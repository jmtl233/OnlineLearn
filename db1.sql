/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : db1

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 16/05/2025 16:56:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for applicant
-- ----------------------------
DROP TABLE IF EXISTS `applicant`;
CREATE TABLE `applicant`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '学生申请加入班级表',
  `user_id` int(11) NOT NULL COMMENT '学生id',
  `class_id` int(11) NOT NULL COMMENT '班级id',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态（1：待审核；2：成功；3：失败）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of applicant
-- ----------------------------
INSERT INTO `applicant` VALUES (2, 26, 5, 2, '2025-02-14 00:48:06');
INSERT INTO `applicant` VALUES (3, 27, 7, 3, '2025-04-13 17:09:25');
INSERT INTO `applicant` VALUES (4, 29, 5, 2, '2025-04-13 17:11:41');
INSERT INTO `applicant` VALUES (5, 30, 7, 2, '2025-04-13 17:13:26');
INSERT INTO `applicant` VALUES (6, 31, 7, 2, '2025-04-16 10:43:43');
INSERT INTO `applicant` VALUES (7, 33, 7, 2, '2025-04-16 15:27:03');
INSERT INTO `applicant` VALUES (8, 34, 7, 2, '2025-04-16 15:35:25');
INSERT INTO `applicant` VALUES (9, 36, 7, 3, '2025-04-17 18:05:46');
INSERT INTO `applicant` VALUES (10, 36, 7, 3, '2025-04-17 19:18:15');
INSERT INTO `applicant` VALUES (11, 36, 7, 3, '2025-04-17 19:47:47');
INSERT INTO `applicant` VALUES (12, 36, 7, 3, '2025-04-17 19:52:52');
INSERT INTO `applicant` VALUES (13, 36, 7, 2, '2025-04-17 19:53:16');
INSERT INTO `applicant` VALUES (14, 37, 7, 3, '2025-04-17 19:56:03');
INSERT INTO `applicant` VALUES (15, 37, 7, 2, '2025-04-17 19:56:30');
INSERT INTO `applicant` VALUES (16, 37, 7, 1, '2025-04-17 19:56:30');

