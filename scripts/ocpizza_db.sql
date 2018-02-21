-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Feb 09, 2018 alle 12:51
-- Versione del server: 10.1.30-MariaDB
-- Versione PHP: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ocpizza_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `articles`
--

CREATE TABLE `articles` (
  `article_id` int(11) NOT NULL,
  `order_nb` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `articles`
--

INSERT INTO `articles` (`article_id`, `order_nb`, `quantity`) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 1, 4),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `details`
--

CREATE TABLE `details` (
  `article_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `details`
--

INSERT INTO `details` (`article_id`, `ingredient_id`, `quantity`) VALUES
(1, 3, 1),
(1, 4, 2),
(1, 11, 1),
(2, 6, 1),
(2, 9, 2),
(2, 12, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `ingredients`
--

INSERT INTO `ingredients` (`id`, `name`, `created`, `modified`) VALUES
(1, 'sel', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(2, 'jambon', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(3, 'sauce tomate', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(4, 'mozzarella', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(5, 'farine', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(6, 'champignons', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(7, 'artichauts', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(8, 'thon', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(9, 'oignons', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(10, 'chorizo', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(11, 'pâte haute', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(12, 'pâte baisse', '2018-02-08 00:00:00', '2018-02-08 00:00:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `invoice`
--

CREATE TABLE `invoice` (
  `invoice_nb` int(11) NOT NULL,
  `order_nb` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `invoice`
--

INSERT INTO `invoice` (`invoice_nb`, `order_nb`, `status`, `created`, `modified`) VALUES
(1, 1, 0, '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(2, 2, 1, '2018-02-08 00:00:00', '2018-02-08 00:00:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `orders`
--

CREATE TABLE `orders` (
  `number` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `order_status` char(20) NOT NULL,
  `delivery_time` datetime NOT NULL,
  `delivery` tinyint(1) DEFAULT NULL,
  `dutyfree_price` int(11) NOT NULL DEFAULT '0',
  `vat` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `orders`
--

INSERT INTO `orders` (`number`, `user_id`, `store_id`, `customer_id`, `courier_id`, `online`, `status`, `order_status`, `delivery_time`, `delivery`, `dutyfree_price`, `vat`, `created`, `modified`) VALUES
(1, 2, 1, 3, NULL, 1, 0, 'en préparation', '2018-02-08 01:00:00', 0, 0, 10, '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(2, 3, 2, 3, 4, 1, 0, 'livraison', '2018-02-08 00:33:00', 0, 0, 10, '2018-02-08 00:00:00', '2018-02-08 00:00:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `payment`
--

CREATE TABLE `payment` (
  `invoice_nb` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `final_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `payment`
--

INSERT INTO `payment` (`invoice_nb`, `payment_method_id`, `final_price`) VALUES
(1, 2, 0),
(2, 3, 25);

-- --------------------------------------------------------

--
-- Struttura della tabella `payment_method`
--

CREATE TABLE `payment_method` (
  `id` int(11) NOT NULL,
  `modality` varchar(25) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `payment_method`
--

INSERT INTO `payment_method` (`id`, `modality`, `active`) VALUES
(1, 'chèque', 1),
(2, 'espèces', 1),
(3, 'carte bancaire', 1),
(4, 'ticket restaurant', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `pizzas`
--

CREATE TABLE `pizzas` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT '0',
  `description` text,
  `recipes` text,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `pizzas`
--

INSERT INTO `pizzas` (`id`, `name`, `availability`, `description`, `recipes`, `created`, `modified`) VALUES
(1, 'Pizza Thon', 1, 'Grand classique', 'pâte haute\r\nsauce tomate\r\nmozzarella\r\nthon\r\noignons\r\n', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(2, 'Pizza Reine', 1, 'La reine des pizzas!', 'pâte baisse\r\ntomate\r\nmozzarella\r\njambon\r\nartichauts', '2018-02-08 00:00:00', '2018-02-08 00:00:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `staff`
--

CREATE TABLE `staff` (
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `staff`
--

INSERT INTO `staff` (`user_id`, `store_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(4, 1),
(5, 2),
(6, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `user_role`
--

CREATE TABLE `user_role` (
  `role_function` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `user_role`
--

INSERT INTO `user_role` (`role_function`) VALUES
('Caissier'),
('Client'),
('Directeur'),
('Livreur');

-- --------------------------------------------------------

--
-- Struttura della tabella `stocks`
--

CREATE TABLE `stocks` (
  `store_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `dutyfree_sale_price` int(11) NOT NULL,
  `dutyfree_purchase_price` int(11) NOT NULL,
  `vat_purchase` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `stocks`
--

INSERT INTO `stocks` (`store_id`, `ingredient_id`, `quantity`, `dutyfree_sale_price`, `dutyfree_purchase_price`, `vat_purchase`) VALUES
(1, 1, 10, 255000, 125800, 21),
(1, 2, 50, 180000, 100000, 21),
(1, 3, 25, 450000, 240000, 21),
(1, 4, 80, 240000, 120000, 21),
(1, 5, 45, 80000, 50000, 21),
(1, 6, 89, 130000, 90000, 21),
(1, 7, 64, 240000, 130000, 21),
(1, 8, 64, 70000, 40000, 21),
(1, 11, 50, 60000, 35000, 21),
(1, 12, 125, 75000, 38000, 21),
(2, 3, 25, 450000, 240000, 21),
(2, 4, 80, 240000, 120000, 21),
(2, 5, 45, 80000, 50000, 21),
(2, 6, 89, 130000, 90000, 21),
(2, 7, 64, 240000, 130000, 21),
(2, 8, 64, 70000, 40000, 21),
(2, 11, 50, 60000, 35000, 21),
(2, 12, 125, 75000, 38000, 21);

-- --------------------------------------------------------

--
-- Struttura della tabella `stores`
--

CREATE TABLE `stores` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `zip_code` mediumint(8) UNSIGNED NOT NULL,
  `city` varchar(50) NOT NULL,
  `longitude` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `latitude` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `phone_number` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `schedules` text,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `stores`
--

INSERT INTO `stores` (`id`, `name`, `address`, `zip_code`, `city`, `longitude`, `latitude`, `phone_number`, `email`, `schedules`, `created`, `modified`) VALUES
(1, 'OC Pizza Rivoli', '185 rue de Rivoli', 75001, 'Paris', '0.000000', '0.000000', '0166987217', 'pizzarivoli@oc_pizza.fr', NULL, '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(2, 'OC Pizza Montmartre', '15 rue des Abbesses', 75018, 'Paris', '0.000000', '0.000000', '0168798894', 'pizzamontmartre@oc_pizza.fr', NULL, '2018-02-08 00:00:00', '2018-02-08 00:00:00');

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_function` varchar(100) NOT NULL,
  `login` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `zip_code` mediumint(9) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `role_function`, `login`, `password`, `firstname`, `lastname`, `address`, `zip_code`, `city`, `longitude`, `latitude`, `phone_number`, `email`, `created`, `modified`) VALUES
(1, 'Directeur', 'directeur', '60d5f0s5df05df05df0s56f40s6d5f4s06df54df0', 'Hugo', 'Boss', '185 rue de Rivoli', 75001, 'Paris', '48.866302', '2.325451', NULL, 'hugoboss@oc_pizza.fr', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(2, 'Caissier', 'caissier', '60d5f0s5df05df05df0s56f40s6d5f4s06df54df0', 'Jordan', 'Dubois', NULL, NULL, NULL, NULL, NULL, NULL, 'jordandubois@oc_pizza.fr', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(3, 'Client', 'client', '60d5f0s5df05df05df0s56f40s6d5f4s06df54df0', 'Louisa', 'Richard', '1 boulevard Malesherbes', 75008, 'Paris', '48.869924', '2.323096', NULL, 'louisarichard@gmail.fr', '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(4, 'Livreur', 'livreur', '60sdf4s605df46sq5d0f460qf406fds5406qsf', 'Nicolas', 'Piroja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(5, 'Caissier', 'caissier 2', '68s2q46f84c2ef42q6sdfqf5ds5f46qsqdfxf4q65', 'Gérard', 'Moreau', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-02-08 00:00:00', '2018-02-08 00:00:00'),
(6, 'Livreur', 'livreur 2', 'sdf35426qsf4264df6qs4df624qs62fd42cqf46c', 'Pascal', 'Durand', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-02-08 00:00:00', '2018-02-08 00:00:00');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`article_id`,`order_nb`),
  ADD KEY `orders_articles_fk` (`order_nb`);

--
-- Indici per le tabelle `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`article_id`,`ingredient_id`),
  ADD KEY `ingredients_details_fk` (`ingredient_id`);

--
-- Indici per le tabelle `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingredients_idx1` (`name`);

--
-- Indici per le tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_nb`),
  ADD KEY `invoice_idx` (`invoice_nb`),
  ADD KEY `orders_invoice_fk` (`order_nb`);

--
-- Indici per le tabelle `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`number`),
  ADD KEY `orders_idx` (`number`),
  ADD KEY `stores_orders_fk` (`store_id`),
  ADD KEY `users_orders_fk2` (`customer_id`),
  ADD KEY `users_orders_fk1` (`user_id`),
  ADD KEY `users_orders_fk` (`courier_id`);

--
-- Indici per le tabelle `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`invoice_nb`,`payment_method_id`),
  ADD KEY `payment_method_payment_fk` (`payment_method_id`);

--
-- Indici per le tabelle `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_method_idx` (`id`);

--
-- Indici per le tabelle `pizzas`
--
ALTER TABLE `pizzas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pizzas_idx` (`id`),
  ADD KEY `pizzas_idx1` (`name`);

--
-- Indici per le tabelle `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`user_id`,`store_id`),
  ADD KEY `stores_staff_fk` (`store_id`);

--
-- Indici per le tabelle `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`role_function`);

--
-- Indici per le tabelle `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`store_id`,`ingredient_id`),
  ADD KEY `ingredients_stocks_fk` (`ingredient_id`);

--
-- Indici per le tabelle `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stores_idx` (`name`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `users_idx` (`login`,`password`,`email`),
  ADD KEY `user_role_users_fk` (`role_function`),
  ADD KEY `id_2` (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoice_nb` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `orders`
--
ALTER TABLE `orders`
  MODIFY `number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `pizzas`
--
ALTER TABLE `pizzas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `orders_articles_fk` FOREIGN KEY (`order_nb`) REFERENCES `orders` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pizzas_articles_fk` FOREIGN KEY (`article_id`) REFERENCES `pizzas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `details`
--
ALTER TABLE `details`
  ADD CONSTRAINT `ingredients_details_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pizzas_details_fk` FOREIGN KEY (`article_id`) REFERENCES `pizzas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `orders_invoice_fk` FOREIGN KEY (`order_nb`) REFERENCES `orders` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `stores_orders_fk` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_orders_fk` FOREIGN KEY (`courier_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_orders_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_orders_fk2` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `invoice_payment_fk` FOREIGN KEY (`invoice_nb`) REFERENCES `invoice` (`invoice_nb`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `payment_method_payment_fk` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `stores_staff_fk` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_staff_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `ingredients_stocks_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `stores_stocks_fk` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `user_role_users_fk` FOREIGN KEY (`role_function`) REFERENCES `user_role` (`role_function`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
