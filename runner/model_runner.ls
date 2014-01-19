rek         = require 'rekuire'
requires    = rek 'requires'

_           = require 'prelude-ls'
lo          = require 'lodash'
inflection  = require 'inflection'

middleware  = require 'middleware'

Debugger    = requires.file 'debugger'
BaseRunner  = middleware.Runner.base

module.exports = class ModelRunner extends BaseRunner implements Debugger

  # the data is the data to be run through the middleware
  # if the data is a LiveScript class, we can get the model name from the constructor display-name
  # otherwise we can get it from model
  # collection is the pluralized model name
  (context) ->
    # index of current middle-ware running
    super ...

    @debug 'context', context

    data  = context['data']
    data ||= {}
    model = context['model']

    if model is undefined
      if _.is-type('Object', data) and data.constructor?
        if data.constructor.display-name?
          model = data.constructor.display-name
        else
          msg = "data constructor has no displayName"

    model-data = "model: #{model}, data: #{data}, " + msg

    unless model?
      console.log 'data', data
      throw Error "Missing data in arguments, #{model-data}"

    @model = model
    @data = data

    unless _.is-type 'String', model
      @debug "data", @data
      @debug "model", @model
      console.log 'ctx', context
      throw Error "model must be a String or class instance - #{model-data}"

    @model = inflection.singularize model.toLowerCase!

    unless @model
      throw Error "Model could not be determined from: #{model-data}"

    @collection = inflection.pluralize @model

    @debug "Collection", @collection
