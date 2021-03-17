/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : za102

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-02-25 22:10:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for device01
-- ----------------------------
DROP TABLE IF EXISTS `device01`;
CREATE TABLE `device01` (
  `deviceid` int(11) NOT NULL AUTO_INCREMENT,
  `devicename` varchar(255) DEFAULT NULL,
  `id` varchar(255) DEFAULT NULL,
  `devicetype` varchar(255) DEFAULT NULL,
  `devicevalue` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `lasttime` varchar(255) DEFAULT NULL,
  `gentime` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  PRIMARY KEY (`deviceid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of device01
-- ----------------------------
INSERT INTO `device01` VALUES ('2', '报警器1', '9624478', '5', '0', '休息区', '1614123940', '2021-02-24 07:45:40', 'oIhmL5Z5bGab47IKgq54ZEFWuDY4', '192.168.1.105', '8080');
INSERT INTO `device01` VALUES ('3', '报警器2', '9624474', '5', '0', '办公区', '1614231844', '2021-02-25 13:44:04', 'oIhmL5Y8KSswcYJhroLc09U-23hA', '192.168.1.105', '8080');
INSERT INTO `device01` VALUES ('6', '灯1', '9624444', '6', '0', '展示区', '1614231926', '2021-02-25 13:45:26', 'oIhmL5Y8KSswcYJhroLc09U-23hA', '192.168.1.105', '8080');
INSERT INTO `device01` VALUES ('7', '灯2', '9624475', '6', '0', '销售区', '1614231927', '2021-02-25 13:45:27', 'oIhmL5Y8KSswcYJhroLc09U-23hA', '192.168.1.105', '8080');
INSERT INTO `device01` VALUES ('8', '灯3', '9624476', '6', '0', '休息区', '1614231927', '2021-02-25 13:45:27', 'oIhmL5Y8KSswcYJhroLc09U-23hA', '192.168.1.105', '8080');