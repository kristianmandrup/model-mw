rek         = require 'rekuire'
requires    = rek 'requires'
_           = require 'prelude-ls'
inflection  = require 'inflection'
lo          = require 'lodash'
middleware  = require 'middleware'

Debugger    = requires.file 'debugger'
BaseRunner  = middleware.runner.base

module.exports = class ModelRunner extends BaseRunner implements Debugger
    (args) ->
      # index of current middle-ware running
      super ...

      argsObj = arguments[0]

      throw Error "Missing data in arguments" unless argsObj['data']

      console.log 'this', @

      @debug 'argsObj', argsObj

      @data = argsObj['data'] || {}

      model = argsObj['model'] || @data.constructor.displayName

      unless _.is-type 'String', model
        @debug "data", @data
        @debug "model", @model
        throw Error "model must be a String, was: #{model}"

      @model = model.toLowerCase!

      throw Error "Missing model for: #{data}" unless @model

      @collection = inflection.pluralize @model

      console.log "Collection", @collection

    name: 'model'