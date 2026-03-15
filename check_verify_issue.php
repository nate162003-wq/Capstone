<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\DB;

// Directly check database
$user = User::latest()->first();

echo "\n=== Checking Database vs Model ===\n\n";
echo "User ID: {$user->id}\n";
echo "Email: {$user->email}\n\n";

// Check raw database value
$rawData = DB::table('users')->where('id', $user->id)->first();
echo "Raw database email_verified_at: ";
var_dump($rawData->email_verified_at);
echo "\n";

echo "Model email_verified_at: ";
var_dump($user->email_verified_at);
echo "\n";

// Try creating with explicit timestamp
$testUser = User::create([
    'name' => 'Test Verify',
    'email' => 'testverify_' . uniqid() . '@example.com',
    'password' => 'password123',
    'role' => 'customer',
    'email_verified_at' => \Illuminate\Support\Facades\DB::raw("NOW()"),
]);

echo "Created user with DB::raw(\"NOW()\"):\n";
$refreshed = $testUser->refresh();
echo "Model shows: " . ($refreshed->email_verified_at ? "✓ VERIFIED" : "✗ NOT VERIFIED") . "\n";

$rawTest = DB::table('users')->where('id', $testUser->id)->first();
echo "Database shows: " . ($rawTest->email_verified_at ? "✓ VERIFIED" : "✗ NOT VERIFIED") . "\n";
