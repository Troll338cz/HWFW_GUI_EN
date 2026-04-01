/* eslint-disable */
/**
 * 特殊字符处理
 * @param {*} value 校验的字符串
 */
function escapeHtml(value) {
  if (typeof (value) == "string") {
      if (value.indexOf("&") > -1 && value.indexOf("&amp;") < 0) {
          value = value.replace(/&/g, "&amp;");
      }
      if (value.indexOf("<") > -1) {
          value = value.replace(/</g, "&lt;");
      }
      if (value.indexOf(">") > -1) {
          value = value.replace(/>/g, "&gt;");
      }
      if (value.indexOf("/") > -1) {
          value = value.replace(/\//g, "&#x2F;");
      }
      if (value.indexOf("\"") > -1) {
          value = value.replace(/"/g, "&quot;");
      }
      if (value.indexOf("'") > -1) {
          value = value.replace(/'/g, "&#x27;");
      }
  }
  return value;
}

/**
 * XSS防注入对象处理
 * @param {*} obj 校验的内容
 */
function defendXSS(obj) {
  if (typeof (obj) == "string") {
      return escapeHtml(obj);
  } else if (typeof (obj) == "number") {
      return obj;
  } else if (typeof (obj) == "object") {
      for (var key in obj) {
          obj[key] = defendXSS(obj[key]);
      }
      return obj;
  } else {
      return obj;
  }
}