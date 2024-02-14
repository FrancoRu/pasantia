<?php

namespace App\Database;

use App\Database\MySQL\MySQLDatabase;

use App\Database\Interface\DatabaseAdapterInterface;
use App\Enums\DatabaseType;

class DBManagerFactory
{
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
