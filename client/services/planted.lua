local INTERACTION_DISTANCE = 1.5
local PLANT_SYNC_POLL_MS = 250
local MODEL_LOAD_TIMEOUT_MS = 10000

local WaterGroup = GetRandomIntInRange(0, 0xffffff)
local HarvestGroup = GetRandomIntInRange(0, 0xffffff)

local WaterPrompt = 0
local SkipWaterPrompt = 0
local HarvestPrompt = 0
local DestroyPrompt = 0
local PromptsStarted = false

local Crops = {}

local function NormalizePlantId(plantId)
    return tonumber(plantId) or tostring(plantId)
end

local function IsPlantWatered(value)
    return value == true or value == 1 or value == '1' or tostring(value):lower() == 'true'
end

local function IsWaterDeclined(value)
    return tostring(value):lower() == 'no'
end

local function HasPromptCompleted(prompt)
    return prompt ~= 0 and Citizen.InvokeNative(0xE0F65F0640EF0617, prompt)
end

local function DeletePrompt(prompt)
    if prompt and prompt ~= 0 then
        UiPromptDelete(prompt)
    end
end

local function RegisterHoldPrompt(control, label, group)
    local prompt = UiPromptRegisterBegin()
    if not prompt or prompt == 0 then
        return 0
    end

    UiPromptSetControlAction(prompt, control)
    UiPromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', label))
    UiPromptSetVisible(prompt, true)
    UiPromptSetEnabled(prompt, true)
    UiPromptSetHoldMode(prompt, 1000)
    UiPromptSetGroup(prompt, group, 0)
    UiPromptRegisterEnd(prompt)

    return prompt
end

local function StartPrompts()
    if PromptsStarted then
        return true
    end

    local keys = Config.keys
    if not keys or not keys.water or not keys.waterNo or not keys.harvest or not keys.destroy then
        DBG:Error('Required planted-crop prompt keys are not configured')
        return false
    end

    WaterPrompt = RegisterHoldPrompt(keys.water, _U('useBucket'), WaterGroup)
    SkipWaterPrompt = RegisterHoldPrompt(keys.waterNo, _U('no'), WaterGroup)
    HarvestPrompt = RegisterHoldPrompt(keys.harvest, _U('harvest'), HarvestGroup)
    DestroyPrompt = RegisterHoldPrompt(keys.destroy, _U('destroyPlant'), HarvestGroup)

    PromptsStarted = WaterPrompt ~= 0
        and SkipWaterPrompt ~= 0
        and HarvestPrompt ~= 0
        and DestroyPrompt ~= 0

    if not PromptsStarted then
        DeletePrompt(WaterPrompt)
        DeletePrompt(SkipWaterPrompt)
        DeletePrompt(HarvestPrompt)
        DeletePrompt(DestroyPrompt)
        WaterPrompt = 0
        SkipWaterPrompt = 0
        HarvestPrompt = 0
        DestroyPrompt = 0
        DBG:Error('One or more planted-crop prompts failed to register')
        return false
    end

    DBG:Success('Planted-crop prompts started successfully')
    return true
end

local function LoadModel(model, modelName)
    if not model or not modelName or not IsModelValid(model) then
        DBG:Error('Invalid plant model: ' .. tostring(modelName))
        return false
    end

    if HasModelLoaded(model) then
        return true
    end

    RequestModel(model, false)
    local startedAt = GetGameTimer()

    while not HasModelLoaded(model) do
        if GetGameTimer() - startedAt >= MODEL_LOAD_TIMEOUT_MS then
            DBG:Error('Timed out while loading plant model: ' .. tostring(modelName))
            return false
        end
        Wait(10)
    end

    return true
end

local function ScenarioInPlace(scenarioType, conditionalAnim, duration)
    local playerPed = PlayerPedId()
    FreezeEntityPosition(playerPed, true)

    TaskStartScenarioInPlaceHash(
        playerPed,
        joaat(scenarioType),
        duration,
        true,
        joaat(conditionalAnim),
        GetEntityHeading(playerPed),
        false
    )

    Wait(duration)
    ClearPedTasks(playerPed)
    Wait(4000)
    HidePedWeapons(playerPed, 2, true)
    Wait(500)
    FreezeEntityPosition(playerPed, false)
