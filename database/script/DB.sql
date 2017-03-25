-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.19-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5151
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
  `email_footer` text,
  `email` varchar(255) DEFAULT NULL,
  `invoice_design_id` int(11) unsigned DEFAULT '1',
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
  `show_currency_code` bit(1) DEFAULT NULL,
  `pro_plan_trial` date DEFAULT NULL,
  `enable_portal_password` bit(1) DEFAULT b'0',
  `send_portal_password` bit(1) DEFAULT b'0',
  `custom_invoice_item_label1` varchar(255) DEFAULT NULL,
  `custom_invoice_item_label2` varchar(255) DEFAULT NULL,
  `recurring_invoice_number_prefix` varchar(255) DEFAULT 'R',
  `enable_client_portal` bit(1) DEFAULT b'1',
  `invoice_fields` text,
  `financial_year_start` date DEFAULT NULL,
  `enabled_modules` smallint(6) DEFAULT '63',
  `enabled_dashboard_sections` smallint(6) DEFAULT '7',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_account_key` (`account_key`),
  UNIQUE KEY `UK_account_email` (`email`),
  KEY `FK_account_regime` (`regime_id`),
  CONSTRAINT `FK_account_regime` FOREIGN KEY (`regime_id`) REFERENCES `account_regime` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='Contains the account information for each user register in the app, in addition controls the the permisiones over the application';

-- Volcando datos para la tabla krece.account: ~7 rows (aproximadamente)
DELETE FROM `account`;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`id`, `name`, `identification`, `address`, `phone`, `website`, `city`, `regime_id`, `logo`, `decimal_precision`, `decimal_separator`, `account_key`, `email_footer`, `email`, `invoice_design_id`, `pro_plan_paid`, `id_number`, `email_template_invoice`, `email_template_quote`, `email_template_payment`, `invoice_footer`, `pdf_email_attachment`, `referral_user_id`, `email_subject_invoice`, `email_subject_quote`, `email_subject_payment`, `email_subject_reminder1`, `email_template_reminder1`, `enable_reminder1`, `num_days_reminder1`, `num_days_reminder2`, `num_days_reminder3`, `custom_invoice_text_label1`, `custom_invoice_text_label2`, `invoice_number_pattern`, `quote_number_pattern`, `quote_terms`, `email_design_id`, `show_currency_code`, `pro_plan_trial`, `enable_portal_password`, `send_portal_password`, `custom_invoice_item_label1`, `custom_invoice_item_label2`, `recurring_invoice_number_prefix`, `enable_client_portal`, `invoice_fields`, `financial_year_start`, `enabled_modules`, `enabled_dashboard_sections`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'TinnSoft', '1234567', 'mi dirección', '3629222', 'www.fernando.com', 'Bogotá', 1, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAbQAAAEHCAMAAAGGs3M5AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAL6UExURQAAAP7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v////7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v////7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v////7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v////7+/v////7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v////7+/v7+/v////7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v////7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v////7+/v7+/v7+/v7+/h0aU+MAAAD+dFJOUwCvQBpbnAfdSInwyjV2t/hjpOWRItI9fg+/UCprrBftWJnaRYbHMnMEtB/1oeJNjmA6ewy8J/1oqeqW10KDFMRVL3ABsRzyXZ4J30qLN7kk+mXMpud4UpPUPxHBLG2uGe+AWpvcRzR1BrYh94hiow7kT5DRfb4paqs8FuxXmP/ZhcYxcgOzRPRfC+FMjR7OOaB6uyb8Z6gT6VSV1kGCwy5vsBvxXJ3eSYrLNncIuCP5ZKXmUZLTPn8QK2yt7lnAmttGhxjIdAW19mGiMw3jTo8g0Dt8vf5pFetWlyjYQ6qExXECsh3zXp8w4EuMzTh5Crol+6cS6FOU1WaBwi1uC2S5HQAAAAlwSFlzAAAXEQAAFxEByibzPwAAExtJREFUeF7t3Qm8HFWVx/EiYVeGRUEcUQlIQCVsCiSAwIACgyCrSEAQxIBDZB1AheGyBBGCIlvYE1llCzuDwihbRPaAskc2QQSCBGRTQD+fufee3711b1V1v37YL+meOd+Pdt3zP7equ+i8ft3V/aoL9f+eMf7CXQ6KW+OLg1/Nr/c+VnPryGr2tvpN+GJjYx60iwVab9FN/1sY+As79SS3WLo4UapGruV7/tJduP/J/1k08uuN9QN3IQMmt1+PnrtYyG/FrncnPV81kvX+HFZOQqIWZHqY5AcHhjrGDXzubxuDuCwXbT37rF+Yr8hC5g+8mlJKzVnyODXoRyu/wuAf49waHTyiVtk1HgvXKJvYT2K/pZYbZLafYe7yl69I4bfhFw1ixy/4/+F2cbQphtnFub5Z42b79eLFKeH6ifywSla7La7myDhUe/pxBbOTQVg8F6omzE5uKf/3i6UkrpOYaW5gzDyy8Gv7RTv8ihwv05YyX3aLu9y9oZRSSvWE8pdZB7/X/mnxKtxgih8NIa7NLYZ6xyy5Fnf5mSTxyrEcD8g6ZeWLDrGKRZBs5XJ7ebgEoVEU81LK4nF7eY5rdsathCSJo7D8fJI/RhabftkRt5Y5szjPLcrED5Z1o8Dn433uSSqIOhBmz4yrxcFIO9jNunnEoTPWSnLPVa7nmn8hG1jcRjx2FRM3ut4vv+cu7wy5XV5RLByrD/pFZ+xKbHsEwzI52g0nvxECt0So/uEvXbMzyWz3T9COkyRcwRNS+TvXkurRrFJKKaWUUkopNbTKF2BPuRdj0ymGSHlt7sqG+qVfvIbZcWXx2mbLlYVru2S2XFm4Nndlk3wwpOTa3JWFXXOjyfbCHQe5Lm0wLZa+WJqiM35tvx6BT6jdwpFGpaSI63XCTc9X8pVVFN9hRJOxlVW3+mZn7PSW1yaXq9jLVWy+RhluXhSj7WLlMKVjbrogKDewH4OHZBlyWSaVW3TIrSW+kSS1gVzu46vvlplfbu0HHbGzrRXcRZLUBnKQy1ciVKfn8QDsZDfdXV4Vk7nCICqKa/1l8EGJBVkHmH1PuZYdLBQG0Q7F8vbSx947EguyDtjJS7A0T4Xk2jCIh1en+dvjY+/D0gvHZTsVtrGI27Yf2aX7qJ9cmx+IUO3qfgBiNThxLbftBRnsHhMZHEk5H0sb24uVfLWzu+xU2KL7KKUM7eJ3PnGjY2ThGizccsus+q1bdoaVZBS2Wl6bMeu4i9dj6dnC/6N8elGqTpWzT2VNe8m1ldvPK/9GC2NjRvtmZ+x0RrK+X4Rre8BHcQbVlVk1Sqr361k+PeK5n6uRjK2Hs3fNnjfmIYZKKaWUUkoppZRSSimllFJqCNwvqILJC9x/5jx3nzp69GDehOo18s5WfGPMG0ZozEdJ+hL7QOURWQR9qrYT40iMeZukX7EbVP937jIr34/plMZ8jqSPsSdZYcxyUteNMmbM44yd7V6ysx8+8EuUudPueN1tbJMbqFPHbepaUxpPLdEl7gosN/wV49q/xZCuxMCcluXiGski4oBUkIlfEnYd2y9HxpwonRL5TSy5nYxLm/pYECVeotPQ+ySNLmPrxSwGxpxEp0QjysPFbmFQ3jUnU+doUtn7eRkG5YpdxbZTP6MVkRuzhqtW9J8qI9nAjYtiCUqpQnOxvNw2Ldz53Cz3t7OOVN3FpnP0AlJzI7X1hCTxEWUfqRfxhYzNNr5wpP4PN/y1jLfyuSP18lTdJFuuognCNK0laZCOq2q9WtA1bNlZNanoCrLFKS33Wb9GrnlpMq56k14N/W5iy8Y8n5e+AtHLlNYkohrXvFGGE/3Miv+SXt1RTOgithx3hTLbNxL5QfLOIKp50TbfZixTc/6v0psMY0IXsWUqi6AhGkdp/YKIMndau2a7XpfVr4okyajTs1IRUVXQvIiyKH4mwWt2KKM5tGshKkPKdNf8h07jCTiK4mqpZZXwzzV88tJ9RN1x4zOTsVOtu6hpy2TuI9dpHT6Q6pHxC+p8Kv85d/8kWriP9sdXE3IvfpZqJ1/dR/VHX3UXm6YCYbijKLJdKyaSpu6lVxxBkAp/8bE9deo8el3FtqkCUmP+lFT5rhU3EEfZc3+yErkVPoYcnU+jy9g6VURszNNlUdk16z06zkyy6HgazrtkwWvkzhlkSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSinVAqf2qZzbZ4lPvXzdiBeuHj169P4kfYg/tFqYEqQWQT9iD/z3kESEFkFfYhcepvR2JjSm+QwpfYJ9SO+e8q/CFyDpT+xEumsk8Utk+hV7kewagUXQr9iLcjdOIuj7Pavt2kxqOVFDX2M/4q5RGvMjgv7FjoRdo+IsPv2NPWHX6udW6mPsiezKdhSt9+xE23uDsbeNO7/ZNXKqhpqr/Mkb1i5PUZQ4YUvbemsC1VBw1+1khXnSl5GEm8cJx5MfRW3dQpTYl5YVzjoVkVv7knQfV+B3jaExm/hWSdKx5QSJ3deUluaXMHiQGAcQe5cRiqE6BwKbdzfWnzrPk1ZJ0rH3y9KYi32a75kx1/sU7xJG79Cw8j0z5svkXcbW7d48wqi+Z2HXZGH50H2LZu43Pvfcz2RFPBfJkwQlzu7XZWzc3loGDXtWttAYWj73CDK02q/YRWyb76n16CRoBP4h46MUZo2twylt5AtenVMIMpz/9IuU9tHoeQbmq9LqLradqn/jLI3g72nmJ1yZFkVxL6X5h6viP07fiytOdcUuFL7TZWw6Q6tEbswettjC958mcWPLf+uwMZ+QakepDKfsPIfSF3ukRVEsKNXJlN0kW87tQi8iN8kvWBL35bGelJwmWQpzoVSxXjkZL+sblpThN2U3yZYrvk0zIE7vzmqS1r9JC2cDX4733x/sh0mPu42qm2TDVTQD0uTU1ZzPujwBKL+h/XhNGZdbWcF872MMX5TWJZRFsZMEVN0kG0b8gf86XZDOTWntLUn5ROL3Evhvy/6AjBsPYX5NenzxtPWqBAdRdpFsWDxRVnRB+CalRZKcoE+CP5RDs47PK3hI/BWlJUH1bFRdIBsWRbEkI7MdbUFI5ZDU3JE049OPFL2aZ+h3EVt2stI3g3pGUrN90vQTq+jVDMELALZs+Sdyq1P432ARGZVDUrNR0vQTq+jV0e8iNhxPaUuVX1U9IqlLmn5iFb06+l3Ehs3l1PHp/aEEDhGVQ1KXNF/1Myvo1dHvIjZcbpm6aUeoHBL3hfnOzTePGHHooTNmyDfn00y+Y7xEj/UqK3YXV7UMZXKK2+R83CRUDknjg2BoNj6dpzc73ifhqr5FaZGke1ILisUlafzVVfxAmutRWvZ5KY9LnHYx/+UyNOSa0pO6h+fpyanGCagcJu1NmQt3PKVVBqvI6AeSDym5puz0y0TJTavWRfG5anSlWYwzqVvV5oQkSIbeGHP67Qy7jGu6j9IpD+cQNOxaiH5MGepZaREP0VG/kIzjs1RqOZLUVWw5O1BI1nbXzsqz7NzAxQtUl0l5IeWxrliOwneKYkZedhNbfovS+xBhvMK88j5BJuFFFJUV5ITrYWekOZVCqvhlP77qLrY8hlIQGrNFVksBMmM+cMwe8dsU/Gsaq+n8v2ZX6VEZ89u9JqzN0Kwuva5i04dQihVJw95kBY4lTJVHHggytJp6Q/K+ENuuHA4hDWf8pfDj6ATSBB2r4RBrfCvyOoIEne5i25WTKp9LzJWm49J8xNHuNJzyfWNMomHx+740lkZ3sXH5noIScf6y2XcSlZuY/7zMRYoLiL34wCIan2z+89j6ZymD/CtpkmGmfBfAmMPIoldoOOcnbwc4m5M7o8jmjGcFVepL8smg8atRZ9blUOunKjvmTHvKt17/ObVSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimlKvxX/UTjSRtN3ZRZqYNpqtmI//bYkrRJ+Nb81G301GzFf32cQlp37L5MSbT9uVRDh//+AWnNLPqpa+mp2Y07ICCtWPJ52okd6anZj7sgIM09SDN1Mj01B3AfBKSpN2mlNqOn5gjuhYA0sSudxOtN3zCqZh/uh4A0Opg8tTE9NadwRwSkwReIE8/QUnMOd0VAKr5BmPoJPTUHcV8EpF7D98f/lVbn9rl0/bEHMW5h2j3TLzpyGsXgrPv1o9d/8sjP3EvZqYNHrjRz5PANqfoP90ZAav2RJPUovSZjUi/6aO5lWM+aOMtHmXG77UI3OHCnFei19+pVd7BGacqfaLZx9lpjmB1MmTDYe7wHcNsD0qK4myDxB1rNmCTG2uBExtFdMhHj1iauunlJZrRy0LnMrJtyKXOaXH88s6r2fn8/5nMOtzsgfYAysTWtVpgmxhZTX2IYncVEbzJho9efZFaTd5nUyvLMq7qMfrP9mNUfuNGBhM9RJVaSTmvME2O/zyCxKhOttneZs2Cr5zsD3WVO0zHR9neZdcqyzOwH3ObARVcwTpzq57bFTLEZy8RzzLMOI2rnZeZm/o3mAOZheukSOu2MYG4f4BYHNnmPYWJpmdsWU1v6NvOKzQkGcCDTExvQGlD2SFwUHyMewEC/AHoHNzgoXmSQu4jZbTCzle8wrZibIFpmwqsuH3c1dbDgsX5+aW8apfNHfHPV4fecMc8h1NFrrOIdRxiNmrWDy9d5gTp4eLif3/u4vcHiLKvmZnprTMwcMWv+aVccN8INmVWs7hulb5I7S2xEKD5NjEnEwRE30HC2IwwOJbemEQXvkDsjtyUUU4h7HTd3QDcyvyXmJY6kY91+BoNiIk3xFdJgArlYitS7gTAYRh58nhzlM5n83+FypMFV5OJE0h7HrR3YR1ihFaZFt5Dn3qArPk5auouO+DCpU3mRtTpx6dd0xL6kxQwCcRJpKf8ZHUna27ixHbifNVpgVnQeeWYfmmJB0lT2wnl/QutSIqSPqghPLf9z/3/9BZGzJbHYhzRxAi3vBcLexo3txIqs0oxJwY+Ic/nDX3xykriInvcWoeV/MUb/Qpo5uukQ2F6sIWaQpn5Cz1uYsLdxY+tGF39lFCUvteqYEyS/0BLb0xWNL9jpifiKd8NTSMQjxAN7hjVE41uB42l66xP2NG5rjXtSnD1wOOvJOo2YgqZHvqLYgS6GrdDglzS9C1mxOIgAjY+9TTZkBbzNlWRuoen9Dyv2NG5rBU+LP04Z/U3yJszATaS53el2LL7jejQBOv68wxas0LHtWbGncVsz5Q/U5STRtjTqmIBNSHOP0+3YfaxYHEMgDiEd2K2s0bHnWbGncVtT36flTCGLWv6mpo+fk+aaPvLaXviRytfs/E57hDU69yZr9jJuamllGqgfam3x0EQXza/Ft6LbuT1ZcxFqkA5sfVboXPMzqN7CTQ0mrkse/TedUvP71zTR8DrKepJu537fvGbtVrZyDyt07nes2cu4qTiMNJU9ufLCf8kMPcwkze1JF6SdqLxd1PET88rz1XmJ+xx7g8ZjT6Nolpr+NdJCi/eeH6Yt0qNUA8mPWdbfMbOu3/HpW/+dcZS9guiTo1QDYm8wH2mu+mGYxnfn6SB9MpNYkbZo9cmAJoezDqpv2zjl++0TF90qHJv8EJH4AmmfY2/wEmlF/paJsxedEg3sTlpxPW3R9Kpvs68uwShXeXXd8NeMf6eFNSX9KaWIh5ETk1c7u7OPgPUO9gajSKvyo67OHnQicrT6VNRZ9EX9UOB+dOwP/d2LbEHonUqODYhLy9ER8bDlEQRiG9JS+e9o4tWTGn9b9x5uMJr+JXr0E9WjvcRIPsWTyY4HG/MGcfDoD2ngNHJrw8qPe/V4fH6Qsfy83qoEuIM4mLoYDQzm9+wcw21FywMeRzEhUXkyQIqWT5wXYkKQPQ/M300zZhVybyZh9DUaTv4mgDF3k1vVd7yzj1++TRicQ97buLE4nbQufyfMm4uWIETrVzuLMiP6dHjSchtBlLyd5nyXOLHtU2e+e/Gh+TNLZyKreGcSRg+tQ+cAgqj56FvP4dbiMdIGw5mSeI+WR4Y2L1Hzt5LbeJoVogtoDGgZVsDFxAO6jhV6HTcXnyRtcjJzEunTPyK0O67Q4WHj7LFRTKc1gNr7fvPTGMBOTO953F40vw2Ghk/XJb8DSdDuTivWrb9crzlsKpNzN9NuZzpzE/O2+sOBxDXt/rykt3CLsRFps1eYlbiS1qDutKL4yxPMa2HTnzKx5hPfYkoruzKxYvjW9FsY009/eMdtxg9JWxjGtBStwd1pRXHaWsxscF37F7u3M63Bn+VvrBq9ujKTGuzWX3/vxK3GnaStNP1yoEWFAe80Z6n8U2/ea4/TbGvpnZmeeGy1pmNbub3WY3Lipgtoqo4d9cDm+036yP2rTTqj+fhVaxsO3336mpMvvn3jcUcO7uj9jy+dvtUB+z/4yPpnH0WilFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUioqiv8FYn1MTisVLCkAAAAASUVORK5CYII=', 1, '.', NULL, NULL, 'fernando2684@gmail.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, 63, 7, '2016-12-07 16:17:25', '2017-03-20 11:19:57', NULL),
	(2, 'FERNANDO ARDILA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fernando26842@gmail.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, 63, 7, '2016-12-07 17:19:15', '2016-12-07 17:19:15', NULL),
	(6, 'seguros delima', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '.', NULL, NULL, 'fernando26841234@gmail.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, 63, 7, '2017-03-22 21:22:54', '2017-03-22 21:22:54', NULL),
	(7, 'negocio eliminar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '.', NULL, NULL, 'example@text.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, 63, 7, '2017-03-22 21:34:50', '2017-03-22 21:34:50', NULL),
	(8, 'mi negocio sr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '.', NULL, NULL, 'test@test.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, 63, 7, '2017-03-22 21:55:18', '2017-03-22 21:55:18', NULL),
	(9, 'mi negocio sr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '.', NULL, NULL, 'test2@test.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, 63, 7, '2017-03-22 22:01:19', '2017-03-22 22:01:19', NULL),
	(10, 'asjasgh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '.', NULL, NULL, 'test3@gmail.com', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 7, 14, 30, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, b'0', b'0', NULL, NULL, 'R', b'1', NULL, NULL, 63, 7, '2017-03-22 22:02:02', '2017-03-22 22:02:02', NULL);
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
  `account_id` int(11),
  `user_id` int(11),
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
) ENGINE=InnoDB AUTO_INCREMENT=697 DEFAULT CHARSET=latin1 COMMENT='stores the log for each transaction made by any user';

-- Volcando datos para la tabla krece.activity_log: ~551 rows (aproximadamente)
DELETE FROM `activity_log`;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` (`id`, `account_id`, `user_id`, `created_at`, `detail`, `route`, `model`, `process_type`) VALUES
	(12, 1, 1, '2017-02-13 12:20:49', '5000', 'route link', 'Estimate', 'Update'),
	(13, 1, 1, '2017-02-13 12:22:35', 'detail', '/estimate/32', 'Estimate', 'Update'),
	(14, 1, 1, '2017-02-13 12:26:00', 'Se actualizó la cotización número32 del cliente cliente 2', '/estimate/32', 'Estimate', 'Update'),
	(15, 1, 1, '2017-02-13 12:37:40', 'Se actualizó la cotización número32 para el cliente cliente 2', '/estimate/32', 'Estimate', 'Update'),
	(16, 1, 1, '2017-02-13 12:40:26', 'Se actualizó la cotización número32 para el cliente cliente 2', '/estimate/32', 'Estimate', 'Update'),
	(17, 1, 1, '2017-02-13 12:40:27', 'Se creó la cotización número32 para el cliente cliente 2', '/estimate/32', 'Estimate', 'Create'),
	(18, 1, 1, '2017-02-13 12:54:33', 'Fernando acaba ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(19, 1, 1, '2017-02-13 12:56:13', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(20, 1, 1, '2017-02-13 13:01:15', 'Se actualizó la remisión número2 para el cliente cliente 2', '/remision/2', 'Remision', 'Update'),
	(21, 1, 1, '2017-02-13 13:06:19', 'Se actualizó la remisión número: 2 para el cliente cliente 2', '/remision/2', 'Remision', 'Update'),
	(22, 1, 1, '2017-02-13 13:13:16', 'Se actualizó la remisión número: 2 para el cliente cliente 2', '/remision/2', 'Remision', 'Update'),
	(23, 1, 1, '2017-02-13 13:19:59', 'Se ha generado el pdf de la remision No: 3', '/remision/3/pdf', 'Remision', 'Create'),
	(24, 1, 1, '2017-02-13 13:21:37', 'Se eliminó la remisión número: 2', NULL, 'Remision', 'Delete'),
	(25, 1, 1, '2017-02-14 14:11:36', 'Se creó la factura de venta número: 2 para el cliente cliente 2', '/invoice/1', 'InvoiceSaleOrder', 'Create'),
	(26, 1, 1, '2017-02-14 14:18:36', 'Se actualizó la remisión número: 1 para el cliente cliente 2', '/invoice/1', 'InvoiceSaleOrder', 'Update'),
	(27, 1, 1, '2017-02-14 14:18:56', 'Se actualizó la remisión número: 1 para el cliente cliente 2', '/invoice/1', 'InvoiceSaleOrder', 'Update'),
	(28, 1, 1, '2017-02-14 14:22:03', 'Se creó la factura de venta número: 3 para el cliente cliente 1', '/invoice/2', 'InvoiceSaleOrder', 'Create'),
	(29, 1, 1, '2017-02-14 15:23:31', 'Se eliminó la remisión número: 1', NULL, 'InvoiceSaleOrder', 'Delete'),
	(30, 1, 1, '2017-02-14 15:28:09', 'Se creó la factura de venta número: 4 para el cliente cliente 2', '/invoice/3', 'InvoiceSaleOrder', 'Create'),
	(31, 1, 1, '2017-02-14 15:28:22', 'Se creó la factura de venta número: 5 para el cliente cliente 2', '/invoice/4', 'InvoiceSaleOrder', 'Create'),
	(32, 1, 1, '2017-02-14 15:52:13', 'Se actualizó el estado de la factura de venta número: 4 para el cliente cliente 2', '/invoice/3', 'InvoiceSaleOrder', 'Update'),
	(33, 1, 1, '2017-02-14 15:52:15', 'Se actualizó el estado de la factura de venta número: 3 para el cliente cliente 1', '/invoice/2', 'InvoiceSaleOrder', 'Update'),
	(34, 1, 1, '2017-02-14 15:52:18', 'Se actualizó el estado de la factura de venta número: 4 para el cliente cliente 2', '/invoice/3', 'InvoiceSaleOrder', 'Update'),
	(35, 1, 1, '2017-02-14 15:53:00', 'Se actualizó el estado de la factura de venta número: 3 para el cliente cliente 1', '/invoice/2', 'InvoiceSaleOrder', 'Update'),
	(36, 1, 1, '2017-02-14 16:38:54', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(37, 1, 1, '2017-02-14 16:39:53', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(38, 1, 1, '2017-02-14 16:40:10', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(39, 1, 1, '2017-02-14 16:40:34', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(40, 1, 1, '2017-02-14 16:40:47', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(41, 1, 1, '2017-02-14 16:41:00', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(42, 1, 1, '2017-02-14 16:41:20', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(43, 1, 1, '2017-02-14 16:41:32', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(44, 1, 1, '2017-02-14 16:41:37', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(45, 1, 1, '2017-02-14 16:42:04', 'Se ha impreso el pdf de la factura de venta No: 5', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(46, 1, 1, '2017-02-14 16:44:16', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/4', 'InvoiceSaleOrder', 'Update'),
	(47, 1, 1, '2017-02-14 16:44:18', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(48, 1, 1, '2017-02-14 16:44:52', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(49, 1, 1, '2017-02-14 16:45:10', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(50, 1, 1, '2017-02-14 16:48:14', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(51, 1, 1, '2017-02-14 16:48:36', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(52, 1, 1, '2017-02-14 16:49:24', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(53, 1, 1, '2017-02-14 16:50:49', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(54, 1, 1, '2017-02-14 16:51:14', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(55, 1, 1, '2017-02-14 16:51:35', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(56, 1, 1, '2017-02-14 16:52:01', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(57, 1, 1, '2017-02-14 16:52:31', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(58, 1, 1, '2017-02-14 16:54:19', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(59, 1, 1, '2017-02-14 16:54:42', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(60, 1, 1, '2017-02-14 16:55:11', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(61, 1, 1, '2017-02-14 16:56:20', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(62, 1, 1, '2017-02-14 16:56:48', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(63, 1, 1, '2017-02-14 16:56:57', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(64, 1, 1, '2017-02-14 16:57:29', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(65, 1, 1, '2017-02-14 16:57:46', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(66, 1, 1, '2017-02-14 17:00:02', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(67, 1, 1, '2017-02-14 17:18:48', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/4', 'InvoiceSaleOrder', 'Print'),
	(68, 1, 1, '2017-02-14 17:22:55', 'Se creó la factura de venta número: 6 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Create'),
	(69, 1, 1, '2017-02-14 17:24:15', 'Se actualizó la factura de venta número: 1 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(70, 1, 1, '2017-02-14 17:26:14', 'Se creó la factura de venta número: 7 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Create'),
	(71, 1, 1, '2017-02-14 17:38:00', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(72, 1, 1, '2017-02-14 17:44:39', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(73, 1, 1, '2017-02-14 18:08:17', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(74, 1, 1, '2017-02-14 18:09:21', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(75, 1, 1, '2017-02-14 18:11:11', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(76, 1, 1, '2017-02-14 18:12:17', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(77, 1, 1, '2017-02-14 18:18:59', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(78, 1, 1, '2017-02-14 18:20:32', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(79, 1, 1, '2017-02-14 18:35:59', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(80, 1, 1, '2017-02-14 19:19:57', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(81, 1, 1, '2017-02-14 19:49:36', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(82, 1, 1, '2017-02-14 19:50:17', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(83, 1, 1, '2017-02-14 19:51:09', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(84, 1, 1, '2017-02-14 19:51:19', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(85, 1, 1, '2017-02-14 19:51:53', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(86, 1, 1, '2017-02-14 19:52:06', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(87, 1, 1, '2017-02-14 20:05:33', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(88, 1, 1, '2017-02-14 20:06:39', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(89, 1, 1, '2017-02-14 20:07:41', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(90, 1, 1, '2017-02-14 20:10:04', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(91, 1, 1, '2017-02-14 20:10:32', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(92, 1, 1, '2017-02-14 20:10:53', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(93, 1, 1, '2017-02-14 20:11:09', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(94, 1, 1, '2017-02-14 20:11:26', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(95, 1, 1, '2017-02-14 20:11:45', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(96, 1, 1, '2017-02-14 20:11:56', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(97, 1, 1, '2017-02-14 20:13:49', 'Se ha impreso el pdf de la factura de venta No: 1', '/invoice/6', 'InvoiceSaleOrder', 'Print'),
	(98, 1, 1, '2017-02-15 09:42:06', 'Se actualizó el estado de la remisión número: 1 para el cliente cliente 2', '/remision/1', 'Remision', 'Update'),
	(99, 1, 1, '2017-02-15 09:42:08', 'Se actualizó el estado de la remisión número: 1 para el cliente cliente 2', '/remision/1', 'Remision', 'Update'),
	(100, 1, 1, '2017-02-15 09:42:10', 'Se actualizó el estado de la remisión número: 3 para el cliente Fernando Ardila', '/remision/3', 'Remision', 'Update'),
	(101, 1, 1, '2017-02-15 10:16:28', 'Se creó la factura de venta número: 8 para el cliente cliente 2', '/invoice/7', 'InvoiceSaleOrder', 'Create'),
	(102, 1, 1, '2017-02-15 10:16:32', 'Se ha impreso el pdf de la factura de venta No: 8', '/invoice/7', 'InvoiceSaleOrder', 'Print'),
	(103, 1, 1, '2017-02-15 12:28:37', 'Se creó la Nota Crédito número: 1 para el cliente cliente 2', '/credit-note/1', 'CreditNote', 'Create'),
	(104, 1, 1, '2017-02-15 12:35:23', 'Se actualizó la factura de venta número: 1 para el cliente cliente 2', '/invoice/7', 'InvoiceSaleOrder', 'Update'),
	(105, 1, 1, '2017-02-15 13:02:54', 'Se actualizó la Nota Crédito número: 1 para el cliente cliente 2', '/credit-note/1', 'CreditNote', 'Update'),
	(106, 1, 1, '2017-02-15 13:23:42', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(107, 1, 1, '2017-02-15 13:24:05', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(108, 1, 1, '2017-02-15 13:24:22', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(109, 1, 1, '2017-02-15 13:24:35', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(110, 1, 1, '2017-02-15 13:26:03', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(111, 1, 1, '2017-02-15 13:27:47', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(112, 1, 1, '2017-02-15 13:28:10', 'Se creó la Nota Crédito número: 2 para el cliente cliente 2', '/credit-note/2', 'CreditNote', 'Create'),
	(113, 1, 1, '2017-02-16 20:39:08', 'Se creó el pago número: 2 para el cliente cliente 1', '/payment/2', 'Payment', 'Create'),
	(114, 1, 1, '2017-02-16 20:41:30', 'Se creó el pago número: 3 para el cliente cliente 2', '/payment/3', 'Payment', 'Create'),
	(115, 1, 1, '2017-02-16 21:08:25', 'Se creó el pago número: 4 para el cliente cliente 2', '/payment/1', 'Payment', 'Create'),
	(116, 1, 1, '2017-02-16 21:09:46', 'Se creó el pago número: 5 para el cliente cliente 2', '/payment/2', 'Payment', 'Create'),
	(117, 1, 1, '2017-02-16 21:21:50', 'Se creó el pago número: 6 para el cliente cliente 2', '/payment/3', 'Payment', 'Create'),
	(118, 1, 1, '2017-02-16 21:22:36', 'Se creó el pago número: 7 para el cliente cliente 2', '/payment/4', 'Payment', 'Create'),
	(119, 1, 1, '2017-02-17 09:59:35', 'Se creó el pago número: 8 para el cliente cliente 1', '/payment/5', 'Payment', 'Create'),
	(120, 1, 1, '2017-02-17 10:05:44', 'Se creó el pago número: 9 para el cliente cliente 1', '/payment/6', 'Payment', 'Create'),
	(121, 1, 1, '2017-02-17 11:26:44', 'Se creó el pago número: 10 para el cliente cliente 1', '/payment/11', 'Payment', 'Create'),
	(122, 1, 1, '2017-02-17 11:59:58', 'Se creó el pago número: 12 para el cliente cliente 2', '/payment/12', 'Payment', 'Create'),
	(123, 1, 1, '2017-02-17 13:49:13', 'Se creó el pago número: 13 para el cliente cliente 1', '/payment/13', 'Payment', 'Create'),
	(124, 1, 1, '2017-02-17 15:29:28', 'Se creó el pago número: 14 para el cliente cliente 1', '/payment/14', 'Payment', 'Create'),
	(125, 1, 1, '2017-02-17 16:11:53', 'Se actualizó el pago número: 14 para el cliente cliente 1', '/payment/14', 'Payment', 'Update'),
	(126, 1, 1, '2017-02-17 16:12:50', 'Se actualizó el pago número: 14 para el cliente cliente 1', '/payment/14', 'Payment', 'Update'),
	(127, 1, 1, '2017-02-17 16:13:14', 'Se actualizó el pago número: 14 para el cliente cliente 1', '/payment/14', 'Payment', 'Update'),
	(128, 1, 1, '2017-02-17 16:23:49', 'Se creó la factura de venta número: 8 para el cliente distribuciones IDRD', '/invoice/8', 'InvoiceSaleOrder', 'Create'),
	(129, 1, 1, '2017-02-17 16:25:50', 'Se creó el pago número: 15 para el cliente distribuciones IDRD', '/payment/15', 'Payment', 'Create'),
	(130, 1, 1, '2017-02-17 16:27:07', 'Se actualizó el pago número: 15 para el cliente distribuciones IDRD', '/payment/15', 'Payment', 'Update'),
	(131, 1, 1, '2017-02-17 16:28:47', 'Se actualizó el pago número: 15 para el cliente distribuciones IDRD', '/payment/15', 'Payment', 'Update'),
	(132, 1, 1, '2017-02-17 16:31:25', 'Se creó la factura de venta número: 9 para el cliente distribuciones IDRD', '/invoice/9', 'InvoiceSaleOrder', 'Create'),
	(133, 1, 1, '2017-02-17 16:34:29', 'Se creó el pago número: 16 para el cliente distribuciones IDRD', '/payment/16', 'Payment', 'Create'),
	(134, 1, 1, '2017-02-17 17:13:02', 'Se actualizó el pago número: 16 para el cliente distribuciones IDRD', '/payment/16', 'Payment', 'Update'),
	(135, 1, 1, '2017-02-17 18:13:08', 'Se eliminó el pago número: 14', NULL, 'Payment', 'Delete'),
	(136, 1, 1, '2017-02-17 18:38:40', 'Se eliminó el pago número: 14', NULL, 'Payment', 'Delete'),
	(137, 1, 1, '2017-02-20 15:05:57', 'Se actualizó la factura de venta número: 1 para el cliente distribuciones IDRD', '/invoice/8', 'InvoiceSaleOrder', 'Update'),
	(138, 1, 1, '2017-02-20 19:06:14', 'Se creó la factura de venta número: 10 para el cliente cliente 2', '/invoice/10', 'InvoiceSaleOrder', 'Create'),
	(139, 1, 1, '2017-02-21 19:37:24', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(140, 1, 1, '2017-02-22 13:30:50', 'Se creó la factura de venta número: 11 para el cliente cliente 1', '/invoice/11', 'InvoiceSaleOrder', 'Create'),
	(141, 1, 1, '2017-02-22 21:20:17', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(142, 1, 1, '2017-02-23 12:01:06', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(143, 1, 1, '2017-02-23 18:12:19', 'Se creó la Orden de Compra número: 1 para el cliente Proveedor 1', '/purchase-order/1', 'PurchaseOrder', 'Create'),
	(144, 1, 1, '2017-02-23 19:09:38', 'Se actualizó la Orden de Compra número: 1 para el cliente Proveedor 1', '/purchase-order/1', 'PurchaseOrder', 'Update'),
	(145, 1, 1, '2017-02-23 19:25:03', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(146, 1, 1, '2017-02-23 19:25:21', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(147, 1, 1, '2017-02-23 19:25:32', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(148, 1, 1, '2017-02-23 19:26:21', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(149, 1, 1, '2017-02-23 19:26:41', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(150, 1, 1, '2017-02-23 19:27:34', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(151, 1, 1, '2017-02-24 07:05:41', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(152, 1, 1, '2017-02-24 12:26:55', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(153, 1, 1, '2017-02-24 12:27:10', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(154, 1, 1, '2017-02-24 12:37:42', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(155, 1, 1, '2017-02-24 12:38:16', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(156, 1, 1, '2017-02-24 12:39:03', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(157, 1, 1, '2017-02-24 12:39:33', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(158, 1, 1, '2017-02-24 12:39:51', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(159, 1, 1, '2017-02-24 12:41:06', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(160, 1, 1, '2017-02-24 12:41:29', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(161, 1, 1, '2017-02-24 12:42:33', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(162, 1, 1, '2017-02-24 12:42:47', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(163, 1, 1, '2017-02-24 12:43:01', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(164, 1, 1, '2017-02-24 12:43:16', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(165, 1, 1, '2017-02-24 12:44:12', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(166, 1, 1, '2017-02-24 12:45:01', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(167, 1, 1, '2017-02-24 12:45:12', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(168, 1, 1, '2017-02-24 12:45:30', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(169, 1, 1, '2017-02-24 12:45:39', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(170, 1, 1, '2017-02-24 12:45:51', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(171, 1, 1, '2017-02-24 12:47:39', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(172, 1, 1, '2017-02-24 12:47:57', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(173, 1, 1, '2017-02-24 12:48:23', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(174, 1, 1, '2017-02-24 12:48:44', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(175, 1, 1, '2017-02-24 12:49:01', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(176, 1, 1, '2017-02-24 12:49:42', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(177, 1, 1, '2017-02-24 12:50:37', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(178, 1, 1, '2017-02-24 12:51:36', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(179, 1, 1, '2017-02-24 12:52:10', 'Se actualizó la Orden de Compra número: 1 para el cliente Proveedor 1', '/purchase-order/1', 'PurchaseOrder', 'Update'),
	(180, 1, 1, '2017-02-24 12:52:17', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(181, 1, 1, '2017-02-24 12:52:41', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(182, 1, 1, '2017-02-24 12:53:29', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(183, 1, 1, '2017-02-24 12:54:09', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(184, 1, 1, '2017-02-24 12:54:35', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(185, 1, 1, '2017-02-24 12:54:55', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(186, 1, 1, '2017-02-24 12:55:17', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(187, 1, 1, '2017-02-24 12:55:24', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(188, 1, 1, '2017-02-24 12:55:37', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(189, 1, 1, '2017-02-24 12:55:49', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(190, 1, 1, '2017-02-24 12:56:37', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(191, 1, 1, '2017-02-24 12:57:46', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(192, 1, 1, '2017-02-24 12:58:40', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(193, 1, 1, '2017-02-24 12:58:55', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(194, 1, 1, '2017-02-24 13:00:04', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(195, 1, 1, '2017-02-24 13:00:15', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(196, 1, 1, '2017-02-24 13:00:30', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(197, 1, 1, '2017-02-24 13:00:51', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(198, 1, 1, '2017-02-24 13:00:58', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(199, 1, 1, '2017-02-24 13:01:15', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(200, 1, 1, '2017-02-24 13:01:25', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(201, 1, 1, '2017-02-24 13:01:35', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(202, 1, 1, '2017-02-24 13:01:46', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(203, 1, 1, '2017-02-24 13:02:07', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(204, 1, 1, '2017-02-24 13:02:15', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(205, 1, 1, '2017-02-24 13:02:25', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(206, 1, 1, '2017-02-24 13:02:43', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(207, 1, 1, '2017-02-24 13:03:48', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(208, 1, 1, '2017-02-24 13:04:03', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(209, 1, 1, '2017-02-24 13:04:14', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(210, 1, 1, '2017-02-24 13:04:30', 'Se actualizó la Orden de Compra número: 1 para el cliente Proveedor 1', '/purchase-order/1', 'PurchaseOrder', 'Update'),
	(211, 1, 1, '2017-02-24 13:04:33', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(212, 1, 1, '2017-02-24 13:04:50', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(213, 1, 1, '2017-02-24 13:05:38', 'Se actualizó la Orden de Compra número: 1 para el cliente Proveedor 1', '/purchase-order/1', 'PurchaseOrder', 'Update'),
	(214, 1, 1, '2017-02-24 13:05:41', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(215, 1, 1, '2017-02-24 13:06:02', 'Se actualizó la Orden de Compra número: 1 para el cliente Proveedor 1', '/purchase-order/1', 'PurchaseOrder', 'Update'),
	(216, 1, 1, '2017-02-24 13:06:05', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(217, 1, 1, '2017-02-24 13:06:32', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(218, 1, 1, '2017-02-24 13:06:43', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(219, 1, 1, '2017-02-24 13:10:27', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(220, 1, 1, '2017-02-24 13:11:15', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(221, 1, 1, '2017-02-24 13:12:04', 'Se ha impreso el pdf de la Orden de Compra No: 1', '/purchase-order/1', 'PurchaseOrder', 'Print'),
	(222, 1, 1, '2017-02-24 15:12:13', 'Se creó la Nota Débito número: 1 para el cliente Proveedor 1', '/debit-note/1', 'DebitNote', 'Create'),
	(223, 1, 1, '2017-02-24 15:24:48', 'Se actualizó la Nota Debito número: 1 para el cliente Proveedor 1', '/debit-note/1', 'DebitNote', 'Update'),
	(224, 1, 1, '2017-02-24 15:26:14', 'Se actualizó la Nota Debito número: 1 para el cliente Proveedor 1', '/debit-note/1', 'DebitNote', 'Update'),
	(225, 1, 1, '2017-02-24 15:26:36', 'Se actualizó la Nota Debito número: 1 para el cliente Proveedor 1', '/debit-note/1', 'DebitNote', 'Update'),
	(226, 1, 1, '2017-02-24 15:27:10', 'Se actualizó la Nota Debito número: 1 para el cliente Proveedor 1', '/debit-note/1', 'DebitNote', 'Update'),
	(227, 1, 1, '2017-02-24 15:27:33', 'Se actualizó la Nota Debito número: 1 para el cliente Proveedor 1', '/debit-note/1', 'DebitNote', 'Update'),
	(228, 1, 1, '2017-02-24 15:28:39', 'Se creó la Nota Débito número: 2 para el cliente Fernando Ardila', '/debit-note/2', 'DebitNote', 'Create'),
	(229, 1, 1, '2017-02-24 15:38:26', 'Se ha impreso el pdf de la Nota Débito No: 1', '/debit-note/1', 'DebitNote', 'Print'),
	(230, 1, 1, '2017-02-24 15:39:06', 'Se ha impreso el pdf de la Nota Débito No: 1', '/debit-note/1', 'DebitNote', 'Print'),
	(231, 1, 1, '2017-02-24 17:13:48', 'Se creó la factura de proveedor número: 1 para el cliente Proveedor 1', '/bill/1', 'Bill', 'Create'),
	(232, 1, 1, '2017-02-24 17:25:46', 'Se actualizó la factura de proveedores número: 1 para el cliente Proveedor 1', '/bill/1', 'Bill', 'Update'),
	(233, 1, 1, '2017-02-24 17:28:37', 'Se actualizó la factura de proveedores número: 1 para el cliente Proveedor 1', '/bill/1', 'Bill', 'Update'),
	(234, 1, 1, '2017-02-24 17:29:02', 'Se actualizó la factura de proveedores número: 1 para el cliente Proveedor 1', '/bill/1', 'Bill', 'Update'),
	(235, 1, 1, '2017-02-24 18:15:40', 'Se ha impreso el pdf de la factura de venta No: 1', '/bill/1', 'Bill', 'Print'),
	(236, 1, 1, '2017-02-24 18:16:11', 'Se ha impreso el pdf de la factura de venta No: 1', '/bill/1', 'Bill', 'Print'),
	(237, 1, 1, '2017-02-24 18:16:30', 'Se ha impreso el pdf de la factura de venta No: 1', '/bill/1', 'Bill', 'Print'),
	(238, 1, 1, '2017-02-24 18:17:06', 'Se actualizó la factura de proveedores número: 1 para el cliente Proveedor 1', '/bill/1', 'Bill', 'Update'),
	(239, 1, 1, '2017-02-24 18:17:08', 'Se ha impreso el pdf de la factura de venta No: 1', '/bill/1', 'Bill', 'Print'),
	(240, 1, 1, '2017-02-24 18:17:23', 'Se ha impreso el pdf de la factura de venta No: 1', '/bill/1', 'Bill', 'Print'),
	(241, 1, 1, '2017-02-24 18:22:39', 'Se creó la factura de proveedor número: 2 para el cliente Proveedor 1', '/bill/2', 'Bill', 'Create'),
	(242, 1, 1, '2017-02-24 18:23:11', 'Se ha impreso el pdf de la factura de venta No: 2', '/bill/2', 'Bill', 'Print'),
	(243, 1, 1, '2017-02-24 18:26:58', 'Se actualizó el estado de la factura de venta número: 2 para el cliente Proveedor 1', '/bill/2', 'Bill', 'Update'),
	(244, 1, 1, '2017-02-24 18:27:38', 'Se actualizó el estado de la factura de venta número: 1 para el cliente Proveedor 1', '/bill/1', 'Bill', 'Update'),
	(245, 1, 1, '2017-02-24 18:27:40', 'Se actualizó el estado de la factura de venta número: 2 para el cliente Proveedor 1', '/bill/2', 'Bill', 'Update'),
	(246, 1, 1, '2017-02-24 18:27:42', 'Se actualizó el estado de la factura de venta número: 1 para el cliente Proveedor 1', '/bill/1', 'Bill', 'Update'),
	(247, 1, 1, '2017-02-24 18:28:20', 'Se eliminó la factura de venta número: 1', NULL, 'Bill', 'Delete'),
	(248, 1, 1, '2017-02-24 18:28:25', 'Se actualizó el estado de la factura de venta número: 2 para el cliente Proveedor 1', '/bill/2', 'Bill', 'Update'),
	(249, 1, 1, '2017-02-24 18:28:28', 'Se actualizó el estado de la factura de venta número: 2 para el cliente Proveedor 1', '/bill/2', 'Bill', 'Update'),
	(250, 1, 1, '2017-02-24 18:49:46', 'Se creó la factura de proveedor número: 3 para el cliente proveedor 5', '/bill/3', 'Bill', 'Create'),
	(251, 1, 1, '2017-02-24 20:09:26', 'Se creó la factura de venta número: 12 para el cliente cliente 1', '/invoice/12', 'InvoiceSaleOrder', 'Create'),
	(252, 1, 1, '2017-02-27 16:20:44', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(253, 1, 1, '2017-02-27 17:34:30', 'Se creó la factura de venta número: 13 para el cliente cliente 1', '/invoice/13', 'InvoiceSaleOrder', 'Create'),
	(254, 1, 1, '2017-02-27 21:48:15', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(255, 1, 1, '2017-02-27 21:49:09', 'Se creó la factura de venta número: 14 para el cliente cliente 1', '/invoice/14', 'InvoiceSaleOrder', 'Create'),
	(256, 1, 1, '2017-02-27 21:53:09', 'Se actualizó la factura de venta número: 1 para el cliente cliente 1', '/invoice/14', 'InvoiceSaleOrder', 'Update'),
	(257, 1, 1, '2017-02-27 21:57:42', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(258, 1, 1, '2017-02-28 10:14:20', 'Se creó la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Create'),
	(259, 1, 1, '2017-02-28 10:31:18', 'Se creó la factura de proveedor número: 4 para el cliente contact-provider', '/bill/4', 'Bill', 'Create'),
	(260, 1, 1, '2017-02-28 11:53:53', 'Se creó el comprobante de pago número: 1 para el proveedor contact-provider', '/payment-out/17', 'Payment-out', 'Create'),
	(261, 1, 1, '2017-02-28 11:54:32', 'Se creó el comprobante de pago número: 1 para el proveedor contact-provider', '/payment-out/17', 'Payment-out', 'Create'),
	(262, 1, 1, '2017-02-28 12:21:43', 'Se actualizó el comprobante de pago número: 1 para el cliente contact-provider', '/payment-out/17', 'Payment-out', 'Update'),
	(263, 1, 1, '2017-02-28 12:22:45', 'Se creó el comprobante de pago número: 4 para el proveedor contact-provider', '/payment-out/18', 'Payment-out', 'Create'),
	(264, 1, 1, '2017-02-28 18:36:33', 'Se creó el comprobante de pago número: 5 para el proveedor Proveedor 1', '/payment-out/19', 'Payment-out', 'Create'),
	(265, 1, 1, '2017-03-01 11:30:48', 'Se actualizó el comprobante de pago número: 5 para el cliente Proveedor 1', '/payment-out/19', 'Payment-out', 'Update'),
	(266, 1, 1, '2017-03-01 11:31:05', 'Se actualizó el comprobante de pago número: 5 para el cliente Proveedor 1', '/payment-out/19', 'Payment-out', 'Update'),
	(267, 1, 1, '2017-03-01 11:31:15', 'Se actualizó el comprobante de pago número: 5 para el cliente Proveedor 1', '/payment-out/19', 'Payment-out', 'Update'),
	(268, 1, 1, '2017-03-01 11:31:33', 'Se actualizó el comprobante de pago número: 5 para el cliente Proveedor 1', '/payment-out/19', 'Payment-out', 'Update'),
	(269, 1, 1, '2017-03-01 11:32:41', 'Se actualizó el comprobante de pago número: 5 para el cliente Proveedor 1', '/payment-out/19', 'Payment-out', 'Update'),
	(270, 1, 1, '2017-03-01 12:31:25', 'Se actualizó el comprobante de pago número: 5 para el cliente Proveedor 1', '/payment-out/19', 'Payment-out', 'Update'),
	(271, 1, 1, '2017-03-01 15:20:13', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment-out', 'Update'),
	(272, 1, 1, '2017-03-01 15:20:48', 'Se actualizó el estado del pago número: 4 para el cliente contact-provider', '/Payment-out/18', 'Payment-out', 'Update'),
	(273, 1, 1, '2017-03-01 15:20:50', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment-out', 'Update'),
	(274, 1, 1, '2017-03-01 15:20:51', 'Se actualizó el estado del pago número: 4 para el cliente contact-provider', '/Payment-out/18', 'Payment-out', 'Update'),
	(275, 1, 1, '2017-03-01 15:21:18', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment-out', 'Update'),
	(276, 1, 1, '2017-03-01 16:17:27', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(277, 1, 1, '2017-03-01 16:19:23', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(278, 1, 1, '2017-03-01 16:20:23', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(279, 1, 1, '2017-03-01 16:20:32', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(280, 1, 1, '2017-03-01 16:21:39', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(281, 1, 1, '2017-03-01 16:25:19', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(282, 1, 1, '2017-03-01 16:28:45', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(283, 1, 1, '2017-03-01 16:28:58', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(284, 1, 1, '2017-03-01 16:29:25', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(285, 1, 1, '2017-03-01 16:30:48', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(286, 1, 1, '2017-03-01 16:31:03', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(287, 1, 1, '2017-03-01 16:31:28', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(288, 1, 1, '2017-03-01 16:31:43', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(289, 1, 1, '2017-03-01 16:32:25', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(290, 1, 1, '2017-03-01 16:33:09', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(291, 1, 1, '2017-03-01 16:33:29', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(292, 1, 1, '2017-03-01 16:34:28', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(293, 1, 1, '2017-03-01 16:34:37', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(294, 1, 1, '2017-03-01 16:34:52', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(295, 1, 1, '2017-03-01 16:41:08', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(296, 1, 1, '2017-03-01 16:41:28', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(297, 1, 1, '2017-03-01 17:43:17', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(298, 1, 1, '2017-03-01 17:43:48', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(299, 1, 1, '2017-03-01 17:44:05', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(300, 1, 1, '2017-03-01 17:45:15', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(301, 1, 1, '2017-03-01 17:48:57', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(302, 1, 1, '2017-03-01 17:49:10', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(303, 1, 1, '2017-03-01 17:49:20', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(304, 1, 1, '2017-03-01 17:49:40', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(305, 1, 1, '2017-03-01 17:49:53', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(306, 1, 1, '2017-03-01 17:50:03', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(307, 1, 1, '2017-03-01 17:50:27', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(308, 1, 1, '2017-03-01 17:51:06', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(309, 1, 1, '2017-03-01 17:51:21', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(310, 1, 1, '2017-03-01 17:51:30', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(311, 1, 1, '2017-03-01 17:51:41', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(312, 1, 1, '2017-03-01 17:51:56', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(313, 1, 1, '2017-03-01 17:52:12', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(314, 1, 1, '2017-03-01 17:52:20', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(315, 1, 1, '2017-03-01 17:52:31', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(316, 1, 1, '2017-03-01 17:52:45', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(317, 1, 1, '2017-03-01 17:52:57', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(318, 1, 1, '2017-03-01 17:53:14', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(319, 1, 1, '2017-03-01 17:53:29', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(320, 1, 1, '2017-03-01 17:53:42', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(321, 1, 1, '2017-03-01 17:56:36', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(322, 1, 1, '2017-03-01 17:56:45', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(323, 1, 1, '2017-03-01 17:57:19', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(324, 1, 1, '2017-03-01 17:57:35', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(325, 1, 1, '2017-03-01 17:58:01', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(326, 1, 1, '2017-03-01 17:58:55', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(327, 1, 1, '2017-03-01 17:59:08', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(328, 1, 1, '2017-03-01 17:59:20', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(329, 1, 1, '2017-03-01 17:59:34', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(330, 1, 1, '2017-03-01 18:04:04', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(331, 1, 1, '2017-03-01 18:04:25', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(332, 1, 1, '2017-03-01 18:04:48', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(333, 1, 1, '2017-03-01 18:05:42', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(334, 1, 1, '2017-03-01 18:05:52', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(335, 1, 1, '2017-03-01 18:06:17', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(336, 1, 1, '2017-03-01 18:06:31', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(337, 1, 1, '2017-03-01 18:06:41', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(338, 1, 1, '2017-03-01 18:06:51', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(339, 1, 1, '2017-03-01 18:07:09', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(340, 1, 1, '2017-03-01 18:07:23', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(341, 1, 1, '2017-03-01 18:08:21', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(342, 1, 1, '2017-03-01 18:09:20', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(343, 1, 1, '2017-03-01 18:09:31', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(344, 1, 1, '2017-03-01 18:09:38', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(345, 1, 1, '2017-03-01 18:10:22', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(346, 1, 1, '2017-03-01 18:10:30', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(347, 1, 1, '2017-03-01 18:10:43', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(348, 1, 1, '2017-03-01 18:10:51', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(349, 1, 1, '2017-03-01 18:12:05', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(350, 1, 1, '2017-03-01 18:12:35', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(351, 1, 1, '2017-03-01 18:12:59', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(352, 1, 1, '2017-03-01 18:13:37', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(353, 1, 1, '2017-03-01 18:16:13', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(354, 1, 1, '2017-03-01 18:16:37', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(355, 1, 1, '2017-03-01 18:16:46', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(356, 1, 1, '2017-03-01 18:17:03', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(357, 1, 1, '2017-03-01 18:17:17', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(358, 1, 1, '2017-03-01 18:18:58', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(359, 1, 1, '2017-03-01 18:19:14', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(360, 1, 1, '2017-03-01 18:19:21', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(361, 1, 1, '2017-03-01 18:20:14', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(362, 1, 1, '2017-03-01 18:22:01', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(363, 1, 1, '2017-03-01 18:26:44', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(364, 1, 1, '2017-03-01 18:30:47', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(365, 1, 1, '2017-03-01 18:34:04', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(366, 1, 1, '2017-03-01 18:34:56', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(367, 1, 1, '2017-03-01 18:35:46', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(368, 1, 1, '2017-03-01 18:37:26', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(369, 1, 1, '2017-03-01 18:40:29', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(370, 1, 1, '2017-03-01 18:43:23', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(371, 1, 1, '2017-03-01 18:45:47', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(372, 1, 1, '2017-03-01 18:46:02', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(373, 1, 1, '2017-03-01 18:46:17', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(374, 1, 1, '2017-03-01 18:47:52', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(375, 1, 1, '2017-03-01 18:48:09', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(376, 1, 1, '2017-03-01 18:48:22', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(377, 1, 1, '2017-03-01 18:48:40', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(378, 1, 1, '2017-03-01 18:49:24', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(379, 1, 1, '2017-03-01 18:49:54', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(380, 1, 1, '2017-03-01 18:55:35', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment-out', 'Update'),
	(381, 1, 1, '2017-03-01 18:56:25', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(382, 1, 1, '2017-03-01 19:19:17', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(383, 1, 1, '2017-03-01 19:20:41', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(384, 1, 1, '2017-03-01 19:21:05', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(385, 1, 1, '2017-03-01 19:53:42', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(386, 1, 1, '2017-03-01 19:54:06', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(387, 1, 1, '2017-03-01 19:55:12', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(388, 1, 1, '2017-03-01 19:55:41', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(389, 1, 1, '2017-03-01 19:55:51', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(390, 1, 1, '2017-03-01 20:01:18', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(391, 1, 1, '2017-03-01 20:01:28', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(392, 1, 1, '2017-03-01 20:03:54', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(393, 1, 1, '2017-03-01 21:13:35', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(394, 1, 1, '2017-03-01 21:17:27', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(395, 1, 1, '2017-03-01 21:18:01', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(396, 1, 1, '2017-03-02 08:34:28', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(397, 1, 1, '2017-03-02 08:40:58', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(398, 1, 1, '2017-03-02 09:55:26', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(399, 1, 1, '2017-03-02 09:55:35', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(400, 1, 1, '2017-03-02 09:56:04', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(401, 1, 1, '2017-03-02 09:57:28', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(402, 1, 1, '2017-03-02 09:59:07', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(403, 1, 1, '2017-03-02 10:03:36', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(404, 1, 1, '2017-03-02 10:04:39', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(405, 1, 1, '2017-03-02 10:04:52', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(406, 1, 1, '2017-03-02 10:05:46', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(407, 1, 1, '2017-03-02 10:05:59', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(408, 1, 1, '2017-03-02 10:07:21', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(409, 1, 1, '2017-03-02 10:08:23', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(410, 1, 1, '2017-03-02 10:10:52', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(411, 1, 1, '2017-03-02 10:11:27', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(412, 1, 1, '2017-03-02 10:11:34', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(413, 1, 1, '2017-03-02 10:11:40', 'Se ha impreso el pdf para el pago No: 4', '/Payment-out/18', 'Payment-out', 'Print'),
	(414, 1, 1, '2017-03-02 10:11:47', 'Se ha impreso el pdf para el pago No: 1', '/Payment-out/17', 'Payment-out', 'Print'),
	(415, 1, 1, '2017-03-02 10:11:55', 'Se ha impreso el pdf para el pago No: 16', '/Payment-out/16', 'Payment-out', 'Print'),
	(416, 1, 1, '2017-03-02 10:12:59', 'Se ha impreso el pdf para el pago No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(417, 1, 1, '2017-03-02 10:13:05', 'Se ha impreso el pdf para el pago No: 4', '/Payment-out/18', 'Payment-out', 'Print'),
	(418, 1, 1, '2017-03-02 10:14:41', 'Se ha impreso el pdf para el pago No: 4', '/Payment-out/18', 'Payment-out', 'Print'),
	(419, 1, 1, '2017-03-02 10:15:19', 'Se actualizó el estado del pago número: 4 para el cliente contact-provider', '/Payment-out/18', 'Payment-out', 'Update'),
	(420, 1, 1, '2017-03-02 10:15:22', 'Se ha impreso el pdf para el pago No: 4', '/Payment-out/18', 'Payment-out', 'Print'),
	(421, 1, 1, '2017-03-02 10:16:44', 'Se ha impreso el pdf para el pago No: 4', '/Payment-out/18', 'Payment-out', 'Print'),
	(422, 1, 1, '2017-03-02 10:19:02', 'Se ha impreso el pdf para el comprobante de egreso No: 4', '/Payment-out/18', 'Payment-out', 'Print'),
	(423, 1, 1, '2017-03-02 10:19:33', 'Se ha impreso el pdf para el comprobante de egreso No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(424, 1, 1, '2017-03-02 10:19:34', 'Se ha impreso el pdf para el comprobante de egreso No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(425, 1, 1, '2017-03-02 10:22:48', 'Se ha impreso el pdf para el comprobante de egreso No: 5', '/Payment-out/19', 'Payment-out', 'Print'),
	(426, 1, 1, '2017-03-02 15:21:40', 'Se ingresó el ingreso número: 17 para el cliente cliente 1', '/payment-in/20', 'Payment', 'Create'),
	(427, 1, 1, '2017-03-02 18:15:42', 'Se actualizó el pago número: 17 para el cliente cliente 1', '/payment/20', 'Payment', 'Update'),
	(428, 1, 1, '2017-03-02 18:16:14', 'Se actualizó el pago número: 17 para el cliente cliente 1', '/payment/20', 'Payment', 'Update'),
	(429, 1, 1, '2017-03-02 18:19:53', 'Se actualizó el pago número: 17 para el cliente cliente 1', '/payment/20', 'Payment', 'Update'),
	(430, 1, 1, '2017-03-02 18:20:51', 'Se actualizó el pago número: 17 para el cliente cliente 1', '/payment/20', 'Payment', 'Update'),
	(431, 1, 1, '2017-03-02 18:33:24', 'Se actualizó el pago número: 17 para el cliente cliente 1', '/payment/20', 'Payment', 'Update'),
	(432, 1, 1, '2017-03-02 18:55:02', 'Se actualizó el estado del pago número: 17 para el cliente cliente 1', '/Payment-in/20', 'Payment-in', 'Update'),
	(433, 1, 1, '2017-03-02 18:55:03', 'Se actualizó el estado del pago número: 17 para el cliente cliente 1', '/Payment-in/20', 'Payment-in', 'Update'),
	(434, 1, 1, '2017-03-02 18:55:05', 'Se actualizó el estado del pago número: 16 para el cliente distribuciones IDRD', '/Payment-in/16', 'Payment-in', 'Update'),
	(435, 1, 1, '2017-03-02 18:55:07', 'Se actualizó el estado del pago número: 16 para el cliente distribuciones IDRD', '/Payment-in/16', 'Payment-in', 'Update'),
	(436, 1, 1, '2017-03-02 19:17:38', 'Se ha impreso el pdf para el comprobante de ingreso No: 10', '/Payment-in/11', 'Payment-out', 'Print'),
	(437, 1, 1, '2017-03-02 19:41:40', 'Se ha impreso el pdf para el comprobante de ingreso No: 17', '/Payment-in/20', 'Payment-out', 'Print'),
	(438, 1, 1, '2017-03-02 19:47:22', 'Se ha impreso el pdf para el comprobante de ingreso No: 16', '/Payment-in/16', 'Payment-out', 'Print'),
	(439, 1, 1, '2017-03-02 19:48:17', 'Se ha impreso el pdf para el comprobante de ingreso No: 12', '/Payment-in/12', 'Payment-out', 'Print'),
	(440, 1, 1, '2017-03-03 10:31:19', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/test/19', 'Payment', 'Update'),
	(441, 1, 1, '2017-03-03 10:44:42', 'Se actualizó el estado del pago número: 4 para el cliente contact-provider', '/Payment-out/18', 'Payment', 'Update'),
	(442, 1, 1, '2017-03-03 10:44:43', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment', 'Update'),
	(443, 1, 1, '2017-03-03 10:44:45', 'Se actualizó el estado del pago número: 4 para el cliente contact-provider', '/Payment-out/18', 'Payment', 'Update'),
	(444, 1, 1, '2017-03-03 10:51:09', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment', 'Update'),
	(445, 1, 1, '2017-03-03 10:51:42', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment', 'Update'),
	(446, 1, 1, '2017-03-03 11:14:13', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment', 'Update'),
	(447, 1, 1, '2017-03-03 11:27:06', 'Se actualizó el estado del pago número: 5 para el cliente Proveedor 1', '/Payment-out/19', 'Payment', 'Update'),
	(448, 1, 1, '2017-03-03 11:32:04', 'Se actualizó el estado del pago número: 16 para el cliente distribuciones IDRD', '/Payment-in/16', 'Payment', 'Update'),
	(449, 1, 1, '2017-03-03 11:32:05', 'Se actualizó el estado del pago número: 16 para el cliente distribuciones IDRD', '/Payment-in/16', 'Payment', 'Update'),
	(450, 1, 1, '2017-03-03 14:03:23', 'Se creó el comprobante de pago número: 12 para el proveedor Proveedor 1', '/Payment-out/21', 'payment-out', 'Create'),
	(451, 1, 1, '2017-03-03 14:05:36', 'Se actualizó el comprobante de pago número: 12 para el cliente Proveedor 1', '/Payment-out/21', 'payment-out', 'Update'),
	(452, 1, 1, '2017-03-03 14:07:19', 'Se creó el comprobante de pago número: 13 para el proveedor Proveedor 1', '/Payment-out/22', 'payment-out', 'Create'),
	(453, 1, 1, '2017-03-03 14:16:56', 'Se creó el comprobante de pago número: 14 para el proveedor Proveedor 1', '/Payment-out/22', 'payment-out', 'Create'),
	(454, 1, 1, '2017-03-03 14:20:59', 'Se creó el comprobante de pago número: 14 para el proveedor Fernando Ardila', '/Payment-out/22', 'payment-out', 'Create'),
	(455, 1, 1, '2017-03-03 15:03:46', 'Se ha creado el ingreso número: 18 para el cliente cliente 1', '/payment-in/23', 'Payment', 'Create'),
	(456, 1, 1, '2017-03-03 14:40:29', 'Se eliminó el pago número: 18', NULL, 'Payment', 'Delete'),
	(457, 1, 1, '2017-03-03 14:42:11', 'Se eliminó el pago número: 4', NULL, 'Payment', 'Delete'),
	(458, 1, 1, '2017-03-03 15:03:40', 'Se creó el comprobante de pago número: 16 para el proveedor proveedor 5', '/payment-out/24', 'payment-out', 'Create'),
	(459, 1, 1, '2017-03-03 15:16:40', 'Se actualizó el estado de la factura de venta número: 4 para el cliente cliente 2', '/invoice/4', 'InvoiceSaleOrder', 'Update'),
	(460, 1, 1, '2017-03-03 15:16:43', 'Se actualizó el estado de la factura de venta número: 4 para el cliente cliente 2', '/invoice/4', 'InvoiceSaleOrder', 'Update'),
	(461, 1, 1, '2017-03-03 15:16:44', 'Se actualizó el estado de la factura de venta número: 4 para el cliente cliente 2', '/invoice/4', 'InvoiceSaleOrder', 'Update'),
	(462, 1, 1, '2017-03-03 15:19:07', 'Se actualizó el estado de la factura de venta número: 4 para el cliente cliente 2', '/invoice/4', 'InvoiceSaleOrder', 'Update'),
	(463, 1, 1, '2017-03-03 15:29:36', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(464, 1, 1, '2017-03-03 15:29:48', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(465, 1, 1, '2017-03-03 15:30:24', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(466, 1, 1, '2017-03-03 15:31:04', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(467, 1, 1, '2017-03-03 15:32:44', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(468, 1, 1, '2017-03-03 15:32:47', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(469, 1, 1, '2017-03-03 16:07:25', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(470, 1, 1, '2017-03-03 16:07:28', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(471, 1, 1, '2017-03-03 16:07:58', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(472, 1, 1, '2017-03-03 16:09:02', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(473, 1, 1, '2017-03-03 16:09:06', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(474, 1, 1, '2017-03-03 16:09:14', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(475, 1, 1, '2017-03-03 16:09:16', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(476, 1, 1, '2017-03-03 16:10:15', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(477, 1, 1, '2017-03-03 16:10:18', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(478, 1, 1, '2017-03-03 16:10:22', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(479, 1, 1, '2017-03-03 16:10:25', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(480, 1, 1, '2017-03-03 16:11:35', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(481, 1, 1, '2017-03-03 16:11:38', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(482, 1, 1, '2017-03-03 17:48:26', 'Se ha creado el ingreso número: 19 para el cliente contact-provider', '/payment-in/25', 'Payment', 'Create'),
	(483, 1, 1, '2017-03-03 17:49:32', 'Se actualizó el pago número: 19 para el cliente contact-provider', '/payment/25', 'Payment', 'Update'),
	(484, 1, 1, '2017-03-03 17:50:14', 'Se actualizó el pago número: 19 para el cliente contact-provider', '/payment/25', 'Payment', 'Update'),
	(485, 1, 1, '2017-03-03 18:12:13', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(486, 1, 1, '2017-03-03 18:12:15', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(487, 1, 1, '2017-03-03 18:12:43', 'Se ha creado el ingreso número: 20 para el cliente contact-provider', '/payment-in/25', 'Payment', 'Create'),
	(488, 1, 1, '2017-03-03 18:14:49', 'Se ha creado el ingreso número: 21 para el cliente cliente 1', '/payment-in/26', 'Payment', 'Create'),
	(489, 1, 1, '2017-03-03 18:31:04', 'Se creó el comprobante de pago número: 17 para el proveedor proveedor 5', '/payment-out/27', 'payment-out', 'Create'),
	(490, 1, 1, '2017-03-03 18:31:33', 'Se ha impreso el pdf para el comprobante de egreso No: 17', '/payment-out/27', 'payment-out', 'Print'),
	(491, 1, 1, '2017-03-03 18:57:11', 'Se actualizó el comprobante de pago número: 1 para el cliente contact-provider', '/payment-out/17', 'payment-out', 'Update'),
	(492, 1, 1, '2017-03-03 19:00:58', 'Se actualizó el comprobante de pago número: 1 para el cliente contact-provider', '/payment-out/17', 'payment-out', 'Update'),
	(493, 1, 1, '2017-03-03 19:33:48', 'Se actualizó el estado de la factura de venta número: 15 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(494, 1, 1, '2017-03-03 19:34:17', 'Se actualizó el estado de la factura de venta número: 11 para el cliente cliente 1', '/invoice/11', 'InvoiceSaleOrder', 'Update'),
	(495, 1, 1, '2017-03-03 19:34:39', 'Se actualizó el estado de la factura de venta número: 6 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(496, 1, 1, '2017-03-03 19:34:43', 'Se actualizó el estado de la factura de venta número: 6 para el cliente cliente 2', '/invoice/6', 'InvoiceSaleOrder', 'Update'),
	(497, 1, 1, '2017-03-03 19:34:45', 'Se actualizó el estado de la factura de venta número: 5 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(498, 1, 1, '2017-03-03 19:34:46', 'Se actualizó el estado de la factura de venta número: 5 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(499, 1, 1, '2017-03-03 19:34:50', 'Se actualizó el estado de la factura de venta número: 5 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(500, 1, 1, '2017-03-03 19:38:34', 'Se ha creado el ingreso número: 22 para el cliente cliente 2', '/payment-in/28', 'Payment', 'Create'),
	(501, 1, 1, '2017-03-03 19:46:43', 'Se ha creado el ingreso número: 23 para el cliente contact-provider', '/payment-in/28', 'Payment', 'Create'),
	(502, 1, 1, '2017-03-03 19:56:59', 'Se ha creado el ingreso número: 24 para el cliente cliente 1', '/payment-in/28', 'Payment', 'Create'),
	(503, 1, 1, '2017-03-05 10:28:15', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(504, 1, 1, '2017-03-05 11:15:51', 'Se creó la factura de venta número: 16 para el cliente cliente 1', '/invoice/16', 'InvoiceSaleOrder', 'Create'),
	(505, 1, 1, '2017-03-05 17:44:26', 'Se ha impreso el pdf de la Nota Crédito No: 1', '/credit-note/1', 'CreditNote', 'Print'),
	(506, 1, 1, '2017-03-05 18:20:48', 'Se actualizó el estado de la factura de venta número: 5 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(507, 1, 1, '2017-03-05 18:20:49', 'Se actualizó el estado de la factura de venta número: 5 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(508, 1, 1, '2017-03-06 08:14:50', 'Se actualizó la factura de venta número: 1 para el cliente cliente 1', '/invoice/16', 'InvoiceSaleOrder', 'Update'),
	(509, 1, 1, '2017-03-06 08:33:05', 'Se actualizó la factura de venta número: 1 para el cliente contact-provider', '/invoice/15', 'InvoiceSaleOrder', 'Update'),
	(510, 1, 1, '2017-03-06 08:35:40', 'Se actualizó la factura de venta número: 1 para el cliente cliente 1', '/invoice/16', 'InvoiceSaleOrder', 'Update'),
	(511, 1, 1, '2017-03-06 08:36:12', 'Se actualizó la factura de venta número: 1 para el cliente cliente 1', '/invoice/16', 'InvoiceSaleOrder', 'Update'),
	(512, 1, 1, '2017-03-06 08:53:57', 'Se actualizó la factura de venta número: 17 para el cliente cliente 1', '/invoice/16', 'InvoiceSaleOrder', 'Update'),
	(513, 1, 1, '2017-03-06 09:46:34', 'Se eliminó la factura de venta número: 16', NULL, 'InvoiceSaleOrder', 'Delete'),
	(514, 1, 1, '2017-03-06 09:46:39', 'Se eliminó la factura de venta número: 15', NULL, 'InvoiceSaleOrder', 'Delete'),
	(515, 1, 1, '2017-03-06 09:46:42', 'Se eliminó la factura de venta número: 14', NULL, 'InvoiceSaleOrder', 'Delete'),
	(516, 1, 1, '2017-03-06 09:46:46', 'Se eliminó la factura de venta número: 12', NULL, 'InvoiceSaleOrder', 'Delete'),
	(517, 1, 1, '2017-03-06 09:46:50', 'Se eliminó la factura de venta número: 11', NULL, 'InvoiceSaleOrder', 'Delete'),
	(518, 1, 1, '2017-03-06 09:46:54', 'Se eliminó la factura de venta número: 10', NULL, 'InvoiceSaleOrder', 'Delete'),
	(519, 1, 1, '2017-03-06 09:46:58', 'Se eliminó la factura de venta número: 9', NULL, 'InvoiceSaleOrder', 'Delete'),
	(520, 1, 1, '2017-03-06 09:47:05', 'Se eliminó la factura de venta número: 4', NULL, 'InvoiceSaleOrder', 'Delete'),
	(521, 1, 1, '2017-03-06 09:47:09', 'Se eliminó la factura de venta número: 6', NULL, 'InvoiceSaleOrder', 'Delete'),
	(522, 1, 1, '2017-03-06 09:47:13', 'Se eliminó la factura de venta número: 7', NULL, 'InvoiceSaleOrder', 'Delete'),
	(523, 1, 1, '2017-03-06 09:47:17', 'Se actualizó el estado de la factura de venta número: 5 para el cliente as', '/invoice/5', 'InvoiceSaleOrder', 'Update'),
	(524, 1, 1, '2017-03-06 09:47:20', 'Se eliminó la factura de venta número: 5', NULL, 'InvoiceSaleOrder', 'Delete'),
	(525, 1, 1, '2017-03-06 09:47:38', 'Se eliminó el pago número: 10', NULL, 'Payment', 'Delete'),
	(526, 1, 1, '2017-03-06 09:47:42', 'Se eliminó el pago número: 12', NULL, 'Payment', 'Delete'),
	(527, 1, 1, '2017-03-06 09:47:45', 'Se eliminó el pago número: 13', NULL, 'Payment', 'Delete'),
	(528, 1, 1, '2017-03-06 09:47:49', 'Se eliminó el pago número: 17', NULL, 'Payment', 'Delete'),
	(529, 1, 1, '2017-03-06 09:47:53', 'Se eliminó el pago número: 24', NULL, 'Payment', 'Delete'),
	(530, 1, 1, '2017-03-06 09:47:56', 'Se eliminó el pago número: 21', NULL, 'Payment', 'Delete'),
	(531, 1, 1, '2017-03-06 09:47:59', 'Se eliminó el pago número: 15', NULL, 'Payment', 'Delete'),
	(532, 1, 1, '2017-03-06 09:48:21', 'Se actualizó el estado de la remisión número: 3 para el cliente Fernando Ardila', '/remision/3', 'Remision', 'Update'),
	(533, 1, 1, '2017-03-06 09:48:24', 'Se eliminó la remisión número: 3', NULL, 'Remision', 'Delete'),
	(534, 1, 1, '2017-03-06 09:48:28', 'Se eliminó la remisión número: 1', NULL, 'Remision', 'Delete'),
	(535, 1, 1, '2017-03-06 09:48:37', 'Se eliminó la cotización número: 23', NULL, 'Estimate', 'Delete'),
	(536, 1, 1, '2017-03-06 09:48:41', 'Se eliminó la cotización número: 24', NULL, 'Estimate', 'Delete'),
	(537, 1, 1, '2017-03-06 09:48:45', 'Se eliminó la cotización número: 25', NULL, 'Estimate', 'Delete'),
	(538, 1, 1, '2017-03-06 09:48:49', 'Se eliminó la cotización número: 22', NULL, 'Estimate', 'Delete'),
	(539, 1, 1, '2017-03-06 09:48:52', 'Se eliminó la cotización número: 21', NULL, 'Estimate', 'Delete'),
	(540, 1, 1, '2017-03-06 09:48:57', 'Se eliminó la cotización número: 20', NULL, 'Estimate', 'Delete'),
	(541, 1, 1, '2017-03-06 09:49:00', 'Se eliminó la cotización número: 17', NULL, 'Estimate', 'Delete'),
	(542, 1, 1, '2017-03-06 09:49:04', 'Se eliminó la cotización número: 14', NULL, 'Estimate', 'Delete'),
	(543, 1, 1, '2017-03-06 09:49:08', 'Se eliminó la cotización número: 12', NULL, 'Estimate', 'Delete'),
	(544, 1, 1, '2017-03-06 09:49:13', 'Se eliminó la cotización número: 9', NULL, 'Estimate', 'Delete'),
	(545, 1, 1, '2017-03-06 09:49:17', 'Se eliminó la cotización número: 8', NULL, 'Estimate', 'Delete'),
	(546, 1, 1, '2017-03-06 09:49:21', 'Se eliminó la cotización número: 26', NULL, 'Estimate', 'Delete'),
	(547, 1, 1, '2017-03-06 09:49:25', 'Se eliminó la cotización número: 5', NULL, 'Estimate', 'Delete'),
	(548, 1, 1, '2017-03-06 09:49:29', 'Se eliminó la cotización número: 3', NULL, 'Estimate', 'Delete'),
	(549, 1, 1, '2017-03-06 09:50:38', 'Se eliminó la cotización número: 37', NULL, 'Estimate', 'Delete'),
	(550, 1, 1, '2017-03-06 09:50:42', 'Se eliminó la cotización número: 36', NULL, 'Estimate', 'Delete'),
	(551, 1, 1, '2017-03-06 09:50:45', 'Se eliminó la cotización número: 35', NULL, 'Estimate', 'Delete'),
	(552, 1, 1, '2017-03-06 09:50:49', 'Se eliminó la cotización número: 29', NULL, 'Estimate', 'Delete'),
	(553, 1, 1, '2017-03-06 09:50:53', 'Se eliminó la cotización número: 28', NULL, 'Estimate', 'Delete'),
	(554, 1, 1, '2017-03-06 09:50:57', 'Se eliminó la cotización número: 27', NULL, 'Estimate', 'Delete'),
	(555, 1, 1, '2017-03-06 09:51:01', 'Se eliminó la cotización número: 7', NULL, 'Estimate', 'Delete'),
	(556, 1, 1, '2017-03-06 09:51:04', 'Se eliminó la cotización número: 6', NULL, 'Estimate', 'Delete'),
	(557, 1, 1, '2017-03-06 09:51:08', 'Se eliminó la cotización número: 4', NULL, 'Estimate', 'Delete'),
	(558, 1, 1, '2017-03-06 09:51:11', 'Se eliminó la cotización número: 2', NULL, 'Estimate', 'Delete'),
	(559, 1, 1, '2017-03-06 09:51:15', 'Se eliminó la cotización número: 1', NULL, 'Estimate', 'Delete'),
	(560, 1, 1, '2017-03-06 09:52:08', 'Se eliminó la factura de venta número: 4', NULL, 'Bill', 'Delete'),
	(561, 1, 1, '2017-03-06 09:52:11', 'Se eliminó la factura de venta número: 2', NULL, 'Bill', 'Delete'),
	(562, 1, 1, '2017-03-06 09:52:15', 'Se eliminó la factura de venta número: 3', NULL, 'Bill', 'Delete'),
	(563, 1, 1, '2017-03-06 10:13:16', 'Se eliminó la factura de venta número: 13', NULL, 'InvoiceSaleOrder', 'Delete'),
	(564, 1, 1, '2017-03-06 10:13:21', 'Se eliminó la factura de venta número: 3', NULL, 'InvoiceSaleOrder', 'Delete'),
	(565, 1, 1, '2017-03-06 10:13:25', 'Se eliminó la factura de venta número: 2', NULL, 'InvoiceSaleOrder', 'Delete'),
	(566, 1, 1, '2017-03-06 10:13:28', 'Se eliminó la factura de venta número: 1', NULL, 'InvoiceSaleOrder', 'Delete'),
	(567, 1, 1, '2017-03-06 13:29:45', 'Se creó la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Create'),
	(568, 1, 1, '2017-03-06 13:30:39', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(569, 1, 1, '2017-03-06 13:43:34', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(570, 1, 1, '2017-03-06 13:44:44', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(571, 1, 1, '2017-03-06 13:44:52', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(572, 1, 1, '2017-03-06 13:45:19', 'Se actualizó la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(573, 1, 1, '2017-03-06 13:47:25', 'Se actualizó la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(574, 1, 1, '2017-03-06 13:49:07', 'Se actualizó la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(575, 1, 1, '2017-03-06 13:49:32', 'Se actualizó la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(576, 1, 1, '2017-03-06 14:12:09', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(577, 1, 1, '2017-03-06 14:14:12', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(578, 1, 1, '2017-03-06 14:14:38', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(579, 1, 1, '2017-03-06 14:15:21', 'Se ha impreso el pdf de la remision No: 4', '/remision/4', 'Remision', 'Print'),
	(580, 1, 1, '2017-03-06 14:29:26', 'Se actualizó la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(581, 1, 1, '2017-03-06 14:43:13', 'Se actualizó el estado de la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(582, 1, 1, '2017-03-06 14:43:17', 'Se actualizó el estado de la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(583, 1, 1, '2017-03-06 14:53:15', 'Se actualizó el estado de la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(584, 1, 1, '2017-03-06 14:53:18', 'Se actualizó el estado de la remisión número: 4 para el cliente contacto-cliente', '/remision/4', 'Remision', 'Update'),
	(585, 1, 1, '2017-03-08 17:14:19', 'Se creó la Cotización número: 38 para el cliente contacto-cliente', '/estimate/33', 'Estimate', 'Create'),
	(586, 1, 1, '2017-03-08 17:14:52', 'Se ha impreso el pdf de la cotización No: 38', '/estimate/33', 'Estimate', 'Print'),
	(587, 1, 1, '2017-03-08 17:26:32', 'Se ha impreso el pdf de la cotización No: 38', '/estimate/33', 'Estimate', 'Print'),
	(588, 1, 1, '2017-03-08 17:35:57', 'Se actualizó la Cotización número: 38 para el cliente contacto-cliente', '/estimate/33', 'Estimate', 'Update'),
	(589, 1, 1, '2017-03-08 17:36:05', 'Se ha impreso el pdf de la cotización No: 38', '/estimate/33', 'Estimate', 'Print'),
	(590, 1, 1, '2017-03-08 17:37:13', 'Se ha impreso el pdf de la cotización No: 38', '/estimate/33', 'Estimate', 'Print'),
	(591, 1, 1, '2017-03-08 17:37:58', 'Se ha impreso el pdf de la cotización No: 38', '/estimate/33', 'Estimate', 'Print'),
	(592, 1, 1, '2017-03-10 09:31:20', 'Se eliminó el pago número: 16', NULL, 'Payment', 'Delete'),
	(593, 1, 1, '2017-03-10 09:31:25', 'Se eliminó el pago número: 14', NULL, 'Payment', 'Delete'),
	(594, 1, 1, '2017-03-10 09:31:28', 'Se eliminó el pago número: 5', NULL, 'Payment', 'Delete'),
	(595, 1, 1, '2017-03-10 12:53:46', 'Se creó el comprobante de pago número: 19 para la cuenta: ', '/payment-out/29', 'payment-out', 'Create'),
	(596, 1, 1, '2017-03-10 13:14:48', 'Se realizó una transferencia desde la cuenta, hacia la cuenta', NULL, 'payment-out', 'Create'),
	(597, 1, 1, '2017-03-10 13:24:53', 'Se realizó una transferencia desde la cuenta, hacia la cuenta', NULL, 'BankAccount', 'Create'),
	(598, 1, 1, '2017-03-10 17:13:46', 'Se realizó una transferencia desde la cuentaBanco 1, hacia la cuenta Tarjeta de crédito 1', NULL, 'BankAccount', 'Create'),
	(599, 1, 1, '2017-03-10 22:19:01', 'Se realizó una transferencia desde la cuentaTarjeta de crédito 1, hacia la cuenta Banco 1', NULL, 'BankAccount', 'Create'),
	(600, 1, 1, '2017-03-13 12:38:25', 'Se actualizó la factura de venta número: 18 para el cliente contacto-cliente', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(601, 1, 1, '2017-03-13 12:53:20', 'Se actualizó el estado de la factura de venta número: 17 para el cliente contacto-cliente', '/invoice/17', 'InvoiceSaleOrder', 'Update'),
	(602, 1, 1, '2017-03-13 12:53:36', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(603, 1, 1, '2017-03-13 12:54:11', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(604, 1, 1, '2017-03-13 12:54:21', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(605, 1, 1, '2017-03-13 12:54:31', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(606, 1, 1, '2017-03-13 12:54:50', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(607, 1, 1, '2017-03-13 12:54:59', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(608, 1, 1, '2017-03-13 12:55:49', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(609, 1, 1, '2017-03-13 12:57:24', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(610, 1, 1, '2017-03-13 12:57:36', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(611, 1, 1, '2017-03-13 13:00:48', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(612, 1, 1, '2017-03-13 13:00:56', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(613, 1, 1, '2017-03-13 13:01:46', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(614, 1, 1, '2017-03-13 13:01:59', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(615, 1, 1, '2017-03-13 13:04:43', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(616, 1, 1, '2017-03-13 13:06:58', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(617, 1, 1, '2017-03-13 13:08:50', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(618, 1, 1, '2017-03-13 13:08:55', 'Se ha impreso el pdf de la factura de venta No: 17', '/invoice/17', 'InvoiceSaleOrder', 'Print'),
	(619, 1, 1, '2017-03-13 13:09:17', 'Se actualizó el estado de la factura de venta número: 17 para el cliente contacto-cliente', '/invoice/17', 'InvoiceSaleOrder', 'Update'),
	(620, 1, 1, '2017-03-13 13:09:24', 'Se actualizó la factura de venta número: 17 para el cliente contacto-cliente', '/invoice/17', 'InvoiceSaleOrder', 'Update'),
	(621, 1, 1, '2017-03-13 13:09:28', 'Se actualizó el estado de la factura de venta número: 17 para el cliente contacto-cliente', '/invoice/17', 'InvoiceSaleOrder', 'Update'),
	(622, 1, 1, '2017-03-13 13:09:31', 'Se ha impreso el pdf de la factura de venta No: 17', '/invoice/17', 'InvoiceSaleOrder', 'Print'),
	(623, 1, 1, '2017-03-13 13:29:25', 'Se ha impreso el pdf de la factura de venta No: 17', '/invoice/17', 'InvoiceSaleOrder', 'Print'),
	(624, 1, 1, '2017-03-13 13:30:36', 'Se ha impreso el pdf de la factura de venta No: 17', '/invoice/17', 'InvoiceSaleOrder', 'Print'),
	(625, 1, 1, '2017-03-13 13:34:04', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(626, 1, 1, '2017-03-13 13:34:43', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(627, 1, 1, '2017-03-13 13:35:16', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(628, 1, 1, '2017-03-13 13:35:31', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(629, 1, 1, '2017-03-13 13:37:01', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(630, 1, 1, '2017-03-13 13:37:07', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(631, 1, 1, '2017-03-13 13:39:11', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(632, 1, 1, '2017-03-13 13:39:24', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(633, 1, 1, '2017-03-13 13:40:14', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(634, 1, 1, '2017-03-13 13:40:53', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(635, 1, 1, '2017-03-13 13:41:28', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(636, 1, 1, '2017-03-13 13:42:32', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(637, 1, 1, '2017-03-13 13:42:56', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(638, 1, 1, '2017-03-13 13:44:21', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(639, 1, 1, '2017-03-13 13:44:46', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(640, 1, 1, '2017-03-13 13:45:07', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(641, 1, 1, '2017-03-13 13:45:40', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(642, 1, 1, '2017-03-13 13:46:00', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(643, 1, 1, '2017-03-13 13:47:16', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(644, 1, 1, '2017-03-13 13:48:29', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(645, 1, 1, '2017-03-13 13:48:45', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(646, 1, 1, '2017-03-13 13:49:42', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(647, 1, 1, '2017-03-13 13:50:29', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(648, 1, 1, '2017-03-13 13:58:26', 'Se creó la Nota Crédito número: 3 para el cliente contacto-cliente', '/credit-note/3', 'CreditNote', 'Create'),
	(649, 1, 1, '2017-03-13 21:45:04', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(650, 1, 1, '2017-03-14 10:12:19', 'Se ha impreso el pdf de la Nota Crédito No: 3', '/credit-note/3', 'CreditNote', 'Print'),
	(651, 1, 1, '2017-03-14 10:13:34', 'Se ha impreso el pdf de la Nota Crédito No: 3', '/credit-note/3', 'CreditNote', 'Print'),
	(652, 1, 1, '2017-03-14 10:23:17', 'Se ha impreso el pdf de la Nota Crédito No: 3', '/credit-note/3', 'CreditNote', 'Print'),
	(653, 1, 1, '2017-03-14 14:40:18', 'Se creó la factura de proveedor número: 5 para el cliente contacto-proveedor', '/bill/5', 'Bill', 'Create'),
	(654, 1, 1, '2017-03-14 14:41:08', 'Se ha impreso el pdf de la factura de venta No: 5', '/bill/5', 'Bill', 'Print'),
	(655, 1, 1, '2017-03-14 14:43:33', 'Se eliminó la cotización número: 1', NULL, 'PurchaseOrder', 'Delete'),
	(656, 1, 1, '2017-03-14 15:02:08', 'Se creó la Orden de Compra número: 2 para el cliente contacto-proveedor', '/purchase-order/2', 'PurchaseOrder', 'Create'),
	(657, 1, 1, '2017-03-14 15:07:19', 'Se ha impreso el pdf de la Orden de Compra No: 2', '/purchase-order/2', 'PurchaseOrder', 'Print'),
	(658, 1, 1, '2017-03-14 15:10:29', 'Se ha impreso el pdf de la Orden de Compra No: 2', '/purchase-order/2', 'PurchaseOrder', 'Print'),
	(659, 1, 1, '2017-03-14 15:31:59', 'Se creó la Nota Débito número: 4 para el cliente contacto-proveedor', '/debit-note/3', 'DebitNote', 'Create'),
	(660, 1, 1, '2017-03-14 15:32:26', 'Se ha impreso el pdf de la Nota Débito No: 4', '/debit-note/3', 'DebitNote', 'Print'),
	(661, 1, 1, '2017-03-16 15:25:51', 'Se ha creado el ingreso número: 29 para el cliente contacto-cliente', '/payment-in/37', 'Payment', 'Create'),
	(662, 1, 1, '2017-03-16 16:29:36', 'Se eliminó el pago número: 29', NULL, 'Payment', 'Delete'),
	(663, 1, 1, '2017-03-16 17:22:00', 'Se ha creado el ingreso número: 30 para el cliente contacto-cliente', '/payment-in/38', 'Payment', 'Create'),
	(664, 1, 1, '2017-03-16 17:22:34', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(665, 1, 1, '2017-03-16 17:23:52', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(666, 1, 1, '2017-03-16 17:24:16', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(667, 1, 1, '2017-03-16 17:29:07', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(668, 1, 1, '2017-03-16 17:29:18', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(669, 1, 1, '2017-03-16 17:30:27', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(670, 1, 1, '2017-03-16 17:30:36', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(671, 1, 1, '2017-03-16 17:32:08', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(672, 1, 1, '2017-03-16 17:32:50', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(673, 1, 1, '2017-03-16 17:33:05', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(674, 1, 1, '2017-03-16 17:33:25', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(675, 1, 1, '2017-03-16 17:34:12', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(676, 1, 1, '2017-03-16 17:34:22', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(677, 1, 1, '2017-03-16 17:35:24', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(678, 1, 1, '2017-03-16 18:34:24', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(679, 1, 1, '2017-03-16 18:34:34', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(680, 1, 1, '2017-03-16 18:34:52', 'Se ha impreso el pdf para el comprobante de ingreso No: 30', '/payment-in/38', 'Payment-out', 'Print'),
	(681, 1, 1, '2017-03-16 20:08:39', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(682, 1, 1, '2017-03-16 20:32:07', 'Se actualizó el estado de la factura de venta número: 18 para el cliente contacto-cliente', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(683, 1, 1, '2017-03-16 20:32:12', 'Se actualizó el estado de la factura de venta número: 18 para el cliente contacto-cliente', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(684, 1, 1, '2017-03-16 21:26:43', 'Se actualizó el estado de la factura de venta número: 18 para el cliente contacto-cliente', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(685, 1, 1, '2017-03-16 21:26:45', 'Se actualizó el estado de la factura de venta número: 18 para el cliente contacto-cliente', '/invoice/18', 'InvoiceSaleOrder', 'Update'),
	(686, 1, 1, '2017-03-16 21:26:50', 'Se ha impreso el pdf de la factura de venta No: 18', '/invoice/18', 'InvoiceSaleOrder', 'Print'),
	(687, 1, 1, '2017-03-16 21:45:00', 'Se ha creado el ingreso número: 31 para el cliente contacto-cliente', '/payment-in/39', 'Payment', 'Create'),
	(688, 1, 1, '2017-03-17 09:16:10', 'Se creó la factura de venta número: 19 para el cliente contacto-cliente', '/invoice/19', 'InvoiceSaleOrder', 'Create'),
	(689, 1, 1, '2017-03-22 14:31:03', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(690, 1, 1, '2017-03-22 16:02:01', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(691, 1, 1, '2017-03-22 16:39:28', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(692, 1, 1, '2017-03-22 16:45:15', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(693, 1, 1, '2017-03-22 17:00:21', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn'),
	(694, 2, 2, '2017-03-22 17:10:32', 'Fernando 2 ha iniciado sesion', '/profile/2/edit', 'User', 'LogIn'),
	(695, NULL, 7, '2017-03-22 21:25:12', 'seguros delima ha iniciado sesion', '/profile/7/edit', 'User', 'LogIn'),
	(696, 1, 1, '2017-03-23 06:16:46', 'Fernando ha iniciado sesion', '/profile/1/edit', 'User', 'LogIn');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COMMENT='bank information related with accounts';

-- Volcando datos para la tabla krece.bank_account: ~18 rows (aproximadamente)
DELETE FROM `bank_account`;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
INSERT INTO `bank_account` (`id`, `user_id`, `public_id`, `account_id`, `bank_account_type_id`, `bank_account_name`, `bank_account_number`, `initial_balance`, `description`, `isDeleted`, `isDefault`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 'Banco 1', '123456', 26999000, NULL, b'0', b'1', '2017-01-18 14:20:49', '2017-03-10 22:19:01', '2017-01-19 08:17:11'),
	(2, 1, 2, 1, 2, 'Tarjeta de crédito 1', '', 3001000, '', b'0', b'0', '2017-01-18 15:42:26', '2017-03-22 21:10:48', NULL),
	(3, 1, 3, 1, 3, 'Caja General', '', 0, '', b'0', b'0', '2017-01-18 15:43:04', '2017-03-22 21:10:49', NULL),
	(4, 2, 1, 2, 1, 'Banco 1', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:13:08', '2017-03-22 21:13:08', NULL),
	(5, 2, 2, 2, 2, 'Tarjeta de crédito 1', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:13:08', '2017-03-22 21:13:08', NULL),
	(6, 2, 3, 2, 3, 'Caja general', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:13:09', '2017-03-22 21:13:09', NULL),
	(7, 7, 1, 6, 1, 'Banco 1', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:23:01', '2017-03-22 21:23:01', NULL),
	(8, 7, 2, 6, 2, 'Tarjeta de crédito 1', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:23:01', '2017-03-22 21:23:01', NULL),
	(9, 7, 3, 6, 3, 'Caja general', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:23:01', '2017-03-22 21:23:01', NULL),
	(10, 8, 1, 7, 1, 'Banco 1', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(11, 8, 2, 7, 2, 'Tarjeta de crédito 1', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(12, 8, 3, 7, 3, 'Caja general', NULL, 0, NULL, b'0', b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(13, 10, 1, 9, 1, 'Banco 1', NULL, 0, NULL, b'0', b'1', NULL, '2017-03-22 22:01:25', NULL),
	(14, 10, 2, 9, 2, 'Tarjeta de crédito 1', NULL, 0, NULL, b'0', b'0', NULL, '2017-03-22 22:01:25', NULL),
	(15, 10, 3, 9, 3, 'Caja general', NULL, 0, NULL, b'0', b'0', NULL, '2017-03-22 22:01:25', NULL),
	(16, 11, 1, 10, 1, 'Banco 1', NULL, 0, NULL, b'0', b'1', NULL, '2017-03-22 22:02:02', NULL),
	(17, 11, 2, 10, 2, 'Tarjeta de crédito 1', NULL, 0, NULL, b'0', b'0', NULL, '2017-03-22 22:02:02', NULL),
	(18, 11, 3, 10, 3, 'Caja general', NULL, 0, NULL, b'0', b'0', NULL, '2017-03-22 22:02:02', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.bill: ~4 rows (aproximadamente)
DELETE FROM `bill`;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` (`id`, `account_id`, `user_id`, `public_id`, `customer_id`, `resolution_id`, `date`, `due_date`, `status_id`, `observations`, `currency_code`, `total`, `sub_total`, `total_discounts`, `total_taxes`, `currency_code_multicurrency`, `exchange_rate`, `isRecurring`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(4, 1, 1, 1, 6, 1, '2017-02-24', '2017-02-24', 1, 'descripciones', 'COP', 13853.2, 13379, 399.2, 873.392, NULL, NULL, b'0', b'1', '2017-02-24 17:13:48', '2017-02-24 18:28:20', '2017-02-24 18:28:20'),
	(9, 1, 1, 2, 6, 2, '2017-02-24', '2017-02-24', 6, 'asas', 'COP', 1212, 1212, 0, 0, NULL, NULL, b'0', b'1', '2017-02-24 18:22:39', '2017-03-06 09:52:11', '2017-03-06 09:52:11'),
	(10, 1, 1, 3, 9, 3, '2017-02-24', '2017-02-24', 6, 'asa', 'COP', 49824.1, 48903, 0, 921.12, NULL, NULL, b'0', b'1', '2017-02-24 18:49:45', '2017-03-06 09:52:15', '2017-03-06 09:52:15'),
	(11, 1, 1, 4, 23, 4, '2017-02-28', '2017-02-28', 6, 'test', 'COP', 3000, 3000, 0, 0, NULL, NULL, b'0', b'1', '2017-02-28 10:31:18', '2017-03-06 09:52:08', '2017-03-06 09:52:08'),
	(12, 1, 1, 5, 24, 5, '2017-03-14', '2017-03-14', 1, 'observaciones factura proveedor', 'COP', 9880, 10000, 500, 380, NULL, NULL, b'0', b'0', '2017-03-14 14:40:18', '2017-03-14 14:40:18', NULL);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_debit_note
CREATE TABLE IF NOT EXISTS `bill_debit_note` (
  `debit_note_id` bigint(20) NOT NULL,
  `bill_id` bigint(20) NOT NULL,
  PRIMARY KEY (`debit_note_id`,`bill_id`),
  KEY `FK_isdn_invoice_supplier_order` (`bill_id`),
  CONSTRAINT `FK_isdn_debit_note` FOREIGN KEY (`debit_note_id`) REFERENCES `debit_note` (`id`),
  CONSTRAINT `FK_isdn_invoice_supplier` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='link between the debit note and the transaction table, a user can add a payment that is stored in transaction table.';

-- Volcando datos para la tabla krece.bill_debit_note: ~0 rows (aproximadamente)
DELETE FROM `bill_debit_note`;
/*!40000 ALTER TABLE `bill_debit_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_debit_note` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.bill_detail: ~12 rows (aproximadamente)
DELETE FROM `bill_detail`;
/*!40000 ALTER TABLE `bill_detail` DISABLE KEYS */;
INSERT INTO `bill_detail` (`id`, `bill_id`, `user_id`, `unit_price`, `discount`, `tax_amount`, `tax_id`, `category_id`, `product_id`, `name`, `description`, `quantity`, `total_tax`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(11, 4, 1, 1996, 20, 19, 3, 54, NULL, 'Alquiler de equipos y licencias', NULL, 1, 303.392, 1596.8, '2017-02-24 18:17:06', '2017-02-24 18:17:06', NULL),
	(12, 4, 1, 3000, 0, 19, 4, 65, NULL, 'Egresos no operacionales', NULL, 1, 570, 3000, '2017-02-24 18:17:06', '2017-02-24 18:17:06', NULL),
	(13, 4, 1, 1212, 0, 0, NULL, 64, NULL, 'Devoluciones en compras de ítem', NULL, 5, 0, 6060, '2017-02-24 18:17:06', '2017-02-24 18:17:06', NULL),
	(14, 4, 1, 2323, 0, 0, 5, 63, NULL, 'Cuentas incobrables', 'desc1', 1, 0, 2323, '2017-02-24 18:17:06', '2017-02-24 18:17:06', NULL),
	(15, 9, 1, 1212, 0, 0, NULL, 54, NULL, 'Alquiler de equipos y licencias', NULL, 1, 0, 1212, '2017-02-24 18:22:39', '2017-02-24 18:22:39', NULL),
	(16, 10, 1, 1212, 0, 19, 3, 65, NULL, 'Egresos no operacionales', NULL, 4, 921.12, 4848, '2017-02-24 18:49:45', '2017-02-24 18:49:45', NULL),
	(17, 10, 1, 4005, 0, 0, NULL, 65, NULL, 'Egresos no operacionales', NULL, 11, 0, 44055, '2017-02-24 18:49:45', '2017-02-24 18:49:45', NULL),
	(18, 11, 1, 1000, 0, 0, NULL, 54, NULL, 'Alquiler de equipos y licencias', NULL, 1, 0, 1000, '2017-02-28 10:31:18', '2017-02-28 10:31:18', NULL),
	(19, 11, 1, 2000, 0, 0, NULL, 66, NULL, 'Descuento financiero', NULL, 1, 0, 2000, '2017-02-28 10:31:18', '2017-02-28 10:31:18', NULL),
	(20, 12, 1, 2000, 0, 19, 3, 54, NULL, 'Alquiler de equipos y licencias', NULL, 1, 380, 2000, '2017-03-14 14:40:18', '2017-03-14 14:40:18', NULL),
	(21, 12, 1, 3000, 0, 0, NULL, 55, NULL, 'Comisiones y honorarios', NULL, 1, 0, 3000, '2017-03-14 14:40:18', '2017-03-14 14:40:18', NULL),
	(22, 12, 1, 5000, 10, 0, NULL, 75, NULL, 'Legales', NULL, 1, 0, 4500, '2017-03-14 14:40:18', '2017-03-14 14:40:18', NULL);
/*!40000 ALTER TABLE `bill_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_payment
CREATE TABLE IF NOT EXISTS `bill_payment` (
  `bill_id` bigint(20) DEFAULT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  KEY `FK_isopa_payment` (`payment_id`),
  KEY `FK_isopa_invoice_supplier_order` (`bill_id`),
  CONSTRAINT `FK_isopa_invoice_supplier_order` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`),
  CONSTRAINT `FK_isopa_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='set the relation between the payments and invoice supplier order, and put the amount payed.';

-- Volcando datos para la tabla krece.bill_payment: ~0 rows (aproximadamente)
DELETE FROM `bill_payment`;
/*!40000 ALTER TABLE `bill_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.bill_purchase_order
CREATE TABLE IF NOT EXISTS `bill_purchase_order` (
  `bill_id` bigint(20) NOT NULL,
  `purchase_order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`purchase_order_id`,`bill_id`),
  UNIQUE KEY `UK_SO_PO_link` (`bill_id`,`purchase_order_id`),
  CONSTRAINT `FK_POSO_PO_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK_POSO_SO_id` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='link between invoice supplier orders and PO orders, so user decides when a PO belongs to a Supp Order.';

-- Volcando datos para la tabla krece.bill_purchase_order: ~0 rows (aproximadamente)
DELETE FROM `bill_purchase_order`;
/*!40000 ALTER TABLE `bill_purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_purchase_order` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=438 DEFAULT CHARSET=latin1 COMMENT='product categories';

-- Volcando datos para la tabla krece.category: ~410 rows (aproximadamente)
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
	(109, 1, 1, NULL, 163, 164, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-02-01 11:01:17', '2017-02-01 11:01:17'),
	(110, 2, 2, NULL, 165, 178, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'0', b'0', 1, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(111, 2, 2, 110, 166, 167, 'Devoluciones de ventas', NULL, NULL, b'0', b'0', 1, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(112, 2, 2, 110, 168, 169, 'Ingreso sin identificar', NULL, NULL, b'0', b'0', 1, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(113, 2, 2, 110, 170, 175, 'Ingresos no operacionales', NULL, NULL, b'0', b'0', 1, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(114, 2, 2, 113, 171, 174, 'Otros Ingresos', NULL, NULL, b'0', b'0', 1, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(115, 2, 2, 114, 172, 173, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'0', b'0', 1, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(116, 2, 2, 110, 176, 177, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 1, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(117, 2, 2, NULL, 179, 252, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'0', b'0', 2, '2017-03-22 18:46:17', '2017-03-22 18:46:17'),
	(118, 2, 2, 117, 180, 181, 'Alquiler de equipos y licencias', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(119, 2, 2, 117, 182, 183, 'Comisiones y honorarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(120, 2, 2, 117, 184, 195, 'Costo de la mercancía vendida', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(121, 2, 2, 120, 185, 186, 'Ajustes del inventario', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(122, 2, 2, 120, 187, 188, 'Compras inventariables', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(123, 2, 2, 120, 189, 190, 'Fletes y envíos', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(124, 2, 2, 120, 191, 192, 'Mano de obra', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(125, 2, 2, 120, 193, 194, 'Materias primas', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(126, 2, 2, 117, 196, 197, 'Costo servicios vendidos', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(127, 2, 2, 117, 198, 199, 'Cuentas incobrables', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(128, 2, 2, 117, 200, 201, 'Devoluciones en compras de ítem', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(129, 2, 2, 117, 202, 207, 'Egresos no operacionales', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(130, 2, 2, 129, 203, 204, 'Descuento financiero', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(131, 2, 2, 129, 205, 206, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'0', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(132, 2, 2, 117, 208, 219, 'Gastos administrativos', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(133, 2, 2, 132, 209, 210, 'Arrendamiento', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(134, 2, 2, 132, 211, 212, 'Aseo y cafetería', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:18', '2017-03-22 18:46:18'),
	(135, 2, 2, 132, 213, 214, 'Internet y telecomunicaciones', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(136, 2, 2, 132, 215, 216, 'Papelería', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(137, 2, 2, 132, 217, 218, 'Servicios públicos', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(138, 2, 2, 117, 220, 221, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(139, 2, 2, 117, 222, 223, 'Legales', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(140, 2, 2, 117, 224, 225, 'Mantenimiento e instalaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(141, 2, 2, 117, 226, 235, 'Nómina', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(142, 2, 2, 141, 227, 228, 'Dotación', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(143, 2, 2, 141, 229, 230, 'Prestaciones sociales', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(144, 2, 2, 141, 231, 232, 'Salarios', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(145, 2, 2, 141, 233, 234, 'Seguridad social y parafiscales', NULL, NULL, b'1', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(146, 2, 2, 117, 236, 237, 'Otros impuestos', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(147, 2, 2, 117, 238, 239, 'Publicidad', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(148, 2, 2, 117, 240, 241, 'Seguros y seguridad', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(149, 2, 2, 117, 242, 243, 'Servicios bancarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(150, 2, 2, 117, 244, 245, 'Subscripciones y afiliaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:19', '2017-03-22 18:46:19'),
	(151, 2, 2, 117, 246, 247, 'Transporte y mensajería', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(152, 2, 2, 117, 248, 249, 'Varios', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(153, 2, 2, 117, 250, 251, 'Viajes y viáticos', NULL, NULL, b'0', b'0', 2, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(154, 2, 2, NULL, 253, 288, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(155, 2, 2, 154, 254, 261, 'Activo corriente', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(156, 2, 2, 155, 255, 256, 'Bancos', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(157, 2, 2, 155, 257, 258, 'Cuentas por cobrar', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(158, 2, 2, 155, 259, 260, 'Inventario', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(159, 2, 2, 154, 262, 263, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(160, 2, 2, 154, 264, 265, 'Avances y anticipos entregados', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(161, 2, 2, 154, 266, 267, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(162, 2, 2, 154, 268, 273, 'Impuestos a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(163, 2, 2, 162, 269, 270, 'ICO a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(164, 2, 2, 162, 271, 272, 'IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(165, 2, 2, 154, 274, 275, 'Inversiones', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(166, 2, 2, 154, 276, 277, 'Préstamos a terceros', NULL, NULL, b'0', b'0', 3, '2017-03-22 18:46:20', '2017-03-22 18:46:20'),
	(167, 2, 2, 154, 278, 287, 'Retenciones a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(168, 2, 2, 167, 279, 280, 'Retención de CREE a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(169, 2, 2, 167, 281, 282, 'Retención de Industria y comercio a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(170, 2, 2, 167, 283, 284, 'Retención de IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(171, 2, 2, 167, 285, 286, 'Retención en la fuente a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(172, 2, 2, NULL, 289, 316, 'Pasivos', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(173, 2, 2, 172, 290, 291, 'Avances y anticipos recibidos', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(174, 2, 2, 172, 292, 293, 'Cuentas por pagar - devoluciones', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(175, 2, 2, 172, 294, 295, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(176, 2, 2, 172, 296, 297, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(177, 2, 2, 172, 298, 303, 'Impuestos por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(178, 2, 2, 177, 299, 300, 'ICO por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(179, 2, 2, 177, 301, 302, 'IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(180, 2, 2, 172, 304, 305, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(181, 2, 2, 172, 306, 315, 'Retenciones por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(182, 2, 2, 181, 307, 308, 'Retención de CREE por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:21', '2017-03-22 18:46:21'),
	(183, 2, 2, 181, 309, 310, 'Retención de industria y Comercio por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(184, 2, 2, 181, 311, 312, 'Retención de IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(185, 2, 2, 181, 313, 314, 'Retención en la fuente por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(186, 2, 2, NULL, 317, 326, 'Patrimonio', NULL, NULL, b'0', b'0', 5, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(187, 2, 2, 186, 318, 319, 'Ajustes iniciales - Bancos', NULL, NULL, b'0', b'0', 5, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(188, 2, 2, 186, 320, 321, 'Ajustes iniciales - Inventario', NULL, NULL, b'0', b'0', 5, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(189, 2, 2, 186, 322, 323, 'Capital accionistas', NULL, NULL, b'0', b'0', 5, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(190, 2, 2, 186, 324, 325, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'0', b'0', 5, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(191, 2, 2, NULL, 327, 328, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-03-22 18:46:22', '2017-03-22 18:46:22'),
	(192, 6, 7, NULL, 329, 342, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'0', b'0', 1, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(193, 6, 7, 192, 330, 331, 'Devoluciones de ventas', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(194, 6, 7, 192, 332, 333, 'Ingreso sin identificar', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(195, 6, 7, 192, 334, 339, 'Ingresos no operacionales', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(196, 6, 7, 195, 335, 338, 'Otros Ingresos', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(197, 6, 7, 196, 336, 337, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'0', b'0', 1, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(198, 6, 7, 192, 340, 341, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 1, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(199, 6, 7, NULL, 343, 416, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'0', b'0', 2, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(200, 6, 7, 199, 344, 345, 'Alquiler de equipos y licencias', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:54', '2017-03-22 21:22:54'),
	(201, 6, 7, 199, 346, 347, 'Comisiones y honorarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(202, 6, 7, 199, 348, 359, 'Costo de la mercancía vendida', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(203, 6, 7, 202, 349, 350, 'Ajustes del inventario', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(204, 6, 7, 202, 351, 352, 'Compras inventariables', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(205, 6, 7, 202, 353, 354, 'Fletes y envíos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(206, 6, 7, 202, 355, 356, 'Mano de obra', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(207, 6, 7, 202, 357, 358, 'Materias primas', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(208, 6, 7, 199, 360, 361, 'Costo servicios vendidos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(209, 6, 7, 199, 362, 363, 'Cuentas incobrables', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(210, 6, 7, 199, 364, 365, 'Devoluciones en compras de ítem', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(211, 6, 7, 199, 366, 371, 'Egresos no operacionales', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(212, 6, 7, 211, 367, 368, 'Descuento financiero', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(213, 6, 7, 211, 369, 370, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'0', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(214, 6, 7, 199, 372, 383, 'Gastos administrativos', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(215, 6, 7, 214, 373, 374, 'Arrendamiento', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:55', '2017-03-22 21:22:55'),
	(216, 6, 7, 214, 375, 376, 'Aseo y cafetería', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(217, 6, 7, 214, 377, 378, 'Internet y telecomunicaciones', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(218, 6, 7, 214, 379, 380, 'Papelería', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(219, 6, 7, 214, 381, 382, 'Servicios públicos', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(220, 6, 7, 199, 384, 385, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'0', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(221, 6, 7, 199, 386, 387, 'Legales', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(222, 6, 7, 199, 388, 389, 'Mantenimiento e instalaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(223, 6, 7, 199, 390, 399, 'Nómina', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(224, 6, 7, 223, 391, 392, 'Dotación', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(225, 6, 7, 223, 393, 394, 'Prestaciones sociales', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(226, 6, 7, 223, 395, 396, 'Salarios', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(227, 6, 7, 223, 397, 398, 'Seguridad social y parafiscales', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(228, 6, 7, 199, 400, 401, 'Otros impuestos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(229, 6, 7, 199, 402, 403, 'Publicidad', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(230, 6, 7, 199, 404, 405, 'Seguros y seguridad', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:56', '2017-03-22 21:22:56'),
	(231, 6, 7, 199, 406, 407, 'Servicios bancarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(232, 6, 7, 199, 408, 409, 'Subscripciones y afiliaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(233, 6, 7, 199, 410, 411, 'Transporte y mensajería', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(234, 6, 7, 199, 412, 413, 'Varios', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(235, 6, 7, 199, 414, 415, 'Viajes y viáticos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(236, 6, 7, NULL, 417, 452, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(237, 6, 7, 236, 418, 425, 'Activo corriente', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(238, 6, 7, 237, 419, 420, 'Bancos', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(239, 6, 7, 237, 421, 422, 'Cuentas por cobrar', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(240, 6, 7, 237, 423, 424, 'Inventario', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(241, 6, 7, 236, 426, 427, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(242, 6, 7, 236, 428, 429, 'Avances y anticipos entregados', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(243, 6, 7, 236, 430, 431, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(244, 6, 7, 236, 432, 437, 'Impuestos a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(245, 6, 7, 244, 433, 434, 'ICO a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(246, 6, 7, 244, 435, 436, 'IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(247, 6, 7, 236, 438, 439, 'Inversiones', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:57', '2017-03-22 21:22:57'),
	(248, 6, 7, 236, 440, 441, 'Préstamos a terceros', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(249, 6, 7, 236, 442, 451, 'Retenciones a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(250, 6, 7, 249, 443, 444, 'Retención de CREE a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(251, 6, 7, 249, 445, 446, 'Retención de Industria y comercio a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(252, 6, 7, 249, 447, 448, 'Retención de IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(253, 6, 7, 249, 449, 450, 'Retención en la fuente a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(254, 6, 7, NULL, 453, 480, 'Pasivos', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(255, 6, 7, 254, 454, 455, 'Avances y anticipos recibidos', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(256, 6, 7, 254, 456, 457, 'Cuentas por pagar - devoluciones', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(257, 6, 7, 254, 458, 459, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(258, 6, 7, 254, 460, 461, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(259, 6, 7, 254, 462, 467, 'Impuestos por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(260, 6, 7, 259, 463, 464, 'ICO por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(261, 6, 7, 259, 465, 466, 'IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(262, 6, 7, 254, 468, 469, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(263, 6, 7, 254, 470, 479, 'Retenciones por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:58', '2017-03-22 21:22:58'),
	(264, 6, 7, 263, 471, 472, 'Retención de CREE por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(265, 6, 7, 263, 473, 474, 'Retención de industria y Comercio por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(266, 6, 7, 263, 475, 476, 'Retención de IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(267, 6, 7, 263, 477, 478, 'Retención en la fuente por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(268, 6, 7, NULL, 481, 490, 'Patrimonio', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(269, 6, 7, 268, 482, 483, 'Ajustes iniciales - Bancos', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(270, 6, 7, 268, 484, 485, 'Ajustes iniciales - Inventario', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(271, 6, 7, 268, 486, 487, 'Capital accionistas', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(272, 6, 7, 268, 488, 489, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'0', b'0', 5, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(273, 6, 7, NULL, 491, 492, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-03-22 21:22:59', '2017-03-22 21:22:59'),
	(274, 8, 9, NULL, 493, 506, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'0', b'0', 1, '2017-03-22 21:55:18', '2017-03-22 21:55:18'),
	(275, 8, 9, 274, 494, 495, 'Devoluciones de ventas', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:55:18', '2017-03-22 21:55:18'),
	(276, 8, 9, 274, 496, 497, 'Ingreso sin identificar', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:55:18', '2017-03-22 21:55:18'),
	(277, 8, 9, 274, 498, 503, 'Ingresos no operacionales', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(278, 8, 9, 277, 499, 502, 'Otros Ingresos', NULL, NULL, b'0', b'0', 1, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(279, 8, 9, 278, 500, 501, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'0', b'0', 1, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(280, 8, 9, 274, 504, 505, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 1, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(281, 8, 9, NULL, 507, 580, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(282, 8, 9, 281, 508, 509, 'Alquiler de equipos y licencias', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(283, 8, 9, 281, 510, 511, 'Comisiones y honorarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(284, 8, 9, 281, 512, 523, 'Costo de la mercancía vendida', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(285, 8, 9, 284, 513, 514, 'Ajustes del inventario', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(286, 8, 9, 284, 515, 516, 'Compras inventariables', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(287, 8, 9, 284, 517, 518, 'Fletes y envíos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(288, 8, 9, 284, 519, 520, 'Mano de obra', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:19', '2017-03-22 21:55:19'),
	(289, 8, 9, 284, 521, 522, 'Materias primas', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(290, 8, 9, 281, 524, 525, 'Costo servicios vendidos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(291, 8, 9, 281, 526, 527, 'Cuentas incobrables', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(292, 8, 9, 281, 528, 529, 'Devoluciones en compras de ítem', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(293, 8, 9, 281, 530, 535, 'Egresos no operacionales', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(294, 8, 9, 293, 531, 532, 'Descuento financiero', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(295, 8, 9, 293, 533, 534, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(296, 8, 9, 281, 536, 547, 'Gastos administrativos', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(297, 8, 9, 296, 537, 538, 'Arrendamiento', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(298, 8, 9, 296, 539, 540, 'Aseo y cafetería', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(299, 8, 9, 296, 541, 542, 'Internet y telecomunicaciones', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(300, 8, 9, 296, 543, 544, 'Papelería', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(301, 8, 9, 296, 545, 546, 'Servicios públicos', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(302, 8, 9, 281, 548, 549, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(303, 8, 9, 281, 550, 551, 'Legales', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:20', '2017-03-22 21:55:20'),
	(304, 8, 9, 281, 552, 553, 'Mantenimiento e instalaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(305, 8, 9, 281, 554, 563, 'Nómina', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(306, 8, 9, 305, 555, 556, 'Dotación', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(307, 8, 9, 305, 557, 558, 'Prestaciones sociales', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(308, 8, 9, 305, 559, 560, 'Salarios', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(309, 8, 9, 305, 561, 562, 'Seguridad social y parafiscales', NULL, NULL, b'1', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(310, 8, 9, 281, 564, 565, 'Otros impuestos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(311, 8, 9, 281, 566, 567, 'Publicidad', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(312, 8, 9, 281, 568, 569, 'Seguros y seguridad', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(313, 8, 9, 281, 570, 571, 'Servicios bancarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(314, 8, 9, 281, 572, 573, 'Subscripciones y afiliaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(315, 8, 9, 281, 574, 575, 'Transporte y mensajería', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(316, 8, 9, 281, 576, 577, 'Varios', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(317, 8, 9, 281, 578, 579, 'Viajes y viáticos', NULL, NULL, b'0', b'0', 2, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(318, 8, 9, NULL, 581, 616, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'0', b'0', 3, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(319, 8, 9, 318, 582, 589, 'Activo corriente', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:21', '2017-03-22 21:55:21'),
	(320, 8, 9, 319, 583, 584, 'Bancos', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(321, 8, 9, 319, 585, 586, 'Cuentas por cobrar', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(322, 8, 9, 319, 587, 588, 'Inventario', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(323, 8, 9, 318, 590, 591, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(324, 8, 9, 318, 592, 593, 'Avances y anticipos entregados', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(325, 8, 9, 318, 594, 595, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(326, 8, 9, 318, 596, 601, 'Impuestos a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(327, 8, 9, 326, 597, 598, 'ICO a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(328, 8, 9, 326, 599, 600, 'IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(329, 8, 9, 318, 602, 603, 'Inversiones', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(330, 8, 9, 318, 604, 605, 'Préstamos a terceros', NULL, NULL, b'0', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(331, 8, 9, 318, 606, 615, 'Retenciones a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(332, 8, 9, 331, 607, 608, 'Retención de CREE a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:55:22', '2017-03-22 21:55:22'),
	(333, 8, 9, 331, 609, 610, 'Retención de Industria y comercio a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(334, 8, 9, 331, 611, 612, 'Retención de IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(335, 8, 9, 331, 613, 614, 'Retención en la fuente a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(336, 8, 9, NULL, 617, 644, 'Pasivos', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(337, 8, 9, 336, 618, 619, 'Avances y anticipos recibidos', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(338, 8, 9, 336, 620, 621, 'Cuentas por pagar - devoluciones', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(339, 8, 9, 336, 622, 623, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(340, 8, 9, 336, 624, 625, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(341, 8, 9, 336, 626, 631, 'Impuestos por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(342, 8, 9, 341, 627, 628, 'ICO por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(343, 8, 9, 341, 629, 630, 'IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(344, 8, 9, 336, 632, 633, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(345, 8, 9, 336, 634, 643, 'Retenciones por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(346, 8, 9, 345, 635, 636, 'Retención de CREE por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(347, 8, 9, 345, 637, 638, 'Retención de industria y Comercio por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(348, 8, 9, 345, 639, 640, 'Retención de IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:23', '2017-03-22 21:55:23'),
	(349, 8, 9, 345, 641, 642, 'Retención en la fuente por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 21:55:24', '2017-03-22 21:55:24'),
	(350, 8, 9, NULL, 645, 654, 'Patrimonio', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:55:24', '2017-03-22 21:55:24'),
	(351, 8, 9, 350, 646, 647, 'Ajustes iniciales - Bancos', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:55:24', '2017-03-22 21:55:24'),
	(352, 8, 9, 350, 648, 649, 'Ajustes iniciales - Inventario', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:55:24', '2017-03-22 21:55:24'),
	(353, 8, 9, 350, 650, 651, 'Capital accionistas', NULL, NULL, b'0', b'0', 5, '2017-03-22 21:55:24', '2017-03-22 21:55:24'),
	(354, 8, 9, 350, 652, 653, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'0', b'0', 5, '2017-03-22 21:55:24', '2017-03-22 21:55:24'),
	(355, 8, 9, NULL, 655, 656, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-03-22 21:55:24', '2017-03-22 21:55:24'),
	(356, 9, 10, NULL, 657, 670, 'Ingresos', NULL, 'Bajo esta categoría se encuentran todos los Ingresos de la compañía', b'0', b'0', 1, '2017-03-22 22:01:19', '2017-03-22 22:01:19'),
	(357, 9, 10, 356, 658, 659, 'Devoluciones de ventas', NULL, NULL, b'0', b'0', 1, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(358, 9, 10, 356, 660, 661, 'Ingreso sin identificar', NULL, NULL, b'0', b'0', 1, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(359, 9, 10, 356, 662, 667, 'Ingresos no operacionales', NULL, NULL, b'0', b'0', 1, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(360, 9, 10, 359, 663, 666, 'Otros Ingresos', NULL, NULL, b'0', b'0', 1, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(361, 9, 10, 360, 664, 665, 'Ingresos por interes', NULL, 'Ingresos por intereses bancarios', b'0', b'0', 1, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(362, 9, 10, 356, 668, 669, 'Ventas', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 1, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(363, 9, 10, NULL, 671, 744, 'Egresos', NULL, 'Bajo esta categoría se encuentran todos los egresos de la compañía', b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(364, 9, 10, 363, 672, 673, 'Alquiler de equipos y licencias', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(365, 9, 10, 363, 674, 675, 'Comisiones y honorarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(366, 9, 10, 363, 676, 687, 'Costo de la mercancía vendida', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(367, 9, 10, 366, 677, 678, 'Ajustes del inventario', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(368, 9, 10, 366, 679, 680, 'Compras inventariables', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(369, 9, 10, 366, 681, 682, 'Fletes y envíos', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(370, 9, 10, 366, 683, 684, 'Mano de obra', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(371, 9, 10, 366, 685, 686, 'Materias primas', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:20', '2017-03-22 22:01:20'),
	(372, 9, 10, 363, 688, 689, 'Costo servicios vendidos', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(373, 9, 10, 363, 690, 691, 'Cuentas incobrables', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(374, 9, 10, 363, 692, 693, 'Devoluciones en compras de ítem', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(375, 9, 10, 363, 694, 699, 'Egresos no operacionales', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(376, 9, 10, 375, 695, 696, 'Descuento financiero', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(377, 9, 10, 375, 697, 698, 'Diferencia en cambio', NULL, 'Bajo esta categoría se encuentran las perdidas y ganancias por diferencias en tasas de cambio', b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(378, 9, 10, 363, 700, 711, 'Gastos administrativos', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(379, 9, 10, 378, 701, 702, 'Arrendamiento', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(380, 9, 10, 378, 703, 704, 'Aseo y cafetería', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(381, 9, 10, 378, 705, 706, 'Internet y telecomunicaciones', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(382, 9, 10, 378, 707, 708, 'Papelería', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(383, 9, 10, 378, 709, 710, 'Servicios públicos', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(384, 9, 10, 363, 712, 713, 'Gastos bancarios', NULL, 'Bajo esta categoría se encuentran todos los gastos bancarios de la compañía', b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(385, 9, 10, 363, 714, 715, 'Legales', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(386, 9, 10, 363, 716, 717, 'Mantenimiento e instalaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(387, 9, 10, 363, 718, 727, 'Nómina', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:21', '2017-03-22 22:01:21'),
	(388, 9, 10, 387, 719, 720, 'Dotación', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(389, 9, 10, 387, 721, 722, 'Prestaciones sociales', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(390, 9, 10, 387, 723, 724, 'Salarios', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(391, 9, 10, 387, 725, 726, 'Seguridad social y parafiscales', NULL, NULL, b'1', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(392, 9, 10, 363, 728, 729, 'Otros impuestos', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(393, 9, 10, 363, 730, 731, 'Publicidad', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(394, 9, 10, 363, 732, 733, 'Seguros y seguridad', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(395, 9, 10, 363, 734, 735, 'Servicios bancarios', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(396, 9, 10, 363, 736, 737, 'Subscripciones y afiliaciones', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(397, 9, 10, 363, 738, 739, 'Transporte y mensajería', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(398, 9, 10, 363, 740, 741, 'Varios', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(399, 9, 10, 363, 742, 743, 'Viajes y viáticos', NULL, NULL, b'0', b'0', 2, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(400, 9, 10, NULL, 745, 780, 'Activos', NULL, 'Bajo esta categoría se encuentran todos los activos de la compañía', b'0', b'0', 3, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(401, 9, 10, 400, 746, 753, 'Activo corriente', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(402, 9, 10, 401, 747, 748, 'Bancos', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(403, 9, 10, 401, 749, 750, 'Cuentas por cobrar', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:22', '2017-03-22 22:01:22'),
	(404, 9, 10, 401, 751, 752, 'Inventario', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(405, 9, 10, 400, 754, 755, 'Activos fijos', NULL, 'Bajo esta categoría se encuentran todos los activos principales de la compañía', b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(406, 9, 10, 400, 756, 757, 'Avances y anticipos entregados', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(407, 9, 10, 400, 758, 759, 'Cuentas por cobrar - devoluciones', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(408, 9, 10, 400, 760, 765, 'Impuestos a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(409, 9, 10, 408, 761, 762, 'ICO a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(410, 9, 10, 408, 763, 764, 'IVA a favor', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(411, 9, 10, 400, 766, 767, 'Inversiones', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(412, 9, 10, 400, 768, 769, 'Préstamos a terceros', NULL, NULL, b'0', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(413, 9, 10, 400, 770, 779, 'Retenciones a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(414, 9, 10, 413, 771, 772, 'Retención de CREE a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(415, 9, 10, 413, 773, 774, 'Retención de Industria y comercio a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(416, 9, 10, 413, 775, 776, 'Retención de IVA a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(417, 9, 10, 413, 777, 778, 'Retención en la fuente a favor', NULL, NULL, b'1', b'0', 3, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(418, 9, 10, NULL, 781, 808, 'Pasivos', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(419, 9, 10, 418, 782, 783, 'Avances y anticipos recibidos', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(420, 9, 10, 418, 784, 785, 'Cuentas por pagar - devoluciones', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(421, 9, 10, 418, 786, 787, 'Cuentas por pagar - proveedores', NULL, 'Bajo esta categoría se encuentran los pasivos principales', b'0', b'0', 4, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(422, 9, 10, 418, 788, 789, 'Cuentas por pagar - tarjetas de crédito', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:23', '2017-03-22 22:01:23'),
	(423, 9, 10, 418, 790, 795, 'Impuestos por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(424, 9, 10, 423, 791, 792, 'ICO por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(425, 9, 10, 423, 793, 794, 'IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(426, 9, 10, 418, 796, 797, 'Obligaciones financieras y préstamos a terceros', NULL, 'Bajo esta categoría se encuentran todos los Ingresos principales', b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(427, 9, 10, 418, 798, 807, 'Retenciones por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(428, 9, 10, 427, 799, 800, 'Retención de CREE por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(429, 9, 10, 427, 801, 802, 'Retención de industria y Comercio por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(430, 9, 10, 427, 803, 804, 'Retención de IVA por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(431, 9, 10, 427, 805, 806, 'Retención en la fuente por pagar', NULL, NULL, b'0', b'0', 4, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(432, 9, 10, NULL, 809, 818, 'Patrimonio', NULL, NULL, b'0', b'0', 5, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(433, 9, 10, 432, 810, 811, 'Ajustes iniciales - Bancos', NULL, NULL, b'0', b'0', 5, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(434, 9, 10, 432, 812, 813, 'Ajustes iniciales - Inventario', NULL, NULL, b'0', b'0', 5, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(435, 9, 10, 432, 814, 815, 'Capital accionistas', NULL, NULL, b'0', b'0', 5, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(436, 9, 10, 432, 816, 817, 'Utilidades', NULL, 'Bajo esta categoría se encuentra el patrimonio principal', b'0', b'0', 5, '2017-03-22 22:01:24', '2017-03-22 22:01:24'),
	(437, 9, 10, NULL, 819, 820, 'Transferencias bancarias', NULL, 'Bajo esta categoría se encuentran todas las transferencias que se realizen entre bancos de la empresa', b'0', b'0', 6, '2017-03-22 22:01:24', '2017-03-22 22:01:24');
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.category_payment: ~17 rows (aproximadamente)
DELETE FROM `category_payment`;
/*!40000 ALTER TABLE `category_payment` DISABLE KEYS */;
INSERT INTO `category_payment` (`id`, `payment_id`, `account_id`, `user_id`, `category_id`, `unit_price`, `tax_id`, `tax_amount`, `tax_total`, `total`, `quantity`, `observations`, `created_at`, `updated_at`) VALUES
	(17, 79, 1, 1, 54, 200, 3, 19, 38, NULL, 1, '1', '2017-03-01 12:31:25', '2017-03-01 12:31:25'),
	(18, 79, 1, 1, 66, 12, NULL, 0, NULL, NULL, 1, '2', '2017-03-01 12:31:25', '2017-03-01 12:31:25'),
	(19, 79, 1, 1, 64, 1500, 4, 19, 570, NULL, 2, '3', '2017-03-01 12:31:25', '2017-03-01 12:31:25'),
	(26, 80, 1, 1, 54, 200, 3, 19, 38, NULL, 1, NULL, '2017-03-02 18:33:24', '2017-03-02 18:33:24'),
	(27, 80, 1, 1, 66, 300, 4, 19, 57, NULL, 1, 'obs2', '2017-03-02 18:33:24', '2017-03-02 18:33:24'),
	(28, 80, 1, 1, 65, 500, NULL, 0, NULL, NULL, 4, NULL, '2017-03-02 18:33:24', '2017-03-02 18:33:24'),
	(29, 80, 1, 1, 56, 700, NULL, NULL, NULL, NULL, 1, NULL, '2017-03-02 18:33:24', '2017-03-02 18:33:24'),
	(30, 89, 1, 1, 54, 2000, 3, 19, 380, NULL, 1, 'obs', '2017-03-03 14:20:59', '2017-03-03 14:20:59'),
	(31, 89, 1, 1, 63, 300, NULL, NULL, NULL, NULL, 1, NULL, '2017-03-03 14:20:59', '2017-03-03 14:20:59'),
	(32, 90, 1, 1, 54, 200, NULL, NULL, NULL, NULL, 1, NULL, '2017-03-03 14:33:32', '2017-03-03 14:33:32'),
	(33, 91, 1, 1, 66, 1500, 3, 19, 285, NULL, 1, NULL, '2017-03-03 14:47:03', '2017-03-03 14:47:03'),
	(37, 108, 1, 1, 109, 2000000, NULL, NULL, NULL, 2000000, 1, 'estas es mi transferencia', '2017-03-10 13:14:48', '2017-03-10 13:14:48'),
	(38, 109, 1, 1, 109, 2000000, NULL, NULL, NULL, 2000000, 1, 'estas es mi transferencia', '2017-03-10 13:14:48', '2017-03-10 13:14:48'),
	(40, 110, 1, 1, 109, 1000000, NULL, NULL, NULL, 1000000, 1, 'trasnsferencia hacia banco 2', '2017-03-10 13:24:53', '2017-03-10 13:24:53'),
	(41, 111, 1, 1, 109, 1000000, NULL, NULL, NULL, 1000000, 1, 'trasnsferencia hacia banco 2', '2017-03-10 13:24:53', '2017-03-10 13:24:53'),
	(44, 114, 1, 1, 109, 2000, NULL, NULL, NULL, 2000, 1, 'asas', '2017-03-10 17:13:46', '2017-03-10 17:13:46'),
	(45, 115, 1, 1, 109, 2000, NULL, NULL, NULL, 2000, 1, 'asas', '2017-03-10 17:13:46', '2017-03-10 17:13:46'),
	(46, 116, 1, 1, 109, 1000, NULL, NULL, NULL, 1000, 1, NULL, '2017-03-10 22:19:01', '2017-03-10 22:19:01'),
	(47, 117, 1, 1, 109, 1000, NULL, NULL, NULL, 1000, 1, NULL, '2017-03-10 22:19:01', '2017-03-10 22:19:01');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1 COMMENT='contains the whole set of contacts of each company';

-- Volcando datos para la tabla krece.contact: ~22 rows (aproximadamente)
DELETE FROM `contact`;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` (`id`, `account_id`, `user_id`, `public_id`, `name`, `nit`, `address`, `city`, `email`, `phone1`, `phone2`, `fax`, `phone_mobile`, `list_price_id`, `seller_id`, `payment_terms_id`, `observation`, `include_account_state`, `isProvider`, `isCustomer`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'cliente 1', '1234506', NULL, 'Bogotá', 'test@example.com', NULL, NULL, NULL, NULL, 1, 4, NULL, 'este contacto es primordpial', b'0', b'0', b'1', b'1', '2016-12-13 15:01:44', '2017-03-06 10:23:37', '2017-03-06 10:23:37'),
	(4, 1, 1, 2, 'cliente 2', '80810419', 'Calle 12 # 2-49', 'Bogotá', NULL, '3629222', NULL, NULL, NULL, 1, 4, 1, NULL, b'0', b'0', b'1', b'1', '2016-12-15 16:43:30', '2017-03-06 10:23:07', '2017-03-06 10:23:07'),
	(5, 1, 1, 3, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:43:37', '2017-01-31 15:24:11', '2017-01-31 15:24:11'),
	(6, 1, 1, 4, 'Proveedor 1', '123456', 'Calle 58 bogota', 'Bogota', 'prov1@gmail.com', NULL, NULL, NULL, NULL, 1, 2, 2, NULL, b'0', b'1', b'0', b'1', '2017-01-19 20:44:14', '2017-03-06 10:23:10', '2017-03-06 10:23:10'),
	(7, 1, 1, 5, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:44:32', '2017-01-31 12:23:03', '2017-01-31 12:23:03'),
	(8, 1, 1, 6, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:44:48', '2017-01-31 12:24:57', '2017-01-31 12:24:57'),
	(9, 1, 1, 7, 'proveedor 5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 4, 1, NULL, b'0', b'1', b'0', b'1', '2017-01-19 20:44:56', '2017-03-06 10:23:13', '2017-03-06 10:23:13'),
	(10, 1, 1, 8, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:45:18', '2017-01-31 13:43:28', '2017-01-31 13:43:28'),
	(11, 1, 1, 9, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:45:43', '2017-03-06 10:23:16', '2017-03-06 10:23:16'),
	(12, 1, 1, 10, 'as', '', '', '', '', '', '', '', '', NULL, NULL, 2, '', b'0', b'0', b'1', b'1', '2017-01-19 20:47:38', '2017-03-06 10:23:19', '2017-03-06 10:23:19'),
	(13, 1, 1, 11, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:50:41', '2017-03-06 10:23:22', '2017-03-06 10:23:22'),
	(14, 1, 1, 12, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:52:09', '2017-03-06 10:23:26', '2017-03-06 10:23:26'),
	(15, 1, 1, 13, 'prueba cliente', '', '', 'bogota', '', '', '', '', '', 1, 2, 2, '', b'0', b'0', b'1', b'1', '2017-01-19 20:55:22', '2017-03-06 10:23:04', '2017-03-06 10:23:04'),
	(16, 1, 1, 14, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:55:32', '2017-03-06 10:19:29', '2017-03-06 10:19:29'),
	(17, 1, 1, 15, 'as', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-19 20:57:22', '2017-03-06 10:19:33', '2017-03-06 10:19:33'),
	(18, 1, 1, 16, 'Fernando Ardila', '80810419', 'Calle 12 # 2-49', 'Bogota', 'fernando2684@gmail.com', '3123633753', 'phone2', '', '3123633753', 1, 2, 2, 'Observaciones', b'0', b'1', b'1', b'1', '2017-01-24 11:44:45', '2017-03-06 10:22:57', '2017-03-06 10:22:57'),
	(19, 1, 1, 17, 'test', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'1', '2017-01-24 16:44:45', '2017-03-06 10:23:01', '2017-03-06 10:23:01'),
	(20, 2, 2, 1, 'contacto1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-24 16:44:53', '2017-01-24 16:44:53', NULL),
	(21, 2, 2, 2, 'contacto 2', '', '', '', '', '', '', '', '', NULL, NULL, NULL, '', b'0', b'0', b'0', b'0', '2017-01-24 16:45:19', '2017-01-24 16:45:19', NULL),
	(22, 1, 1, 18, 'distribuciones IDRD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 4, 1, NULL, b'0', b'0', b'1', b'1', '2017-02-17 16:21:28', '2017-03-06 10:23:32', '2017-03-06 10:23:32'),
	(23, 1, 1, 19, 'contact-provider', '123457', 'Call 23 # 54', 'Bogota', 'fernando2684@gmail.com', NULL, NULL, NULL, NULL, 1, 4, 1, NULL, b'0', b'1', b'1', b'1', '2017-02-28 10:13:24', '2017-03-06 10:23:35', '2017-03-06 10:23:35'),
	(24, 1, 1, 20, 'contacto-proveedor', '123456', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 4, 1, NULL, b'0', b'1', b'0', b'0', '2017-03-06 11:11:03', '2017-03-16 15:12:43', NULL),
	(25, 1, 1, 21, 'contacto-cliente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 4, 1, NULL, b'0', b'0', b'1', b'0', '2017-03-06 11:20:50', '2017-03-06 11:21:00', NULL),
	(26, 1, 1, 22, 'Test', '121212', NULL, NULL, NULL, NULL, NULL, NULL, '122433432', 1, 4, 1, '3242332', b'0', b'1', b'1', b'0', '2017-03-17 11:40:24', '2017-03-17 14:16:08', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note: ~2 rows (aproximadamente)
DELETE FROM `credit_note`;
/*!40000 ALTER TABLE `credit_note` DISABLE KEYS */;
INSERT INTO `credit_note` (`id`, `account_id`, `user_id`, `public_id`, `resolution_id`, `list_price_id`, `customer_id`, `currency_code`, `date`, `notes`, `observations`, `exchange_rate`, `sub_total`, `total`, `total_discounts`, `total_taxes`, `amount_pending_to_apply`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 1, 4, 'COP', '2017-02-15', 'as', 'as', NULL, 8000, 9163, 300, 1463, NULL, b'1', '2017-02-15 12:28:37', '2017-03-06 09:48:11', '2017-03-06 09:48:11'),
	(2, 1, 1, 2, 2, 1, 4, 'COP', '2017-02-15', NULL, NULL, NULL, 9000, 9840, 300, 1140, NULL, b'1', '2017-02-15 13:28:09', '2017-02-15 13:28:25', '2017-02-15 13:28:25'),
	(3, 1, 1, 3, 3, 1, 25, 'COP', '2017-03-13', 'notas visibles en la cotización', 'notas no visibles en la cotización', NULL, 7000, 7000, 0, 0, NULL, b'0', '2017-03-13 13:58:26', '2017-03-13 13:58:26', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.credit_note_detail: ~7 rows (aproximadamente)
DELETE FROM `credit_note_detail`;
/*!40000 ALTER TABLE `credit_note_detail` DISABLE KEYS */;
INSERT INTO `credit_note_detail` (`id`, `credit_note_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `name`, `description`, `quantity`, `total_tax`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(3, 1, 1, 4, '1234', 5000, 0, 3, 19, 'productoprueba', 'producto para pruebas', 1, 950, 5000, '2017-02-15 13:02:53', '2017-02-15 13:02:53', NULL),
	(4, 1, 1, 3, 'ref2', 3000, 10, 4, 19, 'producto 2', 'descripcion producto 2', 1, 513, 2700, '2017-02-15 13:02:53', '2017-02-15 13:02:53', NULL),
	(5, 2, 1, 3, 'ref2', 3000, 0, 3, 19, 'producto 2', 'descripcion producto 2', 1, 570, 3000, '2017-02-15 13:28:10', '2017-02-15 13:28:10', NULL),
	(6, 2, 1, 3, 'ref2', 3000, 10, NULL, 0, 'producto 2', 'descripcion producto 2', 1, 0, 2700, '2017-02-15 13:28:10', '2017-02-15 13:28:10', NULL),
	(7, 2, 1, 3, 'ref2', 3000, 0, 4, 19, 'producto 2', 'descripcion producto 2', 1, 570, 3000, '2017-02-15 13:28:10', '2017-02-15 13:28:10', NULL),
	(8, 3, 1, 6, NULL, 2000, 0, NULL, 0, 'producto-1-inv', NULL, 1, 0, 2000, '2017-03-13 13:58:26', '2017-03-13 13:58:26', NULL),
	(9, 3, 1, 7, NULL, 5000, 0, NULL, 0, 'producto-2-no-inv', NULL, 1, 0, 5000, '2017-03-13 13:58:26', '2017-03-13 13:58:26', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.debit_note: ~2 rows (aproximadamente)
DELETE FROM `debit_note`;
/*!40000 ALTER TABLE `debit_note` DISABLE KEYS */;
INSERT INTO `debit_note` (`id`, `account_id`, `user_id`, `public_id`, `resolution_id`, `customer_id`, `date`, `currency_code`, `observations`, `exchange_rate`, `amount_pending_to_apply`, `sub_total`, `total_taxes`, `total_discounts`, `total`, `isDeleted`, `updated_at`, `created_at`, `deleted_at`) VALUES
	(5, 1, 1, 1, 1, 6, '2017-02-24', 'COP', 'observations', NULL, NULL, 4000, 752.4, 40, 4712.4, b'1', '2017-03-06 09:51:56', '2017-02-24 15:12:13', '2017-03-06 09:51:56'),
	(6, 1, 1, 2, 2, 18, '2017-02-24', 'COP', 'esta es una nota credito de prueba', NULL, NULL, 5086250, 966388, 0, 6052640, b'1', '2017-02-24 15:31:28', '2017-02-24 15:28:39', '2017-02-24 15:31:28'),
	(7, 1, 1, 3, 4, 24, '2017-03-14', 'COP', 'observaciones nota debito', NULL, NULL, 5000, 380, 0, 5380, b'0', '2017-03-14 15:31:59', '2017-03-14 15:31:59', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.debit_note_detail: ~6 rows (aproximadamente)
DELETE FROM `debit_note_detail`;
/*!40000 ALTER TABLE `debit_note_detail` DISABLE KEYS */;
INSERT INTO `debit_note_detail` (`id`, `debit_note_id`, `user_id`, `category_id`, `product_id`, `name`, `description`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `total_tax`, `quantity`, `total`, `updated_at`, `created_at`) VALUES
	(12, 5, 1, 54, NULL, 'Alquiler de equipos y licencias', 'equipos para mi', 2000, 2, 4, 19, 372.4, 1, 1960, '2017-02-24 15:27:33', '2017-02-24 15:27:33'),
	(13, 5, 1, 65, NULL, 'Egresos no operacionales', NULL, 0, 0, NULL, 0, 0, 1, 0, '2017-02-24 15:27:33', '2017-02-24 15:27:33'),
	(14, 5, 1, 66, NULL, 'Descuento financiero', NULL, 2000, 0, 3, 19, 380, 1, 2000, '2017-02-24 15:27:33', '2017-02-24 15:27:33'),
	(15, 6, 1, 66, NULL, 'Descuento financiero', 'test', 5086250, 0, 3, 19, 966388, 1, 5086250, '2017-02-24 15:28:39', '2017-02-24 15:28:39'),
	(16, 7, 1, 54, NULL, 'Alquiler de equipos y licencias', NULL, 2000, 0, 3, 19, 380, 1, 2000, '2017-03-14 15:31:59', '2017-03-14 15:31:59'),
	(17, 7, 1, 55, NULL, 'Comisiones y honorarios', NULL, 3000, 0, NULL, 0, 0, 1, 3000, '2017-03-14 15:31:59', '2017-03-14 15:31:59');
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate: ~30 rows (aproximadamente)
DELETE FROM `estimate`;
/*!40000 ALTER TABLE `estimate` DISABLE KEYS */;
INSERT INTO `estimate` (`id`, `account_id`, `public_id`, `resolution_id`, `user_id`, `seller_id`, `list_price_id`, `customer_id`, `currency_code`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `date`, `due_date`, `notes`, `observations`, `exchange_rate`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 2000, '2016-12-13', '2016-12-13', 'notas act', 'observaciones', 1, b'1', '2016-12-13 14:51:38', '2017-03-06 09:51:15', '2017-03-06 09:51:15'),
	(2, 2, 1, 1, 2, NULL, NULL, 1, 'COP', NULL, NULL, NULL, 123, '2016-12-13', '2016-12-13', 'notes', 'observ', 1, b'0', '2016-12-13 18:07:49', '2016-12-13 18:07:50', NULL),
	(4, 1, 2, 2, 1, 1, 1, 1, 'COP', 3000, 0, 0, 3000, '2017-01-12', '2017-01-12', 'notas', NULL, NULL, b'1', '2017-01-03 19:52:07', '2017-03-06 09:51:11', '2017-03-06 09:51:11'),
	(7, 1, 3, 3, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 2000, '2017-01-13', '2017-01-13', 'nota', NULL, NULL, b'1', '2017-01-03 20:30:07', '2017-03-06 09:49:29', '2017-03-06 09:49:29'),
	(9, 1, 4, 4, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:14:12', '2017-03-06 09:51:07', '2017-03-06 09:51:07'),
	(10, 1, 5, 5, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:15:14', '2017-03-06 09:49:25', '2017-03-06 09:49:25'),
	(11, 1, 6, 6, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:16:45', '2017-03-06 09:51:04', '2017-03-06 09:51:04'),
	(12, 1, 7, 7, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:17:51', '2017-03-06 09:51:00', '2017-03-06 09:51:00'),
	(13, 1, 8, 8, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:18:05', '2017-03-06 09:49:17', '2017-03-06 09:49:17'),
	(14, 1, 9, 9, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:20:11', '2017-03-06 09:49:13', '2017-03-06 09:49:13'),
	(15, 1, 10, 10, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:20:55', '2017-02-06 09:51:15', '2017-02-06 09:51:15'),
	(16, 1, 11, 11, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:20:57', '2017-02-06 09:51:10', '2017-02-06 09:51:10'),
	(17, 1, 12, 12, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:21:05', '2017-03-06 09:49:08', '2017-03-06 09:49:08'),
	(18, 1, 13, 13, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:27:20', '2017-02-06 09:51:04', '2017-02-06 09:51:04'),
	(19, 1, 14, 14, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 2000, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:27:38', '2017-03-06 09:49:04', '2017-03-06 09:49:04'),
	(20, 1, 15, 15, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:39:30', '2017-02-06 09:48:58', '2017-02-06 09:48:58'),
	(21, 1, 16, 16, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:47:33', '2017-02-06 09:51:00', '2017-02-06 09:51:00'),
	(22, 1, 17, 17, 1, 4, 1, 1, 'COP', 7444, 300, 513, 7657, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:48:15', '2017-03-06 09:49:00', '2017-03-06 09:49:00'),
	(23, 1, 18, 18, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:49:24', '2017-02-06 09:50:52', '2017-02-06 09:50:52'),
	(24, 1, 19, 19, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, NULL, '2017-04-01', '2017-03-01', 'as', 'as', NULL, b'1', '2017-01-03 21:53:19', '2017-02-06 08:53:12', '2017-02-06 08:53:12'),
	(25, 1, 20, 20, 1, 1, 1, 4, 'COP', 90001.1, 8500.09, 0, 81501.1, '2017-01-07', '2017-01-25', 'notas cotizacion2', 'observaciones23', NULL, b'1', '2017-01-04 21:09:53', '2017-03-06 09:48:57', '2017-03-06 09:48:57'),
	(26, 1, 21, 21, 1, 1, 1, 1, 'COP', 64000, 300, 4500, 68200, '2017-01-08', '2017-01-14', 'estas notas deben salir en la cotización final.', NULL, NULL, b'1', '2017-01-07 10:12:05', '2017-03-06 09:48:52', '2017-03-06 09:48:52'),
	(27, 1, 22, 22, 1, NULL, 1, 1, 'COP', NULL, NULL, NULL, 20000, '2017-01-11', '2017-01-18', 'noras cot', 'onserv', NULL, b'1', '2017-01-11 12:09:06', '2017-03-06 09:48:49', '2017-03-06 09:48:49'),
	(28, 1, 23, 23, 1, 2, 1, 4, 'COP', NULL, NULL, NULL, 2000, '2017-01-12', '2017-01-27', 'Notas creadas', 'observaciones', NULL, b'1', '2017-01-12 13:35:59', '2017-03-06 09:48:37', '2017-03-06 09:48:37'),
	(29, 1, 24, 24, 1, 4, 1, 18, 'USD', 8000, 0, 950, 8950, '2017-01-24', '2017-02-02', 'asas', 'observaciones', NULL, b'1', '2017-01-24 13:15:26', '2017-03-06 09:48:41', '2017-03-06 09:48:41'),
	(30, 1, 25, 25, 1, 2, 1, 1, 'COP', 5000, 500, 855, 5355, '2017-02-04', '2017-03-10', 'asas', NULL, NULL, b'1', '2017-02-04 13:01:42', '2017-03-06 09:48:45', '2017-03-06 09:48:45'),
	(31, 1, 26, 26, 1, 4, 2, 4, 'USD', 2000, 0, 0, 2000, '2017-02-07', '2017-03-02', 'notas de la cotización', NULL, NULL, b'1', '2017-02-07 20:50:32', '2017-03-06 09:49:21', '2017-03-06 09:49:21'),
	(32, 1, 27, 27, 1, 4, 2, 4, 'USD', 2000, 0, 0, 2000, '2017-02-07', '2017-03-02', 'notas de la cotización', NULL, NULL, b'1', '2017-02-09 14:08:33', '2017-03-06 09:50:57', '2017-03-06 09:50:57'),
	(33, 1, 28, 28, 1, 4, 2, 4, 'USD', 15000, 0, 0, 15000, '2017-02-07', '2017-03-02', 'notas de la cotización', NULL, NULL, b'1', '2017-02-09 14:16:51', '2017-03-06 09:50:53', '2017-03-06 09:50:53'),
	(34, 1, 29, 29, 1, 4, 2, 1, 'USD', 4000, 200, 361, 4161, '2017-02-10', '2017-03-03', 'Estas son las notas no visibles en la cotización', 'observaciones', NULL, b'1', '2017-02-10 13:37:25', '2017-03-06 09:50:49', '2017-03-06 09:50:49'),
	(35, 1, 30, 35, 1, 4, 2, 4, 'COP', 7000, 0, 0, 7000, '2017-02-10', '2017-02-16', 'testtt', NULL, NULL, b'1', '2017-02-10 13:40:14', '2017-03-06 09:50:45', '2017-03-06 09:50:45'),
	(36, 1, 31, 36, 1, 1, 1, 1, 'COP', 7000, 400, 950, 7550, '2017-02-10', '2017-03-03', 'esta fue una cotización clonada', NULL, NULL, b'1', '2017-02-10 14:15:14', '2017-03-06 09:50:42', '2017-03-06 09:50:42'),
	(37, 1, 32, 37, 1, 4, 1, 4, 'COP', 5000, 0, 0, 5000, '2017-02-12', '2017-02-09', 'asas', 'as', NULL, b'1', '2017-02-12 14:18:38', '2017-03-06 09:50:38', '2017-03-06 09:50:38'),
	(38, 1, 33, 38, 1, 4, 1, 25, 'COP', 7000, 0, 380, 7380, '2017-03-08', '2017-04-07', 'notas de la cotizacion jakhjksahdsjak', 'observaciones zjkahsjkashj', NULL, b'0', '2017-03-08 17:14:19', '2017-03-08 17:35:57', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.estimate_detail: ~39 rows (aproximadamente)
DELETE FROM `estimate_detail`;
/*!40000 ALTER TABLE `estimate_detail` DISABLE KEYS */;
INSERT INTO `estimate_detail` (`id`, `estimate_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `name`, `description`, `quantity`, `total_tax`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(4, 23, 1, 2, NULL, 2222, 0, NULL, 0, NULL, 'descripcion', 2, 0, 4444, '2017-01-03 21:49:24', '2017-01-03 21:49:24', NULL),
	(5, 24, 1, 2, NULL, 2222, 0, NULL, 0, NULL, 'descripcion', 2, 0, 4444, '2017-01-03 21:53:19', '2017-01-03 21:53:19', NULL),
	(6, 24, 1, 2, NULL, 30000, 0, NULL, 0, NULL, 'desc2', 1, 0, 30000, '2017-01-03 21:53:19', '2017-01-03 21:53:19', NULL),
	(44, 27, 1, 2, NULL, 20000, 0, NULL, 1, NULL, 'desc prod1', 1, 0, 20000, '2017-01-11 12:09:07', '2017-01-11 12:09:07', NULL),
	(69, 1, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-01-12 17:54:59', '2017-01-12 17:54:59', NULL),
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
	(101, 31, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-07 20:50:32', '2017-02-07 20:50:32', NULL),
	(102, 4, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-09 11:54:38', '2017-02-09 11:54:38', NULL),
	(103, 32, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-09 14:08:33', '2017-02-09 14:08:33', NULL),
	(104, 33, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-09 14:16:51', '2017-02-09 14:16:51', NULL),
	(105, 33, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-09 14:16:51', '2017-02-09 14:16:51', NULL),
	(106, 33, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-09 14:16:51', '2017-02-09 14:16:51', NULL),
	(107, 33, 1, 4, NULL, 5000, 0, NULL, 0, NULL, 'producto para pruebas', 1, 0, 5000, '2017-02-09 14:16:51', '2017-02-09 14:16:51', NULL),
	(108, 33, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-09 14:16:51', '2017-02-09 14:16:51', NULL),
	(109, 34, 1, 2, NULL, 2000, 5, NULL, 19, NULL, 'producto 1', 1, 0, 2000, '2017-02-10 13:37:25', '2017-02-10 13:37:25', NULL),
	(110, 34, 1, 2, NULL, 2000, 5, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-10 13:37:25', '2017-02-10 13:37:25', NULL),
	(111, 35, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-10 13:40:14', '2017-02-10 13:40:14', NULL),
	(112, 35, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-10 13:40:14', '2017-02-10 13:40:14', NULL),
	(113, 35, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-10 13:40:14', '2017-02-10 13:40:14', NULL),
	(114, 36, 1, 3, NULL, 3000, 0, NULL, 19, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-10 14:15:14', '2017-02-10 14:15:14', NULL),
	(115, 36, 1, 2, NULL, 2000, 0, NULL, 19, NULL, 'producto 1', 1, 0, 2000, '2017-02-10 14:15:14', '2017-02-10 14:15:14', NULL),
	(116, 36, 1, 2, NULL, 2000, 20, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-10 14:15:14', '2017-02-10 14:15:14', NULL),
	(218, 37, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 0, 2000, '2017-02-13 12:40:27', '2017-02-13 12:40:27', NULL),
	(219, 37, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 0, 3000, '2017-02-13 12:40:27', '2017-02-13 12:40:27', NULL),
	(225, 38, 1, 6, NULL, 2000, 0, 3, 19, NULL, NULL, 1, 380, 2000, '2017-03-08 17:35:57', '2017-03-08 17:35:57', NULL),
	(226, 38, 1, 7, NULL, 5000, 0, NULL, 0, NULL, NULL, 1, 0, 5000, '2017-03-08 17:35:57', '2017-03-08 17:35:57', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COMMENT='Header of sale invoices';

-- Volcando datos para la tabla krece.invoice_sale_order: ~18 rows (aproximadamente)
DELETE FROM `invoice_sale_order`;
/*!40000 ALTER TABLE `invoice_sale_order` DISABLE KEYS */;
INSERT INTO `invoice_sale_order` (`id`, `public_id`, `user_id`, `account_id`, `resolution_id`, `customer_id`, `date`, `due_date`, `payment_terms_id`, `status_id`, `notes`, `observations`, `seller_id`, `list_price_id`, `category_id`, `currency_code`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `currency_code_multicurrency`, `exchange_rate`, `isRecurring`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(11, 1, 1, 1, 1, 4, '2017-02-14', '2017-02-14', '2', 1, 'asas', NULL, 4, 1, 34, 'COP', 7000, 400, 380, 6980, NULL, NULL, b'0', b'1', '2017-02-14 14:11:36', '2017-02-14 15:23:31', '2017-02-14 15:23:31'),
	(12, 2, 1, 1, 2, 1, '2017-02-14', '2017-02-14', '2', 6, 'asa', 'as', 4, 1, 34, 'COP', 3000, 0, 0, 3000, NULL, NULL, b'0', b'1', '2017-02-14 14:22:03', '2017-03-06 10:13:24', '2017-03-06 10:13:24'),
	(13, 3, 1, 1, 3, 4, '2017-02-14', '2017-02-22', '3', 6, 'asas', NULL, 4, 1, 34, 'COP', 11000, 0, 0, 11000, NULL, NULL, b'0', b'1', '2017-02-14 15:28:09', '2017-03-06 10:13:21', '2017-03-06 10:13:21'),
	(14, 4, 1, 1, 4, 4, '2017-02-14', '2017-02-14', '2', 1, 'as', 'as', 4, 1, 34, 'COP', 7000, 0, 380, 7380, NULL, NULL, b'0', b'1', '2017-02-14 15:28:21', '2017-03-06 09:47:05', '2017-03-06 09:47:05'),
	(15, 5, 1, 1, 5, 12, '2017-02-14', '2017-02-22', '3', 1, 'asas', 'as', 4, 1, 34, 'COP', 5000, 0, 950, 5950, NULL, NULL, b'0', b'1', '2017-01-14 17:22:54', '2017-03-06 09:47:20', '2017-03-06 09:47:20'),
	(16, 6, 1, 1, 6, 4, '2017-02-14', '2017-02-14', '2', 1, 'asa', 'sa', 4, 1, 34, 'COP', 10000, 0, 1330, 11330, NULL, NULL, b'0', b'1', '2017-02-14 17:26:14', '2017-03-06 09:47:09', '2017-03-06 09:47:09'),
	(17, 7, 1, 1, 7, 4, '2017-02-15', '2017-02-15', '2', 1, 'asas', 'as', 4, 1, 34, 'COP', 7000, 0, 950, 7950, NULL, NULL, b'0', b'1', '2017-01-15 10:16:28', '2017-03-06 09:47:13', '2017-03-06 09:47:13'),
	(18, 8, 1, 1, 1, 22, '2017-02-17', '2017-02-17', '2', 6, 'Notas', 'observaciones', 4, 1, 34, 'COP', 32000, 500, 4750, 36250, NULL, NULL, b'0', b'1', '2017-02-17 16:23:49', '2017-03-06 10:13:28', '2017-03-06 10:13:28'),
	(19, 9, 1, 1, 9, 22, '2017-02-17', '2017-02-17', '2', 1, 'nota', NULL, 4, 1, 34, 'COP', 6000, 400, 380, 5980, NULL, NULL, b'0', b'1', '2017-02-17 16:31:24', '2017-03-06 09:46:58', '2017-03-06 09:46:58'),
	(20, 10, 1, 1, 10, 4, '2017-02-20', '2017-02-20', '1', 1, 'test', NULL, 4, 1, 34, 'COP', 15000, 0, 0, 15000, NULL, NULL, b'0', b'1', '2017-02-20 19:06:13', '2017-03-06 09:46:54', '2017-03-06 09:46:54'),
	(21, 11, 1, 1, 11, 1, '2017-02-22', '2017-02-22', '1', 1, 'asas', NULL, 4, 1, 34, 'COP', 5000, 0, 0, 5000, NULL, NULL, b'0', b'1', '2017-02-22 13:30:50', '2017-03-06 09:46:50', '2017-03-06 09:46:50'),
	(22, 12, 1, 1, 12, 1, '2017-02-24', '2017-02-24', '1', 1, 'qwq', NULL, 4, 1, 34, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'1', '2017-02-24 20:09:25', '2017-03-06 09:46:46', '2017-03-06 09:46:46'),
	(23, 13, 1, 1, 13, 1, '2017-02-27', '2017-02-27', '1', 6, 'qw', NULL, 4, 1, 34, 'COP', 5000, 0, 0, 5000, NULL, NULL, b'0', b'1', '2017-02-27 17:34:30', '2017-03-06 10:13:16', '2017-03-06 10:13:16'),
	(24, 14, 1, 1, 14, 1, '2017-02-27', '2017-02-27', '1', 1, 'as', 'as', 4, 1, 34, 'COP', 7000, 0, 0, 7000, NULL, NULL, b'0', b'1', '2017-02-27 21:49:09', '2017-03-06 09:46:42', '2017-03-06 09:46:42'),
	(25, 15, 1, 1, 15, 23, '2017-02-28', '2017-03-09', '2', 1, 'estas notas están visibles', NULL, 4, 1, 34, 'COP', 10000, 0, 0, 10000, NULL, NULL, b'0', b'1', '2017-02-28 10:14:20', '2017-03-06 09:46:39', '2017-03-06 09:46:39'),
	(26, 16, 1, 1, 16, 1, '2017-05-03', '2017-05-31', '2', 1, 'Creado desde mi phone', NULL, 4, 1, 34, 'COP', 4000, 0, 0, 4000, NULL, NULL, b'0', b'1', '2017-03-05 11:15:50', '2017-03-06 09:46:34', '2017-03-06 09:46:34'),
	(27, 17, 1, 1, 17, 25, '2017-03-13', '2017-03-13', '1', 2, 'notas visibles en la factura', NULL, 4, 1, 34, 'COP', 2000, 0, 0, 2000, NULL, NULL, b'0', b'0', '2017-03-13 12:24:32', '2017-03-13 13:09:28', NULL),
	(28, 18, 1, 1, 18, 25, '2017-03-13', '2017-03-13', '1', 1, 'notas visibles test2', NULL, 4, 1, 34, 'COP', 14000, 0, 0, 14000, NULL, NULL, b'0', b'0', '2017-03-13 12:29:37', '2017-03-16 21:26:45', NULL),
	(29, 19, 1, 1, 19, 25, '2017-03-17', '2017-03-17', '2', 1, 'notas factura venta', 'asqwqw', 4, 1, 34, 'COP', 19000, 1500, 760, 18260, NULL, NULL, b'0', b'0', '2017-03-17 09:16:09', '2017-03-17 09:16:09', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.invoice_sale_order_detail: ~37 rows (aproximadamente)
DELETE FROM `invoice_sale_order_detail`;
/*!40000 ALTER TABLE `invoice_sale_order_detail` DISABLE KEYS */;
INSERT INTO `invoice_sale_order_detail` (`id`, `invoice_sale_order_id`, `user_id`, `tax_id`, `product_id`, `name`, `description`, `reference`, `unit_price`, `discount`, `tax_amount`, `quantity`, `total`, `total_tax`, `created_at`, `updated_at`) VALUES
	(5, 11, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 20, 0, 1, 1600, NULL, '2017-02-14 14:18:56', '2017-02-14 14:18:56'),
	(6, 11, 1, NULL, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 0, 1, 3000, NULL, '2017-02-14 14:18:56', '2017-02-14 14:18:56'),
	(7, 11, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 19, 1, 2000, NULL, '2017-02-14 14:18:56', '2017-02-14 14:18:56'),
	(8, 12, 1, NULL, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 0, 1, 3000, NULL, '2017-02-14 14:22:03', '2017-02-14 14:22:03'),
	(9, 13, 1, NULL, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 0, 1, 3000, NULL, '2017-02-14 15:28:09', '2017-02-14 15:28:09'),
	(10, 13, 1, NULL, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 0, 1, 3000, NULL, '2017-02-14 15:28:09', '2017-02-14 15:28:09'),
	(11, 13, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, NULL, '2017-02-14 15:28:09', '2017-02-14 15:28:09'),
	(13, 14, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, NULL, '2017-02-14 16:44:15', '2017-02-14 16:44:15'),
	(14, 14, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 19, 1, 2000, NULL, '2017-02-14 16:44:16', '2017-02-14 16:44:16'),
	(17, 15, 1, 3, 2, NULL, 'producto 1', 'ref', 2000, 0, 19, 1, 2000, NULL, '2017-02-14 17:24:15', '2017-02-14 17:24:15'),
	(18, 15, 1, 4, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 19, 1, 3000, NULL, '2017-02-14 17:24:15', '2017-02-14 17:24:15'),
	(37, 16, 1, 3, 2, NULL, 'producto 1', 'ref', 2000, 0, 19, 1, 2000, 380, '2017-02-14 18:12:17', '2017-02-14 18:12:17'),
	(38, 16, 1, 5, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 0, 1, 3000, 0, '2017-02-14 18:12:17', '2017-02-14 18:12:17'),
	(39, 16, 1, 4, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 19, 1, 5000, 950, '2017-02-14 18:12:17', '2017-02-14 18:12:17'),
	(42, 17, 1, 3, 2, NULL, 'producto 1', 'ref', 2000, 0, 19, 1, 2000, 380, '2017-02-15 12:35:23', '2017-02-15 12:35:23'),
	(43, 17, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-02-15 12:35:23', '2017-02-15 12:35:23'),
	(44, 17, 1, 4, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 19, 1, 3000, 570, '2017-02-15 12:35:23', '2017-02-15 12:35:23'),
	(48, 19, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 20, 0, 1, 1600, 0, '2017-02-17 16:31:24', '2017-02-17 16:31:24'),
	(49, 19, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-02-17 16:31:25', '2017-02-17 16:31:25'),
	(50, 19, 1, 3, 2, NULL, 'producto 1', 'ref', 2000, 0, 19, 1, 2000, 380, '2017-02-17 16:31:25', '2017-02-17 16:31:25'),
	(51, 18, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 2000, 0, 0, 1, 2000, 0, '2017-02-20 15:05:57', '2017-02-20 15:05:57'),
	(52, 18, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 10, 0, 1, 4500, 0, '2017-02-20 15:05:57', '2017-02-20 15:05:57'),
	(53, 18, 1, 4, 4, NULL, 'producto para pruebas', '1234', 25000, 0, 19, 1, 25000, 4750, '2017-02-20 15:05:57', '2017-02-20 15:05:57'),
	(54, 20, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, 0, '2017-02-20 19:06:13', '2017-02-20 19:06:13'),
	(55, 20, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-02-20 19:06:13', '2017-02-20 19:06:13'),
	(56, 20, 1, NULL, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 0, 1, 3000, 0, '2017-02-20 19:06:13', '2017-02-20 19:06:13'),
	(57, 20, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, 0, '2017-02-20 19:06:14', '2017-02-20 19:06:14'),
	(58, 21, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, 0, '2017-02-22 13:30:50', '2017-02-22 13:30:50'),
	(59, 22, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-02-24 20:09:26', '2017-02-24 20:09:26'),
	(60, 23, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, 0, '2017-02-27 17:34:30', '2017-02-27 17:34:30'),
	(63, 24, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, 0, '2017-02-27 21:53:09', '2017-02-27 21:53:09'),
	(64, 24, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-02-27 21:53:09', '2017-02-27 21:53:09'),
	(72, 25, 1, NULL, 4, NULL, 'producto para pruebas', '1234', 5000, 0, 0, 1, 5000, 0, '2017-03-06 08:33:05', '2017-03-06 08:33:05'),
	(73, 25, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-03-06 08:33:05', '2017-03-06 08:33:05'),
	(74, 25, 1, NULL, 3, NULL, 'descripcion producto 2', 'ref2', 3000, 0, 0, 1, 3000, 0, '2017-03-06 08:33:05', '2017-03-06 08:33:05'),
	(79, 26, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-03-06 08:53:57', '2017-03-06 08:53:57'),
	(80, 26, 1, NULL, 2, NULL, 'producto 1', 'ref', 2000, 0, 0, 1, 2000, 0, '2017-03-06 08:53:57', '2017-03-06 08:53:57'),
	(81, 28, 1, NULL, 6, NULL, NULL, NULL, 2000, 0, 0, 2, 4000, 0, '2017-03-13 12:38:25', '2017-03-13 12:38:25'),
	(82, 28, 1, NULL, 7, NULL, NULL, NULL, 5000, 0, 0, 2, 10000, 0, '2017-03-13 12:38:25', '2017-03-13 12:38:25'),
	(83, 27, 1, NULL, 6, NULL, NULL, NULL, 2000, 0, 0, 1, 2000, 0, '2017-03-13 13:09:24', '2017-03-13 13:09:24'),
	(84, 29, 1, 3, 6, NULL, NULL, NULL, 2000, 0, 19, 2, 4000, 760, '2017-03-17 09:16:09', '2017-03-17 09:16:09'),
	(85, 29, 1, NULL, 7, NULL, NULL, NULL, 5000, 10, 0, 3, 13500, 0, '2017-03-17 09:16:10', '2017-03-17 09:16:10');
/*!40000 ALTER TABLE `invoice_sale_order_detail` ENABLE KEYS */;

-- Volcando estructura para tabla krece.invoice_sale_order_estimate
CREATE TABLE IF NOT EXISTS `invoice_sale_order_estimate` (
  `invoice_sale_order_id` bigint(20) NOT NULL,
  `estimate_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_sale_order_id`,`estimate_id`),
  KEY `FK_isoq_quote_id` (`estimate_id`),
  CONSTRAINT `FK_isoq_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `estimate` (`id`),
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COMMENT='Store the list price information';

-- Volcando datos para la tabla krece.list_price: ~7 rows (aproximadamente)
DELETE FROM `list_price`;
/*!40000 ALTER TABLE `list_price` DISABLE KEYS */;
INSERT INTO `list_price` (`id`, `account_id`, `user_id`, `public_id`, `name`, `type_id`, `value`, `isDefault`, `created_at`, `updated_at`, `deleted_at`, `isEnabled`, `isDeleted`) VALUES
	(1, 1, 1, 1, 'General', 2, 0, b'1', '2017-01-05 13:24:27', '2017-01-19 13:01:51', NULL, b'1', b'0'),
	(2, 1, 1, 2, 'lista precios 1', 2, 0, b'0', '2017-01-19 12:27:29', '2017-01-26 21:06:56', '2017-01-19 13:49:28', b'0', b'0'),
	(3, 1, 1, 3, 'lista precios 2', 1, 16, b'0', '2017-01-19 12:31:54', '2017-01-19 14:01:42', NULL, b'0', b'0'),
	(4, 2, 2, 1, 'General', 2, 0, b'1', '2017-03-22 21:05:57', '2017-03-22 21:05:57', NULL, b'1', b'0'),
	(5, 6, 7, 1, 'General', 2, 0, b'1', '2017-03-22 21:23:01', '2017-03-22 21:23:01', NULL, b'1', b'0'),
	(6, 7, 8, 1, 'General', 2, 0, b'1', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL, b'1', b'0'),
	(7, 9, 10, 1, 'General', 2, 0, b'1', '2017-03-22 22:01:25', '2017-03-22 22:01:25', NULL, b'1', b'0'),
	(8, 10, 11, 1, 'General', 2, 0, b'1', '2017-03-22 22:02:02', '2017-03-22 22:02:02', NULL, b'1', b'0');
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

-- Volcando datos para la tabla krece.migrations: ~1 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2017_01_31_210849_create_treeexamples_table', 1),
	(2, '2017_03_23_070113_create_failed_jobs_table', 2);
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

-- Volcando datos para la tabla krece.password_resets: ~1 rows (aproximadamente)
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
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment: ~28 rows (aproximadamente)
DELETE FROM `payment`;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` (`id`, `resolution_id`, `public_id`, `user_id`, `account_id`, `customer_id`, `date`, `bank_account_id`, `observations`, `notes`, `payment_method_id`, `currency_code`, `type_id`, `status_id`, `parent_id`, `isInvoice`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(31, 10, 11, 1, 1, 1, '2017-02-17', 1, NULL, NULL, 1, 'COP', 'in', 1, NULL, b'1', b'1', '2017-02-17 11:26:44', '2017-03-06 09:47:38', '2017-03-06 09:47:38'),
	(32, 12, 12, 1, 1, 4, '2017-02-24', 1, 'Mis observaciones', 'Notas del recibo', 2, 'COP', 'in', 1, NULL, b'1', b'1', '2017-02-17 11:59:58', '2017-03-06 09:47:42', '2017-03-06 09:47:42'),
	(33, 13, 13, 1, 1, 1, '2017-02-17', 1, NULL, NULL, 1, 'COP', 'in', 1, NULL, b'1', b'1', '2017-02-17 13:49:13', '2017-03-06 09:47:45', '2017-03-06 09:47:45'),
	(34, 14, 14, 1, 1, 1, '2017-02-17', 2, NULL, NULL, 3, 'COP', 'in', 1, NULL, b'1', b'1', '2017-02-17 15:29:28', '2017-02-17 18:38:40', '2017-02-17 18:38:40'),
	(35, 15, 15, 1, 1, 22, '2017-02-17', 1, NULL, 'pago ejemplo', 1, 'COP', 'in', 1, NULL, b'1', b'1', '2017-02-17 16:25:49', '2017-03-06 09:47:59', '2017-03-06 09:47:59'),
	(36, 16, 16, 1, 1, 22, '2017-02-23', 1, NULL, NULL, 4, 'COP', 'in', 1, NULL, b'1', b'0', '2017-02-17 16:34:29', '2017-03-03 11:32:05', NULL),
	(45, 1, 17, 1, 1, 23, '2017-02-28', 1, 'Observaciones', 'Notas de egreso', 1, 'COP', 'eg', 1, NULL, b'1', b'0', '2017-02-28 11:54:32', '2017-03-03 19:00:58', NULL),
	(46, 4, 18, 1, 1, 23, '2017-02-28', 1, NULL, NULL, 2, 'COP', 'eg', 1, NULL, b'1', b'1', '2017-02-28 12:22:44', '2017-03-03 14:42:10', '2017-03-03 14:42:10'),
	(79, 5, 19, 1, 1, 6, '2017-02-28', 1, 'obs', 'notes 1', 1, 'COP', 'eg', 1, NULL, b'0', b'1', '2017-02-28 18:36:33', '2017-03-10 09:31:28', '2017-03-10 09:31:28'),
	(80, 17, 20, 1, 1, 1, '2017-03-02', 1, NULL, NULL, 2, 'COP', 'in', 1, NULL, b'0', b'1', '2017-03-02 15:21:40', '2017-03-06 09:47:49', '2017-03-06 09:47:49'),
	(86, 12, 21, 1, 1, 6, '2017-03-03', 1, NULL, NULL, 1, 'COP', 'eg', 1, NULL, b'1', b'0', '2017-03-03 14:03:22', '2017-03-03 14:05:36', NULL),
	(89, 14, 22, 1, 1, 18, '2017-03-03', 1, NULL, NULL, 1, 'COP', 'eg', 1, NULL, b'0', b'1', '2017-03-03 14:20:59', '2017-03-10 09:31:25', '2017-03-10 09:31:25'),
	(90, 18, 23, 1, 1, 1, '2017-03-03', 1, NULL, NULL, 1, 'COP', 'in', 1, NULL, b'0', b'1', '2017-03-03 14:33:32', '2017-03-03 14:40:29', '2017-03-03 14:40:29'),
	(91, 16, 24, 1, 1, 9, '2017-03-03', 1, NULL, NULL, 2, 'COP', 'eg', 1, NULL, b'0', b'1', '2017-03-03 14:47:03', '2017-03-10 09:31:20', '2017-03-10 09:31:20'),
	(93, 20, 25, 1, 1, 23, '2017-03-03', 1, 'asas', NULL, 3, 'COP', 'in', 1, NULL, b'1', b'0', '2017-03-03 18:12:43', '2017-03-03 18:12:43', NULL),
	(94, 21, 26, 1, 1, 1, '2017-03-03', 1, NULL, NULL, 2, 'COP', 'in', 1, NULL, b'1', b'1', '2017-03-03 18:14:49', '2017-03-06 09:47:56', '2017-03-06 09:47:56'),
	(95, 17, 27, 1, 1, 9, '2017-03-03', 1, NULL, NULL, 2, 'COP', 'eg', 1, NULL, b'1', b'0', '2017-03-03 18:31:03', '2017-03-03 18:31:03', NULL),
	(104, 24, 28, 1, 1, 1, '2017-03-03', 1, 'asas', NULL, 2, 'COP', 'in', 1, NULL, b'1', b'1', '2017-03-03 19:56:58', '2017-03-06 09:47:52', '2017-03-06 09:47:52'),
	(108, 20, 29, 1, 1, NULL, '2017-03-10', 1, 'estas es mi transferencia', NULL, 3, 'COP', 'eg', 1, NULL, b'0', b'0', '2017-03-10 13:14:48', '2017-03-10 13:14:48', NULL),
	(109, 25, 30, 1, 1, NULL, '2017-03-10', 2, 'estas es mi transferencia', NULL, 3, 'COP', 'in', 1, NULL, b'0', b'0', '2017-03-10 13:14:48', '2017-03-10 13:14:48', NULL),
	(110, 21, 31, 1, 1, NULL, '2017-03-10', 1, 'trasnsferencia hacia banco 2', NULL, 3, 'COP', 'eg', 1, 110, b'0', b'0', '2017-03-10 13:24:53', '2017-03-10 13:24:53', NULL),
	(111, 26, 32, 1, 1, NULL, '2017-03-10', 2, 'trasnsferencia hacia banco 2', NULL, 3, 'COP', 'in', 1, 110, b'0', b'0', '2017-03-10 13:24:53', '2017-03-10 13:24:53', NULL),
	(114, 22, 33, 1, 1, NULL, '2017-03-10', 1, 'asas', NULL, 3, 'COP', 'eg', 1, 114, b'0', b'0', '2017-03-10 17:13:46', '2017-03-10 17:13:46', NULL),
	(115, 27, 34, 1, 1, NULL, '2017-03-10', 2, 'asas', NULL, 3, 'COP', 'in', 1, 114, b'0', b'0', '2017-03-10 17:13:46', '2017-03-10 17:13:46', NULL),
	(116, 23, 35, 1, 1, NULL, '2017-03-10', 2, NULL, NULL, 3, 'COP', 'eg', 1, 116, b'0', b'0', '2017-03-10 22:19:01', '2017-03-10 22:19:01', NULL),
	(117, 28, 36, 1, 1, NULL, '2017-03-10', 1, NULL, NULL, 3, 'COP', 'in', 1, 116, b'0', b'0', '2017-03-10 22:19:01', '2017-03-10 22:19:01', NULL),
	(118, 29, 37, 1, 1, 25, '2017-03-16', 1, NULL, NULL, 2, 'COP', 'in', 1, NULL, b'1', b'1', '2017-03-16 15:25:51', '2017-03-16 16:29:36', '2017-03-16 16:29:36'),
	(119, 30, 38, 1, 1, 25, '2017-03-16', 1, 'observaciones del pago', 'notas del recibo', 2, 'COP', 'in', 1, NULL, b'1', b'0', '2017-03-16 17:21:59', '2017-03-16 17:21:59', NULL),
	(120, 31, 39, 1, 1, 25, '2017-03-16', 1, 'pago 2', 'pago 2', 1, 'COP', 'in', 1, NULL, b'1', b'0', '2017-03-16 21:44:59', '2017-03-16 21:44:59', NULL);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;

-- Volcando estructura para tabla krece.payment_history
CREATE TABLE IF NOT EXISTS `payment_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `payment_id` bigint(20),
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_history: ~17 rows (aproximadamente)
DELETE FROM `payment_history`;
/*!40000 ALTER TABLE `payment_history` DISABLE KEYS */;
INSERT INTO `payment_history` (`id`, `account_id`, `payment_id`, `user_id`, `invoice_sale_order_id`, `bill_id`, `amount`, `created_at`, `updated_at`) VALUES
	(18, 1, 31, 1, 12, NULL, 2000, '2017-02-17 11:26:44', '2017-02-17 11:26:44'),
	(19, 1, 32, 1, 16, NULL, 10000, '2017-02-17 11:59:58', '2017-02-17 11:59:58'),
	(20, 1, 32, 1, 14, NULL, 1000, '2017-02-17 11:59:58', '2017-02-17 11:59:58'),
	(21, 1, 32, 1, 13, NULL, 5000, '2017-02-17 11:59:58', '2017-02-17 11:59:58'),
	(22, 1, 33, 1, 12, NULL, 20, '2017-02-17 13:49:13', '2017-02-17 13:49:13'),
	(23, 1, 34, 1, 12, NULL, 980, '2017-02-17 15:29:28', '2017-02-17 15:29:28'),
	(24, 1, 35, 1, 18, NULL, 5000, '2017-02-17 16:28:47', '2017-02-17 16:28:47'),
	(25, 1, 36, 1, 19, NULL, 4000, '2017-02-17 17:13:02', '2017-02-17 17:13:02'),
	(32, 1, 45, 1, NULL, 11, 1000, '2017-03-03 18:57:11', '2017-03-03 18:57:11'),
	(33, 1, 46, 1, NULL, 11, 1000, '2017-03-03 19:10:41', '2017-02-28 12:22:44'),
	(37, 1, 86, 1, NULL, 9, 200, '2017-03-03 14:03:22', '2017-03-03 14:03:22'),
	(39, 1, 93, 1, 25, NULL, 2000, '2017-03-03 18:12:43', '2017-03-03 18:12:43'),
	(40, 1, 94, 1, 23, NULL, 200, '2017-03-03 18:14:49', '2017-03-03 18:14:49'),
	(41, 1, 94, 1, 22, NULL, 500, '2017-03-03 18:14:49', '2017-03-03 18:14:49'),
	(42, 1, 94, 1, 21, NULL, 100, '2017-03-03 18:14:49', '2017-03-03 18:14:49'),
	(43, 1, 95, 1, NULL, 10, 5000, '2017-03-03 18:31:03', '2017-03-03 18:31:03'),
	(60, 1, 104, 1, 23, NULL, 4800, '2017-03-03 19:56:58', '2017-03-03 19:56:58'),
	(61, 1, 118, 1, 28, NULL, 6500, '2017-03-16 15:25:51', '2017-03-16 15:25:51'),
	(62, 1, 119, 1, 28, NULL, 2000, '2017-03-16 17:21:59', '2017-03-16 17:21:59'),
	(63, 1, 120, 1, 28, NULL, 3000, '2017-03-16 21:45:00', '2017-03-16 21:45:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.payment_terms: ~34 rows (aproximadamente)
DELETE FROM `payment_terms`;
/*!40000 ALTER TABLE `payment_terms` DISABLE KEYS */;
INSERT INTO `payment_terms` (`id`, `account_id`, `user_id`, `public_id`, `name`, `days`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'Vencimiento manual', 0, b'0', '2017-01-17 16:33:16', '2017-01-17 16:39:42', NULL),
	(2, 1, 1, 2, 'De Contado', 0, b'0', '2017-01-17 16:58:12', '2017-01-17 16:58:12', NULL),
	(3, 1, 1, 3, '8 días', 8, b'0', '2017-01-17 16:58:27', '2017-01-17 16:58:27', NULL),
	(4, 1, 1, 4, '15 días', 15, b'0', '2017-01-17 16:58:41', '2017-01-17 16:58:49', NULL),
	(5, 2, 2, 1, 'Vencimiento manual', 0, b'0', '2017-03-22 20:50:59', '2017-03-22 20:50:59', NULL),
	(6, 2, 2, 2, 'De contado', 0, b'0', '2017-03-22 20:50:59', '2017-03-22 20:50:59', NULL),
	(7, 2, 2, 3, '8 días', 8, b'0', '2017-03-22 20:50:59', '2017-03-22 20:50:59', NULL),
	(8, 2, 2, 4, '15 días', 15, b'0', '2017-03-22 20:50:59', '2017-03-22 20:50:59', NULL),
	(9, 2, 2, 5, '30 días', 30, b'0', '2017-03-22 20:50:59', '2017-03-22 20:50:59', NULL),
	(10, 2, 2, 6, '60 días', 60, b'0', '2017-03-22 20:50:59', '2017-03-22 20:50:59', NULL),
	(11, 6, 7, 1, 'Vencimiento manual', 0, b'0', '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(12, 6, 7, 2, 'De contado', 0, b'0', '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(13, 6, 7, 3, '8 días', 8, b'0', '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(14, 6, 7, 4, '15 días', 15, b'0', '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(15, 6, 7, 5, '30 días', 30, b'0', '2017-03-22 21:23:01', '2017-03-22 21:23:01', NULL),
	(16, 6, 7, 6, '60 días', 60, b'0', '2017-03-22 21:23:01', '2017-03-22 21:23:01', NULL),
	(17, 7, 8, 1, 'Vencimiento manual', 0, b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(18, 7, 8, 2, 'De contado', 0, b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(19, 7, 8, 3, '8 días', 8, b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(20, 7, 8, 4, '15 días', 15, b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(21, 7, 8, 5, '30 días', 30, b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(22, 7, 8, 6, '60 días', 60, b'0', '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(23, 9, 10, 1, 'Vencimiento manual', 0, b'0', NULL, '2017-03-22 22:01:25', NULL),
	(24, 9, 10, 2, 'De contado', 0, b'0', NULL, '2017-03-22 22:01:25', NULL),
	(25, 9, 10, 3, '8 días', 8, b'0', NULL, '2017-03-22 22:01:25', NULL),
	(26, 9, 10, 4, '15 días', 15, b'0', NULL, '2017-03-22 22:01:25', NULL),
	(27, 9, 10, 5, '30 días', 30, b'0', NULL, '2017-03-22 22:01:25', NULL),
	(28, 9, 10, 6, '60 días', 60, b'0', NULL, '2017-03-22 22:01:25', NULL),
	(29, 10, 11, 1, 'Vencimiento manual', 0, b'0', NULL, '2017-03-22 22:02:02', NULL),
	(30, 10, 11, 2, 'De contado', 0, b'0', NULL, '2017-03-22 22:02:02', NULL),
	(31, 10, 11, 3, '8 días', 8, b'0', NULL, '2017-03-22 22:02:02', NULL),
	(32, 10, 11, 4, '15 días', 15, b'0', NULL, '2017-03-22 22:02:02', NULL),
	(33, 10, 11, 5, '30 días', 30, b'0', NULL, '2017-03-22 22:02:02', NULL),
	(34, 10, 11, 6, '60 días', 60, b'0', NULL, '2017-03-22 22:02:02', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.product: ~5 rows (aproximadamente)
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `public_id`, `user_id`, `account_id`, `name`, `description`, `reference`, `sale_price`, `tax_id`, `list_price_id`, `category_id`, `inv_quantity_initial`, `inv_quantity_actual`, `inv_type_id`, `inv_unit_cost`, `inv_inStock`, `isDeleted`, `isActive`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(2, 1, 1, 1, 'producto 1', 'producto 1', 'ref', 2000, 5, NULL, 34, 50, NULL, 1, 1500, b'1', b'1', b'1', '2017-03-06 09:55:42', '2017-03-06 09:55:42', '2017-03-06 09:55:42'),
	(3, 2, 1, 1, 'producto 2', 'descripcion producto 2', 'ref2', 3000, 4, NULL, 30, 50, NULL, 2, 2500, b'0', b'1', b'1', '2017-03-06 09:55:46', '2017-03-06 09:55:46', '2017-03-06 09:55:46'),
	(4, 3, 1, 1, 'productoprueba', 'producto para pruebas', '1234', 5000, 3, NULL, 30, NULL, NULL, NULL, 0, b'0', b'1', b'1', '2017-03-06 09:56:02', '2017-03-06 09:56:02', '2017-03-06 09:56:02'),
	(5, 4, 1, 1, 'test', 'esta es una descripcion del producto pruena', NULL, 2000, 4, NULL, 30, 2, NULL, 1, 300, b'1', b'1', b'1', '2017-03-06 09:55:49', '2017-03-06 09:55:49', '2017-03-06 09:55:49'),
	(6, 5, 1, 1, 'producto-1-inv', NULL, NULL, 2000, 5, NULL, 34, 2, NULL, 1, 1500, b'1', b'0', b'1', '2017-03-06 09:57:58', '2017-03-06 09:57:58', NULL),
	(7, 6, 1, 1, 'producto-2-no-inv', NULL, NULL, 5000, 5, NULL, 34, NULL, NULL, NULL, 0, b'0', b'0', b'1', '2017-03-06 10:03:20', '2017-03-06 10:03:20', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Header of supplier invoices';

-- Volcando datos para la tabla krece.purchase_order: ~2 rows (aproximadamente)
DELETE FROM `purchase_order`;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
INSERT INTO `purchase_order` (`id`, `account_id`, `public_id`, `user_id`, `resolution_id`, `customer_id`, `date`, `due_date`, `currency_code`, `status_id`, `notes`, `observations`, `terms`, `exchange_rate`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 1, 6, '2017-02-23', '2017-03-25', 'COP', 1, 'esta es una nota de prueba', NULL, 'estos son terminos y condiciones de la orden', NULL, 125408, 12340.8, 21482.8, 134550, b'1', '2017-02-23 18:12:19', '2017-03-14 14:43:33', '2017-03-14 14:43:33'),
	(2, 1, 2, 1, 2, 24, '2017-03-14', '2017-04-13', 'COP', 1, 'notas orden de compra', 'observaciones orden de compra', 'terminos y condiciones de PO', NULL, 5000, 0, 380, 5380, b'0', '2017-03-14 15:02:08', '2017-03-14 15:02:08', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COMMENT='detail of the invoice generated';

-- Volcando datos para la tabla krece.purchase_order_detail: ~4 rows (aproximadamente)
DELETE FROM `purchase_order_detail`;
/*!40000 ALTER TABLE `purchase_order_detail` DISABLE KEYS */;
INSERT INTO `purchase_order_detail` (`id`, `purchase_order_id`, `user_id`, `unit_price`, `discount`, `tax_amount`, `tax_id`, `category_id`, `product_id`, `name`, `description`, `quantity`, `total`, `total_tax`, `created_at`, `updated_at`) VALUES
	(11, 1, 1, 2000, 0, 19, 3, 54, NULL, 'Alquiler de equipos y licencias', NULL, 1, 2000, 380, '2017-02-24 13:06:02', '2017-02-24 13:06:02'),
	(12, 1, 1, 123408, 10, 19, 4, 65, NULL, 'Egresos no operacionales', NULL, 1, 111067, 21102.8, '2017-02-24 13:06:02', '2017-02-24 13:06:02'),
	(13, 2, 1, 2000, 0, 19, 3, 54, NULL, 'Alquiler de equipos y licencias', NULL, 1, 2000, 380, '2017-03-14 15:02:08', '2017-03-14 15:02:08'),
	(14, 2, 1, 3000, 0, NULL, NULL, 55, NULL, 'Comisiones y honorarios', NULL, 1, 3000, 0, '2017-03-14 15:02:08', '2017-03-14 15:02:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision: ~4 rows (aproximadamente)
DELETE FROM `remision`;
/*!40000 ALTER TABLE `remision` DISABLE KEYS */;
INSERT INTO `remision` (`id`, `account_id`, `user_id`, `public_id`, `resolution_id`, `seller_id`, `list_price_id`, `customer_id`, `currency_code`, `document_type_id`, `status_id`, `date`, `due_date`, `sub_total`, `total_discounts`, `total_taxes`, `total`, `notes`, `observations`, `exchange_rate`, `isDeleted`, `created_at`, `deleted_at`, `updated_at`) VALUES
	(6, 1, 1, 1, 1, 4, 1, 4, 'COP', 1, 1, '2017-02-10', '2017-03-10', 10000, 0, 950, 10950, 'asas', NULL, NULL, b'1', '2017-02-10 16:28:02', '2017-03-06 09:48:28', '2017-03-06 09:48:28'),
	(7, 1, 1, 2, 2, NULL, 1, 4, 'COP', 1, 1, '2017-02-10', '2017-03-12', 55000, 0, 950, 55950, 'remision clonada', NULL, NULL, b'1', '2017-02-10 16:57:58', '2017-02-13 13:21:36', '2017-02-13 13:21:36'),
	(8, 1, 1, 3, 3, 4, 1, 18, 'COP', 2, 1, '2017-02-10', '2017-03-10', 10000, 0, 570, 10570, 'prueba remision 2', NULL, NULL, b'1', '2017-02-10 17:01:08', '2017-03-06 09:48:24', '2017-03-06 09:48:24'),
	(9, 1, 1, 4, 4, 4, 1, 25, 'COP', 1, 1, '2017-03-06', '2017-04-06', 7000, 0, 380, 7380, 'estas fueron las notas de la remision', 'esta es una remision', NULL, b'0', '2017-03-06 13:29:45', NULL, '2017-03-06 14:53:18');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.remision_detail: ~11 rows (aproximadamente)
DELETE FROM `remision_detail`;
/*!40000 ALTER TABLE `remision_detail` DISABLE KEYS */;
INSERT INTO `remision_detail` (`id`, `remision_id`, `user_id`, `product_id`, `reference`, `unit_price`, `discount`, `tax_id`, `tax_amount`, `name`, `description`, `quantity`, `total`, `total_tax`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(8, 6, 1, 4, NULL, 5000, 0, NULL, 19, NULL, 'producto para pruebas', 1, 5000, NULL, '2017-02-10 16:59:26', '2017-02-10 16:59:26', NULL),
	(9, 6, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 2000, NULL, '2017-02-10 16:59:26', '2017-02-10 16:59:26', NULL),
	(10, 6, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 3000, NULL, '2017-02-10 16:59:26', '2017-02-10 16:59:26', NULL),
	(11, 8, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 2000, NULL, '2017-02-10 17:01:08', '2017-02-10 17:01:08', NULL),
	(12, 8, 1, 3, NULL, 3000, 0, NULL, 19, NULL, 'descripcion producto 2', 1, 3000, NULL, '2017-02-10 17:01:08', '2017-02-10 17:01:08', NULL),
	(13, 8, 1, 4, NULL, 5000, 0, NULL, 0, NULL, 'producto para pruebas', 1, 5000, NULL, '2017-02-10 17:01:08', '2017-02-10 17:01:08', NULL),
	(14, 7, 1, 4, NULL, 5000, 0, NULL, 19, NULL, 'producto para pruebas', 1, 5000, NULL, '2017-02-13 13:01:15', '2017-02-13 13:01:15', NULL),
	(15, 7, 1, 2, NULL, 2000, 0, NULL, 0, NULL, 'producto 1', 1, 2000, NULL, '2017-02-13 13:01:15', '2017-02-13 13:01:15', NULL),
	(16, 7, 1, 3, NULL, 3000, 0, NULL, 0, NULL, 'descripcion producto 2', 1, 3000, NULL, '2017-02-13 13:01:15', '2017-02-13 13:01:15', NULL),
	(17, 7, 1, 5, NULL, 45000, 0, NULL, 0, NULL, NULL, 1, 45000, NULL, '2017-02-13 13:01:15', '2017-02-13 13:01:15', NULL),
	(28, 9, 1, 6, NULL, 2000, 0, 3, 19, NULL, NULL, 1, 2000, 380, '2017-03-06 14:29:26', '2017-03-06 14:29:26', NULL),
	(29, 9, 1, 7, NULL, 5000, 0, NULL, 0, NULL, NULL, 1, 5000, 0, '2017-03-06 14:29:26', '2017-03-06 14:29:26', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='contains resolution IDs for each sale order, according law policies (DIAN in colombia)';

-- Volcando datos para la tabla krece.resolution: ~9 rows (aproximadamente)
DELETE FROM `resolution`;
/*!40000 ALTER TABLE `resolution` DISABLE KEYS */;
INSERT INTO `resolution` (`id`, `account_id`, `public_id`, `user_id`, `initial_number`, `final_number`, `next_invoice_number`, `name`, `prefix`, `invoice_text`, `isDefault`, `isActive`, `isDeleted`, `auto_increment`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, '1', '', '20', 'Principal', NULL, 'resolucion', b'1', b'1', b'0', b'1', '2017-02-09 15:58:41', '2017-03-17 09:16:10', NULL),
	(2, 1, 2, 1, '1', '', '1', 'Nuevo', NULL, NULL, b'0', b'1', b'0', b'1', '2017-02-09 16:15:11', '2017-02-14 11:13:27', '2017-02-09 19:09:39'),
	(3, 1, 3, 1, '1', NULL, '2', 'tes', 'PR', NULL, b'0', b'1', b'1', b'1', '2017-02-09 18:15:58', '2017-02-14 14:19:34', '2017-02-14 14:19:34'),
	(4, 1, 4, 1, '1', NULL, '1', 'fer', NULL, NULL, b'0', b'0', b'0', b'1', '2017-02-09 19:38:49', '2017-02-14 10:47:25', NULL),
	(5, 1, 5, 1, NULL, NULL, NULL, 'sin numeración', NULL, 'Resolución de facturación No 12345678', b'0', b'1', b'0', b'0', '2017-02-10 09:17:13', '2017-02-14 14:22:03', NULL),
	(6, 2, 1, 2, '1', NULL, '1', 'Principal', NULL, NULL, b'1', b'1', b'0', b'1', '2017-03-22 19:25:40', '2017-03-22 19:25:40', NULL),
	(7, 6, 1, 7, '1', NULL, '1', 'Principal', NULL, NULL, b'1', b'1', b'0', b'1', '2017-03-22 21:22:59', '2017-03-22 21:22:59', NULL),
	(8, 7, 1, 8, '1', NULL, '1', 'Principal', NULL, NULL, b'1', b'1', b'0', b'1', '2017-03-22 21:34:50', '2017-03-22 21:34:50', NULL),
	(9, 9, 1, 10, '1', NULL, '1', 'Principal', NULL, NULL, b'1', b'1', b'0', b'1', '2017-03-22 22:01:24', '2017-03-22 22:01:24', NULL),
	(10, 10, 1, 11, '1', NULL, '1', 'Principal', NULL, NULL, b'1', b'1', b'0', b'1', '2017-03-22 22:02:02', '2017-03-22 22:02:02', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla krece.resolution_numbers: ~48 rows (aproximadamente)
DELETE FROM `resolution_numbers`;
/*!40000 ALTER TABLE `resolution_numbers` DISABLE KEYS */;
INSERT INTO `resolution_numbers` (`id`, `account_id`, `key`, `prefix`, `number`, `text`, `created_at`, `updated_at`) VALUES
	(8, 1, 'estimate', NULL, 39, 'Siguiente número de cotizaciones', '2017-02-09 12:55:05', '2017-03-08 17:14:19'),
	(9, 1, 'purchase_order', NULL, 3, 'Siguiente número de órdenes de compra', '2017-02-09 12:55:53', '2017-03-14 15:02:08'),
	(10, 1, 'credit_note', NULL, 4, 'Siguiente número de nota credito', '2017-02-09 12:56:46', '2017-03-13 13:58:26'),
	(11, 1, 'remision', NULL, 5, 'Siguiente número de remisiones', '2017-02-09 12:57:47', '2017-03-06 13:29:45'),
	(12, 1, 'in-come', NULL, 32, 'Siguiente número de recibo de caja', '2017-02-16 12:37:49', '2017-03-16 21:45:00'),
	(13, 1, 'debit_note', NULL, 5, 'Siguiente número de nota debito', '2017-02-24 14:07:27', '2017-03-14 15:31:59'),
	(14, 1, 'bill', NULL, 6, 'Siguiente número de factura de proveedores', '2017-02-24 16:13:59', '2017-03-14 14:40:18'),
	(15, 1, 'out-come', NULL, 24, 'Siguiente número de comprobante de pago', '2017-02-28 10:09:04', '2017-03-10 22:19:01'),
	(16, 2, 'estimate', NULL, 1, 'Siguiente número de cotizaciones', '2017-03-22 19:27:02', '2017-03-22 19:27:02'),
	(17, 2, 'purchase_order', NULL, 1, 'Siguiente número de órdenes de compra', '2017-03-22 19:27:03', '2017-03-22 19:27:03'),
	(18, 2, 'credit_note', NULL, 1, 'Siguiente número de nota credito', '2017-03-22 19:27:03', '2017-03-22 19:27:03'),
	(19, 2, 'remision', NULL, 1, 'Siguiente número de remisiones', '2017-03-22 19:27:03', '2017-03-22 19:27:03'),
	(20, 2, 'in-come', NULL, 1, 'Siguiente número de recibo de caja', '2017-03-22 19:27:03', '2017-03-22 19:27:03'),
	(21, 2, 'debit_note', NULL, 1, 'Siguiente número de nota debito', '2017-03-22 19:27:03', '2017-03-22 19:27:03'),
	(22, 2, 'bill', NULL, 1, 'Siguiente número de factura de proveedores', '2017-03-22 19:27:03', '2017-03-22 19:27:03'),
	(23, 2, 'out-come', NULL, 1, 'Siguiente número de comprobante de pago', '2017-03-22 19:27:03', '2017-03-22 19:27:03'),
	(24, 6, 'estimate', NULL, 1, 'Siguiente número de cotizaciones', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(25, 6, 'purchase_order', NULL, 1, 'Siguiente número de órdenes de compra', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(26, 6, 'credit_note', NULL, 1, 'Siguiente número de nota credito', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(27, 6, 'remision', NULL, 1, 'Siguiente número de remisiones', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(28, 6, 'in-come', NULL, 1, 'Siguiente número de recibo de caja', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(29, 6, 'debit_note', NULL, 1, 'Siguiente número de nota debito', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(30, 6, 'bill', NULL, 1, 'Siguiente número de factura de proveedores', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(31, 6, 'out-come', NULL, 1, 'Siguiente número de comprobante de pago', '2017-03-22 21:23:00', '2017-03-22 21:23:00'),
	(32, 7, 'estimate', NULL, 1, 'Siguiente número de cotizaciones', '2017-03-22 21:34:50', '2017-03-22 21:34:50'),
	(33, 7, 'purchase_order', NULL, 1, 'Siguiente número de órdenes de compra', '2017-03-22 21:34:50', '2017-03-22 21:34:50'),
	(34, 7, 'credit_note', NULL, 1, 'Siguiente número de nota credito', '2017-03-22 21:34:50', '2017-03-22 21:34:50'),
	(35, 7, 'remision', NULL, 1, 'Siguiente número de remisiones', '2017-03-22 21:34:50', '2017-03-22 21:34:50'),
	(36, 7, 'in-come', NULL, 1, 'Siguiente número de recibo de caja', '2017-03-22 21:34:50', '2017-03-22 21:34:50'),
	(37, 7, 'debit_note', NULL, 1, 'Siguiente número de nota debito', '2017-03-22 21:34:50', '2017-03-22 21:34:50'),
	(38, 7, 'bill', NULL, 1, 'Siguiente número de factura de proveedores', '2017-03-22 21:34:51', '2017-03-22 21:34:51'),
	(39, 7, 'out-come', NULL, 1, 'Siguiente número de comprobante de pago', '2017-03-22 21:34:51', '2017-03-22 21:34:51'),
	(40, 9, 'estimate', NULL, 1, 'Siguiente número de cotizaciones', NULL, NULL),
	(41, 9, 'purchase_order', NULL, 1, 'Siguiente número de órdenes de compra', NULL, NULL),
	(42, 9, 'credit_note', NULL, 1, 'Siguiente número de nota credito', NULL, NULL),
	(43, 9, 'remision', NULL, 1, 'Siguiente número de remisiones', NULL, NULL),
	(44, 9, 'in-come', NULL, 1, 'Siguiente número de recibo de caja', NULL, NULL),
	(45, 9, 'debit_note', NULL, 1, 'Siguiente número de nota debito', NULL, NULL),
	(46, 9, 'bill', NULL, 1, 'Siguiente número de factura de proveedores', NULL, NULL),
	(47, 9, 'out-come', NULL, 1, 'Siguiente número de comprobante de pago', NULL, NULL),
	(48, 10, 'estimate', NULL, 1, 'Siguiente número de cotizaciones', NULL, NULL),
	(49, 10, 'purchase_order', NULL, 1, 'Siguiente número de órdenes de compra', NULL, NULL),
	(50, 10, 'credit_note', NULL, 1, 'Siguiente número de nota credito', NULL, NULL),
	(51, 10, 'remision', NULL, 1, 'Siguiente número de remisiones', NULL, NULL),
	(52, 10, 'in-come', NULL, 1, 'Siguiente número de recibo de caja', NULL, NULL),
	(53, 10, 'debit_note', NULL, 1, 'Siguiente número de nota debito', NULL, NULL),
	(54, 10, 'bill', NULL, 1, 'Siguiente número de factura de proveedores', NULL, NULL),
	(55, 10, 'out-come', NULL, 1, 'Siguiente número de comprobante de pago', NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.retention: ~68 rows (aproximadamente)
DELETE FROM `retention`;
/*!40000 ALTER TABLE `retention` DISABLE KEYS */;
INSERT INTO `retention` (`id`, `account_id`, `public_id`, `user_id`, `name`, `value`, `description`, `isDeleted`, `type_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, NULL, 1, 'Retencion', 3.5, 'prueba', b'1', 2, '2017-01-17 14:34:56', '2017-01-17 14:37:14', '2017-01-17 14:37:14'),
	(2, 1, NULL, 1, 'Compras', 2.5, 'Retención aplicada a compras declarantes', b'0', 2, '2017-01-17 14:39:16', '2017-01-17 14:41:13', NULL),
	(3, 1, NULL, 1, 'Arrendamiento de bienes raices', 3.5, 'Retención aplicada a arrendamiento de bienes raices', b'0', 2, '2017-01-17 14:40:07', '2017-01-17 14:40:07', NULL),
	(4, 2, 1, 2, 'Arrendamiento de bienes inmuebles', 4, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(5, 2, 2, 2, 'Arrendamiento de bienes raices', 3.5, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(6, 2, 3, 2, 'Compras declarantes', 2.5, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(7, 2, 4, 2, 'Compras no declarantes', 3.5, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(8, 2, 5, 2, 'Honorarios y comisiones (naturales)', 10, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(9, 2, 6, 2, 'Honoraios y comisiones (jurídicas)', 11, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(10, 2, 7, 2, 'Servicios de aseo y vigilancia', 2, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(11, 2, 8, 2, 'Servicios de hoteles y restaurantes', 3.5, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(12, 2, 9, 2, 'Servicios generales (declarantes)', 4, NULL, b'0', 2, '2017-03-22 20:50:23', '2017-03-22 20:50:23', NULL),
	(13, 2, 10, 2, 'Servicios generales (no declarantes)', 6, NULL, b'0', 2, '2017-03-22 20:50:24', '2017-03-22 20:50:24', NULL),
	(14, 2, 11, 2, 'ReteIca', 0, NULL, b'0', 3, '2017-03-22 20:50:24', '2017-03-22 20:50:24', NULL),
	(15, 2, 12, 2, 'ReteIva', 15, NULL, b'0', 1, '2017-03-22 20:50:24', '2017-03-22 20:50:24', NULL),
	(16, 2, 13, 2, 'Transporte de carga', 15, NULL, b'0', 2, '2017-03-22 20:50:24', '2017-03-22 20:50:24', NULL),
	(17, 6, 1, 7, 'Arrendamiento de bienes inmuebles', 4, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(18, 6, 2, 7, 'Arrendamiento de bienes raices', 3.5, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(19, 6, 3, 7, 'Compras declarantes', 2.5, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(20, 6, 4, 7, 'Compras no declarantes', 3.5, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(21, 6, 5, 7, 'Honorarios y comisiones (naturales)', 10, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(22, 6, 6, 7, 'Honoraios y comisiones (jurídicas)', 11, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(23, 6, 7, 7, 'Servicios de aseo y vigilancia', 2, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(24, 6, 8, 7, 'Servicios de hoteles y restaurantes', 3.5, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(25, 6, 9, 7, 'Servicios generales (declarantes)', 4, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(26, 6, 10, 7, 'Servicios generales (no declarantes)', 6, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(27, 6, 11, 7, 'ReteIca', 0, NULL, b'0', 3, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(28, 6, 12, 7, 'ReteIva', 15, NULL, b'0', 1, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(29, 6, 13, 7, 'Transporte de carga', 15, NULL, b'0', 2, '2017-03-22 21:23:00', '2017-03-22 21:23:00', NULL),
	(30, 7, 1, 8, 'Arrendamiento de bienes inmuebles', 4, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(31, 7, 2, 8, 'Arrendamiento de bienes raices', 3.5, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(32, 7, 3, 8, 'Compras declarantes', 2.5, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(33, 7, 4, 8, 'Compras no declarantes', 3.5, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(34, 7, 5, 8, 'Honorarios y comisiones (naturales)', 10, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(35, 7, 6, 8, 'Honoraios y comisiones (jurídicas)', 11, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(36, 7, 7, 8, 'Servicios de aseo y vigilancia', 2, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(37, 7, 8, 8, 'Servicios de hoteles y restaurantes', 3.5, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(38, 7, 9, 8, 'Servicios generales (declarantes)', 4, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(39, 7, 10, 8, 'Servicios generales (no declarantes)', 6, NULL, b'0', 2, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(40, 7, 11, 8, 'ReteIca', 0, NULL, b'0', 3, '2017-03-22 21:34:51', '2017-03-22 21:34:51', NULL),
	(41, 7, 12, 8, 'ReteIva', 15, NULL, b'0', 1, '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(42, 7, 13, 8, 'Transporte de carga', 15, NULL, b'0', 2, '2017-03-22 21:34:52', '2017-03-22 21:34:52', NULL),
	(43, 9, 1, 10, 'Arrendamiento de bienes inmuebles', 4, '', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(44, 9, 2, 10, 'Arrendamiento de bienes raices', 3.5, 'Retencion aplicada a pagos de arrendamiento de bienes raices', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(45, 9, 3, 10, 'Compras declarantes', 2.5, 'Retencion aplicada a compras declarantes', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(46, 9, 4, 10, 'Compras no declarantes', 3.5, 'Retencion aplicada a compras no declarantes', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(47, 9, 5, 10, 'Honorarios y comisiones (naturales)', 10, 'Retencion aplicada a personas naturales', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(48, 9, 6, 10, 'Honoraios y comisiones (jurídicas)', 11, 'Retencion aplicada a personas juridicas', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(49, 9, 7, 10, 'Servicios de aseo y vigilancia', 2, 'Retencion aplicada a pagos de servicios en aseo y/o vigilancia', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(50, 9, 8, 10, 'Servicios de hoteles y restaurantes', 3.5, 'Retencion aplicada por servicios de hoteles, restaurantes y hospedaje a declarantes y no declarantes', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(51, 9, 9, 10, 'Servicios generales (declarantes)', 4, 'Retencion aplicada a pagos de personas declarantes', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(52, 9, 10, 10, 'Servicios generales (no declarantes)', 6, 'Retencion aplicada a pagos de personas no declarantes', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(53, 9, 11, 10, 'ReteIca', 0, 'Retencion de industria y comercio', b'0', 3, NULL, '2017-03-22 22:01:25', NULL),
	(54, 9, 12, 10, 'ReteIva', 15, 'Retencion sobre el total del IVA asociado a una factura', b'0', 1, NULL, '2017-03-22 22:01:25', NULL),
	(55, 9, 13, 10, 'Transporte de carga', 15, '', b'0', 2, NULL, '2017-03-22 22:01:25', NULL),
	(56, 10, 1, 11, 'Arrendamiento de bienes inmuebles', 4, '', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(57, 10, 2, 11, 'Arrendamiento de bienes raices', 3.5, 'Retencion aplicada a pagos de arrendamiento de bienes raices', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(58, 10, 3, 11, 'Compras declarantes', 2.5, 'Retencion aplicada a compras declarantes', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(59, 10, 4, 11, 'Compras no declarantes', 3.5, 'Retencion aplicada a compras no declarantes', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(60, 10, 5, 11, 'Honorarios y comisiones (naturales)', 10, 'Retencion aplicada a personas naturales', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(61, 10, 6, 11, 'Honoraios y comisiones (jurídicas)', 11, 'Retencion aplicada a personas juridicas', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(62, 10, 7, 11, 'Servicios de aseo y vigilancia', 2, 'Retencion aplicada a pagos de servicios en aseo y/o vigilancia', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(63, 10, 8, 11, 'Servicios de hoteles y restaurantes', 3.5, 'Retencion aplicada por servicios de hoteles, restaurantes y hospedaje a declarantes y no declarantes', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(64, 10, 9, 11, 'Servicios generales (declarantes)', 4, 'Retencion aplicada a pagos de personas declarantes', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(65, 10, 10, 11, 'Servicios generales (no declarantes)', 6, 'Retencion aplicada a pagos de personas no declarantes', b'0', 2, NULL, '2017-03-22 22:02:02', NULL),
	(66, 10, 11, 11, 'ReteIca', 0, 'Retencion de industria y comercio', b'0', 3, NULL, '2017-03-22 22:02:02', NULL),
	(67, 10, 12, 11, 'ReteIva', 15, 'Retencion sobre el total del IVA asociado a una factura', b'0', 1, NULL, '2017-03-22 22:02:02', NULL),
	(68, 10, 13, 11, 'Transporte de carga', 15, '', b'0', 2, NULL, '2017-03-22 22:02:02', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='contains the taxes list that each user defines';

-- Volcando datos para la tabla krece.tax: ~18 rows (aproximadamente)
DELETE FROM `tax`;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
INSERT INTO `tax` (`id`, `account_id`, `public_id`, `user_id`, `name`, `amount`, `description`, `type_id`, `isEditable`, `isDeleted`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 1, 1, 'IVA', 19, 'Nuevo IVA', 1, b'1', b'1', '2017-01-16 09:26:09', '2017-01-19 15:45:00', '2017-01-19 15:45:00'),
	(2, 1, 2, 1, 'te', 20, 'test', 1, b'1', b'1', '2017-01-16 16:27:32', '2017-01-17 12:44:16', '2017-01-17 12:44:16'),
	(3, 1, 3, 1, 'IVA', 19, 'test', 1, b'1', b'0', '2017-01-16 16:31:26', '2017-01-17 12:45:51', '2017-01-17 10:36:27'),
	(4, 1, 4, 1, 'ICO', 15, 'test', 2, b'1', b'0', '2017-01-16 16:32:31', '2017-03-06 14:06:48', '2017-01-17 12:37:34'),
	(5, 1, 5, 1, 'Ninguno', 0, 'prueba', 1, b'1', b'0', '2017-01-16 16:34:48', '2017-01-17 12:46:17', NULL),
	(6, 1, 6, 1, 'IVA2', 18, 'prueba', 1, b'1', b'1', '2017-01-17 10:44:59', '2017-03-06 14:07:50', '2017-01-17 12:44:08'),
	(7, 1, 7, 1, 'IVA3', 17, 'prueba', 1, b'1', b'1', '2017-01-17 10:45:53', '2017-03-06 14:07:51', '2017-01-17 12:44:02'),
	(8, 2, 1, 2, 'IVA', 19, NULL, 1, b'1', b'0', '2017-03-22 19:10:18', '2017-03-22 19:10:18', NULL),
	(9, 2, 2, 2, 'ICO', 19, NULL, 2, b'1', b'0', '2017-03-22 19:10:18', '2017-03-22 19:10:18', NULL),
	(10, 6, 1, 7, 'IVA', 19, NULL, 1, b'1', b'0', '2017-03-22 21:22:59', '2017-03-22 21:22:59', NULL),
	(11, 6, 2, 7, 'ICO', 19, NULL, 2, b'1', b'0', '2017-03-22 21:22:59', '2017-03-22 21:22:59', NULL),
	(12, 6, 3, 7, 'Ninguno', 0, NULL, 3, b'1', b'0', '2017-03-22 21:22:59', '2017-03-22 21:22:59', NULL),
	(13, 7, 1, 8, 'IVA', 19, NULL, 1, b'1', b'0', '2017-03-22 21:34:50', '2017-03-22 21:34:50', NULL),
	(14, 7, 2, 8, 'ICO', 19, NULL, 2, b'1', b'0', '2017-03-22 21:34:50', '2017-03-22 21:34:50', NULL),
	(15, 7, 3, 8, 'Ninguno', 0, NULL, 3, b'1', b'0', '2017-03-22 21:34:50', '2017-03-22 21:34:50', NULL),
	(19, 9, 1, 10, 'IVA', 19, 'IVA', 1, b'1', b'0', NULL, '2017-03-22 22:01:24', NULL),
	(20, 9, 2, 10, 'ICO', 19, 'ICO', 2, b'1', b'0', NULL, '2017-03-22 22:01:24', NULL),
	(21, 9, 3, 10, 'Ninguno', 0, 'Ninguno', 3, b'1', b'0', NULL, '2017-03-22 22:01:24', NULL),
	(22, 10, 1, 11, 'IVA', 19, 'IVA', 1, b'1', b'0', NULL, '2017-03-22 22:02:02', NULL),
	(23, 10, 2, 11, 'ICO', 19, 'ICO', 2, b'1', b'0', NULL, '2017-03-22 22:02:02', NULL),
	(24, 10, 3, 11, 'Ninguno', 0, 'Ninguno', 3, b'1', b'0', NULL, '2017-03-22 22:02:02', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla krece.user: ~7 rows (aproximadamente)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `account_id`, `role_id`, `name`, `last_name`, `email`, `password`, `remember_token`, `transaction_token`, `phone`, `status_id`, `created_at`, `deleted_at`, `updated_at`, `last_login`, `modified_by`, `created_by`, `public_id`, `oauth_user_id`, `oauth_provider_id`, `is_admin`) VALUES
	(1, 1, 1, 'Fernando', 'Ardila Rodriguez', 'fernando2684@gmail.com', '$2y$10$kyQ2lV6uMJq9oMJmiFigneGX1cQ4baV3hMIMVrXATDDlAeMtPT5lG', 'qhi8JnaoWlnT9LOvVELM7OXeL7AtGFaZPHJcu2gzkM6E6vpbb6U65vPaJiHY', NULL, NULL, 1, '2016-12-07 16:17:25', NULL, '2017-03-23 06:16:46', '2017-03-23 06:16:46', NULL, NULL, 1, NULL, NULL, b'1'),
	(2, 2, 1, 'Fernando 2', 'Ardila', 'fernando26842@gmail.com', '$2y$10$a55MnRDXKsxTU5UmNWKh/ua7FY1kSsvAI.PaZNXcWC3Axulhr.aD2', 'RapxDZXohJ2FKbHop2lxhmC7hdNR2ybLrEmwi1TVrXPuMWOVLzQbbm8Pu66X', NULL, NULL, 1, '2016-12-07 17:19:15', NULL, '2017-01-24 16:45:47', NULL, NULL, NULL, 1, NULL, NULL, b'1'),
	(7, 6, 1, 'seguros delima', NULL, 'fernando26841234@gmail.com', '$2y$10$3foquoWNxCscHa6dczAm..bOa7bFvrJyPauh/mlRLoHBGI.DowUMW', 'CBtHeMZJ92mAcm671fakwj7Bgk53oBYXHqQBJm2FH1bR2X7mwtxGDNLRNgli', NULL, NULL, 1, '2017-03-22 21:22:54', NULL, '2017-03-22 21:22:54', NULL, NULL, NULL, NULL, NULL, NULL, b'1'),
	(8, 7, 1, 'negocio eliminar', NULL, 'example@text.com', '$2y$10$epKY35yKPtDPItAggj2v4ercp1Kitmkyp6QT3BfmB4A/UpfhEasuC', '9E3iqt4cH1RyTsrYEjkBOijhiWoO5DL1kZhWpNbw3pBh2Ckc5HTRLAj0NyXN', NULL, NULL, 1, '2017-03-22 21:34:50', NULL, '2017-03-22 21:34:50', NULL, NULL, NULL, NULL, NULL, NULL, b'1'),
	(9, 8, 1, 'mi negocio sr', NULL, 'test@test.com', '$2y$10$MAKReS4NaxfZRFe9tOwtUOy70E7BNNYnojdl3BG0bWt1pqI3ZPGL6', NULL, NULL, NULL, 1, '2017-03-22 21:55:18', NULL, '2017-03-22 21:55:18', NULL, NULL, NULL, NULL, NULL, NULL, b'1'),
	(10, 9, 1, 'mi negocio sr', NULL, 'test2@test.com', '$2y$10$JBTrbEvw2ES.lk/AXhFvrObqs5eRVGFiuLSt2LGKtCdg6.54cmxWC', 'XNDROdyvCEvJlnUQyajsHnh2m6HNExeUZVstyih2WmhJrAO8hIjV7tLSo3fF', NULL, NULL, 1, '2017-03-22 22:01:19', NULL, '2017-03-22 22:01:19', NULL, NULL, NULL, NULL, NULL, NULL, b'1'),
	(11, 10, 1, 'asjasgh', NULL, 'test3@gmail.com', '$2y$10$uIzqGLgr4Gpze90uCztf6.9fyuYeM2mwYORjN5qkWj3shdZIWctKK', NULL, NULL, NULL, 1, '2017-03-22 22:02:02', NULL, '2017-03-22 22:02:02', NULL, NULL, NULL, NULL, NULL, NULL, b'1');
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
