import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\Customer\BookingController::index
 * @see app/Http/Controllers/Customer/BookingController.php:16
 * @route '/customer/bookings'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/customer/bookings',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\BookingController::index
 * @see app/Http/Controllers/Customer/BookingController.php:16
 * @route '/customer/bookings'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\BookingController::index
 * @see app/Http/Controllers/Customer/BookingController.php:16
 * @route '/customer/bookings'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\BookingController::index
 * @see app/Http/Controllers/Customer/BookingController.php:16
 * @route '/customer/bookings'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\BookingController::index
 * @see app/Http/Controllers/Customer/BookingController.php:16
 * @route '/customer/bookings'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\BookingController::index
 * @see app/Http/Controllers/Customer/BookingController.php:16
 * @route '/customer/bookings'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\BookingController::index
 * @see app/Http/Controllers/Customer/BookingController.php:16
 * @route '/customer/bookings'
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
* @see \App\Http\Controllers\Customer\BookingController::create
 * @see app/Http/Controllers/Customer/BookingController.php:28
 * @route '/customer/bookings/create'
 */
export const create = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})

create.definition = {
    methods: ["get","head"],
    url: '/customer/bookings/create',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\BookingController::create
 * @see app/Http/Controllers/Customer/BookingController.php:28
 * @route '/customer/bookings/create'
 */
create.url = (options?: RouteQueryOptions) => {
    return create.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\BookingController::create
 * @see app/Http/Controllers/Customer/BookingController.php:28
 * @route '/customer/bookings/create'
 */
create.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\BookingController::create
 * @see app/Http/Controllers/Customer/BookingController.php:28
 * @route '/customer/bookings/create'
 */
create.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: create.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\BookingController::create
 * @see app/Http/Controllers/Customer/BookingController.php:28
 * @route '/customer/bookings/create'
 */
    const createForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: create.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\BookingController::create
 * @see app/Http/Controllers/Customer/BookingController.php:28
 * @route '/customer/bookings/create'
 */
        createForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\BookingController::create
 * @see app/Http/Controllers/Customer/BookingController.php:28
 * @route '/customer/bookings/create'
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
* @see \App\Http\Controllers\Customer\BookingController::store
 * @see app/Http/Controllers/Customer/BookingController.php:41
 * @route '/customer/bookings'
 */
export const store = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/customer/bookings',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\Customer\BookingController::store
 * @see app/Http/Controllers/Customer/BookingController.php:41
 * @route '/customer/bookings'
 */
store.url = (options?: RouteQueryOptions) => {
    return store.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\BookingController::store
 * @see app/Http/Controllers/Customer/BookingController.php:41
 * @route '/customer/bookings'
 */
store.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\Customer\BookingController::store
 * @see app/Http/Controllers/Customer/BookingController.php:41
 * @route '/customer/bookings'
 */
    const storeForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\BookingController::store
 * @see app/Http/Controllers/Customer/BookingController.php:41
 * @route '/customer/bookings'
 */
        storeForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(options),
            method: 'post',
        })
    
    store.form = storeForm
/**
* @see \App\Http\Controllers\Customer\BookingController::show
 * @see app/Http/Controllers/Customer/BookingController.php:76
 * @route '/customer/bookings/{booking}'
 */
export const show = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/customer/bookings/{booking}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\BookingController::show
 * @see app/Http/Controllers/Customer/BookingController.php:76
 * @route '/customer/bookings/{booking}'
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
* @see \App\Http\Controllers\Customer\BookingController::show
 * @see app/Http/Controllers/Customer/BookingController.php:76
 * @route '/customer/bookings/{booking}'
 */
show.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\BookingController::show
 * @see app/Http/Controllers/Customer/BookingController.php:76
 * @route '/customer/bookings/{booking}'
 */
show.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\BookingController::show
 * @see app/Http/Controllers/Customer/BookingController.php:76
 * @route '/customer/bookings/{booking}'
 */
    const showForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\BookingController::show
 * @see app/Http/Controllers/Customer/BookingController.php:76
 * @route '/customer/bookings/{booking}'
 */
        showForm.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\BookingController::show
 * @see app/Http/Controllers/Customer/BookingController.php:76
 * @route '/customer/bookings/{booking}'
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
* @see \App\Http\Controllers\Customer\BookingController::edit
 * @see app/Http/Controllers/Customer/BookingController.php:87
 * @route '/customer/bookings/{booking}/edit'
 */
export const edit = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})

