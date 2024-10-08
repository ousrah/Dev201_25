-- Q1 : Lister tous les patients ayant un rendez-vous aujourd’hui
SELECT p.nom, p.prenom, r.date_rendezvous, r.heure_rendezvous
FROM patients p
JOIN rendezvous r ON p.id = r.patient_id
WHERE r.date_rendezvous = CURDATE();

-- Q2 : Afficher le nombre des dentistes travaillant dans le cabinet
SELECT COUNT(*) AS nombre_dentistes
FROM dentistes;

-- Q3 : Afficher les rendez-vous du patient « Benhsain Zakaria », triés par date
SELECT p.nom, p.prenom, r.date_rendezvous, r.heure_rendezvous, e.nom_etat
FROM patients p
JOIN rendezvous r ON p.id = r.patient_id
JOIN etats e ON r.etat_id = e.id
WHERE p.nom = 'Benhsain' AND p.prenom = 'Zakaria'
ORDER BY r.date_rendezvous;

-- Q4 : Lister les rendez-vous qui ont été annulés au cours des 30 derniers jours
SELECT p.nom, p.prenom, r.date_rendezvous, r.heure_rendezvous, e.nom_etat
FROM patients p
JOIN rendezvous r ON p.id = r.patient_id
JOIN etats e ON r.etat_id = e.id
WHERE e.nom_etat = 'annule'
AND r.date_rendezvous >= CURDATE() - INTERVAL 30 DAY;

-- Q5 : Lister les dentistes qui ont effectué au moins 3 consultations en une seule journée
SELECT d.nom, d.prenom, r.date_rendezvous, COUNT(*) AS nombre_consultations
FROM dentistes d
JOIN rendezvous r ON d.id = r.dentiste_id
GROUP BY d.nom, d.prenom, r.date_rendezvous
HAVING COUNT(*) >= 3;

-- Q6 : Lister les jours où le dentiste « Hicham Makhlouf » n'a eu aucun rendez-vous
SELECT DISTINCT r.date_rendezvous
FROM rendezvous r
JOIN dentistes d ON r.dentiste_id = d.id
WHERE r.date_rendezvous NOT IN (
    SELECT r2.date_rendezvous
    FROM rendezvous r2
    JOIN dentistes d2 ON r2.dentiste_id = d2.id
    WHERE d2.nom = 'Makhlouf' AND d2.prenom = 'Hicham'
);
