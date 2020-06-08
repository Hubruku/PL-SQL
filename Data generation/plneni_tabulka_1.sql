SET SERVEROUTPUT ON;

ALTER TABLE vysetreni88 DROP CONSTRAINT fk_vysetreni_pacient;
ALTER TABLE vysetreni88 DROP CONSTRAINT fk_vysetreni_doktor;
DROP SEQUENCE doktor88_id_dok_seq;
DROP SEQUENCE pacient88_id_pac_seq;
DROP SEQUENCE vysetreni88_id_vys_seq;

DROP TABLE doktor88;
CREATE TABLE doktor88
(id_dok INTEGER NOT NULL,
jmeno VARCHAR(30) NOT NULL,
prijmeni VARCHAR(30) NOT NULL);

ALTER TABLE doktor88 ADD CONSTRAINT pk_doktor PRIMARY KEY ( id_dok );

DROP TABLE pacient88;
CREATE TABLE pacient88
(id_pac INTEGER NOT NULL,
rodne_cis VARCHAR(15) NOT NULL);

ALTER TABLE pacient88 ADD CONSTRAINT pk_pacient PRIMARY KEY ( id_pac );

DROP TABLE vysetreni88;
CREATE TABLE vysetreni88
(id_vys INTEGER NOT NULL,
id_pac INTEGER NOT NULL,
id_dok INTEGER NOT NULL,
datum DATE);

ALTER TABLE vysetreni88 ADD CONSTRAINT pk_vysetreni PRIMARY KEY ( id_vys );
ALTER TABLE vysetreni88 ADD CONSTRAINT fk_vysetreni_pacient FOREIGN KEY ( id_pac ) REFERENCES pacient88 ( id_pac );
ALTER TABLE vysetreni88 ADD CONSTRAINT fk_vysetreni_doktor FOREIGN KEY ( id_dok ) REFERENCES doktor88 ( id_dok );

CREATE SEQUENCE doktor88_id_dok_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER doktor88_id_dok_trg BEFORE
    INSERT ON doktor88
    FOR EACH ROW
    WHEN ( new.id_dok IS NULL )
BEGIN
    SELECT
        doktor88_id_dok_seq.NEXTVAL
    INTO :new.id_dok
    FROM
        dual;

END;
/

CREATE SEQUENCE pacient88_id_pac_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pacient88_id_pac_trg BEFORE
    INSERT ON pacient88
    FOR EACH ROW
    WHEN ( new.id_pac IS NULL )
BEGIN
    SELECT
        pacient88_id_pac_seq.NEXTVAL
    INTO :new.id_pac
    FROM
        dual;

END;
/

CREATE SEQUENCE vysetreni88_id_vys_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER vysetreni88_id_vys_trg BEFORE
    INSERT ON vysetreni88
    FOR EACH ROW
    WHEN ( new.id_vys IS NULL )
BEGIN
    SELECT
        vysetreni88_id_vys_seq.NEXTVAL
    INTO :new.id_vys
    FROM
        dual;

END;
/

CREATE OR REPLACE PROCEDURE napln_doktory( pocet INTEGER DEFAULT 1000 ) AS
    type namesarray IS VARRAY(30) OF VARCHAR(30);
    firstNames namesarray;
    lastNames namesarray;
    retVal INTEGER;
BEGIN
    firstNames := namesarray('Renado','Barbara','Freddie','Jeni','Flossie','Eachelle','Collete','Karel','Henry','Mortimer','Marcello','Tybie','Florri','Lucias','See','Katlin','Nissie','Dannye','Jacklyn','Davey',
    'Cyndi','Kimble','Sascha','Claybourne','Kimberlee','Tedra','Martyn','Cyndi','Quinton','Arvy');
    lastNames := namesarray('Sobczak','Chaloner','Hopewell','Triggol','Campling','MacEllen','Bonin','Beautyman','Tremoille','Jackalin','Frogley','Pauluzzi','Peche','McDermott','Lumsdall','Shiril','Johl','Lucken',
    'Baggalley','Faichney','Pleager','O Kennavain','Favela','Wringe','Kimbell','Chatain','Buckingham','Ilyushkin','Rodson','Barnfield');
    
    FOR i IN 1 .. pocet LOOP
        insert into doktor88(jmeno,prijmeni) values(firstNames(FLOOR(DBMS_RANDOM.value(1,30))),lastNames(FLOOR(DBMS_RANDOM.value(1,30)))); --O ID SE STARÁ AUTO INCREMENT - SEKVENCE A TRIGGER
        retVal := i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Vse probehlo bez problemu a do tabulky bylo vlozeno ' ||retVal|| ' zaznamu.');
END;
/

EXEC napln_doktory(1500);
