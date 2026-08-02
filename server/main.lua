local AllPlants = {}
local PlantCacheById = {}
local PlantConfigBySeed = {}
local FertilizerByName = {}
local PendingPlantings = {}
local WateringLocks = {}
local PlantsLoaded = false

local DEFAULT_HOUSE_RADIUS = 20.0
local DEFAULT_LOCK_RANGE = 2.5
local INTERACTION_DISTANCE = 3.0
local NOTIFY_DURATION = 4000

local function rebuildConfigIndexes()
    PlantConfigBySeed = {}
    for _, plantCfg in ipairs(Plants or {}) do
        if plantCfg.seedName then
            PlantConfigBySeed[plantCfg.seedName] = plantCfg
        end
    end

    FertilizerByName = {}
    for _, fertilizer in ipairs(Config.fertilizerSetup or {}) do
        if fertilizer.fertName then
            FertilizerByName[fertilizer.fertName] = fertilizer
        end
    end
end

rebuildConfigIndexes()

local function getUserCharacter(src)
    local user = Core.getUser(src)
    if not user then
        return nil, nil
    end
    return user, user.getUsedCharacter
end

local function isWatered(value)
    return value == true or value == 1 or value == '1' or tostring(value):lower() == 'true'
end

local function isWaterDeclined(value)
    return tostring(value):lower() == 'no'
end

local function decodeCoords(encoded)
    if type(encoded) == 'table' then
        return encoded
    end
    if type(encoded) ~= 'string' then
        return nil
    end

    local ok, coords = pcall(json.decode, encoded)
    if not ok or type(coords) ~= 'table' then
        return nil
    end
    return coords
end

local function normalizeCoords(candidate)
    if type(candidate) == 'table' and rawget(candidate, 'coords') then
        candidate = rawget(candidate, 'coords')
    end

    local candidateType = type(candidate)
    local x, y, z, heading

    if candidateType == 'vector3' or candidateType == 'vector4' then
        x, y, z = candidate.x, candidate.y, candidate.z
        heading = candidate.w or candidate.h
    elseif candidateType == 'table' then
        x = rawget(candidate, 'x') or candidate[1]
        y = rawget(candidate, 'y') or candidate[2]
        z = rawget(candidate, 'z') or candidate[3]
        heading = rawget(candidate, 'w') or rawget(candidate, 'h') or rawget(candidate, 'heading') or candidate[4]
    end

    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    if not x or not y or not z then
        return nil
    end

    local normalized = { x = x, y = y, z = z, grounded = true }
    if tonumber(heading) then
        normalized.w = tonumber(heading)
    end
    return normalized
end

local function normalizeLock(lock)
    local normalized = lock
    local radius
    local heading

    if type(lock) == 'table' then
        radius = tonumber(rawget(lock, 'radius') or rawget(lock, 'range'))
        heading = tonumber(rawget(lock, 'heading'))
        normalized = rawget(lock, 'coords') or lock
    end

    local coords = normalizeCoords(normalized)
    if not coords then
        return nil, radius, heading
    end
    heading = heading or tonumber(coords.w)
    return vector3(coords.x, coords.y, coords.z), radius, heading
end

local function notify(src, messageKey, notifyType)
    NotifyClient(src, _U(messageKey), notifyType or 'error', NOTIFY_DURATION)
end

local function returnInventoryItem(src, itemName, amount, reason)
    amount = tonumber(amount)
    if not itemName or not amount or amount <= 0 then
        return false
    end
    if not exports.vorp_inventory:canCarryItem(src, itemName, amount) then
        DBG:Warning(('Player %d cannot carry returned item %s (%s)')
            :format(src, tostring(itemName), tostring(reason)))
        return false
    end
    local added = exports.vorp_inventory:addItem(src, itemName, amount)
    if added == false then
        DBG:Warning(('Failed to return %d %s to player %d (%s)')
            :format(amount, tostring(itemName), src, tostring(reason)))
        return false
    end
    return true
end

