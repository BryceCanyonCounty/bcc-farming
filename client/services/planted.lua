local Core = exports.vorp_core:GetCore()
---@type BCCFarmingDebugLib
local DBG = BCCFarmingDebug or {
    Info = function() end,
    Error = function() end,
    Warning = function() end,
    Success = function() end
}
local WaterPrompt = 0
local DestroyPromptWG = 0
local WaterGroup = GetRandomIntInRange(0, 0xffffff)

local HarvestPrompt = 0
local DestroyPromptHG = 0
local HarvestGroup = GetRandomIntInRange(0, 0xffffff)

local PromptsStarted = false
local Crops = {}

local function StartPrompts()
    DBG.Info('Starting water and harvest prompts...')
    -- Check if prompts are already started
    if PromptsStarted then
        DBG.Success('Prompts are already started')
        return true
    end

    -- Validate that prompt groups exist
    if not WaterGroup or not HarvestGroup then
        DBG.Error('Prompt groups are not initialized')
        return false
    end

    -- Validate config keys exist
    if not Config.keys or not Config.keys.water or not Config.keys.harvest or not Config.keys.destroy then
        DBG.Error('Required keys are not defined in config')
        return false
    end

    -- Create water-related prompts
    WaterPrompt = UiPromptRegisterBegin()
    DBG.Info('Creating WaterPrompt...')
    if not WaterPrompt or WaterPrompt == 0 then
        DBG.Error('Failed to register WaterPrompt')
        return false
    end
    UiPromptSetControlAction(WaterPrompt, Config.keys.water)
    UiPromptSetText(WaterPrompt, CreateVarString(10, 'LITERAL_STRING', _U('useBucket')))
    UiPromptSetVisible(WaterPrompt, true)
    UiPromptSetEnabled(WaterPrompt, true)
    UiPromptSetHoldMode(WaterPrompt, 2000)
    UiPromptSetGroup(WaterPrompt, WaterGroup, 0)
    UiPromptRegisterEnd(WaterPrompt)

    DestroyPromptWG = UiPromptRegisterBegin()
    DBG.Info('Creating DestroyPromptWG...')
    if not DestroyPromptWG or DestroyPromptWG == 0 then
        DBG.Error('Failed to register DestroyPromptWG')
        return false
    end
    UiPromptSetControlAction(DestroyPromptWG, Config.keys.destroy)
    UiPromptSetText(DestroyPromptWG, CreateVarString(10, 'LITERAL_STRING', _U('destroyPlant')))
    UiPromptSetVisible(DestroyPromptWG, true)
    UiPromptSetEnabled(DestroyPromptWG, true)
    UiPromptSetHoldMode(DestroyPromptWG, 2000)
    UiPromptSetGroup(DestroyPromptWG, WaterGroup, 0)
    UiPromptRegisterEnd(DestroyPromptWG)

    -- Create harvest-related prompts
    HarvestPrompt = UiPromptRegisterBegin()
    DBG.Info('Creating HarvestPrompt...')
    if not HarvestPrompt or HarvestPrompt == 0 then
        DBG.Error('Failed to register HarvestPrompt')
        return false
    end
    UiPromptSetControlAction(HarvestPrompt, Config.keys.harvest)
    UiPromptSetText(HarvestPrompt, CreateVarString(10, 'LITERAL_STRING', _U('harvest')))
    UiPromptSetVisible(HarvestPrompt, true)
    UiPromptSetEnabled(HarvestPrompt, true)
    UiPromptSetHoldMode(HarvestPrompt, 2000)
    UiPromptSetGroup(HarvestPrompt, HarvestGroup, 0)
    UiPromptRegisterEnd(HarvestPrompt)

    DestroyPromptHG = UiPromptRegisterBegin()
    DBG.Info('Creating DestroyPromptHG...')
    if not DestroyPromptHG or DestroyPromptHG == 0 then
        DBG.Error('Failed to register DestroyPromptHG')
        return false
    end
    UiPromptSetControlAction(DestroyPromptHG, Config.keys.destroy)
    UiPromptSetText(DestroyPromptHG, CreateVarString(10, 'LITERAL_STRING', _U('destroyPlant')))
    UiPromptSetVisible(DestroyPromptHG, true)
    UiPromptSetEnabled(DestroyPromptHG, true)
    UiPromptSetHoldMode(DestroyPromptHG, 2000)
    UiPromptSetGroup(DestroyPromptHG, HarvestGroup, 0)
    UiPromptRegisterEnd(DestroyPromptHG)

    PromptsStarted = true
    DBG.Success('All prompts started successfully')
    return true
end

