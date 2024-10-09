#Les instructions de controle sous mysql

# block d'instruction mysql

drop function if exists hello;
delimiter $$
create function hello()
	returns varchar(50)
    deterministic
begin
	return 'hi';
end $$
delimiter ;

select hello();

# la declaration



drop function if exists la_declaration;
delimiter $$
create function la_declaration()
	returns int
    deterministic
begin
	declare a int default 3;
    return a;
end $$
delimiter ;

select la_declaration();

drop function if exists addition;
delimiter $$
create function addition()
	returns int
    deterministic
begin
	declare a int default 3;
    declare b int default 5;
    return a + b;
end $$
delimiter ;

select addition();

# l'affectation

drop function if exists addition;
delimiter $$
create function addition()
	returns int
    deterministic
begin
	declare a,b,c int;
    set a = 3;
    set b = 5;
    set c = 8;
    return c;
end $$
delimiter ;


select addition();



drop function if exists addition;
delimiter $$
create function addition()
	returns int
    deterministic
begin
	declare a,b,c int;
    set a = 3;
    select 5 into b;
    select a+b into c;
    return c;
end $$
delimiter ;
select addition();




drop function if exists addition;
delimiter $$
create function addition()
	returns int
    deterministic
begin
	declare a,b,c int;
    set a = 3, b=5;
    select a+b into c;
    return c;
end $$
delimiter ;
select addition();





#passage de paramètres à la fonction
drop function if exists addition;
delimiter $$
create function addition(a int, b int)
	returns int
    deterministic
begin
	declare c int;
    set c = a+b;
    return c;
end $$
delimiter ;
select addition(3,5);



# les couditions


drop function if exists compare;
delimiter $$
create function compare(a int, b int)
	returns int
    deterministic
begin
	declare c int;
    if a > b then
		set c = a;
	else                       -- elseif est disponible aussi
		set c = b;
	end if;
    return c;
end $$
delimiter ;
select compare(13,5);


# exercice 1 
# ecrire une fonction qui compare troi entiers et qui affiche le plus grand
drop function if exists compare;
delimiter $$
create function compare(a int, b int,c int)
 returns int 
 deterministic
begin
	declare d int;
    if a>=b and a>=c then
		return a;
	elseif b>=a and b>=c then
		return b;
	else 
		return c;
    end if;
    
end $$
delimiter ;

select compare(1,2,3); #7 operations
select compare(1,3,2); #7 operations
select compare(3,1,2); #4 operations


drop function if exists compare;
delimiter $$
create function compare(a int, b int,c int)
 returns int 
 deterministic
begin
	declare max int;
    set max = a;
    if b>max then
		set max = b;
	end if;
	if c>max then
		return c;
	end if;
    return max;
    
end $$
delimiter ;

select compare(1,2,3); #5 operations
select compare(1,3,2); #5 operations
select compare(3,1,2); #4 operations



drop function if exists compare;
delimiter $$
create function compare(a int, b int,c int)
 returns int 
 deterministic
begin
	
    if a>b then
		if a>c then
			return a;
		else
			return c;
		end if;
	else
		if b>c then
			return b;
		else
			return c;
		end if;
	end if;
end $$
delimiter ;

select compare(1,2,3); #3 operations
select compare(1,3,2); #3 operations
select compare(3,1,2); #3 operations






#exercice 2 :
/*
un patron décide de participer aux prix de repas de ces employer 
il instaure les règles suivantes :
le pourcentage de la participation par defaut est 20% du prix de repas
si le salaire est inférieur à 2500 dh le taux est augmenté de 15%
si l'employé est marié le taux est augmenté de 5%
pour chaque enfant a charge le taux est augmenté de 10%
le plafond maximal est 60%
on souhaite ecrire une fonction qui reçoit tous les paramètres 
et qui affiche le montant de la participation selon 
le prix de repas acheté par l'employé
*/
drop function if exists participation_repas;
delimiter $$
create function participation_repas(salaire int,marie varchar(1),enfant int, prix float)
	returns float
    deterministic
begin
     declare taux float default 0.2;
	 if salaire<2500 then 
		set taux=taux+0.15;
     end if;
     if marie='o' then 
		set taux=taux+0.05;
     end if;
  	 set taux=taux+(enfant*0.1);
     if taux>0.6 then 
		set taux = 0.6;
     end if;
     return prix*taux;
end $$
delimiter ;

select participation_repas(3000,'o',0,100);

     
     
     
     
     





#exercice 3
/*
ecrire une fonction qui permet de resoudre une equation premier degrès
Ax+B=0

3x+2=0

Rappels mathématique
si A = 0 et B = 0  x = R
si A = 0 et B <> 0 x = impossible
si A <>  0 x = -b/a
*/
use courses201;
drop function if exists equation;
delimiter $$
create function equation(a int,b int)
	returns varchar(45)
    deterministic