local function cachePlant(row)
    if not row or not row.plant_id then
        return
    end
    local key = tostring(row.plant_id)
    local existing = PlantCacheById[key]
    if existing then
        for field, value in pairs(row) do
            existing[field] = value
        end
        return
    end
    AllPlants[#AllPlants + 1] = row
    PlantCacheById[key] = row
end

local function removeCachedPlant(plantId)
    local key = tostring(plantId)
    local cached = PlantCacheById[key]
    if not cached then
        return
    end
    PlantCacheById[key] = nil
    for index = #AllPlants, 1, -1 do
        if tostring(AllPlants[index].plant_id) == key then
            table.remove(AllPlants, index)
            break
        end
    end
end

local function rebuildPlantCache(rows)
    AllPlants = {}
    PlantCacheById = {}
    for _, row in ipairs(rows or {}) do
        cachePlant(row)
    end
end

local function getPlantCoords(row)
    if not row then
        return nil
    end
    if row._decodedCoords then
        return row._decodedCoords
    end
    local coords = decodeCoords(row.plant_coords)
    if coords and tonumber(coords.x) and tonumber(coords.y) and tonumber(coords.z) then
        row._decodedCoords = coords
        return coords
    end
    return nil
end

local function isPlayerNearPlant(src, row)
    local ped = GetPlayerPed(src)
    local coords = getPlantCoords(row)
    if not ped or ped == 0 or not coords then
        return false
    end
    local playerCoords = GetEntityCoords(ped)
    return #(playerCoords - vector3(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0)) <= INTERACTION_DISTANCE
end

function GetPlayerHouses(charIdentifier)
    if not charIdentifier then
        DBG:Warning('GetPlayerHouses called without charidentifier')
        return {}
    end

    local rows = MySQL.query.await(
        'SELECT `house_coords`, `house_radius_limit` FROM `bcchousing` WHERE `charidentifier` = ?',
        { charIdentifier }
    )
    local houses = {}
    for _, row in ipairs(rows or {}) do
        local coords = decodeCoords(row.house_coords)
        if coords and tonumber(coords.x) and tonumber(coords.y) and tonumber(coords.z) then
            houses[#houses + 1] = {
                coords = vector3(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0),
                radius = tonumber(row.house_radius_limit) or DEFAULT_HOUSE_RADIUS
            }
        else
            DBG:Warning('Invalid house coordinates for charidentifier ' .. tostring(charIdentifier))
        end
    end
    return houses
end

local function checkPlayerJob(character)
    if not character then
        return false
    end
    for _, job in ipairs((Config.smelling or {}).jobs or {}) do
        if character.job == job then
            return true
        end
    end
    return false
end

local function validatePlantingArea(character, finalCoords, plantCfg)
    local plantingVector = vector3(finalCoords.x, finalCoords.y, finalCoords.z)
    local withinHouse = false

    if Config.plantSetup.requireHouseOwnership then
        local houses = GetPlayerHouses(character.charIdentifier)
        if #houses == 0 then
            return false, 'needHouseOwnership'
        end
        local padding = tonumber(Config.plantSetup.houseRadiusPadding) or 0.0
        for _, house in ipairs(houses) do
            if #(plantingVector - house.coords) <= (house.radius + padding) then
                withinHouse = true
                break
            end
        end
    end

    local lockRequired = plantCfg.lockCoords
        and type(plantCfg.coordsLocks) == 'table'
        and next(plantCfg.coordsLocks) ~= nil
    local withinLock = false

    if lockRequired then
        local baseRadius = tonumber(plantCfg.coordsLockRange) or DEFAULT_LOCK_RANGE
        local tolerance = tonumber(plantCfg.coordsLockTolerance) or 0.0
        for _, lock in ipairs(plantCfg.coordsLocks) do
            local lockCoords, customRadius, heading = normalizeLock(lock)
            if lockCoords and #(plantingVector - lockCoords) <= ((customRadius or baseRadius) + tolerance) then
                withinLock = true
                if heading then
                    finalCoords.w = heading
                end
                break
            end
        end

        if not withinLock and not (Config.plantSetup.requireHouseOwnership and withinHouse) then
            return false, 'mustUseLockedSpot'
        end
    end

    if Config.plantSetup.requireHouseOwnership and not withinHouse and not withinLock then
        return false, 'needHousePlot'
    end
    return true
end

function BeginPlantingProcess(src, plantCfg)
    src = tonumber(src)
    if not src or not plantCfg or not plantCfg.seedName then
        return false
    end
    PendingPlantings[src] = { seedName = plantCfg.seedName }
    return true
end

local function clearPendingPlanting(src)
    PendingPlantings[src] = nil
end

local function refundPendingPlanting(src, reason)
    local pending = PendingPlantings[src]
    if not pending then
        return false
    end
    PendingPlantings[src] = nil

    local plantCfg = PlantConfigBySeed[pending.seedName]
    if not plantCfg then
        DBG:Error('Cannot refund unknown pending seed: ' .. tostring(pending.seedName))
        return false
    end

    returnInventoryItem(src, plantCfg.seedName, plantCfg.seedAmount, reason)
    if plantCfg.soilRequired then
        returnInventoryItem(src, plantCfg.soilName, plantCfg.soilAmount, reason)
    end
    return true
end

local function applyFertilizer(src, fertilizerName, baseGrowthTime)
    local growthTime = math.max(1, tonumber(baseGrowthTime) or 1)
    if not fertilizerName then
        return growthTime, nil, 1.0
    end

    local fertilizer = FertilizerByName[fertilizerName]
    if not fertilizer then
        DBG:Warning('Rejected unknown fertilizer: ' .. tostring(fertilizerName))
        return growthTime, nil, 1.0
    end

    if exports.vorp_inventory:getItemCount(src, nil, fertilizer.fertName) < 1 then
        return growthTime, nil, 1.0
    end
    if exports.vorp_inventory:subItem(src, fertilizer.fertName, 1) == false then
        return growthTime, nil, 1.0
    end

    local reduction = math.min(0.99, math.max(0.0, tonumber(fertilizer.fertTimeReduction) or 0.0))
    local multiplier = math.max(0.0, tonumber(fertilizer.fertYieldMultiplier) or 1.0)
    return math.max(1, math.floor(growthTime * (1.0 - reduction))), fertilizer.fertName, multiplier
end

RegisterNetEvent('bcc-farming:AddPlant', function(clientPlantData, plantCoords, fertilizerName)
    local src = source
    local _, character = getUserCharacter(src)
    if not character then
        DBG:Error('User not found for source: ' .. tostring(src))
        return
    end

    local requestedSeed = clientPlantData and clientPlantData.seedName
    local pending = PendingPlantings[src]
    if not pending or pending.seedName ~= requestedSeed then
        DBG:Warning('Rejected AddPlant without matching pending planting for source: ' .. tostring(src))
        return
    end

    local plantCfg = PlantConfigBySeed[pending.seedName]
    local finalCoords = normalizeCoords(plantCoords)
    if not plantCfg or not finalCoords then
        notify(src, 'mustUseLockedSpot')
        refundPendingPlanting(src, 'invalid planting coordinates')
        return
    end

    local areaValid, messageKey = validatePlantingArea(character, finalCoords, plantCfg)
    if not areaValid then
        notify(src, messageKey)
        refundPendingPlanting(src, 'server planting-area validation failed')
        return
    end

    local plantCount = tonumber(MySQL.scalar.await(
        'SELECT COUNT(*) FROM `bcc_farming` WHERE `plant_owner` = ?',
        { character.charIdentifier }
    ))
    if not plantCount or plantCount >= (tonumber(Config.plantSetup.maxPlants) or 0) then
        notify(src, 'maxPlantsReached')
        refundPendingPlanting(src, 'maximum plants reached')
        return
    end

    local growthTime, appliedFertilizer, yieldMultiplier =
        applyFertilizer(src, fertilizerName, plantCfg.timeToGrow)
    local encodedCoords = json.encode(finalCoords)
    local plantId = MySQL.insert.await(
        'INSERT INTO `bcc_farming` (`plant_coords`, `plant_type`, `plant_watered`, `time_left`, `fertilizer`, `yield_multiplier`, `plant_owner`) VALUES (?, ?, ?, ?, ?, ?, ?)',
        { encodedCoords, plantCfg.seedName, 'false', growthTime, appliedFertilizer, yieldMultiplier,
            character.charIdentifier }
    )

    if not plantId then
        DBG:Error('Failed to insert plant into database')
        if appliedFertilizer then
            returnInventoryItem(src, appliedFertilizer, 1, 'plant insert failed')
        end
        refundPendingPlanting(src, 'plant insert failed')
        return
    end

    clearPendingPlanting(src)
    cachePlant({
        plant_id = plantId,
        plant_coords = encodedCoords,
        plant_type = plantCfg.seedName,
        plant_watered = 'false',
        time_left = growthTime,
        fertilizer = appliedFertilizer,
        yield_multiplier = yieldMultiplier,
        plant_owner = character.charIdentifier,
        _decodedCoords = finalCoords
    })

    local target = Config.plantSetup.lockedToPlanter and src or -1
    TriggerClientEvent('bcc-farming:PlantPlanted', target, plantId, plantCfg, finalCoords, growthTime, false, src)
end)

RegisterNetEvent('bcc-farming:PlantToolUsage', function(clientPlantData)
    local src = source
    local _, character = getUserCharacter(src)
    local pending = PendingPlantings[src]
    if not character or not pending then
        return
    end

    local requestedSeed = clientPlantData and clientPlantData.seedName
    if requestedSeed ~= pending.seedName then
        DBG:Warning('Rejected mismatched tool usage for source: ' .. tostring(src))
        return
    end

    local plantCfg = PlantConfigBySeed[pending.seedName]
    if not plantCfg or not plantCfg.plantingToolRequired then
        return
    end

    local toolUsage = math.max(0, tonumber(plantCfg.plantingToolUsage) or 0)
    local tool = exports.vorp_inventory:getItem(src, plantCfg.plantingTool)
    if not tool then
        DBG:Error('Planting tool not found for source: ' .. tostring(src))
        return
    end

    local metadata = tool.metadata or {}
    local currentDurability = tonumber(metadata.durability) or 100
    local newDurability = math.max(0, currentDurability - toolUsage)
    if newDurability < toolUsage then
        exports.vorp_inventory:subItemById(src, tool.id, nil, nil, 1)
        notify(src, 'needNewTool')
        return
    end

    exports.vorp_inventory:setItemMetadata(src, tool.id, {
        description = _U('UsageLeft') .. newDurability .. '%',
        durability = newDurability
    })
end)

RegisterNetEvent('bcc-farming:NewClientConnected', function(requestId)
    local src = source
    local _, character = getUserCharacter(src)
    if not character or not PlantsLoaded then
        TriggerClientEvent('bcc-farming:PlantSyncComplete', src, requestId, false)
        return
    end

    TriggerClientEvent('bcc-farming:ResetClientPlants', src)
    local ownedCount = 0

    for _, storedPlant in ipairs(AllPlants) do
        local ownsPlant = tostring(storedPlant.plant_owner) == tostring(character.charIdentifier)
        if ownsPlant then
            ownedCount = ownedCount + 1
        end

        if not Config.plantSetup.lockedToPlanter or ownsPlant then
            local plantCfg = PlantConfigBySeed[storedPlant.plant_type]
            local coords = getPlantCoords(storedPlant)
            if plantCfg and coords then
                TriggerClientEvent('bcc-farming:PlantPlanted', src, storedPlant.plant_id, plantCfg, coords,
                    storedPlant.time_left, storedPlant.plant_watered, ownsPlant and src or 0)
            end
        end
    end

    if ownedCount > 0 then
        TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, ownedCount)
    end
    TriggerClientEvent('bcc-farming:PlantSyncComplete', src, requestId, true)
end)

