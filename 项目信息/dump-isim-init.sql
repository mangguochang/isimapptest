-- MySQL dump 10.13  Distrib 5.7.26, for Win64 (x86_64)
--
-- Host: localhost    Database: isim
-- ------------------------------------------------------
-- Server version	8.0.15

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
-- Table structure for table `database_connector`
--

DROP TABLE IF EXISTS `database_connector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_connector` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `alias` varchar(100) DEFAULT NULL COMMENT '别名',
  `db_type` varchar(100) DEFAULT NULL COMMENT '数据库类型',
  `host` varchar(100) DEFAULT NULL COMMENT '数据库地址',
  `db_name` varchar(100) DEFAULT NULL COMMENT '数据库名称',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `port` varchar(100) DEFAULT NULL COMMENT '端口',
  `test_sql` varchar(100) DEFAULT NULL COMMENT '测试语句',
  `s_type` varchar(100) DEFAULT NULL COMMENT 'sid/serverName',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='连接器-数据库信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_connector`
--

LOCK TABLES `database_connector` WRITE;
/*!40000 ALTER TABLE `database_connector` DISABLE KEYS */;
INSERT INTO `database_connector` VALUES ('sys_databaseId:54afc11a-91fe-4fab-8eac-2198eb709e96','oracle','Oracle','222.188.117.130','esb','c##activiti','activiti','7161','select * from dual;','serverName',NULL,NULL,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-21 15:25:58'),('sys_databaseId:5518fdce-ef2b-441e-a08e-915b2a17b65d','Mysql','MySQL','192.168.8.124','isim','root','root','3306',NULL,NULL,NULL,NULL,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-21 16:14:46'),('sys_databaseId:7a65b742-5d16-416e-8959-c28472d928c0','测试Oracle','Oracle','192.168.1.150','Test','root','d','65535',NULL,'sid','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-21 17:40:42','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-21 17:40:42'),('sys_databaseId:beebccd7-792e-4674-93a8-9a6f54474896','SQL Server','SQLServer','192.168.1.110','mysql_test','aaaa','password','3306',NULL,NULL,NULL,NULL,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-21 17:19:55');
/*!40000 ALTER TABLE `database_connector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_cron_triggers` VALUES ('isimScheduler','TASK_quartzId:69e4829a-e921-4cc7-aa5a-ee64a8bdc159','DEFAULT','0 0/1 * * * ?','Asia/Shanghai');
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `idx_qrtz_ft_trig_inst_name` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `idx_qrtz_ft_inst_job_req_rcvry` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `idx_qrtz_ft_j_g` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `idx_qrtz_ft_jg` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `idx_qrtz_ft_t_g` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `idx_qrtz_ft_tg` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `idx_qrtz_j_req_recovery` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `idx_qrtz_j_grp` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
INSERT INTO `qrtz_job_details` VALUES ('isimScheduler','TASK_quartzId:69e4829a-e921-4cc7-aa5a-ee64a8bdc159','DEFAULT',NULL,'com.hzot.isim.util.quartz.ScheduleJob','0','0','0','0',_binary '�\�\0sr\0org.quartz.JobDataMap���迩�\�\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�\�\��\�](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap\�.�(v\n\�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\rJOB_PARAM_KEYsr\0com.hzot.isim.entity.QuartzTask\0\0\0\0\0\0\0\0L\0cront\0Ljava/lang/String;L\0nameq\0~\0	L\0paramsq\0~\0	L\0remarksq\0~\0	L\0statust\0Ljava/lang/Integer;L\0\ntargetBeanq\0~\0	L\0trgetMethodq\0~\0	xr\0com.hzot.isim.base.DataEntity\0\0\0\0\0\0\0\0L\0createIdq\0~\0	L\0\ncreateTimet\0Ljava/util/Date;L\0\ncreateUsert\0Lcom/hzot/isim/entity/SysUser;L\0updateIdq\0~\0	L\0\nupdateTimeq\0~\0L\0\nupdateUserq\0~\0\rxr\0com.hzot.isim.base.BaseEntity��Բ+�\��\0L\0idq\0~\0	xr\0+com.baomidou.mybatisplus.activerecord.Model\0\0\0\0\0\0\0\0\0xpt\0-quartzId:69e4829a-e921-4cc7-aa5a-ee64a8bdc159t\01sr\0java.util.Datehj�KYt\0\0xpw\0\0nJ�L\�xpq\0~\0sq\0~\0w\0\0nJ�L\�xpt\0\r0 0/1 * * * ?t\0!获取并更新应用发布状态t\01t\0\0sr\0java.lang.Integer⠤���8\0I\0valuexr\0java.lang.Number����\��\0\0xp\0\0\0t\0\nsystemTaskt\0syncBCStatusx\0');
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
INSERT INTO `qrtz_locks` VALUES ('isimScheduler','STATE_ACCESS'),('isimScheduler','TRIGGER_ACCESS');
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
INSERT INTO `qrtz_scheduler_state` VALUES ('isimScheduler','DESKTOP-9V549B51573207609146',1573208124494,15000);
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `idx_qrtz_t_j` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `idx_qrtz_t_jg` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `idx_qrtz_t_c` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `idx_qrtz_t_g` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `idx_qrtz_t_state` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `idx_qrtz_t_n_state` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `idx_qrtz_t_n_g_state` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `idx_qrtz_t_next_fire_time` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `idx_qrtz_t_nft_st` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `idx_qrtz_t_nft_misfire` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `idx_qrtz_t_nft_st_misfire` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `idx_qrtz_t_nft_st_misfire_grp` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
INSERT INTO `qrtz_triggers` VALUES ('isimScheduler','TASK_quartzId:69e4829a-e921-4cc7-aa5a-ee64a8bdc159','DEFAULT','TASK_quartzId:69e4829a-e921-4cc7-aa5a-ee64a8bdc159','DEFAULT',NULL,1573208100000,-1,5,'PAUSED','CRON',1573208083000,0,NULL,2,'');
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_task`
--

DROP TABLE IF EXISTS `quartz_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_task` (
  `id` varchar(50) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '任务名称,input,YES,false,true,true',
  `cron` varchar(255) DEFAULT NULL COMMENT '任务表达式,input,YES,false,true,false',
  `target_bean` varchar(255) DEFAULT NULL COMMENT '执行的类,input,YES,false,true,false',
  `trget_method` varchar(255) DEFAULT NULL COMMENT '执行方法,input,YES,false,true,false',
  `params` varchar(255) DEFAULT NULL COMMENT '执行参数,textarea,YES,false,false,false',
  `status` int(11) DEFAULT NULL COMMENT '任务状态,radio,YES,false,true,true',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '修改人',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_task`
--

LOCK TABLES `quartz_task` WRITE;
/*!40000 ALTER TABLE `quartz_task` DISABLE KEYS */;
INSERT INTO `quartz_task` VALUES ('quartzId:69e4829a-e921-4cc7-aa5a-ee64a8bdc159','获取并更新应用发布状态','0 0/1 * * * ?','systemTask','syncBCStatus','1',1,'2019-11-08 18:14:44','1','2019-11-08 18:14:44','1','',NULL);
/*!40000 ALTER TABLE `quartz_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quartz_task_log`
--

DROP TABLE IF EXISTS `quartz_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quartz_task_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `job_id` varchar(100) DEFAULT NULL COMMENT '任务ID,0,YES,false,false,false',
  `name` varchar(255) DEFAULT NULL COMMENT '定时任务名称,input,YES,false,true,true',
  `target_bean` varchar(255) DEFAULT NULL COMMENT '定制任务执行类,input,YES,false,true,false',
  `trget_method` varchar(255) DEFAULT NULL COMMENT '定时任务执行方法,input,YES,false,true,false',
  `params` varchar(255) DEFAULT NULL COMMENT '执行参数,input,YES,false,true,false',
  `status` int(11) DEFAULT NULL COMMENT '任务状态,0,YES,false,false,false',
  `error` text COMMENT '异常消息,textarea,YES,false,false,false',
  `times` int(11) DEFAULT NULL COMMENT '执行时间,input,YES,false,true,false',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '修改人',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='任务执行日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quartz_task_log`
--

LOCK TABLES `quartz_task_log` WRITE;
/*!40000 ALTER TABLE `quartz_task_log` DISABLE KEYS */;
INSERT INTO `quartz_task_log` VALUES (10,'quartzId:69e4829a-e921-4cc7-aa5a-ee64a8bdc159','执行定时任务【获取并更新应用发布状态】','systemTask','syncBCStatus','1',0,NULL,2538,'2019-11-08 18:15:07','1','2019-11-08 18:15:09','1',NULL,NULL);
/*!40000 ALTER TABLE `quartz_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_application_info`
--

DROP TABLE IF EXISTS `service_application_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_application_info` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `application_name` varchar(100) DEFAULT NULL COMMENT '应用名称',
  `application_hostname` varchar(100) DEFAULT NULL COMMENT '应用域名',
  `namespace` varchar(100) DEFAULT NULL COMMENT '项目空间',
  `memory_limit` bigint(20) DEFAULT NULL COMMENT '容器运行内存',
  `status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用状态',
  `service_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属服务',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_application_info_un` (`application_name`),
  UNIQUE KEY `service_application_info_un1` (`application_hostname`),
  KEY `service_application_info_fk` (`service_id`),
  CONSTRAINT `service_application_info_fk` FOREIGN KEY (`service_id`) REFERENCES `service_info` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务基本信息-应用信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_application_info`
--

LOCK TABLES `service_application_info` WRITE;
/*!40000 ALTER TABLE `service_application_info` DISABLE KEYS */;
INSERT INTO `service_application_info` VALUES ('service_app_infoId:029cbdb0-1f30-40ef-a3a7-ef175b701800','wsdl-app','wsdl-app-host','wsdlspace',1024,NULL,'service_infoId:762a0aa7-9f90-4679-93f2-bfbbe85b7267','1','2019-11-08 16:04:07','1','2019-11-08 16:06:24'),('service_app_infoId:de523d3a-42ba-4a20-985e-945821f05433','app-db','app-db-host','dbspace',1024,NULL,'service_infoId:37d00984-2293-4e76-83cd-df41cc5d2ab3','1','2019-11-08 15:06:40','1','2019-11-08 17:45:37'),('service_app_infoId:ee98e4de-fb61-46ae-b15a-9ea4707e9f07','app-wsdl','app-wsdl-host','wsdlSpace',1024,NULL,'service_infoId:72f9b330-0d9e-4c94-a4c2-5bcc699d0556','1','2019-11-08 15:13:32','1','2019-11-08 15:57:46'),('service_app_infoId:f5868038-7a02-41c7-a714-4456724cd6d6','app-open','app-open-host','openspace',1024,NULL,'service_infoId:b818a01b-dda2-43d7-be15-c080a231555a','1','2019-11-08 15:10:24','1','2019-11-08 15:10:24');
/*!40000 ALTER TABLE `service_application_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_camel_info`
--

DROP TABLE IF EXISTS `service_camel_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_camel_info` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `properties_info` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'camel application.properties配置文件',
  `component_info` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '服务类型为数据库时，componetConfig.properties配置信息',
  `cxf_info` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '服务类型为SOAP时，cxfEndpointConfig.xml配置信息',
  `service_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属服务',
  `properties_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件所属类型（DB,SOAP,OPENAPI）等同serviceType',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `service_camel_info_fk` (`service_id`),
  CONSTRAINT `service_camel_info_fk` FOREIGN KEY (`service_id`) REFERENCES `service_info` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务基本信息-camel配置信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_camel_info`
--

LOCK TABLES `service_camel_info` WRITE;
/*!40000 ALTER TABLE `service_camel_info` DISABLE KEYS */;
INSERT INTO `service_camel_info` VALUES ('service_camel_infoId:1bcce88c-0e6f-4793-b2c9-7b7514a316f6','server.port=8089\r\n# 必填 应用名称\r\nspring.application.name=openshift-wsdl-template-app\r\n# 非必填 Camel请求的目标URL（在WSDL模板中暂时无用）\r\ncamel.request.url=\r\n# 非必填 Camel请求超时时间\r\ncamel.request.timeout=\r\n# 非必填 WSDL接口返回的节点名称\r\nxml.elementName=Person\r\n\r\n#Token验证数据源配置\r\n# 必填 数据源名称\r\nspring.datasource.name=dbTemplateDataSource\r\n# 必填 数据源URL\r\nspring.datasource.url=jdbc:mysql://activity.simon.com:3306/fnshare?useUnicode=true&characterEncoding=utf8&useSSL=false&tinyInt1isBit=true\r\n# 必填 数据源驱动类型\r\nspring.datasource.driver-class-name=com.mysql.jdbc.Driver\r\n# 必填 数据库用户名\r\nspring.datasource.username=root\r\n# 必填 数据库密码\r\nspring.datasource.password=123456\r\n# 非必填 数据源连接超时时间\r\nspring.datasource.hikari.connection-timeout=600\r\n\r\n# Ampq connection configuration (\"amqp.host\" is overridden in Openshift using src/main/fabric8/deployment.yml)\r\n# 必填 MQ服务器地址\r\namqp.host=activity.simon.com\r\n# 必填 MQ服务器端口\r\namqp.port=5672\r\n# 必填 MQ用户名\r\namqp.username=admin\r\n# 必填 MQ密码\r\namqp.password=123456\r\n\r\n#Management 健康检查\r\n# 非必填 是否启用Management\r\nmanagement.endpoint.health.enabled=true\r\n\r\n#Camel Rest组件配置\r\n# 必填 是否启用rest的swagger插件(建议引用默认值)\r\ncamel.component.rest-swagger.enabled=true\r\n# 必填 提供给用户访问的Servlet上下文(建议引用默认值) 格式：/xxx/*\r\ncamel.component.servlet.mapping.context-path=/rest/*\r\n# 必填 Rest组件使用的类型(建议引用默认值)\r\ncamel.rest.component=servlet\r\n# 必填 接口请求host\r\ncamel.rest.host=wsdl-app-host-corepanel.apps.cluster-6ec8.6ec8.sandbox936.opentlc.com\r\n# 必填 Rest组件绑定的数据类型(建议引用默认值)\r\ncamel.rest.binding-mode=auto\r\n# 必填 Rest组件数据类型属性是否启用(建议引用默认值)\r\ncamel.rest.data-format-property[prettyPrint]=true\r\n# 必填 Rest组件是否启用cors功能(建议引用默认值)\r\ncamel.rest.enable-cors=true\r\n# 必填 Rest组件提供接口访问的端口\r\ncamel.rest.port=8080\r\n# 必填 Rest组件提供访问的上下文(此值要与camel.component.servlet.mapping.context-path进行对应)\r\ncamel.rest.context-path=/rest\r\n\r\n#rest DSL api-doc configuration\r\n# 必填 Rest组件api接口信息文档接口地址(建议引用默认值)\r\ncamel.rest.api-context-path=/api-doc\r\n# 必填 Rest组件设置Api接口标题\r\ncamel.rest.api-property[api.title]=User API\r\n# 必填 Rest组件设置Api接口版本号\r\ncamel.rest.api-property[api.version]=1.0.0\r\n\r\n#JWT 集成配置\r\n# 必填 JWT签发人\r\njwt.issuer=pactera\r\n# 必填 JWT加密密钥\r\njwt.general.key=4266b0d5735788e381fb1378ca1f5c34\r\n# 必填 JWT加密是否启用自定义时间长度（设置为true就需要注意设置jwt.effective.date的值）\r\njwt.effective.self.enable=false\r\n# 必填 JWT设置Token加密有效时间（单位毫秒）此属性只有在jwt.effective.self.enable设置为true情况下才生效\r\njwt.effective.date=1\r\n\r\n#WSDL服务配置\r\n# 非必填 WSDL目标服务URL (暂无使用)\r\ncamel.wsdl.url=http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx\r\n# 必填 WSDL模板发送给目标WSDL服务器的头部Content-Type属性值\r\ncamel.wsdl.request.header.content-Type=text/xml;charset=utf-8\r\n# 必填 WSDL发送xml的xmlns:soap值(建议引用默认值)\r\ncamel.wsdl.xmlnsSoap=http://www.w3.org/2003/05/soap-envelope\r\n# 必填 WSDL模板程序拼装标签名称\r\ncamel.wsdl.xmlnsWeb=http://WebXml.com.cn/\r\n# 必填 WSDL模板程序发送目标报文标签名称(建议引用默认值)\r\ncamel.wsdl.elementName=Envelope\r\n# 非必填 WSDL服务提供服务名称（暂无使用）\r\ncamel.wsdl.serviceName=qqOnlineWebService\r\n# 必填 WSDL服务提供服务结束名称（暂无使用）\r\ncamel.wsdl.endpointName=qqOnlineWebServiceSoap12\r\n# 必填 WSDL目标服务的命名空间\r\ncamel.wsdl.targetNamespace=http://WebXml.com.cn/\r\n# 必填 WSDL服务返回数据后，指定返回的JSON节点\r\ncamel.wsdl.return.jsonNode=newdataset\r\n# 必填 WSDL服务返回数据后，需要替换的节点配置（需要替换掉的特殊字符）\r\ncamel.json.format.split.str=@xmlns:;@msdata:;@minOccurs:;@xs:;@diffgr:;diffgr:;@\r\n# 非必填 WSDL服务返回数据后，需要删除的节点，指定需要删除的节点(暂无使用)需要删除的节点之间使用“;”进行分隔\r\ncamel.json.format.delete.node=xmlns;xs:schema;minOccurs:;xs:;diffgr:;name;IsDataSet;xs:schema;msdata\r\n\r\n',NULL,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<beans xmlns=\"http://www.springframework.org/schema/beans\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:cxf=\"http://camel.apache.org/schema/cxf\" xsi:schemaLocation=\"http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd                http://camel.apache.org/schema/cxf http://camel.apache.org/schema/cxf/camel-cxf.xsd\">\n    <!-- 必填 address - WSDL目标服务地址-->\n    <!-- 必填 serviceName - WSDL目标服务地址-->\n    <!-- 必填 endpointName - WSDL目标服务结束名称-->\n    <!-- 必填 xmlns:ns1 - WSDL目标服务命名空间-->\n    <cxf:cxfEndpoint xmlns:ns1=\"http://WebXml.com.cn/\" id=\"oneWayTtEndpoint\" address=\"http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx\" serviceName=\"ns1:qqOnlineWebService\" endpointName=\"ns1:qqOnlineWebServiceSoap12\">\n        <cxf:properties>\n            <entry key=\"dataFormat\" value=\"RAW\"/>\n            <entry key=\"schema-validation-enabled\" value=\"false\"/>\n            <entry key=\"exceptionMessageCauseEnabled\" value=\"true\"/>\n            <entry key=\"faultStackTraceEnabled\" value=\"true\"/>\n            <!-- 必填 wsdlURL WSDL目标的服务WSDL-->\n            <entry key=\"wsdlURL\" value=\"http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx?wsdl\"/>\n            <entry key=\"loggingFeatureEnabled\" value=\"true\"/>\n        </cxf:properties>\n    </cxf:cxfEndpoint>\n</beans>','service_infoId:762a0aa7-9f90-4679-93f2-bfbbe85b7267','soap','1','1','2019-11-08 16:04:07','2019-11-08 16:06:24'),('service_camel_infoId:58756c83-d787-4995-b839-50cbd5586310','',NULL,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<beans xmlns=\"http://www.springframework.org/schema/beans\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:cxf=\"http://camel.apache.org/schema/cxf\" xsi:schemaLocation=\"http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd                http://camel.apache.org/schema/cxf http://camel.apache.org/schema/cxf/camel-cxf.xsd\">\n    <!-- 必填 address - WSDL目标服务地址-->\n    <!-- 必填 serviceName - WSDL目标服务地址-->\n    <!-- 必填 endpointName - WSDL目标服务结束名称-->\n    <!-- 必填 xmlns:ns1 - WSDL目标服务命名空间-->\n    <cxf:cxfEndpoint xmlns:ns1=\"http://WebXml.com.cn/\" id=\"oneWayTtEndpoint\" address=\"http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx\" serviceName=\"ns1:qqOnlineWebService\" endpointName=\"ns1:qqOnlineWebServiceHttpGet\">\n        <cxf:properties>\n            <entry key=\"dataFormat\" value=\"RAW\"/>\n            <entry key=\"schema-validation-enabled\" value=\"false\"/>\n            <entry key=\"exceptionMessageCauseEnabled\" value=\"true\"/>\n            <entry key=\"faultStackTraceEnabled\" value=\"true\"/>\n            <!-- 必填 wsdlURL WSDL目标的服务WSDL-->\n            <entry key=\"wsdlURL\" value=\"http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx?wsdl\"/>\n            <entry key=\"loggingFeatureEnabled\" value=\"true\"/>\n        </cxf:properties>\n    </cxf:cxfEndpoint>\n</beans>','service_infoId:72f9b330-0d9e-4c94-a4c2-5bcc699d0556','soap','1','1','2019-11-08 15:13:32','2019-11-08 15:57:46'),('service_camel_infoId:d7fa8968-52ae-4a90-8c04-957d8876f951','','#select * from sys_user where id=\':id\'\r\n# update sys_log set type=\'Ajax\' where id=1 ??? insert into testTable(title,age) values(\':title\',:age)\r\n# sql-stored:simonupdate(VARCHAR ${headers.num1})  db\r\n# 必填 应用执行的SQL/存储过程\r\nservice.app.sql=sql:select * from dual;\r\n',NULL,'service_infoId:37d00984-2293-4e76-83cd-df41cc5d2ab3','db','1','1','2019-11-08 15:06:40','2019-11-08 17:45:37'),('service_camel_infoId:ea583930-1fef-492e-aede-8b2574e92417','# 必填 系统日志配置文件（建议引用默认配置即可）\r\nlogging.config=classpath:logback.xml\r\n# 必填 应用名称\r\nspring.application.name=\r\n# 必填 Rest组件请求目标接口的URL\r\ncamel.request.url=http://petstore.swagger.io/v2/pet/findByStatus\r\n# 必填 Rest组件请求超时时间\r\ncamel.request.timeout=6000\r\n# 必填 Rest组件返回XML数据格式时的根节点名称\r\nxml.elementName=\r\n\r\n#Token验证数据源配置\r\n# 必填 数据源名称\r\nspring.datasource.name=dbTemplateDataSource\r\n# 必填 数据源URL\r\nspring.datasource.url=jdbc:mysql://activity.simon.com:3306/fnshare?useUnicode=true&characterEncoding=utf8&useSSL=false&tinyInt1isBit=true\r\n# 必填 数据源驱动类型\r\nspring.datasource.driver-class-name=com.mysql.jdbc.Driver\r\n# 必填 数据源用户名称\r\nspring.datasource.username=root\r\n# 必填 数据源密码\r\nspring.datasource.password=123456\r\n# 必填 数据源超时时间设置\r\nspring.datasource.hikari.connection-timeout=600\r\n# the options from org.apache.camel.spring.boot.CamelConfigurationProperties can be configured here\r\n# 必填 应用运行端口\r\nserver.port=\r\n\r\n# lets listen on all ports to ensure we can be invoked from the pod IP\r\n# 非必填 应用允许运行ip（0.0.0.0表示没有限制）\r\nserver.address=0.0.0.0\r\n# 非必填 管理服务允许运行ip（0.0.0.0表示没有限制）\r\nmanagement.address=0.0.0.0\r\n\r\n# lets use a different management port in case you need to listen to HTTP requests on 8080\r\n# 非必填 管理服务运行监听端口\r\nmanagement.port=8081\r\n\r\n# Ampq connection configuration (\"amqp.host\" is overridden in Openshift using src/main/fabric8/deployment.yml)\r\n#Active MQ配置信息\r\n# 必填 MQ服务器地址\r\namqp.host=activity.simon.com\r\n# 必填 MQ服务器端口\r\namqp.port=5672\r\n# 必填 MQ服务器用户名\r\namqp.username=admin\r\n# 必填 MQ服务器密码\r\namqp.password=123456\r\n# 非必填 服务管理的健康检查是否启用\r\nmanagement.endpoint.health.enabled=true\r\n\r\n#Camel Rest组件配置信息\r\n# 必填 是否启用Rest组件中的swagger功能(建议引用默认值)\r\ncamel.component.rest-swagger.enabled=true\r\n# 必填 Rest组件提供给用户访问的Servlet上下文(建议引用默认值) 格式：/xxx/*\r\ncamel.component.servlet.mapping.context-path=/rest/*\r\n# 必填 接口请求host\r\ncamel.rest.host=app-open-host-corepanel.apps.cluster-6ec8.6ec8.sandbox936.opentlc.com\r\n# 必填 Rest组件映射Host\r\ncamel.rest.api-host=\r\n# 必填 Rest组件使用的类型(建议引用默认值)\r\ncamel.rest.component=servlet\r\n# 必填 Rest组件绑定的数据类型(建议引用默认值)\r\ncamel.rest.binding-mode=auto\r\n# 必填 Rest组件数据类型属性是否启用(建议引用默认值)\r\ncamel.rest.data-format-property[prettyPrint]=true\r\n# 必填 Rest组件是否启用cors功能(建议引用默认值)\r\ncamel.rest.enable-cors=true\r\n# 必填 Rest组件提供接口访问的端口\r\ncamel.rest.port=\r\n# 必填 Rest组件提供访问的上下文(此值要与camel.component.servlet.mapping.context-path进行对应)\r\ncamel.rest.context-path=/rest\r\n\r\n#rest DSL api-doc configuration\r\n# 必填 Rest组件api接口信息文档接口地址(建议引用默认值)\r\ncamel.rest.api-context-path=/api-doc\r\n# 必填 Rest组件设置Api接口的标题\r\ncamel.rest.api-property[api.title]=\r\n# 必填 Rest组件设置Api接口的版本号\r\ncamel.rest.api-property[api.version]=\r\n\r\n# 必填 JWT Token的签发人\r\njwt.issuer=pactera\r\n# 必填 JWT Toke加密密钥\r\njwt.general.key=4266b0d5735788e381fb1378ca1f5c34\r\n# 必填 JWT加密是否启用自定义时间长度（设置为true就需要注意设置jwt.effective.date的值）\r\njwt.effective.self.enable=false\r\n# 必填 JWT设置Token加密有效时间（单位毫秒）此属性只有在jwt.effective.self.enable设置为true情况下才生效\r\njwt.effective.date=1\r\n',NULL,NULL,'service_infoId:b818a01b-dda2-43d7-be15-c080a231555a','rest','1','1','2019-11-08 15:10:24','2019-11-08 15:10:24');
/*!40000 ALTER TABLE `service_camel_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_info`
--

DROP TABLE IF EXISTS `service_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_info` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `service_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '服务名称',
  `service_system` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属系统',
  `service_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属分类',
  `service_second_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属分类-二级',
  `service_status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '服务状态;1:服务审批通过;2:服务接口审批通过;3:服务接口发布',
  `deploy_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `version` varchar(100) DEFAULT NULL COMMENT '版本',
  `description` varchar(100) DEFAULT NULL COMMENT '功能说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务基本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_info`
--

LOCK TABLES `service_info` WRITE;
/*!40000 ALTER TABLE `service_info` DISABLE KEYS */;
INSERT INTO `service_info` VALUES ('service_infoId:37d00984-2293-4e76-83cd-df41cc5d2ab3','DB服务','f78af4b4-d69d-4b8e-b33b-1535af0cbfd1','1','2',NULL,NULL,'1','1','2019-11-08 15:06:40','2019-11-08 17:45:37','1.0.0','服务功能说明'),('service_infoId:72f9b330-0d9e-4c94-a4c2-5bcc699d0556','WSDL服务','f78af4b4-d69d-4b8e-b33b-1535af0cbfd1','1','3',NULL,NULL,'1','1','2019-11-08 15:13:32','2019-11-08 15:57:46','1.0.1','WSDL功能说明'),('service_infoId:762a0aa7-9f90-4679-93f2-bfbbe85b7267','WSDL服务1','f78af4b4-d69d-4b8e-b33b-1535af0cbfd1','1','5',NULL,NULL,'1','1','2019-11-08 16:03:26','2019-11-08 16:06:24','版本1',''),('service_infoId:b818a01b-dda2-43d7-be15-c080a231555a','OpenApi服务','f78af4b4-d69d-4b8e-b33b-1535af0cbfd1','1','2',NULL,NULL,'1','1','2019-11-08 15:10:24','2019-11-08 15:10:24','1.0.1','OpenApi功能说明');
/*!40000 ALTER TABLE `service_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_interface_info`
--

DROP TABLE IF EXISTS `service_interface_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_interface_info` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `service_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属服务ID',
  `request_obj_id` varchar(100) DEFAULT NULL COMMENT '请求方接口ID',
  `description` varchar(100) DEFAULT NULL COMMENT '业务场景描述',
  `service_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '服务类型',
  `edit_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '编辑模式',
  `db_type` varchar(100) DEFAULT NULL COMMENT '数据库类型',
  `db_host` varchar(100) DEFAULT NULL COMMENT '数据库地址',
  `db_operate_type` varchar(100) DEFAULT NULL COMMENT '数据库操作类型',
  `sql` varchar(2000) DEFAULT NULL COMMENT 'SQL语句',
  `wsdl_url` varchar(100) DEFAULT NULL COMMENT 'wsdl路径',
  `wsdl_func` varchar(100) DEFAULT NULL COMMENT 'wsdl方法',
  `openapi_url` varchar(100) DEFAULT NULL COMMENT 'openAPI路径',
  `openapi_func` varchar(100) DEFAULT NULL COMMENT 'openAPI方法',
  `access_token` varchar(100) DEFAULT NULL COMMENT '授权码',
  `tag` varchar(100) DEFAULT NULL COMMENT '标签',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `service_interface_info_fk` (`service_id`),
  CONSTRAINT `service_interface_info_fk` FOREIGN KEY (`service_id`) REFERENCES `service_info` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务接口信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_interface_info`
--

LOCK TABLES `service_interface_info` WRITE;
/*!40000 ALTER TABLE `service_interface_info` DISABLE KEYS */;
INSERT INTO `service_interface_info` VALUES ('service_itf_infoId:0f126b6f-b229-4da3-bef3-6eaa31340638','service_infoId:b818a01b-dda2-43d7-be15-c080a231555a','c6d99b3d-3840-9b56-dff3-077ceb7207de','OpenApi场景说明','rest','form','','','','','','','https://petstore.swagger.io/v2/swagger.json','/pet/findByStatus','','','1','1','2019-11-08 15:10:24','2019-11-08 15:10:24'),('service_itf_infoId:28a5a515-b2d6-4c97-80c3-c7d6fe062c52','service_infoId:37d00984-2293-4e76-83cd-df41cc5d2ab3','089e8198-411f-bf7c-1c66-79b9514d0afe','场景描述','db','form','Oracle','sys_databaseId:54afc11a-91fe-4fab-8eac-2198eb709e96','select','select * from dual;','','','','','','','1','1','2019-11-08 15:06:40','2019-11-08 17:45:37'),('service_itf_infoId:ce1593a7-bc98-4320-95b1-3e49a44fb391','service_infoId:762a0aa7-9f90-4679-93f2-bfbbe85b7267','2af679d4-71e4-d268-55fd-df0f2aaaf7bd','场景描述','soap','form','','','','','http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx?wsdl','qqOnlineWebServiceSoap12:qqCheckOnline','','','','','1','1','2019-11-08 16:04:07','2019-11-08 16:06:24'),('service_itf_infoId:fbfe697f-3fef-4542-9d23-34de40231950','service_infoId:72f9b330-0d9e-4c94-a4c2-5bcc699d0556','b266b3cb-45c4-796c-37bf-2bc1aea0c6b2','WDSL场景描述','soap','form','','','','','http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx?wsdl','qqOnlineWebServiceHttpGet:qqCheckOnline','','','','','1','1','2019-11-08 15:13:32','2019-11-08 15:57:46');
/*!40000 ALTER TABLE `service_interface_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_metadata_class`
--

DROP TABLE IF EXISTS `service_metadata_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_metadata_class` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `name` varchar(100) DEFAULT NULL COMMENT '元数据名称',
  `pid` varchar(100) DEFAULT NULL COMMENT '父级元数据Id',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务元数据-分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_metadata_class`
--

LOCK TABLES `service_metadata_class` WRITE;
/*!40000 ALTER TABLE `service_metadata_class` DISABLE KEYS */;
INSERT INTO `service_metadata_class` VALUES ('1','元数据1',NULL,'元数据1',NULL,'2018-10-17 10:57:00',NULL,'2018-10-17 10:57:00'),('13','元数据13',NULL,'元数据13',NULL,'2018-10-17 10:57:00',NULL,'2018-10-17 10:57:00'),('2','元数据2','1','元数据2',NULL,'2018-10-17 10:57:00','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-17 15:17:02'),('3','元数据3','1','元数据Awe',NULL,NULL,'cba1b6b6-466e-4b6e-8904-ab9645fd64c3','2019-10-24 10:10:46'),('4','元数据4','1','元数据4',NULL,'2018-10-17 10:57:00',NULL,'2018-10-17 10:57:00'),('5','元数据5','1','元数据5',NULL,'2018-10-17 10:57:00',NULL,'2018-10-17 10:57:00'),('6','元数据6','1','元数据6',NULL,'2018-10-17 10:57:00',NULL,'2018-10-17 10:57:00'),('7','元数据7','1','元数据7',NULL,'2018-10-17 10:57:00',NULL,'2018-10-17 10:57:00'),('sys_metaId:e68fd1e0-b946-4578-8649-e007c2acadb6','元数据14',NULL,'元数据14','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-17 14:58:57','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-17 14:58:57'),('sys_meta_clsId:2a882335-f510-4cb7-ba7a-8197f5e9b18a','元数据144','sys_metaId:e68fd1e0-b946-4578-8649-e007c2acadb6','元数据144','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-24 15:05:43','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-24 15:05:43'),('sys_meta_clsId:9ef0a1b6-0cd9-428e-b4f4-17a93d9513d5','元数据133','13','元数据133','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-24 15:05:32','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-24 15:05:32');
/*!40000 ALTER TABLE `service_metadata_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_request_params`
--

DROP TABLE IF EXISTS `service_request_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_request_params` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `service_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属服务ID',
  `param_type` varchar(100) DEFAULT NULL COMMENT '参数类型',
  `param_name` varchar(100) DEFAULT NULL COMMENT '参数名称',
  `required` varchar(100) DEFAULT NULL COMMENT '是否必须',
  `type` varchar(100) DEFAULT NULL COMMENT '类型',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `service_request_params_fk` (`service_id`),
  CONSTRAINT `service_request_params_fk` FOREIGN KEY (`service_id`) REFERENCES `service_info` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务基本信息-请求参数';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_request_params`
--

LOCK TABLES `service_request_params` WRITE;
/*!40000 ALTER TABLE `service_request_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_request_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_response_params`
--

DROP TABLE IF EXISTS `service_response_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_response_params` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `service_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属服务',
  `param_name` varchar(100) DEFAULT NULL COMMENT '参数名称',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `service_response_params_fk` (`service_id`),
  CONSTRAINT `service_response_params_fk` FOREIGN KEY (`service_id`) REFERENCES `service_info` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_response_params`
--

LOCK TABLES `service_response_params` WRITE;
/*!40000 ALTER TABLE `service_response_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_response_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
  `id` varchar(255) NOT NULL COMMENT 'UUID',
  `dept_code` varchar(255) DEFAULT NULL COMMENT '部门编码',
  `dept_name` varchar(255) DEFAULT NULL COMMENT '部门名称',
  `short_name` varchar(255) DEFAULT NULL COMMENT '部门简称',
  `dept_type` varchar(255) DEFAULT NULL COMMENT '部门类型',
  `contact_person` varchar(255) DEFAULT NULL COMMENT '联系人',
  `contact` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `foundTime` datetime DEFAULT NULL COMMENT '成立日期',
  `sort` bigint(255) DEFAULT NULL COMMENT '顺序',
  `dept_desc` varchar(255) DEFAULT NULL COMMENT '部门描述',
  `del_flag` varchar(255) DEFAULT NULL COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES ('sys_deptId:035fdce7-ad6c-4631-95dc-c1428075b518','FN023','阜宁县文化广电和旅游局','文广和旅游局','SYDT02','张三丰','1231313123123','阜宁上海路...','2019-07-16 00:00:00',23,'阜宁县文化广电和旅游局','0',NULL,'2019-07-18 01:38:35','1','2019-09-11 07:13:01',NULL),('sys_deptId:15285f1f-d91d-47fe-aebd-b3d4e8dbfaa8','FN031','阜宁县统计局','统计局',NULL,NULL,NULL,NULL,NULL,31,'阜宁县统计局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:159bf0ce-6812-4cbf-8ab0-99c01fdaa6af','FN004','阜宁县教育局','教育局','SYDT01',NULL,NULL,NULL,NULL,455,'阜宁县教育局','0',NULL,'2019-07-18 01:50:21','1','2019-09-11 07:13:00',NULL),('sys_deptId:175ce032-3d6d-497d-8b61-72813e6f90aa','FN019','阜宁县交通运输局','交通局',NULL,NULL,NULL,NULL,NULL,19,'阜宁县交通运输局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:01',NULL),('sys_deptId:1a6d93de-4960-4038-ac92-77f16eb8258b','FN035','阜宁县民族宗教事务局','民宗局','SYDT04',NULL,NULL,NULL,'2019-07-24 00:00:00',35,'阜宁县民族宗教事务局','0',NULL,'2019-07-18 01:50:12','1','2019-09-11 07:13:02',NULL),('sys_deptId:1c1a1470-776b-425c-a561-8ca83683b1fc','FN026','阜宁县退役军人事务局','退役军人事务局',NULL,NULL,NULL,NULL,NULL,26,'阜宁县退役军人事务局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:201535b8-6952-4c69-a61b-01e301eb2be8','FN001','阜宁县政府办公室','办公室',NULL,NULL,NULL,NULL,NULL,1,'阜宁县办公室','0',NULL,'2019-07-15 07:05:12','','2019-09-11 07:13:00',NULL),('sys_deptId:42cd982c-e857-4e98-bc37-212464f4977a','FN022','阜宁县商务局','商务局',NULL,NULL,NULL,NULL,NULL,22,'阜宁县商务局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:48137b07-4ac1-4d60-a94d-47026a3cfbbd','FN027','阜宁县应急管理局','应急局',NULL,NULL,NULL,NULL,NULL,27,'阜宁县应急管理局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:4dd59e40-8d51-4f95-a7d9-c52e3ea10769','FN030','阜宁县市场监督管理局','市监局',NULL,NULL,NULL,NULL,NULL,30,'阜宁县市场监督管理局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:5c0355d3-a100-49ed-9f62-d77086988590','FN034','阜宁县地方金融监督管理局','金融监督局',NULL,NULL,NULL,NULL,NULL,34,'阜宁县地方金融监督管理局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:6288a033-baff-4d43-8c1e-ac6589f9637d','FN005','阜宁县科学技术局','科学技术局',NULL,NULL,NULL,NULL,NULL,5,'阜宁县科学技术局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:68fe916c-2f6a-42b6-a47d-dc2d989bc004','FN008','阜宁县民政局','民政局',NULL,NULL,NULL,NULL,NULL,8,'阜宁县民政局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:6b20253b-875b-4d05-9ee0-2c237007e021','FN014','阜宁县人力资源和社会保障局','人社局',NULL,NULL,NULL,NULL,NULL,14,'阜宁县人力资源和社会保障局','0',NULL,'2019-07-15 07:08:01','','2019-09-11 07:13:00',NULL),('sys_deptId:6c8007c6-a24f-4423-9ca3-c2cf9c5a084f','FN036','阜宁县气象局','气象局','SYDT03','王石','13111111111','guangzhou, gangzhou','2019-07-17 00:00:00',366,'阜宁县气象局','0',NULL,'2019-07-18 01:44:06','1','2019-09-11 07:13:02',NULL),('sys_deptId:7028b299-7d75-4d50-9711-0af03c83fc96','FN021','阜宁县农业农村局','农业局',NULL,NULL,NULL,NULL,NULL,21,'阜宁县农业农村局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:7950fd82-93a6-4424-ab43-d8dda81e4933','FN012','阜宁县财政局','财政局',NULL,NULL,NULL,NULL,NULL,12,'阜宁县财政局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:7b1d8c33-6973-43bf-9ec9-e1d18ff483e6','FN017','阜宁县住房和城乡建设局','住建局',NULL,NULL,NULL,NULL,NULL,17,'阜宁县住房和城乡建设局','0',NULL,'2019-07-15 07:08:01','','2019-09-11 07:13:01',NULL),('sys_deptId:82925627-8963-4282-8b62-60802ed13a83','FN003','阜宁县发展和改革委员会','发改委',NULL,NULL,NULL,NULL,NULL,3,'阜宁县发展和改革委员会','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:887f3590-c86c-402b-b205-369d89a2fea3','FN010','阜宁县人民法院','法院',NULL,NULL,NULL,NULL,NULL,10,'阜宁县人民法院','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:89024dd6-73ad-4575-acc9-1e97daf9b483','FN028','阜宁县审计局','审计局',NULL,NULL,NULL,NULL,NULL,28,'阜宁县审计局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:892337c3-24ef-4118-9402-68f4ef293683','FN018','阜宁县城市管理局','城市管理局',NULL,NULL,NULL,NULL,NULL,18,'阜宁县城市管理局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:01',NULL),('sys_deptId:8c46d790-1912-41fd-b1d3-f9760d20d1a4','FN006','阜宁县工业和信息化局','工信局',NULL,NULL,NULL,NULL,NULL,6,'阜宁县工业和信息化局','0',NULL,'2019-07-15 07:08:00','','2019-09-11 07:13:00',NULL),('sys_deptId:910270f1-19dd-4e31-a114-9bdcfbea007e','FN025','阜宁县卫生健康委员会','卫健委',NULL,NULL,NULL,NULL,NULL,25,'阜宁县卫生健康委员会','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:9374c48e-ba58-40c1-9311-2384ec692b49','FN013','阜宁县税务局','税务局',NULL,NULL,NULL,NULL,NULL,13,'阜宁县税务局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:951cfe8b-0c86-4c54-b159-d258cbbf50b0','FN002','阜宁县委机构编制委员会办公室','编制办',NULL,NULL,NULL,NULL,NULL,2,'阜宁县委机构编制委员会办公室','0',NULL,'2019-07-15 07:05:13','','2019-09-11 07:13:00',NULL),('sys_deptId:9a085f45-9601-4376-a763-5cc2acbd8cea','FN015','阜宁县自然资源和规划局','规划局',NULL,NULL,NULL,NULL,NULL,15,'阜宁县自然资源和规划局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:01',NULL),('sys_deptId:a03b98e8-c615-4144-8ecc-a6d141bbbaca','FN024','阜宁县新闻出版局','新闻出版局',NULL,NULL,NULL,NULL,NULL,24,'阜宁县新闻出版局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:c0599117-3433-4e02-9962-8408ca4c4ded','FN007','阜宁县公安局','公安局',NULL,NULL,NULL,NULL,NULL,7,'阜宁县公安局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:c321ca4c-ef53-4958-8d3d-025b39eed429','FN029','阜宁县行政审批局','审批局',NULL,NULL,NULL,NULL,NULL,29,'阜宁县行政审批局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:cec5f422-794c-4906-a458-2f07da32eb2e','FN011','阜宁县人民检察院','检察院',NULL,NULL,NULL,NULL,NULL,11,'阜宁县人民检察院','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:cf430756-7d2d-4b8d-91e1-2eff3b23617e','FN033','阜宁县信访局','信访局',NULL,NULL,NULL,NULL,NULL,33,'阜宁县信访局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:cf64712c-599c-48b1-a320-664f36c216a5','FN009','阜宁县司法局','司法局',NULL,NULL,NULL,NULL,NULL,9,'阜宁县司法局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:00',NULL),('sys_deptId:d7a7aaf7-cb70-4040-9bbb-98ec8b95c2f0','FN032','阜宁县医疗保障局','医保局',NULL,NULL,NULL,NULL,NULL,32,'阜宁县医疗保障局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:f6e383d4-0e20-498c-b156-8a0269050090','FN020','阜宁县水务局','水务局',NULL,NULL,NULL,NULL,NULL,20,'阜宁县水务局','0',NULL,'2019-07-15 07:05:18','','2019-09-11 07:13:01',NULL),('sys_deptId:fc97f263-68df-4696-b700-be1b6264057f','FN016','阜宁县环境保护局','环保局',NULL,NULL,NULL,NULL,NULL,16,'阜宁县环境保护局','0',NULL,'2019-07-15 07:05:17','','2019-09-11 07:13:01',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict` (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '编号',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '数据值',
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '标签名',
  `parent_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '上级字典ID',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `sort` int(10) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`code`) USING BTREE,
  KEY `sys_dict_label` (`label`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict`
--

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
INSERT INTO `sys_dict` VALUES ('0','0','根节点','0',NULL,0,'1','2019-07-02 17:20:12','1','2019-07-02 17:20:47',NULL,'0'),('1','A01','行业','0','行业1',0,'1','2018-01-05 20:38:12','1','2019-07-02 17:04:24',NULL,'0'),('108','A02002','黑色主题','2','黑色主题',1,'1','2018-01-16 16:03:12','1','2019-07-03 10:47:36',NULL,'0'),('110','322','白色主题','2','白色主题22',2,'1','2018-01-16 17:52:49','1','2019-07-02 16:51:37',NULL,'0'),('2','A02','主题','0','主题',1,'1','2018-01-05 20:38:40','1','2018-01-05 20:38:44',NULL,'0'),('3','A01001','农、林、牧、渔业','1','农、林、牧、渔业',0,'1','2018-01-14 06:39:57','1','2018-01-14 06:39:57',NULL,'0'),('4','A01002','采矿业','1','采矿业',1,'1','2018-01-14 06:39:57','1','2018-01-14 06:39:57',NULL,'0'),('sys_dictId:02179269-ead3-40fd-bc46-2505ccd48add','PL02','层次2','sys_dictId:cfe24103-4017-4d67-9277-75b77c56b683',NULL,0,'1','2019-07-10 11:31:45','1','2019-07-10 11:31:45',NULL,'0'),('sys_dictId:0568340e-a942-4464-a5c4-de3e3d122932','OrgType','组织类型','0',NULL,0,'1','2019-07-12 11:39:35','1','2019-07-12 11:39:35',NULL,'0'),('sys_dictId:05ef91f5-365f-4258-9a9a-fabccb03d6e1','VIT01','视图组成1','sys_dictId:fb9ce1af-4cb0-410c-9525-20015e94dac2',NULL,0,'1','2019-07-07 17:45:56','1','2019-07-07 17:45:56',NULL,'0'),('sys_dictId:084143ac-8af4-4e9d-8873-d5af358d0df0','PssPry','优先级','0',NULL,0,'1','2019-07-10 17:36:46','1','2019-07-10 17:36:46',NULL,'0'),('sys_dictId:08e725db-f4f5-4933-85d8-14e36e549fbe','R02','用户定义','sys_dictId:ff8bcbb1-b024-4ead-a3e4-84d9f1487593',NULL,0,'1','2019-07-03 10:59:07','1','2019-07-03 10:59:07',NULL,'0'),('sys_dictId:0c8742e2-e255-42a6-ba06-0fe910bfbdda','DT001','内设科室','sys_dictId:aff2d704-ee54-4088-b118-15cc677088ea',NULL,0,'1','2019-07-05 10:28:09','1','2019-07-05 10:28:09',NULL,'0'),('sys_dictId:0ed8d8cd-1cb8-4a07-b179-47b6e23cbfe0','VT02','视图类型2','sys_dictId:99f47230-353f-4447-ae58-ec24f231ee1d',NULL,0,'1','2019-07-07 14:21:46','1','2019-07-07 14:21:46',NULL,'0'),('sys_dictId:1277e9be-7254-4cfb-bfee-56e43f1f5835','ModelingTypeList','建模方式','0',NULL,0,'1','2019-07-08 00:09:55','1','2019-07-08 00:09:55',NULL,'0'),('sys_dictId:1366b715-b510-492b-9b0e-c606916838db','DocType','文档分类','0',NULL,0,'1','2019-07-05 17:23:46','1','2019-07-05 17:23:46',NULL,'0'),('sys_dictId:2151126a-fc0a-4077-a539-e072f5efc7e0','EDT01','字符型','sys_dictId:a5a9b145-9794-401e-b9f4-b2d6aa3b5b57',NULL,0,'1','2019-07-08 18:12:45','1','2019-07-08 18:12:45',NULL,'0'),('sys_dictId:236680b6-dc4b-46a2-b019-f7bab995677b','PssFuncClass','应用功能分类','0',NULL,0,'1','2019-07-10 16:05:45','1','2019-07-10 16:05:45',NULL,'0'),('sys_dictId:2c183693-9b9d-4be7-9865-adedec5e0960','VthemeType','主题类型','0',NULL,0,'1','2019-07-08 00:08:18','1','2019-07-08 00:08:18',NULL,'0'),('sys_dictId:33a5dbb5-b1ce-456c-a13f-538e97e79b27','menu','菜单','0',NULL,0,'1','2019-07-02 17:19:57','1','2019-07-02 17:19:57',NULL,'0'),('sys_dictId:3703849c-53d7-4979-800d-c17b12fff64b','VT01','视图类型1','sys_dictId:99f47230-353f-4447-ae58-ec24f231ee1d',NULL,0,'1','2019-07-07 14:21:17','1','2019-07-07 14:21:17',NULL,'0'),('sys_dictId:3ad8bea8-2caf-4908-8e41-cfd0bebce955','PS01','阶段1','sys_dictId:cb348f92-2554-4e86-84b7-225d9d909a7a',NULL,0,'1','2019-07-10 11:32:37','1','2019-07-10 11:32:37',NULL,'0'),('sys_dictId:3bfbbff0-543e-4a96-8df8-4e22f3e5b449','SYDT01','政府机关','sys_dictId:f548f608-1f90-4ba2-bfa9-3e0a8cb1236d',NULL,0,'1','2019-07-18 09:23:23','1','2019-07-18 09:23:23',NULL,'0'),('sys_dictId:3c9677d8-b3d7-48d4-b974-a7c655df4b2e','gz','广州','sys_dictId:f26439a0-a9b3-4817-ad18-303808d8d8cd',NULL,0,'1','2019-07-02 16:08:26','1','2019-07-02 16:53:27',NULL,'0'),('sys_dictId:4213c449-ba3e-45d0-b619-25c56b9020be','PFC01','分类1','sys_dictId:236680b6-dc4b-46a2-b019-f7bab995677b',NULL,0,'1','2019-07-10 16:06:10','1','2019-07-10 16:06:10',NULL,'0'),('sys_dictId:44033809-8a43-4507-8297-f122ed038a18','PS02','阶段2','sys_dictId:cb348f92-2554-4e86-84b7-225d9d909a7a',NULL,0,'1','2019-07-10 11:32:55','1','2019-07-10 11:32:55',NULL,'0'),('sys_dictId:4a2bb52d-7252-4edf-908f-ee62e04533fb','SYDT03','党委机关','sys_dictId:f548f608-1f90-4ba2-bfa9-3e0a8cb1236d',NULL,0,'1','2019-07-18 09:24:13','1','2019-07-18 09:24:13',NULL,'0'),('sys_dictId:4d9ac2a0-40bb-4fab-a21e-c0e76a8336e1','PDM01','开发模式01','sys_dictId:f0372424-3a3d-4b12-852a-8dd2fe070563',NULL,0,'1','2019-07-10 11:33:17','1','2019-07-10 11:34:27',NULL,'0'),('sys_dictId:5386ad7e-f5d6-4d98-8162-0807d214a820','PPY02','中','sys_dictId:084143ac-8af4-4e9d-8873-d5af358d0df0',NULL,0,'1','2019-07-10 17:37:41','1','2019-07-10 17:37:41',NULL,'0'),('sys_dictId:59ef2c02-1033-4208-a1a4-77a35987e6c9','BT01','类型1','sys_dictId:a4bfec83-f271-4fba-bf30-b839afbabbc7',NULL,0,'1','2019-07-06 12:04:58','1','2019-07-06 12:04:58',NULL,'0'),('sys_dictId:6bd78799-85b2-4913-8c09-f68182b1304a','OT2','监察机关','sys_dictId:0568340e-a942-4464-a5c4-de3e3d122932',NULL,0,'1','2019-07-12 11:40:49','1','2019-07-12 13:51:51',NULL,'0'),('sys_dictId:7439a3b2-908a-4168-a42d-9bb54595c79d','Doc04','数据映射图','sys_dictId:1366b715-b510-492b-9b0e-c606916838db',NULL,0,'1','2019-07-05 17:25:22','1','2019-07-05 17:25:22',NULL,'0'),('sys_dictId:7accfcdf-cb3a-4097-875d-16b18abce4f2','MT02','建模方式2','sys_dictId:1277e9be-7254-4cfb-bfee-56e43f1f5835',NULL,0,'1','2019-07-08 00:10:35','1','2019-07-08 00:10:35',NULL,'0'),('sys_dictId:7b23d325-a81a-4ec8-a42d-40c88085f297','PssCplx','复杂度','0',NULL,0,'1','2019-07-10 17:35:15','1','2019-07-10 17:35:15',NULL,'0'),('sys_dictId:85964aef-810e-4b08-af9c-bc62975e7586','PCX02','一般','sys_dictId:7b23d325-a81a-4ec8-a42d-40c88085f297',NULL,0,'1','2019-07-10 17:36:05','1','2019-07-10 17:36:05',NULL,'0'),('sys_dictId:85e371bf-4de6-4c15-9c5f-5565194cb21f','Doc03','实体关系图','sys_dictId:1366b715-b510-492b-9b0e-c606916838db',NULL,0,'1','2019-07-05 17:25:02','1','2019-07-05 17:25:02',NULL,'0'),('sys_dictId:87c31e5b-8086-44ce-a080-b8aed3690f8a','PDM02','开发模式02','sys_dictId:f0372424-3a3d-4b12-852a-8dd2fe070563',NULL,0,'1','2019-07-10 11:34:49','1','2019-07-10 11:34:49',NULL,'0'),('sys_dictId:8b29f9d3-fab6-4830-8371-99deb97a5702','EDT02','数值型','sys_dictId:a5a9b145-9794-401e-b9f4-b2d6aa3b5b57',NULL,0,'1','2019-07-08 18:13:23','1','2019-07-08 18:13:23',NULL,'0'),('sys_dictId:8e8858e7-996e-4559-a74d-605ac29a9cbb','VIT02','视图组成2','sys_dictId:fb9ce1af-4cb0-410c-9525-20015e94dac2',NULL,0,'1','2019-07-07 17:46:19','1','2019-07-07 17:46:19',NULL,'0'),('sys_dictId:91fb2f98-4a5a-484b-8eed-71254c3815f9','BusItemType','事项类别','0',NULL,0,'1','2019-07-06 15:00:09','1','2019-07-06 15:01:33',NULL,'0'),('sys_dictId:923cffd4-77f8-4c2e-ac5b-878bfda472c7','BIT02','事项类别-2','sys_dictId:91fb2f98-4a5a-484b-8eed-71254c3815f9',NULL,0,'1','2019-07-06 15:01:19','1','2019-07-06 15:01:19',NULL,'0'),('sys_dictId:96617bf3-364a-470e-bc07-bf34273f863a','Doc02','系统设计文档','sys_dictId:1366b715-b510-492b-9b0e-c606916838db',NULL,0,'1','2019-07-05 17:24:34','1','2019-07-05 17:24:34',NULL,'0'),('sys_dictId:99f47230-353f-4447-ae58-ec24f231ee1d','ViewType','视图类型','0',NULL,0,'1','2019-07-07 14:20:55','1','2019-07-07 14:20:55',NULL,'0'),('sys_dictId:9e92dc45-4319-453c-8595-2d6f7ba43d0d','shengfen','省份','0',NULL,0,'1','2019-07-02 16:08:49','1','2019-07-02 16:08:49',NULL,'0'),('sys_dictId:a22c33c4-b5c2-48cd-9f91-c10b152adca5','quartz_task_status','定时任务-任务状态','0',NULL,0,'1','2019-07-15 15:33:41','1','2019-07-15 15:33:41',NULL,'0'),('sys_dictId:a34aec95-a93e-4c2e-b080-5a3d7345c3ac','SYDT02','检察机关','sys_dictId:f548f608-1f90-4ba2-bfa9-3e0a8cb1236d',NULL,0,'1','2019-07-18 09:23:50','1','2019-07-18 09:23:50',NULL,'0'),('sys_dictId:a4bfec83-f271-4fba-bf30-b839afbabbc7','BusType','业务域类型','0',NULL,0,'1','2019-07-06 12:04:01','1','2019-07-06 12:04:01',NULL,'0'),('sys_dictId:a5a9b145-9794-401e-b9f4-b2d6aa3b5b57','EntityDataType','数据类型','0',NULL,0,'1','2019-07-08 18:11:40','1','2019-07-08 18:11:40',NULL,'0'),('sys_dictId:a95e3e63-63da-4a70-bdb2-47941a090bf2','PL01','层次1','sys_dictId:cfe24103-4017-4d67-9277-75b77c56b683',NULL,0,'1','2019-07-10 11:31:03','1','2019-07-10 11:31:03',NULL,'0'),('sys_dictId:abde5654-3692-4035-8813-97a2223b8eda','PPY01','高','sys_dictId:084143ac-8af4-4e9d-8873-d5af358d0df0',NULL,0,'1','2019-07-10 17:37:20','1','2019-07-10 17:37:20',NULL,'0'),('sys_dictId:abe18e35-3c6f-41b5-95b2-8d42db5cec49','PFC02','分类2','sys_dictId:236680b6-dc4b-46a2-b019-f7bab995677b',NULL,0,'1','2019-07-10 16:06:27','1','2019-07-10 16:06:27',NULL,'0'),('sys_dictId:ae38a7a0-1f72-4fe8-bcac-04b3a1ad329f','DT002','下属单位','sys_dictId:aff2d704-ee54-4088-b118-15cc677088ea',NULL,0,'1','2019-07-05 10:28:42','1','2019-07-05 10:28:42',NULL,'0'),('sys_dictId:aff2d704-ee54-4088-b118-15cc677088ea','DeptType','部门类型','0','组织机构-内设部门-部门类型',0,'1','2019-07-05 10:27:38','1','2019-07-05 10:27:38',NULL,'0'),('sys_dictId:b87ac89f-97f8-4945-a26e-f2055be85ece','BT02','类型2','sys_dictId:a4bfec83-f271-4fba-bf30-b839afbabbc7',NULL,0,'1','2019-07-06 12:05:25','1','2019-07-06 12:05:25',NULL,'0'),('sys_dictId:bc814c10-1942-48e3-9cbf-a4bee906723d','R01','系统默认','sys_dictId:ff8bcbb1-b024-4ead-a3e4-84d9f1487593',NULL,0,'1','2019-07-03 10:58:48','1','2019-07-03 10:58:48',NULL,'0'),('sys_dictId:bd5c0819-b255-471f-b287-040ed7115c8a','A020021','黑色主题11','2',NULL,0,'1','2019-07-03 10:43:31','1','2019-07-03 10:43:31',NULL,'0'),('sys_dictId:c62608ec-973e-4d3f-b657-1888f5b5d7cc','PPY03','低','sys_dictId:084143ac-8af4-4e9d-8873-d5af358d0df0',NULL,0,'1','2019-07-10 17:37:53','1','2019-07-10 17:37:53',NULL,'0'),('sys_dictId:c680ce78-effd-49ce-9598-a5b72dfe8325','MT01','建模方式1','sys_dictId:1277e9be-7254-4cfb-bfee-56e43f1f5835',NULL,0,'1','2019-07-08 00:10:18','1','2019-07-08 00:10:18',NULL,'0'),('sys_dictId:cb348f92-2554-4e86-84b7-225d9d909a7a','PssStage','应用阶段','0',NULL,0,'1','2019-07-10 11:32:10','1','2019-07-10 11:32:10',NULL,'0'),('sys_dictId:cfe24103-4017-4d67-9277-75b77c56b683','PssLeve','应用层次','0',NULL,0,'1','2019-07-10 11:30:17','1','2019-07-10 11:30:17',NULL,'0'),('sys_dictId:d1bffdc0-4036-4bae-a14d-48f864b1c501','EDT03','日期型','sys_dictId:a5a9b145-9794-401e-b9f4-b2d6aa3b5b57',NULL,0,'1','2019-07-08 18:13:52','1','2019-07-08 18:13:52',NULL,'0'),('sys_dictId:d47a6430-40b6-4bf0-9b83-1bfea8239ee5','PCX01','简单','sys_dictId:7b23d325-a81a-4ec8-a42d-40c88085f297',NULL,0,'1','2019-07-10 17:35:49','1','2019-07-10 17:35:49',NULL,'0'),('sys_dictId:d642ff20-6772-4bc7-b718-efd75665bd2b','OT1','政府机关','sys_dictId:0568340e-a942-4464-a5c4-de3e3d122932',NULL,0,'1','2019-07-12 11:40:30','1','2019-07-12 13:51:39',NULL,'0'),('sys_dictId:d9356899-5ef2-4726-ab33-6b367a376c7a','VTT01','主题类型1','sys_dictId:2c183693-9b9d-4be7-9865-adedec5e0960',NULL,0,'1','2019-07-08 00:08:49','1','2019-07-08 00:08:49',NULL,'0'),('sys_dictId:da12959c-8a53-4b66-9cab-55444a46ec53','PCX03','复杂','sys_dictId:7b23d325-a81a-4ec8-a42d-40c88085f297',NULL,0,'1','2019-07-10 17:36:23','1','2019-07-10 17:36:23',NULL,'0'),('sys_dictId:e75f2f26-8143-471b-abd6-0a666962d73a','VTT02','主题类型2','sys_dictId:2c183693-9b9d-4be7-9865-adedec5e0960',NULL,0,'1','2019-07-08 00:09:21','1','2019-07-08 00:09:21',NULL,'0'),('sys_dictId:f0372424-3a3d-4b12-852a-8dd2fe070563','PssDevModel','开发模式','0',NULL,0,'1','2019-07-10 11:33:55','1','2019-07-10 11:33:55',NULL,'0'),('sys_dictId:f26439a0-a9b3-4817-ad18-303808d8d8cd','gz','广东','sys_dictId:9e92dc45-4319-453c-8595-2d6f7ba43d0d',NULL,0,'1','2019-07-02 16:09:12','1','2019-07-02 16:09:12',NULL,'0'),('sys_dictId:f3b6e74a-7654-41ed-ba17-babb51f14982','BIT01','事项类别-1','sys_dictId:91fb2f98-4a5a-484b-8eed-71254c3815f9',NULL,0,'1','2019-07-06 15:00:56','1','2019-07-06 15:00:56',NULL,'0'),('sys_dictId:f548f608-1f90-4ba2-bfa9-3e0a8cb1236d','SysDeptType','系统部门类型','0',NULL,0,'1','2019-07-18 09:22:46','1','2019-07-18 09:22:46',NULL,'0'),('sys_dictId:fb9ce1af-4cb0-410c-9525-20015e94dac2','ViewItemType','视图组成','0',NULL,0,'1','2019-07-07 17:45:27','1','2019-07-07 17:45:27',NULL,'0'),('sys_dictId:fd5627a9-45c4-46a9-ac4b-293845c1e1a5','Doc01','业务分析文档','sys_dictId:1366b715-b510-492b-9b0e-c606916838db',NULL,0,'1','2019-07-05 17:24:10','1','2019-07-05 17:24:10',NULL,'0'),('sys_dictId:ff8bcbb1-b024-4ead-a3e4-84d9f1487593','RoleType','角色类型','0',NULL,0,'1','2019-07-03 10:58:15','1','2019-07-03 10:58:15',NULL,'0');
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_group`
--

DROP TABLE IF EXISTS `sys_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_group` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `name` varchar(100) DEFAULT NULL COMMENT '分组名称',
  `parent_id` varchar(100) DEFAULT NULL COMMENT '上级分组ID',
  `sort` bigint(20) DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `del_flag` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL COMMENT '层级',
  `parent_ids` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_group`
--

LOCK TABLES `sys_group` WRITE;
/*!40000 ALTER TABLE `sys_group` DISABLE KEYS */;
INSERT INTO `sys_group` VALUES ('sys_groupId:36fa4f89-1d55-4382-ad8a-6cbe3974c4b9','123','sys_groupId:440f8b34-2825-4f38-ac9c-a4336a4aa760',1,'2019-10-10 13:50:11','cba1b6b6-466e-4b6e-8904-ab9645fd64c3','2019-10-10 13:50:11','cba1b6b6-466e-4b6e-8904-ab9645fd64c3',NULL,'2',NULL),('sys_groupId:440f8b34-2825-4f38-ac9c-a4336a4aa760','分组4',NULL,11,'2019-10-09 10:32:14','1','2019-10-09 10:32:14','1','0','1',NULL),('sys_menuId:0d1144f4-1271-4a5d-a754-c4d48438e50a','分组1',NULL,0,'2019-10-08 17:49:50','1','2019-10-08 17:49:50','1','0','1','null,'),('sys_menuId:9a7676cd-e96b-49c0-a008-f8efdd9c2c5f','分组3',NULL,1,'2019-10-09 09:50:55','1','2019-10-09 09:50:55','1','0','1','null,'),('sys_menuId:abf52986-be07-45ae-a41e-60d19549c501','子子分组22','sys_menuId:690c0ee2-08d6-47a6-bb88-2c5492f13d99',0,'2019-10-09 09:46:40','1','2019-10-09 09:50:32','1','1','3','null,null,null,'),('sys_menuId:b28d6577-0a16-4d65-acd9-2e8b7f6fab4f','redis','sys_menuId:4dc1b872-8bec-4cf4-a143-cb6b2a34ee48',30,NULL,'1','2019-10-08 17:44:43','1','0','2','null,null,');
/*!40000 ALTER TABLE `sys_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '请求类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '日志标题',
  `remote_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作IP地址',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作用户昵称',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '请求URI',
  `http_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作方式',
  `class_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '请求类型.方法',
  `params` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '操作提交的数据',
  `session_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'sessionId',
  `response` longtext CHARACTER SET utf8 COLLATE utf8_bin COMMENT '返回内容',
  `use_time` bigint(11) DEFAULT NULL COMMENT '方法执行时间',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '浏览器信息',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '地区',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '市',
  `isp` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '网络服务提供商',
  `exception` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '异常信息',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `del_flag` bit(1) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`) USING BTREE,
  KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
  KEY `sys_log_type` (`type`) USING BTREE,
  KEY `sys_log_create_date` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5574 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
INSERT INTO `sys_log` VALUES (5558,'Ajax请求','获取子元数据分类','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/metadata/getChildMetaById','POST','com.hzot.isim.controller.project.metadataManage.ServiceMetadataClassController.getChildMetaById',NULL,'a58e9047-efe7-4945-9c97-d0b4ee39a90d','{\"data\":[{\"createTime\":1539745020000,\"description\":\"元数据2\",\"id\":\"2\",\"name\":\"元数据2\",\"pid\":\"1\",\"updateId\":\"42473bbb-58c9-4477-9e92-ea34f7e84078\",\"updateTime\":1571296622000},{\"description\":\"元数据Awe\",\"id\":\"3\",\"name\":\"元数据3\",\"pid\":\"1\",\"updateId\":\"cba1b6b6-466e-4b6e-8904-ab9645fd64c3\",\"updateTime\":1571883046000},{\"createTime\":1539745020000,\"description\":\"元数据4\",\"id\":\"4\",\"name\":\"元数据4\",\"pid\":\"1\",\"updateTime\":1539745020000},{\"createTime\":1539745020000,\"description\":\"元数据5\",\"id\":\"5\",\"name\":\"元数据5\",\"pid\":\"1\",\"updateTime\":1539745020000},{\"createTime\":1539745020000,\"description\":\"元数据6\",\"id\":\"6\",\"name\":\"元数据6\",\"pid\":\"1\",\"updateTime\":1539745020000},{\"createTime\":1539745020000,\"description\":\"元数据7\",\"id\":\"7\",\"name\":\"元数据7\",\"pid\":\"1\",\"updateTime\":1539745020000}],\"success\":true,\"message\":\"成功\"}',19,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 17:45:22','1','2019-11-08 17:45:22',NULL,NULL),(5559,'Ajax请求','根据数据库类型获取数据库信息','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/dbConn/getDBInfoByType','POST','com.hzot.isim.controller.project.connectorManage.DatabaseConnectorController.getDBInfoByType',NULL,'a58e9047-efe7-4945-9c97-d0b4ee39a90d','{\"data\":[{\"host\":\"222.188.117.130\",\"id\":\"sys_databaseId:54afc11a-91fe-4fab-8eac-2198eb709e96\"},{\"host\":\"192.168.1.150\",\"id\":\"sys_databaseId:7a65b742-5d16-416e-8959-c28472d928c0\"}],\"success\":true,\"message\":\"成功\"}',37,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 17:45:22','1','2019-11-08 17:45:22',NULL,NULL),(5560,'普通请求','跳转到数据库连接器列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/dbConn/list','GET','com.hzot.isim.controller.project.connectorManage.DatabaseConnectorController.list',NULL,'a58e9047-efe7-4945-9c97-d0b4ee39a90d','\"dbConn/list\"',1,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 17:45:42','1','2019-11-08 17:45:42',NULL,NULL),(5561,'Ajax请求','测试数据库连接','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/dbConn/testLinkById','POST','com.hzot.isim.controller.project.connectorManage.DatabaseConnectorController.testLinkById',NULL,'a58e9047-efe7-4945-9c97-d0b4ee39a90d','{\"success\":false,\"message\":\"连接失败:ORA-28001: the password has expired\\n\"}',3046,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 17:45:49','1','2019-11-08 17:45:49',NULL,NULL),(5562,'Ajax请求','用户登录','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/login/main','POST','com.hzot.isim.controller.LoginController.loginMain',NULL,'6a89f1b1-2b10-4b62-96d6-72e0086ec5ef','{\"data\":{\"url\":\"index\"},\"success\":true,\"message\":\"登录成功\"}',153,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:03:15','1','2019-11-08 18:03:15',NULL,NULL),(5563,'Ajax请求','用户登录','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/login/main','POST','com.hzot.isim.controller.LoginController.loginMain',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','{\"data\":{\"url\":\"index\"},\"success\":true,\"message\":\"登录成功\"}',223,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:07:19','1','2019-11-08 18:07:19',NULL,NULL),(5564,'Ajax请求','获取子元数据分类','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/metadata/getChildMetaById','POST','com.hzot.isim.controller.project.metadataManage.ServiceMetadataClassController.getChildMetaById',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','{\"data\":[{\"createTime\":1539745020000,\"description\":\"元数据2\",\"id\":\"2\",\"name\":\"元数据2\",\"pid\":\"1\",\"updateId\":\"42473bbb-58c9-4477-9e92-ea34f7e84078\",\"updateTime\":1571296622000},{\"description\":\"元数据Awe\",\"id\":\"3\",\"name\":\"元数据3\",\"pid\":\"1\",\"updateId\":\"cba1b6b6-466e-4b6e-8904-ab9645fd64c3\",\"updateTime\":1571883046000},{\"createTime\":1539745020000,\"description\":\"元数据4\",\"id\":\"4\",\"name\":\"元数据4\",\"pid\":\"1\",\"updateTime\":1539745020000},{\"createTime\":1539745020000,\"description\":\"元数据5\",\"id\":\"5\",\"name\":\"元数据5\",\"pid\":\"1\",\"updateTime\":1539745020000},{\"createTime\":1539745020000,\"description\":\"元数据6\",\"id\":\"6\",\"name\":\"元数据6\",\"pid\":\"1\",\"updateTime\":1539745020000},{\"createTime\":1539745020000,\"description\":\"元数据7\",\"id\":\"7\",\"name\":\"元数据7\",\"pid\":\"1\",\"updateTime\":1539745020000}],\"success\":true,\"message\":\"成功\"}',50,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:09:51','1','2019-11-08 18:09:51',NULL,NULL),(5565,'Ajax请求','根据数据库类型获取数据库信息','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/dbConn/getDBInfoByType','POST','com.hzot.isim.controller.project.connectorManage.DatabaseConnectorController.getDBInfoByType',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','{\"data\":[{\"host\":\"222.188.117.130\",\"id\":\"sys_databaseId:54afc11a-91fe-4fab-8eac-2198eb709e96\"},{\"host\":\"192.168.1.150\",\"id\":\"sys_databaseId:7a65b742-5d16-416e-8959-c28472d928c0\"}],\"success\":true,\"message\":\"成功\"}',41,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:09:51','1','2019-11-08 18:09:51',NULL,NULL),(5566,'普通请求','跳转定时任务列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTask/list','GET','com.hzot.isim.controller.QuartzTaskController.list',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','\"/admin/quartzTask/list\"',5,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:14:30','1','2019-11-08 18:14:30',NULL,NULL),(5567,'Ajax请求','保存新增定时任务数据','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTask/add','POST','com.hzot.isim.controller.QuartzTaskController.add',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','{\"success\":true,\"message\":\"成功\"}',92,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:14:44','1','2019-11-08 18:14:44',NULL,NULL),(5568,'普通请求','跳转定时任务列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTask/list','GET','com.hzot.isim.controller.QuartzTaskController.list',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','\"/admin/quartzTask/list\"',1,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:14:45','1','2019-11-08 18:14:45',NULL,NULL),(5569,'普通请求','跳转定时任务列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTask/list','GET','com.hzot.isim.controller.QuartzTaskController.list',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','\"/admin/quartzTask/list\"',1,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:14:49','1','2019-11-08 18:14:49',NULL,NULL),(5570,'普通请求','跳转任务执行日志列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTaskLog/list','GET','com.hzot.isim.controller.QuartzTaskLogController.list',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','\"/admin/quartzTaskLog/list\"',4,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:15:00','1','2019-11-08 18:15:00',NULL,NULL),(5571,'普通请求','跳转任务执行日志列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTaskLog/list','GET','com.hzot.isim.controller.QuartzTaskLogController.list',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','\"/admin/quartzTaskLog/list\"',0,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:15:01','1','2019-11-08 18:15:01',NULL,NULL),(5572,'普通请求','跳转任务执行日志列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTaskLog/list','GET','com.hzot.isim.controller.QuartzTaskLogController.list',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','\"/admin/quartzTaskLog/list\"',0,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:15:05','1','2019-11-08 18:15:05',NULL,NULL),(5573,'普通请求','跳转任务执行日志列表','127.0.0.1','系统管理员','http://localhost:8088/isimPlatform/admin/quartzTaskLog/list','GET','com.hzot.isim.controller.QuartzTaskLogController.list',NULL,'f00ddd01-5455-4131-b5ff-63a8efcb92e9','\"/admin/quartzTaskLog/list\"',0,'Windows-Chrome-75.0.3770.142',NULL,NULL,NULL,NULL,NULL,'1','2019-11-08 18:15:16','1','2019-11-08 18:15:16',NULL,NULL);
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `name` varchar(40) DEFAULT NULL COMMENT '菜单名称',
  `parent_id` varchar(100) DEFAULT NULL COMMENT '父菜单',
  `level` bigint(2) DEFAULT NULL COMMENT '菜单层级',
  `parent_ids` varchar(2000) DEFAULT NULL COMMENT '父菜单联集',
  `sort` smallint(6) DEFAULT NULL COMMENT '排序',
  `href` varchar(2000) DEFAULT NULL COMMENT '链接地址',
  `target` varchar(20) DEFAULT NULL COMMENT '打开方式',
  `icon` varchar(100) DEFAULT NULL COMMENT '菜单图标',
  `bg_color` varchar(255) DEFAULT NULL COMMENT '显示背景色',
  `is_show` tinyint(2) DEFAULT NULL COMMENT '是否显示',
  `permission` varchar(200) DEFAULT NULL COMMENT '权限标识',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(2) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES ('1','系统管理',NULL,1,'1,',20,'',NULL,'',NULL,1,'true',1,'2018-01-16 11:29:46',1,'2019-07-19 14:07:27',NULL,0),('14','定时任务',NULL,1,'14,',5,'',NULL,'',NULL,1,'true',1,'2018-01-26 22:39:35',1,'2019-07-19 14:06:02',NULL,0),('15','任务列表','14',2,'14,15,',15,'/admin/quartzTask/list',NULL,'','#d6d178',1,'true',1,'2018-01-26 22:41:25',1,'2018-02-08 10:31:11',NULL,0),('16','任务执行日志','14',2,'14,16,',10,'/admin/quartzTaskLog/list',NULL,'','#5158d6',1,'true',1,'2018-01-27 01:07:11',1,'2018-02-08 10:37:51',NULL,0),('17','新增字典','9',3,'1,9,17,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:39:09',1,'2018-02-08 09:39:19',NULL,0),('18','编辑字典','9',3,'1,9,18,',10,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:40:37',1,'2018-02-08 09:40:46',NULL,0),('19','编辑字典类型','9',3,'1,9,19,',20,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:42:46',1,'2018-02-08 09:54:07',NULL,0),('2','系统用户管理','1',2,'1,2,',9,'/admin/system/user/list',NULL,'','#47e69c',1,'true',1,'2018-01-16 11:31:18',1,'2018-01-20 05:59:20',NULL,0),('20','新增系统权限','4',3,'1,4,20,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:49:15',1,'2018-02-08 09:49:38',NULL,0),('21','编辑系统权限','4',3,'1,4,21,',10,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:50:16',1,'2018-02-08 09:50:25',NULL,0),('22','删除系统权限','4',3,'1,4,22,',20,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:51:53',1,'2018-02-08 09:53:42',NULL,0),('23','删除系统资源','5',3,'1,5,23,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:56:44',1,'2018-02-08 09:56:53',NULL,0),('24','新增系统角色','3',3,'1,3,24,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:58:11',1,'2018-02-08 09:58:11',NULL,0),('25','编辑菜单权限','3',3,'1,3,25,',10,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:59:01',1,'2018-02-08 09:59:01',NULL,0),('26','删除角色','3',3,'1,3,26,',20,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 09:59:56',1,'2018-02-08 09:59:56',NULL,0),('27','编辑系统信息','7',3,'1,7,27,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:01:40',1,'2018-02-08 10:01:40',NULL,0),('28','数据库新增','8',3,'1,8,28,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:02:51',1,'2018-02-08 10:02:51',NULL,0),('29','编辑数据库','8',3,'1,8,29,',10,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:03:58',1,'2018-02-08 10:03:58',NULL,0),('3','系统角色管理','1',2,'1,3,',10,'/admin/system/role/list',NULL,'','#c23ab9',1,'true',1,'2018-01-16 11:32:33',1,'2018-01-20 05:58:58',NULL,0),('30','新增数据库字段','8',3,'1,8,30,',20,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:05:11',1,'2018-02-08 10:05:11',NULL,0),('31','编辑数据库字段','8',3,'1,8,31,',30,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:05:47',1,'2018-02-08 10:05:47',NULL,0),('32','删除数据库字段','8',3,'1,8,32,',40,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:07:29',1,'2018-02-08 10:15:39',NULL,0),('33','删除数据库','8',3,'1,8,33,',50,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:08:16',1,'2018-02-08 10:08:16',NULL,0),('34','下载源码','8',3,'1,8,34,',60,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:09:28',1,'2018-02-08 10:09:28',NULL,0),('35','新增系统用户','2',3,'1,2,35,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:10:32',1,'2018-02-08 10:10:32',NULL,0),('36','编辑系统用户','2',3,'1,2,36,',10,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:11:49',1,'2018-02-08 10:11:49',NULL,0),('37','删除系统用户','2',3,'1,2,37,',20,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:12:43',1,'2018-02-08 10:12:43',NULL,0),('4','系统菜单权限管理','1',2,'1,4,',20,'/admin/system/menu/list',NULL,'','#d4573b',1,'true',1,'2018-01-16 11:33:19',1,'2019-06-29 09:19:23',NULL,0),('46','新增定时任务','15',3,'14,15,46,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:32:46',1,'2018-02-08 10:32:46',NULL,0),('47','编辑定时任务','15',3,'14,15,47,',10,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:34:18',1,'2018-02-08 10:34:18',NULL,0),('48','删除定时任务','15',3,'14,15,48,',20,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:35:07',1,'2018-02-08 10:35:07',NULL,0),('49','暂停定时任务','15',3,'14,15,49,',30,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:35:43',1,'2018-02-08 10:35:43',NULL,0),('5','系统资源管理','1',2,'1,5,',30,'/admin/system/rescource/list',NULL,'','#f5e42a',1,'true',1,'2018-01-16 11:34:48',1,'2018-01-20 05:56:35',NULL,0),('50','恢复运行任务','15',3,'14,15,50,',40,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:36:26',1,'2018-02-08 10:36:26',NULL,0),('51','立即执行运行任务','15',3,'14,15,51,',50,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:36:55',1,'2018-02-08 10:36:55',NULL,0),('52','删除定时任务日志','16',3,'14,16,52,',0,'',NULL,NULL,NULL,0,'true',1,'2018-02-08 10:39:04',1,'2018-02-08 10:39:04',NULL,0),('53','修改密码','2',3,'1,2,53,',30,'',NULL,'',NULL,0,'true',1,'2018-03-15 10:14:06',1,'2018-03-15 10:14:06',NULL,0),('54','删除字典','9',3,'1,9,54,',30,'',NULL,NULL,NULL,0,'true',1,'2018-03-15 10:16:55',1,'2018-03-15 10:16:55',NULL,0),('55','系统日志删除','6',3,'1,6,55,',0,'',NULL,NULL,NULL,0,'true',1,'2018-06-16 04:30:32',1,'2018-06-16 04:30:32',NULL,0),('6','系统日志管理','1',2,'1,6,',40,'/admin/system/log/list',NULL,'','#b56c18',1,'true',1,'2018-01-16 11:35:31',1,'2018-01-20 05:12:17',NULL,0),('60','Druid数据监控','1',2,'1,60,',25,'/admin/druid/list',NULL,'','#7e8755',1,'true',1,'2018-06-16 05:06:17',1,'2018-06-16 05:06:26',NULL,0),('63','业务架构登记',NULL,1,NULL,90,'',NULL,NULL,NULL,1,'',1,'2019-06-26 18:16:44',1,'2019-06-27 11:38:20',NULL,0),('69','组织机构','63',2,'null,',30,'/admin/frame/business/org/list',NULL,NULL,NULL,1,'',1,'2019-06-27 11:27:31',1,'2019-07-06 10:52:32',NULL,0),('7','网站基本信息','1',2,'1,7,',50,'/admin/system/site/show',NULL,'','#95deb9',1,'true',1,'2018-01-16 11:36:50',1,'2018-01-20 05:55:44',NULL,0),('70','业务域','63',2,'null,',20,'/admin/frame/business/bus/list',NULL,NULL,NULL,1,'',1,'2019-06-27 11:28:43',1,'2019-07-06 10:52:43',NULL,0),('71','用户视图','63',2,'null,',10,'/admin/frame/business/view/list',NULL,NULL,NULL,1,'',1,'2019-06-27 11:29:26',1,'2019-07-07 14:01:23',NULL,0),('8','数据库管理','1',2,'1,8,',60,'/admin/system/table/list',NULL,'','#369e16',1,'true',1,'2018-01-16 11:38:29',1,'2018-01-20 03:14:23',NULL,0),('80','服务注册管理',NULL,1,'null,',60,'/admin/frame/knowledge/list',NULL,NULL,NULL,1,'false',1,'2019-06-27 11:31:31',1,'2019-09-30 16:27:38',NULL,0),('88','系统设置',NULL,1,'null,',40,'',NULL,NULL,NULL,1,'false',1,'2019-06-27 11:33:29',1,'2019-08-27 10:23:06',NULL,0),('89','用户管理','88',2,'null,null,',50,'/admin/system/user/list',NULL,NULL,NULL,1,'true',1,'2019-06-27 11:33:38',1,'2019-07-19 14:03:31',NULL,0),('9','系统字典管理','1',2,'1,9,',70,'/admin/system/dict/list',NULL,'','#1bbcc2',1,'true',1,'2018-01-16 14:51:52',1,'2018-01-20 03:12:27',NULL,0),('90','角色管理','88',2,'null,null,',40,'/admin/system/role/list',NULL,NULL,NULL,1,'true',1,'2019-06-27 11:33:50',1,'2019-07-19 14:03:42',NULL,0),('91','部门维护','88',2,'null,null,',30,'/admin/system/dept/list',NULL,'',NULL,1,'true',1,'2019-06-27 11:33:59',1,'2019-07-19 14:03:56',NULL,0),('92','系统日志','88',2,'null,null,',20,'/admin/system/log/list',NULL,NULL,NULL,1,'true',1,'2019-06-27 11:34:07',1,'2019-07-19 14:04:09',NULL,0),('93','编码管理','88',2,'null,null,',10,'/admin/system/dict/list',NULL,NULL,NULL,1,'true',1,'2019-06-27 11:34:15',1,'2019-07-19 14:04:29',NULL,0),('sys_menuId:0d462c94-bab4-4511-bb80-3dfb1f9db7ba','连接器',NULL,1,NULL,110,'/admin/system/dbconn/list',NULL,NULL,NULL,1,'true',1,'2019-10-09 15:51:30',1,'2019-10-09 16:39:30',NULL,0),('sys_menuId:2dcf7b35-fd20-4faa-8547-a952903c722d','菜单管理','88',2,'null,null,',60,'/admin/system/menu/list',NULL,NULL,NULL,1,'true',1,'2019-08-27 15:11:37',1,'2019-09-25 14:33:18',NULL,0),('sys_menuId:4442d5fd-83c9-4156-af02-57b6da93b75e','分组维护','88',2,'null,null,',70,'/admin/system/group/list',NULL,NULL,NULL,1,'true',1,'2019-10-08 15:29:14',1,'2019-10-08 15:29:14',NULL,0),('sys_menuId:9a9af416-4d25-4a4d-9987-c45ace17ed61','服务元数据',NULL,1,'null,',100,'/admin/system/meta/list',NULL,NULL,NULL,1,'true',1,'2019-10-09 10:34:01',1,'2019-10-09 10:34:01',NULL,0);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_meta`
--

DROP TABLE IF EXISTS `sys_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_meta` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `name` varchar(100) DEFAULT NULL COMMENT '元数据名称',
  `parent_id` varchar(100) DEFAULT NULL COMMENT '上级元数据ID',
  `sort` bigint(20) DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `del_flag` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL COMMENT '层级',
  `parent_ids` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务元数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_meta`
--

LOCK TABLES `sys_meta` WRITE;
/*!40000 ALTER TABLE `sys_meta` DISABLE KEYS */;
INSERT INTO `sys_meta` VALUES ('sys_metaId:3b2e168e-15bc-48e6-911f-7c01caa424ec','元数据1',NULL,0,'2019-10-09 15:09:33','1','2019-10-09 15:09:33','1','0','1',NULL),('sys_metaId:3e7e6fc4-036d-41d5-9b47-8f7fd8faf72a','子元数据1',NULL,1,'2019-10-09 15:09:49','1','2019-10-09 15:09:49','1','0','1',NULL),('sys_metaId:a73c36fb-a082-42ca-b0c9-1273e53ba263','子元素11','sys_metaId:3e7e6fc4-036d-41d5-9b47-8f7fd8faf72a',11,'2019-10-09 15:12:24','1','2019-10-09 15:12:24','1','0','2',NULL);
/*!40000 ALTER TABLE `sys_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_name_list`
--

DROP TABLE IF EXISTS `sys_name_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_name_list` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `name` varchar(100) DEFAULT NULL COMMENT '外网系统名',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='外围系统列表信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_name_list`
--

LOCK TABLES `sys_name_list` WRITE;
/*!40000 ALTER TABLE `sys_name_list` DISABLE KEYS */;
INSERT INTO `sys_name_list` VALUES ('f78af4b4-d69d-4b8e-b33b-1535af0cbfd1','ERP',NULL,NULL,NULL,NULL),('f78af4b4-d69d-4b8e-b33b-1535af0cbfd2','HR',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_name_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rescource`
--

DROP TABLE IF EXISTS `sys_rescource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rescource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `source` varchar(255) DEFAULT NULL COMMENT '来源',
  `web_url` varchar(500) DEFAULT NULL COMMENT '资源网络地址',
  `hash` varchar(255) DEFAULT NULL COMMENT '文件标识',
  `file_size` varchar(50) DEFAULT NULL COMMENT '文件大小',
  `file_type` varchar(255) DEFAULT NULL COMMENT '文件类型',
  `original_net_url` text,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '修改人',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='系统资源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rescource`
--

LOCK TABLES `sys_rescource` WRITE;
/*!40000 ALTER TABLE `sys_rescource` DISABLE KEYS */;
INSERT INTO `sys_rescource` VALUES (13,'e4f8a4fc-96a9-40da-ad69-9326e9ab021e.png','local','/static/upload/e4f8a4fc-96a9-40da-ad69-9326e9ab021e.png','Fk7jwG0W5oko-D8bKtZZonQmFqE9','122kb','image/png',NULL,'2019-08-19 15:45:26','1','2019-08-19 15:45:26','1',NULL,0),(14,'ffaee295-d180-4b5d-90b5-c659f1e68be3.jpg','local','/static/upload/ffaee295-d180-4b5d-90b5-c659f1e68be3.jpg','Fp-zP_45Rz4c_wHHEa_fq9arKKP4','5kb','image/jpeg',NULL,'2019-08-26 17:24:21','sys_userId:364728d9-09cc-4667-ba6c-8cdc9011d3fd','2019-08-26 17:24:21','sys_userId:364728d9-09cc-4667-ba6c-8cdc9011d3fd',NULL,0);
/*!40000 ALTER TABLE `sys_rescource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` varchar(100) NOT NULL COMMENT 'UUID',
  `role_code` varchar(255) DEFAULT NULL COMMENT '角色编码',
  `role_name` varchar(40) DEFAULT NULL COMMENT '角色名称',
  `role_type` varchar(255) DEFAULT NULL COMMENT '角色类型',
  `role_desc` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(2) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('1','admin','管理员','0','管理员','2017-11-02 14:19:07','1','2019-10-09 13:59:57','1',NULL,0),('2','manager','系统管理员','1','系统管理员','2017-11-29 19:36:37','1','2019-10-15 16:17:45','42473bbb-58c9-4477-9e92-ea34f7e84078',NULL,0),('roleId:99b1be6d-e94a-45a7-aa99-17e4560c9141','springboot','测试角色','0','用户自定义角色','2019-06-26 16:51:20','1','2019-10-15 16:18:02','42473bbb-58c9-4477-9e92-ea34f7e84078',NULL,0),('sys_roleId:69120b1c-22e9-4699-a187-9e7b188efef4','R01','开发工程师','1','开发工程师描述','2019-07-03 11:04:44','1','2019-07-18 10:12:38','1',NULL,0);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(100) NOT NULL COMMENT '角色ID',
  `menu_id` varchar(100) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `sys_role_menu_fk_1` (`menu_id`),
  CONSTRAINT `sys_role_menu_fk` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sys_role_menu_fk_1` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES ('1','15'),('2','15'),('1','16'),('2','16'),('1','2'),('2','2'),('1','3'),('2','3'),('1','4'),('2','4'),('1','5'),('2','5'),('1','6'),('2','6'),('1','60'),('2','60'),('1','7'),('2','7'),('1','70'),('1','71'),('1','8'),('2','8'),('1','80'),('2','80'),('1','89'),('2','89'),('1','9'),('2','9'),('1','90'),('2','90'),('1','91'),('2','91'),('1','92'),('2','92'),('1','93'),('2','93'),('1','sys_menuId:0d462c94-bab4-4511-bb80-3dfb1f9db7ba'),('1','sys_menuId:2dcf7b35-fd20-4faa-8547-a952903c722d'),('2','sys_menuId:2dcf7b35-fd20-4faa-8547-a952903c722d'),('1','sys_menuId:4442d5fd-83c9-4156-af02-57b6da93b75e'),('2','sys_menuId:4442d5fd-83c9-4156-af02-57b6da93b75e'),('1','sys_menuId:9a9af416-4d25-4a4d-9987-c45ace17ed61'),('2','sys_menuId:9a9af416-4d25-4a4d-9987-c45ace17ed61');
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_sla_rule`
--

DROP TABLE IF EXISTS `sys_sla_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_sla_rule` (
  `id` varchar(100) DEFAULT NULL COMMENT 'UUID',
  `rule_name` varchar(100) DEFAULT NULL COMMENT '规则名称',
  `fail_retry_time` int(11) DEFAULT NULL COMMENT '失败重试次数',
  `link_over_time` int(11) DEFAULT NULL COMMENT '链接超时时间',
  `request_over_time` int(11) DEFAULT NULL COMMENT '请求超时时间',
  `response_over_time` int(11) DEFAULT NULL COMMENT '响应超时时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SLA规则';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_sla_rule`
--

LOCK TABLES `sys_sla_rule` WRITE;
/*!40000 ALTER TABLE `sys_sla_rule` DISABLE KEYS */;
INSERT INTO `sys_sla_rule` VALUES ('sys_slaId:20b77fb5-6bf2-45fd-b44e-3d647657896f','规则1',1,3,44,4,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 15:15:24','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 16:48:43'),('sys_slaId:867ed4da-6952-4b34-a8d6-586f05f5b6de','规则2',4,4,4,34432,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 15:22:39','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 15:22:39'),('sys_slaId:b213e665-5b6f-4925-941e-e3bd996dc39b','测试规则3',1233,1231,1231231,123,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 16:07:27','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 16:48:32'),('sys_slaId:4fa5e9ba-d168-44e7-971e-7c88a6b2a208','规则04',30000,3000,0,0,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 16:08:11','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 16:08:11'),('sys_slaId:08201e24-ab3e-48f2-b639-f6a1f516592d','测试规则5',1,3,44,4,'42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 16:46:27','42473bbb-58c9-4477-9e92-ea34f7e84078','2019-10-16 16:48:20');
/*!40000 ALTER TABLE `sys_sla_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` varchar(100) NOT NULL COMMENT '用户ID',
  `nick_name` varchar(100) DEFAULT NULL COMMENT '昵称',
  `login_name` varchar(100) DEFAULT NULL COMMENT '登录名',
  `real_name` varchar(100) DEFAULT NULL COMMENT '昵称',
  `dept_code` varchar(100) DEFAULT NULL COMMENT '部门编码',
  `icon` varchar(2000) DEFAULT NULL COMMENT '头像',
  `password` varchar(40) DEFAULT NULL COMMENT '密码',
  `salt` varchar(40) DEFAULT NULL COMMENT 'shiro加密盐',
  `mobile_num` varchar(50) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱地址',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `position` varchar(100) DEFAULT NULL COMMENT '职务',
  `post_code` varchar(100) DEFAULT NULL COMMENT '邮件编码',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `locked` tinyint(2) DEFAULT NULL COMMENT '是否锁定',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) DEFAULT NULL COMMENT '更新者',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  `sex` varchar(50) DEFAULT NULL COMMENT '性别',
  `frame_org_dept_id` varchar(100) DEFAULT NULL COMMENT '所属组织架构内设部门',
  `sort` bigint(20) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES ('0e14efc8-e319-4e4c-8e61-dd8bea1bd492','服务提供者A','gac123','服务提供者A',NULL,NULL,NULL,NULL,NULL,'gac123@qq.com','2019-07-09 00:00:00',NULL,NULL,NULL,0,'2019-10-23 10:05:02','1','2019-10-23 10:05:05',NULL,NULL,NULL,NULL,NULL,NULL),('1','管理员','admin','系统管理员','FN006','/static/upload/e4f8a4fc-96a9-40da-ad69-9326e9ab021e.png','422f36f4523301dbefda33fd00f230028fad1b83','03ce06338b69a8cf','13776055179','b@qq.comddd','2019-07-09 00:00:00','高级工程师','224400','阜宁县上海路',0,'2017-11-27 22:19:39','1','2019-08-27 17:14:48','1','',0,'1','frame_org_deptId:002',1),('42473bbb-58c9-4477-9e92-ea34f7e84078','管理员','admin1','系统管理员','FN006','/static/upload/e4f8a4fc-96a9-40da-ad69-9326e9ab021e.png','422f36f4523301dbefda33fd00f230028fad1b83','03ce06338b69a8cf','13776055179','b@qq.comddd','2019-07-09 00:00:00','高级工程师','224400','阜宁县上海路',0,'2017-11-27 22:19:39','1','2019-08-27 17:14:48','1','',0,'1','frame_org_deptId:002',1),('cba1b6b6-466e-4b6e-8904-ab9645fd64c3','傅腾笙','futs','Futs',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-10-14 17:29:16',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_menu`
--

DROP TABLE IF EXISTS `sys_user_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_menu` (
  `user_id` varchar(100) NOT NULL,
  `menu_id` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`,`menu_id`),
  KEY `sys_user_menu_fk_1` (`menu_id`),
  CONSTRAINT `sys_user_menu_fk` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sys_user_menu_fk_1` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_menu`
--

LOCK TABLES `sys_user_menu` WRITE;
/*!40000 ALTER TABLE `sys_user_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(100) NOT NULL COMMENT '人员ID',
  `role_id` varchar(100) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `sys_user_role_fk` (`role_id`),
  CONSTRAINT `sys_user_role_fk` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sys_user_role_fk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户角色关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES ('42473bbb-58c9-4477-9e92-ea34f7e84078','1'),('cba1b6b6-466e-4b6e-8904-ab9645fd64c3','1'),('42473bbb-58c9-4477-9e92-ea34f7e84078','sys_roleId:69120b1c-22e9-4699-a187-9e7b188efef4');
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'isim'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-11  9:54:34
