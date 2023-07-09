local MiniGame = exports['bcc-minigames'].initiate()
local object
local UseWagon, UsePump = false, false
------- Planting Crop Handler -------------
RegisterNetEvent('bcc-farming:plantcrop', function(v, isoutsideoftown)
    local Minigameresult
    if isoutsideoftown then
        MiniGame.Start('skillcheck', PlantingMinigame, function(result)
            print("Passed?", result.passed) -- true/false
            Minigameresult = result.passed
            if Minigameresult == true then
                VORPcore.NotifyRightTip(Config.Language.Raking, 16000)
                ScenarioInPlace('WORLD_HUMAN_FARMER_RAKE', 12000)
                Wait(1000)
                VORPcore.NotifyRightTip(Config.Language.Weeding, 16000)
                ScenarioInPlace('WORLD_PLAYER_DYNAMIC_KNEEL', 8000)
                VORPcore.NotifyRightTip(Config.Language.PlantFinished, 16000)

                local plcoord = GetEntityCoords(PlayerPedId())
                object = CreateObject(v.PlantProp, plcoord.x, plcoord.y, plcoord.z, true, false, false)
                Citizen.InvokeNative(0x9587913B9E772D29, object, true)
                local plantcoords = GetEntityCoords(object)
                TriggerServerEvent('bcc-farming:dbinsert', v, plantcoords, object, isoutsideoftown)
            else
                VORPcore.NotifyRightTip(Config.Language.MessedUp, 4000)
            end
        end)
    else
        VORPcore.NotifyRightTip(Config.Language.Tooclosetotown, 4000)
    end
end)

---------- Load Plants on char selection -----------------
RegisterNetEvent('vorp:SelectedCharacter')
AddEventHandler('vorp:SelectedCharacter', function()
    TriggerServerEvent('bcc-farming:loadplants')
end)

------------ Load plants after char select -------------------
RegisterNetEvent('bcc-farming:clientspawnplantsinitload')
AddEventHandler('bcc-farming:clientspawnplantsinitload', function(HasPlants)
    for k, v in pairs(HasPlants) do
        local blip, table, plantcoords
        for e, a in pairs(Config.Farming) do
            if a.Type == v['planttype'] then
                table = a
            end
        end
        local coords = json.decode(v['plantcoords'])

        if v['watered'] and v['fertilized'] and v['trimmed'] == 'true' then
            object = CreateObject(v['prop'], coords.x, coords.y, coords.z, true, false, false)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true)
            plantcoords = GetEntityCoords(object)
            if Config.PlantBlips then
                blip = VORPutils.Blips:SetBlip('Your Plant', 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y,
                    plantcoords.z)
            end
            TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v['timeleft'], table, plantcoords, object, v['plantid'],
                true, true)
        elseif v['watered'] and v['fertilized'] == 'true' then
            object = CreateObject(v['prop'], coords.x, coords.y, coords.z, true, false, false)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true)
            plantcoords = GetEntityCoords(object)
            if Config.PlantBlips then
                blip = VORPutils.Blips:SetBlip('Your Plant', 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y,
                    plantcoords.z)
            end
            TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v['timeleft'], table, plantcoords, object, v['plantid'],
                true, false)
        elseif v['watered'] and v['trimmed'] == 'true' then
            object = CreateObject(v['prop'], coords.x, coords.y, coords.z, true, false, false)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true)
            plantcoords = GetEntityCoords(object)
            if Config.PlantBlips then
                blip = VORPutils.Blips:SetBlip('Your Plant', 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y,
                    plantcoords.z)
            end
            TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v['timeleft'], table, plantcoords, object, v['plantid'],
                false, true)
        else
            object = CreateObject(v['prop'], coords.x, coords.y, coords.z, true, false, false)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true)
            local plantcoords = GetEntityCoords(object)
            TriggerEvent('bcc-farming:WaterPlantMain', plantcoords, table, object, v['plantid'], false)
        end
    end
end)

