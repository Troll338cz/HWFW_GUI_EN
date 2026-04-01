
var TabWidth = "75%";

function GetDescFormArrayById(Language, Name) {
  return (Language[Name] == null || Language[Name] == "undefined") ? "" : Language[Name];
}

function ParseBindTextByTagName(LanguageArray, TagName, TagType) {
  var all = document.getElementsByTagName(TagName);
  for (var i = 0; i < all.length; i++) {
    var b = all[i];
    var c = b.getAttribute("BindText");
    if (c == null) {
      continue;
    }

    if (1 == TagType) {
      b.innerHTML = GetDescFormArrayById(LanguageArray, c);
    }
    else if (2 == TagType) {
      b.value = GetDescFormArrayById(LanguageArray, c);
    }
  }
}


function SetDivValue(Id, Value) {
  try {
    var Div = document.getElementById(Id);
    Div.innerHTML = Value;
  }
  catch (ex) {
  }
}
function getElById(sId) {
  return getElement(sId);
}

function getValue(id) {
  var element = getElement(id);
  if (element == null) {
    debug(id + " is not existed");
    return -1;
  }

  return element.value;
}

function Submit(type) {
  if (CheckForm(type) == true) {
    var Form = new webSubmitForm();
    AddSubmitParam(Form, type);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
  }
}

function CreateXMLHttp() {
  function getXmlReqHttp() {
    var msVersions = ["MSXML2.XMLHttp.5.0", "MSXML2.XMLHttp.4.0", "MSXML2.XMLHttp.3.0",
    "MSXML2.XMLHttp", "Microsoft.XMLHttp"];
    var xmlReqhttp = null;
    for (var i = 0; i < 5; i++) {
      try {
        xmlReqhttp = new ActiveXObject(msVersions[i]);
        return xmlReqhttp;
      }
      catch (e) {
      }
    }
    return null;
  }

  var xmlReqhttp = null;
  if (window.XMLHttpRequest) {
    try {
      xmlReqhttp = new XMLHttpRequest();
    } catch (e) { }
  } else {
    if (window.ActiveXObject) {
      xmlReqhttp = getXmlReqHttp();
    }
  }
  return xmlReqhttp;
}

function XmlHttpSendAspFlieWithoutResponse(FileName) {
  var xmlReqHttp = null;
  if (null == FileName || FileName == "") {
    return false;
  }
  if (window.XMLHttpRequest) {
    xmlReqHttp = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    xmlReqHttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  xmlReqHttp.open("GET", FileName, false);
  xmlReqHttp.send(null);
}

var encodeBase64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var decodeBase64Chars = new Array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
  16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1,
  -1, -1, -1, -1);

function base64encode(str) {
  var out, i, len;
  var part1, part2, part3;
  len = str.length;
  i = 0;
  out = "";
  while (i < len) {
    part1 = str.charCodeAt(i++) & 0xff;
    if (i == len) {
      out += encodeBase64Chars.charAt(part1 >> 2);
      out += encodeBase64Chars.charAt((part1 & 0x3) << 4);
      out += "==";
      break;
    }

    part2 = str.charCodeAt(i++);
    if (i == len) {
      out += encodeBase64Chars.charAt(part1 >> 2);
      out += encodeBase64Chars.charAt(((part1 & 0x3) << 4) | ((part2 & 0xF0) >> 4));
      out += encodeBase64Chars.charAt((part2 & 0xF) << 2);
      out += "=";
      break;
    }

    part3 = str.charCodeAt(i++);
    out += encodeBase64Chars.charAt(part1 >> 2);
    out += encodeBase64Chars.charAt(((part1 & 0x3) << 4) | ((part2 & 0xF0) >> 4));
    out += encodeBase64Chars.charAt(((part2 & 0xF) << 2) | ((part3 & 0xC0) >> 6));
    out += encodeBase64Chars.charAt(part3 & 0x3F);
  }
  return out;
}

