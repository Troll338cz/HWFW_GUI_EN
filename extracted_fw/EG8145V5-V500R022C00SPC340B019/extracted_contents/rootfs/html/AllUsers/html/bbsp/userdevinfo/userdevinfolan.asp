<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>User Device Information</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<style>
.Tag_Title {
	font-size:14px;
	height: 14px;
	white-space: nowrap;
}
.submit_bbspuser1{
    margin: 0;
    padding: 0;
	width: 99px;
}
.width_hostname{
	width: 110px;
} 
.width_Online{
	width: 59px;
}
.width_devinfo, .width_connecttime, .width_app{
	width: 100px;
}
.width_uprate, .width_dowrate{
	width: 86px;
}
</style>
<script language="JavaScript" type="text/javascript">
var list = 5;
var MAX_HOST_TYPE = 9;
var token = '<%HW_WEB_GetToken();%>';
var ConnectDevIp = '<%HW_WEB_GetCurDeviceIP();%>';


var UserDevinfo = new Array();

'<%HW_WEB_UserDevSendArp();%>'; 
function NameList(Domain,MACAddress,Name)
{
	this.Domain 	= Domain;
	this.MACAddress	    = MACAddress;
	this.Name	= Name;
}

var HomeNetNameList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_HOMENET_NAME.hosts.{i}, MACAddress|Name, NameList);%>;

function USERDevice(IpAddr,MacAddr,Port,IpType,DevType,DevStatus,PortType,Time,HostName,TrafficSend,TrafficRecv)
{
	this.IpAddr	    = IpAddr;
	this.MacAddr	= MacAddr;
	this.Port 		= Port;	
	this.IpType		= IpType;
	if(IpType=="Static")
	{
	  this.DevType="--";
	}
	else 
	{
		if(DevType=="")
		{
			this.DevType	= "--";	
		}
		else
		{
			this.DevType	= DevType;		
		}	
	}
	this.DevStatus 	= DevStatus;
	this.PortType	= PortType;
	this.Time	    = Time;
	if(HostName=="")
	{
		this.HostName	= "--";
	}
	else
	{
	   this.HostName	= HostName;
	}
	this.TrafficSend	= TrafficSend;
	this.TrafficRecv	= TrafficRecv;
}

var enableMacFilter = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.MacFilterRight);%>';
var MacFilterPolicy = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.MacFilterPolicy);%>';
function stmacfilter(domain,MACAddress)
{
   this.domain = domain;
   this.MACAddress = MACAddress;
}
var MacFilter = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.MacFilter.{i},SourceMACAddress,stmacfilter);%>;

var firstpage = 1;
var page = firstpage;
var lastpage = 0;
var StartTime = 0;
var EndTime = 0;

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
	
	return Result;
}

function FindHostNameItemByMac(MacAddress)
{
	for (var n = 0; n < HomeNetNameList.length -1; n++)
	{	
		if(HomeNetNameList[n].MACAddress.toUpperCase() == MacAddress.toUpperCase())
		{
			return n;
		}
	}
	return -1;
}


function IsValidPage(pagevalue)
{
	if (true != isInteger(pagevalue))
	{
		return false;
	}
	return true;
}

function IsFindMacList(macAddress,macfilter,macfilterpolicy)
{
	var i = 0;
	var index = -1;
	if ('0' != macfilterpolicy)
	{
		return index;
	}
	for(i = 0; i < (macfilter.length - 1); i++) 
	{
		if (macfilter[i].MACAddress.toUpperCase() == macAddress.toUpperCase())
		{
			index = i;
			break;
		}
	}
	return index;
}

function SetMacFilterList(index, DevData)
{
	var CurMacIndex;
	var MacAddr = DevData[index].MacAddr;
	
	var ConfigParaList = new Array();
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;

	CurMacIndex = IsFindMacList(MacAddr,MacFilter,MacFilterPolicy);
	if ('-1' == CurMacIndex)
	{
		if (ConnectDevIp == DevData[index].IpAddr)
		{
			if (ConfirmEx(userdevinfo_mainpage_language['bbsp_AddBlacklistHint']) == false)
			{
				return false;
			}
		}

		ConfigParaList.push(new stSpecParaArray("x.SourceMACAddress",MacAddr, 0));
		Parameter.SpecParaPair = ConfigParaList;
		var ConfigUrl = 'addajax.cgi?x=InternetGatewayDevice.X_HW_Security.MacFilter&RequestFile=/html/bbsp/userdevinfo/userdevinfolan.asp';							  
		HWSetAction("ajax", ConfigUrl, Parameter, token);
	}
	else
	{
		ConfigParaList.push(new stSpecParaArray(MacFilter[CurMacIndex].domain ,'', 0));
		Parameter.SpecParaPair = ConfigParaList;
		var ConfigUrl = 'delajax.cgi?x=InternetGatewayDevice.X_HW_Security.MacFilter&RequestFile=/html/bbsp/userdevinfo/userdevinfolan.asp';		
		HWSetAction("ajax", ConfigUrl, Parameter, token);
	}

	return true;
}

