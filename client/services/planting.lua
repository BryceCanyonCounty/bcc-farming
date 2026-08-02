local PlantingProcess = false

local function WalkToPlantLocation(playerPed, location)
    local marker = Config.plantPlacementMarker or {}
    local stoppingDistance = math.max(0.35, tonumber(marker.stoppingDistance) or 0.7)
    local walkSpeed = tonumber(marker.walkSpeed) or 1.0
    local timeout = math.max(1000, tonumber(marker.walkTimeout) or 10000)
    local currentCoords = GetEntityCoords(playerPed)
    local deltaX = currentCoords.x - location.x
    local deltaY = currentCoords.y - location.y
    local distance = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))

    if distance > stoppingDistance then
        local targetX = location.x + ((deltaX / distance) * stoppingDistance)
        local targetY = location.y + ((deltaY / distance) * stoppingDistance)
        local heading = GetHeadingFromVector_2d(location.x - targetX, location.y - targetY)
        local startedAt = GetGameTimer()

        TaskGoStraightToCoord(playerPed, targetX, targetY, location.z, walkSpeed, timeout, heading, 0.1)
        while PlantingProcess and not IsEntityDead(playerPed) do
            local pedCoords = GetEntityCoords(playerPed)
            local remainingX = pedCoords.x - targetX
            local remainingY = pedCoords.y - targetY
            local horizontalDistance = math.sqrt((remainingX * remainingX) + (remainingY * remainingY))
            if horizontalDistance <= 0.25 then
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

    if not PlantingProcess or IsEntityDead(playerPed) then
        ClearPedTasks(playerPed)
        return false
    end

    TaskTurnPedToFaceCoord(playerPed, location.x, location.y, location.z, 750)
    Wait(750)
    return not IsEntityDead(playerPed)
end

local function SelectPlantLocation()
    local marker = Config.plantPlacementMarker or {}
    local confirmKey = marker.confirmKey or 0x07CE1E61 -- Left mouse / attack
    local cancelKey = marker.cancelKey or 0x156F7119 -- Backspace
    local distance = tonumber(marker.distance) or 0.75
    local maxDistance = math.max(distance, tonumber(marker.maxDistance) or 3.0)
    local mouseSensitivity = tonumber(marker.mouseSensitivity) or 0.035
    local size = tonumber(marker.size) or 0.35
    local color = marker.color or { r = 80, g = 200, b = 120, a = 140 }
    local lookLeftRight = 0xA987235F
    local lookUpDown = 0xD2047988
    local lateralOffset = 0.0
    local forwardOffset = distance

    Notify('Move the mouse to position the seed. Click to confirm or press Backspace to cancel.', 'info', 5000)
    Wait(250) -- Do not treat the inventory click that used the seed as placement confirmation.

    while PlantingProcess do
        local playerPed = PlayerPedId()
        if not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then
            return nil
        end

        DisableControlAction(0, lookLeftRight, true)
        DisableControlAction(0, lookUpDown, true)

        lateralOffset = lateralOffset + (GetDisabledControlNormal(0, lookLeftRight) * mouseSensitivity)
        forwardOffset = forwardOffset - (GetDisabledControlNormal(0, lookUpDown) * mouseSensitivity)

        local offsetDistance = math.sqrt((lateralOffset * lateralOffset) + (forwardOffset * forwardOffset))
        if offsetDistance > maxDistance then
            local scale = maxDistance / offsetDistance
            lateralOffset = lateralOffset * scale
            forwardOffset = forwardOffset * scale
        end

        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, lateralOffset, forwardOffset, 0.0))
        local foundGround, groundZ = GetGroundZFor_3dCoord(x, y, z + 10.0, false)
        if foundGround then
            z = groundZ
        end
        Citizen.InvokeNative(0x2A32FAA57B937173, marker.type or 0x94FDAE17,
            x, y, z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
            size, size, size, color.r or 80, color.g or 200, color.b or 120, color.a or 140,
            false, false, 2, false, 0, 0, false)

        DisableControlAction(0, confirmKey, true)
        if IsDisabledControlJustPressed(0, confirmKey) then
            return { x = x, y = y, z = z }
        end
        if IsControlJustPressed(0, cancelKey) then
            return nil
        end

        Wait(0)
    end

    return nil
end

local function DeleteFertilizerPrompts(prompts)
    for _, prompt in ipairs(prompts) do
        if prompt and prompt ~= 0 then
            Citizen.InvokeNative(0x00EDE88D4D13CF59, prompt) -- UiPromptDelete
        end
    end
end

