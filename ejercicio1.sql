delimiter $$

CREATE FUNCTION procmaximo ( gama varchar(50))
returns INT UNSIGNED DETERMINISTIC

BEGIN
declare maximo int UNSIGNED;

set maximo=(select max(precio_venta)
 from producto where producto.gama=gama);

RETURN maximo;
END
$$

delimiter $$

CREATE FUNCTION procmin ( gama varchar(50))
returns INT UNSIGNED DETERMINISTIC

BEGIN
declare maximo int UNSIGNED;

set maximo=(select min(precio_venta)
 from producto where producto.gama=gama);

RETURN maximo;
END
$$

delimiter $$

CREATE PROCEDURE noel ( in gama VARCHAR(50), out maximo DECIMAL(15,2),out minimo decimal(15,2))

begin
 set maximo =(select procmaximo(gama));
 set minimo =(select procmin(gama));
 
 end
 $$
 
 delimiter $$
 CREATE FUNCTION procmedia ( gama varchar(50))
returns INT UNSIGNED DETERMINISTIC

BEGIN
declare media int UNSIGNED;

set media=(select avg(precio_venta)
 from producto where producto.gama=gama);

RETURN media;
END
$$

DELIMITER $$
DROP PROCEDURE IF EXISTS ejemplo_bucle_loop$$
CREATE PROCEDURE ejemplo_bucle_loop(IN tope INT, OUT suma INT)
BEGIN
	DECLARE contador INT;
		SET contador = 1;
			SET suma = 0;
				bucle: LOOP
					IF contador > tope THEN
						LEAVE bucle;
							END IF;
								SET suma = suma + contador;
							SET contador = contador + 1;
						END LOOP;
END
$$
DELIMITER ;
CALL ejemplo_bucle_loop(10000, @resultado);
SELECT @resultado;

DELIMITER $$
DROP PROCEDURE IF EXISTS ejemplo_bucle_repeat$$
CREATE PROCEDURE ejemplo_bucle_repeat(IN tope INT, OUT suma INT)
BEGIN
   declare contador int;
 set contador =1 ;
 set suma =0;
 repeat set suma = suma + contador;
 set contador = contador +1;
 until contador > tope
 end repeat;
END
$$

DELIMITER ;
CALL ejemplo_bucle_repeat(10, @resultado);
SELECT @resultado;


DELIMITER $$
DROP PROCEDURE IF EXISTS ejemplo_bucle_while$$
CREATE PROCEDURE ejemplo_bucle_while(IN tope INT, OUT suma INT)
BEGIN
  declare acumulado int;
set acumulado = 1;
set suma =0;
while acumulado <= tope do
set suma = suma + acumulado;
set acumulado = acumulado + 1;
end while;
END
$$

DELIMITER ;
CALL ejemplo_bucle_while(10, @resultado);
SELECT @resultado;

select * from pepollas;

