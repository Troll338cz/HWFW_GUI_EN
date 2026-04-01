function dealDataWithFun(str) {
  if (typeof str === 'string' && str.indexOf('function') === 0) {
    return Function('"use strict";return (' + str + ')')()();
  }
  return str;
}


var getElementId = function(domain) {
  if (domain) {
    var reg = /[.]/g;
    return domain.replace(reg, '_');
  }
  return '';
}
