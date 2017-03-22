CREATE TABLE HOLA(ID_HOLA INTEGER, NOMBRE VARCHAR2(80));
SET SERVEROUTPUT ON;



CREATE TABLE USUARIO_INICICIAL (ID INTEGER PRIMARY KEY, NOMBRE VARCHAR2(40));
CREATE TABLE RESPALDO_USUARIOINICIAL(ID INTEGER , NOMBRE VARCHAR2(40));

DROP TABLE RESPALDO_USUARIOINICIAL;

INSERT INTO USUARIO_INICICIAL VALUES(1,'JUAN');
INSERT INTO USUARIO_INICICIAL VALUES(2,'ANA');
INSERT INTO USUARIO_INICICIAL VALUES(3,'ANA');

CREATE OR REPLACE PROCEDURE CONTAR(NUMERO OUT INTEGER)
AS
BEGIN
SELECT COUNT(*) INTO NUMERO FROM USUARIO_INICICIAL;

DBMS_OUTPUT.PUT_LINE('ENCONTRADOS  '||NUMERO);
END;
/

DECLARE 
VALOR INTEGER;
BEGIN
CONTAR(VALOR);
END;
/

-- EL QUE COPIA
CREATE OR REPLACE PROCEDURE COPIAR 
AS
CURSOR CUR_USUARIO_INICICIAL IS SELECT * FROM USUARIO_INICICIAL;
BEGIN
FOR REC IN CUR_USUARIO_INICICIAL LOOP
INSERT INTO RESPALDO_USUARIOINICIAL VALUES(REC.ID, REC.NOMBRE);
END LOOP;
END;
/

CREATE OR REPLACE TRIGGER DISP_USUARIO_INICIAL BEFORE INSERT ON USUARIO_INICICIAL FOR EACH ROW
DECLARE
VALOR INTEGER;
BEGIN
CONTAR(VALOR);
IF  VALOR = 3 THEN
COPIAR();
DELETE FROM USUARIO_INICICIAL;
END IF;
END;
/
------------------------------------------------------
INSERT INTO USUARIO_INICICIAL VALUES(4,'RAUL');
INSERT INTO USUARIO_INICICIAL VALUES(5,'CHANA');
INSERT INTO USUARIO_INICICIAL VALUES(6,'JUANA');

INSERT INTO USUARIO_INICICIAL VALUES(7,'ROQUE');

SELECT * FROM USUARIO_INICICIAL;
SELECT * FROM RESPALDO_USUARIOINICIAL;
DELETE  FROM USUARIO_INICICIAL;