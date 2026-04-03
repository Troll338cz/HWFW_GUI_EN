<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>User Device detail Information</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<style type="text/css" >
	* {
	}
	.clearfix:after{
		 content: "020"; 
		 display: block; 
		 height: 0; 
		 clear: both; 
		 visibility: hidden;  
	 }
	.clearfix {
		 zoom: 1; 
	 }
	.Modle-div {
		width:100%;
	}
	.Modle-div .Modle-desc {
		width:840px;
		margin:20px auto 10px;
		line-height:20px;
	}
	.Modle-div .connect-img {
		width:720px;
		height:335px;
		margin:0 auto;
		position:relative;
	}
	.Modle-div .connect-img div {
		background:url(../../../images/cus_images/local_connect.png) no-repeat;
		position:absolute;
	}
	.Modle-div .connect-img .common-size {
		width:56px;
		height:60px;
		cursor:pointer;
	}
	.Modle-div .connect-img .internet {
		left:332px;
	}
	.Modle-div .connect-img .line {
		width:56px;
		height:23px;
		background-position:-300px -15px;
		left:348px;
		top:80px;
	}
	.Modle-div .connect-img .line2 {
		top:184px;
	}
	.Modle-div .connect-img .router {
		left:332px;
		top:103px;
		background-position:-60px 0;
	}
	.Modle-div .connect-img .connect-frame {
		width:704px;
		height:51px;
		background-position:0 -60px;
		top:180px;
		left:8px;
	}
	.Modle-div .connect-img .pc {
		background-position:-120px 0;
		top:224px;
	}
	.Modle-div .connect-img .printer {
		background-position:-180px 0;
		left:174px;
		top:224px;
	}
	.Modle-div .connect-img .device {
		background-position:-240px 0;
		top:224px;
	}
	.Modle-div .connect-img span {
		font-size:14px;
		position:absolute;
	}
	.Modle-div .connect-img .internet-span {
		top:60px;
		left:338px;
	}
	.Modle-div .connect-img .router-span {
		top:160px;
		left:338px;
	}
	.Modle-div .connect-img .common-span {
		top:280px;
		width:120px;
		line-height:24px;
		text-align:center;
	}
	.tabal_noborder_bg {
	padding:0px 0px 10px 0px;
	background-color: #FAFAFA;
	}
</style>
<script language="JavaScript" type="text/javascript">
var DHCPLeaseTimes = new Array();
var UserDevices = new Array();
var clickIndex = -1;
var PreDevIdx = -1;
var DevIdx = -1;
var IsClickRouter = false;
var options = {
		initNum: 5,             
		showFrame:true          
	}
	
function stUserDev(macaddr, hostname, devtype)
{
	this.macaddr = macaddr;
    this.hostname = hostname;
    this.devtype = devtype;
}
	
var UserDevUserDefList = <%GetUserDefUserDeviceInfo();%>;