local function CreateFertilizerPrompt(group, control, text, holdTime)
    local prompt = UiPromptRegisterBegin()
    if not prompt or prompt == 0 then
        return nil
    end

    UiPromptSetControlAction(prompt, control)
    UiPromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', text))
    UiPromptSetVisible(prompt, true)
    UiPromptSetEnabled(prompt, true)
    UiPromptSetHoldMode(prompt, holdTime)
    UiPromptSetGroup(prompt, group, 0)
    UiPromptRegisterEnd(prompt)
    return prompt
end

local function SelectFertilizer(availableFertilizers, playerPed, plantingCoords)
    if not Config.keys or not Config.keys.fertNo then
        DBG:Error('Missing fertilizer decline key')
        return nil, false
    end

    local group = GetRandomIntInRange(0, 0xffffff)
    local prompts = {}
    local choices = {}
    local availableNames = {}

    for _, available in ipairs(type(availableFertilizers) == 'table' and availableFertilizers or {}) do
        local fertilizerName = type(available) == 'table' and available.fertName or available
        if fertilizerName then
            availableNames[fertilizerName] = true
        end
    end

    for _, fertilizer in ipairs(Config.fertilizerSetup or {}) do
        if fertilizer.fertName and fertilizer.selectionKey then
            local reduction = math.floor((tonumber(fertilizer.fertTimeReduction) or 0) * 100)
            local multiplier = tonumber(fertilizer.fertYieldMultiplier) or 1.0
            local label = string.format('%s | %d%% Faster | %.1fx Yield',
                fertilizer.fertLabel or fertilizer.fertName, reduction, multiplier)
            local prompt = CreateFertilizerPrompt(group, fertilizer.selectionKey, label, 1000)
            if prompt then
                local isAvailable = availableNames[fertilizer.fertName] == true
                UiPromptSetEnabled(prompt, isAvailable)
                table.insert(prompts, prompt)
                table.insert(choices, {
                    fertilizer = fertilizer,
                    prompt = prompt,
                    available = isAvailable
                })
                DBG:Info(string.format('Created fertilizer prompt: %s (control 0x%X)',
                    fertilizer.fertName, fertilizer.selectionKey))
            end
        end
    end

    local declinePrompt = CreateFertilizerPrompt(group, Config.keys.fertNo, _U('no'), 1500)
    if declinePrompt then
        table.insert(prompts, declinePrompt)
    end

    if #choices == 0 or not declinePrompt then
        DeleteFertilizerPrompts(prompts)
        DBG:Error('Failed to create fertilizer choice prompts')
        return nil, false
    end

    while PlantingProcess do
        if not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then
            DeleteFertilizerPrompts(prompts)
            return nil, false
        end
        if #(plantingCoords - GetEntityCoords(playerPed)) >= 3 then
            DeleteFertilizerPrompts(prompts)
            Notify(_U('movedTooFar'), 'error', 4000)
            return nil, false
        end

        UiPromptSetActiveGroupThisFrame(group, CreateVarString(10, 'LITERAL_STRING', _U('fertilize')), 1, 0, 0, 0)

        for _, choice in ipairs(choices) do
            if choice.available and Citizen.InvokeNative(0xE0F65F0640EF0617, choice.prompt) then
                local selected = choice.fertilizer.fertName
                DeleteFertilizerPrompts(prompts)
                DBG:Info('Selected fertilizer: ' .. selected)
                return selected, true
            end
        end

        if Citizen.InvokeNative(0xE0F65F0640EF0617, declinePrompt) then
            DeleteFertilizerPrompts(prompts)
            DBG:Info('Fertilizer declined')
            return nil, true
        end

        Wait(0)
    end

    DeleteFertilizerPrompts(prompts)
    return nil, false
end

