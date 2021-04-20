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

 Date: 20/04/2021 09:20:48
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
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
  `loverid` int(10) NOT NULL COMMENT '对方情侣id',
  `pay` double(11,0) unsigned zerofill DEFAULT NULL COMMENT '余额',
  `isvip` tinyint(1) NOT NULL COMMENT 'vip',
  `lovetime` datetime DEFAULT NULL COMMENT '恋爱时间',
  `myfollow` int(10) NOT NULL COMMENT '关注id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
