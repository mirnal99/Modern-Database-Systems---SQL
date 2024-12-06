DROP TABLE vrijeme_dolaska;
DROP TABLE teretana;
DROP TABLE grupni_trening_�lan;
DROP TABLE grupni_trening;
DROP TABLE sauna_�lan;
DROP TABLE sauna;
DROP TABLE masa�a;
DROP TABLE zaposlenik_smjena;
DROP TABLE smjena;
DROP TABLE �lanarina;
DROP TABLE �lan;
DROP TABLE zaposlenik;
DROP TABLE fitness_centar;

------TABLICE------

CREATE TABLE fitness_centar(
    fitness_id INTEGER CONSTRAINT fitness_centar_PK PRIMARY KEY,
    naziv VARCHAR2(20) NOT NULL,
    adresa VARCHAR2(50) NOT NULL,
    kat_broj INTEGER NOT NULL,
    radno_vrijeme_pocetak VARCHAR2(10) NOT NULL,
    radno_vrijeme_kraj VARCHAR2(10) NOT NULL,
    telefon VARCHAR2(15) NOT NULL,
    email VARCHAR2(30) NOT NULL
);

CREATE TABLE �lan(
    �lan_OIB VARCHAR2(20) CONSTRAINT �lan_OIB_pk PRIMARY KEY,
    ime VARCHAR2(20) NOT NULL,
    prezime VARCHAR2(20) NOT NULL,
    datum_rodjenja DATE NOT NULL,
    spol VARCHAR2(5) NOT NULL,
    telefon VARCHAR2(15) NOT NULL,
    email VARCHAR2(50)
);

CREATE TABLE �lanarina(
    fitness_id INTEGER CONSTRAINT fitness_id_fk REFERENCES fitness_centar (fitness_id),
    �lan_OIB VARCHAR2(20) CONSTRAINT �lan_OIB_fk REFERENCES �lan(�lan_OIB),
    tip_�lanarine VARCHAR2(30) NOT NULL,
    cijena INTEGER NOT NULL,
    datum_u�lanjenja DATE NOT NULL,
    CONSTRAINT �lanarina_pk PRIMARY KEY (fitness_id, �lan_OIB)
);


CREATE TABLE zaposlenik(
    zaposlenik_OIB VARCHAR2(20) CONSTRAINT zaposlenik_OIB_pk PRIMARY KEY,
    ime VARCHAR2(20) NOT NULL,
    prezime VARCHAR2(20) NOT NULL,
    spol VARCHAR2(5) NOT NULL,
    vrsta_posla VARCHAR2(50) NOT NULL,
    pla�a INTEGER NOT NULL,
    fitness_id INTEGER NOT NULL CONSTRAINT fitness_centarr_id_zaposlenikk_fk REFERENCES fitness_centar(fitness_id)
);

CREATE TABLE smjena(
    smjena_broj INTEGER CONSTRAINT smjena_pk PRIMARY KEY,
    datum VARCHAR2(10) NOT NULL,
    po�etak DATE NOT NULL,
    kraj DATE NOT NULL
);

CREATE TABLE zaposlenik_smjena( 
    smjena_broj INTEGER NOT NULL CONSTRAINT zs_smjena_fk REFERENCES smjena(smjena_broj),
    zaposlenik_OIB VARCHAR2(20) NOT NULL CONSTRAINT zs_zaposlenik_fk REFERENCES zaposlenik(zaposlenik_OIB),
    CONSTRAINT zs_pk PRIMARY KEY (smjena_broj, zaposlenik_OIB)
);

CREATE TABLE masa�a(
    masa�a_id INTEGER CONSTRAINT masa�a_pk PRIMARY KEY,
    vrsta_masa�e VARCHAR2(20) NOT NULL,
    broj_prostorije INTEGER NOT NULL,
    cijena INTEGER NOT NULL,
    �lan_OIB VARCHAR2(20) NOT NULL CONSTRAINT �lan_masa�a_fk REFERENCES �lan(�lan_OIB),
    zaposlenik_OIB VARCHAR2(20) NOT NULL CONSTRAINT zaposlenik_masa�a_fk REFERENCES zaposlenik(zaposlenik_OIB)
);

CREATE TABLE sauna(
    sauna_id INTEGER CONSTRAINT sauna_pk PRIMARY KEY,
    broj_saune INTEGER NOT NULL,
    temperatura INTEGER NOT NULL, -- �c
    trajanje INTEGER NOT NULL,     -- min
    cijena INTEGER NOT NULL        -- kn
);

CREATE TABLE sauna_�lan( 
    sauna_id INTEGER NOT NULL CONSTRAINT sauna_�lan_id_fk REFERENCES sauna(sauna_id),
    �lan_OIB VARCHAR2(20) NOT NULL CONSTRAINT sauna_�lan_oib_fk REFERENCES �lan(�lan_OIB),
    CONSTRAINT sauna_�lan_pk PRIMARY KEY (sauna_id, �lan_OIB)
);

CREATE TABLE grupni_trening(
    trening_id INTEGER CONSTRAINT trening_pk PRIMARY KEY,
    naziv_grupe VARCHAR2(20) NOT NULL,
    broj_prostorije INTEGER NOT NULL,
    pocetak DATE NOT NULL,
    kraj DATE NOT NULL,
    zaposlenik_OIB VARCHAR2(20) NOT NULL CONSTRAINT zaposlenik_trening_fk REFERENCES zaposlenik(zaposlenik_OIB)
);

