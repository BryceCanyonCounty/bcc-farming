------ Pulling Essentials ------------
VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)
VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)
BccUtils = {}
TriggerEvent('bcc:getUtils', function(bccutils)
    BccUtils = bccutils
end)
local MiniGame = exports['bcc-minigames'].initiate()

PlantingMinigame = {
    focus = true,        -- Should minigame take nui focus (required)
    cursor = false,      -- Should minigame have cursor
    maxattempts = 1,     -- How many fail attempts are allowed before game over
    type = 'bar',        -- What should the bar look like. (bar, trailing)
    userandomkey = true, -- Should the minigame generate a random key to press?
    keytopress = 'B',    -- userandomkey must be false for this to work. Static key to press
    keycode = 66,        -- The JS keycode for the keytopress
    speed = 5,           -- How fast the orbiter grows
    strict = false       -- if true, letting the timer run out counts as a failed attempt
}

---------- Main Watering Plant Setup ------------
RegisterNetEvent('bcc-farming:WaterPlantMain')
AddEventHandler('bcc-farming:WaterPlantMain', function(plantcoords, v, object, plantid)
    local blip --creates a variable for the blip to set on and be removed later o
    local PromptGroup2 = VORPutils.Prompts:SetupPromptGroup()
    local firstprompt2 = PromptGroup2:RegisterPrompt(Config.Language.WaterCropPrompt .. v.Type, 0x760A9C6F, 1, 1, true,
        'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
    if Config.PlantBlips then
        blip = VORPutils.Blips:SetBlip('Your Plant', 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y,
            plantcoords.z)
    end
    local minigameDoneCatch = false
    while true do
        Wait(5)
        local plcoord2 = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y,
            plantcoords.z, true)
        if dist < 2 then
            if not minigameDoneCatch then
                PromptGroup2:ShowGroup(Config.Language.WaterCropPrompt)
                if firstprompt2:HasCompleted() then
                    TriggerServerEvent('bcc-farming:WateringBucketCheck')
                    Wait(250)
                    if GotBucket then
                        MiniGame.Start('skillcheck', PlantingMinigame, function(result)
                            Minigameresult = result.passed
                            print(Minigameresult)
                            if Minigameresult then
                                TriggerEvent('bcc-farming:WaterCrop', 'water', blip, v, plantcoords, object, plantid)
                                firstprompt2:DeletePrompt()
                                minigameDoneCatch = true
                            end
                        end)
                    end
                end
            end
            if minigameDoneCatch then break end
            if GetRainLevel() >= 0.5 then
                TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v.TimetoGrow, v, plantcoords, object, plantid,
                    false, true)
                TriggerServerEvent('bcc-farming:raindbset')
                break
            end
        elseif dist > 200 then
            Wait(2000)
        end
    end
end)

RegisterNetEvent('bcc-farming:GotBucket', function()
    GotBucket = true
end)

RegisterNetEvent('bcc-farming:WaterCrop', function(type, blip, v, plantcoords, object, plantid)
    local Minigameresult = false
    if type == 'water' then
        TriggerServerEvent('bcc-farming:watereddbset', plantid)
        ScenarioInPlace('WORLD_HUMAN_BUCKET_POUR_LOW', 7000)
        VORPcore.NotifyRightTip(Config.Language.CropWatered, 4000)
        type = 'fert'
    end

    if type == 'fert' then
        local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
        local firstprompt2 = PromptGroup:RegisterPrompt(Config.Language.PlantWithFertilizer, 0x760A9C6F, 1, 1, true,
            'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
        local firstprompt3 = PromptGroup:RegisterPrompt(Config.Language.DoNotUseFertilizer, 0xCEFD9220, 1, 1, true,
            'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
        if v.FertTimeRemove > 0 then
            while true do
                Wait(5)
                local plcoord2 = GetEntityCoords(PlayerPedId())
                local dist = GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y,
                    plantcoords.z, true)
                if dist < 2 then
                    PromptGroup:ShowGroup(Config.Language.UseFert .. v.Type)

                    if not Minigameresult then
                        if firstprompt2:HasCompleted() then
                            MiniGame.Start('skillcheck', PlantingMinigame, function(result)
                                Minigameresult = result.passed
                                if Minigameresult then
                                    firstprompt2:DeletePrompt()
                                    TriggerServerEvent('bcc-farming:FertCheck', blip, v, plantcoords, object, plantid,
                                        true)
                                end
                            end)
                        end
                    end
                    if firstprompt3:HasCompleted() then
                        Wait(200)
                        TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v.TimetoGrow, v, plantcoords, object, plantid,
                            false)
                        break
                    end
                elseif dist > 200 then
                    Wait(2000)
                end
            end
        end
    end

    if v.FertTimeRemove <= 0 then
        TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v.TimetoGrow, v, plantcoords, object, plantid, false, false)
    end
