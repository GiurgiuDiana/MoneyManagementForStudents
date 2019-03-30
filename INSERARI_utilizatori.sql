INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  16:40:00',1,43);
INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  18:00:00',2,40);
INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  19:00:00',3,20);
INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  15:00:00',4,15);
INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  16:30:00',5,19);
INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  18:45:00',6,17);
INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  17:21:00',7,25);
INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2017-10-03  16:30:00',8,23);


INSERT INTO transport(tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_STUDENT_id)VALUES ('autobuz',40,'2017-10-06 16:20:00',2,2);
INSERT INTO transport(tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_STUDENT_id)VALUES ('autobuz',40,'2017-10-13 16:20:00',2,2);
INSERT INTO transport(tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_STUDENT_id)VALUES ('autoturism personal',50,'2017-10-03 09:50:00',3,3);
INSERT INTO transport(tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_STUDENT_id)VALUES ('autobuz',15,'2017-10-04 09:10:00',6,6);
INSERT INTO transport(tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_STUDENT_id)VALUES ('autobuz',17,'2017-10-14 16:20:00',6,6);

INSERT INTO divertisment(tip_activitate,plata_activitate,data_d,STUDENT_id) VALUES ('film',24,'2017-10-04 21:00:00',1);
INSERT INTO divertisment(tip_activitate,plata_activitate,data_d,STUDENT_id) VALUES ('film',24,'2017-10-03 21:00:00',2);
INSERT INTO divertisment(tip_activitate,plata_activitate,data_d,STUDENT_id) VALUES ('gaming',10,'2017-10-08 20:00:00',1);
INSERT INTO divertisment(tip_activitate,plata_activitate,data_d,STUDENT_id) VALUES ('party',40,'2017-10-07 23:00:00',5);
INSERT INTO divertisment(tip_activitate,plata_activitate,data_d,STUDENT_id) VALUES ('film',24,'2017-10-08 20:00:00',5);

INSERT INTO cumparaturi_extra(tip_cumparaturi,plata_cumparaturi,data_c,STUDENT_id)VALUES('medicamente',20,'2018-02-02 15:00:00',1);

select *from buget;
select *from transport;
select *from mancare;
select *from cumparaturi_extra;
select *from divertisment;
select *from evidenta_cheltuieli;