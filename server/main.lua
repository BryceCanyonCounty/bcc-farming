VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()

local AllPlants = {} -- AllPlants will contain all the plants in the server

local function CheckPlayerJob(src)
    local character = VORPcore.getUser(src).getUsedCharacter
    local playerJob = character.job
    for _, job in ipairs(Config.PoliceJobs) do
        if (playerJob == job) then
            return true
        end
    end
    return false
end

RegisterServerEvent('bcc-farming:AddPlant', function(plantData, plantCoords)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter

    local plantId = MySQL.insert.await('INSERT INTO `bcc_farming` (plant_coords, plant_type, plant_watered, time_left, plant_owner) VALUES (?, ?, ?, ?, ?)',
    { json.encode(plantCoords), plantData.seedName, 'false', plantData.timeToGrow, character.charIdentifier })

    if Config.plantSetup.lockedToPlanter then
        TriggerClientEvent('bcc-farming:PlantPlanted', src, plantId, plantData, plantCoords, plantData.timeToGrow, false, src)
    else
        TriggerClientEvent('bcc-farming:PlantPlanted', -1, plantId, plantData, plantCoords, plantData.timeToGrow, false, src)
    end
end)

RegisterServerEvent('bcc-farming:PlantToolUsage',function (plantData)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local toolItem = plantData.plantingTool
    local toolUsage = plantData.plantingToolUsage
    local tool = exports.vorp_inventory:getItem(src, toolItem)
    local toolMeta =  tool['metadata']

    if next(toolMeta) == nil then
        exports.vorp_inventory:subItem(src, toolItem, 1, {})
        exports.vorp_inventory:addItem(src, toolItem, 1, { description = _U('UsageLeft') .. 100 - toolUsage, durability = 100 - toolUsage })
    else
        local durabilityValue = toolMeta.durability - toolUsage
        exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)

        if durabilityValue >= toolUsage then
            exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)
            exports.vorp_inventory:addItem(src, toolItem, 1, { description = _U('UsageLeft') .. durabilityValue, durability = durabilityValue })
        elseif durabilityValue < toolUsage then
            exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)
            VORPcore.NotifyRightTip(src, _U('needNewTool'), 4000)
        end
    end
end)

RegisterServerEvent('bcc-farming:NewClientConnected', function()
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter
    local charid = character.charIdentifier

    if #AllPlants <= 0 then return end

    if not Config.plantSetup.lockedToPlanter then
        for _, currentPlants in pairs(AllPlants) do
            if currentPlants.plant_owner == charid then
                TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, 1)
            end
            for _, plantCfg in pairs(Plants) do
                if currentPlants.plant_type == plantCfg.seedName then
                    TriggerClientEvent('bcc-farming:PlantPlanted',
                    src, currentPlants.plant_id, plantCfg, json.decode(currentPlants.plant_coords), currentPlants.time_left, currentPlants.plant_watered, src)
                    break
                end
            end
        end
    else
        for _, currentPlants in pairs(AllPlants) do
            if currentPlants.plant_owner == charid then
                TriggerClientEvent('bcc-farming:MaxPlantsAmount',src, 1)
                for _, plantCfg in pairs(Plants) do
                    if currentPlants.plant_type == plantCfg.seedName then
                        TriggerClientEvent('bcc-farming:PlantPlanted',
                        src, currentPlants.plant_id, plantCfg, json.decode(currentPlants.plant_coords), currentPlants.time_left, currentPlants.plant_watered, src)
                        break
                    end
                end
            end
        end
    end
end)

VORPcore.Callback.Register('bcc-farming:ManagePlantWateredStatus', function(source, cb, plantId)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return cb(false) end

    local fullWaterBucket = Config.fullWaterBucket
    for _, item in ipairs(fullWaterBucket) do
        local itemCount = exports.vorp_inventory:getItemCount(src, nil, item)
        if itemCount >= 1 then
            exports.vorp_inventory:subItem(src, item, 1)
            exports.vorp_inventory:addItem(src, Config.emptyWaterBucket, 1)
            MySQL.update.await('UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?', { 'true', plantId })
            TriggerClientEvent('bcc-farming:UpdateClientPlantWateredStatus', -1, plantId)
            return cb(true)
        end
    end

    cb(false)
end)

