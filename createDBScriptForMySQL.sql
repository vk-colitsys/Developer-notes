CREATE DATABASE `devnotes` /*!40100 DEFAULT CHARACTER SET utf8 */;

use `devnotes`;

DROP TABLE IF EXISTS `devnotes`.`apps`;
CREATE TABLE  `devnotes`.`apps` (
  `app_id` int(10) unsigned NOT NULL auto_increment,
  `app_name` varchar(255) NOT NULL,
  `app_version` char(10) default NULL,
  PRIMARY KEY  (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `devnotes`.`notes`;
CREATE TABLE  `devnotes`.`notes` (
  `note_id` int(10) unsigned NOT NULL auto_increment,
  `note` text,
  `app_id` int(10) unsigned NOT NULL,
  `entry_date` datetime default NULL,
  PRIMARY KEY  (`note_id`),
  KEY `FK_notes_app` (`app_id`),
  CONSTRAINT `FK_notes_app` FOREIGN KEY (`app_id`) REFERENCES `apps` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;