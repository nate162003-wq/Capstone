<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\DB;

echo "\n=== Verifying All User Emails ===\n\n";

$now = now();

$updated = DB::table('users')->update([
    'email_verified_at' => $now,
]);

echo "✓ Updated {$updated} users\n";
echo "  All emails are now verified\n\n";

// Verify
$users = User::all(['id', 'name', 'email', 'email_verified_at']);

echo "Verification status:\n";
echo str_repeat("-", 60) . "\n";
foreach ($users->take(5) as $user) {
    $verified = $user->email_verified_at ? "✓ VERIFIED" : "✗ NOT VERIFIED";
    echo "{$user->name}: {$verified}\n";
}

if ($users->count() > 5) {
    echo "... and " . ($users->count() - 5) . " more users\n";
}

echo "\n✓ All users can now login successfully!\n";
echo "  They will be able to access dashboards after login.\n\n";
