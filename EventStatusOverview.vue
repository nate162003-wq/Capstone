<script setup lang="ts">
import { computed, onMounted } from 'vue';
import { usePlotlyChart } from '@/composables/usePlotlyChart';
import { getContrastingTextColor } from '@/lib/utils';

interface EventAnalytics {
  analytics: {
    total_events: number;
    events_by_status: {
      pending: number;
      confirmed: number;
      completed: number;
      cancelled: number;
    };
    events_by_type: Record<string, number>;
    average_guest_count: number;
    total_revenue: number;
  };
}

interface Props {
  analytics: EventAnalytics;
}

const props = defineProps<Props>();
const { loadPlotly, renderChart } = usePlotlyChart();
const chartContainerId = 'event-status-chart';

onMounted(async () => {
  await loadPlotly();
  renderEventStatusChart();
});

const renderEventStatusChart = async () => {
  const statuses = ['pending', 'confirmed', 'completed', 'cancelled'];
  const colors = ['#C2613A', '#B77D77', '#5A3735', '#9F544A'];
  const values = statuses.map(s => props.analytics.analytics.events_by_status[s as keyof typeof props.analytics.analytics.events_by_status]);
  const labels = statuses.map(s => s.charAt(0).toUpperCase() + s.slice(1));

  const trace = {
    labels,
    values,
    type: 'pie',
    marker: { colors },
    textposition: 'inside',
    textinfo: 'label+percent',
    hovertemplate: '<b>%{label}</b><br>Count: %{value}<br>Percentage: %{percent}<extra></extra>',
  };

  const layout = {
    title: 'Events by Status Distribution',
    height: 400,
    margin: { l: 0, r: 0, t: 40, b: 0 },
  };

  await renderChart(chartContainerId, [trace], layout);
};

const statusStats = computed(() => {
  const events = props.analytics.analytics.events_by_status;

  const createStatus = (label: string, value: number, backgroundColor: string, icon: string) => {
    const textColor = getContrastingTextColor(backgroundColor);
    return {
      label,
      value,
      icon,
      style: {
        backgroundColor,
        color: textColor,
      },
      mutedStyle: {
        color: textColor,
        opacity: '0.82',
      },
      iconStyle: {
        color: textColor,
        opacity: '0.3',
      },
    };
  };

  return [
    createStatus('Pending', events.pending, '#C2613A', '⏳'),
    createStatus('Confirmed', events.confirmed, '#B77D77', '✓'),
    createStatus('Completed', events.completed, '#5A3735', '✓✓'),
    createStatus('Cancelled', events.cancelled, '#9F544A', '✕'),
  ];
});
</script>

<template>
  <div class="bg-white/95 rounded-2xl border-2 border-[#EAC3BF]/50 shadow-md p-6">
    <!-- Header -->
    <div class="mb-6">
      <h2 class="text-2xl font-semibold text-[#5A3735] mb-2">Event Status Overview</h2>
      <p class="text-gray-600">Complete breakdown of all events</p>
    </div>

    <!-- Key Metrics -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
      <div class="rounded-xl p-4 bg-gradient-to-r from-[#FDF7F5] to-[#EAC3BF]/45 border border-[#EAC3BF]/60 shadow-sm">
        <p class="text-sm text-[#5A3735] font-medium">Total Events</p>
        <p class="text-3xl font-bold text-[#5A3735] mt-2">{{ analytics.analytics.total_events }}</p>
      </div>
      <div class="rounded-xl p-4 bg-gradient-to-r from-[#FDF7F5] to-[#EAC3BF]/45 border border-[#EAC3BF]/60 shadow-sm">
        <p class="text-sm text-[#5A3735] font-medium">Avg Guest Count</p>
        <p class="text-3xl font-bold text-[#5A3735] mt-2">{{ analytics.analytics.average_guest_count }}</p>
      </div>
      <div class="rounded-xl p-4 bg-gradient-to-r from-[#9F544A] to-[#C2613A] border border-[#9F544A]/60 shadow-sm">
        <p class="text-sm text-[#FDF7F5] font-medium">Total Revenue</p>
        <p class="text-3xl font-bold text-[#FDF7F5] mt-2">₱{{ analytics.analytics.total_revenue.toLocaleString() }}</p>
      </div>
    </div>

    <!-- Status Distribution -->
    <div class="mb-8">
      <div :id="chartContainerId" class="w-full" style="height: 400px;"></div>
    </div>

    <!-- Status Stats -->
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
      <div
        v-for="stat in statusStats"
        :key="stat.label"
        class="rounded-lg p-4"
        :style="stat.style"
      >
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm font-medium" :style="stat.mutedStyle">{{ stat.label }}</p>
            <p class="text-2xl font-bold mt-1">{{ stat.value }}</p>
          </div>
          <div class="text-3xl" :style="stat.iconStyle">{{ stat.icon }}</div>
        </div>
      </div>
    </div>
  </div>
</template>
