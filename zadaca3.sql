DROP TABLE Namirnice CASCADE CONSTRAINTS;
DROP TABLE Stand CASCADE CONSTRAINTS;
DROP TABLE Isporuka;
DROP TABLE Dezurstvo;
DROP TABLE nagrada;
DROP TABLE sahovska_simultanka;
DROP TABLE student;
DROP TABLE projekt;
DROP TABLE zaposlenik;
DROP TABLE gost;
DROP TABLE ekipa_za_belu;
DROP TABLE ekipa_za_kviz;

CREATE TABLE ekipa_za_kviz(
kviz_id INTEGER CONSTRAINT kviz_id_pk PRIMARY KEY,
naziv VARCHAR2(60) NOT NULL,
rezultat INTEGER NOT NULL
);

CREATE TABLE ekipa_za_belu(
bela_id INTEGER  CONSTRAINT bela_id_pk PRIMARY KEY,
naziv VARCHAR2(60) NOT NULL,
rezultat INTEGER NOT NULL
);

CREATE TABLE gost(
OIB CHAR(11) CONSTRAINT OIB_pk  PRIMARY KEY,
ime VARCHAR2(20) NOT NULL,
prezime VARCHAR2(20) NOT NULL, 
email VARCHAR(18) NOT NULL,
kviz_id INTEGER  CONSTRAINT gost_fk__kviz_id REFERENCES ekipa_za_kviz(kviz_id),
bela_id INTEGER  CONSTRAINT gost_fk_bela_id REFERENCES ekipa_za_belu(bela_id)
);

CREATE TABLE zaposlenik(
OIB CHAR(11) CONSTRAINT zaposlenik_OIB_pk  PRIMARY KEY REFERENCES gost(OIB),
vrsta_posla VARCHAR2(20) NOT NULL
);

CREATE TABLE projekt(
projekt_id INTEGER CONSTRAINT projekt_id_pk  PRIMARY KEY,
naziv VARCHAR2(50) NOT NULL,
kolegij VARCHAR2(50) NOT NULL,
ocjena INTEGER NOT NULL,
zaposlenik_oib CHAR(11) NOT NULL CONSTRAINT projekt_fk_zaposlenik_OIB REFERENCES zaposlenik(OIB)
);

CREATE TABLE student(
OIB CHAR(11) CONSTRAINT student_OIB_pk  PRIMARY KEY REFERENCES gost(OIB),
JMBAG CHAR(10) NOT NULL,
projekt_id INTEGER CONSTRAINT student_fk_projekt_id REFERENCES projekt(projekt_id)
);

CREATE TABLE sahovska_simultanka(
sah_id INTEGER  CONSTRAINT sah_id_pk PRIMARY KEY,
naziv VARCHAR2(60) NOT NULL,
rezultat INTEGER NOT NULL,
gost_OIB CHAR(11) NOT NULL CONSTRAINT sah_fk_gost_OIB REFERENCES gost(OIB)
);

CREATE TABLE nagrada(
nagrada_id INTEGER  CONSTRAINT nagrada_id_pk PRIMARY KEY,
kategorija VARCHAR2(30) NOT NULL,
naziv VARCHAR2(50) NOT NULL,
projekt_id INTEGER CONSTRAINT nagrada_fk_projekt_id REFERENCES projekt(projekt_id),
bela_id INTEGER CONSTRAINT nagrada_fk_bela_id REFERENCES ekipa_za_belu(bela_id),
kviz_id INTEGER CONSTRAINT nagrada_fk_kviz_id REFERENCES ekipa_za_kviz(kviz_id),
sah_id INTEGER CONSTRAINT nagrada_fk_sah_id REFERENCES sahovska_simultanka(sah_id), 
CONSTRAINT iskljucivo_nagrada CHECK (((projekt_id IS NOT NULL) AND (bela_id IS NULL)
                                                               AND (kviz_id IS NULL)
                                                               AND (sah_id IS NULL))
                                 OR  ((bela_id IS NOT NULL)    AND (projekt_id IS NULL)
                                                               AND (kviz_id IS NULL)
                                                               AND (sah_id IS NULL))
                                 OR ((kviz_id IS NOT NULL)     AND (projekt_id IS NULL)
                                                               AND (bela_id IS NULL)
                                                               AND (sah_id IS NULL))
                                 OR ((sah_id IS NOT NULL)      AND (projekt_id IS NULL)
                                                               AND (bela_id IS NULL)
                                                               AND (bela_id IS NULL)))
);

