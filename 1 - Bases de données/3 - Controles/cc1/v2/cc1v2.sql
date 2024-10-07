-- Création de la base de données
drop database if exists cc1v2;
CREATE DATABASE  cc1v2 collate utf8mb4_general_ci;
USE cc1v2;

-- Table des étudiants
CREATE TABLE etudiants (
    id_etudiant INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100)
);

-- Table des livres
CREATE TABLE livres (
    id_livre INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255),
    consultation BOOLEAN DEFAULT 0 -- 1: consultation sur place, 0: emprunt possible
);

-- Table des exemplaires de livres
CREATE TABLE exemplaires (
    id_exemplaire INT AUTO_INCREMENT PRIMARY KEY,
    id_livre INT,
    disponible BOOLEAN DEFAULT 1, -- 1: disponible, 0: emprunté
    FOREIGN KEY (id_livre) REFERENCES livres(id_livre)
);

-- Table des emprunts
CREATE TABLE emprunts (
    id_emprunt INT AUTO_INCREMENT PRIMARY KEY,
    id_etudiant INT,
    id_exemplaire INT,
    date_emprunt DATE,
    date_retour_prevu DATE,
    date_retour_effectif DATE NULL, -- Null si le livre n'est pas encore rendu
    FOREIGN KEY (id_etudiant) REFERENCES etudiants(id_etudiant),
    FOREIGN KEY (id_exemplaire) REFERENCES exemplaires(id_exemplaire)
);

-- Table des amendes
CREATE TABLE amendes (
    id_amende INT AUTO_INCREMENT PRIMARY KEY,
    id_emprunt INT,
    date_amende DATE,
    montant DECIMAL(5, 2),
    FOREIGN KEY (id_emprunt) REFERENCES emprunts(id_emprunt)
);

-- Table des réservations
CREATE TABLE reservations (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    id_etudiant INT,
    id_livre INT,
    date_reservation DATE,
    FOREIGN KEY (id_etudiant) REFERENCES etudiants(id_etudiant),
    FOREIGN KEY (id_livre) REFERENCES livres(id_livre)
);

INSERT INTO etudiants (nom, prenom) VALUES 
('lahlou', 'karim'),
('sabai', 'khalid'),
('mansouri', 'mouna'),
('youssfi', 'farah'),
('baladi', 'ahmed'),
('monaim', 'amal'),
('kamali', 'omar'),
('morchid', 'Ali'),
('bergui', 'monsif'),
('Simon', 'sanaa');


INSERT INTO livres (titre, consultation) VALUES 
('Programmation en Python', 0),
('Algorithmes Avancés', 0),
('Bases de Données', 0),
('Théorie des Graphes', 0),
('Statistiques et Probabilités', 0),
('Analyse Mathématique', 1), -- consultation sur place
('Physique Quantique', 0),
('Intelligence Artificielle', 0),
('Littérature Française', 1), -- consultation sur place
('Histoire Moderne', 0);

INSERT INTO exemplaires (id_livre, disponible) VALUES 
(1, 1), -- 'Introduction à la Programmation'
(1, 0), -- emprunté
(2, 1), -- 'Algorithmes Avancés'
(3, 1), -- 'Bases de Données'
(4, 0), -- emprunté
(5, 1), -- 'Statistiques et Probabilités'
(6, 1), -- 'Analyse Mathématique'
(7, 1), -- 'Physique Quantique'
(8, 0), -- emprunté
(9, 1); -- 'Littérature Française'


INSERT INTO emprunts (id_etudiant, id_exemplaire, date_emprunt, date_retour_prevu, date_retour_effectif) VALUES 
(1, 2, '2024-09-01', '2024-09-15', NULL), -- pas encore rendu
(2, 4, '2024-09-02', '2024-09-16', '2024-09-10'), -- déjà rendu
(3, 5, '2024-09-03', '2024-09-17', NULL),
(4, 8, '2024-09-04', '2024-09-18', NULL),
(5, 10, '2024-09-05', '2024-09-19', '2024-09-12'),
(6, 1, '2024-09-06', '2024-09-20', NULL),
(7, 7, '2024-09-07', '2024-09-21', NULL),
(8, 6, '2024-09-08', '2024-09-22', NULL),
(9, 9, '2024-09-09', '2024-09-23', NULL),
(10, 3, '2024-09-10', '2024-09-24', NULL);


INSERT INTO amendes (id_emprunt, date_amende, montant) VALUES 
(1, '2024-09-16', 5.00), -- retard
(3, '2024-09-18', 2.50), -- retard
(4, '2024-09-19', 3.00), -- retard
(6, '2024-09-21', 4.00), -- retard
(7, '2024-09-22', 1.50), -- retard
(8, '2024-09-23', 2.00), -- retard
(9, '2024-09-24', 3.50), -- retard
(10, '2024-09-25', 2.75), -- retard
(5, '2024-09-26', 1.25), -- retard
(2, '2024-09-27', 4.50); -- retard


INSERT INTO reservations (id_etudiant, id_livre, date_reservation) VALUES 
(1, 2, '2024-09-01'),
(2, 3, '2024-09-02'),
(3, 4, '2024-09-03'),
(4, 5, '2024-09-04'),
(5, 6, '2024-09-05'),
(6, 7, '2024-09-06'),
(7, 8, '2024-09-07'),
(8, 9, '2024-09-08'),
(9, 10, '2024-09-09'),
(10, 1, '2024-09-10');





