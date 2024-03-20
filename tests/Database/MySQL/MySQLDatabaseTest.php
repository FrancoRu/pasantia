<?php

namespace App\Tests\Database\MySQL;

use App\Database\MySQL\MySQLDatabase;

use PHPUnit\Framework\TestCase;


class MySQLDatabaseTest extends TestCase
{
    /** @var MySQLDatabase */
    private $db;

    protected function setUp(): void
    {

        // Configura la conexión a la base de datos antes de cada prueba
        $this->db = new MySQLDatabase();
    }

    public function testConnection()
    {
        // Intenta conectarte a la base de datos
        $connection = $this->db->connect();

        // Verifica que la conexión sea un objeto PDO válido
        $this->assertInstanceOf(\PDO::class, $connection);

        // Otras aserciones o pruebas que desees realizar
        // Por ejemplo, puedes agregar pruebas para comprobar la ejecución de consultas u otras interacciones con la base de datos
    }
}
