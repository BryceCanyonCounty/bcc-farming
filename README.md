# bcc-farming

> This is a simple easily configurable farming script for RedM!

## Features
- Allows you to create as many crops to plant for your RedM server as you want!
- Easy to translate via the Language files!
- Ability to individually job lock plants!
- Option to require a "Planting tool" to be able to plant the crop! (Tool is set for each plant individually in the config.lua)
- Super easy to configure everything via the config files!
- You have to water crops using a bucket in the config!
- Watering a crop removes the full bucket, and adds an empty one!
- Option in config to have blips on plants!
- Option for enabling or disabling planting crops in town!
- Stores plants in a database so they stay after server restarts!
- Version Checker to help you keep informed on updates!
- Option to require soil to plant!
- Option to allow use of fertilizer!
- Option to lock plants so only the planter can interact with them or have everyone be able to interact with all plants!

## Why use it
- It is simple, effective, and easy to use!

## Requirements
- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [vorp_character](https://github.com/VORPCORE/vorp_character-lua)
- [bcc-utils](https://github.com/BryceCanyonCounty/bcc-utils)

## Installation Steps
- Make sure dependencies are installed/updated and ensured before this script
- Add `bcc-farming` folder to your resources folder
- Add `ensure bcc-farming` to your resources.cfg
- Run the included database file `bcc-farming.sql`
- Add images from `img` folder to: `...\vorp_inventory\html\img\items`
- Restart server

## Side notes
- Make sure all items exist in your database.
- This script is written from scratch, but took a heavy inspiration from prp_farming.
- You can edit the code obviously. All I ask is that you release the edits to the community freely.

## GitHub
- https://github.com/BryceCanyonCounty/bcc-farming