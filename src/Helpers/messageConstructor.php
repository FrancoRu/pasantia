<?php

namespace App\Helpers;

/**
 * Class messageConstructor
 *
 * Helper class for constructing response messages with a standardized format.
 *
 * @package App\Helpers
 */
class messageConstructor
{
    /**
     * Create a template message response.
     *
     * @param string $status The status of the response (e.g., 'success', 'error').
     * @param array $message An array containing additional message details.
     * @param array|null $response An optional array containing response data.
     *
     * @return array The constructed message response with the specified format.
     */
    public static function templateMessageResponse(string $status, array $message, array $response = null): array
    {
        return [
            'status' => $status,
            'message' => $message,
            'response' => $response
        ];
    }
}
