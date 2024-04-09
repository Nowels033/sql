-- Paso 1
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;
-- Paso 2
CREATE TABLE test.t (s1 INT, PRIMARY KEY (s1));
-- Paso 3
DELIMITER $$
DROP PROCEDURE IF EXISTS handlerdemo$$
CREATE PROCEDURE handlerdemo ()
BEGIN
DECLARE -- CONTINUE -- 
EXIT HANDLER FOR SQLSTATE '23000' SET @x = 1;
SET @x = 1;
INSERT INTO test.t VALUES (2);
SET @x = 2;
INSERT INTO test.t VALUES (2);
SET @x = 3;
END
$$
DELIMITER ;
CALL handlerdemo();
SELECT @x;
-- ¿Qué valor devolvería la sentencia SELECT @x?
ff