<script setup lang="ts">
import NavMain from '@/components/NavMain.vue';
import NavUser from '@/components/NavUser.vue';
import {
    Sidebar,
    SidebarContent,
    SidebarFooter,
    SidebarHeader,
    SidebarMenu,
    SidebarMenuButton,
    SidebarMenuItem,
} from '@/components/ui/sidebar';
import { dashboard } from '@/routes';
import { type NavItem } from '@/types';
import { Link, usePage } from '@inertiajs/vue3';
import { LayoutGrid, Users, ImageIcon, Calendar, ClipboardList, CalendarCheck } from 'lucide-vue-next';
import { computed } from 'vue';
import AppLogo from './AppLogo.vue';

const page = usePage();
const user = computed(() => page.props.auth?.user);

const sidebarThemeClasses = computed(() => {
    if (
        user.value?.role === 'customer' ||
        user.value?.role === 'event_manager' ||
        user.value?.role === 'business_owner'
    ) {
        return [
            '[--sidebar-background:#e8b19d]',
            '[--sidebar:#e8b19d]',
            '[--sidebar-foreground:#6b443d]',
            '[--sidebar-primary:#f3e0d1]',
            '[--sidebar-primary-foreground:#5a3735]',
            '[--sidebar-accent:#efd0c4]',
            '[--sidebar-accent-foreground:#6b443d]',
            '[--sidebar-border:#d69f8b]',
            '[--sidebar-ring:#bb8c94]',
        ].join(' ');
    }

    return '';
});

const mainNavItems = computed<NavItem[]>(() => {
    const items: NavItem[] = [
        {
            title: 'Dashboard',
            href: dashboard(),
            icon: LayoutGrid,
        },
    ];

    // Add customer specific navigation items
    if (user.value?.role === 'customer') {
        items.push({
            title: 'My Bookings',
            href: '/customer/bookings',
            icon: CalendarCheck,
        });
    }

    // Add event manager specific navigation items
    if (user.value?.role === 'event_manager' || user.value?.role === 'business_owner') {
        items.push({
            title: 'Booking List',
            href: '/event-manager/reservations',
            icon: ClipboardList,
        });
        items.push({
            title: 'Calendar View',
            href: '/event-manager/calendar',
            icon: Calendar,
        });
    }

    // Add business owner specific navigation items
    if (user.value?.role === 'business_owner') {
        items.push({
            title: 'User Management',
            href: '/business-owner/users',
            icon: Users,
        });
        items.push({
            title: 'Landing Page Images',
            href: '/business-owner/landing-images',
            icon: ImageIcon,
        });
    }

    return items;
});

</script>

<template>
    <Sidebar collapsible="icon" variant="inset" :class="sidebarThemeClasses">
        <SidebarHeader>
            <SidebarMenu>
                <SidebarMenuItem>
                    <SidebarMenuButton size="lg" as-child class="py-2">
                        <Link :href="dashboard()">
                            <AppLogo />
                        </Link>
                    </SidebarMenuButton>
                </SidebarMenuItem>
            </SidebarMenu>
        </SidebarHeader>

        <SidebarContent>
            <NavMain :items="mainNavItems" />
        </SidebarContent>

        <SidebarFooter>
            <NavUser />
        </SidebarFooter>
    </Sidebar>
    <slot />
</template>
