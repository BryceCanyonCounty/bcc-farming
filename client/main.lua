local SYNC_START_DELAY_MS = 1000
local SYNC_ATTEMPTS = 10
local SYNC_TIMEOUT_MS = 2000
local SYNC_RETRY_DELAY_MS = 1000
local ASSET_LOAD_TIMEOUT_MS = 10000
local SMELL_CHECK_INTERVAL_MS = 5000
local RAKE_MODEL = 'p_rake02x'

local PlantSyncRequest = 0
local ActivePlantSync
local SmellingThreadStarted = false
local ResourceStopping = false
local SmellBlips = {}
local RakeObjects = {}

local function RemoveEntity(entity)
    if entity and entity ~= 0 and DoesEntityExist(entity) then
        DeleteObject(entity)
    end
end

local function ClearRakeObjects()
    for rakeObject in pairs(RakeObjects) do
        RemoveEntity(rakeObject)
        RakeObjects[rakeObject] = nil
    end
end

local function ClearSmellBlips()
    for i = 1, #SmellBlips do
        local blip = SmellBlips[i]
        if blip and blip ~= 0 then
            RemoveBlip(blip)
        end
    end
    SmellBlips = {}
end

local function WaitForAsset(isLoaded, requestAsset, asset, description)
    if isLoaded(asset) then
        return true
    end

    requestAsset(asset)
    local startedAt = GetGameTimer()
    while not isLoaded(asset) do
        if ResourceStopping or GetGameTimer() - startedAt >= ASSET_LOAD_TIMEOUT_MS then
            if not ResourceStopping then
                DBG:Error('Timed out while loading ' .. description .. ': ' .. tostring(asset))
            end
            return false
        end
        Wait(10)
    end

    return true
end

local function LoadAnimationDictionary(animDict)
    return WaitForAsset(HasAnimDictLoaded, RequestAnimDict, animDict, 'animation dictionary')
end

local function LoadModel(model)
    if not IsModelValid(model) then
        DBG:Error('Invalid model requested: ' .. tostring(model))
        return false
    end
    return WaitForAsset(HasModelLoaded, function(hash)
        RequestModel(hash, false)
    end, model, 'model')
end

RegisterNetEvent('bcc-farming:PlantSyncComplete', function(requestId, success)
    if ActivePlantSync and requestId == ActivePlantSync.requestId then
        ActivePlantSync.completed = true
        ActivePlantSync.success = success == true
    end
end)

local function SyncPlants()
    PlantSyncRequest = PlantSyncRequest + 1
    local requestId = PlantSyncRequest
    local syncState = {
        requestId = requestId,
        completed = false,
        success = false
    }
    ActivePlantSync = syncState

    CreateThread(function()
        Wait(SYNC_START_DELAY_MS)

        for _ = 1, SYNC_ATTEMPTS do
            if ResourceStopping or ActivePlantSync ~= syncState then
                return
            end

            syncState.completed = false
            syncState.success = false
            TriggerServerEvent('bcc-farming:NewClientConnected', requestId)

            local deadline = GetGameTimer() + SYNC_TIMEOUT_MS
            while not syncState.completed and GetGameTimer() < deadline do
                if ResourceStopping or ActivePlantSync ~= syncState then
                    return
                end
                Wait(100)
            end

            if syncState.completed and syncState.success then
                if ActivePlantSync == syncState then
                    ActivePlantSync = nil
                end
                return
            end

            if syncState.completed then
                Wait(SYNC_RETRY_DELAY_MS)
            end
        end

        if ActivePlantSync == syncState then
            ActivePlantSync = nil
            DBG:Error('Unable to synchronize plants after multiple attempts')
        end
    end)
end

