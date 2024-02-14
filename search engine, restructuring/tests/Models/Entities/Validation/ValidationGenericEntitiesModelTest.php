<?php

namespace App\Tests\Models\Entities\Validation;

use PHPUnit\Framework\TestCase;
use App\Models\Entities\Validation\ValidationGenericEntitiesModel;

class ValidationGenericEntitiesModelTest extends TestCase
{
    /** @var ValidationGenericEntitiesModel */
    private $context;

    public function setUp(): void
    {
        $this->context = new ValidationGenericEntitiesModel();
    }

    public function testValidateValidTableName()
    {
        $result = $this->context->validateNameTable('MyTable');
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
    }

    public function testValidateInvalidTableName()
    {
        $result = $this->context->validateNameTable('@MyTable');
        $this->assertIsArray($result);
        $this->assertNotSame('ok', $result['status']);
    }

    public function testValidateAssociativeArrayValid()
    {
        $result = $this->context->validateArray(['id' => 5]);
        $this->assertIsArray($result);
        $this->assertSame('ok', $result['status']);
    }

    public function testValidateAssociativeArrayInvalid()
    {
        $result = $this->context->validateArray(['' => 5]);
        $this->assertIsArray($result);
        $this->assertNotSame('ok', $result['status']);
    }
}
