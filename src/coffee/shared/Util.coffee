type = Object.prototype.toString.call

isType = (val, typeName)->
    type(val) is "[object #{typeName}]"


quark = (Z)->
    Util =
        isFunction: (val)->
            isType(val, 'Function')
        isRegex: (val)->
            isType(val, 'RegExp')
        isArray: (val)->
            isType(val, 'Array')
        isString: (val)->
            isType(val, 'String')
        isNumber: (val)->
            isType(val, 'Number')
        isUndefined:(val)->
            typeof val == 'undefined'
    Z.Util = Util
    Util

if typeof module is 'object' and typeof module.exports is 'object'
    Z = require './Zuark'
    exports = module.exports = quark Z

if typeof define is 'function' and define.amd
    define 'Util',["Zuark"], (Z)->
        return quark Z
