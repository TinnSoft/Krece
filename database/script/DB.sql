-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.19-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5169
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
  `name` varchar(255) DEFAULT NULL,
  `identification` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `regime_id` int(11) DEFAULT NULL,
  `logo` longtext,
  `decimal_precision` tinyint(4) DEFAULT NULL,
  `decimal_separator` char(1) DEFAULT NULL,
  `account_key` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pro_plan_paid` date DEFAULT NULL,
  `pro_plan_trial` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_account_key` (`account_key`),
  UNIQUE KEY `UK_account_email` (`email`),
  KEY `FK_account_regime` (`regime_id`),
  CONSTRAINT `FK_account_regime` FOREIGN KEY (`regime_id`) REFERENCES `account_regime` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contains the account information for each user register in the app, in addition controls the the permisiones over the application';

-- Volcando datos para la tabla krece.account: ~9 rows (aproximadamente)
DELETE FROM `account`;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

-- Volcando estructura para tabla krece.account_regime
CREATE TABLE IF NOT EXISTS `account_regime` (
  `id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.account_regime: ~4 rows (aproximadamente)
DELETE FROM `account_regime`;
/*!40000 ALTER TABLE `account_regime` DISABLE KEYS */;
INSERT INTO `account_regime` (`id`, `value`) VALUES
	(1, 'Régimen común'),
	(2, 'Régimen simplificado'),
	(3, 'Régimen especial'),
	(4, 'Régimen simplicado impuesto nacional al consumo');
/*!40000 ALTER TABLE `account_regime` ENABLE KEYS */;

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

-- Volcando estructura para tabla krece.activity_log
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `detail` varchar(500) DEFAULT NULL,
  `route` varchar(500) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `process_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_log_company_id` (`account_id`),
  KEY `FK_log_user` (`user_id`),
  CONSTRAINT `FK_log_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_log_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='stores the log for each transaction made by any user';

-- Volcando datos para la tabla krece.activity_log: ~0 rows (aproximadamente)
DELETE FROM `activity_log`;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bank_account
CREATE TABLE IF NOT EXISTS `bank_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `bank_account_type_id` int(11) NOT NULL,
  `bank_account_name` varchar(100) NOT NULL,
  `bank_account_number` varchar(100) DEFAULT NULL,
  `initial_balance` float NOT NULL,
  `description` text,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `isDefault` bit(1) NOT NULL DEFAULT b'0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_BA_public_id_account_id` (`public_id`,`account_id`),
  KEY `FK_banks_accounttype` (`bank_account_type_id`),
  KEY `FK_banks_company` (`user_id`),
  KEY `FK_banks_account` (`account_id`),
  CONSTRAINT `FK_banks_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_banks_accounttype` FOREIGN KEY (`bank_account_type_id`) REFERENCES `bank_account_type` (`id`),
  CONSTRAINT `FK_banks_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='bank information related with accounts';

-- Volcando datos para la tabla krece.bank_account: ~0 rows (aproximadamente)
DELETE FROM `bank_account`;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
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

-- Volcando estructura para tabla krece.bill
CREATE TABLE IF NOT EXISTS `bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `user_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `resolution_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `observations` text COMMENT 'for customer tracking , just internal',
  `currency_code` varchar(3) NOT NULL,
  `total` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `currency_code_multicurrency` varchar(3) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `isRecurring` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`public_id`),
  KEY `FK_invoice_supplier_currency` (`currency_code`),
  KEY `FK_invoice_supplier_customerID` (`customer_id`),
  KEY `FK_invoice_supplier_status` (`status_id`),
  KEY `FK_invoice_supplier_user` (`user_id`),
  CONSTRAINT `FK_invoice_supplier_company` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_invoice_supplier_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_invoice_supplier_customerID` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_invoice_supplier_status` FOREIGN KEY (`status_id`) REFERENCES `bill_status` (`id`),
  CONSTRAINT `FK_invoice_supplier_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.bill: ~0 rows (aproximadamente)
DELETE FROM `bill`;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_detail
CREATE TABLE IF NOT EXISTS `bill_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `bill_id` bigint(20) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `tax_id` float DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_tax` float NOT NULL,
  `total` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_supplier_order_company` (`user_id`),
  KEY `FK_supplier_order_category` (`category_id`),
  KEY `FK_supplier_order_invoice_supplier_order` (`bill_id`),
  KEY `FK_soi_product` (`product_id`),
  CONSTRAINT `FK_soi_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_soi_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_supplier_order_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_supplier_order_invoice_supplier_order` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.bill_detail: ~0 rows (aproximadamente)
