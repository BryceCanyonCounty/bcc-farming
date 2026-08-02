local LOOK_LEFT_RIGHT = 0xA987235F
local LOOK_UP_DOWN = 0xD2047988
local PROMPT_COMPLETED_NATIVE = 0xE0F65F0640EF0617

local PlantingProcess = false

local function IsPlayerAvailable(playerPed)
    return PlantingProcess and DoesEntityExist(playerPed) and not IsEntityDead(playerPed)
end

local function ReturnPlantingItems()
    TriggerServerEvent('bcc-farming:ReturnItems')
end

local function CancelPlanting(messageKey)
    PlantingProcess = false
    ClearPedTasks(PlayerPedId())

    if messageKey then
        Notify(_U(messageKey), 'error', 4000)
    end
    ReturnPlantingItems()
end

local function PromptCompleted(prompt)
    return prompt and prompt ~= 0 and Citizen.InvokeNative(PROMPT_COMPLETED_NATIVE, prompt)
end

local function DeletePrompts(prompts)
    for i = 1, #prompts do
        local prompt = prompts[i]
        if prompt and prompt ~= 0 then
            UiPromptDelete(prompt)
        end
    end
end

local function CreateHoldPrompt(group, control, label, holdTime)
    local prompt = UiPromptRegisterBegin()
    if not prompt or prompt == 0 then
        return nil
    end

    UiPromptSetControlAction(prompt, control)
    UiPromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', label))
    UiPromptSetVisible(prompt, true)
    UiPromptSetEnabled(prompt, true)
    UiPromptSetHoldMode(prompt, holdTime)
    UiPromptSetGroup(prompt, group, 0)
    UiPromptRegisterEnd(prompt)

    return prompt
end

local function ResolveGroundPosition(x, y, z)
    local foundGround, groundZ = GetGroundZFor_3dCoord(x, y, z + 10.0, false)
    return foundGround and groundZ or z
end

local function SelectPlantLocation()
    local marker = Config.plantPlacementMarker or {}
    local confirmKey = marker.confirmKey or 0x07CE1E61
    local cancelKey = marker.cancelKey or 0x156F7119
    local initialDistance = math.max(0, tonumber(marker.distance) or 0.75)
    local maximumDistance = math.max(initialDistance, tonumber(marker.maxDistance) or 3.0)
    local mouseSensitivity = math.max(0.001, tonumber(marker.mouseSensitivity) or 0.035)
    local size = math.max(0.01, tonumber(marker.size) or 0.35)
    local color = marker.color or {}
    local lateralOffset = 0.0
    local forwardOffset = initialDistance

    Notify('Move the mouse to position the seed. Click to confirm or press Backspace to cancel.', 'info', 5000)
    Wait(250)

    while PlantingProcess do
        local playerPed = PlayerPedId()
        if not IsPlayerAvailable(playerPed) then
            return nil
        end

        DisableControlAction(0, LOOK_LEFT_RIGHT, true)
        DisableControlAction(0, LOOK_UP_DOWN, true)
        DisableControlAction(0, confirmKey, true)
        DisableControlAction(0, cancelKey, true)

        lateralOffset = lateralOffset + GetDisabledControlNormal(0, LOOK_LEFT_RIGHT) * mouseSensitivity
        forwardOffset = forwardOffset - GetDisabledControlNormal(0, LOOK_UP_DOWN) * mouseSensitivity

        local offsetDistance = math.sqrt(lateralOffset * lateralOffset + forwardOffset * forwardOffset)
        if offsetDistance > maximumDistance then
            local scale = maximumDistance / offsetDistance
            lateralOffset = lateralOffset * scale
            forwardOffset = forwardOffset * scale
        end

        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(
            playerPed,
            lateralOffset,
            forwardOffset,
            0.0
        ))
        z = ResolveGroundPosition(x, y, z)

        Citizen.InvokeNative(
            0x2A32FAA57B937173,
            marker.type or 0x94FDAE17,
            x,
            y,
            z + 0.05,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            size,
            size,
            size,
            color.r or 80,
            color.g or 200,
            color.b or 120,
            color.a or 140,
            false,
            false,
            2,
            false,
            0,
            0,
            false
        )

        if IsDisabledControlJustPressed(0, confirmKey) then
            return { x = x, y = y, z = z, grounded = true }
        end
        if IsDisabledControlJustPressed(0, cancelKey) then
            return nil
        end

        Wait(0)
    end

    return nil
