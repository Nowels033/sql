DELIMITER $$
DROP PROCEDURE IF exists  listar_producto$$

CREATE PROCEDURE listar_producto(IN gama VARCHAR(50))

BEGIN
	select *
	from producto
    where producto.gama = gama;
    
END
$$


DELIMITER ;
 CALL listar_producto('herramientas');