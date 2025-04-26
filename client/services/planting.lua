local YesPrompt, NoPrompt
local FetilizerGroup = GetRandomIntInRange(0, 0xffffff)
local PromptsStarted = false

local PlantingProcess = false
local CurrentPlants = 0

RegisterNetEvent('bcc-farming:MaxPlantsAmount', function(number)
    if number == 1 then
        CurrentPlants = CurrentPlants + 1
    elseif number == -1 then
        CurrentPlants = CurrentPlants - 1
    end
end)

local function StartPrompts()
    YesPrompt = PromptRegisterBegin()
    PromptSetControlAction(YesPrompt, Config.keys.fertYes)
    PromptSetText(YesPrompt, CreateVarString(10, 'LITERAL_STRING', _U('yes')))
    PromptSetVisible(YesPrompt, true)
    PromptSetEnabled(YesPrompt, true)
    PromptSetHoldMode(YesPrompt, 2000)
    PromptSetGroup(YesPrompt, FetilizerGroup, 0)
    PromptRegisterEnd(YesPrompt)

    NoPrompt = PromptRegisterBegin()
    PromptSetControlAction(NoPrompt, Config.keys.fertNo)
    PromptSetText(NoPrompt, CreateVarString(10, 'LITERAL_STRING', _U('no')))
    PromptSetVisible(NoPrompt, true)
    PromptSetEnabled(NoPrompt, true)
    PromptSetHoldMode(NoPrompt, 2000)
    PromptSetGroup(NoPrompt, FetilizerGroup, 0)
    PromptRegisterEnd(NoPrompt)

    PromptsStarted = true
end

RegisterNetEvent('bcc-farming:PlantingCrop', function(plantData, bestFertilizer)
    if CurrentPlants >= Config.plantSetup.maxPlants then
        VORPcore.NotifyRightTip(_U('maxPlantsReached'), 4000)
        return
    end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local stop = false

    HidePedWeapons(playerPed, 2, true)

    for _, plantCfg in pairs(Plants) do
        local entity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, plantData.plantingDistance, joaat(plantCfg.plantProp), false, false, false)
        if entity ~= 0 then
            stop = true
            VORPcore.NotifyRightTip(_U('tooCloseToAnotherPlant'), 4000)
            break
        end
    end

    if stop then
        TriggerServerEvent('bcc-farming:AddSeedToInventory', plantData.seedName, plantData.seedAmount)
        return
    end

    if PlantingProcess then
        VORPcore.NotifyRightTip(_U('FinishPlantingProcessFirst'), 4000)
        TriggerServerEvent('bcc-farming:AddSeedToInventory', plantData.seedName, plantData.seedAmount)
        return
    end

    PlantingProcess = true

    VORPcore.NotifyRightTip(_U('raking'), 16000)
    PlayAnim('amb_work@world_human_farmer_rake@male_a@idle_a', 'idle_a', 16000, true, true)

    if IsEntityDead(playerPed) then
        VORPcore.NotifyRightTip(_U('failed'), 4000)
        PlantingProcess = false
        TriggerServerEvent('bcc-farming:AddSeedToInventory', plantData.seedName, plantData.seedAmount)
        return
    end

    if plantData.plantingToolRequired then
        TriggerServerEvent('bcc-farming:PlantToolUsage', plantData)
    end

    VORPcore.NotifyRightTip(_U('plantingDone'), 4000)

    if not PromptsStarted then
        StartPrompts()
    end

    while true do
        local sleep = 1000
        local newPlayerCoords = GetEntityCoords(playerPed)
        if #(playerCoords - newPlayerCoords) < 3 then
            sleep = 0
            PromptSetActiveGroupThisFrame(FetilizerGroup, CreateVarString(10, 'LITERAL_STRING', _U('fertilize')), 1, 0, 0, 0)
            if Citizen.InvokeNative(0xE0F65F0640EF0617, YesPrompt) then  -- PromptHasHoldModeCompleted
                if bestFertilizer then
                    plantData.timeToGrow = math.floor(plantData.timeToGrow - (bestFertilizer.fertTimeReduction * plantData.timeToGrow))
                    TriggerServerEvent('bcc-farming:RemoveFertilizer', bestFertilizer.fertName)
                else
                    VORPcore.NotifyRightTip(_U('noFert'), 4000)
                end
                break
            end
            if Citizen.InvokeNative(0xE0F65F0640EF0617, NoPrompt) then  -- PromptHasHoldModeCompleted
                break
            end
        end
        Wait(sleep)
    end

    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, 0.0))
    local plantCoords = vector3(x, y, z)

    TriggerServerEvent('bcc-farming:AddPlant', plantData, plantCoords)
    TriggerEvent('bcc-farming:MaxPlantsAmount', 1)
    PlantingProcess = false
end)
