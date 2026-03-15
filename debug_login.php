<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

echo "\n=== Detailed Login Test ===\n\n";

// Create a test user
echo "Creating test user...\n";
$testUser = User::create([
    'name' => 'Login Test User',
    'email' => 'logintest_' . uniqid() . '@example.com',
    'password' => Hash::make('TestPassword123'),
    'role' => 'customer',
    'is_active' => true,
]);

echo "✓ Test user created\n";
echo "  ID: {$testUser->id}\n";
echo "  Email: {$testUser->email}\n";
echo "  Password hash: " . substr($testUser->password, 0, 20) . "...\n\n";

// Test 1: Direct password check
echo "Test 1: Direct Hash::check() verification\n";
echo str_repeat("-", 60) . "\n";
$passwordCheck = Hash::check('TestPassword123', $testUser->password);
echo "Hash::check('TestPassword123', hash): " . ($passwordCheck ? "✓ PASS" : "✗ FAIL") . "\n\n";

// Test 2: Reload user and check password
echo "Test 2: Reload user from database and verify password\n";
echo str_repeat("-", 60) . "\n";
$reloadedUser = User::find($testUser->id);
echo "User reloaded from DB: {$reloadedUser->name}\n";
echo "Password hash starts with: " . substr($reloadedUser->password, 0, 20) . "...\n";
$passwordCheck2 = Hash::check('TestPassword123', $reloadedUser->password);
echo "Hash::check() result: " . ($passwordCheck2 ? "✓ PASS" : "✗ FAIL") . "\n\n";

// Test 3: Simulate authentication attempt using credentials
echo "Test 3: Try to authenticate using credentials\n";
echo str_repeat("-", 60) . "\n";

$credentials = [
    'email' => $testUser->email,
    'password' => 'TestPassword123',
];

echo "Attempting login with:\n";
echo "  Email: {$credentials['email']}\n";
echo "  Password: {$credentials['password']}\n\n";

$authenticated = Auth::attempt($credentials);
echo "Auth::attempt() result: " . ($authenticated ? "✓ SUCCESS" : "✗ FAILED") . "\n";

if ($authenticated) {
    $authUser = Auth::user();
    echo "✓ Authenticated user: {$authUser->name} ({$authUser->email})\n";
    Auth::logout();
} else {
    echo "✗ Authentication failed\n";
    
    // Try to find user
    $findUser = User::where('email', $credentials['email'])->first();
    if ($findUser) {
        echo "\nDebugging info:\n";
        echo "  User found: YES\n";
        echo "  User active: " . ($findUser->is_active ? "YES" : "NO") . "\n";
        echo "  Password in DB: " . substr($findUser->password, 0, 20) . "...\n";
        echo "  Direct hash check: " . (Hash::check($credentials['password'], $findUser->password) ? "PASS" : "FAIL") . "\n";
    } else {
        echo "  User not found in database\n";
    }
}

echo "\n";

// Test 4: Test with existing known user
echo "Test 4: Test with existing known user (manager@brighterdays.ph)\n";
echo str_repeat("-", 60) . "\n";

$knownUser = User::where('email', 'manager@brighterdays.ph')->first();
if ($knownUser) {
    echo "Found user: {$knownUser->name}\n";
    
    $knownCreds = [
        'email' => 'manager@brighterdays.ph',
        'password' => 'password',
    ];
    
    $knownAuth = Auth::attempt($knownCreds);
    echo "Auth attempt with 'password': " . ($knownAuth ? "✓ SUCCESS" : "✗ FAILED") . "\n";
    
    if ($knownAuth) {
        Auth::logout();
    }
} else {
    echo "User not found\n";
}

echo "\n=== Tests Complete ===\n\n";
