Base = require './base_mw'

class ModelMw extends Base
  constructor: (name) ->
    super

  name: 'simple'
  run: (context) ->
    @context = context
    @runner = context.runner
    @collection = @runner.collection
    @model = @runner.model
    @data = @runner.data

    console.log "#{@name} middleware is being run with:", @runner.name

console.log "Mw Model", ModelMw

module.exports = ModelMw



