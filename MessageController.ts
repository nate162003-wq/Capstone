import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\EventManager\MessageController::index
 * @see app/Http/Controllers/EventManager/MessageController.php:13
 * @route '/event-manager/messages'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/event-manager/messages',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\EventManager\MessageController::index
 * @see app/Http/Controllers/EventManager/MessageController.php:13
 * @route '/event-manager/messages'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\MessageController::index
 * @see app/Http/Controllers/EventManager/MessageController.php:13
 * @route '/event-manager/messages'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\EventManager\MessageController::index
 * @see app/Http/Controllers/EventManager/MessageController.php:13
 * @route '/event-manager/messages'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\EventManager\MessageController::index
 * @see app/Http/Controllers/EventManager/MessageController.php:13
 * @route '/event-manager/messages'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\EventManager\MessageController::index
 * @see app/Http/Controllers/EventManager/MessageController.php:13
 * @route '/event-manager/messages'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\EventManager\MessageController::index
 * @see app/Http/Controllers/EventManager/MessageController.php:13
 * @route '/event-manager/messages'
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
* @see \App\Http\Controllers\EventManager\MessageController::show
 * @see app/Http/Controllers/EventManager/MessageController.php:29
 * @route '/event-manager/messages/{booking}'
 */
export const show = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/event-manager/messages/{booking}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\EventManager\MessageController::show
 * @see app/Http/Controllers/EventManager/MessageController.php:29
 * @route '/event-manager/messages/{booking}'
 */
show.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return show.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\MessageController::show
 * @see app/Http/Controllers/EventManager/MessageController.php:29
 * @route '/event-manager/messages/{booking}'
 */
show.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\EventManager\MessageController::show
 * @see app/Http/Controllers/EventManager/MessageController.php:29
 * @route '/event-manager/messages/{booking}'
 */
show.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\EventManager\MessageController::show
 * @see app/Http/Controllers/EventManager/MessageController.php:29
 * @route '/event-manager/messages/{booking}'
 */
    const showForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\EventManager\MessageController::show
 * @see app/Http/Controllers/EventManager/MessageController.php:29
 * @route '/event-manager/messages/{booking}'
 */
        showForm.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\EventManager\MessageController::show
 * @see app/Http/Controllers/EventManager/MessageController.php:29
 * @route '/event-manager/messages/{booking}'
 */
        showForm.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
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
* @see \App\Http\Controllers\EventManager\MessageController::store
 * @see app/Http/Controllers/EventManager/MessageController.php:53
 * @route '/event-manager/messages/{booking}'
 */
export const store = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(args, options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/event-manager/messages/{booking}',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\MessageController::store
 * @see app/Http/Controllers/EventManager/MessageController.php:53
 * @route '/event-manager/messages/{booking}'
 */
store.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return store.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\MessageController::store
 * @see app/Http/Controllers/EventManager/MessageController.php:53
 * @route '/event-manager/messages/{booking}'
 */
store.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\MessageController::store
 * @see app/Http/Controllers/EventManager/MessageController.php:53
 * @route '/event-manager/messages/{booking}'
 */
    const storeForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\MessageController::store
 * @see app/Http/Controllers/EventManager/MessageController.php:53
 * @route '/event-manager/messages/{booking}'
 */
        storeForm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(args, options),
            method: 'post',
        })
    
    store.form = storeForm
const MessageController = { index, show, store }

export default MessageController