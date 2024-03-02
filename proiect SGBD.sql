drop table angajati;
drop table departamente;
drop table bagaje;
drop table feedback;
drop table aeronave;
drop table escale;
drop table bilete;
drop table zboruri;
drop table mapping_aeroport_companie;
drop table aeroporturi;
drop table clienti;
drop table companii;
drop sequence c;


CREATE TABLE COMPANII (
    id_companie NUMBER NOT NULL,
    nume VARCHAR2(255) NOT NULL,
    cifra_afaceri NUMBER NOT NULL,
    data_infiintare DATE NOT NULL,
    locatie VARCHAR2(255) NOT NULL,
    CONSTRAINT PK_COMPANIE PRIMARY KEY (id_companie)
);

CREATE TABLE DEPARTAMENTE (
    id_departament NUMBER NOT NULL,
    nume VARCHAR2(255) NOT NULL,
    id_companie NUMBER NOT NULL,
    CONSTRAINT PK_DEPARTAMENTE PRIMARY KEY (id_departament),
    CONSTRAINT FK_DEPARTAMENTE_COMPANIE FOREIGN KEY (id_companie) REFERENCES COMPANII (id_companie)
);

CREATE TABLE ANGAJATI (
    id_angajat NUMBER NOT NULL,
    nume VARCHAR2(255) NOT NULL,
    prenume VARCHAR2(255) NOT NULL,
    data_angajarii DATE NOT NULL,
    salariu NUMBER NOT NULL,
    comision NUMBER, 
    numar_telefon VARCHAR(11),
    id_departament NUMBER,
    CONSTRAINT PK_ANGAJATI PRIMARY KEY (id_angajat),
    CONSTRAINT FK_ANGAJATI_DEPARTAMENTE FOREIGN KEY (id_departament) REFERENCES DEPARTAMENTE (id_departament)
);


CREATE TABLE AEROPORTURI (
    id_aeroport NUMBER NOT NULL,
    nume VARCHAR2(255) NOT NULL,
    nr_angajati NUMBER NOT NULL,
    locatie VARCHAR2(255) NOT NULL,
    CONSTRAINT PK_AEROPORTURI PRIMARY KEY (id_aeroport)
);

CREATE TABLE AERONAVE (
    id_aeronave NUMBER NOT NULL,
    model VARCHAR2(255) NOT NULL,
    capacitate NUMBER NOT NULL,
    id_companie NUMBER NOT NULL,
    CONSTRAINT PK_AERONAVE PRIMARY KEY (id_aeronave),
    CONSTRAINT FK_AERONAVE_COMPANII FOREIGN KEY (id_companie) REFERENCES COMPANII (id_companie)
);

CREATE TABLE CLIENTI (
    id_client NUMBER NOT NULL,
    prenume VARCHAR2(255) NOT NULL,
    nume VARCHAR2(255) NOT NULL,
    data_nastere DATE NOT NULL,
    CNP VARCHAR2(255) NOT NULL,
    CONSTRAINT PK_CLIENTI PRIMARY KEY (id_client)
);

CREATE TABLE ZBORURI (
    id_zbor NUMBER(10) NOT NULL,
    data_decolare DATE NOT NULL,
    data_aterizare DATE NOT NULL,
    id_companie NUMBER(10) NOT NULL,
    id_aeroport_plecare NUMBER(10) NOT NULL,
    id_aeroport_aterizare NUMBER(10) NOT NULL,
    id_aeronava NUMBER(10) NOT NULL,
    CONSTRAINT PK_ZBORURI PRIMARY KEY (id_zbor),
    FOREIGN KEY (id_companie) REFERENCES COMPANII(id_companie),
    FOREIGN KEY (id_aeroport_plecare) REFERENCES AEROPORTURI(id_aeroport),
    FOREIGN KEY (id_aeroport_aterizare) REFERENCES AEROPORTURI(id_aeroport),
    FOREIGN KEY (id_aeronava) REFERENCES AERONAVE(id_aeronave)
);

CREATE TABLE BILETE (
    id_bilet NUMBER NOT NULL,
    pret NUMBER,
    id_zbor NUMBER NOT NULL,
    id_client NUMBER NOT NULL,
    CONSTRAINT PK_BILETE PRIMARY KEY (id_bilet),
    CONSTRAINT FK_BILETE_ZBORURI FOREIGN KEY (id_zbor) REFERENCES ZBORURI (id_zbor),
    CONSTRAINT FK_BILETE_CLIENTI FOREIGN KEY (id_client) REFERENCES CLIENTI (id_client)
);



CREATE TABLE BAGAJE (
    id_bagaj NUMBER NOT NULL,
    greutate NUMBER NOT NULL,
    id_bilet NUMBER NOT NULL,
    CONSTRAINT PK_BAGAJ PRIMARY KEY (id_bagaj),
    CONSTRAINT FK_BAGAJ_CLIENTI FOREIGN KEY (id_bilet) REFERENCES BILETE (id_bilet)
);

