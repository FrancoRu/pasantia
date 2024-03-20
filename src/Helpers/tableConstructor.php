<?php

namespace App\Helpers;

/**
 * Interface ConstructorTable
 *
 * Interface for constructing tables.
 *
 * @package App\Helpers
 */
interface ConstructorTable
{
    /**
     * Get the HTML representation of a table.
     *
     * @param array $data The data to be displayed in the table.
     *
     * @return string The HTML representation of the table.
     */
    public static function getTable(array $data): string;
}

/**
 * Class tableConstructor
 *
 * Helper class for constructing HTML tables.
 *
 * @package App\Helpers
 */
class tableConstructor implements ConstructorTable
{
    /**
     * Transform the result data into a structured array for the table.
     *
     * @param array $results The data to be transformed.
     *
     * @return array The transformed data for the table.
     */
    private static function transform(array $results): array
    {
        $table = [
            'title' => array_keys($results[0]),  // Arreglo para las columnas
            'body' => $results
        ];

        return $table;
    }

    /**
     * Get the HTML representation of a table.
     *
     * @param array $data The data to be displayed in the table.
     *
     * @return string The HTML representation of the table.
     */
    public static function getTable(array $data): string
    {
        $field = self::transform($data);
        $args = '<table id="table" class="table table-striped row-border">' .
            self::getTitle($field['title']) .
            self::getBody($field['body']) .
            '</table>';
        return $args;
    }

    /**
     * Get the HTML representation of the table titles (thead).
     *
     * @param array $titles The titles of the columns.
     *
     * @return string The HTML representation of the table titles.
     */
    private static function getTitle(array $titles): string
    {
        $thead = '<thead class="table-dark">
  <tr>';
        foreach ($titles as $title) {
            $thead .= '<th>' . $title . '</th>';
        }
        $thead .= '</tr></thead>';
        return $thead;
    }

    /**
     * Get the HTML representation of the table body (tbody).
     *
     * @param array $body The data for the table body.
     *
     * @return string The HTML representation of the table body.
     */
    private static function getBody(array $body): string
    {
        $tbody = '<tbody>';
        foreach ($body as $arg) {
            $tbody .= '<tr>';
            foreach ($arg as $registerValue) {
                if (strpos($registerValue, "https://www.dgec.gob.ar/buscador/descargas/") !== false) {
                    $tbody .= '<td><a href="' . $registerValue . '" download><img src="buscador/../public/resource/img/excel-icon.svg"></a></td>';
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
