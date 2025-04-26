CREATE TABLE IF NOT EXISTS `bcc_farming` (
    `plant_id` INT(40) NOT NULL AUTO_INCREMENT,
    `plant_coords` LONGTEXT NOT NULL,
    `plant_type` VARCHAR(40) NOT NULL,
    `plant_watered` CHAR(6) NOT NULL DEFAULT 'false',
    `time_left` VARCHAR(100) NOT NULL,
    `plant_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `plant_owner` INT(40) NOT NULL,
    PRIMARY KEY (`plant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`)
VALUES
    ('wateringcan', 'Water Jug', 10, 1, 'item_standard', 1, 'A bucket of clean water.'),
    ('wateringcan_empty', 'Empty Watering Jug', 10, 1, 'item_standard', 1, 'An empty water bucket.'),
    ('wateringcan_dirtywater', 'Dirty Water Jug', 10, 1, 'item_standard', 1, 'A bucket filled with dirty water.'),
    ('fertilizer1', 'Fertilizer Grade C', 10, 1, 'item_standard', 1, 'Low grade fertilizer.'),
    ('fertilizer2', 'Fertilizer Grade B', 10, 1, 'item_standard', 1, 'Mid grade fertilizer.'),
    ('fertilizer3', 'Fertilizer Grade A', 10, 1, 'item_standard', 1, 'High grade fertilizer.')
ON DUPLICATE KEY UPDATE
    `item` = VALUES(`item`),
    `label` = VALUES(`label`),
    `limit` = VALUES(`limit`),
    `can_remove` = VALUES(`can_remove`),
    `type` = VALUES(`type`),
    `usable` = VALUES(`usable`),
    `desc` = VALUES(`desc`);
