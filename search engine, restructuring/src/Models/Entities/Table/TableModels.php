<?php

namespace App\Models\Entities\Table;

use App\Models\Entities\GenericEntitiesModel;

class TableModels
{
    private readonly string $tableName;
    private readonly GenericEntitiesModel $_model;

    public function __construct(GenericEntitiesModel $model)
    {
        $this->_model = $model;
        $this->tableName = 'Table';
    }

    public function save(int $id, string $description): array
    {
        return $this->_model->save($this->tableName, [
            'id' => $id,
            'description' => $description
        ]);
    }


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
    public function saveRecordTable(array $mixed): array
    {
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
