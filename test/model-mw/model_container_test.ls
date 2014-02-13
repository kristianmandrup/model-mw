requires     = require '../../requires'
lo           = require 'lodash'

requires.test 'test_setup'

assert = require('chai').assert
expect = require('chai').expect

container = ->
  lo.extend {
    debug: (msg) ->
      console.log msg

  }, requires.file 'model_container'


class User
  (@ctx)

clazz = (name)->
  name: name
  clazz: 'user'

describe 'model runner' ->
  var ctx

  user = (name) ->
    new User name

  users     = {}
  c         = {}
  ctx       = {}

  context 'create' ->
    before ->
      ctx.col           :=
        collection: 'users'

      ctx.mod           :=
        model: 'user'

      users.kris = new User name: 'kris'

      c.col = container!
      c.col.set-data-ctx ctx.col

      c.mod = container!
      c.mod.set-data-ctx ctx.mod

      ctx.dat           :=
        data: users.kris

      c.dat = container!
      c.dat.set-data-ctx ctx.dat

      users.clazz = clazz 'emily'

      ctx.clazz         :=
        data: users.clazz

      c.clazz = container!
      c.clazz.set-data-ctx ctx.clazz


    describe 'collection only' ->
      specify 'should have user model' ->
        c.col.model.should.eql 'user'

      specify 'should have users collection' ->
        c.col.collection.should.eql 'users'

      specify 'should have no data' ->
        expect(c.col.data).to.eql void

    describe 'model only' ->
      specify 'should have user model' ->
        c.mod.model.should.eql 'user'

      specify 'should have users collection' ->
        c.mod.collection.should.eql 'users'

      specify 'should have no data' ->
        expect(c.mod.data).to.eql void

    describe 'data with LiveScript class only' ->
      specify 'should have user model' ->
        c.dat.model.should.eql 'user'

      specify 'should have users collection' ->
        c.dat.collection.should.eql 'users'

      specify 'should have no data' ->
        expect(c.dat.data).to.eql users.kris

    describe 'data w .clazz only' ->
      specify 'should have user model' ->
        c.clazz.model.should.eql 'user'

      specify 'should have users collection' ->
        c.clazz.collection.should.eql 'users'

      specify 'should have no data' ->
        expect(c.clazz.data).to.eql users.clazz
