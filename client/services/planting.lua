local PlantingProcess = false
local CurrentPlants = 0

local function GetPositionInfrontOfElement(posX, posY, posZ, hed, distance)
    local meters = (type(distance) == 'number' and distance) or 3
    posX = posX - math.sin(math.rad(hed)) * meters
    posY = posY + math.cos(math.rad(hed)) * meters
    hed = hed + math.cos(math.rad(hed))
    local vec = vector3(posX, posY, posZ)
    return vec
end

---@param number integer
RegisterNetEvent('bcc-farming:MaxPlantsAmount', function(number)
    if number == 1 then
        CurrentPlants = CurrentPlants + 1
    elseif number == -1 then
        CurrentPlants = CurrentPlants - 1
    end
end)

---@param plantData table
---@param bestFertilizer table
RegisterNetEvent('bcc-farming:PlantingCrop', function(plantData, bestFertilizer)
    local playerPed = PlayerPedId()
    local seed = plantData.seedName
    local amount = plantData.seedAmount
    if CurrentPlants < Config.plantSetup.maxPlants then -- MaxPlants Check
        local playerCoords = GetEntityCoords(playerPed)
        local stop = false
        HidePedWeapons(playerPed, 2, true)
        for _, plantCfg in pairs(Plants) do
            local entity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, plantData.plantingDistance, joaat(plantCfg.plantProp), false, false, false)
            if entity ~= 0 then
                stop = true
                TriggerServerEvent('bcc-farming:GiveBackSeed', seed, amount)
                VORPcore.NotifyRightTip(_U('tooCloseToAnotherPlant'), 4000)
                break
            end
        end
        if not stop then
            if not PlantingProcess then
                PlantingProcess = true
                VORPcore.NotifyRightTip(_U('raking'), 16000)
                PlayAnim('amb_work@world_human_farmer_rake@male_a@idle_a', 'idle_a', 16000, true, true)
                TriggerServerEvent('bcc-farming:PlantToolUsage', plantData)
                VORPcore.NotifyRightTip(_U('plantingDone'), 4000)
                if not IsEntityDead(playerPed) then
                    local fetilizerGroup = BccUtils.Prompt:SetupPromptGroup()
                    local yesPrompt = fetilizerGroup:RegisterPrompt(_U('yes'), 0x4CC0E2FE, 1, 1, true, 'hold', { timedeventhash = 'MEDIUM_TIMED_EVENT' })
                    local noPrompt = fetilizerGroup:RegisterPrompt(_U('no'), 0x9959A6F0, 1, 2, true, 'hold', { timedeventhash = 'MEDIUM_TIMED_EVENT' })
                    while true do
                        local sleep = 500
                        local newPlayerCoords = GetEntityCoords(playerPed)
                        if #(playerCoords - newPlayerCoords) < 3 then
                            sleep = 0
                            fetilizerGroup:ShowGroup(_U('fertilize'))
                            if yesPrompt:HasCompleted() then
                                if bestFertilizer then
                                    plantData.timeToGrow = math.floor(plantData.timeToGrow - (bestFertilizer.fertTimeReduction * plantData.timeToGrow))
                                    TriggerServerEvent('bcc-farming:RemoveFertilizer', bestFertilizer.fertName)
                                else
                                    VORPcore.NotifyRightTip(_U('noFert'), 4000)
                                end
                                break
                            end
                            if noPrompt:HasCompleted() then
                                break
                            end
                        end
                        Wait(sleep)
                    end
                    local entCoords = GetEntityCoords(playerPed)
                    local entRot = GetEntityHeading(playerPed)
                    local plantCoords = GetPositionInfrontOfElement(entCoords.x, entCoords.y, entCoords.z, entRot, 0.75)
                    TriggerServerEvent('bcc-farming:AddPlant', plantData, plantCoords)
                    TriggerEvent('bcc-farming:MaxPlantsAmount', 1)
                    PlantingProcess = false
                else
                    VORPcore.NotifyRightTip(_U('failed'), 4000)
                end
            else
                TriggerServerEvent('bcc-farming:GiveBackSeed', seed, amount)
                VORPcore.NotifyRightTip(_U('FinishPlantingProcessFirst'), 4000)
            end
        end
    elseif CurrentPlants == Config.plantSetup.maxPlants then
        TriggerServerEvent('bcc-farming:GiveBackSeed', seed, amount)
        VORPcore.NotifyRightTip(_U('maxPlantsReached'), 4000)
    end
end)
