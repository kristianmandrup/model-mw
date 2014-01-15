# Model Middleware

Mode middleware

## Goal

Should hook together all the middleware required to:

* save a model to the server
* read a model from the server

## Dependencies

Should be setup to use:

* validator-mw
* authorize-mw
* authenticate-mw

## Usage

the `index.ls` file exports the relevant API to external modules:

The `ModelRunner` is registered by default and recognized by the middleware builder.
The `Middleware` builder is passed a context object which in this case contains a 'data' entry as expected by the
 `ModelRunner` which is passed to each middleware component registered via `use`.
Each middleware component, such as 'authorize' (assigns `AuthorizeMw` already pre-registered), has a connection to the
 runner which handles running each component in succession.
When the runner is done, the `done` function is called.

```livescript
done-fun = ->
  console.log 'I'm done!'

ctx = data: users.kris, done: done-fun
model-mw = new Middleware('model', ctx)
model-mw.use('authorize').use('validation')
model-mw.run!
```

Model middleware:

```livescript
new Middleware('model').use(authorize-mw, validation-mw)
```

This should return a factory class which for each Middleware component, adds Runner.


