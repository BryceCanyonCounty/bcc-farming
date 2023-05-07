Config = {}

-------------------------------------------------Farming Setup!--------------------------------------------------------------
Config.FullWaterBucket = 'wateringcan' --This is the database name of the full Water Bucket(you will need this item to water your crops)
Config.EmptyWaterBucket = 'wateringcan_empty' --This is the database name of the empty Water Bucket(You will be able to refill this bucket)
Config.PlantBlips = true --True if you want a blip to show on the map where the plant is, false for no blips
Config.Plantintowns = false --Set this true if you want players to be able to plant in towns
Config.WebhookLink = '' --insert your webhook link here

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
        FertTimeRemove = 0, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'Yarrow_Seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 2, --Amount of seeds required to plant
        HarvestItem = 'Yarrow', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 5, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 30000, --The time in ms it will take the plant to grow (60000 is one minute)
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
        Webhooked = true, --if true when someone plants this a webhook will be sent
        Type = 'Hop', --Set this has to be unique to each plant, once set once do not change it will break the database
        PlantingTool = 'hoe', --This is the database name of the item that you have to have in your inventory in order to plant the crop
        PlantingToolDurability = '100',  --This is the amount of hit points the planting tool has
        PlantingToolUsage = '1',  --This is the amount of hit points the planting tool takes per plant
        PlantProp = 'rdr2_bush_snakeweedflower', --The prop model this is what will spawn in game when you plant.
        SoilName = false, -- This is the database name of the soil required to plant the seed. [false for none]
        FertName = 'fertilizer', --This is the item that will be used to fertilize the plant
        FertTimeRemove = 5000, --amount of time in ms the fertilizer will take off the TimetoGrow (if you do not want to use fertilizer for the plant set this too 0 and the option wont show)
        Seedname = 'hop_seed', --This is the database name of the seed that will be used to plant the plant
        SeedsRequired = 2, --Amount of seeds required to plant
        HarvestItem = 'hop', --This is the database name of the item you will recieve when you harvest the plant
        HarvestAmount = 5, --This is the amount you will recieve when harvesting the plant
        TimetoGrow = 30000, --The time in ms it will take the plant to grow (60000 is one minute)
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
Config.Language = {
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
    Webhook_desc = 'Has planted: '
}

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
