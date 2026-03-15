<script setup lang="ts">
import { ref, computed } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AppLayout from '@/layouts/AppLayout.vue';
import Card from '@/components/ui/Card.vue';
import Button from '@/components/ui/Button.vue';
import { getContrastingTextColor } from '@/lib/utils';

interface Booking {
  id: number;
  title: string;
  date: string;
  status: string;
  package: string;
  time: string;
  venue: string;
}

interface Holiday {
  id: number;
  date: string;
  name: string;
  description?: string;
  is_recurring: boolean;
}

interface Props {
  bookings: Booking[];
  holidays: Holiday[];
  bookedDates: string[];
  holidayDates: string[];
}

const props = defineProps<Props>();

const currentDate = ref(new Date());
const selectedDate = ref<string | null>(null);

const currentMonth = computed(() => currentDate.value.getMonth());
const currentYear = computed(() => currentDate.value.getFullYear());

const monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];

const daysInMonth = computed(() => {
  return new Date(currentYear.value, currentMonth.value + 1, 0).getDate();
});

const firstDayOfMonth = computed(() => {
  return new Date(currentYear.value, currentMonth.value, 1).getDay();
});

const calendarDays = computed(() => {
  const days = [];
  const totalDays = daysInMonth.value;
  const firstDay = firstDayOfMonth.value;

  // Add empty slots for days before the first day of the month
  for (let i = 0; i < firstDay; i++) {
    days.push(null);
  }

  // Add all days of the month
  for (let day = 1; day <= totalDays; day++) {
    days.push(day);
  }

  return days;
});

const formatDate = (day: number) => {
  const month = String(currentMonth.value + 1).padStart(2, '0');
  const dayStr = String(day).padStart(2, '0');
  return `${currentYear.value}-${month}-${dayStr}`;
};

const getDayStatus = (day: number | null) => {
  if (!day) return 'empty';
  
  const dateStr = formatDate(day);
  
  // Check if holiday (red)
  if (props.holidayDates.includes(dateStr)) {
    return 'holiday';
  }
  
  // Check if booked (blue)
  if (props.bookedDates.includes(dateStr)) {
    return 'booked';
  }
  
  // Check if date is in the past
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const checkDate = new Date(currentYear.value, currentMonth.value, day);
  
  if (checkDate < today) {
    return 'past';
  }
  
  // Otherwise available (green)
  return 'available';
};

const getDayClass = (day: number | null) => {
  if (!day) return 'invisible';
  
  const status = getDayStatus(day);
  const dateStr = formatDate(day);
  const isSelected = selectedDate.value === dateStr;
  
  const baseClass = 'relative h-24 p-2 border cursor-pointer transition-all hover:shadow-lg';
  
  if (isSelected) {
    return `${baseClass} ring-2 ring-[#9F544A] z-10`;
  }
  
  switch (status) {
    case 'holiday':
      return `${baseClass} bg-yellow-200 border-yellow-500 hover:bg-yellow-300`;
    case 'booked':
      return `${baseClass} bg-gradient-to-br from-[#5A3735] to-[#9F544A] border-[#9F544A] hover:from-[#9F544A] hover:to-[#C2613A] text-[#FDF7F5]`;
    case 'past':
      return `${baseClass} bg-gray-100 border-gray-200 text-gray-400 cursor-not-allowed`;
    case 'available':
      return `${baseClass} bg-green-100 border-green-600 hover:bg-green-200`;
    default:
      return baseClass;
  }
};

const getBookingsForDate = (day: number | null) => {
  if (!day) return [];
  const dateStr = formatDate(day);
  return props.bookings.filter(b => b.date === dateStr);
};

const getHolidayForDate = (day: number | null) => {
  if (!day) return null;
  const dateStr = formatDate(day);
  return props.holidays.find(h => h.date === dateStr);
};

const getBookingStatusChipStyle = (status: string): Record<string, string> => {
  const backgroundColor = status === 'confirmed' ? '#5A3735' : '#9F544A';
  return {
    backgroundColor,
    color: getContrastingTextColor(backgroundColor),
  };
};

const selectDate = (day: number | null) => {
  if (!day) return;
  const dateStr = formatDate(day);
  selectedDate.value = selectedDate.value === dateStr ? null : dateStr;
};

const previousMonth = () => {
  currentDate.value = new Date(currentYear.value, currentMonth.value - 1, 1);
};

const nextMonth = () => {
  currentDate.value = new Date(currentYear.value, currentMonth.value + 1, 1);
};

