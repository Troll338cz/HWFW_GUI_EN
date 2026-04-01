<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>layer3</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">

var landhcpenable ='<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCPS_UNI_CTL);%>';
var iponlyflg ='<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IPONLY);%>';
var UpportDetectFlag ='<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var supportTelmex = "<%HW_WEB_GetFeatureSupport(BBSP_FT_TELMEX);%>";
var supportIPTVPort = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
TopoInfo.EthNum = '<%GetLanPortNum();%>';

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
		b.innerHTML = layer3_language[b.getAttribute("BindText")];
	}
}

function stLayer3Info(l1,l2,l3,l4,l5)
{
    this.LAN1 = l1;
    this.LAN2 = l2;
    this.LAN3 = l3;
    this.LAN4 = l4;   
	this.LAN5 = l5;
}

function stLayer3Info8(l1, l2, l3, l4, l5, l6, l7, l8) {
    this.LAN1 = l1;
    this.LAN2 = l2;
    this.LAN3 = l3;
    this.LAN4 = l4;
    this.LAN5 = l5;
    this.LAN6 = l6;
    this.LAN7 = l7;
    this.LAN8 = l8;
}

function stLayer3Enable(domain, lay3enable)
{
	this.domain = domain;
	this.lay3enable = lay3enable;
}

function stLanDhcpEnable(domain, lanDhcpenable)
{
	this.domain = domain;
	this.lanDhcpenable = lanDhcpenable;
}

function TopoInfo(Domain, EthNum, SSIDNum)
{   
    this.Domain = Domain;
    this.EthNum = EthNum;
    this.SSIDNum = SSIDNum;
}

function ConvertLanBindPort(_BindPhyPortInfo, _Port)
{
	var portEnable = "0";
	var portBindList = _BindPhyPortInfo.split(",");
	
	for(var i = 0; i < portBindList.length; i++)
	{
		if(portBindList[i].toUpperCase() == _Port)
		{
			portEnable = "1";
			break;
		}
	}
	
	return portEnable;
}

function stBindPhyPortInfo(_Domain, _BindPhyPortInfo)
{
	this.domain = _Domain;
	this.BindPhyPortInfo = _BindPhyPortInfo;
	this.lan1enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN1");
	this.lan2enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN2");
	this.lan3enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN3");
	this.lan4enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN4");
	this.lan5enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN5");
    if (TopoInfo.EthNum > 5) {
        this.lan6enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN6");
        this.lan7enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN7");
        this.lan8enable = ConvertLanBindPort(_BindPhyPortInfo, "LAN8");
    }
	this.s1enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID1");
	this.s2enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID2");
	this.s3enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID3");
	this.s4enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID4");
}

var waniplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}, X_HW_BindPhyPortInfo, stBindPhyPortInfo);%>;
var wanppplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}, X_HW_BindPhyPortInfo, stBindPhyPortInfo);%>;

var Lay3Enables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 
var LanDhcpEnables = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaLanDhcpEnable,InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_DHCPv4Enable, stLanDhcpEnable);%>; 
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfo);%>;
var TopoInfo = TopoInfoList[0];
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
var upMode = '<%HW_WEB_GetUpMode();%>';
var lanPortNum = '<%GetLanPortNum();%>';

if (curCfgModeWord.toUpperCase() == "SDCCENTER") {
    TopoInfo.EthNum = lanPortNum;
}

var stbport = '<%HW_WEB_GetSTBPort();%>';

var bindOption;
if (TopoInfo.EthNum > 5) {
    bindOption = new stLayer3Info8();
} else {
    bindOption = new stLayer3Info();
}

for (var i = 1; i <= TopoInfo.EthNum; i++)
{
    if (Lay3Enables[i-1] != null)
    {
        bindOption["LAN"+i] = Lay3Enables[i-1].lay3enable;
    }
    else
    {
        bindOption["LAN"+i] = "0";
    }
}

var LanDhcpOption = new stLayer3Info();
for (var i = 1; i <= TopoInfo.EthNum; i++)
{
    if (LanDhcpEnables[i-1] != null)
    {
        LanDhcpOption["LAN"+i] = LanDhcpEnables[i-1].lanDhcpenable;
    }
    else
    {
        LanDhcpOption["LAN"+i] = "0";
    }
}

var isEnableSSID = false;

var usedBindData= new stLayer3Info();

