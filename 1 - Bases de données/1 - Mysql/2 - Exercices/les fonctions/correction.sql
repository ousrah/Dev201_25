/*Exercice 1 :
Écrire une fonction qui renvoie une chaine qui sera exprimée sous la forme Jour, Mois et Année à partir
# d’une date passée comme paramètre où :
­	Mois est exprimé en toutes lettres
exemple : décembre 
Exemple : 12/09/2011 -----> 12 septembre 2011*/

drop function if exists datecomplet;
delimiter // 
create function datecomplet(d date)
      returns varchar(255)
      deterministic
begin  
       declare mois varchar(50);
        declare datec varchar(255);
        declare jj int;
        declare mm int;
        declare annee int;
        set jj = day(d);
        set mm = month(d);
        set annee = year(d);
        set mois = case mm 
		 when  1 then 'janvier'
		 when  2 then 'fevrier'
		 when  3 then 'mars'
		 when 4 then 'avril'
		 when 5 then 'mai'
		 when 6 then 'juin'
		 when 7 then 'juillet'
		 when 8 then 'aout'
		 when 9 then 'septembre'
		 when 10 then 'octobre'
		 when 11 then 'novembre'
		 when 12 then 'decembre'
			else 'erreur'
	    end ;
        set datec = concat(jj,' ' , mois , ' ' , annee);
        return datec;
end //
delimiter ;

select datecomplet('2024/08/15');
	
drop function if exists datecom;
delimiter // 
create function datecom (d date ) 
		returns varchar(50) 
        deterministic 
begin 
	 declare s varchar(50);
	 declare oldLocal varchar(10);
	 set oldLocal = @@lc_time_names;
	 set lc_time_names = "fr_FR";
	 set s =  date_format (d , "%W %M %Y ") ; 
	 set lc_time_names = oldLocal;
	 return s;
end // 
delimiter ;     

select datecom('2024/7/15');
     
     
select date_format ('2024/7/15' , "%W %M %Y ")  as jour;     

/*Exercice 2:
Ecrire une fonction qui reçoit deux dates comme paramètre et calcule l’écart en fonction de l’unité de calcul passée à la fonction ;
L’unité de calcul peut être de type : jour, mois, année, heure, minute, seconde */
drop function if exists date_f;
delimiter $$
create function date_f( date1 datetime, date2 datetime,unite varchar(50))
returns int
deterministic
begin
declare differance int ;
case unite
when "jour" then 
   set differance=datediff(date2,date1);
  when "mois" then
   set differance=timestampdiff(MONTH,date1,date2);
  when "anne" then
   set differance=timestampdiff(YEAR,date1,date2);
  when "heure" then
   set differance=timestampdiff(HOUR,date1,date2);
   when "minute" then
   set differance=timestampdiff(minute,date1,date2);
   when "second" then
   set differance=timestampdiff(second,date1,date2);
   else
    set differance="erreur";
   end case;
    return differance;
end $$
delimiter ;
select date_f("2017-01-01","2018-01-01","jour") as jour;


/*Exercice 3 : application sur la bd ‘gestion_vols’
Gestion vol
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)
*/



drop database if exists vols_201;

create database vols_201 collate utf8mb4_general_ci;
use vols_201;

create table Pilote(numpilote int auto_increment primary key,
nom varchar(50) ,
titre varchar(50) ,
villepilote varchar(50) ,
daten date,
datedebut date);

create table Vol(numvol int auto_increment primary key,
villed varchar(50) ,
villea varchar(50) ,
dated date ,
datea date , 
numpil int not null,
numav int not null);

create table Avion(numav int auto_increment primary key,
typeav  varchar(50) ,
capav int);

alter table vol add constraint fk_vol_pilote foreign key(numpil) references pilote(numpilote);
alter table vol add constraint fk_vol_avion foreign key(numav) references avion(numav);


insert into avion values (1,'boeing',350),
						(2,'caravel',50),
                        (3,'airbus',500),
                        (4,'test',350);
                        
insert into pilote values (1,'hassan','M.','tetouan','2000-01-01','2022-01-01'),
						(2,'saida','Mme.','casablanca','1980-01-01','2005-01-01'),
						(3,'youssef','M.','tanger','1983-01-01','2002-01-01');



update pilote set datedebut = '2002-01-01' where numpilote = 2;
insert into vol values (1,'tetouan','casablanca','2023-09-10','2023-09-10',1,1),
						(2,'casablanca','tetouan','2023-09-10','2023-09-10',1,1),
						(3,'tanger','casablanca','2023-09-11','2023-09-11',2,2),
						(4,'casablanca','tanger','2023-09-11','2023-09-11',2,2),
						(5,'agadir','casablanca','2023-09-11','2023-09-11',3,3),
						(6,'casablanca','agadir','2023-09-11','2023-09-11',3,3);


insert into vol values (7,'tetouan','casablanca','2023-09-10','2023-09-12',1,1),
						(8,'casablanca','tetouan','2023-09-10','2023-09-12',1,1),
						(9,'tanger','casablanca','2023-09-11','2023-09-13',1,2),
						(10,'casablanca','tanger','2023-09-11','2023-09-13',1,2),
						(11,'agadir','casablanca','2023-09-11','2023-09-13',3,3),
						(12,'casablanca','agadir','2023-09-11','2023-09-13',3,3),
                        (13,'tetouan','casablanca','2023-09-10','2023-09-15',2,1),
						(14,'casablanca','tetouan','2023-09-10','2023-09-15',3,1);  

#1.	Ecrire une fonction qui retourne le nombre de pilotes ayant effectué un 
#nombre de vols supérieur à un nombre donné comme paramètre ;




#2.	Ecrire une fonction qui retourne la durée de travail d’un pilote dont
#l’identifiant est passé comme paramètre ;

#3.	Ecrire une fonction qui renvoie le nombre des avions qui ne sont pas affectés à des vols ;

#4.	Ecrire une fonction qui retourne le numero du plus ancien pilote qui 
#a piloté l’avion dont le numero est passé en paramètre ;


#5.	Ecrire une fonction table qui retourne le nombre des pilotes dont le salaire
# est inférieur à une valeur passée comme paramètre ;


/*Exercice 4:
Considérant la base de données suivante :
DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE,#ID_DEP)
*/

#1.	Créer une fonction qui retourne le nombre d’employés
#2.	Créer une fonction qui retourne la somme des salaires de tous les employés
#3.	Créer une fonction pour retourner le salaire minimum de tous les employés
#4.	Créer une fonction pour retourner le salaire maximum de tous les employés
#5.	En utilisant les fonctions créées précédemment, Créer une requête pour afficher le nombre des employés, la somme des salaires, le salaire minimum et le salaire maximum
#6.	Créer une fonction pour retourner le nombre d’employés d’un département donné.
#7.	Créer une fonction la somme des salaires des employés d’un département donné
#8.	Créer une fonction pour retourner le salaire minimum des employés d’un département donné
#9.	Créer une fonction pour retourner le salaire maximum des employés d’un département.
#10.	En utilisant les fonctions créées précédemment, Créer une requête pour afficher pour les éléments suivants : 
#a.	Le nom de département en majuscule. 
#b.	La somme des salaires du département
#c.	Le salaire minimum
#d.	Le salaire maximum
#11.	Créer une fonction qui accepte comme paramètres 2 chaines de caractères et elle retourne les deux chaines en majuscules concaténé avec un espace entre eux.
