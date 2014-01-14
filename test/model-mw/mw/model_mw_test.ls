rek           = require 'rekuire'
requires      = rek 'requires'

middleware    = require 'middleware'

requires.test 'test_setup'

ModelRunner   = requires.runner 'model_runner'
ModelMw       = requires.mw     'model_mw'
User          = requires.model  'user'

describe 'model middleware' ->
  user = (name) ->
    new User name

  runner = (data) ->
    new ModelRunner data: data

  model-mw = (runner) ->
    new ModelMw runner: runner

  users     = {}
  runners   = {}
  mw        = {}

  context 'user model middleware' ->
    before ->
      users.kris    := user 'kris'
      runners.user  := runner users.kris
      mw.user       := model-mw runners.user

      # runners.user.debug-on!
      # mw.user.debug-on!

    specify 'should be a ModelMw' ->
      mw.user.constructor.should.be.eql ModelMw

    specify 'should have a model user' ->
      mw.user.should.have.a.property('model').and.be.eql 'user'

    specify 'should have a model user' ->
      mw.user.should.have.a.property('model').and.be.eql 'user'

    specify 'should have a data obj for user' ->
      mw.user.should.have.a.property('data').and.be.eql users.kris
