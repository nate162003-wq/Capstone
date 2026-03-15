# AI Theme Generation - Developer Reference

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                      CUSTOMER BROWSER                            │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  Booking/Create.vue                                          ││
│  │  - Step 1: Theme Selection                                  ││
│  │  - Button: "Generate AI Theme"                              ││
│  └──────────────────┬──────────────────────────────────────────┘│
│                     │                                            │
│                     │ Click → Opens Modal                       │
│                     ▼                                            │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  ThemeGenerationModal.vue                                    ││
│  │  - Form for theme details                                   ││
│  │  - Color picker                                             ││
│  │  - Submit → POST /customer/themes/generate/new             ││
│  └──────────────────┬──────────────────────────────────────────┘│
└─────────────────────┼──────────────────────────────────────────┘
                      │
                      │ HTTP Request
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                   LARAVEL BACKEND                                │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  ThemeGenerationController::generate()                      ││
│  │  - Validate request                                         ││
│  │  - Create Theme record (status: 'generating')               ││
│  │  - Dispatch GenerateThemeImagesJob                          ││
│  └──────────────────┬──────────────────────────────────────────┘│
│                     │                                            │
│                     │ Dispatch Job                              │
│                     ▼                                            │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  Queue System (Database Driver)                             ││
│  │  - Store job in 'jobs' table                                ││
│  │  - Wait for queue listener to process                       ││
│  └──────────────────┬──────────────────────────────────────────┘│
│                     │                                            │
│                     │ Queue Listener runs                        │
│                     ▼                                            │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  GenerateThemeImagesJob::handle()                           ││
│  │  - Retrieve Theme from database                             ││
│  │  - Call ImageGenerationService                              ││
│  │  - Enhance prompt (+ event type, colors)                    ││
│  └──────────────────┬──────────────────────────────────────────┘│
│                     │                                            │
│                     ▼                                            │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  ImageGenerationService::generateImages()                   ││
│  │  ┌─────────────────────┬─────────────────┐                 ││
│  │  │ Check API Available │                 │                 ││
│  │  └──────────┬──────────┴──────┬──────────┘                 ││
│  │             │                  │                            ││
│  │        YES  ▼                  ▼  NO                        ││
│  │  ┌──────────────────┐  ┌──────────────────┐               ││
│  │  │ Real API Path    │  │ Mock Path        │               ││
│  │  │ FAL.ai           │  │ Placeholder      │               ││
│  │  │ HTTP Call        │  │ Images (picsum)  │               ││
│  │  └────────┬─────────┘  └────────┬─────────┘               ││
│  │           │                     │                          ││
│  │           └──────────┬──────────┘                          ││
│  │                      ▼                                      ││
│  │           Return Image URLs Array                           ││
│  └──────────────────┬──────────────────────────────────────────┘│
│                     │                                            │
│                     │ Images received                            │
│                     ▼                                            │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  ThemeGenerationService::completeGeneration()               ││
│  │  - Update Theme.generated_images                            ││
│  │  - Update Theme.status = 'ready'                            ││
│  │  - Set generation_completed_at                              ││
│  │  - Store ai_metadata                                        ││
│  └──────────────────┬──────────────────────────────────────────┘│
│                     │                                            │
│                     │ Job Complete                              │
│                     ▼                                            │
│           Theme saved to database                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                      │
                      │ Frontend polls for status
                      │ GET /customer/themes/{id}/status
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                   CUSTOMER BROWSER                               │
│           ┌──────────────────────────────┐                     │
│           │ Modal shows:                  │                     │
│           │ - Success message             │                     │
│           │ - Generated images            │                     │
│           │ - Auto-select theme           │                     │
│           └──────────────────────────────┘                     │
└─────────────────────────────────────────────────────────────────┘
```

## File Dependencies

```
ThemeGenerationModal.vue
  └─ POST /customer/themes/generate/new
     └─ ThemeGenerationController::generate()
        └─ Theme::create()
           └─ GenerateThemeImagesJob::dispatch()
              └─ GenerateThemeImagesJob::handle()
                 ├─ ImageGenerationService::generateImages()
                 │  ├─ FAL.ai API (if key exists)
                 │  └─ Mock images (if no key)
                 └─ ThemeGenerationService::completeGeneration()
                    └─ Theme::update()

Bookings/Create.vue
  ├─ ThemeGenerationModal.vue
  ├─ GET /customer/themes/available/list
  └─ POST /customer/bookings
     └─ BookingController::store()
        └─ Booking::create(theme_id)
