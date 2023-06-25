----------- Pulling Essentials ---------
local VorpInv = {}
VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPcore = {}
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
local BccUtils = {}
TriggerEvent('bcc:getUtils', function(bccutils)
  BccUtils = bccutils
end)
local discord = BccUtils.Discord.setup(Config.WebhookLink, 'BCC Farming',
  'https://gamespot.com/a/uploads/original/1179/11799911/3383938-duck.jpg')
local PlantNumber

-------------------------------------- Main Setup -------------------------------------------------------------------------------
--Registering it usuable has to be done in a seperate thread other wise it will cause a removing dupe bug
CreateThread(function()
  for key, v in pairs(Config.Farming) do
    VorpInv.RegisterUsableItem(v.Seedname, function(data)
      if Config.MaxPlants then
        TriggerEvent('bcc-farming:getplantnumber', data.source)
        Wait(250)
        if PlantNumber < Config.MaxPlantsNumber then
          TriggerClientEvent('bcc-farming:IsPLayerNearTownCheck', data.source, data.source, v)
          VorpInv.CloseInv(data.source)
        else
          VORPcore.NotifyRightTip(data.source, Config.Language.TooManyPlants, 6000)
        end
      else
        TriggerClientEvent('bcc-farming:IsPLayerNearTownCheck', data.source, data.source, v)
        VorpInv.CloseInv(data.source)
      end
    end)
  end
end)



RegisterServerEvent('bcc-farming:PlayerNotNearTown', function(_source, v, isoutsideoftown)
  local charjob = false
  local itemCount2 = VorpInv.getItemCount(_source, v.PlantingTool)
  local Character = VORPcore.getUser(_source).getUsedCharacter
  if itemCount2 > 0 then
    ------------------------------------------- Job Lock True Setup ------------------------------------------------
    if v.Joblock then
      for y, e in pairs(v.Jobs) do
        if Character.job == e.JobName then
          charjob = true
        end
      end
      if not charjob then
        VORPcore.NotifyRightTip(_source, Config.Language.Wrongjob, 10000)
        return
      end
    end

    local itemCount = VorpInv.getItemCount(_source, v.Seedname)
    ------------------------------- Item Removal / Client Event Trigger -------------------------------------------
    if itemCount and (itemCount >= v.SeedsRequired) then
      if v.SoilName then
        local fertCount = VorpInv.getItemCount(_source, v.SoilName)
        if not (fertCount and (fertCount > 0)) then
          VORPcore.NotifyRightTip(_source, Config.Language.NoSoil, 10000)
          return
        end
        VorpInv.subItem(_source, v.SoilName, 1)
      end
      VorpInv.subItem(_source, v.Seedname, v.SeedsRequired)
      VORPcore.NotifyRightTip(_source, Config.Language.OpenedSeeds, 10000)


      if v.Webhooked then
        discord:sendMessage(Config.Language.WebhookTitle .. tostring(Character.charIdentifier),
          Config.Language.Webhook_desc .. v.Type)
      end
      TriggerClientEvent('bcc-farming:plantcrop', _source, v, isoutsideoftown)
    end
  else
    VORPcore.NotifyRightTip(_source, Config.Language.NoTool, 10000)
  end
end)

------------------------------------------- Item Metadata -----------------------------------------------
RegisterServerEvent("bcc-farming:metadata", function(source, name, uses, hits)
  local PlantingToolDurability = uses
  local PlantingToolUsage = hits
  local _source = source
  local tool = VorpInv.getItem(_source, name)
  local meta = tool["metadata"]
  if next(meta) == nil then
    VorpInv.subItem(_source, name, 1, {})
    VorpInv.addItem(_source, name, 1,
      {
        description = "Uses Left: " .. PlantingToolDurability - PlantingToolUsage,
        durability = PlantingToolDurability - PlantingToolUsage
      })
  else
    local durability = meta.durability - PlantingToolUsage
    local description = "Uses Left: "
    VorpInv.subItem(_source, name, 1, meta)
    if 0 >= durability then
      VORPcore.NotifyRightTip(_source, Config.Language.OutOfUses, 4000)
    else
      VorpInv.addItem(_source, name, 1, { description = description .. durability, durability = durability })
    end
  end
end)

