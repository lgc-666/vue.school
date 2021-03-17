/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : za102

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-02-25 22:11:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `locationid` int(11) NOT NULL AUTO_INCREMENT,
  `mac` varchar(255) DEFAULT NULL,
  `adress` varchar(255) DEFAULT NULL,
  `x` varchar(255) DEFAULT NULL,
  `y` varchar(255) DEFAULT NULL,
  `beat` datetime DEFAULT NULL,
  PRIMARY KEY (`locationid`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of location
-- ----------------------------
INSERT INTO `location` VALUES ('6', '68:c6:33:85:3d:69', '办公区', '10', '15', '2020-10-12 17:51:08');
INSERT INTO `location` VALUES ('7', '68:c6:33:85:11:69', '办公区', '10', '15', '2020-10-12 17:51:09');
INSERT INTO `location` VALUES ('8', '68:c6:33:85:22:69', '办公区', '10', '15', '2020-10-12 17:51:10');
INSERT INTO `location` VALUES ('9', '68:c6:33:85:33:69', '办公区', '10', '15', '2020-10-12 17:51:10');
INSERT INTO `location` VALUES ('10', '68:c6:33:85:44:69', '办公区', '10', '15', '2020-10-12 17:51:11');
INSERT INTO `location` VALUES ('11', '68:c6:33:85:3d:69', '办公区', '7', '13', '2020-10-12 19:01:44');
INSERT INTO `location` VALUES ('12', '68:c6:33:85:11:69', '办公区', '7', '13', '2020-10-12 19:01:46');
INSERT INTO `location` VALUES ('13', '68:c6:33:85:22:69', '办公区', '8', '13', '2020-10-12 19:01:47');
INSERT INTO `location` VALUES ('14', '68:c6:33:85:33:69', '办公区', '8', '13', '2020-10-12 19:01:48');
INSERT INTO `location` VALUES ('15', '68:c6:33:85:44:69', '办公区', '8', '13', '2020-10-12 19:01:48');
INSERT INTO `location` VALUES ('16', '68:c6:33:85:3d:69', '办公区', '4', '14', '2020-10-12 19:02:13');
INSERT INTO `location` VALUES ('17', '68:c6:33:85:11:69', '办公区', '8', '14', '2020-10-12 19:02:14');
INSERT INTO `location` VALUES ('18', '68:c6:33:85:22:69', '办公区', '8', '14', '2020-10-12 19:29:15');
INSERT INTO `location` VALUES ('19', '68:c6:33:85:33:69', '办公区', '7', '13', '2020-10-12 19:29:17');
INSERT INTO `location` VALUES ('20', '68:c6:33:85:44:69', '办公区', '10', '15', '2020-10-12 19:29:17');
INSERT INTO `location` VALUES ('21', '68:c6:33:85:3d:69', '办公区', '2', '10', '2020-10-12 19:29:17');
INSERT INTO `location` VALUES ('22', '68:c6:33:85:11:69', '办公区', '19', '5', '2020-10-12 19:29:17');
INSERT INTO `location` VALUES ('23', '68:c6:33:85:22:69', '办公区', '16', '22', '2020-10-12 19:29:17');
INSERT INTO `location` VALUES ('24', '68:c6:33:85:21:11', '办公区', '10', '15', '2020-10-25 19:27:36');
INSERT INTO `location` VALUES ('25', '68:c6:33:85:21:12', '办公区', '10', '15', '2020-10-25 19:27:36');
INSERT INTO `location` VALUES ('26', '68:c6:33:85:21:11', '办公区', '7', '11', '2021-02-18 11:02:24');
INSERT INTO `location` VALUES ('27', '68:c6:33:85:21:11', '办公区', '10', '15', '2021-02-18 11:02:55');
INSERT INTO `location` VALUES ('28', '68:c6:33:85:21:11', '办公区', '8', '12', '2021-02-18 11:07:12');
INSERT INTO `location` VALUES ('29', '68:c6:33:85:21:11', '办公区', '10', '15', '2021-02-18 11:07:37');
INSERT INTO `location` VALUES ('30', '68:c6:33:85:21:11', '办公区', '7', '10', '2021-02-18 11:19:02');
INSERT INTO `location` VALUES ('31', '68:c6:33:85:21:11', '办公区', '10', '15', '2021-02-18 14:29:43');
INSERT INTO `location` VALUES ('32', '68:c6:33:85:21:11', '休息区', '30', '15', '2021-02-19 00:57:23');
INSERT INTO `location` VALUES ('33', '68:c6:33:85:21:12', '休息区', '30', '15', '2021-02-19 00:57:23');
INSERT INTO `location` VALUES ('34', '68:c6:33:85:21:11', '展示区', '55', '38', '2021-02-19 01:05:06');
INSERT INTO `location` VALUES ('35', '68:c6:33:85:21:11', '展示区', '55', '37', '2021-02-19 01:05:08');
INSERT INTO `location` VALUES ('36', '68:c6:33:85:21:11', '展示区', '55', '38', '2021-02-19 01:05:10');
INSERT INTO `location` VALUES ('37', '68:c6:33:85:21:11', '展示区', '55', '37', '2021-02-19 01:05:19');
INSERT INTO `location` VALUES ('38', '68:c6:33:85:21:11', '展示区', '55', '38', '2021-02-19 01:16:58');
INSERT INTO `location` VALUES ('39', '68:c6:33:85:21:11', '展示区', '55', '37', '2021-02-19 01:16:59');
INSERT INTO `location` VALUES ('40', '68:c6:33:85:21:11', '展示区', '55', '38', '2021-02-19 01:17:01');
INSERT INTO `location` VALUES ('41', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 01:58:10');
INSERT INTO `location` VALUES ('42', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 01:58:12');
INSERT INTO `location` VALUES ('43', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 01:58:14');
INSERT INTO `location` VALUES ('44', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 01:58:23');
INSERT INTO `location` VALUES ('45', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 02:16:31');
INSERT INTO `location` VALUES ('46', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 02:16:32');
INSERT INTO `location` VALUES ('47', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 02:16:34');
INSERT INTO `location` VALUES ('48', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 02:32:05');
INSERT INTO `location` VALUES ('49', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 02:50:04');
INSERT INTO `location` VALUES ('50', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-19 02:50:04');
INSERT INTO `location` VALUES ('51', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-19 02:50:05');
INSERT INTO `location` VALUES ('52', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 02:50:05');
INSERT INTO `location` VALUES ('53', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-19 02:50:06');
INSERT INTO `location` VALUES ('54', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 02:50:06');
INSERT INTO `location` VALUES ('55', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-19 02:56:12');
INSERT INTO `location` VALUES ('56', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 02:56:12');
INSERT INTO `location` VALUES ('57', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 02:59:18');
INSERT INTO `location` VALUES ('58', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-19 02:59:18');
INSERT INTO `location` VALUES ('59', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-19 02:59:19');
INSERT INTO `location` VALUES ('60', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 02:59:20');
INSERT INTO `location` VALUES ('61', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 03:08:40');
INSERT INTO `location` VALUES ('62', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 03:08:41');
INSERT INTO `location` VALUES ('63', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 03:10:41');
INSERT INTO `location` VALUES ('64', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-19 03:10:41');
INSERT INTO `location` VALUES ('65', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-19 03:10:42');
INSERT INTO `location` VALUES ('66', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 03:10:42');
INSERT INTO `location` VALUES ('67', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 03:24:15');
INSERT INTO `location` VALUES ('68', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-19 03:24:15');
INSERT INTO `location` VALUES ('69', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-19 03:24:16');
INSERT INTO `location` VALUES ('70', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-19 03:24:16');
INSERT INTO `location` VALUES ('71', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-19 03:24:17');
INSERT INTO `location` VALUES ('72', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-19 03:24:17');
INSERT INTO `location` VALUES ('73', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-20 12:34:21');
INSERT INTO `location` VALUES ('74', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-20 12:34:21');
INSERT INTO `location` VALUES ('75', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-20 12:34:22');
INSERT INTO `location` VALUES ('76', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-20 12:34:22');
INSERT INTO `location` VALUES ('77', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-20 12:38:04');
INSERT INTO `location` VALUES ('78', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-20 12:38:04');
INSERT INTO `location` VALUES ('79', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-20 12:38:05');
INSERT INTO `location` VALUES ('80', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-20 12:38:05');
INSERT INTO `location` VALUES ('81', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-20 12:54:24');
INSERT INTO `location` VALUES ('82', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-20 12:54:24');
INSERT INTO `location` VALUES ('83', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-20 15:23:12');
INSERT INTO `location` VALUES ('84', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-20 15:23:13');
INSERT INTO `location` VALUES ('85', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-20 15:23:14');
INSERT INTO `location` VALUES ('86', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-20 15:23:14');
INSERT INTO `location` VALUES ('87', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-20 15:23:16');
INSERT INTO `location` VALUES ('88', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-20 15:23:17');
INSERT INTO `location` VALUES ('89', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-20 15:23:23');
INSERT INTO `location` VALUES ('90', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-20 15:23:23');
INSERT INTO `location` VALUES ('91', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-20 15:29:06');
INSERT INTO `location` VALUES ('92', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-20 15:29:06');
INSERT INTO `location` VALUES ('93', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-20 15:29:07');
INSERT INTO `location` VALUES ('94', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-20 15:29:08');
INSERT INTO `location` VALUES ('95', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-20 15:29:11');
INSERT INTO `location` VALUES ('96', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-20 15:29:12');
INSERT INTO `location` VALUES ('97', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-20 22:50:15');
INSERT INTO `location` VALUES ('98', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-20 22:50:16');
INSERT INTO `location` VALUES ('99', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-20 23:22:18');
INSERT INTO `location` VALUES ('100', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-20 23:22:19');
INSERT INTO `location` VALUES ('101', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-21 13:49:57');
INSERT INTO `location` VALUES ('102', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-21 13:49:58');
INSERT INTO `location` VALUES ('103', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-21 13:50:01');
INSERT INTO `location` VALUES ('104', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-21 13:50:02');
INSERT INTO `location` VALUES ('105', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-21 14:31:22');
INSERT INTO `location` VALUES ('106', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-21 14:31:23');
INSERT INTO `location` VALUES ('107', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-21 14:31:26');
INSERT INTO `location` VALUES ('108', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-21 14:31:27');
INSERT INTO `location` VALUES ('109', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-21 14:31:44');
INSERT INTO `location` VALUES ('110', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-21 14:31:45');
INSERT INTO `location` VALUES ('111', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-21 14:58:41');
INSERT INTO `location` VALUES ('112', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-21 14:58:42');
INSERT INTO `location` VALUES ('113', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-21 14:58:43');
INSERT INTO `location` VALUES ('114', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-21 14:58:43');
INSERT INTO `location` VALUES ('115', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-21 14:58:47');
INSERT INTO `location` VALUES ('116', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-21 14:58:47');
INSERT INTO `location` VALUES ('117', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-21 15:07:12');
INSERT INTO `location` VALUES ('118', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-21 15:07:13');
INSERT INTO `location` VALUES ('119', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-21 15:07:16');
INSERT INTO `location` VALUES ('120', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-21 15:10:42');
INSERT INTO `location` VALUES ('121', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-21 15:10:43');
INSERT INTO `location` VALUES ('122', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-21 15:10:44');
INSERT INTO `location` VALUES ('123', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-21 15:10:47');
INSERT INTO `location` VALUES ('124', '68:c6:33:85:21:11', '展示区', '35', '23', '2021-02-21 15:24:36');
INSERT INTO `location` VALUES ('125', '68:c6:33:85:21:12', '展示区', '35', '22', '2021-02-21 15:24:37');
INSERT INTO `location` VALUES ('126', '68:c6:33:85:21:11', '展示区', '35', '22', '2021-02-21 15:24:38');
INSERT INTO `location` VALUES ('127', '68:c6:33:85:21:12', '展示区', '35', '23', '2021-02-21 15:24:41');
INSERT INTO `location` VALUES ('128', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 15:34:37');
INSERT INTO `location` VALUES ('129', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 15:34:38');
INSERT INTO `location` VALUES ('130', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 15:34:39');
INSERT INTO `location` VALUES ('131', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 15:34:42');
INSERT INTO `location` VALUES ('132', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 15:34:43');
INSERT INTO `location` VALUES ('133', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 15:45:24');
INSERT INTO `location` VALUES ('134', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 15:45:25');
INSERT INTO `location` VALUES ('135', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 15:45:28');
INSERT INTO `location` VALUES ('136', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 15:51:11');
INSERT INTO `location` VALUES ('137', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 15:51:12');
INSERT INTO `location` VALUES ('138', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 15:51:13');
INSERT INTO `location` VALUES ('139', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 16:02:32');
INSERT INTO `location` VALUES ('140', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 16:02:32');
INSERT INTO `location` VALUES ('141', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 16:02:33');
INSERT INTO `location` VALUES ('142', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 16:02:34');
INSERT INTO `location` VALUES ('143', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 16:08:37');
INSERT INTO `location` VALUES ('144', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 16:08:37');
INSERT INTO `location` VALUES ('145', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 16:08:38');
INSERT INTO `location` VALUES ('146', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 16:08:39');
INSERT INTO `location` VALUES ('147', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 16:08:42');
INSERT INTO `location` VALUES ('148', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 16:08:43');
INSERT INTO `location` VALUES ('149', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 16:12:20');
INSERT INTO `location` VALUES ('150', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 16:12:21');
INSERT INTO `location` VALUES ('151', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 16:12:24');
INSERT INTO `location` VALUES ('152', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 16:14:31');
INSERT INTO `location` VALUES ('153', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 16:14:48');
INSERT INTO `location` VALUES ('154', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 16:14:49');
INSERT INTO `location` VALUES ('155', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 19:49:42');
INSERT INTO `location` VALUES ('156', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 19:49:42');
INSERT INTO `location` VALUES ('157', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 19:49:43');
INSERT INTO `location` VALUES ('158', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 19:49:44');
INSERT INTO `location` VALUES ('159', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 21:05:05');
INSERT INTO `location` VALUES ('160', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 21:05:06');
INSERT INTO `location` VALUES ('161', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 21:05:06');
INSERT INTO `location` VALUES ('162', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 21:05:07');
INSERT INTO `location` VALUES ('163', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 21:05:07');
INSERT INTO `location` VALUES ('164', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 21:05:10');
INSERT INTO `location` VALUES ('165', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 21:05:11');
INSERT INTO `location` VALUES ('166', '68:c6:33:85:21:12', '销售区', '35', '22', '2021-02-21 21:15:14');
INSERT INTO `location` VALUES ('167', '68:c6:33:85:21:11', '销售区', '35', '22', '2021-02-21 21:15:15');
INSERT INTO `location` VALUES ('168', '68:c6:33:85:21:12', '销售区', '35', '23', '2021-02-21 21:15:19');
INSERT INTO `location` VALUES ('169', '68:c6:33:85:21:11', '销售区', '35', '23', '2021-02-21 21:15:19');
INSERT INTO `location` VALUES ('170', '68:c6:33:85:21:12', '办公区', '35', '22', '2021-02-21 21:34:12');
INSERT INTO `location` VALUES ('171', '68:c6:33:85:21:11', '办公区', '35', '22', '2021-02-21 21:34:13');
INSERT INTO `location` VALUES ('172', '68:c6:33:85:21:12', '办公区', '35', '23', '2021-02-21 21:34:16');
INSERT INTO `location` VALUES ('173', '68:c6:33:85:21:11', '办公区', '35', '23', '2021-02-21 21:34:17');
INSERT INTO `location` VALUES ('174', '68:c6:33:85:21:12', '办公区', '35', '22', '2021-02-21 21:34:34');
INSERT INTO `location` VALUES ('175', '68:c6:33:85:21:12', '办公区', '35', '23', '2021-02-21 22:09:35');
INSERT INTO `location` VALUES ('176', '68:c6:33:85:21:12', '办公区', '35', '22', '2021-02-21 22:09:37');
INSERT INTO `location` VALUES ('177', '68:c6:33:85:21:11', '办公区', '35', '22', '2021-02-21 22:09:37');
INSERT INTO `location` VALUES ('178', '68:c6:33:85:21:12', '办公区', '35', '23', '2021-02-21 22:20:15');
INSERT INTO `location` VALUES ('179', '68:c6:33:85:21:11', '办公区', '35', '23', '2021-02-21 22:20:16');
INSERT INTO `location` VALUES ('180', '68:c6:33:85:21:12', '休息区', '35', '22', '2021-02-21 22:22:03');
INSERT INTO `location` VALUES ('181', '68:c6:33:85:21:11', '休息区', '35', '22', '2021-02-21 22:22:03');
INSERT INTO `location` VALUES ('182', '68:c6:33:85:21:12', '休息区', '36', '22', '2021-02-21 22:26:54');
INSERT INTO `location` VALUES ('183', '68:c6:33:85:21:11', '休息区', '36', '22', '2021-02-21 22:26:54');
INSERT INTO `location` VALUES ('184', '68:c6:33:85:21:12', '休息区', '37', '22', '2021-02-21 22:27:36');
INSERT INTO `location` VALUES ('185', '68:c6:33:85:21:11', '休息区', '37', '22', '2021-02-21 22:27:37');
INSERT INTO `location` VALUES ('186', '68:c6:33:85:21:11', '休息区', '35', '23', '2021-02-21 22:36:47');
INSERT INTO `location` VALUES ('187', '68:c6:33:85:21:12', '休息区', '35', '23', '2021-02-21 22:36:47');
INSERT INTO `location` VALUES ('188', '68:c6:33:85:21:12', '休息区', '35', '22', '2021-02-21 22:36:48');
INSERT INTO `location` VALUES ('189', '68:c6:33:85:21:11', '休息区', '39', '22', '2021-02-21 22:40:01');
INSERT INTO `location` VALUES ('190', '68:c6:33:85:21:12', '休息区', '42', '22', '2021-02-21 22:40:01');
INSERT INTO `location` VALUES ('191', '68:c6:33:85:21:11', '休息区', '44', '22', '2021-02-21 22:40:02');
INSERT INTO `location` VALUES ('192', '68:c6:33:85:21:12', '休息区', '45', '22', '2021-02-21 22:40:02');
INSERT INTO `location` VALUES ('193', '68:c6:33:85:21:11', '销售区', '55', '23', '2021-02-21 22:45:32');
INSERT INTO `location` VALUES ('194', '68:c6:33:85:21:12', '销售区', '55', '23', '2021-02-21 22:45:33');
INSERT INTO `location` VALUES ('195', '68:c6:33:85:21:12', '销售区', '55', '22', '2021-02-21 22:45:33');
INSERT INTO `location` VALUES ('196', '68:c6:33:85:21:11', '销售区', '55', '22', '2021-02-21 22:45:34');
INSERT INTO `location` VALUES ('197', '68:c6:33:85:21:12', '销售区', '55', '22', '2021-02-21 22:45:34');
INSERT INTO `location` VALUES ('198', '68:c6:33:85:21:12', '销售区', '55', '23', '2021-02-21 22:47:10');
INSERT INTO `location` VALUES ('199', '68:c6:33:85:21:11', '销售区', '55', '23', '2021-02-21 23:55:18');
INSERT INTO `location` VALUES ('200', '68:c6:33:85:21:12', '销售区', '55', '22', '2021-02-21 23:55:19');
INSERT INTO `location` VALUES ('201', '68:c6:33:85:21:11', '销售区', '55', '22', '2021-02-21 23:55:20');
INSERT INTO `location` VALUES ('202', '68:c6:33:85:21:11', '办公区', '10', '15', '2021-02-22 00:06:17');
INSERT INTO `location` VALUES ('203', '68:c6:33:85:21:12', '办公区', '10', '15', '2021-02-22 00:06:18');
INSERT INTO `location` VALUES ('204', '68:c6:33:85:21:13', '展示区', '33', '23', '2021-02-22 01:23:27');
INSERT INTO `location` VALUES ('205', '68:c6:33:85:21:14', '展示区', '33', '23', '2021-02-22 01:23:28');
INSERT INTO `location` VALUES ('206', '68:c6:33:85:21:15', '销售区', '55', '20', '2021-02-22 01:48:29');
INSERT INTO `location` VALUES ('207', '68:c6:33:85:21:16', '销售区', '55', '20', '2021-02-22 01:48:29');
INSERT INTO `location` VALUES ('208', '68:c6:33:85:21:15', '销售区', '30', '19', '2021-02-22 01:48:30');
INSERT INTO `location` VALUES ('209', '68:c6:33:85:21:16', '销售区', '55', '19', '2021-02-22 01:48:30');
INSERT INTO `location` VALUES ('210', '68:c6:33:85:21:16', '销售区', '55', '20', '2021-02-22 01:48:31');
INSERT INTO `location` VALUES ('211', '68:c6:33:85:21:15', '销售区', '55', '20', '2021-02-22 01:48:32');
INSERT INTO `location` VALUES ('212', '68:c6:33:85:21:17', '休息区', '50', '8', '2021-02-22 02:09:06');
INSERT INTO `location` VALUES ('213', '68:c6:33:85:21:18', '休息区', '25', '8', '2021-02-22 02:09:06');