<script setup lang="ts">
interface Props {
  title?: string;
  description?: string;
  icon?: 'search' | 'inbox' | 'calendar' | 'users' | 'file';
  actionText?: string;
  actionHref?: string;
}

const props = withDefaults(defineProps<Props>(), {
  title: 'No results found',
  description: 'Try adjusting your search or filter to find what you\'re looking for.',
  icon: 'search',
});

const emit = defineEmits<{
  (e: 'action-click'): void;
}>();

const icons = {
  search: 'M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z',
  inbox: 'M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4',
  calendar: 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z',
  users: 'M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z',
  file: 'M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z',
};
</script>

<template>
  <div class="text-center py-12">
    <svg 
      class="mx-auto h-16 w-16 text-gray-400 dark:text-gray-500" 
      fill="none" 
      stroke="currentColor" 
      viewBox="0 0 24 24"
    >
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" :d="icons[icon]" />
    </svg>
    <h3 class="mt-4 text-lg font-medium text-gray-900 dark:text-white">{{ title }}</h3>
    <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">{{ description }}</p>
    <div v-if="actionText" class="mt-6">
      <slot name="action">
        <a 
          v-if="actionHref"
          :href="actionHref"
          class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-lg text-white bg-[#5A3D22] hover:bg-[#5A3D22] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#5A3D22] transition-colors"
        >
          {{ actionText }}
        </a>
        <button
          v-else
          @click="emit('action-click')"
          class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-lg text-white bg-[#5A3D22] hover:bg-[#5A3D22] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#5A3D22] transition-colors"
        >
          {{ actionText }}
        </button>
      </slot>
    </div>
  </div>
</template>
