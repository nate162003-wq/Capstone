<script setup lang="ts">
import { ref, computed } from 'vue';
import Button from '@/components/ui/Button.vue';
import Input from '@/components/ui/Input.vue';
import Textarea from '@/components/ui/Textarea.vue';
import Select from '@/components/ui/Select.vue';

interface Props {
  open: boolean;
  eventTypes?: string[];
}

const props = withDefaults(defineProps<Props>(), {
  eventTypes: () => ['wedding', 'corporate', 'birthday', 'anniversary', 'engagement', 'reception', 'create idea'],
});

const emit = defineEmits<{
  close: [];
  themeGenerated: [theme: { id: number; name: string }];
}>();

const isLoading = ref(false);
const generationProgress = ref<'idle' | 'generating' | 'success' | 'error'>('idle');
const errorMessage = ref('');
const generatedThemeId = ref<number | null>(null);
const generatedImages = ref<string[]>([]);
const pollAttempts = ref(0);
const maxPollAttempts = 180; // 3 minute timeout

const formData = ref({
  name: '',
  description: '',
  event_type: 'wedding',
  prompt: '',
  color_preferences: {
    primary: '#FF6B6B',
    secondary: '#4ECDC4',
    accent: '#FFE66D',
  },
});

const isFormValid = computed(() => {
  return formData.value.name.trim().length > 0 &&
         formData.value.event_type.length > 0 &&
         formData.value.prompt.trim().length >= 10;
});

const submitForm = async () => {
  if (!isFormValid.value || isLoading.value) return;

  isLoading.value = true;
  generationProgress.value = 'generating';
  errorMessage.value = '';

  try {
    const response = await fetch('/customer/themes/generate/new', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
      credentials: 'same-origin', // Include cookies for session
      body: JSON.stringify(formData.value),
    });

    let data;
    try {
      data = await response.json();
    } catch (parseError) {
      console.error('Failed to parse response as JSON:', response.status, response.statusText);
      const text = await response.text();
      console.error('Response body:', text);
      
      // Log headers for debugging
      throw new Error(`Server error: ${response.status} ${response.statusText}`);
    }

    if (!response.ok) {
      throw new Error(data.message || `Failed to generate theme (${response.status})`);
    }

    generatedThemeId.value = data.theme.id;

    const immediateImageUrl = data?.theme?.image_url;
    if (immediateImageUrl) {
      generatedImages.value = [immediateImageUrl];
      generationProgress.value = 'success';
    } else {
      generationProgress.value = 'success';
      startPolling(data.theme.id);
    }
  } catch (error) {
    console.error('Generation error:', error);
    errorMessage.value = error instanceof Error ? error.message : 'An error occurred during generation';
    generationProgress.value = 'error';
  } finally {
    isLoading.value = false;
  }
};

const startPolling = async (themeId: number) => {
  pollAttempts.value = 0;

  const pollForImages = async () => {
    try {
      const statusResponse = await fetch(`/customer/themes/${themeId}/status`, {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
        credentials: 'same-origin',
      });
      
      const statusData = await statusResponse.json();
      
      // Check for images in multiple possible response shapes
      const images = statusData.data?.images || statusData.data?.generated_images || [];
      const singleImageUrl = statusData.data?.image_url;
      
      if (images && images.length > 0) {
        generatedImages.value = images.map((img: any) => 
          typeof img === 'string' ? img : img.url
        );
        
        // Set success state and stop polling
        generationProgress.value = 'success';
        return;
      }

      if (singleImageUrl) {
        generatedImages.value = [singleImageUrl];
        generationProgress.value = 'success';
        return;
      }
      
      pollAttempts.value++;
      if (pollAttempts.value < maxPollAttempts) {
        // Wait 1 second before next poll
        setTimeout(pollForImages, 1000);
      } else {
        // Timeout - show error and allow reprompt
        generationProgress.value = 'error';
        errorMessage.value = 'Image generation is taking longer than expected. You can reprompt or try again.';
      }
    } catch (error) {
      console.error('Error polling for images:', error);
      pollAttempts.value++;
      if (pollAttempts.value < maxPollAttempts) {
        setTimeout(pollForImages, 1000);
      } else {
        generationProgress.value = 'error';
        errorMessage.value = 'Image generation failed while polling. Please reprompt and try again.';
      }
    }
  };

  pollForImages();
};

const resetForm = () => {
  formData.value = {
    name: '',
    description: '',
    event_type: 'wedding',
    prompt: '',
    color_preferences: {
      primary: '#FF6B6B',
      secondary: '#4ECDC4',
      accent: '#FFE66D',
    },
  };
  generationProgress.value = 'idle';
  errorMessage.value = '';
  generatedThemeId.value = null;
  generatedImages.value = [];
};

const repromptTheme = () => {
  generationProgress.value = 'idle';
  errorMessage.value = '';
  generatedThemeId.value = null;
  generatedImages.value = [];
};

const continuePolling = () => {
  if (generatedThemeId.value) {
    generationProgress.value = 'generating';
    errorMessage.value = '';
    startPolling(generatedThemeId.value);
  }
};

const closeModal = () => {
  if (!isLoading.value) {
    resetForm();
    emit('close');
  }
};

const confirmThemeGeneration = () => {
  if (generatedThemeId.value) {
    emit('themeGenerated', {
      id: generatedThemeId.value,
      name: formData.value.name,
    });
    resetForm();
    emit('close');
  }
};
</script>

