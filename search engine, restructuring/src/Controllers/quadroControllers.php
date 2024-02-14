<?php
require_once './services/getCuadroManagment.php';
require_once './services/tableConstructor.php';
require_once 'initController.php';

class QuadroController
{
  private $cuadroManagement;
  private $errorResponse;
  public function __construct()
  {
    $this->cuadroManagement = new CuadroManagement();
    $this->errorResponse = [
      'error' => true,
      'message' => 'Ocurrió un error en el servidor. Por favor, inténtalo de nuevo más tarde.'
    ];
  }

  //Creo un array asosiativo de los datos del formulario
  //En estte punto no se sanitizan si no que eso lo hara el servicio
  public function getQuadro()
  {
    if (!isset($_POST['censo']) && !isset($_POST['department']) && !isset($_POST['theme']) && !isset($_POST['quadro'])) {
      return json_encode($this->errorResponse, JSON_UNESCAPED_UNICODE);
    }
    $args = [
      'i_censo' => $_POST['censo'],
      's_department' => $_POST['department'],
      's_theme' => $_POST['theme'],
      'i_quadro' => $_POST['quadro'],
    ];
    $results = $this->cuadroManagement->getQuadro($args);
    $table = Construct::getTable($results);
    return json_encode($table, JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_QUOT);
  }

  public function getData()
  {
    $result = $this->cuadroManagement->getData();
    if (!$result) {
      echo json_encode(['message' => 'se tenso']);
      exit;
    }

    $data = [];

    while ($row = $result->fetch_assoc()) {
      $row['out_dep'] = json_decode($row['out_dep'], true);
      $row['out_ext'] = json_decode($row['out_ext'], true);

      $row['out_dep']['department'] = json_decode($row['out_dep']['department'], true);
      $row['out_ext']['extension'] = json_decode($row['out_ext']['extension'], true);

      $data[] = $row;
    }

    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
  }

  public function updateJSONFile()
  {
    InitController::getData();
    $filePath = __DIR__ . '/../../public.json';

    // Verificar si el archivo existe
    if (!file_exists($filePath)) {
      echo 'JSON no encontrado';
      exit;
    }

    // Leer el contenido del archivo JSON
    $fileContents = file_get_contents($filePath);

    // Verificar si la lectura fue exitosa
    if ($fileContents === false) {
      echo 'Error al leer el archivo JSON';
      exit;
    }

    // Decodificar el JSON en un array asociativo
    $dataArray = json_decode($fileContents, true);

    // Verificar si la decodificación fue exitosa
    if ($dataArray === null) {
      echo 'Error al decodificar el JSON';
      exit;
    }

    // Mostrar la estructura de datos del JSON
    print_r($dataArray);
  }

  public function addQuadro()
  {
    $this->validateField('censo', 'censo');
    $this->validateField('department', 'department');
    $this->validateField('theme', 'Unidad de relevamiento');
    $this->validateField('quadro', 'Cuadro');
    $this->validateField('title', 'Titulo');
    $this->validateField('extension', 'Extensión');
    $this->validateField('fraccion', 'Fracción');

    $args = [
      's_title' => ucfirst(strtolower($_POST['title'])),
      'i_censo' => $_POST['censo'],
      's_department' => $_POST['department'],
      's_quadro' => ucfirst(strtolower($_POST['quadro'])),
      's_theme' => $_POST['theme'],
      'i_extension' => $_POST['extension'],
      'i_fraccion' => $_POST['fraccion']
    ];

    $this->validateFile($_FILES['input-File']);

    $result = $this->cuadroManagement->addQuadro($args);


    if (!$result) {
      http_response_code(404);
      echo json_encode(['title' => 'Error!!!', 'data' => 'Hubo un error al cargar el cuadro', 'icon' => 'error']);
      exit;
    }


    $this->moveFile($result);
    InitController::getData();
    http_response_code(200);
    echo json_encode(['title' => 'Exito!!!', 'data' => 'Exito al cargar el cuadro', 'icon' => 'success']);
    exit;
  }

  private function validateField($fieldName, $fieldLabel)
  {
    if (!isset($_POST[$fieldName]) || $_POST[$fieldName] === null || $_POST[$fieldName] === '') {
      http_response_code(404);
      echo json_encode(['title' => 'Error!!!', 'data' => 'El campo "' . $fieldLabel . '" no puede estar vacío', 'icon' => 'error']);
      exit;
    }
  }

  private function validateFile($file)
  {
    if (!isset($file['name']) || strlen($file['name']) == 0 || !isset($file['tmp_name']) || strlen($file['tmp_name']) == 0) {
      http_response_code(404);
      echo json_encode(['title' => 'Error!!!', 'data' => 'Se debe proporcionar un archivo con el formato correcto para cargar el cuadro', 'icon' => 'error']);
      exit;
    }
  }


  private function moveFile($result)
  {
    $_FILES['input-File']['name'] = $result['filename'];
    $path = '../descargas/' . $result['path'];
    $newPath = str_replace($result['filename'], '', $path);
    if (!@file_exists($newPath)) {
      @mkdir($newPath, 0777, true);
    }

    if (@move_uploaded_file($_FILES['input-File']['tmp_name'], $path)) {
      InitController::getData();
      return true;
    } else {
      error_log('No entro al move file');
    }

    return false;
  }
}

// Ejemplo de uso :
// $cuadroManagement = getCuadroManagment::getInstance();
// $cuadroController = new CuadroController($cuadroManagement);
// $cuadroController->getQuadro();