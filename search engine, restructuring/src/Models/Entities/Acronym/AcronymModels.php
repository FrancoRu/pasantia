<?php

namespace App\Models\Entities\Acronym;

use App\Models\Entities\GenericEntitiesModel;

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
        if (isset($conditions['acronym'])) $condition['acronym'] = $conditions['acronym'];
        return $condition;
    }

    private function validateValues(array $values): array
    {
        $value = [];
        if (isset($values['description'])) $value['description'] = $values['description'];
        if (isset($values['acronym'])) $value['acronym'] = $values['acronym'];
        return $value;
    }
}