CREATE TABLE stand(
broj INTEGER CONSTRAINT broj_id_pk PRIMARY KEY
);

CREATE TABLE namirnice(
namirnice_id INTEGER CONSTRAINT namirnice_id_pk PRIMARY KEY,
tip VARCHAR2(5) NOT NULL,
vrsta VARCHAR2(20) NOT NULL,
kolicina BINARY_FLOAT NOT NULL,
cijena BINARY_FLOAT NOT NULL,
mjerna_jedinica VARCHAR(5) NOT NULL,
trgovina VARCHAR2(20) NOT NULL
);

CREATE TABLE isporuka(
vrijeme DATE NOT NULL, 
kolicina INTEGER NOT NULL,
stand_broj INTEGER NOT NULL CONSTRAINT isporuka_fk_stand_broj REFERENCES stand(broj),
namirnice_id INTEGER NOT NULL CONSTRAINT isporuka_fk_namirnice_id REFERENCES namirnice(namirnice_id),
CONSTRAINT isporuka_pk PRIMARY KEY(vrijeme, stand_broj, namirnice_id)
);

CREATE TABLE dezurstvo(
vrijeme_pocetka DATE NOT NULL,
vrijeme_kraja DATE NOT NULL,
zaposlenik_OIB CHAR(11) NOT NULL CONSTRAINT dezurstvo_fk_gost_OIB REFERENCES zaposlenik(OIB),
stand_broj INTEGER NOT NULL CONSTRAINT dezurstvo_fk_stand_broj REFERENCES stand(broj),
CONSTRAINT dezurstvo_pk PRIMARY KEY (vrijeme_pocetka,zaposlenik_OIB,stand_broj)
);

COMMIT;

-----------------------------------------------------------------------

-- Brisanje podataka
-- koristeci DROP naredbu brisemo cijelu strukturu tablice (DDL)
-- koristeci DELETE naredbu micemo retke iz tablice (DML)
-- koristeci TRUNCATE naredbu brisemo sve retke u tablici (DDL)
DELETE FROM dezurstvo;
DELETE FROM isporuka;
DELETE FROM namirnice;
DELETE FROM stand;
DELETE FROM nagrada;
DELETE FROM sahovska_simultanka;
DELETE FROM student;
DELETE FROM projekt;
DELETE FROM zaposlenik;
DELETE FROM gost;
DELETE FROM ekipa_za_belu;
DELETE FROM ekipa_za_kviz;

---------------------- INSERT U TABLICE -------------------------------

------ EKIPA ZA KVIZ --------
INSERT INTO ekipa_za_kviz VALUES (1,'Tim(on i Pumbaa)', 3);
INSERT INTO ekipa_za_kviz VALUES (2, 'Kvizasi', 14);
INSERT INTO ekipa_za_kviz VALUES (3, 'Sveznala cetvorka', 8);
INSERT INTO ekipa_za_kviz VALUES (4, 'Ekipa1', 8);
INSERT INTO ekipa_za_kviz VALUES (5, 'Pobjednici', 7);
INSERT INTO ekipa_za_kviz VALUES (6, 'Racunarci', 12);
INSERT INTO ekipa_za_kviz VALUES (7, 'Bilje Merkanti', 6);
INSERT INTO ekipa_za_kviz VALUES (8, 'Pi', 17);
INSERT INTO ekipa_za_kviz VALUES (9, 'Najjaci', 9);
INSERT INTO ekipa_za_kviz VALUES (10, 'Ko kec na desetku', 9);