DELETE FROM `bill_detail`;
/*!40000 ALTER TABLE `bill_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_status
CREATE TABLE IF NOT EXISTS `bill_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.bill_status: ~7 rows (aproximadamente)
DELETE FROM `bill_status`;
/*!40000 ALTER TABLE `bill_status` DISABLE KEYS */;
INSERT INTO `bill_status` (`id`, `description`) VALUES
	(1, 'Abierta'),
	(2, 'Anulada'),
	(3, 'Aprobada'),
	(4, 'Pagada'),
	(5, 'Borrador'),
	(6, 'Cerrada'),
	(7, 'Enviada');
/*!40000 ALTER TABLE `bill_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_tax
CREATE TABLE IF NOT EXISTS `bill_tax` (
  `id` bigint(20) NOT NULL,
  `bill_id` bigint(20) NOT NULL,
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
  KEY `FK_invoice_supplier_order_invoice` (`bill_id`),
  KEY `FK_invocie_supplier_user` (`user_id`),
  CONSTRAINT `FK_invocie_supplier_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_invoice_supplier_ider_id` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.bill_tax: ~0 rows (aproximadamente)
DELETE FROM `bill_tax`;
/*!40000 ALTER TABLE `bill_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_tax` ENABLE KEYS */;

-- Volcando estructura para tabla krece.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.cache: ~0 rows (aproximadamente)
DELETE FROM `cache`;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='product categories';

-- Volcando datos para la tabla krece.category: ~0 rows (aproximadamente)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Volcando estructura para tabla krece.category_payment
CREATE TABLE IF NOT EXISTS `category_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_id` bigint(20) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `unit_price` float NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `tax_total` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `observations` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id_company_id_category_id_tax_id` (`payment_id`,`account_id`,`category_id`,`tax_id`),
  KEY `FK_cp_tax` (`tax_id`),
  KEY `FK_cp_company_id` (`account_id`),
  KEY `FK_cp_payment_id` (`payment_id`),
  KEY `FK_cp_category` (`category_id`),
  KEY `FK_cp_user` (`user_id`),
  CONSTRAINT `FK_cp_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_cp_company_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_cp_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK_cp_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains the whole set of contacts of each company';

-- Volcando datos para la tabla krece.contact: ~0 rows (aproximadamente)
DELETE FROM `contact`;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this table contains other email contacts of any organization';

-- Volcando datos para la tabla krece.contact_others: ~0 rows (aproximadamente)
DELETE FROM `contact_others`;
/*!40000 ALTER TABLE `contact_others` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_others` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note
CREATE TABLE IF NOT EXISTS `credit_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `resolution_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `observations` varchar(255) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `amount_pending_to_apply` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_public_account` (`public_id`,`account_id`),
  KEY `FK_credit_note_company` (`account_id`),
  KEY `FK_credit_note_list_price` (`list_price_id`),
  KEY `FK_credit_note_customer` (`customer_id`),
  KEY `FK_credit_note_currency` (`currency_code`),
  KEY `FK_credit_note_user` (`user_id`),
  CONSTRAINT `FK_credit_note_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_credit_note_currency` FOREIGN KEY (`currency_code`) REFERENCES `currency_code` (`code`),
  CONSTRAINT `FK_credit_note_customer` FOREIGN KEY (`customer_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_credit_note_list_price` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_credit_note_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note: ~0 rows (aproximadamente)
DELETE FROM `credit_note`;
/*!40000 ALTER TABLE `credit_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_note` ENABLE KEYS */;

