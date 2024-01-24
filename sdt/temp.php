<?php

$archivos = ['2.3.11 Hola.xlsx', 'Chau 2 .xlsx', '1.2.5 hola de nuevo.pdf'];

foreach ($archivos as $archivo) {
    $archivo = preg_replace('/^[0-9.]+/', '', $archivo);
    echo $archivo . '------';
    echo pathinfo($archivo, PATHINFO_EXTENSION);
    echo '///////';
}
