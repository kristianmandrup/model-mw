rek           = require 'rekuire'
requires      = rek 'requires'

middleware    = require 'middleware'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

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

  run: (mode) ->
    super mode
    if @model? then true else false

class ValidateMw extends ModelMw
  (@context) ->
    super ...

  run: (mode) ->
    super mode
    return false if @runner.has-errors!
    true

class PromiseValidMw extends ModelMw
  (@context) ->
    super ...

  run: (mode) ->
    @result = true
    void

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

  promise-mw = (runner) ->
    new PromiseValidMw runner: runner

  promiser = ->
    new PromiseValidMw

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
    var auth-mw

    before ->
      Middleware.register model: ModelRunner

      projects.simple   := project 'simple'
      middlewares.model := model-middleware data: projects.simple

      users.kris        := user 'kris'

      middlewares.user := model-middleware data: users.kris

      auth-mw := authorizer!
      # auth-mw.debug-on!

      middlewares.model.use(authorizer: auth-mw, validator: validator!)

    context 'project model middleware' ->
      describe 'run with User kris' ->
        var run-result, results

        before ->
          users.kris  := user 'kris'
          run-result  := middlewares.model.run(users.kris)
          results     := middlewares.model.results!
          # console.log results

        describe 'runner results' ->
          specify 'Authorizer result is true' ->
            results['authorizer'].should.be.true

          specify 'Validator result is true' ->
            results['validator'].should.be.true

        describe 'run result' ->
          specify 'success is true' ->
            run-result.success.should.be.true

      describe 'run using runner model' ->
        var run-result, results

        before ->
          run-result  := middlewares.model.run!
          results     := middlewares.model.results!
          # console.log results

        describe 'runner results' ->
          specify 'Authorizer result is true' ->
            results['authorizer'].should.be.true

          specify 'Validator result is true' ->
            results['validator'].should.be.true

        describe 'run result' ->
          specify 'success is true' ->
            run-result.success.should.be.true

    describe 'run with promiser' ->
      var run-result, results

      context 'user middleware' ->
        before ->
          middlewares.user.use(promiser: promiser!, validator: validator!)

          run-result  := middlewares.user.run!
          results     := middlewares.user.results!
          # console.log results

        describe 'runner results' ->
          specify 'Authorizer result is true' ->
            results['promiser'].should.be.true

          specify 'Validator result is true' ->
            results['validator'].should.be.true

        describe 'run result' ->
          specify 'success is true' ->
            run-result.success.should.be.true