-- Volcando estructura para tabla krece.credit_note_detail
CREATE TABLE IF NOT EXISTS `credit_note_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_note_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_tax` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_credit_note_detail_credit_note_id` (`credit_note_id`),
  KEY `FK_credit_note_detail_item` (`product_id`),
  KEY `FK_credit_note_detail_tax` (`tax_id`),
  KEY `FK_credit_note:user` (`user_id`),
  CONSTRAINT `FK_credit_note:user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_credit_note_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_credit_note_detail_remision_id` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_note` (`id`),
  CONSTRAINT `FK_credit_note_detail_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note_detail: ~0 rows (aproximadamente)
DELETE FROM `credit_note_detail`;
/*!40000 ALTER TABLE `credit_note_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_note_detail` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.currency: ~0 rows (aproximadamente)
DELETE FROM `currency`;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
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
  `resolution_id` int(11) NOT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `observations` text COMMENT 'for customer tracking , just internal',
  `exchange_rate` float DEFAULT NULL,
  `amount_pending_to_apply` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`resolution_id`),
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
  `category_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_debit_note_detail_company` (`user_id`),
  KEY `FK_debit_note_detail_id` (`debit_note_id`),
  KEY `FK_debit_note_detail_tax_id` (`tax_id`),
  KEY `FK_category_id` (`category_id`),
  KEY `FK_debit_note_product` (`product_id`),
  CONSTRAINT `FK_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_debit_note_detail_po` FOREIGN KEY (`debit_note_id`) REFERENCES `debit_note` (`id`),
  CONSTRAINT `FK_debit_note_detail_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_debit_note_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_debit_note_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.debit_note_detail: ~0 rows (aproximadamente)
DELETE FROM `debit_note_detail`;
/*!40000 ALTER TABLE `debit_note_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `debit_note_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.estimate
CREATE TABLE IF NOT EXISTS `estimate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `resolution_id` int(11) DEFAULT NULL COMMENT 'Numero definitivo de la cotización',
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate: ~0 rows (aproximadamente)
DELETE FROM `estimate`;
/*!40000 ALTER TABLE `estimate` DISABLE KEYS */;
/*!40000 ALTER TABLE `estimate` ENABLE KEYS */;

-- Volcando estructura para tabla krece.estimate_detail
CREATE TABLE IF NOT EXISTS `estimate_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estimate_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT '0',
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_tax` float DEFAULT '0',
  `total` float DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_quote_detail_quote_id` (`estimate_id`),
  KEY `FK_quote_detail_company` (`user_id`),
  KEY `FK_quote_detail_item` (`product_id`),
  KEY `FK_quote_detail_tax` (`tax_id`),
  CONSTRAINT `FK_estimate_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_estimate_detail_remision_id` FOREIGN KEY (`estimate_id`) REFERENCES `estimate` (`id`),
  CONSTRAINT `FK_estimate_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_estimate_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate_detail: ~0 rows (aproximadamente)
DELETE FROM `estimate_detail`;
/*!40000 ALTER TABLE `estimate_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `estimate_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.failed_jobs: ~0 rows (aproximadamente)
DELETE FROM `failed_jobs`;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order
CREATE TABLE IF NOT EXISTS `invoice_sale_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'related with client that will receive the invoice',
  `account_id` int(11) NOT NULL,
  `resolution_id` int(11) unsigned NOT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_terms_id` varchar(20) NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `notes` text COMMENT 'vissible inf the sale invoice',
  `observations` text COMMENT 'for customer tracking , just internal',
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `currency_code_multicurrency` varchar(3) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `isRecurring` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
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
  CONSTRAINT `FK_invoice_sale_listprice` FOREIGN KEY (`list_price_id`) REFERENCES `list_price` (`id`),
  CONSTRAINT `FK_invoice_sale_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `FK_invoice_sale_status` FOREIGN KEY (`status_id`) REFERENCES `invoice_sale_order_status` (`id`),
  CONSTRAINT `FK_invoice_sale_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Header of sale invoices';

-- Volcando datos para la tabla krece.invoice_sale_order: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order`;
/*!40000 ALTER TABLE `invoice_sale_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_detail
CREATE TABLE IF NOT EXISTS `invoice_sale_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'header invoice number',
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_ISOI_invoice_sale_order` (`invoice_sale_order_id`),
  KEY `FK_ISOI_item` (`product_id`),
  KEY `FK_ISOI_company` (`user_id`),
  KEY `FK_ISOI_tax` (`tax_id`),
  CONSTRAINT `FK_ISOI_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_ISOI_invoice_sale_order` FOREIGN KEY (`invoice_sale_order_id`) REFERENCES `invoice_sale_order` (`id`),
  CONSTRAINT `FK_ISOI_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_ISOI_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.invoice_sale_order_detail: ~0 rows (aproximadamente)
DELETE FROM `invoice_sale_order_detail`;
/*!40000 ALTER TABLE `invoice_sale_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_sale_order_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_status
CREATE TABLE IF NOT EXISTS `invoice_sale_order_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.invoice_sale_order_status: ~7 rows (aproximadamente)
DELETE FROM `invoice_sale_order_status`;
/*!40000 ALTER TABLE `invoice_sale_order_status` DISABLE KEYS */;
INSERT INTO `invoice_sale_order_status` (`id`, `description`) VALUES
	(1, 'Abierta'),
	(2, 'Anulada'),
	(3, 'Aprobada'),
	(4, 'Pagada'),
	(5, 'Borrador'),
	(6, 'Cerrada'),
	(7, 'Enviada');
