<?php
require_once './services/getCuadroManagment.php';
class CuadroController
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
    if (!isset($_GET['censo']) && !isset($_GET['department']) && !isset($_GET['theme']) && !isset($_GET['quadro'])) {
      return json_encode($this->errorResponse, JSON_UNESCAPED_UNICODE);
    }
    $args = [
      'censo' => $_GET['censo'],
      'department' => $_GET['department'],
      'theme' => $_GET['theme'],
      'quadro' => $_GET['quadro'],
    ];
    // Filtra los argumentos para eliminar valores 'Todos'.
    $filteredArgs = array_filter($args, function ($value) {
      return $value !== 'Todos';
    });

    $results = $this->cuadroManagement->getQuadro($filteredArgs);

    return json_encode($results, JSON_UNESCAPED_UNICODE);
  }
}

// Ejemplo de uso :
// $cuadroManagement = getCuadroManagment::getInstance();
// $cuadroController = new CuadroController($cuadroManagement);
// $cuadroController->getQuadro();