CREATE TABLE grupni_trening_�lan( 
    trening_id INTEGER NOT NULL CONSTRAINT trening_�lan_id_fk REFERENCES grupni_trening(trening_id),
    �lan_OIB VARCHAR2(20) NOT NULL CONSTRAINT trening_�lan_�lan_oib_fk REFERENCES �lan(�lan_OIB),
    CONSTRAINT trening_�lan_pk PRIMARY KEY (trening_id, �lan_OIB)
);

CREATE TABLE teretana( 
    teretana_id INTEGER CONSTRAINT teretana_id_pk PRIMARY KEY,
    broj_prostorije INTEGER NOT NULL,
    kapacitet INTEGER NOT NULL, --broj ljudi koji mogu biti unutra u isto vrijeme
    glazba VARCHAR2(20) NOT NULL --vrsta glazbe
);

CREATE TABLE vrijeme_dolaska(
    teretana_id INTEGER NOT NULL CONSTRAINT teretana_vrijeme_id_fk REFERENCES teretana(teretana_id),
    �lan_OIB VARCHAR2(20) NOT NULL CONSTRAINT �lan_vrijeme_fk REFERENCES �lan(�lan_OIB),
    dolazak DATE NOT NULL,
    odlazak DATE NOT NULL,
    CONSTRAINT vrijeme_dolaska_pk PRIMARY KEY (teretana_id, �lan_OIB)
);

------BRISANJE PODATAKA------
DELETE FROM vrijeme_dolaska;
DELETE FROM teretana;
DELETE FROM grupni_trening_�lan;
DELETE FROM grupni_trening;
DELETE FROM sauna_�lan;
DELETE FROM sauna;
DELETE FROM masa�a;
DELETE FROM zaposlenik_smjena;
DELETE FROM smjena;
DELETE FROM �lanarina;
DELETE FROM �lan;
DELETE FROM zaposlenik;
DELETE FROM fitness_centar;

------UNOSI------
INSERT INTO fitness_centar VALUES (000, 'Planet Fitness', 'Sjenjak 111, Osijek',
                1, '05:00h', '23:00h', '031 782 168', 'planet.fitness@gmail.com');

INSERT INTO �lan VALUES ('00000000000', 'An�ela', 'Borbas', TO_DATE('2000/06/01', 'yyyy/mm/dd '), 
                        '�', '0914836841', 'aborbas@gmail.com');
INSERT INTO �lan VALUES ('00000000001', 'Mia', 'Caklovi�', TO_DATE('1998/05/21', 'yyyy/mm/dd '),
                        '�', '0914589841', 'mcaklovic@gmail.com');
INSERT INTO �lan VALUES ('00000000002', 'Vanesa', 'Abramovi�', TO_DATE('2000/03/05', 'yyyy/mm/dd '),
                        '�', '0914836899', 'vabramovic@gmail.com');
INSERT INTO �lan VALUES ('00000000003', 'Jelena', '�ori�', TO_DATE('2001/08/11', 'yyyy/mm/dd '), 
                        '�', '0914116841', 'jcoric@gmail.com');
INSERT INTO �lan VALUES ('00000000004', 'Tena', 'Su�i�', TO_DATE('1989/10/01', 'yyyy/mm/dd '),
                        '�', '0920836841', 'tsusic@gmail.com');
INSERT INTO �lan VALUES ('00000000005', 'Josipa', 'Gavri�', TO_DATE('1997/12/07', 'yyyy/mm/dd '), 
                        '�', '0914716841', 'jgavric@gmail.com');
INSERT INTO �lan VALUES ('00000000006', 'Kristina', 'Vlahek', TO_DATE('2002/09/07', 'yyyy/mm/dd '), 
                        '�', '0914834441', 'kvlahek@gmail.com');
INSERT INTO �lan VALUES ('00000000007', 'Dunja', 'Kalbot', TO_DATE('2003/01/19', 'yyyy/mm/dd '), 
                        '�', '0914636241', 'dkalbot@gmail.com');
INSERT INTO �lan VALUES ('00000000008', 'Nika', 'Franji�', TO_DATE('1994/10/20', 'yyyy/mm/dd '),
                        '�', '0914833341', 'nfranjic@gmail.com');
INSERT INTO �lan VALUES ('00000000009', 'Ivana', 'Jeli�', TO_DATE('1989/02/04', 'yyyy/mm/dd '),
                        '�', '0914836855', 'ijelic@gmail.com');
INSERT INTO �lan VALUES ('00000000010', 'Marko', 'Gali�', TO_DATE('1991/06/09', 'yyyy/mm/dd '),
                        'm', '0914895815', 'mgalic@gmail.com');
INSERT INTO �lan VALUES ('00000000011', 'Petar', 'Begi�', TO_DATE('1996/08/16', 'yyyy/mm/dd '),
                        'm', '0914895225', 'pbegic@gmail.com');
INSERT INTO �lan VALUES ('00000000012', 'Ivan', 'Sitar', TO_DATE('1998/07/19', 'yyyy/mm/dd '),
                        'm', '0914895833', 'isitar@gmail.com');
INSERT INTO �lan VALUES ('00000000013', 'Kristijan', 'Vuli�', TO_DATE('1995/03/01', 'yyyy/mm/dd '),
                        'm', '0914890015', 'kvulic@gmail.com');
INSERT INTO �lan VALUES ('00000000014', 'Feliks', 'Martinovi�', TO_DATE('1997/11/25', 'yyyy/mm/dd '),
                        'm', '0914894813', 'fmartinovic@gmail.com');
