<?php

namespace App\Controller;

use App\Controllers\Entities\ManagerJSON\ManagerJSONControllers;
use App\Controllers\Entities\Table\TableControllers;
use Dotenv\Dotenv;
use App\Enums\DatabaseType;
use App\Helpers\tableConstructor;
use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\ManagerJSON\ManagerJSONModels;
use App\Models\Entities\Table\TableModels;
use Error;

require __DIR__ . '/../../vendor/autoload.php';
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$dotenv = Dotenv::createImmutable(__DIR__ . '/../..');
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


if (isset($_GET['op']) && $_GET['op'] === 'get_cuadro') {
    $tableModel = new TableModels($models);
    $tableController = new TableControllers($tableModel);
    $result = $tableController->findTableByProcedure();
    if ($result['status'] != 'ok') {
        http_response_code(400);
        exit;
    }
    $table = tableConstructor::getTable(
        count($result['response']) > 0 ?
            $result['response'] :
            [['error' => 'No se enconcontraron resultados']]
    );
    http_response_code(200);
    echo json_encode($table, JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_QUOT);
    exit;
}

if (isset($_GET['op']) && $_GET['op'] === 'updateJSONFile') {
    $initModel = new ManagerJSONModels($models);
    $initController = new ManagerJSONControllers($initModel);
    $initController->updateJSONFile();
    exit;
}
