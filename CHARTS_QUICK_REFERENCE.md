# Chart Analytics Quick Reference Guide

## 🚀 Quick Start

### 1. Import Components (Vue Page)
```vue
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'
```

### 2. Use Components
```vue
<template>
  <div>
    <SalesTrendChart period="monthly" />
    <DemographicsChart />
    <AggregationChart />
  </div>
</template>
```

### 3. That's it! 🎉
Charts automatically fetch data from `/business-owner/charts/*` endpoints.

---

## 📊 Component Reference

### SalesTrendChart

**Props:**
```typescript
period?: 'weekly' | 'monthly' | 'annual'  // Default: 'monthly'
title?: string                              // Default: 'Sales Trend'
height?: string                             // Default: '400px'
```

**Features:**
- Period selector buttons
- Dual-axis chart (sales + bookings)
- 5 statistics cards (min, max, total, mean, mode)

**Example:**
```vue
<SalesTrendChart period="monthly" title="Monthly Revenue" height="500px" />
```

---

### DemographicsChart

**Props:**
```typescript
title?: string                              // Default: 'Age Group Distribution'
height?: string                             // Default: '400px'
```

**Features:**
- Pie chart by age group
- Revenue by event type chart
- Customer drill-down with expandable details
- Interactive age group selection

**Example:**
```vue
<DemographicsChart title="Customer Analysis" />
```

---

### AggregationChart

**Props:**
```typescript
title?: string                              // Default: 'Sales Aggregation'
height?: string                             // Default: '400px'
```

**Features:**
- Sales subtotals by event type
- 6 statistics cards (total, min, max, mean, mode, count)
- Color-coded metric cards

**Example:**
```vue
<AggregationChart title="Aggregation Report" />
```

---

## 🔌 API Endpoints

### Get All Charts
```
GET /business-owner/charts/dashboard
```

**Returns:**
```json
{
  "sales_trend": { /* chart data */ },
  "demographics": { /* chart data */ },
  "aggregation": { /* chart data */ },
  "statistics_cards": [ /* cards */ ]
}
```

### Get Sales Trend
```
GET /business-owner/charts/sales-trend/{period}
```

**Parameters:**
- `period`: `weekly` | `monthly` | `annual`

**Returns:** Sales trend chart data with statistics

### Get Customer Demographics
```
GET /business-owner/charts/customer-demographics
```

**Returns:** Demographics chart data with drill-down info

### Get Aggregation Data
```
GET /business-owner/charts/aggregation
```

**Returns:** Aggregation charts and statistics cards

---

## 📈 Data Calculations

### Statistics Available

| Metric | What It Shows | Formula |
|--------|--------------|---------|
| Minimum | Lowest value | MIN(values) |
| Maximum | Highest value | MAX(values) |
| Total | Sum of all values | SUM(values) |
| Mean | Average value | SUM / COUNT |
| Mode | Most frequent value | Most common value |
| Subtotal | Sum by category | SUM(GROUP BY) |

### Age Groups
```
Low Income:  21-25, 26-40
High Income: 30-35, 36-40
```

### Event Types
- Wedding
- Birthday
- Anniversary
- Corporate Event
- Other

---

## 🎨 Customization

### Change Chart Height
```vue
<SalesTrendChart height="600px" />
```

### Change Chart Title
```vue
<DemographicsChart title="My Custom Title" />
```

### Use Different Period
```vue
<SalesTrendChart period="weekly" />
<SalesTrendChart period="annual" />
```

---

## 🐛 Troubleshooting

### Charts Not Showing
1. Check browser console (F12) for errors
2. Verify Plotly CDN is accessible
3. Check network tab for API response
4. Ensure database has confirmed bookings

### No Data in Charts
1. Verify database has bookings with `status = 'confirmed'`
2. Check `confirmed_at` field is populated
3. Inspect network response for correct data format

### Age Groups Empty
1. Ensure users have bookings
2. Verify `getUserAge()` is calculating correctly
3. Check customer-booking relationships

### Statistics Show Zero
1. Verify calculations in ChartAnalyticsService
2. Check database query results
3. Ensure booking amounts are not null

---

## 🔧 Service Methods

### ChartAnalyticsService

