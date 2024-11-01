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




#le restor (la restauration - la recupération)