<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipinterface);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>VOIP Interface</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>

<script language="JavaScript" type="text/javascript"> 

var selctIndex = -1;
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
var vagIndex = 0;

var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';
var isOltVisualUser = "<% HW_WEB_IfVisualOltUser();%>";

function isValidVoipPort(port) 
{ 
   if (!isInteger(port) || port < 1025 ||port > 65535 || port == "")
   {
       return false;
   }
   
   return true;
}

function GetVagIndexByInst(vagInst)
{
    for(var i = 0; i < AllProfile.length-1; i++)
    {
        if(AllProfile[i].profileid == vagInst)
        {
            return i;
        }
    }
    
    return 0;
}

function stServerType(Domain, X_HW_ServerType)
{
    this.Domain = Domain;
    this.X_HW_ServerType = X_HW_ServerType;
}
var AllServerType = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}, X_HW_ServerType, stServerType);%>;

function stDeviceInfoVoiceMode(Domain, X_HW_VOICE_MODE)
{
    this.Domain = Domain;
    this.X_HW_VOICE_MODE = X_HW_VOICE_MODE;
}

var DeviceVoiceMode = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo, X_HW_VOICE_MODE, stDeviceInfoVoiceMode);%>;


function stMediaPortName(Domain, X_HW_PortName_RTP)
{
    this.Domain = Domain;
    this.X_HW_PortName_RTP = X_HW_PortName_RTP;
}
var MediaPortName = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.RTP,X_HW_PortName,stMediaPortName);%>;

function stProfile(Domain, Region, X_HW_DigitMapMatchMode, X_HW_PortName, DigitMap)
{
    this.Domain = Domain;
    this.Region = Region;
    this.X_HW_DigitMapMatchMode = X_HW_DigitMapMatchMode;
    this.X_HW_PortName = X_HW_PortName;
    var temp = Domain.split('.');
    this.key = '.' + temp[5] + '.';
    this.profileid = temp[5];
    this.Relating = new stSIPServer("","","5060","","5060","","5060");
    
    this.DigitMap = DigitMap; 
}

function stDigitMap(Domain, DigitMap)
{
    this.Domain = Domain;
    this.DigitMap = DigitMap;
}
var SipDigitMap = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPDigitmap.1,DigitMap,stDigitMap);%>;

var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},Region|X_HW_DigitMapMatchMode|X_HW_PortName,stProfile);%>;
vagIndex = GetVagIndexByInst(vagLastInst);

for (var i = 0; i < AllProfile.length-1; i++)
{
    AllProfile[i].DigitMap = SipDigitMap[i].DigitMap;
}

function stSIPServer(Domain, ProxyServer, ProxyServerPort,OutboundProxy,OutboundProxyPort,X_HW_SecondaryOutboundProxy,X_HW_SecondaryOutboundProxyPort, X_HW_SecondaryProxyServer, X_HW_SecondaryProxyServerPort, RegistrarServer, RegistrarServerPort,X_HW_SecondaryRegistrarServer,X_HW_SecondaryRegistrarServerPort, UserAgentPort,RegistrationPeriod)
{
    this.Domain = Domain;                           
    this.OutboundProxy = OutboundProxy;
    this.OutboundProxyPort = OutboundProxyPort;
    this.X_HW_SecondaryOutboundProxy = X_HW_SecondaryOutboundProxy;
    this.X_HW_SecondaryOutboundProxyPort = X_HW_SecondaryOutboundProxyPort;
    
    this.ProxyServer = ProxyServer;
    this.ProxyServerPort = ProxyServerPort;
    this.RegistrationPeriod = RegistrationPeriod;
    this.X_HW_SecondaryProxyServer = X_HW_SecondaryProxyServer;
    this.UserAgentPort = UserAgentPort;
    this.RegistrarServer = RegistrarServer;
	this.RegistrarServerPort = RegistrarServerPort;
	this.X_HW_SecondaryRegistrarServer = X_HW_SecondaryRegistrarServer;
	this.X_HW_SecondaryRegistrarServerPort = X_HW_SecondaryRegistrarServerPort;
    this.ProxyServerPort = ProxyServerPort;
    this.X_HW_SecondaryProxyServerPort = X_HW_SecondaryProxyServerPort;
    this.OutboundProxyPort = OutboundProxyPort;
    this.X_HW_SecondaryOutboundProxyPort = X_HW_SecondaryOutboundProxyPort; 
    var temp = Domain.split('.');
    this.key = '.' + temp[5] + '.';
}

var AllSIPServer = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP,ProxyServer|ProxyServerPort|OutboundProxy|OutboundProxyPort|X_HW_SecondaryOutboundProxy|X_HW_SecondaryOutboundProxyPort|X_HW_SecondaryProxyServer|X_HW_SecondaryProxyServerPort|RegistrarServer|RegistrarServerPort|X_HW_SecondaryRegistrarServer|X_HW_SecondaryRegistrarServerPort|UserAgentPort|RegistrationPeriod,stSIPServer);%>;
AssociateParam(AllProfile, AllSIPServer, 'ProxyServer|ProxyServerPort|OutboundProxy|OutboundProxyPort|X_HW_SecondaryOutboundProxy|X_HW_SecondaryOutboundProxyPort|X_HW_SecondaryProxyServer|X_HW_SecondaryProxyServerPort|RegistrarServer|RegistrarServerPort|X_HW_SecondaryRegistrarServer|X_HW_SecondaryRegistrarServerPort|UserAgentPort|RegistrationPeriod');

function stH248(Domain,DSCPMark, HeartBeatPattern, RegisterMode)
{
    this.Domain = Domain;
    this.DSCPMark = DSCPMark;
    this.HeartBeatPattern = HeartBeatPattern;
    this.RegisterMode = RegisterMode;
}
var H248s = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248,DSCPMark|HeartBeatPattern|RegisterMode,stH248);%>;
var H248 = H248s[0];
 
function stH248Extend(Domain, HeartBeatTimer,HeartBeatRetransTimer, HeartBeatRetransTimes)
{
    this.Domain = Domain; 
    this.HeartBeatTimer = HeartBeatTimer;
    this.HeartBeatRetransTimer = HeartBeatRetransTimer;
    this.HeartBeatRetransTimes = HeartBeatRetransTimes;
}
var H248Extend = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_H248.Extend,HeartBeatTimer|HeartBeatRetransTimer|HeartBeatRetransTimes,stH248Extend);%>;

function stDftRoute(domain,autoenable,wandomain)
{
    this.domain     = domain;
    this.autoenable = autoenable;
    this.wandomain  = wandomain;
}

function stWanInfo(domain,Enable,CntType,Name, ConnectionStatus,NATEnabled,DefaultGateway,ServiceList,ExServiceList,vlanid,MacId,submask)
{
    this.domain = domain;
    this.Enable = Enable;
    this.CntType = CntType; 
    this.Name =  Name;
    this.ConnectionStatus = ConnectionStatus;
    this.NATEnabled = NATEnabled;
    this.DefaultGateway = DefaultGateway;
    this.ServiceList = (ExServiceList.length == 0)?ServiceList:ExServiceList;
    this.vlanid = vlanid;
    this.MacId = MacId;
    this.submask = submask;
}

var WanIPInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i},Enable|ConnectionType|Name|ConnectionStatus|NATEnabled|DefaultGateway|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_VLAN|X_HW_MacId|SubnetMask,stWanInfo);%>;  

var WanPPPInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i},Enable|ConnectionType|Name|ConnectionStatus|NATEnabled|DefaultGateway|X_HW_SERVICELIST|X_HW_ExServiceList|X_HW_VLAN|X_HW_MacId,stWanInfo);%>;  

