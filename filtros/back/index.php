<?php
/*
    function find( $departament, $theme){
        
        $path = 'N:\Informatica\FRANCO';
        $data = file_get_contents("../utils/survey.json");
        $filters = json_decode($data, true);
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

*/
$year = 2010;
$path = 'N:\Informatica\FRANCO';
$censo = '\Censo ' . $year . '-cuadros por muni frac y radio';
$themes = "Caracteristicas Habitacionales";
$data = file_get_contents("C:\\xampp\\htdocs\\front\\utils\\survey.json");
$filters = json_decode($data, true);
$valuIndex = $filters['modules'];

$dataDepartaments = file_get_contents("C:\\xampp\\htdocs\\front\\utils\\departament.json");
$departaments = json_decode($dataDepartaments, true);

foreach ($departaments['departaments'] as $departament) {
    foreach ($valuIndex as $modules) {
        foreach ($modules['tema'] as $themeModule) {
            foreach ($themeModule['array'] as $quadro) {
                $real_path = $path . $censo . "\\" . $departament['value'] . "\\" .
                    $quadro . $modules['id'] . "-FR-" . $departament['value'] . ".xls";
                echo "<p>$real_path</p>";
            }
        }
    }
}
