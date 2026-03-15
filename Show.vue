<script setup lang="ts">
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AppLayout from '@/layouts/AppLayout.vue';
import Card from '@/components/ui/Card.vue';
import Button from '@/components/ui/Button.vue';
import Badge from '@/components/ui/Badge.vue';
import Select from '@/components/ui/Select.vue';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import Textarea from '@/components/ui/Textarea.vue';
import { getContrastingTextColor } from '@/lib/utils';

interface User {
  id: number;
  name: string;
  email: string;
  phone?: string;
  profession?: string;
}

interface Package {
  name: string;
  description: string;
  base_price: number;
  duration_hours: number;
  photos_included: number;
}

interface Theme {
  id: number;
  name: string;
  event_type: string;
  color_palette: any;
}

interface Payment {
  id: number;
  amount: number;
  payment_method: string;
  status: string;
  payment_date?: string;
  proof_path?: string;
}

interface Booking {
  id: number;
  event_type: string;
  event_date: string;
  event_time: string;
  venue: string;
  expected_guests?: number;
  special_requests?: string;
  contact_phone: string;
  contact_email: string;
  status: 'pending' | 'confirmed' | 'cancelled' | 'completed';
  total_cost: number;
  user: User;
  package: Package;
  theme?: Theme;
  payments: Payment[];
  photographer?: User;
  videographer?: User;
  photographer_id?: number;
  videographer_id?: number;
  created_at: string;
  confirmed_at?: string;
  notes?: string;
}

interface Props {
  booking: Booking;
  photographers: User[];
  videographers: User[];
}

const props = defineProps<Props>();

const showCancelDialog = ref(false);
const cancelReason = ref('');
const processing = ref(false);
const selectedPhotographer = ref(props.booking.photographer_id || null);
const selectedVideographer = ref(props.booking.videographer_id || null);

const getStatusBadgeStyle = (status: string): Record<string, string> => {
  const backgroundByStatus: Record<string, string> = {
    pending: '#B58C3C',
    confirmed: '#5A3D22',
    cancelled: '#8A3D2E',
    completed: '#3F2B19',
  };

  const backgroundColor = backgroundByStatus[status] || '#B58C3C';
  return {
    backgroundColor,
    color: getContrastingTextColor(backgroundColor),
  };
};

const getPaymentStatusBadgeStyle = (status: string): Record<string, string> => {
  const backgroundByStatus: Record<string, string> = {
    pending: '#B58C3C',
    verified: '#5A3D22',
    rejected: '#8A3D2E',
  };

  const backgroundColor = backgroundByStatus[status] || '#B58C3C';
  return {
    backgroundColor,
    color: getContrastingTextColor(backgroundColor),
  };
};

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('en-US', {
    weekday: 'long',
    month: 'long',
    day: 'numeric',
    year: 'numeric',
  });
};

const formatCurrency = (amount: number) => {
  return new Intl.NumberFormat('en-PH', {
    style: 'currency',
    currency: 'PHP',
  }).format(amount);
};

const hasVerifiedPayment = () => {
  return props.booking.payments.some(p => p.status === 'verified');
};

const handleConfirm = () => {
  if (confirm('Are you sure you want to confirm this booking?')) {
    processing.value = true;
    router.post(`/event-manager/reservations/${props.booking.id}/confirm`, {}, {
      preserveScroll: true,
      onFinish: () => {
        processing.value = false;
      },
    });
  }
};

const handleCancel = () => {
  if (!cancelReason.value.trim()) {
    alert('Please provide a reason for cancellation');
    return;
  }

  processing.value = true;
  router.post(`/event-manager/reservations/${props.booking.id}/cancel`, {
    reason: cancelReason.value,
  }, {
    preserveScroll: true,
    onSuccess: () => {
      showCancelDialog.value = false;
      cancelReason.value = '';
    },
    onFinish: () => {
      processing.value = false;
    },
  });
};

const handleConfirmed = () => {
  if (confirm('Mark this booking as confirmed?')) {
    processing.value = true;
    router.post(`/event-manager/reservations/${props.booking.id}/complete`, {}, {
      preserveScroll: true,
      onFinish: () => {
        processing.value = false;
      },
    });
  }
};

const assignPhotographer = () => {
  if (!selectedPhotographer.value) {
    alert('Please select a photographer');
    return;
  }
  processing.value = true;
  router.post(`/event-manager/reservations/${props.booking.id}/assign-photographer`, {
    photographer_id: selectedPhotographer.value,
  }, {
    preserveScroll: true,
    onFinish: () => {
      processing.value = false;
    },
  });
};

