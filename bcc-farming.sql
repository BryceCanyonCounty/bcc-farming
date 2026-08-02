CREATE TABLE IF NOT EXISTS `bcc_farming` (
    `plant_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `plant_coords` LONGTEXT NOT NULL,
    `plant_type` VARCHAR(40) NOT NULL,
    `plant_watered` CHAR(6) NOT NULL DEFAULT 'false' COMMENT 'false=pending, no=declined, true=watered',
    `time_left` DECIMAL(12,3) NOT NULL DEFAULT 0.000,
    `fertilizer` VARCHAR(40) DEFAULT NULL,
    `yield_multiplier` DECIMAL(6,3) NOT NULL DEFAULT 1.000,
    `plant_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `plant_owner` BIGINT NOT NULL,
    PRIMARY KEY (`plant_id`),
    KEY `idx_bcc_farming_owner` (`plant_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Upgrade installations created before fertilizer yield tracking was added.
ALTER TABLE `bcc_farming`
    ADD COLUMN IF NOT EXISTS `fertilizer` VARCHAR(40) DEFAULT NULL AFTER `time_left`,
    ADD COLUMN IF NOT EXISTS `yield_multiplier` DECIMAL(6,3) NOT NULL DEFAULT 1.000 AFTER `fertilizer`;

-- Existing releases stored the countdown as text. Normalize unexpected legacy
-- values before converting the column so an upgrade cannot fail or lose rows.
UPDATE `bcc_farming`
SET `time_left` = '0'
WHERE `time_left` IS NULL
   OR TRIM(`time_left`) = ''
   OR TRIM(`time_left`) NOT REGEXP '^[0-9]+([.][0-9]+)?$';

ALTER TABLE `bcc_farming`
    MODIFY COLUMN `plant_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY COLUMN `time_left` DECIMAL(12,3) NOT NULL DEFAULT 0.000,
    MODIFY COLUMN `plant_owner` BIGINT NOT NULL;

ALTER TABLE `bcc_farming`
    ADD INDEX IF NOT EXISTS `idx_bcc_farming_owner` (`plant_owner`);

-- Insert only missing inventory records. Existing server-specific labels,
-- limits, descriptions, and other item customization remain untouched.
INSERT IGNORE INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`)
VALUES
    ('Agarita_Seed', 'Agarita Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Agarita.'),
    ('Agarita', 'Agarita', 20, 1, 'item_standard', 0, 'Harvested Agarita.'),
    ('Yarrow_Seed', 'Yarrow Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Yarrow.'),
    ('Yarrow', 'Yarrow', 20, 1, 'item_standard', 0, 'Harvested Yarrow.'),
    ('hop_seed', 'Hop Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Hop.'),
    ('hop', 'Hop', 20, 1, 'item_standard', 0, 'Harvested Hop.'),
    ('Alaskan_Ginseng_Seed', 'Alaskan Ginseng Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Alaskan Ginseng.'),
    ('Alaskan_Ginseng', 'Alaskan Ginseng', 20, 1, 'item_standard', 0, 'Harvested Alaskan Ginseng.'),
    ('American_Ginseng_Seed', 'American Ginseng Seed', 20, 1, 'item_standard', 1, 'Seed used to grow American Ginseng.'),
    ('American_Ginseng', 'American Ginseng', 20, 1, 'item_standard', 0, 'Harvested American Ginseng.'),
    ('Bay_Bolete_Seed', 'Bay Bolete Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Bay Bolete.'),
    ('Bay_Bolete', 'Bay Bolete', 20, 1, 'item_standard', 0, 'Harvested Bay Bolete.'),
    ('Bitter_Weed_Seed', 'Bitter Weed Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Bitter Weed.'),
    ('Bitter_Weed', 'Bitter Weed', 20, 1, 'item_standard', 0, 'Harvested Bitter Weed.'),
    ('Black_Berry_Seed', 'Black Berry Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Black Berry.'),
    ('Black_Berry', 'Black Berry', 20, 1, 'item_standard', 0, 'Harvested Black Berry.'),
    ('Black_Currant_Seed', 'Black Currant Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Black Currant.'),
    ('Black_Currant', 'Black Currant', 20, 1, 'item_standard', 0, 'Harvested Black Currant.'),
    ('cocoaseeds', 'Cocoa Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Cocoa.'),
    ('cocoa', 'Cocoa', 20, 1, 'item_standard', 0, 'Harvested Cocoa.'),
    ('cornseed', 'Corn Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Corn.'),
    ('corn', 'Corn', 20, 1, 'item_standard', 0, 'Harvested Corn.'),
    ('Creekplum_Seed', 'Creekplum Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Creekplum.'),
    ('Creekplum', 'Creekplum', 20, 1, 'item_standard', 0, 'Harvested Creekplum.'),
    ('Crows_Garlic_Seed', 'Crows Garlic Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Crows Garlic.'),
    ('Crows_Garlic', 'Crows Garlic', 20, 1, 'item_standard', 0, 'Harvested Crows Garlic.'),
    ('Indian_Tobbaco_Seed', 'Indian Tobacco Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Indian Tobacco.'),
    ('Indian_Tobbaco', 'Indian Tobacco', 20, 1, 'item_standard', 0, 'Harvested Indian Tobacco.'),
    ('Milk_Weed_Seed', 'Milk Weed Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Milk Weed.'),
    ('Milk_Weed', 'Milk Weed', 20, 1, 'item_standard', 0, 'Harvested Milk Weed.'),
    ('Oleander_Sage_Seed', 'Oleander Sage Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Oleander Sage.'),
    ('Oleander_Sage', 'Oleander Sage', 20, 1, 'item_standard', 0, 'Harvested Oleander Sage.'),
    ('Parasol_Mushroom_Seed', 'Parasol Mushroom Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Parasol Mushroom.'),
    ('Parasol_Mushroom', 'Parasol Mushroom', 20, 1, 'item_standard', 0, 'Harvested Parasol Mushroom.'),
    ('Prairie_Poppy_Seed', 'Prairie Poppy Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Prairie Poppy.'),
    ('Prairie_Poppy', 'Prairie Poppy', 20, 1, 'item_standard', 0, 'Harvested Prairie Poppy.'),
    ('Rams_Head_Seed', 'Rams Head Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Rams Head.'),
    ('Rams_Head', 'Rams Head', 20, 1, 'item_standard', 0, 'Harvested Rams Head.'),
    ('Red_Raspberry_Seed', 'Red Raspberry Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Red Raspberry.'),
    ('Red_Raspberry', 'Red Raspberry', 20, 1, 'item_standard', 0, 'Harvested Red Raspberry.'),
    ('Red_Sage_Seed', 'Red Sage Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Red Sage.'),
    ('Red_Sage', 'Red Sage', 20, 1, 'item_standard', 0, 'Harvested Red Sage.'),
    ('Saltbush_Seed', 'Saltbush Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Saltbush.'),
    ('Saltbush', 'Saltbush', 20, 1, 'item_standard', 0, 'Harvested Saltbush.'),
    ('sugarcaneseed', 'Sugar Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Sugar.'),
    ('sugar', 'Sugar', 20, 1, 'item_standard', 0, 'Harvested Sugar.'),
    ('Wild_Carrot_Seed', 'Wild Carrot Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Wild Carrot.'),
    ('Wild_Carrot', 'Wild Carrot', 20, 1, 'item_standard', 0, 'Harvested Wild Carrot.'),
    ('Wild_Feverfew_Seed', 'Wild Feverfew Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Wild Feverfew.'),
    ('Wild_Feverfew', 'Wild Feverfew', 20, 1, 'item_standard', 0, 'Harvested Wild Feverfew.'),
    ('Wild_Mint_Seed', 'Wild Mint Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Wild Mint.'),
    ('Wild_Mint', 'Wild Mint', 20, 1, 'item_standard', 0, 'Harvested Wild Mint.'),
    ('Wild_Rhubarb_Seed', 'Wild Rhubarb Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Wild Rhubarb.'),
    ('Wild_Rhubarb', 'Wild Rhubarb', 20, 1, 'item_standard', 0, 'Harvested Wild Rhubarb.'),
    ('Wintergreen_Berry_Seed', 'Wintergreen Berry Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Wintergreen Berry.'),
    ('Wintergreen_Berry', 'Wintergreen Berry', 20, 1, 'item_standard', 0, 'Harvested Wintergreen Berry.'),
    ('potatoseed', 'Potato Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Potato.'),
    ('potato', 'Potato', 20, 1, 'item_standard', 0, 'Harvested Potato.'),
    ('wheatseed', 'Wheat Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Wheat.'),
    ('wheat', 'Wheat', 20, 1, 'item_standard', 0, 'Harvested Wheat.'),
    ('Apple_Seed', 'Apple Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Apple.'),
    ('apple', 'Apple', 20, 1, 'item_standard', 0, 'Harvested Apple.'),
    ('Hummingbird_Sage_Seed', 'Hummingbird Sage Seed', 20, 1, 'item_standard', 1, 'Seed used to grow Hummingbird Sage.'),
    ('Hummingbird_Sage', 'Hummingbird Sage', 20, 1, 'item_standard', 0, 'Harvested Hummingbird Sage.'),
    ('fertilizer1', 'Fertilizer Grade C', 10, 1, 'item_standard', 0, 'Low grade fertilizer.'),
    ('fertilizer2', 'Fertilizer Grade B', 10, 1, 'item_standard', 0, 'Mid grade fertilizer.'),
    ('fertilizer3', 'Fertilizer Grade A', 10, 1, 'item_standard', 0, 'High grade fertilizer.'),
    ('soil', 'Soil', 10, 1, 'item_standard', 0, 'High grade soil.'),
    ('hoe', 'Garden Hoe', 10, 1, 'item_standard', 0, 'A gardening tool with a thin metal blade.');

-- These supplies are selected or consumed by the farming flow rather than used
-- directly from inventory. Apply the corrected flag to existing installations.
UPDATE `items`
SET `usable` = 0
WHERE `item` IN ('fertilizer1', 'fertilizer2', 'fertilizer3', 'soil', 'hoe');

-- Correct only the original default typo while retaining the legacy item IDs
-- required by existing inventories, configured seeds, and planted crop rows.
UPDATE `items`
SET `label` = 'Indian Tobacco Seed'
WHERE `item` = 'Indian_Tobbaco_Seed'
  AND `label` = 'Indian Tobbaco Seed';

UPDATE `items`
SET `desc` = 'Seed used to grow Indian Tobacco.'
WHERE `item` = 'Indian_Tobbaco_Seed'
  AND `desc` = 'Seed used to grow Indian Tobbaco.';

UPDATE `items`
SET `label` = 'Indian Tobacco'
WHERE `item` = 'Indian_Tobbaco'
  AND `label` = 'Indian Tobbaco';

UPDATE `items`
SET `desc` = 'Harvested Indian Tobacco.'
WHERE `item` = 'Indian_Tobbaco'
  AND `desc` = 'Harvested Indian Tobbaco.';
