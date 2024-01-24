DROP FUNCTION IF EXISTS generatorURL;
DELIMITER //
CREATE FUNCTION generatorURL(
    department VARCHAR(3),
    censo INT,
    fraccion INT,
    title VARCHAR(255)
) RETURNS VARCHAR(255)
BEGIN
    DECLARE dep VARCHAR(255);
    DECLARE cen VARCHAR(255);
    DECLARE acr VARCHAR(255);
    DECLARE tit VARCHAR(255);
    DECLARE url_cuadro VARCHAR(255);

    -- Obtener valores de las tablas
    SET dep = (SELECT nombre_departamento FROM departamento WHERE id_departamento = department);
    SET cen = (SELECT descripcion_censo FROM censo WHERE id_censo_anio = censo);
    SET acr = (SELECT acrónimo FROM acronimo WHERE id = fraccion);
    SET tit = (SELECT CONCAT(TC.id_titulo_cuadro, TC.Tematica_id, '-') AS 'name' 
               FROM titulo_cuadro TC 
               WHERE titulo_cuadro_titulo = title);

    -- Construir la URL
    SET url_cuadro = CONCAT('https://www.dgec.gob.ar/buscador/descargas/', cen, '/', dep, '/', tit, acr, '-', dep, '.xlsx');

    -- Retornar la URL
    RETURN url_cuadro;
END //
DELIMITER ;

-- uso
-- SET @url = generatorURL('008', 2010, 0, 'Hogares por material predominante de los pisos de la vivienda');
-- SELECT @url;