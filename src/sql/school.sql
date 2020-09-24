/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : school

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2020-09-24 18:35:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `classid` int(11) NOT NULL AUTO_INCREMENT,
  `adress` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `stopJudge` int(255) DEFAULT NULL,
  `rssi` varchar(255) DEFAULT NULL,
  `floor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`classid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class
-- ----------------------------

-- ----------------------------
-- Table structure for class_data
-- ----------------------------
DROP TABLE IF EXISTS `class_data`;
CREATE TABLE `class_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `new_student` varchar(255) DEFAULT NULL,
  `walker_number` int(11) DEFAULT NULL,
  `in_class_number` int(11) DEFAULT NULL,
  `jump_out` int(255) DEFAULT NULL,
  `class_now_number` int(11) DEFAULT NULL,
  `hour_class_number` int(11) DEFAULT NULL,
  `hour_in_class_number` int(11) DEFAULT NULL,
  `updatetime` varchar(255) DEFAULT NULL,
  `hours` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_data
-- ----------------------------

-- ----------------------------
-- Table structure for class_notice
-- ----------------------------
DROP TABLE IF EXISTS `class_notice`;
CREATE TABLE `class_notice` (
  `cnid` int(11) NOT NULL AUTO_INCREMENT,
  `teachername` varchar(255) DEFAULT NULL,
  `notice` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`cnid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_notice
-- ----------------------------

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `contactname` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `relation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contact
-- ----------------------------

-- ----------------------------
-- Table structure for contact_class_notice
-- ----------------------------
DROP TABLE IF EXISTS `contact_class_notice`;
CREATE TABLE `contact_class_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `cnid` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contact_class_notice
-- ----------------------------

-- ----------------------------
-- Table structure for contact_student
-- ----------------------------
DROP TABLE IF EXISTS `contact_student`;
CREATE TABLE `contact_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contact_student
-- ----------------------------

-- ----------------------------
-- Table structure for logrecord
-- ----------------------------
DROP TABLE IF EXISTS `logrecord`;
CREATE TABLE `logrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceid` varchar(255) DEFAULT NULL,
  `changevalue` varchar(255) DEFAULT NULL,
  `gentime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logrecord
-- ----------------------------

-- ----------------------------
-- Table structure for machine
-- ----------------------------
DROP TABLE IF EXISTS `machine`;
CREATE TABLE `machine` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `machineid` varchar(255) DEFAULT NULL,
  `classname` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `leastRssi` varchar(255) DEFAULT NULL,
  `beat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of machine
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `notice` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `iconCls` varchar(255) DEFAULT NULL,
  `keepAlive` varchar(255) DEFAULT NULL,
  `requireAuth` varchar(255) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '', '/home', 'Home', '权限管理', 'fa fa-address-card-o', null, '1', null, '1');
INSERT INTO `permission` VALUES ('2', '/', '/home', 'Home', '设备管理', 'fa fa-user-circle-o', null, '1', null, '1');
INSERT INTO `permission` VALUES ('3', '/', '/home', 'Home', '人员管理', 'fa fa-bar-chart', null, '1', null, '1');
INSERT INTO `permission` VALUES ('4', '/', '/account', 'Account', '账号管理', '', null, '1', '1', '1');
INSERT INTO `permission` VALUES ('5', '/', '/role', 'Role', '访问授权', '', null, '1', '1', '1');
INSERT INTO `permission` VALUES ('6', '/', '/registerapproval', 'RegisterApproval', '注册审批', null, null, '1', '1', '1');
INSERT INTO `permission` VALUES ('7', '/', '/test2', 'Test2', '选项2', null, null, '1', '2', '1');
INSERT INTO `permission` VALUES ('8', '/', '/shiro1', 'Shiro1', '选项1', null, null, '1', '3', '1');
INSERT INTO `permission` VALUES ('9', null, '/test4', 'Test4', '注册审批2', null, null, '1', '3', '1');

-- ----------------------------
-- Table structure for register_approval
-- ----------------------------
DROP TABLE IF EXISTS `register_approval`;
CREATE TABLE `register_approval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `studentname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of register_approval
-- ----------------------------
INSERT INTO `register_approval` VALUES ('1', '2', '廖冠昌', 'e640d43c781b981f61ec33b0b8022b7f', 'EpSpEXSz0a2pV0Vk9ZMCIQ==', '');
INSERT INTO `register_approval` VALUES ('2', '1', 'zhbit', '17425052a9400d30838430851892a9f0', 'BlqCYr78qIkMan3NsJE9uQ==', 'liaoguanchang');
INSERT INTO `register_approval` VALUES ('3', '1', 'bb', '9f5a28f87fc778ab2a8c3b8b242032b7', 'MfKa5nVH1K36+b+PVMwCIg==', 'liaoguanchang');
INSERT INTO `register_approval` VALUES ('4', '1', 'dfgj', 'd58c1d4b581e3c6ed0100cecf6fd78e7', '64CQb6S/hqYmGGiBUB2EDw==', 'liaoguanchang');
INSERT INTO `register_approval` VALUES ('5', '1', 'hui', '68a83e878ae4dffe8ccf48bea43875ae', 'tsC8rBXXlOR6KUFv0x+aIw==', 'liaoguanchang');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `desc_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'contact', '联系人');
INSERT INTO `role` VALUES ('2', 'teacher', '教师');
INSERT INTO `role` VALUES ('3', 'admin', '管理员');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', '3', '1');
INSERT INTO `role_permission` VALUES ('2', '3', '2');
INSERT INTO `role_permission` VALUES ('3', '3', '3');
INSERT INTO `role_permission` VALUES ('4', '3', '4');
INSERT INTO `role_permission` VALUES ('5', '3', '5');
INSERT INTO `role_permission` VALUES ('6', '3', '6');
INSERT INTO `role_permission` VALUES ('7', '3', '7');
INSERT INTO `role_permission` VALUES ('9', '3', '9');
INSERT INTO `role_permission` VALUES ('11', '3', '8');

