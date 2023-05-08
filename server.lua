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
local discord = BccUtils.Discord.setup(Config.WebhookLink, 'BCC Farming', 'https://gamespot.com/a/uploads/original/1179/11799911/3383938-duck.jpg')

-------------------------------------- Main Setup -------------------------------------------------------------------------------
--Registering it usuable has to be done in a seperate thread other wise it will cause a removing dupe bug
Citizen.CreateThread(function()
  for key, v in pairs(Config.Farming) do
    VorpInv.RegisterUsableItem(v.Seedname, function(data)
      TriggerClientEvent('bcc-farming:IsPLayerNearTownCheck', data.source, data.source, v)
    end)
  end
end)

RegisterServerEvent('bcc-farming:PlayerNotNearTown', function(_source, v, isoutsideoftown)
  local charjob = false
  local itemCount2 = VorpInv.getItemCount(_source, v.PlantingTool) --Checks if you have the planting tool and how many you have
  local Character = VORPcore.getUser(_source).getUsedCharacter --gets the character the player is using
  if itemCount2 > 0 then --if you have one or more of the needed plant item then
    ------------------------------------------- Job Lock True Setup ------------------------------------------------      
    if v.Joblock then --if the config job lock is true
      for y, e in pairs(v.Jobs) do --creates a for loop in the job table
        if Character.job == e.JobName then --if your job matches one of the jobs in the table then
          charjob = true --sets the job catch variable to true allowing the removal of items
        end
      end
      if not charjob then
        VORPcore.NotifyRightTip(_source, Config.Language.Wrongjob, 10000) --prints on players screen
        return
      end
    end

    local itemCount = VorpInv.getItemCount(_source, v.Seedname) --checks to see how many of the seed you have
    ------------------------------- Item Removal / Client Event Trigger --------------------------------------------
    if itemCount and (itemCount >= v.SeedsRequired) then --if you have more than is required then
      if v.SoilName then
        local fertCount = VorpInv.getItemCount(_source, v.SoilName) --checks to see how many of the seed you have
        if not (fertCount and (fertCount > 0)) then
          VORPcore.NotifyRightTip(_source, Config.Language.NoSoil, 10000) --prints on screen
          return
        end
        VorpInv.subItem(_source, v.SoilName, 1) --removes the soil from your inventory
      end
      VorpInv.subItem(_source, v.Seedname, v.SeedsRequired) --removes the seeds from your inventory
      if v.Webhooked then
        discord:sendMessage(Config.Language.WebhookTitle .. tostring(Character.charIdentifier), Config.Language.Webhook_desc .. v.Type)
      end
	TriggerServerEvent('bcc-farming:metadata', v.PlantingTool,v.PlantingToolDurability)
      TriggerClientEvent('bcc-farming:plantcrop', _source, v.PlantProp, v.HarvestItem, v.HarvestAmount, v.TimetoGrow, isoutsideoftown, v.Type, v.FertTimeRemove, v.FertName) --triggers the client event and passes the 4 variables
    end
  else --else you dont have one then
    VORPcore.NotifyRightTip(_source, Config.Language.NoTool, 10000) --prints on screen
  end
end)

------------------------------------------- Item Metadata -----------------------------------------------
RegisterServerEvent("bcc-farming:metadata", function(name, uses)
	local _source = source
	local tool = VorpInv.getItem(_source, name)
	meta = tool["metadata"]
	if next(meta) == nil then
		VorpInv.subItem(_source, name, 1, {})
		VorpInv.addItem(_source, name, 1, { description = "Uses Left: " .. PlantingToolDurability - 1, durability = uses - 1 })
	else
		local durability = meta.durability - 1
		local description = "Uses Left: "
		VorpInv.subItem(_source, name, 1, meta)
		if 0 >= durability then
			VORPcore.NotifyRightTip(_source, "You're out of uses", 4000)
		else
			VorpInv.addItem(_source, name, 1,
				{ description = description .. durability, durability = durability })
		end
	end
end)