```

## Class Structure

### Service Classes

#### ImageGenerationService
```php
class ImageGenerationService {
    // Configuration
    private string $apiKey;              // FAL API key
    private string $baseUrl;             // FAL API endpoint
    private bool $useRealApi;            // Check if real API available
    
    // Public Methods
    public function generateImages(
        string $prompt,
        string $eventType,
        array $colorPalette = [],
        int $count = 3
    ): array
    
    public function isAvailable(): bool
    public function checkHealth(): array
    
    // Private Methods
    private function generateRealImages(...): array
    private function generateMockImages(...): array
    private function enhancePrompt(...): string
}
```

#### ThemeGenerationService
```php
class ThemeGenerationService {
    // Dependency
    protected ImageGenerationService $imageGenerationService;
    
    // Public Methods
    public function initiateGeneration(Theme $theme): void
    public function completeGeneration(Theme $theme, array $generatedImages): void
    public function handleGenerationFailure(Theme $theme, string $errorMessage): void
    public function getStatus(Theme $theme): array
    public function retryGeneration(Theme $theme): void
}
```

### Job Class

#### GenerateThemeImagesJob
```php
class GenerateThemeImagesJob implements ShouldQueue {
    // Configuration
    public int $tries = 3;                // Retry 3 times max
    public int $maxExceptions = 1;        // Stop after 1 unhandled exception
    public int $timeout = 300;            // 5 minute timeout
    
    // Methods
    public function handle(...): void     // Main execution
    public function failed(\Throwable $exception): void  // On final failure
}
```

### Controller Class

#### ThemeGenerationController
```php
class ThemeGenerationController extends Controller {
    // Endpoints
    public function generate(Request $request): JsonResponse
    public function status(Theme $theme): JsonResponse
    public function retry(Theme $theme): JsonResponse
    public function generatingThemes(): JsonResponse
    public function availableThemes(): JsonResponse
}
```

## Data Flow Examples

### Successful Generation Flow

```
1. User fills form in modal
2. Submit → POST /customer/themes/generate/new
3. Controller validates input
4. Theme created: {status: 'generating', progress: 'pending'}
5. Job dispatched
6. Queue processes job
7. Images generated (real or mock)
8. Theme updated: {status: 'ready', progress: 'completed', images: [...]}
9. Frontend detects ready state
10. Modal shows success
11. Theme auto-selected in booking
```

### Error Handling Flow

```
1. Job execution fails (API timeout, etc)
2. Attempt 1: Caught exception → Retry
3. Attempt 2: Caught exception → Retry
4. Attempt 3: Caught exception → Final failure
5. Job::failed() called
6. Theme updated: {status: 'failed', progress: 'failed', error: 'message'}
7. Frontend shows error
8. User can manually retry via button
```

## Key Design Decisions

### 1. Hybrid Mode
- **Why?** Allows testing without API credits
- **How?** Service checks if `FAL_KEY` is configured
- **Fallback?** Returns mock placeholder images

### 2. Async Processing
- **Why?** Images can take 2-5 minutes to generate
- **How?** Uses Laravel Queue with database driver
- **Benefit?** Non-blocking, scalable

### 3. Auto-retry Logic
- **Why?** Network issues can cause temporary failures
- **How?** Job retries 3 times before marking as failed
- **Manual?** User can click "Retry" button anytime

### 4. Prompt Enhancement
- **Why?** Improves AI output quality
- **How?** Adds event type, colors, quality directives
- **Example?** "User prompt + event type + color context + quality"

### 5. Status Polling
- **Why?** Real-time updates without WebSocket complexity
- **How?** Frontend polls `/status` endpoint every 2 seconds
- **Stops?** When status changes from 'generating' to 'ready'/'failed'

## Testing Strategies

### Unit Tests

```php
// Test prompt enhancement
$service = new ImageGenerationService();
$prompt = $service->enhancePrompt('elegant wedding', 'wedding', []);
// Assert contains 'wedding' and quality directives

// Test API availability
$available = $service->isAvailable();
// Assert true/false based on FAL_KEY
```

### Integration Tests

```php
// Test full generation flow
$theme = Theme::factory()->create();
$service = new ThemeGenerationService(new ImageGenerationService());
$service->initiateGeneration($theme);

// Assert job dispatched
// Assert theme status = 'generating'

// Process queue
$this->artisan('queue:work --once');

