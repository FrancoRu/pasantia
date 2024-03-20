-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 19, 2024 at 03:19 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lab`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getData` (OUT `out_dep` JSON, OUT `out_ext` JSON)   BEGIN
	SET out_dep = (
        SELECT JSON_OBJECT('department', 
            CONCAT('[', GROUP_CONCAT(
                JSON_OBJECT('id', id, 'description', description)
            ), ']')
        ) AS resultado
        FROM department
    );
    
	SET out_ext = (
        SELECT JSON_OBJECT('extension', 
            CONCAT('[', GROUP_CONCAT(
                JSON_OBJECT('id', id, 'description', description)
            ), ']')
        ) AS resultado
        FROM extension
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getInfoJSON` ()   BEGIN
	SELECT DISTINCT
        C.id, C.description,
        D.description, D.id 
        , T.description, T.id , 
        Cu.description, Cu.id
                FROM register R
                INNER JOIN census_has_department CD
                ON CD.id =  R.census_has_department_id_register
                INNER JOIN census C
                ON CD.Census_id = C.id 
                INNER JOIN department D 
                ON D.id = CD.Department_id
                INNER JOIN register_titles RT
            ON RT.id = R.Title_id_table_register
            INNER JOIN extension EX
            ON EX.id = RT.id_extension
            INNER JOIN acronym AC
            ON AC.id = RT.id_acron
            INNER JOIN title_table TC
            ON TC.id = RT.id_title
            INNER JOIN `table` Cu
            ON Cu.id = TC.id_table
            INNER JOIN theme T
            ON T.id = TC.theme_id
                ORDER BY C.id ASC,
                D.description ASC, 
                T.description ASC, 
                Cu.description ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getQuadro` (IN `census` INT, IN `department` VARCHAR(13), IN `theme` CHAR, IN `quadro` VARCHAR(45))   BEGIN
	SELECT R.url_table_xlsx AS XLSX, 
    CONCAT(TC.id_title_table, TC.theme_id, ' - ', D.description, ' - ', TC.title_table_titulo, ' ', EX.description,' - ',C.id,'.') 
		AS Titulo
        FROM register R
                INNER JOIN census_has_department CD
                ON CD.id =  R.census_has_department_id_register
                INNER JOIN census C
                ON CD.Census_id = C.id 
                INNER JOIN department D 
                ON D.id = CD.Department_id
                INNER JOIN register_titles RT
            ON RT.id = R.Title_id_table_register
            INNER JOIN extension EX
            ON EX.id = RT.id_extension
            INNER JOIN acronym AC
            ON AC.id = RT.id_acron
            INNER JOIN title_table TC
            ON TC.id = RT.id_title
            INNER JOIN `table` Cu
            ON Cu.id = TC.id_table
            INNER JOIN theme T
            ON T.id = TC.theme_id
            WHERE
			C.id = IFNULL(census, C.id) AND
            D.id = IFNULL(department, D.id) AND
            T.id = IFNULL(theme, T.id) AND
            Cu.id = IFNULL(quadro, Cu.id)
            ORDER BY D.description, TC.id_title_table ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_id` (IN `in_department` VARCHAR(3), IN `in_census` INT(4), OUT `ou_id_temp` INT)   BEGIN
	SELECT CHD.id 
    INTO ou_id_temp 
    FROM census_has_department CHD 
    WHERE (CHD.Census_id = in_census
    AND CHD.Department_id = in_department)
    OR (in_census IS NULL OR in_department IS NULL)
    ORDER BY CHD.id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_id_quadro` (IN `in_desc_quadro` VARCHAR(45), OUT `ou_id_temp` INT)   BEGIN
	SELECT id INTO ou_id_temp
    FROM `table`
    WHERE (Cu.description = in_desc_quadro) 
    OR (in_desc_quadro IS NULL)
    ORDER BY Cu.id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_id_reg` (IN `in_id_CHD` INT, IN `in_id_reg_tit` INT, OUT `ou_id_reg` INT)   BEGIN
	SELECT R.id INTO ou_id_reg
    FROM register R
    WHERE (
		(R.census_has_department_id_register = in_id_CHD)
        AND (R.Title_id_table_register = in_id_reg_tit)
    )
    OR (in_id_CHD IS NULL OR in_id_reg_tit IS NULL)
    ORDER BY R.id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_id_register_title` (IN `in_id_title` INT, IN `in_id` INT, IN `in_id_fraccion` INT, OUT `ou_id_temp` INT)   BEGIN
	SELECT RT.id INTO ou_id_temp
    FROM register_titles RT
    WHERE 
		(RT.id_title = in_id_title
	AND RT.id = in_id
    AND RT.id_acron = in_id_fraccion)
     OR (in_id_title IS NULL OR in_id IS NULL OR in_id_fraccion IS NULL)
    ORDER BY RT.id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_id_title_has_table` (IN `in_title` VARCHAR(255), IN `in_id_quadro` INT, IN `in_id` CHAR, OUT `ou_id_title_temp` INT, OUT `ou_id_title_Qu` INT)   BEGIN
	SELECT TC.id INTO ou_id_title_temp
    FROM title_table TC
    WHERE (TC.title_table_titulo = in_title 
    AND TC.id_table = in_id_quadro AND TC.theme_id = in_id)
    OR (in_title IS NULL)
    ORDER BY TC.id DESC LIMIT 1;
    
    IF in_title IS NULL THEN
		SELECT TC.id_title_table INTO ou_id_title_Qu
		FROM title_table TC
		WHERE TC.theme_id = in_id
		ORDER BY TC.id_title_table DESC LIMIT 1;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertData` (IN `in_title` VARCHAR(255), IN `in_census` INT(4), IN `in_department` VARCHAR(3), IN `in_quadro` VARCHAR(45), IN `in_theme` CHAR, IN `in_extension` INT(1), IN `in_fraccion` INT(1))   BEGIN
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
	-- Insert in_census
    IF NOT EXISTS (SELECT 1 FROM census WHERE id = in_census) THEN
        SET desc_temp = CONCAT('census ', in_census);
        INSERT INTO census (id, description) VALUES (in_census, desc_temp);
    END IF;
    
    -- Insert register between in_census and in_department
    CALL Get_id(in_department, in_census , id_CHD_temp);
    IF id_CHD_temp IS NULL THEN
			CALL Get_id(NULL, NULL , id_CHD_temp);
            SET id_CHD_temp = id_CHD_temp + 1;
			INSERT INTO census_has_department (id, Census_id, Department_id) 
			VALUES (id_CHD_temp, in_census, in_department);
	END IF;

	-- Insert in_quadro
    CALL Get_id_quadro(in_quadro, id_Cu_temp);
    IF id_Cu_temp IS NULL THEN 
		CALL Get_id_quadro(NULL, id_Cu_temp);
        SET id_Cu_temp = id_Cu_temp + 1; 
        INSERT INTO `table` (id, description) VALUES (id_Cu_temp,in_quadro);
	END IF;
    
    -- Insert register between in_quadro and in_theme
    IF NOT EXISTS (
		SELECT 1 FROM theme_has_table THC
        INNER JOIN `table` C
        ON C.id = THC.id_table
        WHERE C.description = in_quadro
        AND THC.theme_id = in_theme
    ) THEN
		INSERT INTO theme_has_table (id_table, theme_id) VALUES (id_Cu_temp, in_theme);
    END IF;
    
    -- Insert in_title
    CALL Get_id_title_has_table(in_title, id_Cu_temp, in_theme, id_tit_temp, id_tit_MAX_temp);
    IF id_tit_temp IS NULL THEN
		CALL Get_id_title_has_table(NULL, id_Cu_temp, in_theme, id_tit_temp, id_tit_MAX_temp);
        SET id_tit_temp = id_tit_temp + 1;
        SET id_tit_MAX_temp = id_tit_MAX_temp + 1;
        INSERT INTO title_table (id, id_title_table, id_table, theme_id, title_table_titulo)
			VALUES (id_tit_temp ,id_tit_MAX_temp, id_Cu_temp ,in_theme, in_title);
    END IF;
     -- Insert register in_title
    CALL Get_id_register_title(id_tit_temp, in_extension, in_fraccion, id_reg_tit);
    IF id_reg_tit IS NULL THEN
		 CALL  Get_id_register_title(NULL, NULL, NULL, id_reg_tit);
         SET id_reg_tit = id_reg_tit + 1;
         INSERT INTO register_titles (id, id_title, id, id_acron)
			VALUES (id_reg_tit, id_tit_temp, in_extension, in_fraccion);
    END IF;
    
    -- Insert register between in_census_has_in_department and register titulo
    CALL Get_id_reg(id_CHD_temp, id_reg_tit ,ou_id_reg);
    SET url = generatorURL(in_department, in_census, in_fraccion, in_title);
    IF ou_id_reg IS NULL THEN
		CALL Get_id_reg(NULL, NULL ,ou_id_reg);
        SET ou_id_reg = ou_id_reg + 1;
        INSERT INTO register (id, Title_id_table_register, census_has_department_id_register, url_table_xlsx) 
			VALUES (ou_id_reg, id_reg_tit, id_CHD_temp,url);
    END IF;
    
    IF ou_id_reg IS NULL THEN
		ROLLBACK;
    END IF;
    
    /*IF ou_id_reg IS NOT NULL THEN
		SET ou_reg_name = SUBSTRING_INDEX(url, '/', -3);
		SET ou_reg_path = SUBSTRING_INDEX(url, '/', -1);
    END IF;*/
    
    IF ou_id_reg IS NOT NULL THEN
		SELECT SUBSTRING_INDEX(url, '/', -3) AS 'filePath',
			SUBSTRING_INDEX(url, '/', -1) AS 'fileName',
            ou_id_reg AS 'id_reg';
    END IF;
    COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proof` ()   BEGIN
    DECLARE id_temp INT;

    -- Llamada al procedimiento almacenado
    CALL Get_id('008', 2010, id_temp);

    -- Muestra el valor de la variable
    SELECT id_temp;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `generatorURL` (`department` VARCHAR(3), `census` INT, `fraccion` INT, `title` VARCHAR(255)) RETURNS VARCHAR(255) CHARSET utf8 COLLATE utf8_general_ci  BEGIN
    DECLARE dep VARCHAR(255);
    DECLARE cen VARCHAR(255);
    DECLARE acr VARCHAR(255);
    DECLARE tit VARCHAR(255);
    DECLARE url_table VARCHAR(255);

    -- Obtener valores de las tablas
    SET dep = (SELECT description FROM department WHERE id = department);
    SET cen = (SELECT description FROM census WHERE id = census);
    SET acr = (SELECT acronym FROM acronym WHERE id = fraccion);
    SET tit = (SELECT CONCAT(TC.id_title_table, TC.theme_id, '-') AS 'name' 
               FROM title_table TC 
               WHERE title_table_titulo = title);

    -- Construir la URL
    SET url_table = CONCAT('https://www.dgec.gob.ar/buscador/descargas/', cen, '/', dep, '/', tit, acr, '-', dep, '.xlsx');

    -- Retornar la URL
    RETURN url_table;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `acronym`
--

CREATE TABLE `acronym` (
  `id` int(1) NOT NULL,
  `description` varchar(255) NOT NULL,
  `acronym` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `acronym`
--

INSERT INTO `acronym` (`id`, `description`, `acronym`) VALUES
(0, 'Fracción', 'FR'),
(1, 'Provincial', 'PR');

-- --------------------------------------------------------

--
-- Table structure for table `census`
--

CREATE TABLE `census` (
  `id` int(4) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `census`
--

INSERT INTO `census` (`id`, `description`) VALUES
(2010, 'Censo 2010');

-- --------------------------------------------------------

--
-- Table structure for table `census_has_department`
--

CREATE TABLE `census_has_department` (
  `id` int(4) NOT NULL,
  `Census_id` int(4) NOT NULL,
  `Department_id` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `census_has_department`
--

INSERT INTO `census_has_department` (`id`, `Census_id`, `Department_id`) VALUES
(1, 2010, '008'),
(2, 2010, '015'),
(3, 2010, '021'),
(4, 2010, '028'),
(5, 2010, '035'),
(6, 2010, '042'),
(7, 2010, '049'),
(8, 2010, '056'),
(9, 2010, '063'),
(10, 2010, '070'),
(11, 2010, '077'),
(12, 2010, '084'),
(13, 2010, '088'),
(14, 2010, '091'),
(15, 2010, '098'),
(16, 2010, '105'),
(17, 2010, '113');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` varchar(3) NOT NULL,
  `description` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `description`) VALUES
