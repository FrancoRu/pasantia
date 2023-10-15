<?php

require_once '../services/getCuadroManagment.php';

class CuadroController
{
  private $cuadroManagement;

  public function __construct(CuadroManagement $cuadroManagement)
  {
    $this->cuadroManagement = $cuadroManagement;
  }

  public function getQuadro()
  {
    $args = [
      'censo' => $_GET['censo'],
      'departament' => $_GET['departament'],
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