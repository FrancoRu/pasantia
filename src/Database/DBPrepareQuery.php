<?php

namespace App\Database;

use App\Enums\DatabaseType;

/**
 * Class DBPrepareQuery
 *
 * This class provides functionality for preparing and executing database queries.
 *
 * @package App\Database
 */
class DBPrepareQuery
{
    /**
     * @var \PDO The PDO instance for database connection.
     */
    private \PDO $pdo;

    /**
     * @var DBManagerFactory The factory to create database adapters.
     */
    private DBManagerFactory $db;

    /**
     * Constructor.
     *
     * @param string $dbtype The type of the database (default is MYSQL).
     */
    public function __construct(string $dbtype = DatabaseType::MYSQL)
    {
        $this->db = new DBManagerFactory($dbtype);
        $this->pdo = $this->db->createDatabase($dbtype)->connect();
        $this->pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
    }

    /**
     * Clean and sanitize query parameters.
     *
     * @param array|string $args The arguments to be sanitized.
     *
     * @return array|string The sanitized arguments.
     */
    public function cleanParam(array | string $args): array | string
    {
        if (is_string($args)) return $this->argumentEscape($args);
        $newArgs = array();
        foreach ($args as $key => $arg) {
            $newArgs[$key] = $this->argumentEscape($arg);
        }
        return $newArgs;
    }

    /**
     * Escape and quote a query argument.
     *
     * @param mixed $arg The argument to be escaped and quoted.
     *
     * @return mixed The escaped and quoted argument.
     */
    private function argumentEscape(mixed $arg): mixed
    {
        return $this->pdo->quote(htmlspecialchars($arg));
    }

    /**
     * Get the last inserted ID from the database.
     *
     * @return string The last inserted ID.
     */
    public function lastId()
    {
        return $this->pdo->lastInsertId();
    }

    /**
     * Execute a database query.
     *
     * @param string $query The SQL query to be executed.
     * @param array|null $args The arguments to be used in the query.
     *
     * @return array|string The result of the query (either an array or an error message).
     */
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