('008', 'Colón'),
('015', 'Concordia'),
('021', 'Diamante'),
('028', 'Federación'),
('035', 'Federal'),
('042', 'Feliciano'),
('049', 'Gualeguay'),
('056', 'Gualeguaychú'),
('063', 'Islas'),
('070', 'La Paz'),
('077', 'Nogoyá'),
('084', 'Paraná'),
('088', 'San Salvador'),
('091', 'Tala'),
('098', 'Concepción del Uruguay'),
('105', 'Victoria'),
('113', 'Villaguay');

-- --------------------------------------------------------

--
-- Table structure for table `extension`
--

CREATE TABLE `extension` (
  `id` int(1) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `extension`
--

INSERT INTO `extension` (`id`, `description`) VALUES
(1, 'por área de gobierno local, fracción y radio censal'),
(2, 'por department');

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `id` int(11) NOT NULL,
  `Title_id_table_register` int(4) DEFAULT NULL,
  `census_has_department_id_register` int(4) DEFAULT NULL,
  `url_table_xlsx` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`id`, `Title_id_table_register`, `census_has_department_id_register`, `url_table_xlsx`) VALUES
(1, 1, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/1H-FR-Colón.xlsx'),
(2, 2, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/2H-FR-Colón.xlsx'),
(3, 3, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/3H-FR-Colón.xlsx'),
(4, 4, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/4H-FR-Colón.xlsx'),
(5, 5, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/5H-FR-Colón.xlsx'),
(6, 6, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/6H-FR-Colón.xlsx'),
(7, 7, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/7H-FR-Colón.xlsx'),
(8, 8, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/9H-FR-Colón.xlsx'),
(9, 9, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/11H-FR-Colón.xlsx'),
(10, 10, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/12H-FR-Colón.xlsx'),
(11, 11, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/13H-FR-Colón.xlsx'),
(12, 12, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/8H-FR-Colón.xlsx'),
(13, 13, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/15H-FR-Colón.xlsx'),
(14, 14, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/16H-FR-Colón.xlsx'),
(15, 15, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/17H-FR-Colón.xlsx'),
(16, 16, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/18H-FR-Colón.xlsx'),
(17, 17, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/10H-FR-Colón.xlsx'),
(18, 18, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/6P-FR-Colón.xlsx'),
(19, 19, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/5P-FR-Colón.xlsx'),
(20, 20, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/7P-FR-Colón.xlsx'),
(21, 21, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/8P-FR-Colón.xlsx'),
(22, 22, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/9P-FR-Colón.xlsx'),
(23, 23, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/10P-FR-Colón.xlsx'),
(24, 24, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/1P-FR-Colón.xlsx'),
(25, 25, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/3P-FR-Colón.xlsx'),
(26, 26, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/4P-FR-Colón.xlsx'),
(27, 27, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/2P-FR-Colón.xlsx'),
(28, 28, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/11P-FR-Colón.xlsx'),
(29, 29, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/2V-FR-Colón.xlsx'),
(30, 30, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/4V-FR-Colón.xlsx'),
(31, 31, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/5V-FR-Colón.xlsx'),
(32, 32, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/6V-FR-Colón.xlsx'),
(33, 33, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/1V-FR-Colón.xlsx'),
(34, 34, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/3V-FR-Colón.xlsx'),
(35, 35, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Colón/7V-FR-Colón.xlsx'),
(36, 1, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/1H-FR-Concordia.xlsx'),
(37, 2, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/2H-FR-Concordia.xlsx'),
(38, 3, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/3H-FR-Concordia.xlsx'),
(39, 4, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/4H-FR-Concordia.xlsx'),
(40, 5, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/5H-FR-Concordia.xlsx'),
(41, 6, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/6H-FR-Concordia.xlsx'),
(42, 7, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/7H-FR-Concordia.xlsx'),
(43, 8, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/9H-FR-Concordia.xlsx'),
(44, 9, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/11H-FR-Concordia.xlsx'),
(45, 10, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/12H-FR-Concordia.xlsx'),
(46, 11, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/13H-FR-Concordia.xlsx'),
(47, 12, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/8H-FR-Concordia.xlsx'),
(48, 13, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/15H-FR-Concordia.xlsx'),
(49, 14, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/16H-FR-Concordia.xlsx'),
(50, 15, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/17H-FR-Concordia.xlsx'),
(51, 16, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/18H-FR-Concordia.xlsx'),
(52, 17, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/10H-FR-Concordia.xlsx'),
(53, 18, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/6P-FR-Concordia.xlsx'),
(54, 19, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/5P-FR-Concordia.xlsx'),
(55, 20, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/7P-FR-Concordia.xlsx'),
(56, 21, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/8P-FR-Concordia.xlsx'),
(57, 22, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/9P-FR-Concordia.xlsx'),
(58, 23, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/10P-FR-Concordia.xlsx'),
(59, 24, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/1P-FR-Concordia.xlsx'),
(60, 25, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/3P-FR-Concordia.xlsx'),
(61, 26, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/4P-FR-Concordia.xlsx'),
(62, 27, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/2P-FR-Concordia.xlsx'),
(63, 28, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/11P-FR-Concordia.xlsx'),
(64, 29, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/2V-FR-Concordia.xlsx'),
(65, 30, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/4V-FR-Concordia.xlsx'),
(66, 31, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/5V-FR-Concordia.xlsx'),
(67, 32, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/6V-FR-Concordia.xlsx'),
(68, 33, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/1V-FR-Concordia.xlsx'),
(69, 34, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/3V-FR-Concordia.xlsx'),
(70, 35, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concordia/7V-FR-Concordia.xlsx'),
(71, 1, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/1H-FR-Diamante.xlsx'),
(72, 2, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/2H-FR-Diamante.xlsx'),
(73, 3, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/3H-FR-Diamante.xlsx'),
(74, 4, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/4H-FR-Diamante.xlsx'),
(75, 5, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/5H-FR-Diamante.xlsx'),
(76, 6, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/6H-FR-Diamante.xlsx'),
(77, 7, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/7H-FR-Diamante.xlsx'),
(78, 8, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/9H-FR-Diamante.xlsx'),
(79, 9, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/11H-FR-Diamante.xlsx'),
(80, 10, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/12H-FR-Diamante.xlsx'),
(81, 11, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/13H-FR-Diamante.xlsx'),
(82, 12, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/8H-FR-Diamante.xlsx'),
(83, 13, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/15H-FR-Diamante.xlsx'),
(84, 14, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/16H-FR-Diamante.xlsx'),
(85, 15, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/17H-FR-Diamante.xlsx'),
(86, 16, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/18H-FR-Diamante.xlsx'),
(87, 17, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/10H-FR-Diamante.xlsx'),
(88, 18, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/6P-FR-Diamante.xlsx'),
(89, 19, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/5P-FR-Diamante.xlsx'),
(90, 20, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/7P-FR-Diamante.xlsx'),
(91, 21, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/8P-FR-Diamante.xlsx'),
(92, 22, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/9P-FR-Diamante.xlsx'),
(93, 23, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/10P-FR-Diamante.xlsx'),
(94, 24, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/1P-FR-Diamante.xlsx'),
(95, 25, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/3P-FR-Diamante.xlsx'),
(96, 26, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/4P-FR-Diamante.xlsx'),
(97, 27, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/2P-FR-Diamante.xlsx'),
(98, 28, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/11P-FR-Diamante.xlsx'),
(99, 29, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/2V-FR-Diamante.xlsx'),
(100, 30, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/4V-FR-Diamante.xlsx'),
(101, 31, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/5V-FR-Diamante.xlsx'),
(102, 32, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/6V-FR-Diamante.xlsx'),
(103, 33, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/1V-FR-Diamante.xlsx'),
(104, 34, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/3V-FR-Diamante.xlsx'),
(105, 35, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Diamante/7V-FR-Diamante.xlsx'),
(106, 1, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/1H-FR-Federación.xlsx'),
(107, 2, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/2H-FR-Federación.xlsx'),
(108, 3, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/3H-FR-Federación.xlsx'),
(109, 4, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/4H-FR-Federación.xlsx'),
(110, 5, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/5H-FR-Federación.xlsx'),
(111, 6, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/6H-FR-Federación.xlsx'),
(112, 7, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/7H-FR-Federación.xlsx'),
(113, 8, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/9H-FR-Federación.xlsx'),
(114, 9, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/11H-FR-Federación.xlsx'),
(115, 10, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/12H-FR-Federación.xlsx'),
(116, 11, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/13H-FR-Federación.xlsx'),
(117, 12, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/8H-FR-Federación.xlsx'),
(118, 13, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/15H-FR-Federación.xlsx'),
(119, 14, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/16H-FR-Federación.xlsx'),
(120, 15, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/17H-FR-Federación.xlsx'),
(121, 16, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/18H-FR-Federación.xlsx'),
(122, 17, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/10H-FR-Federación.xlsx'),
(123, 18, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/6P-FR-Federación.xlsx'),
(124, 19, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/5P-FR-Federación.xlsx'),
(125, 20, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/7P-FR-Federación.xlsx'),
(126, 21, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/8P-FR-Federación.xlsx'),
(127, 22, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/9P-FR-Federación.xlsx'),
(128, 23, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/10P-FR-Federación.xlsx'),
(129, 24, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/1P-FR-Federación.xlsx'),
(130, 25, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/3P-FR-Federación.xlsx'),
(131, 26, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/4P-FR-Federación.xlsx'),
(132, 27, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/2P-FR-Federación.xlsx'),
(133, 28, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/11P-FR-Federación.xlsx'),
(134, 29, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/2V-FR-Federación.xlsx'),
(135, 30, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/4V-FR-Federación.xlsx'),
(136, 31, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/5V-FR-Federación.xlsx'),
(137, 32, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/6V-FR-Federación.xlsx'),
(138, 33, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/1V-FR-Federación.xlsx'),
(139, 34, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/3V-FR-Federación.xlsx'),
(140, 35, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federación/7V-FR-Federación.xlsx'),
(141, 1, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/1H-FR-Federal.xlsx'),
(142, 2, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/2H-FR-Federal.xlsx'),
(143, 3, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/3H-FR-Federal.xlsx'),
(144, 4, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/4H-FR-Federal.xlsx'),
(145, 5, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/5H-FR-Federal.xlsx'),
(146, 6, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/6H-FR-Federal.xlsx'),
(147, 7, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/7H-FR-Federal.xlsx'),
(148, 8, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/9H-FR-Federal.xlsx'),
(149, 9, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/11H-FR-Federal.xlsx'),
(150, 10, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/12H-FR-Federal.xlsx'),
(151, 11, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/13H-FR-Federal.xlsx'),
(152, 12, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/8H-FR-Federal.xlsx'),
(153, 13, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/15H-FR-Federal.xlsx'),
(154, 14, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/16H-FR-Federal.xlsx'),
(155, 15, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/17H-FR-Federal.xlsx'),
(156, 16, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/18H-FR-Federal.xlsx'),
(157, 17, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/10H-FR-Federal.xlsx'),
(158, 18, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/6P-FR-Federal.xlsx'),
(159, 19, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/5P-FR-Federal.xlsx'),
(160, 20, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/7P-FR-Federal.xlsx'),
(161, 21, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/8P-FR-Federal.xlsx'),
(162, 22, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/9P-FR-Federal.xlsx'),
(163, 23, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/10P-FR-Federal.xlsx'),
(164, 24, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/1P-FR-Federal.xlsx'),
(165, 25, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/3P-FR-Federal.xlsx'),
(166, 26, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/4P-FR-Federal.xlsx'),
(167, 27, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/2P-FR-Federal.xlsx'),
(168, 28, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/11P-FR-Federal.xlsx'),
(169, 29, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/2V-FR-Federal.xlsx'),
(170, 30, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/4V-FR-Federal.xlsx'),
(171, 31, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/5V-FR-Federal.xlsx'),
(172, 32, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/6V-FR-Federal.xlsx'),
(173, 33, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/1V-FR-Federal.xlsx'),
(174, 34, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/3V-FR-Federal.xlsx'),
(175, 35, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Federal/7V-FR-Federal.xlsx'),
(176, 1, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/1H-FR-Feliciano.xlsx'),
(177, 2, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/2H-FR-Feliciano.xlsx'),
(178, 3, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/3H-FR-Feliciano.xlsx'),
(179, 4, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/4H-FR-Feliciano.xlsx'),
(180, 5, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/5H-FR-Feliciano.xlsx'),
(181, 6, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/6H-FR-Feliciano.xlsx'),
(182, 7, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/7H-FR-Feliciano.xlsx'),
(183, 8, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/9H-FR-Feliciano.xlsx'),
(184, 9, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/11H-FR-Feliciano.xlsx'),
(185, 10, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/12H-FR-Feliciano.xlsx'),
(186, 11, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/13H-FR-Feliciano.xlsx'),
(187, 12, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/8H-FR-Feliciano.xlsx'),
(188, 13, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/15H-FR-Feliciano.xlsx'),
(189, 14, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/16H-FR-Feliciano.xlsx'),
(190, 15, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/17H-FR-Feliciano.xlsx'),
(191, 16, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/18H-FR-Feliciano.xlsx'),
(192, 17, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/10H-FR-Feliciano.xlsx'),
(193, 18, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/6P-FR-Feliciano.xlsx'),
(194, 19, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/5P-FR-Feliciano.xlsx'),
(195, 20, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/7P-FR-Feliciano.xlsx'),
(196, 21, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/8P-FR-Feliciano.xlsx'),
(197, 22, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/9P-FR-Feliciano.xlsx'),
(198, 23, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/10P-FR-Feliciano.xlsx'),
(199, 24, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/1P-FR-Feliciano.xlsx'),
(200, 25, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/3P-FR-Feliciano.xlsx'),
(201, 26, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/4P-FR-Feliciano.xlsx'),
(202, 27, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/2P-FR-Feliciano.xlsx'),
(203, 28, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/11P-FR-Feliciano.xlsx'),
(204, 29, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/2V-FR-Feliciano.xlsx'),
(205, 30, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/4V-FR-Feliciano.xlsx'),
(206, 31, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/5V-FR-Feliciano.xlsx'),
(207, 32, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/6V-FR-Feliciano.xlsx'),
(208, 33, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/1V-FR-Feliciano.xlsx'),
(209, 34, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/3V-FR-Feliciano.xlsx'),
(210, 35, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Feliciano/7V-FR-Feliciano.xlsx'),
(211, 1, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/1H-FR-Gualeguay.xlsx'),
(212, 2, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/2H-FR-Gualeguay.xlsx'),
(213, 3, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/3H-FR-Gualeguay.xlsx'),
(214, 4, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/4H-FR-Gualeguay.xlsx'),
(215, 5, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/5H-FR-Gualeguay.xlsx'),
(216, 6, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/6H-FR-Gualeguay.xlsx'),
(217, 7, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/7H-FR-Gualeguay.xlsx'),
(218, 8, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/9H-FR-Gualeguay.xlsx'),
(219, 9, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/11H-FR-Gualeguay.xlsx'),
(220, 10, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/12H-FR-Gualeguay.xlsx'),
(221, 11, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/13H-FR-Gualeguay.xlsx'),
(222, 12, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/8H-FR-Gualeguay.xlsx'),
(223, 13, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/15H-FR-Gualeguay.xlsx'),
(224, 14, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/16H-FR-Gualeguay.xlsx'),
(225, 15, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/17H-FR-Gualeguay.xlsx'),
(226, 16, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/18H-FR-Gualeguay.xlsx'),
(227, 17, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/10H-FR-Gualeguay.xlsx'),
(228, 18, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/6P-FR-Gualeguay.xlsx'),
(229, 19, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/5P-FR-Gualeguay.xlsx'),
(230, 20, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/7P-FR-Gualeguay.xlsx'),
(231, 21, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/8P-FR-Gualeguay.xlsx'),
(232, 22, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/9P-FR-Gualeguay.xlsx'),
(233, 23, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/10P-FR-Gualeguay.xlsx'),
(234, 24, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/1P-FR-Gualeguay.xlsx'),
(235, 25, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/3P-FR-Gualeguay.xlsx'),
(236, 26, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/4P-FR-Gualeguay.xlsx'),
(237, 27, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/2P-FR-Gualeguay.xlsx'),
(238, 28, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/11P-FR-Gualeguay.xlsx'),
(239, 29, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/2V-FR-Gualeguay.xlsx'),
(240, 30, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/4V-FR-Gualeguay.xlsx'),
(241, 31, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/5V-FR-Gualeguay.xlsx'),
(242, 32, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/6V-FR-Gualeguay.xlsx'),
(243, 33, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/1V-FR-Gualeguay.xlsx'),
(244, 34, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/3V-FR-Gualeguay.xlsx'),
(245, 35, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguay/7V-FR-Gualeguay.xlsx'),
(246, 1, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/1H-FR-Gualeguaychú.xlsx'),
(247, 2, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/2H-FR-Gualeguaychú.xlsx'),
(248, 3, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/3H-FR-Gualeguaychú.xlsx'),
(249, 4, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/4H-FR-Gualeguaychú.xlsx'),
(250, 5, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/5H-FR-Gualeguaychú.xlsx'),
(251, 6, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/6H-FR-Gualeguaychú.xlsx'),
(252, 7, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/7H-FR-Gualeguaychú.xlsx'),
(253, 8, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/9H-FR-Gualeguaychú.xlsx'),
(254, 9, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/11H-FR-Gualeguaychú.xlsx'),
(255, 10, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/12H-FR-Gualeguaychú.xlsx'),
(256, 11, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/13H-FR-Gualeguaychú.xlsx'),
(257, 12, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/8H-FR-Gualeguaychú.xlsx'),
(258, 13, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/15H-FR-Gualeguaychú.xlsx'),
(259, 14, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/16H-FR-Gualeguaychú.xlsx'),
(260, 15, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/17H-FR-Gualeguaychú.xlsx'),
(261, 16, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/18H-FR-Gualeguaychú.xlsx'),
(262, 17, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/10H-FR-Gualeguaychú.xlsx'),
(263, 18, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/6P-FR-Gualeguaychú.xlsx'),
(264, 19, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/5P-FR-Gualeguaychú.xlsx'),
(265, 20, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/7P-FR-Gualeguaychú.xlsx'),
(266, 21, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/8P-FR-Gualeguaychú.xlsx'),
(267, 22, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/9P-FR-Gualeguaychú.xlsx'),
(268, 23, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/10P-FR-Gualeguaychú.xlsx'),
(269, 24, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/1P-FR-Gualeguaychú.xlsx'),
(270, 25, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/3P-FR-Gualeguaychú.xlsx'),
(271, 26, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/4P-FR-Gualeguaychú.xlsx'),
(272, 27, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/2P-FR-Gualeguaychú.xlsx'),
(273, 28, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/11P-FR-Gualeguaychú.xlsx'),
(274, 29, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/2V-FR-Gualeguaychú.xlsx'),
(275, 30, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/4V-FR-Gualeguaychú.xlsx'),
(276, 31, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/5V-FR-Gualeguaychú.xlsx'),
(277, 32, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/6V-FR-Gualeguaychú.xlsx'),
(278, 33, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/1V-FR-Gualeguaychú.xlsx'),
(279, 34, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/3V-FR-Gualeguaychú.xlsx'),
(280, 35, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Gualeguaychú/7V-FR-Gualeguaychú.xlsx'),
(281, 1, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/1H-FR-Islas.xlsx'),
(282, 2, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/2H-FR-Islas.xlsx'),
(283, 3, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/3H-FR-Islas.xlsx'),
(284, 4, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/4H-FR-Islas.xlsx'),
(285, 5, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/5H-FR-Islas.xlsx'),
(286, 6, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/6H-FR-Islas.xlsx'),
(287, 7, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/7H-FR-Islas.xlsx'),
(288, 8, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/9H-FR-Islas.xlsx'),
(289, 9, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/11H-FR-Islas.xlsx'),
(290, 10, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/12H-FR-Islas.xlsx'),
(291, 11, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/13H-FR-Islas.xlsx'),
(292, 12, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/8H-FR-Islas.xlsx'),
(293, 13, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/15H-FR-Islas.xlsx'),
(294, 14, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/16H-FR-Islas.xlsx'),
(295, 15, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/17H-FR-Islas.xlsx'),
(296, 16, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/18H-FR-Islas.xlsx'),
(297, 17, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/10H-FR-Islas.xlsx'),
(298, 18, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/6P-FR-Islas.xlsx'),
(299, 19, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/5P-FR-Islas.xlsx'),
(300, 20, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/7P-FR-Islas.xlsx'),
(301, 21, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/8P-FR-Islas.xlsx'),
(302, 22, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/9P-FR-Islas.xlsx'),
(303, 23, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/10P-FR-Islas.xlsx'),
(304, 24, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/1P-FR-Islas.xlsx'),
(305, 25, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/3P-FR-Islas.xlsx'),
(306, 26, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/4P-FR-Islas.xlsx'),
(307, 27, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/2P-FR-Islas.xlsx'),
(308, 28, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/11P-FR-Islas.xlsx'),
(309, 29, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/2V-FR-Islas.xlsx'),
(310, 30, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/4V-FR-Islas.xlsx'),
(311, 31, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/5V-FR-Islas.xlsx'),
(312, 32, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/6V-FR-Islas.xlsx'),
(313, 33, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/1V-FR-Islas.xlsx'),
(314, 34, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/3V-FR-Islas.xlsx'),
(315, 35, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Islas/7V-FR-Islas.xlsx'),
(316, 1, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/1H-FR-La Paz.xlsx'),
(317, 2, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/2H-FR-La Paz.xlsx'),
(318, 3, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/3H-FR-La Paz.xlsx'),
(319, 4, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/4H-FR-La Paz.xlsx'),
(320, 5, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/5H-FR-La Paz.xlsx'),
(321, 6, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/6H-FR-La Paz.xlsx'),
(322, 7, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/7H-FR-La Paz.xlsx'),
(323, 8, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/9H-FR-La Paz.xlsx'),
(324, 9, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/11H-FR-La Paz.xlsx'),
(325, 10, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/12H-FR-La Paz.xlsx'),
(326, 11, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/13H-FR-La Paz.xlsx'),
(327, 12, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/8H-FR-La Paz.xlsx'),
(328, 13, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/15H-FR-La Paz.xlsx'),
(329, 14, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/16H-FR-La Paz.xlsx'),
(330, 15, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/17H-FR-La Paz.xlsx'),
(331, 16, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/18H-FR-La Paz.xlsx'),
(332, 17, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/10H-FR-La Paz.xlsx'),
(333, 18, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/6P-FR-La Paz.xlsx'),
(334, 19, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/5P-FR-La Paz.xlsx'),
(335, 20, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/7P-FR-La Paz.xlsx'),
(336, 21, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/8P-FR-La Paz.xlsx'),
(337, 22, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/9P-FR-La Paz.xlsx'),
(338, 23, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/10P-FR-La Paz.xlsx'),
(339, 24, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/1P-FR-La Paz.xlsx'),
(340, 25, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/3P-FR-La Paz.xlsx'),
(341, 26, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/4P-FR-La Paz.xlsx'),
(342, 27, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/2P-FR-La Paz.xlsx'),
(343, 28, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/11P-FR-La Paz.xlsx'),
(344, 29, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/2V-FR-La Paz.xlsx'),
(345, 30, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/4V-FR-La Paz.xlsx'),
(346, 31, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/5V-FR-La Paz.xlsx'),
(347, 32, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/6V-FR-La Paz.xlsx'),
(348, 33, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/1V-FR-La Paz.xlsx'),
(349, 34, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/3V-FR-La Paz.xlsx'),
(350, 35, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/La Paz/7V-FR-La Paz.xlsx'),
(351, 1, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/1H-FR-Nogoyá.xlsx'),
(352, 2, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/2H-FR-Nogoyá.xlsx'),
(353, 3, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/3H-FR-Nogoyá.xlsx'),
(354, 4, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/4H-FR-Nogoyá.xlsx'),
(355, 5, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/5H-FR-Nogoyá.xlsx'),
(356, 6, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/6H-FR-Nogoyá.xlsx'),
(357, 7, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/7H-FR-Nogoyá.xlsx'),
(358, 8, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/9H-FR-Nogoyá.xlsx'),
(359, 9, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/11H-FR-Nogoyá.xlsx'),
(360, 10, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/12H-FR-Nogoyá.xlsx'),
(361, 11, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/13H-FR-Nogoyá.xlsx'),
(362, 12, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/8H-FR-Nogoyá.xlsx'),
(363, 13, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/15H-FR-Nogoyá.xlsx'),
(364, 14, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/16H-FR-Nogoyá.xlsx'),
(365, 15, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/17H-FR-Nogoyá.xlsx'),
(366, 16, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/18H-FR-Nogoyá.xlsx'),
(367, 17, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/10H-FR-Nogoyá.xlsx'),
(368, 18, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/6P-FR-Nogoyá.xlsx'),
(369, 19, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/5P-FR-Nogoyá.xlsx'),
(370, 20, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/7P-FR-Nogoyá.xlsx'),
(371, 21, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/8P-FR-Nogoyá.xlsx'),
(372, 22, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/9P-FR-Nogoyá.xlsx'),
(373, 23, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/10P-FR-Nogoyá.xlsx'),
(374, 24, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/1P-FR-Nogoyá.xlsx'),
(375, 25, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/3P-FR-Nogoyá.xlsx'),
(376, 26, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/4P-FR-Nogoyá.xlsx'),
(377, 27, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/2P-FR-Nogoyá.xlsx'),
(378, 28, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/11P-FR-Nogoyá.xlsx'),
(379, 29, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/2V-FR-Nogoyá.xlsx'),
(380, 30, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/4V-FR-Nogoyá.xlsx'),
(381, 31, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/5V-FR-Nogoyá.xlsx'),
(382, 32, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/6V-FR-Nogoyá.xlsx'),
(383, 33, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/1V-FR-Nogoyá.xlsx'),
(384, 34, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/3V-FR-Nogoyá.xlsx'),
(385, 35, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Nogoyá/7V-FR-Nogoyá.xlsx'),
(386, 1, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/1H-FR-Paraná.xlsx'),
(387, 2, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/2H-FR-Paraná.xlsx'),
(388, 3, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/3H-FR-Paraná.xlsx'),
(389, 4, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/4H-FR-Paraná.xlsx'),
(390, 5, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/5H-FR-Paraná.xlsx'),
(391, 6, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/6H-FR-Paraná.xlsx'),
(392, 7, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/7H-FR-Paraná.xlsx'),
(393, 8, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/9H-FR-Paraná.xlsx'),
(394, 9, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/11H-FR-Paraná.xlsx'),
(395, 10, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/12H-FR-Paraná.xlsx'),
(396, 11, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/13H-FR-Paraná.xlsx'),
(397, 12, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/8H-FR-Paraná.xlsx'),
(398, 13, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/15H-FR-Paraná.xlsx'),
(399, 14, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/16H-FR-Paraná.xlsx'),
(400, 15, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/17H-FR-Paraná.xlsx'),
(401, 16, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/18H-FR-Paraná.xlsx'),
(402, 17, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/10H-FR-Paraná.xlsx'),
(403, 18, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/6P-FR-Paraná.xlsx'),
(404, 19, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/5P-FR-Paraná.xlsx'),
(405, 20, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/7P-FR-Paraná.xlsx'),
(406, 21, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/8P-FR-Paraná.xlsx'),
(407, 22, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/9P-FR-Paraná.xlsx'),
(408, 23, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/10P-FR-Paraná.xlsx'),
(409, 24, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/1P-FR-Paraná.xlsx'),
(410, 25, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/3P-FR-Paraná.xlsx'),
(411, 26, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/4P-FR-Paraná.xlsx'),
(412, 27, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/2P-FR-Paraná.xlsx'),
(413, 28, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/11P-FR-Paraná.xlsx'),
(414, 29, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/2V-FR-Paraná.xlsx'),
(415, 30, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/4V-FR-Paraná.xlsx'),
(416, 31, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/5V-FR-Paraná.xlsx'),
(417, 32, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/6V-FR-Paraná.xlsx'),
(418, 33, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/1V-FR-Paraná.xlsx'),
(419, 34, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/3V-FR-Paraná.xlsx'),
(420, 35, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Paraná/7V-FR-Paraná.xlsx'),
(421, 1, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/1H-FR-San Salvador.xlsx'),
(422, 2, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/2H-FR-San Salvador.xlsx'),
(423, 3, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/3H-FR-San Salvador.xlsx'),
(424, 4, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/4H-FR-San Salvador.xlsx'),
(425, 5, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/5H-FR-San Salvador.xlsx'),
(426, 6, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/6H-FR-San Salvador.xlsx'),
(427, 7, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/7H-FR-San Salvador.xlsx'),
(428, 8, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/9H-FR-San Salvador.xlsx'),
(429, 9, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/11H-FR-San Salvador.xlsx'),
(430, 10, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/12H-FR-San Salvador.xlsx'),
(431, 11, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/13H-FR-San Salvador.xlsx'),
(432, 12, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/8H-FR-San Salvador.xlsx'),
(433, 13, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/15H-FR-San Salvador.xlsx'),
(434, 14, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/16H-FR-San Salvador.xlsx'),
(435, 15, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/17H-FR-San Salvador.xlsx'),
(436, 16, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/18H-FR-San Salvador.xlsx'),
(437, 17, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/10H-FR-San Salvador.xlsx'),
(438, 18, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/6P-FR-San Salvador.xlsx'),
(439, 19, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/5P-FR-San Salvador.xlsx'),
(440, 20, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/7P-FR-San Salvador.xlsx'),
(441, 21, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/8P-FR-San Salvador.xlsx'),
(442, 22, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/9P-FR-San Salvador.xlsx'),
(443, 23, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/10P-FR-San Salvador.xlsx'),
(444, 24, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/1P-FR-San Salvador.xlsx'),
(445, 25, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/3P-FR-San Salvador.xlsx'),
(446, 26, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/4P-FR-San Salvador.xlsx'),
(447, 27, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/2P-FR-San Salvador.xlsx'),
(448, 28, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/11P-FR-San Salvador.xlsx'),
(449, 29, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/2V-FR-San Salvador.xlsx'),
(450, 30, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/4V-FR-San Salvador.xlsx'),
(451, 31, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/5V-FR-San Salvador.xlsx'),
(452, 32, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/6V-FR-San Salvador.xlsx'),
(453, 33, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/1V-FR-San Salvador.xlsx'),
(454, 34, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/3V-FR-San Salvador.xlsx'),
(455, 35, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/San Salvador/7V-FR-San Salvador.xlsx'),
(456, 1, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/1H-FR-Tala.xlsx'),
(457, 2, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/2H-FR-Tala.xlsx'),
(458, 3, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/3H-FR-Tala.xlsx'),
(459, 4, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/4H-FR-Tala.xlsx'),
(460, 5, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/5H-FR-Tala.xlsx'),
(461, 6, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/6H-FR-Tala.xlsx'),
(462, 7, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/7H-FR-Tala.xlsx'),
(463, 8, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/9H-FR-Tala.xlsx'),
(464, 9, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/11H-FR-Tala.xlsx'),
(465, 10, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/12H-FR-Tala.xlsx'),
(466, 11, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/13H-FR-Tala.xlsx'),
(467, 12, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/8H-FR-Tala.xlsx'),
(468, 13, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/15H-FR-Tala.xlsx'),
(469, 14, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/16H-FR-Tala.xlsx'),
(470, 15, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/17H-FR-Tala.xlsx'),
(471, 16, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/18H-FR-Tala.xlsx'),
(472, 17, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/10H-FR-Tala.xlsx'),
(473, 18, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/6P-FR-Tala.xlsx'),
(474, 19, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/5P-FR-Tala.xlsx'),
(475, 20, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/7P-FR-Tala.xlsx'),
(476, 21, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/8P-FR-Tala.xlsx'),
(477, 22, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/9P-FR-Tala.xlsx'),
(478, 23, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/10P-FR-Tala.xlsx'),
(479, 24, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/1P-FR-Tala.xlsx'),
(480, 25, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/3P-FR-Tala.xlsx'),
(481, 26, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/4P-FR-Tala.xlsx'),
(482, 27, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/2P-FR-Tala.xlsx'),
(483, 28, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/11P-FR-Tala.xlsx'),
(484, 29, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/2V-FR-Tala.xlsx'),
(485, 30, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/4V-FR-Tala.xlsx'),
(486, 31, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/5V-FR-Tala.xlsx'),
(487, 32, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/6V-FR-Tala.xlsx'),
(488, 33, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/1V-FR-Tala.xlsx'),
(489, 34, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/3V-FR-Tala.xlsx'),
(490, 35, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Tala/7V-FR-Tala.xlsx'),
(491, 1, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/1H-FR-Concepción del Uruguay.xlsx'),
(492, 2, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/2H-FR-Concepción del Uruguay.xlsx'),
(493, 3, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/3H-FR-Concepción del Uruguay.xlsx'),
(494, 4, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/4H-FR-Concepción del Uruguay.xlsx'),
(495, 5, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/5H-FR-Concepción del Uruguay.xlsx'),
(496, 6, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/6H-FR-Concepción del Uruguay.xlsx'),
(497, 7, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/7H-FR-Concepción del Uruguay.xlsx'),
(498, 8, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/9H-FR-Concepción del Uruguay.xlsx'),
(499, 9, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/11H-FR-Concepción del Uruguay.xlsx'),
(500, 10, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/12H-FR-Concepción del Uruguay.xlsx'),
(501, 11, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/13H-FR-Concepción del Uruguay.xlsx'),
(502, 12, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/8H-FR-Concepción del Uruguay.xlsx'),
(503, 13, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/15H-FR-Concepción del Uruguay.xlsx'),
(504, 14, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/16H-FR-Concepción del Uruguay.xlsx'),
(505, 15, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/17H-FR-Concepción del Uruguay.xlsx'),
(506, 16, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/18H-FR-Concepción del Uruguay.xlsx');
INSERT INTO `register` (`id`, `Title_id_table_register`, `census_has_department_id_register`, `url_table_xlsx`) VALUES
(507, 17, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/10H-FR-Concepción del Uruguay.xlsx'),
(508, 18, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/6P-FR-Concepción del Uruguay.xlsx'),
(509, 19, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/5P-FR-Concepción del Uruguay.xlsx'),
(510, 20, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/7P-FR-Concepción del Uruguay.xlsx'),
(511, 21, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/8P-FR-Concepción del Uruguay.xlsx'),
(512, 22, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/9P-FR-Concepción del Uruguay.xlsx'),
(513, 23, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/10P-FR-Concepción del Uruguay.xlsx'),
(514, 24, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/1P-FR-Concepción del Uruguay.xlsx'),
(515, 25, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/3P-FR-Concepción del Uruguay.xlsx'),
(516, 26, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/4P-FR-Concepción del Uruguay.xlsx'),
(517, 27, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/2P-FR-Concepción del Uruguay.xlsx'),
(518, 28, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/11P-FR-Concepción del Uruguay.xlsx'),
(519, 29, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/2V-FR-Concepción del Uruguay.xlsx'),
(520, 30, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/4V-FR-Concepción del Uruguay.xlsx'),
(521, 31, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/5V-FR-Concepción del Uruguay.xlsx'),
(522, 32, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/6V-FR-Concepción del Uruguay.xlsx'),
(523, 33, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/1V-FR-Concepción del Uruguay.xlsx'),
(524, 34, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/3V-FR-Concepción del Uruguay.xlsx'),
(525, 35, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Concepción del Uruguay/7V-FR-Concepción del Uruguay.xlsx'),
(526, 1, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/1H-FR-Victoria.xlsx'),
(527, 2, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/2H-FR-Victoria.xlsx'),
(528, 3, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/3H-FR-Victoria.xlsx'),
(529, 4, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/4H-FR-Victoria.xlsx'),
(530, 5, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/5H-FR-Victoria.xlsx'),
(531, 6, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/6H-FR-Victoria.xlsx'),
(532, 7, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/7H-FR-Victoria.xlsx'),
(533, 8, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/9H-FR-Victoria.xlsx'),
(534, 9, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/11H-FR-Victoria.xlsx'),
(535, 10, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/12H-FR-Victoria.xlsx'),
(536, 11, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/13H-FR-Victoria.xlsx'),
(537, 12, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/8H-FR-Victoria.xlsx'),
(538, 13, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/15H-FR-Victoria.xlsx'),
(539, 14, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/16H-FR-Victoria.xlsx'),
(540, 15, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/17H-FR-Victoria.xlsx'),
(541, 16, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/18H-FR-Victoria.xlsx'),
(542, 17, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/10H-FR-Victoria.xlsx'),
(543, 18, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/6P-FR-Victoria.xlsx'),
(544, 19, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/5P-FR-Victoria.xlsx'),
(545, 20, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/7P-FR-Victoria.xlsx'),
(546, 21, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/8P-FR-Victoria.xlsx'),
(547, 22, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/9P-FR-Victoria.xlsx'),
(548, 23, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/10P-FR-Victoria.xlsx'),
(549, 24, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/1P-FR-Victoria.xlsx'),
(550, 25, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/3P-FR-Victoria.xlsx'),
(551, 26, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/4P-FR-Victoria.xlsx'),
(552, 27, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/2P-FR-Victoria.xlsx'),
(553, 28, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/11P-FR-Victoria.xlsx'),
(554, 29, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/2V-FR-Victoria.xlsx'),
(555, 30, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/4V-FR-Victoria.xlsx'),
(556, 31, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/5V-FR-Victoria.xlsx'),
(557, 32, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/6V-FR-Victoria.xlsx'),
(558, 33, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/1V-FR-Victoria.xlsx'),
(559, 34, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/3V-FR-Victoria.xlsx'),
(560, 35, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Victoria/7V-FR-Victoria.xlsx'),
(561, 1, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/1H-FR-Villaguay.xlsx'),
(562, 2, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/2H-FR-Villaguay.xlsx'),
(563, 3, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/3H-FR-Villaguay.xlsx'),
(564, 4, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/4H-FR-Villaguay.xlsx'),
(565, 5, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/5H-FR-Villaguay.xlsx'),
(566, 6, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/6H-FR-Villaguay.xlsx'),
(567, 7, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/7H-FR-Villaguay.xlsx'),
(568, 8, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/9H-FR-Villaguay.xlsx'),
(569, 9, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/11H-FR-Villaguay.xlsx'),
(570, 10, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/12H-FR-Villaguay.xlsx'),
(571, 11, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/13H-FR-Villaguay.xlsx'),
(572, 12, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/8H-FR-Villaguay.xlsx'),
(573, 13, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/15H-FR-Villaguay.xlsx'),
(574, 14, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/16H-FR-Villaguay.xlsx'),
(575, 15, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/17H-FR-Villaguay.xlsx'),
(576, 16, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/18H-FR-Villaguay.xlsx'),
(577, 17, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/10H-FR-Villaguay.xlsx'),
(578, 18, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/6P-FR-Villaguay.xlsx'),
(579, 19, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/5P-FR-Villaguay.xlsx'),
(580, 20, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/7P-FR-Villaguay.xlsx'),
(581, 21, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/8P-FR-Villaguay.xlsx'),
(582, 22, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/9P-FR-Villaguay.xlsx'),
(583, 23, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/10P-FR-Villaguay.xlsx'),
(584, 24, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/1P-FR-Villaguay.xlsx'),
(585, 25, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/3P-FR-Villaguay.xlsx'),
(586, 26, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/4P-FR-Villaguay.xlsx'),
(587, 27, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/2P-FR-Villaguay.xlsx'),
(588, 28, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/11P-FR-Villaguay.xlsx'),
(589, 29, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/2V-FR-Villaguay.xlsx'),
(590, 30, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/4V-FR-Villaguay.xlsx'),
(591, 31, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/5V-FR-Villaguay.xlsx'),
(592, 32, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/6V-FR-Villaguay.xlsx'),
(593, 33, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/1V-FR-Villaguay.xlsx'),
(594, 34, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/3V-FR-Villaguay.xlsx'),
(595, 35, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010/Villaguay/7V-FR-Villaguay.xlsx');

-- --------------------------------------------------------

--
-- Table structure for table `register_titles`
--

CREATE TABLE `register_titles` (
  `id` int(11) NOT NULL,
  `id_title` int(11) NOT NULL,
  `id_extension` int(11) NOT NULL,
  `id_acron` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `register_titles`
--

INSERT INTO `register_titles` (`id`, `id_title`, `id_extension`, `id_acron`) VALUES
(1, 1, 1, 0),
(2, 2, 1, 0),
(3, 3, 1, 0),
(4, 4, 1, 0),
(5, 5, 1, 0),
(6, 6, 1, 0),
(7, 7, 1, 0),
(8, 8, 1, 0),
(9, 9, 1, 0),
(10, 10, 1, 0),
(11, 11, 1, 0),
(12, 12, 1, 0),
(13, 13, 1, 0),
(14, 14, 1, 0),
(15, 15, 1, 0),
(16, 16, 1, 0),
(17, 17, 1, 0),
(18, 18, 1, 0),
(19, 19, 1, 0),
(20, 20, 1, 0),
(21, 21, 1, 0),
(22, 22, 1, 0),
(23, 23, 1, 0),
(24, 24, 1, 0),
(25, 25, 1, 0),
(26, 26, 1, 0),
(27, 27, 1, 0),
(28, 28, 1, 0),
(29, 29, 1, 0),
(30, 30, 1, 0),
(31, 31, 1, 0),
(32, 32, 1, 0),
(33, 33, 1, 0),
(34, 34, 1, 0),
(35, 35, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `table`
--

CREATE TABLE `table` (
  `id` int(4) NOT NULL,
  `description` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `table`
--

INSERT INTO `table` (`id`, `description`) VALUES
(1, 'Caracteristicas Habitacionales'),
(2, 'Hacinamiento'),
(3, 'Equipamiento del hogar'),
(4, 'Necesidades basica insatisfecha'),
(5, 'Caracteristicas Economicas'),
(6, 'Composicion del hogar'),
(7, 'Educacion'),
(8, 'Estructura de poblacion'),
(9, 'Migraciones'),
(10, 'Instituciones Colectivas'),
(11, 'Unidades de relevamiento');

-- --------------------------------------------------------

--
-- Table structure for table `theme`
--

CREATE TABLE `theme` (
  `id` char(1) NOT NULL,
  `description` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `theme`
--

INSERT INTO `theme` (`id`, `description`) VALUES
('H', 'Hogar'),
('P', 'Poblacion'),
('V', 'Vivienda');

-- --------------------------------------------------------

--
-- Table structure for table `theme_has_table`
--

CREATE TABLE `theme_has_table` (
  `id_table` int(4) NOT NULL,
  `theme_id` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `theme_has_table`
--

INSERT INTO `theme_has_table` (`id_table`, `theme_id`) VALUES
(1, 'H'),
(2, 'H'),
(3, 'H'),
(4, 'H'),
(3, 'P'),
(5, 'P'),
(6, 'P'),
(7, 'P'),
(8, 'P'),
(9, 'P'),
(1, 'V'),
(10, 'V'),
(11, 'V');

-- --------------------------------------------------------

--
-- Table structure for table `title_table`
--

CREATE TABLE `title_table` (
  `id` int(4) NOT NULL,
  `id_title_table` int(4) NOT NULL,
  `id_table` int(4) NOT NULL,
  `theme_id` char(1) NOT NULL,
  `title_table_titulo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `title_table`
--

INSERT INTO `title_table` (`id`, `id_title_table`, `id_table`, `theme_id`, `title_table_titulo`) VALUES
(1, 1, 1, 'H', 'Hogares por material predominante de los pisos de la vivienda'),
(2, 2, 1, 'H', 'Hogares habitados según tenencia de baño'),
(3, 3, 1, 'H', 'Hogares con baño según desagüe de inodoro '),
(4, 4, 1, 'H', 'Hogares con baño de uso exclusivo'),
(5, 5, 1, 'H', 'Hogares habitados con baño según tengan botón, cadena o mochila para limpieza del inodoro '),
(6, 6, 1, 'H', 'Hogares habitados según procedencia del agua para beber y cocinar'),
(7, 7, 1, 'H', 'Hogares habitados según combustible para cocinar'),
(8, 9, 1, 'H', 'Hogares habitados según régimen de tenencia'),
(9, 11, 1, 'H', 'Hogares habitados según material de la cubierta exterior del techo'),
(10, 12, 1, 'H', 'Hogares habitados según revestimiento interior o cielorraso del techo por department, área de gobierno local, fracción y radio censal'),
(11, 13, 1, 'H', 'Hogares habitados según tenencia de agua'),
(12, 8, 2, 'H', 'Hogares habitados según cantidad de personas por cuarto'),
(13, 15, 3, 'H', 'Hogares habitados según tenga o no celular'),
(14, 16, 3, 'H', 'Hogares habitados según tenga o no computadora'),
(15, 17, 3, 'H', 'Hogares habitados según tenga o no heladera'),
(16, 18, 3, 'H', 'Hogares habitados según tenga o no teléfono de línea'),
(17, 10, 4, 'H', 'Hogares habitados según cumplan algún indicador NBI'),
(18, 6, 5, 'P', 'Población de 14 años y más por condición de actividad'),
(19, 5, 6, 'P', 'Población en hogares según relación de parentesco con el jefe'),
(20, 7, 7, 'P', 'Población de 10 años y más sepan o no leer y escribir'),
(21, 8, 7, 'P', 'Población de 5 años y más que asistió según nivel educativo que cursó y si terminó el nivel'),
(22, 9, 7, 'P', 'Población de 3 años y más según condición de asistencia escolar'),
(23, 10, 7, 'P', 'Población de 3 años y más que asiste según nivel educativo que cursa o cursó'),
(24, 1, 8, 'P', 'Población según sexo'),
(25, 3, 8, 'P', 'Población según grandes grupos de edad'),
(26, 4, 8, 'P', 'Total de población según grupos quinquenales de edad'),
(27, 2, 9, 'P', 'Población según nacimiento en el país o en el extranjero'),
(28, 11, 3, 'P', 'Población de 3 años y más según utiliza o no computadora'),
(29, 2, 1, 'V', 'Viviendas particulares según tipo de vivienda'),
(30, 4, 1, 'V', 'Viviendas particulares habitadas según calidad constructiva'),
(31, 5, 1, 'V', 'Viviendas particulares habitadas según calidad de las conexiones a servicios básicos'),
(32, 6, 1, 'V', 'Viviendas particulares habitadas según calidad de los materiales'),
(33, 1, 10, 'V', 'Viviendas según tipo de vivienda agrupada'),
(34, 3, 10, 'V', 'Viviendas colectivas según tipo de vivienda'),
(35, 7, 11, 'V', 'Viviendas particulares según condición de ocupación');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acronym`
--
ALTER TABLE `acronym`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `census`
--
ALTER TABLE `census`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `census_has_department`
--
ALTER TABLE `census_has_department`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_census_has_department_department1_idx` (`Department_id`),
  ADD KEY `fk_census_has_department_census1_idx` (`Census_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extension`
--
ALTER TABLE `extension`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Title_id_table_register` (`Title_id_table_register`),
  ADD KEY `census_has_department_id_register` (`census_has_department_id_register`);

--
-- Indexes for table `register_titles`
--
ALTER TABLE `register_titles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_title` (`id_title`),
  ADD KEY `fk_id_exten` (`id_extension`),
  ADD KEY `fk_id_acron` (`id_acron`);

--
-- Indexes for table `table`
--
ALTER TABLE `table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `theme`
--
ALTER TABLE `theme`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `theme_has_table`
--
ALTER TABLE `theme_has_table`
  ADD PRIMARY KEY (`theme_id`,`id_table`),
  ADD KEY `fk_theme_has_table_table1_idx` (`id_table`),
  ADD KEY `fk_theme_has_table_theme1_idx` (`theme_id`);

--
-- Indexes for table `title_table`
--
ALTER TABLE `title_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_title_table_table1_idx` (`id_table`),
  ADD KEY `fk_theme_id_title_id_tablex` (`theme_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `extension`
--
ALTER TABLE `extension`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `census_has_department`
--
ALTER TABLE `census_has_department`
  ADD CONSTRAINT `Census_id` FOREIGN KEY (`Census_id`) REFERENCES `census` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Department_id` FOREIGN KEY (`Department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `register`
--
ALTER TABLE `register`
  ADD CONSTRAINT `register_ibfk_1` FOREIGN KEY (`Title_id_table_register`) REFERENCES `register_titles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `register_ibfk_2` FOREIGN KEY (`census_has_department_id_register`) REFERENCES `census_has_department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `register_titles`
--
ALTER TABLE `register_titles`
  ADD CONSTRAINT `fk_id_acron` FOREIGN KEY (`id_acron`) REFERENCES `acronym` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_exten` FOREIGN KEY (`id_extension`) REFERENCES `extension` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_title` FOREIGN KEY (`id_title`) REFERENCES `title_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `theme_has_table`
--
ALTER TABLE `theme_has_table`
  ADD CONSTRAINT `fk_theme_has_table_table1` FOREIGN KEY (`id_table`) REFERENCES `table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_theme_has_table_theme1` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `title_table`
--
ALTER TABLE `title_table`
  ADD CONSTRAINT `fk_theme_id_title_table` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_title_table_table1` FOREIGN KEY (`id_table`) REFERENCES `table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
