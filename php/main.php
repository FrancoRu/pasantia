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
$url = parse_url($_SERVER['HTTP_REFERER']);

if (
    $_SERVER['REQUEST_METHOD'] === 'POST' &&
    $url['path'] === '/buscador/'
) {
    $result = $controller->getQuadro();
    echo $result;
}

if (
    $_SERVER['REQUEST_METHOD'] === 'POST' &&
    $url['path'] === '/buscador/ingreso.html'
) {
    echo 'hello world';
}

if (
    $_SERVER['REQUEST_METHOD'] === 'GET' &&
    $url['path'] === '/buscador/ingreso.html'
) {
    //$result = $controller->getSearch();
    echo $result;
}