begin
	if a = 0 and b = 0 then
		return "R";
	elseif a = 0 and b <> 0 then
		return "Impossible";
	else
		return concat('x=',-b/a);
	end if;
end $$
delimiter ;
select equation(2,0);


drop function if exists equation;
delimiter $$
create function equation(a int,b int)
	returns varchar(45)
    deterministic
begin
	if a = 0  then
		if b = 0 then
			return "R";
		else
			return "Impossible";
		end if;
	else
		return concat('x=',-b/a);
	end if;
end $$
delimiter ;
select equation(1,0);



#exercice 4
/*
ecrire une fonction qui permet de resoudre une equation deuxième degrès
Ax²+Bx+C=0
2x²+3x+0=0

Rappels mathématique
si A = 0 et B = 0 et C = 0  x1 = x2 = R
si A = 0 et B = 0  et C <> 0 x1 = x2 = impossible
si A = 0 et B <> 0  x= -c/b
si A <> 0 
	 delta  = B²-4AC
     si delta < 0 x1 = impossible
     si delta = 0 x1 = x2 = -b/2a
      si delta > 0 x1 = (-b-racine(delta))/2a  et x2 =  (-b+racine(delta))/2a   
    */


drop function if exists equation1;
delimiter $$
create function equation1(a int,b int,c int)
returns varchar(255)
deterministic
begin
    declare d float ;
	if a=0 and b=0 and c=0 then
		   return "x1=x2=R";
	end if;
	if a=0 and b=0 and c<>0 then
           return "Impossible";
	end if;
	if a=0 and b<>0 then
		   return -c/b;
	end if;
    if a<>0  then
        select b*b-4*a*c into d;
		if d<0 then
           return "impossible";
		else if d=0 then
           return -b/2*a;
		else
           return concat("x1=" ,(-b-sqrt(d))/2*a ,",x2=", (-b+sqrt(d))/2*a);
		end if;
        end if;
	end if;

end $$
delimiter ;
select equation1(0,0,0);
select equation1(0,0,1);
select equation1(0,1,2);
select equation1(2,3,1);
select equation1(3,2,1);
select equation1(4,4,1);



drop function if exists equation1;
delimiter $$
create function equation1(a int,b int,c int)
returns varchar(255)
deterministic
begin
    declare d float ;
	if a=0 then
		if b=0 then
			if c=0 then
				return "x1=x2=R";
			else
	           return "Impossible";
			end if;
		else
		   return -c/b;
		end if;
    else
        select b*b-4*a*c into d;
		if d<0 then
           return "impossible dans R";
		elseif d=0 then
           return concat ("x1=x2=",-b/2*a);
		else
           return concat("x1=" ,(-b-sqrt(d))/2*a ,",x2=", (-b+sqrt(d))/2*a);
		end if;
	end if;

end $$
delimiter ;
select equation1(0,0,0);
select equation1(0,0,1);
select equation1(0,1,2);
select equation1(2,3,1);
select equation1(3,2,1);
select equation1(4,4,1);


/*
exercice 
on souhaite ecrire une fonction qui reçoit le numéro d'une journée et qui affiche son nom en arabe
*/

drop function if exists numJournee;
delimiter $$
create function numJournee(num int)
	returns varchar(50)
	deterministic
begin
	if num = 1 then
		return 'الأحد';
    elseif num = 2 then
		return 'الإثنين';
    elseif num = 3 then
		return 'الثلاثاء';
    elseif num = 4 then
		return 'الأربعاء';
    elseif num = 5 then
		return 'الخميس';
    elseif num = 6 then
		return 'الجمعة';
    elseif num = 7 then
		return 'السبت';
	end if;
end $$
delimiter ;




drop function if exists numJournee;
delimiter $$
create function numJournee(num int)
	returns varchar(50)
	deterministic
begin
	declare jour varchar(50);
	set jour = case 
		when num = 1 then 		 'الأحد'
		when num = 2 then		 'الإثنين'
		when num = 3 then		 'الثلاثاء'
		when num = 4 then		 'الأربعاء'
		when num = 5 then		 'الخميس'
		when num = 6 then		 'الخميس'
		when num = 7 then		 'السبت'
		else					 'Erreur'
	end  ;
    return jour;
end $$
delimiter ;





drop function if exists numJournee;
delimiter $$
create function numJournee(num int)
	returns varchar(50)
	deterministic
begin
	declare jour varchar(50);
	set jour = case num
		when 1 then 	 'الأحد'
		when 2 then		 'الإثنين'
		when 3 then		 'الثلاثاء'
		when 4 then		 'الأربعاء'
		when 5 then		 'الخميس'
		when 6 then		 'الخميس'
        when 7 then		 'السبت'
		else			 'Erreur'
	end  ;
    return jour;