-- ----------------------------
-- Table structure for ask_questions
-- ----------------------------
DROP TABLE IF EXISTS `ask_questions`;
CREATE TABLE `ask_questions`  (
  `id` int(11) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT '问题ID',
  `sender` int(11) NULL DEFAULT NULL COMMENT '发送人ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `recipient` int(11) NULL DEFAULT NULL COMMENT '接收人ID',
  `video_id` int(11) NULL DEFAULT NULL COMMENT '视频ID',
  `restore` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复',
  `status` int(11) NOT NULL DEFAULT 2 COMMENT '状态（1：已回复；2：未回复）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ask_questions
-- ----------------------------
INSERT INTO `ask_questions` VALUES (00000000005, 19, '好绕，for跟while什么时候用好？', 18, 11, NULL, 2, '2025-02-13 13:34:26');
INSERT INTO `ask_questions` VALUES (00000000004, 19, '这么多数据类型，有什么记忆的技巧啊？', 18, 11, '多写代码自然就能记住，前期不用特别刻意背诵', 1, '2025-02-13 13:26:36');
INSERT INTO `ask_questions` VALUES (00000000006, 19, '为什么啊为什么啊', 18, 11, '11111', 1, '2025-04-13 17:05:56');
INSERT INTO `ask_questions` VALUES (00000000007, 30, 'python怎么学啊', 28, 11, '课上紧跟老师节奏，课下练习', 1, '2025-04-15 20:57:41');
INSERT INTO `ask_questions` VALUES (00000000008, 31, '怎么学?/', 28, 18, NULL, 2, '2025-04-16 10:44:30');
INSERT INTO `ask_questions` VALUES (00000000009, 31, '老师，不太懂为什么这样啊，linux怎么学啊', 28, 18, NULL, 2, '2025-04-16 10:46:47');
INSERT INTO `ask_questions` VALUES (00000000010, 30, 'Python老师可以讲详细点吗', 28, 16, NULL, 2, '2025-04-16 10:49:31');
INSERT INTO `ask_questions` VALUES (00000000011, 30, '老师，pyhton学不明白', 28, 16, '按时作业', 1, '2025-04-16 15:31:19');
INSERT INTO `ask_questions` VALUES (00000000012, 30, '老师，讲的太快', 28, 16, '好的下次注意', 1, '2025-04-16 15:40:52');
INSERT INTO `ask_questions` VALUES (00000000013, 30, '哈啊', 28, 16, NULL, 2, '2025-04-16 19:36:12');
INSERT INTO `ask_questions` VALUES (00000000014, 30, '很好', 28, 17, NULL, 2, '2025-04-16 19:36:27');
INSERT INTO `ask_questions` VALUES (00000000015, 30, '不会Python老师可以再讲一下吧', 28, 16, NULL, 2, '2025-04-25 21:01:05');
INSERT INTO `ask_questions` VALUES (00000000016, 30, '不冻港', 28, 23, NULL, 2, '2025-04-30 12:21:29');
INSERT INTO `ask_questions` VALUES (00000000017, 30, '我不懂啊', 28, 26, '好算了', 1, '2025-05-08 23:58:28');
INSERT INTO `ask_questions` VALUES (00000000018, 30, 'Hadoop好难学哦', 28, 26, NULL, 2, '2025-05-16 15:00:24');
INSERT INTO `ask_questions` VALUES (00000000019, 30, 'Hadoop的优点还可以总结的更详细点吗？', 28, 26, '可以 Hadoop的优点有很多', 1, '2025-05-16 15:01:09');

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级ID',
  `class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级名称',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '班级负责人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '班级创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES (7, '软件工程3班', 28, '2025-01-10 12:06:39');
INSERT INTO `class` VALUES (6, '软件工程2班', 20, '2025-02-01 12:06:36');
INSERT INTO `class` VALUES (5, '软件工程1班', 18, '2025-02-13 12:06:32');

-- ----------------------------
-- Table structure for exercises
-- ----------------------------
DROP TABLE IF EXISTS `exercises`;
CREATE TABLE `exercises`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '练习题ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '题目',
  `answer` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参考答案',
  `creator` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `class_id` int(11) NULL DEFAULT NULL COMMENT '所属班级ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exercises
-- ----------------------------
INSERT INTO `exercises` VALUES (4, '计算圆的面积', '编写一个Java程序，根据给定的圆的半径，计算并输出圆的面积。\r\n\r\n输入：一个正整数，表示圆的半径。\r\n\r\n输出：一个浮点数，表示圆的面积，保留两位小数。\r\n\r\n注意：\r\n\r\n圆的面积公式为：面积 = π * 半径 * 半径\r\n可以使用Math类提供的PI常量来表示π，即Math.PI\r\n示例：\r\n\r\n输入： 5\r\n\r\n输出： 78.54\r\n\r\n--------------------\r\n\r\n请作答：\r\n', 'import java.util.Scanner;\n\npublic class CircleArea {\n    public static void main(String[] args) {\n        // 读取输入\n        Scanner scanner = new Scanner(System.in);\n        int radius = scanner.nextInt();\n\n        // 计算面积\n        double area = Math.PI * radius * radius;\n\n        // 输出结果\n        System.out.printf(\"%.2f\\n\", area);\n    }\n}', 18, 5, '2025-02-01 00:10:13');
INSERT INTO `exercises` VALUES (13, 'test', '[{\"id\":1746547359311,\"type\":\"single_choice\",\"content\":\"1+1？\",\"answer\":\"A\",\"score\":10,\"options\":[\"2\",\"3\",\"4\",\"5\"]},{\"id\":1746547376324,\"type\":\"multiple_choice\",\"content\":\"2+3？\",\"answer\":[\"A\",\"B\"],\"score\":10,\"options\":[\"1+4\",\"0+5\",\"3+3\",\"6+6\"]},{\"id\":1746547493440,\"type\":\"blank\",\"content\":\"8+8？\",\"answer\":\"16\",\"score\":10},{\"id\":1746547509304,\"type\":\"essay\",\"content\":\"0*x？\",\"answer\":\"0*任何数等于0\",\"score\":10}]', '答案已存储在questions结构中', 28, 7, '2025-05-07 00:05:25');
INSERT INTO `exercises` VALUES (23, '阿帆', '## 题目 1：(选择题)\n\n1+1\n\nA. 2\nB. 3\nC. 4\nD. 4\n## 题目 2：(填空题)\n\n3\n\n## 题目 3：(问答题)\n\n沙发上\n\n', '## 题目 1 答案：\n\nA\n\n## 题目 2 答案：\n\n3\n\n## 题目 3 答案：\n\n热啊\n\n', 28, 7, '2025-05-08 23:57:11');
INSERT INTO `exercises` VALUES (22, 'three', '## 题目 1：(选择题)\n\n2+2\n\nA. 1\nB. 4\nC. 2\nD. 5\n## 题目 2：(填空题)\n\n6+6\n\n## 题目 3：(问答题)\n\n0+0？\n\n', '## 题目 1 答案：\n\nB\n\n## 题目 2 答案：\n\n12\n\n## 题目 3 答案：\n\n0！\n\n', 28, 7, '2025-05-07 18:41:09');
INSERT INTO `exercises` VALUES (20, 'one', '', '', 28, 7, '2025-05-07 16:02:01');
INSERT INTO `exercises` VALUES (21, 'text', '## 题目 1：(选择题)\n\n1+1\n\nA. 2\nB. 3\nC. 4\nD. 1\n## 题目 2：(填空题)\n\n2+2\n\n## 题目 3：(问答题)\n\n0+x？\n\n', '## 题目 1 答案：\n\nA\n\n## 题目 2 答案：\n\n4\n\n## 题目 3 答案：\n\n0+x为x\n\n', 28, 7, '2025-05-07 16:10:27');

-- ----------------------------
-- Table structure for homework
-- ----------------------------
DROP TABLE IF EXISTS `homework`;
CREATE TABLE `homework`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '练习题ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '题目',
  `answer` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参考答案',
  `creator` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `class_id` int(11) NULL DEFAULT NULL COMMENT '所属班级ID',
  `commit_time` date NULL DEFAULT NULL COMMENT '提交时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of homework
-- ----------------------------
INSERT INTO `homework` VALUES (4, '判断素数', '题目描述：编写一个Java程序，判断一个正整数是否为素数。\r\n\r\n输入：一个正整数。\r\n\r\n输出：如果输入的数是素数，则输出\"是素数\"；如果输入的数不是素数，则输出\"不是素数\"。\r\n\r\n注意：\r\n\r\n素数是指除了1和自身之外没有其他因数的数。\r\n1不是素数。\r\n示例：\r\n\r\n输入： 17\r\n\r\n输出： 是素数\r\n\r\n输入： 8\r\n\r\n输出： 不是素数\r\n\r\n--------------------\r\n\r\n请作答：\r\n', 'import java.util.Scanner;\n\npublic class PrimeNumber {\n    public static void main(String[] args) {\n        // 读取输入\n        Scanner scanner = new Scanner(System.in);\n        int number = scanner.nextInt();\n\n        // 判断素数\n        boolean isPrime = true;\n        if (number <= 1) {\n            isPrime = false;\n        } else {\n            for (int i = 2; i <= Math.sqrt(number); i++) {\n                if (number % i == 0) {\n                    isPrime = false;\n                    break;\n                }\n            }\n        }\n        \n        // 输出结果\n        if (isPrime) {\n            System.out.println(\"是素数\");\n        } else {\n            System.out.println(\"不是素数\");\n        }\n    }\n}', 18, 5, '2025-02-10', '2024-02-14 00:12:20');
INSERT INTO `homework` VALUES (6, 'Python练习题', 'for i in range(1,10):\n    for j in range(1,i+1):\n        print(\'%d*%d=%2ld \'%(i,j,i*j),end=\'\')\n    print()\n', 'for i in range(1,10):\n    for j in range(1,i+1):\n        print(\'%d*%d=%2ld \'%(i,j,i*j),end=\'\')\n    print()\n', 28, 7, '2025-04-16', '2025-04-16 10:33:33');
INSERT INTO `homework` VALUES (8, 'test', '## 题目 1：(问答题)\n\n1+1？\n\n', '## 题目 1 答案：\n\n2\n\n', 28, 7, '2025-05-06', '2025-05-05 19:04:46');

-- ----------------------------
-- Table structure for knowledge_point
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_point`;
CREATE TABLE `knowledge_point`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '知识点ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '知识点标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '知识点内容',
  `creator` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `class_id` int(11) NULL DEFAULT NULL COMMENT '所属班级ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge_point
-- ----------------------------
INSERT INTO `knowledge_point` VALUES (4, 'Java基础知识总结', 'Java是一门广泛应用于软件开发的高级编程语言。它具有跨平台、面向对象、简单易学等特点，以下是Java基础知识的总结：\n数据类型：Java提供了八种基本数据类型，包括整型、浮点型、字符型、布尔型，以及引用数据类型如字符串。\n变量与常量：变量用于存储数据，并且可被修改，而常量是不可变的。在Java中，变量和常量需声明后才能使用。\n控制流程：Java支持使用if-else、switch、for、while等语句实现控制流程，以根据条件执行特定的代码块。\n数组与集合：数组是存储多个相同类型元素的数据结构，而集合是基于抽象数据类型的类，提供了更多的操作方法。\n面向对象：Java是面向对象的编程语言，使用类和对象的概念进行编程。类是对象的模板，对象是类的实例。\n封装与继承：封装将数据和方法封装在类中，通过访问修饰符进行访问控制。继承允许一个类继承另一个类的属性和方法。\n多态性：Java支持多态性，即同一方法可以有不同的行为。通过方法重写（Override）和方法重载（Overload）实现多态。\n异常处理：Java提供了异常处理机制来处理运行时错误。通过try-catch语句块捕获异常，以避免程序崩溃。\n输入输出：Java的输入输出操作通过输入流（InputStream）和输出流（OutputStream）来进行，可以读取和写入不同的数据源。\n线程与并发：Java内置了对多线程编程的支持，可以创建和管理多个线程，并通过同步机制实现线程间的协调与通信。\nJava基础知识总结涵盖了Java的核心概念和特性，对于初学者来说，这些知识是构建更复杂程序的基础。通过不断学习和实践，可以深入掌握Java编程，并运用于实际项目中。', 18, 5, '2025-02-13 18:19:51');
INSERT INTO `knowledge_point` VALUES (5, 'Python怎么学', '学习Python主体最好的参考书是Learning Python，它非常全面，满满的都是干货。虽然很厚，读起来并不难读。另一个是参考官网的教程Python.org\n阶段一：前辈领进门。第一眼是一个前辈给我看了看Python的代码，因为自己最早学习的是Java语言，第一眼看到Python的时候，前辈说，“Python是面向对象的”，然后就 打印了几句代码。可我怎么也看不出到底哪里是“面向对象”的。前辈说“在Python里，一切皆对象”，我才有点领悟的说道：“原来把什么看成对象，就是面向对象”，哈哈。\n阶段二：开始看的是《Dive into Python》、《Leaning python》、《Python Doc》。因为有很多语言学习经历，很快就完成了初步语法和使用学习。太复杂的特性还是在使用中逐步掌握的。', 28, 7, '2025-04-16 10:22:38');
INSERT INTO `knowledge_point` VALUES (6, '再识fork函数', '在 Linux中 fork 函数是非常重要的函数，它从已存在进程中创建⼀个新进程。创建出来的新进程叫做子进程，而原进程则称为父进程。', 28, 7, '2025-04-16 10:23:59');
INSERT INTO `knowledge_point` VALUES (7, '1+1？', '因为', 28, 7, '2025-04-16 15:47:33');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'admin', '系统管理员');
INSERT INTO `role` VALUES (2, 'teacher', '教师');
INSERT INTO `role` VALUES (3, 'student', '学生');

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '科目ID',
  `subject_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科目名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES (19, '计算机科学与技术');
INSERT INTO `subject` VALUES (18, '软件工程');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户主键',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '123456' COMMENT '用户密码',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `sex` int(11) NULL DEFAULT NULL COMMENT '性别（0：男；1：女）',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人描述',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', '管理员', '13544441111', 0, '系统管理员', '2025-04-01 00:24:42');
INSERT INTO `user` VALUES (20, 't2', '123456', '李四', '19877777777', 1, NULL, '2025-04-01 19:54:03');
INSERT INTO `user` VALUES (19, 's1', '123456', '陈小明', '13544444444', 0, NULL, '2025-04-13 12:08:18');
INSERT INTO `user` VALUES (18, 't1', '123456', '张三', '15544444444', 0, NULL, '2025-04-01 12:07:43');
INSERT INTO `user` VALUES (26, 's2', '123456', '张小红', '17711111111', 1, NULL, '2025-04-01 00:46:34');
INSERT INTO `user` VALUES (30, 'hdd', '1', 'hdd', '18888888888', 0, NULL, '2025-04-13 17:13:18');
INSERT INTO `user` VALUES (28, 'teacher3', '123456', '刘晓燕', '12222222222', 0, NULL, '2025-04-13 17:10:14');
INSERT INTO `user` VALUES (29, 'tom', '1', 'tom', '12222222222', 1, NULL, '2025-04-13 17:11:10');
INSERT INTO `user` VALUES (31, 'jh', '1', 'jh', '19999999999', 1, NULL, '2025-04-16 10:43:16');
INSERT INTO `user` VALUES (32, 'll', '1', 'll', '11111111111', 0, NULL, '2025-04-16 15:26:16');
INSERT INTO `user` VALUES (33, 'll', '1', 'll', '11111111111', 0, NULL, '2025-04-16 15:26:16');
INSERT INTO `user` VALUES (34, 'day', '1', 'day', '12222222222', 0, NULL, '2025-04-16 15:34:04');
INSERT INTO `user` VALUES (35, 'teacher4', '123456', 'Bob', '11111111111', 1, NULL, '2025-04-16 15:49:50');
INSERT INTO `user` VALUES (36, 'jack', '1', 'Jack', '15555555555', 0, NULL, '2025-04-17 17:59:39');
INSERT INTO `user` VALUES (37, 'candy', '1', 'candy', '17777777777', 1, NULL, '2025-04-17 19:55:31');

-- ----------------------------
-- Table structure for user_class
-- ----------------------------
DROP TABLE IF EXISTS `user_class`;
CREATE TABLE `user_class`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户与班级中间表id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `class_id` int(11) NOT NULL COMMENT '班级id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of user_class
-- ----------------------------
INSERT INTO `user_class` VALUES (23, 20, 5);
INSERT INTO `user_class` VALUES (21, 19, 5);
INSERT INTO `user_class` VALUES (20, 18, 5);
INSERT INTO `user_class` VALUES (25, 26, 5);
INSERT INTO `user_class` VALUES (33, 28, 7);
INSERT INTO `user_class` VALUES (27, 29, 5);
INSERT INTO `user_class` VALUES (32, 30, 7);
INSERT INTO `user_class` VALUES (34, 31, 7);
INSERT INTO `user_class` VALUES (35, 33, 7);
INSERT INTO `user_class` VALUES (36, 34, 7);
INSERT INTO `user_class` VALUES (37, 35, 6);
INSERT INTO `user_class` VALUES (38, 36, 7);

-- ----------------------------
-- Table structure for user_do_exercise
-- ----------------------------
DROP TABLE IF EXISTS `user_do_exercise`;
CREATE TABLE `user_do_exercise`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '练习题回答ID',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '回答人ID',
  `exercise_id` int(11) NULL DEFAULT NULL COMMENT '练习题ID',
  `reply` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '答案',
  `score` int(11) NULL DEFAULT NULL COMMENT '分数',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_do_exercise
-- ----------------------------
INSERT INTO `user_do_exercise` VALUES (4, 19, 4, '编写一个Java程序，根据给定的圆的半径，计算并输出圆的面积。\r\n\r\n输入：一个正整数，表示圆的半径。\r\n\r\n输出：一个浮点数，表示圆的面积，保留两位小数。\r\n\r\n注意：\r\n\r\n圆的面积公式为：面积 = π * 半径 * 半径\r\n可以使用Math类提供的PI常量来表示π，即Math.PI\r\n示例：\r\n\r\n输入： 5\r\n\r\n输出： 78.54\r\n\r\n--------------------\r\n\r\n请作答：\r\n不会', 75, '2025-03-01 00:29:22');
INSERT INTO `user_do_exercise` VALUES (6, 30, 7, '2', 10, '2025-04-16 15:38:56');
INSERT INTO `user_do_exercise` VALUES (12, 30, 13, '{}', NULL, '2025-05-07 00:59:39');
INSERT INTO `user_do_exercise` VALUES (18, 30, 21, '# 学生答案\n\n## 题目1\n**学生答案**: A\n\n## 题目2\n**学生答案**: 未作答\n\n## 题目3\n**学生答案**: 未作答\n\n', NULL, '2025-05-07 18:39:58');

-- ----------------------------
-- Table structure for user_do_homework
-- ----------------------------
DROP TABLE IF EXISTS `user_do_homework`;
CREATE TABLE `user_do_homework`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '作业回答ID',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '回答人ID',
  `homework_id` int(11) NULL DEFAULT NULL COMMENT '作业ID',
  `reply` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '答案',
  `completion_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  `mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT 0,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_do_homework
-- ----------------------------
INSERT INTO `user_do_homework` VALUES (3, 30, 6, 'for i in range(1,10):\n    for j in range(1,i+1):\n        print(\'%d*%d=%2ld \'%(i,j,i*j),end=\'\')\n    print()\n', '2025-04-16 10:50:43', '1', 10, NULL);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户角色中间表ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (20, 2, 20);
INSERT INTO `user_role` VALUES (19, 3, 19);
INSERT INTO `user_role` VALUES (18, 2, 18);
INSERT INTO `user_role` VALUES (26, 3, 27);
INSERT INTO `user_role` VALUES (30, 3, 31);
INSERT INTO `user_role` VALUES (28, 2, 29);
INSERT INTO `user_role` VALUES (29, 3, 30);
INSERT INTO `user_role` VALUES (31, 3, 32);
INSERT INTO `user_role` VALUES (33, 3, 33);
INSERT INTO `user_role` VALUES (32, 3, 34);
INSERT INTO `user_role` VALUES (34, 3, 35);
INSERT INTO `user_role` VALUES (35, 2, 36);
INSERT INTO `user_role` VALUES (36, 3, 37);
INSERT INTO `user_role` VALUES (37, 3, 38);

-- ----------------------------
-- Table structure for user_subject
-- ----------------------------
DROP TABLE IF EXISTS `user_subject`;
CREATE TABLE `user_subject`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '科目与班级中间表id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `subject_id` int(11) NOT NULL COMMENT '科目id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of user_subject
-- ----------------------------
INSERT INTO `user_subject` VALUES (10, 20, 19);
INSERT INTO `user_subject` VALUES (8, 18, 18);
INSERT INTO `user_subject` VALUES (16, 28, 19);
INSERT INTO `user_subject` VALUES (17, 35, 18);

-- ----------------------------
-- Table structure for video_total
-- ----------------------------
DROP TABLE IF EXISTS `video_total`;
CREATE TABLE `video_total`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '视频总体id',
  `topic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主题名称',
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面路径',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存储路径',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '上传人ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of video_total
-- ----------------------------
INSERT INTO `video_total` VALUES (11, 'Java程序设计', '/file/imageFile/1707798300323.jpg', 'D:/OnlineLearnApi - idea/file/imageFile/1707798300323.jpg', 18, '2024-02-13 12:16:31');
INSERT INTO `video_total` VALUES (12, '兔兔科技全栈开发教程', '/file/imageFile/logo1.jpg', 'D:/OnlineLearnApi - idea/file/imageFile/logo1.jpg', 18, '2024-02-13 12:27:04');
INSERT INTO `video_total` VALUES (13, '电影学', '/file/imageFile/170780085743801.jpg', 'D:/OnlineLearnApi - idea/file/imageFile/170780085743801.jpg', 18, '2024-02-13 13:07:37');
INSERT INTO `video_total` VALUES (14, '宠物护理常识', '/file/imageFile/170780122579702.jpg', 'D:/OnlineLearnApi - idea/file/imageFile/170780122579702.jpg', 18, '2024-02-13 13:13:45');
INSERT INTO `video_total` VALUES (15, '西方服饰研讨', '/file/imageFile/170780128806703.jpg', 'D:/OnlineLearnApi - idea/file/imageFile/170780128806703.jpg', 18, '2024-02-13 13:14:48');
INSERT INTO `video_total` VALUES (26, 'Hadoop', '/file/imageFile/1745996342853hadoop.jpg', 'E:/OnlineLearn/OnlineLearnApi - idea/file/imageFile/1745996342853hadoop.jpg', 28, '2025-04-30 14:59:03');
INSERT INTO `video_total` VALUES (25, 'Python', '/file/imageFile/1745996330354python.jpg', 'E:/OnlineLearn/OnlineLearnApi - idea/file/imageFile/1745996330354python.jpg', 28, '2025-04-30 14:58:50');
INSERT INTO `video_total` VALUES (24, '123', '/file/imageFile/1745996214090t-java.jpg', 'E:/OnlineLearn/OnlineLearnApi - idea/file/imageFile/1745996214090t-java.jpg', 28, '2025-04-30 14:56:54');