function base64decode(str) {
  var part1, part2, part3, part4;
  var i, len, out;
  len = str.length;
  i = 0;
  out = "";
  while (i < len) {
    do {
      part1 = decodeBase64Chars[str.charCodeAt(i++) & 0xff];
    } while (i < len && part1 == -1);
    if (part1 == -1)
      break;

    do {
      part2 = decodeBase64Chars[str.charCodeAt(i++) & 0xff];
    } while (i < len && part2 == -1);
    if (part2 == -1)
      break;
    out += String.fromCharCode((part1 << 2) | ((part2 & 0x30) >> 4));

    do {
      part3 = str.charCodeAt(i++) & 0xff;
      if (part3 == 61)
        return out;

      part3 = decodeBase64Chars[part3];
    } while (i < len && part3 == -1);
    if (part3 == -1)
      break;

    out += String.fromCharCode(((part2 & 0XF) << 4) | ((part3 & 0x3C) >> 2));
    do {
      part4 = str.charCodeAt(i++) & 0xff;
      if (part4 == 61)
        return out;
      part4 = decodeBase64Chars[part4];
    } while (i < len && part4 == -1);
    if (part4 == -1)
      break;
    out += String.fromCharCode(((part3 & 0x03) << 6) | part4);
  }
  return out;
}

function getElementById(sId) {
  var getEleById = document.getElementById;
  var docAll = document.all;
  var docLayers = document.layers;
  if (getEleById) {
    return document.getElementById(sId);
  } else if (docAll) {
    return document.all(sId);
  } else if (docLayers) {
    return document.layers[sId];
  }
  return null;
}

function getElementByName(sId) {
  var getEleByName = document.getElementsByName;
  if (getEleByName) {
    var ele = document.getElementsByName(sId);
    if (ele.length == 0) {
      return null;
    } else {
      return (ele.length == 1 ? ele[0] : ele);
    }
  }
}

function getElement(sId) {
  var ele = getElementByName(sId);
  return ((ele == null) ? getElementById(sId) : ele);
}

var makeCheckBoxValue = function (srcForm) {
  var changeRadioPro = function (name) {
    var radio = getElement(name);
    for (var k = 0; k < radio.length; k++) {
      if (radio[k].checked == false) {
        radio[k].disabled = true;
      }
    }
  };
  var inputs = srcForm.getElementsByTagName('input');
  for (var i = 0; i < inputs.length; i++) {
    if (inputs[i].type == 'checkbox') {
      var checkBox = getElement(inputs[i].name);
      checkBox.value = (checkBox.checked == true) ? 1 : 0;
    } else if (inputs[i].type == 'radio') {
      changeRadioPro(inputs[i].name);
    }
  }
}

var addForm = function (sFormName, domainNamePrefix) {
  this.setPrefix(domainNamePrefix);
  var srcForm = getElement(sFormName);
  if (srcForm != null && srcForm.length > 0
    && this.oForm != null && srcForm.style.display != 'none') {
    makeCheckBoxValue(srcForm);
    for (var i = 0; i < srcForm.elements.length; i++) {
      var type = srcForm.elements[i].type;
      if (type != 'button' && srcForm.elements[i].disabled == false) {
        var prefix = (this.domainNamePrefix != '.') ? this.domainNamePrefix : '';
        var ele = this.createNewFormElement(prefix + srcForm.elements[i].name, srcForm.elements[i].value);
        this.oForm.appendChild(ele);
      }
    }
  } else {
    this.status = false;
  }
  this.domainNamePrefix = '.';
};

var addDiv = function (sDivName, prefix) {
  prefix = (prefix == null) ? '' : prefix + '.';

  var srcDiv = getElement(sDivName);
  if (srcDiv == null || srcDiv.style.display == 'none') {
    return;
  }

  var eleSelect = srcDiv.getElementsByTagName('select');
  if (eleSelect != null) {
    for (var k = 0; k < eleSelect.length; k++) {
      if (eleSelect[k].disabled == false) {
        this.addParameter(prefix + eleSelect[k].name, eleSelect[k].value);
      }
    }
  }

  makeCheckBoxValue(srcDiv);
  var eleInput = srcDiv.getElementsByTagName('input');
  if (eleInput != null) {
    for (var k = 0; k < eleInput.length; k++) {
      if (eleInput[k].type != 'button' && eleInput[k].disabled == false) {
        this.addParameter(prefix + eleInput[k].name, eleInput[k].value);
      }
    }
  }
};