INSERT INTO �lan VALUES ('00000000015', 'Matija', 'Tori�', TO_DATE('1999/06/29', 'yyyy/mm/dd '),
                        'm', '0914865810', 'mtoric@gmail.com');
INSERT INTO �lan VALUES ('00000000016', 'Julija', 'Pavi�', TO_DATE('1999/06/09', 'yyyy/mm/dd '),
                        '�', '0917892215', 'jpavic@gmail.com');
INSERT INTO �lan VALUES ('00000000017', 'Andrea', 'Kutli�', TO_DATE('2003/05/07', 'yyyy/mm/dd '),
                        '�', '0916897815', 'akutlic@gmail.com');
INSERT INTO �lan VALUES ('00000000018', 'Petra', '�orkovi�', TO_DATE('1967/03/02', 'yyyy/mm/dd '),
                        '�', '0914899915', 'pcorkovic@gmail.com');
INSERT INTO �lan VALUES ('00000000019', 'Toni', 'Klobu�ar', TO_DATE('1988/08/15', 'yyyy/mm/dd '),
                        'm', '0914891818', 'tklobucar@gmail.com');
INSERT INTO �lan VALUES ('00000000020', 'Josip', 'Vukovi�', TO_DATE('1965/05/29', 'yyyy/mm/dd '),
                        'm', '0914595815', 'jvukovic@gmail.com');
INSERT INTO �lan VALUES ('00000000021', 'Kristina', 'Hajmiler', TO_DATE('1995/07/30', 'yyyy/mm/dd '),
                        '�', '0914596818', 'khajmiler@gmail.com');
INSERT INTO �lan VALUES ('00000000022', 'Mario', 'Ivanu�a', TO_DATE('1987/09/23', 'yyyy/mm/dd '),
                        'm', '0914595816', 'mivanusa@gmail.com');
INSERT INTO �lan VALUES ('00000000023', 'Luka', 'Ani�i�', TO_DATE('1998/03/23', 'yyyy/mm/dd '),
                        'm', '0913595813', 'lanicic@gmail.com');
INSERT INTO �lan VALUES ('00000000024', 'Andrej', 'Vini�', TO_DATE('1974/07/18', 'yyyy/mm/dd '),
                        'm', '0918895815', 'avinic@gmail.com');
INSERT INTO �lan VALUES ('00000000025', 'Matej', 'Fer�ec', TO_DATE('1980/12/22', 'yyyy/mm/dd '),
                        'm', '0914595517', 'mfercec@gmail.com');
INSERT INTO �lan VALUES ('00000000026', 'Hrvoje', 'Milun', TO_DATE('1988/09/10', 'yyyy/mm/dd '),
                        'm', '0914358130', 'hmilun@gmail.com');
INSERT INTO �lan VALUES ('00000000027', 'Stjepan', 'Peri�', TO_DATE('2002/02/11', 'yyyy/mm/dd '),
                        'm', '0919995811', 'speric@gmail.com');
INSERT INTO �lan VALUES ('00000000028', 'Ivona', 'Lokner', TO_DATE('2004/04/01', 'yyyy/mm/dd '),
                        '�', '0914292815', 'ilokner@gmail.com');
INSERT INTO �lan VALUES ('00000000029', 'Luka', 'Kraljik', TO_DATE('1990/10/21', 'yyyy/mm/dd '),
                        'm', '0914595110', 'lkraljik@gmail.com');
INSERT INTO �lan VALUES ('00000000030', 'Lucija', 'Kuba�a', TO_DATE('1991/11/02', 'yyyy/mm/dd '),
                        '�', '0916695811', 'lkubasa@gmail.com');

--SELECT * FROM �lan;