Core.Callback.Register('bcc-farming:GetPlantStatus', function(source, cb, plantId)
    plantId = tonumber(plantId)
    if not plantId then
        return cb(false)
    end

    local rows = MySQL.query.await(
        'SELECT `time_left`, `plant_watered` FROM `bcc_farming` WHERE `plant_id` = ? LIMIT 1',
        { plantId }
    )
    local plant = rows and rows[1]
    if not plant then
        return cb(false)
    end

    local watered = isWatered(plant.plant_watered)
    local waterDeclined = isWaterDeclined(plant.plant_watered)
    local hasWaterBucket = false
    if not watered and not waterDeclined and (tonumber(plant.time_left) or 0) > 0 then
        local exportOk, exportResult = pcall(function()
            return exports['bcc-water']:HasContainer(source, 'bucket')
        end)
        if exportOk then
            hasWaterBucket = exportResult == true
        else
            DBG:Warning('Unable to check bcc-water bucket availability: ' .. tostring(exportResult))
        end
    end

    cb({
        timeLeft = tonumber(plant.time_left) or 0,
        watered = watered,
        waterDeclined = waterDeclined,
        hasWaterBucket = hasWaterBucket
    })
end)

local function markPlantWatered(plantId)
    local affected = MySQL.update.await(
        'UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ? AND `plant_watered` NOT IN (?, ?)',
        { 'true', plantId, 'true', 'no' }
    )
    if affected and tonumber(affected) and tonumber(affected) > 0 then
        local cached = PlantCacheById[tostring(plantId)]
        if cached then
            cached.plant_watered = 'true'
        end
        TriggerClientEvent('bcc-farming:UpdateClientPlantWateredStatus', -1, plantId)
        return true
    end
    return false
