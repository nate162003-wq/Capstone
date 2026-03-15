<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

echo "\n=== Complete Login Test - All Roles ===\n\n";

// Test all existing users
$testUsers = [
    ['email' => 'owner@brighterdays.ph', 'password' => 'password', 'role' => 'business_owner', 'name' => 'Business Owner'],
    ['email' => 'manager@brighterdays.ph', 'password' => 'password', 'role' => 'event_manager', 'name' => 'Event Manager'],
    ['email' => 'john@example.com', 'password' => 'password', 'role' => 'customer', 'name' => 'John Doe'],
    ['email' => 'jane@example.com', 'password' => 'password', 'role' => 'customer', 'name' => 'Jane Smith'],
];

echo "Testing existing seeded users:\n";
echo str_repeat("=", 80) . "\n\n";

$allPassed = true;

foreach ($testUsers as $test) {
    echo "Testing: {$test['name']} ({$test['role']})\n";
    echo str_repeat("-", 80) . "\n";
    
    $user = User::where('email', $test['email'])->first();
    
    if (!$user) {
        echo "  ✗ User not found\n\n";
        $allPassed = false;
        continue;
    }
    
    // Check password
    $passwordOk = Hash::check($test['password'], $user->password);
    echo "  Password hash: " . ($passwordOk ? "✓ OK" : "✗ WRONG") . "\n";
    
    // Check email verified
    $emailVerified = $user->email_verified_at !== null;
    echo "  Email verified: " . ($emailVerified ? "✓ YES" : "✗ NO") . "\n";
    
    // Check active status
    $isActive = $user->is_active;
    echo "  Active status: " . ($isActive ? "✓ YES" : "✗ NO") . "\n";
    
    // Try authenticate
    $canAuth = Auth::attempt([
        'email' => $test['email'],
        'password' => $test['password'],
    ]);
    
    echo "  Authentication: " . ($canAuth ? "✓ SUCCESS" : "✗ FAILED") . "\n";
    
    if ($canAuth) {
        $authUser = Auth::user();
        echo "  Logged in as: {$authUser->name}\n";
        echo "  Role check: " . ($authUser->role === $test['role'] ? "✓ CORRECT" : "✗ WRONG") . "\n";
        Auth::logout();
    } else {
        $allPassed = false;
    }
    
    echo "\n";
}

// Test new user creation for each role
echo "\n=== Testing New User Creation for Each Role ===\n";
echo str_repeat("=", 80) . "\n\n";

$newRoles = ['customer', 'event_manager', 'business_owner'];

foreach ($newRoles as $role) {
    echo "Creating new {$role}:\n";
    echo str_repeat("-", 80) . "\n";
    
    $email = "new_{$role}_" . uniqid() . '@example.com';
    $password = 'NewPassword123!';
    
    $newUser = User::create([
        'name' => "New " . ucfirst(str_replace('_', ' ', $role)),
        'email' => $email,
        'password' => Hash::make($password),
        'role' => $role,
        'is_active' => true,
        'email_verified_at' => now(),
    ]);
    
    echo "  Created: {$newUser->name}\n";
    echo "  Email verified: " . ($newUser->email_verified_at ? "✓ YES" : "✗ NO") . "\n";
    
    $canLogin = Auth::attempt([
        'email' => $email,
        'password' => $password,
    ]);
    
    echo "  Can login: " . ($canLogin ? "✓ YES" : "✗ NO") . "\n";
    
    if ($canLogin) {
        $authUser = Auth::user();
        echo "  Verified: User {$authUser->name} logged in successfully\n";
        Auth::logout();
    } else {
        $allPassed = false;
    }
    
    echo "\n";
}

echo "\n=== Summary ===\n";
echo str_repeat("=", 80) . "\n";

if ($allPassed) {
    echo "✓ All tests passed!\n";
    echo "✓ Business Owners can login\n";
    echo "✓ Event Managers can login\n";
    echo "✓ Customers can login\n";
    echo "✓ New users can be created and login for all roles\n";
} else {
    echo "✗ Some tests failed - see above for details\n";
}

echo "\n";
