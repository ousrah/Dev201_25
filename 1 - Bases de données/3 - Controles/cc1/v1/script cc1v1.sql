-- Création de la base de données
drop database if exists cc1v1;
CREATE DATABASE cc1v1 collate utf8mb4_general_ci;
USE cc1v1;

-- Table des patients
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE,
    email VARCHAR(100),
    telephone VARCHAR(20)
);

-- Table des spécialités des dentistes
CREATE TABLE specialites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_specialite VARCHAR(100) NOT NULL
);

-- Table des dentistes
CREATE TABLE dentistes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    specialite_id INT,
    FOREIGN KEY (specialite_id) REFERENCES specialites(id)
);

-- Table des raisons de rendez-vous
CREATE TABLE raisons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

-- Table des états de rendez-vous
CREATE TABLE etats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_etat VARCHAR(50) NOT NULL
);

-- Table des rendez-vous
CREATE TABLE rendezvous (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    dentiste_id INT,
    raison_id INT,
    etat_id INT,
    date_rendezvous DATE NOT NULL,
    heure_rendezvous TIME NOT NULL,
    duree INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (dentiste_id) REFERENCES dentistes(id),
    FOREIGN KEY (raison_id) REFERENCES raisons(id),
    FOREIGN KEY (etat_id) REFERENCES etats(id)
);

-- Insertion de quelques données d'exemple

-- Insertion des patients
INSERT INTO patients (nom, prenom, date_naissance, email, telephone) VALUES
('Benhsain', 'Zakaria', '1990-05-12', 'zakaria.benhsain@example.com', '0612345678'),
('Elouahabi', 'Fatima', '1985-07-20', 'fatima.elouahabi@example.com', '0611223344'),
('Ouaziz', 'Mohamed', '1978-01-25', 'mohamed.ouaziz@example.com', '0600112233'),
('Nour', 'Ali', '1992-06-17', 'ali.nour@example.com', '0612334455'),
('Lahlou', 'Sara', '1988-03-03', 'sara.lahlou@example.com', '0622334455'),
('Karim', 'Hassan', '1995-10-22', 'hassan.karim@example.com', '0600123456'),
('Rahmani', 'Omar', '1981-08-19', 'omar.rahmani@example.com', '0610001112'),
('Bouzid', 'Meryem', '1997-12-05', 'meryem.bouzid@example.com', '0611234567'),
('Toumi', 'Khadija', '1993-02-14', 'khadija.toumi@example.com', '0621122334'),
('Belkacem', 'Rachid', '1982-04-28', 'rachid.belkacem@example.com', '0612345678');

-- Insertion des spécialités
INSERT INTO specialites (nom_specialite) VALUES
('Soins généraux'),
('Orthodontie'),
('Chirurgie dentaire');

-- Insertion des dentistes
INSERT INTO dentistes (nom, prenom, specialite_id) VALUES
('Makhlouf', 'Hicham', 1),
('El Amrani', 'Samira', 2),
('Mounir', 'Khalid', 3);

-- Insertion des raisons de rendez-vous
INSERT INTO raisons (description) VALUES
('Contrôle général'),
('Orthodontie'),
('Extraction dentaire');

-- Insertion des états de rendez-vous
INSERT INTO etats (nom_etat) VALUES
('actif'),
('annule'),
('reporté');

-- Insertion des rendez-vous
INSERT INTO rendezvous (patient_id, dentiste_id, raison_id, etat_id, date_rendezvous, heure_rendezvous, duree) VALUES
(1, 1, 1, 1, '2024-10-07', '09:00:00', 30),
(1, 2, 2, 1, '2024-10-08', '11:00:00', 45),
(2, 1, 1, 2, '2024-07-09', '10:00:00', 30),
(3, 2, 2, 1, '2024-10-07', '14:00:00', 40),
(4, 3, 3, 1, '2024-10-06', '15:30:00', 50),
(5, 1, 1, 1, '2024-10-06', '12:00:00', 30),
(6, 3, 3, 3, '2024-10-08', '16:00:00', 60),
(7, 2, 2, 2, '2024-10-09', '09:30:00', 45),
(8, 1, 1, 1, '2024-10-10', '11:30:00', 30),
(9, 2, 2, 1, '2024-10-07', '16:45:00', 45),
(10, 3, 3, 1, '2024-10-09', '17:00:00', 50),
(2, 1, 1, 3, '2024-10-11', '08:00:00', 30),
(3, 3, 3, 1, '2024-10-11', '09:00:00', 60),
(4, 2, 2, 1, '2024-10-11', '10:15:00', 45),
(5, 1, 1, 2, '2024-10-12', '13:00:00', 30),
(6, 3, 3, 1, '2024-10-12', '14:30:00', 60),
(7, 2, 2, 1, '2024-10-12', '15:45:00', 45),
(8, 1, 1, 1, '2024-10-13', '16:00:00', 30),
(9, 3, 3, 3, '2024-10-13', '17:00:00', 50),
(10, 2, 2, 1, '2024-10-14', '08:30:00', 45),
(8, 1, 1, 1, '2024-10-13', '16:00:00', 30),
(9, 1, 3, 3, '2024-10-13', '17:00:00', 50),
(10, 1, 2, 1, '2024-10-13', '08:30:00', 45);

;
