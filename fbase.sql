-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 31-Out-2021 às 11:22
-- Versão do servidor: 10.4.18-MariaDB
-- versão do PHP: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `es_extended`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('caution', 'Caution', 0),
('property_black_money', 'Argent Sale Propriété', 0),
('society_ambulance', 'Ambulance', 1),
('society_ammu', 'Ammu-Nation', 1),
('society_bahamas', 'Bahamas', 1),
('society_bahamas_black', 'Bahamas black', 1),
('society_ballas', 'ballas', 1),
('society_ballas_black', 'ballas black', 1),
('society_blanchisseur', 'blanchisseur', 1),
('society_blanchisseur_black', 'blanchisseur black', 1),
('society_boulangerie', 'boulangerie', 1),
('society_brasserie', 'brasserie', 1),
('society_cardealer', 'Concessionnaire', 1),
('society_cartel', 'Cartel', 1),
('society_cartel_black', 'cartel black', 1),
('society_crips', 'crips', 1),
('society_crips_black', 'crips black', 1),
('society_driving', 'Auto-école', 1),
('society_famillies', 'famillies', 1),
('society_famillies_black', 'famillies black', 1),
('society_ferrailleur', 'Ferrailleur', 1),
('society_fire', 'Sapeur-Pompier', 1),
('society_fourriere', 'Fourrière', 1),
('society_mafia', 'Mafia', 1),
('society_mafia_black', 'mafia black', 1),
('society_marabunta', 'marabunta', 1),
('society_marabunta_black', 'marabunta black', 1),
('society_mcdonalds', 'McDonalds', 1),
('society_mechanic', 'Benny\'s', 1),
('society_motodealer', 'Concessionnaire Moto', 1),
('society_police', 'Police', 1),
('society_realestateagent', 'Agent immobilier', 1),
('society_split', 'Slipt Sides', 1),
('society_split_black', 'Slipt Sides black', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_tequila', 'Tequila', 1),
('society_tequila_black', 'Tequila black', 1),
('society_unicorn', 'Vanilla Unicorn', 1),
('society_unicorn_black', 'Vanilla Unicorn black', 1),
('society_vagos', 'vagos', 1),
('society_vagos_black', 'vagos black', 1),
('society_vigneron', 'vigneron', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(2, 'society_ambulance', 0, NULL),
(3, 'society_ammu', 0, NULL),
(4, 'society_bahamas', 0, NULL),
(5, 'society_bahamas_black', 0, NULL),
(6, 'society_ballas', 0, NULL),
(7, 'society_ballas_black', 0, NULL),
(8, 'society_blanchisseur', 0, NULL),
(9, 'society_blanchisseur_black', 0, NULL),
(10, 'society_brasserie', 0, NULL),
(11, 'society_cardealer', 0, NULL),
(12, 'society_crips', 0, NULL),
(13, 'society_crips_black', 0, NULL),
(14, 'society_driving', 0, NULL),
(15, 'society_famillies', 0, NULL),
(16, 'society_famillies_black', 0, NULL),
(17, 'society_fire', 0, NULL),
(18, 'society_marabunta', 0, NULL),
(19, 'society_marabunta_black', 0, NULL),
(20, 'society_mcdonalds', 0, NULL),
(21, 'society_mechanic', 0, NULL),
(22, 'society_motodealer', 0, NULL),
(23, 'society_police', 0, NULL),
(24, 'society_tabac', 0, NULL),
(25, 'society_taxi', 0, NULL),
(26, 'society_tequila', 0, NULL),
(27, 'society_tequila_black', 0, NULL),
(28, 'society_unicorn', 0, NULL),
(29, 'society_unicorn_black', 0, NULL),
(30, 'society_vagos', 0, NULL),
(31, 'society_vagos_black', 0, NULL),
(32, 'society_vigneron', 0, NULL),
(33, 'society_barber', 0, NULL),
(34, 'society_fourriere', 0, NULL),
(35, 'society_ferrailleur', 0, NULL),
(38, 'society_realestateagent', 0, NULL),
(41, 'caution', 0, NULL),
(42, 'property_black_money', 0, NULL),
(43, 'society_cartel', 0, NULL),
(44, 'society_mafia', 0, NULL),
(53, 'society_cartel_black', 0, NULL),
(54, 'society_mafia_black', 0, NULL),
(57, 'society_boulangerie', 0, NULL),
(62, 'society_split', 0, NULL),
(63, 'society_split_black', 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('property', 'Propriété', 0),
('society_ambulance', 'Ambulance', 1),
('society_ammu', 'Ammu-Nation', 1),
('society_bahamas', 'Bahamas', 1),
('society_ballas', 'ballas', 1),
('society_blanchisseur', 'blanchisseur', 1),
('society_boulangerie', 'boulangerie', 1),
('society_brasserie', 'brasserie', 1),
('society_cardealer', 'Concessionnaire', 1),
('society_cartel', 'Cartel', 1),
('society_crips', 'crips', 1),
('society_driving', 'Auto-école', 1),
('society_famillies', 'famillies', 1),
('society_ferrailleur', 'Ferrailleur', 1),
('society_fire', 'Sapeur-Pompier', 1),
('society_fourriere', 'Fourrière', 1),
('society_mafia', 'Mafia', 1),
('society_marabunta', 'marabunta', 1),
('society_mcdonalds', 'McDonalds', 1),
('society_mechanic', 'Benny\'s', 1),
('society_motodealer', 'Concessionnaire Moto', 1),
('society_police', 'Police', 1),
('society_split', 'Slipt Sides', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_tequila', 'Tequila', 1),
('society_unicorn', 'Vanilla Unicorn', 1),
('society_vagos', 'vagos', 1),
('society_vigneron', 'vigneron', 1),
('society_vigneron_fridge', 'vigneron (frigo)', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `banlist`
--

CREATE TABLE IF NOT EXISTS banlist (
  license varchar(50) COLLATE utf8mb4_bin PRIMARY KEY,
  identifier varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  targetplayername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  sourceplayername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  reason varchar(255) NOT NULL,
  timeat varchar(50) NOT NULL,
  expiration varchar(50) NOT NULL,
  permanent int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `banlisthistory`
--

CREATE TABLE IF NOT EXISTS banlisthistory (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  license varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  identifier varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  targetplayername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  sourceplayername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  reason varchar(255) NOT NULL,
  timeat int(11) NOT NULL,
  added varchar(40) NOT NULL,
  expiration int(11) NOT NULL,
  permanent int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `baninfo`
--

CREATE TABLE IF NOT EXISTS baninfo (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  license varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  identifier varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  liveid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  xblid varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  discord varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  playerip varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  playername varchar(32) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('property', 'Propriété', 0),
('society_ambulance', 'Ambulance', 1),
('society_ammu', 'Ammu-Nation', 1),
('society_bahamas', 'Bahamas', 1),
('society_ballas', 'ballas', 1),
('society_blanchisseur', 'blanchisseur', 1),
('society_boulangerie', 'boulangerie', 1),
('society_brasserie', 'brasserie', 1),
('society_cartel', 'Cartel', 1),
('society_crips', 'crips', 1),
('society_famillies', 'famillies', 1),
('society_ferrailleur', 'Ferrailleur', 1),
('society_fire', 'Sapeur-Pompier', 1),
('society_fourriere', 'Fourrière', 1),
('society_mafia', 'Mafia', 1),
('society_marabunta', 'marabunta', 1),
('society_mcdonalds', 'McDonalds', 1),
('society_mechanic', 'Benny\'s', 1),
('society_police', 'Police', 1),
('society_split', 'Slipt Sides', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_tequila', 'Tequila', 1),
('society_unicorn', 'Vanilla Unicorn', 1),
('society_vagos', 'vagos', 1),
('society_vigneron', 'vigneron', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(2, 'society_ambulance', NULL, '{}'),
(3, 'society_ammu', NULL, '{}'),
(4, 'society_bahamas', NULL, '{}'),
(5, 'society_ballas', NULL, '{}'),
(6, 'society_blanchisseur', NULL, '{}'),
(7, 'society_brasserie', NULL, '{}'),
(8, 'society_crips', NULL, '{}'),
(9, 'society_famillies', NULL, '{}'),
(10, 'society_fire', NULL, '{}'),
(11, 'society_marabunta', NULL, '{}'),
(12, 'society_mcdonalds', NULL, '{}'),
(13, 'society_mechanic', NULL, '{}'),
(14, 'society_police', NULL, '{}'),
(15, 'society_tabac', NULL, '{}'),
(16, 'society_taxi', NULL, '{}'),
(17, 'society_tequila', NULL, '{}'),
(18, 'society_unicorn', NULL, '{}'),
(19, 'society_vagos', NULL, '{}'),
(20, 'society_vigneron', NULL, '{}'),
(22, 'society_fourriere', NULL, '{}'),
(23, 'society_ferrailleur', NULL, '{}'),
(26, 'property', NULL, '{}'),
(27, 'society_cartel', NULL, '{}'),
(28, 'society_mafia', NULL, '{}'),
(33, 'society_boulangerie', NULL, '{}'),
(34, 'society_split', NULL, '{}');

-- --------------------------------------------------------

--
-- Estrutura da tabela `fourriere_report`
--

CREATE TABLE `fourriere_report` (
  `id` int(11) NOT NULL,
  `motif` varchar(255) NOT NULL,
  `agent` varchar(255) DEFAULT NULL,
  `numeroreport` varchar(255) DEFAULT NULL,
  `plaque` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `vehicle` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `items`
--

CREATE TABLE `items` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('advancedrifle', 'CTAR-21', -1, 0, 1),
('alive_chicken', 'Poulet vivant', 1, 0, 1),
('appistol', 'Colt SCAMP', -1, 0, 1),
('assaultrifle', 'AK 47', -1, 0, 1),
('assaultrifle_mk2', 'assaultrifle_mk2', -1, 0, 1),
('assaultshotgun', 'UTAS UTS-15', -1, 0, 1),
('assaultsmg', 'Magpul PDR', -1, 0, 1),
('autoshotgun', 'AA-12', -1, 0, 1),
('bag', 'Sac', 1, 0, 1),
('ball', 'ball', -1, 0, 1),
('ball_ammo', 'ball_ammo', -1, 0, 1),
('bandage', 'Bandage', 2, 0, 1),
('bat', 'Baseball Bat', -1, 0, 1),
('battleaxe', 'Battle Axe', -1, 0, 1),
('biere', 'Bière', 1, 0, 1),
('bird_crap_ammo', 'bird_crap_ammo', -1, 0, 1),
('bottle', 'Bottle', -1, 0, 1),
('bread', 'Bread', 1, 0, 1),
('bullpuprifle', 'Type 86-S', -1, 0, 1),
('bullpuprifle_mk2', 'bullpuprifle_mk2', -1, 0, 1),
('bullpupshotgun', 'Kel-Tec KSG', -1, 0, 1),
('bzgas', 'bz gas', -1, 0, 1),
('c4_bomb', 'Bombe c4', 1, 0, 1),
('canon', 'Canon', 1, 0, 1),
('carbinerifle', 'M4A1', -1, 0, 1),
('carbinerifle_mk2', 'carbinerifle_mk2', -1, 0, 1),
('carparts', 'Pièces de carrosseries', -1, 0, 1),
('clothe', 'Vêtement', 1, 0, 1),
('coke', 'Coke', 1, 0, 1),
('coke_pooch', 'Pochon de Coke', 1, 0, 1),
('combatmg', 'M249E1', -1, 0, 1),
('combatmg_mk2', 'combatmg_mk2', -1, 0, 1),
('combatpdw', 'SIG Sauer MPX', -1, 0, 1),
('combatpistol', 'Sig Sauer P228', -1, 0, 1),
('compactlauncher', 'M79 GL', -1, 0, 1),
('compactrifle', 'Micro Draco AK Pistol', -1, 0, 1),
('compresse', 'Compresse', 2, 0, 1),
('copper', 'Cuivre', 1, 0, 1),
('crowbar', 'Crow Bar', -1, 0, 1),
('cutted_wood', 'Bois coupé', 1, 0, 1),
('cutter', 'Coupeur', 1, 0, 1),
('dagger', 'Dagger', -1, 0, 1),
('dbshotgun', 'Zabala short-barreled side-by-side shotgun', -1, 0, 1),
('diamond', 'Diamant', 1, 0, 1),
('digiscanner', 'digiscanner', -1, 0, 1),
('doubleaction', 'doubleaction', -1, 0, 1),
('doublecheese', 'Double Cheese', -1, 0, 1),
('drill', 'Perceuse', 1, 0, 1),
('ecstasy', 'Ecstasy', 50, 0, 1),
('ecstasy_pooch', 'Pochon d\'Ecstasy', 1, 0, 1),
('enemy_laser_ammo', 'enemy_laser_ammo', -1, 0, 1),
('essence', 'Essence', 1, 0, 1),
('fabric', 'Tissu', 1, 0, 1),
('farine', 'Farine', 1, 0, 1),
('ferraille', 'Ferraille', 3, 0, 1),
('fireextinguisher', 'Fire Extinguisher', -1, 0, 1),
('fireextinguisher_ammo', 'fireextinguisher_ammo', -1, 0, 1),
('firework', 'Firework', -1, 0, 1),
('fish', 'Poisson', 1, 0, 1),
('fixkit', 'Kit réparation', 3, 0, 1),
('flare', 'Flare', -1, 0, 1),
('flare_ammo', 'Flares', -1, 0, 1),
('flaregun', 'Flare Gun', -1, 0, 1),
('flashlight', 'Flashlight', -1, 0, 1),
('fritecru', 'Frites Surgélé', -1, 0, 1),
('frites', 'Frites', -1, 0, 1),
('fritesfritecru', 'Frites surgelé', -1, 0, 1),
('garbagebag', 'garbagebag', -1, 0, 1),
('gasmask', 'Masque à gaz', 1, 0, 1),
('gold', 'Or', 1, 0, 1),
('golfclub', 'Golf Club', -1, 0, 1),
('grand_cru', 'Grand cru', 1, 0, 1),
('grenade', 'grenade', -1, 0, 1),
('grenadelauncher', 'Milkor MGL', -1, 0, 1),
('grenadelauncher_ammo', 'grenadelauncher_ammo', -1, 0, 1),
('grenadelauncher_smoke_ammo', 'grenadelauncher_smoke_ammo', -1, 0, 1),
('gusenberg', 'M1928A1 Thompson SMG', -1, 0, 1),
('gzgas_ammo', 'gzgas_ammo', -1, 0, 1),
('hack_usb', 'Usb hack', 1, 0, 1),
('hammer', 'Hammer', -1, 0, 1),
('handcuffs', 'handcuffs', -1, 0, 1),
('hatchet', 'hatchet', -1, 0, 1),
('heavypistol', 'EWB 1911', -1, 0, 1),
('heavyshotgun', 'Saiga-12K', -1, 0, 1),
('heavysniper', 'M107', -1, 0, 1),
('heavysniper_mk2', 'heavysniper_mk2', -1, 0, 1),
('hominglauncher', 'SA-7 Grail', -1, 0, 1),
('hostie', 'Hostie', 1, 0, 1),
('iron', 'Fer', 1, 0, 1),
('jus_raisin', 'Jus de raisin', 1, 0, 1),
('ketchup', 'Sachet de ketchup', -1, 0, 1),
('key1', 'clé 1', 1, 0, 1),
('key2', 'clé 2', 1, 0, 1),
('knife', 'Knife', -1, 0, 1),
('knuckle', 'Knuckledusters', -1, 0, 1),
('laptop', 'Ordinateur portable', 1, 0, 1),
('levier', 'Levier', 1, 0, 1),
('lsd', 'LSD', 1, 0, 1),
('lsd_pooch', 'Pochon de LSD', 1, 0, 1),
('machete', 'machete', -1, 0, 1),
('machinepistol', 'TEC-9', -1, 0, 1),
('malboro', 'Marlboro', 1, 0, 1),
('malt', 'Malt', 1, 0, 1),
('marksmanpistol', 'Thompson-Center Contender G2', -1, 0, 1),
('marksmanrifle', 'M39 EMR', -1, 0, 1),
('marksmanrifle_mk2', 'marksmanrifle_mk2', -1, 0, 1),
('meche', 'Mèche', 1, 0, 1),
('medikit', 'Kit médical', 2, 0, 1),
('metaux', 'Métaux', 1, 0, 1),
('meth', 'Meth', 1, 0, 1),
('meth_pooch', 'Pochon de Meth', 1, 0, 1),
('mg', 'PKP Pecheneg', -1, 0, 1),
('mg_ammo', 'MG Ammo', -1, 0, 1),
('microsmg', 'Micro SMG', -1, 0, 1),
('minigun', 'minigun', -1, 0, 1),
('minigun_ammo', 'Minigun Ammo', -1, 0, 1),
('minismg', 'Skorpion Vz. 61', -1, 0, 1),
('molotov', 'Molotov Cocktail', -1, 0, 1),
('molotov_ammo', 'molotov_ammo', -1, 0, 1),
('musket', 'Brown Bess', -1, 0, 1),
('necklace', 'Collier', 1, 0, 1),
('nightstick', 'ASP Baton', -1, 0, 1),
('nightvision', 'Night Vision', -1, 0, 1),
('opium', 'Opium', 1, 0, 1),
('opium_pooch', 'Pochon d\'Opium', 1, 0, 1),
('packaged_chicken', 'Poulet en barquette', 1, 0, 1),
('packaged_plank', 'Paquet de planches', 1, 0, 1),
('painpremierprix', 'Pain premier prix', 1, 0, 1),
('paintinge', 'Peinture e', 1, 0, 1),
('paintingf', 'Peinture f', 1, 0, 1),
('paintingg', 'Peinture g', 1, 0, 1),
('paintingh', 'Peinture h', 1, 0, 1),
('paintingi', 'Peinture i', 1, 0, 1),
('paintingj', 'Peinture j', 1, 0, 1),
('parachute', 'parachute', -1, 0, 1),
('petrol', 'Pétrole', 1, 0, 1),
('petrol_raffin', 'Pétrole Raffiné', 1, 0, 1),
('petrolcan', 'Petrol Can', -1, 0, 1),
('phone', 'Phone', 1, 0, 1),
('pipebomb', 'pipe bomb', -1, 0, 1),
('pistol', 'Colt M1911', -1, 0, 1),
('pistol_ammo', 'Pistol Ammo', -1, 0, 1),
('pistol_mk2', 'Sig Sauer P226', -1, 0, 1),
('pistol50', 'Desert Eagle', -1, 0, 1),
('plane_rocket_ammo', 'plane_rocket_ammo', -1, 0, 1),
('player_laser_ammo', 'player_laser_ammo', -1, 0, 1),
('poolcue', 'pool cue', -1, 0, 1),
('potatoes', 'Potatoes', -1, 0, 1),
('potatoescru', 'Potatoes Surgélé', -1, 0, 1),
('poudre', 'Poudre à canon', 1, 0, 1),
('pouletdroifcongeler', 'Poulet Cru', -1, 0, 1),
('proxmine', 'Proxmine Mine', -1, 0, 1),
('ptitwrap', 'Petit wrap', -1, 0, 1),
('ptwrap', 'Galette', -1, 0, 1),
('pumpshotgun', 'Remington 870', -1, 0, 1),
('pumpshotgun_mk2', 'pumpshotgun_mk2', -1, 0, 1),
('railgun', 'railgun', -1, 0, 1),
('raisin', 'Raisin', 1, 0, 1),
('remotesniper', 'Remote Sniper', -1, 0, 1),
('revolver', 'Taurus Raging Bull', -1, 0, 1),
('revolver_mk2', 'revolver_mk2', -1, 0, 1),
('rifle_ammo', 'Rifle Ammo', -1, 0, 1),
('ring', 'Anneau', 1, 0, 1),
('rolex', 'Rolex', 1, 0, 1),
('rpg', 'RPG-7', -1, 0, 1),
('rpg_ammo', 'RPG Ammo', -1, 0, 1),
('ruban', 'Ruban adhésif', 1, 0, 1),
('sawnoffshotgun', 'Mossberg 500', -1, 0, 1),
('shotgun_ammo', 'Shotgun Ammo', -1, 0, 1),
('slaughtered_chicken', 'Poulet abattu', 1, 0, 1),
('smg', 'MP5A3', -1, 0, 1),
('smg_ammo', 'SMG Ammo', -1, 0, 1),
('smg_mk2', 'smg_mk2', -1, 0, 1),
('smokegrenade', 'smoke grenade', -1, 0, 1),
('smokegrenade_ammo', 'smokegrenade_ammo', -1, 0, 1),
('sniper_ammo', 'Sniper Ammo', -1, 0, 1),
('sniper_remote_ammo', 'Sniper Remote Ammo', -1, 0, 1),
('sniperrifle', 'PSG-1', -1, 0, 1),
('snowball', 'Snow Ball', -1, 0, 1),
('snspistol', 'H&K P7', -1, 0, 1),
('snspistol_mk2', 'snspistol_mk2', -1, 0, 1),
('space_rocket_ammo', 'space_rocket_ammo', -1, 0, 1),
('specialcarbine', 'H&K G36C', -1, 0, 1),
('specialcarbine_mk2', 'specialcarbine_mk2', -1, 0, 1),
('steak', 'Steak haché', -1, 0, 1),
('stickybomb', 'sticky bomb', -1, 0, 1),
('stickybomb_ammo', 'stickybomb_ammo', -1, 0, 1),
('stinger', 'stinger', -1, 0, 1),
('stinger_ammo', 'stinger_ammo', -1, 0, 1),
('stone', 'Pierre', 1, 0, 1),
('stungun', 'X26 Taser', -1, 0, 1),
('stungun_ammo', 'Stungun Ammo', -1, 0, 1),
('switchblade', 'Switchblade', -1, 0, 1),
('tabac', 'Tabac', 1, 0, 1),
('tabacsec', 'Tabac Sec', 1, 0, 1),
('tank_ammo', 'tank_ammo', -1, 0, 1),
('thermite_bomb', 'Bombe thermite', 1, 0, 1),
('ticket', 'Tickets de prison', -1, 0, 1),
('vanBottle', 'Camionnette Bouteille', 1, 0, 1),
('vanDiamond', 'Camionnette diamant', 1, 0, 1),
('vanNecklace', 'Camionnette Collier', 1, 0, 1),
('vanPanther', 'Camionnette Panther', 1, 0, 1),
('vanPogo', 'Camionnette Pogo', 1, 0, 1),
('videorecord', 'Enregistrement vidéo', 1, 0, 1),
('vine', 'Vin', 1, 0, 1),
('vingtnuggets', 'Boite de 20 Nuggets', -1, 0, 1),
('vintagepistol', 'FN Model 1910', -1, 0, 1),
('washed_stone', 'Pierre Lavée', 1, 0, 1),
('water', 'Water', 1, 0, 1),
('weed', 'Weed', 1, 0, 1),
('weed_pooch', 'Pochon de Weed', 1, 0, 1),
('wood', 'Bois', 1, 0, 1),
('wool', 'Laine', 1, 0, 1),
('wrench', 'wrench', -1, 0, 1),
('pistol_ammo_box', 'Chargeur pistolet', -1, 0, 1),
('smg_ammo_box', 'Chargeur smg', -1, 0, 1),
('rifle_ammo_box', 'Chargeur rifle', -1, 0, 1),
('shotgun_ammo_box', 'Chargeur shotgun', -1, 0, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `jobs`
--

INSERT INTO `jobs` (`name`, `label`) VALUES
('ambulance', 'Ambulance'),
('ammu', 'Ammu-Nation'),
('bahamas', 'Bahamas'),
('ballas', 'Ballas'),
('blanchisseur', 'Blanchisseur'),
('boulangerie', 'Boulangerie'),
('brasserie', 'Brasserie'),
('cardealer', 'Concessionnaire'),
('cartel', 'Cartel'),
('crips', 'Crips'),
('driving', 'Auto-école'),
('famillies', 'Famillies'),
('ferrailleur', 'Ferrailleur'),
('fire', 'Sapeur-Pompier'),
('fisherman', 'Pêcheur'),
('fourriere', 'Fourrière'),
('fueler', 'Raffineur'),
('lumberjack', 'Bûcheron'),
('mafia', 'Mafia'),
('marabunta', 'Marabunta'),
('mcdonalds', 'McDonalds'),
('mechanic', 'Benny\'s'),
('miner', 'Mineur'),
('motodealer', 'Concessionnaire Moto'),
('police', 'LSPD'),
('realestateagent', 'Agent immobilier'),
('reporter', 'Journaliste'),
('slaughterer', 'Abatteur'),
('split', 'Slipt Sides'),
('tabac', 'Tabac'),
('tailor', 'Couturier'),
('taxi', 'Taxi'),
('tequila', 'Tequila'),
('unemployed', 'Unemployed'),
('unicorn', 'Vanilla Unicorn'),
('vagos', 'Vagos'),
('vigneron', 'Vigneron');

-- --------------------------------------------------------

--
-- Estrutura da tabela `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `skin_female` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}'),
(6, 'ambulance', 0, 'ambulance', 'Ambulancier', 20, '{}', '{}'),
(7, 'ambulance', 1, 'doctor', 'Medecin', 40, '{}', '{}'),
(8, 'ambulance', 2, 'chief_doctor', 'Medecin-chef', 60, '{}', '{}'),
(9, 'ambulance', 3, 'boss', 'Chirurgien', 80, '{}', '{}'),
(10, 'ammu', 0, 'soldato', 'Garde', 200, 'null', 'null'),
(11, 'ammu', 1, 'capo', 'Vendeur', 400, 'null', 'null'),
(12, 'ammu', 2, 'consigliere', 'Directeur', 600, 'null', 'null'),
(13, 'ammu', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(14, 'driving', 0, 'motorinstr', 'Instructeur de moto', 50, '{}', '{}'),
(15, 'driving', 1, 'carinstr', 'Instructeur de voiture', 70, '{}', '{}'),
(16, 'driving', 2, 'truckinstr', 'Instructeur de camion', 120, '{}', '{}'),
(17, 'driving', 3, 'examiner', 'Examinateur', 200, '{}', '{}'),
(18, 'driving', 4, 'boss', 'Patron', 350, '{}', '{}'),
(19, 'bahamas', 0, 'barman', 'Barman', 200, 'null', 'null'),
(20, 'bahamas', 1, 'dancer', 'Danseur', 400, 'null', 'null'),
(21, 'bahamas', 2, 'viceboss', 'Gérant', 600, 'null', 'null'),
(22, 'bahamas', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(23, 'mechanic', 0, 'recrue', 'Recrue', 12, '{}', '{}'),
(24, 'mechanic', 1, 'novice', 'Novice', 24, '{}', '{}'),
(25, 'mechanic', 2, 'experimente', 'Experimente', 36, '{}', '{}'),
(26, 'mechanic', 3, 'chief', 'Chef d\'équipe', 48, '{}', '{}'),
(27, 'mechanic', 4, 'boss', 'Patron', 0, '{}', '{}'),
(28, 'blanchisseur', 0, 'info', 'Informateur', 200, 'null', 'null'),
(29, 'blanchisseur', 1, 'nego', 'Negociateur', 400, 'null', 'null'),
(30, 'blanchisseur', 2, 'brasdroit', 'Bras droit', 600, 'null', 'null'),
(31, 'blanchisseur', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(32, 'brasserie', 0, 'recrue', 'Intérimaire', 200, 'null', 'null'),
(33, 'brasserie', 1, 'cdisenior', 'Chef', 600, 'null', 'null'),
(34, 'brasserie', 2, 'boss', 'Patron', 1000, 'null', 'null'),
(35, 'cardealer', 0, 'recruit', 'Recrue', 10, '{}', '{}'),
(36, 'cardealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
(37, 'cardealer', 2, 'experienced', 'Experimente', 40, '{}', '{}'),
(38, 'cardealer', 3, 'boss', 'Patron', 0, '{}', '{}'),
(39, 'motodealer', 0, 'recruit', 'Recrue', 10, '{}', '{}'),
(40, 'motodealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
(41, 'motodealer', 2, 'experienced', 'Experimente', 40, '{}', '{}'),
(42, 'motodealer', 3, 'boss', 'Patron', 0, '{}', '{}'),
(43, 'mcdonalds', 0, 'recrue', 'Recrue', 12, '{}', '{}'),
(44, 'mcdonalds', 1, 'novice', 'Novice', 24, '{}', '{}'),
(45, 'mcdonalds', 2, 'experimente', 'Experimente', 36, '{}', '{}'),
(46, 'mcdonalds', 3, 'chief', 'Chef d\'équipe', 48, '{}', '{}'),
(47, 'mcdonalds', 4, 'boss', 'Patron', 0, '{}', '{}'),
(48, 'tabac', 0, 'recrue', 'Tabagiste', 200, 'null', 'null'),
(49, 'tabac', 1, 'gerant', 'Gérant', 400, 'null', 'null'),
(50, 'tabac', 2, 'boss', 'Patron', 1000, 'null', 'null'),
(51, 'taxi', 0, 'recrue', 'Recrue', 12, 'null', 'null'),
(52, 'taxi', 1, 'novice', 'Novice', 24, 'null', 'null'),
(53, 'taxi', 2, 'experimente', 'Experimente', 36, 'null', 'null'),
(54, 'taxi', 3, 'uber', 'Uber', 48, 'null', 'null'),
(55, 'taxi', 4, 'boss', 'Patron', 0, 'null', 'null'),
(56, 'tequila', 0, 'barman', 'Barman', 200, 'null', 'null'),
(57, 'tequila', 1, 'dancer', 'Danseur', 400, 'null', 'null'),
(58, 'tequila', 2, 'viceboss', 'Gérant', 600, 'null', 'null'),
(59, 'tequila', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(60, 'unicorn', 0, 'barman', 'Barman', 200, 'null', 'null'),
(61, 'unicorn', 1, 'dancer', 'Danseur', 400, 'null', 'null'),
(62, 'unicorn', 2, 'viceboss', 'Gérant', 600, 'null', 'null'),
(63, 'unicorn', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(64, 'vigneron', 0, 'recrue', 'Intérimaire', 1200, '{}', '{}'),
(65, 'vigneron', 1, 'novice', 'Vigneron', 1400, '{}', '{}'),
(66, 'vigneron', 2, 'cdisenior', 'Chef de chai', 1600, '{}', '{}'),
(67, 'vigneron', 3, 'boss', 'Patron', 2000, '{}', '{}'),
(68, 'fire', 0, 'sapeur', 'Sapeur', 20, '{}', '{}'),
(69, 'fire', 1, 'caporal', 'Caporal', 40, '{}', '{}'),
(70, 'fire', 2, 'sergeant', 'Sergent', 60, '{}', '{}'),
(71, 'fire', 3, '1sergeant', '1er Sergent', 85, '{}', '{}'),
(72, 'fire', 4, 'sergeantmajor', 'Sergent-major', 100, '{}', '{}'),
(73, 'fire', 5, 'adjudant', 'Adjudant', 150, '{}', '{}'),
(74, 'fire', 6, 'adjudantchef', 'Adjudant-chef', 200, '{}', '{}'),
(75, 'fire', 7, 'souslieutenant', 'Sous-lieutenant', 250, '{}', '{}'),
(76, 'fire', 8, 'lieutenant', 'Lieutenant', 300, '{}', '{}'),
(77, 'fire', 9, 'capitaine', 'Capitaine', 500, '{}', '{}'),
(78, 'fire', 10, 'major', 'Major', 700, '{}', '{}'),
(79, 'fire', 11, 'lieutenantcolonel', 'Lieutenant-colonel', 850, '{}', '{}'),
(80, 'fire', 12, 'boss', 'Colonel', 1000, '{}', '{}'),
(81, 'police', 0, 'recruit', 'Recrue', 20, '{}', '{}'),
(82, 'police', 1, 'officer', 'Officier', 40, '{}', '{}'),
(83, 'police', 2, 'sergeant', 'Sergent', 60, '{}', '{}'),
(84, 'police', 3, 'lieutenant', 'Lieutenant', 85, '{}', '{}'),
(85, 'police', 4, 'boss', 'Commandant', 100, '{}', '{}'),
(86, 'ballas', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
(87, 'ballas', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
(88, 'ballas', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
(89, 'ballas', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
(90, 'crips', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
(91, 'crips', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
(92, 'crips', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
(93, 'crips', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
(94, 'famillies', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
(95, 'famillies', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
(96, 'famillies', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
(97, 'famillies', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
(98, 'marabunta', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
(99, 'marabunta', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
(100, 'marabunta', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
(101, 'marabunta', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
(102, 'vagos', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
(103, 'vagos', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
(104, 'vagos', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
(105, 'vagos', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
(108, 'fourriere', 0, 'recruit', 'Recrue', 100, '{}', '{}'),
(109, 'fourriere', 1, 'remorqueur', 'Remorqueur', 200, '{}', '{}'),
(110, 'fourriere', 2, 'gardien', 'Gardien', 300, '{}', '{}'),
(111, 'fourriere', 3, 'boss', 'Patron', 400, '{}', '{}'),
(112, 'ferrailleur', 0, 'ferrailleur', 'Intérim', 500, 'null', 'null'),
(113, 'lumberjack', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(114, 'fisherman', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(115, 'fueler', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(116, 'reporter', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(117, 'tailor', 0, 'employee', 'Intérimaire', 0, '{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
(118, 'miner', 0, 'employee', 'Intérimaire', 0, '{\"tshirt_2\":1,\"ears_1\":8,\"glasses_1\":15,\"torso_2\":0,\"ears_2\":2,\"glasses_2\":3,\"shoes_2\":1,\"pants_1\":75,\"shoes_1\":51,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":7,\"torso_1\":71,\"tshirt_1\":59,\"arms\":2,\"bags_2\":0,\"helmet_1\":0}', '{}'),
(119, 'slaughterer', 0, 'employee', 'Intérimaire', 0, '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}'),
(120, 'realestateagent', 0, 'location', 'Location', 10, '{}', '{}'),
(121, 'realestateagent', 1, 'vendeur', 'Vendeur', 25, '{}', '{}'),
(122, 'realestateagent', 2, 'gestion', 'Gestion', 40, '{}', '{}'),
(123, 'realestateagent', 3, 'boss', 'Patron', 0, '{}', '{}'),
(124, 'cartel', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
(125, 'cartel', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
(126, 'cartel', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
(127, 'cartel', 3, 'boss', 'Chef', 1000, 'null', 'null'),
(128, 'mafia', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
(129, 'mafia', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
(130, 'mafia', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
(131, 'mafia', 3, 'boss', 'Chef', 1000, 'null', 'null'),
(132, 'boulangerie', 0, 'recrue', 'Intérimaire', 200, 'null', 'null'),
(133, 'boulangerie', 1, 'novice', 'Pâtissier', 400, 'null', 'null'),
(134, 'boulangerie', 2, 'cdisenior', 'Chef', 600, 'null', 'null'),
(135, 'boulangerie', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(136, 'boulangerie', 0, 'recrue', 'Intérimaire', 200, 'null', 'null'),
(137, 'boulangerie', 1, 'novice', 'Pâtissier', 400, 'null', 'null'),
(138, 'boulangerie', 2, 'cdisenior', 'Chef', 600, 'null', 'null'),
(139, 'boulangerie', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(140, 'split', 0, 'barman', 'Barman', 200, 'null', 'null'),
(141, 'split', 1, 'dancer', 'Danseur', 400, 'null', 'null'),
(142, 'split', 2, 'viceboss', 'Gérant', 600, 'null', 'null'),
(143, 'split', 3, 'boss', 'Patron', 1000, 'null', 'null'),
(148, 'lumberjack', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(149, 'fisherman', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(150, 'fueler', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(151, 'reporter', 0, 'employee', 'Intérimaire', 0, '{}', '{}'),
(152, 'tailor', 0, 'employee', 'Intérimaire', 0, '{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
(153, 'miner', 0, 'employee', 'Intérimaire', 0, '{\"tshirt_2\":1,\"ears_1\":8,\"glasses_1\":15,\"torso_2\":0,\"ears_2\":2,\"glasses_2\":3,\"shoes_2\":1,\"pants_1\":75,\"shoes_1\":51,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":7,\"torso_1\":71,\"tshirt_1\":59,\"arms\":2,\"bags_2\":0,\"helmet_1\":0}', '{}'),
(154, 'slaughterer', 0, 'employee', 'Intérimaire', 0, '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}');

-- --------------------------------------------------------

--
-- Estrutura da tabela `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('dmv', 'Code de la route'),
('drive', 'Permis de voiture'),
('drive_bike', 'Permis moto'),
('drive_truck', 'Permis camion'),
('weapon', 'Permis port d\'armes');

-- --------------------------------------------------------

--
-- Estrutura da tabela `moto_categories`
--

CREATE TABLE `moto_categories` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `moto_categories`
--

INSERT INTO `moto_categories` (`name`, `label`) VALUES
('motorcycles', 'Moto');

-- --------------------------------------------------------

--
-- Estrutura da tabela `open_car`
--

CREATE TABLE `open_car` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `got` varchar(50) DEFAULT NULL,
  `NB` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `owned_properties`
--

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'car',
  `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_clothe`
--

CREATE TABLE `player_clothe` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `clothe` text NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entering` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inside` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outside` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ipls` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `gateway` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{\"y\":564.89,\"z\":182.959,\"x\":119.384}', '{\"x\":117.347,\"y\":559.506,\"z\":183.304}', '{\"y\":557.032,\"z\":183.301,\"x\":118.037}', '{\"y\":567.798,\"z\":182.131,\"x\":119.249}', '[]', NULL, 1, 1, 0, '{\"x\":118.748,\"y\":566.573,\"z\":175.697}', 1500000),
(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{\"x\":372.796,\"y\":428.327,\"z\":144.685}', '{\"x\":373.548,\"y\":422.982,\"z\":144.907}', '{\"y\":420.075,\"z\":145.904,\"x\":372.161}', '{\"x\":372.454,\"y\":432.886,\"z\":143.443}', '[]', NULL, 1, 1, 0, '{\"x\":377.349,\"y\":429.422,\"z\":137.3}', 1500000),
(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{\"y\":-379.165,\"z\":37.961,\"x\":-936.363}', '{\"y\":-365.476,\"z\":113.274,\"x\":-913.097}', '{\"y\":-367.637,\"z\":113.274,\"x\":-918.022}', '{\"y\":-382.023,\"z\":37.961,\"x\":-943.626}', '[]', NULL, 1, 1, 0, '{\"x\":-927.554,\"y\":-377.744,\"z\":112.674}', 1700000),
(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{\"y\":440.8,\"z\":146.702,\"x\":346.964}', '{\"y\":437.456,\"z\":148.394,\"x\":341.683}', '{\"y\":435.626,\"z\":148.394,\"x\":339.595}', '{\"x\":350.535,\"y\":443.329,\"z\":145.764}', '[]', NULL, 1, 1, 0, '{\"x\":337.726,\"y\":436.985,\"z\":140.77}', 1500000),
(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{\"y\":502.696,\"z\":136.421,\"x\":-176.003}', '{\"y\":497.817,\"z\":136.653,\"x\":-174.349}', '{\"y\":495.069,\"z\":136.666,\"x\":-173.331}', '{\"y\":506.412,\"z\":135.0664,\"x\":-177.927}', '[]', NULL, 1, 1, 0, '{\"x\":-174.725,\"y\":493.095,\"z\":129.043}', 1500000),
(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{\"y\":596.58,\"z\":142.641,\"x\":-686.554}', '{\"y\":591.988,\"z\":144.392,\"x\":-681.728}', '{\"y\":590.608,\"z\":144.392,\"x\":-680.124}', '{\"y\":599.019,\"z\":142.059,\"x\":-689.492}', '[]', NULL, 1, 1, 0, '{\"x\":-680.46,\"y\":588.6,\"z\":136.769}', 1500000),
(7, 'LowEndApartment', 'Appartement de base', '{\"y\":-1078.735,\"z\":28.4031,\"x\":292.528}', '{\"y\":-1007.152,\"z\":-102.002,\"x\":265.845}', '{\"y\":-1002.802,\"z\":-100.008,\"x\":265.307}', '{\"y\":-1078.669,\"z\":28.401,\"x\":296.738}', '[]', NULL, 1, 1, 0, '{\"x\":265.916,\"y\":-999.38,\"z\":-100.008}', 562500),
(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{\"y\":454.955,\"z\":96.462,\"x\":-1294.433}', '{\"x\":-1289.917,\"y\":449.541,\"z\":96.902}', '{\"y\":446.322,\"z\":96.899,\"x\":-1289.642}', '{\"y\":455.453,\"z\":96.517,\"x\":-1298.851}', '[]', NULL, 1, 1, 0, '{\"x\":-1287.306,\"y\":455.901,\"z\":89.294}', 1500000),
(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{\"x\":-853.346,\"y\":696.678,\"z\":147.782}', '{\"y\":690.875,\"z\":151.86,\"x\":-859.961}', '{\"y\":688.361,\"z\":151.857,\"x\":-859.395}', '{\"y\":701.628,\"z\":147.773,\"x\":-855.007}', '[]', NULL, 1, 1, 0, '{\"x\":-858.543,\"y\":697.514,\"z\":144.253}', 1500000),
(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{\"y\":620.494,\"z\":141.588,\"x\":-752.82}', '{\"y\":618.62,\"z\":143.153,\"x\":-759.317}', '{\"y\":617.629,\"z\":143.153,\"x\":-760.789}', '{\"y\":621.281,\"z\":141.254,\"x\":-750.919}', '[]', NULL, 1, 1, 0, '{\"x\":-762.504,\"y\":618.992,\"z\":135.53}', 1500000),
(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{\"y\":37.025,\"z\":42.58,\"x\":-618.299}', '{\"y\":58.898,\"z\":97.2,\"x\":-603.301}', '{\"y\":58.941,\"z\":97.2,\"x\":-608.741}', '{\"y\":30.603,\"z\":42.524,\"x\":-620.017}', '[]', NULL, 1, 1, 0, '{\"x\":-622.173,\"y\":54.585,\"z\":96.599}', 1700000),
(12, 'MiltonDrive', 'Milton Drive', '{\"x\":-775.17,\"y\":312.01,\"z\":84.658}', NULL, NULL, '{\"x\":-775.346,\"y\":306.776,\"z\":84.7}', '[]', NULL, 0, 0, 1, NULL, 0),
(13, 'Modern1Apartment', 'Appartement Moderne 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_01_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.661,\"y\":327.672,\"z\":210.396}', 1300000),
(14, 'Modern2Apartment', 'Appartement Moderne 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_01_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.735,\"y\":326.757,\"z\":186.313}', 1300000),
(15, 'Modern3Apartment', 'Appartement Moderne 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_01_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.386,\"y\":330.782,\"z\":195.08}', 1300000),
(16, 'Mody1Apartment', 'Appartement Mode 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_02_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.615,\"y\":327.878,\"z\":210.396}', 1300000),
(17, 'Mody2Apartment', 'Appartement Mode 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_02_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.297,\"y\":327.092,\"z\":186.313}', 1300000),
(18, 'Mody3Apartment', 'Appartement Mode 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_02_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.303,\"y\":330.932,\"z\":195.085}', 1300000),
(19, 'Vibrant1Apartment', 'Appartement Vibrant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_03_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.885,\"y\":327.641,\"z\":210.396}', 1300000),
(20, 'Vibrant2Apartment', 'Appartement Vibrant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_03_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.607,\"y\":327.344,\"z\":186.313}', 1300000),
(21, 'Vibrant3Apartment', 'Appartement Vibrant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_03_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.525,\"y\":330.851,\"z\":195.085}', 1300000),
(22, 'Sharp1Apartment', 'Appartement Persan 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_04_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.527,\"y\":327.89,\"z\":210.396}', 1300000),
(23, 'Sharp2Apartment', 'Appartement Persan 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_04_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.642,\"y\":326.497,\"z\":186.313}', 1300000),
(24, 'Sharp3Apartment', 'Appartement Persan 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_04_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.503,\"y\":331.318,\"z\":195.085}', 1300000),
(25, 'Monochrome1Apartment', 'Appartement Monochrome 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_05_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.289,\"y\":328.086,\"z\":210.396}', 1300000),
(26, 'Monochrome2Apartment', 'Appartement Monochrome 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_05_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.692,\"y\":326.762,\"z\":186.313}', 1300000),
(27, 'Monochrome3Apartment', 'Appartement Monochrome 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_05_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.094,\"y\":330.976,\"z\":195.085}', 1300000),
(28, 'Seductive1Apartment', 'Appartement Séduisant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_06_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.263,\"y\":328.104,\"z\":210.396}', 1300000),
(29, 'Seductive2Apartment', 'Appartement Séduisant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_06_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.655,\"y\":326.611,\"z\":186.313}', 1300000),
(30, 'Seductive3Apartment', 'Appartement Séduisant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_06_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.3,\"y\":331.414,\"z\":195.085}', 1300000),
(31, 'Regal1Apartment', 'Appartement Régal 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_07_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.956,\"y\":328.257,\"z\":210.396}', 1300000),
(32, 'Regal2Apartment', 'Appartement Régal 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_07_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.545,\"y\":326.659,\"z\":186.313}', 1300000),
(33, 'Regal3Apartment', 'Appartement Régal 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_07_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.087,\"y\":331.429,\"z\":195.123}', 1300000),
(34, 'Aqua1Apartment', 'Appartement Aqua 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_08_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.187,\"y\":328.47,\"z\":210.396}', 1300000),
(35, 'Aqua2Apartment', 'Appartement Aqua 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_08_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.658,\"y\":326.563,\"z\":186.313}', 1300000),
(36, 'Aqua3Apartment', 'Appartement Aqua 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_08_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.287,\"y\":331.084,\"z\":195.086}', 1300000),
(37, 'IntegrityWay', '4 Integrity Way', '{\"x\":-47.804,\"y\":-585.867,\"z\":36.956}', NULL, NULL, '{\"x\":-54.178,\"y\":-583.762,\"z\":35.798}', '[]', NULL, 0, 0, 1, NULL, 0),
(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{\"x\":-31.409,\"y\":-594.927,\"z\":79.03}', '{\"x\":-26.098,\"y\":-596.909,\"z\":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-11.923,\"y\":-597.083,\"z\":78.43}', 1700000),
(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{\"x\":-17.702,\"y\":-588.524,\"z\":89.114}', '{\"x\":-16.21,\"y\":-582.569,\"z\":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-26.327,\"y\":-588.384,\"z\":89.123}', 1700000),
(40, 'DellPerroHeights', 'Dell Perro Heights', '{\"x\":-1447.06,\"y\":-538.28,\"z\":33.74}', NULL, NULL, '{\"x\":-1440.022,\"y\":-548.696,\"z\":33.74}', '[]', NULL, 0, 0, 1, NULL, 0),
(41, 'DellPerroHeightst4', 'Dell Perro Heights - Apt 28', NULL, '{\"x\":-1452.125,\"y\":-540.591,\"z\":73.044}', '{\"x\":-1455.435,\"y\":-535.79,\"z\":73.044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1467.058,\"y\":-527.571,\"z\":72.443}', 1700000),
(42, 'DellPerroHeightst7', 'Dell Perro Heights - Apt 30', NULL, '{\"x\":-1451.562,\"y\":-523.535,\"z\":55.928}', '{\"x\":-1456.02,\"y\":-519.209,\"z\":55.929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1457.026,\"y\":-530.219,\"z\":55.937}', 1700000);

-- --------------------------------------------------------

--
-- Estrutura da tabela `society_moneywash`
--

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `society` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `twitter_accounts`
--

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `twitter_likes`
--

CREATE TABLE `twitter_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `twitter_tweets`
--

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accounts` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `inventory` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'unemployed',
  `job2_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `firstname` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateofbirth` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `tattoos` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_property` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_accessories`
--

CREATE TABLE `user_accessories` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `mask` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin DEFAULT 'Masque',
  `type` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `index` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vcoffre`
--

CREATE TABLE `vcoffre` (
  `vPlate` varchar(255) NOT NULL,
  `vInventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `vLoadout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `vMoney` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles`
--

CREATE TABLE `vehicles` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
('Adder', 'adder', 900000, 'super'),
('Akuma', 'AKUMA', 7500, 'motorcycles'),
('Alpha', 'alpha', 60000, 'sports'),
('Ardent', 'ardent', 1150000, 'sportsclassics'),
('Asea', 'asea', 5500, 'sedans'),
('Autarch', 'autarch', 1955000, 'super'),
('Avarus', 'avarus', 18000, 'motorcycles'),
('Bagger', 'bagger', 13500, 'motorcycles'),
('Baller', 'baller2', 40000, 'suvs'),
('Baller Sport', 'baller3', 60000, 'suvs'),
('Banshee', 'banshee', 70000, 'sports'),
('Banshee 900R', 'banshee2', 255000, 'super'),
('Bati 801', 'bati', 12000, 'motorcycles'),
('Bati 801RR', 'bati2', 19000, 'motorcycles'),
('Bestia GTS', 'bestiagts', 55000, 'sports'),
('BF400', 'bf400', 6500, 'motorcycles'),
('Bf Injection', 'bfinjection', 16000, 'offroad'),
('Bifta', 'bifta', 12000, 'offroad'),
('Bison', 'bison', 45000, 'vans'),
('Blade', 'blade', 15000, 'muscle'),
('Blazer', 'blazer', 6500, 'offroad'),
('Blazer Sport', 'blazer4', 8500, 'offroad'),
('blazer5', 'blazer5', 1755600, 'offroad'),
('Blista', 'blista', 8000, 'compacts'),
('BMX (velo)', 'bmx', 160, 'motorcycles'),
('Bobcat XL', 'bobcatxl', 32000, 'vans'),
('Brawler', 'brawler', 45000, 'offroad'),
('Brioso R/A', 'brioso', 18000, 'compacts'),
('Btype', 'btype', 62000, 'sportsclassics'),
('Btype Hotroad', 'btype2', 155000, 'sportsclassics'),
('Btype Luxe', 'btype3', 85000, 'sportsclassics'),
('Buccaneer', 'buccaneer', 18000, 'muscle'),
('Buccaneer Rider', 'buccaneer2', 24000, 'muscle'),
('Buffalo', 'buffalo', 12000, 'sports'),
('Buffalo S', 'buffalo2', 20000, 'sports'),
('Bullet', 'bullet', 90000, 'super'),
('Burrito', 'burrito3', 19000, 'vans'),
('Camper', 'camper', 42000, 'vans'),
('Carbonizzare', 'carbonizzare', 75000, 'sports'),
('Carbon RS', 'carbonrs', 18000, 'motorcycles'),
('Casco', 'casco', 30000, 'sportsclassics'),
('Cavalcade', 'cavalcade2', 55000, 'suvs'),
('Cheetah', 'cheetah', 375000, 'super'),
('Chimera', 'chimera', 38000, 'motorcycles'),
('Chino', 'chino', 15000, 'muscle'),
('Chino Luxe', 'chino2', 19000, 'muscle'),
('Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
('Cognoscenti Cabrio', 'cogcabrio', 55000, 'coupes'),
('Cognoscenti', 'cognoscenti', 55000, 'sedans'),
('Comet', 'comet2', 65000, 'sports'),
('Comet 5', 'comet5', 1145000, 'sports'),
('Contender', 'contender', 70000, 'suvs'),
('Coquette', 'coquette', 65000, 'sports'),
('Coquette Classic', 'coquette2', 40000, 'sportsclassics'),
('Coquette BlackFin', 'coquette3', 55000, 'muscle'),
('Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
('Cyclone', 'cyclone', 1890000, 'super'),
('Daemon', 'daemon', 11500, 'motorcycles'),
('Daemon High', 'daemon2', 13500, 'motorcycles'),
('Defiler', 'defiler', 9800, 'motorcycles'),
('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
('Dominator', 'dominator', 35000, 'muscle'),
('Double T', 'double', 28000, 'motorcycles'),
('Dubsta', 'dubsta', 45000, 'suvs'),
('Dubsta Luxuary', 'dubsta2', 60000, 'suvs'),
('Bubsta 6x6', 'dubsta3', 120000, 'offroad'),
('Dukes', 'dukes', 28000, 'muscle'),
('Dune Buggy', 'dune', 8000, 'offroad'),
('Elegy', 'elegy2', 38500, 'sports'),
('Emperor', 'emperor', 8500, 'sedans'),
('Enduro', 'enduro', 5500, 'motorcycles'),
('Entity XF', 'entityxf', 425000, 'super'),
('Esskey', 'esskey', 4200, 'motorcycles'),
('Exemplar', 'exemplar', 32000, 'coupes'),
('F620', 'f620', 40000, 'coupes'),
('Faction', 'faction', 20000, 'muscle'),
('Faction Rider', 'faction2', 30000, 'muscle'),
('Faction XL', 'faction3', 40000, 'muscle'),
('Faggio', 'faggio', 1900, 'motorcycles'),
('Vespa', 'faggio2', 2800, 'motorcycles'),
('Felon', 'felon', 42000, 'coupes'),
('Felon GT', 'felon2', 55000, 'coupes'),
('Feltzer', 'feltzer2', 55000, 'sports'),
('Stirling GT', 'feltzer3', 65000, 'sportsclassics'),
('Fixter (velo)', 'fixter', 225, 'motorcycles'),
('FMJ', 'fmj', 185000, 'super'),
('Fhantom', 'fq2', 17000, 'suvs'),
('Fugitive', 'fugitive', 12000, 'sedans'),
('Furore GT', 'furoregt', 45000, 'sports'),
('Fusilade', 'fusilade', 40000, 'sports'),
('Gargoyle', 'gargoyle', 16500, 'motorcycles'),
('Gauntlet', 'gauntlet', 30000, 'muscle'),
('Gang Burrito', 'gburrito', 45000, 'vans'),
('Burrito', 'gburrito2', 29000, 'vans'),
('Glendale', 'glendale', 6500, 'sedans'),
('Grabger', 'granger', 50000, 'suvs'),
('Gresley', 'gresley', 47500, 'suvs'),
('GT 500', 'gt500', 785000, 'sportsclassics'),
('Guardian', 'guardian', 45000, 'offroad'),
('Hakuchou', 'hakuchou', 31000, 'motorcycles'),
('Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles'),
('Hermes', 'hermes', 535000, 'muscle'),
('Hexer', 'hexer', 12000, 'motorcycles'),
('Hotknife', 'hotknife', 125000, 'muscle'),
('Huntley S', 'huntley', 40000, 'suvs'),
('Hustler', 'hustler', 625000, 'muscle'),
('Infernus', 'infernus', 180000, 'super'),
('Innovation', 'innovation', 23500, 'motorcycles'),
('Intruder', 'intruder', 7500, 'sedans'),
('Issi', 'issi2', 10000, 'compacts'),
('Jackal', 'jackal', 38000, 'coupes'),
('Jester', 'jester', 65000, 'sports'),
('Jester(Racecar)', 'jester2', 135000, 'sports'),
('Journey', 'journey', 6500, 'vans'),
('Kamacho', 'kamacho', 345000, 'offroad'),
('Khamelion', 'khamelion', 38000, 'sports'),
('Kuruma', 'kuruma', 30000, 'sports'),
('Landstalker', 'landstalker', 35000, 'suvs'),
('RE-7B', 'le7b', 325000, 'super'),
('Lynx', 'lynx', 40000, 'sports'),
('Mamba', 'mamba', 70000, 'sports'),
('Manana', 'manana', 12800, 'sportsclassics'),
('Manchez', 'manchez', 5300, 'motorcycles'),
('Massacro', 'massacro', 65000, 'sports'),
('Massacro(Racecar)', 'massacro2', 130000, 'sports'),
('Mesa', 'mesa', 16000, 'suvs'),
('Mesa Trail', 'mesa3', 40000, 'suvs'),
('Minivan', 'minivan', 13000, 'vans'),
('Monroe', 'monroe', 55000, 'sportsclassics'),
('The Liberator', 'monster', 210000, 'offroad'),
('Moonbeam', 'moonbeam', 18000, 'vans'),
('Moonbeam Rider', 'moonbeam2', 35000, 'vans'),
('Nemesis', 'nemesis', 5800, 'motorcycles'),
('Neon', 'neon', 1500000, 'sports'),
('Nightblade', 'nightblade', 35000, 'motorcycles'),
('Nightshade', 'nightshade', 65000, 'muscle'),
('9F', 'ninef', 65000, 'sports'),
('9F Cabrio', 'ninef2', 80000, 'sports'),
('Omnis', 'omnis', 35000, 'sports'),
('Oppressor', 'oppressor', 3524500, 'super'),
('Oracle XS', 'oracle2', 35000, 'coupes'),
('Osiris', 'osiris', 160000, 'super'),
('Panto', 'panto', 10000, 'compacts'),
('Paradise', 'paradise', 19000, 'vans'),
('Pariah', 'pariah', 1420000, 'sports'),
('Patriot', 'patriot', 55000, 'suvs'),
('PCJ-600', 'pcj', 6200, 'motorcycles'),
('Penumbra', 'penumbra', 28000, 'sports'),
('Pfister', 'pfister811', 85000, 'super'),
('Phoenix', 'phoenix', 12500, 'muscle'),
('Picador', 'picador', 18000, 'muscle'),
('Pigalle', 'pigalle', 20000, 'sportsclassics'),
('Prairie', 'prairie', 12000, 'compacts'),
('Premier', 'premier', 8000, 'sedans'),
('Primo Custom', 'primo2', 14000, 'sedans'),
('X80 Proto', 'prototipo', 2500000, 'super'),
('Radius', 'radi', 29000, 'suvs'),
('raiden', 'raiden', 1375000, 'sports'),
('Rapid GT', 'rapidgt', 35000, 'sports'),
('Rapid GT Convertible', 'rapidgt2', 45000, 'sports'),
('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
('Reaper', 'reaper', 150000, 'super'),
('Rebel', 'rebel2', 35000, 'offroad'),
('Regina', 'regina', 5000, 'sedans'),
('Retinue', 'retinue', 615000, 'sportsclassics'),
('Revolter', 'revolter', 1610000, 'sports'),
('riata', 'riata', 380000, 'offroad'),
('Rocoto', 'rocoto', 45000, 'suvs'),
('Ruffian', 'ruffian', 6800, 'motorcycles'),
('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
('Rumpo', 'rumpo', 15000, 'vans'),
('Rumpo Trail', 'rumpo3', 19500, 'vans'),
('Sabre Turbo', 'sabregt', 20000, 'muscle'),
('Sabre GT', 'sabregt2', 25000, 'muscle'),
('Sanchez', 'sanchez', 5300, 'motorcycles'),
('Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
('Sanctus', 'sanctus', 25000, 'motorcycles'),
('Sandking', 'sandking', 55000, 'offroad'),
('Savestra', 'savestra', 990000, 'sportsclassics'),
('SC 1', 'sc1', 1603000, 'super'),
('Schafter', 'schafter2', 25000, 'sedans'),
('Schafter V12', 'schafter3', 50000, 'sports'),
('Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
('Seminole', 'seminole', 25000, 'suvs'),
('Sentinel', 'sentinel', 32000, 'coupes'),
('Sentinel XS', 'sentinel2', 40000, 'coupes'),
('Sentinel3', 'sentinel3', 650000, 'sports'),
('Seven 70', 'seven70', 39500, 'sports'),
('ETR1', 'sheava', 220000, 'super'),
('Shotaro Concept', 'shotaro', 320000, 'motorcycles'),
('Slam Van', 'slamvan3', 11500, 'muscle'),
('Sovereign', 'sovereign', 22000, 'motorcycles'),
('Stinger', 'stinger', 80000, 'sportsclassics'),
('Stinger GT', 'stingergt', 75000, 'sportsclassics'),
('Streiter', 'streiter', 500000, 'sports'),
('Stretch', 'stretch', 90000, 'sedans'),
('Stromberg', 'stromberg', 3185350, 'sports'),
('Sultan', 'sultan', 15000, 'sports'),
('Sultan RS', 'sultanrs', 65000, 'super'),
('Super Diamond', 'superd', 130000, 'sedans'),
('Surano', 'surano', 50000, 'sports'),
('Surfer', 'surfer', 12000, 'vans'),
('T20', 't20', 300000, 'super'),
('Tailgater', 'tailgater', 30000, 'sedans'),
('Tampa', 'tampa', 16000, 'muscle'),
('Drift Tampa', 'tampa2', 80000, 'sports'),
('Thrust', 'thrust', 24000, 'motorcycles'),
('Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
('Trophy Truck', 'trophytruck', 60000, 'offroad'),
('Trophy Truck Limited', 'trophytruck2', 80000, 'offroad'),
('Tropos', 'tropos', 40000, 'sports'),
('Turismo R', 'turismor', 350000, 'super'),
('Tyrus', 'tyrus', 600000, 'super'),
('Vacca', 'vacca', 120000, 'super'),
('Vader', 'vader', 7200, 'motorcycles'),
('Verlierer', 'verlierer2', 70000, 'sports'),
('Vigero', 'vigero', 12500, 'muscle'),
('Virgo', 'virgo', 14000, 'muscle'),
('Viseris', 'viseris', 875000, 'sportsclassics'),
('Visione', 'visione', 2250000, 'super'),
('Voltic', 'voltic', 90000, 'super'),
('Voltic 2', 'voltic2', 3830400, 'super'),
('Voodoo', 'voodoo', 7200, 'muscle'),
('Vortex', 'vortex', 9800, 'motorcycles'),
('Warrener', 'warrener', 4000, 'sedans'),
('Washington', 'washington', 9000, 'sedans'),
('Windsor', 'windsor', 95000, 'coupes'),
('Windsor Drop', 'windsor2', 125000, 'coupes'),
('Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
('XLS', 'xls', 32000, 'suvs'),
('Yosemite', 'yosemite', 485000, 'muscle'),
('Youga', 'youga', 10800, 'vans'),
('Youga Luxuary', 'youga2', 14500, 'vans'),
('Z190', 'z190', 900000, 'sportsclassics'),
('Zentorno', 'zentorno', 1500000, 'super'),
('Zion', 'zion', 36000, 'coupes'),
('Zion Cabrio', 'zion2', 45000, 'coupes'),
('Zombie', 'zombiea', 9500, 'motorcycles'),
('Zombie Luxuary', 'zombieb', 12000, 'motorcycles'),
('Z-Type', 'ztype', 220000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'Coupés'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Índices para tabela `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Índices para tabela `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Índices para tabela `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Índices para tabela `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`);
  
--
-- Índices para tabela `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`);

--
-- Índices para tabela `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Índices para tabela `fourriere_report`
--
ALTER TABLE `fourriere_report`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Índices para tabela `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Índices para tabela `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`);

--
-- Índices para tabela `moto_categories`
--
ALTER TABLE `moto_categories`
  ADD PRIMARY KEY (`name`);

--
-- Índices para tabela `open_car`
--
ALTER TABLE `open_car`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `owned_properties`
--
ALTER TABLE `owned_properties`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Índices para tabela `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `player_clothe`
--
ALTER TABLE `player_clothe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `clothe` (`clothe`(768)),
  ADD KEY `identifier` (`identifier`);

--
-- Índices para tabela `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `society_moneywash`
--
ALTER TABLE `society_moneywash`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Índices para tabela `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  ADD KEY `FK_twitter_likes_twitter_tweets` (`tweetId`);

--
-- Índices para tabela `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_tweets_twitter_accounts` (`authorId`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Índices para tabela `user_accessories`
--
ALTER TABLE `user_accessories`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `vcoffre`
--
ALTER TABLE `vcoffre`
  ADD PRIMARY KEY (`vPlate`);

--
-- Índices para tabela `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`model`);

--
-- Índices para tabela `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de tabela `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de tabela `fourriere_report`
--
ALTER TABLE `fourriere_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT de tabela `open_car`
--
ALTER TABLE `open_car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de tabela `owned_properties`
--
ALTER TABLE `owned_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT de tabela `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT de tabela `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `player_clothe`
--
ALTER TABLE `player_clothe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de tabela `society_moneywash`
--
ALTER TABLE `society_moneywash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de tabela `twitter_likes`
--
ALTER TABLE `twitter_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT de tabela `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT de tabela `user_accessories`
--
ALTER TABLE `user_accessories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT de tabela `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
