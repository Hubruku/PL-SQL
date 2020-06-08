SET SERVEROUTPUT ON;
--PRO TESTOVANI JSEM SE ROZHODL POUZIT JEDNU VYDRU MUZE A VYPSAT JEHO MATKY

BEGIN
DBMS_OUTPUT.PUT_LINE('Vypisu si rodovou linii vydry.');
END;
/
EXEC vypisRodinuVydry(11,'Z');

BEGIN
DBMS_OUTPUT.PUT_LINE('Nyni pridame vydry do rodove linie. Pridame matku Jarmily, a jeste jeji matku.');
END;
/
INSERT INTO vydra VALUES (17,'Snehurka',null,null, to_date('1.1.90','DD.MM.RR'),'H','Z',1);
INSERT INTO vydra VALUES (16,'Marcela',12,17, to_date('1.1.90','DD.MM.RR'),'H','Z',1);

BEGIN
DBMS_OUTPUT.PUT_LINE('Nyni updatneme informace o Jarmile.');
END;
/
UPDATE vydra SET matka = 16 WHERE cv = 3;

BEGIN
DBMS_OUTPUT.PUT_LINE('Vypiseme updatnutou rodovou linii.');
END;
/
EXEC vypisRodinuVydry(11,'Z');

BEGIN
DBMS_OUTPUT.PUT_LINE('Vidime ze vse funguje.');
END;
/