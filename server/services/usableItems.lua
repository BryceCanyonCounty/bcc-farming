local DEFAULT_LOCK_RANGE = 2.5
local NOTIFY_DURATION = 4000

local function reject(src, messageKey, logMessage)
    if logMessage then
        DBG:Error(logMessage)
    end
    if messageKey then
        NotifyClient(src, _U(messageKey), 'error', NOTIFY_DURATION)
    end
    return false
end

local function normalizeLock(lock)
    local normalized = lock
    local radius

    if type(lock) == 'table' then
        radius = tonumber(rawget(lock, 'radius') or rawget(lock, 'range'))
        normalized = rawget(lock, 'coords') or lock
    end

    local normalizedType = type(normalized)
    if normalizedType == 'vector3' or normalizedType == 'vector4' then
        return vector3(normalized.x + 0.0, normalized.y + 0.0, normalized.z + 0.0), radius
    end

    if normalizedType ~= 'table' then
        return nil, radius
    end

    local x = rawget(normalized, 'x') or normalized[1]
    local y = rawget(normalized, 'y') or normalized[2]
    local z = rawget(normalized, 'z') or normalized[3]
    if not x or not y or not z then
        return nil, radius
    end

    return vector3(x + 0.0, y + 0.0, z + 0.0), radius
end

local function isWithinCoordinateLock(playerCoords, plantCfg)
    if not plantCfg.lockCoords or type(plantCfg.coordsLocks) ~= 'table' or not next(plantCfg.coordsLocks) then
        return false, false
    end

    local baseRadius = tonumber(plantCfg.coordsLockRange) or DEFAULT_LOCK_RANGE
    local tolerance = tonumber(plantCfg.coordsLockTolerance) or 0.0

    for _, lock in ipairs(plantCfg.coordsLocks) do
        local lockCoords, customRadius = normalizeLock(lock)
        if lockCoords and #(playerCoords - lockCoords) <= ((customRadius or baseRadius) + tolerance) then
            return true, true
        end
    end

    return true, false
end

local function getHouseContext(charIdentifier, playerCoords)
    local houses = GetPlayerHouses(charIdentifier)
    if not houses or #houses == 0 then
        return false, false, nil
    end

    local padding = tonumber(Config.plantSetup.houseRadiusPadding) or 0.0
    local withinHouse = false
    local payload = {}

    for _, house in ipairs(houses) do
        if house.coords then
            local radius = (tonumber(house.radius) or 0.0) + padding
            payload[#payload + 1] = {
                x = house.coords.x,
                y = house.coords.y,
                z = house.coords.z,
                radius = radius
            }
            if not withinHouse and #(playerCoords - house.coords) <= radius then
                withinHouse = true
            end
        end
    end

    return true, withinHouse, payload
end

local function validatePlantingArea(src, character, playerCoords, plantCfg)
    local housePayload
    local withinHouse = false

    if Config.plantSetup.requireHouseOwnership then
        local ownsHouse
        ownsHouse, withinHouse, housePayload = getHouseContext(character.charIdentifier, playerCoords)
        if not ownsHouse then
            return reject(src, 'needHouseOwnership', 'Player does not own a house'), nil
        end
    end

    local lockRequired, withinLock = isWithinCoordinateLock(playerCoords, plantCfg)
    if lockRequired and not withinLock and not (Config.plantSetup.requireHouseOwnership and withinHouse) then
        return reject(src, 'mustUseLockedSpot', 'Player not within locked planting coordinates'), nil
    end

    if Config.plantSetup.requireHouseOwnership and not withinHouse and not withinLock then
        return reject(src, 'needHousePlot', 'Player not within owned house radius'), nil
    end

    return true, housePayload
end

local function isTooCloseToTown(playerCoords)
    if Config.townSetup.canPlantInTowns then
        return false
    end

    for _, townCfg in pairs(Config.townSetup.townLocations or {}) do
        if townCfg.coords and townCfg.townRange
            and #(playerCoords - townCfg.coords) <= townCfg.townRange then
            return true
        end
    end

    return false
end

local function hasAllowedJob(character, plantCfg)
    if not plantCfg.jobLocked then
        return true
    end

    for _, job in ipairs(plantCfg.jobs or {}) do
        if character.job == job then
            return true
        end
    end

    return false
end

local function hasRequiredItem(src, itemName, amount)
    if not itemName or not amount or amount <= 0 then
        return false
    end
    return exports.vorp_inventory:getItemCount(src, nil, itemName) >= amount
end

