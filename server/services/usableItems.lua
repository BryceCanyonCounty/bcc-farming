CreateThread(function()
    for k, v in pairs(Config.plantSetup.plants) do
        VorpInv.RegisterUsableItem(v.seedName, function(data)
            local playerCoords = GetEntityCoords(GetPlayerPed(data.source))
            local allowPlant, dontAllowAgain = true, false -- dontAllowAgain is for the item count checks so if we dont have one we can set it true and keep allowPlant false
            if Config.canPlantInTowns then
                allowPlant = true
            else
                for u, e in pairs(Config.townLocations) do
                    if #(playerCoords - e.coords) < e.townRange then
                        VORPcore.NotifyRightTip(data.source, _U("tooCloseToTown"), 4000)
                        dontAllowAgain = true
                        allowPlant = false break
                    else
                        allowPlant = true
                    end
                end
            end

            local character = VORPcore.getUser(data.source).getUsedCharacter
            if v.jobLocked and not dontAllowAgain then
                for e, u in pairs(v.jobs) do
                    if character.job == u then
                        VORPcore.NotifyRightTip(data.source, _U("incorrectJob"), 4000)
                        dontAllowAgain = false
                        allowPlant = true break
                    else
                        dontAllowAgain = true
                        allowPlant = false
                    end
                end
            end
            if v.soilRequired and not dontAllowAgain then
                local hasSoil = VorpInv.getItemCount(data.source, v.soilName)
                if hasSoil >= v.soilAmount then
                    allowPlant = true
                else
                    VORPcore.NotifyRightTip(data.source, _U("noSoil"), 4000)
                    dontAllowAgain = true
                    allowPlant = false
                end
            end
            if v.plantingToolRequired and not dontAllowAgain then
                local hasPlantingTool = VorpInv.getItemCount(data.source, v.plantingTool)
                if hasPlantingTool == 0 then
                    VORPcore.NotifyRightTip(data.source, _U("noPlantingTool"), 4000)
                    allowPlant = false
                    dontAllowAgain = true
                else
                    allowPlant = true
                end
            end

            if not dontAllowAgain then
                local allPlantsOwnedByPlayer = MySQL.query.await("SELECT * FROM bcc_farming WHERE plant_owner = @plant_owner", { ["plant_owner"] = character.charidentifier })
                if #allPlantsOwnedByPlayer >= Config.plantSetup.maxPlants then
                    VORPcore.NotifyRightTip(data.source, _U("maxPlantsReached"), 4000)
                    allowPlant = false -- no need to set dontAllowAgain here because this is the last check so allowPlant wont be changed again
                end
            end

            if allowPlant and not dontAllowAgain then
                -- Lower meta data in plant done event and remove items there too
                local fertCount = VorpInv.getItemCount(data.source, v.fertilizerName)
                TriggerClientEvent('bcc-farming:PlantingCrop', data.source, v, fertCount)
            end
        end)
    end
end)