

select *from buget;
select *from transport;
select *from mancare;
select *from cumparaturi_extra;
select *from divertisment;
select *from evidenta_bani_primiti;

#1.Verificare daca studentul poate sa isi plateasca masa si daca datele introduse sunt corecte 
DROP TRIGGER IF EXISTS  verificare_mancare;

DELIMITER //
CREATE TRIGGER verificare_mancare BEFORE INSERT ON mancare
FOR EACH ROW BEGIN
     DECLARE buget1 int;
     DECLARE SUMA1 int;
     DECLARE buget_ramas1 int;

DECLARE data_precedenta datetime;

select MAX(m.data_m) into data_precedenta from mancare m where m.STUDENT_id = new.STUDENT_id group by m.STUDENT_id ;

	 SELECT b.buget_temporar into buget1  from buget b where  b.STUDENT_id=new.STUDENT_id ;
     SET SUMA1=(buget1-new.plata_mancare);
     
     
	IF ((SUMA1 < 0 ) or (TIMESTAMPDIFF(HOUR,NEW.data_m,data_precedenta) >= 0)) THEN
     SET new.id_masa=NULL;
     SET new.data_m= NULL;
	 SET new.STUDENT_id= NULL;
	 SET new.plata_mancare=NULL;
     else
	 UPDATE buget set buget_temporar=suma1 where STUDENT_id =new.STUDENT_id;
     UPDATE buget set data_temporala=new.data_m where STUDENT_id =new.STUDENT_id;
     SELECT b.buget_temporar into buget_ramas1 from buget b where b.STUDENT_id=new.STUDENT_id group by new.STUDENT_id;
     INSERT INTO evidenta_cheltuieli 
       (data_intermediara,suma_cheltuita,buget_ramas,STUDENT_id)
       VALUES
       (new.data_m,new.plata_mancare,buget_ramas1,new.STUDENT_id);
        
	END IF;
END //
DELIMITER ;

#INSERT INTO mancare(id_masa,data_m,STUDENT_id,plata_mancare) VALUES (2,'2018-03-11  18:00:00',1,43);
select *from evidenta_cheltuieli;
select*from mancare;
select *from buget;

#2.Verificare daca studentul poate sa isi plateasca transportul si daca datele introduse sunt corecte 
DROP TRIGGER IF EXISTS  verificare_transport;

DELIMITER //
CREATE TRIGGER verificare_transport BEFORE INSERT ON transport
FOR EACH ROW BEGIN
     DECLARE buget1 int;
     DECLARE SUMA1 int;
     DECLARE buget_ramas1 int;

DECLARE data_precedenta datetime;

select MAX(data_t) into data_precedenta from transport where new.STUDENT_id=STUDENT_id  group by STUDENT_id ;

	 SELECT b.buget_temporar into buget1  from buget b where  b.STUDENT_id=new.STUDENT_id group by new.STUDENT_id;
     SET SUMA1=(buget1-new.plata_transport);
     
     
	IF ((SUMA1 < 0 ) or (TIMESTAMPDIFF(HOUR,NEW.data_t,data_precedenta) >= 0)) THEN
     SET new.tip_transport=NULL;
     SET new.plata_transport= NULL;
	 SET new.data_t=NULL;
     else
	 UPDATE buget set buget_temporar=suma1 where STUDENT_id =new.STUDENT_id;
     UPDATE buget set data_temporala=new.data_t where STUDENT_id =new.STUDENT_id;
     SELECT b.buget_temporar into buget_ramas1 from buget b where b.STUDENT_id=new.STUDENT_id group by new.STUDENT_id;
     INSERT INTO evidenta_cheltuieli 
       (data_intermediara,suma_cheltuita,buget_ramas,STUDENT_id)
       VALUES
       (new.data_t,new.plata_transport,buget_ramas1,new.STUDENT_id);
        
	END IF;
END //
DELIMITER ;
#INSERT INTO transport(tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_STUDENT_id)
#VALUES ('autobuz',40,'2018-02-03 16:20:00',1,1);
select *from evidenta_cheltuieli;
select *from transport;

