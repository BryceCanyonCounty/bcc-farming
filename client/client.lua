--This will handle planting the crop!
RegisterNetEvent('bcc-farming:plantcrop') --Registers a client event for the server to trigger
AddEventHandler('bcc-farming:plantcrop', function(prop, reward, amount, timer, isoutsideoftown, type) --Makes the event have code to run and catches those 5 variables from the server
    local plyPed = PlayerPedId()
    ---------------------------PLANTING ANIMATION SETUP----------------------------------------------
    if isoutsideoftown == true then -- if variable is true (you are out of town or config = true then)
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_FARMER_RAKE'), 12000, true, false, false, false) --triggers anim
        FreezeEntityPosition(plyPed, true) --freezes player
        VORPcore.NotifyRightTip(Config.Language.Raking,16000) --Prints on the players screen what is set in config.language table
        Wait(12000) --waits 12 seconds (until anim is over)
        ClearPedTasksImmediately(plyPed) --clears anims
        Wait(500) --waits half a second
        VORPcore.NotifyRightTip(Config.Language.Weeding,16000) --Prints on the players screen what is set in config.language table
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_FARMER_WEEDING'), 9000, true, false, false, false) --triggers anim
        Wait(9000) --waits 9 seconds(until anim is over)
        ClearPedTasksImmediately(plyPed) --clears anim
        FreezeEntityPosition(plyPed, false) --unfreezes player
        VORPcore.NotifyRightTip(Config.Language.PlantFinished,16000) --Prints on the players screen what is set in config.language table
        
        -----------------------------CROP SPAWN SETUP----------------------------------
        local plcoord = GetEntityCoords(plyPed) --gets player coords as soon as the plant is planted
        local object = CreateObject(prop, plcoord.x, plcoord.y, plcoord.z, true, true, false) --creates a networked object at the players coords
        Citizen.InvokeNative(0x9587913B9E772D29, object, true) --places entity on the ground properly
        local plantcoords = GetEntityCoords(object) --Gets the plants coordinates once the plant is planted
        TriggerServerEvent('bcc-farming:dbinsert', type, plantcoords, prop, timer, reward, amount, object) --this triggers the server event which inserts the plant into database and returns the database table too the client
    elseif isoutsideoftown == false then
        VORPcore.NotifyRightTip(Config.Language.Tooclosetotown, 4000)
    end
end)

--Event Used to catch plant id from server, and trigger the event to plant the plant
RegisterNetEvent('bcc-farming:plantcrop2')
AddEventHandler('bcc-farming:plantcrop2', function(plantcoords, timer, reward, amount, object, plantid) --catches all from server
    TriggerEvent('bcc-farming:WaterPlantMain', plantcoords, timer, reward, amount, object, plantid) --passes all to function
end)

--TODO still sometimes takes double input on prompt groups, but once pressed 2nd time no issue no double remove or anything so not really a big issue

--This will be used to spawn the plants the player has planted in the database--
--This is used to run the server event for loading the plants after the char has been chosen(if ran before char is chosen it wont work as the db query requires charid)
RegisterNetEvent('vorp:SelectedCharacter')
AddEventHandler('vorp:SelectedCharacter', function()
    TriggerServerEvent('bcc-farming:loadplants') --triggers the server event to get the stuff from database
end)

