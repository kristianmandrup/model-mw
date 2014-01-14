rek         = require 'rekuire'
requires    = rek 'requires'

middleware  = require 'middleware'

Debugger    = requires.file 'debugger'
BaseMw      = middleware.mw.base

module.exports = class ModelMw extends BaseMw implements Debugger
  (context) ->
    super context

    @context = context

    throw Error "Context must have a runner" unless @context.runner?

    @runner = @context.runner

    throw Error "Runner must have a collection" unless @runner.collection?

    @collection = @runner.collection
    @model = @runner.model
    @data = @runner.data

  name: 'model'

