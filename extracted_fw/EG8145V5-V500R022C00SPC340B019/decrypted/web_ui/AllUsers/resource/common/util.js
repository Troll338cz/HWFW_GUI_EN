UpgradeFlag = 0;

function SetDivValue(Id, Value)
{
	 try
	 {
		 var Div = document.getElementById(Id);
		 Div.innerHTML = Value;
	 }
	 catch(ex){
	 }
}
function GetDescFormArrayById(Language,Name)
{
	return (Language[Name] == null || Language[Name] == "undefined") ? "" : Language[Name];
}

function TranslateStrBySonetFlag(str, flag)
{
	var ret = str;
	if (flag != null && parseInt(flag, 10) == 1)
	{
		if (ret.match(/huawei[ ]?/ig) != null)
		{
			if (ret.match(/\bAll rights reserved\b/ig) == null)
				ret = ret.replace(/huawei[ ]?/ig, '');
		}

		if (ret.match(/\bONT\b/g) != null)
		{
			ret = ret.replace(/\bONT\b/g, "ONU");
		}
	}
	return ret;
}

function TranslateStrBySingtelFlag(str, flag)
{
	var ret = str;
	if (flag != null && parseInt(flag, 10) == 1)
	{
		if (ret.match(/\bONT\b/g) != null)
		{
			ret = ret.replace(/\bONT\b/g, "ONR");
		}
	}
	return ret;
}

