quark = (Z)->
    _String =
        isInt:(str, flag = '')->
            switch flag
                when '+' then return /^\+?\d+$/.test str
                when '-' then return /^-\d+$/.test str
                else return /^[+-]?\d+$/.test str
        isNumber: (str, flag = '')->
            switch flag
                when '+' then return /^\+?\d+(\.\d+)?$/.test str
                when '-' then return /^-\d+(\.\d+)?$/.test str
                else return /^[+-]?\d+(\.\d+)?$/.test str
    Z.String = _String
    _String

if typeof module is 'object' and typeof module.exports is 'object'
    Z = require './Zuark'
    exports = module.exports = quark Z

if typeof define is 'function' and define.amd
    define 'QueryString',["Zuark"], (Z)->
        return quark Z
