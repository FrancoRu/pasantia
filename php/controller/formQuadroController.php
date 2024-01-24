<?php
require_once(__DIR__ . '/../services/InitService.php');

class FormQuadroController
{
    public static function addQuadro($data)
    {
        $args = [];
        foreach ($_POST as $key => $value) {
            $args[$key] = $value;
        }
    }

    public static function getInfo($url)
    {
        $args = [];
        foreach ($_GET as $key => $value) {
            $args[$key] = $value;
        }
        error_log(json_encode($args));
        if (in_array('select', $args) || in_array('add', $args)) {
            http_response_code(400);
            echo json_encode(
                self::message('Incorrect Parameters or Arguments')
            );
        } else {
            try {
                $data = InitService::getThemes($args);
                echo json_encode(
                    self::message('Consultation Completed Successfully', true, $data),
                    JSON_UNESCAPED_UNICODE
                );
            } catch (Exception $e) {
                http_response_code(500); // Internal Server Error
                echo json_encode(
                    self::message('Internal Server Error')
                );
            }
        }
    }

    private static function message($message, $response = false, $data = [])
    {
        return array(
            'response' => $response,
            'message' => $message,
            'data' => $data
        );
    }
}
