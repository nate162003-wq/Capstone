<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

echo "\n=== Complete Login Flow Test with Dashboard Access ===\n\n";

// Create a new customer user
$email = 'testdash_' . uniqid() . '@example.com';
$password = 'DashboardTest123';

echo "Step 1: Create new customer user\n";
echo str_repeat("-", 70) . "\n";

$user = User::create([
    'name' => 'Dashboard Test Customer',
    'email' => $email,
    'password' => Hash::make($password),
    'role' => 'customer',
    'is_active' => true,
    'email_verified_at' => now(),
]);

echo "✓ User created\n";
echo "  Email: {$user->email}\n";
echo "  Role: {$user->role}\n";
echo "  Email verified: " . ($user->email_verified_at ? "YES" : "NO") . "\n";
echo "  Active: " . ($user->is_active ? "YES" : "NO") . "\n\n";

// Authenticate
echo "Step 2: Authenticate user\n";
echo str_repeat("-", 70) . "\n";

$canAuth = Auth::attempt([
    'email' => $email,
    'password' => $password,
]);

echo "Authentication result: " . ($canAuth ? "✓ SUCCESS" : "✗ FAILED") . "\n\n";

if ($canAuth) {
    $authUser = Auth::user();
    
    echo "Step 3: Check user properties\n";
    echo str_repeat("-", 70) . "\n";
    echo "  ID: {$authUser->id}\n";
    echo "  Name: {$authUser->name}\n";
    echo "  Email: {$authUser->email}\n";
    echo "  Role: " . ($authUser->role ?: "NULL") . "\n";
    echo "  Role is set: " . ($authUser->role ? "✓ YES" : "✗ NO") . "\n";
    echo "  Role value: '" . ($authUser->role ?? '') . "'\n";
    echo "  Email verified: " . ($authUser->email_verified_at ? "✓ YES" : "✗ NO") . "\n";
    echo "  Active: " . ($authUser->is_active ? "✓ YES" : "✗ NO") . "\n\n";
    
    // Check role methods
    echo "Step 4: Check role methods\n";
    echo str_repeat("-", 70) . "\n";
    echo "  isCustomer(): " . ($authUser->isCustomer() ? "✓ TRUE" : "✗ FALSE") . "\n";
    echo "  isEventManager(): " . ($authUser->isEventManager() ? "✓ TRUE" : "✗ FALSE") . "\n";
    echo "  isBusinessOwner(): " . ($authUser->isBusinessOwner() ? "✓ TRUE" : "✗ FALSE") . "\n\n";
    
    // Check middleware access
    echo "Step 5: Simulate role middleware check\n";
    echo str_repeat("-", 70) . "\n";
    
    $customerAllowed = in_array($authUser->role, ['customer']);
    echo "Can access customer routes (role:customer): " . ($customerAllowed ? "✓ YES" : "✗ NO") . "\n";
    
    $eventManagerAllowed = in_array($authUser->role, ['event_manager', 'business_owner']);
    echo "Can access event manager routes (role:event_manager,business_owner): " . ($eventManagerAllowed ? "✓ YES" : "✗ NO") . "\n";
    
    $businessOwnerAllowed = in_array($authUser->role, ['business_owner']);
    echo "Can access business owner routes (role:business_owner): " . ($businessOwnerAllowed ? "✓ YES" : "✗ NO") . "\n\n";
    
    if ($customerAllowed) {
        echo "✓ User can access customer dashboard!\n";
    } else {
        echo "✗ User CANNOT access customer dashboard\n";
        echo "  This is the problem!\n";
    }
    
    Auth::logout();
} else {
    echo "✗ Authentication failed - cannot test dashboard access\n";
}

echo "\n";
