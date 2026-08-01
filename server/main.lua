local AllPlants = {} -- AllPlants will contain all the plants in the server
local PlantsLoaded = false
local DEFAULT_LOCK_RANGE = 2.5

function GetPlayerHouses(charIdentifier)
    if not charIdentifier then
        DBG:Warning('GetPlayerHouses called without charidentifier')
        return {}
    end

    local houses = {}
    local rows = MySQL.query.await('SELECT house_coords, house_radius_limit FROM `bcchousing` WHERE `charidentifier` = ?', { charIdentifier })

    if not rows or #rows == 0 then
        return houses
    end

    for _, row in ipairs(rows) do
        if row.house_coords then
            local ok, coords = pcall(json.decode, row.house_coords)
            if ok and type(coords) == 'table' and coords.x and coords.y and coords.z then
                local radius = tonumber(row.house_radius_limit) or 20.0
                table.insert(houses, {
                    coords = vector3(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0),
                    radius = radius
                })
            else
                DBG:Warning('Invalid house coordinates for charidentifier ' .. tostring(charIdentifier))
            end
        end
    end

    return houses
end

local function CheckPlayerJob(src)
    local character = Core.getUser(src).getUsedCharacter
    for _, job in ipairs(Config.smelling.jobs) do
        if character.job == job then
            return true
        end
    end
    return false
end

