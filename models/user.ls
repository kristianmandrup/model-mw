rek         = require 'rekuire'
requires    = rek 'requires'

_           = require "prelude-ls"

Model       = requires.file "model"

module.exports = class User extends Model
  (@name) ->