local function belowPlantLimit(charIdentifier)
    local plantCount = MySQL.scalar.await(
        'SELECT COUNT(*) FROM `bcc_farming` WHERE `plant_owner` = ?',
        { charIdentifier }
    )
    plantCount = tonumber(plantCount)
    if not plantCount then
        DBG:Error('Failed to count plants for character: ' .. tostring(charIdentifier))
        return false
    end
    return plantCount < (tonumber(Config.plantSetup.maxPlants) or 0)
end

local function getAvailableFertilizers(src)
    local available = {}
    for _, fertilizer in ipairs(Config.fertilizerSetup or {}) do
        if fertilizer.fertName
            and exports.vorp_inventory:getItemCount(src, nil, fertilizer.fertName) > 0 then
            available[#available + 1] = fertilizer.fertName
        end
    end
    return available
end

local function consumePlantingItems(src, plantCfg)
    local seedRemoved = exports.vorp_inventory:subItem(src, plantCfg.seedName, plantCfg.seedAmount)
    if seedRemoved == false then
        return false
    end

    if plantCfg.soilRequired then
        local soilRemoved = exports.vorp_inventory:subItem(src, plantCfg.soilName, plantCfg.soilAmount)
        if soilRemoved == false then
            exports.vorp_inventory:addItem(src, plantCfg.seedName, plantCfg.seedAmount)
            return false
        end
    end

    return true
end

local function useSeed(plantCfg, data)
    local src = data and tonumber(data.source)
    if not src then
        DBG:Error('Usable seed called without a valid source')
        return
    end

    local user = Core.getUser(src)
    if not user then
        DBG:Error('User not found for source: ' .. tostring(src))
        return
    end

    local character = user.getUsedCharacter
    local playerPed = GetPlayerPed(src)
    if not character or not playerPed or playerPed == 0 then
        DBG:Error('Character or player ped not found for source: ' .. tostring(src))
        return
    end

    local playerCoords = GetEntityCoords(playerPed)
    local areaValid, housePayload = validatePlantingArea(src, character, playerCoords, plantCfg)
    if not areaValid then
        return
    end

    if isTooCloseToTown(playerCoords) then
        reject(src, 'tooCloseToTown', 'Player too close to town')
        return
    end

    if not hasAllowedJob(character, plantCfg) then
        reject(src, 'incorrectJob', "Player doesn't have required job")
        return
    end

    if plantCfg.soilRequired then
        if not hasRequiredItem(src, plantCfg.soilName, tonumber(plantCfg.soilAmount)) then
            reject(src, 'noSoil', "Player doesn't have enough soil")
            return
        end
    end

    if plantCfg.plantingToolRequired
        and not hasRequiredItem(src, plantCfg.plantingTool, 1) then
        reject(src, 'noPlantingTool', "Player doesn't have planting tool")
        return
    end

    if not belowPlantLimit(character.charIdentifier) then
        reject(src, 'maxPlantsReached', 'Player reached max plants limit')
        return
    end

    if not hasRequiredItem(src, plantCfg.seedName, tonumber(plantCfg.seedAmount)) then
        reject(src, 'noSeed', "Player doesn't have enough seeds")
        return
    end

    exports.vorp_inventory:closeInventory(src)
    if not consumePlantingItems(src, plantCfg) then
        reject(src, 'failed', 'Failed to remove planting items from inventory')
        return
    end

    if not BeginPlantingProcess(src, plantCfg) then
        exports.vorp_inventory:addItem(src, plantCfg.seedName, plantCfg.seedAmount)
        if plantCfg.soilRequired then
            exports.vorp_inventory:addItem(src, plantCfg.soilName, plantCfg.soilAmount)
        end
        reject(src, 'failed', 'Failed to initialize pending planting state')
        return
    end

    local availableFertilizers = getAvailableFertilizers(src)
    DBG:Info(('Starting %s planting for source %d with %d fertilizer choice(s)')
        :format(tostring(plantCfg.seedName), src, #availableFertilizers))
    TriggerClientEvent('bcc-farming:PlantingCrop', src, plantCfg, availableFertilizers, housePayload)
end

CreateThread(function()
    for _, configuredPlant in ipairs(Plants or {}) do
        local plantCfg = configuredPlant
        if plantCfg.seedName then
            exports.vorp_inventory:registerUsableItem(plantCfg.seedName, function(data)
                useSeed(plantCfg, data)
            end, GetCurrentResourceName())
        else
            DBG:Error('Skipped plant with missing seedName')
        end
    end
end)