--- @param plantData table
--- @param plantCoords vector3|vector4|table
--- @param fertilizerName string|nil
RegisterNetEvent('bcc-farming:AddPlant', function(plantData, plantCoords, fertilizerName)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return
    end

    local character = user.getUsedCharacter
    local playerHouses = nil

    -- Validate plant data and coordinates
    if not plantData or not plantCoords then
        DBG:Error('Invalid plant data or coordinates from source: ' .. tostring(src))
        return
    end
    if not plantData.seedName or not plantData.timeToGrow then
        DBG:Error('Incomplete plant data from source: ' .. tostring(src))
        return
    end

    -- Never trust client-supplied plant settings. Resolve the configured plant by seed name.
    local configuredPlant = nil
    for _, plantCfg in pairs(Plants) do
        if plantCfg.seedName == plantData.seedName then
            configuredPlant = plantCfg
            break
        end
    end
    if not configuredPlant then
        DBG:Error('Unknown plant type from source: ' .. tostring(src))
        return
    end
    plantData = configuredPlant

    local finalCoords
    local coordsCandidate = plantCoords
    if type(coordsCandidate) == 'table' and coordsCandidate.coords then
        coordsCandidate = coordsCandidate.coords
    end

    local px, py, pz, heading = nil, nil, nil, nil
    if type(coordsCandidate) == 'vector3' then
        px = coordsCandidate.x + 0.0
        py = coordsCandidate.y + 0.0
        pz = coordsCandidate.z + 0.0
    elseif type(coordsCandidate) == 'vector4' then
        px = coordsCandidate.x + 0.0
        py = coordsCandidate.y + 0.0
        pz = coordsCandidate.z + 0.0
        heading = coordsCandidate.w + 0.0
    elseif type(coordsCandidate) == 'table' then
        if coordsCandidate.x and coordsCandidate.y and coordsCandidate.z then
            px = coordsCandidate.x + 0.0
            py = coordsCandidate.y + 0.0
            pz = coordsCandidate.z + 0.0
            if coordsCandidate.w or coordsCandidate.h or coordsCandidate.heading then
                heading = (coordsCandidate.w or coordsCandidate.h or coordsCandidate.heading) + 0.0
            end
        elseif coordsCandidate[1] and coordsCandidate[2] and coordsCandidate[3] then
            px = coordsCandidate[1] + 0.0
            py = coordsCandidate[2] + 0.0
            pz = coordsCandidate[3] + 0.0
            if coordsCandidate[4] then
                heading = coordsCandidate[4] + 0.0
            end
        end
    end

    if px and py and pz then
        finalCoords = { x = px, y = py, z = pz }
        if heading then
            finalCoords.w = heading
        end
    else
        DBG:Error('Unable to normalize plant coordinates for source: ' .. tostring(src))
        NotifyClient(src, _U('mustUseLockedSpot'), "error", 4000)
        if plantData.seedName and plantData.seedAmount and plantData.seedAmount > 0 then
            if exports.vorp_inventory:canCarryItem(src, plantData.seedName, plantData.seedAmount) then
                exports.vorp_inventory:addItem(src, plantData.seedName, plantData.seedAmount)
            else
                DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned seeds: ' .. tostring(plantData.seedName))
            end
        end
        if plantData.soilRequired and plantData.soilName and plantData.soilAmount and plantData.soilAmount > 0 then
            if exports.vorp_inventory:canCarryItem(src, plantData.soilName, plantData.soilAmount) then
                exports.vorp_inventory:addItem(src, plantData.soilName, plantData.soilAmount)
            else
                DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned soil: ' .. tostring(plantData.soilName))
            end
        end
        return
    end

    local withinHouseRadius = false

    if Config.plantSetup.requireHouseOwnership then
        playerHouses = GetPlayerHouses(character.charIdentifier)
        if not playerHouses or #playerHouses == 0 then
            NotifyClient(src, _U('needHouseOwnership'), "error", 4000)
            if plantData.seedName and plantData.seedAmount and plantData.seedAmount > 0 then
                if exports.vorp_inventory:canCarryItem(src, plantData.seedName, plantData.seedAmount) then
                    exports.vorp_inventory:addItem(src, plantData.seedName, plantData.seedAmount)
                else
                    DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned seeds: ' .. tostring(plantData.seedName))
                end
            end
            if plantData.soilRequired and plantData.soilName and plantData.soilAmount and plantData.soilAmount > 0 then
                if exports.vorp_inventory:canCarryItem(src, plantData.soilName, plantData.soilAmount) then
                    exports.vorp_inventory:addItem(src, plantData.soilName, plantData.soilAmount)
                else
                    DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned soil: ' .. tostring(plantData.soilName))
                end
            end
            return
        end

        local padding = Config.plantSetup.houseRadiusPadding or 0.0
        local plantingVector = vector3(finalCoords.x, finalCoords.y, finalCoords.z)
        for _, house in ipairs(playerHouses) do
            if house.coords and #(plantingVector - house.coords) <= ((house.radius or 0.0) + padding) then
                withinHouseRadius = true
                break
            end
        end

    end

    local lockRequired = plantData.lockCoords and type(plantData.coordsLocks) == 'table' and next(plantData.coordsLocks)
    local withinLock = false

    if lockRequired then
        local plantingVector = vector3(finalCoords.x, finalCoords.y, finalCoords.z)
        local baseRadius = plantData.coordsLockRange or DEFAULT_LOCK_RANGE
        local radiusPadding = plantData.coordsLockTolerance or 0.0
        for _, lock in ipairs(plantData.coordsLocks) do
            local normalized = lock
            local lradius
            local lheading
            if type(lock) == 'table' then
                if lock.radius or lock.range then
                    lradius = lock.radius or lock.range
                end
                if lock.heading then
                    lheading = lock.heading + 0.0
                end
                if lock.coords then
                    normalized = lock.coords
                end
            end

            local lx, ly, lz, lh
            if type(normalized) == 'vector3' or type(normalized) == 'vector4' then
                lx = normalized.x + 0.0
                ly = normalized.y + 0.0
                lz = normalized.z + 0.0
                if normalized.w or normalized.h then
                    lh = (normalized.w or normalized.h) + 0.0
                end
            elseif type(normalized) == 'table' then
                if normalized.x and normalized.y and normalized.z then
                    lx = normalized.x + 0.0
                    ly = normalized.y + 0.0
                    lz = normalized.z + 0.0
                    if normalized.w or normalized.h or normalized.heading then
                        lh = (normalized.w or normalized.h or normalized.heading) + 0.0
                    end
                elseif normalized[1] and normalized[2] and normalized[3] then
                    lx = normalized[1] + 0.0
                    ly = normalized[2] + 0.0
                    lz = normalized[3] + 0.0
                    if normalized[4] then
                        lh = normalized[4] + 0.0
                    end
                end
            end

            if lx and ly and lz then
                local allowedRadius = (lradius or baseRadius) + radiusPadding
                if #(plantingVector - vector3(lx, ly, lz)) <= allowedRadius then
                    withinLock = true
                    if lheading or lh then
                        finalCoords.w = lheading or lh
                    end
                    break
                end
            end
        end

        if not withinLock and not (Config.plantSetup.requireHouseOwnership and withinHouseRadius) then
            DBG:Error('Player ' .. tostring(src) .. ' attempted to plant outside of locked coordinates.')
            NotifyClient(src, _U('mustUseLockedSpot'), "error", 4000)
            if plantData.seedName and plantData.seedAmount and plantData.seedAmount > 0 then
                if exports.vorp_inventory:canCarryItem(src, plantData.seedName, plantData.seedAmount) then
                    exports.vorp_inventory:addItem(src, plantData.seedName, plantData.seedAmount)
                else
                    DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned seeds: ' .. tostring(plantData.seedName))
                end
            end
            if plantData.soilRequired and plantData.soilName and plantData.soilAmount and plantData.soilAmount > 0 then
                if exports.vorp_inventory:canCarryItem(src, plantData.soilName, plantData.soilAmount) then
                    exports.vorp_inventory:addItem(src, plantData.soilName, plantData.soilAmount)
                else
                    DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned soil: ' .. tostring(plantData.soilName))
                end
            end
            return
        end
    end

    if Config.plantSetup.requireHouseOwnership and not withinHouseRadius and not withinLock then
        NotifyClient(src, _U('needHousePlot'), "error", 4000)
        if plantData.seedName and plantData.seedAmount and plantData.seedAmount > 0 then
            if exports.vorp_inventory:canCarryItem(src, plantData.seedName, plantData.seedAmount) then
                exports.vorp_inventory:addItem(src, plantData.seedName, plantData.seedAmount)
            else
                DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned seeds: ' .. tostring(plantData.seedName))
            end
        end
        if plantData.soilRequired and plantData.soilName and plantData.soilAmount and plantData.soilAmount > 0 then
            if exports.vorp_inventory:canCarryItem(src, plantData.soilName, plantData.soilAmount) then
                exports.vorp_inventory:addItem(src, plantData.soilName, plantData.soilAmount)
            else
                DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned soil: ' .. tostring(plantData.soilName))
            end
        end
        return
    end

    local growthTime = plantData.timeToGrow
    local yieldMultiplier = 1.0
    local appliedFertilizer = nil

    if fertilizerName then
        for _, fertilizer in pairs(Config.fertilizerSetup) do
            if fertilizer.fertName == fertilizerName then
                local fertilizerCount = exports.vorp_inventory:getItemCount(src, nil, fertilizer.fertName)
                if fertilizerCount > 0 then
                    local removed = exports.vorp_inventory:subItem(src, fertilizer.fertName, 1)
                    if removed ~= false then
                        appliedFertilizer = fertilizer.fertName
                        growthTime = math.max(1, math.floor(growthTime * (1.0 - (fertilizer.fertTimeReduction or 0))))
                        yieldMultiplier = math.max(0, tonumber(fertilizer.fertYieldMultiplier) or 1.0)
                    end
                end
                break
            end
        end
    end

    -- Insert plant into database with its server-validated care modifiers.
    local plantId = MySQL.insert.await('INSERT INTO `bcc_farming` (plant_coords, plant_type, plant_watered, time_left, fertilizer, yield_multiplier, plant_owner) VALUES (?, ?, ?, ?, ?, ?, ?)',
    { json.encode(finalCoords), plantData.seedName, 'false', growthTime, appliedFertilizer, yieldMultiplier, character.charIdentifier })

    if not plantId then
        DBG:Error('Failed to insert plant into database.')
        if appliedFertilizer and exports.vorp_inventory:canCarryItem(src, appliedFertilizer, 1) then
            exports.vorp_inventory:addItem(src, appliedFertilizer, 1)
        end
        if plantData.seedName and plantData.seedAmount and plantData.seedAmount > 0 then
            if exports.vorp_inventory:canCarryItem(src, plantData.seedName, plantData.seedAmount) then
                exports.vorp_inventory:addItem(src, plantData.seedName, plantData.seedAmount)
            else
                DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned seeds: ' .. tostring(plantData.seedName))
            end
        end
        if plantData.soilRequired and plantData.soilName and plantData.soilAmount and plantData.soilAmount > 0 then
            if exports.vorp_inventory:canCarryItem(src, plantData.soilName, plantData.soilAmount) then
                exports.vorp_inventory:addItem(src, plantData.soilName, plantData.soilAmount)
            else
                DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned soil: ' .. tostring(plantData.soilName))
            end
        end
        return
    end

    table.insert(AllPlants, {
        plant_id = plantId,
        plant_coords = json.encode(finalCoords),
        plant_type = plantData.seedName,
        plant_watered = 'false',
        time_left = growthTime,
        fertilizer = appliedFertilizer,
        yield_multiplier = yieldMultiplier,
        plant_owner = character.charIdentifier
    })

    -- Trigger client event
    local target = Config.plantSetup.lockedToPlanter and src or -1
    TriggerClientEvent('bcc-farming:PlantPlanted', target, plantId, plantData, finalCoords, growthTime, false, src)
end)

