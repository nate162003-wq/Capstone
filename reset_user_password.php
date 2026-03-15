<?php

require_once __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;

echo "=== Resetting Password for beranahomer20@gmail.com ===\n\n";

$user = User::where('email', 'beranahomer20@gmail.com')->first();

if ($user) {
    // Set new password
    $newPassword = 'password';
    $user->password = Hash::make($newPassword);
    $user->save();
    
    echo "✓ Password reset successfully!\n";
    echo "Email: beranahomer20@gmail.com\n";
    echo "New Password: {$newPassword}\n\n";
    
    // Verify it works
    $auth = auth()->attempt([
        'email' => 'beranahomer20@gmail.com',
        'password' => $newPassword,
        'is_active' => true,
    ]);
    
    if ($auth) {
        echo "✓ Password verification successful!\n";
        echo "You can now login with these credentials.\n";
        auth()->logout();
    } else {
        echo "✗ Password verification failed\n";
    }
} else {
    echo "✗ User not found\n";
}
