quark = (Z, Util)->
    ###
    Space may be encode to either %20 or '+' which would not normally
    be handled properly by the builtin (en|de)codeURIComponent functions.
    Default: replace "+" with " ", and then decodeURIComponent behavior.

    @module QueryString
    @static
    ###

    _qsDecode = (qs) ->
        return decodeURIComponent qs.replace(/\+/g, ' ')
    _qsEncode = encodeURIComponent

    QueryString =
        decode: _qsDecode
        encode: _qsEncode
        ###
        Accept Query String and return native JavaScript objects.

        @param qs  {String} query string to be converted
        @param sep {String} (optional) Character to join k=v pairs together. Default: "&"
        @param eq  {String} (optional) Character to join key and its values. Default: "="
        @module QueryString
        @static
        ###
        parse:(qs, sep = '&', eq = '=')->
            parsed = {}
            if arguments.length == 0
                if window?.location?.search
                    qs = window.location.search

            if Util.isString(qs) and qs.length > 0
                qs = qs.substring 1 if qs[0] == '?'

                pieces = qs.split(sep)

                for kv in pieces
                    if kv == '' then continue
                    tuple = kv.split eq
                    key = _qsDecode(tuple.shift()).trim()
                    value = _qsDecode(tuple.join(eq)).trim()
                    if key == '' then continue
                    if Util.isUndefined(parsed[key])
                        parsed[key] = value
                    else if Util.isArray(parsed[key])
                        parsed[key].push value
                    else
                        parsed[key] = [parsed[key], value]
            else
                throw TypeError("Query string should be a non-empty string!")
            return parsed
        ###
        Converts a plain object to a Query String representation.

        @param obj {Object/String} The object or string to convert to query string
        @param sep {String} (optional) Character to join k=v pairs together. Default: "&"
        @param eq  {String} (optional) Character to join key and its values. Default: "="
        @module QueryString
        @static
        ###
        stringify: (obj, sep = '&', eq = '=')->
            if Util.isString(obj)
                return obj
            qs = []
            for key of obj
                value = obj[key]
                if obj.hasOwnProperty key and (Util.isString value or Util.isNumber value)
                    qs.push _qsEncode(key) + eq + _qsEncode(String(obj[key]))

            return qs.join sep
    Z.QueryString = QueryString
    QueryString

if typeof module is 'object' and typeof module.exports is 'object'
    Util = require './Util'
    Z = require './Zuark'
    exports = module.exports = quark Z, Util

if typeof define is 'function' and define.amd
    define 'QueryString',["Z", "Util"], (Z, Util)->
        return quark Z,Util