--- @param plantData table
RegisterNetEvent('bcc-farming:PlantToolUsage',function (plantData)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return
    end

    local toolItem = plantData.plantingTool
    local toolUsage = plantData.plantingToolUsage

    -- Check if the tool exists in the player's inventory
    local tool = exports.vorp_inventory:getItem(src, toolItem)
    if not tool then
        DBG:Error('Tool not found in inventory for source: ' .. tostring(src))
        return
    end

    local toolMeta = tool.metadata or {}

    -- If tool has no durability metadata, initialize it
    if not toolMeta.durability then
        exports.vorp_inventory:setItemMetadata(src, tool.id, {
            description = _U('UsageLeft') .. 100 - toolUsage .. '%',
            durability = 100 - toolUsage
        })
        DBG:Info('Initialized durability for tool: ' .. toolItem .. ', durability: ' .. tostring(100 - toolUsage))
    else
        -- Subtract durability
        local durabilityValue = toolMeta.durability - toolUsage

        -- Update the tool's metadata
        if durabilityValue >= toolUsage then
            exports.vorp_inventory:setItemMetadata(src, tool.id, {
                description = _U('UsageLeft') .. durabilityValue .. '%',
                durability = durabilityValue
            })
            DBG:Info('Updated tool durability for source: ' .. tostring(src) .. ', tool: ' .. toolItem .. ', durability: ' .. durabilityValue)
        else
            -- Remove the tool if durability is exhausted
            exports.vorp_inventory:subItemById(src, tool.id, nil, nil, 1)
            NotifyClient(src, _U('needNewTool'), "error", 4000)
            DBG:Info('Removed broken tool for source: ' .. tostring(src) .. ', tool: ' .. toolItem)
        end
    end
end)

