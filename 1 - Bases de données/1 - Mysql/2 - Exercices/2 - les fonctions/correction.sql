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

create table Pilote(
numpilote int auto_increment primary key,
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

use vols_201;

drop function if exists nbrPilote;

delimiter $$
create function nbrPilote(nbrVol int)
	returns int
    deterministic
begin
	declare nombre_pilote int;
    select count(distinct numpilote) 
    into nombre_pilote 
    from Pilote join Vol on Vol.numpil = Pilote.numpilote
    group by numpilote
    having count(numvol) > nbrVol;
    return nombre_pilote;
end $$
delimiter ;

select nbrPilote(3);





select count(*) from (select numpil, count(*)   from vol
group by numpil
having count(*)>2)f ;



with f as (select numpil, count(*)   from vol
group by numpil
having count(*)>2)
select count(*) from f ;



drop function if exists E3Q1;
delimiter $$
create function E3Q1(n int)
returns int
reads sql data
begin
	declare r int;
	
    with f as (select numpil, count(*)   from vol
	group by numpil
	having count(*)>n)
    
	select count(*) into r from f ;
	
    return r;
end $$
delimiter ;

select E3Q1(4);


select * from vol;

#2.	Ecrire une fonction qui retourne la durée de travail d’un pilote dont
#l’identifiant est passé comme paramètre ;
drop function if exists E3Q2;
delimiter //
create function E3Q2(nmpilo int)
returns int
reads sql data
begin
	declare duree int;
	select timestampdiff(YEAR, datedebut , CURRENT_DATE()) into duree
	from pilote
	where numpilote = nmpilo;
	return duree;
end //
delimiter ;
select E3Q2(3);
#3.	Ecrire une fonction qui renvoie le nombre des avions qui ne sont pas affectés à des vols ;
drop function if exists e3q3;

delimiter $$
create function e3q3()
	returns int
	reads sql data
begin
	declare con int ;
    -- select  count(*) from avion left join vol using (numav) where numvol is null;
	select count(*) into con from avion where numav not in (select numav from vol);
	return con;
end $$
delimiter ;
select e3q3();


#4.	Ecrire une fonction qui retourne le numero du plus ancien pilote qui 
# a piloté l’avion dont le numero est passé en paramètre ;
use vols_201;
select p.numpilote
from pilote p join vol v on p.numpilote=v.numpil
where numav=1
order by datedebut asc
limit 1;


drop function if exists E3Q4;
delimiter $$
create function E3Q4(av int)
	returns int 
    reads sql data
begin
	declare d int;
	with t1 as (select distinct  numpilote, datedebut , numav
				from vol v join pilote p on v.numpil = p.numpilote 
				where numav = av
				order by datedebut asc),
	t2 as (select min(datedebut) as datedebut from t1)
	select numpilote into d from t1 join t2 using(datedebut) limit 1;
	return d;
end $$
delimiter ;

select E3Q4(1);


#5.	Ecrire une fonction table qui retourne le nombre des pilotes dont le salaire
# est inférieur à une valeur passée comme paramètre ;

my sql ne permet de retourner une table dans une fonction.

/*Exercice 4:
Considérant la base de données suivante :
DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE,#ID_DEP)
*/



drop database if exists employes_201;

create database employes_201 COLLATE "utf8mb4_general_ci";
use employes_201;


create table DEPARTEMENT (
ID_DEP int auto_increment primary key, 
NOM_DEP varchar(50), 
Ville varchar(50));

create table EMPLOYE (
ID_EMP int auto_increment primary key, 
NOM_EMP varchar(50), 
PRENOM_EMP varchar(50), 
DATE_NAIS_EMP date, 
SALAIRE float,
ID_DEP int ,
constraint fkEmployeDepartement foreign key (ID_DEP) references DEPARTEMENT(ID_DEP));

insert into DEPARTEMENT (nom_dep, ville) values 
		('FINANCIER','Tanger'),
		('Informatique','Tétouan'),
		('Marketing','Martil'),
		('GRH','Mdiq');

insert into EMPLOYE (NOM_EMP , PRENOM_EMP , DATE_NAIS_EMP , SALAIRE ,ID_DEP ) values 
('said','said','1990/1/1',8000,1),
('hassan','hassan','1990/1/1',8500,1),
('khalid','khalid','1990/1/1',7000,2),
('souad','souad','1990/1/1',6500,2),
('Farida','Farida','1990/1/1',5000,3),
('Amal','Amal','1990/1/1',6000,4),
('Mohamed','Mohamed','1990/1/1',7000,4);



#1.	Créer une fonction qui retourne le nombre d’employés

drop function if exists E4Q1;
delimiter $$
create function E4Q1()
	returns int 
    reads sql data
begin
	declare d int;
	select count(*) into d from employe;
	return d;
end $$
delimiter ;

select E4Q1();


#2.	Créer une fonction qui retourne la somme des salaires de tous les employés

drop function if exists E4Q2;
delimiter $$
create function E4Q2()
	returns double 
    reads sql data
begin
	declare d double;
	select sum(salaire) into d from employe;
	return d;
end $$
delimiter ;
select E4Q2();

#3.	Créer une fonction pour retourner le salaire minimum de tous les employés

drop function if exists E4Q3;
delimiter $$
create function E4Q3()
	returns double 
    reads sql data
begin
	declare d double;
	select min(salaire) into d from employe;
	return d;
end $$
delimiter ;
select E4Q3();
#4.	Créer une fonction pour retourner le salaire maximum de tous les employés

drop function if exists E4Q4;
delimiter $$
create function E4Q4()
	returns double 
    reads sql data
begin
	declare d double;
	select max(salaire) into d from employe;
	return d;
end $$
delimiter ;
select E4Q4();

#5.	En utilisant les fonctions créées précédemment, Créer une requête pour afficher
# le nombre des employés, la somme des salaires, le salaire minimum et le salaire maximum


select E4Q1() as nombres_employes,
E4Q2() as Sommes_Salaires,
E4Q3() as MinSalaire,
E4Q4() as MaxSalaire;

#6.	Créer une fonction pour retourner le nombre d’employés d’un département donné.
drop function if exists E4Q6;
delimiter $$
create function E4Q6(id_d int)
	returns int 
    reads sql data
begin
	declare d int;
	select count(*) into d from employe
    where id_dep=id_d;
	return d;
end $$
delimiter ;
select E4Q6(2);



#7.	Créer une fonction la somme des salaires des employés d’un département donné


drop function if exists E4Q7;
delimiter $$
create function E4Q7(id_d int)
	returns double 
    reads sql data
begin
	declare d double;
	select sum(salaire) into d from employe
    where id_dep=id_d;
	return d;
end $$
delimiter ;
select E4Q7(2);

#8.	Créer une fonction pour retourner le salaire minimum des employés d’un département donné

drop function if exists E4Q8;
delimiter $$
create function E4Q8(id_d int)
	returns double 
    reads sql data
begin
	declare d double;
	select min(salaire) into d from employe
    where id_dep=id_d;
	return d;
end $$
delimiter ;
select E4Q8(2);

#9.	Créer une fonction pour retourner le salaire maximum des employés d’un département.


drop function if exists E4Q9;
delimiter $$
create function E4Q9(id_d int)
	returns double 
    reads sql data
begin
	declare d double;
	select max(salaire) into d from employe
    where id_dep=id_d;
	return d;
end $$
delimiter ;
select E4Q9(2);

#10.	En utilisant les fonctions créées précédemment, Créer une requête pour afficher  les éléments suivants : 
	#a.	Le nom de département en majuscule.
	#b. le nombre de salairé du département 
	#c.	La somme des salaires du département
	#d.	Le salaire minimum du département
	#e.	Le salaire maximum du département

select ucase(nom_dep) as nomDepartement, 
	E4Q6(id_dep) as nbEmployes ,
    E4Q7(id_dep) as sommeSalaires ,
    E4Q8(id_dep) as SalaireMin ,
    E4Q9(id_dep) as SalaireMax 
    from departement;




#11.	Créer une fonction qui accepte comme paramètres 2 chaines de caractères et elle retourne les deux chaines en majuscules concaténé avec un espace entre eux.
drop function if exists E4Q11;
delimiter $$
create function E4Q11(str1 varchar(100), str2 varchar(100))
returns varchar (201)
deterministic
begin
return upper(concat(str1, ' ',str2));
end $$
delimiter ;
select E4Q11("hamza","majid");
