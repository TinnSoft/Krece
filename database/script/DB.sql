-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.19-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5145
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para krece
CREATE DATABASE IF NOT EXISTS `krece` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `krece`;

-- Volcando estructura para tabla krece.account
CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `account_key` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `email_footer` text,
  `invoice_design_id` int(11) unsigned DEFAULT '1',
  `work_phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pro_plan_paid` date DEFAULT NULL,
  `id_number` varchar(255) DEFAULT NULL,
  `email_template_invoice` text,
  `email_template_quote` text,
  `email_template_payment` text,
  `invoice_footer` text,
  `pdf_email_attachment` smallint(6) DEFAULT '0',
  `referral_user_id` int(10) unsigned DEFAULT NULL,
  `email_subject_invoice` varchar(255) DEFAULT NULL,
  `email_subject_quote` varchar(255) DEFAULT NULL,
  `email_subject_payment` varchar(255) DEFAULT NULL,
  `email_subject_reminder1` varchar(255) DEFAULT NULL,
  `email_template_reminder1` text,
  `enable_reminder1` bit(1) DEFAULT b'0',
  `num_days_reminder1` smallint(6) DEFAULT '7',
  `num_days_reminder2` smallint(6) DEFAULT '14',
  `num_days_reminder3` smallint(6) DEFAULT '30',
  `custom_invoice_text_label1` varchar(255) DEFAULT NULL,
  `custom_invoice_text_label2` varchar(255) DEFAULT NULL,
  `invoice_number_pattern` varchar(255) DEFAULT NULL,
  `quote_number_pattern` varchar(255) DEFAULT NULL,
  `quote_terms` text,
  `email_design_id` int(11) DEFAULT '1',
  `website` varchar(255) DEFAULT NULL,
  `show_currency_code` bit(1) DEFAULT NULL,
  `pro_plan_trial` date DEFAULT NULL,
  `enable_portal_password` bit(1) DEFAULT b'0',
  `send_portal_password` bit(1) DEFAULT b'0',
  `custom_invoice_item_label1` varchar(255) DEFAULT NULL,
  `custom_invoice_item_label2` varchar(255) DEFAULT NULL,
  `recurring_invoice_number_prefix` varchar(255) DEFAULT 'R',
  `enable_client_portal` bit(1) DEFAULT b'1',
  `invoice_fields` text,
  `company_id` int(11) DEFAULT NULL,
  `financial_year_start` date DEFAULT NULL,
  `enabled_modules` smallint(6) DEFAULT '63',
  `enabled_dashboard_sections` smallint(6) DEFAULT '7',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_account_key` (`account_key`),
  UNIQUE KEY `UK_account_email` (`email`),
  KEY `FK_account_company` (`company_id`),
  CONSTRAINT `FK_account_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Contains the account information for each user register in the app, in addition controls the the permisiones over the application';

