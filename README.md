# Model Middleware

[![Greenkeeper badge](https://badges.greenkeeper.io/kristianmandrup/model-mw.svg)](https://greenkeeper.io/)

Middleware for operating on models. This is useful for such common middleware tasks as
authorizing a user for performing specific operations on a model and for validating changes/updated to a model.

## Usage

the `index.ls` file exports the relevant API to external modules (see `index_test-ls` for examples of usage).

```livescript
model-mw      = require 'model-mw'
ModelMw       = model-mw.mw
ModelRunner   = model-mw.runner
```

The runner `ModelRunner` is registered on `Middleware` for easy use (by name).

```livescript
Middleware.register model: ModelRunner
```

Any runner registered in this fashion can be configured for use by name like this:

```livescript
middleware = new Middleware('model')
```

## Passing runner data

```livescript
middleware = new Middleware('model', data: users.kris)
```

The `Middleware` builder is passed a context object which in this case contains a 'data' entry as expected by the
 `ModelRunner`. This data  is then passed on to each middleware component registered via `use`.

```livescript
middleware = new Middleware('model', data: users.kris).use(validator: validation-mw)
```

Each middleware component has a connection to the middleware runner which handles running each component in succession.
 After each component completes the result is collected on the results of the runner.

When the runner is done, the `on-success` function is normally called. If one or more errors occured, the `on-error` function is called.

Any mw-component always has access to the runner, and can f.ex use `has-errors` or similar for decisions in its `run` method,
 such as whether it should abort etc. (see specs for more detailed API)

Example:

```livescript
done-fun = ->
  console.log 'I'm done!', @success, @results

my-error-fun = ->
  throw Error 'Oops! Errors:', @errors

ctx = data: users.kris, on-success: done-fun, on-error: my-error-fun
model-mw = new Middleware('model', ctx)
model-mw.use(authorize-mw).use(validation-mw)
model-mw.run!
```

You can also set `model` and/or `collection` as part of the context.

The runner will try to determine the model and collection based on the data if `model` or `collection` are not passed as arguments.
Model will always be a singular, underscored entity, such as: `project` or `admin_user`. Collection is pluralised by the same rule: `admin_users`.

If the data is a LiveScript class, the model will be determined by name of the constructor. Otherwise it will try to find
a `clazz` entry on any Object passed as data (see model_container_test` for more).

## Abort or Error

An Mw-component can issue `abort!` to abort the current runner from executing any more mw-components.
You can also use `error(msg)` to add an error to the runner and
ensure that `on-error` will be called when the runner completes. By default `on-error` returns the `errors` object.

## Running alone

An mw-component can be run "alone" (i.e. without a runner), by calling its run method with the mode `'alone'`.

```livescript
mw-alone.run mode: 'alone', data: users.kris
```

This can be useful for testing an mw-component stand-alone.

## Detailed API

For a more detailed understanding of the internals, please see the specs ;)

## Related projects

Please see:

* middleware
* authorization-mw
* validation-mw

## TODO

The current model runner is very simple and only supports running every Mw-component in synchronous mode.
This is far from optimal! There should be more advanced runners available from the *middleware* project that
 support Mw-components that return promises and also one that can run one or more
 Mw-components asynchronously and wait until they all deliver their results etc.

Please help out with this effort ;) The async runners should support both *Q* and *RSVP*, by allowing configuration
 of `defer` function (same as *LGTM* validator approach).

## Testing

Using *mocha*

Run all test

`$ mocha`

Run particular test

`$ mocha test/model-mw/mw/model_flow_test.js`

Easy :)

## Contribution

Please suggest improvements and help improve this project :)