const assignVideographer = () => {
  if (!selectedVideographer.value) {
    alert('Please select a videographer');
    return;
  }
  processing.value = true;
  router.post(`/event-manager/reservations/${props.booking.id}/assign-videographer`, {
    videographer_id: selectedVideographer.value,
  }, {
    preserveScroll: true,
    onFinish: () => {
      processing.value = false;
    },
  });
};
</script>

<template>
  <Head :title="`Booking #${booking.id}`" />

  <AppLayout>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Header -->
      <div class="mb-8">
        <Link href="/event-manager/reservations" 
              class="inline-flex items-center text-sm text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white mb-6 group">
          <svg class="w-4 h-4 mr-2 transform group-hover:-translate-x-1 transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
          </svg>
          Back to Booking List
        </Link>
        
        <div class="flex items-start justify-between border-b border-gray-200 dark:border-gray-700 pb-6">
          <div>
            <h1 class="text-3xl font-light text-gray-900 dark:text-white mb-2">Booking #{{ booking.id }}</h1>
            <p class="text-sm text-gray-500 dark:text-gray-400">
              {{ formatDate(booking.created_at) }}
            </p>
          </div>
          <Badge :style="getStatusBadgeStyle(booking.status)" class="text-sm px-4 py-1.5">
            {{ booking.status }}
          </Badge>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Main Content -->
        <div class="lg:col-span-2 space-y-6">
          <!-- Customer Details -->
          <Card>
            <h2 class="text-lg font-medium text-gray-900 dark:text-white mb-6 pb-3 border-b border-gray-200 dark:border-gray-700">Customer Details</h2>
            <div class="space-y-4">
              <div>
                <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Name</label>
                <p class="text-base text-gray-900 dark:text-white mt-1">{{ booking.user.name }}</p>
              </div>
              <div>
                <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Email</label>
                <p class="text-base text-gray-900 dark:text-white mt-1 break-all">{{ booking.contact_email }}</p>
              </div>
              <div>
                <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Phone</label>
                <p class="text-base text-gray-900 dark:text-white mt-1">{{ booking.contact_phone }}</p>
              </div>
            </div>
          </Card>

          <!-- Event Details -->
          <Card>
            <h2 class="text-lg font-medium text-gray-900 dark:text-white mb-6 pb-3 border-b border-gray-200 dark:border-gray-700">Event Details</h2>
            <div class="space-y-6">
              <div class="grid grid-cols-2 gap-x-8 gap-y-4">
                <div>
                  <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Event Type</label>
                  <p class="text-base text-gray-900 dark:text-white mt-1 capitalize">{{ booking.event_type }}</p>
                </div>
                <div>
                  <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Event Date</label>
                  <p class="text-base text-gray-900 dark:text-white mt-1">{{ formatDate(booking.event_date) }}</p>
                </div>
                <div>
                  <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Event Time</label>
                  <p class="text-base text-gray-900 dark:text-white mt-1">{{ booking.event_time }}</p>
                </div>
                <div>
                  <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Expected Guests</label>
                  <p class="text-base text-gray-900 dark:text-white mt-1">{{ booking.guest_count ?? booking.expected_guests ?? 'Not specified' }}</p>
                </div>
              </div>
              
              <div class="pt-4 border-t border-gray-200 dark:border-gray-700">
                <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Venue</label>
                <p class="text-base text-gray-900 dark:text-white mt-1">{{ booking.venue }}</p>
              </div>

              <div v-if="booking.special_requests" class="pt-4 border-t border-gray-200 dark:border-gray-700">
                <label class="text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wide">Special Requests</label>
                <p class="text-base text-gray-600 dark:text-gray-300 mt-1 italic">{{ booking.special_requests }}</p>
              </div>
            </div>
          </Card>

          <!-- Package Details -->
          <Card>
            <h2 class="text-lg font-medium text-gray-900 dark:text-white mb-6 pb-3 border-b border-gray-200 dark:border-gray-700">Package Details</h2>
            <div class="space-y-4">
              <div>
                <h4 class="text-lg font-semibold text-gray-900 dark:text-white">
                  {{ booking.package.name }}
                </h4>
              </div>
              <div class="grid grid-cols-2 gap-4">
                <div>
                  <label class="block text-sm font-medium text-gray-500 dark:text-gray-400 mb-1">
                    Duration
                  </label>
                  <p class="text-gray-900 dark:text-white">
                    {{ booking.package.duration_hours && booking.package.duration_hours > 0 ? `${booking.package.duration_hours} hours` : 'Full coverage' }}
                  </p>
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-500 dark:text-gray-400 mb-1">
                    Photos Included
                  </label>
                  <p class="text-gray-900 dark:text-white">
                    <span v-if="booking.package.photos_included === 0 || booking.package.photos_included === -1">Unlimited</span>
                    <span v-else>{{ booking.package.photos_included }}</span>
                  </p>
                </div>
              </div>
            </div>
          </Card>

          <!-- Theme (if selected) -->
          <Card v-if="booking.theme">
            <h2 class="text-xl font-bold text-gray-900 dark:text-white mb-4">Selected Theme</h2>
            <div class="flex items-center space-x-3">
              <div 
                class="w-12 h-12 rounded-lg"
                :style="{ backgroundColor: booking.theme.color_palette?.primary || '#3b82f6' }"
              ></div>
              <div>
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">{{ booking.theme.name }}</h3>
                <p class="text-sm text-gray-600 dark:text-gray-400">{{ booking.theme.event_type }}</p>
              </div>
            </div>
            <div v-if="booking.generated_theme_images && booking.generated_theme_images.length > 0" class="mt-4">
              <label class="block text-sm font-medium text-gray-500 dark:text-gray-400 mb-1">
                Confirmed Theme Image
              </label>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div v-for="(img, idx) in booking.generated_theme_images" :key="idx" class="rounded-lg overflow-hidden border border-gray-300">
                  <img :src="img" alt="Confirmed Theme Image" class="w-full h-full object-cover" />
                </div>
              </div>
            </div>
          </Card>

          <!-- Payment Status -->
          <Card>
            <h2 class="text-xl font-bold text-gray-900 dark:text-white mb-4">Payment Status</h2>
            
            <div v-if="booking.payments.length === 0" class="text-center py-8 text-gray-500 dark:text-gray-400">
              <svg class="w-12 h-12 mx-auto mb-3 text-gray-300 dark:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
              <p>No payment submitted yet</p>
            </div>

            <div v-else class="space-y-3">
              <div v-for="payment in booking.payments" :key="payment.id"
                   class="border rounded-lg p-4 dark:border-gray-700">
                <div class="flex items-center justify-between mb-2">
                  <span class="font-medium text-gray-900 dark:text-white">
                    {{ formatCurrency(payment.amount) }}
                  </span>
                  <Badge :style="getPaymentStatusBadgeStyle(payment.status)">
                    {{ payment.status }}
                  </Badge>
                </div>
                <div class="text-sm text-gray-600 dark:text-gray-400 space-y-1">
                  <p>Method: paymongo</p>
                  <p v-if="payment.payment_date">Date: {{ formatDate(payment.payment_date) }}</p>
                </div>
                <div v-if="payment.proof_path" class="mt-3">
                  <Link :href="`/event-manager/payments/${payment.id}`">
                    <Button variant="secondary" size="sm">View Proof</Button>
                  </Link>
                </div>
              </div>
            </div>
          </Card>

          <!-- Team Assignment -->
          <Card>
            <h2 class="text-lg font-medium text-gray-900 dark:text-white mb-6 pb-3 border-b border-gray-200 dark:border-gray-700">Assign Team</h2>
            <div class="space-y-4">
              <!-- Photographer Assignment -->
              <div class="space-y-2">
                <label class="text-sm font-medium text-gray-700 dark:text-gray-300">Photographer</label>
                <p v-if="booking.photographer" class="text-sm text-gray-600 dark:text-gray-400 mb-2">
                  Current: <span class="font-semibold">{{ booking.photographer.name }}</span>
                </p>
                <div class="flex gap-2">
                  <select 
                    v-model="selectedPhotographer"
                    class="flex-1 px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                  >
                    <option :value="null">Select photographer...</option>
                    <option v-for="photographer in photographers" :key="photographer.id" :value="photographer.id">
                      {{ photographer.name }}{{ photographer.profession ? ` (${photographer.profession})` : '' }}
                    </option>
                  </select>
                  <Button 
                    @click="assignPhotographer" 
                    :disabled="processing || !selectedPhotographer"
                    variant="secondary"
                    size="sm"
                  >
                    Assign
                  </Button>
                </div>
              </div>

              <!-- Videographer Assignment -->
              <div class="space-y-2">
                <label class="text-sm font-medium text-gray-700 dark:text-gray-300">Videographer</label>
                <p v-if="booking.videographer" class="text-sm text-gray-600 dark:text-gray-400 mb-2">
                  Current: <span class="font-semibold">{{ booking.videographer.name }}</span>
                </p>
                <div class="flex gap-2">
                  <select 
                    v-model="selectedVideographer"
                    class="flex-1 px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                  >
                    <option :value="null">Select videographer...</option>
                    <option v-for="videographer in videographers" :key="videographer.id" :value="videographer.id">
                      {{ videographer.name }}{{ videographer.profession ? ` (${videographer.profession})` : '' }}
                    </option>
                  </select>
                  <Button 
                    @click="assignVideographer" 
                    :disabled="processing || !selectedVideographer"
                    variant="secondary"
                    size="sm"
                  >
                    Assign
                  </Button>
                </div>
              </div>
            </div>
          </Card>
        </div>

        <!-- Sidebar Actions -->
        <div class="space-y-6">
          <!-- Quick Actions -->
          <Card>
            <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-6 pb-3 border-b border-gray-200 dark:border-gray-700">Actions</h3>
            <div class="space-y-3">
              <!-- Accept Button (Confirm) -->
              <Button
                v-if="booking.status === 'pending'"
                @click="handleConfirm"
                :disabled="!hasVerifiedPayment() || processing"
                class="w-full bg-[#5A3D22] hover:bg-[#5A3D22] text-white"
                :class="{ 'opacity-50 cursor-not-allowed': !hasVerifiedPayment() }"
              >
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                Accept Booking
              </Button>

              <!-- Cancel Button -->
              <Button
                v-if="booking.status !== 'cancelled' && booking.status !== 'completed'"
                @click="showCancelDialog = true"
                variant="destructive"
                :disabled="processing"
                class="w-full"
              >
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
                Cancel Booking
              </Button>

              <!-- Confirmed Button -->
              <Button
                v-if="booking.status === 'confirmed'"
                @click="handleConfirmed"
                variant="secondary"
                :disabled="processing"
                class="w-full"
              >
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                Mark as Confirmed
              </Button>

              <div v-if="!hasVerifiedPayment() && booking.status === 'pending'" class="text-sm text-[#3F2B19] dark:text-[#F5F3ED] bg-[#B58C3C]/20 dark:bg-[#B58C3C]/20 p-3 rounded border border-[#B58C3C] dark:border-[#B58C3C]">
                ⚠️ Payment must be verified before confirming booking
              </div>
            </div>
          </Card>

          <!-- Summary -->
          <Card>
            <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-6 pb-3 border-b border-gray-200 dark:border-gray-700">Booking Summary</h3>
            <div class="space-y-4">
              <div class="flex justify-between text-sm">
                <span class="text-gray-600 dark:text-gray-400">Package Price</span>
                <span class="font-medium text-gray-900 dark:text-white">{{ formatCurrency(booking.package.base_price) }}</span>
              </div>
              <div class="pt-4 border-t border-gray-200 dark:border-gray-700">
                <div class="flex justify-between items-center">
                  <span class="text-sm text-gray-600 dark:text-gray-400">Total Amount</span>
                  <span class="text-2xl font-light text-gray-900 dark:text-white">{{ formatCurrency(booking.total_cost) }}</span>
                </div>
              </div>
            </div>
          </Card>

          <!-- Notes -->
          <Card v-if="booking.notes">
            <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-3">Notes</h3>
            <p class="text-sm text-gray-700 dark:text-gray-300 bg-gray-50 dark:bg-gray-800 p-3 rounded-lg">
              {{ booking.notes }}
            </p>
          </Card>
        </div>
      </div>
    </div>

    <!-- Cancel Dialog -->
    <Dialog v-model:open="showCancelDialog">
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Cancel Booking</DialogTitle>
          <DialogDescription>
            Please provide a reason for cancelling this booking. This will be communicated to the customer.
          </DialogDescription>
        </DialogHeader>
        
        <div class="py-4">
          <Textarea
            v-model="cancelReason"
            placeholder="Enter cancellation reason..."
            :rows="4"
            class="w-full"
          />
        </div>

        <DialogFooter>
          <Button variant="ghost" @click="showCancelDialog = false" :disabled="processing">
            Close
          </Button>
          <Button variant="destructive" @click="handleCancel" :disabled="processing || !cancelReason.trim()">
            <span v-if="processing">Cancelling...</span>
            <span v-else>Confirm Cancellation</span>
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  </AppLayout>
</template>
