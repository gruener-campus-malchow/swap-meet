-- phpMyAdmin SQL Dump
-- version 4.7.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 17. Nov 2021 um 14:07
-- Server-Version: 10.5.12-MariaDB-0+deb11u1
-- PHP-Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `strike_swap-meet`
--
CREATE DATABASE IF NOT EXISTS `strike_swap-meet` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `strike_swap-meet`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blacklist_domain`
--
DROP TABLE IF EXISTS `blacklist_domain`;
CREATE TABLE `blacklist_domain` (
  `domain` varchar(120) NOT NULL PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blacklist_person`
--
DROP TABLE IF EXISTS `blacklist_person`;
CREATE TABLE `blacklist_person` (
  `email` varchar(120) NOT NULL PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `category`
--
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `category_has_item`
--
DROP TABLE IF EXISTS `category_has_item`;
CREATE TABLE `category_has_item` (
  `category_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_contact_mail` varchar(120) NOT NULL, 
PRIMARY KEY(category_id, item_id, item_contact_mail)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `chatroom`
--
DROP TABLE IF EXISTS `chatroom`;
CREATE TABLE `chatroom` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `chat_token` varchar(42) NOT NULL,
  `number_of_messages` int(11) NOT NULL,
  `recipient` varchar(120) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_contact_mail` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `item`
--
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_mail` varchar(120) NOT NULL,
  `pictures_id` int(11) NOT NULL,
  `title` int(11) NOT NULL,
  `edit_token` varchar(42) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `description` text NOT NULL,
PRIMARY KEY(id, contact_mail)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `item_has_pictures`
--
DROP TABLE IF EXISTS `item_has_pictures`;
CREATE TABLE `item_has_pictures` (
  `item_contact_mail` varchar(120) NOT NULL,
  `item_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
PRIMARY KEY(item_contact_mail, item_id, category_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `messages`
--
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `message` text NOT NULL,
  `sender` varchar(120) NOT NULL,
  `recipient` varchar(120) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `chatroom_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `moderators`
--
DROP TABLE IF EXISTS `moderators`;
CREATE TABLE `moderators` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `email` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pictures`
--
DROP TABLE IF EXISTS `pictures`;
CREATE TABLE `pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `blacklist_domain`
--
-- ALTER TABLE `blacklist_domain`
--  ADD PRIMARY KEY (`domain`);

--
-- Indizes für die Tabelle `blacklist_person`
--
-- ALTER TABLE `blacklist_person`
--  ADD PRIMARY KEY (`email`);

--
-- Indizes für die Tabelle `category`
--
-- ALTER TABLE `category`
--  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `category_has_item`
-- 
-- ALTER TABLE `category_has_item`
--  ADD PRIMARY KEY (`category_id`,`item_id`,`item_contact_mail`) USING BTREE,
--  ADD KEY `fk_category_has_item_item_id` (`item_id`);

--
-- Indizes für die Tabelle `chatroom`
--
-- ALTER TABLE `chatroom`
--  ADD PRIMARY KEY (`id`),
--  ADD KEY `item_id` (`item_id`),
--  ADD KEY `item_contact_mail` (`item_contact_mail`);

--
-- Indizes für die Tabelle `item`
--
-- ALTER TABLE `item`
--  ADD PRIMARY KEY (`id`,`contact_mail`),  USING BTREE,
--  ADD KEY `pictures_id` (`pictures_id`);


--
-- Indizes für die Tabelle `item_has_pictures`
--
-- ALTER TABLE `item_has_pictures`
--  ADD PRIMARY KEY (`item_contact_mail`,`item_id`,`category_id`),
--  ADD KEY `fk_item_has_pictures_item_id` (`item_id`);

--
-- Indizes für die Tabelle `messages`
--
-- ALTER TABLE `messages`
--  ADD PRIMARY KEY (`id`),
--  ADD KEY `chatroom_id` (`chatroom_id`);

--
-- Indizes für die Tabelle `moderators`
--
-- ALTER TABLE `moderators`
--  ADD PRIMARY KEY (`user_id`);

--
-- Indizes für die Tabelle `pictures`
--
-- ALTER TABLE `pictures`
--  ADD PRIMARY KEY (`id`);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `category_has_item`
--
ALTER TABLE `category_has_item`
  ADD CONSTRAINT `category_has_item_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_category_has_item_item_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_category_has_item_item_contact_mail` FOREIGN KEY (`item_contact_mail`) REFERENCES `item`(`contact_mail`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `chatroom`
--
ALTER TABLE `chatroom`
  ADD CONSTRAINT `chatroom_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chatroom_ibfk_2` FOREIGN KEY (`item_contact_mail`) REFERENCES `contact_mail` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`pictures_id`) REFERENCES `pictures` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `item_has_pictures`
--
ALTER TABLE `item_has_pictures`
  ADD CONSTRAINT `fk_item_has_pictures_item_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`chatroom_id`) REFERENCES `chatroom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
