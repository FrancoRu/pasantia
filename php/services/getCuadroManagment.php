<?php

require_once 'DBPreapareQuery.php';

// Definicion de una interfaz para abstraer la consulta de datos.
interface QueryInterface
{
    public function searchQuadro($args);
    public function addQuadro($args);
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
            $query = $this->getQuerySearch($cleanedArgs); //Me traigo la query segun los parametros pasados

            return DBPrepareQuery::searchData($query, $cleanedArgs);
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function addQuadro($args)
    {
        try {

            DBPrepareQuery::getInstance();
            $cleanedArgs = DBPrepareQuery::cleanParam($args); //Limpio lo paramentros de entrada

            // // error_log(json_encode($cleanedArgs));
            if (count($cleanedArgs) != count($args)) {
                throw new Error('Parametros con problemas de seguridad');
            }

            $query = 'CALL insertData(?,?,?,?,?,?,?)';
            $result = DBPrepareQuery::searchData($query, $cleanedArgs);
            error_log('Este es el contenido de result: ' . json_encode($result));
            while ($row = $result->fetch_assoc()) {
                return [
                    'id' => $row['id_reg'],
                    'filename' => $row['fileName'],
                    'path' => $row['filePath']
                ];
            }

            return false;
        } catch (Exception $e) {
            error_log($e->getMessage());
            return false;
        }
    }

    //Funcion que funciona como query dinámica para la busqueda de cuadros
    private function getQuerySearch($args)
    {
        //La siguiente query devolvera la url donde s encuentra alojado el cuadro
        //El titulo del cuadro, el nombre de departamento del cual pertenece
        //y una codificicacion
        //Ejemplo un posible resultado puede ser:
        //url:N:\Informatica\FRANCO\Censo 2010-cuadros por muni frac y radio\Colon
        //titulo: Hogares por material predominante de los pisos de la vivienda por área de gobierno local, fracción y radio censal. Año 2010.
        //departamento Colón
        //codificacion: 1H
        $query = "SELECT R.url_cuadro_xlsx AS XLSX, CONCAT(TC.id_titulo_cuadro, TC.Tematica_id, ' - ', D.nombre_departamento, ' - ', TC.titulo_cuadro_titulo, ' ', EX.descripcion_extension,' - ',C.id_censo_anio,'.') AS Titulo
        FROM registro R
                INNER JOIN censo_has_departamento CD
                ON CD.id_censo_has_departamento =  R.Censo_has_departamento_id_registro
                INNER JOIN censo C
                ON CD.Censo_id_censo = C.id_censo_anio 
                INNER JOIN departamento D 
                ON D.id_departamento = CD.Departamento_id_departamento
                INNER JOIN registro_titulos RT
            ON RT.ID = R.Titulo_cuadro_id_registro
            INNER JOIN extension EX
            ON EX.id_extension = RT.id_extension
            INNER JOIN acronimo AC
            ON AC.id = RT.id_acron
            INNER JOIN titulo_cuadro TC
            ON TC.ID = RT.id_titulo
            INNER JOIN cuadro Cu
            ON Cu.id_cuadro = TC.Cuadro_id
            INNER JOIN tematica T
            ON T.id_tematica = TC.Tematica_id";

        //Creo un array para determinar que condiciones de busqueda abra
        //Esto es: si abra o no un WHERE y AND

        $conditions = array();

        //Recorro todos los elementos de $args para saber que condiciones se agregaran
        foreach ($args as $key => $arg) {
            $conditions[] = $this->getCondition($key);
        }

        error_log('condiciones: ' . json_encode($conditions));
        //Si no esta vacio, esto indica que hay condiciones de busqueda, por lo tanto concateno
        if (!empty($conditions)) {
            $query .= " WHERE " . implode(" AND ", $conditions);
        }

        //Clausula de ordenamiento final para que quede mas facil la busqueda
        $query .= " ORDER BY D.nombre_departamento, TC.id_titulo_cuadro ASC;";
        return $query;
    }

    //Condiciones para el where en la query dinámica
    private function getCondition($arg)
    {
        switch ($arg) {
            case "i_censo":
                return "C.id_censo_anio = ?";
            case "s_department":
                return "D.nombre_departamento = ?";
            case "s_theme":
                return "T.tematica_descripcion = ?";
            case "s_quadro":
                return "Cu.cuadro_tematica_descripcion = ?";
            default:
                error_log($arg);
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

    //Funcion accesible desde el sdt
    public function addQuadro($args)
    {
        return $results = $this->query->addQuadro($args);
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