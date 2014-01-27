rek         = require 'rekuire'
requires    = rek 'requires'
_           = require 'prelude-ls'

middleware  = require 'middleware'
BaseMw      = middleware.Mw.base
Debugger    = requires.file 'debugger'

module.exports = class ModelMw extends BaseMw implements Debugger
  (@context) ->
    super ...
    @set-model @context

  validate-and-set: (mode) ->
    @debug 'validate-and-set', mode
    @set-model!
    @validate mode

  validate: (mode) ->
    @debug 'validate', mode
    unless @runner and mode isnt 'alone'
      throw Error "ModelMw must have a runner when running mode: #{mode}"

    unless @data?
      throw Error "ModelMw must have data"

    unless @model?
      throw Error "ModelMw must have a model"

    unless @collection?
      throw Error "ModelMw must have a collection"

  set-model: (ctx-model) ->
    @debug 'set-model', ctx-model
    unless @valid-ctx-model ctx-model
      @debug 'set to runner'
      ctx-model = @runner

      if @valid-ctx-model ctx-model
        @collection = ctx-model.collection
        @model      = ctx-model.model
        @data       = ctx-model.data

  valid-ctx-model: (ctx-model) ->
    _.is-type('Object', ctx-model) and ctx-model.collection? and ctx-model.model? and ctx-model.data?

  run: (mode) ->
    @debug 'run model-mw', mode
    @validate-and-set mode
    @data