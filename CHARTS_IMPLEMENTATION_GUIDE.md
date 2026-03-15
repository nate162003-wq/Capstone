# Chart Analytics Implementation Guide

## Overview
This comprehensive chart analytics system implements mentor-recommended visualizations for sales, customer demographics, and aggregation data using Laravel backend, Vue 3 frontend, and Plotly.js for interactive charts.

## Architecture

### Technology Stack
```
Database → Laravel Query → Data Structure (Array) → Plotly Charts → Interactive Visualizations
```

## Components Created

### 1. Backend Services

#### `ChartAnalyticsService` (`app/Services/ChartAnalyticsService.php`)
Handles all data aggregation and analytics calculations:

- **`getSalesTrendData(period)`** - Get sales trends
  - Parameters: `'weekly'`, `'monthly'`, `'annual'`
  - Returns: Labels, sales data, counts, and statistics (min, max, total, mean, mode)
  
- **`getCustomerDemographics()`** - Get customer demographics with drill-down
  - Groups by age ranges: 21-25, 26-40, 30-35, 36-40
  - Returns: Age group breakdown, event type breakdown, detailed customer info, statistics
  
- **`getAggregationData()`** - Get comprehensive aggregation metrics
  - Sales: min, max, total, mean, mode, subtotals by event type
  - Guest counts: min, max, total, mean, mode

#### `PlotlyChartService` (`app/Services/PlotlyChartService.php`)
Formats data for Plotly visualization:

- **`formatSalesTrendChart(trendData)`** - Dual-axis chart (sales + bookings count)
- **`formatDemographicsPieChart(demographics)`** - Age group distribution
- **`formatEventTypeChart(demographics)`** - Revenue & bookings by event type
- **`formatAggregationChart(aggregationData)`** - Subtotals bar chart
- **`formatStatisticsCards(aggregationData)`** - KPI cards with min/max/mean/mode

### 2. Backend Controller

#### `ChartsController` (`app/Http/Controllers/BusinessOwner/ChartsController.php`)
API endpoints:

```php
GET /business-owner/charts/dashboard           // All charts at once
GET /business-owner/charts/sales-trend/{period}  // Sales trend (weekly/monthly/annual)
GET /business-owner/charts/customer-demographics  // Customer demographics
GET /business-owner/charts/aggregation          // Aggregation data
```

### 3. Frontend Components

#### `SalesTrendChart.vue`
- **Features:**
  - Period selector (Weekly, Monthly, Annual)
  - Dual-axis chart (sales amount + booking count)
  - Statistics cards (min, max, total, mean, mode)
  - Real-time data fetching
  
- **Props:**
  - `period`: 'weekly' | 'monthly' | 'annual'
  - `title`: Custom chart title
  - `height`: Chart height (default: 400px)

- **Usage:**
```vue
<SalesTrendChart period="monthly" title="Monthly Sales Trend" />
```

#### `DemographicsChart.vue`
- **Features:**
  - Age group distribution pie chart
  - Revenue by event type chart
  - Customer drill-down with expandable details
  - Interactive age group selection
  
- **Props:**
  - `title`: Custom title
  - `height`: Chart height
  
- **Usage:**
```vue
<DemographicsChart title="Customer Demographics" />
```

#### `AggregationChart.vue`
- **Features:**
  - Sales subtotals by event type (bar chart)
  - Statistics cards (6 metrics)
  - Color-coded cards by metric type
  
- **Props:**
  - `title`: Custom title
  - `height`: Chart height
  
- **Usage:**
```vue
<AggregationChart title="Sales Aggregation" />
```

### 4. Composable

#### `usePlotlyChart.ts` (`resources/js/composables/usePlotlyChart.ts`)
Utility composable for Plotly chart management:

```typescript
const { renderChart, updateChart, loadPlotly, isPlotlyLoaded } = usePlotlyChart()

// Render a new chart
await renderChart('chart-id', data, layout, config)

// Update existing chart
await updateChart('chart-id', newData, newLayout)
```

## Data Flow

