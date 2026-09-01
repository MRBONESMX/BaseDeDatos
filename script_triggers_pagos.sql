select * from pagos;

/* =========================================================
   1. TRIGGER - VALIDAR CUPO DEL GRUPO
   ========================================================= */

CREATE OR REPLACE FUNCTION validar_cupo_grupo()
RETURNS TRIGGER
AS $$
DECLARE
    total_inscritos INT;
    limite_grupo INT;
BEGIN

    SELECT COUNT(*)
    INTO total_inscritos
    FROM inscripciones
    WHERE id_grupo = NEW.id_grupo
      AND estado = 'INSCRITO';


    SELECT cupo_maximo
    INTO limite_grupo
    FROM grupos
    WHERE id_grupo = NEW.id_grupo;


    IF total_inscritos >= limite_grupo THEN
        RAISE EXCEPTION
        'No se puede realizar la inscripción. El grupo está lleno.';
    END IF;


    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_validar_cupo_grupo
BEFORE INSERT
ON inscripciones
FOR EACH ROW
EXECUTE FUNCTION validar_cupo_grupo();

/* =========================================================
   PRUEBA DEL TRIGGER
   ========================================================= */

SELECT
    g.id_grupo,
    m.nombre AS materia,
    g.grupo,
    g.cupo_maximo,
    COUNT(i.id_inscripcion) AS alumnos_inscritos
FROM grupos g
INNER JOIN materias m
    ON g.id_materia = m.id_materia
LEFT JOIN inscripciones i
    ON g.id_grupo = i.id_grupo
    AND i.estado = 'INSCRITO'
GROUP BY
    g.id_grupo,
    m.nombre,
    g.grupo,
    g.cupo_maximo
ORDER BY g.id_grupo;

create or replace function validar_monto_pago()
returns trigger 
as $$
declare
	monto_pagado INT;
begin
	select new.monto 
	into monto_pagado;
	
	if monto_pagado >= 20000 then
		raise exception
		'El monto supera el limite permitido.';
	end if;
		
	return new;
	
end;
$$ LANGUAGE plpgsql;

create or replace trigger trg_validar_monto_pago
before insert 
on pagos
for each row
execute function validar_monto_pago();

select * from pagos;
INSERT INTO pagos (id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia) 
VALUES 
(8, 2, 'Inscripción', 21000.00, 'Tarjeta', 'REF001');
