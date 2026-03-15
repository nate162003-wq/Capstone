<script setup lang="ts">
import AppContent from '@/components/AppContent.vue'
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'
import { ref } from 'vue'

const activeTab = ref('overview')
</script>

<template>
  <AppContent>
    <div class="space-y-8">
      <!-- Header -->
      <div class="mb-8">
        <h1 class="text-4xl font-bold text-gray-900 mb-2">Analytics Dashboard</h1>
        <p class="text-lg text-gray-600">Comprehensive business insights with trend analysis, customer demographics, and aggregation metrics</p>
      </div>

      <!-- Tab Navigation -->
      <div class="border-b border-gray-200">
        <div class="flex space-x-8">
          <button
            v-for="tab in ['overview', 'trends', 'demographics', 'aggregation']"
            :key="tab"
            @click="activeTab = tab"
            :class="{
              'border-b-2 border-[#5A3D22] text-[#5A3D22]': activeTab === tab,
              'text-gray-600 hover:text-gray-900': activeTab !== tab,
            }"
            class="px-1 py-4 font-medium text-sm transition-colors capitalize"
          >
            {{ tab.replace('-', ' ') }}
          </button>
        </div>
      </div>

      <!-- Overview Tab -->
      <div v-show="activeTab === 'overview'" class="space-y-8 animate-fadeIn">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <!-- Sales Summary Card -->
          <div class="bg-gradient-to-br from-[#5A3D22] to-[#5A3D22] rounded-lg shadow-lg p-6 text-white">
            <h2 class="text-lg font-semibold mb-2">Total Sales</h2>
            <p class="text-4xl font-bold mb-2">₱1,234,567</p>
            <p class="text-[#5A3D22]">+12.5% from last month</p>
          </div>

          <!-- Customers Summary Card -->
          <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-lg shadow-lg p-6 text-white">
            <h2 class="text-lg font-semibold mb-2">Active Customers</h2>
            <p class="text-4xl font-bold mb-2">348</p>
            <p class="text-green-100">+8.2% from last month</p>
          </div>

          <!-- Bookings Summary Card -->
          <div class="bg-gradient-to-br from-[#5A3D22] to-[#5A3D22] rounded-lg shadow-lg p-6 text-white">
            <h2 class="text-lg font-semibold mb-2">Total Bookings</h2>
            <p class="text-4xl font-bold mb-2">1,247</p>
            <p class="text-[#5A3D22]">+15.3% from last month</p>
          </div>

          <!-- Average Order Value -->
          <div class="bg-gradient-to-br from-[#3F2B19] to-[#3F2B19] rounded-lg shadow-lg p-6 text-white">
            <h2 class="text-lg font-semibold mb-2">Average Order Value</h2>
            <p class="text-4xl font-bold mb-2">₱3,547</p>
            <p class="text-[#3F2B19]">Per booking</p>
          </div>
        </div>

        <!-- Quick Metrics -->
        <div class="bg-white rounded-lg shadow p-6">
          <h2 class="text-xl font-semibold text-gray-900 mb-6">Quick Metrics</h2>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div class="text-center p-4 bg-gray-50 rounded-lg">
              <p class="text-2xl font-bold text-gray-900">92%</p>
              <p class="text-sm text-gray-600 mt-1">Booking Success Rate</p>
            </div>
            <div class="text-center p-4 bg-gray-50 rounded-lg">
              <p class="text-2xl font-bold text-gray-900">4.8/5</p>
              <p class="text-sm text-gray-600 mt-1">Average Rating</p>
            </div>
            <div class="text-center p-4 bg-gray-50 rounded-lg">
              <p class="text-2xl font-bold text-gray-900">156</p>
              <p class="text-sm text-gray-600 mt-1">Pending Bookings</p>
            </div>
            <div class="text-center p-4 bg-gray-50 rounded-lg">
              <p class="text-2xl font-bold text-gray-900">2.3d</p>
              <p class="text-sm text-gray-600 mt-1">Avg Response Time</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Trends Tab -->
      <div v-show="activeTab === 'trends'" class="space-y-8 animate-fadeIn">
        <div class="bg-white rounded-lg shadow p-6 mb-6">
          <p class="text-gray-600 mb-4">View sales performance over different time periods</p>
        </div>
        <SalesTrendChart title="Sales Performance Trends" />
      </div>

      <!-- Demographics Tab -->
      <div v-show="activeTab === 'demographics'" class="space-y-8 animate-fadeIn">
        <div class="bg-white rounded-lg shadow p-6 mb-6">
          <p class="text-gray-600 mb-4">Analyze customer demographics and drill down into age groups</p>
        </div>
        <DemographicsChart title="Customer Demographics Analysis" />
      </div>

      <!-- Aggregation Tab -->
      <div v-show="activeTab === 'aggregation'" class="space-y-8 animate-fadeIn">
        <div class="bg-white rounded-lg shadow p-6 mb-6">
          <p class="text-gray-600 mb-4">View comprehensive aggregation metrics including minimum, maximum, totals, subtotals, mean, and mode</p>
        </div>
        <AggregationChart title="Sales Aggregation Analysis" />
      </div>

      <!-- Data Export Section -->
      <div class="bg-[#5A3D22] border border-[#5A3D22] rounded-lg p-6 mt-8">
        <h2 class="text-lg font-semibold text-gray-900 mb-4">Export Options</h2>
        <div class="flex flex-wrap gap-3">
          <button class="px-4 py-2 bg-[#5A3D22] text-white rounded-md hover:bg-[#5A3D22] transition-colors">
            📊 Export as PDF
          </button>
          <button class="px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600 transition-colors">
            📈 Export as Excel
          </button>
          <button class="px-4 py-2 bg-[#3F2B19] text-white rounded-md hover:bg-[#3F2B19] transition-colors">
            🖼️ Export as Images
          </button>
          <button class="px-4 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-600 transition-colors">
            📧 Email Report
          </button>
        </div>
      </div>

      <!-- Footer Info -->
      <div class="bg-gray-50 border border-gray-200 rounded-lg p-6 text-sm text-gray-600">
        <p>
          <strong>Last Updated:</strong> {{ new Date().toLocaleString() }}
        </p>
        <p class="mt-2">
          This dashboard provides real-time insights into your business performance. Data is updated every hour. For more information, see the 
          <a href="#" class="text-[#5A3D22] hover:underline">analytics documentation</a>.
        </p>
      </div>
    </div>
  </AppContent>
</template>

<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fadeIn {
  animation: fadeIn 0.3s ease-in-out;
}
</style>
