<?php

namespace App\Models\Entities\Department;

use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

/**
 * Class DepartmentModels
 *
 * Model class for handling Department entities.
 *
 * @package App\Models\Entities\Department
 */
class DepartmentModels
{
    /**
     * @var string The name of the table for Department entities.
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
        $this->tableName = 'Department';
    }

    /**
     * Save a Department entity to the database.
     *
     * @param int $id The ID of the Department entity.
     * @param string $description The description of the Department entity.
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
     * Find Department entities based on conditions.
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
     * Update Department entities in the database.
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
     * Delete Department entities from the database based on conditions.
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
}
