

-- --------------------------------------------------------
-- 
-- Table structure for table `b_agent`
-- 




DROP TABLE IF EXISTS `b_agent`;
CREATE TABLE `b_agent` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `MODULE_ID` varchar(50)  DEFAULT NULL,
  `SORT` int(18) NOT NULL DEFAULT '100',
  `NAME` varchar(255)  NOT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `LAST_EXEC` datetime DEFAULT NULL,
  `NEXT_EXEC` datetime NOT NULL,
  `DATE_CHECK` datetime DEFAULT NULL,
  `AGENT_INTERVAL` int(18) DEFAULT '86400',
  `IS_PERIOD` char(1)  DEFAULT 'Y',
  `USER_ID` int(18) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_act_next_exec` (`ACTIVE`,`NEXT_EXEC`),
  KEY `ix_agent_user_id` (`USER_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_agent`
-- 


INSERT INTO `b_agent` VALUES (1,'main',100,'CEvent::CleanUpAgent();','Y','2016-03-23 10:21:10','2012-12-02 00:00:00',NULL,86400,'Y',NULL);
INSERT INTO `b_agent` VALUES (2,'main',100,'CUser::CleanUpHitAuthAgent();','Y','2016-03-23 10:21:10','2012-12-02 00:00:00',NULL,86400,'Y',NULL);
INSERT INTO `b_agent` VALUES (3,'main',100,'CCaptchaAgent::DeleteOldCaptcha(3600);','Y','2016-03-23 10:20:51','2016-03-23 11:20:51',NULL,3600,'N',NULL);
INSERT INTO `b_agent` VALUES (4,'main',100,'CUndo::CleanUpOld();','Y','2016-03-23 10:21:10','2012-12-01 00:00:00',NULL,86400,'Y',NULL);
INSERT INTO `b_agent` VALUES (5,'search',10,'CSearchSuggest::CleanUpAgent();','Y','2016-03-22 23:09:15','2016-03-23 23:09:15',NULL,86400,'N',NULL);
INSERT INTO `b_agent` VALUES (6,'search',10,'CSearchStatistic::CleanUpAgent();','Y','2016-03-22 23:09:15','2016-03-23 23:09:15',NULL,86400,'N',NULL);
INSERT INTO `b_agent` VALUES (7,'main',100,'CEventLog::CleanUpAgent();','Y','2016-03-22 23:09:15','2016-03-23 23:09:15',NULL,86400,'N',NULL);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_cache_tag`
-- 




