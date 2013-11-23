require '../../test_setup'

User = require '../../../models/user'

describe 'User' ->
  var user

  before ->
    user := new User 'kris'

  specify "has a name kris" ->
    user.should.have.a.property('name').and.eql 'kris'