function htmlencode(s) {
	var div = document.createElement('div');  
	div.appendChild(document.createTextNode(s));
	var innerHTMLcode = div.innerHTML;
	innerHTMLcode = innerHTMLcode.toString().replace(/\"/g,"&quot;");
	innerHTMLcode = innerHTMLcode.toString().replace(/\'/g, "&#39;");
	innerHTMLcode = innerHTMLcode.toString().replace(/\(/g, "&#40;");
	innerHTMLcode = innerHTMLcode.toString().replace(/\)/g, "&#41;");
	
	return innerHTMLcode;  
}

function ParseBindTextByTagName(LanguageArray, TagName, TagType, sonetflag, singtelflag)
{
	var all = document.getElementsByTagName(TagName);
	for (var i = 0; i < all.length; i++)
	{
		var b = all[i];
		var c = b.getAttribute("BindText");
		var str = GetDescFormArrayById(LanguageArray, c);
		if(c == null)
		{
			continue;
		}

		str = TranslateStrBySonetFlag(str, sonetflag);
		str = TranslateStrBySingtelFlag(str, singtelflag);

		if (1 == TagType)
		{
			b.innerHTML = str;
		}
		else if(2 == TagType)
		{
			b.value = str;
		}
	}
}

function isSafeCharSN(val)
{
	if ( ( val == '<' )
	  || ( val == '>' )
	  || ( val == '\'' )
	  || ( val == '\"' )
	  || ( val == ' ' )
	  || ( val == '%' )
	  || ( val == '#' )
	  || ( val == '{' )
	  || ( val == '}' )
	  || ( val == '\\' )
	  || ( val == '|' )
	  || ( val == '^' )
	  || ( val == '[' )
	  || ( val == ']' ) )
	{
		return false;
	}

	return true;
}

function isSafeStringSN(str)
{
  if (str == "") {
    return false;
  }

  for (var i = 0; i < str.length; i++) {
    if (!isSafeCharSN(str.charAt(i))) {
      return false;
    }
  }

  return true;
}

function isSafeChar(value, supportBrackets)
{
  if ((value == '<') || (value == '>') || (value == '\'') || (value == '\"') || (value == ' ') || (value == '%') ||
    (value == '#') || (value == '{') || (value == '}') || (value == '\\') || (value == '|') || (value == '^') ||
    ((value == '[') && (supportBrackets == 0)) || ((value == ']') && (supportBrackets == 0))) {
    return false;
  }

  return true;
}

function isSafeString(value, supportBrackets)
{
  if (value == "") {
    return false;
  }

  for (var i = 0; i < value.length; i++) {
    if (!isSafeChar(value.charAt(i), supportBrackets)) {
      return false;
    }
  }

  return true;
}

function isValidAscii(value)
{
    var ret = '';
    for (var i = 0 ; i < value.length; i++) {
        var ch = value.charAt(i);
        if ((ch < ' ') || ( ch > '~')) {
            ret += ch;
        }
    }

    return ret;
}

function isValidCfgStr(cfgName, value, maxLen)
{
  if (isValidAscii(value) != '') {
    alert(cfgName + ' has invalid character "' + isValidAscii(value) + '".')
    return false;
  }

  if (value.length > maxLen) {
    alert(cfgName + ' cannot exceed ' + maxLen  + ' characters.');
    return false;
  }
}

function isHexaDigit(ch)
{
  var hexList = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "A", "B", "C", "D", "E", "F", "a", "b", "c", "d", "e", "f");

  for (var i = 0; i < hexList.length; i++) {
    if (ch == hexList[i]) {
      return true;
    };
  }

  return false;
}

function last8isHexaNumber(number)
{
  for (var index = 4; index < number.length; index++) {
    if (isHexaDigit(number.charAt(index)) == false) {
      return false;
    }
  }

  return true;
}

function isSafeStringExc(compareStr, unsafeStr)
{
  for (var i = 0; i < compareStr.length; i++) {
    var ch = compareStr.charAt(i);
    if (isValidAscii(ch) != '') {
      return false;
    }

	if (unsafeStr.indexOf(ch) > -1) {
	  return false;
    }
  }

  return true;
}

function isSafeStringIn(compareStr, unsafeStr)
{
  for (var i = 0; i < compareStr.length; i++) {
    var ch = compareStr.charAt(i);
    if (isValidAscii(ch) != '') {
      return false;
    }

    if (unsafeStr.indexOf(ch) == -1) {
      return false;
    }
  }

  return true;
}

function IsSameSubnet(lip, rip)
{
  var laddrParts = lip.split('.');
  var raddrParts = rip.split('.');

  for(var i=0; i < 3; i++) {
    if(parseInt(laddrParts[i], 10) != parseInt(raddrParts[i], 10)) {
      return false;
    }
  }

  return true;
}

function isValidName(name)
{
   return isSafeStringExc(name,'"<>%\\^[]`\+\$\,=\'#&: \t');
}

function isValidString(name)
{
   return isSafeStringExc(name,'"\\');
}

function isInteger(val)
{
  if (/^(\+|-)?\d+$/.test(val)) {
    return true;
  }

  return false;
}

function isPlusInteger(val)
{
  if (isInteger(val) && (parseInt(val) >= 0)) {
   return true;
  }

  return false;
}

function isFloat(val)
{
  if (/^(\+|-)?\d+($|\.\d+$)/.test(val)) {
    return true;
  }

  return false;
}

function CheckNumber(Value, MinRange, MaxRange)
{
  if ((Value.length > 1) && (Value.charAt(0) == '0')) {
    return false;
  }

  if (isInteger(Value) == false) {
    return false;
  }

  var t = parseInt(Value, 10);
  if (isNaN(t) == true) {
    return false;
  }

  if ((t < MinRange) || (t > MaxRange)) {
    return false;
  }

  return true;
}

function CheckNumberHex(Value, MinRange, MaxRange)
{
  var i = 0;

  if (Value.length > 5) {
    return false;
  }

  for (i = 0; i < Value.length; i++) {
    if (isHexaDigit(Value.charAt(i)) == false) {
      return false;
    }
  }

  var t = parseInt(Value, 16);
  if ((t < MinRange) || (t > MaxRange)) {
    return false;
  }

  return true;
}

function isValidCfgInteger(cfgName, val, start, end)
{
	   if (isInteger(val) == false)
	   {
		   alert(cfgName + ' is invalid, it must be digist.');
		   return false;
	   }
	   var temp = parseInt(val);
	   if (temp < start || temp > end)
	   {
		   alert(cfgName + ' must be greater than ' + start.toString()
				 + ' and less than ' + end.toString() + '.');
		   return false;
	   }
}

function isEndGTEStart(EndIp, StartIp)
{
	addrEnd = EndIp.split('.');
	addrStart = StartIp.split('.');
	E = parseInt(addrEnd[2],10) + 1;
	S = parseInt(addrStart[2],10) + 1;
	if (S < E) {
		return true;
	} else if (E < S) {
		return false;
	}
	
	E = parseInt(addrEnd[3],10) + 1;
	S = parseInt(addrStart[3],10) + 1;
	if (E < S)
		return false;
	return true;
}

function IpCompare(Ip1, Ip2, Ip3, Mask1)
{
   lan1a = Ip1.split('.');
   lan2a = Ip2.split('.');
   lan1m = Mask1.split('.');

	  l1a_n = parseInt(lan1a[3]);
	  l2a_n = parseInt(lan2a[3]);
	  l1m_n = parseInt(lan1m[3]);

	  if (((l1a_n & l1m_n) ? (l1a_n & l1m_n) : l1a_n) > (Ip3)
		  ||(Ip3) > ((l2a_n & l1m_n) ? (l2a_n & l1m_n) : l2a_n))
	  {
		return false;
	  }
   return true;
}

function isValidIpAddress(ipAddr)
{
  if ((ipAddr == '0.0.0.0') || (ipAddr == '255.255.255.255')) {	
    return false;
  }

  var ipParts = ipAddr.split('.');
  if (ipParts.length != 4) {
   return false;
  }

  for (var i = 0; i < 4; i++) {
    if (isNaN(ipParts[i]) || (ipParts[i] == "") ||
      (ipParts[i].charAt(0) == '+') ||  (ipParts[i].charAt(0) == '-')){
      return false;
    }

    if ((ipParts[i].length > 3) || (ipParts[i].length < 1)) {
      return false;
    }
  
    if ((ipParts[i].length > 1) && (ipParts[i].charAt(0) == '0')) {
      return false;
    }

    if (!isInteger(ipParts[i]) || (ipParts[i] < 0)) {
      return false;
    }

    var intVal = parseInt(ipParts[i]);
    if ((i == 0) && (intVal == 0)) {
      return false;
    }
  
    if ((intVal < 0) || (intVal > 255)) {
      return false;
    }
  }

  return true;
}

function isBroadcastIp(ipAddr, subnetMask)
{
  var maskLen = 0;
  maskParts = subnetMask.split('.');
  ipParts = ipAddr.split('.');

  if((parseInt(ipParts[0]) > 223) || (parseInt(ipParts[0]) == 127)) {
    return true;
  }

  for (maskLen = 0; maskLen < 4; maskLen++) {
    if(parseInt(maskParts[maskLen]) < 255) {
      break;
    }
  }

  tmpNum0 = parseInt(ipParts[maskLen]);
  tmpNum1 = 255 - parseInt(maskParts[maskLen]);
  tmpNum2 = tmpNum0 & tmpNum1;

  if((tmpNum2 != 0) && (tmpNum2 != tmpNum1)) {
    return false;
  }

  if(maskLen == 3) {
    return true;
  } else if(maskLen == 2) {
    if(((ipParts[3] == 0) && (tmpNum2 == 0)) ||
      ((ipParts[3] == 255)&&(tmpNum2 == tmpNum1))) {
      return true;
    }
  } else if(maskLen == 1) {
    if(((tmpNum2 == 0) && (ipParts[3] == 0) && (ipParts[2] == 0)) ||
      ((tmpNum2 == tmpNum1) && (ipParts[3] == 255) && (ipParts[2] == 255))) {
      return true;
    }
  } else if(maskLen == 0) {
    if(((tmpNum2 == 0) && (ipParts[3] == 0) && (ipParts[2] == 0) && (ipParts[1] == 0)) ||
      ((tmpNum2 == tmpNum1)&&(ipParts[3] == 255)&&(ipParts[2] == 255) &&(ipParts[1] == 255))) {
      return true;
    }
  }

  return false;
}

function isAbcIpAddress(ipAddr)
{
  if (isValidIpAddress(ipAddr) == false) {
    return false;
  }

  var ipParts = ipAddr.split('.');
  var intVal = parseInt(ipParts[0]);
  if ((intVal < 1) || (intVal >= 224) || (intVal == 127)) {
    return false;
  }

  return true;
}

function isHostIpWithSubnetMask(ipAddr, subnet)
{
  if (isAbcIpAddress(ipAddr) == false) {
    return false;
  }

  if (isValidSubnetMask(subnet) == false) {
    return false;
  }

  var decAddr = IpAddress2DecNum(ipAddr);
  var decMask = SubnetAddress2DecNum(subnet);
  if ((decAddr & (~decMask)) == 0) {
    return false;
  }

  if (isBroadcastIp(ipAddr, subnet) == true) {
    return false;
  }

  return true;
}

function isDeIpAddress(ipAddr)
{
  if (isValidIpAddress(ipAddr) == false) {
    return false;
  }

  var ipParts = ipAddr.split('.');
  if (ipParts.length != 4) {
    return false;
  }

  if (!isInteger(ipParts[0]) || (ipParts[0] < 0) ) {
    return false;
  }

  var intVal = parseInt(ipParts[0]);
  if (!((intVal >= 224) && (intVal <= 247))) {
    return false;
  }

  for (var i = 1; i <= 3; i++) {
    if (!isInteger(ipParts[i]) || ipParts[i] < 0) {
      return false;
    }

    intVal = parseInt(ipParts[i]);
    if (!((intVal >= 0) && (intVal <= 255))) {
      return false;
    }
  }
 
  return true;
}

function isBroadcastIpAddress(ipAddr)
{
  if (!isValidIpAddress(ipAddr)) {
    return false;
  }

  var ipParts = ipAddr.split('.');
  if (ipParts[3] == '255') {
    return true;
  }

  return false;
}

function isLoopIpAddress(ipAddr)
{
  if (!isValidIpAddress(ipAddr)) {
    return false;
  }

  if (ipAddr.split('.')[0] == '127') {
    return true;
  }

  return false;
}

function getLeftMostZeroBitPos(val)
{
  var numList = [128, 64, 32, 16, 8, 4, 2, 1];

  for (var i = 0; i < numList.length; i++) {
    if ((val & numList[i]) == 0){
      return i;
    }
  }

  return numList.length;
}

function getRightMostOneBitPos(val)
{
  var numList = [1, 2, 4, 8, 16, 32, 64, 128];

  for (var i = 0; i < numList.length; i++) {
    if (((val & numList[i]) >> i) == 1) {
      return (numList.length - i - 1);
    }
  }

  return -1;
}

function maskIsAllZero(mask)
{
	if ( mask.charAt(0) == '0' && mask.charAt(0) == ':' )
	  return true;
}

function getV6AddrLeftMostZeroBitPos(val)
{
  var numArr = [0x8000, 0x4000, 0x2000, 0x1000, 0x800, 0x400, 0x200, 0x100, 0x80, 0x40, 0x20, 0x10, 8, 4, 2, 1];

  for (var i = 0; i < numArr.length; i++) {
    if ((val & numArr[i]) == 0) {
      return i;
    }
  }

  return numArr.length;
}

function getV6AddrRightMostOneBitPos(val)
{
  var numArr = [1, 2, 4, 8, 0x10, 0x20, 0x40, 0x80, 0x100, 0x200, 0x400, 0x800, 0x1000, 0x2000, 0x4000, 0x8000];

  for (i = 0; i < numArr.length; i++) {
    if (((val & numArr[i]) >> i) == 1) {
      return (numArr.length - i - 1);
    }
  }

  return -1;
}

function isValidSubnetMask(subnetMask)
{
  var zeroBitLoc = 0, oneBitLoc = 0;
  var zeroBitExisted = false;

  if (subnetMask == '0.0.0.0') {
    return false;
  }

  var maskParts = subnetMask.split('.');
  if (maskParts.length != 4) {
    return false;
  }

  for (var i = 0; i < 4; i++) {
    if ((isNaN(maskParts[i]) == true) || (maskParts[i] == "") ||
      (maskParts[i].charAt(0) == '+') || (maskParts[i].charAt(0) == '-')) {
        return false;
    }

    if (!isInteger(maskParts[i]) || ( maskParts[i] < 0)) {
      return false;
    }

    var intVal = parseInt(maskParts[i]);
    if ((intVal < 0) || (intVal > 255)) {
      return false;
    }

    if ((zeroBitExisted == true) && (intVal != 0)) {
      return false;
    }

    zeroBitLoc = getLeftMostZeroBitPos(intVal);
    oneBitLoc = getRightMostOneBitPos(intVal);
    if (zeroBitLoc < oneBitLoc) {
      return false;
    }

    if (zeroBitLoc < 8) {
      zeroBitExisted = true;
    }
  }

  return true;
}

function isValidIPV6SubnetMask(mask)
{
   var i = 0, num = 0;
   var zeroBitPos = 0, oneBitPos = 0;
   var zeroBitExisted = false;

   if (maskIsAllZero(mask))
   {
		return false;
   }

   var shortMaskParts = mask.split('::');

   if (shortMaskParts.length >= 3)
   {
	   return false;
   }

   if (shortMaskParts.length == 2)
   {
	   if (shortMaskParts[1] != '')
	   {
		   return false;
	   }
	   var maskParts = shortMaskParts[0].split(':');
	   if (maskParts.length >= 8)
	   {
		   return false;
	   }
   }
   else if (shortMaskParts.length == 1)
   {
	   var maskParts = shortMaskParts[0].split(':');
	   if (maskParts.length != 8)
	   {
		   return false;
	   }
   }
   for (i = 0; i < maskParts.length; i++)
   {
	  if (false ==  IsIPv6AddressUshortValid(maskParts[i]))
	  {
		 return false;
	  }
	  num = parseInt(maskParts[i], 16);

	  if ( num < 0 || num > 65535 )
		 return false;
	  if ( zeroBitExisted == true && num != 0 )
		 return false;
	  zeroBitPos = getV6AddrLeftMostZeroBitPos(num);
	  oneBitPos = getV6AddrRightMostOneBitPos(num);

	  if ( zeroBitPos < oneBitPos )
		 return false;
	  if ( zeroBitPos < 16 )
		 zeroBitExisted = true;
   }
	return true;
}

function isValidPort(port)
{
  if (!isInteger(port)) {
    return false;
  }

  if ((port < 1) || (port > 65535)) {
    return false;
  }

  return true;
}

function isValidPort2(port)
{
  if (!isInteger(port) || (port < 1) || (port > 65535)) {
    if (port == 0) {
      return true;
    }

    return false;
  }

  return true;
}

function isValidPortPair(startPort, endPort)
{
  if (!isValidPort(startPort) || !isValidPort(endPort)) {
    return false;
  }

  if (parseInt(startPort) <= parseInt(endPort)) {
    return false;  
  }

  return true;  
}

function isMulticastMacAddress(address)
{
  var addrParts = address.split(':');
  if ((addrParts[0] == '01') && (addrParts[1] == '00') && (addrParts[2] == '5e')) {
    return false;
  }

  return true;
}

function standIpv6Address(StrAddr)
{
	var i,j,k = 8;
	var addr = ['0','0','0','0','0','0','0','0'];
	var aAddr = StrAddr.split(":");
	var len = aAddr.length;

	if (len == 8)
	{
		return aAddr;
	}

	for (i = 0; i < len; i++)
	{
		if (aAddr[i] != '')
		{
			addr[i] = aAddr[i];
		}
		else
		{
			break;
		}
	}

	for (j = len - 1; j > 0; j--)
	{
		if (aAddr[j] != '')
		{
		   addr[k - 1] = aAddr[j];
		   k--;
		}
		else
		{
			break;
		}
	}

	return addr;
}

function isStartIpbigerEndIp(Startaddress,Endaddress)
{
  var startaddress = standIpv6Address(Startaddress);
  var endaddress = standIpv6Address(Endaddress);

  for (var i = 0; i < 8; i++) {
    if (parseInt(startaddress[i],16) < parseInt(endaddress[i],16)) {
      return false;
    } else if (parseInt(startaddress[i],16) > parseInt(endaddress[i],16)) {
      return true;
    }
  }

  return false;
}

function isStartIpSameEndIp(Startaddress,Endaddress)
{
	var i = 0;

	var startaddress = standIpv6Address(Startaddress);
	var endaddress   = standIpv6Address(Endaddress);

	for (i = 0; i < 8; i++)
	{
		if (parseInt(startaddress[i],16) != parseInt(endaddress[i],16))
		{
			return false;
		}
	}
	return true;
}

function isValidMacAddress(ipAddr)
{
  if (ipAddr.toLowerCase() == 'ff:ff:ff:ff:ff:ff') {
    return false;
  }

  if (ipAddr.toLowerCase() == '00:00:00:00:00:00') {
    return false;
  }

  var ipParts = ipAddr.split(':');
  if (ipParts.length != 6) {
    return false;
  }

  for (var i = 0; i < 6; i++) {
    if (ipParts[i] == '') {
      return false;
    }

    if ( ipParts[i].length != 2) {
      return false;
    }

    var ch = '';
    for (var j = 0; j < ipParts[i].length; j++) {
      ch = ipParts[i].toLowerCase().charAt(j);
      if (((ch >= '0') && (ch <= '9')) || ((ch >= 'a') && (ch <= 'f'))) {
        continue;
      } else {
        return false;
      }
    }
  }

  return true;
}

function isValidMacAddress1(address)
{
  return isValidMacAddress(address);
}


function isNtwkSgmtIpAddress(ipAddr)
{
  if (!isValidIpAddress(ipAddr)) {
    return false;
  }

  if (ipAddr.split('.')[3] == '0') {
    return true;
  }

  return false;
}

function isSameSubNet(ipAddr1, mask1, ipAddr2, mask2)
{
  var ip1Parts = ipAddr1.split('.');
  var mask1Parts = mask1.split('.');
  var ip2Parts = ipAddr2.split('.');
  var mask2Parts = mask2.split('.');

  for (var i = 0; i < 4; i++) {
    var ip1Part = parseInt(ip1Parts[i]);
    var mask1Part = parseInt(mask1Parts[i]);
    var ip2Part = parseInt(ip2Parts[i]);
    var mask2Part = parseInt(mask2Parts[i]);
    if ((ip1Part & mask1Part) != (ip2Part & mask2Part)) {
      return false;
    }
  }
  return true;
}

function checkSpace(str)
{
  var len=str.length;

  if (len == 0) {
    return false;
  }

  if (str.charAt(0) == ' ') {
    return false;
  }

  if (str.charAt(len - 1) == ' ') {
    return false;
  }

  return true;
}

function CheckUrlParameter(inputUrl)
{
	if(checkSpace(inputUrl)==false)
	{
	  return false;
	}

	if(inputUrl.indexOf('http://')!=-1)
	{
		if(inputUrl.indexOf('http://')!=0)
		{
			return false;
		}
		if(inputUrl=="http://")
		{
			return false;
		}
		inputUrl=inputUrl.substring(7);
	}
	if(inputUrl.indexOf('/')==0)
	{
		return false;
	}
	var CutUrl=inputUrl.split('/');
	var Domine=CutUrl[0];
	var ports=Domine.split(':');
	var len=ports.length;
	if(ports.length>1)
	{
		if((parseInt(ports[len-1],10)>0&&parseInt(ports[len-1],10)<65536)==false)
		{
			return false;
		}
		Domine=Domine.substring(0,(Domine.length)-1-ports[len-1].length);
	}

	var i=0;
	var adds=Domine.split('.');
	if(adds[0]=='0'&&adds.length==4)
	{
		var isip=1;
		for(var key=1;key<=3;key++)
		{
			if(adds[key]<=255 && adds[key]>=0)
			{
				continue;
			}
			else
			{
				isip=0;
				break;
			}
		}
		if(isip==1)
		{
			return false;
		}
	}
	while(Domine.indexOf(" ")==0)
	{
		Domine=Domine.substring(1);
	}
	if(Domine=='0.0.0.0'||Domine=='255.255.255.255')
	{
		return false;
	}
	if ((isValidIpAddress(Domine) == true))
	{
		var addrs=Domine.split('.');
		if(parseInt(addrs[0],10)>=224)
		{
			return false;
		}
		if(Domine=='127.0.0.1')
		{
			return false;
		}
		if(addrs[3]=='0')
		{
			return false;
		}
	}
	return true;

}

function isNum(str)
{
	var valid=/[0-9]/;
	var i;
	for(i=0; i<str.length; i++)
	{
		if(false == valid.test(str.charAt(i)))
		{
			return false;
		}
	}
	return true;
}

function isNull( str )
{
	if ( str == "" ) return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}

function IsUrlValid(_Url)
{
	if(true == isNull(_Url))
	{
		return false;
	}
	var Url = new String(_Url.toLocaleLowerCase().replace("http://",""));
	var ExitColon = false;
	var ColonLocation = 0;
	var ColorReg = new RegExp(".*[a-zA-Z0-9]+:[0-9]+/*");

	var ArrayOfUrl = Url.split("//");

	if(ArrayOfUrl[0].toUpperCase() == "FTP:" || ArrayOfUrl[0].toUpperCase() == "HTTPS:")
	{
		return false;
	}
	if (ArrayOfUrl.length >= 2)
	{
		Url = ArrayOfUrl[1];
	}

	if (Url.length == 0)
	{
		return false;
	}

	ColonLocation = Url.indexOf(":", 0);
	if (ColonLocation == 0)
	{
		return false;
	}

	ExitColon = ColonLocation > 0 ? true : false;

	if (ExitColon == false)
	{
		return true;
	}

	return ColorReg.test(Url);
}

function IpAddress2DecNum(ipAddr)
{
  if (isValidIpAddress(ipAddr) == false) {
  	return -1;
  }

  var ipParts = ipAddr.split('.');
  var decNum = 0;
  for (var i = 0; i < 4; i++) {
    decNum += parseInt(ipParts[i]) * Math.pow(256, 3 - i);
  }

  return decNum;
}

function SubnetAddress2DecNum(address)
{
	if (isValidSubnetMask(address) == false)
	{
		return -1;
	}
	var addrParts = address.split('.');
	var num = 0;
	for (i = 0; i < 4; i++)
	{
		num += parseInt(addrParts[i]) * Math.pow(256, 3 - i);
	}
	return num;
}

function MacAddress2DecNum(address)
{
	if (isValidMacAddress(address) == false)
	{
		return -1;
	}
	var addrParts = address.split(':');
	var num = 0;
	for (i = 0; i < 6; i++)
	{
		num += parseInt(addrParts[i],16) * Math.pow(256, 5 - i);
	}
	return num;
}

function getElById(sId)
{
	return getElement(sId);
}

function getElementById(id)
{
  if (document.getElementById) {
    return document.getElementById((id));
  } else if (document.all) {
    return document.all((id));
  } else if (document.layers) {
    return document.layers[(id)];
  } else {
    return null;
  }
}

function getElementByName(id)
{
  if (document.getElementsByName) {
    var ele = document.getElementsByName(id);

    if (ele.length == 0) {
      return null;
    } else if (ele.length == 1) {
      return ele[0];
    }

    return ele;
  }
}

function getElement(id)
{
  var element = getElementByName(id);
  if (element == null) {
    return getElementById(id);
  }
  return element;
}

function getOptionIndex(id, value)
{
  var elementObj = getElement(id);
  if (elementObj == null)	{
    return -1;
  }

  for (var i = 0; i < elementObj.length; i++) {
    if (elementObj.options[i].value == value) {
      return i;
    }
  }

  return -1;
}

function getValue(id)
{
  var element = getElement(id);
  if (element == null) {
    return -1;
  }

  return element.value;
}

function setDisplay(id, sh)
{
  var status = (sh > 0) ? "" : "none";

  var element = getElement(id);
  if (element != null) {
  	getElement(id).style.display = status;
  }
}

function setVisible(id, sh)
{
  var status = (sh > 0) ? "visible" : "hidden";

  var element = getElement(id);
  if (element != null) {
    getElement(id).style.visibility = status;
  }
}

function setElementInnerHtmlById(sId, sValue)
{
	document.getElementById(sId).innerHTML = htmlencode(sValue);
}

function setElementInnerHtml(sId, sValue)
{
	getElement(sId).innerHTML = htmlencode(sValue);
}

function setElementInnerHtmlByObj(obj, sValue)
{
	obj.innerHTML = htmlencode(sValue);
}

function setObjNoEncodeInnerHtmlValue(obj, sValue)
{
	obj.innerHTML = sValue;
}

function setNoEncodeInnerHtmlValue(sId, sValue)
{
	getElement(sId).innerHTML = sValue;
}

function setSelect(id, value)
{
  var element = getElement(id);
  if (element == null) {
    return false;
  }

  for (var i = 0; i < element.options.length; i++) {
    if (element.options[i].value == value) {
      element.selectedIndex = i;
      return true;
    }
  }

  return false;
}

function setText(id, value)
{
  var element = getElement(id);
  if (element == null) {
    return false;
  }

  element.value = value;
  return true;
}

function setCheck(id, value) {
  var element = getElement(id);
  if (element == null) {
    return false;
  }

  element.checked = (value == '1') ? true : false;

  return true;
}

function setRadio(id, value) {
  var element = getElement(id);
  if (element == null) {
    return false;
  }

  for (var i = 0; i < element.length; i++) {
    if (element[i].value == value) {
      element[i].checked = true;
      return true;
  	}
  }

  return false;
}  

function getDivInnerId(divID) {
  var nameStartPos = -1;
  var nameEndPos = -1;
  divHTML = getElement(divID).innerHTML;
  nameStartPos = divHTML.indexOf('name=');
  nameEndPos = divHTML.indexOf(' ', nameStartPos);

  if(nameEndPos <= 0) {
    nameEndPos = divHTML.indexOf('>', nameStartPos);
  }

  var ele = divHTML.substring(nameStartPos+3, nameEndPos);
  return ele;
}

function setDisable(id, flag) {
  var element = getElement(id);
  if (element == null) {
    return false;
  }

  if (typeof(element.disabled) == 'undefined') {
    if (element.tagName == 'DIV' || element.tagName == 'div') {
      var ele = getDivInnerId(id);
      setDisable(ele, flag);
    }
  } else {
    if (flag == 1) {
      addClass(id, "osgidisable");
      element.disabled = true;
    } else {
      removeClass(id, "osgidisable");
      element.disabled = false;
    }
  }

  return true;
}

function getCheckVal(id) {
  var element = getElement(id);
  if (element == null) {
    return -1;
  }

  return element.checked ? 1 : 0;
}

function getRadioVal(id) {
  var element = getElement(id);
  if (element == null) {
    return -1;
  }

  for (i = 0; i < element.length; i++) {
    if (element[i].checked == true) {
      return element[i].value;
    }
  }

  return -1;
}

function getSelectVal(sId)
{
   return getValue(sId);
}

function addOption(id, optionName, optionValue, optionText)
{
  var para = document.createElement("option");
  para.setAttribute('name', optionName);
  para.setAttribute('value', optionValue);
  para.innerHTML = optionText;

  var element = getElement(id);
  if (element != null) {
  	element.appendChild(para);
  	return para;
  }
  return null;
}

function removeOption(id, value)
{
  var element = getElement(id);
  if (element != null) {
    var index = getOptionIndex(id,value);
    if (index >= 0) {
      element.removeChild(element.options[index]);
      return true;
    }
    return false;
  }
  return false;
}

function removeAllOption(id)
{
  var element = getElement(id);
  if (element != null) {
    element.length = 0;
    return true;
  }
  return false;
}

var addForm = function(sFormName,domainNamePrefix) {
  this.setPrefix(domainNamePrefix);
  var srcForm = getElement(sFormName);
  if (srcForm != null && srcForm.length > 0 
    && this.oForm != null && srcForm.style.display != 'none') {
    makeCheckBoxValue(srcForm);
    for(var i=0; i < srcForm.elements.length; i++) { 
      var type = srcForm.elements[i].type;
      if (type != 'button' && srcForm.elements[i].disabled == false) {
        var prefix = (this.domainNamePrefix != '.')? this.domainNamePrefix : '';
        var ele = this.createNewFormElement(prefix + srcForm.elements[i].name, srcForm.elements[i].value);
        this.oForm.appendChild(ele);
      }
    }
  } else {
    this.status = false;
  }
  this.domainNamePrefix = '.';
};

var addDiv = function(sDivName, prefix) {
  prefix = (prefix == null)? '': prefix + '.';

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
        this.addParameter(prefix + eleInput[k].name,eleInput[k].value);
      }
    }
  }
};

