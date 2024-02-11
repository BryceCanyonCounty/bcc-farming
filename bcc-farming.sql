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