DELIMITER $$
DROP PROCEDURE IF EXISTS listar_productos$$
CREATE PROCEDURE listar_productos(IN gama VARCHAR(50))
BEGIN
	SELECT *
    FROM producto
    WHERE producto.gama = gama;
END
$$

DELIMITER ;
CALL listar_productos('Herramientas');


DELIMITER $$
DROP PROCEDURE IF EXISTS contar_productos$$
CREATE PROCEDURE contar_productos(IN gama VARCHAR(50), OUT total INT UNSIGNED)
BEGIN
	SET total = (
    SELECT count(*)
    from producto
    WHERE producto.gama = gama);
END
 $$
DELIMITER ;
CALL contar_productos('Herramientas', @total) ;
SELECT @total ;


DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_max_media$$
CREATE PROCEDURE calcular_max_media(IN gama VARCHAR(50), OUT maximo DECIMAL(15,2), OUT minimo DECIMAL(15,2), OUT media DECIMAL(15,2))
	SET maximo = (
    SELECT AVG(*)
    from producto
    WHERE producto.gama = gama
    INTO maximo, minimo, media);
    
    

    DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_max_min_media$$
CREATE PROCEDURE calcular_max_min_media(
IN gama VARCHAR(50),
OUT maximo DECIMAL(15, 2),
OUT minimo DECIMAL(15, 2),
OUT media DECIMAL(15, 2)
)
BEGIN
SET maximo = (
SELECT MAX(precio_venta)
FROM producto
WHERE producto.gama = gama);
SET minimo = (
SELECT MIN(precio_venta)
FROM producto
WHERE producto.gama = gama);
SET media = (
SELECT AVG(precio_venta)
FROM producto
WHERE producto.gama = gama);
END
$$
DELIMITER ;
CALL calcular_max_min_media('Herramientas', @maximo, @minimo, @media);
SELECT @maximo, @minimo, @media;

-- ejemplo
delimiter $$
CREATE FUNCTION procmaximo(gama varchar(50)) returns int unsigned DETERMINISTIC
BEGIN
	DECLARE maximo INT UNSIGNED;
	SET maximo = (SELECT max(precio_venta) FROM producto where producto.gama = gama);
	RETURN maximo;
END
$$

delimiter $$
CREATE FUNCTION procminimo(gama varchar(50)) returns int unsigned DETERMINISTIC
BEGIN
	DECLARE minimo INT UNSIGNED;
	SET minimo = (SELECT min(precio_venta) FROM producto where producto.gama = gama);
	RETURN minimo;
END
$$
delimiter $$
create PROCEDURE noel (in gama varchar(50), out maximo decimal(15,2), out minimo DECIMAL(15,2))
BEGIN
	SET maximo = (SELECT procmaximo(gama));
    SET minimo = (SELECT procminimo(gama));
END
$$


delimiter $$
CREATE FUNCTION procmedia(gama varchar(50)) returns int unsigned DETERMINISTIC
BEGIN
	DECLARE media INT UNSIGNED;
	SET media = (SELECT avg(precio_venta) FROM producto where producto.gama = gama);
	RETURN media;
END
$$
call noel('Herramientas', @noel1,@noel2);
select @noel1,@noel2;