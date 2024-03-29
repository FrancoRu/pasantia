<?php

namespace App\Models\Entities;

use App\Database\DBPrepareQuery;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;
use App\Models\Interfaces\Entities\IGenericEntities;
use App\Enums\DatabaseType;
use App\Helpers\messageConstructor;

/**
 * Class GenericEntitiesModel
 *
 * Model class for handling generic entities operations.
 *
 * @package App\Models\Entities
 */
class GenericEntitiesModel implements IGenericEntities
{
    /**
     * @var DBPrepareQuery The database query preparation object.
     */
    private DBPrepareQuery $db;

    /**
     * @var string The type of the database.
     */
    private string $_databaseType;

    /**
     * Constructor.
     *
     * @param string $databaseType The type of the database.
     */
    public function __construct(string $databaseType)
    {
        $this->db = new DBPrepareQuery($databaseType);
        $this->_databaseType = $databaseType;
    }

    /**
     * Save data to the specified table.
     *
     * @param string $table The name of the table.
     * @param array $values The values to be saved.
     *
     * @return array|string The result of the operation.
     */
    public function save(string $table, array $values): array | string
    {
        $isValid = ValidationGenericEntitiesModel::validateNameTable($table);
        if ($isValid['status'] !== 'ok') return $isValid;

        $isValid = ValidationGenericEntitiesModel::validateArray($values);
        if ($isValid['status'] !== 'ok') return $isValid;

        if (!isset($values['id'])) return messageConstructor::templateMessageResponse('fail', ['When saving, an ID is always required to be sent.']);

        // Obtener las columnas y los valores del array asociativo
        $columns = array_keys($values);
        $placeholders = ':' . implode(', :', $columns);
        $columns = implode(', ', $columns);

        $result = $this->find($table, [
            'select' => ['id' => 'id'],
            'conditions' => $values
        ]);

        if ($result['status'] !== 'ok') return $result;

        if (count($result['response']) > 0) return messageConstructor::templateMessageResponse('fail', ['Existing record']);

        $sql = "INSERT INTO $table ($columns) VALUES ($placeholders)";

        // Ejecutar la consulta y retornar el resultado
        // return $this->db->executeQuery($sql, $values);

        $result = $this->db->executeQuery($sql, $values);
        return is_string($result)
            ? messageConstructor::templateMessageResponse('fail', [$result])
            : messageConstructor::templateMessageResponse('ok', ['Saved information successfully.'], $result);
    }

    /**
     * Call a stored procedure.
     *
     * @param string $name The name of the stored procedure.
     * @param array $values The values to be passed to the stored procedure.
     *
     * @return array|string The result of the operation.
     */
    public function callProcedure(string $name, array $values = []): array | string
    {
        $placeholder = empty($values) ? "" : ':' . implode(', :', array_keys($values));

        switch ($this->_databaseType) {
            case DatabaseType::MYSQL:
                $sql = "CALL $name($placeholder)";
                break;
            case DatabaseType::POSTGRESSQL:
                $sql = "SELECT $name($placeholder)";
                break;
            case DatabaseType::SQLS:
                $sql = "EXEC $name " . implode(', ', array_map(function ($key) {
                    return "@$key";
                }, array_keys($values)));
                break;
        }
        $result = $this->db->executeQuery($sql, $values);
        return is_string($result)
            ? messageConstructor::templateMessageResponse('fail', [$result])
            : messageConstructor::templateMessageResponse('ok', ['Store Procedure Execute successfully.'], $result);
    }

    /**
     * Get data from the specified table.
     *
     * @param string $table The name of the table.
     * @param array|null $values The values to be used in the query.
     *
     * @return array|string The result of the operation.
     */
    public function get(string $table, array $values = null): array | string
    {
        $isValid = ValidationGenericEntitiesModel::validateNameTable($table);
        if ($isValid['status'] !== 'ok') return $isValid;

        $isValid = isset($values) ? ValidationGenericEntitiesModel::validateArray($values) : ['status' => 'ok'];
        if ($isValid['status'] !== 'ok') return $isValid;

        // Obtener las columnas y los valores del array asociativo
        $columns = $values ? "(" . implode(', ', array_keys($values)) . ")" : '*';
        // $placeholders = ':' . implode(', :', $columns);
        $sql = "SELECT $columns FROM $table";
        $result = $this->db->executeQuery($sql, $values);
        return is_string($result)
            ? messageConstructor::templateMessageResponse('fail', [$result])
            : messageConstructor::templateMessageResponse('ok', ['Search completed successfully.'], $result);
    }

