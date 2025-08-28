local Core = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()
---@type BCCFarmingDebugLib
local DBG = BCCFarmingDebug or {
    Info = function() end,
    Error = function() end,
    Warning = function() end,
    Success = function() end
}
local AllPlants = {} -- AllPlants will contain all the plants in the server

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
--- @param plantCoords vector3
RegisterNetEvent('bcc-farming:AddPlant', function(plantData, plantCoords)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG.Error('User not found for source: ' .. tostring(src))
        return
    end

    local character = user.getUsedCharacter

    -- Validate plant data and coordinates
    if not plantData or not plantCoords then
        DBG.Error('Invalid plant data or coordinates from source: ' .. tostring(src))
        return
    end
    if not plantData.seedName or not plantData.timeToGrow then
        DBG.Error('Incomplete plant data from source: ' .. tostring(src))
        return
    end

    -- Insert plant into database
    local plantId = MySQL.insert.await('INSERT INTO `bcc_farming` (plant_coords, plant_type, plant_watered, time_left, plant_owner) VALUES (?, ?, ?, ?, ?)',
    { json.encode(plantCoords), plantData.seedName, 'false', plantData.timeToGrow, character.charIdentifier })

    if not plantId then
        DBG.Error('Failed to insert plant into database.')
        return
    end

    -- Trigger client event
    local target = Config.plantSetup.lockedToPlanter and src or -1
    TriggerClientEvent('bcc-farming:PlantPlanted', target, plantId, plantData, plantCoords, plantData.timeToGrow, false, src)
end)

--- @param plantData table
RegisterNetEvent('bcc-farming:PlantToolUsage',function (plantData)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG.Error('User not found for source: ' .. tostring(src))
        return
    end

    local toolItem = plantData.plantingTool
    local toolUsage = plantData.plantingToolUsage

    -- Check if the tool exists in the player's inventory
    local tool = exports.vorp_inventory:getItem(src, toolItem)
    if not tool then
        DBG.Error('Tool not found in inventory for source: ' .. tostring(src))
        return
    end

    local toolMeta = tool.metadata or {}

    -- If tool has no durability metadata, initialize it
    if not toolMeta.durability then
        exports.vorp_inventory:setItemMetadata(src, tool.id, {
            description = _U('UsageLeft') .. 100 - toolUsage .. '%',
            durability = 100 - toolUsage
        })
        DBG.Info('Initialized durability for tool: ' .. toolItem .. ', durability: ' .. tostring(100 - toolUsage))
    else
        -- Subtract durability
        local durabilityValue = toolMeta.durability - toolUsage

        -- Update the tool's metadata
        if durabilityValue >= toolUsage then
            exports.vorp_inventory:setItemMetadata(src, tool.id, {
                description = _U('UsageLeft') .. durabilityValue .. '%',
                durability = durabilityValue
            })
            DBG.Info('Updated tool durability for source: ' .. tostring(src) .. ', tool: ' .. toolItem .. ', durability: ' .. durabilityValue)
        else
            -- Remove the tool if durability is exhausted
            exports.vorp_inventory:subItemById(src, tool.id, nil, nil, 1)
            Core.NotifyRightTip(src, _U('needNewTool'), 4000)
            DBG.Info('Removed broken tool for source: ' .. tostring(src) .. ', tool: ' .. toolItem)
        end
    end
end)

RegisterNetEvent('bcc-farming:NewClientConnected', function()
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG.Error('User not found for source: ' .. tostring(src))
        return
    end

    local character = user.getUsedCharacter
    local charid = character.charIdentifier

    -- Check if AllPlants is empty
    if not AllPlants or #AllPlants <= 0 then
        DBG.Error('No plants to sync for source: ' .. tostring(src))
        return
    end

    -- Loop through all plants on the server
    for _, currentPlants in pairs(AllPlants) do
        if Config.plantSetup.lockedToPlanter and currentPlants.plant_owner ~= charid then
            goto END
        end

        -- If player owns plant add to their max plants count
        if currentPlants.plant_owner == charid then
            TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, 1)
        end

        -- Get plant configuration and send to client
        for _, plantCfg in pairs(Plants) do
            if currentPlants.plant_type == plantCfg.seedName then
                local plantCoords = json.decode(currentPlants.plant_coords)
                TriggerClientEvent('bcc-farming:PlantPlanted', src, currentPlants.plant_id, plantCfg, plantCoords, currentPlants.time_left, currentPlants.plant_watered, src)
                break
            end
        end
        ::END::
    end
