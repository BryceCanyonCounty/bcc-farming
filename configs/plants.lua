Plants = {
    {
        webhooked = false,              -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,    -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',           -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,          -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,         -- Distance between plants
        plantName = 'Agarita',          -- Name of the plant
        seedName = 'Agarita_Seed',      -- Item name for the seed
        seedAmount = 1,                 -- Number of seeds required to plant
        plantProp = 'p_tree_orange_01', -- Prop for the plant to be spawned
        soilRequired = false,           -- If true, the seed will require soil to be planted
        soilAmount = 1,                 -- Amount of soil required to plant the seed
        soilName = 'soil',              -- Item name for the soil required to plant the seed
        timeToGrow = 900,               -- Time in seconds for the plant to grow
        plantOffset = 1,                -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,              -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Agarita',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,           -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',        -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,       -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,      -- Distance between plants
        plantName = 'Yarrow',        -- Name of the plant
        seedName = 'Yarrow_Seed',    -- Item name for the seed
        seedAmount = 1,              -- Amount of soil required to plant the seed
        plantProp = 'yarrow01_p',    -- Prop for the plant to be spawned
        soilRequired = false,        -- If true, the seed will require soil to be planted
        soilAmount = 1,              -- Amount of soil required to plant the seed
        soilName = 'soil',           -- Item name for the soil required to plant the seed
        timeToGrow = 900,            -- Time in seconds for the plant to grow
        plantOffset = 1,             -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,           -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Yarrow',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                       -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,             -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',                    -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,                   -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,                  -- Distance between plants
        plantName = 'Hop',                       -- Name of the plant
        seedName = 'hop_seed',                   -- Item name for the seed
        seedAmount = 1,                          -- Amount of soil required to plant the seed
        plantProp = 'rdr2_bush_snakeweedflower', -- Prop for the plant to be spawned
        soilRequired = false,                    -- If true, the seed will require soil to be planted
        soilAmount = 1,                          -- Amount of soil required to plant the seed
        soilName = 'soil',                       -- Item name for the soil required to plant the seed
        timeToGrow = 900,                        -- Time in seconds for the plant to grow
        plantOffset = 1,                         -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                       -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'hop',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                 -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Alaskan Ginseng',     -- Name of the plant
        seedName = 'Alaskan_Ginseng_Seed', -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 'alaskanginseng_p',    -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                  -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Alaskan_Ginseng',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                  -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,        -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',               -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,              -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,             -- Distance between plants
        plantName = 'American Ginseng',     -- Name of the plant
        seedName = 'American_Ginseng_Seed', -- Item name for the seed
        seedAmount = 1,                     -- Amount of soil required to plant the seed
        plantProp = 'ginseng_p',            -- Prop for the plant to be spawned
        soilRequired = false,               -- If true, the seed will require soil to be planted
        soilAmount = 1,                     -- Amount of soil required to plant the seed
        soilName = 'soil',                  -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                    -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                  -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'American_Ginseng',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,            -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,  -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',         -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,        -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,       -- Distance between plants
        plantName = 'Bay Bolete',     -- Name of the plant
        seedName = 'Bay_Bolete_Seed', -- Item name for the seed
        seedAmount = 1,               -- Amount of soil required to plant the seed
        plantProp = 's_milkweed01x',  -- Prop for the plant to be spawned
        soilRequired = false,         -- If true, the seed will require soil to be planted
        soilAmount = 1,               -- Amount of soil required to plant the seed
        soilName = 'soil',            -- Item name for the soil required to plant the seed
        timeToGrow = 900,             -- Time in seconds for the plant to grow
        plantOffset = 1,              -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,            -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Bay_Bolete',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,             -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,   -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',          -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,         -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,        -- Distance between plants
        plantName = 'Bitter Weed',     -- Name of the plant
        seedName = 'Bitter_Weed_Seed', -- Item name for the seed
        seedAmount = 1,                -- Amount of soil required to plant the seed
        plantProp = 's_milkweed01x',   -- Prop for the plant to be spawned
        soilRequired = false,          -- If true, the seed will require soil to be planted
        soilAmount = 1,                -- Amount of soil required to plant the seed
        soilName = 'soil',             -- Item name for the soil required to plant the seed
        timeToGrow = 900,              -- Time in seconds for the plant to grow
        plantOffset = 1,               -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,             -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Bitter_Weed',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                 -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Black Berry',         -- Name of the plant
        seedName = 'Black_Berry_Seed',     -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_blackberry01x', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                  -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Black_Berry',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                 -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,       -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',              -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,             -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,            -- Distance between plants
        plantName = 'Black Currant',       -- Name of the plant
        seedName = 'Black_Currant_Seed',   -- Item name for the seed
        seedAmount = 1,                    -- Amount of soil required to plant the seed
        plantProp = 's_inv_blackberry01x', -- Prop for the plant to be spawned
        soilRequired = false,              -- If true, the seed will require soil to be planted
        soilAmount = 1,                    -- Amount of soil required to plant the seed
        soilName = 'soil',                 -- Item name for the soil required to plant the seed
        timeToGrow = 900,                  -- Time in seconds for the plant to grow
        plantOffset = 1,                   -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                 -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Black_Currant',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                   -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,         -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',                -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,               -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,              -- Distance between plants
        plantName = 'Blood Flower',          -- Name of the plant
        seedName = 'Blood_Flower_Seed',      -- Item name for the seed
        seedAmount = 1,                      -- Amount of soil required to plant the seed
        plantProp = 's_inv_bloodflower01bx', -- Prop for the plant to be spawned
        soilRequired = false,                -- If true, the seed will require soil to be planted
        soilAmount = 1,                      -- Amount of soil required to plant the seed
        soilName = 'soil',                   -- Item name for the soil required to plant the seed
        timeToGrow = 900,                    -- Time in seconds for the plant to grow
        plantOffset = 1,                     -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                   -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Blood_Flower',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                    -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,          -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',                 -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,                -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,               -- Distance between plants
        plantName = 'Chanterelles',           -- Name of the plant
        seedName = 'Chanterelles_Seed',       -- Item name for the seed
        seedAmount = 1,                       -- Amount of soil required to plant the seed
        plantProp = 's_inv_chanterelles01bx', -- Prop for the plant to be spawned
        soilRequired = false,                 -- If true, the seed will require soil to be planted
        soilAmount = 1,                       -- Amount of soil required to plant the seed
        soilName = 'soil',                    -- Item name for the soil required to plant the seed
        timeToGrow = 900,                     -- Time in seconds for the plant to grow
        plantOffset = 1,                      -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                    -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Chanterelles',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Cocoa',              -- Name of the plant
        seedName = 'cocoaseeds',          -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'cocoa',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                   -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,         -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',                -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,               -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,              -- Distance between plants
        plantName = 'Corn',                  -- Name of the plant
        seedName = 'cornseed',               -- Item name for the seed
        seedAmount = 1,                      -- Amount of soil required to plant the seed
        plantProp = 'crp_cornstalks_bb_sim', -- Prop for the plant to be spawned
        soilRequired = false,                -- If true, the seed will require soil to be planted
        soilAmount = 1,                      -- Amount of soil required to plant the seed
        soilName = 'soil',                   -- Item name for the soil required to plant the seed
        timeToGrow = 900,                    -- Time in seconds for the plant to grow
        plantOffset = 1,                     -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                   -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'corn',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Creekplum',          -- Name of the plant
        seedName = 'Creekplum_Seed',      -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Creekplum',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Crows Garlic',       -- Name of the plant
        seedName = 'Crows_Garlic_Seed',   -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Crows_Garlic',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                  -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,        -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',               -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,              -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,             -- Distance between plants
        plantName = 'Desert Sage',          -- Name of the plant
        seedName = 'Desert_Sage_Seed',      -- Item name for the seed
        seedAmount = 1,                     -- Amount of soil required to plant the seed
        plantProp = 's_inv_desertsage01ex', -- Prop for the plant to be spawned
        soilRequired = false,               -- If true, the seed will require soil to be planted
        soilAmount = 1,                     -- Amount of soil required to plant the seed
        soilName = 'soil',                  -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                    -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                  -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Desert_Sage',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                       -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,             -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',                    -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,                   -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,                  -- Distance between plants
        plantName = 'Evergreen Huckleberry',     -- Name of the plant
        seedName = 'Evergreen_Huckleberry_Seed', -- Item name for the seed
        seedAmount = 1,                          -- Amount of soil required to plant the seed
        plantProp = 's_inv_desertsage01ex',      -- Prop for the plant to be spawned
        soilRequired = false,                    -- If true, the seed will require soil to be planted
        soilAmount = 1,                          -- Amount of soil required to plant the seed
        soilName = 'soil',                       -- Item name for the soil required to plant the seed
        timeToGrow = 900,                        -- Time in seconds for the plant to grow
        plantOffset = 1,                         -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                       -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Evergreen_Huckleberry',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Golden Currant',     -- Name of the plant
        seedName = 'Golden_Currant_Seed', -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 'goldencurrant_p',    -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Golden_Currant',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Indian Tobbaco',     -- Name of the plant
        seedName = 'Indian_Tobbaco_Seed', -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_indiantobacco01x', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = true,                 -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Indian_Tobbaco',
                amount = 1
            }
        },
        jobs = {
            'tabak',
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,           -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',        -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,       -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,      -- Distance between plants
        plantName = 'Milk Weed',     -- Name of the plant
        seedName = 'Milk_Weed_Seed', -- Item name for the seed
        seedAmount = 1,              -- Amount of soil required to plant the seed
        plantProp = 's_milkweed01x', -- Prop for the plant to be spawned
        soilRequired = false,        -- If true, the seed will require soil to be planted
        soilAmount = 1,              -- Amount of soil required to plant the seed
        soilName = 'soil',           -- Item name for the soil required to plant the seed
        timeToGrow = 900,            -- Time in seconds for the plant to grow
        plantOffset = 1,             -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,           -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Milk_Weed',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,               -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,     -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',            -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,           -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,          -- Distance between plants
        plantName = 'Oleander Sage',     -- Name of the plant
        seedName = 'Oleander_Sage_Seed', -- Item name for the seed
        seedAmount = 1,                  -- Amount of soil required to plant the seed
        plantProp = 's_oleander01x',     -- Prop for the plant to be spawned
        soilRequired = false,            -- If true, the seed will require soil to be planted
        soilAmount = 1,                  -- Amount of soil required to plant the seed
        soilName = 'soil',               -- Item name for the soil required to plant the seed
        timeToGrow = 900,                -- Time in seconds for the plant to grow
        plantOffset = 1,                 -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,               -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Oleander_Sage',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                  -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,        -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',               -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,              -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,             -- Distance between plants
        plantName = 'Parasol Mushroom',     -- Name of the plant
        seedName = 'Parasol_Mushroom_Seed', -- Item name for the seed
        seedAmount = 1,                     -- Amount of soil required to plant the seed
        plantProp = 's_inv_parasol01bx',    -- Prop for the plant to be spawned
        soilRequired = false,               -- If true, the seed will require soil to be planted
        soilAmount = 1,                     -- Amount of soil required to plant the seed
        soilName = 'soil',                  -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                    -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                  -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Parasol_Mushroom',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,               -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,     -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',            -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,           -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,          -- Distance between plants
        plantName = 'Prairie Poppy',     -- Name of the plant
        seedName = 'Prairie_Poppy_Seed', -- Item name for the seed
        seedAmount = 1,                  -- Amount of soil required to plant the seed
        plantProp = 'prariepoppy_p',     -- Prop for the plant to be spawned
        soilRequired = false,            -- If true, the seed will require soil to be planted
        soilAmount = 1,                  -- Amount of soil required to plant the seed
        soilName = 'soil',               -- Item name for the soil required to plant the seed
        timeToGrow = 900,                -- Time in seconds for the plant to grow
        plantOffset = 1,                 -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,               -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Prairie_Poppy',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Rams Head',          -- Name of the plant
        seedName = 'Rams_Head_Seed',      -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_inv_ramshead01bx', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Rams_Head',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Red Raspberry',      -- Name of the plant
        seedName = 'Red_Raspberry_Seed',  -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_inv_raspberry01x', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Red_Raspberry',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,           -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',        -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,       -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,      -- Distance between plants
        plantName = 'Red Sage',      -- Name of the plant
        seedName = 'Red_Sage_Seed',  -- Item name for the seed
        seedAmount = 1,              -- Amount of soil required to plant the seed
        plantProp = 'redsage_p',     -- Prop for the plant to be spawned
        soilRequired = false,        -- If true, the seed will require soil to be planted
        soilAmount = 1,              -- Amount of soil required to plant the seed
        soilName = 'soil',           -- Item name for the soil required to plant the seed
        timeToGrow = 900,            -- Time in seconds for the plant to grow
        plantOffset = 1,             -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,           -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Red_Sage',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Saltbush',           -- Name of the plant
        seedName = 'Saltbush_Seed',       -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_inv_saltbush01ex', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Saltbush',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                  -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,        -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',               -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,              -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,             -- Distance between plants
        plantName = 'Sugar',                -- Name of the plant
        seedName = 'sugarcaneseed',         -- Item name for the seed
        seedAmount = 1,                     -- Amount of soil required to plant the seed
        plantProp = 's_inv_bloodflower01x', -- Prop for the plant to be spawned
        soilRequired = false,               -- If true, the seed will require soil to be planted
        soilAmount = 1,                     -- Amount of soil required to plant the seed
        soilName = 'soil',                  -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                    -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                  -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'sugar',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,             -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,   -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',          -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,         -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,        -- Distance between plants
        plantName = 'Wild Carrot',     -- Name of the plant
        seedName = 'Wild_Carrot_Seed', -- Item name for the seed
        seedAmount = 1,                -- Amount of soil required to plant the seed
        plantProp = 'wildcarrot_p',    -- Prop for the plant to be spawned
        soilRequired = false,          -- If true, the seed will require soil to be planted
        soilAmount = 1,                -- Amount of soil required to plant the seed
        soilName = 'soil',             -- Item name for the soil required to plant the seed
        timeToGrow = 900,              -- Time in seconds for the plant to grow
        plantOffset = 1,               -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,             -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Wild_Carrot',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,               -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,     -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',            -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,           -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,          -- Distance between plants
        plantName = 'Wild Feverfew',     -- Name of the plant
        seedName = 'Wild_Feverfew_Seed', -- Item name for the seed
        seedAmount = 1,                  -- Amount of soil required to plant the seed
        plantProp = 's_wildfeverfew01x', -- Prop for the plant to be spawned
        soilRequired = false,            -- If true, the seed will require soil to be planted
        soilAmount = 1,                  -- Amount of soil required to plant the seed
        soilName = 'soil',               -- Item name for the soil required to plant the seed
        timeToGrow = 900,                -- Time in seconds for the plant to grow
        plantOffset = 1,                 -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,               -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Wild_Feverfew',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,           -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',        -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,       -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,      -- Distance between plants
        plantName = 'Wild Mint',     -- Name of the plant
        seedName = 'Wild_Mint_Seed', -- Item name for the seed
        seedAmount = 1,              -- Amount of soil required to plant the seed
        plantProp = 'wildmint_p',    -- Prop for the plant to be spawned
        soilRequired = false,        -- If true, the seed will require soil to be planted
        soilAmount = 1,              -- Amount of soil required to plant the seed
        soilName = 'soil',           -- Item name for the soil required to plant the seed
        timeToGrow = 900,            -- Time in seconds for the plant to grow
        plantOffset = 1,             -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,           -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Wild_Mint',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,              -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,    -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',           -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,          -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,         -- Distance between plants
        plantName = 'Wild Rhubarb',     -- Name of the plant
        seedName = 'Wild_Rhubarb_Seed', -- Item name for the seed
        seedAmount = 1,                 -- Amount of soil required to plant the seed
        plantProp = 's_inv_rhubarb01x', -- Prop for the plant to be spawned
        soilRequired = false,           -- If true, the seed will require soil to be planted
        soilAmount = 1,                 -- Amount of soil required to plant the seed
        soilName = 'soil',              -- Item name for the soil required to plant the seed
        timeToGrow = 900,               -- Time in seconds for the plant to grow
        plantOffset = 1,                -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,              -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Wild_Rhubarb',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                   -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,         -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',                -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,               -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,              -- Distance between plants
        plantName = 'Wintergreen Berry',     -- Name of the plant
        seedName = 'Wintergreen_Berry_Seed', -- Item name for the seed
        seedAmount = 1,                      -- Amount of soil required to plant the seed
        plantProp = 's_inv_wintergreen01x',  -- Prop for the plant to be spawned
        soilRequired = false,                -- If true, the seed will require soil to be planted
        soilAmount = 1,                      -- Amount of soil required to plant the seed
        soilName = 'soil',                   -- Item name for the soil required to plant the seed
        timeToGrow = 900,                    -- Time in seconds for the plant to grow
        plantOffset = 1,                     -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                   -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Wintergreen_Berry',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                   -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,         -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',                -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,               -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,              -- Distance between plants
        plantName = 'Potato',                -- Name of the plant
        seedName = 'potatoseed',             -- Item name for the seed
        seedAmount = 1,                      -- Amount of soil required to plant the seed
        plantProp = 's_desertsagepicked01x', -- Prop for the plant to be spawned
        soilRequired = false,                -- If true, the seed will require soil to be planted
        soilAmount = 1,                      -- Amount of soil required to plant the seed
        soilName = 'soil',                   -- Item name for the soil required to plant the seed
        timeToGrow = 900,                    -- Time in seconds for the plant to grow
        plantOffset = 1,                     -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                   -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'potato',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                  -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,        -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',               -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,              -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,             -- Distance between plants
        plantName = 'Wheat',                -- Name of the plant
        seedName = 'wheatseed',             -- Item name for the seed
        seedAmount = 1,                     -- Amount of soil required to plant the seed
        plantProp = 'crp_wheat_dry_aa_sim', -- Prop for the plant to be spawned
        soilRequired = false,               -- If true, the seed will require soil to be planted
        soilAmount = 1,                     -- Amount of soil required to plant the seed
        soilName = 'soil',                  -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                    -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                  -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'wheat',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,      -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',             -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,            -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,           -- Distance between plants
        plantName = 'Apple',              -- Name of the plant
        seedName = 'Apple_Seed',          -- Item name for the seed
        seedAmount = 1,                   -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x', -- Prop for the plant to be spawned
        soilRequired = false,             -- If true, the seed will require soil to be planted
        soilAmount = 1,                   -- Amount of soil required to plant the seed
        soilName = 'soil',                -- Item name for the soil required to plant the seed
        timeToGrow = 900,                 -- Time in seconds for the plant to grow
        plantOffset = 1,                  -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'apple',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    },
    -----------------------------------------------------
    {
        webhooked = false,                  -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
        plantingToolRequired = true,        -- If true, the player will need a tool to plant the seed
        plantingTool = 'hoe',               -- Item name for the planting tool (Durability starts at 100)
        plantingToolUsage = 2,              -- Durability value removed from the tool when planting a seed
        plantingDistance = 1.5,             -- Distance between plants
        plantName = 'Hummingbird Sage',     -- Name of the plant
        seedName = 'Hummingbird_Sage_Seed', -- Item name for the seed
        seedAmount = 1,                     -- Amount of soil required to plant the seed
        plantProp = 's_ginsengpicked01x',   -- Prop for the plant to be spawned
        soilRequired = false,               -- If true, the seed will require soil to be planted
        soilAmount = 1,                     -- Amount of soil required to plant the seed
        soilName = 'soil',                  -- Item name for the soil required to plant the seed
        timeToGrow = 900,                   -- Time in seconds for the plant to grow
        plantOffset = 1,                    -- If the plant is not on the ground properly you can use this setting
        jobLocked = false,                  -- If true, only players with the job will be able to harvest the plant
        rewards = {
            {
                itemName = 'Hummingbird_Sage',
                amount = 1
            }
        },
        jobs = {
            'farmer',
            'doctor'
        }
    }
    -----------------------------------------------------
}
