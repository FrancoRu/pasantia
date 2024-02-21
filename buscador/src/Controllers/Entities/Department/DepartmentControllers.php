<?php

namespace App\Controllers\Entities\Department;

use App\Models\Entities\Department\DepartmentModels;

/**
 * Class DepartmentControllers
 * 
 * This is the controller class for handling CRUD operations of Department entities
 * 
 * @package App\Controllers\Entities\Department
 */

class DepartmentControllers
{
    /**
     * @var DepartmentModels
     */
    private DepartmentModels $_model;

    /**
     * @param DepartmentModels $model the DepartmentModels instance 
     */
    public function __construct(DepartmentModels $model)
    {
        $this->_model = $model;
    }

    /**
     * Save a new department.
     *
     * @return array Result of the operation.
     */
    public function save(): array
    {
        if (!isset($_POST['id']) || !isset($_POST['description'])) {
            return [
                'status' => 'fail',
                'message' => 'It is necessary to send the id, description to be added'
            ];
        };

        return $this->_model->save($_POST['id'], $_POST['description']);
    }

    /**
     * Search department according to given conditions.
     *
     * @return array Result of the search operation.
     */
    public function find(): array
    {
        return $this->_model->find($_POST);
    }

    /**
     * Updates department based on given values ​​and conditions.
     *
     * @return array Result of the update operation.
     */
    public function set(): array
    {
        if (!isset($_POST['values']) || !isset($_POST['conditions'])) {
            return [
                'status' => 'fail',
                'message' => ['It is necessary that you have the columns to modify and the conditions of the change']
            ];
        }
        return $this->_model->set($_POST['values'], $_POST['conditions']);
    }

    /**
     * Eliminates department according to given conditions.
     *
     * @return array Result of the delete operation.
     */
    public function delete(): array
    {
        if (!isset($_POST['conditions'])) {
            return [
                'status' => 'fail',
                'message' => ['It is necessary that you have the conditions of the delete']
            ];
        }
        return $this->_model->delete($_POST['conditions']);
    }
}