end)


RegisterNetEvent('bcc-farming:WaitUntilHarvest')
AddEventHandler('bcc-farming:WaitUntilHarvest',
    function(blip, timer, v, plantcoords, object, plantid, fertilized, trimed)
        local Minigameresult = false
        local dbcatch = timer --this is used to detect how long it has been since last back up
        local PromptGroup = VORPutils.Prompts:SetupPromptGroup()
        local PromptGroup2 = VORPutils.Prompts:SetupPromptGroup()
        local PromptGroup3 = VORPutils.Prompts:SetupPromptGroup()

        local firstprompt = PromptGroup:RegisterPrompt(Config.Language.HarvestPrompt .. v.Type, 0x760A9C6F, 1, 1, true,
            'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
        local secondprompt = PromptGroup2:RegisterPrompt(Config.Language.PlantWithFertilizer, 0x760A9C6F, 1, 1, true,
            'hold', { timedeventhash = "MEDIUM_TIMED_EVENT" })
        local thirdprompt = PromptGroup3:RegisterPrompt(Config.Language.TrimPlant .. v.Type, 0x760A9C6F, 1, 1, true,
            'hold',
            { timedeventhash = "MEDIUM_TIMED_EVENT" })

        while true do
            Wait(5)
            local plcoord2 = GetEntityCoords(PlayerPedId())
            ------TIMER SETUP ------
            timer = timer -
                20.5                         --Timer outside of if so the number goes down regardless of if your close or not. Set to minus 20(closest to a full minute as can get) every time this is run as this code runs once every 10ms had to move this out of the if dist statement, timer would only go down if you were close
            --this will detect when the player leaves and trigger the server event to update the timer db entry for the plant id
            if timer == dbcatch - 40000 then --if the timer is 20,000 (20 seconds) less than it was originally then
                dbcatch = dbcatch -
                    40000                    --change the var too var - 20000 so this can run again 20 seconds later
                TriggerServerEvent('bcc-farming:LeftGameDBUpdate', plantid, timer)
            elseif timer <= 0 then           --if the timer is less than or equal to 0 then end(this saves resources)
            end
            local dist = GetDistanceBetweenCoords(plcoord2.x, plcoord2.y, plcoord2.z, plantcoords.x, plantcoords.y,
                plantcoords.z, true)
            if dist < 2 then
                if timer > 0 then
                    local roundedtimer = timer /
                        60000
                    local roundedtimer2 = (math.floor(roundedtimer * 100) / 100) --round roundedtimer so it looks prettier
                    --This function will trigger if the player leaves the game and if so then11
                    if not Minigameresult then
                        if fertilized and trimed then
                            PromptGroup3:ShowGroup(tostring(roundedtimer2) ..
                                ' ' .. Config.Language.TimerText .. v.Type ..
                                [[

                                Fertilized: True
                                Trimmed: true
                                ]])
                        elseif fertilized and not trimed then
                            PromptGroup2:ShowGroup(tostring(roundedtimer2) ..
                                ' ' .. Config.Language.TimerText .. v.Type ..
                                [[

                            Fertilized: True
                            Trimmed: false
                            ]])
                        elseif trimed and not fertilized then
                            if timer > v.FertTimeRemove then
                                PromptGroup2:ShowGroup(tostring(roundedtimer2) ..
                                    ' ' .. Config.Language.TimerText .. v.Type ..
                                    [[

                                    Fertilized: false
                                    Trimmed: True
                                    ]])
                            else
                                PromptGroup:ShowGroup(tostring(roundedtimer2) ..
                                    ' ' .. Config.Language.TimerText .. v.Type ..
                                    [[

                                    Fertilized: false
                                    Trimmed: True
                                         ]])
                            end
                        else
                            PromptGroup3:ShowGroup(tostring(roundedtimer2) ..
                                ' ' .. Config.Language.TimerText .. v.Type ..
                                [[

                            Fertilized: false
                            Trimmed: false
                                 ]])
                        end

                        if secondprompt:HasCompleted() then
                            MiniGame.Start('skillcheck', PlantingMinigame, function(result)
                                Minigameresult = result.passed
                                if Minigameresult then
                                    TriggerServerEvent('bcc-farming:FertCheck', blip, v, plantcoords, object, plantid)
                                    secondprompt:DeletePrompt()
                                end
                            end)
                        end
                        if thirdprompt:HasCompleted() then
                            MiniGame.Start('skillcheck', PlantingMinigame, function(result)
                                Minigameresult = result.passed
                                if Minigameresult then
                                    TriggerServerEvent('bcc-farming:TrimPlant', blip, v, plantcoords, object, plantid,
                                        timer, fertilized)
                                    thirdprompt:DeletePrompt()
                                end
                            end)
                        end
                    end
                    --triggers the server event and passes the plant id and timer(time left) to database
                elseif timer <= 0 then --elseif the timer is less than or is 0 then (if the timer has finished/ has reached 0)
                    if fertilized and trimed then
                        PromptGroup:ShowGroup(Config.Language.HarvestPrompt ..
                            [[

                                Fertilized: True
                                Trimmed: true
                                 ]])
                    elseif fertilized and not trimed then
                        PromptGroup:ShowGroup(Config.Language.HarvestPrompt ..
                            [[

                                Fertilized: True
                                Trimmed: false
                                 ]])
                    elseif not fertilized and trimed then
                        PromptGroup:ShowGroup(Config.Language.HarvestPrompt ..
                            [[

                                        Fertilized: False
                                        Trimmed: True
                                         ]])
                    else
                        PromptGroup:ShowGroup(Config.Language.HarvestPrompt ..
                            [[

                                    Fertilized: False
                                    Trimmed: false
                                     ]])
                    end
                    if firstprompt:HasCompleted() then
                        firstprompt:DeletePrompt()
                        VORPcore.NotifyRightTip(Config.Language.Harvestingcrop, 10000)
                        ScenarioInPlace('WORLD_HUMAN_CROUCH_INSPECT', 10000)
                        DeleteObject(object)
                        if Config.PlantBlips then
                            VORPutils.Blips.RemoveBlip(blip.rawblip)
                        end
                        TriggerServerEvent('bcc-farming:RemoveDBRow', plantid)
                        TriggerServerEvent('bcc-farming:CropHarvested', v.HarvestItem, v.HarvestAmount, trimed,
                            v.TrimmedAmount)
                        break
                    end
                end
            elseif dist > 200 then
                Wait(250)
            end
        end
    end)

----- Is any plant near ped -----
function IsAnyPlantPropNearPed()
    local pl = PlayerPedId()
    for k, v in pairs(Config.Farming) do
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(pl, 0.0, 2.5, 0))
        local Entity = (GetClosestObjectOfType(x, y, z, 2.5, joaat(v.PlantProp), false, false, false))
        if Entity ~= 0 then
            return true
        end
    end
    return false
end

------ Get Closest Vehicle --------
function GetClosestVehicle(coords)
    local ped = PlayerPedId()
    local objects = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestObject = -1
    if coords then
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #objects, 1 do
        local objectCoords = GetEntityCoords(objects[i])
        local distance = #(objectCoords - coords)
        if closestDistance == -1 or closestDistance > distance then
            closestObject = objects[i]
            closestDistance = distance
        end
    end
    return closestObject, closestDistance
end

--- Function for playing task scenarion in place for player
function ScenarioInPlace(hash, time)
    local pl = PlayerPedId()
    FreezeEntityPosition(pl, true)
    TaskStartScenarioInPlace(pl, joaat(hash), time, true, false, false, false)
    Wait(time + 2200)
    ClearPedTasksImmediately(pl)
    FreezeEntityPosition(pl, false)
end