function DisplayPort()
{
	if (UpportDetectFlag ==1)
	{
		
		for (var i =1;i<= TopoInfo.EthNum;i++)
		{
			if (UpUserPortID == i)
			{
				setDisplay("Div_LAN"+i, 0);
			}
			else
			{
				setDisplay("Div_LAN"+i, 1);
			}
		}	
	}
}

function DisplayLanType()
{
	if (UpportDetectFlag ==1)
	{
	
		for (var i =1;i<= TopoInfo.EthNum;i++)
		{
			if (UpUserPortID == i)
			{
				continue;
			}
			else
			{
				document.getElementById('lantype'+i).innerHTML = "LAN" + i;
			}
		}	
	}
}

function InitIPTVPortInfo()
{
	if (supportIPTVPort != 1)
	{
		return;
	}

	var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
	if (IPTVUpPortInfo == "")
	{
		return;
	}
	
	var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
	var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
	var tempIPTVUpList = tempIPTVUpValue.split(".");
	var tempLanID = "Div_" + tempIPTVUpList[0];
	setDisplay(tempLanID, 0);
	return;
}

function SetLANDisble()
{
	if ( "1" == supportTelmex)
	{
		return;
	}

	for(i=0;waniplanbind.length > 0 && i < waniplanbind.length -1;i++)
	{
		if ("1" == waniplanbind[i].lan1enable)
		{
			setDisable('cb_Lan1', 1);
		}

		if ("1" == waniplanbind[i].lan2enable)
		{
			setDisable('cb_Lan2', 1);
		}

		if ("1" == waniplanbind[i].lan3enable)
		{
			setDisable('cb_Lan3', 1);
		}

		if ("1" == waniplanbind[i].lan4enable)
		{
			setDisable('cb_Lan4', 1);
		}
		
		if ("1" == waniplanbind[i].lan5enable)
        {
            setDisable('cb_Lan5', 1);
        }	

        if (TopoInfo.EthNum > 5) {
            if (waniplanbind[i].lan6enable == "1") {
                setDisable('cb_Lan6', 1);
            }
            if (waniplanbind[i].lan7enable == "1") {
                setDisable('cb_Lan7', 1);
            }
            if (waniplanbind[i].lan8enable == "1") {
                setDisable('cb_Lan8', 1);
            }
        }
    }

	for(i=0;wanppplanbind.length > 0 && i < wanppplanbind.length -1;i++)
	{
		if ("1" == wanppplanbind[i].lan1enable)
		{
			setDisable('cb_Lan1', 1);
		}

		if ("1" == wanppplanbind[i].lan2enable)
		{
			setDisable('cb_Lan2', 1);
		}

		if ("1" == wanppplanbind[i].lan3enable)
		{
			setDisable('cb_Lan3', 1);
		}

		if ("1" == wanppplanbind[i].lan4enable)
		{
			setDisable('cb_Lan4', 1);
		}		
		
		if ("1" == wanppplanbind[i].lan5enable)
		{
			setDisable('cb_Lan5', 1);
		}
        if (TopoInfo.EthNum > 5) {
            if (wanppplanbind[i].lan6enable == "1") {
                setDisable('cb_Lan6', 1);
            }
            if (wanppplanbind[i].lan7enable == "1") {
                setDisable('cb_Lan7', 1);
            }
            if (wanppplanbind[i].lan8enable == "1") {
                setDisable('cb_Lan8', 1);
            }
        }
	}		

    /* 获取旁挂防火墙节点信息 */
    var t3dFWEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.BypassFirewall.T3dFirewallDevEnable);%>';
    var t3dFWLan = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.BypassFirewall.T3dFirewallDevLan);%>';
    var t3dFWWan = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.BypassFirewall.T3dFirewallDevWan);%>';
    if (t3dFWEnable == 1) {
        setDisable('cb_Lan'+t3dFWLan, 1);
        setDisable('cb_Lan'+t3dFWWan, 1);
    }

	return;
}