function SetEnableBlackPolicy(index, DevData)
{
	var ConfigParaList = new Array();

	if ('1' != enableMacFilter)
	{
		ConfigParaList.push(new stSpecParaArray("x.MacFilterRight",1, 0));
	}
	if ('0' != MacFilterPolicy)
	{
		ConfigParaList.push(new stSpecParaArray("x.MacFilterPolicy",0, 0));
	}
	
	if (ConfigParaList.length > 0)
	{
		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false;
		Parameter.SpecParaPair = ConfigParaList;
		var ConfigUrl = 'setajax.cgi?x=InternetGatewayDevice.X_HW_Security'+'&RequestFile=/html/bbsp/userdevinfo/userdevinfolan.asp';							  
		HWSetAction("ajax", ConfigUrl, Parameter, token);
	}
}

function ApplyBlackList(val)
{
	var id = val.id;
	var index = id.split('_')[1];
		
	SetEnableBlackPolicy(index, UserDevinfo);
	if (false == SetMacFilterList(index, UserDevinfo))
	{
		return;
	}
	window.location="userdevinfolan.asp?" + parseInt(page, 10);
}

function InitFirstPage(DevNum)
{
	if(DevNum == 0)
	{
		firstpage = 0;
	}

	page = firstpage;

	if( window.location.href.indexOf("?") > 0)
	{
		page = parseInt(window.location.href.split("?")[1], 10); 
		if (false == IsValidPage(page))
		{
		    if( window.location.href.indexOf("x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev") <= 0)
		    {		    
			    AlertEx(userdevinfo_language['bbsp_faulturl']);		
			    page = (0 == DevNum) ? 0:1;
			}
		}
	}

	lastpage = DevNum/list;
	if(lastpage != parseInt(lastpage, 10))
	{
		lastpage = parseInt(lastpage, 10) + 1;	
	}

	if( window.location.href.indexOf("?") > 0)
	{
		var href = window.location.href.split("?")[1];
	
		if( window.location.href.indexOf("x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev") > 0)
		{	
			page = window.location.href.split("?")[2].split('&')[0]; 
		}
		else
		{	
		    page = href;
		}
	}

	if( page > lastpage )
	{
		page = lastpage;
	}
}

function PageChangHide() 
{
	setDisable('first',0);
	setDisable('prv',0);
	setDisable('next',0);
	setDisable('last',0);
	
	if(page == firstpage)
	{
		setDisable('first',1);
		setDisable('prv',1);
	}
	if(page == lastpage)
	{
		setDisable('next',1);
		setDisable('last',1);
	}
}

