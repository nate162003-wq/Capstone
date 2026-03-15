<script setup lang="ts">
import { Head, router } from '@inertiajs/vue3';
import { computed, ref, onMounted, onUnmounted } from 'vue';
import AppLayout from '@/layouts/AppLayout.vue';
import Card from '@/components/ui/Card.vue';
import Badge from '@/components/ui/Badge.vue';
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue';
import AggregationChart from '@/components/Charts/AggregationChart.vue';
import OperationalAnalyticsChart from '@/components/Charts/OperationalAnalyticsChart.vue';
import { getContrastingTextColor } from '@/lib/utils';

interface Props {
  overview?: {
    total_sales: number;
    total_bookings: number;
    paid_bookings: number;
  };
  analytics?: {
    total_bookings: number;
    total_revenue: number;
    pending_bookings: number;
    active_customers: number;
    revenue_by_month: Array<{ month: string; revenue: number }>;
    bookings_by_status: Array<{ status: string; count: number }>;
    popular_packages: Array<{ name: string; count: number; revenue: number }>;
    predictive: {
      revenue_forecast: {
        series: Array<{ label: string; amount: number; type: 'historical' | 'forecast' }>;
        next_month_forecast: number;
        historical_average: number;
        growth_vs_average_pct: number;
        confidence: number;
      };
      cancellation_risks: Array<{
        booking_id: number;
        customer_name: string;
        package_name: string;
        event_type: string;
        event_date: string;
        days_until_event: number;
        risk_score: number;
        risk_level: 'high' | 'medium' | 'low';
        reasons: string[];
      }>;
    };
    prescriptive: {
      recommended_actions: {
        forecast_reference: number;
        generated_at: string;
        actions: Array<{
          priority: 'high' | 'medium' | 'low';
          title: string;
          recommendation: string;
          expected_impact: string;
        }>;
      };
    };
    operational: {
      capacity: {
        daily_capacity: number;
        window_days: number;
        booked_slots: number;
        available_slots: number;
        utilization_rate: number;
        weekly_utilization: Array<{ week: string; booked: number; capacity: number; rate: number }>;
      };
      lead_time: {
        average_days: number;
        distribution: Array<{ bucket: string; count: number }>;
      };
      workload: {
        photographers: Array<{ name: string; count: number }>;
        videographers: Array<{ name: string; count: number }>;
        unassigned_bookings: number;
      };
      peak_day_heatmap: {
        days: Array<{ day: string; count: number }>;
        peak_day: string;
        peak_count: number;
      };
    };
    recent_bookings: Array<{
      id: number;
      event_type: string;
      user: { name: string };
      total_cost: number;
      status: string;
      created_at: string;
    }>;
  };
}

// Logout when user navigates back using browser buttons (enhanced security)
onMounted(() => {
  const handlePopState = () => {
    router.post('/logout', {}, {
      preserveState: false,
      preserveScroll: false,
    });
  };
  
  window.addEventListener('popstate', handlePopState);
  
  onUnmounted(() => {
    window.removeEventListener('popstate', handlePopState);
  });
});

const props = withDefaults(defineProps<Props>(), {
  overview: () => ({
    total_sales: 0,
    total_bookings: 0,
    paid_bookings: 0,
  }),
  analytics: () => ({
    total_bookings: 0,
    total_revenue: 0,
    pending_bookings: 0,
    active_customers: 0,
    revenue_by_month: [],
    bookings_by_status: [],
    popular_packages: [],
    predictive: {
      revenue_forecast: {
        series: [],
        next_month_forecast: 0,
        historical_average: 0,
        growth_vs_average_pct: 0,
        confidence: 0,
      },
      cancellation_risks: [],
    },
    prescriptive: {
      recommended_actions: {
        forecast_reference: 0,
        generated_at: '',
        actions: [],
      },
    },
    operational: {
      capacity: {
        daily_capacity: 0,
        window_days: 0,
        booked_slots: 0,
        available_slots: 0,
        utilization_rate: 0,
        weekly_utilization: [],
      },
      lead_time: {
        average_days: 0,
        distribution: [],
      },
      workload: {
        photographers: [],
        videographers: [],
        unassigned_bookings: 0,
      },
      peak_day_heatmap: {
        days: [],
        peak_day: 'N/A',
        peak_count: 0,
      },
    },
    recent_bookings: [],
  }),
});

