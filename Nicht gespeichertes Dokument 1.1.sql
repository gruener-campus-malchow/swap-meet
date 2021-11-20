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
-- Tabellenstruktur für Tabelle `pictures`
--

CREATE TABLE `pictures` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Tabellenstruktur für Tabelle `blacklist_domain`
--

CREATE TABLE `blacklist_domain` (
  `domain` varchar(120) NOT NULL PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blacklist_person`
--

CREATE TABLE `blacklist_person` (
  `email` varchar(120) NOT NULL PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `category`
--

CREATE TABLE `category` (
  `id` int(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `item` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contact_mail` varchar(120) NOT NULL,
  `pictures_id` int(11) UNSIGNED NOT NULL,
  `title` text(11) NOT NULL,
  `edit_token` varchar(42) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `description` text NOT NULL,
PRIMARY KEY(id, contact_mail),
FOREIGN KEY (pictures_id) REFERENCES pictures(id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `category_has_item` (
  `category_id` int(11) UNSIGNED NOT NULL,
  `item_id` int(11) UNSIGNED NOT NULL,
  `item_contact_mail` varchar(120) NOT NULL, 
PRIMARY KEY(category_id, item_id, item_contact_mail),
  FOREIGN KEY (category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES item(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (item_contact_mail) REFERENCES item(contact_mail) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `item_has_pictures` (
  `item_contact_mail` varchar(120) NOT NULL,
  `item_id` int(11) UNSIGNED NOT NULL,
  `pictures_id` int(11) UNSIGNED NOT NULL,
PRIMARY KEY(item_contact_mail, item_id, category_id),
  FOREIGN KEY (item_id) REFERENCES item(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (item_contact_mail) REFERENCES item(contact_mail) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (pictures_id) REFERENCES pictures(id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `messages`
--

CREATE TABLE `messages` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `message` text NOT NULL,
  `sender` varchar(120) NOT NULL,
  `recipient` varchar(120) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `chatroom_id` int(11) NOT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `moderators`
--

CREATE TABLE `moderators` (
  `user_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  `email` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tabellenstruktur für Tabelle `chatroom`
--

CREATE TABLE `chatroom` (
  `id` int(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `chat_token` varchar(42) NOT NULL,
  `number_of_messages` int(11) UNSIGNED NOT NULL,
  `recipient` varchar(120) NOT NULL,
  `item_id` int(11) UNSIGNED NOT NULL,
  `item_contact_mail` varchar(120) NOT NULL,
    FOREIGN KEY (item_id) REFERENCES item(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (item_contact_mail) REFERENCES item(contact_mail) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------
COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
