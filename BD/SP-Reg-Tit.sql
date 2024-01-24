DROP PROCEDURE IF EXISTS Get_id_register_title;
DELIMITER //
CREATE PROCEDURE Get_id_register_title(
	IN in_id_title INT,
    IN in_id_extension INT,
    IN in_id_fraccion INT,
    OUT ou_id_temp INT
)
BEGIN
	SELECT RT.ID INTO ou_id_temp
    FROM registro_titulos RT
    WHERE 
		(RT.id_titulo = in_id_title
	AND RT.id_extension = in_id_extension
    AND RT.id_acron = in_id_fraccion)
     OR (in_id_title IS NULL OR in_id_extension IS NULL OR in_id_fraccion IS NULL)
    ORDER BY RT.ID DESC LIMIT 1;
END //
DELIMITER ;

/*
-- uso
-- Si ninguno de los parametros es null y se encuentra el registro se devuelve el ID
CALL Get_id_register_title(1,1,0, @ou_temp_id);
SELECT @ou_temp_id;

-- Si ninguno de los parametros es null y no se encuentra el registro se devuelve el ultimo ID
CALL Get_id_register_title(43,1,0, @ou_temp_id);
SELECT @ou_temp_id;

-- Si alguno de los parametros es null se devuelve el ultimo ID
CALL Get_id_register_title(NULL,1,0, @ou_temp_id);
SELECT @ou_temp_id;

CALL Get_id_register_title(NULL,NULL,0, @ou_temp_id);
SELECT @ou_temp_id;

CALL Get_id_register_title(NULL,NULL,NULL, @ou_temp_id);
SELECT @ou_temp_id;

CALL Get_id_register_title(1,NULL,NULL, @ou_temp_id);
SELECT @ou_temp_id;

CALL Get_id_register_title(1,0,NULL, @ou_temp_id);
SELECT @ou_temp_id;

CALL Get_id_register_title(NULL,0,NULL, @ou_temp_id);
SELECT @ou_temp_id;
*/