# Integration Examples

## Example 1: Add Charts to Existing Analytics Page

### Before (old analytics page)
```vue
<template>
  <AppContent>
    <h1>Analytics</h1>
    <p>Coming soon...</p>
  </AppContent>
</template>
```

### After (with chart components)
```vue
<script setup lang="ts">
import AppContent from '@/components/AppContent.vue'
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'
</script>

<template>
  <AppContent>
    <div class="space-y-8">
      <h1 class="text-3xl font-bold">Analytics Dashboard</h1>
      
      <!-- Sales Trends -->
      <SalesTrendChart period="monthly" />
      
      <!-- Customer Demographics -->
      <DemographicsChart />
      
      <!-- Aggregation Metrics -->
      <AggregationChart />
    </div>
  </AppContent>
</template>
```

---

## Example 2: Add Charts with Tabs

```vue
<script setup lang="ts">
import { ref } from 'vue'
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'

const activeTab = ref('trends')
</script>

<template>
  <div>
    <!-- Tab Navigation -->
    <div class="border-b">
      <button
        @click="activeTab = 'trends'"
        :class="{ 'border-b-2 border-blue-500': activeTab === 'trends' }"
        class="px-4 py-2 font-medium"
      >
        Sales Trends
      </button>
      <button
        @click="activeTab = 'demographics'"
        :class="{ 'border-b-2 border-blue-500': activeTab === 'demographics' }"
        class="px-4 py-2 font-medium"
      >
        Customer Demographics
      </button>
      <button
        @click="activeTab = 'aggregation'"
        :class="{ 'border-b-2 border-blue-500': activeTab === 'aggregation' }"
        class="px-4 py-2 font-medium"
      >
        Aggregation
      </button>
    </div>

    <!-- Tab Content -->
    <div class="p-6">
      <SalesTrendChart v-show="activeTab === 'trends'" />
      <DemographicsChart v-show="activeTab === 'demographics'" />
      <AggregationChart v-show="activeTab === 'aggregation'" />
    </div>
  </div>
</template>
```

---

## Example 3: Add Charts with Summary Cards

```vue
<script setup lang="ts">
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'
</script>

<template>
  <div class="space-y-8">
    <!-- Summary Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="bg-blue-50 border border-blue-200 rounded-lg p-6">
        <p class="text-gray-600 text-sm">Total Bookings</p>
        <p class="text-3xl font-bold text-gray-900 mt-2">1,247</p>
        <p class="text-green-600 text-sm mt-2">↑ 12.5% this month</p>
      </div>
      <div class="bg-green-50 border border-green-200 rounded-lg p-6">
        <p class="text-gray-600 text-sm">Total Revenue</p>
        <p class="text-3xl font-bold text-gray-900 mt-2">₱1.2M</p>
        <p class="text-green-600 text-sm mt-2">↑ 8.3% this month</p>
      </div>
      <div class="bg-orange-50 border border-orange-200 rounded-lg p-6">
        <p class="text-gray-600 text-sm">Active Customers</p>
        <p class="text-3xl font-bold text-gray-900 mt-2">348</p>
        <p class="text-green-600 text-sm mt-2">↑ 5.2% this month</p>
      </div>
      <div class="bg-purple-50 border border-purple-200 rounded-lg p-6">
        <p class="text-gray-600 text-sm">Avg Booking Value</p>
        <p class="text-3xl font-bold text-gray-900 mt-2">₱3,547</p>
        <p class="text-red-600 text-sm mt-2">↓ 2.1% this month</p>
      </div>
    </div>

    <!-- Charts -->
    <SalesTrendChart period="monthly" />
    <DemographicsChart />
    <AggregationChart />
  </div>
</template>
```

---

## Example 4: Responsive Layout with Sidebar

```vue
<script setup lang="ts">
import { ref } from 'vue'
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'

const period = ref('monthly')
const showFilters = ref(false)
</script>

<template>
  <div class="flex gap-6">
    <!-- Sidebar with Filters -->
    <div class="w-64 bg-gray-50 p-6 rounded-lg h-fit">
      <h2 class="font-bold text-gray-900 mb-4">Filters</h2>
      
      <!-- Period Selector -->
      <div class="mb-6">
        <label class="block text-sm font-medium text-gray-700 mb-2">
          Period
        </label>
        <select v-model="period" class="w-full border rounded px-3 py-2">
          <option value="weekly">Weekly</option>
          <option value="monthly">Monthly</option>
          <option value="annual">Annual</option>
        </select>
      </div>

      <!-- Date Range -->
      <div class="mb-6">
        <label class="block text-sm font-medium text-gray-700 mb-2">
          Date Range
        </label>
        <input type="date" class="w-full border rounded px-3 py-2 mb-2" />
        <input type="date" class="w-full border rounded px-3 py-2" />
      </div>

      <!-- Event Type Filter -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-2">
          Event Type
        </label>
        <div class="space-y-2">
          <label class="flex items-center">
            <input type="checkbox" class="rounded" checked />
            <span class="ml-2 text-sm">Wedding</span>
          </label>
          <label class="flex items-center">
            <input type="checkbox" class="rounded" checked />
            <span class="ml-2 text-sm">Birthday</span>
          </label>
          <label class="flex items-center">
            <input type="checkbox" class="rounded" checked />
            <span class="ml-2 text-sm">Anniversary</span>
          </label>
          <label class="flex items-center">
            <input type="checkbox" class="rounded" checked />
            <span class="ml-2 text-sm">Corporate</span>
          </label>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="flex-1 space-y-8">
      <SalesTrendChart :period="period" />
      <DemographicsChart />
      <AggregationChart />
    </div>
  </div>
</template>
```

