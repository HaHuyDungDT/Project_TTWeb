/*
 Navicat Premium Dump SQL

 Source Server         : MyConnection
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : doanlaptrinhweb

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 25/03/2025 15:38:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart_items
-- ----------------------------
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE `cart_items`  (
                               `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                               `cart_id` int NOT NULL,
                               `product_id` int NOT NULL,
                               `quantity` int NOT NULL,
                               PRIMARY KEY (`id`) USING BTREE,
                               INDEX `cart_items_carts_id_fk`(`cart_id` ASC) USING BTREE,
                               INDEX `cart_items_products_id_fk`(`product_id` ASC) USING BTREE,
                               CONSTRAINT `cart_items_carts_id_fk` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                               CONSTRAINT `cart_items_products_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart_items
-- ----------------------------

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `user_id` int NOT NULL,
                          PRIMARY KEY (`id`) USING BTREE,
                          INDEX `carts_users_id_fk`(`user_id` ASC) USING BTREE,
                          CONSTRAINT `carts_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carts
-- ----------------------------

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`  (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                           `percent_discount` int NOT NULL,
                           `date_start` datetime NOT NULL,
                           `date_end` datetime NOT NULL,
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of coupon
-- ----------------------------
INSERT INTO `coupon` VALUES (1, 'PAADAPTERSAC50', 50, '2024-06-16 07:48:33', '2024-07-08 23:30:18');
INSERT INTO `coupon` VALUES (2, 'PATAINGHE60', 60, '2024-06-16 14:26:38', '2024-06-28 03:15:54');
INSERT INTO `coupon` VALUES (3, 'PALOA30', 30, '2024-06-16 19:44:15', '2024-06-30 01:29:25');
INSERT INTO `coupon` VALUES (4, 'PASACDUPHONG60', 60, '2024-06-16 23:07:17', '2024-07-01 17:55:56');
INSERT INTO `coupon` VALUES (5, 'PACAP40', 40, '2024-06-16 21:32:51', '2024-06-30 17:39:45');
INSERT INTO `coupon` VALUES (6, 'PAOPLUNG50', 50, '2024-06-16 20:54:04', '2024-06-25 03:45:19');

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `link_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                           `product_id` int NULL DEFAULT NULL,
                           PRIMARY KEY (`id`) USING BTREE,
                           INDEX `images_products_id_fk`(`product_id` ASC) USING BTREE,
                           CONSTRAINT `images_products_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES (1, './img/Anker/Adapter_capsac/Adapter Sạc Type C PD GaN 30W Anker Nano 3 A2147.jpg', 1);
INSERT INTO `images` VALUES (2, './img/Anker/Tai_Nghe/Tai Nghe Bluetooth True Wireless Anker SoundCore Liberty 2 Pro A3909.jpg', 10);
INSERT INTO `images` VALUES (3, './img/Sony/Loa/Loa Bluetooth Sony SRS-XP500.jpg', 101);
INSERT INTO `images` VALUES (4, './img/Sony/Loa/Loa thanh Sony HT-S100F 120W.jpg', 102);
INSERT INTO `images` VALUES (5, './img/Sony/Tai_Nghe/Tai nghe Bluetooth True Wireless Sony WF-C500.jpeg', 103);
INSERT INTO `images` VALUES (6, './img/Sony/Tai_Nghe/Tai nghe Bluetooth True Wireless Sony WF-C700N.jpg', 104);
INSERT INTO `images` VALUES (7, './img/Sony/Tai_Nghe/Tai nghe Chụp Tai Sony MDR - ZX110AP.jpg', 105);
INSERT INTO `images` VALUES (8, './img/Sony/Tai_Nghe/Tai nghe Có Dây Sony MDR-EX15AP.jpg', 106);
INSERT INTO `images` VALUES (9, './img/Oppo/Adapter_capsac/Adapter Sạc USB 18W OPPO OP92KAUH.jpg', 107);
INSERT INTO `images` VALUES (10, './img/Oppo/Adapter_capsac/Adapter Sạc USB 18W OPPO OP92KAUH.jpg', 108);
INSERT INTO `images` VALUES (11, './img/Oppo/Tai_nghe/Tai nghe Bluetooth True Wireless OPPO ENCO Air 3 ETE31.jpg', 109);
INSERT INTO `images` VALUES (12, './img/Anker/Adapter_capsac/Adapter Sạc Type C PD PIQ 3.0 GaN II 30W Anker 313 A2639.jpg', 11);
INSERT INTO `images` VALUES (13, './img/Oppo/Tai_nghe/Tai nghe Bluetooth True Wireless OPPO ENCO Buds 2 ETE41.jpg', 110);
INSERT INTO `images` VALUES (14, './img/Oppo/Tai_nghe/Tai nghe Có Dây OPPO MH151.jpg', 111);
INSERT INTO `images` VALUES (15, './img/Oppo/Tai_nghe/Tai nghe Có Dây OPPO MH320.jpg', 112);
INSERT INTO `images` VALUES (16, './img/XMobile/Adapter_capsac/Adapter chuyển đổi Type C 4 in 1 Xmobile DS122F.jpg', 113);
INSERT INTO `images` VALUES (17, './img/XMobile/Adapter_capsac/Adapter Sạc Type C PD GaN 30W Xmobile DS230.jpg', 114);
INSERT INTO `images` VALUES (18, './img/XMobile/Adapter_capsac/Adapter Sạc Type C PD GaN 30W Xmobile MFM30.jpg', 115);
INSERT INTO `images` VALUES (19, './img/XMobile/Adapter_capsac/Adapter Sạc Type C PD 20W Xmobile CS-TC041.jpg', 116);
INSERT INTO `images` VALUES (20, './img/XMobile/Adapter_capsac/Adapter Sạc Type C PD 20W Xmobile DS602A.jpg', 117);
INSERT INTO `images` VALUES (21, './img/XMobile/Adapter_capsac/Adapter Sạc Type C PD 20W Xmobile DS602A.jpg', 118);
INSERT INTO `images` VALUES (22, './img/XMobile/Adapter_capsac/Adapter Sạc Type C PD 20W Xmobile TC20P.jpg', 119);
INSERT INTO `images` VALUES (23, './img/Anker/Adapter_capsac/Adapter Sạc Type C PD 20W Anker PowerPort III Nano A2633.jpg', 12);
INSERT INTO `images` VALUES (24, './img/XMobile/Adapter_capsac/Adapter Sạc Type C PD 20W Xmobile TC20W.jpg', 120);
INSERT INTO `images` VALUES (25, './img/XMobile/Adapter_capsac/Adapter Sạc đa năng Universal PD 65W Xmobile DS636.jpg', 121);
INSERT INTO `images` VALUES (26, './img/XMobile/Adapter_capsac/Adapter Sạc 2 cổng Type C PD GaN 67W Xmobile DS266.jpg', 122);
INSERT INTO `images` VALUES (27, './img/XMobile/Adapter_capsac/Adapter Sạc 2 cổng Type C PD QC3.0 20W Xmobile TC20QP.jpg', 123);
INSERT INTO `images` VALUES (28, './img/XMobile/Adapter_capsac/Adapter sạc 2 cổng USB Type C 15W Xmobile DS165-NB.jpg', 124);
INSERT INTO `images` VALUES (29, './img/XMobile/Adapter_capsac/Adapter sạc 2 cổng USB Type C 15W Xmobile DS165X.jpg', 125);
INSERT INTO `images` VALUES (30, './img/XMobile/Adapter_capsac/Adapter Sạc 2 cổng USB Type C 15W Xmobile MFK3A.jpg', 126);
INSERT INTO `images` VALUES (31, './img/XMobile/Adapter_capsac/Adapter sạc 2 cổng USB 12W Dual Xmobile DS702.jpg', 127);
INSERT INTO `images` VALUES (32, './img/XMobile/Adapter_capsac/Adapter sạc 2 cổng USB 12W Xmobile DS476.jpg', 128);
INSERT INTO `images` VALUES (33, './img/XMobile/Adapter_capsac/Adapter sạc 4 cổng USB Type C 15W Xmobile DS931-WB.jpg', 129);
INSERT INTO `images` VALUES (34, './img/Anker/Adapter_capsac/Adapter sạc 2 cổng USB 12W Anker PowerPort Elite 2 - A2023.jpg', 13);
INSERT INTO `images` VALUES (35, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 20.000 mAh Type C PD QC3.0 18W Xmobile PowerBox P69D.jpg', 130);
INSERT INTO `images` VALUES (36, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 10000mAh Không dây Magnetic Type C PD 20W Xmobile PowerLite P181P.jpg', 131);
INSERT INTO `images` VALUES (37, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 10000mAh Không dây Magnetic Type C PD 20W Xmobile T156.jpg', 132);
INSERT INTO `images` VALUES (38, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 20000mAh Type C PD QC3.0 20W Xmobile PowerBox+ JP218.jpg', 133);
INSERT INTO `images` VALUES (39, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 20000mAh Type C PD QC 3.0 22.5W Xmobile S2032 kèm Cáp Lightning và Type C.jpg', 134);
INSERT INTO `images` VALUES (40, './img/XMobile/Sac_du_phong/Pin sạc dự phòng không dây Polymer 10.000 mAh Type C PD QC3.0 18W Xmobile P66D.jpg', 135);
INSERT INTO `images` VALUES (41, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 10.000 mAh Type C PD QC3.0 18W Xmobile PowerSlim PJ JP213.jpg', 136);
INSERT INTO `images` VALUES (42, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 10.000 mAh Type C 12W Xmobile PJ JP190ST.jpg', 137);
INSERT INTO `images` VALUES (43, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 15.000 mAh Type C PD QC3.0 18W Xmobile PowerBox P72D.jpg', 138);
INSERT INTO `images` VALUES (44, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 20.000 mAh Type C PD QC3.0 18W Xmobile PowerBox P69D.jpg', 139);
INSERT INTO `images` VALUES (45, './img/Anker/Adapter_capsac/Cáp Lightning MFI 0.9m Anker Powerline II A8432 .jpg', 14);
INSERT INTO `images` VALUES (46, './img/XMobile/Sac_du_phong/Pin sạc dự phòng Polymer 5000mAh Không dây Magnetic Type C PD 20W Xmobile DS611.jpg', 140);
INSERT INTO `images` VALUES (47, './img/XMobile/Sac_du_phong/Pin sạc dự phòng 10.000 mAh Lightning 10W Xmobile LJ JP90S.jpg', 141);
INSERT INTO `images` VALUES (48, './img/XMobile/Sac_du_phong/Pin sạc dự phòng 10000mAh Type C PD QC3.0 20W Xmobile Y73.jpg', 142);
INSERT INTO `images` VALUES (49, './img/XMobile/Sac_du_phong/Pin sạc dự phòng 10000mAh Type C PD QC3.0 22.5W Xmobile T1212.jpg', 143);
INSERT INTO `images` VALUES (50, './img/XMobile/Adapter_capsac/Cáp Lightning 1m Xmobile AL31-1000.jpg', 144);
INSERT INTO `images` VALUES (51, './img/XMobile/Adapter_capsac/Cáp Lightning 1m Xmobile DR-L001X.jpg', 145);
INSERT INTO `images` VALUES (52, './img/XMobile/Adapter_capsac/Cáp Lightning 1m Xmobile LTL-01X.jpg', 146);
INSERT INTO `images` VALUES (53, './img/XMobile/Adapter_capsac/Cáp Micro USB 1m Xmobile Paladin.jpg', 147);
INSERT INTO `images` VALUES (54, './img/XMobile/Adapter_capsac/Cáp Micro USB 2m Xmobile DR-M03.jpg', 148);
INSERT INTO `images` VALUES (55, './img/XMobile/Adapter_capsac/Cáp Micro USB 2m Xmobile LTMP-2006.jpg', 149);
INSERT INTO `images` VALUES (56, './img/Anker/Adapter_capsac/Cáp Micro USB 0.9m Anker PowerLine+ A8142.jpg', 15);
INSERT INTO `images` VALUES (57, './img/XMobile/Adapter_capsac/Cáp Type C - Lightning 1m Xmobile CL-PD01-1000.jpg', 150);
INSERT INTO `images` VALUES (58, './img/Anker/Adapter_capsac/Cáp Type C - Lightning MFI 0.9m Anker PowerLine+ II A8652.jpg', 16);
INSERT INTO `images` VALUES (59, './img/Anker/Adapter_capsac/Cáp Type C - Lightning MFI 0.9m Anker 322 A81B5.jpg', 17);
INSERT INTO `images` VALUES (60, './img/Anker/Adapter_capsac/Cáp Type C - Type C 0.9m Anker PowerLine+ A8187.jpg', 18);
INSERT INTO `images` VALUES (61, './img/Apple/Adapter_capsac/Adapter Sạc Type C 20W.jpg', 19);
INSERT INTO `images` VALUES (62, './img/Anker/Adapter_capsac/Cáp Type C - Type C 1.8m Anker 544 Bio A80F2.jpg', 2);
INSERT INTO `images` VALUES (63, './img/Apple/Adapter_capsac/Cáp sạc không dây MagSafe.jpg', 20);
INSERT INTO `images` VALUES (64, './img/Apple/Adapter_capsac/Cáp Thunderbolt 2m.jpg', 21);
INSERT INTO `images` VALUES (65, './img/Apple/Adapter_capsac/Cáp Thunderbolt 2m.jpg', 22);
INSERT INTO `images` VALUES (66, './img/Apple/Adapter_capsac/Cáp Type C - Type C 1m.jpg', 23);
INSERT INTO `images` VALUES (67, './img/Apple/Adapter_capsac/Cáp Type C - Type C 1m.jpg', 24);
INSERT INTO `images` VALUES (68, './img/Apple/Op_Lung/Ốp lưng MagSafe cho Iphone 15 Pro Max(Nhựa).jpg', 25);
INSERT INTO `images` VALUES (69, './img/Apple/Op_Lung/Ốp lưng Magsafe iPhone 14 Pro Max Nhựa.jpg', 26);
INSERT INTO `images` VALUES (70, './img/Apple/Op_Lung/Ốp lưng Magsafe iPhone 15 Pro Max Silicone.jpg', 27);
INSERT INTO `images` VALUES (71, './img/Apple/Op_Lung/Ốp lưng Magsafe iPhone 15 Pro Max (Vải cứng dẻo).jpg', 28);
INSERT INTO `images` VALUES (72, './img/Apple/Op_Lung/Ốp lưng iPhone 15 Pro Nhựa cứng viền dẻo.jpg', 29);
INSERT INTO `images` VALUES (73, './img/Anker/Adapter_capsac/Cáp USB - Lightning MFI Anker A8012 0.9m.jpg', 3);
INSERT INTO `images` VALUES (74, './img/Apple/Adapter_capsac/Adapter Sạc 5W cho iPhone_iPad_iPod.jpg', 30);
INSERT INTO `images` VALUES (75, './img/Apple/Tai_Nghe/Tai nghe Bluetooth AirPods Pro Gen 2 MagSafe Charge (USB-C).jpg', 31);
INSERT INTO `images` VALUES (76, './img/Apple/Tai_Nghe/Tai nghe Bluetooth AirPods Pro Gen 2 MagSafe Charge (USB-C).jpg', 32);
INSERT INTO `images` VALUES (77, './img/Apple/Tai_Nghe/Tai nghe Bluetooth AirPods 2 Lightning.jpg', 33);
INSERT INTO `images` VALUES (78, './img/Apple/Tai_Nghe/Tai nghe Bluetooth AirPods 3.jpg', 34);
INSERT INTO `images` VALUES (79, './img/Apple/Tai_Nghe/Tai nghe Có Dây Apple.jpg', 35);
INSERT INTO `images` VALUES (80, './img/Apple/Adapter_capsac/Bộ chuyển đổi chân sạc Adapter Kit.jpg', 36);
INSERT INTO `images` VALUES (81, './img/Apple/Adapter_capsac/Cáp chuyển đổi Lightning.jpg', 37);
INSERT INTO `images` VALUES (82, './img/Apple/Adapter_capsac/Cáp chuyển đổi Thunderbolt 3 (USB-C) sang Thunderbolt 2.jpg', 38);
INSERT INTO `images` VALUES (83, './img/Apple/Adapter_capsac/Cáp chuyển đổi USB-C sang Lightning.jpg', 39);
INSERT INTO `images` VALUES (84, './img/Anker/Sac_Du_Phong/Pin sạc dự phòng Polymer 10.000 mAh Type C 12W Anker PowerCore Slim A1229.jpg', 4);
INSERT INTO `images` VALUES (85, './img/Apple/Adapter_capsac/Cáp chuyển đổi USB-C sang VGA.jpg', 40);
INSERT INTO `images` VALUES (86, './img/Apple/Adapter_capsac/Cáp Lightning 1m.jpg', 41);
INSERT INTO `images` VALUES (87, './img/Apple/Adapter_capsac/Cáp Lightning 2m.jpg', 42);
INSERT INTO `images` VALUES (88, './img/JBL/Loa/Cặp loa karaoke JBL Pasion 8 300W.jpg', 43);
INSERT INTO `images` VALUES (89, './img/JBL/Loa/Loa Bluetooth JBL Boombox 3.jpg', 44);
INSERT INTO `images` VALUES (90, './img/JBL/Loa/Loa Bluetooth JBL Charge 5.jpg', 45);
INSERT INTO `images` VALUES (91, './img/JBL/Loa/Loa Bluetooth JBL Flip 6.jpg', 46);
INSERT INTO `images` VALUES (92, './img/JBL/Loa/Loa Bluetooth JBL Go Essential.jpg', 47);
INSERT INTO `images` VALUES (93, './img/JBL/Loa/Loa Bluetooth JBL Go Essential.jpg', 48);
INSERT INTO `images` VALUES (94, './img/JBL/Loa/Loa Bluetooth JBL Partybox Encore 2Mic.jpg', 49);
INSERT INTO `images` VALUES (95, './img/Anker/Sac_Du_Phong/Pin sạc dự phòng Polymer 5000mAh Không dây Magnetic Type C 12W Anker MagGo A1611.jpg', 5);
INSERT INTO `images` VALUES (96, './img/JBL/Loa/Loa Bluetooth JBL Partybox On The Go.jpg', 50);
INSERT INTO `images` VALUES (97, './img/JBL/Loa/Loa Bluetooth JBL Partybox 110.jpg', 51);
INSERT INTO `images` VALUES (98, './img/JBL/Loa/Loa Bluetooth JBL Pulse 5.jpg', 52);
INSERT INTO `images` VALUES (99, './img/JBL/Loa/Loa Bluetooth JBL Xtreme 3.jpg', 53);
INSERT INTO `images` VALUES (100, './img/JBL/Loa/Loa siêu trầm JBL PASION 12SP 300W.jpg', 54);
INSERT INTO `images` VALUES (101, './img/JBL/Loa/Loa điện karaoke JBL IRX108BT 1000W.jpg', 55);
INSERT INTO `images` VALUES (102, './img/JBL/Loa/Loa điện karaoke JBL IRX112BT 1300W.jpg', 56);
INSERT INTO `images` VALUES (103, './img/JBL/Tai_Nghe/Tai nghe Bluetooth Chụp Tai JBL T500.jpg', 57);
INSERT INTO `images` VALUES (104, './img/JBL/Tai_Nghe/Tai nghe Bluetooth Chụp Tai JBL Tune 520BT.jpg', 58);
INSERT INTO `images` VALUES (105, './img/JBL/Tai_Nghe/Tai nghe Có Dây JBL C200 SIU.jpg', 59);
INSERT INTO `images` VALUES (106, './img/Anker/Sac_Du_Phong/Pin sạc dự phòng 10.000 mAh Anker PowerCore Select A1223.jpg', 6);
INSERT INTO `images` VALUES (107, './img/Xiaomi/Op_lung/Ốp lưng Redmi 9C Nhựa dẻo.jpg', 60);
INSERT INTO `images` VALUES (108, './img/Xiaomi/Op_lung/Ốp lưng Xiaomi Poco C40 Nhựa.jpg', 61);
INSERT INTO `images` VALUES (109, './img/Xiaomi/Op_lung/Ốp lưng Xiaomi Redmi A2+ Nhựa dẻo.jpg', 62);
INSERT INTO `images` VALUES (110, './img/Xiaomi/Op_lung/Ốp lưng Xiaomi Redmi A2 Nhựa dẻo TPU JM Cons Shock.jpg', 63);
INSERT INTO `images` VALUES (111, './img/Xiaomi/Op_lung/Ốp lưng Xiaomi Redmi 10A Nhựa dẻo.jpg', 64);
INSERT INTO `images` VALUES (112, './img/Xiaomi/Op_lung/Ốp lưng Xiaomi Redmi 12 Silicone JM Candy.jpg', 65);
INSERT INTO `images` VALUES (113, './img/Xiaomi/Tai_Nghe/Tai nghe Bluetooth True Wireless Xiaomi Redmi Buds 4 Active.jpg', 66);
INSERT INTO `images` VALUES (114, './img/Xiaomi/Tai_Nghe/Tai nghe Bluetooth TWS Xiaomi Redmi Buds 4 Lite.jpg', 67);
INSERT INTO `images` VALUES (115, './img/Samsung/Adapter_capsac/Adapter Sạc Type C PD 25W Samsung EP-TA800N.jpg', 68);
INSERT INTO `images` VALUES (116, './img/Samsung/Adapter_capsac/Adapter Sạc Type C 15W Samsung EP-T1510N.jpg', 69);
INSERT INTO `images` VALUES (117, './img/Anker/Sac_Du_Phong/Pin sạc dự phòng 10000mAh Không dây Magnetic Type C PD QC 3.0 20W Anker MagGo A1641.jpg', 7);
INSERT INTO `images` VALUES (118, './img/Samsung/Adapter_capsac/Adapter sạc 3 cổng USB Type C PD 65W Samsung EP-T6530.jpg', 70);
INSERT INTO `images` VALUES (119, './img/Samsung/Adapter_capsac/Bộ Adapter sạc kèm cáp Type C Samsung EP-T1510X.jpg', 71);
INSERT INTO `images` VALUES (120, './img/Samsung/Adapter_capsac/Pin sạc dự phòng 20.000 mAh Type C PD 25W Samsung EB-P5300.jpg', 72);
INSERT INTO `images` VALUES (121, './img/Samsung/Adapter_capsac/Pin sạc dự phòng 10000 mAh Type C PD 25W Samsung EB-P3400.jpg', 73);
INSERT INTO `images` VALUES (122, './img/Samsung/Op_Lung/Bao da nắp gập Galaxy S21+ Clear View Samsung Chính hãng.jpg', 74);
INSERT INTO `images` VALUES (123, './img/Samsung/Op_Lung/Bao da nắp gập Galaxy Z Fold4 Samsung Chính hãng.jpg', 75);
INSERT INTO `images` VALUES (124, './img/Samsung/Op_Lung/Ốp lưng Galaxy A03 Nhựa dẻo Soft Clear Samsung Chính hãng.jpg', 76);
INSERT INTO `images` VALUES (125, './img/Samsung/Op_Lung/Ốp lưng Galaxy A12 Nhựa dẻo Soft Clear Samsung Chính hãng.jpg', 77);
INSERT INTO `images` VALUES (126, './img/Samsung/Op_Lung/Ốp lưng Galaxy A13 Nhựa dẻo Samsung Chính hãng.jpg', 78);
INSERT INTO `images` VALUES (127, './img/Samsung/Op_Lung/Ốp lưng Galaxy A22 Nhựa dẻo Soft Clear Samsung Chính hãng.jpg', 79);
INSERT INTO `images` VALUES (128, './img/Anker/Sac_Du_Phong/Pin sạc dự phòng 10000mAh Type C PD QC 3.0 30W Anker A1256 .jpg', 8);
INSERT INTO `images` VALUES (129, './img/Samsung/Op_Lung/Ốp lưng Galaxy A52 Nhựa dẻo A Cover Samsung Chính hãng.jpg', 80);
INSERT INTO `images` VALUES (130, './img/Samsung/Op_Lung/Ốp lưng Galaxy A72 Nhựa dẻo Clear Standing Samsung Chính hãng.jpg', 81);
INSERT INTO `images` VALUES (131, './img/Samsung/Op_Lung/Ốp lưng Galaxy M33 Silicone Samsung Chính hãng.jpg', 82);
INSERT INTO `images` VALUES (132, './img/Samsung/Op_Lung/Ốp lưng Galaxy M53 Nhựa dẻo Samsung Chính hãng.jpg', 83);
INSERT INTO `images` VALUES (133, './img/Samsung/Op_Lung/Ốp lưng Galaxy Z Flip3 Da Samsung Chính hãng.jpg', 84);
INSERT INTO `images` VALUES (134, './img/Samsung/Op_Lung/Ốp lưng Galaxy Z Flip5 Silicone Samsung Kèm vòng đeo tay Chính hãng.jpg', 85);
INSERT INTO `images` VALUES (135, './img/Samsung/Op_Lung/Ốp lưng nắp gập Galaxy S10+ Clear View Samsung Chính hãng.jpg', 86);
INSERT INTO `images` VALUES (136, './img/Samsung/Op_Lung/Ốp lưng nắp gập Galaxy Z Flip4 Nhựa cứng Samsung Chính hãng.jpg', 87);
INSERT INTO `images` VALUES (137, './img/Samsung/Op_Lung/Ốp lưng nắp gập Galaxy Z Fold4 kèm S Pen Samsung Chính hãng.jpg', 88);
INSERT INTO `images` VALUES (138, './img/Samsung/Op_Lung/Ốp lưng nắp gập Galaxy Z Fold4 Silicone kèm S Pen Samsung Chính hãng.jpg', 89);
INSERT INTO `images` VALUES (139, './img/Anker/Sac_Du_Phong/Pin sạc dự phòng 20000mAh Type C PD 20W Anker PowerCore Essential A1287.jpg', 9);
INSERT INTO `images` VALUES (140, './img/Samsung/Tai_Nghe/Tai nghe Bluetooth True Wireless Samsung Galaxy Buds 2 Pro R510N.jpg', 90);
INSERT INTO `images` VALUES (141, './img/Samsung/Tai_Nghe/Tai nghe Bluetooth True Wireless Samsung Galaxy Buds 2 R177N.jpg', 91);
INSERT INTO `images` VALUES (142, './img/Samsung/Tai_Nghe/Tai nghe Có Dây Samsung IA500.jpg', 92);
INSERT INTO `images` VALUES (143, './img/Sony/Loa/Bộ loa Sony 5.1 HT-S700RF 1000W.jpg', 93);
INSERT INTO `images` VALUES (144, './img/Sony/Loa/Bộ loa thanh Sony HT- G700 400W.jpg', 94);
INSERT INTO `images` VALUES (145, './img/Sony/Loa/Bộ loa thanh Sony HT-S20R 400W.jpg', 95);
INSERT INTO `images` VALUES (146, './img/Sony/Loa/Bộ loa thanh Sony HT-S40R 600W.jpg', 96);
INSERT INTO `images` VALUES (147, './img/Sony/Loa/Bộ loa thanh Sony HT-S400 330W.jpg', 97);
INSERT INTO `images` VALUES (148, './img/Sony/Loa/Loa Bluetooth Sony Hifi GTK-PG10.jpg', 98);
INSERT INTO `images` VALUES (149, './img/Sony/Loa/Loa Bluetooth Sony SRS-XB13.jpg', 99);

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory`  (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `product_id` int NULL DEFAULT NULL,
                              `quantity` int NULL DEFAULT NULL,
                              PRIMARY KEY (`id`) USING BTREE,
                              INDEX `product_id`(`product_id` ASC) USING BTREE,
                              CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of inventory
-- ----------------------------
INSERT INTO `inventory` VALUES (1, 1, 500);
INSERT INTO `inventory` VALUES (2, 2, 500);
INSERT INTO `inventory` VALUES (3, 3, 500);
INSERT INTO `inventory` VALUES (4, 4, 500);
INSERT INTO `inventory` VALUES (5, 5, 500);
INSERT INTO `inventory` VALUES (6, 6, 500);
INSERT INTO `inventory` VALUES (7, 7, 500);
INSERT INTO `inventory` VALUES (8, 8, 500);
INSERT INTO `inventory` VALUES (9, 9, 500);
INSERT INTO `inventory` VALUES (10, 10, 500);
INSERT INTO `inventory` VALUES (11, 11, 500);
INSERT INTO `inventory` VALUES (12, 12, 400);
INSERT INTO `inventory` VALUES (13, 13, 400);
INSERT INTO `inventory` VALUES (14, 14, 400);
INSERT INTO `inventory` VALUES (15, 15, 400);
INSERT INTO `inventory` VALUES (16, 16, 400);
INSERT INTO `inventory` VALUES (17, 17, 400);
INSERT INTO `inventory` VALUES (18, 18, 400);
INSERT INTO `inventory` VALUES (19, 19, 400);
INSERT INTO `inventory` VALUES (20, 20, 400);
INSERT INTO `inventory` VALUES (21, 21, 400);
INSERT INTO `inventory` VALUES (22, 22, 400);
INSERT INTO `inventory` VALUES (23, 23, 400);
INSERT INTO `inventory` VALUES (24, 24, 500);
INSERT INTO `inventory` VALUES (25, 25, 500);
INSERT INTO `inventory` VALUES (26, 26, 500);
INSERT INTO `inventory` VALUES (27, 27, 500);
INSERT INTO `inventory` VALUES (28, 28, 500);
INSERT INTO `inventory` VALUES (29, 29, 500);
INSERT INTO `inventory` VALUES (30, 30, 500);
INSERT INTO `inventory` VALUES (31, 31, 500);
INSERT INTO `inventory` VALUES (32, 32, 500);
INSERT INTO `inventory` VALUES (33, 33, 500);
INSERT INTO `inventory` VALUES (34, 34, 500);
INSERT INTO `inventory` VALUES (35, 35, 500);
INSERT INTO `inventory` VALUES (36, 36, 500);
INSERT INTO `inventory` VALUES (37, 37, 500);
INSERT INTO `inventory` VALUES (38, 38, 500);
INSERT INTO `inventory` VALUES (39, 39, 500);
INSERT INTO `inventory` VALUES (40, 40, 500);
INSERT INTO `inventory` VALUES (41, 41, 500);
INSERT INTO `inventory` VALUES (42, 42, 500);
INSERT INTO `inventory` VALUES (43, 43, 500);
INSERT INTO `inventory` VALUES (44, 44, 500);
INSERT INTO `inventory` VALUES (45, 45, 500);
INSERT INTO `inventory` VALUES (46, 46, 500);
INSERT INTO `inventory` VALUES (47, 47, 500);
INSERT INTO `inventory` VALUES (48, 48, 500);
INSERT INTO `inventory` VALUES (49, 49, 500);
INSERT INTO `inventory` VALUES (50, 50, 500);
INSERT INTO `inventory` VALUES (51, 51, 500);
INSERT INTO `inventory` VALUES (52, 52, 500);
INSERT INTO `inventory` VALUES (53, 53, 500);
INSERT INTO `inventory` VALUES (54, 54, 500);
INSERT INTO `inventory` VALUES (55, 55, 500);
INSERT INTO `inventory` VALUES (56, 56, 500);
INSERT INTO `inventory` VALUES (57, 57, 500);
INSERT INTO `inventory` VALUES (58, 58, 500);
INSERT INTO `inventory` VALUES (59, 59, 500);
INSERT INTO `inventory` VALUES (60, 60, 500);
INSERT INTO `inventory` VALUES (61, 61, 500);
INSERT INTO `inventory` VALUES (62, 62, 500);
INSERT INTO `inventory` VALUES (63, 63, 500);
INSERT INTO `inventory` VALUES (64, 64, 500);
INSERT INTO `inventory` VALUES (65, 65, 500);
INSERT INTO `inventory` VALUES (66, 66, 500);
INSERT INTO `inventory` VALUES (67, 67, 500);
INSERT INTO `inventory` VALUES (68, 68, 500);
INSERT INTO `inventory` VALUES (69, 69, 500);
INSERT INTO `inventory` VALUES (70, 70, 500);
INSERT INTO `inventory` VALUES (71, 71, 500);
INSERT INTO `inventory` VALUES (72, 72, 500);
INSERT INTO `inventory` VALUES (73, 73, 500);
INSERT INTO `inventory` VALUES (74, 74, 500);
INSERT INTO `inventory` VALUES (75, 75, 500);
INSERT INTO `inventory` VALUES (76, 76, 500);
INSERT INTO `inventory` VALUES (77, 77, 500);
INSERT INTO `inventory` VALUES (78, 78, 500);
INSERT INTO `inventory` VALUES (79, 79, 500);
INSERT INTO `inventory` VALUES (80, 80, 500);
INSERT INTO `inventory` VALUES (81, 81, 500);
INSERT INTO `inventory` VALUES (82, 82, 500);
INSERT INTO `inventory` VALUES (83, 83, 500);
INSERT INTO `inventory` VALUES (84, 84, 500);
INSERT INTO `inventory` VALUES (85, 85, 500);
INSERT INTO `inventory` VALUES (86, 86, 500);
INSERT INTO `inventory` VALUES (87, 87, 200);
INSERT INTO `inventory` VALUES (88, 88, 200);
INSERT INTO `inventory` VALUES (89, 89, 200);
INSERT INTO `inventory` VALUES (90, 90, 200);
INSERT INTO `inventory` VALUES (91, 91, 200);
INSERT INTO `inventory` VALUES (92, 92, 200);
INSERT INTO `inventory` VALUES (93, 93, 200);
INSERT INTO `inventory` VALUES (94, 94, 200);
INSERT INTO `inventory` VALUES (95, 95, 200);
INSERT INTO `inventory` VALUES (96, 96, 200);
INSERT INTO `inventory` VALUES (97, 97, 200);
INSERT INTO `inventory` VALUES (98, 98, 200);
INSERT INTO `inventory` VALUES (99, 99, 200);
INSERT INTO `inventory` VALUES (100, 101, 500);
INSERT INTO `inventory` VALUES (101, 102, 500);
INSERT INTO `inventory` VALUES (102, 103, 500);
INSERT INTO `inventory` VALUES (103, 104, 500);
INSERT INTO `inventory` VALUES (104, 105, 500);
INSERT INTO `inventory` VALUES (105, 106, 500);
INSERT INTO `inventory` VALUES (106, 107, 500);
INSERT INTO `inventory` VALUES (107, 108, 500);
INSERT INTO `inventory` VALUES (108, 109, 500);
INSERT INTO `inventory` VALUES (109, 110, 500);
INSERT INTO `inventory` VALUES (110, 111, 500);
INSERT INTO `inventory` VALUES (111, 112, 500);
INSERT INTO `inventory` VALUES (112, 113, 500);
INSERT INTO `inventory` VALUES (113, 114, 500);
INSERT INTO `inventory` VALUES (114, 115, 500);
INSERT INTO `inventory` VALUES (115, 116, 500);
INSERT INTO `inventory` VALUES (116, 117, 500);
INSERT INTO `inventory` VALUES (117, 118, 500);
INSERT INTO `inventory` VALUES (118, 119, 500);
INSERT INTO `inventory` VALUES (119, 120, 500);
INSERT INTO `inventory` VALUES (120, 121, 500);
INSERT INTO `inventory` VALUES (121, 122, 500);
INSERT INTO `inventory` VALUES (122, 123, 500);
INSERT INTO `inventory` VALUES (123, 124, 500);
INSERT INTO `inventory` VALUES (124, 125, 500);
INSERT INTO `inventory` VALUES (125, 126, 500);
INSERT INTO `inventory` VALUES (126, 127, 500);
INSERT INTO `inventory` VALUES (127, 128, 500);
INSERT INTO `inventory` VALUES (128, 129, 500);
INSERT INTO `inventory` VALUES (129, 130, 500);
INSERT INTO `inventory` VALUES (130, 131, 500);
INSERT INTO `inventory` VALUES (131, 132, 500);
INSERT INTO `inventory` VALUES (132, 133, 500);
INSERT INTO `inventory` VALUES (133, 134, 500);
INSERT INTO `inventory` VALUES (134, 135, 500);
INSERT INTO `inventory` VALUES (135, 136, 500);
INSERT INTO `inventory` VALUES (136, 137, 500);
INSERT INTO `inventory` VALUES (137, 138, 500);
INSERT INTO `inventory` VALUES (138, 139, 500);
INSERT INTO `inventory` VALUES (139, 140, 500);
INSERT INTO `inventory` VALUES (140, 141, 500);
INSERT INTO `inventory` VALUES (141, 142, 500);
INSERT INTO `inventory` VALUES (142, 143, 500);
INSERT INTO `inventory` VALUES (143, 144, 500);
INSERT INTO `inventory` VALUES (144, 145, 500);
INSERT INTO `inventory` VALUES (145, 146, 500);
INSERT INTO `inventory` VALUES (146, 147, 500);
INSERT INTO `inventory` VALUES (147, 148, 500);
INSERT INTO `inventory` VALUES (148, 149, 500);
INSERT INTO `inventory` VALUES (149, 150, 500);

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`  (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `level` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                         `action` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                         `address_ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                         `user_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                         `created_at` datetime NOT NULL,
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 458 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `order_id` int NOT NULL,
                                  `amount` double NOT NULL,
                                  `product_id` int NOT NULL,
                                  `quantity` int NOT NULL,
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `order_details_products_id_fk`(`product_id` ASC) USING BTREE,
                                  CONSTRAINT `order_details_products_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_details
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `user_id` int NOT NULL,
                           `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                           `phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                           `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                           `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL,
                           `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                           `order_date` datetime NOT NULL,
                           `delivery_date` datetime NOT NULL,
                           `total_price` double NULL DEFAULT NULL,
                           PRIMARY KEY (`id`) USING BTREE,
                           INDEX `orders_users_id_fk`(`user_id` ASC) USING BTREE,
                           CONSTRAINT `orders_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for producers
-- ----------------------------
DROP TABLE IF EXISTS `producers`;
CREATE TABLE `producers`  (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                              `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of producers
-- ----------------------------
INSERT INTO `producers` VALUES (1, 'Anker', 'AN');
INSERT INTO `producers` VALUES (2, 'Apple', 'AP');
INSERT INTO `producers` VALUES (3, 'JBL', 'JP');
INSERT INTO `producers` VALUES (4, 'Oppo', 'OP');
INSERT INTO `producers` VALUES (5, 'Sony', 'SN');
INSERT INTO `producers` VALUES (6, 'SamSung', 'SA');
INSERT INTO `producers` VALUES (7, 'XMobile', 'XM');
INSERT INTO `producers` VALUES (8, 'Xiaomi', 'XI');

-- ----------------------------
-- Table structure for product_types
-- ----------------------------
DROP TABLE IF EXISTS `product_types`;
CREATE TABLE `product_types`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                                  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_types
-- ----------------------------
INSERT INTO `product_types` VALUES (1, 'Apdapter, Cáp sạc', 'ADAPTER');
INSERT INTO `product_types` VALUES (2, 'Ốp lưng', 'BUMBER');
INSERT INTO `product_types` VALUES (3, 'Tai nghe', 'EARPHONE');
INSERT INTO `product_types` VALUES (4, 'Phụ kiện khác', 'OTHER');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
                             `id` int NOT NULL AUTO_INCREMENT,
                             `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                             `price` double NOT NULL,
                             `product_type_id` int NOT NULL,
                             `producer_id` int NOT NULL,
                             `quantity` int NOT NULL,
                             `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                             `coupon_id` int NOT NULL,
                             `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                             `import_date` date NULL DEFAULT NULL,
                             `active` int NOT NULL DEFAULT 1,
                             PRIMARY KEY (`id`) USING BTREE,
                             INDEX `product_producers_id_fk`(`producer_id` ASC) USING BTREE,
                             INDEX `product_product_types_id_fk`(`product_type_id` ASC) USING BTREE,
                             INDEX `products_coupon_id_fk`(`coupon_id` ASC) USING BTREE,
                             CONSTRAINT `product_producers_id_fk` FOREIGN KEY (`producer_id`) REFERENCES `producers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                             CONSTRAINT `product_product_types_id_fk` FOREIGN KEY (`product_type_id`) REFERENCES `product_types` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                             CONSTRAINT `products_coupon_id_fk` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Adapter Sạc Type C PD GaN 30W', 259000, 1, 1, 23, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-26', 1);
INSERT INTO `products` VALUES (2, 'Cáp Type C - Type C 1.8m', 590000, 1, 1, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-04', 1);
INSERT INTO `products` VALUES (3, 'Cáp USB - Lightning MFI', 99000, 1, 1, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-07-01', 1);
INSERT INTO `products` VALUES (4, 'Pin sạc dự phòng Polymer 10.000 mAh', 410000, 4, 1, 0, NULL, 4, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-30', 1);
INSERT INTO `products` VALUES (5, 'Pin sạc dự phòng Polymer 5000mAh', 1150000, 4, 1, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-04', 1);
INSERT INTO `products` VALUES (6, 'Pin sạc dự phòng 10.000 mAh', 1180000, 4, 1, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-07-01', 1);
INSERT INTO `products` VALUES (7, 'Pin sạc dự phòng 10000mAh không dây', 1750000, 4, 1, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-04', 1);
INSERT INTO `products` VALUES (8, 'Pin sạc dự phòng 10000mAh Type C', 1180000, 4, 1, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-05-29', 1);
INSERT INTO `products` VALUES (9, 'Pin sạc dự phòng 20000mAh', 1200000, 4, 1, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-05-08', 1);
INSERT INTO `products` VALUES (10, 'Tai Nghe Bluetooth True Wireless', 3500000, 3, 1, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-05-10', 1);
INSERT INTO `products` VALUES (11, 'Adapter Sạc Type C PD PIQ 30W', 350000, 1, 1, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-05-07', 1);
INSERT INTO `products` VALUES (12, 'Adapter Sạc Type C PD 20W', 400000, 1, 1, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-07-19', 1);
INSERT INTO `products` VALUES (13, 'Adapter sạc 2 cổng USB 12W ', 310000, 1, 1, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-03', 1);
INSERT INTO `products` VALUES (14, 'Cáp Lightning MFI 0.9m', 220000, 1, 1, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-07-04', 1);
INSERT INTO `products` VALUES (15, 'Cáp Micro USB 0.9m', 100000, 1, 1, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-07-01', 1);
INSERT INTO `products` VALUES (16, 'Cáp Type C - Lightning MFI 0.9m', 210000, 1, 1, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (17, 'Cáp Type C - Lightning MFI 1.8m', 220000, 1, 1, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (18, 'Cáp Type C - Type C 0.9m', 320000, 1, 1, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (19, 'Adapter Sạc Type C 20W', 500000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (20, 'Cáp sạc không dây MagSafe', 1590000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (21, 'Cáp Thunderbolt 2m', 1190000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (22, 'Cáp Type C - Lightning', 550000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (23, 'Cáp Type C - Type C 1m', 540000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (24, 'Cáp Type C - Type C 2m', 690000, 1, 2, 0, 'sale', 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (25, 'MagSafe Iphone 15 Pro Max(Nhựa)', 1400000, 2, 2, 0, NULL, 4, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (26, 'Magsafe iPhone 14 Pro Max (Nhựa)', 1590000, 2, 2, 0, NULL, 4, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-07-19', 1);
INSERT INTO `products` VALUES (27, 'Magsafe iPhone 15 Pro Max (Silicone)', 1400000, 2, 2, 0, 'sale', 4, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (28, 'Magsafe iPhone 15 Pro Max (Vải)', 1520000, 2, 2, 0, NULL, 4, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (29, 'Magsafe iPhone 15 Pro (Nhựa cứng viền dẻo)', 300000, 2, 2, 0, 'sale', 4, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (30, 'Adapter Sạc 5W', 450000, 1, 2, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (31, 'AirPods Pro (2nd Gen) MagSafe', 6000000, 3, 2, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (32, 'AirPods Pro Gen 2 MagSafe Charge', 6200000, 3, 2, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (33, 'AirPods 2 Lightning', 3500000, 3, 2, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (34, 'AirPods 3', 4900000, 3, 2, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (35, 'Tai nghe Có Dây Apple', 550000, 3, 2, 0, 'sale', 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (36, 'Bộ chuyển đổi chân sạc Adapter Kit', 1000000, 1, 2, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (37, 'Cáp chuyển đổi Lightning', 300000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (38, 'USB-C sang Thunderbolt', 1700000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (39, 'Cáp chuyển đổi USB-C sang Lightning', 950000, 1, 2, 0, 'sale', 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (40, 'Cáp chuyển đổi USB-C sang VGA', 2600000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (41, 'Cáp Lightning 1m', 550000, 1, 2, 0, 'sale', 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (42, 'Cáp Lightning 2m', 750000, 1, 2, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (43, 'Cặp loa karaoke JBL Pasion 8 300W', 9900000, 4, 3, 0, '', 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (44, 'Loa Bluetooth JBL Boombox 3', 3490000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (45, 'Loa Bluetooth JBL Charge 5', 3700000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (46, 'Loa Bluetooth JBL Flip 6', 2599000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (47, 'Loa Bluetooth JBL Go Essential', 690000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (48, 'Loa Bluetooth JBL Go 3', 249000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (49, 'Loa Bluetooth JBL Partybox Encore', 5900000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (50, 'Loa Bluetooth JBL Partybox On', 6390000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-07-19', 1);
INSERT INTO `products` VALUES (51, 'Loa Bluetooth JBL Partybox 110', 9350000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (52, 'Loa Bluetooth JBL Pulse 5', 6150000, 4, 3, 0, 'selling', 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (53, 'Loa Bluetooth JBL Xtreme 3', 5700000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (54, 'Loa siêu trầm JBL PASION 12SP 300W', 9000000, 4, 3, 0, 'selling', 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (55, 'Loa điện karaoke JBL IRX108BT ', 9450000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (56, 'Loa điện karaoke JBL IRX112BT ', 9740000, 4, 3, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (57, 'Tai nghe Bluetooth Chụp Tai JBL T500', 890000, 3, 3, 0, 'selling', 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (58, 'Tai nghe Bluetooth Chụp Tai JBL 520BT', 700000, 3, 3, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (59, 'Tai nghe Có Dây JBL C200 SIU', 600000, 3, 3, 0, 'selling', 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (60, 'Ốp lưng Redmi 9C Nhựa dẻo', 40000, 2, 8, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (61, 'Ốp lưng Xiaomi Poco C40 Nhựa', 80000, 2, 8, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (62, 'Ốp lưng Xiaomi Redmi A2+ Nhựa dẻo', 30000, 2, 8, 0, 'selling', 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-07-19', 1);
INSERT INTO `products` VALUES (63, 'Ốp lưng Xiaomi Redmi A2 Nhựa dẻo TPU', 90000, 2, 8, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (64, 'Ốp lưng Xiaomi Redmi 10A Nhựa dẻo', 50000, 2, 8, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (65, 'Ốp lưng Xiaomi Redmi 12 Silicone', 70000, 2, 8, 0, 'selling', 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (66, 'Tai nghe Bluetooth True Wireless', 540000, 3, 8, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (67, 'Tai nghe Bluetooth TWS', 440000, 3, 8, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (68, 'Adapter Sạc Type C PD 25W', 150000, 1, 6, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (69, 'Adapter Sạc Type C 15W Samsung', 100000, 1, 6, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (70, 'Adapter sạc 3 cổng USB Type C', 350000, 1, 6, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (71, 'Bộ Adapter sạc kèm cáp Type C', 500000, 1, 6, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (72, 'Pin sạc dự phòng 20.000 mAh', 600000, 4, 6, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (73, 'Pin sạc dự phòng 10000 mAh', 300000, 4, 6, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (74, 'Bao da nắp gập Galaxy S21+', 400000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (75, 'Bao da nắp gập Galaxy Z Fold4', 450000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (76, 'Ốp lưng Galaxy A03 Nhựa dẻo', 50000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (77, 'Ốp lưng Galaxy A12 Nhựa dẻo', 60000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-07-19', 1);
INSERT INTO `products` VALUES (78, 'Ốp lưng Galaxy A13 Nhựa dẻo', 50000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (79, 'Ốp lưng Galaxy A22 Nhựa dẻo', 50000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (80, 'Ốp lưng Galaxy A52 Nhựa dẻo', 60000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (81, 'Ốp lưng Galaxy A72 Nhựa dẻo', 60000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (82, 'Ốp lưng Galaxy M33 Silicone', 300000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (83, 'Ốp lưng Galaxy M53 Nhựa dẻo', 60000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (84, 'Ốp lưng Galaxy Z Flip3 Da', 300000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (85, 'Ốp lưng Galaxy Z Flip5 Silicone', 300000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (86, 'Ốp lưng nắp gập Galaxy S10+', 450000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (87, 'Ốp lưng nắp gập Galaxy Z Flip4', 450000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (88, 'Ốp lưng nắp gập Galaxy Z Fold4', 300000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-06-11', 1);
INSERT INTO `products` VALUES (89, 'Ốp lưng Galaxy Z Fold4 Silicone', 320000, 2, 6, 0, NULL, 6, 'Ốp lưng: Bảo vệ độc đáo với vật liệu chống sốc và chống va đập. Thiết kế mỏng nhẹ nhưng vô cùng chắc chắn, giữ cho điện thoại của bạn an toàn khỏi trầy xước và hỏng hóc. Dễ dàng truy cập các cổng và nút điều khiển, là sự kết hợp lý tưởng giữa bảo vệ và thiết kế hiện đại.', '2024-07-19', 1);
INSERT INTO `products` VALUES (90, 'Tai nghe Bluetooth True Wireless', 1450000, 3, 6, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (91, 'Tai nghe Bluetooth True Wireless Pro', 2450000, 3, 6, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (92, 'Tai nghe Có Dây', 90000, 3, 6, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (93, 'Bộ loa Sony 5.1 HT-S700RF 1000W', 2450000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (94, 'Bộ loa thanh Sony HT- G700 400W', 1980000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (95, 'Bộ loa thanh Sony HT-S20R', 450000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (96, 'Bộ loa thanh Sony HT-S40R 600W', 1750000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (97, 'Bộ loa thanh Sony HT-S400 330W', 600000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (98, 'Loa Bluetooth Sony Hifi GTK-PG10', 1200000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (99, 'Loa Bluetooth Sony SRS-XB13', 1180000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (101, 'Loa Bluetooth Sony SRS-XP500', 1600000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (102, 'Loa thanh Sony HT-S100F 120W', 1750000, 4, 5, 0, NULL, 3, 'Loa: Âm thanh sống động và mạnh mẽ trong thiết kế nhỏ gọn. Kết nối Bluetooth dễ dàng, pin lâu bền, và chống nước, là sự lựa chọn tuyệt vời cho âm nhạc di động và trải nghiệm giải trí ngoại ô. Mang lại âm thanh chất lượng, tính di động và khả năng chống nước đáng tin cậy.', '2024-06-11', 1);
INSERT INTO `products` VALUES (103, 'Tai nghe Bluetooth True Wireless', 2100000, 3, 5, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (104, 'Tai nghe Bluetooth True Wireless Pro', 3900000, 3, 5, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (105, 'Tai nghe Chụp Tai Sony MDR', 1140000, 3, 5, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (106, 'Tai nghe Có Dây Sony MDR', 352000, 3, 5, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (107, 'Tai nghe Có Dây Sony DMX', 200000, 3, 5, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (108, 'Adapter Sạc USB 18W OPPO', 300000, 1, 4, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (109, 'Tai nghe Bluetooth True Wireless', 500000, 3, 4, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (110, 'Tai nghe Bluetooth True Wireless Pro', 1750000, 3, 4, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (111, 'Tai nghe Có Dây OPPO MH151', 250000, 3, 4, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (112, 'Tai nghe Có Dây OPPO MH320', 250000, 3, 4, 0, NULL, 2, 'Tai nghe: Âm thanh chất lượng cao, thiết kế thoải mái. Công nghệ giảm tiếng ồn và điều khiển cảm ứng giúp trải nghiệm nghe nhạc và cuộc gọi mượt mà. Sự kết hợp hoàn hảo cho người yêu âm nhạc di động.', '2024-06-11', 1);
INSERT INTO `products` VALUES (113, 'Adapter chuyển đổi Type C', 500000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (114, 'Adapter Sạc Type C PD GaN 30W', 600000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (115, 'Adapter Sạc Type C PD GaN 45W', 570000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (116, 'Adapter Sạc Type C PD 20W', 250000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (117, 'Adapter Sạc Type C PD 20W XML', 570000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (118, 'Adapter Sạc Type C PD 20W Đen', 250000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (119, 'Adapter Sạc Type C PD 60W', 500000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (120, 'Adapter Sạc Type C PD 45W', 500000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (121, 'Adapter Sạc đa năng Universa', 570000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (122, 'Adapter Sạc 2 cổng Type C PD 65W', 570000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (123, 'Adapter Sạc 2 cổng Type C PD 20W', 600000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (124, 'Adapter sạc 2 cổng USB Type C 15W', 250000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (125, 'Adapter sạc 2 cổng USB Type C 30W', 250000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (126, 'Adapter Sạc 3 cổng USB Type C ', 250000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (127, 'Adapter sạc 2 cổng USB 12W Dual', 600000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (128, 'Adapter sạc 2 cổng USB 12W', 300000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (129, 'Adapter sạc 4 cổng USB Type C 15W', 400000, 1, 7, 0, NULL, 1, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (130, 'Pin sạc dự phòng Polymer 20.000 mAh', 600000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (131, 'Pin sạc dự phòng 10000mAh Không dây', 600000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (132, 'Pin sạc dự phòng 10000mAh Magnetic', 260000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (133, 'Pin sạc dự phòng 20000mAh 20W', 400000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (134, 'Pin sạc dự phòng 20000mAh  22.5W', 620000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (135, 'Pin sạc dự phòng không dây 10000mAh ', 260000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (136, 'Pin sạc dự phòng 10.000 mAh Type C', 320000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (137, 'Pin sạc dự phòng 10.000 mAh 12W', 1400000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (138, 'Pin sạc dự phòng 15.000 mAh Type C ', 600000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (139, 'Pin sạc dự phòng 20.000 mAh Type C  ', 400000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (140, 'Pin sạc dự phòng 5000mAh Không dây ', 800000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (141, 'Pin sạc dự phòng10.000 mAh 10W', 360000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (142, 'Pin sạc dự phòng 10000mAh 25W', 360000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (143, 'Pin sạc dự phòng 10000mAh 65W', 360000, 4, 7, 0, NULL, 4, 'Sạc Dự Phòng: Cung cấp năng lượng dự phòng hiệu quả với dung lượng lớn và công suất đầu ra nhanh chóng. Thiết kế nhỏ gọn, dễ mang theo. Tích hợp nhiều cổng sạc đa dạng, đảm bảo sạc đồng thời nhiều thiết bị. Là nguồn năng lượng di động lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (144, 'Cáp Lightning 1m Xmobile AL31', 125000, 1, 7, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (145, 'Cáp Lightning 1m Xmobile DR', 175000, 1, 7, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (146, 'Cáp Lightning 1m', 160000, 1, 7, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (147, 'Cáp Micro USB 1m', 150000, 1, 7, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (148, 'Cáp Micro USB 2m', 140000, 1, 7, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (149, 'Cáp Micro USB 2m', 180000, 1, 7, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);
INSERT INTO `products` VALUES (150, 'Cáp Type C - Lightning', 250000, 1, 7, 0, NULL, 5, 'Adapter Sạc là giải pháp sạc linh hoạt cho mọi thiết bị di động. Với cổng USB đa dạng, công suất lớn, và tính năng an toàn, nó đảm bảo sạc nhanh chóng và an toàn. Thiết kế nhỏ gọn và di động làm cho nó trở thành người bạn đồng hành lý tưởng cho mọi chuyến đi.', '2024-06-11', 1);

-- ----------------------------
-- Table structure for rates
-- ----------------------------
DROP TABLE IF EXISTS `rates`;
CREATE TABLE `rates`  (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `star` int NULL DEFAULT NULL,
                          `comment` int NULL DEFAULT NULL,
                          `product_id` int NOT NULL,
                          PRIMARY KEY (`id`) USING BTREE,
                          INDEX `rates_product_id_fk`(`product_id` ASC) USING BTREE,
                          CONSTRAINT `rates_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rates
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'ADMIN');
INSERT INTO `roles` VALUES (2, 'MOD');
INSERT INTO `roles` VALUES (4, 'USER');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
                          `id` int(11) NOT NULL AUTO_INCREMENT,
                          `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                          `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                          `oauth_provider` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          `oauth_uid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          `oauth_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                          `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
                          `role_id` int(11) NOT NULL,
                          `created_at` datetime NOT NULL,
                          `updated_at` datetime NOT NULL,
                          `status` int(11) NOT NULL,
                          `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          `birth` date NULL DEFAULT NULL,
                          `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          `secretKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          `twoFaEnabled` tinyint(1) NULL DEFAULT 0,
                          `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NULL DEFAULT NULL,
                          PRIMARY KEY (`id`) USING BTREE,
                          INDEX `users_roles_id_fk`(`role_id`) USING BTREE,
                          CONSTRAINT `users_roles_id_fk` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_vietnamese_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
