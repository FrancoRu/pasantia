DROP PROCEDURE IF EXISTS Get_id_title_has_cuadro;
DELIMITER //
CREATE PROCEDURE Get_id_title_has_cuadro(
	IN in_title VARCHAR(255),
	IN in_id_quadro INT,
    IN in_id_theme CHAR,
    OUT ou_id_title_temp INT,
    OUT ou_id_title_Qu INT
)
BEGIN
	SELECT TC.ID INTO ou_id_title_temp
    FROM titulo_cuadro TC
    WHERE (TC.titulo_cuadro_titulo = in_title 
    AND TC.Cuadro_id = in_id_quadro AND TC.Tematica_id = in_id_theme)
    OR (in_title IS NULL)
    ORDER BY TC.ID DESC LIMIT 1;
    
    IF in_title IS NULL THEN
		SELECT TC.id_titulo_cuadro INTO ou_id_title_Qu
		FROM titulo_cuadro TC
		WHERE TC.Tematica_id = in_id_theme
		ORDER BY TC.id_titulo_cuadro DESC LIMIT 1;
    END IF;
    
END //
DELIMITER ;

/*
-- Uso
-- Si titulo no es null y se encuentra se devuelve su ID
CALL Get_id_title_has_cuadro('Hogares por material predominante de los pisos de la vivienda', 1, 'H', @ou_id_title, @ou_id_max);
SELECT @ou_id_title, @ou_id_max;

-- Si titulo no es null pero no se encuentra devuelve null
CALL Get_id_title_has_cuadro('Hogares por material predominante de los pisos de la vivienda', 1, 'V', @ou_id_title, @ou_id_max);
SELECT @ou_id_title, @ou_id_max;

-- Si titulo es null devuelve el ultimo ID del titulo ingresado y el maximo ID del cuadro
CALL Get_id_title_has_cuadro(NULL, 1, 'V', @ou_id_title, @ou_id_max);
SELECT @ou_id_title, @ou_id_max;
*/