var addParameter = function(sName, sValue) {
  var domainName = this.getDomainName(sName);
  var j = 0;
  for(j = 0; j < this.oForm.elements.length; j++) {
    if(this.oForm.elements[j].name == domainName) {
      this.oForm.elements[j].disabled = false;
      this.oForm.elements[j].value = sValue;
      return;
    }
  }
  
  if(j == this.oForm.elements.length) {
    var ele = this.createNewFormElement(domainName,sValue);
    this.oForm.appendChild(ele);
  }
};

var disableElement = function(sName) {
  var domainName = this.getDomainName(sName);
  for(var i = 0; i < this.oForm.elements.length; i++) {
    if(this.oForm.elements[i].name == domainName) {
      this.oForm.elements[i].disabled = true;
      return;
    }
  }
};

var submit = function(sURL, sMethod) {
  if( sURL != null && sURL != '' ) this.setAction(sURL);
  if( sMethod != null && sMethod != '' ) this.setMethod(sMethod);
  if (this.status == true) this.oForm.submit();
};

var getNewSubmitForm = function() {
  var submitForm = document.createElement('FORM');
  document.body.appendChild(submitForm);
  submitForm.method = 'POST';
  return submitForm;
};

var createNewFormElement = function(elementName, elementValue) {
  var newElement = document.createElement('INPUT');
  newElement.setAttribute('name',elementName);
  newElement.setAttribute('value',elementValue);
  newElement.setAttribute('type','hidden');
  return newElement;
};

