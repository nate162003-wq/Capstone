<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import TextLink from '@/components/TextLink.vue';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Spinner } from '@/components/ui/spinner';
import { useForm, router } from '@inertiajs/vue3';
import { register } from '@/routes';
import { request } from '@/routes/password';
import { Head, Link } from '@inertiajs/vue3';
import { Home, Camera, Aperture } from 'lucide-vue-next';
import { onMounted, onUnmounted } from 'vue';

interface Props {
    status?: string;
    canResetPassword: boolean;
    canRegister: boolean;
}

const props = defineProps<Props>();

// Initialize form using Inertia's useForm instead of route definition
const form = useForm({
    email: '',
    password: '',
});

const handleLogin = () => {
    form.post('/login', {
        onSuccess: (response) => {
            if (response?.props?.component === 'auth/Login' || window.location.pathname === '/login') {
                return;
            }

            router.visit('/dashboard');
        },
        onFinish: () => {
            form.reset('password');
        },
    });
};

onMounted(() => {
    const forceLoginRoute = () => {
        // Push state to clear forward history stack
        window.history.pushState(null, '', '/login');
    };

    // Prevent navigating forward/back into authenticated pages from login
    forceLoginRoute();
    window.addEventListener('popstate', forceLoginRoute);
    window.addEventListener('pageshow', forceLoginRoute);

    onUnmounted(() => {
        window.removeEventListener('popstate', forceLoginRoute);
        window.removeEventListener('pageshow', forceLoginRoute);
    });
});
</script>

