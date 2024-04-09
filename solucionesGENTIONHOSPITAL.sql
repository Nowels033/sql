SOLUCIONES DEL EJERCICIO DE GESTION HOSPITALARIA HASTA LOS 15 PRIMEROS UPDATES
-- Consultas en la tabla Pacientes
-- 1. Seleccionar todos los pacientes
SELECT * FROM Pacientes;
-- 2. Listar solo los nombres y edades de los pacientes
SELECT Nombre, Edad FROM Pacientes;
-- 3. Filtrar pacientes mayores de 40 años
SELECT * FROM Pacientes WHERE Edad > 40;
-- 4. Ordenar pacientes por edad de forma descendente
SELECT * FROM Pacientes ORDER BY Edad DESC;
-- 5. Contar la cantidad total de pacientes
SELECT COUNT(*) AS TotalPacientes FROM Pacientes;
-- 6. Mostrar pacientes de género femenino
SELECT * FROM Pacientes WHERE Genero = 'Femenino';
-- 7. Obtener el paciente más joven
SELECT * FROM Pacientes ORDER BY Edad ASC LIMIT 1;
-- 8. Filtrar pacientes cuyo nombre comienza con "A"
SELECT * FROM Pacientes WHERE Nombre LIKE 'A%';
-- 9. Calcular el promedio de edades de los pacientes
SELECT AVG(Edad) AS EdadPromedio FROM Pacientes;
-- 10. Seleccionar pacientes de una franja de edad específica
SELECT * FROM Pacientes WHERE Edad BETWEEN 30 AND 50;
-- 11. Encontrar pacientes cuyo nombre contiene "a" (mayúsculas o minúsculas)
SELECT * FROM Pacientes WHERE LOWER(Nombre) LIKE '%a%';
-- 12. Mostrar pacientes ordenados alfabéticamente por nombre
SELECT * FROM Pacientes ORDER BY Nombre;
-- 13. Contar la cantidad de pacientes de género masculino
SELECT COUNT(*) AS TotalMasculinos FROM Pacientes WHERE Genero = 'Masculino';
-- 14. Obtener el paciente más anciano
SELECT * FROM Pacientes ORDER BY Edad DESC LIMIT 1;
-- 15. Filtrar pacientes que no tienen asignada una cama
SELECT * FROM Pacientes WHERE PacienteID NOT IN (SELECT PacienteID FROM Asignaciones);
-- Consultas con JOIN entre varias tablas
-- 1. Listar nombres de pacientes y tipos de cama asignados
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes
JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 2. Mostrar detalles de asignaciones con nombres de pacientes
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Asignaciones
JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- 3. Obtener información completa de las asignaciones con detalles de camas
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Camas.Tipo,
Asignaciones.FechaAsignacion
FROM Asignaciones
JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 4. Listar camas asignadas con detalles de pacientes
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas
JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- 5. Mostrar pacientes y camas disponibles
SELECT Pacientes.Nombre, Camas.CamaID
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
RIGHT JOIN Camas ON Asignaciones.CamaID = Camas.CamaID
WHERE Asignaciones.AsignacionID IS NULL;
-- 6. Obtener la cantidad de camas ocupadas por tipo
SELECT Camas.Tipo, COUNT(*) AS CantidadOcupada
FROM Camas
JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
GROUP BY Camas.Tipo;
-- 7. Listar camas disponibles junto con sus tipos
SELECT Camas.CamaID, Camas.Tipo
FROM Camas
LEFT JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
WHERE Asignaciones.AsignacionID IS NULL;
-- 8. Mostrar la edad promedio de los pacientes asignados a camas individuales
SELECT AVG(Pacientes.Edad) AS EdadPromedio
FROM Pacientes
JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
JOIN Camas ON Asignaciones.CamaID = Camas.CamaID
WHERE Camas.Tipo = 'Individual';
-- 9. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes
JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 10. Listar camas y la cantidad de veces que han sido asignadas
SELECT Camas.CamaID, Camas.Tipo, COUNT(Asignaciones.AsignacionID) AS VecesAsignada
FROM Camas
LEFT JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
GROUP BY Camas.CamaID, Camas.Tipo;
-- 11. Mostrar detalles de asignaciones con nombres de pacientes y tipo de cama
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Camas.Tipo,
Asignaciones.FechaAsignacion
FROM Asignaciones
JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 12. Obtener la cantidad total de camas y la cantidad asignada
SELECT COUNT(Camas.CamaID) AS TotalCamas, COUNT(Asignaciones.AsignacionID) AS
CamasAsignadas
FROM Camas
LEFT JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID;
-- 13. Listar camas ocupadas con detalles de pacientes
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas
JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- 14. Mostrar pacientes sin asignación de cama
SELECT Pacientes.Nombre
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
WHERE Asignaciones.AsignacionID IS NULL;
-- 15. Obtener detalles de asignaciones ordenadas por fecha de asignación
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Camas.Tipo,
Asignaciones.FechaAsignacion
FROM Asignaciones
JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
JOIN Camas ON Asignaciones.CamaID = Camas.CamaID
ORDER BY Asignaciones.FechaAsignacion;
-- Consultas con composición interna entre varias tablas
-- 1. Listar pacientes y sus camas asignadas
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes, Asignaciones, Camas
WHERE Pacientes.PacienteID = Asignaciones.PacienteID
AND Asignaciones.CamaID = Camas.CamaID;
-- 2. Obtener detalles de asignaciones con nombres de pacientes y tipo de cama
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Camas.Tipo,
Asignaciones.FechaAsignacion
FROM Pacientes, Asignaciones, Camas
WHERE Pacientes.PacienteID = Asignaciones.PacienteID
AND Asignaciones.CamaID = Camas.CamaID;
-- 3. Mostrar la edad promedio de los pacientes asignados a camas individuales
SELECT AVG(Pacientes.Edad) AS EdadPromedio
FROM Pacientes, Asignaciones, Camas
WHERE Pacientes.PacienteID = Asignaciones.PacienteID
AND Asignaciones.CamaID = Camas.CamaID
AND Camas.Tipo = 'Individual';
-- 4. Listar camas y la cantidad de veces que han sido asignadas
SELECT Camas.CamaID, Camas.Tipo, COUNT(Asignaciones.AsignacionID) AS VecesAsignada
FROM Camas, Asignaciones
WHERE Camas.CamaID = Asignaciones.CamaID
GROUP BY Camas.CamaID, Camas.Tipo;
-- 5. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes, Asignaciones, Camas
WHERE Pacientes.PacienteID = Asignaciones.PacienteID
AND Asignaciones.CamaID = Camas.CamaID;
-- 6. Listar camas ocupadas con detalles de pacientes
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas, Asignaciones, Pacientes
WHERE Camas.CamaID = Asignaciones.CamaID
AND Asignaciones.PacienteID = Pacientes.PacienteID;
-- 7. Mostrar pacientes sin asignación de cama
SELECT Pacientes.Nombre
FROM Pacientes
WHERE Pacientes.PacienteID NOT IN (SELECT Asignaciones.PacienteID FROM Asignaciones);
-- 8. Obtener la cantidad total de camas y la cantidad asignada
SELECT COUNT(*) AS TotalCamas,
(SELECT COUNT(DISTINCT CamaID) FROM Asignaciones) AS CamasAsignadas
FROM Camas;
-- 9. Listar camas asignadas con detalles de pacientes
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas, Asignaciones, Pacientes
WHERE Camas.CamaID = Asignaciones.CamaID
AND Asignaciones.PacienteID = Pacientes.PacienteID;
-- 10. Mostrar detalles de asignaciones con nombres de pacientes
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Asignaciones, Pacientes
WHERE Asignaciones.PacienteID = Pacientes.PacienteID;
-- 11. Obtener información completa de las asignaciones con detalles de camas
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Camas.Tipo,
Asignaciones.FechaAsignacion
FROM Asignaciones, Pacientes, Camas
WHERE Asignaciones.PacienteID = Pacientes.PacienteID
AND Asignaciones.CamaID = Camas.CamaID;
-- 12. Listar camas disponibles junto con sus tipos
SELECT Camas.CamaID, Camas.Tipo
FROM Camas
WHERE Camas.CamaID NOT IN (SELECT Asignaciones.CamaID FROM Asignaciones);
-- 13. Mostrar pacientes y camas disponibles
SELECT Pacientes.Nombre, Camas.CamaID
FROM Pacientes, Camas
WHERE Pacientes.PacienteID NOT IN (SELECT Asignaciones.PacienteID FROM Asignaciones)
AND Camas.CamaID NOT IN (SELECT Asignaciones.CamaID FROM Asignaciones);
-- 14. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes, Asignaciones, Camas
WHERE Pacientes.PacienteID = Asignaciones.PacienteID
AND Asignaciones.CamaID = Camas.CamaID;
-- 15. Listar camas ocupadas con detalles de pacientes
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas, Asignaciones, Pacientes
WHERE Camas.CamaID = Asignaciones.CamaID
AND Asignaciones.PacienteID = Pacientes.PacienteID;
-- Consultas con composición externa entre varias tablas
-- 1. Listar pacientes y sus camas asignadas (incluso aquellos sin asignación)
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
LEFT JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 2. Obtener detalles de asignaciones con nombres de pacientes y tipo de cama (incluso sin
asignación)
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Camas.Tipo,
Asignaciones.FechaAsignacion
FROM Asignaciones
LEFT JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
LEFT JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 3. Mostrar la edad promedio de los pacientes asignados a camas individuales (incluso sin
asignación)
SELECT AVG(Pacientes.Edad) AS EdadPromedio
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
LEFT JOIN Camas ON Asignaciones.CamaID = Camas.CamaID
WHERE Camas.Tipo = 'Individual';
-- 4. Listar camas y la cantidad de veces que han sido asignadas (incluso sin asignación)
SELECT Camas.CamaID, Camas.Tipo, COUNT(Asignaciones.AsignacionID) AS VecesAsignada
FROM Camas
LEFT JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
GROUP BY Camas.CamaID, Camas.Tipo;
-- 5. Obtener el nombre del paciente y tipo de cama asignada por cada asignación (incluso sin
asignación)
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
LEFT JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 6. Listar camas ocupadas con detalles de pacientes (solo camas ocupadas)
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- 7. Mostrar pacientes sin asignación de cama
SELECT Pacientes.Nombre
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
WHERE Asignaciones.AsignacionID IS NULL;
-- 8. Obtener la cantidad total de camas y la cantidad asignada (solo camas asignadas)
SELECT COUNT(Camas.CamaID) AS TotalCamas, COUNT(Asignaciones.AsignacionID) AS
CamasAsignadas
FROM Camas
LEFT JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID;
-- 9. Listar camas asignadas con detalles de pacientes (solo camas asignadas)
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- 10. Mostrar detalles de asignaciones con nombres de pacientes (solo asignaciones con
pacientes)
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Asignaciones
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- 11. Obtener información completa de las asignaciones con detalles de camas
-- (solo asignaciones con camas)
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, Camas.Tipo,
Asignaciones.FechaAsignacion
FROM Asignaciones
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
INNER JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 12. Listar camas disponibles junto con sus tipos (solo camas disponibles)
SELECT Camas.CamaID, Camas.Tipo
FROM Camas
LEFT JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
WHERE Asignaciones.AsignacionID IS NULL;
-- 13. Mostrar pacientes y camas disponibles (solo pacientes sin asignación)
SELECT Pacientes.Nombre, Camas.CamaID
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
LEFT JOIN Camas ON Asignaciones.CamaID = Camas.CamaID
WHERE Asignaciones.AsignacionID IS NULL;
-- 14. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
-- (solo asignaciones con pacientes)
SELECT Pacientes.Nombre, Camas.Tipo
FROM Pacientes
INNER JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
INNER JOIN Camas ON Asignaciones.CamaID = Camas.CamaID;
-- 15. Listar camas ocupadas con detalles de pacientes (solo camas ocupadas)
SELECT Camas.CamaID, Pacientes.Nombre, Asignaciones.FechaAsignacion
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- Subconsultas con dos o tres tablas
-- 1. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
-- (subconsulta de dos tablas)
SELECT Pacientes.Nombre, (SELECT Camas.Tipo FROM Camas
WHERE Camas.CamaID = Asignaciones.CamaID) AS TipoCama
FROM Pacientes
INNER JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID;
-- 2. Mostrar detalles de asignaciones con nombres de pacientes y tipo de cama
-- (subconsulta de tres tablas)
SELECT Asignaciones.AsignacionID, Pacientes.Nombre, (SELECT Camas.Tipo FROM Camas
WHERE Camas.CamaID = Asignaciones.CamaID) AS TipoCama, Asignaciones.FechaAsignacion
FROM Asignaciones
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
select asignaciones.*, pacientes.nombre, camas.tipo from asignaciones join pacientes
on asignaciones.pacienteid=pacientes.pacienteid join camas on
asignaciones.camaid=camas.camaid;
-- 3. Listar camas ocupadas con detalles de pacientes (subconsulta de tres tablas)
SELECT Camas.CamaID, (SELECT Pacientes.Nombre FROM Pacientes
WHERE Pacientes.PacienteID = Asignaciones.PacienteID) AS NombrePaciente,
Asignaciones.FechaAsignacion
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID;
-- 4. Obtener información completa de las asignaciones con detalles de camas y pacientes
-- (subconsulta de tres tablas)
SELECT Asignaciones.AsignacionID, (SELECT Pacientes.Nombre FROM Pacientes
WHERE Pacientes.PacienteID = Asignaciones.PacienteID) AS NombrePaciente,
(SELECT Camas.Tipo FROM Camas WHERE Camas.CamaID = Asignaciones.CamaID)
AS TipoCama, Asignaciones.FechaAsignacion
FROM Asignaciones;
SELECT Asignaciones.AsignacionID, (SELECT Pacientes.Nombre FROM Pacientes
WHERE Pacientes.PacienteID = Asignaciones.PacienteID) as nombrepaciente, camas.* from
asignaciones
join camas on asignaciones.CamaID=camas.camaid;
-- 5. Listar camas asignadas con detalles de pacientes y tipo de cama (subconsulta de tres
tablas)
SELECT Camas.CamaID, (SELECT Pacientes.Nombre FROM Pacientes
WHERE Pacientes.PacienteID = Asignaciones.PacienteID) AS "Nombre Paciente",
(SELECT Camas.Tipo FROM Camas WHERE Camas.CamaID = Asignaciones.CamaID) AS "Tipo
Cama"
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID;
-- 6. Mostrar pacientes y camas disponibles con sus tipos (subconsulta de tres tablas)
-- Pacientes sin camas asignadas
SELECT pacientes.*, NULL AS CamaID, NULL AS TipoCama FROM Pacientes WHERE
NOT EXISTS (SELECT 1 FROM Asignaciones WHERE Asignaciones.PacienteID =
Pacientes.PacienteID)
UNION
-- Camas sin asignación
SELECT NULL AS PacienteID, NULL AS Nombre, NULL AS Edad, NULL AS Genero, Camas.CamaID,
Camas.Tipo AS TipoCama FROM Camas WHERE
NOT EXISTS (SELECT 1 FROM Asignaciones WHERE Asignaciones.CamaID = Camas.CamaID);
-- 7. Obtener el nombre del paciente y la cantidad de camas asignadas (subconsulta de dos
tablas)
SELECT Pacientes.Nombre, (SELECT COUNT(*) FROM Asignaciones
WHERE Asignaciones.PacienteID = Pacientes.PacienteID) AS CantidadCamasAsignadas
FROM Pacientes;
-- 8. Listar camas con la cantidad de asignaciones y nombres de pacientes (subconsulta de tres
tablas)
SELECT Camas.CamaID, (SELECT COUNT(*) FROM Asignaciones
WHERE Asignaciones.CamaID = Camas.CamaID) AS CantidadAsignaciones,
(SELECT Pacientes.Nombre FROM Pacientes WHERE Pacientes.PacienteID =
(SELECT Asignaciones.PacienteID FROM Asignaciones
WHERE Asignaciones.CamaID = Camas.CamaID LIMIT 1)) AS NombrePaciente
FROM Camas;
-- 9. Mostrar pacientes con asignaciones y su edad promedio (subconsulta de tres tablas)
SELECT Pacientes.Nombre, (SELECT AVG(Pacientes.Edad) FROM Pacientes
WHERE Pacientes.PacienteID = Asignaciones.PacienteID) AS EdadPromedio
FROM Pacientes
INNER JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID;
-- 10. Obtener el tipo de cama y la cantidad de pacientes asignados (subconsulta de dos
tablas)
SELECT Camas.Tipo, (SELECT COUNT(Asignaciones.PacienteID) FROM Asignaciones
WHERE Asignaciones.CamaID = Camas.CamaID) AS CantidadPacientes
FROM Camas;
SELECT Camas.Tipo AS TipoCama, COUNT(DISTINCT Asignaciones.PacienteID) AS
CantidadPacientesAsignados
FROM Camas LEFT JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID GROUP BY
Camas.Tipo;
SELECT TipoCama, (SELECT COUNT(DISTINCT Asignaciones.PacienteID) FROM Asignaciones
WHERE Asignaciones.CamaID IN (SELECT CamaID FROM Camas WHERE TipoCama =
Camas.Tipo)) AS CantidadPacientesAsignados
FROM (SELECT DISTINCT Tipo AS TipoCama FROM Camas) AS TiposCamas;
select Camas.camaid, tipo, (select count(asignaciones.asignacionid) from asignaciones
where camas.camaid=asignaciones.camaid) as vecesasignadas from camas;
-- 11. Listar camas con asignaciones y pacientes ordenados por fecha de asignación
-- (subconsulta de tres tablas)
SELECT Camas.CamaID, Asignaciones.AsignacionID, Pacientes.Nombre,
Asignaciones.FechaAsignacion
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
ORDER BY Asignaciones.FechaAsignacion;
select camas.camaid,(select pacientes.nombre from pacientes
where pacientes.PacienteID = asignaciones.PacienteID)
as nombrepaciente from asignaciones join camas on camas.camaid=asignaciones.camaid
order by asignaciones.fechaasignacion;
select FechaAsignacion,(select camas.camaid from camas where
asignaciones.camaid=camas.camaid) as camaconasignacion
,(select pacientes.nombre from pacientes where
pacientes.pacienteid=asignaciones.pacienteid)
as pacienteasignadoacama from asignaciones order by asignaciones.FechaAsignacion;
-- 12. Mostrar camas individuales y pacientes asignados ordenados alfabéticamente
-- (subconsulta de tres tablas)
SELECT Camas.CamaID, Pacientes.Nombre
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
WHERE Camas.Tipo = 'Individual'
ORDER BY Pacientes.Nombre;
select camas.camaid, (select nombre from pacientes where
pacientes.pacienteid=asignaciones.pacienteID) as nombre
,(select camas.Tipo from camas where camas.CamaID = asignaciones.CamaID) as tipo from
camas
join asignaciones on camas.CamaID=asignaciones.camaid where camas.tipo = 'Individual' order
by
nombre asc;
-- (solucion sin join) -------------------------------------------------------------
SELECT Camas.CamaID, Camas.Tipo AS TipoCama, (SELECT Pacientes.Nombre FROM Pacientes
WHERE Pacientes.PacienteID IN (SELECT Asignaciones.PacienteID FROM Asignaciones
WHERE Asignaciones.CamaID = Camas.CamaID) LIMIT 1 ) AS NombrePaciente
FROM Camas WHERE Camas.Tipo = 'Individual' AND EXISTS (SELECT 1 FROM Asignaciones
WHERE Asignaciones.CamaID = Camas.CamaID) ORDER BY NombrePaciente;
-- ------------------------------------------------------------------------------------
-- 13. Obtener el nombre del paciente y la fecha de asignación más reciente (subconsulta de
tres tablas)
select pacientes.nombre,(select max(asignaciones.FechaAsignacion) from asignaciones where
asignaciones.pacienteid =pacientes.PacienteID) as fecha from pacientes where (select
fechaasignacion from
asignaciones order by FechaAsignacion desc limit 1)=(select max(asignaciones.fechaasignacion)
from
asignaciones where asignaciones.pacienteid=pacientes.PacienteID);
-- (solucion a implementar por Noel) ------------------------------------------------------
SELECT Pacientes.Nombre, (SELECT MAX(Asignaciones.FechaAsignacion) FROM Asignaciones
WHERE Asignaciones.PacienteID = Pacientes.PacienteID) AS FechaAsignacionReciente
FROM Pacientes WHERE Pacientes.PacienteID IN (SELECT DISTINCT PacienteID FROM
Asignaciones);
-- -----------------------------------------------------------------------------------------
select pacientes.nombre,(select camas.camaid from camas where
camas.camaid=asignaciones.CamaID
and asignaciones.PacienteID = pacientes.pacienteid) as camaid, fechaasignacion from
asignaciones
join pacientes on asignaciones.PacienteID = pacientes.PacienteID order by FechaAsignacion
desc limit 1;
-- 14. Listar camas con asignaciones y pacientes de género femenino (subconsulta de tres
tablas)
SELECT Camas.CamaID, Pacientes.Nombre
FROM Camas
INNER JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID
INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID
WHERE Pacientes.Genero = 'Femenino';
select pacientes.nombre, (select camas.camaid from camas where
camas.camaid=asignaciones.CamaID)
as camaid from asignaciones join pacientes on pacientes.pacienteid=asignaciones.pacienteid
where
genero='Femenino';
-- 15. Mostrar pacientes sin asignación de cama y su edad promedio (subconsulta de dos
tablas)
SELECT Pacientes.Nombre, Pacientes.Edad
FROM Pacientes
LEFT JOIN Asignaciones ON Pacientes.PacienteID = Asignaciones.PacienteID
WHERE Asignaciones.AsignacionID IS NULL;
select (select count(pacientes.nombre) from pacientes where pacientes.PacienteID not in
(select asignaciones.pacienteid from asignaciones )), avg(edad) from pacientes where
pacientes.PacienteID
not in(select asignaciones.pacienteid from asignaciones );
-- (solucion a implementar por Brayan) -------------------------------------------------------
SELECT Pacientes.Nombre, Pacientes.Edad, (SELECT AVG(Pacientes.Edad) FROM Pacientes
WHERE Pacientes.PacienteID NOT IN (SELECT DISTINCT PacienteID FROM Asignaciones)) AS
EdadPromedio
FROM Pacientes WHERE Pacientes.PacienteID NOT IN (SELECT DISTINCT PacienteID FROM
Asignaciones);
-- ---------------------------------------------------------------------------------------
-- Subconsultas de Dos y Tres Tablas sin JOIN explícito:
-- Subconsultas sin JOIN explícito entre dos o tres tablas
-- 1. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
SELECT
Pacientes.Nombre,
(SELECT Camas.CamaID FROM Camas WHERE Camas.CamaID = Camas.CamaID AND
Camas.CamaID NOT IN
(SELECT Asignaciones.CamaID FROM Asignaciones WHERE Asignaciones.PacienteID =
Pacientes.PacienteID)
LIMIT 1) AS CamaDisponible, (SELECT Camas.Tipo FROM Camas WHERE Camas.CamaID =
Camas.CamaID
AND Camas.CamaID NOT IN (SELECT Asignaciones.CamaID FROM Asignaciones
WHERE Asignaciones.PacienteID = Pacientes.PacienteID) LIMIT 1) AS TipoCamaDisponible
FROM
Pacientes;
select(select pacientes.nombre from pacientes where pacientes.PacienteID =
asignaciones.pacienteId)
as nombrepaciente, (select camas.tipo from camas where camas.camaid=asignaciones.camaid)
as
tipocamaporasignacion from asignaciones;
-- 2. Mostrar detalles de asignaciones con nombres de pacientes y tipo de cama
SELECT Asignaciones.AsignacionID, Pacientes.Nombre,
(SELECT Camas.Tipo FROM Camas WHERE Camas.CamaID = Asignaciones.CamaID)
AS TipoCama, Asignaciones.FechaAsignacion
FROM Asignaciones, Pacientes
WHERE Asignaciones.PacienteID = Pacientes.PacienteID;
-- 3. Listar camas ocupadas con detalles de pacientes
SELECT Camas.CamaID,
(SELECT Pacientes.Nombre FROM Pacientes WHERE Pacientes.PacienteID =
Asignaciones.PacienteID)
AS NombrePaciente, Asignaciones.FechaAsignacion
FROM Camas, Asignaciones
WHERE Camas.CamaID = Asignaciones.CamaID;
-- 4. Obtener información completa de las asignaciones con detalles de camas y pacientes
SELECT Asignaciones.AsignacionID, Asignaciones.FechaAsignacion,
(SELECT Pacientes.Nombre FROM Pacientes WHERE Pacientes.PacienteID =
Asignaciones.PacienteID)
AS NombrePaciente,
(SELECT Camas.Tipo FROM Camas WHERE Camas.CamaID = Asignaciones.CamaID)
AS TipoCama
FROM Asignaciones;
-- 5. Listar camas asignadas con detalles de pacientes y tipo de cama
SELECT Camas.CamaID, (SELECT Pacientes.Nombre FROM Pacientes WHERE
Pacientes.PacienteID = Asignaciones.PacienteID) AS NombrePaciente, (SELECT Camas.Tipo
FROM Camas WHERE Camas.CamaID = Asignaciones.CamaID) AS TipoCama
FROM Camas, Asignaciones
WHERE Camas.CamaID = Asignaciones.CamaID;
-- 6. Mostrar pacientes y camas disponibles con sus tipos
SELECT -- Mostrar pacientes con camas asignadas
(SELECT Pacientes.Nombre FROM Pacientes WHERE Pacientes.PacienteID =
Asignaciones.PacienteID) AS Nombre,
Asignaciones.CamaID AS CamaAsignada, null as CamaDisponible,
(SELECT Camas.Tipo FROM Camas WHERE Camas.CamaID = Asignaciones.CamaID) AS
TipoCamaAsignada
FROM Asignaciones
UNION
SELECT -- Mostrar pacientes sin camas asignadas
Pacientes.Nombre,
NULL AS CamaAsignada,
NULL as CamaDisponible,
NULL AS TipoCamaAsignada
FROM Pacientes
WHERE Pacientes.PacienteID NOT IN (SELECT DISTINCT PacienteID FROM Asignaciones)
UNION
SELECT -- Mostrar camas disponibles sin asignación
NULL AS Nombre,
NULL AS CamaAsignada,
Camas.CamaID AS CamaDisponible,
Camas.Tipo AS TipoCamaDisponible
FROM Camas
WHERE Camas.CamaID NOT IN (SELECT CamaID FROM Asignaciones WHERE CamaID IS NOT
NULL);
-- 7. Obtener el nombre del paciente y la cantidad de camas asignadas
SELECT Pacientes.Nombre, (SELECT COUNT(*) FROM Asignaciones WHERE
Asignaciones.PacienteID = Pacientes.PacienteID) AS CantidadCamasAsignadas
FROM Pacientes;
select(select pacientes.nombre from pacientes where
pacientes.pacienteid=asignaciones.pacienteid) as nombre
, count(asignaciones.camaid) from asignaciones group by nombre;
-- 8. Listar camas con la cantidad de asignaciones y nombres de pacientes
SELECT Camas.CamaID, (SELECT COUNT(*) FROM Asignaciones WHERE
Asignaciones.CamaID = Camas.CamaID) AS CantidadAsignaciones,
(SELECT Pacientes.Nombre FROM Pacientes WHERE
Pacientes.PacienteID = (SELECT Asignaciones.PacienteID FROM Asignaciones WHERE
Asignaciones.CamaID = Camas.CamaID LIMIT 1)) AS NombrePaciente
FROM Camas;
select camas.camaid,count(asignaciones.asignacionid) as cantidadasignaciones, (select
pacientes.nombre
from pacientes where pacientes.pacienteid = asignaciones.pacienteid) as nombredepaciente
from
camas,asignaciones where camas.camaid=asignaciones.camaid group by
camas.camaid,asignaciones.pacienteid
union
select camas.camaid, (select count(asignaciones.asignacionid) from asignaciones where
camas.camaid=asignaciones.camaid), null as nombrepaciente from camas where
camas.camaid not in
(select asignaciones.camaid from asignaciones);
-- 9. Mostrar pacientes con asignaciones y su edad promedio
SELECT
(SELECT Pacientes.Nombre FROM Pacientes WHERE Pacientes.PacienteID =
Asignaciones.PacienteID) AS Nombre,
(SELECT Pacientes.Edad FROM Pacientes WHERE Pacientes.PacienteID =
Asignaciones.PacienteID) AS Edad,
Asignaciones.CamaID AS CamaAsignada,
(SELECT AVG(Pacientes.Edad) FROM Pacientes WHERE Pacientes.PacienteID IN
(SELECT PacienteID FROM Asignaciones)) AS EdadPromedio
FROM Asignaciones;
-- 10. Obtener el tipo de cama y la cantidad de pacientes asignados
SELECT Camas.Tipo, (SELECT COUNT(DISTINCT Asignaciones.PacienteID) FROM Asignaciones
WHERE
Asignaciones.CamaID = Camas.CamaID) AS CantidadPacientes
FROM Camas;
SELECT Camas.Tipo, (SELECT COUNT(Asignaciones.PacienteID) FROM Asignaciones WHERE
Asignaciones.CamaID = Camas.CamaID) AS CantidadPacientes
FROM Camas;
-- 11. Listar camas con asignaciones y pacientes ordenados por fecha de asignación
SELECT Camas.CamaID, (SELECT Asignaciones.AsignacionID FROM Asignaciones WHERE
Asignaciones.CamaID = Camas.CamaID ORDER BY Asignaciones.FechaAsignacion LIMIT 1) AS
AsignacionID,
(SELECT Pacientes.Nombre FROM Pacientes WHERE Pacientes.PacienteID =
(SELECT Asignaciones.PacienteID FROM Asignaciones WHERE Asignaciones.CamaID =
Camas.CamaID
ORDER BY Asignaciones.FechaAsignacion LIMIT 1)) AS NombrePaciente,
(SELECT Asignaciones.FechaAsignacion FROM Asignaciones WHERE Asignaciones.CamaID =
Camas.CamaID
ORDER BY Asignaciones.FechaAsignacion LIMIT 1) AS FechaAsignacion
FROM Camas;
select asignaciones.camaid, (select nombre from pacientes where
pacientes.PacienteID=asignaciones.PacienteID
)as nombre, fechaasignacion from asignaciones order by asignaciones.fechaasignacion;
-- 12. Mostrar camas individuales y pacientes asignados ordenados alfabéticamente
SELECT distinct(camas.CamaID), (SELECT Pacientes.Nombre FROM Pacientes WHERE
Pacientes.PacienteID = Asignaciones.PacienteID) AS NombrePaciente, camas.tipo
FROM Camas, Asignaciones
WHERE Camas.CamaID = Asignaciones.CamaID
AND Camas.Tipo = 'Individual'
ORDER BY (SELECT Pacientes.Nombre FROM Pacientes WHERE Pacientes.PacienteID =
Asignaciones.PacienteID),
camas.CamaID;
-- 13. Obtener el nombre del paciente y la fecha de asignación más reciente
SELECT Pacientes.Nombre, (SELECT MAX(Asignaciones.FechaAsignacion) FROM Asignaciones
WHERE
Asignaciones.PacienteID = Pacientes.PacienteID) AS FechaAsignacionReciente
FROM Pacientes;
-- 14. Listar camas con asignaciones y pacientes de género femenino
SELECT Camas.CamaID, (SELECT Pacientes.Nombre FROM Pacientes WHERE
Pacientes.PacienteID = Asignaciones.PacienteID) AS NombrePaciente,pacientes.genero
FROM Camas, Asignaciones, Pacientes
WHERE Camas.CamaID = Asignaciones.CamaID
AND Asignaciones.PacienteID = Pacientes.PacienteID
AND Pacientes.Genero = 'Femenino';
select asignaciones.camaid,(select nombre from pacientes where
pacientes.PacienteID=asignaciones.PacienteID)
from asignaciones where asignaciones.pacienteid in(select pacientes.pacienteid from
pacientes where
pacientes.pacienteid=asignaciones.pacienteid and genero='Femenino');
-- 15. Mostrar pacientes sin asignación de cama y su edad promedio
SELECT
Pacientes.Nombre,
Pacientes.Edad,
(SELECT AVG(Edad) FROM Pacientes WHERE Pacientes.PacienteID NOT IN
(SELECT DISTINCT PacienteID FROM Asignaciones)) AS EdadPromedio
FROM
Pacientes
WHERE
Pacientes.PacienteID NOT IN (SELECT DISTINCT PacienteID FROM Asignaciones);
-- Subconsultas con ANY, ALL y EXISTS:
-- 1. Mostrar pacientes con asignaciones de camas de tipo "Individual"
SELECT Nombre
FROM Pacientes
WHERE EXISTS (SELECT 1 FROM Asignaciones WHERE Pacientes.PacienteID =
Asignaciones.PacienteID
AND EXISTS (SELECT 1 FROM Camas WHERE Asignaciones.CamaID = Camas.CamaID AND
Camas.Tipo = 'Individual'));
select * from pacientes where pacienteid=any(select asignaciones.pacienteid from
asignaciones where
asignaciones.camaid = any(select camas.camaid from camas where tipo='Individual'));
select (select nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid) as
nombrepaciente,
(select camas.tipo from camas where camas.camaid=asignaciones.camaid and
camas.tipo='Individual') as tipocama
from asignaciones where asignaciones.camaid = any(select camas.camaid from camas where
camas.camaid=asignaciones.camaid and camas.tipo='Individual');
-- 2. Listar camas con asignaciones donde todas las asignaciones tienen pacientes mayores de
25 años
SELECT CamaID
FROM Asignaciones
WHERE CamaID = ANY (SELECT CamaID FROM Pacientes WHERE Edad > 25);
select * from asignaciones where pacienteid=any(select pacientes.pacienteid from pacientes
where pacientes.pacienteid=asignaciones.pacienteid and edad > 25);
-- 3. Obtener el tipo de cama de las camas asignadas a pacientes mayores de 30 años
select tipo from camas where camaid= any(select asignaciones.camaid from asignaciones
where PacienteID =
any(select pacienteid from pacientes where edad >30));
SELECT DISTINCT Tipo
FROM Camas
WHERE CamaID = ANY (SELECT CamaID FROM Asignaciones WHERE PacienteID =
ANY (SELECT PacienteID FROM Pacientes WHERE Edad > 30));
-- 4. Mostrar camas asignadas a pacientes de género femenino
SELECT CamaID
FROM Asignaciones
WHERE PacienteID = ANY (SELECT PacienteID FROM Pacientes WHERE Genero = 'Femenino');
-- 5. Listar camas donde todas las asignaciones tienen pacientes con al menos 2 asignaciones
SELECT Camas.CamaID, Camas.Tipo FROM Camas
WHERE Camas.CamaID IN (SELECT Asignaciones.CamaID FROM Asignaciones GROUP BY
Asignaciones.CamaID
HAVING COUNT(DISTINCT Asignaciones.PacienteID) > 0 AND MIN((SELECT
COUNT(AsignacionID) FROM Asignaciones
WHERE CamaID = Camas.CamaID AND PacienteID = Asignaciones.PacienteID)) >= 2);
-- buscar solucion noel
-- 6. Obtener camas asignadas donde existe al menos un paciente menor de 25 años
SELECT CamaID, (select nombre from pacientes where
pacientes.pacienteid=asignaciones.pacienteid) as nombre,
(select edad from pacientes where pacientes.pacienteid=asignaciones.pacienteid) as edad
FROM Asignaciones
WHERE PacienteID = ANY (SELECT PacienteID FROM Pacientes WHERE Edad < 26);
-- 7. Mostrar pacientes con asignaciones de camas donde todas las camas son de tipo "Doble"
SELECT Nombre
FROM Pacientes
WHERE PacienteID = ALL (SELECT PacienteID FROM Asignaciones
WHERE CamaID = ALL (SELECT CamaID FROM Camas WHERE Tipo = 'Doble'));
-- 8. Listar camas con asignaciones de pacientes que existen en la tabla de asignaciones
SELECT CamaID
FROM Asignaciones
WHERE EXISTS (SELECT 1 FROM Pacientes WHERE PacienteID = Asignaciones.PacienteID);
-- 9. Obtener camas asignadas a pacientes donde al menos una asignación tiene una fecha
anterior a '2024-01-01'
SELECT CamaID
FROM Asignaciones
WHERE EXISTS (SELECT 1 FROM Asignaciones WHERE Asignaciones.CamaID =
Asignaciones.CamaID AND
FechaAsignacion < '2024-01-01');
-- 10. Mostrar pacientes con asignaciones en todas las camas de tipo "Individual"
SELECT Nombre
FROM Pacientes
WHERE PacienteID = ALL (SELECT PacienteID FROM Asignaciones WHERE CamaID =
ALL (SELECT CamaID FROM Camas WHERE Tipo = 'Individual'));
-- 11. Listar camas con asignaciones de pacientes donde al menos un paciente tiene
asignaciones en todas las camas
SELECT CamaID
FROM Asignaciones
WHERE PacienteID = ANY (SELECT PacienteID FROM Asignaciones WHERE PacienteID =
ALL (SELECT PacienteID FROM Asignaciones));
-- 12. Obtener camas asignadas a pacientes donde todas las asignaciones tienen una fecha de
asignación posterior a '2024-01-01'
SELECT CamaID
FROM Asignaciones
WHERE CamaID = ALL (SELECT CamaID FROM Asignaciones WHERE FechaAsignacion > '2024-
01-01');
-- 13. Mostrar pacientes con asignaciones en todas las camas
SELECT Nombre
FROM Pacientes
WHERE PacienteID = ALL (SELECT PacienteID FROM Asignaciones WHERE CamaID =
ALL (SELECT CamaID FROM Camas));
-- 14. Listar camas con asignaciones de pacientes que no existen en la tabla de asignaciones
SELECT CamaID
FROM Asignaciones
WHERE NOT EXISTS (SELECT 1 FROM Pacientes WHERE PacienteID = Asignaciones.PacienteID);
-- 15. Obtener camas asignadas a pacientes donde al menos una asignación tiene una fecha de
asignación igual a la fecha máxima de asignación
SELECT CamaID
FROM Asignaciones
WHERE EXISTS (SELECT 1 FROM Asignaciones WHERE Asignaciones.CamaID =
Asignaciones.CamaID
AND FechaAsignacion = (SELECT MAX(FechaAsignacion) FROM Asignaciones));
-- 1. Subconsulta con NOT ANY: Obtener pacientes que no tienen asignaciones en camas
individuales.
SELECT Nombre FROM Pacientes WHERE NOT PacienteID = ANY (SELECT PacienteID FROM
Asignaciones WHERE CamaID = ANY (SELECT CamaID FROM Camas WHERE Tipo = 'Individual'));
-- 2. Subconsulta con NOT ALL: Listar camas con asignaciones donde no todas las asignaciones
tienen pacientes mayores de 25 años.
SELECT CamaID FROM Asignaciones WHERE CamaID NOT IN (SELECT CamaID FROM Pacientes
WHERE Edad > 25);
-- 3. Subconsulta con NOT EXISTS: Mostrar pacientes sin asignaciones en ninguna cama.
SELECT Nombre FROM Pacientes WHERE NOT EXISTS (SELECT 1 FROM Asignaciones WHERE
Asignaciones.PacienteID = Pacientes.PacienteID);
-- 4. Subconsulta combinando NOT EXISTS y NOT ANY: Obtener camas sin asignaciones de
pacientes menores de 30 años.
SELECT CamaID FROM Camas WHERE NOT EXISTS (SELECT 1 FROM Asignaciones WHERE
Camas.CamaID = Asignaciones.CamaID AND Asignaciones.PacienteID = ANY (SELECT PacienteID
FROM Pacientes WHERE Edad < 30));
-- 5. Subconsulta combinando NOT EXISTS y NOT ALL: Listar camas con asignaciones de
pacientes donde no todas las asignaciones
-- tienen una fecha de asignación posterior a '2024-01-01'.
SELECT CamaID FROM Asignaciones WHERE CamaID NOT IN (SELECT CamaID FROM
Asignaciones WHERE FechaAsignacion > '2024-01-01');
SELECT DISTINCT Camas.CamaID, Camas.Tipo FROM Camas JOIN Asignaciones ON
Camas.CamaID = Asignaciones.CamaID
WHERE NOT EXISTS (SELECT 1 FROM Pacientes WHERE Pacientes.PacienteID =
Asignaciones.PacienteID AND NOT EXISTS (SELECT 1
FROM Asignaciones AS SubAsignaciones WHERE SubAsignaciones.PacienteID =
Pacientes.PacienteID AND SubAsignaciones.FechaAsignacion <= '2024-01-01'));
-- 1. Consulta con Subconsulta y Agregación: Obtener el número total de camas, la cantidad de
camas ocupadas y la proporción de ocupación.
SELECT COUNT(Camas.CamaID) AS TotalCamas, COUNT(Asignaciones.CamaID) AS
CamasOcupadas, COUNT(Asignaciones.CamaID) / COUNT(Camas.CamaID) AS
ProporcionOcupacion FROM Camas LEFT JOIN Asignaciones ON Camas.CamaID =
Asignaciones.CamaID;
-- 2. Consulta con Subconsulta Correlativa y Agregación: Mostrar la lista de pacientes con la
cantidad total de asignaciones.
SELECT Pacientes.Nombre, (SELECT COUNT(*) FROM Asignaciones WHERE
Asignaciones.PacienteID = Pacientes.PacienteID) AS CantidadAsignaciones FROM Pacientes;
-- 3. Consulta con CTE (Common Table Expression) y JOIN: Listar camas junto con la edad
promedio de los pacientes asignados.
WITH AsignacionesConEdad AS ( SELECT Camas.CamaID, Asignaciones.PacienteID,
Pacientes.Edad FROM Camas INNER JOIN Asignaciones ON Camas.CamaID =
Asignaciones.CamaID INNER JOIN Pacientes ON Asignaciones.PacienteID =
Pacientes.PacienteID ) SELECT CamaID, AVG(Edad) AS EdadPromedio FROM
AsignacionesConEdad GROUP BY CamaID;
-- 4. Consulta con Funciones de Ventana: Obtener la lista de camas con el nombre del paciente
más joven y más viejo asignado a cada cama.
SELECT CamaID, FIRST_VALUE(Pacientes.Nombre) OVER (PARTITION BY CamaID ORDER BY
Pacientes.Edad ASC) AS PacienteMasJoven, FIRST_VALUE(Pacientes.Nombre) OVER
(PARTITION BY CamaID ORDER BY Pacientes.Edad DESC) AS PacienteMasViejo FROM
Asignaciones INNER JOIN Pacientes ON Asignaciones.PacienteID = Pacientes.PacienteID;
-- 5. Consulta con Pivoteo Dinámico: Mostrar la cantidad de camas ocupadas por tipo de cama
en una tabla pivote.
SELECT Tipo, COUNT(DISTINCT Asignaciones.CamaID) AS CamasOcupadas FROM Camas LEFT
JOIN Asignaciones ON Camas.CamaID = Asignaciones.CamaID GROUP BY Tipo;
-- 1. Actualizar la edad de todos los pacientes mayores de 50 años:
UPDATE Pacientes
JOIN (SELECT PacienteID FROM Pacientes WHERE Edad > 50) AS PacientesFiltrados
ON Pacientes.PacienteID = PacientesFiltrados.PacienteID
SET Pacientes.Edad = Pacientes.Edad + 1;
Update Pacientes set edad=edad+1 where pacienteid=
(select * from (select pacienteid from pacientes where edad>50) as subconsulta);
-- 2. Modificar el tipo de cama de todas las camas individuales:
UPDATE Camas AS c1
LEFT JOIN Camas AS c2 ON c1.CamaID = c2.CamaID
SET c1.Tipo = 'Doble'
WHERE c2.Tipo = 'Individual';
-- 3. Actualizar la fecha de asignación de todas las asignaciones a una fecha específica:
UPDATE Asignaciones AS a1
JOIN (SELECT AsignacionID FROM Asignaciones WHERE FechaAsignacion IS NOT NULL) AS a2
ON a1.AsignacionID = a2.AsignacionID
SET a1.FechaAsignacion = '2024-01-01';
-- 4. Incrementar la cantidad de camas disponibles en un determinado piso:
UPDATE Camas SET Disponible = Disponible + 1 WHERE CamaID like '3__';
-- 5. Cambiar el género de todos los pacientes femeninos a masculino:
UPDATE Pacientes SET Genero = 'Masculino' WHERE Genero = 'Femenino';
-- 6. Marcar todas las camas ocupadas como no disponibles:
UPDATE Camas SET Disponible = 0 WHERE CamaID IN (SELECT CamaID FROM Asignaciones);
-- 7. Actualizar la fecha de asignación de las asignaciones más recientes:
UPDATE Asignaciones
SET FechaAsignacion = '2024-12-31'
ORDER BY FechaAsignacion DESC
LIMIT 1;
-- 8. Modificar el tipo de cama para asignaciones de pacientes menores de 30 años:
UPDATE Camas SET Tipo = 'Individual' WHERE CamaID IN (SELECT CamaID FROM Asignaciones
WHERE PacienteID IN (SELECT PacienteID FROM Pacientes WHERE Edad < 30));
-- 9. Actualizar la cantidad máxima de camas permitidas por tipo:
UPDATE Camas SET MaxCamas = 20 WHERE Tipo = 'Doble';
-- 10. Cambiar la fecha de asignación de pacientes en camas individuales:
UPDATE Asignaciones SET FechaAsignacion = '2024-02-15' WHERE CamaID IN (SELECT CamaID
FROM Camas WHERE Tipo = 'Individual');
-- 11. Incrementar la cantidad de camas asignadas para pacientes con más de 2 asignaciones:
UPDATE Pacientes SET CantidadAsignaciones = CantidadAsignaciones + 1 WHERE PacienteID IN
(SELECT PacienteID FROM Asignaciones GROUP BY PacienteID HAVING COUNT(*) > 2);
-- 12. Actualizar la fecha de asignación para todas las asignaciones de un paciente específico:
UPDATE Asignaciones SET FechaAsignacion = '2024-03-20' WHERE PacienteID = (SELECT
PacienteID FROM Pacientes WHERE Nombre = 'Juan Perez');
-- 13. Modificar el tipo de cama para asignaciones de pacientes mayores de 40 años:
UPDATE Camas SET Tipo = 'Individual' WHERE CamaID IN (SELECT CamaID FROM Asignaciones
WHERE PacienteID IN (SELECT PacienteID FROM Pacientes WHERE Edad > 40));
-- 14. Cambiar la disponibilidad de camas individuales a no disponibles:
UPDATE Camas SET Disponible = 0 WHERE Tipo = 'Individual';
-- 15. Actualizar la fecha de asignación de las asignaciones más antiguas:
UPDATE Asignaciones SET FechaAsignacion = '2024-01-01' WHERE FechaAsignacion = (SELECT
MIN(FechaAsignacion) FROM Asignaciones);
