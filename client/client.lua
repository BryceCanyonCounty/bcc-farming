--This will handle planting the crop!
RegisterNetEvent('bcc-farming:plantcrop', function(prop, reward, amount, timer, isoutsideoftown, type, ferttime, fertitem)
    ---------------------------PLANTING ANIMATION SETUP----------------------------------------------
    if isoutsideoftown then -- if variable is true (you are out of town or config = true then)
        VORPcore.NotifyRightTip(Config.Language.Raking,16000)
        ScenarioInPlace('WORLD_HUMAN_FARMER_RAKE', 12000)
        VORPcore.NotifyRightTip(Config.Language.Weeding,16000) --Prints on the players screen what is set in config.language table
        ScenarioInPlace('WORLD_HUMAN_FARMER_WEEDING', 9000)
        VORPcore.NotifyRightTip(Config.Language.PlantFinished,16000) --Prints on the players screen what is set in config.language table
        
        -----------------------------CROP SPAWN SETUP----------------------------------
        local plcoord = GetEntityCoords(PlayerPedId())
        local object = CreateObject(prop, plcoord.x, plcoord.y, plcoord.z, true, true, false) --creates a networked object at the players coords
        Citizen.InvokeNative(0x9587913B9E772D29, object, true) --places entity on the ground properly
        local plantcoords = GetEntityCoords(object) --Gets the plants coordinates once the plant is planted
        TriggerServerEvent('bcc-farming:dbinsert', type, plantcoords, prop, timer, reward, amount, object, ferttime, fertitem) --this triggers the server event which inserts the plant into database and returns the database table too the client
    else
        VORPcore.NotifyRightTip(Config.Language.Tooclosetotown, 4000)
    end
end)

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
RegisterNetEvent('bcc-farming:PedInWaterClientCatch', function(_source)
    if IsEntityInWater(PlayerPedId()) then
        ScenarioInPlace('WORLD_CAMP_JACK_ES_BUCKET_FILL', 7000)
        TriggerServerEvent('bcc-farming:RefillWateringCan', _source) --triggers server event to add the item(goes regardless of debug)
    else
        VORPcore.NotifyRightTip(Config.Language.Notinwater) --print not in water
    end
end)

----------------------- Distance Check for player to town coordinates --------------------------------
RegisterNetEvent('bcc-farming:IsPLayerNearTownCheck', function(_source, v)
    local isoutsideoftown = false --creates a variable used as a catch to see if your in a town
    if Config.Plantintowns then --if the config value is set to true (allowed to plant in town then)
        isoutsideoftown = true --sets variable to true to allow if statement to trigger server event
    else
        local pl2 = PlayerPedId()
        for k, e in pairs(Config.Towns) do --opens up the town table and creates a for loop
            local pl = GetEntityCoords(pl2)
            if #(vec2(pl.x, pl.y) - vec2(e.coordinates.x, e.coordinates.y)) > e.range then
                isoutsideoftown = true --set to true
            else
                VORPcore.NotifyRightTip(Config.Language.Tooclosetotown, 4000)
                isoutsideoftown = false break --sets it too false and breaks the for loop
            end
        end
    end
    if IsAnyPlantPropNearPed() then
        VORPcore.NotifyRightTip(Config.Language.TooCloseToPlant, 4000) return
    end
    if isoutsideoftown then
        TriggerServerEvent('bcc-farming:PlayerNotNearTown', _source, v, isoutsideoftown) --trigger server event to continue planting
    end
end)