<template>
  <div
    v-if="open"
    class="fixed inset-0 z-50 flex items-center justify-center"
    @click.self="closeModal"
  >
    <!-- Backdrop -->
    <div class="absolute inset-0 bg-black/50 backdrop-blur-sm"></div>

    <!-- Modal -->
    <div class="relative bg-white rounded-2xl shadow-2xl border border-gray-200 max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto">
      <!-- Close Button -->
      <button
        @click="closeModal"
        :disabled="isLoading"
        class="absolute top-4 right-4 p-2 text-gray-500 hover:text-gray-800 disabled:opacity-50"
      >
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>

      <!-- Content -->
      <div class="p-8">
        <!-- Header -->
        <h2 class="text-3xl font-bold text-gray-900 mb-2">Generate AI Theme</h2>
        <p class="text-gray-600 mb-6">Create a custom event theme using artificial intelligence</p>

        <!-- Success State -->
        <div v-if="generationProgress === 'success'" class="space-y-4">
          <div class="p-4 bg-green-500/10 border border-green-500/30 rounded-lg">
            <div class="flex items-center gap-3 text-green-400">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
              <span>
                <span v-if="generatedImages.length > 0">Theme generated successfully! Review below.</span>
                <span v-else>Generating theme images... (this may take up to 30 seconds)</span>
              </span>
            </div>
          </div>
          
          <!-- Generated Images -->
          <div v-if="generatedImages.length > 0" class="space-y-3">
            <p class="text-sm font-semibold text-gray-700">Generated Theme Image:</p>
            <div class="grid grid-cols-1 gap-3">
              <div 
                v-for="(image, index) in generatedImages" 
                :key="index"
                class="aspect-video rounded-lg overflow-hidden border border-gray-300 hover:border-[#5A3D22] transition-colors"
              >
                <img 
                  :src="image" 
                  :alt="`Generated theme image ${index + 1}`"
                  class="w-full h-full object-cover"
                />
              </div>
            </div>
            
            <!-- Confirm/Reject Buttons -->
            <div class="flex gap-3 pt-4">
              <button
                @click="confirmThemeGeneration"
                type="button"
                class="flex-1 px-4 py-2 bg-green-600 hover:bg-green-700 text-white font-semibold rounded-lg transition-colors"
              >
                Confirm & Use Theme
              </button>
                <button
                @click="repromptTheme"
                type="button"
                  class="flex-1 px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold rounded-lg transition-colors"
              >
                Reprompt
              </button>
            </div>
          </div>
        </div>

        <!-- Error State -->
        <div v-if="generationProgress === 'error' && errorMessage" class="mb-6 p-4 bg-red-500/10 border border-red-500/30 rounded-lg">
          <div class="flex items-start gap-3">
            <svg class="w-5 h-5 text-red-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4v.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <div>
              <p class="font-semibold text-red-400">Generation Failed</p>
              <p class="text-red-300 text-sm">{{ errorMessage }}</p>
              <div class="flex gap-3 mt-4">
                <button
                  type="button"
                  @click="continuePolling"
                  class="px-4 py-2 bg-slate-700 hover:bg-slate-600 text-white font-semibold rounded-lg transition-colors"
                >
                  Keep Waiting
                </button>
                <button
                  type="button"
                  @click="repromptTheme"
                  class="px-4 py-2 bg-[#5A3D22] hover:bg-[#5A3D22] text-white font-semibold rounded-lg transition-colors"
                >
                  Reprompt
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Form -->
        <form v-if="generationProgress !== 'success'" @submit.prevent="submitForm" class="space-y-6">
          <!-- Event Name -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Event Name *</label>
            <Input
              v-model="formData.name"
              type="text"
              placeholder="e.g., Summer Romance, Winter Wonderland"
              :disabled="isLoading"
              class="w-full"
            />
            <p class="text-xs text-gray-500 mt-1">Give your event a memorable name</p>
          </div>

          <!-- Event Type -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Event Type *</label>
            <Select
              v-model="formData.event_type"
              :options="props.eventTypes.map(type => ({
                value: type,
                label: type.charAt(0).toUpperCase() + type.slice(1),
              }))"
              :disabled="isLoading"
              class="w-full"
            />
          </div>

          <!-- AI Prompt -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Theme Description *</label>
            <Textarea
              v-model="formData.prompt"
              placeholder="Describe the visual theme you want. E.g., 'Elegant outdoor wedding with sunset colors, rose gold accents, romantic floral arrangements'"
              :rows="4"
              :disabled="isLoading"
              class="w-full"
            />
            <p class="text-xs text-gray-500 mt-1">Be descriptive! The AI will use this to generate your theme visuals.</p>
          </div>

          <!-- Generating Indicator -->
          <div v-if="generationProgress === 'generating'" class="p-4 bg-[#5A3D22]/10 border border-[#5A3D22]/30 rounded-lg">
            <div class="flex items-center gap-3">
              <div class="animate-spin">
                <svg class="w-5 h-5 text-[#5A3D22]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
              </div>
              <div>
                <p class="font-semibold text-[#5A3D22]">Generating your theme...</p>
                <p class="text-[#5A3D22] text-sm">This may take a few minutes</p>
              </div>
            </div>
          </div>

          <!-- Actions -->
          <div class="flex gap-3 pt-4">
            <button
              type="button"
              @click="closeModal"
              :disabled="isLoading"
              class="flex-1 px-4 py-2 rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-100 disabled:opacity-50 transition-colors"
            >
              Cancel
            </button>
            <Button
              type="submit"
              :disabled="!isFormValid || isLoading"
              class="flex-1"
            >
              <span v-if="!isLoading">Generate Theme</span>
              <span v-else class="flex items-center justify-center gap-2">
                <svg class="w-4 h-4 animate-spin" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
                Generating...
              </span>
            </Button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
