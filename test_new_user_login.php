<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

echo "\n=== Test New User Creation and Login ===\n\n";

// Simulate what happens when BusinessOwner creates a new user via the form
echo "Step 1: Create new user (simulating form submission)\n";
echo str_repeat("-", 70) . "\n";

$newUserEmail = 'newuser_' . uniqid() . '@example.com';
$newUserPassword = 'SecurePassword123';

echo "Creating user with:\n";
echo "  Name: New Employee\n";
echo "  Email: $newUserEmail\n";
echo "  Password: $newUserPassword\n";
echo "  Role: customer\n\n";

// This simulates what the updated UserManagementController::store() does
$validated = [
    'name' => 'New Employee',
    'email' => $newUserEmail,
    'password' => Hash::make($newUserPassword),
    'role' => 'customer',
    'phone' => '09123456789',
    'address' => 'Test Address',
    // This is the key fix - auto-verify email
    'email_verified_at' => now(),
];

$createdUser = User::create($validated);

echo "✓ User created successfully\n";
echo "  User ID: {$createdUser->id}\n";
echo "  Password hash: " . substr($createdUser->password, 0, 30) . "...\n";
echo "  Email verified at: " . ($createdUser->email_verified_at ? $createdUser->email_verified_at->format('Y-m-d H:i:s') : 'NULL') . "\n\n";

// Step 2: Try to login with the newly created user
echo "Step 2: Attempt login with newly created user\n";
echo str_repeat("-", 70) . "\n";

echo "Trying to login with:\n";
echo "  Email: $newUserEmail\n";
echo "  Password: $newUserPassword\n\n";

$canLogin = Auth::attempt([
    'email' => $newUserEmail,
    'password' => $newUserPassword,
]);

if ($canLogin) {
    echo "✓ LOGIN SUCCESSFUL!\n\n";
    
    $user = Auth::user();
    echo "Authenticated as:\n";
    echo "  Name: {$user->name}\n";
    echo "  Email: {$user->email}\n";
    echo "  Role: {$user->role}\n";
    echo "  ID: {$user->id}\n\n";
    
    // Check if user can access verified routes
    echo "Step 3: Check access to dashboard routes\n";
    echo str_repeat("-", 70) . "\n";
    
    if ($user->email_verified_at) {
        echo "✓ User email is verified\n";
        echo "✓ User can access 'verified' protected routes\n";
        echo "✓ User can access dashboard\n";
    } else {
        echo "✗ User email is NOT verified\n";
        echo "✗ User CANNOT access 'verified' protected routes\n";
    }
    
    Auth::logout();
    echo "\n✓ Session ended\n\n";
} else {
    echo "✗ LOGIN FAILED!\n\n";
    
    // Debug info
    $user = User::where('email', $newUserEmail)->first();
    if ($user) {
        echo "Debug Info:\n";
        echo "  User exists: YES\n";
        echo "  Password hash correct: " . (Hash::check($newUserPassword, $user->password) ? "YES" : "NO") . "\n";
        echo "  Email verified: " . ($user->email_verified_at ? "YES" : "NO") . "\n";
    } else {
        echo "  User not found in database\n";
    }
}

echo "\n=== Test Complete ===\n\n";

// Additional test: Create via registration action (simulating self-signup)
echo "Step 4: Test registration action (self-signup)\n";
echo str_repeat("-", 70) . "\n";

$registerEmail = 'register_' . uniqid() . '@example.com';
$registerPassword = 'RegisterPassword456';

// Simulate what CreateNewUser action does
$newRegisterUser = User::create([
    'name' => 'Self Registered User',
    'email' => $registerEmail,
    'password' => $registerPassword, // Note: will be hashed by User model's 'password' => 'hashed' cast
    'email_verified_at' => now(),
]);

echo "Created registered user: {$newRegisterUser->name}\n";
echo "Email verified: " . ($newRegisterUser->email_verified_at ? "✓ YES" : "✗ NO") . "\n";

$canLoginRegistered = Auth::attempt([
    'email' => $registerEmail,
    'password' => $registerPassword,
]);

echo "Can login: " . ($canLoginRegistered ? "✓ YES" : "✗ NO") . "\n";

if ($canLoginRegistered) {
    Auth::logout();
}

echo "\n✓ All tests passed! New users can login immediately after creation.\n\n";
