middleware = require 'middleware'

BaseRunner = middleware.runner.base

inflection = require 'inflection'
_          = require 'lodash'

module.exports = class ModelRunner extends BaseRunner
    (args) ->
      # index of current middle-ware running
      super ...

      argsObj = arguments[0]

      throw Error "Missing data in arguments" unless argsObj['data']

      @data = argsObj['data'] || {}
      model = argsObj['model'] || @data.constructor.displayName
      @model = model.toLowerCase!

      throw Error "Missing model for: #{data}" unless @model

      @collection = inflection.pluralize @model

      console.log "Collection", @collection

    name: 'model'