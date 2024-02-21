<?php

namespace App\Database\Interface;

/**
 * DatabaseAdapterInterface interface
 *
 * This interface defines the methods that must be implemented by database adapters.
 *
 * @package App\Database\Interface
 */
interface DatabaseAdapterInterface
{
    /**
     * Establishes the connection to the database and returns a PDO object.
     *
     * @return \PDO The PDO connection established.
     *
     * @throws \PDOException If an error occurs during the connection.
     */
    public function connect(): \PDO;
}
