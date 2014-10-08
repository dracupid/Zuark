Zuark = {}


if typeof module == 'object' && typeof module.exports == 'object'
    require "es5-shim"
    exports = module.exports = Zuark

if typeof define is 'function' and define.amd
    define 'Zuark',["es5-shim"], ()->
        return Zuark

if typeof window is 'object' and typeof window.document is 'object'
    window.Zuark = Zuark
