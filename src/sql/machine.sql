/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : za102

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-02-25 22:11:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for machine
-- ----------------------------
DROP TABLE IF EXISTS `machine`;
CREATE TABLE `machine` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `machineid` varchar(255) DEFAULT NULL,
  `adress` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `leastRssi` int(11) DEFAULT NULL,
  `beat` datetime DEFAULT NULL,
  `x` varchar(255) DEFAULT NULL,
  `y` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of machine
-- ----------------------------
INSERT INTO `machine` VALUES ('1', '101', '办公区', '离线', '-100', '2021-02-25 22:02:57', '1', '1');
INSERT INTO `machine` VALUES ('2', '102', '办公区', '离线', '-100', '2021-02-25 22:02:57', '1', '29');
INSERT INTO `machine` VALUES ('3', '103', '办公区', '离线', '-100', '2021-02-25 22:02:57', '19', '29');
INSERT INTO `machine` VALUES ('4', '104', '办公区', '离线', '-100', '2021-02-25 22:02:57', '19', '1');
INSERT INTO `machine` VALUES ('5', '201', '展示区', '离线', '-100', '2021-02-25 22:02:57', '21', '16');
INSERT INTO `machine` VALUES ('6', '202', '展示区', '离线', '-100', '2021-02-25 22:02:57', '21', '29');
INSERT INTO `machine` VALUES ('7', '203', '展示区', '离线', '-100', '2021-02-25 22:02:57', '49', '29');
INSERT INTO `machine` VALUES ('8', '204', '展示区', '离线', '-100', '2021-02-25 22:02:57', '49', '16');
INSERT INTO `machine` VALUES ('9', '301', '销售区', '离线', '-100', '2021-02-25 22:02:57', '51', '16');
INSERT INTO `machine` VALUES ('10', '302', '销售区', '离线', '-100', '2021-02-25 22:02:57', '51', '29');
INSERT INTO `machine` VALUES ('11', '303', '销售区', '离线', '-100', '2021-02-25 22:02:57', '59', '29');
INSERT INTO `machine` VALUES ('12', '304', '销售区', '离线', '-100', '2021-02-25 22:02:57', '59', '16');
INSERT INTO `machine` VALUES ('13', '401', '休息区', '离线', '-100', '2021-02-25 22:02:57', '21', '1');
INSERT INTO `machine` VALUES ('14', '402', '休息区', '离线', '-100', '2021-02-25 22:02:57', '21', '14');
INSERT INTO `machine` VALUES ('15', '403', '休息区', '离线', '-100', '2021-02-25 22:02:57', '59', '14');
INSERT INTO `machine` VALUES ('16', '404', '休息区', '离线', '-100', '2021-02-25 22:02:57', '59', '1');
