# Model Middleware

Mode middleware

## Goal

Should hook together all the middleware required to:

 * save a model to the server/DB
 * read a model from the server DB and expose it to the client (fx Angular or similar UI framework)

 ## Dependencies

Should be setup to use:

validator-mw, authorize-mw and perhaps later authenticate-mw

## Usage

the `index.ls` file exports the relevant API to external modules:

Here is an example of how to use the middleware from an external module:

```livescript
model-mw    = require 'model-mw'
ModelMw     = model-mw.mw
ModelRunner = model-mw.runner

model_mw  = new ModelMw

runner    = new ModelRunner(context).run
```

## TODO

Add validator-mw, authorize-mw etc. as described on Gist (also see model_config) in middleware project.
Should be something similar (but not exactly - is just pseudo code/thoughts for now).

