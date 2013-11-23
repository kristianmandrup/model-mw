_ = require 'lodash'

module.exports = class Properties
  @defaultSettings =
    value         : 1
    writable      : true
    configurable  : true
    enumerable    : true

  property: (name, settings) ->
    settings ||= {}
    propSettings = _.extend {}, settings, Properties.defaultSettings

    # using new JavaScript function: defineProperty :)
    Object.defineProperty @, name, propSettings
