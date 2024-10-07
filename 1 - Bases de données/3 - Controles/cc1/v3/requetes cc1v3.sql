use cc1v3;

-- Q1 : Lister tous les colis qui ont été livrés aujourd'hui.
SELECT c.id_colis, c.num_suivi, c.date_envoi, pl.date_etape
FROM Colis c
JOIN Processus_Livraison pl ON c.id_colis = pl.id_colis
JOIN Etape e ON pl.id_etape = e.id_etape
WHERE e.nom_etape = 'Livré' 
AND DATE(pl.date_etape) = CURDATE();

-- Q2 : Afficher le nombre de livreurs travaillant pour l'entreprise.
SELECT COUNT(*) AS nombre_livreurs
FROM Livreur;

-- Q3 : Afficher les livraisons effectuées pour le client « Mohamed Zaki », triées par date.
SELECT c.id_colis, c.num_suivi, pl.date_etape
FROM Colis c
JOIN Client cli ON c.id_client_destinataire = cli.id_client
JOIN Processus_Livraison pl ON c.id_colis = pl.id_colis
JOIN Etape e ON pl.id_etape = e.id_etape
WHERE cli.nom = 'Zaki' AND cli.prenom = 'Mohamed'
AND e.nom_etape = 'Livré'
ORDER BY pl.date_etape ASC;

-- Q4 : Lister les colis en attente de livraison depuis plus de 5 jours.
SELECT c.id_colis, c.num_suivi, pl.date_etape
FROM Colis c
JOIN Processus_Livraison pl ON c.id_colis = pl.id_colis
JOIN Etape e ON pl.id_etape = e.id_etape
WHERE e.nom_etape = 'En attente de livraison'
AND DATEDIFF(CURDATE(), pl.date_etape) > 5;

-- Q5 : Lister les livreurs ayant effectué au moins 10 livraisons en une journée.
SELECT l.id_livreur, l.nom, l.prenom, COUNT(pl.id_processus) AS nombre_livraisons, DATE(pl.date_etape) AS date_livraison
FROM Livreur l
JOIN Processus_Livraison pl ON l.id_livreur = pl.id_livreur
JOIN Etape e ON pl.id_etape = e.id_etape
WHERE e.nom_etape = 'Livré'
GROUP BY l.id_livreur, DATE(pl.date_etape)
HAVING nombre_livraisons >= 10;

-- Q6 : Lister les colis pour lesquels une tentative de livraison a échoué au cours des 7 derniers jours.
SELECT c.id_colis, c.num_suivi, tl.date_tentative, tl.raison
FROM Colis c
JOIN Tentative_Livraison tl ON c.id_colis = tl.id_colis
WHERE tl.succes = FALSE
AND tl.date_tentative >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);


























