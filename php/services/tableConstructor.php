<?php
interface ConstructorTable
{
    public static function getTable($data);
}

class Construct implements ConstructorTable
{
    public static function getTable($data)
    {
        $results = '<table id="table" class="row-border">' .
            self::getTitle($data['title']) .
            self::getBody($data['body']) .
            '</table>';

        return $results;
    }

    private static function getTitle($titles)
    {
        $thead = '<thead>
    <tr>';
        foreach ($titles as $title) {
            $thead .= '<td>' . $title . '</td>';
        }
        $thead .= '</tr></thead>';
        return $thead;
    }

    private static function getBody($body)
    {
        $tbody = '<tbody>';
        if (count($body) === 0) {
            $tbody .= '
        <tr>
            <td>Error</td>
            <td>Dato no encontrado, por favor realice una nueva búsqueda</td>
            <td>-</td>
        </tr>';
        } else {
            foreach ($body as $arg) {
                $tbody .= '
            <tr>
                <td><a href="' . $arg['url_cuadro'] . '" download><img src="buscador/../resource/img/excel-icon.svg"></a></td>
                <td>' . $arg['cuadro_titulo'] . '</td>
                <td>' . $arg['departamento_cuadro'] . '</td>
            </tr>';
            }
        }
        $tbody .= '</tbody>';
        return $tbody;
    }
}
