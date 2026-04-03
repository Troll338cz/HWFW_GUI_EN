<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link type='text/css' rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link type='text/css' rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(errdes.html);%>"></script>

<script language="JavaScript" type="text/javascript">

function GetLanguageDesc(Name)
{
    return UsbHostLgeDes[Name];
}

function stUSBDevice(domain,DeviceList)
{
	this.domain = domain;
	this.DeviceList = DeviceList;
}

function stStorageService(domain,PhysicalNumber,LogicalNumber)
{
    this.domain = domain;
    this.PhysicalNumber = PhysicalNumber;
	this.LogicalNumber = LogicalNumber;
}

function stPhysicalMedium(domain,Name,Status,X_HW_SafeRemove)
{
    this.domain = domain;
    this.Name = Name;
    this.Status = Status;
	this.X_HW_SafeRemove = X_HW_SafeRemove;
}

function stUsbInfo(mntpath, devname)
{
	this.mntpath = mntpath;
	this.devname = devname;
}

var IsPtVdf = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PTVDF);%>";
var StorageServices = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.{i}, PhysicalMediumNumberOfEntries|LogicalVolumeNumberOfEntries, stStorageService);%>;
var PhysicalMediums = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.StorageService.{i}.PhysicalMedium.{i}, Name|Status|X_HW_SafeRemove, stPhysicalMedium);%>;
var stUsbInfo = <%HW_WEB_GetUSBAllInfo();%>;
var PhyDevInst = 0;
var SelectDevName = null;

function GetDevNameList(usbname)
{
	var showDevName = "";
	for (var i = 0; i < stUsbInfo.length; ++i)
	{
		if (null == stUsbInfo[i])continue;
		var pos = stUsbInfo[i].mntpath.indexOf(usbname);
		if (9 == pos)
		{
			showDevName += stUsbInfo[i].devname + "&#10;";
		}
	}
	
	return showDevName;
}

function MakeDeviceName(DiskName)
{
	var device = DiskName.split("/"); 
	return device[3];
}


function WriteDeviceOption(id)
{
	var select = document.getElementById(id);

	if (DeviceStr != 'null')
	{
		for (var i in DeviceArray)
		{
			if ((DeviceArray[i] == 'null')
				|| (DeviceArray[i] == 'undefined'))
				continue;
			var opt = document.createElement('option');
			var html = document.createTextNode(MakeDeviceName(DeviceArray[i]));
			opt.value = DeviceArray[i] + '/';
			opt.appendChild(html);
			select.appendChild(opt);
		}
		return true;
	}
	else
	{
		var opt = document.createElement('option');
		var html = document.createTextNode(UsbHostLgeDes['s052e']);
		opt.value = '';
		opt.appendChild(html);
		select.appendChild(opt);
		return false;
	}
}

function GetUsbList()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "../common/GetUsbphyStatus.asp",
		success : function(data) {
			PhysicalMediums = dealDataWithFun(data);
			//window.document.location.href = "usbremove.asp";
		}
	});
}

function ShowUsbList()
{
	var status = 0
	$("#DevSelect").remove();
	$("#DevList").append('<div id="DevSelect" width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_noborder_bg" style="line-height: 26px; padding: 0;"></div>');

	if ( PhysicalMediums.length > 1 )
	{
		for (var i = 0; i < PhysicalMediums.length-1; i++)
		{
			if ((PhysicalMediums[i] == 'null')
					|| (PhysicalMediums[i].Name == 'undefined'))
					continue;
			if( 'Online' == PhysicalMediums[i].Status)
			{
				status += 1;
				var devname = htmlencode(PhysicalMediums[i].Name);
				var showdevname = "usb-"+devname;
				if (1 == IsPtVdf)
				{
					var devnametip = htmlencode(GetDevNameList(showdevname));
					$("#DevSelect").append('<div style="line-height:26px;" title="' + devnametip + '" id="'+ devname +'"><input type="radio" name="usbdev" value="'+devname+'" style="vertical-align: text-top; width: 30px;" onclick="ShowUsbSelect(this.value)">' + showdevname + '</div>');
				}
				else
				{
					$("#DevSelect").append('<div style="line-height:26px;" id="'+ devname +'"><input type="radio" name="usbdev" value="'+devname+'" style="vertical-align: text-top; width: 30px;" onclick="ShowUsbSelect(this.value)">' + showdevname + '</div>');
				}
			}
			else
			{
				continue;
			}
		}
		if( 0 == status)
		{
			$("#DevSelect").append('<div>'+ GetLanguageDesc("s052e") +'</div>');
		}
		return true;
	}
	else
	{
		$("#DevSelect").append('<div>'+ GetLanguageDesc("s052e") +'</div>');
	}
}

