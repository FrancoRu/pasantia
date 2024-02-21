<?php

namespace App\Controllers\Entities\Table;

use App\Helpers\messageConstructor;
use App\Models\Entities\Table\TableModels;

/**
 * Class TableControllers
 * 
 * This is the controller class for handling CRUD operations of Table entities
 * 
 * @package App\Controllers\Entities\Table
 */

class TableControllers
{
    /**
     * @var TableModels
     */
    private TableModels $_model;

    /**
     * @param TableModels $model the TableModels instance 
     */
    public function __construct(TableModels $model)
    {
        $this->_model = $model;
    }

    /**
     * Save a new table.
     *
     * @return array Result of the operation.
     */
    public function save(): array
    {
        if (!isset($_POST['id']) || !isset($_POST['description'])) {
            return messageConstructor::templateMessageResponse('fail', [
                'It is necessary to send the id, description to be added'
            ]);
        };

        return $this->_model->save($_POST['id'], $_POST['description']);
    }

    /**
     * Search table according to given conditions.
     *
     * @return array Result of the search operation.
     */
    public function find(): array
    {
        return $this->_model->find($_POST);
    }

    /**
     * Search table according to given conditions and procedure
     * 
     * @return array Result of the search operation
     */
    public function findTableByProcedure(): array
    {
        if (!isset($_POST['censo']) && !isset($_POST['department']) && !isset($_POST['theme']) && !isset($_POST['table'])) {
            return messageConstructor::templateMessageResponse('fail', [
                'When carrying out this operation, you should try to send the census data, department, topic and census table'
            ]);
        }
        $args = [
            'censo' => $_POST['censo'],
            'department' => $_POST['department'],
            'theme' => $_POST['theme'],
            'quadro' => $_POST['table']
        ];
        return $this->_model->findRecordTable($args);
    }

    /**
     * Updates table based on given values ​​and conditions.
     *
     * @return array Result of the update operation.
     */
    public function set(): array
    {
        if (!isset($_POST['values']) || !isset($_POST['conditions'])) {
            return messageConstructor::templateMessageResponse(
                'fail',
                ['It is necessary that you have the columns to modify and the conditions of the change']
            );
        }
        return $this->_model->set($_POST['values'], $_POST['conditions']);
    }

    /**
     * Eliminates tables according to given conditions.
     *
     * @return array Result of the delete operation.
     */
    public function delete(): array
    {
        if (!isset($_POST['conditions'])) {
            return messageConstructor::templateMessageResponse('fail', ['It is necessary that you have the conditions of the delete']);
        }
        return $this->_model->delete($_POST['conditions']);
    }
}
