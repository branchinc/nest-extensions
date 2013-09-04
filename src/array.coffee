defineProperty = require './defineProperty'

defineProperty Array.prototype, 'toSentence', ->
  wordsConnector = ", "
  twoWordsConnector = " and "
  lastWordConnector = ", and "
  switch @length
    when 0 then ""
    when 1 then @[0]
    when 2 then @[0] + twoWordsConnector + @[1]
    else
      @slice(0, -1).join(wordsConnector) + lastWordConnector + @[@length - 1]


defineProperty Array.prototype, 'pluck', (key) ->
  @map (item) ->
    item?[key]


defineProperty Array.prototype, 'findWhere', (attrs) ->
  return unless attrs?.size() > 0

  @find (value) ->
    for key of attrs
      return false if attrs[key] != value[key]
    true

module.exports = true