edit.definition = {
    methods: ["get","head"],
    url: '/customer/bookings/{booking}/edit',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\Customer\BookingController::edit
 * @see app/Http/Controllers/Customer/BookingController.php:87
 * @route '/customer/bookings/{booking}/edit'
 */
edit.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return edit.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\BookingController::edit
 * @see app/Http/Controllers/Customer/BookingController.php:87
 * @route '/customer/bookings/{booking}/edit'
 */
edit.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\Customer\BookingController::edit
 * @see app/Http/Controllers/Customer/BookingController.php:87
 * @route '/customer/bookings/{booking}/edit'
 */
edit.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: edit.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\Customer\BookingController::edit
 * @see app/Http/Controllers/Customer/BookingController.php:87
 * @route '/customer/bookings/{booking}/edit'
 */
    const editForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: edit.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\Customer\BookingController::edit
 * @see app/Http/Controllers/Customer/BookingController.php:87
 * @route '/customer/bookings/{booking}/edit'
 */
        editForm.get = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: edit.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\Customer\BookingController::edit
 * @see app/Http/Controllers/Customer/BookingController.php:87
 * @route '/customer/bookings/{booking}/edit'
 */
        editForm.head = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: edit.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    edit.form = editForm
/**
* @see \App\Http\Controllers\Customer\BookingController::update
 * @see app/Http/Controllers/Customer/BookingController.php:107
 * @route '/customer/bookings/{booking}'
 */
export const update = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})

update.definition = {
    methods: ["put","patch"],
    url: '/customer/bookings/{booking}',
} satisfies RouteDefinition<["put","patch"]>

/**
* @see \App\Http\Controllers\Customer\BookingController::update
 * @see app/Http/Controllers/Customer/BookingController.php:107
 * @route '/customer/bookings/{booking}'
 */
update.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return update.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\BookingController::update
 * @see app/Http/Controllers/Customer/BookingController.php:107
 * @route '/customer/bookings/{booking}'
 */
update.put = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})
/**
* @see \App\Http\Controllers\Customer\BookingController::update
 * @see app/Http/Controllers/Customer/BookingController.php:107
 * @route '/customer/bookings/{booking}'
 */
update.patch = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'patch'> => ({
    url: update.url(args, options),
    method: 'patch',
})

    /**
* @see \App\Http\Controllers\Customer\BookingController::update
 * @see app/Http/Controllers/Customer/BookingController.php:107
 * @route '/customer/bookings/{booking}'
 */
    const updateForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: update.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\BookingController::update
 * @see app/Http/Controllers/Customer/BookingController.php:107
 * @route '/customer/bookings/{booking}'
 */
        updateForm.put = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: update.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'PUT',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
            /**
* @see \App\Http\Controllers\Customer\BookingController::update
 * @see app/Http/Controllers/Customer/BookingController.php:107
 * @route '/customer/bookings/{booking}'
 */
        updateForm.patch = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: update.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'PATCH',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    update.form = updateForm
/**
* @see \App\Http\Controllers\Customer\BookingController::destroy
 * @see app/Http/Controllers/Customer/BookingController.php:136
 * @route '/customer/bookings/{booking}'
 */
export const destroy = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

destroy.definition = {
    methods: ["delete"],
    url: '/customer/bookings/{booking}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\Customer\BookingController::destroy
 * @see app/Http/Controllers/Customer/BookingController.php:136
 * @route '/customer/bookings/{booking}'
 */
destroy.url = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
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

    return destroy.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\Customer\BookingController::destroy
 * @see app/Http/Controllers/Customer/BookingController.php:136
 * @route '/customer/bookings/{booking}'
 */
destroy.delete = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\Customer\BookingController::destroy
 * @see app/Http/Controllers/Customer/BookingController.php:136
 * @route '/customer/bookings/{booking}'
 */
    const destroyForm = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroy.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\Customer\BookingController::destroy
 * @see app/Http/Controllers/Customer/BookingController.php:136
 * @route '/customer/bookings/{booking}'
 */
        destroyForm.delete = (args: { booking: string | number | { id: string | number } } | [booking: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: destroy.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'DELETE',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    destroy.form = destroyForm
const BookingController = { index, create, store, show, edit, update, destroy }

export default BookingController