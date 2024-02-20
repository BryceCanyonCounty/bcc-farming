---@param plantData table
---@param fertCount number
RegisterNetEvent('bcc-farming:PlantingCrop', function(plantData, fertCount)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local stop = false
    for e, a in pairs(Config.plantSetup.plants) do
        local entity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 2.5, joaat(a.plantProp), false, false, false)
        if entity ~= 0 then
            stop = true
            VORPcore.NotifyRightTip(_U("tooCloseToAnotherPlant"), 4000) break
        end
    end
    if not stop then
        VORPcore.NotifyRightTip(_U("raking"), 16000)
        PlayAnim("amb_work@world_human_farmer_rake@male_a@idle_a", "idle_a", 16000, true, true)
        VORPcore.NotifyRightTip(_U("plantingDone"), 16000)
        if not IsEntityDead(PlayerPedId()) then
            local PromptGroup = BccUtils.Prompt:SetupPromptGroup()
            local firstprompt = PromptGroup:RegisterPrompt(_U("yes"), 0x4CC0E2FE, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
            local secondprompt = PromptGroup:RegisterPrompt(_U("no"), 0x9959A6F0, 1, 2, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
            local fertilized = false
            while true do
                Wait(5)
                local newPlayerCoords = GetEntityCoords(PlayerPedId())
                if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, newPlayerCoords.x, newPlayerCoords.y, newPlayerCoords.z, true) < 3 then
                    PromptGroup:ShowGroup(_U("fertilize"))
                    if firstprompt:HasCompleted() then
                        if fertCount > 0 then
                            fertilized = true
                            plantData.timeToGrow = plantData.timeToGrow - plantData.fertTimeReduction break
                        else
                            VORPcore.NotifyRightTip(_U("noFert"), 4000) break
                        end
                    end
                    if secondprompt:HasCompleted() then
                        break
                    end
                end
            end

            TriggerServerEvent('bcc-farming:AddPlant', plantData, GetEntityCoords(PlayerPedId()), fertilized)
        else
            VORPcore.NotifyRightTip(_U("failed"), 4000)
        end
    end
end)