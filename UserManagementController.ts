import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::index
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:13
 * @route '/business-owner/users'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/business-owner/users',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::index
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:13
 * @route '/business-owner/users'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::index
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:13
 * @route '/business-owner/users'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::index
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:13
 * @route '/business-owner/users'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::index
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:13
 * @route '/business-owner/users'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::index
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:13
 * @route '/business-owner/users'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::index
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:13
 * @route '/business-owner/users'
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
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::create
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:40
 * @route '/business-owner/users/create'
 */
export const create = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})

create.definition = {
    methods: ["get","head"],
    url: '/business-owner/users/create',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::create
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:40
 * @route '/business-owner/users/create'
 */
create.url = (options?: RouteQueryOptions) => {
    return create.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::create
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:40
 * @route '/business-owner/users/create'
 */
create.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::create
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:40
 * @route '/business-owner/users/create'
 */
create.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: create.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::create
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:40
 * @route '/business-owner/users/create'
 */
    const createForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: create.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::create
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:40
 * @route '/business-owner/users/create'
 */
        createForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::create
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:40
 * @route '/business-owner/users/create'
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
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::store
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:45
 * @route '/business-owner/users'
 */
export const store = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/business-owner/users',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::store
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:45
 * @route '/business-owner/users'
 */
store.url = (options?: RouteQueryOptions) => {
    return store.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::store
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:45
 * @route '/business-owner/users'
 */
store.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::store
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:45
 * @route '/business-owner/users'
 */
    const storeForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::store
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:45
 * @route '/business-owner/users'
 */
        storeForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(options),
            method: 'post',
        })
    
    store.form = storeForm
/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::show
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:65
 * @route '/business-owner/users/{user}'
 */
export const show = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/business-owner/users/{user}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::show
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:65
 * @route '/business-owner/users/{user}'
 */
show.url = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { user: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { user: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    user: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        user: typeof args.user === 'object'
                ? args.user.id
                : args.user,
                }

    return show.definition.url
            .replace('{user}', parsedArgs.user.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::show
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:65
 * @route '/business-owner/users/{user}'
 */
show.get = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::show
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:65
 * @route '/business-owner/users/{user}'
 */
show.head = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::show
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:65
 * @route '/business-owner/users/{user}'
 */
    const showForm = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::show
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:65
 * @route '/business-owner/users/{user}'
 */
        showForm.get = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::show
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:65
 * @route '/business-owner/users/{user}'
 */
        showForm.head = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:74
 * @route '/business-owner/users/{user}/edit'
 */
export const edit = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})

edit.definition = {
    methods: ["get","head"],
    url: '/business-owner/users/{user}/edit',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:74
 * @route '/business-owner/users/{user}/edit'
 */
edit.url = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { user: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { user: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    user: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        user: typeof args.user === 'object'
                ? args.user.id
                : args.user,
                }

    return edit.definition.url
            .replace('{user}', parsedArgs.user.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:74
 * @route '/business-owner/users/{user}/edit'
 */
edit.get = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:74
 * @route '/business-owner/users/{user}/edit'
 */
edit.head = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: edit.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:74
 * @route '/business-owner/users/{user}/edit'
 */
    const editForm = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: edit.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:74
 * @route '/business-owner/users/{user}/edit'
 */
        editForm.get = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: edit.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:74
 * @route '/business-owner/users/{user}/edit'
 */
        editForm.head = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::update
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:81
 * @route '/business-owner/users/{user}'
 */
export const update = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})

update.definition = {
    methods: ["put"],
    url: '/business-owner/users/{user}',
} satisfies RouteDefinition<["put"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::update
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:81
 * @route '/business-owner/users/{user}'
 */
update.url = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { user: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { user: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    user: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        user: typeof args.user === 'object'
                ? args.user.id
                : args.user,
                }

    return update.definition.url
            .replace('{user}', parsedArgs.user.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::update
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:81
 * @route '/business-owner/users/{user}'
 */
update.put = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::update
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:81
 * @route '/business-owner/users/{user}'
 */
    const updateForm = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: update.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::update
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:81
 * @route '/business-owner/users/{user}'
 */
        updateForm.put = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: update.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'PUT',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    update.form = updateForm
/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:99
 * @route '/business-owner/users/{user}'
 */
export const destroy = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

destroy.definition = {
    methods: ["delete"],
    url: '/business-owner/users/{user}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:99
 * @route '/business-owner/users/{user}'
 */
destroy.url = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { user: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { user: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    user: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        user: typeof args.user === 'object'
                ? args.user.id
                : args.user,
                }

    return destroy.definition.url
            .replace('{user}', parsedArgs.user.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:99
 * @route '/business-owner/users/{user}'
 */
destroy.delete = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:99
 * @route '/business-owner/users/{user}'
 */
    const destroyForm = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroy.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:99
 * @route '/business-owner/users/{user}'
 */
        destroyForm.delete = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:111
 * @route '/business-owner/users/{user}/toggle-status'
 */
export const toggleStatus = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleStatus.url(args, options),
    method: 'post',
})

toggleStatus.definition = {
    methods: ["post"],
    url: '/business-owner/users/{user}/toggle-status',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:111
 * @route '/business-owner/users/{user}/toggle-status'
 */
toggleStatus.url = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { user: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { user: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    user: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        user: typeof args.user === 'object'
                ? args.user.id
                : args.user,
                }

    return toggleStatus.definition.url
            .replace('{user}', parsedArgs.user.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:111
 * @route '/business-owner/users/{user}/toggle-status'
 */
toggleStatus.post = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleStatus.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:111
 * @route '/business-owner/users/{user}/toggle-status'
 */
    const toggleStatusForm = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: toggleStatus.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\UserManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/UserManagementController.php:111
 * @route '/business-owner/users/{user}/toggle-status'
 */
        toggleStatusForm.post = (args: { user: string | number | { id: string | number } } | [user: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: toggleStatus.url(args, options),
            method: 'post',
        })
    
    toggleStatus.form = toggleStatusForm
const UserManagementController = { index, create, store, show, edit, update, destroy, toggleStatus }

export default UserManagementController