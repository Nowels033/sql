Consultas multitabla (Composición interna). Resuelva las siguientes consultas sin usar JOIN de tablas.
1.	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.

select empleado.nombre,empleado.id_departamento,departamento.nombre,departamento.presupuesto from empleado,departamento where empleado.id_departamento=departamento.id;

2.	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, 
en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.

select empleado.nombre,empleado.id_departamento,departamento.nombre,departamento.presupuesto from empleado,departamento where empleado.id_departamento=departamento.id 
order by departamento.nombre ,empleado.apellido1,empleado.apellido2,empleado.nombre ;


3.	Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.

select distinct departamento.id , departamento.nombre from empleado,departamento where empleado.id_departamento=departamento.id;

4.	Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone,
 solamente de aquellos departamentos que tienen empleados.
 El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial
 (columna presupuesto) el valor de los gastos que ha generado (columna gastos).
 
 select distinct departamento.id , departamento.nombre,departamento.presupuesto-departamento.gastos as "presupuesto actual del que dispone" from empleado,departamento 
 where empleado.id_departamento=departamento.id;
 
5.	Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.

select departamento.nombre from departamento,empleado where empleado.id_departamento=departamento.id and empleado.nif="38382980M";

6.	Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.

select departamento.nombre from departamento,empleado where empleado.id_departamento=departamento.id 
and empleado.nombre="pepe" and empleado.apellido1="ruiz" and empleado.apellido2="santana";

7.	Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.

select empleado.nif,empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado,departamento where empleado.id_departamento=departamento.id 
and departamento.nombre="I+D" order by empleado.nombre;


8.	Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.

select empleado.nif,empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado,departamento where empleado.id_departamento=departamento.id 
and departamento.nombre="sistemas" and departamento.nombre="contabilidad" or departamento.nombre="I+D" order by empleado.nombre;

9.	Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

select empleado.nombre from empleado,departamento where empleado.id_departamento=departamento.id 
and departamento.presupuesto > 100000 and departamento.presupuesto < 200000;


10.	Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. 
Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.

select distinct departamento.nombre from empleado,departamento where empleado.id_departamento=departamento.id and empleado.apellido2 is null;

11.	Obtener los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

select distinct departamento.nombre from departamento,departamento as dep2 where departamento.id=dep2.id and dep2.presupuesto < 100000 or dep2.presupuesto > 200000; 


12.	Obtener los departamentos donde los gastos son mayores que el presupuesto.

select departamento.nombre from departamento,departamento as dep2 where departamento.id=dep2.id and dep2.gastos > dep2.presupuesto;

13.	Obtener los departamentos donde los gastos son iguales al presupuesto.

select departamento.nombre from departamento,departamento as dep2 where departamento.id=dep2.id and dep2.gastos = dep2.presupuesto;

14.	Obtener todos los datos de los empleados cuyo segundo apellido es NULL.


select empleado.nif,empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado as emp,empleado where emp.id=empleado.id and emp.apellido2 is null;

15.	Obtener todos los datos de los empleados cuyo segundo apellido es Díaz o Moreno.

select distinct empleado.nif,empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado as emp,empleado where emp.id=empleado.id 
and emp.apellido2= "Díaz" or emp.apellido2="Moreno" and empleado.apellido2= "Díaz" or empleado.apellido2="Moreno";


16.	Obtener los nombres de los empleados cuyo segundo apellido es Díaz o Moreno utilizando el operador IN.

