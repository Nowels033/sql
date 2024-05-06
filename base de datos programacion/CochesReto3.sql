CREATE DATABASE DatosCoches;
USE DatosCoches;
CREATE TABLE PROPIETARIOS (
   DNI VARCHAR(5) Primary Key,
   Nombre VARCHAR(40),
   Edad INTEGER);

CREATE TABLE COCHES (
   Matricula VARCHAR(10) Primary Key,
   Marca VARCHAR(20),
   Precio INTEGER,
   DNI VARCHAR (5));

INSERT INTO Propietarios values('1A','Pepe',34);
INSERT INTO Propietarios values('1B','Ana',40);
INSERT INTO Propietarios values('1C','Maria',50);
INSERT INTO Propietarios values('1D','Javier',20);
INSERT INTO Propietarios values('1E','Rosa',44);
INSERT INTO Propietarios values('1F','Marcos',50);
INSERT INTO Propietarios values('1G','Pedro',34);
INSERT INTO Propietarios values('1H','Adrian',40);
INSERT INTO Propietarios values('1I','Marta',50);
INSERT INTO Propietarios values('1J','Juan',20);
INSERT INTO Propietarios values('1K','Isabel',44);
INSERT INTO Propietarios values('1L','Miguel',50);

INSERT INTO Coches values('MA-1111','Opel',10000,'1A');
INSERT INTO Coches values('MA-2222','Renault',20000,'1E');
INSERT INTO Coches values('BA-3333','Seat', 15000,'1I');
INSERT INTO Coches values('BA-4444','Citroen',25000,'1C');
INSERT INTO Coches values('MA-5555','Toyota',26000,'1D');
INSERT INTO Coches values('BA-6666','Audi', 30000,'1F');
INSERT INTO Coches values('BA-2222','Citroen',19000,'1L');
INSERT INTO Coches values('MA-3333','Toyota',230000,'1H');
INSERT INTO Coches values('MA-4444','Audi', 38000,'1B');