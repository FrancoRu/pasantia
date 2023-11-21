<?php

require_once 'DBManager.php';

class InitService
{
    private static $db;
    private static $stmt;

    private static function initializeDatabase()
    {
        if (self::$db === null) {
            self::$db = DBManagerFactory::getInstance()->createDatabase();
            self::$stmt = self::$db->connect();
        }
    }

    public static function getData()
    {
        self::initializeDatabase();

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
        $statement = self::$stmt->prepare($query);
        if (!$statement) {
            throw new Exception("Error en la preparación de la consulta SQL.");
        }

        $statement->execute();

        $result = $statement->get_result();

        $data = [];
        $lastDepartments = null;
        $lastYear = null;
        $arrayQuadros = [];
        $arrayQuadros[] = "Todos";

        $arrayAll = [];

        while ($row = $result->fetch_assoc()) {
            self::processRow($row, $data, $lastDepartments, $lastYear, $arrayQuadros, $arrayAll);
        }

        $yearIndex = array_search($lastYear, array_column($data['censos'], 'value'));
        if ($row === null) {
            $info = self::transformArray($arrayAll);
            $data['censos'][$yearIndex]['departments'][] = $info;
        }

        // Convertimos a JSON con formato bonito
        //echo json_encode($data, JSON_UNESCAPED_UNICODE);
        self::writeJSON(json_encode($data, JSON_UNESCAPED_UNICODE));
    }
    private static function processRow($row, &$data, &$lastDepartments, &$lastYear, &$arrayQuadros, &$arrayAll)
    {
        $year = $row['id_censo_anio'];
        $department = $row['nombre_departamento'];
        $theme = $row['tematica_descripcion'];
        $quadro = $row['cuadro_tematica_descripcion'];

        if ($lastYear === null) {
            $lastYear = $year;
        }

        if (!isset($arrayAll[$theme]) || !is_array($arrayAll[$theme])) {
            $arrayAll[$theme] = [];
        }

        if (!isset($data['censos'])) {
            $data['censos'] = [];
        }

        $existingYear = array_filter($data['censos'], function ($c) use ($year) {
            return $c['value'] === $year;
        });

        if (empty($existingYear)) {
            $data['censos'][] = [
                'value' => $year,
                'departments' => []
            ];
        }

        $yearIndex = array_search($year, array_column($data['censos'], 'value'));

        $existingDepartment = array_filter($data['censos'][$yearIndex]['departments'], function ($dep) use ($department) {
            return $dep['value'] === $department;
        });

        if (empty($existingDepartment)) {
            $data['censos'][$yearIndex]['departments'][] = [
                'value' => $department,
                'themes' => []
            ];
        }

        $departmentIndex = array_search($department, array_column($data['censos'][$yearIndex]['departments'], 'value'));

        $existingTheme = array_filter($data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'], function ($th) use ($theme) {
            return $th['value'] === $theme;
        });

        if (empty($existingTheme)) {
            $data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'][] = [
                'value' => $theme,
                'quadros' => []
            ];
            $themeIndex = array_search($theme, array_column($data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'], 'value'));
            $data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'][$themeIndex]['quadros'][] = [
                'value' => "Todos"
            ];
            if (!in_array("Todos", $arrayAll["$theme"])) {
                $arrayAll["$theme"][] = "Todos";
            }
        }

        $themeIndex = array_search($theme, array_column($data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'], 'value'));

        $data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'][$themeIndex]['quadros'][] = [
            'value' => $quadro
        ];

        if (!in_array($quadro, $arrayAll["$theme"])) {
            $arrayAll["$theme"][] = $quadro;
        }
        if (!in_array($quadro, $arrayQuadros)) {
            $arrayQuadros[] = $quadro;
        }

        if ($lastDepartments === null) {
            $lastDepartments = $department;
        }

        if ($lastDepartments !== $department) {
            $departmentIndex = array_search($lastDepartments, array_column($data['censos'][$yearIndex]['departments'], 'value'));
            $theme = 'Todos';
            $existingTheme = array_filter($data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'], function ($th) use ($theme) {
                return $th['value'] === $theme;
            });

            if (empty($existingTheme)) {
                $data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'][] = [
                    'value' => $theme,
                    'quadros' => []
                ];
            }

            $themeIndex = array_search($theme, array_column($data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'], 'value'));

            foreach ($arrayQuadros as $Quadros) {
                $data['censos'][$yearIndex]['departments'][$departmentIndex]['themes'][$themeIndex]['quadros'][] = [
                    'value' => $Quadros
                ];
                if (!isset($arrayAll[$theme]) || !is_array($arrayAll[$theme])) {
                    $arrayAll[$theme] = [];
                }
                if (!in_array($Quadros, $arrayAll["$theme"])) {
                    $arrayAll["$theme"][] = $Quadros;
                }
            }
            $lastDepartments = $department;
            $arrayQuadros = [];
            $arrayQuadros[] = "Todos";
        }

        if ($lastYear !== $year) {
            if (!empty($arrayAll)) {
                $yearIndex = array_search($lastYear, array_column($data['censos'], 'value'));
                if ($yearIndex !== false) {
                    $data['censos'][$yearIndex]['departments'][] = self::transformArray($arrayAll);
                } else {
                    $data['censos'][] = [
                        'value' => $lastYear,
                        'departments' => [self::transformArray($arrayAll)]
                    ];
                }

                if (!isset($arrayAll[$theme]) || !is_array($arrayAll[$theme])) {
                    $arrayAll[$theme] = [];
                }
            }
            $lastYear = $year;
        }
    }

    private static function transformArray($inputArray)
    {
        $result = [
            'value' => 'Todos',
            'themes' => []
        ];

        foreach ($inputArray as $key => $values) {
            $themeItem = [
                'value' => $key,
                'quadros' => []
            ];

            foreach ($values as $index => $quadroValue) {
                $quadroItem = [
                    'value' => $quadroValue
                ];

                $themeItem['quadros'][] = $quadroItem;
            }

            $result['themes'][] = $themeItem;
        }
        return $result;
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

    public static function getThemes()
    {
        self::initializeDatabase();
        $query = 'SELECT Cu.cuadro_tematica-descripcion FROM tematica_has_cuadro THC
        INNER JOIN tematica T
        ON T.id_tematica = tematica_id_tematica
        INNER JOIN cuadro Cu
        ON Cu.id_cuadro = THC.cuadro_id_cuadro
        INNER JOIN registro R
        ON R.
        WHERE ';
        $statement = self::$stmt->prepare($query);
        if (!$statement) {
            throw new Exception("Error en la preparación de la consulta SQL.");
        }

        $statement->execute();

        $result = $statement->get_result();
    }
}
