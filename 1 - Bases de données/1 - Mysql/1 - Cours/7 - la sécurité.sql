#gestion des utilisateurs et des droits
#Suppressiond d'un utilisateur existant
drop user if exists 'yousra'@'localhost';

#creation d'un utilisation avec spécification du mot de passe
create user 'yousra'@'localhost' identified by '123456';

#attribuer tous les droits sur tous les objets de la base de données cuisine_201 à l'utilisateur
grant all privileges on cuisine_201.* to 'yousra'@'localhost';

#attribuer tous les droits sur la table pilote  à l'utilisateur
grant all privileges on vols_201.pilote to 'yousra'@'localhost';

#attribuer la selection sur la table avion  à l'utilisateur
grant select on vols_201.avion  to 'yousra'@'localhost';

#attribuer l'insertion et la modification sur la table avion  à l'utilisateur
grant insert, update on vols_201.avion  to 'yousra'@'localhost';

#afficher tous les droits de l'utilisateur
show grants for  'yousra'@'localhost';

#Enlever les droits insert et update sur la table avion à l'utilisateur
revoke insert, update on vols_201.avion  from 'yousra'@'localhost';

#afficher tous les droits de l'utilisateur
show grants for  'yousra'@'localhost';

#l'utilisateur ne peut voir que les champs villed et villea de la table vol
grant select(villed, villea) on vols_201.vol  to 'yousra'@'localhost';

#l'utilisateur ne peut modifier que les champs villed et villea de la table vol
grant update(villed, villea) on vols_201.vol  to 'yousra'@'localhost';


#modifier le mot de passe de l'utilisatrice yousra
set password for 'yousra'@'localhost' = "abcdefg";

