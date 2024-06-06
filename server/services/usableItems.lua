CreateThread(function()
    for k, v in pairs(Config.plantSetup.plants) do
        exports.vorp_inventory:registerUsableItem(v.seedName, function(data)
            local _source = data.source
            local playerCoords = GetEntityCoords(GetPlayerPed(_source))
            local allowPlant, dontAllowAgain = true, false -- dontAllowAgain is for the item count checks so if we dont have one we can set it true and keep allowPlant false
            if Config.townSetup.canPlantInTowns then
                allowPlant = true
            else
                for u, e in pairs(Config.townSetup.townLocations) do
                    if #(playerCoords - e.coords) < e.townRange then
                        VORPcore.NotifyRightTip(_source, _U("tooCloseToTown"), 4000)
                        dontAllowAgain = true
                        allowPlant = false break
                    else
                        allowPlant = true
                    end
                end
            end

            local character = VORPcore.getUser(_source).getUsedCharacter
            if v.jobLocked and not dontAllowAgain then
                local hasJob = false
                for e, u in pairs(v.jobs) do
                    if character.job == u then
                        hasJob = true
                        dontAllowAgain = false
                        allowPlant = true
                        break
                    end
                end
                if not hasJob then
                    VORPcore.NotifyRightTip(_source, _U("incorrectJob"), 4000)
                    dontAllowAgain = true
                    allowPlant = false
                end
            end
            if v.soilRequired and not dontAllowAgain then
                local hasSoil = exports.vorp_inventory:getItemCount(_source, nil, v.soilName)
                if hasSoil >= v.soilAmount then
                    allowPlant = true
                else
                    VORPcore.NotifyRightTip(_source, _U("noSoil"), 4000)
                    dontAllowAgain = true
                    allowPlant = false
                end
            end
            if v.plantingToolRequired and not dontAllowAgain then
                local hasPlantingTool = exports.vorp_inventory:getItemCount(_source, nil, v.plantingTool)
                if hasPlantingTool == 0 then
                    VORPcore.NotifyRightTip(_source, _U("noPlantingTool"), 4000)
                    allowPlant = false
                    dontAllowAgain = true
                else
                    allowPlant = true
                end
            end

            if not dontAllowAgain then
                local allPlantsOwnedByPlayer = MySQL.query.await("SELECT * FROM bcc_farming WHERE plant_owner = @plant_owner", { ["plant_owner"] = character.charidentifier })
                if #allPlantsOwnedByPlayer >= Config.plantSetup.maxPlants then
                    VORPcore.NotifyRightTip(_source, _U("maxPlantsReached"), 4000)
                    allowPlant = false -- no need to set dontAllowAgain here because this is the last check so allowPlant wont be changed again
                end
            end

            if allowPlant and not dontAllowAgain then
                -- Lower meta data in plant done event and remove items there too
                local fertCount = exports.vorp_inventory:getItemCount(_source, nil, v.fertilizerName)
                local seedCount = exports.vorp_inventory:getItemCount(_source, nil, v.seedName)
                if seedCount < v.seedAmount then
                    VORPcore.NotifyRightTip(_source, _U("notEnoughSeeds"), 4000)
                    return
                else
                    exports.vorp_inventory:subItem(_source, v.seedName, v.seedAmount)
                    TriggerClientEvent('bcc-farming:PlantingCrop', _source, v, fertCount)
                end
            end
        end)
    end
end)