#Objectif : Manipuler les curseurs/imbriquer les curseurs
#1 - Terminer la questions 9 du dernier exercice des procedures stockées

/*PS9 : Qui affiche pour chaque recette :
1-Un message sous la forme : "Recette : (Nom de la recette), temps de préparation : (Temps)
2-La liste des ingrédients avec pour chaque ingrédient le nom et la quantité
3-Un message sous la forme : Sa méthode de préparation est : (Méthode)
4-Si le prix de reviens pour la recette est inférieur à 50 DH afficher le message
'Prix intéressant'

1- la structure de la procedure stockée
2- le curseur
3- la boucle du curseur avec affichage du premier message
4- la sortie de la boucle du curseurs
5 - afficher la liste des ingrédiets et la méthode de préparation (question 2 et 3)
6 - Afficher le prix intéressant si le prix de reviens et inférieur a 50.
*/

use cuisine_201;
drop procedure if exists Ps9;
delimiter $$
create procedure Ps9()
begin
	declare flag boolean default false;
	declare  idRec int;
    declare nameRec varchar(50);
    declare methode varchar(250);
    declare tpRec varchar(20); #temp de préparation
    declare prix double;
    declare c cursor for select numrec, nomrec, tempsPreparation, methodePreparation from recettes;
    declare continue handler for not found set flag=true;
    open c;
    l:loop

		fetch c into idRec,nameRec,tpRec, methode;
		if flag then 
			leave l;
		end if;
		select concat("Recette :", nameRec," temps de préparation :", tpRec) as "message";
        
        select NomIng, QteUtilisee 
		from composition_recette
		join ingredients using (NumIng)
		where NumRec=idRec;
		select concat("Sa méthode de préparation est  : ", methode) as "methode";
    
	   select sum(puIng*qteUtilisee) into prix 
	   from ingredients  join composition_recette using(numIng)
  	   where numRec=idRec;
	   if prix<50 then
		   select concat("le prix est interessant ",prix) as prix ;
	   end if;
    
    end loop l;
    
    
    close c;
    

end $$
delimiter ;
call Ps9;










#2 – Ajouter le trigger qui permet de modifier le prix des recettes  lorsqu'on change le prix 
#unitaire d'un ingrédient ( voir le dernier exercice de la série des triggers)

/*1 - strucutre du trigger
2 - recupérer la liste des recettes dont le prix doit être modifié
3 - parcourir la liste des recettes avec un curseur et sortir lorsqu'on atteind la fin
4 - calculer le nouveau prix pour chaque recette
5 - modifier l'ancien prix par le nouveau pour chaque recette.*/

drop trigger if exists q2 ;
delimiter //
create trigger q2 after update on Ingredients for each row
begin
	declare Id int;
    declare flag boolean default False;
    declare p double;
	declare c1 cursor for select Numrec from  composition_recette where Numing = new.numing;
    declare continue handler for not found set flag=True;
    open c1;
		L1:loop
			fetch c1 into Id;
			if flag then
				leave L1;
			end if;
			select sum(puing*qteutilisee) into p from ingredients join composition_recette using(numing) 
			where numrec=id;
			update recettes set prix = p where numrec = id;
		end loop L1;
    close c1;
end //
delimiter ;

select * from ingredients where numing = 1;
select * from composition_recette where numing = 1;
update ingredients set puing = 6  where numing = 1;
select * from recettes;

use vols_201;
select * from pilote;
alter table pilote add salaire double;


#Base de données ‘Gestion_vols’ :
#1)	Réalisez un curseur  qui extrait la liste des pilotes avec pour informations l’identifiant, le nom et le salaire du pilote ;
#Affichez les informations à l’aide de l’instruction Select (print)




drop procedure if exists e2q1;
delimiter $$
create procedure e2q1()
begin
	declare flag boolean default false;
	declare idpilote int;
    declare nomP varchar(50);
    declare sal double;
    declare c cursor for select  numpilote,nom, salaire from pilote;
    declare continue handler for not found set flag=true;
    open c;
		b1: loop
			fetch c into idpilote,nomP,sal;
			if flag then
				leave b1;
			end if;
			select idpilote,nomP,sal;
		end loop;
    close c;