function LoadFrame()
{
    setCheck('cb_Lan1', bindOption.LAN1);
    setCheck('cb_Lan2', bindOption.LAN2);
    setCheck('cb_Lan3', bindOption.LAN3);
    setCheck('cb_Lan4', bindOption.LAN4);
	setCheck('cb_Lan5', bindOption.LAN5);
    if (TopoInfo.EthNum > 5) {
        setCheck('cb_Lan6', bindOption.LAN6);
        setCheck('cb_Lan7', bindOption.LAN7);
        setCheck('cb_Lan8', bindOption.LAN8);
    }
    setCheck('cb_DhcpLan1', LanDhcpOption.LAN1);
    setCheck('cb_DhcpLan2', LanDhcpOption.LAN2);
    setCheck('cb_DhcpLan3', LanDhcpOption.LAN3);
    setCheck('cb_DhcpLan4', LanDhcpOption.LAN4);
    if (TopoInfo.EthNum > 5) {
        setCheck('cb_DhcpLan5', LanDhcpOption.LAN5);
        setCheck('cb_DhcpLan6', LanDhcpOption.LAN6);
        setCheck('cb_DhcpLan7', LanDhcpOption.LAN7);
        setCheck('cb_DhcpLan8', LanDhcpOption.LAN8);
    }
    setDisable('cb_Lan1', 0);
    setDisable('cb_Lan2', 0);
    setDisable('cb_Lan3', 0);
    setDisable('cb_Lan4', 0);
	setDisable('cb_Lan5', 0);
    if (TopoInfo.EthNum > 5) {
        setDisable('cb_Lan6', 0);
        setDisable('cb_Lan7', 0);
        setDisable('cb_Lan8', 0);
    }

	for (var i = 1; i <= TopoInfo.EthNum; i++)
	{
		if( i == stbport )
		{
			document.getElementById('lantype'+i).innerHTML = layer3_language['bbsp_stb'];
		}
		else
		{
			document.getElementById('lantype'+i).innerHTML = "LAN" + i;
		}
	}

	var typevalue = (iponlyflg > 0) ? "EXT1" : "LAN5";
	document.getElementById('lantype5').innerHTML = htmlencode(typevalue);
	
	SetLANDisble();

	loadlanguage();
	DisplayLanType();
	
	if (PonUpportConfig == 1 && '3' == upMode)
	{
	    for(var i = 1; i <= TopoInfo.EthNum; i++)
		{
			if(UpUserPortID == i)
			{
				setDisable('cb_Lan'+i, 1);
			}
		}
	}
	
    InitIPTVPortInfo();
    if (notSupportPON == "1") {
        if (TopoInfo.EthNum > 3) {
            $("#Div_LAN4").hide();
        }
    }
}

