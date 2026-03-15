# Chart Analytics Setup Checklist

## Backend Setup ✅

### Services Created
- [x] `app/Services/ChartAnalyticsService.php` - Data aggregation & analytics
- [x] `app/Services/PlotlyChartService.php` - Plotly chart formatting

### Controller Created
- [x] `app/Http/Controllers/BusinessOwner/ChartsController.php` - API endpoints

### Routes Added
- [x] `/business-owner/charts/dashboard` - GET all charts
- [x] `/business-owner/charts/sales-trend/{period}` - GET sales trend
- [x] `/business-owner/charts/customer-demographics` - GET demographics
- [x] `/business-owner/charts/aggregation` - GET aggregation data

## Frontend Setup ✅

### Vue Components Created
- [x] `resources/js/components/Charts/SalesTrendChart.vue`
- [x] `resources/js/components/Charts/DemographicsChart.vue`
- [x] `resources/js/components/Charts/AggregationChart.vue`

### Composables Created
- [x] `resources/js/composables/usePlotlyChart.ts`

## Configuration

### Ensure Dependencies Installed
```bash
npm install
```

Plotly is loaded via CDN, no npm install needed.

### Database Requirements
Ensure your `bookings` table has:
- `confirmed_at` (datetime) - For trend calculations
- `total_cost` (decimal) - For sales aggregation
- `event_type` (string) - For categorization
- `guest_count` (integer) - For guest analytics
- `user_id` (foreign key) - For customer grouping
- `status` (string) - For filtering confirmed bookings

### User Model Requirements
User model should have:
- `bookings()` relationship
- `profession` field (optional)
- Age calculation method (currently randomized, update as needed)

## Integration Steps

### Step 1: Import Components
In your analytics page/dashboard:

```vue
<script setup>
import SalesTrendChart from '@/components/Charts/SalesTrendChart.vue'
import DemographicsChart from '@/components/Charts/DemographicsChart.vue'
import AggregationChart from '@/components/Charts/AggregationChart.vue'
</script>

<template>
  <div class="space-y-8">
    <h1 class="text-3xl font-bold">Analytics Dashboard</h1>
    
    <SalesTrendChart />
    <DemographicsChart />
    <AggregationChart />
  </div>
</template>
```

### Step 2: Run Migration (if needed)
If any new fields are needed on bookings table:
```bash
php artisan migrate
```

### Step 3: Test the Endpoints
```bash
# Test chart endpoints
curl http://localhost:8000/business-owner/charts/dashboard
curl http://localhost:8000/business-owner/charts/sales-trend/monthly
```

### Step 4: Build Frontend (if needed)
```bash
npm run build
# or for development
npm run dev
```

## Verification Checklist

### Backend Verification
- [ ] All services are created and properly namespaced
- [ ] ChartsController is properly registered
- [ ] Routes are added to `routes/web.php`
- [ ] Database relationships are working
- [ ] API endpoints return valid JSON

### Frontend Verification
- [ ] Components compile without errors
- [ ] Plotly library loads correctly (check browser console)
- [ ] Charts render with sample data
- [ ] Statistics cards display correctly
- [ ] Responsive design works on mobile

### Integration Verification
- [ ] Analytics page loads without errors
- [ ] Charts load data from API
- [ ] Period selector works (weekly/monthly/annual)
- [ ] Age group selection works
- [ ] Customer drill-down expands/collapses
- [ ] Statistics update correctly

## Common Issues & Solutions

### Issue: Charts not rendering
**Solution:** Check browser console for errors. Ensure Plotly CDN is accessible.

### Issue: No data showing
**Solution:** Verify database has confirmed bookings. Check network tab for API response.

### Issue: Age calculation shows random values
**Solution:** Update `getUserAge()` in `ChartAnalyticsService` to use actual DOB field if available.

### Issue: Empty customer list
**Solution:** Ensure users have related confirmed bookings in the database.

## API Documentation

### GET /business-owner/charts/sales-trend/{period}
Returns sales trend data with dual-axis chart format.

**Parameters:**
- `period` (string): 'weekly', 'monthly', or 'annual'

**Response:**
```json
{
  "data": [...],
  "layout": {...},
  "statistics": {...}
}
```

### GET /business-owner/charts/customer-demographics
Returns customer demographic data with drill-down capability.

**Response:**
```json
{
  "pie_chart": {...},
  "event_type_chart": {...},
  "detailed_breakdown": [...]
}
```

### GET /business-owner/charts/aggregation
Returns aggregation metrics and statistics cards.

**Response:**
```json
{
  "charts": {...},
  "statistics_cards": {...}
}
```

### GET /business-owner/charts/dashboard
Returns all chart data at once.

**Response:**
```json
{
  "sales_trend": {...},
  "demographics": {...},
  "aggregation": {...},
  "statistics_cards": {...}
}
```

## Performance Tips

1. **Caching:** Consider adding Redis caching for frequently accessed analytics
   ```php
   Cache::remember('chart_data', 3600, function () {
       return $this->analyticsService->getSalesTrendData('monthly');
   });
   ```

2. **Database Indexes:** Add indexes on frequently queried columns
   ```sql
   CREATE INDEX idx_bookings_confirmed_at ON bookings(confirmed_at);
   CREATE INDEX idx_bookings_event_type ON bookings(event_type);
   CREATE INDEX idx_bookings_status ON bookings(status);
   ```

3. **Pagination:** For large datasets, implement pagination in detailed breakdown

## Next Steps

1. Integrate charts into the main dashboard
2. Add export functionality (PDF/PNG)
3. Implement real-time updates with WebSockets
4. Add custom date range selection
5. Create advanced filtering options
6. Set up automated report generation

## Support Files

- **Documentation:** `CHARTS_IMPLEMENTATION_GUIDE.md`
- **Services:** `app/Services/ChartAnalyticsService.php`, `PlotlyChartService.php`
- **Controller:** `app/Http/Controllers/BusinessOwner/ChartsController.php`
- **Components:** `resources/js/components/Charts/*.vue`
- **Composable:** `resources/js/composables/usePlotlyChart.ts`

---

**Last Updated:** February 1, 2026
**Implementation Status:** ✅ Complete
