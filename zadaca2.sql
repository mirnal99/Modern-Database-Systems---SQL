DROP TABLE isporuka;
DROP TABLE namirnice;
DROP TABLE dezurstvo;
DROP TABLE stand;
DROP TABLE nagrada;
DROP TABLE student;
DROP TABLE sahovska_simultanka;
DROP TABLE projekt;
DROP TABLE zaposlenik;
DROP TABLE gost;
DROP TABLE ekipa_za_kviz;
DROP TABLE ekipa_za_belu;

CREATE TABLE ekipa_za_belu(
ekipa_za_belu_id INTEGER CONSTRAINT ekipa_za_belu_pk PRIMARY KEY,
naziv VARCHAR2(60) NOT NULL,
rezultat INTEGER NOT NULL
);

CREATE TABLE ekipa_za_kviz(
ekipa_za_kviz_id INTEGER CONSTRAINT ekipa_za_kviz_pk PRIMARY KEY,
naziv VARCHAR2(60) NOT NULL,
rezultat INTEGER NOT NULL
);

CREATE TABLE gost(
    OIB CHAR(11) CONSTRAINT gost_pk PRIMARY KEY,
    ime VARCHAR2(20) NOT NULL,
    prezime VARCHAR2(20) NOT NULL,
    email CHAR(50) NOT NULL,
    ekipa_za_belu_id INTEGER CONSTRAINT gost_fk_ekipa_za_belu_id REFERENCES ekipa_za_belu (ekipa_za_belu_id),
    ekipa_za_kviz_id INTEGER CONSTRAINT gost_fk_ekipa_za_kviz_id REFERENCES ekipa_za_kviz (ekipa_za_kviz_id)
);

CREATE TABLE sahovska_simultanka(
    sahovska_simultanka_id INTEGER CONSTRAINT sahovska_simultanka_pk PRIMARY KEY,
    naziv VARCHAR2(60) NOT NULL,
    rezultat INTEGER NOT NULL,
    OIB CHAR(11) NOT NULL CONSTRAINT sahovska_simultanka_fk_gost_OIB REFERENCES gost(OIB)
    --nagrada_id INTEGER CONSTRAINT sahovska_simultanka_fk_nagrada_id REFERENCES nagrada(nagrada_id)
);


CREATE TABLE zaposlenik(
    zaposlenik_OIB CHAR(11) NOT NULL CONSTRAINT zaposlenik_fk_gost REFERENCES gost(OIB),
    vrsta_posla VARCHAR2(100) NOT NULL,
    CONSTRAINT zaposlenik_pk PRIMARY KEY (zaposlenik_OIB)
);

CREATE TABLE projekt(
    projekt_id INTEGER CONSTRAINT projekt_id_pk PRIMARY KEY,
    naziv VARCHAR2(50) NOT NULL,
    kolegij VARCHAR2(50) NOT NULL,
    ocjena INTEGER NOT NULL,
    zaposlenik_OIB CHAR(11) NOT NULL CONSTRAINT projekt_fk_zaposlenik_OIB REFERENCES gost(OIB)
    --zaposlenik_OIB CHAR(11) NOT NULL CONSTRAINT projekt_fk_zaposlenik_OIB REFERENCES zaposlenik(zaposlenik_OIB),
    --nagrada_id INTEGER CONSTRAINT projekt_fk_nagrada_id REFERENCES nagrada (nagrada_id)
);

CREATE TABLE student(
    student_id CHAR(11) NOT NULL CONSTRAINT student_fk_gost REFERENCES gost(OIB),
    JMBAG CHAR(10) NOT NULL,
    projekt_id INTEGER CONSTRAINT student_fk_projekt_id REFERENCES projekt (projekt_id),
    CONSTRAINT student_pk PRIMARY KEY (student_id)
);

CREATE TABLE nagrada(
    nagrada_id INTEGER CONSTRAINT nagrada_id_pk PRIMARY KEY,
    kategorija VARCHAR2(60) NOT NULL,
    naziv VARCHAR2(60) NOT NULL,
    ekipa_za_belu_id INTEGER CONSTRAINT nagrada_fk_ekipa_za_belu_id REFERENCES ekipa_za_belu (ekipa_za_belu_id),
    ekipa_za_kviz_id INTEGER CONSTRAINT nagrada_fk_ekipa_za_kviz_id REFERENCES ekipa_za_kviz (ekipa_za_kviz_id),
    sahovska_simultanka_id INTEGER CONSTRAINT nagrada_fk_sahovska_simultanka REFERENCES sahovska_simultanka (sahovska_simultanka_id),
    projekt_id INTEGER CONSTRAINT nagrada_fk_projekt_id REFERENCES projekt(projekt_id)
);