function parseUsedBindOptionData()
{
    for ( i=0; usedBindOptionOfIPCon.length > 0 && i < usedBindOptionOfIPCon.length-1; i++)
    {
        if ( usedBindOptionOfIPCon[i].LAN1 == 1)
        {
            usedBindData.LAN1 = 1;
        }
        if ( usedBindOptionOfIPCon[i].LAN2 == 1)
        {
            usedBindData.LAN2 = 1;
        }
        if ( usedBindOptionOfIPCon[i].LAN3 == 1)
        {
            usedBindData.LAN3 = 1;
        }
        if ( usedBindOptionOfIPCon[i].LAN4 == 1)
        {
            usedBindData.LAN4 = 1;
        }
		if ( usedBindOptionOfIPCon[i].LAN5 == 1)
        {
            usedBindData.LAN5 = 1;
        }
        if (TopoInfo.EthNum > 5) {
            if (usedBindOptionOfIPCon[i].LAN6 == 1) {
                usedBindData.LAN6 = 1;
            }
            if (usedBindOptionOfIPCon[i].LAN7 == 1) {
                usedBindData.LAN7 = 1;
            }
            if (usedBindOptionOfIPCon[i].LAN8 == 1) {
                usedBindData.LAN8 = 1;
            }
        }
    }

    for ( j=0; usedBindOptionOfPPPCon.length > 1 && j < usedBindOptionOfPPPCon.length-1; j++)
    {
        if ( usedBindOptionOfPPPCon[j].LAN1 == 1)
        {
            usedBindData.LAN1 = 1;
        }
        if ( usedBindOptionOfPPPCon[j].LAN2 == 1)
        {
            usedBindData.LAN2 = 1;
        }
        if ( usedBindOptionOfPPPCon[j].LAN3 == 1)
        {
            usedBindData.LAN3 = 1;
        }
        if ( usedBindOptionOfPPPCon[j].LAN4 == 1)
        {
            usedBindData.LAN4 = 1;
        }
		if ( usedBindOptionOfPPPCon[j].LAN5 == 1)
        {
            usedBindData.LAN5 = 1;
        }
        if (TopoInfo.EthNum > 5) {
            if (usedBindOptionOfPPPCon[j].LAN6 == 1) {
                usedBindData.LAN6 = 1;
            }
            if (usedBindOptionOfPPPCon[j].LAN7 == 1) {
                usedBindData.LAN7 = 1;
            }
            if (usedBindOptionOfPPPCon[j].LAN8 == 1) {
                usedBindData.LAN8 = 1;
            }
        }
    }


     if ( isEnableSSID)
     {
        for ( i=0; usedBindOptionOfIPCon.length > 0 && i < usedBindOptionOfIPCon.length-1; i++)
        {
            if ( usedBindOptionOfIPCon[i].SSID1 == 1)
            {
                usedBindData.SSID1 = 1;
            }
            if ( usedBindOptionOfIPCon[i].SSID2 == 1)
            {
                usedBindData.SSID2 = 1;
            }
            if ( usedBindOptionOfIPCon[i].SSID3 == 1)
            {
                usedBindData.SSID4 = 1;
            }
            if ( usedBindOptionOfIPCon[i].SSID4 == 1)
            {
                usedBindData.SSID5 = 1;
            }
        }

        for ( j=0; usedBindOptionOfPPPCon.length > 1 && j < usedBindOptionOfPPPCon.length-1; j++)
        {
            if ( usedBindOptionOfPPPCon[j].SSID1 == 1)
            {
                usedBindData.SSID1 = 1;
            }
            if ( usedBindOptionOfPPPCon[j].SSID2 == 1)
            {
                usedBindData.SSID2 = 1;
            }
            if ( usedBindOptionOfPPPCon[j].SSID3 == 1)
            {
                usedBindData.SSID3 = 1;
            }
            if ( usedBindOptionOfPPPCon[j].SSID4 == 1)
            {
                usedBindData.SSID4 = 1;
            }
        }
    }
}

function CheckForm()
{
    setDisable('button', 1);
    setDisable('cancelValue', 1);
	return true;
}

function ResetOnt()
{
	setDisplay('showlayer3', 0);
	setDisplay('showsuccess', 1);	
	
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : 'set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard' + '&RequestFile=html/bbsp/layer3/layer3.asp',
		data: 'x.X_HW_Token=' + getValue('onttoken'),
		success : function(data) {	
			;
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.TELMEXgetpppstatusflag = 1;
			setDisable('button', 0);
			setDisable('cancelValue', 0);	
			setDisplay('showsuccess', 0);	
			setDisplay('showlayer3', 1);
		}
	});
}

function ChangeLanStateAndReset(domain, TelmexData)
{
	setDisable('button', 1);
	setDisable('cancelValue', 1);	
	top.TELMEXgetpppstatusflag = 0;
	
	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		url : 'set.cgi?' + domain + '&RequestFile=html/bbsp/layer3/layer3.asp',
		data : TelmexData,
		success : function(data) {
			setTimeout("ResetOnt()", 500);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.TELMEXgetpppstatusflag = 1;
			setDisable('button', 0);
			setDisable('cancelValue', 0);
		}
	});
}

function ChangeLanState()
{
    var Form = new webSubmitForm();
    var domain = "";
	var TelmexData = "";
	if (UpportDetectFlag ==1)
	{
	
		for (var i =1;i<= TopoInfo.EthNum;i++)
		{
			if (UpUserPortID == i)
			{
				continue;
			}
			else
			{
				domain +=  '&LAN'+i+'='+ Lay3Enables[i-1].domain;
				Form.addParameter('LAN'+i+'.X_HW_L3Enable',getCheckVal('cb_Lan'+i+''));
				TelmexData += 'LAN'+i+'.X_HW_L3Enable='+getCheckVal('cb_Lan'+i+'');
			}
		}	
	}
	else
	{
		for (var i = 1; i <= TopoInfo.EthNum && Lay3Enables[i-1] != null; i++)
		{
			domain +=  '&LAN'+i+'='+ Lay3Enables[i-1].domain;
			Form.addParameter('LAN'+i+'.X_HW_L3Enable',getCheckVal('cb_Lan'+i+''));
			TelmexData += 'LAN'+i+'.X_HW_L3Enable='+getCheckVal('cb_Lan'+i+'')+'&';
		}	
	}	

	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    domain = domain.substr(1,domain.length-1);
	TelmexData += 'x.X_HW_Token='+getValue('onttoken')

	if( "1" == supportTelmex)
	{
		ChangeLanStateAndReset(domain, TelmexData);
	}
	else
	{
		Form.setAction('set.cgi?' + domain
							 + '&RequestFile=html/bbsp/layer3/layer3.asp');
		setDisable('button', 1);
		setDisable('cancelValue', 1);
		Form.submit();	
	}
}

