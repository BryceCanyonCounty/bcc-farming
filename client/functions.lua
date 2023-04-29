-- Pulls vorp core, and utils for the notify
VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

-------------------------------- 3D Text Setup ----------------------------------------------------
function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
	  SetTextScale(0.30, 0.30)
	  SetTextFontForCurrentCommand(1)
	  SetTextColor(255, 255, 255, 215)
	  SetTextCentre(1)
	  DisplayText(str,_x,_y)
	  local factor = (string.len(text)) / 225
	  DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
	end
end

RegisterNetEvent('bcc-farming:WaterPlantMain')
AddEventHandler('bcc-farming:WaterPlantMain', function(plantcoords, timer, reward, amount, object, plantid, ferttime, fertitem)
    local blip --creates a variable for the blip to set on and be removed later o
    local PromptGroup2 = VORPutils.Prompts:SetupPromptGroup() --registers a prompt group using vorp_utils
    local firstprompt2 = PromptGroup2:RegisterPrompt(Config.Language.WaterCropPrompt, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
    if Config.PlantBlips == true then --if you have blips set true in config
        blip = VORPutils.Blips:SetBlip('Your Plant', 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y, plantcoords.z) --Sets blip variable to have a blip
    end
    while true do --creates a while true do loop
        Citizen.Wait(10) --Prevents crashing
        local plcoord2 = GetEntityCoords(PlayerPedId()) --gets the players coords once everytime the loop is ran
        if GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y, plantcoords.z, true) < 2 then --Gets the distance between the player and the plant
        ---------------------TIMER SETUP / WATER CROP PROMPT SETUP / HARVEST PROMPT SETUP----------------------------
            PromptGroup2:ShowGroup(Config.Language.WaterCropPrompt) --shows the 2nd prompt group
            DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, Config.Language.WaterCropPrompt) --draws text saying to water crop
            if firstprompt2:HasCompleted() then --if you do  the prompt then
                firstprompt2:DeletePrompt() --delets the prompt group once you water the plant
                TriggerServerEvent('bcc-farming:WateringBucketCheck', blip, timer, reward, amount, plantcoords, object, plantid, ferttime, fertitem) break --triggers the server event to check if you have the watering item
            end
        end
    end
end)

RegisterNetEvent('bcc-farming:WaterCrop') --registers a client event for the above server event to trigger
AddEventHandler('bcc-farming:WaterCrop', function(type, blip, timer, reward, amount, plantcoords, object, plantid, fertime, fertitem) --makes the event have code and catches the hadbucket variable from the server
    if type == 'water' then
        TriggerServerEvent('bcc-farming:watereddbset', plantid)
        FreezeEntityPosition(PlayerPedId(), true) --freezes player
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_POUR_LOW'), 7000, true, false, false, false) --plays an animation of watering the crop
        Wait(7000) --waits 7 seconds (until anim ends)
        ClearPedTasksImmediately(PlayerPedId()) --ends the animation
        FreezeEntityPosition(PlayerPedId(), false) --unfreezes player
        TriggerServerEvent('bcc-farming:RemoveWaterBucket') --Triggers server event and passes source
        VORPcore.NotifyRightTip(Config.Language.CropWatered, 4000) --places text on screen
        type = 'fert'
    end
    
    if type == 'fert' then
        local PromptGroup2 = VORPutils.Prompts:SetupPromptGroup() --registers a prompt group using vorp_utils    
        local firstprompt2 = PromptGroup2:RegisterPrompt(Config.Language.PlantWithFertilizer, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
        local firstprompt3 = PromptGroup2:RegisterPrompt(Config.Language.DoNotUseFertilizer, 0xCEFD9220, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
        if fertime > 0 then
            while true do
                Citizen.Wait(10)
                local plcoord2 = GetEntityCoords(PlayerPedId())
                if GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y, plantcoords.z, true) < 2 then --Gets the distance between the player and the plant
                    DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, Config.Language.UseFert)
                    PromptGroup2:ShowGroup(Config.Language.UseFert)
                    if firstprompt2:HasCompleted() then
                        TriggerServerEvent('bcc-farming:FertCheck', blip, timer, reward, amount, plantcoords, object, plantid, fertime, fertitem) break
                    end
                    if firstprompt3:HasCompleted() then
                        TriggerEvent('bcc-farming:WaitUntilHarvest', blip, timer, reward, amount, plantcoords, object, plantid) break
                    end
                end
            end
        end
    end

    if fertime <= 0 then
        TriggerEvent('bcc-farming:WaitUntilHarvest', blip, timer, reward, amount, plantcoords, object, plantid)
    end
end)


