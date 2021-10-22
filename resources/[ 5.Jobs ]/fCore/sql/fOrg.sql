INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_cartel','Cartel',1);

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_cartel','Cartel',1);

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_cartel', 'Cartel', 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('cartel', 'Cartel');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('cartel', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('cartel', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('cartel', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('cartel', 3, 'boss', 'Chef', 1000, 'null', 'null');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES 
('metaux', 'Métaux', '1', '0', '1'), 
('poudre', 'Poudre à canon', '1', '0', '1'),
('meche', 'Mèche', '1', '0', '1'),
('ruban', 'Ruban adhésif', '1', '0', '1');