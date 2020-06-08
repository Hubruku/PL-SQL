insert into doktor88 (jmeno, prijmeni) values ('Jan', 'Pìkný');

EXEC napln_pacienty(3);

insert into vysetreni88 (id_pac, id_dok, datum) values (4,3,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (5,3,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (6,3,sysdate);

/*DO STREDISKA PRIBYL NOVY DOKTOR JMENEM JAN PEKNY. TENTO DOKTOR SE SPECIALIZUJE NA REHABILITACE. 
BUDEME CHTIT PRESUNOUT PACIENTY OD STAREHO DOKTORA - KTERY ODESEL - K TOMU NOVEMU.

MOJE DATABAZE NENI PRO EVIDENCI PACIENTU U RUZNYCH DOKTORU, JE PRO NAVSTEVY, ALE NECHTELO SE MI TO PREDELAVAT, MAXIMALNE BYCH 
UDELAL NOVOU VAZEBNI TABULKU JAKO SLABOU VAZBU, ABYCH DOSAHL UNIQUE KOMBINACE PF KLICU, A PAK PROVEDL OBSAH TOHO PACKAGE NAD TOU 
TABULKOU. POPR JESTE ROZSIRIT DATABAZI O SPECIALIZACE A PODOBNE VECI.
*/

SELECT * FROM vysetreni88;

DECLARE
    doktorOLDfirst VARCHAR(30);
    doktorOLDlast VARCHAR(30);
    rodneCis VARCHAR(15);
BEGIN
    SELECT p.rodne_cis, d.jmeno, d.prijmeni
    INTO rodneCis, doktorOLDfirst, doktorOLDlast 
    FROM pacient88 p INNER JOIN vysetreni88 v
    ON p.id_pac = v.id_pac INNER JOIN doktor88 d
    ON d.id_dok = v.id_dok
    FETCH NEXT 1 ROW ONLY;
    
    fixVisitors.fix_visitors(fixVisitors.get_patient_id(rodneCis),fixVisitors.get_doctor_id(doktorOLDfirst, doktorOLDlast),fixVisitors.get_doctor_id('Jan','Pìkný'));
END;
/

SELECT * FROM vysetreni88;

SELECT * FROM pacient88;