local function LoadModel(model, modelName)
    DBG.Info('Loading model: ' .. modelName)
    -- Validate input
    if not model or not modelName then
        DBG.Error('Invalid model or modelName for LoadModel: ' .. tostring(model) .. ', ' .. tostring(modelName))
        return false
    end

    -- Check if model is already loaded
    if HasModelLoaded(model) then
        DBG.Success('Model already loaded: ' .. modelName)
        return true
    end

    -- Check if model is valid
    if not IsModelValid(model) then
        DBG.Error('Invalid model:' .. modelName)
        return false
    end

    -- Request model
    RequestModel(model, false)
    DBG.Info('Requesting model: ' .. modelName)

    -- Set timeout (10 seconds)
    local timeout = 10000
    local startTime = GetGameTimer()

    -- Wait for model to load
    while not HasModelLoaded(model) do
        -- Check for timeout
        if GetGameTimer() - startTime > timeout then
            DBG.Error('Timeout while loading model: ' .. modelName)
            return false
        end
        Wait(10)
    end

    DBG.Success('Model loaded successfully: ' .. modelName)
    return true
end

local function ScenarioInPlace(hash, time)
    -- Validate inputs
    if not hash or not time then
        DBG.Error('Invalid hash or time parameter for ScenarioInPlace: ' .. tostring(hash) .. ', ' .. tostring(time))
        return
    end

    local playerPed = PlayerPedId()
    if not DoesEntityExist(playerPed) or playerPed == 0 then
        DBG.Error('Player ped does not exist')
        return
    end

    -- Freeze player and start scenario
    FreezeEntityPosition(playerPed, true)

    -- Convert hash to joaat if it's not already
    local scenarioHash = type(hash) == 'string' and joaat(hash) or hash

    -- Start scenario
    TaskStartScenarioInPlaceHash(playerPed, scenarioHash, time, true, 0, GetEntityHeading(playerPed), false)

    -- Wait for the scenario to complete
    Wait(time)

    -- Clear tasks and reset player state
    ClearPedTasks(playerPed)
    Wait(4000)
    HidePedWeapons(playerPed, 2, true)
    Wait(500)
    FreezeEntityPosition(playerPed, false)
end

