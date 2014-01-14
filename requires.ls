rek = require 'rekuire'
require 'sugar'
_ = require 'prelude-ls'

underscore = (items) ->
  strings = items.map (item) ->
    String(item)
  _.map (.underscore!), strings

test-level = 1
file-level = 0

test-base-path = ->
  "test"

file-base-path = ->
  "."

test-path = (...paths) ->
  upaths = underscore(...paths)
  [test-base-path!, upaths].flatten!.join '/'

<<<<<<< HEAD
runner-path = (...paths) ->
  upaths = underscore(...paths)
  ['runner', upaths].flatten!.join '/'

mw-path = (...paths) ->
  upaths = underscore(...paths)
  ['mw', upaths].flatten!.join '/'

=======
>>>>>>> 2624be2150335c172a3f2f811622a6de7911ccd9
model-path = (...paths) ->
  upaths = underscore(...paths)
  ['models', upaths].flatten!.join '/'

<<<<<<< HEAD
=======
middleware-path = (...paths) ->
  upaths = underscore(...paths)
  ['mw', upaths].flatten!.join '/'
>>>>>>> 2624be2150335c172a3f2f811622a6de7911ccd9

module.exports =
  file-lv: (lvs) ->
    file-level := lvs

  test-lv: (lvs) ->
    test-level := lvs

  test: (...paths) ->
    rek test-path(paths)

<<<<<<< HEAD
  runner: (...paths) ->
    rek runner-path(paths)

  mw: (...paths) ->
    rek mw-path(paths)
=======
  middleware: (...paths) ->
    rek middleware-path(paths)
>>>>>>> 2624be2150335c172a3f2f811622a6de7911ccd9

  model: (...paths) ->
    rek model-path(paths)

<<<<<<< HEAD
  fixture: (path) ->
    @test 'fixtures', path

=======
  # alias
  mw: (path) ->
    @middleware path

  fixture: (path) ->
    @test 'fixtures', path

  test-model: (path) ->
    @test 'models', path

>>>>>>> 2624be2150335c172a3f2f811622a6de7911ccd9
  # alias
  fix: (path) ->
    @fixture path

<<<<<<< HEAD
  factory: (path) ->
    @test 'factories', path

  # alias
  fac: (path) ->
    @factory path
=======
  test-factory: (path) ->
    @test 'factories', path

  # alias
  test-fac: (path) ->
    @test-factory path
>>>>>>> 2624be2150335c172a3f2f811622a6de7911ccd9

  file: (path) ->
    rek [file-base-path!, path.underscore!].join '/'

  # m - alias for module
  m: (path) ->
    @file path

  files: (...paths) ->
    paths.map (path) ->
      @file path

  fixtures: (...paths) ->
    paths.map (path) ->
      @fixture path

  tests: (...paths) ->
    paths.map (path) ->
      @test path
