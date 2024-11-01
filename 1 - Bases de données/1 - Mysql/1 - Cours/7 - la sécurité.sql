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



#creation de plusieurs utilisateurs
drop user if exists u1@'localhost';
drop user if exists u2@'localhost';
drop user if exists u3@'localhost';
drop user if exists u4@'localhost';
drop user if exists u5@'localhost';

create user u1@'localhost' identified by '123456';
create user u2@'localhost' identified by '123456';
create user u3@'localhost' identified by '123456';
create user u4@'localhost' identified by '123456';
create user u5@'localhost' identified by '123456';

#creation de deux roles
drop role if exists etudiants@localhost;
drop role if exists profs@localhost;

create role etudiants@localhost;
create role profs@localhost;


#donner les droits aux roles
grant all privileges on vols_201.pilote to etudiants@localhost;
grant  select on vols_201.vol to etudiants@localhost;

grant all privileges on vols_201.* to profs@localhost;

#affecter les roles a plusieurs utilisateurs
grant etudiants@localhost to u1@localhost;
grant etudiants@localhost to u2@localhost;
grant etudiants@localhost to u3@localhost;
grant etudiants@localhost to u4@localhost;
grant etudiants@localhost to u5@localhost;


#appliquer les roles
set default role all to u1@localhost;
set default role all to u2@localhost;
set default role all to u3@localhost;
set default role all to u4@localhost;
set default role all to u5@localhost;

#ajouter d'autres priviles a un role
grant select on vols_201.avion to etudiants@localhost;


#ajouter d'autres roles a certains utilisateurs
grant profs@localhost to u4@localhost;
grant profs@localhost to u5@localhost;

#afficher les privileges d'un utilisateur
show grants for u4@localhost;

#enelver les roles de certains utilisateurs
revoke etudiants@localhost from u4@localhost;
revoke etudiants@localhost from u5@localhost;

#afficher les privileges d'un utilisateur
show grants for u4@localhost;

#rafraichir les privileges sur le serveur pour l'utilisateur en cours
flush privileges;