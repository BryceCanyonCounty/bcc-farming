Config = {}

-------------------------------------------------Farming Setup!--------------------------------------------------------------
Config.WebhookLink = '' --insert your webhook link here

----- Watering Cans Setup
Config.FullWaterBucket = 'wateringcan' --This is the database name of the full Water Bucket(you will need this item to water your crops)
Config.EmptyWaterBucket = 'wateringcan_empty' --This is the database name of the empty Water Bucket(You will be able to refill this bucket)

----- Plant in Town Setup
Config.PlantBlips = true --True if you want a blip to show on the map where the plant is, false for no blips
Config.Plantintowns = false --Set this true if you want players to be able to plant in towns

----- Farms Setup
Config.UseFarmingLocations = true  --- if true you can only plant in radius around farming locations set to false if you want to plant Everywhere
Config.UseLocationBlips = true --- if set to true the farming locations will get a blip
Config.FarmingLocations = {   ----- if you add more farm / fields make sure you are in the middle of it bcs the radius is surrounding the coords
    {
        location = {x = 1151.45, y = -962.16, z = 67.74}, ----------- Farm Near Rhodes
        radius = 55,
        blipname = 'Farm',   ------------- Name of the blip
        blipsprite = 'blip_plant',
    },
    {
        location = {x = 1030.43, y = -1979.46, z = 46.15}, ---------- Big Farm Near Braithworth Maner
        radius = 120,
        blipname = 'Farm',   ------------- Name of the blip
        blipsprite = 'blip_plant',
    },
    {
        location = {x = 1868.65, y = -1524.12, z = 45.0},  ---------- Big Tobacco Farm Calliga Hall
        radius = 120,
        blipname = 'Farm',   ------------- Name of the blip
        blipsprite = 'blip_plant',
    },
    {
        location = {x = 1140.07, y = 461.83, z = 96.98},    ------ Small Farm Next to Emerald Ranch under the A
        radius = 45,
        blipname = 'Farm',   ------------- Name of the blip
        blipsprite = 'blip_plant',
    },
}

----- Plants Setup
Config.Maxplants = 5 --The maximum amount of plants a player can plant. If set to 0 players will have no limit.
Config.DeleteAfterDays = 3 --If a plant is planted and is not harvested within this many days it will be deleted from the database
Config.Farming = {
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Yarrow', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100', --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'yarrow01_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed.  [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Yarrow_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Yarrow', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Hop', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'rdr2_bush_snakeweedflower', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'hop_seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'hop', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Agarita', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'p_dandyclump_01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Agarita_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Agarita', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Alaskan_Ginseng', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'alaskanginseng_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Alaskan_Ginseng_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Alaskan_Ginseng', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'American_Ginsen', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'ginseng_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'American_Ginseng_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'American_Ginseng', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Bay_Bolete', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_baybolete01bx', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Bay_Bolete_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Bay_Bolete', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Bitter_Weed', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_milkweed01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Bitter_Weed_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Bitter_Weed', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Black_Berry', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_blackberry01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Black_Berry_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Black_Berry', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Black_Currant', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_blackberry01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Black_Currant_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Black_Currant', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Blood_Flowe', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_bloodflower01bx', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Blood_Flower_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Blood_Flower', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Chanterelles', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_chanterelles01bx', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Chanterelles_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Chanterelles', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'cocoa', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_ginsengpicked01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'cocoaseeds', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'cocoa', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'corn', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_desertsage01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'cornseed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'corn', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Creekplum', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_blackberry01bx', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Creekplum_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Creekplum', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Crows', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_crowsgarlic01cx', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Crows_Garlic_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Crows_Garlic', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Deser', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_desertsage01ex', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Desert_Sage_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Desert_Sage', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Evergreen', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_wintergreen01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Evergreen_Huckleberry_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Evergreen_Huckleberry', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need

    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Golde', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'goldencurrant_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Golden_Currant_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Golden_Currant', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Indian', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_indiantobacco01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Indian_Tobbaco_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Indian_Tobbaco', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Milk', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_milkweed01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Milk_Weed_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Milk_Weed', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Oleander', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_oleander01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Oleander_Sage_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Oleander_Sage', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Parasol', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_parasol01bx', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Parasol_Mushroom_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Parasol_Mushroom', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you needs
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Prairie', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'prariepoppy_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Prairie_Poppy_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Prairie_Poppy', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Rams_Head', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_ramshead01bx', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Rams_Head_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Rams_Head', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Red_Raspberry', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_raspberry01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Red_Raspberry_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Red_Raspberry', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Red_Sage', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'redsage_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Red_Sage_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Red_Sage', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Saltbush', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_saltbush01ex', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Saltbush_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Saltbush', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'sugarcane', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_bloodflower01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'sugarcaneseed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'sugar', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Carrot', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'wildcarrot_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Wild_Carrot_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Wild_Carrot', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Feverfew', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_wildfeverfew01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Wild_Feverfew_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Wild_Feverfew', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Mint', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'wildmint_p', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Wild_Mint_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Wild_Mint', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Wild', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_rhubarb01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Wild_Rhubarb_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Wild_Rhubarb', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'Wint', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_inv_wintergreen01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Wintergreen_Berry_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'Wintergreen_Berry', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'pota', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 's_desertsagepicked01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'potatoseed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'potato', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
    {
        Webhooked = false, --if true when someone plants this a webhook will be sent
        Type = 'wheat', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'p_cs_haypiece01x', --The prop model this is what will spawn in game when you plant.
        SoilName = 'soil', -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 300000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'wheatseed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 1, --Amount of seeds required to plant
        HarvestItem = 'wheat', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 10, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 900000, --The time in ms it will take the plant to grow (60000 is one minute)
        Joblock = false, --If you want to joblock this plant set true, if not then set false
        Jobs = {
            {
                JobName = 'doctor', --the name of the job
            }, --you can have as many jobs as you want just copy and paste the table and change what you need
            {
                JobName = 'police',
            },
        },
    }, -- too add more plants just copy and paste the table and change what you need
}


