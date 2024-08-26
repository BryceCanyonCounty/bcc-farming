AllPlants = {} -- AllPlants is a table that will contain all the plants in the server

---@param plantData table
---@param plantCoords vector3
RegisterServerEvent("bcc-farming:AddPlant", function(plantData, plantCoords)
    local _source = source
    local user = VORPcore.getUser(_source)
    if not user then return end
    local character = user.getUsedCharacter

    local plantId = MySQL.insert.await(
        "INSERT INTO `bcc_farming` (plant_coords, plant_type, plant_watered, time_left, plant_owner) VALUES (?, ?, ?, ?, ?)",
        { json.encode(plantCoords), plantData.seedName, "false", plantData.timeToGrow, character.charIdentifier })

    if Config.plantSetup.lockedToPlanter then
        TriggerClientEvent('bcc-farming:PlantPlanted', _source, plantId, plantData, plantCoords, plantData.timeToGrow, false, _source)
    else
        TriggerClientEvent('bcc-farming:PlantPlanted', -1, plantId, plantData, plantCoords, plantData.timeToGrow, false, _source)
    end
end)

RegisterServerEvent("bcc-farming:GiveBackSeed", function(seed, amount)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end

    local canCarry = exports.vorp_inventory:canCarryItem(src, seed, amount)
    if canCarry then
        exports.vorp_inventory:addItem(src, seed, amount)
    end
end)

RegisterServerEvent("bcc-farming:PlantToolUsage", function(plantData)
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local toolItem = plantData.plantingTool
    local toolUsage = plantData.plantingToolUsage
    local tool = exports.vorp_inventory:getItem(src, toolItem)
    local toolMeta = tool["metadata"]

    if next(toolMeta) == nil then
        exports.vorp_inventory:subItem(src, toolItem, 1, {})
        exports.vorp_inventory:addItem(src, toolItem, 1, { description = _U("UsageLeft") .. 100 - toolUsage, durability = 100 - toolUsage })
    else
        local durabilityValue = toolMeta.durability - toolUsage
        exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)

        if durabilityValue >= toolUsage then
            exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)
            exports.vorp_inventory:addItem(src, toolItem, 1, { description = _U("UsageLeft") .. durabilityValue, durability = durabilityValue })
        elseif durabilityValue < toolUsage then
            exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)
            VORPcore.NotifyRightTip(src, _U('needNewTool'), 4000)
        end
    end
end)

RegisterServerEvent("bcc-farming:NewClientConnected", function()
    local _source = source
    local user = VORPcore.getUser(_source)
    if not user then return end
    local character = user.getUsedCharacter
    local charid = character.charIdentifier

    if not Config.plantSetup.lockedToPlanter then
        if #AllPlants > 0 then
            for k, v in pairs(AllPlants) do
                for e, u in pairs(Plants) do
                    if v.plant_owner == character.charIdentifier then
                        TriggerClientEvent('bcc-farming:client:MaxPlantsAmount', _source, 1)
                    end
                    if v.plant_type == u.seedName then
                        TriggerClientEvent('bcc-farming:PlantPlanted', _source, v.plant_id, u, json.decode(v.plant_coords), v.time_left, v.plant_watered, _source)
                        break
                    end
                end
            end
        end
    else
        if #AllPlants > 0 then
            for k, v in pairs(AllPlants) do
                if v.plant_owner == charid then
                    for e, u in pairs(Plants) do
                        if v.plant_type == u.seedName then
                            TriggerClientEvent('bcc-farming:client:MaxPlantsAmount', _source, 1)
                            TriggerClientEvent('bcc-farming:PlantPlanted', _source, v.plant_id, u, json.decode(v.plant_coords), v.time_left, v.plant_watered, _source)
                            break
                        end
                    end
                end
            end
        end
    end
end)

---@param plantId integer
RegisterServerEvent("bcc-farming:UpdatePlantWateredStatus", function(plantId, isRaining)
    local _source = source
    local user = VORPcore.getUser(_source)
    if not user then return end
    local hasWaterBucket = exports.vorp_inventory:getItem(_source, Config.fullWaterBucket)

    if isRaining > 0 then
        MySQL.query.await("UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?", { 'true', plantId })
        TriggerClientEvent("bcc-farming:UpdatePlantWateredStatus", -1, plantId)

    elseif hasWaterBucket then
        exports.vorp_inventory:subItem(_source, Config.fullWaterBucket, 1)
        exports.vorp_inventory:addItem(_source, Config.emptyWaterBucket, 1)
        MySQL.query.await("UPDATE `bcc_farming` SET `plant_watered` = ? WHERE `plant_id` = ?", { 'true', plantId })
        TriggerClientEvent("bcc-farming:UpdatePlantWateredStatus", -1, plantId)

    else
        VORPcore.NotifyRightTip(_source, _U("noWaterBucket"), 4000)
    end
end)

---@param plantId integer
---@param plantData table
---@param destroy boolean
RegisterServerEvent('bcc-farming:HarvestPlant', function(plantId, plantData, destroy)
    local _source = source
    local user = VORPcore.getUser(_source)
    if not user then return end

    if not destroy then
        for k, v in pairs(plantData.rewards) do
            exports.vorp_inventory:addItem(_source, v.itemName, v.amount)
        end

        MySQL.query.await("DELETE FROM `bcc_farming` WHERE `plant_id` = ?", { plantId })
        TriggerClientEvent('bcc-farming:client:MaxPlantsAmount', _source, -1)
        TriggerClientEvent("bcc-farming:RemovePlantClient", -1, plantId)

    else
        MySQL.query.await("DELETE FROM `bcc_farming` WHERE `plant_id` = ?", { plantId })
        TriggerClientEvent('bcc-farming:client:MaxPlantsAmount', _source, -1)
        TriggerClientEvent("bcc-farming:RemovePlantClient", -1, plantId)
    end
end)

---@param item string
---@param amount integer
VORPcore.Callback.Register('bcc-farming:callback:CanCarryCheck', function(source, cb, item, amount)
    local _source = source
    local user = VORPcore.getUser(_source)
    if not user then return cb(false) end

    local check = exports.vorp_inventory:canCarryItem(_source, item, amount)
    cb(check)
end)

RegisterServerEvent('bcc-farming:RemoveFertilizer', function(fertilizerName)
    local _source = source
    local user = VORPcore.getUser(_source)
    if not user then return end

    -- Check if the player has the fertilizer
    local fertCount = exports.vorp_inventory:getItemCount(_source, nil, fertilizerName)
    if fertCount > 0 then
        -- Remove one unit of the fertilizer
        exports.vorp_inventory:subItem(_source, fertilizerName, 1)
        print("Removed one unit of " .. fertilizerName)
    else
        print("Fertilizer, " .. fertilizerName .. ", not found in inventory")
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        local allPlants = MySQL.query.await("SELECT * FROM `bcc_farming`")
        AllPlants = allPlants
        if #allPlants > 0 then
            for k, v in pairs(allPlants) do
                if v.plant_watered == "true" and tonumber(v.time_left) > 0 then
                    exports.oxmysql:execute("UPDATE bcc_farming SET time_left = time_left - ? WHERE plant_id = ?",
                        { 1, v.plant_id })
                end
            end
        end
    end
end)