function connectShowPage(userOptions) {
	$.extend(options, userOptions);
	var initNum = options.initNum;
	var showFrame = options.showFrame;
	var deviceNum = $(".common-device").length;
	var rowAll = Math.ceil(deviceNum / initNum);
	var blockSpace = 640 / (initNum - 1);
	var blockHeight = showFrame ? 150 : 80;
	$(".connect-img").css("height", 335 + (rowAll - 1) * blockHeight + "px");
	if (showFrame) {
		for (var i = 1; i < rowAll; i++) {
			$(".connect-frame").eq(0).after("<div class=\"connect-frame\"></div>");
		}
	}
	$(".connect-frame").each(function (index) {
		var obj = $(this);
		obj.css("top", 180 + index * blockHeight + "px");
	});
	
	if (rowAll==1) {
		if (deviceNum == 1) {
			$(".connect-frame").eq(0).hide();
		}
		var blockWidth = parseFloat(blockSpace * (deviceNum - 1));
		var startLocation = parseFloat($(".connect-img").width() - blockWidth) / 2;
		$(".common-device").each(function (index) {
			var obj = $(this);
			if (deviceNum == 1) {
				obj.css("top", "202px");
				$(".common-span").eq(index).css("top", "262px");
			} else {
				obj.css("top", "228px");
				$(".common-span").eq(index).css("top", "288px");
			}
			obj.css("left", -31 + startLocation + blockSpace * index + "px");
			$(".common-span").eq(index).css("left", -61 + startLocation + blockSpace * index + "px");
			if (showFrame && deviceNum > 1) {
				obj.after("<div class=\"line\"></div>");
				obj.next("div").css("top", "210px");
				obj.next("div").css("left", -12 + startLocation + blockSpace * index + "px");
			}
		});

		var frameWidth = blockWidth + 70;
		var frameStart = startLocation-35;
		$(".connect-frame").eq(0).css({ "width": frameWidth, "left": frameStart });
	} else {
		$(".common-device").each(function (index) {
			var obj = $(this);
			var rowNow = Math.floor((index) / initNum);
			obj.css("top", 228 + blockHeight * rowNow + "px");
			$(".common-span").eq(index).css("top", 288 + blockHeight * rowNow + "px");
			if (showFrame || index < initNum) {
				obj.after("<div class=\"line\"></div>");
				obj.next("div").css("top", 210 + blockHeight * rowNow + "px");
			}
			var diviceLocation = parseInt(index % initNum);
			obj.css("left", 9 + blockSpace * diviceLocation + "px");
			$(".common-span").eq(index).css("left", -21 + blockSpace * diviceLocation + "px");
			if (showFrame || index < initNum) {
				obj.next("div").css("left", 28 + blockSpace * diviceLocation + "px");
			}
		});
	}
	$(".common-size").hover(function () {
		var obj = $(this);
		var old_top = obj.css("top");
		obj.css("top", parseInt(old_top) + 4 + "px");
		obj.next().next().css("color", "#0193de");
	}, function () {
		var obj = $(this);
		var new_top = obj.css("top");
		obj.css("top", parseInt(new_top) - 4 + "px");
		obj.next().next().css("color", "#000");
	});
	$("#imgRouter").click(function() {
		ClickRouter();
    });
	$("#imgRouter").hover(function(){
		$("#spanRouter").css("color", "#0193de");
    }, function () {
		$("#spanRouter").css("color", "#000");
	});
}

function NameList(Domain,MACAddress,Name)
{
	this.Domain 	= Domain;
	this.MACAddress	    = MACAddress;
	this.Name	= Name;
}
var HomeNetNameList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_WANSrcWhiteList, InternetGatewayDevice.X_HW_HOMENET_NAME.hosts.{i},MACAddress|Name, NameList);%>;

function FindNameItemByDevInfo(UserDevinfoItem)
{
	for (n=0; HomeNetNameList.length > 1 && n < HomeNetNameList.length -1; n++)
	{	
		if(HomeNetNameList[n].MACAddress.toUpperCase() == UserDevinfoItem.MacAddr.toUpperCase())
		{
			return n;
		}
	
	}
	return -1;
}

function filterWan(WanItem)
{
	if (!(WanItem.Tr069Flag == '0' && (Instance_IspWlan.IsWanHidden(domainTowanname(WanItem.domain)) == false)))
	{
		return false;	
	}
	return true;
}

var WanInfo = GetWanListByFilter(filterWan);

function FormatPortStr(port)
{
    var portList = port.split(':');
    if ((portList.length > 1) && (parseInt(portList[1], 10) == 0))
    {
        return portList[0];
    }

    return port;
}

function stPortMappingPortList(domain,Protocol,InternalPort,ExternalPort,ExternalSrcPort,flag)
{
    var portList;
    var pathString = domain.split('.');
    this.instId = 0;
    if((pathString.length > 0) && ("X_HW_Portlist" == pathString[pathString.length - 2])){
        this.instId = parseInt(pathString[pathString.length - 1], 10);;
    }
    this.domain = domain;
    this.Protocol = Protocol;
	this.flag = 0;
    
    portList = FormatPortStr(InternalPort).split(':');
    this.innerPortStart = portList[0];
    this.innerPortEnd = portList[0];
    if(portList.length > 1){
        this.innerPortEnd = portList[1];
    }
    
    portList = FormatPortStr(ExternalPort).split(':');
    this.exterPortStart = portList[0];
    this.exterPortEnd = portList[0];
    if(portList.length > 1){
        this.exterPortEnd = portList[1];
    }
    
    portList = FormatPortStr(ExternalSrcPort).split(':');
    this.exterSrcPortStart = portList[0];
    this.exterSrcPortEnd = portList[0];
    if(portList.length > 1){
        this.exterSrcPortEnd = portList[1];
    }
}

