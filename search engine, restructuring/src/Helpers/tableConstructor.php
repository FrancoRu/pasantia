<?php
interface ConstructorTable
{
    public static function getTable($data);
}

class Construct implements ConstructorTable
{
    private static function transform($result)
    {
        $table = [
            'title' => [],  // Arreglo para las columnas
            'body' => []    // Arreglo para los registros
        ];
        // Verifica que $result sea un objeto válido
        if ($result && $result->num_rows > 0) {
            $firstRow = $result->fetch_assoc();

            $table['title'] = array_keys($firstRow);

            // Reinicia el puntero del resultado
            $result->data_seek(0);
            while ($row = $result->fetch_assoc()) {
                $table['body'][] = array_values($row);
            }
        }

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
                    $tbody .= '<td><a href="' . $registerValue . '" download><img src="buscador/../resource/img/excel-icon.svg"></a></td>';
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
