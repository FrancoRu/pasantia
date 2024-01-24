<?php

require_once 'DBManager.php';

class DBPrepareQuery
{
    private static $instance; // Instancia única
    private static $stmt; // Cambiado a estático
    private static $db;

    private function __construct()
    {
        // Constructor privado para evitar la creación de instancias externas
        self::$db = DBManagerFactory::getInstance()->createDatabase();
        self::$stmt = self::$db->connect(); // Establecer la conexión
    }

    public static function getInstance()
    {
        if (!self::$instance) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    //Sanitizo los argumentos

    public static function cleanParam($args)
    {
        $newArgs = array();
        foreach ($args as $key => $arg) {
            $newArgs[$key] = mysqli_real_escape_string(self::$stmt, $arg);
        }

        return $newArgs;
    }

    //Transformo de un array asosiativo a uno comun
    //con el fin de poder usarlo en la funcion bind_param() de msqli
    //para lograr dinamismo

    private static function transformArray($args)
    {
        $newArgs = array();
        foreach ($args as $arg) {
            array_push($newArgs, $arg);
        }
        return $newArgs;
    }

    public static function lastId()
    {
        return self::$stmt->insert_id;
    }

    public static function searchData($query, $args = null)
    {
        try {

            $statement = self::$stmt->prepare($query);

            if ($args !== null) {

                if (!$statement) {
                    throw new Exception("Error en la preparación de la consulta SQL.");
                }

                // $types = str_repeat('s', count($args)); //Crea un string dependiendo de la cantidad de datos a parametrizar

                $types = self::mapTypes($args);

                $values = self::transformArray($args); //Lo transformo en un array simple

                array_unshift($values, $types); //posiciono al frente el tipo de datos de la parametrizacion

                $statement->bind_param(...$values); //Preparo la parametrizacion

            }

            $statement->execute();  //Ejecuto la query

            return $statement->get_result(); //Retorno el resultado, ya haya sido exitoso o no 

        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    private static function mapTypes($args)
    {
        $types = '';
        foreach ($args as $key => $value) {
            $types .= substr($key, 0, 1);
        }
        return $types;
    }

    // private static function type($arg)
    // {
    //     switch (str_starts_with($arg)) {
    //         case 'fraccion':
    //             return 'i';
    //             break;
    //         default:
    //             return 's';
    //             break;
    //     }
    // }
}