end $$
delimiter ;


call e2q1;
/*2)	Complétez le script précédent en imbriquant un deuxième curseur qui va préciser pour chaque 
pilote, quels sont les vols effectués par celui-ci.

Vous imprimerez alors, pour chaque pilote une liste sous la forme suivante :
- Le pilote ‘ xxxxx xxxxxxxxxxxxxxxxx est affecté aux vols :
       Départ : xxxx  Arrivée : xxxx
       Départ : xxxx  Arrivée : xxxx
       Départ : xxxx  Arrivée : xxxx
-Le pilote ‘ YYY YYYYYYYY est affecté aux vols :
       Départ : xxxx  Arrivée : xxxx
       Départ : xxxx  Arrivée : xxxx
*/


drop procedure if exists e2q2;
delimiter $$
create procedure e2q2()
begin
	declare flag boolean default false;
	declare idpilote int;
    declare nomP varchar(50);
    declare sal double;
    declare c cursor for select  numpilote,nom, salaire from pilote;
    declare continue handler for not found set flag=true;
    open c;
		b1: loop
			fetch c into idpilote,nomP,sal;
			if flag then
				leave b1;
			end if;
			select idpilote,nomP,sal;
            select concat("Le pilote ‘", nomP, " est affecté aux vols :") as "vols";
            
            #affichage des vols du pilote en cours par un curseur
            # select villed, villea from vol where numpil = idpilote;
            begin
				declare flag2 boolean default false;
                declare vd varchar(50);
                declare va varchar(50);
                declare c2 cursor for select villed, villea from vol where numpil = idpilote;
                declare continue handler for not found set flag2 = true;
                open c2;
					lp: loop
						fetch c2 into vd,va;
                    
						if flag2 then
							leave lp;
						end if;
                        
                        select concat("depart: ",vd," - arivee : ", va);
                    end loop lp;
                close c2;
            end;
		end loop;
    close c;
end $$
delimiter ;


call e2q2;
select * from pilote;
select ceiling(rand()*4);

/*3)	Vous allez modifier le curseur précédent pour pouvoir mettre à jour le salaire du pilote. Vous afficherz une ligne supplémentaire à la suite de la liste des vols en précisant l’ancien et le nouveau salaire du pilote.
Le salaire brut du pilote est fonction du nombre de vols auxquels il est affecté :

	Si 0 alors le salaire est 5 000
	Si entre 1 et 3,  salaire de 7 000
	Plus de 3, salaire de 8000
*/


#methode 1
drop procedure if exists e2q3;
delimiter $$
create procedure e2q3()
begin
	declare flag boolean default false;
	declare idpilote int;
    declare nomP varchar(50);
    declare sal double;
    declare salairenv double;
    declare countv int;
    declare c cursor for select  numpilote,nom, salaire from pilote;
    declare continue handler for not found set flag=true;
    open c;
		b1: loop
			fetch c into idpilote,nomP,sal;
			if flag then
				leave b1;
			end if;
			select idpilote,nomP,sal;
            select concat("Le pilote ‘", nomP, " est affecté aux vols :") as "vols";
            select count(*) into countv from vol where numPil = idpilote;
            
            
            #affichage des vols du pilote en cours par un curseur
            # select villed, villea from vol where numpil = idpilote;
            begin
				declare flag2 boolean default false;
                declare vd varchar(50);
                declare va varchar(50);
                declare c2 cursor for select villed, villea from vol where numpil = idpilote;
                declare continue handler for not found set flag2 = true;
                open c2;
					lp: loop
						fetch c2 into vd,va;
                    
						if flag2 then
							leave lp;
						end if;
                        
                        select concat("depart: ",vd," - arivee : ", va);
                    end loop lp;
                close c2;
		
            end;
             if countv = 0 then 
				set salairenv = 5000 ;
			 elseif countv between 1 and 3 then 
                set salairenv = 7000 ;
			 else 
                set salairenv = 8000 ;
             end if;
            update pilote set salaire = salairenv where numpilote = idpilote;
		end loop;
    close c;
