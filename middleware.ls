lo      = 'lodash'
_       = 'prelude-ls'

ModelRunner = requires.file 'model_runner'

class Middleware
  (@context) ->
    unless _.is-type 'Object', context
      throw Error "Context must be an Object, was: #{typeof context}, #{context}"

    @runner = context.runner
    @runner ||= ModelRunner
    @index  = 0

  use: (middleware) ->
    @@registry.register middleware

  @registry = MiddlewareRegistry

  run-next-mw: (index) ->
    @middleware-list.length >= next-index

  next-index: ->
    @index ||= 0
    @index +1

  inc-index: ->
    @index ||= 0
    @index++

  run: ->
    if run-next-mw then run-next! else @done-fun!
    inc-index!

  run-next: ->
    @registry.at(next-index).run @runner