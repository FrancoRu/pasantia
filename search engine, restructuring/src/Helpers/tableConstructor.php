<?php

namespace App\Helpers;

interface ConstructorTable
{
    public static function getTable($data);
}

class tableConstructor implements ConstructorTable
{
    private static function transform(array $results)
    {
        $table = [
            'title' => array_keys($results[0]),  // Arreglo para las columnas
            'body' => $results
        ];

        return $table;
    }


    public static function getTable($data)
    {
        $field = self::transform($data);
        $args = '<table id="table" class="table table-striped row-border">' .
            self::getTitle($field['title']) .
            self::getBody($field['body']) .
            '</table>';
        return $args;
    }

    private static function getTitle($titles)
    {
        $thead = '<thead class="table-dark">
  <tr>';
        foreach ($titles as $title) {
            $thead .= '<th>' . $title . '</th>';
        }
        $thead .= '</tr></thead>';
        return $thead;
    }

    private static function getBody($body)
    {
        $tbody = '<tbody>';
        foreach ($body as $arg) {
            $tbody .= '<tr>';
            foreach ($arg as $registerValue) {
                if (strpos($registerValue, "https://www.dgec.gob.ar/buscador/descargas/") !== false) {
                    $tbody .= '<td><a href="' . $registerValue . '" download><img src="buscadorTemp/../public/resource/img/excel-icon.svg"></a></td>';
                } else {
                    $tbody .= '<td class="text-break">' . $registerValue . '</td>';
                }
            }
            $tbody .= '</tr>';
        }
        $tbody .= '</tbody>';
        return $tbody;
    }
}
