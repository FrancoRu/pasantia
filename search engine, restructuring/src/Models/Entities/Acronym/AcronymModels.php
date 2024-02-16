<?php

namespace App\Models\Entities\Acronym;

use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

class AcronymModels
{
    private readonly string $tableName;
    private readonly GenericEntitiesModel $_model;

    public function __construct(GenericEntitiesModel $model)
    {
        $this->_model = $model;
        $this->tableName = 'Acronym';
    }

    public function save(int $id, string $description, string $acronym): array
    {
        return $this->_model->save($this->tableName, [
            'id' => $id,
            'description' => $description,
            'acronym' => $acronym
        ]);
    }

    public function get(array $mixed = null): array
    {

        return $this->_model->get($this->tableName, $mixed);
    }

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

    public function set(array $value, array $conditions): array
    {
        return $this->_model->set(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($value, ['description', 'acronym']),
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'acronym'])
        );
    }

    public function delete(array $conditions): array
    {
        return $this->_model->delete(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'acronym'])
        );
    }
}
