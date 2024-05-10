local plantsPlantedOnClient = {}

---@param plantId integer
---@param plandData table
---@param plantCoords vector3
---@param timeLeft integer --May be nil if called from addplant event only used in neew client connected event
---@param watered boolean --Boolean string
---@param source integer
RegisterNetEvent('bcc-farming:PlantPlanted', function(plantId, plandData, plantCoords, timeLeft, watered, source)
    local plantObj = BccUtils.Objects:Create(plandData.plantProp, plantCoords.x, plantCoords.y, plantCoords.z, 0, false, 'standard')

    plantObj:PlaceOnGround(true)
    if plandData.plantOffset ~= 0 then
        SetEntityCoords(plantObj:GetObj(), plantCoords.x, plantCoords.y, plantCoords.z - plandData.plantOffset)
    end

    plantsPlantedOnClient[plantId] = { plantId = plantId, removePlant = false, watered = tostring(watered)}
    local blip = nil
    if Config.plantSetup.blips then -- Make a check on server to only have blip show for planter not everyone otherwise blips would be for everyone if its not locked to planter
        if GetPlayerServerId(PlayerId()) == source then -- Only show blip for planter not all clients
            blip = BccUtils.Blip:SetBlip(_U("plant"), "blip_mp_spawnpoint", 0.2, plantCoords.x, plantCoords.y, plantCoords.z)
        end
    end

    local promptGroup = BccUtils.Prompt:SetupPromptGroup()
    local firstPrompt = promptGroup:RegisterPrompt(_U("yes"), 0x4CC0E2FE, 1, 1, true, 'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    local waterPromptGroupDestroyPlant = promptGroup:RegisterPrompt(_U("destroyPlant"), 0x27D1C284, 1, 1, true, 'hold', { timedeventhash = "MEDIUM_TIMED_EVENT"})
    local doWaterAnim = false -- Used to play the anim after the watered status is changed (Cant be done where serv event is triggered as you may not have the buckets this stops it from playing unless you have the buckets)
    local harvestPromptGroup = BccUtils.Prompt:SetupPromptGroup()
    local harvestPrompt = harvestPromptGroup:RegisterPrompt(_U("harvest"), 0x4CC0E2FE, 1, 1, true, 'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    local harvestPromptGroupDestroyPlant = harvestPromptGroup:RegisterPrompt(_U("destroyPlant"), 0x27D1C284, 1, 1, true, 'hold', { timedeventhash = "MEDIUM_TIMED_EVENT"})

    CreateThread(function() -- I normally hate doing layered threads in an event or function but this is the best way to keep the time synced with the database and accurate
        while tonumber(timeLeft) > 0 and plantsPlantedOnClient[plantId] do
            if plantsPlantedOnClient[plantId].removePlant then break end
            if plantsPlantedOnClient[plantId].watered == "true" then
                Wait(1000)
                timeLeft = timeLeft - 1
            else
                Wait(200)
            end
        end
    end)

    while true do
        Wait(5)
        if plantsPlantedOnClient[plantId].removePlant then
            plantsPlantedOnClient[plantId] = false
            if Config.plantSetup.blips then
                if blip then
                    blip:Remove()
                end
            end
            plantObj:Remove() break
        end

        if tostring(plantsPlantedOnClient[plantId].watered) ~= tostring(watered) then
            watered = plantsPlantedOnClient[plantId].watered
        end

        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(plantCoords.x, plantCoords.y, plantCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)
        if tostring(watered) ~= "false" then
            if doWaterAnim and plantsPlantedOnClient[plantId].watered == "true" then
                ScenarioInPlace('WORLD_HUMAN_BUCKET_POUR_LOW', 5000)
                doWaterAnim = false
            end
            if dist < 50 then
                if dist < 5 then
                    if tonumber(timeLeft) > 0 then
                        local minutes = math.floor(timeLeft / 60)
                        local seconds = timeLeft % 60
                        DrawText3D(plantCoords.x, plantCoords.y, plantCoords.z, _U("secondsUntilharvest") .. string.format("%02d:%02d", minutes, seconds))
                    end
                    if dist < 1 then
                        harvestPromptGroup:ShowGroup(_U("plant") .. " " .. plandData.plantName)
                        if harvestPrompt:HasCompleted() then
                            if tonumber(timeLeft) <= 0 then
                                PlayAnim("mech_pickup@plant@berries", "base", 2500)
                                if blip then
                                    blip:Remove()
                                end
                                VORPcore.NotifyRightTip(_U("harvested"), 4000)
                                TriggerServerEvent("bcc-farming:HarvestPlant", plantId, plandData)
                            else
                                VORPcore.NotifyRightTip(_U("plantNotGrown"), 4000)
                            end
                        end
                        if harvestPromptGroupDestroyPlant:HasCompleted() then
                            if blip then
                                blip:Remove()
                            end
                            PlayAnim("amb_camp@world_camp_fire@stomp@male_a@wip_base", "wip_base", 10000)
                            TriggerServerEvent('bcc-farming:HarvestPlant', plantId, plandData, true)
                        end
                    end
                end
            else
                Wait(1000)
            end
        else
            if dist < 50 then
                if dist < 1 then
                    local isRaining = GetRainLevel() > 0
                        if isRaining and tostring(watered) == "false" then
                            plantsPlantedOnClient[plantId].watered = "true"
                            TriggerServerEvent("qc-farming:UpdatePlantWateredStatus", plantId)
                        elseif tostring(watered) == "false" and dist < 1 then
                            promptGroup:ShowGroup(_U("waterPlant"))
                                if firstPrompt:HasCompleted() then
                                    doWaterAnim = true
                                    TriggerServerEvent("qc-farming:UpdatePlantWateredStatus", plantId)
                                end
                            if waterPromptGroupDestroyPlant:HasCompleted() then
                                if blip then
                                    blip:Remove()
                            end
                            PlayAnim("amb_camp@world_camp_fire@stomp@male_a@wip_base", "wip_base", 10000)
                            TriggerServerEvent('qc-farming:HarvestPlant', plantId, plandData, true)
                    end
                end
            else
                Wait(1000)
            end
        end
    end
end
end)

---@param plantId integer
RegisterNetEvent('bcc-farming:RemovePlantClient', function(plantId)
    if plantsPlantedOnClient[plantId] then
        plantsPlantedOnClient[plantId].removePlant = true
    end
end)

---@param plantId integer
RegisterNetEvent("bcc-farming:UpdatePlantWateredStatus", function (plantId)
    if plantsPlantedOnClient[plantId] then
        plantsPlantedOnClient[plantId].watered = "true"
    end
end)
