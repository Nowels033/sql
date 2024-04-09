Consultas en la tabla Pacientes
 1. Seleccionar todos los pacientes
 
 select nombre from pacientes;
 
 select * from pacientes;
 
 2. Listar solo los nombres y edades de los pacientes
 
 select nombre,edad from pacientes;
 
 3. Filtrar pacientes mayores de 40 años
 
 select * from pacientes where edad > 40;
 
 4. Ordenar pacientes por edad de forma descendente
 
 select nombre from pacientes order by edad desc;
 
 5. Contar la cantidad total de pacientes
 
 select count(*) from pacientes;
 
 6. Mostrar pacientes de género femenino
 
 select *  from pacientes where genero = "femenino";
 
 select * from pacientes where genero like "F%";
 
 7. Obtener el paciente más joven
 
 select  * from pacientes order by  edad asc limit 1 ;
 
 8. Filtrar pacientes cuyo nombre comienza con "A"
 
 select nombre from pacientes where nombre like "A%";
 
 9. Calcular el promedio de edades de los pacientes
 
 select avg(edad) from pacientes;
 
 10. Seleccionar pacientes de una franja de edad específica
 
 select * from pacientes where edad like "2%";
 
 11. Encontrar pacientes cuyo nombre contiene "a" (mayúsculas o minúsculas)
 
 select * from pacientes where nombre like "%a%";
 
 12. Mostrar pacientes ordenados alfabéticamente por nombre
 
 select * from pacientes order by nombre ;
 
 13. Contar la cantidad de pacientes de género masculino
 
 select count(nombre) from pacientes where genero = "masculino";
 
 14. Obtener el paciente más anciano
 
 select * from pacientes order by edad desc limit 1;
 
 15. Filtrar pacientes que no tienen asignada una cama
 
 select pacienteID from asignaciones where camaid is null; 
 
 Consultas con JOIN:
 Consultas con JOIN entre varias tablas
 1. Listar nombres de pacientes y tipos de cama asignados
 
 select nombre,tipo from pacientes join asignaciones on pacientes.pacienteid=asignaciones.pacienteid join camas on asignaciones.camaid=camas.camaid;
 
 2. Mostrar detalles de asignaciones con nombres de pacientes
 
 select *,pacientes.nombre from asignaciones join pacientes on asignaciones.pacienteid=pacientes.pacienteid;
 
 3. Obtener información completa de las asignaciones con detalles de camas
 
 select *,tipo from asignaciones join camas on asignaciones.camaid=camas.camaid;
 
 4. Listar camas asignadas con detalles de pacientes
 

  
  -- BUENA --
  select camas.camaid,nombre,edad,genero from pacientes join asignaciones on pacientes.pacienteid=asignaciones.pacienteid join camas on asignaciones.camaid=camas.camaid;
 
 5. Mostrar pacientes y camas disponibles
 
 select nombre,disponible  from pacientes join asignaciones on pacientes.pacienteid=asignaciones.pacienteid right join camas on asignaciones.camaid=camas.camaid where disponible=true;
 

 6. Obtener la cantidad de camas ocupadas por tipo
 
 select tipo,count(*) from camas  join asignaciones on camas.camaid=asignaciones.camaid  group by tipo;
 

 
 7. Listar camas disponibles junto con sus tipos
 
  select camas.camaid,tipo from camas  join asignaciones on camas.camaid=asignaciones.camaid where camas.disponible = true ;

 
 8. Mostrar la edad promedio de los pacientes asignados a camas individuales
 
 select avg(edad) as "Edad promedio de los pacientes en camas individuales" from pacientes
 join asignaciones on pacientes.pacienteid=asignaciones.pacienteid  join camas on asignaciones.camaid=camas.camaid;
 
 9. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
 
 select nombre,tipo from pacientes join asignaciones on pacientes.pacienteid=asignaciones.pacienteid  join camas on asignaciones.camaid=camas.camaid;
 
 10. Listar camas y la cantidad de veces que han sido asignadas
 
 select camas.camaid ,count(asignaciones.asignacionid) from asignaciones join camas on asignaciones.camaid=camas.camaid group by camas.camaid;
 
 11. Mostrar detalles de asignaciones con nombres de pacientes y tipo de cama
 
 select asignaciones.*,nombre,tipo from asignaciones join camas on asignaciones.camaid=camas.camaid 
 join pacientes on pacientes.pacienteid=asignaciones.pacienteid;
 
 12. Obtener la cantidad total de camas y la cantidad asignada
 
 select count(camas.camaid) as "total de camas" ,count(asignaciones.camaid) as "cantidad de camas asignadas"
 from camas left join asignaciones on asignaciones.camaid=camas.camaid ; 
 
 
 13. Listar camas ocupadas con detalles de pacientes
 
 select camas.camaid as "cama ocupada",pacientes.* from camas left join asignaciones on 
 asignaciones.camaid=camas.camaid 
left join pacientes on pacientes.pacienteid=asignaciones.pacienteid where disponible = true;
 
 14. Mostrar pacientes sin asignación de cama
 
 select * from pacientes left join asignaciones on pacientes.pacienteid=asignaciones.pacienteid where camaid is null;
 
 15. Obtener detalles de asignaciones ordenadas por fecha de asignación



select asignaciones.* from pacientes  join asignaciones on pacientes.pacienteid=asignaciones.pacienteid order by fechaasignacion;





