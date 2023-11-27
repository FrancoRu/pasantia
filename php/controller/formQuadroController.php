<?php
require_once(__DIR__ . '/../services/InitService.php');

class FormQuadroController
{
    public static function addQuadro($data)
    {
    }

    public static function getInfo($url)
    {

        $args = [];
        foreach ($_GET as $key => $value) {
            $args[$key] = $value;
        }
        echo json_encode(InitService::getThemes($args), JSON_UNESCAPED_UNICODE);
        exit();
    }
}
