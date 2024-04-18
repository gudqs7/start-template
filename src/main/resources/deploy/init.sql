-- MySQL dump 10.13  Distrib 5.7.27, for Win64 (x86_64)
--
-- Host: 8.134.218.243    Database: your db
-- ------------------------------------------------------
-- Server version	5.7.42-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sys_auth`
--

DROP TABLE IF EXISTS `sys_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_auth` (
  `sysAuthId` int(11) NOT NULL AUTO_INCREMENT,
  `sysMenuId` int(11) NOT NULL COMMENT '菜单 id',
  `code` varchar(50) NOT NULL COMMENT '权限标识符',
  `method` varchar(20) DEFAULT NULL COMMENT '请求方法',
  `url` varchar(200) NOT NULL COMMENT 'url 地址',
  PRIMARY KEY (`sysAuthId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_auth`
--

LOCK TABLES `sys_auth` WRITE;
/*!40000 ALTER TABLE `sys_auth` DISABLE KEYS */;
INSERT INTO `sys_auth` VALUES (1,3,'find',NULL,'/admin/user/find'),(2,3,'update',NULL,'/admin/user/update'),(3,3,'add',NULL,'/admin/user/add'),(4,3,'delete',NULL,'/admin/user/delete'),(5,4,'find',NULL,'/admin/role/find'),(6,4,'update',NULL,'/admin/role/update'),(7,4,'add',NULL,'/admin/role/add'),(8,4,'delete',NULL,'/admin/role/delete'),(9,4,'findBySysUserId',NULL,'/admin/role/findBySysUserId'),(10,4,'findMenu',NULL,'/admin/auth/findMenu'),(11,4,'findByRole',NULL,'/admin/auth/findByRole'),(12,4,'delMenu',NULL,'/admin/auth/delMenu'),(13,4,'addMenu',NULL,'/admin/auth/addMenu'),(14,4,'add',NULL,'/admin/auth/add'),(15,4,'delete',NULL,'/admin/auth/delete'),(16,5,'find',NULL,'/admin/wechat/keyword/find'),(17,5,'add',NULL,'/admin/wechat/keyword/add'),(18,5,'update',NULL,'/admin/wechat/keyword/update'),(19,5,'delete',NULL,'/admin/wechat/keyword/delete'),(20,6,'find',NULL,'/admin/sys/dictionary/find'),(21,6,'findParent',NULL,'/admin/sys/dictionary/findParent'),(22,6,'update',NULL,'/admin/sys/dictionary/update'),(23,6,'add',NULL,'/admin/sys/dictionary/add'),(24,6,'delete',NULL,'/admin/sys/dictionary/delete'),(25,7,'find',NULL,'/admin/sys/region/find'),(26,7,'update',NULL,'/admin/sys/region/update'),(27,7,'add',NULL,'/admin/sys/region/add'),(28,7,'delete',NULL,'/admin/sys/region/delete');
/*!40000 ALTER TABLE `sys_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dictionary`
--

DROP TABLE IF EXISTS `sys_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dictionary` (
  `dictionaryId` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL DEFAULT '0' COMMENT '父字典 id',
  `dictionaryCode` varchar(50) NOT NULL COMMENT '字典 key',
  `dictionaryValue` varchar(500) DEFAULT NULL COMMENT '字典值',
  `dictionaryMemo` varchar(200) DEFAULT NULL COMMENT '描述',
  `dictionaryType` int(11) NOT NULL DEFAULT '0' COMMENT '预留字典类型',
  `displayOrder` int(11) NOT NULL DEFAULT '0' COMMENT '排序, 数字越大越靠前',
  PRIMARY KEY (`dictionaryId`),
  UNIQUE KEY `uk_dictionary_code` (`dictionaryCode`),
  KEY `ix_dictionary_type` (`dictionaryType`),
  KEY `ix_dictionary_parentId` (`parentId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dictionary`
--

LOCK TABLES `sys_dictionary` WRITE;
/*!40000 ALTER TABLE `sys_dictionary` DISABLE KEYS */;
INSERT INTO `sys_dictionary` VALUES (1,0,'EDUCATION',NULL,'学历',0,0),(2,1,'EDUCATION_DZ','大专','',0,0),(3,1,'EDUCATION_BENKE','本科','',0,0),(4,1,'EDUCATION_YJS','研究生','',0,0),(5,1,'EDUCATION_BOSHI','博士','',0,0);
/*!40000 ALTER TABLE `sys_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `sysMenuId` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL COMMENT '父级',
  `menuText` varchar(50) NOT NULL COMMENT '菜单标题',
  `menuUrl` varchar(200) NOT NULL COMMENT '菜单 url',
  `displayOrder` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `openType` int(11) NOT NULL DEFAULT '0' COMMENT '打开方式: -1.菜单 0.内部模块 1.iframe 2.新标签页 3.新窗口',
  PRIMARY KEY (`sysMenuId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,0,'常用','',0,-1),(2,0,'系统管理','',0,-1),(3,2,'系统用户管理','userManage/userManage',0,0),(4,2,'系统角色管理','userAuth/userAuth',0,0),(5,1,'微信关键词回复','wechatKeyword/wechatKeyword',0,0),(6,2,'系统字典','sysDictionary/sysDictionary',0,0),(7,2,'行政区域','region/region',0,0);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_region`
--

DROP TABLE IF EXISTS `sys_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_region` (
  `regionId` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '父区域id',
  `regionName` varchar(64) NOT NULL DEFAULT '' COMMENT '区域名称',
  `regionType` int(11) NOT NULL DEFAULT '2' COMMENT '区域类型，0-中国、1-省、2-市、3-区、4-街道',
  PRIMARY KEY (`regionId`),
  KEY `ix_region_parentId` (`parentId`),
  KEY `ix_region_regionType` (`regionType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_region`
--

LOCK TABLES `sys_region` WRITE;
/*!40000 ALTER TABLE `sys_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `sysRoleId` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) NOT NULL COMMENT '角色名',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态: 0.禁用 1.启用',
  PRIMARY KEY (`sysRoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'admin',1);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_auth`
--

DROP TABLE IF EXISTS `sys_role_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_auth` (
  `sysRoleId` int(11) NOT NULL,
  `sysAuthId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-权限关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_auth`
--

LOCK TABLES `sys_role_auth` WRITE;
/*!40000 ALTER TABLE `sys_role_auth` DISABLE KEYS */;
INSERT INTO `sys_role_auth` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,16),(1,17),(1,18),(1,19);
/*!40000 ALTER TABLE `sys_role_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `sysRoleId` int(11) NOT NULL,
  `sysMenuId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (1,1),(1,2),(1,3),(1,4),(1,6),(1,7),(1,5);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_update_record`
--

DROP TABLE IF EXISTS `sys_update_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_update_record` (
  `recordId` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) NOT NULL COMMENT '提交者',
  `recordTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '升级时间',
  `recordMemo` varchar(200) NOT NULL COMMENT '升级备注',
  PRIMARY KEY (`recordId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='升级记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_update_record`
--

LOCK TABLES `sys_update_record` WRITE;
/*!40000 ALTER TABLE `sys_update_record` DISABLE KEYS */;
INSERT INTO `sys_update_record` VALUES (1,'wq','2024-04-18 08:24:11','微信自动回复');
/*!40000 ALTER TABLE `sys_update_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `sysUserId` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(50) NOT NULL COMMENT '登录名',
  `password` varchar(50) NOT NULL COMMENT '登录密码: md5(name+password)',
  `nickName` varchar(20) DEFAULT NULL COMMENT '昵称',
  `avatarUrl` varchar(500) DEFAULT NULL COMMENT '头像',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态: 0.禁用 1.启用',
  PRIMARY KEY (`sysUserId`),
  UNIQUE KEY `uk_user_loginName` (`loginName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','e00cf25ad42683b3df678c61f42c6bda','管理','',1);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `sysUserId` int(11) NOT NULL COMMENT '系统用户 id',
  `sysRoleId` int(11) NOT NULL COMMENT '角色 id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_keyword`
--

DROP TABLE IF EXISTS `wechat_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat_keyword` (
  `keywordId` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(200) DEFAULT NULL COMMENT '关键词',
  `matchType` int(11) NOT NULL DEFAULT '1' COMMENT '匹配方式: 1.完全等于 2.关键词包含用户输入 3.用户输入包含关键词',
  `replyType` int(11) NOT NULL DEFAULT '1' COMMENT '回复消息类型: 1.普通文本 2.可带小程序链接文本 3.图片 4.图文信息 5.小程序',
  `replyData` varchar(800) DEFAULT NULL COMMENT '回复内容, json 格式',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0|1',
  `memo` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`keywordId`),
  UNIQUE KEY `uk_wechat_keyword_matchType` (`keyword`,`matchType`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='公众号关键词回复表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_keyword`
--

LOCK TABLES `wechat_keyword` WRITE;
/*!40000 ALTER TABLE `wechat_keyword` DISABLE KEYS */;
INSERT INTO `wechat_keyword` VALUES (1,'1',1,1,'323','2024-04-18 08:24:13',1,'2'),(2,'3',1,1,'323','2024-04-18 08:24:18',1,'32');
/*!40000 ALTER TABLE `wechat_keyword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-18 16:37:53
