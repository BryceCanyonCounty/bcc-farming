local WaterPrompt, DestroyPromptWG
local WaterGroup = GetRandomIntInRange(0, 0xffffff)

local HarvestPrompt, DestroyPromptHG
local HarvestGroup = GetRandomIntInRange(0, 0xffffff)

local PromptsStarted = false
local Crops = {}

local function StartPrompts()
    WaterPrompt = PromptRegisterBegin()
    PromptSetControlAction(WaterPrompt, Config.keys.water)
    PromptSetText(WaterPrompt, CreateVarString(10, 'LITERAL_STRING', _U('useBucket')))
    PromptSetVisible(WaterPrompt, true)
    PromptSetEnabled(WaterPrompt, true)
    PromptSetHoldMode(WaterPrompt, 2000)
    PromptSetGroup(WaterPrompt, WaterGroup, 0)
    PromptRegisterEnd(WaterPrompt)

    DestroyPromptWG = PromptRegisterBegin()
    PromptSetControlAction(DestroyPromptWG, Config.keys.destroy)
    PromptSetText(DestroyPromptWG, CreateVarString(10, 'LITERAL_STRING', _U('destroyPlant')))
    PromptSetVisible(DestroyPromptWG, true)
    PromptSetEnabled(DestroyPromptWG, true)
    PromptSetHoldMode(DestroyPromptWG, 2000)
    PromptSetGroup(DestroyPromptWG, WaterGroup, 0)
    PromptRegisterEnd(DestroyPromptWG)

    HarvestPrompt = PromptRegisterBegin()
    PromptSetControlAction(HarvestPrompt, Config.keys.harvest)
    PromptSetText(HarvestPrompt, CreateVarString(10, 'LITERAL_STRING', _U('harvest')))
    PromptSetVisible(HarvestPrompt, true)
    PromptSetEnabled(HarvestPrompt, true)
    PromptSetHoldMode(HarvestPrompt, 2000)
    PromptSetGroup(HarvestPrompt, HarvestGroup, 0)
    PromptRegisterEnd(HarvestPrompt)

    DestroyPromptHG = PromptRegisterBegin()
    PromptSetControlAction(DestroyPromptHG, Config.keys.destroy)
    PromptSetText(DestroyPromptHG, CreateVarString(10, 'LITERAL_STRING', _U('destroyPlant')))
    PromptSetVisible(DestroyPromptHG, true)
    PromptSetEnabled(DestroyPromptHG, true)
    PromptSetHoldMode(DestroyPromptHG, 2000)
    PromptSetGroup(DestroyPromptHG, HarvestGroup, 0)
    PromptRegisterEnd(DestroyPromptHG)

    PromptsStarted = true
end