------ EKIPA ZA BELU -----------------------------
INSERT INTO ekipa_za_belu VALUES (1, 'Lovci u zitu', 4);
INSERT INTO ekipa_za_belu VALUES (2, 'Paran par za bijelu belu', 2);
INSERT INTO ekipa_za_belu VALUES (3, 'Dvojac', 4);
INSERT INTO ekipa_za_belu VALUES (4, 'Bobi', 5);
INSERT INTO ekipa_za_belu VALUES (5, 'Dinamican duo',5);
INSERT INTO ekipa_za_belu VALUES (6, 'Haskelasi', 11);
INSERT INTO ekipa_za_belu VALUES (7, 'Duo Fantastico', 6);
INSERT INTO ekipa_za_belu VALUES (8, 'Kralj i kraljica', 7);
INSERT INTO ekipa_za_belu VALUES (9, 'Bella', 8);
INSERT INTO ekipa_za_belu VALUES (10, 'Bili pivac', 7);

-------------------- GOSTI -----------------
INSERT INTO gost VALUES ('11122233344', 'Danijela', 'Jaganjac', 'djaganja@mathos.hr',   1,NULL);
INSERT INTO gost VALUES ('12312312312', 'Rebeka',   'Coric', 'rcoric@mathos.hr',        1,NULL);
INSERT INTO gost VALUES ('44556677889', 'Mateja',   'Djumic', 'mdjumic@mathos.hr',      1,NULL);
INSERT INTO gost VALUES ('99887766554', 'Jurica',   'Maltar', 'jmalta@mathos.hr',       2,NULL);
INSERT INTO gost VALUES ('22223333444', 'Domagoj',  'Matijevic', 'dmatijev@mathos.hr',  2,NULL);
INSERT INTO gost VALUES ('44444444444', 'Domagoj',  'Severdija', 'dseverdi@mathos.hr',  2,NULL);
INSERT INTO gost VALUES ('55555555555', 'Slobodan', 'Jelic', 'sjelic@mathos.hr',        3,NULL);
INSERT INTO gost VALUES ('10101010555', 'Zoran',    'Tomljanovic', 'ztomljan@mathos.hr',3,NULL);
INSERT INTO gost VALUES ('99999999999', 'Nenad',    'Suvak', 'nsuvak@mathos.hr',        3,NULL);
INSERT INTO gost VALUES ('77788877788', 'Jelena',   'Jankov', 'jjankov@mathos.hr',      4,10);
INSERT INTO gost VALUES ('80558781051', 'Dragana',  'Jankov', 'djankov@mathos.hr',      4,10);
INSERT INTO gost VALUES ('62137100161', 'Ivana',    'Crnjac', 'icrnjac@mathos.hr',      4,9);
INSERT INTO gost VALUES ('78473032965', 'Ivan',     'Papic', 'ipapic@mathos.hr',        5,9);
INSERT INTO gost VALUES ('49001010930', 'Ivan',     'Soldo', 'isoldo@mathos.hr',        5,8);
INSERT INTO gost VALUES ('89379191356', 'Kristian', 'Sabo', 'ksabo@mathos.hr',          5,8);

INSERT INTO gost VALUES ('08628893747', 'Katica',  'Popovic', 'kpopov@mathos.hr',       6,NULL);
INSERT INTO gost VALUES ('46956357133', 'Jan',     'Valenta', 'jvalenta@mathos.hr',     6,NULL);
INSERT INTO gost VALUES ('04784461176', 'Vlado',   'Fotak', 'vfotak@mathos.hr',         6,7);
INSERT INTO gost VALUES ('40404040404', 'Snjezana','Varga', 'svarga@mathos.hr',         7,7);
INSERT INTO gost VALUES ('50505050505', 'Petar',   'Taler', 'petar@mathos.hr',          7,NULL);
INSERT INTO gost VALUES ('60606060606', 'Marija',  'Sabo', 'msabo@mathos.hr',           7,NULL);

