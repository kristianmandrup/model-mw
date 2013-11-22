module.exports =
  defaultSettings =
    value         : 1
    writable      : true
    configurable  : true
    enumerable    : true

  property: (name, settings) ->
    settings ||= {}
    propSettings = _.extend {}, settings, defaultSettings
    Object.defineProperty @, name, propSettings

