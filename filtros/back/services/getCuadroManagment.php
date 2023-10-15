<?php
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
    public function __construct(DatabaseInterface $db)
    {
        $this->db = $db;
        $this->stmt = $this->db->connect();
    }

    public function searchQuadro($args)
    {
        $cleanedArgs = $this->cleanParam($args);
        $query = $this->getQuery($cleanedArgs);

        $stmt = $this->stmt->prepare($query);

        $types = str_repeat('s', count($cleanedArgs));
        $values = $cleanedArgs;

        array_unshift($values, $types);

        call_user_func_array(array($stmt, 'bind_param'), $values);

        $stmt->execute();

        return $stmt->get_result();
    }

    private function cleanParam($args)
    {
        $newArgs = array();
        foreach ($args as $key => $arg) {
            $newArgs[$key] = mysqli_real_escape_string($this->stmt, $arg);
        }

        return $newArgs;
    }

    private function getQuery($args)
    {
        $query = "SELECT CT.url_cuadro, CT.cuadro_titulo
        FROM Cuadro Cu
        JOIN Departamento D ON D.id_departamento = CeDe.Departamento_id_departamento
        JOIN Censo_has_Departamento CeDe ON CeDe.Censo_id_censo = Ce.id_censo_anio
        JOIN Censo Ce ON CeDe.Censo_id_censo = Ce.id_censo_anio
        JOIN Tematica_has_Departamento TD ON TD.Departamento_id_departamento = D.id_departamento
        JOIN Tematica T ON T.id_tematica = Cu.cuadro_id_tematica
        JOIN Cuadro_has_Titulo CT ON CT.cuadro_id = Cu.id_cuadro";
        $conditions = array();

        foreach ($args as $key => $arg) {
            $conditions[] = $this->getCondition($key);
        }

        if (!empty($conditions)) {
            $query .= " WHERE " . implode(" AND ", $conditions);
        }

        return $query;
    }

    private function getCondition($arg)
    {
        switch ($arg) {
            case "censo":
                return "Ce.id_censo_anio = ?";
            case "departament":
                return "D.nombre_departamento = ?";
            case "theme":
                return "T.tematica_descripcion = ?";
            case "quadro":
                return "Cu.cuadro_descripcion = ?";
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

    public function __construct(QueryInterface $query)
    {
        $this->query = $query;
    }

    public function getQuadro($args)
    {
        return $this->getArrayQuadros($this->query->searchQuadro($args));
    }

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