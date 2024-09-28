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

select participation_repas(3000,'o',0,100)

     
     
     
     
     





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


# les boucles




#les fonctions


#les procedures stockées

# les tables temporaires

# les triggers (les declencheurs)

# la gestion des erreurs

# les transactions

# les curseurs

# la gestion des utilisateurs

# la sauvegarde et la restauration