rek           = require 'rekuire'
requires      = rek 'requires'

middleware    = require 'middleware'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

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

  context 'create' ->
    before ->
      ctx           :=
        collection: 'users'

    describe 'data only' ->
      specify 'should throw missing data' ->
        (-> runner data: {}).should.throw!

    describe 'model only' ->
      specify 'should NOT throw missing data' ->
        (-> runner model: 'user').should.not.throw!

      describe 'model' ->
        specify 'should be model singularized' ->
          runner(model: 'users').model.should.eql 'user'

      describe 'collection' ->
        specify 'should be model pluralized' ->
          runner(model: 'user').collection.should.eql 'users'

    describe 'collection only' ->
      specify 'should allow' ->
        (-> runner collection: 'users').should.not.throw!

    describe 'model and collection only' ->
      specify 'should NOT throw missing data' ->
        (-> runner model: 'user', collection: 'users').should.not.throw!

      describe 'model' ->
        specify 'should be model singularized' ->
          runner(model: 'users').model.should.eql 'user'

      describe 'collection' ->
        specify 'should be model pluralized' ->
          runner(model: 'user').collection.should.eql 'users'

    describe 'data and collection only' ->
      before ->
        users.kris    := user 'kris'
        runners.user = runner data: users.kris, collection: 'users'

      describe 'model' ->
        specify 'should be model singularized' ->
          runners.user.model.should.eql 'user'

      describe 'collection' ->
        specify 'should be model pluralized' ->
          runners.user.collection.should.eql 'users'

      describe 'data' ->
        specify 'should be user kris' ->
          runners.user.data.should.eql users.kris

    describe 'data and model only' ->
      before ->
        users.kris    := user 'kris'
        runners.user = runner data: users.kris, model: 'Users'

      describe 'model' ->
        specify 'should be model singularized' ->
          runners.user.model.should.eql 'user'

      describe 'collection' ->
        specify 'should be model pluralized' ->
          runners.user.collection.should.eql 'users'

      describe 'data' ->
        specify 'should be user kris' ->
          runners.user.data.should.eql users.kris

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