var dftRoutes = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Layer3Forwarding,X_HW_AutoDefaultGatewayEnable|DefaultConnectionService,stDftRoute);%>;

var dftRoute = dftRoutes[0];

var WanInfo = new Array();

for(i=0, j=0;WanIPInfo.length > 0 && i < WanIPInfo.length -1;i++ )
{
    WanIPInfo[i].ServiceList = WanIPInfo[i].ServiceList.toUpperCase();
    if ( (true == WanIPInfo[i].Enable)
         && (WanIPInfo[i].ServiceList.indexOf("VOIP") >= 0) 
         )
    {
        WanInfo[j] = WanIPInfo[i];
        j++;
    }
}

for(i=0; WanPPPInfo.length > 0 && i < WanPPPInfo.length - 1;i++)
{
    WanPPPInfo[i].ServiceList = WanPPPInfo[i].ServiceList.toUpperCase();
    if ( (true == WanPPPInfo[i].Enable)
        &&(WanPPPInfo[i].ServiceList.indexOf("VOIP") >= 0) 
        )
    {
        WanInfo[j] = WanPPPInfo[i];
        j++;
    }
}

function MakeVoipWanName(wan)
{
    var wanInst = 0;
    var wanServiceList = '';
    var currentWanName = '';       

    DomainElement = wan.domain.split(".");
    wanInst = DomainElement[4];
       
    wanServiceList  = wan.ServiceList;
    
    currentWanName = "wan"+wanInst;
    return currentWanName;    
}

var dmm = sipinterface['vspa_dmmhint'];

function initLineHtml()
{
    initCtlValue();
    var html = '<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="voipUserTable" style="table-layout:fixed;word-break:break-all"> ';
    html += '<tr class="head_title">';
    html += '<td style="width:5%">&nbsp;</td>';
    html += '<td width="10%" BindText="vspa_seq"></td>';
    html += '<td style="width:28%" BindText="vspa_e8ctelno"></td>';
    html += '<td style="width:34%" BindText="vspa_e8cusername"</td>';
    html += '<td style="width:13%" BindText="vspa_password"</td>';
    html += '<td style="width:20%" BindText="vspa_assopot"</td></tr>';
    
    if(LineList[vagIndex].length == 0)
    {
        html += '<TR id="record_no"' +' class="tabal_center01 " onclick="selectLine(this.id);">';
        html += '<TD >--</TD>';
        html += '<TD >--</TD>';
        html += '<TD >--</TD>';
        html += '<TD >--</TD>';
        html += '<TD >--</TD>';
        html += '<TD >--</TD></TR>';
    }
    else
    {
        for (var i = 0; i < LineList[vagIndex].length; i++)
        {
            if( i%2 == 0 )
            {                        
                 html += '<tr id="record_' + i + '" class="tabal_01" ' + 'onclick="SelectLineRecord(this.id);">';
            }
            else
            {
                 html += '<tr id="record_' + i + '" class="tabal_02" ' + 'onclick="SelectLineRecord(this.id);">';                        
            }
                                                    
            html += '<td align="center">' + '<input name="rml" id="rml1" type="checkbox" value="' + htmlencode(LineList[vagIndex][i].Domain) + '";></td>';
                   
            html += '<td align="left">' + (i+1) + '</td>';
            
            if (AuthList[vagIndex][i].URI == "")
            {
                html += '<td align="center">' + '--' + '&nbsp;</td>';
            }
            else
            {
                 html += '<td align="left" style="word-wrap:break-word; overflow:hidden;">' + htmlencode(AuthList[vagIndex][i].URI) + '&nbsp;</td>';
            }
            

            if (AuthList[vagIndex][i].AuthUserName == "")
            {
                html += '<td align="center">' + '--' + '&nbsp;</td>';
            }
            else
            {
                html += '<td align="left" style="word-wrap:break-word;overflow:hidden;">' + htmlencode(AuthList[vagIndex][i].AuthUserName) + '&nbsp;</td>';
            }                       
            html += '<td align="center">' + '&nbsp  *******</td>';                   
            if (LineList[vagIndex][i].PhyReferenceList == "")
            {
                html += '<td align="center">' + '--' + '&nbsp;</td>';
            }
            else
            {
                html += '<td align="left">' + htmlencode(LineList[vagIndex][i].PhyReferenceList) + '&nbsp;</td>';
            }
            html += '</tr>';
        }
    }
    html += '</table>';
    document.getElementById('line_list').innerHTML = html;
}

function init()
{
    var objTR = getElementByName('vag_tr');
    if(objTR!= null)
    {
        for(var i = 0; i < objTR.length; i++)
        {
            objTR[i].value = sipinterface['vspa_profile'] + AllProfile[i].profileid;
            if(i == vagIndex)
            {
                objTR[i].style.background = '#B4B4B4';
                objTR[i].style.color = '#990000';
                objTR[i].style.fontWeight='bold';
            }
            else
            {
                objTR[i].style.background = '#C3C3C3';
                objTR[i].style.color = '#505050';
                objTR[i].style.fontWeight='normal';
            }
        }
    }
    
  if(AllPhyInterface.length > 2)
  {
	initLineHtml();
  }
    
    
    if(AllProfile[0] == null)
    {
        return;
    }
	
	setSelect('ServerType_select', AllServerType[0].X_HW_ServerType);
	
    if ( DeviceVoiceMode != null )
    {
        if(DeviceVoiceMode[0] != null)
        {
            if(DeviceVoiceMode[0].X_HW_VOICE_MODE != 0)
            {
                setDisable('ServerType_select',1);
            }
        }
    }
       
    if(AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServer == "255.255.255.255")
    {
        AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServer = "";
    }    
    
    if(AllProfile[vagIndex].Relating.ProxyServer == "255.255.255.255")
    {
        AllProfile[vagIndex].Relating.ProxyServer = "";
    }

    if (CfgMode.toUpperCase() == 'ZJCT') {
        setSelect("RegisterMode",H248.RegisterMode);
        setSelect("HeartBeatPattern",H248.HeartBeatPattern);
        setText('HeartbeatCycle_text',H248Extend[0].HeartBeatRetransTimer);
    }

    setText('OutboundProxy_text',AllProfile[vagIndex].Relating.OutboundProxy);
    setText('OutboundProxyPort_text',AllProfile[vagIndex].Relating.OutboundProxyPort);
    setText('StandbyOutboundProxy_text',AllProfile[vagIndex].Relating.X_HW_SecondaryOutboundProxy);
    setText('StandbyOutboundProxyPort_text',AllProfile[vagIndex].Relating.X_HW_SecondaryOutboundProxyPort);    
    setText('ProxyServer_text',AllProfile[vagIndex].Relating.ProxyServer);
    setText('ProxyServerPort_text',AllProfile[vagIndex].Relating.ProxyServerPort);
    setText('StandbyProxyServer_text',AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServer);
    setText('StandbyProxyServerPort_text',AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServerPort);
    setText('RegistrarServer_text',AllProfile[vagIndex].Relating.RegistrarServer);
	setText('RegistrarServerPort_text',AllProfile[vagIndex].Relating.RegistrarServerPort);
	setText('StandbyRegistrarServer_text',AllProfile[vagIndex].Relating.X_HW_SecondaryRegistrarServer);
	setText('StandbyRegistrarServerPort_text',AllProfile[vagIndex].Relating.X_HW_SecondaryRegistrarServerPort);
    
    var wanSigValue;
    for (k = 0; k < WanInfo.length; k++ )
    {
        if ( MakeVoipWanName(WanInfo[k]) ==  AllProfile[vagIndex].X_HW_PortName)
        {
            wanSigValue = domainTowanname(WanInfo[k].domain);            
            break;
        }        
    }
    if (k == WanInfo.length)
    {
        wanSigValue = AllProfile[vagIndex].X_HW_PortName;
    }
    
    var wanRtpValue;
    for (k = 0; k < WanInfo.length; k++ )
    {
        if ( MakeVoipWanName(WanInfo[k]) == MediaPortName[vagIndex].X_HW_PortName_RTP)
        {
            wanRtpValue = domainTowanname(WanInfo[k].domain);            
            break;
        }        
    }
    if (k == WanInfo.length)
    {
        wanRtpValue = MediaPortName[vagIndex].X_HW_PortName_RTP;
    }

    
}