select distinct empleado.nif,empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado where empleado.id in
(s;



17.	Obtener los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.

select distinct empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado,departamento where empleado.id_departamento=departamento.id 
and departamento.id = 2 or departamento.id = 4 or departamento.id = 5;

-- comprobar--
select distinct empleado.nombre,empleado.apellido1,empleado.apellido2,departamento.id from empleado,departamento where empleado.id_departamento=departamento.id 
and departamento.id = 2 or departamento.id = 4 or departamento.id = 5;

18.	Obtener el nombre del departamento donde trabaja el empleado con nif 38382980M.

select departamento.nombre from empleado,departamento where empleado.id_departamento=departamento.id and empleado.nif="38382980M";

19.	Obtener el nombre del departamento donde trabaja el empleado "Pepe Ruiz Santana".

select departamento.nombre from departamento,empleado where empleado.id_departamento=departamento.id 
and empleado.nombre="pepe" and empleado.apellido1="ruiz" and empleado.apellido2="santana";

20.	Obtener los datos de los empleados que trabajan en el departamento de I+D ordenados alfabéticamente.

select empleado.nif,empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado,departamento where empleado.id_departamento=departamento.id 
and departamento.nombre="I+D" order by empleado.nombre;


Consultas multitabla (Composición externa). Resuelva las siguientes consultas utilizando las cláusulas JOIN.
1.	Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

select empleado.nombre,empleado.apellido1,empleado.apellido2,departamento.nombre,departamento.presupuesto from empleado left join departamento 
on empleado.id_departamento=departamento.id ;

2.	Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.

select empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado left join departamento 
on empleado.id_departamento=departamento.id where departamento.nombre is null ;


3.	Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.

select departamento.nombre from empleado right join departamento 
on empleado.id_departamento=departamento.id where empleado.nombre is null;



4.	Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado.
 Ordene el listado alfabéticamente por el nombre del departamento.
 
 select empleado.nombre ,departamento.nombre from empleado left join departamento 
on empleado.id_departamento=departamento.id
union 
 select empleado.nombre ,departamento.nombre from empleado right join departamento 
on empleado.id_departamento=departamento.id ;

revisar

5.	Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado.
 Ordene el listado alfabéticamente por el nombre del departamento.
 
 select empleado.nombre ,departamento.nombre from empleado left join departamento 
on empleado.id_departamento = departamento.id where departamento.nombre is null
union
select empleado.nombre ,departamento.nombre from empleado right join departamento 
on empleado.id_departamento=departamento.id where empleado.nombre is null ;

 revisar
 
6. 	Consulta para obtener un listado con los empleados y los datos de los departamentos donde trabajan cada uno.

select empleado.nombre , empleado.apellido1,empleado.apellido2, departamento.id,departamento.nombre,departamento.presupuesto from empleado 
join departamento on empleado.id_departamento=departamento.id;

7.	Consulta para obtener un listado con los empleados y los datos de los departamentos donde trabajan cada uno.
 Ordena el resultado alfabéticamente por el nombre del departamento y por los apellidos y el nombre de los empleados.
 
 select empleado.nombre , empleado.apellido1,empleado.apellido2, departamento.id,departamento.nombre,departamento.presupuesto from empleado 
join departamento on empleado.id_departamento=departamento.id order by departamento.nombre,empleado.apellido1,empleado.apellido2,empleado.nombre;
 
8.	Consulta para obtener un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.

select distinct departamento.id,departamento.nombre from departamento join empleado on empleado.id_departamento=departamento.id;

9.	Consulta para obtener un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, 
solamente de aquellos departamentos que tienen empleados.

select distinct departamento.id,departamento.nombre,departamento.presupuesto-departamento.gastos from departamento 
join empleado on empleado.id_departamento=departamento.id;

10.	Consulta para obtener el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.

select departamento.nombre from departamento join empleado on empleado.id_departamento=departamento.id where empleado.nif ="38382980M";


11.	Consulta para obtener el nombre del departamento donde trabaja el empleado "Pepe Ruiz Santana".

select departamento.nombre from departamento join empleado on empleado.id_departamento=departamento.id where empleado.nombre="pepe" and empleado.apellido1="ruiz"
and empleado.apellido2="santana";

12. Consulta para obtener un listado con los datos de los empleados que trabajan en el departamento de I+D. 
Ordena el resultado alfabéticamente por nombre, apellido1 y apellido2.

select empleado.nombre,empleado.apellido1,empleado.apellido2,empleado.nif from empleado join departamento 
on empleado.id_departamento=departamento.id where departamento.nombre="I+D" order by empleado.nombre,empleado.apellido1,empleado.apellido2;

13.	Consulta para obtener un listado con los datos de los empleados que trabajan en los departamentos de Sistemas, Contabilidad o I+D.
 Ordena el resultado alfabéticamente por nombre, apellido1 y apellido2.
 
 select empleado.nombre,empleado.apellido1,empleado.apellido2,empleado.nif from empleado join departamento 
on empleado.id_departamento=departamento.id where departamento.nombre="SISTEMAS" or departamento.nombre="Contabilidad" or departamento.nombre="I+D" 
order by empleado.nombre,empleado.apellido1,empleado.apellido2;
 
14.	Consulta para obtener una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

select empleado.nombre,empleado.apellido1,empleado.apellido2,empleado.nif from empleado join departamento 
on empleado.id_departamento=departamento.id where departamento.presupuesto < 100000 or departamento.presupuesto > 200000;

15.	Consulta para obtener un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. 
Ten en cuenta que no se deben mostrar nombres de departamentos que estén repetidos.

select distinct departamento.nombre from departamento join empleado on empleado.id_departamento=departamento.id where empleado.apellido2 is null;





Updates con condición: Resolver los siguientes updates utilizando en todos ellos consultas multitablas (subconsultas select y/o Join) 
1.	Actualizar el presupuesto de todos los departamentos duplicando el presupuesto actual si los gastos superan los 20000 euros.


update departamento set presupuesto=presupuesto * 2 where departamento.id in(select departamento.id from departamento where departamento.id
 in (select departamento.id from departamento where gastos > 20000 ) ) ;


2.	Cambiar el segundo apellido de los empleados en el departamento de 'Recursos Humanos' a 'Rodríguez' si actualmente es NULL.

update empleado set apellido2="Rodriguez" where empleado.id_departamento in(select departamento.id from departamento where departamento.nombre="recursos humanos"
and empleado.apellido2 is null);

-- comprobacion --
select empleado.apellido2,departamento.nombre from empleado join departamento on empleado.id_departamento=departamento.id;

3.	Asignar el departamento con id 2 a los empleados cuyo apellido1 sea 'Salas' y el nombre del departamento actual sea distinto de 'Sistemas'.

update empleado set id_departamento=2 where empleado.id_departamento in(select departamento.id from departamento
 where departamento.nombre != "Sistemas" and empleado.apellido1="Salas");

4. 	Asignar el departamento con id 4 a los empleados que actualmente trabajan en el departamento de 'Desarrollo' y tienen más de 3 años de antigüedad.

update empleado set id_departamento=4 where empleado.id_departamento in(select departamento.id from departamento
 where departamento.nombre = "Desarrollo" and empleado.fecha_contratacion <= '2021/03/14');

5.	Cambiar el presupuesto de los departamentos que tienen más de 10 empleados asignados, reduciéndolo en un 10%.

update departamento set presupuesto = presupuesto -(presupuesto*10/100)  where departamento.id =(select departamento.id from departamento join 
empleado on empleado.id_departamento = departamento.id group by departamento.id having count(empleado.id)>10);


select departamento.id from departamento join 
empleado on empleado.id_departamento = departamento.id group by departamento.id having count(empleado.id)>10;

select departamento.id from departamento join empleado on empleado.id_departamento = departamento.id group by departamento.id having count(empleado.id)>2;

6.	Incrementar el presupuesto en un 8% para los departamentos donde el promedio de gastos por empleado sea mayor a 15000 euros.

update departamento set presupuesto = presupuesto +(presupuesto*8/100)  where departamento.id =(select departamento.id from departamento 
where 