CREATE TABLE ESCALE (
    id_escala NUMBER NOT NULL,
    durata NUMBER NOT NULL,
    id_zbor NUMBER NOT NULL,
    id_aeroport NUMBER NOT NULL,
    CONSTRAINT PK_ESCALA PRIMARY KEY (id_escala),
    CONSTRAINT FK_ESCALA_ZBORURI FOREIGN KEY (id_zbor) REFERENCES ZBORURI (id_zbor),
    CONSTRAINT FK_ESCALA_AEROPORTURI FOREIGN KEY (id_aeroport) REFERENCES AEROPORTURI (id_aeroport)
);


CREATE TABLE FEEDBACK (
    id_feedback NUMBER NOT NULL,
    text VARCHAR2(255) NOT NULL,
    id_client NUMBER NOT NULL,
    CONSTRAINT PK_FEEDBACK PRIMARY KEY (id_feedback),
    CONSTRAINT FK_FEEDBACK_CLIENTI FOREIGN KEY (id_client) REFERENCES CLIENTI (id_client)
);

CREATE TABLE MAPPING_AEROPORT_COMPANIE (
    id_aerport NUMBER NOT NULL,
    id_companie NUMBER NOT NULL,
    CONSTRAINT FK_MAPPING_AEROPORT_COMPANIE_AEROPORTURI FOREIGN KEY (id_aerport) REFERENCES AEROPORTURI (id_aeroport),
    CONSTRAINT FK_MAPPING_AEROPORT_COMPANIE_COMPANIE FOREIGN KEY (id_companie) REFERENCES COMPANII (id_companie)
);

CREATE SEQUENCE c
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

INSERT INTO COMPANII (id_companie, nume, cifra_afaceri, data_infiintare, locatie)
VALUES (c.nextval, 'Tarom', 1000000, DATE '2022-01-01', 'Paris');

INSERT INTO COMPANII (id_companie, nume, cifra_afaceri, data_infiintare, locatie)
VALUES (c.nextval, 'Emirates', 2000000, DATE '2023-02-01', 'Bucuresti');

INSERT INTO COMPANII (id_companie, nume, cifra_afaceri, data_infiintare, locatie)
VALUES (c.nextval, 'JetStream', 1500000, DATE '2023-03-01', 'Londra');

INSERT INTO COMPANII (id_companie, nume, cifra_afaceri, data_infiintare, locatie)
VALUES (c.nextval, 'AirTech', 1800000, DATE '2022-05-01', 'Berlin');

INSERT INTO COMPANII (id_companie, nume, cifra_afaceri, data_infiintare, locatie)
VALUES (c.nextval, 'HiSky', 1200000, DATE '2022-08-01', 'Iasi');


select * from companii;
INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'Angajari', 1);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'Customer Service', 1);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'HR', 2);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'PR', 2);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'Management', 3);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'Marketing', 3);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'IT', 4);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'Vanzari', 4);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'Administratie', 5);

INSERT INTO DEPARTAMENTE (id_departament, nume, id_companie)
VALUES (c.nextval, 'Finante', 5);


select * from departamente;

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Popescu', 'Ion', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 2000, 0.5, '0702070359', 6);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Ionescu', 'Maria', TO_DATE('2019-03-20', 'YYYY-MM-DD'), 100, 0.1, '0731883509', 7);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Georgescu', 'Andrei', TO_DATE('2022-05-10', 'YYYY-MM-DD'), 6000, 0.2, '0732483509', NULL);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Mihai', 'Elena', TO_DATE('2022-02-01', 'YYYY-MM-DD'), 4000, 0, '0714883509', 8);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Dumitrescu', 'Radu', TO_DATE('2022-06-25', 'YYYY-MM-DD'), 5500, 0.4, '0714883019', NULL);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Stanescu', 'Ana', TO_DATE('2019-04-12', 'YYYY-MM-DD'), 3200, 0.9, '0714883599', 9);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Popescu', 'Ana', TO_DATE('2022-04-12', 'YYYY-MM-DD'), 7000, 0.9, '0714883499', 10);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Vasilescu', 'Elena', TO_DATE('2020-08-22', 'YYYY-MM-DD'), 4800, 0.9, '0714883399', 10);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Popescu', 'Ana', TO_DATE('2021-09-12', 'YYYY-MM-DD'), 6000, NULL, '0714883299', 10);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Stan', 'Ioan', TO_DATE('2003-09-24', 'YYYY-MM-DD'), 10000, 0.8, '0714883199', 10);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Bran', 'Adrian', TO_DATE('2013-09-08', 'YYYY-MM-DD'), 4800, NULL, '0747583509', 11);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Constantin', 'Cristina', TO_DATE('2008-07-03', 'YYYY-MM-DD'), 4700, NULL, '0142883509', 12);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Gheorghe', 'Alexandru', TO_DATE('2022-11-17', 'YYYY-MM-DD'), 5200, 0.15, '0714222509', NULL);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Matei', 'Laura', TO_DATE('2022-08-05', 'YYYY-MM-DD'), 1800, 0.2, '0712422509', 13);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Ionescu', 'Laura', TO_DATE('2020-08-05', 'YYYY-MM-DD'), 2800, 0.7, '0712422509', 14);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Florea', 'Maria', TO_DATE('2010-08-05', 'YYYY-MM-DD'), 3000, 0.2, '0712422509', 14);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Grigoras', 'Elena', TO_DATE('2021-08-05', 'YYYY-MM-DD'), 1205, NULL, '0712422509', 14);