RegisterNetEvent('bcc-farming:NewClientConnected', function(requestId)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        TriggerClientEvent('bcc-farming:PlantSyncComplete', src, requestId, false)
        return
    end

    local character = user.getUsedCharacter
    local charid = character.charIdentifier

    if not PlantsLoaded then
        DBG:Info('Plant cache is not ready for source: ' .. tostring(src))
        TriggerClientEvent('bcc-farming:PlantSyncComplete', src, requestId, false)
        return
    end

    if type(Plants) ~= 'table' then
        DBG:Error('Plants configuration table is missing or invalid')
        TriggerClientEvent('bcc-farming:PlantSyncComplete', src, requestId, false)
        return
    end

    TriggerClientEvent('bcc-farming:ResetClientPlants', src)

    -- Loop through all plants on the server
    for _, currentPlants in pairs(AllPlants) do
        local ownsPlant = tostring(currentPlants.plant_owner) == tostring(charid)

        if Config.plantSetup.lockedToPlanter and not ownsPlant then
            goto END
        end

        -- If player owns plant add to their max plants count
        if ownsPlant then
            TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, 1)
        end

        -- Get plant configuration and send to client
        for _, plantCfg in pairs(Plants) do
            if currentPlants.plant_type == plantCfg.seedName then
                local plantCoords = json.decode(currentPlants.plant_coords)
                local planterSource = ownsPlant and src or 0
                TriggerClientEvent('bcc-farming:PlantPlanted', src, currentPlants.plant_id, plantCfg, plantCoords, currentPlants.time_left, currentPlants.plant_watered, planterSource)
                break
            end
        end
        ::END::
    end

    TriggerClientEvent('bcc-farming:PlantSyncComplete', src, requestId, true)
