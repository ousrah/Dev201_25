#	Q1 : Lister tous les étudiants ayant emprunté un livre aujourd'hui. (2 points)
SELECT e.nom, e.prenom, emp.date_emprunt 
FROM emprunts emp
JOIN etudiants e ON emp.id_etudiant = e.id_etudiant
WHERE emp.date_emprunt = CURDATE();

#	Q2 : Afficher le nombre total de livres disponibles en consultation sur place. (2 points)
SELECT COUNT(*) AS livres_consultation
FROM livres
WHERE consultation = 1;


#	Q3 : Afficher les emprunts de l'étudiant « Karim Lahlou », triés par date. (2 points)
SELECT e.nom, e.prenom, emp.date_emprunt, emp.date_retour_prevu, emp.date_retour_effectif 
FROM emprunts emp
JOIN etudiants e ON emp.id_etudiant = e.id_etudiant
WHERE e.nom = 'Lahlou' AND e.prenom = 'Karim'
ORDER BY emp.date_emprunt ASC;

#	Q4 : Lister les emprunts non retournés dans les délais au cours des 30 derniers jours. (2 points)
SELECT e.nom, e.prenom, emp.date_emprunt, emp.date_retour_prevu, emp.date_retour_effectif
FROM emprunts emp
JOIN etudiants e ON emp.id_etudiant = e.id_etudiant
WHERE emp.date_retour_effectif IS NULL 
AND emp.date_retour_prevu < CURDATE() 
AND emp.date_emprunt >= CURDATE() - INTERVAL 30 DAY;

#	Q5 : Lister les étudiants ayant emprunté au moins 10 livres au cours du semestre. (2 points)
SELECT e.nom, e.prenom, COUNT(emp.id_emprunt) AS nombre_emprunts
FROM emprunts emp
JOIN etudiants e ON emp.id_etudiant = e.id_etudiant
WHERE emp.date_emprunt >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY e.nom, e.prenom
HAVING COUNT(emp.id_emprunt) >= 10;

#	Q6 : Lister les jours où le livre « Programmation en Python » a été réservé mais n'a pas été disponible. (2 points)
SELECT r.date_reservation 
FROM reservations r
JOIN livres l ON r.id_livre = l.id_livre
JOIN exemplaires ex ON l.id_livre = ex.id_livre
WHERE l.titre = 'Programmation en Python' 
AND ex.disponible = 0;