INSERT INTO �lanarina VALUES(000,'00000000000', 'student', 150, TO_DATE('2021/05/20', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000001', 'student', 150, TO_DATE('2018/02/10', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000002', 'student', 150, TO_DATE('2020/10/22', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000003', 'u�enik', 120, TO_DATE('2021/01/27', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000004', 'radnik', 200, TO_DATE('2016/08/07', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000005', 'radnik', 200, TO_DATE('2017/07/13', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000006', 'u�enik', 120, TO_DATE('2020/09/02', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000007', 'u�enik', 120, TO_DATE('2021/04/29', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000008', 'radnik', 200, TO_DATE('2015/11/26', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000009', 'radnik', 200, TO_DATE('2019/06/11', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000010', 'radnik', 200, TO_DATE('2020/03/21', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000011', 'student', 150, TO_DATE('2019/05/19', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000012', 'student', 150, TO_DATE('2017/07/02', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000013', 'radnik', 200, TO_DATE('2015/04/07', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000014', 'student', 150, TO_DATE('2019/08/22', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000015', 'student', 150, TO_DATE('2020/10/15', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000016', 'radnik', 200, TO_DATE('2017/12/10', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000017', 'u�enik', 120, TO_DATE('2021/02/20', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000018', 'umirovljenik', 150, TO_DATE('2014/02/13', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000019', 'radnik', 200, TO_DATE('2013/10/27', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000020', 'umirovljenik', 150, TO_DATE('2013/03/18', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000021', 'radnik', 200, TO_DATE('2019/06/22', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000022', 'radnik', 200, TO_DATE('2018/08/30', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000023', 'student', 150, TO_DATE('2017/09/05', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000024', 'radnik', 200, TO_DATE('2015/10/16', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000025', 'radnik', 200, TO_DATE('2019/11/12', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000026', 'radnik', 200, TO_DATE('2015/12/10', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000027', 'student', 150, TO_DATE('2014/11/09', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000028', 'u�enik', 120, TO_DATE('2020/12/10', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000029', 'radnik', 200, TO_DATE('2014/11/22', 'yyyy/mm/dd '));
INSERT INTO �lanarina VALUES(000,'00000000030', 'radnik', 200, TO_DATE('2015/12/08', 'yyyy/mm/dd '));

INSERT INTO zaposlenik VALUES ('00000000031', 'Dario', 'Kova�evi�', 'm', 'trener', 5400, 000);
INSERT INTO zaposlenik VALUES ('00000000032', 'Kristina', 'Gavri�', '�', 'trener', 5000, 000);
INSERT INTO zaposlenik VALUES ('00000000033', 'An�ela', '�imic', '�', 'maser', 3100, 000);
INSERT INTO zaposlenik VALUES ('00000000034', 'Ana', 'Stojanovi�', '�', 'recepcionar', 3000, 000);
INSERT INTO zaposlenik VALUES ('00000000035', 'Marko', '�iri�', 'm', 'trener', 5800, 000);
INSERT INTO zaposlenik VALUES ('00000000036', 'Petar', 'Baljak', 'm', 'maser', 2850, 000);
INSERT INTO zaposlenik VALUES ('00000000037', 'Jelena', 'Dimitrijevi�', '�', '�ista�ica', 2800, 000);
INSERT INTO zaposlenik VALUES ('00000000038', 'Andrea', '�ujevi�', '�', 'maser', 2800, 000);
INSERT INTO zaposlenik VALUES ('00000000039', 'Matea', '�uk', '�', 'trener', 5750, 000);
INSERT INTO zaposlenik VALUES ('00000000040', 'Ivan', 'Juri�', 'm', 'trener', 4900, 000);
INSERT INTO zaposlenik VALUES ('00000000041', 'Stjepan', 'Gustin', 'm', 'trener', 5600, 000);
INSERT INTO zaposlenik VALUES ('00000000042', 'Iva', 'Milu�i�', '�', 'maser', 2830, 000);
INSERT INTO zaposlenik VALUES ('00000000043', 'Tomislav', 'Savi�', 'm', 'trener', 5200, 000);
INSERT INTO zaposlenik VALUES ('00000000044', 'Tarik', 'Lon�ar', 'm', 'maser', 3800, 000);
INSERT INTO zaposlenik VALUES ('00000000045', '�eljka', 'Marinovi�', 'm', '�ista�ica', 2670, 000);
INSERT INTO zaposlenik VALUES ('00000000046', 'Josip', 'Doljanin', 'm', 'recepcionar', 2900, 000);
INSERT INTO zaposlenik VALUES ('00000000047', 'Maja', 'Petrovi�', 'm', 'recepcionar', 2890, 000);

INSERT INTO smjena VALUES (1, '2021/05/20', TO_DATE('2021/05/20 05:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                            TO_DATE('2021/05/20 11:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO smjena VALUES (2, '2021/05/20', TO_DATE('2021/05/20 11:00:00', 'yyyy/mm/dd hh24:mi:ss'),  
                                            TO_DATE('2021/05/20 17:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO smjena VALUES (3, '2021/05/20', TO_DATE('2021/05/20 17:00:00', 'yyyy/mm/dd hh24:mi:ss'),  
                                            TO_DATE('2021/05/20 23:00:00', 'yyyy/mm/dd hh24:mi:ss'));

INSERT INTO zaposlenik_smjena VALUES (1, '00000000031');
INSERT INTO zaposlenik_smjena VALUES (1, '00000000033');
INSERT INTO zaposlenik_smjena VALUES (1, '00000000035');
INSERT INTO zaposlenik_smjena VALUES (1, '00000000042');
INSERT INTO zaposlenik_smjena VALUES (1, '00000000034');

INSERT INTO zaposlenik_smjena VALUES (2, '00000000032');
INSERT INTO zaposlenik_smjena VALUES (2, '00000000043');
INSERT INTO zaposlenik_smjena VALUES (2, '00000000040');
INSERT INTO zaposlenik_smjena VALUES (2, '00000000036');
INSERT INTO zaposlenik_smjena VALUES (2, '00000000045');
INSERT INTO zaposlenik_smjena VALUES (2, '00000000046');

INSERT INTO zaposlenik_smjena VALUES (3, '00000000037');
INSERT INTO zaposlenik_smjena VALUES (3, '00000000038');
INSERT INTO zaposlenik_smjena VALUES (3, '00000000041');
INSERT INTO zaposlenik_smjena VALUES (3, '00000000044');
INSERT INTO zaposlenik_smjena VALUES (3, '00000000039');
INSERT INTO zaposlenik_smjena VALUES (3, '00000000047');

INSERT INTO masa�a VALUES(10, 'sportska', 10, 180, '00000000014', '00000000033');
INSERT INTO masa�a VALUES(11, 'relaksacijska', 11, 120, '00000000021', '00000000038');
INSERT INTO masa�a VALUES(12, 'sportska', 12, 180, '00000000030', '00000000033');
INSERT INTO masa�a VALUES(13, 'medicinska', 10, 150, '00000000020', '00000000036');
INSERT INTO masa�a VALUES(14, 'klasi�na', 11, 100, '00000000007', '00000000036');
INSERT INTO masa�a VALUES(15, 'relaksacijska', 12, 120, '00000000012', '00000000038');
INSERT INTO masa�a VALUES(16, 'klasi�na', 10, 100, '00000000027', '00000000042');

INSERT INTO sauna VALUES (100, 4, 65, 15, 40); --id, br, temp, time, cijena
INSERT INTO sauna VALUES (200, 4, 65, 10, 30);
INSERT INTO sauna VALUES (300, 4, 65, 20, 60);

INSERT INTO sauna VALUES (400, 5, 75, 15, 40);
INSERT INTO sauna VALUES (500, 5, 75, 15, 40);
INSERT INTO sauna VALUES (600, 5, 75, 20, 60);

INSERT INTO sauna VALUES (700, 6, 85, 10, 30);
INSERT INTO sauna VALUES (800, 6, 85, 10, 30);
INSERT INTO sauna VALUES (900, 6, 85, 15, 40);

--SELECT * FROM sauna;

INSERT INTO sauna_�lan VALUES (100, '00000000003');
INSERT INTO sauna_�lan VALUES (100, '00000000004');

INSERT INTO sauna_�lan VALUES (200, '00000000008');
INSERT INTO sauna_�lan VALUES (200, '00000000011');
INSERT INTO sauna_�lan VALUES (200, '00000000023');

INSERT INTO sauna_�lan VALUES (300, '00000000020');

INSERT INTO sauna_�lan VALUES (400, '00000000030');

INSERT INTO sauna_�lan VALUES (500, '00000000015');
INSERT INTO sauna_�lan VALUES (500, '00000000024');

INSERT INTO sauna_�lan VALUES (600, '00000000018');
INSERT INTO sauna_�lan VALUES (600, '00000000028');
INSERT INTO sauna_�lan VALUES (600, '00000000019');

INSERT INTO sauna_�lan VALUES (700, '00000000002');

INSERT INTO sauna_�lan VALUES (800, '00000000017');
INSERT INTO sauna_�lan VALUES (800, '00000000021');

INSERT INTO sauna_�lan VALUES (900, '00000000025');
INSERT INTO sauna_�lan VALUES (900, '00000000005');
INSERT INTO sauna_�lan VALUES (900, '00000000006');

--SELECT * from sauna_�lan;

INSERT INTO grupni_trening VALUES (1000, 'Aerobik', 7, TO_DATE('2021/05/20 09:00:00', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2021/05/20 10:30:00', 'yyyy/mm/dd hh24:mi:ss'), '00000000032');
INSERT INTO grupni_trening VALUES (2000, 'Pilates', 7, TO_DATE('2021/05/20 15:00:00', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2021/05/20 16:00:00', 'yyyy/mm/dd hh24:mi:ss'), '00000000035');
INSERT INTO grupni_trening VALUES (3000, 'Tabata', 8, TO_DATE('2021/05/20 18:00:00', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2021/05/20 19:00:00', 'yyyy/mm/dd hh24:mi:ss'), '00000000040');
INSERT INTO grupni_trening VALUES (4000, 'Joga', 7, TO_DATE('2021/05/20 19:30:00', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2021/05/20 20:30:00', 'yyyy/mm/dd hh24:mi:ss'), '00000000039');
INSERT INTO grupni_trening VALUES (5000, 'Funkcionalni trening', 8, TO_DATE('2021/05/20 21:00:00', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2021/05/20 22:30:00', 'yyyy/mm/dd hh24:mi:ss'), '00000000043');

INSERT INTO grupni_trening_�lan VALUES (1000, '00000000000');
INSERT INTO grupni_trening_�lan VALUES (1000, '00000000004');
INSERT INTO grupni_trening_�lan VALUES (1000, '00000000005');
INSERT INTO grupni_trening_�lan VALUES (1000, '00000000014');
INSERT INTO grupni_trening_�lan VALUES (1000, '00000000016');
INSERT INTO grupni_trening_�lan VALUES (1000, '00000000021');
INSERT INTO grupni_trening_�lan VALUES (1000, '00000000026');

INSERT INTO grupni_trening_�lan VALUES (2000, '00000000030');
INSERT INTO grupni_trening_�lan VALUES (2000, '00000000024');
INSERT INTO grupni_trening_�lan VALUES (2000, '00000000018');
INSERT INTO grupni_trening_�lan VALUES (2000, '00000000028');

INSERT INTO grupni_trening_�lan VALUES (3000, '00000000010');
INSERT INTO grupni_trening_�lan VALUES (3000, '00000000012');
INSERT INTO grupni_trening_�lan VALUES (3000, '00000000019');
INSERT INTO grupni_trening_�lan VALUES (3000, '00000000020');
INSERT INTO grupni_trening_�lan VALUES (3000, '00000000028');
INSERT INTO grupni_trening_�lan VALUES (3000, '00000000004');
INSERT INTO grupni_trening_�lan VALUES (3000, '00000000025');

INSERT INTO grupni_trening_�lan VALUES (4000, '00000000018');
INSERT INTO grupni_trening_�lan VALUES (4000, '00000000009');
INSERT INTO grupni_trening_�lan VALUES (4000, '00000000008');
INSERT INTO grupni_trening_�lan VALUES (4000, '00000000007');

INSERT INTO grupni_trening_�lan VALUES (5000, '00000000006');
INSERT INTO grupni_trening_�lan VALUES (5000, '00000000001');
INSERT INTO grupni_trening_�lan VALUES (5000, '00000000013');
INSERT INTO grupni_trening_�lan VALUES (5000, '00000000015');
INSERT INTO grupni_trening_�lan VALUES (5000, '00000000017');
INSERT INTO grupni_trening_�lan VALUES (5000, '00000000026');
INSERT INTO grupni_trening_�lan VALUES (5000, '00000000022');

--SELECT * FROM grupni_trening_�lan;

INSERT INTO teretana VALUES(101, 9, 40, 'techno');

INSERT INTO vrijeme_dolaska VALUES(101, '00000000000', TO_DATE('2021/05/20 22:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 23:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000001', TO_DATE('2021/05/20 12:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 13:30:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000002', TO_DATE('2021/05/20 06:15:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 07:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000003', TO_DATE('2021/05/20 05:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 06:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000005', TO_DATE('2021/05/20 05:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 06:30:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000006', TO_DATE('2021/05/20 11:20:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 12:15:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000007', TO_DATE('2021/05/20 05:15:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 06:10:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000008', TO_DATE('2021/05/20 09:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 10:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000009', TO_DATE('2021/05/20 06:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 07:15:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000011', TO_DATE('2021/05/20 07:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 08:45:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000013', TO_DATE('2021/05/20 07:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 08:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000014', TO_DATE('2021/05/20 18:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 19:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000016', TO_DATE('2021/05/20 15:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 16:45:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000017', TO_DATE('2021/05/20 11:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 12:30:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000021', TO_DATE('2021/05/20 13:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 14:15:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000022', TO_DATE('2021/05/20 12:05:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 13:00:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000023', TO_DATE('2021/05/20 19:20:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 20:30:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000024', TO_DATE('2021/05/20 07:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 08:05:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000027', TO_DATE('2021/05/20 11:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 12:30:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000029', TO_DATE('2021/05/20 20:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 21:10:00', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO vrijeme_dolaska VALUES(101, '00000000030', TO_DATE('2021/05/20 22:00:00', 'yyyy/mm/dd hh24:mi:ss'), 
                                                       TO_DATE('2021/05/20 22:45:00', 'yyyy/mm/dd hh24:mi:ss'));

commit;
------------------------------------------UPITI------------------------------------------
----------------JEDNOSTAVNI UPITI----------------

--ispisati osnovne podatke iz tablice �lan

SELECT ime || ', ' || prezime || ', ' || telefon "osnovni podatci" FROM �lan;

--koliko je �lanova koritilo saunu ?

SELECT COUNT(*) AS "Ukupno" FROM sauna_�lan;

--iz tablice zaposlenik za svakog zaposlenika izra�unati kolika bi pla�a bila ako se uve�a za 20%.
--Taj stupac nazvati ''pla�a s povi�icom''

SELECT zaposlenik_OIB, vrsta_posla, pla�a "redovna pla�a", pla�a + (pla�a*0.2) "pla�a s povi�icom" FROM zaposlenik;

--ispisati broj saune �ija je temperatura vi�a od 70 �C

SELECT DISTINCT broj_saune, temperatura FROM sauna WHERE temperatura > 70;

--iz tablice �lanarina ispisati cijenu za svaku vrstu �lanarine

SELECT DISTINCT tip_�lanarine, cijena FROM �lanarina;

----------------UPITI NAD VI�E TABLICA----------------

--imena �lanova koji su bili u teretani kada i �lan s OIBom '00000000001'

SELECT  �lan.�lan_OIB, ime, prezime FROM �lan
INNER JOIN vrijeme_dolaska ON (�lan.�lan_OIB = vrijeme_dolaska.�lan_OIB)
WHERE (dolazak BETWEEN (SELECT dolazak FROM vrijeme_dolaska WHERE �lan_OIB = '00000000001')
AND (SELECT odlazak FROM vrijeme_dolaska WHERE �lan_OIB = '00000000001'))
OR (odlazak BETWEEN (SELECT dolazak FROM vrijeme_dolaska WHERE �lan_OIB = '00000000001')
AND (SELECT odlazak FROM vrijeme_dolaska WHERE �lan_OIB = '00000000001'));

--imena i prezimena �lanova koji su sudjelovali na aerobiku ili pilatesu

SELECT ime, prezime FROM �lan c
INNER JOIN grupni_trening_�lan gc USING (�lan_OIB)
INNER JOIN grupni_trening gt USING (trening_id)
WHERE naziv_grupe = any('Aerobik', 'Pilates');

--imena �lanova koji su studenti i bili su u sauni

SELECT ime, prezime, sauna.broj_saune FROM �lan
INNER JOIN sauna_�lan sc USING (�lan_OIB)
INNER JOIN sauna USING (sauna_id)
INNER JOIN �lanarina cl USING(�lan_OIB)
WHERE tip_�lanarine = 'student';

--Imena klijenata i vrstu masa�e koje je odradio zaposlenik u prvoj smjeni

SELECT ime, prezime, masa�a.vrsta_masa�e, zs.zaposlenik_OIB FROM �lan 
INNER JOIN masa�a USING (�lan_OIB)
INNER JOIN zaposlenik_smjena zs ON (masa�a.zaposlenik_OIB = zs.zaposlenik_OIB)
WHERE smjena_broj = 1;

--OIB trenera koji su vodili grupne treninge nakon 17h

SELECT z.zaposlenik_OIB, gt.naziv_grupe, gt.pocetak FROM zaposlenik z
INNER JOIN grupni_trening gt ON (z.zaposlenik_OIB = gt.zaposlenik_OIB)
WHERE pocetak > TO_DATE('2021/05/20 17:00:00', 'yyyy/mm/dd hh24:mi:ss');

----------------UPITI KORISTE�I AGREGIRAJU�E FUNKCIJE----------------

--ispisati kolika je prosije�na pla�a za trenera

SELECT AVG(pla�a) AS "Prosje�na pla�a trenera" FROM zaposlenik
WHERE vrsta_posla = 'trener';

--grupni trening na kojemu je sudjelovalo vi�e od 5 �lanova

SELECT naziv_grupe FROM grupni_trening gt
INNER JOIN grupni_trening_�lan gc ON (gt.trening_id = gc.trening_id)
GROUP BY naziv_grupe
HAVING COUNT(�lan_OIB) > 5;

--za svaku vrstu posla ispisati najve�u pla�u i pripadnog zaposlenika

SELECT zaposlenik_OIB, vrsta_posla, pla�a FROM zaposlenik z
WHERE pla�a = (SELECT max(pla�a) FROM zaposlenik 
WHERE zaposlenik.vrsta_posla = z.vrsta_posla);

--�lanovi koji su bili u Centru nakon 18h i pla�aju najve�u mogu�u �lanarinu

SELECT DISTINCT ime, prezime, �lanarina.cijena FROM �lan �
FULL OUTER JOIN grupni_trening_�lan gtc USING (�lan_OIB)
FULL OUTER JOIN  grupni_trening gt USING (trening_id)
FULL OUTER JOIN vrijeme_dolaska vd USING (�lan_OIB)
INNER JOIN �lanarina USING (�lan_OIB)
WHERE (gt.pocetak > TO_DATE('2021/05/20 18:00:00', 'yyyy/mm/dd hh24:mi:ss') 
    OR (vd.dolazak > TO_DATE('2021/05/20 18:00:00', 'yyyy/mm/dd hh24:mi:ss')))
    AND �lanarina.cijena = (SELECT max(cijena) FROM �lanarina WHERE �lanarina.�lan_OIB = �lan_OIB);
    
--koliko je �lanova bilo na grupnom treningu, a tako�er su bili i u sauni ili na masa�i ?

SELECT COUNT(DISTINCT(gc.�lan_OIB)) "broj �lanova" FROM grupni_trening_�lan gc, masa�a m, sauna_�lan s
WHERE (m.�lan_OIB = gc.�lan_OIB) OR (s.�lan_OIB = gc.�lan_OIB);

----------------UPITI KORISTE�I PODUPITE, UGNIJE��ENE UPITE ILI SKUPOVNE OPERACIJE----------------

--koriste�i podupit u WHERE klauzuli prona�i sve �lanove �ije prezime po�inje sa 'K'
-- i tip �lanarine im je 'radnik'


SELECT �lan_OIB , ime, prezime, email
FROM �lan 
INNER JOIN �lanarina USING (�lan_OIB)
WHERE �lan_OIB IN (SELECT �lan_OIB from �lan WHERE prezime LIKE 'K%')
      AND tip_�lanarine = 'radnik';

--koriste�i podupit u WHERE klauzuli prona�i najstarijeg �lana prema dobi


SELECT ime, prezime, datum_rodjenja 
FROM �lan
WHERE datum_rodjenja = (SELECT MIN(datum_rodjenja) FROM �lan);

--koriste�i podupit u WHERE klauzuli prona�i sve�lanove koji su mladji
-- od �lana koji je posljednji u�lanjen u fitness centar


SELECT ime, prezime, datum_rodjenja 
FROM �lan 
WHERE datum_rodjenja > (SELECT datum_rodjenja FROM �lan 
INNER JOIN �lanarina USING (�lan_OIB)
    WHERE datum_u�lanjenja = (SELECT max(datum_u�lanjenja) FROM �lanarina));

--vrati sve zaposlenike koji su mu�kog spola i nisu bili vodili 
--grupni trening
--(skupovna operacija minus)

SELECT ime, prezime, zaposlenik_OIB, spol FROM zaposlenik
WHERE zaposlenik_OIB IN
(SELECT zaposlenik_OIB FROM zaposlenik 
 MINUS
 SELECT zaposlenik_OIB FROM grupni_trening
 ) AND spol = 'm';
 
--(skupovna operacija)
--vrati OIB �lanova koji su koristili obje mogu�e dodatene usluge taj dan
--ali nisu bili u teretani

SELECT distinct �lan_OIB, ime , prezime
FROM �lan WHERE �lan_OIB 
IN
(((SELECT �lan_OIB FROM sauna_�lan) 
    INTERSECT 
 (SELECT �lan_OIB FROM masa�a)) 
    MINUS 
 (SELECT �lan_OIB FROM vrijeme_dolaska));

----------------DODAVANJE ZADAENE VRIJEDNOSTI NA NEKOLIKO ATRIBUTA----------------

ALTER TABLE masa�a
MODIFY vrsta_masa�e DEFAULT 'klasi�na';
--INSERT INTO masa�a(masa�a_id, broj_prostorije, cijena, �lan_OIB, zaposlenik_OIB)
--VALUES(1234, 10, 180, '00000000014', '00000000033');
--select * from masa�a;

ALTER TABLE sauna
MODIFY temperatura DEFAULT 65;

ALTER TABLE teretana
MODIFY glazba DEFAULT 'Otvoreni radio';
--insert into teretana(teretana_id, broj_prostorije, kapacitet) values (102, 99, 60);
--Select * from teretana;

ALTER TABLE �lanarina
MODIFY cijena DEFAULT 200;

--ako se ne donese potvrda za neku od 'povlastica' pla�a se puna cijena od 200 kn

commit;
----------------DODAVANJE UVJETA----------------

ALTER TABLE �lanarina
ADD CONSTRAINT �l_ck
CHECK(tip_�lanarine IN ('student', 'radnik', 'u�enik', 'umirovljenik'));

--INSERT INTO �lanarina VALUES(000,'00000500013', 'neki_novi_tip', 200, TO_DATE('2015/04/07', 'yyyy/mm/dd '));

ALTER TABLE sauna
ADD CONSTRAINT sauna_ck
CHECK(temperatura >= 65 AND temperatura <= 90);

ALTER TABLE �lan 
ADD CONSTRAINT �lan_uq
UNIQUE (telefon, email);

INSERT INTO �lan VALUES ('00060000000', 'Novi', '�lan', 
            TO_DATE('2000/06/01', 'yyyy/mm/dd '), '�', '0914836841', NULL);
                    

----------------DODAVANJE KOMENTARA NA TEABLICE----------------

COMMENT ON TABLE �lanarina
IS 'Bez predod�be potvrde o povlastici �lan pla�a
    punu cijenu u iznosu od 200kn';

COMMENT ON TABLE smjena
IS 'Ova tablica sadr�i informacije o tome kada je
    koja smjena zapo�ela i zavr�ila, za svaki
    pojedina�ni dan';

COMMENT ON TABLE teretana 
IS 'Radi epidemiolo�kih mjera dozvoljeno je
    maksimalno 40 ljudi istovremeno u prostoriji';

SELECT *
FROM user_tab_comments
WHERE table_name = 'SMJENA' OR table_name = '�LANARINA' OR table_name = 'TERETANA';

----------------DODAVANJE INDEKSA----------------

CREATE INDEX i_�_mail ON �lan(email);

CREATE INDEX i_gt_z_oib ON grupni_trening(zaposlenik_OIB);

CREATE INDEX i_gt_�_oib ON grupni_trening_�lan(�lan_OIB);

CREATE INDEX i_sa_�_oib ON sauna_�lan(�lan_OIB);

CREATE BITMAP INDEX i_smjena ON zaposlenik_smjena(smjena_broj);

----------------PROCEDURE----------------

 --procedura koja provjerava je li �lan u�lanjen du�e od 5 godina
 --ako jest, dati mu popust od 10%

CREATE OR REPLACE PROCEDURE popust_5(
    p_oib �lanarina.�lan_OIB%type
)
IS
p_datum date;
BEGIN
    select datum_u�lanjenja into p_datum
    from �lanarina
    where �lan_OIB = p_oib;
    
    IF (sysdate - p_datum >= 1825) THEN
        UPDATE �lanarina
        SET cijena = cijena - (cijena*0.1)
        WHERE �lan_OIB = p_oib;
    END IF;
END popust_5;
/

--select * from �lanarina;

--call popust_5 ('00000000008');

--rollback;
 --�elimo pove�ati pla�u zaposleniku za 15% ako je njihova trenutna 
 --pla�a manja od prosje�ne za tu vrstu posla

CREATE OR REPLACE PROCEDURE povi�ica_ako_manje(
    z_oib zaposlenik.zaposlenik_OIB%type
)
IS
v_posla zaposlenik.vrsta_posla%type;
n_pla�a zaposlenik.pla�a%type;
prosijek INTEGER;
BEGIN
    select vrsta_posla into v_posla
    from zaposlenik 
    where zaposlenik.zaposlenik_OIB = z_oib;

    select avg(pla�a) into prosijek
    from zaposlenik 
    where vrsta_posla = v_posla;
    
    select pla�a into n_pla�a
    from zaposlenik 
    where zaposlenik.zaposlenik_OIB = z_oib;
    
    IF (n_pla�a < prosijek) THEN
        UPDATE zaposlenik
        SET pla�a = pla�a + (pla�a*0.15)
        WHERE zaposlenik.zaposlenik_OIB = z_oib;
    END IF;
END povi�ica_ako_manje;
/

--select * from zaposlenik;

--SELECT AVG(pla�a) FROM zaposlenik
--WHERE vrsta_posla = 'maser'; 

--call povi�ica_ako_manje('00000000036');

----------------OKIDA�I----------------
SET SERVEROUTPUT ON;

--osigurava da se cijena niti jednog tipa �lanarine ne mo�e povisiti

CREATE OR REPLACE TRIGGER provjera_�lanarine
BEFORE UPDATE ON �lanarina
FOR EACH ROW
BEGIN
    IF :NEW.cijena > :OLD.cijena 
        THEN RAISE_APPLICATION_ERROR(-20111, 'Cijena �lanarine se ne smije povisiti!');
    END IF;

END;
/

--UPDATE �lanarina
--SET cijena = cijena/2
--WHERE tip_�lanarine = 'radnik';

--rollback;

--osigurava da se niti jedom zaposleniku pla�a ne mo�e smanjiti za vi�e od 30%

CREATE OR REPLACE TRIGGER provjera_nove_pla�e
BEFORE UPDATE ON zaposlenik
FOR EACH ROW
BEGIN
    IF :NEW.pla�a < (:OLD.pla�a * 0.7) 
        THEN RAISE_APPLICATION_ERROR(-20111, 'Smanjenje pla�e je preveliko!');
        ELSE DBMS_OUTPUT.PUT_LINE('Pla�a je uspje�no promijenjena.');
    END IF;

END;
/

--UPDATE zaposlenik
--SET pla�a = 3000
--WHERE zaposlenik_OIB = '00000000031';