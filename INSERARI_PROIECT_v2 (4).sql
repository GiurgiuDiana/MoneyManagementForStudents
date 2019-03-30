#1
INSERT INTO STUDENT (id,nume,prenume,anul_de_studiu,adresa,domiciliu_temporar,buget_membru)VALUES
(1,'Cristea','IOANA',2,'str 1 Decembrie 1918','camin',600),
(2,'Giurgiu','IOANA',2,'str Gheorghe Baritiu','camin',600),
(3,'Mihai ','Eminovici',3,'str 1 decembrie 1918','camin',1230),
(4,'Vasile','Alexandra',4,'str Badulescu','apartament',1000),
(5,'Iorgulescu','Constantin',1,'str Plopilor','camin',900),
(6,'Grigorescu','Mircea',2,'str Avram Iancu ','-',300),
(7,'Radu','Mihaela',3,'str Constantei ','-',280),
(8,'Dan','Andreea',2,'str Dunarii','apartament',1100);

INSERT INTO buget (buget_initial,buget_temporar,data_initiala,data_temporala,STUDENT_id) VALUES
(600,600,'2017-10-02 08:00:00','2017-10-02 08:00:00',1),
(600,600,'2017-10-02 08:00:00','2017-10-02 08:00:00',2),
(1230,1230,'2017-10-02 08:00:00','2017-10-02 08:00:00',3),
(1000,1000,'2017-10-02 08:00:00','2017-10-02 08:00:00',4),
(900,900,'2017-10-02 08:00:00','2017-10-02 08:00:00',5),
(300,300,'2017-10-02 08:00:00','2017-10-02 08:00:00',6),
(280,280,'2017-10-02 08:00:00','2017-10-02 08:00:00',7),
(300,300,'2017-10-02 08:00:00','2017-10-02 08:00:00',8);

INSERT INTO evidenta_bani_primiti
       (data_intermediara,suma_primita,buget_nou,STUDENT_id)
       VALUES
       ('2017-10-02 08:00:00',600,600,1),
       ('2017-10-02 08:00:00',600,600,2),
       ('2017-10-02 08:00:00',1230,1230,3),
       ('2017-10-02 08:00:00',1000,1000,4),
       ('2017-10-02 08:00:00',900,900,5),
       ('2017-10-02 08:00:00',300,300,6),
       ('2017-10-02 08:00:00',200,200,7),
       ('2017-10-02 08:00:00',300,300,8);
       
#2
INSERT INTO FACULTATE(id_facultate,nume_specializare,nume_facultate,media_minima_bursa,STUDENT_id) VALUES 
(1,'Calculatoare si Tehnologia Informatiei','Automatica si Calculatoare',8,1),
(1,'Informatica Aplicata','Automatica si Calculatoare',8,2),
(2,'Inginerie Civila','Constructii',7,3),
(3,'Inginerie Medicala','Inginerie Electrica',7,4),
(4,'Robotica','Constructii de Masini',8,5),
(5,'Electronica Aplicata','Electronica si Tehnologia Informatiei',8,6),
(3,'Ingineria Instalatiilor','Instalatii',6,7),
(3,'Ingineria Instalatiilor','Instalatii',6,8);
#3
insert INTO domiciliu_temp(tip_domiciliu,plata,data_mutarii,data_plata,STUDENT_id)values
('camin',155,'2017-09-28 10:00:00','2017-09-28 10:00:00',1),
('camin',155,'2017-09-28 10:00:00','2017-09-28 10:00:00',2),
('camin',155,'2017-09-28 10:00:00','2017-09-28 10:00:00',3),
('apartament',255,'2017-09-25 12:00:00','2017-09-25 10:00:00',4),
('camin',155,'2017-09-28 10:00:00','2017-09-28 10:00:00',5),
('-',0,'1998-02-19 07:00:00',NULL,6),
('-',0,'1998-11-04 15:00:00',NULL,7),
('apartament',455,'2017-09-28 10:00:00','2017-09-28 10:00:00',8);
#4
INSERT INTO situatie_scolara(id_semestru,tip_finantare,nr_examen_r,nr_ani_examen_r,nr_laboratoare_r,STUDENT_id)VALUES
(1,'buget',0,0,0,1),
(1,'buget',0,0,0,2),
(2,'plata',1,2,0,3),
(1,'plata',2,1,1,4),
(1,'buget',0,0,0,5),
(1,'buget',0,0,0,6),
(1,'plata',1,0,1,7),
(1,'plata',2,1,1,8);
#5

