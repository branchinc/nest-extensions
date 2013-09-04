// Generated by CoffeeScript 1.6.3
(function() {
  var defineProperty,
    __slice = [].slice;

  defineProperty = require('./defineProperty');

  defineProperty(String.prototype, 'pad', function(length, pad) {
    var arr;
    return arr = new Array(length + 1 - this.length).join(pad) + this.toString();
  });

  defineProperty(String.prototype, 'chunk', function(length) {
    return this.toString().match(new RegExp(".{1," + length + "}", "g"));
  });

  defineProperty(String.prototype, 'stripTags', function(allowed_tags) {
    var allowed, allowed_array, allowed_tag, html, i, k, key, matches, replacer, str;
    str = this;
    key = "";
    allowed = false;
    matches = [];
    allowed_array = [];
    allowed_tag = "";
    i = 0;
    k = "";
    html = "";
    replacer = function(search, replace, str) {
      return str.split(search).join(replace);
    };
    if (allowed_tags) {
      allowed_array = allowed_tags.match(/([a-zA-Z0-9]+)/g);
    }
    str += "";
    matches = str.match(/(<\/?[\S][^>]*>)/g);
    for (key in matches) {
      html = matches[key].toString();
      allowed = false;
      for (k in allowed_array) {
        allowed_tag = allowed_array[k];
        i = -1;
        if (i !== 0) {
          i = html.toLowerCase().indexOf("<" + allowed_tag + ">");
        }
        if (i !== 0) {
          i = html.toLowerCase().indexOf("<" + allowed_tag + " ");
        }
        if (i !== 0) {
          i = html.toLowerCase().indexOf("</" + allowed_tag);
        }
        if (i === 0) {
          allowed = true;
          break;
        }
      }
      if (!allowed) {
        str = replacer(html, "", str);
      }
    }
    return str;
  });

  defineProperty(String.prototype, 'autoLink', function() {
    var k, linkAttributes, option, options, pattern, v;
    options = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    pattern = /(^|\s)((?:https?|ftp):\/\/[\-A-Z0-9+\u0026@#\/%?=~_|!:,.;]*[\-A-Z0-9+\u0026@#\/%=~_|])/gi;
    if (!(options.length > 0)) {
      return this.replace(pattern, "$1<a href='$2'>$2</a>");
    }
    option = options[0];
    linkAttributes = ((function() {
      var _results;
      _results = [];
      for (k in option) {
        v = option[k];
        if (k !== 'callback') {
          _results.push(" " + k + "='" + v + "'");
        }
      }
      return _results;
    })()).join('');
    return this.replace(pattern, function(match, space, url) {
      var link;
      link = (typeof option.callback === "function" ? option.callback(url) : void 0) || ("<a href='" + url + "'" + linkAttributes + ">" + url + "</a>");
      return "" + space + link;
    });
  });

  module.exports = true;

}).call(this);