CreateThread(function()
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.FillBucket, 0x760A9C6F, 1, 1, true,
        'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    while true do
        Wait(5)
        for k, v in pairs(Config.pumps) do
            local playercoords = GetEntityCoords(PlayerPedId())
            local waterpump = GetClosestObjectOfType(playercoords, 2.0, joaat(v), false, false, false)
            local waterpumpcoords = GetEntityCoords(waterpump)
            local pumpdist = GetDistanceBetweenCoords(playercoords, waterpumpcoords, true)
            if 2.5 > pumpdist and not UsePump then
                PromptGroup:ShowGroup(Config.Language.FillBucket)
                if firstprompt:HasCompleted() then
                    TriggerServerEvent('bcc-farming:RefillWateringCanPump')
                    UsePump = true
                end
            end
        end
    end
end)

CreateThread(function()
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.FillWagon, 0x760A9C6F, 1, 1, true,
        'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    local secondprompt = PromptGroup:RegisterPrompt(Config.Language.FillBucket, 0x41AC83D1, 1, 1, true,
        'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    while true do
        Wait(5)
        for k, v in pairs(Config.wagons) do
            local playercoords     = GetEntityCoords(PlayerPedId())
            local waterwagon       = GetClosestVehicle(playercoords)
            local waterwagoncoords = GetEntityCoords(waterwagon)
            local wagdist          = GetDistanceBetweenCoords(playercoords, waterwagoncoords, true)
            if 2.5 > wagdist and not UseWagon then
                if GetEntityModel(waterwagon) == joaat(v) then
                    PromptGroup:ShowGroup(Config.Language.FillWagon)
                    if firstprompt:HasCompleted() then
                        TriggerServerEvent('bcc-farming:AffectWaterWagon', 'fill', v)
                        UseWagon = true
                    end
                    if secondprompt:HasCompleted() then
                        TriggerServerEvent('bcc-farming:AffectWaterWagon', 'take', v)
                        UseWagon = true
                    end
                    UseWagon = false
                end
            end
        end
    end
end)

--------------------------- Is Ped Currently In Water Check -------------------------------------------------
RegisterNetEvent('bcc-farming:PedUsingWagon', function(type)
    if type == 'fill' then
        ScenarioInPlace('WORLD_CAMP_JACK_ES_BUCKET_POUR', 7000)
    else
        ScenarioInPlace('PROP_HUMAN_PUMP_WATER', 7000)
    end
    UseWagon = false
end)

--------------------------- Is Ped Currently In Water Check -------------------------------------------------
RegisterNetEvent('bcc-farming:PedInWaterClientCatch', function(_source)
    if IsEntityInWater(PlayerPedId()) then
        ScenarioInPlace('WORLD_CAMP_JACK_ES_BUCKET_FILL', 7000)
        TriggerServerEvent('bcc-farming:RefillWateringCan', _source)
    else
        VORPcore.NotifyRightTip(Config.Language.Notinwater)
    end
end)

----------------------- Distance Check for player to town coordinates --------------------------------
RegisterNetEvent('bcc-farming:IsPLayerNearTownCheck', function(_source, v)
    local isoutsideoftown = false
    if Config.Plantintowns then
        isoutsideoftown = true
    else
        local pl2 = PlayerPedId()
        for k, e in pairs(Config.Towns) do
            local pl = GetEntityCoords(pl2)
            if #(vec2(pl.x, pl.y) - vec2(e.coordinates.x, e.coordinates.y)) > e.range then
                isoutsideoftown = true
            else
                VORPcore.NotifyRightTip(Config.Language.Tooclosetotown, 4000)
                isoutsideoftown = false
                break
            end
        end
    end
    if IsAnyPlantPropNearPed() then
        VORPcore.NotifyRightTip(Config.Language.TooCloseToPlant, 4000)
        return
    end
    if isoutsideoftown then
        TriggerServerEvent('bcc-farming:PlayerNotNearTown', _source, v, isoutsideoftown)
    end
end)
