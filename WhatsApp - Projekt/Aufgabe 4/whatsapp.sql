-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 09. Okt 2019 um 15:45
-- Server-Version: 10.1.37-MariaDB
-- PHP-Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `whatsapp`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Account`
--

CREATE TABLE `Account` (
  `account_id` bigint(20) NOT NULL,
  `telefonnummer` varchar(20) COLLATE latin1_german2_ci NOT NULL,
  `nutzername` varchar(20) COLLATE latin1_german2_ci NOT NULL,
  `profilbild` blob,
  `beschreibung` varchar(40) COLLATE latin1_german2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

--
-- Daten für Tabelle `Account`
--

INSERT INTO `Account` (`account_id`, `telefonnummer`, `nutzername`, `profilbild`, `beschreibung`) VALUES
(1, '04562/2346782', 'mattomueller', NULL, '...'),
(2, '0327/247345', 'keinplan', NULL, '...');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `AccountInChat`
--

CREATE TABLE `AccountInChat` (
  `account_id` bigint(20) NOT NULL,
  `chat_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Chat`
--

CREATE TABLE `Chat` (
  `teilnehmer` bigint(20) NOT NULL,
  `chat_id` bigint(20) NOT NULL,
  `verlauf_id` bigint(20) NOT NULL,
  `pinned` tinyint(1) NOT NULL,
  `muted` tinyint(1) NOT NULL,
  `muteDuration` int(11) NOT NULL,
  `gruppenchat` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Datei`
--

CREATE TABLE `Datei` (
  `datei_id` bigint(20) NOT NULL,
  `datei` blob NOT NULL,
  `groeßeByte` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Gruppe`
--

CREATE TABLE `Gruppe` (
  `gruppenname` varchar(20) COLLATE latin1_german2_ci NOT NULL,
  `beschreibung` varchar(50) COLLATE latin1_german2_ci DEFAULT NULL,
  `gruppenbild` blob,
  `admin` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Nachricht`
--

CREATE TABLE `Nachricht` (
  `nachricht_id` bigint(20) NOT NULL,
  `inhalt` varchar(3000) COLLATE latin1_german2_ci NOT NULL,
  `verfasser` bigint(20) NOT NULL,
  `groeßeByte` bigint(20) NOT NULL,
  `datei_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

--
-- Daten für Tabelle `Nachricht`
--

INSERT INTO `Nachricht` (`nachricht_id`, `inhalt`, `verfasser`, `groeßeByte`, `datei_id`) VALUES
(1, 'Moin, was geht?', 1, 12, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Status`
--

CREATE TABLE `Status` (
  `status_id` bigint(20) NOT NULL,
  `datei` blob NOT NULL,
  `datum` datetime NOT NULL,
  `gesehenVon` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `StatusVonAccount`
--

CREATE TABLE `StatusVonAccount` (
  `account_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Telefonat`
--

CREATE TABLE `Telefonat` (
  `telefonat_id` bigint(20) NOT NULL,
  `dauer` time NOT NULL,
  `datum` datetime NOT NULL,
  `videoanruf` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `TelefonatVonAccount`
--

CREATE TABLE `TelefonatVonAccount` (
  `telefonat_id` bigint(20) NOT NULL,
  `empfänger_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Verlauf`
--

CREATE TABLE `Verlauf` (
  `verlauf_id` bigint(20) NOT NULL,
  `nachrichten` bigint(20) NOT NULL,
  `groeßeByte` bigint(20) NOT NULL,
  `anzNachrichten` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german2_ci;

--
-- Daten für Tabelle `Verlauf`
--

INSERT INTO `Verlauf` (`verlauf_id`, `nachrichten`, `groeßeByte`, `anzNachrichten`) VALUES
(1, 1, 12, 1);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `Account`
--
ALTER TABLE `Account`
  ADD PRIMARY KEY (`account_id`);

--
-- Indizes für die Tabelle `AccountInChat`
--
ALTER TABLE `AccountInChat`
  ADD PRIMARY KEY (`account_id`,`chat_id`);

--
-- Indizes für die Tabelle `Chat`
--
ALTER TABLE `Chat`
  ADD PRIMARY KEY (`chat_id`);

--
-- Indizes für die Tabelle `Datei`
--
ALTER TABLE `Datei`
  ADD PRIMARY KEY (`datei_id`);

--
-- Indizes für die Tabelle `Nachricht`
--
ALTER TABLE `Nachricht`
  ADD PRIMARY KEY (`nachricht_id`),
  ADD KEY `fk_datei_id` (`datei_id`);

--
-- Indizes für die Tabelle `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indizes für die Tabelle `StatusVonAccount`
--
ALTER TABLE `StatusVonAccount`
  ADD KEY `account_id` (`account_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indizes für die Tabelle `Telefonat`
--
ALTER TABLE `Telefonat`
  ADD PRIMARY KEY (`telefonat_id`);

--
-- Indizes für die Tabelle `TelefonatVonAccount`
--
ALTER TABLE `TelefonatVonAccount`
  ADD KEY `telefonat_id` (`telefonat_id`),
  ADD KEY `empfänger_id` (`empfänger_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indizes für die Tabelle `Verlauf`
--
ALTER TABLE `Verlauf`
  ADD PRIMARY KEY (`verlauf_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `Account`
--
ALTER TABLE `Account`
  MODIFY `account_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `Chat`
--
ALTER TABLE `Chat`
  MODIFY `chat_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Datei`
--
ALTER TABLE `Datei`
  MODIFY `datei_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Nachricht`
--
ALTER TABLE `Nachricht`
  MODIFY `nachricht_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `Status`
--
ALTER TABLE `Status`
  MODIFY `status_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Telefonat`
--
ALTER TABLE `Telefonat`
  MODIFY `telefonat_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Verlauf`
--
ALTER TABLE `Verlauf`
  MODIFY `verlauf_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `Nachricht`
--
ALTER TABLE `Nachricht`
  ADD CONSTRAINT `fk_datei_id` FOREIGN KEY (`datei_id`) REFERENCES `Datei` (`datei_id`);

--
-- Constraints der Tabelle `StatusVonAccount`
--
ALTER TABLE `StatusVonAccount`
  ADD CONSTRAINT `StatusVonAccount_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `Account` (`account_id`),
  ADD CONSTRAINT `StatusVonAccount_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `Status` (`status_id`);

--
-- Constraints der Tabelle `TelefonatVonAccount`
--
ALTER TABLE `TelefonatVonAccount`
  ADD CONSTRAINT `TelefonatVonAccount_ibfk_1` FOREIGN KEY (`telefonat_id`) REFERENCES `Telefonat` (`telefonat_id`),
  ADD CONSTRAINT `TelefonatVonAccount_ibfk_2` FOREIGN KEY (`empfänger_id`) REFERENCES `Account` (`account_id`),
  ADD CONSTRAINT `TelefonatVonAccount_ibfk_3` FOREIGN KEY (`sender_id`) REFERENCES `Account` (`account_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
