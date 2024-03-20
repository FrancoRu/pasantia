<?php

namespace App\Database;

use App\Database\MySQL\MySQLDatabase;

use App\Database\Interface\DatabaseAdapterInterface;
use App\Enums\DatabaseType;

/**
 * Class DBManagerFactory
 *
 * Factory class for creating database adapters based on the specified database type.
 *
 * @package App\Database
 */
class DBManagerFactory
{
    /**
     * Create a database adapter based on the specified database type.
     *
     * @param string $databaseType The type of the database.
     *
     * @return DatabaseAdapterInterface|\Exception The database adapter instance or an exception if the type is unsupported.
     *
     * @throws \Exception If an unsupported database type is provided.
     */
    public function createDatabase(string $databaseType): DatabaseAdapterInterface | \Exception
    {
        switch ($databaseType) {
            case DatabaseType::MYSQL:
                return new MySQLDatabase();
            default:
                throw new \Exception('Unsupported database type');
        }
    }
}
