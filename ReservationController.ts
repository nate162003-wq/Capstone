import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\EventManager\ReservationController::index
 * @see app/Http/Controllers/EventManager/ReservationController.php:14
 * @route '/event-manager/reservations'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/event-manager/reservations',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::index
 * @see app/Http/Controllers/EventManager/ReservationController.php:14
 * @route '/event-manager/reservations'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::index
 * @see app/Http/Controllers/EventManager/ReservationController.php:14
 * @route '/event-manager/reservations'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\EventManager\ReservationController::index
 * @see app/Http/Controllers/EventManager/ReservationController.php:14
 * @route '/event-manager/reservations'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::index
 * @see app/Http/Controllers/EventManager/ReservationController.php:14
 * @route '/event-manager/reservations'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::index
 * @see app/Http/Controllers/EventManager/ReservationController.php:14
 * @route '/event-manager/reservations'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\EventManager\ReservationController::index
 * @see app/Http/Controllers/EventManager/ReservationController.php:14
 * @route '/event-manager/reservations'
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
* @see \App\Http\Controllers\EventManager\ReservationController::show
 * @see app/Http/Controllers/EventManager/ReservationController.php:46
 * @route '/event-manager/reservations/{booking}'
 */
export const show = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/event-manager/reservations/{booking}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::show
 * @see app/Http/Controllers/EventManager/ReservationController.php:46
 * @route '/event-manager/reservations/{booking}'
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
* @see \App\Http\Controllers\EventManager\ReservationController::show
 * @see app/Http/Controllers/EventManager/ReservationController.php:46
 * @route '/event-manager/reservations/{booking}'
 */
show.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\EventManager\ReservationController::show
 * @see app/Http/Controllers/EventManager/ReservationController.php:46
 * @route '/event-manager/reservations/{booking}'
 */
show.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::show
 * @see app/Http/Controllers/EventManager/ReservationController.php:46
 * @route '/event-manager/reservations/{booking}'
 */
    const showForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::show
 * @see app/Http/Controllers/EventManager/ReservationController.php:46
 * @route '/event-manager/reservations/{booking}'
 */
        showForm.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\EventManager\ReservationController::show
 * @see app/Http/Controllers/EventManager/ReservationController.php:46
 * @route '/event-manager/reservations/{booking}'
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
* @see \App\Http\Controllers\EventManager\ReservationController::confirm
 * @see app/Http/Controllers/EventManager/ReservationController.php:66
 * @route '/event-manager/reservations/{booking}/confirm'
 */
export const confirm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: confirm.url(args, options),
    method: 'post',
})

confirm.definition = {
    methods: ["post"],
    url: '/event-manager/reservations/{booking}/confirm',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::confirm
 * @see app/Http/Controllers/EventManager/ReservationController.php:66
 * @route '/event-manager/reservations/{booking}/confirm'
 */
confirm.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return confirm.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::confirm
 * @see app/Http/Controllers/EventManager/ReservationController.php:66
 * @route '/event-manager/reservations/{booking}/confirm'
 */
confirm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: confirm.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::confirm
 * @see app/Http/Controllers/EventManager/ReservationController.php:66
 * @route '/event-manager/reservations/{booking}/confirm'
 */
    const confirmForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: confirm.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::confirm
 * @see app/Http/Controllers/EventManager/ReservationController.php:66
 * @route '/event-manager/reservations/{booking}/confirm'
 */
        confirmForm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: confirm.url(args, options),
            method: 'post',
        })
    
    confirm.form = confirmForm
/**
* @see \App\Http\Controllers\EventManager\ReservationController::cancel
 * @see app/Http/Controllers/EventManager/ReservationController.php:98
 * @route '/event-manager/reservations/{booking}/cancel'
 */
export const cancel = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: cancel.url(args, options),
    method: 'post',
})

cancel.definition = {
    methods: ["post"],
    url: '/event-manager/reservations/{booking}/cancel',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::cancel
 * @see app/Http/Controllers/EventManager/ReservationController.php:98
 * @route '/event-manager/reservations/{booking}/cancel'
 */
cancel.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return cancel.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::cancel
 * @see app/Http/Controllers/EventManager/ReservationController.php:98
 * @route '/event-manager/reservations/{booking}/cancel'
 */
cancel.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: cancel.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::cancel
 * @see app/Http/Controllers/EventManager/ReservationController.php:98
 * @route '/event-manager/reservations/{booking}/cancel'
 */
    const cancelForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: cancel.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::cancel
 * @see app/Http/Controllers/EventManager/ReservationController.php:98
 * @route '/event-manager/reservations/{booking}/cancel'
 */
        cancelForm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: cancel.url(args, options),
            method: 'post',
        })
    
    cancel.form = cancelForm
/**
* @see \App\Http\Controllers\EventManager\ReservationController::complete
 * @see app/Http/Controllers/EventManager/ReservationController.php:112
 * @route '/event-manager/reservations/{booking}/complete'
 */
export const complete = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: complete.url(args, options),
    method: 'post',
})

complete.definition = {
    methods: ["post"],
    url: '/event-manager/reservations/{booking}/complete',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::complete
 * @see app/Http/Controllers/EventManager/ReservationController.php:112
 * @route '/event-manager/reservations/{booking}/complete'
 */
complete.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return complete.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::complete
 * @see app/Http/Controllers/EventManager/ReservationController.php:112
 * @route '/event-manager/reservations/{booking}/complete'
 */
complete.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: complete.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::complete
 * @see app/Http/Controllers/EventManager/ReservationController.php:112
 * @route '/event-manager/reservations/{booking}/complete'
 */
    const completeForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: complete.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::complete
 * @see app/Http/Controllers/EventManager/ReservationController.php:112
 * @route '/event-manager/reservations/{booking}/complete'
 */
        completeForm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: complete.url(args, options),
            method: 'post',
        })
    
    complete.form = completeForm
