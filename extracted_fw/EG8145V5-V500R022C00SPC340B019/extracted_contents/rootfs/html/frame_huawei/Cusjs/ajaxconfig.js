function hexDecode(str) {
  if (typeof str === 'string' && /\\x(\w{2})/.test(str)) {
    return str.replace(/\\x(\w{2})/g,function(_,$1){ return String.fromCharCode(parseInt($1,16)) });
  }
  return str;
}

function HwAjaxGetPara(ObjPath, ParameterList)
{
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
	  
	try{
		return Result;
	}
	catch(e){
		return null;	
	}
}

function HWGetAction(Url, ParameterList, tokenvalue)
{
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

function HwAjaxGetUsbContentInfo(usbtolen)
{
	var usb1;
	var usb2;
	var ParameterList="DeviceList";
	var ObjPath = "x=InternetGatewayDevice.X_HW_UsbInterface.X_HW_UsbStorageDevice&RequestFile=/CustomApp/index.asp";
	if(null != usbtolen)
	{
		var tokenstr = "&x.X_HW_Token=" + usbtolen;
		ParameterList += tokenstr;
	}
	
	var TmpUsbList = HwAjaxGetPara(ObjPath, ParameterList);
	
	if(-1 == TmpUsbList.indexOf('|'))
	{
		return null;
	}
	
	var	UsbList = $.parseJSON(TmpUsbList);
	
	var DeviceStr = UsbList.DeviceList;
	if(DeviceStr != '')
	{
		DeviceArray = DeviceStr.split("|");
	}
	
	if(DeviceArray.length > 0)
	{
		return DeviceArray;
	}

	return null;
}
