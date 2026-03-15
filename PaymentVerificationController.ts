import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::index
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:12
 * @route '/event-manager/payments'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/event-manager/payments',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::index
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:12
 * @route '/event-manager/payments'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::index
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:12
 * @route '/event-manager/payments'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::index
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:12
 * @route '/event-manager/payments'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::index
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:12
 * @route '/event-manager/payments'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::index
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:12
 * @route '/event-manager/payments'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::index
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:12
 * @route '/event-manager/payments'
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
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::show
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:30
 * @route '/event-manager/payments/{payment}'
 */
export const show = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/event-manager/payments/{payment}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::show
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:30
 * @route '/event-manager/payments/{payment}'
 */
show.url = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { payment: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { payment: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    payment: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        payment: typeof args.payment === 'object'
                ? args.payment.id
                : args.payment,
                }

    return show.definition.url
            .replace('{payment}', parsedArgs.payment.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::show
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:30
 * @route '/event-manager/payments/{payment}'
 */
show.get = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::show
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:30
 * @route '/event-manager/payments/{payment}'
 */
show.head = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::show
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:30
 * @route '/event-manager/payments/{payment}'
 */
    const showForm = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::show
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:30
 * @route '/event-manager/payments/{payment}'
 */
        showForm.get = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::show
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:30
 * @route '/event-manager/payments/{payment}'
 */
        showForm.head = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
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
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::verify
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:39
 * @route '/event-manager/payments/{payment}/verify'
 */
export const verify = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: verify.url(args, options),
    method: 'post',
})

verify.definition = {
    methods: ["post"],
    url: '/event-manager/payments/{payment}/verify',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::verify
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:39
 * @route '/event-manager/payments/{payment}/verify'
 */
verify.url = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { payment: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { payment: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    payment: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        payment: typeof args.payment === 'object'
                ? args.payment.id
                : args.payment,
                }

    return verify.definition.url
            .replace('{payment}', parsedArgs.payment.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::verify
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:39
 * @route '/event-manager/payments/{payment}/verify'
 */
verify.post = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: verify.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::verify
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:39
 * @route '/event-manager/payments/{payment}/verify'
 */
    const verifyForm = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: verify.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::verify
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:39
 * @route '/event-manager/payments/{payment}/verify'
 */
        verifyForm.post = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: verify.url(args, options),
            method: 'post',
        })
    
    verify.form = verifyForm
/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::reject
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:59
 * @route '/event-manager/payments/{payment}/reject'
 */
export const reject = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: reject.url(args, options),
    method: 'post',
})

reject.definition = {
    methods: ["post"],
    url: '/event-manager/payments/{payment}/reject',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::reject
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:59
 * @route '/event-manager/payments/{payment}/reject'
 */
reject.url = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { payment: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { payment: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    payment: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        payment: typeof args.payment === 'object'
                ? args.payment.id
                : args.payment,
                }

    return reject.definition.url
            .replace('{payment}', parsedArgs.payment.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::reject
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:59
 * @route '/event-manager/payments/{payment}/reject'
 */
reject.post = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: reject.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::reject
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:59
 * @route '/event-manager/payments/{payment}/reject'
 */
    const rejectForm = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: reject.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\PaymentVerificationController::reject
 * @see app/Http/Controllers/EventManager/PaymentVerificationController.php:59
 * @route '/event-manager/payments/{payment}/reject'
 */
        rejectForm.post = (args: { payment: string | number | { id: string | number } } | [payment: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: reject.url(args, options),
            method: 'post',
        })
    
    reject.form = rejectForm
const PaymentVerificationController = { index, show, verify, reject }

export default PaymentVerificationController