------------------------------------------- Crop Harvested Setup -----------------------------------------------
RegisterServerEvent('bcc-farming:CropHarvested', function(reward, amount, trimmed, trimmedamount)
  local _source = source
  if trimmed then
    VorpInv.addItem(_source, reward, trimmedamount)
  else
    VorpInv.addItem(_source, reward, amount)
  end
  VORPcore.NotifyRightTip(_source, Config.Language.HarvestComplete, 10000)
end)

---------------------------------------- Watering Bucket Check -------------------------------------
RegisterServerEvent('bcc-farming:WateringBucketCheck', function()
  local _source = source
  local itemCount = VorpInv.getItemCount(_source, Config.FullWaterBucket)
  if itemCount > 0 then
    TriggerClientEvent('bcc-farming:GotBucket', _source)
    TriggerEvent('bcc-farming:metadata', _source, Config.FullWaterBucket, 5, 1)
  else
    VORPcore.NotifyRightTip(_source, Config.Language.Nowaterbucket)
  end
end)

-------------------------------------- Fert Check --------------------------------
RegisterServerEvent('bcc-farming:TrimPlant', function(blip, v, plantcoords, object, plantid, timer, fertilized)
  local _source = source
  local itemCount = VorpInv.getItemCount(_source, v.TrimTool)
  local timer = timer
  if itemCount > 0 then
    TriggerEvent('bcc-farming:metadata', _source, v.TrimTool, 5, 1)
    TriggerClientEvent('bcc-farming:WaitUntilHarvest', _source, blip, timer, v, plantcoords, object, plantid, fertilized,
      true)
    TriggerEvent('bcc-farming:trimmeddbset', plantid)
  else
    TriggerClientEvent('bcc-farming:WaitUntilHarvest', _source, blip, timer, v, plantcoords, object, plantid, fertilized,
      false)
    VORPcore.NotifyRightTip(_source, Config.Language.NoTrim, 4000)
  end
end)

-------------------------------------- Fert Check --------------------------------
RegisterServerEvent('bcc-farming:FertCheck', function(blip, v, plantcoords, object, plantid, watered)
  local _source = source
  local itemCount = VorpInv.getItemCount(_source, v.FertName)
  local timer = v.TimetoGrow
  local fertilized
  if itemCount > 0 then
    timer = timer - v.FertTimeRemove
    fertilized = true
    TriggerClientEvent('bcc-farming:WaitUntilHarvest', _source, blip, timer, v, plantcoords, object, plantid, fertilized,
      watered)
    VorpInv.subItem(_source, v.FertName, 1)
    TriggerEvent('bcc-farming:fertilizerdbset', plantid)
  else
    fertilized = false
    TriggerClientEvent('bcc-farming:WaitUntilHarvest', _source, blip, timer, v, plantcoords, object, plantid, fertilized,
      watered)
    VORPcore.NotifyRightTip(_source, Config.Language.NoFerti, 4000)
  end
end)

--------------------------- Refill Bucket In Water Setup / Removing full bucket and adding empty after watering plant--------------------------------------
CreateThread(function()
  VorpInv.RegisterUsableItem(Config.EmptyWaterBucket, function(data)
    TriggerClientEvent('bcc-farming:PedInWaterClientCatch', data.source, data.source)
  end)
end)

RegisterServerEvent('bcc-farming:RefillWateringCan', function(source)
  local _source = source
  local itemCount = VorpInv.getItemCount(_source, Config.EmptyWaterBucket)
  if itemCount >= 1 then
    VORPcore.NotifyRightTip(_source, Config.Language.BucketFilled)
    VorpInv.subItem(_source, Config.EmptyWaterBucket, 1)
    VorpInv.addItem(_source, Config.FullWaterBucket, 1)
  else
    VORPcore.NotifyRightTip(_source, Config.Language.Nowaterbucket)
  end
end)

