<?php

$args = [
    'censo' => $_GET['censo'],
    'departament' => $_GET['departament'],
    'theme' => $_GET['theme'],
    'quadro' => $_GET['quadro'],
  ];
  header('Content-Type: application/json; charset=utf-8');
  echo json_encode($args, JSON_UNESCAPED_UNICODE);


/*
// Carga las dependencias y las clases definidas previamente
require_once 'DB-Manager.php';
require_once './controller/cuadros-controllers.php';
// Configuración de la base de datos utilizando la fábrica
$databaseFactory = DBManagerFactory::getInstance();
$database = $databaseFactory->createDatabase();

// Creación de la instancia de Query
$query = new QuadroQuery($database);

// Creación de la instancia de CuadroManagement
$manager = new CuadroManagement($query);

$controller  = new CuadroController($manager);

$controller->getQuadro();*/