// Assert theme status = 'ready'
// Assert images populated
```

### Browser Tests

```javascript
// Test modal in browser
// 1. Navigate to booking create page
// 2. Click "Generate AI Theme" button
// 3. Fill form
// 4. Submit
// 5. Monitor network requests
// 6. Verify job status endpoint responses
// 7. Confirm theme auto-selection
```

## Performance Tuning

### Queue Performance
```php
// Process multiple jobs in parallel
php artisan queue:work --max-jobs=10 --max-time=3600

// Process specific queue
php artisan queue:work --queue=images
```

### Database Optimization
```php
// Index generation_job_id for faster lookups
Schema::table('themes', function (Blueprint $table) {
    $table->index('generation_job_id');
});

// Index status for filtering
$table->index('status');
```

### API Rate Limiting
```php
// If implementing rate limiting later
Route::middleware('throttle:60,1')->group(function () {
    Route::post('/themes/generate/new', ...);
});
```

## Common Modifications

### Change Number of Image Variations
```php
// In GenerateThemeImagesJob::handle()
// Change count parameter
$generatedImages = $imageGenerationService->generateImages(
    prompt: $this->theme->prompt_used,
    eventType: $this->theme->event_type,
    colorPalette: $this->theme->color_palette ?? [],
    count: 5  // Changed from 3 to 5
);
```

### Change Image Size
```php
// In ImageGenerationService::generateRealImages()
'image_size' => [1536, 1536],  // Changed from 1024x1024
```

### Add Event Types
```javascript
// In ThemeGenerationModal.vue
const props = withDefaults(defineProps<Props>(), {
  eventTypes: () => [
    'wedding',
    'corporate',
    'birthday',
    'engagement',
    'sweet16',  // NEW
    'babyshower', // NEW
  ],
});
```

### Customize Prompt Enhancement
```php
// In ImageGenerationService::enhancePrompt()
private function enhancePrompt(...): string {
    // Add your custom logic here
    // Example: Add style presets
    if ($eventType === 'wedding') {
        $enhancedPrompt .= " Romantic, elegant, sophisticated style.";
    }
    return $enhancedPrompt;
}
```

## Environment Variables Reference

```env
# AI Configuration
FAL_KEY=                          # FAL.ai API key (optional, uses mock if empty)
FAL_API_URL=https://api.falai.com # FAL base URL (default)

# Queue Configuration  
QUEUE_CONNECTION=database         # Use database queue driver
DB_QUEUE_CONNECTION=mysql         # Which DB connection for queue
DB_QUEUE_TABLE=jobs              # Jobs table name
DB_QUEUE=default                 # Queue name
DB_QUEUE_RETRY_AFTER=90          # Retry failed jobs after 90 seconds

# Application
APP_DEBUG=true                    # Show errors in development
LOG_CHANNEL=single                # Log to single file
```

## Monitoring Commands

```bash
# Watch queue jobs
php artisan queue:monitor

# Show failed jobs
php artisan queue:failed

# Retry specific failed job
php artisan queue:retry {id}

# Retry all failed jobs
php artisan queue:retry all

# Flush failed jobs
php artisan queue:flush

# Monitor in real-time
watch 'php artisan queue:failed | tail -20'
```

## Debug Tips

### Enable Detailed Logging
```php
// In .env
LOG_LEVEL=debug

// Or in code
Log::debug('Theme generation', [
    'theme_id' => $theme->id,
    'status' => $theme->status,
    'prompt' => $theme->prompt_used,
]);
```

### Check Job Status
```bash
# See job data in database
select * from jobs where id = 123;

# See if job is being processed
select * from jobs where reserved_at is not null;

# Count pending jobs
select count(*) from jobs where reserved_at is null;
```

### Test API Endpoint
```bash
# Using curl
curl -X POST http://localhost:8000/customer/themes/generate/new \
  -H "Content-Type: application/json" \
  -H "X-CSRF-Token: $(csrf_token)" \
  -d '{"name":"Test","event_type":"wedding","prompt":"Test prompt with details"}'
```

## Version History

- **v1.0** (2025-01-27): Initial release
  - ✅ FAL.ai integration
  - ✅ Hybrid mode (real + mock)
  - ✅ Async queue processing
  - ✅ Auto-retry logic
  - ✅ Modal component
  - ✅ Status polling

---

**Need help?** Check `AI_THEME_GENERATION_GUIDE.md` for more details.