function stPortMap(domain,ProtMapEnabled,RemoteHost,RemoteHostRange,OperateRule,InClient,Description,ExternalIP)
{
    this.domain = domain;
    this.ProtMapEnabled = ProtMapEnabled;
    this.RemoteHost = RemoteHost;
	this.RemoteHostRange = RemoteHostRange;
	this.OperateRule = OperateRule;
    this.InClient = InClient;	
    this.Description = Description;
	this.ExternalIP = ExternalIP;
    var index = domain.lastIndexOf('PortMapping');
    this.Interface = domain.substr(0,index - 1);
}

var WanIPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.PortMapping.{i}.X_HW_Portlist.{i},Protocol|InternalPort|ExternalPort|ExternalSrcPort,stPortMappingPortList);%>;
var WanPPPPortMappingPortList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.PortMapping.{i}.X_HW_Portlist.{i},Protocol|InternalPort|ExternalPort|ExternalSrcPort,stPortMappingPortList);%>;
var WanIPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.PortMapping.{i},PortMappingEnabled|RemoteHost|X_HW_RemoteHostRange|X_HW_OperateRule|InternalClient|PortMappingDescription|X_HW_ExternalIP,stPortMap);%>;
var WanPPPPortMapping = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaArrayPortMapping, InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.PortMapping.{i},PortMappingEnabled|RemoteHost|X_HW_RemoteHostRange|X_HW_OperateRule|InternalClient|PortMappingDescription|X_HW_ExternalIP,stPortMap);%>; 

function FindWanInfoByPortMapping(portMappingItem)
{
	var wandomain_len = 0;
	var temp_domain = null;
	
	for(var k = 0; k < WanInfo.length; k++ )
	{
		wandomain_len = WanInfo[k].domain.length;
		temp_domain = portMappingItem.domain.substr(0, wandomain_len);
		
		if (temp_domain == WanInfo[k].domain)
		{
			return WanInfo[k];
		}
	}
	return false;
}

function SelectPortMappingPortList(portMappingDomain,wanPortMappingPortList)
{
    var idx;
    var parentDomain;
    var portList = new Array(0);
    
    for(var i = 0; i < wanPortMappingPortList.length-1; i++)
    {
        idx = wanPortMappingPortList[i].domain.lastIndexOf(".X_HW_Portlist");
        if(idx < 0)
        {
            return '';
        }
        parentDomain = wanPortMappingPortList[i].domain.substr(0,idx);
        if(portMappingDomain == parentDomain)
        {
            portList.push(wanPortMappingPortList[i]);
        }
    }
    return portList;
}

var PortMapping = new Array();
var Idx = 0;
for (var i = 0; i < WanIPPortMapping.length-1; i++)
{
	if(WanIPPortMapping[i].InClient=="")
	{
		continue;
	}
	if(false == FindWanInfoByPortMapping(WanIPPortMapping[i]))
	{
		continue;
	}
	var tmpWan = FindWanInfoByPortMapping(WanIPPortMapping[i]);
    if (tmpWan.ServiceList != 'TR069'
       && tmpWan.ServiceList != 'VOIP'
       && tmpWan.ServiceList != 'TR069_VOIP'
       && tmpWan.Mode == 'IP_Routed')
	{    
	    PortMapping[Idx] = WanIPPortMapping[i];
		PortMapping[Idx].Interface = MakeWanName(tmpWan);
	    PortMapping[Idx].PortList = SelectPortMappingPortList(WanIPPortMapping[i].domain,WanIPPortMappingPortList);
		Idx ++;
	}
}
for (var j = 0; j < WanPPPPortMapping.length-1; j++,i++)
{
	if(WanPPPPortMapping[j].InClient=="")
	{
		continue;
	}
	if(false == FindWanInfoByPortMapping(WanPPPPortMapping[j]))
	{
		continue;
	}
    var tmpWan = FindWanInfoByPortMapping(WanPPPPortMapping[j]);   

    if (tmpWan.ServiceList != 'TR069'
		&& tmpWan.ServiceList != 'VOIP'
		&& tmpWan.ServiceList != 'TR069_VOIP'
		&& tmpWan.Mode == 'IP_Routed')
	{
		PortMapping[Idx] = WanPPPPortMapping[j];
		PortMapping[Idx].Interface = MakeWanName(tmpWan);
	    PortMapping[Idx].PortList = SelectPortMappingPortList(WanPPPPortMapping[j].domain,WanPPPPortMappingPortList);

		Idx ++;   
	}
}

