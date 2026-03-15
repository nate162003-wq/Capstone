<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;

echo "=== Test Users (All should work) ===\n\n";

$testUsers = [
    ['email' => 'john@example.com', 'password' => 'password'],
    ['email' => 'jane@example.com', 'password' => 'password'],
    ['email' => 'manager@brighterdays.ph', 'password' => 'password'],
    ['email' => 'owner@brighterdays.ph', 'password' => 'password'],
];

foreach ($testUsers as $creds) {
    $user = User::where('email', $creds['email'])->first();
    if ($user) {
        $result = auth()->attempt($creds);
        echo ($result ? '✓' : '✗') . " {$creds['email']} - " . ($result ? 'CAN LOGIN' : 'CANNOT LOGIN') . "\n";
        if ($result) {
            auth()->logout();
        }
    } else {
        echo "✗ {$creds['email']} - NOT FOUND\n";
    }
}

echo "\n=== beranahomer20@gmail.com (Your account) ===\n";
$user = User::where('email', 'beranahomer20@gmail.com')->first();
if ($user) {
    echo "Email verified: " . ($user->email_verified_at ? 'YES' : 'NO') . "\n";
    echo "Active: " . ($user->is_active ? 'YES' : 'NO') . "\n";
    
    $result = auth()->attempt([
        'email' => 'beranahomer20@gmail.com',
        'password' => 'password'
    ]);
    echo "Can login: " . ($result ? 'YES' : 'NO') . "\n";
    if ($result) {
        auth()->logout();
    }
}
