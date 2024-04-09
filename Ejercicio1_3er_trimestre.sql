1.8.1 Procedimientos sin sentencias SQL
1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre
el texto ¡Hola mundo!.

DELIMITER $$
DROP PROCEDURE IF EXISTS holaMundo$$
CREATE PROCEDURE holaMundo (OUT holamundo VARCHAR(10))
BEGIN
set holamundo= "hola mundo";

END
$$
DELIMITER ;
call  holamundo(@holamundo);
select @holamundo;





2. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje
indicando si el número es positivo, negativo o cero.


DELIMITER $$
DROP PROCEDURE IF EXISTS positivoNegativo$$
CREATE PROCEDURE positivoNegativo (in numero DECIMAL(10,2))
BEGIN

IF numero > 0 
	THEN SELECT "el numero es positivo" as msj;
    ELSEIF numero < 0 THEN
		SELECT " el numero es negativo" as msj;
        ELSE
        select "el numero es positivo" as msj;
	end if;
END
$$
DELIMITER ;
call  positivoNegativo(5);
call  positivoNegativo(-5);
call  positivoNegativo(0);

3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de
entrada, con el valor un número real, y un parámetro de salida, con una cadena de caracteres
indicando si el número es positivo, negativo o cero.

DELIMITER $$
DROP PROCEDURE IF EXISTS positivoNegativoV2$$
CREATE PROCEDURE positivoNegativoV2 (in numero DECIMAL(10,2),out salida varchar(25))
BEGIN

IF numero > 0 
	THEN set salida = "el numero es positivo" ;
    ELSEIF numero < 0 THEN
		set salida =  " el numero es negativo" ;
        ELSE
       set salida= "el numero es cero" ;
	end if;
END
$$
DELIMITER ;
call  positivoNegativoV2(5,@salida);
select @salida;
call  positivoNegativoV2(-5,@salida);
select @salida;
call  positivoNegativoV2(0,@salida);
select @salida;


4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la
nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las
siguientes condiciones:
• [0,5) = Insuficiente
• [5,6) = Aprobado
• [6,7) = Bien
• [7, 9) = Notable
• [9, 10] = Sobresaliente
• En cualquier otro caso la nota no será válida.


DELIMITER $$
DROP PROCEDURE IF EXISTS nota$$
CREATE PROCEDURE nota (in numero DOUBLE)
BEGIN

IF numero >=0 and numero < 5
	THEN select "insufuciente" ;
    ELSEIF numero >= 5 and numero <=6 THEN
		select "Aprobado" ;
      ELSEIF numero > 6 and numero <=7 THEN
       select "Bien"  ;
       ELSEIF numero > 7 and numero <=9 THEN
       select "Notable"  ;
        ELSEIF numero > 9 and numero <=10 THEN
       select "Sobresaliente"  ;
       else 
       SELECT "nota negativa o superior a 10";
	end if;
END
$$
DELIMITER ;
call  nota(5);
call  nota(4);
call  nota(6.5);
call  nota(8.2);

5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de
entrada, con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de
texto indicando la nota correspondiente.


DELIMITER $$
DROP PROCEDURE IF EXISTS notaV2$$
CREATE PROCEDURE notaV2 (in numero DOUBLE,out salida varchar (30))
BEGIN

IF numero >=0 and numero < 5
	THEN SET salida= "insufuciente" ;
    ELSEIF numero >= 5 and numero <=6 THEN
		SET salida= "Aprobado" ;
      ELSEIF numero > 6 and numero <=7 THEN
      SET salida= "Bien"  ;
       ELSEIF numero > 7 and numero <=9 THEN
       SET salida= "Notable"  ;
        ELSEIF numero > 9 and numero <=10 THEN
      SET salida= "Sobresaliente"  ;
       else 
       SET salida= "nota negativa o superior a 10";
	end if;
END
$$
DELIMITER ;
call notaV2(5,@nota);
SELECT @nota;
call notaV2(3.2,@nota);
SELECT @nota;


6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de
control CASE.

DELIMITER $$
DROP PROCEDURE IF EXISTS notaV3$$
CREATE PROCEDURE notaV3 (in numero real,out salida varchar (30))
BEGIN


case numero
when numero >=0 and numero < 5
	THEN SET salida= "insufuciente" ;
    when numero >= 5 and numero <=6 THEN
		SET salida= "Aprobado" ;
      when numero > 6 and numero <=7 THEN
      SET salida= "Bien"  ;
       when numero > 7 and numero <=9 THEN
       SET salida= "Notable"  ;
        when numero > 9 and numero <=10 THEN
      SET salida= "Sobresaliente"  ;
       else 
       SET salida= "nota negativa o superior a 10";
	end case;
