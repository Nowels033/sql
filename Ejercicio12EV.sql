
select fabricante.nombre ,count(*) from fabricante join producto on fabricante.id=producto.id_fabricante 
group by fabricante.nombre having count(*) =
(select count(*) from producto where id_fabricante =
(select id from fabricante where nombre = "lenovo"));

select * from producto;

8. Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.

select nombre,precio from producto where precio >= all 
(select precio from producto);

9. Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.

select nombre,precio from producto where precio <= all 
(select precio from producto);

10. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).

select fabricante.nombre, count(*) from fabricante join producto on fabricante.id=producto.id_fabricante 
group by fabricante.nombre

select nombre from fabricante where id => all
(select id_fabricante from producto where id_fabricante >= 1 )group by nombre having ;


SELECT    nombre
FROM fabricante 
WHERE id >= any (SELECT id_fabricante FROM producto WHERE id_fabricante IS NOT NULL);
  AND nombre IS NOT NULL;
  
  select * from producto;

11. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).

SELECT distinct nombre,id
FROM fabricante 
WHERE id = is null  (select id_fabricante FROM producto WHERE id_fabricante  is NULL);


SELECT DISTINCT nombre
FROM fabricante
WHERE id = any (SELECT id_fabricante FROM producto WHERE id_fabricante IS NOT NULL);

select nombre , id from fabricante;

Subconsultas con IN y NOT IN
12. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).

select nombre from fabricante where id in (select id_fabricante from producto where id_fabricante is not null);

13. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).

select nombre from fabricante where id not in (select id_fabricante from producto where id_fabricante is not null);

Subconsultas con EXISTS y NOT EXISTS
14. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).

select nombre from fabricante as f where exists (select id_fabricante from producto where f.id =id_fabricante );

15. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).

select nombre from fabricante as f where not exists (select id_fabricante from producto where f.id =id_fabricante );


Subconsultas correlacionadas
16. Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.

select fabricante.nombre , producto.nombre,producto.precio from fabricante join producto
on fabricante.id = producto.id_fabricante  where producto.precio = max(precio) group by fabricante.nombre;
(select nombre ,max(precio)from producto group by nombre) group by fabricante.nombre  ;

-- la buena--
SELECT f.nombre,p.nombre,p.precio as k FROM fabricante as f JOIN
    producto as  p ON f.id = p.id_fabricante
WHERE 
    p.precio = (SELECT MAX(precio) FROM producto where f.id =  id_fabricante);        (select id from fabricante));; 
    
    group by nombre); WHERE id_fabricante = f.id);

where id_fabricante=(select id from fabricante) 


17. Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de
su mismo fabricante.
-- buena --
select p.nombre , precio ,f.nombre from producto as p join fabricante as f on p.id_fabricante=f.id where precio >= 
(select avg(precio) from producto where id_fabricante = f.id);

select f.nombre,avg(precio) from producto as p join fabricante as f on p.id_fabricante = f.id group by f.nombre;



18. Lista el nombre del producto más caro del fabricante Lenovo.

select nombre from producto where precio = 
(select max(precio) from producto where id_fabricante = 
(select id from fabricante where nombre = "lenovo"));