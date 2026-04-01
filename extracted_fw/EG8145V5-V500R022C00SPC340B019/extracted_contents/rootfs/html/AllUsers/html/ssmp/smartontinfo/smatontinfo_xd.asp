<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/wanipv6state.asp"></script>
<script language="JavaScript" type="text/javascript">

var WanList = GetWanList();
var curUserType = '<%HW_WEB_GetUserType();%>';
var sysUserType = '0';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var opticInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.RxPower);%>';
var gponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT.State);%>';
var eponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT.State);%>';
var GUIDE_NULL = "--";
var isTurkcell2xdFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_XD_NODISPLAY);%>';

function GEInfo(domain,Mode,Speed,Status)
{
	this.domain		= domain;
	this.Mode 		= Mode;
	if(Mode==0)this.Mode = status_ethinfo_language['amp_port_halfduplex'];
	if(Mode==1)this.Mode = status_ethinfo_language['amp_port_fullduplex'];

    this.Speed = Speed;
    if(Speed==0)this.Speed = status_ethinfo_language['amp_port_10M'];
    if(Speed==1)this.Speed = status_ethinfo_language['amp_port_100M'];
    if(Speed==2)this.Speed = status_ethinfo_language['amp_port_1000M'];
    if(Speed==3)this.Speed = status_ethinfo_language['amp_port_2500M'];
    if(Speed==4)this.Speed = status_ethinfo_language['amp_port_10000M'];
    if(Speed==6)this.Speed = status_ethinfo_language['amp_port_5000M'];

	this.Status 	= Status; 
	if(Status==0)this.Status = status_ethinfo_language['amp_port_linkdown'];
	if(Status==1)this.Status = status_ethinfo_language['amp_port_linkup'];
}

function GetAccessMode()
{
	var accModes = new Array(["not initial", "NOT INITIAL"], ["gpon", "GPON"], ["epon", "EPON"], 
						["10g-gpon", "XG-PON"], ["Asymmetric 10g-epon", "Asymmetric 10G EPON"], 
						["Symmetric 10g-epon", "Symmetric 10G EPON"], ["ge", "GE"]);

	var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.XG_AccessMode);%>';

	var i=0;
	
	for( ; i<accModes.length; i++)
	{
		if(ontPonMode == accModes[i][0])
			return accModes[i][1];
	}
	
	return "--";
}

function GetLinkState(type)
{
	var dslStatus='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.Status);%>';
	var ethStatus='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.3.WANEthernetInterfaceConfig.Status);%>';
	var geInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Duplex|Speed|Link,GEInfo);%>;
  var ethTypes = '<%GetEthServiceTypes();%>';
  if (ethTypes !== '') {
    ethTypes = JSON.parse(ethTypes);
  }

	for (var i=0; i<ethTypes.length; i++)
	{
		if ((typeof ethTypes != "undefined") && 2 == ethTypes[i])
		{
			if (null != geInfos[i])
			{
				ethStatus = geInfos[i].Status;
				if (status_ethinfo_language['amp_port_linkdown'] == geInfos[i].Status)
					break;
				ethStatus = ethStatus + '<br>' + geInfos[i].Speed + '<br>' + geInfos[i].Mode;
				break;
			}
		}
	}
	if (type == "dsl")
	{
		return  dslStatus;
	}
	else if (type == "eth")
	{
		return ethStatus;
	}
	else
	{
		return "";
	}
}

function GetIPv6Address(wan)
{
	var AddressList = GetIPv6AddressList(wan.MacId);
	var AddressHtml = "";
	for (var m = 0; m < AddressList.length; m++)
	{			
		if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
		{				
			if (wan.Enable == "1")
			{
				if(AddressHtml == '')
					AddressHtml += AddressList[m].IPAddress;
				else
					AddressHtml += "<br>" + AddressList[m].IPAddress;
			}
		}
	}
	return AddressHtml;
}

function SetIPv4Addr(wan,id)
{
	if(("CONNECTED" == wan.Status.toUpperCase()) && ('' != wan.IPv4IPAddress) )
	{
		document.getElementById(id).innerHTML = htmlencode(wan.IPv4IPAddress);
	}
	else
	{
		document.getElementById(id).innerHTML = "--";
	}
}

function SetIPv6Addr(wan,id)
{
	var ipv6Wan = GetIPv6WanInfo(wan.MacId);
	var ipv6wanStatus = (ipv6Wan == undefined ? '':ipv6Wan.ConnectionStatus.toUpperCase());
	if("CONNECTED" == ipv6wanStatus)
	{
		document.getElementById(id).innerHTML = htmlencode(GetIPv6Address(wan));
	}
	else
	{
		document.getElementById(id).innerHTML = "--";
	}
}

function IsInternetWanUp(wan)
{
	if ('IPv4' == wan.ProtocolType)
	{
		return ("CONNECTED" == wan.Status.toUpperCase()) ? true : false;
	}
	else if ('IPv6' == wan.ProtocolType)
	{
		var ipv6Wan = GetIPv6WanInfo(wan.MacId);
		var ipv6wanStatus = (ipv6Wan == undefined ? '':ipv6Wan.ConnectionStatus.toUpperCase());
		return ("CONNECTED" == ipv6wanStatus) ? true : false;
	}
	else if ('IPv4/IPv6' == wan.ProtocolType)
	{
		var ipv6Wan = GetIPv6WanInfo(wan.MacId);
		var ipv6wanStatus = (ipv6Wan == undefined ? '':ipv6Wan.ConnectionStatus.toUpperCase());
		if("CONNECTED" == wan.Status.toUpperCase() || "CONNECTED" == ipv6wanStatus)
		{
			return true;
		}
		
		return false;
	}
	else
	{
		return false;
	}
}

