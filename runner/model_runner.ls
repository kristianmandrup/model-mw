rek         = require 'rekuire'
requires    = rek 'requires'

_           = require 'prelude-ls'
lo          = require 'lodash'

middleware  = require 'middleware'

Debugger    = requires.file 'debugger'
Container   = requires.file 'model_container'
BaseRunner  = middleware.Runner.base

module.exports = class ModelRunner extends BaseRunner implements Container, Debugger

  # the data is the data to be run through the middleware
  # if the data is a LiveScript class, we can get the model name from the constructor display-name
  # otherwise we can get it from model
  # collection is the pluralized model name
  (@context) ->
    # index of current middle-ware running
    super ...

    @set-data-ctx @context

