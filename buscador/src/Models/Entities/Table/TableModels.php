<?php

namespace App\Models\Entities\Table;

use App\Helpers\messageConstructor;
use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

/**
 * Class TableModels
 *
 * Model class for handling Table entities.
 *
 * @package App\Models\Entities\Table
 */
class TableModels
{
    /**
     * @var string The name of the table for Table entities.
     */
    private string $tableName;

    /**
     * @var GenericEntitiesModel The generic entities model for database operations.
     */
    private GenericEntitiesModel $_model;

    /**
     * Constructor.
     *
     * @param GenericEntitiesModel $model The generic entities model for database operations.
     */
    public function __construct(GenericEntitiesModel $model)
    {
        $this->_model = $model;
        $this->tableName = 'Table';
    }

    /**
     * Save a Table entity to the database.
     *
     * @param int $id The ID of the Table entity.
     * @param string $description The description of the Table entity.
     *
     * @return array The result of the operation.
     */
    public function save(int $id, string $description): array
    {
        return $this->_model->save($this->tableName, [
            'id' => $id,
            'description' => $description
        ]);
    }

    /**
     * Save a record to the Table entity using a stored procedure.
     *
     * @param array $mixed The array with 7 columns: [string, int, string, string, char, int, int].
     *                     It must be associative to be used in PDO and simplify its execution.
     *
     * @return array The result of the operation.
     */
    public function saveRecordTable(array $mixed): array
    {
        /*
    *   The $mixed array must have 7 columns, and be associative to be able to be used in PDO and simplify its execution. 
        The types that must arrive are:
        [
            string,
            int,
            string,
            string,
            char,
            int,
            int
        ]   
    
    */
        if (count($mixed) != 7) {
            return ['status' => 'fail', 'message' => ['The array must have 7 columns'], 'response' => null];
        }

        $requiredKeys = ['in_title', 'in_censo', 'in_department', 'in_quadro', 'in_theme', 'in_extension', 'in_fraccion'];
        if (array_diff($requiredKeys, array_keys($mixed))) {
            return [
                'status' => 'fail',
                'message' => ['To execute this procedure, you need an array with the following keys: ' . implode(', ', $requiredKeys)],
                'response' => null
            ];
        }

        if (
            !is_string($mixed['in_title']) ||
            !is_int($mixed['in_censo']) ||
            !is_string($mixed['in_department']) || strlen($mixed['in_department']) !== 3 ||
            !is_string($mixed['in_quadro']) ||
            !is_string($mixed['in_theme']) || strlen($mixed['in_theme']) !== 1 ||
            !is_int($mixed['in_extension']) ||
            !is_int($mixed['in_fraccion'])
        ) {
            return [
                'status' => 'fail',
                'message' => ['Invalid data types or formats in the input array'],
                'response' => null
            ];
        }
        $newArr = [
            'in_title' => $mixed['in_title'],
            'in_censo' => $mixed['in_censo'],
            'in_department' => $mixed['in_department'],
            'in_quadro' => $mixed['in_quadro'],
            'in_theme' => $mixed['in_theme'],
            'in_extension' => $mixed['in_extension'],
            'in_fraccion' => $mixed['in_fraccion']
        ];
        return $this->_model->callProcedure('insertData', $newArr);
    }

    /**
     * Find Table entities based on conditions.
     *
     * @param array|null $mixed Additional options for the query.
     *
     * @return array The result of the operation.
     */
    public function find(array $mixed = null): array
    {
        $args = [];

        if (isset($mixed['conditions'])) {
            $args['conditions'] = ValidationGenericEntitiesModel::validateKeys($mixed['conditions'], ['id', 'description']);
        }
        if (isset($mixed['select'])) {
            $args['select'] = ValidationGenericEntitiesModel::validateKeys($mixed['select'], ['id', 'description']);
        }
        return $this->_model->find(
            $this->tableName,
            $args
        );
    }

    /**
     * Update Table entities in the database.
     *
     * @param array $value The values to be updated.
     * @param array $conditions The conditions for the update.
     *
     * @return array The result of the operation.
     */
    public function set(array $value, array $conditions): array
    {
        return $this->_model->set(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($value, ['description']),
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description'])
        );
    }

    /**
     * Delete Table entities from the database based on conditions.
     *
     * @param array $conditions The conditions for deletion.
     *
     * @return array The result of the operation.
     */
    public function delete(array $conditions): array
    {
        return $this->_model->delete(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description'])
        );
    }

    /**
     * Find a record from the Table entity using a stored procedure.
     *
     * @param array $mixed The array with 4 columns: [census, department, theme, censusTable].
     *
     * @return array The result of the operation.
     */
    public function findRecordTable(array $mixed): array
    {
        if (count($mixed) != 4) return messageConstructor::templateMessageResponse('fail', [
            'When carrying out this operation, you should try to send the census data, department, topic and census table'
        ]);

        foreach ($mixed as $key => $value) {
            if ($value === 'T') $mixed[$key] = null;
        }
        return $this->_model->callProcedure('getQuadro', $mixed);
    }
}
