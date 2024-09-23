
use location_201B;

select ceiling(rand()*18) as student;
-- A.	La liste des bien de type ‘villa’

-- methode 1 - avec jointure on
select b.* ,t.nom_type
from bien b join type t  on b.id_type=t.id_type
where nom_type='villa';

-- methode 2 - avec jointure using
select b.* ,t.nom_type
from bien b join type t  using (id_type)
where nom_type='villa';


-- methode 3 ensembliste (sous requettes)
select * 
from bien 
where id_type in (	select id_type 
					from type 
                    where nom_type = 'villa');


-- methode 4 jointure avec with
with lists_des_biens as (select id_type from type
						where nom_type='villa'
						)
select * 
from bien join lists_des_biens using(id_type);


-- B.	La liste des appartements qui se trouve à Tétouan

select b.* 
from bien b
join quartier q on b.id_quartier = q.id_quartier
join ville v on v.id_ville = q.id_ville
join type t on b.id_type=t.id_type
where nom_type='appartement' 
AND  nom_ville = 'tetouan' ;

select bien.* 
from bien 
join quartier using (id_quartier)
join ville using (id_ville) 
join type using (id_type)
where nom_type='appartement' 
AND  nom_ville = 'tetouan' ;


select * 
from bien 
where id_type in (	select id_type 
					from type 
                    where nom_type = 'appartement')
and id_quartier in (select id_quartier 
					from quartier 
                    where id_ville in (select id_ville 
										from ville 
                                        where nom_ville='tetouan')
					)
;
          
          
-- methode  4  jointure avec l'insctruction with         
with a as  (select id_type 
					from type 
                    where nom_type = 'appartement'),   
q  as (select id_quartier from quartier 
                    where id_ville in (select id_ville 
										from ville 
                                        where nom_ville='tetouan'))        
select * 
from bien 
join a using(id_type)
join q using(id_quartier);



           
-- C.	La liste des appartements loués par M. Marchoud Ali

select bien.*  
from bien 
join contrat using (reference)
join type using (id_type)
join client on client.id_client = contrat.id_client
where nom_type='appartement' 
AND  prenom_client='ali' and nom_client='marchoud';


select * from bien
where id_type in (select id_type from type where nom_type = 'appartement')
and reference in (select reference 
					from contrat 
                    where id_client in (select id_client 
										from client 
                                        where nom_client='marchoud' and prenom_client ='ali')
					);
                    
                    
with t as (select id_type from type where nom_type = 'appartement'),
c as (select reference 
					from contrat 
                    where id_client in (select id_client 
										from client 
                                        where nom_client='marchoud' and prenom_client ='ali'))   
select * from bien join t using(id_type)
join c using(reference);								

-- D.	Le nombre des appartements loués dans le mois en cours
select COUNT(*) as nb_appartements 
from contrat 
join bien using(reference) 
join type using(id_type) 
where nom_type="appartement" 
and month(date_creation)=month(curdate()) 
and year(date_creation)=year(curdate());

-- E.	Les appartements disponibles actuellement à Martil 
-- dont le loyer est inférieur à 2000 DH 
-- triés du moins chère au plus chère

select *
from bien join quartier q on bien.id_quartier = q.id_quartier
join ville v on v.id_ville = q.id_ville
join type t on bien.id_type=t.id_type 
left join contrat using(reference)
where nom_type='appartement' 
AND  nom_ville = 'Martil' 
and bien.loyer < 2000 
and (id_contrat is null or date_sortie < curdate())
order By bien.loyer ASC;



select *
from bien join quartier q on bien.id_quartier = q.id_quartier
join ville v on v.id_ville = q.id_ville
join type t on bien.id_type=t.id_type 
where nom_type='appartement' 
AND  nom_ville = 'Martil' 
and bien.loyer < 2000 
and (
reference not in(select distinct reference from contrat)
or
reference in (select reference from contrat where date_sortie < curdate())
)
order By bien.loyer ASC;

-- F.	La liste des biens qui n’ont jamais été loués
select bien.* from bien
	where reference not in (select distinct reference from contrat);

select bien.*
from bien left join contrat using(reference)
where id_contrat is null;

-- G.	La somme des loyers du mois en cours
select sum(loyer) as somme from contrat
where date_sortie>curdate() or date_sortie is null;








