# AI Text-to-Image Theme Generation - Implementation Guide

## Overview
This guide explains how the text-to-image theme generation feature works in your Brighter Days Photography system. Users can now generate custom themes with AI-generated images directly during the booking process.

## Architecture

```
Customer Booking Flow
    ↓
Step 1: Theme Selection
    ├─ Option A: Select existing theme
    └─ Option B: Click "Generate AI Theme" → Opens Modal
         ↓
    User enters theme details + prompt
         ↓
    API Request: POST /customer/themes/generate/new
         ↓
    ThemeGenerationController
         ↓
    Creates Theme record (status: 'generating')
         ↓
    Dispatches GenerateThemeImagesJob (async)
         ↓
    Queue processes job (uses hybrid mode):
         ├─ Real API: Calls FAL.ai with prompt
         └─ Mock Mode: Generates placeholder images
         ↓
    ImageGenerationService → FAL.ai API
         ↓
    Images generated & stored in database
         ↓
    Theme status: 'ready'
         ↓
    Frontend auto-selects theme for booking
         ↓
Step 2-4: Continue booking normally
```

## File Structure

### Backend Files Created/Modified:

```
app/Services/
├── ImageGenerationService.php      (AI image generation abstraction)
└── ThemeGenerationService.php      (Theme generation orchestration)

app/Jobs/
└── GenerateThemeImagesJob.php      (Queue job for async generation)

app/Http/Controllers/Customer/
├── ThemeGenerationController.php   (API endpoints for generation)
└── ThemeController.php             (Updated - removed old simulation)

database/migrations/
└── 2025_01_27_000000_add_generation_fields_to_themes_table.php

app/Models/
└── Theme.php                       (Updated with new fields)

routes/
└── web.php                         (Updated with new API routes)
```

### Frontend Files Created/Modified:

```
resources/js/
├── components/Modals/
│   └── ThemeGenerationModal.vue    (Modal for theme generation)
└── pages/Customer/Bookings/
    └── Create.vue                  (Updated with modal integration)
```

## Configuration

### 1. Environment Setup

Add to your `.env` file:

```env
# FAL.ai Configuration (for real image generation)
FAL_KEY=your_fal_api_key_here

# Queue Configuration (already set)
QUEUE_CONNECTION=database
```

### 2. Queue Setup

The system uses Laravel's queue system with database driver:

```bash
# Queue listener should be running in background
php artisan queue:listen
```

Or for development:
```bash
# Included in dev script
npm run dev  # includes queue listener automatically
```

## How It Works

### 1. **Hybrid Mode** (Works with or without API key)

```php
ImageGenerationService
├─ If FAL_KEY is configured:
│  └─ Real API: Calls FAL.ai (Flux Pro model)
└─ If FAL_KEY is missing:
   └─ Mock Mode: Generates placeholder images for testing
```

### 2. **Theme Generation Flow**

**Step 1: User initiates generation**
```javascript
POST /customer/themes/generate/new
{
  "name": "Summer Romance",
  "description": "Elegant wedding theme",
  "event_type": "wedding",
  "prompt": "Elegant outdoor wedding with sunset colors...",
  "color_preferences": {
    "primary": "#FF6B6B",
    "secondary": "#4ECDC4",
    "accent": "#FFE66D"
  }
}
```

**Step 2: Controller creates theme**
- Creates `Theme` record with `status = 'generating'`
- Stores generation metadata

**Step 3: Job is dispatched**
- `GenerateThemeImagesJob` queued for async processing
- User sees loading indicator

**Step 4: Queue processes job**
```php
GenerateThemeImagesJob::handle()
├─ Enhance prompt with event type + colors
├─ Call ImageGenerationService
├─ Generate 3 image variations
└─ Update theme with images
```

**Step 5: Images generated**
- FAL.ai generates high-quality images (1024x1024)
- Images stored in `generated_images` JSON array
- Theme status updated to `'ready'`

**Step 6: Frontend updates**
- Modal shows success message
- Newly generated theme auto-selected
- User continues booking

### 3. **Database Fields Added**

```sql
ALTER TABLE themes ADD COLUMN generation_progress VARCHAR(255) DEFAULT 'pending';
ALTER TABLE themes ADD COLUMN error_message TEXT NULL;
ALTER TABLE themes ADD COLUMN generation_job_id VARCHAR(255) UNIQUE NULL;
ALTER TABLE themes ADD COLUMN generation_started_at TIMESTAMP NULL;
ALTER TABLE themes ADD COLUMN generation_completed_at TIMESTAMP NULL;
ALTER TABLE themes ADD COLUMN generation_attempt INT DEFAULT 0;
```

## API Endpoints

### Generate New Theme
```
POST /customer/themes/generate/new
Headers: Content-Type: application/json, X-CSRF-Token

Request Body:
{
  "name": "Theme Name",
  "description": "Optional description",
  "event_type": "wedding",
  "prompt": "Your detailed prompt (min 10 chars)",
  "color_preferences": {
    "primary": "#hex",
    "secondary": "#hex",
    "accent": "#hex"
  }
}

Response (201 Created):
{
  "success": true,
  "message": "Theme generation started...",
  "theme": {
    "id": 1,
    "name": "Summer Romance",
    "status": "generating",
    "progress": "pending"
  }
}
```

