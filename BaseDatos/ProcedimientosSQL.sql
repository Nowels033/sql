delimiter $$
create function procMaximo(gama varchar (50))
returns int unsigned
deterministic
begin
	declare maximo int unsigned;
	set maximo = (
	select max(precio_venta) from producto
	where producto.gama = gama);
	return maximo;
end $$



create function procMinimo(gama varchar (50))
returns int unsigned
deterministic
begin
	declare minimo int unsigned;
	set minimo = (
	select min(precio_venta) from producto
	where producto.gama = gama);
	return minimo;
end $$

delimiter $$
create procedure brayan (in gama varchar (50),out media decimal (15,2), out maximo decimal (15,2), out minimo decimal (15,2))
begin
	set maximo = (select procMaximo(gama)); -- llamo al otro procedimiento para que haga la funcion que esta en ella
	set minimo = (select procMinimo(gama)); -- llamo al otro procedimiento para que haga la funcion que esta en ella
end $$
DELIMITER ;
call brayan('Herramientas', @brayan1, @stiven2); -- declaro los nombres para llamar
select @brayan1,@stiven2; -- select para ver que se genero


delimiter $$
create function procMedia (gama varchar (50))
returns int unsigned
deterministic
begin
	declare media int unsigned;
    set media = (select avg (precio_venta) from productos where producto.gama = gama);
    return media;
end $$
call brayan('Herramientas',@media,@brayan1,@stiven2);
select @media,@brayan1,@stiven2;
    
    
DELIMITER $$
DROP PROCEDURE IF EXISTS ejemplo_bucle_loop$$
CREATE PROCEDURE ejemplo_bucle_loop(IN tope INT, OUT suma INT)
BEGIN
	DECLARE contador INT;
		SET contador = 1;
		SET suma = 0;
			bucle: LOOP				/* "bucle" es una etiqueta para nombrar al bucle*/
				IF contador > tope THEN
					LEAVE bucle;	/*hay que poner LEAVE "bucle" para salir del bucle si se cumple la condicion para que salga*/
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
	DECLARE contador INT DEFAULT 0;
    SET suma = 0;
    REPEAT
		SET suma = suma + contador;
		SET contador = contador + 1;
	UNTIL contador > tope 
    END REPEAT;
END
$$
DELIMITER ;
CALL ejemplo_bucle_repeat(2, @resultado);
SELECT @resultado;


DELIMITER $$
DROP PROCEDURE IF EXISTS ejemplo_bucle_repeat$$
CREATE PROCEDURE ejemplo_bucle_while(IN tope INT, OUT suma INT)
BEGIN 
	DECLARE contador INT;
    SET contador=1;
    SET suma=0;
    WHILE contador<=tope DO		/*aqui hay que poner MIENTRAS la condicion se cumpla */
		SET suma = suma + contador;
        SET contador = contador + 1;
	END WHILE;
END
$$
DELIMITER ;
CALL ejemplo_bucle_while(10, @resultado);
SELECT @resultado;

delimiter $$
drop PROCEDURE IF EXISTS proceCine$$
CREATE PROCEDURE proceCine (in param1 int ,in paramNombre varchar(50))
begin

declare existe int DEFAULT 0;

set existe =(select count(id_cuenta) from cuentas where id_cuenta=param1);


if existe = 0 THEN

insert into cuentas (id_cuenta,nombre) VALUES (param1,paramNombre);
SELECT concat("Se creo la cuenta con id : ",param1," con nombre de : ",paramNombre) as mensaje;

else 
select concat("El id :",param1," ya existe") as mensaje;

end if;

end $$
delimiter ;

call proceCine(1,"pablo");

