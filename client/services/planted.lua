local Crops = {}

---@param plantId integer
---@param plantData table
---@param plantCoords vector3
---@param timeLeft integer --May be nil if called from addplant event only used in neew client connected event
---@param watered boolean --Boolean string
---@param source integer
RegisterNetEvent('bcc-farming:PlantPlanted', function(plantId, plantData, plantCoords, timeLeft, watered, source)
    local plantObj = BccUtils.Objects:Create(plantData.plantProp, plantCoords.x, plantCoords.y, plantCoords.z, GetEntityHeading(PlayerPedId()), false, 'standard')
    plantObj:PlaceOnGround(true)
    if plantData.plantOffset ~= 0 then
        SetEntityCoords(plantObj:GetObj(), plantCoords.x, plantCoords.y, plantCoords.z - plantData.plantOffset, false, false, false, true)
    end

    Crops[plantId] = { plantId = plantId, removePlant = false, watered = tostring(watered)}
    local blip = nil
    if Config.plantSetup.blips then -- Make a check on server to only have blip show for planter not everyone otherwise blips would be for everyone if its not locked to planter
        if GetPlayerServerId(PlayerPedId()) == source then -- Only show blip for planter not all clients
            blip = BccUtils.Blip:SetBlip(_U('plant'), 'blip_mp_spawnpoint', 0.2, plantCoords.x, plantCoords.y, plantCoords.z)
        end
    end

    local waterGroup = BccUtils.Prompt:SetupPromptGroup()
    local waterPrompt = waterGroup:RegisterPrompt(_U('useBucket'), Config.keys.water, 1, 1, true, 'hold', { timedeventhash = 'MEDIUM_TIMED_EVENT' })
    local destroyPromptWG = waterGroup:RegisterPrompt(_U('destroyPlant'), Config.keys.destroy, 1, 1, true, 'hold', { timedeventhash = 'MEDIUM_TIMED_EVENT'})
    local doWaterAnim = false -- Used to play the anim after the watered status is changed (Cant be done where serv event is triggered as you may not have the buckets this stops it from playing unless you have the buckets)
    local harvestGroup = BccUtils.Prompt:SetupPromptGroup()
    local harvestPrompt = harvestGroup:RegisterPrompt(_U('harvest'), Config.keys.harvest, 1, 1, true, 'hold', { timedeventhash = 'MEDIUM_TIMED_EVENT' })
    local destroyPromptHG = harvestGroup:RegisterPrompt(_U('destroyPlant'), Config.keys.destroy, 1, 1, true, 'hold', { timedeventhash = 'MEDIUM_TIMED_EVENT'})

    CreateThread(function() -- I normally hate doing layered threads in an event or function but this is the best way to keep the time synced with the database and accurate
        while tonumber(timeLeft) > 0 and Crops[plantId] do
            if Crops[plantId].removePlant then break end
            if Crops[plantId].watered == 'true' then
                Wait(1000)
                timeLeft = timeLeft - 1
            else
                Wait(200)
            end
        end
    end)

    while true do
        local sleep = 1000
        if Crops[plantId].removePlant then
            Crops[plantId] = false
            if Config.plantSetup.blips then
                if blip then
                    blip:Remove()
                end
            end
            plantObj:Remove() break
        end

        if tostring(Crops[plantId].watered) ~= tostring(watered) then
            watered = Crops[plantId].watered
        end

        local dist = #(GetEntityCoords(PlayerPedId()) - vector3(plantCoords.x, plantCoords.y, plantCoords.z))
        if tostring(watered) ~= 'false' then
            if doWaterAnim and Crops[plantId].watered == 'true' then
                ScenarioInPlace('WORLD_HUMAN_BUCKET_POUR_LOW', 5000)
                doWaterAnim = false
            end

            if dist <= 1.5 then
                sleep = 0
                if tonumber(timeLeft) > 0 then
                    local minutes = math.floor(timeLeft / 60)
                    local seconds = timeLeft % 60
                    harvestPrompt:EnabledPrompt(false)
                    harvestGroup:ShowGroup(_U('plant') .. ' ' .. plantData.plantName..' | ' .. _U('secondsUntilharvest')..string.format('%02d:%02d', minutes, seconds))
                elseif tonumber(timeLeft) <= 0 then
                    harvestPrompt:EnabledPrompt(true)
                    harvestGroup:ShowGroup(_U('plant') .. ' ' .. plantData.plantName..' ' .. _U('secondsUntilharvestOver'))
                    if harvestPrompt:HasCompleted() then
                        for _, reward in pairs(plantData.rewards) do
                            local canCarry = VORPcore.Callback.TriggerAwait('bcc-farming:CanCarryCheck', reward.itemName, reward.amount)
                            if canCarry then
                                PlayAnim('mech_pickup@plant@berries', 'base', 2500)
                                if blip then
                                    blip:Remove()
                                end
                                VORPcore.NotifyRightTip(_U('harvested'), 4000)
                                TriggerServerEvent('bcc-farming:HarvestPlant', plantId, plantData, false)
                            else
                                VORPcore.NotifyRightTip(_U('noCarry'), 4000)
                                break
                            end
                        end
                    end
                end
                if destroyPromptHG:HasCompleted() then
                    if blip then
                        blip:Remove()
                    end
                    PlayAnim('amb_camp@world_camp_fire@stomp@male_a@wip_base', 'wip_base', 10000)
                    TriggerServerEvent('bcc-farming:HarvestPlant', plantId, plantData, true)
                end
            end
        else
            if dist <= 1.5 and tostring(watered) == 'false' then
                sleep = 0
                local isRaining = GetRainLevel()
                if isRaining > 0 then
                    Crops[plantId].watered = 'true'
                    TriggerServerEvent('bcc-farming:UpdatePlantWateredStatus', plantId, isRaining)
                else
                    waterGroup:ShowGroup(_U('waterPlant'))
                    if waterPrompt:HasCompleted() then
                        doWaterAnim = true
                        TriggerServerEvent('bcc-farming:UpdatePlantWateredStatus', plantId, isRaining)
                    end
                    if destroyPromptWG:HasCompleted() then
                        if blip then
                            blip:Remove()
                        end
                        PlayAnim('amb_camp@world_camp_fire@stomp@male_a@wip_base', 'wip_base', 10000)
                        TriggerServerEvent('bcc-farming:HarvestPlant', plantId, plantData, true)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

---@param plantId integer
RegisterNetEvent('bcc-farming:RemovePlantClient', function(plantId)
    if Crops[plantId] then
        Crops[plantId].removePlant = true
    end
end)

---@param plantId integer
RegisterNetEvent('bcc-farming:UpdatePlantWateredStatus', function (plantId)
    if Crops[plantId] then
        Crops[plantId].watered = 'true'
    end
end)