end

local function RemoveCrop(plantId)
    plantId = NormalizePlantId(plantId)
    local crop = Crops[plantId]
    if not crop then
        return false
    end

    if crop.blip and crop.blip ~= 0 then
        RemoveBlip(crop.blip)
    end
    if crop.object and DoesEntityExist(crop.object) then
        DeleteObject(crop.object)
    end

    Crops[plantId] = nil
    return true
end

local function ResetCrops()
    local plantIds = {}
    for plantId in pairs(Crops) do
        plantIds[#plantIds + 1] = plantId
    end
    for i = 1, #plantIds do
        RemoveCrop(plantIds[i])
    end
end

local function GetNearestCrop(playerCoords, maximumDistance)
    local nearestId, nearestCrop, nearestDistance

    for plantId, crop in pairs(Crops) do
        local distance = #(playerCoords - crop.coords)
        if distance <= maximumDistance and (not nearestDistance or distance < nearestDistance) then
            nearestId = plantId
            nearestCrop = crop
            nearestDistance = distance
        end
    end

    return nearestId, nearestCrop, nearestDistance
end


local function RefreshPlantStatus(plantId, crop)
    if not crop or Crops[plantId] ~= crop then
        return nil
    end

    crop.lastStatusSync = GetGameTimer()
    local status = Core.Callback.TriggerAwait('bcc-farming:GetPlantStatus', plantId)
    if not status or Crops[plantId] ~= crop then
        return nil
    end

    crop.timeLeft = math.max(0, tonumber(status.timeLeft) or crop.timeLeft or 0)
    crop.watered = IsPlantWatered(status.watered)
    crop.waterDeclined = status.waterDeclined == true
    crop.rainWaterPending = false
    crop.hasWaterBucket = status.hasWaterBucket == true
    return status
end

local function FormatPlantTitle(crop, remaining)
    if remaining <= 0 then
        return _U('plant') .. ': ' .. crop.plantName .. ' ' .. _U('secondsUntilharvestOver')
    end

    local displayTime = math.ceil(remaining)
    local minutes = math.floor(displayTime / 60)
    local seconds = displayTime % 60

    return _U('plant') .. ': ' .. crop.plantName .. ' | ' .. _U('secondsUntilharvest')
        .. string.format('%02d:%02d', minutes, seconds)
end

local function SetHarvestGroupActive(title, harvestEnabled)
    UiPromptSetEnabled(HarvestPrompt, harvestEnabled)
    UiPromptSetEnabled(DestroyPrompt, true)
    UiPromptSetActiveGroupThisFrame(
        HarvestGroup,
        CreateVarString(10, 'LITERAL_STRING', title),
        1,
        0,
        0,
        0
    )
end

local function SetWaterGroupActive(title, bucketAvailable)
    UiPromptSetEnabled(WaterPrompt, bucketAvailable)
    UiPromptSetEnabled(SkipWaterPrompt, true)
    UiPromptSetActiveGroupThisFrame(
        WaterGroup,
        CreateVarString(10, 'LITERAL_STRING', title .. ' | ' .. _U('waterPlant')),
        1,
        0,
        0,
        0
    )
end

local function HandleHarvest(plantId, crop)
    crop.busy = true
    local status = RefreshPlantStatus(plantId, crop)

    if status and (tonumber(status.timeLeft) or 0) <= 0 then
        PlayAnim('mech_pickup@plant@berries', 'base', 2500, false, true)
        Core.Callback.TriggerAwait('bcc-farming:HarvestCheck', plantId, false)
    end

    if Crops[plantId] == crop then
        crop.busy = false
    end
end

local function HandleDestroy(plantId, crop)
    crop.busy = true
    local canDestroy = Core.Callback.TriggerAwait('bcc-farming:HarvestCheck', plantId, true)

    if canDestroy then
        PlayAnim('amb_camp@world_camp_fire@stomp@male_a@wip_base', 'wip_base', 8000, false, true)
    end

    if Crops[plantId] == crop then
        crop.busy = false
    end
end

local function HandleWater(plantId, crop)
    crop.busy = true
    local canWater = Core.Callback.TriggerAwait('bcc-farming:ManagePlantWateredStatus', plantId)

    if canWater then
        local conditionalAnim = IsPedMale(PlayerPedId())
            and 'WORLD_HUMAN_BUCKET_POUR_LOW_MALE_A'
            or 'WORLD_HUMAN_BUCKET_POUR_LOW_FEMALE_A'
        ScenarioInPlace('WORLD_HUMAN_BUCKET_POUR_LOW', conditionalAnim, 3000)
    elseif Crops[plantId] == crop then
        crop.hasWaterBucket = false
    end

    if Crops[plantId] == crop then
        crop.busy = false
    end
end

local function HandleWaterDecline(plantId, crop)
    crop.busy = true
    local declined = Core.Callback.TriggerAwait('bcc-farming:DeclinePlantWatering', plantId)

    if Crops[plantId] == crop then
        crop.waterDeclined = declined == true
        crop.busy = false
    end
end

RegisterNetEvent('bcc-farming:PlantPlanted', function(plantId, plantData, plantCoords, timeLeft, watered, source)
    if plantId == nil or type(plantData) ~= 'table' or not plantCoords or timeLeft == nil or watered == nil then
        DBG:Error('Invalid PlantPlanted data for plant: ' .. tostring(plantId))
        return
    end

    plantId = NormalizePlantId(plantId)
    RemoveCrop(plantId)

    local plantProp = plantData.plantProp
    local model = plantProp and joaat(plantProp)
    if not LoadModel(model, plantProp) then
        ClearPedTasks(PlayerPedId())
        return
    end

    local x = tonumber(plantCoords.x)
    local y = tonumber(plantCoords.y)
    local spawnZ = tonumber(plantCoords.z)
    if not x or not y or not spawnZ then
        DBG:Error('Invalid coordinates for plant: ' .. tostring(plantId))
        SetModelAsNoLongerNeeded(model)
        return
    end

    local foundGround, groundZ = GetGroundZFor_3dCoord(x, y, spawnZ + 10.0, false)
    if foundGround then
        spawnZ = groundZ
    elseif plantCoords.grounded ~= true then
        spawnZ = spawnZ - (tonumber(plantData.plantOffset) or 0.0)
    end

    local plantObject = CreateObject(model, x, y, spawnZ, false, false, false, false, false)
    if not plantObject or plantObject == 0 or not DoesEntityExist(plantObject) then
        DBG:Error('Failed to create plant object: ' .. tostring(plantProp))
        SetModelAsNoLongerNeeded(model)
        return
    end

    SetEntityCollision(plantObject, false, false)
    SetEntityCoords(plantObject, x, y, spawnZ, false, false, false, false)
    SetEntityHeading(plantObject, plantCoords.w or plantCoords.heading or 0.0)
    FreezeEntityPosition(plantObject, true)
    SetEntityCollision(plantObject, true, true)
    SetModelAsNoLongerNeeded(model)

    local crop = {
        plantId = plantId,
        plantName = plantData.plantName,
        watered = IsPlantWatered(watered),
        waterDeclined = IsWaterDeclined(watered),
        rainWaterPending = false,
        hasWaterBucket = false,
        busy = false,
        timeLeft = math.max(0, tonumber(timeLeft) or 0),
        object = plantObject,
        coords = vector3(x, y, spawnZ)
    }
    Crops[plantId] = crop

    if plantData.blips and plantData.blips.enabled
        and GetPlayerServerId(PlayerId()) == tonumber(source) then
        local blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, x, y, spawnZ)
        if blip and blip ~= 0 then
            SetBlipSprite(blip, joaat(plantData.blips.sprite), true)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, plantData.blips.name)
            Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(Config.BlipColors[plantData.blips.color]))
            crop.blip = blip
        end
    end

    StartPrompts()
