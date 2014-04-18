_           = require 'prelude-ls'
lo          = require 'lodash'
inflection  = require 'inflection'
require 'sugar'

module.exports =
  set-data-ctx: (ctx) ->
    @debug 'set-data-ctx', ctx

    if @valid-ctx ctx
      @debug 'override and set mw data-ctx using', ctx
      @data       = ctx.data

      @collection = ctx.collection
      @model      = ctx.model

      if @model is undefined
        if _.is-type('Function', @data)
          @data = @data!

        if _.is-type('Object', @data)
          if @data.clazz?
            @debug 'set model from data clazz', @data.clazz
            @model = @data.clazz

          if @data.constructor?
            if @data.constructor.display-name?
              @debug 'set model from data', @data
              @model = @data.constructor.display-name

      if @collection and not @model
        @debug 'set model from collection', @collection
        @model = inflection.singularize @collection.underscore!

      if @model
        @model = inflection.singularize @model.underscore!

      unless @collection
        @debug 'set collection from model', @model
        @collection = inflection.pluralize @model

    else
      @debug 'invalid ctx', ctx

  valid-ctx: (ctx) ->
    if _.is-type('Object', ctx)
      return true if ctx.data? or ctx.collection? or ctx.model?
    false

  validate-data-ctx: (ctx) ->
    unless @model? || @collection?
      unless @data?
        throw Error "Must have data when no collection or model, #{@}"

    unless @model? || @collection
      throw Error "Must have a model or collection, #{@}"

  data-ctx: ->
    "data: #{@data}, model: #{@model}, collection: #{@collection}"