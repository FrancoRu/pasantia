DROP PROCEDURE IF EXISTS Get_id_reg;
DELIMITER //
CREATE PROCEDURE Get_id_reg(
	IN in_id_CHD INT,
    IN in_id_reg_tit INT,
    OUT ou_id_reg INT
)
BEGIN
	SELECT R.ID INTO ou_id_reg
    FROM registro R
    WHERE (
		(R.Censo_has_departamento_id_registro = in_id_CHD)
        AND (R.Titulo_cuadro_id_registro = in_id_reg_tit)
    )
    OR (in_id_CHD IS NULL OR in_id_reg_tit IS NULL)
    ORDER BY R.ID DESC LIMIT 1;
END //
DELIMITER ;

/*
-- uso
-- Si ningun parametro es null y el registro se encuentra se devuelve el ID
CALL Get_id_reg(1,1,@ou_temp_id);
SELECT @ou_temp_id;

-- Si ningun parametro es null y el registro no se encuentra se devuelve el ultimo ID 
CALL Get_id_reg(610,1,@ou_temp_id);
SELECT @ou_temp_id;

-- Si algun parametro es null se devuelve el ultimo ID 
CALL Get_id_reg(NULL,1,@ou_temp_id);
SELECT @ou_temp_id;

CALL Get_id_reg(1,NULL,@ou_temp_id);
SELECT @ou_temp_id;

CALL Get_id_reg(NULL,NULL,@ou_temp_id);
SELECT @ou_temp_id;
*/