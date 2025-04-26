# bcc-farming

> **bcc-farming** is a highly configurable and user-friendly farming script designed for RedM servers. It allows you to create and manage various crops, providing a rich and immersive farming experience for your players.

## Features

- **Customizable Crops**: Create as many crops as you want for your RedM server.
- **Multilingual Support**: Easily translate the script using language files.
- **Job Locking**: Individually job lock plants to restrict access.
- **Planting Tools**: Require specific "Planting tools" for each crop, configurable via config file.
- **Easy Configuration**: Configure everything effortlessly through the provided config files.
- **Watering System**: Water crops using a bucket, which gets replaced with an empty one after use.
- **Blip Options**: Enable or disable blips on plants via the config file.
- **Town Planting**: Control whether players can plant crops in town areas.
- **Database Storage**: Stores plant data in a database to persist across server restarts.
- **Version Checker**: Stay informed about updates with the built-in version checker.
- **Soil Requirement**: Optionally require soil for planting crops.
- **Fertilizer Support**: Allow the use of fertilizers to enhance crop growth.
- **Plant Locking**: Lock plants so only the planter can interact with them, or allow everyone to interact with all plants.

## Dependencies

- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [vorp_character](https://github.com/VORPCORE/vorp_character-lua)
- [bcc-utils](https://github.com/BryceCanyonCounty/bcc-utils)

## Additional Dependency

You'll need a script that fills buckets for watering the plants. The default config settings use:

- [bcc-water](https://github.com/BryceCanyonCounty/bcc-water)

## Installation Steps

1. **Install Dependencies**: Ensure all dependencies are installed and updated before installing this script.
2. **Add to Resource Folder**: Add the `bcc-farming` folder to your resources folder.
3. **Update Server Cfg**: Add `ensure bcc-farming` to your `server.cfg` file.
4. **Run Database File**: Execute the included database file `bcc-farming.sql` to set up the necessary tables.
5. **Add Images**: Copy the images from the `img` folder to `...\vorp_inventory\html\img\items`.
6. **Restart Server**: Restart your server to apply the changes.

## Configuration

- **Config Files**: All configuration settings can be found in the `configs` folder. Adjust the settings to fit your server's needs.
- **Language Files**: Translate the script using the provided language files.

## Side Notes

- **Database Items**: Ensure all items exist in your database.
- **Inspiration**: This script is written from scratch but took heavy inspiration from `prp_farming`.
- **Community Contributions**: Feel free to edit the code and share your modifications with the community.

## GitHub

- [bcc-farming](https://github.com/BryceCanyonCounty/bcc-farming)
