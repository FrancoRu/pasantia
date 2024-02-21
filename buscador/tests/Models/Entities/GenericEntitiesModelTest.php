<?php

namespace App\Tests\Models\Entities;

use App\Enums\DatabaseType;
use App\Models\Entities\GenericEntitiesModel;
use PHPUnit\Framework\TestCase;

class GenericEntitiesModelTest extends TestCase
{
    /** @var GenericEntitiesModel */
    private $Model;

    protected function setUp(): void
    {
        $this->Model = new GenericEntitiesModel(DatabaseType::MYSQL);
    }

    // Test for SAVE information
    public function testOfSaveInformation(): void
    {
        $result = $this->Model->save('persona', ['id' => 4, 'nombre' => 'pedro']);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        $this->assertSame(['Saved information successfully.'], $result['message']);
    }

    public function testOfSaveInformationWithExistingRecords(): void
    {
        $result = $this->Model->save('persona', ['id' => 1, 'nombre' => 'franco']);
        $this->assertIsArray($result);
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['Existing record'], $result['message']);
        $this->assertNull($result['response']);
    }

    public function testOfSaveInformationWithoutID(): void
    {
        $result = $this->Model->save('persona', ['nombre' => 'franco']);
        $this->assertIsArray($result);
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['When saving, an ID is always required to be sent.'], $result['message']);
        $this->assertNull($result['response']);
    }

    //Test for FIND information
    public function testOfFindInformationWithConditionsAndWithoutSelect(): void
    {
        $result = $this->Model->find('persona', [
            'conditions' => [
                'id' => 1
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'conditions' => [
                'nombre' => 'franco'
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'conditions' => [
                'id' => 5,
                'nombre' => 'franco'
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'conditions' => [
                'id' => 10,
                'nombre' => 'frco'
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
    }

    public function testOfFindInformationWithoutConditionsAndWithSelect(): void
    {
        $result = $this->Model->find('persona', [
            'select' => ['id' => 'id'],
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'select' => ['nombre' => 'nombre'],
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'select' => ['id' => 'id', 'nombre' => 'nombre'],
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
    }

    public function testOfFindInformationWithConditionsAndWithSelect(): void
    {
        $result = $this->Model->find('persona', [
            'select' => ['id' => 'id', 'nombre' => 'nombre'],
            'conditions' => [
                'id' => 5,
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'select' => ['id' => 'id', 'nombre' => 'nombre'],
            'conditions' => [
                'id' => 5,
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'select' => ['id' => 'id', 'nombre' => 'nombre'],
            'conditions' => [
                'id' => 5,
                'nombre' => 'franco'
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);

        $result = $this->Model->find('persona', [
            'select' => ['nombre' => 'nombre'],
            'conditions' => [
                'id' => 5,
            ]
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
    }

    public function testOfFindInformationWithoutConditionsAndWithoutSelect(): void
    {
        $result = $this->Model->find('persona');
        $this->assertIsArray($result);
    }

    public function testOfFindInformationWithException(): void
    {
        $result = $this->Model->find('persona', ['select' => []]);
        $this->assertIsArray($result);
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['The array cannot be empty.'], $result['message']);

        $result = $this->Model->find('persona', [
            '' => []
        ]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        $this->assertSame(['Search completed successfully.'], $result['message']);

        $result = $this->Model->find('persona', [
            'select' => []
        ]);
        $this->assertIsArray($result);
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['The array cannot be empty.'], $result['message']);
    }

    //Test for SET information
    public function testOfSetWithInformationCorrect(): void
    {
        $result = $this->Model->set('persona', ['nombre' => 'Thiago'], ['id' => 5]);
        $this->assertIsArray($result, "It is expected to return an array of the form ['status' => value, 'message' => value (optional)]");
        $this->assertSame('ok', $result['status']);
    }


    public function testOfSetWithInformationIncorrect(): void
    {
        $result = $this->Model->set('@persona', ['nombre' => 'Thiago'], ['id' => 5]);
        $this->assertIsArray($result, "It is expected to return an array of the form ['status' => value, 'message' => value (optional)], 'response' => response of type Array | null");
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['Table name must be supported for sql.'], $result['message']);

        $result = $this->Model->set('', ['nombre' => 'Thiago'], ['id' => 5]);
        $this->assertIsArray($result, "It is expected to return an array of the form ['status' => value, 'message' => value (optional)], 'response' => response of type Array | null");
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['Table should not be empty.', 'Table name must be supported for sql.'], $result['message']);

        $result = $this->Model->set('', ['nombre' => 'Thiago'], []);
        $this->assertIsArray($result, "It is expected to return an array of the form ['status' => value, 'message' => value (optional)], 'response' => response of type Array | null");
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['Table should not be empty.', 'Table name must be supported for sql.'], $result['message']);

        $result = $this->Model->set('peddro', ['nombre' => 'Thiago'], []);
        $this->assertIsArray($result, "It is expected to return an array of the form ['status' => value, 'message' => value (optional)], 'response' => response of type Array | null");
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['The array cannot be empty.'], $result['message']);

        $result = $this->Model->set('peddro', ['nombre' => 'Thiago'], ['pedro']);
        $this->assertIsArray($result, "It is expected to return an array of the form ['status' => value, 'message' => value (optional)], 'response' => response of type Array | null");
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['The array must be associative.', 'Invalid SQL column name: 0.'], $result['message']);

        $result = $this->Model->set('peddro', ['nombre' => 'Thiago'], [1 => 'pedro', '@e' => 'hodor']);
        $this->assertIsArray($result, "It is expected to return an array of the form ['status' => value, 'message' => value (optional)], 'response' => response of type Array | null");
        $this->assertSame('fail', $result['status']);
        $this->assertSame(['The array must be associative.', 'Invalid SQL column name: 1.', 'Invalid SQL column name: @e.'], $result['message']);
    }

    //Test for DELETE information

    public function testOfDeleteWithConditionCorrect(): void
    {
        $result =  $this->Model->delete('persona', ['id' => 4]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        //Even if there are no records, it will return 'OK' as long as the parameters and the table name are correct.
        $this->assertSame(['Records successfully deleted.'], $result['message']);
        // print_r($result);
    }

    public function testOfDeleteWithCoonditionNotExists(): void
    {
        $result =  $this->Model->delete('persona', ['id' => 5]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
        //Even if there are no records, it will return 'OK' as long as the parameters and the table name are correct.
        $this->assertSame(['Records successfully deleted.'], $result['message']);
        // print_r($result);
    }
}
