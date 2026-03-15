<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;

echo "=== Login Credential Validation ===\n\n";

// Test with newcustomer@example.com
echo "Testing: newcustomer@example.com\n";
$user = User::where('email', 'newcustomer@example.com')->first();

if ($user) {
    echo "✓ User found\n";
    echo "  ID: {$user->id}\n";
    echo "  Name: {$user->name}\n";
    echo "  Role: {$user->role}\n";
    echo "  Email Verified: " . ($user->email_verified_at ? 'YES' : 'NO') . "\n";
    echo "  Active: " . ($user->is_active ? 'YES' : 'NO') . "\n";
    echo "  Password Hash Exists: " . (!empty($user->password) ? 'YES' : 'NO') . "\n";
    
    // Test authentication
    echo "\nTesting password verification:\n";
    
    // Try with common test passwords
    $testPasswords = [
        'password',
        'newcustomer',
        'NewCustomer123!',
        'TestPassword123!',
    ];
    
    $foundPassword = false;
    foreach ($testPasswords as $pwd) {
        if (Hash::check($pwd, $user->password)) {
            echo "  ✓ Password match found: '{$pwd}'\n";
            $foundPassword = true;
        }
    }
    
    if (!$foundPassword) {
        echo "  ✗ None of the test passwords matched\n";
        echo "  Note: The password should have been set when the user was created\n";
    }
    
    // Try authentication
    echo "\nTesting authentication attempt:\n";
    $auth = auth()->attempt([
        'email' => 'newcustomer@example.com',
        'password' => 'password',
        'is_active' => true,
    ]);
    echo "  Result with 'password': " . ($auth ? 'SUCCESS' : 'FAILED') . "\n";
    
} else {
    echo "✗ User NOT found\n";
}

echo "\n=== All Active Users ===\n";
$allUsers = User::where('is_active', true)->get(['id', 'name', 'email', 'role']);
echo "Total active users: " . $allUsers->count() . "\n";
foreach ($allUsers as $u) {
    echo "  - {$u->email} (Role: {$u->role})\n";
}