RegisterNetEvent('bcc-farming:PlantingCrop', function(plantData, availableFertilizers, houseLocks)
    DBG:Info('PlantingCrop event triggered')
    -- Validate inputs
    if not plantData then
        DBG:Error('Invalid plantData received')
        return
    end

    local playerPed = PlayerPedId()
    if not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then
        DBG:Error('Player ped is invalid or dead')
        return
    end

    if PlantingProcess then
        Notify(_U('FinishPlantingProcessFirst'), "error", 4000)
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    PlantingProcess = true
    local selectedLocation = SelectPlantLocation()
    if not selectedLocation then
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    local playerCoords = vector3(selectedLocation.x, selectedLocation.y, selectedLocation.z)
    HidePedWeapons(playerPed, 2, true)

    local placementHeading = GetEntityHeading(playerPed)
    local withinLock = false
    local lockRequired = plantData.lockCoords and type(plantData.coordsLocks) == 'table' and next(plantData.coordsLocks)
    local withinHouseRadius = false

    if Config.plantSetup.requireHouseOwnership and type(houseLocks) == 'table' then
        for _, house in ipairs(houseLocks) do
            if house.x and house.y and house.z and house.radius then
                local dist = #(playerCoords - vector3(house.x, house.y, house.z))
                if dist <= (house.radius or 0.0) then
                    withinHouseRadius = true
                    break
                end
            end
        end
    end

    if lockRequired then
        local baseRadius = plantData.coordsLockRange or 2.5
        local radiusPadding = plantData.coordsLockTolerance or 0.0

        for _, lock in ipairs(plantData.coordsLocks) do
            local normalized = lock
            local lradius
            local lheading
            if type(lock) == 'table' then
                if lock.radius or lock.range then
                    lradius = lock.radius or lock.range
                end
                if lock.heading then
                    lheading = lock.heading + 0.0
                end
                if lock.coords then
                    normalized = lock.coords
                end
            end

            local lx, ly, lz, lh
            if type(normalized) == 'vector3' or type(normalized) == 'vector4' then
                lx = normalized.x + 0.0
                ly = normalized.y + 0.0
                lz = normalized.z + 0.0
                if normalized.w or normalized.h then
                    lh = (normalized.w or normalized.h) + 0.0
                end
            elseif type(normalized) == 'table' then
                if normalized.x and normalized.y and normalized.z then
                    lx = normalized.x + 0.0
                    ly = normalized.y + 0.0
                    lz = normalized.z + 0.0
                    if normalized.w or normalized.h or normalized.heading then
                        lh = (normalized.w or normalized.h or normalized.heading) + 0.0
                    end
                elseif normalized[1] and normalized[2] and normalized[3] then
                    lx = normalized[1] + 0.0
                    ly = normalized[2] + 0.0
                    lz = normalized[3] + 0.0
                    if normalized[4] then
                        lh = normalized[4] + 0.0
                    end
                end
            end

            if lx and ly and lz then
                local lockVector = vector3(lx, ly, lz)
                local distance = #(lockVector - playerCoords)
                local allowedRadius = (lradius or baseRadius) + radiusPadding
                if distance <= allowedRadius then
                    withinLock = true
                    placementHeading = lheading or lh or placementHeading
                    break
                end
            end
        end
    end

    if lockRequired and not withinLock and not withinHouseRadius then
        Notify(_U('mustUseLockedSpot'), "error", 4000)
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    if Config.plantSetup.requireHouseOwnership and not withinHouseRadius and not withinLock then
        Notify(_U('needHousePlot'), "error", 4000)
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    -- Check for nearby plants
    for _, plantCfg in pairs(Plants) do
        local entity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, plantData.plantingDistance, joaat(plantCfg.plantProp), false, false, false)
        if entity ~= 0 then
            Notify(_U('tooCloseToAnotherPlant'), "error", 4000)
            PlantingProcess = false
            TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
            return
        end
    end

    local selectedFertilizer = nil
    DBG:Info('Planting process started')

    if not WalkToPlantLocation(playerPed, selectedLocation) then
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    -- Raking animation
    Notify(_U('raking'), "info", 16000)
    PlayAnim('amb_work@world_human_farmer_rake@male_a@idle_a', 'idle_a', 16000, true, true)

    -- Check if player died during animation
    if IsEntityDead(playerPed) then
        Notify(_U('failed'), "error", 4000)
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    -- Tool usage
    if plantData.plantingToolRequired then
        DBG:Info('Sending tool usage data')
        TriggerServerEvent('bcc-farming:PlantToolUsage', plantData)
    end

    Notify(_U('plantingDone'), "success", 4000)

    local fertilizerSelectionCompleted
    selectedFertilizer, fertilizerSelectionCompleted = SelectFertilizer(availableFertilizers, playerPed, playerCoords)
    if not fertilizerSelectionCompleted then
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    -- Plant the crop if process is still active
    if PlantingProcess then
        DBG:Info('Planting crop at final location')
        local plantCoords = {
            x = selectedLocation.x,
            y = selectedLocation.y,
            z = selectedLocation.z
        }
        if placementHeading then
            plantCoords.w = placementHeading
        end
        TriggerServerEvent('bcc-farming:AddPlant', plantData, plantCoords, selectedFertilizer)
    end

    PlantingProcess = false
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        PlantingProcess = false
    end
end)
