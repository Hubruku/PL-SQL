SET SERVEROUTPUT ON;

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

EXEC napln_pacienty(1500);