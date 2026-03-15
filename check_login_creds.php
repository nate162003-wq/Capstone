<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;

echo "=== Checking Login Credentials ===\n\n";

$testEmail = 'beranahomer20@gmail.com';
echo "Checking user: {$testEmail}\n";

$user = User::where('email', $testEmail)->first();

if ($user) {
    echo "✓ User found\n";
    echo "  Name: {$user->name}\n";
    echo "  Role: {$user->role}\n";
    echo "  Email Verified: " . ($user->email_verified_at ? 'YES' : 'NO') . "\n";
    echo "  Active: " . ($user->is_active ? 'YES' : 'NO') . "\n";
    echo "  Password Hash: " . (empty($user->password) ? 'EMPTY!' : 'SET') . "\n\n";
    
    if (empty($user->password)) {
        echo "⚠️  PROBLEM: Password is EMPTY!\n";
        echo "This user cannot login until password is set.\n\n";
    }
    
    // Try authentication with common test passwords
    echo "Testing authentication:\n";
    $testPasswords = ['password', 'beranahomer', 'Password123!', 'test123'];
    
    $foundPassword = false;
    foreach ($testPasswords as $pwd) {
        $result = auth()->attempt([
            'email' => $testEmail,
            'password' => $pwd,
            'is_active' => true,
        ]);
        if ($result) {
            echo "✓ Authentication successful with password: '{$pwd}'\n";
            $foundPassword = true;
            auth()->logout();
            break;
        }
    }
    
    if (!$foundPassword) {
        echo "✗ None of the test passwords worked\n";
        echo "The user needs a valid password set.\n";
    }
    
} else {
    echo "✗ User NOT found in database\n";
}

echo "\n=== All Users ===\n";
$allUsers = User::all(['email', 'role', 'is_active'])->take(10);
echo "First 10 users:\n";
foreach ($allUsers as $u) {
    echo "  - {$u->email} (Role: {$u->role}, Active: " . ($u->is_active ? 'YES' : 'NO') . ")\n";
}
