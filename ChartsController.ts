import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults, validateParameters } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::dashboard
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:60
 * @route '/business-owner/charts/dashboard'
 */
export const dashboard = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: dashboard.url(options),
    method: 'get',
})

dashboard.definition = {
    methods: ["get","head"],
    url: '/business-owner/charts/dashboard',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::dashboard
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:60
 * @route '/business-owner/charts/dashboard'
 */
dashboard.url = (options?: RouteQueryOptions) => {
    return dashboard.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::dashboard
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:60
 * @route '/business-owner/charts/dashboard'
 */
dashboard.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: dashboard.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::dashboard
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:60
 * @route '/business-owner/charts/dashboard'
 */
dashboard.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: dashboard.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::dashboard
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:60
 * @route '/business-owner/charts/dashboard'
 */
    const dashboardForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: dashboard.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::dashboard
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:60
 * @route '/business-owner/charts/dashboard'
 */
        dashboardForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: dashboard.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::dashboard
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:60
 * @route '/business-owner/charts/dashboard'
 */
        dashboardForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: dashboard.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    dashboard.form = dashboardForm
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::salesTrend
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:20
 * @route '/business-owner/charts/sales-trend/{period?}'
 */
export const salesTrend = (args?: { period?: string | number } | [period: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: salesTrend.url(args, options),
    method: 'get',
})

salesTrend.definition = {
    methods: ["get","head"],
    url: '/business-owner/charts/sales-trend/{period?}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::salesTrend
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:20
 * @route '/business-owner/charts/sales-trend/{period?}'
 */
salesTrend.url = (args?: { period?: string | number } | [period: string | number ] | string | number, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { period: args }
    }

    
    if (Array.isArray(args)) {
        args = {
                    period: args[0],
                }
    }

    args = applyUrlDefaults(args)

    validateParameters(args, [
            "period",
        ])

    const parsedArgs = {
                        period: args?.period,
                }

    return salesTrend.definition.url
            .replace('{period?}', parsedArgs.period?.toString() ?? '')
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::salesTrend
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:20
 * @route '/business-owner/charts/sales-trend/{period?}'
 */
salesTrend.get = (args?: { period?: string | number } | [period: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: salesTrend.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::salesTrend
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:20
 * @route '/business-owner/charts/sales-trend/{period?}'
 */
salesTrend.head = (args?: { period?: string | number } | [period: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: salesTrend.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::salesTrend
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:20
 * @route '/business-owner/charts/sales-trend/{period?}'
 */
    const salesTrendForm = (args?: { period?: string | number } | [period: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: salesTrend.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::salesTrend
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:20
 * @route '/business-owner/charts/sales-trend/{period?}'
 */
        salesTrendForm.get = (args?: { period?: string | number } | [period: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: salesTrend.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::salesTrend
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:20
 * @route '/business-owner/charts/sales-trend/{period?}'
 */
        salesTrendForm.head = (args?: { period?: string | number } | [period: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: salesTrend.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    salesTrend.form = salesTrendForm
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::customerDemographics
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:31
 * @route '/business-owner/charts/customer-demographics'
 */
export const customerDemographics = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: customerDemographics.url(options),
    method: 'get',
})

customerDemographics.definition = {
    methods: ["get","head"],
    url: '/business-owner/charts/customer-demographics',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::customerDemographics
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:31
 * @route '/business-owner/charts/customer-demographics'
 */
customerDemographics.url = (options?: RouteQueryOptions) => {
    return customerDemographics.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::customerDemographics
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:31
 * @route '/business-owner/charts/customer-demographics'
 */
customerDemographics.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: customerDemographics.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::customerDemographics
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:31
 * @route '/business-owner/charts/customer-demographics'
 */
customerDemographics.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: customerDemographics.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::customerDemographics
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:31
 * @route '/business-owner/charts/customer-demographics'
 */
    const customerDemographicsForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: customerDemographics.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::customerDemographics
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:31
 * @route '/business-owner/charts/customer-demographics'
 */
        customerDemographicsForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: customerDemographics.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::customerDemographics
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:31
 * @route '/business-owner/charts/customer-demographics'
 */
        customerDemographicsForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: customerDemographics.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    customerDemographics.form = customerDemographicsForm
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::aggregation
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:45
 * @route '/business-owner/charts/aggregation'
 */
export const aggregation = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: aggregation.url(options),
    method: 'get',
})

aggregation.definition = {
    methods: ["get","head"],
    url: '/business-owner/charts/aggregation',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::aggregation
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:45
 * @route '/business-owner/charts/aggregation'
 */
aggregation.url = (options?: RouteQueryOptions) => {
    return aggregation.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::aggregation
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:45
 * @route '/business-owner/charts/aggregation'
 */
aggregation.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: aggregation.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::aggregation
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:45
 * @route '/business-owner/charts/aggregation'
 */
aggregation.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: aggregation.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::aggregation
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:45
 * @route '/business-owner/charts/aggregation'
 */
    const aggregationForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: aggregation.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::aggregation
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:45
 * @route '/business-owner/charts/aggregation'
 */
        aggregationForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: aggregation.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\ChartsController::aggregation
 * @see app/Http/Controllers/BusinessOwner/ChartsController.php:45
 * @route '/business-owner/charts/aggregation'
 */
        aggregationForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: aggregation.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    aggregation.form = aggregationForm
const ChartsController = { dashboard, salesTrend, customerDemographics, aggregation }

export default ChartsController