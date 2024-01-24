<?php
require_once './services/getCuadroManagment.php';
require_once './services/tableConstructor.php';
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
      'censo' => $_POST['censo'],
      'department' => $_POST['department'],
      'theme' => $_POST['theme'],
      'quadro' => $_POST['quadro'],
    ];
    // Filtra los argumentos para eliminar valores 'Todos'.
    $filteredArgs = array_filter($args, function ($value) {
      return $value !== 'Todos';
    });

    $results = $this->cuadroManagement->getQuadro($filteredArgs);
    $table = Construct::getTable($results);
    error_log($table);
    return json_encode($table, JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_QUOT);
  }
}

// Ejemplo de uso :
// $cuadroManagement = getCuadroManagment::getInstance();
// $cuadroController = new CuadroController($cuadroManagement);
// $cuadroController->getQuadro();