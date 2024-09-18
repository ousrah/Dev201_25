-- methode 1
-- methode avec relation externes

drop database if exists location_201;
create database location_201 collate utf8mb4_general_ci;
use location_201;

create table ville (
				id int auto_increment primary key,
                nom varchar(50) not null
				);
                
create table contrat (
				id int auto_increment primary key,
                date_creation date not null,
                date_entree date,
                date_sortie date,
                charges float,
                loyer float,
                id_client int not null,
                reference int not null
				);
create table quartier (
				id int auto_increment primary key,
                nom varchar(50) not null,
                id_ville int not null
				);
create table type (
				id int auto_increment primary key,
                nom varchar(50) not null
				);
create table client(
				id int auto_increment primary key,
				nom varchar(50) not null,
				prenom varchar(50), 
				adresse varchar(150),
				telephone varchar(20)
				);
create table bien (
				reference int auto_increment primary key,
				superficie float not null,
				nb_pieces smallint not null,
				loyer float,
				id_type int not null,
				id_client int not null,
				id_quartier int not null
				);

alter table quartier add constraint fk_quartier_ville foreign key (id_ville) references ville(id);

alter table bien add constraint fk_bien_quartier foreign key (id_quartier) references quartier(id);
alter table bien add constraint fk_bien_type foreign key (id_type) references type(id);
alter table bien add constraint fk_bien_client foreign key (id_client) references client(id);


alter table contrat add constraint fk_contrat_bien foreign key (reference) references bien(reference);
alter table contrat add constraint fk_contrat_client foreign key (id_client) references client(id);




-- methode 2
-- methode avec relation internes

drop database if exists location_201B;
create database location_201B collate utf8mb4_general_ci;
use location_201B;

create table ville (
				id int auto_increment primary key,
                nom varchar(50) not null
				);
create table type (
				id int auto_increment primary key,
                nom varchar(50) not null
				);
create table client(
				id int auto_increment primary key,
				nom varchar(50) not null,
				prenom varchar(50), 
				adresse varchar(150),
				telephone varchar(20)
				);
create table quartier (
				id int auto_increment primary key,
                nom varchar(50) not null,
                id_ville int not null,
                constraint fk_quartier_ville foreign key (id_ville) references ville(id)
				);

create table bien (
				reference int auto_increment primary key,
				superficie float not null,
				nb_pieces smallint not null,
				loyer float,
				id_type int not null,
				id_client int not null,
				id_quartier int not null,
                constraint fk_bien_type foreign key (id_type) references type(id),
                constraint fk_bien_client foreign key (id_client) references client(id),
                constraint fk_bien_quartier foreign key (id_quartier) references quartier(id)
				);                
create table contrat (
				id int auto_increment primary key,
                date_creation date not null,
                date_entree date,
                date_sortie date,
                charges float,
                loyer float,
                id_client int not null,
                reference int not null,
                 constraint fk_contrat_client foreign key (id_client) references client(id),
                  constraint fk_contrat_bien foreign key (reference) references bien(reference)
				);



