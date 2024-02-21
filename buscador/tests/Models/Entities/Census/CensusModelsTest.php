<?php

namespace App\Tests\Models\Entities\Census;

use App\Enums\DatabaseType;
use App\Models\Entities\Census\CensusModels;
use App\Models\Entities\GenericEntitiesModel;
use PHPUnit\Framework\TestCase;

class CensusModelsTest extends TestCase
{

    /** @var GenericEntitiesModel */
    private GenericEntitiesModel $_generic;

    /** @var CensusModels */
    private CensusModels $_model;

    public function setUp(): void
    {
        $this->_generic = new GenericEntitiesModel(DatabaseType::MYSQL);
        $this->_model = new CensusModels($this->_generic);
    }

    public function testSaveCensusWithInformationCorrect()
    {
        $result = $this->_model->save(2022);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        $result = $this->_model->save(2024);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
    }

    public function testFindCensusWithouthInformation()
    {
        $result = $this->_model->find();
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        print_r($result);
    }

    public function testFindCensusWithInformation()
    {
        $result = $this->_model->find(['conditions' => ['id' => 2024]]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        print_r($result);
    }


    public function testDeleteCensusWithId()
    {
        $result = $this->_model->delete(['id' => 2022]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        $result = $this->_model->delete(['id' => 2024]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
    }
}
