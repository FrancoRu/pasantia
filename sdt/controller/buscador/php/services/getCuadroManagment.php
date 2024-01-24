<?php

require_once 'DBPreapareQuery.php';

// Definicion de una interfaz para abstraer la consulta de datos.
interface QueryInterface
{
    public function searchQuadro($args);
}

// Implementacion de la consulta de datos.
class QuadroQuery implements QueryInterface
{

    //Funcion principal de busqueda
    public function searchQuadro($args)
    {
        try {
            DBPrepareQuery::getInstance();
            $cleanedArgs = DBPrepareQuery::cleanParam($args); //Limpio lo paramentros de entrada
            $query = $this->getQuery($cleanedArgs); //Me traigo la query segun los parametros pasados

            return DBPrepareQuery::searchData($query, $cleanedArgs);
        } catch (Exception $e) {
            return $e->getMessage();
        }
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
        $query = "SELECT R.url_cuadro_xlsx AS XLSX, CONCAT(TC.id_titulo_cuadro, TC.Tematica_id, '-', DEP.nombre_departamento, '-', TC.titulo_cuadro_titulo, ' ', EX.descripcion_extension,'-',CEN.id_censo_anio,'.') AS Titulo
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
		ON CEN.id_censo_anio = CHD.Censo_id_censo
        INNER JOIN extension EX
        ON EX.id_extension = TC.extension_id_titulo";

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
    //public function getSearch($args);
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
        return $results = $this->query->searchQuadro($args);
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