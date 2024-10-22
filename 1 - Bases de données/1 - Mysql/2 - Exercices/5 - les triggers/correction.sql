
/*EX 1 - Soit la base de données suivante :  (Utilisez celle de la série des fonctions):
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)
*/
use vols_201;


#1 – Ajouter la table pilote le champ nb d’heures de vols ‘NBHV’ sous la forme  « 00:00:00 ».
alter table pilote add nbhv time default "00:00:00";
select * from pilote;
delete from vol;
#2 – Ajouter un déclencheur qui calcule le nombre heures lorsqu’on ajoute un nouveau vol et qui augmente 
#automatiquement le nb d’heures de vols du pilote qui a effectué le vol.

drop trigger if exists e1q2;
delimiter //
create trigger e1q2 after insert on vol for each row 
begin 
        update pilote set NBHV = nbhv+timediff(new.datea, new.dated) where numpilote = new.numpil ;
end // 
delimiter ;
select * from vol ;

insert into vol values (null,'x','y','2023-09-10 12:00:00','2023-09-10 14:00:00',1,1);
insert into vol values (null,'y','x','2023-10-12 12:30:00','2023-10-12 14:00:00',1,1);
#3 – Si on supprime un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.


drop trigger if exists e1q3;
delimiter //
create trigger e1q3 after delete on vol for each row 
begin 
        update pilote set NBHV = nbhv-timediff(old.datea, old.dated) where numpilote = old.numpil ;
end // 
delimiter ;
select * from vol;
delete from vol where numvol = 2;

#4 – Si on modifie la date de départ ou d’arrivée d’un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.

drop trigger if exists e1q4;
delimiter //
create trigger e1q4 after update on vol for each row 
begin 
        update pilote set NBHV = nbhv-timediff(old.datea, old.dated)+timediff(new.datea, new.dated) where numpilote = new.numpil ;
end // 
delimiter ;
select * from vol ;
update vol set datea = '2023-09-10 15:00:00' where numvol = 1;
update vol set datea = '2023-09-10 13:00:00' where numvol = 1;


/*EX 2 - Soit la base de données suivante :  (Utilisez celle de la série des PS):

DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE, #ID_DEP)*/

use employes_201;
select * from departement;
select * from employe;
# 1 – Ajouter le champs salaire moyen dans la table département.
alter table departement add salaire_moyen double default 0;
delete from employe;

/*2 – On souhaite que le salaire moyen soit recalculé automatiquement si 
-on ajoute un nouvel employé, 
-on supprime ou 
-on modifie le salaire d’un ou plusieurs employés. 
Proposez une solution.*/

select * from departement;
select * from employe;

#trigger d'insertion
drop trigger if exists e2q2a;
delimiter $$
create trigger e2q2a after insert on employe for each row
begin
	update departement set salaire_moyen = (select avg(salaire) from employe where id_dep = new.id_dep) where id_dep = new.id_dep;
end $$
delimiter ;

insert into employe values (null,'x','x',null,8000,1);
insert into employe values (null,'y','y',null,6000,1);

#trigger de suppression

drop trigger if exists e2q2b;
delimiter $$
create trigger e2q2b after delete on employe for each row
begin
	update departement set salaire_moyen = (select avg(salaire) from employe where id_dep = old.id_dep) where id_dep = old.id_dep;
end $$
delimiter ;


delete from employe where id_emp = 9;


#trigger de modification
drop trigger if exists e2q2c;
delimiter $$
create trigger e2q2c after update on employe for each row
begin
	update departement 
    set salaire_moyen = (select avg(salaire) from employe where id_dep = new.id_dep) 
    where id_dep = new.id_dep;
end $$
delimiter ;

update employe set salaire = 15000 where id_emp = 8;


/*EX 2 - Soit la base de données suivante : (Utilisez celle de la série des PS):
Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
Composition_Recette (NumRec, NumIng, QteUtilisee)
Fournisseur (NumFou, RSFou, AdrFou)*/
use cuisine_201;
select * from recettes;
select * from composition_recette;

#1 – Ajoutez le champ prix à la table recettes.
alter table recettes add prix double default 0;
delete from composition_recette;
/*#2 – On souhaite que le prix de la recette soit calculé automatiquement
- si on ajoute un nouvel ingrédient dans la recette,
- on supprime un ingrédient de la recette
-ou on modifie la quantité ou le prix d’un ou plusieurs ingrédients.
 Proposez une solution. */

#trigger d'insertion
drop trigger if exists e3q1;
delimiter $$
create trigger e3q1 after insert on composition_recette for each row
begin
	update recettes 
	set prix =(select sum(QteUtilisee*PUIng) from Ingredients i join composition_recette cr
				using(NumIng) where cr.NumRec=new.NumRec ) 
	WHERE NumRec=new.NumRec;
end $$
delimiter ;


select * from recettes;
select * from composition_recette;
select * from ingredients;


insert into composition_recette values (1,1,2);
insert into composition_recette values (1,3,1);

#trigger de suppression
drop trigger if exists e3q2b;
delimiter $$
create trigger e3q2b after delete on composition_recette for each row
begin
declare p decimal(10,2);
select sum(qteutilisee * puing)into p from composition_recette
		join Ingredients using(NumIng)
        where NumRec=old.NumRec;
        update Recettes set prix= p where NumRec = old.NumRec ;
end$$
delimiter ;

select * from recettes;
select * from composition_recette;
select * from ingredients;

delete from composition_recette where numrec = 1 and numing = 1;



#trigger de modification
drop trigger if exists e3q2c;
delimiter $$
create trigger e3q2c after update on composition_recette for each row
begin
declare p decimal(10,2);
select sum(qteutilisee * puing)into p from composition_recette
		join Ingredients using(NumIng)
        where NumRec=old.NumRec;
        update Recettes set prix= p where NumRec = old.NumRec ;
end$$
delimiter ;

select * from recettes;
select * from composition_recette;
select * from ingredients;

update composition_recette set qteutilisee = 1 where numrec = 1 and numing = 3;