end)

--- @param plantId number
Core.Callback.Register('bcc-farming:ManagePlantWateredStatus', function(source, cb, plantId)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return cb(false)
    end

    -- Check if plantId is valid
    if not plantId then
        DBG:Error('Invalid plantId from source: ' .. tostring(src))
        return cb(false)
    end

    if not exports['bcc-water']:ConsumeContainer(src, 'bucket') then
        DBG:Info('No usable water bucket found for source: ' .. tostring(src))
        return cb(false)
    end

    local successUpdate = MySQL.update.await(
        'UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?',
        { 'true', plantId }
    )
    if not successUpdate then
        DBG:Error('Failed to update plant watered status for plantId: ' .. tostring(plantId))
        return cb(false)
    end

    TriggerClientEvent('bcc-farming:UpdateClientPlantWateredStatus', -1, plantId)
    cb(true)
end)

--- @param plantId number
RegisterNetEvent('bcc-farming:UpdatePlantWateredStatus', function(plantId)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return
    end

    -- Check if plantId is valid
    if not plantId then
        DBG:Error('Invalid plantId from source: ' .. tostring(src))
        return
    end

    -- Update plant watered status in database
    local result = MySQL.update.await('UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?', { 'true', plantId })

    if not result then
        DBG:Error('Failed to update plant watered status in database for plantId: ' .. tostring(plantId))
        return
    end

    DBG:Success('Successfully updated watered status for plant ID: ' .. tostring(plantId))
    TriggerClientEvent('bcc-farming:UpdateClientPlantWateredStatus', -1, plantId)
end)

--- @param plantId number
--- @param destroy boolean
Core.Callback.Register('bcc-farming:HarvestCheck', function(source, cb, plantId, destroy)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return cb(false)
    end

    if not plantId then
        DBG:Error('Invalid plant ID for source: ' .. tostring(src))
        return cb(false)
    end

    local rows = MySQL.query.await('SELECT * FROM `bcc_farming` WHERE `plant_id` = ? LIMIT 1', { plantId })
    local storedPlant = rows and rows[1]
    if not storedPlant then
        DBG:Warning('Plant not found for harvest: ' .. tostring(plantId))
        return cb(false)
    end

    local configuredPlant = nil
    for _, plantCfg in pairs(Plants) do
        if plantCfg.seedName == storedPlant.plant_type then
            configuredPlant = plantCfg
            break
        end
    end
    if not configuredPlant then
        DBG:Error('Missing configuration for plant type: ' .. tostring(storedPlant.plant_type))
        return cb(false)
    end

    local itemsToAdd = {}
    if not destroy then
        if (tonumber(storedPlant.time_left) or 1) > 0 then
            DBG:Warning('Player attempted to harvest an immature plant: ' .. tostring(plantId))
            return cb(false)
        end

        local careConfig = Config.cropCare or {}
        local fertilizerMultiplier = tonumber(storedPlant.yield_multiplier) or 1.0
        local waterMultiplier = tostring(storedPlant.plant_watered) == 'true'
            and (tonumber(careConfig.wateredYieldMultiplier) or 1.0)
            or (tonumber(careConfig.dryYieldMultiplier) or 0.5)
        local finalMultiplier = math.max(0, fertilizerMultiplier * waterMultiplier)
        local waterBonus = tostring(storedPlant.plant_watered) == 'true'
            and math.max(0, math.floor(tonumber(careConfig.wateredYieldBonus) or 0))
            or 0
        local minimumYield = math.max(0, math.floor(tonumber(careConfig.minimumYield) or 1))

        -- Rewards are calculated exclusively from server configuration and saved crop care.
        for _, reward in pairs(configuredPlant.rewards or {}) do
            local itemName = reward.itemName
            local itemLabel = reward.itemLabel
            local baseAmount = tonumber(reward.amount)

            if not itemName or not itemLabel or not baseAmount then
                DBG:Error('Invalid reward data for plant ID: ' .. tostring(plantId))
                return cb(false)
            end

            local amount = math.max(minimumYield, math.floor((baseAmount * finalMultiplier) + 0.5) + waterBonus)

            local canCarry = exports.vorp_inventory:canCarryItem(src, itemName, amount)
            if not canCarry then
                NotifyClient(src, _U('noCarry') .. itemName, "error", 4000)
                DBG:Error('Player ' .. tostring(src) .. ' cannot carry item: ' .. itemName)
                return cb(false)
            end

            table.insert(itemsToAdd, { itemName = itemName, itemLabel = itemLabel, amount = amount })
        end
    end

    -- Claim the plant before granting rewards to prevent duplicate harvests.
    local affectedRows = MySQL.update.await('DELETE FROM `bcc_farming` WHERE `plant_id` = ?', { plantId })
    if not affectedRows or affectedRows < 1 then
        DBG:Error('Failed to delete plant with ID: ' .. tostring(plantId) .. ' from database')
        return cb(false)
    end

    for _, item in ipairs(itemsToAdd) do
        local success = exports.vorp_inventory:addItem(src, item.itemName, item.amount)
        if not success then
            DBG:Warning('Failed to add item to inventory for source: ' .. tostring(src) .. ', item: ' .. item.itemName)
        else
            NotifyClient(src, _U('harvested') .. item.amount .. ' ' .. item.itemLabel, "success", 4000)
            DBG:Success('Successfully added item to inventory for source: ' .. tostring(src) .. ', item: ' .. item.itemName)
        end
    end

    DBG:Success('Successfully deleted plant with ID: ' .. tostring(plantId) .. ' from database')

    TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, -1)
    TriggerClientEvent('bcc-farming:RemovePlantClient', -1, plantId)

    cb(true)
