select ceiling(rand()*18);

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





-- E.	Le cheval qui a remporté le plus grand nombre de compétitions

-- F.	Les parents du cheval qui a remporté le plus grand nombre de compétitions

-- G.	Le montant total remporté par 'black' dans toutes les compétitions qu'il a remporté

-- H.	La catégorie que le cheval 'black' remporte le plus
