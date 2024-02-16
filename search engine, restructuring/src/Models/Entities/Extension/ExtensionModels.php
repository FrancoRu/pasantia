<?php

namespace App\Models\Entities\Extension;

use App\Models\Entities\GenericEntitiesModel;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

class ExtensionModels
{
    private readonly string $tableName;
    private readonly GenericEntitiesModel $_model;

    public function __construct(GenericEntitiesModel $model)
    {
        $this->_model = $model;
        $this->tableName = 'Extension';
    }

    public function save(int $id, string $description, string $extension): array
    {
        return $this->_model->save($this->tableName, [
            'id' => $id,
            'description' => $description,
            'extension' => $extension
        ]);
    }

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

    public function set(array $values, array $conditions): array
    {
        return $this->_model->set(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($values, ['description', 'extension']),
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'extension'])
        );
    }

    public function delete(array $conditions): array
    {
        return $this->_model->delete(
            $this->tableName,
            ValidationGenericEntitiesModel::validateKeys($conditions, ['id', 'description', 'extension'])
        );
    }
}