end $$
delimiter ;




#methode 2
drop procedure if exists e2q3;
delimiter $$
create procedure e2q3()
begin
	declare flag boolean default false;
	declare idpilote int;
    declare nomP varchar(50);
    declare sal double;
    declare salairenv double;
    declare countv int;
    declare c cursor for select  numpilote,nom, salaire from pilote;
    declare continue handler for not found set flag=true;
    open c;
		b1: loop
			set countv = 0;
			fetch c into idpilote,nomP,sal;
			if flag then
				leave b1;
			end if;
			select idpilote,nomP,sal;
            select concat("Le pilote ‘", nomP, " est affecté aux vols :") as "vols";
            
            
            #affichage des vols du pilote en cours par un curseur
            # select villed, villea from vol where numpil = idpilote;
            begin
				declare flag2 boolean default false;
                declare vd varchar(50);
                declare va varchar(50);
                declare c2 cursor for select villed, villea from vol where numpil = idpilote;
                declare continue handler for not found set flag2 = true;
                open c2;
					lp: loop
						fetch c2 into vd,va;
                    
						if flag2 then
							leave lp;
						end if;
						set countv = countv+1;
                        select concat("depart: ",vd," - arivee : ", va);
                    end loop lp;
                close c2;
		
            end;
             if countv = 0 then 
				set salairenv = 5000 ;
			 elseif countv between 1 and 3 then 
                set salairenv = 7000 ;
			 else 
                set salairenv = 8000 ;
             end if;
            update pilote set salaire = salairenv where numpilote = idpilote;
		end loop;
    close c;
end $$
delimiter ;

select * from pilote;
update pilote set salaire = 0;

select * from vol;

call e2q3;


/*Exercice 2
Soit la base de données suivante

Employé :

Matricule	nom	prénom	état
1453	Lemrani	Kamal	fatigué
4532	Senhaji	sara	En forme
			…
			..

Groupe :
Matricule	Groupe
1453	Administrateur
1453	Chef
4532	Besoin vacances
…	
On désire ajouter les employés dont l’état est fatigué dans le groupe ‘besoin vacances’ dans la table Groupe;
Utiliser un curseur ;
*/




drop database if exists vacances_201;
create database vacances_201 collate utf8mb4_general_ci;
use vacances_201;

create table employe (matricule int primary key, nom varchar(100), prenom varchar(100),etat  varchar(100));
create table groupe (matricule int , groupe varchar(100), constraint fk_groupe_employe foreign key (matricule) references employe(matricule) on delete cascade on update cascade);

insert into employe  (matricule, nom, etat) values
(1453,	'amal'	,'fatigué'),
(4532	,'sara'	,'En forme'),
(1454,	'Kamal'	,'fatigué'),
(4535	,'karima'	,'En forme'),
(1456,	'hasna'	,'fatigué'),
(4537	,'moad'	,'En forme'),
(1458,	'ziad'	,'fatigué'),
(4539	,'nada'	,'En forme'),
(1450,	'omar'	,'fatigué'),
(4531	,'mouna'	,'En forme');





#methode avec curseur
drop procedure if exists e3;
delimiter $$
create procedure e3()
begin
	declare flag boolean default false;
	declare mat int;
    declare c cursor for select  matricule from employe where etat = 'fatigue';
    declare continue handler for not found set flag=true;
    open c;
		b1: loop
			fetch c into mat;
			if flag then
				leave b1;
			end if;
			insert into groupe value (mat, 'besoin vacances');
		end loop;
    close c;
end $$
delimiter ;

delete from groupe;
call e3;

#methode sans curseur
insert into groupe select matricule,'besoin vacances' from employe where etat = 'fatigué';

select * from groupe;
