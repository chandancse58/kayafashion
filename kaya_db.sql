-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.17.0.7270
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for kaya_db
CREATE DATABASE IF NOT EXISTS `kaya_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `kaya_db`;

-- Dumping structure for table kaya_db.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.auth_group: ~0 rows (approximately)
DELETE FROM `auth_group`;

-- Dumping structure for table kaya_db.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.auth_group_permissions: ~0 rows (approximately)
DELETE FROM `auth_group_permissions`;

-- Dumping structure for table kaya_db.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.auth_permission: ~84 rows (approximately)
DELETE FROM `auth_permission`;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add content type', 4, 'add_contenttype'),
	(14, 'Can change content type', 4, 'change_contenttype'),
	(15, 'Can delete content type', 4, 'delete_contenttype'),
	(16, 'Can view content type', 4, 'view_contenttype'),
	(17, 'Can add session', 5, 'add_session'),
	(18, 'Can change session', 5, 'change_session'),
	(19, 'Can delete session', 5, 'delete_session'),
	(20, 'Can view session', 5, 'view_session'),
	(21, 'Can add Customer', 6, 'add_customer'),
	(22, 'Can change Customer', 6, 'change_customer'),
	(23, 'Can delete Customer', 6, 'delete_customer'),
	(24, 'Can view Customer', 6, 'view_customer'),
	(25, 'Can add Customer Address', 7, 'add_address'),
	(26, 'Can change Customer Address', 7, 'change_address'),
	(27, 'Can delete Customer Address', 7, 'delete_address'),
	(28, 'Can view Customer Address', 7, 'view_address'),
	(29, 'Can add filter attribute', 8, 'add_filterattribute'),
	(30, 'Can change filter attribute', 8, 'change_filterattribute'),
	(31, 'Can delete filter attribute', 8, 'delete_filterattribute'),
	(32, 'Can view filter attribute', 8, 'view_filterattribute'),
	(33, 'Can add Product', 9, 'add_product'),
	(34, 'Can change Product', 9, 'change_product'),
	(35, 'Can delete Product', 9, 'delete_product'),
	(36, 'Can view Product', 9, 'view_product'),
	(37, 'Can add Product Category', 10, 'add_productcategory'),
	(38, 'Can change Product Category', 10, 'change_productcategory'),
	(39, 'Can delete Product Category', 10, 'delete_productcategory'),
	(40, 'Can view Product Category', 10, 'view_productcategory'),
	(41, 'Can add Product Subcategory', 11, 'add_productsubcategory'),
	(42, 'Can change Product Subcategory', 11, 'change_productsubcategory'),
	(43, 'Can delete Product Subcategory', 11, 'delete_productsubcategory'),
	(44, 'Can view Product Subcategory', 11, 'view_productsubcategory'),
	(45, 'Can add Product Gallery Image', 12, 'add_productimage'),
	(46, 'Can change Product Gallery Image', 12, 'change_productimage'),
	(47, 'Can delete Product Gallery Image', 12, 'delete_productimage'),
	(48, 'Can view Product Gallery Image', 12, 'view_productimage'),
	(49, 'Can add filter value', 13, 'add_filtervalue'),
	(50, 'Can change filter value', 13, 'change_filtervalue'),
	(51, 'Can delete filter value', 13, 'delete_filtervalue'),
	(52, 'Can view filter value', 13, 'view_filtervalue'),
	(53, 'Can add category', 14, 'add_category'),
	(54, 'Can change category', 14, 'change_category'),
	(55, 'Can delete category', 14, 'delete_category'),
	(56, 'Can view category', 14, 'view_category'),
	(57, 'Can add Website Setting', 15, 'add_websitesetting'),
	(58, 'Can change Website Setting', 15, 'change_websitesetting'),
	(59, 'Can delete Website Setting', 15, 'delete_websitesetting'),
	(60, 'Can view Website Setting', 15, 'view_websitesetting'),
	(61, 'Can add Website Setting', 16, 'add_websitesetting'),
	(62, 'Can change Website Setting', 16, 'change_websitesetting'),
	(63, 'Can delete Website Setting', 16, 'delete_websitesetting'),
	(64, 'Can view Website Setting', 16, 'view_websitesetting'),
	(65, 'Can add Banner', 17, 'add_banner'),
	(66, 'Can change Banner', 17, 'change_banner'),
	(67, 'Can delete Banner', 17, 'delete_banner'),
	(68, 'Can view Banner', 17, 'view_banner'),
	(69, 'Can add Information Page', 18, 'add_informationpage'),
	(70, 'Can change Information Page', 18, 'change_informationpage'),
	(71, 'Can delete Information Page', 18, 'delete_informationpage'),
	(72, 'Can view Information Page', 18, 'view_informationpage'),
	(73, 'Can add payment', 19, 'add_payment'),
	(74, 'Can change payment', 19, 'change_payment'),
	(75, 'Can delete payment', 19, 'delete_payment'),
	(76, 'Can view payment', 19, 'view_payment'),
	(77, 'Can add order item', 20, 'add_orderitem'),
	(78, 'Can change order item', 20, 'change_orderitem'),
	(79, 'Can delete order item', 20, 'delete_orderitem'),
	(80, 'Can view order item', 20, 'view_orderitem'),
	(81, 'Can add order', 21, 'add_order'),
	(82, 'Can change order', 21, 'change_order'),
	(83, 'Can delete order', 21, 'delete_order'),
	(84, 'Can view order', 21, 'view_order'),
	(85, 'Can add coupon', 22, 'add_coupon'),
	(86, 'Can change coupon', 22, 'change_coupon'),
	(87, 'Can delete coupon', 22, 'delete_coupon'),
	(88, 'Can view coupon', 22, 'view_coupon'),
	(89, 'Can add product variant', 23, 'add_productvariant'),
	(90, 'Can change product variant', 23, 'change_productvariant'),
	(91, 'Can delete product variant', 23, 'delete_productvariant'),
	(92, 'Can view product variant', 23, 'view_productvariant'),
	(93, 'Can add Newsletter', 24, 'add_newsletter'),
	(94, 'Can change Newsletter', 24, 'change_newsletter'),
	(95, 'Can delete Newsletter', 24, 'delete_newsletter'),
	(96, 'Can view Newsletter', 24, 'view_newsletter'),
	(97, 'Can add review', 25, 'add_review'),
	(98, 'Can change review', 25, 'change_review'),
	(99, 'Can delete review', 25, 'delete_review'),
	(100, 'Can view review', 25, 'view_review'),
	(101, 'Can add cart item', 26, 'add_cartitem'),
	(102, 'Can change cart item', 26, 'change_cartitem'),
	(103, 'Can delete cart item', 26, 'delete_cartitem'),
	(104, 'Can view cart item', 26, 'view_cartitem'),
	(105, 'Can add Customer', 27, 'add_customer'),
	(106, 'Can change Customer', 27, 'change_customer'),
	(107, 'Can delete Customer', 27, 'delete_customer'),
	(108, 'Can view Customer', 27, 'view_customer');

-- Dumping structure for table kaya_db.categories_category
CREATE TABLE IF NOT EXISTS `categories_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `categories_category_parent_id_f141de59_fk_categories_category_id` (`parent_id`),
  CONSTRAINT `categories_category_parent_id_f141de59_fk_categories_category_id` FOREIGN KEY (`parent_id`) REFERENCES `categories_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.categories_category: ~0 rows (approximately)
DELETE FROM `categories_category`;

-- Dumping structure for table kaya_db.coupons
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `discount_type` varchar(10) NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) NOT NULL,
  `max_discount_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int(10) unsigned DEFAULT NULL CHECK (`usage_limit` >= 0),
  `used_count` int(10) unsigned NOT NULL CHECK (`used_count` >= 0),
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.coupons: ~0 rows (approximately)
DELETE FROM `coupons`;
INSERT INTO `coupons` (`id`, `code`, `discount_type`, `discount_value`, `min_order_amount`, `max_discount_amount`, `usage_limit`, `used_count`, `start_date`, `end_date`, `is_active`, `created_at`) VALUES
	(1, 'ABCD', 'FLAT', 100.00, 0.00, NULL, NULL, 0, '2026-08-29 07:58:17.000000', '2026-08-31 00:00:00.000000', 1, '2026-08-29 07:58:51.510453');

-- Dumping structure for table kaya_db.customer_addresses
CREATE TABLE IF NOT EXISTS `customer_addresses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address_line` longtext NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `pincode` varchar(6) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_addresses_customer_id_54520d4e_fk_customers_id` (`customer_id`),
  CONSTRAINT `customer_addresses_customer_id_54520d4e_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.customer_addresses: ~0 rows (approximately)
DELETE FROM `customer_addresses`;

-- Dumping structure for table kaya_db.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.customers: ~0 rows (approximately)
DELETE FROM `customers`;
INSERT INTO `customers` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `mobile`) VALUES
	(1, 'pbkdf2_sha256$600000$XxUcIb7FVYWtlXfSOd8daI$Sg8Q6SVdj+iZMQHV3Ne+qw09nA9t9Xq1t8JCVCuvDVY=', '2026-10-17 17:43:32.322706', 1, 'admin', '', '', 'admin@test.com', 1, 1, '2026-08-23 08:12:37.115865', '9999999999');

-- Dumping structure for table kaya_db.customers_groups
CREATE TABLE IF NOT EXISTS `customers_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_groups_customer_id_group_id_1325860a_uniq` (`customer_id`,`group_id`),
  KEY `customers_groups_group_id_fdf713e0_fk_auth_group_id` (`group_id`),
  CONSTRAINT `customers_groups_customer_id_c47e4788_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `customers_groups_group_id_fdf713e0_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.customers_groups: ~0 rows (approximately)
DELETE FROM `customers_groups`;