Consultas con Composición Interna:
 Consultas con composición interna entre varias tablas
 1. Listar pacientes y sus camas asignadas
 
 select pacientes.nombre,asignaciones.camaid from pacientes,asignaciones where pacientes.pacienteid=asignaciones.pacienteid;
 
 select * from asignaciones;
 
 2. Obtener detalles de asignaciones con nombres de pacientes y tipo de cama
 
 select asignaciones.*,pacientes.nombre,camas.tipo from pacientes,asignaciones,camas 
 where pacientes.pacienteid=asignaciones.pacienteid and asignaciones.camaid = camas.camaid;
 
 3. Mostrar la edad promedio de los pacientes asignados a camas individuales
 
 select avg(pacientes.edad) as "edad promedio de los pacientes asignados a camas individuales"  from pacientes,asignaciones,camas 
 where pacientes.pacienteid=asignaciones.pacienteid and asignaciones.camaid = camas.camaid and camas.tipo="individual";
 
 4. Listar camas y la cantidad de veces que han sido asignadas
 
 select camas.camaid as "numero de cama", count(asignaciones.camaid) as " numero de veces asignada" from camas,asignaciones
 where asignaciones.camaid = camas.camaid group by camas.camaid;
 
 5. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
 
 select pacientes.nombre, camas.tipo from pacientes,camas,asignaciones where
 pacientes.pacienteid=asignaciones.pacienteid and asignaciones.camaid = camas.camaid;
 
 6. Listar camas ocupadas con detalles de pacientes
 
 select camas.camaid,pacientes.* from pacientes,camas,asignaciones where
 pacientes.pacienteid=asignaciones.pacienteid and asignaciones.camaid = camas.camaid and camas.disponible=true;
 
 7. Mostrar pacientes sin asignación de cama

 
 select nombre from pacientes where pacienteid not in (select pacienteid from asignaciones where pacientes.PacienteID=Asignaciones.PacienteID);
 
 8. Obtener la cantidad total de camas y la cantidad asignada
 
 select count(camas.camaid),count(asignaciones.camaid) from asignaciones,camas where asignaciones.camaid = camas.camaid;
 select count(*) as totalcamas,(select count(distinct camaid) from asignaciones) as camasasignadas from camas;
 
 -- funciona --
 select 
    (select count(*) from camas) as "total camas",
    (select count(*) from asignaciones) as "camas asignadas";
 
 9. Listar camas asignadas con detalles de pacientes
 
 select asignaciones.camaid,pacientes.* from pacientes,camas,asignaciones where
 pacientes.pacienteid=asignaciones.pacienteid and asignaciones.camaid = camas.camaid;
 
 10. Mostrar detalles de asignaciones con nombres de pacientes
 
 select asignaciones.*, pacientes.nombre from pacientes , asignaciones where asignaciones.pacienteid=pacientes.pacienteid;
 
 11. Obtener información completa de las asignaciones con detalles de camas
 
 select asignaciones.*,camas.tipo,camas.disponible from camas,asignaciones where asignaciones.camaid=camas.camaid;
 
 12. Listar camas disponibles junto con sus tipos
 

 
  select cama1.camaid,cama1.tipo from camas as cama1,camas as cama2 
 where cama1.camaid=cama2.camaid and cama1.disponible is true;
 
 13. Mostrar pacientes y camas disponibles
 
 select pacientes.nombre , camas.camaid from pacientes,camas,asignaciones where asignaciones.camaid is null group by pacientes.nombre ;
 
 14. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
 
 select pacientes.nombre, camas.tipo from pacientes,asignaciones,camas
 where pacientes.pacienteid=asignaciones.pacienteid and asignaciones.camaid = camas.camaid;
 
 15. Listar camas ocupadas con detalles de pacientes
 
 select camas.camaid , pacientes.* from  pacientes,asignaciones,camas
 where pacientes.pacienteid=asignaciones.pacienteid and asignaciones.camaid = camas.camaid and camas.disponible is false;


Consultas con Composición Externa:
 Consultas con composición externa entre varias tablas
 1. Listar pacientes y sus camas asignadas (incluso aquellos sin asignación)
 
 select  pacientes.nombre,asignaciones.camaid from pacientes left join asignaciones on pacientes.pacienteid=asignaciones.pacienteid;
 
 2. Obtener detalles de asignaciones con nombres de pacientes y tipo de cama (incluso sin asignación)
 
 select asignaciones.*,pacientes.nombre,camas.tipo from pacientes left join asignaciones on pacientes.pacienteid=asignaciones.pacienteid 
 left join camas on asignaciones.camaid=camas.camaid; 
 
 3. Mostrar la edad promedio de los pacientes asignados a camas individuales (incluso sin asignación)
 
 select avg(edad) from pacientes left join asignaciones on pacientes.pacienteid=asignaciones.pacienteid 
 left join camas on asignaciones.camaid=camas.camaid where camas.tipo="individual";
 
 4. Listar camas y la cantidad de veces que han sido asignadas (incluso sin asignación)
 
 select camas.camaid, count(asignaciones.camaid) from camas left join asignaciones on asignaciones.camaid=camas.camaid group by camas.camaid;
 
 5. Obtener el nombre del paciente y tipo de cama asignada por cada asignación (incluso sin asignación)
 
 select nombre , tipo from pacientes left join asignaciones on pacientes.pacienteid=asignaciones.pacienteid 
 left join camas on asignaciones.camaid=camas.camaid;
 
 6. Listar camas ocupadas con detalles de pacientes (solo camas ocupadas)
 
 select asignaciones.camaid,pacientes.* from asignaciones join pacientes on pacientes.pacienteid=asignaciones.pacienteid ;
 
 7. Mostrar pacientes sin asignación de cama
 
 select * from pacientes  left join asignaciones on pacientes.pacienteid=asignaciones.pacienteid where asignaciones.pacienteid is null ;
 
 8. Obtener la cantidad total de camas y la cantidad asignada (solo camas asignadas)
 
 select count(c.camaid),count(a.camaid) from camas as c join asignaciones as a on a.camaid=c.camaid;
 
 
 
 9. Listar camas asignadas con detalles de pacientes (solo camas asignadas)
 
 select asignaciones.camaid,pacientes.* from asignaciones join pacientes on pacientes.pacienteid=asignaciones.pacienteid ;
 
 10. Mostrar detalles de asignaciones con nombres de pacientes (solo asignaciones con pacientes)
 
 select asignaciones.*, nombre from asignaciones join pacientes on pacientes.pacienteid=asignaciones.pacienteid 
 where asignaciones.pacienteid is not null;
 
 11. Obtener información completa de las asignaciones con detalles de camas (solo asignaciones con camas)
 
 select asignaciones.pacienteid,asignaciones.camaid,asignaciones.fechaasignacion,camas.* from asignaciones  join camas on asignaciones.camaid=camas.camaid;
 
 12. Listar camas disponibles junto con sus tipos (solo camas disponibles)
 
 select asignaciones.camaid, camas.tipo from asignaciones left join camas on asignaciones.camaid=camas.camaid where asignaciones.camaid is null;
 
 13. Mostrar pacientes y camas disponibles (solo pacientes sin asignación)
 