function GetInternetWanstate()
{
	var Currentwan = null;	
    for (var i = 0; i < WanList.length; i++)
    {	
        if(('IP_Routed' == WanList[i].Mode) 
            && (WanList[i].ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)
			&& ("1" == WanList[i].Enable)
			&& IsInternetWanUp(WanList[i]))
        {
            Currentwan = WanList[i];	
			break;
        }
    }
	
	if (null == Currentwan)
    {
		document.getElementById("internettypevalue").innerHTML = '--';
		document.getElementById("internetip").innerHTML = '--';
		setDisplay('internetipRow',1);
		setDisplay('internetipv4Row',0);
		setDisplay('internetipv6Row',0);
		return;
    }
	
	document.getElementById("internettypevalue").innerHTML = htmlencode(Currentwan.ProtocolType);

	if ('IPv4' == Currentwan.ProtocolType)
	{
		SetIPv4Addr(Currentwan,'internetip');
		setDisplay('internetipRow',1);
		setDisplay('internetipv4Row',0);
		setDisplay('internetipv6Row',0);
	}
	else if ('IPv6' == Currentwan.ProtocolType)
	{
		SetIPv6Addr(Currentwan,'internetip');
		setDisplay('internetipRow',1);
		setDisplay('internetipv4Row',0);
		setDisplay('internetipv6Row',0);
	}
	else if ('IPv4/IPv6' == Currentwan.ProtocolType)
	{
		SetIPv4Addr(Currentwan,'internetipv4');
		SetIPv6Addr(Currentwan,'internetipv6');
		setDisplay('internetipRow',0);
		setDisplay('internetipv4Row',1);
		setDisplay('internetipv6Row',1);
	}
    return;
}

var InformStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserInfo.X_HW_InformStatus);%>';
function SetItmsInfoStatus()
{
	if( '0' == InformStatus )
	{
		document.write(SmartOntdes["smart016"]);
	} 
	else
	{
		document.write(SmartOntdes["smart015"]);
	}	
}

function LoadFrame()
{
	GetInternetWanstate();
    if (isTurkcell2xdFlag == 1) {
        document.getElementById('dsllinkinfo').style.display="none";
    }
}
</script>
</head>
<body onLoad="LoadFrame();" style="background-color:#EDF1F2;">
<div id="SmartOntInfo"> 
<div id="DSLInfo" class="SmartOntModule">
<div id="DSLInfoTitle" class="TitleBorderCss"><span id="DSLInfoTitleSpan" class="SmartinfoSpan" BindText="smart001_xd"></span></div>
<div id="dsllinkinfo" class="TitleSpace">
<div id="dsllinkdes" class="SmartinfoLeft" BindText="smart045_xd"></div>
<div id="dsllinkvalue" class="Smartinforight"><script type="text/javascript" language="javascript">document.write(GetLinkState("dsl"));</script></div>
</div>

<div id="ethlinkinfo" class="TitleSpace">
<div id="ethlinkdes" class="SmartinfoLeft" BindText="smart044_xd"></div>
<div id="ethlinkvalue" class="Smartinforight"><script type="text/javascript" language="javascript">document.write(GetLinkState("eth"));</script></div>
</div>
</div>

<div id="registerinfo" class="SmartOntModule_PonInfo">
<div id="registerTitle" class="TitleBorderCss"><span id="registerTitleSpan" class="SmartinfoSpan" BindText="smart009"></span></div>
<div id="itmsinfo" class="TitleSpace" style="display:none;">
<div id="itmsinfotitle" class="SmartinfoLeft" BindText="smart014"></div>
<div id="itmsinfovalue" class="Smartinforight"><script language="javascript">SetItmsInfoStatus()</script></div>
</div>
</div>

<div id="internetinfo" class="SmartOntModule_InterNet">
<div id="internetTitle" class="TitleBorderCss"><span id="internetTitleSpan" class="SmartinfoSpan" BindText="smart018"></span></div>
<div id="iptypeinfo" class="TitleSpace">
<div id="internettypedes" class="SmartinfoLeft" BindText="smart019"></div>
<div id="internettypevalue" class="Smartinforight"></div>
</div>
<div id="internetipRow" class="TitleSpace" style="display:none;">
<div id="internetipdes" class="SmartinfoLeft" BindText="smart020"></div>
<div id="internetip" class="Smartinforight"></div>
</div>
<div id="internetipv4Row" class="TitleSpace" style="display:none;">
<div id="internetipv4des" class="SmartinfoLeft" BindText="smart027"></div>
<div id="internetipv4" class="Smartinforight"></div>
</div>
<div id="internetipv6Row" class="TitleSpace" style="display:none;">
<div id="internetipv6des" class="SmartinfoLeft" BindText="smart028"></div>
<div id="internetipv6" class="Smartinforight"></div>
</div>

</div>
</div><!-- end of SmartOntInfo -->
<script>
ParseBindTextByTagName(SmartOntdes, "span", 1);
ParseBindTextByTagName(SmartOntdes, "td", 1);
ParseBindTextByTagName(SmartOntdes, "div", 1);
if(parseInt(mngttype, 10) == 1 && curUserType != sysUserType)
{
	$("#itmsinfo").css("display", "none");
}
else
{
	$("#itmsinfo").css("display", "block");
}
</script>
</div>
</body>
</html>
