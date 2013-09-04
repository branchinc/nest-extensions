module.exports = (target, name, method) ->
  Object.defineProperty target, name,
    value: method
    configurable: true
    enumerable: false
    writable: true
