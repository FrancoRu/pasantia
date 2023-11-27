<?php

require_once 'DBPreapareQuery.php';

class InitService
{

    public static function getData()
    {
        DBPrepareQuery::getInstance();

        $query = 'SELECT DISTINCT
        C.id_censo_anio, D.nombre_departamento 
        , T.tematica_descripcion, Cu.cuadro_tematica_descripcion
                FROM registro R
                INNER JOIN censo_has_departamento CD
                ON CD.id_censo_has_departamento =  R.Censo_has_departamento_id_registro
                INNER JOIN censo C
                ON CD.Censo_id_censo = C.id_censo_anio 
                INNER JOIN departamento D 
                ON D.id_departamento = CD.Departamento_id_departamento 
                INNER JOIN titulo_cuadro TC
                ON TC.ID = R.Titulo_cuadro_id_registro
                INNER JOIN tematica T 
                ON T.id_tematica = TC.Tematica_id
                INNER JOIN cuadro Cu
                ON Cu.id_cuadro = TC.Cuadro_id
                ORDER BY C.id_censo_anio ASC,
                D.nombre_departamento ASC, 
                T.tematica_descripcion ASC, 
                Cu.cuadro_tematica_descripcion ASC;';


        // $statement = self::$stmt->prepare($query);
        // if (!$statement) {
        //     throw new Exception("Error en la preparación de la consulta SQL.");
        // }

        // $statement->execute();

        //$result = $statement->get_result();

        $result = DBPrepareQuery::searchData($query);

        $data = [];
        $data["censos"] = [];

        $lastYear = null;
        $lastDepartment = null;
        $lastTheme = null;
        $indexYear = -1; // Comenzar desde -1 para ajustar el primer incremento a 0

        while ($row = $result->fetch_assoc()) {
            $year = $row['id_censo_anio'];
            $department = $row['nombre_departamento'];
            $theme = $row['tematica_descripcion'];
            $quadro = $row['cuadro_tematica_descripcion'];

            if ($lastYear !== $year) {
                $data["censos"][] = [
                    "value" => $year,
                    "departments" => []
                ];
                $lastYear = $year;
                $indexYear++;
                $lastDepartment = null;
                $data["censos"][$indexYear]["departments"][] = [
                    "value" => "Todos",
                    "themes" => []
                ];
                $data["censos"][$indexYear]["departments"][0]["themes"][] = [
                    "value" => "Todos",
                    "quadros" => []
                ];
            }

            // Inicializar el índice del departamento si cambia el departamento
            if ($lastDepartment !== $department) {
                $data["censos"][$indexYear]["departments"][] = [
                    "value" => $department,
                    "themes" => []
                ];
                $lastDepartment = $department;
                $indexDepartment = count($data["censos"][$indexYear]["departments"]) - 1; // Índice del último departamento
                $lastTheme = null;
                $data["censos"][$indexYear]["departments"][$indexDepartment]["themes"][] = [
                    "value" => "Todos",
                    "quadros" => []
                ];
            }

            // Inicializar el índice del tema si cambia el tema
            if ($lastTheme !== $theme) {
                $data["censos"][$indexYear]["departments"][$indexDepartment]["themes"][] = [
                    "value" => $theme,
                    "quadros" => []
                ];
                $lastTheme = $theme;
                $indexTheme = count($data["censos"][$indexYear]["departments"][$indexDepartment]["themes"]) - 1; // Índice del último tema
                $data["censos"][$indexYear]["departments"][$indexDepartment]["themes"][$indexTheme]["quadros"][] = [
                    "value" => "Todos"
                ];
                $valuesThemes = array_column($data["censos"][$indexYear]["departments"][0]["themes"], "value");
                if (!in_array($theme, $valuesThemes)) {
                    $data["censos"][$indexYear]["departments"][0]["themes"][] = [
                        "value" => $theme,
                        "quadros" => []
                    ];
                }
            }

            self::verifyQuadro("Todos", $data, $indexYear, $indexDepartment, 0);

            self::verifyQuadro("Todos", $data, $indexYear, 0, $indexTheme);

            self::verifyQuadro("Todos", $data, $indexYear, 0, 0);

            self::verifyQuadro("Todos", $data, $indexYear, $indexDepartment, $indexTheme);

            self::verifyQuadro($quadro, $data, $indexYear, $indexDepartment, 0);

            self::verifyQuadro($quadro, $data, $indexYear, 0, $indexTheme);

            self::verifyQuadro($quadro, $data, $indexYear, 0, 0);

            self::verifyQuadro($quadro, $data, $indexYear, $indexDepartment, $indexTheme);

            self::writeJSON(json_encode($data, JSON_UNESCAPED_UNICODE));
        }
    }