CREATE TABLE stand(
    broj INTEGER CONSTRAINT broj_pk PRIMARY KEY
);

CREATE TABLE namirnice(
    namirnice_id INTEGER CONSTRAINT namirnice_id_pk PRIMARY KEY,
    tip VARCHAR2(50) NOT NULL,
    vrsta VARCHAR2(50) NOT NULL,
    kolicina BINARY_FLOAT NOT NULL,
    cijena BINARY_FLOAT NOT NULL,
    mjerna_jedinica VARCHAR2(5) NOT NULL,
    trgovina VARCHAR(20) NOT NULL
);

CREATE TABLE isporuka(
    vrijeme VARCHAR2(6) NOT NULL,
    kolicina INTEGER NOT NULL,
    namirnice_id INTEGER NOT NULL CONSTRAINT isporuka_fk_namirnice_id REFERENCES namirnice (namirnice_id),
    stand_broj INTEGER NOT NULL CONSTRAINT isporuka_fk_stand_broj REFERENCES stand (broj),
    CONSTRAINT isporuka_pk PRIMARY KEY (namirnice_id, stand_broj, vrijeme)
);

CREATE TABLE dezurstvo(
    vrijeme_pocetka CHAR(50) NOT NULL,
    vrijeme_kraja CHAR(50) NOT NULL,
    stand_broj INTEGER NOT NULL CONSTRAINT dezurstvo_fk_stand_broj REFERENCES stand (broj),
    zaposlenik_OIB CHAR(11) NOT NULL CONSTRAINT dezurstvo_fk_zaposlenik_OIB REFERENCES gost(OIB),
    CONSTRAINT dezurstvo_pk PRIMARY KEY (stand_broj, zaposlenik_OIB, vrijeme_pocetka)
);

---------------------- ZADATAK 2 -----------------------

--ekipe--
INSERT INTO ekipa_za_belu VALUES (1, 'Dvojac', 199);
INSERT INTO ekipa_za_belu VALUES (2, 'Bobi', 290);
INSERT INTO ekipa_za_belu VALUES (3, 'Lovac u žitu', 300);
INSERT INTO ekipa_za_belu VALUES (4, 'Dinamièan duo', 400);
INSERT INTO ekipa_za_belu VALUES (5, 'Haskelaši', 500);
INSERT INTO ekipa_za_belu VALUES (6, 'Duo Fantastico', 600);
INSERT INTO ekipa_za_belu VALUES (7, 'Kralj i kraljica', 700);
INSERT INTO ekipa_za_belu VALUES (8, 'Bella', 1001);
INSERT INTO ekipa_za_belu VALUES (9, 'Paran par za bijelu belu', 940);
INSERT INTO ekipa_za_belu VALUES (10, 'Bili pivac', 670);

INSERT INTO ekipa_za_kviz VALUES (11, 'Tim(ion i Pumbaa)', 650);
INSERT INTO ekipa_za_kviz VALUES (12, 'Kvizaši', 456);
INSERT INTO ekipa_za_kviz VALUES (13, 'Sveznala èetvorka', 467);
INSERT INTO ekipa_za_kviz VALUES (14, 'Ekipa1', 678);
INSERT INTO ekipa_za_kviz VALUES (15, 'Pobjednici', 342);
INSERT INTO ekipa_za_kviz VALUES (16, 'Raèunarci', 333);
INSERT INTO ekipa_za_kviz VALUES (17, 'Bilje Merkanti', 289);
INSERT INTO ekipa_za_kviz VALUES (18, 'Pi', 256);
INSERT INTO ekipa_za_kviz VALUES (19, 'Najjaèi', 589);
INSERT INTO ekipa_za_kviz VALUES (20, 'Ko kec na desetku', 500);

