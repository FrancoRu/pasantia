<?php
require_once './services/getCuadroManagment.php';
class CuadroController
{
  private $cuadroManagement;

  public function __construct()
  {
    $this->cuadroManagement = new CuadroManagement();
  }

  //Creo un array asosiativo de los datos del formulario
  //En estte punto no se sanitizan si no que eso lo hara el servicio
  public function getQuadro()
  {
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

    header('Content-Type: application/json');
    echo json_encode($results);
  }
}

// Ejemplo de uso :
// $cuadroManagement = getCuadroManagment::getInstance();
// $cuadroController = new CuadroController($cuadroManagement);
// $cuadroController->getQuadro();