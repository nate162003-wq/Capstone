<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import Select from '@/components/ui/Select.vue';
import { useForm } from '@inertiajs/vue3';
import { ArrowLeft } from 'lucide-vue-next';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    role: 'customer',
    profession: '',
    phone: '',
    address: '',
});

const submit = () => {
    form.post('/business-owner/users');
};
</script>

<template>
    <AppLayout>
        <div class="container mx-auto py-6 space-y-6 max-w-3xl">
            <div class="flex items-center gap-4">
                <Button variant="ghost" size="sm" @click="$inertia.visit('/business-owner/users')">
                    <ArrowLeft class="w-4 h-4 mr-2" />
                    Back
                </Button>
                <div>
                    <h1 class="text-3xl font-bold text-gray-900 dark:text-white">Create New User</h1>
                    <p class="text-gray-600 dark:text-gray-400 mt-1">Add a new user to the system</p>
                </div>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>User Information</CardTitle>
                    <CardDescription>Fill in the details for the new user</CardDescription>
                </CardHeader>
                <CardContent>
                    <form @submit.prevent="submit" class="space-y-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <Label for="name">Full Name *</Label>
                                <Input
                                    id="name"
                                    v-model="form.name"
                                    type="text"
                                    required
                                />
                                <p v-if="form.errors.name" class="text-sm text-red-600">{{ form.errors.name }}</p>
                            </div>

                            <div class="space-y-2">
                                <Label for="email">Email Address *</Label>
                                <Input
                                    id="email"
                                    v-model="form.email"
                                    type="email"
                                    required
                                />
                                <p v-if="form.errors.email" class="text-sm text-red-600">{{ form.errors.email }}</p>
                            </div>

                            <div class="space-y-2">
                                <Label for="password">Password *</Label>
                                <Input
                                    id="password"
                                    v-model="form.password"
                                    type="password"
                                    required
                                />
                                <p v-if="form.errors.password" class="text-sm text-red-600">{{ form.errors.password }}</p>
                            </div>

                            <div class="space-y-2">
                                <Label for="password_confirmation">Confirm Password *</Label>
                                <Input
                                    id="password_confirmation"
                                    v-model="form.password_confirmation"
                                    type="password"
                                    required
                                />
                            </div>

                            <div class="space-y-2">
                                <Label for="role">Role *</Label>
                                <Select
                                    id="role"
                                    v-model="form.role"
                                    :options="[
                                        { value: 'customer', label: 'Customer' },
                                        { value: 'event_manager', label: 'Event Manager' },
                                        { value: 'business_owner', label: 'Business Owner' },
                                    ]"
                                    required
                                    placeholder="Select role"
                                />
                                <p v-if="form.errors.role" class="text-sm text-red-600">{{ form.errors.role }}</p>
                            </div>

                            <div class="space-y-2">
                                <Label for="profession">Profession</Label>
                                <Select
                                    id="profession"
                                    v-model="form.profession"
                                    :options="[
                                        { value: '', label: 'None' },
                                        { value: 'photographer', label: 'Photographer' },
                                        { value: 'videographer', label: 'Videographer' },
                                    ]"
                                    placeholder="Select profession (optional)"
                                />
                                <p v-if="form.errors.profession" class="text-sm text-red-600">{{ form.errors.profession }}</p>
                            </div>

                            <div class="space-y-2">
                                <Label for="phone">Phone Number</Label>
                                <Input
                                    id="phone"
                                    v-model="form.phone"
                                    type="tel"
                                />
                                <p v-if="form.errors.phone" class="text-sm text-red-600">{{ form.errors.phone }}</p>
                            </div>
                        </div>

                        <div class="space-y-2">
                            <Label for="address">Address</Label>
                            <Input
                                id="address"
                                v-model="form.address"
                                type="text"
                            />
                            <p v-if="form.errors.address" class="text-sm text-red-600">{{ form.errors.address }}</p>
                        </div>

                        <div class="flex gap-4">
                            <Button type="submit" :disabled="form.processing">
                                {{ form.processing ? 'Creating...' : 'Create User' }}
                            </Button>
                            <Button
                                type="button"
                                variant="outline"
                                @click="$inertia.visit('/business-owner/users')"
                            >
                                Cancel
                            </Button>
                        </div>
                    </form>
                </CardContent>
            </Card>
        </div>
    </AppLayout>
</template>