function ChangeDhcpBasedLanState()
{
    var Form = new webSubmitForm();
    var domain = "";
  
    for (var i = 1; i <= TopoInfo.EthNum; i++)
    {  
        domain +=  '&LAN'+i+'='+ LanDhcpEnables[i-1].domain
        Form.addParameter('LAN'+i+'.X_HW_DHCPv4Enable',getCheckVal('cb_DhcpLan'+i+''));
    }
    
    domain = domain.substr(1,domain.length-1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?' + domain
						 + '&RequestFile=html/bbsp/layer3/layer3.asp');
    setDisable('button', 1);
    setDisable('cancelValue', 1);
    Form.submit();
}

function CancelConfig()
{
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div id="showlayer3">
<script language="JavaScript" type="text/javascript">
	if( "1" == supportTelmex)
	{
		HWCreatePageHeadInfo("layer3", GetDescFormArrayById(layer3_language, "bbsp_mune"), GetDescFormArrayById(layer3_language, "bbsp_layer3_telmex_title"), false);
	}
	else
	{
		HWCreatePageHeadInfo("layer3", GetDescFormArrayById(layer3_language, "bbsp_mune"), GetDescFormArrayById(layer3_language, "bbsp_layer3_title"), false);
	}

</script> 
<div class="title_spread"></div>
<table> 
  <form action="" id="ConfigForm"> 
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1"> 
      <tr id="secUsername" class='align_left'> 
        <td class="LanBg"  id="Div_LAN1"> <div> 
            <input id="cb_Lan1" name="cb_Lan1" type="checkbox" value="LAN1"> 
            <span id="lantype1"></span></div></td> 
        <td class="LanBg"  id="Div_LAN2" nowrap> <div> 
            <input id="cb_Lan2" name="cb_Lan2" type="checkbox" value="LAN2"> 
            <span id="lantype2"></span></div></td> 
        <td class="LanBg"  id="Div_LAN3"> <div> 
            <input type="checkbox" id="cb_Lan3" name="cb_Lan3" value="LAN3"> 
            <span id="lantype3"></span></div></td> 
        <td class="LanBg"  id="Div_LAN4"> <div> 
            <input type="checkbox" id="cb_Lan4" name="cb_Lan4" value="LAN4"> 
            <span id="lantype4"></span></div></td>
		<td class="LanBg"  id="Div_LAN5"> <div> 
            <input type="checkbox" id="cb_Lan5" name="cb_Lan5" value="LAN5"> 
			<span id="lantype5"></span></div></td> 
        <td class="LanBg"  id="Div_LAN6"> <div>
            <input type="checkbox" id="cb_Lan6" name="cb_Lan6" value="LAN6">
            <span id="lantype6"></span></div></td>
        <td class="LanBg"  id="Div_LAN7"> <div>
            <input type="checkbox" id="cb_Lan7" name="cb_Lan7" value="LAN7">
            <span id="lantype7"></span></div></td>
        <td class="LanBg"  id="Div_LAN8"> <div>
            <input type="checkbox" id="cb_Lan8" name="cb_Lan8" value="LAN8">
            <span id="lantype8"></span></div></td>
      </tr> 
      <tr id='secSSID' class='displaynone align_left'> 
        <td width="100%" align="left"> <div id="Div_SSID1"> 
            <input type="checkbox" id="cb_SSID1" name="cb_SSID1" value="SSID1"> 
            SSID1&nbsp;</div> 
          <div id="Div_SSID2"> 
            <input type="checkbox" id="cb_SSID2" name="cb_SSID2" value="SSID2"> 
            SSID2&nbsp;</div> 
          <div id="Div_SSID3"> 
            <input type="checkbox" id="cb_SSID3" name="cb_SSID3" value="SSID3"> 
            SSID3&nbsp;</div> 
          <div id="Div_SSID4"> 
            <input type="checkbox" id="cb_SSID4" name="cb_SSID4" value="SSID4"> 
            SSID4&nbsp;</div></td> 
      </tr> 
      <script>
        var EthNum = TopoInfo.EthNum;
        var SSIDNum = TopoInfo.SSIDNum;
        var i;
        for (i = 1; i <= 8; i++)
        {
            if (i > EthNum)
            {
                setDisplay("Div_LAN"+i, 0);                
            }
            if (i > SSIDNum)
            {
                setDisplay("Div_SSID"+i, 0);
            }
        }
		DisplayPort();
  </script> 
    </table> 
    <table width="100%" border="0"  cellpadding="0" cellspacing="0"> 
      <tr > 
        <td class='title_bright1'> <button id='Apply' name="button" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="ChangeLanState();" >
		<script>		  	
			if ( "1" == supportTelmex)
			{
				document.write(layer3_language['bbsp_appandreset']);	
			}
			else
			{
				document.write(layer3_language['bbsp_app']);
			}
		</script>
		</button> 
          <button id='Cancel' name="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(layer3_language['bbsp_cancel']);</script></button> </td> 
      </tr> 
    </table> 
  </form> 
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tabTestDhcpLan" style="display:none"> 
  <tr> 
    <td class="prompt"> <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class='title_common' BindText='bbsp_dhcpbasedlan_title' ></td> 
        </tr> 
      </table> 
  </tr> 
  <tr> 
    <td class='height5p'></td> 
  </tr> 
  <script>
		if (landhcpenable == 1)
		{
  	    setDisplay("tabTestDhcpLan", 1);
  	}
  </script>
</table> 

<form action="" id="ConfigFormDhcpLan" style="display:none"> 
<table id="tabTestDhcpLanCheck">   
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" > 
      <tr id="secUsername" class='align_left'> 
        <td class="LanBg"> <div id="Div_DHCPLAN1"> 
            <input id="cb_DhcpLan1" name="cb_DhcpLan1" type="checkbox" value="LAN1"> 
            LAN1</div></td> 
        <td class="LanBg"> <div id="Div_DHCPLAN2"> 
            <input id="cb_DhcpLan2" name="cb_DhcpLan2" type="checkbox" value="LAN2"> 
            LAN2</div></td> 
        <td class="LanBg"> <div id="Div_DHCPLAN3"> 
            <input type="checkbox" id="cb_DhcpLan3" name="cb_DhcpLan3" value="LAN3"> 
            LAN3</div></td> 
        <td class="LanBg"> <div id="Div_DHCPLAN4"> 
            <input type="checkbox" id="cb_DhcpLan4" name="cb_DhcpLan4" value="LAN4"> 
            LAN4</div></td>
		<td class="LanBg"> <div id="Div_DHCPLAN5"> 
            <input type="checkbox" id="cb_DhcpLan5" name="cb_DhcpLan5" value="LAN5"> 
            LAN5</div></td>  
      </tr> 
      <script>
      var EthNum = TopoInfo.EthNum;
      var i;
      for (i = 1; i <= 5; i++)
      {
          if (i > EthNum)
          {
            setDisplay("Div_DHCPLAN"+i, 0);
          }
      }
      </script>
    </table> 
    <table width="100%" border="0"  cellpadding="0" cellspacing="0"> 
      <tr > 
        <td class='title_bright1'>
		  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
		  <button id='Apply' name="button" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="ChangeDhcpBasedLanState();" ><script>document.write(layer3_language['bbsp_app']);</script></button> 
          <button id='Cancel' name="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(layer3_language['bbsp_cancel']);</script></button> </td> 
      </tr> 
    </table> 
</table> 
<script>
if (landhcpenable == 1)
{
    setDisplay("ConfigFormDhcpLan", 1);
}
</script>
</form> 
</div>
<div id="showsuccess" style="display:none;">
  <table width="100%" height="10%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td class="PageTitle_content"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="13%" align="center"><img src="../../../images/ok.gif" width="48" height="48" /></td>
			<td width="87%" id="RestoreInfo">
			<script language="JavaScript" type="text/javascript">
				document.write(layer3_language['bbsp_reset_wait']);
			</script>
			</td>
		  </tr>
		</table></td>
	</tr>
  </table>
</div>
</body>
</html>
