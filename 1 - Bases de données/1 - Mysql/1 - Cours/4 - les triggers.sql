drop database if exists ventes_201;
create database ventes_201 collate utf8mb4_general_ci;
use ventes_201;

create table produit(
id_produit int auto_increment primary key,
nom varchar(100),
prix double,
stock int,
check (stock >=0));


create table vente(
id_vente int auto_increment primary key,
date_vente date,
qte int,
id_produit int ,
constraint fk_vente_produit foreign key (id_produit) references produit(id_produit) on delete cascade on update cascade);


INSERT INTO produit (nom, prix, stock) VALUES
('pc', 19.99, 100),
('imprimance', 9.99, 50),
('clavier', 29.99, 200),
('Produit 4', 14.99, 80),
('Produit 5', 24.99, 60),
('Produit 6', 39.99, 120),
('Produit 7', 49.99, 30),
('Produit 8', 34.99, 90),
('Produit 9', 59.99, 15),
('Produit 10', 12.99, 70);


-- declencheur d'insertion


drop trigger if exists insert_vente;
delimiter $$
create trigger insert_vente after insert on vente for each row
begin
	update produit set stock = stock - (new.qte) where id_produit = new.id_produit;
end $$
delimiter ;

insert into vente values (null, curdate(),54,1);


-- declencheur de suppression


drop trigger if exists suppression_vente;
delimiter $$
create trigger suppression_vente after delete on vente for each row
begin
	update produit set stock = stock + (old.qte) where id_produit = old.id_produit;
end $$
delimiter ;

delete from vente where id_vente = 1;


-- declencheur de mofidification

drop trigger if exists update_vente;
delimiter $$
create trigger update_vente after update on vente for each row
begin
	update produit set stock = stock + old.qte - new.qte where id_produit = old.id_produit;
 end $$
delimiter ;



select * from vente;
select * from produit;

update vente set qte = 30 where id_vente = 4;
