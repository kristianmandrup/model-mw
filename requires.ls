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

model-path = (...paths) ->
  upaths = underscore(...paths)
  ['models', upaths].flatten!.join '/'

middleware-path = (...paths) ->
  upaths = underscore(...paths)
  ['mw', upaths].flatten!.join '/'

module.exports =
  file-lv: (lvs) ->
    file-level := lvs

  test-lv: (lvs) ->
    test-level := lvs

  test: (...paths) ->
    rek test-path(paths)

  middleware: (...paths) ->
    rek middleware-path(paths)

  model: (...paths) ->
    rek model-path(paths)

  # alias
  mw: (path) ->
    @middleware path

  fixture: (path) ->
    @test 'fixtures', path

  test-model: (path) ->
    @test 'models', path

  # alias
  fix: (path) ->
    @fixture path

  test-factory: (path) ->
    @test 'factories', path

  # alias
  test-fac: (path) ->
    @test-factory path

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