INSERT INTO situatie_sociala(tip_social,STUDENT_id)VALUES
('apt',1),
('apt',2),
('apt',3),
('bolnav',4),
('orfan2',5),
('apt',6),
('bolnav',7),
('apt',8);
#6
INSERT INTO medie(media_an_anterior,media_sem1,media_sem2,situatie_scolara_id_semestru,situatie_scolara_STUDENT_id)VALUES
(9,9,0,1,1),
(9,9,0,1,2),
(7,7,5,1,3),
(5,5,0,1,4),
(0,9,0,1,5),
(9,9,0,1,6),
(9,9,0,1,7),
(5,5,0,1,8);
 INSERT INTO bursa (tip_bursa,suma_bursa,data_intrare_bursa,situatie_sociala_STUDENT_id,medie_situatie_scolara_id_semestru,medie_situatie_scolara_STUDENT_id )
 VALUES	    (NULL,NULL,'2017-09-01 10:00:00',1,9,1 ),
(NULL,NULL,'2017-09-01 10:00:00',2,9,2 ),
(NULL,NULL,'2017-09-01 10:00:00',3,7,3 ),
(NULL,NULL,'2017-09-01 10:00:00',4,5,4 ),
(NULL,NULL,'2017-09-01 10:00:00',5,0,5 ),
(NULL,NULL,'2017-09-01 10:00:00',6,9,6 ),
(NULL,NULL,'2017-09-01 10:00:00',7,9,7 ),
(NULL,NULL,'2017-09-01 10:00:00',8,5,8 );
	    
#7
#INSERT INTO cumparaturi_extra(tip_cumparaturi,plata_cumparaturi,data_c,STUDENT_id)VALUES
#('medicamente',120,'2017-09-28 14:00:00',1),
#('cumparaturi_cadouri',100,'2017-12-22 21:00:00',2),
#('playstation',120,'2017-10-05 19:00:00',3),
#('machiaj',50,'2017-10-03 21:30:00',4),
#('medicamente',20,'2017-11-28 14:00:00',5),
#('playstation',100,'2017-12-18 21:30:00',6),
#('machiaj',200,'2017-10-17 20:25:00',7),
#('patura',100,'2017-12-23 11:20:00',8);

