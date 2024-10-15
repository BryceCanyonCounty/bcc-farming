Config = {
    defaultlang = 'en_lang', -- Language file to use
    -----------------------------------------------------

    keys = {
        fertYes = 0x4CC0E2FE, -- Default: 0x4CC0E2FE / B key
        fertNo = 0x9959A6F0,  -- Default: 0x9959A6F0 / C key
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
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Plant',                -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown Below
        },
        lockedToPlanter = false,           -- If true, only the player who planted the seed will be able to harvest it
        maxPlants = 10,                    -- Maximum amount of plants a player can have
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
    },

    BlipColors = {
        LIGHT_BLUE    = 'BLIP_MODIFIER_MP_COLOR_1',
        DARK_RED      = 'BLIP_MODIFIER_MP_COLOR_2',
        PURPLE        = 'BLIP_MODIFIER_MP_COLOR_3',
        ORANGE        = 'BLIP_MODIFIER_MP_COLOR_4',
        TEAL          = 'BLIP_MODIFIER_MP_COLOR_5',
        LIGHT_YELLOW  = 'BLIP_MODIFIER_MP_COLOR_6',
        PINK          = 'BLIP_MODIFIER_MP_COLOR_7',
        GREEN         = 'BLIP_MODIFIER_MP_COLOR_8',
        DARK_TEAL     = 'BLIP_MODIFIER_MP_COLOR_9',
        RED           = 'BLIP_MODIFIER_MP_COLOR_10',
        LIGHT_GREEN   = 'BLIP_MODIFIER_MP_COLOR_11',
        TEAL2         = 'BLIP_MODIFIER_MP_COLOR_12',
        BLUE          = 'BLIP_MODIFIER_MP_COLOR_13',
        DARK_PUPLE    = 'BLIP_MODIFIER_MP_COLOR_14',
        DARK_PINK     = 'BLIP_MODIFIER_MP_COLOR_15',
        DARK_DARK_RED = 'BLIP_MODIFIER_MP_COLOR_16',
        GRAY          = 'BLIP_MODIFIER_MP_COLOR_17',
        PINKISH       = 'BLIP_MODIFIER_MP_COLOR_18',
        YELLOW_GREEN  = 'BLIP_MODIFIER_MP_COLOR_19',
        DARK_GREEN    = 'BLIP_MODIFIER_MP_COLOR_20',
        BRIGHT_BLUE   = 'BLIP_MODIFIER_MP_COLOR_21',
        BRIGHT_PURPLE = 'BLIP_MODIFIER_MP_COLOR_22',
        YELLOW_ORANGE = 'BLIP_MODIFIER_MP_COLOR_23',
        BLUE2         = 'BLIP_MODIFIER_MP_COLOR_24',
        TEAL3         = 'BLIP_MODIFIER_MP_COLOR_25',
        TAN           = 'BLIP_MODIFIER_MP_COLOR_26',
        OFF_WHITE     = 'BLIP_MODIFIER_MP_COLOR_27',
        LIGHT_YELLOW2 = 'BLIP_MODIFIER_MP_COLOR_28',
        LIGHT_PINK    = 'BLIP_MODIFIER_MP_COLOR_29',
        LIGHT_RED     = 'BLIP_MODIFIER_MP_COLOR_30',
        LIGHT_YELLOW3 = 'BLIP_MODIFIER_MP_COLOR_31',
        WHITE         = 'BLIP_MODIFIER_MP_COLOR_32'
    },
}
