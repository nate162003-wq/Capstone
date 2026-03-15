<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\DB;

echo "=== Checking for 'newcustomer@example.com' in Database ===\n\n";

$user = User::where('email', 'newcustomer@example.com')->first();

if ($user) {
    echo "✓ User FOUND in database\n\n";
    echo "User Details:\n";
    echo "  ID: {$user->id}\n";
    echo "  Name: {$user->name}\n";
    echo "  Email: {$user->email}\n";
    echo "  Role: {$user->role}\n";
    echo "  Email Verified: " . ($user->email_verified_at ? 'YES (' . $user->email_verified_at->format('Y-m-d H:i:s') . ')' : 'NO') . "\n";
    echo "  Active: " . ($user->is_active ? 'YES' : 'NO') . "\n";
    echo "  Created At: " . ($user->created_at ? $user->created_at->format('Y-m-d H:i:s') : 'N/A') . "\n";
    echo "  Password Hash: " . substr($user->password, 0, 20) . "...\n";
    echo "\n";
    
    echo "Role Check Methods:\n";
    echo "  isCustomer(): " . ($user->isCustomer() ? 'TRUE' : 'FALSE') . "\n";
    echo "  isEventManager(): " . ($user->isEventManager() ? 'TRUE' : 'FALSE') . "\n";
    echo "  isBusinessOwner(): " . ($user->isBusinessOwner() ? 'TRUE' : 'FALSE') . "\n";
    
} else {
    echo "✗ User NOT FOUND in database\n";
    echo "\nChecking for similar users...\n";
    
    $similar = DB::table('users')
        ->where('email', 'like', '%newcustomer%')
        ->orWhere('email', 'like', '%new%customer%')
        ->get();
    
    if ($similar->count() > 0) {
        echo "Found {$similar->count()} similar user(s):\n";
        foreach ($similar as $u) {
            echo "  - {$u->email} (Role: {$u->role})\n";
        }
    } else {
        echo "No similar users found.\n";
    }
}

echo "\n=== All Users in Database ===\n";
$allUsers = User::all(['id', 'name', 'email', 'role', 'email_verified_at', 'is_active']);
echo $allUsers->count() . " total users:\n";
foreach ($allUsers as $u) {
    echo "  - {$u->email} (Role: {$u->role}, Verified: " . ($u->email_verified_at ? 'YES' : 'NO') . ", Active: " . ($u->is_active ? 'YES' : 'NO') . ")\n";
}