#3.Verificare daca studentul poate sa isi plateasca activitatea de divertisment si daca datele introduse sunt corecte 
DROP TRIGGER IF EXISTS  verificare_divertisment;

DELIMITER //
CREATE TRIGGER verificare_divertisment BEFORE INSERT ON divertisment
FOR EACH ROW BEGIN
     DECLARE buget1 int;
     DECLARE SUMA1 int;
     DECLARE buget_ramas1 int;

DECLARE data_precedenta datetime;

select MAX(data_d) into data_precedenta from divertisment where new.STUDENT_id=STUDENT_id  group by STUDENT_id ;

	 SELECT b.buget_temporar into buget1  from buget b where  b.STUDENT_id=new.STUDENT_id group by new.STUDENT_id;
     SET SUMA1=(buget1-new.plata_activitate);
     
     
	IF ((SUMA1 < 0 ) or (TIMESTAMPDIFF(HOUR,NEW.data_d,data_precedenta) >= 0)) THEN
     SET new.tip_activitate=NULL;
     SET new.plata_activitate= NULL;
	 SET new.data_d=NULL;
     else
	 UPDATE buget set buget_temporar=suma1 where STUDENT_id =new.STUDENT_id;
     UPDATE buget set data_temporala=new.data_d where STUDENT_id =new.STUDENT_id;
     SELECT b.buget_temporar into buget_ramas1 from buget b where b.STUDENT_id=new.STUDENT_id group by new.STUDENT_id;
     INSERT INTO evidenta_cheltuieli 
       (data_intermediara,suma_cheltuita,buget_ramas,STUDENT_id)
       VALUES
       (new.data_d,new.plata_activitate,buget_ramas1,new.STUDENT_id);
        
	END IF;
END //
DELIMITER ;

#INSERT INTO divertisment(tip_activitate,plata_activitate,data_d,STUDENT_id) VALUES ('film',24,'2018-02-02 20:00:00',1);
select *from evidenta_cheltuieli;
select*from divertisment;
select *from buget;

#4.Verificare daca studentul poate sa isi plateasca cumparaturile extra si daca datele introduse sunt corecte 
DROP TRIGGER IF EXISTS  verificare_cumparaturi_extra;

DELIMITER //
CREATE TRIGGER verificare_cumparaturi_extra BEFORE INSERT ON cumparaturi_extra
FOR EACH ROW BEGIN
     DECLARE buget1 int;
     DECLARE SUMA1 int;
     DECLARE buget_ramas1 int;

DECLARE data_precedenta datetime;

select MAX(data_c) into data_precedenta from cumparaturi_extra where new.STUDENT_id=STUDENT_id  group by STUDENT_id ;

	 SELECT b.buget_temporar into buget1  from buget b where  b.STUDENT_id=new.STUDENT_id group by new.STUDENT_id;
     SET SUMA1=(buget1-new.plata_cumparaturi);
     
	IF ((SUMA1 < 0 ) or (TIMESTAMPDIFF(HOUR,NEW.data_c,data_precedenta) >= 0)) THEN
     SET new.tip_cumparaturi=NULL;
     SET new.plata_cumparaturi= NULL;
	 SET new.data_c=NULL;
     else
	 UPDATE buget set buget_temporar=suma1 where STUDENT_id =new.STUDENT_id;
     UPDATE buget set data_temporala=new.data_c where STUDENT_id =new.STUDENT_id;
     SELECT b.buget_temporar into buget_ramas1 from buget b where b.STUDENT_id=new.STUDENT_id group by new.STUDENT_id;
     INSERT INTO evidenta_cheltuieli 
       (data_intermediara,suma_cheltuita,buget_ramas,STUDENT_id)
       VALUES
       (new.data_c,new.plata_cumparaturi,buget_ramas1,new.STUDENT_id);
	END IF;
END //
DELIMITER ;

#INSERT INTO cumparaturi_extra(tip_cumparaturi,plata_cumparaturi,data_c,STUDENT_id)VALUES('medicamente',20,'2018-02-02 15:00:00',1);
select *from evidenta_cheltuieli;
select*from cumparaturi_extra;
select *from buget;


