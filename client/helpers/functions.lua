VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
BccUtils = exports['bcc-utils'].initiate()

---@param hash string
---@param time ineger --Milliseconds
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