import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\Customer\ThemeController::index
 * @see app/Http/Controllers/Customer/ThemeController.php:12
 * @route '/customer/themes'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/customer/themes',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\ThemeController::index
 * @see app/Http/Controllers/Customer/ThemeController.php:12
 * @route '/customer/themes'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeController::index
 * @see app/Http/Controllers/Customer/ThemeController.php:12
 * @route '/customer/themes'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\ThemeController::index
 * @see app/Http/Controllers/Customer/ThemeController.php:12
 * @route '/customer/themes'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeController::index
 * @see app/Http/Controllers/Customer/ThemeController.php:12
 * @route '/customer/themes'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeController::index
 * @see app/Http/Controllers/Customer/ThemeController.php:12
 * @route '/customer/themes'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\ThemeController::index
 * @see app/Http/Controllers/Customer/ThemeController.php:12
 * @route '/customer/themes'
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
* @see \App\Http\Controllers\Customer\ThemeController::create
 * @see app/Http/Controllers/Customer/ThemeController.php:23
 * @route '/customer/themes/create'
 */
export const create = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})

create.definition = {
    methods: ["get","head"],
    url: '/customer/themes/create',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\ThemeController::create
 * @see app/Http/Controllers/Customer/ThemeController.php:23
 * @route '/customer/themes/create'
 */
create.url = (options?: RouteQueryOptions) => {
    return create.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeController::create
 * @see app/Http/Controllers/Customer/ThemeController.php:23
 * @route '/customer/themes/create'
 */
create.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\ThemeController::create
 * @see app/Http/Controllers/Customer/ThemeController.php:23
 * @route '/customer/themes/create'
 */
create.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: create.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeController::create
 * @see app/Http/Controllers/Customer/ThemeController.php:23
 * @route '/customer/themes/create'
 */
    const createForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: create.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeController::create
 * @see app/Http/Controllers/Customer/ThemeController.php:23
 * @route '/customer/themes/create'
 */
        createForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\ThemeController::create
 * @see app/Http/Controllers/Customer/ThemeController.php:23
 * @route '/customer/themes/create'
 */
        createForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    create.form = createForm
/**
* @see \App\Http\Controllers\Customer\ThemeController::store
 * @see app/Http/Controllers/Customer/ThemeController.php:28
 * @route '/customer/themes'
 */
export const store = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/customer/themes',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\Customer\ThemeController::store
 * @see app/Http/Controllers/Customer/ThemeController.php:28
 * @route '/customer/themes'
 */
store.url = (options?: RouteQueryOptions) => {
    return store.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeController::store
 * @see app/Http/Controllers/Customer/ThemeController.php:28
 * @route '/customer/themes'
 */
store.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeController::store
 * @see app/Http/Controllers/Customer/ThemeController.php:28
 * @route '/customer/themes'
 */
    const storeForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeController::store
 * @see app/Http/Controllers/Customer/ThemeController.php:28
 * @route '/customer/themes'
 */
        storeForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(options),
            method: 'post',
        })
    
    store.form = storeForm
/**
* @see \App\Http\Controllers\Customer\ThemeController::show
 * @see app/Http/Controllers/Customer/ThemeController.php:53
 * @route '/customer/themes/{theme}'
 */
export const show = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/customer/themes/{theme}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\ThemeController::show
 * @see app/Http/Controllers/Customer/ThemeController.php:53
 * @route '/customer/themes/{theme}'
 */
show.url = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return show.definition.url
            .replace('{theme}', parsedArgs.theme.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeController::show
 * @see app/Http/Controllers/Customer/ThemeController.php:53
 * @route '/customer/themes/{theme}'
 */
show.get = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\ThemeController::show
 * @see app/Http/Controllers/Customer/ThemeController.php:53
 * @route '/customer/themes/{theme}'
 */
show.head = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeController::show
 * @see app/Http/Controllers/Customer/ThemeController.php:53
 * @route '/customer/themes/{theme}'
 */
    const showForm = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeController::show
 * @see app/Http/Controllers/Customer/ThemeController.php:53
 * @route '/customer/themes/{theme}'
 */
        showForm.get = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\ThemeController::show
 * @see app/Http/Controllers/Customer/ThemeController.php:53
 * @route '/customer/themes/{theme}'
 */
        showForm.head = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    show.form = showForm
/**
* @see \App\Http\Controllers\Customer\ThemeController::destroy
 * @see app/Http/Controllers/Customer/ThemeController.php:64
 * @route '/customer/themes/{theme}'
 */
export const destroy = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

destroy.definition = {
    methods: ["delete"],
    url: '/customer/themes/{theme}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\Customer\ThemeController::destroy
 * @see app/Http/Controllers/Customer/ThemeController.php:64
 * @route '/customer/themes/{theme}'
 */
destroy.url = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return destroy.definition.url
            .replace('{theme}', parsedArgs.theme.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeController::destroy
 * @see app/Http/Controllers/Customer/ThemeController.php:64
 * @route '/customer/themes/{theme}'
 */
destroy.delete = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeController::destroy
 * @see app/Http/Controllers/Customer/ThemeController.php:64
 * @route '/customer/themes/{theme}'
 */
    const destroyForm = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroy.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeController::destroy
 * @see app/Http/Controllers/Customer/ThemeController.php:64
 * @route '/customer/themes/{theme}'
 */
        destroyForm.delete = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: destroy.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'DELETE',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    destroy.form = destroyForm
/**
* @see \App\Http\Controllers\Customer\ThemeController::toggleFavorite
 * @see app/Http/Controllers/Customer/ThemeController.php:76
 * @route '/customer/themes/{theme}/favorite'
 */
export const toggleFavorite = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleFavorite.url(args, options),
    method: 'post',
})

toggleFavorite.definition = {
    methods: ["post"],
    url: '/customer/themes/{theme}/favorite',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\Customer\ThemeController::toggleFavorite
 * @see app/Http/Controllers/Customer/ThemeController.php:76
 * @route '/customer/themes/{theme}/favorite'
 */
toggleFavorite.url = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return toggleFavorite.definition.url
            .replace('{theme}', parsedArgs.theme.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\ThemeController::toggleFavorite
 * @see app/Http/Controllers/Customer/ThemeController.php:76
 * @route '/customer/themes/{theme}/favorite'
 */
toggleFavorite.post = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleFavorite.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\Customer\ThemeController::toggleFavorite
 * @see app/Http/Controllers/Customer/ThemeController.php:76
 * @route '/customer/themes/{theme}/favorite'
 */
    const toggleFavoriteForm = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: toggleFavorite.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\ThemeController::toggleFavorite
 * @see app/Http/Controllers/Customer/ThemeController.php:76
 * @route '/customer/themes/{theme}/favorite'
 */
        toggleFavoriteForm.post = (args: { theme: string | number | { id: string | number } } | [theme: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: toggleFavorite.url(args, options),
            method: 'post',
        })
    
    toggleFavorite.form = toggleFavoriteForm
const ThemeController = { index, create, store, show, destroy, toggleFavorite }

export default ThemeController