---- GOSTI -----
--profesori--
INSERT INTO gost VALUES (11111111111, 'Danijela', 'Jaganjac', 'djaganja@mathos.hr', 9, 13);
INSERT INTO gost VALUES (11111111112, 'Mateja', 'Ðumiæ', 'mdjumic@mathos.hr',9,20);
INSERT INTO gost VALUES (11111111113, 'Slobodan', 'Jeliæ', 'sjelic@mathos.hr',5,13);
INSERT INTO gost VALUES (11111111114, 'Rebeka', 'Èoriæ', 'rcoric@mathos.hr',6,13);
INSERT INTO gost VALUES (11111111115, 'Suzana', 'Miodragoviæ', 'ssusic@mathos.hr', null,20);
INSERT INTO gost VALUES (11111111116, 'Domagoj', 'Ševerdija', 'dseverdija@mathos.hr', 2,14);
INSERT INTO gost VALUES (11111111117, 'Zoran', 'Tomljanoviæ', 'kpopovic@mathos.hr',null,14);
INSERT INTO gost VALUES (11111111118, 'Jurica', 'Maltar', 'jmaltar@mathos.hr', 2,16);
INSERT INTO gost VALUES (11111111119, 'Domagoj', 'Matijeviæ', 'dmatijevic@mathos.hr',null, 16);
INSERT INTO gost VALUES (11111111110, 'Nenad', 'Šuvak', 'nsuvak@mathos.hr',3,15);
--nenastvano osoblje--
INSERT INTO gost VALUES (21111111111, 'Antonija Ljilja', 'Bassi', 'ljilja@mathos.hr',4,15);
INSERT INTO gost VALUES (31111111111, 'Vlado', 'Fotak', 'vfotak@mathos.hr',null,14);
INSERT INTO gost VALUES (41111111111, 'Zita', 'Guliæ', 'zgulic@mathos.hr',4,20);
INSERT INTO gost VALUES (51111111111, 'Marija', 'Opaèak', 'mopacak@mathos.hr',10,15);
INSERT INTO gost VALUES (61111111111, 'Lidija', 'Radan', 'lidija@mathos.hr',null,20);
INSERT INTO gost VALUES (63111111111, 'Katica', 'Popoviæ', 'kpopovic@mathos.hr',null,19);
INSERT INTO gost VALUES (64111111111, 'Jan', 'Valenta', 'jvalenta@mathos.hr', 3,19);

--studenti--

INSERT INTO gost VALUES (71111111111, 'Marko', 'Mariæ', 'mmaric@mathos.hr', 1, 11);
INSERT INTO gost VALUES (81111111111, 'Ivan', 'Iviæ', 'iivic@mathos.hr',7, 11);
INSERT INTO gost VALUES (91111111111, 'Pero', 'Periæ', 'pperic@mathos.hr',null,12);
INSERT INTO gost VALUES (22111111111, 'Jozo', 'Joziæ', 'jjozic@mathos.hr', 1,12);
INSERT INTO gost VALUES (33111111111, 'Petar', 'Petroviæ', 'ppetrovic@mathos.hr',10,12);
INSERT INTO gost VALUES (44111111111, 'Josipa', 'Joviæ', 'jjovic@mathos.hr',8,17);
INSERT INTO gost VALUES (55111111111, 'Stipe', 'Stipiæ', 'sstipic@mathos.hr',8,17);
INSERT INTO gost VALUES (66111111111, 'Maja', 'Majiæ', 'mmajic@mathos.hr',7,18);
INSERT INTO gost VALUES (77111111111, 'Marijan', 'Markoviæ', 'mmarkovic@mathos.hr',5,19);
INSERT INTO gost VALUES (88111111111, 'Marina', 'Mariniæ', 'mmarinic@mathos.hr',6,18);
 
INSERT INTO gost VALUES (99111111111, 'Ana', 'Aniæ', 'aanic@mathos.hr', null,16);
INSERT INTO gost VALUES (22211111111, 'Beta', 'Betiæ', 'bbetic@mathos.hr',null,17);
INSERT INTO gost VALUES (33311111111, 'Cvjetka', 'Cvjetiæ', 'ccvjetic@mathos.hr',null,18);
INSERT INTO gost VALUES (44411111111, 'Damir', 'Dariæ', 'ddaric@mathos.hr', null,19);
INSERT INTO gost VALUES (55511111111, 'Goran', 'Gordiæ', 'ggordic@mathos.hr',null, 11);
INSERT INTO gost VALUES (66611111111, 'Franjo', 'Franjiæ', 'ffranjic@mathos.hr',null, 13 );

