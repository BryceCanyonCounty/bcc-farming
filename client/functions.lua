------ Pulling Essentials ------------
VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

BccUtils = exports['bcc-utils'].initiate()

---------- Main Watering Plant Setup ------------
RegisterNetEvent('bcc-farming:WaterPlantMain')
AddEventHandler('bcc-farming:WaterPlantMain', function(plantcoords, v, object, plantid)
    local blip --creates a variable for the blip to set on and be removed later o
    local PromptGroup2 = BccUtils.Prompts:SetupPromptGroup()
    local firstprompt2 = PromptGroup2:RegisterPrompt(Config.Language.WaterCropPrompt, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
    if Config.PlantBlips then
        blip = BccUtils.Blips:SetBlip('Your Plant', 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y, plantcoords.z)
    end
    while true do
        Wait(5)
        local plcoord2 = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y, plantcoords.z, true)
        if dist < 2 then
            PromptGroup2:ShowGroup(Config.Language.WaterCropPrompt)
            BccUtils.Misc.DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, Config.Language.WaterCropPrompt)
            if firstprompt2:HasCompleted() then
                firstprompt2:DeletePrompt()
                TriggerServerEvent('bcc-farming:WateringBucketCheck', blip, v, plantcoords, object, plantid) break
            end
        elseif dist > 200 then
            Wait(2000)
        end
    end
end)

RegisterNetEvent('bcc-farming:WaterCrop', function(type, blip, v, plantcoords, object, plantid)
    if type == 'water' then
        TriggerServerEvent('bcc-farming:watereddbset', plantid)
        ScenarioInPlace('WORLD_HUMAN_BUCKET_POUR_LOW', 7000)
        TriggerServerEvent('bcc-farming:RemoveWaterBucket')
        VORPcore.NotifyRightTip(Config.Language.CropWatered, 4000)
        type = 'fert'
    end
    
    if type == 'fert' then
        local PromptGroup2 = BccUtils.Prompts:SetupPromptGroup()
        local firstprompt2 = PromptGroup2:RegisterPrompt(Config.Language.PlantWithFertilizer, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
        local firstprompt3 = PromptGroup2:RegisterPrompt(Config.Language.DoNotUseFertilizer, 0xCEFD9220, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
        if v.FertTimeRemove > 0 then
            while true do
                Wait(5)
                local plcoord2 = GetEntityCoords(PlayerPedId())
                local dist = GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y, plantcoords.z, true)
                if dist < 2 then
                    BccUtils.Misc.DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, Config.Language.UseFert)
                    PromptGroup2:ShowGroup(Config.Language.UseFert)
                    if firstprompt2:HasCompleted() then
                        TriggerServerEvent('bcc-farming:FertCheck', blip, v, plantcoords, object, plantid) break
                    end
                    if firstprompt3:HasCompleted() then
                        TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v.TimetoGrow, v, plantcoords, object, plantid) break
                    end
                elseif dist > 200 then
                    Wait(2000)
                end
            end
        end
    end

    if v.FertTimeRemove <= 0 then
        TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v.TimetoGrow, v, plantcoords, object, plantid)
    end
end)


RegisterNetEvent('bcc-farming:WaitUntilHarvest')
AddEventHandler('bcc-farming:WaitUntilHarvest', function(blip, timer, v, plantcoords, object, plantid)
    local dbcatch = timer --this is used to detect how long it has been since last back up
    local PromptGroup = BccUtils.Prompts:SetupPromptGroup()
    local firstprompt = PromptGroup:RegisterPrompt(Config.Language.HarvestPrompt, 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"})
    while true do
        Wait(5)
        local plcoord2 = GetEntityCoords(PlayerPedId())
        ------TIMER SETUP ------
        timer = timer - 20 --Timer outside of if so the number goes down regardless of if your close or not. Set to minus 20(closest to a full minute as can get) every time this is run as this code runs once every 10ms had to move this out of the if dist statement, timer would only go down if you were close
        --this will detect when the player leaves and trigger the server event to update the timer db entry for the plant id
        if timer == dbcatch - 40000 then --if the timer is 20,000 (20 seconds) less than it was originally then
            dbcatch = dbcatch - 40000 --change the var too var - 20000 so this can run again 20 seconds later
            TriggerServerEvent('bcc-farming:LeftGameDBUpdate', plantid, timer) --triggers the server event and passes the plant id and timer(time left) to database
        elseif timer <= 0 then --if the timer is less than or equal to 0 then end(this saves resources)
        end
        local dist = GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y, plantcoords.z, true)
        if dist < 2 then
            if timer > 0 then --if the timer is more than 0 then (if the timer hasnt reached 0 yet)
                local roundedtimer = timer / 60000 --Divides timer by 60000 which is one minute
                local roundedtimer2 = (math.floor(roundedtimer * 100) / 100) --round roundedtimer so it looks prettier
                --This function will trigger if the player leaves the game and if so then11
                BccUtils.Misc.DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, tostring(roundedtimer2) .. ' ' .. Config.Language.TimerText) --creates the text at the plants coords
            elseif timer <= 0 then --elseif the timer is less than or is 0 then (if the timer has finished/ has reached 0)
                BccUtils.Misc.DrawText3D(plantcoords.x, plantcoords.y, plantcoords.z, Config.Language.ReadytoHarvest)
                PromptGroup:ShowGroup(Config.Language.HarvestPrompt)
                if firstprompt:HasCompleted() then
                    firstprompt:DeletePrompt()
                    VORPcore.NotifyRightTip(Config.Language.Harvestingcrop, 10000)
                    ScenarioInPlace('WORLD_HUMAN_CROUCH_INSPECT', 10000)
                    DeleteObject(object)
                    if Config.PlantBlips then
                        BccUtils.Blips.RemoveBlip(blip.rawblip)
                    end
                    TriggerServerEvent('bcc-farming:RemoveDBRow', plantid)
                    TriggerServerEvent('bcc-farming:CropHarvested', v.HarvestItem, v.HarvestAmount) break
                end
            end
        elseif dist > 200 then
            Wait(2000)
        end
    end
end)

----- Is any plant near ped -----
function IsAnyPlantPropNearPed()
    local pl = PlayerPedId()
    for k,v in pairs(Config.Farming) do
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(pl, 0.0, 2.5, 0))
        local Entity = (GetClosestObjectOfType(x,y,z, 2.5, joaat(v.PlantProp), false, false, false))
        if Entity ~= 0 then
            return true
        end
    end
    return false
end

--- Function for playing task scenarion in place for player
function ScenarioInPlace(hash, time)
    local pl = PlayerPedId()
    FreezeEntityPosition(pl, true)
    TaskStartScenarioInPlace(pl, joaat(hash), time, true, false, false, false)
    Wait(time)
    ClearPedTasksImmediately(pl)
    FreezeEntityPosition(pl, false)
end