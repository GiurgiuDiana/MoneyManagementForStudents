##################################################################################################################################################
#1.Imprumuturi intre studenti
DROP PROCEDURE IF EXISTS imprumut;
DELIMITER //

CREATE PROCEDURE imprumut (_id_student_cerere int,_id_student_imprumutor int,_suma_imprumutata int,_data_imprumut datetime)
  BEGIN
    START TRANSACTION;
       SET @ID_D1 = NULL;
       SET @ID_D2 = NULL;
       
       SELECT @ID_D1 := ID FROM student WHERE ID=_id_student_cerere;
       SELECT @ID_D2 := ID FROM student WHERE ID=_id_student_imprumutor;
	    
	   SET @data_precedenta=NULL;

      select @data_precedenta := MAX(data_imprumut)  from imprumuturi  where id_student_cerere=_id_student_cerere and 
      id_student_imprumutor=_id_student_imprumutor group by id_student_cerere,id_student_imprumutor ;
       IF(@ID_D1 IS NOT NULL) THEN 	
	 BEGIN
	 IF TIMESTAMPDIFF(hour, _data_imprumut,@data_precedenta) < 0 THEN
	   INSERT INTO imprumuturi
	    (id_student_cerere,id_student_imprumutor,suma_imprumutata,data_imprumut,data_returnare_imprumut,STUDENT_id)
	    VALUES
	    (_id_student_cerere,_id_student_imprumutor,_suma_imprumutata,_data_imprumut,NULL,_id_student_cerere);
        
	    UPDATE buget SET buget_temporar = buget_temporar+_suma_imprumutata WHERE STUDENT_id = @ID_D1;
		UPDATE buget SET buget_temporar = buget_temporar-_suma_imprumutata WHERE STUDENT_id = @ID_D2;
        
        UPDATE buget set data_temporala= _data_imprumut where STUDENT_id=@ID_D1;
		UPDATE buget set data_temporala= _data_imprumut where STUDENT_id=@ID_D2;
        
        SELECT @BUGET_TEMP := buget_temporar FROM buget WHERE STUDENT_id=_id_student_imprumutor;
        
	   INSERT INTO evidenta_cheltuieli 
       (data_intermediara,suma_cheltuita,buget_ramas,STUDENT_id)
       VALUES
       (_data_imprumut,_suma_imprumutata,@BUGET_TEMP,_id_student_imprumutor);
       
       SET @buget_nou1=NULL;
	   SELECT @buget_nou1:=buget_temporar from buget where STUDENT_id=_id_student_cerere group by STUDENT_id;
        
        INSERT INTO evidenta_bani_primiti
       (data_intermediara,suma_primita,buget_nou,STUDENT_id)
       VALUES
       (_data_imprumut,_suma_imprumutata,@buget_nou1,_id_student_cerere);
       END IF;
	   COMMIT;
         END;
	ELSE ROLLBACK;
    	END IF;
  END //
DELIMITER ;
#########################################################################################################################################################
#2.Restituirea imprumuturilor studentilor
DROP PROCEDURE IF EXISTS restituire_imprumut;
DELIMITER //