function findOpenPortByIp(ipaddr)
{
	var len = 0;
	for (var i = 0; i < PortMapping.length; i++)
	{
		if ((ipaddr == PortMapping[i].InClient) && (0 != PortMapping[i].ProtMapEnabled))
		{	
			var PortListRec = PortMapping[i].PortList;
			len = PortListRec.length;
			return len;
		}
	}
	return len;
}

function setDevInfo(DevInfo)
{
	var i = 0;
	setText('DevName', DevInfo.HostName);
	for (i = 0; i < gCondetailInfo.length - 1; i++)
	{
		if (gCondetailInfo[i].DevName == DevInfo.DevType)
		{
			setSelect('DevType1', DevInfo.DevType);
			break;
		}
	}

	if (i == (gCondetailInfo.length - 1))
	{
		setSelect('DevType1', 'Desktop PC');
	}
	
	setElementInnerHtmlById("IPAddr", DevInfo.IpAddr);
	for(i = 0; i < UserDevUserDefList.length - 1; i++)
	{
		if(DevInfo.MacAddr == UserDevUserDefList[i].macaddr)
		{
			setText('DevName', UserDevUserDefList[i].hostname);
			setSelect('DevType1', UserDevUserDefList[i].devtype);
		}
	}	
	if ('ETH' == DevInfo.PortType.toUpperCase())
	{
		document.getElementById("ConnectType").innerHTML = userdevinfo_language['bbsp_eth'];
	}
	else if('WIFI' == DevInfo.PortType.toUpperCase())
	{
		document.getElementById("ConnectType").innerHTML = userdevinfo_language['bbsp_wifi'];
	}
	var len = findOpenPortByIp(DevInfo.IpAddr);
	if (0 == len)
	{
		document.getElementById("OpenPort").innerHTML = userdevinfo_language['bbsp_no'];
	}
	else
	{
		document.getElementById("OpenPort").innerHTML = userdevinfo_language['bbsp_yes'];
	}
}

function clickConnectDev(params)
{
	var parameterS = params.split("_");
	var MacInfo = parameterS[1];
	for(var Index = 0; Index < UserDevices.length - 1; Index++ )
	{
		if(MacInfo == UserDevices[Index].MacAddr)
		{
			clickIndex = Index;
			break;
		}
	}
	if (-1 != clickIndex)
	{
		PreDevIdx = DevIdx;
   		DevIdx = clickIndex;
		setDevInfo(UserDevices[clickIndex]);
		if (false == UserDevices[clickIndex].IsClickDev)
		{
			UserDevices[clickIndex].IsClickDev = true;
			if (-1 != PreDevIdx)
			{
				UserDevices[PreDevIdx].IsClickDev = false;
			}
			setDisplay('DivDevCfg',1);
		}
		else
		{
			UserDevices[clickIndex].IsClickDev = false;
			if (-1 != PreDevIdx)
			{
				UserDevices[PreDevIdx].IsClickDev = false;
			}
			setDisplay('DivDevCfg',0);
		}
	}
	IsClickRouter = false;
	setDisplay('DivNetworkCfg',0);
}

function CondetailInfo(DevType, DevName, DevClass)
{
	this.DevType = DevType;
	this.DevName = DevName;
	this.DevClass = DevClass;
}

