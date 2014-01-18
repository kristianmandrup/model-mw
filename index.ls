rek           = require 'rekuire'
requires      = rek 'requires'

module.exports =
  mw:       requires.file 'mw/model_mw'
  runner:   requires.file 'runner/model_runner'
