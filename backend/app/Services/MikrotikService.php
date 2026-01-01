<?php

namespace App\Services;

class MikrotikService
{
    public function ping(): bool
    {
        // TODO: Implement RouterOS API TLS connection test
        return true;
    }

    public function createPppoeSecret(array $data): void
    {
        // queue command to RouterOS
    }

    public function addStaticAddressList(array $data): void
    {
        // queue command to RouterOS
    }

    public function applySoftLimit(array $data): void {}
    public function applySuspend(array $data): void {}
    public function reactivate(array $data): void {}
}