var gCondetailInfo = new Array( new CondetailInfo("0","Desktop PC","common-device pc common-size"),
								new CondetailInfo("1","Phone","common-device pc common-size"),
								new CondetailInfo("2","TV","common-device device common-size"),
								new CondetailInfo("3","Mini Hi-Fi System","common-device device common-size"),
								new CondetailInfo("4","Hard disk","common-device device common-size"),
								new CondetailInfo("5","Notebook","common-device device common-size"),
								new CondetailInfo("6","Mobile phone","common-device pc common-size"),
								new CondetailInfo("7","Game console","common-device device common-size"),
								new CondetailInfo("8","Printer","common-device printer common-size"),
								new CondetailInfo("9","Other","common-device pc common-size"),
								new CondetailInfo("10","Unknown","common-device pc common-size"),
								null);
								
function getDevClassByDevType(devtype)
{
	var devclass = "common-device device common-size";

	for (var i = 0; i < gCondetailInfo.length - 1; i++)
	{
		if (gCondetailInfo[i].DevName == devtype)
		{
			devclass = gCondetailInfo[i].DevClass;
			return devclass;
		}
	}

	return devclass;
}

function getDevNameByMac(MacAddr, HostName)
{
	for(var i = 0; i < UserDevUserDefList.length - 1; i++)
	{
		if(UserDevUserDefList[i].macaddr == MacAddr)
		{
			return UserDevUserDefList[i].hostname;
		}
	}
	return HostName;
}

function getNewDevType(MacAddr, DevType)
{
	for(var i = 0; i < UserDevUserDefList.length - 1; i++)
	{
		if(UserDevUserDefList[i].macaddr == MacAddr)
		{
			return UserDevUserDefList[i].devtype;
		}
	}
	if ((DevType == '0') || (DevType == '') || (DevType == 'null'))
	{
		return 'Desktop PC';
	}
	return DevType;
}

function ShowCntDevDetails(DataIn)
{
	var numIn = DataIn.length - 1;
	var Data = new Array();
	var DataIndex = 0;
	for(var index = 0; index < numIn; index++)
	{			
		Data[DataIndex] = DataIn[index];
		DataIndex++;
	}
		
	num = DataIndex;
	var html = "";
	if(num == 0)
	{
		setDisplay('DivContentDevice',0);
		return;
	}
	
	for(var index = 0; index < num; index++)
	{	
		var idname= Data[index].PortType + "_" + Data[index].MacAddr;
		var devtype = getNewDevType(Data[index].MacAddr,Data[index].DeviceType);
		var DevClass = getDevClassByDevType(devtype);	
		var DevName = getDevNameByMac(Data[index].MacAddr, Data[index].HostName);
				
		html += '<div id="'+ idname +'" class="'+DevClass+'" onclick="clickConnectDev(this.id);"></div>';
		html += '<span class="common-span">'+htmlencode(DevName)+'</span>';
	}
	document.write(html);
}

function ClickRouter()
{
	if (false == IsClickRouter)
	{
		IsClickRouter = true;
		setDisplay('DivNetworkCfg',1);
	}
	else
	{
		IsClickRouter = false;
		setDisplay('DivNetworkCfg',0);
	}
	
	for (var i=0; UserDevices.length > 0 && i < UserDevices.length -1; i++)
	{
		UserDevices[i].IsClickDev = false; 
	}
	PreDevIdx = -1;
	DevIdx = -1;
	setDisplay('DivDevCfg',0);
}

function ChangeDevType()
{

}

function InitDeviceType()
{
	var List = getElementById("DevType1");
	List.options.length = 0;
	List.options.add(new Option(userdevinfo_language['bbsp_DesktopPC'],"Desktop PC"));
	List.options.add(new Option(userdevinfo_language['bbsp_Phone'],"Phone"));
	List.options.add(new Option(userdevinfo_language['bbsp_TV'],"TV"));
	List.options.add(new Option(userdevinfo_language['bbsp_MiniHiFi'],"Mini Hi-Fi System"));
	List.options.add(new Option(userdevinfo_language['bbsp_HardDisk'],"Hard disk"));
	List.options.add(new Option(userdevinfo_language['bbsp_Notebook'],"Notebook"));
	List.options.add(new Option(userdevinfo_language['bbsp_MobilePhone'],"Mobile phone"));
	List.options.add(new Option(userdevinfo_language['bbsp_GameConsole'],"Game console"));
	List.options.add(new Option(userdevinfo_language['bbsp_Printer'],"Printer"));
	List.options.add(new Option(userdevinfo_language['bbsp_Other'],"Other"));
	List.options.add(new Option(userdevinfo_language['bbsp_Unknown'],"Unknown"));
}

