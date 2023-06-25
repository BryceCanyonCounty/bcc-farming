# bcc-farming

>This is a simple easily configurable farming script for RedM!

## Features
- Allows you to create as many crops to plant for your RedM server as you want!
- Easy to translate via the Config.Languages in the config.lua!
- Ability to individually job lock plants!
- Must have a "Planting tool" to be able to plant the crop! (Tool is set for each plant individually in the config.lua)
- Super easy to configure everything via the config.lua!
- You have to water crops using a bucket in the config!
- You can refill the bucket at any lake, river, pond, ocean etc!
- Watering a crop removes the full bucket, and adds an empty one!
- Option in config to have blips on plants!
- Option for enabling or disabling planting crops in town!
- Stores plants in a database so they stay after server restarts!
- Saves the time left on plants every 40 seconds!
- Saves if they are watered or not aswell!
- Script automatically makes the database table no need to run an sql!
- Version Checker to help you keep informed on updates!
- Option to require soil to plant!
- Option to allow use of fertilizer!
- Individual plant webhooking!

## How it works
- When you have the required amount of seed items set in the config, and you have the planting tool set in the config. Just use the item seed item in your inventory! Wait for it too grow, then harvest it!
- To refill a bucket just go step in some water, and use the empty bucket in your inventory
- To water plant just walk upto it and a prompt will appear

## Why use it
- It is simple, effective, and easy to use!

## Requirements
- VORP Core
- VORP Inventory
- VORP Utils
- VORP Character
- bcc-utils

## Installation Steps
- Add the file to your resource file
- Add ensure 'bcc-farming' to your resources.cfg

## Side notes
- Stealing plants is not implemented yes
- Support will be provided
- Make sure all items set exist in your database
- This script is written from scratch, but took a heavy inspiration from prp_farming.
- You can edit the code obviously. All I ask is that you release the edits to the community freely.
- I really hope you enjoy the script thanks for trying it!
