<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\DB;

// Create 5 bookings
for ($i = 0; $i < 5; $i++) {
    DB::table('bookings')->insert([
        'user_id' => 3,
        'package_id' => 1,
        'event_type' => ['wedding','birthday','corporate'][rand(0,2)],
        'event_date' => date('Y-m-d', strtotime('+' . rand(30, 90) . ' days')),
        'event_time' => '14:00:00',
        'venue' => 'Venue #' . rand(1, 5),
        'expected_guests' => rand(50, 200),
        'contact_phone' => '09123456789',
        'contact_email' => 'test@example.com',
        'total_cost' => rand(15000, 50000),
        'status' => ['pending','confirmed'][rand(0,1)],
        'confirmed_at' => now(),
        'confirmed_by' => 2,
        'created_at' => now(),
        'updated_at' => now(),
    ]);
}

echo "Created 5 bookings\n";

// Get last 5 bookings
$bookings = DB::table('bookings')->orderBy('id', 'desc')->take(5)->get();

foreach ($bookings as $booking) {
    DB::table('payments')->insert([
        'booking_id' => $booking->id,
        'user_id' => $booking->user_id,
        'amount' => $booking->total_cost * 0.5,
        'payment_type' => 'deposit',
        'payment_method' => ['gcash','bank_transfer','cash'][rand(0,2)],
        'status' => 'verified',
        'transaction_reference' => 'TXN' . strtoupper(uniqid()),
        'verified_by' => 2,
        'verified_at' => now(),
        'created_at' => now(),
        'updated_at' => now(),
    ]);
}

echo "Created payments for 5 bookings\n";
