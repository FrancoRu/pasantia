<?php

namespace App\Helpers;

class messageConstructor
{
    public static function templateMessageResponse(string $status, array $message, array $response = null): array
    {
        return [
            'status' => $status,
            'message' => $message,
            'response' => $response
        ];
    }
}