end

Core.Callback.Register('bcc-farming:ManagePlantWateredStatus', function(source, cb, plantId)
    local src = source
    plantId = tonumber(plantId)
    if not plantId then
        return cb(false)
    end
    local _, character = getUserCharacter(src)
    local cached = PlantCacheById[tostring(plantId)]
    if not character or not cached or isWatered(cached.plant_watered)
        or isWaterDeclined(cached.plant_watered) or not isPlayerNearPlant(src, cached) then
        return cb(false)
    end
    if WateringLocks[plantId] then
        return cb(false)
    end

    WateringLocks[plantId] = true
    local consumed = exports['bcc-water']:ConsumeContainer(src, 'bucket')
    local watered = consumed and markPlantWatered(plantId) or false
    WateringLocks[plantId] = nil
    cb(watered)
end)

Core.Callback.Register('bcc-farming:DeclinePlantWatering', function(source, cb, plantId)
    local src = source
    plantId = tonumber(plantId)
    if not plantId then
        return cb(false)
    end

    local _, character = getUserCharacter(src)
    local cached = PlantCacheById[tostring(plantId)]
    if not character or not cached or isWatered(cached.plant_watered)
        or isWaterDeclined(cached.plant_watered) or WateringLocks[plantId]
        or (tonumber(cached.time_left) or 0) <= 0 or not isPlayerNearPlant(src, cached) then
        return cb(false)
    end

    WateringLocks[plantId] = true
    local affected = MySQL.update.await(
        'UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ? AND `plant_watered` NOT IN (?, ?) AND `time_left` > 0',
        { 'no', plantId, 'true', 'no' }
    )

    if not affected or tonumber(affected) < 1 then
        WateringLocks[plantId] = nil
        return cb(false)
    end

    cached.plant_watered = 'no'
    TriggerClientEvent('bcc-farming:UpdateClientPlantWaterDeclinedStatus', -1, plantId)
    WateringLocks[plantId] = nil
    cb(true)
end)

