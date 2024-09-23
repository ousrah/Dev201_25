

insert into type values (1,'appartement'),(2,'villa'),(3,'garage'),(4,'maison'),(5,'duplex');
insert into ville values (1,'tetouan'),(2,'martil'),(3,'m''diq'),(4,'tanger'),(5,'larache');
insert into quartier values (1,'saniat rmel',1),(2,'touilaa',1),(3,'soukna wa taamir',1),(4,'chbar',2),(5,'diza',2);
insert into client (id_client, nom_client, prenom_client,telephone,adresse) values 
							(1,'mohamed','mohamed','01','av3'),
							(2,'marchoud','ali','02','av2'),
                            (3,'youssef','youssef','03', 'av3'),
                            (4,'khalid','khalid','04','av4'),
                            (5,'amina','amina','05','av5');
insert into bien (reference, superficie,nb_pieces,loyer,id_client,id_type,id_quartier) values 
					(1,80,3,1800,1,1,1),
                    (2,120,5,2500,1,2,3),
                    (3,50,2,1100,1,1,1),
                    (4,90,4,2000,1,1,3),
                    (5,70,3,1900,1,2,3);
insert into bien values (null,70,3,1800,1,1,4), (null,70,3,1500,1,1,5);
insert into contrat values 
					(1,'2024-09-05','2024-09-05',null,150,1800,1,2),
                    (2,'2024-07-05','2024-07-05',null,150,2400,2,1),
                    (3,'2023-09-05','2023-09-05','2023-12-30',150,1100,3,3),
                    (4,'2024-01-05','2024-01-05',null,150,1100,3,4),
                    (5,'2024-08-05','2024-08-05',null,150,2500,2,5),
                    (6,'2024-09-01','2024-09-01',null,150,1800,1,1),
                    (7,'2022-04-05','2022-04-05','2023-04-05',150,1900,4,2),
                    (8,'2021-02-05','2021-02-05','2023-01-01',150,1800,5,3),
                    (9,'2024-08-05','2024-08-05',null,150,1900,5,4),
                    (10,'2024-09-01','2024-09-01',null,150,2400,2,5);
                    

