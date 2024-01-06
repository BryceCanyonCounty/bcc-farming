CREATE TABLE `farming` (
	`identifier` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`charidentifier` INT(11) NOT NULL,
	`planttype` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`plantcoords` LONGTEXT NOT NULL COLLATE 'utf8_general_ci',
	`timeleft` INT(50) NOT NULL DEFAULT '0',
	`prop` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`plantid` INT(11) NOT NULL AUTO_INCREMENT,
	`planted_on` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`watered` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_general_ci',
	PRIMARY KEY (`plantid`) USING BTREE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;
