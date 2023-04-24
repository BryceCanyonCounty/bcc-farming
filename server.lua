--Pulls vorp inventory and core
local VorpInv = {}
VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPcore = {}
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
--ends pulling inv and core

-------------------------------------- Main Setup -------------------------------------------------------------------------------
--Registering it usuable has to be done in a seperate thread other wise it will cause a removing dupe bug
Citizen.CreateThread(function()
  for key, v in pairs(Config.Farming) do
    VorpInv.RegisterUsableItem(v.Seedname, function(data)
      local _source = data.source
      TriggerClientEvent('bcc-farming:IsPLayerNearTownCheck', data.source, _source, v)
    end)
  end
end)

RegisterServerEvent('bcc-farming:PlayerNotNearTown') --Creates a server event
AddEventHandler('bcc-farming:PlayerNotNearTown', function(_source, v, isoutsideoftown) --makes the event have code and catches _source from client
  local psource = _source
  local charjob= false
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
      if v.FertName then
        local fertCount = VorpInv.getItemCount(_source, v.FertName) --checks to see how many of the seed you have
        if not (fertCount and (fertCount > 0)) then
          VORPcore.NotifyRightTip(_source, Config.Language.NoFert, 10000) --prints on screen
          return
        end
      end
      VorpInv.subItem(_source, v.Seedname, v.SeedsRequired) --removes the seeds from your inventory
      local prop = v.PlantProp --setst this variable to the model set in the config
      local reward = v.HarvestItem --sets this variable to the reward item set in the config
      local amount = v.HarvestAmount --sets this variable to the amount of the rewards you get set in the config
      local timer = v.TimetoGrow --ssets the variable to the config option
      local type = v.Type
      TriggerClientEvent('bcc-farming:plantcrop', _source, prop, reward, amount, timer, isoutsideoftown, type) --triggers the client event and passes the 4 variables
    end
  else --else you dont have one then
    VORPcore.NotifyRightTip(_source, Config.Language.NoTool, 10000) --prints on screen
  end
end)

------------------------------------------- Crop Harvested Setup -----------------------------------------------
RegisterServerEvent('bcc-farming:CropHarvested') --makes a server event
AddEventHandler('bcc-farming:CropHarvested', function(reward, amount) --makes the vent have code to run, and recieves the 3 variables from client. _source is necessary as source wont work, as the whole code is events
  local _source = source
  VorpInv.addItem(_source, reward, amount) --adds the set items
  VORPcore.NotifyRightTip(_source, Config.Language.HarvestComplete, 10000) --prints on players screen
end)

---------------------------------------- Watering Bucket Check -------------------------------------
RegisterServerEvent('bcc-farming:WateringBucketCheck')
AddEventHandler('bcc-farming:WateringBucketCheck', function(blip, timer, reward, amount, plantcoords, object, plantid)
  local _source = source
  local itemCount = VorpInv.getItemCount(_source, Config.FullWaterBucket) --Checks if you have the watering bucket and how many you have
  if itemCount > 0 then -- if you have more than 0 then
    TriggerClientEvent('bcc-farming:WaterCrop', _source, blip, timer, reward, amount, plantcoords, object, plantid) --triggers the client event and passes hadbucket variable for client side catch
  else --else its not more than 0 then
    TriggerClientEvent('bcc-farming:WaterPlantMain', _source, plantcoords, timer, reward, amount, object, plantid)
    VORPcore.NotifyRightTip(_source, Config.Language.Nowaterbucket) --notifies in right side of screen you dont have the item
  end
end)

--------------------------- Refill Bucket In Water Setup / Removing full bucket and adding empty after watering plant--------------------------------------
Citizen.CreateThread(function() --Create thread this runs the entire time
  VorpInv.RegisterUsableItem(Config.EmptyWaterBucket, function(data) --registers the item usable
    local _source = data.source --sets _source to data.source so we can pass to client
    TriggerClientEvent('bcc-farming:PedInWaterClientCatch', data.source, _source) --triggers client event to see if ped is in water
  end)
end)

RegisterServerEvent('bcc-farming:RefillWateringCan') --registers server event
AddEventHandler('bcc-farming:RefillWateringCan', function(_source) --adds code for the event to run, and catches _source from client
  VORPcore.NotifyRightTip(_source, Config.Language.BucketFilled) --displays on screen
  VorpInv.subItem(_source, Config.EmptyWaterBucket, 1) --removes 1 item from config
  VorpInv.addItem(_source, Config.FullWaterBucket, 1) --adds one item from config
end)

