<?php

// namespace App\Tests\Models\Entities\Censo;

// use App\Enums\DatabaseType;
// use App\Models\Entities\Censo\CensoModels;
// use PHPUnit\Framework\TestCase;

// class CensoModelsTest extends TestCase
// {
//     /** @var CensoModels */
//     private $Model;
//     public function setUp(): void
//     {
//         $this->Model = new CensoModels(DatabaseType::MYSQL);
//     }

//     // //Test Save for CensoModel
//     // public function testOfSaveCensoModelsWithIdAndWithoutDescription(): void
//     // {
//     //     $result = $this->Model->save(2022);
//     //     $this->assertIsArray($result);
//     //     $this->assertSame('ok', $result['status']);
//     //     $this->assertSame(['Saved information successfully.'], $result['message']);
//     //     $this->assertNotNull($result);
//     // }

//     // public function testOfSaveCensoModelsWithIdAndWithDescription(): void
//     // {
//     //     $result = $this->Model->save(2023, 'Prueba de testing');
//     //     $this->assertIsArray($result);
//     //     $this->assertSame('ok', $result['status']);
//     //     $this->assertSame(['Saved information successfully.'], $result['message']);
//     //     $this->assertNotNull($result);
//     // }

//     //Test Find for CensoModel
//     public function testOfFindCensoModelWithSelectAndWithCondition(): void
//     {
//         $result = $this->Model->find(['select' => ['id' => 'id'], 'conditions' => ['id' => 2022]]);
//         $this->assertIsArray($result);
//         $this->assertSame('ok', $result['status']);
//         $this->assertSame(['Search completed successfully.'], $result['message']);
//         $this->assertNotNull($result['response']);
//     }

//     public function testOfFindCensoModelWithSelectAndWithoutCondition(): void
//     {
//         $result = $this->Model->find(['select' => ['id' => 'id']]);
//         $this->assertIsArray($result);
//         $this->assertSame('ok', $result['status']);
//         $this->assertSame(['Search completed successfully.'], $result['message']);
//         $this->assertNotNull($result['response']);
//     }

//     public function testOfFindCensoModelWithoutSelectAndWithCondition(): void
//     {
//         $result = $this->Model->find(['conditions' => ['id' => 2022]]);
//         $this->assertIsArray($result);
//         $this->assertSame('ok', $result['status']);
//         $this->assertSame(['Search completed successfully.'], $result['message']);
//         $this->assertNotNull($result['response']);
//     }

//     public function testOfFindCensoModelWithoutSelectAndWithoutCondition(): void
//     {
//         $result = $this->Model->find();
//         $this->assertIsArray($result);
//         $this->assertSame('ok', $result['status']);
//         $this->assertSame(['Search completed successfully.'], $result['message']);
//         $this->assertNotNull($result['response']);
//     }

//     public function testOfFindCensoModelWithException(): void
//     {
//         $result = $this->Model->find(['select' => []]);
//         $this->assertIsArray($result);
//         $this->assertSame('fail', $result['status']);
//         $this->assertSame(['The array cannot be empty.'], $result['message']);
//         $this->assertNull($result['response']);
//     }

//     //Test SET for CensoModels
// }
