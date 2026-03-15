import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::index
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:17
 * @route '/business-owner/analytics'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/business-owner/analytics',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::index
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:17
 * @route '/business-owner/analytics'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::index
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:17
 * @route '/business-owner/analytics'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::index
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:17
 * @route '/business-owner/analytics'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::index
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:17
 * @route '/business-owner/analytics'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::index
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:17
 * @route '/business-owner/analytics'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::index
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:17
 * @route '/business-owner/analytics'
 */
        indexForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    index.form = indexForm
/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::reports
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:151
 * @route '/business-owner/analytics/reports'
 */
export const reports = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: reports.url(options),
    method: 'get',
})

reports.definition = {
    methods: ["get","head"],
    url: '/business-owner/analytics/reports',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::reports
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:151
 * @route '/business-owner/analytics/reports'
 */
reports.url = (options?: RouteQueryOptions) => {
    return reports.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::reports
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:151
 * @route '/business-owner/analytics/reports'
 */
reports.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: reports.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::reports
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:151
 * @route '/business-owner/analytics/reports'
 */
reports.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: reports.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::reports
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:151
 * @route '/business-owner/analytics/reports'
 */
    const reportsForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: reports.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::reports
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:151
 * @route '/business-owner/analytics/reports'
 */
        reportsForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: reports.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::reports
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:151
 * @route '/business-owner/analytics/reports'
 */
        reportsForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: reports.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    reports.form = reportsForm
/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::generateReport
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:156
 * @route '/business-owner/analytics/reports/generate'
 */
export const generateReport = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: generateReport.url(options),
    method: 'post',
})

generateReport.definition = {
    methods: ["post"],
    url: '/business-owner/analytics/reports/generate',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::generateReport
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:156
 * @route '/business-owner/analytics/reports/generate'
 */
generateReport.url = (options?: RouteQueryOptions) => {
    return generateReport.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::generateReport
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:156
 * @route '/business-owner/analytics/reports/generate'
 */
generateReport.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: generateReport.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::generateReport
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:156
 * @route '/business-owner/analytics/reports/generate'
 */
    const generateReportForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: generateReport.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\AnalyticsController::generateReport
 * @see app/Http/Controllers/BusinessOwner/AnalyticsController.php:156
 * @route '/business-owner/analytics/reports/generate'
 */
        generateReportForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: generateReport.url(options),
            method: 'post',
        })
    
    generateReport.form = generateReportForm
const AnalyticsController = { index, reports, generateReport }

export default AnalyticsController