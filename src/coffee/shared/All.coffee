quarks = [
    'Zuark'
    'Util'
    'QueryString'
    'String'
]

if typeof module is 'object' and typeof module.exports is 'object'
    quarks.map (quark)->
        require quark
    Z = require './Zuark'
    exports = module.exports = Z

if typeof define is 'function' and define.amd
    define 'QueryString',quarks, (Z)->
        return quark Z
