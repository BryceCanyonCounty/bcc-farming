local Plants = 1
local LastSeed = {
    name = '',
    amount = 0
}

------- Planting Crop Handler -------------
RegisterNetEvent('bcc-farming:plantcrop', function(v, isoutsideoftown)
    if isoutsideoftown then
        if Plants <= Config.Maxplants or Config.Maxplants == 0 then
            VORPcore.NotifyRightTip(Config.Language.Raking, 16000)
            ScenarioInPlace('WORLD_HUMAN_FARMER_RAKE', 12000)
            VORPcore.NotifyRightTip(Config.Language.Weeding, 16000)
            ScenarioInPlace('WORLD_HUMAN_FARMER_WEEDING', 9000)
            VORPcore.NotifyRightTip(Config.Language.PlantFinished, 16000)
            LastSeed.name = v.Seedname
            LastSeed.amount = v.SeedsRequired
            local plcoord = GetEntityCoords(PlayerPedId())
            local object = CreateObject(v.PlantProp, plcoord.x, plcoord.y, plcoord.z, true, true, false)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true)
            local plantcoords = GetEntityCoords(object)
            TriggerServerEvent('bcc-farming:dbinsert', v, plantcoords, object)
            Plants = Plants + 1
        else
            TriggerServerEvent('bcc-farming:givebackseed', LastSeed.name, LastSeed.amount)
            VORPcore.NotifyRightTip(Config.Language.Maxplants, 4000)
        end
    else
        VORPcore.NotifyRightTip(Config.Language.Tooclosetotown, 4000)
    end
end)

local function createLocationBlips()
    if Config.UseLocationBlips == true then
        for k, b in pairs(Config.FarmingLocations) do
            VORPutils.Blips:SetBlip(b.blipname, b.blipsprite, 0.2, b.location.x, b.location.y,
                b.location.z)
        end
    end
end

--- Check if the player is within a valie farming location
local function checkFarmingLocations(v, isoutsideoftown)
    local isinsidefarminglocation = false
    local pl2 = PlayerPedId()
    for k, e in pairs(Config.FarmingLocations) do
        local pl = GetEntityCoords(pl2)
        if #(vec2(pl.x, pl.y) - vec2(e.location.x, e.location.y)) < e.radius then
            isinsidefarminglocation = true
        end
    end

    if isinsidefarminglocation then
        TriggerServerEvent('bcc-farming:PlayerNotNearTown', _source, v, isoutsideoftown)
    else
        VORPcore.NotifyRightTip(Config.Language.NotInFarmingLocation, 4000)
    end
end

---------- Load Plants and all other data on char selection -----------------
RegisterNetEvent('vorp:SelectedCharacter')
AddEventHandler('vorp:SelectedCharacter', function()
    TriggerServerEvent('bcc-farming:loadplants')
    createLocationBlips()
end)

------------ Load plants after char select -------------------
RegisterNetEvent('bcc-farming:clientspawnplantsinitload')
AddEventHandler('bcc-farming:clientspawnplantsinitload', function(HasPlants)
    for k, v in pairs(HasPlants) do
        local blip, table
        for e, a in pairs(Config.Farming) do
            if a.Type == v['planttype'] then
                table = a
            end
        end
        local coords = json.decode(v['plantcoords'])

        if v['watered'] == 'true' then
            local object = CreateObject(v['prop'], coords.x, coords.y, coords.z, true, true, false)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true)
            local plantcoords = GetEntityCoords(object)
            if Config.PlantBlips then
                blip = VORPutils.Blips:SetBlip(Config.Language.PlantBlip, 'blip_mp_spawnpoint', 0.2, plantcoords.x, plantcoords.y,
                    plantcoords.z)
            end
            TriggerEvent('bcc-farming:WaitUntilHarvest', blip, v['timeleft'], table, plantcoords, object, v['plantid'])
        else
            local object = CreateObject(v['prop'], coords.x, coords.y, coords.z, true, true, false)
            Citizen.InvokeNative(0x9587913B9E772D29, object, true)
            local plantcoords = GetEntityCoords(object)
            TriggerEvent('bcc-farming:WaterPlantMain', plantcoords, table, object, v['plantid'])
        end
        Plants = Plants + 1
    end
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
    if isoutsideoftown and Config.UseFarmingLocations == false then
        TriggerServerEvent('bcc-farming:PlayerNotNearTown', _source, v, isoutsideoftown)
    elseif isoutsideoftown and Config.UseFarmingLocations == true then
        checkFarmingLocations(v, isoutsideoftown)
    end
end)

RegisterNetEvent('bcc-farming:PlantHarvested', function(_source)
    Plants = Plants - 1
end)