RegisterServerEvent('bcc-farming:RemoveWaterBucket', function(source)
  local _source = source
  VorpInv.subItem(_source, Config.FullWaterBucket, 1)
  VorpInv.addItem(_source, Config.EmptyWaterBucket, 1)
end)

------------DataBase Testing-------------------------------------------
------------------------ Creates the db table--------------------------
CreateThread(function()
  exports.oxmysql:execute([[CREATE TABLE if NOT EXISTS `farming` (
    `identifier` varchar(50) NOT NULL,
    `charidentifier` int(11) NOT NULL,
    `planttype` varchar(50) NOT NULL,
    `plantcoords` LONGTEXT NOT NULL,
    `timeleft` int(50) NOT NULL DEFAULT 0,
    `prop` varchar(50) NOT NULL,
    `plantid` int NOT NULL AUTO_INCREMENT,
    `planted_on` varchar(50) NOT NULL,
    PRIMARY KEY `plantid` (`plantid`),
    `watered` varchar(50) NOT NULL DEFAULT 0)
  ]])
end)

--------- Database Cleaner (Delete if plants have not harvested after x days) -------------
CreateThread(function()
  exports.oxmysql:execute('SELECT * FROM farming', function(result)
    if result[1] then --if it is valid info then
      for k, v in pairs(result) do
        local daysSincePlant = os.difftime(os.time(), v.planted_on) / (24 * 60 * 60)
        local wholeDaysSincePlant = math.floor(daysSincePlant)
        if wholeDaysSincePlant >= Config.DeleteAfterDays then
          local param = { ['plantid'] = v.plantid }
          exports.oxmysql:execute("DELETE FROM farming WHERE plantid=@plantid", param)
        end
      end
    end
  end)
end)

------- Get Plants Number -----
RegisterServerEvent('bcc-farming:getplantnumber', function(source)
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local Parameters = { ['@identifier'] = Character.identifier, ['@charid'] = Character.charIdentifier }
  exports.oxmysql:execute('SELECT * FROM farming WHERE identifier = @identifier AND charidentifier = @charid', Parameters,
    function(HasPlants)
      PlantNumber = #HasPlants
    end)
end)

------- Fill Water Wagon -----
RegisterServerEvent('bcc-farming:AffectWaterWagon', function(type, wagonmodel)
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local water
  local emptybucket = VorpInv.getItemCount(_source, Config.EmptyWaterBucket)
  local fullbucket = VorpInv.getItemCount(_source, Config.FullWaterBucket)

  local Parameters = {
    ['@identifier'] = Character.identifier,
    ['@charid'] = Character.charIdentifier,
    ['@model'] = wagonmodel,
  }
  exports.oxmysql:execute(
    'SELECT water FROM wagons WHERE identifier = @identifier AND charid = @charid AND model = @model', Parameters,
    function(result)
      print(result[1].water)
      if result[1].water then
        water = result[1].water
        local Parameters2 = {
          ['@identifier'] = Character.identifier,
          ['@charid'] = Character.charIdentifier,
          ['@model'] = wagonmodel,
          ['@water'] = water
        }
        if type == 'fill' then
          if fullbucket >= 1 then
            exports.oxmysql:execute(
              "UPDATE wagons SET `water`= @water+1 WHERE identifier = @identifier AND charid = @charid AND model = @model",
              Parameters2)
            TriggerEvent('bcc-farming:RemoveWaterBucket', _source)
            TriggerClientEvent('bcc-farming:PedUsingWagon', _source, 'fill')
          else
            VORPcore.NotifyRightTip(_source, Config.Language.Nowaterbucket)
          end
        else
          if water > 0 and emptybucket >= 1 then
            exports.oxmysql:execute(
              "UPDATE wagons SET `water`= @water-1 WHERE identifier = @identifier AND charid = @charid AND model = @model",
              Parameters2)
            TriggerEvent('bcc-farming:RefillWateringCan', _source)
            TriggerClientEvent('bcc-farming:PedUsingWagon', _source, 'empty')
          else
            VORPcore.NotifyRightTip(_source, Config.Language.Nowater)
          end
        end
      end
    end)
end)