function AppPort(val)
{
	val.id = '';
	val.NameStr = 'Ports';
	if (-1 != clickIndex)
	{
		val.name = '/html/bbsp/portmapping/portmappingtde.asp?'+UserDevices[clickIndex].IpAddr;
	}
	else
	{
		val.name = '/html/bbsp/portmapping/portmappingtde.asp';
	}
	window.parent.OnChangeIframeShowPage(val); 
}

function FindHostNameItemByMac(MacAddress)
{
	for (n=0; HomeNetNameList.length > 1 && n < HomeNetNameList.length -1; n++)
	{	
		if(HomeNetNameList[n].MACAddress.toUpperCase() == MacAddress.toUpperCase())
		{
			return n;
		}
	
	}
	return -1;
}


function GetAndString(str)
{
    if(!!str)
    {
        str = str.toString().replace(/%/g,"%25");
        str = str.toString().replace(/&/g,"%26");
    }
    return str;
}


function setDevUserDef(macaddr, macreplace, hostname, devtype)
{
	var conflict = false; 
	$.ajax({
        type  : "POST",
        async : false,
        cache : false,
        data  : "macaddr=" + macaddr+ "&macreplace=" + macreplace + "&hostname=" + GetAndString(hostname) + "&devtype=" + devtype + "&x.X_HW_Token=" + getValue('onttoken'),
        url   : "setUserDefUserDeviceInfo",
        success : function(data) {
            conflict = true;	
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            conflict = false;
        },
        complete: function (XHR, TS) { 
            XHR = null;
      }         
    }); 
	window.location="/html/bbsp/userdevinfo/userdevinfotde.asp";
	return conflict;
}

var tdeSpecailChar = ['Á','á','À','à','É','é','Í','í','Ó','ó',
                      'Ú','ú','Â','â','Ê','ê','Î','î','ö','Û',
					  'û','Ü','ü','Ç','ç','Ã','ã','Õ','õ','Ñ',
					  'ñ','€','´','·','¸','Ò','ò','Ù','ù','È',
					  'è','Ì','ì','Ï','ï','ª','¿','º'];
 

function checkSepcailStrValid(val)
{
    var findVar = 0;
	
    for ( var i = 0 ; i < val.length ; i++ )
	{
		var ch = val.charAt(i);
		if (ch >= ' ' && ch <=  '~')
		{
		    continue;
		}		
		else
		{
		    findVar = 0;
		    for (var j = 0; j < tdeSpecailChar.length; j++)
	        {
		        if(ch == tdeSpecailChar[j])
		        {
			        findVar = 1;
			        break;
		        }
	        }
			
			if (1 != findVar)
			{
			    return false;
			}
	        
		}
	}
	return true;
}

function getTDEStringActualLen(val)
{
    var actualLen = 0;
	for( var i = 0; i < val.length; i++ )
	{
	    var ch = val.charAt(i);
		if (ch >= ' ' && ch <=  '~')
		{
		    actualLen = actualLen + 1;
		}
        else
        {
		     if('€' == ch || '•' == ch)
			 {
			     actualLen = actualLen + 3;
			 }
			 else
			 {
			     actualLen = actualLen + 2;
			 }
		} 		
	}
	
	return actualLen;
}

function checkDevNameForTDE(devname)
{
	if (devname == '')
    {
        AlertEx(userdevinfo_language['bbsp_devnamenull']);
        return false;
    }

    if (devname.length > 32)
    {
        AlertEx(userdevinfo_language['bbsp_devnametoolong']);
        return false;
    }

    if (true != checkSepcailStrValid(devname))
    {
        AlertEx(userdevinfo_language['bbsp_devnameinvalid']);
        return false;
    }
	
	if(getTDEStringActualLen(devname) > 32)
	{
	    AlertEx(userdevinfo_language['bbsp_devnametoolong']);
        return false;
	}
    
    return true;
}