end

local function WalkToPlantLocation(playerPed, location)
    local marker = Config.plantPlacementMarker or {}
    local stoppingDistance = math.max(0.35, tonumber(marker.stoppingDistance) or 0.7)
    local walkSpeed = math.max(0.1, tonumber(marker.walkSpeed) or 1.0)
    local timeout = math.max(1000, tonumber(marker.walkTimeout) or 10000)
    local currentCoords = GetEntityCoords(playerPed)
    local deltaX = currentCoords.x - location.x
    local deltaY = currentCoords.y - location.y
    local distance = math.sqrt(deltaX * deltaX + deltaY * deltaY)

    if distance > stoppingDistance then
        local targetX = location.x + deltaX / distance * stoppingDistance
        local targetY = location.y + deltaY / distance * stoppingDistance
        local heading = GetHeadingFromVector_2d(location.x - targetX, location.y - targetY)
        local startedAt = GetGameTimer()

        TaskGoStraightToCoord(playerPed, targetX, targetY, location.z, walkSpeed, timeout, heading, 0.1)

        while IsPlayerAvailable(playerPed) do
            local current = GetEntityCoords(playerPed)
            local remainingX = current.x - targetX
            local remainingY = current.y - targetY
            if math.sqrt(remainingX * remainingX + remainingY * remainingY) <= 0.25 then
                ClearPedTasks(playerPed)
                break
            end

            if GetGameTimer() - startedAt >= timeout then
                ClearPedTasks(playerPed)
                Notify('Unable to reach the selected planting spot.', 'error', 4000)
                return false
            end
            Wait(100)
        end
    end

    if not IsPlayerAvailable(playerPed) then
        ClearPedTasks(playerPed)
        return false
    end

    TaskTurnPedToFaceCoord(playerPed, location.x, location.y, location.z, 750)
    Wait(750)
    return IsPlayerAvailable(playerPed)
end

local function NormalizeLock(lock)
    local normalized = lock
    local radius
    local heading

    if type(lock) == 'table' then
        radius = tonumber(rawget(lock, 'radius') or rawget(lock, 'range'))
        heading = tonumber(rawget(lock, 'heading'))
        normalized = rawget(lock, 'coords') or lock
    end

    local normalizedType = type(normalized)
    if normalizedType == 'vector3' or normalizedType == 'vector4' then
        return vector3(normalized.x, normalized.y, normalized.z), radius,
            heading or tonumber(normalized.w or normalized.h)
    end
    if normalizedType ~= 'table' then
        return nil, radius, heading
    end

    local x = tonumber(rawget(normalized, 'x') or normalized[1])
    local y = tonumber(rawget(normalized, 'y') or normalized[2])
    local z = tonumber(rawget(normalized, 'z') or normalized[3])
    local normalizedHeading = tonumber(
        rawget(normalized, 'w') or rawget(normalized, 'h') or rawget(normalized, 'heading') or normalized[4]
    )

    if not x or not y or not z then
        return nil, radius, heading or normalizedHeading
    end
    return vector3(x, y, z), radius, heading or normalizedHeading
end

local function IsInsideHousePlot(playerCoords, houseLocks)
    if not Config.plantSetup.requireHouseOwnership or type(houseLocks) ~= 'table' then
        return false
    end

    for _, house in ipairs(houseLocks) do
        local x = tonumber(house.x)
        local y = tonumber(house.y)
        local z = tonumber(house.z)
        local radius = tonumber(house.radius)
        if x and y and z and radius and #(playerCoords - vector3(x, y, z)) <= radius then
            return true
        end
    end
    return false
