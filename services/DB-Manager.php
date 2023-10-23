<?php

interface DatabaseInterface
{
    public function connect();
}

class MySQLDatabase implements DatabaseInterface
{
    private $server;
    private $username;
    private $password;
    private $database;

    public function __construct()
    {
        $this->server = '127.0.0.1';
        $this->username = 'root';
        $this->password = '';
        $this->database = 'mydb';
    }

    public function connect()
    {
        try {
            $conn = new mysqli($this->server, $this->username, $this->password, $this->database);
            return $conn;
        } catch (Exception $e) {
            die('Connection failed: ' . $e->getMessage());
        }
    }
}

class DBManagerFactory
{
    private static $instance;

    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function createDatabase()
    {
        return new MySQLDatabase();
    }
}