CREATE PROCEDURE restituire_imprumut (_id_student_cerere int,_id_student_imprumutor int,_data_returnare_imprumut datetime)
  BEGIN
    START TRANSACTION;
       SET @ID_D1 = NULL;
       SET @ID_D2 = NULL;
       SET @suma=NULL;
       SET @BUGET_TEMP=NULL;
       
	  SET @data_precedenta=NULL;
      SET @data_precedenta2=NULL;

      select @data_precedenta := MAX(data_imprumut)  from imprumuturi  where (id_student_cerere=_id_student_cerere and 
      id_student_imprumutor=_id_student_imprumutor) group by id_student_cerere,id_student_imprumutor ;
      
	  SELECT @data_precedenta2:=MAX(data_returnare_imprumut) FROM imprumuturi where (id_student_cerere=_id_student_cerere and 
      id_student_imprumutor=_id_student_imprumutor) group by id_student_cerere,id_student_imprumutor;
       
       SELECT @ID_D1 := ID FROM student WHERE ID=_id_student_cerere;
       SELECT @ID_D2 := ID FROM student WHERE ID=_id_student_imprumutor;
       SELECT @suma := SUM(suma_imprumutata) from imprumuturi where  ((id_student_imprumutor=_id_student_imprumutor) and 
       (id_student_cerere=_id_student_cerere))
       group by id_student_cerere,id_student_imprumutor;
       SELECT @data_imprumut := data_imprumut from imprumuturi where id_student_imprumutor=@ID_D2;
	
       IF((@ID_D1 and @ID_D2) IS NOT NULL) THEN 	
	 BEGIN
      IF ((TIMESTAMPDIFF(hour, _data_returnare_imprumut,@data_precedenta) < 0 ) and (TIMESTAMPDIFF(hour, _data_returnare_imprumut,@data_precedenta2) < 0)) THEN
	   INSERT INTO imprumuturi
	    (id_student_cerere,id_student_imprumutor,suma_imprumutata,data_imprumut,data_returnare_imprumut,STUDENT_id)
	    VALUES
	    (_id_student_cerere,_id_student_imprumutor,@suma,@data_imprumut,_data_returnare_imprumut,_id_student_cerere);
        
	    UPDATE buget SET buget_temporar = buget_temporar-@suma WHERE STUDENT_id = @ID_D1;
		UPDATE buget SET buget_temporar = buget_temporar+@suma WHERE STUDENT_id = @ID_D2;
        
        UPDATE buget set data_temporala= _data_returnare_imprumut where STUDENT_id=@ID_D1;
		UPDATE buget set data_temporala= _data_returnare_imprumut where STUDENT_id=@ID_D2;
		
	   SELECT @BUGET_TEMP := buget_temporar FROM buget WHERE STUDENT_id=_id_student_cerere;
        
	   INSERT INTO evidenta_cheltuieli 
       (data_intermediara,suma_cheltuita,buget_ramas,STUDENT_id)
       VALUES
       (_data_returnare_imprumut,@suma,@BUGET_TEMP,_id_student_cerere);
	   COMMIT;
       
       SET @buget_nou1=NULL;
	   SELECT @buget_nou1:=buget_temporar from buget where STUDENT_id=_id_student_imprumutor group by STUDENT_id;
        
        INSERT INTO evidenta_bani_primiti
       (data_intermediara,suma_primita,buget_nou,STUDENT_id)
       VALUES
       (_data_returnare_imprumut,@suma,@buget_nou1,_id_student_imprumutor);
       END IF;
         END;
	ELSE ROLLBACK;
    	END IF;
  END //
DELIMITER ;
#########################################################################################################################################################
#3.Acordarea burselor de merit pentru studentii de la facultati diferite din cadrul UTCN
DROP PROCEDURE IF EXISTS burse_de_merit;

DELIMITER //