end

local function ValidatePlantingArea(plantData, playerCoords, houseLocks, defaultHeading)
    local lockRequired = plantData.lockCoords == true
        and type(plantData.coordsLocks) == 'table'
        and next(plantData.coordsLocks) ~= nil
    local withinHouse = IsInsideHousePlot(playerCoords, houseLocks)
    local withinLock = false
    local placementHeading = defaultHeading

    if lockRequired then
        local baseRadius = tonumber(plantData.coordsLockRange) or 2.5
        local radiusPadding = tonumber(plantData.coordsLockTolerance) or 0.0

        for _, lock in ipairs(plantData.coordsLocks) do
            local lockCoords, customRadius, lockHeading = NormalizeLock(lock)
            if lockCoords and #(lockCoords - playerCoords) <= ((customRadius or baseRadius) + radiusPadding) then
                withinLock = true
                placementHeading = lockHeading or placementHeading
                break
            end
        end

        if not withinLock and not withinHouse then
            return false, 'mustUseLockedSpot'
        end
    end

    if Config.plantSetup.requireHouseOwnership and not withinHouse and not withinLock then
        return false, 'needHousePlot'
    end

    return true, nil, placementHeading
end

local function IsTooCloseToPlant(playerCoords, plantingDistance)
    local distance = math.max(0, tonumber(plantingDistance) or 0)

    for _, plantConfig in pairs(Plants) do
        local plantProp = plantConfig.plantProp
        if plantProp then
            local entity = GetClosestObjectOfType(
                playerCoords.x,
                playerCoords.y,
                playerCoords.z,
                distance,
                joaat(plantProp),
                false,
                false,
                false
            )
            if entity and entity ~= 0 then
                return true
            end
        end
    end

    return false
end

local function BuildFertilizerChoices(availableFertilizers)
    local availableNames = {}
    local choices = {}

    for _, available in ipairs(type(availableFertilizers) == 'table' and availableFertilizers or {}) do
        local fertilizerName = type(available) == 'table' and available.fertName or available
        if fertilizerName then
            availableNames[fertilizerName] = true
        end
    end

    for _, fertilizer in ipairs(Config.fertilizerSetup or {}) do
        if fertilizer.fertName and fertilizer.selectionKey then
            choices[#choices + 1] = {
                fertilizer = fertilizer,
                available = availableNames[fertilizer.fertName] == true
            }
        end
    end

    return choices
end

