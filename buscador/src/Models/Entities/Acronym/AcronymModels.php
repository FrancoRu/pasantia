<?php

namespace App\Models\Entities\Acronym;

use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

/**
 * Class AcronymModels
 *
 * Model class for handling Acronym entities.
 *
 * @package App\Models\Entities\Acronym
 */
class AcronymModels
{

    /**
     * @var string The name of the table for Acronym entities.
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
        $this->tableName = 'Acronym';
    }

    /**
     * Save an Acronym entity to the database.
     *
     * @param int $id The ID of the Acronym entity.
     * @param string $description The description of the Acronym entity.
     * @param string $acronym The acronym of the Acronym entity.
     *
     * @return array The result of the operation.
     */
    public function save(int $id, string $description, string $acronym): array
    {
        return $this->_model->save($this->tableName, [
            'id' => $id,
            'description' => $description,
            'acronym' => $acronym
        ]);
    }

    /**
     * Get Acronym entities from the database.
     *
     * @param array|null $mixed Additional options for the query.
     *
     * @return array The result of the operation.
     */
    public function get(array $mixed = null): array
    {

        return $this->_model->get($this->tableName, $mixed);
    }

    /**
     * Find Acronym entities based on conditions.
     *
     * @param array|null $mixed Additional options for the query.
     *
     * @return array The result of the operation.
     */

    public function find(array $mixed = null): array
    {
        $args = [];

        if (isset($mixed['conditions'])) {
            $args['conditions'] = ValidationGenericEntitiesModel::validateKeys($mixed['conditions'], ['id', 'description', 'acronym']);
        }
        if (isset($mixed['select'])) {
            $args['select'] = ValidationGenericEntitiesModel::validateKeys($mixed['select'], ['id', 'description', 'acronym']);
        }
        return $this->_model->find(
            $this->tableName,
            $args
        );
    }

    /**
     * Update Acronym entities in the database.
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
            ValidationGenericEntitiesModel::validateKeys($value, ['description', 'acronym']),
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'acronym'])
        );
    }

    /**
     * Delete Acronym entities from the database based on conditions.
     *
     * @param array $conditions The conditions for deletion.
     *
     * @return array The result of the operation.
     */
    public function delete(array $conditions): array
    {
        return $this->_model->delete(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'acronym'])
        );
    }
}
