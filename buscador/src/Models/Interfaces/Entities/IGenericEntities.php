<?php

namespace App\Models\Interfaces\Entities;

/**
 * Interface IGenericEntities
 *
 * Interface defining common methods for handling generic entities in models.
 *
 * @package App\Models\Interfaces\Entities
 */
interface IGenericEntities
{
    /**
     * Save data to the specified table.
     *
     * @param string $table The name of the table.
     * @param array $args The values to be saved.
     *
     * @return array|string The result of the operation.
     */
    public function save(string $table, array $args): array | string;

    /**
     * Find records in the specified table based on conditions.
     *
     * @param string $table The name of the table.
     * @param array|null $mixed The selection and condition criteria.
     *
     * @return array|string The result of the operation.
     */
    public function find(string $table, array $mixed = null): array | string;

    /**
     * Update records in the specified table.
     *
     * @param string $table The name of the table.
     * @param array $values The values to be updated.
     * @param array $conditions The conditions for the update.
     *
     * @return array|string The result of the operation.
     */
    public function set(string $table, array $values, array $conditions): array | string;

    /**
     * Delete records from the specified table based on conditions.
     *
     * @param string $table The name of the table.
     * @param array $conditions The conditions for deletion.
     *
     * @return array|string The result of the operation.
     */
    public function delete(string $table, array $conditions): array | string;

    /**
     * Get the last inserted ID from the specified table.
     *
     * @param string $table The name of the table.
     *
     * @return array|string The result of the operation.
     */
    public function lastId(string $table): array | string;
}
