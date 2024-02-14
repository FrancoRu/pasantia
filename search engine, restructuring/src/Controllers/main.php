<?php

namespace App\Controller;

use Dotenv\Dotenv;
use App\Enums\DatabaseType;
use App\Models\Entities\GenericEntitiesModel;

require 'vendor/autoload.php';
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

$models = new GenericEntitiesModel(DatabaseType::MYSQL);

if (!isset($_SESSION['state'])) {
    try {
        session_start();
        $_SESSION['state'] = 'ready';
    } catch (\Exception $e) {
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