### Sales Trend Example
```
Database (bookings table)
    ↓
ChartAnalyticsService.getSalesTrendData('monthly')
    ↓
[labels: ['2024-01', '2024-02', ...], sales: [50000, 75000, ...], counts: [10, 15, ...]]
    ↓
PlotlyChartService.formatSalesTrendChart()
    ↓
{data: [...], layout: {...}, statistics: {...}}
    ↓
SalesTrendChart.vue (renderChart)
    ↓
Plotly.newPlot() → Interactive Chart
```

## Statistics Calculation Methods

### Minimum & Maximum
- `MIN()` and `MAX()` of dataset values
- Used for range analysis

### Total & Subtotals
- `SUM()` of all values (Total)
- `SUM()` grouped by category (Subtotals)

### Mean (Average)
```
Mean = SUM(values) / COUNT(values)
```

### Mode (Most Frequent Value)
```
Mode = Most frequently occurring value in dataset
```

## Customer Demographics Legend

### Age Groups
- **Low Income**: 21-25, 26-40
- **High Income**: 30-35, 36-40

### Attributes Tracked
- Age range
- Total customers
- Total revenue generated
- Average guest count
- Event types availed
- Booking history

## Usage Examples

### In a Page Component
```vue
<template>
  <div class="space-y-8">
    <SalesTrendChart period="monthly" />
    <DemographicsChart />
    <AggregationChart />
  </div>
</template>

<script setup lang="ts">
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'
</script>
```

### Accessing Raw Data
```typescript
// Fetch all chart data
fetch('/business-owner/charts/dashboard')
  .then(res => res.json())
  .then(data => {
    console.log(data.sales_trend)
    console.log(data.demographics)
    console.log(data.aggregation)
  })
```

## Database Queries Optimized

- **Sales Trend**: Uses `DATE_TRUNC()` and `GROUP BY` for period aggregation
- **Demographics**: Leverages `whereHas()` for customer-booking relationships
- **Aggregation**: Efficient SUM, COUNT, and AVG calculations with proper indexing

## API Response Format

### Sales Trend Response
```json
{
  "data": [...],
  "layout": {...},
  "config": {...},
  "statistics": {
    "min": 10000,
    "max": 100000,
    "mean": 50000,
    "mode": 45000,
    "total": 500000
  }
}
```

### Demographics Response
```json
{
  "pie_chart": {...},
  "event_type_chart": {...},
  "detailed_breakdown": [...]
}
```

### Aggregation Response
```json
{
  "charts": {
    "subtotals": {...}
  },
  "statistics_cards": {
    "sales_statistics": [...],
    "guest_statistics": [...]
  }
}
```

## Features Implemented

✅ **Trend Charts** - Weekly, monthly, annual sales
✅ **Drill Up/Roll Up** - Customer demographics with expandable details
✅ **Age Groups** - Low (21-25, 26-40) and High (30-35, 36-40)
✅ **Aggregation** - Min, max, totals, subtotals, mean, mode
✅ **Event Type Analysis** - Revenue and bookings by event type
✅ **Statistics Cards** - KPI displays for quick insights
✅ **Interactive Charts** - Plotly.js with hover/click interactions
✅ **Responsive Design** - Mobile-friendly layouts
✅ **Real-time Data** - Dynamic API calls with loading states

## Customization

### Add New Age Groups
Edit `ChartAnalyticsService::getCustomerDemographics()`:
```php
$ageGroups = [
    'new_group' => ['label' => '40 - 50', 'min' => 40, 'max' => 50],
    // ...
];
```

### Customize Chart Colors
Edit `PlotlyChartService` color assignments:
```php
'marker' => ['color' => '#YOUR_COLOR']
```

### Change Chart Dimensions
Pass `height` prop to components:
```vue
<SalesTrendChart height="500px" />
```

## Performance Considerations

- Charts are lazy-loaded via Plotly CDN
- Data fetching is optimized with database-level aggregation
- Components use Vue's `watch` for reactive updates
- Statistics calculations are done server-side for efficiency

## Browser Compatibility
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

Plotly.js handles cross-browser compatibility automatically.

## Future Enhancements

- Export charts as PNG/SVG
- PDF report generation
- Real-time data with WebSockets
- Custom date range selection
- Advanced filtering options
- Comparison between periods
- Predictive analytics
