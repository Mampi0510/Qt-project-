-- Active: 1759898357630@@127.0.0.1@3306@eoy_project
CREATE DATABASE EOY_PROJECT;
USE EOY_PROJECT;

-- client
CREATE TABLE client (
	id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    telephone VARCHAR(15) UNIQUE
);

-- commande
CREATE TABLE commande (
	id_commande INT PRIMARY KEY AUTO_INCREMENT,
    date_commande DATETIME DEFAULT CURRENT_TIMESTAMP,-- similar to NOW()
    total DECIMAL (10, 2) DEFAULT 0,
    id_client INT NOT NULL,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- plat
CREATE TABLE plat(
	id_plat INT PRIMARY KEY AUTO_INCREMENT,
    nom_plat VARCHAR(50) NOT NULL,
    prix DECIMAL(8,2) NOT NULL,
    categorie VARCHAR(50)
);

-- Detailscommande
CREATE TABLE detailscommande(
	id_commande INT NOT NULL,
    id_plat INT NOT NULL,
    PRIMARY KEY (id_commande, id_plat),
    FOREIGN KEY (id_plat) REFERENCES plat(id_plat) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_commande) REFERENCES commande(id_commande) ON DELETE CASCADE ON UPDATE CASCADE
);

-- facture
CREATE TABLE facture(
	id_facture INT PRIMARY KEY AUTO_INCREMENT,
    id_commande INT NOT NULL,
    id_client INT NOT NULL ,
	date_facture DATETIME DEFAULT CURRENT_TIMESTAMP,
    net_a_payer DOUBLE NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES commande(id_commande) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE
);
