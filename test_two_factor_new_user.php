<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

echo "=== Checking Two-Factor Setup for New Users ===\n\n";

// Create test user via registration
$testEmail = 'twofactor-test-' . time() . '@example.com';
$testPassword = 'TestPassword123!';

echo "1. Checking fresh user from database\n";

// Clean up
User::where('email', $testEmail)->forceDelete();

// Create user  exactly as CreateNewUser would
$user = User::create([
    'name' => 'Two Factor Test',
    'email' => $testEmail,
    'password' => Hash::make($testPassword),
    'role' => 'customer',
    'email_verified_at' => now(),
]);

echo "Created user: {$user->email}\n";
echo "two_factor_confirmed_at: " . ($user->two_factor_confirmed_at ?? 'NULL') . "\n";
echo "two_factor_secret: " . ($user->two_factor_secret ?? 'NULL') . "\n";
echo "two_factor_recovery_codes: " . ($user->two_factor_recovery_codes ?? 'NULL') . "\n\n";

echo "2. Checking raw database values\n";
$dbRow = DB::table('users')->where('email', $testEmail)->first();
echo "two_factor_confirmed_at: " . ($dbRow->two_factor_confirmed_at ?? 'NULL') . "\n";
echo "two_factor_secret: " . ($dbRow->two_factor_secret ?? 'NULL') . "\n";
echo "two_factor_recovery_codes: " . ($dbRow->two_factor_recovery_codes ?? 'NULL') . "\n\n";

echo "3. Check if hasTwo FactorAuthentication() would trigger\n";
$checkMethod = method_exists($user, 'hasTwoFactorAuthenticationEnabled');
if ($checkMethod) {
    echo "hasTwoFactorAuthenticationEnabled() exists\n";
    echo "Method returns: " . ($user->hasTwoFactorAuthenticationEnabled() ? 'TRUE' : 'FALSE') . "\n";
} else {
    echo "Method doesn't exist\n";
}

echo "\nCleaning up...\n";
User::where('email', $testEmail)->forceDelete();
echo "✓ Done\n";
