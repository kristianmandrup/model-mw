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

Here is an example of how to use the middleware from an external module:

```livescript
model-mw    = require 'model-mw'
ModelMw     = model-mw.mw
ModelRunner = model-mw.runner

runner    = new ModelRunner(context).run
```

