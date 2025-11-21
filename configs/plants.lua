Plants = {
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Agarita',              -- Name of the plant
        seedName = 'Agarita_Seed',          -- Item name for the seed
        seedAmount = 1,                    -- Number of seeds required to plant
        plantProp = 'p_tree_orange_01',     -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = true,                   -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Agarita',              -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Agarita',
                itemLabel = 'Agarita',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)

        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Yarrow',               -- Name of the plant
        seedName = 'Yarrow_Seed',           -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'yarrow01_p',           -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = true,                   -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Yarrow',               -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Yarrow',
                itemLabel = 'Yarrow',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Hop',                  -- Name of the plant
        seedName = 'hop_seed',             -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'rdr2_bush_snakeweedflower', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = true,                   -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Hop',                  -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'hop',
                itemLabel = 'Hop',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Alaskan Ginseng',      -- Name of the plant
        seedName = 'Alaskan_Ginseng_Seed', -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'alaskanginseng_p',    -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Alaskan Ginseng',      -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Alaskan_Ginseng',
                itemLabel = 'Alaskan Ginseng',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'American Ginseng',     -- Name of the plant
        seedName = 'American_Ginseng_Seed', -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'ginseng_p',           -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'American Ginseng',     -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'American_Ginseng',
                itemLabel = 'American Ginseng',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Bay Bolete',           -- Name of the plant
        seedName = 'Bay_Bolete_Seed',       -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_milkweed01x',       -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = true,                   -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Bay Bolete',           -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Bay_Bolete',
                itemLabel = 'Bay Bolete',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Bitter Weed',          -- Name of the plant
        seedName = 'Bitter_Weed_Seed',     -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_milkweed01x',       -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = true,                   -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Bitter Weed',          -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Bitter_Weed',
                itemLabel = 'Bitter Weed',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Black Berry',          -- Name of the plant
        seedName = 'Black_Berry_Seed',     -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_blackberry01x', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Black Berry',          -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Black_Berry',
                itemLabel = 'Black Berry',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Black Currant',        -- Name of the plant
        seedName = 'Black_Currant_Seed',   -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_blackberry01x', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Black Currant',        -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Black_Currant',
                itemLabel = 'Black Currant',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Hop',                  -- Name of the plant
        seedName = 'hop_seed',             -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'rdr2_bush_snakeweedflower', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = true,                   -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Hop',                  -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'hop',
                itemLabel = 'Hop',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Cocoa',                -- Name of the plant
        seedName = 'cocoaseeds',            -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Cocoa',                -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'cocoa',
                itemLabel = 'Cocoa',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Corn',                 -- Name of the plant
        seedName = 'cornseed',              -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'crp_cornstalks_bb_sim', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Corn',                 -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'corn',
                itemLabel = 'Corn',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Creekplum',            -- Name of the plant
        seedName = 'Creekplum_Seed',       -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Creekplum',            -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Creekplum',
                itemLabel = 'Creekplum',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Crows Garlic',         -- Name of the plant
        seedName = 'Crows_Garlic_Seed',    -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Crows Garlic',         -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Crows_Garlic',
                itemLabel = 'Crows Garlic',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Indian Tobbaco',       -- Name of the plant
        seedName = 'Indian_Tobbaco_Seed',  -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_indiantobacco01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = true,                  -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Indian Tobbaco',       -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Indian_Tobbaco',
                itemLabel = 'Indian Tobbaco',
                amount = 1
            }
        },
        jobs = {
            'tabak',
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Milk Weed',            -- Name of the plant
        seedName = 'Milk_Weed_Seed',       -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_milkweed01x',       -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Milk Weed',            -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Milk_Weed',
                itemLabel = 'Milk Weed',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Oleander Sage',        -- Name of the plant
        seedName = 'Oleander_Sage_Seed',   -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_oleander01x',       -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Oleander Sage',        -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Oleander_Sage',
                itemLabel = 'Oleander Sage',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Parasol Mushroom',     -- Name of the plant
        seedName = 'Parasol_Mushroom_Seed', -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_parasol01bx',   -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Parasol Mushroom',     -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Parasol_Mushroom',
                itemLabel = 'Parasol Mushroom',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Prairie Poppy',        -- Name of the plant
        seedName = 'Prairie_Poppy_Seed',   -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'prariepoppy_p',       -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Prairie Poppy',        -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Prairie_Poppy',
                itemLabel = 'Prairie Poppy',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Rams Head',            -- Name of the plant
        seedName = 'Rams_Head_Seed',       -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_ramshead01bx',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Rams Head',            -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Rams_Head',
                itemLabel = 'Rams Head',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Red Raspberry',        -- Name of the plant
        seedName = 'Red_Raspberry_Seed',   -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_raspberry01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Red Raspberry',        -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Red_Raspberry',
                itemLabel = 'Red Raspberry',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Red Sage',             -- Name of the plant
        seedName = 'Red_Sage_Seed',         -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'redsage_p',           -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Red Sage',             -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Red_Sage',
                itemLabel = 'Red Sage',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Saltbush',             -- Name of the plant
        seedName = 'Saltbush_Seed',         -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_saltbush01ex',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Saltbush',             -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Saltbush',
                itemLabel = 'Saltbush',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Sugar',                 -- Name of the plant
        seedName = 'sugarcaneseed',         -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_bloodflower01x', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Sugar',                -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'sugar',
                itemLabel = 'Sugar',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Wild Carrot',          -- Name of the plant
        seedName = 'Wild_Carrot_Seed',     -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'wildcarrot_p',        -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Wild Carrot',          -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Wild_Carrot',
                itemLabel = 'Wild Carrot',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Wild Feverfew',        -- Name of the plant
        seedName = 'Wild_Feverfew_Seed',   -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_wildfeverfew01x',   -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Wild Feverfew',        -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Wild_Feverfew',
                itemLabel = 'Wild Feverfew',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Wild Mint',            -- Name of the plant
        seedName = 'Wild_Mint_Seed',       -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'wildmint_p',          -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Wild Mint',            -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Wild_Mint',
                itemLabel = 'Wild Mint',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Wild Rhubarb',         -- Name of the plant
        seedName = 'Wild_Rhubarb_Seed',    -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_rhubarb01x',    -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Wild Rhubarb',         -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Wild_Rhubarb',
                itemLabel = 'Wild Rhubarb',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Wintergreen Berry',     -- Name of the plant
        seedName = 'Wintergreen_Berry_Seed', -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_wintergreen01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Wintergreen Berry',    -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Wintergreen_Berry',
                itemLabel = 'Wintergreen Berry',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Potato',               -- Name of the plant
        seedName = 'potatoseed',           -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_desertsagepicked01x', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Potato',               -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'potato',
                itemLabel = 'Potato',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Wheat',                -- Name of the plant
        seedName = 'wheatseed',             -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'crp_wheat_dry_aa_sim', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Wheat',                -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'wheat',
                itemLabel = 'Wheat',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Apple',               -- Name of the plant
        seedName = 'Apple_Seed',           -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Apple',                -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'apple',
                itemLabel = 'Apple',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Hummingbird Sage',     -- Name of the plant
        seedName = 'Hummingbird_Sage_Seed', -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x',  -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        smelling = false,                  -- PoliceJob can smell this plant
        blips = {
            enabled = true,                -- Set true to Enable Blips for Plants (Only shows to planter)
            sprite = 'blip_mp_spawnpoint', -- Default: 'blip_mp_spawnpoint'
            name = 'Hummingbird Sage',     -- Name of Blip on Map
            color = 'WHITE'                -- Blip Colors Shown in 'config.lua'
        },
        rewards = {
            {
                itemName = 'Hummingbird_Sage',
                itemLabel = 'Hummingbird Sage',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = true, -- Set to false to allow planting anywhere
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    }
}