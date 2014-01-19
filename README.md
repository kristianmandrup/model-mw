# Model Middleware

Middleware for operating on models. This is useful for such common middleware tasks as
authorizing a user for performing specific operations on a model and for validating changes/updated to a model.

## Usage

the `index.ls` file exports the relevant API to external modules (see `index_test-ls` for examples of usage).

```livescript
model-mw      = require 'model-mw'
ModelMw       = model-mw.mw
ModelRunner   = model-mw.runner
```

It is recommended to regiter the `ModelRunner` on the `Middleware` builder for easy use.

```livescript
Middleware.register 'model', ModelRunner
```

The `Middleware` builder is passed a context object which in this case contains a 'data' entry as expected by the
 `ModelRunner` which is passed to each middleware component registered via `use`.

Each middleware component, such as 'authorize' (assigns `AuthorizeMw` already pre-registered), has a connection to the
 runner which handles running each component in succession and collecting the results.

When the runner is done, the `on-success` (or on-error if errors) function is called.
Any Mw-component always has access to the runner, and can f.ex use `has-errors` or similar for decisions in its `run` method,
 such as whether it should abort etc. (TODO: make "abortion" simpler).

```livescript
done-fun = ->
  console.log 'I'm done!'

ctx = data: users.kris, on-success: done-fun
model-mw = new Middleware('model', ctx)
model-mw.use(authorize-mw).use(validation-mw)
model-mw.run!
```

## TODO

Model middleware:

Yet to be implemented to be flexible like this

```livescript
new Middleware('model').use(authorize-mw, validation-mw)
```

This should return a factory class which for each Middleware component, adds Runner.
