DELIMITER $$

DROP PROCEDURE IF EXISTS calcular_max_min_media$$

CREATE PROCEDURE calcular_max_min_media(IN gama VARCHAR(50),OUT max DECIMAL(15,2),OUT min DECIMAL(15,2),OUT media DECIMAL(15,2))
BEGIN
	SET max=(
    SELECT max(precio_venta)
    FROM producto
    where producto.gama=gama);
    
    SET min=(
    SELECT min(precio_venta)
    FROM producto
    where producto.gama=gama);
    
    SET media=(
    SELECT avg(precio_venta)
    FROM producto
    where producto.gama=gama);
END
$$
DELIMITER ;




DELIMITER $$

DROP PROCEDURE IF EXISTS calcular_max_min_media$$


CREATE PROCEDURE calcular_max_min_media_into(IN gama VARCHAR(50),OUT max DECIMAL(15,2),OUT min DECIMAL(15,2),OUT media DECIMAL(15,2))
BEGIN
	
    SELECT max(precio_venta), min(precio_venta),avg(precio_venta)
    FROM producto
    where producto.gama=gama
    into max,min,media;
    
    
END
$$


DELIMITER ;