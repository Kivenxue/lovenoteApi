/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : lovenote

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 25/04/2021 16:09:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int(10) NOT NULL,
  `startTime` datetime NOT NULL COMMENT '活动时间',
  `endTime` datetime NOT NULL COMMENT '结束时间',
  `join_count` int(11) unsigned zerofill NOT NULL COMMENT '参数人数',
  `img` varchar(150) COLLATE utf8mb4_bin NOT NULL COMMENT '活动图片',
  `title` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '活动标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of activity
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for activity_users
-- ----------------------------
DROP TABLE IF EXISTS `activity_users`;
CREATE TABLE `activity_users` (
  `activity_id` int(10) NOT NULL COMMENT '活动id',
  `users_id` int(10) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`activity_id`,`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of activity_users
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(10) NOT NULL,
  `account` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '登录名',
  `password` varchar(128) COLLATE utf8mb4_bin NOT NULL COMMENT '登录密码',
  `email` varchar(25) COLLATE utf8mb4_bin NOT NULL COMMENT '邮箱地址',
  `avatar` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '管理员头像',
  `role_id` int(10) NOT NULL COMMENT '管理员权限',
  `createdAt` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedAt` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES (1, 'lemon123', '0ghliwg8cdtUhUJfzEpeow==', '1879178791@qq.com', 'https://s2.ax1x.com/2019/05/17/ELAeHO.jpg', 1, '2021-04-16 13:38:00', '2021-04-16 09:58:43');
COMMIT;

-- ----------------------------
-- Table structure for black_list
-- ----------------------------
DROP TABLE IF EXISTS `black_list`;
CREATE TABLE `black_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `createAt` int(10) DEFAULT NULL COMMENT '封禁开始时间',
  `endAt` int(10) DEFAULT NULL COMMENT '封禁结束时间',
  `reason` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '封禁理由',
  `admin_id` int(10) DEFAULT NULL COMMENT '封禁操作员',
  `uid` int(10) DEFAULT NULL COMMENT '封禁用户',
  PRIMARY KEY (`id`),
  KEY `USER_BLACK` (`uid`),
  CONSTRAINT `USER_BLACK` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of black_list
-- ----------------------------
BEGIN;
INSERT INTO `black_list` VALUES (10, 1619155155, 0, '1', 1, 3);
INSERT INTO `black_list` VALUES (22, 1619159557, 0, '1', 1, 7);
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(10) NOT NULL,
  `uid` int(10) NOT NULL COMMENT '用户id',
  `content` longtext COLLATE utf8mb4_bin NOT NULL COMMENT '评论内容',
  `parent_id` int(11) NOT NULL COMMENT '父级id',
  `createTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '发布时间',
  `community_id` int(10) NOT NULL COMMENT '关联的社区帖子评论',
  `activity_id` int(10) NOT NULL COMMENT '关联的活动评论',
  PRIMARY KEY (`id`),
  KEY `COMMENT_ACTIVITY` (`activity_id`),
  KEY `COMMENT_COMMUNITY` (`community_id`),
  CONSTRAINT `COMMENT_ACTIVITY` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `COMMENT_COMMUNITY` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for community
-- ----------------------------
DROP TABLE IF EXISTS `community`;
CREATE TABLE `community` (
  `id` int(10) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT '文章标题',
  `img` varchar(150) COLLATE utf8mb4_bin NOT NULL COMMENT '图片文件夹路径',
  `likes` int(10) NOT NULL COMMENT '收藏数',
  `uid` int(10) NOT NULL COMMENT '用户id',
  `message` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT '用户评论',
  PRIMARY KEY (`id`),
  KEY `COMMUNITY_USERS` (`uid`),
  CONSTRAINT `COMMUNITY_USERS` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of community
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) NOT NULL COMMENT '权限id',
  `name` varchar(25) COLLATE utf8mb4_bin NOT NULL COMMENT '权限名',
  `desc` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT '权限描述',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  `createdAt` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES (4, '超级管理员', '超级管理员', 1, 1616659119);
INSERT INTO `roles` VALUES (7, '社区管理员', '社区管理员', 1, 1616662026);
INSERT INTO `roles` VALUES (8, '用户管理员', '用户管理员', 1, 1616924540);
INSERT INTO `roles` VALUES (9, '评论管理员', '评论管理员', 1, 1616924547);
COMMIT;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(10) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_bin NOT NULL COMMENT '标签名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of tags
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow` (
  `uid` int(10) NOT NULL COMMENT '用户',
  `follow_id` int(10) NOT NULL COMMENT '关注的id',
  PRIMARY KEY (`uid`,`follow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of user_follow
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `account` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(128) COLLATE utf8mb4_bin NOT NULL COMMENT '密码',
  `avatar` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT '头像',
  `nickname` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '昵称',
  `sex` tinyint(1) NOT NULL COMMENT '用户性别',
  `state` tinyint(1) NOT NULL COMMENT '登录状态',
  `loverid` int(10) DEFAULT NULL COMMENT '对方情侣id',
  `pay` double(11,0) unsigned zerofill DEFAULT NULL COMMENT '余额',
  `isvip` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT 'vip',
  `lovetime` datetime DEFAULT NULL COMMENT '恋爱时间',
  `myfollow` int(10) DEFAULT NULL COMMENT '关注id',
  `phone` int(11) NOT NULL COMMENT '手机号',
  PRIMARY KEY (`id`),
  KEY `USER_LOVER` (`loverid`),
  CONSTRAINT `USER_LOVER` FOREIGN KEY (`loverid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (3, 'lemon888', 'qq1879178791', 'https://www.keaidian.com/uploads/allimg/150806/1_150806002240_1.jpg', '降龙十八掌', 1, 0, 4, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (4, 'lemon999', 'qq1879178791', 'https://www.keaidian.com/uploads/allimg/150806/1_150806002259_1.jpg', '降妞十巴掌', 0, 1, 3, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (5, 'lemon23', 'qq1879178791', 'https://www.keaidian.com/uploads/allimg/150806/1_150806002259_1.jpg', '甘霖娘', 1, 0, 6, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (6, 'lemonbb', 'qq1879178791', 'https://www.keaidian.com/uploads/allimg/150806/1_150806002240_1.jpg', '你不要再讲了好不好', 0, 1, 5, NULL, 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (7, '16620740930', 'qq1879178791', 'https://img2.woyaogexing.com/2018/11/13/f75d402f9e9343f69dded7ae5546e606!400x400.jpeg', 'A', 0, 0, 8, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (8, '13107440930', '请求879178791', 'https://img2.woyaogexing.com/2018/11/13/23b62fb3c27545da8d24a3481c013cbd!400x400.jpeg', 'B', 1, 1, 7, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (9, 'woxunsi', 'abcdefg', 'https://img2.woyaogexing.com/2018/11/13/47c9671b0272494ebf29d9006a1a06f8!400x400.jpeg', '例外', 0, 0, 10, NULL, 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (10, 'abcdefg', 'qq1879178791', 'https://img2.woyaogexing.com/2018/11/13/94560203d9684bbba1603f35dfd123e6!400x400.jpeg', '不是例外', 1, 1, 9, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (11, 'ndzt', 'qq1879178791', 'https://img2.woyaogexing.com/2018/11/13/0834b3edf6334c3685539628cd03c1bc!400x400.jpeg', '啊', 0, 0, 12, NULL, 0, NULL, NULL, 0);
INSERT INTO `users` VALUES (12, 'lemonomg', 'qq1879178791', 'https://img2.woyaogexing.com/2018/11/13/73551b032afb4e1d98855b609671b24b!400x400.jpeg', '这', 1, 1, 11, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (13, 'lemon123', 'qq1879178791', 'https://img2.woyaogexing.com/2018/11/13/058111ed2307403d9c9b98b9d816a5fc!400x400.jpeg', '不期', 1, 1, 13, NULL, 1, NULL, NULL, 0);
INSERT INTO `users` VALUES (14, 'lemon456', 'qq1879178791', 'https://img2.woyaogexing.com/2018/11/13/68549378a8fb44c1a59d108fa3d619bd!400x400.jpeg', '不许', 0, 1, 14, NULL, 1, NULL, NULL, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