function PlayAnim(animDict, animName, duration, raking, loopUntilTimeOver)
    duration = tonumber(duration)
    if type(animDict) ~= 'string' or type(animName) ~= 'string' or not duration or duration < 0 then
        DBG:Error(('Invalid PlayAnim request: %s, %s, %s')
            :format(tostring(animDict), tostring(animName), tostring(duration)))
        return false
    end

    local playerPed = PlayerPedId()
    if playerPed == 0 or not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then
        DBG:Error('Cannot play animation because the player ped is unavailable')
        return false
    end
    if not LoadAnimationDictionary(animDict) then
        return false
    end

    local animationDuration = loopUntilTimeOver and -1 or duration
    local animationFlag = loopUntilTimeOver and 1 or 16
    TaskPlayAnim(
        playerPed,
        animDict,
        animName,
        1.0,
        1.0,
        animationDuration,
        animationFlag,
        0,
        false,
        false,
        false
    )

    local rakeObject
    if raking then
        local rakeModel = joaat(RAKE_MODEL)
        if LoadModel(rakeModel) then
            local playerCoords = GetEntityCoords(playerPed)
            rakeObject = CreateObject(rakeModel, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
            SetModelAsNoLongerNeeded(rakeModel)

            if rakeObject and rakeObject ~= 0 and DoesEntityExist(rakeObject) then
                RakeObjects[rakeObject] = true
                AttachEntityToEntity(
                    rakeObject,
                    playerPed,
                    GetEntityBoneIndexByName(playerPed, 'PH_R_Hand'),
                    0.0,
                    0.0,
                    0.19,
                    0.0,
                    0.0,
                    0.0,
                    false,
                    false,
                    true,
                    false,
                    0,
                    true,
                    false,
                    false
                )
            else
                rakeObject = nil
                DBG:Warning('Failed to create rake object')
            end
        end
    end

    local deadline = GetGameTimer() + duration
    while not ResourceStopping and GetGameTimer() < deadline do
        if not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then
            break
        end
        Wait(math.min(100, math.max(0, deadline - GetGameTimer())))
    end

    if rakeObject then
        RakeObjects[rakeObject] = nil
        RemoveEntity(rakeObject)
    end
    RemoveAnimDict(animDict)

    if DoesEntityExist(playerPed) then
        ClearPedTasks(playerPed)
    end
    return not ResourceStopping and DoesEntityExist(playerPed) and not IsEntityDead(playerPed)
end

local function IsValidSmellingPlant(plant)
    if type(plant) ~= 'table' or not plant.plantName or not plant.coords then
        return false
    end
    local coordsType = type(plant.coords)
    return (coordsType == 'table' or coordsType == 'vector3' or coordsType == 'vector4')
        and tonumber(plant.coords.x) ~= nil
        and tonumber(plant.coords.y) ~= nil
        and tonumber(plant.coords.z) ~= nil
end

local function ShowSmellBlips(smellingPlants, blipConfig)
    ClearSmellBlips()

    local sprite = joaat(blipConfig.sprite or 'blip_plant')
    local color = Config.BlipColors and Config.BlipColors[blipConfig.color]
    local colorHash = color and joaat(color)

    for _, plant in ipairs(smellingPlants) do
        if IsValidSmellingPlant(plant) then
            local coords = plant.coords
            local blip = Citizen.InvokeNative(
                0x554D9D53F696D002,
                1664425300,
                coords.x,
                coords.y,
                coords.z
            )

            if blip and blip ~= 0 then
                SetBlipSprite(blip, sprite, true)
                Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('SmellablePlant') .. plant.plantName)
                if colorHash then
                    Citizen.InvokeNative(0x662D364ABF16DE2F, blip, colorHash)
                end
                SmellBlips[#SmellBlips + 1] = blip
            end
        else
            DBG:Warning('Ignored invalid smelling plant data')
        end
    end
end

local function StartSmellingPlants()
    if SmellingThreadStarted then
        return
    end
    SmellingThreadStarted = true

    CreateThread(function()
        local smellConfig = Config.smelling or {}
        local blipConfig = smellConfig.blip or {}
        local notificationConfig = smellConfig.notifications or {}
        local notificationCooldown = math.max(0, tonumber(notificationConfig.cooldown) or 30) * 1000
        local blipFrequency = math.max(0, tonumber(blipConfig.frequency) or 15) * 1000
        local blipDuration = math.max(0, tonumber(blipConfig.duration) or 5) * 1000
        local nextNotificationAt = 0
        local nextBlipAt = 0
        local blipsExpireAt = 0

        while not ResourceStopping do
            local now = GetGameTimer()
            if blipsExpireAt > 0 and now >= blipsExpireAt then
                ClearSmellBlips()
                blipsExpireAt = 0
            end

            local playerPed = PlayerPedId()
            if playerPed ~= 0 and DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
                local smellingPlants = Core.Callback.TriggerAwait('bcc-farming:DetectSmellingPlants')
                if type(smellingPlants) == 'table' and #smellingPlants > 0 then
                    now = GetGameTimer()

                    if notificationConfig.enabled and now >= nextNotificationAt then
                        Notify(_U('SmellPlant'), 'info', 5000)
                        nextNotificationAt = now + notificationCooldown
                    end

                    if blipConfig.enabled and now >= nextBlipAt then
                        ShowSmellBlips(smellingPlants, blipConfig)
                        nextBlipAt = now + blipFrequency
                        blipsExpireAt = now + blipDuration
                    end
                end
            end

            local waitUntilExpiry = blipsExpireAt > 0 and math.max(0, blipsExpireAt - GetGameTimer()) or SMELL_CHECK_INTERVAL_MS
            Wait(math.min(SMELL_CHECK_INTERVAL_MS, math.max(250, waitUntilExpiry)))
        end

        ClearSmellBlips()
        SmellingThreadStarted = false
    end)
end

RegisterNetEvent('vorp:SelectedCharacter', function()
    SyncPlants()
end)

AddEventHandler('bcc-farming:ShowSmellingPlants', function()
    StartSmellingPlants()
end)

CreateThread(function()
    SyncPlants()
    StartSmellingPlants()
end)

if Config.DevMode then
    RegisterCommand('farmreload', function()
        DBG:Info('Manually restarting farming client synchronization')
        SyncPlants()
        StartSmellingPlants()
    end, false)
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    ResourceStopping = true
    PlantSyncRequest = PlantSyncRequest + 1
    ActivePlantSync = nil
    ClearSmellBlips()
    ClearRakeObjects()
    ClearPedTasksImmediately(PlayerPedId())
end)
