<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

echo "=== Testing Fortify Login Handler ===\n\n";

// Create a fresh test user
echo "Creating test user...\n";
$testEmail = 'fortify-test-' . time() . '@example.com';
$testPassword = 'TestPassword123!';

// Clean up any existing test user
User::where('email', $testEmail)->forceDelete();

$user = User::create([
    'name' => 'Fortify Test',
    'email' => $testEmail,
    'password' => Hash::make($testPassword),
    'role' => 'customer',
    'email_verified_at' => now(),
    'is_active' => true,
]);

echo "✓ Test user created: {$testEmail}\n";
echo "  Role: {$user->role}\n";
echo "  Email verified: " . ($user->email_verified_at ? 'YES' : 'NO') . "\n";
echo "  Active: " . ($user->is_active ? 'YES' : 'NO') . "\n";

// Try to authenticate
echo "\nAttempting authentication...\n";
$authenticated = auth()->attempt([
    'email' => $testEmail,
    'password' => $testPassword,
    'is_active' => true,  // This is what Fortify checks
]);

echo "Authentication result: " . ($authenticated ? 'SUCCESS' : 'FAILED') . "\n";

if ($authenticated) {
    $authUser = auth()->user();
    echo "  Logged in as: {$authUser->email}\n";
    echo "  Role: {$authUser->role}\n";
    echo "  Email verified: " . ($authUser->email_verified_at ? 'YES' : 'NO') . "\n";
    
    // Test the dashboard redirect
    echo "\nDashboard redirect logic:\n";
    if ($authUser->isCustomer()) {
        echo "✓ Should redirect to: customer.dashboard\n";
    } elseif ($authUser->isEventManager()) {
        echo "✓ Should redirect to: event-manager.dashboard\n";
    } elseif ($authUser->isBusinessOwner()) {
        echo "✓ Should redirect to: business-owner.analytics.index\n";
    }
    
} else {
    echo "\nDEBUG INFO:\n";
    $dbUser = User::where('email', $testEmail)->first();
    if ($dbUser) {
        echo "User in DB: YES\n";
        echo "Password check: " . (Hash::check($testPassword, $dbUser->password) ? 'PASS' : 'FAIL') . "\n";
        echo "Is active: " . ($dbUser->is_active ? 'YES' : 'NO') . "\n";
        echo "Email verified: " . ($dbUser->email_verified_at ? 'YES' : 'NO') . "\n";
    } else {
        echo "User in DB: NO\n";
    }
}

// Clean up
User::where('email', $testEmail)->forceDelete();