function OnDeleteButtonClick1(tabTitle)
{
	var Selected = false;
	var RmlList = document.getElementsByName("rml");
    for (var i = 0; i < RmlList.length; i++)
	{
		if (RmlList[i].checked == true)
		{
			Selected = true;
		}
    }
	if (Selected == true)
	{
	    document.getElementById("SettingDelete_button").disabled = true;
	}

	clickRemove(tabTitle, "SettingDelete_button");
}



function writeTabCfgHeader1(tabTitle, tabWidth,titleWidth)
{
	writeTabHeader1(tabTitle,tabWidth,titleWidth,'cfg');
}
function writeTabHeader1(tabTitle, width, titleWidth, type)
{
	if (width == null)
	    width = "70%";
		
	if (titleWidth == null)
	   titleWidth = "120";
			
	var html = 
			"<table width=\"" + width + "\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
			+ "<tr>"
			+ "<td>"
			+ "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
			+ "<tr>"
			+ " <td width=\"7\" height=\"22\"> <\/td>"
			+ "<td valign=\"bottom\" align=\"center\" width=\"" + titleWidth + "\" >"
			+ "<\/td>"
			+ "<td width=\"7\"><\/td>"
			+ "<td align=\"right\">"
			+ "<table border=\"0\" cellpadding=\"1\" cellspacing=\"0\">"
			+ "<tr>";
	
	if ('info' == type)
	{
		 
	}
	else if ('cfg' == type)
	{
		
		html +=  '<td><input class="submit" id="LineSettingAdd_button" type="button" value="新建" '
		         + 'onclick="clickAdd(\''
		         + tabTitle + '\');"></td>'
				 
				 + '<td><input id="SettingDelete_button" class="submit" type="button" value="删除" '
				 + 'onclick="OnDeleteButtonClick1(\''
			     + tabTitle + '\');"></td>'
				 + '<td width="3"></td>';
	}
	
	html += "<\/tr>"
			+ "<\/table>"
			+ "<\/td>"
			+ "<\/tr>"
			+ "<\/table>"
			+ "<\/td>"
			+ "<\/tr>"
			+ "<tr>"
			+ "<td id=\"" + tabTitle + "\">";
	
	writeFile(html);			
	document.write(html);		
}

function LoadFrame()
{
    init();
  	if(AllPhyInterface.length > 2)  
	{
		if (LineList[vagIndex].length > 0)
		{
			selectLine('record_0');
			setDisplay('ConfigForm1', 1);
		}    
		else
		{    
			selectLine('record_no');
			setDisplay('ConfigForm1', 0);
		}	
	}
	else
	{
		if(LineList[vagIndex].length == 0)
		{
			setText('URI_text',''); 
			setText('AuthUserName_text','');
			setText('AuthPassword_password','');
			setCheck('Enable', '');
		}
		else
		{
			setText('URI_text',AuthList[vagIndex][0].URI); 
			setText('AuthUserName_text',AuthList[vagIndex][0].AuthUserName);
			setText('AuthPassword_password',AuthList[vagIndex][0].AuthPassword);
			setCheck('Enable', LineList[vagIndex][0].Enable);
		}
		 
		setDisplay('ConfigForm1', 1);	
	}

    
    if (MngtShct == 1)
    {   
        setDisplay('ConfigForm2', 0);
    }
    else
    {
        setDisplay('ConfigForm2', 1);
    }
    
    if((CfgMode.toUpperCase() == 'TELMEX') || ('TELMEX5G' == CfgMode.toUpperCase()))
    {
            setDisplay('vspa_basic_div', 0);
    } else if (CfgMode.toUpperCase() == 'ZJCT') {
        setDisplay('zjctRegisterMode', 1);
        setDisplay('zjctHeartBeat', 1);
    }

	if('SCCT' == CfgMode.toUpperCase())
	{		
		setDisable('LineSettingAdd_button',1);
		setDisable('SettingDelete_button',1);
		setDisable('Enable',1);
		setDisable('PhyReferenceList',1);
		setDisable('URI_text',1);
		setDisable('AuthUserName_text',1);
		setDisable('AuthPassword_password',1);		
	}
    
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }
        b.innerHTML = sipinterface[b.getAttribute("BindText")];
    }
	if(isOltVisualUser == 1)
	{
        var all_input = document.getElementsByTagName("input");
        for (var i = 0; i <all_input.length ; i++) 
        {
            var b_input = all_input[i];
            
            if (b_input.type == "button")
            {
                setDisable(b_input.id,1);
            }
            else
            {
                b_input.disabled = "disabled";
            }
        }
        $("select").attr("disabled",true);
	}
}

var g_Index = -1;

function isIpAddress(address) 
{
    var i = 0;

    var addrParts = address.split('.');
    if (addrParts.length != 4) 
    {
        return false;
    }
    
    for (i = 0; i < 4; i++) 
    {
        if (isNaN(addrParts[i]) || addrParts[i] == ""
            || addrParts[i].charAt(0) == '+' || addrParts[i].charAt(0) == '-')
        {
            return false;
        }
        if (!isInteger(addrParts[i]) || addrParts[i] < 0)
        {
            return false;
        }
    }
    return true;
}

function getIpAddress(address)
{
    var i = 0;
    var addrParts = address.split('.');
    var IpAddress=parseInt(addrParts[0],10)+'.'+parseInt(addrParts[1],10)+'.'+parseInt(addrParts[2],10)+'.'+parseInt(addrParts[3],10);
    return IpAddress
}

function isvalidVoipIpAddress(address)
{
    var i = 0;
    if (address == '255.255.255.255')
    {
        return false;
    }
        
    if (address == '0.0.0.0')
    {
        return true;
    } 
     
    var addrParts = address.split('.');
    if ( addrParts.length != 4 ) return false;
    for (i = 0; i < 4; i++) 
    {
        if (isNaN(addrParts[i]) || addrParts[i] ==""
            || addrParts[i].charAt(0) == '+' ||  addrParts[i].charAt(0) == '-' )
           return false;
           
        if (addrParts[i].length > 3 || addrParts[i].length < 1)
        {
            return false;
        }
        
        if (addrParts[i].length > 1 && addrParts[i].charAt(0) == '0')
        {
            return false;
        }
        if (!isInteger(addrParts[i]) || addrParts[i] < 0)
        {
            return false;
        }
        num = parseInt(addrParts[i]);
        if ( num < 0 || num > 255 )
           return false;
    }
    return true;
}


function vspaisValidCfgStr(cfgName, val, len)
{
    if (isValidAscii(val) != '')         
    {  
        AlertEx(cfgName + sipinterface['vspa_hasvalidch'] + isValidAscii(val) + sipinterface['vspa_end']);          
        return false;       
    }
    if (val.length > len)
    {
        AlertEx(cfgName + sipinterface['vspa_cantexceed']  + len  + sipinterface['vspa_characters']);
        return false;
    }        
}

