Config = {
    defaultlang = "de_lang", -- Language file to use

    fullWaterBucketItem = "wateringcan", -- Item name for the full water bucket
    emptyWaterBucketItem = "wateringcan_empty", -- Item name for the empty water bucket

    plantSetup = {
        blips = false, -- If true, it will create blips for the plants
        deleteAfterDays = 3, -- Days after the plant will be deleted if not harvested (0 will disable, but it's not recommended)
        lockedToPlanter = false, -- If true, only the player who planted the seed will be able to harvest it
        maxPlants = 20, -- Maximum amount of plants a player can have
        plants = {
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Agarete", -- Name of the plant
                seedName = "Agarita_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Agarita",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Schafgarbe", -- Name of the plant
                seedName = "Yarrow_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "yarrow01_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Yarrow",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Hopfen", -- Name of the plant
                seedName = "hop_seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "rdr2_bush_snakeweedflower", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "hop",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Alaska Ginseng", -- Name of the plant
                seedName = "Alaskan_Ginseng_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "alaskanginseng_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Alaskan_Ginseng",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Amerikanischer Ginseng", -- Name of the plant
                seedName = "American_Ginseng_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "ginseng_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "American_Ginseng",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Brauner Steinpilz", -- Name of the plant
                seedName = "Bay_Bolete_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_milkweed01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Bay_Bolete",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Bittergras", -- Name of the plant
                seedName = "Bitter_Weed_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_milkweed01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Bitter_Weed",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Brombeer", -- Name of the plant
                seedName = "Black_Berry_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_blackberry01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Black_Berry",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Schwarze Johannisbeere", -- Name of the plant
                seedName = "Black_Currant_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_blackberry01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Black_Currant",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Blutblume", -- Name of the plant
                seedName = "Blood_Flower_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_bloodflower01bx", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Blood_Flower",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Pfifferlinge", -- Name of the plant
                seedName = "Chanterelles_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_chanterelles01bx", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Chanterelles",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Pfifferlinge", -- Name of the plant
                seedName = "Chanterelles_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_chanterelles01bx", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Chanterelles",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Kakao", -- Name of the plant
                seedName = "cocoaseeds", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "cocoa",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Mais", -- Name of the plant
                seedName = "cornseed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "crp_cornstalks_bb_sim", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "corn",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Bachpflaume", -- Name of the plant
                seedName = "Creekplum_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Creekplum",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Knoblauch", -- Name of the plant
                seedName = "Crows_Garlic_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Crows_Garlic",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Wüstensalbei", -- Name of the plant
                seedName = "Desert_Sage_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_desertsage01ex", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Desert_Sage",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Immergrüne Heidelbeere", -- Name of the plant
                seedName = "Evergreen_Huckleberry_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_desertsage01ex", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Evergreen_Huckleberry",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Goldene Johannisbeere", -- Name of the plant
                seedName = "Golden_Currant_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "goldencurrant_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Golden_Currant",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Indischer Tabak", -- Name of the plant
                seedName = "Indian_Tobbaco_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_indiantobacco01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = true, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Indian_Tobbaco",
                        amount = 15
                    }
                },
                jobs = {
                    'tabak',
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Milchkraut", -- Name of the plant
                seedName = "Milk_Weed_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_milkweed01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Milk_Weed",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Oleander Salbei", -- Name of the plant
                seedName = "Oleander_Sage_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_oleander01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Oleander_Sage",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Schirmpilz", -- Name of the plant
                seedName = "Parasol_Mushroom_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_parasol01bx", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Parasol_Mushroom",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Schirmpilz", -- Name of the plant
                seedName = "Parasol_Mushroom_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_parasol01bx", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Parasol_Mushroom",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Präriemohn", -- Name of the plant
                seedName = "Prairie_Poppy_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "prariepoppy_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Prairie_Poppy",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Widderkopf", -- Name of the plant
                seedName = "Rams_Head_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_ramshead01bx", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Rams_Head",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Rote Himbeere", -- Name of the plant
                seedName = "Red_Raspberry_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_raspberry01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Red_Raspberry",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Roter Salbei", -- Name of the plant
                seedName = "Red_Sage_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "redsage_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Red_Sage",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Salzbusch", -- Name of the plant
                seedName = "Saltbush_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_saltbush01ex", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Saltbush",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Zuckerrohr", -- Name of the plant
                seedName = "sugarcaneseed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_bloodflower01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "sugar",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Wilde Karotte", -- Name of the plant
                seedName = "Wild_Carrot_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "wildcarrot_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Wild_Carrot",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Wildes Mutterkraut", -- Name of the plant
                seedName = "Wild_Feverfew_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_wildfeverfew01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Wild_Feverfew",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Wilde Minze", -- Name of the plant
                seedName = "Wild_Mint_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "wildmint_p", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Wild_Mint",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Wilder Rhabarber", -- Name of the plant
                seedName = "Wild_Rhubarb_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_rhubarb01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Wild_Rhubarb",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Wintergrüne Beere", -- Name of the plant
                seedName = "Wintergreen_Berry_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_inv_wintergreen01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Wintergreen_Berry",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Kartoffel", -- Name of the plant
                seedName = "potatoseed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_desertsagepicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "potato",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Weizen", -- Name of the plant
                seedName = "wheatseed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "crp_wheat_dry_aa_sim", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "wheat",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Apfel", -- Name of the plant
                seedName = "Apple_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "apple",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Kolibri-Salbei", -- Name of the plant
                seedName = "Hummingbird_Sage_Seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Hummingbird_Sage",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Blaubeere", -- Name of the plant
                seedName = "blueberry_seed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "blueberry",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Vanille", -- Name of the plant
                seedName = "Vanillesamen", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "vanillaFlower",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            -------------------------- COUSTOM ITEMS DRUGS Xakra_Drugs -----------
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Pilze", -- Name of the plant
                seedName = "pilzsamen", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "mushroom",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Opium", -- Name of the plant
                seedName = "opiumsamen", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "opium",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Gras", -- Name of the plant
                seedName = "weedsamen", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "prop_weed_03", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "weed",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Trauben", -- Name of the plant
                seedName = "TraubenSeed", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Trauben",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Mandeln", -- Name of the plant
                seedName = "Mandelsamen", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Mandeln",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Zwiebeln", -- Name of the plant
                seedName = "Zwiebelsamen", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "Zwiebeln",
                        amount = 15
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 2, -- Durability of the tool required to plant the seed
                plantingToolUsage = 2, -- Durability usage of the tool required to plant the seed
                plantingDistance = 1.5, -- Distance between plants
                plantName = "Kokain", -- Name of the plant
                seedName = "kokasamen", -- Item name for the seed
                seedAmount = 1, -- Amount of soil required to plant the seed
                plantProp = "s_ginsengpicked01x", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizer", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 500, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1020, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "kokablatt",
                        amount = 15
                    }
                },
                jobs = {
                    'ble',
                    
                }
            },
        }
    },



----------------------------------------------TOWNS--------------------------------------------------------------

    townSetup = {
        canPlantInTowns = false, -- If true, players will be able to plant seeds in towns
        townLocations = {
            {
                coords = vector3(-297.48,  791.1, 118.33), -- Valentine
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(2930.95, 1348.91, 44.1), -- Annesburg
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(2632.52, -1312.31, 51.42), -- Saint Denis
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(1346.14, -1312.5, 76.53), -- Rhodes
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-1801.09, -374.86, 161.15), -- Strawberry
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-801.77, -1336.43, 43.54), -- Blackwater
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-3659.38, -2608.91, -14.08), -- Armadillo
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-5498.97, -2950.61, -1.62), -- Tumbleweed
                townRange = 150 -- Range where the town will be considered
            }
        }
    }
}