SELECT * FROM gost;
-----------------
INSERT INTO sahovska_simultanka VALUES (21, 'Listopad', 2000, 11111111114);
INSERT INTO sahovska_simultanka VALUES (22, 'Pobjeda', 2577, 21111111111);
INSERT INTO sahovska_simultanka VALUES (23, 'Damin gambit', 2801, 88111111111);
INSERT INTO sahovska_simultanka VALUES (24, 'A-zvijezda', 2254, 55111111111);
INSERT INTO sahovska_simultanka VALUES (25, 'Magnus', 2444, 22111111111);
INSERT INTO sahovska_simultanka VALUES (26, 'Kasparov', 2005, 71111111111);
INSERT INTO sahovska_simultanka VALUES (27, 'Top', 2675, 11111111117);
INSERT INTO sahovska_simultanka VALUES (28, 'Lovac', 2111, 11111111110);
INSERT INTO sahovska_simultanka VALUES (29, 'C5', 2775, 61111111111);
INSERT INTO sahovska_simultanka VALUES (30, 'Šah mat', 2571, 81111111111);

SELECT * FROM sahovska_simultanka;
-------------------
--PROJEKTI--
INSERT INTO projekt VALUES (31, 'projekt1', 'Ugraðeni sustavi', 5, 11111111118);
INSERT INTO projekt VALUES (32, 'projekt2', 'Strojno uèenje', 5, 11111111119);
INSERT INTO projekt VALUES (33, 'projekt3', '3D raèunalna grafika', 4, 11111111116);
INSERT INTO projekt VALUES (34, 'projekt4', 'Sluèajni procesi', 4, 11111111110);
INSERT INTO projekt VALUES (35, 'projekt5', 'Osnove teorije upravljanja', 4, 11111111117);

SELECT * FROM projekt;

--NAGRADE--
INSERT INTO nagrada VALUES (36, 'putovanje', 'Posjet Plitvièkim jezerima', null, null, null, 31);
INSERT INTO nagrada VALUES (37, 'putovanje', 'Odlazak u Kataloniju', null, null, null,32);
INSERT INTO nagrada VALUES (38, 'poklon paket', 'Poklon paket tvornice èokolade', null, 14, null, null);
INSERT INTO nagrada VALUES (39, 'poklon paket', 'Poklon paket informatièke trgovine', 8, null, null, null);
INSERT INTO nagrada VALUES (40, 'putovanje', 'Putovanje na festival Exit', null, null, 23, null);

SELECT * FROM nagrada;

--STUDENTI--
INSERT INTO student VALUES (71111111111, 0000000001, null);
INSERT INTO student VALUES (81111111111, 0000000002, 31);
INSERT INTO student VALUES (91111111111, 0000000003, null);
INSERT INTO student VALUES (22111111111, 0000000004, 32);
INSERT INTO student VALUES (33111111111, 0000000005, 33);
INSERT INTO student VALUES (44111111111, 0000000006, null);
INSERT INTO student VALUES (55111111111, 0000000007, 34);
INSERT INTO student VALUES (66111111111, 0000000008, null);
INSERT INTO student VALUES (77111111111, 0000000009, 35);
INSERT INTO student VALUES (88111111111, 0000000010, null);

SELECT * FROM student;

--PORFESORI-- 
INSERT INTO zaposlenik VALUES (11111111111, 'asistent');
INSERT INTO zaposlenik VALUES (11111111112, 'profesor');
INSERT INTO zaposlenik VALUES (11111111113, 'profesor');
INSERT INTO zaposlenik VALUES (11111111114, 'asistent');
INSERT INTO zaposlenik VALUES (11111111115, 'profesor');
INSERT INTO zaposlenik VALUES (11111111116, 'profesor');
INSERT INTO zaposlenik VALUES (11111111117, 'profesor');
INSERT INTO zaposlenik VALUES (11111111118, 'asistent');
INSERT INTO zaposlenik VALUES (11111111119, 'profesor');
INSERT INTO zaposlenik VALUES (11111111110, 'profesor');