-- ZAPOSLENICI ----------------------------------------------------------------
INSERT INTO zaposlenik VALUES ('11122233344', 'nastavnik');
INSERT INTO zaposlenik VALUES ('12312312312', 'nastavnik');
INSERT INTO zaposlenik VALUES ('44556677889', 'nastavnik');
INSERT INTO zaposlenik VALUES ('99887766554', 'nastavnik');
INSERT INTO zaposlenik VALUES ('22223333444', 'nastavnik');
INSERT INTO zaposlenik VALUES ('44444444444', 'nastavnik');
INSERT INTO zaposlenik VALUES ('55555555555', 'nastavnik');
INSERT INTO zaposlenik VALUES ('10101010555', 'nastavnik');
INSERT INTO zaposlenik VALUES ('99999999999', 'nastavnik');
INSERT INTO zaposlenik VALUES ('77788877788', 'nastavnik');
INSERT INTO zaposlenik VALUES ('80558781051', 'nastavnik');
INSERT INTO zaposlenik VALUES ('62137100161', 'nastavnik');
INSERT INTO zaposlenik VALUES ('78473032965', 'nastavnik');
INSERT INTO zaposlenik VALUES ('49001010930', 'nastavnik');
INSERT INTO zaposlenik VALUES ('89379191356', 'nastavnik');

INSERT INTO zaposlenik VALUES ('08628893747', 'osoblje');
INSERT INTO zaposlenik VALUES ('46956357133', 'osoblje');
INSERT INTO zaposlenik VALUES ('04784461176', 'osoblje');
INSERT INTO zaposlenik VALUES ('40404040404', 'osoblje');
INSERT INTO zaposlenik VALUES ('50505050505', 'osoblje');
INSERT INTO zaposlenik VALUES ('60606060606', 'osoblje');


-- PROJEKT ----------------------
INSERT INTO projekt VALUES (1,'Smart house', 'Ugradjeni sustavi', 5,'99887766554');
INSERT INTO projekt VALUES (2,'Model za predikciju peludi', 'Strojno ucenje', 5,'22223333444');
INSERT INTO projekt VALUES (3,'3D animacija', '3D racunalna grafika', 4,'44444444444');
INSERT INTO projekt VALUES (4,'Pracenje investicija', 'Slucajni procesi', 4,'99999999999');
INSERT INTO projekt VALUES (5,'Modeliranje kinematike', 'Osnove teorije upravljanja',4,'10101010555');


-- GOST ----------------------------------------------------------------
INSERT INTO gost VALUES ('50699566453', 'Ivo',     'Ivic', 'iivic@mathos.hr',           8,NULL);
INSERT INTO gost VALUES ('37687532343', 'Marko',   'Marko', 'marko@mathos.hr',          9,6);
INSERT INTO gost VALUES ('75955008209', 'Ivan',    'Ivancic', 'ivancic@mathos.hr',      8,6);
INSERT INTO gost VALUES ('10050901424', 'Ana',     'Anic', 'aanic@mathos.hr',           9,5);
INSERT INTO gost VALUES ('59669133029', 'Ivana',   'Ivanic', 'iivanic@mathos.hr',       9,5);
INSERT INTO gost VALUES ('23000076382', 'Marija',  'Maric', 'mmaric@mathos.hr',         9,4);
INSERT INTO gost VALUES ('24865876382', 'Marin',   'Maric', 'mmaric2@mathos.hr',        8,4);
INSERT INTO gost VALUES ('69804033041', 'Filip',   'Filic', 'ffilic@mathos.hr',         10,3);
INSERT INTO gost VALUES ('00617924955', 'Marko',   'Anic', 'manic@mathos.hr',           10,3);
INSERT INTO gost VALUES ('67617924914', 'Luka',    'Anic', 'lanic@mathos.hr',           10,2);
INSERT INTO gost VALUES ('60339136661', 'Iva',     'Peric', 'iperic@mathos.hr',         NULL,2);
INSERT INTO gost VALUES ('93976739459', 'Maja',    'Majic', 'mmajic@mathos.hr',         NULL,1);
INSERT INTO gost VALUES ('11176739000', 'Mara',    'Majic', 'mmajic2@mathos.hr',        NULL,1);


