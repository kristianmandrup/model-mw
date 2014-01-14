rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

User = requires.model 'user'

describe 'User' ->
  var user

  before ->
    user := new User 'kris'

  specify "has a name kris" ->
    user.should.have.a.property('name').and.eql 'kris'