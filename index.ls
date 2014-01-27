rek           = require 'rekuire'
requires      = rek 'requires'
Middleware    = require('middleware').Middleware
ModelRunner   = requires.file 'runner/model_runner'
ModelMw       = requires.file 'mw/model_mw'
module.exports =
  mw:       ModelMw
  runner:   ModelRunner

Middleware.register model: ModelRunner