-- STUDENT ----------------------------------------------------------------
INSERT INTO student VALUES ('50699566453', '6437072310', 1);
INSERT INTO student VALUES ('37687532343', '8923244747', 2);
INSERT INTO student VALUES ('75955008209', '0605156591', 3);
INSERT INTO student VALUES ('10050901424', '7001716254', 4);
INSERT INTO student VALUES ('59669133029', '3932566938', 5);
INSERT INTO student VALUES ('24865876382', '0910652694', NULL);
INSERT INTO student VALUES ('23000076382', '1239871237', NULL);
INSERT INTO student VALUES ('69804033041', '0997250686', NULL);
INSERT INTO student VALUES ('00617924955', '1114445555', NULL);
INSERT INTO student VALUES ('67617924914', '0926019778', NULL);
INSERT INTO student VALUES ('60339136661', '1882787234', NULL);
INSERT INTO student VALUES ('93976739459', '8736903458', NULL);
INSERT INTO student VALUES ('11176739000', '1111111111', NULL);


-- SAH ----------------------------------------------------------------
INSERT INTO sahovska_simultanka VALUES(1,'Sah Mat', 2, '24865876382');
INSERT INTO sahovska_simultanka VALUES(2,'Listopad',1 , '93976739459');
INSERT INTO sahovska_simultanka VALUES(3,'Pobjeda', 1, '10050901424');
INSERT INTO sahovska_simultanka VALUES(4,'Damin gambit', 10, '67617924914');
INSERT INTO sahovska_simultanka VALUES(5,'A-zvijezda', 2, '60339136661');
INSERT INTO sahovska_simultanka VALUES(6,'Magnus', 3, '50699566453');
INSERT INTO sahovska_simultanka VALUES(7,'Kasparov', 4, '04784461176');
INSERT INTO sahovska_simultanka VALUES(8,'Top', 4, '77788877788');
INSERT INTO sahovska_simultanka VALUES(9,'Lovac', 5, '10101010555');
INSERT INTO sahovska_simultanka VALUES(10,'C5', 7, '44444444444');

-- NAGRADA ----------------------------------------------------------------
INSERT INTO nagrada VALUES (1, 'Putovanje', 'Posjet Plitvickim jezerima', 1, NULL, NULL, NULL);
INSERT INTO nagrada VALUES (2, 'Putovanje', 'Odlazak u Kataloniju', 2,NULL, NULL, NULL);
INSERT INTO nagrada VALUES (3, 'Putovanje', 'Putovanje na festival Exit', NULL, NULL, NULL,4);
INSERT INTO nagrada VALUES (5, 'Poklon paket', 'Poklon paket informaticke opreme', NULL, 6, NULL, NULL);
INSERT INTO nagrada VALUES (6, 'Poklon paket', 'Poklon paket tvornice cokolade', NULL, NULL,8, NULL);

SELECT * FROM nagrada;

-- STAND ----------------------------------------------------------------
INSERT INTO stand VALUES (1);
INSERT INTO stand VALUES (2);
INSERT INTO stand VALUES (3);
INSERT INTO stand VALUES (4);

select * from stand;

-- NAMIRNICE ----------------------------------------------------------------
INSERT INTO namirnice VALUES (1, 'Hrana', 'Cevapi', 30,19.99,'kg','Onzum');
INSERT INTO namirnice VALUES (2, 'Hrana', 'Pljeskavice', 30,19.99,'kg','Onzum');
INSERT INTO namirnice VALUES (3, 'Hrana', 'Lepinje', 100,2.99,'kom','Onzum');
INSERT INTO namirnice VALUES (4, 'Hrana', 'Umak', 20,3.99,'kom','Onzum');
INSERT INTO namirnice VALUES (5, 'Hrana', 'Rajcica', 5,9.99,'kg','Onzum');
INSERT INTO namirnice VALUES (6, 'Hrana', 'Luk', 1,8.99,'kg','Onzum');
INSERT INTO namirnice VALUES (7, 'Hrana', 'Salata', 15,2.99,'kom','Onzum');
INSERT INTO namirnice VALUES (8, 'Pice', 'Voda', 30,2.99,'l','Ldil');
INSERT INTO namirnice VALUES (9, 'Pice', 'Sok', 20,9.99,'l','Ldil');
INSERT INTO namirnice VALUES (10, 'Pice', 'Pivo', 15,11.99,'l','Ldil');
INSERT INTO namirnice VALUES (11, 'Pice', 'Mineralna', 15,4.99,'l','Ldil');

