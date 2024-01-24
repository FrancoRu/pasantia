<?php
session_start();

class Conectar
{
    protected $dbh;

    protected function Conexion()
    {
        try {
            //Local
            $dsn = "mysql:host=localhost;dbname=dgec_tck";
            $username = "root";
            $password = "";
            //Produccion
            //$dsn = "mysql:host=localhost;dbname=base";
            //$username = "usuario";
            //$password = "contrase&#1043;�a";
            $conectar = $this->dbh = new PDO($dsn, $username, $password);
            return $conectar;
        } catch (PDOException $e) {
            print "&#1042;&#1038;Error BD!: " . $e->getMessage() . "<br/>";
            die();
        }
    }

    public function set_names()
    {
        return $this->dbh->query("SET NAMES 'utf8'");
    }

    public static function ruta()
    {
        //Produccion
        return "http://localhost/sdt/";
    }
}