```php
// Get trend data
getSalesTrendData($period = 'monthly'): array

// Get demographics with drill-down
getCustomerDemographics(): array

// Get aggregation metrics
getAggregationData(): array
```

### PlotlyChartService

```php
// Format for sales trend chart
formatSalesTrendChart($trendData): array

// Format for demographics pie chart
formatDemographicsPieChart($demographics): array

// Format for event type chart
formatEventTypeChart($demographics): array

// Format for aggregation bar chart
formatAggregationChart($aggregationData): array

// Format statistics cards
formatStatisticsCards($aggregationData): array
```

---

## 💡 Tips & Tricks

### 1. Refresh Data Manually
```typescript
const { loadChartData } = useChartData()
loadChartData() // Re-fetch from API
```

### 2. Access Raw Statistics
```typescript
// In component
const statistics = chartData.value?.statistics
console.log(statistics.min)
console.log(statistics.max)
console.log(statistics.mean)
```

### 3. Add Loading Indicator
```vue
<div v-if="isLoading" class="text-center">
  <p>Loading chart data...</p>
</div>
```

### 4. Handle Errors
```vue
<div v-if="error" class="alert alert-error">
  {{ error }}
</div>
```

---

## 📱 Responsive Behavior

All components are mobile-responsive:
- **Mobile (< 768px)**: Single column layout
- **Tablet (768px - 1024px)**: 2 column layout
- **Desktop (> 1024px)**: Full grid layout with 3-4 columns

---

## 🚀 Performance Tips

1. **Use Dashboard Endpoint** for all charts at once
   ```typescript
   fetch('/business-owner/charts/dashboard')
   ```

2. **Cache Results** for faster subsequent loads
   ```php
   Cache::remember('chart_data', 3600, fn() => ...);
   ```

3. **Lazy Load** components below fold
   ```vue
   <Suspense>
     <SalesTrendChart />
   </Suspense>
   ```

4. **Database Indexes** for faster queries
   ```sql
   CREATE INDEX idx_bookings_confirmed_at ON bookings(confirmed_at);
   ```

---

## 🔑 Key Files Location

```
app/Services/
  ├── ChartAnalyticsService.php ........... Data aggregation
  └── PlotlyChartService.php ............ Chart formatting

app/Http/Controllers/BusinessOwner/
  └── ChartsController.php .............. API endpoints

resources/js/components/Charts/
  ├── SalesTrendChart.vue .............. Trend visualization
  ├── DemographicsChart.vue ............ Demographics drill-down
  └── AggregationChart.vue ............ Aggregation metrics

resources/js/composables/
  └── usePlotlyChart.ts ............... Plotly helper

resources/js/pages/BusinessOwner/
  └── ChartsDashboard.vue ............. Sample dashboard
```

---

## 📚 Documentation Files

```
CHARTS_IMPLEMENTATION_GUIDE.md ........... Full technical guide
CHARTS_SETUP_CHECKLIST.md ............... Setup verification
CHARTS_IMPLEMENTATION_SUMMARY.md ........ Overview & architecture
CHARTS_QUICK_REFERENCE.md .............. This file
```

---

## 🎯 Common Tasks

### Task: Show Weekly Sales
```vue
<SalesTrendChart period="weekly" title="Weekly Sales" />
```

### Task: Get Customer Count by Age
- Use DemographicsChart component
- Click on age group card
- See customer list with details

### Task: Get Total Sales for Event Type
- Use AggregationChart component
- View subtotals card
- See breakdown by event type

### Task: Find Min/Max Booking Amount
- Use SalesTrendChart or AggregationChart
- Check statistics cards
- View "Minimum" and "Maximum" cards

### Task: Calculate Average Guest Count
- Use AggregationChart
- View guest_statistics section
- Check "Average Guests" card

---

## 🔗 Related Links

- **Laravel Docs**: https://laravel.com/docs
- **Vue 3 Docs**: https://vuejs.org
- **Plotly Docs**: https://plotly.com/javascript
- **Tailwind Docs**: https://tailwindcss.com

---

## 📞 Support

For issues or questions:
1. Check troubleshooting section above
2. Review implementation guide
3. Check browser console for errors
4. Inspect network tab for API response

---

**Last Updated**: February 1, 2026
**Status**: Ready for Production ✅
