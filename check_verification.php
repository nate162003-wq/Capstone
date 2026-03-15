<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\User;

echo "\n=== Email Verification Status ===\n\n";

$users = User::all(['id', 'name', 'email', 'email_verified_at', 'role']);

echo "ID | Name | Email | Verified At | Role\n";
echo str_repeat("-", 100) . "\n";

foreach ($users as $user) {
    $verified = $user->email_verified_at ? $user->email_verified_at->format('Y-m-d H:i') : "NOT VERIFIED";
    echo "{$user->id} | {$user->name} | {$user->email} | {$verified} | {$user->role}\n";
}

echo "\n";
echo "⚠️  If users show 'NOT VERIFIED', they may not be able to access dashboards\n";
echo "    that require the 'verified' middleware.\n\n";
