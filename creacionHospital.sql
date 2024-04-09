CREATE DATABASE HospitalDB;

USE HospitalDB;

CREATE TABLE Pacientes (
PacienteID INT PRIMARY KEY,
Nombre VARCHAR(50),
Edad INT,
Genero VARCHAR(10)
);
CREATE TABLE Camas (
CamaID INT PRIMARY KEY,
Tipo VARCHAR(20),
Disponible BOOLEAN
);
CREATE TABLE Asignaciones (
AsignacionID INT PRIMARY KEY,
PacienteID INT,
CamaID INT,
FechaAsignacion DATE,
FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID),
FOREIGN KEY (CamaID) REFERENCES Camas(CamaID));


INSERT INTO Pacientes VALUES
(1, 'Juan Pérez', 35, 'Masculino'),
(2, 'Ana Gómez', 45, 'Femenino'),
(3, 'Carlos Rodríguez', 28, 'Masculino'),
(4, 'María López', 50, 'Femenino'),
(5, 'Luis Hernández', 40, 'Masculino'),
(6, 'Laura Torres', 35, 'Femenino'),
(7, 'Javier García', 60, 'Masculino'),
(8, 'Elena Martínez', 25, 'Femenino'),
(9, 'Miguel Sánchez', 48, 'Masculino'),
(10, 'Carmen Ruiz', 55, 'Femenino'),
(11, 'Pedro Díaz', 33, 'Masculino'),
(12, 'Sofía Fernández', 42, 'Femenino'),
(13, 'Antonio Jiménez', 38, 'Masculino'),
(14, 'Isabel Castro', 47, 'Femenino'),
(15, 'Raúl Vargas', 29, 'Masculino');

INSERT INTO Camas VALUES
(101, 'Individual', TRUE),
(102, 'Individual', TRUE),
(103, 'Compartida', TRUE),
(104, 'Individual', TRUE),
(105, 'Compartida', TRUE),
(106, 'Individual', TRUE),
(107, 'Compartida', TRUE),
(108, 'Individual', TRUE),
(109, 'Compartida', TRUE),
(110, 'Individual', TRUE),
(111, 'Compartida', TRUE),
(112, 'Individual', TRUE),
(113, 'Compartida', TRUE),
(114, 'Individual', TRUE),
(115, 'Compartida', TRUE);

INSERT INTO Asignaciones VALUES
(1, 1, 101, '2024-01-01'),
(2, 2, 102, '2024-01-02'),
(3, 3, 103, '2024-01-03'),
(4, 4, 104, '2024-01-04'),
(5, 5, 105, '2024-01-05'),
(6, 6, 106, '2024-01-06'),
(7, 7, 107, '2024-01-07'),
(8, 8, 108, '2024-01-08'),
(9, 9, 109, '2024-01-09'),
(10, 10, 110, '2024-01-10'),
(11, 11, 111, '2024-01-11'),
(12, 12, 112, '2024-01-12'),
(13, 13, 113, '2024-01-13'),
(14, 14, 114, '2024-01-14'),
(15, 15, 115, '2024-01-15');