end)

--- @param plantId number
Core.Callback.Register('bcc-farming:ManagePlantWateredStatus', function(source, cb, plantId)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG.Error('User not found for source: ' .. tostring(src))
        return cb(false)
    end

    -- Check if plantId is valid
    if not plantId then
        DBG.Error('Invalid plantId from source: ' .. tostring(src))
        return cb(false)
    end

    local fullWaterBucket = Config.fullWaterBucket

    -- Check for any full water bucket
    for _, item in ipairs(fullWaterBucket) do
        local itemCount = exports.vorp_inventory:getItemCount(src, nil, item)
        if itemCount >= 1 then
            -- Remove full water bucket and add empty one
            local successRemove = exports.vorp_inventory:subItem(src, item, 1)
            local successAdd = exports.vorp_inventory:addItem(src, Config.emptyWaterBucket, 1)
            if not successRemove or not successAdd then
                DBG.Error('Failed to update inventory for source: ' .. tostring(src))
                return cb(false)
            end

            -- Update plant watered status in database
            local successUpdate = MySQL.update.await('UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?', { 'true', plantId })

            if not successUpdate then
                DBG.Error('Failed to update plant watered status in database for plantId: ' .. tostring(plantId))
                return cb(false)
            end

            TriggerClientEvent('bcc-farming:UpdateClientPlantWateredStatus', -1, plantId)
            return cb(true)
        end
    end

    DBG.Error('No water bucket found for source: ' .. tostring(src))
    cb(false)
end)

--- @param plantId number
RegisterNetEvent('bcc-farming:UpdatePlantWateredStatus', function(plantId)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG.Error('User not found for source: ' .. tostring(src))
        return
    end

    -- Check if plantId is valid
    if not plantId then
        DBG.Error('Invalid plantId from source: ' .. tostring(src))
        return
    end

    -- Update plant watered status in database
    local result = MySQL.update.await('UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?', { 'true', plantId })

    if not result then
        DBG.Error('Failed to update plant watered status in database for plantId: ' .. tostring(plantId))
        return
    end

    DBG.Success('Successfully updated watered status for plant ID: ' .. tostring(plantId))
    TriggerClientEvent('bcc-farming:UpdateClientPlantWateredStatus', -1, plantId)
end)

--- @param plantId number
--- @param plantData table
--- @param destroy boolean
Core.Callback.Register('bcc-farming:HarvestCheck', function(source, cb, plantId, plantData, destroy)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG.Error('User not found for source: ' .. tostring(src))
        return cb(false)
    end

    -- Validate plantId and plantData
    if not plantId or not plantData then
        DBG.Error('Invalid plant ID or plant data for source: ' .. tostring(src))
        return cb(false)
    end

    -- If not destroying, check if player can carry all rewards
    if not destroy then
        local itemsToAdd = {}

        -- Check if all items can be carried
        for _, reward in pairs(plantData.rewards) do
            local itemName = reward.itemName
            local itemLabel = reward.itemLabel
            local amount = reward.amount

            if not itemName or not itemLabel or not amount then
                DBG.Error('Invalid reward data for plant ID: ' .. tostring(plantId))
                return cb(false)
            end

            local canCarry = exports.vorp_inventory:canCarryItem(src, itemName, amount)
            if not canCarry then
                Core.NotifyRightTip(src, _U('noCarry') .. itemName, 4000)
                DBG.Error('Player ' .. tostring(src) .. ' cannot carry item: ' .. itemName)
                return cb(false)
            end

            table.insert(itemsToAdd, { itemName = itemName, itemLabel = itemLabel, amount = amount })
        end

        -- Add items if can be carried
        for _, item in ipairs(itemsToAdd) do
            local success = exports.vorp_inventory:addItem(src, item.itemName, item.amount)
            if not success then
                DBG.Warning('Failed to add item to inventory for source: ' .. tostring(src) .. ', item: ' .. item.itemName)
            else
                Core.NotifyRightTip(src, _U('harvested') .. item.amount .. ' ' .. item.itemLabel, 4000)
                DBG.Success('Successfully added item to inventory for source: ' .. tostring(src) .. ', item: ' .. item.itemName)
            end
        end
    end

    -- Update plant status in database and remove plant from clients
    local result = MySQL.query.await('DELETE FROM `bcc_farming` WHERE `plant_id` = ?', { plantId })

    if not result or (result and result.affectedRows and result.affectedRows == 0) then
        DBG.Error('Failed to delete plant with ID: ' .. tostring(plantId) .. ' from database')
        return cb(false)
    end

    DBG.Success('Successfully deleted plant with ID: ' .. tostring(plantId) .. ' from database')

    TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, -1)
    TriggerClientEvent('bcc-farming:RemovePlantClient', -1, plantId)

    cb(true)
