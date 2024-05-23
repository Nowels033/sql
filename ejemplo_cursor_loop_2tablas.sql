DELIMITER $$

CREATE PROCEDURE CalcularTotalesClientes()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cliente_id INT;
    DECLARE cliente_nombre VARCHAR(255);
    DECLARE total_pedidos DECIMAL(10, 2);

    -- Declarar el cursor para recorrer la tabla clientes
    DECLARE cliente_cursor CURSOR FOR 
    SELECT id, nombre FROM clientes;

    -- Declarar un handler para el final del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir el cursor
    OPEN cliente_cursor;

    -- Bucle para recorrer los registros del cursor
    leer_clientes: LOOP
        -- Obtener el siguiente registro del cursor
        FETCH cliente_cursor INTO cliente_id, cliente_nombre;
        
        -- Si no hay más registros, salir del bucle
        IF done THEN
            LEAVE leer_clientes;
        END IF;
        
        -- Calcular el total de pedidos para el cliente actual
        SELECT SUM(monto) INTO total_pedidos
        FROM pedidos
        WHERE cliente_id = cliente_id;

        -- Si el cliente no tiene pedidos, establecer total_pedidos a 0
        IF total_pedidos IS NULL THEN
            SET total_pedidos = 0;
        END IF;

        -- Aquí puedes realizar cualquier acción con el resultado, como imprimirlo
        -- o almacenarlo en otra tabla, por ahora solo lo imprimimos
        SELECT CONCAT('Cliente: ', cliente_nombre, ' Total de pedidos: ', total_pedidos) AS resultado;

    END LOOP leer_clientes;

    -- Cerrar el cursor
    CLOSE cliente_cursor;
END $$

DELIMITER ;
Explicación del Procedimiento
Declaraciones y Variables:

done se utiliza para controlar el fin del cursor.
cliente_id y cliente_nombre para almacenar los datos de cada cliente.
total_pedidos para almacenar la suma de los pedidos del cliente.
Cursor:

Se declara un cursor cliente_cursor para seleccionar los id y nombre de la tabla clientes.
Un handler CONTINUE HANDLER FOR NOT FOUND se declara para gestionar el final de los registros del cursor, estableciendo done a 1.
Apertura y Bucles:

Se abre el cursor.
Se inicia un bucle leer_clientes que itera sobre cada registro del cursor.
Se utiliza FETCH para obtener cada registro del cursor en las variables cliente_id y cliente_nombre.
Si no hay más registros (done se establece en 1), se abandona el bucle.
Cálculo y Acción:

Para cada cliente, se calcula el total_pedidos sumando los monto de la tabla pedidos donde cliente_id coincide.
Si el cliente no tiene pedidos (total_pedidos es NULL), se establece a 0.
Aquí se imprime el resultado usando SELECT CONCAT(...) (esto es solo un ejemplo, puedes realizar otras acciones como insertar los resultados en otra tabla).
Cierre del Cursor:

Finalmente, se cierra el cursor para liberar los recursos.



DELIMITER $$

CREATE PROCEDURE CalcularTotalesClientes()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cliente_id INT;
    DECLARE cliente_nombre VARCHAR(255);
    DECLARE total_pedidos DECIMAL(10, 2);

    -- Declarar el cursor para recorrer la tabla clientes
    DECLARE cliente_cursor CURSOR FOR 
    SELECT id, nombre FROM clientes;

    -- Declarar un handler para el final del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir el cursor
    OPEN cliente_cursor;

    -- Obtener el primer registro del cursor
    FETCH cliente_cursor INTO cliente_id, cliente_nombre;
    
    WHILE done = 0 DO
        -- Calcular el total de pedidos para el cliente actual
        SELECT SUM(monto) INTO total_pedidos
        FROM pedidos
        WHERE cliente_id = cliente_id;

        -- Si el cliente no tiene pedidos, establecer total_pedidos a 0
        IF total_pedidos IS NULL THEN
            SET total_pedidos = 0;
        END IF;

        -- Aquí puedes realizar cualquier acción con el resultado, como imprimirlo
        -- o almacenarlo en otra tabla, por ahora solo lo imprimimos
        SELECT CONCAT('Cliente: ', cliente_nombre, ' Total de pedidos: ', total_pedidos) AS resultado;

        -- Obtener el siguiente registro del cursor
        FETCH cliente_cursor INTO cliente_id, cliente_nombre;
    END WHILE;

    -- Cerrar el cursor
    CLOSE cliente_cursor;
END $$

DELIMITER ;

Explicación del Procedimiento
Declaraciones y Variables:

done se utiliza para controlar el fin del cursor.
cliente_id y cliente_nombre para almacenar los datos de cada cliente.
total_pedidos para almacenar la suma de los pedidos del cliente.
Cursor:

Se declara un cursor cliente_cursor para seleccionar los id y nombre de la tabla clientes.
Un handler CONTINUE HANDLER FOR NOT FOUND se declara para gestionar el final de los registros del cursor, estableciendo done a 1.
Apertura y Iteración con WHILE:

Se abre el cursor.
Se obtiene el primer registro del cursor usando FETCH.
Bucle WHILE:

Se utiliza un bucle WHILE done = 0 para iterar sobre cada registro del cursor.
Dentro del bucle, se calcula el total_pedidos sumando los monto de la tabla pedidos donde cliente_id coincide.
Si el cliente no tiene pedidos (total_pedidos es NULL), se establece a 0.
Aquí se imprime el resultado usando SELECT CONCAT(...).
Luego, se obtiene el siguiente registro del cursor usando FETCH.
Cierre del Cursor:

Finalmente, se cierra el cursor para liberar los recursos.
Este procedimiento muestra cómo puedes utilizar un cursor en MySQL para recorrer una tabla y realizar operaciones sobre los datos obtenidos sin un bucle explícito, utilizando un bucle WHILE controlado por la variable done.




DELIMITER $$

CREATE FUNCTION CalcularTotalesClientes() RETURNS TEXT
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cliente_id INT;
    DECLARE cliente_nombre VARCHAR(255);
    DECLARE total_pedidos DECIMAL(10, 2);
    DECLARE resultado TEXT DEFAULT '';

    -- Declarar el cursor para recorrer la tabla clientes
    DECLARE cliente_cursor CURSOR FOR 
    SELECT id, nombre FROM clientes;

    -- Declarar un handler para el final del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir el cursor
    OPEN cliente_cursor;

    -- Bucle para recorrer los registros del cursor
    leer_clientes: LOOP
        -- Obtener el siguiente registro del cursor
        FETCH cliente_cursor INTO cliente_id, cliente_nombre;
        
        -- Si no hay más registros, salir del bucle
        IF done THEN
            LEAVE leer_clientes;
        END IF;
        
        -- Calcular el total de pedidos para el cliente actual
        SELECT SUM(monto) INTO total_pedidos
        FROM pedidos
        WHERE cliente_id = cliente_id;

        -- Si el cliente no tiene pedidos, establecer total_pedidos a 0
        IF total_pedidos IS NULL THEN
            SET total_pedidos = 0;
        END IF;

        -- Concatenar el resultado en la variable 'resultado'
        SET resultado = CONCAT(resultado, 'Cliente: ', cliente_nombre, ' Total de pedidos: ', total_pedidos, '\n');
    END LOOP leer_clientes;

    -- Cerrar el cursor
    CLOSE cliente_cursor;
    
    -- Devolver el resultado concatenado
    RETURN resultado;
END $$

DELIMITER ;
Explicación de la Función
Declaraciones y Variables:

done se utiliza para controlar el fin del cursor.
cliente_id y cliente_nombre para almacenar los datos de cada cliente.
total_pedidos para almacenar la suma de los pedidos del cliente.
resultado es una cadena de texto que concatenará los resultados de cada cliente.
Cursor:

Se declara un cursor cliente_cursor para seleccionar los id y nombre de la tabla clientes.
Un handler CONTINUE HANDLER FOR NOT FOUND se declara para gestionar el final de los registros del cursor, estableciendo done a 1.
Apertura del Cursor y Bucle:

Se abre el cursor.
Se inicia un bucle leer_clientes que itera sobre cada registro del cursor.
Se utiliza FETCH para obtener cada registro del cursor en las variables cliente_id y cliente_nombre.
Si no hay más registros (done se establece en 1), se abandona el bucle usando LEAVE.
Cálculo y Concatenación del Resultado:

Para cada cliente, se calcula el total_pedidos sumando los monto de la tabla pedidos donde cliente_id coincide.
Si el cliente no tiene pedidos (total_pedidos es NULL), se establece a 0.
Los resultados se concatenan en la variable resultado.
Cierre del Cursor y Retorno del Resultado:

Finalmente, se cierra el cursor para liberar los recursos.
La función devuelve la cadena resultado con los totales de pedidos de todos los clientes.
Esta función devuelve una cadena de texto que contiene el total de pedidos por cliente. La función podría ser llamada directamente desde una consulta SELECT para obtener el resultado en una sola cadena.