#8 
INSERT INTO imprumuturi(id_student_cerere,id_student_imprumutor,suma_imprumutata,data_imprumut,data_returnare_imprumut)VALUES
(1,2,NULL,'2017-10-01','2017-10-01'),(4,3,NULL,'2017-10-01','2017-10-01'),(7,5,NULL,'2017-10-01','2017-10-01'),
(1,3,NULL,'2017-10-01','2017-10-01'),(4,5,NULL,'2017-10-01','2017-10-01'),(7,6,NULL,'2017-10-01','2017-10-01'),
(1,4,NULL,'2017-10-01','2017-10-01'),(4,6,NULL,'2017-10-01','2017-10-01'),(7,8,NULL,'2017-10-01','2017-10-01'),
(1,5,NULL,'2017-10-01','2017-10-01'),(4,7,NULL,'2017-10-01','2017-10-01'),(8,1,NULL,'2017-10-01','2017-10-01'),
(1,6,NULL,'2017-10-01','2017-10-01'),(4,8,NULL,'2017-10-01','2017-10-01'),(8,2,NULL,'2017-10-01','2017-10-01'),
(1,7,NULL,'2017-10-01','2017-10-01'),(5,1,NULL,'2017-10-01','2017-10-01'),(8,3,NULL,'2017-10-01','2017-10-01'),
(1,8,NULL,'2017-10-01','2017-10-01'),(5,2,NULL,'2017-10-01','2017-10-01'),(8,4,NULL,'2017-10-01','2017-10-01'),
(2,1,NULL,'2017-10-01','2017-10-01'),(5,3,NULL,'2017-10-01','2017-10-01'),(8,5,NULL,'2017-10-01','2017-10-01'),
(2,3,NULL,'2017-10-01','2017-10-01'),(5,4,NULL,'2017-10-01','2017-10-01'),(8,6,NULL,'2017-10-01','2017-10-01'),
(2,4,NULL,'2017-10-01','2017-10-01'),(5,6,NULL,'2017-10-01','2017-10-01'),(8,7,NULL,'2017-10-01','2017-10-01'),
(2,5,NULL,'2017-10-01','2017-10-01'),(5,7,NULL,'2017-10-01','2017-10-01'),
(2,6,NULL,'2017-10-01','2017-10-01'),(5,8,NULL,'2017-10-01','2017-10-01'),
(2,7,NULL,'2017-10-01','2017-10-01'),(6,1,NULL,'2017-10-01','2017-10-01'),
(2,8,NULL,'2017-10-01','2017-10-01'),(6,2,NULL,'2017-10-01','2017-10-01'),
(3,1,NULL,'2017-10-01','2017-10-01'),(6,3,NULL,'2017-10-01','2017-10-01'),
(3,2,NULL,'2017-10-01','2017-10-01'),(6,4,NULL,'2017-10-01','2017-10-01'),
(3,4,NULL,'2017-10-01','2017-10-01'),(6,5,NULL,'2017-10-01','2017-10-01'),
(3,5,NULL,'2017-10-01','2017-10-01'),(6,7,NULL,'2017-10-01','2017-10-01'),
(3,6,NULL,'2017-10-01','2017-10-01'),(6,8,NULL,'2017-10-01','2017-10-01'),
(3,7,NULL,'2017-10-01','2017-10-01'),(7,1,NULL,'2017-10-01','2017-10-01'),
(3,8,NULL,'2017-10-01','2017-10-01'),(7,2,NULL,'2017-10-01','2017-10-01'),
(4,1,NULL,'2017-10-01','2017-10-01'),(7,3,NULL,'2017-10-01','2017-10-01'),
(4,2,NULL,'2017-10-01','2017-10-01'),(7,4,NULL,'2017-10-01','2017-10-01');

#INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES 
#(2,'2017-12-11',1,15),
#(3,'2017-11-11',1,25),
#(2,'2017-11-11',1,13),
#(1,'2017-10-19',2,8),
#(1,'2017-10-22',3,19),
#(2,'2017-12-03',4,18),
#(2,'2017-10-04',5,16),
#(3,'2017-10-05',5,23),
#(3,'2017-11-21',6,40),
#(1,'2017-10-13',7,0);


#INSERT INTO transport(tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_id_semestru,situatie_scolara_STUDENT_id) VALUES 
#('microbuz',200,'2017-10-11',1,1,1),
#('microbuz',200,'2017-11-11',1,1,1),
#('autoturism',350,'2017-11-10',2,1,2),
#('mers',0,'2017-12-04',8,1,8),
#('microbuz',100,'2017-12-07',4,1,4),
#('microbuz',50,'2017-10-07',5,1,5),
#('microbuz',80,'2017-11-11',6,1,6),
#('tren',10,'2017-12-17',3,1,3),
#('autoturism',250,'2017-12-11',7,1,7);

INSERT INTO job (tip_job,data_angajare,data_salarizare,salariu_brut,STUDENT_id) VALUES 
#('part-time','2017-10-11','2017-10-15',650,1),
(NULL,NULL,NULL,NULL,2),
('part-time','2017-10-30','2017-11-30',750,3),
(NULL,NULL,NULL,0,4),
(NULL,NULL,NULL,0,5),
('full-time','2017-07-12','2017-12-12',1300,6),
(NULL,NULL,NULL,0,7);

#INSERT INTO divertisment(tip_activitate,plata_activitate,data_d,STUDENT_id) VALUES 
#('bowling',30,'2017-10-03',1),
#('film',25,'2017-11-04',2),
#('film',25,'2017-11-05',2),
#('biliard',15,'2017-12-06',3),
#('club',50,'2017-10-04',4),
#('party',80,'2017-12-15',5),
#('concert',150,'2017-11-15',6),
#('gaming',45,'2017-10-12',8),
#('gaming',45,'2017-10-12',7);