------------------------------------------- Crop Harvested Setup -----------------------------------------------
RegisterServerEvent('bcc-farming:CropHarvested', function(reward, amount)
  local _source = source
  VorpInv.addItem(_source, reward, amount) --adds the set items
  VORPcore.NotifyRightTip(_source, Config.Language.HarvestComplete, 10000) --prints on players screen
end)

---------------------------------------- Watering Bucket Check -------------------------------------
RegisterServerEvent('bcc-farming:WateringBucketCheck', function(blip, timer, reward, amount, plantcoords, object, plantid,ferttime, fertitem)
  local _source = source
  local itemCount = VorpInv.getItemCount(_source, Config.FullWaterBucket) --Checks if you have the watering bucket and how many you have
  if itemCount > 0 then -- if you have more than 0 then
    TriggerClientEvent('bcc-farming:WaterCrop', _source, 'water', blip, timer, reward, amount, plantcoords, object, plantid, ferttime, fertitem) --triggers the client event and passes hadbucket variable for client side catch
  else --else its not more than 0 then
    TriggerClientEvent('bcc-farming:WaterPlantMain', _source, plantcoords, timer, reward, amount, object, plantid, ferttime, fertitem)
    VORPcore.NotifyRightTip(_source, Config.Language.Nowaterbucket) --notifies in right side of screen you dont have the item
  end
end)

-------------------------------------- Fert Check --------------------------------
RegisterServerEvent('bcc-farming:FertCheck', function(blip, timer, reward, amount, plantcoords, object, plantid, ferttime, fertitem)
  local _source = source
  local itemCount = VorpInv.getItemCount(_source, fertitem) --Checks if you have the watering bucket and how many you have
  if itemCount > 0 then -- if you have more than 0 then
    timer = timer - ferttime
    TriggerClientEvent('bcc-farming:WaitUntilHarvest', _source, blip, timer, reward, amount, plantcoords, object, plantid)
    VorpInv.subItem(_source, fertitem, 1)
  else --else its not more than 0 then
    TriggerClientEvent('bcc-farming:WaterCrop', _source, 'fert', blip, timer, reward, amount, plantcoords, object, plantid, ferttime, fertitem) --triggers the client event and passes hadbucket variable for client side catch
    VORPcore.NotifyRightTip(_source, Config.Language.NoFerti, 4000) --notifies in right side of screen you dont have the item
  end
end)

--------------------------- Refill Bucket In Water Setup / Removing full bucket and adding empty after watering plant--------------------------------------
Citizen.CreateThread(function() --Create thread this runs the entire time
  VorpInv.RegisterUsableItem(Config.EmptyWaterBucket, function(data) --registers the item usable
    TriggerClientEvent('bcc-farming:PedInWaterClientCatch', data.source, data.source) --triggers client event to see if ped is in water
  end)
end)

RegisterServerEvent('bcc-farming:RefillWateringCan', function(_source)
  VORPcore.NotifyRightTip(_source, Config.Language.BucketFilled) --displays on screen
  VorpInv.subItem(_source, Config.EmptyWaterBucket, 1) --removes 1 item from config
  VorpInv.addItem(_source, Config.FullWaterBucket, 1) --adds one item from config
end)

RegisterServerEvent('bcc-farming:RemoveWaterBucket', function()
  local _source = source
  VorpInv.subItem(_source, Config.FullWaterBucket, 1)
  VorpInv.addItem(_source, Config.EmptyWaterBucket, 1)
end)

------------DataBase Testing-------------------------------------------
------------------------ Creates the db table--------------------------
Citizen.CreateThread(function()
  --Using oxmysql to create the table if its not already made every time script is launched
  exports.oxmysql:execute([[CREATE TABLE if NOT EXISTS `farming` (
    `identifier` varchar(50) NOT NULL,
    `charidentifier` int(11) NOT NULL,
    `planttype` varchar(50) NOT NULL,
    `x` varchar(50) NOT NULL,
    `y` varchar(50) NOT NULL,
    `z` varchar(50) NOT NULL,
    `timeleft` int(50) NOT NULL DEFAULT 0,
    `prop` varchar(50) NOT NULL,
    `plantid` int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY `plantid` (`plantid`),
    `watered` varchar(50) NOT NULL DEFAULT 0)
  ]])
end)