var webSubmitForm = function(sFormName, domainNamePrefix) {
  this.setPrefix = function(Prefix) {
    this.domainNamePrefix = (Prefix == null) ? '.' : (Prefix + '.');
  };

  this.getDomainName = function(sName) {
    return (this.domainNamePrefix == '.')? sName : (this.domainNamePrefix + sName);
  };

  this.getNewSubmitForm = getNewSubmitForm;
  this.createNewFormElement = createNewFormElement;
  this.addForm = addForm;
  this.addDiv = addDiv;
  this.addParameter = addParameter;
  this.disableElement = disableElement;

  this.usingPrefix = function(prefix){
    this.domainNamePrefix = prefix + '.';
  };

  this.endPrefix = function(){
    this.domainNamePrefix = '.';
  };

  this.setMethod = function(sMethod) {
    this.oForm.method = (sMethod.toUpperCase() == 'GET')? 'GET' : 'POST';
  };

  this.setAction = function(sUrl) {
    this.oForm.action = sUrl;
  };
  
  this.setTarget = function(sTarget) {
    this.oForm.target = sTarget;
  };

  this.submit = submit;
  this.status = true;
  this.setPrefix(domainNamePrefix);
  this.oForm = this.getNewSubmitForm();
  if (sFormName != null && sFormName != '') {
    this.addForm(sFormName,this.domainNamePrefix);
  }
}

function makeCheckBoxValue(srcForm) {
  var changeRadioPro = function(name) {
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
      checkBox.value = (checkBox.checked == true)? 1 : 0;
    } else if (inputs[i].type == 'radio') {
      changeRadioPro(inputs[i].name);
    }
  }
}
var g_redirectTimer;

function DisableRepeatSubmit()
{
}
function Submit(type)
{
	if (CheckForm(type) == true)
	{
		var Form = new webSubmitForm();
		AddSubmitParam(Form,type);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
		DisableRepeatSubmit();
	}
}

function CreateXMLHttp()
{
  var xmlReqhttp = null;
  var msVersions = ["MSXML2.XMLHttp.5.0", "MSXML2.XMLHttp.4.0", "MSXML2.XMLHttp.3.0",
    "MSXML2.XMLHttp", "Microsoft.XMLHttp"];

  if (window.XMLHttpRequest) {
    try {
      xmlReqhttp = new XMLHttpRequest();
    } catch (e) { }
  } else {
    if (window.ActiveXObject) {
      for (var i = 0; i < 5; i++) {
        try {
          xmlReqhttp = new ActiveXObject(msVersions[i]);
          return xmlReqhttp;
        } catch (e) { }
      }
    }
  }

  return xmlReqhttp;
}

function AssociateParam(dest,src,name)
{
   var destObj = dest;
   var srcObj = src;
   var nameParts = name.split('|');

   for (j = 0; j < destObj.length; j++)
   {
	  if (destObj[j] == null)
		 break;
	  for (i = 0; i < srcObj.length; i++)
	  {
		if (srcObj[i] == null)
			break;
		if (srcObj[j].key.indexOf(srcObj[i].key) > -1)
		{
			try
			{
        dest[j].Relating = src[i];
			}
			catch (e)
			{
			}
			 for (k = 0; k < nameParts.length; k++)
			{
				 if (nameParts[k] == '')
				 {
					 continue;
				 }

				 try
				 {
           dest[j][nameParts[k]] = src[i][nameParts[k]];
				 }
				 catch (e)
				 {
				 }
			}
			break;
		}
	  }
   }

}
function getBoolValue(param)
{
  var value = parseInt(param);
  if (isNaN(value) == true) {
     var lowerParam = param.toLowerCase();
     return (lowerParam == 'enable') ? 1 : 0;
  }

  return value;
}

function debug(info)
{
}

function isMaskOf24BitOrMore(mask)
{
  if(!isValidSubnetMask(mask)) {
    return false;
  }

  var maskParts = mask.split('.');
  for(var i = 0; i < 3; i++) {
    var intVal = parseInt(maskParts[i]);
    if(intVal != 255) {
      return false;  
    }
  }

  return true;
}

function ipInSubnet(ip,subnetStart,subnetEnd)
{
	var ipDec;
	var subnetStartDec;
	var subnetEndDec;

	ipDec = IpAddress2DecNum(ip);
	subnetStartDec = SubnetAddress2DecNum(subnetStart);
	subnetEndDec = SubnetAddress2DecNum(subnetEnd);
   if((ipDec >= subnetStartDec) && (ipDec <= subnetEndDec ))
	{
		return true;
	}

	return false;
}
function netmaskIsContinue(Mask)
{
	var ulmask;
	var i;
	var ulTmp = 0xffffffff;
	ulmask = SubnetAddress2DecNum(Mask);
	for (i = 0; i < 32; i++)
	{
		if (ulTmp == ulmask)
		{
			return 0;
		}

		ulTmp <<= 1 ;
	}

	return 1;
}

function getmaskLength(Mask)
{

	var ulTmp;
	var ulCount = 0;
	var ulmask;
	ulTmp = IP_NetmaskIsContinue(Mask);
	ulmask = SubnetAddress2DecNum(Mask);
	if (ulTmp)
	{
		return 0;
	}

	while (ulmask != 0)
	{
		ulmask = ulmask << 1;
		ulCount++;
	}
	return ulCount;
}

function removeSpaceTrim(inputStr)
{
   var inputStrTemp;
   var i,j = 0;

   if(inputStr == "")
   {
	  return "";
   }

   for(i=0;i<inputStr.length;i++)
	{
	   if(inputStr.charAt(i) == ' ')
	   {
		   continue;
	   }
	   else
	   {
		   break;
	   }
	}

	inputStrTemp = inputStr.substr(i,inputStr.length-i);

	if(inputStrTemp == "")
	{
	   return "";
	}

	for(i=inputStrTemp.length-1;i>=0;i--)
	{
		if(inputStrTemp.charAt(i) == ' ')
		{
			j++;
			continue;
		}
		else
		{
			break;
		}
	}

	inputStrTemp = inputStrTemp.substr(0,inputStrTemp.length-j);

	return inputStrTemp;

}