-- ----------------------------
-- Table structure for stop_visit
-- ----------------------------
DROP TABLE IF EXISTS `stop_visit`;
CREATE TABLE `stop_visit` (
  `stop_visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `adress` varchar(255) DEFAULT NULL,
  `inJudge` int(11) DEFAULT NULL,
  `in_time` datetime DEFAULT NULL,
  `left_time` datetime DEFAULT NULL,
  `rt` varchar(255) DEFAULT NULL,
  `visited_times` int(11) DEFAULT NULL,
  `beat` varchar(255) DEFAULT NULL,
  `handleJudge` int(11) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`stop_visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stop_visit
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentname` varchar(255) DEFAULT NULL,
  `deviceid` varchar(255) DEFAULT NULL,
  `devicevalue` varchar(255) DEFAULT NULL,
  `updatetime` varchar(255) DEFAULT NULL,
  `gentime` datetime DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  `teachername` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', 'liaoguanchang', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `teachername` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `job_number` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `entry_time` date DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------

-- ----------------------------
-- Table structure for teacher_class
-- ----------------------------
DROP TABLE IF EXISTS `teacher_class`;
CREATE TABLE `teacher_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `classid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_class
-- ----------------------------

-- ----------------------------
-- Table structure for teacher_contact
-- ----------------------------
DROP TABLE IF EXISTS `teacher_contact`;
CREATE TABLE `teacher_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_contact
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'lgc', '1a30914ce446ce58b7e1ad55346a5ba1', 'I60c7+kbbHsTjGu1O3w+7Q==');
INSERT INTO `user` VALUES ('2', 'lgc2', '6a8dd12480d2a6dda1120a1a0d68579e', 'c33IjVxTG1Ez5j5L1iGFEQ==');

-- ----------------------------
-- Table structure for user_notice
-- ----------------------------
DROP TABLE IF EXISTS `user_notice`;
CREATE TABLE `user_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `nid` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_notice
-- ----------------------------

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1', '3');
INSERT INTO `user_role` VALUES ('3', '1', '2');
INSERT INTO `user_role` VALUES ('18', '2', '2');

-- ----------------------------
-- Table structure for visit
-- ----------------------------
DROP TABLE IF EXISTS `visit`;
CREATE TABLE `visit` (
  `visitid` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `in_time` datetime DEFAULT NULL,
  `left_time` datetime DEFAULT NULL,
  `beat` varchar(255) DEFAULT NULL,
  `inJudge` int(11) DEFAULT NULL,
  `visited_times` int(11) DEFAULT NULL,
  `last_in_time` datetime DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `rt` varchar(255) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`visitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of visit
-- ----------------------------