var addParameter = function (sName, sValue) {
  var domainName = this.getDomainName(sName);
  var i = 0;
  for (i = 0; i < this.oForm.elements.length; i++) {
    if (this.oForm.elements[i].name == domainName) {
      this.oForm.elements[i].value = sValue;
      this.oForm.elements[i].disabled = false;
      return;
    }
  }

  if (i == this.oForm.elements.length) {
    var ele = this.createNewFormElement(domainName, sValue);
    this.oForm.appendChild(ele);
  }
};

var disableElement = function (sName) {
  var domainName = this.getDomainName(sName);
  for (var i = 0; i < this.oForm.elements.length; i++) {
    if (this.oForm.elements[i].name == domainName) {
      this.oForm.elements[i].disabled = true;
      return;
    }
  }
};

var submit = function (sURL, sMethod) {
  if (sURL != null && sURL != '') this.setAction(sURL);
  if (sMethod != null && sMethod != '') this.setMethod(sMethod);
  if (this.status == true) this.oForm.submit();
};

var getNewSubmitForm = function () {
  var submitForm = document.createElement('FORM');
  document.body.appendChild(submitForm);
  submitForm.method = 'POST';
  return submitForm;
};

var createNewFormElement = function (elementName, elementValue) {
  var newElement = document.createElement('INPUT');
  newElement.setAttribute('name', elementName);
  newElement.setAttribute('value', elementValue);
  newElement.setAttribute('type', 'hidden');
  return newElement;
};

var webSubmitForm = function (sFormName, domainNamePrefix) {
  this.setPrefix = function (Prefix) {
    this.domainNamePrefix = (Prefix == null) ? '.' : (Prefix + '.');
  };

  this.getDomainName = function (sName) {
    return (this.domainNamePrefix == '.') ? sName : (this.domainNamePrefix + sName);
  };

  this.getNewSubmitForm = getNewSubmitForm;
  this.createNewFormElement = createNewFormElement;
  this.addForm = addForm;
  this.addDiv = addDiv;
  this.addParameter = addParameter;
  this.disableElement = disableElement;

  this.usingPrefix = function (prefix) {
    this.domainNamePrefix = prefix + '.';
  };

  this.endPrefix = function () {
    this.domainNamePrefix = '.';
  };

  this.setMethod = function (sMethod) {
    this.oForm.method = (sMethod.toUpperCase() == 'GET') ? 'GET' : 'POST';
  };

  this.setAction = function (sUrl) {
    this.oForm.action = sUrl;
  };

  this.setTarget = function (sTarget) {
    this.oForm.target = sTarget;
  };

  this.submit = submit;
  this.status = true;
  this.setPrefix(domainNamePrefix);
  this.oForm = this.getNewSubmitForm();
  if (sFormName != null && sFormName != '') {
    this.addForm(sFormName, this.domainNamePrefix);
  }
}

function getValue(sId) {
  var item = getElement(sId);
  return (item == null ? -1 : item.value);
}

function setText(sId, sValue) {
  var item = getElement(sId);
  if (item == null) {
    return false;
  }
  item.value = sValue;
  return true;
}

function getDivInnerId(divID) {
  var nameStartPos = -1;
  var nameEndPos = -1;
  divHTML = getElement(divID).innerHTML;
  nameStartPos = divHTML.indexOf('name=');
  nameEndPos = divHTML.indexOf(' ', nameStartPos);
  if (nameEndPos <= 0) {
    nameEndPos = divHTML.indexOf('>', nameStartPos);
  }

  var ele = divHTML.substring(nameStartPos + 3, nameEndPos);
  return ele;
}


function setDisable(sId, flag) {
  var item = getElement(sId);
  if (item == null) {
    return false;
  }

  if (typeof (item.disabled) == 'undefined') {
    if (item.tagName == 'DIV' || item.tagName == 'div') {
      var ele = getDivInnerId(sId);
      setDisable(ele, flag);
    }
  } else {
    item.disabled = (flag == 1 ? true : false);
  }

  return true;
}

function setDisplay(sId, sh) {
  var status = (sh > 0 ? '' : 'none');
  getElement(sId).style.display = status;
}

function isValidAscii(str) {
  for (var i = 0; i < str.length; i++) {
    var ch = str.charAt(i);
    if (ch < ' ' || ch > '~') {
      return false;
    }
  }
  return true;
}

