<?php

namespace App\Database\MySQL;

use App\Database\Interface\DatabaseAdapterInterface;

class MySQLDatabase implements DatabaseAdapterInterface
{
    private $pdo;

    public function __construct()
    {
        $dsn = "mysql:host={$_ENV['MYSQL_SERVER']};dbname={$_ENV['MYSQL_DATABASE']}";
        $username = $_ENV['MYSQL_USERNAME'];
        $password = $_ENV['MYSQL_PASSWORD'];

        try {
            $this->pdo = new \PDO($dsn, $username, $password);
            $this->pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        } catch (\PDOException $e) {
            die('Connection failed: ' . $e->getMessage());
        }
    }

    public function connect()
    {
        return $this->pdo;
    }
}
