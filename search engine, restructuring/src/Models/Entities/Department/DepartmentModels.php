<?php

namespace App\Models\Entities\Department;

use App\Models\Entities\GenericEntitiesModel;

class DepartmentModels
{
    private readonly string $tableName;
    private readonly GenericEntitiesModel $_model;

    public function __construct(GenericEntitiesModel $model)
    {
        $this->_model = $model;
        $this->tableName = 'Department';
    }

    public function save(int $id, string $description): array
    {
        return $this->_model->save($this->tableName, [
            'id' => $id,
            'description' => $description
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

    public function set(array $value, array $conditions): array
    {
        return $this->_model->set(
            $this->tableName,
            $this->validateValues($value),
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
        return $condition;
    }

    private function validateValues(array $values): array
    {
        $value = [];
        if (isset($values['description'])) $value['description'] = $values['description'];
        return $value;
    }
}
