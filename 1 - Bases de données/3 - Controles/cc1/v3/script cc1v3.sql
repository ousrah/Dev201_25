-- Création de la base de données
DROP DATABASE IF EXISTS cc1v3;
CREATE DATABASE IF NOT EXISTS cc1v3 collate utf8mb4_general_ci;
USE cc1v3;

-- Table Client
CREATE TABLE Client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    adresse VARCHAR(255),
    email VARCHAR(100),
    telephone VARCHAR(20)
);

-- Table Colis
CREATE TABLE Colis (
    id_colis INT AUTO_INCREMENT PRIMARY KEY,
    num_suivi VARCHAR(100) UNIQUE NOT NULL,
    id_client_expediteur INT,  -- Client qui envoie le colis
    id_client_destinataire INT, -- Client qui reçoit le colis
    adresse_destinataire VARCHAR(255) NOT NULL, -- peut être différente de l'adresse de résidence du destinataire
    date_envoi DATE NOT NULL,
    signature_requise BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_client_expediteur) REFERENCES Client(id_client) ON DELETE CASCADE,
    FOREIGN KEY (id_client_destinataire) REFERENCES Client(id_client) ON DELETE CASCADE
);

-- Table Livreur
CREATE TABLE Livreur (
    id_livreur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    telephone VARCHAR(20)
);

-- Table Etape
CREATE TABLE Etape (
    id_etape INT AUTO_INCREMENT PRIMARY KEY,
    nom_etape VARCHAR(50) NOT NULL
);

-- Table Processus de Livraison
CREATE TABLE Processus_Livraison (
    id_processus INT AUTO_INCREMENT PRIMARY KEY,
    id_colis INT,
    id_livreur INT,
    id_etape INT,
    date_etape DATETIME NOT NULL,
    commentaire TEXT,
    FOREIGN KEY (id_colis) REFERENCES Colis(id_colis) ON DELETE CASCADE,
    FOREIGN KEY (id_livreur) REFERENCES Livreur(id_livreur) ON DELETE CASCADE,
    FOREIGN KEY (id_etape) REFERENCES Etape(id_etape) ON DELETE CASCADE
);

-- Table Tentative de Livraison
CREATE TABLE Tentative_Livraison (
    id_tentative INT AUTO_INCREMENT PRIMARY KEY,
    id_colis INT,
    id_livreur INT,
    date_tentative DATETIME NOT NULL,
    succes BOOLEAN NOT NULL,
    raison VARCHAR(255),
    FOREIGN KEY (id_colis) REFERENCES Colis(id_colis) ON DELETE CASCADE,
    FOREIGN KEY (id_livreur) REFERENCES Livreur(id_livreur) ON DELETE CASCADE
);



-- Insertion de données dans la table Client
INSERT INTO Client (nom, prenom, adresse, email, telephone)
VALUES 
('El Majd', 'Ahmed', '12 Rue Ouarzazate, Casablanca', 'ahmed.majd@gmail.com', '0661234567'),
('Zaki', 'Mohamed', '34 Avenue Hassan II, Rabat', 'mohamed.zaki@yahoo.com', '0678901234'),
('Bennis', 'Khadija', '45 Rue Meknès, Fès', 'khadija.bennis@outlook.com', '0654567890'),
('Alaoui', 'Samira', '78 Rue Marrakech, Marrakech', 'samira.alaoui@gmail.com', '0627891234'),
('Bouzid', 'Yassine', '23 Rue Souss, Agadir', 'yassine.bouzid@gmail.com', '0691234567'),
('Tazi', 'Fatima', '9 Rue Atlas, Tanger', 'fatima.tazi@tanger.com', '0689876543'),
('Karim', 'Oussama', '22 Rue Dakhla, Oujda', 'oussama.karim@oujda.net', '0645678901'),
('El Mansour', 'Imane', '101 Rue Safi, Safi', 'imane.mansour@safi.org', '0652347890'),
('Ouazzani', 'Amine', '56 Rue Essaouira, Essaouira', 'amine.ouazzani@essaouira.org', '0676543210'),
('Benjelloun', 'Mouad', '67 Rue Kenitra, Kenitra', 'mouad.benjelloun@kenitra.com', '0669871234');

