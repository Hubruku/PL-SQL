SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE fixVisitors
AS
    FUNCTION get_patient_id(rodneCis IN VARCHAR) RETURN NUMBER;
    FUNCTION get_doctor_id(firstName IN VARCHAR, lastName IN VARCHAR) RETURN NUMBER;
    PROCEDURE fix_visitors(patID IN INTEGER, docID IN INTEGER, newDocID IN INTEGER);
END;
/

CREATE OR REPLACE PACKAGE BODY fixVisitors
AS
    FUNCTION get_patient_id(rodneCis IN VARCHAR) RETURN NUMBER IS patID INTEGER;
    BEGIN
        SELECT id_pac INTO patID FROM pacient88 WHERE rodne_cis = rodneCis;
        RETURN patID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20500,'V databazi nenalezen pacient s timto rodnym cislem.');
            NULL;
    END get_patient_id;
    
    FUNCTION get_doctor_id(firstName IN VARCHAR, lastName IN VARCHAR) RETURN NUMBER IS docID INTEGER;
    BEGIN
        SELECT id_dok INTO docID FROM doktor88 WHERE jmeno = firstName AND prijmeni = lastName;
        RETURN docID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20500,'V databazi nenalezen doktor s timto jmenem.');
            NULL;
    END get_doctor_id;
    
    PROCEDURE fix_visitors(patID IN INTEGER, docID IN INTEGER, newDocID IN INTEGER) AS
    BEGIN
        UPDATE vysetreni88 SET id_dok = newDocID
        WHERE id_pac = patID  AND id_dok = docID;
    END fix_visitors;
    
END fixVisitors;
/