INSERT INTO ANGAJATI (id_angajat, nume, prenume, data_angajarii, salariu, comision, numar_telefon, id_departament)
VALUES (c.nextval, 'Stanescu', 'Andreea', TO_DATE('2007-08-05', 'YYYY-MM-DD'), 6000, 0.7, '0712422509', 14);

select * from angajati;



INSERT INTO AEROPORTURI (id_aeroport, nume, nr_angajati, locatie)
VALUES (c.nextval, 'John F. Kennedy International Airport', 500, 'New York');

INSERT INTO AEROPORTURI (id_aeroport, nume, nr_angajati, locatie)
VALUES (c.nextval, 'Heathrow Airport', 300, 'Londra');

INSERT INTO AEROPORTURI (id_aeroport, nume, nr_angajati, locatie)
VALUES (c.nextval, 'Charles de Gaulle Airport', 450, 'Paris');

INSERT INTO AEROPORTURI (id_aeroport, nume, nr_angajati, locatie)
VALUES (c.nextval, 'Dubai International Airport', 200, 'Dubai');

INSERT INTO AEROPORTURI (id_aeroport, nume, nr_angajati, locatie)
VALUES (c.nextval, 'Beijing Capital International Airport', 250, 'Beijing');

INSERT INTO AEROPORTURI (id_aeroport, nume, nr_angajati, locatie)
VALUES (c.nextval, 'Dubai International Airport', 324, 'Dubai');

select * from aeroporturi;

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Boeing 747', 416, 1);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Airbus A380', 853, 2);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Boeing 737', 215, 4);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Airbus A320', 180, 2);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Boeing 777', 396, 1);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Airbus A350', 440, 2);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Embraer E190', 98, 3);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Bombardier CRJ900', 90, 4);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Boeing 767', 375, 1);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Airbus A330', 335, 2);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Airbus A330', 400, 5);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Boeing 767', 375, 5);

INSERT INTO AERONAVE (id_aeronave, model, capacitate, id_companie)
VALUES (c.nextval, 'Boeing 747', 416, 5);

SELECT * from aeronave;



INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (34, 1);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (34, 2);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (35, 3);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (35, 4);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (36, 5);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (36, 1);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (37, 2);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (37, 3);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (38, 4);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (38, 3);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (38, 5);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (38, 2);

INSERT INTO MAPPING_AEROPORT_COMPANIE (id_aerport, id_companie)
VALUES (39, 1);

select * from mapping_aeroport_companie
order by id_companie;

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2023-05-25 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 36, 39, 40);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2023-05-26 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-26 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 34, 37, 41);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2023-05-27 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-27 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 35, 37, 46);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2023-05-28 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-28 21:15:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 34, 39, 44);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2023-05-29 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-29 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 37, 34, 49);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2023-05-30 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-30 13:05:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 37, 38, 46);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2022-05-31 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-05-31 16:25:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 39, 36, 48);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2022-06-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-06-01 21:45:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 38, 35, 46);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2021-06-02 12:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-06-02 15:55:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 37, 34, 49);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2021-06-03 14:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-06-03 17:10:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 38, 35, 47);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2021-06-03 14:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-06-03 17:10:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 35, 38, 47);

INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
VALUES (c.nextval, TO_DATE('2021-06-03 14:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-06-03 17:10:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 38, 36, 51);


select * from zboruri;


INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Ion', 'Popescu', TO_DATE('1985-03-12', 'YYYY-MM-DD'), '1850312001234');
INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Maria', 'Ionescu', TO_DATE('1990-07-25', 'YYYY-MM-DD'), '2900725004321');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Andrei', 'Dumitrescu', TO_DATE('1988-11-03', 'YYYY-MM-DD'), '8811103005432');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Elena', 'Constantinescu', TO_DATE('1976-06-18', 'YYYY-MM-DD'), '7600618006543');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Mihai', 'Popa', TO_DATE('1992-09-30', 'YYYY-MM-DD'), '9200930007654');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Ana', 'Georgescu', TO_DATE('1982-02-14', 'YYYY-MM-DD'), '8200214008765');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Adrian', 'Radu', TO_DATE('1987-04-08', 'YYYY-MM-DD'), '8700408009876');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Diana', 'Stancu', TO_DATE('1995-12-29', 'YYYY-MM-DD'), '9512299000987');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Gabriel', 'Popovici', TO_DATE('1993-08-20', 'YYYY-MM-DD'), '9300820001098');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Mihaela', 'Dobre', TO_DATE('1984-01-07', 'YYYY-MM-DD'), '8400107002112');