RegisterNetEvent('bcc-farming:UpdatePlantWateredStatus', function(plantId)
    local src = source
    plantId = tonumber(plantId)
    if not plantId then
        return
    end
    local _, character = getUserCharacter(src)
    local cached = PlantCacheById[tostring(plantId)]
    if not character or not cached or isWatered(cached.plant_watered) or isWaterDeclined(cached.plant_watered)
        or WateringLocks[plantId] or not isPlayerNearPlant(src, cached) then
        return
    end
    WateringLocks[plantId] = true
    markPlantWatered(plantId)
    WateringLocks[plantId] = nil
end)

local function calculateHarvestItems(storedPlant, plantCfg)
    local careConfig = Config.cropCare or {}
    local watered = isWatered(storedPlant.plant_watered)
    local fertilizerMultiplier = tonumber(storedPlant.yield_multiplier) or 1.0
    local waterMultiplier = watered
        and (tonumber(careConfig.wateredYieldMultiplier) or 1.0)
        or (tonumber(careConfig.dryYieldMultiplier) or 0.5)
    local finalMultiplier = math.max(0.0, fertilizerMultiplier * waterMultiplier)
    local waterBonus = watered and math.max(0, math.floor(tonumber(careConfig.wateredYieldBonus) or 0)) or 0
    local minimumYield = math.max(0, math.floor(tonumber(careConfig.minimumYield) or 1))
    local items = {}

    for _, reward in ipairs(plantCfg.rewards or {}) do
        local baseAmount = tonumber(reward.amount)
        if not reward.itemName or not reward.itemLabel or not baseAmount then
            return nil
        end
        items[#items + 1] = {
            itemName = reward.itemName,
            itemLabel = reward.itemLabel,
            amount = math.max(minimumYield, math.floor((baseAmount * finalMultiplier) + 0.5) + waterBonus)
        }
    end
    return items
end

