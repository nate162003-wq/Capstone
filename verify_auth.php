<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;

echo "=== Verifying beranahomer20@gmail.com ===\n\n";

$user = User::where('email', 'beranahomer20@gmail.com')->first();

if (!$user) {
    echo "✗ User not found\n";
    exit;
}

echo "User found: {$user->name}\n";
echo "Email: {$user->email}\n";
echo "Email verified: " . ($user->email_verified_at ? 'YES' : 'NO') . "\n";
echo "Active: " . ($user->is_active ? 'YES' : 'NO') . "\n";
echo "Password hash: " . substr($user->password, 0, 30) . "...\n\n";

// Test password
$testPassword = 'testpassword123';
echo "Testing authentication with '{$testPassword}':\n";

$result = auth()->attempt([
    'email' => 'beranahomer20@gmail.com',
    'password' => $testPassword,
]);

echo "Result: " . ($result ? '✓ SUCCESS' : '✗ FAILED') . "\n\n";

if ($result) {
    echo "✓ User authenticated!\n";
    echo "Authenticated as: " . auth()->user()->email . "\n";
    auth()->logout();
} else {
    echo "✗ Authentication failed\n";
    echo "Checking password hash...\n";
    $hashCheck = Hash::check($testPassword, $user->password);
    echo "Hash matches: " . ($hashCheck ? 'YES' : 'NO') . "\n";
    
    if (!$hashCheck) {
        echo "\nPassword mismatch - resetting to 'password'...\n";
        $user->password = Hash::make('password');
        $user->save();
        echo "✓ Password reset to 'password'\n";
        
        // Test again
        $result2 = auth()->attempt([
            'email' => 'beranahomer20@gmail.com',
            'password' => 'password',
        ]);
        echo "Test with 'password': " . ($result2 ? '✓ SUCCESS' : '✗ FAILED') . "\n";
    }
}
