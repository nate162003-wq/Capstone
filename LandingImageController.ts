import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../../wayfinder'
/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::index
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:12
 * @route '/business-owner/landing-images'
 */
export const index = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})

index.definition = {
    methods: ["get","head"],
    url: '/business-owner/landing-images',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::index
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:12
 * @route '/business-owner/landing-images'
 */
index.url = (options?: RouteQueryOptions) => {
    return index.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::index
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:12
 * @route '/business-owner/landing-images'
 */
index.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: index.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::index
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:12
 * @route '/business-owner/landing-images'
 */
index.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: index.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::index
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:12
 * @route '/business-owner/landing-images'
 */
    const indexForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: index.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::index
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:12
 * @route '/business-owner/landing-images'
 */
        indexForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: index.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::index
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:12
 * @route '/business-owner/landing-images'
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
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::create
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:36
 * @route '/business-owner/landing-images/create'
 */
export const create = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})

create.definition = {
    methods: ["get","head"],
    url: '/business-owner/landing-images/create',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::create
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:36
 * @route '/business-owner/landing-images/create'
 */
create.url = (options?: RouteQueryOptions) => {
    return create.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::create
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:36
 * @route '/business-owner/landing-images/create'
 */
create.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: create.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::create
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:36
 * @route '/business-owner/landing-images/create'
 */
create.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: create.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::create
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:36
 * @route '/business-owner/landing-images/create'
 */
    const createForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: create.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::create
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:36
 * @route '/business-owner/landing-images/create'
 */
        createForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: create.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::create
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:36
 * @route '/business-owner/landing-images/create'
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
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::store
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:41
 * @route '/business-owner/landing-images'
 */
export const store = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/business-owner/landing-images',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::store
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:41
 * @route '/business-owner/landing-images'
 */
store.url = (options?: RouteQueryOptions) => {
    return store.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::store
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:41
 * @route '/business-owner/landing-images'
 */
store.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::store
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:41
 * @route '/business-owner/landing-images'
 */
    const storeForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::store
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:41
 * @route '/business-owner/landing-images'
 */
        storeForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(options),
            method: 'post',
        })
    
    store.form = storeForm
/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::edit
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:59
 * @route '/business-owner/landing-images/{landingImage}/edit'
 */
export const edit = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})

edit.definition = {
    methods: ["get","head"],
    url: '/business-owner/landing-images/{landingImage}/edit',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::edit
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:59
 * @route '/business-owner/landing-images/{landingImage}/edit'
 */
edit.url = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { landingImage: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { landingImage: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    landingImage: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        landingImage: typeof args.landingImage === 'object'
                ? args.landingImage.id
                : args.landingImage,
                }

    return edit.definition.url
            .replace('{landingImage}', parsedArgs.landingImage.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::edit
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:59
 * @route '/business-owner/landing-images/{landingImage}/edit'
 */
edit.get = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: edit.url(args, options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::edit
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:59
 * @route '/business-owner/landing-images/{landingImage}/edit'
 */
edit.head = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: edit.url(args, options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::edit
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:59
 * @route '/business-owner/landing-images/{landingImage}/edit'
 */
    const editForm = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: edit.url(args, options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::edit
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:59
 * @route '/business-owner/landing-images/{landingImage}/edit'
 */
        editForm.get = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: edit.url(args, options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::edit
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:59
 * @route '/business-owner/landing-images/{landingImage}/edit'
 */
        editForm.head = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::update
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:66
 * @route '/business-owner/landing-images/{landingImage}'
 */
export const update = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})

update.definition = {
    methods: ["put"],
    url: '/business-owner/landing-images/{landingImage}',
} satisfies RouteDefinition<["put"]>

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::update
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:66
 * @route '/business-owner/landing-images/{landingImage}'
 */
update.url = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { landingImage: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { landingImage: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    landingImage: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        landingImage: typeof args.landingImage === 'object'
                ? args.landingImage.id
                : args.landingImage,
                }

    return update.definition.url
            .replace('{landingImage}', parsedArgs.landingImage.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::update
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:66
 * @route '/business-owner/landing-images/{landingImage}'
 */
update.put = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update.url(args, options),
    method: 'put',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::update
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:66
 * @route '/business-owner/landing-images/{landingImage}'
 */
    const updateForm = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: update.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::update
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:66
 * @route '/business-owner/landing-images/{landingImage}'
 */
        updateForm.put = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::destroy
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:84
 * @route '/business-owner/landing-images/{landingImage}'
 */
export const destroy = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

destroy.definition = {
    methods: ["delete"],
    url: '/business-owner/landing-images/{landingImage}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::destroy
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:84
 * @route '/business-owner/landing-images/{landingImage}'
 */
destroy.url = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { landingImage: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { landingImage: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    landingImage: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        landingImage: typeof args.landingImage === 'object'
                ? args.landingImage.id
                : args.landingImage,
                }

    return destroy.definition.url
            .replace('{landingImage}', parsedArgs.landingImage.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::destroy
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:84
 * @route '/business-owner/landing-images/{landingImage}'
 */
destroy.delete = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::destroy
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:84
 * @route '/business-owner/landing-images/{landingImage}'
 */
    const destroyForm = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroy.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::destroy
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:84
 * @route '/business-owner/landing-images/{landingImage}'
 */
        destroyForm.delete = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
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
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:92
 * @route '/business-owner/landing-images/{landingImage}/toggle-status'
 */
export const toggleStatus = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleStatus.url(args, options),
    method: 'post',
})

toggleStatus.definition = {
    methods: ["post"],
    url: '/business-owner/landing-images/{landingImage}/toggle-status',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:92
 * @route '/business-owner/landing-images/{landingImage}/toggle-status'
 */
toggleStatus.url = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { landingImage: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { landingImage: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    landingImage: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        landingImage: typeof args.landingImage === 'object'
                ? args.landingImage.id
                : args.landingImage,
                }

    return toggleStatus.definition.url
            .replace('{landingImage}', parsedArgs.landingImage.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:92
 * @route '/business-owner/landing-images/{landingImage}/toggle-status'
 */
toggleStatus.post = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: toggleStatus.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:92
 * @route '/business-owner/landing-images/{landingImage}/toggle-status'
 */
    const toggleStatusForm = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: toggleStatus.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BusinessOwner\LandingImageController::toggleStatus
 * @see app/Http/Controllers/BusinessOwner/LandingImageController.php:92
 * @route '/business-owner/landing-images/{landingImage}/toggle-status'
 */
        toggleStatusForm.post = (args: { landingImage: string | number | { id: string | number } } | [landingImage: string | number | { id: string | number } ] | string | number | { id: string | number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: toggleStatus.url(args, options),
            method: 'post',
        })
    
    toggleStatus.form = toggleStatusForm
const LandingImageController = { index, create, store, edit, update, destroy, toggleStatus }

export default LandingImageController