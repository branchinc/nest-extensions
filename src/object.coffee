defineProperty = require './defineProperty'

defineProperty Object.prototype, 'mapKeys', (func) ->
  newObj = {}
  Object.keys(@).each (key) =>
    newKey = func(key)
    newObj[newKey] = @[key]
  newObj

module.exports = true