end)

RegisterNetEvent('bcc-farming:ResetClientPlants', function()
    ResetCrops()
end)

RegisterNetEvent('bcc-farming:RemovePlantClient', function(plantId)
    if plantId == nil then
        DBG:Error('Invalid plantId received for RemovePlantClient')
        return
    end

    if not RemoveCrop(plantId) then
        DBG:Warning('Attempted to remove non-existent plant: ' .. tostring(plantId))
    end
end)

RegisterNetEvent('bcc-farming:UpdateClientPlantWateredStatus', function(plantId)
    local crop = Crops[NormalizePlantId(plantId)]
    if not crop then
        DBG:Warning('Attempted to water non-existent plant: ' .. tostring(plantId))
        return
    end

    crop.watered = true
    crop.waterDeclined = false
    crop.rainWaterPending = false
end)

RegisterNetEvent('bcc-farming:UpdateClientPlantWaterDeclinedStatus', function(plantId)
    local crop = Crops[NormalizePlantId(plantId)]
    if not crop then
        return
    end

    crop.watered = false
    crop.waterDeclined = true
    crop.rainWaterPending = false
end)

-- Advance every local crop from one lightweight timer. Database synchronization
-- below remains authoritative and corrects any accumulated client-side drift.
CreateThread(function()
    while true do
        Wait(1000)

        local dryGrowthRate = math.max(0, tonumber((Config.cropCare or {}).dryGrowthRate) or 0.5)
        for _, crop in pairs(Crops) do
            if crop.timeLeft > 0 then
                local growthRate = crop.watered and 1.0 or dryGrowthRate
                crop.timeLeft = math.max(0, crop.timeLeft - growthRate)
            end
        end
    end
end)