--this will load the plants from db
RegisterServerEvent('bcc-farming:loadplants', function()
  local _source = source --sets source
  local Character = VORPcore.getUser(_source).getUsedCharacter
  local Parameters = { ['@identifier'] = Character.identifier, ['@charid'] = Character.charIdentifier } --sets params
  exports.oxmysql:execute('SELECT * FROM farming WHERE identifier = @identifier AND charidentifier = @charid', Parameters, function(HasPlants) --gets all the rows in the database for the players info
    if HasPlants[1] then --if it is valid info then
      TriggerClientEvent("bcc-farming:clientspawnplantsinitload", _source, HasPlants) --trigger client event and pass the data too it
    end
  end)
end)


--Will be used to insert the plant into the databasetype, plantcoords, timer, prop, psource, timer, reward, amount, object
RegisterServerEvent('bcc-farming:dbinsert', function(type, plantcoords, prop, timer, reward, amount, object, ferttime,fertitem)
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter --checks the char used
  local param = { ['charidentifier'] = Character.charIdentifier, ['identifier'] = Character.identifier, ['planttype'] = type, ['x'] = plantcoords.x, ['y'] = plantcoords.y, ['z'] = plantcoords.z, ['timeleft'] = timer, ['prop'] = prop }
  --------The if you exist in db code was pulled from vorp_banking and modified ----------------
  exports.oxmysql:execute("INSERT INTO farming ( `charidentifier`,`identifier`,`planttype`,`x`,`y`,`z`,`timeleft`,`prop` ) VALUES ( @charidentifier,@identifier,@planttype,@x,@y,@z,@timeleft,@prop )", param) --If player is not in db this will create him in the db
  local rep = false
  repeat
    local ran = false
    exports.oxmysql:execute('SELECT * FROM farming WHERE identifier=@identifier AND charidentifier=@charidentifier AND x=@x AND y=@y AND z=@z', param, function(Plants2Id) --gets the data from farming table where the params match(uses x y z coords as a verify to make sure it gets the right id)
      ran = true
      if Plants2Id[1] then --if it is not nil then
        rep = true
        TriggerClientEvent('bcc-farming:WaterPlantMain', _source, plantcoords, timer, reward, amount, object, Plants2Id[1].plantid, ferttime,fertitem) --triggers the client event and passes the data too it
      end
    end)
    --This has to be done otherwise the repeat will run before the export is done causing it to run twice
    while true do
      Citizen.Wait(10)
      if ran then break end
    end
  until rep
end)

--This event will be used to update the players time remaining on the plant if they disconnect from the server
RegisterServerEvent('bcc-farming:LeftGameDBUpdate', function(plantid, timer)
  local param = { ['plantid'] = plantid, ['timeleft'] = timer }
  exports.oxmysql:execute("UPDATE farming SET `timeleft`=@timeleft WHERE plantid=@plantid", param)
end)

--This will be used to change the watered status of the plant
RegisterServerEvent('bcc-farming:watereddbset', function(plantid)
  local param = { ['watered'] = 'true', ['plantid'] = plantid } --sets the params
  exports.oxmysql:execute("UPDATE farming SET `watered`=@watered WHERE plantid=@plantid", param) --updates the watered column where the plant id is
end)

--This will be used to remove the plant from the database
RegisterServerEvent('bcc-farming:RemoveDBRow', function(plantid)
  local params = { ['plantid'] = plantid } --sets params
  exports.oxmysql:execute("DELETE FROM farming WHERE plantid=@plantid", params) --deletes the row that the plant id is on
end)

--This handles the version check
BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-farming')