RegisterNetEvent('bcc-farming:PlantPlanted', function(plantId, plantData, plantCoords, timeLeft, watered, source)
    local hash = joaat(plantData.plantProp)
    RequestModel(hash, false)
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    local plantObj = Citizen.InvokeNative(0x509D5878EB39E842, hash, plantCoords.x, plantCoords.y, plantCoords.z - plantData.plantOffset, false, false, false, false, false) -- CreateObject
    SetEntityHeading(plantObj, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(plantObj, true)
    FreezeEntityPosition(plantObj, true)

    Crops[plantId] = { plantId = plantId, removePlant = false, watered = tostring(watered)}

    local blip = nil
    if Config.plantSetup.blips.enabled then
        if GetPlayerServerId(PlayerId()) == source then -- Only show blip for planter not all clients
            blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, plantCoords.x, plantCoords.y, plantCoords.z) -- BlipAddForCoords
            SetBlipSprite(blip, joaat(Config.plantSetup.blips.sprite), true)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.plantSetup.blips.name) -- SetBlipName
            Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(Config.BlipColors[Config.plantSetup.blips.color])) -- BlipAddModifier
        end
    end

    if not PromptsStarted then
        StartPrompts()
    end

    CreateThread(function() -- keep the time synced with the database
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
            if blip then
                RemoveBlip(blip)
            end
            DeleteObject(plantObj)
            break
        end

        if tostring(Crops[plantId].watered) ~= tostring(watered) then
            watered = Crops[plantId].watered
        end

        local dist = #(GetEntityCoords(PlayerPedId()) - vector3(plantCoords.x, plantCoords.y, plantCoords.z))
        if tostring(watered) ~= 'false' then
            if dist <= 1.5 then
                sleep = 0

                if tonumber(timeLeft) > 0 then
                    local minutes = math.floor(timeLeft / 60)
                    local seconds = timeLeft % 60
                    PromptSetEnabled(HarvestPrompt, false)
                    local noHarvest = _U('plant') .. ': ' .. plantData.plantName..' | ' .. _U('secondsUntilharvest')..string.format('%02d:%02d', minutes, seconds)
                    PromptSetActiveGroupThisFrame(HarvestGroup, CreateVarString(10, 'LITERAL_STRING', noHarvest), 1, 0, 0, 0)

                elseif tonumber(timeLeft) <= 0 then
                    PromptSetEnabled(HarvestPrompt, true)
                    local harvest = _U('plant') .. ': ' .. plantData.plantName..' ' .. _U('secondsUntilharvestOver')
                    PromptSetActiveGroupThisFrame(HarvestGroup, CreateVarString(10, 'LITERAL_STRING', harvest), 1, 0, 0, 0)

                    if Citizen.InvokeNative(0xE0F65F0640EF0617, HarvestPrompt) then  -- PromptHasHoldModeCompleted
                        local canHarvest = VORPcore.Callback.TriggerAwait('bcc-farming:HarvestCheck', plantId, plantData, false)
                        if canHarvest then
                            PlayAnim('mech_pickup@plant@berries', 'base', 2500)
                            if blip then
                                RemoveBlip(blip)
                            end
                        end
                    end
                end

                if Citizen.InvokeNative(0xE0F65F0640EF0617, DestroyPromptHG) then  -- PromptHasHoldModeCompleted
                    if blip then
                        RemoveBlip(blip)
                    end
                    PlayAnim('amb_camp@world_camp_fire@stomp@male_a@wip_base', 'wip_base', 8000)
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
                    PromptSetActiveGroupThisFrame(WaterGroup, CreateVarString(10, 'LITERAL_STRING', _U('waterPlant')), 1, 0, 0, 0)
                    if Citizen.InvokeNative(0xE0F65F0640EF0617, WaterPrompt) then  -- PromptHasHoldModeCompleted
                        local hasWaterBucket = VORPcore.Callback.TriggerAwait('bcc-farming:CheckHasItem', Config.fullWaterBucket, 1)
                        if hasWaterBucket then
                            ScenarioInPlace('WORLD_HUMAN_BUCKET_POUR_LOW', 5000)
                            TriggerServerEvent('bcc-farming:UpdatePlantWateredStatus', plantId, isRaining)
                        else
                            VORPcore.NotifyRightTip(_U('noWaterBucket'), 4000)
                        end
                    end

                    if Citizen.InvokeNative(0xE0F65F0640EF0617, DestroyPromptWG) then  -- PromptHasHoldModeCompleted
                        if blip then
                            RemoveBlip(blip)
                        end
                        PlayAnim('amb_camp@world_camp_fire@stomp@male_a@wip_base', 'wip_base', 8000)
                        TriggerServerEvent('bcc-farming:HarvestPlant', plantId, plantData, true)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('bcc-farming:RemovePlantClient', function(plantId)
    if Crops[plantId] then
        Crops[plantId].removePlant = true
    end
end)

RegisterNetEvent('bcc-farming:UpdatePlantWateredStatus', function (plantId)
    if Crops[plantId] then
        Crops[plantId].watered = 'true'
    end
end)
