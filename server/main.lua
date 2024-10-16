VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()

local AllPlants = {} -- AllPlants will contain all the plants in the server

RegisterServerEvent('bcc-farming:AddPlant', function(plantData, plantCoords)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter
    local item = plantData.seedName
    local amount = plantData.seedAmount

    local itemCount = exports.vorp_inventory:getItemCount(src, nil, item)
    if itemCount >= amount then
        exports.vorp_inventory:subItem(src, item, amount)
    end

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

VORPcore.Callback.Register('bcc-farming:CheckHasItem', function(source, cb, item, amount)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return cb(false) end

    local itemCount = exports.vorp_inventory:getItemCount(src, nil, item)
    if itemCount >= amount then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('bcc-farming:UpdatePlantWateredStatus', function(plantId, isRaining)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end

    if isRaining > 0 then
        MySQL.update.await('UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?', { 'true', plantId })
        TriggerClientEvent('bcc-farming:UpdatePlantWateredStatus', -1, plantId)
    else
        exports.vorp_inventory:subItem(src, Config.fullWaterBucket, 1)
        exports.vorp_inventory:addItem(src, Config.emptyWaterBucket, 1)
        MySQL.update.await('UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?', { 'true', plantId })
        TriggerClientEvent('bcc-farming:UpdatePlantWateredStatus', -1, plantId)
    end
end)

RegisterServerEvent('bcc-farming:HarvestPlant', function(plantId, plantData, destroy)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end

    if not destroy then
        for _, reward in pairs(plantData.rewards) do
            exports.vorp_inventory:addItem(src, reward.itemName, reward.amount)
        end
    end

    MySQL.query.await('DELETE FROM `bcc_farming` WHERE `plant_id` = ?', { plantId })
    TriggerClientEvent('bcc-farming:MaxPlantsAmount', src, -1)
    TriggerClientEvent('bcc-farming:RemovePlantClient', -1, plantId)
end)

VORPcore.Callback.Register('bcc-farming:CanCarryCheck', function(source, cb, item, amount)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return cb(false) end

    local check = exports.vorp_inventory:canCarryItem(src, item, amount)
	cb(check)
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

BccUtils.Versioner.checkFile(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-farming')
