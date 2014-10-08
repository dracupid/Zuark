;(function() {
var core, queryString, _Zuark_, _util_;
core = function () {
  var Zuark, marco, _env;
  Zuark = {};
  marco = {
    unknown: 0,
    node_like: 2,
    browser: 4
  };
  _env = marco.unknown;
  if (typeof module === 'object' && typeof module.exports === 'object') {
    exports = Zuark;
    _env = marco.node_like;
  } else if (typeof window === 'object' && typeof window.document === 'object') {
    window.Zuark = Zuark;
    if (window._) {
      window.lodash = _;
    }
    _env = marco.browser;
  }
  if (!String.prototype.trim) {
    String.prototype.trim = function () {
      return this.replace(/^\s+|\s+$/g, '');
    };
  }
  return Zuark;
}();
_util_ = function (Zuark) {
  var util;
  util = {};
  Zuark.util = util;
  return Zuark;
}(core);
queryString = function (Zuark) {
  /*
  Space may be encode to either %20 or '+' which would not normally
  be handled properly by the builtin (en|de)codeURIComponent functions.
  Default: replace "+" with " ", and then decodeURIComponent behavior.
  
  @module QueryString
  @static
   */
  var _, _qsDecode, _qsEncode;
  _ = lodash;
  _qsDecode = function (qs) {
    return decodeURIComponent(qs.replace(/\+/g, ' '));
  };
  _qsEncode = encodeURIComponent;
  Zuark.QueryString = {
    decode: _qsDecode,
    encode: _qsEncode,
    /*
    Accept Query String and return native JavaScript objects.
    
    @param qs  {String} query string to be converted
    @param sep {String} (optional) Character to join k=v pairs together. Default: "&"
    @param eq  {String} (optional) Character to join key and its values. Default: "="
    @module QueryString
    @static
     */
    parse: function (qs, sep, eq) {
      var key, kv, parsed, pieces, tuple, value, _i, _len, _ref;
      if (sep == null) {
        sep = '&';
      }
      if (eq == null) {
        eq = '=';
      }
      parsed = {};
      if (arguments.length === 0) {
        if (typeof window !== 'undefined' && window !== null ? (_ref = window.location) != null ? _ref.search : void 0 : void 0) {
          qs = window.location.search;
        }
      }
      if (_.isString(qs) && qs.length > 0) {
        if (qs[0] === '?') {
          qs = qs.substring(1);
        }
        pieces = qs.split(sep);
        for (_i = 0, _len = pieces.length; _i < _len; _i++) {
          kv = pieces[_i];
          if (kv === '') {
            continue;
          }
          tuple = kv.split(eq);
          key = _qsDecode(tuple.shift()).trim();
          value = _qsDecode(tuple.join(eq)).trim();
          if (key === '') {
            continue;
          }
          if (_.isUndefined(parsed[key])) {
            parsed[key] = value;
          } else if (_.isArray(parsed[key])) {
            parsed[key].push(value);
          } else {
            parsed[key] = [
              parsed[key],
              value
            ];
          }
        }
      } else {
        throw TypeError('Query string should be a non-empty string!');
      }
      return parsed;
    },
    /*
    Converts a plain object to a Query String representation.
    
    @param obj {Object/String} The object or string to convert to query string
    @param sep {String} (optional) Character to join k=v pairs together. Default: "&"
    @param eq  {String} (optional) Character to join key and its values. Default: "="
    @module QueryString
    @static
     */
    stringify: function (obj, sep, eq) {
      var key, qs;
      if (sep == null) {
        sep = '&';
      }
      if (eq == null) {
        eq = '=';
      }
      if (_.isString(obj)) {
        return obj;
      }
      if (!_.isPlainObject(obj)) {
        throw TypeError('Only plain object or string can be stringify to a queryString');
      }
      qs = [];
      for (key in obj) {
        if (obj.hasOwnProperty(key)) {
          qs.push(_qsEncode(key) + eq + _qsEncode(String(obj[key])));
        }
      }
      return qs.join(sep);
    }
  };
  return Zuark;
}(core);
_Zuark_ = function (Zuark) {
  return Zuark;
}(core);
}());