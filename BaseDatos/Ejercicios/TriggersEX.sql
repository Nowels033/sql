DELIMITER //

CREATE TRIGGER antesDeInsertarEmpleado
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    IF NEW.salario < 1000 THEN
        SET NEW.salario = 1000;
    END IF;
END //

DELIMITER ;

-- ----------------------------------------------------


DELIMITER //

CREATE TRIGGER despuesDeInsertarEmpleado
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados (empleado_id, accion, fecha)
    VALUES (NEW.id, 'INSERT', NOW());
END //

DELIMITER ;

-- -----------------------------------------------------------------------


DELIMITER //

CREATE TRIGGER antesDeActualizarEmpleado
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
    IF NEW.salario < OLD.salario THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El salario nuevo no puede ser menor que el salario actual.';
    END IF;
END //

DELIMITER ;


-- --------------------------------------------------------------------------------------


DELIMITER //

CREATE TRIGGER despuesDeActualizarEmpleado
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados (empleado_id, accion, fecha)
    VALUES (NEW.id, 'UPDATE', NOW());
END //

DELIMITER ;
 -- -------------------------------------------------------------------------------------
 
 
 DELIMITER //

CREATE TRIGGER antesDeEliminarEmpleado
BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados (empleado_id, accion, fecha)
    VALUES (OLD.id, 'DELETE', NOW());
END //

DELIMITER ;


 -- --------------------------------------------------------------------------------------------
 
 
 DELIMITER //

CREATE TRIGGER prevenirDuplicados
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    DECLARE cuenta INT;
    SELECT COUNT(*) INTO cuenta FROM empleados WHERE email = NEW.email;
    IF cuenta > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El email ya existe.';
    END IF;
END //

DELIMITER ;