END
$$
DELIMITER ;
call notaV3(5,@nota);
SELECT @nota;
call notaV3(3.2,@nota);
SELECT @nota;



7. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que
represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de
la semana correspondiente.
Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.
Triggers, procedimientos y funciones en
MySQL1.8.2 Procedimientos con sentencias SQL
1. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice
una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese
país.
2. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será
una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de
máximo valor realizado para esa forma de pago. Deberá hacer uso de la tabla pago de la base de
datos jardinería.
3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será
una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los
siguientes valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
• el pago de máximo valor,
• el pago de mínimo valor,
Triggers, procedimientos y funciones en
MySQL1.8.2 Procedimientos con sentencias SQL
• el valor medio de los pagos realizados,
• la suma de todos los pagos,
• el número de pagos realizados para esa forma de pago.
Deberá hacer uso de la tabla pago de la base de datos jardineria.
4. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La
tabla cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número y
otra columna llamada cuadrado.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado
calcular_cuadrados con las siguientes características. El procedimiento recibe un parámetro de
entrada llamado tope de tipo INT UNSIGNED y calculará el valor de los cuadrados de los primeros
números naturales hasta el valor introducido como parámetro. El valor del números y de sus
cuadrados deberán ser almacenados en la tabla cuadrados que hemos creado previamente.
Triggers, procedimientos y funciones en
MySQL1.8.2 Procedimientos con sentencias SQL
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de
insertar los nuevos valores de los cuadrados que va a calcular.
Utilice un bucle WHILE para resolver el procedimiento.
5. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
6. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
7. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La
tabla debe tener una única columna llamada número y el tipo de dato de esta columna debe ser
INT UNSIGNED.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado
calcular_números con las siguientes características. El procedimiento recibe un parámetro de
entrada llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio toda
la secuencia de números desde el valor inicial pasado como entrada hasta el 1.
Triggers, procedimientos y funciones en
MySQL1.8.2 Procedimientos con sentencias SQL
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de
insertar los nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento.
8. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
9. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
10. Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra
tabla llamada impares. Las dos tablas deben tener única columna llamada número y el tipo de dato
de esta columna debe ser INT UNSIGNED.
Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado
calcular_pares_impares con las siguientes características.
Triggers, procedimientos y funciones en
MySQL1.8.2 Procedimientos con sentencias SQL
El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá
almacenar en la tabla pares aquellos números pares que existan entre el número 1 el valor
introducido como parámetro. Habrá que realizar la misma operación para almacenar los números
impares en la tabla impares.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de
insertar los nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento.
11. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
12. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
Triggers, procedimientos y funciones en
MySQL1.8.3 Funciones sin sentencias SQL
1. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número
es par o FALSE en caso contrario.
2. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los
valores de sus lados.
3. Escribe una función que reciba como parámetro de entrada un valor numérico que
represente un día de la semana y que devuelva una cadena de caracteres con el nombre del
día de la semana correspondiente.
Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.
4. Escribe una función que reciba tres números reales como parámetros de entrada y
devuelva el mayor de los tres.
5. Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio
que se recibirá como parámetro de entrada.
Triggers, procedimientos y funciones en
MySQL1.8.3 Funciones sin sentencias SQL
6. Escribe una función que devuelva como salida el número de años que han transcurrido
entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como
parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que
han pasado 10 años.
Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona
MySQL:
• DATEDIFF
• TRUNCATE
7. Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero
sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la
misma vocal pero sin acento.
Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe
devolver la cadena Maria.
Triggers, procedimientos y funciones en
MySQL1.8.4 Funciones con sentencias SQL
1. Escribe una función para la base de datos tienda que devuelva el número total de
productos que hay en la tabla productos.
2. Escribe una función para la base de datos tienda que devuelva el valor medio del precio de
los productos de un determinado fabricante que se recibirá como parámetro de entrada. El
parámetro de entrada será el nombre del fabricante.
3. Escribe una función para la base de datos tienda que devuelva el valor máximo del precio
de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El
parámetro de entrada será el nombre del fabricante.
4. Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio
de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El
parámetro de entrada será el nombre del fabricante.
Triggers, procedimientos y funciones en
MySQL1.8.5 Manejo de errores en MySQL
1. Crea una base de datos llamada test que contenga una tabla llamada alumno. La tabla
debe tener cuatro columnas:
• id: entero sin signo (clave primaria).
• nombre: cadena de 50 caracteres.
• apellido1: cadena de 50 caracteres.
• apellido2: cadena de 50 caracteres.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado
insertar_alumno con las siguientes características. El procedimiento recibe cuatro parámetros
de entrada (id, nombre, apellido1, apellido2) y los insertará en la tabla alumno. El
procedimiento devolverá como salida un parámetro llamado error que tendrá un valor igual a
0 si la operación se ha podido realizar con éxito y un valor igual a 1 en caso contrario.
Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que
contiene una clave primaria repetida.
Triggers, procedimientos y funciones en
MySQL1.8.6 Transacciones con procedimientos almacenados
1. Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
Tabla cuentas:
• id_cuenta: entero sin signo (clave primaria).
• saldo: real sin signo.
Tabla entradas:
• id_butaca: entero sin signo (clave primaria).
• nif: cadena de 9 caracteres.
Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado
comprar_entrada con las siguientes características. El procedimiento recibe 3 parámetros de
entrada (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro llamado error que
tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual
a 1 en caso contrario.
Triggers, procedimientos y funciones en
MySQL1.8.6 Transacciones con procedimientos almacenados
El procedimiento de compra realiza los siguientes pasos:
• Inicia una transacción.
• Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta
adecuado.
• Inserta una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el
usuario (nif).
• Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún
error entonces aplica un COMMIT a la transacción y si ha ocurrido algún error aplica un
ROLLBACK.
Triggers, procedimientos y funciones en
MySQL1.8.6 Transacciones con procedimientos almacenados
Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.
• ERROR 1264 (Out of range value)
• ERROR 1062 (Duplicate entry for PRIMARY KEY)
2. ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un
número de cuenta que no existe en la tabla cuentas? ¿Ocurre algún error o podemos comprar la
entrada?
En caso de que exista algún error, ¿cómo podríamos resolverlo?.
Triggers, procedimientos y funciones en
MySQL1.8.7 Cursores
1. Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla
llamada alumnos y 4 sentencias de inserción para inicializar la tabla. La tabla alumnos está
formada por las siguientes columnas:
• id (entero sin signo y clave primaria)
• nombre (cadena de caracteres)
• apellido1 (cadena de caracteres)
• apellido2 (cadena de caracteres
• fecha_nacimiento (fecha)
Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un
valor calculado a partir de la columna fecha_nacimiento. Escriba la sentencia SQL necesaria para
modificar la tabla y añadir la nueva columna.
Triggers, procedimientos y funciones en
MySQL1.8.7 Cursores
Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número de años que
han pasado desde la fecha actual hasta la fecha pasada como parámetro:
• Función: calcular_edad
• Entrada: Fecha
• Salida: Número de años (entero)
Ahora escriba un procedimiento que permita calcular la edad de todos los alumnos que ya existen
en la tabla.
Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que calcule la
edad de cada alumno y actualice la tabla. Este procedimiento hará uso de la función calcular_edad
que hemos creado en el paso anterior.
Triggers, procedimientos y funciones en
MySQL1.8.7 Cursores
2. Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email. Una vez
que hemos modificado la tabla necesitamos asignarle una dirección de correo electrónico de forma
automática.
Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre,
apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.
• Procedimiento: crear_email
• Entrada:
– nombre (cadena de caracteres)
– apellido1 (cadena de caracteres)
– apellido2 (cadena de caracteres)
– dominio (cadena de caracteres)
Triggers, procedimientos y funciones en
MySQL1.8.7 Cursores
• Salida:
– email (cadena de caracteres)
devuelva una dirección de correo electrónico con el siguiente formato:
• El primer carácter del parámetro nombre.
• Los tres primeros caracteres del parámetro apellido1.
• Los tres primeros caracteres del parámetro apellido2.
• El carácter @.
• El dominio pasado como parámetro.
Ahora escriba un procedimiento que permita crear un email para todos los alumnos que ya existen
en la tabla.
Para esto será necesario crear un procedimiento llamado actualizar_columna_email que actualice
la columna email de la tabla alumnos.
Triggers, procedimientos y funciones en
MySQL1.8.7 Cursores
Este procedimiento hará uso del procedimiento crear_email que hemos creado en el paso anterior.
3. Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails
de la tabla alumnos separados por un punto y coma. Ejemplo: juan@ccc.org; maria@ccc.org;
pepe@ccc.org; lucia@ccc.org .