-- Volcando datos para la tabla krece.account: ~5 rows (aproximadamente)
DELETE FROM `account`;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`id`, `created_at`, `updated_at`, `deleted_at`, `last_login`, `name`, `ip`, `account_key`, `address1`, `address2`, `email_footer`, `invoice_design_id`, `work_phone`, `email`, `pro_plan_paid`, `id_number`, `email_template_invoice`, `email_template_quote`, `email_template_payment`, `invoice_footer`, `pdf_email_attachment`, `referral_user_id`, `email_subject_invoice`, `email_subject_quote`, `email_subject_payment`, `email_subject_reminder1`, `email_template_reminder1`, `enable_reminder1`, `num_days_reminder1`, `num_days_reminder2`, `num_days_reminder3`, `custom_invoice_text_label1`, `custom_invoice_text_label2`, `invoice_number_pattern`, `quote_number_pattern`, `quote_terms`, `email_design_id`, `website`, `show_currency_code`, `pro_plan_trial`, `enable_portal_password`, `send_portal_password`, `custom_invoice_item_label1`, `custom_invoice_item_label2`, `recurring_invoice_number_prefix`, `enable_client_portal`, `invoice_fields`, `company_id`, `financial_year_start`, `enabled_modules`, `enabled_dashboard_sections`) VALUES
	(1, '2016-12-07 16:17:25', '2016-12-07 16:17:25', NULL, NULL, 'FERNANDO ARDILA', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'fernando2684@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, 1, NULL, 63, 7),
	(2, '2016-12-07 17:19:15', '2016-12-07 17:19:15', NULL, NULL, 'FERNANDO ARDILA', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'fernando26842@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, NULL, 63, 7),
	(3, '2016-12-07 17:22:30', '2016-12-07 17:22:30', NULL, NULL, 'FERNANDO ARDILA', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'fernandwo2684@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, NULL, 63, 7),
	(4, '2016-12-07 17:23:23', '2016-12-07 17:23:23', NULL, NULL, 'FERNANDO ARDILA', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'fernando268422@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, NULL, 63, 7),
	(5, '2016-12-07 22:43:02', '2016-12-07 22:43:02', NULL, NULL, 'FERNANDO ARDILA', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'fernando2684fff@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, NULL, 63, 7);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

-- Volcando estructura para tabla krece.account_tokens
CREATE TABLE IF NOT EXISTS `account_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `public_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_tokens_token_unique` (`token`),
  UNIQUE KEY `account_tokens_account_id_public_id_unique` (`account_id`,`public_id`),
  KEY `account_tokens_user_id_foreign` (`user_id`),
  KEY `account_tokens_account_id_index` (`account_id`),
  CONSTRAINT `FK_account_tokens_accountid` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_account_tokens_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.account_tokens: ~0 rows (aproximadamente)
DELETE FROM `account_tokens`;
/*!40000 ALTER TABLE `account_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bank_account
CREATE TABLE IF NOT EXISTS `bank_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `bank_account_type` int(11) NOT NULL,
  `bank_account_name` varchar(100) NOT NULL,
  `bank_account_number` varchar(100) DEFAULT NULL,
  `initial_balance` float NOT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_BA_public_id_account_id` (`public_id`,`account_id`),
  KEY `FK_banks_accounttype` (`bank_account_type`),
  KEY `FK_banks_company` (`user_id`),
  KEY `FK_banks_account` (`account_id`),
  CONSTRAINT `FK_banks_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_banks_accounttype` FOREIGN KEY (`bank_account_type`) REFERENCES `bank_account_type` (`id`),
  CONSTRAINT `FK_banks_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='bank information related with accounts';

-- Volcando datos para la tabla krece.bank_account: ~3 rows (aproximadamente)
DELETE FROM `bank_account`;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
INSERT INTO `bank_account` (`id`, `user_id`, `public_id`, `account_id`, `bank_account_type`, `bank_account_name`, `bank_account_number`, `initial_balance`, `description`, `created_at`, `updated_at`, `deleted_at`, `isDeleted`) VALUES
	(1, 1, 1, 1, 1, 'Banco 1', '', 0, '', '2017-01-18 14:20:49', '2017-01-19 08:17:26', '2017-01-19 08:17:11', b'0'),
	(2, 1, 2, 1, 2, 'Tarjeta de crédito 1', '', 0, '', '2017-01-18 15:42:26', '2017-01-18 15:42:26', NULL, b'0'),
	(3, 1, 3, 1, 3, 'Caja General', '', 0, '', '2017-01-18 15:43:04', '2017-01-18 15:43:04', NULL, b'0');
/*!40000 ALTER TABLE `bank_account` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bank_account_type
CREATE TABLE IF NOT EXISTS `bank_account_type` (
  `id` int(11) NOT NULL,
  `description` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='account type default for the bank section';

-- Volcando datos para la tabla krece.bank_account_type: ~3 rows (aproximadamente)
DELETE FROM `bank_account_type`;
/*!40000 ALTER TABLE `bank_account_type` DISABLE KEYS */;
INSERT INTO `bank_account_type` (`id`, `description`) VALUES
	(1, 'Banco'),
	(2, 'Tarjeta de Crédito'),
	(3, 'Efectivo');
/*!40000 ALTER TABLE `bank_account_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `niif_account` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isEditable` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `type_id` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_category_account` (`account_id`),
  KEY `FK_category_parent` (`parent_id`),
  KEY `FK_category_user` (`user_id`),
  KEY `FK_category_type` (`type_id`),
  CONSTRAINT `FK_category_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_category_type` FOREIGN KEY (`type_id`) REFERENCES `category_type` (`id`),
  CONSTRAINT `FK_category_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1 COMMENT='product categories';

-- Volcando datos para la tabla krece.category: ~83 rows (aproximadamente)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `account_id`, `user_id`, `parent_id`, `lft`, `rgt`, `name`, `niif_account`, `description`, `isEditable`, `isDeleted`, `type_id`, `updated_at`, `created_at`) VALUES
	(28, 1, 1, NULL, 1, 14, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'0', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(29, 1, 1, 28, 2, 3, 'Devoluciones de ventas', NULL, NULL, b'0', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(30, 1, 1, 28, 4, 5, 'Ingreso sin identificar', NULL, NULL, b'0', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(31, 1, 1, 28, 6, 11, 'Ingresos no operacionales', NULL, NULL, b'0', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(32, 1, 1, 31, 7, 10, 'Otros Ingresos', NULL, NULL, b'0', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(33, 1, 1, 32, 8, 9, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'0', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(34, 1, 1, 28, 12, 13, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(35, 1, 1, NULL, 15, 50, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'0', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(36, 1, 1, 35, 16, 23, 'Activo corriente', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(37, 1, 1, 36, 17, 18, 'Bancos', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(38, 1, 1, 36, 19, 20, 'Cuentas por cobrar', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(39, 1, 1, 36, 21, 22, 'Inventario', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(40, 1, 1, 35, 24, 25, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'0', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(41, 1, 1, 35, 26, 27, 'Avances y anticipos entregados', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(42, 1, 1, 35, 28, 29, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(43, 1, 1, 35, 30, 35, 'Impuestos a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(44, 1, 1, 43, 31, 32, 'ICO a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(45, 1, 1, 43, 33, 34, 'IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(46, 1, 1, 35, 36, 37, 'Inversiones', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(47, 1, 1, 35, 38, 39, 'Préstamos a terceros', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(48, 1, 1, 35, 40, 49, 'Retenciones a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(49, 1, 1, 48, 41, 42, 'Retención de CREE a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(50, 1, 1, 48, 43, 44, 'Retención de Industria y comercio a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(51, 1, 1, 48, 45, 46, 'Retención de IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(52, 1, 1, 48, 47, 48, 'Retención en la fuente a favor', NULL, NULL, b'0', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(53, 1, 1, NULL, 51, 124, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(54, 1, 1, 53, 52, 53, 'Alquiler de equipos y licencias', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(55, 1, 1, 53, 54, 55, 'Comisiones y honorarios', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(56, 1, 1, 53, 56, 67, 'Costo de la mercancía vendida', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(57, 1, 1, 56, 57, 58, 'Ajustes del inventario', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(58, 1, 1, 56, 59, 60, 'Compras inventariables', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(59, 1, 1, 56, 61, 62, 'Fletes y envíos', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(60, 1, 1, 56, 63, 64, 'Mano de obra', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(61, 1, 1, 56, 65, 66, 'Materias primas', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(62, 1, 1, 53, 68, 69, 'Costo servicios vendidos', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(63, 1, 1, 53, 70, 71, 'Cuentas incobrables', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(64, 1, 1, 53, 72, 73, 'Devoluciones en compras de ítem', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(65, 1, 1, 53, 74, 79, 'Egresos no operacionales', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(66, 1, 1, 65, 75, 76, 'Descuento financiero', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(67, 1, 1, 65, 77, 78, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(68, 1, 1, 53, 80, 91, 'Gastos administrativos', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(69, 1, 1, 68, 81, 82, 'Arrendamiento', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(70, 1, 1, 68, 83, 84, 'Aseo y cafetería', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(71, 1, 1, 68, 85, 86, 'Internet y telecomunicaciones', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(72, 1, 1, 68, 87, 88, 'Papelería', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(73, 1, 1, 68, 89, 90, 'Servicios públicos', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(74, 1, 1, 53, 92, 93, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(75, 1, 1, 53, 94, 95, 'Legales', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(76, 1, 1, 53, 96, 97, 'Mantenimiento e instalaciones', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(77, 1, 1, 53, 98, 107, 'Nómina', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(78, 1, 1, 77, 99, 100, 'Dotación', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(79, 1, 1, 77, 101, 102, 'Prestaciones sociales', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(80, 1, 1, 77, 103, 104, 'Salarios', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(81, 1, 1, 77, 105, 106, 'Seguridad social y parafiscales', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(82, 1, 1, 53, 108, 109, 'Otros impuestos', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(83, 1, 1, 53, 110, 111, 'Publicidad', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(84, 1, 1, 53, 112, 113, 'Seguros y seguridad', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(85, 1, 1, 53, 114, 115, 'Servicios bancarios', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(86, 1, 1, 53, 116, 117, 'Subscripciones y afiliaciones', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(87, 1, 1, 53, 118, 119, 'Transporte y mensajería', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(88, 1, 1, 53, 120, 121, 'Varios', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(89, 1, 1, 53, 122, 123, 'Viajes y viáticos', NULL, NULL, b'0', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(90, 1, 1, NULL, 125, 152, 'Pasivos', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(91, 1, 1, 90, 126, 127, 'Avances y anticipos recibidos', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(92, 1, 1, 90, 128, 129, 'Cuentas por pagar - devoluciones', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(93, 1, 1, 90, 130, 131, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'0', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(94, 1, 1, 90, 132, 133, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(95, 1, 1, 90, 134, 139, 'Impuestos por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(96, 1, 1, 95, 135, 136, 'ICO por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(97, 1, 1, 95, 137, 138, 'IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(98, 1, 1, 90, 140, 141, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(99, 1, 1, 90, 142, 151, 'Retenciones por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(100, 1, 1, 99, 143, 144, 'Retención de CREE por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(101, 1, 1, 99, 145, 146, 'Retención de industria y Comercio por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(102, 1, 1, 99, 147, 148, 'Retención de IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(103, 1, 1, 99, 149, 150, 'Retención en la fuente por pagar', NULL, NULL, b'0', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(104, 1, 1, NULL, 153, 162, 'Patrimonio', NULL, NULL, b'0', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(105, 1, 1, 104, 154, 155, 'Ajustes iniciales - Bancos', NULL, NULL, b'0', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(106, 1, 1, 104, 156, 157, 'Ajustes iniciales - Inventario', NULL, NULL, b'0', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(107, 1, 1, 104, 158, 159, 'Capital accionistas', NULL, NULL, b'0', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(108, 1, 1, 104, 160, 161, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'0', b'0', 5, '2017-02-01 11:01:17', '2017-02-01 11:01:17'),
	(109, 1, 1, NULL, 163, 164, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-02-01 11:01:17', '2017-02-01 11:01:17');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Volcando estructura para tabla krece.category_payment
CREATE TABLE IF NOT EXISTS `category_payment` (
  `payment_id` bigint(20) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `unit_price` float NOT NULL,
  `tax_id` int(11) NOT NULL,
  `tax_amount` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `observations` text,
  UNIQUE KEY `payment_id_company_id_category_id_tax_id` (`payment_id`,`account_id`,`category_id`,`tax_id`),
  KEY `FK_cp_tax` (`tax_id`),
  KEY `FK_cp_company_id` (`account_id`),
  KEY `FK_cp_payment_id` (`payment_id`),
  KEY `FK_cp_category` (`category_id`),
  KEY `FK_cp_user` (`user_id`),
  CONSTRAINT `FK_cp_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_cp_company_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_cp_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK_cp_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.category_payment: ~0 rows (aproximadamente)
DELETE FROM `category_payment`;
/*!40000 ALTER TABLE `category_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.category_type
CREATE TABLE IF NOT EXISTS `category_type` (
  `id` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.category_type: ~6 rows (aproximadamente)
DELETE FROM `category_type`;
/*!40000 ALTER TABLE `category_type` DISABLE KEYS */;
INSERT INTO `category_type` (`id`, `type`) VALUES
	(1, 'Ingreso'),
	(2, 'Egreso'),
	(3, 'Activo'),
	(4, 'Pasivo'),
	(5, 'Patrimonio'),
	(6, 'Transferencia');
/*!40000 ALTER TABLE `category_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.company
CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `identification` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `website` varchar(300) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `regime_id` int(11) DEFAULT NULL COMMENT 'related with the "regimen" of a company: comun, simplificado.etc',
  `logo` longtext COMMENT 'company''s logo',
  `decimal_precision` tinyint(4) DEFAULT NULL,
  `decimal_separator` char(1) DEFAULT NULL,
  `plan` enum('pro','enterprise','white_label') DEFAULT NULL,
  `plan_term` enum('month','year') DEFAULT NULL,
  `plan_started` date DEFAULT NULL,
  `plan_paid` date DEFAULT NULL,
  `plan_expires` date DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `trial_started` date DEFAULT NULL,
  `trial_plan` enum('pro','enterprise') DEFAULT NULL,
  `pending_plan` enum('pro','enterprise','free') DEFAULT NULL,
  `pending_term` enum('month','year') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_company_email` (`email`),
  KEY `idx_company` (`regime_id`),
  CONSTRAINT `fk_company_regime` FOREIGN KEY (`regime_id`) REFERENCES `company_regime` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.company: ~0 rows (aproximadamente)
DELETE FROM `company`;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`, `name`, `identification`, `address`, `phone`, `website`, `email`, `city`, `regime_id`, `logo`, `decimal_precision`, `decimal_separator`, `plan`, `plan_term`, `plan_started`, `plan_paid`, `plan_expires`, `payment_id`, `trial_started`, `trial_plan`, `pending_plan`, `pending_term`, `created_at`, `updated_at`) VALUES
	(1, 'Mi empresa', '12345', 'calle 12 # 2-49', '123456', 'www.tinnsoft.com', 'fernando2684@gmail.com', 'Bogotá', 3, 'data:image/png;base64,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', 2, '.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-02-07 09:14:06', '2017-02-08 07:52:01');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;

-- Volcando estructura para tabla krece.company_regime
CREATE TABLE IF NOT EXISTS `company_regime` (
  `id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.company_regime: ~4 rows (aproximadamente)
DELETE FROM `company_regime`;
/*!40000 ALTER TABLE `company_regime` DISABLE KEYS */;
INSERT INTO `company_regime` (`id`, `value`) VALUES
	(1, 'Regimen comun'),
	(2, 'Regimen simplificado'),
	(3, 'Regimen especial'),
	(4, 'Regimen simplicado impuesto nacional al consumo');
/*!40000 ALTER TABLE `company_regime` ENABLE KEYS */;

-- Volcando estructura para tabla krece.conciliation
CREATE TABLE IF NOT EXISTS `conciliation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `date_update` datetime DEFAULT NULL,
  `bank_expens` float DEFAULT NULL,
  `bank_tax` float DEFAULT NULL,
  `bank_in` float DEFAULT NULL,
  `balance_initial` float NOT NULL,
  `balance_last` float NOT NULL,
  `difference` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_conciliation_bank` (`bank_id`),
  KEY `FK_conciliation_accountid` (`account_id`),
  KEY `FK_conciliation_user` (`user_id`),
  CONSTRAINT `FK_conciliation_accountid` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_conciliation_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank_account` (`id`),
  CONSTRAINT `FK_conciliation_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='conciliation of accounts';

-- Volcando datos para la tabla krece.conciliation: ~0 rows (aproximadamente)
DELETE FROM `conciliation`;
/*!40000 ALTER TABLE `conciliation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conciliation` ENABLE KEYS */;

-- Volcando estructura para tabla krece.contact
CREATE TABLE IF NOT EXISTS `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `nit` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `phone_mobile` varchar(20) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `payment_terms_id` int(11) DEFAULT NULL,
  `observation` text,
  `include_account_state` bit(1) NOT NULL DEFAULT b'0',
  `isProvider` bit(1) NOT NULL DEFAULT b'0',
  `isCustomer` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_contacts_company_id_email` (`account_id`,`public_id`),
  KEY `FK_contacts_seller` (`seller_id`),
  KEY `FK_contacts_payment_term` (`payment_terms_id`),
  KEY `FK_contacts_company` (`account_id`),
  KEY `FK_contacts_list_price` (`list_price_id`),
  KEY `FK_contacts_user` (`user_id`),
  CONSTRAINT `FK_contacts_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_contacts_list_price` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_contacts_payment_term` FOREIGN KEY (`payment_terms_id`) REFERENCES `payment_terms` (`id`),
  CONSTRAINT `FK_contacts_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_contacts_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COMMENT='contains the whole set of contacts of each company';

-- Volcando datos para la tabla krece.contact: ~19 rows (aproximadamente)
DELETE FROM `contact`;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` (`id`, `account_id`, `user_id`, `public_id`, `name`, `nit`, `address`, `city`, `email`, `phone1`, `phone2`, `fax`, `phone_mobile`, `list_price_id`, `seller_id`, `payment_terms_id`, `observation`, `include_account_state`, `isProvider`, `isCustomer`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'cliente 1', '1234506', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'este contacto es primordpial', b'0', b'0', b'1', b'0', '2016-12-13 15:01:44', '2017-02-07 20:56:03', NULL),
	(4, 1, 1, 2, 'cliente 2', '80810419', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'0', '2016-12-15 16:43:30', '2016-12-15 16:43:31', NULL),
	(5, 1, 1, 3, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:43:37', '2017-01-31 15:24:11', '2017-01-31 15:24:11'),
	(6, 1, 1, 4, 'Proveedor 1', NULL, NULL, NULL, 'prov1@gmail.com', NULL, NULL, NULL, NULL, 1, 2, 2, NULL, b'0', b'1', b'0', b'0', '2017-01-19 20:44:14', '2017-01-31 12:22:50', '2017-01-31 11:39:53'),
	(7, 1, 1, 5, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:44:32', '2017-01-31 12:23:03', '2017-01-31 12:23:03'),
	(8, 1, 1, 6, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:44:48', '2017-01-31 12:24:57', '2017-01-31 12:24:57'),
	(9, 1, 1, 7, 'proveedor 5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 4, 1, NULL, b'0', b'1', b'0', b'0', '2017-01-19 20:44:56', '2017-01-31 12:24:50', '2017-01-31 11:17:36'),
	(10, 1, 1, 8, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:45:18', '2017-01-31 13:43:28', '2017-01-31 13:43:28'),
	(11, 1, 1, 9, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-19 20:45:43', '2017-01-30 21:10:15', '2017-01-30 21:10:15'),
	(12, 1, 1, 10, 'as', '', '', '', '', '', '', '', '', NULL, NULL, 2, '', b'0', b'0', b'1', b'0', '2017-01-19 20:47:38', '2017-01-25 14:25:15', '2017-01-25 14:25:15'),
	(13, 1, 1, 11, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-19 20:50:41', '2017-01-25 13:58:46', '2017-01-25 13:58:46'),
	(14, 1, 1, 12, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-19 20:52:09', '2017-01-25 13:57:24', '2017-01-25 13:57:24'),
	(15, 1, 1, 13, 'prueba cliente', '', '', 'bogota', '', '', '', '', '', 1, 2, 2, '', b'0', b'0', b'1', b'0', '2017-01-19 20:55:22', '2017-01-31 11:14:24', '2017-01-31 11:14:24'),
	(16, 1, 1, 14, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-19 20:55:32', '2017-01-25 13:58:43', '2017-01-25 13:58:43'),
	(17, 1, 1, 15, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-19 20:57:22', '2017-01-25 13:58:39', '2017-01-25 13:58:39'),
	(18, 1, 1, 16, 'Fernando Ardila', '80810419', 'Calle 12 # 2-49', 'Bogota', 'fernando2684@gmail.com', '3123633753', 'phone2', '', '3123633753', 1, 2, 2, 'Observaciones', b'0', b'1', b'1', b'0', '2017-01-24 11:44:45', '2017-01-24 13:29:53', NULL),
	(19, 1, 1, 17, 'test', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-24 16:44:45', '2017-01-25 13:57:38', '2017-01-25 13:57:38'),
	(20, 2, 2, 1, 'contacto1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-24 16:44:53', '2017-01-24 16:44:53', NULL),
	(21, 2, 2, 2, 'contacto 2', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-24 16:45:19', '2017-01-24 16:45:19', NULL);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;

-- Volcando estructura para tabla krece.contact_others
CREATE TABLE IF NOT EXISTS `contact_others` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'pk about the father of the set included here',
  `contact_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone_mobile` varchar(20) DEFAULT NULL,
  `notify` bit(1) NOT NULL DEFAULT b'0' COMMENT 'allows to send automatic notifications to the customer or provider selected',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_contact_others_contact_id_email` (`account_id`,`id`),
  KEY `FK_contacts_others_user` (`user_id`),
  KEY `FK_contacts_contact_id` (`contact_id`),
  CONSTRAINT `FK_contacts_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_contacts_others_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_contacts_others_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1 COMMENT='this table contains other email contacts of any organization';

-- Volcando datos para la tabla krece.contact_others: ~5 rows (aproximadamente)
DELETE FROM `contact_others`;
/*!40000 ALTER TABLE `contact_others` DISABLE KEYS */;
INSERT INTO `contact_others` (`id`, `account_id`, `contact_id`, `user_id`, `name`, `last_name`, `email`, `phone`, `phone_mobile`, `notify`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(4, 1, 17, 1, 'as', NULL, '', '', '', b'1', '2017-01-19 20:57:22', '2017-01-19 20:57:22', NULL),
	(43, 1, 18, 1, 'Asoc1', 'apellido', 'asoc1@gmail.com', '', '', b'1', '2017-01-24 13:29:53', '2017-01-24 13:29:53', NULL),
	(44, 1, 18, 1, 'asoc2', '', 'asoc2@gmail.com', 'phone2', 'cell', b'1', '2017-01-24 13:29:53', '2017-01-24 13:29:53', NULL),
	(45, 1, 18, 1, 'asoc3', 'appellido', 'asoc3@gmail.com', 'phone3', 'cell', b'1', '2017-01-24 13:29:53', '2017-01-24 13:29:53', NULL),
	(46, 1, 15, 1, 'as', NULL, '', '', '', b'1', '2017-01-25 13:59:24', '2017-01-25 13:59:24', NULL);
/*!40000 ALTER TABLE `contact_others` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note
CREATE TABLE IF NOT EXISTS `credit_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `document_number` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `due_date` int(11) DEFAULT NULL,
  `notes` int(11) DEFAULT NULL,
  `observations` int(11) DEFAULT NULL,
  `exchange_rate` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_credit_note_company` (`account_id`),
  KEY `FK_credit_note_seller` (`seller_id`),
  KEY `FK_credit_note_list_price` (`list_price_id`),
  KEY `FK_credit_note_customer` (`customer_id`),
  KEY `FK_credit_note_currency` (`currency_code`),
  KEY `FK_credit_note_status` (`status_id`),
  KEY `FK_credit_note_user` (`user_id`),
  CONSTRAINT `FK_credit_note_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_credit_note_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_credit_note_customer` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_credit_note_list_price` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_credit_note_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_credit_note_status` FOREIGN KEY (`status_id`) REFERENCES `credit_note_status` (`id`),
  CONSTRAINT `FK_credit_note_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note: ~0 rows (aproximadamente)
DELETE FROM `credit_note`;
/*!40000 ALTER TABLE `credit_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_note` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note_detail
CREATE TABLE IF NOT EXISTS `credit_note_detail` (
  `credit_note_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_type_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `gross_total` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  KEY `FK_credit_note_detail_credit_note_id` (`credit_note_id`),
  KEY `FK_credit_note_detail_item` (`product_id`),
  KEY `FK_credit_note_detail_tax` (`tax_type_id`),
  KEY `FK_credit_note:user` (`user_id`),
  CONSTRAINT `FK_credit_note:user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_credit_note_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_credit_note_detail_remision_id` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note_detail: ~0 rows (aproximadamente)
DELETE FROM `credit_note_detail`;
/*!40000 ALTER TABLE `credit_note_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_note_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note_status
CREATE TABLE IF NOT EXISTS `credit_note_status` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note_status: ~0 rows (aproximadamente)
DELETE FROM `credit_note_status`;
/*!40000 ALTER TABLE `credit_note_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_note_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note_transaction
CREATE TABLE IF NOT EXISTS `credit_note_transaction` (
  `credit_note_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  PRIMARY KEY (`credit_note_id`,`transaction_id`),
  KEY `FK_cnt_transaction_id` (`transaction_id`),
  CONSTRAINT `FK_cnt_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `FK_cnt_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note_transaction: ~0 rows (aproximadamente)
DELETE FROM `credit_note_transaction`;
/*!40000 ALTER TABLE `credit_note_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_note_transaction` ENABLE KEYS */;

-- Volcando estructura para tabla krece.currency
CREATE TABLE IF NOT EXISTS `currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code_id` varchar(3) NOT NULL,
  `exchange_rate` float NOT NULL,
  `status_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_currency_company_id_code_id` (`account_id`,`public_id`),
  KEY `FK_currency_code` (`code_id`),
  KEY `FK_currency_status` (`status_id`),
  KEY `FK_currency_user` (`user_id`),
  KEY `IDX_currency_public_id` (`public_id`),
  CONSTRAINT `FK_currency_code` FOREIGN KEY (`code_id`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_currency_status` FOREIGN KEY (`status_id`) REFERENCES `currency_status` (`id`),
  CONSTRAINT `FK_currency_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_currency_company` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.currency: ~2 rows (aproximadamente)
DELETE FROM `currency`;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` (`id`, `account_id`, `public_id`, `user_id`, `code_id`, `exchange_rate`, `status_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'COP', 1, 1, '2017-01-12 10:27:15', '2017-01-12 10:27:17', NULL),
	(6, 1, 2, 1, 'USD', 1, 1, '2017-01-12 11:10:57', '2017-01-12 11:10:58', NULL);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;

-- Volcando estructura para tabla krece.currency_code
CREATE TABLE IF NOT EXISTS `currency_code` (
  `code` varchar(3) NOT NULL,
  `country` varchar(30) DEFAULT NULL,
  `symbol` varchar(5) DEFAULT NULL,
  `precision` tinyint(4) DEFAULT NULL,
  `thousand_separator` char(1) DEFAULT NULL,
  `decimal_separator` char(1) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `order` int(11) DEFAULT '2',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='default values for the kind of money around the world';

-- Volcando datos para la tabla krece.currency_code: ~37 rows (aproximadamente)
DELETE FROM `currency_code`;
/*!40000 ALTER TABLE `currency_code` DISABLE KEYS */;
INSERT INTO `currency_code` (`code`, `country`, `symbol`, `precision`, `thousand_separator`, `decimal_separator`, `name`, `isActive`, `order`) VALUES
	('AED', NULL, 'DH ', 2, ',', '.', 'United Arab Emirates Dirham', b'1', 2),
	('ARS', NULL, '$', 2, '.', ',', 'Argentine Peso', b'1', 2),
	('AUD', NULL, '$', 2, ',', '.', 'Australian Dollar', b'1', 2),
	('AWG', NULL, 'Afl. ', 2, '', '.', 'Aruban Florin', b'1', 2),
	('BDT', NULL, 'Tk', 2, ',', '.', 'Bangladeshi Taka', b'1', 2),
	('BRL', 'Brasil', 'R$', 2, '.', ',', 'Brazilian Real', b'1', 2),
	('CAD', NULL, 'C$', 2, ',', '.', 'Canadian Dollar', b'1', 2),
	('CNY', NULL, 'RMB ', 2, ',', '.', 'Chinese Renminbi', b'1', 2),
	('COP', 'Colombia', '$', 2, '.', ',', 'Colombian Peso', b'1', 1),
	('DKK', NULL, 'kr ', 2, '.', ',', 'Danish Krone', b'1', 2),
	('EGP', NULL, 'E£', 2, ',', '.', 'Egyptian Pound', b'1', 2),
	('EUR', NULL, '€', 2, '.', ',', 'Euro', b'1', 2),
	('GBP', NULL, '£', 2, ',', '.', 'British Pound', b'1', 2),
	('GTQ', NULL, 'Q', 2, ',', '.', 'Guatemalan Quetzal', b'1', 2),
	('HKR', NULL, 'kn', 2, '.', ',', 'Croatian Kuna', b'1', 2),
	('IDR', NULL, 'Rp', 2, ',', '.', 'Indonesian Rupiah', b'1', 2),
	('ILS', NULL, 'NIS ', 2, ',', '.', 'Israeli Shekel', b'1', 2),
	('INR', NULL, 'Rs. ', 2, ',', '.', 'Indian Rupee', b'1', 2),
	('JPY', NULL, '¥', 0, ',', '.', 'Japanese Yen', b'1', 2),
	('KES', NULL, 'KSh ', 2, ',', '.', 'Kenyan Shilling', b'1', 2),
	('LKR', NULL, 'LKR', 2, ',', '.', 'Sri Lankan Rupee', b'1', 2),
	('MXN', NULL, '$', 2, ',', '.', 'Mexican Peso', b'1', 2),
	('MYR', NULL, 'RM', 2, ',', '.', 'Malaysian Ringgit', b'1', 2),
	('NOK', NULL, 'kr ', 2, '.', ',', 'Norske Kroner', b'1', 2),
	('NZD', NULL, '$', 2, ',', '.', 'New Zealand Dollar', b'1', 2),
	('PHP', NULL, 'P ', 2, ',', '.', 'Philippine Peso', b'1', 2),
	('PKR', NULL, 'Rs ', 0, ',', '.', 'Pakistani Rupee', b'1', 2),
	('PLN', NULL, 'z?', 2, '', ',', 'Polish Zloty', b'1', 2),
	('RWF', NULL, 'RF ', 2, ',', '.', 'Rwandan Franc', b'1', 2),
	('SEK', NULL, 'kr ', 2, '.', ',', 'Swedish Krona', b'1', 2),
	('TRY', NULL, 'TL ', 2, '.', ',', 'Turkish Lira', b'1', 2),
	('TTD', NULL, 'TT$', 2, ',', '.', 'Trinidad and Tobago Dollar', b'1', 2),
	('TZS', NULL, 'TSh ', 2, ',', '.', 'Tanzanian Shilling', b'1', 2),
	('USD', NULL, '$', 2, ',', '.', 'US Dollar', b'1', 1),
	('XCD', NULL, 'EC$', 2, ',', '.', 'East Caribbean Dollar', b'1', 2),
	('XOF', NULL, 'CFA ', 2, ',', '.', 'West African Franc', b'1', 2),
	('ZAR', NULL, 'R', 2, '.', ',', 'South African Rand', b'1', 2);
/*!40000 ALTER TABLE `currency_code` ENABLE KEYS */;

-- Volcando estructura para tabla krece.currency_status
CREATE TABLE IF NOT EXISTS `currency_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.currency_status: ~2 rows (aproximadamente)
DELETE FROM `currency_status`;
/*!40000 ALTER TABLE `currency_status` DISABLE KEYS */;
INSERT INTO `currency_status` (`id`, `description`) VALUES
	(1, 'Activo'),
	(2, 'Eliminado');
/*!40000 ALTER TABLE `currency_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.debit_note
CREATE TABLE IF NOT EXISTS `debit_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `document_number` int(11) NOT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `notes` text COMMENT 'vissible inf the supplier invoice',
  `observations` text COMMENT 'for customer tracking , just internal',
  `exchange_rate` float DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`document_number`),
  KEY `FK_debit_note_currency` (`currency_code`),
  KEY `FK_debit_note_customerID` (`customer_id`),
  KEY `FK_debit_note_user` (`user_id`),
  CONSTRAINT `FK_debit_note_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_debit_note_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_debit_note_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_debit_note_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.debit_note: ~0 rows (aproximadamente)
DELETE FROM `debit_note`;
/*!40000 ALTER TABLE `debit_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `debit_note` ENABLE KEYS */;

-- Volcando estructura para tabla krece.debit_note_detail
CREATE TABLE IF NOT EXISTS `debit_note_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `debit_note_id` bigint(20) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `taxt_type_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `gross_total` float NOT NULL,
  `total` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_debit_note_detail_company` (`user_id`),
  KEY `FK_debit_note_detail_id` (`debit_note_id`),
  KEY `FK_debit_note_detail_tax_id` (`taxt_type_id`),
  KEY `FK_category_id` (`category_id`),
  CONSTRAINT `FK_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_debit_note_detail_po` FOREIGN KEY (`debit_note_id`) REFERENCES `debit_note` (`id`),
  CONSTRAINT `FK_debit_note_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.debit_note_detail: ~0 rows (aproximadamente)
DELETE FROM `debit_note_detail`;
/*!40000 ALTER TABLE `debit_note_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `debit_note_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.debit_note_transaction
CREATE TABLE IF NOT EXISTS `debit_note_transaction` (
  `debit_note_id` bigint(20) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  PRIMARY KEY (`debit_note_id`,`transaction_id`),
  KEY `FK_dnt_transaction` (`transaction_id`),
  CONSTRAINT `FK_dnt_debit_note` FOREIGN KEY (`debit_note_id`) REFERENCES `debit_note` (`id`),
  CONSTRAINT `FK_dnt_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='link between the debit note and the transaction table, a user can add a payment that is stored in transaction table.';

-- Volcando datos para la tabla krece.debit_note_transaction: ~0 rows (aproximadamente)
DELETE FROM `debit_note_transaction`;
/*!40000 ALTER TABLE `debit_note_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `debit_note_transaction` ENABLE KEYS */;

-- Volcando estructura para tabla krece.estimate
CREATE TABLE IF NOT EXISTS `estimate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `sub_total` float DEFAULT '0',
  `total_discounts` float DEFAULT '0',
  `total_taxes` float DEFAULT '0',
  `total` float DEFAULT '0',
  `date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `notes` text,
  `observations` text,
  `exchange_rate` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_quote_account_id` (`account_id`,`public_id`),
  KEY `FK_estimate_client` (`customer_id`),
  KEY `FK_estimate_currency_code` (`currency_code`),
  KEY `FK_estimate_user` (`user_id`),
  CONSTRAINT `FK_estimate_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_estimate_client` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_estimate_currency_code` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_estimate_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate: ~26 rows (aproximadamente)
DELETE FROM `estimate`;
/*!40000 ALTER TABLE `estimate` DISABLE KEYS */;
INSERT INTO `estimate` (`id`, `account_id`, `public_id`, `user_id`, `seller_id`, `list_price_id`, `customer_id`, `currency_code`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `date`, `due_date`, `notes`, `observations`, `exchange_rate`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 2000, '2016-12-13', '2016-12-13', 'notas act', 'observaciones', 1, b'0', '2016-12-13 14:51:38', '2017-01-12 17:54:59', '0000-00-00 00:00:00'),
	(2, 2, 1, 2, NULL, NULL, 1, 'COP', NULL, NULL, NULL, 123, '2016-12-13', '2016-12-13', 'notes', 'observ', 1, b'0', '2016-12-13 18:07:49', '2016-12-13 18:07:50', NULL),
	(4, 1, 2, 1, 1, 1, 1, 'COP', NULL, NULL, NULL, 3000, '2017-01-12', '2017-01-12', 'notas', NULL, NULL, b'0', '2017-01-03 19:52:07', '2017-01-12 17:56:03', NULL),
	(7, 1, 3, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 2000, '2017-01-13', '2017-01-13', 'nota', NULL, NULL, b'0', '2017-01-03 20:30:07', '2017-01-13 18:09:52', NULL),
	(9, 1, 4, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:14:12', '2017-01-03 21:14:12', NULL),
	(10, 1, 5, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:15:14', '2017-01-03 21:15:14', NULL),
	(11, 1, 6, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:16:45', '2017-01-03 21:16:45', NULL),
	(12, 1, 7, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:17:51', '2017-01-03 21:17:51', NULL),
	(13, 1, 8, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:18:05', '2017-01-03 21:18:05', NULL),
	(14, 1, 9, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:20:11', '2017-01-03 21:20:11', NULL),
	(15, 1, 10, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:20:55', '2017-02-06 09:51:15', '2017-02-06 09:51:15'),
	(16, 1, 11, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:20:57', '2017-02-06 09:51:10', '2017-02-06 09:51:10'),
	(17, 1, 12, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:21:05', '2017-01-03 21:21:05', NULL),
	(18, 1, 13, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:27:20', '2017-02-06 09:51:04', '2017-02-06 09:51:04'),
	(19, 1, 14, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 2000, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:27:38', '2017-02-06 09:49:22', NULL),
	(20, 1, 15, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:39:30', '2017-02-06 09:48:58', '2017-02-06 09:48:58'),
	(21, 1, 16, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:47:33', '2017-02-06 09:51:00', '2017-02-06 09:51:00'),
	(22, 1, 17, 1, 4, 1, 1, 'COP', 7444, 300, 513, 7657, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'0', '2017-01-03 21:48:15', '2017-02-06 10:18:30', NULL),
	(23, 1, 18, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:49:24', '2017-02-06 09:50:52', '2017-02-06 09:50:52'),
	(24, 1, 19, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:53:19', '2017-02-06 08:53:12', '2017-02-06 08:53:12'),
	(25, 1, 20, 1, 1, 1, 4, 'COP', 90001.1, 8500.09, 0, 81501.1, '2017-01-07', '2017-01-25', 'notas cotizacion2', 'observaciones23', NULL, b'0', '2017-01-04 21:09:53', '2017-02-06 18:58:41', NULL),
	(26, 1, 21, 1, 1, 1, 1, 'COP', 64000, 300, 4500, 68200, '2017-01-08', '2017-01-14', 'estas notas deben salir en la cotización final.', NULL, NULL, b'0', '2017-01-07 10:12:05', '2017-02-06 20:45:41', NULL),
	(27, 1, 22, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 20000, '2017-01-11', '2017-01-18', 'noras cot', 'onserv', NULL, b'0', '2017-01-11 12:09:06', '2017-01-11 12:09:06', NULL),
	(28, 1, 23, 1, 2, 1, 4, 'COP', NULL, NULL, NULL, 2000, '2017-01-12', '2017-01-27', 'Notas creadas', 'observaciones', NULL, b'0', '2017-01-12 13:35:59', '2017-01-24 13:14:33', NULL),
	(29, 1, 24, 1, 4, 1, 18, 'USD', 8000, 0, 950, 8950, '2017-01-24', '2017-02-02', 'asas', 'observaciones', NULL, b'0', '2017-01-24 13:15:26', '2017-02-06 10:17:57', NULL),
	(30, 1, 25, 1, 2, 1, 1, 'COP', 5000, 500, 855, 5355, '2017-02-04', '2017-03-10', 'asas', NULL, NULL, b'0', '2017-02-04 13:01:42', '2017-02-06 10:15:04', NULL),
	(31, 1, 26, 1, 4, 2, 4, 'USD', 2000, 0, 0, 2000, '2017-02-07', '2017-03-02', 'notas de la cotización', NULL, NULL, b'0', '2017-02-07 20:50:32', '2017-02-07 20:50:32', NULL);
/*!40000 ALTER TABLE `estimate` ENABLE KEYS */;

-- Volcando estructura para tabla krece.estimate_detail
CREATE TABLE IF NOT EXISTS `estimate_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estimate_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float NOT NULL DEFAULT '0',
  `tax_type_id` int(11) DEFAULT NULL,
  `tax_amount` float NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `gross_total` float NOT NULL DEFAULT '0',
  `total` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_quote_detail_quote_id` (`estimate_id`),
  KEY `FK_quote_detail_company` (`user_id`),
  KEY `FK_quote_detail_item` (`product_id`),
  KEY `FK_quote_detail_tax` (`tax_type_id`),
  CONSTRAINT `FK_estimate_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_estimate_detail_remision_id` FOREIGN KEY (`estimate_id`) REFERENCES `estimate` (`id`),
  CONSTRAINT `FK_estimate_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_estimate_tax` FOREIGN KEY (`tax_type_id`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate_detail: ~22 rows (aproximadamente)
DELETE FROM `estimate_detail`;
/*!40000 ALTER TABLE `estimate_detail` DISABLE KEYS */;
INSERT INTO `estimate_detail` (`id`, `estimate_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_type_id`, `tax_amount`, `name`, `description`, `quantity`, `gross_total`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(4, 23, 1, 2, NULL, 2222, 0, NULL, 0, NULL, 'descripcion', 2, 0, 4444, '2017-01-03 21:49:24', '2017-01-03 21:49:24', NULL),
	(5, 24, 1, 2, NULL, 2222, 0, NULL, 0, NULL, 'descripcion', 2, 0, 4444, '2017-01-03 21:53:19', '2017-01-03 21:53:19', NULL),
	(6, 24, 1, 2, NULL, 30000, 0, NULL, 0, NULL, 'desc2', 1, 0, 30000, '2017-01-03 21:53:19', '2017-01-03 21:53:19', NULL),
	(44, 27, 1, 2, NULL, 20000, 0, NULL, 1, NULL, 'desc prod1', 1, 0, 20000, '2017-01-11 12:09:07', '2017-01-11 12:09:07', NULL),
	(69, 1, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-12 17:54:59', '2017-01-12 17:54:59', NULL),
	(70, 4, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-01-12 17:56:03', '2017-01-12 17:56:03', NULL),
	(72, 7, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-13 18:09:52', '2017-01-13 18:09:52', NULL),
	(76, 28, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-24 13:14:33', '2017-01-24 13:14:33', NULL),
	(81, 19, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-06 09:49:22', '2017-02-06 09:49:22', NULL),
	(86, 30, 1, 4, NULL, 5000, 10, NULL, 19, NULL, 'producto para pruebas', 1, 0, 5000, '2017-02-06 10:15:05', '2017-02-06 10:15:05', NULL),
	(87, 29, 1, 2, NULL, 2000, 0, NULL, 19, NULL, 'producto 1', 1, 0, 2000, '2017-02-06 10:17:58', '2017-02-06 10:17:58', NULL),
	(88, 29, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-06 10:17:58', '2017-02-06 10:17:58', NULL),
	(89, 29, 1, 3, NULL, 3000, 0, NULL, 19, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-06 10:17:58', '2017-02-06 10:17:58', NULL),
	(90, 22, 1, 2, NULL, 2222, 0, NULL, 0, NULL, NULL, 2, 0, 4444, '2017-02-06 10:18:30', '2017-02-06 10:18:30', NULL),
	(91, 22, 1, 3, NULL, 3000, 10, NULL, 19, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-06 10:18:30', '2017-02-06 10:18:30', NULL),
	(94, 25, 1, 2, NULL, 40000.3, 10, NULL, 0, NULL, 'product 2', 2, 0, 80000.7, '2017-02-06 18:58:41', '2017-02-06 18:58:41', NULL),
	(95, 25, 1, 2, NULL, 10000.5, 5, NULL, 0, NULL, 'p3', 1, 0, 10000.5, '2017-02-06 18:58:41', '2017-02-06 18:58:41', NULL),
	(96, 26, 1, 3, NULL, 3000, 5, NULL, 0, NULL, 'descripcion producto 2', 2, 0, 6000, '2017-02-06 20:45:41', '2017-02-06 20:45:41', NULL),
	(97, 26, 1, 2, NULL, 50000, 0, NULL, 9, NULL, 'd2', 1, 0, 50000, '2017-02-06 20:45:41', '2017-02-06 20:45:41', NULL),
	(98, 26, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-06 20:45:41', '2017-02-06 20:45:41', NULL),
	(99, 26, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-06 20:45:41', '2017-02-06 20:45:41', NULL),
	(100, 26, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-06 20:45:41', '2017-02-06 20:45:41', NULL),
	(101, 31, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-07 20:50:32', '2017-02-07 20:50:32', NULL);
/*!40000 ALTER TABLE `estimate_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_payments_invoices
CREATE TABLE IF NOT EXISTS `invoice_payments_invoices` (
  `id` int(11) NOT NULL,
  `number` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `total` float NOT NULL,
  `amount` float NOT NULL,
  KEY `FK_invoice_payment_invoices` (`id`),
  CONSTRAINT `FK_invoice_payment_invoices` FOREIGN KEY (`id`) REFERENCES `invoice_payments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='sales invoices payed';

-- Volcando datos para la tabla krece.invoice_payments_invoices: ~0 rows (aproximadamente)
DELETE FROM `invoice_payments_invoices`;
/*!40000 ALTER TABLE `invoice_payments_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_payments_invoices` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order
CREATE TABLE IF NOT EXISTS `invoice_sale_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `account_id` int(11) NOT NULL,
  `resolution_number` int(11) DEFAULT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_terms` varchar(20) NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `notes` text COMMENT 'vissible inf the sale invoice',
  `observations` text COMMENT 'for customer tracking , just internal',
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `total` float DEFAULT NULL,
  `total_payed` float DEFAULT NULL,
  `total_pending_byPayment` float DEFAULT NULL,
  `balance` float DEFAULT NULL,
  `currency_code_multicurrency` varchar(3) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `is_recurring` bit(1) NOT NULL DEFAULT b'0',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ISS_public_id_account_id` (`public_id`,`account_id`),
  KEY `FK_invoice_sale_currency` (`currency_code`),
  KEY `FK_invoice_sale_customerID` (`customer_id`),
  KEY `FK_invoice_sale_status` (`status_id`),
  KEY `FK_invoice_sale_list_price` (`list_price_id`),
  KEY `FK_invocie_sale_account` (`account_id`),
  KEY `FK_invoice_sale_seller` (`seller_id`),
  KEY `FK_invoice_sale_user` (`user_id`),
  KEY `FK_invoice_sale_category` (`category_id`),
  CONSTRAINT `FK_invocie_sale_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_invoice_sale_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_invoice_sale_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_invoice_sale_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_invoice_sale_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_invoice_sale_status` FOREIGN KEY (`status_id`) REFERENCES `invoice_sale_order_status` (`id`),
  CONSTRAINT `FK_invoice_sale_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Header of sale invoices';

-- Volcando datos para la tabla krece.invoice_sale_order: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order`;
/*!40000 ALTER TABLE `invoice_sale_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_credit_note
CREATE TABLE IF NOT EXISTS `invoice_sale_order_credit_note` (
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `credit_note_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_sale_order_id`,`credit_note_id`),
  KEY `FK_isocn_credit_note_id` (`credit_note_id`),
  CONSTRAINT `FK_isocn_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `FK_isocn_invoice_sale_order` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='join between the invoice sale order table and the quote one. Here are integrated the quote that belongs to the sale order table.';

-- Volcando datos para la tabla krece.invoice_sale_order_credit_note: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order_credit_note`;
/*!40000 ALTER TABLE `invoice_sale_order_credit_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order_credit_note` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_detail
CREATE TABLE IF NOT EXISTS `invoice_sale_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `notes` text,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `gross_total` float NOT NULL,
  `total` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_ISOI_invoice_sale_order` (`invoice_sale_order_id`),
  KEY `FK_ISOI_item` (`product_id`),
  KEY `FK_ISOI_company` (`user_id`),
  CONSTRAINT `FK_ISOI_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_ISOI_invoice_sale_order` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`),
  CONSTRAINT `FK_ISOI_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.invoice_sale_order_detail: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order_detail`;
/*!40000 ALTER TABLE `invoice_sale_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_estimate
CREATE TABLE IF NOT EXISTS `invoice_sale_order_estimate` (
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `FK_estimate_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_sale_order_id`,`FK_estimate_id`),
  KEY `FK_isoq_quote_id` (`FK_estimate_id`),
  CONSTRAINT `FK_isoq_estimate_id` FOREIGN KEY (`FK_estimate_id`) REFERENCES `estimate` (`id`),
  CONSTRAINT `FK_isoq_invoice_sale` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='join between the invoice sale order table and the quote one. Here are integrated the quote that belongs to the sale order table.';

-- Volcando datos para la tabla krece.invoice_sale_order_estimate: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order_estimate`;
/*!40000 ALTER TABLE `invoice_sale_order_estimate` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order_estimate` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_payment
CREATE TABLE IF NOT EXISTS `invoice_sale_order_payment` (
  `invoice_sale_order_id` bigint(20) DEFAULT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  KEY `FK_isop_payment` (`payment_id`),
  KEY `FK_isop_invoice_sale_order` (`invoice_sale_order_id`),
  CONSTRAINT `FK_isop_invoice_sale_order` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`),
  CONSTRAINT `FK_isop_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='set the relation between the payments and invoice sale order, and put the amount payed.';

-- Volcando datos para la tabla krece.invoice_sale_order_payment: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order_payment`;
/*!40000 ALTER TABLE `invoice_sale_order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order_payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_remision
CREATE TABLE IF NOT EXISTS `invoice_sale_order_remision` (
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `remision_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_sale_order_id`,`remision_id`),
  KEY `FK_isoi_remision_id` (`remision_id`),
  CONSTRAINT `FK_isoi_remision_id` FOREIGN KEY (`remision_id`) REFERENCES `remision` (`id`),
  CONSTRAINT `FK_osoi_invoice_sale` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='join between the invoice sale order table and the remision one. Here are integrated the remision that belongs to the sale order table.';

-- Volcando datos para la tabla krece.invoice_sale_order_remision: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order_remision`;
/*!40000 ALTER TABLE `invoice_sale_order_remision` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order_remision` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_status
CREATE TABLE IF NOT EXISTS `invoice_sale_order_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_sale_order_status: ~4 rows (aproximadamente)
DELETE FROM `invoice_sale_order_status`;
/*!40000 ALTER TABLE `invoice_sale_order_status` DISABLE KEYS */;
INSERT INTO `invoice_sale_order_status` (`id`, `description`) VALUES
	(1, 'Drafy'),
	(2, 'Sent'),
	(3, 'Approved'),
	(4, 'Paid');
/*!40000 ALTER TABLE `invoice_sale_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_tax
CREATE TABLE IF NOT EXISTS `invoice_sale_order_tax` (
  `id` bigint(20) NOT NULL,
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tax_type` varchar(50) DEFAULT NULL,
  `tax_rate` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ISOT_sale_order` (`invoice_sale_order_id`),
  KEY `FK_ISOT_tax` (`tax_id`),
  KEY `FK_ISOT_user` (`user_id`),
  CONSTRAINT `FK_ISOT_sale_order` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`),
  CONSTRAINT `FK_ISOT_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_sale_order_tax: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order_tax`;
/*!40000 ALTER TABLE `invoice_sale_order_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_supplier_debit_note
CREATE TABLE IF NOT EXISTS `invoice_supplier_debit_note` (
  `debit_note_id` bigint(20) NOT NULL,
  `invoice_supplier_order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`debit_note_id`,`invoice_supplier_order_id`),
  KEY `FK_isdn_invoice_supplier_order` (`invoice_supplier_order_id`),
  CONSTRAINT `FK_isdn_debit_note` FOREIGN KEY (`debit_note_id`) REFERENCES `debit_note` (`id`),
  CONSTRAINT `FK_isdn_invoice_supplier` FOREIGN KEY (`invoice_supplier_order_id`) REFERENCES `invoice_supplier_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='link between the debit note and the transaction table, a user can add a payment that is stored in transaction table.';

-- Volcando datos para la tabla krece.invoice_supplier_debit_note: ~0 rows (aproximadamente)
DELETE FROM `invoice_supplier_debit_note`;
/*!40000 ALTER TABLE `invoice_supplier_debit_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_supplier_debit_note` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_supplier_order
CREATE TABLE IF NOT EXISTS `invoice_supplier_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `user_id` int(11) NOT NULL,
  `document_number` int(11) NOT NULL COMMENT 'resolution DIAN #',
  `public_id` int(11) NOT NULL,
  `revision_number` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_terms` varchar(20) NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `notes` text COMMENT 'vissible inf the supplier invoice',
  `observations` text COMMENT 'for customer tracking , just internal',
  `category_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `total` float DEFAULT NULL,
  `total_payed` float DEFAULT NULL,
  `total_pending_byPayment` float DEFAULT NULL,
  `balance` float DEFAULT NULL,
  `currency_code_multicurrency` varchar(3) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `is_recurring` bit(1) NOT NULL DEFAULT b'0',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`document_number`),
  KEY `FK_invoice_supplier_currency` (`currency_code`),
  KEY `FK_invoice_supplier_customerID` (`customer_id`),
  KEY `FK_invoice_supplier_status` (`status_id`),
  KEY `FK_invoice_supplier_category` (`category_id`),
  KEY `FK_invoice_supplier_user` (`user_id`),
  CONSTRAINT `FK_invoice_supplier_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_invoice_supplier_company` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_invoice_supplier_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_invoice_supplier_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_invoice_supplier_status` FOREIGN KEY (`status_id`) REFERENCES `invoice_supplier_order_status` (`id`),
  CONSTRAINT `FK_invoice_supplier_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.invoice_supplier_order: ~0 rows (aproximadamente)
DELETE FROM `invoice_supplier_order`;
/*!40000 ALTER TABLE `invoice_supplier_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_supplier_order` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_supplier_order_detail
CREATE TABLE IF NOT EXISTS `invoice_supplier_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `invoice_supplier_order_id` bigint(20) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `gross_total` float NOT NULL,
  `total` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_supplier_order_company` (`user_id`),
  KEY `FK_supplier_order_category` (`category_id`),
  KEY `FK_supplier_order_invoice_supplier_order` (`invoice_supplier_order_id`),
  CONSTRAINT `FK_soi_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_supplier_order_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_supplier_order_invoice_supplier_order` FOREIGN KEY (`invoice_supplier_order_id`) REFERENCES `invoice_supplier_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.invoice_supplier_order_detail: ~0 rows (aproximadamente)
DELETE FROM `invoice_supplier_order_detail`;
/*!40000 ALTER TABLE `invoice_supplier_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_supplier_order_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_supplier_order_payment
CREATE TABLE IF NOT EXISTS `invoice_supplier_order_payment` (
  `invoice_supplier_order_id` bigint(20) DEFAULT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  KEY `FK_isopa_payment` (`payment_id`),
  KEY `FK_isopa_invoice_supplier_order` (`invoice_supplier_order_id`),
  CONSTRAINT `FK_isopa_invoice_supplier_order` FOREIGN KEY (`invoice_supplier_order_id`) REFERENCES `invoice_supplier_order` (`id`),
  CONSTRAINT `FK_isopa_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='set the relation between the payments and invoice supplier order, and put the amount payed.';

-- Volcando datos para la tabla krece.invoice_supplier_order_payment: ~0 rows (aproximadamente)
DELETE FROM `invoice_supplier_order_payment`;
/*!40000 ALTER TABLE `invoice_supplier_order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_supplier_order_payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_supplier_order_status
CREATE TABLE IF NOT EXISTS `invoice_supplier_order_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_supplier_order_status: ~0 rows (aproximadamente)
DELETE FROM `invoice_supplier_order_status`;
/*!40000 ALTER TABLE `invoice_supplier_order_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_supplier_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_supplier_order_tax
CREATE TABLE IF NOT EXISTS `invoice_supplier_order_tax` (
  `id` bigint(20) NOT NULL,
  `invoice_supplier_order_id` bigint(20) NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tax_type` varchar(50) DEFAULT NULL,
  `tax_rate` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_invoice_supplier_order_tax` (`tax_id`),
  KEY `FK_invoice_supplier_order_invoice` (`invoice_supplier_order_id`),
  KEY `FK_invocie_supplier_user` (`user_id`),
  CONSTRAINT `FK_invocie_supplier_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_invoice_supplier_ider_id` FOREIGN KEY (`invoice_supplier_order_id`) REFERENCES `invoice_supplier_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_supplier_order_tax: ~0 rows (aproximadamente)
DELETE FROM `invoice_supplier_order_tax`;
/*!40000 ALTER TABLE `invoice_supplier_order_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_supplier_order_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_supplier_purchase_order
CREATE TABLE IF NOT EXISTS `invoice_supplier_purchase_order` (
  `invoice_supplier_order_id` bigint(20) NOT NULL,
  `purchase_order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`purchase_order_id`,`invoice_supplier_order_id`),
  UNIQUE KEY `UK_SO_PO_link` (`invoice_supplier_order_id`,`purchase_order_id`),
  CONSTRAINT `FK_POSO_PO_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK_POSO_SO_id` FOREIGN KEY (`invoice_supplier_order_id`) REFERENCES `invoice_supplier_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='link between invoice supplier orders and PO orders, so user decides when a PO belongs to a Supp Order.';

-- Volcando datos para la tabla krece.invoice_supplier_purchase_order: ~0 rows (aproximadamente)
DELETE FROM `invoice_supplier_purchase_order`;
/*!40000 ALTER TABLE `invoice_supplier_purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_supplier_purchase_order` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_type
CREATE TABLE IF NOT EXISTS `invoice_type` (
  `id` tinyint(4) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='kind of invoice or invoice source: pucharse order, Sale order';

-- Volcando datos para la tabla krece.invoice_type: ~2 rows (aproximadamente)
DELETE FROM `invoice_type`;
/*!40000 ALTER TABLE `invoice_type` DISABLE KEYS */;
INSERT INTO `invoice_type` (`id`, `description`) VALUES
	(1, 'Factura de Venta'),
	(2, 'Factura de Compra');
/*!40000 ALTER TABLE `invoice_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_withholding_tax
CREATE TABLE IF NOT EXISTS `invoice_withholding_tax` (
  `withholding_tax_values_id` int(11) NOT NULL,
  `invoice_id` bigint(20) NOT NULL COMMENT 'contain sale e and supplier orders',
  `invoice_type_id` tinyint(4) NOT NULL,
  KEY `FK_iwt_tax_values` (`withholding_tax_values_id`),
  KEY `FK_iwt_invoice_type` (`invoice_type_id`),
  CONSTRAINT `FK_iwt_invoice_type` FOREIGN KEY (`invoice_type_id`) REFERENCES `invoice_type` (`id`),
  CONSTRAINT `FK_iwt_tax_values` FOREIGN KEY (`withholding_tax_values_id`) REFERENCES `invoice_withholding_tax_values` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='set the join between the with holding tax and the invoices tables (that could be ingresos and egresos)';

-- Volcando datos para la tabla krece.invoice_withholding_tax: ~0 rows (aproximadamente)
DELETE FROM `invoice_withholding_tax`;
/*!40000 ALTER TABLE `invoice_withholding_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_withholding_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_withholding_tax_values
CREATE TABLE IF NOT EXISTS `invoice_withholding_tax_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `withholding_tax_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_iwt_withholding_tax` (`withholding_tax_id`),
  KEY `FK_iwt_account` (`account_id`),
  KEY `FK_iwt_user` (`user_id`),
  CONSTRAINT `FK_iwt_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_iwt_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_iwt_withholding_tax` FOREIGN KEY (`withholding_tax_id`) REFERENCES `retention` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_withholding_tax_values: ~0 rows (aproximadamente)
DELETE FROM `invoice_withholding_tax_values`;
/*!40000 ALTER TABLE `invoice_withholding_tax_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_withholding_tax_values` ENABLE KEYS */;

-- Volcando estructura para tabla krece.list_price
CREATE TABLE IF NOT EXISTS `list_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `public_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `type_id` tinyint(4) NOT NULL DEFAULT '0',
  `value` float NOT NULL DEFAULT '0',
  `isDefault` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isEnabled` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_list_price_company_id_name` (`account_id`,`public_id`),
  KEY `FK_list_price_type` (`type_id`),
  KEY `FK_list_price_user` (`user_id`),
  CONSTRAINT `FK_list_price_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_list_price_type` FOREIGN KEY (`type_id`) REFERENCES `list_price_type` (`id`),
  CONSTRAINT `FK_list_price_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Store the list price information';

-- Volcando datos para la tabla krece.list_price: ~3 rows (aproximadamente)
DELETE FROM `list_price`;
/*!40000 ALTER TABLE `list_price` DISABLE KEYS */;
INSERT INTO `list_price` (`id`, `account_id`, `user_id`, `public_id`, `name`, `type_id`, `value`, `isDefault`, `created_at`, `updated_at`, `deleted_at`, `isEnabled`, `isDeleted`) VALUES
	(1, 1, 1, 1, 'General', 2, 0, b'1', '2017-01-05 13:24:27', '2017-01-19 13:01:51', NULL, b'1', b'0'),
	(2, 1, 1, 2, 'lista precios 1', 2, 0, b'0', '2017-01-19 12:27:29', '2017-01-26 21:06:56', '2017-01-19 13:49:28', b'0', b'0'),
	(3, 1, 1, 3, 'lista precios 2', 1, 16, b'0', '2017-01-19 12:31:54', '2017-01-19 14:01:42', NULL, b'0', b'0');
/*!40000 ALTER TABLE `list_price` ENABLE KEYS */;

-- Volcando estructura para tabla krece.list_price_type
CREATE TABLE IF NOT EXISTS `list_price_type` (
  `id` tinyint(4) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.list_price_type: ~2 rows (aproximadamente)
DELETE FROM `list_price_type`;
/*!40000 ALTER TABLE `list_price_type` DISABLE KEYS */;
INSERT INTO `list_price_type` (`id`, `type`) VALUES
	(1, 'Porcentaje'),
	(2, 'Valor');
/*!40000 ALTER TABLE `list_price_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `detail` varchar(500) DEFAULT NULL,
  `link` varchar(1000) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_log_company_id` (`company_id`),
  KEY `FK_log_user` (`user_id`),
  CONSTRAINT `FK_log_company_id` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `FK_log_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='database log of transactions made by users';

-- Volcando datos para la tabla krece.log: ~0 rows (aproximadamente)
DELETE FROM `log`;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;

-- Volcando estructura para tabla krece.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.migrations: ~0 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2017_01_31_210849_create_treeexamples_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla krece.modules
CREATE TABLE IF NOT EXISTS `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `functionality` varchar(100) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `FK_modules_parent` (`parent_id`),
  CONSTRAINT `FK_modules_parent` FOREIGN KEY (`parent_id`) REFERENCES `modules_parent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.modules: ~0 rows (aproximadamente)
DELETE FROM `modules`;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;

-- Volcando estructura para tabla krece.modules_parent
CREATE TABLE IF NOT EXISTS `modules_parent` (
  `id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.modules_parent: ~0 rows (aproximadamente)
DELETE FROM `modules_parent`;
/*!40000 ALTER TABLE `modules_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules_parent` ENABLE KEYS */;

-- Volcando estructura para tabla krece.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.password_resets: ~0 rows (aproximadamente)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
	('fernando2684@gmail.com', '27add76ba889d02183e67735a4108baa4f65fdd3455a10eefef7857906830501', '2016-12-08 03:13:17');
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `bank_id` int(11) NOT NULL,
  `amount` float DEFAULT NULL,
  `observations` text,
  `payment_method_id` tinyint(4) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `type_id` char(2) NOT NULL,
  `status_id` tinyint(4) NOT NULL,
  `anotations` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id_company_id_type_id` (`payment_id`,`account_id`,`type_id`),
  KEY `FK_payment_customer` (`customer_id`),
  KEY `FK_payment_type` (`type_id`),
  KEY `FK_payment_status` (`status_id`),
  KEY `FK_payment_payment_method_id` (`payment_method_id`),
  KEY `FK_payment_bank` (`bank_id`),
  KEY `FK_payment_account` (`account_id`),
  KEY `FK_payment_user` (`user_id`),
  CONSTRAINT `FK_payment_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_payment_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank_account` (`id`),
  CONSTRAINT `FK_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FK_payment_status` FOREIGN KEY (`status_id`) REFERENCES `payment_status` (`id`),
  CONSTRAINT `FK_payment_type` FOREIGN KEY (`type_id`) REFERENCES `payment_type` (`type`),
  CONSTRAINT `FK_payment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment: ~0 rows (aproximadamente)
DELETE FROM `payment`;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_method
CREATE TABLE IF NOT EXISTS `payment_method` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='paymeth method list';

-- Volcando datos para la tabla krece.payment_method: ~6 rows (aproximadamente)
DELETE FROM `payment_method`;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` (`id`, `name`, `isActive`) VALUES
	(1, 'Efectivo', b'1'),
	(2, 'Consignación', b'1'),
	(3, 'Transferencia', b'1'),
	(4, 'Cheque', b'1'),
	(5, 'Trajeta crédito', b'1'),
	(6, 'Tarjeta débito', b'1');
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_status
CREATE TABLE IF NOT EXISTS `payment_status` (
  `id` tinyint(4) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_status: ~4 rows (aproximadamente)
DELETE FROM `payment_status`;
/*!40000 ALTER TABLE `payment_status` DISABLE KEYS */;
INSERT INTO `payment_status` (`id`, `description`) VALUES
	(1, 'Pendiente'),
	(2, 'Completado'),
	(3, 'Devuelto'),
	(4, 'Anulado');
/*!40000 ALTER TABLE `payment_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_terms
CREATE TABLE IF NOT EXISTS `payment_terms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `days` int(11) NOT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_company_id_name_days` (`account_id`,`name`,`days`,`isDeleted`),
  KEY `FK_payment_terms_user` (`user_id`),
  CONSTRAINT `FK_payment_terms_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_payment_terms_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_terms: ~4 rows (aproximadamente)
DELETE FROM `payment_terms`;
/*!40000 ALTER TABLE `payment_terms` DISABLE KEYS */;
INSERT INTO `payment_terms` (`id`, `account_id`, `user_id`, `public_id`, `name`, `days`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'Vencimiento manual', 0, b'0', '2017-01-17 16:33:16', '2017-01-17 16:39:42', NULL),
	(2, 1, 1, 2, 'De Contado', 0, b'0', '2017-01-17 16:58:12', '2017-01-17 16:58:12', NULL),
	(3, 1, 1, 3, '8 días', 8, b'0', '2017-01-17 16:58:27', '2017-01-17 16:58:27', NULL),
	(4, 1, 1, 4, '15 días', 15, b'0', '2017-01-17 16:58:41', '2017-01-17 16:58:49', NULL);
/*!40000 ALTER TABLE `payment_terms` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_type
CREATE TABLE IF NOT EXISTS `payment_type` (
  `type` char(2) NOT NULL,
  `description` char(20) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='determines if the payment is D or C';

-- Volcando datos para la tabla krece.payment_type: ~2 rows (aproximadamente)
DELETE FROM `payment_type`;
/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` (`type`, `description`) VALUES
	('eg', 'Credito'),
	('in', 'Debito');
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_withholding_tax
CREATE TABLE IF NOT EXISTS `payment_withholding_tax` (
  `withholding_tax_values_id` int(11) NOT NULL,
  `payment_id` bigint(20) NOT NULL,
  PRIMARY KEY (`withholding_tax_values_id`,`payment_id`),
  KEY `FK_wht_tax_values_payment` (`payment_id`),
  CONSTRAINT `FK_wht_tax_values_id` FOREIGN KEY (`withholding_tax_values_id`) REFERENCES `invoice_withholding_tax_values` (`id`),
  CONSTRAINT `FK_wht_tax_values_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_withholding_tax: ~0 rows (aproximadamente)
DELETE FROM `payment_withholding_tax`;
/*!40000 ALTER TABLE `payment_withholding_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_withholding_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` int(11) NOT NULL COMMENT 'id of item by company',
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `sale_price` float NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `inv_quantity_initial` int(11) DEFAULT NULL,
  `inv_quantity_actual` int(11) DEFAULT NULL,
  `inv_type_id` int(11) DEFAULT NULL,
  `inv_unit_cost` float DEFAULT NULL,
  `inv_inStock` bit(1) DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_products_public_id_account_id` (`public_id`,`account_id`),
  KEY `FK_products_tax` (`tax_id`),
  KEY `id_auto` (`id`),
  KEY `FK_products_account` (`account_id`),
  KEY `FK_products_user` (`user_id`),
  KEY `FK_products_category` (`category_id`),
  KEY `FK_products_inv_type` (`inv_type_id`),
  KEY `FK_products_listprice` (`list_price_id`),
  CONSTRAINT `FK_products_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_products_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_products_inv_type` FOREIGN KEY (`inv_type_id`) REFERENCES `product_inventory_type` (`id`),
  CONSTRAINT `FK_products_listprice` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_products_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_products_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.product: ~3 rows (aproximadamente)
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `public_id`, `user_id`, `account_id`, `name`, `description`, `reference`, `sale_price`, `tax_id`, `list_price_id`, `category_id`, `inv_quantity_initial`, `inv_quantity_actual`, `inv_type_id`, `inv_unit_cost`, `inv_inStock`, `isDeleted`, `isActive`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(2, 1, 1, 1, 'producto 1', 'producto 1', 'ref', 2000, 5, NULL, 34, 50, NULL, 1, 1500, b'1', b'0', b'1', '2017-02-01 16:22:28', '2017-02-01 16:22:28', '0000-00-00 00:00:00'),
	(3, 2, 1, 1, 'producto 2', 'descripcion producto 2', 'ref2', 3000, 4, NULL, 30, 50, NULL, 2, 2500, b'0', b'0', b'1', '2017-02-02 21:04:43', '2017-02-02 21:04:43', '0000-00-00 00:00:00'),
	(4, 3, 1, 1, 'productoprueba', 'producto para pruebas', '1234', 5000, 3, NULL, 30, NULL, NULL, NULL, 0, b'0', b'0', b'0', '2017-02-01 15:55:07', '2017-02-01 15:55:07', '2017-01-31 15:25:02');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- Volcando estructura para tabla krece.product_inventory_type
CREATE TABLE IF NOT EXISTS `product_inventory_type` (
  `id` int(11) NOT NULL,
  `measure_unit` varchar(50) NOT NULL,
  `measure_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='just applies for products that are cataloged as inventory, like products.\r\nServices commonly does not have inventory.';

-- Volcando datos para la tabla krece.product_inventory_type: ~16 rows (aproximadamente)
DELETE FROM `product_inventory_type`;
/*!40000 ALTER TABLE `product_inventory_type` DISABLE KEYS */;
INSERT INTO `product_inventory_type` (`id`, `measure_unit`, `measure_type`) VALUES
	(1, 'Unidad', 'Unidad'),
	(2, 'Servicio', 'Unidad'),
	(3, 'Pieza', 'Unidad'),
	(4, 'Centimetro (cm)', 'Longitud'),
	(5, 'Metro (m)', 'Longitud'),
	(6, 'Pulgada', 'Longitud'),
	(7, 'Centímetro cuadrado (cm2)', 'Área'),
	(8, 'Metro cuadrado (m2)', 'Área'),
	(9, 'Pulgada cuadrada', 'Área'),
	(10, 'Mililitro (mL)', 'Volumen'),
	(11, 'Litro (L)', 'Volumen'),
	(12, 'Galón', 'Volumen'),
	(13, 'Gramo (g)', 'Peso'),
	(14, 'Kilogramo (kg)', 'Peso'),
	(15, 'Tonelada', 'Peso'),
	(16, 'Libra', 'Peso');
/*!40000 ALTER TABLE `product_inventory_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.purchase_order
CREATE TABLE IF NOT EXISTS `purchase_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `document_number` int(11) NOT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `notes` text COMMENT 'vissible inf the supplier invoice',
  `observations` text COMMENT 'for customer tracking , just internal',
  `exchange_rate` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`document_number`),
  KEY `FK_purchase_order_currency` (`currency_code`),
  KEY `FK_purchase_order_customerID` (`customer_id`),
  KEY `FK_purchase_order_status` (`status_id`),
  KEY `FK_PO_user` (`user_id`),
  CONSTRAINT `FK_PO_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_purchase_order_caccount` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_purchase_order_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_purchase_order_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_purchase_order_status` FOREIGN KEY (`status_id`) REFERENCES `purchase_order_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.purchase_order: ~0 rows (aproximadamente)
DELETE FROM `purchase_order`;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;

-- Volcando estructura para tabla krece.purchase_order_detail
CREATE TABLE IF NOT EXISTS `purchase_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `purchase_order_id` bigint(20) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `taxt_type_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `gross_total` float NOT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_purchase_order_detail_company` (`user_id`),
  KEY `FK_purchase_order_purchase_order_detail` (`purchase_order_id`),
  KEY `FK_purchase_order_detail_tax_id` (`taxt_type_id`),
  CONSTRAINT `FK_purchase_order_detail_po` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK_purchase_order_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.purchase_order_detail: ~0 rows (aproximadamente)
DELETE FROM `purchase_order_detail`;
/*!40000 ALTER TABLE `purchase_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.purchase_order_status
CREATE TABLE IF NOT EXISTS `purchase_order_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.purchase_order_status: ~0 rows (aproximadamente)
DELETE FROM `purchase_order_status`;
/*!40000 ALTER TABLE `purchase_order_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision
CREATE TABLE IF NOT EXISTS `remision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `document_type_id` int(11) DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `due_date` int(11) DEFAULT NULL,
  `notes` int(11) DEFAULT NULL,
  `observations` int(11) DEFAULT NULL,
  `exchange_rate` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_remision_account_id_public_id` (`account_id`,`public_id`),
  KEY `FK_remision_seller` (`seller_id`),
  KEY `FK_remision_list_price` (`list_price_id`),
  KEY `FK_remision_customer` (`customer_id`),
  KEY `FK_remision_document_type` (`document_type_id`),
  KEY `FK_remision_currency` (`currency_code`),
  KEY `FK_remision_status` (`status_id`),
  KEY `FK_remision_user` (`user_id`),
  CONSTRAINT `FK_remision_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_remision_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_remision_customer` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_remision_document_type` FOREIGN KEY (`document_type_id`) REFERENCES `remision_document_type` (`id`),
  CONSTRAINT `FK_remision_list_price` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_remision_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_remision_status` FOREIGN KEY (`status_id`) REFERENCES `remision_status` (`id`),
  CONSTRAINT `FK_remision_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision: ~0 rows (aproximadamente)
DELETE FROM `remision`;
/*!40000 ALTER TABLE `remision` DISABLE KEYS */;
/*!40000 ALTER TABLE `remision` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision_detail
CREATE TABLE IF NOT EXISTS `remision_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remision_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_type_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `gross_total` float DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_remision_detail_remision_id` (`remision_id`),
  KEY `FK_remision_detail_item` (`product_id`),
  KEY `FK_remision_detail_tax` (`tax_type_id`),
  KEY `FK_remision_detail_user` (`user_id`),
  CONSTRAINT `FK_remision_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_remision_detail_remision_id` FOREIGN KEY (`remision_id`) REFERENCES `remision` (`id`),
  CONSTRAINT `FK_remision_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_detail: ~0 rows (aproximadamente)
DELETE FROM `remision_detail`;
/*!40000 ALTER TABLE `remision_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `remision_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision_document_type
CREATE TABLE IF NOT EXISTS `remision_document_type` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_document_type: ~0 rows (aproximadamente)
DELETE FROM `remision_document_type`;
/*!40000 ALTER TABLE `remision_document_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `remision_document_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision_status
CREATE TABLE IF NOT EXISTS `remision_status` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_status: ~0 rows (aproximadamente)
DELETE FROM `remision_status`;
/*!40000 ALTER TABLE `remision_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `remision_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.resolution
CREATE TABLE IF NOT EXISTS `resolution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `next_invoice_number` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `invoice_text` varchar(500) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `isDefault` bit(1) NOT NULL,
  `auto_increment` bit(1) NOT NULL DEFAULT b'1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_resolution_status` (`status_id`),
  KEY `FK_resolution_account` (`account_id`),
  KEY `FK_resolution_user` (`user_id`),
  CONSTRAINT `FK_resolution_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_resolution_status` FOREIGN KEY (`status_id`) REFERENCES `resolution_status` (`id`),
  CONSTRAINT `FK_resolution_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains resolution IDs for each sale order, according law policies (DIAN in colombia)';

-- Volcando datos para la tabla krece.resolution: ~0 rows (aproximadamente)
DELETE FROM `resolution`;
/*!40000 ALTER TABLE `resolution` DISABLE KEYS */;
/*!40000 ALTER TABLE `resolution` ENABLE KEYS */;

-- Volcando estructura para tabla krece.resolution_status
CREATE TABLE IF NOT EXISTS `resolution_status` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.resolution_status: ~0 rows (aproximadamente)
DELETE FROM `resolution_status`;
/*!40000 ALTER TABLE `resolution_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `resolution_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.retention
CREATE TABLE IF NOT EXISTS `retention` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` float NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `type_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_wht_type` (`type_id`),
  KEY `FK_wht_company` (`account_id`),
  KEY `FK_wht_user` (`user_id`),
  CONSTRAINT `FK_wht_company` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_wht_type` FOREIGN KEY (`type_id`) REFERENCES `retention_type` (`id`),
  CONSTRAINT `FK_wht_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.retention: ~3 rows (aproximadamente)
DELETE FROM `retention`;
/*!40000 ALTER TABLE `retention` DISABLE KEYS */;
INSERT INTO `retention` (`id`, `account_id`, `user_id`, `name`, `value`, `description`, `isDeleted`, `type_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 'Retencion', 3.5, 'prueba', b'1', 2, '2017-01-17 14:34:56', '2017-01-17 14:37:14', '2017-01-17 14:37:14'),
	(2, 1, 1, 'Compras', 2.5, 'Retención aplicada a compras declarantes', b'0', 2, '2017-01-17 14:39:16', '2017-01-17 14:41:13', NULL),
	(3, 1, 1, 'Arrendamiento de bienes raices', 3.5, 'Retención aplicada a arrendamiento de bienes raices', b'0', 2, '2017-01-17 14:40:07', '2017-01-17 14:40:07', NULL);
/*!40000 ALTER TABLE `retention` ENABLE KEYS */;

-- Volcando estructura para tabla krece.retention_type
CREATE TABLE IF NOT EXISTS `retention_type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this contains the list of with holding tax used by the app';

-- Volcando datos para la tabla krece.retention_type: ~5 rows (aproximadamente)
DELETE FROM `retention_type`;
/*!40000 ALTER TABLE `retention_type` DISABLE KEYS */;
INSERT INTO `retention_type` (`id`, `name`) VALUES
	(1, 'Retención de IVA'),
	(2, 'Retención en la fuente'),
	(3, 'Retención de Industria y Comercio'),
	(4, 'Retención de CREE'),
	(5, 'Otro tipo de retención');
/*!40000 ALTER TABLE `retention_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.seller
CREATE TABLE IF NOT EXISTS `seller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `dni` varchar(50) DEFAULT NULL,
  `work_phone` varchar(255) DEFAULT NULL,
  `private_phone` varchar(255) DEFAULT NULL,
  `observations` text,
  `isEnabled` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_id_local_id` (`account_id`,`public_id`),
  KEY `FK_seller_user` (`user_id`),
  CONSTRAINT `FK_seller_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_seller_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='seller list customized by company';

-- Volcando datos para la tabla krece.seller: ~4 rows (aproximadamente)
DELETE FROM `seller`;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` (`id`, `account_id`, `user_id`, `public_id`, `name`, `dni`, `work_phone`, `private_phone`, `observations`, `isEnabled`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'Fernando ardila', '12345996', '123456', '123456', 'observaciones', b'1', b'1', '2017-01-19 15:33:25', '2017-01-19 15:48:06', '2017-01-19 15:48:06'),
	(2, 1, 1, 2, 'Fernando Ardila', '18234994', '1234565', '12345', 'prueba', b'0', b'0', '2017-01-19 15:47:34', '2017-02-04 14:15:39', NULL),
	(3, 1, 1, 3, 'vendedor 2', '', '', '', '', b'0', b'0', '2017-01-19 15:50:56', '2017-01-19 15:52:59', NULL),
	(4, 1, 1, 4, 'vendedor 3', '', '', '124334', '', b'1', b'0', '2017-01-19 15:51:04', '2017-01-19 15:53:53', NULL);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;

-- Volcando estructura para tabla krece.supplier_order_status
CREATE TABLE IF NOT EXISTS `supplier_order_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.supplier_order_status: ~0 rows (aproximadamente)
DELETE FROM `supplier_order_status`;
/*!40000 ALTER TABLE `supplier_order_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.tax
CREATE TABLE IF NOT EXISTS `tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `amount` float NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `isEditable` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_taxes_account_id_public_id` (`account_id`,`public_id`),
  KEY `FK_taxes_user` (`user_id`),
  KEY `FK_taxes_type` (`type_id`),
  CONSTRAINT `FK_taxes_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_taxes_type` FOREIGN KEY (`type_id`) REFERENCES `tax_type` (`id`),
  CONSTRAINT `FK_taxes_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.tax: ~7 rows (aproximadamente)
DELETE FROM `tax`;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
INSERT INTO `tax` (`id`, `account_id`, `public_id`, `user_id`, `name`, `amount`, `description`, `type_id`, `isEditable`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'IVA', 19, 'Nuevo IVA', 1, b'1', b'1', '2017-01-16 09:26:09', '2017-01-19 15:45:00', '2017-01-19 15:45:00'),
	(2, 1, 2, 1, 'te', 20, 'test', 1, b'1', b'1', '2017-01-16 16:27:32', '2017-01-17 12:44:16', '2017-01-17 12:44:16'),
	(3, 1, 3, 1, 'IVA', 19, 'test', 1, b'1', b'0', '2017-01-16 16:31:26', '2017-01-17 12:45:51', '2017-01-17 10:36:27'),
	(4, 1, 4, 1, 'ICO', 19, 'test', 2, b'1', b'0', '2017-01-16 16:32:31', '2017-01-17 12:45:33', '2017-01-17 12:37:34'),
	(5, 1, 5, 1, 'Ninguno', 0, 'prueba', 1, b'1', b'0', '2017-01-16 16:34:48', '2017-01-17 12:46:17', NULL),
	(6, 1, 6, 1, 'IVA2', 19, 'prueba', 1, b'1', b'1', '2017-01-17 10:44:59', '2017-01-17 12:44:08', '2017-01-17 12:44:08'),
	(7, 1, 7, 1, 'IVA3', 19, 'prueba', 1, b'1', b'1', '2017-01-17 10:45:53', '2017-01-17 12:44:02', '2017-01-17 12:44:02');
/*!40000 ALTER TABLE `tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.tax_type
CREATE TABLE IF NOT EXISTS `tax_type` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this contains the kind of taxes used inside the app';

-- Volcando datos para la tabla krece.tax_type: ~3 rows (aproximadamente)
DELETE FROM `tax_type`;
/*!40000 ALTER TABLE `tax_type` DISABLE KEYS */;
INSERT INTO `tax_type` (`id`, `name`) VALUES
	(1, 'IVA'),
	(2, 'ICO'),
	(3, 'Otro');
/*!40000 ALTER TABLE `tax_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.transaction
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_transaction_type` (`type_id`),
  KEY `FK_transaction_bank` (`bank_id`),
  KEY `FK_transaction_account` (`account_id`),
  KEY `FK_transaction_user` (`user_id`),
  CONSTRAINT `FK_transaction_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_transaction_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank_account` (`id`),
  CONSTRAINT `FK_transaction_type` FOREIGN KEY (`type_id`) REFERENCES `transaction_type` (`id`),
  CONSTRAINT `FK_transaction_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='when creating a credit note or debit note, there is an escenario where the user can add a money devolution-';

-- Volcando datos para la tabla krece.transaction: ~0 rows (aproximadamente)
DELETE FROM `transaction`;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;

-- Volcando estructura para tabla krece.transaction_type
CREATE TABLE IF NOT EXISTS `transaction_type` (
  `id` int(11) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='determines if the transaction is debit or credit';

-- Volcando datos para la tabla krece.transaction_type: ~2 rows (aproximadamente)
DELETE FROM `transaction_type`;
/*!40000 ALTER TABLE `transaction_type` DISABLE KEYS */;
INSERT INTO `transaction_type` (`id`, `type`) VALUES
	(1, 'Debito'),
	(2, 'Credito');
/*!40000 ALTER TABLE `transaction_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT '1',
  `name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `transaction_token` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `avatar` blob COMMENT 'user image',
  `status_id` int(11) DEFAULT '1' COMMENT 'state of the user: active, inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `public_id` int(11) unsigned DEFAULT NULL,
  `oauth_user_id` varchar(255) DEFAULT NULL,
  `oauth_provider_id` int(11) unsigned DEFAULT NULL,
  `is_admin` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `FK_user_status` (`status_id`),
  KEY `FK_user_role` (`role_id`),
  KEY `FK_user_accountid` (`account_id`),
  CONSTRAINT `FK_user_accountid` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_user_role` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`),
  CONSTRAINT `FK_user_status` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user: ~5 rows (aproximadamente)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `account_id`, `role_id`, `name`, `last_name`, `email`, `password`, `remember_token`, `transaction_token`, `phone`, `avatar`, `status_id`, `created_at`, `deleted_at`, `updated_at`, `last_login`, `modified_by`, `created_by`, `public_id`, `oauth_user_id`, `oauth_provider_id`, `is_admin`) VALUES
	(1, 1, 1, 'Fernando', 'Ardila Rodriguez', 'fernando2684@gmail.com', '$2y$10$gC551oWqmWxtaA8mphnAVOC2u3SF.rPX65x/4qYn.0nUihR8QjSWS', 'GDJjquFewnCUdr105VetJWeUSKjI9O0q5N7Tzre1gKVJmHia7ru3TyGedCdY', NULL, NULL, NULL, 1, '2016-12-07 16:17:25', NULL, '2017-01-24 09:42:03', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(2, 2, 1, 'Fernando 2', 'Ardila', 'fernando26842@gmail.com', '$2y$10$a55MnRDXKsxTU5UmNWKh/ua7FY1kSsvAI.PaZNXcWC3Axulhr.aD2', 'FcregiMVfdO3B65QJkXKuELvAVo9VO41bZVsKq27s22fDwJDqK79DWs92VmN', NULL, NULL, NULL, 1, '2016-12-07 17:19:15', NULL, '2017-01-24 16:45:47', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(3, 3, 1, NULL, NULL, 'fernandwo2684@gmail.com', '$2y$10$u6v0vfdvla3xCyD7HJLkVeFS/Q6Ozhf.I1AIv9nnUCqDuPDCUe1XW', 'j7WUKqHUUhp5uBiAZKAg9fWmTvKYEgEq9kk9PGGiwf1ax3DE2H5oSjoau79P', NULL, NULL, NULL, 1, '2016-12-07 17:22:30', NULL, '2016-12-07 17:22:35', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(4, 4, 1, NULL, NULL, 'fernando268422@gmail.com', '$2y$10$n..GzUA79THtAPd2Y/J8N.7nZiFzeHcdCEIH3emPIM98k4Yp9/z7u', 'O67MhIiFYyJkgNi3AkvJsI1UL7fJf8cYE4depxK7Kmk3WvI50zYWoh2u0aRJ', NULL, NULL, NULL, 1, '2016-12-07 17:23:24', NULL, '2016-12-07 17:24:15', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(5, 5, 1, NULL, NULL, 'fernando2684fff@gmail.com', '$2y$10$pzPLJy8dj/OZm0PZig7RU.MQapUDHC0QAeeoS01n5W8jedsr9jaw6', 'vJlDKaPMlujHx33vjYwAE4b6pMzOkpf75DRllIZX0dkUsCMEsgJ7Lq6DqEEp', NULL, NULL, NULL, 1, '2016-12-07 22:43:02', NULL, '2017-01-17 17:56:29', NULL, NULL, NULL, 1, NULL, NULL, b'1');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_password_resets
CREATE TABLE IF NOT EXISTS `user_password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.user_password_resets: ~0 rows (aproximadamente)
DELETE FROM `user_password_resets`;
/*!40000 ALTER TABLE `user_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_rights
CREATE TABLE IF NOT EXISTS `user_rights` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_user_rights_module_id` (`user_id`,`module_id`),
  KEY `FK_user_rights_module` (`module_id`),
  CONSTRAINT `FK_user_rights_module` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`),
  CONSTRAINT `FK_user_rights_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='list of modules that an user has access';

-- Volcando datos para la tabla krece.user_rights: ~0 rows (aproximadamente)
DELETE FROM `user_rights`;
/*!40000 ALTER TABLE `user_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_rights` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_role
CREATE TABLE IF NOT EXISTS `user_role` (
  `id` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user_role: ~2 rows (aproximadamente)
DELETE FROM `user_role`;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`id`, `description`) VALUES
	(1, 'Administrator'),
	(2, 'Restricted');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;

-- Volcando estructura para tabla krece.user_status
CREATE TABLE IF NOT EXISTS `user_status` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user_status: ~3 rows (aproximadamente)
DELETE FROM `user_status`;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` (`id`, `description`) VALUES
	(1, 'Active'),
	(2, 'Inactive'),
	(3, 'Deleted');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