-- ISPORUKA ----------------------------------------------------------------
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 13:00:00', 'yyyy/mm/dd hh24:mi:ss'), 1, 1, 1);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 13:00:00', 'yyyy/mm/dd hh24:mi:ss'), 5, 2,9);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 14:00:00', 'yyyy/mm/dd hh24:mi:ss'), 2, 3, 2);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 14:30:00', 'yyyy/mm/dd hh24:mi:ss'), 2, 4, 9);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 15:00:00', 'yyyy/mm/dd hh24:mi:ss'), 30, 1, 3);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 16:00:00', 'yyyy/mm/dd hh24:mi:ss'), 20, 2, 4);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 16:30:00', 'yyyy/mm/dd hh24:mi:ss'), 5, 3, 10);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 16:45:00', 'yyyy/mm/dd hh24:mi:ss'), 2, 4, 1);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 17:00:00', 'yyyy/mm/dd hh24:mi:ss'), 3, 4, 8);
INSERT INTO isporuka VALUES (TO_DATE('2021/06/01 17:15:00', 'yyyy/mm/dd hh24:mi:ss'), 15,1, 3);

-- DEZURSTVO ----------------------------------------------------------------
-- STAND 1
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 12:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 13:05:00', 'yyyy/mm/dd hh24:mi:ss'),'11122233344',1);
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 13:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 14:00:00', 'yyyy/mm/dd hh24:mi:ss'),'12312312312',1);  
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 14:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 15:00:00', 'yyyy/mm/dd hh24:mi:ss'),'44556677889',1);   
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 15:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 16:05:00', 'yyyy/mm/dd hh24:mi:ss'),'49001010930',1);  
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 16:45:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 17:40:00', 'yyyy/mm/dd hh24:mi:ss'),'62137100161',1);
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 17:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 18:25:00', 'yyyy/mm/dd hh24:mi:ss'),'44444444444',1);  
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 18:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 19:10:00', 'yyyy/mm/dd hh24:mi:ss'),'11122233344',1);   
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 18:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 19:15:00', 'yyyy/mm/dd hh24:mi:ss'),'12312312312',1);  
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 19:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 20:00:00', 'yyyy/mm/dd hh24:mi:ss'),'44556677889',1);
                              
---- STAND 2 -----------------------------------------------------------------------------------------

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 12:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 13:30:00', 'yyyy/mm/dd hh24:mi:ss'),'55555555555',2);

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 13:15:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 14:05:00', 'yyyy/mm/dd hh24:mi:ss'),'10101010555',2); 

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 14:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 14:35:00', 'yyyy/mm/dd hh24:mi:ss'),'78473032965',2);
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 14:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 16:40:00', 'yyyy/mm/dd hh24:mi:ss'),'55555555555',2);
                                                     

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 17:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 18:00:00', 'yyyy/mm/dd hh24:mi:ss'),'77788877788',2);                              

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 18:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 19:00:00', 'yyyy/mm/dd hh24:mi:ss'),'80558781051',2);                              
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 19:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 20:00:00', 'yyyy/mm/dd hh24:mi:ss'),'62137100161',2);
                              
---- STAND 3 -----------------------------------------------------------------------------------------  

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 12:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 13:10:00', 'yyyy/mm/dd hh24:mi:ss'),'08628893747',3);

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 13:10:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 13:40:00', 'yyyy/mm/dd hh24:mi:ss'),'46956357133',3);  

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 15:20:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 16:15:00', 'yyyy/mm/dd hh24:mi:ss'),'04784461176',3);
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 17:20:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 18:00:00', 'yyyy/mm/dd hh24:mi:ss'),'50505050505',3);


