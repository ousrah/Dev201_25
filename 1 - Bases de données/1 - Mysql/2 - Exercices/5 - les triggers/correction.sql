
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
dated datetime ,
datea datetime , 
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
insert into vol values (1,'tetouan','casablanca','2023-09-10 12:00:00','2023-09-10 14:00:00',1,1),
						(2,'casablanca','tetouan','2023-09-10 12:00:00','2023-09-10 14:00:00',1,1),
						(3,'tanger','casablanca','2023-09-11 12:00:00','2023-09-11 14:00:00',2,2),
						(4,'casablanca','tanger','2023-09-11 12:00:00','2023-09-11 14:00:00',2,2),
						(5,'agadir','casablanca','2023-09-11 12:00:00','2023-09-11 14:00:00',3,3),
						(6,'casablanca','agadir','2023-09-11 12:00:00','2023-09-11 14:00:00',3,3);





#1 – Ajouter la table pilote le champ nb d’heures de vols ‘NBHV’ sous la forme  « 00:00:00 ».
alter table pilote modify nbhv time;
select * from pilote;
#2 – Ajouter un déclencheur qui calcule le nombre heures lorsqu’on ajoute un nouveau vol et qui augmente 
#automatiquement le nb d’heures de vols du pilote qui a effectué le vol.

drop trigger if exists CalcHeure;
delimiter //
create trigger CalcHeure after insert on vol for each row 
begin 
		declare Tdiff time ; 
        set Tdiff = timediff(new.datea, new.dated) ;
        update pilote set NBHV = nbhv+tdiff where numpilote = new.numpil ;
end // 
delimiter ;
select * from vol ;

insert into vol values (null,'x','y','2023-09-10 12:00:00','2023-09-10 14:00:00',1,1);
insert into vol values (null,'x','y','2023-10-10 12:00:00','2023-10-10 14:00:00',1,1);
insert into vol values (null,'y','x','2023-10-11 12:00:00','2023-10-12 23:00:00',1,1);
#3 – Si on supprime un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.
#4 – Si on modifie la date de départ ou d’arrivée d’un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.


