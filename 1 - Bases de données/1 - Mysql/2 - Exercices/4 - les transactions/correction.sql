drop database if exists salles_201;
create database salles_201 collate utf8mb4_general_ci;
use salles_201;


create table Salle (
	NumSalle int primary key, 
    Etage int, 
    NombreChaises int,
    check (NombreChaises between 20 and 30)
    );
    
create table Transfert (
	NumSalleOrigine int, 
    NumSalleDestination int, 
    DateTransfert date, 
    NbChaisesTransferees int, 
	constraint fk_salleOrigine foreign key (NumSalleOrigine) references Salle (NumSalle) on delete cascade on update cascade,
	constraint fk_salleDestination foreign key (NumSalleDestination) references Salle (NumSalle) on delete cascade on update cascade
);

insert into salle values 
(1,	1,	24),
(2,	1,	26),
(3,	1,	26),
(4,	2,	28);
  
  
  
drop procedure if exists transf;
delimiter $$
create procedure transf(SalleOrigine int ,SalleDest int,NbChaises int,dateTransfert date)
begin
declare exit handler for sqlexception
	begin
		select "Impossible d’effectuer le transfert des chaises" as "erreur";
        rollback;
	end;
	start transaction;
		update salle set NombreChaises = NombreChaises - NbChaises Where NumSalle = SalleOrigine;
		update salle set NombreChaises = NombreChaises + NbChaises Where NumSalle = SalleDest;
		insert into Transfert values (SalleOrigine , SalleDest, dateTransfert , NbChaises);
	commit;
end $$
delimiter ;

call transf(2,3,4,curdate());
call transf(2,3,1,curdate());

select * from salle;
select * from transfert;

