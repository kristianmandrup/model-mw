rek         = require 'rekuire'
requires    = rek 'requires'

_           = require 'prelude-ls'
lo          = require 'lodash'
inflection  = require 'inflection'
middleware  = require 'middleware'

Debugger    = requires.file 'debugger'
BaseRunner  = middleware.runner.base

module.exports = class ModelRunner extends BaseRunner implements Debugger

  # the data is the data to be run through the middleware
  # if the data is a LiveScript class, we can get the model name from the constructor display-name
  # otherwise we can get it from model
  # collection is the pluralized model name
  (context) ->
    # index of current middle-ware running
    super ...

    @debug 'context', context

    data = context['data']
    model = context['model']

    model-data = "model: #{model}, data: #{data}"

    unless data? or model?
      throw Error "Missing data in arguments"

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

    @model = inflection.singularize model-name.toLowerCase!

    unless @model
      throw Error "Model could not be determined from: #{model-data}"

    @collection = inflection.pluralize @model

    @debug "Collection", @collection
