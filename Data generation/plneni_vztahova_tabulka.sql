ALTER SESSION SET NLS_DATE_FORMAT = 'DD-mm-YYYY hh24:mi:ss';

CREATE OR REPLACE PROCEDURE napln_vztah( pocet INTEGER DEFAULT 1000 ) AS
    retVal INTEGER;
    BEGIN
        FOR i IN 1 .. pocet LOOP
            insert into vysetreni88(id_pac, id_dok, datum) values
            (FLOOR(DBMS_RANDOM.value(1,pacient88_id_pac_seq.CURRVAL)),
            FLOOR(DBMS_RANDOM.value(1,doktor88_id_dok_seq.CURRVAL)),
            SYSDATE);
            retVal := i;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Vse probehlo bez problemu a do tabulky bylo vlozeno ' ||retVal|| ' zaznamu.');
END;
/

EXEC napln_vztah(1500);