RegisterNetEvent('bcc-farming:UpdatePlantWateredStatus', function(plantId)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end

    MySQL.update.await('UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?', { 'true', plantId })
    TriggerClientEvent('bcc-farming:UpdateClientPlantWateredStatus', -1, plantId)
end)

VORPcore.Callback.Register('bcc-farming:HarvestCheck', function(source, cb, plantId, plantData, destroy)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return cb(false) end

    if not destroy then
        local itemsToAdd = {}

        -- Check if all items can be carried
        for _, reward in pairs(plantData.rewards) do
            local itemName = reward.itemName
            local itemLabel = reward.itemLabel
            local amount = reward.amount
            local canCarry = exports.vorp_inventory:canCarryItem(src, itemName, amount)
            if canCarry then
                table.insert(itemsToAdd, { itemName = itemName, itemLabel = itemLabel, amount = amount })
            else
                VORPcore.NotifyRightTip(src, _U('noCarry') .. itemName, 4000)
                return cb(false) -- Exit early if any item cannot be carried
            end
        end

        -- Add items if all can be carried
        for _, item in ipairs(itemsToAdd) do
            exports.vorp_inventory:addItem(src, item.itemName, item.amount)
            VORPcore.NotifyRightTip(src, _U('harvested') .. item.amount .. ' ' .. item.itemLabel, 4000)
        end
    end

    cb(true)

    -- Update plant status in database and remove plant from clients
    MySQL.query.await('DELETE FROM `bcc_farming` WHERE `plant_id` = ?', { plantId })
    TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, -1)
    TriggerClientEvent('bcc-farming:RemovePlantClient', -1, plantId)
end)

RegisterServerEvent('bcc-farming:RemoveFertilizer', function(fertilizerName)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end

    local fertCount = exports.vorp_inventory:getItemCount(src, nil, fertilizerName)
    if fertCount >= 1 then
        exports.vorp_inventory:subItem(src, fertilizerName, 1)
    end
end)

RegisterNetEvent('bcc-farming:AddSeedToInventory', function(seedName, amount)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end

    local canCarry = exports.vorp_inventory:canCarryItem(src, seedName, amount)
    if canCarry then
        exports.vorp_inventory:addItem(src, seedName, amount)
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        local allPlants = MySQL.query.await('SELECT * FROM `bcc_farming`')
        AllPlants = allPlants
        if #allPlants > 0 then
            for _, plant in pairs(allPlants) do
                local timeLeft = tonumber(plant.time_left)
                if plant.plant_watered == 'true' and timeLeft > 0 then
                    local newTime = timeLeft - 1
                    MySQL.update('UPDATE `bcc_farming` SET `time_left` = ? WHERE `plant_id` = ?', { newTime, plant.plant_id }, function() end)
                end
            end
        end
    end
end)

RegisterNetEvent('bcc-farming:DetectSmellingPlants', function(playerCoords)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter
    local hasJob = CheckPlayerJob(src)
    if not hasJob then return end
    local smellingPlants = {}

    for _, allPlant in pairs(AllPlants) do
        for h, plant in pairs(Plants) do
            local plantData = AllPlants[allPlant.plant_type]
            if allPlant.plant_type == plant.seedName and plant.smelling then
                local plantCoords = json.decode(allPlant.plant_coords)
                local distance = #(vector3(plantCoords.x, plantCoords.y, plantCoords.z) - playerCoords)
                if distance <= Config.SmellingDistance then
                    table.insert(smellingPlants, { coords = plantCoords, plantName = plant.plantName })
                    TriggerClientEvent('bcc-farming:ShowSmellingPlants', src, smellingPlants)
                end
            end
        end
    end
end)

BccUtils.Versioner.checkFile(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-farming')
