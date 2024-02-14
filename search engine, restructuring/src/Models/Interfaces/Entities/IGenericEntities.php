<?php

namespace App\Models\Interfaces\Entities;

interface IGenericEntities
{
    public function save(string $table, array $args): array | string;
    public function find(string $table, array $mixed = null): array | string;
    public function set(string $table, array $values, array $conditions): array | string;
    public function delete(string $table, array $conditions): array | string;
    public function lastId(string $table): array | string;
}
