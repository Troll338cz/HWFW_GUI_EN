<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>VOIP Interface</title>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="javascript" src="../common/voip_disableallelement.asp"></script>
<style>
.interfacetextclass{
	width:300px;
	height:50px;
}

.TextBox
{
width:155px;
}

.lineclass
{
width:200px;
}


.wordclass
{
word-wrap:break-all;
word-break: break-all;
}


</style>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipinterface);%>"></script>
<script language="JavaScript" type="text/javascript"> 

var selctIndex = -1;
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var TelMexMode = 0;
if((CfgMode.toUpperCase() == 'TELMEX') || ('TELMEX5G' == CfgMode.toUpperCase()))
{
    TelMexMode = 1;
}

var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';

var vagIndex = 0;

var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>';

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function isValidVoipPort(port) 
{ 
   if (!isInteger(port) || port < 0 ||port > 65535)
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


var maxvagnum = AllProfile.length-1;

for (var i = 0; i < AllProfile.length-1; i++)
{
    AllProfile[i].DigitMap = SipDigitMap[i].DigitMap;
}

function stSIPServer(Domain, ProxyServer, ProxyServerPort,OutboundProxy,OutboundProxyPort,X_HW_SecondaryOutboundProxy,X_HW_SecondaryOutboundProxyPort, X_HW_SecondaryProxyServer, X_HW_SecondaryProxyServerPort, RegistrarServer, UserAgentPort,RegistrationPeriod)
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
    this.ProxyServerPort = ProxyServerPort;
    this.X_HW_SecondaryProxyServerPort = X_HW_SecondaryProxyServerPort;
    this.OutboundProxyPort = OutboundProxyPort;
    this.X_HW_SecondaryOutboundProxyPort = X_HW_SecondaryOutboundProxyPort; 
    var temp = Domain.split('.');
    this.key = '.' + temp[5] + '.';
}

var AllSIPServer = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP,ProxyServer|ProxyServerPort|OutboundProxy|OutboundProxyPort|X_HW_SecondaryOutboundProxy|X_HW_SecondaryOutboundProxyPort|X_HW_SecondaryProxyServer|X_HW_SecondaryProxyServerPort|RegistrarServer|UserAgentPort|RegistrationPeriod,stSIPServer);%>;
AssociateParam(AllProfile, AllSIPServer, 'ProxyServer|ProxyServerPort|OutboundProxy|OutboundProxyPort|X_HW_SecondaryOutboundProxy|X_HW_SecondaryOutboundProxyPort|X_HW_SecondaryProxyServer|X_HW_SecondaryProxyServerPort|RegistrarServer|UserAgentPort|RegistrationPeriod');

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