--ADMINISTRATIVNO I POMOCNO OSOBLJE--
INSERT INTO zaposlenik VALUES (21111111111, 'voditeljica Odsjeka za preddiplomske i diplomske studije ');
INSERT INTO zaposlenik VALUES (31111111111, 'tajnik Odjela');
INSERT INTO zaposlenik VALUES (41111111111, 'voditeljica Odsjeka raèunovodstvenih poslova ');
INSERT INTO zaposlenik VALUES (51111111111, 'voditeljica Odsjeka raèunovodstvenih poslova u Uredu za financije i raèunovodstvo ');
INSERT INTO zaposlenik VALUES (61111111111, 'voditeljica Ureda proèelnika');

SELECT * FROM zaposlenik;

--ŠTANDOVI--
INSERT INTO stand VALUES (1);
INSERT INTO stand VALUES (2);
INSERT INTO stand VALUES (3);
INSERT INTO stand VALUES (4);

SELECT * FROM stand;

--NAMIRNICE--
INSERT INTO namirnice VALUES (01, 'æevapi', 'hrana', 10, 30, 'kg', 'Onzum');
INSERT INTO namirnice VALUES (02, 'pljeskavice', 'hrana', 40, 6, 'kg', 'Onzum');
INSERT INTO namirnice VALUES (03, 'lepinje', 'hrana', 15, 20, 'kg', 'Onzum');
INSERT INTO namirnice VALUES (04, 'umak', 'dodatak', 5, 16, 'kg', 'Onzum');
INSERT INTO namirnice VALUES (05, 'rajèica', 'povræe', 5, 15, 'kg', 'Onzum');
INSERT INTO namirnice VALUES (06, 'luk', 'povræe', 5, 5, 'kg', 'Onzum');
INSERT INTO namirnice VALUES (07, 'salata', 'povræe', 5, 5, 'kg', 'Onzum');

INSERT INTO namirnice VALUES (08, 'voda', 'piæe', 30, 2, 'L', 'Ldil');
INSERT INTO namirnice VALUES (09, 'sok', 'piæe', 20, 12, 'L', 'Ldil');
INSERT INTO namirnice VALUES (010, 'pivo', 'piæe', 30, 14, 'L', 'Ldil');
INSERT INTO namirnice VALUES (011, 'mineralna voda', 'piæe', 20, 13, 'L', 'Ldil');

SELECT * FROM namirnice;

--ISPORUKA--
INSERT INTO isporuka VALUES ('13:00', 1, 01, 1);
INSERT INTO isporuka VALUES ('13:00', 5, 09, 2);
INSERT INTO isporuka VALUES ('14:00', 2, 02, 3);
INSERT INTO isporuka VALUES ('14:30', 2, 09, 4);
INSERT INTO isporuka VALUES ('15:00', 30, 03, 1);
INSERT INTO isporuka VALUES ('16:00', 20, 04, 2);
INSERT INTO isporuka VALUES ('16:30', 5, 010, 3);
INSERT INTO isporuka VALUES ('16:45', 2, 01, 4);
INSERT INTO isporuka VALUES ('17:00', 3, 08, 4);
INSERT INTO isporuka VALUES ('17:15', 15, 03, 1);

SELECT * FROM isporuka;

--DEŽURSTVA--
INSERT INTO dezurstvo VALUES (to_date('12:00', 'hh24:mi'), to_date('13:05', 'hh24:mi'), 1, 11111111111);
INSERT INTO dezurstvo VALUES (to_date('13:10', 'hh24:mi'), to_date('14:00', 'hh24:mi'), 1, 11111111112);
INSERT INTO dezurstvo VALUES (to_date('14:30', 'hh24:mi'), to_date('16:40', 'hh24:mi'), 2, 11111111113);
INSERT INTO dezurstvo VALUES (to_date('13:15', 'hh24:mi'), to_date('14:05', 'hh24:mi'), 2, 11111111114);
INSERT INTO dezurstvo VALUES (to_date('14:45', 'hh24:mi'), to_date('15:40', 'hh24:mi'), 4, 64111111111);
INSERT INTO dezurstvo VALUES (to_date('16:00', 'hh24:mi'), to_date('17:10', 'hh24:mi'), 4, 11111111116);
INSERT INTO dezurstvo VALUES (to_date('15:20', 'hh24:mi'), to_date('16:15', 'hh24:mi'), 3, 63111111111);
INSERT INTO dezurstvo VALUES (to_date('14:10', 'hh24:mi'), to_date('14:35', 'hh24:mi'), 2, 11111111111);
INSERT INTO dezurstvo VALUES (to_date('14:10', 'hh24:mi'), to_date('14:40', 'hh24:mi'), 3, 11111111112);
INSERT INTO dezurstvo VALUES (to_date('17:20', 'hh24:mi'), to_date('18:00', 'hh24:mi'), 3, 63111111111);
INSERT INTO dezurstvo VALUES (to_date('18:15', 'hh24:mi'), to_date('18:30', 'hh24:mi'), 4, 11111111114);
INSERT INTO dezurstvo VALUES (to_date('16:45', 'hh24:mi'), to_date('17:40', 'hh24:mi'), 1, 64111111111);