/**
* @see \App\Http\Controllers\EventManager\ReservationController::assignPhotographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:174
 * @route '/event-manager/reservations/{booking}/assign-photographer'
 */
export const assignPhotographer = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: assignPhotographer.url(args, options),
    method: 'post',
})

assignPhotographer.definition = {
    methods: ["post"],
    url: '/event-manager/reservations/{booking}/assign-photographer',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::assignPhotographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:174
 * @route '/event-manager/reservations/{booking}/assign-photographer'
 */
assignPhotographer.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return assignPhotographer.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::assignPhotographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:174
 * @route '/event-manager/reservations/{booking}/assign-photographer'
 */
assignPhotographer.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: assignPhotographer.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::assignPhotographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:174
 * @route '/event-manager/reservations/{booking}/assign-photographer'
 */
    const assignPhotographerForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: assignPhotographer.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::assignPhotographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:174
 * @route '/event-manager/reservations/{booking}/assign-photographer'
 */
        assignPhotographerForm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: assignPhotographer.url(args, options),
            method: 'post',
        })
    
    assignPhotographer.form = assignPhotographerForm
/**
* @see \App\Http\Controllers\EventManager\ReservationController::assignVideographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:195
 * @route '/event-manager/reservations/{booking}/assign-videographer'
 */
export const assignVideographer = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: assignVideographer.url(args, options),
    method: 'post',
})

assignVideographer.definition = {
    methods: ["post"],
    url: '/event-manager/reservations/{booking}/assign-videographer',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::assignVideographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:195
 * @route '/event-manager/reservations/{booking}/assign-videographer'
 */
assignVideographer.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return assignVideographer.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::assignVideographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:195
 * @route '/event-manager/reservations/{booking}/assign-videographer'
 */
assignVideographer.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: assignVideographer.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::assignVideographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:195
 * @route '/event-manager/reservations/{booking}/assign-videographer'
 */
    const assignVideographerForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: assignVideographer.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::assignVideographer
 * @see app/Http/Controllers/EventManager/ReservationController.php:195
 * @route '/event-manager/reservations/{booking}/assign-videographer'
 */
        assignVideographerForm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: assignVideographer.url(args, options),
            method: 'post',
        })
    
    assignVideographer.form = assignVideographerForm
/**
* @see \App\Http\Controllers\EventManager\ReservationController::updatePaymentStatus
 * @see app/Http/Controllers/EventManager/ReservationController.php:125
 * @route '/event-manager/reservations/{booking}/payment-status'
 */
export const updatePaymentStatus = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: updatePaymentStatus.url(args, options),
    method: 'post',
})

updatePaymentStatus.definition = {
    methods: ["post"],
    url: '/event-manager/reservations/{booking}/payment-status',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::updatePaymentStatus
 * @see app/Http/Controllers/EventManager/ReservationController.php:125
 * @route '/event-manager/reservations/{booking}/payment-status'
 */
updatePaymentStatus.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return updatePaymentStatus.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::updatePaymentStatus
 * @see app/Http/Controllers/EventManager/ReservationController.php:125
 * @route '/event-manager/reservations/{booking}/payment-status'
 */
updatePaymentStatus.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: updatePaymentStatus.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::updatePaymentStatus
 * @see app/Http/Controllers/EventManager/ReservationController.php:125
 * @route '/event-manager/reservations/{booking}/payment-status'
 */
    const updatePaymentStatusForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: updatePaymentStatus.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::updatePaymentStatus
 * @see app/Http/Controllers/EventManager/ReservationController.php:125
 * @route '/event-manager/reservations/{booking}/payment-status'
 */
        updatePaymentStatusForm.post = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: updatePaymentStatus.url(args, options),
            method: 'post',
        })
    
    updatePaymentStatus.form = updatePaymentStatusForm
/**
* @see \App\Http\Controllers\EventManager\ReservationController::calendar
 * @see app/Http/Controllers/EventManager/ReservationController.php:216
 * @route '/event-manager/calendar'
 */
export const calendar = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: calendar.url(options),
    method: 'get',
})

calendar.definition = {
    methods: ["get","head"],
    url: '/event-manager/calendar',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\EventManager\ReservationController::calendar
 * @see app/Http/Controllers/EventManager/ReservationController.php:216
 * @route '/event-manager/calendar'
 */
calendar.url = (options?: RouteQueryOptions) => {
    return calendar.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\EventManager\ReservationController::calendar
 * @see app/Http/Controllers/EventManager/ReservationController.php:216
 * @route '/event-manager/calendar'
 */
calendar.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: calendar.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\EventManager\ReservationController::calendar
 * @see app/Http/Controllers/EventManager/ReservationController.php:216
 * @route '/event-manager/calendar'
 */
calendar.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: calendar.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\EventManager\ReservationController::calendar
 * @see app/Http/Controllers/EventManager/ReservationController.php:216
 * @route '/event-manager/calendar'
 */
    const calendarForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: calendar.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\EventManager\ReservationController::calendar
 * @see app/Http/Controllers/EventManager/ReservationController.php:216
 * @route '/event-manager/calendar'
 */
        calendarForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: calendar.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\EventManager\ReservationController::calendar
 * @see app/Http/Controllers/EventManager/ReservationController.php:216
 * @route '/event-manager/calendar'
 */
        calendarForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: calendar.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    calendar.form = calendarForm
const ReservationController = { index, show, confirm, cancel, complete, assignPhotographer, assignVideographer, updatePaymentStatus, calendar }

export default ReservationController