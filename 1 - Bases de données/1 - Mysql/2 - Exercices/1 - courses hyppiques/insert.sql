INSERT INTO PROPRIETAIRE (NOM_PROPRIETAIRE, PRENOM_PROPRIETAIRE)
VALUES ('Dupont', 'Jean'),
       ('Martin', 'Pierre'),
       ('Durand', 'Marie'),
       ('Leclerc', 'Sophie'),
       ('Bernard', 'Jacques');
       
       
       
INSERT INTO CHEVAL (ID_PROPRIETAIRE, NOM_CHEVAL, DATE_NAISSANCE, SEXE_CHEVAL)
VALUES (1, 'Black', '2017-03-01', 'M'),
       (2, 'White', '2018-04-12', 'F'),
       (3, 'Thunder', '2016-05-23', 'M'),
       (4, 'Storm', '2019-06-15', 'F'),
       (5, 'Blaze', '2017-08-10', 'M'),
       (1, 'Lightning', '2018-02-19', 'F'),
       (3, 'Shadow', '2019-09-05', 'M'),
       (4, 'Ghost', '2016-11-29', 'F'),
       (2, 'Flame', '2017-07-07', 'M'),
       (5, 'Spirit', '2018-12-13', 'F');
-- Parents de Black
INSERT INTO PARENT (ID_PARENT, ID_CHEVAL)
VALUES (3, 1), (2, 1);

-- Parents de White
INSERT INTO PARENT (ID_PARENT, ID_CHEVAL)
VALUES (3, 2), (4, 2);

-- Parents de Thunder
INSERT INTO PARENT (ID_PARENT, ID_CHEVAL)
VALUES (5, 3), (6, 3);

-- Parents de Storm
INSERT INTO PARENT (ID_PARENT, ID_CHEVAL)
VALUES (7, 4), (8, 4);

-- Parents de Blaze
INSERT INTO PARENT (ID_PARENT, ID_CHEVAL)
VALUES (9, 5), (10, 5);

INSERT INTO JOCKEY (NOM_JOCKEY, PRENOM_JOCKEY)
VALUES ('Tremblay', 'Eric'),
       ('Moreau', 'Léa'),
       ('Girard', 'Paul'),
       ('Mercier', 'Julien'),
       ('Roux', 'Isabelle'),
       ('Lemoine', 'Patrick'),
       ('Faure', 'Camille'),
       ('Perrin', 'Emilie'),
       ('Dupuis', 'Thomas'),
       ('Gaillard', 'Claire');
       
       
INSERT INTO CATEGORIE (NOM_CATEGORIE)
VALUES ('Trot attelé'), ('Trot monté'), ('Obstacle');



INSERT INTO CHAMP (NOM_CHAMP, NB_PLACES)
VALUES ('Champ de Vincennes', 30000),
       ('Champ de Longchamp', 25000),
       ('Champ de Chantilly', 20000);
       

-- Contenu de la table ADAPTE
INSERT INTO ADAPTE (ID_CHAMP, ID_CATEGORIE) VALUES 
(1, 1), -- Le champ 1 peut accueillir la catégorie 1 (par exemple, trot attelé)
(1, 2), -- Le champ 1 peut également accueillir la catégorie 2 (par exemple, trot monté)
(2, 1), -- Le champ 2 peut accueillir la catégorie 1
(3, 3), -- Le champ 3 peut accueillir la catégorie 3 (par exemple, obstacle)
(3, 1); -- Le champ 3 peut également accueillir la catégorie 1

       
       
INSERT INTO COURSE (ID_CHAMP, ID_CATEGORIE, DESIGNATION)
VALUES (1, 1, 'Prix d’Amérique'),
       (2, 2, 'Prix de l’Arc de Triomphe'),
       (3, 3, 'Grand Steeple-Chase'),
       (1, 1, 'Prix du Président');
       
       
INSERT INTO SESSION (ID_COURSE, NOM_SESSION, DOTATION, DATE_COURSE)
VALUES (1, 'Mars 2024', 1000000, '2024-03-01'),
       (1, 'Mai 2024', 1200000, '2024-05-01'),
       (2, 'Avril 2024', 500000, '2024-04-15'),
       (2, 'Septembre 2024', 600000, '2024-09-10'),
       (3, 'Juin 2024', 750000, '2024-06-10'),
       (3, 'Octobre 2024', 800000, '2024-10-05'),
       (4, 'Juillet 2024', 900000, '2024-07-20'),
       (4, 'Decembre 2024', 950000, '2024-12-01');
       
       
       
-- Participation du cheval Black
INSERT INTO PARTICIPE (ID_JOCKEY, ID_CHEVAL, ID_SESSION, CLASSEMENT)
VALUES (1, 1, 1, 1), (1, 1, 2, 1), (2, 1, 3, 3), (3, 1, 4, 5), (4, 1, 5, 1);

-- Participation du cheval White
INSERT INTO PARTICIPE (ID_JOCKEY, ID_CHEVAL, ID_SESSION, CLASSEMENT)
VALUES (2, 2, 1, 2), (2, 2, 2, 1), (3, 2, 3, 1), (4, 2, 4, 1), (5, 2, 5, 4);

-- Participation des autres chevaux
INSERT INTO PARTICIPE (ID_JOCKEY, ID_CHEVAL, ID_SESSION, CLASSEMENT)
VALUES (3, 3, 1, 4), (4, 3, 2, 3), (5, 3, 3, 2), (6, 3, 4, 5), (7, 3, 5, 3),

       (5, 4, 1, 5), (6, 4, 2, 2), (7, 4, 3, 3), (8, 4, 4, 4), (9, 4, 5, 2),

       (9, 5, 1, 2), (8, 5, 2, 4), (7, 5, 3, 5), (6, 5, 4, 3), (5, 5, 5, 1);


