#1.Care sunt studentii din baza de date a UTCN-ului ?
select s.id as ID,s.nume as Nume,s.prenume as Prenume ,s.anul_de_studiu as An,s.adresa as Domiciliul_Stabil from student s order by s.id asc;

#2. Care sunt sumele de bani ale studentilor la inceputul anului universitar?
select s.id AS ID,s.nume AS NUME,s.prenume as PRENUME ,b.buget_nou as BUGET from evidenta_bani_primiti b inner join student s on b.STUDENT_id=s.id where
(( year(b.data_intermediara)=2017) and (month(b.data_intermediara)=10)and (day(b.data_intermediara)=2))order by s.id asc;

#3.Care este suma totala cheltuita pe divertisment de studenti in luna octombrie?
select m.id,m.nume,m.prenume,sum(t.plata_activitate),month(data_d) as luna from student m inner join divertisment t on m.id=t.STUDENT_id
where (month(data_d)=10) group by m.id;

#4.Care este suma totala cheltuita pe mancare de studenti in luna octombrie ? 
select s.id,s.nume,s.anul_de_studiu,SUM(p.plata_mancare) from student s inner join mancare p on s.id=p.STUDENT_id where
month(p.data_m)=10 group by s.id;

#5.Care este suma totala cheltuita pe transport de studenti in luna octombrie ? 
select s.id,s.nume,s.prenume,s.anul_de_studiu,SUM(t.plata_transport) from student s inner join transport t on s.id=t.STUDENT_id where 
month(t.data_t)=10 group by s.id ;

#6.Care este suma totala cheltuita pe cumparaturi extra de studenti in luna octombrie ? 
select s.id,s.nume,s.anul_de_studiu,SUM(e.plata_cumparaturi) AS cumparaturi from student s inner join cumparaturi_extra e on s.id=e.STUDENT_id where
month(e.data_c)=10 group by s.id;

#7.Care sunt mediile studentilor la intrare in semestrul 1?
select s.id,s.nume,s.prenume,s.anul_de_studiu,m.media_an_anterior from student s inner join medie m on m.situatie_scolara_STUDENT_id=s.id ;

#8.Care e situatia sociala a fiecarui student in anul universitar 2017-2018?
select s.id,s.nume,s.prenume,s.anul_de_studiu,g.tip_social from student s inner join situatie_sociala g on g.STUDENT_id=s.id ;

#9.Care sunt mediile studentilor la intrare in semestrul 2?
select s.id,s.nume,s.prenume,s.anul_de_studiu,m.media_sem1 from student s inner join medie m on m.situatie_scolara_STUDENT_id=s.id ;

#10.Care sunt veniturile pe membru de familie ale studentilor?
select s.id,s.nume,s.prenume,s.anul_de_studiu,s.buget_membru from student s ;

#11.Cati elevi iau bursa de merit in semestrul 1 ?
select s.id,s.nume,s.prenume ,s.anul_de_studiu as an ,b.suma_bursa  from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id 
where b.tip_bursa ='bursa merit'  and b. medie_situatie_scolara_id_semestru=1 group by s.id ;

#12.Cati elevi iau in primul semestru atat bursa de merit cat si bursa sociala?
select s.id,s.nume,s.prenume,s.anul_de_studiu,b.tip_bursa from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id where 
b.tip_bursa='bursa merit+sociala';

#13.Cati elevi iau bursa sociala pe primul semestru ?
select s.id,s.nume,s.prenume ,s.anul_de_studiu as an ,b.suma_bursa  from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id 
where b.tip_bursa ='bursa sociala'  and b. medie_situatie_scolara_id_semestru=1 group by s.id ;

#14.Cati bani primesc in total studentii in luna octombrie ?
SELECT s.id, CONCAT(s.nume, ' ',s.prenume) as student,MONTH(c.data_intermediara) as luna,sum(c.suma_primita) as SumaPrimita
FROM student s INNER JOIN evidenta_bani_primiti c
 ON s.id = c.STUDENT_id  where month(c.data_intermediara)=10 group by s.id;



#astea sunt interogari nereusite :
#14.Care este suma totala pe care un student care are domiciliul permanent in Cluj o cheltuieste pe mancare,pe an ?
select s.id,s.nume,s.anul_de_studiu,SUM(m.plata_mancare) from student s inner join mancare m on s.id=m.STUDENT_id 
group by s.id;

#2.Cati dintre studenti stau la camin,in chirie si au domiciliul in orasul de studiu?
select d.tip_domiciliu as DOMICILIU, COUNT(*) as NUMAR_STUDENTI from student s inner join domiciliu_temp d on s.id=d.STUDENT_id
where (d.tip_domiciliu='camin'or d.tip_domiciliu='apartament' or d.tip_domiciliu='-') group by d.tip_domiciliu;

#5.Studentul cu id-ul 4 cheltuia vreun ban in intervalul orar 21:00-23:00 in data de 2017-10-14 ?
 # In caz,afirmativ ,sa se afiseze numele lui ,altfel,sa se afiseze tabela goala
 select s.id,s.nume,s.prenume
 from student s inner join cumparaturi_extra a on s.id=a.STUDENT_id inner join divertisment b on a.STUDENT_id=b.STUDENT_id
 inner join mancare c on b.STUDENT_id=c.STUDENT_id inner join  transport d on c.STUDENT_id=d.STUDENT_id where (s.id=4 )and
 (( a.data_c between CAST('2017-10-14 21:00:00'AS DATETIME) and CAST('2017-10-14 23:00:00' AS DATETIME))or
 ( b.data_d between CAST('2017-10-14 21:00:00'AS DATETIME) and CAST('2017-10-14 23:00:00'AS DATETIME))or
 ( c.data_m between CAST('2017-10-14 21:00:00'AS DATETIME) and CAST('2017-10-14 23:00:00'AS DATETIME))or
 ( d.data_t between CAST('2017-10-14 21:00:00'AS DATETIME) and CAST('2017-10-14 23:00:00'AS DATETIME))) group by s.id ;
 select *from student ;
 #6.S-a intamplat ca inainte de vacanta de iarna vreun student sa aiba bugetul <= 0 ?
select s.nume,s.prenume,c.buget_ramas from student s inner join evidenta_cheltuieli c on s.id=c.STUDENT_id where
 ((c.buget_ramas<-1) and (c.data_intermediara<='2017-12-23 00:00:00'));
#7.Care sunt studentii care nu si-au platit imprumuturile?
select s.id, s.nume,s.prenume,b.data_temporala,SUM(i.suma_imprumutata) as SUMA_TOTALA_IMPRUMUTATA
from student s inner join imprumuturi i on i.id_student_cerere=s.id inner join buget b on s.id=b.STUDENT_id where
b.data_temporala = i.data_imprumut group by i.STUDENT_id;
#8.Care sunt studentii care au facut imprumuturi in luna octombrie (suma totala a imprumuturilor fiecarui student) ? 
select s.id, s.nume,s.prenume,SUM(i.suma_imprumutata) as SUMA_TOTALA_IMPRUMUTATA
from student s inner join imprumuturi i on i.id_student_cerere=s.id  where
(s.id = i.STUDENT_id) and month(i.data_imprumut)=10 group by i.STUDENT_id;
#15.Cati studenti au de recuperat laboratoare in semestrul 1?
#16.Care este suma pe care studentii cu laboratoare pierdute o au de platit?
#17.Care este suma pe care o consuma in medie un student in week-end comparativ cu timpul saptamanii?
#18.Care sunt studentii penalizati pentru chiul ?
#19.Care este suma cu care au fost penalizati studentii care au chiulit la faculatate?