INSERT INTO CLIENTI (id_client, prenume, nume, data_nastere, CNP)
VALUES (c.nextval, 'Anca-Elena', 'Gorcioaia', TO_DATE('2003-05-29', 'YYYY-MM-DD'), '6030529873521');

select * from clienti; 

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval,500, 53, 65);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval,450, 54, 66);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval,1000, 55, 67);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval,1000 , 56, 68);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval,600 , 57, 69);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval, 450, 58, 70);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval, 783, 59, 71);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval, 458, 59, 72);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval,800, 59, 73);

INSERT INTO BILETE (id_bilet, pret, id_zbor, id_client)
VALUES (c.nextval,463 , 60, 74);

select * from bilete;


INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 20, 76);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 15, 77);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 18, 78);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 22, 79);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 16, 80);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 19, 81);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 25, 82);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 12, 80);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 23, 80);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 14, 83);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 24, 83);

INSERT INTO BAGAJE (id_bagaj, greutate, id_bilet)
VALUES (c.nextval, 44, 84);


select * from bagaje;

INSERT INTO ESCALE (id_escala, durata, id_zbor, id_aeroport)
VALUES (c.nextval, 120, 53, 34 );

INSERT INTO ESCALE (id_escala, durata, id_zbor, id_aeroport)
VALUES (c.nextval, 90, 54, 38);

INSERT INTO ESCALE (id_escala, durata, id_zbor, id_aeroport)
VALUES (c.nextval, 75, 55, 38);

INSERT INTO ESCALE (id_escala, durata, id_zbor, id_aeroport)
VALUES (c.nextval, 80, 56, 36);

INSERT INTO ESCALE (id_escala, durata, id_zbor, id_aeroport)
VALUES (c.nextval, 70, 58, 35);


SELECT * from escale;

INSERT INTO FEEDBACK (id_feedback, text, id_client)
VALUES (c.nextval, 'Excelent serviciu!', 65);

INSERT INTO FEEDBACK (id_feedback, text, id_client)
VALUES (c.nextval, 'Foarte mul?umit de experien??.', 66);

INSERT INTO FEEDBACK (id_feedback, text, id_client)
VALUES (c.nextval, 'Personal amabil ?i profesionist.', 67);

INSERT INTO FEEDBACK (id_feedback, text, id_client)
VALUES (c.nextval, 'Recomand cu  ncredere.', 68);

INSERT INTO FEEDBACK (id_feedback, text, id_client)
VALUES (c.nextval, 'Servicii de calitate superioar?.', 69);


INSERT INTO FEEDBACK (id_feedback, text, id_client)
VALUES (c.nextval, 'Servicii de calitate superioar?.', 70);

INSERT INTO FEEDBACK (id_feedback, text, id_client)
VALUES (c.nextval, 'Servicii de calitate superioar?.', 70);

select * from feedback;

-- ex 6 

-- procedura Pentru o companie a carei ID este dat, 
-- afisati toate id-urile zborurilor acesteia, toate id-urile zborurilor cu escala si toate modelele de aeronava pe care le detine.


set serveroutput on;
CREATE OR REPLACE PROCEDURE afiseaza_informatii_companie(id_companie_param IN NUMBER) IS

    nu_exista_companie EXCEPTION;
    TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    TYPE tablou_imbricat IS TABLE OF NUMBER;
    TYPE varray_aeronave IS VARRAY(100) OF VARCHAR2(255);

    -- record pentru a grupa informatiile
    TYPE companie_record IS RECORD (
        id_companie NUMBER,
        zboruri tablou_indexat,
        zboruri_cu_escala tablou_imbricat,
        aeronave varray_aeronave
    );

    -- Instanta pentru record
    companie_info companie_record;
    
    v_exista_companie NUMBER;
    