    private static function verifyQuadro($quadro, &$data, $indexYear, $indexDepartment, $indexTheme)
    {
        $values = array_column($data["censos"][$indexYear]["departments"][$indexDepartment]["themes"][$indexTheme]["quadros"], "value");
        if (!in_array($quadro, $values)) {
            $data["censos"][$indexYear]["departments"][$indexDepartment]["themes"][$indexTheme]["quadros"][] = [
                "value" => $quadro
            ];
        }
    }
    private static function writeJSON($data)
    {
        $filePath = '../public.json';

        // Intenta abrir o crear el archivo en modo escritura
        if ($file = fopen($filePath, 'w')) {
            // Escribe el contenido en el archivo
            fwrite($file, $data);

            fclose($file);
        } else {
            echo "No se pudo abrir o crear el archivo '$filePath'.";
        }
    }

    public static function getThemes($args)
    {
        DBPrepareQuery::getInstance();
        $select = self::getSelect(array_key_last($args));
        $query = "SELECT DISTINCT $select as 'value'
        FROM registro R
    	INNER JOIN titulo_cuadro TC 
    	ON TC.ID = R.titulo_cuadro_id_registro
    	INNER JOIN cuadro C 
    	ON C.id_cuadro = TC.Cuadro_id
    	INNER JOIN tematica TEM 
    	ON TEM.id_tematica = TC.Tematica_id
    	INNER JOIN censo_has_departamento CHD 
    	ON CHD.id_censo_has_departamento = R.Censo_has_departamento_id_registro
    	INNER JOIN departamento DEP 
    	ON DEP.id_departamento = CHD.Departamento_id_departamento
    	INNER JOIN censo CEN 
    	ON CEN.id_censo_anio = CHD.Censo_id_censo";

        $conditions = array();

        //Recorro todos los elementos de $args para saber que condiciones se agregaran
        foreach ($args as $key => $arg) {
            $conditions[] = self::getCondition($key);
        }

        //Si no esta vacio, esto indica que hay condiciones de busqueda, por lo tanto concateno
        if (!empty($conditions)) {
            $query .= " WHERE " . implode(" AND ", $conditions);
        }

        if (empty($args)) {
            $args = null;
        }

        $result = DBPrepareQuery::searchData($query, $args);

        $results = [
            'value' => []
        ];
        while ($row = $result->fetch_assoc()) {
            $results['value'][] = $row;
        }
        return $results;
    }

    private static function getCondition($arg)
    {
        switch ($arg) {
            case "censo":
                return "CEN.id_censo_anio = ?";
            case "department":
                return "DEP.nombre_departamento = ?";
            case "theme":
                return "TEM.tematica_descripcion = ?";
            case "quadro":
                return "C.cuadro_tematica_descripcion = ?";
            default:
                throw new Exception('Incorrect number of arguments');
        }
    }

    private static function getSelect($search)
    {
        switch ($search) {
            case 'censo':
                return 'DEP.nombre_departamento';
            case 'department':
                return 'TEM.tematica_descripcion';
            case 'theme':
                return 'C.cuadro_tematica_descripcion';
            case 'quadro':
                return 'TC.titulo_cuadro_titulo';
            default:
                return 'CEN.id_censo_anio';
        }
    }
}
