/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : za102

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-04-10 16:00:48
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
  `indoorname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`visitid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of visit
-- ----------------------------
INSERT INTO `visit` VALUES ('22', '展示区', '0', '2021-02-22 01:23:28', '2021-02-22 01:25:02', '94', '1', '2021-02-22 01:25:02', '2021-02-22 01:23:28', '68:c6:33:85:21:13', '-92', 'za102');
INSERT INTO `visit` VALUES ('23', '展示区', '0', '2021-02-22 01:23:28', '2021-02-22 01:25:02', '94', '1', '2021-02-22 01:25:02', '2021-02-22 01:23:28', '68:c6:33:85:21:14', '-92', 'za102');
INSERT INTO `visit` VALUES ('24', '销售区', '0', '2021-02-22 01:48:30', '2021-02-22 01:48:34', '4', '1', '2021-02-22 01:48:34', '2021-02-22 01:48:30', '68:c6:33:85:21:15', '-90', 'za102');
INSERT INTO `visit` VALUES ('25', '销售区', '0', '2021-02-22 01:48:30', '2021-02-22 01:48:34', '4', '1', '2021-02-22 01:48:34', '2021-02-22 01:48:30', '68:c6:33:85:21:16', '-90', 'za102');
INSERT INTO `visit` VALUES ('26', '休息区', '0', '2021-02-22 02:16:58', '2021-02-22 02:17:04', '6', '2', '2021-02-22 02:17:04', '2021-02-22 02:09:07', '68:c6:33:85:21:17', '-92', 'za102');
INSERT INTO `visit` VALUES ('27', '休息区', '0', '2021-02-22 02:16:58', '2021-02-22 02:17:04', '6', '2', '2021-02-22 02:17:04', '2021-02-22 02:09:07', '68:c6:33:85:21:18', '-92', 'za102');
INSERT INTO `visit` VALUES ('28', '销售区', '0', '2021-03-31 17:28:58', '2021-03-31 17:31:28', '149', '3', '2021-03-31 17:31:28', '2021-03-31 17:24:32', '68:c6:33:85:21:19', '-88', 'za102');
INSERT INTO `visit` VALUES ('29', '销售区', '0', '2021-03-31 17:29:02', '2021-03-31 17:30:39', '96', '3', '2021-03-31 17:30:39', '2021-03-31 17:24:36', '68:c6:33:85:21:20', '-90', 'za102');
INSERT INTO `visit` VALUES ('30', '销售区', '0', '2021-04-03 04:14:06', '2021-04-03 04:14:38', '31', '10', '2021-04-03 04:14:38', '2021-04-03 03:19:28', '68:c6:33:85:21:11', '-88', 'za102');
INSERT INTO `visit` VALUES ('31', '销售区', '0', '2021-04-03 04:14:08', '2021-04-03 04:14:39', '30', '10', '2021-04-03 04:14:39', '2021-04-03 03:19:29', '68:c6:33:85:21:12', '-88', 'za102');
