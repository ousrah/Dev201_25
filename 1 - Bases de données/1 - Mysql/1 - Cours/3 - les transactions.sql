-- exemple gestion d'erreur

drop procedure if exists test;
delimiter $$
create procedure test(x int)
begin
	declare a smallint;
    declare exit handler for sqlexception 
    begin
		select "la valeur passée est incorrect";
    end;
	set a = x;
	select a;
end $$
delimiter ;

call test(5);

call test(55554857);




-- exemple gestion transactions
drop database if  exists bank_201;
create database if not exists bank_201 collate utf8mb4_general_ci;
use bank_201;


drop table if exists account;
create table account (
account_number varchar(50) primary key ,
funds decimal(8,2),
check (funds>=0),
check (funds<=50000));


insert into account value(1,10000);
insert into account value(2,10000);

drop procedure if exists transfert;
delimiter $$
create procedure transfert(acc1 int, acc2 int , amount double)
begin
	declare exit handler for sqlexception
    begin
       rollback;
       select ("operation annulée");
    end;
	start transaction;
		update account set funds = funds + amount where account_number = acc1;
		update account set funds = funds - amount where account_number = acc2;
	commit;
 
end $$
delimiter ;