------- Load Plants on join setup -----
RegisterServerEvent('bcc-farming:loadplants', function()
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local Parameters = { ['@identifier'] = Character.identifier, ['@charid'] = Character.charIdentifier }
  exports.oxmysql:execute('SELECT * FROM farming WHERE identifier = @identifier AND charidentifier = @charid', Parameters,
    function(HasPlants)
      if HasPlants[1] then --if it is valid info then
        TriggerClientEvent("bcc-farming:clientspawnplantsinitload", _source, HasPlants)
      end
    end)
end)

------------ Inserting Plants into DB ----------------
RegisterServerEvent('bcc-farming:dbinsert', function(v, plantcoords, object, isoutsideoftown)
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local time = os.time()
  local param = {
    ['charidentifier'] = Character.charIdentifier,
    ['identifier'] = Character.identifier,
    ['planttype'] = v.Type,
    ['plantcoords'] = json.encode(plantcoords),
    ['timeleft'] = v.TimetoGrow,
    ['prop'] = v.PlantProp,
    ['plant_on'] = time
  }
  --------The if you exist in db code was pulled from vorp_banking and modified ----------------
  MySQL.query.await(
    "INSERT INTO farming ( `charidentifier`,`identifier`,`planttype`,`plantcoords`,`timeleft`,`prop`,`planted_on` ) VALUES ( @charidentifier,@identifier,@planttype,@plantcoords,@timeleft,@prop,@plant_on )",
    param)

  local result = MySQL.query.await(
    'SELECT * FROM farming WHERE identifier=@identifier AND charidentifier=@charidentifier AND planted_on=@plant_on',
    param)
  TriggerEvent('bcc-farming:metadata', _source, v.PlantingTool, v.PlantingToolDurability, v.PlantingToolUsage)
  TriggerClientEvent('bcc-farming:WaterPlantMain', _source, plantcoords, v, object, result[1].plantid)
end)

----------------- Left game setup --------------
RegisterServerEvent('bcc-farming:LeftGameDBUpdate', function(plantid, timer)
  local param = { ['plantid'] = plantid, ['timeleft'] = timer }
  exports.oxmysql:execute("UPDATE farming SET `timeleft`=@timeleft WHERE plantid=@plantid", param)
end)

------ Changing Watered Status --------------
RegisterServerEvent('bcc-farming:watereddbset', function(plantid)
  local param = { ['watered'] = 'true', ['plantid'] = plantid }
  exports.oxmysql:execute("UPDATE farming SET `watered`=@watered WHERE plantid=@plantid", param)
end)

RegisterServerEvent('bcc-farming:trimmeddbset', function(plantid)
  local param = { ['trimmed'] = 'true', ['plantid'] = plantid }
  exports.oxmysql:execute("UPDATE farming SET `trimmed`=@trimmed WHERE plantid=@plantid", param)
end)

RegisterServerEvent('bcc-farming:fertilizerdbset', function(plantid)
  local param = { ['fertilized'] = 'true', ['plantid'] = plantid }
  exports.oxmysql:execute("UPDATE farming SET `fertilized`=@fertilized WHERE plantid=@plantid", param)
end)

RegisterServerEvent('bcc-farming:raindbset', function()
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local Parameters = {
    ['@identifier'] = Character.identifier,
    ['@charid'] = Character.charIdentifier,
    ['watered'] = 'true'
  }
  exports.oxmysql:execute("UPDATE farming SET `watered`=@watered WHERE identifier=@identifier AND charid = @charid",
    Parameters)
end)

------ Delete DB entry --------
RegisterServerEvent('bcc-farming:RemoveDBRow', function(plantid)
  local params = { ['plantid'] = plantid }
  exports.oxmysql:execute("DELETE FROM farming WHERE plantid=@plantid", params)
end)

---------- Version Check ---------------
BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-farming')
