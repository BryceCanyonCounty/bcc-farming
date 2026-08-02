# BCC Farming

Welcome to BCC Farming, a persistent and highly configurable farming system for RedM servers using the VORP framework.

The resource is designed to give your players an easy-to-understand planting experience while giving you full control over crops, growth times, tools, fertilizer, watering, yields, jobs, planting locations, ownership, and limits. Plants are stored in the database and validated by the server, so they remain available through reconnects and restarts.

## Features

- Persistent plants that survive player reconnects, resource restarts, and server restarts
- Server-authoritative planting, watering, harvesting, ownership, proximity, and inventory checks
- Ground-level placement marker controlled with the mouse
- Automatic player movement to the selected planting position
- Configurable planting tools and durability usage
- Optional soil requirements per crop
- Three configurable fertilizer tiers
- Fertilizer selection prompts that remain visible but are disabled when an item is unavailable
- Fertilizer effects on growth time and harvest quantity
- Water-container support through `bcc-water`
- Reduced growth speed and yield for dry plants
- Automatic watering when rain is detected
- Database-validated harvest readiness
- Public or planter-only crops
- Maximum plant limits per character
- Job-restricted crops
- Coordinate-locked planting areas
- Optional house-property planting requirements
- Town planting restrictions
- Optional smell notifications and temporary map blips for configured jobs
- Owner-only crop blips
- Multiple languages
- Development logging and client resynchronization command

## Before you install

Required resources:

- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [vorp_character](https://github.com/VORPCORE/vorp_character-lua)
- [bcc-utils](https://github.com/BryceCanyonCounty/bcc-utils)
- [bcc-water](https://github.com/BryceCanyonCounty/bcc-water)

Notification providers:

- `vorp-core` uses VORP right-tip notifications and requires no additional resource.
- `feather-menu` requires [feather-menu](https://github.com/FeatherFramework/feather-menu) to be installed and started before `bcc-farming`.

You only need housing support if you enable `Config.plantSetup.requireHouseOwnership`. In that case, your database needs a compatible [bcc-housing](https://github.com/BryceCanyonCounty/bcc-housing) table with `house_coords`, `house_radius_limit`, and `charidentifier` columns.

## Installation

1. Install the required resources listed above.
2. Copy the `bcc-farming` folder into your server's resources directory.
3. Make a database backup. It is a good habit even though the included upgrade statements are designed to preserve existing data.
4. Run `bcc-farming.sql`.
5. Review `configs/config.lua` for server-wide settings.
6. Review `configs/plants.lua` for crop-specific settings.
7. Copy either the color or grayscale icons into VORP Inventory.
8. Add the resources to `server.cfg` in the order shown below.

Recommended `server.cfg` order:

```cfg
ensure oxmysql
ensure vorp_core
ensure vorp_inventory
ensure vorp_character
ensure feather-menu (optional)
ensure bcc-utils
ensure bcc-water
ensure bcc-housing (optional)
ensure bcc-farming
```

If you prefer VORP notifications, set `Config.Notify` to `vorp-core` and leave Feather Menu out unless another resource needs it.

## Choosing inventory images

Two 96x96 icon sets are included:

```text
img/color/
img/grayscale/
```

Each set contains:

- `fertilizer1.png`
- `fertilizer2.png`
- `fertilizer3.png`
- `hoe.png`
- `soil.png`

Choose the style that best matches your server, then copy that complete set into the VORP Inventory item image directory:

```text
vorp_inventory/html/img/items/
```

You do not need to copy water-container images from this resource; those are supplied by `bcc-water`. Seed and harvested-crop images are not bundled, so you can use the artwork already included with your inventory pack or add your own.

## What your players will experience

1. The player uses a configured seed from inventory.
2. The server verifies their character, job, planting limit, town restrictions, coordinate locks, property rules, tool, seed, and soil.
3. The seed and required soil are reserved and removed.
4. A ground marker appears in front of the player.
5. The player moves the marker with the mouse and clicks to confirm the position.
6. The player automatically walks to the selected position and performs the planting animation.
7. Available fertilizer tiers are shown. Fertilizers the player does not possess remain visible but disabled.
8. The player selects a fertilizer or declines fertilizer.
9. The server validates the final location again and creates the persistent plant.
10. The player may water the plant, decline watering, or allow rain to water it.
11. When the database timer reaches zero, the harvest prompt becomes available.

If planting is cancelled or fails, the resource returns the reserved seed and soil as long as the player has room to carry them.

Watering decisions are persistent. Choosing No stores the declined state on the plant, so the watering prompt does not return after reconnecting or restarting the resource.

## Helpful development command

When `Config.DevMode` is enabled:

```text
/farmreload
```

This asks the client to rebuild synchronized plants and makes sure smell detection is running. It is handy after restarting `bcc-farming` while testing. The command is intentionally unavailable when development mode is disabled.

## Export

Server export:

```lua
local houses = exports['bcc-farming']:GetPlayerHouses(charIdentifier)
```

Returns the compatible houses found for the supplied character identifier. Each result contains property coordinates and radius.

## Need help?

BCC Farming is maintained by [Bryce Canyon County](https://github.com/BryceCanyonCounty). If you run into an issue, please include your resource version, relevant configuration, and the client or server console message when asking for help.

- [Discord](https://discord.gg/bNDpwruqwX)
- [GitHub](https://github.com/BryceCanyonCounty/bcc-farming)

Original concept inspired by `prp_farming` and rebuilt for the BCC ecosystem.
