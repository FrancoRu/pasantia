<?php
require_once './controller/quadroControllers.php';
require_once './controller/initController.php';
require_once './controller/formQuadroController.php';
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



$url = parse_url($_SERVER['REQUEST_URI']);
if (
    isset($url['path']) &&
    strpos($url['path'], '/form') !== false &&
    $_SERVER['REQUEST_METHOD'] === 'GET'
) {
    FormQuadroController::getInfo($url);
}

if (
    $_SERVER['REQUEST_METHOD'] === 'POST'
) {
    $result = $controller->getQuadro();
    echo $result;
}

if (
    $_SERVER['REQUEST_METHOD'] === 'GET'
) {
    echo InitController::getData();
}
