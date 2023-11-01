<?php
require_once './controller/quadroControllers.php';
require 'vendor/autoload.php';
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

if (!isset($_SESSION['state'])) {
    try {
        session_start();
        $_SESSION['state'] = 'ready';
        $controller  = new QuadroController();
    } catch (Exception $e) {
        $errorInfo = [
            'Tipo de Excepción' => get_class($e),
            'Mensaje' => $e->getMessage(),
            'Archivo' => $e->getFile(),
            'Línea' => $e->getLine(),
            'Fecha y Hora' => date('Y-m-d H:i:s'),
        ];
        // Registra la información en un archivo de registro (por ejemplo, error.log)
        error_log(json_encode($errorInfo), 3, 'error.log');
        echo json_encode($errorInfo);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $result = $controller->getQuadro();
    echo $result;
}
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $result = '<div class="container-form">
        <div class="header-form">
            <div class="title-header">
                <h1>Buscador de Cuadros</h1>
                <h2>Censos 2010-2022</h2>
            </div>
            <div class="text">
                <p>
                    En esta sección, se muestran los resultados del Censo Nacional
                    2010 a nivel provincial y por departamentos, con la adición de
                    datos provisionales del Censo 2022. Puedes buscar información
                    según área geográfica, unidad de relevamiento y tema de
                    interés.
                </p>
            </div>
        </div>
        <form id="form" accept-charset="UTF-8">
            <fieldset>
                <label for="censo">
                    Año: <br />
                    <select class="select-form" id="censo" name="censo"></select>
                </label>
            </fieldset>
            <fieldset>
                <label for="department">
                    Unidad geográfica : <br />
                    <select
                        class="select-form"
                        id="department"
                        name="department"
                    ></select>
                </label>
            </fieldset>
            <fieldset>
                <label for="theme">
                    Unidad de relevamiento: <br />
                    <select class="select-form" id="theme" name="theme"></select>
                </label>
            </fieldset>
            <fieldset>
                <label for="quadro">
                    Temas: <br />
                    <select
                        class="select-form"
                        id="quadro"
                        name="quadro"
                    ></select>
                </label>
            </fieldset>
            <div class="button-container">
                <button type="submit" id="submit">Buscar</button>
            </div>
        </form>
    </div>';

    echo $result;
}
