local YesPrompt = 0
local NoPrompt = 0
local FertilizerGroup = GetRandomIntInRange(0, 0xffffff)
local PromptsStarted = false
local PlantingProcess = false

local function StartPrompts()
    DBG:Info('Starting fertilizer prompts...')
    -- Check if prompts are already started
    if PromptsStarted then
        DBG:Success('Prompts are already started')
        return true
    end

    -- Validate that prompt groups exist
    if not FertilizerGroup then
        DBG:Error('Prompt group is not initialized for Fertilizer')
        return false
    end

    -- Validate config keys exist
    if not Config.keys or not Config.keys.fertYes or not Config.keys.fertNo then
        DBG:Error('Required Fertilizer keys are not defined in config')
        return false
    end

    -- Create Fertilizer Yes prompt
    YesPrompt = UiPromptRegisterBegin()
    DBG:Info('Creating YesPrompt...')
    if not YesPrompt or YesPrompt == 0 then
        DBG:Error('Failed to register YesPrompt')
        return false
    end
    UiPromptSetControlAction(YesPrompt, Config.keys.fertYes)
    UiPromptSetText(YesPrompt, CreateVarString(10, 'LITERAL_STRING', _U('yes')))
    UiPromptSetVisible(YesPrompt, true)
    UiPromptSetEnabled(YesPrompt, true)
    UiPromptSetHoldMode(YesPrompt, 2000)
    UiPromptSetGroup(YesPrompt, FertilizerGroup, 0)
    UiPromptRegisterEnd(YesPrompt)

    -- Create Fertilizer No prompt
    NoPrompt = UiPromptRegisterBegin()
    DBG:Info('Creating NoPrompt...')
    if not NoPrompt or NoPrompt == 0 then
        DBG:Error('Failed to register NoPrompt')
        return false
    end
    UiPromptSetControlAction(NoPrompt, Config.keys.fertNo)
    UiPromptSetText(NoPrompt, CreateVarString(10, 'LITERAL_STRING', _U('no')))
    UiPromptSetVisible(NoPrompt, true)
    UiPromptSetEnabled(NoPrompt, true)
    UiPromptSetHoldMode(NoPrompt, 2000)
    UiPromptSetGroup(NoPrompt, FertilizerGroup, 0)
    UiPromptRegisterEnd(NoPrompt)

    PromptsStarted = true
    DBG:Success('All fertilizer prompts started successfully')
    return true
end

RegisterNetEvent('bcc-farming:PlantingCrop', function(plantData, bestFertilizer, houseLocks)
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

    local playerCoords = GetEntityCoords(playerPed)
    HidePedWeapons(playerPed, 2, true)

    local placementHeading
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
                    placementHeading = lheading or lh
                    break
                end
            end
        end
    end

    if lockRequired and not withinLock and not withinHouseRadius then
        Notify(_U('mustUseLockedSpot'), "error", 4000)
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    if Config.plantSetup.requireHouseOwnership and not withinHouseRadius and not withinLock then
        Notify(_U('needHousePlot'), "error", 4000)
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    -- Check for nearby plants
    for _, plantCfg in pairs(Plants) do
        local entity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, plantData.plantingDistance, joaat(plantCfg.plantProp), false, false, false)
        if entity ~= 0 then
            Notify(_U('tooCloseToAnotherPlant'), "error", 4000)
            TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
            return
        end
    end

    -- Return if already planting
    if PlantingProcess then
        Notify(_U('FinishPlantingProcessFirst'), "error", 4000)
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    PlantingProcess = true
    DBG:Info('Planting process started')

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

    -- Start fertilizer prompts if not already started
    if not PromptsStarted and not StartPrompts() then
        DBG:Error('Failed to start prompts')
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
        return
    end

    -- Fertilizer prompt loop
    DBG:Info('Entering fertilizer prompt loop')
    while PlantingProcess do
        local sleep = 1000
        local newPlayerCoords = GetEntityCoords(playerPed)

        -- Check if player moved too far away
        if #(playerCoords - newPlayerCoords) < 3 then
            sleep = 0
            UiPromptSetActiveGroupThisFrame(FertilizerGroup, CreateVarString(10, 'LITERAL_STRING', _U('fertilize')), 1, 0, 0, 0)

            if Citizen.InvokeNative(0xE0F65F0640EF0617, YesPrompt) then  -- PromptHasHoldModeCompleted
                DBG:Info('Yes prompt completed - using fertilizer')
                if bestFertilizer then
                    plantData.timeToGrow = math.floor(plantData.timeToGrow - (bestFertilizer.fertTimeReduction * plantData.timeToGrow))
                    TriggerServerEvent('bcc-farming:RemoveFertilizer', bestFertilizer.fertName)
                else
                    Notify(_U('noFert'), "error", 4000)
                end
                break
            end

            if Citizen.InvokeNative(0xE0F65F0640EF0617, NoPrompt) then -- PromptHasHoldModeCompleted
                DBG:Info('No prompt completed - skipping fertilizer')
                break
            end

            -- Check if player died during fertilizer selection
            if IsEntityDead(playerPed) then
                Notify(_U('failed'), "error", 4000)
                PlantingProcess = false
                TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
                return
            end
        else
            -- Player moved too far away
            Notify(_U('movedTooFar'), "error", 4000)
            PlantingProcess = false
            TriggerServerEvent('bcc-farming:ReturnItems', plantData.seedName, plantData.seedAmount, plantData.soilRequired, plantData.soilName, plantData.soilAmount)
            return
        end
        Wait(sleep)
    end

    -- Plant the crop if process is still active
    if PlantingProcess then
        DBG:Info('Planting crop at final location')
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, 0.0))
        local plantCoords = {
            x = x,
            y = y,
            z = z
        }
        if placementHeading then
            plantCoords.w = placementHeading
        end
        TriggerServerEvent('bcc-farming:AddPlant', plantData, plantCoords)
    end

    PlantingProcess = false
end)
