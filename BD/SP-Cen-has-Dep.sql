DROP PROCEDURE IF EXISTS Get_id_censo_has_departamento;
DELIMITER //
CREATE PROCEDURE Get_id_censo_has_departamento(
IN in_department VARCHAR(3), 
IN in_censo INT(4), 
OUT ou_id_temp INT
)
BEGIN
	SELECT CHD.id_censo_has_departamento 
    INTO ou_id_temp 
    FROM censo_has_departamento CHD 
    WHERE (CHD.censo_id_censo = in_censo
    AND CHD.Departamento_id_departamento = in_department)
    OR (in_censo IS NULL OR in_department IS NULL)
    ORDER BY CHD.id_censo_has_departamento DESC LIMIT 1;
END //
DELIMITER ;

/*
-- Uso
-- Si 1 o ambos parametros de entrada son NULL el resultado es el ultimo registro
CALL Get_id_censo_has_departamento(NULL, NULL , @ou_id_temp);
SELECT @ou_id_temp;

CALL Get_id_censo_has_departamento(NULL, 2010 , @ou_id_temp);
SELECT @ou_id_temp;

CALL Get_id_censo_has_departamento('008', NULL , @ou_id_temp);
SELECT @ou_id_temp;

-- Si el registro se encuentra devuelve su indice

CALL Get_id_censo_has_departamento('008', 2010, @ou_id_temp);
SELECT @ou_id_temp;

-- Si el registro no se encuentra devuelve null
CALL Get_id_censo_has_departamento('084', 2022 , @ou_id_temp);
SELECT @ou_id_temp;
*/

