<?php

require __DIR__ . '/vendor/autoload.php';
$app = require __DIR__ . '/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

$themes = App\Models\Theme::query()
    ->latest()
    ->take(20)
    ->get(['id', 'user_id', 'name', 'status', 'image_url', 'generated_images', 'ai_metadata', 'created_at']);

echo 'count=' . $themes->count() . PHP_EOL;

foreach ($themes as $theme) {
    $firstGenerated = is_array($theme->generated_images) && count($theme->generated_images) > 0 ? $theme->generated_images[0] : null;
    $metadataKeys = is_array($theme->ai_metadata) ? implode(',', array_keys($theme->ai_metadata)) : 'NULL';
    echo sprintf(
        "id=%d | user=%d | status=%s | image_url=%s | first_generated=%s | metadata_keys=%s\n",
        $theme->id,
        $theme->user_id,
        $theme->status,
        $theme->image_url ?: 'NULL',
        $firstGenerated ?: 'NULL',
        $metadataKeys
    );
}
