(function() {
  define(function() {
    var Zuark, marco, _env;
    Zuark = {};
    marco = {
      unknown: 0,
      node_like: 2,
      browser: 4
    };
    _env = marco.unknown;
    if (typeof module === 'object' && typeof module.exports === 'object') {
      module.exports = Zuark;
      _env = marco.node_like;
    } else if (typeof window === 'object' && typeof window.document === 'object') {
      window.Zuark = Zuark;
      if (window._) {
        window.lodash = _;
      }
      _env = marco.browser;
    }
    if (!String.prototype.trim) {
      String.prototype.trim = function() {
        return this.replace(/^\s+|\s+$/g, '');
      };
    }
    return Zuark;
  });

}).call(this);
