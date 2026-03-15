<?php

require __DIR__ . '/vendor/autoload.php';
$app = require __DIR__ . '/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

$start = microtime(true);
$data = app(App\Services\ChartAnalyticsService::class)->getCustomerDemographics();

echo 'age_groups=' . count($data['by_age_group']) . PHP_EOL;
echo 'event_types=' . count($data['by_event_type']) . PHP_EOL;
echo 'elapsed=' . round(microtime(true) - $start, 3) . 's' . PHP_EOL;
