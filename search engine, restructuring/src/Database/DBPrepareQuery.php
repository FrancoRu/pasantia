<?php

namespace App\Database;

use App\Enums\DatabaseType;

class DBPrepareQuery
{
    private $pdo;
    private $db;

    public function __construct(string $dbtype = DatabaseType::MYSQL)
    {
        // Constructor privado para evitar la creación de instancias externas
        $this->db = new DBManagerFactory($dbtype);
        $this->pdo = $this->db->createDatabase($dbtype)->connect();
        $this->pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
    }

    // Sanitizo los argumentos
    public function cleanParam(array | string $args): array | string
    {
        if (is_string($args)) return $this->argumentEscape($args);
        $newArgs = array();
        foreach ($args as $key => $arg) {
            $newArgs[$key] = $this->argumentEscape($arg); // Ajustar la sanitización según tus necesidades
        }
        return $newArgs;
    }

    private function argumentEscape(mixed $arg): mixed
    {
        return $this->pdo->quote(htmlspecialchars($arg));
    }

    public function lastId()
    {
        return $this->pdo->lastInsertId();
    }

    public function executeQuery($query, $args = null): array | string
    {
        try {
            $statement = $this->pdo->prepare($query);

            $statement->execute($args);  // Ejecuto la query

            return $statement->fetchAll(\PDO::FETCH_ASSOC); // Retorno el resultado, ya haya sido exitoso o no

        } catch (\Exception $e) {
            return $e->getMessage();
        }
    }
}