RegisterNetEvent('bcc-farming:WaitUntilHarvest')
AddEventHandler('bcc-farming:WaitUntilHarvest', function(blip, timer, reward, amount, plantcoords, object, plantid)
    local dbcatch = timer --this is used to detect how long it has been since last back up
    local PromptGroup = VORPutils.Prompts:SetupPromptGroup() --registers a prompt group using vorp_utils
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.HarvestPrompt, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
    while true do --creates a while true do loop
        Citizen.Wait(10) --Prevents crashing
        local plcoord2 = GetEntityCoords(PlayerPedId()) --gets the players coords once everytime the loop is ran
        ---------------------TIMER SETUP / WATER CROP PROMPT SETUP / HARVEST PROMPT SETUP----------------------------
        timer = timer - 20 --Timer outside of if so the number goes down regardless of if your close or not. Set to minus 20(closest to a full minute as can get) every time this is run as this code runs once every 10ms had to move this out of the if dist statement, timer would only go down if you were close
        --this will detect when the player leaves and trigger the server event to update the timer db entry for the plant id
        if timer == dbcatch - 40000 then --if the timer is 20,000 (20 seconds) less than it was originally then
            dbcatch = dbcatch - 40000 --change the var too var - 20000 so this can run again 20 seconds later
            TriggerServerEvent('bcc-farming:LeftGameDBUpdate', plantid, timer) --triggers the server event and passes the plant id and timer(time left) to database
        elseif timer <= 0 then --if the timer is less than or equal to 0 then end(this saves resources)
        end
        if GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y, plantcoords.z, true) < 2 then --Gets the distance between the player and the plant
            if timer > 0 then --if the timer is more than 0 then (if the timer hasnt reached 0 yet)
                local roundedtimer = timer / 60000 --Divides timer by 60000 which is one minute
                local roundedtimer2 = (math.floor(roundedtimer * 100) / 100) --round roundedtimer so it looks prettier
                --This function will trigger if the player leaves the game and if so then11
                DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, tostring(roundedtimer2) .. ' ' .. Config.Language.TimerText) --creates the text at the plants coords
            elseif timer <= 0 then --elseif the timer is less than or is 0 then (if the timer has finished/ has reached 0)
                DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, Config.Language.ReadytoHarvest) --Draws the text from config on the plant
                PromptGroup:ShowGroup(Config.Language.HarvestPrompt) --Names the prompt
                if firstprompt:HasCompleted() then --if you do the prompt then
                    firstprompt:DeletePrompt() --deletes the prompt
                    FreezeEntityPosition(PlayerPedId(), true) --freezes player
                    VORPcore.NotifyRightTip(Config.Language.Harvestingcrop, 10000) --Notifies in the right side of screen
                    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false) --Triggers an animation to play for 10 seconds
                    Wait(10000) --waits 10 seconds(until anim is over) then allows the rest of code to run
                    ClearPedTasksImmediately(PlayerPedId()) --ends the animation
                    FreezeEntityPosition(PlayerPedId(), false) --unfreezes player
                    DeleteObject(object) --deletes the object regardless of if debug is on or not
                    if Config.PlantBlips then --if you have blipsset true then
                        VORPutils.Blips.RemoveBlip(blip.rawblip) --removes the blip have to use this not just blip:RemoveBlip as that wont work
                    end
                    TriggerServerEvent('bcc-farming:RemoveDBRow', plantid) --this will trigger the server event to remove the plants row form the database
                    TriggerServerEvent('bcc-farming:CropHarvested', reward, amount) break --passes the variables back to the server to add the items to your inventory and breaks loop
                end
            end
        end
    end
end)

--function to see if player is near any placed objects listed in config
function IsAnyPlantPropNearPed()
    for k,v in pairs(Config.Farming) do
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0))
        local Entity = (GetClosestObjectOfType(x,y,z, 2.5, GetHashKey(v.PlantProp), false, false, false))
        if Entity ~= 0 then
            return true
        end
    end
    return false
end