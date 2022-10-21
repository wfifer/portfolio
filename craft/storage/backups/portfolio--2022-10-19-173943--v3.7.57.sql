-- MySQL dump 10.13  Distrib 8.0.30, for macos12.4 (arm64)
--
-- Host: localhost    Database: db_portfolio
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `craft_assetindexdata`
--

DROP TABLE IF EXISTS `craft_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int NOT NULL,
  `uri` text,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `craft_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assets`
--

DROP TABLE IF EXISTS `craft_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assets_folderId_idx` (`folderId`),
  KEY `craft_assets_volumeId_idx` (`volumeId`),
  KEY `craft_assets_volumeId_keptFile_idx` (`volumeId`,`keptFile`),
  KEY `craft_assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `craft_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransformindex`
--

DROP TABLE IF EXISTS `craft_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransforms`
--

DROP TABLE IF EXISTS `craft_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_assettransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransforms_name_idx` (`name`),
  KEY `craft_assettransforms_handle_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categories`
--

DROP TABLE IF EXISTS `craft_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_idx` (`groupId`),
  KEY `craft_categories_parentId_fk` (`parentId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups`
--

DROP TABLE IF EXISTS `craft_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categorygroups_structureId_idx` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_categorygroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_categorygroups_name_idx` (`name`),
  KEY `craft_categorygroups_handle_idx` (`handle`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups_sites`
--

DROP TABLE IF EXISTS `craft_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `craft_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_changedattributes`
--

DROP TABLE IF EXISTS `craft_changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `craft_changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `craft_changedattributes_siteId_fk` (`siteId`),
  KEY `craft_changedattributes_userId_fk` (`userId`),
  CONSTRAINT `craft_changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_changedfields`
--

DROP TABLE IF EXISTS `craft_changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `craft_changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `craft_changedfields_siteId_fk` (`siteId`),
  KEY `craft_changedfields_fieldId_fk` (`fieldId`),
  KEY `craft_changedfields_userId_fk` (`userId`),
  CONSTRAINT `craft_changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_content`
--

DROP TABLE IF EXISTS `craft_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_fontIcon` text,
  `field_intro` text,
  `field_website` text,
  `field_featured` tinyint(1) DEFAULT NULL,
  `field_fontIconStyle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_content_siteId_idx` (`siteId`),
  KEY `craft_content_title_idx` (`title`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_craftidtokens`
--

DROP TABLE IF EXISTS `craft_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craft_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_deprecationerrors`
--

DROP TABLE IF EXISTS `craft_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_drafts`
--

DROP TABLE IF EXISTS `craft_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_drafts_sourceId_fk` (`sourceId`),
  KEY `craft_drafts_creatorId_fk` (`creatorId`),
  CONSTRAINT `craft_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elementindexsettings`
--

DROP TABLE IF EXISTS `craft_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_elementindexsettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements`
--

DROP TABLE IF EXISTS `craft_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `craft_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_elements_draftId_fk` (`draftId`),
  KEY `craft_elements_revisionId_fk` (`revisionId`),
  KEY `craft_elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  CONSTRAINT `craft_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `craft_revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements_sites`
--

DROP TABLE IF EXISTS `craft_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_elements_sites_siteId_idx` (`siteId`),
  KEY `craft_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `craft_elements_sites_enabled_idx` (`enabled`),
  KEY `craft_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `craft_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entries`
--

DROP TABLE IF EXISTS `craft_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_idx` (`authorId`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_parentId_fk` (`parentId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafterrors`
--

DROP TABLE IF EXISTS `craft_entrydrafterrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_entrydrafterrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `draftId` int DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafterrors_draftId_fk` (`draftId`),
  CONSTRAINT `craft_entrydrafterrors_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_entrydrafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafts`
--

DROP TABLE IF EXISTS `craft_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entryId` int NOT NULL,
  `sectionId` int NOT NULL,
  `creatorId` int NOT NULL,
  `siteId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `craft_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entrydrafts_siteId_idx` (`siteId`),
  KEY `craft_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrytypes`
--

DROP TABLE IF EXISTS `craft_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrytypes_sectionId_idx` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_entrytypes_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `craft_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversionerrors`
--

DROP TABLE IF EXISTS `craft_entryversionerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_entryversionerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `versionId` int DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_entryversionerrors_versionId_fk` (`versionId`),
  CONSTRAINT `craft_entryversionerrors_versionId_fk` FOREIGN KEY (`versionId`) REFERENCES `craft_entryversions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversions`
--

DROP TABLE IF EXISTS `craft_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_entryversions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entryId` int NOT NULL,
  `sectionId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `siteId` int NOT NULL,
  `num` smallint unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_sectionId_idx` (`sectionId`),
  KEY `craft_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entryversions_siteId_idx` (`siteId`),
  KEY `craft_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldgroups`
--

DROP TABLE IF EXISTS `craft_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldgroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayoutfields`
--

DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouts`
--

DROP TABLE IF EXISTS `craft_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_type_idx` (`type`),
  KEY `craft_fieldlayouts_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouttabs`
--

DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fields`
--

DROP TABLE IF EXISTS `craft_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fields_groupId_idx` (`groupId`),
  KEY `craft_fields_context_idx` (`context`),
  KEY `craft_fields_handle_context_idx` (`handle`,`context`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_globalsets`
--

DROP TABLE IF EXISTS `craft_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_globalsets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_globalsets_name_idx` (`name`),
  KEY `craft_globalsets_handle_idx` (`handle`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_gqlschemas`
--

DROP TABLE IF EXISTS `craft_gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_gqltokens`
--

DROP TABLE IF EXISTS `craft_gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `craft_gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `craft_gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_info`
--

DROP TABLE IF EXISTS `craft_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocks`
--

DROP TABLE IF EXISTS `craft_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int NOT NULL,
  `ownerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocktypes`
--

DROP TABLE IF EXISTS `craft_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_matrixblocktypes_name_fieldId_idx` (`name`,`fieldId`),
  KEY `craft_matrixblocktypes_handle_fieldId_idx` (`handle`,`fieldId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixcontent_herobackground`
--

DROP TABLE IF EXISTS `craft_matrixcontent_herobackground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_matrixcontent_herobackground` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_background_angle` text,
  `field_background_stops` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixcontent_herobackground_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_matrixcontent_herobackground_siteId_fk` (`siteId`),
  CONSTRAINT `craft_matrixcontent_herobackground_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixcontent_herobackground_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixcontent_pagecontent`
--

DROP TABLE IF EXISTS `craft_matrixcontent_pagecontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_matrixcontent_pagecontent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_wysiwyg_body` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixcontent_pagecontent_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_matrixcontent_pagecontent_siteId_fk` (`siteId`),
  CONSTRAINT `craft_matrixcontent_pagecontent_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixcontent_pagecontent_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixcontent_projectlayers`
--

DROP TABLE IF EXISTS `craft_matrixcontent_projectlayers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_matrixcontent_projectlayers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_layer_depth` smallint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixcontent_projectlayers_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_matrixcontent_projectlayers_siteId_fk` (`siteId`),
  CONSTRAINT `craft_matrixcontent_projectlayers_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixcontent_projectlayers_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_migrations`
--

DROP TABLE IF EXISTS `craft_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_migrations_track_name_unq_idx` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_plugins`
--

DROP TABLE IF EXISTS `craft_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_projectconfig`
--

DROP TABLE IF EXISTS `craft_projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_queue`
--

DROP TABLE IF EXISTS `craft_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `craft_queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_relations`
--

DROP TABLE IF EXISTS `craft_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `craft_relations_sourceId_idx` (`sourceId`),
  KEY `craft_relations_targetId_idx` (`targetId`),
  KEY `craft_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=583 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_resourcepaths`
--

DROP TABLE IF EXISTS `craft_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_revisions`
--

DROP TABLE IF EXISTS `craft_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `craft_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `craft_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_searchindex`
--

DROP TABLE IF EXISTS `craft_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections`
--

DROP TABLE IF EXISTS `craft_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sections_structureId_idx` (`structureId`),
  KEY `craft_sections_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sections_name_idx` (`name`),
  KEY `craft_sections_handle_idx` (`handle`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections_sites`
--

DROP TABLE IF EXISTS `craft_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `craft_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sequences`
--

DROP TABLE IF EXISTS `craft_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sessions`
--

DROP TABLE IF EXISTS `craft_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_idx` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_shunnedmessages`
--

DROP TABLE IF EXISTS `craft_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sitegroups`
--

DROP TABLE IF EXISTS `craft_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sitegroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sites`
--

DROP TABLE IF EXISTS `craft_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sites_sortOrder_idx` (`sortOrder`),
  KEY `craft_sites_groupId_fk` (`groupId`),
  KEY `craft_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sites_handle_idx` (`handle`),
  CONSTRAINT `craft_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structureelements`
--

DROP TABLE IF EXISTS `craft_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structures`
--

DROP TABLE IF EXISTS `craft_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_systemmessages`
--

DROP TABLE IF EXISTS `craft_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `craft_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_taggroups`
--

DROP TABLE IF EXISTS `craft_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `craft_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_taggroups_name_idx` (`name`),
  KEY `craft_taggroups_handle_idx` (`handle`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tags`
--

DROP TABLE IF EXISTS `craft_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_idx` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecacheelements`
--

DROP TABLE IF EXISTS `craft_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int NOT NULL,
  `elementId` int NOT NULL,
  KEY `craft_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecachequeries`
--

DROP TABLE IF EXISTS `craft_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_templatecachequeries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cacheId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `craft_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `craft_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecaches`
--

DROP TABLE IF EXISTS `craft_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_templatecaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `craft_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `craft_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tokens`
--

DROP TABLE IF EXISTS `craft_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups`
--

DROP TABLE IF EXISTS `craft_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_usergroups_handle_idx` (`handle`),
  KEY `craft_usergroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups_users`
--

DROP TABLE IF EXISTS `craft_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions`
--

DROP TABLE IF EXISTS `craft_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_users`
--

DROP TABLE IF EXISTS `craft_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpreferences`
--

DROP TABLE IF EXISTS `craft_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_userpreferences` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `craft_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_users`
--

DROP TABLE IF EXISTS `craft_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_users` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_email_idx` (`email`),
  KEY `craft_users_username_idx` (`username`),
  KEY `craft_users_photoId_fk` (`photoId`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `craft_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumefolders`
--

DROP TABLE IF EXISTS `craft_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `craft_volumefolders_parentId_idx` (`parentId`),
  KEY `craft_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumes`
--

DROP TABLE IF EXISTS `craft_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_volumes_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_volumes_name_idx` (`name`),
  KEY `craft_volumes_handle_idx` (`handle`),
  CONSTRAINT `craft_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_widgets`
--

DROP TABLE IF EXISTS `craft_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craft_widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_idx` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'db_portfolio'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-19 13:39:43
-- MySQL dump 10.13  Distrib 8.0.30, for macos12.4 (arm64)
--
-- Host: localhost    Database: db_portfolio
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `craft_assets`
--

LOCK TABLES `craft_assets` WRITE;
/*!40000 ALTER TABLE `craft_assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_assets` VALUES (3,1,4,NULL,'will.jpg','image',1500,1000,358599,NULL,NULL,NULL,'2018-08-29 23:27:07','2018-08-29 23:27:07','2018-10-24 01:10:23','1169d149-ee14-4746-b291-28541a3176b6'),(9,1,5,NULL,'identity.svg','image',50,50,2070,NULL,NULL,NULL,'2018-08-29 23:31:28','2018-08-29 23:31:28','2018-10-24 01:10:22','ab343c3b-58ec-4bf8-86e2-2a7090ac8180'),(11,1,5,NULL,'taco.svg','image',50,50,2718,NULL,NULL,NULL,'2018-08-29 23:31:44','2018-08-29 23:31:44','2018-10-24 01:10:22','a5be052e-4094-489c-81a0-2b6902ed75ae'),(13,1,4,NULL,'man-test.jpg','image',1401,800,285356,NULL,NULL,NULL,'2018-08-29 23:34:41','2018-08-29 23:34:41','2018-10-24 01:10:25','febef898-4622-4929-abe1-e62b1dbd3cd3'),(17,1,4,NULL,'halls-taekwondo.jpg','image',1450,1000,175405,NULL,NULL,NULL,'2018-08-29 23:37:38','2018-08-29 23:37:38','2018-10-24 01:10:25','2feec205-4ce1-4b70-ac84-e977a81090f6'),(20,1,4,NULL,'womens-health-week.jpg','image',2121,1193,2611013,NULL,NULL,NULL,'2018-08-29 23:38:38','2018-08-29 23:38:39','2018-10-24 01:10:18','f9d1570c-d9b8-4d30-822e-9c1d14acc65e'),(23,1,6,NULL,'man-test_180829_235635.jpg','image',798,798,181500,NULL,NULL,NULL,'2018-08-29 23:56:36','2018-08-29 23:56:36','2018-10-24 01:10:19','84d13380-af8a-42c7-a66a-a4a8140bc711'),(24,1,6,NULL,'womens-health-week_180829_235728.jpg','image',2121,1193,2616092,NULL,NULL,NULL,'2018-08-29 23:57:29','2018-08-29 23:57:30','2018-10-24 01:10:18','e31579bc-3137-4e41-ac8e-6e4af7ef35bb'),(25,1,6,NULL,'halls-taekwondo_180829_235841.jpg','image',440,441,61870,NULL,NULL,NULL,'2018-08-29 23:58:42','2018-08-29 23:58:42','2018-10-24 01:10:20','9be87bcd-b332-402e-b2f6-b502b453ef6d'),(26,1,4,NULL,'cengage-ecollection.png','image',2438,1766,5963344,NULL,NULL,NULL,'2018-08-30 02:19:05','2018-08-30 02:19:06','2018-10-24 01:10:27','01d4def7-7dfc-4831-8912-8ea6afa002bc'),(29,1,4,NULL,'uxmas.png','image',2112,1362,332492,NULL,NULL,NULL,'2018-08-30 02:20:31','2018-08-30 02:20:31','2018-10-24 01:10:26','69bded83-a837-4053-9048-7e8183449930'),(32,1,4,NULL,'change-it-ourselves.png','image',2690,2018,1036929,NULL,NULL,NULL,'2018-08-30 02:21:59','2018-08-30 02:21:59','2018-10-24 01:10:24','7ebe61d9-9372-4bf3-acc8-58bf10ad1a6f'),(35,1,4,NULL,'other-work.png','image',2516,1666,3688889,NULL,NULL,NULL,'2018-08-30 02:23:15','2018-08-30 02:23:16','2018-10-24 01:10:25','cd0411d1-672f-425b-a6f5-fd05dc6d606d'),(38,1,6,NULL,'cengage-ecollection_180830_022429.png','image',2438,1766,5764694,NULL,NULL,NULL,'2018-08-30 02:24:41','2018-08-30 02:24:42','2018-10-24 01:10:22','2330c816-9a16-4b9c-a2e5-2faad41b7839'),(39,1,6,NULL,'change-it-ourselves_180830_022509.png','image',2690,2018,1036929,NULL,NULL,NULL,'2018-08-30 02:25:14','2018-08-30 02:25:15','2018-10-24 01:10:20','518f93f4-645e-47c4-ac9c-1150e1a25be8'),(40,1,6,NULL,'other-work_180830_022619.png','image',1666,1665,2348643,NULL,NULL,NULL,'2018-08-30 02:26:24','2018-08-30 02:26:24','2018-10-24 01:10:19','a5a762a3-cd2e-4f30-86d4-ef6a5651eab6'),(41,1,6,NULL,'uxmas_180830_022658.png','image',2112,1362,332492,NULL,NULL,NULL,'2018-08-30 02:27:02','2018-08-30 02:27:02','2018-10-24 01:10:19','9a2beda5-29c2-49ad-a9ff-126302976177'),(43,1,6,NULL,'IMG_5525.jpg','image',1600,1600,935229,NULL,NULL,NULL,'2018-08-30 23:45:47','2018-08-30 23:45:47','2018-09-13 00:49:52','4807cf75-a2f4-4fd1-9187-8c4cdbdad5fd'),(44,1,4,NULL,'IMG_5501.jpg','image',1600,1333,596546,NULL,NULL,NULL,'2018-08-30 23:46:00','2018-08-30 23:46:00','2018-09-13 00:50:13','e89b1a84-fcb2-40be-ae41-eeeb49ea7e4b'),(47,1,6,NULL,'food-blog-thumbnail.jpg','image',1223,1223,692368,NULL,NULL,NULL,'2018-08-31 00:03:46','2018-08-31 00:03:46','2018-09-13 00:49:53','3495cb45-51b5-4a85-a811-b77517d6331e'),(48,1,4,NULL,'food-blog.jpg','image',1600,1333,613676,NULL,NULL,NULL,'2018-08-31 00:03:58','2018-08-31 00:03:58','2018-09-13 00:50:05','2da1a3a9-3d63-4622-9412-4b20f99ef928'),(84,1,1,NULL,'change-it-ourselves_take-part.jpg','image',2892,1954,495865,NULL,NULL,NULL,'2018-10-24 03:05:02','2018-10-24 03:05:06','2018-10-24 03:05:06','1e5e6e09-ee6c-433e-89a5-fd7777b05b0f'),(85,1,1,NULL,'ecollection-reader.jpg','image',2798,1918,2353546,NULL,NULL,NULL,'2018-10-24 03:05:14','2018-10-24 03:05:14','2018-10-24 03:05:14','8cd53c64-ca40-4388-afb2-146ecfb13565'),(86,1,1,NULL,'ecollection.jpg','image',2818,1894,2922368,NULL,NULL,NULL,'2018-10-24 03:05:22','2018-10-24 03:05:22','2018-10-24 03:05:22','683bdc12-e1d7-4fb9-b680-abbd9cde56fa'),(87,1,1,NULL,'halls-taekwondo-shop.jpg','image',2892,1682,1168262,NULL,NULL,NULL,'2018-10-24 03:05:24','2018-10-24 03:05:24','2018-10-24 03:05:24','92d9c27f-62cf-4c77-b832-7e69b3e6bec3'),(88,1,1,NULL,'halls-taekwondo.jpg','image',2890,1874,1447680,NULL,NULL,NULL,'2018-10-24 03:05:26','2018-10-24 03:05:29','2018-10-24 03:05:29','3d38a138-910a-42a9-ba20-229d102c3433'),(89,1,1,NULL,'man-test.jpg','image',2892,1800,2155800,NULL,NULL,NULL,'2018-10-24 03:05:31','2018-10-24 03:05:31','2018-10-24 03:05:31','e160ef96-4211-4a72-954b-6e41bd24f04d'),(90,1,1,NULL,'uxmas.jpg','image',2890,2042,1460838,NULL,NULL,NULL,'2018-10-24 03:05:32','2018-10-24 03:05:35','2018-10-24 03:05:35','4a633163-7b80-43ce-8696-a9fefbf9e4e3'),(91,1,1,NULL,'womens-health-week.jpg','image',2816,2062,1159762,NULL,NULL,NULL,'2018-10-24 03:05:38','2018-10-24 03:05:39','2018-10-24 03:05:39','b9327573-8aa9-490a-be5f-4bdd9c93e9ff'),(94,1,1,NULL,'man-test-quiz.jpg','image',1440,992,1366692,NULL,NULL,NULL,'2018-10-24 19:28:32','2018-10-24 19:28:34','2018-10-24 19:28:34','99349a1d-0d8b-4133-85a7-47e4081ef5fc'),(99,1,4,NULL,'exercise-86200_1920.jpg','image',1920,1280,749163,NULL,NULL,NULL,'2018-10-26 19:03:53','2018-10-26 19:03:54','2018-10-26 19:11:44','b91d7739-80ff-457d-9b81-a52422c68bad'),(102,1,6,NULL,'exercise-86200_1920_181026_191207.jpg','image',1920,1280,748851,NULL,NULL,NULL,'2018-10-26 19:12:07','2018-10-26 19:12:07','2018-10-26 19:12:21','868729cb-c959-4e5b-92c0-5ea712de52dd'),(103,1,1,NULL,'macrolease.jpg','image',1440,1553,854288,NULL,NULL,NULL,'2018-10-26 19:37:44','2018-10-26 19:37:44','2018-10-26 19:37:44','7554a2a9-08c1-4b36-974f-0cfce294c433'),(104,1,1,NULL,'macrolease-advantage.jpg','image',1440,2310,606156,NULL,NULL,NULL,'2018-10-26 19:39:17','2018-10-26 19:39:17','2018-10-26 19:39:17','de86c679-aeb9-4d8f-af39-8d198f34ec9e'),(105,1,1,NULL,'macrolease-old.jpg','image',1440,853,376948,NULL,NULL,NULL,'2018-10-26 19:39:18','2018-10-26 19:39:18','2018-10-26 19:39:18','decde3e4-f4a4-443c-b1bd-4116cfb6c81b'),(108,1,4,NULL,'macrolease.jpg','image',1600,1507,383227,NULL,NULL,NULL,'2018-11-02 04:41:37','2018-11-02 04:41:38','2018-11-02 04:41:38','096ffd2f-87e5-4fe1-8b41-4797a57e8316'),(110,1,4,NULL,'about.jpg','image',1600,981,1598635,NULL,NULL,NULL,'2020-06-25 02:15:16','2020-06-25 02:15:18','2020-06-25 02:15:18','fe2af097-3d04-45f2-8372-ad053f05139a'),(113,1,4,NULL,'header-portrait.jpg','image',800,1040,117680,NULL,NULL,NULL,'2020-09-22 21:35:29','2020-09-22 21:35:30','2020-09-22 21:35:30','e1cdbf03-7bce-481a-bd4d-4aa86fe0bdef'),(116,1,4,NULL,'lying.jpg','image',1440,790,84809,NULL,NULL,NULL,'2020-09-22 21:38:07','2020-09-22 21:38:07','2020-09-22 21:38:07','9ee44f90-5817-4d35-b528-8473ddf3f8be'),(117,1,6,NULL,'idealist-help-hero.jpg','image',1920,981,639101,NULL,NULL,NULL,'2020-12-21 20:18:51','2020-12-21 20:18:51','2020-12-21 20:18:51','729af627-f514-466d-b35c-16a8babc93aa'),(121,1,4,NULL,'Artboard-2_201130_031938.jpg','image',1280,1280,629524,NULL,NULL,NULL,'2020-12-23 14:43:40','2020-12-23 14:43:41','2020-12-23 14:43:41','c587c598-cf80-43a3-96d8-05283b210f3c');
/*!40000 ALTER TABLE `craft_assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_assettransforms` VALUES (1,'Masked','masked','crop','center-center',1200,800,NULL,30,'none','2018-09-13 02:18:01','2018-08-29 23:16:11','2018-09-13 02:18:01','4a27c079-071e-4be9-a104-71c91786949b'),(2,'Thumbnail','thumbnail','crop','center-center',280,280,NULL,82,'none','2018-08-29 23:16:56','2018-08-29 23:16:56','2018-08-29 23:16:56','f1dd0f6a-7c8c-4701-adc3-16803a4471bb'),(3,'WYSIWYG','wysiwyg','crop','center-center',960,NULL,NULL,82,'none','2018-10-24 02:18:13','2018-10-24 02:18:13','2018-10-24 02:18:13','cddab5be-3121-4dc8-ac07-27d48b71edde');
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_categories` VALUES (5,2,NULL,NULL,'2018-08-29 23:30:09','2020-12-28 15:15:22','cc3cb555-365b-4557-8bc7-9b7a3d8309fc'),(6,2,NULL,NULL,'2018-08-29 23:30:33','2020-12-28 16:45:38','aa6c66f0-8180-4d84-8b22-470d6e25b618'),(7,2,NULL,NULL,'2018-08-29 23:30:44','2020-12-28 15:55:32','a1e11c8f-347b-4a3b-941b-5a87a66fe62a'),(8,2,NULL,NULL,'2018-08-29 23:30:58','2020-12-28 16:51:40','6ba18927-2dab-4da3-92da-f3f2d2531ec6'),(10,2,NULL,NULL,'2018-08-29 23:31:32','2020-12-21 21:11:12','94bb53f8-a5e4-48fc-b591-43deacf3d433'),(12,2,NULL,NULL,'2018-08-29 23:31:47','2020-12-28 15:59:34','f2209928-f0b9-4c8c-a66e-1d0a3a8d3d92'),(14,1,NULL,NULL,'2018-08-29 23:35:47','2018-08-29 23:35:47','46146bdb-887b-4035-a73f-69f85c5725dc'),(33,1,NULL,NULL,'2018-08-30 02:22:29','2018-08-30 02:22:29','9d9a94eb-2601-442f-b96d-c58813e75eb4'),(52,1,NULL,NULL,'2018-10-19 17:43:21','2018-10-19 17:43:21','e1903f5a-86e5-4d8c-b01f-8df8cefbb032'),(53,1,NULL,NULL,'2018-10-19 17:43:34','2018-10-19 17:43:34','2ff89c5e-fd4b-4e94-b050-13e16637efd6'),(54,1,NULL,NULL,'2018-10-19 17:43:51','2018-10-19 17:43:51','1ac1442b-1df8-4722-9525-e3e65786bb5b'),(55,1,NULL,NULL,'2018-10-19 17:45:06','2018-10-19 17:45:06','c9060989-812e-4d68-9175-97e187cefa29'),(56,1,NULL,NULL,'2018-10-19 17:45:27','2018-10-19 17:45:27','45da3279-caca-420d-869e-6c8a26e3f12f'),(57,1,NULL,NULL,'2018-10-19 17:45:51','2018-10-19 17:45:51','77ed292e-8b9c-436f-8a33-b1d27d790ecc'),(109,1,NULL,NULL,'2020-06-25 02:12:46','2020-06-25 02:12:46','bef8b197-c70c-4f46-8344-bf2d6a9f2bcb'),(120,2,NULL,NULL,'2020-12-21 20:29:07','2020-12-28 15:54:19','eabf64fa-0ec6-4bdf-bf45-78fdda6163aa'),(122,2,NULL,NULL,'2020-12-28 16:49:09','2020-12-28 16:49:09','e72fecd1-c9f5-4bd5-96d4-027ab276ccc9');
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_categorygroups` VALUES (1,1,1,'Entity','entity','2018-08-29 23:05:16','2018-10-19 17:42:50',NULL,'492f2972-c006-463a-bc0a-e5c717b071ad'),(2,2,4,'Project Category','projectCategory','2018-08-29 23:11:31','2020-12-28 15:11:05',NULL,'b1044122-fed0-47d2-ad0e-ac24c940dcb6');
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups_sites`
--

LOCK TABLES `craft_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_categorygroups_sites` VALUES (1,1,1,1,'entity/{slug}','entity/_category','2018-08-29 23:05:16','2018-10-19 17:42:50','8df0b142-b94a-44ec-8a1e-0555dab7066a'),(2,2,1,1,'project-category/{slug}','project-category/_category','2018-08-29 23:11:31','2020-12-28 15:11:05','9baf77ef-662c-44d7-949e-def9bb7890a8');
/*!40000 ALTER TABLE `craft_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_changedattributes`
--

LOCK TABLES `craft_changedattributes` WRITE;
/*!40000 ALTER TABLE `craft_changedattributes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_changedfields`
--

LOCK TABLES `craft_changedfields` WRITE;
/*!40000 ALTER TABLE `craft_changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_changedfields` VALUES (123,1,1,'2021-01-03 00:36:16',0,1),(123,1,3,'2021-01-03 00:36:16',0,1),(123,1,6,'2021-01-03 00:36:16',0,1),(123,1,9,'2021-01-03 00:36:16',0,1),(123,1,11,'2021-01-03 00:36:16',0,1),(123,1,12,'2021-01-03 00:36:16',0,1),(123,1,15,'2021-01-03 00:36:16',0,1),(123,1,16,'2021-01-03 00:36:16',0,1),(123,1,17,'2021-01-03 00:36:16',0,1),(123,1,18,'2021-01-03 00:36:16',0,1),(125,1,1,'2021-01-03 00:36:32',0,1),(125,1,3,'2021-01-03 00:36:32',0,1),(125,1,6,'2021-01-03 00:36:32',0,1),(125,1,9,'2021-01-03 00:36:32',0,1),(125,1,11,'2021-01-03 00:36:32',0,1),(125,1,12,'2021-01-03 00:36:32',0,1),(125,1,15,'2021-01-03 00:36:32',0,1),(125,1,16,'2021-01-03 00:36:32',0,1),(125,1,17,'2021-01-03 00:36:32',0,1),(125,1,18,'2021-01-03 00:36:32',0,1),(127,1,1,'2021-01-03 00:36:32',0,1),(127,1,3,'2021-01-03 00:36:32',0,1),(127,1,6,'2021-01-03 00:36:32',0,1),(127,1,9,'2021-01-03 00:36:32',0,1),(127,1,11,'2021-01-03 00:36:32',0,1),(127,1,12,'2021-01-03 00:36:32',0,1),(127,1,15,'2021-01-03 00:36:32',0,1),(127,1,16,'2021-01-03 00:36:32',0,1),(127,1,17,'2021-01-03 00:36:32',0,1),(127,1,18,'2021-01-03 00:36:32',0,1),(130,1,1,'2021-01-03 00:36:32',0,1),(130,1,3,'2021-01-03 00:36:32',0,1),(130,1,6,'2021-01-03 00:36:32',0,1),(130,1,8,'2021-01-03 00:36:32',0,1),(130,1,9,'2021-01-03 00:36:32',0,1),(130,1,11,'2021-01-03 00:36:32',0,1),(130,1,12,'2021-01-03 00:36:32',0,1),(130,1,15,'2021-01-03 00:36:32',0,1),(130,1,16,'2021-01-03 00:36:32',0,1),(130,1,17,'2021-01-03 00:36:32',0,1),(130,1,18,'2021-01-03 00:36:32',0,1),(133,1,1,'2021-01-03 00:36:33',0,1),(133,1,3,'2021-01-03 00:36:33',0,1),(133,1,6,'2021-01-03 00:36:33',0,1),(133,1,9,'2021-01-03 00:36:33',0,1),(133,1,11,'2021-01-03 00:36:33',0,1),(133,1,12,'2021-01-03 00:36:33',0,1),(133,1,15,'2021-01-03 00:36:33',0,1),(133,1,16,'2021-01-03 00:36:33',0,1),(133,1,17,'2021-01-03 00:36:33',0,1),(133,1,18,'2021-01-03 00:36:33',0,1),(135,1,1,'2021-01-03 00:36:33',0,1),(135,1,3,'2021-01-03 00:36:33',0,1),(135,1,6,'2021-01-03 00:36:33',0,1),(135,1,8,'2021-01-03 00:36:33',0,1),(135,1,9,'2021-01-03 00:36:33',0,1),(135,1,11,'2021-01-03 00:36:33',0,1),(135,1,12,'2021-01-03 00:36:33',0,1),(135,1,15,'2021-01-03 00:36:33',0,1),(135,1,17,'2021-01-03 00:36:33',0,1),(135,1,18,'2021-01-03 00:36:33',0,1),(137,1,1,'2021-01-03 00:36:33',0,1),(137,1,3,'2021-01-03 00:36:33',0,1),(137,1,6,'2021-01-03 00:36:33',0,1),(137,1,9,'2021-01-03 00:36:33',0,1),(137,1,11,'2021-01-03 00:36:33',0,1),(137,1,12,'2021-01-03 00:36:33',0,1),(137,1,15,'2021-01-03 00:36:33',0,1),(137,1,16,'2021-01-03 00:36:33',0,1),(137,1,17,'2021-01-03 00:36:33',0,1),(137,1,18,'2021-01-03 00:36:33',0,1),(140,1,1,'2021-01-03 00:36:33',0,1),(140,1,3,'2021-01-03 00:36:33',0,1),(140,1,6,'2021-01-03 00:36:33',0,1),(140,1,9,'2021-01-03 00:36:33',0,1),(140,1,11,'2021-01-03 00:36:33',0,1),(140,1,12,'2021-01-03 00:36:33',0,1),(140,1,15,'2021-01-03 00:36:33',0,1),(140,1,16,'2021-01-03 00:36:33',0,1),(140,1,17,'2021-01-03 00:36:33',0,1),(140,1,18,'2021-01-03 00:36:33',0,1),(143,1,1,'2021-01-03 00:36:33',0,1),(143,1,3,'2021-01-03 00:36:33',0,1),(143,1,6,'2021-01-03 00:36:33',0,1),(143,1,9,'2021-01-03 00:36:33',0,1),(143,1,11,'2021-01-03 00:36:33',0,1),(143,1,12,'2021-01-03 00:36:33',0,1),(143,1,15,'2021-01-03 00:36:33',0,1),(143,1,16,'2021-01-03 00:36:33',0,1),(143,1,17,'2021-01-03 00:36:33',0,1),(143,1,18,'2021-01-03 00:36:33',0,1),(146,1,1,'2021-01-03 00:36:33',0,1),(146,1,3,'2021-01-03 00:36:33',0,1),(146,1,6,'2021-01-03 00:36:33',0,1),(146,1,8,'2021-01-03 00:36:33',0,1),(146,1,9,'2021-01-03 00:36:33',0,1),(146,1,11,'2021-01-03 00:36:33',0,1),(146,1,12,'2021-01-03 00:36:33',0,1),(146,1,15,'2021-01-03 00:36:33',0,1),(146,1,16,'2021-01-03 00:36:33',0,1),(146,1,17,'2021-01-03 00:36:33',0,1),(146,1,18,'2021-01-03 00:36:33',0,1),(149,1,1,'2021-01-03 00:36:33',0,1),(149,1,3,'2021-01-03 00:36:33',0,1),(149,1,6,'2021-01-03 00:36:33',0,1),(149,1,9,'2021-01-03 00:36:33',0,1),(149,1,11,'2021-01-03 00:36:33',0,1),(149,1,12,'2021-01-03 00:36:33',0,1),(149,1,15,'2021-01-03 00:36:33',0,1),(149,1,16,'2021-01-03 00:36:33',0,1),(149,1,17,'2021-01-03 00:36:33',0,1),(149,1,18,'2021-01-03 00:36:33',0,1),(152,1,1,'2021-01-03 00:36:33',0,1),(152,1,3,'2021-01-03 00:36:33',0,1),(152,1,6,'2021-01-03 00:36:33',0,1),(152,1,8,'2021-01-03 00:36:33',0,1),(152,1,9,'2021-01-03 00:36:33',0,1),(152,1,11,'2021-01-03 00:36:33',0,1),(152,1,12,'2021-01-03 00:36:33',0,1),(152,1,15,'2021-01-03 00:36:33',0,1),(152,1,16,'2021-01-03 00:36:33',0,1),(152,1,17,'2021-01-03 00:36:33',0,1),(152,1,18,'2021-01-03 00:36:33',0,1),(155,1,1,'2021-01-03 00:36:34',0,1),(155,1,3,'2021-01-03 00:36:34',0,1),(155,1,6,'2021-01-03 00:36:34',0,1),(155,1,9,'2021-01-03 00:36:34',0,1),(155,1,11,'2021-01-03 00:36:34',0,1),(155,1,12,'2021-01-03 00:36:34',0,1),(155,1,15,'2021-01-03 00:36:34',0,1),(155,1,17,'2021-01-03 00:36:34',0,1);
/*!40000 ALTER TABLE `craft_changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_content` VALUES (1,1,1,NULL,'2018-08-29 22:59:29','2018-08-29 22:59:29','96d2d9bf-f061-4fec-aa65-023cd2edfe4c',NULL,NULL,NULL,NULL,NULL),(2,2,1,'Will Makes Things','2018-08-29 23:19:39','2020-12-21 20:42:35','4fe8bd0c-de21-46f2-87ac-43f768142f54',NULL,'<p>I\'m Will Fifer: designer, developer, and whatever else gets the job done. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. The tools often change, but the goal remains the same: identifying and solving problems. </p>\n<p><a href=\"mailto:wfifer@gmail.com\" target=\"_blank\" title=\"Email me\" rel=\"noreferrer noopener\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it.</p>\n<p>Looking to Angel-invest in a concept store or food truck based purely on its pun-tastic name? Let\'s grab a beer. </p>',NULL,1,NULL),(3,3,1,'Will','2018-08-29 23:27:06','2018-10-24 01:10:23','662a147f-acf1-43dc-80a3-20290901fae3',NULL,NULL,NULL,NULL,NULL),(4,5,1,'Development','2018-08-29 23:30:09','2020-12-28 15:15:22','544683fa-7a61-4a34-aed7-462d25e16a84','laptop-code',NULL,NULL,NULL,'far'),(5,6,1,'UI Design','2018-08-29 23:30:33','2020-12-28 16:45:38','ccf8b128-7e09-4b03-83da-52b401f2c11a','vector-square',NULL,NULL,NULL,'far'),(6,7,1,'Graphic Design','2018-08-29 23:30:44','2020-12-28 15:55:32','2261d4fe-a45c-48fc-bf96-e3b69a7c87bf','crop',NULL,NULL,NULL,'far'),(7,8,1,'Illustration','2018-08-29 23:30:58','2020-12-28 16:51:40','985af63c-c973-4653-b410-212d6153a39a','pencil-alt',NULL,NULL,NULL,'far'),(8,9,1,'Identity','2018-08-29 23:31:28','2018-10-24 01:10:22','ba05197d-81ad-43b2-9218-f98a9e2ae867',NULL,NULL,NULL,NULL,NULL),(9,10,1,'Identity','2018-08-29 23:31:32','2020-12-21 21:11:12','beb27333-90f1-4c97-b433-792cbcbd5240','fingerprint',NULL,NULL,NULL,NULL),(10,11,1,'Taco','2018-08-29 23:31:44','2018-10-24 01:10:22','0f02b506-c3fb-4c69-a053-d135e19276ca',NULL,NULL,NULL,NULL,NULL),(11,12,1,'Awesome Tacos','2018-08-29 23:31:47','2020-12-28 15:59:34','d03a5107-dd73-4673-9ef3-c582fd9762dc','taco',NULL,NULL,NULL,'far'),(12,13,1,'Man Test','2018-08-29 23:34:40','2018-10-24 01:10:25','50aefdfd-274b-4b39-9377-33a25e04f4da',NULL,NULL,NULL,NULL,NULL),(13,14,1,'Thirst Studios','2018-08-29 23:35:47','2018-08-29 23:35:47','ddc16a2f-7f11-46b9-903c-c0d88690ab4f',NULL,NULL,'http://thirststudios.com/',NULL,NULL),(14,15,1,'The Man Test','2018-08-29 23:36:02','2018-10-24 19:33:39','1922c462-89c9-4b6c-85a1-0db231a2f326',NULL,'<p>\"Significant health problems such as high blood pressure, type 2 diabetes, heart disease, prostate cancer, testicular cancer, infertility, colon cancer and depression, could be detected and treated more effectively if men’s awareness of these problems was greater. By taking control of your own health, you can catch small issues before they become big problems.\"</p>','http://mantest.com.au/',1,NULL),(15,17,1,'Halls Taekwondo','2018-08-29 23:37:37','2018-10-24 01:10:25','0d87dd05-c218-416b-85b1-6fb7e15226d8',NULL,NULL,NULL,NULL,NULL),(16,18,1,'Hall\'s Taekwondo','2018-08-29 23:38:11','2018-10-24 20:20:29','f670a557-7a9f-4966-8b44-0ccb8ba25143',NULL,NULL,'https://hallstaekwondo.com.au',1,NULL),(17,20,1,'Womens Health Week','2018-08-29 23:38:35','2018-10-24 01:10:18','de5aa5a2-c59c-48a9-babc-5db47f02406b',NULL,NULL,NULL,NULL,NULL),(18,21,1,'Women\'s Health Week','2018-08-29 23:39:20','2020-12-28 16:50:56','1753f559-58f9-46da-abf7-f6bc7c80381a',NULL,NULL,'https://www.womenshealthweek.com.au/',0,NULL),(19,23,1,'Man Test Thumbnail','2018-08-29 23:56:35','2018-10-24 01:10:19','392a00fd-2acb-463d-8382-e6927e3fb933',NULL,NULL,NULL,NULL,NULL),(20,24,1,'Womens Health Week Thumbnail','2018-08-29 23:57:28','2018-10-24 01:10:18','bf824e27-7c19-430d-962a-54f62a7e38d0',NULL,NULL,NULL,NULL,NULL),(21,25,1,'Halls Taekwondo Thumbnail','2018-08-29 23:58:41','2018-10-24 01:10:20','f8c22c53-abd2-4596-b74b-e2773407bab9',NULL,NULL,NULL,NULL,NULL),(22,26,1,'Cengage Ecollection','2018-08-30 02:18:53','2018-10-24 01:10:27','d16e0190-f29f-45ee-bb2c-324aaab94c64',NULL,NULL,NULL,NULL,NULL),(23,27,1,'Cengage eCollection','2018-08-30 02:20:00','2018-10-24 20:30:41','89e9ae90-29e5-4191-9e48-31681b86dab0',NULL,'<p>This was a complete web port of an existing iOS app, leveraging various web APIs and a custom framework. For a demo, click <strong>Get Started</strong> on the <a href=\"https://app.pmecollection.com.au/\" target=\"_blank\" title=\"Cengage PM eCollection\" rel=\"noreferrer noopener\">home page</a>.</p>','https://app.pmecollection.com.au/',1,NULL),(24,29,1,'UXMas','2018-08-30 02:20:27','2018-10-24 01:10:26','36ac48f0-ec05-4058-9007-a76f7a6a952e',NULL,NULL,NULL,NULL,NULL),(25,30,1,'UXMas','2018-08-30 02:21:20','2018-11-15 19:29:42','d7095b7f-b4e5-44a3-8e8c-4812db85414a',NULL,NULL,'http://uxmas.com/',1,NULL),(26,32,1,'Change It Ourselves','2018-08-30 02:21:54','2018-10-24 01:10:24','c56183a3-d449-40b5-af58-545369e4bc62',NULL,NULL,NULL,NULL,NULL),(27,33,1,'Dale de Silva','2018-08-30 02:22:29','2018-08-30 02:22:29','7020033d-8cee-4d95-912a-424b1c0ecab9',NULL,NULL,'http://www.daledesilva.com/',NULL,NULL),(28,34,1,'Change It Ourselves','2018-08-30 02:22:43','2020-12-21 20:38:19','032cc183-c438-447f-a153-34003708c941',NULL,NULL,'http://changeitourselves.com.au/',0,NULL),(29,35,1,'Other Work','2018-08-30 02:23:07','2018-10-24 01:10:25','1909e7f3-a535-49db-811d-8ee2d2d1b463',NULL,NULL,NULL,NULL,NULL),(30,36,1,'Other Work','2018-08-30 02:23:35','2020-12-21 20:37:50','4661eb84-f91a-4e8c-b021-af50bfaaea6b',NULL,NULL,'https://www.behance.net/wfifer',1,NULL),(31,38,1,'Cengage Ecollection Thumbnail','2018-08-30 02:24:29','2018-10-24 01:10:22','23acf4f2-f471-4e87-afb3-b2d372b239aa',NULL,NULL,NULL,NULL,NULL),(32,39,1,'Change It Ourselves Thumbnail','2018-08-30 02:25:09','2018-10-24 01:10:20','5c3d3a4d-8fcf-45db-9ac2-570401a93801',NULL,NULL,NULL,NULL,NULL),(33,40,1,'Other Work Thumbnail','2018-08-30 02:26:19','2018-10-24 01:10:19','53a27525-4766-4a08-94f1-0abbe11c2b7e',NULL,NULL,NULL,NULL,NULL),(34,41,1,'UXMas Thumbnail','2018-08-30 02:26:58','2018-10-24 01:10:19','67489148-885e-45ad-b6d1-9644322a2aed',NULL,NULL,NULL,NULL,NULL),(35,43,1,'Img 5525','2018-08-30 23:45:46','2018-09-13 00:49:52','c2f4c453-8355-4178-bbc2-4a3e2651f684',NULL,NULL,NULL,NULL,NULL),(36,44,1,'Img 5501','2018-08-30 23:45:59','2018-09-13 00:50:13','76dcfaea-4473-4810-be47-c4b56fbab785',NULL,NULL,NULL,NULL,NULL),(37,45,1,'The World Needs Another Food Blog','2018-08-30 23:46:13','2018-10-19 19:09:37','aab3d2d1-e6ba-42ea-a5e6-2cacfe711bde',NULL,NULL,NULL,0,NULL),(38,47,1,'Food Blog Thumbnail','2018-08-31 00:03:45','2018-09-13 00:49:53','90add30b-c64d-4949-b041-d3e45f7c04f0',NULL,NULL,NULL,NULL,NULL),(39,48,1,'Food Blog','2018-08-31 00:03:53','2018-09-13 00:50:05','9e0fe1f2-3b97-402b-8c97-7b8461c4c44d',NULL,NULL,NULL,NULL,NULL),(43,52,1,'Cengage','2018-10-19 17:43:21','2018-10-19 17:43:21','eb5b1249-ab75-4b73-80ba-edbc9f1599f2',NULL,NULL,'https://cengage.com.au/',NULL,NULL),(44,53,1,'Baker Institute','2018-10-19 17:43:34','2018-10-19 17:43:34','78656860-0405-411e-aece-a6ca774df0cb',NULL,NULL,'https://www.baker.edu.au/',NULL,NULL),(45,54,1,'Jean Hailes Women\'s Hospital','2018-10-19 17:43:51','2018-10-19 17:43:51','e640fced-9979-40f1-917a-2f2cda226fdb',NULL,NULL,'https://jeanhailes.org.au/',NULL,NULL),(46,55,1,'UX Mastery','2018-10-19 17:45:06','2018-10-19 17:45:06','892f88a0-e967-4cd5-8aef-85ff0ebc2c4d',NULL,NULL,'https://uxmastery.com/',NULL,NULL),(47,56,1,'Hall\'s Taekwondo','2018-10-19 17:45:27','2018-10-19 17:45:27','83d1838a-b99e-4558-bd6c-97ce8973344b',NULL,NULL,'https://www.hallstaekwondo.com.au/',NULL,NULL),(48,57,1,'Various','2018-10-19 17:45:51','2018-10-19 17:45:51','a474b94a-d74d-477b-8cba-a71ff4249b6e',NULL,NULL,NULL,NULL,NULL),(74,84,1,'Change It Ourselves Take Part','2018-10-24 03:05:02','2018-10-24 03:05:02','5a1af6e5-8916-452d-a240-6780f32febff',NULL,NULL,NULL,NULL,NULL),(75,85,1,'Ecollection Reader','2018-10-24 03:05:13','2018-10-24 03:05:13','ff386ba2-6540-4b07-9dfd-64649e0ea18c',NULL,NULL,NULL,NULL,NULL),(76,86,1,'Ecollection','2018-10-24 03:05:21','2018-10-24 03:05:21','7f06a88a-0a1c-4faf-9c04-40ac8b172475',NULL,NULL,NULL,NULL,NULL),(77,87,1,'Halls Taekwondo Shop','2018-10-24 03:05:24','2018-10-24 03:05:24','efa1eccd-b30b-41ac-bd64-2eef45e627f3',NULL,NULL,NULL,NULL,NULL),(78,88,1,'Halls Taekwondo','2018-10-24 03:05:25','2018-10-24 03:05:25','574ea6d9-8990-442c-8117-34f56298351c',NULL,NULL,NULL,NULL,NULL),(79,89,1,'Man Test','2018-10-24 03:05:30','2018-10-24 03:05:30','eb621577-307d-4484-b997-21e3805c0af9',NULL,NULL,NULL,NULL,NULL),(80,90,1,'Uxmas','2018-10-24 03:05:32','2018-10-24 03:05:32','d8e88652-d97b-40a0-b230-7800dcc0b2e9',NULL,NULL,NULL,NULL,NULL),(81,91,1,'Womens Health Week','2018-10-24 03:05:38','2018-10-24 03:05:38','f3ec146b-e4c1-4a6a-ae1f-b312922d8220',NULL,NULL,NULL,NULL,NULL),(82,94,1,'Man Test Quiz','2018-10-24 19:28:32','2018-10-24 19:28:32','957b6915-562b-4117-8bc2-7cc4138ef32a',NULL,NULL,NULL,NULL,NULL),(83,99,1,'Macrolease Fitness','2018-10-26 19:03:53','2018-10-26 19:11:44','f2293cff-8a01-496b-9ba4-c0b5352ed048',NULL,NULL,NULL,NULL,NULL),(84,100,1,'Macrolease','2018-10-26 19:08:08','2020-12-28 16:50:35','7b856364-bb64-413d-8e74-67671230993a',NULL,'<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessitated consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, an oft overlooked component of web development.</p>','https://macrolease.com',0,NULL),(85,102,1,'Exercise 86200 1920','2018-10-26 19:12:07','2018-10-26 19:12:21','63c5d6a7-dbbf-41aa-990c-65cc8ddf2636',NULL,NULL,NULL,NULL,NULL),(86,103,1,'Macrolease','2018-10-26 19:37:43','2018-10-26 19:37:43','620a4e99-2f6f-4e0a-947d-35305f5613cb',NULL,NULL,NULL,NULL,NULL),(87,104,1,'Macrolease Advantage','2018-10-26 19:39:17','2018-10-26 19:39:17','3fb6cdde-948e-4070-9e24-889bff363920',NULL,NULL,NULL,NULL,NULL),(88,105,1,'Macrolease Old','2018-10-26 19:39:18','2018-10-26 19:39:18','9a4d1bcb-dd0d-453d-9cf6-8747ccd5db51',NULL,NULL,NULL,NULL,NULL),(89,108,1,'Macrolease','2018-11-02 04:41:37','2018-11-02 04:41:37','69e7c0a9-6f92-4c25-b87b-74d706c0966e',NULL,NULL,NULL,NULL,NULL),(90,109,1,'Leo Flander','2020-06-25 02:12:45','2020-06-25 02:12:45','f775700c-654b-4de4-b629-09eed18be414',NULL,NULL,NULL,NULL,NULL),(91,110,1,'About','2020-06-25 02:15:16','2020-06-25 02:15:16','5ebe516e-dfa3-4f2f-959a-dde26457ed8f',NULL,NULL,NULL,NULL,NULL),(92,111,1,'Portraits for Change','2020-06-25 02:15:33','2020-12-28 16:46:23','8ef9e04b-ce99-4edd-987d-83ee7defca4d',NULL,NULL,'http://www.oilportraits.org/',1,NULL),(93,113,1,'Header Portrait','2020-09-22 21:35:29','2020-09-22 21:35:29','393c34b7-2637-4c40-b2e0-00baa2e36fd8',NULL,NULL,NULL,NULL,NULL),(94,114,1,'Cicada','2020-09-22 21:37:06','2020-12-28 20:22:32','74379b05-d96c-400f-b986-e2e9bcd48b92',NULL,NULL,'https://cicadafilm.com',0,NULL),(95,116,1,'Lying','2020-09-22 21:38:07','2020-09-22 21:38:07','16380cce-5886-4e8e-9757-24f0d0b0fcfd',NULL,NULL,NULL,NULL,NULL),(96,117,1,'Idealist Help Hero','2020-12-21 20:18:50','2020-12-21 20:18:50','9035dcc4-c964-441a-80dd-ef30340910f9',NULL,NULL,NULL,NULL,NULL),(97,118,1,'Idealist.org','2020-12-21 20:24:33','2020-12-28 20:43:18','6101c013-5f74-428c-a7aa-82673826a4bd',NULL,NULL,'https://idealist.org',1,NULL),(98,120,1,'Product Design','2020-12-21 20:29:07','2020-12-28 15:54:19','197d7473-541a-4faa-bdea-88f9dd0b404d','lightbulb-on',NULL,NULL,NULL,'far'),(99,121,1,'Artboard 2 201130 031938','2020-12-23 14:43:40','2020-12-23 14:43:40','514b11b9-71f4-430d-ac9b-de7685da5bb9',NULL,NULL,NULL,NULL,NULL),(100,122,1,'UX Design','2020-12-28 16:49:09','2020-12-28 16:49:09','c043ab24-2972-4e2e-86c2-e1dfd5f5343e','street-view',NULL,NULL,NULL,'far'),(101,123,1,'Idealist.org','2021-01-03 00:36:15','2021-01-03 00:36:16','94e5b4b1-4845-44f8-8c38-62d1b7a4d625',NULL,NULL,'https://idealist.org',1,NULL),(102,125,1,'Cicada','2021-01-03 00:36:32','2021-01-03 00:36:32','cea83f86-21e3-4890-9044-ec6addbf3b8d',NULL,NULL,'https://cicadafilm.com',0,NULL),(103,127,1,'Women\'s Health Week','2021-01-03 00:36:32','2021-01-03 00:36:32','c0cc0e6d-2c00-40cb-b30a-1f4565cece88',NULL,NULL,'https://www.womenshealthweek.com.au/',0,NULL),(104,130,1,'Macrolease','2021-01-03 00:36:32','2021-01-03 00:36:32','d0e43d8a-4f6a-46d0-887f-50742ef59fa7',NULL,'<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessitated consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, an oft overlooked component of web development.</p>','https://macrolease.com',0,NULL),(105,133,1,'Portraits for Change','2021-01-03 00:36:32','2021-01-03 00:36:33','80b0d41c-6f59-4486-b669-15754cd2e670',NULL,NULL,'http://www.oilportraits.org/',1,NULL),(106,135,1,'Will Makes Things','2021-01-03 00:36:33','2021-01-03 00:36:33','8f8d1f20-9042-4b40-b3f6-be1d5f5ed0ef',NULL,'<p>I\'m Will Fifer: designer, developer, and whatever else gets the job done. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. The tools often change, but the goal remains the same: identifying and solving problems. </p>\n<p><a href=\"mailto:wfifer@gmail.com\" target=\"_blank\" title=\"Email me\" rel=\"noreferrer noopener\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it.</p>\n<p>Looking to Angel-invest in a concept store or food truck based purely on its pun-tastic name? Let\'s grab a beer. </p>',NULL,1,NULL),(107,137,1,'Change It Ourselves','2021-01-03 00:36:33','2021-01-03 00:36:33','3ae14fc3-56cf-4c23-928d-e40b7e064c79',NULL,NULL,'http://changeitourselves.com.au/',0,NULL),(108,140,1,'Other Work','2021-01-03 00:36:33','2021-01-03 00:36:33','542fb157-1ed9-4e2d-bc95-f84f9689d9e3',NULL,NULL,'https://www.behance.net/wfifer',1,NULL),(109,143,1,'UXMas','2021-01-03 00:36:33','2021-01-03 00:36:33','44c2be32-50e7-461b-b235-ece5a728d25f',NULL,NULL,'http://uxmas.com/',1,NULL),(110,146,1,'Cengage eCollection','2021-01-03 00:36:33','2021-01-03 00:36:33','6c8a9f50-bf5d-4e61-9609-6a8db7beced9',NULL,'<p>This was a complete web port of an existing iOS app, leveraging various web APIs and a custom framework. For a demo, click <strong>Get Started</strong> on the <a href=\"https://app.pmecollection.com.au/\" target=\"_blank\" title=\"Cengage PM eCollection\" rel=\"noreferrer noopener\">home page</a>.</p>','https://app.pmecollection.com.au/',1,NULL),(111,149,1,'Hall\'s Taekwondo','2021-01-03 00:36:33','2021-01-03 00:36:33','b0b24785-28b5-46c9-a7aa-3877f19721a2',NULL,NULL,'https://hallstaekwondo.com.au',1,NULL),(112,152,1,'The Man Test','2021-01-03 00:36:33','2021-01-03 00:36:33','00354109-5e36-4d79-a54f-e5cc8eeb4cda',NULL,'<p>\"Significant health problems such as high blood pressure, type 2 diabetes, heart disease, prostate cancer, testicular cancer, infertility, colon cancer and depression, could be detected and treated more effectively if men’s awareness of these problems was greater. By taking control of your own health, you can catch small issues before they become big problems.\"</p>','http://mantest.com.au/',1,NULL),(113,155,1,'The World Needs Another Food Blog','2021-01-03 00:36:33','2021-01-03 00:36:34','1f65132f-5311-4438-9dc1-bec87de83d55',NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_craftidtokens`
--

LOCK TABLES `craft_craftidtokens` WRITE;
/*!40000 ALTER TABLE `craft_craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_deprecationerrors` VALUES (1,'siteUrl','/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/base/BaseObject.php:109','2022-10-19 17:39:43','/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/base/BaseObject.php',109,'The `siteUrl` config setting has been deprecated. You can set your site’s Base URL setting on a per-environment basis using an alias or environment variable. See [Environmental Configuration](https://craftcms.com/docs/3.x/config/#environmental-configuration) for more info.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/config/GeneralConfig.php\",\"line\":1868,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"siteUrl\\\", \\\"The `siteUrl` config setting has been deprecated. You can set yo...\\\"\"},{\"objectClass\":\"craft\\\\config\\\\GeneralConfig\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/base/BaseObject.php\",\"line\":109,\"class\":\"craft\\\\config\\\\GeneralConfig\",\"method\":\"init\",\"args\":null},{\"objectClass\":\"craft\\\\config\\\\GeneralConfig\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/services/Config.php\",\"line\":102,\"class\":\"yii\\\\base\\\\BaseObject\",\"method\":\"__construct\",\"args\":\"[\\\"defaultWeekStartDay\\\" => 0, \\\"enableCsrfProtection\\\" => true, \\\"omitScriptNameInUrls\\\" => true, \\\"cpTrigger\\\" => \\\"admin\\\", ...]\"},{\"objectClass\":\"craft\\\\services\\\\Config\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/services/Config.php\",\"line\":170,\"class\":\"craft\\\\services\\\\Config\",\"method\":\"getConfigSettings\",\"args\":\"\\\"general\\\"\"},{\"objectClass\":\"craft\\\\services\\\\Config\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/helpers/App.php\",\"line\":949,\"class\":\"craft\\\\services\\\\Config\",\"method\":\"getGeneral\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/config/app.web.php\",\"line\":11,\"class\":\"craft\\\\helpers\\\\App\",\"method\":\"webRequestConfig\",\"args\":null},{\"objectClass\":null,\"file\":null,\"line\":null,\"class\":null,\"method\":\"{closure}\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/di/Container.php\",\"line\":633,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"Closure, []\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/BaseYii.php\",\"line\":349,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"invoke\",\"args\":\"Closure, []\"},{\"objectClass\":null,\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/di/ServiceLocator.php\",\"line\":137,\"class\":\"yii\\\\BaseYii\",\"method\":\"createObject\",\"args\":\"Closure\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/base/Module.php\",\"line\":766,\"class\":\"yii\\\\di\\\\ServiceLocator\",\"method\":\"get\",\"args\":\"\\\"request\\\", true\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/web/Application.php\",\"line\":343,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"get\",\"args\":\"\\\"request\\\", true\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/web/Application.php\",\"line\":160,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"get\",\"args\":\"\\\"request\\\"\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/base/ApplicationTrait.php\",\"line\":1459,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"getRequest\",\"args\":null},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/web/Application.php\",\"line\":91,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"_preInit\",\"args\":null},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/base/BaseObject.php\",\"line\":109,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"init\",\"args\":null},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/base/Application.php\",\"line\":204,\"class\":\"yii\\\\base\\\\BaseObject\",\"method\":\"__construct\",\"args\":\"[\\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", \\\"name\\\" => \\\"Craft CMS\\\", ...]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":null,\"line\":null,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"__construct\",\"args\":\"[\\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", \\\"name\\\" => \\\"Craft CMS\\\", ...]\"},{\"objectClass\":\"ReflectionClass\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/di/Container.php\",\"line\":419,\"class\":\"ReflectionClass\",\"method\":\"newInstanceArgs\",\"args\":\"[[\\\"vendorPath\\\" => \\\"/Users/willfifer/Development/portfolio/craft/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]]\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/di/Container.php\",\"line\":170,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"build\",\"args\":\"\\\"craft\\\\web\\\\Application\\\", [], [\\\"vendorPath\\\" => \\\"/Users/willfifer/Development/portfolio/craft/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/yiisoft/yii2/BaseYii.php\",\"line\":365,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"get\",\"args\":\"\\\"craft\\\\web\\\\Application\\\", [], [\\\"vendorPath\\\" => \\\"/Users/willfifer/Development/portfolio/craft/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":null,\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/src/Craft.php\",\"line\":61,\"class\":\"yii\\\\BaseYii\",\"method\":\"createObject\",\"args\":\"[\\\"vendorPath\\\" => \\\"/Users/willfifer/Development/portfolio/craft/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...], []\"},{\"objectClass\":null,\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/bootstrap/bootstrap.php\",\"line\":247,\"class\":\"Craft\",\"method\":\"createObject\",\"args\":\"[\\\"vendorPath\\\" => \\\"/Users/willfifer/Development/portfolio/craft/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":null,\"file\":\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms/bootstrap/web.php\",\"line\":51,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms...\\\"\"},{\"objectClass\":null,\"file\":\"/Users/willfifer/Development/portfolio/craft/public_html/index.php\",\"line\":20,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/willfifer/Development/portfolio/craft/vendor/craftcms/cms...\\\"\"}]','2022-10-19 17:39:43','2022-10-19 17:39:43','96874631-b625-446c-9f92-69d2ef0d136b');
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_drafts`
--

LOCK TABLES `craft_drafts` WRITE;
/*!40000 ALTER TABLE `craft_drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elementindexsettings`
--

LOCK TABLES `craft_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `craft_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elementindexsettings` VALUES (1,'craft\\elements\\Category','{\"sources\":{\"group:b1044122-fed0-47d2-ad0e-ac24c940dcb6\":{\"tableAttributes\":{\"1\":\"link\",\"2\":\"field:2\"}}}}','2020-12-21 21:08:00','2020-12-21 21:08:00','6d19ac13-7ba4-4579-8d13-6f91c9889491');
/*!40000 ALTER TABLE `craft_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2018-08-29 22:59:29','2018-08-29 22:59:29',NULL,'4e50b23a-4ef7-4e98-8d43-32d605e42979'),(2,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-29 23:19:39','2020-12-21 20:42:35',NULL,'2e662b56-55c3-4756-8eae-edb46f713463'),(3,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:27:06','2018-10-24 01:10:23',NULL,'3ab8ffdc-1429-43a9-83bb-065c8f2f4869'),(4,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-29 23:28:35','2020-12-21 20:42:35',NULL,'6c03e3c9-71ac-48dd-a057-093ef1506f88'),(5,NULL,NULL,4,'craft\\elements\\Category',1,0,'2018-08-29 23:30:09','2020-12-28 15:15:22',NULL,'e87fceef-88f7-4b28-84fe-a1b8f17f0b8e'),(6,NULL,NULL,4,'craft\\elements\\Category',1,0,'2018-08-29 23:30:33','2020-12-28 16:45:38',NULL,'6eedb3ad-3e05-4410-b3d5-680e64bb4a38'),(7,NULL,NULL,4,'craft\\elements\\Category',1,0,'2018-08-29 23:30:44','2020-12-28 15:55:32',NULL,'ebb7d8a7-0478-4cfe-9585-c3a3f2063cf2'),(8,NULL,NULL,4,'craft\\elements\\Category',1,0,'2018-08-29 23:30:58','2020-12-28 16:51:40',NULL,'e3ef1e89-be1b-42fc-94b1-3b61194d4d47'),(9,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:31:28','2018-10-24 01:10:22',NULL,'f792f5ac-c6b9-4119-bc37-fb6de9d9cfd1'),(10,NULL,NULL,4,'craft\\elements\\Category',1,0,'2018-08-29 23:31:32','2020-12-21 21:11:12',NULL,'568a98d7-ff70-431b-bcaf-0c77731a3939'),(11,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:31:44','2018-10-24 01:10:22',NULL,'c1e97087-5603-42da-8cfe-1268c41c1c4d'),(12,NULL,NULL,4,'craft\\elements\\Category',1,0,'2018-08-29 23:31:47','2020-12-28 15:59:34',NULL,'0cd02a5e-924b-46f7-94c8-7c5988571277'),(13,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:34:40','2018-10-24 01:10:25',NULL,'2743d5bc-4486-4a06-b259-ae23ffb2d9e5'),(14,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-08-29 23:35:47','2018-08-29 23:35:47',NULL,'82078d89-5e05-4f3f-84e1-704d6ea36cb7'),(15,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-29 23:36:02','2018-10-24 19:33:39',NULL,'10e57ac3-164e-4c00-8d5d-3e1fe56a844d'),(16,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-29 23:36:02','2018-10-24 19:33:39',NULL,'10001726-d420-44c6-ab04-f3e98a532ec9'),(17,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:37:37','2018-10-24 01:10:25',NULL,'c50205f5-0a2e-4bef-a376-f2b05fc3a10b'),(18,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-29 23:38:11','2018-10-24 20:20:29',NULL,'bc6bcfae-ff53-46d0-ba98-218aea9e6b91'),(19,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-29 23:38:11','2018-10-24 20:20:29',NULL,'ad1e1d7b-6fe9-4538-8419-79e034ffd6c4'),(20,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:38:35','2018-10-24 01:10:18',NULL,'c5e8fbbd-960b-46de-9092-0ea2a8d89f70'),(21,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-29 23:39:20','2020-12-28 16:50:56',NULL,'89b13683-dc33-4ea1-8fdd-bfd9350f37b3'),(22,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-29 23:39:20','2020-12-28 16:50:56',NULL,'44a18039-b205-4db2-81b1-8ea0f2964adb'),(23,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:56:35','2018-10-24 01:10:19',NULL,'3d3d5656-3b83-4d9e-a4cc-32c3e14a04a2'),(24,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:57:28','2018-10-24 01:10:18',NULL,'f6e21747-54d1-4235-a2e8-264071d47a32'),(25,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-29 23:58:41','2018-10-24 01:10:20',NULL,'605dfe60-ddba-4ca3-862a-f5ff9afbea0b'),(26,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:18:53','2018-10-24 01:10:27',NULL,'99bdf8e8-0ab0-4752-8a04-b9eff710ff3a'),(27,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-30 02:20:00','2018-10-24 20:30:41',NULL,'583bb0f4-03ad-407d-8ff6-bb63ea2577eb'),(28,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-30 02:20:00','2018-10-24 20:30:42',NULL,'c4a922c3-0f88-4a8e-8de3-f267d19c0a3b'),(29,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:20:27','2018-10-24 01:10:26',NULL,'2a5b27f4-0f0c-4c31-b46f-4735f716f5ba'),(30,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-30 02:21:20','2018-11-15 19:29:42',NULL,'95751110-2287-4774-b9f7-9e8009bc4624'),(31,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-30 02:21:20','2018-11-15 19:29:56',NULL,'47cc6c71-9a68-4905-8a2a-ca2b26064095'),(32,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:21:54','2018-10-24 01:10:24',NULL,'7eff2013-dc92-4967-963d-aa53cdb6676f'),(33,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-08-30 02:22:29','2018-08-30 02:22:29',NULL,'4eb8be18-c684-4b3f-adf3-a563680948a5'),(34,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-30 02:22:43','2020-12-21 20:38:19',NULL,'eb59222f-1428-4ac9-9858-45bc5df80e19'),(35,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:23:07','2018-10-24 01:10:24',NULL,'3e5a908f-6015-47aa-b197-f57a31ab5af7'),(36,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-08-30 02:23:35','2020-12-21 20:37:50',NULL,'515d0bde-6858-4ce0-9c96-3ce57f724363'),(37,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-30 02:23:35','2020-12-21 20:37:50',NULL,'a427145b-8144-4a3b-8ea4-8bfaa4012169'),(38,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:24:29','2018-10-24 01:10:22',NULL,'6a9e3b5f-9c30-4a7b-831a-510838e6ca1f'),(39,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:25:09','2018-10-24 01:10:20',NULL,'b2c1dff7-d302-4dd4-99ee-a3cd0c1ee39b'),(40,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:26:19','2018-10-24 01:10:19',NULL,'977492be-2dad-492a-97f0-beb739777a05'),(41,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 02:26:58','2018-10-24 01:10:19',NULL,'36d9653b-fd98-46f3-92ec-42e797e1e297'),(42,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-30 02:28:25','2020-12-21 20:38:19',NULL,'5d378bac-aaa6-4344-9a85-178848fa4c48'),(43,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 23:45:46','2018-09-13 00:49:52',NULL,'c7ae9b1b-6258-4339-b849-e4e06dac57fa'),(44,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-30 23:45:59','2018-09-13 00:50:13',NULL,'73699b9d-872b-4f03-8060-722d4e56d306'),(45,NULL,NULL,7,'craft\\elements\\Entry',0,0,'2018-08-30 23:46:13','2018-10-19 19:09:37',NULL,'faee2d95-ff40-4b28-93b3-6489dade27dc'),(46,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-08-30 23:46:13','2018-10-19 19:09:37',NULL,'aad84b51-2e98-4866-a827-22dfac6f3ee1'),(47,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-31 00:03:45','2018-09-13 00:49:53',NULL,'e9c9201c-a030-411f-95ec-8556769e4f31'),(48,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-08-31 00:03:53','2018-09-13 00:50:05',NULL,'e259abcd-a6ca-4b56-8470-db19b7339afe'),(52,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-10-19 17:43:21','2018-10-19 17:43:21',NULL,'ee0b9749-5238-4dd9-b3aa-7032cd6c4914'),(53,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-10-19 17:43:34','2018-10-19 17:43:34',NULL,'a29e52d0-94e2-4c3b-9660-47ca5f006cee'),(54,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-10-19 17:43:51','2018-10-19 17:43:51',NULL,'63c8a491-d0ab-498f-911f-262004ae7f47'),(55,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-10-19 17:45:06','2018-10-19 17:45:06',NULL,'63a64ad3-5d07-42e9-8829-f34fad13a33a'),(56,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-10-19 17:45:27','2018-10-19 17:45:27',NULL,'d136f134-a13b-4e02-bfaf-378eeef71a41'),(57,NULL,NULL,1,'craft\\elements\\Category',1,0,'2018-10-19 17:45:51','2018-10-19 17:45:51',NULL,'5a909ef2-ae3c-4a11-bd4a-48e601e6ea8c'),(67,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-23 22:41:04','2018-10-24 19:33:39',NULL,'7e72b99f-c28b-4b2d-a713-fddfa1318f39'),(84,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:02','2018-10-24 03:05:02',NULL,'52cb61a0-5255-4104-aec8-6208220aa2a9'),(85,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:13','2018-10-24 03:05:13',NULL,'6c7d0baa-cedf-4129-a5a9-2f409cd4b9a8'),(86,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:21','2018-10-24 03:05:21',NULL,'d394be9c-f4e1-41e9-9383-c118bd53cf75'),(87,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:24','2018-10-24 03:05:24',NULL,'03674613-6983-44dd-a901-b2abb0a6d2a4'),(88,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:25','2018-10-24 03:05:25',NULL,'2f1b1a77-596f-421c-8522-d5f7d8df62da'),(89,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:30','2018-10-24 03:05:30',NULL,'dc764713-098e-45c3-8307-0cd15b891d1e'),(90,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:32','2018-10-24 03:05:32',NULL,'b8ba13ef-b1e9-4c58-b2d6-442dfcb956de'),(91,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 03:05:38','2018-10-24 03:05:38',NULL,'3d4f2535-d8f4-4aa6-8933-828f67a1f111'),(93,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-24 04:03:16','2018-11-15 19:29:57',NULL,'ad1ac6ef-5ad8-4a4b-b632-6a4a34c1681d'),(94,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-24 19:28:32','2018-10-24 19:28:32',NULL,'bde0cf6f-ae30-4ef2-81f6-33ce13c69217'),(95,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-24 20:20:29','2018-10-24 20:20:29',NULL,'beb8c407-b8a6-42d4-ae48-6f14a6709529'),(96,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-24 20:21:52','2020-12-28 16:50:56',NULL,'2fc405e8-0eb1-4d16-978a-9488172c4521'),(97,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-24 20:30:42','2018-10-24 20:30:42',NULL,'5615b5ae-5ebc-45fc-9b58-d91358e884bd'),(98,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-24 20:36:40','2020-12-21 20:38:19',NULL,'f55d70ed-82da-49d0-9a5a-146174835a57'),(99,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-26 19:03:53','2018-10-26 19:11:44',NULL,'4e8b62a9-81b0-4331-a27d-7265da919ee1'),(100,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2018-10-26 19:08:08','2020-12-28 16:50:35',NULL,'ebfd46d9-ef07-4193-8a9b-69a6dcc46a0f'),(101,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-10-26 19:08:08','2020-12-28 16:50:35',NULL,'b447559a-ed26-46e8-a2bf-396c317ec50a'),(102,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-26 19:12:07','2018-10-26 19:12:21',NULL,'fee43256-8fe4-4f88-8374-6c3cc2d9fab6'),(103,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-26 19:37:43','2018-10-26 19:37:43',NULL,'b51acd5a-eaac-48a0-8d53-b224306493d7'),(104,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-26 19:39:17','2018-10-26 19:39:17',NULL,'9aa0b21b-1a10-464f-b81b-4b1ac396919e'),(105,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-10-26 19:39:18','2018-10-26 19:39:18',NULL,'ee5323f5-d0fe-4235-909b-602b6d56b8c0'),(106,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-26 19:41:28','2020-12-28 16:50:35',NULL,'46c77f9a-5ff6-4668-8fe4-5219f356576a'),(107,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-10-26 22:33:19','2020-12-21 20:37:50',NULL,'0464c0a9-7211-4e2e-b3dd-193ecbbc4b27'),(108,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2018-11-02 04:41:37','2018-11-02 04:41:37',NULL,'76e0621d-38ef-4d47-b770-f87457efe667'),(109,NULL,NULL,1,'craft\\elements\\Category',1,0,'2020-06-25 02:12:45','2020-06-25 02:12:45',NULL,'16c53b37-bd02-4b2f-bfe4-9923b8baad30'),(110,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2020-06-25 02:15:16','2020-06-25 02:15:16',NULL,'3d60dd69-202f-4e55-8db7-d756a84311d1'),(111,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2020-06-25 02:15:33','2020-12-28 16:46:23',NULL,'7292d548-b933-4126-92cb-e319057cbb31'),(112,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-06-25 02:15:33','2020-12-28 16:46:23',NULL,'765c6f7a-f466-48b1-8681-136e0ace46ed'),(113,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2020-09-22 21:35:29','2020-09-22 21:35:29',NULL,'e34c9910-e3f4-4d40-acc7-6cd00b14434e'),(114,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2020-09-22 21:37:06','2020-12-28 20:22:32',NULL,'13fbc907-257f-4794-8665-96465c263069'),(115,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-09-22 21:37:06','2020-12-28 20:22:59',NULL,'4e1177fd-5b02-49c6-87c4-5dc86bcc5fdc'),(116,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2020-09-22 21:38:07','2020-09-22 21:38:07',NULL,'b4fa7719-4330-4161-9529-bd934f3b7f36'),(117,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2020-12-21 20:18:50','2020-12-21 20:18:50',NULL,'98efab08-5ef4-4855-bf3f-ea2fd61f182c'),(118,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2020-12-21 20:24:33','2020-12-28 20:43:18',NULL,'f5461744-5a80-459a-8e1b-111e19c9da67'),(119,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-12-21 20:24:33','2020-12-28 20:43:18',NULL,'5318f721-46d6-4461-a452-52463d42302d'),(120,NULL,NULL,4,'craft\\elements\\Category',1,0,'2020-12-21 20:29:07','2020-12-28 15:54:19',NULL,'dec382cf-12bb-4570-9deb-b0df69520a85'),(121,NULL,NULL,6,'craft\\elements\\Asset',1,0,'2020-12-23 14:43:40','2020-12-23 14:43:40',NULL,'9a107de1-f6dd-4b53-821d-2a4ca44ea9f1'),(122,NULL,NULL,4,'craft\\elements\\Category',1,0,'2020-12-28 16:49:09','2020-12-28 16:49:09',NULL,'753b6b44-2b59-4a1b-b4d9-749b205a832c'),(123,NULL,1,7,'craft\\elements\\Entry',1,0,'2020-12-28 20:43:18','2021-01-03 00:36:16',NULL,'886f0785-ff9e-4032-bcd7-5082f6189cec'),(124,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:15','2021-01-03 00:36:16',NULL,'83bc188c-aef3-4776-a440-7b80d5fad00f'),(125,NULL,2,7,'craft\\elements\\Entry',1,0,'2020-12-28 20:22:59','2021-01-03 00:36:32',NULL,'60e55a08-c9f7-47af-823c-4699da04d997'),(126,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:32','2021-01-03 00:36:32',NULL,'81f8c110-1c0f-4805-8b09-040497cf9248'),(127,NULL,3,7,'craft\\elements\\Entry',1,0,'2020-12-28 16:50:56','2021-01-03 00:36:32',NULL,'59d595df-3b3d-4927-a0d0-fda937479644'),(128,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:32','2021-01-03 00:36:32',NULL,'711d0a11-e466-4617-9244-5b852834e220'),(129,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:32','2021-01-03 00:36:32',NULL,'9ebbc001-120a-4b20-afc9-963da4d10dfd'),(130,NULL,4,7,'craft\\elements\\Entry',1,0,'2020-12-28 16:50:35','2021-01-03 00:36:32',NULL,'80798945-7e69-49e4-8a04-c37480bd9e91'),(131,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:32','2021-01-03 00:36:32',NULL,'03fae946-656a-460d-a2fc-14f9da570e6e'),(132,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:32','2021-01-03 00:36:32',NULL,'28218607-b192-4fca-81c6-5ff1725d8274'),(133,NULL,5,7,'craft\\elements\\Entry',1,0,'2020-12-28 16:46:23','2021-01-03 00:36:33',NULL,'c19abf6b-b68c-4b56-a25d-21460c44de6d'),(134,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'b935e07e-8d45-4078-b2bb-b37d2debddef'),(135,NULL,6,7,'craft\\elements\\Entry',1,0,'2020-12-21 20:42:35','2021-01-03 00:36:33',NULL,'78cf9307-aaea-40b5-968d-6527e52fa6ec'),(136,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'bb1026fc-cc76-4023-94a1-34b06bd2d641'),(137,NULL,7,7,'craft\\elements\\Entry',1,0,'2020-12-21 20:38:19','2021-01-03 00:36:33',NULL,'5fe28882-7e42-4308-913f-2febb334f813'),(138,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'4f002d06-25bd-4843-a145-1a4f9aa3d87c'),(139,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'03b9ff7d-57a9-459f-8cec-dbe4096472e1'),(140,NULL,8,7,'craft\\elements\\Entry',1,0,'2020-09-22 21:39:24','2021-01-03 00:36:33',NULL,'593ff590-3491-470b-a903-a5369867da92'),(141,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'485096b8-e1bd-4ec3-8b24-88f4155d3635'),(142,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'a08bb07b-b505-4f85-b23e-89aaeea191fc'),(143,NULL,9,7,'craft\\elements\\Entry',1,0,'2018-11-15 19:29:57','2021-01-03 00:36:33',NULL,'a5f2bf20-3604-4b51-8113-a77c502c3159'),(144,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'edc1d4e5-9f2d-478a-b87c-6d62f4b1e694'),(145,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'ef9d2bf2-a757-487d-b94a-938de6270adb'),(146,NULL,10,7,'craft\\elements\\Entry',1,0,'2018-10-24 20:30:42','2021-01-03 00:36:33',NULL,'16bd7ebc-aa47-494c-ab36-069ab56f56c4'),(147,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'342b31a8-05e0-4c1d-b60f-00de5920ee5f'),(148,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'c8bf040c-262e-4976-9b7b-2bb581ca1bf9'),(149,NULL,11,7,'craft\\elements\\Entry',1,0,'2018-10-24 20:20:29','2021-01-03 00:36:33',NULL,'d6984503-c59b-40c9-938b-e654905a6f50'),(150,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'95925c9a-39c7-43fe-ba60-4799e5e9a0ed'),(151,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'7b364fca-4814-45cc-a023-f8330b447221'),(152,NULL,12,7,'craft\\elements\\Entry',1,0,'2018-10-24 19:33:39','2021-01-03 00:36:33',NULL,'bba36e42-9d2c-4741-97e2-504664d3a721'),(153,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'e68f4e31-0721-49c0-84f4-abbcf2fe2deb'),(154,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:33','2021-01-03 00:36:33',NULL,'5461a4ef-cad7-4b38-a89c-31af74916fd2'),(155,NULL,13,7,'craft\\elements\\Entry',0,0,'2018-10-19 19:01:56','2021-01-03 00:36:34',NULL,'f2a60fec-a801-4710-b1d2-1f8024e02d61'),(156,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-01-03 00:36:34','2021-01-03 00:36:34',NULL,'be196c53-71ed-4930-bcd7-3ee6f7c6a7c1');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements_sites`
--

LOCK TABLES `craft_elements_sites` WRITE;
/*!40000 ALTER TABLE `craft_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2018-08-29 22:59:29','2018-08-29 22:59:29','c9ad25fa-5286-49e1-adc3-1d03c0ad119a'),(2,2,1,'will-makes-things','projects/will-makes-things',1,'2018-08-29 23:19:39','2020-12-21 20:42:35','f6de71e6-a5ac-4f49-9372-d82b0904fd65'),(3,3,1,NULL,NULL,1,'2018-08-29 23:27:06','2018-10-24 01:10:23','ade7181e-2e89-49a8-82fb-db0d63aa5d14'),(4,4,1,NULL,NULL,1,'2018-08-29 23:28:35','2020-12-21 20:42:35','121d29df-eb43-47ce-a0cf-551fa726a9fd'),(5,5,1,'development','project-category/development',1,'2018-08-29 23:30:09','2020-12-28 16:45:56','3e0c0463-6be1-43f4-87c8-56978ca668d2'),(6,6,1,'ui-design','project-category/ui-design',1,'2018-08-29 23:30:33','2020-12-28 16:45:38','f65b4446-ffda-48f8-9b72-0252876bd1d3'),(7,7,1,'graphic-design','project-category/graphic-design',1,'2018-08-29 23:30:44','2020-12-28 15:55:32','35a22ce8-f0ec-49bb-b33b-b1a46707e9dd'),(8,8,1,'illustration','project-category/illustration',1,'2018-08-29 23:30:58','2020-12-28 16:51:40','af03ba2c-aab2-4a43-98d9-4419f6b34a9f'),(9,9,1,NULL,NULL,1,'2018-08-29 23:31:28','2018-10-24 01:10:22','88fa5b0e-bca1-438d-ab56-41f214539ef6'),(10,10,1,'identity','project-category/identity',1,'2018-08-29 23:31:32','2020-12-21 21:11:12','3f6d0889-26cc-4441-a6c6-3b26920f91ca'),(11,11,1,NULL,NULL,1,'2018-08-29 23:31:44','2018-10-24 01:10:22','f7e78766-bb60-402b-84b4-7c83e501d1ab'),(12,12,1,'awesome-tacos','project-category/awesome-tacos',1,'2018-08-29 23:31:47','2020-12-28 15:59:34','fc8d32ad-fe39-417b-90c1-3f582adb98c4'),(13,13,1,NULL,NULL,1,'2018-08-29 23:34:40','2018-10-24 01:10:25','fd02f9f8-dabb-49a3-bb1f-8ec3ae4a2492'),(14,14,1,'thirst-studios','entity/thirst-studios',1,'2018-08-29 23:35:47','2018-10-19 17:42:51','f0a195a5-a5bb-4ca4-b13e-274f6cce3da4'),(15,15,1,'the-man-test','projects/the-man-test',1,'2018-08-29 23:36:02','2018-10-26 19:59:09','41cc2154-d6cf-45d1-b721-6cf817a99430'),(16,16,1,NULL,NULL,1,'2018-08-29 23:36:02','2018-10-24 19:33:39','ce19b82c-3a1d-48bc-ade7-70852af28f36'),(17,17,1,NULL,NULL,1,'2018-08-29 23:37:37','2018-10-24 01:10:25','c4e20400-a232-4104-9697-382bb302c494'),(18,18,1,'halls-taekwondo','projects/halls-taekwondo',1,'2018-08-29 23:38:11','2018-10-24 20:20:29','29a36a8f-74e0-483c-9c39-89fe40443cab'),(19,19,1,NULL,NULL,1,'2018-08-29 23:38:11','2018-10-24 20:20:29','33fd1f08-dfe9-4698-bf1c-2a505425e7a4'),(20,20,1,NULL,NULL,1,'2018-08-29 23:38:35','2018-10-24 01:10:18','59bbeb8e-d1f4-4f05-b965-1b4a7dfabdf6'),(21,21,1,'womens-health-week','projects/womens-health-week',1,'2018-08-29 23:39:20','2020-12-28 16:50:56','317f9e85-2b27-48c9-9c2d-2797f04f0c23'),(22,22,1,NULL,NULL,1,'2018-08-29 23:39:20','2020-12-28 16:50:56','5e5e3132-44bb-4dcc-b8e5-95641b2ea227'),(23,23,1,NULL,NULL,1,'2018-08-29 23:56:35','2018-10-24 01:10:19','38701e99-38db-4a96-889c-30b9044cd7f9'),(24,24,1,NULL,NULL,1,'2018-08-29 23:57:28','2018-10-24 01:10:18','a8e1dd46-3960-4bb2-8af3-e5391c8be840'),(25,25,1,NULL,NULL,1,'2018-08-29 23:58:41','2018-10-24 01:10:20','02fa195d-6430-4741-83ad-037d38a4b53e'),(26,26,1,NULL,NULL,1,'2018-08-30 02:18:53','2018-10-24 01:10:27','a0c1bef9-17a9-43b8-9ba9-c68488c3ed13'),(27,27,1,'cengage-ecollection','projects/cengage-ecollection',1,'2018-08-30 02:20:00','2018-10-24 20:30:41','432a7c84-7ad5-48a8-914a-9a2157b399ff'),(28,28,1,NULL,NULL,1,'2018-08-30 02:20:00','2018-10-24 20:30:42','9b96e489-b42b-426b-9602-f94814de1850'),(29,29,1,NULL,NULL,1,'2018-08-30 02:20:27','2018-10-24 01:10:26','a861945f-65a5-49f3-800a-bffced53f550'),(30,30,1,'uxmas','projects/uxmas',1,'2018-08-30 02:21:20','2018-11-15 19:29:42','ef8b369e-7be6-41d4-949c-3770c565b537'),(31,31,1,NULL,NULL,1,'2018-08-30 02:21:20','2018-11-15 19:29:56','39800966-6500-4416-8c84-4fdbe2589d25'),(32,32,1,NULL,NULL,1,'2018-08-30 02:21:54','2018-10-24 01:10:24','4411c65d-4466-42cf-aba9-4d7f2f302889'),(33,33,1,'dale-de-silva','entity/dale-de-silva',1,'2018-08-30 02:22:29','2018-10-19 17:42:51','5a793f50-c086-4f23-a774-cafc872d0f08'),(34,34,1,'change-it-ourselves','projects/change-it-ourselves',1,'2018-08-30 02:22:43','2020-12-21 20:38:19','474c5404-54bd-43b5-83de-18738bba0191'),(35,35,1,NULL,NULL,1,'2018-08-30 02:23:07','2018-10-24 01:10:25','8a30ad9b-41df-4f99-9f74-e4414e69e9ba'),(36,36,1,'other-work','projects/other-work',1,'2018-08-30 02:23:35','2020-12-21 20:37:50','6206265c-d556-46c3-b117-dfe781843b08'),(37,37,1,NULL,NULL,1,'2018-08-30 02:23:35','2020-12-21 20:37:50','0814bc95-2764-4bd9-8d8d-7562ff5b141a'),(38,38,1,NULL,NULL,1,'2018-08-30 02:24:29','2018-10-24 01:10:22','b642d014-8e71-45b8-825d-c7235afdfa3d'),(39,39,1,NULL,NULL,1,'2018-08-30 02:25:09','2018-10-24 01:10:20','a381c9ab-e292-40bc-8cc5-16d23ca40d50'),(40,40,1,NULL,NULL,1,'2018-08-30 02:26:19','2018-10-24 01:10:19','81f094c9-6d33-412e-94b1-4aed1b4ec032'),(41,41,1,NULL,NULL,1,'2018-08-30 02:26:58','2018-10-24 01:10:19','1d1d824d-6ab1-4ed5-8558-45afd3722118'),(42,42,1,NULL,NULL,1,'2018-08-30 02:28:25','2020-12-21 20:38:19','ccf061d7-14a9-428e-90d4-55d9b4b51b2d'),(43,43,1,NULL,NULL,1,'2018-08-30 23:45:46','2018-09-13 00:49:52','c7951f56-136e-4c3b-bcdb-71b928577539'),(44,44,1,NULL,NULL,1,'2018-08-30 23:45:59','2018-09-13 00:50:13','e905b1d5-c2bf-40e7-8acb-ce6ef4d9d5c7'),(45,45,1,'food-blog','projects/food-blog',1,'2018-08-30 23:46:13','2018-10-19 19:09:37','acf9c3b0-70a0-43f5-a7f6-1c83d0d30600'),(46,46,1,NULL,NULL,1,'2018-08-30 23:46:13','2018-10-19 19:09:37','b3dbe3ea-cac9-4aba-92da-c4a4caa0aa70'),(47,47,1,NULL,NULL,1,'2018-08-31 00:03:45','2018-09-13 00:49:53','73b1fd56-7d46-4cd4-914c-fe65e2308c97'),(48,48,1,NULL,NULL,1,'2018-08-31 00:03:53','2018-09-13 00:50:05','1b1a7b09-09c0-4290-bf5d-3938877ed893'),(52,52,1,'cengage','entity/cengage',1,'2018-10-19 17:43:21','2018-10-19 17:43:23','4c3121f8-bf7e-463d-8142-00564e611e3e'),(53,53,1,'baker-institute','entity/baker-institute',1,'2018-10-19 17:43:34','2018-10-19 17:43:35','79c68dde-0165-413c-9ff5-98895b39bab5'),(54,54,1,'jean-hailes-womens-hospital','entity/jean-hailes-womens-hospital',1,'2018-10-19 17:43:51','2018-10-19 17:43:52','08340b6f-e3af-43ef-87cb-a076e7b5ea05'),(55,55,1,'ux-mastery','entity/ux-mastery',1,'2018-10-19 17:45:06','2018-10-19 17:45:08','87e3ea52-09ae-4a13-be78-2e7a4b70187f'),(56,56,1,'halls-taekwondo','entity/halls-taekwondo',1,'2018-10-19 17:45:27','2018-10-19 17:45:28','59deb131-b813-4654-acbf-8cd943242ada'),(57,57,1,'various','entity/various',1,'2018-10-19 17:45:51','2018-10-19 17:45:52','ea2c6d06-6c81-46c7-9a45-1114b5763a20'),(67,67,1,NULL,NULL,1,'2018-10-23 22:41:04','2018-10-24 19:33:39','51184286-202a-4cf4-a39e-098516997e9f'),(84,84,1,NULL,NULL,1,'2018-10-24 03:05:02','2018-10-24 03:05:02','0ebb78da-27e0-4099-a3ac-dad1d6aa3416'),(85,85,1,NULL,NULL,1,'2018-10-24 03:05:13','2018-10-24 03:05:13','6e2ccbd8-5f81-4b08-85f4-a39865044df2'),(86,86,1,NULL,NULL,1,'2018-10-24 03:05:21','2018-10-24 03:05:21','a6da28e1-534e-4b6c-b921-cd3b5b7f73af'),(87,87,1,NULL,NULL,1,'2018-10-24 03:05:24','2018-10-24 03:05:24','6ef7d6f6-269e-436d-8b00-572a78f75d5d'),(88,88,1,NULL,NULL,1,'2018-10-24 03:05:25','2018-10-24 03:05:25','0a8a42d7-9400-4deb-b017-daeed4d67c00'),(89,89,1,NULL,NULL,1,'2018-10-24 03:05:30','2018-10-24 03:05:30','86b3b8e0-bb26-4776-9b59-4b571d95cc93'),(90,90,1,NULL,NULL,1,'2018-10-24 03:05:32','2018-10-24 03:05:32','71d6ebd8-6e19-40e4-be32-6013a911076e'),(91,91,1,NULL,NULL,1,'2018-10-24 03:05:38','2018-10-24 03:05:38','0e01c54d-c102-4fbc-9a0a-6351ecb4b87e'),(93,93,1,NULL,NULL,1,'2018-10-24 04:03:16','2018-11-15 19:29:57','8bb4d63f-f61b-4c5a-a65c-8f6c5af417ab'),(94,94,1,NULL,NULL,1,'2018-10-24 19:28:32','2018-10-24 19:28:32','94f89353-86ca-4bd3-84cf-040ee2f30830'),(95,95,1,NULL,NULL,1,'2018-10-24 20:20:29','2018-10-24 20:20:29','78e9fde8-18f7-44f3-9132-528417c28537'),(96,96,1,NULL,NULL,1,'2018-10-24 20:21:52','2020-12-28 16:50:56','88dee1ed-0b34-4707-88cc-c974c61dbaab'),(97,97,1,NULL,NULL,1,'2018-10-24 20:30:42','2018-10-24 20:30:42','242f0151-9368-4fdf-95ea-41eb2fe67ce1'),(98,98,1,NULL,NULL,1,'2018-10-24 20:36:40','2020-12-21 20:38:19','e4a02742-cf61-4332-8f4c-2be49d0b30ed'),(99,99,1,NULL,NULL,1,'2018-10-26 19:03:53','2018-10-26 19:11:44','024f19fa-d6dd-41a2-a668-78e9e065824d'),(100,100,1,'macrolease','projects/macrolease',1,'2018-10-26 19:08:08','2020-12-28 16:50:35','88e88f9a-9076-4a17-8ff8-211a0012d5c2'),(101,101,1,NULL,NULL,1,'2018-10-26 19:08:08','2020-12-28 16:50:35','b7cace84-7f21-4779-b2b2-378f2a1a5dd1'),(102,102,1,NULL,NULL,1,'2018-10-26 19:12:07','2018-10-26 19:12:21','a20113bf-bf01-4795-a9f5-24d04bbead1a'),(103,103,1,NULL,NULL,1,'2018-10-26 19:37:43','2018-10-26 19:37:43','3ae0662f-eca2-474d-9cd1-112223abb257'),(104,104,1,NULL,NULL,1,'2018-10-26 19:39:17','2018-10-26 19:39:17','7af09c5f-9982-4568-b79e-c362f63df97f'),(105,105,1,NULL,NULL,1,'2018-10-26 19:39:18','2018-10-26 19:39:18','49d9e66e-e30f-48e3-b67c-22c309bd4ad5'),(106,106,1,NULL,NULL,1,'2018-10-26 19:41:28','2020-12-28 16:50:35','8e02ce7b-eca7-43dc-9784-b318bfad40ea'),(107,107,1,NULL,NULL,1,'2018-10-26 22:33:19','2020-12-21 20:37:50','6698688b-764a-453e-8452-b41571982f09'),(108,108,1,NULL,NULL,1,'2018-11-02 04:41:37','2018-11-02 04:41:37','ec4c9b95-e3b5-4b80-ab2b-1014f0d58917'),(109,109,1,'leo-flander','entity/leo-flander',1,'2020-06-25 02:12:45','2020-06-25 02:15:18','feefd6df-371e-40d4-bb3a-b9d14f217497'),(110,110,1,NULL,NULL,1,'2020-06-25 02:15:16','2020-06-25 02:15:16','6399dace-fd33-430b-92f4-66cf6931f4b1'),(111,111,1,'portraits-for-change','projects/portraits-for-change',1,'2020-06-25 02:15:33','2020-12-28 16:46:23','e221dfa7-1317-4ffa-9a71-9da1987d481a'),(112,112,1,NULL,NULL,1,'2020-06-25 02:15:33','2020-12-28 16:46:23','018e0479-dd36-437a-94ba-713af1b9f3e2'),(113,113,1,NULL,NULL,1,'2020-09-22 21:35:29','2020-09-22 21:35:29','8c33eb59-b325-48f9-ad8b-ad7c9014e22c'),(114,114,1,'cicada','projects/cicada',1,'2020-09-22 21:37:06','2020-12-28 20:22:32','177b0b96-2478-42e2-a2b7-4423b6eccbc4'),(115,115,1,NULL,NULL,1,'2020-09-22 21:37:06','2020-12-28 20:22:59','b0b101a3-c65c-4b02-be01-9d07a94bd869'),(116,116,1,NULL,NULL,1,'2020-09-22 21:38:07','2020-09-22 21:38:07','096a7a05-b8b1-4540-bdcc-e49de4d0fe3c'),(117,117,1,NULL,NULL,1,'2020-12-21 20:18:50','2020-12-21 20:18:50','1a80c0f0-b0c4-4356-8454-fce5601a8c5f'),(118,118,1,'idealist-org','projects/idealist-org',1,'2020-12-21 20:24:33','2020-12-28 20:43:18','f472fbad-e6c7-41e1-aabb-ff7837c3be98'),(119,119,1,NULL,NULL,1,'2020-12-21 20:24:33','2020-12-28 20:43:18','88b68d1a-d77d-471e-93ff-3bf9e167e48b'),(120,120,1,'product-design','project-category/product-design',1,'2020-12-21 20:29:07','2020-12-28 15:54:19','92f3acd6-0d23-422b-af70-cf51726d03f8'),(121,121,1,NULL,NULL,1,'2020-12-23 14:43:40','2020-12-23 14:43:40','ffb69aa7-a2aa-4012-9ca3-3336dd7a7a1e'),(122,122,1,'ux-design','project-category/ux-design',1,'2020-12-28 16:49:09','2020-12-28 16:49:40','f93d068d-9087-4191-8a3b-a6c08cdbc5c6'),(123,123,1,'idealist-org','projects/idealist-org',1,'2021-01-03 00:36:15','2021-01-03 00:36:15','af23e5e3-b13b-4210-b0e1-edd7c9d9c6f2'),(124,124,1,NULL,NULL,1,'2021-01-03 00:36:15','2021-01-03 00:36:15','72d91be1-9a79-4feb-938a-c09b1b0dd053'),(125,125,1,'cicada','projects/cicada',1,'2021-01-03 00:36:32','2021-01-03 00:36:32','e74bb901-aefe-495f-aa71-d282560a652d'),(126,126,1,NULL,NULL,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','0fb3c020-7a22-4969-bce2-e0b008a074f9'),(127,127,1,'womens-health-week','projects/womens-health-week',1,'2021-01-03 00:36:32','2021-01-03 00:36:32','f061c65a-e039-44ac-bd1f-2e6741be58a7'),(128,128,1,NULL,NULL,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','f87380f2-c8a1-45df-9814-a0af6375e101'),(129,129,1,NULL,NULL,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','397d8458-90e9-476b-b583-252af896c2cf'),(130,130,1,'macrolease','projects/macrolease',1,'2021-01-03 00:36:32','2021-01-03 00:36:32','bef2c340-4071-4adc-83f2-361a0422d74f'),(131,131,1,NULL,NULL,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','16ed977b-97a0-442d-b1fc-fdb1c42db79c'),(132,132,1,NULL,NULL,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','8c45ca48-93bf-497a-977f-8dd02e38c5c6'),(133,133,1,'portraits-for-change','projects/portraits-for-change',1,'2021-01-03 00:36:32','2021-01-03 00:36:32','7f358e65-0d70-44b3-b515-92e0a41f6686'),(134,134,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','acb6e4c6-b7b8-442d-b508-6fe5ef6ffd8b'),(135,135,1,'will-makes-things','projects/will-makes-things',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','5f9e57c6-08f5-4776-8bbc-d68ee46c811d'),(136,136,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','0ee2de0d-b0ba-47f8-88fd-dfac2bc5b1bb'),(137,137,1,'change-it-ourselves','projects/change-it-ourselves',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','cb894267-ab6f-44b2-bcdb-66940dd62db8'),(138,138,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','f7659615-7a5d-43b4-ab48-d516f2a49d57'),(139,139,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','25204d8a-2e54-4cf5-82c1-c233bd94ba70'),(140,140,1,'other-work','projects/other-work',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','0e60d7d4-3968-4b88-a1e9-6ba0f02d60cc'),(141,141,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','c4a9dd0e-827b-4cf6-831e-261dc50923b6'),(142,142,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','2d508d89-6c0e-410a-9716-1be44fe2fdb2'),(143,143,1,'uxmas','projects/uxmas',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','8305439e-18f4-4465-8e90-151fb75d5ade'),(144,144,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','1dc700bd-23ec-4746-bc7d-b1da7eec1dad'),(145,145,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','0801f891-10a2-427f-a905-29fec01833a2'),(146,146,1,'cengage-ecollection','projects/cengage-ecollection',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','9ca408b2-de61-4997-945e-24b454ce31c5'),(147,147,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','19f8c5e2-3d43-402a-90ef-e1fbf766cac2'),(148,148,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','64e0d9fb-7fda-419c-9c5b-d44ae122dca2'),(149,149,1,'halls-taekwondo','projects/halls-taekwondo',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','b17009be-b5f7-414f-bf70-143609d97d2b'),(150,150,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','e0bdef8f-b093-4ff3-b7d6-c284c94f9688'),(151,151,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','ae410736-3be6-4ec2-bd9b-49d7f9653011'),(152,152,1,'the-man-test','projects/the-man-test',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','8a1bec7b-4a19-4670-87d5-dcb00794c02c'),(153,153,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','8a131bca-d9bd-490f-acba-5de5ac8989b8'),(154,154,1,NULL,NULL,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','78360c49-4f2f-4b60-93a4-d078328cbc50'),(155,155,1,'food-blog','projects/food-blog',1,'2021-01-03 00:36:33','2021-01-03 00:36:33','8a801aee-ce46-4e8e-8bca-f121c0c4d4e7'),(156,156,1,NULL,NULL,1,'2021-01-03 00:36:34','2021-01-03 00:36:34','2b4159f7-630d-418b-91bf-19c365aeda9e');
/*!40000 ALTER TABLE `craft_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entries` VALUES (2,1,NULL,1,1,'2018-08-29 23:19:00',NULL,NULL,'2018-08-29 23:19:39','2020-12-21 20:42:35','745f9c26-2699-4ceb-afa6-f4754d681497'),(15,1,NULL,1,1,'2018-08-29 23:36:00',NULL,NULL,'2018-08-29 23:36:02','2018-10-24 19:33:39','d0ae1dbe-3b26-4cc2-988b-10c4927d2fcd'),(18,1,NULL,1,1,'2018-08-29 23:38:00',NULL,NULL,'2018-08-29 23:38:11','2018-10-24 20:20:29','831bfce3-356a-4344-a666-9da8908de98f'),(21,1,NULL,1,1,'2018-08-29 23:39:00',NULL,NULL,'2018-08-29 23:39:20','2020-12-28 16:50:56','76ad2337-0186-45c3-bf0e-6273e64cb8d3'),(27,1,NULL,1,1,'2018-08-30 02:20:00',NULL,NULL,'2018-08-30 02:20:00','2018-10-24 20:30:42','ae9b0b2b-dacf-43d0-9268-18b95436ca0c'),(30,1,NULL,1,1,'2018-08-30 02:21:00',NULL,NULL,'2018-08-30 02:21:20','2018-11-15 19:29:56','a9fd94b4-6db6-4436-8376-8b59522dec8d'),(34,1,NULL,1,1,'2018-08-30 02:22:00',NULL,NULL,'2018-08-30 02:22:43','2020-12-21 20:38:19','de082559-7a05-47e2-bc17-2879bb0011e9'),(36,1,NULL,1,1,'2018-08-30 02:23:00',NULL,NULL,'2018-08-30 02:23:35','2020-12-21 20:37:50','a6fafa89-e82a-4b20-9a30-fd1ec8bbafd5'),(45,1,NULL,1,1,'2018-08-30 23:58:00',NULL,NULL,'2018-08-30 23:46:13','2018-10-19 19:09:37','d68b1064-d232-492a-a0eb-10ec908df8e8'),(100,1,NULL,1,1,'2018-10-26 19:08:00',NULL,NULL,'2018-10-26 19:08:08','2020-12-28 16:50:35','d7bd89c4-6a94-4b36-8ac9-3ab815746e22'),(111,1,NULL,1,1,'2020-06-25 02:15:00',NULL,NULL,'2020-06-25 02:15:33','2020-12-28 16:46:23','8a3fcc1b-9de6-431a-8ca8-233a47a282eb'),(114,1,NULL,1,1,'2020-09-22 21:37:00',NULL,NULL,'2020-09-22 21:37:06','2020-12-28 20:22:59','9baf5007-a746-446b-ab52-4ed85ec8055a'),(118,1,NULL,1,1,'2020-12-21 20:24:00',NULL,NULL,'2020-12-21 20:24:33','2020-12-28 20:43:18','10d3c8dd-7ce5-4006-9f6d-16deea3ccb23'),(123,1,NULL,1,1,'2020-12-21 20:24:00',NULL,NULL,'2021-01-03 00:36:15','2021-01-03 00:36:15','65f657be-90f6-47c8-a592-c140a8866eb8'),(125,1,NULL,1,1,'2020-09-22 21:37:00',NULL,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','7e75de93-bbad-4f6d-9f54-94400b6892fb'),(127,1,NULL,1,1,'2018-08-29 23:39:00',NULL,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','e9919c05-6b89-42b8-b62d-a625f5fe983a'),(130,1,NULL,1,1,'2018-10-26 19:08:00',NULL,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','9c65d2dd-15c1-4221-bd65-8cbd7a3df228'),(133,1,NULL,1,1,'2020-06-25 02:15:00',NULL,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','ed6d40db-4120-4f59-aead-d6bb37db68f8'),(135,1,NULL,1,1,'2018-08-29 23:19:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','aefe55b4-f22b-4a39-b0e0-78b876e05285'),(137,1,NULL,1,1,'2018-08-30 02:22:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','72a0a931-bfd8-491e-aedf-169c4f6e6f08'),(140,1,NULL,1,1,'2018-08-30 02:23:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','00fc2de0-dbc7-4c42-a26d-f1b561352ad5'),(143,1,NULL,1,1,'2018-08-30 02:21:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','25d0abb1-1b71-44f8-924f-2781c6ad587b'),(146,1,NULL,1,1,'2018-08-30 02:20:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','178b5000-5c07-41a3-86f2-4a6ced26b03f'),(149,1,NULL,1,1,'2018-08-29 23:38:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','825a4e83-d447-4632-beb6-b3944eeeee72'),(152,1,NULL,1,1,'2018-08-29 23:36:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','9a27fccd-a399-468d-85ae-43dc1962ac60'),(155,1,NULL,1,1,'2018-08-30 23:58:00',NULL,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','4c8a4905-1153-4393-b41f-848ba5efb9f2');
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafterrors`
--

LOCK TABLES `craft_entrydrafterrors` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafterrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafterrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entrytypes` VALUES (1,1,7,'Projects','projects',1,'site',NULL,NULL,1,'2018-08-29 23:17:50','2018-10-19 19:09:34',NULL,'30e4ec7e-c20c-406b-9d25-8bd28cbccb62');
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversionerrors`
--

LOCK TABLES `craft_entryversionerrors` WRITE;
/*!40000 ALTER TABLE `craft_entryversionerrors` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entryversionerrors` VALUES (1,89,'Could not acquire a lock to save a revision for element 114'),(2,88,'Could not acquire a lock to save a revision for element 118'),(3,86,'Could not acquire a lock to save a revision for element 111'),(4,85,'Could not acquire a lock to save a revision for element 100'),(5,84,'Could not acquire a lock to save a revision for element 118'),(6,82,'Could not acquire a lock to save a revision for element 21'),(7,80,'Could not acquire a lock to save a revision for element 111'),(8,79,'Could not acquire a lock to save a revision for element 118'),(9,78,'Could not acquire a lock to save a revision for element 118'),(10,77,'Could not acquire a lock to save a revision for element 114'),(11,76,'Could not acquire a lock to save a revision for element 100'),(12,75,'Could not acquire a lock to save a revision for element 111'),(13,73,'Could not acquire a lock to save a revision for element 114'),(14,72,'Could not acquire a lock to save a revision for element 114'),(15,71,'Could not acquire a lock to save a revision for element 111'),(16,70,'Could not acquire a lock to save a revision for element 111'),(17,69,'Could not acquire a lock to save a revision for element 111'),(18,68,'Could not acquire a lock to save a revision for element 100'),(19,66,'Could not acquire a lock to save a revision for element 100'),(20,65,'Could not acquire a lock to save a revision for element 100'),(21,64,'Could not acquire a lock to save a revision for element 100'),(22,63,'Could not acquire a lock to save a revision for element 100'),(23,62,'Could not acquire a lock to save a revision for element 36'),(24,61,'Could not acquire a lock to save a revision for element 36'),(25,60,'Could not acquire a lock to save a revision for element 36'),(26,59,'Could not acquire a lock to save a revision for element 100'),(27,58,'Could not acquire a lock to save a revision for element 100'),(28,57,'Could not acquire a lock to save a revision for element 2'),(29,56,'Could not acquire a lock to save a revision for element 100'),(30,55,'Could not acquire a lock to save a revision for element 100'),(31,54,'Could not acquire a lock to save a revision for element 100'),(32,53,'Could not acquire a lock to save a revision for element 2'),(33,52,'Could not acquire a lock to save a revision for element 2'),(34,51,'Could not acquire a lock to save a revision for element 34'),(35,49,'Could not acquire a lock to save a revision for element 21'),(36,47,'Could not acquire a lock to save a revision for element 30'),(37,46,'Could not acquire a lock to save a revision for element 30'),(38,45,'Could not acquire a lock to save a revision for element 30'),(39,44,'Could not acquire a lock to save a revision for element 30'),(40,43,'Could not acquire a lock to save a revision for element 30'),(41,42,'Could not acquire a lock to save a revision for element 30'),(42,40,'Could not acquire a lock to save a revision for element 15'),(43,39,'Could not acquire a lock to save a revision for element 36'),(44,38,'Could not acquire a lock to save a revision for element 2'),(45,37,'Could not acquire a lock to save a revision for element 30'),(46,36,'Could not acquire a lock to save a revision for element 30'),(47,35,'Could not acquire a lock to save a revision for element 15'),(48,34,'Could not acquire a lock to save a revision for element 15'),(49,33,'Could not acquire a lock to save a revision for element 15'),(50,32,'Could not acquire a lock to save a revision for element 2'),(51,31,'Could not acquire a lock to save a revision for element 2'),(52,30,'Could not acquire a lock to save a revision for element 36'),(53,29,'Could not acquire a lock to save a revision for element 34'),(54,28,'Could not acquire a lock to save a revision for element 30'),(55,27,'Could not acquire a lock to save a revision for element 27'),(56,26,'Could not acquire a lock to save a revision for element 21'),(57,25,'Could not acquire a lock to save a revision for element 18'),(58,24,'Could not acquire a lock to save a revision for element 15'),(59,22,'Could not acquire a lock to save a revision for element 45'),(60,21,'Could not acquire a lock to save a revision for element 45'),(61,20,'Could not acquire a lock to save a revision for element 45'),(62,19,'Could not acquire a lock to save a revision for element 45'),(63,18,'Could not acquire a lock to save a revision for element 45'),(64,17,'Could not acquire a lock to save a revision for element 36'),(65,16,'Could not acquire a lock to save a revision for element 34'),(66,15,'Could not acquire a lock to save a revision for element 30'),(67,14,'Could not acquire a lock to save a revision for element 27'),(68,13,'Could not acquire a lock to save a revision for element 36'),(69,12,'Could not acquire a lock to save a revision for element 34'),(70,11,'Could not acquire a lock to save a revision for element 30'),(71,10,'Could not acquire a lock to save a revision for element 27'),(72,9,'Could not acquire a lock to save a revision for element 18'),(73,8,'Could not acquire a lock to save a revision for element 15'),(74,7,'Could not acquire a lock to save a revision for element 21'),(75,6,'Could not acquire a lock to save a revision for element 21'),(76,5,'Could not acquire a lock to save a revision for element 18'),(77,4,'Could not acquire a lock to save a revision for element 15'),(78,3,'Could not acquire a lock to save a revision for element 2'),(79,2,'Could not acquire a lock to save a revision for element 2'),(80,1,'Could not acquire a lock to save a revision for element 2');
/*!40000 ALTER TABLE `craft_entryversionerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entryversions` VALUES (1,2,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"3\":[],\"6\":[],\"9\":[],\"11\":[],\"12\":[],\"15\":[]}}','2018-08-29 23:19:39','2018-08-29 23:19:39','87eceaf8-8f41-4514-a633-0ba013101e7e'),(2,2,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#9822ff\"},{\"col1\":\"80\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"9\":[],\"11\":[],\"12\":[],\"15\":[]}}','2018-08-29 23:28:35','2018-08-29 23:28:35','8a554a6e-6097-4356-9929-050d7f5df517'),(3,2,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#9822ff\"},{\"col1\":\"80\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"9\":[],\"11\":[\"5\",\"6\",\"7\",\"8\",\"10\",\"12\"],\"12\":[],\"15\":[]}}','2018-08-29 23:33:03','2018-08-29 23:33:03','17091e21-8041-43b3-96f1-e11ccfb40a34'),(4,15,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The Man Test\",\"slug\":\"the-man-test\",\"postDate\":1535585760,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"16\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"30deg\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]}}},\"6\":[\"13\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[],\"16\":\"http://mantest.com.au/\"}}','2018-08-29 23:36:02','2018-08-29 23:36:02','a5fd6955-28a3-4fe2-976e-a6fe184ca582'),(5,18,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Hall\'s Taekwondo\",\"slug\":\"halls-taekwondo\",\"postDate\":1535585880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"19\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff0062\"},{\"col1\":\"80\",\"col2\":\"#ff7900\"}]}}},\"6\":[\"17\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[],\"16\":\"https://hallstaekwondo.com.au\"}}','2018-08-29 23:38:11','2018-08-29 23:38:11','ec285d2e-97ed-43e7-9537-6de99dcc257d'),(6,21,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Women\'s Health Week\",\"slug\":\"womens-health-week\",\"postDate\":1535585940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"22\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"67deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#7000c6\"},{\"col1\":\"80\",\"col2\":\"#ff2eb9\"}]}}},\"6\":[\"20\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"https://www.womenshealthweek.com.au/\"}}','2018-08-29 23:39:20','2018-08-29 23:39:20','9c609c8e-1ba7-4423-80ee-bb642f4c7d14'),(7,21,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Women\'s Health Week\",\"slug\":\"womens-health-week\",\"postDate\":1535585940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"22\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"67deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#7000c6\"},{\"col1\":\"80\",\"col2\":\"#ff2eb9\"}]}}},\"6\":[\"20\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[\"24\"],\"16\":\"https://www.womenshealthweek.com.au/\"}}','2018-08-29 23:59:51','2018-08-29 23:59:51','bc03c99d-a8df-47fd-93c1-f4ddf08c5542'),(8,15,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The Man Test\",\"slug\":\"the-man-test\",\"postDate\":1535585760,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"16\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"30deg\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]}}},\"6\":[\"13\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"23\"],\"16\":\"http://mantest.com.au/\"}}','2018-08-30 00:00:02','2018-08-30 00:00:02','97557a77-dc02-4b0c-8cdd-80c91df58588'),(9,18,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Hall\'s Taekwondo\",\"slug\":\"halls-taekwondo\",\"postDate\":1535585880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"19\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff0062\"},{\"col1\":\"80\",\"col2\":\"#ff7900\"}]}}},\"6\":[\"17\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"25\"],\"16\":\"https://hallstaekwondo.com.au\"}}','2018-08-30 00:00:12','2018-08-30 00:00:12','af36b258-2235-449f-b23b-e171a39f391d'),(10,27,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Cengage eCollection\",\"slug\":\"cengage-ecollection\",\"postDate\":1535595600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"28\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"0deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#00d4a2\"},{\"col1\":\"50\",\"col2\":\"#8d81ff\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]}}},\"6\":[\"26\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[],\"16\":\"https://app.pmecollection.com.au/\"}}','2018-08-30 02:20:00','2018-08-30 02:20:00','f8751a8f-570b-4dd9-a21a-75a8ab281e49'),(11,30,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[],\"16\":\"http://uxmas.com/\"}}','2018-08-30 02:21:20','2018-08-30 02:21:20','668cf2b7-70d4-4113-abcf-a32e6d2f39f3'),(12,34,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Change It Ourselves\",\"slug\":\"change-it-ourselves\",\"postDate\":1535595720,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"33\"],\"3\":[],\"6\":[\"32\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[],\"16\":\"http://changeitourselves.com.au/change-the-date\"}}','2018-08-30 02:22:43','2018-08-30 02:22:43','a1699d10-c2d7-4b94-a381-2e4699391a78'),(13,36,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Other Work\",\"slug\":\"other-work\",\"postDate\":1535595780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"3\":{\"37\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"10deg\",\"stops\":[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]}}},\"6\":[\"35\"],\"9\":[],\"11\":[\"7\",\"8\",\"10\"],\"12\":[],\"15\":[],\"16\":\"https://www.behance.net/wfifer\"}}','2018-08-30 02:23:35','2018-08-30 02:23:35','ca4ef5bc-2e2a-4b6b-bb29-b08a32248f1f'),(14,27,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Cengage eCollection\",\"slug\":\"cengage-ecollection\",\"postDate\":1535595600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"28\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"0deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#00d4a2\"},{\"col1\":\"50\",\"col2\":\"#8d81ff\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]}}},\"6\":[\"26\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"38\"],\"16\":\"https://app.pmecollection.com.au/\"}}','2018-08-30 02:27:40','2018-08-30 02:27:40','b2192668-9d5a-47e2-a3de-52ef9f7f78d3'),(15,30,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"14\"],\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-08-30 02:27:46','2018-08-30 02:27:46','db17d2c7-7d87-44eb-86a6-d1b09f2d9848'),(16,34,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Change It Ourselves\",\"slug\":\"change-it-ourselves\",\"postDate\":1535595720,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"33\"],\"3\":{\"42\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"45deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9e15\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]}}},\"6\":[\"32\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"39\"],\"16\":\"http://changeitourselves.com.au/change-the-date\"}}','2018-08-30 02:28:25','2018-08-30 02:28:25','a8c7df9f-fa04-47ae-9bc0-747d8e076af6'),(17,36,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Other Work\",\"slug\":\"other-work\",\"postDate\":1535595780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"3\":{\"37\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"10deg\",\"stops\":[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]}}},\"6\":[\"35\"],\"9\":[],\"11\":[\"7\",\"8\",\"10\"],\"12\":[],\"15\":[\"40\"],\"16\":\"https://www.behance.net/wfifer\"}}','2018-08-30 02:28:37','2018-08-30 02:28:37','c6dca637-a450-4a89-86fd-980e0dd6ec4a'),(18,45,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Food Blog\",\"slug\":\"food-blog\",\"postDate\":null,\"expiryDate\":null,\"enabled\":false,\"newParentId\":null,\"fields\":{\"1\":[],\"17\":false,\"3\":{\"46\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"48deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9000\"},{\"col1\":\"80\",\"col2\":\"#ff0036\"}]}}},\"6\":[\"44\"],\"9\":[],\"11\":[\"12\"],\"12\":[],\"15\":[\"43\"]}}','2018-08-30 23:46:13','2018-08-30 23:46:13','e96d12f4-dc14-40db-80a0-bacbb59177e5'),(19,45,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Food Blog\",\"slug\":\"food-blog\",\"postDate\":1535673480,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"17\":false,\"3\":{\"46\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"48deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9000\"},{\"col1\":\"80\",\"col2\":\"#ff0036\"}]}}},\"6\":[\"44\"],\"9\":[],\"11\":[\"12\"],\"12\":[],\"15\":[\"43\"]}}','2018-08-30 23:58:02','2018-08-30 23:58:02','d1238d0e-4a77-4e3a-bdb6-cac69abac24b'),(20,45,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Food Blog\",\"slug\":\"food-blog\",\"postDate\":1535673480,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"17\":false,\"3\":{\"46\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"48deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9000\"},{\"col1\":\"80\",\"col2\":\"#ff0036\"}]}}},\"6\":[\"44\"],\"9\":[],\"11\":[\"12\"],\"12\":[],\"15\":[\"44\"]}}','2018-08-31 00:00:51','2018-08-31 00:00:51','ac71a1e9-873d-4c1d-9cb3-2ccefa91b007'),(21,45,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Food Blog\",\"slug\":\"food-blog\",\"postDate\":1535673480,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"17\":false,\"3\":{\"46\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"48deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9000\"},{\"col1\":\"80\",\"col2\":\"#ff0036\"}]}}},\"6\":[\"48\"],\"9\":[],\"11\":[\"12\"],\"12\":[],\"15\":[\"47\"]}}','2018-08-31 00:04:04','2018-08-31 00:04:04','c1ec76e7-b9de-4893-a3d1-4b1bbe1bd0b9'),(22,45,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The World Needs Another Food Blog\",\"slug\":\"food-blog\",\"postDate\":1535673480,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[],\"17\":false,\"3\":{\"46\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"48deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9000\"},{\"col1\":\"80\",\"col2\":\"#ff0036\"}]}}},\"6\":[\"48\"],\"9\":[],\"11\":[\"12\"],\"12\":[],\"15\":[\"47\"]}}','2018-08-31 01:44:30','2018-08-31 01:44:30','0875acb5-9702-4d34-aad1-4283fa323253'),(24,15,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The Man Test\",\"slug\":\"the-man-test\",\"postDate\":1535585760,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"53\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"16\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"30deg\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]}}},\"6\":[\"13\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"23\"],\"16\":\"http://mantest.com.au/\"}}','2018-10-19 19:09:57','2018-10-19 19:09:57','148721f6-be14-4524-82df-477cb4839421'),(25,18,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Hall\'s Taekwondo\",\"slug\":\"halls-taekwondo\",\"postDate\":1535585880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"56\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"19\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff0062\"},{\"col1\":\"80\",\"col2\":\"#ff7900\"}]}}},\"6\":[\"17\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"25\"],\"16\":\"https://hallstaekwondo.com.au\"}}','2018-10-19 19:10:08','2018-10-19 19:10:08','52666acf-8ad0-4652-9626-340e8ce9b796'),(26,21,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Women\'s Health Week\",\"slug\":\"womens-health-week\",\"postDate\":1535585940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"54\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"22\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"67deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#7000c6\"},{\"col1\":\"80\",\"col2\":\"#ff2eb9\"}]}}},\"6\":[\"20\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[\"24\"],\"16\":\"https://www.womenshealthweek.com.au/\"}}','2018-10-19 19:10:26','2018-10-19 19:10:26','400d0395-031b-4dcf-a6f0-e905d632bef1'),(27,27,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Cengage eCollection\",\"slug\":\"cengage-ecollection\",\"postDate\":1535595600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"52\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"28\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"0deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#00d4a2\"},{\"col1\":\"50\",\"col2\":\"#8d81ff\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]}}},\"6\":[\"26\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"38\"],\"16\":\"https://app.pmecollection.com.au/\"}}','2018-10-19 19:10:37','2018-10-19 19:10:37','6d8017a9-4358-460a-8df8-46988c35a10e'),(28,30,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-19 19:10:49','2018-10-19 19:10:49','c78cdb66-ed7b-4c03-b15c-25e251b5790e'),(29,34,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Change It Ourselves\",\"slug\":\"change-it-ourselves\",\"postDate\":1535595720,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"33\"],\"1\":[\"33\"],\"17\":true,\"3\":{\"42\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"45deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9e15\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]}}},\"6\":[\"32\"],\"9\":[],\"11\":[\"5\"],\"12\":[],\"15\":[\"39\"],\"16\":\"http://changeitourselves.com.au/change-the-date\"}}','2018-10-19 19:10:59','2018-10-19 19:10:59','b0620fb3-4801-48f0-a23a-a36ded1cdfe2'),(30,36,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Other Work\",\"slug\":\"other-work\",\"postDate\":1535595780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"57\"],\"1\":[],\"17\":true,\"3\":{\"37\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"10deg\",\"stops\":[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]}}},\"6\":[\"35\"],\"9\":[],\"11\":[\"7\",\"8\",\"10\"],\"12\":[],\"15\":[\"40\"],\"16\":\"https://www.behance.net/wfifer\"}}','2018-10-19 19:11:41','2018-10-19 19:11:41','0102080c-cadc-44c0-b109-9f0795bdd436'),(31,2,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#9822ff\"},{\"col1\":\"80\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"8\":\"<p>Oh. Hi. I\'m Will Fifer (of willfifer.com fame). I\'m a designer, developer and aspiring pun-laden food truck owner. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. Ultimately, whatever hat I\'m wearing, I\'m a visual problem solver—all that changes is the tool.</p><p>Sound good? <a href=\\\"mailto:wfifer@gmail.com\\\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it. </p>\",\"9\":[],\"11\":[\"5\",\"6\",\"7\",\"8\",\"10\",\"12\"],\"12\":[],\"15\":[]}}','2018-10-19 22:14:44','2018-10-19 22:14:44','3f0dc9de-37e4-4ad5-af5c-9efb62de5ea4'),(32,2,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#9822ff\"},{\"col1\":\"80\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"8\":\"<p>Oh, hi. I\'m Will Fifer. I\'m a designer, developer, and whatever else I need to be to get the job done. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. My tools often change, but the goal remains the same: identifying and solving problems. </p>\\n<p>Sound good? <a href=\\\"mailto:wfifer@gmail.com\\\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it.</p><p>Looking to Angel-invest in a concept store or food truck based purely on its pun-tastic name? Let\'s grab a beer. </p>\",\"9\":[],\"11\":[\"5\",\"6\",\"7\",\"8\",\"10\",\"12\"],\"12\":[],\"15\":[]}}','2018-10-23 21:26:32','2018-10-23 21:26:32','d8f97f31-1dde-497a-886e-d9fa36f9e733'),(33,15,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The Man Test\",\"slug\":\"the-man-test\",\"postDate\":1535585760,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"53\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"16\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"30deg\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]}}},\"6\":[\"13\"],\"9\":{\"67\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><img src=\\\"{asset:59:url}\\\" alt=\\\"\\\" /></figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"23\"],\"16\":\"http://mantest.com.au/\"}}','2018-10-23 22:41:05','2018-10-23 22:41:05','f7252128-b181-4558-8995-9bd3cac66318'),(34,15,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The Man Test\",\"slug\":\"the-man-test\",\"postDate\":1535585760,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"53\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"16\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"30deg\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]}}},\"6\":[\"13\"],\"9\":{\"67\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><img src=\\\"{asset:73:url}\\\" alt=\\\"\\\" /></figure><p></p>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"23\"],\"16\":\"http://mantest.com.au/\"}}','2018-10-23 23:14:44','2018-10-23 23:14:44','cf9e6782-fad4-45a1-bf2c-f0ceeef20ef7'),(35,15,1,1,1,6,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The Man Test\",\"slug\":\"the-man-test\",\"postDate\":1535585760,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"53\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"16\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"30deg\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]}}},\"6\":[\"13\"],\"9\":{\"67\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><img src=\\\"{asset:89:url}\\\" alt=\\\"\\\" /></figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"23\"],\"16\":\"http://mantest.com.au/\"}}','2018-10-24 03:06:28','2018-10-24 03:06:28','40e9b452-1a87-4246-8f0c-6d407438fec6'),(36,30,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><img src=\\\"{asset:90:transform:wysiwyg}\\\" alt=\\\"\\\" /></figure><p></p>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 04:03:16','2018-10-24 04:03:16','0d5e57bf-e9c6-4b73-9148-a3b6d50fd038'),(37,30,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"{asset:90:transform:wysiwyg}\\\" alt=\\\"\\\" /></a><figcaption>The UXMas advent calendar</figcaption></figure><p></p>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 05:25:10','2018-10-24 05:25:10','2eec4975-0230-403c-9556-3a5bd150d3d4'),(38,2,1,1,1,6,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#9822ff\"},{\"col1\":\"80\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"8\":\"<p>I\'m Will Fifer. I\'m a designer, developer, and whatever else gets the job done. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. The tools often change, but the goal remains the same: identifying and solving problems. </p>\\n<p><a href=\\\"mailto:wfifer@gmail.com\\\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it.</p>\\n<p>Looking to Angel-invest in a concept store or food truck based purely on its pun-tastic name? Let\'s grab a beer. </p>\",\"9\":[],\"11\":[\"5\",\"6\",\"7\",\"8\",\"10\",\"12\"],\"12\":[],\"15\":[]}}','2018-10-24 06:06:32','2018-10-24 06:06:32','30670ff2-4e44-4f89-b96e-e74c24a23f05'),(39,36,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Other Work\",\"slug\":\"other-work\",\"postDate\":1535595780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"37\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"10deg\",\"stops\":[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]}}},\"6\":[\"35\"],\"9\":[],\"11\":[\"7\",\"8\",\"10\"],\"12\":[],\"15\":[\"40\"],\"16\":\"https://www.behance.net/wfifer\"}}','2018-10-24 07:03:09','2018-10-24 07:03:09','c2475e29-6acc-48d6-9fe4-13db66a1ddc6'),(40,15,1,1,1,7,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"The Man Test\",\"slug\":\"the-man-test\",\"postDate\":1535585760,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"53\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"16\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"30deg\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]}}},\"6\":[\"13\"],\"8\":\"<p>\\\"Significant health problems such as high blood pressure, type 2 diabetes, heart disease, prostate cancer, testicular cancer, infertility, colon cancer and depression, could be detected and treated more effectively if men’s awareness of these problems was greater. By taking control of your own health, you can catch small issues before they become big problems.\\\"</p>\\n\",\"9\":{\"67\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><img src=\\\"{asset:89:url}\\\" alt=\\\"\\\" /></figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"23\"],\"16\":\"http://mantest.com.au/\"}}','2018-10-24 19:19:07','2018-10-24 19:19:07','af88545a-e000-47c9-b0c1-0eb1874cc776'),(42,30,1,1,1,6,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"{asset:90:transform:wysiwyg}\\\" alt=\\\"\\\" /></a><figcaption>The UXMas advent calendar</figcaption></figure><figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"http://api.willfifer.com/assets/img/uxmas-scene.gif\\\" alt=\\\"\\\" /></a><figcaption>25 days of UXMas</figcaption></figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 19:38:29','2018-10-24 19:38:29','63bdf230-c5c1-4be3-ae57-c3af37e5eaf7'),(43,30,1,1,1,7,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"{asset:90:transform:wysiwyg}\\\" alt=\\\"\\\" /></a><figcaption>The UXMas advent calendar</figcaption></figure><figure><figcaption>25 days of UXMas</figcaption></figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 19:44:17','2018-10-24 19:44:17','51111a47-db7c-401c-a5be-35318edc6bcd'),(44,30,1,1,1,8,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"{asset:90:transform:wysiwyg}\\\" data-image=\\\"unhphfeu8xap\\\"></a><figcaption>The UXMas advent calendar</figcaption></figure>\\r\\n<figure>\\r\\n    <video autoplay loop muted playsinline>\\r\\n        <source type=\\\"video/mp4\\\" src=\\\"/assets/video/uxmas.mp4\\\">\\r\\n        <source type=\\\"video/webm\\\" src=\\\"/assets/video/uxmas.webm\\\">\\r\\n    </video>\\r\\n    <figcaption>25 days of UXMas</figcaption>\\r\\n</figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 19:48:06','2018-10-24 19:48:06','e3250f1a-8665-4651-aac9-1fe063c058bb'),(45,30,1,1,1,9,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"{asset:90:transform:wysiwyg}\\\" data-image=\\\"unhphfeu8xap\\\"></a><figcaption>The UXMas advent calendar</figcaption></figure>\\r\\n<figure>\\r\\n    <iframe src=\\\"https://player.vimeo.com/video/296951046?autoplay=1&loop=1\\\" width=\\\"1080\\\" height=\\\"720\\\" frameborder=\\\"0\\\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>\\r\\n    <figcaption>25 days of UXMas</figcaption>\\r\\n</figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 20:02:19','2018-10-24 20:02:19','6d68cd7f-1b1f-482f-bdec-c44ebc6f8642'),(46,30,1,1,1,10,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"{asset:90:transform:wysiwyg}\\\" data-image=\\\"unhphfeu8xap\\\"></a><figcaption>The UXMas advent calendar</figcaption></figure>\\r\\n<figure>\\r\\n    <div class=\\\"video-container\\\">\\r\\n        <iframe src=\\\"https://player.vimeo.com/video/296951046?autoplay=1&loop=1\\\" width=\\\"1080\\\" height=\\\"720\\\" frameborder=\\\"0\\\" webkitallowfullscreen=\\\"\\\" mozallowfullscreen=\\\"\\\" allowfullscreen=\\\"\\\"></iframe>\\r\\n    </div>\\r\\n    <figcaption>25 days of UXMas</figcaption>\\r\\n</figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 20:04:26','2018-10-24 20:04:26','9526789a-1eef-4b57-84b1-149b81c96b77'),(47,30,1,1,1,11,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"UXMas\",\"slug\":\"uxmas\",\"postDate\":1535595660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"55\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"31\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"75deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]}}},\"6\":[\"29\"],\"9\":{\"93\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://uxmas.com\\\"><img src=\\\"{asset:90:transform:wysiwyg}\\\" data-image=\\\"unhphfeu8xap\\\"></a><figcaption>The UXMas advent calendar</figcaption></figure>\\r\\n<figure>\\r\\n    <div class=\\\"video-container\\\">\\r\\n        <iframe src=\\\"https://player.vimeo.com/video/296951046?autoplay=1&loop=1&muted=1\\\" width=\\\"1080\\\" height=\\\"720\\\" frameborder=\\\"0\\\" webkitallowfullscreen=\\\"\\\" mozallowfullscreen=\\\"\\\" allowfullscreen=\\\"\\\"></iframe>\\r\\n    </div>\\r\\n    <figcaption>25 days of UXMas</figcaption>\\r\\n</figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"41\"],\"16\":\"http://uxmas.com/\"}}','2018-10-24 20:07:05','2018-10-24 20:07:05','194f3f4e-b4f6-4213-9a74-9fad47e96a7c'),(49,21,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Women\'s Health Week\",\"slug\":\"womens-health-week\",\"postDate\":1535585940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"54\"],\"1\":[\"14\"],\"17\":true,\"3\":{\"22\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"67deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#7000c6\"},{\"col1\":\"80\",\"col2\":\"#ff2eb9\"}]}}},\"6\":[\"20\"],\"9\":{\"96\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"https://womenshealthweek.com.au\\\" target=\\\"true\\\"><img src=\\\"{asset:91:transform:wysiwyg}\\\" data-image=\\\"91\\\"></a><figcaption>Successful relaunch of the Womens Health Week site</figcaption></figure>\"}}},\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[\"24\"],\"16\":\"https://www.womenshealthweek.com.au/\"}}','2018-10-24 20:21:52','2018-10-24 20:21:52','98b54c03-1c99-485e-9814-eb0c1312aa8e'),(51,34,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Change It Ourselves\",\"slug\":\"change-it-ourselves\",\"postDate\":1535595720,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"33\"],\"1\":[\"33\"],\"17\":true,\"3\":{\"42\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"45deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ff9e15\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]}}},\"6\":[\"32\"],\"9\":{\"98\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"https://changeitourselves.com.au/take-part\\\" target=\\\"true\\\"><img src=\\\"{asset:84:transform:wysiwyg}\\\" data-image=\\\"84\\\"></a><figcaption>Helpful resources for employers and employees</figcaption></figure>\"}}},\"11\":[\"5\"],\"12\":[],\"15\":[\"39\"],\"16\":\"http://changeitourselves.com.au/\"}}','2018-10-24 20:36:40','2018-10-24 20:36:40','5a812022-ea5c-469e-bf90-f16d49fec34a'),(52,2,1,1,1,7,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#9822ff\"},{\"col1\":\"80\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"8\":\"<p>I\'m Will Fifer: designer, developer, and whatever else gets the job done. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. The tools often change, but the goal remains the same: identifying and solving problems. </p>\\n<p><a href=\\\"mailto:wfifer@gmail.com\\\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it.</p>\\n<p>Looking to Angel-invest in a concept store or food truck based purely on its pun-tastic name? Let\'s grab a beer. </p>\",\"9\":[],\"11\":[\"5\",\"6\",\"7\",\"8\",\"10\",\"12\"],\"12\":[],\"15\":[]}}','2018-10-25 19:43:34','2018-10-25 19:43:34','d56b8605-10ec-49f3-87f1-7421113430d8'),(53,2,1,1,1,8,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#9822ff\"},{\"col1\":\"80\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"8\":\"<p>I\'m Will Fifer: designer, developer, and whatever else gets the job done. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. The tools often change, but the goal remains the same: identifying and solving problems. </p>\\n<p><a href=\\\"mailto:wfifer@gmail.com\\\" target=\\\"_blank\\\" title=\\\"Email me\\\" rel=\\\"noreferrer noopener\\\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it.</p>\\n<p>Looking to Angel-invest in a concept store or food truck based purely on its pun-tastic name? Let\'s grab a beer. </p>\",\"9\":[],\"11\":[\"5\",\"6\",\"7\",\"8\",\"10\",\"12\"],\"12\":[],\"15\":[]}}','2018-10-25 19:48:27','2018-10-25 19:48:27','820d8d8a-6f78-4e02-be1a-aff84c9cfc91'),(54,100,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"10\",\"col2\":\"#9f42ce\"},{\"col1\":\"40\",\"col2\":\"#6866d7\"},{\"col1\":\"95\",\"col2\":\"#00abe9\"}]}}},\"6\":[\"99\"],\"9\":[],\"11\":[],\"12\":[],\"15\":[]}}','2018-10-26 19:08:08','2018-10-26 19:08:08','a77e9ae1-37c7-4d83-940a-34088aed0427'),(55,100,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"10\",\"col2\":\"#9f42ce\"},{\"col1\":\"40\",\"col2\":\"#6866d7\"},{\"col1\":\"95\",\"col2\":\"#00abe9\"}]}}},\"6\":[\"99\"],\"9\":[],\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-10-26 19:13:51','2018-10-26 19:13:51','66357b0b-057c-4a2d-a7f7-384f3ef8096d'),(56,100,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"30\",\"col2\":\"#9f42ce\"},{\"col1\":\"40\",\"col2\":\"#6866d7\"},{\"col1\":\"75\",\"col2\":\"#00abe9\"}]}}},\"6\":[\"99\"],\"9\":[],\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-10-26 19:15:45','2018-10-26 19:15:45','66efbb2a-b489-470e-8bcf-9b2775d91e9c'),(57,2,1,1,1,9,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Will Makes Things\",\"slug\":\"will-makes-things\",\"postDate\":1535584740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"4\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"28deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#9822ff\"},{\"col1\":\"70\",\"col2\":\"#0065ff\"}]}}},\"6\":[\"3\"],\"8\":\"<p>I\'m Will Fifer: designer, developer, and whatever else gets the job done. In an ever more connected world, my aim is digital progress guided by both ethics and empathy. To that end, I draw on my background in engineering and graphic design to craft human-centered products. The tools often change, but the goal remains the same: identifying and solving problems. </p>\\n<p><a href=\\\"mailto:wfifer@gmail.com\\\" target=\\\"_blank\\\" title=\\\"Email me\\\" rel=\\\"noreferrer noopener\\\">Drop me a line.</a> I love working with folks who are doing good and are passionate about it.</p>\\n<p>Looking to Angel-invest in a concept store or food truck based purely on its pun-tastic name? Let\'s grab a beer. </p>\",\"9\":[],\"11\":[\"5\",\"6\",\"7\",\"8\",\"10\",\"12\"],\"12\":[],\"15\":[]}}','2018-10-26 19:16:17','2018-10-26 19:16:17','3fac537d-0c5f-4272-b3e4-1dcbb0701514'),(58,100,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"30\",\"col2\":\"#9f42ce\"},{\"col1\":\"60\",\"col2\":\"#158eff\"},{\"col1\":\"75\",\"col2\":\"00ddff\"}]}}},\"6\":[\"99\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessarily involved consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, and oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure><figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure><figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-10-26 19:41:28','2018-10-26 19:41:28','35018bf1-32a9-418f-ad85-4e495f465b32'),(59,100,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"30\",\"col2\":\"#9f42ce\"},{\"col1\":\"60\",\"col2\":\"#158eff\"},{\"col1\":\"75\",\"col2\":\"#00ddff\"}]}}},\"6\":[\"99\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessarily involved consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, and oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-10-26 19:41:54','2018-10-26 19:41:54','2e80d93a-ac1b-43b9-be59-f8a3cac954c0'),(60,36,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Other Work\",\"slug\":\"other-work\",\"postDate\":1535595780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"37\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"10deg\",\"stops\":[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]}}},\"6\":[\"35\"],\"8\":\"<figure>\\n <figcaption>Jay &amp; Pluto film logo and animation</figcaption></figure>\",\"9\":[],\"11\":[\"7\",\"8\",\"10\"],\"12\":[],\"15\":[\"40\"],\"16\":\"https://www.behance.net/wfifer\"}}','2018-10-26 22:32:26','2018-10-26 22:32:26','759e534d-4511-418f-940b-f3033efaf0d0'),(61,36,1,1,1,6,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Other Work\",\"slug\":\"other-work\",\"postDate\":1535595780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"37\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"10deg\",\"stops\":[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]}}},\"6\":[\"35\"],\"9\":{\"107\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><iframe src=\\\"http://willfifer.com/jay-and-pluto/index.html\\\" frameborder=\\\"0\\\"></iframe><figcaption>Jay & Pluto film logo and animation</figcaption></figure>\"}}},\"11\":[\"7\",\"8\",\"10\"],\"12\":[],\"15\":[\"40\"],\"16\":\"https://www.behance.net/wfifer\"}}','2018-10-26 22:33:19','2018-10-26 22:33:19','41ac6b51-2f3a-4464-8152-71967f8c4e5a'),(62,36,1,1,1,7,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Other Work\",\"slug\":\"other-work\",\"postDate\":1535595780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"37\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"10deg\",\"stops\":[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]}}},\"6\":[\"35\"],\"9\":{\"107\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><div class=\\\"video-container\\\"><iframe src=\\\"http://willfifer.com/jay-and-pluto/index.html\\\" frameborder=\\\"0\\\"></iframe></div><figcaption>Jay & Pluto film logo and animation</figcaption></figure>\"}}},\"11\":[\"7\",\"8\",\"10\"],\"12\":[],\"15\":[\"40\"],\"16\":\"https://www.behance.net/wfifer\"}}','2018-10-26 22:34:18','2018-10-26 22:34:18','258498ac-c94e-4418-96c1-3021212a565e'),(63,100,1,1,1,6,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"30\",\"col2\":\"#9f42ce\"},{\"col1\":\"80\",\"col2\":\"#158eff\"}]}}},\"6\":[\"99\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessarily involved consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, and oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-11-02 04:35:15','2018-11-02 04:35:15','d33c6190-8323-4a4d-9fca-8018cabecea9'),(64,100,1,1,1,7,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"30\",\"col2\":\"#ff5e00\"},{\"col1\":\"80\",\"col2\":\"#ff6ade\"}]}}},\"6\":[\"99\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessarily involved consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, and oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-11-02 04:37:25','2018-11-02 04:37:25','85934aa8-4995-4015-8d3b-9de52a383e51'),(65,100,1,1,1,8,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"38\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#3ee4c0\"},{\"col1\":\"90\",\"col2\":\"#0045de\"}]}}},\"6\":[\"108\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessarily involved consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, and oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-11-02 04:41:39','2018-11-02 04:41:39','5136da6c-2fa3-49c0-b959-ffd5179507f5'),(66,100,1,1,1,9,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"38\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#3ee4c0\"},{\"col1\":\"90\",\"col2\":\"#0045de\"}]}}},\"6\":[\"108\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessitated consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, an oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"http://s-macrolease.willfifer.com\"}}','2018-11-14 16:22:59','2018-11-14 16:22:59','582c1c8f-c1b5-430d-a584-9366d727ff81'),(68,100,1,1,1,10,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"38\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#3ee4c0\"},{\"col1\":\"90\",\"col2\":\"#0045de\"}]}}},\"6\":[\"108\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessitated consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, an oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"https://macrolease.com\"}}','2019-11-05 03:04:34','2019-11-05 03:04:34','56f86755-7de1-42ff-a0f2-f5570ce79f5b'),(69,111,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Portraits for Change\",\"slug\":\"portraits-for-change\",\"postDate\":1593051300,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[\"109\"],\"17\":true,\"3\":{\"112\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"\",\"col2\":\"\"}]}}},\"6\":[\"110\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"http://www.oilportraits.org/\"}}','2020-06-25 02:15:33','2020-06-25 02:15:33','ca62cfe6-1a78-487e-a62c-21fb3a818c3d'),(70,111,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Portraits for Change\",\"slug\":\"portraits-for-change\",\"postDate\":1593051300,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"109\"],\"1\":[\"109\"],\"17\":true,\"3\":{\"112\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"65\",\"stops\":[{\"col1\":\"20\",\"col2\":\"ef4749\"},{\"col1\":\"90\",\"col2\":\"89827a\"}]}}},\"6\":[\"110\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"http://www.oilportraits.org/\"}}','2020-06-25 02:25:03','2020-06-25 02:25:03','c1ce6c5c-7950-4827-860e-eda5d6e5344c'),(71,111,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Portraits for Change\",\"slug\":\"portraits-for-change\",\"postDate\":1593051300,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"109\"],\"1\":[\"109\"],\"17\":true,\"3\":{\"112\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"65deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ef4749\"},{\"col1\":\"90\",\"col2\":\"#89827a\"}]}}},\"6\":[\"110\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"http://www.oilportraits.org/\"}}','2020-06-25 02:28:56','2020-06-25 02:28:56','4b7b4a97-7b18-4ded-83b7-b30096f1d5ad'),(72,114,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Cicada\",\"slug\":\"cicada\",\"postDate\":1600810620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"115\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"0\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#4a37be\"},{\"col1\":\"100\",\"col2\":\"#d4254f\"}]}}},\"6\":[\"113\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"https://cicadafilm.com\"}}','2020-09-22 21:37:06','2020-09-22 21:37:06','daa8f915-fa17-4fe0-9fb8-e1472a644839'),(73,114,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Cicada\",\"slug\":\"cicada\",\"postDate\":1600810620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"115\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"0\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#4a37be\"},{\"col1\":\"100\",\"col2\":\"#d4254f\"}]}}},\"6\":[\"116\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"https://cicadafilm.com\"}}','2020-09-22 21:38:10','2020-09-22 21:38:10','ef87f4bf-a25b-4ef2-8dd1-7dfb01421795'),(75,111,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Portraits for Change\",\"slug\":\"portraits-for-change\",\"postDate\":1593051300,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"109\"],\"1\":[\"109\"],\"17\":true,\"3\":{\"112\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"65deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ef4749\"},{\"col1\":\"80\",\"col2\":\"#8800ff\"}]}}},\"6\":[\"110\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"http://www.oilportraits.org/\"}}','2020-10-29 03:48:39','2020-10-29 03:48:39','e97509dc-1bd8-41e9-afb9-058c45895785'),(76,100,1,1,1,11,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"38\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#3ee4c0\"},{\"col1\":\"90\",\"col2\":\"#0045de\"}]}}},\"6\":[\"102\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessitated consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, an oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"https://macrolease.com\"}}','2020-10-29 04:39:04','2020-10-29 04:39:04','ec17f5b0-34b5-4a8e-b0cd-cbd498ba7de8'),(77,114,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Cicada\",\"slug\":\"cicada\",\"postDate\":1600810620,\"expiryDate\":null,\"enabled\":false,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"115\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"0\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#4a37be\"},{\"col1\":\"100\",\"col2\":\"#d4254f\"}]}}},\"6\":[\"116\"],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[],\"16\":\"https://cicadafilm.com\"}}','2020-12-21 20:13:42','2020-12-21 20:13:42','912ceda1-74cc-4911-b90d-e8576970e87f'),(78,118,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Idealist.org\",\"slug\":\"idealist-org\",\"postDate\":1608582240,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"119\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"25\",\"col2\":\"#2F80ED\"},{\"col1\":\"90\",\"col2\":\"#0036F4\"}]}}},\"6\":[],\"9\":[],\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[\"117\"],\"16\":\"https://idealist.org\"}}','2020-12-21 20:24:33','2020-12-21 20:24:33','98c43059-e31c-41d9-96bb-3d687b5aa0e3'),(79,118,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Idealist.org\",\"slug\":\"idealist-org\",\"postDate\":1608582240,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"119\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"25\",\"col2\":\"#2F80ED\"},{\"col1\":\"90\",\"col2\":\"#0036F4\"}]}}},\"6\":[],\"9\":[],\"11\":[\"5\",\"120\"],\"12\":[],\"15\":[\"117\"],\"16\":\"https://idealist.org\"}}','2020-12-21 20:30:53','2020-12-21 20:30:53','6e4060ce-7e33-464f-ba16-72a505f0bc92'),(80,111,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Portraits for Change\",\"slug\":\"portraits-for-change\",\"postDate\":1593051300,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"109\"],\"1\":[\"109\"],\"17\":true,\"3\":{\"112\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"65deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ef4749\"},{\"col1\":\"80\",\"col2\":\"#8800ff\"}]}}},\"6\":[\"110\"],\"9\":[],\"11\":[\"5\",\"120\"],\"12\":[],\"15\":[],\"16\":\"http://www.oilportraits.org/\"}}','2020-12-21 20:31:34','2020-12-21 20:31:34','fce8cbbc-374a-4d15-b027-a406d3b5faac'),(82,21,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Women\'s Health Week\",\"slug\":\"womens-health-week\",\"postDate\":1535585940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"54\"],\"1\":[\"14\"],\"17\":false,\"3\":{\"22\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"67deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#7000c6\"},{\"col1\":\"80\",\"col2\":\"#ff2eb9\"}]}}},\"6\":[\"20\"],\"9\":{\"96\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"https://womenshealthweek.com.au\\\" target=\\\"true\\\"><img src=\\\"{asset:91:transform:wysiwyg}\\\" data-image=\\\"91\\\"></a><figcaption>Successful relaunch of the Womens Health Week site</figcaption></figure>\"}}},\"11\":[\"5\",\"6\"],\"12\":[],\"15\":[\"24\"],\"16\":\"https://www.womenshealthweek.com.au/\"}}','2020-12-21 20:38:46','2020-12-21 20:38:46','ee5e76d4-b5c3-4fb4-ba60-e9257d65bf2c'),(84,118,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Idealist.org\",\"slug\":\"idealist-org\",\"postDate\":1608582240,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"119\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"25\",\"col2\":\"#2F80ED\"},{\"col1\":\"90\",\"col2\":\"#0036F4\"}]}}},\"6\":[\"117\"],\"9\":[],\"11\":[\"5\",\"120\"],\"12\":[],\"15\":[],\"16\":\"https://idealist.org\"}}','2020-12-21 21:39:30','2020-12-21 21:39:30','839e7886-4edc-40e4-91a2-07d67460afa5'),(85,100,1,1,1,12,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Macrolease\",\"slug\":\"macrolease\",\"postDate\":1540580880,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":false,\"3\":{\"101\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"38\",\"stops\":[{\"col1\":\"10\",\"col2\":\"#3ee4c0\"},{\"col1\":\"90\",\"col2\":\"#0045de\"}]}}},\"6\":[\"102\"],\"8\":\"<p>A complete redesign and rebuild of the Macrolease website using Craft CMS. This project necessitated consideration of some elements of visual identity without the scope to actually tackle it head-on. Craft was chosen for both facility of development and the client\'s content entry experience, an oft overlooked component of web development.</p>\",\"9\":{\"106\":{\"type\":\"wysiwyg\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<figure><a href=\\\"http://s-macrolease.willfifer.com\\\" target=\\\"true\\\"><img src=\\\"{asset:103:transform:wysiwyg}\\\" data-image=\\\"103\\\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:104:transform:wysiwyg}\\\" data-image=\\\"104\\\"><figcaption>\\\"Floating\\\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\\r\\n<figure><img src=\\\"{asset:105:transform:wysiwyg}\\\" data-image=\\\"105\\\"><figcaption>Original website</figcaption></figure>\"}}},\"11\":[\"5\",\"6\",\"8\"],\"12\":[],\"15\":[\"102\"],\"16\":\"https://macrolease.com\"}}','2020-12-23 14:41:13','2020-12-23 14:41:13','f66e34ef-7ae1-4602-92b6-0378932cccb6'),(86,111,1,1,1,6,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Portraits for Change\",\"slug\":\"portraits-for-change\",\"postDate\":1593051300,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[\"109\"],\"1\":[\"109\"],\"17\":true,\"3\":{\"112\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"65deg\",\"stops\":[{\"col1\":\"20\",\"col2\":\"#ef4749\"},{\"col1\":\"80\",\"col2\":\"#8800ff\"}]}}},\"6\":[\"121\"],\"9\":[],\"11\":[\"5\",\"120\"],\"12\":[],\"15\":[],\"16\":\"http://www.oilportraits.org/\"}}','2020-12-23 14:43:44','2020-12-23 14:43:44','533091ba-b5cc-48d4-a228-d3095638e547'),(88,118,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Idealist.org\",\"slug\":\"idealist-org\",\"postDate\":1608582240,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"119\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":null,\"stops\":[{\"col1\":\"25\",\"col2\":\"#2F80ED\"},{\"col1\":\"90\",\"col2\":\"#0036F4\"}]}}},\"6\":[\"117\"],\"9\":[],\"11\":[\"120\",\"6\",\"5\"],\"12\":[],\"15\":[],\"16\":\"https://idealist.org\"}}','2020-12-28 16:48:30','2020-12-28 16:48:30','86d7c571-bc49-4dd6-9bf9-db0aa71b6fc4'),(89,114,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Cicada\",\"slug\":\"cicada\",\"postDate\":1600810620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":[],\"1\":[],\"17\":true,\"3\":{\"115\":{\"type\":\"background\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"angle\":\"0\",\"stops\":[{\"col1\":\"0\",\"col2\":\"#4a37be\"},{\"col1\":\"100\",\"col2\":\"#d4254f\"}]}}},\"6\":[\"116\"],\"9\":[],\"11\":[\"6\",\"5\"],\"12\":[],\"15\":[],\"16\":\"https://cicadafilm.com\"}}','2020-12-28 16:49:54','2020-12-28 16:49:54','8e5c91d5-c4eb-4d30-adcb-b3c2c9cba6d6');
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldgroups` VALUES (1,'Common','2018-08-29 22:59:29','2018-08-29 22:59:29','1601ca5d-3aa7-42f2-a898-540bbb721690'),(2,'Project','2018-08-29 23:04:14','2018-08-29 23:04:14','3a27efe0-652c-4a93-afc7-755455810a60');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldlayoutfields` VALUES (1,2,1,4,0,1,'2018-08-29 23:08:09','2018-08-29 23:08:09','0350d44a-155c-405f-a418-c7d53e5bb646'),(2,2,1,5,0,2,'2018-08-29 23:08:09','2018-08-29 23:08:09','cea403ac-d424-4778-a35c-b4e31cfd3cb7'),(4,5,3,13,0,1,'2018-08-29 23:12:58','2018-08-29 23:12:58','9d69ce51-75bb-485d-9fd3-34bf0a403111'),(5,5,3,14,0,2,'2018-08-29 23:12:58','2018-08-29 23:12:58','fbba350c-3359-4d32-921c-ad522dabaec4'),(29,1,11,16,0,1,'2018-10-19 17:42:50','2018-10-19 17:42:50','53f33ea7-0be5-49c9-8bf9-df1f1bc089aa'),(30,7,12,6,0,1,'2018-10-19 19:09:34','2018-10-19 19:09:34','f990ea67-d6e6-4789-af4d-444598b0ed39'),(31,7,12,3,0,2,'2018-10-19 19:09:34','2018-10-19 19:09:34','e737bbc4-11ba-4917-bfb0-5cca87ac42de'),(32,7,12,12,0,3,'2018-10-19 19:09:34','2018-10-19 19:09:34','39cace73-fa23-49a3-a13a-f35a697e46f8'),(33,7,12,15,0,4,'2018-10-19 19:09:34','2018-10-19 19:09:34','3e8a4632-4180-4fc4-ba41-423499f4ea4e'),(34,7,12,16,0,5,'2018-10-19 19:09:34','2018-10-19 19:09:34','01a18f3c-ab6c-4bf9-b7d1-e51a8177bf7d'),(35,7,12,1,0,6,'2018-10-19 19:09:34','2018-10-19 19:09:34','9cb28ccf-cc74-420c-9eb2-8779a1b783a6'),(36,7,12,18,0,7,'2018-10-19 19:09:34','2018-10-19 19:09:34','403eb8d7-69c2-41b7-a391-63612fe371fb'),(37,7,12,11,0,8,'2018-10-19 19:09:34','2018-10-19 19:09:34','e4ac2bd3-6516-4bac-907d-727e9f3de5de'),(38,7,12,17,0,9,'2018-10-19 19:09:34','2018-10-19 19:09:34','cb4d2979-eccb-4dae-83b3-33d12b108342'),(39,7,13,8,0,1,'2018-10-19 19:09:34','2018-10-19 19:09:34','20516004-5c46-46f4-918b-e6ffd683cee2'),(40,7,13,9,0,2,'2018-10-19 19:09:34','2018-10-19 19:09:34','41c51867-d347-4f4f-b181-c655f2bd35c9'),(44,3,17,10,0,1,'2018-10-24 19:47:03','2018-10-24 19:47:03','d4a943e9-62c6-4da7-91bd-c2800272b4c7'),(45,4,18,2,0,1,'2020-12-28 15:11:05','2020-12-28 15:11:05','1ff54a55-96e1-4dd4-a613-2a7d800e65ad'),(46,4,18,19,0,2,'2020-12-28 15:11:05','2020-12-28 15:11:05','f76eb60e-41f1-409c-a27d-5e8b33a905d8');
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldlayouts` VALUES (1,'craft\\elements\\Category','2018-08-29 23:05:16','2018-10-19 17:42:50',NULL,'3e70a6a8-9132-4444-8f9d-c8f7bb539fef'),(2,'craft\\elements\\MatrixBlock','2018-08-29 23:08:09','2018-08-29 23:08:09',NULL,'d6ebade8-f5dd-4ed1-8539-584aa0c083cd'),(3,'craft\\elements\\MatrixBlock','2018-08-29 23:10:58','2018-10-24 19:47:03',NULL,'59a7a1d7-b45e-478b-9aac-0f33b5193ca2'),(4,'craft\\elements\\Category','2018-08-29 23:11:31','2020-12-28 15:11:05',NULL,'16ef1415-8834-46a5-b62e-dc0f7ef198c3'),(5,'craft\\elements\\MatrixBlock','2018-08-29 23:12:58','2018-08-29 23:12:58',NULL,'d7b35595-a2d6-4f58-8642-de0487518ecd'),(6,'craft\\elements\\Asset','2018-08-29 23:15:31','2020-12-29 19:01:07',NULL,'b0056f80-4989-4c64-8210-8be4d2ff4cfd'),(7,'craft\\elements\\Entry','2018-08-29 23:17:50','2018-10-19 19:09:34',NULL,'b20c17fa-2461-4eb2-98c4-7f40b8d94417');
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldlayouttabs` VALUES (1,2,'Content',NULL,1,'2018-08-29 23:08:09','2018-08-29 23:08:09','a37a7785-6993-4036-acdb-02a1fa88fb49'),(3,5,'Content',NULL,1,'2018-08-29 23:12:58','2018-08-29 23:12:58','1c5c0545-f2ff-45ce-af9d-22c094c1f210'),(11,1,'Content',NULL,1,'2018-10-19 17:42:50','2018-10-19 17:42:50','654d448b-fed3-4b12-9fca-77f1b8234a80'),(12,7,'Project',NULL,1,'2018-10-19 19:09:34','2018-10-19 19:09:34','1bf29184-2981-4e34-973d-2e794fd27902'),(13,7,'Details',NULL,2,'2018-10-19 19:09:34','2018-10-19 19:09:34','a6c4151a-0c1a-46b4-bcc0-ca01f1aee622'),(17,3,'Content',NULL,1,'2018-10-24 19:47:03','2018-10-24 19:47:03','4c20219f-e57b-466c-a0e6-896d1de26ea8'),(18,4,'Common',NULL,1,'2020-12-28 15:11:05','2020-12-28 15:11:05','91dc64ce-ec66-43e4-bc22-aaf6971bae3b');
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fields` VALUES (1,2,'Collaborator','collaborator','global','',1,'site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:492f2972-c006-463a-bc0a-e5c717b071ad\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-08-29 23:04:41','2018-08-29 23:05:28','f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb'),(2,1,'Font Icon','fontIcon','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-08-29 23:06:17','2018-08-30 19:20:53','5a963a89-7fa0-4b36-a2a2-41b8c32576d0'),(3,2,'Hero Background','heroBackground','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"1\",\"localizeBlocks\":false,\"contentTable\":\"{{%matrixcontent_herobackground}}\"}','2018-08-29 23:08:09','2018-08-29 23:08:09','dd3b32a6-93ce-42ad-9d56-f42364868459'),(4,NULL,'Angle','angle','matrixBlockType:d012cae4-70de-460d-bfae-c1fad53523a4','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2018-08-29 23:08:09','2021-01-03 00:35:30','eda0bb13-fa15-4fd1-be40-93113a86ebb9'),(5,NULL,'Stops','stops','matrixBlockType:d012cae4-70de-460d-bfae-c1fad53523a4','',1,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a row\",\"maxRows\":\"\",\"minRows\":\"\",\"columns\":{\"col1\":{\"heading\":\"Position\",\"handle\":\"position\",\"width\":\"\",\"type\":\"number\"},\"col2\":{\"heading\":\"Color\",\"handle\":\"color\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":{\"row1\":{\"col1\":\"\",\"col2\":\"\"}},\"columnType\":\"text\"}','2018-08-29 23:08:09','2018-08-29 23:08:09','11b64d24-f280-458c-a5f0-8832a3e9331d'),(6,2,'Hero Image','heroImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\",\"defaultUploadLocationSubpath\":\"hero\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2018-08-29 23:09:09','2021-01-03 00:35:30','28ad0220-2985-4dd6-b69c-d2bba848f18c'),(7,1,'Icon','icon','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\",\"defaultUploadLocationSubpath\":\"icon\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2018-08-29 23:09:55','2021-01-03 00:35:30','aae80770-f8da-4b57-8e50-67451222446d'),(8,2,'Intro','intro','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"1\",\"removeEmptyTags\":\"1\",\"removeNbsp\":\"1\"}','2018-08-29 23:10:19','2021-01-03 00:59:43','ad268a11-e70c-4b59-a8db-5ba3121b2268'),(9,2,'Page Content','pageContent','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_pagecontent}}\",\"localizeBlocks\":false}','2018-08-29 23:10:58','2018-10-24 19:47:03','a3097e79-2eca-45a0-9de1-532129638764'),(10,NULL,'Body','body','matrixBlockType:ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":[\"3\"],\"availableVolumes\":\"*\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"\",\"redactorConfig\":\"Standard.json\",\"removeInlineStyles\":\"\",\"removeEmptyTags\":\"\",\"removeNbsp\":\"\"}','2018-08-29 23:10:58','2021-01-03 00:59:43','3a1a6899-2491-4f99-91d5-45690288cbef'),(11,2,'Project Category','projectCategory','global','',1,'site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:b1044122-fed0-47d2-ad0e-ac24c940dcb6\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-08-29 23:11:47','2018-08-29 23:32:35','a430daeb-1368-4cb9-996c-f43a38b978b1'),(12,2,'Project Layers','projectLayers','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false,\"contentTable\":\"{{%matrixcontent_projectlayers}}\"}','2018-08-29 23:12:58','2018-08-29 23:12:58','e92faebe-fac6-4f3d-94c5-98416b9596fe'),(13,NULL,'Image','image','matrixBlockType:b5e9da4e-d9d4-4e07-afa4-1416703646c0','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":null,\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":null,\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-08-29 23:12:58','2018-08-29 23:12:58','37957ba4-44c0-455f-acb8-9a018e7bcf53'),(14,NULL,'Depth','depth','matrixBlockType:b5e9da4e-d9d4-4e07-afa4-1416703646c0','Negative will appear behind project hero. ',1,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":null,\"max\":\"10\",\"min\":\"-10\",\"size\":null}','2018-08-29 23:12:58','2021-01-03 00:35:30','5f203469-9c0d-4c6b-9bfd-1e70bb80095e'),(15,2,'Thumbnail','thumbnail','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\",\"defaultUploadLocationSubpath\":\"thumbnail\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2018-08-29 23:13:23','2021-01-03 00:35:30','50b5a7ca-6355-4c94-bc52-14eb2ba78593'),(16,2,'Website','website','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-08-29 23:13:37','2018-08-29 23:13:37','3017f74c-e2c5-4e6b-960e-c8296b8e86f1'),(17,2,'Featured','featured','global','',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"1\"}','2018-08-30 23:41:19','2018-08-30 23:41:19','b5088f1a-7338-47ec-83a8-64e2b5873b29'),(18,2,'Client','client','global','',1,'site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:492f2972-c006-463a-bc0a-e5c717b071ad\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-10-19 17:38:39','2018-10-19 17:44:17','a6bdea55-c12e-4a2b-bef4-8db5348d162c'),(19,1,'Font Icon Style','fontIconStyle','global','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Solid\",\"value\":\"fas\",\"default\":\"1\"},{\"label\":\"Regular\",\"value\":\"far\",\"default\":\"\"},{\"label\":\"Light\",\"value\":\"fal\",\"default\":\"\"},{\"label\":\"Duotone\",\"value\":\"fad\",\"default\":\"\"},{\"label\":\"Brands\",\"value\":\"fab\",\"default\":\"\"}]}','2020-12-28 15:09:55','2020-12-28 15:52:30','bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91');
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_gqlschemas`
--

LOCK TABLES `craft_gqlschemas` WRITE;
/*!40000 ALTER TABLE `craft_gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_gqltokens`
--

LOCK TABLES `craft_gqltokens` WRITE;
/*!40000 ALTER TABLE `craft_gqltokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_gqltokens` VALUES (1,'Public Token','__PUBLIC__',0,NULL,NULL,NULL,'2021-01-03 00:35:38','2021-01-03 00:35:38','e190152a-c2e2-4540-9b05-46451a94bc3c');
/*!40000 ALTER TABLE `craft_gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_info` VALUES (1,'3.5.19.1','3.5.13',1,'azcribkvsvuf','2eCXpiv6d2BU','2018-08-29 22:59:29','2022-10-19 17:39:43','4a114c78-ca88-4a75-8046-c9730346ee4c');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_matrixblocks` VALUES (4,2,3,1,1,NULL,'2018-08-29 23:28:35','2020-12-21 20:42:35','d1bff3ea-b000-4119-a15c-c97c46a603f1'),(16,15,3,1,1,NULL,'2018-08-29 23:36:02','2018-10-24 19:33:39','49b88364-9f55-489d-aabe-ecd2ffd76cb9'),(19,18,3,1,1,NULL,'2018-08-29 23:38:11','2018-10-24 20:20:29','de4ff7b7-d183-492d-a523-291ea5d815a1'),(22,21,3,1,1,NULL,'2018-08-29 23:39:20','2020-12-28 16:50:56','45f56924-8948-493e-9429-c5ecdd2c0fb2'),(28,27,3,1,1,NULL,'2018-08-30 02:20:00','2018-10-24 20:30:42','62705b18-cc8d-457f-ac33-dc7be7a49a79'),(31,30,3,1,1,NULL,'2018-08-30 02:21:20','2018-11-15 19:29:57','99d91fac-4306-4e45-9775-29ad22014e8b'),(37,36,3,1,1,NULL,'2018-08-30 02:23:35','2020-12-21 20:37:50','5745ed64-363b-47ff-aa2f-e3d84e3b3151'),(42,34,3,1,1,NULL,'2018-08-30 02:28:25','2020-12-21 20:38:19','22691547-7ca1-4b45-8b95-59a751fa1f00'),(46,45,3,1,1,NULL,'2018-08-30 23:46:13','2018-10-19 19:09:37','dc592563-066b-4480-88eb-cc2deee7aeb6'),(67,15,9,2,1,NULL,'2018-10-23 22:41:04','2018-10-24 19:33:39','c52d0278-d43c-4dbb-a3c3-2c68ee597b9e'),(93,30,9,2,1,NULL,'2018-10-24 04:03:16','2018-11-15 19:29:57','3d2e42e1-4c42-4450-aebb-6cdb4e317ff3'),(95,18,9,2,1,NULL,'2018-10-24 20:20:29','2018-10-24 20:20:29','39474587-ae04-42f4-840f-ecee5431e91a'),(96,21,9,2,1,NULL,'2018-10-24 20:21:52','2020-12-28 16:50:56','c643bff0-d790-4f67-b318-34a07b6832e8'),(97,27,9,2,1,NULL,'2018-10-24 20:30:42','2018-10-24 20:30:42','1a5adafe-5f9d-4537-ba5d-f7c293bc5160'),(98,34,9,2,1,NULL,'2018-10-24 20:36:40','2020-12-21 20:38:19','3ff8b079-ef65-4ef9-9b75-b7f23fdfe51e'),(101,100,3,1,1,NULL,'2018-10-26 19:08:08','2020-12-28 16:50:35','fee8ca21-73fe-4bba-a536-0bff98ced54a'),(106,100,9,2,1,NULL,'2018-10-26 19:41:28','2020-12-28 16:50:35','5858246e-9f00-4e5d-9682-00bafa214204'),(107,36,9,2,1,NULL,'2018-10-26 22:33:19','2020-12-21 20:37:50','410e76bc-8837-4e52-84e3-d6f898e08564'),(112,111,3,1,1,NULL,'2020-06-25 02:15:33','2020-12-28 16:46:23','64d6a6ad-7e74-4dc1-affb-8eb469373cad'),(115,114,3,1,1,NULL,'2020-09-22 21:37:06','2020-12-28 20:22:59','f8eea0ad-ee8f-43e0-8ded-58ffd24d8f3d'),(119,118,3,1,1,NULL,'2020-12-21 20:24:33','2020-12-28 20:43:18','2a535b8f-f9d1-4514-8dd1-892c0d83e6a5'),(124,123,3,1,1,NULL,'2021-01-03 00:36:15','2021-01-03 00:36:15','9947bf5c-c326-47e6-9e58-42900433f5bd'),(126,125,3,1,1,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','1fff9579-a8fa-40e4-97e8-ca4a8197d112'),(128,127,3,1,1,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','2e269861-4a79-4840-905f-a37a008efb7d'),(129,127,9,2,1,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','057e7595-e968-43f9-ac91-7ad9ce351f9d'),(131,130,3,1,1,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','fc1d7efa-fbc0-401f-aefd-afddadde73c6'),(132,130,9,2,1,NULL,'2021-01-03 00:36:32','2021-01-03 00:36:32','2dd82787-22c2-407c-946d-e95c0d403362'),(134,133,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','11a98bfb-1fca-4342-9c40-5556a500c70e'),(136,135,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','39eaf40e-9977-4565-95fe-8396e03512b7'),(138,137,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','69a1a617-c570-4462-856a-8ff27b6cbef5'),(139,137,9,2,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','50cf5206-6579-42d3-95ec-da3015046daa'),(141,140,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','1addeaf0-ef7f-4cc0-b2fb-58e63b1080f5'),(142,140,9,2,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','edddbf83-bbaa-4a63-914c-04e2403bbb92'),(144,143,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','e1a6f613-a34d-4aac-bbbd-a06134319f01'),(145,143,9,2,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','ee5e1348-acbd-4bcc-8432-0487df4a09b3'),(147,146,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','afb90465-138d-46cd-8246-729cc914e8e5'),(148,146,9,2,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','9ce7bda1-c856-4d38-bb44-74de57094e36'),(150,149,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','f64f2c95-b726-4cba-a094-09adc0f08cfe'),(151,149,9,2,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','31476b9e-8192-49f7-ba85-607368b89100'),(153,152,3,1,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','ab2cb99b-541c-45c0-bbcb-5ddce0c300e6'),(154,152,9,2,1,NULL,'2021-01-03 00:36:33','2021-01-03 00:36:33','26e6e8f7-22c5-45ad-a032-2d9f0487e74e'),(156,155,3,1,1,NULL,'2021-01-03 00:36:34','2021-01-03 00:36:34','c6abd4d5-f7bf-44d6-ba03-4d0baf0450fb');
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_matrixblocktypes` VALUES (1,3,2,'Background','background',1,'2018-08-29 23:08:09','2018-08-29 23:08:09','d012cae4-70de-460d-bfae-c1fad53523a4'),(2,9,3,'WYSIWYG','wysiwyg',1,'2018-08-29 23:10:58','2018-10-24 19:47:03','ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac'),(3,12,5,'Layer','layer',1,'2018-08-29 23:12:58','2018-08-29 23:12:58','b5e9da4e-d9d4-4e07-afa4-1416703646c0');
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixcontent_herobackground`
--

LOCK TABLES `craft_matrixcontent_herobackground` WRITE;
/*!40000 ALTER TABLE `craft_matrixcontent_herobackground` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_matrixcontent_herobackground` VALUES (1,4,1,'2018-08-29 23:28:35','2020-12-21 20:42:35','48a62834-6ec5-43f2-9a8c-37fec06bf01c','28deg','[{\"col1\":\"20\",\"col2\":\"#9822ff\"},{\"col1\":\"70\",\"col2\":\"#0065ff\"}]'),(2,16,1,'2018-08-29 23:36:02','2018-10-24 19:33:39','d130ac7d-45e9-45d8-98f0-67ea1636702c','30deg','[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]'),(3,19,1,'2018-08-29 23:38:11','2018-10-24 20:20:29','e64d3dcc-6fce-480a-87ec-9452b81fac98',NULL,'[{\"col1\":\"20\",\"col2\":\"#ff0062\"},{\"col1\":\"80\",\"col2\":\"#ff7900\"}]'),(4,22,1,'2018-08-29 23:39:20','2020-12-28 16:50:56','d2cb0529-d44c-4a35-993d-3d5b99146c39','67deg','[{\"col1\":\"20\",\"col2\":\"#7000c6\"},{\"col1\":\"80\",\"col2\":\"#ff2eb9\"}]'),(5,28,1,'2018-08-30 02:20:00','2018-10-24 20:30:42','20d45c9a-e622-42bc-9a8d-dd9abdacbc90','0deg','[{\"col1\":\"20\",\"col2\":\"#00d4a2\"},{\"col1\":\"50\",\"col2\":\"#8d81ff\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]'),(6,31,1,'2018-08-30 02:21:20','2018-11-15 19:29:56','cf1bb33b-cac5-4984-b686-eea6757f02c1','75deg','[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]'),(7,37,1,'2018-08-30 02:23:35','2020-12-21 20:37:50','f34839a3-53eb-4c42-a655-5fdfd92f1d76','10deg','[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]'),(8,42,1,'2018-08-30 02:28:25','2020-12-21 20:38:19','2154f24d-cb18-4ae5-b2dd-d46553b3ec85','45deg','[{\"col1\":\"20\",\"col2\":\"#ff9e15\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]'),(9,46,1,'2018-08-30 23:46:13','2018-10-19 19:09:37','dba0ab8c-2e96-467c-b60e-391a95d03899','48deg','[{\"col1\":\"20\",\"col2\":\"#ff9000\"},{\"col1\":\"80\",\"col2\":\"#ff0036\"}]'),(10,101,1,'2018-10-26 19:08:08','2020-12-28 16:50:35','04750fd5-225a-4e75-b637-d419fc62e5c8','38','[{\"col1\":\"10\",\"col2\":\"#3ee4c0\"},{\"col1\":\"90\",\"col2\":\"#0045de\"}]'),(11,112,1,'2020-06-25 02:15:33','2020-12-28 16:46:23','54c0c793-b678-41b5-892f-a17417456123','65deg','[{\"col1\":\"20\",\"col2\":\"#ef4749\"},{\"col1\":\"80\",\"col2\":\"#8800ff\"}]'),(12,115,1,'2020-09-22 21:37:06','2020-12-28 20:22:59','c2d5d54d-9d05-498f-ac0d-9db2cf8821cd','0','[{\"col1\":\"0\",\"col2\":\"#4a37be\"},{\"col1\":\"100\",\"col2\":\"#d4254f\"}]'),(13,119,1,'2020-12-21 20:24:33','2020-12-28 20:43:18','c53ff86d-44b3-4197-9b5a-afa95c9cd0b3','20','[{\"col1\":\"25\",\"col2\":\"#A4FF30\"},{\"col1\":\"90\",\"col2\":\"#0036F4\"}]'),(14,124,1,'2021-01-03 00:36:15','2021-01-03 00:36:16','f7ff7a33-43db-4bef-9998-29d07e9f2d9e','20','[{\"col1\":\"25\",\"col2\":\"#A4FF30\"},{\"col1\":\"90\",\"col2\":\"#0036F4\"}]'),(15,126,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','d1f8d06d-0f25-43c9-ab9d-9c0c1bbe8b10','0','[{\"col1\":\"0\",\"col2\":\"#4a37be\"},{\"col1\":\"100\",\"col2\":\"#d4254f\"}]'),(16,128,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','0a7e961b-d06c-4063-af57-b6f4c53247d9','67deg','[{\"col1\":\"20\",\"col2\":\"#7000c6\"},{\"col1\":\"80\",\"col2\":\"#ff2eb9\"}]'),(17,131,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','08adb064-6bd0-4688-b196-27d5b7d393b3','38','[{\"col1\":\"10\",\"col2\":\"#3ee4c0\"},{\"col1\":\"90\",\"col2\":\"#0045de\"}]'),(18,134,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','676dd5d4-9c32-4f75-9512-44f692025756','65deg','[{\"col1\":\"20\",\"col2\":\"#ef4749\"},{\"col1\":\"80\",\"col2\":\"#8800ff\"}]'),(19,136,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','ff093504-35a7-40ed-923a-c9c9aa167a36','28deg','[{\"col1\":\"20\",\"col2\":\"#9822ff\"},{\"col1\":\"70\",\"col2\":\"#0065ff\"}]'),(20,138,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','a1ea0edf-ada0-45c6-ac95-a16e20ca386c','45deg','[{\"col1\":\"20\",\"col2\":\"#ff9e15\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]'),(21,141,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','2b4f8764-5e70-483e-9963-15edca3cf6af','10deg','[{\"col1\":\"30\",\"col2\":\"#e2ff00\"},{\"col1\":\"80\",\"col2\":\"#00ffcf\"}]'),(22,144,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','9be7d3ab-255f-4457-a22a-1fe70ea558cd','75deg','[{\"col1\":\"10\",\"col2\":\"#ff3f85\"},{\"col1\":\"50\",\"col2\":\"#ffe448\"},{\"col1\":\"90\",\"col2\":\"#95ff10\"}]'),(23,147,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','c3fb4e8a-75a3-44fd-a1e3-6eee19cbb761','0deg','[{\"col1\":\"20\",\"col2\":\"#00d4a2\"},{\"col1\":\"50\",\"col2\":\"#8d81ff\"},{\"col1\":\"80\",\"col2\":\"#ff3fb5\"}]'),(24,150,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','cecab1b7-1b4d-4fc6-80c0-5efdeb6dd9a7',NULL,'[{\"col1\":\"20\",\"col2\":\"#ff0062\"},{\"col1\":\"80\",\"col2\":\"#ff7900\"}]'),(25,153,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','08da2de4-a439-495f-8807-f67a7078c5bb','30deg','[{\"col1\":\"0\",\"col2\":\"#00a99d\"},{\"col1\":\"80\",\"col2\":\"#b6ff15\"}]'),(26,156,1,'2021-01-03 00:36:34','2021-01-03 00:36:34','5cc83e37-9803-40c3-bb9a-f14c9450ec00','48deg','[{\"col1\":\"20\",\"col2\":\"#ff9000\"},{\"col1\":\"80\",\"col2\":\"#ff0036\"}]');
/*!40000 ALTER TABLE `craft_matrixcontent_herobackground` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixcontent_pagecontent`
--

LOCK TABLES `craft_matrixcontent_pagecontent` WRITE;
/*!40000 ALTER TABLE `craft_matrixcontent_pagecontent` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_matrixcontent_pagecontent` VALUES (1,67,1,'2018-10-23 22:41:04','2018-10-24 19:33:39','0fe51451-0a69-4b02-b6b8-f86501789b7c','<figure><a href=\"https://mantest.com.au\"><img src=\"{asset:89:transform:wysiwyg}\" alt=\"\" /></a><figcaption>Have a crack at The Man Test</figcaption></figure><p></p>\n<figure><a href=\"http://mantest.com.au/test\"><img src=\"{asset:94:transform:wysiwyg}\" alt=\"\" /></a><figcaption>My typical checkup experience</figcaption></figure>'),(2,93,1,'2018-10-24 04:03:16','2018-11-15 19:29:57','57f8b5a9-1d37-4269-8d9b-d5b8bef3ba7e','<figure><a href=\"http://uxmas.com\"><img src=\"{asset:90:transform:wysiwyg}\" data-image=\"unhphfeu8xap\"></a><figcaption>The UXMas advent calendar</figcaption></figure>\r\n<figure>\r\n    <div class=\"video-container\">\r\n        <iframe src=\"https://player.vimeo.com/video/296951046?autoplay=1&loop=1&muted=1\" width=\"1080\" height=\"720\" frameborder=\"0\" webkitallowfullscreen=\"\" mozallowfullscreen=\"\" allowfullscreen=\"\"></iframe>\r\n    </div>\r\n    <figcaption>25 days of UXMas</figcaption>\r\n</figure>'),(3,95,1,'2018-10-24 20:20:29','2018-10-24 20:20:29','5cf78ad0-8247-4ea9-b14d-30e512e1cad0','<figure><a href=\"https://hallstaekwondo.com.au\" target=\"true\"><img src=\"{asset:88:transform:wysiwyg}\" data-image=\"88\"></a><figcaption>Halls Taekwondo home page</figcaption></figure><figure><a href=\"https://hallstaekwondo.com.au/shop\" target=\"true\"><img src=\"{asset:87:transform:wysiwyg}\" data-image=\"87\"></a><figcaption>Halls shop, product details</figcaption></figure><p></p>'),(4,96,1,'2018-10-24 20:21:52','2020-12-28 16:50:56','91d86ffc-c239-4a55-81ba-cc9f3546c86e','<figure><a href=\"https://womenshealthweek.com.au\" target=\"true\"><img src=\"{asset:91:transform:wysiwyg}\" data-image=\"91\"></a><figcaption>Successful relaunch of the Womens Health Week site</figcaption></figure>'),(5,97,1,'2018-10-24 20:30:42','2018-10-24 20:30:42','df410faf-7db1-44b3-996f-c705c0df7664','<figure><a href=\"https://app.pmecollection.com.au\" target=\"true\"><img src=\"{asset:86:transform:wysiwyg}\" data-image=\"86\"></a><figcaption>The eCollection bookshelf</figcaption></figure>\r\n<figure><img src=\"{asset:85:transform:wysiwyg}\" data-image=\"85\"><figcaption>Book reader view</figcaption></figure>\r\n'),(6,98,1,'2018-10-24 20:36:40','2020-12-21 20:38:19','b2513701-7d82-45b4-a0ec-4ad7368bec68','<figure><a href=\"https://changeitourselves.com.au/take-part\" target=\"true\"><img src=\"{asset:84:transform:wysiwyg}\" data-image=\"84\"></a><figcaption>Helpful resources for employers and employees</figcaption></figure>'),(7,106,1,'2018-10-26 19:41:28','2020-12-28 16:50:35','6ec30f7f-1813-4c9f-ad4b-c8967ebc72e9','<figure><a href=\"http://s-macrolease.willfifer.com\" target=\"true\"><img src=\"{asset:103:transform:wysiwyg}\" data-image=\"103\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\r\n<figure><img src=\"{asset:104:transform:wysiwyg}\" data-image=\"104\"><figcaption>\"Floating\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\r\n<figure><img src=\"{asset:105:transform:wysiwyg}\" data-image=\"105\"><figcaption>Original website</figcaption></figure>'),(8,107,1,'2018-10-26 22:33:19','2020-12-21 20:37:50','b2bc4b23-9fca-4e80-b3df-cdb177c7a517','<figure><div class=\"video-container\"><iframe src=\"https://willfifer.com/jay-and-pluto/index.html\" frameborder=\"0\"></iframe></div><figcaption>Jay & Pluto film logo and animation</figcaption></figure>'),(9,129,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','0434386d-240f-4412-b7f7-ca71ad6968c9','<figure><a href=\"https://womenshealthweek.com.au\" target=\"true\"><img src=\"{asset:91:transform:wysiwyg}\" data-image=\"91\"></a><figcaption>Successful relaunch of the Womens Health Week site</figcaption></figure>'),(10,132,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','461311ec-c7f7-47ea-9ba5-78b47cdda2f1','<figure><a href=\"http://s-macrolease.willfifer.com\" target=\"true\"><img src=\"{asset:103:transform:wysiwyg}\" data-image=\"103\"></a><figcaption>Home page featuring animated title lockup and video reel</figcaption></figure>\r\n<figure><img src=\"{asset:104:transform:wysiwyg}\" data-image=\"104\"><figcaption>\"Floating\" illustrations bring Macrolease\'s personality to life</figcaption></figure>\r\n<figure><img src=\"{asset:105:transform:wysiwyg}\" data-image=\"105\"><figcaption>Original website</figcaption></figure>'),(11,139,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','6e6e7c27-56e5-4f8a-b656-6bfa570762f2','<figure><a href=\"https://changeitourselves.com.au/take-part\" target=\"true\"><img src=\"{asset:84:transform:wysiwyg}\" data-image=\"84\"></a><figcaption>Helpful resources for employers and employees</figcaption></figure>'),(12,142,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','cc2a25aa-1043-4214-aae6-45d17a84a000','<figure><div class=\"video-container\"><iframe src=\"https://willfifer.com/jay-and-pluto/index.html\" frameborder=\"0\"></iframe></div><figcaption>Jay & Pluto film logo and animation</figcaption></figure>'),(13,145,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','4cfff250-c0f1-474a-938a-4fa08d5fa99c','<figure><a href=\"http://uxmas.com\"><img src=\"{asset:90:transform:wysiwyg}\" data-image=\"unhphfeu8xap\"></a><figcaption>The UXMas advent calendar</figcaption></figure>\r\n<figure>\r\n    <div class=\"video-container\">\r\n        <iframe src=\"https://player.vimeo.com/video/296951046?autoplay=1&loop=1&muted=1\" width=\"1080\" height=\"720\" frameborder=\"0\" webkitallowfullscreen=\"\" mozallowfullscreen=\"\" allowfullscreen=\"\"></iframe>\r\n    </div>\r\n    <figcaption>25 days of UXMas</figcaption>\r\n</figure>'),(14,148,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','901e9c75-8134-412d-a67e-4a0d622c054c','<figure><a href=\"https://app.pmecollection.com.au\" target=\"true\"><img src=\"{asset:86:transform:wysiwyg}\" data-image=\"86\"></a><figcaption>The eCollection bookshelf</figcaption></figure>\r\n<figure><img src=\"{asset:85:transform:wysiwyg}\" data-image=\"85\"><figcaption>Book reader view</figcaption></figure>\r\n'),(15,151,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','d7cc1d3a-1e07-4890-9cf7-4f104caec10f','<figure><a href=\"https://hallstaekwondo.com.au\" target=\"true\"><img src=\"{asset:88:transform:wysiwyg}\" data-image=\"88\"></a><figcaption>Halls Taekwondo home page</figcaption></figure><figure><a href=\"https://hallstaekwondo.com.au/shop\" target=\"true\"><img src=\"{asset:87:transform:wysiwyg}\" data-image=\"87\"></a><figcaption>Halls shop, product details</figcaption></figure><p></p>'),(16,154,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','a33f607a-c80b-4929-aa22-a25bc475d0f8','<figure><a href=\"https://mantest.com.au\"><img src=\"{asset:89:transform:wysiwyg}\" alt=\"\" /></a><figcaption>Have a crack at The Man Test</figcaption></figure><p></p>\n<figure><a href=\"http://mantest.com.au/test\"><img src=\"{asset:94:transform:wysiwyg}\" alt=\"\" /></a><figcaption>My typical checkup experience</figcaption></figure>');
/*!40000 ALTER TABLE `craft_matrixcontent_pagecontent` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixcontent_projectlayers`
--

LOCK TABLES `craft_matrixcontent_projectlayers` WRITE;
/*!40000 ALTER TABLE `craft_matrixcontent_projectlayers` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_matrixcontent_projectlayers` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_migrations` VALUES (1,'craft','Install','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','c4878fc7-afb2-4f14-8c2b-e617d20a0c75'),(2,'craft','m150403_183908_migrations_table_changes','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','17948ffe-8d50-432a-8979-8ab198d325da'),(3,'craft','m150403_184247_plugins_table_changes','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','16d5ac9a-8e3a-4472-ae54-3e4963d3ddd2'),(4,'craft','m150403_184533_field_version','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','58753be5-f0cd-4cb9-a30b-87792ff420c0'),(5,'craft','m150403_184729_type_columns','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','9ef4951d-2b44-406f-98c2-4faca556059a'),(6,'craft','m150403_185142_volumes','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','98666c14-620f-4379-aa18-a1bbe15be40c'),(7,'craft','m150428_231346_userpreferences','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','a8c957e4-89ee-430f-895f-9f6aef4b3ec7'),(8,'craft','m150519_150900_fieldversion_conversion','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','041d6f4d-44f5-403d-88f0-a79ddf6d263f'),(9,'craft','m150617_213829_update_email_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','d300fa06-b871-4e35-b867-a1037f082f03'),(10,'craft','m150721_124739_templatecachequeries','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','02ee6b08-4dd1-49f6-8194-5d7b7c9cf32f'),(11,'craft','m150724_140822_adjust_quality_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','6d045c20-efc3-4f16-bed8-0cc88e53c1a1'),(12,'craft','m150815_133521_last_login_attempt_ip','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','2b269746-0b06-4828-8673-17a95579b1cd'),(13,'craft','m151002_095935_volume_cache_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','b6efd8e7-dcee-4d22-8017-eff6d431eeb2'),(14,'craft','m151005_142750_volume_s3_storage_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','dbdd01e4-f12a-4cb7-88c0-c4eddc15188b'),(15,'craft','m151016_133600_delete_asset_thumbnails','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','4a378e83-6c51-4e59-b9f8-1662a6004892'),(16,'craft','m151209_000000_move_logo','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','3faa8b81-17c7-4fc8-977a-25fe0c91b520'),(17,'craft','m151211_000000_rename_fileId_to_assetId','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','871cb466-20a5-409b-b000-fe5dbe771b7e'),(18,'craft','m151215_000000_rename_asset_permissions','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','0aa1a8a6-f8e1-4e74-9f4a-c3c2736dbd2d'),(19,'craft','m160707_000001_rename_richtext_assetsource_setting','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','5502fae4-021b-484d-823f-0129094a97f2'),(20,'craft','m160708_185142_volume_hasUrls_setting','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','9c3e7177-c5c8-4c5f-aa33-32fe08384676'),(21,'craft','m160714_000000_increase_max_asset_filesize','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','352a21ee-04e4-4a77-b629-fec7c7c894ac'),(22,'craft','m160727_194637_column_cleanup','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','2a5e7de7-178a-432d-8e8d-d0c7e7aee166'),(23,'craft','m160804_110002_userphotos_to_assets','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','b23031f0-b7c0-4ede-bf78-a79e613a02ed'),(24,'craft','m160807_144858_sites','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','e0d234d4-b45c-4fc9-beba-f4e09f1458e2'),(25,'craft','m160829_000000_pending_user_content_cleanup','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','f4109fcf-5938-4312-89bc-8839c500bada'),(26,'craft','m160830_000000_asset_index_uri_increase','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','693efb0c-d845-4eb7-bc8d-810a0e482f3c'),(27,'craft','m160912_230520_require_entry_type_id','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','f2125f9e-1d4c-4c93-99ef-b83408b9c3c8'),(28,'craft','m160913_134730_require_matrix_block_type_id','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','77ae0cce-02ba-4215-94ba-7feaee0d7f1a'),(29,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','86c1c078-61c8-4f19-930d-f32e5d5d0130'),(30,'craft','m160920_231045_usergroup_handle_title_unique','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','b1bbbe68-15cc-4c49-959b-6d3f445e0f6f'),(31,'craft','m160925_113941_route_uri_parts','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','0b580a56-74a2-406b-8a88-116eabdc1926'),(32,'craft','m161006_205918_schemaVersion_not_null','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','d36369d8-8abb-462c-a393-417248ddfc52'),(33,'craft','m161007_130653_update_email_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','c06c2bbc-be43-4126-b509-2966ea89ad90'),(34,'craft','m161013_175052_newParentId','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','542f7192-275f-4394-844a-6eae29e7355e'),(35,'craft','m161021_102916_fix_recent_entries_widgets','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','3b3df87c-37a7-4dd3-88ac-458007a97456'),(36,'craft','m161021_182140_rename_get_help_widget','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','94c39d32-ba86-49ae-a5ac-06a4c8d083ea'),(37,'craft','m161025_000000_fix_char_columns','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','cb45a5eb-41fc-467e-96d1-fb1b61cd6eac'),(38,'craft','m161029_124145_email_message_languages','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','e8e80875-c27a-4657-bb58-1f7c4282971e'),(39,'craft','m161108_000000_new_version_format','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','ea42cfc4-2085-43e1-af3a-5a6d4c1df01e'),(40,'craft','m161109_000000_index_shuffle','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','c62be1a6-87bc-4d38-85df-361a0aba4e0c'),(41,'craft','m161122_185500_no_craft_app','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','65ad10c2-4e03-47b1-8f75-e44179f729f6'),(42,'craft','m161125_150752_clear_urlmanager_cache','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','b5a74322-0b03-4fa4-8ba7-7d16ee97e491'),(43,'craft','m161220_000000_volumes_hasurl_notnull','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','bcb52caa-3f0c-46c1-8092-776967f0551d'),(44,'craft','m170114_161144_udates_permission','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','95aa4ba8-4a04-44c3-bff8-1903c4316367'),(45,'craft','m170120_000000_schema_cleanup','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','41bac5b6-e912-440a-b993-47043b987259'),(46,'craft','m170126_000000_assets_focal_point','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','51741beb-0b9e-4ce2-ab65-a1c372bcca19'),(47,'craft','m170206_142126_system_name','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','0741bc9e-217e-40e6-bd74-40e3aef207c3'),(48,'craft','m170217_044740_category_branch_limits','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','092f40bb-71e3-4eb3-aa42-bed77665cf79'),(49,'craft','m170217_120224_asset_indexing_columns','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','2b71e896-87d3-4fbc-9208-068106c1e441'),(50,'craft','m170223_224012_plain_text_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','93ecd6b8-e812-4975-a6e5-8e5a39655c88'),(51,'craft','m170227_120814_focal_point_percentage','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','47910e97-1584-4e44-8f7f-4ff611c13236'),(52,'craft','m170228_171113_system_messages','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','a7ea062b-de4f-4418-9b70-7a705fe02b97'),(53,'craft','m170303_140500_asset_field_source_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','65cb41f6-11d6-47e2-a2c0-28718a95fda0'),(54,'craft','m170306_150500_asset_temporary_uploads','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','eea2828b-0c5f-45e5-87dd-4694784e133d'),(55,'craft','m170414_162429_rich_text_config_setting','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','f961387c-13c4-4e2d-b03c-946eb49172e2'),(56,'craft','m170523_190652_element_field_layout_ids','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','0fd583a6-de73-4c8b-b48b-b37a81dff22b'),(57,'craft','m170612_000000_route_index_shuffle','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','3ddf1530-0213-41ca-a046-fae124d71c84'),(58,'craft','m170621_195237_format_plugin_handles','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','2fb414ea-61f7-4817-ba67-cf75716263ba'),(59,'craft','m170630_161028_deprecation_changes','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','914a12b0-bae7-4120-af47-a44201e0ba0e'),(60,'craft','m170703_181539_plugins_table_tweaks','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','5fc4bfe3-9ce7-4765-a78e-cd94c866f0aa'),(61,'craft','m170704_134916_sites_tables','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','d6e906de-c161-4b77-ade4-9dace2c7ffbd'),(62,'craft','m170706_183216_rename_sequences','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','2a2db23d-cd85-4523-8d14-13199dde44be'),(63,'craft','m170707_094758_delete_compiled_traits','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','4546fb4d-b251-48b1-9549-a3d3dae2bced'),(64,'craft','m170731_190138_drop_asset_packagist','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','91eace9f-7b12-4ca7-8ca0-c2f4aeb02223'),(65,'craft','m170810_201318_create_queue_table','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','9ddf2fd8-2868-4000-b05e-c180061ca8d7'),(66,'craft','m170816_133741_delete_compiled_behaviors','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','1d4d7ccc-5b82-486a-b33b-faebb863ba7d'),(67,'craft','m170821_180624_deprecation_line_nullable','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','745f76b2-43e6-406f-afe4-8f23818acbe8'),(68,'craft','m170903_192801_longblob_for_queue_jobs','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','3698be78-625e-437f-afca-dc334fe0997e'),(69,'craft','m170914_204621_asset_cache_shuffle','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','713accd3-8e64-4813-86db-f711b8b88b5f'),(70,'craft','m171011_214115_site_groups','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','01ee093f-ea02-4e09-9938-31cabb0fd004'),(71,'craft','m171012_151440_primary_site','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','474f9766-f7a0-4989-8f45-fe1ac464dee0'),(72,'craft','m171013_142500_transform_interlace','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','a30fde9b-55b9-4e1d-83a4-d0a21b896804'),(73,'craft','m171016_092553_drop_position_select','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','1d1ac6c7-98c9-4e1e-b5dd-044f4712140b'),(74,'craft','m171016_221244_less_strict_translation_method','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','8acfaae2-f332-4cd8-80af-39a00266f0ae'),(75,'craft','m171107_000000_assign_group_permissions','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','1e4bad70-7719-40f0-8f8e-848a1159c3ab'),(76,'craft','m171117_000001_templatecache_index_tune','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','999d14e4-f207-43f2-8573-2f5e8410d386'),(77,'craft','m171126_105927_disabled_plugins','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','0f8d4f70-9a69-4ca4-a15d-9454a00f5cea'),(78,'craft','m171130_214407_craftidtokens_table','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','986030cb-2d4b-4543-9d54-f7cf4893d3bb'),(79,'craft','m171202_004225_update_email_settings','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','468686f5-ab32-4668-a73f-63a7be6a9b29'),(80,'craft','m171204_000001_templatecache_index_tune_deux','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','b2d21b84-73bd-4f6b-8fd0-bbfc3c037a55'),(81,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','e41bf129-cc10-4de4-b412-8ee8511a3909'),(82,'craft','m171218_143135_longtext_query_column','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','935a9634-64bd-4a9c-9de7-92d0a53bc91b'),(83,'craft','m171231_055546_environment_variables_to_aliases','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','6cc8c88d-5c81-49ec-8ccc-f1f727a3a505'),(84,'craft','m180113_153740_drop_users_archived_column','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','b859f0f3-6c91-475d-899b-caa95c7d7983'),(85,'craft','m180122_213433_propagate_entries_setting','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','8a3f47e5-066f-4da7-b7b6-ec485441e77e'),(86,'craft','m180124_230459_fix_propagate_entries_values','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','3145f774-302a-4bd4-9ddd-f80d79ec0b86'),(87,'craft','m180128_235202_set_tag_slugs','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','e66aee54-2296-44de-9a54-bf12494a7d10'),(88,'craft','m180202_185551_fix_focal_points','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','05daae94-44ac-4fe4-90c2-2dfe1df2fd11'),(89,'craft','m180217_172123_tiny_ints','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','35f5df6c-eb83-4bdb-a9cf-cc8aa42d56e8'),(90,'craft','m180321_233505_small_ints','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','6a237d06-a9a0-45ae-9d56-59ca9f730b09'),(91,'craft','m180328_115523_new_license_key_statuses','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','34069c27-a6c0-418d-8a90-7e344f503855'),(92,'craft','m180404_182320_edition_changes','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','d0470daa-0467-4b2a-ac69-7bc175ce5fd7'),(93,'craft','m180411_102218_fix_db_routes','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','4a3576a2-2f66-4826-9176-6fbef9a5f632'),(94,'craft','m180416_205628_resourcepaths_table','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','0971a958-0489-4f03-9155-696c6ca678de'),(95,'craft','m180418_205713_widget_cleanup','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','e18b78c9-09fe-4aa6-bc42-67e6d38a3574'),(96,'craft','m180824_193422_case_sensitivity_fixes','2018-08-29 22:59:32','2018-08-29 22:59:32','2018-08-29 22:59:32','9484f087-6c88-472c-aa63-ad89373c56a5'),(97,'plugin:redactor','m180430_204710_remove_old_plugins','2018-08-29 23:02:32','2018-08-29 23:02:32','2018-08-29 23:02:32','07687c39-6aff-4dd6-aeee-29ff8d13f5d7'),(98,'plugin:redactor','Install','2018-08-29 23:02:32','2018-08-29 23:02:32','2018-08-29 23:02:32','e1a3f332-168f-434d-bddf-7d8b3e208d20'),(99,'craft','m180901_151639_fix_matrixcontent_tables','2018-10-24 02:17:00','2018-10-24 02:17:00','2018-10-24 02:17:00','2b869d77-a935-4c40-b172-7ceda613360c'),(100,'craft','m181112_203955_sequences_table','2021-01-02 19:32:30','2021-01-02 19:32:30','2021-01-02 19:32:30','a1402a69-e11b-4d14-9ef4-61e8248577aa'),(101,'craft','m170630_161027_deprecation_line_nullable','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','b9030682-ecd7-4ff8-8fc4-e9acc194b5df'),(102,'craft','m180425_203349_searchable_fields','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','9e2fb525-c4a3-4a5c-972f-afc9330f9ded'),(103,'craft','m180516_153000_uids_in_field_settings','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','b84133ac-5e2b-4542-a9dc-d99f04e5efa5'),(104,'craft','m180517_173000_user_photo_volume_to_uid','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','9950d27b-d483-471a-ac14-a22d5d277bc0'),(105,'craft','m180518_173000_permissions_to_uid','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','d929b6d0-618e-4a47-abdc-048133734f53'),(106,'craft','m180520_173000_matrix_context_to_uids','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','01c6c8e8-84ef-4252-9c13-bb5ede725b17'),(107,'craft','m180521_172900_project_config_table','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','3cea2a0f-2299-419d-bf3b-fbf6f9e275ca'),(108,'craft','m180521_173000_initial_yml_and_snapshot','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','a2d5cb15-536f-4e23-b0eb-251365f9ebab'),(109,'craft','m180731_162030_soft_delete_sites','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','5f82068e-d3e4-426f-91c1-b6094eee4df6'),(110,'craft','m180810_214427_soft_delete_field_layouts','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','03d9c2ee-96d0-48a8-acc4-f41df02acf92'),(111,'craft','m180810_214439_soft_delete_elements','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','452d3181-fa77-4bfc-a902-a84374861825'),(112,'craft','m180904_112109_permission_changes','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','e47a0e90-79f4-4754-9ba5-a637baf0de61'),(113,'craft','m180910_142030_soft_delete_sitegroups','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','b5cd51e5-5cea-47cb-b72d-b37d89502a1a'),(114,'craft','m181011_160000_soft_delete_asset_support','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','e11fdf55-8840-4e53-a4e5-bd2fa4efccf2'),(115,'craft','m181016_183648_set_default_user_settings','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','fe83ad40-30e3-464a-9913-38876e4d29c7'),(116,'craft','m181017_225222_system_config_settings','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','56114016-c895-4614-8330-0dcc5f07424c'),(117,'craft','m181018_222343_drop_userpermissions_from_config','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','28ae2d7f-abd0-4719-9510-d0e0d7db8e5f'),(118,'craft','m181029_130000_add_transforms_routes_to_config','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','38857353-018e-44f8-86f3-9c0bf7935953'),(119,'craft','m181121_001712_cleanup_field_configs','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','27704217-83ff-4cb1-acdf-da5637be93b0'),(120,'craft','m181128_193942_fix_project_config','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','00c19aa7-3977-408f-912d-c3490a0567c5'),(121,'craft','m181130_143040_fix_schema_version','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','ff15db7c-602d-45d0-bac5-3faf13fdbd4e'),(122,'craft','m181211_143040_fix_entry_type_uids','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','f8bfdb37-fca9-450b-8349-914e417f189b'),(123,'craft','m181217_153000_fix_structure_uids','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','ac306005-d007-49d8-9587-8e671ef9ae82'),(124,'craft','m190104_152725_store_licensed_plugin_editions','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','cc3e1b0f-caf2-455c-8a3e-7dbd25be94a7'),(125,'craft','m190108_110000_cleanup_project_config','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','eb168f2a-03b5-48ea-90fd-0bdde88a1c96'),(126,'craft','m190108_113000_asset_field_setting_change','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','b39be758-de9a-428f-a3db-1e75ea2424fc'),(127,'craft','m190109_172845_fix_colspan','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','69c95d6b-c6cb-4db4-a491-e980b50da98d'),(128,'craft','m190110_150000_prune_nonexisting_sites','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','d1a5506e-8e3a-4672-a558-f81c60489695'),(129,'craft','m190110_214819_soft_delete_volumes','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','6cbdf55f-6358-4a48-b89b-b63f10fee314'),(130,'craft','m190112_124737_fix_user_settings','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','361eb614-ead7-48d6-9c97-00939ce789cb'),(131,'craft','m190112_131225_fix_field_layouts','2021-01-03 00:35:29','2021-01-03 00:35:29','2021-01-03 00:35:29','5407f80c-28a1-4793-bdbd-66ed9c042bbe'),(132,'craft','m190112_201010_more_soft_deletes','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','97412f8b-cce4-4262-8c2b-ca9d2d785845'),(133,'craft','m190114_143000_more_asset_field_setting_changes','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','8aa0dd2b-9e6a-4ee1-b35c-11251788068c'),(134,'craft','m190121_120000_rich_text_config_setting','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','a8e89d81-63b9-4620-b24d-213dba0f6795'),(135,'craft','m190125_191628_fix_email_transport_password','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','f0e9e105-cab9-45ec-b505-d2f722bdac56'),(136,'craft','m190128_181422_cleanup_volume_folders','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','f4fc36db-c70b-4640-b884-96e61a56dc32'),(137,'craft','m190205_140000_fix_asset_soft_delete_index','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','fa787225-8c83-4707-8b56-b1eef1a992bc'),(138,'craft','m190218_143000_element_index_settings_uid','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','e433a987-996e-44d4-9bd1-107a597db427'),(139,'craft','m190312_152740_element_revisions','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','74315762-596d-4bda-9413-39f8d2ff4195'),(140,'craft','m190327_235137_propagation_method','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','43c8d810-4ad7-4b4a-a713-1edcf0e880d8'),(141,'craft','m190401_223843_drop_old_indexes','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','1b29eec1-b14b-43be-9a81-1920745d2c50'),(142,'craft','m190416_014525_drop_unique_global_indexes','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','f48457e5-e375-4bbd-937e-0fa3a2bdc5f0'),(143,'craft','m190417_085010_add_image_editor_permissions','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','26c2e368-9369-4597-8674-bf110e728283'),(144,'craft','m190502_122019_store_default_user_group_uid','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','1f45ecec-be8c-4d90-8acf-715549a07b94'),(145,'craft','m190504_150349_preview_targets','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','be2d99e8-71f1-495b-b21b-3abd3ab94f8a'),(146,'craft','m190516_184711_job_progress_label','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','bd8f3c59-e0ae-48ac-a782-6a03b9d0031b'),(147,'craft','m190523_190303_optional_revision_creators','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','9fb7b2f4-9727-4793-a419-4bfbf5a4f178'),(148,'craft','m190529_204501_fix_duplicate_uids','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','d4e12ffc-ef70-429d-81e7-0b496f4767cd'),(149,'craft','m190605_223807_unsaved_drafts','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','2e69639e-0af3-426c-8ee4-6fffc04bf599'),(150,'craft','m190607_230042_entry_revision_error_tables','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','fb1ed254-e91b-456d-b033-4819f93cf950'),(151,'craft','m190608_033429_drop_elements_uid_idx','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','41943599-3a4c-4d31-bb99-4dcecbedbf23'),(152,'craft','m190617_164400_add_gqlschemas_table','2021-01-03 00:35:30','2021-01-03 00:35:30','2021-01-03 00:35:30','13a6f8d6-0ce8-499a-88eb-d096566ccb58'),(153,'craft','m190624_234204_matrix_propagation_method','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','696f3cfa-9160-4a1b-b3fd-9641cbf3d028'),(154,'craft','m190711_153020_drop_snapshots','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','0a860396-e559-44d6-b0d2-812f16d63197'),(155,'craft','m190712_195914_no_draft_revisions','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','87b921ac-3e56-434c-85f2-ccf9d3e61d6d'),(156,'craft','m190723_140314_fix_preview_targets_column','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','15be345e-acab-48e5-8141-f94320ae8e58'),(157,'craft','m190820_003519_flush_compiled_templates','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','52fb0cd9-2759-47e5-a800-eb674011365f'),(158,'craft','m190823_020339_optional_draft_creators','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','943256e8-7e7a-4f74-a428-f355c8ece90e'),(159,'craft','m190913_152146_update_preview_targets','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','86ab66a2-b5d2-4f5e-abd5-667616ba38ac'),(160,'craft','m191107_122000_add_gql_project_config_support','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','d7723667-108d-46a1-bd70-04a848f35d85'),(161,'craft','m191204_085100_pack_savable_component_settings','2021-01-03 00:35:31','2021-01-03 00:35:31','2021-01-03 00:35:31','54443327-4bb0-4722-b301-36d44758e071'),(162,'craft','m191206_001148_change_tracking','2021-01-03 00:35:32','2021-01-03 00:35:32','2021-01-03 00:35:32','094a5618-5bad-404d-89dc-8feee3306f36'),(163,'craft','m191216_191635_asset_upload_tracking','2021-01-03 00:35:32','2021-01-03 00:35:32','2021-01-03 00:35:32','8fdee3a6-d54e-4738-abdd-2a015cf2e55e'),(164,'craft','m191222_002848_peer_asset_permissions','2021-01-03 00:35:32','2021-01-03 00:35:32','2021-01-03 00:35:32','bc5d0198-ac13-4dda-9788-29d342f19e03'),(165,'craft','m200127_172522_queue_channels','2021-01-03 00:35:32','2021-01-03 00:35:32','2021-01-03 00:35:32','a201f404-c273-43c9-ab3f-88363c297ee9'),(166,'craft','m200211_175048_truncate_element_query_cache','2021-01-03 00:35:33','2021-01-03 00:35:33','2021-01-03 00:35:33','00799474-bf73-4c84-92a5-3d4424a7dc77'),(167,'craft','m200213_172522_new_elements_index','2021-01-03 00:35:33','2021-01-03 00:35:33','2021-01-03 00:35:33','d868b117-8cc1-490e-940e-d440c6b4d621'),(168,'craft','m200228_195211_long_deprecation_messages','2021-01-03 00:35:33','2021-01-03 00:35:33','2021-01-03 00:35:33','02beaf81-ecb9-4293-8734-17bface8627b'),(169,'craft','m200306_054652_disabled_sites','2021-01-03 00:35:36','2021-01-03 00:35:36','2021-01-03 00:35:36','00f59b63-e00b-454c-a0a9-a393d3e56d51'),(170,'craft','m200522_191453_clear_template_caches','2021-01-03 00:35:36','2021-01-03 00:35:36','2021-01-03 00:35:36','a2623af2-0d9d-4d51-934c-ae659c835c4d'),(171,'craft','m200606_231117_migration_tracks','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','12570f91-2dd0-4d49-bb2c-dc16726f80f4'),(172,'craft','m200619_215137_title_translation_method','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','a169b01b-e271-4ab1-a559-30e07e03ca60'),(173,'craft','m200620_005028_user_group_descriptions','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','41d38ab0-2d18-4d24-b887-878204076920'),(174,'craft','m200620_230205_field_layout_changes','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','de26bc50-d8fe-4411-bb5a-6cfdc8aa5664'),(175,'craft','m200625_131100_move_entrytypes_to_top_project_config','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','7be60511-943c-4e1c-9c97-7e2a0eda1f8b'),(176,'craft','m200629_112700_remove_project_config_legacy_files','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','c999f46d-7606-4b20-9962-816e85d1ba15'),(177,'craft','m200630_183000_drop_configmap','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','a9bb5a3a-d8f6-455a-a2da-abd3169d55ce'),(178,'craft','m200715_113400_transform_index_error_flag','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','da0dbf71-c67d-401b-8c35-bb1c301104ca'),(179,'craft','m200716_110900_replace_file_asset_permissions','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','b6f85c73-9d0f-49e3-9f95-fe1df5697423'),(180,'craft','m200716_153800_public_token_settings_in_project_config','2021-01-03 00:35:38','2021-01-03 00:35:38','2021-01-03 00:35:38','3dbd3426-2502-4f34-8bda-3da13cb2ac55'),(181,'craft','m200720_175543_drop_unique_constraints','2021-01-03 00:35:40','2021-01-03 00:35:40','2021-01-03 00:35:40','82812c8a-3fbc-4885-909f-8ffdb2850a80'),(182,'craft','m200825_051217_project_config_version','2021-01-03 00:35:40','2021-01-03 00:35:40','2021-01-03 00:35:40','abe3defc-a110-4f85-b71e-0ce484d18cf4'),(183,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2021-01-03 00:59:43','2021-01-03 00:59:43','2021-01-03 00:59:43','fc1378db-6f37-4979-aefe-d925928f5892');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_plugins` VALUES (1,'element-api','2.5.4','1.0.0','unknown',NULL,'2018-08-29 23:01:59','2018-08-29 23:01:59','2022-10-19 03:51:02','ad6bdb13-d1da-4e98-a332-23d15a3763ba'),(2,'redactor','2.1.6','2.3.0','unknown',NULL,'2018-08-29 23:02:32','2018-08-29 23:02:32','2022-10-19 03:51:02','040ccf56-fc72-4aac-b698-7c61d983292b');
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_projectconfig`
--

LOCK TABLES `craft_projectconfig` WRITE;
/*!40000 ALTER TABLE `craft_projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_projectconfig` VALUES ('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.fieldLayouts.3e70a6a8-9132-4444-8f9d-c8f7bb539fef.tabs.0.fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.required','false'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.fieldLayouts.3e70a6a8-9132-4444-8f9d-c8f7bb539fef.tabs.0.fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.sortOrder','1'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.fieldLayouts.3e70a6a8-9132-4444-8f9d-c8f7bb539fef.tabs.0.name','\"Content\"'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.fieldLayouts.3e70a6a8-9132-4444-8f9d-c8f7bb539fef.tabs.0.sortOrder','1'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.handle','\"entity\"'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.name','\"Entity\"'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.hasUrls','true'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.template','\"entity/_category\"'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.uriFormat','\"entity/{slug}\"'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.structure.maxLevels','1'),('categoryGroups.492f2972-c006-463a-bc0a-e5c717b071ad.structure.uid','\"ed75a22a-57ca-4501-9529-4cd9bca26fbc\"'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.fieldLayouts.16ef1415-8834-46a5-b62e-dc0f7ef198c3.tabs.0.fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.required','false'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.fieldLayouts.16ef1415-8834-46a5-b62e-dc0f7ef198c3.tabs.0.fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.sortOrder','1'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.fieldLayouts.16ef1415-8834-46a5-b62e-dc0f7ef198c3.tabs.0.fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.required','false'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.fieldLayouts.16ef1415-8834-46a5-b62e-dc0f7ef198c3.tabs.0.fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.sortOrder','2'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.fieldLayouts.16ef1415-8834-46a5-b62e-dc0f7ef198c3.tabs.0.name','\"Common\"'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.fieldLayouts.16ef1415-8834-46a5-b62e-dc0f7ef198c3.tabs.0.sortOrder','1'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.handle','\"projectCategory\"'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.name','\"Project Category\"'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.hasUrls','true'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.template','\"project-category/_category\"'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.uriFormat','\"project-category/{slug}\"'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.structure.maxLevels','null'),('categoryGroups.b1044122-fed0-47d2-ad0e-ac24c940dcb6.structure.uid','\"bf223d46-0591-4ea2-bbc4-9e73d73d77f7\"'),('dateModified','1609635583'),('email.fromEmail','\"wfifer@gmail.com\"'),('email.fromName','\"Portfolio\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.0.instructions','null'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.0.label','\"Title\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.1.fieldUid','\"28ad0220-2985-4dd6-b69c-d2bba848f18c\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.1.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.2.fieldUid','\"dd3b32a6-93ce-42ad-9d56-f42364868459\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.2.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.3.fieldUid','\"e92faebe-fac6-4f3d-94c5-98416b9596fe\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.3.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.4.fieldUid','\"50b5a7ca-6355-4c94-bc52-14eb2ba78593\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.4.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.5.fieldUid','\"3017f74c-e2c5-4e6b-960e-c8296b8e86f1\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.5.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.5.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.6.fieldUid','\"f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.6.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.6.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.7.fieldUid','\"a6bdea55-c12e-4a2b-bef4-8db5348d162c\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.7.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.7.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.8.fieldUid','\"a430daeb-1368-4cb9-996c-f43a38b978b1\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.8.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.8.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.9.fieldUid','\"b5088f1a-7338-47ec-83a8-64e2b5873b29\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.9.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.elements.9.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.name','\"Project\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.0.sortOrder','1'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.elements.0.fieldUid','\"ad268a11-e70c-4b59-a8db-5ba3121b2268\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.elements.0.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.elements.1.fieldUid','\"a3097e79-2eca-45a0-9de1-532129638764\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.elements.1.required','false'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.name','\"Details\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.fieldLayouts.b20c17fa-2461-4eb2-98c4-7f40b8d94417.tabs.1.sortOrder','2'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.handle','\"projects\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.hasTitleField','true'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.name','\"Projects\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.section','\"04258b8a-06cf-4637-a5a5-0d201b72dbd6\"'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.sortOrder','1'),('entryTypes.30e4ec7e-c20c-406b-9d25-8bd28cbccb62.titleFormat','null'),('fieldGroups.1601ca5d-3aa7-42f2-a898-540bbb721690.name','\"Common\"'),('fieldGroups.3a27efe0-652c-4a93-afc7-755455810a60.name','\"Project\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.contentColumnType','\"string\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.handle','\"heroImage\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.instructions','\"\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.name','\"Hero Image\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.searchable','true'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.allowedKinds.0','\"image\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.defaultUploadLocationSource','\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.defaultUploadLocationSubpath','\"hero\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.limit','\"1\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.localizeRelations','false'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.restrictFiles','\"1\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.selectionLabel','\"\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.singleUploadLocationSource','\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.singleUploadLocationSubpath','\"\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.source','null'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.sources','\"*\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.targetSiteId','null'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.useSingleFolder','\"\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.settings.viewMode','\"list\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.translationKeyFormat','null'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.translationMethod','\"site\"'),('fields.28ad0220-2985-4dd6-b69c-d2bba848f18c.type','\"craft\\\\fields\\\\Assets\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.contentColumnType','\"text\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.handle','\"website\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.instructions','\"\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.name','\"Website\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.searchable','true'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.settings.charLimit','\"\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.settings.code','\"\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.settings.columnType','\"text\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.settings.initialRows','\"4\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.settings.multiline','\"\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.settings.placeholder','\"\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.translationKeyFormat','null'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.translationMethod','\"none\"'),('fields.3017f74c-e2c5-4e6b-960e-c8296b8e86f1.type','\"craft\\\\fields\\\\PlainText\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.contentColumnType','\"string\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.handle','\"thumbnail\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.instructions','\"\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.name','\"Thumbnail\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.searchable','true'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.allowedKinds.0','\"image\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.defaultUploadLocationSource','\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.defaultUploadLocationSubpath','\"thumbnail\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.limit','\"1\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.localizeRelations','false'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.restrictFiles','\"1\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.selectionLabel','\"\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.singleUploadLocationSource','\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.singleUploadLocationSubpath','\"\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.source','null'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.sources','\"*\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.targetSiteId','null'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.useSingleFolder','\"\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.settings.viewMode','\"list\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.translationKeyFormat','null'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.translationMethod','\"site\"'),('fields.50b5a7ca-6355-4c94-bc52-14eb2ba78593.type','\"craft\\\\fields\\\\Assets\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.contentColumnType','\"text\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.fieldGroup','\"1601ca5d-3aa7-42f2-a898-540bbb721690\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.handle','\"fontIcon\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.instructions','\"\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.name','\"Font Icon\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.searchable','true'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.settings.charLimit','\"\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.settings.code','\"\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.settings.columnType','\"text\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.settings.initialRows','\"4\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.settings.multiline','\"\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.settings.placeholder','\"\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.translationKeyFormat','null'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.translationMethod','\"none\"'),('fields.5a963a89-7fa0-4b36-a2a2-41b8c32576d0.type','\"craft\\\\fields\\\\PlainText\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.contentColumnType','\"string\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.handle','\"pageContent\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.instructions','\"\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.name','\"Page Content\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.searchable','true'),('fields.a3097e79-2eca-45a0-9de1-532129638764.settings.contentTable','\"{{%matrixcontent_pagecontent}}\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.settings.localizeBlocks','false'),('fields.a3097e79-2eca-45a0-9de1-532129638764.settings.maxBlocks','\"\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.settings.minBlocks','\"\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.translationKeyFormat','null'),('fields.a3097e79-2eca-45a0-9de1-532129638764.translationMethod','\"site\"'),('fields.a3097e79-2eca-45a0-9de1-532129638764.type','\"craft\\\\fields\\\\Matrix\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.contentColumnType','\"string\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.handle','\"projectCategory\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.instructions','\"\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.name','\"Project Category\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.searchable','true'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.branchLimit','\"\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.limit','null'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.localizeRelations','false'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.selectionLabel','\"\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.source','\"group:b1044122-fed0-47d2-ad0e-ac24c940dcb6\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.sources','\"*\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.targetSiteId','null'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.settings.viewMode','null'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.translationKeyFormat','null'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.translationMethod','\"site\"'),('fields.a430daeb-1368-4cb9-996c-f43a38b978b1.type','\"craft\\\\fields\\\\Categories\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.contentColumnType','\"string\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.handle','\"client\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.instructions','\"\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.name','\"Client\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.searchable','true'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.branchLimit','\"\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.limit','null'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.localizeRelations','false'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.selectionLabel','\"\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.source','\"group:492f2972-c006-463a-bc0a-e5c717b071ad\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.sources','\"*\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.targetSiteId','null'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.settings.viewMode','null'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.translationKeyFormat','null'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.translationMethod','\"site\"'),('fields.a6bdea55-c12e-4a2b-bef4-8db5348d162c.type','\"craft\\\\fields\\\\Categories\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.contentColumnType','\"string\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.fieldGroup','\"1601ca5d-3aa7-42f2-a898-540bbb721690\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.handle','\"icon\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.instructions','\"\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.name','\"Icon\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.searchable','true'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.allowedKinds.0','\"image\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.defaultUploadLocationSource','\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.defaultUploadLocationSubpath','\"icon\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.limit','\"1\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.localizeRelations','false'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.restrictFiles','\"1\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.selectionLabel','\"\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.singleUploadLocationSource','\"volume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.singleUploadLocationSubpath','\"\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.source','null'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.sources','\"*\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.targetSiteId','null'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.useSingleFolder','\"\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.settings.viewMode','\"list\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.translationKeyFormat','null'),('fields.aae80770-f8da-4b57-8e50-67451222446d.translationMethod','\"site\"'),('fields.aae80770-f8da-4b57-8e50-67451222446d.type','\"craft\\\\fields\\\\Assets\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.contentColumnType','\"text\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.handle','\"intro\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.instructions','\"\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.name','\"Intro\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.searchable','true'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.availableTransforms','\"*\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.availableVolumes','\"*\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.columnType','\"text\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.purifierConfig','\"\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.purifyHtml','\"1\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.redactorConfig','\"Standard.json\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.removeEmptyTags','\"1\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.removeInlineStyles','\"1\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.settings.removeNbsp','\"1\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.translationKeyFormat','null'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.translationMethod','\"none\"'),('fields.ad268a11-e70c-4b59-a8db-5ba3121b2268.type','\"craft\\\\redactor\\\\Field\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.contentColumnType','\"boolean\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.handle','\"featured\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.instructions','\"\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.name','\"Featured\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.searchable','true'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.settings.default','\"1\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.translationKeyFormat','null'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.translationMethod','\"none\"'),('fields.b5088f1a-7338-47ec-83a8-64e2b5873b29.type','\"craft\\\\fields\\\\Lightswitch\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.contentColumnType','\"string\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.fieldGroup','\"1601ca5d-3aa7-42f2-a898-540bbb721690\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.handle','\"fontIconStyle\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.instructions','\"\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.name','\"Font Icon Style\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.searchable','true'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.0.__assoc__.0.0','\"default\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.0.__assoc__.0.1','\"1\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.0.__assoc__.1.0','\"label\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.0.__assoc__.1.1','\"Solid\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.0.__assoc__.2.0','\"value\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.0.__assoc__.2.1','\"fas\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.1.__assoc__.0.0','\"default\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.1.__assoc__.0.1','\"\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.1.__assoc__.1.0','\"label\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.1.__assoc__.1.1','\"Regular\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.1.__assoc__.2.0','\"value\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.1.__assoc__.2.1','\"far\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.2.__assoc__.0.0','\"default\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.2.__assoc__.0.1','\"\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.2.__assoc__.1.0','\"label\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.2.__assoc__.1.1','\"Light\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.2.__assoc__.2.0','\"value\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.2.__assoc__.2.1','\"fal\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.3.__assoc__.0.0','\"default\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.3.__assoc__.0.1','\"\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.3.__assoc__.1.0','\"label\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.3.__assoc__.1.1','\"Duotone\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.3.__assoc__.2.0','\"value\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.3.__assoc__.2.1','\"fad\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.4.__assoc__.0.0','\"default\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.4.__assoc__.0.1','\"\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.4.__assoc__.1.0','\"label\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.4.__assoc__.1.1','\"Brands\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.4.__assoc__.2.0','\"value\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.settings.options.4.__assoc__.2.1','\"fab\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.translationKeyFormat','null'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.translationMethod','\"none\"'),('fields.bc7e7a7e-4f87-417f-ae4d-ee4d13d54c91.type','\"craft\\\\fields\\\\Dropdown\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.contentColumnType','\"string\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.handle','\"heroBackground\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.instructions','\"\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.name','\"Hero Background\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.searchable','true'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.settings.contentTable','\"{{%matrixcontent_herobackground}}\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.settings.localizeBlocks','false'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.settings.maxBlocks','\"1\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.settings.minBlocks','\"\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.translationKeyFormat','null'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.translationMethod','\"site\"'),('fields.dd3b32a6-93ce-42ad-9d56-f42364868459.type','\"craft\\\\fields\\\\Matrix\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.contentColumnType','\"string\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.handle','\"projectLayers\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.instructions','\"\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.name','\"Project Layers\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.searchable','true'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.settings.contentTable','\"{{%matrixcontent_projectlayers}}\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.settings.localizeBlocks','false'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.settings.maxBlocks','\"\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.settings.minBlocks','\"\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.translationKeyFormat','null'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.translationMethod','\"site\"'),('fields.e92faebe-fac6-4f3d-94c5-98416b9596fe.type','\"craft\\\\fields\\\\Matrix\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.contentColumnType','\"string\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.fieldGroup','\"3a27efe0-652c-4a93-afc7-755455810a60\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.handle','\"collaborator\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.instructions','\"\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.name','\"Collaborator\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.searchable','true'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.branchLimit','\"\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.limit','null'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.localizeRelations','false'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.selectionLabel','\"\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.source','\"group:492f2972-c006-463a-bc0a-e5c717b071ad\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.sources','\"*\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.targetSiteId','null'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.settings.viewMode','null'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.translationKeyFormat','null'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.translationMethod','\"site\"'),('fields.f8eddcec-a7b6-4d31-b3f1-ecfbbe5172cb.type','\"craft\\\\fields\\\\Categories\"'),('graphql.publicToken.enabled','false'),('graphql.publicToken.expiryDate','null'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.format','null'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.handle','\"masked\"'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.height','800'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.interlace','\"none\"'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.mode','\"crop\"'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.name','\"Masked\"'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.position','\"center-center\"'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.quality','30'),('imageTransforms.4a27c079-071e-4be9-a104-71c91786949b.width','1200'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.format','null'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.handle','\"wysiwyg\"'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.height','null'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.interlace','\"none\"'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.mode','\"crop\"'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.name','\"WYSIWYG\"'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.position','\"center-center\"'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.quality','82'),('imageTransforms.cddab5be-3121-4dc8-ac07-27d48b71edde.width','960'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.format','null'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.handle','\"thumbnail\"'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.height','280'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.interlace','\"none\"'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.mode','\"crop\"'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.name','\"Thumbnail\"'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.position','\"center-center\"'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.quality','82'),('imageTransforms.f1dd0f6a-7c8c-4701-adc3-16803a4471bb.width','280'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.field','\"e92faebe-fac6-4f3d-94c5-98416b9596fe\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fieldLayouts.d7b35595-a2d6-4f58-8642-de0487518ecd.tabs.0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.required','false'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fieldLayouts.d7b35595-a2d6-4f58-8642-de0487518ecd.tabs.0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.sortOrder','1'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fieldLayouts.d7b35595-a2d6-4f58-8642-de0487518ecd.tabs.0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.required','false'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fieldLayouts.d7b35595-a2d6-4f58-8642-de0487518ecd.tabs.0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.sortOrder','2'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fieldLayouts.d7b35595-a2d6-4f58-8642-de0487518ecd.tabs.0.name','\"Content\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fieldLayouts.d7b35595-a2d6-4f58-8642-de0487518ecd.tabs.0.sortOrder','1'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.contentColumnType','\"string\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.fieldGroup','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.handle','\"image\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.instructions','\"\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.name','\"Image\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.searchable','true'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.allowedKinds.0','\"image\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.defaultUploadLocationSource','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.defaultUploadLocationSubpath','\"\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.limit','\"1\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.localizeRelations','false'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.restrictFiles','\"1\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.selectionLabel','\"\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.singleUploadLocationSource','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.singleUploadLocationSubpath','\"\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.source','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.sources','\"*\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.targetSiteId','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.useSingleFolder','\"\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.settings.viewMode','\"list\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.translationKeyFormat','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.translationMethod','\"site\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.37957ba4-44c0-455f-acb8-9a018e7bcf53.type','\"craft\\\\fields\\\\Assets\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.contentColumnType','\"smallint(2)\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.fieldGroup','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.handle','\"depth\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.instructions','\"Negative will appear behind project hero. \"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.name','\"Depth\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.searchable','true'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.settings.decimals','0'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.settings.defaultValue','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.settings.max','\"10\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.settings.min','\"-10\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.settings.size','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.translationKeyFormat','null'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.translationMethod','\"none\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.fields.5f203469-9c0d-4c6b-9bfd-1e70bb80095e.type','\"craft\\\\fields\\\\Number\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.handle','\"layer\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.name','\"Layer\"'),('matrixBlockTypes.b5e9da4e-d9d4-4e07-afa4-1416703646c0.sortOrder','1'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.field','\"dd3b32a6-93ce-42ad-9d56-f42364868459\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fieldLayouts.d6ebade8-f5dd-4ed1-8539-584aa0c083cd.tabs.0.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.required','false'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fieldLayouts.d6ebade8-f5dd-4ed1-8539-584aa0c083cd.tabs.0.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.sortOrder','2'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fieldLayouts.d6ebade8-f5dd-4ed1-8539-584aa0c083cd.tabs.0.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.required','false'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fieldLayouts.d6ebade8-f5dd-4ed1-8539-584aa0c083cd.tabs.0.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.sortOrder','1'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fieldLayouts.d6ebade8-f5dd-4ed1-8539-584aa0c083cd.tabs.0.name','\"Content\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fieldLayouts.d6ebade8-f5dd-4ed1-8539-584aa0c083cd.tabs.0.sortOrder','1'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.contentColumnType','\"text\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.fieldGroup','null'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.handle','\"stops\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.instructions','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.name','\"Stops\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.searchable','true'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.addRowLabel','\"Add a row\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.0','\"col1\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.0.0','\"handle\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.0.1','\"position\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.1.0','\"heading\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.1.1','\"Position\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.2.0','\"type\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.2.1','\"number\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.3.0','\"width\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.0.1.__assoc__.3.1','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.0','\"col2\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.0.0','\"handle\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.0.1','\"color\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.1.0','\"heading\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.1.1','\"Color\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.2.0','\"type\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.2.1','\"singleline\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.3.0','\"width\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columns.__assoc__.1.1.__assoc__.3.1','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.columnType','\"text\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.defaults.__assoc__.0.0','\"row1\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.defaults.__assoc__.0.1.__assoc__.0.0','\"col1\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.defaults.__assoc__.0.1.__assoc__.0.1','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.defaults.__assoc__.0.1.__assoc__.1.0','\"col2\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.defaults.__assoc__.0.1.__assoc__.1.1','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.maxRows','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.settings.minRows','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.translationKeyFormat','null'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.translationMethod','\"none\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.11b64d24-f280-458c-a5f0-8832a3e9331d.type','\"craft\\\\fields\\\\Table\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.contentColumnType','\"text\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.fieldGroup','null'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.handle','\"angle\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.instructions','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.name','\"Angle\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.searchable','true'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.settings.charLimit','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.settings.code','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.settings.columnType','\"text\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.settings.initialRows','\"4\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.settings.multiline','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.settings.placeholder','\"\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.translationKeyFormat','null'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.translationMethod','\"none\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.fields.eda0bb13-fa15-4fd1-be40-93113a86ebb9.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.handle','\"background\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.name','\"Background\"'),('matrixBlockTypes.d012cae4-70de-460d-bfae-c1fad53523a4.sortOrder','1'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.field','\"a3097e79-2eca-45a0-9de1-532129638764\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fieldLayouts.59a7a1d7-b45e-478b-9aac-0f33b5193ca2.tabs.0.fields.3a1a6899-2491-4f99-91d5-45690288cbef.required','false'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fieldLayouts.59a7a1d7-b45e-478b-9aac-0f33b5193ca2.tabs.0.fields.3a1a6899-2491-4f99-91d5-45690288cbef.sortOrder','1'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fieldLayouts.59a7a1d7-b45e-478b-9aac-0f33b5193ca2.tabs.0.name','\"Content\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fieldLayouts.59a7a1d7-b45e-478b-9aac-0f33b5193ca2.tabs.0.sortOrder','1'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.contentColumnType','\"text\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.fieldGroup','null'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.handle','\"body\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.instructions','\"\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.name','\"Body\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.searchable','true'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.availableTransforms.0','\"3\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.availableVolumes','\"*\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.columnType','\"text\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.purifierConfig','\"\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.purifyHtml','\"\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.redactorConfig','\"Standard.json\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.removeEmptyTags','\"\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.removeInlineStyles','\"\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.settings.removeNbsp','\"\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.translationKeyFormat','null'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.translationMethod','\"none\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.fields.3a1a6899-2491-4f99-91d5-45690288cbef.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.handle','\"wysiwyg\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.name','\"WYSIWYG\"'),('matrixBlockTypes.ebf81a2b-eadd-4fe5-bc7e-2cf52b3fbfac.sortOrder','1'),('plugins.element-api.enabled','\"1\"'),('plugins.element-api.licenseKey','null'),('plugins.element-api.schemaVersion','\"1.0.0\"'),('plugins.element-api.settings','null'),('plugins.redactor.enabled','\"1\"'),('plugins.redactor.licenseKey','null'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.redactor.settings','null'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.enableVersioning','true'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.handle','\"projects\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.name','\"Projects\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.previewTargets.0.label','\"Primary entry page\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.previewTargets.0.urlFormat','\"{url}\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.propagationMethod','\"all\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.enabledByDefault','true'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.hasUrls','true'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.template','\"index\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.siteSettings.1ca609a1-4ff3-4e3c-9780-72a3e090292b.uriFormat','\"projects/{slug}\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.structure.maxLevels','1'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.structure.uid','\"689e7abf-4fa6-43a2-b14e-1fcb7529f2e0\"'),('sections.04258b8a-06cf-4637-a5a5-0d201b72dbd6.type','\"structure\"'),('siteGroups.c0689416-79ae-4ca4-815a-d892be24323f.name','\"Portfolio\"'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.baseUrl','\"@web/\"'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.handle','\"default\"'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.hasUrls','true'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.language','\"en-US\"'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.name','\"Portfolio\"'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.primary','true'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.siteGroup','\"c0689416-79ae-4ca4-815a-d892be24323f\"'),('sites.1ca609a1-4ff3-4e3c-9780-72a3e090292b.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Portfolio\"'),('system.schemaVersion','\"3.5.13\"'),('system.timeZone','\"America/New_York\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','null'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1.handle','\"general\"'),('volumes.7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1.hasUrls','true'),('volumes.7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1.name','\"General\"'),('volumes.7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1.settings.path','\"assets/uploads\"'),('volumes.7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1.sortOrder','1'),('volumes.7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1.type','\"craft\\\\volumes\\\\Local\"'),('volumes.7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1.url','\"https://api.willfifer.com/assets/uploads\"');
/*!40000 ALTER TABLE `craft_projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_queue`
--

LOCK TABLES `craft_queue` WRITE;
/*!40000 ALTER TABLE `craft_queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_relations` VALUES (156,6,45,NULL,48,1,'2018-10-19 19:09:37','2018-10-19 19:09:37','fc79a84b-30af-459c-b357-86648c776798'),(157,15,45,NULL,47,1,'2018-10-19 19:09:37','2018-10-19 19:09:37','0de0770a-3f57-42eb-bafa-752f22194446'),(158,11,45,NULL,12,1,'2018-10-19 19:09:37','2018-10-19 19:09:37','9fac9bf9-ee12-4ac0-95c9-69bef0e349b0'),(252,6,15,NULL,13,1,'2018-10-24 19:33:39','2018-10-24 19:33:39','b941300d-0eb5-4b2b-a69d-ab356019cc8f'),(253,15,15,NULL,23,1,'2018-10-24 19:33:39','2018-10-24 19:33:39','06710a56-eea6-4a1a-8dae-ce8f53d51c3f'),(254,1,15,NULL,14,1,'2018-10-24 19:33:39','2018-10-24 19:33:39','40dfa0c0-797d-468d-9a0c-4a5dd7093cff'),(255,18,15,NULL,53,1,'2018-10-24 19:33:39','2018-10-24 19:33:39','64fbe3ae-93db-4a60-b5dd-41979867b425'),(256,11,15,NULL,5,1,'2018-10-24 19:33:39','2018-10-24 19:33:39','90548b42-937e-4c2b-a4d1-9aa436c6c0ef'),(287,6,18,NULL,17,1,'2018-10-24 20:20:29','2018-10-24 20:20:29','53bc1bc9-60be-4b3c-97ed-d64ee7d5a6ae'),(288,15,18,NULL,25,1,'2018-10-24 20:20:29','2018-10-24 20:20:29','118e2154-6743-4310-bb45-45fad87da837'),(289,1,18,NULL,14,1,'2018-10-24 20:20:29','2018-10-24 20:20:29','991ad05a-f5b9-4fe2-81cc-1af0f915173d'),(290,18,18,NULL,56,1,'2018-10-24 20:20:29','2018-10-24 20:20:29','5a099dc4-58df-4c8d-a9dc-64a0c5887688'),(291,11,18,NULL,5,1,'2018-10-24 20:20:29','2018-10-24 20:20:29','a400f909-17ea-4c21-8ef1-6fa5cba01683'),(298,6,27,NULL,26,1,'2018-10-24 20:30:42','2018-10-24 20:30:42','3b399f62-aa17-45d5-8bb6-1b9ad021062f'),(299,15,27,NULL,38,1,'2018-10-24 20:30:42','2018-10-24 20:30:42','9fdfad15-85df-4085-b66c-4ddeff8f44b8'),(300,1,27,NULL,14,1,'2018-10-24 20:30:42','2018-10-24 20:30:42','238d6a63-76c1-491c-9c81-f2428207b4c1'),(301,18,27,NULL,52,1,'2018-10-24 20:30:42','2018-10-24 20:30:42','49267df3-19d1-41d5-bf47-030b6f66c70a'),(302,11,27,NULL,5,1,'2018-10-24 20:30:42','2018-10-24 20:30:42','ffc71ddd-cfc9-433d-ba90-68a561a6ef15'),(385,6,30,NULL,29,1,'2018-11-15 19:29:56','2018-11-15 19:29:56','c761cf9e-b01e-4701-9e58-820de9614762'),(386,15,30,NULL,41,1,'2018-11-15 19:29:57','2018-11-15 19:29:57','14bda1ca-63bb-40d4-862a-1063c77581c1'),(387,1,30,NULL,14,1,'2018-11-15 19:29:57','2018-11-15 19:29:57','b9ee0aa1-bedc-42a4-940e-93069c8d1f9c'),(388,18,30,NULL,55,1,'2018-11-15 19:29:57','2018-11-15 19:29:57','e4052749-7c8a-479a-9a08-1fc517bf2d10'),(389,11,30,NULL,5,1,'2018-11-15 19:29:57','2018-11-15 19:29:57','2e887aba-e73b-4658-909f-4310b2a8ae1f'),(390,11,30,NULL,8,2,'2018-11-15 19:29:57','2018-11-15 19:29:57','d4ea6059-ea8b-4898-8ddf-fc1d0afaabab'),(445,6,36,NULL,35,1,'2020-12-21 20:37:50','2020-12-21 20:37:50','9923fae6-4e21-42f4-8c40-d910adb80dfb'),(446,15,36,NULL,40,1,'2020-12-21 20:37:50','2020-12-21 20:37:50','4e5a0b7c-b966-40b2-a5a9-c669122f5eba'),(447,11,36,NULL,7,1,'2020-12-21 20:37:50','2020-12-21 20:37:50','b8285244-7e32-4572-9537-64a7a19edca2'),(448,11,36,NULL,8,2,'2020-12-21 20:37:50','2020-12-21 20:37:50','1c92e122-3206-4266-aa2d-92a2d88cf560'),(449,11,36,NULL,10,3,'2020-12-21 20:37:50','2020-12-21 20:37:50','8d742553-c51c-42ac-8e69-92de3c15a3a4'),(450,6,34,NULL,32,1,'2020-12-21 20:38:19','2020-12-21 20:38:19','06499806-dbf4-4a1e-838e-75a35d41995a'),(451,15,34,NULL,39,1,'2020-12-21 20:38:19','2020-12-21 20:38:19','1477e4c3-216f-4723-96c5-0477bbac399d'),(452,1,34,NULL,33,1,'2020-12-21 20:38:19','2020-12-21 20:38:19','a16b97f5-17b6-47ea-9574-e2f879c60169'),(453,18,34,NULL,33,1,'2020-12-21 20:38:19','2020-12-21 20:38:19','cb4914c9-ded9-42e6-a736-b7f84853f3e5'),(454,11,34,NULL,5,1,'2020-12-21 20:38:19','2020-12-21 20:38:19','66c50eda-d02d-472b-bd1f-ed67c98c90d5'),(461,6,2,NULL,3,1,'2020-12-21 20:42:35','2020-12-21 20:42:35','f83b67cb-e27b-497d-af4d-6e9b1b9edbcf'),(462,11,2,NULL,5,1,'2020-12-21 20:42:35','2020-12-21 20:42:35','1f88547f-8ba5-495c-8e57-783036fee782'),(463,11,2,NULL,6,2,'2020-12-21 20:42:35','2020-12-21 20:42:35','4ca85837-87a4-42db-bc39-f6d2d1c34600'),(464,11,2,NULL,7,3,'2020-12-21 20:42:35','2020-12-21 20:42:35','eaf65398-367d-4c64-b644-19893741ea3d'),(465,11,2,NULL,8,4,'2020-12-21 20:42:35','2020-12-21 20:42:35','a82fcf38-2633-4aee-b088-14f5f7d402b0'),(466,11,2,NULL,10,5,'2020-12-21 20:42:35','2020-12-21 20:42:35','d402a3e0-251f-4c23-aab2-06284849f20f'),(467,11,2,NULL,12,6,'2020-12-21 20:42:35','2020-12-21 20:42:35','1ae9df24-7505-479e-b77b-689e0de3f5f5'),(468,11,2,NULL,120,7,'2020-12-21 20:42:35','2020-12-21 20:42:35','44c249af-b70d-438c-ae4a-a989971d8c53'),(482,6,111,NULL,121,1,'2020-12-28 16:46:23','2020-12-28 16:46:23','a3d215c5-cfba-46b9-8ecb-420024c5c3b0'),(483,1,111,NULL,109,1,'2020-12-28 16:46:23','2020-12-28 16:46:23','d0a59c71-4a6a-444f-a80f-22b16894ec46'),(484,18,111,NULL,109,1,'2020-12-28 16:46:23','2020-12-28 16:46:23','edf8ab8f-c28b-4319-9882-4015928cfef3'),(485,11,111,NULL,120,1,'2020-12-28 16:46:23','2020-12-28 16:46:23','e8d7eb5c-0ef5-46e6-b100-2a758741133c'),(486,11,111,NULL,6,2,'2020-12-28 16:46:23','2020-12-28 16:46:23','954ce0ad-8a87-44de-8862-354bfee98d05'),(487,11,111,NULL,5,3,'2020-12-28 16:46:23','2020-12-28 16:46:23','3d64ac23-f061-4d48-9371-686fe19789e5'),(495,6,100,NULL,102,1,'2020-12-28 16:50:35','2020-12-28 16:50:35','982d36b3-5972-4d87-9b39-710f98ff805a'),(496,15,100,NULL,102,1,'2020-12-28 16:50:35','2020-12-28 16:50:35','d578d800-c8d4-4f37-9b5b-cf762f906335'),(497,11,100,NULL,122,1,'2020-12-28 16:50:35','2020-12-28 16:50:35','46290d71-5870-4266-a918-be0d422b624b'),(498,11,100,NULL,6,2,'2020-12-28 16:50:35','2020-12-28 16:50:35','22733a3f-9f84-4c5f-8601-b3644781ad2c'),(499,11,100,NULL,5,3,'2020-12-28 16:50:35','2020-12-28 16:50:35','3fc4e1e0-e9e4-4e66-8f11-c8b387371e08'),(500,11,100,NULL,8,4,'2020-12-28 16:50:35','2020-12-28 16:50:35','0c07c4c3-7fdb-49c1-87d1-d3a094941086'),(501,6,21,NULL,20,1,'2020-12-28 16:50:56','2020-12-28 16:50:56','d8963f74-8f7a-4281-96d9-afa980859891'),(502,15,21,NULL,24,1,'2020-12-28 16:50:56','2020-12-28 16:50:56','8d60b065-e953-4fec-b9bc-ec4d90b6070c'),(503,1,21,NULL,14,1,'2020-12-28 16:50:56','2020-12-28 16:50:56','8af277d3-1bad-4d9d-9701-88931c277d1f'),(504,18,21,NULL,54,1,'2020-12-28 16:50:56','2020-12-28 16:50:56','1e5eb0c5-1655-4cf8-ba01-4d2497ad28c2'),(505,11,21,NULL,122,1,'2020-12-28 16:50:56','2020-12-28 16:50:56','f0a4ae18-d79c-42e1-a674-6a7620f0982e'),(506,11,21,NULL,6,2,'2020-12-28 16:50:56','2020-12-28 16:50:56','e67bb07a-33b7-4dd5-b0da-5aee1d636f48'),(507,11,21,NULL,5,3,'2020-12-28 16:50:56','2020-12-28 16:50:56','79cfaea0-b941-4cd2-9d25-2419b334b911'),(508,6,114,NULL,116,1,'2020-12-28 20:22:59','2020-12-28 20:22:59','245278fc-26d6-4bdf-9ce7-c3c373b8659f'),(509,11,114,NULL,6,1,'2020-12-28 20:22:59','2020-12-28 20:22:59','0c2e107f-fb52-4286-8638-e565167c4d5d'),(510,11,114,NULL,5,2,'2020-12-28 20:22:59','2020-12-28 20:22:59','faf4110a-9993-4dcd-914a-8ace11f7a855'),(511,6,118,NULL,117,1,'2020-12-28 20:43:18','2020-12-28 20:43:18','6ef5794b-34fe-4ad6-b9e1-e87800f6f592'),(512,11,118,NULL,120,1,'2020-12-28 20:43:18','2020-12-28 20:43:18','50ac9bd6-d529-4731-a675-ba551b178739'),(513,11,118,NULL,6,2,'2020-12-28 20:43:18','2020-12-28 20:43:18','bc4a815e-d62f-4f3a-b1b1-38c255fb5380'),(514,11,118,NULL,5,3,'2020-12-28 20:43:18','2020-12-28 20:43:18','9f736bee-467d-48ff-a623-41b06fd8d025'),(515,6,123,NULL,117,1,'2021-01-03 00:36:15','2021-01-03 00:36:15','1f4d9f89-b35d-4e48-93a7-a4a2df150848'),(516,11,123,NULL,120,1,'2021-01-03 00:36:15','2021-01-03 00:36:15','4b0811a0-dc97-45a8-aa10-3e90f637c0cc'),(517,11,123,NULL,6,2,'2021-01-03 00:36:15','2021-01-03 00:36:15','479932ef-ef41-4a02-a848-a54447ce7495'),(518,11,123,NULL,5,3,'2021-01-03 00:36:15','2021-01-03 00:36:15','ea1f2a04-633c-4322-8978-092258835feb'),(519,6,125,NULL,116,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','dfe03636-9bf7-4119-851f-c01412462615'),(520,11,125,NULL,6,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','4056e854-464a-4311-b037-314aa6886f6b'),(521,11,125,NULL,5,2,'2021-01-03 00:36:32','2021-01-03 00:36:32','6f63e568-8575-4afd-b74e-d08ecb917cc5'),(522,6,127,NULL,20,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','5ba41732-2549-4d06-8835-1cc38e682d7a'),(523,15,127,NULL,24,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','aff3128e-1072-4980-b8d1-dfb26c9ad65b'),(524,1,127,NULL,14,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','676b7d5c-7d82-42a8-ae5a-f98bd6449309'),(525,18,127,NULL,54,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','7b79a97c-ccd8-47f7-a516-f1f6e966f5df'),(526,11,127,NULL,122,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','2044cb6c-b350-4d60-a7bb-72ef793fdbfd'),(527,11,127,NULL,6,2,'2021-01-03 00:36:32','2021-01-03 00:36:32','2cf0dd5e-370e-4357-927e-8a12ad37c990'),(528,11,127,NULL,5,3,'2021-01-03 00:36:32','2021-01-03 00:36:32','3333f4b3-97b5-46a9-a763-9376c385d255'),(529,6,130,NULL,102,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','f2f8873a-c194-4b44-9e40-a4555dcf5002'),(530,15,130,NULL,102,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','e105823a-494d-4fc0-ae5c-f333bf3d9596'),(531,11,130,NULL,122,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','2713d61a-034f-445c-8f35-66f46dcf81ad'),(532,11,130,NULL,6,2,'2021-01-03 00:36:32','2021-01-03 00:36:32','792289ae-794a-4c0c-9780-f04745d44cff'),(533,11,130,NULL,5,3,'2021-01-03 00:36:32','2021-01-03 00:36:32','5aebe387-d127-493b-926c-bdcb0d074681'),(534,11,130,NULL,8,4,'2021-01-03 00:36:32','2021-01-03 00:36:32','e320b9f7-ff25-4548-b9ae-385f58e34602'),(535,6,133,NULL,121,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','670b20f3-77d5-471a-bd35-c50249da6613'),(536,1,133,NULL,109,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','676f8623-fa35-4456-87b5-0de8562ff4cf'),(537,18,133,NULL,109,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','dbd3380a-6154-4c64-bc13-a049bfe1111f'),(538,11,133,NULL,120,1,'2021-01-03 00:36:32','2021-01-03 00:36:32','8731347f-c7e0-4663-ac43-a566036b1c64'),(539,11,133,NULL,6,2,'2021-01-03 00:36:32','2021-01-03 00:36:32','0226d7c0-d49b-4cee-9410-9e8fd9285e53'),(540,11,133,NULL,5,3,'2021-01-03 00:36:32','2021-01-03 00:36:32','8c86ee27-a727-47aa-acec-be937ec93b83'),(541,6,135,NULL,3,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','5f00df3a-6777-4dbc-b48e-cab30497b4e9'),(542,11,135,NULL,120,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','c4d763fb-d6a4-4ae1-82a3-3e402344c79b'),(543,11,135,NULL,6,2,'2021-01-03 00:36:33','2021-01-03 00:36:33','a88e5f8c-b773-4d18-87c8-9f3b0035ae49'),(544,11,135,NULL,5,3,'2021-01-03 00:36:33','2021-01-03 00:36:33','7693fe34-9d92-4177-ad88-7c56531f621b'),(545,11,135,NULL,7,4,'2021-01-03 00:36:33','2021-01-03 00:36:33','ae688d35-9fdb-4d80-97ed-e87563a57d2e'),(546,11,135,NULL,8,5,'2021-01-03 00:36:33','2021-01-03 00:36:33','cce78147-5b49-4f85-9d19-a77a7c78bc48'),(547,11,135,NULL,10,6,'2021-01-03 00:36:33','2021-01-03 00:36:33','07407808-1da5-4a88-ae22-8d56f16a02ec'),(548,11,135,NULL,12,7,'2021-01-03 00:36:33','2021-01-03 00:36:33','992e45e7-2dd7-4892-b1a8-bbc734404d0a'),(549,6,137,NULL,32,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','061a8562-a387-4e55-ae27-391671c04c65'),(550,15,137,NULL,39,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','c1e0fa86-a5f6-41b5-9221-f7214cd98be7'),(551,1,137,NULL,33,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','814f7744-2af1-49ad-8288-2268e3a29f76'),(552,18,137,NULL,33,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','b87ba0a5-79fc-412b-8365-5d18a674ae84'),(553,11,137,NULL,5,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','8be8d750-7082-417c-841d-40f2fe2c3bf5'),(554,6,140,NULL,35,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','731ac821-4722-40be-b49c-36240e7aa8a3'),(555,15,140,NULL,40,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','efc15ee8-1e44-45de-9aa4-4fb68aa56e93'),(556,11,140,NULL,7,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','55aff5c7-e8d9-4ff5-9f73-cad980d8fb21'),(557,11,140,NULL,8,2,'2021-01-03 00:36:33','2021-01-03 00:36:33','f391a932-5d5c-4c3f-9d1d-0c4f8037317f'),(558,11,140,NULL,10,3,'2021-01-03 00:36:33','2021-01-03 00:36:33','edd4a2e4-7150-4d06-84b5-0763b22483a9'),(559,6,143,NULL,29,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','72c81996-46cb-4163-97f0-9137cce419d9'),(560,15,143,NULL,41,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','56caf607-7db7-421c-877a-4dc1be4df63e'),(561,1,143,NULL,14,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','53349508-f12b-405d-aa07-14e6f290d8d0'),(562,18,143,NULL,55,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','299686bb-be44-459a-b77d-415a6b1c81c3'),(563,11,143,NULL,5,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','63a26c4f-4ff9-4284-b005-cc717f653576'),(564,11,143,NULL,8,2,'2021-01-03 00:36:33','2021-01-03 00:36:33','3d518370-d2ce-4151-b3dc-ee3ebe9879e6'),(565,6,146,NULL,26,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','1ad26c33-71cb-4b43-ba82-d8db521e99c6'),(566,15,146,NULL,38,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','880d2f60-32c0-4ef8-af08-991d6ff643ab'),(567,1,146,NULL,14,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','7601a2a7-95c0-4bd1-9c7e-09f3dd83bb29'),(568,18,146,NULL,52,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','9e506162-850b-47e6-bd52-dd56e7561cd5'),(569,11,146,NULL,5,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','5a25c826-a478-4baa-afad-426c1219172f'),(570,6,149,NULL,17,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','b77f1f47-a263-4519-b6de-450582fac522'),(571,15,149,NULL,25,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','51ffc005-61f0-4bd4-86e8-9dd5e743c0da'),(572,1,149,NULL,14,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','044d08e9-524f-4df1-965a-e55c88c430c9'),(573,18,149,NULL,56,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','493fb28f-b626-4386-a3ec-f5dcc7bab814'),(574,11,149,NULL,5,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','6d84297c-92bf-4d79-a01c-69c4f758ea6a'),(575,6,152,NULL,13,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','12245153-7dd9-47c0-84b7-23222d735e50'),(576,15,152,NULL,23,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','65877ed6-6482-4a3f-9e08-79c949af396c'),(577,1,152,NULL,14,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','7eb72023-3578-43bc-9dd7-9f977922657b'),(578,18,152,NULL,53,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','d1981cb2-7c99-4785-9458-7547c77884d7'),(579,11,152,NULL,5,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','f24cde99-9a5a-4b0b-8a7f-d83e5f6e147a'),(580,6,155,NULL,48,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','569c5d5b-686a-435e-841d-20dfa8748b1e'),(581,15,155,NULL,47,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','d1b33213-70ce-4c2d-a907-dd0e20254044'),(582,11,155,NULL,12,1,'2021-01-03 00:36:33','2021-01-03 00:36:33','17806c88-ad57-4ee3-a2c9-b27ca5c66f0b');
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_revisions`
--

LOCK TABLES `craft_revisions` WRITE;
/*!40000 ALTER TABLE `craft_revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_revisions` VALUES (1,118,1,2,NULL),(2,114,1,2,NULL),(3,21,1,2,NULL),(4,100,1,2,NULL),(5,111,1,2,NULL),(6,2,1,2,NULL),(7,34,1,2,NULL),(8,36,1,2,NULL),(9,30,1,2,NULL),(10,27,1,2,NULL),(11,18,1,2,NULL),(12,15,1,2,NULL),(13,45,1,2,NULL);
/*!40000 ALTER TABLE `craft_revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' wfifer gmail com '),(1,'slug',0,1,''),(2,'field',6,1,' will '),(2,'field',3,1,' 28deg 20 9822ff 20 9822ff 70 0065ff 70 0065ff '),(2,'field',12,1,''),(2,'field',15,1,''),(2,'field',16,1,''),(2,'field',1,1,''),(2,'field',11,1,' development ux ui design graphic design illustration identity awesome tacos product design '),(2,'field',8,1,' i m will fifer designer developer and whatever else gets the job done in an ever more connected world my aim is digital progress guided by both ethics and empathy to that end i draw on my background in engineering and graphic design to craft human centered products the tools often change but the goal remains the same identifying and solving problems drop me a line i love working with folks who are doing good and are passionate about it looking to angel invest in a concept store or food truck based purely on its pun tastic name let s grab a beer '),(2,'field',9,1,''),(2,'slug',0,1,' will makes things '),(2,'title',0,1,' will makes things '),(3,'filename',0,1,' will jpg '),(3,'extension',0,1,' jpg '),(3,'kind',0,1,' image '),(3,'slug',0,1,''),(3,'title',0,1,' will '),(4,'field',4,1,' 28deg '),(4,'field',5,1,' 20 9822ff 20 9822ff 70 0065ff 70 0065ff '),(4,'slug',0,1,''),(5,'field',2,1,' laptop code '),(5,'field',7,1,''),(5,'slug',0,1,' development '),(5,'title',0,1,' development '),(6,'field',2,1,' vector square '),(6,'field',7,1,''),(6,'slug',0,1,' ui design '),(6,'title',0,1,' ui design '),(7,'field',2,1,' crop '),(7,'field',7,1,''),(7,'slug',0,1,' graphic design '),(7,'title',0,1,' graphic design '),(8,'field',2,1,' pencil alt '),(8,'field',7,1,''),(8,'slug',0,1,' illustration '),(8,'title',0,1,' illustration '),(9,'filename',0,1,' identity svg '),(9,'extension',0,1,' svg '),(9,'kind',0,1,' image '),(9,'slug',0,1,''),(9,'title',0,1,' identity '),(10,'field',2,1,' fingerprint '),(10,'field',7,1,''),(10,'slug',0,1,' identity '),(10,'title',0,1,' identity '),(11,'filename',0,1,' taco svg '),(11,'extension',0,1,' svg '),(11,'kind',0,1,' image '),(11,'slug',0,1,''),(11,'title',0,1,' taco '),(12,'field',2,1,' taco '),(12,'field',7,1,''),(12,'slug',0,1,' awesome tacos '),(12,'title',0,1,' awesome tacos '),(13,'filename',0,1,' man test jpg '),(13,'extension',0,1,' jpg '),(13,'kind',0,1,' image '),(13,'slug',0,1,''),(13,'title',0,1,' man test '),(14,'field',16,1,' http thirststudios com '),(14,'slug',0,1,' thirst studios '),(14,'title',0,1,' thirst studios '),(15,'field',6,1,' man test '),(15,'field',3,1,' 30deg 0 00a99d 0 00a99d 80 b6ff15 80 b6ff15 '),(15,'field',12,1,''),(15,'field',15,1,' man test thumbnail '),(15,'field',16,1,' http mantest com au '),(15,'field',1,1,' thirst studios '),(15,'field',11,1,' development '),(15,'field',8,1,' significant health problems such as high blood pressure type 2 diabetes heart disease prostate cancer testicular cancer infertility colon cancer and depression could be detected and treated more effectively if men s awareness of these problems was greater by taking control of your own health you can catch small issues before they become big problems '),(15,'field',9,1,' have a crack at the man test my typical checkup experience '),(16,'field',4,1,' 30deg '),(16,'field',5,1,' 0 00a99d 0 00a99d 80 b6ff15 80 b6ff15 '),(16,'slug',0,1,''),(15,'slug',0,1,' the man test '),(15,'title',0,1,' the man test '),(17,'filename',0,1,' halls taekwondo jpg '),(17,'extension',0,1,' jpg '),(17,'kind',0,1,' image '),(17,'slug',0,1,''),(17,'title',0,1,' halls taekwondo '),(18,'field',6,1,' halls taekwondo '),(18,'field',3,1,' 20 ff0062 20 ff0062 80 ff7900 80 ff7900 '),(18,'field',12,1,''),(18,'field',15,1,' halls taekwondo thumbnail '),(18,'field',16,1,' https hallstaekwondo com au '),(18,'field',1,1,' thirst studios '),(18,'field',11,1,' development '),(18,'field',8,1,''),(18,'field',9,1,' halls taekwondo home pagehalls shop product details '),(19,'field',4,1,''),(19,'field',5,1,' 20 ff0062 20 ff0062 80 ff7900 80 ff7900 '),(19,'slug',0,1,''),(18,'slug',0,1,' halls taekwondo '),(18,'title',0,1,' hall s taekwondo '),(20,'filename',0,1,' womens health week jpg '),(20,'extension',0,1,' jpg '),(20,'kind',0,1,' image '),(20,'slug',0,1,''),(20,'title',0,1,' womens health week '),(21,'field',6,1,' womens health week '),(21,'field',3,1,' 67deg 20 7000c6 20 7000c6 80 ff2eb9 80 ff2eb9 '),(21,'field',12,1,''),(21,'field',15,1,' womens health week thumbnail '),(21,'field',16,1,' https www womenshealthweek com au '),(21,'field',1,1,' thirst studios '),(21,'field',11,1,' ux design ui design development '),(21,'field',8,1,''),(21,'field',9,1,' successful relaunch of the womens health week site '),(22,'field',4,1,' 67deg '),(22,'field',5,1,' 20 7000c6 20 7000c6 80 ff2eb9 80 ff2eb9 '),(22,'slug',0,1,''),(21,'slug',0,1,' womens health week '),(21,'title',0,1,' women s health week '),(23,'filename',0,1,' man test_180829_235635 jpg '),(23,'extension',0,1,' jpg '),(23,'kind',0,1,' image '),(23,'slug',0,1,''),(23,'title',0,1,' man test thumbnail '),(24,'filename',0,1,' womens health week_180829_235728 jpg '),(24,'extension',0,1,' jpg '),(24,'kind',0,1,' image '),(24,'slug',0,1,''),(24,'title',0,1,' womens health week thumbnail '),(25,'filename',0,1,' halls taekwondo_180829_235841 jpg '),(25,'extension',0,1,' jpg '),(25,'kind',0,1,' image '),(25,'slug',0,1,''),(25,'title',0,1,' halls taekwondo thumbnail '),(26,'filename',0,1,' cengage ecollection png '),(26,'extension',0,1,' png '),(26,'kind',0,1,' image '),(26,'slug',0,1,''),(26,'title',0,1,' cengage ecollection '),(27,'field',6,1,' cengage ecollection '),(27,'field',3,1,' 0deg 20 00d4a2 20 00d4a2 50 8d81ff 50 8d81ff 80 ff3fb5 80 ff3fb5 '),(27,'field',12,1,''),(27,'field',15,1,' cengage ecollection thumbnail '),(27,'field',16,1,' https app pmecollection com au '),(27,'field',1,1,' thirst studios '),(27,'field',11,1,' development '),(27,'field',8,1,' this was a complete web port of an existing ios app leveraging various web apis and a custom framework for a demo click get started on the home page '),(27,'field',9,1,' the ecollection bookshelf book reader view '),(28,'field',4,1,' 0deg '),(28,'field',5,1,' 20 00d4a2 20 00d4a2 50 8d81ff 50 8d81ff 80 ff3fb5 80 ff3fb5 '),(28,'slug',0,1,''),(27,'slug',0,1,' cengage ecollection '),(27,'title',0,1,' cengage ecollection '),(29,'filename',0,1,' uxmas png '),(29,'extension',0,1,' png '),(29,'kind',0,1,' image '),(29,'slug',0,1,''),(29,'title',0,1,' uxmas '),(30,'field',6,1,' uxmas '),(30,'field',3,1,' 75deg 10 ff3f85 10 ff3f85 50 ffe448 50 ffe448 90 95ff10 90 95ff10 '),(30,'field',12,1,''),(30,'field',15,1,' uxmas thumbnail '),(30,'field',16,1,' http uxmas com '),(30,'field',1,1,' thirst studios '),(30,'field',11,1,' development illustration '),(30,'field',8,1,''),(30,'field',9,1,' the uxmas advent calendar 25 days of uxmas '),(31,'field',4,1,' 75deg '),(31,'field',5,1,' 10 ff3f85 10 ff3f85 50 ffe448 50 ffe448 90 95ff10 90 95ff10 '),(31,'slug',0,1,''),(30,'slug',0,1,' uxmas '),(30,'title',0,1,' uxmas '),(32,'filename',0,1,' change it ourselves png '),(32,'extension',0,1,' png '),(32,'kind',0,1,' image '),(32,'slug',0,1,''),(32,'title',0,1,' change it ourselves '),(33,'field',16,1,' http www daledesilva com '),(33,'slug',0,1,' dale de silva '),(33,'title',0,1,' dale de silva '),(34,'field',6,1,' change it ourselves '),(34,'field',3,1,' 45deg 20 ff9e15 20 ff9e15 80 ff3fb5 80 ff3fb5 '),(34,'field',12,1,''),(34,'field',15,1,' change it ourselves thumbnail '),(34,'field',16,1,' http changeitourselves com au '),(34,'field',1,1,' dale de silva '),(34,'field',11,1,' development '),(34,'field',8,1,''),(34,'field',9,1,' helpful resources for employers and employees '),(34,'slug',0,1,' change it ourselves '),(34,'title',0,1,' change it ourselves '),(35,'filename',0,1,' other work png '),(35,'extension',0,1,' png '),(35,'kind',0,1,' image '),(35,'slug',0,1,''),(35,'title',0,1,' other work '),(36,'field',6,1,' other work '),(36,'field',3,1,' 10deg 30 e2ff00 30 e2ff00 80 00ffcf 80 00ffcf '),(36,'field',12,1,''),(36,'field',15,1,' other work thumbnail '),(36,'field',16,1,' https www behance net wfifer '),(36,'field',1,1,''),(36,'field',11,1,' graphic design illustration identity '),(36,'field',8,1,''),(36,'field',9,1,' jay pluto film logo and animation '),(37,'field',4,1,' 10deg '),(37,'field',5,1,' 30 e2ff00 30 e2ff00 80 00ffcf 80 00ffcf '),(37,'slug',0,1,''),(36,'slug',0,1,' other work '),(36,'title',0,1,' other work '),(38,'filename',0,1,' cengage ecollection_180830_022429 png '),(38,'extension',0,1,' png '),(38,'kind',0,1,' image '),(38,'slug',0,1,''),(38,'title',0,1,' cengage ecollection thumbnail '),(39,'filename',0,1,' change it ourselves_180830_022509 png '),(39,'extension',0,1,' png '),(39,'kind',0,1,' image '),(39,'slug',0,1,''),(39,'title',0,1,' change it ourselves thumbnail '),(40,'filename',0,1,' other work_180830_022619 png '),(40,'extension',0,1,' png '),(40,'kind',0,1,' image '),(40,'slug',0,1,''),(40,'title',0,1,' other work thumbnail '),(41,'filename',0,1,' uxmas_180830_022658 png '),(41,'extension',0,1,' png '),(41,'kind',0,1,' image '),(41,'slug',0,1,''),(41,'title',0,1,' uxmas thumbnail '),(42,'field',4,1,' 45deg '),(42,'field',5,1,' 20 ff9e15 20 ff9e15 80 ff3fb5 80 ff3fb5 '),(42,'slug',0,1,''),(2,'field',17,1,' 1 '),(15,'field',17,1,' 1 '),(18,'field',17,1,' 1 '),(21,'field',17,1,''),(27,'field',17,1,' 1 '),(30,'field',17,1,' 1 '),(34,'field',17,1,''),(36,'field',17,1,' 1 '),(43,'filename',0,1,' img_5525 jpg '),(43,'extension',0,1,' jpg '),(43,'kind',0,1,' image '),(43,'slug',0,1,''),(43,'title',0,1,' img 5525 '),(44,'filename',0,1,' img_5501 jpg '),(44,'extension',0,1,' jpg '),(44,'kind',0,1,' image '),(44,'slug',0,1,''),(44,'title',0,1,' img 5501 '),(45,'field',6,1,' food blog '),(45,'field',3,1,' 48deg 20 ff9000 20 ff9000 80 ff0036 80 ff0036 '),(45,'field',12,1,''),(45,'field',15,1,' food blog thumbnail '),(45,'field',16,1,''),(45,'field',1,1,''),(45,'field',11,1,' awesome tacos '),(45,'field',17,1,''),(45,'field',8,1,''),(45,'field',9,1,''),(46,'field',4,1,' 48deg '),(46,'field',5,1,' 20 ff9000 20 ff9000 80 ff0036 80 ff0036 '),(46,'slug',0,1,''),(45,'slug',0,1,' food blog '),(45,'title',0,1,' the world needs another food blog '),(47,'filename',0,1,' food blog thumbnail jpg '),(47,'extension',0,1,' jpg '),(47,'kind',0,1,' image '),(47,'slug',0,1,''),(47,'title',0,1,' food blog thumbnail '),(48,'filename',0,1,' food blog jpg '),(48,'extension',0,1,' jpg '),(48,'kind',0,1,' image '),(48,'slug',0,1,''),(48,'title',0,1,' food blog '),(56,'title',0,1,' hall s taekwondo '),(56,'slug',0,1,' halls taekwondo '),(56,'field',16,1,' https www hallstaekwondo com au '),(55,'title',0,1,' ux mastery '),(55,'slug',0,1,' ux mastery '),(55,'field',16,1,' https uxmastery com '),(52,'field',16,1,' https cengage com au '),(52,'slug',0,1,' cengage '),(52,'title',0,1,' cengage '),(53,'field',16,1,' https www baker edu au '),(53,'slug',0,1,' baker institute '),(53,'title',0,1,' baker institute '),(54,'field',16,1,' https jeanhailes org au '),(54,'slug',0,1,' jean hailes womens hospital '),(54,'title',0,1,' jean hailes women s hospital '),(57,'field',16,1,''),(57,'slug',0,1,' various '),(57,'title',0,1,' various '),(2,'field',18,1,''),(15,'field',18,1,' baker institute '),(18,'field',18,1,' hall s taekwondo '),(21,'field',18,1,' jean hailes women s hospital '),(27,'field',18,1,' cengage '),(30,'field',18,1,' ux mastery '),(34,'field',18,1,' dale de silva '),(36,'field',18,1,''),(45,'field',18,1,''),(67,'field',10,1,' have a crack at the man test my typical checkup experience '),(67,'slug',0,1,''),(84,'filename',0,1,' change it ourselves_take part jpg '),(84,'extension',0,1,' jpg '),(84,'kind',0,1,' image '),(84,'slug',0,1,''),(84,'title',0,1,' change it ourselves take part '),(85,'filename',0,1,' ecollection reader jpg '),(85,'extension',0,1,' jpg '),(85,'kind',0,1,' image '),(85,'slug',0,1,''),(85,'title',0,1,' ecollection reader '),(86,'filename',0,1,' ecollection jpg '),(86,'extension',0,1,' jpg '),(86,'kind',0,1,' image '),(86,'slug',0,1,''),(86,'title',0,1,' ecollection '),(87,'filename',0,1,' halls taekwondo shop jpg '),(87,'extension',0,1,' jpg '),(87,'kind',0,1,' image '),(87,'slug',0,1,''),(87,'title',0,1,' halls taekwondo shop '),(88,'filename',0,1,' halls taekwondo jpg '),(88,'extension',0,1,' jpg '),(88,'kind',0,1,' image '),(88,'slug',0,1,''),(88,'title',0,1,' halls taekwondo '),(89,'filename',0,1,' man test jpg '),(89,'extension',0,1,' jpg '),(89,'kind',0,1,' image '),(89,'slug',0,1,''),(89,'title',0,1,' man test '),(90,'filename',0,1,' uxmas jpg '),(90,'extension',0,1,' jpg '),(90,'kind',0,1,' image '),(90,'slug',0,1,''),(90,'title',0,1,' uxmas '),(91,'filename',0,1,' womens health week jpg '),(91,'extension',0,1,' jpg '),(91,'kind',0,1,' image '),(91,'slug',0,1,''),(91,'title',0,1,' womens health week '),(93,'field',10,1,' the uxmas advent calendar 25 days of uxmas '),(93,'slug',0,1,''),(94,'filename',0,1,' man test quiz jpg '),(94,'extension',0,1,' jpg '),(94,'kind',0,1,' image '),(94,'slug',0,1,''),(94,'title',0,1,' man test quiz '),(95,'field',10,1,' halls taekwondo home pagehalls shop product details '),(95,'slug',0,1,''),(96,'field',10,1,' successful relaunch of the womens health week site '),(96,'slug',0,1,''),(97,'field',10,1,' the ecollection bookshelf book reader view '),(97,'slug',0,1,''),(98,'field',10,1,' helpful resources for employers and employees '),(98,'slug',0,1,''),(99,'filename',0,1,' exercise 86200_1920 jpg '),(99,'extension',0,1,' jpg '),(99,'kind',0,1,' image '),(99,'slug',0,1,''),(99,'title',0,1,' macrolease fitness '),(100,'field',6,1,' exercise 86200 1920 '),(100,'field',3,1,' 38 10 3ee4c0 10 3ee4c0 90 0045de 90 0045de '),(100,'field',12,1,''),(100,'field',15,1,' exercise 86200 1920 '),(100,'field',16,1,' https macrolease com '),(100,'field',1,1,''),(100,'field',18,1,''),(100,'field',11,1,' ux design ui design development illustration '),(100,'field',17,1,''),(100,'field',8,1,' a complete redesign and rebuild of the macrolease website using craft cms this project necessitated consideration of some elements of visual identity without the scope to actually tackle it head on craft was chosen for both facility of development and the client s content entry experience an oft overlooked component of web development '),(100,'field',9,1,' home page featuring animated title lockup and video reel floating illustrations bring macrolease s personality to life original website '),(101,'field',4,1,' 38 '),(101,'field',5,1,' 10 3ee4c0 10 3ee4c0 90 0045de 90 0045de '),(101,'slug',0,1,''),(100,'slug',0,1,' macrolease '),(100,'title',0,1,' macrolease '),(102,'filename',0,1,' exercise 86200_1920_181026_191207 jpg '),(102,'extension',0,1,' jpg '),(102,'kind',0,1,' image '),(102,'slug',0,1,''),(102,'title',0,1,' exercise 86200 1920 '),(103,'filename',0,1,' macrolease jpg '),(103,'extension',0,1,' jpg '),(103,'kind',0,1,' image '),(103,'slug',0,1,''),(103,'title',0,1,' macrolease '),(104,'filename',0,1,' macrolease advantage jpg '),(104,'extension',0,1,' jpg '),(104,'kind',0,1,' image '),(104,'slug',0,1,''),(104,'title',0,1,' macrolease advantage '),(105,'filename',0,1,' macrolease old jpg '),(105,'extension',0,1,' jpg '),(105,'kind',0,1,' image '),(105,'slug',0,1,''),(105,'title',0,1,' macrolease old '),(106,'field',10,1,' home page featuring animated title lockup and video reel floating illustrations bring macrolease s personality to life original website '),(106,'slug',0,1,''),(107,'field',10,1,' jay pluto film logo and animation '),(107,'slug',0,1,''),(108,'filename',0,1,' macrolease jpg '),(108,'extension',0,1,' jpg '),(108,'kind',0,1,' image '),(108,'slug',0,1,''),(108,'title',0,1,' macrolease '),(109,'field',16,1,''),(109,'slug',0,1,' leo flander '),(109,'title',0,1,' leo flander '),(110,'filename',0,1,' about jpg '),(110,'extension',0,1,' jpg '),(110,'kind',0,1,' image '),(110,'slug',0,1,''),(110,'title',0,1,' about '),(111,'field',6,1,' artboard 2 201130 031938 '),(111,'field',3,1,' 65deg 20 ef4749 20 ef4749 80 8800ff 80 8800ff '),(111,'field',12,1,''),(111,'field',15,1,''),(111,'field',16,1,' http www oilportraits org '),(111,'field',1,1,' leo flander '),(111,'field',18,1,' leo flander '),(111,'field',11,1,' product design ui design development '),(111,'field',17,1,' 1 '),(111,'field',8,1,''),(111,'field',9,1,''),(112,'field',4,1,' 65deg '),(112,'field',5,1,' 20 ef4749 20 ef4749 80 8800ff 80 8800ff '),(112,'slug',0,1,''),(111,'slug',0,1,' portraits for change '),(111,'title',0,1,' portraits for change '),(113,'filename',0,1,' header portrait jpg '),(113,'extension',0,1,' jpg '),(113,'kind',0,1,' image '),(113,'slug',0,1,''),(113,'title',0,1,' header portrait '),(114,'field',6,1,' lying '),(114,'field',3,1,' 0 0 4a37be 0 4a37be 100 d4254f 100 d4254f '),(114,'field',12,1,''),(114,'field',15,1,''),(114,'field',16,1,' https cicadafilm com '),(114,'field',1,1,''),(114,'field',18,1,''),(114,'field',11,1,' ui design development '),(114,'field',17,1,''),(114,'field',8,1,''),(114,'field',9,1,''),(115,'field',4,1,' 0 '),(115,'field',5,1,' 0 4a37be 0 4a37be 100 d4254f 100 d4254f '),(115,'slug',0,1,''),(114,'slug',0,1,' cicada '),(114,'title',0,1,' cicada '),(116,'filename',0,1,' lying jpg '),(116,'extension',0,1,' jpg '),(116,'kind',0,1,' image '),(116,'slug',0,1,''),(116,'title',0,1,' lying '),(117,'filename',0,1,' idealist help hero jpg '),(117,'extension',0,1,' jpg '),(117,'kind',0,1,' image '),(117,'slug',0,1,''),(117,'title',0,1,' idealist help hero '),(118,'field',6,1,' idealist help hero '),(118,'field',3,1,' 20 25 a4ff30 25 a4ff30 90 0036f4 90 0036f4 '),(118,'field',12,1,''),(118,'field',15,1,''),(118,'field',16,1,' https idealist org '),(118,'field',1,1,''),(118,'field',18,1,''),(118,'field',11,1,' product design ui design development '),(118,'field',17,1,' 1 '),(118,'field',8,1,''),(118,'field',9,1,''),(119,'field',4,1,' 20 '),(119,'field',5,1,' 25 a4ff30 25 a4ff30 90 0036f4 90 0036f4 '),(119,'slug',0,1,''),(118,'slug',0,1,' idealist org '),(118,'title',0,1,' idealist org '),(120,'field',2,1,' lightbulb on '),(120,'field',7,1,''),(120,'slug',0,1,' product design '),(120,'title',0,1,' product design '),(5,'field',19,1,' far '),(121,'filename',0,1,' artboard 2_201130_031938 jpg '),(121,'extension',0,1,' jpg '),(121,'kind',0,1,' image '),(121,'slug',0,1,''),(121,'title',0,1,' artboard 2 201130 031938 '),(120,'field',19,1,' far '),(7,'field',19,1,' far '),(6,'field',19,1,' far '),(12,'field',19,1,' far '),(122,'field',2,1,' street view '),(122,'field',19,1,' far '),(122,'slug',0,1,' ux design '),(122,'title',0,1,' ux design '),(8,'field',19,1,' far ');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections` VALUES (1,3,'Projects','projects','structure',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2018-08-29 23:17:50','2021-01-03 00:35:31',NULL,'04258b8a-06cf-4637-a5a5-0d201b72dbd6');
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections_sites`
--

LOCK TABLES `craft_sections_sites` WRITE;
/*!40000 ALTER TABLE `craft_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections_sites` VALUES (1,1,1,1,'projects/{slug}','index',1,'2018-08-29 23:17:50','2018-08-29 23:17:50','432afd81-0950-4606-bb8d-cceff004051d');
/*!40000 ALTER TABLE `craft_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sequences`
--

LOCK TABLES `craft_sequences` WRITE;
/*!40000 ALTER TABLE `craft_sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sitegroups`
--

LOCK TABLES `craft_sitegroups` WRITE;
/*!40000 ALTER TABLE `craft_sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sitegroups` VALUES (1,'Portfolio','2018-08-29 22:59:29','2018-08-29 22:59:29',NULL,'c0689416-79ae-4ca4-815a-d892be24323f');
/*!40000 ALTER TABLE `craft_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sites`
--

LOCK TABLES `craft_sites` WRITE;
/*!40000 ALTER TABLE `craft_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sites` VALUES (1,1,1,1,'Portfolio','default','en-US',1,'@web/',1,'2018-08-29 22:59:29','2018-08-29 22:59:29',NULL,'1ca609a1-4ff3-4e3c-9780-72a3e090292b');
/*!40000 ALTER TABLE `craft_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_structureelements` VALUES (1,3,NULL,1,1,54,0,'2018-08-29 23:19:39','2021-01-03 00:36:34','a32831fb-d552-457d-97aa-f9c8987a52d2'),(2,3,2,1,2,3,1,'2018-08-29 23:19:39','2018-08-29 23:19:39','482c3b99-bfb6-440e-98cc-c2f42720fe04'),(3,2,NULL,3,1,18,0,'2018-08-29 23:30:09','2020-12-28 16:49:39','9ecf2b2e-75e3-4794-9691-129eb1a14111'),(4,2,5,3,8,9,1,'2018-08-29 23:30:09','2020-12-28 16:49:39','7e5e1074-90d7-4dcc-8238-68c7092ef9e1'),(5,2,6,3,6,7,1,'2018-08-29 23:30:33','2020-12-28 16:49:39','c9164a96-65f8-4344-a0ab-8c6047a8a934'),(6,2,7,3,10,11,1,'2018-08-29 23:30:44','2020-12-28 16:49:39','cc944fe7-062f-4c2f-85d7-f44d0453e3f3'),(7,2,8,3,12,13,1,'2018-08-29 23:30:58','2020-12-28 16:49:39','1fbcc1f5-8482-4231-95d4-8d3d3f5c08f4'),(8,2,10,3,14,15,1,'2018-08-29 23:31:32','2020-12-28 16:49:39','f6fc775a-496d-4026-98fb-a605c42eb045'),(9,2,12,3,16,17,1,'2018-08-29 23:31:47','2020-12-28 16:49:39','c02c0788-1ff3-4b30-90c5-72f9a5e9e768'),(10,1,NULL,10,1,20,0,'2018-08-29 23:35:47','2020-06-25 02:12:47','3bcfd71b-f42b-44b5-865a-e8e81105a87a'),(11,1,14,10,2,3,1,'2018-08-29 23:35:47','2018-08-29 23:35:47','ca3b24ce-0829-4766-a8fb-3bfb5b389f8f'),(12,3,15,1,14,15,1,'2018-08-29 23:36:02','2021-01-03 00:36:33','e9dc5e88-2af3-4b9c-bf5d-502246189786'),(13,3,18,1,20,21,1,'2018-08-29 23:38:11','2021-01-03 00:36:33','4d6aedc0-071f-4d2b-a62b-84400941fbad'),(14,3,21,1,16,17,1,'2018-08-29 23:39:20','2021-01-03 00:36:33','e588d340-a363-4109-837d-28ee78bdadee'),(15,3,27,1,22,23,1,'2018-08-30 02:20:00','2021-01-03 00:36:33','2082aa2b-ab49-474c-996f-d6f682e1514f'),(16,3,30,1,10,11,1,'2018-08-30 02:21:20','2021-01-03 00:36:33','0ed207fa-f4d2-4cea-9e64-2f5d0a990282'),(17,1,33,10,4,5,1,'2018-08-30 02:22:29','2018-08-30 02:22:29','0c1b3e5e-4696-408f-818d-8f66281043a8'),(18,3,34,1,18,19,1,'2018-08-30 02:22:43','2021-01-03 00:36:33','45f68a89-c012-4e11-8bb2-e5aa363150b9'),(19,3,36,1,24,25,1,'2018-08-30 02:23:35','2021-01-03 00:36:33','a5d42b58-3b2c-414b-8d06-870524824d4a'),(20,3,45,1,26,27,1,'2018-08-30 23:46:13','2021-01-03 00:36:33','ce8133ec-8dce-460b-8fa4-ca67acb1d77a'),(21,4,NULL,21,1,2,0,'2018-10-19 17:39:58','2018-10-19 17:44:04','49852cfc-8868-48be-9b79-37029cfa4d47'),(25,1,52,10,6,7,1,'2018-10-19 17:43:21','2018-10-19 17:43:21','095cb0bc-c409-428e-8208-54a9b570b7eb'),(26,1,53,10,8,9,1,'2018-10-19 17:43:34','2018-10-19 17:43:34','5e160812-e9f1-40d7-a47e-8fae1b911b58'),(27,1,54,10,10,11,1,'2018-10-19 17:43:51','2018-10-19 17:43:51','45be7d46-b89d-44d7-af85-15a9759a399a'),(28,1,55,10,12,13,1,'2018-10-19 17:45:06','2018-10-19 17:45:06','876fd0c7-7f60-4bbb-a6d1-ca4e0f7f4bcd'),(29,1,56,10,14,15,1,'2018-10-19 17:45:27','2018-10-19 17:45:27','e2fe06cb-69c4-4ed3-a6dc-565495a72749'),(30,1,57,10,16,17,1,'2018-10-19 17:45:51','2018-10-19 17:45:51','8f937cf8-8052-4ba8-898f-b0eff7e0fbfe'),(31,3,100,1,8,9,1,'2018-10-26 19:08:08','2021-01-03 00:36:33','2fac55b8-79c2-4f0b-81b5-391300000eb8'),(32,1,109,10,18,19,1,'2020-06-25 02:12:47','2020-06-25 02:12:47','4027aca9-5fea-4d70-b951-a814a9086656'),(33,3,111,1,4,5,1,'2020-06-25 02:15:33','2021-01-03 00:36:33','fb31d566-f343-4217-abde-5418883e6913'),(34,3,114,1,12,13,1,'2020-09-22 21:37:06','2021-01-03 00:36:33','b2ea70d2-1a48-4a8c-9abe-3c9143fbf044'),(35,3,118,1,6,7,1,'2020-12-21 20:24:33','2021-01-03 00:36:33','a01f67d1-db98-4554-a5a7-a3f24d501fe7'),(36,2,120,3,2,3,1,'2020-12-21 20:29:07','2020-12-28 15:51:57','9cd3acdf-5a66-4c59-bb8e-a101d9bba926'),(37,2,122,3,4,5,1,'2020-12-28 16:49:09','2020-12-28 16:49:39','9cd9a84a-a7ae-49b1-b38b-7fb403e9f807'),(38,3,123,1,28,29,1,'2021-01-03 00:36:15','2021-01-03 00:36:34','6fe51662-ea02-4878-8e02-b8109a16a764'),(39,3,125,1,30,31,1,'2021-01-03 00:36:32','2021-01-03 00:36:34','99632fa7-73f5-4a67-88a5-edae65a60fe4'),(40,3,127,1,32,33,1,'2021-01-03 00:36:32','2021-01-03 00:36:34','196e3ba0-6d8b-4aba-a87f-5780963e34a9'),(41,3,130,1,34,35,1,'2021-01-03 00:36:32','2021-01-03 00:36:34','e8c734ab-4a5e-4edb-b8fa-1ad27a3d42e3'),(42,3,133,1,36,37,1,'2021-01-03 00:36:32','2021-01-03 00:36:34','81d12f5c-2983-491c-90b4-5368bdaa7c66'),(43,3,135,1,38,39,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','71162bb8-a67d-47b2-9527-28a8894b0c93'),(44,3,137,1,40,41,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','1c1b401f-36fe-4b23-9554-4a9cd23f80be'),(45,3,140,1,42,43,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','1806aff5-a334-47de-94a8-83dbe56c05cf'),(46,3,143,1,44,45,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','2499faf1-1681-4c05-b51b-0e832f47f466'),(47,3,146,1,46,47,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','48de2934-6b7b-40f5-8c17-eca6ce2901ac'),(48,3,149,1,48,49,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','a42184b4-bd56-4c9a-b526-915089b8072e'),(49,3,152,1,50,51,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','5bdd3a84-c941-433a-a51f-e5fef7e5ff1e'),(50,3,155,1,52,53,1,'2021-01-03 00:36:33','2021-01-03 00:36:34','b1720c8f-fb70-4212-b255-40883ea8d471');
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_structures` VALUES (1,1,'2018-08-29 23:05:16','2018-10-19 17:42:50',NULL,'ed75a22a-57ca-4501-9529-4cd9bca26fbc'),(2,NULL,'2018-08-29 23:11:31','2020-12-28 15:11:05',NULL,'bf223d46-0591-4ea2-bbc4-9e73d73d77f7'),(3,1,'2018-08-29 23:17:50','2018-08-29 23:17:50',NULL,'689e7abf-4fa6-43a2-b14e-1fcb7529f2e0'),(4,NULL,'2018-10-19 17:39:09','2018-10-19 17:39:09',NULL,'183f0c6b-97bc-48a7-a0e4-b3bab4ee0315');
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_systemmessages`
--

LOCK TABLES `craft_systemmessages` WRITE;
/*!40000 ALTER TABLE `craft_systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_userpermissions` VALUES (1,'editimagesinvolume:7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1','2021-01-03 00:35:30','2021-01-03 00:35:30','9dfad3aa-1c11-40a9-8d74-f047b7833d0c');
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpreferences`
--

LOCK TABLES `craft_userpreferences` WRITE;
/*!40000 ALTER TABLE `craft_userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `craft_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_users` VALUES (1,'admin',NULL,NULL,NULL,'wfifer@gmail.com','$2y$13$KWg7GrdISBrZcJgjriTnyOslauDT1JSMGTs4ES24wTu7/Qkvg43t.',1,0,0,0,'2021-01-03 00:31:56','69.86.174.100',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2018-08-29 22:59:32','2018-08-29 22:59:32','2021-01-03 00:31:57','28ec834b-1d78-43dc-a3c0-323ab703cd0d');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumefolders`
--

LOCK TABLES `craft_volumefolders` WRITE;
/*!40000 ALTER TABLE `craft_volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_volumefolders` VALUES (1,NULL,1,'General','','2018-08-29 23:15:31','2018-08-29 23:15:31','05ecc053-58e0-4077-8983-237410cdff7b'),(2,NULL,NULL,'Temporary source',NULL,'2018-08-29 23:19:50','2018-08-29 23:19:50','cb16c0e3-ee72-4c82-a333-4fa96e875ed2'),(3,2,NULL,'user_1','user_1/','2018-08-29 23:19:50','2018-08-29 23:19:50','498f09fb-6869-43f5-8f4f-599de3d5e054'),(4,1,1,'hero','hero/','2018-08-29 23:27:06','2018-08-29 23:27:06','1c522390-f0e7-43a6-884d-8e365d88be47'),(5,1,1,'icon','icon/','2018-08-29 23:31:28','2018-08-29 23:31:28','60748ff4-0810-4846-af44-e44ed40e968c'),(6,1,1,'thumbnail','thumbnail/','2018-08-29 23:57:06','2018-08-29 23:57:06','c70cf079-d7f6-45e3-ac98-b576e353f958');
/*!40000 ALTER TABLE `craft_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumes`
--

LOCK TABLES `craft_volumes` WRITE;
/*!40000 ALTER TABLE `craft_volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_volumes` VALUES (1,6,'General','general','craft\\volumes\\Local',1,'https://api.willfifer.com/assets/uploads','{\"path\":\"assets/uploads\"}',1,'2018-08-29 23:15:31','2020-12-29 19:01:07',NULL,'7e980ef2-cdf7-4eed-ae78-5d6dcd604ad1');
/*!40000 ALTER TABLE `craft_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-08-29 22:59:33','2018-08-29 22:59:33','a54bcf08-a31e-435f-af2c-dc4ddef873a7'),(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-08-29 22:59:33','2018-08-29 22:59:33','c227c6a2-c3b5-4599-b659-b23eb70dcc8d'),(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2018-08-29 22:59:33','2018-08-29 22:59:33','982b5345-0372-4de0-b9ff-c083e65cdd85'),(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-08-29 22:59:33','2018-08-29 22:59:33','7a87e6fe-c33d-4467-b631-b8e142c00f33');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'db_portfolio'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-19 13:39:43
