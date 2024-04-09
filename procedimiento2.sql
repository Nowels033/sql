DELIMITER $$

DROP PROCEDURE IF EXISTS contar_productos$$

CREATE PROCEDURE contar_productos(IN gama VARCHAR(50),OUT total INT UNSIGNED)
BEGIN
	SET total=(
    SELECT count(*)
    FROM producto
    where producto.gama=gama);
END
$$

DELIMITER ;

CALL contar_productos('herramientas',@paco);

select @paco as total;
