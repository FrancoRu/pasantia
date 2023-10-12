<?php

require_once 'DB-Manager.php';
class CuadroController
{
    private static $instance;
    private $db;
    private $conn;

    private function __construct()
    {
        $this->db = DBManager::getInstance();
        $this->conn = $this->db->connection();
    }

    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function searchCuadroByDepartament($year, $theme, $quadro, $departament)
    {
        $year_s = mysqli_real_escape_string($this->conn, $year);
        $theme_s = mysqli_real_escape_string($this->conn, $theme);
        $quadro_s = mysqli_real_escape_string($this->conn, $quadro);
        $departament_s = mysqli_real_escape_string($this->conn, $departament);

        $query = "SELECT Cu.url_cuadro, Cu.cuadro_titulo FROM Cuadro Cu
        JOIN departamento D
        ON D.nombre_departamento = (?)
        JOIN Tematica_has_Departamento TD
        ON TD.Departamento_id_departamento = D.id_departamento
        JOIN Tematica T
        ON T.tematica_descripcion = (?)
        WHERE Cu.cuadro_descripcion = (?)
        AND CU.cuadro_id_tematica = T.id_tematica
        AND CU.cuadro_id_departamento = D.id_departamento";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sss", $departament_s, $theme_s, $quadro_s);

        $stmt->execute();

        $result = $stmt->get_result();

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
