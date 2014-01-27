rek       = require 'rekuire'
requires  = rek 'requires'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

_  = require 'prelude-ls'

model-mw = requires.file 'index'

ModelMw       = model-mw.mw
ModelRunner   = model-mw.runner

Middleware    = require('middleware').Middleware

describe 'index' ->
  describe 'ModelMw' ->
    specify 'is class' ->
      ModelMw.display-name.should.eql 'ModelMw'

  describe 'ModelRunner' ->
    specify 'is class' ->
      ModelRunner.display-name.should.eql 'ModelRunner'

  describe 'ModelRunner middleware' ->
    specify 'is registered' ->
      Middleware.get-registered('model').should.eql ModelRunner

    specify 'can be used by name on Middleware' ->
      expect( -> new Middleware 'model').to.not.throw!