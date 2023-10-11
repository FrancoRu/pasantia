<?php

    function find( $departament, $theme){
        
        $path = 'N:\Informatica\FRANCO';
        $data = file_get_contents("../utils/survey.json");
        $filters = json_decode($data, true);
        //$real_path = $path . $censo . "\" . $departament . "\" . $filters['modules'][$modulo]['tema'][][1] . $filters['modules'][$modulo]['id'] . "-FR-" . $departament . ".xls" ;
        echo var_dump($filters);
    }
    $year = 2010;
    $departament = "Paraná";
    $path = 'N:\Informatica\FRANCO';
    $censo = '\Censo ' . $year . '-cuadros por muni frac y radio';
    $module = "hogar";
    $themes = "Caracteristicas Habitacionales";
    $data = file_get_contents("./utils/survey.json");
    $filters = json_decode($data, true);
    $valuIndex = $filters['modules'];

foreach ($valuIndex as $modules) {
    if ($modules['value'] === $module) {
        foreach ($modules['tema'] as $themeModule) {
            if ($themeModule['value'] === $themes) {
                $real_path = $path . $censo . "\\" . $departament . "\\" .
                    $themeModule['array'][0] . $modules['id'] . "-FR-" . $departament . ".xls";
                    echo $real_path;
            }
        }
    }
}

?>
