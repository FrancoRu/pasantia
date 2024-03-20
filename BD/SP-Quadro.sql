DROP PROCEDURE IF EXISTS Get_id_quadro;
DELIMITER //
CREATE PROCEDURE Get_id_quadro(
	IN in_desc_quadro VARCHAR(45),
    OUT ou_id_temp INT
)
BEGIN
	SELECT id_cuadro INTO ou_id_temp
    FROM cuadro Cu
    WHERE (Cu.cuadro_tematica_descripcion = in_desc_quadro) 
    OR (in_desc_quadro IS NULL)
    ORDER BY Cu.id_cuadro DESC LIMIT 1;
END //
DELIMITER ;

/*
CALL Get_id_quadro(NULL, @ou_id_temp);
SELECT @ou_id_temp;

CALL Get_id_quadro('Caracteristicas Habitacionales', @ou_id_temp);
SELECT @ou_id_temp;

CALL Get_id_quadro('Caracteristicas Habitacionales 1', @ou_id_temp);
SELECT @ou_id_temp;
*/