SELECT * FROM dezurstvo;

---------------------- ZADATAK 3 -----------------------

SELECT ROWNUM, naziv, rezultat FROM ekipa_za_kviz;

SELECT COUNT(*) FROM dezurstvo;

SELECT ime || ', ' || prezime || ', ' || email "osobni podatci" FROM gost;

--SELECT zaposlenik_OIB || vrijeme_kraja - vrijeme_pocetka "Smjena" FROM dezurstvo; 

SELECT tip, cijena/2 "Cijena s popustom" FROM namirnice
WHERE mjerna_jedinica = 'kg';

SELECT DISTINCT zaposlenik_OIB FROM dezurstvo;

SELECT tip FROM namirnice 
WHERE trgovina = 'Onzum' AND mjerna_jedinica = 'kg' AND (cijena < 70 AND cijena>10);

---------------------- ZADATAK 4 -----------------------
--a
SELECT gost.ime, gost.prezime FROM gost, dezurstvo
WHERE gost.OIB = dezurstvo.zaposlenik_OIB AND 
(dezurstvo.vrijeme_pocetka BETWEEN '13:00' AND '16:00' OR dezurstvo.vrijeme_kraja BETWEEN '13:00' AND '16:00');

--b ok
SELECT gost.ime, gost.prezime FROM gost, projekt
WHERE gost.OIB = projekt.zaposlenik_OIB AND projekt.zaposlenik_OIB != ALL (SELECT zaposlenik_OIB FROM dezurstvo);

--c ok
SELECT gost.ime, gost.prezime FROM gost, projekt
WHERE gost.OIB = projekt.zaposlenik_OIB AND projekt.ocjena = '5';

--d  ok
SELECT DISTINCT gost.ime, gost.prezime FROM gost, ekipa_za_kviz, student
WHERE gost.ekipa_za_kviz_id = ekipa_za_kviz.ekipa_za_kviz_id AND student.student_id = gost.OIB;

--e
SELECT namirnice.tip, namirnice.vrsta, gost.OIB
FROM namirnice, isporuka, gost
WHERE namirnice.namirnice_id = isporuka.namirnice_id and isporuka.stand_broj = '4' and gost.OIB = '11111111116';

--SELECT namirnice.tip, namirnice.vrsta, 
--FROM namirnice, isporuka, gost, stand, dezurstvo 
--WHERE isporuka.stand_broj = stand.broj and isporuka.namirnice_id = namirnice.namirnice_id and 
--dezurstvo.stand_broj = stand.broj and dezurstvo.zaposlenik_OIB = gost.OIB
--and gost.ime = 'Domagoj' and gost.prezime = 'Ševerdija';

--f
--SELECT DISTINCT OIB, ime, prezime, email
--FROM gost, sahovska_simultanka, ekipa_za_belu, ekipa_za_kviz
--WHERE (gost.ekipa_za_belu_ID = ekipa_za_belu.ekipa_za_belu_id and gost.ekipa_za_kviz_id = ekipa_za_kviz.ekipa_za_kviz_id) or
--(gost.ekipa_za_belu_id = ekipa_za_belu.ekipa_za_belu_id and gost.OIB = sahovska_simultanka.OIB) or
--(gost.ekipa_za_kviz_id = ekipa_za_kviz.ekipa_za_kviz_id and gost.OIB = sahovska_simultanka.OIB) or
--(gost.ekipa_za_kviz_id = ekipa_za_kviz.ekipa_za_kviz_id and gost.OIB = sahovska_simultanka.OIB and 
--gost.ekipa_za_belu_id = ekipa_za_belu.ekipa_za_belu_id);

--g
SELECT SUM(cijena)/COUNT(namirnice_id) FROM namirnice;
