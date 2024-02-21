<?php

namespace App\Database\MySQL;

use App\Database\Interface\DatabaseAdapterInterface;

/**
 * Class MySQLDatabase
 *
 * This class implements the DatabaseAdapterInterface for MySQL database connections.
 *
 * @package App\Database\MySQL
 */
class MySQLDatabase implements DatabaseAdapterInterface
{
    /**
     * @var \PDO The PDO instance for MySQL database connection.
     */
    private \PDO $pdo;

    /**
     * Constructor. Initializes the MySQL database connection.
     */
    public function __construct()
    {
        // Construct the DSN (Data Source Name) for MySQL connection.
        $dsn = "mysql:host={$_ENV['MYSQL_SERVER']};dbname={$_ENV['MYSQL_DATABASE']}";
        $username = $_ENV['MYSQL_USERNAME'];
        $password = $_ENV['MYSQL_PASSWORD'];

        try {
            // Create a new PDO instance for MySQL connection.
            $this->pdo = new \PDO($dsn, $username, $password);

            // Set PDO attributes for error handling.
            $this->pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        } catch (\PDOException $e) {
            // Handle connection failure.
            die('Connection failed: ' . $e->getMessage());
        }
    }

    /**
     * Connect to the MySQL database and return the PDO instance.
     *
     * @return \PDO The established PDO connection.
     */
    public function connect(): \PDO
    {
        return $this->pdo;
    }
}
