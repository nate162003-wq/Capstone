<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  currentPage: number;
  lastPage: number;
  perPage: number;
  total: number;
  from?: number;
  to?: number;
  showInfo?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  showInfo: true,
});

const emit = defineEmits<{
  (e: 'page-changed', page: number): void;
}>();

const pages = computed(() => {
  const delta = 2;
  const range: number[] = [];
  const rangeWithDots: (number | string)[] = [];
  let l: number | undefined;

  for (let i = 1; i <= props.lastPage; i++) {
    if (i === 1 || i === props.lastPage || (i >= props.currentPage - delta && i <= props.currentPage + delta)) {
      range.push(i);
    }
  }

  range.forEach((i) => {
    if (l) {
      if (i - l === 2) {
        rangeWithDots.push(l + 1);
      } else if (i - l !== 1) {
        rangeWithDots.push('...');
      }
    }
    rangeWithDots.push(i);
    l = i;
  });

  return rangeWithDots;
});

const from = computed(() => props.from || (props.currentPage - 1) * props.perPage + 1);
const to = computed(() => props.to || Math.min(props.currentPage * props.perPage, props.total));

const goToPage = (page: number | string) => {
  if (typeof page === 'number' && page !== props.currentPage) {
    emit('page-changed', page);
  }
};

const previousPage = () => {
  if (props.currentPage > 1) {
    emit('page-changed', props.currentPage - 1);
  }
};

const nextPage = () => {
  if (props.currentPage < props.lastPage) {
    emit('page-changed', props.currentPage + 1);
  }
};
</script>

<template>
  <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
    <!-- Info -->
    <div v-if="showInfo" class="text-sm text-gray-600 dark:text-gray-400">
      Showing {{ from }} to {{ to }} of {{ total }} results
    </div>

    <!-- Pagination -->
    <nav class="flex items-center gap-1">
      <!-- Previous Button -->
      <button
        @click="previousPage"
        :disabled="currentPage === 1"
        class="px-3 py-2 text-sm font-medium rounded-lg border transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        :class="
          currentPage === 1
            ? 'border-gray-300 dark:border-gray-600 text-gray-400 dark:text-gray-500'
            : 'border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800'
        "
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
        </svg>
      </button>

      <!-- Page Numbers -->
      <button
        v-for="(page, index) in pages"
        :key="index"
        @click="goToPage(page)"
        :disabled="page === '...'"
        class="min-w-[2.5rem] px-3 py-2 text-sm font-medium rounded-lg border transition-colors"
        :class="
          page === currentPage
            ? 'border-[#5A3D22] bg-[#5A3D22] text-white'
            : page === '...'
            ? 'border-transparent text-gray-400 dark:text-gray-500 cursor-default'
            : 'border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800'
        "
      >
        {{ page }}
      </button>

      <!-- Next Button -->
      <button
        @click="nextPage"
        :disabled="currentPage === lastPage"
        class="px-3 py-2 text-sm font-medium rounded-lg border transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        :class="
          currentPage === lastPage
            ? 'border-gray-300 dark:border-gray-600 text-gray-400 dark:text-gray-500'
            : 'border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800'
        "
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
        </svg>
      </button>
    </nav>
  </div>
</template>
