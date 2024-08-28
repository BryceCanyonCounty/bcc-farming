CREATE TABLE IF NOT EXISTS `bcc_farming` (
	`plant_id` INT(40) NOT NULL AUTO_INCREMENT,
    `plant_coords` LONGTEXT NOT NULL,
    `plant_type` VARCHAR(40) NOT NULL,
    `plant_watered` char(6) NOT NULL DEFAULT 'false',
    `time_left` varchar(100) NOT NULL,
    `plant_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `plant_owner` INT(40) NOT NULL,
	PRIMARY KEY (`plant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('wateringcan', 'Water Jug', 10, 1, 'item_standard', 1)
    ON DUPLICATE KEY UPDATE `item`='wateringcan', `label`='Water Jug', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('wateringcan_empty', 'Empty Watering Jug', 10, 1, 'item_standard', 1)
    ON DUPLICATE KEY UPDATE `item`='wateringcan_empty', `label`='Empty Watering Jug', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES ('fertilizer1', 'Fertilizer Grade C', 10, 1, 'item_standard', 1, 'Low grade fertilizer.')
    ON DUPLICATE KEY UPDATE `item`='fertilizer1', `label`='Fertilizer Grade C', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1, `desc`='Low grade fertilizer.';

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES ('fertilizer2', 'Fertilizer Grade B', 10, 1, 'item_standard', 1, 'Mid grade fertilizer.')
    ON DUPLICATE KEY UPDATE `item`='fertilizer2', `label`='Fertilizer Grade B', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1, `desc`='Mid grade fertilizer.';

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES ('fertilizer3', 'Fertilizer Grade A', 10, 1, 'item_standard', 1, 'High grade fertilizer.')
    ON DUPLICATE KEY UPDATE `item`='fertilizer3', `label`='Fertilizer Grade A', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1, `desc`='High grade fertilizer.';
