Config = {
    defaultlang = 'en_lang', -- Language file to use
    -----------------------------------------------------

    keys = {
        water = 0x4CC0E2FE,   -- Default: 0x4CC0E2FE / B key
        harvest = 0x4CC0E2FE, -- Default: 0x4CC0E2FE / B key
        destroy = 0x27D1C284, -- Default: 0x27D1C284 / R key
    },

    fullWaterBucket = 'wateringcan',        -- Item name for the full water bucket
    emptyWaterBucket = 'wateringcan_empty', -- Item name for the empty water bucket
    -----------------------------------------------------

    -- Script will use the one with the highest time reduction from the player's inventory
    fertilizerSetup = {
        {
            fertName = 'fertilizer1', -- Item name used in the database
            fertTimeReduction = 0.25, -- Default: 0.25 / 25% reduction in time
        },
        {
            fertName = 'fertilizer2', -- Item name used in the database
            fertTimeReduction = 0.50, -- Default: 0.50 / 50% reduction in time
        },
        {
            fertName = 'fertilizer3', -- Item name used in the database
            fertTimeReduction = 0.75, -- Default: 0.75 / 75% reduction in time
        },
    },
    -----------------------------------------------------

    plantSetup = {
        blips = false,           -- If true, it will create blips for the plants
        deleteAfterDays = 3,     -- Days after the plant will be deleted if not harvested (0 will disable, but it's not recommended)
        lockedToPlanter = false, -- If true, only the player who planted the seed will be able to harvest it
        maxPlants = 10,          -- Maximum amount of plants a player can have
    },
    -----------------------------------------------------

    townSetup = {
        canPlantInTowns = false, -- If true, players will be able to plant seeds in towns
        townLocations = {
            {
                coords = vector3(-297.48, 791.1, 118.33), -- Valentine
                townRange = 150                           -- Range where the town will be considered
            },
            {
                coords = vector3(2930.95, 1348.91, 44.1), -- Annesburg
                townRange = 150                           -- Range where the town will be considered
            },
            {
                coords = vector3(2632.52, -1312.31, 51.42), -- Saint Denis
                townRange = 150                             -- Range where the town will be considered
            },
            {
                coords = vector3(1346.14, -1312.5, 76.53), -- Rhodes
                townRange = 150                            -- Range where the town will be considered
            },
            {
                coords = vector3(-1801.09, -374.86, 161.15), -- Strawberry
                townRange = 150                              -- Range where the town will be considered
            },
            {
                coords = vector3(-801.77, -1336.43, 43.54), -- Blackwater
                townRange = 150                             -- Range where the town will be considered
            },
            {
                coords = vector3(-3659.38, -2608.91, -14.08), -- Armadillo
                townRange = 150                               -- Range where the town will be considered
            },
            {
                coords = vector3(-5498.97, -2950.61, -1.62), -- Tumbleweed
                townRange = 150                              -- Range where the town will be considered
            }
        }
    }
}
