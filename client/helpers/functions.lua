VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()

---@param hash string
---@param time integer --Milliseconds
function ScenarioInPlace(hash, time)
    local playerPed = PlayerPedId()
    FreezeEntityPosition(playerPed, true)
    TaskStartScenarioInPlace(playerPed, joaat(hash), time, true, false, false, false)
    Wait(time)
    ClearPedTasksImmediately(playerPed)
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
        ClearPedTasksImmediately(playerPed)
    else
        Wait(time)
        ClearPedTasksImmediately(playerPed)
    end
end
