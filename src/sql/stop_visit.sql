/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : za102

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-02-25 22:12:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for stop_visit
-- ----------------------------
DROP TABLE IF EXISTS `stop_visit`;
CREATE TABLE `stop_visit` (
  `stop_visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `inJudge` int(11) DEFAULT NULL,
  `in_time` datetime DEFAULT NULL,
  `left_time` datetime DEFAULT NULL,
  `rt` varchar(255) DEFAULT NULL,
  `visited_times` int(11) DEFAULT NULL,
  `beat` datetime DEFAULT NULL,
  `handleJudge` int(11) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  `rssi` int(11) DEFAULT NULL,
  PRIMARY KEY (`stop_visit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stop_visit
-- ----------------------------
INSERT INTO `stop_visit` VALUES ('46', '办公区', '0', '2021-02-22 00:31:09', '2021-02-22 00:31:15', '6', '2', '2021-02-22 00:31:15', '0', '68:c6:33:85:21:11', '-89');
INSERT INTO `stop_visit` VALUES ('47', '办公区', '0', '2021-02-22 00:31:09', '2021-02-22 00:31:15', '6', '2', '2021-02-22 00:31:15', '0', '68:c6:33:85:21:12', '-89');
