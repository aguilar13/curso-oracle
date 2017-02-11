CREATE sequence sec_nomina start with 1 increment BY 1 nomaxvalue;
  CREATE TABLE trabajador
    (
      seguro_social INTEGER,
      nombre        VARCHAR2(80),
      paterno       VARCHAR2(80),
      CONSTRAINT pk_seguro_social PRIMARY KEY(seguro_social)
    );
  CREATE TABLE nomina
    (
      id_nomina  INTEGER,
      seguro_soc INTEGER,
      horas_lab  INTEGER,
      fecha_pago DATE,
      saldo FLOAT,
      CONSTRAINT pk_id_nomina PRIMARY KEY(id_nomina),
      CONSTRAINT fk_seguro_soc FOREIGN KEY(seguro_soc) REFERENCES trabajador(seguro_social)
    );
  --Crear Pocedimiento para guardar al trabajador
CREATE OR REPLACE
PROCEDURE guardar_trabajador
  (
    my_id      IN INTEGER,
    my_nombre  IN VARCHAR2,
    my_paterno IN VARCHAR2
  )
AS
BEGIN
  INSERT INTO trabajador VALUES
    (my_id, my_nombre, my_paterno
    );
END;
/
  CREATE OR REPLACE
PROCEDURE guardar_nomina
  (
    my_id_nomina OUT INTEGER,
    my_seguro_social IN INTEGER
  )
AS
BEGIN
  SELECT sec_nomina.nextval INTO my_id_nomina FROM dual;
  INSERT
  INTO nomina
    (
      id_nomina,
      seguro_soc
    )
    VALUES
    (
      my_id_nomina,
      my_seguro_social
    );
END;

DECLARE
  valor INTEGER;
BEGIN
  guardar_trabajador(777,'ana','lopez');
  guardar_nomina(valor, 777);
END;
/
SET serverput ON;
SELECT * FROM trabajador;
select * from nomina;
