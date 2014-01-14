rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

middleware = require 'middleware'

ModelRunner   = requires.runner 'model_runner'
ModelMw       = requires.mw 'model_mw'
User          = requires.model 'user'

describe 'model middleware' ->
  var mw, runner, user

  # function to be assigned runner, to be called when runner is done
  doneFun = ->
    'done :)'

  before ->
    user    := new User 'kris'
    runner  := new ModelRunner data: user
    mw      := new ModelMw runner: runner

  specify 'should be a ModelMw' ->
    mw.constructor.should.be.eql ModelMw

  specify 'should have a model user' ->
    mw.should.have.a.property('model').and.be.eql('user')

  specify 'should have a data obj for user' ->
    mw.should.have.a.property('data').and.be.eql user
