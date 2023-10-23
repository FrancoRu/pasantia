<?php

require_once 'DB-Manager.php';
// Definicion de una interfaz para abstraer la consulta de datos.
interface QueryInterface
{
    public function searchQuadro($args);
}

// Implementacion de la consulta de datos.
class QuadroQuery implements QueryInterface
{
    private $db;
    private $stmt;
    public function __construct()
    {
        $this->db = DBManagerFactory::getInstance()->createDatabase();
        $this->stmt = $this->db->connect();
    }

    //Funcion principal de busqueda
    public function searchQuadro($args)
    {
        $cleanedArgs = $this->cleanParam($args); //Limpio lo paramentros de entrada
        $query = $this->getQuery($cleanedArgs); //Me traigo la query segun los parametros pasados

        $stmt = $this->stmt->prepare($query); //Preparo la misma para ser ejecutada
        $types = str_repeat('s', count($cleanedArgs));
        $values = $cleanedArgs;

        array_unshift($values, $types);

        call_user_func_array(array($stmt, 'bind_param'), $values); //Preparo la parametrizacion

        $stmt->execute(); //Ejecuto la query

        return $stmt->get_result(); //Retorno el resultado, ya haya sido exitoso o no 
    }

    //Funcion que elimina todos los caracteres de escape para prevenir SQL injection
    private function cleanParam($args)
    {
        $newArgs = array();
        foreach ($args as $key => $arg) {
            $newArgs[$key] = mysqli_real_escape_string($this->stmt, $arg);
        }

        return $newArgs;
    }

    //Funcion que funciona como query dinámica
    private function getQuery($args)
    {
        $query = "SELECT distinct R.url_cuadro_xlsx, TC.titulo_cuadro_titulo FROM registro R
        JOIN titulo_cuadro TC
        ON TC.ID = R.titulo_cuadro_id_registro
        JOIN cuadro C
        ON C.id_cuadro = TC.Cuadro_id
        JOIN tematica_has_cuadro THC
        ON THC.cuadro_id_cuadro = C.id_cuadro
        JOIN tematica TEM
        ON TEM.id_tematica = THC.tematica_id_tematica
        JOIN censo_has_departamento CHD
        ON CHD.id_censo_has_departamento = R.Censo_has_departamento_id_registro
        JOIN departamento DEP
        ON DEP.id_departamento = CHD.Departamento_id_departamento
        JOIN censo CEN
        ON CEN.id_censo_anio = CHD.Censo_id_censo";
        $conditions = array();

        //Recorro todos los elementos de $args para saber que condiciones se agregaran
        foreach ($args as $key => $arg) {
            $conditions[] = $this->getCondition($key);
        }

        //Si no esta vacio, esto indica que hay condiciones de busqueda, por lo tanto concateno
        if (!empty($conditions)) {
            $query .= " WHERE " . implode(" AND ", $conditions);
        }

        return $query;
    }

    //Condiciones para el where en la query dinámica
    private function getCondition($arg)
    {
        switch ($arg) {
            case "censo":
                return "CEN.id_censo_anio = ?";
            case "department":
                return "DEP.nombre_departamento = ?";
            case "theme":
                return "TEM.tematica_descripcion = ?";
            case "quadro":
                return "C.cuadro_tematica_descripcion = ?";
            default:
                throw new Exception('Incorrect number of arguments');
        }
    }
}

// Definicion de la interfaz para abstraer la gestión de Cuadros.
interface CuadroManagerInterface
{
    public function getQuadro($args);
}

// Implementacion de la gestión de Cuadros.
class CuadroManagement implements CuadroManagerInterface
{
    private $query;

    public function __construct()
    {
        $this->query = new QuadroQuery();
    }

    //Funcion de punto de entrada desde controllers
    public function getQuadro($args)
    {
        return $this->getArrayQuadros($this->query->searchQuadro($args));
    }

    //Devuelve un array asociativo entre la url del cuadro(su ubicacion) y el titulo del mismo
    private function getArrayQuadros($result)
    {
        $cuadros = array();
        while ($row = $result->fetch_assoc()) {
            $cuadros[] = array(
                'url_cuadro' => $row['url_cuadro'],
                'cuadro_titulo' => $row['cuadro_titulo']
            );
        }

        return $cuadros;
    }
}

// // Ejemplo de uso:
// $databaseFactory = DBManagerFactory::getInstance();
// $database = $databaseFactory->createDatabase();
// $query = new QuadroQuery($database);
// $manager = new CuadroManagement($query);
// $args = array(
//     'censo' => '2022',
//     'departament' => 'Some Department',
//     'theme' => 'Some Theme',
//     'quadro' => 'Some Quadro'
// );
// $quadros = $manager->getQuadro($args);