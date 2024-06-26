create database Personal;
use Personal;

CREATE TABLE Departamento(
  Dept_no int PRIMARY KEY,
  Nombre VARCHAR(15),
  Ubicacion VARCHAR(15)
);
INSERT INTO Departamento VALUES (10,'CONTABILIDAD','SEVILLA');
INSERT INTO Departamento VALUES (20,'INVESTIGACION','MADRID');
INSERT INTO Departamento VALUES (30,'VENTAS','BARCELONA');
INSERT INTO Departamento VALUES (40,'PRODUCCION','BILBAO');

CREATE TABLE Empleado (
 Emp_no VARCHAR(4) PRIMARY KEY,
 Nombre VARCHAR(25),
 Salario int,
 Dept_no int NOT NULL,
 Foreign Key (Dept_no) REFERENCES Departamento(Dept_no)
 on delete cascade on update cascade
);

INSERT INTO Empleado VALUES ('7369','SANCHEZ',1040,20);
INSERT INTO Empleado VALUES ('7499','ARROYO',1500,30);
INSERT INTO Empleado VALUES ('7521','SALA',1625,30);
INSERT INTO Empleado VALUES ('7566','JIMENEZ',3500,40);
INSERT INTO Empleado VALUES ('7654','MARTIN',1600,30);
INSERT INTO Empleado VALUES ('7698','NEGRO',3005,30);
INSERT INTO Empleado VALUES ('7782','CEREZO',2885,10);
INSERT INTO Empleado VALUES ('7788','GIL',3000,20);
INSERT INTO Empleado VALUES ('7839','REY',4100,10);
INSERT INTO Empleado VALUES ('7844','TOVAR',1350,30);
INSERT INTO Empleado VALUES ('7876','ALONSO',1430,40);
INSERT INTO Empleado VALUES ('7900','JIMENO',1335,30);
INSERT INTO Empleado VALUES ('7902','FERNANDEZ',3000,20);
INSERT INTO Empleado VALUES ('7934','MUÑOZ',1690,10);

select empleado.nombre as 'empleado',departamento.nombre as 'departamento',empleado.salario from empleado join departamento on empleado.dept_no= departamento.dept_no;