BEGIN

    SELECT COUNT(*)
    INTO v_exista_companie
    FROM COMPANII
    WHERE id_companie = id_companie_param;
    
        -- Daca compania nu exista, se ridica exceptia
    IF v_exista_companie = 0 THEN
        RAISE nu_exista_companie;
    END IF;
    

    companie_info.id_companie := id_companie_param;

    -- punem zboruruile companiei intr un tablou indexat
    SELECT id_zbor BULK COLLECT INTO companie_info.zboruri
    FROM ZBORURI
    WHERE id_companie = id_companie_param;

    -- punem zborurile cu escala intr un tablou imbricat
    SELECT z.id_zbor BULK COLLECT INTO companie_info.zboruri_cu_escala
    FROM ZBORURI z JOIN ESCALE e ON z.id_zbor = e.id_zbor
    WHERE z.id_companie = id_companie_param;

    -- punem aeronavele intr un vector
    SELECT model BULK COLLECT INTO companie_info.aeronave
    FROM AERONAVE
    WHERE id_companie = id_companie_param;

    -- afisarea
    DBMS_OUTPUT.PUT_LINE('Id companie: ' || companie_info.id_companie);

    IF companie_info.zboruri.COUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('zboruri:'); 
        -- parcurgem tabloul indexat pt zboruri
        FOR i IN 1 .. companie_info.zboruri.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(companie_info.zboruri(i));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('nu exsta zboruri pentru aceata companie');
    END IF;

    IF companie_info.zboruri_cu_escala.COUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('zboruri cu escala:');
        -- parcurgem tabloul imbricat pentru a lua zborurile cu esca;a
        FOR i IN 1 .. companie_info.zboruri_cu_escala.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(companie_info.zboruri_cu_escala(i));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('nu exista zboruri cu escala pentru aceasta companie');
    END IF;

    IF companie_info.aeronave.COUNT > 0 THEN
    -- parcurgem vectorul pentru a lua modelele de aeronave
        DBMS_OUTPUT.PUT_LINE('modele aeronave:');
        FOR i IN 1 .. companie_info.aeronave.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(companie_info.aeronave(i));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('nu exista aernave pentru aceasta companie');
    END IF;

EXCEPTION
    WHEN nu_exista_companie THEN
        RAISE_APPLICATION_ERROR(-20002, 'nu exista companie cu ID ' || id_companie_param);
END afiseaza_informatii_companie;


BEGIN
    afiseaza_informatii_companie(2); 
END;

-- EX 7 Pentru fiecare zbor din 2023 afisati escalele acestuia impreuna cu id-ul si durata lor 
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE AfisareZboruriEscale IS


    CURSOR C IS
    SELECT id_zbor
    FROM zboruri
    WHERE EXTRACT(YEAR FROM data_decolare) = 2023;
        
        -- cursor parametrizat pentru a selecta toate escalele si durata lor pentru fiecare zbor
    CURSOR CAUTA(idZbor zboruri.id_Zbor%type) IS
        SELECT id_escala, durata
        FROM escale
        WHERE id_zbor = idZbor;
        
    id_z zboruri.id_zbor%type;
    id_e escale.id_escala%type;
    d escale.durata%type;
    contor NUMBER;
    
BEGIN
    OPEN C;
    LOOP
        FETCH C INTO id_z;
        EXIT WHEN C%notfound;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Zborul cu id-ul ' || id_z || ':');
        
        -- deschidem cursorul cauta dupa id_z
        OPEN CAUTA(id_z);
        contor:= 0;
        
        LOOP
        -- adaugam id ul escalei si durata lor in varibailele lor 
            FETCH CAUTA INTO id_e, d;
            IF CAUTA%NOTFOUND THEN
                IF contor=0 THEN
                    DBMS_OUTPUT.PUT_LINE('ZBORUL ' || id_z|| ' nu are escala');
                END IF;
                EXIT;
            END IF;
    
            DBMS_OUTPUT.PUT_LINE('are escala ' || id_e || ' si dureaza ' || d);
            contor:=1;
        END LOOP;
        CLOSE CAUTA;
    END LOOP;
    CLOSE C;
END AfisareZboruriEscale;

BEGIN
    AfisareZboruriEscale;
END;
    
-- EX 8 definiti un subprogram care sa obtina greuatea totala a bagajelor pentru zborurile dintr un an introdus
-- exceptii:
-- nu exsita zboruri in anul respectiv
-- nimeni nu a cumparat bilete pentru acel zbbor
-- cele 3 tabele folosite: zboruri, bagaje, bilete

CREATE OR REPLACE FUNCTION Zboruri_Bagaje(p_an INT DEFAULT 2023) RETURN NUMBER IS
    v_greutate_totala NUMBER := 0;
    v_exista_zboruri NUMBER := 0;

    nu_exista_bagaje EXCEPTION;
    nu_exista_zboruri EXCEPTION;

BEGIN
    SELECT COUNT(*)
    INTO v_exista_zboruri
    FROM ZBORURI z
    WHERE EXTRACT(YEAR FROM z.data_decolare) = p_an;

    IF v_exista_zboruri = 0 THEN
        RAISE nu_exista_zboruri;
    ELSE
        SELECT SUM(b.greutate)
        INTO v_greutate_totala
        FROM BAGAJE b
        JOIN BILETE bl ON b.id_bilet = bl.id_bilet
        JOIN ZBORURI z ON bl.id_zbor = z.id_zbor
        WHERE EXTRACT(YEAR FROM z.data_decolare) = p_an;

        IF v_greutate_totala IS NULL THEN
            RAISE nu_exista_bagaje;
        ELSE
            RETURN v_greutate_totala;
        END IF;
    END IF;
