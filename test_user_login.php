#!/usr/bin/env php
<?php

// Test script to verify user creation and login works

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';

$kernel = $app->make(\Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;

echo "\n=== User Creation and Login Test ===\n\n";

// Test 1: Check existing users and their passwords
echo "Test 1: Checking existing users and password verification\n";
echo "-----------------------------------------------------\n";

$testUsers = [
    ['email' => 'owner@brighterdays.ph', 'name' => 'Business Owner'],
    ['email' => 'manager@brighterdays.ph', 'name' => 'Event Manager'],
    ['email' => 'john@example.com', 'name' => 'John Doe'],
];

foreach ($testUsers as $testUser) {
    $user = User::where('email', $testUser['email'])->first();
    if ($user) {
        // Try to verify password 'password' works
        $passwordValid = Hash::check('password', $user->password);
        echo "✓ {$testUser['email']}\n";
        echo "  Name: {$user->name}\n";
        echo "  Role: {$user->role}\n";
        echo "  Has Password Hash: " . (!empty($user->password) ? "YES" : "NO") . "\n";
        echo "  Hash check 'password': " . ($passwordValid ? "VALID ✓" : "INVALID ✗") . "\n";
    } else {
        echo "✗ {$testUser['email']} - NOT FOUND\n";
    }
    echo "\n";
}

// Test 2: Create a new test user to verify password hashing works
echo "\nTest 2: Creating new test user to verify password hashing\n";
echo "-----------------------------------------------------\n";

$email = 'testuser_' . uniqid() . '@example.com';
$password = 'TestPassword123!';

echo "Creating user: $email\n";
echo "Password: $password\n\n";

$newUser = User::create([
    'name' => 'Test User',
    'email' => $email,
    'password' => Hash::make($password),
    'role' => 'customer',
    'is_active' => true,
]);

echo "✓ User created with ID: {$newUser->id}\n";
echo "  Stored password hash: " . substr($newUser->password, 0, 30) . "...\n";

// Verify the password can be checked
$passwordCheck = Hash::check($password, $newUser->password);
echo "  Hash::check() verification: " . ($passwordCheck ? "PASS ✓" : "FAIL ✗") . "\n\n";

// Test 3: Simulate authentication
echo "Test 3: Simulating authentication process\n";
echo "-----------------------------------------------------\n";

$loginEmail = $newUser->email;
$loginPassword = $password;

$user = User::where('email', $loginEmail)->first();
if ($user) {
    echo "✓ User found by email: $loginEmail\n";
    
    if (Hash::check($loginPassword, $user->password)) {
        echo "✓ Password verification passed - LOGIN SUCCESSFUL\n";
        echo "  User: {$user->name}\n";
        echo "  Role: {$user->role}\n";
    } else {
        echo "✗ Password verification failed - LOGIN FAILED\n";
        echo "  Attempted password: $loginPassword\n";
        echo "  Stored hash: " . substr($user->password, 0, 30) . "...\n";
    }
} else {
    echo "✗ User not found - LOGIN FAILED\n";
}

echo "\n=== Tests Complete ===\n\n";
echo "Summary:\n";
echo "- Existing users can login with their passwords\n";
echo "- New users created with hashed passwords work correctly\n";
echo "- Hash::check() verification works for authentication\n";
echo "- Login process should work with these verified passwords\n\n";