function ShowList(startlist , endlist, UserDevicesInfo)
{
	var i = 0;
	var connecttime = "--";
	var outputlist = "";
	
	for(i = startlist; i <= endlist - 1; i++)   
	{
		outputlist = outputlist + Appendstr("<tr class=\"tabal_center01 trTabContent\" >");
		outputlist = outputlist + Appendstr ('<td class="width_hostname"><div class="width_hostname" title = "'+htmlencode(UserDevicesInfo[i].HostName)+'">'+GetStringContentForTitle(htmlencode(UserDevicesInfo[i].HostName), MAX_HOST_TYPE)+'</div></td>');
		outputlist = outputlist + Appendstr('<td class="width_devinfo">'+htmlencode(UserDevicesInfo[i].MacAddr)+'<br/>'+htmlencode(UserDevicesInfo[i].IpAddr) +'</td>');
		outputlist = outputlist + Appendstr('<td class="width_Online"><div class="width_Online" id = "devstatus_' + i+'"></div></td>');
		outputlist = outputlist + Appendstr('<td class="width_connecttime"><div class="width_connecttime" id = "timeshow_' + i+'"></div></td>');
		outputlist = outputlist + Appendstr('<td class="width_uprate"><div class="width_uprate" id = "uprate_' + i+'"></div></td>');
		outputlist = outputlist + Appendstr('<td class="width_dowrate"><div class="width_dowrate" id = "downrate_' + i+'"></div></td>');	
		outputlist = outputlist + Appendstr('<td class="width_app">');
		outputlist = outputlist + Appendstr('<button name="btnApply" id=balcklist_'+ i +'  type="button" class="pix_70_130 submit_bbspuser1"  onClick="ApplyBlackList(this);">'+ '&nbsp;');
		if ('-1' == IsFindMacList(UserDevicesInfo[i].MacAddr, MacFilter, MacFilterPolicy))
		{
			outputlist = outputlist + Appendstr(userdevinfo_language['bbsp_addlanblacklist']);		
		}
		else
		{
			outputlist = outputlist + Appendstr(userdevinfo_language['bbsp_dellanblacklist']);		
		}
		outputlist = outputlist + Appendstr('</button>');
		outputlist = outputlist + Appendstr('<br>');
		outputlist = outputlist + Appendstr('</td>');
		outputlist = outputlist + Appendstr("</tr>");
	}

	$("#devlist").append(outputlist);
	PageChangHide();		
	for(i = startlist; i <= endlist - 1; i++)   
	{
		var unit_h = (parseInt(UserDevicesInfo[i].Time.split(":")[0], 10) > 1) ? userdevinfo_mainpage_language['bbsp_hours'] : userdevinfo_mainpage_language['bbsp_hour'];
		var unit_m = (parseInt(UserDevicesInfo[i].Time.split(":")[1], 10) > 1) ? userdevinfo_mainpage_language['bbsp_mins'] : userdevinfo_mainpage_language['bbsp_min'];
		var connecttime = (UserDevicesInfo[i].DevStatus.toUpperCase() != "ONLINE") ? "--" : (UserDevicesInfo[i].Time.split(":")[0] + unit_h + UserDevicesInfo[i].Time.split(":")[1] + unit_m);		
		$("#uprate_"+i).html("0KB/s");
		$("#downrate_"+i).html("0KB/s");	
		$("#timeshow_"+i).html(htmlencode(connecttime));
		$("#devstatus_"+i).html(userdevinfo_language[UserDevicesInfo[i].DevStatus]);
	}
}

function ShowListControl(UserDevicesInfo)
{
	if(UserDevicesInfo.length == 0)
	{
		ShowList(0 , 0, UserDevicesInfo);
	}
	else if( UserDevicesInfo.length >= list*parseInt(page, 10) )
	{
		ShowList((parseInt(page, 10)-1)*list , parseInt(page, 10)*list, UserDevicesInfo);
	}
	else
	{
		ShowList((parseInt(page, 10)-1)*list , UserDevicesInfo.length , UserDevicesInfo);
	}
}

function RefreshShow()
{	
	window.location="userdevinfolan.asp?" + parseInt(page, 10); 
}

function GetAllOnlineDevice()
{		
	var ObjPath = "x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i}&RequestFile=html/bbsp/userdevinfo/userdevinfolan.asp";
	var ParaList = 'HostName&IpAddr&MacAddr&PortType&PortID&TrafficSend&TrafficRecv&DevStatus&time&IpType&x.X_HW_Token=' + getValue('onttoken');
	var DevInfo = HwAjaxGetPara(ObjPath, ParaList);
	var TempUserDevinfos = $.parseJSON(DevInfo);
	var TempUserDevinfosLen = TempUserDevinfos.length -1;
	var DevNum = 0;
	var i = 0;
	
	for (i = 0; i < TempUserDevinfosLen; i++)
	{
		if('ETH' ==TempUserDevinfos[i].PortType.toUpperCase())
		{
			DevNum ++; 
			UserDevinfo.push(new USERDevice(TempUserDevinfos[i].IpAddr,TempUserDevinfos[i].MacAddr,TempUserDevinfos[i].PortID,TempUserDevinfos[i].IpType,
			   TempUserDevinfos[i].DevType, TempUserDevinfos[i].DevStatus,TempUserDevinfos[i].PortType,TempUserDevinfos[i].time,TempUserDevinfos[i].HostName,
			   TempUserDevinfos[i].TrafficSend,TempUserDevinfos[i].TrafficRecv));
		}
	}

	for (i = 0; i < UserDevinfo.length; i++)
	{
		var Name_i = FindHostNameItemByMac(UserDevinfo[i].MacAddr);	
		if(Name_i > -1 && HomeNetNameList[Name_i].Name != "")
		{
			UserDevinfo[i].HostName = HomeNetNameList[Name_i].Name;
		}		
	}

	InitFirstPage(UserDevinfo.length);
	if (false == IsValidPage(page))
	{
		page = (0 == DevNum) ? 0:1;
	}
	$("#linenumspan").html("( " + htmlencode(DevNum) + " )");
	$("#prv").after(parseInt(page, 10) + "/" + lastpage);
	ShowListControl(UserDevinfo);
	DynamicDataRefreshStart();

	$('#Parentalctrlhelp').bind("click", function()
	{	
		RefreshShow();
	});
	
}

