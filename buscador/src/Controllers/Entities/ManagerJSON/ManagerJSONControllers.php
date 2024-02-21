<?php

namespace App\Controllers\Entities\ManagerJSON;

use App\Models\Entities\ManagerJSON\ManagerJSONModels;

/**
 * Class ManagerJSONControllers
 *
 * This class acts as a handler for modeling JSON files in the application.
 *
 * @package App\Controllers\Entities\ManagerJSON
 */

class ManagerJSONControllers
{
    /**
     * @var ManagerJSONModels
     */
    private ManagerJSONModels $_model;

    /**
     * Constructor
     *
     * @param ManagerJSONModels $model The ManagerJSONModels instance
     */
    public function __construct(ManagerJSONModels $model)
    {
        $this->_model = $model;
    }


    /**
     * Update the public.json file with updated information from the database.
     */
    public function updateJSONFile(): void
    {
        /**
         * $data is the resulting associative arrangement of the information in the database
         * 
         * @var array 
         */
        $data = $this->_model->getData();

        $this->_model::writeJSON($data);
    }
}