/*!40000 ALTER TABLE `invoice_sale_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_withholding_tax
CREATE TABLE IF NOT EXISTS `invoice_withholding_tax` (
  `withholding_tax_values_id` int(11) NOT NULL,
  `invoice_id` bigint(20) NOT NULL COMMENT 'contain sale e and supplier orders',
  `invoice_type_id` tinyint(4) NOT NULL,
  KEY `FK_iwt_tax_values` (`withholding_tax_values_id`),
  KEY `FK_iwt_invoice_type` (`invoice_type_id`),
  CONSTRAINT `FK_iwt_invoice_type` FOREIGN KEY (`invoice_type_id`) REFERENCES `todelete_invoice_type` (`id`),
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

-- Volcando estructura para tabla krece.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla krece.jobs: ~0 rows (aproximadamente)
DELETE FROM `jobs`;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Store the list price information';

-- Volcando datos para la tabla krece.list_price: ~0 rows (aproximadamente)
DELETE FROM `list_price`;
/*!40000 ALTER TABLE `list_price` DISABLE KEYS */;
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

-- Volcando estructura para tabla krece.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.migrations: ~0 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
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
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resolution_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `bank_account_id` int(11) NOT NULL,
  `observations` text,
  `notes` text,
  `payment_method_id` tinyint(4) NOT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `type_id` char(2) NOT NULL,
  `status_id` tinyint(4) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL COMMENT 'permite asociar un pago de tipo ingreso a uno de tipo  egreso',
  `isInvoice` bit(1) NOT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id_company_id_type_id` (`resolution_id`,`account_id`,`type_id`),
  KEY `FK_payment_customer` (`customer_id`),
  KEY `FK_payment_type` (`type_id`),
  KEY `FK_payment_status` (`status_id`),
  KEY `FK_payment_payment_method_id` (`payment_method_id`),
  KEY `FK_payment_bank` (`bank_account_id`),
  KEY `FK_payment_account` (`account_id`),
  KEY `FK_payment_user` (`user_id`),
  CONSTRAINT `FK_payment_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_payment_bank` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_account` (`id`),
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

