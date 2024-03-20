<?php

namespace App\Models\Entities\ManagerJSON;

use App\Models\Entities\GenericEntitiesModel;

/**
 * Class ManagerJSONModels
 *
 * Model class for managing JSON data and generating a structured array from the database results.
 *
 * @package App\Models\Entities\ManagerJSON
 */
class ManagerJSONModels
{
    /**
     * @var GenericEntitiesModel The generic entities model for database operations.
     */
    private GenericEntitiesModel $_model;

    /**
     * ManagerJSONModels constructor.
     *
     * @param GenericEntitiesModel $model The generic entities model for database operations.
     */
    public function __construct(GenericEntitiesModel $model)
    {
        $this->_model = $model;
    }

    /**
     * Retrieve and process data from the database to generate a structured array.
     *
     * @return array The structured array containing information about censos, departments, themes, and tables.
     */
    public function getData(): array
    {
        $result = $this->_model->callProcedure('getInfoJSON');


        $data = [];
        $data['censos'] = [];

        $lastYear = null;
        $lastDepartment = null;
        $lastTheme = null;
        foreach ($result['response'] as $row) {

            $procces = $this->processYear($row, $lastYear);
            if (is_array($procces)) {
                $data['censos'][] = $procces;
                $lastYear = $row['Censo_id'];
                $lastDepartment = null;
            }

            $indexYear = $this->searchIndex($row['Censo_id'], $data['censos'], 'id');

            $procces = $this->processDepartment($row, $lastDepartment);
            if (is_array($procces)) {
                $data['censos'][$indexYear]['departments'][] = $procces;
                $lastDepartment = $row['Department_id'];
                $lastTheme = null;
            }

            $indexDepartment = $this->searchIndex($row['Department_id'], $data['censos'][$indexYear]['departments'], 'id');

            $procces = $this->processTheme($row, $lastTheme);
            if (is_array($procces)) {
                $data['censos'][$indexYear]['departments'][$indexDepartment]['themes'][] = $procces;
                $lastTheme = $row['Theme_id'];
            }

            $indexTheme = $this->searchIndex($row['Theme_id'], $data['censos'][$indexYear]['departments'][$indexDepartment]['themes'], 'id');


            $procces = $this->verifyQuadro($row, $data, $indexYear, $indexDepartment, 0);
            if (is_array($procces)) {
                $data['censos'][$indexYear]['departments'][$indexDepartment]['themes'][0]['tables'][] = $procces;
            }

            $procces = $this->verifyQuadro($row, $data, $indexYear, 0, 0);
            if (is_array($procces)) {
                $data['censos'][$indexYear]['departments'][0]['themes'][0]['tables'][] = $procces;
            }

            $procces = $this->verifyQuadro($row, $data, $indexYear, $indexDepartment, $indexTheme);
            if (is_array($procces)) {
                $data['censos'][$indexYear]['departments'][$indexDepartment]['themes'][$indexTheme]['tables'][] = $procces;
            }

            isset($data['censos'][$indexYear]['departments'][0]['themes'][$indexTheme]) ||
                $data['censos'][$indexYear]['departments'][0]['themes'][] = $this->processTheme($row);


            $procces = $this->verifyQuadro($row, $data, $indexYear, 0, $indexTheme);
            if (is_array($procces)) {
                $data['censos'][$indexYear]['departments'][0]['themes'][$indexTheme]['tables'][] = $procces;
            }
        }
        return $data;
    }