EXCEPTION
    WHEN nu_exista_zboruri THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu exista zboruri în anul ' || p_an);
    WHEN nu_exista_bagaje THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nu exista bagaje pentru zborurile din anul ' || p_an);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'A aprut o eroare');
END Zboruri_Bagaje;
/


DECLARE
 v_result number(10);
BEGIN
 v_result := Zboruri_Bagaje(2023);
 DBMS_OUTPUT.PUT_LINE('Greuatatea bagajelor: ' || v_result);
 exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Error' || SQLERRM);
END;




-- ex 9 
-- se da numele unei comapnii ca si parametru, afisati nr de feedback uri pe care compania le a primit
-- exceptii : 
-- nu exista compania in baza de date, exceptie NO_DATA_FOUND
-- exista 2 companii cu acelasi nume, excepti TOO_MANY_ROWS
-- compania nu are feedback-uri, excpetie nu_exista_feedback
-- cele 5 tabele folosite : feedback, clienti, bilete, zboruri, companii


CREATE OR REPLACE PROCEDURE numar_feedback_companii(p_nume_companie IN VARCHAR2) IS
    v_nr_feedback NUMBER;
    v_id_companie COMPANII.id_companie%TYPE;

    nu_exista_feedback EXCEPTION;

BEGIN
    SELECT id_companie INTO v_id_companie FROM COMPANII WHERE nume = p_nume_companie;

    SELECT COUNT(*) INTO v_nr_feedback
    FROM FEEDBACK f
    JOIN CLIENTI c ON f.id_client = c.id_client
    JOIN BILETE b ON c.id_client = b.id_client
    JOIN ZBORURI z ON b.id_zbor = z.id_zbor
    WHERE z.id_companie = v_id_companie;

    IF v_nr_feedback = 0 THEN
        RAISE nu_exista_feedback;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Numarul de feedback-uri pentru ' || p_nume_companie || ' este: ' || v_nr_feedback);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nu exista compania in baza de date');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Exista mai multe companii cu acelasi nume');
    WHEN nu_exista_feedback THEN
        RAISE_APPLICATION_ERROR(-20001, 'Compania nu are feedback-uri');
    WHEN OTHERS THEN
        RAISE;
END numar_feedback_companii;
/
--
--INSERT INTO COMPANII (id_companie, nume, cifra_afaceri, data_infiintare, locatie)
--VALUES (c.nextval, 'Emirates', 2000000, DATE '2023-02-01', 'Bucuresti');


BEGIN
    numar_feedback_companii('Salut');
    exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Error' || SQLERRM);
END;
/



--ex 10

-- trigger care oermite modificarea zboruri doar in zilele de luni
-- trigger LMD la nivel de linie
CREATE OR REPLACE TRIGGER trigger_zboruri
BEFORE INSERT OR UPDATE OR DELETE ON ZBORURI
FOR EACH ROW
BEGIN
    IF TO_CHAR(SYSDATE, 'DY') != 'WED' THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20001, 'Inserarile in tabelul ZBORURI sunt permise doar in zilele de luni.');
        ELSIF UPDATING THEN
            RAISE_APPLICATION_ERROR(-20002, 'Actualizrile in tabelul ZBORURI sunt permise doar in zilele de luni.');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20003, 'Stergerile din tabelul ZBORURI sunt permise doar in zilele de luni.');
        END IF;
    END IF;
END;

DROP TRIGGER trigger_zboruri;
--SELECT TO_CHAR(SYSDATE, 'Day') AS Day_Name
--FROM DUAL;

