

#########################################################
CALL imprumut(1,6,30,'2017-10-11 12:12:00');            #
select * from imprumuturi;
select *from buget;
select *from evidenta_cheltuieli ;
select *from evidenta_bani_primiti;
CALL restituire_imprumut(1,2,'2017-11-11 13:50:00');  # fara schimbari de data 
#CALL imprumut(3,4,15,'2017-12-04 13:53:07');            #
#CALL imprumut(1,4,30,'2017-11-11 02:43:50');            #
#CALL imprumut(7,8,2,'2017-12-05 09:55:14');  
#CALL imprumut(7,8,8,'2017-12-06 12:21:50');             #
#########################################################
#select *from student where id=7;

#########################################################
#CALL restituire_imprumut(1,4,'2017-11-12 14:50:00');    #
#CALL restituire_imprumut(3,4,'2017-12-17 12:40:00');    #
#CALL restituire_imprumut(1,2,'2017-11-12 14:55:00');    #
#########################################################
#select * from imprumuturi;
#CALL burse_de_merit(1,NULL,5 ) ;
#select *from bursa where medie_situatie_scolara_STUDENT_id=5 ;
CALL burse_de_merit(1,'2018-01-30 10:20:00',1 );
CALL burse_de_merit(1,'2017-12-30 10:20:00',2 );
CALL burse_de_merit(1,'2018-01-30 10:20:00',3 );
CALL burse_de_merit(1,'2017-12-30 10:20:00',4 );
CALL burse_de_merit(1,'2017-12-30 10:20:00',5 );
CALL burse_de_merit(1,'2017-12-30 10:20:00',6 );
CALL burse_de_merit(1,'2017-12-30 10:20:00',7 );
CALL burse_de_merit(1,'2017-12-30 10:20:00',8 );


CALL burse_sociale(1,'2017-12-30 10:20:00',1);
CALL burse_sociale(1,'2017-12-30 10:20:00',2);
CALL burse_sociale(1,'2017-12-30 10:20:00',3);
CALL burse_sociale(1,'2017-12-30 10:20:00',4);
CALL burse_sociale(1,'2017-12-30 10:20:00',5);
CALL burse_sociale(1,'2017-11-30 10:20:00',6);
CALL burse_sociale(1,'2017-12-30 10:20:00',7);
CALL burse_sociale(1,'2017-12-30 10:20:00',8);


CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',1 );
CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',2 );
CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',3 );
CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',4 );
CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',5 );
CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',6 );
CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',7 );
CALL burse_de_merit_sociale(1,'2018-03-30 10:20:00',8 );
select * from bursa;
select *from buget;
select *from evidenta_cheltuieli ;
CALL adaugare_buget_lunar(800,'2017-10-02 08:00:00',1);

