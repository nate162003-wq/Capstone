import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::index
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:12
 * @route '/business-owner/packages'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/business-owner/packages',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::index
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:12
 * @route '/business-owner/packages'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::index
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:12
 * @route '/business-owner/packages'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::index
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:12
 * @route '/business-owner/packages'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::index
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:12
 * @route '/business-owner/packages'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::index
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:12
 * @route '/business-owner/packages'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::index
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:12
 * @route '/business-owner/packages'
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
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::create
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:23
 * @route '/business-owner/packages/create'
 */
export const create = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})

create.definition = {
    methods: ["get","head"],
    url: '/business-owner/packages/create',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::create
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:23
 * @route '/business-owner/packages/create'
 */
create.url = (options?: RouteQueryOptions) => {
    return create.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::create
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:23
 * @route '/business-owner/packages/create'
 */
create.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::create
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:23
 * @route '/business-owner/packages/create'
 */
create.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: create.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::create
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:23
 * @route '/business-owner/packages/create'
 */
    const createForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: create.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::create
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:23
 * @route '/business-owner/packages/create'
 */
        createForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::create
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:23
 * @route '/business-owner/packages/create'
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
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::store
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:28
 * @route '/business-owner/packages'
 */
export const store = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/business-owner/packages',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::store
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:28
 * @route '/business-owner/packages'
 */
store.url = (options?: RouteQueryOptions) => {
    return store.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::store
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:28
 * @route '/business-owner/packages'
 */
store.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::store
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:28
 * @route '/business-owner/packages'
 */
    const storeForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::store
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:28
 * @route '/business-owner/packages'
 */
        storeForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(options),
            method: 'post',
        })
    
    store.form = storeForm
/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::show
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:47
 * @route '/business-owner/packages/{package}'
 */
export const show = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})

show.definition = {
    methods: ["get","head"],
    url: '/business-owner/packages/{package}',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::show
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:47
 * @route '/business-owner/packages/{package}'
 */
show.url = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { package: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { package: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    package: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        package: typeof args.package === 'object'
                ? args.package.id
                : args.package,
                }

    return show.definition.url
            .replace('{package}', parsedArgs.package.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::show
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:47
 * @route '/business-owner/packages/{package}'
 */
show.get = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: show.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::show
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:47
 * @route '/business-owner/packages/{package}'
 */
show.head = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: show.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::show
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:47
 * @route '/business-owner/packages/{package}'
 */
    const showForm = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: show.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::show
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:47
 * @route '/business-owner/packages/{package}'
 */
        showForm.get = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: show.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::show
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:47
 * @route '/business-owner/packages/{package}'
 */
        showForm.head = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:56
 * @route '/business-owner/packages/{package}/edit'
 */
export const edit = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})

edit.definition = {
    methods: ["get","head"],
    url: '/business-owner/packages/{package}/edit',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:56
 * @route '/business-owner/packages/{package}/edit'
 */
edit.url = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { package: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { package: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    package: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        package: typeof args.package === 'object'
                ? args.package.id
                : args.package,
                }

    return edit.definition.url
            .replace('{package}', parsedArgs.package.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:56
 * @route '/business-owner/packages/{package}/edit'
 */
edit.get = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:56
 * @route '/business-owner/packages/{package}/edit'
 */
edit.head = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: edit.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:56
 * @route '/business-owner/packages/{package}/edit'
 */
    const editForm = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: edit.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:56
 * @route '/business-owner/packages/{package}/edit'
 */
        editForm.get = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: edit.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::edit
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:56
 * @route '/business-owner/packages/{package}/edit'
 */
        editForm.head = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::update
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:63
 * @route '/business-owner/packages/{package}'
 */
export const update = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})

update.definition = {
    methods: ["put"],
    url: '/business-owner/packages/{package}',
} satisfies RouteDefinition<["put"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::update
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:63
 * @route '/business-owner/packages/{package}'
 */
update.url = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { package: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { package: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    package: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        package: typeof args.package === 'object'
                ? args.package.id
                : args.package,
                }

    return update.definition.url
            .replace('{package}', parsedArgs.package.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::update
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:63
 * @route '/business-owner/packages/{package}'
 */
update.put = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::update
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:63
 * @route '/business-owner/packages/{package}'
 */
    const updateForm = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: update.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::update
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:63
 * @route '/business-owner/packages/{package}'
 */
        updateForm.put = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:82
 * @route '/business-owner/packages/{package}'
 */
export const destroy = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

destroy.definition = {
    methods: ["delete"],
    url: '/business-owner/packages/{package}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:82
 * @route '/business-owner/packages/{package}'
 */
destroy.url = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { package: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { package: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    package: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        package: typeof args.package === 'object'
                ? args.package.id
                : args.package,
                }

    return destroy.definition.url
            .replace('{package}', parsedArgs.package.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:82
 * @route '/business-owner/packages/{package}'
 */
destroy.delete = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:82
 * @route '/business-owner/packages/{package}'
 */
    const destroyForm = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroy.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::destroy
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:82
 * @route '/business-owner/packages/{package}'
 */
        destroyForm.delete = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:95
 * @route '/business-owner/packages/{package}/toggle-status'
 */
export const toggleStatus = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleStatus.url(args, options),
    method: 'post',
})

toggleStatus.definition = {
    methods: ["post"],
    url: '/business-owner/packages/{package}/toggle-status',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:95
 * @route '/business-owner/packages/{package}/toggle-status'
 */
toggleStatus.url = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { package: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { package: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    package: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        package: typeof args.package === 'object'
                ? args.package.id
                : args.package,
                }

    return toggleStatus.definition.url
            .replace('{package}', parsedArgs.package.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:95
 * @route '/business-owner/packages/{package}/toggle-status'
 */
toggleStatus.post = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleStatus.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:95
 * @route '/business-owner/packages/{package}/toggle-status'
 */
    const toggleStatusForm = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: toggleStatus.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\PackageManagementController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/PackageManagementController.php:95
 * @route '/business-owner/packages/{package}/toggle-status'
 */
        toggleStatusForm.post = (args: { package: string | number | { id: string | number } } | [packageParam: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: toggleStatus.url(args, options),
            method: 'post',
        })
    
    toggleStatus.form = toggleStatusForm
const PackageManagementController = { index, create, store, show, edit, update, destroy, toggleStatus }

export default PackageManagementController