function CheckSpace()
{  
    var Firstoutbound = "";
    var Secoutbound = "";
    var FirstProxy = "";
    var SecProxy = "";
    var Reg = "";
    var SecReg = "";
    var URI = ""
    var spaceInfo = "";
    var inLen = 0;
	
	FirstProxy = getValue('ProxyServer_text');
    inLen =  FirstProxy.length;
    if( inLen != 0)
    {
        if(  ( FirstProxy.charAt(0) == ' ' ) || (FirstProxy.charAt(inLen -1) == ' ') )
        {
            spaceInfo = sipinterface['vspa_thepriproxy'];
        }
    }
	
	Reg = getValue('RegistrarServer_text');
    inLen =  Reg.length;
    if( inLen != 0)
    {
        if(  ( Reg.charAt(0) == ' ' ) || (Reg.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_regserver1'];
            }
            else
            {
                spaceInfo =  sipinterface['vspa_regserver1'];
            }
        }
    }
    
    Firstoutbound = getValue('OutboundProxy_text');
    inLen =  Firstoutbound.length;
    if( inLen != 0)
    {
        if(  ( Firstoutbound.charAt(0) == ' ' ) || (Firstoutbound.charAt(inLen -1) == ' ') )
        {
			if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_theoutproxy'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_theoutproxy'];
            }
        }
    }
    
    SecProxy = getValue('StandbyProxyServer_text');
    inLen =  SecProxy.length;
    if( inLen != 0)
    {
        if(  ( SecProxy.charAt(0) == ' ' ) || (SecProxy.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_standbyproxy'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_standbyproxy'];
            }
        }
    }
    
    SecReg = getValue('StandbyRegistrarServer_text');
    inLen =  SecReg.length;
    if( inLen != 0)
    {
        if(  ( SecReg.charAt(0) == ' ' ) || (SecReg.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_secregserver1'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_secregserver1'];
            }
        }
    }
	
	Secoutbound = getValue('StandbyOutboundProxy_text');
    inLen =  Secoutbound.length;
    if( inLen != 0)
    {
        if(  ( Secoutbound.charAt(0) == ' ' ) || (Secoutbound.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_thesecproxy'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_thesecproxy'];
            }
        }
    }
    
    URI = getValue('URI_text');
    inLen =  URI.length;
    if( inLen != 0)
    {
        if(  ( URI.charAt(0) == ' ' ) || (URI.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_e8ctelno'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_e8ctelno'];
            }
        }
    }
    
    return spaceInfo;
}

function CheckForm1()
{   
    var spaceInfo = CheckSpace();
    if("" != spaceInfo)
    {
        AlertEx(sipinterface['vspa_alertStart'] + spaceInfo + sipinterface['vspa_alertEnd']);
        return false;
    }
	
    if ( '' != removeSpaceTrim(getValue('OutboundProxy_text')))
    {
        if ( true == isIpAddress(getValue('OutboundProxy_text')) )
        {
            if (false == isvalidVoipIpAddress(getValue('OutboundProxy_text')))
            {
                AlertEx(sipinterface['vspa_outproxyaddvalid']);
                return false;
            }
        }
        else
        {           
            if ( false == vspaisValidCfgStr(sipinterface['vspa_theoutproxy'], getValue('OutboundProxy_text'),65) )
            {                  
                return false;       
            }
            var OutboundProxy = getValue('OutboundProxy_text'); 
            
            if ( (OutboundProxy.substring(0,1) <= 9) &&(OutboundProxy.substring(0,1) >= 0))
            {
                AlertEx(sipinterface['vspa_outproxyvalid']);
                return false;
            }
        }
    }        

    if ( isValidVoipPort(getValue('OutboundProxyPort_text')) == false )
    {
		AlertEx(sipinterface['vspa_theoutport'] +  getValue('OutboundProxyPort_text') + sipinterface['vspa_isvalid']);
		return false;
    }        
		
    if ( '' != removeSpaceTrim(getValue('StandbyOutboundProxy_text')))
    {
        if ( true == isIpAddress(getValue('StandbyOutboundProxy_text')) )
        {
            if (false == isvalidVoipIpAddress(getValue('StandbyOutboundProxy_text')))
            {
                AlertEx(sipinterface['vspa_secproxyaddvalid']);
                return false;
            }
        }
        else
        {           
            if ( false == vspaisValidCfgStr(sipinterface['vspa_thesecproxy'], getValue('StandbyOutboundProxy_text'),65) )
            {                  
                return false;       
            }
            var SecondaryOutboundProxy = getValue('StandbyOutboundProxy_text'); 
            
            if ( (SecondaryOutboundProxy.substring(0,1) <= 9) &&(SecondaryOutboundProxy.substring(0,1) >= 0))
            {
                AlertEx(sipinterface['vspa_secproxyvalid']);
                return false;
            }
        }
    }        

	if ( isValidVoipPort(getValue('StandbyOutboundProxyPort_text')) == false )
	{
		AlertEx(sipinterface['vspa_thesecporxy'] +  getValue('StandbyOutboundProxyPort_text') + sipinterface['vspa_isvalid']);
		return false;
	}        
    
    if ( '' != removeSpaceTrim(getValue('ProxyServer_text')))
    {
        if ( true == isIpAddress(getValue('ProxyServer_text')) )
        {
            if (false == isvalidVoipIpAddress(getValue('ProxyServer_text')))
            {
                AlertEx(sipinterface['vspa_priproxyaddva']);
                return false;
            }
        }
        else
        {           
            if ( false == vspaisValidCfgStr(sipinterface['vspa_thepriproxy'], getValue('ProxyServer_text'),65) )
            {                  
                return false;       
            }
            var proxyserv = getValue('ProxyServer_text'); 
            
            if ( (proxyserv.substring(0,1) <= 9) &&(proxyserv.substring(0,1) >= 0))
            {
                AlertEx(sipinterface['vspa_priproxyva']);
                return false;
            }
        }
    }        
    
	if ( isValidVoipPort(getValue('ProxyServerPort_text')) == false )
	{
		AlertEx(sipinterface['vspa_thepri'] +  getValue('ProxyServerPort_text') + sipinterface['vspa_isvalid']);
		return false;
	}        
	
	if ( isValidVoipPort(getValue('RegistrarServerPort_text')) == false )
	{
		AlertEx('主用注册端口号“' +  getValue('RegistrarServerPort_text') + sipinterface['vspa_isvalid']);
		return false;
	}        
	
	if ( isValidVoipPort(getValue('StandbyRegistrarServerPort_text')) == false )
	{
		AlertEx('备用注册端口号“' +  getValue('StandbyRegistrarServerPort_text') + sipinterface['vspa_isvalid']);
		return false;
	}        
	
    if ( '' != removeSpaceTrim(getValue('StandbyProxyServer_text')))
    {
        if ( true == isIpAddress(getValue('StandbyProxyServer_text')) )
        {
            if ( false == isvalidVoipIpAddress(getValue('StandbyProxyServer_text')) )
            {
                AlertEx(sipinterface['vspa_stproxyaddvalid']);
                return false;
            }
        }
        else
        {
            if ( false == vspaisValidCfgStr(sipinterface['vspa_standbyproxy'],getValue('StandbyProxyServer_text'),65) )
            {
                return false;
            }
            
            var proxysndserv = getValue('StandbyProxyServer_text'); 
            
            if ( (proxysndserv.substring(0,1) <= 9) &&(proxysndserv.substring(0,1) >= 0))
            {
                AlertEx(sipinterface['vspa_stproxyvalid']);
                return false;
            }            
        }
    }
    
	if ( isValidVoipPort(getValue('StandbyProxyServerPort_text')) == false )
	{
		AlertEx(sipinterface['vspa_thestport'] +  getValue('StandbyProxyServerPort_text') + sipinterface['vspa_isvalid']);
		return false;
	}

    if ( '' != removeSpaceTrim(getValue('RegistrarServer_text')))
    {
        if ( true == isIpAddress(getValue('RegistrarServer_text')) )
        {
            if (false == isvalidVoipIpAddress(getValue('RegistrarServer_text')))
            {
                AlertEx(sipinterface['vspa_domainvalid']);
                return false;
            }
        }
        else
        {        
            if (vspaisValidCfgStr(sipinterface['vspa_thehomedomain'],getValue('RegistrarServer_text'),65) == false)
            {
                AlertEx(sipinterface['vspa_domainvalid']);
                return false;
            }
        }
    }

    return true;
}

