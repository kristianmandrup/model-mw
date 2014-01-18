rek         = require 'rekuire'
requires    = rek 'requires'

middleware  = require 'middleware'
BaseMw      = middleware.mw.base
Debugger    = requires.file 'debugger'

module.exports = class ModelMw extends BaseMw implements Debugger
  (@context) ->
    super ...

    @runner = @context.runner

    unless @runner
      throw Error "Context must have a runner, was: #{@runner}"

    unless @runner.data?
      throw Error "Runner must have a model, was: #{@data}"

    unless @runner.model?
      throw Error "Runner must have a model, was: #{@runner}"

    unless @runner.collection?
      throw Error "Runner must have a collection"

    @collection = @runner.collection
    @model      = @runner.model
    @data       = @runner.data