    /**
     * Find records in the specified table based on conditions.
     *
     * @param string $table The name of the table.
     * @param array|null $mixed The selection and condition criteria.
     *
     * @return array|string The result of the operation.
     */
    public function find(string $table, array $mixed = null): array | string
    {

        $isValid = ValidationGenericEntitiesModel::validateNameTable($table);
        if ($isValid['status'] !== 'ok') return $isValid;

        $isValid = isset($mixed['select']) ? ValidationGenericEntitiesModel::validateArray($mixed['select']) : ['status' => 'ok'];
        if ($isValid['status'] !== 'ok') return $isValid;

        $isValid = isset($mixed['conditions']) ? ValidationGenericEntitiesModel::validateArray($mixed['conditions']) : ['status' => 'ok'];
        if ($isValid['status'] !== 'ok') return $isValid;

        $selectColumns = empty($mixed['select']) ? '*' : implode(', ', $mixed['select']);
        $conditionClause = empty($mixed['conditions']) ? '' : "WHERE " . implode(' AND ', array_map(function ($key) {
            return "$key = :$key";
        }, array_keys($mixed['conditions']), $mixed['conditions']));

        $sql = "SELECT $selectColumns FROM $table $conditionClause";

        $result = $this->db->executeQuery($sql, $mixed['conditions']);

        return is_string($result)
            ? messageConstructor::templateMessageResponse('fail', [$result])
            : messageConstructor::templateMessageResponse(
                'ok',
                count($result) > 0 ?
                    ['Search completed successfully.'] :
                    ['Search Completed without results'],
                $result
            );
    }

    /**
     * Update records in the specified table.
     *
     * @param string $table The name of the table.
     * @param array $values The values to be updated.
     * @param array $conditions The conditions for the update.
     *
     * @return array|string The result of the operation.
     */
    public function set(string $table, array $values, array $conditions): array | string
    {
        $isValidTable = ValidationGenericEntitiesModel::validateNameTable($table);
        if ($isValidTable['status'] !== 'ok') return $isValidTable;

        $isValidArray = ValidationGenericEntitiesModel::validateArray($values);
        if ($isValidArray['status'] !== 'ok') return $isValidArray;

        $isValidArray = ValidationGenericEntitiesModel::validateArray($conditions);
        if ($isValidArray['status'] !== 'ok') return $isValidArray;

        $columns = implode(', ', array_map(function ($key) {
            return "$key=:col_$key";
        }, array_keys($values)));

        $condition = implode(' AND ', array_map(function ($key) {
            return "$key=:con_$key";
        }, array_keys($conditions), $conditions));

        $sql = "UPDATE $table
                SET $columns
                WHERE $condition";
        $newArray = array_merge($this->modifiedArray($values, 'col_'), $this->modifiedArray($conditions, 'con_'));
        $result = $this->db->executeQuery($sql, $newArray);
        return is_string($result)
            ? messageConstructor::templateMessageResponse('fail', [$result])
            : messageConstructor::templateMessageResponse('ok', ['Changes made successfully.'], $result);
    }

    /**
     * Delete records from the specified table based on conditions.
     *
     * @param string $table The name of the table.
     * @param array $conditions The conditions for deletion.
     *
     * @return array|string The result of the operation.
     */
    public function delete(string $table, array $conditions): array | string
    {
        $isValid = ValidationGenericEntitiesModel::validateNameTable($table);
        if ($isValid['status'] !== 'ok') return $isValid;

        $isValid = ValidationGenericEntitiesModel::validateArray($conditions);
        if ($isValid['status'] !== 'ok') return $isValid;

        $condition = implode(' AND ', array_map(function ($key) {
            return "$key=:$key";
        }, array_keys($conditions), $conditions));

        $sql = "DELETE FROM $table WHERE $condition";
        $result = $this->db->executeQuery($sql, $conditions);
        return is_string($result)
            ? messageConstructor::templateMessageResponse('fail', [$result])
            : messageConstructor::templateMessageResponse('ok', ['Records successfully deleted.'], $result);
    }

    /**
     * Get the last inserted ID from the specified table.
     *
     * @param string $table The name of the table.
     *
     * @return array|string The result of the operation.
     */
    public function lastId(string $table): array | string
    {
        $isValid = ValidationGenericEntitiesModel::validateNameTable($table);
        if ($isValid['status'] !== 'ok') return $isValid;

        switch ($this->_databaseType) {
            case DatabaseType::MYSQL:
            case DatabaseType::POSTGRESSQL:
                $sql = "SELECT id FROM $table ORDER BY id DESC LIMIT 1";
                break;
            case DatabaseType::SQLS:
                $sql = "SELECT TOP 1 id FROM $table ORDER BY id DESC";
                break;
            default:
                return [
                    'status' => 'fail',
                    'message' => ['database type error'],
                    'response' => null
                ];
                break;
        }
        $result = $this->db->executeQuery($sql);
        return is_string($result)
            ? messageConstructor::templateMessageResponse('fail', [$result])
            : messageConstructor::templateMessageResponse('ok', ['Last ID searched successfully.'], $result);
    }

    /**
     * Modify array keys by adding a prefix.
     *
     * @param array $array The array to be modified.
     * @param string $prefix The prefix to be added to each key.
     *
     * @return array The modified array.
     */
    private function modifiedArray(array $array, string $prefix): array
    {
        return array_combine(
            array_map(function ($oldKey) use ($prefix) {
                return $prefix . $oldKey;
            }, array_keys($array)),
            $array
        );
    }
}