-- Volcando estructura para tabla krece.payment_history
CREATE TABLE IF NOT EXISTS `payment_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `invoice_sale_order_id` int(11) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `amount` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_payment_history_account_id` (`account_id`),
  KEY `FK_payment_history_user` (`user_id`),
  KEY `FK_payment_history_payment` (`payment_id`),
  CONSTRAINT `FK_payment_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_payment_history_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK_payment_history_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_history: ~0 rows (aproximadamente)
DELETE FROM `payment_history`;
/*!40000 ALTER TABLE `payment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_history` ENABLE KEYS */;

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
	(5, 'Tarjeta crédito', b'1'),
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
	(1, 'Aplicado'),
	(2, 'Anulado'),
	(3, 'Devuelto'),
	(4, 'Completo');
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_terms: ~0 rows (aproximadamente)
DELETE FROM `payment_terms`;
/*!40000 ALTER TABLE `payment_terms` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.product: ~0 rows (aproximadamente)
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
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
  `resolution_id` int(11) NOT NULL COMMENT 'resolution DIAN #',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `due_date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `status_id` int(11) NOT NULL COMMENT 'Status of the invoice that could be open, closed, revoked',
  `notes` text COMMENT 'vissible inf the supplier invoice',
  `observations` text COMMENT 'for customer tracking , just internal',
  `terms` text,
  `exchange_rate` float DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_supp_company_id_document_number` (`account_id`,`resolution_id`),
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
  `unit_price` float NOT NULL,
  `discount` float DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float NOT NULL,
  `total_tax` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_purchase_order_detail_company` (`user_id`),
  KEY `FK_purchase_order_purchase_order_detail` (`purchase_order_id`),
  KEY `FK_purchase_order_detail_tax_id` (`tax_id`),
  KEY `FK_PO_detail_category` (`category_id`),
  KEY `FK_Po_detail_product` (`product_id`),
  CONSTRAINT `FK_PO_detail_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_Po_detail_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_purchase_order_detail_po` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK_purchase_order_detail_tax_id` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
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

-- Volcando datos para la tabla krece.purchase_order_status: ~3 rows (aproximadamente)
DELETE FROM `purchase_order_status`;
/*!40000 ALTER TABLE `purchase_order_status` DISABLE KEYS */;
INSERT INTO `purchase_order_status` (`id`, `description`) VALUES
	(1, 'Borrador'),
	(2, 'Anulada'),
	(3, 'Facturada');
/*!40000 ALTER TABLE `purchase_order_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision
CREATE TABLE IF NOT EXISTS `remision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `public_id` int(11) DEFAULT NULL,
  `resolution_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `list_price_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `document_type_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `total_discounts` float DEFAULT NULL,
  `total_taxes` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `observations` varchar(255) DEFAULT NULL,
  `exchange_rate` float DEFAULT NULL,
  `isDeleted` bit(1) DEFAULT b'0',
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
  KEY `FK_remision_user` (`user_id`),
  KEY `FK_remision_status` (`status_id`),
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
  `tax_id` int(11) DEFAULT NULL,
  `tax_amount` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_remision_detail_remision_id` (`remision_id`),
  KEY `FK_remision_detail_item` (`product_id`),
  KEY `FK_remision_detail_tax` (`tax_id`),
  KEY `FK_remision_detail_user` (`user_id`),
  CONSTRAINT `FK_remision_detail_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_remision_detail_remision_id` FOREIGN KEY (`remision_id`) REFERENCES `remision` (`id`),
  CONSTRAINT `FK_remision_detail_tax` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`),
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

-- Volcando datos para la tabla krece.remision_document_type: ~2 rows (aproximadamente)
DELETE FROM `remision_document_type`;
/*!40000 ALTER TABLE `remision_document_type` DISABLE KEYS */;
INSERT INTO `remision_document_type` (`id`, `description`) VALUES
	(1, 'Remision'),
	(2, 'Orden de Servicio');
/*!40000 ALTER TABLE `remision_document_type` ENABLE KEYS */;