Core.Callback.Register('bcc-farming:HarvestCheck', function(source, cb, plantId, destroy)
    local src = source
    plantId = tonumber(plantId)
    local _, character = getUserCharacter(src)
    if not character or not plantId then
        return cb(false)
    end

    local rows = MySQL.query.await('SELECT * FROM `bcc_farming` WHERE `plant_id` = ? LIMIT 1', { plantId })
    local storedPlant = rows and rows[1]
    local plantCfg = storedPlant and PlantConfigBySeed[storedPlant.plant_type]
    if not storedPlant or not plantCfg or not isPlayerNearPlant(src, storedPlant) then
        return cb(false)
    end
    if Config.plantSetup.lockedToPlanter
        and tostring(storedPlant.plant_owner) ~= tostring(character.charIdentifier) then
        return cb(false)
    end

    ---@type table|nil
    local itemsToAdd
    if not destroy then
        if (tonumber(storedPlant.time_left) or 1) > 0 then
            return cb(false)
        end
        itemsToAdd = calculateHarvestItems(storedPlant, plantCfg)
        if not itemsToAdd then
            DBG:Error('Invalid reward configuration for plant: ' .. tostring(storedPlant.plant_type))
            return cb(false)
        end
        for _, item in ipairs(itemsToAdd) do
            if not exports.vorp_inventory:canCarryItem(src, item.itemName, item.amount) then
                NotifyClient(src, _U('noCarry') .. item.itemName, 'error', NOTIFY_DURATION)
                return cb(false)
            end
        end
    else
        itemsToAdd = {}
    end

    local affected = MySQL.update.await('DELETE FROM `bcc_farming` WHERE `plant_id` = ?', { plantId })
    if not affected or tonumber(affected) < 1 then
        return cb(false)
    end
    removeCachedPlant(plantId)

    for _, item in ipairs(itemsToAdd) do
        if exports.vorp_inventory:addItem(src, item.itemName, item.amount) ~= false then
            NotifyClient(src, _U('harvested') .. item.amount .. ' ' .. item.itemLabel, 'success', NOTIFY_DURATION)
        else
            DBG:Warning(('Failed to grant %s after claiming plant %d for source %d')
                :format(tostring(item.itemName), plantId, src))
        end
    end

    if tostring(storedPlant.plant_owner) == tostring(character.charIdentifier) then
        TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, -1)
    end
    TriggerClientEvent('bcc-farming:RemovePlantClient', -1, plantId)
    cb(true)
end)

RegisterNetEvent('bcc-farming:ReturnItems', function()
    local src = source
    local user = Core.getUser(src)
    if not user then
        return
    end
    if not refundPendingPlanting(src, 'planting cancelled') then
        DBG:Warning('Ignored ReturnItems without pending planting for source: ' .. tostring(src))
    end
end)

AddEventHandler('playerDropped', function()
    PendingPlantings[source] = nil
end)

CreateThread(function()
    while true do
        local rows = MySQL.query.await('SELECT * FROM `bcc_farming`')
        if rows then
            rebuildPlantCache(rows)
            PlantsLoaded = true
            break
        end
        DBG:Warning('Failed to load plants; retrying in five seconds')
        Wait(5000)
    end

    local dryGrowthRate = math.max(0.0, tonumber((Config.cropCare or {}).dryGrowthRate) or 0.5)
    while true do
        Wait(1000)
        local updated = MySQL.update.await(
            'UPDATE `bcc_farming` SET `time_left` = GREATEST(0, `time_left` - IF(`plant_watered` = ?, 1, ?)) WHERE `time_left` > 0',
            { 'true', dryGrowthRate }
        )
        if updated == nil then
            DBG:Warning('Failed to update plant growth timers')
        else
            for _, plant in ipairs(AllPlants) do
                local timeLeft = tonumber(plant.time_left)
                if timeLeft and timeLeft > 0 then
                    local rate = isWatered(plant.plant_watered) and 1.0 or dryGrowthRate
                    plant.time_left = math.max(0, timeLeft - rate)
                end
            end
        end
    end
end)

Core.Callback.Register('bcc-farming:DetectSmellingPlants', function(source, cb)
    local src = source
    local _, character = getUserCharacter(src)
    local playerPed = GetPlayerPed(src)
    if not character or not checkPlayerJob(character) or not playerPed or playerPed == 0 or not PlantsLoaded then
        return cb(false)
    end

    local playerCoords = GetEntityCoords(playerPed)
    local smellDistance = tonumber((Config.smelling or {}).distance) or 0.0
    local smellingPlants = {}
    for _, storedPlant in ipairs(AllPlants) do
        local plantCfg = PlantConfigBySeed[storedPlant.plant_type]
        local coords = plantCfg and plantCfg.smelling and getPlantCoords(storedPlant)
        if coords and #(vector3(coords.x, coords.y, coords.z) - playerCoords) <= smellDistance then
            smellingPlants[#smellingPlants + 1] = { coords = coords, plantName = plantCfg.plantName }
        end
    end

    cb(#smellingPlants > 0 and smellingPlants or false)
end)

BccUtils.Versioner.checkFile(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-farming')

exports('GetPlayerHouses', GetPlayerHouses)
