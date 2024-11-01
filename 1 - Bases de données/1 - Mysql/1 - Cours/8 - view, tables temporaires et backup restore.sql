#les vues
use vols_201;

# la requette t1 n'est utilisable quand dans la contexte la requette
with t1 as (select vol.* from vol join pilote on vol.numpil = pilote.numpilote
				  join avion on vol.numav = avion.numav)
select count(*) from t1;

#impossible d'utiliser t1 ici
select * from t1;

#on peut enregistrer un requette sous forme de vue pour l'utiliser ultériérement comme si on utilise une table
create view v_t1 as select vol.* from vol join pilote on vol.numpil = pilote.numpilote
				  join avion on vol.numav = avion.numav;


select * from v_t1;
select count(*) from v_t1;

#les tables temporaires
create temporary table tva (id int auto_increment primary key, nom varchar(50), valeur double);
insert into tva (nom, valeur) values ('normal', '0.20'),('reduire',0.07),('services',0.14);
create temporary table tva2025 (id int auto_increment primary key, nom varchar(50), valeur double);
insert into tva2025 (nom, valeur) values ('normal', '0.19'),('reduire',0.09),('services',0.16);

CREATE temporary TABLE volsOfCasa AS select * from vol where villed = 'casablanca';
CREATE  TABLE volsOfTanger AS select * from vol where villed = 'tanger';

select * from volsOfCasa;
select * from volsOfTanger;




#le backup (la sauvegarde)

#pour utiliser mysqldump il faut soit entrer dans le dossier  C:\Program Files\MySQL\MySQL Server x.x\bin
# ou ajouter C:\Program Files\MySQL\MySQL Server x.x\bin a path systeme dans les variables d'environnement
#tapez mysqldump en ligne de commande pour tester s'il existe.


#utilise le post locale et le port 3306
mysqldump -u root -p cuisine_202 > cuisine_202.sql

#ici on a précisé le host avec -h et le port avec -P (maj)
mysqldump -h 127.0.0.1 -P 3306 -u root -p cuisine_202 > cuisine_202B.sql

#ici on a fourni aussi le mot de passe il doit être collé a -p (min)
mysqldump -h 127.0.0.1 -P 3306 -u root -p123456 cuisine_202 > cuisine_202B.sql



#le restor (la restauration - la recupération)

#methode 1 (pour les petits scripts)
#Créer une nouvelle base de données
create database test;
use test;
#ouvrir le script sauvegardé dans workbench
#lancer le script dans workbench


#Methode 2 ( en ligne de commande)
create database test2;
mysql -u root -p test2 < cuisine_202B.sql


#methode 3 (sur la console mysql)
mysql -u root -p
create database test3 collate utf8mb4_general_ci; (attention ne pas oublier ;)
use test;
source cuisine_202B.sql  (sans ;) (préciser le chemin du fichier, si vous donnez juste le nom il doit le trouver dans le dossier a partir duquel vous avez lancé la console mysql)