-- Volcando estructura para tabla krece.remision_status
CREATE TABLE IF NOT EXISTS `remision_status` (
  `id` int(11) NOT NULL,
  `description` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_status: ~2 rows (aproximadamente)
DELETE FROM `remision_status`;
/*!40000 ALTER TABLE `remision_status` DISABLE KEYS */;
INSERT INTO `remision_status` (`id`, `description`) VALUES
	(1, 'Activo'),
	(2, 'Anulado');
/*!40000 ALTER TABLE `remision_status` ENABLE KEYS */;

-- Volcando estructura para tabla krece.resolution
CREATE TABLE IF NOT EXISTS `resolution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `initial_number` varchar(50) DEFAULT NULL,
  `final_number` varchar(50) DEFAULT NULL,
  `next_invoice_number` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `invoice_text` varchar(500) DEFAULT NULL,
  `isDefault` bit(1) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `auto_increment` bit(1) NOT NULL DEFAULT b'1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_resolution_account` (`account_id`),
  KEY `FK_resolution_user` (`user_id`),
  CONSTRAINT `FK_resolution_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_resolution_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains resolution IDs for each sale order, according law policies (DIAN in colombia)';

-- Volcando datos para la tabla krece.resolution: ~0 rows (aproximadamente)
DELETE FROM `resolution`;
/*!40000 ALTER TABLE `resolution` DISABLE KEYS */;
/*!40000 ALTER TABLE `resolution` ENABLE KEYS */;

-- Volcando estructura para tabla krece.resolution_numbers
CREATE TABLE IF NOT EXISTS `resolution_numbers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prefix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` int(11) NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_resonumb_account_id` (`account_id`),
  CONSTRAINT `FK_resonumb_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.resolution_numbers: ~0 rows (aproximadamente)
DELETE FROM `resolution_numbers`;
/*!40000 ALTER TABLE `resolution_numbers` DISABLE KEYS */;
/*!40000 ALTER TABLE `resolution_numbers` ENABLE KEYS */;

-- Volcando estructura para tabla krece.retention
CREATE TABLE IF NOT EXISTS `retention` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `public_id` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.retention: ~0 rows (aproximadamente)
DELETE FROM `retention`;
/*!40000 ALTER TABLE `retention` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='seller list customized by company';

-- Volcando datos para la tabla krece.seller: ~0 rows (aproximadamente)
DELETE FROM `seller`;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.tax: ~0 rows (aproximadamente)
DELETE FROM `tax`;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user: ~10 rows (aproximadamente)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
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
	(1, 'Activo'),
	(2, 'Inactivo'),
	(3, 'Eliminado');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;

-- Volcando estructura para procedimiento krece.delete_all_data
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_all_data`()
    COMMENT 'Elmina todos los datos de la base de datos y restaura los ids autonumerícos'
BEGIN

delete from remision_detail;
ALTER TABLE remision_detail AUTO_INCREMENT = 1;

delete from remision;
ALTER TABLE remision AUTO_INCREMENT = 1;

delete from resolution;
ALTER TABLE resolution AUTO_INCREMENT = 1;

delete from resolution_numbers;
ALTER TABLE resolution_numbers AUTO_INCREMENT = 1;

delete from retention;
ALTER TABLE retention AUTO_INCREMENT = 1;

delete from category_payment;
ALTER TABLE category_payment AUTO_INCREMENT = 1;

delete from bill_detail;
ALTER TABLE bill_detail AUTO_INCREMENT = 1;

delete from bill;
ALTER TABLE bill AUTO_INCREMENT = 1;

delete from invoice_sale_order_detail;
ALTER TABLE invoice_sale_order_detail AUTO_INCREMENT = 1;

delete from invoice_sale_order;
ALTER TABLE invoice_sale_order AUTO_INCREMENT = 1;

delete from estimate_detail;
ALTER TABLE estimate_detail AUTO_INCREMENT = 1;

delete from estimate;
ALTER TABLE estimate AUTO_INCREMENT = 1;

delete from purchase_order_detail;
ALTER TABLE purchase_order_detail AUTO_INCREMENT = 1;

delete from purchase_order;
ALTER TABLE purchase_order AUTO_INCREMENT = 1;

delete from debit_note_detail;
ALTER TABLE debit_note_detail AUTO_INCREMENT = 1;

delete from debit_note;
ALTER TABLE debit_note AUTO_INCREMENT = 1;

delete from credit_note_detail;
ALTER TABLE credit_note_detail AUTO_INCREMENT = 1;

delete from credit_note;
ALTER TABLE credit_note AUTO_INCREMENT = 1;

delete from payment_history;
ALTER TABLE payment_history AUTO_INCREMENT = 1;

delete from payment;
ALTER TABLE payment AUTO_INCREMENT = 1;

delete from failed_jobs;
ALTER TABLE failed_jobs AUTO_INCREMENT = 1;

delete from retention;
ALTER TABLE retention AUTO_INCREMENT = 1;

delete from list_price;
ALTER TABLE list_price AUTO_INCREMENT = 1;

delete from currency;
ALTER TABLE currency AUTO_INCREMENT = 1;

delete from product;
ALTER TABLE product AUTO_INCREMENT = 1;

delete from category;
ALTER TABLE category AUTO_INCREMENT = 1;

delete from seller;
ALTER TABLE seller AUTO_INCREMENT = 1;

delete from bank_account;
ALTER TABLE bank_account AUTO_INCREMENT = 1;

delete from payment_terms;
ALTER TABLE payment_terms AUTO_INCREMENT = 1;

delete from tax;
ALTER TABLE tax AUTO_INCREMENT = 1;

delete from contact;
ALTER TABLE contact AUTO_INCREMENT = 1;

delete from activity_log;
ALTER TABLE activity_log AUTO_INCREMENT = 1;

delete from user;
ALTER TABLE user AUTO_INCREMENT = 1;

delete from account;
ALTER TABLE account AUTO_INCREMENT = 1;



END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