DROP TABLE IF EXISTS `b_cache_tag`;
CREATE TABLE `b_cache_tag` (
  `SITE_ID` char(2)  DEFAULT NULL,
  `CACHE_SALT` char(4)  DEFAULT NULL,
  `RELATIVE_PATH` varchar(255)  DEFAULT NULL,
  `TAG` varchar(100)  DEFAULT NULL,
  KEY `ix_b_cache_tag_0` (`SITE_ID`,`CACHE_SALT`,`RELATIVE_PATH`(50)),
  KEY `ix_b_cache_tag_1` (`TAG`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_captcha`
-- 




DROP TABLE IF EXISTS `b_captcha`;
CREATE TABLE `b_captcha` (
  `ID` varchar(32)  NOT NULL,
  `CODE` varchar(20)  NOT NULL,
  `IP` varchar(15)  NOT NULL,
  `DATE_CREATE` datetime NOT NULL,
  UNIQUE KEY `UX_B_CAPTCHA` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_event`
-- 




DROP TABLE IF EXISTS `b_event`;
CREATE TABLE `b_event` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `EVENT_NAME` varchar(50)  NOT NULL,
  `MESSAGE_ID` int(18) DEFAULT NULL,
  `LID` char(2)  NOT NULL,
  `C_FIELDS` longtext ,
  `DATE_INSERT` datetime DEFAULT NULL,
  `DATE_EXEC` datetime DEFAULT NULL,
  `SUCCESS_EXEC` char(1)  NOT NULL DEFAULT 'N',
  `DUPLICATE` char(1)  NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`ID`),
  KEY `ix_success` (`SUCCESS_EXEC`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_event_log`
-- 




DROP TABLE IF EXISTS `b_event_log`;
CREATE TABLE `b_event_log` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SEVERITY` varchar(50)  NOT NULL,
  `AUDIT_TYPE_ID` varchar(50)  NOT NULL,
  `MODULE_ID` varchar(50)  NOT NULL,
  `ITEM_ID` varchar(255)  NOT NULL,
  `REMOTE_ADDR` varchar(15)  DEFAULT NULL,
  `USER_AGENT` text ,
  `REQUEST_URI` text ,
  `SITE_ID` char(2)  DEFAULT NULL,
  `USER_ID` int(18) DEFAULT NULL,
  `GUEST_ID` int(18) DEFAULT NULL,
  `DESCRIPTION` mediumtext ,
  PRIMARY KEY (`ID`),
  KEY `ix_b_event_log_time` (`TIMESTAMP_X`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_event_message`
-- 




DROP TABLE IF EXISTS `b_event_message`;
CREATE TABLE `b_event_message` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EVENT_NAME` varchar(50)  NOT NULL,
  `LID` char(2)  DEFAULT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `EMAIL_FROM` varchar(255)  NOT NULL DEFAULT '#EMAIL_FROM#',
  `EMAIL_TO` varchar(255)  NOT NULL DEFAULT '#EMAIL_TO#',
  `SUBJECT` varchar(255)  DEFAULT NULL,
  `MESSAGE` text ,
  `BODY_TYPE` varchar(4)  NOT NULL DEFAULT 'text',
  `BCC` text ,
  `REPLY_TO` varchar(255)  DEFAULT NULL,
  `CC` varchar(255)  DEFAULT NULL,
  `IN_REPLY_TO` varchar(255)  DEFAULT NULL,
  `PRIORITY` varchar(50)  DEFAULT NULL,
  `FIELD1_NAME` varchar(50)  DEFAULT NULL,
  `FIELD1_VALUE` varchar(255)  DEFAULT NULL,
  `FIELD2_NAME` varchar(50)  DEFAULT NULL,
  `FIELD2_VALUE` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_event_message`
-- 


INSERT INTO `b_event_message` VALUES (1,'2010-11-08 12:08:16','NEW_USER','s1','Y','#DEFAULT_EMAIL_FROM#','#DEFAULT_EMAIL_FROM#','#SITE_NAME#: New user has been registered on the site','Informational message from #SITE_NAME#\n---------------------------------------\n\nNew user has been successfully registered on the site #SERVER_NAME#.\n\nUser details:\nUser ID: #USER_ID#\n\nName: #NAME#\nLast Name: #LAST_NAME#\nUser\'s E-Mail: #EMAIL#\n\nLogin: #LOGIN#\n\nAutomatically generated message.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `b_event_message` VALUES (2,'2010-11-08 12:08:16','USER_INFO','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: Registration info','Informational message from #SITE_NAME#\n---------------------------------------\n\n#NAME# #LAST_NAME#,\n\n#MESSAGE#\n\nYour registration info:\n\nUser ID: #USER_ID#\nAccount status: #STATUS#\nLogin: #LOGIN#\n\nTo change your password please visit the link below:\nhttp://#SERVER_NAME#/bitrix/admin/index.php?change_password=yes&lang=en&USER_CHECKWORD=#CHECKWORD#\n\nAutomatically generated message.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `b_event_message` VALUES (3,'2010-11-08 12:08:16','NEW_USER_CONFIRM','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: New user registration confirmation','Greetings from #SITE_NAME#!\n------------------------------------------\n\nHello,\n\nyou have received this message because you (or someone else) used your e-mail to register at #SERVER_NAME#.\n\nYour registration confirmation code: #CONFIRM_CODE#\n\nPlease use the link below to verify and activate your registration:\nhttp://#SERVER_NAME#/auth/index.php?confirm_registration=yes&confirm_user_id=#USER_ID#&confirm_code=#CONFIRM_CODE#\n\nAlternatively, open this link in your browser and enter the code manually:\nhttp://#SERVER_NAME#/auth/index.php?confirm_registration=yes&confirm_user_id=#USER_ID#\n\nAttention! Your account will not be activated until you confirm registration.\n\n---------------------------------------------------------------------\n\nAutomatically generated message.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `b_event_message` VALUES (4,'2010-11-08 12:08:16','USER_INVITE','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: Invitation to site','Informational message from site #SITE_NAME#\n------------------------------------------\nHello #NAME# #LAST_NAME#!\n\nAdministrator has added you to registered site users.\n\nWe invite you to visit our site.\n\nYour registration info:\n\nUser ID: #ID#\nLogin: #LOGIN#\n\nWe recommend you to change automatically generated password.\n\nTo change password please follow the link:\nhttp://#SERVER_NAME#/auth.php?change_password=yes&USER_LOGIN=#URL_LOGIN#&USER_CHECKWORD=#CHECKWORD#','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `b_event_message` VALUES (5,'2010-11-08 12:08:16','FEEDBACK_FORM','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL_TO#','#SITE_NAME#: A feedback form message','Notification from #SITE_NAME#\n------------------------------------------\n\nA message has been sent to you from the feedback form.\n\nSent by: #AUTHOR#\nSender\'s e-mail: #AUTHOR_EMAIL#\n\nMessage text:\n#TEXT#\n\nThis notification has been generated automatically.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_event_message_site`
-- 




DROP TABLE IF EXISTS `b_event_message_site`;
CREATE TABLE `b_event_message_site` (
  `EVENT_MESSAGE_ID` int(11) NOT NULL,
  `SITE_ID` char(2)  NOT NULL,
  PRIMARY KEY (`EVENT_MESSAGE_ID`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_event_message_site`
-- 


INSERT INTO `b_event_message_site` VALUES (1,'s1');
INSERT INTO `b_event_message_site` VALUES (2,'s1');
INSERT INTO `b_event_message_site` VALUES (3,'s1');
INSERT INTO `b_event_message_site` VALUES (4,'s1');
INSERT INTO `b_event_message_site` VALUES (5,'s1');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_event_type`
-- 




DROP TABLE IF EXISTS `b_event_type`;
CREATE TABLE `b_event_type` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `LID` varchar(201)  NOT NULL,
  `EVENT_NAME` varchar(50)  NOT NULL,
  `NAME` varchar(100)  DEFAULT NULL,
  `DESCRIPTION` text ,
  `SORT` int(18) NOT NULL DEFAULT '150',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_1` (`EVENT_NAME`,`LID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_event_type`
-- 


INSERT INTO `b_event_type` VALUES (1,'en','NEW_USER','New user was registered','\n\n#USER_ID# - User ID\n#LOGIN# - Login\n#EMAIL# - EMail\n#NAME# - Name\n#LAST_NAME# - Last Name\n#USER_IP# - User IP\n#USER_HOST# - User Host\n',1);
INSERT INTO `b_event_type` VALUES (2,'en','USER_INFO','Account Information','\n\n#USER_ID# - User ID\n#STATUS# - Account status\n#MESSAGE# - Message for user\n#LOGIN# - Login\n#CHECKWORD# - Check string for password change\n#NAME# - Name\n#LAST_NAME# - Last Name\n#EMAIL# - User E-Mail\n',2);
INSERT INTO `b_event_type` VALUES (3,'en','NEW_USER_CONFIRM','New user registration confirmation','\n\n#USER_ID# - User ID\n#LOGIN# - Login\n#EMAIL# - E-mail\n#NAME# - First name\n#LAST_NAME# - Last name\n#USER_IP# - User IP\n#USER_HOST# - User host\n#CONFIRM_CODE# - Confirmation code\n',3);
INSERT INTO `b_event_type` VALUES (4,'en','USER_INVITE','Invitation of a new site user','#ID# - User ID\n#LOGIN# - Login\n#URL_LOGIN# - Encoded login for use in URL\n#EMAIL# - EMail\n#NAME# - Name\n#LAST_NAME# - Last Name\n#PASSWORD# - User password \n#CHECKWORD# - Password check string\n#XML_ID# - User ID to link with external data sources\n\n',4);
INSERT INTO `b_event_type` VALUES (5,'en','FEEDBACK_FORM','Sending a message using a feedback form','#AUTHOR# - Message author\n#AUTHOR_EMAIL# - Author\'s e-mail address\n#TEXT# - Message text\n#EMAIL_FROM# - Sender\'s e-mail address\n#EMAIL_TO# - Recipient\'s e-mail address',5);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_favorite`
-- 




DROP TABLE IF EXISTS `b_favorite`;
CREATE TABLE `b_favorite` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` datetime DEFAULT NULL,
  `DATE_CREATE` datetime DEFAULT NULL,
  `C_SORT` int(18) NOT NULL DEFAULT '100',
  `MODIFIED_BY` int(18) DEFAULT NULL,
  `CREATED_BY` int(18) DEFAULT NULL,
  `MODULE_ID` varchar(50)  DEFAULT NULL,
  `NAME` varchar(255)  DEFAULT NULL,
  `URL` text ,
  `COMMENTS` text ,
  `LANGUAGE_ID` char(2)  DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL,
  `COMMON` char(1)  NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_file`
-- 




DROP TABLE IF EXISTS `b_file`;
CREATE TABLE `b_file` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODULE_ID` varchar(50)  DEFAULT NULL,
  `HEIGHT` int(18) DEFAULT NULL,
  `WIDTH` int(18) DEFAULT NULL,
  `FILE_SIZE` int(18) NOT NULL,
  `CONTENT_TYPE` varchar(255)  DEFAULT 'IMAGE',
  `SUBDIR` varchar(255)  DEFAULT NULL,
  `FILE_NAME` varchar(255)  NOT NULL,
  `ORIGINAL_NAME` varchar(255)  DEFAULT NULL,
  `DESCRIPTION` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_file_search`
-- 




DROP TABLE IF EXISTS `b_file_search`;
CREATE TABLE `b_file_search` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SESS_ID` varchar(255)  NOT NULL,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `F_PATH` varchar(255)  DEFAULT NULL,
  `B_DIR` int(11) NOT NULL DEFAULT '0',
  `F_SIZE` int(11) NOT NULL DEFAULT '0',
  `F_TIME` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_group`
-- 




DROP TABLE IF EXISTS `b_group`;
CREATE TABLE `b_group` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `C_SORT` int(18) NOT NULL DEFAULT '100',
  `ANONYMOUS` char(1)  NOT NULL DEFAULT 'N',
  `NAME` varchar(255)  NOT NULL,
  `DESCRIPTION` varchar(255)  DEFAULT NULL,
  `SECURITY_POLICY` text ,
  `STRING_ID` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_group`
-- 


INSERT INTO `b_group` VALUES (1,'2010-11-08 12:08:16','Y',1,'N','Administrators','Full access.',NULL,NULL);
INSERT INTO `b_group` VALUES (2,'2010-11-08 12:08:16','Y',2,'Y','All users (with non-authorized users)','All users (including non-authorized users).',NULL,NULL);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_group_collection_task`
-- 




DROP TABLE IF EXISTS `b_group_collection_task`;
CREATE TABLE `b_group_collection_task` (
  `GROUP_ID` int(11) NOT NULL,
  `TASK_ID` int(11) NOT NULL,
  `COLLECTION_ID` int(11) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`TASK_ID`,`COLLECTION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_group_subordinate`
-- 




DROP TABLE IF EXISTS `b_group_subordinate`;
CREATE TABLE `b_group_subordinate` (
  `ID` int(18) NOT NULL,
  `AR_SUBGROUP_ID` varchar(255)  NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_group_task`
-- 




DROP TABLE IF EXISTS `b_group_task`;
CREATE TABLE `b_group_task` (
  `GROUP_ID` int(18) NOT NULL,
  `TASK_ID` int(18) NOT NULL,
  `EXTERNAL_ID` varchar(50)  DEFAULT '',
  PRIMARY KEY (`GROUP_ID`,`TASK_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock`
-- 




DROP TABLE IF EXISTS `b_iblock`;
CREATE TABLE `b_iblock` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IBLOCK_TYPE_ID` varchar(50)  NOT NULL,
  `LID` char(2)  NOT NULL,
  `CODE` varchar(50)  DEFAULT NULL,
  `NAME` varchar(255)  NOT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `LIST_PAGE_URL` varchar(255)  DEFAULT NULL,
  `DETAIL_PAGE_URL` varchar(255)  DEFAULT NULL,
  `SECTION_PAGE_URL` varchar(255)  DEFAULT NULL,
  `PICTURE` int(18) DEFAULT NULL,
  `DESCRIPTION` text ,
  `DESCRIPTION_TYPE` char(4)  NOT NULL DEFAULT 'text',
  `RSS_TTL` int(11) NOT NULL DEFAULT '24',
  `RSS_ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `RSS_FILE_ACTIVE` char(1)  NOT NULL DEFAULT 'N',
  `RSS_FILE_LIMIT` int(11) DEFAULT NULL,
  `RSS_FILE_DAYS` int(11) DEFAULT NULL,
  `RSS_YANDEX_ACTIVE` char(1)  NOT NULL DEFAULT 'N',
  `XML_ID` varchar(255)  DEFAULT NULL,
  `TMP_ID` varchar(40)  DEFAULT NULL,
  `INDEX_ELEMENT` char(1)  NOT NULL DEFAULT 'Y',
  `INDEX_SECTION` char(1)  NOT NULL DEFAULT 'N',
  `WORKFLOW` char(1)  NOT NULL DEFAULT 'Y',
  `BIZPROC` char(1)  NOT NULL DEFAULT 'N',
  `SECTION_CHOOSER` char(1)  DEFAULT NULL,
  `LIST_MODE` char(1)  DEFAULT NULL,
  `VERSION` int(11) NOT NULL DEFAULT '1',
  `LAST_CONV_ELEMENT` int(11) NOT NULL DEFAULT '0',
  `SOCNET_GROUP_ID` int(18) DEFAULT NULL,
  `EDIT_FILE_BEFORE` varchar(255)  DEFAULT NULL,
  `EDIT_FILE_AFTER` varchar(255)  DEFAULT NULL,
  `SECTIONS_NAME` varchar(100)  DEFAULT NULL,
  `SECTION_NAME` varchar(100)  DEFAULT NULL,
  `ELEMENTS_NAME` varchar(100)  DEFAULT NULL,
  `ELEMENT_NAME` varchar(100)  DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock` (`IBLOCK_TYPE_ID`,`LID`,`ACTIVE`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_iblock`
-- 


INSERT INTO `b_iblock` VALUES (5,'2015-12-01 08:10:58','vn','s1','','Tin tuc','Y',500,'#SITE_DIR#/vn/index.php?ID=#IBLOCK_ID#','#SITE_DIR#/vn/detail.php?ID=#ID#','#SITE_DIR#/vn/list.php?SECTION_ID=#ID#',NULL,'','text',24,'Y','N',NULL,NULL,'N',NULL,NULL,'N','N','N','N','L','',1,0,NULL,'','','Sections','Section','Elements','Element');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_cache`
-- 




DROP TABLE IF EXISTS `b_iblock_cache`;
CREATE TABLE `b_iblock_cache` (
  `CACHE_KEY` varchar(35)  NOT NULL,
  `CACHE` longtext  NOT NULL,
  `CACHE_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`CACHE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_element`
-- 




DROP TABLE IF EXISTS `b_iblock_element`;
CREATE TABLE `b_iblock_element` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` datetime DEFAULT NULL,
  `MODIFIED_BY` int(18) DEFAULT NULL,
  `DATE_CREATE` datetime DEFAULT NULL,
  `CREATED_BY` int(18) DEFAULT NULL,
  `IBLOCK_ID` int(11) NOT NULL DEFAULT '0',
  `IBLOCK_SECTION_ID` int(11) DEFAULT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `ACTIVE_FROM` datetime DEFAULT NULL,
  `ACTIVE_TO` datetime DEFAULT NULL,
  `SORT` int(11) NOT NULL DEFAULT '500',
  `NAME` varchar(255)  NOT NULL,
  `PREVIEW_PICTURE` int(18) DEFAULT NULL,
  `PREVIEW_TEXT` text ,
  `PREVIEW_TEXT_TYPE` varchar(4)  NOT NULL DEFAULT 'text',
  `DETAIL_PICTURE` int(18) DEFAULT NULL,
  `DETAIL_TEXT` longtext ,
  `DETAIL_TEXT_TYPE` varchar(4)  NOT NULL DEFAULT 'text',
  `SEARCHABLE_CONTENT` text ,
  `WF_STATUS_ID` int(18) DEFAULT '1',
  `WF_PARENT_ELEMENT_ID` int(11) DEFAULT NULL,
  `WF_NEW` char(1)  DEFAULT NULL,
  `WF_LOCKED_BY` int(18) DEFAULT NULL,
  `WF_DATE_LOCK` datetime DEFAULT NULL,
  `WF_COMMENTS` text ,
  `IN_SECTIONS` char(1)  NOT NULL DEFAULT 'N',
  `XML_ID` varchar(255)  DEFAULT NULL,
  `CODE` varchar(255)  DEFAULT NULL,
  `TAGS` varchar(255)  DEFAULT NULL,
  `TMP_ID` varchar(40)  DEFAULT NULL,
  `WF_LAST_HISTORY_ID` int(11) DEFAULT NULL,
  `SHOW_COUNTER` int(18) DEFAULT NULL,
  `SHOW_COUNTER_START` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_element_1` (`IBLOCK_ID`,`IBLOCK_SECTION_ID`),
  KEY `ix_iblock_element_4` (`IBLOCK_ID`,`XML_ID`,`WF_PARENT_ELEMENT_ID`),
  KEY `ix_iblock_element_3` (`WF_PARENT_ELEMENT_ID`),
  KEY `ix_iblock_element_code` (`IBLOCK_ID`,`CODE`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_element_lock`
-- 




DROP TABLE IF EXISTS `b_iblock_element_lock`;
CREATE TABLE `b_iblock_element_lock` (
  `IBLOCK_ELEMENT_ID` int(11) NOT NULL,
  `DATE_LOCK` datetime DEFAULT NULL,
  `LOCKED_BY` varchar(32)  DEFAULT NULL,
  PRIMARY KEY (`IBLOCK_ELEMENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_element_property`
-- 




DROP TABLE IF EXISTS `b_iblock_element_property`;
CREATE TABLE `b_iblock_element_property` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IBLOCK_PROPERTY_ID` int(11) NOT NULL,
  `IBLOCK_ELEMENT_ID` int(11) NOT NULL,
  `VALUE` text  NOT NULL,
  `VALUE_TYPE` char(4)  NOT NULL DEFAULT 'text',
  `VALUE_ENUM` int(11) DEFAULT NULL,
  `VALUE_NUM` decimal(18,4) DEFAULT NULL,
  `DESCRIPTION` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_element_property_1` (`IBLOCK_ELEMENT_ID`,`IBLOCK_PROPERTY_ID`),
  KEY `ix_iblock_element_property_2` (`IBLOCK_PROPERTY_ID`),
  KEY `ix_iblock_element_prop_enum` (`VALUE_ENUM`,`IBLOCK_PROPERTY_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_fields`
-- 




DROP TABLE IF EXISTS `b_iblock_fields`;
CREATE TABLE `b_iblock_fields` (
  `IBLOCK_ID` int(18) NOT NULL,
  `FIELD_ID` varchar(50)  NOT NULL,
  `IS_REQUIRED` char(1)  DEFAULT NULL,
  `DEFAULT_VALUE` longtext ,
  PRIMARY KEY (`IBLOCK_ID`,`FIELD_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_iblock_fields`
-- 


INSERT INTO `b_iblock_fields` VALUES (5,'SECTION_CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"_\";s:11:\"TRANS_OTHER\";s:1:\"_\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}');
INSERT INTO `b_iblock_fields` VALUES (5,'SECTION_XML_ID','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'SECTION_DESCRIPTION_TYPE','Y','text');
INSERT INTO `b_iblock_fields` VALUES (5,'SECTION_DESCRIPTION','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'SECTION_DETAIL_PICTURE','N','a:6:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;}');
INSERT INTO `b_iblock_fields` VALUES (5,'SECTION_NAME','Y','');
INSERT INTO `b_iblock_fields` VALUES (5,'SECTION_PICTURE','N','a:9:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";}');
INSERT INTO `b_iblock_fields` VALUES (5,'TAGS','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"_\";s:11:\"TRANS_OTHER\";s:1:\"_\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}');
INSERT INTO `b_iblock_fields` VALUES (5,'XML_ID','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'DETAIL_TEXT','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'PREVIEW_TEXT','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'DETAIL_PICTURE','N','a:6:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;}');
INSERT INTO `b_iblock_fields` VALUES (5,'DETAIL_TEXT_TYPE','Y','text');
INSERT INTO `b_iblock_fields` VALUES (5,'PREVIEW_TEXT_TYPE','Y','text');
INSERT INTO `b_iblock_fields` VALUES (5,'PREVIEW_PICTURE','N','a:9:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";}');
INSERT INTO `b_iblock_fields` VALUES (5,'NAME','Y','');
INSERT INTO `b_iblock_fields` VALUES (5,'SORT','N','0');
INSERT INTO `b_iblock_fields` VALUES (5,'ACTIVE_TO','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'ACTIVE_FROM','N','');
INSERT INTO `b_iblock_fields` VALUES (5,'ACTIVE','Y','Y');
INSERT INTO `b_iblock_fields` VALUES (5,'IBLOCK_SECTION','N','');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_group`
-- 




DROP TABLE IF EXISTS `b_iblock_group`;
CREATE TABLE `b_iblock_group` (
  `IBLOCK_ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `PERMISSION` char(1)  NOT NULL,
  UNIQUE KEY `ux_iblock_group_1` (`IBLOCK_ID`,`GROUP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_iblock_group`
-- 


INSERT INTO `b_iblock_group` VALUES (5,1,'X');
INSERT INTO `b_iblock_group` VALUES (5,2,'R');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_messages`
-- 




DROP TABLE IF EXISTS `b_iblock_messages`;
CREATE TABLE `b_iblock_messages` (
  `IBLOCK_ID` int(18) NOT NULL,
  `MESSAGE_ID` varchar(50)  NOT NULL,
  `MESSAGE_TEXT` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`IBLOCK_ID`,`MESSAGE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_iblock_messages`
-- 


INSERT INTO `b_iblock_messages` VALUES (5,'SECTION_DELETE','Delete section');
INSERT INTO `b_iblock_messages` VALUES (5,'SECTION_EDIT','Modify section');
INSERT INTO `b_iblock_messages` VALUES (5,'SECTION_ADD','Add section');
INSERT INTO `b_iblock_messages` VALUES (5,'SECTIONS_NAME','Sections');
INSERT INTO `b_iblock_messages` VALUES (5,'SECTION_NAME','Section');
INSERT INTO `b_iblock_messages` VALUES (5,'ELEMENT_DELETE','Delete element');
INSERT INTO `b_iblock_messages` VALUES (5,'ELEMENT_EDIT','Modify element');
INSERT INTO `b_iblock_messages` VALUES (5,'ELEMENT_ADD','Add element');
INSERT INTO `b_iblock_messages` VALUES (5,'ELEMENTS_NAME','Elements');
INSERT INTO `b_iblock_messages` VALUES (5,'ELEMENT_NAME','Element');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_property`
-- 




DROP TABLE IF EXISTS `b_iblock_property`;
CREATE TABLE `b_iblock_property` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IBLOCK_ID` int(11) NOT NULL,
  `NAME` varchar(100)  NOT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `CODE` varchar(50)  DEFAULT NULL,
  `DEFAULT_VALUE` text ,
  `PROPERTY_TYPE` char(1)  NOT NULL DEFAULT 'S',
  `ROW_COUNT` int(11) NOT NULL DEFAULT '1',
  `COL_COUNT` int(11) NOT NULL DEFAULT '30',
  `LIST_TYPE` char(1)  NOT NULL DEFAULT 'L',
  `MULTIPLE` char(1)  NOT NULL DEFAULT 'N',
  `XML_ID` varchar(100)  DEFAULT NULL,
  `FILE_TYPE` varchar(200)  DEFAULT NULL,
  `MULTIPLE_CNT` int(11) DEFAULT NULL,
  `TMP_ID` varchar(40)  DEFAULT NULL,
  `LINK_IBLOCK_ID` int(18) DEFAULT NULL,
  `WITH_DESCRIPTION` char(1)  DEFAULT NULL,
  `SEARCHABLE` char(1)  NOT NULL DEFAULT 'N',
  `FILTRABLE` char(1)  NOT NULL DEFAULT 'N',
  `IS_REQUIRED` char(1)  DEFAULT NULL,
  `VERSION` int(11) NOT NULL DEFAULT '1',
  `USER_TYPE` varchar(255)  DEFAULT NULL,
  `USER_TYPE_SETTINGS` text ,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_property_1` (`IBLOCK_ID`),
  KEY `ix_iblock_property_2` (`CODE`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_property_enum`
-- 




DROP TABLE IF EXISTS `b_iblock_property_enum`;
CREATE TABLE `b_iblock_property_enum` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROPERTY_ID` int(11) NOT NULL,
  `VALUE` varchar(255)  NOT NULL,
  `DEF` char(1)  NOT NULL DEFAULT 'N',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `XML_ID` varchar(200)  NOT NULL,
  `TMP_ID` varchar(40)  DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_iblock_property_enum` (`PROPERTY_ID`,`XML_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_rss`
-- 




DROP TABLE IF EXISTS `b_iblock_rss`;
CREATE TABLE `b_iblock_rss` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IBLOCK_ID` int(11) NOT NULL,
  `NODE` varchar(50)  NOT NULL,
  `NODE_VALUE` varchar(250)  DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_section`
-- 




DROP TABLE IF EXISTS `b_iblock_section`;
CREATE TABLE `b_iblock_section` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED_BY` int(18) DEFAULT NULL,
  `DATE_CREATE` datetime DEFAULT NULL,
  `CREATED_BY` int(18) DEFAULT NULL,
  `IBLOCK_ID` int(11) NOT NULL,
  `IBLOCK_SECTION_ID` int(11) DEFAULT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `GLOBAL_ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `NAME` varchar(255)  NOT NULL,
  `PICTURE` int(18) DEFAULT NULL,
  `LEFT_MARGIN` int(18) DEFAULT NULL,
  `RIGHT_MARGIN` int(18) DEFAULT NULL,
  `DEPTH_LEVEL` int(18) DEFAULT NULL,
  `DESCRIPTION` text ,
  `DESCRIPTION_TYPE` char(4)  NOT NULL DEFAULT 'text',
  `SEARCHABLE_CONTENT` text ,
  `CODE` varchar(255)  DEFAULT NULL,
  `XML_ID` varchar(255)  DEFAULT NULL,
  `TMP_ID` varchar(40)  DEFAULT NULL,
  `DETAIL_PICTURE` int(18) DEFAULT NULL,
  `SOCNET_GROUP_ID` int(18) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_section_1` (`IBLOCK_ID`,`IBLOCK_SECTION_ID`),
  KEY `ix_iblock_section_depth_level` (`IBLOCK_ID`,`DEPTH_LEVEL`),
  KEY `ix_iblock_section_left_margin` (`IBLOCK_ID`,`LEFT_MARGIN`,`RIGHT_MARGIN`),
  KEY `ix_iblock_section_right_margin` (`IBLOCK_ID`,`RIGHT_MARGIN`,`LEFT_MARGIN`),
  KEY `ix_iblock_section_code` (`IBLOCK_ID`,`CODE`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_section_element`
-- 




DROP TABLE IF EXISTS `b_iblock_section_element`;
CREATE TABLE `b_iblock_section_element` (
  `IBLOCK_SECTION_ID` int(11) NOT NULL,
  `IBLOCK_ELEMENT_ID` int(11) NOT NULL,
  `ADDITIONAL_PROPERTY_ID` int(18) DEFAULT NULL,
  UNIQUE KEY `ux_iblock_section_element` (`IBLOCK_SECTION_ID`,`IBLOCK_ELEMENT_ID`,`ADDITIONAL_PROPERTY_ID`),
  KEY `UX_IBLOCK_SECTION_ELEMENT2` (`IBLOCK_ELEMENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_sequence`
-- 




DROP TABLE IF EXISTS `b_iblock_sequence`;
CREATE TABLE `b_iblock_sequence` (
  `IBLOCK_ID` int(18) NOT NULL,
  `CODE` varchar(50)  NOT NULL,
  `SEQ_VALUE` int(11) DEFAULT NULL,
  PRIMARY KEY (`IBLOCK_ID`,`CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_site`
-- 




DROP TABLE IF EXISTS `b_iblock_site`;
CREATE TABLE `b_iblock_site` (
  `IBLOCK_ID` int(18) NOT NULL,
  `SITE_ID` char(2)  NOT NULL,
  PRIMARY KEY (`IBLOCK_ID`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_iblock_site`
-- 


INSERT INTO `b_iblock_site` VALUES (5,'s1');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_type`
-- 




DROP TABLE IF EXISTS `b_iblock_type`;
CREATE TABLE `b_iblock_type` (
  `ID` varchar(50)  NOT NULL,
  `SECTIONS` char(1)  NOT NULL DEFAULT 'Y',
  `EDIT_FILE_BEFORE` varchar(255)  DEFAULT NULL,
  `EDIT_FILE_AFTER` varchar(255)  DEFAULT NULL,
  `IN_RSS` char(1)  NOT NULL DEFAULT 'N',
  `SORT` int(18) NOT NULL DEFAULT '500',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_iblock_type`
-- 


INSERT INTO `b_iblock_type` VALUES ('vn','Y','','','N',500);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_iblock_type_lang`
-- 




DROP TABLE IF EXISTS `b_iblock_type_lang`;
CREATE TABLE `b_iblock_type_lang` (
  `IBLOCK_TYPE_ID` varchar(50)  NOT NULL,
  `LID` char(2)  NOT NULL,
  `NAME` varchar(100)  NOT NULL,
  `SECTION_NAME` varchar(100)  DEFAULT NULL,
  `ELEMENT_NAME` varchar(100)  NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_iblock_type_lang`
-- 


INSERT INTO `b_iblock_type_lang` VALUES ('vn','en','Tieng Viet','','');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_lang`
-- 




DROP TABLE IF EXISTS `b_lang`;
CREATE TABLE `b_lang` (
  `LID` char(2)  NOT NULL,
  `SORT` int(18) NOT NULL DEFAULT '100',
  `DEF` char(1)  NOT NULL DEFAULT 'N',
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `NAME` varchar(50)  NOT NULL,
  `DIR` varchar(50)  NOT NULL,
  `FORMAT_DATE` varchar(50)  NOT NULL,
  `FORMAT_DATETIME` varchar(50)  NOT NULL,
  `CHARSET` varchar(255)  DEFAULT NULL,
  `LANGUAGE_ID` char(2)  NOT NULL,
  `DOC_ROOT` varchar(255)  DEFAULT NULL,
  `DOMAIN_LIMITED` char(1)  NOT NULL DEFAULT 'N',
  `SERVER_NAME` varchar(255)  DEFAULT NULL,
  `SITE_NAME` varchar(255)  DEFAULT NULL,
  `EMAIL` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`LID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_lang`
-- 


INSERT INTO `b_lang` VALUES ('s1',1,'Y','Y','Web Go','/','MM/DD/YYYY','MM/DD/YYYY HH:MI:SS','UTF-8','en','','N','','Web Go','');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_lang_domain`
-- 




DROP TABLE IF EXISTS `b_lang_domain`;
CREATE TABLE `b_lang_domain` (
  `LID` char(2)  NOT NULL,
  `DOMAIN` varchar(255)  NOT NULL,
  PRIMARY KEY (`LID`,`DOMAIN`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_language`
-- 




DROP TABLE IF EXISTS `b_language`;
CREATE TABLE `b_language` (
  `LID` char(2)  NOT NULL,
  `SORT` int(11) NOT NULL DEFAULT '100',
  `DEF` char(1)  NOT NULL DEFAULT 'N',
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `NAME` varchar(50)  NOT NULL,
  `FORMAT_DATE` varchar(50)  NOT NULL,
  `FORMAT_DATETIME` varchar(50)  NOT NULL,
  `CHARSET` varchar(255)  DEFAULT NULL,
  `DIRECTION` char(1)  NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`LID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_language`
-- 


INSERT INTO `b_language` VALUES ('en',1,'Y','Y','English','MM/DD/YYYY','MM/DD/YYYY HH:MI:SS','UTF-8','Y');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_medialib_collection`
-- 




DROP TABLE IF EXISTS `b_medialib_collection`;
CREATE TABLE `b_medialib_collection` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255)  NOT NULL,
  `DESCRIPTION` text ,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `DATE_UPDATE` datetime NOT NULL,
  `OWNER_ID` int(11) DEFAULT NULL,
  `PARENT_ID` int(11) DEFAULT NULL,
  `SITE_ID` char(2)  DEFAULT NULL,
  `KEYWORDS` varchar(255)  DEFAULT NULL,
  `ITEMS_COUNT` int(11) DEFAULT NULL,
  `ML_TYPE` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_medialib_collection_item`
-- 




DROP TABLE IF EXISTS `b_medialib_collection_item`;
CREATE TABLE `b_medialib_collection_item` (
  `COLLECTION_ID` int(11) NOT NULL,
  `ITEM_ID` int(11) NOT NULL,
  PRIMARY KEY (`ITEM_ID`,`COLLECTION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_medialib_item`
-- 




DROP TABLE IF EXISTS `b_medialib_item`;
CREATE TABLE `b_medialib_item` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255)  NOT NULL,
  `ITEM_TYPE` char(30)  NOT NULL,
  `DESCRIPTION` text ,
  `DATE_CREATE` datetime NOT NULL,
  `DATE_UPDATE` datetime NOT NULL,
  `SOURCE_ID` int(11) NOT NULL,
  `KEYWORDS` varchar(255)  DEFAULT NULL,
  `SEARCHABLE_CONTENT` text ,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_medialib_type`
-- 




DROP TABLE IF EXISTS `b_medialib_type`;
CREATE TABLE `b_medialib_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255)  DEFAULT NULL,
  `CODE` varchar(255)  NOT NULL,
  `EXT` varchar(255)  NOT NULL,
  `SYSTEM` char(1)  NOT NULL DEFAULT 'N',
  `DESCRIPTION` text ,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_medialib_type`
-- 


INSERT INTO `b_medialib_type` VALUES (1,'image_name','image','jpg,jpeg,gif,png','Y','image_desc');
INSERT INTO `b_medialib_type` VALUES (2,'video_name','video','flv,mp4,wmv','Y','video_desc');
INSERT INTO `b_medialib_type` VALUES (3,'sound_name','sound','mp3,wma,aac','Y','sound_desc');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_module`
-- 




DROP TABLE IF EXISTS `b_module`;
CREATE TABLE `b_module` (
  `ID` varchar(50)  NOT NULL,
  `DATE_ACTIVE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_module`
-- 


INSERT INTO `b_module` VALUES ('main','2010-11-08 12:08:16');
INSERT INTO `b_module` VALUES ('compression','2010-11-08 12:08:49');
INSERT INTO `b_module` VALUES ('fileman','2010-11-08 12:08:52');
INSERT INTO `b_module` VALUES ('iblock','2010-11-08 12:09:13');
INSERT INTO `b_module` VALUES ('perfmon','2010-11-08 12:09:43');
INSERT INTO `b_module` VALUES ('search','2010-11-08 12:09:47');
INSERT INTO `b_module` VALUES ('seo','2010-11-08 12:09:52');
INSERT INTO `b_module` VALUES ('sitecorporate','2010-11-08 12:09:57');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_module_group`
-- 




DROP TABLE IF EXISTS `b_module_group`;
CREATE TABLE `b_module_group` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MODULE_ID` varchar(50)  NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `G_ACCESS` varchar(255)  NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_GROUP_MODULE` (`MODULE_ID`,`GROUP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_module_to_module`
-- 




DROP TABLE IF EXISTS `b_module_to_module`;
CREATE TABLE `b_module_to_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SORT` int(18) NOT NULL DEFAULT '100',
  `FROM_MODULE_ID` varchar(50)  NOT NULL,
  `MESSAGE_ID` varchar(50)  NOT NULL,
  `TO_MODULE_ID` varchar(50)  NOT NULL,
  `TO_PATH` varchar(255)  DEFAULT NULL,
  `TO_CLASS` varchar(50)  DEFAULT NULL,
  `TO_METHOD` varchar(50)  DEFAULT NULL,
  `TO_METHOD_ARG` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_module_to_module` (`FROM_MODULE_ID`,`MESSAGE_ID`,`TO_MODULE_ID`,`TO_CLASS`,`TO_METHOD`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_module_to_module`
-- 


INSERT INTO `b_module_to_module` VALUES (1,'2010-11-08 12:08:16',100,'iblock','OnIBlockPropertyBuildList','main','/modules/main/tools/prop_userid.php','CIBlockPropertyUserID','GetUserTypeDescription','');
INSERT INTO `b_module_to_module` VALUES (2,'2010-11-08 12:08:16',100,'main','OnUserDelete','main','/modules/main/classes/mysql/favorites.php','CFavorites','OnUserDelete','');
INSERT INTO `b_module_to_module` VALUES (3,'2010-11-08 12:08:16',100,'main','OnLanguageDelete','main','/modules/main/classes/mysql/favorites.php','CFavorites','OnLanguageDelete','');
INSERT INTO `b_module_to_module` VALUES (4,'2010-11-08 12:08:16',100,'main','OnUserDelete','main','/modules/main/classes/mysql/favorites.php','CUserOptions','OnUserDelete','');
INSERT INTO `b_module_to_module` VALUES (5,'2010-11-08 12:08:16',100,'main','OnChangeFile','main','','CMain','OnChangeFileComponent','');
INSERT INTO `b_module_to_module` VALUES (6,'2010-11-08 12:08:16',100,'main','OnUserTypeRightsCheck','main','','CUser','UserTypeRightsCheck','');
INSERT INTO `b_module_to_module` VALUES (7,'2010-11-08 12:08:16',100,'main','OnUserLogin','main','','UpdateTools','CheckUpdates','');
INSERT INTO `b_module_to_module` VALUES (8,'2010-11-08 12:08:16',100,'main','OnModuleUpdate','main','','UpdateTools','SetUpdateResult','');
INSERT INTO `b_module_to_module` VALUES (9,'2010-11-08 12:08:16',100,'main','OnUpdateCheck','main','','UpdateTools','SetUpdateError','');
INSERT INTO `b_module_to_module` VALUES (10,'2010-11-08 12:08:16',100,'main','OnPanelCreate','main','','CUndo','CheckNotifyMessage','');
INSERT INTO `b_module_to_module` VALUES (11,'2010-11-08 12:08:49',1,'main','OnPageStart','compression','','CCompress','OnPageStart','');
INSERT INTO `b_module_to_module` VALUES (12,'2010-11-08 12:08:49',10000,'main','OnAfterEpilog','compression','','CCompress','OnAfterEpilog','');
INSERT INTO `b_module_to_module` VALUES (13,'2010-11-08 12:08:52',100,'main','OnGroupDelete','fileman','','CFileman','OnGroupDelete','');
INSERT INTO `b_module_to_module` VALUES (14,'2010-11-08 12:08:52',100,'main','OnPanelCreate','fileman','','CFileman','OnPanelCreate','');
INSERT INTO `b_module_to_module` VALUES (15,'2010-11-08 12:08:52',100,'main','OnModuleUpdate','fileman','','CFileman','OnModuleUpdate','');
INSERT INTO `b_module_to_module` VALUES (16,'2010-11-08 12:08:52',100,'main','OnModuleInstalled','fileman','','CFileman','ClearComponentsListCache','');
INSERT INTO `b_module_to_module` VALUES (17,'2010-11-08 12:08:52',100,'iblock','OnIBlockPropertyBuildList','fileman','','CIBlockPropertyMapGoogle','GetUserTypeDescription','');
INSERT INTO `b_module_to_module` VALUES (18,'2010-11-08 12:08:52',100,'iblock','OnIBlockPropertyBuildList','fileman','','CIBlockPropertyMapYandex','GetUserTypeDescription','');
INSERT INTO `b_module_to_module` VALUES (19,'2010-11-08 12:08:52',100,'iblock','OnIBlockPropertyBuildList','fileman','','CIBlockPropertyVideo','GetUserTypeDescription','');
INSERT INTO `b_module_to_module` VALUES (20,'2010-11-08 12:08:52',100,'main','OnUserTypeBuildList','fileman','','CUserTypeVideo','GetUserTypeDescription','');
INSERT INTO `b_module_to_module` VALUES (21,'2010-11-08 12:09:13',100,'main','OnGroupDelete','iblock','','CIBlock','OnGroupDelete','');
INSERT INTO `b_module_to_module` VALUES (22,'2010-11-08 12:09:13',100,'main','OnBeforeLangDelete','iblock','','CIBlock','OnBeforeLangDelete','');
INSERT INTO `b_module_to_module` VALUES (23,'2010-11-08 12:09:13',100,'main','OnLangDelete','iblock','','CIBlock','OnLangDelete','');
INSERT INTO `b_module_to_module` VALUES (24,'2010-11-08 12:09:13',100,'main','OnUserTypeRightsCheck','iblock','','CIBlockSection','UserTypeRightsCheck','');
INSERT INTO `b_module_to_module` VALUES (25,'2010-11-08 12:09:13',100,'search','OnReindex','iblock','','CIBlock','OnSearchReindex','');
INSERT INTO `b_module_to_module` VALUES (26,'2010-11-08 12:09:13',100,'search','OnSearchGetURL','iblock','','CIBlock','OnSearchGetURL','');
INSERT INTO `b_module_to_module` VALUES (27,'2010-11-08 12:09:47',100,'main','OnChangePermissions','search','','CSearch','OnChangeFilePermissions','');
INSERT INTO `b_module_to_module` VALUES (28,'2010-11-08 12:09:47',100,'main','OnChangeFile','search','','CSearch','OnChangeFile','');
INSERT INTO `b_module_to_module` VALUES (29,'2010-11-08 12:09:47',100,'main','OnGroupDelete','search','','CSearch','OnGroupDelete','');
INSERT INTO `b_module_to_module` VALUES (30,'2010-11-08 12:09:47',100,'main','OnLangDelete','search','','CSearch','OnLangDelete','');
INSERT INTO `b_module_to_module` VALUES (31,'2010-11-08 12:09:47',90,'main','OnEpilog','search','','CSearchStatistic','OnEpilog','');
INSERT INTO `b_module_to_module` VALUES (32,'2010-11-08 12:09:52',100,'main','OnPanelCreate','seo','','CSeoEventHandlers','SeoOnPanelCreate','');
INSERT INTO `b_module_to_module` VALUES (33,'2010-11-08 12:09:57',100,'main','OnBeforeProlog','sitecorporate','','CSiteCorporate','ShowPanel','');
INSERT INTO `b_module_to_module` VALUES (34,'2010-11-08 12:10:50',100,'main','OnBeforeProlog','main','/modules/main/install/wizard_sol/panel_button.php','CWizardSolPanel','ShowPanel','');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_operation`
-- 




DROP TABLE IF EXISTS `b_operation`;
CREATE TABLE `b_operation` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50)  NOT NULL,
  `MODULE_ID` varchar(50)  NOT NULL,
  `DESCRIPTION` varchar(255)  DEFAULT NULL,
  `BINDING` varchar(50)  DEFAULT 'module',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_operation`
-- 


INSERT INTO `b_operation` VALUES (1,'view_own_profile','main',NULL,'module');
INSERT INTO `b_operation` VALUES (2,'view_subordinate_users','main',NULL,'module');
INSERT INTO `b_operation` VALUES (3,'view_all_users','main',NULL,'module');
INSERT INTO `b_operation` VALUES (4,'view_groups','main',NULL,'module');
INSERT INTO `b_operation` VALUES (5,'view_tasks','main',NULL,'module');
INSERT INTO `b_operation` VALUES (6,'view_other_settings','main',NULL,'module');
INSERT INTO `b_operation` VALUES (7,'edit_own_profile','main',NULL,'module');
INSERT INTO `b_operation` VALUES (8,'edit_all_users','main',NULL,'module');
INSERT INTO `b_operation` VALUES (9,'edit_subordinate_users','main',NULL,'module');
INSERT INTO `b_operation` VALUES (10,'edit_groups','main',NULL,'module');
INSERT INTO `b_operation` VALUES (11,'edit_tasks','main',NULL,'module');
INSERT INTO `b_operation` VALUES (12,'edit_other_settings','main',NULL,'module');
INSERT INTO `b_operation` VALUES (13,'cache_control','main',NULL,'module');
INSERT INTO `b_operation` VALUES (14,'edit_php','main',NULL,'module');
INSERT INTO `b_operation` VALUES (15,'fm_view_permission','main',NULL,'file');
INSERT INTO `b_operation` VALUES (16,'fm_edit_permission','main',NULL,'file');
INSERT INTO `b_operation` VALUES (17,'fm_edit_existent_folder','main',NULL,'file');
INSERT INTO `b_operation` VALUES (18,'fm_create_new_file','main',NULL,'file');
INSERT INTO `b_operation` VALUES (19,'fm_edit_existent_file','main',NULL,'file');
INSERT INTO `b_operation` VALUES (20,'fm_create_new_folder','main',NULL,'file');
INSERT INTO `b_operation` VALUES (21,'fm_delete_file','main',NULL,'file');
INSERT INTO `b_operation` VALUES (22,'fm_delete_folder','main',NULL,'file');
INSERT INTO `b_operation` VALUES (23,'fm_view_file','main',NULL,'file');
INSERT INTO `b_operation` VALUES (24,'fm_view_listing','main',NULL,'file');
INSERT INTO `b_operation` VALUES (25,'fm_edit_in_workflow','main',NULL,'file');
INSERT INTO `b_operation` VALUES (26,'fm_rename_file','main',NULL,'file');
INSERT INTO `b_operation` VALUES (27,'fm_rename_folder','main',NULL,'file');
INSERT INTO `b_operation` VALUES (28,'fm_upload_file','main',NULL,'file');
INSERT INTO `b_operation` VALUES (29,'fm_add_to_menu','main',NULL,'file');
INSERT INTO `b_operation` VALUES (30,'fm_download_file','main',NULL,'file');
INSERT INTO `b_operation` VALUES (31,'fm_lpa','main',NULL,'file');
INSERT INTO `b_operation` VALUES (32,'lpa_template_edit','main',NULL,'module');
INSERT INTO `b_operation` VALUES (33,'view_event_log','main',NULL,'module');
INSERT INTO `b_operation` VALUES (34,'fileman_view_all_settings','fileman','','module');
INSERT INTO `b_operation` VALUES (35,'fileman_edit_menu_types','fileman','','module');
INSERT INTO `b_operation` VALUES (36,'fileman_add_element_to_menu','fileman','','module');
INSERT INTO `b_operation` VALUES (37,'fileman_edit_menu_elements','fileman','','module');
INSERT INTO `b_operation` VALUES (38,'fileman_edit_existent_files','fileman','','module');
INSERT INTO `b_operation` VALUES (39,'fileman_edit_existent_folders','fileman','','module');
INSERT INTO `b_operation` VALUES (40,'fileman_admin_files','fileman','','module');
INSERT INTO `b_operation` VALUES (41,'fileman_admin_folders','fileman','','module');
INSERT INTO `b_operation` VALUES (42,'fileman_view_permissions','fileman','','module');
INSERT INTO `b_operation` VALUES (43,'fileman_edit_all_settings','fileman','','module');
INSERT INTO `b_operation` VALUES (44,'fileman_upload_files','fileman','','module');
INSERT INTO `b_operation` VALUES (45,'fileman_view_file_structure','fileman','','module');
INSERT INTO `b_operation` VALUES (46,'fileman_install_control','fileman','','module');
INSERT INTO `b_operation` VALUES (47,'medialib_view_collection','fileman','','medialib');
INSERT INTO `b_operation` VALUES (48,'medialib_new_collection','fileman','','medialib');
INSERT INTO `b_operation` VALUES (49,'medialib_edit_collection','fileman','','medialib');
INSERT INTO `b_operation` VALUES (50,'medialib_del_collection','fileman','','medialib');
INSERT INTO `b_operation` VALUES (51,'medialib_access','fileman','','medialib');
INSERT INTO `b_operation` VALUES (52,'medialib_new_item','fileman','','medialib');
INSERT INTO `b_operation` VALUES (53,'medialib_edit_item','fileman','','medialib');
INSERT INTO `b_operation` VALUES (54,'medialib_del_item','fileman','','medialib');
INSERT INTO `b_operation` VALUES (55,'seo_settings','seo','','module');
INSERT INTO `b_operation` VALUES (56,'seo_tools','seo','','module');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_option`
-- 




DROP TABLE IF EXISTS `b_option`;
CREATE TABLE `b_option` (
  `MODULE_ID` varchar(50)  DEFAULT NULL,
  `NAME` varchar(50)  NOT NULL,
  `VALUE` text ,
  `DESCRIPTION` varchar(255)  DEFAULT NULL,
  `SITE_ID` char(2)  DEFAULT NULL,
  UNIQUE KEY `ix_option` (`MODULE_ID`,`NAME`,`SITE_ID`),
  KEY `ix_option_name` (`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_option`
-- 


INSERT INTO `b_option` VALUES ('main','auth_comp2','Y','Use Components 2.0 for authorization and registration:',NULL);
INSERT INTO `b_option` VALUES ('main','PARAM_MAX_SITES','2','',NULL);
INSERT INTO `b_option` VALUES ('main','PARAM_MAX_USERS','0','',NULL);
INSERT INTO `b_option` VALUES ('main','distributive6','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','new_license7_sign','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','GROUP_DEFAULT_TASK','1','Task for groups by default',NULL);
INSERT INTO `b_option` VALUES ('main','vendor','bitrix','',NULL);
INSERT INTO `b_option` VALUES ('main','admin_lid','en','',NULL);
INSERT INTO `b_option` VALUES ('main','update_site','www.bitrixsoft.com','Name of system update server:',NULL);
INSERT INTO `b_option` VALUES ('main','update_site_ns','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','server_uniq_id','961954a83f50903dc1616f729ece7ad7','',NULL);
INSERT INTO `b_option` VALUES ('main','email_from','dqhung.ec@gmail.com','E-mail of the site administrator (default sender address)',NULL);
INSERT INTO `b_option` VALUES ('fileman','different_set','Y','',NULL);
INSERT INTO `b_option` VALUES ('fileman','menutypes','a:3:{s:4:\\\"left\\\";s:12:\\\"Section menu\\\";s:3:\\\"top\\\";s:9:\\\"Main menu\\\";s:6:\\\"bottom\\\";s:11:\\\"Bottom Menu\\\";}','','s1');
INSERT INTO `b_option` VALUES ('main','wizard_template_id','furniture','','s1');
INSERT INTO `b_option` VALUES ('main','wizard_site_logo','0','','s1');
INSERT INTO `b_option` VALUES ('main','wizard_furniture_theme_id','dark-blue','','s1');
INSERT INTO `b_option` VALUES ('main','wizard_firstcorp_furniture_s1','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','wizard_solution','corp_furniture','','s1');
INSERT INTO `b_option` VALUES ('main','site_name','Webmin','Site name',NULL);
INSERT INTO `b_option` VALUES ('main','server_name','localhost','Site URL (without http://). E.g., www.mysite.com',NULL);
INSERT INTO `b_option` VALUES ('main','cookie_name','BITRIX_SM','Cookies name prefix (without dots and spaces):',NULL);
INSERT INTO `b_option` VALUES ('main','ALLOW_SPREAD_COOKIE','Y','Spread cookies to all sites:',NULL);
INSERT INTO `b_option` VALUES ('main','header_200','N','Replace status 404 with 200 in header:',NULL);
INSERT INTO `b_option` VALUES ('main','error_reporting','85','Error report mode:',NULL);
INSERT INTO `b_option` VALUES ('main','templates_visual_editor','N','Use WYSIWYG editor for Site Templates:',NULL);
INSERT INTO `b_option` VALUES ('main','all_bcc','','One or comma-separated list of E-mail addresses to receive copies of all outcoming messages',NULL);
INSERT INTO `b_option` VALUES ('main','send_mid','N','Send email event and template identifiers in message:',NULL);
INSERT INTO `b_option` VALUES ('main','fill_to_mail','N','E-mail address in caption',NULL);
INSERT INTO `b_option` VALUES ('main','CONVERT_UNIX_NEWLINE_2_WINDOWS','N','Convert Unix new lines to Windows format when sending messages:',NULL);
INSERT INTO `b_option` VALUES ('main','convert_mail_header','Y','Convert 8-bit characters in the message header:',NULL);
INSERT INTO `b_option` VALUES ('main','mail_event_period','14','Days to keep e-mail events:',NULL);
INSERT INTO `b_option` VALUES ('main','mail_event_bulk','5','Messages to send at a page request:',NULL);
INSERT INTO `b_option` VALUES ('main','mail_additional_parameters','','Additional parameter for mail() function:',NULL);
INSERT INTO `b_option` VALUES ('main','disk_space','','Available disk space (MB):',NULL);
INSERT INTO `b_option` VALUES ('main','upload_dir','upload','File upload default folder',NULL);
INSERT INTO `b_option` VALUES ('main','save_original_file_name','N','Keep the original names for uploaded files:',NULL);
INSERT INTO `b_option` VALUES ('main','convert_original_file_name','Y','Automatically replace non-valid symbols in the names of uploaded files:',NULL);
INSERT INTO `b_option` VALUES ('main','image_resize_quality','95','JPEG compression quality (percentage):',NULL);
INSERT INTO `b_option` VALUES ('main','map_top_menu_type','top','Menu type for the top level of the site map:',NULL);
INSERT INTO `b_option` VALUES ('main','map_left_menu_type','left','Menu type for other levels of the site map:',NULL);
INSERT INTO `b_option` VALUES ('main','update_site_proxy_addr','','Proxy address for update system:',NULL);
INSERT INTO `b_option` VALUES ('main','update_site_proxy_port','','Proxy port for update system:',NULL);
INSERT INTO `b_option` VALUES ('main','update_site_proxy_user','admin','Proxy user name (if auth requied)',NULL);
INSERT INTO `b_option` VALUES ('main','update_site_proxy_pass','123456','Proxy user password (if auth requied)',NULL);
INSERT INTO `b_option` VALUES ('main','strong_update_check','Y','Stress checking the integrity of the updates installation:',NULL);
INSERT INTO `b_option` VALUES ('main','stable_versions_only','Y','Download only stable updates:',NULL);
INSERT INTO `b_option` VALUES ('main','update_autocheck','','Autocheck For Updates:',NULL);
INSERT INTO `b_option` VALUES ('main','update_stop_autocheck','N','Abort Authocheck When Error(s) Occur:',NULL);
INSERT INTO `b_option` VALUES ('main','update_is_gzip_installed','Y','Don\'t Use Compression:',NULL);
INSERT INTO `b_option` VALUES ('main','update_load_timeout','30','Download Step Duration (sec):',NULL);
INSERT INTO `b_option` VALUES ('main','store_password','Y','Allow authorization caching:',NULL);
INSERT INTO `b_option` VALUES ('main','use_secure_password_cookies','N','Use secure storing of the authorization data in cookies:',NULL);
INSERT INTO `b_option` VALUES ('main','auth_multisite','N','Global authentication for all site domains:',NULL);
INSERT INTO `b_option` VALUES ('main','captcha_registration','N','Use CAPTCHA:',NULL);
INSERT INTO `b_option` VALUES ('main','auth_openid','N','Use OpenID',NULL);
INSERT INTO `b_option` VALUES ('main','auth_liveid','N','Use Live ID authentication:',NULL);
INSERT INTO `b_option` VALUES ('main','liveid_appid','','Live ID Application ID:',NULL);
INSERT INTO `b_option` VALUES ('main','liveid_secret','','Live ID Secret Key:',NULL);
INSERT INTO `b_option` VALUES ('main','new_user_registration','Y','Allow users to self-register?',NULL);
INSERT INTO `b_option` VALUES ('main','new_user_registration_def_group','','Upon registration, add to group:',NULL);
INSERT INTO `b_option` VALUES ('main','new_user_registration_email_confirmation','N','Send request for registration confirmation:</label><br><a href=\"/webmin/admin/message_admin.php?lang=en&set_filter=Y&find_type_id=NEW_USER_CONFIRM\">Edit e-mail templates</a><label>',NULL);
INSERT INTO `b_option` VALUES ('main','new_user_registration_cleanup_days','7','Delete unconfirmed registrations after (days):',NULL);
INSERT INTO `b_option` VALUES ('main','new_user_email_uniq_check','N','Check e-mail uniqueness:',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_cleanup_days','7','Keep events (days):',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_logout','N','Logout',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_login_success','N','Successful login',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_login_fail','N','Login failure',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_register','N','Log new user registrations',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_register_fail','N','Log registration errors',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_password_request','N','Log password change requests',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_password_change','N','Log password changes',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_user_delete','N','Log user deletion',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_user_groups','N','Log user group changes',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_group_policy','N','Log group security policy changes',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_module_access','N','Log module access permission changes',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_file_access','N','Log file access permission changes',NULL);
INSERT INTO `b_option` VALUES ('main','event_log_task','N','Log access permission changes',NULL);
INSERT INTO `b_option` VALUES ('main','auth_controller_prefix','','Controller side authorization prefix:',NULL);
INSERT INTO `b_option` VALUES ('main','auth_controller_sso','N','Authorize users of other client sites at this site:',NULL);
INSERT INTO `b_option` VALUES ('main','GROUP_DEFAULT_RIGHT','D','Right for groups by default',NULL);
INSERT INTO `b_option` VALUES ('main','~update_autocheck_result','a:3:{s:10:\"check_date\";i:0;s:6:\"result\";b:0;s:5:\"error\";s:44:\"[LICENSE_NOT_FOUND] License key is not found\";}','',NULL);
INSERT INTO `b_option` VALUES ('main','update_system_check','11/30/2015 10:37:35','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_max_exec_time_sleep','3','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_disable_gzip','N','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_integrity_check','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_max_file_size','0','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_max_exec_time','20','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_file_public','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_file_kernel','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_base_true','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_base_stat','','',NULL);
INSERT INTO `b_option` VALUES ('main','dump_base_index','','',NULL);
INSERT INTO `b_option` VALUES ('main','skip_symlinks','Y','',NULL);
INSERT INTO `b_option` VALUES ('main','skip_mask','','',NULL);
INSERT INTO `b_option` VALUES ('iblock','use_htmledit','Y','Use visual editor',NULL);
INSERT INTO `b_option` VALUES ('iblock','show_xml_id','','Show code from external DB source',NULL);
INSERT INTO `b_option` VALUES ('iblock','path2rss','/upload/','Path to exported RSS files',NULL);
INSERT INTO `b_option` VALUES ('iblock','combined_list_mode','Y','Combined view of sections and elements',NULL);
INSERT INTO `b_option` VALUES ('iblock','iblock_menu_max_sections','50','Maximum number of sections in menu',NULL);
INSERT INTO `b_option` VALUES ('perfmon','bitrix_optimal','N','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','total_mark_value','calc','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','total_mark_duration','300','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_page_rate','0.86','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_page_time','1.1679','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_session_time_value','0.0005','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_mail_value','0.7656','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_files_value','1 000.0','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_cpu_value','10.9','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','total_mark_time','01/04/2016 08:25:10','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','total_mark_hits','0','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','end_time','1451892610','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_page_date','22.03.2016 17:25:51','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_php_is_good','N','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_db_insert_value','7 131','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_db_read_value','6 274','',NULL);
INSERT INTO `b_option` VALUES ('perfmon','mark_db_update_value','6 848','',NULL);
INSERT INTO `b_option` VALUES ('main','component_cache_on','N','',NULL);
INSERT INTO `b_option` VALUES ('fileman','use_pspell','N','',NULL);
INSERT INTO `b_option` VALUES ('fileman','GROUP_DEFAULT_TASK','12','',NULL);
INSERT INTO `b_option` VALUES ('search','sm_max_execution_time','30','',NULL);
INSERT INTO `b_option` VALUES ('search','sm_record_limit','5000','',NULL);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_perf_component`
-- 




DROP TABLE IF EXISTS `b_perf_component`;
CREATE TABLE `b_perf_component` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `HIT_ID` int(18) DEFAULT NULL,
  `NN` int(18) DEFAULT NULL,
  `CACHE_TYPE` char(1)  DEFAULT NULL,
  `CACHE_SIZE` int(11) DEFAULT NULL,
  `COMPONENT_TIME` float DEFAULT NULL,
  `QUERIES` int(11) DEFAULT NULL,
  `QUERIES_TIME` float DEFAULT NULL,
  `COMPONENT_NAME` text ,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_B_PERF_COMPONENT_0` (`HIT_ID`,`NN`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_perf_error`
-- 




DROP TABLE IF EXISTS `b_perf_error`;
CREATE TABLE `b_perf_error` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `HIT_ID` int(18) DEFAULT NULL,
  `ERRNO` int(18) DEFAULT NULL,
  `ERRSTR` text ,
  `ERRFILE` text ,
  `ERRLINE` int(18) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_B_PERF_ERROR_0` (`HIT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_perf_hit`
-- 




DROP TABLE IF EXISTS `b_perf_hit`;
CREATE TABLE `b_perf_hit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_HIT` datetime DEFAULT NULL,
  `IS_ADMIN` char(1)  DEFAULT NULL,
  `REQUEST_METHOD` varchar(50)  DEFAULT NULL,
  `SERVER_NAME` varchar(50)  DEFAULT NULL,
  `SERVER_PORT` int(11) DEFAULT NULL,
  `SCRIPT_NAME` text ,
  `REQUEST_URI` text ,
  `INCLUDED_FILES` int(11) DEFAULT NULL,
  `MEMORY_PEAK_USAGE` int(11) DEFAULT NULL,
  `CACHE_TYPE` char(1)  DEFAULT NULL,
  `CACHE_SIZE` int(11) DEFAULT NULL,
  `QUERIES` int(11) DEFAULT NULL,
  `QUERIES_TIME` float DEFAULT NULL,
  `COMPONENTS` int(11) DEFAULT NULL,
  `COMPONENTS_TIME` float DEFAULT NULL,
  `SQL_LOG` char(1)  DEFAULT NULL,
  `PAGE_TIME` float DEFAULT NULL,
  `PROLOG_TIME` float DEFAULT NULL,
  `PROLOG_BEFORE_TIME` float DEFAULT NULL,
  `AGENTS_TIME` float DEFAULT NULL,
  `PROLOG_AFTER_TIME` float DEFAULT NULL,
  `WORK_AREA_TIME` float DEFAULT NULL,
  `EPILOG_TIME` float DEFAULT NULL,
  `EPILOG_BEFORE_TIME` float DEFAULT NULL,
  `EVENTS_TIME` float DEFAULT NULL,
  `EPILOG_AFTER_TIME` float DEFAULT NULL,
  `MENU_RECALC` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_B_PERF_HIT_0` (`DATE_HIT`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_perf_hit`
-- 


INSERT INTO `b_perf_hit` VALUES (1,'2016-01-04 14:25:37','Y','GET','demo.dev',80,'/bitrix/admin/user_admin.php','/bitrix/admin/user_admin.php?lang=en',154,8296664,'Y',34341,14,0.0293114,0,0,'Y',1.45017,1.4012,1.2953,0.00658989,0.112528,0.0286291,0.01371,0.00269794,0.0001688,0.0108433,0);
INSERT INTO `b_perf_hit` VALUES (2,'2016-01-04 14:25:37','Y','GET','demo.dev',80,'/bitrix/admin/user_options.php','/bitrix/admin/user_options.php?p[0][c]=admin_menu&p[0][n]=pos&p[0][v][sections]=menu_iblock_%2Fnews%2Cmenu_iblock%2Cmenu_perfmon%2Cmenu_fileman%2Ciblock_import%2Cmenu_iblock_%2Fvn%2Cmenu_util%2Cmenu_module_settings%2Cmenu_users&sessid=98c0f30967b28f01a50ea5f482e0549c',90,6123016,'Y',26927,3,0.00124788,0,0,'Y',1.2155,NULL,NULL,0.00641108,NULL,NULL,NULL,NULL,0.000146151,NULL,0);
INSERT INTO `b_perf_hit` VALUES (3,'2016-01-04 14:25:39','Y','GET','demo.dev',80,'/bitrix/admin/task_admin.php','/bitrix/admin/task_admin.php?lang=en',156,8389480,'Y',40788,10,0.00667191,0,0,'Y',1.44835,1.4047,1.30992,0.0051949,0.100016,0.00751209,0.0309079,0.00222898,0.000168085,0.0285108,0);
INSERT INTO `b_perf_hit` VALUES (4,'2016-01-04 14:25:48','Y','GET','demo.dev',80,'/bitrix/admin/user_admin.php','/bitrix/admin/user_admin.php?lang=en',155,8253456,'Y',34341,10,0.00869226,0,0,'Y',1.32273,1.2935,1.18392,0.00585508,0.115477,0.009794,0.0135379,0.00265694,0.0000751019,0.0108058,0);
INSERT INTO `b_perf_hit` VALUES (5,'2016-01-04 14:25:54','Y','GET','demo.dev',80,'/bitrix/admin/user_edit.php','/bitrix/admin/user_edit.php?ID=1&lang=en',157,8750648,'Y',35037,15,0.0110178,0,0,'Y',1.53195,1.3254,1.22356,0.0058651,0.107726,0.159898,0.040766,0.00680995,0.000165939,0.0337901,0);
INSERT INTO `b_perf_hit` VALUES (6,'2016-01-04 14:26:06','Y','GET','demo.dev',80,'/bitrix/admin/iblock_list_admin.php','/bitrix/admin/iblock_list_admin.php?IBLOCK_ID=5&type=vn&lang=en&find_section_section=0',167,10120296,'Y',34341,18,0.0287323,0,0,'Y',1.47969,1.4474,1.36854,0.00665903,0.085485,0.0141339,0.0115409,0.0021801,0.000293016,0.00906777,0);
INSERT INTO `b_perf_hit` VALUES (7,'2016-01-04 14:26:12','Y','GET','demo.dev',80,'/bitrix/admin/user_options.php','/bitrix/admin/user_options.php?p[0][c]=filter&p[0][n]=tbl_iblock_list_feec45850a6da7a26ecbc04356074bda_filter&p[0][v][rows]=IBLIST_A_PARENT&sessid=98c0f30967b28f01a50ea5f482e0549c',90,6122288,'Y',26927,3,0.00143862,0,0,'Y',1.17178,NULL,NULL,0.00768805,NULL,NULL,NULL,NULL,0.0000829697,NULL,0);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_perf_sql`
-- 




DROP TABLE IF EXISTS `b_perf_sql`;
CREATE TABLE `b_perf_sql` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `HIT_ID` int(18) DEFAULT NULL,
  `COMPONENT_ID` int(18) DEFAULT NULL,
  `NN` int(18) DEFAULT NULL,
  `QUERY_TIME` float DEFAULT NULL,
  `MODULE_NAME` text ,
  `COMPONENT_NAME` text ,
  `SQL_TEXT` text ,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_B_PERF_SQL_0` (`HIT_ID`,`NN`),
  KEY `IX_B_PERF_SQL_1` (`COMPONENT_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_perf_sql`
-- 


INSERT INTO `b_perf_sql` VALUES (1,1,NULL,0,0.000739813,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (2,1,NULL,1,0.000562191,'main',NULL,'SELECT ID FROM b_user_option WHERE USER_ID=1	AND CATEGORY=\'admin_menu\' 	AND NAME=\'pos\'');
INSERT INTO `b_perf_sql` VALUES (3,1,NULL,2,0.000725985,'main',NULL,'UPDATE b_user_option SET `COMMON` = \'N\', `VALUE` = \'a:1:{s:8:\\\"sections\\\";s:127:\\\"menu_iblock_/news,menu_iblock,menu_perfmon,menu_fileman,iblock_import,menu_iblock_/vn,menu_util,menu_module_settings,menu_users\\\";}\', `NAME` = \'pos\', `CATEGORY` = \'admin_menu\', `USER_ID` = 1 WHERE ID=3');
INSERT INTO `b_perf_sql` VALUES (4,1,NULL,3,0.000618696,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (5,1,NULL,4,0.021512,'main',NULL,'\n			SELECT\n				UF.ID\n				,UF.ENTITY_ID\n				,UF.FIELD_NAME\n				,UF.USER_TYPE_ID\n				,UF.XML_ID\n				,UF.SORT\n				,UF.MULTIPLE\n				,UF.MANDATORY\n				,UF.SHOW_FILTER\n				,UF.SHOW_IN_LIST\n				,UF.EDIT_IN_LIST\n				,UF.IS_SEARCHABLE\n				,UF.SETTINGS\n				\n					,UFL.EDIT_FORM_LABEL\n					,UFL.LIST_COLUMN_LABEL\n					,UFL.LIST_FILTER_LABEL\n					,UFL.ERROR_MESSAGE\n					,UFL.HELP_MESSAGE\n				\n			FROM\n				b_user_field UF\n				LEFT JOIN b_user_field_lang UFL on UFL.LANGUAGE_ID = \'en\' AND UFL.USER_FIELD_ID = UF.ID\n			\nWHERE UF.ENTITY_ID LIKE \'USER\'\nORDER BY UF.SORT ASC, UF.ID ASC');
INSERT INTO `b_perf_sql` VALUES (6,1,NULL,5,0.000386,'main',NULL,'SELECT COUNT(U.ID) as C \n			FROM\n				b_user U\n				\n				\n			WHERE\n				(1=1)\n			');
INSERT INTO `b_perf_sql` VALUES (7,1,NULL,6,0.000684977,'main',NULL,'SELECT \n			U.*,\n			DATE_FORMAT(U.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') TIMESTAMP_X,\n			DATE_FORMAT(U.DATE_REGISTER, \'%m/%d/%Y %H:%i:%s\') DATE_REGISTER,\n			DATE_FORMAT(U.LAST_LOGIN, \'%m/%d/%Y %H:%i:%s\') LAST_LOGIN,\n			DATE_FORMAT(U.PERSONAL_BIRTHDAY, \'%m/%d/%Y\') PERSONAL_BIRTHDAY\n			\n		\n			FROM\n				b_user U\n				\n				\n			WHERE\n				(1=1)\n			 ORDER BY U.TIMESTAMP_X desc  LIMIT 0, 20');
INSERT INTO `b_perf_sql` VALUES (8,1,NULL,7,0.000418902,'main',NULL,'SELECT L.*, L.LID as ID, L.LID as LANGUAGE_ID FROM b_language L  WHERE  (L.LID=\'en\')  ORDER BY L.SORT ');
INSERT INTO `b_perf_sql` VALUES (9,1,NULL,8,0.000661135,'fileman',NULL,'SELECT * FROM b_medialib_type');
INSERT INTO `b_perf_sql` VALUES (10,1,NULL,9,0.000748157,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (11,1,NULL,10,0.000533581,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (12,1,NULL,11,0.000482082,'main',NULL,'SELECT * FROM b_language WHERE ACTIVE=\'Y\' ORDER BY SORT');
INSERT INTO `b_perf_sql` VALUES (13,1,NULL,12,0.000547886,'main',NULL,'\n			SELECT\n				F.ID, F.C_SORT, F.NAME, F.URL, F.MODIFIED_BY, F.CREATED_BY, F.MODULE_ID, F.LANGUAGE_ID,\n				F.COMMENTS, F.COMMON, F.USER_ID, UM.LOGIN AS M_LOGIN, UC.LOGIN as C_LOGIN, U.LOGIN,\n				DATE_FORMAT(F.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\')	TIMESTAMP_X,\n				DATE_FORMAT(F.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\')	DATE_CREATE,\n				concat(ifnull(UM.NAME, \'\') , \' \' , ifnull(UM.LAST_NAME, \'\')) as M_USER_NAME,\n				concat(ifnull(UC.NAME, \'\') , \' \' , ifnull(UC.LAST_NAME, \'\')) as C_USER_NAME,\n				concat(ifnull(U.NAME, \'\') , \' \' , ifnull(U.LAST_NAME, \'\')) as USER_NAME\n			FROM\n				b_favorite F\n				LEFT JOIN b_user UM ON (UM.ID = F.MODIFIED_BY)\n				LEFT JOIN b_user UC ON (UC.ID = F.CREATED_BY)\n				LEFT JOIN b_user U ON (U.ID = F.USER_ID)\n			WHERE\n			(1=1\n					AND\n					(\n						(F.USER_ID=1 OR F.COMMON=\'Y\')\n					)\n					\n					AND\n					(\n						F.LANGUAGE_ID = \'en\'\n					)\n					)\n			 ORDER BY  F.COMMON ASC, F.C_SORT ASC, F.NAME ASC');
INSERT INTO `b_perf_sql` VALUES (14,1,NULL,13,0.000689983,'main',NULL,'\n			SELECT\n				ID as REFERENCE_ID,\n				concat(NAME, \' [\', ID, \']\') as REFERENCE\n			FROM\n				b_group\n			WHERE\n				1=1\n			AND ID!=2\n			ORDER BY C_SORT, NAME, ID\n			');
INSERT INTO `b_perf_sql` VALUES (15,2,NULL,0,0.000586986,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (16,2,NULL,1,0.000272989,'main',NULL,'SELECT ID FROM b_user_option WHERE USER_ID=1	AND CATEGORY=\'admin_menu\' 	AND NAME=\'pos\'');
INSERT INTO `b_perf_sql` VALUES (17,2,NULL,2,0.000387907,'main',NULL,'UPDATE b_user_option SET `COMMON` = \'N\', `VALUE` = \'a:1:{s:8:\\\"sections\\\";s:127:\\\"menu_iblock_/news,menu_iblock,menu_perfmon,menu_fileman,iblock_import,menu_iblock_/vn,menu_util,menu_module_settings,menu_users\\\";}\', `NAME` = \'pos\', `CATEGORY` = \'admin_menu\', `USER_ID` = 1 WHERE ID=3');
INSERT INTO `b_perf_sql` VALUES (18,3,NULL,0,0.000709772,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (19,3,NULL,1,0.000874996,'main',NULL,'SELECT DISTINCT O.MODULE_ID FROM b_operation O');
INSERT INTO `b_perf_sql` VALUES (20,3,NULL,2,0.000696898,'main',NULL,'\n			SELECT\n				T.ID, T.NAME, T.DESCRIPTION, T.MODULE_ID, T.LETTER, T.SYS, T.BINDING\n			FROM\n				b_task T\n			WHERE\n				(1=1)\n			');
INSERT INTO `b_perf_sql` VALUES (21,3,NULL,3,0.000883818,'main',NULL,'SELECT L.*, L.LID as ID, L.LID as LANGUAGE_ID FROM b_language L  WHERE  (L.LID=\'en\')  ORDER BY L.SORT ');
INSERT INTO `b_perf_sql` VALUES (22,3,NULL,4,0.000407219,'fileman',NULL,'SELECT * FROM b_medialib_type');
INSERT INTO `b_perf_sql` VALUES (23,3,NULL,5,0.000736713,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (24,3,NULL,6,0.000537157,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (25,3,NULL,7,0.000411034,'main',NULL,'SELECT * FROM b_language WHERE ACTIVE=\'Y\' ORDER BY SORT');
INSERT INTO `b_perf_sql` VALUES (26,3,NULL,8,0.000622988,'main',NULL,'\n			SELECT\n				F.ID, F.C_SORT, F.NAME, F.URL, F.MODIFIED_BY, F.CREATED_BY, F.MODULE_ID, F.LANGUAGE_ID,\n				F.COMMENTS, F.COMMON, F.USER_ID, UM.LOGIN AS M_LOGIN, UC.LOGIN as C_LOGIN, U.LOGIN,\n				DATE_FORMAT(F.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\')	TIMESTAMP_X,\n				DATE_FORMAT(F.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\')	DATE_CREATE,\n				concat(ifnull(UM.NAME, \'\') , \' \' , ifnull(UM.LAST_NAME, \'\')) as M_USER_NAME,\n				concat(ifnull(UC.NAME, \'\') , \' \' , ifnull(UC.LAST_NAME, \'\')) as C_USER_NAME,\n				concat(ifnull(U.NAME, \'\') , \' \' , ifnull(U.LAST_NAME, \'\')) as USER_NAME\n			FROM\n				b_favorite F\n				LEFT JOIN b_user UM ON (UM.ID = F.MODIFIED_BY)\n				LEFT JOIN b_user UC ON (UC.ID = F.CREATED_BY)\n				LEFT JOIN b_user U ON (U.ID = F.USER_ID)\n			WHERE\n			(1=1\n					AND\n					(\n						(F.USER_ID=1 OR F.COMMON=\'Y\')\n					)\n					\n					AND\n					(\n						F.LANGUAGE_ID = \'en\'\n					)\n					)\n			 ORDER BY  F.COMMON ASC, F.C_SORT ASC, F.NAME ASC');
INSERT INTO `b_perf_sql` VALUES (27,3,NULL,9,0.000791311,'main',NULL,'SELECT DISTINCT O.BINDING FROM b_operation O');
INSERT INTO `b_perf_sql` VALUES (28,4,NULL,0,0.000586986,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (29,4,NULL,1,0.000352144,'main',NULL,'SELECT COUNT(U.ID) as C \n			FROM\n				b_user U\n				\n				\n			WHERE\n				(1=1)\n			');
INSERT INTO `b_perf_sql` VALUES (30,4,NULL,2,0.00052309,'main',NULL,'SELECT \n			U.*,\n			DATE_FORMAT(U.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') TIMESTAMP_X,\n			DATE_FORMAT(U.DATE_REGISTER, \'%m/%d/%Y %H:%i:%s\') DATE_REGISTER,\n			DATE_FORMAT(U.LAST_LOGIN, \'%m/%d/%Y %H:%i:%s\') LAST_LOGIN,\n			DATE_FORMAT(U.PERSONAL_BIRTHDAY, \'%m/%d/%Y\') PERSONAL_BIRTHDAY\n			\n		\n			FROM\n				b_user U\n				\n				\n			WHERE\n				(1=1)\n			 ORDER BY U.TIMESTAMP_X desc  LIMIT 0, 20');
INSERT INTO `b_perf_sql` VALUES (31,4,NULL,3,0.000598192,'main',NULL,'SELECT L.*, L.LID as ID, L.LID as LANGUAGE_ID FROM b_language L  WHERE  (L.LID=\'en\')  ORDER BY L.SORT ');
INSERT INTO `b_perf_sql` VALUES (32,4,NULL,4,0.000404119,'fileman',NULL,'SELECT * FROM b_medialib_type');
INSERT INTO `b_perf_sql` VALUES (33,4,NULL,5,0.00337076,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (34,4,NULL,6,0.00140595,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (35,4,NULL,7,0.000393629,'main',NULL,'SELECT * FROM b_language WHERE ACTIVE=\'Y\' ORDER BY SORT');
INSERT INTO `b_perf_sql` VALUES (36,4,NULL,8,0.000497103,'main',NULL,'\n			SELECT\n				F.ID, F.C_SORT, F.NAME, F.URL, F.MODIFIED_BY, F.CREATED_BY, F.MODULE_ID, F.LANGUAGE_ID,\n				F.COMMENTS, F.COMMON, F.USER_ID, UM.LOGIN AS M_LOGIN, UC.LOGIN as C_LOGIN, U.LOGIN,\n				DATE_FORMAT(F.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\')	TIMESTAMP_X,\n				DATE_FORMAT(F.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\')	DATE_CREATE,\n				concat(ifnull(UM.NAME, \'\') , \' \' , ifnull(UM.LAST_NAME, \'\')) as M_USER_NAME,\n				concat(ifnull(UC.NAME, \'\') , \' \' , ifnull(UC.LAST_NAME, \'\')) as C_USER_NAME,\n				concat(ifnull(U.NAME, \'\') , \' \' , ifnull(U.LAST_NAME, \'\')) as USER_NAME\n			FROM\n				b_favorite F\n				LEFT JOIN b_user UM ON (UM.ID = F.MODIFIED_BY)\n				LEFT JOIN b_user UC ON (UC.ID = F.CREATED_BY)\n				LEFT JOIN b_user U ON (U.ID = F.USER_ID)\n			WHERE\n			(1=1\n					AND\n					(\n						(F.USER_ID=1 OR F.COMMON=\'Y\')\n					)\n					\n					AND\n					(\n						F.LANGUAGE_ID = \'en\'\n					)\n					)\n			 ORDER BY  F.COMMON ASC, F.C_SORT ASC, F.NAME ASC');
INSERT INTO `b_perf_sql` VALUES (37,4,NULL,9,0.000560284,'main',NULL,'\n			SELECT\n				ID as REFERENCE_ID,\n				concat(NAME, \' [\', ID, \']\') as REFERENCE\n			FROM\n				b_group\n			WHERE\n				1=1\n			AND ID!=2\n			ORDER BY C_SORT, NAME, ID\n			');
INSERT INTO `b_perf_sql` VALUES (38,5,NULL,0,0.00268292,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (39,5,NULL,1,0.000381947,'main',NULL,'SELECT UG.GROUP_ID FROM b_user_group UG WHERE UG.USER_ID = 1 	AND ((UG.DATE_ACTIVE_FROM IS NULL) OR (UG.DATE_ACTIVE_FROM <= now())) 	AND ((UG.DATE_ACTIVE_TO IS NULL) OR (UG.DATE_ACTIVE_TO >= now())) ');
INSERT INTO `b_perf_sql` VALUES (40,5,NULL,2,0.000183821,'main',NULL,'SELECT UG.GROUP_ID FROM b_user_group UG WHERE UG.USER_ID = 1 	AND ((UG.DATE_ACTIVE_FROM IS NULL) OR (UG.DATE_ACTIVE_FROM <= now())) 	AND ((UG.DATE_ACTIVE_TO IS NULL) OR (UG.DATE_ACTIVE_TO >= now())) ');
INSERT INTO `b_perf_sql` VALUES (41,5,NULL,3,0.00117612,'main',NULL,'SELECT \n			U.*,\n			DATE_FORMAT(U.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') TIMESTAMP_X,\n			DATE_FORMAT(U.DATE_REGISTER, \'%m/%d/%Y %H:%i:%s\') DATE_REGISTER,\n			DATE_FORMAT(U.LAST_LOGIN, \'%m/%d/%Y %H:%i:%s\') LAST_LOGIN,\n			DATE_FORMAT(U.PERSONAL_BIRTHDAY, \'%m/%d/%Y\') PERSONAL_BIRTHDAY\n			\n		\n			FROM\n				b_user U\n				\n				\n			WHERE\n				(1=1\n					AND\n					(\n						U.ID=\'1\'\n					)\n					)\n			 ORDER BY U.ID');
INSERT INTO `b_perf_sql` VALUES (42,5,NULL,4,0.001019,'main',NULL,'\n			SELECT\n				UG.GROUP_ID,\n				DATE_FORMAT(UG.DATE_ACTIVE_FROM, \'%m/%d/%Y %H:%i:%s\') as DATE_ACTIVE_FROM,\n				DATE_FORMAT(UG.DATE_ACTIVE_TO, \'%m/%d/%Y %H:%i:%s\') as DATE_ACTIVE_TO\n			FROM\n				b_user_group UG\n			WHERE\n				UG.USER_ID = 1\n			UNION SELECT 2, NULL, NULL\n			FROM b_user_group ');
INSERT INTO `b_perf_sql` VALUES (43,5,NULL,5,0.000437021,'main',NULL,'SELECT L.*, L.LID as ID, L.LID as LANGUAGE_ID FROM b_language L  WHERE  (L.LID=\'en\')  ORDER BY L.SORT ');
INSERT INTO `b_perf_sql` VALUES (44,5,NULL,6,0.000406265,'fileman',NULL,'SELECT * FROM b_medialib_type');
INSERT INTO `b_perf_sql` VALUES (45,5,NULL,7,0.00113583,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (46,5,NULL,8,0.000705242,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (47,5,NULL,9,0.000416994,'main',NULL,'SELECT * FROM b_language WHERE ACTIVE=\'Y\' ORDER BY SORT');
INSERT INTO `b_perf_sql` VALUES (48,5,NULL,10,0.000400066,'main',NULL,'\n			SELECT\n				F.ID, F.C_SORT, F.NAME, F.URL, F.MODIFIED_BY, F.CREATED_BY, F.MODULE_ID, F.LANGUAGE_ID,\n				F.COMMENTS, F.COMMON, F.USER_ID, UM.LOGIN AS M_LOGIN, UC.LOGIN as C_LOGIN, U.LOGIN,\n				DATE_FORMAT(F.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\')	TIMESTAMP_X,\n				DATE_FORMAT(F.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\')	DATE_CREATE,\n				concat(ifnull(UM.NAME, \'\') , \' \' , ifnull(UM.LAST_NAME, \'\')) as M_USER_NAME,\n				concat(ifnull(UC.NAME, \'\') , \' \' , ifnull(UC.LAST_NAME, \'\')) as C_USER_NAME,\n				concat(ifnull(U.NAME, \'\') , \' \' , ifnull(U.LAST_NAME, \'\')) as USER_NAME\n			FROM\n				b_favorite F\n				LEFT JOIN b_user UM ON (UM.ID = F.MODIFIED_BY)\n				LEFT JOIN b_user UC ON (UC.ID = F.CREATED_BY)\n				LEFT JOIN b_user U ON (U.ID = F.USER_ID)\n			WHERE\n			(1=1\n					AND\n					(\n						(F.USER_ID=1 OR F.COMMON=\'Y\')\n					)\n					\n					AND\n					(\n						F.LANGUAGE_ID = \'en\'\n					)\n					)\n			 ORDER BY  F.COMMON ASC, F.C_SORT ASC, F.NAME ASC');
INSERT INTO `b_perf_sql` VALUES (49,5,NULL,11,0.000621796,'main',NULL,'\n			SELECT \n				L.*,\n				L.LID ID,\n				length(L.DIR),\n				ifnull(length(L.DOC_ROOT), 0)\n			FROM\n				b_lang L\n				\n			WHERE\n				 1=1\n\n			 ORDER BY L.SORT ');
INSERT INTO `b_perf_sql` VALUES (50,5,NULL,12,0.000594854,'main',NULL,'\n			SELECT\n				G.ID, G.ACTIVE, G.C_SORT, G.ANONYMOUS, G.NAME, G.DESCRIPTION, G.STRING_ID,\n				\n				G.ID										REFERENCE_ID,\n				concat(G.NAME, \' [\', G.ID, \']\')					REFERENCE,\n				DATE_FORMAT(G.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\')	TIMESTAMP_X\n			FROM\n				b_group G\n			\n			WHERE\n			(1=1\n					AND\n					(\n						G.ANONYMOUS=\'N\'\n					)\n					)\n			GROUP BY\n				G.ID, G.ACTIVE, G.C_SORT, G.TIMESTAMP_X, G.ANONYMOUS, G.NAME, G.STRING_ID, G.DESCRIPTION\n			HAVING\n				1=1\n				\n			 ORDER BY G.C_SORT  asc \n			');
INSERT INTO `b_perf_sql` VALUES (51,5,NULL,13,0.000464201,'main',NULL,'SELECT G.SECURITY_POLICY FROM b_group G WHERE G.ID=2');
INSERT INTO `b_perf_sql` VALUES (52,5,NULL,14,0.000391722,'main',NULL,'SELECT UG.GROUP_ID, G.SECURITY_POLICY FROM b_user_group UG, b_group G WHERE UG.USER_ID = 1 	AND UG.GROUP_ID = G.ID 	AND ((UG.DATE_ACTIVE_FROM IS NULL) OR (UG.DATE_ACTIVE_FROM <= now())) 	AND ((UG.DATE_ACTIVE_TO IS NULL) OR (UG.DATE_ACTIVE_TO >= now())) ');
INSERT INTO `b_perf_sql` VALUES (53,6,NULL,0,0.000833511,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (54,6,NULL,1,0.00054121,'iblock',NULL,'SELECT BP.* FROM b_iblock_property BP, b_iblock B WHERE BP.IBLOCK_ID=B.ID AND BP.ACTIVE=\'Y\'\nAND BP.IBLOCK_ID=5\n ORDER BY BP.SORT ASC,BP.NAME ASC');
INSERT INTO `b_perf_sql` VALUES (55,6,NULL,2,0.000383854,'main',NULL,'\n			SELECT\n				UF.ID\n				,UF.ENTITY_ID\n				,UF.FIELD_NAME\n				,UF.USER_TYPE_ID\n				,UF.XML_ID\n				,UF.SORT\n				,UF.MULTIPLE\n				,UF.MANDATORY\n				,UF.SHOW_FILTER\n				,UF.SHOW_IN_LIST\n				,UF.EDIT_IN_LIST\n				,UF.IS_SEARCHABLE\n				,UF.SETTINGS\n				\n			FROM\n				b_user_field UF\n				\n			\nWHERE UF.ENTITY_ID LIKE \'IBLOCK_5_SECTION\'\nORDER BY UF.SORT ASC, UF.ID ASC');
INSERT INTO `b_perf_sql` VALUES (56,6,NULL,3,0.0186059,'iblock',NULL,'\n				SELECT DISTINCT\n					\n				BS.*,\n				B.LIST_PAGE_URL,\n				B.SECTION_PAGE_URL,\n				B.IBLOCK_TYPE_ID,\n				B.CODE as IBLOCK_CODE,\n				B.XML_ID as IBLOCK_EXTERNAL_ID,\n				BS.XML_ID as EXTERNAL_ID,\n				DATE_FORMAT(BS.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X,\n				DATE_FORMAT(BS.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\') as DATE_CREATE\n			\n					\n				FROM b_iblock_section BS\n					INNER JOIN b_iblock B ON BS.IBLOCK_ID = B.ID\n					LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID\n					\n				\n				WHERE 1=1\n				\n				\n				AND  ((((BS.IBLOCK_ID = \'5\')))) \n				AND  ((((BS.IBLOCK_SECTION_ID IS NULL)))) \n				AND  ((((B.ID = \'5\')))) \n				ORDER BY  BS.TIMESTAMP_X desc ');
INSERT INTO `b_perf_sql` VALUES (57,6,NULL,4,0.000644922,'iblock',NULL,'SELECT  BE.NAME as NAME,BE.ACTIVE as ACTIVE,BE.SORT as SORT,DATE_FORMAT(BE.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X,BE.ID as ID,BE.CREATED_BY as CREATED_BY,L.DIR as LANG_DIR,B.LID as LID,BE.WF_PARENT_ELEMENT_ID as WF_PARENT_ELEMENT_ID,if (BE.WF_DATE_LOCK is null, \'green\', if(DATE_ADD(BE.WF_DATE_LOCK, interval 60 MINUTE)<now(), \'green\', if(BE.WF_LOCKED_BY=1, \'yellow\', \'red\'))) as LOCK_STATUS,BE.WF_NEW as WF_NEW,BE.WF_STATUS_ID as WF_STATUS_ID,B.DETAIL_PAGE_URL as DETAIL_PAGE_URL,BE.CODE as CODE,BE.XML_ID as EXTERNAL_ID,BE.IBLOCK_SECTION_ID as IBLOCK_SECTION_ID,B.IBLOCK_TYPE_ID as IBLOCK_TYPE_ID,BE.IBLOCK_ID as IBLOCK_ID,B.CODE as IBLOCK_CODE,B.XML_ID as IBLOCK_EXTERNAL_ID \n			FROM b_iblock B\n			INNER JOIN b_lang L ON B.LID=L.LID\n			INNER JOIN b_iblock_element BE ON BE.IBLOCK_ID = B.ID\n			\n			WHERE 1=1 \n			AND (\n			\n				((((BE.IBLOCK_ID = \'5\'))))\n				AND (BE.IN_SECTIONS=\'N\')\n			)\n			AND (((BE.WF_STATUS_ID=1 AND BE.WF_PARENT_ELEMENT_ID IS NULL) OR (BE.WF_NEW=\'Y\')))\n			\n		 ORDER BY BE.TIMESTAMP_X desc ');
INSERT INTO `b_perf_sql` VALUES (58,6,NULL,5,0.000552177,'iblock',NULL,'\n				SELECT DISTINCT\n					\n				BS.*,\n				B.LIST_PAGE_URL,\n				B.SECTION_PAGE_URL,\n				B.IBLOCK_TYPE_ID,\n				B.CODE as IBLOCK_CODE,\n				B.XML_ID as IBLOCK_EXTERNAL_ID,\n				BS.XML_ID as EXTERNAL_ID,\n				DATE_FORMAT(BS.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X,\n				DATE_FORMAT(BS.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\') as DATE_CREATE\n			\n					\n				FROM b_iblock_section BS\n					INNER JOIN b_iblock B ON BS.IBLOCK_ID = B.ID\n					LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID\n					\n				\n				WHERE 1=1\n				\n				\n				AND  ((((BS.IBLOCK_ID = \'5\')))) \n				AND  ((((B.ID = \'5\')))) \n				ORDER BY  BS.LEFT_MARGIN asc ');
INSERT INTO `b_perf_sql` VALUES (59,6,NULL,6,0.000468016,'main',NULL,'SELECT L.*, L.LID as ID, L.LID as LANGUAGE_ID FROM b_language L  WHERE  (L.LID=\'en\')  ORDER BY L.SORT ');
INSERT INTO `b_perf_sql` VALUES (60,6,NULL,7,0.000450134,'fileman',NULL,'SELECT * FROM b_medialib_type');
INSERT INTO `b_perf_sql` VALUES (61,6,NULL,8,0.000766754,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (62,6,NULL,9,0.000555038,'iblock',NULL,'SELECT DISTINCT B.*, B.XML_ID as EXTERNAL_ID, DATE_FORMAT(B.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X, L.DIR as LANG_DIR, L.SERVER_NAME FROM b_iblock B  INNER JOIN b_lang L ON L.LID=B.LID 	LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID WHERE 1 = 1  ORDER BY  B.SORT asc , B.NAME asc ');
INSERT INTO `b_perf_sql` VALUES (63,6,NULL,10,0.000610113,'iblock',NULL,'\n				SELECT DISTINCT\n					\n				BS.*,\n				B.LIST_PAGE_URL,\n				B.SECTION_PAGE_URL,\n				B.IBLOCK_TYPE_ID,\n				B.CODE as IBLOCK_CODE,\n				B.XML_ID as IBLOCK_EXTERNAL_ID,\n				BS.XML_ID as EXTERNAL_ID,\n				DATE_FORMAT(BS.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X,\n				DATE_FORMAT(BS.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\') as DATE_CREATE\n			\n					\n				FROM b_iblock_section BS\n					INNER JOIN b_iblock B ON BS.IBLOCK_ID = B.ID\n					LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID\n					\n				\n				WHERE 1=1\n				\n				\n				AND  ((((BS.IBLOCK_ID = \'5\')))) \n				AND  ((((BS.IBLOCK_SECTION_ID IS NULL)))) \n				AND  ((((B.ID = \'5\')))) \n				ORDER BY  BS.LEFT_MARGIN asc ');
INSERT INTO `b_perf_sql` VALUES (64,6,NULL,11,0.000491858,'main',NULL,'SELECT * FROM b_language WHERE ACTIVE=\'Y\' ORDER BY SORT');
INSERT INTO `b_perf_sql` VALUES (65,6,NULL,12,0.000650883,'main',NULL,'\n			SELECT\n				F.ID, F.C_SORT, F.NAME, F.URL, F.MODIFIED_BY, F.CREATED_BY, F.MODULE_ID, F.LANGUAGE_ID,\n				F.COMMENTS, F.COMMON, F.USER_ID, UM.LOGIN AS M_LOGIN, UC.LOGIN as C_LOGIN, U.LOGIN,\n				DATE_FORMAT(F.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\')	TIMESTAMP_X,\n				DATE_FORMAT(F.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\')	DATE_CREATE,\n				concat(ifnull(UM.NAME, \'\') , \' \' , ifnull(UM.LAST_NAME, \'\')) as M_USER_NAME,\n				concat(ifnull(UC.NAME, \'\') , \' \' , ifnull(UC.LAST_NAME, \'\')) as C_USER_NAME,\n				concat(ifnull(U.NAME, \'\') , \' \' , ifnull(U.LAST_NAME, \'\')) as USER_NAME\n			FROM\n				b_favorite F\n				LEFT JOIN b_user UM ON (UM.ID = F.MODIFIED_BY)\n				LEFT JOIN b_user UC ON (UC.ID = F.CREATED_BY)\n				LEFT JOIN b_user U ON (U.ID = F.USER_ID)\n			WHERE\n			(1=1\n					AND\n					(\n						(F.USER_ID=1 OR F.COMMON=\'Y\')\n					)\n					\n					AND\n					(\n						F.LANGUAGE_ID = \'en\'\n					)\n					)\n			 ORDER BY  F.COMMON ASC, F.C_SORT ASC, F.NAME ASC');
INSERT INTO `b_perf_sql` VALUES (66,6,NULL,13,0.00100803,'iblock',NULL,'\n				SELECT DISTINCT\n					\n				BS.*,\n				B.LIST_PAGE_URL,\n				B.SECTION_PAGE_URL,\n				B.IBLOCK_TYPE_ID,\n				B.CODE as IBLOCK_CODE,\n				B.XML_ID as IBLOCK_EXTERNAL_ID,\n				BS.XML_ID as EXTERNAL_ID,\n				DATE_FORMAT(BS.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') as TIMESTAMP_X,\n				DATE_FORMAT(BS.DATE_CREATE, \'%m/%d/%Y %H:%i:%s\') as DATE_CREATE\n			\n					\n				FROM b_iblock_section BS\n					INNER JOIN b_iblock B ON BS.IBLOCK_ID = B.ID\n					LEFT JOIN b_iblock_group IBG ON IBG.IBLOCK_ID=B.ID\n					\n				\n				WHERE 1=1\n				\n				\n				AND  ((((BS.IBLOCK_ID = \'5\')))) \n				AND  ((((B.ID = \'5\')))) \n				ORDER BY  BS.LEFT_MARGIN asc ');
INSERT INTO `b_perf_sql` VALUES (67,6,NULL,14,0.000452995,'iblock',NULL,'SELECT * FROM b_iblock_group WHERE IBLOCK_ID = \'5\'');
INSERT INTO `b_perf_sql` VALUES (68,6,NULL,15,0.000793934,'main',NULL,'SELECT \n			U.*,\n			DATE_FORMAT(U.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') TIMESTAMP_X,\n			DATE_FORMAT(U.DATE_REGISTER, \'%m/%d/%Y %H:%i:%s\') DATE_REGISTER,\n			DATE_FORMAT(U.LAST_LOGIN, \'%m/%d/%Y %H:%i:%s\') LAST_LOGIN,\n			DATE_FORMAT(U.PERSONAL_BIRTHDAY, \'%m/%d/%Y\') PERSONAL_BIRTHDAY\n			\n		\n			FROM\n				b_user U\n				\n				 INNER JOIN (SELECT DISTINCT UG.USER_ID FROM b_user_group UG\n							WHERE UG.GROUP_ID in (1)\n								and (UG.DATE_ACTIVE_FROM is null or	UG.DATE_ACTIVE_FROM <= now())\n								and (UG.DATE_ACTIVE_TO is null or UG.DATE_ACTIVE_TO >= now())\n							) UG ON UG.USER_ID=U.ID \n			WHERE\n				(1=1)\n			 ORDER BY U.NAME desc ');
INSERT INTO `b_perf_sql` VALUES (69,6,NULL,16,0.000268936,'iblock',NULL,'SELECT * FROM b_iblock_group WHERE IBLOCK_ID = \'5\'');
INSERT INTO `b_perf_sql` VALUES (70,6,NULL,17,0.000653982,'main',NULL,'SELECT \n			U.*,\n			DATE_FORMAT(U.TIMESTAMP_X, \'%m/%d/%Y %H:%i:%s\') TIMESTAMP_X,\n			DATE_FORMAT(U.DATE_REGISTER, \'%m/%d/%Y %H:%i:%s\') DATE_REGISTER,\n			DATE_FORMAT(U.LAST_LOGIN, \'%m/%d/%Y %H:%i:%s\') LAST_LOGIN,\n			DATE_FORMAT(U.PERSONAL_BIRTHDAY, \'%m/%d/%Y\') PERSONAL_BIRTHDAY\n			\n		\n			FROM\n				b_user U\n				\n				 INNER JOIN (SELECT DISTINCT UG.USER_ID FROM b_user_group UG\n							WHERE UG.GROUP_ID in (1)\n								and (UG.DATE_ACTIVE_FROM is null or	UG.DATE_ACTIVE_FROM <= now())\n								and (UG.DATE_ACTIVE_TO is null or UG.DATE_ACTIVE_TO >= now())\n							) UG ON UG.USER_ID=U.ID \n			WHERE\n				(1=1)\n			 ORDER BY U.NAME desc ');
INSERT INTO `b_perf_sql` VALUES (71,7,NULL,0,0.000611782,'main',NULL,'SELECT CATEGORY, NAME, VALUE, COMMON FROM b_user_option WHERE (USER_ID=1 OR USER_ID IS NULL AND COMMON=\'Y\') ');
INSERT INTO `b_perf_sql` VALUES (72,7,NULL,1,0.000360966,'main',NULL,'SELECT ID FROM b_user_option WHERE USER_ID=1	AND CATEGORY=\'filter\' 	AND NAME=\'tbl_iblock_list_feec45850a6da7a26ecbc04356074bda_filter\'');
INSERT INTO `b_perf_sql` VALUES (73,7,NULL,2,0.00046587,'main',NULL,'UPDATE b_user_option SET `COMMON` = \'N\', `VALUE` = \'a:1:{s:4:\\\"rows\\\";s:15:\\\"IBLIST_A_PARENT\\\";}\', `NAME` = \'tbl_iblock_list_feec45850a6da7a26ecbc04356074bda_filter\', `CATEGORY` = \'filter\', `USER_ID` = 1 WHERE ID=6');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_perf_test`
-- 




DROP TABLE IF EXISTS `b_perf_test`;
CREATE TABLE `b_perf_test` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `REFERENCE_ID` int(18) DEFAULT NULL,
  `NAME` varchar(200)  DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_B_PERF_TEST_0` (`REFERENCE_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_perf_test`
-- 


INSERT INTO `b_perf_test` VALUES (1,2,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (2,3,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (3,4,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (4,5,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (5,6,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (6,7,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (7,8,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (8,9,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (9,10,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (10,11,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (11,12,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (12,13,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (13,14,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (14,15,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (15,16,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (16,17,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (17,18,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (18,19,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (19,20,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (20,21,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (21,22,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (22,23,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (23,24,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (24,25,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (25,26,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (26,27,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (27,28,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (28,29,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (29,30,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (30,31,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (31,32,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (32,33,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (33,34,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (34,35,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (35,36,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (36,37,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (37,38,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (38,39,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (39,40,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (40,41,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (41,42,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (42,43,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (43,44,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (44,45,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (45,46,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (46,47,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (47,48,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (48,49,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (49,50,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (50,51,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (51,52,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (52,53,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (53,54,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (54,55,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (55,56,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (56,57,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (57,58,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (58,59,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (59,60,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (60,61,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (61,62,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (62,63,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (63,64,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (64,65,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (65,66,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (66,67,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (67,68,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (68,69,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (69,70,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (70,71,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (71,72,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (72,73,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (73,74,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (74,75,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (75,76,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (76,77,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (77,78,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (78,79,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (79,80,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (80,81,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (81,82,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (82,83,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (83,84,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (84,85,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (85,86,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (86,87,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (87,88,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (88,89,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (89,90,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (90,91,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (91,92,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (92,93,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (93,94,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (94,95,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (95,96,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (96,97,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (97,98,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (98,99,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (99,100,'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
INSERT INTO `b_perf_test` VALUES (100,98,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (101,-1,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (102,0,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (103,1,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (104,2,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (105,3,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (106,4,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (107,5,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (108,6,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (109,7,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (110,8,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (111,9,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (112,10,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (113,11,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (114,12,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (115,13,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (116,14,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (117,15,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (118,16,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (119,17,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (120,18,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (121,19,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (122,20,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (123,21,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (124,22,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (125,23,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (126,24,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (127,25,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (128,26,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (129,27,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (130,28,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (131,29,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (132,30,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (133,31,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (134,32,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (135,33,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (136,34,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (137,35,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (138,36,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (139,37,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (140,38,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (141,39,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (142,40,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (143,41,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (144,42,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (145,43,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (146,44,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (147,45,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (148,46,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (149,47,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (150,48,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (151,49,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (152,50,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (153,51,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (154,52,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (155,53,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (156,54,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (157,55,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (158,56,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (159,57,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (160,58,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (161,59,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (162,60,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (163,61,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (164,62,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (165,63,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (166,64,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (167,65,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (168,66,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (169,67,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (170,68,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (171,69,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (172,70,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (173,71,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (174,72,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (175,73,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (176,74,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (177,75,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (178,76,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (179,77,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (180,78,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (181,79,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (182,80,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (183,81,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (184,82,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (185,83,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (186,84,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (187,85,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (188,86,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (189,87,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (190,88,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (191,89,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (192,90,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (193,91,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (194,92,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (195,93,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (196,94,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (197,95,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (198,96,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (199,97,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (200,98,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (201,-1,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (202,0,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (203,1,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (204,2,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (205,3,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (206,4,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (207,5,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (208,6,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (209,7,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (210,8,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (211,9,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (212,10,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (213,11,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (214,12,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (215,13,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (216,14,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (217,15,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (218,16,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (219,17,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (220,18,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (221,19,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (222,20,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (223,21,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (224,22,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (225,23,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (226,24,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (227,25,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (228,26,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (229,27,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (230,28,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (231,29,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (232,30,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (233,31,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (234,32,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (235,33,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (236,34,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (237,35,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (238,36,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (239,37,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (240,38,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (241,39,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (242,40,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (243,41,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (244,42,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (245,43,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (246,44,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (247,45,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (248,46,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (249,47,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (250,48,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (251,49,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (252,50,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (253,51,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (254,52,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (255,53,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (256,54,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (257,55,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (258,56,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (259,57,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (260,58,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (261,59,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (262,60,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (263,61,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (264,62,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (265,63,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (266,64,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (267,65,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (268,66,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (269,67,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (270,68,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (271,69,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (272,70,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (273,71,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (274,72,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (275,73,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (276,74,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (277,75,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (278,76,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (279,77,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (280,78,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (281,79,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (282,80,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (283,81,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (284,82,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (285,83,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (286,84,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (287,85,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (288,86,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (289,87,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (290,88,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (291,89,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (292,90,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (293,91,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (294,92,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (295,93,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (296,94,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (297,95,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (298,96,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (299,97,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (300,98,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (301,-1,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (302,0,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (303,1,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (304,2,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (305,3,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (306,4,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (307,5,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (308,6,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (309,7,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (310,8,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (311,9,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (312,10,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (313,11,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (314,12,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (315,13,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (316,14,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (317,15,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (318,16,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (319,17,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (320,18,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (321,19,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (322,20,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (323,21,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (324,22,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (325,23,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (326,24,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (327,25,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (328,26,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (329,27,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (330,28,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (331,29,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (332,30,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (333,31,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (334,32,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (335,33,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (336,34,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (337,35,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (338,36,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (339,37,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (340,38,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (341,39,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (342,40,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (343,41,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (344,42,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (345,43,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (346,44,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (347,45,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (348,46,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (349,47,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (350,48,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (351,49,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (352,50,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (353,51,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (354,52,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (355,53,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (356,54,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (357,55,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (358,56,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (359,57,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (360,58,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (361,59,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (362,60,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (363,61,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (364,62,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (365,63,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (366,64,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (367,65,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (368,66,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (369,67,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (370,68,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (371,69,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (372,70,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (373,71,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (374,72,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (375,73,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (376,74,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (377,75,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (378,76,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (379,77,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (380,78,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (381,79,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (382,80,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (383,81,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (384,82,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (385,83,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (386,84,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (387,85,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (388,86,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (389,87,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (390,88,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (391,89,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (392,90,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (393,91,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (394,92,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (395,93,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (396,94,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (397,95,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (398,96,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (399,97,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `b_perf_test` VALUES (400,98,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_rating`
-- 




DROP TABLE IF EXISTS `b_rating`;
CREATE TABLE `b_rating` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACTIVE` char(1)  NOT NULL,
  `NAME` varchar(512)  NOT NULL,
  `ENTITY_ID` varchar(50)  NOT NULL,
  `CALCULATION_METHOD` varchar(3)  NOT NULL DEFAULT 'SUM',
  `CREATED` datetime DEFAULT NULL,
  `LAST_MODIFIED` datetime DEFAULT NULL,
  `LAST_CALCULATED` datetime DEFAULT NULL,
  `CALCULATED` char(1)  NOT NULL DEFAULT 'N',
  `CONFIGS` text ,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_rating_component`
-- 




DROP TABLE IF EXISTS `b_rating_component`;
CREATE TABLE `b_rating_component` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_ID` int(11) NOT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'N',
  `ENTITY_ID` varchar(50)  NOT NULL,
  `MODULE_ID` varchar(50)  NOT NULL,
  `RATING_TYPE` varchar(50)  NOT NULL,
  `NAME` varchar(50)  NOT NULL,
  `COMPLEX_NAME` varchar(200)  NOT NULL,
  `CLASS` varchar(255)  NOT NULL,
  `CALC_METHOD` varchar(255)  NOT NULL,
  `EXCEPTION_METHOD` varchar(255)  DEFAULT NULL,
  `LAST_MODIFIED` datetime DEFAULT NULL,
  `LAST_CALCULATED` datetime DEFAULT NULL,
  `NEXT_CALCULATION` datetime DEFAULT NULL,
  `REFRESH_INTERVAL` int(11) NOT NULL,
  `CONFIG` text ,
  PRIMARY KEY (`ID`),
  KEY `IX_RATING_ID_1` (`RATING_ID`,`ACTIVE`,`NEXT_CALCULATION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_rating_component_results`
-- 




DROP TABLE IF EXISTS `b_rating_component_results`;
CREATE TABLE `b_rating_component_results` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_ID` int(11) NOT NULL,
  `ENTITY_TYPE_ID` varchar(50)  NOT NULL,
  `ENTITY_ID` varchar(50)  NOT NULL,
  `MODULE_ID` varchar(50)  NOT NULL,
  `RATING_TYPE` varchar(50)  NOT NULL,
  `NAME` varchar(50)  NOT NULL,
  `COMPLEX_NAME` varchar(200)  NOT NULL,
  `CURRENT_VALUE` decimal(18,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_ENTITY_TYPE_ID` (`ENTITY_TYPE_ID`),
  KEY `IX_COMPLEX_NAME` (`COMPLEX_NAME`),
  KEY `IX_RATING_ID_2` (`RATING_ID`,`COMPLEX_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_rating_results`
-- 




DROP TABLE IF EXISTS `b_rating_results`;
CREATE TABLE `b_rating_results` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_ID` int(11) NOT NULL,
  `ENTITY_TYPE_ID` varchar(50)  NOT NULL,
  `ENTITY_ID` varchar(50)  NOT NULL,
  `CURRENT_VALUE` decimal(18,2) NOT NULL,
  `PREVIOUS_VALUE` decimal(18,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_RATING_3` (`RATING_ID`,`ENTITY_TYPE_ID`,`ENTITY_ID`),
  KEY `IX_RATING_4` (`RATING_ID`,`ENTITY_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_rating_vote`
-- 




DROP TABLE IF EXISTS `b_rating_vote`;
CREATE TABLE `b_rating_vote` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_VOTING_ID` int(11) NOT NULL,
  `VALUE` decimal(18,2) NOT NULL,
  `ACTIVE` char(1)  NOT NULL,
  `CREATED` datetime NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `USER_IP` varchar(64)  NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_RAT_VOTING_ID` (`RATING_VOTING_ID`,`USER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_rating_voting`
-- 




DROP TABLE IF EXISTS `b_rating_voting`;
CREATE TABLE `b_rating_voting` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ENTITY_TYPE_ID` varchar(50)  NOT NULL,
  `ENTITY_ID` varchar(50)  NOT NULL,
  `ACTIVE` char(1)  NOT NULL,
  `CREATED` datetime DEFAULT NULL,
  `LAST_CALCULATED` datetime DEFAULT NULL,
  `TOTAL_VALUE` decimal(18,2) NOT NULL,
  `TOTAL_VOTES` int(11) NOT NULL,
  `TOTAL_POSITIVE_VOTES` int(11) NOT NULL,
  `TOTAL_NEGATIVE_VOTES` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_ENTITY_TYPE_ID_2` (`ENTITY_TYPE_ID`,`ENTITY_ID`,`ACTIVE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_content`
-- 




DROP TABLE IF EXISTS `b_search_content`;
CREATE TABLE `b_search_content` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_CHANGE` datetime NOT NULL,
  `MODULE_ID` varchar(50)  NOT NULL,
  `ITEM_ID` varchar(255)  NOT NULL,
  `LID` char(2)  NOT NULL,
  `CUSTOM_RANK` int(11) NOT NULL DEFAULT '0',
  `URL` text ,
  `TITLE` text ,
  `BODY` text ,
  `TAGS` text ,
  `SEARCHABLE_CONTENT` longtext ,
  `PARAM1` text ,
  `PARAM2` text ,
  `UPD` varchar(32)  DEFAULT NULL,
  `DATE_FROM` datetime DEFAULT NULL,
  `DATE_TO` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_B_SEARCH_CONTENT` (`MODULE_ID`,`ITEM_ID`),
  KEY `IX_B_SEARCH_CONTENT_1` (`MODULE_ID`,`PARAM1`(50),`PARAM2`(50))
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_content_freq`
-- 




DROP TABLE IF EXISTS `b_search_content_freq`;
CREATE TABLE `b_search_content_freq` (
  `STEM` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `LANGUAGE_ID` char(2)  NOT NULL,
  `SITE_ID` char(2)  DEFAULT NULL,
  `FREQ` float NOT NULL,
  `TF` float DEFAULT NULL,
  UNIQUE KEY `UX_B_SEARCH_CONTENT_FREQ` (`STEM`,`LANGUAGE_ID`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_content_group`
-- 




DROP TABLE IF EXISTS `b_search_content_group`;
CREATE TABLE `b_search_content_group` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  UNIQUE KEY `UX_B_SEARCH_CONTENT_GROUP` (`SEARCH_CONTENT_ID`,`GROUP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_content_site`
-- 




DROP TABLE IF EXISTS `b_search_content_site`;
CREATE TABLE `b_search_content_site` (
  `SEARCH_CONTENT_ID` int(18) NOT NULL,
  `SITE_ID` char(2)  NOT NULL,
  `URL` text ,
  PRIMARY KEY (`SEARCH_CONTENT_ID`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_content_stem`
-- 




DROP TABLE IF EXISTS `b_search_content_stem`;
CREATE TABLE `b_search_content_stem` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `LANGUAGE_ID` char(2)  NOT NULL,
  `STEM` varchar(50) CHARACTER SET utf8 NOT NULL,
  `TF` float NOT NULL,
  UNIQUE KEY `UX_B_SEARCH_CONTENT_STEM` (`STEM`,`LANGUAGE_ID`,`TF`,`SEARCH_CONTENT_ID`),
  KEY `IND_B_SEARCH_CONTENT_STEM` (`SEARCH_CONTENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci DELAY_KEY_WRITE=1;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_custom_rank`
-- 




DROP TABLE IF EXISTS `b_search_custom_rank`;
CREATE TABLE `b_search_custom_rank` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2)  NOT NULL,
  `MODULE_ID` varchar(200)  NOT NULL,
  `PARAM1` text ,
  `PARAM2` text ,
  `ITEM_ID` varchar(255)  DEFAULT NULL,
  `RANK` int(11) NOT NULL DEFAULT '0',
  `APPLIED` char(1)  NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `IND_B_SEARCH_CUSTOM_RANK` (`SITE_ID`,`MODULE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_phrase`
-- 




DROP TABLE IF EXISTS `b_search_phrase`;
CREATE TABLE `b_search_phrase` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` datetime NOT NULL,
  `SITE_ID` char(2)  NOT NULL,
  `RESULT_COUNT` int(11) NOT NULL,
  `PAGES` int(11) NOT NULL,
  `SESSION_ID` varchar(32)  NOT NULL,
  `PHRASE` varchar(250)  DEFAULT NULL,
  `TAGS` varchar(250)  DEFAULT NULL,
  `URL_TO` text ,
  `URL_TO_404` char(1)  DEFAULT NULL,
  `URL_TO_SITE_ID` char(2)  DEFAULT NULL,
  `STAT_SESS_ID` int(18) DEFAULT NULL,
  `EVENT1` varchar(50)  DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IND_PK_B_SEARCH_PHRASE_SESS_PH` (`SESSION_ID`,`PHRASE`(50)),
  KEY `IND_PK_B_SEARCH_PHRASE_SESS_TG` (`SESSION_ID`,`TAGS`(50)),
  KEY `IND_PK_B_SEARCH_PHRASE_TIME` (`TIMESTAMP_X`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_suggest`
-- 




DROP TABLE IF EXISTS `b_search_suggest`;
CREATE TABLE `b_search_suggest` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2)  NOT NULL,
  `FILTER_MD5` varchar(32)  NOT NULL,
  `PHRASE` varchar(250)  NOT NULL,
  `RATE` float NOT NULL,
  `TIMESTAMP_X` datetime NOT NULL,
  `RESULT_COUNT` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IND_B_SEARCH_SUGGEST` (`FILTER_MD5`,`PHRASE`(50),`RATE`),
  KEY `IND_B_SEARCH_SUGGEST_PHRASE` (`PHRASE`(50),`RATE`),
  KEY `IND_B_SEARCH_SUGGEST_TIME` (`TIMESTAMP_X`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_search_tags`
-- 




DROP TABLE IF EXISTS `b_search_tags`;
CREATE TABLE `b_search_tags` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `SITE_ID` char(2)  NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`SEARCH_CONTENT_ID`,`SITE_ID`,`NAME`),
  KEY `IX_B_SEARCH_TAGS_0` (`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci DELAY_KEY_WRITE=1;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_seo_keywords`
-- 




DROP TABLE IF EXISTS `b_seo_keywords`;
CREATE TABLE `b_seo_keywords` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2)  NOT NULL,
  `URL` varchar(255)  DEFAULT NULL,
  `KEYWORDS` text ,
  PRIMARY KEY (`ID`),
  KEY `ix_b_seo_keywords_url` (`URL`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_site_template`
-- 




DROP TABLE IF EXISTS `b_site_template`;
CREATE TABLE `b_site_template` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2)  NOT NULL,
  `CONDITION` varchar(255)  DEFAULT NULL,
  `SORT` int(11) NOT NULL DEFAULT '500',
  `TEMPLATE` varchar(50)  NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_B_SITE_TEMPLATE` (`SITE_ID`,`CONDITION`,`TEMPLATE`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_site_template`
-- 


INSERT INTO `b_site_template` VALUES (5,'s1','',150,'furniture_dark-blue');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_task`
-- 




DROP TABLE IF EXISTS `b_task`;
CREATE TABLE `b_task` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100)  NOT NULL,
  `LETTER` char(1)  DEFAULT NULL,
  `MODULE_ID` varchar(50)  NOT NULL,
  `SYS` char(1)  NOT NULL,
  `DESCRIPTION` varchar(255)  DEFAULT NULL,
  `BINDING` varchar(50)  DEFAULT 'module',
  PRIMARY KEY (`ID`),
  KEY `ix_task` (`MODULE_ID`,`BINDING`,`LETTER`,`SYS`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_task`
-- 


INSERT INTO `b_task` VALUES (1,'main_denied','D','main','Y',NULL,'module');
INSERT INTO `b_task` VALUES (2,'main_change_profile','P','main','Y',NULL,'module');
INSERT INTO `b_task` VALUES (3,'main_view_all_settings','R','main','Y',NULL,'module');
INSERT INTO `b_task` VALUES (4,'main_view_all_settings_change_profile','T','main','Y',NULL,'module');
INSERT INTO `b_task` VALUES (5,'main_edit_subordinate_users','V','main','Y',NULL,'module');
INSERT INTO `b_task` VALUES (6,'main_full_access','W','main','Y',NULL,'module');
INSERT INTO `b_task` VALUES (7,'fm_folder_access_denied','D','main','Y',NULL,'file');
INSERT INTO `b_task` VALUES (8,'fm_folder_access_read','R','main','Y',NULL,'file');
INSERT INTO `b_task` VALUES (9,'fm_folder_access_write','W','main','Y',NULL,'file');
INSERT INTO `b_task` VALUES (10,'fm_folder_access_full','X','main','Y',NULL,'file');
INSERT INTO `b_task` VALUES (11,'fm_folder_access_workflow','U','main','Y',NULL,'file');
INSERT INTO `b_task` VALUES (12,'fileman_denied','D','fileman','Y','','module');
INSERT INTO `b_task` VALUES (13,'fileman_allowed_folders','F','fileman','Y','','module');
INSERT INTO `b_task` VALUES (14,'fileman_full_access','W','fileman','Y','','module');
INSERT INTO `b_task` VALUES (15,'medialib_denied','D','fileman','Y','','medialib');
INSERT INTO `b_task` VALUES (16,'medialib_view','F','fileman','Y','','medialib');
INSERT INTO `b_task` VALUES (17,'medialib_only_new','R','fileman','Y','','medialib');
INSERT INTO `b_task` VALUES (18,'medialib_edit_items','V','fileman','Y','','medialib');
INSERT INTO `b_task` VALUES (19,'medialib_editor','W','fileman','Y','','medialib');
INSERT INTO `b_task` VALUES (20,'medialib_full','X','fileman','Y','','medialib');
INSERT INTO `b_task` VALUES (21,'seo_denied','D','seo','Y','','module');
INSERT INTO `b_task` VALUES (22,'seo_edit','F','seo','Y','','module');
INSERT INTO `b_task` VALUES (23,'seo_full_access','W','seo','Y','','module');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_task_operation`
-- 




DROP TABLE IF EXISTS `b_task_operation`;
CREATE TABLE `b_task_operation` (
  `TASK_ID` int(18) NOT NULL,
  `OPERATION_ID` int(18) NOT NULL,
  PRIMARY KEY (`TASK_ID`,`OPERATION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_task_operation`
-- 


INSERT INTO `b_task_operation` VALUES (2,1);
INSERT INTO `b_task_operation` VALUES (2,7);
INSERT INTO `b_task_operation` VALUES (3,1);
INSERT INTO `b_task_operation` VALUES (3,3);
INSERT INTO `b_task_operation` VALUES (3,4);
INSERT INTO `b_task_operation` VALUES (3,5);
INSERT INTO `b_task_operation` VALUES (3,6);
INSERT INTO `b_task_operation` VALUES (4,1);
INSERT INTO `b_task_operation` VALUES (4,3);
INSERT INTO `b_task_operation` VALUES (4,4);
INSERT INTO `b_task_operation` VALUES (4,5);
INSERT INTO `b_task_operation` VALUES (4,6);
INSERT INTO `b_task_operation` VALUES (4,7);
INSERT INTO `b_task_operation` VALUES (5,1);
INSERT INTO `b_task_operation` VALUES (5,2);
INSERT INTO `b_task_operation` VALUES (5,4);
INSERT INTO `b_task_operation` VALUES (5,5);
INSERT INTO `b_task_operation` VALUES (5,6);
INSERT INTO `b_task_operation` VALUES (5,7);
INSERT INTO `b_task_operation` VALUES (5,9);
INSERT INTO `b_task_operation` VALUES (6,1);
INSERT INTO `b_task_operation` VALUES (6,3);
INSERT INTO `b_task_operation` VALUES (6,4);
INSERT INTO `b_task_operation` VALUES (6,5);
INSERT INTO `b_task_operation` VALUES (6,6);
INSERT INTO `b_task_operation` VALUES (6,7);
INSERT INTO `b_task_operation` VALUES (6,8);
INSERT INTO `b_task_operation` VALUES (6,10);
INSERT INTO `b_task_operation` VALUES (6,11);
INSERT INTO `b_task_operation` VALUES (6,12);
INSERT INTO `b_task_operation` VALUES (6,13);
INSERT INTO `b_task_operation` VALUES (6,32);
INSERT INTO `b_task_operation` VALUES (6,33);
INSERT INTO `b_task_operation` VALUES (8,15);
INSERT INTO `b_task_operation` VALUES (8,23);
INSERT INTO `b_task_operation` VALUES (8,24);
INSERT INTO `b_task_operation` VALUES (9,15);
INSERT INTO `b_task_operation` VALUES (9,17);
INSERT INTO `b_task_operation` VALUES (9,18);
INSERT INTO `b_task_operation` VALUES (9,19);
INSERT INTO `b_task_operation` VALUES (9,20);
INSERT INTO `b_task_operation` VALUES (9,21);
INSERT INTO `b_task_operation` VALUES (9,22);
INSERT INTO `b_task_operation` VALUES (9,23);
INSERT INTO `b_task_operation` VALUES (9,24);
INSERT INTO `b_task_operation` VALUES (9,25);
INSERT INTO `b_task_operation` VALUES (9,26);
INSERT INTO `b_task_operation` VALUES (9,27);
INSERT INTO `b_task_operation` VALUES (9,28);
INSERT INTO `b_task_operation` VALUES (9,29);
INSERT INTO `b_task_operation` VALUES (9,30);
INSERT INTO `b_task_operation` VALUES (9,31);
INSERT INTO `b_task_operation` VALUES (10,15);
INSERT INTO `b_task_operation` VALUES (10,16);
INSERT INTO `b_task_operation` VALUES (10,17);
INSERT INTO `b_task_operation` VALUES (10,18);
INSERT INTO `b_task_operation` VALUES (10,19);
INSERT INTO `b_task_operation` VALUES (10,20);
INSERT INTO `b_task_operation` VALUES (10,21);
INSERT INTO `b_task_operation` VALUES (10,22);
INSERT INTO `b_task_operation` VALUES (10,23);
INSERT INTO `b_task_operation` VALUES (10,24);
INSERT INTO `b_task_operation` VALUES (10,25);
INSERT INTO `b_task_operation` VALUES (10,26);
INSERT INTO `b_task_operation` VALUES (10,27);
INSERT INTO `b_task_operation` VALUES (10,28);
INSERT INTO `b_task_operation` VALUES (10,29);
INSERT INTO `b_task_operation` VALUES (10,30);
INSERT INTO `b_task_operation` VALUES (10,31);
INSERT INTO `b_task_operation` VALUES (11,15);
INSERT INTO `b_task_operation` VALUES (11,19);
INSERT INTO `b_task_operation` VALUES (11,23);
INSERT INTO `b_task_operation` VALUES (11,24);
INSERT INTO `b_task_operation` VALUES (11,25);
INSERT INTO `b_task_operation` VALUES (13,36);
INSERT INTO `b_task_operation` VALUES (13,37);
INSERT INTO `b_task_operation` VALUES (13,38);
INSERT INTO `b_task_operation` VALUES (13,39);
INSERT INTO `b_task_operation` VALUES (13,40);
INSERT INTO `b_task_operation` VALUES (13,41);
INSERT INTO `b_task_operation` VALUES (13,42);
INSERT INTO `b_task_operation` VALUES (13,44);
INSERT INTO `b_task_operation` VALUES (13,45);
INSERT INTO `b_task_operation` VALUES (14,34);
INSERT INTO `b_task_operation` VALUES (14,35);
INSERT INTO `b_task_operation` VALUES (14,36);
INSERT INTO `b_task_operation` VALUES (14,37);
INSERT INTO `b_task_operation` VALUES (14,38);
INSERT INTO `b_task_operation` VALUES (14,39);
INSERT INTO `b_task_operation` VALUES (14,40);
INSERT INTO `b_task_operation` VALUES (14,41);
INSERT INTO `b_task_operation` VALUES (14,42);
INSERT INTO `b_task_operation` VALUES (14,43);
INSERT INTO `b_task_operation` VALUES (14,44);
INSERT INTO `b_task_operation` VALUES (14,45);
INSERT INTO `b_task_operation` VALUES (14,46);
INSERT INTO `b_task_operation` VALUES (16,47);
INSERT INTO `b_task_operation` VALUES (17,47);
INSERT INTO `b_task_operation` VALUES (17,48);
INSERT INTO `b_task_operation` VALUES (17,52);
INSERT INTO `b_task_operation` VALUES (18,47);
INSERT INTO `b_task_operation` VALUES (18,52);
INSERT INTO `b_task_operation` VALUES (18,53);
INSERT INTO `b_task_operation` VALUES (18,54);
INSERT INTO `b_task_operation` VALUES (19,47);
INSERT INTO `b_task_operation` VALUES (19,48);
INSERT INTO `b_task_operation` VALUES (19,49);
INSERT INTO `b_task_operation` VALUES (19,50);
INSERT INTO `b_task_operation` VALUES (19,52);
INSERT INTO `b_task_operation` VALUES (19,53);
INSERT INTO `b_task_operation` VALUES (19,54);
INSERT INTO `b_task_operation` VALUES (20,47);
INSERT INTO `b_task_operation` VALUES (20,48);
INSERT INTO `b_task_operation` VALUES (20,49);
INSERT INTO `b_task_operation` VALUES (20,50);
INSERT INTO `b_task_operation` VALUES (20,51);
INSERT INTO `b_task_operation` VALUES (20,52);
INSERT INTO `b_task_operation` VALUES (20,53);
INSERT INTO `b_task_operation` VALUES (20,54);
INSERT INTO `b_task_operation` VALUES (22,56);
INSERT INTO `b_task_operation` VALUES (23,55);
INSERT INTO `b_task_operation` VALUES (23,56);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_undo`
-- 




DROP TABLE IF EXISTS `b_undo`;
CREATE TABLE `b_undo` (
  `ID` varchar(255)  NOT NULL,
  `MODULE_ID` varchar(50)  DEFAULT NULL,
  `UNDO_TYPE` varchar(50)  DEFAULT NULL,
  `UNDO_HANDLER` varchar(255)  DEFAULT NULL,
  `CONTENT` mediumtext ,
  `USER_ID` int(11) DEFAULT NULL,
  `TIMESTAMP_X` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user`
-- 




DROP TABLE IF EXISTS `b_user`;
CREATE TABLE `b_user` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `LOGIN` varchar(50)  NOT NULL,
  `PASSWORD` varchar(50)  NOT NULL,
  `CHECKWORD` varchar(50)  DEFAULT NULL,
  `ACTIVE` char(1)  NOT NULL DEFAULT 'Y',
  `NAME` varchar(50)  DEFAULT NULL,
  `LAST_NAME` varchar(50)  DEFAULT NULL,
  `EMAIL` varchar(255)  NOT NULL,
  `LAST_LOGIN` datetime DEFAULT NULL,
  `DATE_REGISTER` datetime NOT NULL,
  `LID` char(2)  DEFAULT NULL,
  `PERSONAL_PROFESSION` varchar(255)  DEFAULT NULL,
  `PERSONAL_WWW` varchar(255)  DEFAULT NULL,
  `PERSONAL_ICQ` varchar(255)  DEFAULT NULL,
  `PERSONAL_GENDER` char(1)  DEFAULT NULL,
  `PERSONAL_BIRTHDATE` varchar(50)  DEFAULT NULL,
  `PERSONAL_PHOTO` int(18) DEFAULT NULL,
  `PERSONAL_PHONE` varchar(255)  DEFAULT NULL,
  `PERSONAL_FAX` varchar(255)  DEFAULT NULL,
  `PERSONAL_MOBILE` varchar(255)  DEFAULT NULL,
  `PERSONAL_PAGER` varchar(255)  DEFAULT NULL,
  `PERSONAL_STREET` text ,
  `PERSONAL_MAILBOX` varchar(255)  DEFAULT NULL,
  `PERSONAL_CITY` varchar(255)  DEFAULT NULL,
  `PERSONAL_STATE` varchar(255)  DEFAULT NULL,
  `PERSONAL_ZIP` varchar(255)  DEFAULT NULL,
  `PERSONAL_COUNTRY` varchar(255)  DEFAULT NULL,
  `PERSONAL_NOTES` text ,
  `WORK_COMPANY` varchar(255)  DEFAULT NULL,
  `WORK_DEPARTMENT` varchar(255)  DEFAULT NULL,
  `WORK_POSITION` varchar(255)  DEFAULT NULL,
  `WORK_WWW` varchar(255)  DEFAULT NULL,
  `WORK_PHONE` varchar(255)  DEFAULT NULL,
  `WORK_FAX` varchar(255)  DEFAULT NULL,
  `WORK_PAGER` varchar(255)  DEFAULT NULL,
  `WORK_STREET` text ,
  `WORK_MAILBOX` varchar(255)  DEFAULT NULL,
  `WORK_CITY` varchar(255)  DEFAULT NULL,
  `WORK_STATE` varchar(255)  DEFAULT NULL,
  `WORK_ZIP` varchar(255)  DEFAULT NULL,
  `WORK_COUNTRY` varchar(255)  DEFAULT NULL,
  `WORK_PROFILE` text ,
  `WORK_LOGO` int(18) DEFAULT NULL,
  `WORK_NOTES` text ,
  `ADMIN_NOTES` text ,
  `STORED_HASH` varchar(32)  DEFAULT NULL,
  `XML_ID` varchar(255)  DEFAULT NULL,
  `PERSONAL_BIRTHDAY` date DEFAULT NULL,
  `EXTERNAL_AUTH_ID` varchar(255)  DEFAULT NULL,
  `CHECKWORD_TIME` datetime DEFAULT NULL,
  `SECOND_NAME` varchar(50)  DEFAULT NULL,
  `CONFIRM_CODE` varchar(8)  DEFAULT NULL,
  `LOGIN_ATTEMPTS` int(18) DEFAULT NULL,
  `LAST_ACTIVITY_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ix_login` (`LOGIN`,`EXTERNAL_AUTH_ID`),
  KEY `ix_b_user_email` (`EMAIL`),
  KEY `ix_b_user_activity_date` (`LAST_ACTIVITY_DATE`),
  KEY `IX_B_USER_XML_ID` (`XML_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_user`
-- 


INSERT INTO `b_user` VALUES (1,'2015-11-30 16:23:59','admin','3<mEZ{7yae1de7b0d5f5e16612f04f429b7b7197','E9C6M3mp8aa841b632a657cb2c2e20288d8e1b83','Y','Đào','Quang Hưng','dqhung.ec@gmail.com','2016-03-23 10:20:54','2010-11-08 12:10:49','s1','','','','',NULL,NULL,'','','','','','','','','','0','','','','','','','','','','','','','','0','',NULL,'','',NULL,NULL,NULL,NULL,'2015-11-30 16:23:59','',NULL,0,NULL);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user_field`
-- 




DROP TABLE IF EXISTS `b_user_field`;
CREATE TABLE `b_user_field` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ENTITY_ID` varchar(20)  DEFAULT NULL,
  `FIELD_NAME` varchar(20)  DEFAULT NULL,
  `USER_TYPE_ID` varchar(50)  DEFAULT NULL,
  `XML_ID` varchar(255)  DEFAULT NULL,
  `SORT` int(11) DEFAULT NULL,
  `MULTIPLE` char(1)  NOT NULL DEFAULT 'N',
  `MANDATORY` char(1)  NOT NULL DEFAULT 'N',
  `SHOW_FILTER` char(1)  NOT NULL DEFAULT 'N',
  `SHOW_IN_LIST` char(1)  NOT NULL DEFAULT 'Y',
  `EDIT_IN_LIST` char(1)  NOT NULL DEFAULT 'Y',
  `IS_SEARCHABLE` char(1)  NOT NULL DEFAULT 'N',
  `SETTINGS` text ,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_user_type_entity` (`ENTITY_ID`,`FIELD_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user_field_enum`
-- 




DROP TABLE IF EXISTS `b_user_field_enum`;
CREATE TABLE `b_user_field_enum` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_FIELD_ID` int(11) DEFAULT NULL,
  `VALUE` varchar(255)  NOT NULL,
  `DEF` char(1)  NOT NULL DEFAULT 'N',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `XML_ID` varchar(255)  NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_user_field_enum` (`USER_FIELD_ID`,`XML_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user_field_lang`
-- 




DROP TABLE IF EXISTS `b_user_field_lang`;
CREATE TABLE `b_user_field_lang` (
  `USER_FIELD_ID` int(11) NOT NULL DEFAULT '0',
  `LANGUAGE_ID` char(2)  NOT NULL DEFAULT '',
  `EDIT_FORM_LABEL` varchar(255)  DEFAULT NULL,
  `LIST_COLUMN_LABEL` varchar(255)  DEFAULT NULL,
  `LIST_FILTER_LABEL` varchar(255)  DEFAULT NULL,
  `ERROR_MESSAGE` varchar(255)  DEFAULT NULL,
  `HELP_MESSAGE` varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`USER_FIELD_ID`,`LANGUAGE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user_group`
-- 




DROP TABLE IF EXISTS `b_user_group`;
CREATE TABLE `b_user_group` (
  `USER_ID` int(18) NOT NULL,
  `GROUP_ID` int(18) NOT NULL,
  `DATE_ACTIVE_FROM` datetime DEFAULT NULL,
  `DATE_ACTIVE_TO` datetime DEFAULT NULL,
  UNIQUE KEY `ix_user_group` (`USER_ID`,`GROUP_ID`),
  KEY `ix_user_group_group` (`GROUP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_user_group`
-- 


INSERT INTO `b_user_group` VALUES (1,1,NULL,NULL);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user_hit_auth`
-- 




DROP TABLE IF EXISTS `b_user_hit_auth`;
CREATE TABLE `b_user_hit_auth` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(18) NOT NULL,
  `HASH` varchar(32)  NOT NULL,
  `URL` varchar(255)  NOT NULL,
  `SITE_ID` char(2)  DEFAULT NULL,
  `TIMESTAMP_X` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_USER_HIT_AUTH_1` (`HASH`),
  KEY `IX_USER_HIT_AUTH_2` (`USER_ID`),
  KEY `IX_USER_HIT_AUTH_3` (`TIMESTAMP_X`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user_option`
-- 




DROP TABLE IF EXISTS `b_user_option`;
CREATE TABLE `b_user_option` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `CATEGORY` varchar(50)  NOT NULL,
  `NAME` varchar(255)  NOT NULL,
  `VALUE` text ,
  `COMMON` char(1)  NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `ix_user_option_param` (`CATEGORY`,`NAME`),
  KEY `ix_user_option_user` (`USER_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_user_option`
-- 


INSERT INTO `b_user_option` VALUES (1,NULL,'main.interface','global','a:1:{s:5:\"theme\";s:9:\"dark-blue\";}','Y');
INSERT INTO `b_user_option` VALUES (2,1,'admin_panel','settings','a:2:{s:4:\"edit\";s:3:\"off\";s:9:\"collapsed\";s:3:\"off\";}','N');
INSERT INTO `b_user_option` VALUES (3,1,'admin_menu','pos','a:2:{s:8:\"sections\";s:98:\"menu_iblock_/news,menu_fileman,menu_iblock_/vn,iblock_admin,menu_iblock,menu_search_stat,menu_util\";s:5:\"width\";s:3:\"225\";}','N');
INSERT INTO `b_user_option` VALUES (4,1,'fileman','last_pathes','s:85:\"a:4:{i:0;s:13:\"/webmin/cache\";i:1;s:7:\"/webmin\";i:2;s:7:\"/upload\";i:3;s:7:\"/bitrix\";}\";','N');
INSERT INTO `b_user_option` VALUES (5,1,'filter','tbl_iblock_section_feec45850a6da7a26ecbc04356074bda_filter','a:1:{s:4:\"rows\";s:6:\"parent\";}','N');
INSERT INTO `b_user_option` VALUES (6,1,'filter','tbl_iblock_list_feec45850a6da7a26ecbc04356074bda_filter','a:1:{s:4:\"rows\";s:15:\"IBLIST_A_PARENT\";}','N');
INSERT INTO `b_user_option` VALUES (7,1,'fileman','medialib_def_type','s:1:\"3\";','N');
INSERT INTO `b_user_option` VALUES (9,1,'fileman','taskbar_settings_PREVIEW_TEXT','s:246:\"a:3:{s:19:\"BXPropertiesTaskbar\";a:3:{s:4:\"show\";b:1;s:3:\"set\";i:3;s:6:\"active\";b:1;}s:20:\"BXComponents2Taskbar\";a:3:{s:4:\"show\";b:1;s:3:\"set\";s:1:\"2\";s:6:\"active\";b:1;}s:17:\"BXSnippetsTaskbar\";a:3:{s:4:\"show\";b:1;s:3:\"set\";i:3;s:6:\"active\";b:1;}}\";','N');
INSERT INTO `b_user_option` VALUES (8,1,'start_menu','recent','a:1:{i:0;a:4:{s:3:\"url\";s:86:\"/webmin/admin/iblock_list_admin.php?IBLOCK_ID=5&type=vn&lang=en&find_section_section=0\";s:4:\"text\";s:7:\"Tin tuc\";s:5:\"title\";s:30:\"Tin tuc (double click to open)\";s:4:\"icon\";s:24:\"iblock_menu_icon_iblocks\";}}','N');
INSERT INTO `b_user_option` VALUES (10,1,'fileman','taskbarset_settings_PREVIEW_TEXT','s:90:\"a:2:{i:2;a:2:{s:4:\"show\";b:0;s:4:\"size\";i:200;}i:3;a:2:{s:4:\"show\";b:0;s:4:\"size\";i:160;}}\";','N');


-- --------------------------------------------------------
-- 
-- Table structure for table `b_user_stored_auth`
-- 




DROP TABLE IF EXISTS `b_user_stored_auth`;
CREATE TABLE `b_user_stored_auth` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(18) NOT NULL,
  `DATE_REG` datetime NOT NULL,
  `LAST_AUTH` datetime NOT NULL,
  `STORED_HASH` varchar(32)  NOT NULL,
  `TEMP_HASH` char(1)  NOT NULL DEFAULT 'N',
  `IP_ADDR` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ux_user_hash` (`USER_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_user_stored_auth`
-- 


INSERT INTO `b_user_stored_auth` VALUES (1,1,'2010-11-08 12:10:50','2010-11-08 12:10:50','2e46f2ce2b5ee485ed86e6443eb64f1a','N',2130706433);


-- --------------------------------------------------------
-- 
-- Table structure for table `b_xml_tree`
-- 




DROP TABLE IF EXISTS `b_xml_tree`;
CREATE TABLE `b_xml_tree` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARENT_ID` int(11) DEFAULT NULL,
  `LEFT_MARGIN` int(11) DEFAULT NULL,
  `RIGHT_MARGIN` int(11) DEFAULT NULL,
  `DEPTH_LEVEL` int(11) DEFAULT NULL,
  `NAME` varchar(255)  DEFAULT NULL,
  `VALUE` text ,
  `ATTRIBUTES` text ,
  PRIMARY KEY (`ID`),
  KEY `ix_b_xml_tree_parent` (`PARENT_ID`),
  KEY `ix_b_xml_tree_left` (`LEFT_MARGIN`)
) ENGINE=MyISAM AUTO_INCREMENT=164 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table  `b_xml_tree`
-- 


INSERT INTO `b_xml_tree` VALUES (1,0,1,320,0,'CommerceInformation',NULL,'a:2:{s:13:\"SchemaVersion\";s:5:\"2.021\";s:12:\"CreationDate\";s:19:\"2010-07-12T16:48:00\";}');
INSERT INTO `b_xml_tree` VALUES (2,1,2,67,1,'Metadata',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (3,2,3,4,2,'Id','2',NULL);
INSERT INTO `b_xml_tree` VALUES (4,2,5,6,2,'Title','Job Vacancies',NULL);
INSERT INTO `b_xml_tree` VALUES (5,2,7,64,2,'Properties',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (6,5,8,15,3,'Property',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (7,6,9,10,4,'Id','CML2_ACTIVE',NULL);
INSERT INTO `b_xml_tree` VALUES (8,6,11,12,4,'Title','BitrixActive',NULL);
INSERT INTO `b_xml_tree` VALUES (9,6,13,14,4,'Multiple','false',NULL);
INSERT INTO `b_xml_tree` VALUES (10,5,16,23,3,'Property',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (11,10,17,18,4,'Id','CML2_CODE',NULL);
INSERT INTO `b_xml_tree` VALUES (12,10,19,20,4,'Title','Code',NULL);
INSERT INTO `b_xml_tree` VALUES (13,10,21,22,4,'Multiple','false',NULL);
INSERT INTO `b_xml_tree` VALUES (14,5,24,31,3,'Property',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (15,14,25,26,4,'Id','CML2_SORT',NULL);
INSERT INTO `b_xml_tree` VALUES (16,14,27,28,4,'Title','Sort',NULL);
INSERT INTO `b_xml_tree` VALUES (17,14,29,30,4,'Multiple','false',NULL);
INSERT INTO `b_xml_tree` VALUES (18,5,32,39,3,'Property',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (19,18,33,34,4,'Id','CML2_ACTIVE_FROM',NULL);
INSERT INTO `b_xml_tree` VALUES (20,18,35,36,4,'Title','Start time',NULL);
INSERT INTO `b_xml_tree` VALUES (21,18,37,38,4,'Multiple','false',NULL);
INSERT INTO `b_xml_tree` VALUES (22,5,40,47,3,'Property',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (23,22,41,42,4,'Id','CML2_ACTIVE_TO',NULL);
INSERT INTO `b_xml_tree` VALUES (24,22,43,44,4,'Title','End time',NULL);
INSERT INTO `b_xml_tree` VALUES (25,22,45,46,4,'Multiple','false',NULL);
INSERT INTO `b_xml_tree` VALUES (26,5,48,55,3,'Property',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (27,26,49,50,4,'Id','CML2_PREVIEW_TEXT',NULL);
INSERT INTO `b_xml_tree` VALUES (28,26,51,52,4,'Title','Anons',NULL);
INSERT INTO `b_xml_tree` VALUES (29,26,53,54,4,'Multiple','false',NULL);
INSERT INTO `b_xml_tree` VALUES (30,5,56,63,3,'Property',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (31,30,57,58,4,'Id','CML2_PREVIEW_PICTURE',NULL);
INSERT INTO `b_xml_tree` VALUES (32,30,59,60,4,'Title','Preview picture',NULL);
INSERT INTO `b_xml_tree` VALUES (33,30,61,62,4,'Multiple','false',NULL);
INSERT INTO `b_xml_tree` VALUES (34,2,65,66,2,'Sections',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (35,1,68,319,1,'Catalog',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (36,35,69,70,2,'Id','furniture_vacancies',NULL);
INSERT INTO `b_xml_tree` VALUES (37,35,71,72,2,'MetadataId','2',NULL);
INSERT INTO `b_xml_tree` VALUES (38,35,73,74,2,'Title','Job Vacancies',NULL);
INSERT INTO `b_xml_tree` VALUES (39,35,75,76,2,'BitrixCode','furniture_vacancies',NULL);
INSERT INTO `b_xml_tree` VALUES (40,35,77,78,2,'BitrixSort','500',NULL);
INSERT INTO `b_xml_tree` VALUES (41,35,79,80,2,'BitrixListURL','#SITE_DIR#/company/vacancies.php',NULL);
INSERT INTO `b_xml_tree` VALUES (42,35,81,82,2,'BitrixDetailURL','#SITE_DIR#/company/vacancies.php##ID#',NULL);
INSERT INTO `b_xml_tree` VALUES (43,35,83,84,2,'BitrixSectionURL',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (44,35,85,86,2,'BitrixPicture',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (45,35,87,88,2,'BitrixIndexElements','true',NULL);
INSERT INTO `b_xml_tree` VALUES (46,35,89,90,2,'BitrixIndexSections','false',NULL);
INSERT INTO `b_xml_tree` VALUES (47,35,91,92,2,'BitrixWorkflow','false',NULL);
INSERT INTO `b_xml_tree` VALUES (48,35,93,154,2,'BitrixLabels',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (49,48,94,99,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (50,49,95,96,4,'Id','ELEMENT_NAME',NULL);
INSERT INTO `b_xml_tree` VALUES (51,49,97,98,4,'Value','Vacancy',NULL);
INSERT INTO `b_xml_tree` VALUES (52,48,100,105,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (53,52,101,102,4,'Id','ELEMENTS_NAME',NULL);
INSERT INTO `b_xml_tree` VALUES (54,52,103,104,4,'Value','Vacancies',NULL);
INSERT INTO `b_xml_tree` VALUES (55,48,106,111,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (56,55,107,108,4,'Id','ELEMENT_ADD',NULL);
INSERT INTO `b_xml_tree` VALUES (57,55,109,110,4,'Value','Add vacancy',NULL);
INSERT INTO `b_xml_tree` VALUES (58,48,112,117,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (59,58,113,114,4,'Id','ELEMENT_EDIT',NULL);
INSERT INTO `b_xml_tree` VALUES (60,58,115,116,4,'Value','Edit vacancy',NULL);
INSERT INTO `b_xml_tree` VALUES (61,48,118,123,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (62,61,119,120,4,'Id','ELEMENT_DELETE',NULL);
INSERT INTO `b_xml_tree` VALUES (63,61,121,122,4,'Value','Delete vacancy',NULL);
INSERT INTO `b_xml_tree` VALUES (64,48,124,129,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (65,64,125,126,4,'Id','SECTION_NAME',NULL);
INSERT INTO `b_xml_tree` VALUES (66,64,127,128,4,'Value','Category',NULL);
INSERT INTO `b_xml_tree` VALUES (67,48,130,135,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (68,67,131,132,4,'Id','SECTIONS_NAME',NULL);
INSERT INTO `b_xml_tree` VALUES (69,67,133,134,4,'Value','Categories',NULL);
INSERT INTO `b_xml_tree` VALUES (70,48,136,141,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (71,70,137,138,4,'Id','SECTION_ADD',NULL);
INSERT INTO `b_xml_tree` VALUES (72,70,139,140,4,'Value','Add category',NULL);
INSERT INTO `b_xml_tree` VALUES (73,48,142,147,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (74,73,143,144,4,'Id','SECTION_EDIT',NULL);
INSERT INTO `b_xml_tree` VALUES (75,73,145,146,4,'Value','Edit category',NULL);
INSERT INTO `b_xml_tree` VALUES (76,48,148,153,3,'BitrixLabel',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (77,76,149,150,4,'Id','SECTION_DELETE',NULL);
INSERT INTO `b_xml_tree` VALUES (78,76,151,152,4,'Value','Delete category',NULL);
INSERT INTO `b_xml_tree` VALUES (79,35,155,318,2,'Elements',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (80,79,156,209,3,'Element',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (81,80,157,158,4,'Id','2',NULL);
INSERT INTO `b_xml_tree` VALUES (82,80,159,160,4,'Title','Designer, Decorative Accessories',NULL);
INSERT INTO `b_xml_tree` VALUES (83,80,161,162,4,'BitrixTags',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (84,80,163,164,4,'Description','<b>Requirements</b> 						 						 \r\n<p>Degree in Fine Arts, Applied Arts or Engineering</p>\r\n\r\n<b>Essential Functions</b> 						 \r\n<p>Develop designs from conception through revisions to sample approval. Present to Head Designer for review and approval.</p>\r\n<p>Create presentation boards.</p>	\r\n					 						\r\n<b>Employment Status</b> 						 \r\n<p>Full time</p>\r\n ',NULL);
INSERT INTO `b_xml_tree` VALUES (85,80,165,208,4,'PropertiesValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (86,85,166,171,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (87,86,167,168,6,'Id','CML2_ACTIVE',NULL);
INSERT INTO `b_xml_tree` VALUES (88,86,169,170,6,'Value','true',NULL);
INSERT INTO `b_xml_tree` VALUES (89,85,172,177,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (90,89,173,174,6,'Id','CML2_CODE',NULL);
INSERT INTO `b_xml_tree` VALUES (91,89,175,176,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (92,85,178,183,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (93,92,179,180,6,'Id','CML2_SORT',NULL);
INSERT INTO `b_xml_tree` VALUES (94,92,181,182,6,'Value','200',NULL);
INSERT INTO `b_xml_tree` VALUES (95,85,184,189,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (96,95,185,186,6,'Id','CML2_ACTIVE_FROM',NULL);
INSERT INTO `b_xml_tree` VALUES (97,95,187,188,6,'Value','2010-05-01 00:00:00',NULL);
INSERT INTO `b_xml_tree` VALUES (98,85,190,195,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (99,98,191,192,6,'Id','CML2_ACTIVE_TO',NULL);
INSERT INTO `b_xml_tree` VALUES (100,98,193,194,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (101,85,196,201,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (102,101,197,198,6,'Id','CML2_PREVIEW_TEXT',NULL);
INSERT INTO `b_xml_tree` VALUES (103,101,199,200,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (104,85,202,207,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (105,104,203,204,6,'Id','CML2_PREVIEW_PICTURE',NULL);
INSERT INTO `b_xml_tree` VALUES (106,104,205,206,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (107,79,210,263,3,'Element',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (108,107,211,212,4,'Id','3',NULL);
INSERT INTO `b_xml_tree` VALUES (109,107,213,214,4,'Title','Associate Marketing Manager',NULL);
INSERT INTO `b_xml_tree` VALUES (110,107,215,216,4,'BitrixTags',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (111,107,217,218,4,'Description','<p>Provide professional administrative support to IT executives and department. Tasks require a high degree of sound judgment, initiative and tact under general supervision.</p>\r\n\r\n<b>Requirements</b> 						 						 \r\n<p>Minimum 5 years experience as an executive assistant</p>\r\n<p>Proficiency with Microsoft Office Suite</p>\r\n<p>Strong organizational skills</p>\r\n<p>Some college preferred but not necessary  </p>\r\n 						 						\r\n<b>Essential Functions</b> 						 \r\n<p>Provide general point of contact assistance and support for the IT department</p>\r\n<p>Maintain contractor database and monitor badge access extensions/deactivations</p>',NULL);
INSERT INTO `b_xml_tree` VALUES (112,107,219,262,4,'PropertiesValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (113,112,220,225,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (114,113,221,222,6,'Id','CML2_ACTIVE',NULL);
INSERT INTO `b_xml_tree` VALUES (115,113,223,224,6,'Value','true',NULL);
INSERT INTO `b_xml_tree` VALUES (116,112,226,231,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (117,116,227,228,6,'Id','CML2_CODE',NULL);
INSERT INTO `b_xml_tree` VALUES (118,116,229,230,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (119,112,232,237,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (120,119,233,234,6,'Id','CML2_SORT',NULL);
INSERT INTO `b_xml_tree` VALUES (121,119,235,236,6,'Value','300',NULL);
INSERT INTO `b_xml_tree` VALUES (122,112,238,243,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (123,122,239,240,6,'Id','CML2_ACTIVE_FROM',NULL);
INSERT INTO `b_xml_tree` VALUES (124,122,241,242,6,'Value','2010-05-01 00:00:00',NULL);
INSERT INTO `b_xml_tree` VALUES (125,112,244,249,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (126,125,245,246,6,'Id','CML2_ACTIVE_TO',NULL);
INSERT INTO `b_xml_tree` VALUES (127,125,247,248,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (128,112,250,255,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (129,128,251,252,6,'Id','CML2_PREVIEW_TEXT',NULL);
INSERT INTO `b_xml_tree` VALUES (130,128,253,254,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (131,112,256,261,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (132,131,257,258,6,'Id','CML2_PREVIEW_PICTURE',NULL);
INSERT INTO `b_xml_tree` VALUES (133,131,259,260,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (134,79,264,317,3,'Element',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (135,134,265,266,4,'Id','4',NULL);
INSERT INTO `b_xml_tree` VALUES (136,134,267,268,4,'Title','Packaging Engineer',NULL);
INSERT INTO `b_xml_tree` VALUES (137,134,269,270,4,'BitrixTags',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (138,134,271,272,4,'Description','<b>Requirements</b> 						 						 \r\n<p>Bachelors Degree preferably in packaging or technically related field.</p>\r\n<p>Project Management experience essential.</p>	\r\n					 						\r\n<b>Essential Functions</b> 						 \r\n<p>Develop and maintain general and specific packaging specifications that meet transportation\r\nand optimal distribution flow requirements for all Decorative Accessories</p>\r\n<p>Analyze damage reports on products and take appropriate corrective actions to eliminate future\r\nproblems</p>\r\n<p>Research, designate, and approve packaging suppliers worldwide.</p>',NULL);
INSERT INTO `b_xml_tree` VALUES (139,134,273,316,4,'PropertiesValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (140,139,274,279,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (141,140,275,276,6,'Id','CML2_ACTIVE',NULL);
INSERT INTO `b_xml_tree` VALUES (142,140,277,278,6,'Value','true',NULL);
INSERT INTO `b_xml_tree` VALUES (143,139,280,285,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (144,143,281,282,6,'Id','CML2_CODE',NULL);
INSERT INTO `b_xml_tree` VALUES (145,143,283,284,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (146,139,286,291,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (147,146,287,288,6,'Id','CML2_SORT',NULL);
INSERT INTO `b_xml_tree` VALUES (148,146,289,290,6,'Value','400',NULL);
INSERT INTO `b_xml_tree` VALUES (149,139,292,297,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (150,149,293,294,6,'Id','CML2_ACTIVE_FROM',NULL);
INSERT INTO `b_xml_tree` VALUES (151,149,295,296,6,'Value','2010-05-01 00:00:00',NULL);
INSERT INTO `b_xml_tree` VALUES (152,139,298,303,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (153,152,299,300,6,'Id','CML2_ACTIVE_TO',NULL);
INSERT INTO `b_xml_tree` VALUES (154,152,301,302,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (155,139,304,309,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (156,155,305,306,6,'Id','CML2_PREVIEW_TEXT',NULL);
INSERT INTO `b_xml_tree` VALUES (157,155,307,308,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (158,139,310,315,5,'PropertyValues',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (159,158,311,312,6,'Id','CML2_PREVIEW_PICTURE',NULL);
INSERT INTO `b_xml_tree` VALUES (160,158,313,314,6,'Value',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (161,0,22,0,0,'',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (162,0,23,0,0,'',NULL,NULL);
INSERT INTO `b_xml_tree` VALUES (163,0,24,0,0,'',NULL,NULL);
