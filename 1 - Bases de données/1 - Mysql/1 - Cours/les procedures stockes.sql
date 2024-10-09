use employes_201;


drop procedure if exists p1;
delimiter $$
create procedure p1()
begin
	select * from employe;
	select * from departement;
	select E4Q8(1);
end $$
delimiter ;


call p1;


drop procedure if exists somme;
delimiter $$
create procedure somme()
begin
	declare a int default 3;
    declare b int default 5;
    declare c int;
    set c = a+b;
	select c;
end $$
delimiter ;


call somme;



drop procedure if exists somme;
delimiter $$
create procedure somme(a int, b int)
begin
    declare c int;
    set c = a+b;
	select c;
end $$
delimiter ;


call somme(5,8);




drop procedure if exists somme;
delimiter $$
create procedure somme(a int, b int, out addition int, out mult int )
begin
    set addition = a+b;
    set mult = a*b;
end $$
delimiter ;


call somme(5,8,@a, @m);
select @a, @m;



