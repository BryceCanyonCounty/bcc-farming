CreateThread(function()
    for _, plantCfg in pairs(Plants) do
        exports.vorp_inventory:registerUsableItem(plantCfg.seedName, function(data)
            local src = data.source
            local user = Core.getUser(src)

            -- Check if the user exists
            if not user then
                DBG:Error('User not found for source: ' .. tostring(src))
                return
            end

            local character = user.getUsedCharacter
            local playerCoords = GetEntityCoords(GetPlayerPed(src))
            local playerHouses = nil
            local housePayload = nil
            local withinHouseRadius = false

            if Config.plantSetup.requireHouseOwnership then
                playerHouses = GetPlayerHouses(character.charIdentifier)
                if not playerHouses or #playerHouses == 0 then
                    DBG:Error("Player does not own a house")
                    NotifyClient(src, _U('needHouseOwnership'), "error", 4000)
                    return
                end

                local padding = Config.plantSetup.houseRadiusPadding or 0.0
                for _, house in ipairs(playerHouses) do
                    if house.coords and #(playerCoords - house.coords) <= ((house.radius or 0.0) + padding) then
                        withinHouseRadius = true
                        break
                    end
                end

                housePayload = {}
                for _, house in ipairs(playerHouses) do
                    if house.coords then
                        table.insert(housePayload, {
                            x = house.coords.x,
                            y = house.coords.y,
                            z = house.coords.z,
                            radius = (house.radius or 0.0) + padding
                        })
                    end
                end
            end

            local lockRequired = plantCfg.lockCoords and type(plantCfg.coordsLocks) == 'table' and next(plantCfg.coordsLocks)
            local withinLock = false

            if lockRequired then
                local baseRadius = plantCfg.coordsLockRange or 2.5
                local radiusPadding = plantCfg.coordsLockTolerance or 0.0

                for _, lock in ipairs(plantCfg.coordsLocks) do
                    local normalized = lock
                    local lradius
                    if type(lock) == 'table' then
                        if lock.radius or lock.range then
                            lradius = lock.radius or lock.range
                        end
                        if lock.coords then
                            normalized = lock.coords
                        end
                    end

                    local lx, ly, lz
                    if type(normalized) == 'vector3' or type(normalized) == 'vector4' then
                        lx = normalized.x + 0.0
                        ly = normalized.y + 0.0
                        lz = normalized.z + 0.0
                    elseif type(normalized) == 'table' then
                        if normalized.x and normalized.y and normalized.z then
                            lx = normalized.x + 0.0
                            ly = normalized.y + 0.0
                            lz = normalized.z + 0.0
                        elseif normalized[1] and normalized[2] and normalized[3] then
                            lx = normalized[1] + 0.0
                            ly = normalized[2] + 0.0
                            lz = normalized[3] + 0.0
                        end
                    end

                    if lx and ly and lz then
                        local distance = #(vector3(lx, ly, lz) - playerCoords)
                        local allowedRadius = (lradius or baseRadius) + radiusPadding
                        if distance <= allowedRadius then
                            withinLock = true
                            break
                        end
                    end
                end

                if not withinLock and not (Config.plantSetup.requireHouseOwnership and withinHouseRadius) then
                    DBG:Error("Player not within locked planting coordinates")
                    NotifyClient(src, _U('mustUseLockedSpot'), "error", 4000)
                    return
                end
            end

            if Config.plantSetup.requireHouseOwnership and not withinHouseRadius and not withinLock then
                DBG:Error("Player not within owned house radius")
                NotifyClient(src, _U('needHousePlot'), "error", 4000)
                return
            end

            -- Town Check
            if not Config.townSetup.canPlantInTowns then
                DBG:Info("Checking town proximity...")
                for _, townCfg in pairs(Config.townSetup.townLocations) do
                    if #(playerCoords - townCfg.coords) <= townCfg.townRange then
                        DBG:Error("Player too close to town")
                        NotifyClient(src, _U('tooCloseToTown'), "error", 4000)
                        return
                    end
                end
                DBG:Success("Town check passed")
            else
                DBG:Success("Town check skipped (can plant in towns)")
            end

            -- Job Check
            if plantCfg.jobLocked then
                DBG:Info("Checking job requirements...")
                local hasJob = false
                for _, job in ipairs(plantCfg.jobs) do
                    if character.job == job then
                        hasJob = true
                        break
                    end
                end
                if not hasJob then
                    DBG:Error("Player doesn't have required job")
                    NotifyClient(src, _U('incorrectJob'), "error", 4000)
                    return
                end
                DBG:Success("Job check passed")
            else
                DBG:Success("Job check skipped (no job requirements)")
            end

            -- Soil Check
            if plantCfg.soilRequired then
                DBG:Info("Checking soil requirements...")
                if not plantCfg.soilName or not plantCfg.soilAmount then
                    DBG:Error('Soil config is missing or invalid.')
                    return
                end
                local hasSoil = exports.vorp_inventory:getItemCount(src, nil, plantCfg.soilName)
                if hasSoil < plantCfg.soilAmount then
                    DBG:Error("Player doesn't have enough soil")
                    NotifyClient(src, _U('noSoil'), "error", 4000)
                    return
                end
                DBG:Success("Soil check passed")
            else
                DBG:Success("Soil check skipped (no soil required)")
            end

            -- Tool Check
            if plantCfg.plantingToolRequired then
                DBG:Info("Checking planting tool...")
                local hasPlantingTool = exports.vorp_inventory:getItemCount(src, nil, plantCfg.plantingTool)
                if hasPlantingTool == 0 then
                    DBG:Error("Player doesn't have planting tool")
                    NotifyClient(src, _U('noPlantingTool'), "error", 4000)
                    return
                end
                DBG:Success("Tool check passed")
            else
                DBG:Success("Tool check skipped (no tool required)")
            end

            -- Max Plants Check
            DBG:Info("Checking max plants limit...")
            local playerPlants = MySQL.query.await('SELECT * FROM `bcc_farming` WHERE `plant_owner` = ?', { character.charIdentifier })
            if not playerPlants or #playerPlants >= Config.plantSetup.maxPlants then
                DBG:Error("Player reached max plants limit")
                NotifyClient(src, _U('maxPlantsReached'), "error", 4000)
                return
            end
            DBG:Success("Max plants check passed")

            -- Seed Check
            DBG:Info("Checking seed requirements...")
            if not plantCfg.seedName or not plantCfg.seedAmount then
                DBG:Error('Seed config is missing or invalid.')
                return
            end

            local seedCount = exports.vorp_inventory:getItemCount(src, nil, plantCfg.seedName)
            if seedCount < plantCfg.seedAmount then
                DBG:Error("Player doesn't have enough seeds")
                NotifyClient(src, _U('noSeed'), "error", 4000)
                return
            end
            DBG:Success("Seed check passed")

            -- Remove Seeds and Soil
            DBG:Info("Removing seeds and soil from inventory...")
            exports.vorp_inventory:closeInventory(src)
            exports.vorp_inventory:subItem(src, plantCfg.seedName, plantCfg.seedAmount)
            if plantCfg.soilRequired then
                exports.vorp_inventory:subItem(src, plantCfg.soilName, plantCfg.soilAmount)
            end
            DBG:Success("Seeds and soil (if required) removed")

            -- Find Best Fertilizer
            DBG:Info("Finding best fertilizer...")
            local bestFertilizer = nil
            for _, fert in pairs(Config.fertilizerSetup) do
                local fertCount = exports.vorp_inventory:getItemCount(src, nil, fert.fertName)
                if fertCount > 0 and (not bestFertilizer or fert.fertTimeReduction > bestFertilizer.fertTimeReduction) then
                    bestFertilizer = fert
                end
            end

            if bestFertilizer then
                DBG:Info("Best fertilizer found: " .. bestFertilizer.fertName)
            else
                DBG:Info("No suitable fertilizer found")
            end

            -- Trigger Planting Event
            DBG:Info("Triggering planting event...")
            TriggerClientEvent('bcc-farming:PlantingCrop', src, plantCfg, bestFertilizer, housePayload)
        end, GetCurrentResourceName())
    end
end)
