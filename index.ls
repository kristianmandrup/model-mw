requires      = require './requires'

ModelRunner   = requires.file 'runner/model_runner'
ModelMw       = requires.file 'mw/model_mw'

module.exports =
  mw:       ModelMw
  runner:   ModelRunner

Middleware    = require('middleware').Middleware

Middleware.register model: ModelRunner