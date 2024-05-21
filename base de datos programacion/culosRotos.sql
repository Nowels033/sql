create database NoelEsGay;
use NoelEsGay;

create table culos_rotos
(id int AUTO_INCREMENT,
nombre varchar (50),
sitio varchar (50),
sexo_oral boolean, primary key (id));

insert into culos_rotos(nombre,sitio,sexo_oral) values ("JUANJO","DONDE SEA",TRUE);

UPDATE culos_rotos set nombre="noel" where id =1;

alter table culos_rotos add COLUMN huevoPeludo  VARCHAR(20);


drop database noelesgay;

-- Seleccionar todos los registros de una tabla
SELECT * FROM empleados;

-- Seleccionar campos específicos
SELECT nombre, apellido FROM empleados;

-- Selección con condiciones
SELECT * FROM empleados WHERE edad > 30;

-- Selección con orden
SELECT * FROM empleados ORDER BY apellido ASC;

-- Selección con límite
SELECT * FROM empleados LIMIT 10;

-- Selección con agrupación
SELECT departamento, COUNT(*) FROM empleados GROUP BY departamento;

-- Selección con funciones de agregación
SELECT AVG(salario) AS salario_promedio FROM empleados;
2. Inserción (INSERT)
sql
Copiar código
-- Insertar un solo registro
INSERT INTO empleados (nombre, apellido, edad, departamento, salario)
VALUES ('Juan', 'Pérez', 28, 'Ventas', 30000);

-- Insertar múltiples registros
INSERT INTO empleados (nombre, apellido, edad, departamento, salario)
VALUES 
('María', 'García', 35, 'Marketing', 40000),
('Pedro', 'López', 42, 'TI', 50000);
3. Actualización (UPDATE)
sql
Copiar código
-- Actualizar un solo campo
UPDATE empleados
SET salario = 35000
WHERE nombre = 'Juan' AND apellido = 'Pérez';

-- Actualizar múltiples campos
UPDATE empleados
SET salario = 45000, departamento = 'RRHH'
WHERE nombre = 'María' AND apellido = 'García';
4. Eliminación (DELETE)
sql
Copiar código
-- Eliminar un solo registro
DELETE FROM empleados
WHERE nombre = 'Juan' AND apellido = 'Pérez';

-- Eliminar todos los registros
DELETE FROM empleados;
5. Creación de Tablas (CREATE TABLE)
sql
Copiar código
-- Crear una nueva tabla
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT,
    departamento VARCHAR(50),
    salario DECIMAL(10, 2)
);
6. Modificación de Tablas (ALTER TABLE)
sql
Copiar código
-- Agregar una nueva columna
ALTER TABLE empleados
ADD COLUMN fecha_contratacion DATE;

-- Modificar una columna existente
ALTER TABLE empleados
MODIFY COLUMN salario DECIMAL(15, 2);

-- Eliminar una columna
ALTER TABLE empleados
DROP COLUMN fecha_contratacion;
7. Eliminación de Tablas (DROP TABLE)
sql
Copiar código
-- Eliminar una tabla
DROP TABLE empleados;
8. Creación de Índices (CREATE INDEX)
sql
Copiar código
-- Crear un índice en una columna
CREATE INDEX idx_apellido ON empleados(apellido);

-- Crear un índice único
CREATE UNIQUE INDEX idx_unico_nombre_apellido ON empleados(nombre, apellido);
9. Unión de Tablas (JOIN)
sql
Copiar código
-- Unión interna (INNER JOIN)
SELECT empleados.nombre, empleados.apellido, departamentos.nombre AS departamento
FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id;

-- Unión externa izquierda (LEFT JOIN)
SELECT empleados.nombre, empleados.apellido, departamentos.nombre AS departamento
FROM empleados
LEFT JOIN departamentos ON empleados.departamento_id = departamentos.id;

-- Unión externa derecha (RIGHT JOIN)
SELECT empleados.nombre, empleados.apellido, departamentos.nombre AS departamento
FROM empleados
RIGHT JOIN departamentos ON empleados.departamento_id = departamentos.id;
10. Subconsultas
sql
Copiar código
-- Subconsulta en la cláusula SELECT
SELECT nombre, (SELECT nombre FROM departamentos WHERE departamentos.id = empleados.departamento_id) AS departamento
FROM empleados;

-- Subconsulta en la cláusula WHERE
SELECT nombre, apellido
FROM empleados
WHERE departamento_id = (SELECT id FROM departamentos WHERE nombre = 'Ventas');
11. Transacciones
sql
Copiar código
-- Iniciar una transacción
START TRANSACTION;

-- Ejecutar varias operaciones
INSERT INTO empleados (nombre, apellido, edad, departamento, salario) VALUES ('Ana', 'Martínez', 30, 'TI', 32000);
UPDATE empleados SET salario = 34000 WHERE nombre = 'Pedro' AND apellido = 'López';

-- Confirmar la transacción
COMMIT;

-- O revertir la transacción
ROLLBACK;