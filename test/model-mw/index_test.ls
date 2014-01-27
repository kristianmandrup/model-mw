rek       = require 'rekuire'
requires  = rek 'requires'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

_  = require 'prelude-ls'

model-mw = requires.file 'index'

ModelMw       = model-mw.mw
ModelRunner   = model-mw.runner

describe 'index' ->
  describe 'ModelMw' ->
    specify 'is class' ->
      ModelMw.display-name.should.eql 'ModelMw'

  describe 'ModelRunner' ->
    specify 'is class' ->
      ModelRunner.display-name.should.eql 'ModelRunner'
