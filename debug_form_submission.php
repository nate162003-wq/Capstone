<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

echo "\n=== Debug: Form Submission Simulation ===\n\n";

// Simulate form data
$formData = [
    'name' => 'Test Customer',
    'email' => 'testcustomer_' . uniqid() . '@example.com',
    'password' => 'CustomPassword123',
    'password_confirmation' => 'CustomPassword123',
    'role' => 'customer',
    'profession' => '',
    'phone' => '09123456789',
    'address' => 'Test Address',
];

echo "Step 1: Validate form data (simulate controller validation)\n";
echo str_repeat("-", 70) . "\n";

// Validate like the controller does
$errors = [];

if (empty($formData['name'])) $errors['name'] = 'Name required';
if (empty($formData['email'])) $errors['email'] = 'Email required';
if (empty($formData['password'])) $errors['password'] = 'Password required';
if (strlen($formData['password']) < 8) $errors['password'] = 'Password must be at least 8 characters';
if ($formData['password'] !== $formData['password_confirmation']) $errors['password_confirmation'] = 'Passwords do not match';
if (!in_array($formData['role'], ['customer', 'event_manager', 'business_owner'])) $errors['role'] = 'Invalid role';

if ($errors) {
    echo "✗ Validation failed:\n";
    foreach ($errors as $field => $error) {
        echo "  $field: $error\n";
    }
    exit(1);
} else {
    echo "✓ Validation passed\n\n";
}

// Step 2: Create user (simulate controller store method)
echo "Step 2: Create user with hashed password\n";
echo str_repeat("-", 70) . "\n";

$validated = [
    'name' => $formData['name'],
    'email' => $formData['email'],
    'password' => Hash::make($formData['password']),
    'role' => $formData['role'],
    'profession' => $formData['profession'] ?: null,
    'phone' => $formData['phone'] ?: null,
    'address' => $formData['address'] ?: null,
    'email_verified_at' => now(),
];

echo "Creating user with:\n";
echo "  Name: {$validated['name']}\n";
echo "  Email: {$validated['email']}\n";
echo "  Password (hashed): " . substr($validated['password'], 0, 30) . "...\n";
echo "  Role: {$validated['role']}\n";
echo "  Email verified at: " . ($validated['email_verified_at'] ? $validated['email_verified_at']->format('Y-m-d H:i:s') : 'NULL') . "\n\n";

$user = User::create($validated);

echo "✓ User created\n";
echo "  User ID: {$user->id}\n";
echo "  In database - Email verified at: " . ($user->email_verified_at ? "YES ✓" : "NO ✗") . "\n\n";

// Step 3: Reload and check what's in database
echo "Step 3: Reload user from database and verify data\n";
echo str_repeat("-", 70) . "\n";

$reloaded = User::find($user->id);

echo "User data from database:\n";
echo "  Name: {$reloaded->name}\n";
echo "  Email: {$reloaded->email}\n";
echo "  Email verified: " . ($reloaded->email_verified_at ? "✓ YES" : "✗ NO") . "\n";
echo "  Role: {$reloaded->role}\n";
echo "  Password hash: " . substr($reloaded->password, 0, 30) . "...\n\n";

// Step 4: Try to login
echo "Step 4: Attempt login with submitted password\n";
echo str_repeat("-", 70) . "\n";

echo "Login attempt with:\n";
echo "  Email: {$formData['email']}\n";
echo "  Password: {$formData['password']}\n\n";

$canLogin = Auth::attempt([
    'email' => $formData['email'],
    'password' => $formData['password'],
]);

echo "Login result: " . ($canLogin ? "✓ SUCCESS" : "✗ FAILED") . "\n";

if ($canLogin) {
    $authUser = Auth::user();
    echo "Authenticated as: {$authUser->name}\n";
    echo "Role: {$authUser->role}\n";
    echo "Email verified: " . ($authUser->email_verified_at ? "✓ YES" : "✗ NO") . "\n\n";
    
    // Step 5: Check if middleware allows access
    echo "Step 5: Simulate middleware checks\n";
    echo str_repeat("-", 70) . "\n";
    
    // Check 1: User exists
    $userExists = User::find($authUser->id);
    echo "User exists in database: " . ($userExists ? "✓ YES" : "✗ NO") . "\n";
    
    // Check 2: Email verified
    echo "Email verified: " . ($authUser->email_verified_at ? "✓ YES" : "✗ NO") . "\n";
    
    // Check 3: Active status
    echo "User active: " . ($authUser->is_active ? "✓ YES" : "✗ NO") . "\n";
    
    if ($userExists && $authUser->email_verified_at) {
        echo "\n✓ User can access verified routes and dashboards\n";
    } else {
        echo "\n✗ User may be blocked from accessing dashboards\n";
        if (!$authUser->email_verified_at) {
            echo "  Reason: Email not verified\n";
        }
        if (!$userExists) {
            echo "  Reason: User doesn't exist\n";
        }
    }
    
    Auth::logout();
} else {
    // Debug why login failed
    echo "✗ Login failed\n\n";
    
    $checkUser = User::where('email', $formData['email'])->first();
    if ($checkUser) {
        echo "Debug info:\n";
        echo "  User found: YES\n";
        
        $passwordMatch = Hash::check($formData['password'], $checkUser->password);
        echo "  Password matches: " . ($passwordMatch ? "YES ✓" : "NO ✗") . "\n";
        
        echo "  Email verified: " . ($checkUser->email_verified_at ? "YES ✓" : "NO ✗") . "\n";
        echo "  Active: " . ($checkUser->is_active ? "YES" : "NO") . "\n";
        
        if ($passwordMatch && $checkUser->email_verified_at) {
            echo "\n  Note: Password and email are correct, but Auth::attempt failed\n";
            echo "  This might indicate a database driver issue or authentication guard issue\n";
        }
    } else {
        echo "User not found in database\n";
    }
}

echo "\n";