--This is used to spawn the plants in, after restart or rejoin of server
RegisterNetEvent('bcc-farming:clientspawnplantsinitload')
AddEventHandler('bcc-farming:clientspawnplantsinitload', function(HasPlants) --catches var from server
    for k, v in pairs(HasPlants) do --opens up the table
        --Detection Variables
        local notwateredtimer, reward, amount, blip
        --Crop Detection Setup
        for e, a in pairs(Config.Farming) do --creates for loop
            if a.Type == v['planttype'] then --if a.type = HasPlants type in db then
                notwateredtimer = a.TimetoGrow
                reward = a.HarvestItem
                amount = a.HarvestAmount
            end
        end
        --If plant is watered in db setup
        if v['watered'] == 'true' then --checks if the row/plant has been watered and if so then
            local object = CreateObject(v['prop'], tonumber(v['x']), tonumber(v['y']), tonumber(v['z']), true, true, false) --creates a networked object at the players coords (no need to minus 1 the  z as we did it when placing the plant to begin with)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true) --places entity on the ground properly
            local plantcoords = GetEntityCoords(object)
            if Config.PlantBlips then
                blip = VORPutils.Blips:SetBlip('Your Plant', 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y, plantcoords.z) --Sets blip variable to have a blip
            end
            TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v['timeleft'], reward, amount, plantcoords, object, v['plantid']) --triggers the event to plant crop and passes variables to it
            
            --If plant has not been watered in db setup
        else --else if it has not been watered then
            local object = CreateObject(v['prop'], tonumber(v['x']), tonumber(v['y']), tonumber(v['z']), true, true, false) --creates a networked object at the players coords (no need to minus 1 the  z as we did it when placing the plant to begin with)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true) --places entity on the ground properly
            local plantcoords = GetEntityCoords(object) --gets plants coords
            TriggerEvent('bcc-farming:WaterPlantMain', plantcoords, notwateredtimer, reward, amount, object, v['plantid']) --triggers event to water crop and passes variables to it
        end
    end
end)


--------------------------- Is Ped Currently In Water Check -------------------------------------------------
RegisterNetEvent('bcc-farming:PedInWaterClientCatch')
AddEventHandler('bcc-farming:PedInWaterClientCatch', function(_source)
    local plyPed = PlayerPedId()
    local inwater = IsEntityInWater(plyPed) --gets if the player is in water 1 if is false if not
    if inwater == 1 then --if you are in water then
        FreezeEntityPosition(plyPed, true) --freezes player in place
        TaskStartScenarioInPlace(plyPed, GetHashKey("WORLD_CAMP_JACK_ES_BUCKET_FILL"), 7000, true, false, false, false) --triggers anim
        Wait(7000) --waits 7 seconds(until anim is over)
        ClearPedTasksImmediately(plyPed) --stops animation
        FreezeEntityPosition(plyPed, false) --unfreezes player
        TriggerServerEvent('bcc-farming:RefillWateringCan', _source) --triggers server event to add the item(goes regardless of debug)
    elseif inwater == false then --elseif not in water then
        VORPcore.NotifyRightTip(Config.Language.Notinwater) --print not in water
    end
end)

----------------------- Distance Check for player to town coordinates --------------------------------
RegisterNetEvent('bcc-farming:IsPLayerNearTownCheck')
AddEventHandler('bcc-farming:IsPLayerNearTownCheck', function(_source, v)
    local isoutsideoftown = false --creates a variable used as a catch to see if your in a town
    if Config.Plantintowns == true then --if the config value is set to true (allowed to plant in town then)
        isoutsideoftown = true --sets variable to true to allow if statement to trigger server event
    elseif Config.Plantintowns == false then --elseif config is false then
        for k, e in pairs(Config.Towns) do --opens up the town table and creates a for loop
            local pl = GetEntityCoords(PlayerPedId()) --gets your coords once per loop run
            local dist = #(pl.xy - e.coordinates.xy)
            if dist > e.range then --if dist is more htan 150 then
                isoutsideoftown = true --set to true
            elseif dist < e.range then --if its less then
                VORPcore.NotifyRightTip(Config.Language.Tooclosetotown, 4000)
                isoutsideoftown = false break --sets it too false and breaks the for loop
            end
        end
    end
    local nearotherplant = IsAnyPlantPropNearPed()
    Wait(100)
    if nearotherplant then
        VORPcore.NotifyRightTip(Config.Language.TooCloseToPlant, 4000) return
    end
    if isoutsideoftown == true then --after all the above code runs if outside of town = true then
        TriggerServerEvent('bcc-farming:PlayerNotNearTown', _source, v, isoutsideoftown) --trigger server event to continue planting
    end
end)

-- TODO Setup distance check between all plants and do not allow anyone to plant if they are near any crop they planted