function ltrim(str)
{ 
 return str.replace(/(^\s*)/g,""); 
}

function ApplyDevConfig()
{
	var newName  = getValue('DevName');

    newName = ltrim(newName);
    if(false == checkDevNameForTDE(newName))
    {
        return false;
    }
	
	var newDevType = getSelectVal('DevType1');
	
	var MacAddrReplace = '';
	if (UserDevUserDefList.length > 512)
	{
		for(i = 0; i < UserDevUserDefList.length - 1; i++)
		{
			if (UserDevUserDefList[i].macaddr == UserDevices[clickIndex].MacAddr)
			{
				setDevUserDef(UserDevices[clickIndex].MacAddr, MacAddrReplace, newName, newDevType);
				return true;
			}
		}

		for(i = 0; i < UserDevUserDefList.length - 1; i++)
		{
			for (var j = 0; j < UserDevices.length - 1; j ++)
			{
				if (UserDevUserDefList[i].macaddr == UserDevices[j].MacAddr) 
				 {
					break;
				 }
			}
			if (j == (UserDevices.length - 1))
			{
				MacAddrReplace = UserDevUserDefList[i].macaddr;
				break;
			}
		}
	}
	setDevUserDef(UserDevices[clickIndex].MacAddr, MacAddrReplace, newName, newDevType);
}

function CancelDevConfig()
{
	if (-1 != clickIndex)
	{
		setDisplay('DivDevCfg',0);
	}
}

function AppDhcpv4(val)
{
	val.id = 'networksettings';
	val.NameStr = 'Local network settings';
	val.name = 'html/bbsp/dhcpservercfg/dhcp2tde.asp';
	window.parent.OnChangeIframeShowPage(val); 
}

function AppUserNat(val)
{
	val.id = 'Userconfig';
	val.NameStr = 'Multi-User/Single-User';
	val.name = 'html/bbsp/guideinternet/guideinternettde.asp';
	window.parent.OnChangeIframeShowPage(val); 
}

function LoadFrame()
{
	options.initNum = 6;
	options.showFrame = true;
	connectShowPage(options);
}

</script>
</head>
<body  class="iframebody" onLoad="LoadFrame();"> 
<div style="height:20px;"></div>
<div id="DivUserdevice" class="FuctionPageAreaCss">
<div id="UserdeviceTitle" class="FunctionPageTitleCss">
<span id="UserdeviceTitleText" class="PageTitleTextCss" BindText="bbsp_localnetmap"></span>
</div>

<div class="FuctionPageContentCss">
<div class="PageSumaryInfoCss" BindText="bbsp_localnetmap_title"></div>
</div>

<div class="Modle-div">
	<div class="connect-img">
		<div id="imgInternet" class="internet common-size"></div>
		<span class="internet-span" BindText="bbsp_internet"></span>
		<div class="line"></div>
		<div id="imgRouter" class="router common-size"></div>
		<span id="spanRouter" class="router-span" BindText="bbsp_router"></span>
		<div class="line line2"></div>
		<div class="connect-frame"></div>
		<div id="DivContentDevice">
		<script>
			GetLanUserDevInfoNoDelay(function(para)
			{
				UserDevices = para;
				for (var i=0; UserDevices.length > 0 && i < UserDevices.length -1; i++)
				{
					var Name_i = FindNameItemByDevInfo(UserDevices[i]);
					if(Name_i > -1)
					{
						UserDevices[i].HostName = HomeNetNameList[Name_i].Name;
					}	
				}
				ShowCntDevDetails(para);
			});
		</script>
		</div>
	</div>
</div>
</div>
  
