rek           = require 'rekuire'
requires      = rek 'requires'

middleware    = require 'middleware'

requires.test 'test_setup'

ModelRunner   = requires.runner 'model_runner'
ModelMw       = requires.mw     'model_mw'
User          = requires.model  'user'

describe 'model runner' ->
  var ctx

  user = (name) ->
    new User name

  runner = (context) ->
    new ModelRunner context

  model-mw = (runner) ->
    new ModelMw runner: runner

  users     = {}
  runners   = {}
  mw        = {}

  context 'user runner middleware with data: User kris' ->
    before ->
      users.kris    := user 'kris'
      ctx           := data: users.kris
      runners.user  := runner ctx
      mw.user       := model-mw runners.user

      # runners.user.debug-on!
      # mw.user.debug-on!

    describe 'data' ->
      specify 'should be: User kris' ->
        runners.user.data.should.be.eql users.kris

    describe 'model' ->
      specify 'should be: user' ->
        runners.user.model.should.be.eql 'user'

    describe 'collection' ->
      specify 'should be: users' ->
        runners.user.collection.should.be.eql 'users'