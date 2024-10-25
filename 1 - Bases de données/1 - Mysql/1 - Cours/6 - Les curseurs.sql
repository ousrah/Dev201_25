#Les curseurs

#utilisons la base de données gestion des vols


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
						(2,'saida','Mme.','casablanca','1980-01-01','2002-01-01'),
						(3,'youssef','M.','tanger','1983-01-01','2002-01-01');



insert into vol values (1,'tetouan','casablanca','2023-09-10','2023-09-10',1,1),
						(2,'casablanca','tetouan','2023-09-10','2023-09-10',1,1),
						(3,'tanger','casablanca','2023-09-11','2023-09-11',2,2),
						(4,'casablanca','tanger','2023-09-11','2023-09-11',2,2),
						(5,'agadir','casablanca','2023-09-11','2023-09-11',3,3),
						(6,'casablanca','agadir','2023-09-11','2023-09-11',3,3),
                        (7,'tetouan','casablanca','2023-09-10','2023-09-12',1,1),
						(8,'casablanca','tetouan','2023-09-10','2023-09-12',1,1),
						(9,'tanger','casablanca','2023-09-11','2023-09-13',1,2),
						(10,'casablanca','tanger','2023-09-11','2023-09-13',1,2),
						(11,'agadir','casablanca','2023-09-11','2023-09-13',3,3),
						(12,'casablanca','agadir','2023-09-11','2023-09-13',3,3),
                        (13,'tetouan','casablanca','2023-09-10','2023-09-15',2,1),
						(14,'casablanca','tetouan','2023-09-10','2023-09-15',3,1);  


delete from vol where numvol>=7;
#on va ajouter le champs nbhv dans la table pilote pour enregistrer le nombre d'heures de vol
alter table pilote add nbhv time default "00:00:00";
alter table vol modify datea datetime;
alter table vol modify dated datetime;

select * from pilote;
select * from vol;

drop procedure if exists set_nbhv;
delimiter $$
create procedure set_nbhv()
begin
	declare flag boolean default false;
	declare id int;
    declare t time;
    declare c1 cursor for select numpilote from pilote;
    declare continue handler for not found set flag = true;
    open c1;
    b1: loop
		fetch c1 into id;
        if flag then
			leave b1;
        end if;
        #traitement pour le pilote en cours
        select sec_to_time(sum(time_to_sec(timediff(datea, dated)))) into t 
				from vol 
                where numpil = id;
        update pilote 
				set nbhv = t 
                where numpilote = id;
    end loop b1;
    close c1;
end $$
delimiter ;

call set_nbhv;
select * from pilote;


select sec_to_time(sum(time_to_sec(timediff(datea, dated)))) from vol where numpil = 3;

