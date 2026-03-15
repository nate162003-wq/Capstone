<?php
require 'vendor/autoload.php';
$app = require 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

$users = \App\Models\User::all(['id','name','email','role']);

echo "\n=== Current Users in Database ===\n\n";
echo "ID | Name | Email | Role\n";
echo str_repeat("-", 80) . "\n";
foreach($users as $u) {
    echo "{$u->id} | {$u->name} | {$u->email} | {$u->role}\n";
}
echo "\nTotal: " . $users->count() . " users\n\n";