-- Insertion de données dans la table Livreur
INSERT INTO Livreur (nom, prenom, telephone)
VALUES 
('El Hadi', 'Ali', '0663456789'),
('Najib', 'Youssef', '0676547890'),
('Benkirane', 'Sara', '0687654321'),
('Hamdoun', 'Leila', '0698765432'),
('Fadil', 'Hassan', '0654321890');

-- Insertion de données dans la table Colis
INSERT INTO Colis (num_suivi, id_client_expediteur, id_client_destinataire, adresse_destinataire, date_envoi, signature_requise)
VALUES 
('MA20241001', 1, 2, '34 Avenue Hassan II, Rabat', '2024-09-01', TRUE),
('MA20241002', 2, 3, '45 Rue Meknès, Fès', '2024-09-02', FALSE),
('MA20241003', 3, 4, '78 Rue Marrakech, Marrakech', '2024-09-03', TRUE),
('MA20241004', 4, 5, '23 Rue Souss, Agadir', '2024-09-04', TRUE),
('MA20241005', 5, 6, '9 Rue Atlas, Tanger', '2024-09-05', FALSE),
('MA20241006', 6, 7, '22 Rue Dakhla, Oujda', '2024-09-06', TRUE),
('MA20241007', 7, 8, '101 Rue Safi, Safi', '2024-09-07', FALSE),
('MA20241008', 8, 9, '56 Rue Essaouira, Essaouira', '2024-09-08', TRUE),
('MA20241009', 9, 10, '67 Rue Kenitra, Kenitra', '2024-09-09', TRUE),
('MA20241010', 10, 1, '12 Rue Ouarzazate, Casablanca', '2024-09-10', FALSE);

-- Insertion de données dans la table Etape
INSERT INTO Etape (nom_etape)
VALUES 
('Prise en charge'),
('En transit'),
('Tri au centre de distribution'),
('En attente de livraison'),
('Livré');

-- Insertion de données dans la table Processus_Livraison
INSERT INTO Processus_Livraison (id_colis, id_livreur, id_etape, date_etape, commentaire)
VALUES 
(1, 1, 1, '2024-09-01 08:00:00', 'Colis pris en charge'),
(1, 2, 2, '2024-09-02 10:00:00', 'Colis en transit'),
(1, 2, 3, '2024-09-02 14:00:00', 'Tri effectué'),
(1, 1, 4, '2024-09-03 16:00:00', 'En attente de livraison'),
(1, 1, 5, '2024-09-03 18:00:00', 'Colis livré avec signature'),
(2, 3, 1, '2024-09-02 09:00:00', 'Colis pris en charge'),
(2, 3, 2, '2024-09-02 12:00:00', 'Colis en transit'),
(2, 3, 3, '2024-09-02 16:00:00', 'Tri effectué'),
(2, 4, 4, '2024-09-03 09:00:00', 'En attente de livraison'),
(2, 4, 5, '2024-09-03 17:00:00', 'Colis livré sans signature');

-- Insertion de données dans la table Tentative_Livraison
INSERT INTO Tentative_Livraison (id_colis, id_livreur, date_tentative, succes, raison)
VALUES 
(3, 1, '2024-09-04 10:00:00', FALSE, 'Adresse incorrecte'),
(3, 1, '2024-09-04 16:00:00', TRUE, NULL),
(4, 2, '2024-09-05 14:00:00', FALSE, 'Destinataire absent'),
(4, 2, '2024-09-06 09:00:00', TRUE, NULL),
(5, 3, '2024-09-05 11:00:00', TRUE, NULL),
(6, 4, '2024-09-06 13:00:00', TRUE, NULL),
(7, 5, '2024-09-07 09:30:00', TRUE, NULL),
(8, 1, '2024-09-08 15:00:00', FALSE, 'Absence du destinataire'),
(8, 1, '2024-09-09 10:00:00', TRUE, NULL),
(9, 2, '2024-09-09 14:30:00', TRUE, NULL);

