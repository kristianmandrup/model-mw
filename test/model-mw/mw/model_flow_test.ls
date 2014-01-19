rek           = require 'rekuire'
requires      = rek 'requires'

middleware    = require 'middleware'

requires.test 'test_setup'

Middleware    = require('middleware').Middleware

ModelRunner   = requires.runner 'model_runner'
ModelMw       = requires.mw     'model_mw'
User          = requires.model  'user'

class Authorizer extends ModelMw
  (@context) ->
    super ...
    @user = @context.user

  # TODO: abort and/or enable easy addition of error
  run: ->
    if @user? then true else false

class Validator extends ModelMw
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

  users       = {}
  projects    = {}
  runners     = {}
  mw          = {}
  middlewares = {}

  context 'with Authorizer and Validator' ->
    before ->
      projects.simple   := project 'simple'
      middlewares.model := middleware data: projects.simple
      middlewares.model.use(Authorizer).use(Validator)

    describe 'run with User kris' ->
      var run-result, results

      before ->
        users.kris  := user 'kris'
        run-result  := middlewares.model.run(users.kris)
        results     := middlewares.model.results

      describe 'runner results' ->
        specify 'Authorizer result is true' ->
          results['Authorizer'].should.be.false

        specify 'Validator result is true' ->
          results['Validator'].should.be.false

      describe 'run result' ->
        specify 'result is true' ->
          run-result.should.be.true