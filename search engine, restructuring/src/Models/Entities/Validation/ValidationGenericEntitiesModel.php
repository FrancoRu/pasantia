<?php

namespace App\Models\Entities\Validation;

class ValidationGenericEntitiesModel
{

    public static function validateNameTable(string $table): array
    {
        $response = ['status' => 'ok'];

        if (!is_string($table)) {
            $response['status'] = 'fail';
            $response['message'][] = 'Table must be string.';
        }

        if (strlen($table) == 0) {
            $response['status'] = 'fail';
            $response['message'][] = 'Table should not be empty.';
        }

        if (!preg_match('/^[a-zA-Z_][a-zA-Z0-9_]*$/', $table)) {
            $response['status'] = 'fail';
            $response['message'][] = 'Table name must be supported for sql.';
        }

        return $response;
    }

    public static function validateArray(array $mixed = null): array
    {
        $response = ['status' => 'ok'];

        if ($mixed === null || !is_array($mixed)) {
            $response['status'] = 'fail';
            $response['message'][] = "Must be a non-null array.";
            return $response;
        }

        if (empty($mixed)) {
            $response['status'] = 'fail';
            $response['message'][] = "The array cannot be empty.";
        }

        if (count($mixed) !== count(array_filter($mixed, function ($value) {
            return $value !== null;
        }))) {
            $response['status'] = 'fail';
            $response['message'][] = "The array cannot contain null values.";
        }

        if (count(array_filter(array_keys($mixed), 'is_string')) !== count($mixed)) {
            $response['status'] = 'fail';
            $response['message'][] = "The array must be associative.";
        }

        if (count(array_filter($mixed, 'is_array')) !== 0) {
            $response['status'] = 'fail';
            $response['message'][] = "The array cannot have subarrays.";
        }
        foreach ($mixed as $key => $value) {
            if (!preg_match('/^[a-zA-Z_][a-zA-Z0-9_]*$/', $key)) {
                $response['status'] = 'fail';
                $response['message'][] = "Invalid SQL column name: $key.";
            }
        }
        return $response;
    }

    public static function validateKeys(array $conditions = null, array $keyValues): array
    {
        $condition = [];
        foreach ($keyValues as $key) {
            if (isset($conditions[$key])) $condition[$key] = $conditions[$key];
        }
        return $condition;
    }
}
