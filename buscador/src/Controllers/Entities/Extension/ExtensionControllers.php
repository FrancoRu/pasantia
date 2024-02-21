<?php

namespace App\Controllers\Entities\Extension;

use App\Models\Entities\Extension\ExtensionModels;

/**
 * Class ExtensionControllers
 * 
 * This is the controller class for handling CRUD operations of Extension entities
 * 
 * @package App\Controllers\Entities\Extension
 */

class ExtensionControllers
{
    /**
     * @var ExtensionModels
     */
    private ExtensionModels $_model;

    /**
     * @param ExtensionModels $model the ExtensionModels instance 
     */
    public function __construct(ExtensionModels $model)
    {
        $this->_model = $model;
    }

    /**
     * Save a new extension.
     *
     * @return array Result of the operation.
     */
    public function save(): array
    {
        if (!isset($_POST['id']) || !isset($_POST['description']) || !isset($_POST['extension'])) {
            return [
                'status' => 'fail',
                'message' => 'It is necessary to send the id, description and extension to be added'
            ];
        };

        return $this->_model->save($_POST['id'], $_POST['description'], $_POST['extension']);
    }

    /**
     * Search extensions according to given conditions.
     *
     * @return array Result of the search operation.
     */
    public function find(): array
    {
        return $this->_model->find($_POST);
    }

    /**
     * Updates extensions based on given values ​​and conditions.
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
     * Eliminates extensions according to given conditions.
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