RegisterNetEvent('bcc-farming:PlantPlanted', function(plantId, plantData, plantCoords, timeLeft, watered, source)
    DBG.Info('Starting PlantPlanted event...')
    -- Validate inputs
    if not plantId or not plantData or not plantCoords or timeLeft == nil or watered == nil then
        DBG.Error('Invalid parameters received for plant: ' .. tostring(plantId))
        return
    end

    -- Load plant model
    local plantProp = plantData.plantProp
    local hash = joaat(plantProp)

    if not LoadModel(hash, plantProp) then
        DBG.Error('Failed to load model: ' .. plantProp)
        ClearPedTasks(PlayerPedId())
        return
    end

    -- Create plant object with timeout
    local x, y, z = table.unpack(plantCoords)
    local plantObj = CreateObject(hash, x, y, z - plantData.plantOffset, false, false, false, false, false)
    if not DoesEntityExist(plantObj) then
        local timeout = 10000
        local startTime = GetGameTimer()
        while not DoesEntityExist(plantObj) do
            if GetGameTimer() - startTime > timeout then
                DBG.Error('Failed to create plant object: ' .. plantProp)
                return
            end
            Wait(10)
        end
    end

    -- Position and freeze plant
    SetEntityCollision(plantObj, false, false)
    SetEntityCoords(plantObj, x, y, z - plantData.plantOffset, false, false, false, false)
    SetEntityHeading(plantObj, GetEntityHeading(PlayerPedId()))
    FreezeEntityPosition(plantObj, true)
    SetEntityCollision(plantObj, true, true)

    -- Initialize crop data
    Crops[plantId] = {
        plantId = plantId,
        removePlant = false,
        watered = tostring(watered),
        object = plantObj,
        coords = plantCoords
    }

    -- Create blip if enabled and for the planter only
    local blip = nil
    if plantData.blips and plantData.blips.enabled and GetPlayerServerId(PlayerId()) == source then
        blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, plantCoords.x, plantCoords.y, plantCoords.z)
        if blip and blip ~= 0 then
            SetBlipSprite(blip, joaat(plantData.blips.sprite), true)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, plantData.blips.name)
            Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(Config.BlipColors[plantData.blips.color]))
            Crops[plantId].blip = blip
        end
    end

    -- Start prompts if not already started
    if not PromptsStarted and not StartPrompts() then
        DBG.Error('Failed to start prompts')
    end

    -- Create thread for time synchronization
    CreateThread(function()
        while tonumber(timeLeft) > 0 and Crops[plantId] and not Crops[plantId].removePlant do
            if Crops[plantId].watered == 'true' then
                Wait(1000)
                timeLeft = timeLeft - 1
                if Crops[plantId] then
                    Crops[plantId].timeLeft = timeLeft
                end
            else
                Wait(200)
            end
        end
    end)

    -- Main plant interaction loop
    while Crops[plantId] and not Crops[plantId].removePlant do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = #(playerCoords - vector3(plantCoords.x, plantCoords.y, plantCoords.z))

        if dist <= 1.5 then
            sleep = 0

            -- Handle watered plants
            if tostring(Crops[plantId].watered) ~= 'false' then
                if tonumber(timeLeft) > 0 then
                    UiPromptSetEnabled(HarvestPrompt, false)
                    local minutes = math.floor(timeLeft / 60)
                    local seconds = timeLeft % 60
                    local noHarvest = _U('plant') .. ': ' .. plantData.plantName..' | ' .. _U('secondsUntilharvest')..string.format('%02d:%02d', minutes, seconds)
                    UiPromptSetActiveGroupThisFrame(HarvestGroup, CreateVarString(10, 'LITERAL_STRING', noHarvest), 1, 0, 0, 0)

                    -- Handle harvest prompt
                elseif tonumber(timeLeft) <= 0 then
                    UiPromptSetEnabled(HarvestPrompt, true)
                    local harvest = _U('plant') .. ': ' .. plantData.plantName..' ' .. _U('secondsUntilharvestOver')
                    UiPromptSetActiveGroupThisFrame(HarvestGroup, CreateVarString(10, 'LITERAL_STRING', harvest), 1, 0, 0, 0)

                    if Citizen.InvokeNative(0xE0F65F0640EF0617, HarvestPrompt) then -- UiPromptHasHoldModeCompleted
                        DBG.Info('Harvest prompt completed...')
                        local canHarvest = Core.Callback.TriggerAwait('bcc-farming:HarvestCheck', plantId, plantData, false)
                        if canHarvest then
                            PlayAnim('mech_pickup@plant@berries', 'base', 2500, false, true)
                        end
                    end
                end

                -- Handle destroy prompt for watered plants
                if Citizen.InvokeNative(0xE0F65F0640EF0617, DestroyPromptHG) then -- UiPromptHasHoldModeCompleted
                    DBG.Info('Destroy prompt completed...')
                    local canDestroy = Core.Callback.TriggerAwait('bcc-farming:HarvestCheck', plantId, plantData, true)
                    if canDestroy then
                        PlayAnim('amb_camp@world_camp_fire@stomp@male_a@wip_base', 'wip_base', 8000, false, true)
                    end
                end
            end

            -- Handle unwatered plants
            if tostring(Crops[plantId].watered) == 'false' then
                local isRaining = GetRainLevel()
                if isRaining > 0 then
                    TriggerServerEvent('bcc-farming:UpdatePlantWateredStatus', plantId)
                else
                    UiPromptSetActiveGroupThisFrame(WaterGroup, CreateVarString(10, 'LITERAL_STRING', _U('waterPlant')), 1, 0, 0, 0)

                    if Citizen.InvokeNative(0xE0F65F0640EF0617, WaterPrompt) then -- UiPromptHasHoldModeCompleted
                        DBG.Info('Water prompt completed...')
                        local canWater = Core.Callback.TriggerAwait('bcc-farming:ManagePlantWateredStatus', plantId)
                        if canWater then
                            ScenarioInPlace('WORLD_HUMAN_BUCKET_POUR_LOW', 5000)
                        else
                            Core.NotifyRightTip(_U('noWaterBucket'), 4000)
                        end
                    end

                    if Citizen.InvokeNative(0xE0F65F0640EF0617, DestroyPromptWG) then -- UiPromptHasHoldModeCompleted
                        DBG.Info('Destroy prompt completed...')
                        local canDestroy = Core.Callback.TriggerAwait('bcc-farming:HarvestCheck', plantId, plantData, true)
                        if canDestroy then
                            PlayAnim('amb_camp@world_camp_fire@stomp@male_a@wip_base', 'wip_base', 8000, false, true)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end

    -- Cleanup when plant is removed
    if Crops[plantId] then
        if Crops[plantId].blip then
            RemoveBlip(Crops[plantId].blip)
        end
        if Crops[plantId].object and DoesEntityExist(Crops[plantId].object) then
            DeleteObject(Crops[plantId].object)
        end
        Crops[plantId] = nil
    end
end)

-- Remove a plant from the client
RegisterNetEvent('bcc-farming:RemovePlantClient', function(plantId)
    -- Validate input
    if not plantId then
        DBG.Error('Invalid plantId received for RemovePlantClient')
        return
    end

    -- Check if plant exists
    if Crops[plantId] then
        DBG.Info('Removing plant with ID: ' .. tostring(plantId))

        -- Mark plant for removal
        Crops[plantId].removePlant = true
    else
        DBG.Warning('Attempted to remove non-existent plant with ID: ' .. tostring(plantId))
    end
end)

-- Update plant watered status on client
RegisterNetEvent('bcc-farming:UpdateClientPlantWateredStatus', function (plantId)
    -- Validate input
    if not plantId then
        DBG.Error('Invalid plantId received for UpdateClientPlantWateredStatus')
        return
    end

    -- Check if plant exists
    if Crops[plantId] then
        DBG.Info('Updating watered status for plant with ID: ' .. tostring(plantId))

        -- Update watered status
        Crops[plantId].watered = 'true'
    else
        DBG.Warning('Attempted to update watered status for non-existent plant with ID: ' .. tostring(plantId))
    end
end)