function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
}

var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;

function stLine(Domain, DirectoryNumber, Enable, PhyReferenceList )
{
    this.Domain = Domain;
    this.DirectoryNumber = DirectoryNumber;
    this.PhyReferenceList = PhyReferenceList;

    if (Enable.toLowerCase() == 'enabled')
    {
        this.Enable = 1;
    }
    else
    {
        this.Enable = 0;
    }     
	
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|Enable|PhyReferenceList,stLine);%>;
var LineList = new Array(new Array(),new Array(),new Array(),new Array());
var AllLineInsNumArray = new Array(new Array(),new Array(),new Array(),new Array());
for(var j = 0; j < 4; j++)
{
	for(var i = 0; i < 68; i++)
	{
		AllLineInsNumArray[j][i]=256;
		
	}
}

for (var i = 0; i < AllLine.length-1; i++)
{
    var temp = AllLine[i].Domain.split('.');
    var Vagindex = GetVagIndexByInst(temp[5]);
    LineList[Vagindex].push(AllLine[i]);
	index = temp[7];
	AllLineInsNumArray[Vagindex][index - 1] = index;
}

function FindFreeLineInst(Vagindex)
{
	var numtotal = AllLineInsNumArray[Vagindex].length ;

	for(var i = 0; i < 68; i++)
	{
		if(256 == AllLineInsNumArray[Vagindex][i])
		{
			return i+1;
		}
	}
	return 256;
}