CREATE PROCEDURE burse_de_merit(_id_semestru int ,_data datetime, _id_student int )   
  BEGIN
    START TRANSACTION;
       SET @ID_D = NULL;
       SET @ID_D1=NULL;
       SET @ID_D2=NULL;
       SET @MEDIE1 =NULL;
       SET @MEDIE2=NULL;
       SET @SEM=_id_semestru;
       SET @AN=NULL;
       SET @MEDIE_MIN= NULL;
       SET @MEDIE=NULL;
       SET @statut=NULL;
	   SET @buget=NULL;
       
       SET @BUGET_TEMP=NULL;
       SET @data_anterioara=NULL;
       
        SELECT @data_anterioara:=MAX(data_intrare_bursa) FROM bursa where situatie_sociala_STUDENT_id=_id_student
       group by situatie_sociala_STUDENT_id;
       
       SELECT @ID_D3 :=STUDENT_id from situatie_sociala where STUDENT_id=_id_student;
       SELECT @ID_D2 := situatie_scolara_STUDENT_id from medie where situatie_scolara_STUDENT_id=_id_student;
       SELECT @ID_D1 := STUDENT_id from facultate where STUDENT_id=_id_student;
       SELECT @ID_D := ID FROM student WHERE ID=_id_student;	
       
       SELECT @buget:= buget_membru from student where id=@ID_D;
       SELECT @AN:=anul_de_studiu FROM student where id=@ID_D;
       SELECT @MEDIE_MIN :=media_minima_bursa from facultate where STUDENT_id=@ID_D1;
       SELECT @MEDIE1:=media_an_anterior from medie where situatie_scolara_STUDENT_id=@ID_D2;
       SELECT @MEDIE2:=media_sem1 from medie where situatie_scolara_STUDENT_id=@ID_D2;
       SELECT @statut:=tip_social from situatie_sociala where STUDENT_id=@ID_D3;
       
       IF(@ID_D IS NOT NULL) THEN 	
       
	 BEGIN
     IF _id_semestru=1 then SET @MEDIE=@MEDIE1;
                       else
				            SET @MEDIE=@MEDIE2;
     end IF;
     
     IF (@AN=1 and @SEM=1 ) then 
      INSERT INTO bursa
	    (tip_bursa,suma_bursa,data_intrare_bursa,situatie_sociala_STUDENT_id,medie_situatie_scolara_id_semestru,medie_situatie_scolara_STUDENT_id )
	    VALUES (NULL,NULL,NULL,@ID_D,@SEM,@ID_D);
        else
	  IF TIMESTAMPDIFF(MONTH, _data,@data_anterioara) < 0 THEN
	   IF (@MEDIE>=@MEDIE_MIN and @statut= 'apt' and @buget > 1050)then 
	   INSERT INTO bursa
	    (tip_bursa,suma_bursa,data_intrare_bursa,situatie_sociala_STUDENT_id,medie_situatie_scolara_id_semestru,medie_situatie_scolara_STUDENT_id )
	    VALUES
	    ('bursa merit',700,_data,@ID_D,@SEM,@ID_D);
        
	    UPDATE buget SET buget_temporar = buget_temporar+ 700 WHERE STUDENT_id = @ID_D;
        UPDATE buget set data_temporala= _data where STUDENT_id=@ID_D;
        
        SET @buget_nou1=NULL;
        SELECT @buget_nou1:=buget_temporar from buget where STUDENT_id=_id_student group by _id_student;
        
        INSERT INTO evidenta_bani_primiti
       (data_intermediara,suma_primita,buget_nou,STUDENT_id)
       VALUES
       (_data,700,@buget_nou1,_id_student);
		END IF;
	    END IF;
        END IF;
	   COMMIT;
         END;
	ELSE ROLLBACK;
    	 END IF;
  END //
DELIMITER ;
##########################################################################################################################################################
#4.Acordare de burse sociale pentru studentii cu venituri mici sau probleme  medicale 
DROP PROCEDURE IF EXISTS burse_sociale ;
DELIMITER //