function ShowUsbSelect(val)
{
	SelectDevName = val;
	setRadio("usbdev", val);
}

function GetPhyDevDomain()
{
	if ( PhysicalMediums.length > 1 )
	{
		for (var i = 0; i < PhysicalMediums.length-1; i++)
		{
			if(PhysicalMediums[i].Name == SelectDevName)
			{
				if('Online' == PhysicalMediums[i].Status)
				{
					return PhysicalMediums[i].domain;
				}
			}
		}
	}
	return null;
}

function RemoveSubmit()
{
	if(null == SelectDevName)
	{
		alert(GetLanguageDesc("s050c"));
		return 0;
	}

	GetUsbList();
	var phyDomain = GetPhyDevDomain();
	if((null == phyDomain)||("" == phyDomain))
	{
		alert(GetLanguageDesc("s0554"));
		window.document.location.href = "usbremove.asp";
		return 0;
	}
	

	if(ConfirmEx(GetLanguageDesc("s0553")))
	{
		setDisable('btnDownSrvApply', 1);
		setDisable('btnDownSrcCancle', 1);
		$.ajax({
			 type : "POST",
			 async : true,
			 cache : false,
			 data : "x.X_HW_SafeRemove=1&x.X_HW_Token="+getValue('onttoken'),
			 url : "setajax.cgi?x="+phyDomain+"&RequestFile=html/ssmp/usbftp/usbremove.asp",
			 success : function(data) {
				window.document.location.href = "usbremove.asp";
			 },
			 complete: function (XHR, TS) {
				XHR=null;
			 }
		});
	}

}

function CancelConfig()
{
	setDisable('btnDownSrvApply', 1);
	setDisable('btnDownSrcCancle', 1);
	//window.document.location.href = "usbremove.asp";
	//SelectDevName = null;
	//LoadFrame();
	setTimeout(
		function(){
		window.document.location.href = "usbremove.asp";},
		1000);
}

function LoadFrame()
{
	GetUsbList();
	ShowUsbList();
}

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
	<script language="JavaScript" type="text/javascript">
		var USBRMSummaryArray = new Array(new stSummaryInfo("text", GetDescFormArrayById(UsbHostLgeDes, "s0549")),
										 new stSummaryInfo("img", "../../../images/icon_01.gif", GetDescFormArrayById(UsbHostLgeDes, "s0531")),
										 new stSummaryInfo("text", GetDescFormArrayById(UsbHostLgeDes, "s0555")),
										 null);
		HWCreatePageHeadInfo("usbremove", GetDescFormArrayById(UsbHostLgeDes, "s0556"), USBRMSummaryArray, true);
	</script>

	<div id="PhysicalInfo" name="Physical" class="z_index_2">
	<div class="func_spread"></div> 
	<div class="func_title" BindText="s0550"></div>
	</div>

	<div id="DevList">
		<div id="DevSelect">
		</div>
	</div>

	<div class="func_spread"></div>
	
	<form id="ConfigForm" action="">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per25"></td>
				<td class="table_submit">
					<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>" />
					<input type="button" name="btnDownSrvApply"  id="btnDownSrvApply"  class="ApplyButtoncss  buttonwidth_100px" BindText="s0551" onClick='RemoveSubmit()' />
					<input type="button" name="btnDownSrcCancle" id="btnDownSrcCancle" class="CancleButtonCss buttonwidth_100px" BindText="s0552" onClick='CancelConfig()' />
				</td>
			</tr>
		</table>
	</form>

<script>
ParseBindTextByTagName(UsbHostLgeDes, "div",    1);
ParseBindTextByTagName(UsbHostLgeDes, "td",    1);
ParseBindTextByTagName(UsbHostLgeDes, "input", 2);
</script>
</body>
</html>
