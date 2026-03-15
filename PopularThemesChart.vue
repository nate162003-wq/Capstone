<script setup lang="ts">
import { onMounted, watch } from 'vue';
import { usePlotlyChart } from '@/composables/usePlotlyChart';

interface PopularTheme {
  theme_id: number;
  theme_name: string;
  usage_count: number;
  percentage: number;
}

interface PopularThemesAnalytics {
  popular_themes: {
    most_popular: PopularTheme[];
    total_with_theme: number;
  };
}

interface Props {
  analytics: PopularThemesAnalytics;
}

const props = defineProps<Props>();
const { loadPlotly, renderChart } = usePlotlyChart();
const chartContainerId = 'popular-themes-chart';

const getMostPopular = () => {
  return props.analytics.popular_themes.most_popular[0] || null;
};

const getTopThemes = () => {
  return props.analytics.popular_themes.most_popular.slice(0, 5);
};

const renderPopularThemesChart = async () => {
  const topThemes = getTopThemes();

  if (!topThemes.length) return;

  const chartThemes = [...topThemes].reverse();

  const trace = {
    type: 'bar',
    orientation: 'h',
    x: chartThemes.map(theme => theme.usage_count),
    y: chartThemes.map(theme => theme.theme_name),
    text: chartThemes.map(theme => `${theme.percentage}%`),
    textposition: 'outside',
    marker: {
      color: '#9F544A',
      line: {
        color: '#5A3735',
        width: 1,
      },
    },
    hovertemplate: '<b>%{y}</b><br>Events: %{x}<br>Share: %{text}<extra></extra>',
    cliponaxis: false,
  };

  const layout = {
    title: 'Top 5 Most Availed Themes',
    height: 340,
    margin: { l: 160, r: 40, t: 44, b: 40 },
    xaxis: {
      title: 'Number of Events',
      rangemode: 'tozero',
    },
    yaxis: {
      automargin: true,
    },
    showlegend: false,
  };

  await renderChart(chartContainerId, [trace], layout);
};

onMounted(async () => {
  await loadPlotly();
  await renderPopularThemesChart();
});

watch(
  () => props.analytics.popular_themes.most_popular,
  async () => {
    await renderPopularThemesChart();
  },
  { deep: true }
);
</script>

<template>
  <div class="bg-white/95 rounded-2xl border-2 border-[#EAC3BF]/50 shadow-md p-6">
    <!-- Header -->
    <div class="mb-6">
      <h2 class="text-2xl font-semibold text-[#5A3735] mb-2">Most Availed Themes</h2>
      <p class="text-gray-600">Popular theme selections by customers</p>
    </div>

    <!-- Most Popular Theme Highlight -->
    <div v-if="getMostPopular()" class="mb-8">
      <div class="bg-gradient-to-r from-[#5A3735] via-[#9F544A] to-[#C2613A] rounded-xl p-6 border border-[#EAC3BF]/45 shadow-sm">
        <div class="flex items-center gap-4">
          <div class="flex-shrink-0">
            <div class="flex items-center justify-center h-12 w-12 rounded-lg bg-[#FDF7F5]/20">
              <span class="text-[#FDF7F5] text-lg font-bold">⭐</span>
            </div>
          </div>
          <div class="flex-1">
            <p class="text-sm text-[#FDF7F5]/85 font-medium">Most Popular</p>
            <h3 class="text-2xl font-bold text-[#FDF7F5]">{{ getMostPopular().theme_name }}</h3>
            <p class="text-sm text-[#FDF7F5]/90 mt-1">
              Used in {{ getMostPopular().usage_count }} events ({{ getMostPopular().percentage }}%)
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Chart -->
    <div v-if="getTopThemes().length > 0" class="mb-8">
      <div :id="chartContainerId" class="w-full" style="height: 340px;"></div>
    </div>

    <!-- Theme Rankings -->
    <div>
      <h3 class="text-lg font-semibold text-[#5A3735] mb-4">Top Themes</h3>
      <div class="space-y-3">
        <div
          v-for="(theme, index) in getTopThemes()"
          :key="theme.theme_id"
          class="flex items-center justify-between p-4 bg-gradient-to-r from-[#FDF7F5] to-[#EAC3BF]/40 rounded-xl border border-[#EAC3BF]/40 transition hover:from-[#FDF7F5] hover:to-[#EAC3BF]/65"
        >
          <div class="flex items-center gap-4">
            <div class="flex-shrink-0">
              <span class="text-xl font-bold text-[#9F544A]/70 w-8 text-center">#{{ index + 1 }}</span>
            </div>
            <div>
              <p class="font-medium text-gray-900">{{ theme.theme_name }}</p>
              <p class="text-sm text-gray-600">{{ theme.usage_count }} events</p>
            </div>
          </div>
          <div class="text-right">
            <p class="text-lg font-bold text-[#5A3735]">{{ theme.percentage }}%</p>
          </div>
        </div>
      </div>

      <!-- Summary -->
      <div v-if="analytics.popular_themes.total_with_theme > 0" class="mt-6 pt-4 border-t border-[#EAC3BF]/50">
        <p class="text-sm text-gray-600">
          <span class="font-semibold">Total events with themes:</span> {{ analytics.popular_themes.total_with_theme }}
        </p>
      </div>
    </div>
  </div>
</template>
