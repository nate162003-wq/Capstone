<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\Hash;
use App\Models\User;

echo "\n=== User Login Test ===\n\n";

// Test each user with default password 'password'
$testEmails = [
    'owner@brighterdays.ph',
    'manager@brighterdays.ph',
    'john@example.com',
    'jane@example.com',
];

echo "Testing login with password 'password' for existing users:\n";
echo str_repeat("-", 80) . "\n\n";

foreach ($testEmails as $email) {
    $user = User::where('email', $email)->first();
    
    if (!$user) {
        echo "✗ {$email} - USER NOT FOUND\n";
        continue;
    }
    
    $passwordValid = Hash::check('password', $user->password);
    
    echo "User: {$user->name}\n";
    echo "Email: {$email}\n";
    echo "Role: {$user->role}\n";
    echo "Can login with 'password': " . ($passwordValid ? "✓ YES" : "✗ NO") . "\n";
    echo "Password hash starts with: " . substr($user->password, 0, 20) . "...\n";
    echo "\n";
}