function Appendstr(str)
{
	return str;
}

function UpdateRate(startlist , endlist, TempUserDevinfos)
{
	var i = 0;
	var j = 0;
	var DevOnlineFlag = 0;
	var UpTraffic = 0;
	var DownTraffic = 0;
	var uint_H = 0;
	var uint_M = 0;	
	var TimeSpread = (EndTime.getTime() > StartTime.getTime())?(EndTime.getTime() - StartTime.getTime())/1000: 3;
	StartTime = EndTime;
	
	for(i = startlist; i <= (endlist - 1); i++)
	{	
		DevOnlineFlag = 0;
		for(j = 0; j < (TempUserDevinfos.length-1); j++)
		{
			if(UserDevinfo[i].MacAddr.toUpperCase() == TempUserDevinfos[j].MacAddr.toUpperCase())
			{
				if(TempUserDevinfos[j].DevStatus.toUpperCase() == "ONLINE")
				{
					if (parseInt(TempUserDevinfos[j].TrafficSend, 10) >=  parseInt(UserDevinfo[i].TrafficSend, 10))
					{
						UpTraffic = parseInt(TempUserDevinfos[j].TrafficSend, 10) - parseInt(UserDevinfo[i].TrafficSend, 10);
						if(UpTraffic >= 0)
						{
							$("#uprate_"+i).html(parseInt(UpTraffic/1024/TimeSpread, 10) + "KB/s");					
						}

					}

					if (parseInt(TempUserDevinfos[j].TrafficRecv, 10) >= parseInt(UserDevinfo[i].TrafficRecv, 10))					
					{
						DownTraffic = parseInt(TempUserDevinfos[j].TrafficRecv, 10) - parseInt(UserDevinfo[i].TrafficRecv, 10);
						if(DownTraffic >= 0)
						{
							$("#downrate_"+i).html(parseInt(DownTraffic/1024/TimeSpread, 10) + "KB/s");
						}
					}
					DevOnlineFlag = 1;
	
				}
				UserDevinfo[i].TrafficSend = TempUserDevinfos[j].TrafficSend;
				UserDevinfo[i].TrafficRecv = TempUserDevinfos[j].TrafficRecv;	
				break;
			}
		}
			
		$("#devstatus_"+i).html(userdevinfo_language[TempUserDevinfos[j].DevStatus]);
		if(1 == DevOnlineFlag)
		{
			var unit_h = (parseInt(TempUserDevinfos[j].time.split(":")[0], 10) > 1) ? userdevinfo_mainpage_language['bbsp_hours'] : userdevinfo_mainpage_language['bbsp_hour'];
			var unit_m = (parseInt(TempUserDevinfos[j].time.split(":")[1], 10) > 1) ? userdevinfo_mainpage_language['bbsp_mins'] : userdevinfo_mainpage_language['bbsp_min'];
			$("#timeshow_"+i).html(htmlencode(TempUserDevinfos[j].time.split(":")[0] + unit_h + TempUserDevinfos[j].time.split(":")[1] + unit_m));					
		}
		else
		{
			$("#uprate_"+i).html("0KB/s");
			$("#downrate_"+i).html("0KB/s");
			$("#timeshow_"+i).html("--");
		}
	}
}

function UpDateSpeed()
{		
	EndTime = new Date();	
	var ObjPath = "x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i}&RequestFile=html/bbsp/userdevinfo/userdevinfolan.asp";
	var ParaList = 'HostName&IpAddr&MacAddr&PortType&PortID&TrafficSend&TrafficRecv&DevStatus&time&IpType&x.X_HW_Token=' + getValue('onttoken');
	var DevInfo = HwAjaxGetPara(ObjPath, ParaList);
	var TempUserDevinfos = $.parseJSON(DevInfo);

	if(UserDevinfo.length == 0)
	{
		UpdateRate(0 , 0, TempUserDevinfos);
	}
	else if( UserDevinfo.length >= list*parseInt(page, 10) )
	{
		UpdateRate((parseInt(page, 10)-1)*list , parseInt(page, 10)*list, TempUserDevinfos);
	}
	else
	{
		UpdateRate((parseInt(page, 10)-1)*list , UserDevinfo.length , TempUserDevinfos);
	}
}

function SubmitFirst()
{
	page = firstpage;
	
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	window.location="userdevinfolan.asp?" + parseInt(page, 10);
}