select pacientes.nombre,camas.camaid from pacientes left join asignaciones on 
 
 
 SELECT p.nombre AS nombre_paciente, c.camaid AS numero_cama
FROM pacientes as p
left JOIN asignaciones as a ON p.pacienteid = a.pacienteid
right JOIN camas as c ON a.camaid = c.camaid
WHERE a.asignacionid IS NULL ;


SELECT p.nombre AS nombre_paciente, c.camaid AS numero_cama
FROM pacientes p
CROSS JOIN camas c
JOIN asignaciones a ON p.pacienteid = a.pacienteid AND c.camaid = a.camaid
WHERE a.asignacionid IS NULL;


 
 
 14. Obtener el nombre del paciente y tipo de cama asignada por cada asignación (solo asignaciones con pacientes)
 
 select nombre,tipo from pacientes join asignaciones on asignaciones.pacienteid=pacientes.pacienteid join camas
 on camas.camaid=asignaciones.camaid;
 
 
 15. Listar camas ocupadas con detalles de pacientes (solo camas ocupadas)
 
 select asignaciones.camaid,pacientes.* from asignaciones join pacientes on asignaciones.pacienteid=pacientes.pacienteid where asignacionid is not null;
 
 Subconsultas de Dos y Tres Tablas:
 Subconsultas con dos o tres tablas
 1. Obtener el nombre del paciente y tipo de cama asignada por cada asignación (subconsulta de dos tablas)
 
 select (select nombre from pacientes where pacientes.pacienteid = a.pacienteid) as "nombre paciente",
 (select tipo from camas where camas.camaid = a.camaid) as "tipo de cama" from asignaciones a;
 
 

 
 2. Mostrar detalles de asignaciones con nombres de pacientes y tipo de cama (subconsulta de tres tablas)
 
 
 
  select a.*,(select nombre from pacientes where pacientes.pacienteid = a.pacienteid) as "nombre paciente",
 (select tipo from camas where camas.camaid = a.camaid) as "tipo de cama" from asignaciones a;
 
 
 3. Listar camas ocupadas con detalles de pacientes (subconsulta de tres tablas)
 
 select camas.camaid,(select pacientes.nombre from pacientes where pacientes.pacienteid =asignaciones.pacienteid),asignaciones.fechaasignacion 
 from camas join asignaciones on asignaciones.camaid=camas.camaid;
 
 4. Obtener información completa de las asignaciones con detalles de camas y pacientes (subconsulta de tres tablas)
 
 select *,(select camas.camaid from camas where camas.camaid = asignaciones.camaid ),(select camas.disponible from camas where camas.camaid = asignaciones.camaid )
 ,(select camas.tipo from camas where camas.camaid = asignaciones.camaid ),
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid),
  (select pacientes.edad from pacientes where pacientes.pacienteid = asignaciones.pacienteid) from asignaciones ;
 
 5. Listar camas asignadas con detalles de pacientes y tipo de cama (subconsulta de tres tablas)
 
select asignaciones.camaid,
 (select camas.tipo from camas where camas.camaid = asignaciones.camaid ),
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid),
  (select pacientes.edad from pacientes where pacientes.pacienteid = asignaciones.pacienteid) from asignaciones ;
 
 
 6. Mostrar pacientes y camas disponibles con sus tipos (subconsulta de tres tablas)
 
 select (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid),asignaciones.camaid
 ,(select camas.tipo from camas where camas.camaid = asignaciones.camaid ) from asignaciones;
 
 
 7. Obtener el nombre del paciente y la cantidad de camas asignadas (subconsulta de dos tablas)
 
 select pacientes.nombre,(select count(asignaciones.camaid) from asignaciones where pacientes.pacienteid =asignaciones.pacienteid ) from pacientes;
 
 
 8. Listar camas con la cantidad de asignaciones y nombres de pacientes (subconsulta de tres tablas)
 
 select camas.camaid,(select count(asignaciones.camaid) from asignaciones,pacientes where pacientes.pacienteid =asignaciones.pacienteid ),
 (select pacientes.nombre from pacientes,asignaciones where pacientes.pacienteid=asignaciones.pacienteid) from camas;
 
 
 select camas.camaid,(select count(*) from asignaciones where asignaciones.camaid = camas.camaid),(select pacientes.nombre from pacientes where pacientes.PacienteID=
 (select asignaciones.pacienteid from asignaciones where asignaciones.camaid=camas.camaid limit 1)) from camas;
 
 
