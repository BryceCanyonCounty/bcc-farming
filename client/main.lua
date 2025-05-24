VORPcore = exports.vorp_core:GetCore()

RegisterNetEvent('vorp:SelectedCharacter', function()
    TriggerServerEvent('bcc-farming:NewClientConnected')
end)

function ScenarioInPlace(hash, time)
    local playerPed = PlayerPedId()
    FreezeEntityPosition(playerPed, true)
    TaskStartScenarioInPlace(playerPed, joaat(hash), time, true, false, false, false)
    Wait(time)
    ClearPedTasks(playerPed)
    Wait(4000)
    HidePedWeapons(playerPed, 2, true)
    FreezeEntityPosition(playerPed, false)
end

function PlayAnim(animDict, animName, time, raking, loopUntilTimeOver) --function to play an animation
    local animTime = time
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    local flag = 16
    -- if time is -1 then play the animation in an infinite loop which is not possible with flag 16 but with 1
    -- if time is -1 the caller has to deal with ending the animation by themselve
    if loopUntilTimeOver then
        flag = 1
        animTime = -1
    end

    local playerPed = PlayerPedId()
    TaskPlayAnim(playerPed, animDict, animName, 1.0, 1.0, animTime, flag, 0, true, 0, false, 0, false)
    if raking then
        local playerCoords = GetEntityCoords(playerPed)
        local rakeObj = CreateObject('p_rake02x', playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
        AttachEntityToEntity(rakeObj, playerPed, GetEntityBoneIndexByName(playerPed, 'PH_R_Hand'), 0.0, 0.0, 0.19,
            0.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)
        Wait(time)
        DeleteObject(rakeObj)
    else
        Wait(time)
    end
    ClearPedTasks(playerPed)
end

RegisterNetEvent('bcc-farming:ShowSmellingPlants', function(smellingPlants)
    for _, plant in pairs(smellingPlants) do
        print('Showing smelling plant:', plant.plantName, 'at coords:', plant.coords.x, plant.coords.y, plant.coords.z)
        -- TriggerEvent("rsd_notify:NotifLeftAdvanced", "Spürnase", _U('SmellPlant'), "toast_awards_set_d", "awards_set_d_001", 5000)
        VORPcore.NotifyRightTip(_U('SmellPlant'), 5000)
        if Config.SmellingPlantBlips then
            local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, plant.coords.x, plant.coords.y, plant.coords.z)
            SetBlipSprite(blip, joaat('BLIP_AMBIENT_SMELL'), true)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Riechbare Pflanze: ' .. plant.plantName)
            Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(Config.BlipColors.RED))
            Wait(5000) -- Remove Blip after 5 Seconds
            RemoveBlip(blip)
        end
        
    end
end)

-- Trigger  Server-Logic for distance check
CreateThread(function()
    while true do
        Wait(5000) -- Alle 5 Sekunden prüfen
        local playerCoords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('bcc-farming:DetectSmellingPlants', playerCoords)
    end
end)