CREATE PROCEDURE burse_sociale(_id_semestru int ,_data datetime, _id_student int )   
  BEGIN
    START TRANSACTION;
       SET @ID_D = NULL;
       SET @ID_D1=NULL;
       SET @buget=NULL;
	   SET @statut=NULL;
       SET @MEDIE1 =NULL;
       SET @MEDIE2=NULL;
       SET @MEDIE_MIN= NULL;
       SET @MEDIE=NULL;
       SET @AN=NULL;
       
	   SET @BUGET_TEMP=NULL;
       SET @data_anterioara=NULL;
       
       SELECT @data_anterioara:=MAX(data_intrare_bursa) FROM bursa where situatie_sociala_STUDENT_id=_id_student
       group by situatie_sociala_STUDENT_id;
      
       SELECT @ID_D4 :=STUDENT_id from situatie_sociala where STUDENT_id=_id_student;
	   SELECT @ID_D3 :=STUDENT_id from situatie_sociala where STUDENT_id=_id_student;
       SELECT @ID_D2 := situatie_scolara_STUDENT_id from medie where situatie_scolara_STUDENT_id=_id_student;
       SELECT @ID_D1 := STUDENT_id from facultate where STUDENT_id=_id_student;
	   SELECT @ID_D := ID FROM student WHERE ID=_id_student;
        
       SELECT @MEDIE_MIN :=media_minima_bursa from facultate where STUDENT_id=@ID_D1;
       SELECT @MEDIE1:=media_an_anterior from medie where situatie_scolara_STUDENT_id=@ID_D2;
       SELECT @MEDIE2:=media_sem1 from medie where situatie_scolara_STUDENT_id=@ID_D2;
       
       SELECT @buget:= buget_membru from student where ID=@ID_D;
       SELECT @statut:=tip_social from situatie_sociala where STUDENT_id=@ID_D4;
       SELECT @AN:=anul_de_studiu FROM student where id=@ID_D;
       
       IF(@ID_D IS NOT NULL) THEN 	
       
	 BEGIN
     IF _id_semestru=1 then SET @MEDIE=@MEDIE1;
                       else
				            SET @MEDIE=@MEDIE2;
	END if;
    
      IF((@buget >= 1050 and @statut ='apt') or @MEDIE > @MEDIE_MIN ) then 
	  INSERT INTO bursa
	    (tip_bursa,suma_bursa,data_intrare_bursa,situatie_sociala_STUDENT_id,medie_situatie_scolara_id_semestru,medie_situatie_scolara_STUDENT_id )
	    VALUES (NULL,NULL,NULL,@ID_D,@SEM,@ID_D1);
        else
	 IF TIMESTAMPDIFF(MONTH, _data,@data_anterioara) < 0 THEN
        IF(((@buget<=1050 or @statut <> 'apt')and @MEDIE < @MEDIE_MIN) or (@AN=1 and ( @status <> 'apt')))then 
      INSERT INTO bursa
	    (tip_bursa,suma_bursa,data_intrare_bursa,situatie_sociala_STUDENT_id,medie_situatie_scolara_id_semestru,medie_situatie_scolara_STUDENT_id )
	    VALUES
	    ('bursa sociala',578,_data,@ID_D,@SEM,@ID_D1);

	    UPDATE buget SET buget_temporar = buget_temporar+ 578 WHERE STUDENT_id = @ID_D;
        UPDATE buget set data_temporala= _data where STUDENT_id=@ID_D;
        
        SET @buget_nou1=NULL;
        SELECT @buget_nou1:=buget_temporar from buget where STUDENT_id=_id_student group by _id_student;
        
        INSERT INTO evidenta_bani_primiti
       (data_intermediara,suma_primita,buget_nou,STUDENT_id)
       VALUES
       (_data,578,@buget_nou1,_id_student);
		END IF;
        END IF;
        END IF;
	   COMMIT;
		END;
	ELSE ROLLBACK;
    	END IF;
  END //
DELIMITER ;
#########################################################################################################################################################
#5.Acordare de burse cumulate,pentru studentii cazuri sociale care au medii mari 
DROP PROCEDURE IF EXISTS burse_de_merit_sociale;

DELIMITER //

CREATE PROCEDURE burse_de_merit_sociale(_id_semestru int ,_data datetime, _id_student int )   
  BEGIN
    START TRANSACTION;
       SET @ID_D = NULL;
       SET @ID_D1=NULL;
       SET @ID_D2=NULL;
       SET @MEDIE1 =NULL;
       SET @MEDIE2=NULL;	
       SET @AN=NULL;
       SET @MEDIE_MIN= NULL;
       SET @MEDIE=NULL;
	   SET @buget=NULL;
	   SET @statut=NULL;
        
       SET @BUGET_TEMP=NULL;
       SET @data_anterioara=NULL;
       
       SELECT @data_anterioara:=MAX(data_intrare_bursa) FROM bursa where situatie_sociala_STUDENT_id=_id_student 
       group by situatie_sociala_STUDENT_id;
       
	   SELECT @ID_D3 :=STUDENT_id from situatie_sociala where STUDENT_id=_id_student;
       SELECT @ID_D2 := situatie_scolara_STUDENT_id from medie where situatie_scolara_STUDENT_id=_id_student;
       SELECT @ID_D1 := STUDENT_id from facultate where STUDENT_id=_id_student;
       SELECT @ID_D := ID FROM student WHERE ID=_id_student;	
       
       SELECT @AN:=anul_de_studiu FROM student where id=@ID_D;
       SELECT @MEDIE_MIN :=media_minima_bursa from facultate where STUDENT_id=@ID_D1;
       SELECT @MEDIE1:=media_an_anterior from medie where situatie_scolara_STUDENT_id=@ID_D2;
       SELECT @MEDIE2:=media_sem1 from medie where situatie_scolara_STUDENT_id=@ID_D2;
       SELECT @buget:= buget_membru from student where ID=@ID_D;
       SELECT @statut:=tip_social from situatie_sociala where STUDENT_id=@ID_D3;
	 IF _id_semestru=1 then SET @MEDIE=@MEDIE1;
					   else
							SET @MEDIE=@MEDIE2;
     end IF;
     
       IF(@ID_D IS NOT NULL) THEN 	
	 BEGIN
    
     IF (@AN=1 and @SEM=1 ) then 
      INSERT INTO bursa
	    (tip_bursa,suma_bursa,data_intrare_bursa,situatie_sociala_STUDENT_id,medie_situatie_scolara_id_semestru,medie_situatie_scolara_STUDENT_id )
	    VALUES (NULL,NULL,NULL,@ID_D,@SEM,@ID_D);
        else
	  IF TIMESTAMPDIFF(MONTH, _data,@data_anterioara) < 0 THEN
	   IF((@buget<=1050 or @statut <> 'apt')and @MEDIE > @MEDIE_MIN) then 
	   INSERT INTO bursa
	    (tip_bursa,suma_bursa,data_intrare_bursa,situatie_sociala_STUDENT_id,medie_situatie_scolara_id_semestru,medie_situatie_scolara_STUDENT_id )
	    VALUES
	    ('bursa merit+sociala',1278,_data,@ID_D,@SEM,@ID_D);
	    UPDATE buget SET buget_temporar = buget_temporar+ 1278 WHERE STUDENT_id = @ID_D;
        UPDATE buget set data_temporala= _data where STUDENT_id=@ID_D;
        
		SET @buget_nou1=NULL;
        SELECT @buget_nou1:=buget_temporar from buget where STUDENT_id=_id_student group by _id_student;
        
        INSERT INTO evidenta_bani_primiti
       (data_intermediara,suma_primita,buget_nou,STUDENT_id)
       VALUES
       (_data,1278,@buget_nou1,_id_student);
       
	    END IF;
	    END IF;
        END IF;
	   COMMIT;
		END;
	ELSE ROLLBACK;
    	END IF;
  END //
