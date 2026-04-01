<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>modeswitch</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="JavaScript" type="text/javascript">

var landhcpenable ='<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCPS_UNI_CTL);%>';
var UpportDetecflg ='<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var IGMPEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_IPTV.IGMPEnable);%>';
var BridgeMode = 1;
var MixMode = 2;
var RouteMode = 3;

var ChooseMode = 1;

var WanList = GetWanList();

function getmode()
{
    if (ChooseMode == BridgeMode)
    {
        return 1;
    }
    else if (ChooseMode == MixMode)
    {
        return 2;
    }

    return 0;
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
		b.innerHTML = modeswitch_customize_language[b.getAttribute("BindText")];
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
	this.s1enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID1");
	this.s2enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID2");
	this.s3enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID3");
	this.s4enable = ConvertLanBindPort(_BindPhyPortInfo, "SSID4");
}

var waniplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}, X_HW_BindPhyPortInfo, stBindPhyPortInfo);%>;
var wanppplanbind = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}, X_HW_BindPhyPortInfo, stBindPhyPortInfo);%>;

var Lay3Enables = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfo);%>;
var TopoInfo = TopoInfoList[0];
TopoInfo.EthNum = '<%GetLanPortNum();%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var bindOption = new stLayer3Info();
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

var isEnableSSID = false;

var usedBindData= new stLayer3Info();

function setAllPortDisable(Disable)
{
	setDisable('cb_Lan1', Disable);
    setDisable('cb_Lan2', Disable);
    setDisable('cb_Lan3', Disable);
    setDisable('cb_Lan4', Disable);
	setDisable('cb_Lan5', Disable);
}

function LoadFrame()
{
    setCheck('cb_Lan1', bindOption.LAN1);
    setCheck('cb_Lan2', bindOption.LAN2);
    setCheck('cb_Lan3', bindOption.LAN3);
    setCheck('cb_Lan4', bindOption.LAN4);
	setCheck('cb_Lan5', bindOption.LAN5);
	
	setAllPortDisable(0);

	for (var i = 1; i <= TopoInfo.EthNum; i++)
	{
		if( i == stbport )
		{
			document.getElementById('lantype'+i).innerHTML = modeswitch_customize_language['bbsp_stb'];
		}
		else
		{
			document.getElementById('lantype'+i).innerHTML = "LAN" + i;
		}
	}
	
    for (i=0;waniplanbind.length > 0 && i < waniplanbind.length -1;i++)
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
    }

    for (i=0;wanppplanbind.length > 0 && i < wanppplanbind.length -1;i++)
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
    }
	
	if (IGMPEnable == '0')
	{
		ChooseMode = BridgeMode;
	}
	else 
	{
		var EthNum = TopoInfo.EthNum;
        for (i = 1; i <= TopoInfo.EthNum; i++)
        {
			if ("0" == bindOption["LAN"+i] )
			{
				ChooseMode = MixMode;
				break;
			}
			ChooseMode = RouteMode;
        }
	}
	
	if(RouteMode == ChooseMode || BridgeMode == ChooseMode )
	{
		setAllPortDisable(1);
	}

	setRadio('ModeSelect',ChooseMode);
	
	loadlanguage();
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

function ChooseBridgeMode()
{
	ChooseMode = BridgeMode;
	setCheck('cb_Lan1', 0);
    setCheck('cb_Lan2', 0);
    setCheck('cb_Lan3', 0);
    setCheck('cb_Lan4', 0);
	setCheck('cb_Lan5', 0);
    
	setAllPortDisable(1);
	
}

function ChooseMixedMode()
{
	ChooseMode = MixMode;
   
	setAllPortDisable(0);
}

function ChooseRouteMode()
{
	ChooseMode = RouteMode;
	setCheck('cb_Lan1', 1);
    setCheck('cb_Lan2', 1);
    setCheck('cb_Lan3', 1);
    setCheck('cb_Lan4', 1);
	setCheck('cb_Lan5', 1);
   
	setAllPortDisable(1);
}

function ChangeLanReset()
{
    var Form = new webSubmitForm();

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
				 + '&RequestFile=html/ssmp/reset/reset.asp');
    Form.submit();
}

