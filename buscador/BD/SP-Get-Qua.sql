DROP PROCEDURE IF EXISTS getQuadro;

DELIMITER //

CREATE PROCEDURE getQuadro(
	IN censo INT,
    IN department VARCHAR(13),
    IN theme CHAR,
    IN quadro VARCHAR(45)
)
BEGIN
	SELECT R.url_cuadro_xlsx AS XLSX, 
    CONCAT(TC.id_titulo_cuadro, TC.Tematica_id, ' - ', D.nombre_departamento, ' - ', TC.titulo_cuadro_titulo, ' ', EX.descripcion_extension,' - ',C.id_censo_anio,'.') 
		AS Titulo
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
            WHERE
			C.id_censo_anio = IFNULL(censo, C.id_censo_anio) AND
            D.id_departamento = IFNULL(department, D.id_departamento) AND
            T.id_tematica = IFNULL(theme, T.id_tematica) AND
            Cu.id_cuadro = IFNULL(quadro, Cu.id_cuadro)
            ORDER BY D.nombre_departamento, TC.id_titulo_cuadro ASC;
END //
DELIMITER ;
-- CALL getQuadro(2010, '008', 'P' , 6);
