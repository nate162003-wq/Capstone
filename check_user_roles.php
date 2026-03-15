<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\User;

echo "\n=== Check All Users and Their Roles ===\n\n";

$users = User::all(['id', 'name', 'email', 'role', 'is_active', 'email_verified_at']);

echo "ID | Name | Email | Role | Active | Email Verified\n";
echo str_repeat("-", 120) . "\n";

foreach ($users as $user) {
    $role = $user->role ?: 'NULL';
    $active = $user->is_active ? 'YES' : 'NO';
    $verified = $user->email_verified_at ? 'YES' : 'NO';
    
    printf("%2d | %-20s | %-35s | %-15s | %s | %s\n", 
        $user->id, 
        substr($user->name, 0, 20),
        $user->email,
        $role,
        $active,
        $verified
    );
}

echo "\n";

// Find newly created user (assuming it's the latest one)
$latest = User::latest()->first();
echo "Latest user:\n";
echo "  ID: {$latest->id}\n";
echo "  Name: {$latest->name}\n";
echo "  Email: {$latest->email}\n";
echo "  Role: " . ($latest->role ? "{$latest->role}" : "NULL - THIS IS THE PROBLEM!") . "\n";
echo "  Role is set: " . ($latest->role ? "✓ YES" : "✗ NO") . "\n";

if (!$latest->role) {
    echo "\n⚠️  WARNING: Latest user has NO role set!\n";
    echo "   This is why they can't access their dashboard.\n";
}

echo "\n";
