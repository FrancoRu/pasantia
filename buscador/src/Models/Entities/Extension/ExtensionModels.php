<?php

namespace App\Models\Entities\Extension;

use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

/**
 * Class ExtensionModels
 *
 * Model class for handling Extension entities.
 *
 * @package App\Models\Entities\Extension
 */
class ExtensionModels
{
    /**
     * @var string The name of the table for Extension entities.
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
        $this->tableName = 'Extension';
    }

    /**
     * Save an Extension entity to the database.
     *
     * @param int $id The ID of the Extension entity.
     * @param string $description The description of the Extension entity.
     * @param string $extension The extension value of the Extension entity.
     *
     * @return array The result of the operation.
     */
    public function save(int $id, string $description, string $extension): array
    {
        return $this->_model->save($this->tableName, [
            'id' => $id,
            'description' => $description,
            'extension' => $extension
        ]);
    }

    /**
     * Find Extension entities based on conditions.
     *
     * @param array|null $mixed Additional options for the query.
     *
     * @return array The result of the operation.
     */
    public function find(array $mixed = null): array
    {
        $args = [];

        if (isset($mixed['conditions'])) {
            $args['conditions'] = ValidationGenericEntitiesModel::validateKeys($mixed['conditions'], ['id', 'description', 'extension']);
        }
        if (isset($mixed['select'])) {
            $args['select'] = ValidationGenericEntitiesModel::validateKeys($mixed['select'], ['id', 'description', 'extension']);
        }
        return $this->_model->find(
            $this->tableName,
            $args
        );
    }

    /**
     * Update Extension entities in the database.
     *
     * @param array $values The values to be updated.
     * @param array $conditions The conditions for the update.
     *
     * @return array The result of the operation.
     */
    public function set(array $values, array $conditions): array
    {
        return $this->_model->set(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($values, ['description', 'extension']),
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'extension'])
        );
    }

    /**
     * Delete Extension entities from the database based on conditions.
     *
     * @param array $conditions The conditions for deletion.
     *
     * @return array The result of the operation.
     */
    public function delete(array $conditions): array
    {
        return $this->_model->delete(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'extension'])
        );
    }
}
