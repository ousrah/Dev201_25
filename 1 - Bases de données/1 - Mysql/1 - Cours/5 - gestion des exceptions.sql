#La gestion des exceptions

drop database if exists commerce_201;
create database commerce_201 collate utf8mb4_general_ci;
use commerce_201;

create table produit(id_produit int auto_increment primary key,
nom varchar(100),
prix double,
check (prix>0));


drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	insert into produit  values (null,name, price);
end $$
delimiter ;

call add_product('pc',8000);
call add_product('imprimante',-100); #erreur liée a la règle de valdation prix>0
select * from produit;


#on va ajouter une gestion d'exception générale (sqlexception)
drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare exit handler for sqlexception
    begin
		select "erreur d'insertion" as 'erreur';
    end;
	insert into produit  values (null,name, price);
    select "insertion effectuée avec succues" as 'succes';
end $$
delimiter ;

call add_product('clavier',80);
call add_product('imprimante',-100); #erreur liée a la règle de valdation prix>0
select * from produit;

#on va ajouter deux autres règle de validation dans la table produit;
alter table produit modify nom varchar(100) not null unique;

call add_product('souris',50);
call add_product('souris',150); #erreur d'insertion parceque le nom est en double
call add_product(null,150); #erreur d'insertion parceque le nom est null
call add_product('imprimante',-100); #erreur d'inserction parceque le prix est inférieur à zero


#on va provoquer les erreur et noter les codes d'erreur pour les traiter par la suite un par un
drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	insert into produit  values (null,name, price);
end $$
delimiter ;
select * from produit;
call add_product('telephone',1500); #success
call add_product('souris',150); #1062
call add_product(null,150); #1048
call add_product('imprimante',-100); #3819



drop procedure if exists add_product ;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare msg varchar(100) default '';
    begin
		declare exit handler for 1062 set msg = "ce produit existe deja";
		declare exit handler for 1048 set msg = "le nom du produit ne peut pas être null";
		declare exit handler for 3819 set msg = "le prix du produit ne peut pas être négatif";
		insert into produit  values (null,name, price);
	end;
    if msg != '' then
		select msg as 'erreur';
	else
        select "insertion effectuée avec succues" as 'succes';
	end if;
end $$
delimiter ;


#si on souhaite lever l'erreur sans quitter la procedure


drop procedure if exists add_product;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare flag boolean default false;
    begin
		declare exit handler for sqlexception set flag = true;
		insert into produit values (null, name, price);
	end;
    if flag then
		select "erreur d'insertion" as "erreur";
    else
		select "insertion effecutée avec succes" as "success";
    end if;
end $$
delimiter ;


# on va lever l'erreur et capturer son numero, son message et son sql_state (etat sql)


drop procedure if exists add_product;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare flag boolean default false;
    declare numero_erreur int;
    declare message_original varchar(255);
    declare sql_etat varchar(5);
    begin
		declare exit handler for sqlexception
        begin
			get diagnostics condition 1
				numero_erreur = mysql_errno,
                message_original = message_text,
                sql_etat = returned_sqlstate;
			set flag = true;
		end;
		insert into produit values (null, name, price);
	end;
    if flag then
		select concat(" le numero d'erreur est ", numero_erreur, " - l'etat sql est " , sql_etat, " le message original est " , message_original) as "erreur";
    else
		select "insertion effecutée avec succes" as "success";
    end if;
end $$
delimiter ;





select * from produit;
call add_product('scanner',1500); #1062
call add_product('souris',150); #1062
call add_product(null,150); #1048
call add_product('imprimante',-100); #3819





# on va lever l'erreur de type sql stage 23000
# liste des codes d'erreurs pour mysql
# https://www.briandunning.com/error-codes/?source=MySQL

drop procedure if exists add_product;
delimiter $$
create procedure add_product(name varchar(100), price double)
begin
	declare flag boolean default false;
    begin
		declare exit handler for sqlstate '23000' set flag = true;
		insert into produit values (null, name, price);
	end;
    if flag then
		select "erreur d'insertion , soit le produit existe ou son nom est null";
    else
		select "insertion effecutée avec succes" as "success";
    end if;
end $$
delimiter ;

select * from produit;
call add_product('scanner',1500); #sql state 23000
call add_product(null,150); #sql state 23000
call add_product('imprimante',-100); #le programme se plante parceque le sqlstate de cette erreur est "HY000"


#Exception de type not found

drop procedure if exists get_product;
delimiter $$
create procedure get_product(id int, out name varchar(100))
begin
	declare exit handler for not found select "produit introuvable" as 'erreur';
	select nom into name from produit where id_produit = id;
end $$
delimiter ;



call get_product(3,@n);
select @n;



drop procedure if exists diviser;
delimiter $$
create procedure diviser(a int, b int, out r double)
begin
	declare erreur_division condition for sqlstate '11111';
    declare exit handler for erreur_division resignal set message_text = "problème de division par zero";
	if b=0 then
		signal erreur_division;
	else
		set r = a/b;
	end if;
end $$
delimiter ;


call diviser(1,0,@r);
select @r;