function ChangeLanState()
{
    var domain = "";
	var WANdomain = "";
	var Data = "";
	
	if(false == ConfirmEx(modeswitch_customize_language['bbsp_restart'])) 
	{
		return;
	}
 
    for (var i = 1; i <= TopoInfo.EthNum && Lay3Enables[i-1] != null; i++)
    {
		if( 1 == i)
		{
			Data += 'LAN'+i+'.X_HW_L3Enable='+getCheckVal('cb_Lan'+i+'');
			domain +=  'LAN'+i+'='+ Lay3Enables[i-1].domain;			
		}
		else
		{
			Data += '&LAN'+i+'.X_HW_L3Enable='+getCheckVal('cb_Lan'+i+'');
			domain +=  '&LAN'+i+'='+ Lay3Enables[i-1].domain;
		}

    }
		
	if ((RouteMode == ChooseMode) || (MixMode == ChooseMode) )
	{	
		for (var i = 0; i < WanList.length ; i++ )
		{
			var prefix = "WAN" + i; 
			Data += "&"+prefix+'.Enable=1';
			WANdomain += '&' + prefix + '=' + WanList[i].domain;
		}

		Data += "&Y.IGMPEnable=1";
	}
	else if ( BridgeMode == ChooseMode)
	{
		for (var i = 0; i < WanList.length ; i++ )
		{
			if (WanList[i].ServiceList.toUpperCase().indexOf("VOIP") >= 0)
			{
				continue;
			}
            if (WanList[i].ServiceList.toUpperCase().indexOf("TR069") >= 0)
			{
				continue;
			}
			var prefix = "WAN" + i; 
			Data += "&"+prefix+'.Enable=0';
			WANdomain += '&' + prefix + '=' + WanList[i].domain;
		}

		Data += "&Y.IGMPEnable=0";
	}	
	Data += "&x.X_HW_Token="+getValue('onttoken');
			
    setDisable('button', 1);
    setDisable('cancelValue', 1);

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : 'modeswitch='+getmode()+'&x.X_HW_Token='+getValue('onttoken'),
		url : 'setmodeswitch.cgi?&RequestFile=html/ipv6/not_find_file.asp',
	});

    $.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : Data,
		url : 'set.cgi?' + domain+ WANdomain + '&Y=InternetGatewayDevice.Services.X_HW_IPTV' + '&RequestFile=html/bbsp/modechange/modechange.asp',
		success : function(data) {
		}
	}); 

    ChangeLanReset();
}


function CancelConfig()
{
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("layer3", GetDescFormArrayById(modeswitch_customize_language, "bbsp_mune"), GetDescFormArrayById(modeswitch_customize_language, "bbsp_layer3_title"), false);
</script> 
<div class="title_spread"></div>
	<tr>	
		<td >
		<input name="ModeSelect" id="BridgeMode" type="radio" value="1"  onclick="ChooseBridgeMode();" />
		<span ><script>document.write(modeswitch_customize_language['bbsp_brigemode']);</script>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
		<input name="ModeSelect" id="MixedMode" type="radio" value="2"  onclick="ChooseMixedMode();"/>
		<span ><script>document.write(modeswitch_customize_language['bbsp_hybridmode']);</script>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
		<input name="ModeSelect" id="RouteMode" type="radio" value="3"  onclick="ChooseRouteMode();"/>
		<span ><script>document.write(modeswitch_customize_language['bbsp_routemode']);</script></span>
		</td>	
	</tr>
	
<table> 
  <form action="" id="ConfigForm"> 
	<div class="title_spread"></div>
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
        for (i = 1; i <= 5; i++)
        {
            if (i > EthNum)
            {
                setDisplay("Div_LAN"+i, 0);
                if(UpportDetecflg ==1 && UpUserPortID == i)
                {
                    setDisplay("Div_LAN"+i, 0);
                }                
            }
            if (i > SSIDNum)
            {
                setDisplay("Div_SSID"+i, 0);
            }
        }

  </script> 
    </table> 
    <table width="100%" border="0"  cellpadding="0" cellspacing="0"> 
      <tr > 
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
        <td class='title_bright1'> <button id='Apply' name="button" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="ChangeLanState();" ><script>document.write(modeswitch_customize_language['bbsp_app']);</script></button> 
          <button id='Cancel' name="cancelValue" class="CancleButtonCss buttonwidth_100px" type="button" onClick="CancelConfig();"><script>document.write(modeswitch_customize_language['bbsp_cancel']);</script></button> </td> 
      </tr> 
    </table> 
  </form> 
</table>

</body>
</html>
