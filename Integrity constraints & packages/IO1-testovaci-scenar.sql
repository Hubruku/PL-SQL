insert into doktor88 (jmeno, prijmeni) values ('Moira', 'MacNish');
insert into doktor88 (jmeno, prijmeni) values ('Meredith', 'Sima');

EXEC napln_pacienty(3);

insert into vysetreni88 (id_pac, id_dok, datum) values (1,1,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (2,1,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (3,1,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (1,1,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (2,1,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (3,1,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (1,1,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (2,2,sysdate);
insert into vysetreni88 (id_pac, id_dok, datum) values (3,2,sysdate);

/*NASLEDUJICI INSERTY SIMULUJI, KDYZ 3 PACIENTI JDOU K DOKTORUM. PACIENTI 2 A 3 JDOU KE STEJNEMU DOKTOROVI DVAKRAT ZA JEDEN DEN - 
TO JE POVOLENA MIRA. ALE PACIENT 1 JDE KE STEJNEMU DOKTOROVI PO TRETI VE STEJNY DEN. SQL DEVELOPER BY MEL VYPSAT CHYBU A VUBEC NEPROPSAT
ZAZNAM DO DATABAZE.
POZDEJI SE JESTE ROZHODL PACIENT 3 DOJIT K DOKTOROVI CISLO 1.*/

insert into vysetreni88 (id_pac, id_dok, datum) values (3,1,sysdate);