-- Synchronize only the crop the player can interact with. This keeps database
-- callbacks off the render loop and avoids one polling thread per planted crop.
CreateThread(function()
    while true do
        Wait(PLANT_SYNC_POLL_MS)

        local plantId, crop = GetNearestCrop(GetEntityCoords(PlayerPedId()), INTERACTION_DISTANCE)
        if crop and not crop.busy then
            local interval = math.max(1, tonumber((Config.cropCare or {}).statusSyncInterval) or 5) * 1000
            local now = GetGameTimer()
            if not crop.lastStatusSync or now - crop.lastStatusSync >= interval then
                RefreshPlantStatus(plantId, crop)
            end
        end
    end
end)

-- Shared prompts are rendered and consumed by one loop, targeting only the
-- nearest crop. Multiple nearby plants can no longer compete for prompt state.
CreateThread(function()
    while true do
        local sleep = 500
        local plantId, crop = GetNearestCrop(GetEntityCoords(PlayerPedId()), INTERACTION_DISTANCE)

        if crop and PromptsStarted and not crop.busy then
            sleep = 0

            local remaining = math.max(0, tonumber(crop.timeLeft) or 0)
            local watered = IsPlantWatered(crop.watered)
            local raining = GetRainLevel() > 0
            local waterChoiceActive = remaining > 0
                and not watered
                and not crop.waterDeclined
                and not raining
            local title = FormatPlantTitle(crop, remaining)

            if waterChoiceActive then
                SetWaterGroupActive(title, crop.hasWaterBucket == true)

                if HasPromptCompleted(WaterPrompt) then
                    HandleWater(plantId, crop)
                elseif HasPromptCompleted(SkipWaterPrompt) then
                    HandleWaterDecline(plantId, crop)
                end
            else
                SetHarvestGroupActive(title, remaining <= 0)

                if remaining <= 0 and HasPromptCompleted(HarvestPrompt) then
                    HandleHarvest(plantId, crop)
                elseif HasPromptCompleted(DestroyPrompt) then
                    HandleDestroy(plantId, crop)
                end

                if remaining > 0 and not watered and not crop.waterDeclined and raining
                    and not crop.rainWaterPending then
                    crop.rainWaterPending = true
                    Notify(_U('rainWatered'), 'info', 4000)
                    TriggerServerEvent('bcc-farming:UpdatePlantWateredStatus', plantId)
                end
            end
        end

        Wait(sleep)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    ResetCrops()
    DeletePrompt(WaterPrompt)
    DeletePrompt(SkipWaterPrompt)
    DeletePrompt(HarvestPrompt)
    DeletePrompt(DestroyPrompt)
end)