const getHeatmapCellBackground = (count: number, maxCount: number) => {
  return `rgb(59 130 246 / ${heatmapOpacity(count, maxCount)})`;
};

const getHeatmapCellTextColor = (count: number, maxCount: number) => {
  const alpha = heatmapOpacity(count, maxCount);
  const red = Math.round(255 * (1 - alpha) + 59 * alpha);
  const green = Math.round(255 * (1 - alpha) + 130 * alpha);
  const blue = Math.round(255 * (1 - alpha) + 246 * alpha);
  return getContrastingTextColor(`rgb(${red}, ${green}, ${blue})`);
};

const formatCurrency = (amount: number) => {
  return new Intl.NumberFormat('en-PH', {
    style: 'currency',
    currency: 'PHP',
  }).format(amount);
};

const getStatusBadgeStyle = (status: string): Record<string, string> => {
  const normalizedStatus = status.toLowerCase();
  const backgroundByStatus: Record<string, string> = {
    pending: '#B77D77',
    confirmed: '#9F544A',
    cancelled: '#8A3D2E',
    completed: '#5A3735',
  };

  const backgroundColor = backgroundByStatus[normalizedStatus] || '#9F544A';
  return {
    backgroundColor,
    color: '#FDF7F5',
    borderColor: '#EAC3BF',
    fontWeight: '600',
  };
};

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  });
};

const barWidth = (value: number, max: number) => {
  if (!max || max <= 0) return '0%';
  return `${Math.max((value / max) * 100, 5)}%`;
};

const heatmapOpacity = (value: number, max: number) => {
  if (!max || max <= 0) return 0.12;
  return Math.max(0.12, Number((value / max).toFixed(2)));
};

const forecastSeriesMax = computed(() => {
  if (!analytics.value?.predictive?.revenue_forecast?.series?.length) {
    return 0;
  }

  return Math.max(...analytics.value.predictive.revenue_forecast.series.map((item) => item.amount), 0);
});

const getForecastBarHeight = (value: number) => {
  if (!forecastSeriesMax.value || forecastSeriesMax.value <= 0) {
    return '4%';
  }

  const ratio = (value / forecastSeriesMax.value) * 100;
  return `${Math.max(4, Math.min(ratio, 100))}%`;
};

const getRiskBadgeClasses = (riskLevel: 'high' | 'medium' | 'low') => {
  if (riskLevel === 'high') {
    return 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300';
  }

  if (riskLevel === 'medium') {
    return 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-300';
  }

  return 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-300';
};

const getActionPriorityClasses = (priority: 'high' | 'medium' | 'low') => {
  if (priority === 'high') {
    return 'border-red-300 bg-red-50 dark:border-red-800 dark:bg-red-900/10';
  }

  if (priority === 'medium') {
    return 'border-yellow-300 bg-yellow-50 dark:border-yellow-800 dark:bg-yellow-900/10';
  }

  return 'border-green-300 bg-green-50 dark:border-green-800 dark:bg-green-900/10';
};

const analytics = computed(() => props.analytics);
</script>

