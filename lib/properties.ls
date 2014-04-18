requires = require '../requires'
_        = require 'lodash'
Debugger = requires.lib 'debugger'

module.exports = class Properties implements Debugger
  @defaultSettings =
    value         : 1
    writable      : true
    configurable  : true
    enumerable    : true

  property: (name, settings) ->
    settings ||= {}
    propSettings = _.extend {}, settings, @@defaultSettings

    # using new JavaScript function: defineProperty :)
    Object.defineProperty @, name, propSettings
