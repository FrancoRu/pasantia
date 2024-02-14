<?php

// namespace App\Tests\Database;

// use App\Database\Interface\DatabaseAdapterInterface;
// use App\Database\DBManagerFactory;
// use PHPUnit\Framework\TestCase;

// class DBManagerFactoryTest extends TestCase
// {
//     private $factory;

//     public function setUp(): void
//     {
//         $this->factory = new DBManagerFactory();
//     }

//     public function FactoryTypeTest()
//     {
//         $this->assertInstanceOf(DBManagerFactory::class, $this->factory);
//     }

//     public function FactoryTypeReturnInterfaceDatabaseTest()
//     {
//         $instance = $this->factory->createDatabase('mysql');
//         $this->assertInstanceOf(DatabaseAdapterInterface::class, $instance);
//     }

//     public function testCreateUnsupportedDatabase()
//     {
//         $this->expectException(\Exception::class);
//         $this->expectExceptionMessage('Unsupported database type');
//         $this->factory->createDatabase('unsupported');
//     }
// }
