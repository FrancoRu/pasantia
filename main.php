<?php
require_once './controller/cuadros-controllers.php';
require 'vendor/autoload.php';
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

if (!isset($_SESSION['state'])) {
    try {
        session_start();
        $_SESSION['state'] = 'ready';
        $controller  = new CuadroController();
    } catch (Exception $e) {
        echo $e->getMessage();
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $result = $controller->getQuadro();
    echo $result;
}
