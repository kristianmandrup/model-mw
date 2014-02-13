requires     = require '../../requires'

middleware    = require 'middleware'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

ModelRunner   = requires.runner 'model_runner'
ModelMw       = requires.mw     'model_mw'

User          = requires.model  'user'

describe 'model middleware' ->
  user = (name) ->
    new User name

  runner = (ctx) ->
    new ModelRunner ctx

  model-mw = (runner) ->
    new ModelMw runner: runner

  users     = {}
  runners   = {}
  mw        = {}


  context 'runner with data: user kris ' ->
    before ->
      users.kris    := user 'kris'
      runners.user  := runner data: users.kris
      mw.user       := model-mw runners.user

    specify 'should be a ModelMw' ->
      mw.user.constructor.should.be.eql ModelMw

    specify 'should have a model user' ->
      mw.user.should.have.a.property('model').and.be.eql 'user'

    specify 'should have a model user' ->
      mw.user.should.have.a.property('model').and.be.eql 'user'

    specify 'should have a data obj for user' ->
      mw.user.should.have.a.property('data').and.be.eql users.kris

    describe 'smart-merge' ->
      var res

      context 'data: some girl' ->
        before ->
          res := mw.user.smart-merge(data: 'some girl')

        specify 'should merge data smartly' ->
          expect(res.data).to.eql 'some girl'

        specify 'should clean model' ->
          expect(res.model).to.eql void

        specify 'should clean collection' ->
          expect(res.collection).to.eql void

    context 'runner has User data but NO collection' ->
      before ->
        runners.user  := runner data: users.kris
        mw.user       := model-mw runners.user

      describe 'collection' ->
        specify 'should throw error' ->
          mw.user.collection.should.eql 'users'

      describe 'model' ->
        specify 'should be set' ->
          mw.user.model.should.eql 'user'

      describe 'data' ->
        specify 'should be set' ->
          mw.user.data.should.eql users.kris

    context 'runner has User data and collection' ->
      before ->
        runners.user  := runner data: users.kris, collection: 'users'

      describe 'collection' ->
        specify 'should be set' ->
          mw.user.collection.should.eql 'users'

      describe 'model' ->
        specify 'should be set' ->
          mw.user.model.should.eql 'user'

    context 'runner has User data and model' ->
      before ->
        runners.user  := runner data: users.kris, collection: 'users'

      describe 'collection' ->
        specify 'should be set' ->
          mw.user.collection.should.eql 'users'

      describe 'model' ->
        specify 'should be set' ->
          mw.user.model.should.eql 'user'

    describe 'run-alone' ->
      context 'mw.user' ->
        var res

        before ->
          runners.user  := runner data: users.kris, collection: 'users'
          mw.user       := model-mw runners.user
          res           := mw.user.run-alone!

          specify 'should return data' ->
            res.should.eql users.kris

    describe 'run' ->
      context 'no runner and not alone' ->
        before ->
          mw.user       := model-mw

          specify 'should throw error' ->
            expect( -> mw.user.run!).to.throw

    describe 'run' ->
      context 'mw.user - default run method' ->
        before ->
          runners.user  := runner data: users.kris, collection: 'users'
          mw.user       := model-mw runners.user

          specify 'should return data' ->
            mw.user.run!.should.eql users.kris

      context 'mw.user - custom run method' ->
        before ->
          runners.user  := runner data: users.kris, collection: 'users'
          mw.user       := model-mw runners.user
          mw.user.run = ->
            my-data: @data

        specify 'should return custom' ->
          mw.user.run!.my-data.should.eql users.kris

      context 'mw.user - custom run method' ->
        var mw-alone
        before ->
          mw-alone       := new ModelMw name: 'basic'

        specify 'should return custom' ->
          mw-alone.run(mode: 'alone', data: users.kris, collection: 'users').should.eql users.kris


      context 'mw.user - run with context model: post' ->
        var res

        before ->
          runners.user  := runner data: users.kris, collection: 'users'
          mw.user       := model-mw runners.user
          mw.user.run(model: 'post')

        specify 'should set mw model to run model post' ->
          expect(mw.user.model).to.eql 'post'

        specify 'should calc mw collection from new model post' ->
          expect(mw.user.collection).to.eql 'posts'

        specify 'should clear mw data' ->
          expect(mw.user.data).to.eql void

      context 'mw.user - run with context collection: posts' ->
        var res

        before ->
          runners.user  := runner data: users.kris, collection: 'users'
          mw.user       := model-mw runners.user
          mw.user.run(collection: 'posts')

        specify 'should set mw model to run model post' ->
          expect(mw.user.model).to.eql 'post'

        specify 'should calc mw collection from new model post' ->
          expect(mw.user.collection).to.eql 'posts'

        specify 'should clear mw data' ->
          expect(mw.user.data).to.eql void
