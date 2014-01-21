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
  (@context) ->
    # index of current middle-ware running
    super ...

    @debug 'context', context

    @set-data!
    @set-model!
    @set-collection!
    @validate!

  set-data: ->
    @data = @context['data'] or {}

  set-model: ->
    @model = @context['model']
    if @model is undefined
      if _.is-type('Object', @data) and @data.constructor?
        if @data.constructor.display-name?
          @model = @data.constructor.display-name
        else
          @error = "data objecy constructor has no displayName function (not a LiveScript class)"

    unless _.is-type 'String', @model
      throw Error "model must be a String or class instance - #{@model-data!}"

    @model = inflection.singularize @model.toLowerCase!

  set-collection: ->
    @collection = inflection.pluralize @model

    @debug "Collection", @collection

  validate: ->
    unless @model?
      throw Error "Model could not be determined from context #{@context}, #{@model-data!}"

  error: ''
  model-data: ->
    "model: #{@model}, data: #{@data}, " + @error
