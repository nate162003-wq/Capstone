<script setup lang="ts">
import AppContent from '@/components/AppContent.vue';
import AppShell from '@/components/AppShell.vue';
import AppSidebar from '@/components/AppSidebar.vue';
import AppSidebarHeader from '@/components/AppSidebarHeader.vue';
import type { BreadcrumbItemType } from '@/types';
import { router } from '@inertiajs/vue3';
import { onMounted, onUnmounted } from 'vue';

interface Props {
    breadcrumbs?: BreadcrumbItemType[];
}

withDefaults(defineProps<Props>(), {
    breadcrumbs: () => [],
});

const revalidateOnHistoryNav = () => {
    router.reload({
        preserveScroll: false,
        preserveState: false,
    });
};

onMounted(() => {
    window.addEventListener('popstate', revalidateOnHistoryNav);
    window.addEventListener('pageshow', revalidateOnHistoryNav);
});

onUnmounted(() => {
    window.removeEventListener('popstate', revalidateOnHistoryNav);
    window.removeEventListener('pageshow', revalidateOnHistoryNav);
});
</script>

<template>
    <AppShell variant="sidebar">
        <AppSidebar />
        <AppContent variant="sidebar" class="overflow-x-hidden">
            <AppSidebarHeader :breadcrumbs="breadcrumbs" />
            <slot />
        </AppContent>
    </AppShell>
</template>
