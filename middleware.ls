lo = 'lodash'

class Middleware
  @registry = ->
    MiddlewareRegistry

  @runner ->
    lo.extend @, args

    return
      use: (middleware) ->
        @registry!register middleware

      next: ->
        nextIndex = @index++

        if @middlewares.length >= nextIndex
          nextMiddleware = @middlewares nextIndex
          nextMiddleware.run @
        else
          @doneFun!