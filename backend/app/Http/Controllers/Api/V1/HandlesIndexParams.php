<?php

namespace App\Http\Controllers\Api\V1;

trait HandlesIndexParams
{
    protected function perPage(): int
    {
        return max(1, min((int) request('per_page', 10), 100));
    }

    /**
     * sort: ?sort=campo  o ?sort=-campo (desc)
     */
    protected function sortParams(array $allowed, string $default = 'id'): array
    {
        $sort = (string) request('sort', $default);
        $dir  = str_starts_with($sort, '-') ? 'desc' : 'asc';
        $col  = ltrim($sort, '-');
        if (!in_array($col, $allowed, true)) $col = $default;
        return [$col, $dir];
    }
}
