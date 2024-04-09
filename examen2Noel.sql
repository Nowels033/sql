CREATE DATABASE Examen2;

USE Examen2;


CREATE TABLE departamento (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  id_departamento INT UNSIGNED,
  fecha_contratacion DATE,
FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1 ,'2020-03-14');
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2 ,'2020-05-16');
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3 ,'2000-07-17');
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4 ,'2000-07-17');
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5 ,'2023-04-09');
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1 ,'2000-09-12');
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2 ,'2021-12-16');
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3 ,'2020-09-20');
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2 ,'2000-07-17');
INSERT INTO empleado VALUES(10, '46384486H', 'Diego', 'Flores', 'Salas', 5 ,'2011-11-27');
INSERT INTO empleado VALUES(11, '67389283A', 'Marta', 'Herrera', 'Gil', 1 ,'2023-01-23');
INSERT INTO empleado VALUES(12, '41234836R', 'Irene', 'Salas', 'Flores', NULL ,'2014-12-05');
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio', 'Sáez', 'Guerrero', NULL ,'2000-07-17');

