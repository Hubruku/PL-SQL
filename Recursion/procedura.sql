SET SERVEROUTPUT ON;

--PROCEDURA VYPISE CELOU RODOVOU LINII DANE VYDRY, DLE ZADANEHO ID VYDRY A TOHO JESTLI CHCEME VYPSAT MATKY ( Z ) A NEBO OTCE ( M )
CREATE OR REPLACE PROCEDURE vypisRodinuVydry(cisloVydry INTEGER, vypisMatkyNeboOtce VARCHAR) AS
    cisloV INTEGER;
    text VARCHAR(30);
    otecNeboMatka VARCHAR(10);
    pohlavi VARCHAR(2);
    jmenoVydry VARCHAR(20);
    vysledek VARCHAR(200);
    SPATNY_VSTUP EXCEPTION;
    PRAGMA exception_init(SPATNY_VSTUP,-20666);
BEGIN
    BEGIN
        SELECT v.pohlavi, v.jmeno INTO pohlavi, jmenoVydry FROM vydra v WHERE v.cv = cisloVydry;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20667,'Vydra s takovym ID neexistuje !');
    END;
    
    IF vypisMatkyNeboOtce = 'M' THEN
        text := ' otcu ';
    ELSIF vypisMatkyNeboOtce = 'Z' THEN
        text := ' matek ';
    ELSE
        RAISE SPATNY_VSTUP;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Vypis' || text || 'v rodove linii vydry jmenem ' || jmenoVydry || '(' || pohlavi || ').');
    WITH Vydry(cv, jmeno, pohlavi, matka, otec, cesta) AS
        (
        SELECT v.cv, v.jmeno, v.pohlavi, v.matka, v.otec, v.jmeno
        FROM vydra v

        UNION ALL

        SELECT v2.cv, v2.jmeno, v2.pohlavi, v2.matka, v2.otec, CTE.cesta || ' -> ' || v2.jmeno
        FROM vydra v2 INNER JOIN Vydry CTE ON (v2.cv = CASE vypisMatkyNeboOtce WHEN 'M' THEN CTE.otec ELSE CTE.matka END)
        )
    SELECT cesta INTO vysledek FROM vydry WHERE cesta LIKE jmenoVydry || ' ->%' ORDER BY LENGTH(cesta) DESC FETCH FIRST 1 ROW ONLY;
    
    DBMS_OUTPUT.PUT_LINE(vysledek);
    
EXCEPTION
    WHEN SPATNY_VSTUP THEN
        RAISE_APPLICATION_ERROR(-20666,'Spatny vstup !');
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20667,'V databazi chybi zaznam o rodicich zadane vydry !');
END;
/