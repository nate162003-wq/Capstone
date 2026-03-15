<template>
  <div class="space-y-1">
    <label v-if="label" :for="id" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
      {{ label }}
      <span v-if="required" class="text-red-500">*</span>
    </label>
    <textarea
      :id="id"
      v-model="textareaValue"
      :placeholder="placeholder"
      :disabled="disabled"
      :required="required"
      :rows="rows"
      :class="textareaClasses"
    ></textarea>
    <p v-if="error" class="text-sm text-red-600 dark:text-red-400">{{ error }}</p>
    <p v-else-if="hint" class="text-sm text-gray-500 dark:text-gray-400">{{ hint }}</p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  modelValue?: string;
  label?: string;
  placeholder?: string;
  error?: string;
  hint?: string;
  disabled?: boolean;
  required?: boolean;
  rows?: number;
  id?: string;
}

const props = withDefaults(defineProps<Props>(), {
  disabled: false,
  required: false,
  rows: 4,
});

const emit = defineEmits<{
  'update:modelValue': [value: string];
}>();

const textareaValue = computed({
  get: () => props.modelValue,
  set: (value) => emit('update:modelValue', value),
});

const textareaClasses = computed(() => [
  'block w-full px-4 py-2 border rounded-lg shadow-sm',
  'focus:outline-none focus:ring-2 focus:ring-offset-0',
  'transition-colors duration-200',
  'dark:bg-gray-900 dark:text-white',
  'resize-none',
  {
    'border-red-300 focus:ring-red-500 focus:border-red-500': props.error,
    'border-gray-300 dark:border-gray-600 focus:ring-[#5A3D22] focus:border-[#5A3D22]': !props.error,
    'opacity-50 cursor-not-allowed bg-gray-50': props.disabled,
  },
]);
</script>