### Check Generation Status
```
GET /customer/themes/{theme}/status

Response (200 OK):
{
  "success": true,
  "data": {
    "id": 1,
    "status": "ready",
    "progress": "completed",
    "error": null,
    "images": [
      "https://...",
      "https://...",
      "https://..."
    ],
    "started_at": "2025-01-27T10:30:00Z",
    "completed_at": "2025-01-27T10:35:00Z",
    "attempt": 1
  }
}
```

### Retry Failed Generation
```
POST /customer/themes/{theme}/retry

Response (200 OK):
{
  "success": true,
  "message": "Theme generation restarted.",
  "theme": {
    "id": 1,
    "status": "generating",
    "progress": "pending"
  }
}
```

### List Generating Themes
```
GET /customer/themes/generating/list

Response (200 OK):
{
  "success": true,
  "data": [
    { /* theme with generating status */ }
  ]
}
```

### List Available Themes
```
GET /customer/themes/available/list

Response (200 OK):
{
  "success": true,
  "data": [
    { /* ready themes */ }
  ]
}
```

## Service Classes

### ImageGenerationService

```php
// Generate images from prompt
$images = $service->generateImages(
    prompt: "Elegant wedding...",
    eventType: "wedding",
    colorPalette: ["primary" => "#FF6B6B"],
    count: 3  // Number of variations
);

// Check if API is available
$available = $service->isAvailable(); // Returns boolean

// Check API health
$health = $service->checkHealth();
// Returns: ['status' => 'healthy'|'unhealthy'|'mock', 'message' => '...']
```

### ThemeGenerationService

```php
// Initiate generation
$service->initiateGeneration($theme);

// Complete generation
$service->completeGeneration($theme, $generatedImages);

// Handle failure
$service->handleGenerationFailure($theme, "Error message");

// Get current status
$status = $service->getStatus($theme);

// Retry failed generation
$service->retryGeneration($theme);
```

## Retry Logic

- **Max Attempts**: 3
- **Retry Behavior**: Automatic retry on first 2 failures
- **Final Failure**: Marked as `status = 'failed'` after 3 attempts
- **Manual Retry**: Users can manually retry from booking or theme page

## Testing

### Test with Mock Data (No API Key)

```bash
# Leave FAL_KEY empty in .env
# System automatically uses mock image generation
# Perfect for testing without credits!
```

### Test with Real API

```bash
# 1. Sign up at https://fal.ai
# 2. Get your API key
# 3. Add to .env: FAL_KEY=your_key
# 4. Restart queue listener
# 5. System uses real image generation
```

### Manual Testing in Browser

```javascript
// Open browser console in booking page
// Test API endpoint directly
fetch('/customer/themes/generate/new', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
  },
  body: JSON.stringify({
    name: "Test Theme",
    event_type: "wedding",
    prompt: "Test theme with sunset colors and elegant details",
    color_preferences: {
      primary: "#FF6B6B",
      secondary: "#4ECDC4",
      accent: "#FFE66D"
    }
  })
})
.then(r => r.json())
.then(data => console.log(data));
```

## Queue Commands

### Start Queue Listener (Development)

```bash
php artisan queue:listen
```

### Process Queue Once

```bash
php artisan queue:work --once
```

### Monitor Queue Jobs

```bash
# View pending jobs
php artisan queue:monitor

# View failed jobs
php artisan queue:failed

# Retry failed jobs
php artisan queue:retry all
```

## Troubleshooting

### Issue: "Theme generation stuck in 'generating' state"

**Solution**: Check if queue listener is running
```bash
# Start queue listener
php artisan queue:listen

# OR check failed jobs
php artisan queue:failed
php artisan queue:retry all
```

### Issue: "Mock images showing instead of real images"

**Cause**: FAL_KEY not configured

**Solution**:
```bash
# 1. Verify .env has FAL_KEY set
# FAL_KEY=your_actual_key_here

# 2. Clear config cache
php artisan config:clear

# 3. Restart queue listener
php artisan queue:listen
```

### Issue: "API rate limit errors"

**Cause**: Too many rapid requests to FAL.ai

**Solution**:
- FAL.ai has generous free tier
- Add delays between requests if needed
- Check FAL.ai dashboard for usage limits

### Issue: "Database error - column doesn't exist"

**Solution**: Run migrations
```bash
php artisan migrate
```

## Performance Considerations

1. **Async Processing**: Images generated in background queue
   - User doesn't wait for generation
   - Multiple generations can run in parallel

2. **Image Storage**: URLs stored in database
   - Uses CDN URLs from FAL.ai
   - No local storage needed

3. **Database Queries**: Minimal impact
   - Only adds 6 new columns to themes table
   - Generation job IDs indexed for tracking

## Security

1. **Authorization**: All endpoints check `auth()->id()` matches theme owner
2. **Validation**: Prompt length validated (min 10, max 1000 chars)
3. **CSRF Protection**: X-CSRF-Token required for POST requests
4. **API Key**: Stored securely in .env (never in code)

## Future Enhancements

- [ ] Real-time WebSocket updates for generation progress
- [ ] Multiple AI provider support (OpenAI, Midjourney, etc.)
- [ ] Image regeneration/variation selection
- [ ] Saved generation history
- [ ] Community theme gallery
- [ ] Cost tracking per user/month

## Support

For issues or questions:
- Check queue logs: `php artisan pail`
- Check failed jobs: `php artisan queue:failed`
- Contact: mr.brightshots@gmail.com or 0977 217 9168