-- Dumping structure for table kaya_db.customers_user_permissions
CREATE TABLE IF NOT EXISTS `customers_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_user_permissio_customer_id_permission_i_227f9e91_uniq` (`customer_id`,`permission_id`),
  KEY `customers_user_permi_permission_id_20d0445e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `customers_user_permi_permission_id_20d0445e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `customers_user_permissions_customer_id_a2937193_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.customers_user_permissions: ~0 rows (approximately)
DELETE FROM `customers_user_permissions`;

-- Dumping structure for table kaya_db.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_customers_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_customers_id` FOREIGN KEY (`user_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.django_admin_log: ~140 rows (approximately)
DELETE FROM `django_admin_log`;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2026-08-23 08:13:28.569613', '1', 'Chikankari Saree (Uttar Pradesh)', 1, '[{"added": {}}]', 10, 1),
	(2, '2026-08-23 08:13:52.003737', '1', 'Chikankari Saree (Uttar Pradesh) -> Traditional Saree', 1, '[{"added": {}}]', 11, 1),
	(3, '2026-08-23 08:16:38.212157', '1', 'Shiny Doshi Wine Silk Woven Kanjivaram Saree', 1, '[{"added": {}}, {"added": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 1)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 2)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 3)"}}]', 9, 1),
	(4, '2026-08-23 12:25:15.420642', '1', 'Kaya Fashion', 1, '[{"added": {}}]', 16, 1),
	(5, '2026-08-23 12:44:24.628701', '1', 'Kaya', 1, '[{"added": {}}]', 17, 1),
	(6, '2026-08-23 12:44:45.568716', '2', 'sss', 1, '[{"added": {}}]', 17, 1),
	(7, '2026-08-23 12:59:07.387597', '1', 'About Us', 1, '[{"added": {}}]', 18, 1),
	(8, '2026-08-29 07:58:51.511466', '1', 'ABCD - (Flat Amount Discount (₹/$))', 1, '[{"added": {}}]', 22, 1),
	(9, '2026-09-06 07:42:33.634731', '1', 'Chikankari Saree', 2, '[{"changed": {"fields": ["Category Name"]}}]', 10, 1),
	(10, '2026-09-06 07:47:47.473776', '2', 'CHANDERI SAREE', 1, '[{"added": {}}]', 10, 1),
	(11, '2026-09-06 07:48:08.042259', '1', 'Chikankari Saree', 2, '[{"changed": {"fields": ["Slug", "Display Title"]}}]', 10, 1),
	(12, '2026-09-06 07:51:59.345604', '3', 'Silk Sarees', 1, '[{"added": {}}]', 10, 1),
	(13, '2026-09-06 07:55:03.103346', '4', 'Designer Sarees', 1, '[{"added": {}}]', 10, 1),
	(14, '2026-09-06 07:56:33.879711', '5', 'Printed Sarees', 1, '[{"added": {}}]', 10, 1),
	(15, '2026-09-06 07:57:52.118419', '6', 'Handloom Sarees', 1, '[{"added": {}}]', 10, 1),
	(16, '2026-09-06 08:01:50.820148', '2', 'Cotton Sarees', 2, '[{"changed": {"fields": ["Category Name", "Slug", "Display Title", "Description", "Thumbnail Image", "Cover Image"]}}]', 10, 1),
	(17, '2026-09-06 08:05:28.296212', '1', 'Wedding & Festive', 2, '[{"changed": {"fields": ["Category Name", "Slug", "Display Title", "Description", "Thumbnail Image", "Cover Image"]}}]', 10, 1),
	(18, '2026-09-06 08:14:02.751641', '1', 'Wedding & Festive -> Bridal Sarees', 2, '[{"changed": {"fields": ["Subcategory Name", "Slug", "Display Title", "Description", "Thumbnail Image", "Cover Image"]}}]', 11, 1),
	(19, '2026-10-02 11:28:51.467989', '1', 'Kaya', 2, '[{"changed": {"fields": ["Banner Image"]}}]', 17, 1),
	(20, '2026-10-02 11:29:08.594801', '2', 'sss', 2, '[{"changed": {"fields": ["Banner Image"]}}]', 17, 1),
	(21, '2026-10-02 12:09:41.644058', '2', 'Cotton Sarees', 2, '[]', 10, 1),
	(22, '2026-10-02 18:03:38.542451', '2', 'Banarasi Sarees', 2, '[{"changed": {"fields": ["Category Name", "Slug", "Display Title", "Description", "Thumbnail Image", "Cover Image"]}}]', 10, 1),
	(23, '2026-10-02 18:05:25.370192', '4', 'Designer Sarees', 2, '[{"changed": {"fields": ["Thumbnail Image", "Cover Image"]}}]', 10, 1),
	(24, '2026-10-02 18:06:00.299268', '6', 'Handloom Sarees', 2, '[{"changed": {"fields": ["Thumbnail Image", "Cover Image"]}}]', 10, 1),
	(25, '2026-10-02 18:08:42.651838', '5', 'Printed Sarees', 2, '[{"changed": {"fields": ["Thumbnail Image", "Cover Image"]}}]', 10, 1),
	(26, '2026-10-02 18:09:12.321593', '3', 'Silk Sarees', 2, '[{"changed": {"fields": ["Thumbnail Image", "Cover Image"]}}]', 10, 1),
	(27, '2026-10-02 18:11:00.230187', '1', 'Banner1', 2, '[{"changed": {"fields": ["Banner Title", "Subtitle", "Banner Image"]}}]', 17, 1),
	(28, '2026-10-02 18:20:26.892991', '2', 'Dewali Festival', 2, '[{"changed": {"fields": ["Banner Title", "Subtitle", "Banner Image"]}}]', 17, 1),
	(29, '2026-10-02 19:44:44.332056', '1', 'Shiny Doshi Wine Silk Woven Kanjivaram Saree', 2, '[{"changed": {"fields": ["Description", "Key Features", "Is Featured"]}}, {"added": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 4)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 5)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 6)"}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 1)", "fields": ["Gallery Image", "Sort Order"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 2)", "fields": ["Gallery Image", "Sort Order"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Shiny Doshi Wine Silk Woven Kanjivaram Saree (ID: 3)", "fields": ["Gallery Image", "Sort Order", "Is Primary/Featured Gallery Image"]}}]', 9, 1),
	(30, '2026-10-02 20:07:36.457736', '1', 'Deep Green Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Product Name", "Slug", "Product Image", "Category", "Description", "Key Features"]}}]', 9, 1),
	(31, '2026-10-02 20:09:21.857629', '1', 'Color', 1, '[{"added": {}}, {"added": {"name": "filter value", "object": "Color: Green"}}, {"added": {"name": "filter value", "object": "Color: Blue"}}, {"added": {"name": "filter value", "object": "Color: Red"}}, {"added": {"name": "filter value", "object": "Color: Maroon"}}, {"added": {"name": "filter value", "object": "Color: Pink"}}]', 8, 1),
	(32, '2026-10-02 20:12:24.242208', '1', 'Deep Green Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["SEO Title", "Meta Description"]}}]', 9, 1),
	(33, '2026-10-02 20:31:54.109121', '1', 'Deep Green Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Description", "Key Features", "Product MRP Price", "Product Discount", "Meta Description"]}}]', 9, 1),
	(34, '2026-10-02 20:33:29.795221', '1', 'Deep Green Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Key Features", "Product Quantity"]}}]', 9, 1),
	(35, '2026-10-02 20:37:51.723555', '2', 'Designer Border and Traditional Floral Pattern', 1, '[{"added": {}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern (ID: 7)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern (ID: 8)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern (ID: 9)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern (ID: 10)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern (ID: 11)"}}]', 9, 1),
	(36, '2026-10-02 20:38:42.563162', '1', 'Deep Green Embroidered Georgette Saree', 2, '[{"changed": {"name": "Product Gallery Image", "object": "Image for Deep Green Embroidered Georgette Saree (ID: 3)", "fields": ["Gallery Image"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Green Embroidered Georgette Saree (ID: 1)", "fields": ["Gallery Image"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Green Embroidered Georgette Saree (ID: 2)", "fields": ["Gallery Image"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Green Embroidered Georgette Saree (ID: 5)", "fields": ["Gallery Image"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Green Embroidered Georgette Saree (ID: 6)", "fields": ["Gallery Image"]}}]', 9, 1),
	(37, '2026-10-02 20:46:55.833047', '1', 'Deep Green Embroidered Georgette Saree', 2, '[{"changed": {"name": "Product Gallery Image", "object": "Image for Deep Green Embroidered Georgette Saree (ID: 4)", "fields": ["Gallery Image"]}}]', 9, 1),
	(38, '2026-10-02 22:00:10.078242', '1', 'Deep Green Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Product MRP Price", "Product Discount"]}}]', 9, 1),
	(39, '2026-10-02 22:44:13.115288', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Product Name", "Slug", "Category", "Description", "Key Features"]}}, {"added": {"name": "Product Variant", "object": "Deep Plum Embroidered Georgette Saree (Free / Deep Plum)"}}]', 9, 1),
	(40, '2026-10-02 22:48:23.618464', '2', 'Designer Border and Traditional Floral Pattern', 2, '[{"changed": {"fields": ["Product Image", "Category", "Product MRP Price", "Product Discount"]}}, {"added": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern (Free / Pink)"}}, {"added": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern (Free / Pink)"}}]', 9, 1),
	(41, '2026-10-02 22:49:41.545580', '2', 'Designer Border and Traditional Floral Pattern', 2, '[{"added": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern (Free / Blue)"}}, {"changed": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern (Free / Red)", "fields": ["SKU Code", "Color"]}}]', 9, 1),
	(42, '2026-10-02 22:53:44.556079', '3', 'Designer Border and Traditional Floral Pattern(Purple)', 1, '[{"added": {}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern(Purple) (ID: 12)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern(Purple) (ID: 13)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern(Purple) (ID: 14)"}}, {"added": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern(Purple) (Free / Purple)"}}]', 9, 1),
	(43, '2026-10-02 22:53:58.050199', '3', 'Designer Border and Traditional Floral Pattern(Purple)', 2, '[{"changed": {"fields": ["Minimum Order Quantity"]}}]', 9, 1),
	(44, '2026-10-02 22:53:58.052800', '2', 'Designer Border and Traditional Floral Pattern', 2, '[{"changed": {"fields": ["Minimum Order Quantity"]}}]', 9, 1),
	(45, '2026-10-02 23:12:49.602813', '3', 'Designer Border and Traditional Floral Pattern(Purple)', 2, '[{"changed": {"fields": ["Product Image"]}}]', 9, 1),
	(46, '2026-10-02 23:14:18.849572', '2', 'Designer Border and Traditional Floral Pattern', 2, '[{"changed": {"fields": ["Product Image"]}}]', 9, 1),
	(47, '2026-10-02 23:15:04.405082', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Product Image"]}}]', 9, 1),
	(48, '2026-10-02 23:23:24.455431', '4', 'Elegant Peacock Blue Georgette Saree', 1, '[{"added": {}}, {"added": {"name": "Product Gallery Image", "object": "Image for Elegant Peacock Blue Georgette Saree (ID: 15)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Elegant Peacock Blue Georgette Saree (ID: 16)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Elegant Peacock Blue Georgette Saree (ID: 17)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Elegant Peacock Blue Georgette Saree (ID: 18)"}}, {"added": {"name": "Product Variant", "object": "Elegant Peacock Blue Georgette Saree (Free / Yellow)"}}]', 9, 1),
	(49, '2026-10-02 23:24:07.078864', '4', 'Elegant Yellow Georgette Saree', 2, '[{"changed": {"fields": ["Product Name", "Slug"]}}]', 9, 1),
	(50, '2026-10-02 23:49:48.823439', '1', 'About Us', 2, '[{"changed": {"fields": ["Description"]}}]', 18, 1),
	(51, '2026-10-02 23:55:52.773216', '1', 'About Us', 2, '[{"changed": {"fields": ["Description"]}}]', 18, 1),
	(52, '2026-10-03 00:59:15.997125', '1', 'About Us', 2, '[{"changed": {"fields": ["Description"]}}]', 18, 1),
	(53, '2026-10-08 10:56:42.591380', '5', 'Bandhani Printed Saree', 1, '[{"added": {}}, {"added": {"name": "Product Gallery Image", "object": "Image for Bandhani Printed Saree (ID: 19)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Bandhani Printed Saree (ID: 20)"}}, {"added": {"name": "Product Variant", "object": "Bandhani Printed Saree (Yellow)"}}]', 9, 1),
	(54, '2026-10-08 10:57:42.566979', '5', 'Bandhani Printed Saree', 2, '[{"changed": {"fields": ["Product Image"]}}]', 9, 1),
	(55, '2026-10-08 11:02:18.040319', '5', 'Bandhani Printed Saree', 2, '[{"changed": {"fields": ["Product Image"]}}]', 9, 1),
	(56, '2026-10-08 11:08:40.881856', '6', 'Georgette Saree styles like Heavy Border Work Designer', 1, '[{"added": {}}, {"added": {"name": "Product Gallery Image", "object": "Image for Georgette Saree styles like Heavy Border Work Designer (ID: 21)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Georgette Saree styles like Heavy Border Work Designer (ID: 22)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Georgette Saree styles like Heavy Border Work Designer (ID: 23)"}}, {"added": {"name": "Product Variant", "object": "Georgette Saree styles like Heavy Border Work Designer (B0HLH3JTJS)"}}]', 9, 1),
	(57, '2026-10-08 11:11:27.549301', '7', 'Silk Saree with Designer Border and Traditional Floral Pattern', 1, '[{"added": {}}, {"added": {"name": "Product Variant", "object": "Silk Saree with Designer Border and Traditional Floral Pattern (B0HLLDWHDG)"}}]', 9, 1),
	(58, '2026-10-08 11:12:49.238628', '6', 'Georgette Saree styles like Heavy Border Work Designer', 2, '[{"changed": {"fields": ["Is Featured"]}}, {"changed": {"name": "Product Variant", "object": "Georgette Saree styles like Heavy Border Work Designer (B0HLH3JTJS)", "fields": ["Stock Quantity"]}}]', 9, 1),
	(59, '2026-10-08 11:13:13.795663', '2', 'Designer Border and Traditional Floral Pattern', 2, '[]', 9, 1),
	(60, '2026-10-08 11:13:30.559500', '2', 'Designer Border and Traditional Floral Pattern', 2, '[]', 9, 1),
	(61, '2026-10-08 11:15:23.777446', '2', 'Designer Border and Traditional Floral Pattern-Green', 2, '[{"changed": {"fields": ["Product Name", "Slug", "Is Popular"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Designer Border and Traditional Floral Pattern-Green (ID: 7)", "fields": ["Is Primary/Featured Gallery Image"]}}]', 9, 1),
	(62, '2026-10-08 11:15:56.482856', '2', 'Designer Border and Traditional Floral Pattern-Green', 2, '[{"changed": {"fields": ["Category"]}}]', 9, 1),
	(63, '2026-10-08 11:16:22.369423', '2', 'Designer Border and Traditional Floral Pattern-Green', 2, '[{"deleted": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern-Green (Free / Red)"}}, {"deleted": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern-Green (Free / Pink)"}}, {"deleted": {"name": "Product Variant", "object": "Designer Border and Traditional Floral Pattern-Green (Free / Blue)"}}]', 9, 1),
	(64, '2026-10-08 11:16:49.543346', '2', 'Designer Border and Traditional Floral Pattern-Green', 2, '[{"changed": {"fields": ["Is Featured"]}}]', 9, 1),
	(65, '2026-10-08 11:17:23.780481', '3', 'Designer Border and Traditional Floral Pattern(Purple)', 2, '[{"changed": {"fields": ["Minimum Order Quantity"]}}]', 9, 1),
	(66, '2026-10-08 11:17:23.782416', '2', 'Designer Border and Traditional Floral Pattern-Green', 2, '[{"changed": {"fields": ["Minimum Order Quantity"]}}]', 9, 1),
	(67, '2026-10-08 11:17:23.786239', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Minimum Order Quantity"]}}]', 9, 1),
	(68, '2026-10-08 11:20:34.081024', '7', 'Silk Saree with Designer Border', 2, '[{"changed": {"fields": ["Product Name", "Slug", "Product Image"]}}, {"added": {"name": "Product Gallery Image", "object": "Image for Silk Saree with Designer Border (ID: 24)"}}, {"deleted": {"name": "Product Variant", "object": "Silk Saree with Designer Border (B0HLLDWHDG)"}}]', 9, 1),
	(69, '2026-10-08 11:21:14.220735', '7', 'Silk Saree with Designer Border', 2, '[{"changed": {"fields": ["Is New Product"]}}]', 9, 1),
	(70, '2026-10-08 12:17:35.249781', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 1, '[{"added": {}}, {"added": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (DISGN-KAT-GRB-001)"}}]', 9, 1),
	(71, '2026-10-08 14:50:36.836409', '3', 'Exclusive Collection', 1, '[{"added": {}}]', 17, 1),
	(72, '2026-10-08 14:51:07.698199', '4', 'Diwali Collection', 1, '[{"added": {}}]', 17, 1),
	(73, '2026-10-08 16:59:01.595973', '7', 'Silk Saree with Designer Border', 2, '[{"changed": {"fields": ["Product Image"]}}]', 9, 1),
	(74, '2026-10-08 17:07:38.714838', '5', 'Collection', 1, '[{"added": {}}]', 17, 1),
	(75, '2026-10-08 17:08:05.411106', '6', 'Collection', 1, '[{"added": {}}]', 17, 1),
	(76, '2026-10-08 17:15:00.843767', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(77, '2026-10-08 17:16:08.305288', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(78, '2026-10-10 05:20:57.781602', '7', 'Silk Saree with Designer Border', 2, '[]', 9, 1),
	(79, '2026-10-10 06:10:48.094334', '1', 'Saree Fashion Trends', 1, '[{"added": {}}]', 24, 1),
	(80, '2026-10-10 08:30:37.643755', '1', 'Saree Fashion Trends', 2, '[{"changed": {"fields": ["Textbox", "Image"]}}]', 24, 1),
	(81, '2026-10-10 08:35:19.361025', '2', '5 Beautiful Saree Colours for the Festive Season', 1, '[{"added": {}}]', 24, 1),
	(82, '2026-10-10 08:39:54.963447', '3', 'How to Care for Your Silk and Printed Sarees', 1, '[{"added": {}}]', 24, 1),
	(83, '2026-10-10 08:40:03.130062', '2', '5 Beautiful Saree Colours for the Festive Season', 2, '[{"changed": {"fields": ["Status"]}}]', 24, 1),
	(84, '2026-10-10 08:40:09.808596', '3', 'How to Care for Your Silk and Printed Sarees', 2, '[{"changed": {"fields": ["Status"]}}]', 24, 1),
	(85, '2026-10-10 08:55:41.117710', '3', 'How to Care for Your Silk and Printed Sarees', 2, '[{"changed": {"fields": ["Image"]}}]', 24, 1),
	(86, '2026-10-10 08:55:56.014665', '2', '5 Beautiful Saree Colours for the Festive Season', 2, '[{"changed": {"fields": ["Image"]}}]', 24, 1),
	(87, '2026-10-10 08:56:19.858737', '1', 'Saree Fashion Trends', 2, '[{"changed": {"fields": ["Image"]}}]', 24, 1),
	(88, '2026-10-10 08:58:12.999970', '4', 'Saree Styling Guide: How to Look Elegant for Every Occasion', 1, '[{"added": {}}]', 24, 1),
	(89, '2026-10-10 09:58:07.841223', '4', 'Saree Styling Guide: How to Look Elegant for Every Occasion', 2, '[{"changed": {"fields": ["Slug"]}}]', 24, 1),
	(90, '2026-10-10 09:58:26.634333', '3', 'How to Care for Your Silk and Printed Sarees', 2, '[{"changed": {"fields": ["Slug"]}}]', 24, 1),
	(91, '2026-10-10 09:58:44.746745', '2', '5 Beautiful Saree Colours for the Festive Season', 2, '[{"changed": {"fields": ["Slug"]}}]', 24, 1),
	(92, '2026-10-10 09:59:04.146624', '1', 'Saree Fashion Trends', 2, '[{"changed": {"fields": ["Slug"]}}]', 24, 1),
	(93, '2026-10-10 10:19:43.623900', '1', 'Saree Fashion Trends', 2, '[{"changed": {"fields": ["Image"]}}]', 24, 1),
	(94, '2026-10-10 12:04:04.098814', '2', 'Price', 1, '[{"added": {}}, {"added": {"name": "filter value", "object": "Price: 500-600"}}, {"added": {"name": "filter value", "object": "Price: 600-700"}}, {"added": {"name": "filter value", "object": "Price: 700-800"}}, {"added": {"name": "filter value", "object": "Price: 800-1000"}}]', 8, 1),
	(95, '2026-10-10 12:04:53.503333', '2', 'Color: Blue', 2, '[{"changed": {"fields": ["Color code"]}}]', 13, 1),
	(96, '2026-10-10 12:05:16.750393', '1', 'Color: Green', 2, '[{"changed": {"fields": ["Color code"]}}]', 13, 1),
	(97, '2026-10-10 12:05:36.556724', '4', 'Color: Maroon', 2, '[{"changed": {"fields": ["Color code"]}}]', 13, 1),
	(98, '2026-10-10 12:05:56.047020', '5', 'Color: Pink', 2, '[{"changed": {"fields": ["Color code"]}}]', 13, 1),
	(99, '2026-10-10 12:06:08.597007', '3', 'Color: Red', 2, '[{"changed": {"fields": ["Color code"]}}]', 13, 1),
	(100, '2026-10-11 08:23:57.148079', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"added": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Pink)"}}, {"added": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Blue)"}}, {"changed": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Red)", "fields": ["Size", "Color"]}}]', 9, 1),
	(101, '2026-10-11 09:04:16.224408', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"added": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Maroon)"}}]', 9, 1),
	(102, '2026-10-11 09:04:48.849604', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"changed": {"fields": ["Category"]}}]', 9, 1),
	(103, '2026-10-11 09:06:20.591295', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(104, '2026-10-11 09:16:27.963071', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(105, '2026-10-11 09:17:57.544748', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(106, '2026-10-11 09:18:44.261409', '7', 'Silk Saree with Designer Border', 2, '[{"changed": {"fields": ["Category"]}}, {"added": {"name": "Product Variant", "object": "Silk Saree with Designer Border (Free / Green)"}}]', 9, 1),
	(107, '2026-10-11 09:28:02.330415', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(108, '2026-10-11 09:32:21.595119', '7', 'Silk Saree with Designer Border', 2, '[{"added": {"name": "product variant", "object": "Silk Saree with Designer Border (Free / Pink)"}}]', 9, 1),
	(109, '2026-10-11 09:40:38.144963', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(110, '2026-10-11 09:45:09.170165', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(111, '2026-10-11 09:45:54.669319', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(112, '2026-10-11 09:47:00.829487', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[{"added": {"name": "Product Variant", "object": "Deep Plum Embroidered Georgette Saree (Free / Pink)"}}]', 9, 1),
	(113, '2026-10-11 13:29:11.672153', '1', 'Banner1', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(114, '2026-10-11 13:29:19.241584', '2', 'Dewali Festival', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(115, '2026-10-11 13:29:28.681488', '3', 'Exclusive Collection', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(116, '2026-10-11 13:29:36.561626', '4', 'Diwali Collection', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(117, '2026-10-11 13:30:01.666033', '5', 'Collection', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(118, '2026-10-11 13:31:09.511885', '1', 'Banner1', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(119, '2026-10-11 13:31:18.896429', '2', 'Dewali Festival', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(120, '2026-10-11 13:31:25.246449', '3', 'Exclusive Collection', 2, '[]', 17, 1),
	(121, '2026-10-11 13:31:35.448458', '4', 'Diwali Collection', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(122, '2026-10-11 13:31:53.624780', '5', 'Collection', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(123, '2026-10-11 13:31:57.580468', '6', 'Collection', 2, '[{"changed": {"fields": ["Banner Type"]}}]', 17, 1),
	(124, '2026-10-11 17:47:44.874031', '4', 'Elegant Yellow Georgette Saree', 2, '[{"changed": {"fields": ["Product Code"]}}]', 9, 1),
	(125, '2026-10-11 17:50:05.974426', '5', 'Bandhani Printed Saree', 2, '[{"changed": {"fields": ["Product Code"]}}, {"added": {"name": "Product Gallery Image", "object": "Image for Bandhani Printed Saree (ID: 25)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Bandhani Printed Saree (ID: 26)"}}]', 9, 1),
	(126, '2026-10-11 18:09:54.166811', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"changed": {"fields": ["Product Code"]}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 27)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 28)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 29)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 30)"}}]', 9, 1),
	(127, '2026-10-17 06:20:38.249485', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[]', 9, 1),
	(128, '2026-10-17 06:26:09.748785', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[{"changed": {"fields": ["Description", "Key Features"]}}, {"added": {"name": "Product Variant", "object": "Deep Plum Embroidered Georgette Saree (Free / Green)"}}]', 9, 1),
	(129, '2026-10-17 06:41:05.604304', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[]', 9, 1),
	(130, '2026-10-17 06:42:48.313954', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[]', 9, 1),
	(131, '2026-10-17 07:02:26.031805', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[{"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 31)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 32)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 33)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 34)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 35)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 36)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 37)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 38)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 39)"}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 3)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 1)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 2)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 4)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 5)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Deep Plum Embroidered Georgette Saree (ID: 6)", "fields": ["Variant"]}}]', 9, 1),
	(132, '2026-10-17 08:22:24.582813', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 40)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 41)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 42)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 43)"}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 27)", "fields": ["Sort Order"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 28)", "fields": ["Sort Order"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 29)", "fields": ["Sort Order"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 30)", "fields": ["Sort Order"]}}]', 9, 1),
	(133, '2026-10-17 08:24:56.285548', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"deleted": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Pink)"}}, {"deleted": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Blue)"}}, {"deleted": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Maroon)"}}]', 9, 1),
	(134, '2026-10-17 08:25:43.730045', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 27)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 28)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 29)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 30)", "fields": ["Variant"]}}]', 9, 1),
	(135, '2026-10-17 08:27:38.360486', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"deleted": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: None)"}}, {"deleted": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: None)"}}, {"deleted": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: None)"}}, {"deleted": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: None)"}}]', 9, 1),
	(136, '2026-10-17 08:28:44.895034', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"changed": {"fields": ["Product Image"]}}]', 9, 1),
	(137, '2026-10-17 08:32:35.550062', '12', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer Green', 1, '[{"added": {}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer Green (ID: 44)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer Green (ID: 45)"}}, {"added": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer Green (Free / Green)"}}]', 9, 1),
	(138, '2026-10-17 08:34:27.773761', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 46)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 47)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 48)"}}, {"added": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 49)"}}]', 9, 1),
	(139, '2026-10-17 08:35:07.080402', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"added": {"name": "Product Variant", "object": "Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (Free / Green)"}}]', 9, 1),
	(140, '2026-10-17 08:36:34.958931', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(141, '2026-10-17 08:41:23.892088', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(142, '2026-10-17 08:43:47.176745', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(143, '2026-10-17 11:20:51.637598', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[]', 9, 1),
	(144, '2026-10-17 11:21:15.909272', '12', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer Green', 2, '[{"changed": {"fields": ["Status"]}}]', 9, 1),
	(145, '2026-10-17 11:34:14.953232', '1', 'Deep Plum Embroidered Georgette Saree', 2, '[]', 9, 1),
	(146, '2026-10-17 11:36:02.948269', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 40)", "fields": ["Is Primary/Featured Gallery Image"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 47)", "fields": ["Is Primary/Featured Gallery Image"]}}]', 9, 1),
	(147, '2026-10-17 11:37:47.810004', '11', 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 2, '[{"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 46)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 47)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 48)", "fields": ["Variant"]}}, {"changed": {"name": "Product Gallery Image", "object": "Image for Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer (ID: 49)", "fields": ["Variant"]}}]', 9, 1);

-- Dumping structure for table kaya_db.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.django_content_type: ~18 rows (approximately)
DELETE FROM `django_content_type`;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(2, 'auth', 'permission'),
	(3, 'auth', 'group'),
	(4, 'contenttypes', 'contenttype'),
	(5, 'sessions', 'session'),
	(6, 'accounts', 'customer'),
	(7, 'accounts', 'address'),
	(8, 'products', 'filterattribute'),
	(9, 'products', 'product'),
	(10, 'products', 'productcategory'),
	(11, 'products', 'productsubcategory'),
	(12, 'products', 'productimage'),
	(13, 'products', 'filtervalue'),
	(14, 'categories', 'category'),
	(15, 'settings', 'websitesetting'),
	(16, 'site_settings', 'websitesetting'),
	(17, 'site_settings', 'banner'),
	(18, 'site_settings', 'informationpage'),
	(19, 'orders', 'payment'),
	(20, 'orders', 'orderitem'),
	(21, 'orders', 'order'),
	(22, 'orders', 'coupon'),
	(23, 'products', 'productvariant'),
	(24, 'newsletters', 'newsletter'),
	(25, 'products', 'review'),
	(26, 'products', 'cartitem'),
	(27, 'products', 'customer');

-- Dumping structure for table kaya_db.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.django_migrations: ~42 rows (approximately)
DELETE FROM `django_migrations`;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2026-08-23 08:03:29.861499'),
	(2, 'contenttypes', '0002_remove_content_type_name', '2026-08-23 08:03:29.970535'),
	(3, 'auth', '0001_initial', '2026-08-23 08:03:30.427676'),
	(4, 'auth', '0002_alter_permission_name_max_length', '2026-08-23 08:03:30.598859'),
	(5, 'auth', '0003_alter_user_email_max_length', '2026-08-23 08:03:30.610759'),
	(6, 'auth', '0004_alter_user_username_opts', '2026-08-23 08:03:30.622096'),
	(7, 'auth', '0005_alter_user_last_login_null', '2026-08-23 08:03:30.635269'),
	(8, 'auth', '0006_require_contenttypes_0002', '2026-08-23 08:03:30.646903'),
	(9, 'auth', '0007_alter_validators_add_error_messages', '2026-08-23 08:03:30.655717'),
	(10, 'auth', '0008_alter_user_username_max_length', '2026-08-23 08:03:30.665088'),
	(11, 'auth', '0009_alter_user_last_name_max_length', '2026-08-23 08:03:30.675806'),
	(12, 'auth', '0010_alter_group_name_max_length', '2026-08-23 08:03:30.694808'),
	(13, 'auth', '0011_update_proxy_permissions', '2026-08-23 08:03:30.706892'),
	(14, 'auth', '0012_alter_user_first_name_max_length', '2026-08-23 08:03:30.757125'),
	(15, 'accounts', '0001_initial', '2026-08-23 08:03:32.053777'),
	(16, 'admin', '0001_initial', '2026-08-23 08:03:32.453639'),
	(17, 'admin', '0002_logentry_remove_auto_add', '2026-08-23 08:03:32.466649'),
	(18, 'admin', '0003_logentry_add_action_flag_choices', '2026-08-23 08:03:32.517169'),
	(19, 'categories', '0001_initial', '2026-08-23 08:03:32.692639'),
	(20, 'categories', '0002_alter_category_options_category_created_at_and_more', '2026-08-23 08:03:34.397033'),
	(21, 'products', '0001_initial', '2026-08-23 08:03:35.899059'),
	(22, 'sessions', '0001_initial', '2026-08-23 08:03:36.099249'),
	(23, 'settings', '0001_initial', '2026-08-23 08:03:36.128707'),
	(25, 'site_settings', '0002_alter_websitesetting_contact_number', '2026-08-23 08:47:41.178071'),
	(26, 'site_settings', '0001_initial', '2026-08-23 08:52:41.489074'),
	(27, 'site_settings', '0002_banner', '2026-08-23 12:42:41.448044'),
	(28, 'site_settings', '0003_informationpage', '2026-08-23 12:57:59.911209'),
	(29, 'orders', '0001_initial', '2026-08-23 13:31:52.541811'),
	(30, 'orders', '0002_coupon', '2026-08-29 07:33:15.905029'),
	(31, 'products', '0002_alter_product_description_productvariant_and_more', '2026-10-02 20:45:33.298207'),
	(32, 'products', '0003_remove_product_dist_price_remove_product_mrp_price', '2026-10-02 21:00:19.639410'),
	(33, 'products', '0004_alter_productvariant_options_and_more', '2026-10-02 21:58:47.313736'),
	(34, 'products', '0005_alter_productvariant_options_product_productcode', '2026-10-10 05:16:49.641445'),
	(35, 'products', '0006_alter_product_productcode', '2026-10-10 05:25:37.133299'),
	(36, 'newsletters', '0001_initial', '2026-10-10 05:55:41.475441'),
	(37, 'newsletters', '0002_newsletter_slug_alter_newsletter_textbox', '2026-10-10 09:45:22.776866'),
	(38, 'products', '0007_alter_product_dist_price', '2026-10-11 08:50:27.728840'),
	(39, 'products', '0008_alter_product_dist_price', '2026-10-11 08:50:27.834172'),
	(40, 'products', '0002_productvariant_product_productcode_and_more', '2026-10-11 08:56:55.810809'),
	(41, 'products', '0003_product_productcode', '2026-10-11 08:58:59.620930'),
	(42, 'products', '0004_productvariant_alter_product_description_and_more', '2026-10-11 09:02:15.143563'),
	(43, 'site_settings', '0004_banner_banner_type_alter_informationpage_description', '2026-10-11 09:03:02.599988'),
	(44, 'products', '0005_alter_productvariant_options', '2026-10-11 09:31:46.627690'),
	(45, 'products', '0006_alter_productvariant_options_review', '2026-10-11 18:41:56.453407'),
	(46, 'products', '0007_alter_productimage_image', '2026-10-17 11:41:31.378704'),
	(47, 'products', '0008_cartitem_customer', '2026-10-17 12:38:05.629501'),
	(48, 'products', '0009_cartitem_customer', '2026-10-17 18:01:14.879909'),
	(49, 'products', '0008_customer', '2026-10-17 18:37:32.216555'),
	(50, 'orders', '0003_orderitem_session_key', '2026-10-17 18:46:11.621442'),
	(51, 'orders', '0004_remove_orderitem_session_key_order_session_key', '2026-10-17 18:55:17.948259'),
	(52, 'orders', '0005_alter_order_customer', '2026-10-17 19:32:11.779106'),
	(53, 'orders', '0006_order_razorpay_payment_link_id', '2026-10-18 12:05:49.805739'),
	(54, 'orders', '0007_order_razorpay_order_id_order_razorpay_payment_id', '2026-10-18 13:17:59.267281'),
	(55, 'orders', '0008_payment_razorpay_order_id_and_more', '2026-10-18 18:19:23.592954');

-- Dumping structure for table kaya_db.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.django_session: ~6 rows (approximately)
DELETE FROM `django_session`;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('6oxmlolxncta7dwvgpixtkq2anmxkoz8', '.eJxVjDsOwjAQBe_iGlnexL9Q0nMGa3e9xgEUS_lUiLtDpBTQvpl5L5VwW2vaFpnTmNVZgTr9boT8kGkH-Y7TrWlu0zqPpHdFH3TR15bleTncv4OKS_3WMaKj4shnBs8hGCsCZchihq5HTxIZTXa2hB4EvKcOYuHBO-s6RiD1_gD4MDgy:1xCbwf:X97GpXyi_07aUD6KiPV_ABxae3D6el7m_hIwbkEw2gM', '2026-10-16 12:00:57.627218'),
	('ctzcp9fxzcktbx0aab2v7fvu9nf4v2ia', '.eJxVjDsOwjAQBe_iGlnexL9Q0nMGa3e9xgEUS_lUiLtDpBTQvpl5L5VwW2vaFpnTmNVZgTr9boT8kGkH-Y7TrWlu0zqPpHdFH3TR15bleTncv4OKS_3WMaKj4shnBs8hGCsCZchihq5HTxIZTXa2hB4EvKcOYuHBO-s6RiD1_gD4MDgy:1x0Dhk:W0JXXft9PJn5Z6lz7iRF2gdg_yqXN3-kDwZozZKXjPQ', '2026-09-12 07:42:20.488734'),
	('gyj4ls4b66gfsd52zt5trd04b0da0ct8', '.eJxVjDsOwjAQBe_iGlnexL9Q0nMGa3e9xgEUS_lUiLtDpBTQvpl5L5VwW2vaFpnTmNVZgTr9boT8kGkH-Y7TrWlu0zqPpHdFH3TR15bleTncv4OKS_3WMaKj4shnBs8hGCsCZchihq5HTxIZTXa2hB4EvKcOYuHBO-s6RiD1_gD4MDgy:1xHxwj:GEwXp0M7DRnA-W8Df0DpoEmqUxFwlEKjy86ofHGqgtM', '2026-10-31 06:31:09.332297'),
	('krsf759nqwllb0q3f8r9daxdyuwmrsym', '.eJxVjDsOwjAQBe_iGlnexL9Q0nMGa3e9xgEUS_lUiLtDpBTQvpl5L5VwW2vaFpnTmNVZgTr9boT8kGkH-Y7TrWlu0zqPpHdFH3TR15bleTncv4OKS_3WMaKj4shnBs8hGCsCZchihq5HTxIZTXa2hB4EvKcOYuHBO-s6RiD1_gD4MDgy:1wy3KG:RB1Q7VoJGPhQklrEgoLEPhr-YyB4AH_ewDF2Xg9rMUc', '2026-09-06 08:13:08.040845'),
	('nwi7a1lwqne8k18wl1vfttyh3zemgkbb', '.eJxVjDsOwjAQBe_iGlnexL9Q0nMGa3e9xgEUS_lUiLtDpBTQvpl5L5VwW2vaFpnTmNVZgTr9boT8kGkH-Y7TrWlu0zqPpHdFH3TR15bleTncv4OKS_3WMaKj4shnBs8hGCsCZchihq5HTxIZTXa2hB4EvKcOYuHBO-s6RiD1_gD4MDgy:1x0DAk:LsISZ1M-_XH9y6zUvjx1T-TKCLEymh2FxyyD2Mb3-ZQ', '2026-09-12 07:08:14.814078'),
	('uh0xudze17delkhv6sd57hh750j9k97t', '.eJxVj81OwzAQhN_FZxTZSew4PdJDBai3Hiou1tpeN4HUDv5Booh3J1GLVG67O9-MZr-JgpIHVRJGNVqyIYw83N80mHf0q2DfwJ9CZYLPcdTVilQ3NVX7YHF6vLH_AgZIw-KWErh2XAtrmDBdR1tE5nqLtK8bEBqlAWp567qGIRNC10w60wve8toA00voBCmrVIzBlFyZ1AxfZ_T5WntZ1GE-Xk67j-Zzb8enl8UR4RLiqoRo__67joc57lyzbeSrTM_HexTOofhMNozSn1-_UWFK:1xIrfG:STaloLIGZi7PSUDXQwynFM-95a3BglZb5n9BZEkIKN8', '2026-11-02 18:00:50.238515');

-- Dumping structure for table kaya_db.filter_attributes
CREATE TABLE IF NOT EXISTS `filter_attributes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.filter_attributes: ~0 rows (approximately)
DELETE FROM `filter_attributes`;
INSERT INTO `filter_attributes` (`id`, `name`, `slug`) VALUES
	(1, 'Color', 'color'),
	(2, 'Price', 'price');

-- Dumping structure for table kaya_db.filter_values
CREATE TABLE IF NOT EXISTS `filter_values` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `color_code` varchar(20) DEFAULT NULL,
  `attribute_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filter_values_attribute_id_slug_2eccf45f_uniq` (`attribute_id`,`slug`),
  KEY `filter_values_slug_fc090d12` (`slug`),
  CONSTRAINT `filter_values_attribute_id_2875dbb0_fk_filter_attributes_id` FOREIGN KEY (`attribute_id`) REFERENCES `filter_attributes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.filter_values: ~9 rows (approximately)
DELETE FROM `filter_values`;
INSERT INTO `filter_values` (`id`, `name`, `slug`, `color_code`, `attribute_id`) VALUES
	(1, 'Green', 'green', '#147649', 1),
	(2, 'Blue', 'blue', '#2D87CB', 1),
	(3, 'Red', 'red', '#FF3D3D', 1),
	(4, 'Maroon', 'maroon', '#972944', 1),
	(5, 'Pink', 'pink', '#c7617a', 1),
	(6, '500-600', '500-600', NULL, 2),
	(7, '600-700', '600-700', NULL, 2),
	(8, '700-800', '700-800', NULL, 2),
	(9, '800-1000', '800-1000', NULL, 2);

-- Dumping structure for table kaya_db.information_page
CREATE TABLE IF NOT EXISTS `information_page` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `slug` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `meta_keyword` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.information_page: ~1 rows (approximately)
DELETE FROM `information_page`;
INSERT INTO `information_page` (`id`, `title`, `slug`, `description`, `meta_title`, `meta_description`, `meta_keyword`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'About Us', 'about-us', '<p><strong>Young, Stylish &amp; Modern</strong></p>\r\n\r\n<p>Kaya Fashion is built for the new-age Indian woman&mdash;free-spirited, self-assured, and effortlessly stylish. We bring you a constantly refreshed collection of trendsetting sarees, ethnic ensembles, and fusion wear, thoughtfully designed to mirror global fashion trends without sacrificing daily comfort.</p>\r\n\r\n<p><strong>Our Philosophy</strong></p>\r\n\r\n<p>We craft stories over seasons, champion personal expression over fleeting trends, and prioritize everyday ease above all. While traditional fashion revolves around seasonal launches, Kaya Fashion introduces fresh stories and new saree designs throughout the year, keeping your wardrobe vibrant and ahead of the trend.</p>\r\n\r\n<p><strong>Our Brand Forte</strong></p>\r\n\r\n<p>While comfortable, high-fashion sarees remain at the heart of what we do, our versatile range of kurtas, bottom wear, and dupattas allows you to mix, match, and curate your own signature look for any occasion.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Meaning Of Kaya Fashion&nbsp;</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>In the context of fashion and ethnic wear, <a href="http://www.kayafashion.in"><strong>Kaya Fashion</strong></a> signifies <strong>&quot;clothing that honors and accentuates the body&quot;</strong>&mdash;focusing on perfect fit, graceful drapes, and flattering silhouettes.</p>\r\n	</li>\r\n	<li>\r\n	<p>It carries connotations of vitality, beauty, and physical elegance.</p>\r\n	</li>\r\n	<li>\r\n	<p>&nbsp;</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>Our Vision</strong></p>\r\n\r\n<p>To become India&#39;s go-to digital destination for modern ethnic and saree fashion. We strive to create an engaging space where style-conscious shoppers explore new trends and discover comfortable, contemporary designs. As <a href="https://www.kayafashion.in"><strong>Kaya Fashion</strong></a> grows, we will continue expanding our category offerings, optimizing customer touchpoints, and putting the modern Indian woman first.</p>', 'About Us', NULL, NULL, 0, 1, '2026-08-23 12:59:07.386811', '2026-10-03 00:59:15.995231');

-- Dumping structure for table kaya_db.newsletters
CREATE TABLE IF NOT EXISTS `newsletters` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `short_description` longtext NOT NULL,
  `textbox` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `video` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.newsletters: ~4 rows (approximately)
DELETE FROM `newsletters`;
INSERT INTO `newsletters` (`id`, `title`, `short_description`, `textbox`, `image`, `video`, `status`, `datetime`, `updated_at`, `slug`) VALUES
	(1, 'Saree Fashion Trends', 'Share trending saree colours, popular fabrics, blouse styles, festive looks, and traditional fashion ideas.', '<p>A saree is more than a traditional outfit &mdash; it is a timeless expression of grace, culture, and personal style. Whether you are attending a wedding, celebrating a festival, going to the office, or enjoying a casual gathering, the right saree styling can make you feel confident and beautiful.</p>\r\n\r\n<p>At <strong>KAYA FASHION</strong>, we believe that elegance comes from finding the perfect balance between your saree, accessories, colours, and the occasion. Here is your guide to styling a saree beautifully for every moment.</p>\r\n\r\n<h2>1. Wedding Elegance: Make Every Moment Special</h2>\r\n\r\n<p>Weddings are the perfect opportunity to embrace rich colours, luxurious fabrics, and intricate details.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Opt for silk sarees, Banarasi-inspired designs, rich woven borders, or elaborate traditional patterns. Shades such as deep red, wine, emerald green, royal blue, and gold create a beautiful celebratory look.</p>\r\n\r\n<p><strong>Style your blouse:</strong> Choose a well-fitted blouse with embroidery, elegant sleeves, or a complementary neckline.</p>\r\n\r\n<p><strong>Complete your look:</strong> Pair your saree with statement earrings, a necklace, bangles, and a coordinated clutch. Keep the accessories balanced so that your saree remains the highlight.</p>\r\n\r\n<p><strong>Draping tip:</strong> Arrange your pleats neatly and pin the pallu securely to maintain a graceful silhouette throughout the celebration.</p>\r\n\r\n<h2>2. Festive Glamour: Celebrate in Colour</h2>\r\n\r\n<p>Festivals are an opportunity to express your personality through vibrant colours and traditional designs.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Consider silk, printed, patterned, or zari-border sarees in festive shades such as magenta, mustard, purple, red, and green.</p>\r\n\r\n<p><strong>Style your blouse:</strong> A contrasting blouse can create a striking combination, while a matching blouse gives a more coordinated appearance.</p>\r\n\r\n<p><strong>Complete your look:</strong> Add traditional jhumkas, delicate bangles, a small bindi, and comfortable festive footwear.</p>\r\n\r\n<p><strong>Draping tip:</strong> Try a classic Nivi drape for an elegant traditional look, keeping the pallu visible to showcase its design.</p>\r\n\r\n<h2>3. Office and Professional Occasions: Understated Sophistication</h2>\r\n\r\n<p>A saree can look professional, comfortable, and polished when styled with simplicity.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Look for lightweight fabrics, subtle prints, delicate borders, and colours such as navy blue, beige, muted green, dusty pink, or charcoal.</p>\r\n\r\n<p><strong>Style your blouse:</strong> Choose a comfortable, well-fitted blouse with clean lines and sleeves that suit your workplace.</p>\r\n\r\n<p><strong>Complete your look:</strong> Wear small earrings, a simple watch, and comfortable footwear. Keep your handbag practical and coordinated.</p>\r\n\r\n<p><strong>Draping tip:</strong> Secure the pleats neatly and arrange the pallu so it stays in place throughout your working day.</p>\r\n\r\n<h2>4. Parties and Evening Events: Add a Touch of Glamour</h2>\r\n\r\n<p>For dinners, celebrations, and evening gatherings, choose a saree that makes you feel special without sacrificing comfort.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Explore jewel tones, metallic accents, satin-like finishes, rich silk textures, or striking printed designs.</p>\r\n\r\n<p><strong>Style your blouse:</strong> A statement sleeve, elegant neckline, or subtle embellishment can elevate the entire outfit.</p>\r\n\r\n<p><strong>Complete your look:</strong> Choose statement earrings or a bracelet, a sleek clutch, and footwear that complements your saree.</p>\r\n\r\n<p><strong>Draping tip:</strong> Let the pallu fall gracefully over your shoulder, ensuring that the border is visible and the fabric moves naturally.</p>\r\n\r\n<h2>5. Casual Outings and Family Gatherings: Effortless Grace</h2>\r\n\r\n<p>Everyday occasions deserve beautiful styling too. You do not need heavy embroidery or elaborate accessories to look elegant.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Lightweight printed sarees, soft cotton sarees, simple silk blends, and delicate patterned designs are excellent options.</p>\r\n\r\n<p><strong>Style your blouse:</strong> A solid-colour blouse that complements one of the colours in your saree creates a cohesive look.</p>\r\n\r\n<p><strong>Complete your look:</strong> Add small earrings, minimal bangles, comfortable sandals, and a simple handbag.</p>\r\n\r\n<p><strong>Draping tip:</strong> Keep the drape relaxed but tidy. Choose a style that allows you to move comfortably.</p>\r\n\r\n<h2>6. Choose Jewellery That Complements Your Saree</h2>\r\n\r\n<p>Jewellery should enhance your saree rather than compete with it.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Heavy embroidered sarees:</strong> Try simple earrings or a restrained necklace.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Plain sarees:</strong> Consider statement earrings, a necklace, or a decorative belt.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Traditional silk sarees:</strong> Gold-tone jewellery and classic bangles often complement the look beautifully.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Printed sarees:</strong> Keep accessories minimal or select a colour from the print to coordinate them.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Modern evening sarees:</strong> Try delicate jewellery or one bold accessory.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Remember that you do not need to wear every accessory at once. A thoughtfully selected piece can make a stronger impression than an overloaded look.</p>\r\n\r\n<h2>7. How to Match Your Blouse with Your Saree</h2>\r\n\r\n<p>Your blouse plays an important role in defining your overall style.</p>\r\n\r\n<p><strong>Matching blouse:</strong> Creates a harmonious, timeless appearance.</p>\r\n\r\n<p><strong>Contrasting blouse:</strong> Adds visual interest and highlights the saree&#39;s main colour.</p>\r\n\r\n<p><strong>Border-matched blouse:</strong> Repeats a shade from the saree border for a coordinated finish.</p>\r\n\r\n<p><strong>Embellished blouse:</strong> Works well with simpler sarees when you want a more festive look.</p>\r\n\r\n<p>Before choosing, consider the saree&#39;s fabric, occasion, comfort, and the style you want to express.</p>\r\n\r\n<h2>8. Five Simple Tips for an Elegant Saree Look</h2>\r\n\r\n<ol start="1">\r\n	<li>\r\n	<p><strong>Prioritise the fit:</strong> A well-fitted blouse and neatly arranged pleats make a noticeable difference.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Balance your accessories:</strong> Choose one focal point rather than making every element compete for attention.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Pay attention to footwear:</strong> Select shoes that complement your outfit and allow you to walk comfortably.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Care for your fabric:</strong> Follow the saree&#39;s specific washing, drying, and storage instructions.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Wear it with confidence:</strong> Good posture, comfortable movement, and a natural smile complete the look.</p>\r\n	</li>\r\n</ol>\r\n\r\n<h2>Discover Your Signature Style with KAYA FASHION</h2>\r\n\r\n<p>From traditional silk-inspired elegance to printed and patterned sarees, the right choice is the one that makes you feel confident and comfortable.</p>\r\n\r\n<p>Explore the KAYA FASHION collection to discover sarees for weddings, festivals, family gatherings, and everyday occasions. Pair your favourite design with complementary accessories and create a look that reflects your individual style.</p>\r\n\r\n<p><strong>KAYA FASHION &mdash; Timeless Elegance, Beautifully Draped.</strong></p>', 'newsletters/images/Sarees_Under_2000_That_Look_Like_You_Spent_10_000_d49deeb6-6c46-4f29_GXOso5N.webp', '', 'published', '2026-10-10 06:10:48.092559', '2026-10-10 10:19:43.616517', 'saree-fashion-trends'),
	(2, '5 Beautiful Saree Colours for the Festive Season', 'The festive season is the perfect time to embrace traditional elegance with beautiful sarees that reflect your style and personality. From rich jewel tones to vibrant festive shades, the right saree colour can make every celebration more memorable.', '<p>The festive season is the perfect time to embrace traditional elegance with beautiful sarees that reflect your style and personality. From rich jewel tones to vibrant festive shades, the right saree colour can make every celebration more memorable.</p>\r\n\r\n<p>Discover five stunning saree colours from <strong>KAYA FASHION</strong> to elevate your festive wardrobe.</p>\r\n\r\n<h2>1. Royal Blue &ndash; Elegant &amp; Timeless</h2>\r\n\r\n<p>Royal blue brings a sophisticated charm to festive celebrations. Paired with silver or gold jewellery, this colour is perfect for evening parties, family gatherings and festive dinners.</p>\r\n\r\n<p><strong>Style tip:</strong> Choose a royal blue silk saree with a statement border and traditional earrings for a graceful look.</p>\r\n\r\n<h2>2. Maroon &ndash; Rich &amp; Traditional</h2>\r\n\r\n<p>Maroon is a timeless festive favourite that radiates elegance and tradition. Its rich tone makes it ideal for weddings, pujas and special family occasions.</p>\r\n\r\n<p><strong>Style tip:</strong> Pair a maroon saree with antique gold jewellery and a matching blouse for a classic ethnic look.</p>\r\n\r\n<h2>3. Emerald Green &ndash; Fresh &amp; Luxurious</h2>\r\n\r\n<p>Emerald green adds a luxurious touch to your festive outfit. Whether you prefer silk, embroidered or printed sarees, this shade creates a striking and elegant appearance.</p>\r\n\r\n<p><strong>Style tip:</strong> Complete your look with gold accessories, a sleek hairstyle and subtle makeup.</p>\r\n\r\n<h2>4. Mustard Yellow &ndash; Bright &amp; Festive</h2>\r\n\r\n<p>Mustard yellow brings warmth, happiness and a cheerful festive vibe. It is a beautiful choice for daytime celebrations, traditional ceremonies and festive get-togethers.</p>\r\n\r\n<p><strong>Style tip:</strong> Pair a mustard saree with floral embroidery and a contrasting blouse for a charming traditional look.</p>\r\n\r\n<h2>5. Rani Pink &ndash; Vibrant &amp; Glamorous</h2>\r\n\r\n<p>Rani pink is perfect for women who love bold, lively colours. Its vibrant appeal makes it a wonderful choice for festive parties, weddings and special celebrations.</p>\r\n\r\n<p><strong>Style tip:</strong> Style your rani pink saree with gold jewellery and a coordinating blouse for a glamorous finish.</p>\r\n\r\n<h2>Celebrate Every Occasion with KAYA FASHION</h2>\r\n\r\n<p>Every colour tells a story, and every saree celebrates the beauty of tradition. Whether you love the richness of maroon, the elegance of royal blue or the vibrancy of rani pink, find a style that makes you feel confident and beautiful.</p>\r\n\r\n<p>Explore the festive saree collection at <strong>KAYA FASHION</strong> and make every celebration unforgettable.</p>\r\n\r\n<p><strong>Celebrate tradition. Embrace elegance. Drape your confidence.</strong></p>\r\n\r\n<p>Visit: <a href="http://www.kayafashion.in">www.kayafashion.in</a></p>\r\n\r\n<p>Follow us on Instagram: @kayafashion_india</p>', 'newsletters/images/blog_images_1_d31c7d3b-dd5c-4257-8814-9d95daceb809.webp', 'newsletters/videos/Saree_embroidery_close-up_20261010101256.mp4', 'published', '2026-10-10 08:35:19.359213', '2026-10-10 09:58:44.745122', '5-beautiful-saree-colours-for-the-festive-season'),
	(3, 'How to Care for Your Silk and Printed Sarees', 'A beautiful saree is more than just an outfit — it is a timeless expression of tradition, elegance and personal style. Whether you own a luxurious silk saree or a vibrant printed saree, proper care helps preserve its beauty, colour and fabric quality for years to come.', '<p>A beautiful saree is more than just an outfit &mdash; it is a timeless expression of tradition, elegance and personal style. Whether you own a luxurious silk saree or a vibrant printed saree, proper care helps preserve its beauty, colour and fabric quality for years to come.</p>\r\n\r\n<p>At <strong>KAYA FASHION</strong>, we believe every saree deserves special care. Follow these simple tips to keep your favourite sarees looking beautiful for every occasion.</p>\r\n\r\n<h2>1. Understand Your Saree Fabric</h2>\r\n\r\n<p>Different fabrics require different care methods.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Silk sarees:</strong> Delicate silk fibres and zari work may require professional dry cleaning.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Printed sarees:</strong> The correct washing method depends on the fabric, dyes and printing technique. Some can be gently hand-washed, while others require dry cleaning.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Always check the saree&#39;s care label or the seller&#39;s instructions before cleaning.</p>\r\n\r\n<h2>2. How to Care for Silk Sarees</h2>\r\n\r\n<p>Silk sarees are known for their luxurious texture and graceful appearance. A few careful habits can help protect their beauty.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Prefer professional dry cleaning:</strong> This is particularly important for expensive silk, zari work, embroidery and delicate finishes.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Avoid harsh detergents:</strong> Strong chemicals and bleach may damage silk fibres and decorative details.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Keep away from direct sunlight:</strong> Prolonged exposure can fade colours and weaken fibres.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Fold with care:</strong> Refold your saree occasionally in a different direction to reduce permanent creases.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Handle zari gently:</strong> Avoid excessive rubbing or pulling that could loosen threads.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>3. How to Care for Printed Sarees</h2>\r\n\r\n<p>Printed sarees bring colour and personality to your wardrobe. Proper washing and storage can help maintain their appearance.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Separate colours:</strong> Wash dark and light garments separately when washing is permitted.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Use mild detergent:</strong> Avoid bleach and harsh stain removers.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Avoid unnecessary soaking:</strong> Long soaking may cause colour bleeding or damage the print.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Wash gently:</strong> If the care label permits hand-washing, use cool water and avoid vigorous scrubbing.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Dry in the shade:</strong> Turn the saree inside out and keep it away from harsh sunlight.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>Important:</strong> Test for colour bleeding only in an inconspicuous area when appropriate. If the colour transfers, stop washing and consult a professional cleaner.</p>\r\n\r\n<h2>4. The Right Way to Store Your Sarees</h2>\r\n\r\n<p>Proper storage helps protect your sarees from dust, moisture and fabric damage.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Clean and completely dry the saree before storing it.</p>\r\n	</li>\r\n	<li>\r\n	<p>Fold it neatly and wrap delicate sarees in clean, breathable cotton or muslin fabric.</p>\r\n	</li>\r\n	<li>\r\n	<p>Store sarees in a cool, dry place away from direct sunlight.</p>\r\n	</li>\r\n	<li>\r\n	<p>Avoid tight plastic covers for long-term storage, as trapped moisture can encourage mildew.</p>\r\n	</li>\r\n	<li>\r\n	<p>Keep silk sarees separate from rough fabrics, jewellery and sharp embellishments that may snag the material.</p>\r\n	</li>\r\n	<li>\r\n	<p>Check stored sarees periodically for moisture, insects and discolouration.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>5. Remove Wrinkles Without Damaging the Fabric</h2>\r\n\r\n<p>Wrinkles are common after storing a saree, but excessive heat can damage delicate fibres and embellishments.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Use a steamer cautiously, if suitable for the fabric and finish.</p>\r\n	</li>\r\n	<li>\r\n	<p>If ironing is permitted, use a low-temperature setting and place a clean protective cloth between the iron and the saree.</p>\r\n	</li>\r\n	<li>\r\n	<p>Avoid direct ironing on zari, embroidery, sequins or delicate printed areas.</p>\r\n	</li>\r\n	<li>\r\n	<p>For valuable silk sarees, consider professional pressing.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>6. Common Saree Care Mistakes to Avoid</h2>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Washing every saree using the same method.</p>\r\n	</li>\r\n	<li>\r\n	<p>Using bleach or strong chemical cleaners.</p>\r\n	</li>\r\n	<li>\r\n	<p>Leaving damp sarees folded in a cupboard.</p>\r\n	</li>\r\n	<li>\r\n	<p>Storing silk sarees in direct sunlight or humid spaces.</p>\r\n	</li>\r\n	<li>\r\n	<p>Spraying perfume directly onto the fabric.</p>\r\n	</li>\r\n	<li>\r\n	<p>Ignoring the care instructions supplied with the saree.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>Keep Your Favourite Sarees Beautiful with KAYA FASHION</h2>\r\n\r\n<p>Every saree holds a special place in your wardrobe, whether it is chosen for a wedding, a festive celebration or an everyday elegant look. With the right cleaning, handling and storage habits, you can enjoy your favourite pieces for many occasions to come.</p>\r\n\r\n<p>Discover beautiful traditional, printed and patterned sarees with <strong>KAYA FASHION</strong>.</p>\r\n\r\n<p><strong>Wear your tradition. Preserve your elegance. Celebrate every drape.</strong></p>\r\n\r\n<p>Visit: <a href="http://www.kayafashion.in/">www.kayafashion.in</a></p>\r\n\r\n<p>Follow us on Instagram: @kaya.fashion</p>', 'newsletters/images/news-5.webp', 'newsletters/videos/Model_posing_in_luxury_interior_20261010103846.mp4', 'published', '2026-10-10 08:39:54.958245', '2026-10-10 09:58:26.631563', 'how-to-care-for-your-silk-and-printed-sarees'),
	(4, 'Saree Styling Guide: How to Look Elegant for Every Occasion', 'Saree Styling Guide: How to Look Elegant for Every Occasion', '<p>A saree is more than just a traditional outfit &mdash; it is a timeless symbol of grace, confidence and Indian heritage. Whether you are attending a wedding, celebrating a festival, going to the office or enjoying a casual outing, the right saree styling can make you look effortlessly elegant.</p>\r\n\r\n<p>At <strong>KAYA FASHION</strong>, we believe every woman deserves to feel beautiful in her own style. Discover how to style your favourite sarees for every occasion with these simple tips.</p>\r\n\r\n<h2>1. Wedding Elegance: Make Every Moment Special</h2>\r\n\r\n<p>Weddings are the perfect occasion to embrace rich colours, luxurious fabrics and statement accessories.</p>\r\n\r\n<p><strong>What to wear:</strong> Silk sarees, Banarasi-inspired sarees, embroidered sarees and rich jewel tones such as maroon, emerald green and royal blue.</p>\r\n\r\n<p><strong>How to style it:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Pair your saree with traditional gold or kundan-style jewellery.</p>\r\n	</li>\r\n	<li>\r\n	<p>Choose a well-fitted blouse with elegant sleeves or embroidery.</p>\r\n	</li>\r\n	<li>\r\n	<p>Complete your look with a classic bun, soft curls or a traditional hairstyle.</p>\r\n	</li>\r\n	<li>\r\n	<p>Add a small clutch and comfortable festive footwear.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>Style tip:</strong> Let your saree be the highlight. Choose accessories that complement its colour, border and embellishments.</p>\r\n\r\n<h2>2. Festive Celebrations: Embrace Colour and Tradition</h2>\r\n\r\n<p>Festivals call for vibrant colours, beautiful prints and traditional elegance. Whether you are celebrating Diwali, Navratri or a family occasion, a thoughtfully styled saree can create a memorable look.</p>\r\n\r\n<p><strong>What to wear:</strong> Mustard yellow, rani pink, red, purple and green sarees with traditional borders or attractive patterns.</p>\r\n\r\n<p><strong>How to style it:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Experiment with contrasting blouses.</p>\r\n	</li>\r\n	<li>\r\n	<p>Add jhumkas, bangles and a delicate bindi.</p>\r\n	</li>\r\n	<li>\r\n	<p>Choose comfortable footwear for long celebrations.</p>\r\n	</li>\r\n	<li>\r\n	<p>Try a graceful pleated pallu or a traditional drape.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>Style tip:</strong> Mix traditional accessories with a modern blouse design to create a fresh festive look.</p>\r\n\r\n<h2>3. Office Wear: Simple, Smart and Sophisticated</h2>\r\n\r\n<p>A saree can be an excellent choice for a professional wardrobe when styled with simplicity and comfort.</p>\r\n\r\n<p><strong>What to wear:</strong> Lightweight printed sarees and subtle patterns in navy blue, beige, grey, pastel pink or muted green.</p>\r\n\r\n<p><strong>How to style it:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Choose a comfortable blouse with clean lines.</p>\r\n	</li>\r\n	<li>\r\n	<p>Keep jewellery minimal with small</p>\r\n	</li>\r\n</ul>', 'newsletters/images/news-6.jfif', '', 'draft', '2026-10-10 08:58:12.998158', '2026-10-10 09:58:07.839604', 'saree-styling-guide-how-to-look-elegant-for-every-occasion');

-- Dumping structure for table kaya_db.newsletters_bck
CREATE TABLE IF NOT EXISTS `newsletters_bck` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `short_description` longtext NOT NULL,
  `textbox` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `video` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.newsletters_bck: ~4 rows (approximately)
DELETE FROM `newsletters_bck`;
INSERT INTO `newsletters_bck` (`id`, `title`, `short_description`, `textbox`, `image`, `video`, `status`, `datetime`, `updated_at`) VALUES
	(1, 'Saree Fashion Trends', 'Share trending saree colours, popular fabrics, blouse styles, festive looks, and traditional fashion ideas.', '<p>A saree is more than a traditional outfit &mdash; it is a timeless expression of grace, culture, and personal style. Whether you are attending a wedding, celebrating a festival, going to the office, or enjoying a casual gathering, the right saree styling can make you feel confident and beautiful.</p>\r\n\r\n<p>At <strong>KAYA FASHION</strong>, we believe that elegance comes from finding the perfect balance between your saree, accessories, colours, and the occasion. Here is your guide to styling a saree beautifully for every moment.</p>\r\n\r\n<h2>1. Wedding Elegance: Make Every Moment Special</h2>\r\n\r\n<p>Weddings are the perfect opportunity to embrace rich colours, luxurious fabrics, and intricate details.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Opt for silk sarees, Banarasi-inspired designs, rich woven borders, or elaborate traditional patterns. Shades such as deep red, wine, emerald green, royal blue, and gold create a beautiful celebratory look.</p>\r\n\r\n<p><strong>Style your blouse:</strong> Choose a well-fitted blouse with embroidery, elegant sleeves, or a complementary neckline.</p>\r\n\r\n<p><strong>Complete your look:</strong> Pair your saree with statement earrings, a necklace, bangles, and a coordinated clutch. Keep the accessories balanced so that your saree remains the highlight.</p>\r\n\r\n<p><strong>Draping tip:</strong> Arrange your pleats neatly and pin the pallu securely to maintain a graceful silhouette throughout the celebration.</p>\r\n\r\n<h2>2. Festive Glamour: Celebrate in Colour</h2>\r\n\r\n<p>Festivals are an opportunity to express your personality through vibrant colours and traditional designs.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Consider silk, printed, patterned, or zari-border sarees in festive shades such as magenta, mustard, purple, red, and green.</p>\r\n\r\n<p><strong>Style your blouse:</strong> A contrasting blouse can create a striking combination, while a matching blouse gives a more coordinated appearance.</p>\r\n\r\n<p><strong>Complete your look:</strong> Add traditional jhumkas, delicate bangles, a small bindi, and comfortable festive footwear.</p>\r\n\r\n<p><strong>Draping tip:</strong> Try a classic Nivi drape for an elegant traditional look, keeping the pallu visible to showcase its design.</p>\r\n\r\n<h2>3. Office and Professional Occasions: Understated Sophistication</h2>\r\n\r\n<p>A saree can look professional, comfortable, and polished when styled with simplicity.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Look for lightweight fabrics, subtle prints, delicate borders, and colours such as navy blue, beige, muted green, dusty pink, or charcoal.</p>\r\n\r\n<p><strong>Style your blouse:</strong> Choose a comfortable, well-fitted blouse with clean lines and sleeves that suit your workplace.</p>\r\n\r\n<p><strong>Complete your look:</strong> Wear small earrings, a simple watch, and comfortable footwear. Keep your handbag practical and coordinated.</p>\r\n\r\n<p><strong>Draping tip:</strong> Secure the pleats neatly and arrange the pallu so it stays in place throughout your working day.</p>\r\n\r\n<h2>4. Parties and Evening Events: Add a Touch of Glamour</h2>\r\n\r\n<p>For dinners, celebrations, and evening gatherings, choose a saree that makes you feel special without sacrificing comfort.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Explore jewel tones, metallic accents, satin-like finishes, rich silk textures, or striking printed designs.</p>\r\n\r\n<p><strong>Style your blouse:</strong> A statement sleeve, elegant neckline, or subtle embellishment can elevate the entire outfit.</p>\r\n\r\n<p><strong>Complete your look:</strong> Choose statement earrings or a bracelet, a sleek clutch, and footwear that complements your saree.</p>\r\n\r\n<p><strong>Draping tip:</strong> Let the pallu fall gracefully over your shoulder, ensuring that the border is visible and the fabric moves naturally.</p>\r\n\r\n<h2>5. Casual Outings and Family Gatherings: Effortless Grace</h2>\r\n\r\n<p>Everyday occasions deserve beautiful styling too. You do not need heavy embroidery or elaborate accessories to look elegant.</p>\r\n\r\n<p><strong>Choose your saree:</strong> Lightweight printed sarees, soft cotton sarees, simple silk blends, and delicate patterned designs are excellent options.</p>\r\n\r\n<p><strong>Style your blouse:</strong> A solid-colour blouse that complements one of the colours in your saree creates a cohesive look.</p>\r\n\r\n<p><strong>Complete your look:</strong> Add small earrings, minimal bangles, comfortable sandals, and a simple handbag.</p>\r\n\r\n<p><strong>Draping tip:</strong> Keep the drape relaxed but tidy. Choose a style that allows you to move comfortably.</p>\r\n\r\n<h2>6. Choose Jewellery That Complements Your Saree</h2>\r\n\r\n<p>Jewellery should enhance your saree rather than compete with it.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Heavy embroidered sarees:</strong> Try simple earrings or a restrained necklace.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Plain sarees:</strong> Consider statement earrings, a necklace, or a decorative belt.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Traditional silk sarees:</strong> Gold-tone jewellery and classic bangles often complement the look beautifully.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Printed sarees:</strong> Keep accessories minimal or select a colour from the print to coordinate them.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Modern evening sarees:</strong> Try delicate jewellery or one bold accessory.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Remember that you do not need to wear every accessory at once. A thoughtfully selected piece can make a stronger impression than an overloaded look.</p>\r\n\r\n<h2>7. How to Match Your Blouse with Your Saree</h2>\r\n\r\n<p>Your blouse plays an important role in defining your overall style.</p>\r\n\r\n<p><strong>Matching blouse:</strong> Creates a harmonious, timeless appearance.</p>\r\n\r\n<p><strong>Contrasting blouse:</strong> Adds visual interest and highlights the saree&#39;s main colour.</p>\r\n\r\n<p><strong>Border-matched blouse:</strong> Repeats a shade from the saree border for a coordinated finish.</p>\r\n\r\n<p><strong>Embellished blouse:</strong> Works well with simpler sarees when you want a more festive look.</p>\r\n\r\n<p>Before choosing, consider the saree&#39;s fabric, occasion, comfort, and the style you want to express.</p>\r\n\r\n<h2>8. Five Simple Tips for an Elegant Saree Look</h2>\r\n\r\n<ol start="1">\r\n	<li>\r\n	<p><strong>Prioritise the fit:</strong> A well-fitted blouse and neatly arranged pleats make a noticeable difference.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Balance your accessories:</strong> Choose one focal point rather than making every element compete for attention.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Pay attention to footwear:</strong> Select shoes that complement your outfit and allow you to walk comfortably.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Care for your fabric:</strong> Follow the saree&#39;s specific washing, drying, and storage instructions.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Wear it with confidence:</strong> Good posture, comfortable movement, and a natural smile complete the look.</p>\r\n	</li>\r\n</ol>\r\n\r\n<h2>Discover Your Signature Style with KAYA FASHION</h2>\r\n\r\n<p>From traditional silk-inspired elegance to printed and patterned sarees, the right choice is the one that makes you feel confident and comfortable.</p>\r\n\r\n<p>Explore the KAYA FASHION collection to discover sarees for weddings, festivals, family gatherings, and everyday occasions. Pair your favourite design with complementary accessories and create a look that reflects your individual style.</p>\r\n\r\n<p><strong>KAYA FASHION &mdash; Timeless Elegance, Beautifully Draped.</strong></p>', 'newsletters/images/news-3.png', '', 'published', '2026-10-10 06:10:48.092559', '2026-10-10 08:56:19.855374'),
	(2, '5 Beautiful Saree Colours for the Festive Season', 'The festive season is the perfect time to embrace traditional elegance with beautiful sarees that reflect your style and personality. From rich jewel tones to vibrant festive shades, the right saree colour can make every celebration more memorable.', '<p>The festive season is the perfect time to embrace traditional elegance with beautiful sarees that reflect your style and personality. From rich jewel tones to vibrant festive shades, the right saree colour can make every celebration more memorable.</p>\r\n\r\n<p>Discover five stunning saree colours from <strong>KAYA FASHION</strong> to elevate your festive wardrobe.</p>\r\n\r\n<h2>1. Royal Blue &ndash; Elegant &amp; Timeless</h2>\r\n\r\n<p>Royal blue brings a sophisticated charm to festive celebrations. Paired with silver or gold jewellery, this colour is perfect for evening parties, family gatherings and festive dinners.</p>\r\n\r\n<p><strong>Style tip:</strong> Choose a royal blue silk saree with a statement border and traditional earrings for a graceful look.</p>\r\n\r\n<h2>2. Maroon &ndash; Rich &amp; Traditional</h2>\r\n\r\n<p>Maroon is a timeless festive favourite that radiates elegance and tradition. Its rich tone makes it ideal for weddings, pujas and special family occasions.</p>\r\n\r\n<p><strong>Style tip:</strong> Pair a maroon saree with antique gold jewellery and a matching blouse for a classic ethnic look.</p>\r\n\r\n<h2>3. Emerald Green &ndash; Fresh &amp; Luxurious</h2>\r\n\r\n<p>Emerald green adds a luxurious touch to your festive outfit. Whether you prefer silk, embroidered or printed sarees, this shade creates a striking and elegant appearance.</p>\r\n\r\n<p><strong>Style tip:</strong> Complete your look with gold accessories, a sleek hairstyle and subtle makeup.</p>\r\n\r\n<h2>4. Mustard Yellow &ndash; Bright &amp; Festive</h2>\r\n\r\n<p>Mustard yellow brings warmth, happiness and a cheerful festive vibe. It is a beautiful choice for daytime celebrations, traditional ceremonies and festive get-togethers.</p>\r\n\r\n<p><strong>Style tip:</strong> Pair a mustard saree with floral embroidery and a contrasting blouse for a charming traditional look.</p>\r\n\r\n<h2>5. Rani Pink &ndash; Vibrant &amp; Glamorous</h2>\r\n\r\n<p>Rani pink is perfect for women who love bold, lively colours. Its vibrant appeal makes it a wonderful choice for festive parties, weddings and special celebrations.</p>\r\n\r\n<p><strong>Style tip:</strong> Style your rani pink saree with gold jewellery and a coordinating blouse for a glamorous finish.</p>\r\n\r\n<h2>Celebrate Every Occasion with KAYA FASHION</h2>\r\n\r\n<p>Every colour tells a story, and every saree celebrates the beauty of tradition. Whether you love the richness of maroon, the elegance of royal blue or the vibrancy of rani pink, find a style that makes you feel confident and beautiful.</p>\r\n\r\n<p>Explore the festive saree collection at <strong>KAYA FASHION</strong> and make every celebration unforgettable.</p>\r\n\r\n<p><strong>Celebrate tradition. Embrace elegance. Drape your confidence.</strong></p>\r\n\r\n<p>Visit: <a href="http://www.kayafashion.in">www.kayafashion.in</a></p>\r\n\r\n<p>Follow us on Instagram: @kayafashion_india</p>', 'newsletters/images/blog_images_1_d31c7d3b-dd5c-4257-8814-9d95daceb809.webp', 'newsletters/videos/Saree_embroidery_close-up_20261010101256.mp4', 'published', '2026-10-10 08:35:19.359213', '2026-10-10 08:55:56.013240'),
	(3, 'How to Care for Your Silk and Printed Sarees', 'A beautiful saree is more than just an outfit — it is a timeless expression of tradition, elegance and personal style. Whether you own a luxurious silk saree or a vibrant printed saree, proper care helps preserve its beauty, colour and fabric quality for years to come.', '<p>A beautiful saree is more than just an outfit &mdash; it is a timeless expression of tradition, elegance and personal style. Whether you own a luxurious silk saree or a vibrant printed saree, proper care helps preserve its beauty, colour and fabric quality for years to come.</p>\r\n\r\n<p>At <strong>KAYA FASHION</strong>, we believe every saree deserves special care. Follow these simple tips to keep your favourite sarees looking beautiful for every occasion.</p>\r\n\r\n<h2>1. Understand Your Saree Fabric</h2>\r\n\r\n<p>Different fabrics require different care methods.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Silk sarees:</strong> Delicate silk fibres and zari work may require professional dry cleaning.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Printed sarees:</strong> The correct washing method depends on the fabric, dyes and printing technique. Some can be gently hand-washed, while others require dry cleaning.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Always check the saree&#39;s care label or the seller&#39;s instructions before cleaning.</p>\r\n\r\n<h2>2. How to Care for Silk Sarees</h2>\r\n\r\n<p>Silk sarees are known for their luxurious texture and graceful appearance. A few careful habits can help protect their beauty.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Prefer professional dry cleaning:</strong> This is particularly important for expensive silk, zari work, embroidery and delicate finishes.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Avoid harsh detergents:</strong> Strong chemicals and bleach may damage silk fibres and decorative details.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Keep away from direct sunlight:</strong> Prolonged exposure can fade colours and weaken fibres.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Fold with care:</strong> Refold your saree occasionally in a different direction to reduce permanent creases.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Handle zari gently:</strong> Avoid excessive rubbing or pulling that could loosen threads.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>3. How to Care for Printed Sarees</h2>\r\n\r\n<p>Printed sarees bring colour and personality to your wardrobe. Proper washing and storage can help maintain their appearance.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><strong>Separate colours:</strong> Wash dark and light garments separately when washing is permitted.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Use mild detergent:</strong> Avoid bleach and harsh stain removers.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Avoid unnecessary soaking:</strong> Long soaking may cause colour bleeding or damage the print.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Wash gently:</strong> If the care label permits hand-washing, use cool water and avoid vigorous scrubbing.</p>\r\n	</li>\r\n	<li>\r\n	<p><strong>Dry in the shade:</strong> Turn the saree inside out and keep it away from harsh sunlight.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>Important:</strong> Test for colour bleeding only in an inconspicuous area when appropriate. If the colour transfers, stop washing and consult a professional cleaner.</p>\r\n\r\n<h2>4. The Right Way to Store Your Sarees</h2>\r\n\r\n<p>Proper storage helps protect your sarees from dust, moisture and fabric damage.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Clean and completely dry the saree before storing it.</p>\r\n	</li>\r\n	<li>\r\n	<p>Fold it neatly and wrap delicate sarees in clean, breathable cotton or muslin fabric.</p>\r\n	</li>\r\n	<li>\r\n	<p>Store sarees in a cool, dry place away from direct sunlight.</p>\r\n	</li>\r\n	<li>\r\n	<p>Avoid tight plastic covers for long-term storage, as trapped moisture can encourage mildew.</p>\r\n	</li>\r\n	<li>\r\n	<p>Keep silk sarees separate from rough fabrics, jewellery and sharp embellishments that may snag the material.</p>\r\n	</li>\r\n	<li>\r\n	<p>Check stored sarees periodically for moisture, insects and discolouration.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>5. Remove Wrinkles Without Damaging the Fabric</h2>\r\n\r\n<p>Wrinkles are common after storing a saree, but excessive heat can damage delicate fibres and embellishments.</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Use a steamer cautiously, if suitable for the fabric and finish.</p>\r\n	</li>\r\n	<li>\r\n	<p>If ironing is permitted, use a low-temperature setting and place a clean protective cloth between the iron and the saree.</p>\r\n	</li>\r\n	<li>\r\n	<p>Avoid direct ironing on zari, embroidery, sequins or delicate printed areas.</p>\r\n	</li>\r\n	<li>\r\n	<p>For valuable silk sarees, consider professional pressing.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>6. Common Saree Care Mistakes to Avoid</h2>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Washing every saree using the same method.</p>\r\n	</li>\r\n	<li>\r\n	<p>Using bleach or strong chemical cleaners.</p>\r\n	</li>\r\n	<li>\r\n	<p>Leaving damp sarees folded in a cupboard.</p>\r\n	</li>\r\n	<li>\r\n	<p>Storing silk sarees in direct sunlight or humid spaces.</p>\r\n	</li>\r\n	<li>\r\n	<p>Spraying perfume directly onto the fabric.</p>\r\n	</li>\r\n	<li>\r\n	<p>Ignoring the care instructions supplied with the saree.</p>\r\n	</li>\r\n</ul>\r\n\r\n<h2>Keep Your Favourite Sarees Beautiful with KAYA FASHION</h2>\r\n\r\n<p>Every saree holds a special place in your wardrobe, whether it is chosen for a wedding, a festive celebration or an everyday elegant look. With the right cleaning, handling and storage habits, you can enjoy your favourite pieces for many occasions to come.</p>\r\n\r\n<p>Discover beautiful traditional, printed and patterned sarees with <strong>KAYA FASHION</strong>.</p>\r\n\r\n<p><strong>Wear your tradition. Preserve your elegance. Celebrate every drape.</strong></p>\r\n\r\n<p>Visit: <a href="http://www.kayafashion.in/">www.kayafashion.in</a></p>\r\n\r\n<p>Follow us on Instagram: @kaya.fashion</p>', 'newsletters/images/news-5.webp', 'newsletters/videos/Model_posing_in_luxury_interior_20261010103846.mp4', 'published', '2026-10-10 08:39:54.958245', '2026-10-10 08:55:41.114278'),
	(4, 'Saree Styling Guide: How to Look Elegant for Every Occasion', 'Saree Styling Guide: How to Look Elegant for Every Occasion', '<p>A saree is more than just a traditional outfit &mdash; it is a timeless symbol of grace, confidence and Indian heritage. Whether you are attending a wedding, celebrating a festival, going to the office or enjoying a casual outing, the right saree styling can make you look effortlessly elegant.</p>\r\n\r\n<p>At <strong>KAYA FASHION</strong>, we believe every woman deserves to feel beautiful in her own style. Discover how to style your favourite sarees for every occasion with these simple tips.</p>\r\n\r\n<h2>1. Wedding Elegance: Make Every Moment Special</h2>\r\n\r\n<p>Weddings are the perfect occasion to embrace rich colours, luxurious fabrics and statement accessories.</p>\r\n\r\n<p><strong>What to wear:</strong> Silk sarees, Banarasi-inspired sarees, embroidered sarees and rich jewel tones such as maroon, emerald green and royal blue.</p>\r\n\r\n<p><strong>How to style it:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Pair your saree with traditional gold or kundan-style jewellery.</p>\r\n	</li>\r\n	<li>\r\n	<p>Choose a well-fitted blouse with elegant sleeves or embroidery.</p>\r\n	</li>\r\n	<li>\r\n	<p>Complete your look with a classic bun, soft curls or a traditional hairstyle.</p>\r\n	</li>\r\n	<li>\r\n	<p>Add a small clutch and comfortable festive footwear.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>Style tip:</strong> Let your saree be the highlight. Choose accessories that complement its colour, border and embellishments.</p>\r\n\r\n<h2>2. Festive Celebrations: Embrace Colour and Tradition</h2>\r\n\r\n<p>Festivals call for vibrant colours, beautiful prints and traditional elegance. Whether you are celebrating Diwali, Navratri or a family occasion, a thoughtfully styled saree can create a memorable look.</p>\r\n\r\n<p><strong>What to wear:</strong> Mustard yellow, rani pink, red, purple and green sarees with traditional borders or attractive patterns.</p>\r\n\r\n<p><strong>How to style it:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Experiment with contrasting blouses.</p>\r\n	</li>\r\n	<li>\r\n	<p>Add jhumkas, bangles and a delicate bindi.</p>\r\n	</li>\r\n	<li>\r\n	<p>Choose comfortable footwear for long celebrations.</p>\r\n	</li>\r\n	<li>\r\n	<p>Try a graceful pleated pallu or a traditional drape.</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>Style tip:</strong> Mix traditional accessories with a modern blouse design to create a fresh festive look.</p>\r\n\r\n<h2>3. Office Wear: Simple, Smart and Sophisticated</h2>\r\n\r\n<p>A saree can be an excellent choice for a professional wardrobe when styled with simplicity and comfort.</p>\r\n\r\n<p><strong>What to wear:</strong> Lightweight printed sarees and subtle patterns in navy blue, beige, grey, pastel pink or muted green.</p>\r\n\r\n<p><strong>How to style it:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Choose a comfortable blouse with clean lines.</p>\r\n	</li>\r\n	<li>\r\n	<p>Keep jewellery minimal with small</p>\r\n	</li>\r\n</ul>', 'newsletters/images/news-6.jfif', '', 'draft', '2026-10-10 08:58:12.998158', '2026-10-10 08:58:12.998203');

-- Dumping structure for table kaya_db.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `product_sku` varchar(50) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int(10) unsigned NOT NULL CHECK (`quantity` >= 0),
  `total_price` decimal(10,2) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_412ad78b_fk_orders_id` (`order_id`),
  KEY `order_items_product_id_dd557d5a_fk_products_master_id` (`product_id`),
  CONSTRAINT `order_items_order_id_412ad78b_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `order_items_product_id_dd557d5a_fk_products_master_id` FOREIGN KEY (`product_id`) REFERENCES `products_master` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.order_items: ~2 rows (approximately)
DELETE FROM `order_items`;
INSERT INTO `order_items` (`id`, `product_name`, `product_sku`, `unit_price`, `quantity`, `total_price`, `order_id`, `product_id`) VALUES
	(1, 'Bandhani Printed Saree', 'B0HLXX1FK9', 999.00, 2, 1998.00, 6, 5),
	(2, 'Georgette Saree styles like Heavy Border Work Designer', 'B0HLH3JTJS', 1299.00, 2, 2598.00, 6, 6);

-- Dumping structure for table kaya_db.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(32) NOT NULL,
  `shipping_address` longtext NOT NULL,
  `billing_address` longtext NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL,
  `shipping_fee` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` varchar(20) NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `courier_name` varchar(100) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `coupon_id` bigint(20) DEFAULT NULL,
  `session_key` varchar(100) DEFAULT NULL,
  `razorpay_payment_link_id` varchar(100) DEFAULT NULL,
  `razorpay_order_id` varchar(100) DEFAULT NULL,
  `razorpay_payment_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `orders_coupon_id_fk_coupons_id` (`coupon_id`),
  KEY `orders_customer_id_b7016332_fk_customers_id` (`customer_id`),
  CONSTRAINT `orders_coupon_id_fk_coupons_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_customer_id_b7016332_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.orders: ~1 rows (approximately)
DELETE FROM `orders`;
INSERT INTO `orders` (`id`, `order_number`, `shipping_address`, `billing_address`, `subtotal`, `tax_amount`, `shipping_fee`, `discount_amount`, `total_amount`, `order_status`, `payment_status`, `tracking_number`, `courier_name`, `notes`, `created_at`, `updated_at`, `customer_id`, `coupon_id`, `session_key`, `razorpay_payment_link_id`, `razorpay_order_id`, `razorpay_payment_id`) VALUES
	(6, 'KAYA-2026-B7D14453', '', '', 4596.00, 0.00, 0.00, 0.00, 4596.00, 'PENDING', 'UNPAID', NULL, NULL, NULL, '2026-10-18 21:29:41.816874', '2026-10-18 21:49:09.150160', 1, NULL, 'uh0xudze17delkhv6sd57hh750j9k97t', NULL, NULL, NULL);

-- Dumping structure for table kaya_db.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(20) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` int(10) unsigned NOT NULL,
  `status` varchar(20) NOT NULL,
  `raw_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_response`)),
  `created_at` datetime(6) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `razorpay_order_id` varchar(100) NOT NULL,
  `razorpay_payment_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `razorpay_order_id` (`razorpay_order_id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `payments_order_id_6086ad70` (`order_id`),
  CONSTRAINT `payments_order_id_6086ad70_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `payments_amount_ddcded74_check` CHECK (`amount` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.payments: ~0 rows (approximately)
DELETE FROM `payments`;

-- Dumping structure for table kaya_db.product_categories
CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `thumbnail_image` varchar(100) NOT NULL,
  `cover_image` varchar(100) DEFAULT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_description` longtext NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.product_categories: ~6 rows (approximately)
DELETE FROM `product_categories`;
INSERT INTO `product_categories` (`id`, `name`, `slug`, `title`, `description`, `thumbnail_image`, `cover_image`, `meta_title`, `meta_description`, `meta_keywords`, `created_at`, `updated_at`) VALUES
	(1, 'Wedding & Festive', 'wedding-festive', 'Wedding & Festive', 'Wedding & Festive', 'images/categories/thumbnails/wedding-festive.jpg', 'images/categories/covers/wedding-festive.jpg', 'Chikankari Saree (Uttar Pradesh)', '', '', '2026-08-23 08:13:28.567486', '2026-09-06 08:05:28.294242'),
	(2, 'Banarasi Sarees', 'banarasi-sarees', 'Banarasi Sarees', 'Banarasi Sarees', 'images/categories/thumbnails/f683a267-6628-414a-9687-e8924081b94d.png', 'images/categories/covers/f683a267-6628-414a-9687-e8924081b94d.png', 'CHANDERI SAREE', '', '', '2026-09-06 07:47:47.470403', '2026-10-02 18:03:38.538660'),
	(3, 'Silk Sarees', 'silk-sarees', 'Silk Sarees', '', 'images/categories/thumbnails/1dd84c1f-5ca5-4f4a-9647-bf7f0e8d3971.png', 'images/categories/covers/1dd84c1f-5ca5-4f4a-9647-bf7f0e8d3971.png', 'Silk Sarees', '', '', '2026-09-06 07:51:59.288048', '2026-10-02 18:09:12.319577'),
	(4, 'Designer Sarees', 'designer-sarees', 'Designer Sarees', 'Designer Sarees', 'images/categories/thumbnails/51d5b845-e985-450c-988b-e5b88c597892.png', 'images/categories/covers/51d5b845-e985-450c-988b-e5b88c597892.png', 'Designer Sarees', '', '', '2026-09-06 07:55:03.101561', '2026-10-02 18:05:25.368169'),
	(5, 'Printed Sarees', 'printed-sarees', 'Printed Sarees', 'Printed Sarees', 'images/categories/thumbnails/Image-3.png', 'images/categories/covers/Image-3.png', 'Printed Sarees', '', '', '2026-09-06 07:56:33.855388', '2026-10-02 18:08:42.649985'),
	(6, 'Handloom Sarees', 'handloom-sarees', 'Handloom Sarees', 'Handloom Sarees', 'images/categories/thumbnails/maroon-main.png', 'images/categories/covers/maroon-main.png', 'Handloom Sarees', '', '', '2026-09-06 07:57:52.116960', '2026-10-02 18:06:00.297387');

-- Dumping structure for table kaya_db.product_images
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `alt_text` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `variant_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_images_product_id_28ebf5f0_fk_products_master_id` (`product_id`),
  KEY `product_images_variant_id_4f2278dc_fk_product_variants_id` (`variant_id`),
  CONSTRAINT `product_images_product_id_28ebf5f0_fk_products_master_id` FOREIGN KEY (`product_id`) REFERENCES `products_master` (`id`),
  CONSTRAINT `product_images_variant_id_4f2278dc_fk_product_variants_id` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.product_images: ~43 rows (approximately)
DELETE FROM `product_images`;
INSERT INTO `product_images` (`id`, `image`, `alt_text`, `sort_order`, `is_primary`, `created_at`, `product_id`, `variant_id`) VALUES
	(1, 'images/products/gallery/product_deep-green-embroidered-georgette-saree/2b5cacf8-99d7-4a_8oSBKW8.jfif', '', 2, 0, '2026-08-23 08:16:38.195894', 1, 1),
	(2, 'images/products/gallery/product_deep-green-embroidered-georgette-saree/img2.jfif', '', 3, 0, '2026-08-23 08:16:38.199055', 1, 1),
	(3, 'images/products/gallery/product_deep-green-embroidered-georgette-saree/c1443b40-04e2-4f_47z6vTD.jfif', '', 1, 0, '2026-08-23 08:16:38.201357', 1, 1),
	(4, 'images/products/gallery/product_deep-green-embroidered-georgette-saree/Sumac_dyed.png', '', 4, 0, '2026-10-02 19:44:44.314289', 1, 1),
	(5, 'images/products/gallery/product_deep-green-embroidered-georgette-saree/iamge-1.png', '', 5, 0, '2026-10-02 19:44:44.319566', 1, 1),
	(6, 'images/products/gallery/product_deep-green-embroidered-georgette-saree/blouse.png', '', 6, 0, '2026-10-02 19:44:44.330333', 1, 1),
	(7, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern/Main-image.png', '', 1, 1, '2026-10-02 20:37:51.694063', 2, NULL),
	(8, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern/Image-3.png', '', 2, 0, '2026-10-02 20:37:51.701116', 2, NULL),
	(9, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern/Image-4.png', '', 3, 0, '2026-10-02 20:37:51.705738', 2, NULL),
	(10, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern/Image-2.png', '', 4, 0, '2026-10-02 20:37:51.716606', 2, NULL),
	(11, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern/blouse.png', '', 5, 0, '2026-10-02 20:37:51.720920', 2, NULL),
	(12, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern-purple/pu_8E9Mg3D.png', '', 0, 1, '2026-10-02 22:53:44.520577', 3, NULL),
	(13, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern-purple/Cr_ZBXAu1f.png', '', 0, 0, '2026-10-02 22:53:44.537862', 3, NULL),
	(14, 'images/products/gallery/product_designer-border-and-traditional-floral-pattern-purple/pu_ndegJrc.png', '', 0, 0, '2026-10-02 22:53:44.543625', 3, NULL),
	(15, 'images/products/gallery/product_elegant-peacock-blue-georgette-saree/yellow.png', '', 0, 0, '2026-10-02 23:23:24.412044', 4, NULL),
	(16, 'images/products/gallery/product_elegant-peacock-blue-georgette-saree/yellow5.png', '', 0, 0, '2026-10-02 23:23:24.427977', 4, NULL),
	(17, 'images/products/gallery/product_elegant-peacock-blue-georgette-saree/wht-yellow.png', '', 0, 0, '2026-10-02 23:23:24.432394', 4, NULL),
	(18, 'images/products/gallery/product_elegant-peacock-blue-georgette-saree/WhatsApp_Image_202_07t14ic.jpeg', '', 0, 0, '2026-10-02 23:23:24.447472', 4, NULL),
	(19, 'images/products/gallery/product_bandhani-printed-saree/yellow.jpeg', '', 1, 0, '2026-10-08 10:56:42.583291', 5, NULL),
	(20, 'images/products/gallery/product_bandhani-printed-saree/img2.png', '', 2, 0, '2026-10-08 10:56:42.588489', 5, NULL),
	(21, 'images/products/gallery/product_georgette-saree-styles-like-heavy-border-work-designer/pink-3.png', '', 1, 0, '2026-10-08 11:08:40.857205', 6, NULL),
	(22, 'images/products/gallery/product_georgette-saree-styles-like-heavy-border-work-designer/pink1.png', '', 2, 0, '2026-10-08 11:08:40.868943', 6, NULL),
	(23, 'images/products/gallery/product_georgette-saree-styles-like-heavy-border-work-designer/p_tYd3feb.png', '', 3, 0, '2026-10-08 11:08:40.880303', 6, NULL),
	(24, 'images/products/gallery/product_silk-saree-with-designer-border/white-mostang.png', '', 0, 0, '2026-10-08 11:20:34.063306', 7, NULL),
	(25, 'images/products/gallery/product_bandhani-printed-saree/img4.png', '', 0, 0, '2026-10-11 17:50:05.970458', 5, NULL),
	(26, 'images/products/gallery/product_bandhani-printed-saree/yellow_8JNUmVr.jpeg', '', 0, 0, '2026-10-11 17:50:05.973393', 5, NULL),
	(31, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/278ca276-1d11-4718_fOuwZvO.png', '', 1, 0, '2026-10-17 07:02:25.995462', 1, 16),
	(32, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/Pink-Raspberry.png', '', 2, 0, '2026-10-17 07:02:26.001374', 1, 16),
	(33, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/1dd84c1f-5ca5-4f4a_6P9HyOG.png', '', 3, 0, '2026-10-17 07:02:26.006273', 1, 16),
	(34, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/pink1.png', '', 4, 0, '2026-10-17 07:02:26.009759', 1, 16),
	(35, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/pink-3.png', '', 5, 0, '2026-10-17 07:02:26.014137', 1, 16),
	(36, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/393d1dd1-1c89-4271_UV1NLo5.png', '', 1, 1, '2026-10-17 07:02:26.020307', 1, 17),
	(37, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/2ed0a980-3fd0-4a56_nIec5PI.png', '', 2, 0, '2026-10-17 07:02:26.024711', 1, 17),
	(38, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/white-greem.jpg', '', 3, 0, '2026-10-17 07:02:26.027118', 1, 17),
	(39, 'images/products/gallery/product_deep-plum-embroidered-georgette-saree/green-blouse.png', '', 4, 0, '2026-10-17 07:02:26.030696', 1, 17),
	(40, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/blouse-red.png', '', 1, 0, '2026-10-17 08:22:24.556626', 11, 10),
	(41, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/Red.png', '', 2, 0, '2026-10-17 08:22:24.563200', 11, 10),
	(42, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/pinl-blouse.png', '', 3, 0, '2026-10-17 08:22:24.573877', 11, 10),
	(43, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/red-11.png', '', 4, 0, '2026-10-17 08:22:24.579379', 11, 10),
	(46, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/green-1.png', '', 1, 0, '2026-10-17 08:34:27.757309', 11, 19),
	(47, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/green.png', '', 2, 1, '2026-10-17 08:34:27.762909', 11, 19),
	(48, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/deep-green.png', '', 3, 0, '2026-10-17 08:34:27.768168', 11, 19),
	(49, 'images/products/gallery/product_banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer/white-green.png', '', 4, 0, '2026-10-17 08:34:27.772763', 11, 19);

-- Dumping structure for table kaya_db.product_subcategories
CREATE TABLE IF NOT EXISTS `product_subcategories` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `thumbnail_image` varchar(100) NOT NULL,
  `cover_image` varchar(100) DEFAULT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_description` longtext NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_subcategories_category_id_slug_3dfea964_uniq` (`category_id`,`slug`),
  KEY `product_subcategories_slug_b896d74b` (`slug`),
  CONSTRAINT `product_subcategorie_category_id_dd1f4074_fk_product_c` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.product_subcategories: ~0 rows (approximately)
DELETE FROM `product_subcategories`;
INSERT INTO `product_subcategories` (`id`, `name`, `slug`, `title`, `description`, `thumbnail_image`, `cover_image`, `meta_title`, `meta_description`, `meta_keywords`, `created_at`, `updated_at`, `category_id`) VALUES
	(1, 'Bridal Sarees', 'bridal-sarees', 'Bridal Sarees', 'Bridal Sarees', 'images/subcategories/thumbnails/bridal-sarees.jpg', 'images/subcategories/covers/bridal-sarees.jpg', 'Traditional Saree', '', '', '2026-08-23 08:13:52.002150', '2026-09-06 08:14:02.749610', 1);

-- Dumping structure for table kaya_db.product_variants
CREATE TABLE IF NOT EXISTS `product_variants` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sku` varchar(100) NOT NULL,
  `size` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(10) unsigned NOT NULL CHECK (`quantity` >= 0),
  `category` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `products_productvari_product_id_d9c22902_fk_products_` (`product_id`),
  KEY `FK_product_variants_product_categories` (`category`),
  CONSTRAINT `FK_product_variants_product_categories` FOREIGN KEY (`category`) REFERENCES `product_categories` (`id`),
  CONSTRAINT `products_productvari_product_id_d9c22902_fk_products_` FOREIGN KEY (`product_id`) REFERENCES `products_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.product_variants: ~12 rows (approximately)
DELETE FROM `product_variants`;
INSERT INTO `product_variants` (`id`, `sku`, `size`, `color`, `is_active`, `product_id`, `quantity`, `category`) VALUES
	(1, 'DISGN-BB-DPPLM-001', 'Free', 'Deep Plum', 1, 1, 2, NULL),
	(5, 'DISGN-KAT-PPL-001', 'Free', 'Purple', 1, 3, 2, NULL),
	(6, 'DISGN-RUDR-YLW-001', 'Free', 'Yellow', 1, 4, 2, NULL),
	(7, 'B0HLXX1FK9', NULL, 'Yellow', 1, 5, 2, NULL),
	(8, 'B0HLH3JTJS', NULL, NULL, 1, 6, 2, NULL),
	(10, 'DISGN-KAT-GRB-001', 'Free', 'Red', 1, 11, 2, NULL),
	(14, 'DISGN-KAT-GRN-001', 'Free', 'Green', 1, 7, 2, NULL),
	(15, 'DISGN-KAT-GRN-002', 'Free', 'Pink', 1, 7, 2, NULL),
	(16, 'DISGN-BB-DPPLM-002', 'Free', 'Pink', 1, 1, 2, NULL),
	(17, 'DISGN-BB-DPPLM-003', 'Free', 'Green', 1, 1, 2, NULL),
	(18, 'DISGN-KAT-RED-002', 'Free', 'Green', 1, 12, 0, NULL),
	(19, 'DISGN-KAT-GRB-002', 'Free', 'Green', 1, 11, 2, NULL);

-- Dumping structure for table kaya_db.products_master
CREATE TABLE IF NOT EXISTS `products_master` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `product_image` varchar(100) NOT NULL,
  `quantity` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `key_features` longtext NOT NULL,
  `weight` decimal(15,2) DEFAULT NULL,
  `length` decimal(15,2) DEFAULT NULL,
  `width` decimal(15,2) DEFAULT NULL,
  `height` decimal(15,2) DEFAULT NULL,
  `minimum` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `is_popular` tinyint(1) NOT NULL,
  `is_new_product` tinyint(1) NOT NULL,
  `is_stock` tinyint(1) NOT NULL,
  `seo_title` varchar(255) NOT NULL,
  `meta_description` longtext NOT NULL,
  `meta_keywords` varchar(500) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `subcategory_id` bigint(20) DEFAULT NULL,
  `dist_price` decimal(10,2) DEFAULT NULL,
  `mrp_price` varchar(50) DEFAULT NULL,
  `productcode` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `products_master_category_id_01e25df6_fk_product_categories_id` (`category_id`),
  KEY `products_master_subcategory_id_8bbf3ee4_fk_product_s` (`subcategory_id`),
  CONSTRAINT `products_master_category_id_01e25df6_fk_product_categories_id` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`),
  CONSTRAINT `products_master_subcategory_id_8bbf3ee4_fk_product_s` FOREIGN KEY (`subcategory_id`) REFERENCES `product_subcategories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.products_master: ~9 rows (approximately)
DELETE FROM `products_master`;
INSERT INTO `products_master` (`id`, `name`, `slug`, `product_image`, `quantity`, `description`, `key_features`, `weight`, `length`, `width`, `height`, `minimum`, `rating`, `sort_order`, `status`, `is_featured`, `is_popular`, `is_new_product`, `is_stock`, `seo_title`, `meta_description`, `meta_keywords`, `created_at`, `updated_at`, `category_id`, `subcategory_id`, `dist_price`, `mrp_price`, `productcode`) VALUES
	(1, 'Deep Plum Embroidered Georgette Saree', 'deep-plum-embroidered-georgette-saree', 'images/products/images/img2.jfif', '2', '<p>This rich deep plum saree is crafted from lightweight, fluid georgette fabric that offers an effortless, elegant drape. The body is adorned with intricate antique gold zari floral embroidery and subtle sequin highlights that shimmer delicately with movement. Framing the saree is a striking scalloped border features detailed cutwork and ornate motif craftsmanship, adding a traditional yet grand finish. Paired with a matching deep purple sleeve blouse, this ensemble blends regal tones with festive grandeur. Add timeless elegance to your ethnic collection with this beautifully printed saree, designed with intricate golden motifs and a sophisticated designer border. The striking blue and gold colour combination creates a luxurious and graceful look, while the detailed pallu enhances its traditional appeal. Perfect for weddings, festive celebrations, family gatherings, parties, cultural occasions and special events, this saree can be beautifully paired with traditional jewellery, statement earrings and matching footwear for a refined ethnic ensemble. Designed for women who appreciate classic Indian elegance, its versatile colour palette and traditional detailing make it an ideal choice for creating a graceful, stylish and sophisticated look on every special occasion.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Deep Plum</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Floral</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival, Party, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Saree Design</th>\r\n			<td>Chanderi, Banarsi, Woven, Printed</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Holiday Type</th>\r\n			<td>Christmas, Diwali, New Year</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Life Event</th>\r\n			<td>Anniversary, Bridal Shower, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', '<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>Fabric: Georgette or Faux Georgette (sheer, lightweight, fluid drape) with intricate gold thread embroidery, sequence/stonework motifs, and a rich scallop/cutwork embroidered border.</li>\r\n	<li>Color: Deep Plum / Royal Purple with contrasting Antique Gold embroidery.</li>\r\n	<li>Quality &amp; Texture: Premium decorative finish; lightweight, soft, flowy, and non-stiff with a graceful, figure-flattering drape.</li>\r\n	<li>Wash &amp; Care Type: Dry Clean Only (due to heavy thread embroidery, sequence, and delicate border work).</li>\r\n	<li>Comes paired with a color-matched solid blouse fabric designed to create a clean, sophisticated frame for the decorative saree.</li>\r\n	<li>Features intricate gold floral zari embroidery interspersed with delicate sequin embellishments that offer a subtle, light-catching shimmer throughout the drape.</li>\r\n</ul>', 250.00, 5.50, 167.00, 157.00, 1, 0, 0, 'published', 0, 0, 1, 0, 'Deep Green Embroidered Georgette Saree', '<p>Deep Green Embroidered Georgette Saree</p>', '', '2026-08-23 08:16:38.190550', '2026-10-17 11:34:14.943966', 4, 1, 1299.00, '2499', '2026-10-11 08:58:59.595630+00:00'),
	(2, 'Designer Border and Traditional Floral Pattern-Green', 'designer-border-and-traditional-floral-pattern-green', 'images/products/images/Image-4.png', '2', '<ul>\r\n	<li>Elegant Printed Design: Features intricate golden traditional motifs that create a graceful and sophisticated ethnic look for women</li>\r\n	<li>Designer Border And Pallu: Detailed patterned border and beautifully designed pallu add a rich traditional appeal to the saree</li>\r\n	<li>Classic Green And Gold Look: The timeless green and gold combination gives the saree a refined and versatile appearance for special occasions</li>\r\n	<li>Suitable For Special Occasions: Designed for weddings, festivals, family functions, parties, cultural events and festive celebrations</li>\r\n	<li>Easy To Style: Pair with traditional jewellery, elegant earrings and matching footwear to create a beautiful and sophisticated ethnic ensemble</li>\r\n	<li>Premium Silk Fabric: Made from quality silk material that offers a luxurious drape and comfortable wear throughout the day</li>\r\n</ul>', '<p>Add timeless elegance to your ethnic collection with this beautifully printed saree, designed with intricate golden motifs and a sophisticated designer border. The striking blue and gold colour combination creates a luxurious and graceful look, while the detailed pallu enhances its traditional appeal. Perfect for weddings, festive celebrations, family gatherings, parties, cultural occasions and special events, this saree can be beautifully paired with traditional jewellery, statement earrings and matching footwear for a refined ethnic ensemble. Designed for women who appreciate classic Indian elegance, its versatile colour palette and traditional detailing make it an ideal choice for creating a graceful, stylish and sophisticated look on every special occasion.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Green</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Floral</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival, Party, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Saree Design</th>\r\n			<td>Chanderi, Banarsi, Woven, Printed</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Holiday Type</th>\r\n			<td>Christmas, Diwali, Valentine&#39;s Day</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Life Event</th>\r\n			<td>Anniversary, Birthday, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'published', 1, 1, 1, 0, 'Designer Border and Traditional Floral Pattern', '', '', '2026-10-02 20:37:51.676442', '2026-10-08 11:17:23.781197', 5, 1, 899.00, '1499', '2026-10-11 08:58:59.595630+00:00'),
	(3, 'Designer Border and Traditional Floral Pattern(Purple)', 'designer-border-and-traditional-floral-pattern-purple', 'images/products/images/purple-image.png', '2', '<ul>\r\n	<li>Elegant Printed Design: Features intricate golden traditional motifs that create a graceful and sophisticated ethnic look for women</li>\r\n	<li>Designer Border And Pallu: Detailed patterned border and beautifully designed pallu add a rich traditional appeal to the saree</li>\r\n	<li>Classic Green And Gold Look: The timeless green and gold combination gives the saree a refined and versatile appearance for special occasions</li>\r\n	<li>Suitable For Special Occasions: Designed for weddings, festivals, family functions, parties, cultural events and festive celebrations</li>\r\n	<li>Easy To Style: Pair with traditional jewellery, elegant earrings and matching footwear to create a beautiful and sophisticated ethnic ensemble</li>\r\n	<li>Premium Silk Fabric: Made from quality silk material that offers a luxurious drape and comfortable wear throughout the day</li>\r\n</ul>', '<p>Add timeless elegance to your ethnic collection with this beautifully printed saree, designed with intricate golden motifs and a sophisticated designer border. The striking blue and gold colour combination creates a luxurious and graceful look, while the detailed pallu enhances its traditional appeal. Perfect for weddings, festive celebrations, family gatherings, parties, cultural occasions and special events, this saree can be beautifully paired with traditional jewellery, statement earrings and matching footwear for a refined ethnic ensemble. Designed for women who appreciate classic Indian elegance, its versatile colour palette and traditional detailing make it an ideal choice for creating a graceful, stylish and sophisticated look on every special occasion.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Purple</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Floral</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Saree Design</th>\r\n			<td>Chanderi, Banarsi, Woven, Printed</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Holiday Type</th>\r\n			<td>Christmas, Diwali, Valentine&#39;s Day</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Life Event</th>\r\n			<td>Anniversary, Birthday, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'published', 1, 0, 1, 0, 'Designer Border and Traditional Floral Pattern(Purple)', '', '', '2026-10-02 22:53:44.511885', '2026-10-08 11:17:23.778177', 4, 1, 899.00, '1499', '2026-10-11 08:58:59.595630+00:00'),
	(4, 'Elegant Yellow Georgette Saree', 'elegant-yellow-georgette-saree', 'images/products/images/yellow.png', '2', '<ul>\r\n	<li>Intricate Stone Work Border: Features a broad, delicate geometric grid/lattice border made with gleaming white hotfix stones.</li>\r\n	<li>Statement Floral Motifs: Bold starburst-style floral motifs accented with stones along the inner and outer pallu borders.</li>\r\n	<li>Coordinated Sleeve Detail: Matching blouse piece featuring identical stone-embellished border detailing along the sleeves.</li>\r\n	<li>Graceful Drape: Lightweight and fluid fabric ensures elegant pleating and comfortable all-day wear.</li>\r\n	<li>Color Palette: Deep royal peacock blue paired with contrasting silver/white stone detailing</li>\r\n	<li>Occasion Wear: Suitable for evening parties, festive celebrations, receptions, and wedding functions.</li>\r\n</ul>', '<p>This stunning peacock blue saree features lightweight, soft fluid fabric with intricate white stone/rhinestone embellishments. The border displays a detailed criss-cross geometric lattice pattern paired with prominent floral motifs that extend along the pallu and borders, creating a sophisticated and radiant look suitable for parties, festive occasions, and evening events. It comes with a matching solid blue blouse featuring embellished sleeve borders. Perfect for weddings, festive celebrations, family gatherings, parties, cultural occasions and special events, this saree can be beautifully paired with traditional jewellery, statement earrings and matching footwear for a refined ethnic ensemble. Designed for women who appreciate classic Indian elegance, its versatile colour palette and traditional detailing make it an ideal choice for creating a graceful, stylish and sophisticated look on every special occasion.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Yellow</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Floral</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival, Party, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Saree Design</th>\r\n			<td>Sophisticated &amp; Festive (Moderate to Intricate)</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Life Event</th>\r\n			<td>Anniversary</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'published', 1, 0, 1, 0, 'Elegant Peacock Blue Georgette Saree', '', '', '2026-10-02 23:23:24.405064', '2026-10-11 17:47:44.872103', 1, 1, 899.00, '1499', 'Gobhi'),
	(5, 'Bandhani Printed Saree', 'bandhani-printed-saree', 'images/products/images/Red.jpeg', '2', '<h3>About this item</h3>\r\n\r\n<ul>\r\n	<li>Intricate floral and sunburst thread embroidery accented with delicate gold and orange highlights across the pallu and border.</li>\r\n	<li>Scattered shimmering sequin and stone accents distributed evenly across the drape to catch the light</li>\r\n	<li>Scalloped Edge finishing along the full length of the border for a refined, modern silhouette.</li>\r\n	<li>Saree Work : Bandhani Printed &amp; Sequins Embroidery &amp; Lace &amp; Tassels || Blouse : Weaving &amp; Lace</li>\r\n	<li>Package Content : 1 Saree With 1 Unstitched Blouses Piece || Occassion: This Saree Is Suitable To Get A Contemporary Stylish Look In Normal Occasions, College Farewell, Family Get Together, Regular Or Daily Use, Office Or Work Or Gifting To Loved One.</li>\r\n	<li>Color : Colour Of The Actual Product May Slightly Vary Due To Different Photographic Lighting Sources Or Your Display Color Settings Or Screen Type.</li>\r\n</ul>', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Yellow</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Geometric</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival, Party, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Lace, Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'published', 1, 1, 1, 0, 'Bandhani Printed Saree', '', '', '2026-10-08 10:56:42.578547', '2026-10-11 17:50:05.962806', 5, 1, 999.00, '2499', 'Gobhi'),
	(6, 'Georgette Saree styles like Heavy Border Work Designer', 'georgette-saree-styles-like-heavy-border-work-designer', 'images/products/images/1dd84c1f-5ca5-4f4a-9647-bf7f0e8d3971.png', '2', '<h3>About this item</h3>\r\n\r\n<ul>\r\n	<li>Fabric: Georgette or Faux Georgette (sheer, lightweight, fluid drape) with intricate gold thread embroidery, sequence/stonework motifs, and a rich scallop/cutwork embroidered border</li>\r\n	<li>Color: Deep Red with contrasting Antique Gold embroidery</li>\r\n	<li>Quality &amp; Texture: Premium decorative finish; lightweight, soft, flowy, and non-stiff with a graceful, figure-flattering drape</li>\r\n	<li>Wash &amp; Care Type: Dry Clean Only (due to heavy thread embroidery, sequence, and delicate border work)</li>\r\n	<li>Blouse Fabric Included: Comes paired with a color-matched solid blouse fabric designed to create a clean, sophisticated frame for the decorative saree</li>\r\n	<li>Embellishment Details: Features intricate gold floral zari embroidery interspersed with delicate sequin embellishments that offer a subtle, light-catching shimmer throughout the drape</li>\r\n</ul>', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Red</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Floral</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival, Party, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Saree Design</th>\r\n			<td>Chanderi, Banarsi, Woven, Printed</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Holiday Type</th>\r\n			<td>Christmas, Diwali, New Year</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Life Event</th>\r\n			<td>Anniversary, Bridal Shower, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'published', 1, 1, 1, 0, 'Georgette Saree styles like Heavy Border Work Designer', '', '', '2026-10-08 11:08:40.850055', '2026-10-08 11:12:49.235808', 6, 1, 1299.00, '2499', '2026-10-11 08:58:59.595630+00:00'),
	(7, 'Silk Saree with Designer Border', 'silk-saree-with-designer-border', 'images/products/images/red-3.png', '2', '<h3>About this item</h3>\r\n\r\n<ul>\r\n	<li>Elegant Printed Design: Features intricate golden traditional motifs that create a graceful and sophisticated ethnic look for women</li>\r\n	<li>Designer Border And Pallu: Detailed patterned border and beautifully designed pallu add a rich traditional appeal to the saree</li>\r\n	<li>Classic Green And Gold Look: The timeless green and gold combination gives the saree a refined and versatile appearance for special occasions</li>\r\n	<li>Suitable For Special Occasions: Designed for weddings, festivals, family functions, parties, cultural events and festive celebrations</li>\r\n	<li>Easy To Style: Pair with traditional jewellery, elegant earrings and matching footwear to create a beautiful and sophisticated ethnic ensemble</li>\r\n	<li>Premium Silk Fabric: Made from quality silk material that offers a luxurious drape and comfortable wear throughout the day</li>\r\n</ul>', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Light Green</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Floral</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Saree Design</th>\r\n			<td>Chanderi, Banarsi, Woven, Printed</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Holiday Type</th>\r\n			<td>Christmas, Diwali, Valentine&#39;s Day</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Life Event</th>\r\n			<td>Anniversary, Birthday, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'published', 1, 1, 1, 0, 'Silk Saree with Designer Border and Traditional Floral Pattern', '', '', '2026-10-08 11:11:27.546812', '2026-10-11 09:32:21.592652', 4, 1, 899.00, '1499', '2026-10-11 08:58:59.595630+00:00'),
	(11, 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 'banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer', 'images/products/images/blouse-red.png', '2', '<h3>About this item</h3>\r\n\r\n<ul>\r\n	<li>FABRIC: Crafted from heavy Banarasi Art Silk, this saree offers a rich, lustrous finish with an elegant drape.</li>\r\n	<li>DESIGN: Features intricate Banarasi weaving patterns that lend a traditional and regal look, perfect for festive and wedding occasions.</li>\r\n	<li>INCLUDES BLOUSE PIECE: Comes with an unstitched blouse piece, allowing you to customise the blouse as per your preferred style and fit.</li>\r\n	<li>VERSATILE OCCASION WEAR: Ideal for weddings, receptions, pujas, and other celebratory events where traditional elegance is desired.</li>\r\n	<li>CARE INSTRUCTIONS: Dry clean recommended to maintain the sheen, texture, and longevity of the Art Silk fabric.</li>\r\n	<li>Rich Woven Borders: Elegantly framed by heavy gold or dual-tone zari borders and matching pallus featuring classic traditional motifs, including floral and geometric patterns.</li>\r\n</ul>', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>Multicolour</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Floral</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Festival, Party, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Zari</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Saree Design</th>\r\n			<td>Chanderi, Banarsi, Woven, Printed</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Classic</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Holiday Type</th>\r\n			<td>Diwali, New Year, Valentine&#39;s Day</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Life Event</th>\r\n			<td>Anniversary, Prom, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embellishment Feature</th>\r\n			<td>Zari Weaving</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'published', 0, 1, 1, 0, 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', '', '', '2026-10-08 12:17:35.234804', '2026-10-17 11:37:47.785771', 4, 1, 999.00, '1499', 'Vanika Silk'),
	(12, 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer Green', 'banarasi-soft-silk-saree-with-rich-woven-zari-butti-designer-green', 'images/products/images/green-1.png', '2', '<p>Explore the collection of beautifully designed sarees from &quot;SWORNOF&quot; on Amazon. Each piece is elegantly crafted and will surely add to your wardrobe. Pair this piece with heels or flats for a graceful look.Sarees are not just cloth to be draped around your waist, they are much more than that. With thousands of years of Indian traditions woven in, the saree has been popular through the ages for its ability to redefine elegance and accentuates the wearer&#39;s femininity.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>Product Dimensions &rlm; : &lrm; 630 x 111.76 x 0.05 cm; 620 g</li>\r\n	<li>Date First Available &rlm; : &lrm; 28 April 2023</li>\r\n	<li>Manufacturer &rlm; : &lrm; SWORNOF ADAJAN GAM,PAL ROAD</li>\r\n	<li>ASIN &rlm; : &lrm; B0C3VHMRPH</li>\r\n	<li>Item model number &rlm; : &lrm; KIROM_PURPLE</li>\r\n	<li>Country of Origin &rlm; : &lrm; India</li>\r\n	<li>Department &rlm; : &lrm; Women</li>\r\n	<li>Manufacturer &rlm; : &lrm; SWORNOF ADAJAN GAM,PAL ROAD</li>\r\n	<li>Packer &rlm; : &lrm; SWORNOF ADAJAN GAM,PAL ROAD</li>\r\n	<li>Item Weight &rlm; : &lrm; 620 g</li>\r\n	<li>Item Dimensions LxWxH &rlm; : &lrm; 6.3 x 1.12 Meters</li>\r\n	<li>Included Components &rlm; : &lrm; with blouse piece</li>\r\n	<li>Generic Name &rlm; : &lrm; Sarees</li>\r\n</ul>', '<ul>\r\n	<li>Material : SILK SAREE</li>\r\n	<li>Design :SEQANCE SAREE</li>\r\n	<li>Features : Saree With Blouse Piece</li>\r\n	<li>Style : The Texture And Weight Of The Saree Brings Image Prints One Step Closer To The Originals And Invites Attention</li>\r\n	<li>Occasion : Sarees for women, festive, traditional saree. Best birth-day gift for your loved ones. Each piece is elegantly crafted and will surely add to your wardrobe</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table>\r\n	<tbody>\r\n		<tr>\r\n			<th>Colour</th>\r\n			<td>PURPLE</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Pattern</th>\r\n			<td>Solid</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Occasion Type</th>\r\n			<td>Daily Wear, Festival, Party, Wedding</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Embroidery Type</th>\r\n			<td>Sequins</td>\r\n		</tr>\r\n		<tr>\r\n			<th>Style Name</th>\r\n			<td>Ready Pleated Saree</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 0.00, 0.00, 0.00, 0.00, 1, 0, 0, 'draft', 0, 1, 1, 0, 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer Green', '', '', '2026-10-17 08:32:35.528104', '2026-10-17 11:21:15.907243', 4, 1, 999.00, '1499', 'Vanika Silk');

-- Dumping structure for table kaya_db.products_review
CREATE TABLE IF NOT EXISTS `products_review` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_review_product_id_d933ffa7_fk_products_master_id` (`product_id`),
  CONSTRAINT `products_review_product_id_d933ffa7_fk_products_master_id` FOREIGN KEY (`product_id`) REFERENCES `products_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.products_review: ~11 rows (approximately)
DELETE FROM `products_review`;
INSERT INTO `products_review` (`id`, `name`, `email`, `rating`, `comment`, `created_at`, `product_id`) VALUES
	(1, 'sdfasdf', 'chandan@rathinfotech.com', 4, 'safas sad fsdfsadfa', '2026-10-12 18:05:12.022536', 2),
	(2, 'Traditional Saree', 'trtytr rt@adsf.fghd', 5, 'dfhgdf sdf dsf sd ', '2026-10-12 18:07:41.377996', 2),
	(3, 'sdfdsa asdf', 'sadsad@af.fgjh', 4, 'g sdf sdf sdf sghdfgh sfgh', '2026-10-12 18:08:40.598185', 2),
	(4, 'Traditional Saree', 'chandancse58@gmail.com', 3, 'sdf asdfasdfads', '2026-10-17 03:19:19.300854', 6),
	(5, 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 'chandancse58@gmail.com', 4, 'adfdsf sdf sd', '2026-10-17 05:56:58.953811', 6),
	(6, 'Silk Saree with Designer Border', 'chandan@rathinfotech.com', 5, 'adfdsfsdf ds', '2026-10-17 06:00:30.059426', 6),
	(7, 'Traditional Saree', 'chandan@rathinfotech.com', 4, 'asdas sa', '2026-10-17 06:02:28.807830', 6),
	(8, 'Deep Green Embroidered Georgette Saree', 'chandancse58@gmail.com', 4, 'adfsa ', '2026-10-17 06:03:03.978220', 7),
	(9, 'Chikankari Saree (Uttar Pradesh)', 'chandan@rathinfotech.com', 4, 'asdf asd', '2026-10-17 06:07:34.602932', 7),
	(10, 'Chikankari Saree (Uttar Pradesh)', 'chandan@rathinfotech.com', 4, 'dfedfe', '2026-10-17 06:09:34.551109', 7),
	(11, 'Silk Saree with Designer Border', 'chandancse58@gmail.com', 3, 'fcsadf', '2026-10-17 06:15:07.685663', 1),
	(12, 'Banarasi Soft Silk Saree with Rich Woven Zari Butti, Designer', 'chandan@rathinfotech.com', 4, 'afdsadfasd', '2026-10-17 06:16:33.814211', 1);

-- Dumping structure for table kaya_db.site_banners
CREATE TABLE IF NOT EXISTS `site_banners` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `link` varchar(500) DEFAULT NULL,
  `order` int(10) unsigned NOT NULL CHECK (`order` >= 0),
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `website_setting_id` bigint(20) NOT NULL,
  `banner_type` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_banners_website_setting_id_f354031d_fk_websitesetting_id` (`website_setting_id`),
  CONSTRAINT `site_banners_website_setting_id_f354031d_fk_websitesetting_id` FOREIGN KEY (`website_setting_id`) REFERENCES `websitesetting` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.site_banners: ~5 rows (approximately)
DELETE FROM `site_banners`;
INSERT INTO `site_banners` (`id`, `title`, `sub_title`, `image`, `link`, `order`, `is_active`, `created_at`, `website_setting_id`, `banner_type`) VALUES
	(1, 'Banner1', 'Banner1', 'images/site/banners/b3.png', NULL, 1, 1, '2026-08-23 12:44:24.626426', 1, 'home'),
	(2, 'Dewali Festival', 'Dewali Festival', 'images/site/banners/b2.png', NULL, 2, 1, '2026-08-23 12:44:45.567279', 1, 'home'),
	(3, 'Exclusive Collection', 'Exclusive Collection', 'images/site/banners/exclusive-banner.png', NULL, 0, 1, '2026-10-08 14:50:36.832305', 1, 'exclusive'),
	(4, 'Diwali Collection', 'Diwali Collection', 'images/site/banners/diwali-banner.png', NULL, 0, 1, '2026-10-08 14:51:07.695563', 1, 'home'),
	(5, 'Collection', 'collection', 'images/site/banners/1.jpg', NULL, 0, 1, '2026-10-08 17:07:38.710509', 1, 'festival'),
	(6, 'Collection', 'collection', 'images/site/banners/Gemini_Generated_Image_nt2whfnt2whfnt2w.png', NULL, 0, 1, '2026-10-08 17:08:05.408950', 1, 'festival');

-- Dumping structure for table kaya_db.websitesetting
CREATE TABLE IF NOT EXISTS `websitesetting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `site_title` varchar(100) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `favicon` varchar(100) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `city` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table kaya_db.websitesetting: ~0 rows (approximately)
DELETE FROM `websitesetting`;
INSERT INTO `websitesetting` (`id`, `site_title`, `logo`, `favicon`, `email`, `contact_number`, `address`, `city`) VALUES
	(1, 'Kaya Fashion', 'images/site/logo/logo.png', 'images/site/favicon/android-chrome-192x192.png', 'chandan@rathinfotech.com', '09967355303', 'Mumbai', 'Thane');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
