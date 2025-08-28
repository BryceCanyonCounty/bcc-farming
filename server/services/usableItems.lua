local Core = exports.vorp_core:GetCore()
---@type BCCFarmingDebugLib
local DBG = BCCFarmingDebug or {
    Info = function() end,
    Error = function() end,
    Warning = function() end,
    Success = function() end
}

CreateThread(function()
    for _, plantCfg in pairs(Plants) do
        exports.vorp_inventory:registerUsableItem(plantCfg.seedName, function(data)
            local src = data.source
            local user = Core.getUser(src)

            -- Check if the user exists
            if not user then
                DBG.Error('User not found for source: ' .. tostring(src))
                return
            end

            local character = user.getUsedCharacter
            local playerCoords = GetEntityCoords(GetPlayerPed(src))

            -- Town Check
            if not Config.townSetup.canPlantInTowns then
                DBG.Info("Checking town proximity...")
                for _, townCfg in pairs(Config.townSetup.townLocations) do
                    if #(playerCoords - townCfg.coords) <= townCfg.townRange then
                        DBG.Error("Player too close to town")
                        Core.NotifyRightTip(src, _U('tooCloseToTown'), 4000)
                        return
                    end
                end
                DBG.Success("Town check passed")
            else
                DBG.Success("Town check skipped (can plant in towns)")
            end

            -- Job Check
            if plantCfg.jobLocked then
                DBG.Info("Checking job requirements...")
                local hasJob = false
                for _, job in ipairs(plantCfg.jobs) do
                    if character.job == job then
                        hasJob = true
                        break
                    end
                end
                if not hasJob then
                    DBG.Error("Player doesn't have required job")
                    Core.NotifyRightTip(src, _U('incorrectJob'), 4000)
                    return
                end
                DBG.Success("Job check passed")
            else
                DBG.Success("Job check skipped (no job requirements)")
            end

            -- Soil Check
            if plantCfg.soilRequired then
                DBG.Info("Checking soil requirements...")
                if not plantCfg.soilName or not plantCfg.soilAmount then
                    DBG.Error('Soil config is missing or invalid.')
                    return
                end
                local hasSoil = exports.vorp_inventory:getItemCount(src, nil, plantCfg.soilName)
                if hasSoil < plantCfg.soilAmount then
                    DBG.Error("Player doesn't have enough soil")
                    Core.NotifyRightTip(src, _U('noSoil'), 4000)
                    return
                end
                DBG.Success("Soil check passed")
            else
                DBG.Success("Soil check skipped (no soil required)")
            end

            -- Tool Check
            if plantCfg.plantingToolRequired then
                DBG.Info("Checking planting tool...")
                local hasPlantingTool = exports.vorp_inventory:getItemCount(src, nil, plantCfg.plantingTool)
                if hasPlantingTool == 0 then
                    DBG.Error("Player doesn't have planting tool")
                    Core.NotifyRightTip(src, _U('noPlantingTool'), 4000)
                    return
                end
                DBG.Success("Tool check passed")
            else
                DBG.Success("Tool check skipped (no tool required)")
            end

            -- Max Plants Check
            DBG.Info("Checking max plants limit...")
            local playerPlants = MySQL.query.await('SELECT * FROM `bcc_farming` WHERE `plant_owner` = ?', { character.charIdentifier })
            if not playerPlants or #playerPlants >= Config.plantSetup.maxPlants then
                DBG.Error("Player reached max plants limit")
                Core.NotifyRightTip(src, _U('maxPlantsReached'), 4000)
                return
            end
            DBG.Success("Max plants check passed")

            -- Seed Check
            DBG.Info("Checking seed requirements...")
            if not plantCfg.seedName or not plantCfg.seedAmount then
                DBG.Error('Seed config is missing or invalid.')
                return
            end

            local seedCount = exports.vorp_inventory:getItemCount(src, nil, plantCfg.seedName)
            if seedCount < plantCfg.seedAmount then
                DBG.Error("Player doesn't have enough seeds")
                Core.NotifyRightTip(src, _U('noSeed'), 4000)
                return
            end
            DBG.Success("Seed check passed")

            -- Remove Seeds and Soil
            DBG.Info("Removing seeds and soil from inventory...")
            exports.vorp_inventory:closeInventory(src)
            exports.vorp_inventory:subItem(src, plantCfg.seedName, plantCfg.seedAmount)
            if plantCfg.soilRequired then
                exports.vorp_inventory:subItem(src, plantCfg.soilName, plantCfg.soilAmount)
            end
            DBG.Success("Seeds and soil (if required) removed")

            -- Find Best Fertilizer
            DBG.Info("Finding best fertilizer...")
            local bestFertilizer = nil
            for _, fert in pairs(Config.fertilizerSetup) do
                local fertCount = exports.vorp_inventory:getItemCount(src, nil, fert.fertName)
                if fertCount > 0 and (not bestFertilizer or fert.fertTimeReduction > bestFertilizer.fertTimeReduction) then
                    bestFertilizer = fert
                end
            end

            if bestFertilizer then
                DBG.Info("Best fertilizer found: " .. bestFertilizer.fertName)
            else
                DBG.Info("No suitable fertilizer found")
            end

            -- Trigger Planting Event
            DBG.Info("Triggering planting event...")
            TriggerClientEvent('bcc-farming:PlantingCrop', src, plantCfg, bestFertilizer)
        end)
    end
end)