function XmlHttpSendAspFlieWithoutResponse(FileName)
{
	var xmlHttp = null;
	if(null == FileName || FileName == "")
	{
		return false;
	}
	if(window.XMLHttpRequest)
	{
		xmlHttp = new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlHttp.open("GET", FileName, false);
	xmlHttp.send(null);
}

function AlertEx(content)
{
	XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
	alert(content);
}

function ConfirmEx(content)
{
	XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
	if(confirm(content))
	{
		return true;
	}
	return false;
}

function CheckIpAddressValid(ipAddr)
{
	if ( ipAddr != '' && (isValidIpAddress(ipAddr) == false || isAbcIpAddress(ipAddr) == false))
	{
		if(IsIPv6AddressValid(ipAddr) == false)
		{
			return false;
		}
	}
	return true;
}
function CheckDomainName(domainName)
{
	if(domainName != '')
	{
		var adr  = domainName;
		var arr  = domainName.split(".");
		var i=0;
		var j=0;

		if (adr.length >= 256)
		{
			return false;
		}

		if( (adr.charAt(adr.length -1) == '.' ) || (adr.charAt(0) == '.'))
		{
			return false;
		}

		for(i=0;i<adr.length;i++)
		{
			if( ((adr.charAt(i) =='.') && (adr.charAt(i+1) =='.')))
			{
				return false;
			}
		}

		for(i=0;i<arr.length;i++)
		{
			if (arr[i].length > 63)
			{
				return false;
			}
			for(j=0;j<arr[i].length;j++)
			{
				if( !((arr[i].charAt(j)>='A' && arr[i].charAt(j)<='Z') || (arr[i].charAt(j)>='a' && arr[i].charAt(j)<='z') || (arr[i].charAt(j)>='0' && arr[i].charAt(j)<='9') || (arr[i].charAt(j)=='-')) )
				{
					return false;
				}
			}
		}

		if( (arr[arr.length-1].charAt(arr[arr.length-1].length -1)== '-') || (arr[arr.length-1].charAt(arr[arr.length-1].length -1)== '.' ) || (arr[0].charAt(0)== '.'))
		{
			return false;
		}
	}

	return true;
}

function CheckMultDomainName(domainName)
{		
	var domainParts = domainName.split(',');
	var num = domainParts.length;
	for (var i = 0;i<num;i++)
	{
		if (false == CheckDomainName(domainParts[i]))
		{
			return false;
		}
	}
    return true;		
}

function CheckDomainNameWithWildcard(domainName)
{
	if(domainName != '')
	{
		var adr  = domainName;
		var arr  = domainName.split(".");
		var i=0;
		var j=0;

		if (adr.length >= 256)
		{
			return false;
		}

		if( (adr.charAt(adr.length - 1) == '.' ) || (adr.charAt(0) == '.'))
		{
			return false;
		}

		for(i=0;i<adr.length;i++)
		{
			if( ((adr.charAt(i) =='.') && (adr.charAt(i+1) =='.')))
			{
				return false;
			}
		}

		for(i=0;i<arr.length;i++)
		{
			if (arr[i].length > 63)
			{
				return false;
			}
			for(j=0;j<arr[i].length;j++)
			{
				var IsWildcardVaild = 0;
				if (arr[i].length == 1 && arr[i] == '*')
				{
					IsWildcardVaild = 1;
				}

				if( !((arr[i].charAt(j)>='A' && arr[i].charAt(j)<='Z')
				|| (arr[i].charAt(j)>='a' && arr[i].charAt(j)<='z')
				|| (arr[i].charAt(j)>='0' && arr[i].charAt(j)<='9')
				|| (arr[i].charAt(j)=='-')
				|| IsWildcardVaild))
				{
					return false;
				}
			}
		}

		if( (arr[arr.length-1].charAt(arr[arr.length-1].length -1)== '-') || (arr[arr.length-1].charAt(arr[arr.length-1].length -1)== '.' ) || (arr[0].charAt(0)== '.'))
		{
			return false;
		}
	}

	return true;
}

function CheckIsIpOrNot(ipOrDomainStr)
{
	var ch = ipOrDomainStr.charAt(0);
	if( (ch <= '9' && ch >= '0') || (-1 != ipOrDomainStr.indexOf(":")) )
	{
		return true;
	}

	return false;
}

function CheckIpOrDomainIsValid(ipOrDomainStr)
{
	if( true == CheckIsIpOrNot(ipOrDomainStr) )
	{
		if(false == CheckIpAddressValid(ipOrDomainStr))
		{
			return false;
		}
	}
	else
	{
		if (false == CheckDomainName(ipOrDomainStr))
		{
			return false;
		}
	}
	return true;
}

function CheckPwdIsComplex(str, UserName, checkLen)
{
	var i = 0;
    var inputCheckLen = checkLen ? checkLen : 8;
    if (str.length < inputCheckLen) {
		return false;
	}

	if (!CompareString(str,UserName) )
	{
		return false;
	}

	if ( isLowercaseInString(str) )
	{
		i++;
	}

	if ( isUppercaseInString(str) )
	{
		i++;
	}

	if ( isDigitInString(str) )
	{
		i++;
	}

	if ( isSpecialCharacterInString(str) )
	{
		i++;
	}
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}

function isSpecialCharacterInString(str)
{
	var specia_Reg =/^.*[`~!@#\$%\^&\*\(\)_\+\-=\[\]\{\}\'\;\,\./:\"\?><\\\| ]{1,}.*$/;
	var MyReg = new RegExp(specia_Reg);
	if ( MyReg.test(str) )
	{
		return true;
	}
	return false;
}

function isSpecialCharacterNoSpace(str)
{
	var specia_Reg =/^.*[`~!@#\$%\^&\*\(\)_\+\-=\[\]\{\}\'\;\,\./:\"\?><\\\|]{1,}.*$/;
	var MyReg = new RegExp(specia_Reg);
	if ( MyReg.test(str) )
	{
		return true;
	}
	return false;
}

function isDigitInString(str)
{
	var digit_reg = /^.*([0-9])+.*$/;
	var MyReg = new RegExp(digit_reg);
	if ( MyReg.test(str) )
	{
		return true;
	}
	return false;
}

function isUppercaseInString(str)
{
		var upper_reg = /^.*([A-Z])+.*$/;
		var MyReg = new RegExp(upper_reg);
		if ( MyReg.test(str) )
		{
			return true;
		}
		return false;
}

function isLowercaseInString(str)
{
		var lower_reg = /^.*([a-z])+.*$/;
		var MyReg = new RegExp(lower_reg);
		if ( MyReg.test(str) )
		{
			return true;
		}
		return false;
}

function CompareString(srcstr,deststr)
{
	var reverestr=(srcstr.split("").reverse().join(""));
	if ( srcstr == deststr )
	{
		return false;
	}

	if (reverestr == deststr )
	{
		return false;
	}
	return true;
}

var htmlDecodeMap = [
  [/&nbsp;/g, ' '],
  [/&quot;/g, '\"'],
  [/&gt;/g, '>'],
  [/&lt;/g, '<'],
  [/&#39;/g, '\''],
  [/&#40;/g, '\('],
  [/&#41;/g, '\)'],
  [/&amp;/g, '&']
];

var htmlEncodeMap = [
  [/&/g, '&amp;'],
  [/>/g, '&gt;'],
  [/</g, '&lt;'],
  [/ /g, '&nbsp;'],
  [/\"/g, '&quot;'],
  [/\'/g, '&#39;']
];

var getConvertStr = function(str, mapArr) {
  for (var i = 0; i < mapArr.length; i++) {
    str = str.toString().replace(mapArr[i][0], mapArr[i][1]);
  }
  return str;
}

function GetStringContent(str, Length)
{
	if (str.length > Length)
	{
			str = getConvertStr(str, htmlDecodeMap);

			var strNewLength = str.length;
            if (strNewLength > Length ) {
                str=str.substr(0, Length) + "......";
            } else {
                str=str.substr(0, Length);
            }
      
      return getConvertStr(str, htmlEncodeMap);
	}
	return str.toString().replace(/ /g,"&nbsp;");
}

function GetStringContentForTitle(str, Length)
{
	if (str.length > Length)
	{
			str = getConvertStr(str, htmlDecodeMap);

			var strNewLength = str.length;
			if(strNewLength > Length )
			{
				str=str.substr(0, Length) + "...";
			}
			else
			{
				str=str.substr(0, Length);
			}
      return getConvertStr(str, htmlEncodeMap);
	}
	return str.toString().replace(/ /g,"&nbsp;");
}

function GetUnescapedString(str)
{
  return getConvertStr(str, htmlDecodeMap);
}


function ShowNewRow(oldstring)
{
	var newstring = '';
	var LineLength = 200;
	for (j = 0; j < parseInt((oldstring.length)/LineLength); j++)
	{
		newstring += oldstring.substr(LineLength*j,LineLength*(j+1)) + ' ';
	}
	newstring +=  oldstring.substr(LineLength*j,oldstring.length);
	return newstring;
}

var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var base64DecodeChars = new Array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
		-1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
		16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1,
		-1, -1, -1, -1);

function Base64Encode(str)
{
  var part1, part2, part3;

  var len = str.length;
  var i = 0;
  var out = "";
  while (i < len) {
    part1 = str.charCodeAt(i++) & 0xff;
    if (i == len) {
      out += base64EncodeChars.charAt(part1 >> 2);
      out += base64EncodeChars.charAt((part1 & 0x3) << 4);
      out += "==";
      break;
    }

    part2 = str.charCodeAt(i++);
    if (i == len) {
      out += base64EncodeChars.charAt(part1 >> 2);
      out += base64EncodeChars.charAt(((part1 & 0x3) << 4) | ((part2 & 0xF0) >> 4));
      out += base64EncodeChars.charAt((part2 & 0xF) << 2);
      out += "=";
      break;
    }
    part3 = str.charCodeAt(i++);
    out += base64EncodeChars.charAt(part1 >> 2);
    out += base64EncodeChars.charAt(((part1 & 0x3) << 4) | ((part2 & 0xF0) >> 4));
    out += base64EncodeChars.charAt(((part2 & 0xF) << 2) | ((part3 & 0xC0) >> 6));
    out += base64EncodeChars.charAt(part3 & 0x3F);
  }
  return out;
}

function Base64Decode(str)
{
  var part1, part2, part3, part4;
  
  var len = str.length;
  var i = 0;
  var out = "";
  while (i < len) {
    do {
      part1 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
    } while ((i < len) && (part1 == -1));
    if (part1 == -1) {
      break;
    }

    do {
      part2 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
    } while ((i < len) && (part2 == -1));
    if (part2 == -1) {
      break;
    }

    out += String.fromCharCode((part1 << 2) | ((part2 & 0x30) >> 4));

    do {
      part3 = str.charCodeAt(i++) & 0xff;
      if (part3 == 61) {
        return out;
      }

      part3 = base64DecodeChars[part3];
    } while ((i < len) && (part3 == -1));

    if (part3 == -1) {
      break;
    }

    out += String.fromCharCode(((part2 & 0XF) << 4) | ((part3 & 0x3C) >> 2));

    do {
      part4 = str.charCodeAt(i++) & 0xff;
      if (part4 == 61) {
        return out;
      }
      part4 = base64DecodeChars[part4];
    } while ((i < len) && (part4 == -1));
    if (part4 == -1) {
      break;
    }
    out += String.fromCharCode(((part3 & 0x03) << 6) | part4);
  }

  return out;
}

function isValidBase64(value)
{
	if((value.length)%4 != 0 )
	{
		return false;
	}

	var List = value.split('=');
	if(List.length > 3)
	{
		return false;
	}
	if(List.length == 2)
	{
		if(!(List[1] == ""))
		{
			return false;
		}
	}
	if(List.length == 3)
	{
		if(!(List[1] == "" && List[2] == ""))
		{
			return false;
		}
	}

	for (var i = 0; i < value.length; i++)
	{
		var ch = value.charAt(i);

		var find = false;
		for (var j = 0; j < base64EncodeChars.length; j++)
		{
			if ((ch == base64EncodeChars.charAt(j)) || (ch == '='))
			{
				find = true;
				break;
			}
		}

		if (find == false)
			return false;

	}

	var TempHex = ConvertBase64ToHex(value);
	var TempBase64 = ConvertHexToBase64(TempHex);
	if(TempBase64 != value)
	{
		return false;
	}

	return true;
}

function ConvertHexToBase64(value)
{
	var hexstr;
	var hexvalue;
	var inflow;
	inflow = "";
	var temp;


	if ((value.length)%2 == 1)
	{
	temp = '0' + value;
	}
	else
	{
		temp = value;
	}
	for(var i = 0; i < temp.length/2; i++)
	{
		hexstr = temp.substr(i*2, 2);
		hexvalue = parseInt(hexstr, 16);
		inflow += String.fromCharCode(hexvalue);
	}

	var out = Base64Encode(inflow);

	return out;
}


function ConvertBase64ToHex(value) {
	var inflow = Base64Decode(value);
	var out = '';

	for (var i = 0; i < inflow.length; i++)
	{
		var temp = inflow.charCodeAt(i).toString(16);
		if (temp.length == 1)
		{
			out += '0' + temp;
		}
		else
		{
		   out += temp;
		}
	}

	return out;
}

function CheckDateIsValid(chkDate) {
	var theDateReg = /^(\d{4})(-)([1][0-2]|[0]{0,1}[1-9])(-)([3][0-1]|[1-2]\d|[0]{0,1}[1-9])$/g;
	var matchResult = chkDate.match(theDateReg);

	if(null == matchResult){
		return false;
	}
	var strDate = chkDate.split("-");
	var currentDate = new Date(strDate[0],strDate[1],0);
	if(strDate[2] > currentDate.getDate()){
		return false;
	}
	return true;
}


function TabControl(Id, CssName, TabItemList) {
	this.Id = Id;
	this.CssName = CssName;
	this.TableItemList = TabItemList;
}

function TabControlItem(ReferenceId, Text) {
	this.ReferenceId = ReferenceId;
	this.Text = Text;
}

function OnClickTableControlItem(CurrentIndex, List, Id) {
	var IdList = List.split(",");
	var i;
	for (i = 0; i < IdList.length; i++)
	{
		if (IdList[i].length == 0)
		{
			continue;
		}
		try
		{
			document.getElementById(IdList[i]).style.display = "none";
			document.getElementById('LinkItem'+i).style.color = "blue";
		}
		catch(ex)
		{

		}
	}
	document.getElementById(Id).style.display = "block";
	document.getElementById('LinkItem'+CurrentIndex).style.color = "red";

}

function TabControlParser(NativeControl) {
	this.NativeControl = NativeControl;
	this.ParseControlItem = function(_ItemHtml)
	{
		var ItemHtml = _ItemHtml.replace("{","").replace("}","");
		var Arr = ItemHtml.split(",");
		return new TabControlItem(Arr[0], Arr[1]);
	}
	this.ParseTabControl = function()
	{
		var Reference = NativeControl.reference;
		var RefList = Reference.split("},");
		var RefLength = RefList.length;
		var i = 0;
		var TabItemList = new Array();
		for (i = 0; i < RefLength; i++)
		{
			TabItemList[i] = this.ParseControlItem(RefList[i]);
		}
		return new TabControl(this.NativeControl.Id, this.NativeControl.Css, TabItemList);
	}

	this.GetOuterHTML = function(Tab)
	{
		if (null == Tab)
		{
			return "";
		}

		var OuterHTML = "<table border=\"0\" id=\""+Tab.Id+"\"><tr css=\""+this.CssName+"\">";
		var i = 0;
		var ItemList = Tab.TableItemList;
		var ItemCount = ItemList.length;
		var EachItem = null;
		var IdListText = "";
		for (i = 0; i < ItemCount; i++)
		{
			EachItem = ItemList[i];
			IdListText += EachItem.ReferenceId + ",";
		}
		for (i = 0; i < ItemCount; i++)
		{
			EachItem = ItemList[i];
			OuterHTML +="<td onclick='return OnClickTableControlItem("+i+",\""+IdListText+"\",\""+EachItem.ReferenceId+"\");'><a id='LinkItem"+i+"' href=# style='color:blue;text-decoration: underline'>"+EachItem.Text+"</a></td>";
		}

		OuterHTML+= "</tr></table>";
		return OuterHTML;
	}

	this.RenderControl = function()
	{
		var Tab = this.ParseTabControl();
		var OuterHTML = this.GetOuterHTML(Tab);
		this.NativeControl.outerHTML = OuterHTML;
		var i = 0;
		for (i = 0; i < Tab.TableItemList.length; i++)
		{
		 document.getElementById(Tab.TableItemList[i].ReferenceId).style.display="none";
		}
		document.getElementById(Tab.TableItemList[0].ReferenceId).style.display="block";
		document.getElementById("LinkItem0").style.color="red";

	}
}


function InitControlDataType() {
	var TextBoxList = document.getElementsByTagName("input");
	for (var i = 0; i < TextBoxList.length; i++) {
		var Control = TextBoxList[i];
		if (Control.type != "text") {
			continue;
		}

		var DataType = TextBoxList[i].getAttribute("datatype");
		if (null == DataType)
		{
			continue;
		}

		if (DataType == "int")
		{
			Control.onkeypress = function(event)
			{
				var event = event || window.event;
				var KeyCode = event.keyCode || event.charCode;

				if ((KeyCode < 48 || KeyCode > 57) && KeyCode != 8)
				{
					this.focus();
					return false;
				}

				return true;
			};

			Control.onchange = function()
			{
				var MinValue = this.getAttribute("minvalue");
				var MaxValue = this.getAttribute("maxvalue");
				var ErrorMsg = this.getAttribute("ErrorMsg");
				var DefaultValue = this.getAttribute("default");

				if (this.value.length == 0 || this.vlue*1 == 0)
				{
						if ((ErrorMsg != null ) && (ErrorMsg != "undefined"))
						{
							AlertEx(ErrorMsg);
						}

						this.value = DefaultValue;
						this.focus();
						return false;
				}

				if  ((MinValue != null)
				&& (MaxValue != null)
				&& (MinValue != undefined)
				&& (MaxValue != undefined))
				{
					if (this.value*1 < MinValue*1 || this.value*1 > MaxValue*1)
					{
						if ((ErrorMsg != null ) && (ErrorMsg != "undefined"))
						{
							AlertEx(ErrorMsg);
						}

						this.value = DefaultValue;
						this.focus();
						return false;
					}
				}

				return true;
			};

		}
	}
}

function UrlFilterInfoClass(_UrlEnable, _NameListMode, _SmartEnable, _UrlList) {
	this.UrlEnable = _UrlEnable;
	this.NameListMode = _NameListMode;
	this.SmartEnable = _SmartEnable;
	this.UrlList = _UrlList;
	this.Observer = new Array();
	this.SetEnable = function(Value) {
		this.UrlEnable = Value;
		this.NotifyObserver();
	}
	this.GetEnable = function() {
		return this.UrlEnable;
	}

	this.SetSmartEnable = function(Value) {
		this.SmartEnable = Value;
	}
	this.GetSmartEnable = function() {
		return this.SmartEnable;
	}

	this.SetNameListMode = function(Value) {
		this.NameListMode = Value;
		this.NotifyObserver();
	}
	this.GetNameListMode = function() {
		return this.NameListMode;
	}

	this.GetUrlList = function() {
		return this.UrlList;
	}
	this.SetUrlList = function(Value) {
		this.UrlList = Value;
		this.NotifyObserver();
	}

	this.AddUrl = function(Value) {
		this.UrlList.push(Value);
		this.NotifyObserver();
	}
	this.AddAllUrl = function(Value, Spliter) {
		var i = 0;
		var x = new String();
		var ArrayOfUrl = Value.split(Spliter);
		for (i = 0; i < Value.length; i++)
		{
			this.AddUrl(ArrayOfUrl[i]);
		}

	}

	this.DeleteUrl = function(Value) {
		var i = 0;
		for (i = 0; i < this.UrlList.length; i++) {
			if (this.UrlList[i] == Value)
			{
				this.UrlList[i] = null;
			}
		}

		this.NotifyObserver();
	}
	this.GetUrlListLength = function() {
		var i = 0;
		var Length = 0;
		for (i = 0; i < this.UrlList.length; i++) {
			if (this.UrlList[i] != null)
			{
				Length++;
			}
		}

		return Length;
	}

	this.GetUrlString = function() {
		var UrlString = "";
		var i = 0;
		for (i = 0; i < this.UrlList.length; i++) {
			if (this.UrlList[i] != null)
			{
				UrlString = UrlString + "|" + this.UrlList[i];
			}
		}

		if (UrlString.length > 0)
		{
		   return UrlString.substr(1, UrlString.length-1);
		}

		return UrlString;
	} 
  this.GetAllUrl  = function() {
		return this.UrlList;
	}

	this.AddObserver = function(DataUIObserverObj) {
		this.Observer.push(DataUIObserverObj);
	}

	this.NotifyObserver = function() {
		var i = 0;
		for (i = 0; i < this.Observer.length; i++) {
			this.Observer[i].UpdateUI(this);
		}
	}

	this.SaveData = function(DataObj) {
		DataObj.SaveData(this);
	}
}

function adjustFrameHeight(frameContainerID, frameID, diffOffset, minHeight) {
	var ifm = document.getElementById(frameID);
	try{
	var subWeb = document.frames ? document.frames[frameID].document : ifm.contentDocument;
	}
	catch(e){
		return ;	
	}
	var newMin = 0;

	if (minHeight != null) {
		var minClientHeight = document.body.clientHeight - 56 - ((navigator.appName.indexOf("Internet Explorer") >= 0) ? 4 : 0);
		newMin = Math.max(minHeight, minClientHeight);
	}

	if (ifm != null && subWeb != null && subWeb.body != null) {
		var newHeight = subWeb.body.offsetHeight + diffOffset;
		{
			$("#" + frameContainerID).css("height", Math.max(newHeight, newMin) + "px");
		}
	}
}

function GetShortStr(str, num) {
	if(null == str || 0 == str.length){
		return "";
	}
	num = (isNaN(num) || num) < 0? 5: num;
	var newStr = "";
	var UpReg = /^[A-Z]+$/;
	var LittleReg = /^[a-z0-9\_]+$/;
	var curNum = 0;
	for(i=0; i< str.length; i++){
		if(UpReg.test(str[i])){
			curNum += 0.8;
		}else if(LittleReg.test(str[i])){
			curNum += 0.45;
		}else{
			curNum += 1;
		}
		if(curNum >= num){
			newStr = str.substring(0, i) + "...";
			break;
		}
		if(i >= str.length - 1)
		{
			newStr = str;
			break;
		}
	}
	return newStr;
}

function HwAjaxGetPara(ObjPath, ParameterList) {
	var Result = null;
	  $.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/getajax.cgi?' + ObjPath,
		data: ParameterList,
		success : function(data) {
      Result  = hexDecode(data);
		}
	});
	
	return Result;
}

function CheckHwAjaxRet(Parameter) {
	var Result = hexDecode(Parameter);

	if(Result == '{ "result": 0 }') {
		return true;
	}
	else {
		return false;
	}
}

function HWGetAction(Url, ParameterList, tokenvalue) {
	var tokenstring = (null == tokenvalue) ? "" : ("x.X_HW_Token=" + tokenvalue);
	var ResultTmp = null;
	  $.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : Url,
		data: ParameterList + tokenstring,
		success : function(data) {
			 ResultTmp = hexDecode(data);
		}
	});

	try{
		var ReturnJson = $.parseJSON(ResultTmp);
	}catch(e){
		var ReturnJson = null;
	}

	return ReturnJson;
}

function createDropdown(selectid,dropdowndefault,width,dropdownArr,callfuncobj) {
	var i = 0;
	var dropdownShowId = selectid + "show";
	var dropdownHideId = selectid + "hide";
	$('#'+selectid).css({"width":width});
	
	var DropdownIdStr = "<div class='iframedropdownShow' id='" + dropdownShowId + "' onclick='showDropdown(this,event);'></div><ul class='iframedropdownHide' name='dropDownList' id='" + dropdownHideId + "' style='display:none;'></ul>";
	
	$('#'+selectid).html(DropdownIdStr);
	
	$('#'+dropdownShowId).html(dropdowndefault);
	$('#'+dropdownShowId).css({"width":"98%"});
	
	for(i;i<dropdownArr.length;i++){
		$("#"+dropdownHideId).append("<li id='"+ dropdownArr[i] + "' onclick='" + callfuncobj + "' >"+dropdownArr[i]+"</li>")
	}
	$('#'+dropdownHideId).css({"width":width});
}

var thisDropdownArr = '';
function createWlanDropdown(selectid,dropdowndefault,width,dropdownArr,callfuncobj) {
	
	//dropdownShow
	thisDropdownArr = dropdownArr;
	var i = 0;
	var dropdownShowId = selectid + "show";
	var dropdownHideId = selectid + "hide";
	$('#'+selectid).css({"width":width});
	
	var DropdownIdStr = "<div class='iframedropdownShow' id='" + dropdownShowId + "' onclick='showWlanDropdown(this,event);'></div><ul class='iframedropdownHide' id='" + dropdownHideId + "' style='display:none;'></ul>";
	$('#'+selectid).html(DropdownIdStr);
	$('#'+dropdownShowId).html(dropdowndefault[0]);
	$('#'+dropdownShowId).css({"width":"98%"});
	
	for(i;i<dropdownArr.length;i++){
		$("#"+dropdownHideId).append("<li id='"+ dropdownArr[i][0] + "' dataValue = '" + dropdownArr[i][1] + "' onclick='" + callfuncobj + "' >"+dropdownArr[i][0]+"</li>")
	}
	$('#'+dropdownHideId).css({"width":width});
}

function setDropdownSelVal(selectid,dropdowndefault) {
	var dropdownShowId = selectid + "show";
	$('#'+dropdownShowId).html(dropdowndefault);
}

var g_Allclickshow = false;
function SetClickFlag(flag) {
	g_Allclickshow = flag;	
}

function showDropdown(obj, event) {
	
	var ShowId = obj.id;
	var HideId = obj.id.split("show")[0] + "hide";
	$("#" + HideId).toggle(function(){
		if(false == g_Allclickshow){
			$('#'+ShowId).css("background-image","url('../../../images/arrow-up.png')");
			g_Allclickshow = true;
			
		}else{
			g_Allclickshow = false;
			$('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
		}
	}
	);
	
	$("body").click(function(){
		$("#"+HideId).hide();
		g_Allclickshow = false;
		$('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
	});
	
	var e = window.event || event;
	if(e.stopPropagation){
		e.stopPropagation();
	}else{
		window.event.cancelBubble = true;
	}
}

function showWlanDropdown(obj, event) {
	
	var ShowId = obj.id;
	var HideId = obj.id.split("show")[0] + "hide";
	var dropdownArrHeight = (thisDropdownArr.length*39) + 'px';  
	$("#" + HideId).toggle(function(){
		if(false == g_Allclickshow){
			$("#DivEmpty").css('height',dropdownArrHeight);
			$('#'+ShowId).css("background-image","url('../../../images/arrow-up.png')");
			g_Allclickshow = true;
		}else{
			$("#DivEmpty").css('height','0px');
			g_Allclickshow = false;
			$('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
		}
	}
	);
	
	$("body").click(function(){
		$("#DivEmpty").css('height','0px');
		$("#"+HideId).hide();
		g_Allclickshow = false;
		$('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
	});
	
	var e = window.event || event;
	if(e.stopPropagation){
		e.stopPropagation();
	}else{
		window.event.cancelBubble = true;
	}
	
}

function chooseValue(obj){
	var text = obj.innerHTML;
	$('#dropdownShow').html(text);
}

function pageDisable() {
    var input = document.getElementsByTagName("input");
    var select = document.getElementsByTagName("select");
	var textarea = document.getElementsByTagName("textarea");
    for(var i =0;i<input.length;i++) {
        input[i].disabled = true;
    }
    for(var i =0;i<select.length;i++) {
        select[i].disabled = true;
    }
	for(var i =0;i<textarea.length;i++) {
        textarea[i].disabled = true;
    }
	
}

function addClass(id, cls) {
	var classval = getElement(id).getAttribute("class");
	classval = (classval==null)?cls:classval.concat(" " + cls)

	if (hasClass(id, cls)) {
		return;
	}

	getElement(id).setAttribute("class",classval);
}


function removeClass(id, cls) {
	var classval = getElement(id).getAttribute("class");
	if (classval == null) {
		return;
	}

  classval = classval.replace(cls,"");
	getElement(id).setAttribute("class",classval);
}

function hasClass(id,cls) {
    var re = new RegExp("\\b"+cls+"\\b");

    var elm = getElement(id);

    return re.test(elm.className);
}
if (!String.prototype.trim) {
	String.prototype.trim = function() {
		var str = this,
		str = str.replace(/^\s\s*/, ''),
		ws = /\s/,
		i = str.length;
		while (ws.test(str.charAt(--i)));
		return str.slice(0, i + 1);
	}
}

function IsKeyBoardContinuousChar(str) {
    var c1 = [ 
                ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
                ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
                ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
                ['z', 'x', 'c', 'v', 'b', 'n', 'm']
    ];

    str = str.split("");
    var y = [];
    var x = [];
    for (var c = 0; c < str.length; c++) {
        y[c] = 0;
        x[c] = -1;

        for (var i = 0; i < c1.length; i++) {
            for (var j = 0; j < c1[i].length; j++) {
                if (str[c] == c1[i][j]) {
                    y[c] = i; x[c] = j;
                }
            }
        }
    }

    for (var c = 1; c < str.length - 2; c++) {
        if (y[c - 1] == y[c] && y[c] == y[c + 1] && y[c + 1] == y[c + 2]) {
            if ((x[c - 1] + 1 == x[c] && x[c] + 1 == x[c + 1]  && x[c + 1] + 1 == x[c + 2])) {
                keyBoardConsecutiveNumber = str[c - 1] + str[c] + str[c + 1] + str[c + 2];
                return true;
            }
        }
    }
    return false;
}

function CheckConsecutiveChar(firstChar, secondChar, thirdChar, forthChar) {
    if (((forthChar - thirdChar) == 1) && ((thirdChar - secondChar) == 1) && ((secondChar - firstChar) == 1)) {
        return true;
    }

    return false;
}

function IsconsecutiveChar(str) {
    var arr = str.split('');
    for (var i = 1; i < arr.length-2; i++) {
        var firstIndex = arr[i-1].charCodeAt();
        var secondIndex = arr[i].charCodeAt();
        var thirdIndex = arr[i+1].charCodeAt();
        var forthIndex = arr[i+2].charCodeAt();

        if ((CheckConsecutiveChar(firstIndex, secondIndex, thirdIndex, forthIndex)) ||
            (CheckConsecutiveChar(forthIndex, thirdIndex, secondIndex, firstIndex))) {
            consecutiveNumber = arr[i-1] + arr[i] + arr[i+1] + arr[i+2];
            return true;
        }
    }
    return false;
}

function IsRepeatedChar(str) {
    var arr = str.split('');
    for (var i = 1; i < arr.length-2; i++) {
        var firstIndex = arr[i-1].charCodeAt();
        var secondIndex = arr[i].charCodeAt();
        var thirdIndex = arr[i+1].charCodeAt();
        var forthIndex = arr[i+2].charCodeAt();

        if ((forthIndex - thirdIndex == 0) && (thirdIndex - secondIndex == 0) && (secondIndex - firstIndex==0)) {
            repeatedNumber = arr[i-1] + arr[i] + arr[i+1] + arr[i+2];
            return true;
        }
    }
    return false; 
}

function TtnetComplex(oldPassword, newPassword) {
    if (newPassword.length < 8) {
        AlertEx(GetLanguageDesc("S2422"));
        return false;
    }

    if (/^[0-9]*$/.test(newPassword)) {
        AlertEx(GetLanguageDesc("S2423"));
        return false;
    }

    if (/^[a-zA-Z]*$/.test(newPassword)) {
        AlertEx(GetLanguageDesc("S2424"));
        return false;
    }

    if (IsKeyBoardContinuousChar(newPassword)){
        AlertEx(GetLanguageDesc("S2425") + keyBoardConsecutiveNumber + GetLanguageDesc("S2426")); 
        return false;
    }

    if (IsconsecutiveChar(newPassword)){
        AlertEx(GetLanguageDesc("S2427") + consecutiveNumber + GetLanguageDesc("S2426"));
        return false;
    }

    if (IsRepeatedChar(newPassword)){
        AlertEx(GetLanguageDesc("S2428") + repeatedNumber + GetLanguageDesc("S2426"));
        return false;
    }

    if (oldPassword == newPassword) {
        AlertEx(GetLanguageDesc("S2429"));
        return false;
    }

    return true;
}

function GetToken() {
    var tokenstring="";
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/ssmp/common/GetRandToken.asp",
        success : function(data) {
            tokenstring = data;
        }
    });
    return tokenstring;
}

function logoutfunc(timeStamp) {
    if (UpgradeFlag == 1){
        alert(framedesinfo["uploadingTip"]);

        return;
    }
    var token = GetToken();
    var sUserAgent = navigator.userAgent;
    var url = 'logout.cgi?RequestFile=html/logout.html';
    var isIELarge11 = (sUserAgent.indexOf("Trident") > -1 && sUserAgent.indexOf("rv") > -1);
    if (isIELarge11) {
        if (timeStamp != undefined) {
            url += "&TimeStamp=";
            url += timeStamp;
        }

        var data = {'x.X_HW_Token': token};
        $.post(url, data);
        window.location = "/";
    }
    else {
        var Form = new webSubmitForm();
        Form.addParameter('x.X_HW_Token', token);
        Form.setAction('logout.cgi?RequestFile=html/logout.html');
        Form.submit();
    }
}

function LogoutWithPara(submitType, location, diffAdminPath, curUser) {
    var token = GetToken();
    var sysUser = '0';
    var sUserAgent = navigator.userAgent;
    var isIELarge11 = (sUserAgent.indexOf("Trident") > -1 && sUserAgent.indexOf("rv") > -1);
    var url = '/logout.cgi?';
    if (submitType != "") {
        url += '&SubmitType=' + submitType;
    }
    url += '&RequestFile=/html/logout.html';
    if (isIELarge11) {
        var data = {'x.X_HW_Token': token}
        $.post(url, data);
        if (((diffAdminPath == true) && (sysUser != curUser)) || (location == "")) {
            window.location = "/";
        } else {
            window.location = location;
        }
    } else {
        var Form = new webSubmitForm();
        Form.addParameter('x.X_HW_Token', token);
        Form.setAction(url);
        Form.submit();
    }
}

function IntToIpForBigEndian(ipNum) {
    var ipAddress = '';
    ipNum = parseInt(ipNum,10);
    var ipStr = ipNum.toString(16);

    if (ipStr != '') {
        if (ipStr.length < 8) {
            ipStr = "00000000".substring(0, 8 - ipStr.length) + ipStr;
        }

        ipNum = parseInt(ipStr, 16);
        ipAddress = (ipNum>>>24) + "." + (ipNum>>16 & 0xFF) + "." + (ipNum>>8 & 0xFF) + "." + (ipNum & 0xFF);
    }

    return ipAddress;
}

function setCookie(name, value) {
  var expdate = new Date();
  var argv = setCookie.arguments;
  var argc = setCookie.arguments.length;
  var expires = (argc > 2) ? argv[2] : null;

  var path = '/';
  var domain = (argc > 4) ? argv[4] : null;
  var secure = (argc > 5) ? argv[5] : false;
  if(expires!=null) expdate.setTime(expdate.getTime() + ( expires * 1000 ));
  document.cookie = name + '=' + escape (value) +((expires == null) ? '' : ('; expires='+ expdate.toGMTString()))
  +((path == null) ? '' : ('; path=' + path)) +((domain == null) ? '' : ('; domain=' + domain))
  +((secure == true) ? '; secure' : '');
}

function getCookieVal(off) {
  var str = document.cookie.indexOf (';', off);
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

function getPath(curObj) {
  if (curObj) {
    if (window.navigator.userAgent.indexOf("Firefox") >= 1) {
      if (curObj.files) {
        return curObj.files.item(0).getAsDataURL();
      }
      return curObj.value;
    } else if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
      curObj.select(); 
      return document.selection.createRange().text;
    } 
    return curObj.value;
  }
}

function getLayerStr(isNs4, barheight, barwidth, bordercolor, barheight, unloadedcolor, loadedcolor) {
  var txt = '';
  if(isNs4) {
    txt += '<table border=0 cellpadding=0 cellspacing=0><tr><td>';
    txt += '<ilayer name="PBouter" visibility="hide" height="'+barheight+'" width="'+barwidth+'">';
    txt += '<layer width="'+barwidth+'" height="'+barheight+'" bgcolor="'+bordercolor+'" top="0" left="0"></layer>';
    txt += '<layer width="'+(barwidth-2)+'" height="'+(barheight-2)+'" bgcolor="'+unloadedcolor+'"';
    txt += ' top="1" left="1"></layer>';
    txt += '<layer name="PBdone" width="'+(barwidth-2)+'" height="'+(barheight-2)+'"';
    txt += ' bgcolor="'+loadedcolor+'" top="1" left="1"></layer>';
    txt += '</ilayer>';
    txt += '</td></tr></table>';
  } else {
    txt += '<div id="PBouter" style="background-color:'+bordercolor+'; width:'+barwidth+'px; height:'+barheight+'px;';
    txt += ' position:relative; visibility:hidden;">';
    txt += '<div style="width:'+(barwidth-2)+'px; height:'+(barheight-2)+'px; background-color:'+unloadedcolor+';';
    txt += ' position:absolute; top:1px; left:1px;font-size:1px;"></div>';
    txt += '<div id="PBdone" style="height:'+(barheight-2)+'px; background-color:'+loadedcolor+';';
    txt += ' position:absolute; top:1px; left:1px; width:0px;font-size:1px;"></div>';
    txt += '</div>';
  }  
  return txt;
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

function getDynamicData(path, callBack, errorCallBack) {
  $.ajax({
    type : 'GET',
    async : true,
    cache : false,
    url : path,
    success : function(data) {
      var result = dealDataWithFun(data);
      if (callBack) {
        callBack(result);
      }
    },
    error: function() {
        if (errorCallBack) {
            errorCallBack();
        }
    }
  });
}

var PRE_LOGIN_TOKEN_PATH = '/html/ssmp/common/getRandString.asp';
var LOGIN_TOKEN_PATH = '/html/ssmp/common/GetRandToken.asp';

function getAuthToken(isLogin) {
  var tokenPath = PRE_LOGIN_TOKEN_PATH;
  if (isLogin === '1' || isLogin == true) {
    tokenPath = LOGIN_TOKEN_PATH;
  }
  return ajaxGetAspData(tokenPath);
}

function getDataWithToken(data, isLogin) {
  var token = getAuthToken(isLogin);
  if (data) {
    return data + '&x.X_HW_Token=' + token;
  }
  return 'x.X_HW_Token=' + token;
}

function ajaxSumitData(path, submitData, isLogin, callBack) {
  $.ajax({
    type: 'POST',
    async: true,
    cache: false,
    url: path,
    data: getDataWithToken(submitData, isLogin),
    success: function (data) {
      if (callBack) {
        callBack(dealDataWithFun(data));
      }
    }
  });
}