---- STAND 4 ----------------------------------------------------------------------------------------- 
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 12:15:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 13:30:00', 'yyyy/mm/dd hh24:mi:ss'),'04784461176',4); 
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 14:45:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 15:40:00', 'yyyy/mm/dd hh24:mi:ss'),'50505050505',4);  
                              
INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 16:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 17:10:00', 'yyyy/mm/dd hh24:mi:ss'),'08628893747',4);

INSERT INTO dezurstvo VALUES (TO_DATE('2021/06/01 18:15:00', 'yyyy/mm/dd hh24:mi:ss'), 
                              TO_DATE('2021/06/01 18:30:00', 'yyyy/mm/dd hh24:mi:ss'),'49001010930',4); 
                              
                              
COMMIT;

select * from dezurstvo;

-------------------------------------------------------- ZADACA 3 --------------------------------------------------------

--SELECT OIB FROM student WHERE projekt_id IS NOT null;
--DESCRIBE projekt;
--SELECT * FROM gost ORDER BY prezime;
-- ASC uzlazno (default), DESC descending silazno


--1.-- 
--select * from nagrade;

--Pronađite (ako postoje) studente koji su dobili nagradu za projekt, 
--a istovremeno nagradu za natjecanje u beli ili kvizu. Ispišite imena i prezime 
--tih studenata.

SELECT distinct gost.ime, gost.prezime, student.projekt_id
FROM student, gost , nagrada, projekt, ekipa_za_belu eb, ekipa_za_kviz ek
WHERE student.OIB = gost.OIB AND nagrada.projekt_id = student.projekt_id
AND (gost.bela_id = eb.bela_id OR gost.kviz_id = ek.kviz_id);


--2.--  
--Ispišite imena i prezimena gosta/gostiju koji su dobili 
--nagradu Odlazak u Kataloniju.

SELECT DISTINCT ime, prezime FROM gost , sahovska_simultanka, nagrada, projekt, student
WHERE (sahovska_simultanka.gost_OIB = gost.OIB AND 
nagrada.sah_id = sahovska_simultanka.sah_id 
AND nagrada.naziv = 'Odlazak u Kataloniju')
OR ( gost.kviz_id = nagrada.kviz_id
AND nagrada.naziv = 'Odlazak u Kataloniju')
OR (gost.bela_id = nagrada.bela_id 
AND nagrada.naziv = 'Odlazak u Kataloniju')
OR (student.OIB = gost.OIB 
AND nagrada.projekt_id = student.projekt_id
AND nagrada.naziv = 'Odlazak u Kataloniju');

COMMIT;
--3.--  
--Ispišite brojeve štandova na kojem je dežuralo više od 5 ljudi.

SELECT stand_broj FROM dezurstvo
GROUP BY stand_broj
HAVING COUNT(stand_broj) > 5;

COMMIT;

--4.--
--Za svaki sat i za svaki �tand ispi�ite koliko je ljudi
--de�uralo u tom satu na tom �tandu.  Ispis neka sadr�i stupce
--sat, �tand i broj ljudi. 


--5--  
--Ispi�ite sve podatke o studentu koji je napravio
--projekt Smart house.
--describe student;
SELECT * from student
INNER JOIN gost
ON student.OIB = gost.OIB
INNER JOIN projekt
ON (student.projekt_id = projekt.projekt_id)
WHERE projekt.naziv = 'Smart house';

COMMIT;

--6.--  
--Ispi�ite sve podatke o zaposlenicima koji 
--su de�urali na �tandu broj 4.
SELECT * FROM gost
INNER JOIN zaposlenik
ON (gost.OIB = zaposlenik.OIB)
INNER JOIN dezurstvo
ON (dezurstvo.zaposlenik_OIB = zaposlenik.OIB)
WHERE stand_broj = 4;

COMMIT;

