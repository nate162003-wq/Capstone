import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generate
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:22
 * @route '/customer/themes/generate/new'
 */
export const generate = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: generate.url(options),
    method: 'post',
})

generate.definition = {
    methods: ["post"],
    url: '/customer/themes/generate/new',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generate
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:22
 * @route '/customer/themes/generate/new'
 */
generate.url = (options?: RouteQueryOptions) => {
    return generate.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generate
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:22
 * @route '/customer/themes/generate/new'
 */
generate.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: generate.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generate
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:22
 * @route '/customer/themes/generate/new'
 */
    const generateForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: generate.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generate
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:22
 * @route '/customer/themes/generate/new'
 */
        generateForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: generate.url(options),
            method: 'post',
        })
    
    generate.form = generateForm
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generatingThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:157
 * @route '/customer/themes/generating/list'
 */
export const generatingThemes = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: generatingThemes.url(options),
    method: 'get',
})

generatingThemes.definition = {
    methods: ["get","head"],
    url: '/customer/themes/generating/list',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generatingThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:157
 * @route '/customer/themes/generating/list'
 */
generatingThemes.url = (options?: RouteQueryOptions) => {
    return generatingThemes.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generatingThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:157
 * @route '/customer/themes/generating/list'
 */
generatingThemes.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: generatingThemes.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generatingThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:157
 * @route '/customer/themes/generating/list'
 */
generatingThemes.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: generatingThemes.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generatingThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:157
 * @route '/customer/themes/generating/list'
 */
    const generatingThemesForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: generatingThemes.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generatingThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:157
 * @route '/customer/themes/generating/list'
 */
        generatingThemesForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: generatingThemes.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::generatingThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:157
 * @route '/customer/themes/generating/list'
 */
        generatingThemesForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: generatingThemes.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    generatingThemes.form = generatingThemesForm
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::availableThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:177
 * @route '/customer/themes/available/list'
 */
export const availableThemes = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: availableThemes.url(options),
    method: 'get',
})

availableThemes.definition = {
    methods: ["get","head"],
    url: '/customer/themes/available/list',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::availableThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:177
 * @route '/customer/themes/available/list'
 */
availableThemes.url = (options?: RouteQueryOptions) => {
    return availableThemes.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::availableThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:177
 * @route '/customer/themes/available/list'
 */
availableThemes.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: availableThemes.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::availableThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:177
 * @route '/customer/themes/available/list'
 */
availableThemes.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: availableThemes.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::availableThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:177
 * @route '/customer/themes/available/list'
 */
    const availableThemesForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: availableThemes.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::availableThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:177
 * @route '/customer/themes/available/list'
 */
        availableThemesForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: availableThemes.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::availableThemes
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:177
 * @route '/customer/themes/available/list'
 */
        availableThemesForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: availableThemes.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    availableThemes.form = availableThemesForm
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::status
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:103
 * @route '/customer/themes/{theme}/status'
 */
export const status = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: status.url(args, options),
    method: 'get',
})

status.definition = {
    methods: ["get","head"],
    url: '/customer/themes/{theme}/status',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::status
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:103
 * @route '/customer/themes/{theme}/status'
 */
status.url = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { theme: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { theme: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    theme: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        theme: typeof args.theme === 'object'
                ? args.theme.id
                : args.theme,
                }

    return status.definition.url
            .replace('{theme}', parsedArgs.theme.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::status
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:103
 * @route '/customer/themes/{theme}/status'
 */
status.get = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: status.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::status
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:103
 * @route '/customer/themes/{theme}/status'
 */
status.head = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: status.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::status
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:103
 * @route '/customer/themes/{theme}/status'
 */
    const statusForm = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: status.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::status
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:103
 * @route '/customer/themes/{theme}/status'
 */
        statusForm.get = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: status.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::status
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:103
 * @route '/customer/themes/{theme}/status'
 */
        statusForm.head = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: status.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    status.form = statusForm
/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::retry
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:124
 * @route '/customer/themes/{theme}/retry'
 */
export const retry = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: retry.url(args, options),
    method: 'post',
})

retry.definition = {
    methods: ["post"],
    url: '/customer/themes/{theme}/retry',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::retry
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:124
 * @route '/customer/themes/{theme}/retry'
 */
retry.url = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { theme: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { theme: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    theme: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        theme: typeof args.theme === 'object'
                ? args.theme.id
                : args.theme,
                }

    return retry.definition.url
            .replace('{theme}', parsedArgs.theme.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::retry
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:124
 * @route '/customer/themes/{theme}/retry'
 */
retry.post = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: retry.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::retry
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:124
 * @route '/customer/themes/{theme}/retry'
 */
    const retryForm = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: retry.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeGenerationController::retry
 * @see app/Http/Controllers/Customer/ThemeGenerationController.php:124
 * @route '/customer/themes/{theme}/retry'
 */
        retryForm.post = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: retry.url(args, options),
            method: 'post',
        })
    
    retry.form = retryForm
const ThemeGenerationController = { generate, generatingThemes, availableThemes, status, retry }

export default ThemeGenerationController