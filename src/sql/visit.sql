/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : za102

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-02-25 22:13:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for visit
-- ----------------------------
DROP TABLE IF EXISTS `visit`;
CREATE TABLE `visit` (
  `visitid` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `inJudge` int(11) DEFAULT NULL,
  `in_time` datetime DEFAULT NULL,
  `left_time` datetime DEFAULT NULL,
  `rt` varchar(255) DEFAULT NULL,
  `visited_times` int(11) DEFAULT NULL,
  `beat` datetime DEFAULT NULL,
  `last_in_time` datetime DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  `rssi` int(11) DEFAULT NULL,
  PRIMARY KEY (`visitid`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of visit
-- ----------------------------
INSERT INTO `visit` VALUES ('10', '展示区', '0', '2021-02-21 19:55:40', '2021-02-21 19:55:41', '2', '2', '2021-02-21 19:55:41', '2021-02-21 19:49:43', '68:c6:33:85:21:11', '-89');
INSERT INTO `visit` VALUES ('11', '展示区', '0', '2021-02-21 19:55:40', '2021-02-21 19:55:41', '3', '2', '2021-02-21 19:55:41', '2021-02-21 19:49:43', '68:c6:33:85:21:12', '-89');
INSERT INTO `visit` VALUES ('18', '销售区', '0', '2021-02-21 23:55:19', '2021-02-21 23:55:21', '1', '4', '2021-02-21 23:55:21', '2021-02-21 22:45:34', '68:c6:33:85:21:11', '-88');
INSERT INTO `visit` VALUES ('19', '销售区', '0', '2021-02-21 23:55:19', '2021-02-21 23:55:21', '1', '4', '2021-02-21 23:55:21', '2021-02-21 22:45:34', '68:c6:33:85:21:12', '-88');
INSERT INTO `visit` VALUES ('20', '休息区', '0', '2021-02-21 22:36:48', '2021-02-21 22:40:02', '194', '2', '2021-02-21 22:40:02', '2021-02-21 22:22:03', '68:c6:33:85:21:11', '-87');
INSERT INTO `visit` VALUES ('21', '休息区', '0', '2021-02-21 22:36:48', '2021-02-21 22:40:02', '194', '2', '2021-02-21 22:40:02', '2021-02-21 22:22:03', '68:c6:33:85:21:12', '-87');
INSERT INTO `visit` VALUES ('22', '展示区', '0', '2021-02-22 01:23:28', '2021-02-22 01:25:02', '94', '1', '2021-02-22 01:25:02', '2021-02-22 01:23:28', '68:c6:33:85:21:13', '-92');
INSERT INTO `visit` VALUES ('23', '展示区', '0', '2021-02-22 01:23:28', '2021-02-22 01:25:02', '94', '1', '2021-02-22 01:25:02', '2021-02-22 01:23:28', '68:c6:33:85:21:14', '-92');
INSERT INTO `visit` VALUES ('24', '销售区', '0', '2021-02-22 01:48:30', '2021-02-22 01:48:34', '4', '1', '2021-02-22 01:48:34', '2021-02-22 01:48:30', '68:c6:33:85:21:15', '-90');
INSERT INTO `visit` VALUES ('25', '销售区', '0', '2021-02-22 01:48:30', '2021-02-22 01:48:34', '4', '1', '2021-02-22 01:48:34', '2021-02-22 01:48:30', '68:c6:33:85:21:16', '-90');
INSERT INTO `visit` VALUES ('26', '休息区', '0', '2021-02-22 02:16:58', '2021-02-22 02:17:04', '6', '2', '2021-02-22 02:17:04', '2021-02-22 02:09:07', '68:c6:33:85:21:17', '-92');
INSERT INTO `visit` VALUES ('27', '休息区', '0', '2021-02-22 02:16:58', '2021-02-22 02:17:04', '6', '2', '2021-02-22 02:17:04', '2021-02-22 02:09:07', '68:c6:33:85:21:18', '-92');
