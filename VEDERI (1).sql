#1.Suma de bani cheltuita lunar de un student 
DROP VIEW IF EXISTS SumaCheltuitaLunar;

CREATE VIEW SumaCheltuitaLunar AS
SELECT s.id, CONCAT(s.nume, ' ',s.prenume) as student,MONTH(c.data_intermediara) as luna,sum(c.suma_cheltuita) as SumaCheltuita
FROM student s INNER JOIN evidenta_cheltuieli c
 ON s.id = c.STUDENT_id group by month(c.data_intermediara),s.id ;
 
#2.Suma de bani cheltuita de student in prima saptamana
DROP VIEW IF EXISTS SumaCheltuitaSaptamana1;
CREATE VIEW SumaCheltuitaSaptamana1 AS
SELECT s.id, CONCAT(s.nume, ' ',s.prenume) as student,sum(c.suma_cheltuita) as SumaCheltuitaSaptamana1,c.data_intermediara as data_cc
 FROM student s INNER JOIN evidenta_cheltuieli c ON s.id = c.STUDENT_id 
where (day(c.data_intermediara)>=1 and day(c.data_intermediara)<=7) and (month(c.data_intermediara)=10) group by month(c.data_intermediara),s.id ;

#3Suma de bani cheltuita pe semestrul 1 de student
DROP VIEW IF EXISTS SumaCheltuitaSemestrul1;
CREATE VIEW SumaCheltuitaSemestrul1 AS
SELECT s.id, CONCAT(s.nume, ' ',s.prenume) as student,sum(c.suma_cheltuita) as SumaCheltuitaSemestrul1,c.data_intermediara as data_cc
 FROM student s INNER JOIN evidenta_cheltuieli c ON s.id = c.STUDENT_id 
 where (month(c.data_intermediara) <=12 and year(c.data_intermediara)=2017 ) or 
	   (month(c.data_intermediara) =01 and year(c.data_intermediara)=2018 and day(c.data_intermediara)<=21) group by s.id ;

#4.Suma de bani cheltuita pe semestrul 2 de student 
DROP VIEW IF EXISTS SumaCheltuitaSemestrul2;
CREATE VIEW SumaCheltuitaSemestrul2 AS
SELECT s.id, CONCAT(s.nume, ' ',s.prenume) as student,sum(c.suma_cheltuita) as SumaCheltuitaSemestrul2,c.data_intermediara as data_cc
 FROM student s INNER JOIN evidenta_cheltuieli c ON s.id = c.STUDENT_id 
 where (month(c.data_intermediara) >=1 and year(c.data_intermediara)=2018 ) or 
	   (month(c.data_intermediara) <=7 and year(c.data_intermediara)=2018 and day(c.data_intermediara)<=8) group by s.id ;

#5.Suma de bani cheltuita pe zi de student 
DROP VIEW IF EXISTS SumaCheltuitaZilnic;

CREATE VIEW SumaCheltuitaZilnic AS
SELECT s.id, CONCAT(s.nume, ' ',s.prenume) as student,YEAR(c.data_intermediara) as anul,MONTH(c.data_intermediara) as luna,
DAY(c.data_intermediara) as ziua, sum(c.suma_cheltuita) as SumaCheltuitaInZiua
FROM student s INNER JOIN evidenta_cheltuieli c
 ON s.id = c.STUDENT_id group by day(c.data_intermediara),s.id;
 
 select *from SumaCheltuitaLunar where luna=12;
 select *from SumaCheltuitaSaptamana1 ;
 select *from SumaCheltuitaSemestrul1;
 select *from SumaCheltuitaSemestrul2;
 select *from SumaCheltuitaZilnic;

