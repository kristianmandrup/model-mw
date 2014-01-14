rek         = require 'rekuire'
requires    = rek 'requires'

_           = require 'prelude-ls'
lo          = require 'lodash'
inflection  = require 'inflection'
middleware  = require 'middleware'

Debugger    = requires.file 'debugger'
BaseRunner  = middleware.runner.base

module.exports = class ModelRunner extends BaseRunner implements Debugger
  (args) ->
    # index of current middle-ware running
    super ...

    argsObj = arguments[0]

    data = argsObj['data']
    model = argsObj['model']

    model-data = "model: #{model}, data: #{data}"

    unless data? or model?
      throw Error "Missing data in arguments"

    @debug 'argsObj', argsObj

    @data = data || {}

    var model-name

    if _.is-type('Object', @data) and @data.constructor
      model-name = @data.constructor.displayName

    # if not set by instance constructor, assume model is name of class
    model-name ||= model

    unless _.is-type 'String', model-name
      @debug "data", @data
      @debug "model", @model
      throw Error "model must be a String or class instance - #{model-data}"

    @model = model-name.toLowerCase!

    unless @model
      throw Error "Missing model for: #{model-data}"

    @collection = inflection.pluralize @model

    @debug "Collection", @collection
