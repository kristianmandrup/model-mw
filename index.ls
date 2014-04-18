requires      = require './requires'

ModelRunner   = requires.lib 'runner/model_runner'
ModelMw       = requires.lib 'mw/model_mw'

module.exports =
  mw:       ModelMw
  runner:   ModelRunner

Middleware    = require('middleware').Middleware

Middleware.register model: ModelRunner