end)

--- @param seedName string
--- @param seedAmount number
--- @param soilRequired boolean
--- @param soilName string
--- @param soilAmount number
RegisterNetEvent('bcc-farming:ReturnItems', function(seedName, seedAmount, soilRequired, soilName, soilAmount)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return
    end

    -- Return Seeds
    if seedName and seedAmount and seedAmount > 0 then
        DBG:Info('Returning ' .. tostring(seedAmount) .. ' of ' .. seedName .. ' to player ' .. tostring(src))
        local canCarrySeed = exports.vorp_inventory:canCarryItem(src, seedName, seedAmount)
        if canCarrySeed then
            local success = exports.vorp_inventory:addItem(src, seedName, seedAmount)
            if success then
                DBG:Success('Successfully returned ' ..
                tostring(seedAmount) .. ' of ' .. seedName .. ' to player ' .. tostring(src))
            else
                DBG:Warning('Failed to return ' ..
                tostring(seedAmount) .. ' of ' .. seedName .. ' to player ' .. tostring(src))
            end
        else
            DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned seeds: ' .. seedName)
        end
    else
        DBG:Info('No seeds to return or invalid seed data for player ' .. tostring(src))
    end

    -- Return Soil if Required
    if soilRequired and soilName and soilAmount and soilAmount > 0 then
        local canCarrySoil = exports.vorp_inventory:canCarryItem(src, soilName, soilAmount)
        if canCarrySoil then
            local success = exports.vorp_inventory:addItem(src, soilName, soilAmount)
            if success then
                DBG:Success('Successfully returned ' ..
                tostring(soilAmount) .. ' of ' .. soilName .. ' to player ' .. tostring(src))
            else
                DBG:Warning('Failed to return ' ..
                tostring(soilAmount) .. ' of ' .. soilName .. ' to player ' .. tostring(src))
            end
        else
            DBG:Warning('Player ' .. tostring(src) .. ' could not carry returned soil: ' .. soilName)
        end
    else
        DBG:Info('No soil to return or invalid soil data for player ' .. tostring(src))
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        local timeLeft

        -- Fetch all plants from the database
        local allPlants = MySQL.query.await('SELECT * FROM `bcc_farming`')
        if not allPlants then
            DBG:Warning('Failed to fetch plants from database. Will try again.')
            Wait(5000)
            goto continueThread
        end

        -- Update global AllPlants table
        AllPlants = allPlants
        PlantsLoaded = true
        --DBG:Info('Fetched ' .. tostring(#allPlants) .. ' plants from database.')

        -- Process each plant
        if #allPlants > 0 then
            for _, plant in pairs(allPlants) do
                -- Validate plant data
                if not plant or not plant.plant_id or not plant.time_left or not plant.plant_watered then
                    DBG:Warning('Invalid plant data detected')
                    goto continuePlant
                end

                timeLeft = tonumber(plant.time_left)

                -- Dry plants continue growing slowly and produce a smaller harvest.
                if timeLeft > 0 then
                    local growthRate = plant.plant_watered == 'true'
                        and 1.0
                        or (tonumber((Config.cropCare or {}).dryGrowthRate) or 0.5)
                    local newTime = math.max(0, timeLeft - math.max(0, growthRate))
                    --DBG:Info('Updating plant ID: ' .. tostring(plant.plant_id) .. ', time left: ' .. tostring(newTime))

                    -- Update plant time in database
                    local success = MySQL.update.await('UPDATE `bcc_farming` SET `time_left` = ? WHERE `plant_id` = ?',
                        { newTime, plant.plant_id })

                    if not success then
                        DBG:Warning('Failed to update time for plant ID: ' .. tostring(plant.plant_id))
                    end
                end
                ::continuePlant::
            end
        end
        ::continueThread::
    end
end)

--- @param playerCoords vector3
Core.Callback.Register('bcc-farming:DetectSmellingPlants', function(source, cb, playerCoords)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return cb(false)
    end

    local hasJob = CheckPlayerJob(src)
    if not hasJob then
        --DBG:Warning('Player ' .. tostring(src) .. ' does not have the required job for smelling plants.')
        return cb(false)
    end

    -- Validate player coordinates
    if not playerCoords then
        DBG:Error('Invalid player coordinates for source: ' .. tostring(src))
        return cb(false)
    end

    -- Validate AllPlants and Plants tables
    if not AllPlants or not Plants then
        DBG:Error('AllPlants or Plants table is not defined')
        return cb(false)
    end

    local smellingPlants = {}

    -- Iterate through all plants
    for _, allPlant in pairs(AllPlants) do
        local distance
        -- Validate plant data
        if not allPlant or not allPlant.plant_type or not allPlant.plant_coords then
            DBG:Warning('Invalid plant data detected in AllPlants')
            goto continuePlant
        end

        -- Find matching plant configuration
        for _, plant in pairs(Plants) do
            -- Validate plant data
            if not plant or not plant.seedName or not plant.plantName then
                DBG:Warning('Invalid plant data detected in Plants')
                goto continueConfig
            end

            -- Check if plant types match and if the plant can be smelled
            if allPlant.plant_type == plant.seedName and plant.smelling then
                -- Decode plant coordinates
                local plantCoords = json.decode(allPlant.plant_coords)
                if not plantCoords or not plantCoords.x or not plantCoords.y or not plantCoords.z then
                    DBG:Warning('Invalid plant coordinates detected for plant: ' .. tostring(plant.seedName))
                    goto continueConfig
                end

                -- Check if player is within smelling distance
                distance = #(vector3(plantCoords.x, plantCoords.y, plantCoords.z) - playerCoords)
                if distance <= Config.smelling.distance then
                    DBG:Info('Player ' .. tostring(src) .. ' is within smelling distance of plant: ' .. plant.plantName)
                    table.insert(smellingPlants, { coords = plantCoords, plantName = plant.plantName })
                end
            end
            ::continueConfig::
        end
        ::continuePlant::
    end

    -- Send smelling plants to client if any were found
    if #smellingPlants > 0 then
        DBG:Info('Sending ' .. tostring(#smellingPlants) .. ' smelling plants to player ' .. tostring(src))
        cb(smellingPlants)
    else
        DBG:Info('No smelling plants found for player ' .. tostring(src))
        cb(false)
    end
end)

BccUtils.Versioner.checkFile(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-farming')

exports('GetPlayerHouses', GetPlayerHouses)
