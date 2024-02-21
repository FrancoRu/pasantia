<?php

namespace App\Models\Entities\Theme;

use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

/**
 * Class ThemeModels
 *
 * Model class for handling Theme entities.
 *
 * @package App\Models\Entities\Theme
 */
class ThemeModels
{
    /**
     * @var string The name of the table for Theme entities.
     */
    private string $tableName;

    /**
     * @var GenericEntitiesModel The generic entities model for database operations.
     */
    private GenericEntitiesModel $_model;

    /**
     * ThemeModels constructor.
     *
     * @param GenericEntitiesModel $model The generic entities model for database operations.
     */
    public function __construct(GenericEntitiesModel $model)
    {
        $this->_model = $model;
        $this->tableName = 'Theme';
    }

    /**
     * Save a Theme entity to the database.
     *
     * @param int $id The ID of the Theme entity.
     * @param string $description The description of the Theme entity.
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
     * Find Theme entities based on conditions.
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
     * Update Theme entities in the database.
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
     * Delete Theme entities from the database based on conditions.
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
