_ = require "lodash"
type = require "../type"


module.exports = (attributes) ->
  throw "Must be an object, was: #{attributes}" unless type(attributes) == 'object'

  _.extend
    name: ''
  , attributes
