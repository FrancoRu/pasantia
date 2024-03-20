<?php

namespace App\Models\Interface;

// Definicion de una interfaz para abstraer la consulta de datos.
interface QueryInterface
{
    public function searchQuadro($args);
    public function addQuadro($args);
    public function getData();
}