const goToToday = () => {
  currentDate.value = new Date();
  const today = new Date();
  const month = String(today.getMonth() + 1).padStart(2, '0');
  const day = String(today.getDate()).padStart(2, '0');
  selectedDate.value = `${today.getFullYear()}-${month}-${day}`;
};

const selectedDateBookings = computed(() => {
  if (!selectedDate.value) return [];
  return props.bookings.filter(b => b.date === selectedDate.value);
});

const selectedDateHoliday = computed(() => {
  if (!selectedDate.value) return null;
  return props.holidays.find(h => h.date === selectedDate.value);
});
</script>

<template>
  <Head title="Calendar - Event Manager" />

  <AppLayout>
    <div class="py-8">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Header -->
        <div class="mb-8 overflow-hidden rounded-3xl border border-[#EAC3BF]/60 bg-gradient-to-r from-[#5A3735] via-[#9F544A] to-[#C2613A] p-7 text-[#FDF7F5] shadow-xl">
          <div class="flex justify-between items-center">
          <div>
            <h1 class="text-3xl font-bold">Calendar View</h1>
            <p class="text-sm text-[#FDF7F5]/90 mt-1">Manage bookings and check availability</p>
          </div>
          <Link :href="'/event-manager/reservations'">
            <Button class="bg-[#FDF7F5]/20 hover:bg-[#FDF7F5]/30 text-[#FDF7F5] border border-[#FDF7F5]/30">Back to Reservations</Button>
          </Link>
          </div>
        </div>

        <!-- Legend -->
        <Card class="mb-6 border-2 border-[#EAC3BF]/50 bg-white/95">
          <div class="flex flex-wrap gap-6">
            <div class="flex items-center space-x-2">
              <div class="w-6 h-6 rounded bg-green-400 border-2 border-green-600"></div>
              <span class="text-sm font-medium text-gray-700">Available</span>
            </div>
            <div class="flex items-center space-x-2">
              <div class="w-6 h-6 rounded bg-gradient-to-br from-[#5A3735] to-[#9F544A] border-2 border-[#9F544A]"></div>
              <span class="text-sm font-medium text-gray-700">Booked</span>
            </div>
            <div class="flex items-center space-x-2">
              <div class="w-6 h-6 rounded bg-yellow-300 border-2 border-yellow-500"></div>
              <span class="text-sm font-medium text-gray-700">Holiday</span>
            </div>
            <div class="flex items-center space-x-2">
              <div class="w-6 h-6 rounded bg-gray-100 border-2 border-gray-400"></div>
              <span class="text-sm font-medium text-gray-700">Past Date</span>
            </div>
          </div>
        </Card>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <!-- Calendar -->
          <div class="lg:col-span-2">
            <Card class="border-2 border-[#EAC3BF]/50 bg-white/95">
              <!-- Calendar Header -->
              <div class="flex items-center justify-between mb-6">
                <Button @click="previousMonth" variant="ghost" size="sm" class="text-[#5A3735] hover:bg-[#FDF7F5]">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                  </svg>
                </Button>

                <h2 class="text-2xl font-bold text-[#5A3735]">
                  {{ monthNames[currentMonth] }} {{ currentYear }}
                </h2>

                <Button @click="nextMonth" variant="ghost" size="sm" class="text-[#5A3735] hover:bg-[#FDF7F5]">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                  </svg>
                </Button>
              </div>

              <div class="mb-4 text-center">
                <Button @click="goToToday" size="sm" class="bg-gradient-to-r from-[#5A3735] to-[#9F544A] text-[#FDF7F5] hover:from-[#9F544A] hover:to-[#C2613A]">Today</Button>
              </div>

              <!-- Days of Week -->
              <div class="grid grid-cols-7 gap-1 mb-2">
                <div v-for="day in ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']" :key="day"
                     class="text-center text-sm font-semibold text-[#5A3735] py-2">
                  {{ day }}
                </div>
              </div>

              <!-- Calendar Grid -->
              <div class="grid grid-cols-7 gap-1">
                <div v-for="(day, index) in calendarDays" :key="index"
                     :class="getDayClass(day)"
                     @click="selectDate(day)">
                  <div v-if="day" class="flex flex-col h-full">
                    <div class="font-semibold text-sm mb-1">{{ day }}</div>
                    
                    <!-- Holiday indicator -->
                    <div v-if="getHolidayForDate(day)" 
                      class="text-xs font-medium text-[#9F544A] mb-1 truncate"
                         :title="getHolidayForDate(day)?.name">
                      🎉 {{ getHolidayForDate(day)?.name }}
                    </div>

                    <!-- Bookings indicators -->
                    <div class="flex-1 space-y-1 overflow-hidden">
                      <div v-for="booking in getBookingsForDate(day).slice(0, 2)" :key="booking.id"
                           class="text-xs px-1 py-0.5 rounded truncate"
                           :style="getBookingStatusChipStyle(booking.status)"
                           :title="`${booking.title} - ${booking.time}`">
                        {{ booking.title.split(' - ')[0] }}
                      </div>
                      <div v-if="getBookingsForDate(day).length > 2"
                           class="text-xs text-[#FDF7F5]/90 font-medium">
                        +{{ getBookingsForDate(day).length - 2 }} more
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </Card>
          </div>

          <!-- Details Sidebar -->
          <div class="lg:col-span-1">
            <Card class="border-2 border-[#EAC3BF]/50 bg-white/95">
              <h3 class="text-lg font-bold text-[#5A3735] mb-4">
                {{ selectedDate ? `Details for ${selectedDate}` : 'Select a Date' }}
              </h3>

              <div v-if="!selectedDate" class="text-center text-gray-500 py-8">
                <svg class="w-16 h-16 mx-auto mb-4 text-[#9F544A]/45" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                </svg>
                <p class="text-sm">Click on a date to view details</p>
              </div>

              <div v-else class="space-y-4">
                <!-- Holiday Info -->
                <div v-if="selectedDateHoliday" class="bg-[#FDF7F5] border-2 border-[#EAC3BF] rounded-lg p-4">
                  <div class="flex items-start space-x-2">
                    <span class="text-2xl">🎉</span>
                    <div>
                      <h4 class="font-bold text-[#5A3735]">{{ selectedDateHoliday.name }}</h4>
                      <p v-if="selectedDateHoliday.description" class="text-sm text-[#9F544A] mt-1">
                        {{ selectedDateHoliday.description }}
                      </p>
                    </div>
                  </div>
                </div>

                <!-- Bookings List -->
                <div>
                  <h4 class="font-semibold text-[#5A3735] mb-3">
                    Bookings ({{ selectedDateBookings.length }})
                  </h4>

                  <div v-if="selectedDateBookings.length === 0" class="text-sm text-gray-500 text-center py-4">
                    No bookings for this date
                  </div>

                  <div v-else class="space-y-3">
                    <div v-for="booking in selectedDateBookings" :key="booking.id"
                         class="border rounded-lg p-3 hover:shadow-md transition-shadow"
                         :class="booking.status === 'confirmed' 
                           ? 'border-[#9F544A]/55 bg-gradient-to-r from-[#FDF7F5] to-[#EAC3BF]/45' 
                           : 'border-[#B77D77]/55 bg-gradient-to-r from-[#FDF7F5] to-[#EAC3BF]/35'">
                      <div class="flex items-start justify-between mb-2">
                        <h5 class="font-semibold text-sm text-gray-900">{{ booking.title }}</h5>
                        <span class="text-xs px-2 py-1 rounded-full font-medium"
                              :style="getBookingStatusChipStyle(booking.status)">
                          {{ booking.status }}
                        </span>
                      </div>
                      <div class="space-y-1 text-xs text-gray-600">
                        <div class="flex items-center">
                          <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                          </svg>
                          {{ booking.time }}
                        </div>
                        <div class="flex items-center">
                          <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                          </svg>
                          {{ booking.venue }}
                        </div>
                        <div class="flex items-center">
                          <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                          </svg>
                          {{ booking.package }}
                        </div>
                      </div>
                      <div class="mt-3">
                        <Link :href="`/event-manager/reservations/${booking.id}`">
                          <Button size="sm" class="w-full bg-gradient-to-r from-[#5A3735] to-[#9F544A] text-[#FDF7F5] hover:from-[#9F544A] hover:to-[#C2613A]">View Details</Button>
                        </Link>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Availability Status -->
                <div v-if="!selectedDateHoliday" 
                     class="border-t pt-4"
                     :class="selectedDateBookings.length > 0 
                       ? 'border-[#EAC3BF]' 
                       : 'border-[#EAC3BF]'">
                  <div class="flex items-center justify-between">
                    <span class="text-sm font-medium text-gray-700">Status:</span>
                    <span class="text-sm font-bold"
                          :class="selectedDateBookings.length > 0 
                            ? 'text-[#9F544A]' 
                            : 'text-[#5A3735]'">
                      {{ selectedDateBookings.length > 0 ? 'Booked' : 'Available' }}
                    </span>
                  </div>
                </div>
              </div>
            </Card>
          </div>
        </div>
      </div>
    </div>
  </AppLayout>
</template>
