rek           = require 'rekuire'
requires      = rek 'requires'

middleware    = require 'middleware'

requires.test 'test_setup'

Middleware    = require('middleware').Middleware

ModelRunner   = requires.runner 'model_runner'
ModelMw       = requires.mw     'model_mw'
User          = requires.model  'user'

class BasicMw extends ModelMw
  (@context) ->
    super ...

  abort: ->
    @runner.abort = true
    @runner.aborted-by @@

  error: (msg) ->
    @runner.error msg


class AuthorizeMw extends ModelMw
  (@context) ->
    super ...
    @user = @context.user

  # TODO: abort and/or enable easy addition of error
  run: ->
    if @user? then true else false

class ValidateMw extends ModelMw
  (@context) ->
    super ...

  run: ->
    return false if @runner.has-errors!
    true

class Project
  (@name) ->

describe 'Middleware using model-mw components' ->
  user = (name) ->
    new User name

  project = (title) ->
    new Project title: title

  model-middleware = (ctx) ->
    new Middleware 'model', ctx

  runner = (ctx) ->
    new ModelRunner ctx

  model-mw = (runner) ->
    new ModelMw runner: runner

  authorizer = ->
    new AuthorizeMw

  validator = ->
    new ValidateMw

  users       = {}
  projects    = {}
  runners     = {}
  mw          = {}
  middlewares = {}

  context 'with Authorizer and Validator' ->
    before ->
      Middleware.register model: ModelRunner

      projects.simple   := project 'simple'
      middlewares.model := model-middleware data: projects.simple

      # TODO: use - should take class name also!?
      middlewares.model.use(authorizer: authorizer!, validator: validator!)

    describe 'run with User kris' ->
      var run-result, results

      before ->
        users.kris  := user 'kris'
        run-result  := middlewares.model.run(users.kris)
        results     := middlewares.model.results!
        # console.log results

      describe 'runner results' ->
        specify 'Authorizer result is true' ->
          results['authorizer'].should.be.false

        specify 'Validator result is true' ->
          results['validator'].should.be.true

      describe 'run result' ->
        specify 'success is true' ->
          run-result.success.should.be.true
