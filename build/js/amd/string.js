define(['Zuark'], function(Zuark) {
  var string;
  string = {
    isInt: function(str, flag) {
      if (flag == null) {
        flag = '';
      }
      switch (flag) {
        case '+':
          return /^\+?\d+$/.test(str);
        case '-':
          return /^-\d+$/.test(str);
        default:
          return /^[+-]?\d+$/.test(str);
      }
    },
    isNumber: function(str, flag) {
      if (flag == null) {
        flag = '';
      }
      switch (flag) {
        case '+':
          return /^\+?\d+(\.\d+)?$/.test(str);
        case '-':
          return /^-\d+(\.\d+)?$/.test(str);
        default:
          return /^[+-]?\d+(\.\d+)?$/.test(str);
      }
    }
  };
  Zuark.string = string;
  return Zuark;
});
