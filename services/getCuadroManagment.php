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
        try {
            $cleanedArgs = $this->cleanParam($args); //Limpio lo paramentros de entrada
            $query = $this->getQuery($cleanedArgs); //Me traigo la query segun los parametros pasados
            $statement = $this->stmt->prepare($query); //Preparo la misma para ser ejecutada

            if (!$statement) {
                throw new Exception("Error en la preparación de la consulta SQL.");
            }

            $types = str_repeat('s', count($cleanedArgs)); //Crep un sstring dependiendo de la cantidad de datos a parametrizar
            $values = $this->transformArray($cleanedArgs); //Lo transformo en un array simple
            array_unshift($values, $types); //posiciono al frente el tipo de datos de la parametrizacion
            $statement->bind_param(...$values); //Preparo la parametrizacion
            $statement->execute(); //Ejecuto la query
            return $statement->get_result(); //Retorno el resultado, ya haya sido exitoso o no 
        } catch (Exception $e) {
            return $e->getMessage();
        }
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

    //Transformo de un array asosiativo a uno comun
    //con el fin de poder usarlo en la funcion bind_param() de msqli
    //para lograr dinamismo
    private function transformArray($args)
    {
        $newArgs = array();
        foreach ($args as $arg) {
            array_push($newArgs, $arg);
        }
        return $newArgs;
    }

    //Funcion que funciona como query dinámica
    private function getQuery($args)
    {
        //La siguiente query devolvera la url donde s encuentra alojado el cuadro
        //El titulo del cuadro, el nombre de departamento del cual pertenece
        //y una codificicacion
        //Ejemplo un posible resultado puede ser:
        //url:N:\Informatica\FRANCO\Censo 2010-cuadros por muni frac y radio\Colon
        //titulo: Hogares por material predominante de los pisos de la vivienda por área de gobierno local, fracción y radio censal. Año 2010.
        //departamento Colón
        //codificacion: 1H
        $query = "SELECT R.url_cuadro_xlsx, TC.titulo_cuadro_titulo, 
        DEP.nombre_departamento, CONCAT(TC.id_titulo_cuadro,TC.Tematica_id) AS cuadro_tematica 
        FROM registro R
		INNER JOIN titulo_cuadro TC 
		ON TC.ID = R.titulo_cuadro_id_registro
		INNER JOIN cuadro C 
		ON C.id_cuadro = TC.Cuadro_id
		INNER JOIN tematica TEM 
		ON TEM.id_tematica = TC.Tematica_id
		INNER JOIN censo_has_departamento CHD 
		ON CHD.id_censo_has_departamento = R.Censo_has_departamento_id_registro
		INNER JOIN departamento DEP 
		ON DEP.id_departamento = CHD.Departamento_id_departamento
		INNER JOIN censo CEN 
		ON CEN.id_censo_anio = CHD.Censo_id_censo";

        //Creo un array para determinar que condiciones de busqueda abra
        //Esto es: si abra o no un WHERE y AND

        $conditions = array();

        //Recorro todos los elementos de $args para saber que condiciones se agregaran
        foreach ($args as $key => $arg) {
            $conditions[] = $this->getCondition($key);
        }

        //Si no esta vacio, esto indica que hay condiciones de busqueda, por lo tanto concateno
        if (!empty($conditions)) {
            $query .= " WHERE " . implode(" AND ", $conditions);
        }

        //Clausula de ordenamiento final para que quede mas facil la busqueda
        $query .= " ORDER BY DEP.nombre_departamento, TC.id_titulo_cuadro ASC;";
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
        $results = $this->query->searchQuadro($args);
        if ($results instanceof mysqli_result) {
            $cuadros = $this->getArrayQuadros($results);
        } else {
            $cuadros = array(
                array(
                    'cuadro_titulo' => 'No se encontraron cuadros con la información proporcionada',
                    'url_cuadro' => '',
                    'departamento_cuadro' => '',
                    'cuadro_tematica' => '',
                )
            );
        }
        return $cuadros;
    }

    //Devuelve un array asociativo entre: 
    //La url del cuadro(su ubicacion)
    //El titulo del mismo
    //EL nombre de departamento
    //La codificacion del mismo
    private function getArrayQuadros($result)
    {
        $cuadros = array();
        while ($row = $result->fetch_assoc()) {
            $cuadros[] = array(
                'url_cuadro' => $row['url_cuadro_xlsx'],
                'cuadro_titulo' => $row['titulo_cuadro_titulo'],
                'departamento_cuadro' => $row['nombre_departamento'],
                'cuadro_tematica' => $row['cuadro_tematica']
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