<template>
    <Head title="Log in - Brighter Days Photography" />

    <div class="min-h-screen flex">
        <!-- Left Side - Image/Brand Section -->
        <div
            class="hidden lg:flex lg:w-1/2 relative overflow-hidden"
            style="background:
                radial-gradient(circle at 15% 20%, rgba(255, 190, 152, 0.42), transparent 34%),
                radial-gradient(circle at 84% 22%, rgba(240, 165, 153, 0.34), transparent 36%),
                radial-gradient(circle at 72% 82%, rgba(206, 90, 67, 0.30), transparent 40%),
                radial-gradient(circle at 28% 80%, rgba(248, 216, 212, 0.36), transparent 42%),
                linear-gradient(145deg, #F8D8D4 0%, #FFBE98 36%, #F0A599 62%, #F09367 82%, #CE5A43 100%);"
        >
            <!-- Decorative blur circles -->
            <div class="absolute top-10 left-8 w-80 h-80 bg-[#FFBE98] rounded-full mix-blend-soft-light blur-2xl opacity-44"></div>
            <div class="absolute top-32 right-8 w-80 h-80 bg-[#F0A599] rounded-full mix-blend-overlay blur-2xl opacity-26"></div>
            <div class="absolute bottom-16 left-1/2 w-80 h-80 bg-[#CE5A43] rounded-full mix-blend-multiply blur-2xl opacity-20"></div>
            <div class="absolute -bottom-24 -left-10 w-[24rem] h-[24rem] bg-[#F8D8D4] rounded-full mix-blend-soft-light blur-3xl opacity-36"></div>
            
            <div class="relative z-10 flex flex-col justify-center items-center w-full p-12 text-[#3A211A]">
                <div class="max-w-md text-center">
                    <!-- Logo -->
                    <div class="mb-8 flex justify-center">
                        <div class="relative">
                            <Aperture class="w-24 h-24 animate-pulse" />
                            <div class="absolute inset-0 bg-white/20 rounded-full blur-xl"></div>
                        </div>
                    </div>
                    
                    <h1 class="text-5xl font-bold text-[#3A211A] mb-4">Brighter Days Photography</h1>
                    <p class="text-[18px] text-[#4E3A32] font-grandia-like mb-8">Capturing Life's Beautiful Moments</p>
                    
                    <div class="space-y-4 text-left bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20">
                        <div class="flex items-start space-x-3">
                            <Camera class="w-6 h-6 mt-1 flex-shrink-0 text-[#3A211A]" />
                            <div>
                                <h3 class="font-semibold mb-1 text-[#2F1B15]">Professional Photography</h3>
                                <p class="text-sm text-[#5B463D]">Expert photographers for weddings, events, and special moments</p>
                            </div>
                        </div>
                        <div class="flex items-start space-x-3">
                            <Aperture class="w-6 h-6 mt-1 flex-shrink-0 text-[#3A211A]" />
                            <div>
                                <h3 class="font-semibold mb-1 text-[#2F1B15]">AI-Powered Themes</h3>
                                <p class="text-sm text-[#5B463D]">Generate custom themes tailored to your event style</p>
                            </div>
                        </div>
                        <div class="flex items-start space-x-3">
                            <svg class="w-6 h-6 mt-1 flex-shrink-0 text-[#3A211A]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                            <div>
                                <h3 class="font-semibold mb-1 text-[#2F1B15]">Easy Booking</h3>
                                <p class="text-sm text-[#5B463D]">Simple online booking system with instant confirmation</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="w-full lg:w-1/2 flex items-center justify-center p-8 bg-[#FAF9F7]">
            <div class="w-full max-w-md">
                <!-- Mobile Logo -->
                <div class="lg:hidden text-center mb-8">
                    <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-gradient-to-br from-[#452815] to-[#73411F] mb-4">
                        <Aperture class="w-8 h-8 text-[#E8D2B8]" />
                    </div>
                    <h2 class="text-2xl font-bold text-[#452815]">Brighter Days Photography</h2>
                </div>

                <!-- Home Button -->
                <Link href="/" 
                        class="inline-flex items-center px-4 py-2 mb-6 text-sm font-medium text-[#73411F] hover:text-[#452815] bg-[#E8D2B8]/85 hover:bg-[#E0C4A0] border border-[#B6885D]/45 rounded-lg shadow-sm transition-all duration-200 group">
                    <Home class="w-4 h-4 mr-2 group-hover:scale-110 transition-transform duration-200" />
                    Back to Home
                </Link>

                <!-- Card Container -->
                <div class="bg-white/96 backdrop-blur-sm rounded-2xl shadow-xl border border-[#E6E1DB] p-8">
                    <!-- Header -->
                    <div class="text-center mb-8">
                        <h1 class="text-3xl font-bold text-[#452815] mb-2">Welcome</h1>
                        <p class="text-[#73411F]">Sign in to manage your bookings</p>
                    </div>

                    <!-- Status Message -->
                    <div
                        v-if="status"
                        class="mb-6 p-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg text-center text-sm font-medium text-green-700 dark:text-green-400"
                    >
                        {{ status }}
                    </div>

                    <!-- Form -->
                    <form @submit.prevent="handleLogin" class="space-y-6">
                        <!-- Email Field -->
                        <div class="space-y-2">
                            <Label for="email" class="text-sm font-semibold text-[#452815]">
                                Email Address
                            </Label>
                            <Input
                                id="email"
                                type="email"
                                v-model="form.email"
                                name="email"
                                required
                                autofocus
                                :tabindex="1"
                                autocomplete="email"
                                placeholder="your@email.com"
                                class="h-12 px-4 !bg-[#FEFBF6] !border-[#CE5A43]/55 text-[#452815] placeholder:text-[#8A6A52] focus:border-[#863D28] focus:ring-[#863D28]"
                                style="background-color: #FEFBF6 !important;"
                            />
                            <InputError :message="form.errors.email" />
                        </div>

                        <!-- Password Field -->
                        <div class="space-y-2">
                            <div class="flex items-center justify-between mb-2">
                                <Label for="password" class="text-sm font-semibold text-[#452815]">
                                    Password
                                </Label>
                                <Link
                                    v-if="canResetPassword"
                                    :href="request()"
                                    :tabindex="5"
                                    class="text-sm font-semibold text-[#73411F] underline decoration-[#B6885D] underline-offset-4 hover:text-[#452815]"
                                >
                                    Forgot password?
                                </Link>
                            </div>
                            <Input
                                id="password"
                                type="password"
                                v-model="form.password"
                                name="password"
                                required
                                :tabindex="2"
                                autocomplete="current-password"
                                placeholder="Enter your password"
                                class="h-12 px-4 !bg-[#FEFBF6] !border-[#CE5A43]/55 text-[#452815] placeholder:text-[#8A6A52] focus:border-[#863D28] focus:ring-[#863D28]"
                                style="background-color: #FEFBF6 !important;"
                            />
                            <InputError :message="form.errors.password" />
                        </div>

                        <!-- Submit Button -->
                        <Button
                            type="submit"
                            class="w-full h-12 font-semibold rounded-lg shadow-lg hover:shadow-xl transition-all duration-200 transform hover:scale-[1.02]"
                            style="background: linear-gradient(135deg, #F09367 0%, #CE5A43 100%); color: #FFF8F1;"
                            :tabindex="4"
                            :disabled="form.processing"
                            data-test="login-button"
                        >
                            <Spinner v-if="form.processing" class="mr-2" />
                            <span v-if="!form.processing">Sign In</span>
                            <span v-else>Signing In...</span>
                        </Button>
                    </form>

                    <!-- Register Link -->
                    <div
                        class="mt-8 pt-6 border-t border-[#B6885D]/35 text-center text-sm"
                        v-if="canRegister"
                    >
                        <span class="text-[#73411F]">Don't have an account?</span>
                        <Link
                            :href="register()"
                            :tabindex="5"
                            class="ml-2 font-semibold text-[#452815] underline decoration-[#B6885D] underline-offset-4 hover:text-[#73411F]"
                        >
                            Create Account
                        </Link>
                    </div>
                </div>

                <!-- Footer -->
                <div class="mt-6 text-center text-xs text-[#73411F]">
                    <p>© 2025 Brighter Days Photography. All rights reserved.</p>
                </div>
            </div>
        </div>
    </div>
</template>
