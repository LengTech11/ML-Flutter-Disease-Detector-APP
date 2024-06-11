<?php

namespace Database\Seeders;


use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        User::factory()->create([
            'first_name' => 'Admin',
            'last_name' => '1',
            'email' => 'admin@gmail.com',
            'age' => 32,
            'phone_number' => '070717197',
            'gender'=> 1,
            'user_role' => 1,
            'password' => Hash::make('admin123'),
        ]);

        $faker = Faker::create();
        for ($i = 0; $i < 4; $i++) {
            User::create([
                'first_name' => $faker->firstName,
                'last_name' => $faker->lastName,
                'email' => $faker->unique()->safeEmail,
                'age' => $faker->numberBetween(18, 65),
                'phone_number' => $faker->phoneNumber,
                'gender' => $faker->randomElement([1, 2]),
                'user_role' => 2,
                'password' => Hash::make('password'),
            ]);
        }
    }
}
