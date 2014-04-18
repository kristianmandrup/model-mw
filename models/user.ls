requires     = require '../requires'

_           = require "prelude-ls"

Model       = requires.lib "model"

module.exports = class User extends Model
  (@name) ->
