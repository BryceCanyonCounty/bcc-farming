Plants = {
    {
        plantingToolRequired = true,       -- Require a planting tool before this seed can be used
        plantingTool = 'hoe',              -- Inventory item used as the planting tool
        plantingToolUsage = 2,             -- Durability removed from the tool per planting
        plantingDistance = 1.5,            -- Minimum distance required between plants
        plantName = 'Agarita',             -- Display name used by prompts, blips, and notifications
        seedName = 'Agarita_Seed',         -- Inventory item registered as the usable seed
        seedAmount = 1,                    -- Seeds consumed when planting
        plantProp = 'p_tree_orange_01',    -- World prop spawned for the planted crop
        soilRequired = false,              -- Require soil in addition to the seed
        soilAmount = 1,                    -- Soil consumed when soilRequired is enabled
        soilName = 'soil',                 -- Inventory item used as soil
        timeToGrow = 900,                  -- Base growth time in seconds before care modifiers
        plantOffset = 1,                   -- Legacy Z fallback when terrain height cannot be detected
        jobLocked = false,                 -- Restrict planting to the jobs listed below
        smelling = true,                   -- Allow this crop to be detected by the smelling system
        blips = {
            enabled = true,                -- Show an owner-only map blip for this crop
            sprite = 'blip_mp_spawnpoint', -- Blip sprite name
            name = 'Agarita',              -- Text displayed on the map blip
            color = 'WHITE'                -- Key from Config.BlipColors in config.lua
        },
        rewards = {                        -- Items granted at harvest after care multipliers
            {
                itemName = 'Agarita',      -- Reward inventory item name
                itemLabel = 'Agarita',     -- Reward name displayed to the player
                amount = 2                 -- Base reward quantity
            }
        },
        jobs = {                              -- Jobs allowed to plant when jobLocked is enabled
            'farmer',                         -- VORP character job name
            'doctor'                          -- Add or remove job names as needed
        },
        lockCoords = false,                   -- Restrict planting to the configured locations
        coordsLockRange = 50,                 -- Base allowed radius around each location
        coordsLockTolerance = 0.75,           -- Extra radius added to reduce boundary failures
        coordsLocks = {                       -- Allowed planting locations when lockCoords is enabled
            vector3(1306.07, -1903.26, 52.26) -- Location center

        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Yarrow',
        seedName = 'Yarrow_Seed',
        seedAmount = 1,
        plantProp = 'yarrow01_p',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = true,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Yarrow',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Yarrow',
                itemLabel = 'Yarrow',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Hop',
        seedName = 'hop_seed',
        seedAmount = 1,
        plantProp = 'rdr2_bush_snakeweedflower',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = true,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Hop',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'hop',
                itemLabel = 'Hop',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Alaskan Ginseng',
        seedName = 'Alaskan_Ginseng_Seed',
        seedAmount = 1,
        plantProp = 'alaskanginseng_p',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Alaskan Ginseng',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Alaskan_Ginseng',
                itemLabel = 'Alaskan Ginseng',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'American Ginseng',
        seedName = 'American_Ginseng_Seed',
        seedAmount = 1,
        plantProp = 'ginseng_p',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'American Ginseng',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'American_Ginseng',
                itemLabel = 'American Ginseng',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Bay Bolete',
        seedName = 'Bay_Bolete_Seed',
        seedAmount = 1,
        plantProp = 's_milkweed01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = true,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Bay Bolete',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Bay_Bolete',
                itemLabel = 'Bay Bolete',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Bitter Weed',
        seedName = 'Bitter_Weed_Seed',
        seedAmount = 1,
        plantProp = 's_milkweed01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = true,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Bitter Weed',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Bitter_Weed',
                itemLabel = 'Bitter Weed',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Black Berry',
        seedName = 'Black_Berry_Seed',
        seedAmount = 1,
        plantProp = 's_inv_blackberry01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Black Berry',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Black_Berry',
                itemLabel = 'Black Berry',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Black Currant',
        seedName = 'Black_Currant_Seed',
        seedAmount = 1,
        plantProp = 's_inv_blackberry01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Black Currant',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Black_Currant',
                itemLabel = 'Black Currant',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------

    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Cocoa',
        seedName = 'cocoaseeds',
        seedAmount = 1,
        plantProp = 's_ginsengpicked01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Cocoa',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'cocoa',
                itemLabel = 'Cocoa',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Corn',
        seedName = 'cornseed',
        seedAmount = 1,
        plantProp = 'crp_cornstalks_bb_sim',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Corn',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'corn',
                itemLabel = 'Corn',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Creekplum',
        seedName = 'Creekplum_Seed',
        seedAmount = 1,
        plantProp = 's_ginsengpicked01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Creekplum',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Creekplum',
                itemLabel = 'Creekplum',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Crows Garlic',
        seedName = 'Crows_Garlic_Seed',
        seedAmount = 1,
        plantProp = 's_ginsengpicked01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Crows Garlic',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Crows_Garlic',
                itemLabel = 'Crows Garlic',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Indian Tobacco',
        seedName = 'Indian_Tobbaco_Seed',
        seedAmount = 1,
        plantProp = 's_indiantobacco01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = true,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Indian Tobacco',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Indian_Tobbaco',
                itemLabel = 'Indian Tobacco',
                amount = 2
            }
        },
        jobs = {
            'tabak',
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Milk Weed',
        seedName = 'Milk_Weed_Seed',
        seedAmount = 1,
        plantProp = 's_milkweed01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Milk Weed',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Milk_Weed',
                itemLabel = 'Milk Weed',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Oleander Sage',
        seedName = 'Oleander_Sage_Seed',
        seedAmount = 1,
        plantProp = 's_oleander01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Oleander Sage',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Oleander_Sage',
                itemLabel = 'Oleander Sage',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Parasol Mushroom',
        seedName = 'Parasol_Mushroom_Seed',
        seedAmount = 1,
        plantProp = 's_inv_parasol01bx',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Parasol Mushroom',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Parasol_Mushroom',
                itemLabel = 'Parasol Mushroom',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Prairie Poppy',
        seedName = 'Prairie_Poppy_Seed',
        seedAmount = 1,
        plantProp = 'prariepoppy_p',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Prairie Poppy',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Prairie_Poppy',
                itemLabel = 'Prairie Poppy',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Rams Head',
        seedName = 'Rams_Head_Seed',
        seedAmount = 1,
        plantProp = 's_inv_ramshead01bx',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Rams Head',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Rams_Head',
                itemLabel = 'Rams Head',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Red Raspberry',
        seedName = 'Red_Raspberry_Seed',
        seedAmount = 1,
        plantProp = 's_inv_raspberry01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Red Raspberry',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Red_Raspberry',
                itemLabel = 'Red Raspberry',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Red Sage',
        seedName = 'Red_Sage_Seed',
        seedAmount = 1,
        plantProp = 'redsage_p',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Red Sage',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Red_Sage',
                itemLabel = 'Red Sage',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Saltbush',
        seedName = 'Saltbush_Seed',
        seedAmount = 1,
        plantProp = 's_inv_saltbush01ex',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Saltbush',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Saltbush',
                itemLabel = 'Saltbush',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Sugar',
        seedName = 'sugarcaneseed',
        seedAmount = 1,
        plantProp = 's_inv_bloodflower01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Sugar',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'sugar',
                itemLabel = 'Sugar',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Wild Carrot',
        seedName = 'Wild_Carrot_Seed',
        seedAmount = 1,
        plantProp = 'wildcarrot_p',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Wild Carrot',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Wild_Carrot',
                itemLabel = 'Wild Carrot',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Wild Feverfew',
        seedName = 'Wild_Feverfew_Seed',
        seedAmount = 1,
        plantProp = 's_wildfeverfew01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Wild Feverfew',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Wild_Feverfew',
                itemLabel = 'Wild Feverfew',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Wild Mint',
        seedName = 'Wild_Mint_Seed',
        seedAmount = 1,
        plantProp = 'wildmint_p',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Wild Mint',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Wild_Mint',
                itemLabel = 'Wild Mint',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Wild Rhubarb',
        seedName = 'Wild_Rhubarb_Seed',
        seedAmount = 1,
        plantProp = 's_inv_rhubarb01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Wild Rhubarb',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Wild_Rhubarb',
                itemLabel = 'Wild Rhubarb',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Wintergreen Berry',
        seedName = 'Wintergreen_Berry_Seed',
        seedAmount = 1,
        plantProp = 's_inv_wintergreen01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Wintergreen Berry',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Wintergreen_Berry',
                itemLabel = 'Wintergreen Berry',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Potato',
        seedName = 'potatoseed',
        seedAmount = 1,
        plantProp = 's_desertsagepicked01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Potato',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'potato',
                itemLabel = 'Potato',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Wheat',
        seedName = 'wheatseed',
        seedAmount = 1,
        plantProp = 'crp_wheat_dry_aa_sim',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Wheat',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'wheat',
                itemLabel = 'Wheat',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Apple',
        seedName = 'Apple_Seed',
        seedAmount = 1,
        plantProp = 's_ginsengpicked01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Apple',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'apple',
                itemLabel = 'Apple',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    },
    -----------------------------------------------------
    {
        plantingToolRequired = true,
        plantingTool = 'hoe',
        plantingToolUsage = 2,
        plantingDistance = 1.5,
        plantName = 'Hummingbird Sage',
        seedName = 'Hummingbird_Sage_Seed',
        seedAmount = 1,
        plantProp = 's_ginsengpicked01x',
        soilRequired = false,
        soilAmount = 1,
        soilName = 'soil',
        timeToGrow = 900,
        plantOffset = 1,
        jobLocked = false,
        smelling = false,
        blips = {
            enabled = true,
            sprite = 'blip_mp_spawnpoint',
            name = 'Hummingbird Sage',
            color = 'WHITE'
        },
        rewards = {
            {
                itemName = 'Hummingbird_Sage',
                itemLabel = 'Hummingbird Sage',
                amount = 2
            }
        },
        jobs = {
            'farmer',
            'doctor'
        },
        lockCoords = false,
        coordsLockRange = 50,
        coordsLockTolerance = 0.75,
        coordsLocks = {
            vector3(1306.07, -1903.26, 52.26)
        }
    }
}
