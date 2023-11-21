<?php
require_once(__DIR__ . '/../services/InitService.php');
class InitController
{
    public static function getData()
    {
        echo InitService::getData();
    }
}
