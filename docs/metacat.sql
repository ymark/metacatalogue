/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table metadb.datasets
CREATE TABLE IF NOT EXISTS `datasets` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL DEFAULT '0',
  `user_email` varchar(120) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf32;

-- Dumping structure for table metadb.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_email` varchar(120) NOT NULL DEFAULT '0',
  `action` varchar(50) NOT NULL DEFAULT '0',
  `message` text,
  `related_dataset` varchar(250) DEFAULT '0',
  `when` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119142 DEFAULT CHARSET=utf32;

-- Dumping structure for table metadb.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(250) NOT NULL,
  `last_modified` datetime NOT NULL,
  `about` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf32;

-- Dumping data for table metadb.settings: ~25 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `name`, `value`, `last_modified`, `about`) VALUES
	(1, 'metacatalogueBaseUrl', 'http://myapp.gr', '2015-05-03 12:00:00', 'Metadata Catalogue vLab base URL'),
	(3, 'descriptionPath', '/root/descriptions', '2015-05-03 12:00:00', 'Description File Storage Path'),
	(4, 'internalMetadataPath', '/root/metadata', '2015-05-03 12:00:00', 'Internal Metadata File Storage Path'),
	(5, 'internalDatasetPath', '/root/datasets', '2015-05-03 12:00:00', 'Internal Dataset File Storage Path'),
	(6, 'directoryRecoveryPath', '/root/dirTemp', '2015-05-03 12:00:00', 'Directory Recovery Temp Path'),
	(7, 'datasetPath', '/root/irodsFiles', '2015-05-03 12:00:00', 'Dataset File Storage Path'),
	(8, 'irodsIP', '127.0.0.1', '2015-05-03 12:00:00', 'iRODS IP'),
	(9, 'irodsPort', '1247', '2015-05-03 12:00:00', 'iRODS Port'),
	(10, 'irodsUsername', 'irodsuser', '2015-05-03 12:00:00', 'iRODS Username'),
	(11, 'irodsPassword', 'irodspwd', '2015-05-03 12:00:00', 'iRODS Password'),
	(12, 'irodsPath', '/irodsTemp/home/rods/', '2015-05-03 12:00:00', 'iRODS Path'),
	(13, 'irodsTempZone', 'irodsTemp', '2015-05-03 12:00:00', 'irodsTempZone'),
	(14, 'irodsDemoResc', 'irodsDL', '2015-05-03 12:00:00', 'irodsDemoResc'),
	(15, 'irodsDLFolder', 'irodsDL', '2015-05-03 12:00:00', 'Temp Folder for Files that need to be downloaded from iRODS'),
	(16, 'virtuosoUrl', 'http://83.212.171.166/', '2015-05-03 12:00:00', 'Virtuoso URL'),
	(17, 'virtuosoPort', '1111', '2015-05-03 12:00:00', 'Virtuoso Port'),
	(18, 'virtuosoJdbc', 'jdbc:virtuoso://83.212.171.166:1111', '2015-05-03 12:00:00', 'Virtuoso IP-Port'),
	(19, 'virtuosoUser', 'dba', '2015-05-03 12:00:00', 'Virtuoso Username'),
	(20, 'virtuosoPass', 'ofi', '2015-05-03 12:00:00', 'Virtuoso Password'),
	(21, 'directoryGraph', 'http://www.ics.forth.gr/isl/lifewatch/directory', '2015-05-03 12:00:00', 'Directory Graph'),
	(22, 'metadataGraph', 'http://www.ics.forth.gr/isl/lifewatch/metadata', '2015-05-03 12:00:00', 'Metadata Graph'),
	(23, 'uriPrefix', 'http://www.lifewatchgreece.eu/entity', '2015-05-03 12:00:00', 'URI Prefix'),
	(24, 'rpp', '20', '2015-05-03 12:00:00', 'Search results per page'),
	(25, 'ppm', '5', '2015-05-03 12:00:00', 'Number of pages in pagination'),
	(26, 'materializationGraph', 'http://MaterilGraph', '2016-01-21 12:59:13', 'Graph used by Materialization in Recovery Page');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