------------------------------------------------TRANSLATE HERE!---------------------------------------------------------------
Config.Language = { ---- English
    Raking = 'Tilling the soil',
    Weeding = 'Planting the seeds',
    PlantFinished = 'You have finished planting the seeds',
    TimerText = 'Minutes until crop is Ready',
    ReadytoHarvest = 'Crop is ready to harvest',
    HarvestPrompt = 'Harvest Crop',
    Harvestingcrop = 'You are harvesting the crop',
    HarvestComplete = 'You harvested the crop',
    NoSoil = 'You do not have the correct soil to plant this crop',
    NoTool = 'You do not have the correct tool to plant this crop',
    Wrongjob = 'You do not have the correct job needed to plant this crop',
    WaterCropPrompt = 'Water Crop',
    Nowaterbucket = 'You do not have a Water Bucket',
    CropWatered = 'You watered the crop',
    Notinwater = 'You are not near water',
    BucketFilled = 'You filled a Water Bucket',
    Tooclosetotown = 'You are too close to a town',
    TooCloseToPlant = 'Too Close To another plant!',
    PlantWithFertilizer = 'Use Fertilizer?',
    UseFert = 'Fertilize',
    DoNotUseFertilizer = 'Do Not Use Fertilizer',
    NoFerti = 'You do not have fertilizer',
    WebhookTitle = 'Character Static Id: ',
    Webhook_desc = 'Has planted: ',
    OutOfUses = 'You have run out of uses',
    Maxplants = 'Max plant limit reached',
    NotInFarmingLocation = 'You are not near the Farm!',
    PlantBlip = "Your Plant"
}


--[[Config.Language = {  ----- German
    Raking = 'Den Boden bearbeiten',
    Weeding = 'Die Samen pflanzen',
    PlantFinished = 'Sie haben die Samen gepflanzt',
    TimerText = 'Es dauert nur wenige Minuten, bis die Ernte fertig ist',
    ReadytoHarvest = 'Die Ernte ist zur Ernte bereit',
    HarvestPrompt = 'Ernte Pflanze',
    Harvestingcrop = 'Sie ernten die Pflanze',
    HarvestComplete = 'Sie haben die Pflanze geerntet',
    NoSoil = 'Sie verfügen nicht über den richtigen Boden, um diese Pflanze anzupflanzen',
    NoTool = 'Sie verfügen nicht über das richtige Werkzeug, um diese Pflanze anzupflanzen',
    Wrongjob = 'Sie verfügen nicht über den richtigen Job, um diese Pflanze anzupflanzen',
    WaterCropPrompt = 'Pflanze Wässern',
    Nowaterbucket = 'Du hast keinen Wassereimer',
    CropWatered = 'Du hast die Plfanze gewässert',
    Notinwater = 'Du bist nicht in der nähe von Wasser',
    BucketFilled = 'Du hast einen Eimer gefüllt',
    Tooclosetotown = 'Du bist zu nah an einer Stadt',
    TooCloseToPlant = 'Zu nah an einer anderen Pflanze!',
    PlantWithFertilizer = 'Benutze Dünger ?',
    UseFert = 'Dünge',
    DoNotUseFertilizer = 'Benutze keinen Dünger',
    NoFerti = 'Du hast keinen Dünger',
    WebhookTitle = 'Character Static Id: ',
    Webhook_desc = 'Has planted: ',
    OutOfUses = 'Sie haben keine Verwendungsmöglichkeiten mehr',
    Maxplants = 'Sie haben die Maximale anzahl an Pflanzen erreicht',
    NotInFarmingLocation = 'Du bist Außerhalb der Farm!',
    PlantBlip = "Deine Pflanze"
}]]--

--------------------------------- Town Locations ------------------------------------------------------------------------------------
------------Ignore This for the most part. Unless you want to change the range of a town, or add more towns -------------------------
Config.Towns = { --creates a sub table in town table
    {
        coordinates = {x = -297.48, y = 791.1, z = 118.33}, --Valentine (the towns coords)
        range = 150, --The distance away you have to be to be considered outside of town
    },
    {
        coordinates = {x = 2930.95, y = 1348.91, z = 44.1}, --annesburg
        range = 250,
    },
    {
        coordinates = {x = 2632.52, y = -1312.31, z = 51.42}, --Saint denis
        range = 600,
    },
    {
        coordinates = {x = 1346.14, y = -1312.5, z = 76.53}, --Rhodes
        range = 200,
    },
    {
        coordinates = {x = -1801.09, y = -374.86, z = 161.15}, --strawberry
        range = 150,
    },
    {
        coordinates = {x = -801.77, y = -1336.43, z = 43.54}, --blackwater
        range = 350
    },
    {
        coordinates = {x = -3659.38, y = -2608.91, z = -14.08}, --armadillo
        range = 150,
    },
    {
        coordinates = {x = -5498.97, y = -2950.61, z = -1.62}, --Tumbleweed
        range = 100,
    }, --You can add more towns by copy and pasting one of the tables above and changing the coords and range to your liking
}
