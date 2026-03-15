<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import Select from '@/components/ui/Select.vue';
import { Link, router, useForm } from '@inertiajs/vue3';
import { Trash2, Edit, UserPlus, Search, ToggleLeft, ToggleRight } from 'lucide-vue-next';
import { ref, watch } from 'vue';
import { getContrastingTextColor } from '@/lib/utils';

interface User {
    id: number;
    name: string;
    email: string;
    role: string;
    is_active: boolean;
    created_at: string;
    bookings_count?: number;
}

interface Props {
    users: {
        data: User[];
        current_page: number;
        last_page: number;
        per_page: number;
        total: number;
    };
    filters?: {
        role?: string;
        search?: string;
    };
}

const props = withDefaults(defineProps<Props>(), {
    filters: () => ({}),
});

const searchQuery = ref(props.filters?.search || '');
const roleFilter = ref(props.filters?.role || 'all');

const deleteForm = useForm({});

const deleteUser = (userId: number) => {
    if (confirm('Are you sure you want to delete this user?')) {
        deleteForm.delete(`/business-owner/users/${userId}`, {
            preserveScroll: true,
        });
    }
};

const toggleStatus = (userId: number) => {
    router.post(`/business-owner/users/${userId}/toggle-status`, {}, {
        preserveScroll: true,
    });
};

watch([searchQuery, roleFilter], ([search, role]) => {
    router.get('/business-owner/users', {
        search,
        role,
    }, {
        preserveState: true,
        preserveScroll: true,
    });
}, { debounce: 300 });

const getRoleBadgeStyle = (role: string) => {
    const roleBackground: Record<string, string> = {
        business_owner: '#7A4B45',
        event_manager: '#8E5551',
        customer: '#B95F35',
    };

    const backgroundColor = roleBackground[role] || '#4b5563';
    return {
        backgroundColor,
        color: '#FDF7F5',
        borderColor: '#EAC3BF',
        fontWeight: '700',
    };
};

const getActiveBadgeStyle = (isActive: boolean) => {
    const backgroundColor = isActive ? '#7A4B45' : '#8A3D2E';
    return {
        backgroundColor,
        color: '#FDF7F5',
        borderColor: '#EAC3BF',
        fontWeight: '700',
    };
};

const formatRole = (role: string) => {
    return role.split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
};
</script>

<template>
    <AppLayout>
        <div class="container mx-auto py-6 space-y-6">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900 dark:text-white">User Management</h1>
                    <p class="text-gray-600 dark:text-gray-400 mt-1">Manage system users and their roles</p>
                </div>
                <Link href="/business-owner/users/create">
                    <Button>
                        <UserPlus class="w-4 h-4 mr-2" />
                        Add User
                    </Button>
                </Link>
            </div>

            <Card>
                <CardHeader>
                    <div class="flex flex-col sm:flex-row gap-4">
                        <div class="flex-1">
                            <div class="relative">
                                <Search class="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                                <Input
                                    v-model="searchQuery"
                                    type="text"
                                    placeholder="Search by name or email..."
                                    class="pl-10"
                                />
                            </div>
                        </div>
                        <Select
                            v-model="roleFilter"
                            :options="[
                                { value: 'all', label: 'All Roles' },
                                { value: 'customer', label: 'Customer' },
                                { value: 'event_manager', label: 'Event Manager' },
                                { value: 'business_owner', label: 'Business Owner' },
                            ]"
                            placeholder="Filter by role"
                            class="w-full sm:w-[180px]"
                        />
                    </div>
                </CardHeader>
                <CardContent>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b border-gray-200 dark:border-gray-700">
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700 dark:text-gray-300">Name</th>
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700 dark:text-gray-300">Email</th>
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700 dark:text-gray-300">Role</th>
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700 dark:text-gray-300">Status</th>
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700 dark:text-gray-300">Bookings</th>
                                    <th class="text-right py-3 px-4 font-semibold text-sm text-gray-700 dark:text-gray-300">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="user in users.data"
                                    :key="user.id"
                                    class="border-b border-gray-100 dark:border-gray-800 hover:bg-gray-50 dark:hover:bg-gray-800/50"
                                >
                                    <td class="py-4 px-4">
                                        <div class="font-medium text-gray-900 dark:text-white">{{ user.name }}</div>
                                    </td>
                                    <td class="py-4 px-4 text-gray-600 dark:text-gray-400">{{ user.email }}</td>
                                    <td class="py-4 px-4">
                                        <Badge :style="getRoleBadgeStyle(user.role)" class="text-xs font-semibold px-2 py-0.5 rounded-md">
                                            {{ formatRole(user.role) }}
                                        </Badge>
                                    </td>
                                    <td class="py-4 px-4">
                                        <Badge :style="getActiveBadgeStyle(user.is_active)" class="text-xs font-semibold px-2 py-0.5 rounded-md">
                                            {{ user.is_active ? 'Active' : 'Inactive' }}
                                        </Badge>
                                    </td>
                                    <td class="py-4 px-4 text-gray-600 dark:text-gray-400">
                                        {{ user.bookings_count || 0 }}
                                    </td>
                                    <td class="py-4 px-4">
                                        <div class="flex items-center justify-end gap-2">
                                            <Button
                                                variant="ghost"
                                                size="sm"
                                                @click="toggleStatus(user.id)"
                                            >
                                                <ToggleRight v-if="user.is_active" class="w-4 h-4" />
                                                <ToggleLeft v-else class="w-4 h-4" />
                                            </Button>
                                            <Link :href="`/business-owner/users/${user.id}/edit`">
                                                <Button variant="ghost" size="sm">
                                                    <Edit class="w-4 h-4" />
                                                </Button>
                                            </Link>
                                            <Button
                                                variant="ghost"
                                                size="sm"
                                                @click="deleteUser(user.id)"
                                            >
                                                <Trash2 class="w-4 h-4 text-red-600" />
                                            </Button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div v-if="users.data.length === 0" class="text-center py-12">
                        <p class="text-gray-500 dark:text-gray-400">No users found</p>
                    </div>

                    <div v-if="users.last_page > 1" class="mt-6 flex justify-center">
                        <div class="flex gap-2">
                            <Button
                                v-for="page in users.last_page"
                                :key="page"
                                :variant="page === users.current_page ? 'default' : 'outline'"
                                size="sm"
                                @click="router.get(`/business-owner/users?page=${page}`)"
                            >
                                {{ page }}
                            </Button>
                        </div>
                    </div>
                </CardContent>
            </Card>
        </div>
    </AppLayout>
</template>