function getLayerStr(isNs4, barheight, barwidth, bordercolor, barheight, unloadedcolor, loadedcolor) {
  var txt = '';
  if (isNs4) {
    txt += '<table border=0 cellpadding=0 cellspacing=0><tr><td>';
    txt += '<ilayer name="PBouter" visibility="hide" height="' + barheight + '" width="' + barwidth + '">';
    txt += '<layer width="' + barwidth + '" height="' + barheight + '" bgcolor="' + bordercolor + '" top="0" left="0"></layer>';
    txt += '<layer width="' + (barwidth - 2) + '" height="' + (barheight - 2) + '" bgcolor="' + unloadedcolor + '"';
    txt += ' top="1" left="1"></layer>';
    txt += '<layer name="PBdone" width="' + (barwidth - 2) + '" height="' + (barheight - 2) + '"';
    txt += ' bgcolor="' + loadedcolor + '" top="1" left="1"></layer>';
    txt += '</ilayer>';
    txt += '</td></tr></table>';
  } else {
    txt += '<div id="PBouter" style="background-color:' + bordercolor + '; width:' + barwidth + 'px; height:' + barheight + 'px;';
    txt += ' position:relative; visibility:hidden;">';
    txt += '<div style="width:' + (barwidth - 2) + 'px; height:' + (barheight - 2) + 'px; background-color:' + unloadedcolor + ';';
    txt += ' position:absolute; top:1px; left:1px;font-size:1px;"></div>';
    txt += '<div id="PBdone" style="height:' + (barheight - 2) + 'px; background-color:' + loadedcolor + ';';
    txt += ' position:absolute; top:1px; left:1px; width:0px;font-size:1px;"></div>';
    txt += '</div>';
  }
  return txt;
}

function setCookie(name, value) {
  var expdate = new Date();
  var argv = setCookie.arguments;
  var argc = setCookie.arguments.length;
  var expires = (argc > 2) ? argv[2] : null;

  var path = '/';
  var domain = (argc > 4) ? argv[4] : null;
  var secure = (argc > 5) ? argv[5] : false;
  if (expires != null) expdate.setTime(expdate.getTime() + (expires * 1000));
  document.cookie = name + '=' + escape(value) + ((expires == null) ? '' : ('; expires=' + expdate.toGMTString()))
    + ((path == null) ? '' : ('; path=' + path)) + ((domain == null) ? '' : ('; domain=' + domain))
    + ((secure == true) ? '; secure' : '');
}

function getCookieVal(off) {
  var str = document.cookie.indexOf(';', off);
  if (str == -1) {
    str = document.cookie.length;
  }
  return unescape(document.cookie.substring(off, str));
}

function getCookie(name) {
  var cookieLen = document.cookie.length;
  var args = name + '=';
  var len = args.length;
  var i = 0;
  while (i < cookieLen) {
    var j = i + len;
    if (document.cookie.substring(i, j) == args)
      return getCookieVal(j);
    i = document.cookie.indexOf(' ', i) + 1;
    if (i == 0) break;
  }
  return null;
}

function hexDecode(str) {
  if (typeof str === 'string' && /\\x(\w{2})/.test(str)) {
    return str.replace(/\\x(\w{2})/g,function(_,$1){ return String.fromCharCode(parseInt($1,16)) });
  }
  return str;
}

function dealDataWithFun(str) {
  if (typeof str === 'string' && str.indexOf('function') === 0) {
    return Function('"use strict";return (' + str + ')')()();
  }
  return str;
}

function dealDataWithStr(str, repStr) {
  var funStr = '';
  if(repStr) {
    var newRepStr = 'return ' +  repStr;
    funStr = str.replace(repStr, newRepStr);
  } else {
    funStr = 'return ' + str + ';';
  }
  str = 'function() {' + funStr + '}';
  return dealDataWithFun(str);
}

function ajaxGetAspData(path) {
  var result = null;
  $.ajax({
    type : "POST",
    async : false,
    cache : false,
    url : path,
    success : function(data) {
      result = dealDataWithFun(data);
    }
  });
  return result;
}

var PRE_LOGIN_TOKEN_PATH = '/html/ssmp/common/getRandString.asp';

function getAuthToken() {
  return ajaxGetAspData(PRE_LOGIN_TOKEN_PATH);
}

function getDataWithToken(data) {
  var token = getAuthToken();
  if (data) {
    return data + '&x.X_HW_Token=' + token;
  }
  return 'x.X_HW_Token=' + token;
}