select camas.CamaID,(select nombre from pacientes where pacientes.PacienteID = asignaciones.PacienteID) as Nombre
from camas inner join asignaciones on camas.CamaID = asignaciones.CamaID;
 
 
 9. Mostrar pacientes con asignaciones y su edad promedio (subconsulta de tres tablas)
 
 select (select camas.camaid from camas where camas.camaid=asignaciones.camaid) as "CAMA",(select avg(pacientes.edad) from pacientes where pacientes.pacienteid=asignaciones.pacienteid) "EDAD PROMEDIO DE CADA CAMA ASIGNADA"
 from asignaciones;
 
 select pacientes.nombre,(select avg(pacientes.edad) from pacientes where pacientes.PacienteID = asignaciones.PacienteID ) from pacientes join asignaciones
 on pacientes.pacienteid = asignaciones.PacienteID;
 
 
 10. Obtener el tipo de cama y la cantidad de pacientes asignados (subconsulta de dos tablas)
 
 
 select camas.tipo,(select count(asignaciones.camaid) from asignaciones where asignaciones.camaid=camas.camaid)as " numero de pacientes asignados a la cama" from camas;
 
 select camas.tipo,(select count(distinct asignaciones.PacienteID) from asignaciones where asignaciones.CamaID in( select camaid from camas where
 
 11. Listar camas con asignaciones y pacientes ordenados por fecha de asignación (subconsulta de tres tablas)
 
 
 select (select camas.camaid from camas where asignaciones.camaid=camas.camaid) as "CAMA CON ASIGNACION",
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)"PACIENTE ASIGANDO A CAMA"
 from asignaciones order by asignaciones.fechaasignacion;
 
 12. Mostrar camas individuales y pacientes asignados ordenados alfabéticamente (subconsulta de tres tablas)
 
 
 select (select camas.tipo  from camas where asignaciones.camaid=camas.camaid and camas.tipo="individual"), 
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid order by pacientes.nombre) from asignaciones;
 
 select camas.camaid,camas.tipo as tipocama,(select pacientes.nombre from pacientes where pacientes.PacienteID in(select asignaciones.PacienteID from asignaciones where
 asignaciones.CamaID = camas.camaid) limit 1) as nombrePaciente from camas where camas.tipo="individual" and exists (select 1 from asignaciones where
 asignaciones.camaid = camas.CamaID) order by nombrePaciente;
 
 13. Obtener el nombre del paciente y la fecha de asignación más reciente (subconsulta de tres tablas)
 
select pacientes.nombre,(select max(asignaciones.fechaasignacion) from asignaciones where asignaciones.pacienteid=pacientes.pacienteid) from pacientes
order by (select fechaasignacion from asignaciones order by fechaasignacion desc limit 1 ) limit 1;

-- buena version1 --

select pacientes.nombre,(select max(asignaciones.fechaasignacion)from asignaciones where asignaciones.pacienteid=pacientes.pacienteid)as fecha from pacientes
where (select fechaasignacion from asignaciones order by fechaasignacion desc limit 1 ) = (select max(asignaciones.fechaasignacion) 
from asignaciones where asignaciones.pacienteid=pacientes.pacienteid);

-- fin buena --

select pacientes.nombre,(select fechaasignacion from asignaciones where asignaciones.pacienteid=pacientes.pacienteid limit 1) from pacientes
where (select fechaasignacion from asignaciones order by fechaasignacion desc limit 1 ) = (select max(asignaciones.fechaasignacion) 
from asignaciones where asignaciones.pacienteid=pacientes.pacienteid);

select pacientes.nombre,(select max(asignaciones.fechaasignacion) from asignaciones where asignaciones.pacienteid=pacientes.pacienteid order by FechaAsignacion desc  ) from pacientes;


SELECT Pacientes.Nombre, fechamaxima  AS FechaAsignacionReciente
FROM Pacientes where (select max(asignaciones.fechaasignacion) from asignaciones
order by fechaasignacion) as fechamaxima;



select fechaasignacion from asignaciones; 
 
 
 14. Listar camas con asignaciones y pacientes de género femenino (subconsulta de tres tablas)
 
 -- sin join --
 select (select camas.camaid from camas where asignaciones.camaid=camas.camaid ),
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid and genero="femenino") from asignaciones;
 
 -- con join --
 select pacientes.nombre,(select camas.camaid from camas where camas.camaid = asignaciones.camaid) as camaid
