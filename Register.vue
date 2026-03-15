<script setup lang="ts">
import { ref, computed } from 'vue';
// Password strength logic
const password = ref('');
const passwordStrength = computed(() => {
    const val = password.value;
    let score = 0;
    if (val.length >= 8) score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[a-z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;
    if (score <= 2) return 'Weak';
    if (score === 3 || score === 4) return 'Medium';
    return 'Strong';
});
const isPasswordStrong = computed(() => passwordStrength.value === 'Strong');
import InputError from '@/components/InputError.vue';
import TextLink from '@/components/TextLink.vue';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Spinner } from '@/components/ui/spinner';
import { login } from '@/routes';
import { store } from '@/routes/register';
import { Form, Head, Link } from '@inertiajs/vue3';
import { Home, Camera, Aperture, UserPlus } from 'lucide-vue-next';
</script>

<template>
    <Head title="Create Account - Brighter Days Photography" />

    <div class="min-h-screen flex">
        <!-- Left Side - Brand Section -->
        <div class="hidden lg:flex lg:w-1/2 relative bg-gradient-to-br from-[#B58C3C] via-[#5A3D22] to-[#B58C3C] overflow-hidden">
            <!-- Decorative blur circles -->
            <div class="absolute top-20 right-20 w-72 h-72 bg-white/20 rounded-full blur-3xl"></div>
            <div class="absolute bottom-20 left-20 w-96 h-96 bg-[#B58C3C]/30 rounded-full blur-3xl"></div>
            
            <div class="relative z-10 flex flex-col justify-center items-center w-full p-12 text-white">
                <div class="max-w-md text-center">
                    <!-- Logo -->
                    <div class="mb-8 flex justify-center">
                        <div class="relative">
                            <Aperture class="w-24 h-24 animate-pulse" />
                            <div class="absolute inset-0 bg-white/20 rounded-full blur-xl"></div>
                        </div>
                    </div>
                    
                    <h1 class="text-5xl font-bold mb-4">Join Our Community</h1>
                    <p class="text-xl text-white/90 mb-8">Start your journey with professional photography services</p>
                    
                    <div class="space-y-4 text-left bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20">
                        <div class="flex items-start space-x-3">
                            <UserPlus class="w-6 h-6 mt-1 flex-shrink-0" />
                            <div>
                                <h3 class="font-semibold mb-1">Quick Registration</h3>
                                <p class="text-sm text-white/80">Create your account in just a few steps</p>
                            </div>
                        </div>
                        <div class="flex items-start space-x-3">
                            <Camera class="w-6 h-6 mt-1 flex-shrink-0" />
                            <div>
                                <h3 class="font-semibold mb-1">Book Instantly</h3>
                                <p class="text-sm text-white/80">Access our photography packages and book your event</p>
                            </div>
                        </div>
                        <div class="flex items-start space-x-3">
                            <Aperture class="w-6 h-6 mt-1 flex-shrink-0" />
                            <div>
                                <h3 class="font-semibold mb-1">Custom Themes</h3>
                                <p class="text-sm text-white/80">Generate AI-powered themes for your special moments</p>
                            </div>
                        </div>
                    </div>

                    <div class="mt-8 p-4 bg-white/10 backdrop-blur-sm rounded-xl border border-white/20">
                        <p class="text-sm text-white/90">
                            <span class="font-semibold">Over 1,000+</span> happy customers trust us with their precious memories
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side - Registration Form -->
        <div class="w-full lg:w-1/2 flex items-center justify-center p-8 bg-gray-50 dark:bg-gray-900">
            <div class="w-full max-w-md">
                <!-- Mobile Logo -->
                <div class="lg:hidden text-center mb-8">
                    <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-gradient-to-br from-[#B58C3C] to-[#5A3D22] mb-4">
                        <Aperture class="w-8 h-8 text-white" />
                    </div>
                    <h2 class="text-2xl font-bold text-gray-900 dark:text-white">Brighter Days Photography</h2>
                </div>

                <!-- Home Button -->
                <Link href="/" 
                      class="inline-flex items-center px-4 py-2 mb-6 text-sm font-medium text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white bg-white dark:bg-gray-800 hover:bg-gray-100 dark:hover:bg-gray-700 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm transition-all duration-200 group">
                    <Home class="w-4 h-4 mr-2 group-hover:scale-110 transition-transform duration-200" />
                    Back to Home
                </Link>

                <!-- Card Container -->
                <div class="bg-white dark:bg-gray-800 rounded-2xl shadow-xl border border-gray-200 dark:border-gray-700 p-8">
                    <!-- Header -->
                    <div class="text-center mb-8">
                        <h1 class="text-3xl font-bold text-gray-900 dark:text-white mb-2">Create Your Account</h1>
                        <p class="text-gray-600 dark:text-gray-400">Join us and start booking amazing photography</p>
                    </div>

                    <!-- Form -->
                    <Form
                        v-bind="store.form()"
                        :reset-on-success="['password', 'password_confirmation']"
                        v-slot="{ errors, processing }"
                        class="space-y-5"
                    >
                        <!-- Name Field -->
                        <div class="space-y-2">
                            <Label for="name" class="text-sm font-semibold text-gray-700 dark:text-gray-300">
                                Full Name
                            </Label>
                            <Input
                                id="name"
                                type="text"
                                required
                                autofocus
                                :tabindex="1"
                                autocomplete="name"
                                name="name"
                                placeholder="John Doe"
                                class="h-12 px-4 bg-gray-50 dark:bg-gray-900 border-gray-300 dark:border-gray-600 focus:border-[#5A3D22] focus:ring-[#5A3D22]"
                            />
                            <InputError :message="errors.name" />
                        </div>

                        <!-- Email Field -->
                        <div class="space-y-2">
                            <Label for="email" class="text-sm font-semibold text-gray-700 dark:text-gray-300">
                                Email Address
                            </Label>
                            <Input
                                id="email"
                                type="email"
                                required
                                :tabindex="2"
                                autocomplete="email"
                                name="email"
                                placeholder="your@email.com"
                                class="h-12 px-4 bg-gray-50 dark:bg-gray-900 border-gray-300 dark:border-gray-600 focus:border-[#5A3D22] focus:ring-[#5A3D22]"
                            />
                            <InputError :message="errors.email" />
                        </div>

                        <!-- Password Field -->
                        <div class="space-y-2">
                            <Label for="password" class="text-sm font-semibold text-gray-700 dark:text-gray-300">
                                Password
                            </Label>
                                                        <Input
                                                                id="password"
                                                                type="password"
                                                                required
                                                                :tabindex="3"
                                                                autocomplete="new-password"
                                                                name="password"
                                                                placeholder="Create a strong password"
                                                                class="h-12 px-4 bg-gray-50 dark:bg-gray-900 border-gray-300 dark:border-gray-600 focus:border-[#5A3D22] focus:ring-[#5A3D22]"
                                                                v-model="password"
                                                        />
                                                        <div class="mt-1 flex items-center gap-2">
                                                            <div class="w-24 h-2 rounded bg-gray-200 dark:bg-gray-700 overflow-hidden">
                                                                <div :class="[
                                                                    'h-2 rounded transition-all',
                                                                    passwordStrength === 'Weak' ? 'bg-red-400 w-1/3' : '',
                                                                    passwordStrength === 'Medium' ? 'bg-yellow-400 w-2/3' : '',
                                                                    passwordStrength === 'Strong' ? 'bg-green-500 w-full' : ''
                                                                ]"></div>
                                                            </div>
                                                            <span :class="[
                                                                'text-xs font-semibold',
                                                                passwordStrength === 'Weak' ? 'text-red-500' : '',
                                                                passwordStrength === 'Medium' ? 'text-yellow-600' : '',
                                                                passwordStrength === 'Strong' ? 'text-green-600' : ''
                                                            ]">{{ passwordStrength }}</span>
                                                        </div>
                                                        <div v-if="password && passwordStrength !== 'Strong'" class="text-xs text-red-500 mt-1">
                                                            Password must be at least 8 characters and include uppercase, lowercase, number, and special character.
                                                        </div>
                                                        <InputError :message="errors.password" />
                        </div>

                        <!-- Confirm Password Field -->
                        <div class="space-y-2">
                            <Label for="password_confirmation" class="text-sm font-semibold text-gray-700 dark:text-gray-300">
                                Confirm Password
                            </Label>
                            <Input
                                id="password_confirmation"
                                type="password"
                                required
                                :tabindex="4"
                                autocomplete="new-password"
                                name="password_confirmation"
                                placeholder="Re-enter your password"
                                class="h-12 px-4 bg-gray-50 dark:bg-gray-900 border-gray-300 dark:border-gray-600 focus:border-[#5A3D22] focus:ring-[#5A3D22]"
                            />
                            <InputError :message="errors.password_confirmation" />
                        </div>

                        <!-- Submit Button -->
                        <Button
                            type="submit"
                            class="w-full h-12 mt-6 bg-gradient-to-r from-[#B58C3C] to-[#5A3D22] hover:from-[#B58C3C] hover:to-[#5A3D22] text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transition-all duration-200 transform hover:scale-[1.02]"
                            tabindex="5"
                            :disabled="processing || passwordStrength !== 'Strong'"
                            data-test="register-user-button"
                        >
                            <Spinner v-if="processing" class="mr-2" />
                            <span v-if="!processing">Create Account</span>
                            <span v-else>Creating Account...</span>
                        </Button>
                    </Form>

                    <!-- Login Link -->
                    <div class="mt-8 pt-6 border-t border-gray-200 dark:border-gray-700 text-center text-sm">
                        <span class="text-gray-600 dark:text-gray-400">Already have an account?</span>
                        <TextLink
                            :href="login()"
                            :tabindex="6"
                            class="ml-2 font-semibold text-[#5A3D22] hover:text-[#5A3D22] dark:text-[#5A3D22] dark:hover:text-[#5A3D22]"
                        >
                            Sign In
                        </TextLink>
                    </div>
                </div>

                <!-- Footer -->
                <div class="mt-6 text-center text-xs text-gray-500 dark:text-gray-400">
                    <p>© 2025 Brighter Days Photography. All rights reserved.</p>
                </div>
            </div>
        </div>
    </div>
</template>
