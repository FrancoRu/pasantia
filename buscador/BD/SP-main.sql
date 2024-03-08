
DROP PROCEDURE IF EXISTS insertData;
DELIMITER //
CREATE PROCEDURE insertData (
    IN in_title VARCHAR(255), 
    IN in_censo INT(4), 
    IN in_department VARCHAR(3),
    IN in_quadro VARCHAR(45),
    IN in_theme CHAR,
    IN in_extension INT(1),
    IN in_fraccion INT (1)
)
BEGIN
	DECLARE id_CHD_temp INT;
    DECLARE id_Cu_temp INT;
    DECLARE id_tit_temp INT;
    DECLARE id_tit_MAX_temp INT;
    DECLARE id_reg_tit INT;
    DECLARE ou_id_reg INT;
    DECLARE desc_temp VARCHAR(255);
    DECLARE url VARCHAR(255);
    DECLARE filename VARCHAR(255);
    DECLARE pathname VARCHAR(255);
    START TRANSACTION;
	-- Insert in_censo
    IF NOT EXISTS (SELECT 1 FROM censo WHERE id_censo_anio = in_censo) THEN
        SET desc_temp = CONCAT('censo ', in_censo);
        INSERT INTO censo (id_censo_anio, descripcion_censo) VALUES (in_censo, desc_temp);
    END IF;
    
    -- Insert register between in_censo and in_department
    CALL Get_id_censo_has_departamento(in_department, in_censo , id_CHD_temp);
    IF id_CHD_temp IS NULL THEN
			CALL Get_id_censo_has_departamento(NULL, NULL , id_CHD_temp);
            SET id_CHD_temp = id_CHD_temp + 1;
			INSERT INTO censo_has_departamento (id_censo_has_departamento, Censo_id_censo, Departamento_id_departamento) 
			VALUES (id_CHD_temp, in_censo, in_department);
	END IF;

	-- Insert in_quadro
    CALL Get_id_quadro(in_quadro, id_Cu_temp);
    IF id_Cu_temp IS NULL THEN 
		CALL Get_id_quadro(NULL, id_Cu_temp);
        SET id_Cu_temp = id_Cu_temp + 1; 
        INSERT INTO cuadro (id_cuadro, cuadro_tematica_descripcion) VALUES (id_Cu_temp,in_quadro);
	END IF;
    
    -- Insert register between in_quadro and in_theme
    IF NOT EXISTS (
		SELECT 1 FROM tematica_has_cuadro THC
        INNER JOIN cuadro C
        ON C.id_cuadro = THC.cuadro_id_cuadro
        WHERE C.cuadro_tematica_descripcion = in_quadro
        AND THC.tematica_id_tematica = in_theme
    ) THEN
		INSERT INTO tematica_has_cuadro (cuadro_id_cuadro, tematica_id_tematica) VALUES (id_Cu_temp, in_theme);
    END IF;
    
    -- Insert in_title
    CALL Get_id_title_has_cuadro(in_title, id_Cu_temp, in_theme, id_tit_temp, id_tit_MAX_temp);
    IF id_tit_temp IS NULL THEN
		CALL Get_id_title_has_cuadro(NULL, id_Cu_temp, in_theme, id_tit_temp, id_tit_MAX_temp);
        SET id_tit_temp = id_tit_temp + 1;
        SET id_tit_MAX_temp = id_tit_MAX_temp + 1;
        INSERT INTO titulo_cuadro (ID, id_titulo_cuadro, Cuadro_id, Tematica_id, titulo_cuadro_titulo)
			VALUES (id_tit_temp ,id_tit_MAX_temp, id_Cu_temp ,in_theme, in_title);
    END IF;
     -- Insert register in_title
    CALL Get_id_register_title(id_tit_temp, in_extension, in_fraccion, id_reg_tit);
    IF id_reg_tit IS NULL THEN
		 CALL  Get_id_register_title(NULL, NULL, NULL, id_reg_tit);
         SET id_reg_tit = id_reg_tit + 1;
         INSERT INTO registro_titulos (ID, id_titulo, id_extension, id_acron)
			VALUES (id_reg_tit, id_tit_temp, in_extension, in_fraccion);
    END IF;
    
    -- Insert register between in_censo_has_in_department and register titulo
    CALL Get_id_reg(id_CHD_temp, id_reg_tit ,ou_id_reg);
    SET url = generatorURL(in_department, in_censo, in_fraccion, in_title);
    IF ou_id_reg IS NULL THEN
		CALL Get_id_reg(NULL, NULL ,ou_id_reg);
        SET ou_id_reg = ou_id_reg + 1;
        INSERT INTO registro (ID, Titulo_cuadro_id_registro, Censo_has_departamento_id_registro, url_cuadro_xlsx) 
			VALUES (ou_id_reg, id_reg_tit, id_CHD_temp,url);
    END IF;
    
    IF ou_id_reg IS NULL THEN
		ROLLBACK;
    END IF;
    
    IF ou_id_reg IS NOT NULL THEN
		SELECT SUBSTRING_INDEX(url, '/', -3) AS 'filePath',
			SUBSTRING_INDEX(url, '/', -1) AS 'fileName',
            ou_id_reg AS 'id_reg';
    END IF;
    COMMIT;
END //

DELIMITER ;


-- uso
-- El store procedure si o si necesita que los valores sean distintos a null para funcionar
-- El mismo crea diferentes SF (Store Functions) y SP (Store Procedures) para insertar un cuadro

/*CALL insertData(
	'Prueba con store Procedure',
    2025,
    '008',
    'Caracteristicas Habitacionales',
    'H',
    1,
    1
);*/