function stAuth(Domain, AuthUserName, AuthPassword, URI)
{
    this.Domain = Domain;
    if(AuthUserName != null)
    {
        this.AuthUserName = AuthUserName.toString().replace(/&apos;/g,"\'"); 
    }
    else
    {
        this.AuthUserName = AuthUserName;
    }    
	this.AuthPassword = AuthPassword;
    if(URI != null)
    {
        this.URI = URI.toString().replace(/&apos;/g,"\'");   
    }
    else
    {
        this.URI = URI;
    } 
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,AuthUserName|AuthPassword|URI,stAuth);%>;
var AuthList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllAuth.length-1; i++)
{
    var temp = AllAuth[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    AuthList[index].push(AllAuth[i]);
}

var recordDirectoryNumber;

function SelectLineRecord(recordId)
{
    selectLine(recordId);
}

function SubmitServerType()
{
	var newServerTpyeValue = getSelectVal('ServerType_select');
	var Form = new webSubmitForm();

	if((0 == newServerTpyeValue) || (1 == newServerTpyeValue))
	{
		Form.addParameter('x.X_HW_ServerType',getSelectVal('ServerType_select'));
        	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

			ActionURL = 'set.cgi?'
					+ 'x=' +  AllServerType[vagIndex].Domain				
					+ '&RequestFile=html/voip/cnvoipinterface/cnvoipinterface.asp';		
	}
	else
	{
		Form.addParameter('x.X_HW_ServerType',getSelectVal('ServerType_select'));
        	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

			ActionURL = 'set.cgi?'
					+ 'x=' +  AllServerType[vagIndex].Domain				
					+ '&RequestFile=html/voip/cnvoipinterface/cnvoipServertypechangeTemp.asp';			
	}
	
	Form.setAction(ActionURL); 		
	Form.submit();			
}

function SubmitBasicPara()
{
    
    var Form = new webSubmitForm();
    var sndProServerPort;
    var ProServerPort;
    var sndOutboundServerPort;
    var OutboundServerPort;
    var ActionURL;
    var FreeLine;
	var PriRegistrarServerPort;
	var sndRegistrarServerPort;
    var strvar = getValue('AuthPassword_password');
    
    if(AllProfile[0] == null)
    {
        return false;
    }
           
    var ulret = CheckForm1();
    if (ulret != true )
    {
        return false;
    }
    
    ulret = CheckParaForm();
    if (ulret != true )
    {
        return false;
    }
   
    if(removeSpaceTrim(getValue('StandbyProxyServerPort_text').toString()) == "")
    {
        sndProServerPort = 0;
    }
    else
    {
        sndProServerPort = parseInt(getValue('StandbyProxyServerPort_text'),10);
    } 
    
    
    if(removeSpaceTrim(getValue('ProxyServerPort_text').toString()) == "")
    {
        ProServerPort = 0;
    }
    else
    {
        ProServerPort = parseInt(getValue('ProxyServerPort_text'),10);
    }
    
    if(removeSpaceTrim(getValue('OutboundProxyPort_text').toString()) == "")
    {
        OutboundServerPort = 0;
    }
    else
    {
        OutboundServerPort = parseInt(getValue('OutboundProxyPort_text'),10);
    }
    if(removeSpaceTrim(getValue('StandbyOutboundProxyPort_text').toString()) == "")
    {
        sndOutboundServerPort = 0;
    }
    else
    {
        sndOutboundServerPort = parseInt(getValue('StandbyOutboundProxyPort_text'),10);
    }    
    if(removeSpaceTrim(getValue('RegistrarServerPort_text').toString()) == "")
    {
        PriRegistrarServerPort = 0;
    }
    else
    {
        PriRegistrarServerPort = parseInt(getValue('RegistrarServerPort_text'),10);
    }  	
    if(removeSpaceTrim(getValue('StandbyRegistrarServerPort_text').toString()) == "")
    {
        sndRegistrarServerPort = 0;
    }
    else
    {
        sndRegistrarServerPort = parseInt(getValue('StandbyRegistrarServerPort_text'),10);
    }  	
    
    if(CheckUserRepeat())
    {
        return false;
    }

    Form.addParameter('y.OutboundProxy',getValue('OutboundProxy_text'));	
    Form.addParameter('y.OutboundProxyPort',parseInt(OutboundServerPort));	
    Form.addParameter('y.X_HW_SecondaryOutboundProxy',getValue('StandbyOutboundProxy_text'));
    Form.addParameter('y.X_HW_SecondaryOutboundProxyPort',parseInt(sndOutboundServerPort));
    Form.addParameter('y.ProxyServer',getValue('ProxyServer_text'));
    Form.addParameter('y.ProxyServerPort',parseInt(ProServerPort));
    Form.addParameter('y.X_HW_SecondaryProxyServerPort',parseInt(sndProServerPort));
    Form.addParameter('y.X_HW_SecondaryProxyServer',getValue('StandbyProxyServer_text'));
    Form.addParameter('y.RegistrarServer',getValue('RegistrarServer_text'));
	Form.addParameter('y.RegistrarServerPort',parseInt(PriRegistrarServerPort));
	Form.addParameter('y.X_HW_SecondaryRegistrarServer',getValue('StandbyRegistrarServer_text'));
	Form.addParameter('y.X_HW_SecondaryRegistrarServerPort',parseInt(sndRegistrarServerPort));

    if (CfgMode.toUpperCase() == 'ZJCT') {
        Form.addParameter('l.RegisterMode',getSelectVal('RegisterMode'));
        Form.addParameter('l.HeartBeatPattern',getSelectVal('HeartBeatPattern'));
        Form.addParameter('m.HeartBeatRetransTimer',getValue('HeartbeatCycle_text'));
    }

	if('SCCT' == CfgMode.toUpperCase())
	{
		selctIndex = -3;
	}
	else
	{
		if(AllPhyInterface.length <= 2)
		{
			Form.addParameter('Add_b.PhyReferenceList',1);
			if(LineList[vagIndex].length == 0)
			{
				selctIndex = -1;
			}
			else
			{
				selctIndex = 0;
			}
		}
		else
		{
			Form.addParameter('Add_b.PhyReferenceList',getValue('PhyReferenceList'));
		}
		
		Form.addParameter('c.AuthUserName',getValue('AuthUserName_text'));
		
		if (strvar != '****************************************************************')
		{
			Form.addParameter('c.AuthPassword',getValue('AuthPassword_password'));   
		}
	 
		Form.addParameter('c.URI',getValue('URI_text'));
	  
		if (getCheckVal('Enable') == 1)
		{
			Form.addParameter('Add_b.Enable','Enabled');
		}
		else
		{
			Form.addParameter('Add_b.Enable','Disabled');
		}	
	}
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    if( selctIndex == -1 )
    {
		
        FreeLine= FindFreeLineInst(vagIndex);  
        ActionURL = 'complex.cgi?'
                + 'x=' +  AllProfile[vagIndex].Domain
                + '&y=' + AllProfile[vagIndex].Domain + '.SIP'
                + '&z=' + AllProfile[vagIndex].Domain + '.SIP.X_HW_SIPDigitmap.1'
                + '&a=' + AllProfile[vagIndex].Domain + '.RTP'
                + '&Add_b=' + AllProfile[vagIndex].Domain + '.Line'
                + '&c=' + AllProfile[vagIndex].Domain + '.Line.' + FreeLine + '.SIP';
    }
    else if( selctIndex == -2 )
    {
        ActionURL = 'set.cgi?x=' + AllProfile[vagIndex].Domain
                         + '&y=' + AllProfile[vagIndex].Domain + '.SIP'
                         + '&z=' + AllProfile[vagIndex].Domain + '.SIP.X_HW_SIPDigitmap.1'
                         + '&a=' + AllProfile[vagIndex].Domain + '.RTP';
    }
    else if (selctIndex == -3)
	{
        ActionURL = 'set.cgi?x=' + AllProfile[vagIndex].Domain
					+ '&y=' + AllProfile[vagIndex].Domain + '.SIP';
	}
    else
    {
      ActionURL = 'set.cgi?'
                + 'x=' +  AllProfile[vagIndex].Domain
                + '&y=' + AllProfile[vagIndex].Domain + '.SIP'
                + '&z=' + AllProfile[vagIndex].Domain + '.SIP.X_HW_SIPDigitmap.1'
                + '&a=' + AllProfile[vagIndex].Domain + '.RTP'
                + '&Add_b=' + LineList[vagIndex][selctIndex].Domain
                + '&c=' + LineList[vagIndex][selctIndex].Domain + '.SIP';
    }

    if (CfgMode.toUpperCase() == 'ZJCT') {
        ActionURL += '&l=' + H248.Domain + '&m=' + H248Extend[0].Domain;
    }
    ActionURL += '&RequestFile=html/voip/cnvoipinterface/cnvoipinterface.asp';
    Form.setAction(ActionURL);                               
    setDisable('btnApplySipUser',1);
    setDisable('SaveApply_button',1);
    setDisable('Cancel_button',1);
    Form.submit();
}

function setCtlDisplay(LineRecord, AuthRecord)
{
    setText('URI_text',AuthRecord.URI); 
    setText('DirectoryNumber',LineRecord.DirectoryNumber);
    setText('AuthUserName_text',AuthRecord.AuthUserName);
    setText('AuthPassword_password',AuthRecord.AuthPassword);
    setSelect('PhyReferenceList', LineRecord.PhyReferenceList);
    setCheck('Enable', LineRecord.Enable);
}

function initCtlValue()
{
    setText('URI_text',''); 
    setText('DirectoryNumber','');
    setText('AuthUserName_text','');
    setText('AuthPassword_password','');
    setSelect('PhyReferenceList', '');
    setCheck('Enable', '');
}

var g_Index = -1;

function setControl(index)
{
    var record;
    selctIndex = index;

    if (index == -1)
    {   
        if(LineList[vagIndex].length >= ((AllPhyInterface.length - 1) * 17))
        {
            setDisplay('ConfigForm1', 0);
            AlertEx(sipinterface['vspa_toomanyuser']);
            return false;
        }   
        
        var LineRecord = new stLine("","","Disabled","");
        var AuthRecord = new stAuth("","","","");
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(LineRecord, AuthRecord);
    }
    else if (index == -2)
    {
        setDisplay('ConfigForm1', 0);
    }
    else
    {
        record = LineList[vagIndex][index];
        var LineRecord = LineList[vagIndex][index];
        var AuthRecord = AuthList[vagIndex][index];
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(LineRecord, AuthRecord);
    }
    g_Index = index;
}

function clickRemove() 
{
    if (LineList[vagIndex].length == 0)
    {
        AlertEx(sipinterface['vspa_usercanotdel']);
        return;
    }
    
    if (selctIndex == -1)
    {
        AlertEx(sipinterface['vspa_usercanotdel1']);
        document.getElementById("SettingDelete_button").disabled = false;
        return;
    }
    var rml = getElement('rml');
    var noChooseFlag = true;
    if ( rml.length > 0)
    {
         for (var i = 0; i < rml.length; i++)
         {
             if (rml[i].checked == true)
             {   
                 noChooseFlag = false;
             }        
         }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
    }
    if ( noChooseFlag )
    {
        AlertEx(sipinterface['vspa_nouserdel']);
        return ;
    }
        
    if (ConfirmEx(sipinterface['vspa_del']) == false)
    {
        document.getElementById("SettingDelete_button").disabled = false;
        return;
    }
    setDisable('btnApplySipUser',1);
    setDisable('SaveApply_button',1);
    setDisable('Cancel_button',1);
    removeInst('html/voip/cnvoipinterface/cnvoipinterface.asp');     
}  

function CheckParaForm()
{    
     var inSipAuthUserName;
     var inLen = 0;

     if ( '' != removeSpaceTrim(getValue('URI_text')))
     {
         if (vspaisValidCfgStr(sipinterface['vspa_theuri'],getValue('URI_text'),64) == false)
         {
             return false;
         }    
     }
     
     if ( '' != removeSpaceTrim(getValue('AuthUserName_text')))
     {
         if (vspaisValidCfgStr(sipinterface['vspa_theauthname'],getValue('AuthUserName_text'),64) == false)
         {
             return false;
         }
     }
     
     if ( '' != removeSpaceTrim(getValue('AuthPassword_password')))
     {        
    
         if (vspaisValidCfgStr(sipinterface['vspa_thepassword'],getValue('AuthPassword_password'),64) == false)
         {
             return false;
         }
     }                     

	if(AllPhyInterface.length > 2)
	{     
     if((selctIndex < 0) || (getValue('PhyReferenceList') != LineList[vagIndex][selctIndex].PhyReferenceList) || (getCheckVal('Enable') != LineList[vagIndex][selctIndex].Enable))
     {
         for (var i = 0; i < LineList[vagIndex].length; i++)
         {
            if (selctIndex != i)
            {
                if ((getValue('PhyReferenceList') != "") && (getValue('PhyReferenceList') == LineList[vagIndex][i].PhyReferenceList) )
                {
                    if((getCheckVal('Enable') == 1) && (LineList[vagIndex][i].Enable == 1))
                    { 
                        var ulret = ConfirmEx(sipinterface['vspa_pots']+getValue('PhyReferenceList')+sipinterface['vspa_potsassohint']);
                        return ulret;
                    }
                }
            }    
         }
     }
          
     if (getValue('PhyReferenceList') != "")
     {
         for (var i = 0; i < LineList.length; i++)
         {
             if(vagIndex != i)
             {
                 for (var j = 0; j < LineList[i].length; j++)
                 {
                     if(getValue('PhyReferenceList') == LineList[i][j].PhyReferenceList)
                     {
                         AlertEx(sipinterface['vspa_vagsportexsit']);
                         return false;
                     }
                 }
             }
         }
     }
	} 
     inSipAuthUserName = getValue('AuthUserName_text');
     inLen =  inSipAuthUserName.length;
     
     if( inLen != 0)
     {
         if    (  ( inSipAuthUserName.charAt(0) == ' ' ) || (inSipAuthUserName.charAt(inLen -1) == ' ') )
         {
            if(ConfirmEx(sipinterface['vspa_spacewarning']))
            {
                return true;
            }
            else
            {            
                return false;
            }
         }
     }
     
     return true;
}

function stUserRepeatCheck(Domain, UserRepeatCheck)
{
    this.Domain = Domain;
    this.UserRepeatCheck = UserRepeatCheck;
}
var UserRepeatCheckFlag = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.X_HW_InnerParameters,UserRepeatCheck,stUserRepeatCheck);%>;

