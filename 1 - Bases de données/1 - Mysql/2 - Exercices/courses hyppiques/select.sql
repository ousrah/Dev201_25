select ceiling(rand()*18);
use courses201;
-- A.	la liste de tous les chevaux.

select * from cheval;

-- B.	la liste des champs qui peuvent acceuillir la catégorie "trot attelé"

/*  avec join using */
select champ.* from champ 
join adapte using(id_champ) 
join categorie using(id_categorie) 
where nom_categorie="trot attelé";


/*  avec les sous requettes enembliste */
select * from champ where id_champ in( 	select id_champ 
										from adapte 
                                        where id_categorie in ( select id_categorie 
																from categorie 
                                                                where nom_categorie="trot attelé")
									  );
/*  avec with */
with cat as( select id_champ from adapte join categorie using(id_categorie)
                   where nom_categorie="trot attelé" )

select * from champ join cat using(id_champ);


/* methode du produit cartésien a éviter si on a une autre solution */

select ch.* 
from champ ch, adapte ad,  categorie ca
where ch.id_champ = ad.id_champ
and ad.id_categorie = ca.id_categorie
and nom_categorie = 'trot attelé';
     


select * from cheval join proprietaire using(id_proprietaire);



-- C.	la liste des cheveaux qui participent a la course "prix d'amérique" de la session 'Mars 2024' triés par classement
select cheval.*,classement from cheval
join participe using (id_cheval)
join session using(id_session)
join course using (id_course)
where nom_session= 'Mars 2024'
and designation like "Prix d_Amérique"
order by classement asc;



select cheval.*, classement
from cheval join participe using(id_cheval)
where id_session in
			(select id_session 
			 from session 
			 where nom_session = 'Mars 2024' 
			 and id_course in
							(select id_course 
							 from course 
							 where designation 
							 like "Prix d_Amérique" )
			)
order by classement asc;
		
        
with ses as (select id_session 
			 from session 
			 where nom_session = 'Mars 2024' 
			 and id_course in
							(select id_course 
							 from course 
							 where designation 
							 like "Prix d_Amérique" )
			)    
            
select cheval.*, classement
from cheval join participe using(id_cheval)
			join ses using(id_session)
order by classement asc;

-- D.	la liste des jockeys qui ont monté le cheval "black" durant tout son historique

select  distinct jockey.id_jockey, nom_jockey,prenom_jockey
from jockey
			join participe using (id_jockey)
			join cheval using (id_cheval)
where nom_cheval ='black';


select jockey.id_jockey, nom_jockey,prenom_jockey
from jockey 
where id_jockey in ( select distinct id_jockey 
					from participe 
                    where id_cheval in (select id_cheval 
										from cheval 
                                        where nom_cheval = "black ")
					);

with j as (select distinct id_jockey 
					from participe 
                    where id_cheval in (select id_cheval 
										from cheval 
                                        where nom_cheval = "black "))
select jockey.* from jockey join j using (id_jockey);

-- E.	Le cheval qui a remporté le plus grand nombre de compétitions

with t1 as (select id_cheval, count(classement) as nb from participe
where classement = 1
group by id_cheval),
t2 as (select max(nb) as nb from t1)
select cheval.* 
	from cheval  join t1 using(id_cheval) 
    join t2 using(nb) ;
 


-- F.	Les parents du cheval qui a remporté le plus grand nombre de compétitions

-- tout d'abord je vais faire une requtte qui permet de recupérer les parents de n'importe quel cheval

select fils.id_cheval as id_cheval, fils.nom_cheval as nom_fils, pere.id_cheval as id_parent, pere.nom_cheval as nom_parent
from cheval fils join parent using (id_cheval)
join cheval pere on parent.id_parent = pere.id_cheval
where fils.id_cheval = 1;

-- je vais chercher a faire un lien entre la dernière quette et celle qui permet de récuprer le cheval qui a remporté le plus grand nombre de competitions.

with t1 as (select id_cheval, count(classement) as nb from participe
where classement = 1
group by id_cheval),
t2 as (select max(nb) as nb from t1)
select fils.id_cheval as id_cheval, fils.nom_cheval as nom_fils, pere.id_cheval as id_parent, pere.nom_cheval as nom_parent
from cheval fils join parent using (id_cheval)
join cheval pere on parent.id_parent = pere.id_cheval
join t1  on fils.id_cheval = t1.id_cheval
join t2 using (nb)
;



-- G.	Le montant total remporté par 'black' dans toutes les compétitions qu'il a remporté


select sum(dotation) from participe 
join cheval using (id_cheval) 
join session using(id_session)
where nom_cheval = 'black' and classement = 1
;


-- H.	La catégorie que le cheval 'black' remporte le plus
with t1 as (
			select nom_categorie, count(id_categorie) nb from
			cheval join participe using (id_cheval)
			join session using(id_session)
			join course using(id_course)
			join categorie using (id_categorie)
			where nom_cheval = 'black'
			and classement = 1
			group by nom_categorie
            ),
t2 as		(
				select max(nb) nb from t1
			) 
select * from t1 join t2 using (nb);




