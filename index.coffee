"use strict"

SimplePublisher = require "amo.modules.simple_publisher"
forbiddenProps = ["addProperty", "addProperties", "register", "publish"]

module.exports = class ObservableValue extends SimplePublisher
  constructor: (props = {}) ->
    super()
    @addProperties props

  addProperty: (key, val) ->
    return @ if @hasOwnProperty(key) or  key in forbiddenProps
    self = @
    descriptor =
      configurable: false
      enumerable: true
      get: -> val
      set: (newVal) ->
        return if val is newVal
        old = val
        val = newVal
        self.publish key, old, val
    Object.defineProperty @, key, descriptor
    return @

  addProperties: (props) ->
    @addProperty k, v for k, v of props
    return @
