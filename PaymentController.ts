import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\Customer\PaymentController::create
 * @see app/Http/Controllers/Customer/PaymentController.php:18
 * @route '/customer/bookings/{booking}/payments/create'
 */
export const create = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(args, options),
    method: 'get',
})

create.definition = {
    methods: ["get","head"],
    url: '/customer/bookings/{booking}/payments/create',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\PaymentController::create
 * @see app/Http/Controllers/Customer/PaymentController.php:18
 * @route '/customer/bookings/{booking}/payments/create'
 */
create.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return create.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\PaymentController::create
 * @see app/Http/Controllers/Customer/PaymentController.php:18
 * @route '/customer/bookings/{booking}/payments/create'
 */
create.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\PaymentController::create
 * @see app/Http/Controllers/Customer/PaymentController.php:18
 * @route '/customer/bookings/{booking}/payments/create'
 */
create.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: create.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\PaymentController::create
 * @see app/Http/Controllers/Customer/PaymentController.php:18
 * @route '/customer/bookings/{booking}/payments/create'
 */
    const createForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: create.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\PaymentController::create
 * @see app/Http/Controllers/Customer/PaymentController.php:18
 * @route '/customer/bookings/{booking}/payments/create'
 */
        createForm.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\PaymentController::create
 * @see app/Http/Controllers/Customer/PaymentController.php:18
 * @route '/customer/bookings/{booking}/payments/create'
 */
        createForm.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    create.form = createForm
/**
* @see \App\Http\Controllers\Customer\PaymentController::store
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/bookings/{booking}/payments'
 */
export const store = (args: { booking: string | number } | [booking: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(args, options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/customer/bookings/{booking}/payments',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\Customer\PaymentController::store
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/bookings/{booking}/payments'
 */
store.url = (args: { booking: string | number } | [booking: string | number ] | string | number, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: args.booking,
                }

    return store.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\PaymentController::store
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/bookings/{booking}/payments'
 */
store.post = (args: { booking: string | number } | [booking: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\Customer\PaymentController::store
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/bookings/{booking}/payments'
 */
    const storeForm = (args: { booking: string | number } | [booking: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\PaymentController::store
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/bookings/{booking}/payments'
 */
        storeForm.post = (args: { booking: string | number } | [booking: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(args, options),
            method: 'post',
        })
    
    store.form = storeForm
/**
* @see \App\Http\Controllers\Customer\PaymentController::show
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/payments/{payment}'
 */
export const show = (args: { payment: string | number } | [payment: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/customer/payments/{payment}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\PaymentController::show
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/payments/{payment}'
 */
show.url = (args: { payment: string | number } | [payment: string | number ] | string | number, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { payment: args }
    }

    
    if (Array.isArray(args)) {
        args = {
                    payment: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        payment: args.payment,
                }

    return show.definition.url
            .replace('{payment}', parsedArgs.payment.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\PaymentController::show
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/payments/{payment}'
 */
show.get = (args: { payment: string | number } | [payment: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\PaymentController::show
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/payments/{payment}'
 */
show.head = (args: { payment: string | number } | [payment: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\PaymentController::show
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/payments/{payment}'
 */
    const showForm = (args: { payment: string | number } | [payment: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\PaymentController::show
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/payments/{payment}'
 */
        showForm.get = (args: { payment: string | number } | [payment: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\PaymentController::show
 * @see app/Http/Controllers/Customer/PaymentController.php:0
 * @route '/customer/payments/{payment}'
 */
        showForm.head = (args: { payment: string | number } | [payment: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    show.form = showForm
const PaymentController = { create, store, show }

export default PaymentController