end $$
delimiter ;



select numJournee(10);




# utilisation de case dans la resolution de l'equation deuxième degrès.

drop function if exists equation1;
delimiter $$
create function equation1(a int,b int,c int)
returns varchar(255)
deterministic
begin
    declare d float ;
    declare r varchar(50);
	if a=0 then
		if b=0 then
			if c=0 then
				set r =  "x1=x2=R";
			else
	           set r =   "Impossible";
			end if;
		else
		   set r =   -c/b;
		end if;
    else
        select b*b-4*a*c into d;
        set r = case 
		when d<0 then
             "impossible dans R"
		when d=0 then
           concat ("x1=x2=",-b/2*a)
		else
            concat("x1=" ,(-b-sqrt(d))/2*a ,",x2=", (-b+sqrt(d))/2*a)
		end ;
	end if;
	return r;
end $$
delimiter ;
select equation1(0,0,0);
select equation1(0,0,1);
select equation1(0,1,2);
select equation1(2,3,1);
select equation1(3,2,1);
select equation1(4,4,1);

# les boucles
#ecrire une fonction qui calcule la somme des n premier entier


# avec la boucle while
drop function if exists somme;
delimiter $$
create function somme (n int)
	returns bigint
    deterministic
begin
	declare s bigint default 0;
	declare i int default 1;
    while i<=n do
		set s = s + i;
        set i = i+1;
    end while;
	return s;
end $$
delimiter ;

select somme(3);


#avec la boucle repeat
drop function if exists somme;
delimiter $$
create function somme(n int)
	returns bigint
    deterministic
begin
	declare s bigint default 0;
    declare i int default 0;
    repeat
		set s = s + i;
        set i = i + 1;
	until i>n end repeat;
	return s;
end $$
delimiter ;

select somme(3);


# avec la boucle loop


drop function if exists somme;
delimiter $$
create function somme(n int)
	returns bigint
    deterministic
begin
	declare s bigint default 0;
    declare i int default 0;
	b1: loop
			set s = s + i;
			set i = i + 1;
			if i>n then
				leave b1;
			end if;
		end loop;
	return s;
end $$
delimiter ;

select somme(0);


# ecrire un fonction qui calcule la somme des n premier entiers 
# paires en utilisant les trois formes de boucles mysql while, repeat et loop
drop function if exists somme1;
delimiter // 
create function somme1(n  int ) 
	returns int 
    deterministic 

begin 
	declare s int default 0 ; 
    declare i int default 1 ;
    while i <= n do 
		if i%2 = 0 then 
			set s = s + i ;
		end if ; 
        set i = i + 1 ; 
		end while ;
        return s ; 
end //

delimiter ; 

select somme1(4);


drop function if exists somme1;
delimiter // 
create function somme1(n  int ) 
	returns int 
    deterministic 

begin 
	declare s int default 0 ; 
    declare i int default 1 ;
    repeat 
		if i%2 = 0 then 
			set s = s + i ;
		end if ; 
        set i = i + 1 ; 
		until i>n end repeat;
        return s ; 
end //

delimiter ; 
select somme1(1);
drop function if exists somme1;
delimiter // 
create function somme1(n int ) 
	returns int 
    deterministic 
begin 
	declare s int default 0 ;  
    declare i int default 1 ; 
    l:loop
		if i%2 = 0 then 
			set s = s + i ;
		end if ; 
        set i = i + 1 ; 
        if i>n then
			leave l;
        end if;
	end loop;
    return s ; 
end //

delimiter ; 
select somme1(0);




# ecrire une fonction qui calcule le factoriel d'un entier positif
/*rappel 5! = 5x4x3x2
		4! = 4x3x2
        1! = 1
        0! = 1*/
use courses201;
drop function if exists facto;
delimiter &&
create function facto(n int)
	returns double 
    deterministic
begin 
	declare s double default 1;
    declare i int default 2;
    while i<=n do
		set s=s*i;
        set i=i+1;
	end while;
    return s;
end &&
delimiter ;

select facto(0);
select facto(1);
select facto(4);
select facto(5);
select facto(170);







# les variables globales
select 3 into @c;
select @c;


select dotation into @d from session where id_session=1;
select @d;

#les fonctions

drop function if exists getDotation;
delimiter $$
create function getDotation(id int)
	returns float
	reads sql data
begin
	declare d float;
	select dotation into d from session where id_session = id;
    return d;
end $$
delimiter ;

select getDotation(1);





#les procedures stockées

# les tables temporaires

# les triggers (les declencheurs)

# la gestion des erreurs

# les transactions

# les curseurs

# la gestion des utilisateurs

# la sauvegarde et la restauration