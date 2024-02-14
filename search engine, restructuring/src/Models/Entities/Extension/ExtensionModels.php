<?php

namespace App\Models\Entities\Extension;

use App\Models\Entities\GenericEntitiesModel;

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
        $newArr = $this->validateConditions($mixed);
        return $this->_model->find(
            $this->tableName,
            $newArr
        );
    }

    public function set(array $values, array $conditions): array
    {
        return $this->_model->set(
            $this->tableName,
            $this->validateValues($values),
            $this->validateConditions($conditions)
        );
    }

    public function delete(array $conditions): array
    {
        return $this->_model->delete(
            $this->tableName,
            $this->validateConditions($conditions)
        );
    }

    private function validateConditions(array $conditions): array
    {
        $condition = [];
        if (isset($conditions['id'])) $condition['id'] = $conditions['id'];
        if (isset($conditions['description'])) $condition['description'] = $conditions['description'];
        if (isset($conditions['extension'])) $condition['extension'] = $conditions['extension'];
        return $condition;
    }

    private function validateValues(array $values): array
    {
        $value = [];
        if (isset($values['description'])) $value['description'] = $values['description'];
        if (isset($values['extension'])) $value['extension'] = $values['extension'];
        return $value;
    }
}
