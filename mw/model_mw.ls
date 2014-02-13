requires     = require '../requires'
_            = require 'prelude-ls'
lo           = require 'lodash'

middleware   = require 'middleware'
BaseMw       = middleware.Mw.base
Debugger     = requires.file 'debugger'
Container    = requires.file 'model_container'

module.exports = class ModelMw extends BaseMw implements Container, Debugger
  (@context) ->
    super ...
    ctx = @context.runner || @context
    @set-data-ctx ctx

  validate-and-set: (ctx) ->
    @debug 'validate-and-set', ctx
    if _.is-type 'Object', ctx
      mode = ctx.mode

    unless @valid-ctx ctx
      @debug 'set to runner'
      ctx = @runner
    else
      @debug 'valid ctx', ctx

    @set-data-ctx ctx
    @validate mode

  validate: (mode) ->
    @debug 'mode', mode
    unless @runner
      if mode isnt 'alone'
        throw Error "ModelMw must have a runner when running mode: #{mode}"

    @validate-data-ctx!

  smart-merge: (ctx) ->
    ctx

  run: (ctx) ->
    @debug 'run model-mw', ctx
    @validate-and-set ctx
    @data

  run-alone: (ctx) ->
    @run lo.extend ctx, mode: 'alone'