function isEmpty(obj)
{
    if(typeof obj == "undefined" || obj == null || obj == "")
	{
        return true;
    }
	else
	{
        return false;
    }
}

function CheckUserRepeat()
{
    var configUri = getValue('URI_text');
	var configUserName = getValue('AuthUserName_text');
	
	if(UserRepeatCheckFlag[0].UserRepeatCheck == 0)
	{
	    return false;
	}
	if(selctIndex==-3 || selctIndex==-2)
	{
	    return false;
	}
    for(var existIndex = 0; (existIndex < LineList[vagIndex].length)&&(existIndex < 2); existIndex++)
	{
			if(!isEmpty(configUserName))
			{
			    if(configUserName == AuthList[vagIndex][existIndex].AuthUserName && selctIndex != existIndex)
				{
				    AlertEx("配置用户名 "+configUserName+" 已存在用户名 "+ AuthList[vagIndex][existIndex].AuthUserName+" 重复!");
				    return true;
				}
			}
			if(!isEmpty(configUri))
			{
			    if(configUri == AuthList[vagIndex][existIndex].URI && selctIndex != existIndex)
				{
				    AlertEx("配置号码 "+configUri+" 已存在号码 "+ AuthList[vagIndex][existIndex].URI+" 重复!");
				    return true;
				}
			}
	}
	
	return false;
}

function CancelUserConfig(selctIndex)
{
    LoadFrame();
    selectLine('record_'+selctIndex);
}

