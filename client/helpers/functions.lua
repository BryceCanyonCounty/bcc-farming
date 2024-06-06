VORPcore = {}
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
BccUtils = exports['bcc-utils'].initiate()

---@param hash string
---@param time integer --Milliseconds
function ScenarioInPlace(hash, time)
  local pl = PlayerPedId()
  FreezeEntityPosition(pl, true)
  TaskStartScenarioInPlace(pl, joaat(hash), time, true, false, false, false)
  Wait(time)
  ClearPedTasksImmediately(pl)
  FreezeEntityPosition(pl, false)
end

---@param x number
---@param y number
---@param z number
---@param text string
function DrawText3D(x, y, z, text)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)

	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 223)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
end

function PlayAnim(animDict, animName, time, raking, loopUntilTimeOver) --function to play an animation
  local animTime = time
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Wait(100)
  end
  local flag = 16
  -- if time is -1 then play the animation in an infinite loop which is not possible with flag 16 but with 1
  -- if time is -1 the caller has to deal with ending the animation by themselve
  if loopUntilTimeOver then
    flag = 1
    animTime = -1
  end
  TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, animTime, flag, 0, true, 0, false, 0, false)
  if raking then
    local playerCoords = GetEntityCoords(PlayerPedId())
    local rakeObj = CreateObject("p_rake02x", playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    AttachEntityToEntity(rakeObj, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.19, 0.0, 0.0, 0.0, false, false, true, false, 0, true, false, false)
    Wait(time)
    DeleteObject(rakeObj)
    ClearPedTasksImmediately(PlayerPedId())
  else
    Wait(time)
    ClearPedTasksImmediately(PlayerPedId())
  end
end