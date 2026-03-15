<script setup lang="ts">
import { onMounted } from 'vue';
import { usePlotlyChart } from '@/composables/usePlotlyChart';

interface CompletedCanceledAnalytics {
  completed_analytics: {
    total_completed: number;
    completion_rate: number;
    completed_by_month: Record<string, number>;
  };
  canceled_analytics: {
    total_canceled: number;
    cancellation_rate: number;
    canceled_by_month: Record<string, number>;
  };
}

interface Props {
  analytics: CompletedCanceledAnalytics;
}

const props = defineProps<Props>();
const { loadPlotly, renderChart } = usePlotlyChart();
const chartContainerId = 'completed-canceled-chart';

onMounted(async () => {
  await loadPlotly();
  renderCompletedCanceledChart();
});

const renderCompletedCanceledChart = async () => {
  const months = Object.keys(props.analytics.completed_analytics.completed_by_month).sort();
  const completedCounts = months.map(m => props.analytics.completed_analytics.completed_by_month[m]);
  const canceledCounts = months.map(m => props.analytics.canceled_analytics.canceled_by_month[m]);

  const trace1 = {
    x: months,
    y: completedCounts,
    name: 'Completed Events',
    type: 'bar',
    marker: { color: '#5A3735' },
  };

  const trace2 = {
    x: months,
    y: canceledCounts,
    name: 'Canceled Events',
    type: 'bar',
    marker: { color: '#9F544A' },
  };

  const layout = {
    title: 'Event Status Trends (Last 6 Months)',
    xaxis: { title: 'Month' },
    yaxis: { title: 'Count' },
    barmode: 'group',
    hovermode: 'x unified',
  };

  await renderChart(chartContainerId, [trace1, trace2], layout);
};
</script>

<template>
  <div class="bg-white/95 rounded-2xl border-2 border-[#EAC3BF]/50 shadow-md p-6">
    <!-- Header -->
    <div class="mb-6">
      <h2 class="text-2xl font-semibold text-[#5A3735] mb-2">Event Status Analytics</h2>
      <p class="text-gray-600">Completed and canceled events overview</p>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-8">
      <!-- Completed Events Card -->
      <div class="bg-gradient-to-r from-[#FDF7F5] to-[#EAC3BF]/45 border border-[#EAC3BF]/55 rounded-xl p-4">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-[#5A3735] font-medium">Completed Events</p>
            <p class="text-3xl font-bold text-[#5A3735] mt-2">{{ analytics.completed_analytics.total_completed }}</p>
            <p class="text-sm text-[#9F544A] mt-1">{{ analytics.completed_analytics.completion_rate }}% completion rate</p>
          </div>
          <div class="text-4xl opacity-30 text-[#5A3735]">✓</div>
        </div>
      </div>

      <!-- Canceled Events Card -->
      <div class="bg-gradient-to-r from-[#EAC3BF]/55 to-[#B77D77]/35 border border-[#B77D77]/55 rounded-xl p-4">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-[#5A3735] font-medium">Canceled Events</p>
            <p class="text-3xl font-bold text-[#9F544A] mt-2">{{ analytics.canceled_analytics.total_canceled }}</p>
            <p class="text-sm text-[#9F544A] mt-1">{{ analytics.canceled_analytics.cancellation_rate }}% cancellation rate</p>
          </div>
          <div class="text-4xl opacity-30 text-[#9F544A]">✕</div>
        </div>
      </div>
    </div>

    <!-- Chart -->
    <div :id="chartContainerId" class="w-full" style="height: 400px;"></div>
  </div>
</template>
