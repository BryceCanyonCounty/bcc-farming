CreateThread(function()
    for _, plant in pairs(Plants) do
        exports.vorp_inventory:registerUsableItem(plant.seedName, function(data)
            local src = data.source
            local playerCoords = GetEntityCoords(GetPlayerPed(src))
            local allowPlant, dontAllowAgain = true, false -- dontAllowAgain is for the item count checks so if we dont have one we can set it true and keep allowPlant false

            if Config.townSetup.canPlantInTowns then
                allowPlant = true
            else
                for _, townCfg in pairs(Config.townSetup.townLocations) do
                    if #(playerCoords - townCfg.coords) <= townCfg.townRange then
                        VORPcore.NotifyRightTip(src, _U('tooCloseToTown'), 4000)
                        dontAllowAgain = true
                        allowPlant = false
                        break
                    else
                        allowPlant = true
                    end
                end
            end

            local character = VORPcore.getUser(src).getUsedCharacter
            if plant.jobLocked and not dontAllowAgain then
                local hasJob = false
                for e, u in pairs(plant.jobs) do
                    if character.job == u then
                        hasJob = true
                        dontAllowAgain = false
                        allowPlant = true
                        break
                    end
                end
                if not hasJob then
                    VORPcore.NotifyRightTip(src, _U('incorrectJob'), 4000)
                    dontAllowAgain = true
                    allowPlant = false
                end
            end
            if plant.soilRequired and not dontAllowAgain then
                local hasSoil = exports.vorp_inventory:getItemCount(src, nil, plant.soilName)
                if hasSoil >= plant.soilAmount then
                    allowPlant = true
                else
                    VORPcore.NotifyRightTip(src, _U('noSoil'), 4000)
                    dontAllowAgain = true
                    allowPlant = false
                end
            end
            if plant.plantingToolRequired and not dontAllowAgain then
                local hasPlantingTool = exports.vorp_inventory:getItemCount(src, nil, plant.plantingTool)
                if hasPlantingTool == 0 then
                    VORPcore.NotifyRightTip(src, _U('noPlantingTool'), 4000)
                    allowPlant = false
                    dontAllowAgain = true
                else
                    allowPlant = true
                end
            end

            if not dontAllowAgain then
                local allPlantsOwnedByPlayer = MySQL.query.await('SELECT * FROM bcc_farming WHERE plant_owner = @plant_owner', { ['plant_owner'] = character.charidentifier })
                if #allPlantsOwnedByPlayer >= Config.plantSetup.maxPlants then
                    VORPcore.NotifyRightTip(src, _U('maxPlantsReached'), 4000)
                    allowPlant = false -- no need to set dontAllowAgain here because this is the last check so allowPlant wont be changed again
                end
            end

            if allowPlant and not dontAllowAgain then
                -- Lower meta data in plant done event and remove items there too
                local seedCount = exports.vorp_inventory:getItemCount(src, nil, plant.seedName)
                if seedCount < plant.seedAmount then
                    VORPcore.NotifyRightTip(src, _U('noSeed'), 4000)
                    return
                else
                    exports.vorp_inventory:subItem(src, plant.seedName, plant.seedAmount)
                    exports.vorp_inventory:closeInventory(src)
                    local bestFertilizer = nil
                    for _, fert in pairs(Config.fertilizerSetup) do
                        local fertCount = exports.vorp_inventory:getItemCount(src, nil, fert.fertName)
                        if fertCount > 0 then
                            if not bestFertilizer or fert.fertTimeReduction > bestFertilizer.fertTimeReduction then
                                bestFertilizer = fert
                            end
                        end
                    end
                    TriggerClientEvent('bcc-farming:PlantingCrop', src, plant, bestFertilizer)
                end
            end
        end)
    end
end)