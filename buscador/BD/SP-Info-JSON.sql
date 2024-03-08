DROP PROCEDURE IF EXISTS getInfoJSON;

DELIMITER //

CREATE PROCEDURE getInfoJSON()
BEGIN
	SELECT DISTINCT
        C.id_censo_anio, C.descripcion_censo,
        D.nombre_departamento, D.id_departamento 
        , T.tematica_descripcion, T.id_tematica , 
        Cu.cuadro_tematica_descripcion, Cu.id_cuadro
                FROM registro R
                INNER JOIN censo_has_departamento CD
                ON CD.id_censo_has_departamento =  R.Censo_has_departamento_id_registro
                INNER JOIN censo C
                ON CD.Censo_id_censo = C.id_censo_anio 
                INNER JOIN departamento D 
                ON D.id_departamento = CD.Departamento_id_departamento
                INNER JOIN registro_titulos RT
            ON RT.ID = R.Titulo_cuadro_id_registro
            INNER JOIN extension EX
            ON EX.id_extension = RT.id_extension
            INNER JOIN acronimo AC
            ON AC.id = RT.id_acron
            INNER JOIN titulo_cuadro TC
            ON TC.ID = RT.id_titulo
            INNER JOIN cuadro Cu
            ON Cu.id_cuadro = TC.Cuadro_id
            INNER JOIN tematica T
            ON T.id_tematica = TC.Tematica_id
                ORDER BY C.id_censo_anio ASC,
                D.nombre_departamento ASC, 
                T.tematica_descripcion ASC, 
                Cu.cuadro_tematica_descripcion ASC;
END //
DELIMITER ;

-- CALL getInfoJSON();