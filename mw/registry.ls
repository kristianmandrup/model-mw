_ = require 'prelude-ls'

class MiddlewareRegistry
  @middlewares = []

  @get = (name) ->
    @@middlewares[name]

  @register = (middleware) ->
    if _.is-type('Object', middleware) and middleware.run
      @@middlewares.push middleware