function MakeWanName(wan)
{
    var wanInst = 0;
    var wanServiceList = '';
    var wanMode = '';
    var vlanId = 0;
    var currentWanName = ''; 

    if('&nbsp;'!= wan)
    {
        if ("AIS" == CfgMode.toUpperCase() && wan.Name != '')
        {
            return wan.Name;       
        }
        wanInst = wan.MacId;
        wanServiceList  = wan.ServiceList;
        wanMode         = (wan.CntType  ==  'IP_Bridged' ) ? "B" : "R";
        vlanId          = wan.vlanid;

        if (1 == MngtShct|| CUVoiceFeature == "1")
        {
            switch(wanServiceList)
            {
                case "VOIP":
                wanServiceList = "VOICE";
                break;
                case "TR069_VOIP":
                wanServiceList = "TR069_VOICE";
                break;
                case "VOIP_INTERNET":
                wanServiceList = "VOICE_INTERNET";
                break;
                case "TR069_VOIP_INTERNET":
                wanServiceList = "TR069_VOICE_INTERNET";
                break;
				case "VOIP_IPTV":
		    	wanServiceList = "VOICE_IPTV";
		    	break;
		    	case "TR069_VOIP_IPTV":
		    	wanServiceList = "TR069_VOICE_IPTV";
		    	break;
		    	default:
		    	break;
		    }
	    }

	    if (0 != parseInt(vlanId))
	    {
	        currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
	    }
	    else
        {
            currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
        }

        return currentWanName;
    }
    else
    {
        return '&nbsp;';
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

function ShowTab(index, URI, TelNo, AuthUserName, Password,PhyReferenceList)
{
	this.index = index;
	this.URI = URI;
	this.TelNo = TelNo;
	this.AuthUserName = AuthUserName;
	this.Password = Password;
	this.PhyReferenceList = PhyReferenceList;
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
    

	initCtlValue();
    
    if(AllProfile[0] == null)
    {
        return;
    }
    
    if(AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServer == "255.255.255.255")
    {
        AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServer = "";
    }    
    
    if(AllProfile[vagIndex].Relating.ProxyServer == "255.255.255.255")
    {
        AllProfile[vagIndex].Relating.ProxyServer = "";
    }         
    setText('OutboundProxy',AllProfile[vagIndex].Relating.OutboundProxy);
    setText('OutboundProxyPort',AllProfile[vagIndex].Relating.OutboundProxyPort);
    setText('SecondaryOutboundProxy',AllProfile[vagIndex].Relating.X_HW_SecondaryOutboundProxy);
    setText('SecondaryOutboundProxyPort',AllProfile[vagIndex].Relating.X_HW_SecondaryOutboundProxyPort);    
    setText('ProxyServer',AllProfile[vagIndex].Relating.ProxyServer);
    setText('ProxyServerPort',AllProfile[vagIndex].Relating.ProxyServerPort);
    setText('SecondProxyServer',AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServer);
    setText('SecondProxyServerPort',AllProfile[vagIndex].Relating.X_HW_SecondaryProxyServerPort);
    setText('HomeDomain',AllProfile[vagIndex].Relating.RegistrarServer);
    setText('UserAgentPort',AllProfile[vagIndex].Relating.UserAgentPort);
    setText('DigitMap',AllProfile[vagIndex].DigitMap);
    setSelect('Region', AllProfile[vagIndex].Region);
    setSelect('X_HW_DigitMapMatchMode', AllProfile[vagIndex].X_HW_DigitMapMatchMode);
    
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
    setSelect('X_HW_PortName', wanSigValue);
    
    setText('RegistrationPeriod', AllProfile[vagIndex].Relating.RegistrationPeriod);
    
    
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
    setSelect('X_HW_PortName_RTP', wanRtpValue);

    
}

function ChangeVAGTable(allvagnum, vagIndex)
{
	for(index = 0; index < allvagnum; index++)
	{
		var optid = 'linelist'+index+'_tbl';

		if(vagIndex == index)
		{
			setDisplay(optid, 1);
		}
		else
		{
			setDisplay(optid, 0);
		}
	}
}

function LoadFrame()
{
    init();
	var j = 0;
	
	ChangeVAGTable(maxvagnum, vagIndex);
    
    if (LineList[vagIndex].length > 0)
    {
	    selectLine('record_0'); 
		
		for (j=0; j<maxvagnum; j++)
		{
			if (vagIndex == j)
			{
				var oid = 'linelist' + j + '_record_0';
				selectLine(oid);  
			}
		}
				
        setDisplay('ConfigForm1', 1);
    }    
    else
    {    
		
		selectLine('record_no');  

		for (j=0; j<maxvagnum; j++)
		{
			if (vagIndex == j)
			{
				var oid = 'linelist' + j + '_record_no';
				selectLine(oid);
			}
		}		
		    
        setDisplay('ConfigForm1', 0);
    }
    
    if (MngtShct == 1)
    {   
        setDisplay('ConfigForm2', 0);
    }
    else
    {
        setDisplay('ConfigForm2', 1);
    }
    
    if(1 == TelMexMode)
    {
        setDisplay('voipbasic', 0);
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
    var Homedomain = "";
    var Number = "";
    var URI = ""
    var spaceInfo = "";
    var inLen = 0;
    
    Firstoutbound = getValue('OutboundProxy');
    inLen =  Firstoutbound.length;
    if( inLen != 0)
    {
        if(  ( Firstoutbound.charAt(0) == ' ' ) || (Firstoutbound.charAt(inLen -1) == ' ') )
        {
            spaceInfo = sipinterface['vspa_theoutproxy'];
        }
    }
    
    Secoutbound = getValue('SecondaryOutboundProxy');
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
    
    FirstProxy = getValue('ProxyServer');
    inLen =  FirstProxy.length;
    if( inLen != 0)
    {
        if(  ( FirstProxy.charAt(0) == ' ' ) || (FirstProxy.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_thepriproxy'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_thepriproxy'];
            }
        }
    }

    SecProxy = getValue('SecondProxyServer');
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
    
    Homedomain = getValue('HomeDomain');
    inLen =  Homedomain.length;
    if( inLen != 0)
    {
        if(  ( Homedomain.charAt(0) == ' ' ) || (Homedomain.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_thehomedomain'];
            }
            else
            {
                spaceInfo =  sipinterface['vspa_thehomedomain'];
            }
        }
    }
    
    URI = getValue('URI');
    inLen =  URI.length;
    if( inLen != 0)
    {
        if(  ( URI.charAt(0) == ' ' ) || (URI.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_useruri'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_useruri'];
            }
        }
    }
    
    Number = getValue('DirectoryNumber');
    inLen =  Number.length;
    if( inLen != 0)
    {
        if(  ( Number.charAt(0) == ' ' ) || (Number.charAt(inLen -1) == ' ') )
        {
            if(("" != spaceInfo))
            {
                spaceInfo =spaceInfo + "," + sipinterface['vspa_regusername'];
            }
            else
            {
                spaceInfo = sipinterface['vspa_regusername'];
            }
        }
    }
        
    return spaceInfo;
}

function CheckForm1()
{   
	
    var spaceInfo = ""; 

    if (curLanguage == "chinese")
    {
        spaceInfo = CheckSpace();
    
        if("" != spaceInfo)
        {
            AlertEx(sipinterface['vspa_alertStart'] + spaceInfo + sipinterface['vspa_alertEnd']);
            return false;
        }
    }

	if ( '' == getValue('UserAgentPort'))
	{
		AlertEx(sipinterface['vspa_siploporthint']);
		return false;
	}
	else
	{
		if (isValidVoipPort(getValue('UserAgentPort')) == false)
		{
			AlertEx(sipinterface['vspa_siploport'] +  getValue('UserAgentPort') + sipinterface['vspa_isvalid']);
			return false;
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
    if(DirectoryNumber != null)
    {
        this.DirectoryNumber = DirectoryNumber.toString().replace(/&apos;/g,"\'"); 
        
    }
    else
    {
      this.DirectoryNumber = DirectoryNumber;
    }
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
    recordDirectoryNumber = getElement("DirectoryNumber").value;
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
    var strvar = getValue('AuthPassword');
    
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
   
    
	if(0 == TelMexMode)
	{
		Form.addParameter('y.UserAgentPort',parseInt(getValue('UserAgentPort'),10)); 
    }
    Form.addParameter('Add_b.DirectoryNumber',getValue('DirectoryNumber'));
    Form.addParameter('Add_b.PhyReferenceList',getValue('PhyReferenceList'));
    Form.addParameter('c.AuthUserName',getValue('AuthUserName'));
    
    if (strvar != '****************************************************************')
    {
        Form.addParameter('c.AuthPassword',getValue('AuthPassword'));   
    }

    Form.addParameter('c.URI',getValue('URI'));
  
    if (getCheckVal('Enable') == 1)
    {
        Form.addParameter('Add_b.Enable','Enabled');
    }
    else
    {
        Form.addParameter('Add_b.Enable','Disabled');
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
     
    if( selctIndex == -1 )
    {
		
        FreeLine= FindFreeLineInst(vagIndex);  
		if(1 == TelMexMode)
		{
			ActionURL = 'set.cgi?'
					+ '&Add_b=' + LineList[vagIndex][selctIndex].Domain
					+ '&c=' + LineList[vagIndex][selctIndex].Domain + '.SIP'
					+ '&RequestFile=html/voip/voipinterface/globevoipinterface.asp';
		}
		else
		{
			ActionURL = 'complex.cgi?'
					+ 'y=' + AllProfile[vagIndex].Domain + '.SIP'
					+ '&x=' +  AllProfile[vagIndex].Domain
					+ '&Add_b=' + AllProfile[vagIndex].Domain + '.Line'
					+ '&c=' + AllProfile[vagIndex].Domain + '.Line.' + FreeLine + '.SIP'
					+ '&RequestFile=html/voip/voipinterface/globevoipinterface.asp';	
		}
    }
    else if( selctIndex == -2 )
    {
		if(0 == TelMexMode)
		{
			ActionURL = 'set.cgi?'
							 + 'y=' + AllProfile[vagIndex].Domain + '.SIP'
							 + '&x=' + AllProfile[vagIndex].Domain
							 + '&RequestFile=html/voip/voipinterface/globevoipinterface.asp';
		}
    }
    else
    {
		if(1 == TelMexMode)
		{
			ActionURL = 'set.cgi?'
					+ '&Add_b=' + LineList[vagIndex][selctIndex].Domain
					+ '&c=' + LineList[vagIndex][selctIndex].Domain + '.SIP'
					+ '&RequestFile=html/voip/voipinterface/globevoipinterface.asp';
		}
		else
		{
			ActionURL = 'set.cgi?'
					+ 'y=' + AllProfile[vagIndex].Domain + '.SIP'
					+ '&x=' +  AllProfile[vagIndex].Domain
					+ '&Add_b=' + LineList[vagIndex][selctIndex].Domain
					+ '&c=' + LineList[vagIndex][selctIndex].Domain + '.SIP'
					+ '&RequestFile=html/voip/voipinterface/globevoipinterface.asp';
		}
    }
    Form.setAction(ActionURL);                               
    setDisable('btnApplySipUser',1);
    setDisable('btnApplyVoipUser',1);
    setDisable('cancelValue',1);
    Form.submit();
	
}

function setCtlDisplay(LineRecord, AuthRecord)
{
    setText('URI',AuthRecord.URI); 
    setText('DirectoryNumber',LineRecord.DirectoryNumber);
    setText('AuthUserName',AuthRecord.AuthUserName);
    setText('AuthPassword',AuthRecord.AuthPassword);
    setSelect('PhyReferenceList', LineRecord.PhyReferenceList);
    setCheck('Enable', LineRecord.Enable);
	
}

function initCtlValue()
{
    setText('URI',''); 
    setText('DirectoryNumber','');
    setText('AuthUserName','');
    setText('AuthPassword','');
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
        document.getElementById("DeleteButton").disabled = false;
        return;
    }
    
	var rml = getElement('linelist' + vagIndex + 'rml');

    var noChooseFlag = true;
	var SubmitForm = new webSubmitForm();

    if ( rml.length > 0)
    {
         for (var i = 0; i < rml.length; i++)
         {
             if (rml[i].checked == true)
             { 
                 noChooseFlag = false;
				 SubmitForm.addParameter(rml[i].value,'');
             }        
         }
    }
    else if (rml.checked == true)
    {
        noChooseFlag = false;
		SubmitForm.addParameter(rml.value,'');
    }
	
    if ( noChooseFlag )
    {
        AlertEx(sipinterface['vspa_nouserdel']);
        return ;
    }
        
    if (ConfirmEx(sipinterface['vspa_del']) == false)
    {
        document.getElementById("DeleteButton").disabled = false;
        return;
    }
    setDisable('btnApplySipUser',1);
    setDisable('btnApplyVoipUser',1);
    setDisable('cancelValue',1);

	if(!noChooseFlag)
	{
		SubmitForm.setAction('del.cgi?RequestFile=html/voip/voipinterface/globevoipinterface.asp');
		SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
		SubmitForm.submit();
	}  
}  

function CheckParaForm()
{    
     var inSipAuthUserName;
     var inLen = 0;

     if ( '' != removeSpaceTrim(getValue('DirectoryNumber')))
     {
         if (vspaisValidCfgStr(sipinterface['vspa_theregister'],getValue('DirectoryNumber'),64) == false)
         {
             return false;
         }   
     }
     
     if ( '' != removeSpaceTrim(getValue('URI')))
     {
         if (vspaisValidCfgStr(sipinterface['vspa_theuri'],getValue('URI'),64) == false)
         {
             return false;
         }    
     }
     
     if ( '' != removeSpaceTrim(getValue('AuthUserName')))
     {
         if (vspaisValidCfgStr(sipinterface['vspa_theauthname'],getValue('AuthUserName'),64) == false)
         {
             return false;
         }
     }
     
     if ( '' != removeSpaceTrim(getValue('AuthPassword')))
     {        
    
         if (vspaisValidCfgStr(sipinterface['vspa_thepassword'],getValue('AuthPassword'),64) == false)
         {
             return false;
         }
     }                     
      
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

     inSipAuthUserName = getValue('AuthUserName');
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

function CancelUserConfig(selctIndex)
{
    LoadFrame();
    selectLine('record_'+selctIndex);
}

function DropDownListSelect(id, ArrayOption)
{
 	var Control = getElById(id);
    var i = 1;  

	var Option = document.createElement("Option");
        Option.value = "";
        Option.innerText = "";
		Option.text = "";
        Control.appendChild(Option);
		
	
	var Option = document.createElement("Option");
        Option.value = "br0";
        Option.innerText = "br0";
		Option.text = "br0";
        Control.appendChild(Option);
	
    for (i = 0; i <  ArrayOption.length; i++)
	{
	    var Option = document.createElement("Option");
        Option.value = domainTowanname(WanInfo[i].domain);
        Option.innerText = MakeWanName(WanInfo[i]);
		Option.text = MakeWanName(WanInfo[i]);
        Control.appendChild(Option);
	}
}


function DropDownLineListSelect(id, ArrayOption)
{
    var Control = getElById(id);
    var i = 1;  
	
	var Option = document.createElement("Option");
        Option.value = "";
        Option.innerText = "";
		Option.text = "";
        Control.appendChild(Option);

    for (i = 1; i <  ArrayOption.length; i++)
    {
        var Option = document.createElement("Option");
        Option.value = i;
        Option.innerText = i;
		Option.text = i;
        Control.appendChild(Option);
    }
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
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipInterface", GetDescFormArrayById(sipinterface, "v01"), GetDescFormArrayById(sipinterface, "v02"), false);
</script>

<div class="title_spread"></div>

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



<form id="voipbasic">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_basic'></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg"> 
<li id="UserAgentPort" RealType="TextBox" DescRef="vspa_loport" RemarkRef="vspa_localporthint" ErrorMsgRef="Empty" Require="TRUE" BindField="UserAgentPort" InitValue="Empty" MaxLength="11"/>
<script>
var VoipConfigFormList1 = HWGetLiIdListByForm("voipbasic", null);
HWParsePageControlByID("voipbasic", TableClass, sipinterface, null);
var VoipBasicParaSetArray = new Array();
HWSetTableByLiIdList(VoipConfigFormList1, VoipBasicParaSetArray, null);
</script>
</table>
</form>


<div class="func_spread"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="func_title">
  <tr> 
    <td BindText='vspa_userbaspara'></td>
  </tr>
</table>

<script language="JavaScript" type="text/javascript">
initCtlValue();
var i = 0;
var ShowableFlag = 1;
var ShowButtonFlag = 1;
if(1 == TelMexMode)
{
	ShowButtonFlag = 0;
}
var ColumnNum = 7;
var ConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox",false),
							new stTableTileInfo("vspa_seq","align_center","index",false),
							new stTableTileInfo("vspa_useruri","wordclass align_center","URI",false),
							new stTableTileInfo("vspa_regusername","wordclass align_center","TelNo",false),
							new stTableTileInfo("vspa_authusername","wordclass align_center","AuthUserName",false),
							new stTableTileInfo("vspa_password","align_center","Password",false),
							new stTableTileInfo("vspa_assopot","align_center","PhyReferenceList",false),null);

function GetVAGPara(vagInsId)
{

	var VoipArray = new Array();
	
	if(LineList[vagInsId].length == 0)
	{
		var VoipShowTab = new ShowTab();
		VoipShowTab.index = "--";
		VoipShowTab.URI = "--";
		VoipShowTab.TelNo = "--";
		VoipShowTab.AuthUserName = "--";
		VoipShowTab.Password = "--";
		VoipShowTab.PhyReferenceList = "--";
	}
	else
	{
		
		for (var i = 0; i < LineList[vagInsId].length; i++)
		{	
			var VoipShowTab = new ShowTab();
			
			VoipShowTab.domain = LineList[vagInsId][i].Domain;
			
			VoipShowTab.index = i+1;
			
			if (AuthList[vagInsId][i].URI == "")
			{
				VoipShowTab.URI = "--";
			}
			else
			{
				VoipShowTab.URI = AuthList[vagInsId][i].URI;
			}
			
			if (LineList[vagInsId][i].DirectoryNumber == "")
			{
				VoipShowTab.TelNo = "--";
			}
			else
			{
				VoipShowTab.TelNo = LineList[vagInsId][i].DirectoryNumber;
			}
			if (AuthList[vagInsId][i].AuthUserName == "")
			{
				VoipShowTab.AuthUserName = "--";
			}
			else
			{
				VoipShowTab.AuthUserName = AuthList[vagInsId][i].AuthUserName;
			} 
			
			VoipShowTab.Password = "*******";                 
			if (LineList[vagInsId][i].PhyReferenceList == "")
			{
				VoipShowTab.PhyReferenceList = "--";
			}
			else
			{
				VoipShowTab.PhyReferenceList = LineList[vagInsId][i].PhyReferenceList;
			}
			VoipArray.push(VoipShowTab);
		}
	}
	
	VoipArray.push(null);
	return VoipArray;
}

for(var index = 0 ; index < maxvagnum; index++)
{
	var tableid = "linelist"+index;
	VoipArray = GetVAGPara(index);
	HWShowTableListByType(ShowableFlag, tableid, ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, sipinterface, null);
}


function linelist0selectRemoveCnt()
{
}

function linelist1selectRemoveCnt()
{
}

</script>

<form id="ConfigForm1">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="Enable" RealType="CheckBox" DescRef="vspa_enableuser" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Enable" InitValue="Empty"/>
<li id="URI" RealType="TextBox" DescRef="vspa_uri1" RemarkRef="vspa_uri2" ErrorMsgRef="Empty" Require="FALSE" BindField="URI" InitValue="Empty" Elementclass="lineclass"/>
<li id="DirectoryNumber" RealType="TextBox" DescRef="vspa_regname" RemarkRef="vspa_telno" ErrorMsgRef="Empty" Require="FALSE" BindField="DirectoryNumber" InitValue="Empty" Elementclass="lineclass"/>
<li id="PhyReferenceList" RealType="DropDownList" DescRef="vspa_asspot" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PhyReferenceList" InitValue="Empty"/>
<li id="AuthUserName" RealType="TextBox" DescRef="vspa_authname" RemarkRef="vspa_authnamehint" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthUserName" InitValue="Empty" Elementclass="lineclass"/>
<li id="AuthPassword" RealType="TextBox" DescRef="vspa_paasw" RemarkRef="vspa_passwdhint" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthPassword" InitValue="Empty" Elementclass="lineclass"/>
<script>
var VoipConfigFormList2 = HWGetLiIdListByForm("ConfigForm1", null);
HWParsePageControlByID("ConfigForm1", TableClass, sipinterface, null);
DropDownLineListSelect("PhyReferenceList",AllPhyInterface);
</script>
</table>
</form>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
<tr >
<td class="table_submit width_per25"></td>
<td class="table_submit"> 
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<input name="btnApplyVoipUser" id="btnApplyVoipUser" type="button" class="ApplyButtoncss buttonwidth_100px" value="Apply" onClick="SubmitBasicPara();"/>
<script type="text/javascript">
document.getElementsByName('btnApplyVoipUser')[0].value = sipinterface['vspa_apply'];    
</script>
<input name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" value="Cancel" onClick="CancelUserConfig(selctIndex);"/>
<script>
document.getElementsByName('cancelValue')[0].value = sipinterface['vspa_cancel'];
</script>

</td>
</tr>
</table>
<br></br>

</body>
</html>
