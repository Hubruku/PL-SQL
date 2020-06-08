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

CREATE OR REPLACE PROCEDURE napln_pacienty( pocet INTEGER DEFAULT 1000 ) AS
    retVal INTEGER;
    BEGIN
        FOR i IN 1 .. pocet LOOP
            insert into pacient88(rodne_cis) values(TO_CHAR(FLOOR(DBMS_RANDOM.value(100000000000,999999999999))));
            retVal := i;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Vse probehlo bez problemu a do tabulky bylo vlozeno ' ||retVal|| ' zaznamu.');
END;
/

------------------------------------------------------ODSUD NIZ JE IMPLEMENTACE PRVNIHO IO--------------------------------------------------------------------------

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-mm-YYYY hh24:mi:ss';

CREATE OR REPLACE TRIGGER checkVisits BEFORE
    INSERT ON vysetreni88
    FOR EACH ROW
DECLARE
    tmp INTEGER DEFAULT 0;
BEGIN
    SELECT count(v.id_pac) INTO tmp FROM vysetreni88 v
    WHERE (v.id_pac = :new.id_pac) AND (v.id_dok = :new.id_dok) AND (TO_CHAR(v.datum,'DD/MM/YYYY') IN (SELECT TO_CHAR(sysdate,'DD/MM/YYYY') FROM dual)) 
    GROUP BY v.id_dok, v.id_pac;
    
    IF tmp > 1
    THEN
        raise_application_error(-20666,'Tento pacient byl dnes u tohoto doktora uz dvakrat. Kvuli kapacitnim moznostem uz treti navsteva nebude povolena.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        tmp := 0;
END;
/