--select * from zboruri;
--INSERT INTO ZBORURI (id_zbor, data_decolare, data_aterizare, id_companie, id_aeroport_plecare, id_aeroport_aterizare, id_aeronava)
--VALUES (c.nextval, TO_DATE('2021-06-03 14:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-06-03 17:10:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 38, 36, 51);
--
----
--UPDATE ZBORURI
--SET 
--    data_decolare = TO_DATE('2021-06-03 14:25:00', 'YYYY-MM-DD HH24:MI:SS'),
--    data_aterizare = TO_DATE('2021-06-03 17:10:00', 'YYYY-MM-DD HH24:MI:SS'),
--    id_companie = 5,
--    id_aeroport_plecare = 38,
--    id_aeroport_aterizare = 36,
--    id_aeronava = 44
--WHERE
--    id_zbor = 114;
--
--
--DELETE FROM ZBORURI
--WHERE id_zbor = 114;



-- ex 11

-- definiti un trigger care sa nu permita aduagarea unui bagaj cu greutate mai mare ca maximul greutatii din acel tabel
-- trigger LMD la nivel de comanda
CREATE OR REPLACE TRIGGER trigger_bagaj_greutate
BEFORE UPDATE OF greutate ON BAGAJE
FOR EACH ROW
BEGIN
    IF :OLD.greutate <> :NEW.greutate THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu este permisa schimbarea greutatii bagajului.');
    END IF;
END;
/

UPDATE BAGAJE
SET greutate = 40
where id_bagaj = 88;


-- EX 12
-- Am definit un declan?ator care s? introduc? date tabelul info_comenzi dup? ce utilizatorul a folosit o comand? LDD.

CREATE TABLE info_comenzi (
    utilizator VARCHAR(20),
    eveniment VARCHAR2(30),
    tip_obiect VARCHAR2(30),
    nume_obiect VARCHAR2(50),
    data_eveniment DATE
);

CREATE OR REPLACE TRIGGER companii_ddl_trigger
AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    INSERT INTO info_comenzi(utilizator, eveniment, tip_obiect, nume_obiect, data_eveniment)
    VALUES (sys.login_user, sys.sysevent, sys.dictionary_obj_name,sys.dictionary_obj_type , sysdate);
END;
/


CREATE TABLE TEST(
    id_test number(4),
    nume varchar(20),
    CONSTRAINT PK_TEST PRIMARY KEY (id_test)
);

ALTER TABLE TEST
MODIFY nume varchar(30);

drop table test;
select * from info_comenzi;


-- ex 13

CREATE OR REPLACE PACKAGE pachet AS
    procedure afiseaza_informatii_companie(id_companie_param IN NUMBER);
    
    procedure AfisareZboruriEscale;

    function Zboruri_Bagaje(p_an INT DEFAULT 2023)
    return NUMBER;

    procedure numar_feedback_companii(p_nume_companie IN VARCHAR2);
END pachet;
/

CREATE OR REPLACE PACKAGE BODY pachet AS
	
    PROCEDURE afiseaza_informatii_companie(id_companie_param IN NUMBER) IS

        nu_exista_companie EXCEPTION;
        TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
        TYPE tablou_imbricat IS TABLE OF NUMBER;
        TYPE varray_aeronave IS VARRAY(100) OF VARCHAR2(255);
    
        -- record pentru a grupa informatiile
        TYPE companie_record IS RECORD (
            id_companie NUMBER,
            zboruri tablou_indexat,
            zboruri_cu_escala tablou_imbricat,
            aeronave varray_aeronave
        );
    
        -- Instanta pentru record
        companie_info companie_record;
        
        v_exista_companie NUMBER;
    
        BEGIN
        
            SELECT COUNT(*)
            INTO v_exista_companie
            FROM COMPANII
            WHERE id_companie = id_companie_param;
            
                -- Dac? compania nu exist?, se ridic? excep?ia
            IF v_exista_companie = 0 THEN
                RAISE nu_exista_companie;
            END IF;
            
        
            companie_info.id_companie := id_companie_param;
        
            -- punem zboruruile companiei intr un tablou indexat
            SELECT id_zbor BULK COLLECT INTO companie_info.zboruri
            FROM ZBORURI
            WHERE id_companie = id_companie_param;
        
            -- punem zborurile cu escala intr un tablou imbricat
            SELECT z.id_zbor BULK COLLECT INTO companie_info.zboruri_cu_escala
            FROM ZBORURI z JOIN ESCALE e ON z.id_zbor = e.id_zbor
            WHERE z.id_companie = id_companie_param;
        
            -- punem aeronavele intr un vector
            SELECT model BULK COLLECT INTO companie_info.aeronave
            FROM AERONAVE
            WHERE id_companie = id_companie_param;
        
            -- afisarea
            DBMS_OUTPUT.PUT_LINE('Id companie: ' || companie_info.id_companie);
        
            IF companie_info.zboruri.COUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE('zboruri:'); 
                -- parcurgem tabloul indexat pt zboruri
                FOR i IN 1 .. companie_info.zboruri.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE(companie_info.zboruri(i));
                END LOOP;
            ELSE
                DBMS_OUTPUT.PUT_LINE('nu exsta zboruri pentru aceata companie');
            END IF;
        
            IF companie_info.zboruri_cu_escala.COUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE('zboruri cu escala:');
                -- parcurgem tabloul imbricat pentru a lua zborurile cu esca;a
                FOR i IN 1 .. companie_info.zboruri_cu_escala.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE(companie_info.zboruri_cu_escala(i));
                END LOOP;
            ELSE
                DBMS_OUTPUT.PUT_LINE('nu exista zboruri cu escala pentru aceasta companie');
            END IF;
        
            IF companie_info.aeronave.COUNT > 0 THEN
            -- parcurgem vectorul pentru a lua modelele de aeronave
                DBMS_OUTPUT.PUT_LINE('modele aeronave:');
                FOR i IN 1 .. companie_info.aeronave.COUNT LOOP
                    DBMS_OUTPUT.PUT_LINE(companie_info.aeronave(i));
                END LOOP;
            ELSE
                DBMS_OUTPUT.PUT_LINE('nu exista aernave pentru aceasta companie');
            END IF;
        
        EXCEPTION
            WHEN nu_exista_companie THEN
                RAISE_APPLICATION_ERROR(-20002, 'nu exista companie cu ID ' || id_companie_param);
        END afiseaza_informatii_companie;
    
    PROCEDURE AfisareZboruriEscale IS

    CURSOR C IS
        SELECT id_zbor
        FROM zboruri
        WHERE EXTRACT(YEAR FROM data_decolare) = 2023;
        
    CURSOR CAUTA(idZbor zboruri.id_Zbor%type) IS
        SELECT id_escala, durata
        FROM escale
        WHERE id_zbor = idZbor;
        
    id_z zboruri.id_zbor%type;
    id_e escale.id_escala%type;
    d escale.durata%type;
    contor NUMBER;
    
    BEGIN
        OPEN C;
        LOOP
            FETCH C INTO id_z;
            EXIT WHEN C%notfound;
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            DBMS_OUTPUT.PUT_LINE('Zborul cu id-ul ' || id_z || ':');
            
            OPEN CAUTA(id_z);
            contor:= 0;
            
            LOOP
                FETCH CAUTA INTO id_e, d;
                IF CAUTA%NOTFOUND THEN
                    IF contor=0 THEN
                        DBMS_OUTPUT.PUT_LINE('ZBORUL ' || id_z|| ' nu are escala');
                    END IF;
                    EXIT;
                END IF;
        
                DBMS_OUTPUT.PUT_LINE('are escala ' || id_e || ' si dureaza ' || d);
                contor:=1;
            END LOOP;
            CLOSE CAUTA;
        END LOOP;
        CLOSE C;
    END AfisareZboruriEscale;
    
    FUNCTION Zboruri_Bagaje(p_an INT DEFAULT 2023) RETURN NUMBER IS
    v_greutate_totala NUMBER := 0;
    v_exista_zboruri NUMBER := 0;

    nu_exista_bagaje EXCEPTION;
    nu_exista_zboruri EXCEPTION;

    BEGIN
        SELECT COUNT(*)
        INTO v_exista_zboruri
        FROM ZBORURI z
        WHERE EXTRACT(YEAR FROM z.data_decolare) = p_an;
    
        IF v_exista_zboruri = 0 THEN
            RAISE nu_exista_zboruri;
        ELSE
            SELECT SUM(b.greutate)
            INTO v_greutate_totala
            FROM BAGAJE b
            JOIN BILETE bl ON b.id_bilet = bl.id_bilet
            JOIN ZBORURI z ON bl.id_zbor = z.id_zbor
            WHERE EXTRACT(YEAR FROM z.data_decolare) = p_an;
    
            IF v_greutate_totala IS NULL THEN
                RAISE nu_exista_bagaje;
            ELSE
                RETURN v_greutate_totala;
            END IF;
        END IF;
    EXCEPTION
        WHEN nu_exista_zboruri THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nu exista zboruri în anul ' || p_an);
        WHEN nu_exista_bagaje THEN
            RAISE_APPLICATION_ERROR(-20002, 'Nu exista bagaje pentru zborurile din anul ' || p_an);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'A aprut o eroare');
    END Zboruri_Bagaje;
    
    
    PROCEDURE numar_feedback_companii(p_nume_companie IN VARCHAR2) IS
    v_nr_feedback NUMBER;
    v_id_companie COMPANII.id_companie%TYPE;

    nu_exista_feedback EXCEPTION;

    BEGIN
        SELECT id_companie INTO v_id_companie FROM COMPANII WHERE nume = p_nume_companie;
    
        SELECT COUNT(*) INTO v_nr_feedback
        FROM FEEDBACK f
        JOIN CLIENTI c ON f.id_client = c.id_client
        JOIN BILETE b ON c.id_client = b.id_client
        JOIN ZBORURI z ON b.id_zbor = z.id_zbor
        WHERE z.id_companie = v_id_companie;
    
        IF v_nr_feedback = 0 THEN
            RAISE nu_exista_feedback;
        END IF;
    
        DBMS_OUTPUT.PUT_LINE('Numarul de feedback-uri pentru ' || p_nume_companie || ' este: ' || v_nr_feedback);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Nu exista compania in baza de date');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Exista mai multe companii cu acelasi nume');
        WHEN nu_exista_feedback THEN
            RAISE_APPLICATION_ERROR(-20001, 'Compania nu are feedback-uri');
        WHEN OTHERS THEN
            RAISE;
    END numar_feedback_companii;
    
    
END pachet;
/

EXECUTE pachet.afiseaza_informatii_companie(2);    

    
EXECUTE pachet.AfisareZboruriEscale;    
    
DECLARE 
v_result NUMBER;
BEGIN
    v_result :=pachet.Zboruri_Bagaje(2023);
    DBMS_OUTPUT.PUT_LINE(v_result);
END;

EXECUTE pachet.numar_feedback_companii('Tarom');    