from asignaciones join pacientes on asignaciones.pacienteid = pacientes.pacienteid
where genero = "femenino";
 
 15. Mostrar pacientes sin asignación de cama y su edad promedio (subconsulta de dos tablas)
 
 select (select count(pacientes.nombre) from pacientes where pacientes.pacienteid not in (select asignaciones.pacienteid from asignaciones)), 
 avg(edad) from pacientes where pacientes.pacienteid not in (select asignaciones.pacienteid from asignaciones);
 
 -- solucion fernando --
 select pacientes.nombre, pacientes.edad,(select avg(pacientes.edad) from pacientes
 where pacientes.PacienteID = pacientes.PacienteID) as edadpromedio from pacientes where pacientes.PacienteID not in 
 (select distinct pacienteid from asignaciones);
 
 Subconsultas de Dos y Tres Tablas sin JOIN explícito:
 Subconsultas sin JOIN explícito entre dos o tres tablas
 1. Obtener el nombre del paciente y tipo de cama asignada por cada asignación
 
 select (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente",
 (select camas.tipo from camas where  camas.camaid = asignaciones.camaid) as "tipo de cama por cada asignacion" from asignaciones;
 
 
 2. Mostrar detalles de asignaciones con nombres de pacientes y tipo de cama
 
 
 select asignaciones.fechaasignacion,asignaciones.camaid,asignaciones.pacienteid,
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente",
 (select camas.tipo from camas where  camas.camaid = asignaciones.camaid) as "tipo de cama " from asignaciones;
 
 
 3. Listar camas ocupadas con detalles de pacientes
 
 select (select asignaciones.camaid from asignaciones where pacientes.pacienteid = asignaciones.pacienteid) as "cama ocupada",pacientes.nombre from pacientes;
 
 
 4. Obtener información completa de las asignaciones con detalles de camas y pacientes
 
 select asignaciones.*,
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente",
 (select pacientes.genero from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "sexo paciente",
 (select pacientes.edad from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "edad paciente",
 (select camas.tipo from camas where  camas.camaid = asignaciones.camaid) as "tipo de cama " from asignaciones;
 
 
 5. Listar camas asignadas con detalles de pacientes y tipo de cama
 
 
 select asignaciones.camaid,
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente",
 (select pacientes.genero from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "sexo paciente",
 (select pacientes.edad from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "edad paciente",
 (select camas.tipo from camas where  camas.camaid = asignaciones.camaid) as "tipo de cama " from asignaciones;
 
 6. Mostrar pacientes y camas disponibles con sus tipos
 
 select (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente",
 (select camas.tipo from camas where  camas.camaid = asignaciones.camaid) as "tipo de cama " from asignaciones;
 
 select (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente",
 (select camas.tipo from camas where  camas.camaid = asignaciones.camaid) as "tipo de cama ",
 asignaciones.camaid as "numero de cama" from asignaciones;
 
 
 select
(select pacientes.nombre from pacientes where pacientes.pacienteid =asignaciones.pacienteid) Nombre,
asignaciones.camaid CamaAsignada, null as CamaDisponible,
(select camas.tipo from camas where camas.camaid = asignaciones.camaid) TipoCamaAsignada
from asignaciones

UNION
select
pacientes.nombre,
null as CamaAsignada,
null as CamaDisponible,
null as TipoCamaAsignada from pacientes 
where pacientes.pacienteid not in (select distinct pacienteid from asignaciones) 

UNION
select 
null as Nombre,
null as CamaAsignada,
camas.camaid CamaDisponible,
camas.tipo TipoCamaDisponible
from camas where camas.camaid not in (select camaID from asignaciones where camaid is not null);

 
 
 
 7. Obtener el nombre del paciente y la cantidad de camas asignadas
 
 select (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as nombre,
 count(asignaciones.camaid)  from asignaciones group by nombre;
 

 
 8. Listar camas con la cantidad de asignaciones y nombres de pacientes
 -- mal--
 select count(asignaciones.camaid) as cantidadDeAsignaciones, 
 (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente",
 asignaciones.camaid from asignaciones group by asignaciones.camaid;
 -- fin mala --
 select camas.camaid,(select count(*) from asignaciones where asignaciones.camaid = camas.camaid) as CantidadAsignaciones,
 (select pacientes.nombre from pacientes where pacientes.PacienteID=(select asignaciones.PacienteID from asignaciones where asignaciones.camaid = camas.camaid limit 1)) as nombrePaciente
 from camas;
 
 
 9. Mostrar pacientes con asignaciones y su edad promedio
 
 select (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)as "nombre paciente", 
 (select avg(edad) from pacientes where pacientes.pacienteid = asignaciones.pacienteid) from asignaciones;
 
 
 
 10. Obtener el tipo de cama y la cantidad de pacientes asignados

select (select camas.tipo from camas where asignaciones.camaid = camas.camaid) as tipoCama,
count(asignaciones.camaid) as numeroAsignaciones from asignaciones group by tipoCama;
 
 11. Listar camas con asignaciones y pacientes ordenados por fecha de asignación
 
 select asignaciones.camaid ,(select nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid) as nombre ,fechaasignacion
 from asignaciones order by asignaciones.fechaasignacion;
 
 
 12. Mostrar camas individuales y pacientes asignados ordenados alfabéticamente
 
 select (select camas.tipo from camas where asignaciones.camaid = camas.camaid and camas.tipo="individual") as tipoCama,
 (select nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid) as nombre from asignaciones order by nombre;
 
 
 
 
 13. Obtener el nombre del paciente y la fecha de asignación más reciente+
 
 select pacientes.nombre,(select max(asignaciones.fechaasignacion)from asignaciones where asignaciones.pacienteid=pacientes.pacienteid)as fecha from pacientes
where (select fechaasignacion from asignaciones order by fechaasignacion desc limit 1 ) = (select max(asignaciones.fechaasignacion) 
from asignaciones where asignaciones.pacienteid=pacientes.pacienteid);
 
 
 14. Listar camas con asignaciones y pacientes de género femenino
 
 select asignaciones.camaid , (select pacientes.nombre from pacientes
 where pacientes.pacienteid = asignaciones.pacienteid and pacientes.genero="femenino") from asignaciones;
 
 select Camas.CamaID, (select Camas.Tipo from camas  WHERE camas.CamaID = Asignaciones.CamaID), (select CONCAT(Pacientes.Nombre, ', ', Pacientes.Edad, ', ', Pacientes.genero) from pacientes
 WHERE Pacientes.PacienteID = Asignaciones.PacienteID) AS Detalles_Paciente from camas, asignaciones WHERE Camas.CamaID = Asignaciones.CamaID AND (select Pacientes.genero from pacientes
 WHERE Pacientes.PacienteID = Asignaciones.PacienteID) = 'Femenino';
 
 15. Mostrar pacientes sin asignación de cama y su edad promedio
 
 select (select count(pacientes.nombre) from pacientes where pacientes.pacienteid not in (select asignaciones.pacienteid from asignaciones)), 
 avg(edad) from pacientes where pacientes.pacienteid not in (select asignaciones.pacienteid from asignaciones);
 
select pacientes.nombre,pacientes.edad,(select avg(edad) from pacientes where pacientes.PacienteID not in (select distinct pacienteid from asignaciones)) as edadPromedio
from pacientes where pacientes.pacienteid not in (select distinct pacienteid from asignaciones); 
 
 Subconsultas con ANY, ALL y EXISTS:
 1. Mostrar pacientes con asignaciones de camas de tipo "Individual"
 -- con IN para comprobar lo que tiene que salir --
 select * from pacientes where pacienteid in (select asignaciones.pacienteid from 
 asignaciones where asignaciones.camaid in (select camas.camaid from camas where tipo="individual"));
 
 select * from pacientes where pacienteid = any (select asignaciones.pacienteid from 
 asignaciones where asignaciones.camaid = any (select camas.camaid from camas where tipo="individual"));
 
 2. Listar camas con asignaciones donde todas las asignaciones tienen pacientes mayores de 25 años
 
 select * from asignaciones where pacienteid = any
 (select pacientes.pacienteid from pacientes where pacientes.pacienteid=asignaciones.pacienteid and edad > 25);
 
 3. Obtener el tipo de cama de las camas asignadas a pacientes mayores de 30 años
 
 select tipo from camas where camaid = any (select asignaciones.camaid from asignaciones where pacienteid = any 
 (select pacientes.pacienteid from pacientes where edad >30)); 
 
 
 -- para comprobar --
  select tipo from camas where camaid in (select asignaciones.camaid from asignaciones where pacienteid in
 (select pacientes.pacienteid from pacientes where edad >30));
 
 4. Mostrar camas asignadas a pacientes de género femenino
 
 select camaid from asignaciones where pacienteid = any (select pacientes.pacienteid from pacientes where genero = "femenino"); 
 
 5. Listar camas donde todas las asignaciones tienen pacientes con al menos 2 asignaciones
 
 select camaid from asignaciones as a where a.camaid = any (select count(p.camaid) from asignaciones as p group by p.camaid  );
 
 select camaid from camas where camas.camaid >all  (select  asignaciones.camaid from asignaciones where 2 >= all
 (select count(*) from asignaciones )) group by camaid ;
 
 
 6. Obtener camas asignadas donde existe al menos un paciente menor de 25 años
 
 select pacientes.nombre from pacientes join asignaciones on pacientes.pacienteid = asignaciones.pacienteid where edad >= any 25;
 
 select asignaciones.CamaID , pacientes.nombre from pacientes join asignaciones on pacientes.pacienteid = asignaciones.pacienteid 
 where asignaciones.PacienteID = any (select pacientes.PacienteID from pacientes where edad <= 25);
 
 select edad,nombre from pacientes;
 
 7. Mostrar pacientes con asignaciones de camas donde todas las camas son de tipo "Doble"
 
 select * from pacientes where NOT EXISTS (select 1 from asignaciones inner join camas  
ON Asignaciones.CamaID = Camas.CamaID where Asignaciones.PacienteID = pacientes.PacienteID and Camas.Tipo != 'Compartida');
                                                                                                        
 
 8. Listar camas con asignaciones de pacientes que existen en la tabla de asignaciones
 
 select camas.camaid as "cama asignada que existe en la tabla de asignaciones" from camas where exists
 (select asignaciones.camaid from asignaciones where asignaciones.camaid=camas.camaid ) ;
 
 
 9. Obtener camas asignadas a pacientes donde al menos una asignación tiene una fecha anterior a '2024-01-01'
 
 select camas.camaid as "cama asignada que existe en la tabla de asignaciones anterior a la fecha 2024-01-01 " from camas where exists
 (select asignaciones.camaid from asignaciones where asignaciones.camaid=camas.camaid and  fechaasignacion <'2024-01-01') ;
 
 
 
 10. Mostrar pacientes con asignaciones en todas las camas de tipo "Individual"
 
 select nombre from pacientes where exists (select asignaciones.pacienteid from asignaciones where asignaciones.pacienteid=pacientes.pacienteid 
 and exists (select 1 from camas where asignaciones.camaid = camas.camaid and camas.tipo="individual"));
 
 
 
 
select nombre from pacientes where exists (select asignaciones.pacienteid from asignaciones where asignaciones.pacienteid=pacientes.pacienteid   and exists (select 1 from camas where asignaciones.camaid = camas.camaid )	Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 2	0.000 sec

 
 
 11. Listar camas con asignaciones de pacientes donde al menos un paciente tiene asignaciones en todas las camas
 
 select (select pacientes.nombre from pacientes where pacientes.PacienteID >= 
 all (select asignaciones.PacienteID from asignaciones )) from pacientes ;
 
select camaid,pacienteid from asignaciones
where asignaciones.camaid  = all (Select camas.camaid from camas ) ;
 
 12. Obtener camas asignadas a pacientes donde todas las asignaciones tienen una fecha de asignación posterior a '2024-01-01'
 
  select camas.camaid as "cama asignada que existe en la tabla de asignaciones donde tienen una asignacion posterior a 2024-01-01" from camas where exists
 (select asignaciones.camaid from asignaciones where asignaciones.camaid=camas.camaid and  fechaasignacion >'2024-01-01') ;
 
 13. Mostrar pacientes con asignaciones en todas las camas
 
 select nombre from pacientes where pacientes.pacienteid >= all (
 
 
 14. Listar camas con asignaciones de pacientes que no existen en la tabla de asignaciones
 
 select camas.camaid from camas where not exists (select asignaciones.camaid from asignaciones);
 
 
 15. Obtener camas asignadas a pacientes donde al menos una asignación tiene una fecha de asignación igual a la fecha máxima de asignación
 
 
 select camas.camaid from camas where exists (select asignaciones.camaid from asignaciones
 where camas.camaid = asignaciones.camaid and fechaasignacion = (select max(fechaasignacion) from asignaciones));
 
 select max(fechaasignacion) from asignaciones;
 
 
 1. Subconsulta con NOT ANY: Obtener pacientes que no tienen asignaciones en camas individuales.
 
 select  not distinct pacientes.nombre from pacientes where pacientes.pacienteid=(select asignaciones.pacienteid from asignaciones
 where not camaid = any  (select camas.camaid from camas where camas.tipo="individual"));
 
select distinct pacientes.nombre,
(select tipo from camas where camas.CamaID=asignaciones.CamaID) as 'Tipo de Cama'
from pacientes
join asignaciones on pacientes.pacienteid = asignaciones.pacienteid where not asignaciones.camaid = any 
 (select camas.camaid from camas where camas.tipo="individual");

select distinct (select nombre from pacientes where pacientes.PacienteID=asignaciones.PacienteID) as Paciente,
(select tipo from camas where camas.CamaID=asignaciones.CamaID) as 'Tipo de Cama'
from asignaciones where not asignaciones.CamaID = any (select camas.camaid from camas where tipo='individual'); 
 
 2. Subconsulta con NOT ANY: Listar camas con asignaciones donde no todas las asignaciones tienen pacientes mayores de 25 años.
 
 select asignaciones.camaid, (select pacientes.nombre from pacientes where pacientes.pacienteid = asignaciones.pacienteid)
 from asignaciones where not asignaciones.pacienteid = any (select  pacientes.edad from pacientes where edad < 25 );
 
 select distinct pacientes.nombre,edad from pacientes
join asignaciones on pacientes.pacienteid = asignaciones.pacienteid where not pacientes.edad = any (select pacientes.edad from pacientes where edad > 25);
 
 3. Subconsulta con NOT EXISTS: Mostrar pacientes sin asignaciones en ninguna cama.
 
 select pacientes.nombre from pacientes where not exists (select asignaciones.pacienteid from asignaciones where pacientes.pacienteid = asignaciones.pacienteid);
 
 4. Subconsulta combinando NOT EXISTS y NOT ANY: Obtener camas sin asignaciones de pacientes menores de 30 años.
 
 select asignaciones.CamaID, asignaciones.PacienteID, (select pacientes.Nombre from pacientes where asignaciones.PacienteID=pacientes.PacienteID) as Paciente,
 (select pacientes.Edad from pacientes where asignaciones.PacienteID=pacientes.PacienteID) as Edad
from asignaciones where not exists (select pacientes.PacienteID from pacientes
 where asignaciones.PacienteID=pacientes.PacienteID and not edad = any (select edad from pacientes where edad < 30));
 
 5. Subconsulta combinando NOT EXISTS y NOT ANY: Listar camas con asignaciones de pacientes donde no todas las asignaciones tienen una fecha de asignación posterior a '2024-01-01'.
 
 select asignaciones.camaid, asignaciones.pacienteid from asignaciones join camas on asignaciones.camaid = camas.camaid where not exists 
 
 Ejercicios de Update: 
1. Actualizar la edad de todos los pacientes mayores de 50 años:

update pacientes set edad = edad +1  where pacienteid in(select pacienteid from pacientes where edad >50);

UPDATE pacientes SET edad = edad + 1 WHERE pacienteid IN (SELECT * FROM (SELECT pacienteid FROM pacientes 
WHERE edad > 50) AS subconsulta);

update pacientes join (select pacienteid from pacientes where edad >50) as pacientesFiltrados on pacientes.PacienteID=pacientesFiltrados.pacienteid
set pacientes.Edad=pacientes.Edad+1;

 2. Modificar el tipo de cama de todas las camas individuales:
 
 update camas set tipo ="mixta" where camaid in 
 
 update camas join (select camas.tipo from camas where camas.tipo = "Individual") as cambioCamas on camas.tipo = cambioCamas.tipo set camas.tipo = "Mixta";

 
 3. Actualizar la fecha de asignación de todas las asignaciones a una fecha específica:
 
  update asignaciones join (select asignaciones.FechaAsignacion from asignaciones) as asignacionesfecha on asignaciones.FechaAsignacion = asignacionesfecha.FechaAsignacion
 set asignaciones.FechaAsignacion = '2024-09-09';
 
 4. Incrementar la cantidad de camas disponibles en un determinado piso:
 
  update camas join
 (select camaid from camas where camaid like '1__' and camas.Disponible = 1) as cantidad on camas.CamaID = cantidad.camaid
 set camas.Disponible = 0;
 
 5. Cambiar el género de todos los pacientes femeninos a masculino:
 
 update pacientes set pacientes.genero="masculino" where pacientes.genero="femenino";
 
 update pacientes join (select pacientes.Genero from pacientes where pacientes.Genero='masculino') as femenino 
 on pacientes.Genero = femenino.genero set pacientes.Genero = 'masc';
 
 6. Marcar todas las camas ocupadas como no disponibles:
 
 UPDATE Camas SET Disponible = 0 WHERE CamaID IN (SELECT CamaID FROM Asignaciones);
 
 7. Actualizar la fecha de asignación de las asignaciones más recientes:
 
UPDATE Asignaciones SET FechaAsignacion = '2024-12-31' ORDER BY FechaAsignacion DESC LIMIT 1;
 
 8. Modificar el tipo de cama para asignaciones de pacientes menores de 30 años:
 
 update camas join asignaciones join asignaciones on camas.camaid = asignaciones.camaid join pacientes
 on pacientes.pacienteid=asignaciones.pacienteid set camas.tipo="otros";
 
 
 9. Actualizar la cantidad máxima de camas permitidas por tipo:
 
 UPDATE Camas SET Max(Camas) = 20 WHERE Tipo = 'Doble';
 
 10. Cambiar la fecha de asignación de pacientes en camas individuales:
 
 UPDATE Asignaciones SET FechaAsignacion = '2024-02-15' WHERE CamaID IN (SELECT CamaID FROM Camas WHERE Tipo = 'Individual');
 
 11. Incrementar la cantidad de camas asignadas para pacientes con más de 2 asignaciones:
 
 UPDATE Pacientes SET CantidadAsignaciones = CantidadAsignaciones + 1 WHERE PacienteID IN
(SELECT PacienteID FROM Asignaciones GROUP BY PacienteID HAVING COUNT(*) > 2);
 
 12. Actualizar la fecha de asignación para todas las asignaciones de un paciente específico:
 
 
 update asignaciones join
 
 (select pacientes.pacienteid from pacientes where pacientes.nombre="El Pesado") as pesado
 
 on pesado.pacienteid=asignaciones.pacienteid
  set asignaciones.fechaasignacion=asignaciones.fechaasignacion+1;
 
 UPDATE asignaciones
JOIN pacientes ON asignaciones.pacienteid = pacientes.pacienteid
SET asignaciones.fechaasignacion = DATE_ADD(asignaciones.fechaasignacion, INTERVAL 1 DAY)
WHERE pacientes.nombre = "El Pesado";
 
 13. Modificar el tipo de cama para asignaciones de pacientes mayores de 40 años:
 
 UPDATE Camas SET Tipo = 'Individual' WHERE CamaID IN (SELECT CamaID FROM Asignaciones
WHERE PacienteID IN (SELECT PacienteID FROM Pacientes WHERE Edad > 40));
 
 14. Cambiar la disponibilidad de camas individuales a no disponibles:
 
 UPDATE Camas SET Disponible = 0 WHERE Tipo = 'Individual';
 
 15. Actualizar la fecha de asignación de las asignaciones más antiguas:
 
 UPDATE Asignaciones SET FechaAsignacion = '2024-01-01' WHERE FechaAsignacion = (SELECT
MIN(FechaAsignacion) FROM Asignaciones);

 
 Ejercicios de Update:
1. Incrementar la edad de todos los pacientes asignados a camas individuales en 2 años:

UPDATE pacientes SET edad = edad + 2 WHERE pacienteid IN (SELECT pacienteid FROM (SELECT pacientes.pacienteid 
FROM pacientes JOIN asignaciones ON pacientes.pacienteid = asignaciones.pacienteid JOIN camas 
ON asignaciones.camaid = camas.camaid WHERE camas.tipo = "individual") AS subconsulta);

2. Marcar como no disponible todas las camas asignadas a pacientes menores de 25 años:

	UPDATE camas set disponible=false where camas.camaid in(select camas.camaid from ( select camas.camaid from camas
    join asignaciones ON asignaciones.camaid = camas.camaid join pacientes ON pacientes.pacienteid = asignaciones.pacienteid
    where pacientes.edad < 30)as sub );

3. Actualizar la fecha de asignación de las asignaciones realizadas en camas del piso 3:

UPDATE asignaciones set fechaasignacion = '2024-01-01' where asignaciones.asignacionid in(select asignaciones.camaid 
from( select asignaciones.camaid from asignaciones join camas ON asignaciones.camaid = camas.camaid where camas.camaid like "3__")as sub);


4. Cambiar el tipo de cama para asignaciones de pacientes mayores de 30 años:



UPDATE camas set tipo="saco de dormir" where camas.camaid in(select asignaciones.camaid from asignaciones 
where asignaciones.camaid = camas.camaid and asignaciones.PacienteID in(select pacientes.pacienteid from pacientes where edad>30));


5. Incrementar la cantidad de camas disponibles en un piso específico en 3 unidades:

UPDATE camas set disponible = true where camaid  like "1__" limit 3;

6. Actualizar la fecha de asignación de las asignaciones de camas individuales a la fecha actual:

UPDATE asignaciones set fechaasignacion ='2024-03-04' where asignaciones.camaid in
(select camas.camaid from camas where tipo="saco de dormir");

7. Modificar el tipo de cama para asignaciones de pacientes femeninas a 'Individual':

UPDATE camas set camas.tipo="INDIVIDUAL" where camas.camaid in(select asignaciones.camaid from asignaciones where asignaciones.pacienteid
in(select pacientes.pacienteid from pacientes where genero="FEMENINO"));


8. Actualizar la fecha de asignación para todas las asignaciones de camas del piso 4:


UPDATE asignaciones set fechaasignacion='2030-01-01' where asignaciones.camaid in 
(select camas.camaid from camas where camas.camaid like "4__");

9. Cambiar el tipo de cama para asignaciones de pacientes con más de 2 asignaciones a 'Individual':
10. Incrementar la cantidad de camas disponibles en un 5%:
11. Actualizar la fecha de asignación para las asignaciones realizadas en camas con más de 1 asignación:
12. Cambiar el tipo de cama para asignaciones de pacientes masculinos mayores de 40 años a 'Individual':
13. Actualizar la fecha de asignación para todas las asignaciones de pacientes con más de 3 asignaciones:
14. Modificar el tipo de cama para asignaciones de pacientes con más de 1 asignación a 'Doble':
15. Actualizar la cantidad máxima de camas permitidas por tipo y piso:


1. Consulta con JOIN y GROUP BY: Obtener la cantidad de asignaciones por tipo de cama.
2. Consulta con Subconsulta correlacionada y Agregación: Mostrar la edad promedio de pacientes con más de 2 asignaciones.
3. Consulta con JOIN y ORDER BY: Listar camas asignadas con detalles de pacientes, ordenadas por fecha de asignación.
4. Consulta con Subconsulta y DISTINCT: Obtener la lista de géneros únicos de pacientes asignados.
5. Consulta con JOIN y SUM: Mostrar la suma total de la cantidad de camas disponibles por piso.
6. Consulta con JOIN, WHERE y ORDER BY: Listar camas asignadas con detalles de pacientes, solo para camas en el piso 3, ordenadas por fecha de asignación.
7. Consulta con JOIN, GROUP BY y HAVING: Obtener la cantidad de asignaciones por paciente, solo para aquellos con más de 3 asignaciones.
8. Consulta con Subconsulta y MAX: Encontrar la fecha más reciente de asignación para cada paciente.
9. Consulta con JOIN, WHERE y COUNT: Contar la cantidad de pacientes asignados en camas de tipo 'Individual' en el piso 2.
10. Consulta con JOIN, GROUP BY, y AVG: Obtener la edad promedio de pacientes asignados por tipo de cama.
11. Consulta con JOIN, ORDER BY y LIMIT: Listar las camas asignadas a pacientes, ordenadas por fecha de asignación, y limitar los resultados a 10.
12. Consulta con JOIN, WHERE y COUNT con Distinción: Contar la cantidad de camas ocupadas por pacientes femeninas mayores de 25 años.
13. Consulta con Subconsulta y MIN: Encontrar la fecha de asignación más antigua para cada cama.
14. Consulta con JOIN, GROUP BY, y Funciones de Ventana: Obtener la lista de pacientes junto con la cantidad total de asignaciones y el número de asignaciones por paciente.
15. Consulta con JOIN, WHERE y Funciones de Ventana: Listar camas asignadas a pacientes junto con el número de asignaciones por paciente, ordenadas por el número de asignaciones en orden descendente.


1. Consulta con Subconsulta y Agregación: Obtener el número total de camas, la cantidad de camas ocupadas y la proporción de ocupación.
 2. Consulta con Subconsulta correlacionada y Agregación: Mostrar la lista de pacientes con la cantidad total de asignaciones.
 3. Consulta con CTE (Common Table Expression) y JOIN: Listar camas junto con la edad promedio de los pacientes asignados.
 4. Consulta con Funciones de Ventana: Obtener la lista de camas con el nombre del paciente más joven y más viejo asignado a cada cama.
5. Consulta con Pivoteo Dinámico: Mostrar la cantidad de camas ocupadas por tipo de cama en una tabla pivote