DELIMITER ;
##########################################################################################################################################################

#6.Adaugare_job
DROP PROCEDURE IF EXISTS adaugare_job;

DELIMITER //
CREATE PROCEDURE adaugare_job (_tip_job varchar(45),_data_angajare datetime,_data_salarizare datetime,_salariu_brut int,_id_student int)   
  BEGIN
    START TRANSACTION;
       SET @ID_D = NULL;
       SELECT @ID_D := ID FROM student WHERE ID=_id_student;
	
       IF(@ID_D IS NOT NULL) THEN 	
	 BEGIN
	   INSERT INTO job
	    (tip_job,data_angajare,data_salarizare,salariu_brut,STUDENT_id)
	    VALUES
	    (_tip_job,_data_angajare,_data_salarizare,_salariu_brut,_id_student);
        
	   COMMIT;
         END;
	ELSE ROLLBACK;
    	END IF;
  END //
DELIMITER ;
##########################################################################################################################################################
#7.Plata lunara job 
DROP PROCEDURE IF EXISTS plata_lunara_job;

DELIMITER //
CREATE PROCEDURE plata_lunara_job (_id_student int,_luna_salarizare int)   
  BEGIN
    START TRANSACTION;
       SET @ID_D = NULL;
       SET @ID_D1=NULL;
       SET @AN_ANGAJARE=NULL;
       SET @AN_SALARIZARE=NULL;
       SET @LUNA_ANGAJARE=NULL;
       SET @LUNA_SALARIZARE=_luna_salarizare;
       SET @ZIUA_ANGAJARE=NULL;
       SET @ZIUA_SALARIZARE=NULL;
       SET @SALARIU= NULL;
       
       
       SELECT @ID_D := ID FROM student WHERE ID=_id_student;
       SELECT @ID_D1:= STUDENT_id from job where STUDENT_id=_id_student;
	   SELECT @AN_ANGAJARE:=year(data_angajare) FROM job where STUDENT_id=@ID_D1;
	   SELECT @LUNA_ANGAJARE:=month(data_angajare) FROM job where STUDENT_id=@ID_D1;
       SELECT @ZIUA_ANGAJARE:=day(data_angajare)FROM job where STUDENT_id=@ID_D1;
       SELECT @ZIUA_SALARIZARE:=day(data_salarizare)FROM job where STUDENT_id=@ID_D1;
       SELECT @SALARIU:=salariu_brut from job job where STUDENT_id=@ID_D1;
       
       IF(@ID_D IS NOT NULL) THEN 	
	 BEGIN
	   IF _luna_salarizare>=10 then 
       SET @AN_SALARIZARE=2017;
       else
       SET @AN_SALARIZARE=2018;
       END IF;
	   IF @AN_SALARIZARE-@AN_ANGAJARE >=0 THEN 
         IF @LUNA_SALARIZARE-@LUNA_ANGAJARE=1 THEN 
           IF @ZIUA_SALARIZARE -@ZIUA_SALARIZARE>=0 THEN 
		   UPDATE buget SET buget_temporar = buget_temporar+@SALARIU WHERE STUDENT_id = @ID_D;
		   UPDATE buget set data_temporala= CONCAT(@AN_SALARIZARE,'-',@LUNA_SALARIZARE,'-',@ZI_SALARIZARE) where STUDENT_id=@ID_D;
           END IF;
		else 
        IF @LUNA_SALARIZARE-@LUNA_ANGAJARE>1 THEN 
          UPDATE buget SET buget_temporar = buget_temporar+@SALARIU WHERE STUDENT_id = @ID_D;
		  UPDATE student set data_temporala= CONCAT(@AN_SALARIZARE,'-',@LUNA_SALARIZARE,'-',@ZI_SALARIZARE) where STUDENT_id=@ID_D;
          
		END IF;
        END IF;
        END IF;
	   COMMIT;
         END;
	ELSE ROLLBACK;
    	END IF;
  END //
