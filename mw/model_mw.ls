rek      = require 'rekuire'
requires = rek 'requires'

middleware  = require 'middleware'
BaseMw      = middleware.mw.base
Debugger    = requires.file 'debugger'

module.exports = class ModelMw extends BaseMw implements Debugger
  (context) ->
    super context

    @context = context

    unless @context.runner?
      throw Error "Context must have a runner"

    @runner = @context.runner

    unless @runner.collection?
      throw Error "Runner must have a collection"

    @collection = @runner.collection
    @model = @runner.model
    @data = @runner.data