<template>
  <Head title="Analytics Dashboard" />

  <AppLayout>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Header -->
      <div class="mb-8 pb-6 border-b border-gray-200 dark:border-gray-700">
        <h1 class="text-3xl font-light text-gray-900 dark:text-white mb-1">Sales Overview</h1>
        <p class="text-sm text-gray-500 dark:text-gray-400">
          Business insights and performance metrics
        </p>
      </div>

      <!-- Overview Cards -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <Card class="hover:shadow-lg transition-shadow">
          <div class="p-6">
            <p class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2">Total Sales</p>
            <p class="text-3xl font-bold text-gray-900 dark:text-white">
              {{ formatCurrency(overview.total_sales) }}
            </p>
          </div>
        </Card>

        <Card class="hover:shadow-lg transition-shadow">
          <div class="p-6">
            <p class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2">Total Bookings</p>
            <p class="text-3xl font-bold text-gray-900 dark:text-white">
              {{ overview.total_bookings }}
            </p>
          </div>
        </Card>

        <Card class="hover:shadow-lg transition-shadow">
          <div class="p-6">
            <p class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2">Paid Bookings</p>
            <p class="text-3xl font-bold text-gray-900 dark:text-white">
              {{ overview.paid_bookings }}
            </p>
          </div>
        </Card>
      </div>

      <!-- Stats Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <Card :hover="false">
          <div class="flex items-center">
            <div class="flex-shrink-0 bg-[#5A3D22] dark:bg-[#5A3D22]/30 rounded-lg p-3">
              <svg class="w-6 h-6 text-[#5A3D22] dark:text-[#5A3D22]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Total Revenue</p>
              <p class="text-2xl font-bold text-gray-900 dark:text-white">
                {{ formatCurrency(analytics.total_revenue) }}
              </p>
            </div>
          </div>
        </Card>

        <Card :hover="false">
          <div class="flex items-center">
            <div class="flex-shrink-0 bg-green-100 dark:bg-green-900/30 rounded-lg p-3">
              <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Total Bookings</p>
              <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ analytics.total_bookings }}</p>
            </div>
          </div>
        </Card>

        <Card :hover="false">
          <div class="flex items-center">
            <div class="flex-shrink-0 bg-yellow-100 dark:bg-yellow-900/30 rounded-lg p-3">
              <svg class="w-6 h-6 text-yellow-600 dark:text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Pending</p>
              <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ analytics.pending_bookings }}</p>
            </div>
          </div>
        </Card>

        <Card :hover="false">
          <div class="flex items-center">
            <div class="flex-shrink-0 bg-[#3F2B19] dark:bg-[#3F2B19]/30 rounded-lg p-3">
              <svg class="w-6 h-6 text-[#3F2B19] dark:text-[#3F2B19]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Active Customers</p>
              <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ analytics.active_customers }}</p>
            </div>
          </div>
        </Card>
      </div>

      <!-- Predictive & Prescriptive Analytics -->
      <div class="mb-8">
        <h2 class="text-2xl font-light text-gray-900 dark:text-white mb-4">Predictive & Prescriptive Insights</h2>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card title="Revenue Forecast (Historical + Next 3 Months)">
            <div class="space-y-4">
              <div class="grid grid-cols-3 gap-3">
                <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-3">
                  <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">Next Month</p>
                  <p class="text-lg font-semibold text-gray-900 dark:text-white">
                    {{ formatCurrency(analytics.predictive.revenue_forecast.next_month_forecast) }}
                  </p>
                </div>
                <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-3">
                  <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">Vs Avg</p>
                  <p
                    class="text-lg font-semibold"
                    :class="analytics.predictive.revenue_forecast.growth_vs_average_pct >= 0
                      ? 'text-green-600 dark:text-green-400'
                      : 'text-red-600 dark:text-red-400'"
                  >
                    {{ analytics.predictive.revenue_forecast.growth_vs_average_pct }}%
                  </p>
                </div>
                <div class="rounded-lg border border-gray-200 dark:border-gray-700 p-3">
                  <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">Confidence</p>
                  <p class="text-lg font-semibold text-gray-900 dark:text-white">
                    {{ analytics.predictive.revenue_forecast.confidence }}%
                  </p>
                </div>
              </div>

              <div class="h-56 rounded-lg border border-gray-200 dark:border-gray-700 p-4">
                <div class="h-full flex items-end gap-2">
                  <div
                    v-for="point in analytics.predictive.revenue_forecast.series"
                    :key="`${point.label}-${point.type}`"
                    class="flex-1 flex flex-col items-center justify-end h-full"
                  >
                    <div
                      class="w-full rounded-t"
                      :class="point.type === 'forecast' ? 'bg-[#B58C3C]' : 'bg-[#5A3D22]'"
                      :style="{ height: getForecastBarHeight(point.amount) }"
                    />
                    <p class="mt-2 text-[10px] text-center text-gray-600 dark:text-gray-400 leading-tight">{{ point.label }}</p>
                  </div>
                </div>
              </div>

              <p class="text-xs text-gray-500 dark:text-gray-400">
                Dark bars are historical verified revenue, light bars are forecast values.
              </p>
            </div>
          </Card>

          <Card title="Recommended Actions">
            <div class="space-y-3">
              <div
                v-for="action in analytics.prescriptive.recommended_actions.actions"
                :key="action.title"
                class="rounded-lg border p-3"
                :class="getActionPriorityClasses(action.priority)"
              >
                <div class="flex items-center justify-between gap-3 mb-1">
                  <p class="font-medium text-gray-900 dark:text-white">{{ action.title }}</p>
                  <span class="text-xs uppercase tracking-wide text-gray-600 dark:text-gray-300">{{ action.priority }}</span>
                </div>
                <p class="text-sm text-gray-700 dark:text-gray-300 mb-1">{{ action.recommendation }}</p>
                <p class="text-xs text-gray-600 dark:text-gray-400">Expected impact: {{ action.expected_impact }}</p>
              </div>

              <p class="text-xs text-gray-500 dark:text-gray-400">
                Generated: {{ formatDate(analytics.prescriptive.recommended_actions.generated_at || new Date().toISOString()) }}
              </p>
            </div>
          </Card>
        </div>

        <div class="mt-6">
          <Card title="Cancellation Risk Flags (Upcoming Bookings)">
            <div v-if="analytics.predictive.cancellation_risks.length" class="space-y-3">
              <div
                v-for="risk in analytics.predictive.cancellation_risks"
                :key="risk.booking_id"
                class="rounded-lg border border-gray-200 dark:border-gray-700 p-4"
              >
                <div class="flex flex-wrap items-center justify-between gap-2 mb-2">
                  <div>
                    <p class="font-medium text-gray-900 dark:text-white">
                      #{{ risk.booking_id }} - {{ risk.customer_name }}
                    </p>
                    <p class="text-sm text-gray-600 dark:text-gray-400">
                      {{ risk.event_type }} • {{ risk.package_name }} • {{ risk.event_date }}
                    </p>
                  </div>
                  <div class="flex items-center gap-2">
                    <span class="text-sm font-semibold text-gray-900 dark:text-white">{{ risk.risk_score }}%</span>
                    <Badge class="capitalize" :class="getRiskBadgeClasses(risk.risk_level)">{{ risk.risk_level }}</Badge>
                  </div>
                </div>

                <div class="mb-2 w-full h-2 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden">
                  <div
                    class="h-full"
                    :class="risk.risk_level === 'high' ? 'bg-red-500' : (risk.risk_level === 'medium' ? 'bg-yellow-500' : 'bg-green-500')"
                    :style="{ width: `${Math.min(risk.risk_score, 100)}%` }"
                  />
                </div>

                <p class="text-xs text-gray-600 dark:text-gray-400 mb-2">{{ risk.days_until_event }} day(s) until event</p>
                <p class="text-xs text-gray-500 dark:text-gray-400">
                  Risk signals: {{ risk.reasons.join(' • ') }}
                </p>
              </div>
            </div>
            <p v-else class="text-sm text-gray-500 dark:text-gray-400">No upcoming bookings with risk data yet.</p>
          </Card>
        </div>
      </div>

      <!-- Operational Analytics (without Turnaround SLA) -->
      <div class="mb-8">
        <h2 class="text-2xl font-light text-gray-900 dark:text-white mb-4">Operational Analytics</h2>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card title="Capacity & Utilization">
            <div class="space-y-3">
              <div class="flex items-baseline justify-between">
                <span class="text-sm text-gray-500 dark:text-gray-400">30-day utilization</span>
                <span class="text-xl font-semibold text-gray-900 dark:text-white">
                  {{ analytics.operational.capacity.utilization_rate }}%
                </span>
              </div>
              <div class="w-full h-2 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden">
                <div
                  class="h-full bg-[#5A3D22] dark:bg-[#5A3D22]"
                  :style="{ width: `${Math.min(analytics.operational.capacity.utilization_rate, 100)}%` }"
                />
              </div>
              <p class="text-sm text-gray-600 dark:text-gray-400">
                {{ analytics.operational.capacity.booked_slots }} booked of
                {{ analytics.operational.capacity.available_slots }} available slots
              </p>
              <div class="pt-2 space-y-2">
                <div
                  v-for="week in analytics.operational.capacity.weekly_utilization"
                  :key="week.week"
                  class="flex items-center gap-3"
                >
                  <span class="w-16 text-xs text-gray-500 dark:text-gray-400">{{ week.week }}</span>
                  <div class="flex-1 h-2 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden">
                    <div class="h-full bg-[#3F2B19]" :style="{ width: `${Math.min(week.rate, 100)}%` }" />
                  </div>
                  <span class="text-xs text-gray-600 dark:text-gray-300">{{ week.rate }}%</span>
                </div>
              </div>
            </div>
          </Card>

          <Card title="Lead Time Distribution">
            <div class="space-y-3">
              <p class="text-sm text-gray-600 dark:text-gray-400">
                Average lead time: <span class="font-semibold text-gray-900 dark:text-white">{{ analytics.operational.lead_time.average_days }} days</span>
              </p>
              <div
                v-for="bucket in analytics.operational.lead_time.distribution"
                :key="bucket.bucket"
                class="space-y-1"
              >
                <div class="flex items-center justify-between text-sm">
                  <span class="text-gray-600 dark:text-gray-400">{{ bucket.bucket }}</span>
                  <span class="font-medium text-gray-900 dark:text-white">{{ bucket.count }}</span>
                </div>
                <div class="w-full h-2 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden">
                  <div
                    class="h-full bg-[#B58C3C]"
                    :style="{
                      width: barWidth(
                        bucket.count,
                        Math.max(...analytics.operational.lead_time.distribution.map((item) => item.count), 0)
                      )
                    }"
                  />
                </div>
              </div>
            </div>
          </Card>

          <Card title="Team Workload (This Month)">
            <div class="space-y-4">
              <div>
                <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400 mb-2">Photographers</p>
                <div class="space-y-2" v-if="analytics.operational.workload.photographers.length">
                  <div
                    v-for="person in analytics.operational.workload.photographers"
                    :key="`photo-${person.name}`"
                    class="flex items-center justify-between text-sm"
                  >
                    <span class="text-gray-700 dark:text-gray-300">{{ person.name }}</span>
                    <span class="font-medium text-gray-900 dark:text-white">{{ person.count }}</span>
                  </div>
                </div>
                <p v-else class="text-sm text-gray-500 dark:text-gray-400">No photographer assignments yet.</p>
              </div>

              <div>
                <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400 mb-2">Videographers</p>
                <div class="space-y-2" v-if="analytics.operational.workload.videographers.length">
                  <div
                    v-for="person in analytics.operational.workload.videographers"
                    :key="`video-${person.name}`"
                    class="flex items-center justify-between text-sm"
                  >
                    <span class="text-gray-700 dark:text-gray-300">{{ person.name }}</span>
                    <span class="font-medium text-gray-900 dark:text-white">{{ person.count }}</span>
                  </div>
                </div>
                <p v-else class="text-sm text-gray-500 dark:text-gray-400">No videographer assignments yet.</p>
              </div>

              <p class="text-sm text-[#B58C3C] dark:text-[#B58C3C]">
                Unassigned bookings: {{ analytics.operational.workload.unassigned_bookings }}
              </p>
            </div>
          </Card>

          <Card title="Peak Day Heatmap (Last 3 Months)">
            <div class="space-y-4">
              <div class="grid grid-cols-7 gap-2">
                <div
                  v-for="day in analytics.operational.peak_day_heatmap.days"
                  :key="day.day"
                  class="rounded-lg p-3 text-center border border-gray-200 dark:border-gray-700"
                  :style="{
                    backgroundColor: getHeatmapCellBackground(
                      day.count,
                      Math.max(...analytics.operational.peak_day_heatmap.days.map((item) => item.count), 0)
                    ),
                    color: getHeatmapCellTextColor(
                      day.count,
                      Math.max(...analytics.operational.peak_day_heatmap.days.map((item) => item.count), 0)
                    )
                  }"
                >
                  <p class="text-xs font-medium">{{ day.day }}</p>
                  <p class="text-sm font-semibold">{{ day.count }}</p>
                </div>
              </div>
              <p class="text-sm text-gray-600 dark:text-gray-400">
                Peak day: <span class="font-semibold text-gray-900 dark:text-white">{{ analytics.operational.peak_day_heatmap.peak_day }}</span>
                ({{ analytics.operational.peak_day_heatmap.peak_count }} bookings)
              </p>
            </div>
          </Card>
        </div>

        <div class="mt-6">
          <OperationalAnalyticsChart
            :operational="analytics.operational"
            title="Operational Charts (Capacity, Lead Time, Workload, Peak Day)"
          />
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
        <!-- Revenue Chart Placeholder -->
        <Card title="Revenue Trend">
          <div class="space-y-4">
            <div v-for="month in analytics.revenue_by_month" :key="month.month" class="flex items-center justify-between">
              <span class="text-sm text-gray-600 dark:text-gray-400">{{ month.month }}</span>
              <span class="text-sm font-medium text-gray-900 dark:text-white">{{ formatCurrency(month.revenue) }}</span>
            </div>
          </div>
          <div class="mt-4 text-sm text-gray-500 dark:text-gray-400">
            💡 Install Chart.js to see visual charts
          </div>
        </Card>

        <!-- Bookings by Status -->
        <Card title="Bookings by Status">
          <div class="space-y-4">
            <div v-for="item in analytics.bookings_by_status" :key="item.status" class="flex items-center justify-between">
              <div class="flex items-center">
                <Badge :style="getStatusBadgeStyle(item.status)" class="mr-2">{{ item.status }}</Badge>
              </div>
              <span class="text-lg font-semibold text-gray-900 dark:text-white">{{ item.count }}</span>
            </div>
          </div>
        </Card>
      </div>

      <!-- Popular Packages -->
      <Card title="Popular Packages" class="mb-6">
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
            <thead class="bg-gray-50 dark:bg-gray-800">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                  Package
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                  Bookings
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                  Revenue
                </th>
              </tr>
            </thead>
            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
              <tr v-for="pkg in analytics.popular_packages" :key="pkg.name">
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                  {{ pkg.name }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600 dark:text-gray-400">
                  {{ pkg.count }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white font-medium">
                  {{ formatCurrency(pkg.revenue) }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </Card>

      <!-- Advanced Analytics Charts -->
      <div class="space-y-8 mb-8">
        <h2 class="text-2xl font-light text-gray-900 dark:text-white">Advanced Analytics</h2>
        <SalesTrendChart title="Sales Trend (Weekly / Monthly / Annual)" />
        <AggregationChart title="Sales Aggregation" />
      </div>

      <!-- Recent Bookings -->
      <Card title="Recent Bookings">
        <div class="space-y-3">
          <div
            v-for="booking in analytics.recent_bookings"
            :key="booking.id"
            class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-800 rounded-lg"
          >
            <div class="flex-1">
              <p class="font-medium text-gray-900 dark:text-white">{{ booking.event_type }}</p>
              <p class="text-sm text-gray-600 dark:text-gray-400">{{ booking.user.name }} • {{ formatDate(booking.created_at) }}</p>
            </div>
            <div class="flex items-center gap-3">
              <span class="text-sm font-medium text-gray-900 dark:text-white">
                {{ formatCurrency(booking.total_cost) }}
              </span>
              <Badge :style="getStatusBadgeStyle(booking.status)">{{ booking.status }}</Badge>
            </div>
          </div>
        </div>
      </Card>
    </div>
  </AppLayout>
</template>
