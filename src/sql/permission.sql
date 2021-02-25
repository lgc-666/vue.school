/*
Navicat MySQL Data Transfer

Source Server         : Single
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : za102

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-02-25 22:11:47
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '/', '/home', 'Home', '权限管理', 'fa fa-address-card-o', null, '1', null, '1');
INSERT INTO `permission` VALUES ('2', '/', '/home', 'Home', '设备管理', 'fa fa-user-circle-o', null, '1', null, '1');
INSERT INTO `permission` VALUES ('3', '/', '/home', 'Home', '区域管理', 'fa fa-bar-chart', null, '1', null, '1');
INSERT INTO `permission` VALUES ('4', 'listUser,updatePassword,updateUser,listUserSearch', '/account', 'Account', '账号管理', '', null, '1', '1', '1');
INSERT INTO `permission` VALUES ('5', 'listRole,editRole,updateRolePermission', '/role', 'Role', '访问授权', '', null, '1', '1', '1');
INSERT INTO `permission` VALUES ('6', 'listregisterApproval,agreeregisterApproval,deleteregisterApproval', '/registerapproval', 'RegisterApproval', '注册审批', null, null, '1', '1', '1');
INSERT INTO `permission` VALUES ('7', 'listmachine,addmachine,deletemachine,updatemachine,listmachineSearch', '/machine', 'Machine', '探针设备', null, null, '1', '2', '1');
INSERT INTO `permission` VALUES ('8', 'listClass,addClass,deleteClass,updateClass,listClassSearch', '/class', 'Class', '室内区域划分', null, null, '1', '3', '1');
INSERT INTO `permission` VALUES ('9', 'listVisit,addVisit,deleteVisit,updateVisit,listVisitSearch', '/visit', 'Visit', '普通区域访问统计', null, null, '1', '3', '1');
INSERT INTO `permission` VALUES ('10', 'listStopVisit,addStopVisit,deleteStopVisit,updateStopVisit,doStopVisit,listStopVisitSearch', '/stopvisit', 'StopVisit', '禁止区域访问统计', null, null, '1', '3', '1');
INSERT INTO `permission` VALUES ('11', 'getDBlocation,getDBlocationNotRepeat,listByMac', '/home', 'Home', '室内地图', 'fa fa-address-card-o', null, '1', null, '1');
INSERT INTO `permission` VALUES ('12', 'listDevice,addDevice,deleteDevice,updateDevice,updateStatus,listDeviceSearch', '/device', 'Device', '硬件设备', null, null, '1', '2', '1');
INSERT INTO `permission` VALUES ('13', 'listLogrecord,addLogrecord,deleteLogrecord,updateLogrecord,listLogrecordSearch', '/logrecord', 'Logrecord', '硬件设备操作日志', null, null, '1', '2', '1');
INSERT INTO `permission` VALUES ('14', 'listClassNoPage,getInCustomerPerHour,getCustomerPerHour,getMainData', '/data', 'Data', '数据分析', null, null, '1', '11', '1');
INSERT INTO `permission` VALUES ('15', 'getSum,getMainData,getCustomerPerHour,getInCustomerPerHour', '/administrators', 'Administrators', '百度地图', null, null, '1', '11', '1');
INSERT INTO `permission` VALUES ('20', 'sortVisit,listClassNoPage,sortStoptime,sortNow', '/classdata', 'ClassData', '区域数据统计', null, null, '1', '3', '1');