---

## Example 5: With Export Functionality

```vue
<script setup lang="ts">
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'

const exportAsImage = () => {
  // Use Plotly's built-in export
  const plotlyPlot = document.querySelector('[id^="sales-trend-chart"]')
  // Plotly will show download button on hover
}

const exportAsJSON = () => {
  // Fetch all data and export
  fetch('/business-owner/charts/dashboard')
    .then(res => res.json())
    .then(data => {
      const json = JSON.stringify(data, null, 2)
      const blob = new Blob([json], { type: 'application/json' })
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = 'charts-data.json'
      a.click()
    })
}

const printReport = () => {
  window.print()
}
</script>

<template>
  <div class="space-y-6">
    <!-- Export Buttons -->
    <div class="flex gap-2 print:hidden">
      <button
        @click="exportAsImage"
        class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
      >
        📊 Export Charts
      </button>
      <button
        @click="exportAsJSON"
        class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600"
      >
        📥 Export Data
      </button>
      <button
        @click="printReport"
        class="px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600"
      >
        🖨️ Print Report
      </button>
    </div>

    <!-- Charts -->
    <SalesTrendChart />
    <DemographicsChart />
    <AggregationChart />
  </div>
</template>

<style scoped>
@media print {
  .print\:hidden {
    display: none;
  }
}
</style>
```

---

## Example 6: Dashboard with Multiple Periods

```vue
<script setup lang="ts">
import { ref } from 'vue'
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'

const periods = ['weekly', 'monthly', 'annual']
const selectedPeriod = ref('monthly')
</script>

<template>
  <div class="space-y-8">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <SalesTrendChart
        v-for="period in periods"
        :key="period"
        :period="period"
        :title="`${period.charAt(0).toUpperCase() + period.slice(1)} Sales`"
        height="300px"
      />
    </div>

    <!-- Detailed View -->
    <div class="bg-white rounded-lg shadow p-6">
      <h2 class="text-xl font-semibold mb-4">Detailed Analysis</h2>
      <SalesTrendChart :period="selectedPeriod" height="500px" />
    </div>
  </div>
</template>
```

---

## Example 7: Real-time Dashboard with Auto-Refresh

```vue
<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'

const refreshInterval = ref(300000) // 5 minutes
let refreshTimer: NodeJS.Timeout | null = null

const refreshData = () => {
  // Reload the page or refresh components
  // Components handle auto-refresh via their own fetch
}

const setupAutoRefresh = () => {
  refreshTimer = setInterval(refreshData, refreshInterval.value)
}

const clearAutoRefresh = () => {
  if (refreshTimer) clearInterval(refreshTimer)
}

onMounted(() => {
  setupAutoRefresh()
})

onUnmounted(() => {
  clearAutoRefresh()
})
</script>

<template>
  <div class="space-y-8">
    <!-- Refresh Controls -->
    <div class="flex gap-2 items-center">
      <span class="text-sm text-gray-600">Auto-refresh every 5 minutes</span>
      <label class="flex items-center">
        <input
          type="checkbox"
          @change="e => refreshInterval = e.target.checked ? 300000 : 0"
          checked
          class="rounded"
        />
        <span class="ml-2 text-sm">Enabled</span>
      </label>
    </div>

    <!-- Charts -->
    <SalesTrendChart />
    <DemographicsChart />
    <AggregationChart />
  </div>
</template>
```

---

## Example 8: Minimal Integration

```vue
<template>
  <div>
    <SalesTrendChart />
    <DemographicsChart />
    <AggregationChart />
  </div>
</template>

<script setup>
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'
</script>
```

That's it! Just 3 lines + imports = complete analytics dashboard.

---

## Implementation Tips

1. **Keep It Simple**: Start with Example 8
2. **Add Gradually**: Add features as needed
3. **Customize Colors**: Match your brand
4. **Responsive First**: Test on mobile
5. **Performance**: Use caching for large datasets

---

**Ready to integrate?** Choose the example that fits your needs and start with that!