end)

--- @param fertilizerName string
RegisterNetEvent('bcc-farming:RemoveFertilizer', function(fertilizerName)
    local src = source
    local user = Core.getUser(src)

    -- Check if the user exists
    if not user then
        DBG.Error('User not found for source: ' .. tostring(src))
        return
    end

    -- Validate fertilizerName
    if not fertilizerName then
        DBG.Error('No fertilizer name provided by source: ' .. tostring(src))
        return
    end

    -- Check if player has the fertilizer
    local fertCount = exports.vorp_inventory:getItemCount(src, nil, fertilizerName)
    DBG.Info('Player ' .. tostring(src) .. ' has ' .. tostring(fertCount) .. ' of ' .. fertilizerName)

    if fertCount >= 1 then
        -- Remove 1 fertilizer from inventory
        local success = exports.vorp_inventory:subItem(src, fertilizerName, 1)
        if success then
            DBG.Success('Successfully removed 1 of ' .. fertilizerName .. ' from inventory for source: ' .. tostring(src))
        else
            DBG.Warning('Failed to remove 1 of ' .. fertilizerName .. ' from inventory for source: ' .. tostring(src))
        end
    else
        DBG.Info('Player ' .. tostring(src) .. ' does not have any of ' .. fertilizerName .. ' in inventory')
    end
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
        DBG.Error('User not found for source: ' .. tostring(src))
        return
    end

    -- Return Seeds
    if seedName and seedAmount and seedAmount > 0 then
        DBG.Info('Returning ' .. tostring(seedAmount) .. ' of ' .. seedName .. ' to player ' .. tostring(src))
        local canCarrySeed = exports.vorp_inventory:canCarryItem(src, seedName, seedAmount)
        if canCarrySeed then
            local success = exports.vorp_inventory:addItem(src, seedName, seedAmount)
            if success then
                DBG.Success('Successfully returned ' ..
                tostring(seedAmount) .. ' of ' .. seedName .. ' to player ' .. tostring(src))
            else
                DBG.Warning('Failed to return ' ..
                tostring(seedAmount) .. ' of ' .. seedName .. ' to player ' .. tostring(src))
            end
        else
            DBG.Warning('Player ' .. tostring(src) .. ' could not carry returned seeds: ' .. seedName)
        end
    else
        DBG.Info('No seeds to return or invalid seed data for player ' .. tostring(src))
    end

    -- Return Soil if Required
    if soilRequired and soilName and soilAmount and soilAmount > 0 then
        local canCarrySoil = exports.vorp_inventory:canCarryItem(src, soilName, soilAmount)
        if canCarrySoil then
            local success = exports.vorp_inventory:addItem(src, soilName, soilAmount)
            if success then
                DBG.Success('Successfully returned ' ..
                tostring(soilAmount) .. ' of ' .. soilName .. ' to player ' .. tostring(src))
            else
                DBG.Warning('Failed to return ' ..
                tostring(soilAmount) .. ' of ' .. soilName .. ' to player ' .. tostring(src))
            end
        else
            DBG.Warning('Player ' .. tostring(src) .. ' could not carry returned soil: ' .. soilName)
        end
    else
        DBG.Info('No soil to return or invalid soil data for player ' .. tostring(src))
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        local timeLeft

        -- Fetch all plants from the database
        local allPlants = MySQL.query.await('SELECT * FROM `bcc_farming`')
        if not allPlants then
            DBG.Warning('Failed to fetch plants from database. Will try again.')
            Wait(5000)
            goto continueThread
        end

        -- Update global AllPlants table
        AllPlants = allPlants
        --DBG.Info('Fetched ' .. tostring(#allPlants) .. ' plants from database.')

        -- Process each plant
        if #allPlants > 0 then
            for _, plant in pairs(allPlants) do
                -- Validate plant data
                if not plant or not plant.plant_id or not plant.time_left or not plant.plant_watered then
                    DBG.Warning('Invalid plant data detected')
                    goto continuePlant
                end

                timeLeft = tonumber(plant.time_left)

                -- Only process watered plants with time left
                if plant.plant_watered == 'true' and timeLeft > 0 then
                    local newTime = timeLeft - 1
                    --DBG.Info('Updating plant ID: ' .. tostring(plant.plant_id) .. ', time left: ' .. tostring(newTime))

                    -- Update plant time in database
                    local success = MySQL.update.await('UPDATE `bcc_farming` SET `time_left` = ? WHERE `plant_id` = ?',
                        { newTime, plant.plant_id })

                    if not success then
                        DBG.Warning('Failed to update time for plant ID: ' .. tostring(plant.plant_id))
                    else
                        DBG.Info('Successfully updated time for plant ID: ' .. tostring(plant.plant_id))
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
        DBG.Error('User not found for source: ' .. tostring(src))
        return cb(false)
    end

    local hasJob = CheckPlayerJob(src)
    if not hasJob then
        --DBG.Warning('Player ' .. tostring(src) .. ' does not have the required job for smelling plants.')
        return cb(false)
    end

    -- Validate player coordinates
    if not playerCoords then
        DBG.Error('Invalid player coordinates for source: ' .. tostring(src))
        return cb(false)
    end

    -- Validate AllPlants and Plants tables
    if not AllPlants or not Plants then
        DBG.Error('AllPlants or Plants table is not defined')
        return cb(false)
    end

    local smellingPlants = {}

    -- Iterate through all plants
    for _, allPlant in pairs(AllPlants) do
        local distance
        -- Validate plant data
        if not allPlant or not allPlant.plant_type or not allPlant.plant_coords then
            DBG.Warning('Invalid plant data detected in AllPlants')
            goto continuePlant
        end

        -- Find matching plant configuration
        for _, plant in pairs(Plants) do
            -- Validate plant data
            if not plant or not plant.seedName or not plant.plantName then
                DBG.Warning('Invalid plant data detected in Plants')
                goto continueConfig
            end

            -- Check if plant types match and if the plant can be smelled
            if allPlant.plant_type == plant.seedName and plant.smelling then
                -- Decode plant coordinates
                local plantCoords = json.decode(allPlant.plant_coords)
                if not plantCoords or not plantCoords.x or not plantCoords.y or not plantCoords.z then
                    DBG.Warning('Invalid plant coordinates detected for plant: ' .. tostring(plant.seedName))
                    goto continueConfig
                end

                -- Check if player is within smelling distance
                distance = #(vector3(plantCoords.x, plantCoords.y, plantCoords.z) - playerCoords)
                if distance <= Config.smelling.distance then
                    DBG.Info('Player ' .. tostring(src) .. ' is within smelling distance of plant: ' .. plant.plantName)
                    table.insert(smellingPlants, { coords = plantCoords, plantName = plant.plantName })
                end
            end
            ::continueConfig::
        end
        ::continuePlant::
    end

    -- Send smelling plants to client if any were found
    if #smellingPlants > 0 then
        DBG.Info('Sending ' .. tostring(#smellingPlants) .. ' smelling plants to player ' .. tostring(src))
        cb(smellingPlants)
    else
        DBG.Info('No smelling plants found for player ' .. tostring(src))
        cb(false)
    end
end)

BccUtils.Versioner.checkFile(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-farming')