--7.--  
--Ispi�ite imena svih zaposlenika koji su 
--de�urali na �tandu na kojem je u 17:00h isporu�ena voda.
SELECT ime, prezime from gost
INNER JOIN zaposlenik
ON (zaposlenik.OIB = gost.OIB)
INNER JOIN dezurstvo
ON (dezurstvo.zaposlenik_OIB = zaposlenik.OIB)
INNER JOIN isporuka
ON(dezurstvo.stand_broj = isporuka.stand_broj)
WHERE isporuka.vrijeme = TO_DATE('2021/06/01 17:00:00', 'yyyy/mm/dd hh24:mi:ss')
AND isporuka.namirnice_id = 8;

--8.--
--Za svaki stand ispišite namirnicu s najvećom cijenom 
--koja je na njega isporučena. Ispis neka sadrži broj štanda, 
--tip namirnice, vrstu namirnice i cijenu namirnice pod nazivom 
--"Najskuplja namirnica".

--SELECT stand.broj, MAX(cijena) from namirnice, stand group by stand.broj;

SELECT stand.broj, namirnice.tip, namirnice.vrsta, namirnice.cijena "Najskuplja namirnica"
from stand, namirnice,isporuka where namirnice.namirnice_id = isporuka.namirnice_id 
AND namirnice.cijena = (SELECT max(cijena) from namirnice);

--9.--
--Za svaki štand na kojem su se dogodile barem tri isporuke, 
--ispišite razliku između najskuplje i najjfetnije isporučene 
--namirnice.

SELECT stand.broj, (MAX(namirnice.cijena) - MIN(namirnice.cijena))
from namirnice, stand 
inner join isporuka
on(isporuka.stand_broj = stand.broj)
where namirnice.namirnice_id = isporuka.namirnice_id
group by stand.broj
having COUNT(isporuka.stand_broj)>=3;

commit;
--10.--
--Ispišite ime, prezime i vrstu posla za sve zaposlenike koji 
--su dežurali na štandu/štandovima na kojima je dežurao i mentor 
--nagrađenog projekta iz 3D računalne grafike.

SELECT DISTINCT gost.ime, gost.prezime, zaposlenik.vrsta_posla
from gost 
inner join zaposlenik 
on (gost.OIB = zaposlenik.OIB)
left JOIN dezurstvo 
on (zaposlenik.OIB = dezurstvo.zaposlenik_OIB)
left JOIN stand
on(stand.broj = dezurstvo.stand_broj)
where stand_broj = ( SELECT broj from stand 
INNER JOIN dezurstvo on dezurstvo.stand_broj = stand.broj
inner join zaposlenik on zaposlenik.OIB = dezurstvo.zaposlenik_OIB
inner join projekt on projekt.zaposlenik_OIB = zaposlenik.OIB
inner join nagrada on projekt.projekt_id = nagrada.projekt_id
where projekt.kolegij = '3D racunalna grafika' );
--projekt iz 3D nije nagradjen

--11.-- 
--Ispišite imena i prezimena svih gostiju čija je ekipa za kviz
--ostvarila drugi najbolji rezultat.

SELECT ime, prezime 
from gost 
inner join ekipa_za_kviz
using (kviz_id)
where rezultat = (SELECT MAX(rezultat) from ekipa_za_kviz
                    where rezultat < (SELECT MAX(rezultat) from ekipa_za_kviz));


--13.--
--Ispišite vrstu namirnica koje imaju cijena manju od prosječne
--cijene za taj tip namirnica.

SELECT vrsta from namirnice x
where cijena < (SELECT AVG(cijena) from namirnice
where namirnice.tip = x.tip);


--15.--
--Ispišite imena i prezimena svih onih studenata koji su se natjecali u kvizu, 
--ali nisu pobjedili, a njihova ekipa je ostvarila rezultat veći od prosječnog rezultata. 
SELECT ime, prezime from gost
inner join student 
on (student.OIB = gost.OIB)
inner join ekipa_za_kviz
on (ekipa_za_kviz.kviz_id = gost.kviz_id)
where rezultat < ( SELECT max(rezultat) from ekipa_za_kviz) 
and rezultat > (SELECT AVG(rezultat) from ekipa_za_kviz);