function SubmitGetProfile(vagInst)
{
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('SetVoiceVagIndex.cgi?vagIndex=' + vagInst);
    Form.setTarget('disableIframe');
    Form.submit();
    
    vagIndex = GetVagIndexByInst(vagInst);
    LoadFrame();
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">

<script type="text/javascript">
if(AllProfile.length > 2)
{
    document.write('<iframe name="disableIframe" style="display:none"></iframe>');
    document.write('<table border="0" cellpadding="0" cellspacing="0">');
    document.write('<tr>');
    var html = '';
    
    for(var i = 0; i < AllProfile.length-1; i++)
    {
        html += '<td><input id="vag_' + i + '" name="vag_tr" type="button" onfocus="this.blur()" class="submit" style="cursor:pointer;background:#C3C3C3;font-size: 12px;height: 25px;width: 110px;border: 0px;" onClick="SubmitGetProfile(' +htmlencode(AllProfile[i].profileid)+ ');"/>';
        html += '</td>';
    }
    
    document.write(html);
    document.write('</tr>');
    document.write('</table>');
}
</script>
<div style="height: 3px;"></div>
<div id="vspa_basic_div">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="tabal_head" BindText='vspa_protocol'></td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1"> 
  <tr>
    <td  class="table_title align_left width_per25" BindText='vspa_protocolList'></td> 
    <td  class="table_right align_left width_per75" >
        <select name="ServerType_select" id="ServerType_select" class="wid_60px" onchange="SubmitServerType();"  >
           <script language="JavaScript" type="text/javascript">
                document.write('<option value=' + "0" + ' id="IMS_SIP">' + "IMS"+ '<\/option>'); 
                document.write('<option value=' + "1" + ' id="NGN_SIP">' + "软交换"+ '<\/option>');  
				document.write('<option value=' + "2" + ' id="H.248">' + "H.248"+ '<\/option>');                                              
           </script>
      </select>
    </td> 
  </tr>
</table> 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height15p"></td></tr>
</table>


<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="tabal_head" BindText='vspa_basic'></td>
  </tr>
</table>

<table id="zjctRegisterMode" width="100%" border="0" cellpadding="0" cellspacing="0" style = "display: none">
    <tr>
        <td class="table_title align_left width_per25">终端注册方式：</td>
        <td class="width_per75 table_right" colspan="10">
            <select id="RegisterMode" class="width_125px">
            <option value="Wildcard">根注册</option>
            <option value="Individual">单端点</option>
            </select>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="tabal_head" BindText='vspa_mainserver'></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1">       
	<tr>
		<td class="table_title align_left width_per25" BindText='vspa_proxy'></td>
		<td class="table_right align_left width_per75" colspan="2">
		<input type="text" name="ProxyServer_text" id="ProxyServer_text" maxlength="256" value="" style="width: 155px" />
		<span class="gray"><script>document.write(sipinterface['vspa_outbandproxyhint']);</script></span>    </td>
	</tr>    
    <tr>    
    <td class="table_title align_left width_per25" BindText='vspa_proxyport'></td>
    <td class="table_right align_left width_per75" colspan="2">
    <input type="text" name="ProxyServerPort_text" id="ProxyServerPort_text" maxlength="11" value="5060" style="width: 155px" />
    <span class="gray">(1025-65535)</span>    </td>
    </tr>
	
	<tr>
	<td class="table_title align_left width_per25" BindText='vspa_regserver'></td>
	<td class="table_right align_left width_per75" colspan="2">
	<input type="text" name="RegistrarServer_text" id="RegistrarServer_text" maxlength="256" value="" style="width: 155px" />
	<span class="gray">(IP或域名，归属域名)</span>    </td>
	</tr>    
    <tr>    
    <td class="table_title align_left width_per25" BindText='vspa_regserverport'></td>
    <td class="table_right align_left width_per75" colspan="2">
    <input type="text" name="RegistrarServerPort_text" id="RegistrarServerPort_text" maxlength="11" value="5060" style="width: 155px" />
    <span class="gray">(1025-65535)</span>    </td>
    </tr>

     <tr>        
    <td class="table_title align_left width_per25" BindText='vspa_outbanproxy'></td>
    <td class="table_right align_left width_per75" colspan="2"><input type="text" name="OutboundProxy_text" id="OutboundProxy_text" maxlength="256" value="" style="width: 155px" />
    <span class="gray"><script>document.write(sipinterface['vspa_outbandproxyhint']);</script></span>    </td>
    </tr>
    <tr>
    <td  class="table_title align_left width_per25" BindText='vspa_outbandport'></td>
    <td class="table_right align_left width_per75" colspan="2">
    <input type="text" name="OutboundProxyPort_text" id="OutboundProxyPort_text" maxlength="256" value="" style="width: 155px" />
    <span class="gray">(1025-65535)</span>    </td>
    </tr>
	</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height15p"></td></tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="tabal_head" BindText='vspa_secserver'></td>
  </tr>
</table>	
   <table width="100%" border="0" cellpadding="0" cellspacing="1"> 
    <tr>
    <td class="table_title align_left width_per25" BindText='vspa_stproxy'></td>
        <td class="table_right align_left width_per75" colspan="2">
        <input type="text" name="StandbyProxyServer_text" id="StandbyProxyServer_text" maxlength="256" value="" style="width: 155px"/>
        <span class="gray"><script>document.write(sipinterface['vspa_outbandproxyhint']);</script></span> </td>                      
    </tr>
            
    <tr>     
    <td class="table_title align_left width_per25" BindText='vspa_stport'></td>
	<td class="table_right align_left width_per75" colspan="2">
	<input type="text" name="StandbyProxyServerPort_text" id="StandbyProxyServerPort_text" maxlength="11" value="5060" style="width: 155px">
	<span class="gray">(1025-65535)</span>
	</td>
    </tr>
   
   <tr>
	<td class="table_title align_left width_per25" BindText='vspa_secregserver'></td>
	<td class="table_right align_left width_per75" colspan="2">
	<input type="text" name="StandbyRegistrarServer_text" id="StandbyRegistrarServer_text" maxlength="256" value="" style="width: 155px" />
	<span class="gray"><script>document.write(sipinterface['vspa_outbandproxyhint']);</script></span>    </td>
	</tr>    
    <tr>    
    <td class="table_title align_left width_per25" BindText='vspa_secregserverport'></td>
    <td class="table_right align_left width_per75" colspan="2">
    <input type="text" name="StandbyRegistrarServerPort_text" id="StandbyRegistrarServerPort_text" maxlength="11" value="5060" style="width: 155px" />
    <span class="gray">(1025-65535)</span>    </td>
    </tr>

	<tr>
    <td class="table_title align_left width_per25" BindText='vspa_stoutproxy'></td>
	<td class="table_right align_left width_per75" colspan="2">
	<input type="text" name="StandbyOutboundProxy_text" id="StandbyOutboundProxy_text" maxlength="256" value="" style="width: 155px" />
	<span class="gray"><script>document.write(sipinterface['vspa_outbandproxyhint']);</script></span>    </td>
    </tr>
    <tr> 
	<td class="table_title align_left width_per25" BindText='vspa_stoutport'></td>
	<td class="table_right align_left width_per75" colspan="2">
	<input type="text" name="StandbyOutboundProxyPort_text" id="StandbyOutboundProxyPort_text" maxlength="256" value="" style="width: 155px" />
	<span class="gray">(1025-65535)</span>    </td>
    </tr> 
</table>

<table id="zjctHeartBeat" width="100%" border="0" cellpadding="0" cellspacing="1" style="display:none">
    <tr>
        <td class="table_title align_left width_per25">心跳方式：</td>
        <td class="width_per75 table_right" colspan="10">
            <select id="HeartBeatPattern" class="width_125px">
            <option value="0">被动心跳</option>
            <option value="1">MGC心跳</option>
            <option value="2">主动心跳</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="table_title width_20p">心跳时长：</td>
        <td width="80%" class="table_right" colspan="10" >
             <input type="text" id="HeartbeatCycle_text" class="width_125px"/><span class="gray"> (单位：秒) </span>
        </td>
    </tr>	
</table>

<div id="ConfigForm2">

</div>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height_30p"></td></tr>
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height15p"></td></tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="tabal_head"  BindText='vspa_userbaspara'></td>
  </tr>
</table>

<script language="JavaScript" type="text/javascript">
	if(AllPhyInterface.length > 2)
	{
		writeTabCfgHeader1('VOIP User',"100%");
	}	
</script>
       
<div id="line_list">
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height5p" ></td></tr>
</table>

<div id="ConfigForm1">
<table width="100%" border="0" cellpadding="0" cellspacing="1">
<tr>   
      <td class="table_title align_left width_per25">启用：</td>
    <td class="table_right align_left width_per75" colspan="2">
    <input name="Enable" id="Enable" type='checkbox' size="18" checked="checked" />                    
    </td>
</tr> 

<tr>
      <td class="table_title align_left width_per25" BindText='vspa_e8ctelno1'></td>
    <td class="table_right align_left width_per75" colspan="2">
    <input name="URI_text" type="URI_text" maxlength="389" style="width: 205px" /></td>
</tr>
 
  <script language="JavaScript" type="text/javascript">
	if(AllPhyInterface.length > 2)
	{
		document.write('<tr>');
		document.write('<td class="table_title align_left width_per25" BindText="vspa_asspot"></td>');	
		document.write('<td class="table_right align_left width_per75" colspan="2">');
		document.write('<select name="PhyReferenceList" id="PhyReferenceList" style="width: 50px">');	
            var k;
            document.write('<option value="" id="null">' + ''+ '<\/option>');
            for (k = 1; k < AllPhyInterface.length; k++)
            {
                document.write('<option value="' + k + '">' + k + '</option>');
            } 
		document.write('</select>');				 
		document.write(' </td>');	
		document.write('</tr>');	
	}
  </script> 

 <tr>
    <td class="table_title align_left width_per25" BindText='vspa_e8cusername1'></td>
    <td class="table_right  align_left width_per75" colspan="2">
    <input name="AuthUserName_text" id="AuthUserName_text" type="text" maxlength="256" style="width: 205px" />
    <span class="gray"> <script>document.write(sipinterface['vspa_authnamehint']);</script></span> </td>
</tr> 

 <tr>
    <td class="table_title align_left width_per25" BindText='vspa_paasw'></td>
    <td class="table_right align_left width_per75" colspan="2">
    <input name="AuthPassword_password" id="AuthPassword_password" type="password" autocomplete="off" maxlength="256" style="width: 205px" />
    <span class="gray"><script>document.write(sipinterface['vspa_passwdhint']);</script></span></td>
</tr> 
  <tr ><td class="height_9p"></td></tr>
</table>
 </div>
<table width="100%" border="0" cellpadding="0" cellspacing="1"  >
<tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="">
<tr>
<td class="width_per25"></td>
<td class="" align="right"> 
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<input name="SaveApply_button" id="SaveApply_button" type="button" class="submit" value="Apply" onClick="SubmitBasicPara();"/>
<script type="text/javascript">
document.getElementsByName('SaveApply_button')[0].value = sipinterface['e8cvspa_apply'];    
</script>
<input name="Cancel_button" id="Cancel_button" type="button" class="submit" value="Cancel" onClick="CancelUserConfig(selctIndex);"/>
<script>
document.getElementsByName('Cancel_button')[0].value = sipinterface['vspa_cancel'];
</script>
</td>
</tr>
</table>
</td>
</tr>
</table>    
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
</body>
</html>
