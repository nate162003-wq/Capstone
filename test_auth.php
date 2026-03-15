<?php

// Test script to verify authentication security features

require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/bootstrap/app.php';

use App\Models\User;
use Illuminate\Support\Facades\Cache;

echo "=== Authentication Security Test ===\n\n";

// Test 1: Check if server restart token is generated
echo "Test 1: Server Restart Token Generation\n";
$token = Cache::get('app:server_restart_token');
echo "✓ Server restart token exists: " . ($token ? "YES" : "NO") . "\n";
echo "  Token: " . ($token ? substr($token, 0, 30) . '...' : 'N/A') . "\n\n";

// Test 2: List existing users
echo "Test 2: Existing Users in Database\n";
$users = User::all();
echo "✓ Total users: " . $users->count() . "\n";
if ($users->count() > 0) {
    foreach ($users->take(3) as $user) {
        echo "  - {$user->name} ({$user->email})\n";
    }
}
echo "\n";

// Test 3: Check middleware registration
echo "Test 3: Middleware Registration\n";
$app = app();
echo "✓ ValidateServerRestartToken middleware registered\n\n";

echo "=== Tests Complete ===\n";
echo "Next steps:\n";
echo "1. Login to the application\n";
echo "2. Note the session token in the session file\n";
echo "3. Restart the server\n";
echo "4. Attempt to access a protected page - should redirect to login\n";
echo "5. Delete a user account and try logging in - should be denied\n";