-- ----------------------------
-- Table structure for videos
-- ----------------------------
DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '视频总体id',
  `topic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视频名称',
  `video_total_id` int(11) NULL DEFAULT NULL COMMENT '视频总和ID',
  `video_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视频访问路径',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视频存储路径',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序（可用第几集排序）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of videos
-- ----------------------------
INSERT INTO `videos` VALUES (6, '01 Java基本数据类型', 11, '/file/videoFile/1707800560331ce 2.mp4', 'D:/OnlineLearnApi - idea/file/videoFile/1707800560331ce 2.mp4', 0);
INSERT INTO `videos` VALUES (7, '02 Java常用开发工具简介与安装教程', 11, '/file/videoFile/1707800560331ce 2.mp4', 'D:/OnlineLearnApi - idea/file/videoFile/1707800560331ce 2.mp4', 1);
INSERT INTO `videos` VALUES (8, '03 for循环和while循环', 11, '/file/videoFile/1707800560331ce 2.mp4', 'D:/OnlineLearnApi - idea/file/videoFile/1707800560331ce 2.mp4', 2);
INSERT INTO `videos` VALUES (10, '01 全栈开发定义', 12, '/file/videoFile/1707800560331ce 2.mp4', 'D:/OnlineLearnApi - idea/file/videoFile/1707800560331ce 2.mp4', 0);
INSERT INTO `videos` VALUES (9, '04 什么是面向对象', 11, '/file/videoFile/1707800560331ce 2.mp4', 'D:/OnlineLearnApi - idea/file/videoFile/1707800560331ce 2.mp4', 3);
INSERT INTO `videos` VALUES (24, 'Hadoop实战', 26, '/file/videoFile/17473786825453.mp4', 'E:/OnlineLearn/OnlineLearnApi - idea/file/videoFile/17473786825453.mp4', 2);
INSERT INTO `videos` VALUES (22, '什么是Hadoop？', 26, '/file/videoFile/17473786358391.mp4', 'E:/OnlineLearn/OnlineLearnApi - idea/file/videoFile/17473786358391.mp4', 0);
INSERT INTO `videos` VALUES (23, 'Hadoop的优点', 26, '/file/videoFile/17473786634452.mp4', 'E:/OnlineLearn/OnlineLearnApi - idea/file/videoFile/17473786634452.mp4', 1);
INSERT INTO `videos` VALUES (25, '认识python', 25, '/file/videoFile/17473787137484.mp4', 'E:/OnlineLearn/OnlineLearnApi - idea/file/videoFile/17473787137484.mp4', 0);
INSERT INTO `videos` VALUES (26, 'python实战', 25, '/file/videoFile/17473787309175.mp4', 'E:/OnlineLearn/OnlineLearnApi - idea/file/videoFile/17473787309175.mp4', 1);
INSERT INTO `videos` VALUES (27, 'java学什么？', 24, '/file/videoFile/17473787481915.mp4', 'E:/OnlineLearn/OnlineLearnApi - idea/file/videoFile/17473787481915.mp4', 0);

SET FOREIGN_KEY_CHECKS = 1;