DELIMITER ;
######################################################################################################################################################
#8.Adaugarea bugetului stabil lunar de la "sponsorul principal"

DROP PROCEDURE IF EXISTS adaugare_buget_lunar;

DELIMITER //
CREATE PROCEDURE adaugare_buget_lunar (_buget_initial int,_data_initiala datetime,_id_student int)   
  BEGIN
    START TRANSACTION;
       SET @ID_D = NULL;
       SET @ID_D1=NULL;
       SET @BUGET_TEMP=NULL;
       SET @data_anterioara=NULL;
       
       SELECT @ID_D := ID FROM student WHERE ID=_id_student;
       SELECT @data_anterioara:=MAX(data_initiala) FROM buget where STUDENT_id=_id_student;
       SELECT @BUGET_TEMP:=buget_temporar from buget where STUDENT_id=_id_student;
	
       IF(@ID_D IS NOT NULL) THEN 	
	 BEGIN
     IF TIMESTAMPDIFF(MONTH, _data_initiala,@data_anterioara) < 0 THEN

        UPDATE buget set data_initiala=_data_initiala where STUDENT_id=_id_student;
        UPDATE buget set data_temporala=_data_initiala where STUDENT_id =_id_student;
        UPDATE buget SET buget_initial = _buget_initial WHERE STUDENT_id =_id_student;
		UPDATE buget SET buget_temporar = _buget_initial+@BUGET_TEMP WHERE STUDENT_id =_id_student;
        
        INSERT INTO cumparaturi_extra
	    (tip_cumparaturi,plata_cumparaturi,data_c,STUDENT_id)
	    VALUES
	    (NULL,NULL,_data_initiala,_id_student);
        
        INSERT INTO divertisment
	    (tip_activitate,plata_activitate,data_d,STUDENT_id)
	    VALUES
	    (NULL,NULL,_data_initiala,_id_student);
        
        INSERT INTO transport
	    (tip_transport,plata_transport,data_t,STUDENT_id,situatie_scolara_STUDENT_id)
	    VALUES
	    (NULL,NULL,_data_initiala,_id_student,_id_student);
        
        INSERT INTO mancare
	    (id_masa,data_m,STUDENT_id,plata_mancare)
	    VALUES
	    (NULL,_data_initiala,_id_student,NULL);
        
        SET @buget_nou1=NULL;
        SELECT @buget_nou1:=buget_temporar from buget where STUDENT_id=_id_student group by _id_student;
        
        INSERT INTO evidenta_bani_primiti
       (data_intermediara,suma_primita,buget_nou,STUDENT_id)
       VALUES
       (_data_initiala,_buget_initial,@buget_nou1,_id_student);
        
        #SELECT @BUGET_TEMP := buget_temporar FROM buget WHERE STUDENT_id=_id_student;
       
         END IF ;
         COMMIT;
         END;
	ELSE ROLLBACK;
    	END IF;
  END //
DELIMITER ;