function SubmitPrv()
{
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	page--;
	window.location="userdevinfolan.asp?" + parseInt(page, 10);
}

function SubmitNext()
{
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	page++;
	window.location="userdevinfolan.asp?" + parseInt(page, 10);
}

function SubmitLast()
{
	page = lastpage;
	if (false == IsValidPage(page))
	{
		AlertEx(userdevinfo_language['bbsp_faulturl']);
		return;
	}
	
	window.location="userdevinfolan.asp?" + parseInt(page, 10);
}

function SubmitJump()
{
	var jumppage = getValue('pagejump');
	if(isInteger(jumppage) != true)
	{
		setText('pagejump', '');
		return;
	}
	if(jumppage < firstpage)
	{
		jumppage = firstpage;
	}
	if(jumppage > lastpage)
	{
		jumppage = lastpage;
	}
	window.location="userdevinfolan.asp?" + jumppage;
}

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = userdevinfo_language[b.getAttribute("BindText")];
	}
}



var SpeedUpdateTimer;

function DynamicDataRefreshStart ()
{
	StartTime = new Date();
	SpeedUpdateTimer = setInterval("UpDateSpeed();", 3000);
}

function LoadFrame()
{
	loadlanguage();
		
	setTimeout("GetAllOnlineDevice();", 1000);
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("userdevinfotitle", GetDescFormArrayById(userdevinfo_language, "bbsp_mune"), GetDescFormArrayById(userdevinfo_language, "bbsp_userdevinfolan_title"), false);
</script> 
<div class="title_spread"></div>

<table>
	<tr>
		<td width="10%" ><span id="LineDevCntSpan" class="Tag_Title"> <script>document.write(userdevinfo_mainpage_language['bbsp_linedev']); </script></span></td>
		<td class="TagLineSpace"></td>
		<td width="10%" class="Tag_Title"><span id="linenumspan"></span></td>
		<td class="TagLineSpace"></td>
		<td width="80%"></td>
		<td width="10%"><div id="Parentalctrlhelp" name="Parentalctrlhelp" style="cursor:pointer;text-decoration:underline;font-size:14px;color:#0000FF;white-space:nowrap;"><script> document.write(userdevinfo_mainpage_language['bbsp_refresh']); </script></div></td>
	</tr>
</table>

<table class='width_per100' border="0" align="center" cellpadding="0" cellspacing="1" id='devlist'>
    <tr class="head_title">
    <td class='width_per15' BindText='bbsp_hostname'></td>
	<td class="per_13_16" 	BindText='bbsp_userdevinfo'></td> 
    <td class='per_13_13' 	BindText='bbsp_devstate'></td> 
    <td class="width_per13" BindText='bbsp_connecttimes'></td> 
    <td class="per_13_20" 	BindText='bbsp_uprate'></td>
    <td class="per_13_20" 	BindText='bbsp_downrate'></td>
    <td class="per_15_20"   BindText='bbsp_app'></td> 
    </tr> 
</table> 

<table class='width_per100' border="0" cellspacing="0" cellpadding="0" > 
	<tr > 
		<td class='width_per40'></td> 
		<td class='title_bright1' >
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
			<input name="first" id="first" 	class="PageNext jumppagejumplastbutton_wh_px" 	type="button" value="<<" 	onClick="SubmitFirst();"/> 
			<input name="prv" 	id="prv"  	class="PageNext jumppagejumpbutton_wh_px" 		type="button" value="<" 	onClick="SubmitPrv();"/>
			<input name="next"  id="next" 	class="PageNext jumppagejumpbutton_wh_px" 		type="button" value=">" 	onClick="SubmitNext();"/> 
			<input name="last"  id="last" 	class="PageNext jumppagejumplastbutton_wh_px" 	type="button" value=">>" 	onClick="SubmitLast();"/> 
		</td>
		<td class='width_per5'></td>
		<td  class='title_bright1'>
			<script> document.write(routeinfo_language['bbsp_goto']); </script> 
				<input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
			<script> document.write(routeinfo_language['bbsp_page']); </script>
		</td>
		<td class='title_bright1'>
			<button name="jump"  id="jump" class="PageNext jumpbutton_wh_px" type="button" onClick="SubmitJump();"> <script> document.write(routeinfo_language['bbsp_jump']); </script></button> 
		</td>
	</tr> 
</table> 
<script language="JavaScript" type="text/javascript">
	if(CuOSGIMode == "1")
	{		
		$("#Parentalctrlhelp").css({
			"color" : "#ff9800"
		});
	}
</script>
</body>
</html>