<div style="height:20px;"></div>
<div id="DivDevCfg" class="FuctionPageAreaCss" style="display:none;">
<div id="DevCfgTitle" class="FunctionPageTitleCss">
<span id="DevCfgText" class="PageTitleTextCss" BindText="bbsp_devcfgtitle"></span>
</div>
<form id="DevConfigForm">
<div style="height:30px;"></div>
<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
	<li   id="DevName"        		    RealType="TextBox"      	  DescRef="bbsp_namemh"        	      RemarkRef="Empty"     				ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   InitValue="Empty"/>
	<li   id="DevType"                  RealType="HtmlText"           DescRef="bbsp_typemh"               RemarkRef="Empty"                     ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"  InitValue="Empty" />
	<li   id="DevType1"                 RealType="DropDownList"       DescRef="bbsp_typemh"               RemarkRef="Empty"                     ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"  InitValue="Empty"  ClickFuncApp="onchange=ChangeDevType"/>
	<li   id="IPAddr"                   RealType="HtmlText"           DescRef="bbsp_ipmh"                 RemarkRef="Empty"                     ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"       InitValue="Empty"  MaxLength="15"/>
	<li   id="ConnectType"              RealType="HtmlText"           DescRef="bbsp_connecttypemh"        RemarkRef="Empty"     			    ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"           InitValue="Empty"  />
	<li   id="OpenPort"                 RealType="HtmlText"           DescRef="bbsp_openportmh"           RemarkRef="Empty"    			        ErrorMsgRef="Empty"    Require="FALSE"     BindField="Empty"  InitValue="Empty"/>
</table>
<script>
	var TableClass = new stTableClass("PageSumaryTitleCss tablecfg_title width_per25", "tablecfg_right width_per75", "ltr");
	var DevConfigFormList = new Array();
	DevConfigFormList = HWGetLiIdListByForm("DevConfigForm");
	HWParsePageControlByID("DevConfigForm", TableClass, userdevinfo_language, null);
	setDisplay('DevTypeRow',0);
	InitDeviceType();
</script>
<div style="height:30px;"></div>
</form>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> 
  <td class="tablecfg_submit"> 
   <button id="btnAppPort" name="btnAppPort" type="button" class="BluebuttonGreenBgcss buttonwidth_150px_250px" style="margin-left: 15px;" onClick="AppPort(this);"><script>document.write(userdevinfo_language['bbsp_appport']);</script> </button> 
  </td>
  <td class='width_per25 tablecfg_submit'></td> 
  <td class="tablecfg_submit" > 
   <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	<button name="cancelValue" id="cancelValue" type="button" class="BluebuttonGreenBgcss buttonwidth_100px" style="margin-left: 0px;" onClick="CancelDevConfig();"><script>document.write(dhcp2_language['bbsp_cancel']);</script> </button> 
	<button id="btnApply" name="btnApply" type="button" class="BluebuttonGreenBgcss buttonwidth_100px" style="margin-left: 36px;" onClick="ApplyDevConfig();"><script>document.write(dhcp2_language['bbsp_app']);</script> </button>
  </td>
</tr> 
</table> 
<div style="height:30px;"></div>
</div>
</div>

<div id="DivNetworkCfg" class="FuctionPageAreaCss" style="display:none;" >
<div id="NetworkCfgTitle" class="FunctionPageTitleCss">
<span id="NetworkCfgText" class="PageTitleTextCss" BindText="bbsp_devcfgtitle"></span>
</div>
<div style="height:30px;"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tablecfg_submit"> 
<tr> 
  <td class="tablecfg_submit" > 
   <button id="btnAppDhcpv4" name="btnAppDhcpv4" type="button" class="BluebuttonGreenBgcss buttonwidth_150px_250px" style="margin-left: 15px;" onClick="AppDhcpv4(this);"><script>document.write(userdevinfo_language['bbsp_networksettings']);</script> </button> 
   </td>
</tr>
<tr style="height:20px;"></tr>
<tr>
  <td class="tablecfg_submit" > 
   <button id="btnAppUserNat" name="btnAppUserNat" type="button" class="BluebuttonGreenBgcss buttonwidth_150px_250px" style="margin-left: 15px;" onClick="AppUserNat(this);"><script>document.write(userdevinfo_language['bsp_usernat']);</script> </button> 
   </td>
</tr> 
</table> 
<div style="height:30px;"></div>
</div>
<div class="title_spread"></div>

<script>
	ParseBindTextByTagName(userdevinfo_language, "div",  1);
	ParseBindTextByTagName(userdevinfo_language, "span",  1);
	ParseBindTextByTagName(userdevinfo_language, "td",    1);
	ParseBindTextByTagName(userdevinfo_language, "input", 2);
</script>
</body>
</html>
