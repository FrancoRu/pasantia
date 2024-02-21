<?php

namespace App\Controllers\Entities\Acronym;

use App\Models\Entities\Acronym\AcronymModels;

/**
 * Class AcronymControllers
 * 
 * This is the controller class for handling CRUD operations of acronym entities
 * 
 * @package App\Controllers\Entities\Acronym
 */

class AcronymControllers
{
    /**
     * @var AcronymModels
     */

    private AcronymModels $_model;

    /**
     * 
     * @param AcronymModels $model the AcronymModels instance 
     * 
     */
    public function __construct(AcronymModels $model)
    {
        $this->_model = $model;
    }

    /**
     * Save a new acronym.
     *
     * @return array Result of the operation.
     */
    public function save(): array
    {
        if (!isset($_POST['id']) || !isset($_POST['description']) || !isset($_POST['acronym'])) {
            return [
                'status' => 'fail',
                'message' => 'It is necessary to send the id, description and acronym to be added'
            ];
        };

        return $this->_model->save($_POST['id'], $_POST['description'], $_POST['acronym']);
    }

    /**
     * Search acronyms according to given conditions.
     *
     * @return array Result of the search operation.
     */
    public function find(): array
    {
        return $this->_model->find($_POST);
    }

    /**
     * Updates acronyms based on given values ​​and conditions.
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
     * Eliminates acronyms according to given conditions.
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
