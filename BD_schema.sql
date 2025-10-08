-- Active: 1759898357630@@127.0.0.1@3306@eoy_project
CREATE DATABASE EOY_PROJECT;
USE EOY_PROJECT;

-- client
CREATE TABLE Client (
	id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    telephone VARCHAR(15) UNIQUE
);

-- commande
CREATE TABLE Commande (
	id_commande INT PRIMARY KEY AUTO_INCREMENT,
    date_commande DATETIME DEFAULT CURRENT_TIMESTAMP,-- similar to NOW()
    total DECIMAL (10, 2) DEFAULT 0,
    id_client INT NOT NULL,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- plat
CREATE TABLE Plat(
	id_plat INT PRIMARY KEY AUTO_INCREMENT,
    nom_plat VARCHAR(50) NOT NULL,
    prix DECIMAL(8,2) NOT NULL,
    categorie VARCHAR(50)
);

-- Detailscommande
CREATE TABLE DetailsCommande(
	id_commande INT NOT NULL,
    id_plat INT NOT NULL,
    PRIMARY KEY (id_commande, id_plat),
    FOREIGN KEY (id_plat) REFERENCES plat(id_plat) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_commande) REFERENCES commande(id_commande) ON DELETE CASCADE ON UPDATE CASCADE
);

-- facture
CREATE TABLE Facture(
	id_facture INT PRIMARY KEY AUTO_INCREMENT,
    id_commande INT NOT NULL,
    id_client INT NOT NULL ,
	date_facture DATETIME DEFAULT CURRENT_TIMESTAMP,
    net_a_payer DOUBLE NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES commande(id_commande) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_client) REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Stock
CREATE TABLE Stock(
    id_produit INT PRIMARY KEY AUTO_INCREMENT,
    nom_produit VARCHAR(50) NOT NULL,
    quantite DOUBLE
);

-- DetailsStock
CREATE TABLE DetailsStock(
    id_produit INT NOT NULL,
    id_plat INT NOT NULL,
    quantite_prise DOUBLE NOT NULL,
    PRIMARY key (id_produit, id_plat),
    FOREIGN KEY (id_produit) REFERENCES Stock(id_produit) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_plat) REFERENCES plat(id_plat) ON DELETE CASCADE ON UPDATE CASCADE
);