local function SelectFertilizer(availableFertilizers, playerPed, plantingCoords)
    local declineKey = Config.keys and Config.keys.fertNo
    if not declineKey then
        DBG:Error('Missing fertilizer decline key')
        return nil, false
    end

    local group = GetRandomIntInRange(0, 0xffffff)
    local prompts = {}
    local choices = BuildFertilizerChoices(availableFertilizers)
    local registeredChoices = 0

    for _, choice in ipairs(choices) do
        local fertilizer = choice.fertilizer
        local reduction = math.floor((tonumber(fertilizer.fertTimeReduction) or 0) * 100)
        local multiplier = tonumber(fertilizer.fertYieldMultiplier) or 1.0
        local label = string.format(
            '%s | %d%% Faster | %.1fx Yield',
            fertilizer.fertLabel or fertilizer.fertName,
            reduction,
            multiplier
        )
        choice.prompt = CreateHoldPrompt(group, fertilizer.selectionKey, label, 1000)

        if choice.prompt then
            UiPromptSetEnabled(choice.prompt, choice.available)
            prompts[#prompts + 1] = choice.prompt
            registeredChoices = registeredChoices + 1
        end
    end

    local declinePrompt = CreateHoldPrompt(group, declineKey, _U('no'), 1500)
    if declinePrompt then
        prompts[#prompts + 1] = declinePrompt
    end

    if registeredChoices == 0 or not declinePrompt then
        DeletePrompts(prompts)
        DBG:Error('Failed to create fertilizer choice prompts')
        return nil, false
    end

    local title = CreateVarString(10, 'LITERAL_STRING', _U('fertilize'))
    while IsPlayerAvailable(playerPed) do
        if #(plantingCoords - GetEntityCoords(playerPed)) >= 3.0 then
            DeletePrompts(prompts)
            Notify(_U('movedTooFar'), 'error', 4000)
            return nil, false
        end

        UiPromptSetActiveGroupThisFrame(group, title, 1, 0, 0, 0)

        for _, choice in ipairs(choices) do
            if choice.available and choice.prompt and PromptCompleted(choice.prompt) then
                local selected = choice.fertilizer.fertName
                DeletePrompts(prompts)
                return selected, true
            end
        end

        if PromptCompleted(declinePrompt) then
            DeletePrompts(prompts)
            return nil, true
        end
        Wait(0)
    end

    DeletePrompts(prompts)
    return nil, false
end

local function RunPlantingProcess(plantData, availableFertilizers, houseLocks)
    local playerPed = PlayerPedId()
    local selectedLocation = SelectPlantLocation()
    if not selectedLocation then
        CancelPlanting()
        return
    end

    local plantingCoords = vector3(selectedLocation.x, selectedLocation.y, selectedLocation.z)
    HidePedWeapons(playerPed, 2, true)

    local areaValid, messageKey, placementHeading = ValidatePlantingArea(
        plantData,
        plantingCoords,
        houseLocks,
        GetEntityHeading(playerPed)
    )
    if not areaValid then
        CancelPlanting(messageKey)
        return
    end

    if IsTooCloseToPlant(plantingCoords, plantData.plantingDistance) then
        CancelPlanting('tooCloseToAnotherPlant')
        return
    end

    if not WalkToPlantLocation(playerPed, selectedLocation) then
        CancelPlanting()
        return
    end

    Notify(_U('raking'), 'info', 16000)
    PlayAnim('amb_work@world_human_farmer_rake@male_a@idle_a', 'idle_a', 16000, true, true)

    if not IsPlayerAvailable(playerPed) then
        CancelPlanting('failed')
        return
    end

    if plantData.plantingToolRequired then
        TriggerServerEvent('bcc-farming:PlantToolUsage', plantData)
    end

    Notify(_U('plantingDone'), 'success', 4000)

    local selectedFertilizer, selectionCompleted = SelectFertilizer(
        availableFertilizers,
        playerPed,
        plantingCoords
    )
    if not selectionCompleted then
        CancelPlanting()
        return
    end

    TriggerServerEvent('bcc-farming:AddPlant', plantData, {
        x = selectedLocation.x,
        y = selectedLocation.y,
        z = selectedLocation.z,
        w = placementHeading,
        grounded = true
    }, selectedFertilizer)

    PlantingProcess = false
end

RegisterNetEvent('bcc-farming:PlantingCrop', function(plantData, availableFertilizers, houseLocks)
    if type(plantData) ~= 'table' then
        DBG:Error('Invalid plantData received')
        ReturnPlantingItems()
        return
    end

    local playerPed = PlayerPedId()
    if not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then
        DBG:Error('Player ped is invalid or dead')
        ReturnPlantingItems()
        return
    end

    if PlantingProcess then
        Notify(_U('FinishPlantingProcessFirst'), 'error', 4000)
        ReturnPlantingItems()
        return
    end

    PlantingProcess = true
    local succeeded, errorMessage = xpcall(
        RunPlantingProcess,
        debug.traceback,
        plantData,
        availableFertilizers,
        houseLocks
    )
    if not succeeded then
        DBG:Error('Planting process failed: ' .. tostring(errorMessage))
        if PlantingProcess then
            CancelPlanting('failed')
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    PlantingProcess = false
    ClearPedTasks(PlayerPedId())
end)