RegisterServerEvent('bcc-farming:RemoveWaterBucket') -- same as above
AddEventHandler('bcc-farming:RemoveWaterBucket', function()
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
RegisterServerEvent('bcc-farming:loadplants')
AddEventHandler('bcc-farming:loadplants', function()
  local _source = source --sets source
  local Character = VORPcore.getUser(source).getUsedCharacter
  local u_charid = Character.charIdentifier
  local u_identifier = Character.identifier
  local Parameters = { ['@identifier'] = u_identifier, ['@charid'] = u_charid } --sets params
  exports.oxmysql:execute('SELECT * FROM farming WHERE identifier = @identifier AND charidentifier = @charid', Parameters, function(HasPlants) --gets all the rows in the database for the players info
    if HasPlants[1] then --if it is valid info then
      TriggerClientEvent("bcc-farming:clientspawnplantsinitload", _source, HasPlants) --trigger client event and pass the data too it
    end
  end)
end)


--Will be used to insert the plant into the databasetype, plantcoords, timer, prop, psource, timer, reward, amount, object
RegisterServerEvent('bcc-farming:dbinsert')
AddEventHandler('bcc-farming:dbinsert', function(type, plantcoords, prop, timer, reward, amount, object) --catches all the data from client
  local _source = source
  local Character = VORPcore.getUser(_source).getUsedCharacter --checks the char used
  local charidentifier = Character.charIdentifier              --This is the static id of your character
  local identifier = Character.identifier                      --steam id
  local plantx = plantcoords.x
  local planty = plantcoords.y
  local plantz = plantcoords.z
  local planttype = type
  local timeleft = timer
  local propp = prop
  local param = { ['charidentifier'] = charidentifier,['identifier'] = identifier, ['planttype'] = planttype, ['x'] = plantx, ['y'] = planty, ['z'] = plantz, ['timeleft'] = timeleft, ['prop'] = propp }
  --------The if you exist in db code was pulled from vorp_banking and modified ----------------
  exports.oxmysql:execute("INSERT INTO farming ( `charidentifier`,`identifier`,`planttype`,`x`,`y`,`z`,`timeleft`,`prop` ) VALUES ( @charidentifier,@identifier,@planttype,@x,@y,@z,@timeleft,@prop )", param) --If player is not in db this will create him in the db
  Wait(2000) --waits 2 seconds giving the server ample time to run the query above
  exports.oxmysql:execute('SELECT * FROM farming WHERE identifier=@identifier AND charidentifier=@charidentifier AND x=@x AND y=@y AND z=@z', param, function(Plants2Id) --gets the data from farming table where the params match(uses x y z coords as a verify to make sure it gets the right id)
    if Plants2Id[1] then --if it is not nil then
      local plantid = Plants2Id[1].plantid --sets the var to = the id
      TriggerClientEvent('bcc-farming:plantcrop2', _source, plantcoords, timer, reward, amount, object, plantid) --triggers the client event and passes the data too it
    end
  end)
end)

--This event will be used to update the players time remaining on the plant if they disconnect from the server
RegisterServerEvent('bcc-farming:LeftGameDBUpdate')
AddEventHandler('bcc-farming:LeftGameDBUpdate', function(plantid, timer)
  local param = { ['plantid'] = plantid, ['timeleft'] = timer }
  exports.oxmysql:execute("UPDATE farming SET `timeleft`=@timeleft WHERE plantid=@plantid", param)
end)

--This will be used to change the watered status of the plant
RegisterServerEvent('bcc-farming:watereddbset')
AddEventHandler('bcc-farming:watereddbset', function(plantid) --catches plantid from client
  local param = { ['watered'] = 'true', ['plantid'] = plantid } --sets the params
  exports.oxmysql:execute("UPDATE farming SET `watered`=@watered WHERE plantid=@plantid", param) --updates the watered column where the plant id is
end)

--This will be used to remove the plant from the database
RegisterServerEvent('bcc-farming:RemoveDBRow')
AddEventHandler('bcc-farming:RemoveDBRow', function(plantid) --catches var from client
  local params = { ['plantid'] = plantid } --sets params
  exports.oxmysql:execute("DELETE FROM farming WHERE plantid=@plantid", params) --deletes the row that the plant id is on
end)

--This handles the version check
local versioner = exports['bcc-versioner'].initiate()
local repo = 'https://github.com/BryceCanyonCounty/bcc-farming'
versioner.checkRelease(GetCurrentResourceName(), repo)
