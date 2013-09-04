defineProperty = require './defineProperty'

defineProperty String.prototype, 'pad', (length, pad) ->
  arr = new Array(length + 1 - @length).join(pad) + @toString()

defineProperty String.prototype, 'chunk', (length) ->
  @toString().match(new RegExp(".{1,#{length}}", "g"))


# From http://brijeshshah.com/tag/strip_tags-in-javascript/
defineProperty String.prototype, 'stripTags', (allowed_tags) ->
  str = this
  key = ""
  allowed = false
  matches = []
  allowed_array = []
  allowed_tag = ""
  i = 0
  k = ""
  html = ""
  replacer = (search, replace, str) ->
    str.split(search).join replace


  # Build allowes tags associative array
  allowed_array = allowed_tags.match(/([a-zA-Z0-9]+)/g)  if allowed_tags
  str += ""

  # Match tags
  matches = str.match(/(<\/?[\S][^>]*>)/g)

  # Go through all HTML tags
  for key of matches
    # Save HTML tag
    html = matches[key].toString()

    # Is tag not in allowed list? Remove from str!
    allowed = false

    # Go through all allowed tags
    for k of allowed_array

      # Init
      allowed_tag = allowed_array[k]
      i = -1
      i = html.toLowerCase().indexOf("<" + allowed_tag + ">")  unless i is 0
      i = html.toLowerCase().indexOf("<" + allowed_tag + " ")  unless i is 0
      i = html.toLowerCase().indexOf("</" + allowed_tag)  unless i is 0

      # Determine
      if i is 0
        allowed = true
        break
    str = replacer(html, "", str)  unless allowed # Custom replace. No regexing
  str

defineProperty String.prototype, 'autoLink', (options...) ->
  pattern = ///
    (^|\s) # Capture the beginning of string or leading whitespace
    (
      (?:https?|ftp):// # Look for a valid URL protocol (non-captured)
      [\-A-Z0-9+\u0026@#/%?=~_|!:,.;]* # Valid URL characters (any number of times)
      [\-A-Z0-9+\u0026@#/%=~_|] # String must end in a valid URL character
    )
  ///gi

  return @replace(pattern, "$1<a href='$2'>$2</a>") unless options.length > 0

  option = options[0]
  linkAttributes = (
    " #{k}='#{v}'" for k, v of option when k isnt 'callback'
  ).join('')

  @replace pattern, (match, space, url) ->
    link = option.callback?(url) or
      "<a href='#{url}'#{linkAttributes}>#{url}</a>"

    "#{space}#{link}"


module.exports = true
