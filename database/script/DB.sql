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
	(1, '2016-12-07 16:17:25', '2016-12-07 16:17:25', NULL, NULL, 'FERNANDO ARDILA', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'fernando2684@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, NULL, 63, 7),
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
  `niif_account` int(11) DEFAULT NULL,
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

-- Volcando datos para la tabla krece.category: ~82 rows (aproximadamente)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `account_id`, `user_id`, `parent_id`, `lft`, `rgt`, `name`, `niif_account`, `description`, `isEditable`, `isDeleted`, `type_id`, `updated_at`, `created_at`) VALUES
	(28, 1, 1, NULL, 1, 14, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'1', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(29, 1, 1, 28, 2, 3, 'Devoluciones de ventas', NULL, NULL, b'1', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(30, 1, 1, 28, 4, 5, 'Ingreso sin identificar', NULL, NULL, b'1', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(31, 1, 1, 28, 6, 11, 'Ingresos no operacionales', NULL, NULL, b'1', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(32, 1, 1, 31, 7, 10, 'Otros Ingresos', NULL, NULL, b'1', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(33, 1, 1, 32, 8, 9, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'1', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(34, 1, 1, 28, 12, 13, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'1', b'0', 1, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(35, 1, 1, NULL, 15, 50, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'1', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(36, 1, 1, 35, 16, 23, 'Activo corriente', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(37, 1, 1, 36, 17, 18, 'Bancos', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(38, 1, 1, 36, 19, 20, 'Cuentas por cobrar', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(39, 1, 1, 36, 21, 22, 'Inventario', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(40, 1, 1, 35, 24, 25, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'1', b'0', 3, '2017-02-01 11:01:11', '2017-02-01 11:01:11'),
	(41, 1, 1, 35, 26, 27, 'Avances y anticipos entregados', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(42, 1, 1, 35, 28, 29, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(43, 1, 1, 35, 30, 35, 'Impuestos a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(44, 1, 1, 43, 31, 32, 'ICO a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(45, 1, 1, 43, 33, 34, 'IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(46, 1, 1, 35, 36, 37, 'Inversiones', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(47, 1, 1, 35, 38, 39, 'Préstamos a terceros', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(48, 1, 1, 35, 40, 49, 'Retenciones a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(49, 1, 1, 48, 41, 42, 'Retención de CREE a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(50, 1, 1, 48, 43, 44, 'Retención de Industria y comercio a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(51, 1, 1, 48, 45, 46, 'Retención de IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(52, 1, 1, 48, 47, 48, 'Retención en la fuente a favor', NULL, NULL, b'1', b'0', 3, '2017-02-01 11:01:12', '2017-02-01 11:01:12'),
	(53, 1, 1, NULL, 51, 124, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(54, 1, 1, 53, 52, 53, 'Alquiler de equipos y licencias', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(55, 1, 1, 53, 54, 55, 'Comisiones y honorarios', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(56, 1, 1, 53, 56, 67, 'Costo de la mercancía vendida', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(57, 1, 1, 56, 57, 58, 'Ajustes del inventario', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(58, 1, 1, 56, 59, 60, 'Compras inventariables', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(59, 1, 1, 56, 61, 62, 'Fletes y envíos', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(60, 1, 1, 56, 63, 64, 'Mano de obra', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(61, 1, 1, 56, 65, 66, 'Materias primas', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(62, 1, 1, 53, 68, 69, 'Costo servicios vendidos', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(63, 1, 1, 53, 70, 71, 'Cuentas incobrables', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(64, 1, 1, 53, 72, 73, 'Devoluciones en compras de ítem', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(65, 1, 1, 53, 74, 79, 'Egresos no operacionales', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(66, 1, 1, 65, 75, 76, 'Descuento financiero', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:13', '2017-02-01 11:01:13'),
	(67, 1, 1, 65, 77, 78, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(68, 1, 1, 53, 80, 91, 'Gastos administrativos', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(69, 1, 1, 68, 81, 82, 'Arrendamiento', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(70, 1, 1, 68, 83, 84, 'Aseo y cafetería', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(71, 1, 1, 68, 85, 86, 'Internet y telecomunicaciones', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(72, 1, 1, 68, 87, 88, 'Papelería', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(73, 1, 1, 68, 89, 90, 'Servicios públicos', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(74, 1, 1, 53, 92, 93, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(75, 1, 1, 53, 94, 95, 'Legales', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(76, 1, 1, 53, 96, 97, 'Mantenimiento e instalaciones', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(77, 1, 1, 53, 98, 107, 'Nómina', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(78, 1, 1, 77, 99, 100, 'Dotación', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(79, 1, 1, 77, 101, 102, 'Prestaciones sociales', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:14', '2017-02-01 11:01:14'),
	(80, 1, 1, 77, 103, 104, 'Salarios', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(81, 1, 1, 77, 105, 106, 'Seguridad social y parafiscales', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(82, 1, 1, 53, 108, 109, 'Otros impuestos', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(83, 1, 1, 53, 110, 111, 'Publicidad', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(84, 1, 1, 53, 112, 113, 'Seguros y seguridad', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(85, 1, 1, 53, 114, 115, 'Servicios bancarios', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(86, 1, 1, 53, 116, 117, 'Subscripciones y afiliaciones', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(87, 1, 1, 53, 118, 119, 'Transporte y mensajería', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(88, 1, 1, 53, 120, 121, 'Varios', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(89, 1, 1, 53, 122, 123, 'Viajes y viáticos', NULL, NULL, b'1', b'0', 2, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(90, 1, 1, NULL, 125, 152, 'Pasivos', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(91, 1, 1, 90, 126, 127, 'Avances y anticipos recibidos', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(92, 1, 1, 90, 128, 129, 'Cuentas por pagar - devoluciones', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(93, 1, 1, 90, 130, 131, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'1', b'0', 4, '2017-02-01 11:01:15', '2017-02-01 11:01:15'),
	(94, 1, 1, 90, 132, 133, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(95, 1, 1, 90, 134, 139, 'Impuestos por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(96, 1, 1, 95, 135, 136, 'ICO por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(97, 1, 1, 95, 137, 138, 'IVA por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(98, 1, 1, 90, 140, 141, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(99, 1, 1, 90, 142, 151, 'Retenciones por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(100, 1, 1, 99, 143, 144, 'Retención de CREE por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(101, 1, 1, 99, 145, 146, 'Retención de industria y Comercio por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(102, 1, 1, 99, 147, 148, 'Retención de IVA por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(103, 1, 1, 99, 149, 150, 'Retención en la fuente por pagar', NULL, NULL, b'1', b'0', 4, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(104, 1, 1, NULL, 153, 162, 'Patrimonio', NULL, NULL, b'1', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(105, 1, 1, 104, 154, 155, 'Ajustes iniciales - Bancos', NULL, NULL, b'1', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(106, 1, 1, 104, 156, 157, 'Ajustes iniciales - Inventario', NULL, NULL, b'1', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(107, 1, 1, 104, 158, 159, 'Capital accionistas', NULL, NULL, b'1', b'0', 5, '2017-02-01 11:01:16', '2017-02-01 11:01:16'),
	(108, 1, 1, 104, 160, 161, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'1', b'0', 5, '2017-02-01 11:01:17', '2017-02-01 11:01:17'),
	(109, 1, 1, NULL, 163, 164, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'1', b'0', 6, '2017-02-01 11:01:17', '2017-02-01 11:01:17');
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
  `regime` int(11) DEFAULT NULL COMMENT 'related with the "regimen" of a company: comun, simplificado.etc',
  `logo` blob COMMENT 'company''s logo',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_company_email` (`email`),
  KEY `idx_company` (`regime`),
  CONSTRAINT `fk_company_regime` FOREIGN KEY (`regime`) REFERENCES `company_regime` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.company: ~0 rows (aproximadamente)
DELETE FROM `company`;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
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
	(1, 1, 1, 1, 'cliente 1', '1234506', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'1', b'0', '2016-12-13 15:01:44', '2016-12-13 15:01:45', NULL),
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
  `total` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `notes` text,
  `observations` text,
  `exchange_rate` float DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate: ~25 rows (aproximadamente)
DELETE FROM `estimate`;
/*!40000 ALTER TABLE `estimate` DISABLE KEYS */;
INSERT INTO `estimate` (`id`, `account_id`, `public_id`, `user_id`, `seller_id`, `list_price_id`, `customer_id`, `currency_code`, `total`, `date`, `due_date`, `notes`, `observations`, `exchange_rate`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, NULL, 1, 1, 'COP', 2000, '2016-12-13', '2016-12-13', 'notas act', 'observaciones', 1, '2016-12-13 14:51:38', '2017-01-12 17:54:59', '0000-00-00 00:00:00'),
	(2, 2, 1, 2, NULL, NULL, 1, 'COP', 123, '2016-12-13', '2016-12-13', 'notes', 'observ', 1, '2016-12-13 18:07:49', '2016-12-13 18:07:50', NULL),
	(4, 1, 2, 1, 1, 1, 1, 'COP', 3000, '2017-01-12', '2017-01-12', 'notas', NULL, NULL, '2017-01-03 19:52:07', '2017-01-12 17:56:03', NULL),
	(7, 1, 3, 1, NULL, 1, 1, 'COP', 2000, '2017-01-13', '2017-01-13', 'nota', NULL, NULL, '2017-01-03 20:30:07', '2017-01-13 18:09:52', NULL),
	(9, 1, 4, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:14:12', '2017-01-03 21:14:12', NULL),
	(10, 1, 5, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:15:14', '2017-01-03 21:15:14', NULL),
	(11, 1, 6, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:16:45', '2017-01-03 21:16:45', NULL),
	(12, 1, 7, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:17:51', '2017-01-03 21:17:51', NULL),
	(13, 1, 8, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:18:05', '2017-01-03 21:18:05', NULL),
	(14, 1, 9, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:20:11', '2017-01-03 21:20:11', NULL),
	(15, 1, 10, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:20:55', '2017-01-03 21:20:55', NULL),
	(16, 1, 11, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:20:57', '2017-01-03 21:20:57', NULL),
	(17, 1, 12, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:21:05', '2017-01-03 21:21:05', NULL),
	(18, 1, 13, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:27:20', '2017-01-03 21:27:20', NULL),
	(19, 1, 14, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:27:38', '2017-01-03 21:27:38', NULL),
	(20, 1, 15, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:39:30', '2017-01-03 21:39:30', NULL),
	(21, 1, 16, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:47:33', '2017-01-03 21:47:33', NULL),
	(22, 1, 17, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:48:15', '2017-01-03 21:48:15', NULL),
	(23, 1, 18, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:49:24', '2017-01-03 21:49:24', NULL),
	(24, 1, 19, 1, NULL, 1, 1, 'COP', NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, '2017-01-03 21:53:19', '2017-01-03 21:53:19', NULL),
	(25, 1, 20, 1, 1, 1, 4, 'COP', 45500, '2017-01-07', '2017-01-25', 'notas cotizacion2', 'observaciones23', NULL, '2017-01-04 21:09:53', '2017-01-12 09:43:29', NULL),
	(26, 1, 21, 1, 1, 1, 1, 'COP', 68200, '2017-01-08', '2017-01-14', 'estas notas deben salir en la cotización final.', '', NULL, '2017-01-07 10:12:05', '2017-01-12 15:47:23', NULL),
	(27, 1, 22, 1, NULL, 1, 1, 'COP', 20000, '2017-01-11', '2017-01-18', 'noras cot', 'onserv', NULL, '2017-01-11 12:09:06', '2017-01-11 12:09:06', NULL),
	(28, 1, 23, 1, 2, 1, 4, 'COP', 2000, '2017-01-12', '2017-01-27', 'Notas creadas', 'observaciones', NULL, '2017-01-12 13:35:59', '2017-01-24 13:14:33', NULL),
	(29, 1, 24, 1, 4, 1, 18, 'USD', 8000, '2017-01-24', '2017-02-02', 'asas', 'observaciones', NULL, '2017-01-24 13:15:26', '2017-01-24 13:15:26', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate_detail: ~19 rows (aproximadamente)
DELETE FROM `estimate_detail`;
/*!40000 ALTER TABLE `estimate_detail` DISABLE KEYS */;
INSERT INTO `estimate_detail` (`id`, `estimate_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_type_id`, `tax_amount`, `name`, `description`, `quantity`, `gross_total`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(3, 22, 1, 2, NULL, 2222, 0, NULL, 0, NULL, '', 2, 0, 4444, '2017-01-03 21:48:15', '2017-01-03 21:48:15', NULL),
	(4, 23, 1, 2, NULL, 2222, 0, NULL, 0, NULL, 'descripcion', 2, 0, 4444, '2017-01-03 21:49:24', '2017-01-03 21:49:24', NULL),
	(5, 24, 1, 2, NULL, 2222, 0, NULL, 0, NULL, 'descripcion', 2, 0, 4444, '2017-01-03 21:53:19', '2017-01-03 21:53:19', NULL),
	(6, 24, 1, 2, NULL, 30000, 0, NULL, 0, NULL, 'desc2', 1, 0, 30000, '2017-01-03 21:53:19', '2017-01-03 21:53:19', NULL),
	(44, 27, 1, 2, NULL, 20000, 0, NULL, 1, NULL, 'desc prod1', 1, 0, 20000, '2017-01-11 12:09:07', '2017-01-11 12:09:07', NULL),
	(51, 25, 1, 2, NULL, 40000, 10, NULL, 0, NULL, 'product 2', 1, 0, 40000, '2017-01-12 09:43:29', '2017-01-12 09:43:29', NULL),
	(52, 25, 1, 2, NULL, 10000, 5, NULL, 0, NULL, 'p3', 1, 0, 10000, '2017-01-12 09:43:29', '2017-01-12 09:43:29', NULL),
	(64, 26, 1, 3, NULL, 3000, 5, NULL, 0, NULL, 'descripcion producto 2', 2, 0, 6000, '2017-01-12 15:47:23', '2017-01-12 15:47:23', NULL),
	(65, 26, 1, 2, NULL, 50000, 0, NULL, 9, NULL, 'd2', 1, 0, 50000, '2017-01-12 15:47:23', '2017-01-12 15:47:23', NULL),
	(66, 26, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-01-12 15:47:23', '2017-01-12 15:47:23', NULL),
	(67, 26, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-12 15:47:23', '2017-01-12 15:47:23', NULL),
	(68, 26, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-01-12 15:47:23', '2017-01-12 15:47:23', NULL),
	(69, 1, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-12 17:54:59', '2017-01-12 17:54:59', NULL),
	(70, 4, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-01-12 17:56:03', '2017-01-12 17:56:03', NULL),
	(72, 7, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-13 18:09:52', '2017-01-13 18:09:52', NULL),
	(76, 28, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-24 13:14:33', '2017-01-24 13:14:33', NULL),
	(77, 29, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-24 13:15:26', '2017-01-24 13:15:26', NULL),
	(78, 29, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-01-24 13:15:26', '2017-01-24 13:15:26', NULL),
	(79, 29, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-01-24 13:15:26', '2017-01-24 13:15:26', NULL);
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

-- Volcando datos para la tabla krece.migrations: ~1 rows (aproximadamente)
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

-- Volcando datos para la tabla krece.product: ~2 rows (aproximadamente)
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `public_id`, `user_id`, `account_id`, `name`, `description`, `reference`, `sale_price`, `tax_id`, `list_price_id`, `category_id`, `inv_quantity_initial`, `inv_quantity_actual`, `inv_type_id`, `inv_unit_cost`, `inv_inStock`, `isDeleted`, `isActive`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(2, 1, 1, 1, 'producto 1', 'producto 1', 'ref', 2000, 5, 1, NULL, 50, NULL, 1, 1500, b'1', b'0', b'0', '2017-01-31 15:14:48', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(3, 2, 1, 1, 'producto 2', 'descripcion producto 2', 'ref2', 3000, NULL, 2, NULL, 50, NULL, 2, 2500, b'0', b'0', b'0', '2017-01-26 21:16:25', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(4, 3, 1, 1, 'productoprueba', 'producto para pruebas', '1234', 5000, 3, NULL, NULL, NULL, NULL, NULL, 0, b'0', b'0', b'1', '2017-01-31 15:25:11', '2017-01-31 15:25:02', '2017-01-31 15:25:02');
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
	(2, 1, 1, 2, 'Fernando Ardila', '18234994', '1234565', '12345', 'prueba', b'1', b'0', '2017-01-19 15:47:34', '2017-01-19 15:52:57', NULL),
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
	(1, 1, 1, 'Fernando', 'Ardila Rodriguez', 'fernando2684@gmail.com', '$2y$10$gC551oWqmWxtaA8mphnAVOC2u3SF.rPX65x/4qYn.0nUihR8QjSWS', '9LalK96dGv8LMg1fRSAd0jnBX80kw0L85TTTLDGXy2B7vE2s21CIJkcSmkRL', NULL, NULL, NULL, 1, '2016-12-07 16:17:25', NULL, '2017-01-24 09:42:03', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(2, 2, 1, 'Fernando 2', 'Ardila', 'fernando26842@gmail.com', '$2y$10$a55MnRDXKsxTU5UmNWKh/ua7FY1kSsvAI.PaZNXcWC3Axulhr.aD2', 'FcregiMVfdO3B65QJkXKuELvAVo9VO41bZVsKq27s22fDwJDqK79DWs92VmN', NULL, NULL, NULL, 1, '2016-12-07 17:19:15', NULL, '2017-01-24 16:45:47', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(3, 3, 1, NULL, NULL, 'fernandwo2684@gmail.com', '$2y$10$u6v0vfdvla3xCyD7HJLkVeFS/Q6Ozhf.I1AIv9nnUCqDuPDCUe1XW', 'j7WUKqHUUhp5uBiAZKAg9fWmTvKYEgEq9kk9PGGiwf1ax3DE2H5oSjoau79P', NULL, NULL, NULL, 1, '2016-12-07 17:22:30', NULL, '2016-12-07 17:22:35', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(4, 4, 1, NULL, NULL, 'fernando268422@gmail.com', '$2y$10$n..GzUA79THtAPd2Y/J8N.7nZiFzeHcdCEIH3emPIM98k4Yp9/z7u', 'O67MhIiFYyJkgNi3AkvJsI1UL7fJf8cYE4depxK7Kmk3WvI50zYWoh2u0aRJ', NULL, NULL, NULL, 1, '2016-12-07 17:23:24', NULL, '2016-12-07 17:24:15', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(5, 5, 1, NULL, NULL, 'fernando2684fff@gmail.com', '$2y$10$pzPLJy8dj/OZm0PZig7RU.MQapUDHC0QAeeoS01n5W8jedsr9jaw6', 'vJlDKaPMlujHx33vjYwAE4b6pMzOkpf75DRllIZX0dkUsCMEsgJ7Lq6DqEEp', NULL, NULL, NULL, 1, '2016-12-07 22:43:02', NULL, '2017-01-17 17:56:29', NULL, NULL, NULL, 1, NULL, NULL, b'1');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Volcando estructura para tabla krece.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.users: ~0 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

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