    /**
     * Process the year information for the structured array.
     *
     * @param array $row The database row representing the year.
     * @param int|null $lastYear The ID of the last processed year.
     *
     * @return array|bool The processed element for the structured array or false if it's a duplicate year.
     */
    private function processYear(array $row, int $lastYear = null): array | bool
    {
        if ($lastYear == $row['Censo_id']) {
            return false;
        }

        $newElement = [
            'value' => $row['Censo_description'],
            'id' => $row['Censo_id'],
            'departments' => [
                [
                    'value' => 'Todos',
                    'id' => 'T',
                    'themes' => [
                        [
                            'value' => 'Todos',
                            'id' => 'T',
                            'tables' => [
                                [
                                    'value' => 'Todos',
                                    'id' => 'T'
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ];

        return $newElement;
    }

    /**
     * Process the department information for the structured array.
     *
     * @param array $row The database row representing the department.
     * @param int|null $lastDepartment The ID of the last processed department.
     *
     * @return array|bool The processed element for the structured array or false if it's a duplicate department.
     */
    private function processDepartment(array $row, int $lastDepartment = null): array | bool
    {
        if ($lastDepartment == $row['Department_id']) {
            return false;
        }

        $newElement = [

            'value' => $row['Department_description'],
            'id' => $row['Department_id'],
            'themes' => [
                [
                    'value' => 'Todos',
                    'id' => 'T',
                    'tables' => [
                        [
                            'value' => 'Todos',
                            'id' => 'T'
                        ]
                    ]
                ]
            ]

        ];
        return $newElement;
    }

    /**
     * Process the theme information for the structured array.
     *
     * @param array $row The database row representing the theme.
     * @param string|null $lastTheme The ID of the last processed theme.
     *
     * @return array|bool The processed element for the structured array or false if it's a duplicate theme.
     */
    private function processTheme(array $row, string $lastTheme = null): array | bool
    {

        if ($lastTheme == $row['Theme_id']) {
            return false;
        }

        $newElement = [
            'value' => $row['Theme_description'],
            'id' => $row['Theme_id'],
            'tables' => [
                [
                    'value' => 'Todos',
                    'id' => 'T'
                ]
            ]
        ];

        return $newElement;
    }

    /**
     * Verify and process the quadro (table) information for the structured array.
     *
     * @param array $row The database row representing the quadro.
     * @param array $data The existing structured array data.
     * @param int $indexYear The index of the current year.
     * @param int $indexDepartment The index of the current department.
     * @param int $indexTheme The index of the current theme.
     *
     * @return array if the table to be added does not exist within the given structure.
     * @return false if the table to be added already exists within the given structure
     */
    private function verifyQuadro(array $row, array $data, int $indexYear, int $indexDepartment, int $indexTheme): array | false
    {
        $values = array_column($data['censos'][$indexYear]['departments'][$indexDepartment]['themes'][$indexTheme]['tables'], 'value');

        if (in_array($row['Table_description'], $values)) {
            return false;
        }
        return [
            'value' => $row['Table_description'],
            'id' => $row['Table_id']
        ];
    }


    /**
     * Write the structured array data to a JSON file.
     *
     * @param array $data The structured array data to be written to the JSON file.
     *
     * @return void
     */
    public static function writeJSON(array $data): void
    {
        $filePath = '../../public.json';
        if ($file = fopen($filePath, 'w')) {
            fwrite($file, json_encode($data, JSON_UNESCAPED_UNICODE));

            fclose($file);
        } else {
            echo "No se pudo abrir o crear el archivo $filePath";
        }
        echo json_encode($data);
    }

    /**
     * Find the index of a value and a property passed by parameters
     * 
     * @param $needle is the value to search for, it can be a string or an int
     * @param $haystack is the arrangement where to look for the index
     * @param $prop is the name of the property to search (optional), if it is 
     *  null then it will be searched by only the value, if it is not null it will 
     *  be searched by associative name
     * 
     * @return false if the passed value is not found
     * @return int if the passed value is found, it returns the index
     */
    private function searchIndex(string | int $needle, array $haystack, string $prop = null): int|false
    {
        foreach ($haystack as $index => $element) {
            if ($prop !== null && isset($element[$prop]) && $element[$prop] === $needle) {
                return $index;
            } else if ($prop === null && $element === $needle) {
                return $index;
            }
        }
        return false;
    }
}
