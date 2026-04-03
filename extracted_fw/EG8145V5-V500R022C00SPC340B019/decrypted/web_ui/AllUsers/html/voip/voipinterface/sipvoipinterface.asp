<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipinterface);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>VOIP Interface</title>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="javascript" src="../../bbsp/common/wandns.asp"></script>
<script language="javascript" src="../common/voip_disableallelement.asp"></script>
<style>
.interfacetextclass{
    width:300px;
    height:50px;
    color:black;
}
.interfacetextrosgameclass{
    width:300px;
    height:50px;
    color:white;
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

<script language="JavaScript" type="text/javascript"> 

var PortNum = '<%HW_WEB_GetPortNum();%>';
var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var rosUnionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

var selctIndex = -1;
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var TurksAT = 0;
if (CfgMode.toUpperCase() == 'TURKSATEBG2') {
    TurksAT = 1;
}
var TelMexMode = 0;
if((CfgMode.toUpperCase() == 'TELMEX') || ('TELMEX5G' == CfgMode.toUpperCase()))
{
    TelMexMode = 1;
}

var SingTelMode = 0;
if((CfgMode.toUpperCase() == 'SINGTEL') || (CfgMode.toUpperCase() == 'SINGTEL2'))
{
    SingTelMode = 1;
}

var BhartiMode = 0;
if(CfgMode.toUpperCase() == 'BHARTI')
{
    BhartiMode = 1;
}

var brazclaroMode = 0;
if (CfgMode.toUpperCase() == 'BRAZCLARO') {
    brazclaroMode = 1;
}

var RussianMode = 0;
if (CfgMode.toUpperCase() == 'ROSUNION')
{
    RussianMode = 1;
}

var DethMaxis = 0;
if (CfgMode.toUpperCase() == 'DETHMAXIS') {
    DethMaxis = 1;
}

var IcelandVdf = 0;
if (CfgMode.toUpperCase() == 'DICELANDVDF') {
    IcelandVdf = 1;
}

var OteMode = 0;
if (CfgMode.toUpperCase() == 'OTE') {
    OteMode = 1;
}

var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var CUVoiceFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_UNICOM_DIS_VOICE);%>";
var curLanguage='<%HW_WEB_GetCurrentLanguage();%>';

var vagIndex = 0;
var outProxyServerPort= '';
var secOutProxyServerPort= '';
var primaryProxyServerPort= '';
var secPrimaryProxyServerPort= '';
var localPort = '';
var digitMapValue = '';
var digitMapMatchMode = '';
var registrationPeriod = '';
var signalingPort = '';
var meidaPort = '';
var regionselect = '';
var outboundProxy = '';
var secOutboundProxy = '';
var proxyServer = '';
var registrarServer = '';
var userAgentDomain = '';
var homeDomain = '';
var secondProxyServer = '';

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

function stSIPServer(Domain, ProxyServer, ProxyServerPort, OutboundProxy, OutboundProxyPort, X_HW_SecondaryOutboundProxy, X_HW_SecondaryOutboundProxyPort, X_HW_SecondaryProxyServer, X_HW_SecondaryProxyServerPort, RegistrarServer, UserAgentDomain, UserAgentPort, RegistrationPeriod, RegisterRetryInterval)
{
    this.Domain = Domain;                           
    this.OutboundProxy = OutboundProxy;
    this.OutboundProxyPort = OutboundProxyPort;
    this.X_HW_SecondaryOutboundProxy = X_HW_SecondaryOutboundProxy;
    this.X_HW_SecondaryOutboundProxyPort = X_HW_SecondaryOutboundProxyPort;
    
    this.ProxyServer = ProxyServer;
    this.ProxyServerPort = ProxyServerPort;
    this.RegistrationPeriod = RegistrationPeriod;
    this.RegisterRetryInterval = RegisterRetryInterval;
    this.X_HW_SecondaryProxyServer = X_HW_SecondaryProxyServer;
    this.UserAgentPort = UserAgentPort;
    this.RegistrarServer = RegistrarServer;
    this.UserAgentDomain = UserAgentDomain;
    this.ProxyServerPort = ProxyServerPort;
    this.X_HW_SecondaryProxyServerPort = X_HW_SecondaryProxyServerPort;
    this.OutboundProxyPort = OutboundProxyPort;
    this.X_HW_SecondaryOutboundProxyPort = X_HW_SecondaryOutboundProxyPort; 
    var temp = Domain.split('.');
    this.key = '.' + temp[5] + '.';
}
var ProductType = '<%HW_WEB_GetProductType();%>';
var AllSIPServer = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP,ProxyServer|ProxyServerPort|OutboundProxy|OutboundProxyPort|X_HW_SecondaryOutboundProxy|X_HW_SecondaryOutboundProxyPort|X_HW_SecondaryProxyServer|X_HW_SecondaryProxyServerPort|RegistrarServer|UserAgentDomain|UserAgentPort|RegistrationPeriod|RegisterRetryInterval,stSIPServer);%>;
AssociateParam(AllProfile, AllSIPServer,'ProxyServer|ProxyServerPort|OutboundProxy|OutboundProxyPort|X_HW_SecondaryOutboundProxy|X_HW_SecondaryOutboundProxyPort|X_HW_SecondaryProxyServer|X_HW_SecondaryProxyServerPort|RegistrarServer|UserAgentDomain|UserAgentPort|RegistrationPeriod|RegisterRetryInterval');

function ValidVoipWan(wan)
{
    return ((true == wan.Enable) && (wan.ServiceList.toUpperCase().indexOf("VOIP") >= 0));
}

var WanInfo = GetWanListByFilter(ValidVoipWan);

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
    
       document.getElementById('DigitMap').title = dmm;

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
    if(RussianMode == 1)
    {
        setText('RegistrarServer', AllProfile[vagIndex].Relating.RegistrarServer);
        setText('UserAgentDomain', AllProfile[vagIndex].Relating.UserAgentDomain);
        setText('RegisterRetryInterval', AllProfile[vagIndex].Relating.RegisterRetryInterval);
    }
    else
    {
        setText('HomeDomain', AllProfile[vagIndex].Relating.RegistrarServer);
    }

    if (OteMode == 1) {
        setText('UserAgentDomain', AllProfile[vagIndex].Relating.UserAgentDomain);
    }

    setText('UserAgentPort', AllProfile[vagIndex].Relating.UserAgentPort);
    setText('DigitMap', AllProfile[vagIndex].DigitMap);
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
    if(1 == SingTelMode)
    {
        setDisplay('X_HW_PortNameRow', 0);
        setDisplay('X_HW_PortName_RTPRow', 0);
    }
    
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
          
    if(1 == BhartiMode)
    {
        DisableAllElement();
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
        $("textarea").attr("disabled",true);
    }

    if (TurksAT == 1) {
        setDisable('Region', 1);
    }
    if ((DethMaxis == 1) && (curLoginUserType == 1)) {
        setDisable('OutboundProxyPort', 1);
        outProxyServerPort = getValue('OutboundProxyPort');

        setDisable('SecondaryOutboundProxyPort', 1);
        secOutProxyServerPort = getValue('SecondaryOutboundProxyPort');

        setDisable('ProxyServerPort', 1);
        primaryProxyServerPort =getValue('ProxyServerPort');

        setDisable('SecondProxyServerPort', 1);
        secPrimaryProxyServerPort = getValue('SecondProxyServerPort');

        setDisable('UserAgentPort', 1);
        localPort = getValue('UserAgentPort');

        setDisable('DigitMap', 1);
        digitMapValue = getValue('DigitMap');

        setDisable('X_HW_DigitMapMatchMode', 1);
        digitMapMatchMode = getValue('X_HW_DigitMapMatchMode');

        setDisable('RegistrationPeriod', 1);
        registrationPeriod = getValue('RegistrationPeriod');

        setDisable('X_HW_PortName', 1);
        signalingPort = getValue('X_HW_PortName');

        setDisable('X_HW_PortName_RTP', 1);
        meidaPort = getValue('X_HW_PortName_RTP');

        setDisable('Region', 1);
        regionselect = getValue('Region');
    }

    if ((IcelandVdf == 1) && (curLoginUserType == 1)) {
        setDisable('OutboundProxy', 1);
        outboundProxy = getValue('OutboundProxy');

        setDisable('SecondaryOutboundProxy', 1);
        secOutboundProxy = getValue('SecondaryOutboundProxy');

        setDisable('OutboundProxyPort', 1);
        outProxyServerPort = getValue('OutboundProxyPort');

        setDisable('SecondaryOutboundProxyPort', 1);
        secOutProxyServerPort = getValue('SecondaryOutboundProxyPort');

        setDisable('ProxyServer', 1);
        proxyServer = getValue('ProxyServer');

        setDisable('ProxyServerPort', 1);
        primaryProxyServerPort =getValue('ProxyServerPort');

        setDisable('SecondProxyServer', 1);
        secondProxyServer =getValue('SecondProxyServer');

        setDisable('SecondProxyServerPort', 1);
        secPrimaryProxyServerPort = getValue('SecondProxyServerPort');

        setDisable('HomeDomain', 1);
        homeDomain = getValue('HomeDomain');

        setDisable('UserAgentPort', 1);
        localPort = getValue('UserAgentPort');

        setDisable('DigitMap', 1);
        digitMapValue = getValue('DigitMap');

        setDisable('X_HW_DigitMapMatchMode', 1);
        digitMapMatchMode = getValue('X_HW_DigitMapMatchMode');

        setDisable('RegistrationPeriod', 1);
        registrationPeriod = getValue('RegistrationPeriod');

        setDisable('X_HW_PortName', 1);
        signalingPort = getValue('X_HW_PortName');

        setDisable('X_HW_PortName_RTP', 1);
        meidaPort = getValue('X_HW_PortName_RTP');

        setDisable('Region', 1);
        regionselect = getValue('Region');
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
    var UserAgentDomain = "";
    var RegistrarServer = "";
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
    
    if (RussianMode == 1)
    {
        RegistrarServer = getValue('RegistrarServer');
        inLen =  RegistrarServer.length;
        if(inLen != 0)
        {
            if((RegistrarServer.charAt(0) == ' ') || (RegistrarServer.charAt(inLen -1) == ' '))
            {
                if(spaceInfo != "")
                {
                    spaceInfo =spaceInfo + "," + sipinterface['vspa_regisserver'];
                }
                else
                {
                    spaceInfo = sipinterface['vspa_regisserver'];
                }
            }
        }

        UserAgentDomain = getValue('UserAgentDomain');
        inLen =  UserAgentDomain.length;
        if(inLen != 0)
        {
            if((UserAgentDomain.charAt(0) == ' ') || (UserAgentDomain.charAt(inLen -1) == ' '))
            {
                if(spaceInfo != "")
                {
                    spaceInfo =spaceInfo + "," + sipinterface['vspa_uadomain'];
                }
                else
                {
                    spaceInfo =  sipinterface['vspa_uadomain'];
                }
            }
        }
    }
    else
    {
        Homedomain = getValue('HomeDomain');
        inLen =  Homedomain.length;
        if( inLen != 0)
        {
            if((Homedomain.charAt(0) == ' ') || (Homedomain.charAt(inLen -1) == ' '))
            {
                if(spaceInfo != "")
                {
                    spaceInfo =spaceInfo + "," + sipinterface['vspa_thehomedomain'];
                }
                else
                {
                    spaceInfo =  sipinterface['vspa_thehomedomain'];
                }
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
    
    if ( '' != removeSpaceTrim(getValue('OutboundProxy')))
    {
        if ( true == isIpAddress(getValue('OutboundProxy')) )
        {
            if (false == isvalidVoipIpAddress(getValue('OutboundProxy')))
            {
                AlertEx(sipinterface['vspa_outproxyaddvalid']);
                return false;
            }
        }
        else
        {           
            if ( false == vspaisValidCfgStr(sipinterface['vspa_theoutproxy'], getValue('OutboundProxy'),257) )
            {                  
                return false;       
            }
        }
    }        
    if ( '' != removeSpaceTrim(getValue('OutboundProxyPort')))
    {
        if ( isValidVoipPort(getValue('OutboundProxyPort')) == false )
        {
            AlertEx(sipinterface['vspa_theoutport'] +  getValue('OutboundProxyPort') + sipinterface['vspa_isvalid']);
            return false;
        }        
    } 
    if ( '' != removeSpaceTrim(getValue('SecondaryOutboundProxy')))
    {
        if ( true == isIpAddress(getValue('SecondaryOutboundProxy')) )
        {
            if (false == isvalidVoipIpAddress(getValue('SecondaryOutboundProxy')))
            {
                AlertEx(sipinterface['vspa_secproxyaddvalid']);
                return false;
            }
        }
        else
        {           
            if ( false == vspaisValidCfgStr(sipinterface['vspa_thesecproxy'], getValue('SecondaryOutboundProxy'),257) )
            {                  
                return false;       
            }
        }
    }        
    if ( '' != removeSpaceTrim(getValue('SecondaryOutboundProxyPort')))
    {
        if ( isValidVoipPort(getValue('SecondaryOutboundProxyPort')) == false )
        {
            AlertEx(sipinterface['vspa_thesecporxy'] +  getValue('SecondaryOutboundProxyPort') + sipinterface['vspa_isvalid']);
            return false;
        }        
    } 
    
    if ( '' != removeSpaceTrim(getValue('ProxyServer')))
    {
        if ( true == isIpAddress(getValue('ProxyServer')) )
        {
            if (false == isvalidVoipIpAddress(getValue('ProxyServer')))
            {
                AlertEx(sipinterface['vspa_priproxyaddva']);
                return false;
            }
        }
        else
        {           
            if ( false == vspaisValidCfgStr(sipinterface['vspa_thepriproxy'], getValue('ProxyServer'),257) )
            {                  
                return false;       
            }
        }
    }        
    
    if ( '' != removeSpaceTrim(getValue('ProxyServerPort')))
    {
        if ( isValidVoipPort(getValue('ProxyServerPort')) == false )
        {
            AlertEx(sipinterface['vspa_thepri'] +  getValue('ProxyServerPort') + sipinterface['vspa_isvalid']);
            return false;
        }        
    } 
    
    if ( '' != removeSpaceTrim(getValue('SecondProxyServer')))
    {
        if ( true == isIpAddress(getValue('SecondProxyServer')) )
        {
            if ( false == isvalidVoipIpAddress(getValue('SecondProxyServer')) )
            {
                AlertEx(sipinterface['vspa_stproxyaddvalid']);
                return false;
            }
        }
        else
        {
            if ( false == vspaisValidCfgStr(sipinterface['vspa_standbyproxy'],getValue('SecondProxyServer'),257) )
            {
                return false;
            }
                    
        }
    }
    
    if ( '' != removeSpaceTrim(getValue('SecondProxyServerPort')) )
    {
        if ( isValidVoipPort(getValue('SecondProxyServerPort')) == false )
        {
            AlertEx(sipinterface['vspa_thestport'] +  getValue('SecondProxyServerPort') + sipinterface['vspa_isvalid']);
            return false;
        }
    }

    if (RussianMode == 1)
	{
        if (removeSpaceTrim(getValue('RegistrarServer')) != '')
        {
            if (isIpAddress(getValue('RegistrarServer')) == true)
            {
                if (isvalidVoipIpAddress(getValue('RegistrarServer')) == false)
                {
                    AlertEx(sipinterface['vspa_registrarservervalid']);
                    return false;
                }
            }
            else
            {        
                if (vspaisValidCfgStr(sipinterface['vspa_regisserver'], getValue('RegistrarServer'), 65) == false)
                {
                    AlertEx(sipinterface['vspa_registrarservervalid']);
                    return false;
                }
            }
        }
        if (removeSpaceTrim(getValue('UserAgentDomain')) != '')
        {
            if (isIpAddress(getValue('UserAgentDomain')) == true)
            {
                if (isvalidVoipIpAddress(getValue('UserAgentDomain')) == false)
                {
                    AlertEx(sipinterface['vspa_uadomainvalid']);
                    return false;
                }
            }
            else
            {        
                if (vspaisValidCfgStr(sipinterface['vspa_uadomain'], getValue('UserAgentDomain'), 257) == false)
                {
                    AlertEx(sipinterface['vspa_uadomainvalid']);
                    return false;
                }
            }
        }
        if (isInteger(getValue('RegisterRetryInterval')) == false)
        {
            AlertEx(sipinterface['vspa_regretryintervalvalid']);
            return false;
        }

        if ((getValue('RegisterRetryInterval') > 65534) || (getValue('RegisterRetryInterval') < 1))
        {
            AlertEx(sipinterface['vspa_regretryintervalvalid']);
            return false;
        }
    }
    else
    {
        if (removeSpaceTrim(getValue('HomeDomain')) != '')
        {
            if (isIpAddress(getValue('HomeDomain')) == true)
            {
                if (isvalidVoipIpAddress(getValue('HomeDomain')) == false)
                {
                    AlertEx(sipinterface['vspa_domainvalid']);
                    return false;
                }
            }
            else
            {        
                if (vspaisValidCfgStr(sipinterface['vspa_thehomedomain'], getValue('HomeDomain'), 257) == false)
                {
                    AlertEx(sipinterface['vspa_domainvalid']);
                    return false;
                }
            }
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
    
    if (getValue('DigitMap').length > 8000)
    {
        AlertEx(sipinterface['vspa_digmaplength']);
        return false;
    }
    
    if (isSafeStringIn(getValue('DigitMap'), 'ABCDEFXabcdefxT0123456789-{}[]()*#,.Tt|LlSsZz') == false)
    {
        AlertEx(sipinterface['vspa_digmapvalid']);
        return false;
    }
    if ( false == isInteger(getValue('RegistrationPeriod')) )
    {
        AlertEx(sipinterface['vspa_regpervalid']);
        return false;
    }
        
    if ((getValue('RegistrationPeriod') > 65534) || (getValue('RegistrationPeriod') < 1))
    {
        AlertEx(sipinterface['vspa_regpervalid']);
        return false;
    }
    if ((getValue('RegistrationPeriod') != AllProfile[vagIndex].Relating.RegistrationPeriod) && (getValue('RegistrationPeriod') <= 90))
    {
        if(!ConfirmEx(sipinterface['vspa_regperiodshort']))
        {
            return false;
        }
        
    }
    if ((DethMaxis == 1) && (curLoginUserType == 1)) {
        if (outProxyServerPort != getValue('OutboundProxyPort') ||
            secOutProxyServerPort != getValue('SecondaryOutboundProxyPort') ||
            primaryProxyServerPort != getValue('ProxyServerPort') ||
            secPrimaryProxyServerPort != getValue('SecondProxyServerPort') ||
            localPort != getValue('UserAgentPort') ||
            digitMapValue != getValue('DigitMap') ||
            digitMapMatchMode != getValue('X_HW_DigitMapMatchMode') ||
            registrationPeriod != getValue('RegistrationPeriod') ||
            signalingPort != getValue('X_HW_PortName') ||
            meidaPort != getValue('X_HW_PortName_RTP') ||
            regionselect != getValue('Region')) {
            AlertEx('Error!');
            return false;
        }
    }

    if ((IcelandVdf == 1) && (curLoginUserType == 1)) {
        if (outProxyServerPort != getValue('OutboundProxyPort') ||
            outboundProxy != getValue('OutboundProxy') ||
            secOutboundProxy != getValue('SecondaryOutboundProxy') ||
            proxyServer != getValue('ProxyServer') ||
            secondProxyServer != getValue('SecondProxyServer') ||
            secOutProxyServerPort != getValue('SecondaryOutboundProxyPort') ||
            primaryProxyServerPort != getValue('ProxyServerPort') ||
            secPrimaryProxyServerPort != getValue('SecondProxyServerPort') ||
            localPort != getValue('UserAgentPort') ||
            homeDomain != getValue('HomeDomain') ||
            digitMapValue != getValue('DigitMap') ||
            digitMapMatchMode != getValue('X_HW_DigitMapMatchMode') ||
            registrationPeriod != getValue('RegistrationPeriod') ||
            signalingPort != getValue('X_HW_PortName') ||
            meidaPort != getValue('X_HW_PortName_RTP') ||
            regionselect != getValue('Region')) {
            AlertEx('Error!');
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

function SipExtend(Domain, SharedUserMode)
{
    this.Domain = Domain;
    this.SharedUserMode = SharedUserMode;
}
var sipExt = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.SIP.X_HW_SIPExtend, SharedUserMode, SipExtend);%>;
var ringParallelFt = '<%HW_WEB_GetFeatureSupport(FT_VOIP_EXTEND_RING_PARALLEL);%>';
var ringPrlflag = (OteMode == 1) && (sipExt[vagIndex].SharedUserMode == 'RingParallel') && ringParallelFt;

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

function GetAssociatedPhyList()
{
    var list = "";
    for (var i = 1; i <= 2; ++i) {
        if (getCheckVal("PhyReferenceList" + i) == 1) {
            list += i + ",";
        }
    }

    if (list.length > 0) {
        list = list.substr(0, list.length - 1);
    }

    return list;
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
    
    if(removeSpaceTrim(getValue('SecondProxyServerPort').toString()) == "")
    {
        sndProServerPort = 0;
    }
    else
    {
        sndProServerPort = parseInt(getValue('SecondProxyServerPort'),10);
    } 
    
    
    if(removeSpaceTrim(getValue('ProxyServerPort').toString()) == "")
    {
        ProServerPort = 0;
    }
    else
    {
        ProServerPort = parseInt(getValue('ProxyServerPort'),10);
    }
    
    if(removeSpaceTrim(getValue('OutboundProxyPort').toString()) == "")
    {
        OutboundServerPort = 0;
    }
    else
    {
        OutboundServerPort = parseInt(getValue('OutboundProxyPort'),10);
    }
    if(removeSpaceTrim(getValue('SecondaryOutboundProxyPort').toString()) == "")
    {
        sndOutboundServerPort = 0;
    }
    else
    {
        sndOutboundServerPort = parseInt(getValue('SecondaryOutboundProxyPort'),10);
    }  
	
	if(CheckUserRepeat())
	{
	    return false;
	}
    
    if(0 == TelMexMode)
    {
        var addOutbound = getValue('OutboundProxy');
        var addSecondOutbound = getValue('SecondaryOutboundProxy');
        if(addOutbound != AllProfile[vagIndex].Relating.OutboundProxy)
        {
            Form.addParameter('y.OutboundProxy',getValue('OutboundProxy'));
        }
        Form.addParameter('y.OutboundProxyPort',parseInt(OutboundServerPort));
        if(addSecondOutbound != AllProfile[vagIndex].Relating.X_HW_SecondaryOutboundProxy)
        {
            Form.addParameter('y.X_HW_SecondaryOutboundProxy',getValue('SecondaryOutboundProxy'));
        }
        Form.addParameter('y.X_HW_SecondaryOutboundProxyPort',parseInt(sndOutboundServerPort));
        Form.addParameter('x.Region',getValue('Region'));
        Form.addParameter('z.DigitMap',getValue('DigitMap'));
        Form.addParameter('x.X_HW_DigitMapMatchMode',getValue('X_HW_DigitMapMatchMode'));    
        Form.addParameter('y.ProxyServer',getValue('ProxyServer'));
        Form.addParameter('y.ProxyServerPort',parseInt(ProServerPort));
        Form.addParameter('y.RegistrationPeriod',parseInt(getValue('RegistrationPeriod'),10));
        Form.addParameter('y.X_HW_SecondaryProxyServerPort',parseInt(sndProServerPort));
        Form.addParameter('y.UserAgentPort',parseInt(getValue('UserAgentPort'),10)); 
        Form.addParameter('y.X_HW_SecondaryProxyServer',getValue('SecondProxyServer'));

        if (RussianMode == 1)
        {
            Form.addParameter('y.RegistrarServer',getValue('RegistrarServer'));
            Form.addParameter('y.UserAgentDomain',getValue('UserAgentDomain'));
            Form.addParameter('y.RegisterRetryInterval', parseInt(getValue('RegisterRetryInterval'), 10));
        }
        else
        {
            Form.addParameter('y.RegistrarServer',getValue('HomeDomain'));
        }

        if (OteMode == 1) {
            Form.addParameter('y.UserAgentDomain',getValue('UserAgentDomain'));
        }

        if(0 == SingTelMode)
        {
            Form.addParameter('x.X_HW_PortName',getValue('X_HW_PortName'));
            Form.addParameter('a.X_HW_PortName',getValue('X_HW_PortName_RTP'));
        }
    }
    Form.addParameter('Add_b.DirectoryNumber',getValue('DirectoryNumber'));
    if (ringPrlflag) {
        Form.addParameter('Add_b.PhyReferenceList', GetAssociatedPhyList());
    } else {
        Form.addParameter('Add_b.PhyReferenceList', getValue('PhyReferenceList'));
    }

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
                    + '&RequestFile=html/voip/voipinterface/voipinterface.asp';
        }
        else
        {
            ActionURL = 'complex.cgi?'
                    + 'y=' + AllProfile[vagIndex].Domain + '.SIP'
                    + '&z=' + AllProfile[vagIndex].Domain + '.SIP.X_HW_SIPDigitmap.1'
                    + '&x=' +  AllProfile[vagIndex].Domain
                    + '&a=' + AllProfile[vagIndex].Domain + '.RTP'
                    + '&Add_b=' + AllProfile[vagIndex].Domain + '.Line'
                    + '&c=' + AllProfile[vagIndex].Domain + '.Line.' + FreeLine + '.SIP'
                    + '&RequestFile=html/voip/voipinterface/voipinterface.asp';    
        }
    }
    else if( selctIndex == -2 )
    {
        if(0 == TelMexMode)
        {
            ActionURL = 'set.cgi?'
                             + 'y=' + AllProfile[vagIndex].Domain + '.SIP'
                             + '&z=' + AllProfile[vagIndex].Domain + '.SIP.X_HW_SIPDigitmap.1'
                             + '&x=' + AllProfile[vagIndex].Domain
                             + '&a=' + AllProfile[vagIndex].Domain + '.RTP'
                             + '&RequestFile=html/voip/voipinterface/voipinterface.asp';
        }
    }
    else
    {
        if(1 == TelMexMode)
        {
            ActionURL = 'set.cgi?'
                    + '&Add_b=' + LineList[vagIndex][selctIndex].Domain
                    + '&c=' + LineList[vagIndex][selctIndex].Domain + '.SIP'
                    + '&RequestFile=html/voip/voipinterface/voipinterface.asp';
        }
        else
        {
            ActionURL = 'set.cgi?'
                    + 'y=' + AllProfile[vagIndex].Domain + '.SIP'
                    + '&z=' + AllProfile[vagIndex].Domain + '.SIP.X_HW_SIPDigitmap.1'
                    + '&x=' +  AllProfile[vagIndex].Domain
                    + '&a=' + AllProfile[vagIndex].Domain + '.RTP'
                    + '&Add_b=' + LineList[vagIndex][selctIndex].Domain
                    + '&c=' + LineList[vagIndex][selctIndex].Domain + '.SIP'
                    + '&RequestFile=html/voip/voipinterface/voipinterface.asp';
        }
    }
    Form.setAction(ActionURL);                               
    setDisable('btnApplySipUser',1);
    setDisable('btnApplyVoipUser',1);
    setDisable('cancelValue',1);
    Form.submit();
}

function setAssociaPotsList(PhyReferenceList)
{
    getElement('PhyReferenceList1').checked = false;
    getElement('PhyReferenceList2').checked = false;

    var phyBindList = PhyReferenceList.split(",");
    for (var i = 0; i < phyBindList.length; ++i) {
        if (phyBindList[i] == "") {
            return;
        }

        var element = getElement('PhyReferenceList' + phyBindList[i]);
        if (element == null) {
            return;
        }

        element.checked = true;
    }
}

function setCtlDisplay(LineRecord, AuthRecord)
{
    setText('URI',AuthRecord.URI); 
    setText('DirectoryNumber',LineRecord.DirectoryNumber);
    setText('AuthUserName',AuthRecord.AuthUserName);
    setText('AuthPassword',AuthRecord.AuthPassword);
    if (ringPrlflag) {
        setAssociaPotsList(LineRecord.PhyReferenceList);
    } else {
        setSelect('PhyReferenceList', LineRecord.PhyReferenceList);
    }
    setCheck('Enable', LineRecord.Enable);
    
}

function initCtlValue()
{
    setText('URI',''); 
    setText('DirectoryNumber','');
    setText('AuthUserName','');
    setText('AuthPassword','');
    if (ringPrlflag) {
        setCheck('PhyReferenceList1', '');
        setCheck('PhyReferenceList2', '');
    } else {
        setSelect('PhyReferenceList', '');
    }
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
        SubmitForm.setAction('del.cgi?RequestFile=html/voip/voipinterface/voipinterface.asp');
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
    var configUri = getValue('URI');
    var configTelNum = getValue('DirectoryNumber');
	var configUserName = getValue('AuthUserName');

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
		    if(!isEmpty(configTelNum))
			{
			    if(configTelNum == LineList[vagIndex][existIndex].DirectoryNumber && selctIndex != existIndex)
				{
				    AlertEx("configTelNum "+configTelNum+" exist telNum "+ LineList[vagIndex][existIndex].DirectoryNumber+" repeat!");
				    return true;
				}
			}
			if(!isEmpty(configUserName))
			{
			    if(configUserName == AuthList[vagIndex][existIndex].AuthUserName && selctIndex != existIndex)
				{
				    AlertEx("configUserName "+configUserName+" exist UserName "+ AuthList[vagIndex][existIndex].AuthUserName+" repeat!");
				    return true;
				}
			}
			if(!isEmpty(configUri))
			{
			    if(configUri == AuthList[vagIndex][existIndex].URI && selctIndex != existIndex)
				{
				    AlertEx("configUri "+configUri+" exist URI "+ AuthList[vagIndex][existIndex].URI+" repeat!");
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
    
    InitWanNameListControlWanname(id, ValidVoipWan);
}

function RegionSelect(id)
{
    var Control = getElById(id);
    var Option = document.createElement("Option");
    Option.value = "";
    Option.innerText = "";
    Option.text = "";
    Control.appendChild(Option);

    var RegionEn = [
    ["AF",sipinterface['vspa_AF']],
    ["AX",sipinterface['vspa_AX']],
    ["AL",sipinterface['vspa_AL']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AS",sipinterface['vspa_AS']],
    ["AD",sipinterface['vspa_AD']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["AR",sipinterface['vspa_AR']],
    ["AM",sipinterface['vspa_AM']],
    ["AW",sipinterface['vspa_AW']],
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AZ",sipinterface['vspa_AZ']],
    ["BS",sipinterface['vspa_BS']],
    ["BH",sipinterface['vspa_BH']],
    ["BD",sipinterface['vspa_BD']],
    ["BB",sipinterface['vspa_BB']],
    ["BY",sipinterface['vspa_BY']],
    ["BE",sipinterface['vspa_BE']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BM",sipinterface['vspa_BM']],
    ["BT",sipinterface['vspa_BT']],
    ["BO",sipinterface['vspa_BO']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BV",sipinterface['vspa_BV']],
    ["BR",sipinterface['vspa_BR']],
    ["IO",sipinterface['vspa_IO']],
    ["BN",sipinterface['vspa_BN']],
    ["BG",sipinterface['vspa_BG']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["KH",sipinterface['vspa_KH']],
    ["CM",sipinterface['vspa_CM']],
    ["CA",sipinterface['vspa_CA']],
    ["CV",sipinterface['vspa_CV']],
    ["KY",sipinterface['vspa_KY']],
    ["CF",sipinterface['vspa_CF']],
    ["TD",sipinterface['vspa_TD']],
    ["CL",sipinterface['vspa_CL']],
    ["CN",sipinterface['vspa_CN']],
    ["CX",sipinterface['vspa_CX']],
    ["CC",sipinterface['vspa_CC']],
    ["CO",sipinterface['vspa_CO']],
    ["KM",sipinterface['vspa_KM']],
    ["CG",sipinterface['vspa_CG']],
    ["CK",sipinterface['vspa_CK']],
    ["CR",sipinterface['vspa_CR']],
    ["CI",sipinterface['vspa_CI']],
    ["HR",sipinterface['vspa_HR']],
    ["CU",sipinterface['vspa_CU']],
    ["CW",sipinterface['vspa_CW']],
    ["CY",sipinterface['vspa_CY']],
    ["CZ",sipinterface['vspa_CZ']],
    ["KP",sipinterface['vspa_KP']],
    ["DK",sipinterface['vspa_DK']],
    ["DJ",sipinterface['vspa_DJ']],
    ["DM",sipinterface['vspa_DM']],
    ["DO",sipinterface['vspa_DO']],
    ["EC",sipinterface['vspa_EC']],
    ["EG",sipinterface['vspa_EG']],
    ["SV",sipinterface['vspa_SV']],
    ["GQ",sipinterface['vspa_GQ']],
    ["ER",sipinterface['vspa_ER']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["FK",sipinterface['vspa_FK']],
    ["FO",sipinterface['vspa_FO']],
    ["FJ",sipinterface['vspa_FJ']],
    ["FI",sipinterface['vspa_FI']],
    ["FR",sipinterface['vspa_FR']],
    ["GF",sipinterface['vspa_GF']],
    ["PF",sipinterface['vspa_PF']],
    ["TF",sipinterface['vspa_TF']],
    ["GA",sipinterface['vspa_GA']],
    ["GM",sipinterface['vspa_GM']],
    ["GE",sipinterface['vspa_GE']],
    ["DE",sipinterface['vspa_DE']],
    ["GH",sipinterface['vspa_GH']],
    ["GI",sipinterface['vspa_GI']],
    ["GR",sipinterface['vspa_GR']],
    ["GL",sipinterface['vspa_GL']],
    ["GD",sipinterface['vspa_GD']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GT",sipinterface['vspa_GT']],
    ["GG",sipinterface['vspa_GG']],
    ["GN",sipinterface['vspa_GN']],
    ["GW",sipinterface['vspa_GW']],
    ["GY",sipinterface['vspa_GY']],
    ["HT",sipinterface['vspa_HT']],
    ["HM",sipinterface['vspa_HM']],
    ["HN",sipinterface['vspa_HN']],
    ["HK",sipinterface['vspa_HK']],
    ["HU",sipinterface['vspa_HU']],
    ["IS",sipinterface['vspa_IS']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["IR",sipinterface['vspa_IR']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IE",sipinterface['vspa_IE']],
    ["IM",sipinterface['vspa_IM']],
    ["IL",sipinterface['vspa_IL']],
    ["IT",sipinterface['vspa_IT']],
    ["JM",sipinterface['vspa_JM']],
    ["JP",sipinterface['vspa_JP']],
    ["JE",sipinterface['vspa_JE']],
    ["JO",sipinterface['vspa_JO']],
    ["KZ",sipinterface['vspa_KZ']],
    ["KE",sipinterface['vspa_KE']],
    ["KI",sipinterface['vspa_KI']],
    ["KW",sipinterface['vspa_KW']],
    ["KG",sipinterface['vspa_KG']],
    ["LA",sipinterface['vspa_LA']],
    ["LV",sipinterface['vspa_LV']],
    ["LB",sipinterface['vspa_LB']],
    ["LS",sipinterface['vspa_LS']],
    ["LR",sipinterface['vspa_LR']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["LT",sipinterface['vspa_LT']],
    ["LU",sipinterface['vspa_LU']],
    ["MO",sipinterface['vspa_MO']],
    ["MG",sipinterface['vspa_MG']],
    ["MW",sipinterface['vspa_MW']],
    ["MY",sipinterface['vspa_MY']],
    ["MV",sipinterface['vspa_MV']],
    ["ML",sipinterface['vspa_ML']],
    ["MT",sipinterface['vspa_MT']],
    ["MH",sipinterface['vspa_MH']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MR",sipinterface['vspa_MR']],
    ["MU",sipinterface['vspa_MU']],
    ["YT",sipinterface['vspa_YT']],
    ["MX",sipinterface['vspa_MX']],
    ["FM",sipinterface['vspa_FM']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MN",sipinterface['vspa_MN']],
    ["ME",sipinterface['vspa_ME']],
    ["MS",sipinterface['vspa_MS']],
    ["MA",sipinterface['vspa_MA']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MM",sipinterface['vspa_MM']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NL",sipinterface['vspa_NL']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["NI",sipinterface['vspa_NI']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NU",sipinterface['vspa_NU']],
    ["NF",sipinterface['vspa_NF']],
    ["MK",sipinterface['vspa_MK']],
    ["MP",sipinterface['vspa_MP']],
    ["NO",sipinterface['vspa_NO']],
    ["OM",sipinterface['vspa_OM']],
    ["PK",sipinterface['vspa_PK']],
    ["PW",sipinterface['vspa_PW']],
    ["PS",sipinterface['vspa_PS']],
    ["PA",sipinterface['vspa_PA']],
    ["PG",sipinterface['vspa_PG']],
    ["PY",sipinterface['vspa_PY']],
    ["PE",sipinterface['vspa_PE']],
    ["PH",sipinterface['vspa_PH']],
    ["PN",sipinterface['vspa_PN']],
    ["PL",sipinterface['vspa_PL']],
    ["PT",sipinterface['vspa_PT']],
    ["PR",sipinterface['vspa_PR']],
    ["QA",sipinterface['vspa_QA']],
    ["KR",sipinterface['vspa_KR']],
    ["RE",sipinterface['vspa_RE']],
    ["RO",sipinterface['vspa_RO']],
    ["RU",sipinterface['vspa_RU']],
    ["RW",sipinterface['vspa_RW']],
    ["BL",sipinterface['vspa_BL']],
    ["SH",sipinterface['vspa_SH']],
    ["KN",sipinterface['vspa_KN']],
    ["LC",sipinterface['vspa_LC']],
    ["MF",sipinterface['vspa_MF']],
    ["PM",sipinterface['vspa_PM']],
    ["VC",sipinterface['vspa_VC']],
    ["WS",sipinterface['vspa_WS']],
    ["SM",sipinterface['vspa_SM']],
    ["ST",sipinterface['vspa_ST']],
    ["SA",sipinterface['vspa_SA']],
    ["SN",sipinterface['vspa_SN']],
    ["RS",sipinterface['vspa_RS']],
    ["SC",sipinterface['vspa_SC']],
    ["SL",sipinterface['vspa_SL']],
    ["SG",sipinterface['vspa_SG']],
    ["SX",sipinterface['vspa_SX']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["SB",sipinterface['vspa_SB']],
    ["SO",sipinterface['vspa_SO']],
    ["ZA",sipinterface['vspa_ZA']],
    ["GS",sipinterface['vspa_GS']],
    ["SS",sipinterface['vspa_SS']],
    ["ES",sipinterface['vspa_ES']],
    ["LK",sipinterface['vspa_LK']],
    ["SD",sipinterface['vspa_SD']],
    ["SR",sipinterface['vspa_SR']],
    ["SJ",sipinterface['vspa_SJ']],
    ["SZ",sipinterface['vspa_SZ']],
    ["SE",sipinterface['vspa_SE']],
    ["CH",sipinterface['vspa_CH']],
    ["SY",sipinterface['vspa_SY']],
    ["TW",sipinterface['vspa_TW']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TH",sipinterface['vspa_TH']],
    ["CD",sipinterface['vspa_CD']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["TK",sipinterface['vspa_TK']],
    ["TO",sipinterface['vspa_TO']],
    ["TT",sipinterface['vspa_TT']],
    ["TN",sipinterface['vspa_TN']],
    ["TR",sipinterface['vspa_TR']],
    ["TM",sipinterface['vspa_TM']],
    ["TC",sipinterface['vspa_TC']],
    ["TV",sipinterface['vspa_TV']],
    ["UG",sipinterface['vspa_UG']],
    ["UA",sipinterface['vspa_UA']],
    ["AE",sipinterface['vspa_AE']],
    ["GB",sipinterface['vspa_GB']],
    ["US",sipinterface['vspa_US']],
    ["UM",sipinterface['vspa_UM']],
    ["UY",sipinterface['vspa_UY']],
    ["UZ",sipinterface['vspa_UZ']],
    ["VU",sipinterface['vspa_VU']],
    ["VA",sipinterface['vspa_VA']],
    ["VE",sipinterface['vspa_VE']],
    ["VN",sipinterface['vspa_VN']],
    ["VG",sipinterface['vspa_VG']],
    ["VI",sipinterface['vspa_VI']],
    ["WF",sipinterface['vspa_WF']],
    ["YE",sipinterface['vspa_YE']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']]];
    
    
    var RegionCh = [
    ["AL",sipinterface['vspa_AL']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AF",sipinterface['vspa_AF']],
    ["AR",sipinterface['vspa_AR']],
    ["AE",sipinterface['vspa_AE']],
    ["AW",sipinterface['vspa_AW']],
    ["OM",sipinterface['vspa_OM']],
    ["AZ",sipinterface['vspa_AZ']],
    ["EG",sipinterface['vspa_EG']],
    ["ET",sipinterface['vspa_ET']],
    ["IE",sipinterface['vspa_IE']],
    ["EE",sipinterface['vspa_EE']],
    ["AD",sipinterface['vspa_AD']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AG",sipinterface['vspa_AG']],
    ["AT",sipinterface['vspa_AT']],
    ["AX",sipinterface['vspa_AX']],
    ["AU",sipinterface['vspa_AU']],
    ["MO",sipinterface['vspa_MO']],
    ["BB",sipinterface['vspa_BB']],
    ["PG",sipinterface['vspa_PG']],
    ["BS",sipinterface['vspa_BS']],
    ["PK",sipinterface['vspa_PK']],
    ["PY",sipinterface['vspa_PY']],
    ["PS",sipinterface['vspa_PS']],
    ["BH",sipinterface['vspa_BH']],
    ["PA",sipinterface['vspa_PA']],
    ["BR",sipinterface['vspa_BR']],
    ["BY",sipinterface['vspa_BY']],
    ["BM",sipinterface['vspa_BM']],
    ["BG",sipinterface['vspa_BG']],
    ["MP",sipinterface['vspa_MP']],
    ["MK",sipinterface['vspa_MK']],
    ["PW",sipinterface['vspa_PW']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BE",sipinterface['vspa_BE']],
    ["IS",sipinterface['vspa_IS']],
    ["PR",sipinterface['vspa_PR']],
    ["BA",sipinterface['vspa_BA']],
    ["PL",sipinterface['vspa_PL']],
    ["BO",sipinterface['vspa_BO']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BW",sipinterface['vspa_BW']],
    ["BT",sipinterface['vspa_BT']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["BV",sipinterface['vspa_BV']],
    ["KP",sipinterface['vspa_KP']],
    ["GQ",sipinterface['vspa_GQ']],
    ["DK",sipinterface['vspa_DK']],
    ["DE",sipinterface['vspa_DE']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["DO",sipinterface['vspa_DO']],
    ["DM",sipinterface['vspa_DM']],
    ["RU",sipinterface['vspa_RU']],
    ["EC",sipinterface['vspa_EC']],
    ["ER",sipinterface['vspa_ER']],
    ["FR",sipinterface['vspa_FR']],
    ["FO",sipinterface['vspa_FO']],
    ["PF",sipinterface['vspa_PF']],
    ["GF",sipinterface['vspa_GF']],
    ["TF",sipinterface['vspa_TF']],
    ["VA",sipinterface['vspa_VA']],
    ["PH",sipinterface['vspa_PH']],
    ["FJ",sipinterface['vspa_FJ']],
    ["FI",sipinterface['vspa_FI']],
    ["CV",sipinterface['vspa_CV']],
    ["FK",sipinterface['vspa_FK']],
    ["GM",sipinterface['vspa_GM']],
    ["CG",sipinterface['vspa_CG']],
    ["CD",sipinterface['vspa_CD']],
    ["CO",sipinterface['vspa_CO']],
    ["CR",sipinterface['vspa_CR']],
    ["GD",sipinterface['vspa_GD']],
    ["GL",sipinterface['vspa_GL']],
    ["GE",sipinterface['vspa_GE']],
    ["GG",sipinterface['vspa_GG']],
    ["CU",sipinterface['vspa_CU']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GY",sipinterface['vspa_GY']],
    ["KZ",sipinterface['vspa_KZ']],
    ["HT",sipinterface['vspa_HT']],
    ["KR",sipinterface['vspa_KR']],
    ["NL",sipinterface['vspa_NL']],
    ["BQ",sipinterface['vspa_BQ']],
    ["SX",sipinterface['vspa_SX']],
    ["HM",sipinterface['vspa_HM']],
    ["ME",sipinterface['vspa_ME']],
    ["HN",sipinterface['vspa_HN']],
    ["KI",sipinterface['vspa_KI']],
    ["DJ",sipinterface['vspa_DJ']],
    ["KG",sipinterface['vspa_KG']],
    ["GN",sipinterface['vspa_GN']],
    ["GW",sipinterface['vspa_GW']],
    ["CA",sipinterface['vspa_CA']],
    ["GH",sipinterface['vspa_GH']],
    ["GA",sipinterface['vspa_GA']],
    ["KH",sipinterface['vspa_KH']],
    ["CZ",sipinterface['vspa_CZ']],
    ["ZW",sipinterface['vspa_ZW']],
    ["CM",sipinterface['vspa_CM']],
    ["QA",sipinterface['vspa_QA']],
    ["KY",sipinterface['vspa_KY']],
    ["CC",sipinterface['vspa_CC']],
    ["KM",sipinterface['vspa_KM']],
    ["CI",sipinterface['vspa_CI']],
    ["KW",sipinterface['vspa_KW']],
    ["HR",sipinterface['vspa_HR']],
    ["KE",sipinterface['vspa_KE']],
    ["CK",sipinterface['vspa_CK']],
    ["CW",sipinterface['vspa_CW']],
    ["LV",sipinterface['vspa_LV']],
    ["LS",sipinterface['vspa_LS']],
    ["LA",sipinterface['vspa_LA']],
    ["LB",sipinterface['vspa_LB']],
    ["LT",sipinterface['vspa_LT']],
    ["LR",sipinterface['vspa_LR']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["RE",sipinterface['vspa_RE']],
    ["LU",sipinterface['vspa_LU']],
    ["RW",sipinterface['vspa_RW']],
    ["RO",sipinterface['vspa_RO']],
    ["MG",sipinterface['vspa_MG']],
    ["IM",sipinterface['vspa_IM']],
    ["MV",sipinterface['vspa_MV']],
    ["MT",sipinterface['vspa_MT']],
    ["MW",sipinterface['vspa_MW']],
    ["MY",sipinterface['vspa_MY']],
    ["ML",sipinterface['vspa_ML']],
    ["MH",sipinterface['vspa_MH']],
    ["MQ",sipinterface['vspa_MQ']],
    ["YT",sipinterface['vspa_YT']],
    ["MU",sipinterface['vspa_MU']],
    ["MR",sipinterface['vspa_MR']],
    ["US",sipinterface['vspa_US']],
    ["UM",sipinterface['vspa_UM']],
    ["AS",sipinterface['vspa_AS']],
    ["MN",sipinterface['vspa_MN']],
    ["MS",sipinterface['vspa_MS']],
    ["BD",sipinterface['vspa_BD']],
    ["PE",sipinterface['vspa_PE']],
    ["FM",sipinterface['vspa_FM']],
    ["MM",sipinterface['vspa_MM']],
    ["MD",sipinterface['vspa_MD']],
    ["MA",sipinterface['vspa_MA']],
    ["MC",sipinterface['vspa_MC']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MX",sipinterface['vspa_MX']],
    ["NA",sipinterface['vspa_NA']],
    ["ZA",sipinterface['vspa_ZA']],
    ["AQ",sipinterface['vspa_AQ']],
    ["GS",sipinterface['vspa_GS']],
    ["SS",sipinterface['vspa_SS']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NI",sipinterface['vspa_NI']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NU",sipinterface['vspa_NU']],
    ["NO",sipinterface['vspa_NO']],
    ["NF",sipinterface['vspa_NF']],
    ["PN",sipinterface['vspa_PN']],
    ["PT",sipinterface['vspa_PT']],
    ["JP",sipinterface['vspa_JP']],
    ["SE",sipinterface['vspa_SE']],
    ["CH",sipinterface['vspa_CH']],
    ["SV",sipinterface['vspa_SV']],
    ["WS",sipinterface['vspa_WS']],
    ["RS",sipinterface['vspa_RS']],
    ["SL",sipinterface['vspa_SL']],
    ["SN",sipinterface['vspa_SN']],
    ["CY",sipinterface['vspa_CY']],
    ["SC",sipinterface['vspa_SC']],
    ["SA",sipinterface['vspa_SA']],
    ["BL",sipinterface['vspa_BL']],
    ["PM",sipinterface['vspa_PM']],
    ["CX",sipinterface['vspa_CX']],
    ["ST",sipinterface['vspa_ST']],
    ["SH",sipinterface['vspa_SH']],
    ["KN",sipinterface['vspa_KN']],
    ["LC",sipinterface['vspa_LC']],
    ["MF",sipinterface['vspa_MF']],
    ["SM",sipinterface['vspa_SM']],
    ["VC",sipinterface['vspa_VC']],
    ["LK",sipinterface['vspa_LK']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["SJ",sipinterface['vspa_SJ']],
    ["SZ",sipinterface['vspa_SZ']],
    ["SD",sipinterface['vspa_SD']],
    ["SR",sipinterface['vspa_SR']],
    ["SB",sipinterface['vspa_SB']],
    ["SO",sipinterface['vspa_SO']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TH",sipinterface['vspa_TH']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TO",sipinterface['vspa_TO']],
    ["TC",sipinterface['vspa_TC']],
    ["TT",sipinterface['vspa_TT']],
    ["TN",sipinterface['vspa_TN']],
    ["TV",sipinterface['vspa_TV']],
    ["TR",sipinterface['vspa_TR']],
    ["TM",sipinterface['vspa_TM']],
    ["TK",sipinterface['vspa_TK']],
    ["WF",sipinterface['vspa_WF']],
    ["VU",sipinterface['vspa_VU']],
    ["GT",sipinterface['vspa_GT']],
    ["VI",sipinterface['vspa_VI']],
    ["VG",sipinterface['vspa_VG']],
    ["VE",sipinterface['vspa_VE']],
    ["BN",sipinterface['vspa_BN']],
    ["UG",sipinterface['vspa_UG']],
    ["UA",sipinterface['vspa_UA']],
    ["UY",sipinterface['vspa_UY']],
    ["UZ",sipinterface['vspa_UZ']],
    ["ES",sipinterface['vspa_ES']],
    ["GR",sipinterface['vspa_GR']],
    ["HK",sipinterface['vspa_HK']],
    ["SG",sipinterface['vspa_SG']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["HU",sipinterface['vspa_HU']],
    ["SY",sipinterface['vspa_SY']],
    ["JM",sipinterface['vspa_JM']],
    ["AM",sipinterface['vspa_AM']],
    ["YE",sipinterface['vspa_YE']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IR",sipinterface['vspa_IR']],
    ["IL",sipinterface['vspa_IL']],
    ["IT",sipinterface['vspa_IT']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["GB",sipinterface['vspa_GB']],
    ["IO",sipinterface['vspa_IO']],
    ["JO",sipinterface['vspa_JO']],
    ["VN",sipinterface['vspa_VN']],
    ["ZM",sipinterface['vspa_ZM']],
    ["JE",sipinterface['vspa_JE']],
    ["TD",sipinterface['vspa_TD']],
    ["GI",sipinterface['vspa_GI']],
    ["CL",sipinterface['vspa_CL']],
    ["CF",sipinterface['vspa_CF']],
    ["CN",sipinterface['vspa_CN']],
    ["TW",sipinterface['vspa_TW']]];
    
    var RegionSpa = [
    ["AF",sipinterface['vspa_AF']],
    ["CF",sipinterface['vspa_CF']],
    ["AL",sipinterface['vspa_AL']],
    ["DE",sipinterface['vspa_DE']],
    ["AD",sipinterface['vspa_AD']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["SA",sipinterface['vspa_SA']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AR",sipinterface['vspa_AR']],
    ["AM",sipinterface['vspa_AM']],
    ["AW",sipinterface['vspa_AW']],
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AZ",sipinterface['vspa_AZ']],
    ["BS",sipinterface['vspa_BS']],
    ["BH",sipinterface['vspa_BH']],
    ["BD",sipinterface['vspa_BD']],
    ["BB",sipinterface['vspa_BB']],
    ["BE",sipinterface['vspa_BE']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BM",sipinterface['vspa_BM']],
    ["BY",sipinterface['vspa_BY']],
    ["BO",sipinterface['vspa_BO']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BR",sipinterface['vspa_BR']],
    ["BN",sipinterface['vspa_BN']],
    ["BG",sipinterface['vspa_BG']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["BT",sipinterface['vspa_BT']],
    ["CV",sipinterface['vspa_CV']],
    ["KH",sipinterface['vspa_KH']],
    ["CM",sipinterface['vspa_CM']],
    ["CA",sipinterface['vspa_CA']],
    ["TD",sipinterface['vspa_TD']],
    ["CL",sipinterface['vspa_CL']],
    ["CN",sipinterface['vspa_CN']],
    ["CY",sipinterface['vspa_CY']],
    ["CO",sipinterface['vspa_CO']],
    ["KM",sipinterface['vspa_KM']],
    ["CG",sipinterface['vspa_CG']],
    ["CI",sipinterface['vspa_CI']],
    ["CR",sipinterface['vspa_CR']],
    ["HR",sipinterface['vspa_HR']],
    ["CU",sipinterface['vspa_CU']],
    ["CW",sipinterface['vspa_CW']],
    ["DK",sipinterface['vspa_DK']],
    ["DM",sipinterface['vspa_DM']],
    ["EC",sipinterface['vspa_EC']],
    ["EG",sipinterface['vspa_EG']],
    ["SV",sipinterface['vspa_SV']],
    ["VA",sipinterface['vspa_VA']],
    ["AE",sipinterface['vspa_AE']],
    ["ER",sipinterface['vspa_ER']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["ES",sipinterface['vspa_ES']],
    ["US",sipinterface['vspa_US']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["PH",sipinterface['vspa_PH']],
    ["FI",sipinterface['vspa_FI']],
    ["FJ",sipinterface['vspa_FJ']],
    ["FR",sipinterface['vspa_FR']],
    ["GA",sipinterface['vspa_GA']],
    ["GM",sipinterface['vspa_GM']],
    ["GE",sipinterface['vspa_GE']],
    ["GH",sipinterface['vspa_GH']],
    ["GI",sipinterface['vspa_GI']],
    ["GD",sipinterface['vspa_GD']],
    ["GR",sipinterface['vspa_GR']],
    ["GL",sipinterface['vspa_GL']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GT",sipinterface['vspa_GT']],
    ["GF",sipinterface['vspa_GF']],
    ["GG",sipinterface['vspa_GG']],
    ["GN",sipinterface['vspa_GN']],
    ["GQ",sipinterface['vspa_GQ']],
    ["GW",sipinterface['vspa_GW']],
    ["GY",sipinterface['vspa_GY']],
    ["HT",sipinterface['vspa_HT']],
    ["HN",sipinterface['vspa_HN']],
    ["HU",sipinterface['vspa_HU']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IR",sipinterface['vspa_IR']],
    ["IE",sipinterface['vspa_IE']],
    ["BV",sipinterface['vspa_BV']],
    ["IM",sipinterface['vspa_IM']],
    ["CX",sipinterface['vspa_CX']],
    ["NF",sipinterface['vspa_NF']],
    ["IS",sipinterface['vspa_IS']],
    ["AX",sipinterface['vspa_AX']],
    ["KY",sipinterface['vspa_KY']],
    ["CC",sipinterface['vspa_CC']],
    ["CK",sipinterface['vspa_CK']],
    ["FO",sipinterface['vspa_FO']],
    ["GS",sipinterface['vspa_GS']],
    ["HM",sipinterface['vspa_HM']],
    ["FK",sipinterface['vspa_FK']],
    ["MP",sipinterface['vspa_MP']],
    ["MH",sipinterface['vspa_MH']],
    ["SB",sipinterface['vspa_SB']],
    ["TC",sipinterface['vspa_TC']],
    ["UM",sipinterface['vspa_UM']],
    ["VG",sipinterface['vspa_VG']],
    ["VI",sipinterface['vspa_VI']],
    ["IL",sipinterface['vspa_IL']],
    ["IT",sipinterface['vspa_IT']],
    ["JM",sipinterface['vspa_JM']],
    ["JP",sipinterface['vspa_JP']],
    ["JE",sipinterface['vspa_JE']],
    ["JO",sipinterface['vspa_JO']],
    ["KZ",sipinterface['vspa_KZ']],
    ["KE",sipinterface['vspa_KE']],
    ["KG",sipinterface['vspa_KG']],
    ["KI",sipinterface['vspa_KI']],
    ["KW",sipinterface['vspa_KW']],
    ["LA",sipinterface['vspa_LA']],
    ["LS",sipinterface['vspa_LS']],
    ["LV",sipinterface['vspa_LV']],
    ["LB",sipinterface['vspa_LB']],
    ["LR",sipinterface['vspa_LR']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["LT",sipinterface['vspa_LT']],
    ["LU",sipinterface['vspa_LU']],
    ["MK",sipinterface['vspa_MK']],
    ["MG",sipinterface['vspa_MG']],
    ["MY",sipinterface['vspa_MY']],
    ["MW",sipinterface['vspa_MW']],
    ["MV",sipinterface['vspa_MV']],
    ["ML",sipinterface['vspa_ML']],
    ["MT",sipinterface['vspa_MT']],
    ["MA",sipinterface['vspa_MA']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MU",sipinterface['vspa_MU']],
    ["MR",sipinterface['vspa_MR']],
    ["YT",sipinterface['vspa_YT']],
    ["MX",sipinterface['vspa_MX']],
    ["FM",sipinterface['vspa_FM']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MN",sipinterface['vspa_MN']],
    ["ME",sipinterface['vspa_ME']],
    ["MS",sipinterface['vspa_MS']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MM",sipinterface['vspa_MM']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NI",sipinterface['vspa_NI']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NU",sipinterface['vspa_NU']],
    ["NO",sipinterface['vspa_NO']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["OM",sipinterface['vspa_OM']],
    ["NL",sipinterface['vspa_NL']],
    ["PK",sipinterface['vspa_PK']],
    ["PW",sipinterface['vspa_PW']],
    ["PS",sipinterface['vspa_PS']],
    ["PA",sipinterface['vspa_PA']],
    ["PG",sipinterface['vspa_PG']],
    ["PY",sipinterface['vspa_PY']],
    ["PE",sipinterface['vspa_PE']],
    ["PN",sipinterface['vspa_PN']],
    ["PF",sipinterface['vspa_PF']],
    ["PL",sipinterface['vspa_PL']],
    ["PT",sipinterface['vspa_PT']],
    ["PR",sipinterface['vspa_PR']],
    ["QA",sipinterface['vspa_QA']],
    ["HK",sipinterface['vspa_HK']],
    ["MO",sipinterface['vspa_MO']],
    ["GB",sipinterface['vspa_GB']],
    ["CZ",sipinterface['vspa_CZ']],
    ["KR",sipinterface['vspa_KR']],
    ["CD",sipinterface['vspa_CD']],
    ["DO",sipinterface['vspa_DO']],
    ["KP",sipinterface['vspa_KP']],
    ["RE",sipinterface['vspa_RE']],
    ["RW",sipinterface['vspa_RW']],
    ["RO",sipinterface['vspa_RO']],
    ["RU",sipinterface['vspa_RU']],
    ["WS",sipinterface['vspa_WS']],
    ["AS",sipinterface['vspa_AS']],
    ["BL",sipinterface['vspa_BL']],
    ["KN",sipinterface['vspa_KN']],
    ["SM",sipinterface['vspa_SM']],
    ["MF",sipinterface['vspa_MF']],
    ["PM",sipinterface['vspa_PM']],
    ["VC",sipinterface['vspa_VC']],
    ["SH",sipinterface['vspa_SH']],
    ["LC",sipinterface['vspa_LC']],
    ["ST",sipinterface['vspa_ST']],
    ["SN",sipinterface['vspa_SN']],
    ["RS",sipinterface['vspa_RS']],
    ["SC",sipinterface['vspa_SC']],
    ["SL",sipinterface['vspa_SL']],
    ["SG",sipinterface['vspa_SG']],
    ["SX",sipinterface['vspa_SX']],
    ["SY",sipinterface['vspa_SY']],
    ["SO",sipinterface['vspa_SO']],
    ["LK",sipinterface['vspa_LK']],
    ["SZ",sipinterface['vspa_SZ']],
    ["ZA",sipinterface['vspa_ZA']],
    ["SD",sipinterface['vspa_SD']],
    ["SS",sipinterface['vspa_SS']],
    ["SE",sipinterface['vspa_SE']],
    ["CH",sipinterface['vspa_CH']],
    ["SR",sipinterface['vspa_SR']],
    ["SJ",sipinterface['vspa_SJ']],
    ["TH",sipinterface['vspa_TH']],
    ["TW",sipinterface['vspa_TW']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TJ",sipinterface['vspa_TJ']],
    ["IO",sipinterface['vspa_IO']],
    ["TF",sipinterface['vspa_TF']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["TK",sipinterface['vspa_TK']],
    ["TO",sipinterface['vspa_TO']],
    ["TT",sipinterface['vspa_TT']],
    ["TN",sipinterface['vspa_TN']],
    ["TM",sipinterface['vspa_TM']],
    ["TR",sipinterface['vspa_TR']],
    ["TV",sipinterface['vspa_TV']],
    ["UA",sipinterface['vspa_UA']],
    ["UG",sipinterface['vspa_UG']],
    ["UY",sipinterface['vspa_UY']],
    ["UZ",sipinterface['vspa_UZ']],
    ["VU",sipinterface['vspa_VU']],
    ["VE",sipinterface['vspa_VE']],
    ["VN",sipinterface['vspa_VN']],
    ["WF",sipinterface['vspa_WF']],
    ["YE",sipinterface['vspa_YE']],
    ["DJ",sipinterface['vspa_DJ']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']]];
    
    var RegionArb = [
    ["ET",sipinterface['vspa_ET']],
    ["AZ",sipinterface['vspa_AZ']],
    ["AM",sipinterface['vspa_AM']],
    ["AW",sipinterface['vspa_AW']],
    ["ER",sipinterface['vspa_ER']],
    ["ES",sipinterface['vspa_ES']],
    ["AU",sipinterface['vspa_AU']],
    ["EE",sipinterface['vspa_EE']],
    ["IL",sipinterface['vspa_IL']],
    ["CF",sipinterface['vspa_CF']],
    ["AF",sipinterface['vspa_AF']],
    ["IO",sipinterface['vspa_IO']],
    ["TF",sipinterface['vspa_TF']],
    ["AR",sipinterface['vspa_AR']],
    ["JO",sipinterface['vspa_JO']],
    ["EC",sipinterface['vspa_EC']],
    ["AE",sipinterface['vspa_AE']],
    ["AL",sipinterface['vspa_AL']],
    ["BH",sipinterface['vspa_BH']],
    ["BR",sipinterface['vspa_BR']],
    ["PT",sipinterface['vspa_PT']],
    ["BA",sipinterface['vspa_BA']],
    ["ME",sipinterface['vspa_ME']],
    ["DZ",sipinterface['vspa_DZ']],
    ["VI",sipinterface['vspa_VI']],
    ["VG",sipinterface['vspa_VG']],
    ["DK",sipinterface['vspa_DK']],
    ["SV",sipinterface['vspa_SV']],
    ["SN",sipinterface['vspa_SN']],
    ["SD",sipinterface['vspa_SD']],
    ["SE",sipinterface['vspa_SE']],
    ["SO",sipinterface['vspa_SO']],
    ["IQ",sipinterface['vspa_IQ']],
    ["GA",sipinterface['vspa_GA']],
    ["VA",sipinterface['vspa_VA']],
    ["PH",sipinterface['vspa_PH']],
    ["CM",sipinterface['vspa_CM']],
    ["CG",sipinterface['vspa_CG']],
    ["CD",sipinterface['vspa_CD']],
    ["KW",sipinterface['vspa_KW']],
    ["DE",sipinterface['vspa_DE']],
    ["HU",sipinterface['vspa_HU']],
    ["MA",sipinterface['vspa_MA']],
    ["MX",sipinterface['vspa_MX']],
    ["SA",sipinterface['vspa_SA']],
    ["NO",sipinterface['vspa_NO']],
    ["AT",sipinterface['vspa_AT']],
    ["NE",sipinterface['vspa_NE']],
    ["IN",sipinterface['vspa_IN']],
    ["US",sipinterface['vspa_US']],
    ["JP",sipinterface['vspa_JP']],
    ["YE",sipinterface['vspa_YE']],
    ["GR",sipinterface['vspa_GR']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AD",sipinterface['vspa_AD']],
    ["ID",sipinterface['vspa_ID']],
    ["UY",sipinterface['vspa_UY']],
    ["UZ",sipinterface['vspa_UZ']],
    ["UG",sipinterface['vspa_UG']],
    ["UA",sipinterface['vspa_UA']],
    ["IR",sipinterface['vspa_IR']],
    ["IE",sipinterface['vspa_IE']],
    ["IS",sipinterface['vspa_IS']],
    ["IT",sipinterface['vspa_IT']],
    ["PG",sipinterface['vspa_PG']],
    ["PY",sipinterface['vspa_PY']],
    ["BB",sipinterface['vspa_BB']],
    ["PK",sipinterface['vspa_PK']],
    ["PW",sipinterface['vspa_PW']],
    ["CN",sipinterface['vspa_CN']],
    ["BM",sipinterface['vspa_BM']],
    ["BN",sipinterface['vspa_BN']],
    ["GB",sipinterface['vspa_GB']],
    ["BE",sipinterface['vspa_BE']],
    ["BG",sipinterface['vspa_BG']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BD",sipinterface['vspa_BD']],
    ["PA",sipinterface['vspa_PA']],
    ["BT",sipinterface['vspa_BT']],
    ["BW",sipinterface['vspa_BW']],
    ["PR",sipinterface['vspa_PR']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["PL",sipinterface['vspa_PL']],
    ["BO",sipinterface['vspa_BO']],
    ["PF",sipinterface['vspa_PF']],
    ["BQ",sipinterface['vspa_BQ']],
    ["PN",sipinterface['vspa_PN']],
    ["PE",sipinterface['vspa_PE']],
    ["BJ",sipinterface['vspa_BJ']],
    ["TH",sipinterface['vspa_TH']],
    ["TW",sipinterface['vspa_TW']],
    ["TM",sipinterface['vspa_TM']],
    ["TR",sipinterface['vspa_TR']],
    ["TT",sipinterface['vspa_TT']],
    ["TD",sipinterface['vspa_TD']],
    ["CL",sipinterface['vspa_CL']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TG",sipinterface['vspa_TG']],
    ["TV",sipinterface['vspa_TV']],
    ["TK",sipinterface['vspa_TK']],
    ["TN",sipinterface['vspa_TN']],
    ["TO",sipinterface['vspa_TO']],
    ["TL",sipinterface['vspa_TL']],
    ["JM",sipinterface['vspa_JM']],
    ["GI",sipinterface['vspa_GI']],
    ["AX",sipinterface['vspa_AX']],
    ["BS",sipinterface['vspa_BS']],
    ["KM",sipinterface['vspa_KM']],
    ["MH",sipinterface['vspa_MH']],
    ["MV",sipinterface['vspa_MV']],
    ["UM",sipinterface['vspa_UM']],
    ["TC",sipinterface['vspa_TC']],
    ["SB",sipinterface['vspa_SB']],
    ["FO",sipinterface['vspa_FO']],
    ["FK",sipinterface['vspa_FK']],
    ["KY",sipinterface['vspa_KY']],
    ["CK",sipinterface['vspa_CK']],
    ["CC",sipinterface['vspa_CC']],
    ["CV",sipinterface['vspa_CV']],
    ["CX",sipinterface['vspa_CX']],
    ["BV",sipinterface['vspa_BV']],
    ["IM",sipinterface['vspa_IM']],
    ["NF",sipinterface['vspa_NF']],
    ["HM",sipinterface['vspa_HM']],
    ["CZ",sipinterface['vspa_CZ']],
    ["DO",sipinterface['vspa_DO']],
    ["KR",sipinterface['vspa_KR']],
    ["KP",sipinterface['vspa_KP']],
    ["ZA",sipinterface['vspa_ZA']],
    ["SS",sipinterface['vspa_SS']],
    ["GE",sipinterface['vspa_GE']],
    ["GS",sipinterface['vspa_GS']],
    ["DJ",sipinterface['vspa_DJ']],
    ["JE",sipinterface['vspa_JE']],
    ["DM",sipinterface['vspa_DM']],
    ["RW",sipinterface['vspa_RW']],
    ["RU",sipinterface['vspa_RU']],
    ["BY",sipinterface['vspa_BY']],
    ["RO",sipinterface['vspa_RO']],
    ["RE",sipinterface['vspa_RE']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']],
    ["CI",sipinterface['vspa_CI']],
    ["WS",sipinterface['vspa_WS']],
    ["AS",sipinterface['vspa_AS']],
    ["BL",sipinterface['vspa_BL']],
    ["PM",sipinterface['vspa_PM']],
    ["SM",sipinterface['vspa_SM']],
    ["VC",sipinterface['vspa_VC']],
    ["KN",sipinterface['vspa_KN']],
    ["LC",sipinterface['vspa_LC']],
    ["MF",sipinterface['vspa_MF']],
    ["SH",sipinterface['vspa_SH']],
    ["ST",sipinterface['vspa_ST']],
    ["SJ",sipinterface['vspa_SJ']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["SG",sipinterface['vspa_SG']],
    ["SZ",sipinterface['vspa_SZ']],
    ["SY",sipinterface['vspa_SY']],
    ["SR",sipinterface['vspa_SR']],
    ["CH",sipinterface['vspa_CH']],
    ["SL",sipinterface['vspa_SL']],
    ["LK",sipinterface['vspa_LK']],
    ["SC",sipinterface['vspa_SC']],
    ["SX",sipinterface['vspa_SX']],
    ["RS",sipinterface['vspa_RS']],
    ["TJ",sipinterface['vspa_TJ']],
    ["OM",sipinterface['vspa_OM']],
    ["GM",sipinterface['vspa_GM']],
    ["GH",sipinterface['vspa_GH']],
    ["GD",sipinterface['vspa_GD']],
    ["GL",sipinterface['vspa_GL']],
    ["GT",sipinterface['vspa_GT']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GY",sipinterface['vspa_GY']],
    ["GF",sipinterface['vspa_GF']],
    ["GG",sipinterface['vspa_GG']],
    ["GN",sipinterface['vspa_GN']],
    ["GQ",sipinterface['vspa_GQ']],
    ["GW",sipinterface['vspa_GW']],
    ["VU",sipinterface['vspa_VU']],
    ["FR",sipinterface['vspa_FR']],
    ["PS",sipinterface['vspa_PS']],
    ["VE",sipinterface['vspa_VE']],
    ["FI",sipinterface['vspa_FI']],
    ["VN",sipinterface['vspa_VN']],
    ["FJ",sipinterface['vspa_FJ']],
    ["CY",sipinterface['vspa_CY']],
    ["KG",sipinterface['vspa_KG']],
    ["QA",sipinterface['vspa_QA']],
    ["KZ",sipinterface['vspa_KZ']],
    ["NC",sipinterface['vspa_NC']],
    ["HR",sipinterface['vspa_HR']],
    ["KI",sipinterface['vspa_KI']],
    ["KH",sipinterface['vspa_KH']],
    ["CA",sipinterface['vspa_CA']],
    ["CU",sipinterface['vspa_CU']],
    ["CW",sipinterface['vspa_CW']],
    ["CR",sipinterface['vspa_CR']],
    ["CO",sipinterface['vspa_CO']],
    ["KE",sipinterface['vspa_KE']],
    ["LV",sipinterface['vspa_LV']],
    ["LA",sipinterface['vspa_LA']],
    ["LB",sipinterface['vspa_LB']],
    ["LU",sipinterface['vspa_LU']],
    ["LY",sipinterface['vspa_LY']],
    ["LR",sipinterface['vspa_LR']],
    ["LT",sipinterface['vspa_LT']],
    ["LI",sipinterface['vspa_LI']],
    ["LS",sipinterface['vspa_LS']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MP",sipinterface['vspa_MP']],
    ["MW",sipinterface['vspa_MW']],
    ["MT",sipinterface['vspa_MT']],
    ["ML",sipinterface['vspa_ML']],
    ["MY",sipinterface['vspa_MY']],
    ["YT",sipinterface['vspa_YT']],
    ["MG",sipinterface['vspa_MG']],
    ["EG",sipinterface['vspa_EG']],
    ["MK",sipinterface['vspa_MK']],
    ["MO",sipinterface['vspa_MO']],
    ["HK",sipinterface['vspa_HK']],
    ["MN",sipinterface['vspa_MN']],
    ["MR",sipinterface['vspa_MR']],
    ["MU",sipinterface['vspa_MU']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MS",sipinterface['vspa_MS']],
    ["MM",sipinterface['vspa_MM']],
    ["FM",sipinterface['vspa_FM']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NG",sipinterface['vspa_NG']],
    ["NI",sipinterface['vspa_NI']],
    ["NZ",sipinterface['vspa_NZ']],
    ["NU",sipinterface['vspa_NU']],
    ["HT",sipinterface['vspa_HT']],
    ["HN",sipinterface['vspa_HN']],
    ["NL",sipinterface['vspa_NL']],
    ["WF",sipinterface['vspa_WF']]];
    
    var RegionJap = [
    ["IS",sipinterface['vspa_IS']],
    ["IE",sipinterface['vspa_IE']],
    ["AZ",sipinterface['vspa_AZ']],
    ["AF",sipinterface['vspa_AF']],
    ["AE",sipinterface['vspa_AE']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AR",sipinterface['vspa_AR']],
    ["AW",sipinterface['vspa_AW']],
    ["AL",sipinterface['vspa_AL']],
    ["AM",sipinterface['vspa_AM']],
    ["AI",sipinterface['vspa_AI']],
    ["AO",sipinterface['vspa_AO']],
    ["AG",sipinterface['vspa_AG']],
    ["AD",sipinterface['vspa_AD']],
    ["YE",sipinterface['vspa_YE']],
    ["IL",sipinterface['vspa_IL']],
    ["IT",sipinterface['vspa_IT']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IR",sipinterface['vspa_IR']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["UG",sipinterface['vspa_UG']],
    ["UA",sipinterface['vspa_UA']],
    ["UZ",sipinterface['vspa_UZ']],
    ["UY",sipinterface['vspa_UY']],
    ["GB",sipinterface['vspa_GB']],
    ["IO",sipinterface['vspa_IO']],
    ["VG",sipinterface['vspa_VG']],	
    ["EC",sipinterface['vspa_EC']],
    ["EG",sipinterface['vspa_EG']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["ER",sipinterface['vspa_ER']],
    ["SV",sipinterface['vspa_SV']],
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AX",sipinterface['vspa_AX']],
    ["OM",sipinterface['vspa_OM']],
    ["NL",sipinterface['vspa_NL']],
    ["GH",sipinterface['vspa_GH']],
    ["CV",sipinterface['vspa_CV']],
    ["GG",sipinterface['vspa_GG']],
    ["GY",sipinterface['vspa_GY']],
    ["KZ",sipinterface['vspa_KZ']],
    ["QA",sipinterface['vspa_QA']],
    ["UM",sipinterface['vspa_UM']],	
    ["CA",sipinterface['vspa_CA']],
    ["GA",sipinterface['vspa_GA']],
    ["CM",sipinterface['vspa_CM']],
    ["GM",sipinterface['vspa_GM']],
    ["KH",sipinterface['vspa_KH']],
    ["MK",sipinterface['vspa_MK']],
    ["MP",sipinterface['vspa_MP']],	
    ["GN",sipinterface['vspa_GN']],
    ["GW",sipinterface['vspa_GW']],
    ["CY",sipinterface['vspa_CY']],
    ["CU",sipinterface['vspa_CU']],
    ["CW",sipinterface['vspa_CW']],
    ["GR",sipinterface['vspa_GR']],
    ["KI",sipinterface['vspa_KI']],
    ["KG",sipinterface['vspa_KG']],
    ["GT",sipinterface['vspa_GT']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["KW",sipinterface['vspa_KW']],
    ["CK",sipinterface['vspa_CK']],
    ["GL",sipinterface['vspa_GL']],
    ["CX",sipinterface['vspa_CX']],
    ["GD",sipinterface['vspa_GD']],
    ["HR",sipinterface['vspa_HR']],
    ["KY",sipinterface['vspa_KY']],
    ["KE",sipinterface['vspa_KE']],
    ["CI",sipinterface['vspa_CI']],
    ["CC",sipinterface['vspa_CC']],
    ["CR",sipinterface['vspa_CR']],
    ["KM",sipinterface['vspa_KM']],
    ["CO",sipinterface['vspa_CO']],
    ["CG",sipinterface['vspa_CG']],
    ["CD",sipinterface['vspa_CD']],
    ["SA",sipinterface['vspa_SA']],
    ["GS",sipinterface['vspa_GS']],
    ["WS",sipinterface['vspa_WS']],
    ["BL",sipinterface['vspa_BL']],
    ["ST",sipinterface['vspa_ST']],
    ["ZM",sipinterface['vspa_ZM']],
    ["PM",sipinterface['vspa_PM']],
    ["SM",sipinterface['vspa_SM']],
    ["MF",sipinterface['vspa_MF']],	
    ["SL",sipinterface['vspa_SL']],
    ["DJ",sipinterface['vspa_DJ']],
    ["GI",sipinterface['vspa_GI']],
    ["JE",sipinterface['vspa_JE']],
    ["JM",sipinterface['vspa_JM']],
    ["GE",sipinterface['vspa_GE']],
    ["SY",sipinterface['vspa_SY']],
    ["SG",sipinterface['vspa_SG']],
    ["SX",sipinterface['vspa_SX']],
    ["ZW",sipinterface['vspa_ZW']],
    ["CH",sipinterface['vspa_CH']],
    ["SE",sipinterface['vspa_SE']],
    ["SD",sipinterface['vspa_SD']],
    ["SJ",sipinterface['vspa_SJ']],
    ["ES",sipinterface['vspa_ES']],
    ["SR",sipinterface['vspa_SR']],
    ["LK",sipinterface['vspa_LK']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["SZ",sipinterface['vspa_SZ']],
    ["SC",sipinterface['vspa_SC']],
    ["GQ",sipinterface['vspa_GQ']],
    ["SN",sipinterface['vspa_SN']],
    ["RS",sipinterface['vspa_RS']],
    ["KN",sipinterface['vspa_KN']],
    ["VC",sipinterface['vspa_VC']],
    ["SH",sipinterface['vspa_SH']],
    ["LC",sipinterface['vspa_LC']],
    ["SO",sipinterface['vspa_SO']],
    ["SB",sipinterface['vspa_SB']],
    ["TC",sipinterface['vspa_TC']],
    ["TH",sipinterface['vspa_TH']],
    ["KR",sipinterface['vspa_KR']],
    ["TW",sipinterface['vspa_TW']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TZ",sipinterface['vspa_TZ']],
    ["CZ",sipinterface['vspa_CZ']],
    ["TD",sipinterface['vspa_TD']],
    ["CF",sipinterface['vspa_CF']],
    ["CN",sipinterface['vspa_CN']],
    ["TN",sipinterface['vspa_TN']],
    ["KP",sipinterface['vspa_KP']],
    ["CL",sipinterface['vspa_CL']],
    ["TV",sipinterface['vspa_TV']],
    ["DK",sipinterface['vspa_DK']],
    ["DE",sipinterface['vspa_DE']],
    ["TG",sipinterface['vspa_TG']],
    ["TK",sipinterface['vspa_TK']],
    ["DO",sipinterface['vspa_DO']],
    ["DM",sipinterface['vspa_DM']],
    ["TT",sipinterface['vspa_TT']],
    ["TM",sipinterface['vspa_TM']],
    ["TR",sipinterface['vspa_TR']],
    ["TO",sipinterface['vspa_TO']],
    ["NG",sipinterface['vspa_NG']],
    ["NR",sipinterface['vspa_NR']],
    ["NA",sipinterface['vspa_NA']],
    ["AQ",sipinterface['vspa_AQ']],
    ["NU",sipinterface['vspa_NU']],
    ["NI",sipinterface['vspa_NI']],
    ["NE",sipinterface['vspa_NE']],
    ["JP",sipinterface['vspa_JP']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["NP",sipinterface['vspa_NP']],
    ["NF",sipinterface['vspa_NF']],
    ["NO",sipinterface['vspa_NO']],
    ["HM",sipinterface['vspa_HM']],
    ["BH",sipinterface['vspa_BH']],
    ["HT",sipinterface['vspa_HT']],
    ["PK",sipinterface['vspa_PK']],
    ["VA",sipinterface['vspa_VA']],
    ["PA",sipinterface['vspa_PA']],
    ["VU",sipinterface['vspa_VU']],
    ["BS",sipinterface['vspa_BS']],
    ["PG",sipinterface['vspa_PG']],
    ["BM",sipinterface['vspa_BM']],
    ["PW",sipinterface['vspa_PW']],
    ["PY",sipinterface['vspa_PY']],
    ["BB",sipinterface['vspa_BB']],
    ["PS",sipinterface['vspa_PS']],
    ["HU",sipinterface['vspa_HU']],
    ["BD",sipinterface['vspa_BD']],
    ["TL",sipinterface['vspa_TL']],
    ["PN",sipinterface['vspa_PN']],
    ["FJ",sipinterface['vspa_FJ']],
    ["PH",sipinterface['vspa_PH']],
    ["FI",sipinterface['vspa_FI']],
    ["BT",sipinterface['vspa_BT']],
    ["BV",sipinterface['vspa_BV']],
    ["PR",sipinterface['vspa_PR']],
    ["FO",sipinterface['vspa_FO']],
    ["FK",sipinterface['vspa_FK']],
    ["BR",sipinterface['vspa_BR']],
    ["FR",sipinterface['vspa_FR']],
    ["GF",sipinterface['vspa_GF']],
    ["TF",sipinterface['vspa_TF']],
    ["PF",sipinterface['vspa_PF']],
    ["BG",sipinterface['vspa_BG']],
    ["BF",sipinterface['vspa_BF']],
    ["BN",sipinterface['vspa_BN']],
    ["BI",sipinterface['vspa_BI']],
    ["US",sipinterface['vspa_US']],
    ["AS",sipinterface['vspa_AS']],
    ["VI",sipinterface['vspa_VI']],
    ["VN",sipinterface['vspa_VN']],
    ["BJ",sipinterface['vspa_BJ']],
    ["VE",sipinterface['vspa_VE']],
    ["BY",sipinterface['vspa_BY']],
    ["BZ",sipinterface['vspa_BZ']],
    ["PE",sipinterface['vspa_PE']],
    ["BE",sipinterface['vspa_BE']],
    ["PL",sipinterface['vspa_PL']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BO",sipinterface['vspa_BO']],
    ["PT",sipinterface['vspa_PT']],
    ["HK",sipinterface['vspa_HK']],
    ["HN",sipinterface['vspa_HN']],
    ["MH",sipinterface['vspa_MH']],
    ["MO",sipinterface['vspa_MO']],
    ["MG",sipinterface['vspa_MG']],
    ["YT",sipinterface['vspa_YT']],
    ["MW",sipinterface['vspa_MW']],
    ["ML",sipinterface['vspa_ML']],
    ["MT",sipinterface['vspa_MT']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MY",sipinterface['vspa_MY']],
    ["IM",sipinterface['vspa_IM']],
    ["FM",sipinterface['vspa_FM']],
    ["ZA",sipinterface['vspa_ZA']],
    ["SS",sipinterface['vspa_SS']],
    ["MM",sipinterface['vspa_MM']],
    ["MX",sipinterface['vspa_MX']],
    ["MU",sipinterface['vspa_MU']],
    ["MR",sipinterface['vspa_MR']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MC",sipinterface['vspa_MC']],
    ["MV",sipinterface['vspa_MV']],
    ["MD",sipinterface['vspa_MD']],
    ["MA",sipinterface['vspa_MA']],
    ["MN",sipinterface['vspa_MN']],
    ["MS",sipinterface['vspa_MS']],
    ["ME",sipinterface['vspa_ME']],
    ["JO",sipinterface['vspa_JO']],
    ["LA",sipinterface['vspa_LA']],
    ["LV",sipinterface['vspa_LV']],
    ["LT",sipinterface['vspa_LT']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["LR",sipinterface['vspa_LR']],
    ["RO",sipinterface['vspa_RO']],
    ["LU",sipinterface['vspa_LU']],
    ["RW",sipinterface['vspa_RW']],
    ["LS",sipinterface['vspa_LS']],
    ["LB",sipinterface['vspa_LB']],
    ["RE",sipinterface['vspa_RE']],
    ["RU",sipinterface['vspa_RU']],
    ["WF",sipinterface['vspa_WF']]];
    
    var RegionPT = [    
    ["AF",sipinterface['vspa_AF']],
    ["ZA",sipinterface['vspa_ZA']],
    ["AL",sipinterface['vspa_AL']],
    ["DE",sipinterface['vspa_DE']],
    ["AD",sipinterface['vspa_AD']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["SA",sipinterface['vspa_SA']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AR",sipinterface['vspa_AR']],
    ["AM",sipinterface['vspa_AM']],
    ["AW",sipinterface['vspa_AW']],
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AZ",sipinterface['vspa_AZ']],
    ["BS",sipinterface['vspa_BS']],
    ["BD",sipinterface['vspa_BD']],
    ["BB",sipinterface['vspa_BB']],
    ["BH",sipinterface['vspa_BH']],
    ["BE",sipinterface['vspa_BE']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BM",sipinterface['vspa_BM']],
    ["BY",sipinterface['vspa_BY']],
    ["BO",sipinterface['vspa_BO']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BR",sipinterface['vspa_BR']],
    ["BN",sipinterface['vspa_BN']],
    ["BG",sipinterface['vspa_BG']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["BT",sipinterface['vspa_BT']],
    ["CV",sipinterface['vspa_CV']],
    ["CM",sipinterface['vspa_CM']],
    ["KH",sipinterface['vspa_KH']],
    ["CA",sipinterface['vspa_CA']],
    ["QA",sipinterface['vspa_QA']],
    ["KZ",sipinterface['vspa_KZ']],
    ["TD",sipinterface['vspa_TD']],
    ["CL",sipinterface['vspa_CL']],
    ["CN",sipinterface['vspa_CN']],
    ["CY",sipinterface['vspa_CY']],
    ["CO",sipinterface['vspa_CO']],
    ["KM",sipinterface['vspa_KM']],
    ["CG",sipinterface['vspa_CG']],
    ["CD",sipinterface['vspa_CD']],
    ["CI",sipinterface['vspa_CI']],
    ["CR",sipinterface['vspa_CR']],
    ["HR",sipinterface['vspa_HR']],
    ["CU",sipinterface['vspa_CU']],
    ["CW",sipinterface['vspa_CW']],
    ["DK",sipinterface['vspa_DK']],
    ["DM",sipinterface['vspa_DM']],
    ["EG",sipinterface['vspa_EG']],
    ["AE",sipinterface['vspa_AE']],
    ["EC",sipinterface['vspa_EC']],
    ["ER",sipinterface['vspa_ER']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["ES",sipinterface['vspa_ES']],
    ["US",sipinterface['vspa_US']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["FJ",sipinterface['vspa_FJ']],
    ["PH",sipinterface['vspa_PH']],
    ["FI",sipinterface['vspa_FI']],
    ["FR",sipinterface['vspa_FR']],
    ["GA",sipinterface['vspa_GA']],
    ["GM",sipinterface['vspa_GM']],
    ["GH",sipinterface['vspa_GH']],
    ["GE",sipinterface['vspa_GE']],
    ["GI",sipinterface['vspa_GI']],
    ["GD",sipinterface['vspa_GD']],
    ["GR",sipinterface['vspa_GR']],
    ["GL",sipinterface['vspa_GL']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GT",sipinterface['vspa_GT']],
    ["GG",sipinterface['vspa_GG']],
    ["GY",sipinterface['vspa_GY']],
    ["GF",sipinterface['vspa_GF']],
    ["GN",sipinterface['vspa_GN']],
    ["GQ",sipinterface['vspa_GQ']],
    ["GW",sipinterface['vspa_GW']],
    ["HT",sipinterface['vspa_HT']],
    ["HN",sipinterface['vspa_HN']],
    ["HU",sipinterface['vspa_HU']],
    ["YE",sipinterface['vspa_YE']],
    ["BV",sipinterface['vspa_BV']],
    ["IM",sipinterface['vspa_IM']],
    ["MF",sipinterface['vspa_MF']],
    ["CX",sipinterface['vspa_CX']],
    ["HM",sipinterface['vspa_HM']],
    ["NF",sipinterface['vspa_NF']],
    ["AX",sipinterface['vspa_AX']],
    ["KY",sipinterface['vspa_KY']],
    ["CK",sipinterface['vspa_CK']],
    ["CC",sipinterface['vspa_CC']],
    ["FK",sipinterface['vspa_FK']],
    ["FO",sipinterface['vspa_FO']],
    ["GS",sipinterface['vspa_GS']],
    ["MH",sipinterface['vspa_MH']],
    ["UM",sipinterface['vspa_UM']],
    ["PN",sipinterface['vspa_PN']],
    ["SB",sipinterface['vspa_SB']],
    ["TC",sipinterface['vspa_TC']],
    ["VI",sipinterface['vspa_VI']],
    ["VG",sipinterface['vspa_VG']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["IR",sipinterface['vspa_IR']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IE",sipinterface['vspa_IE']],
    ["IS",sipinterface['vspa_IS']],
    ["IL",sipinterface['vspa_IL']],
    ["IT",sipinterface['vspa_IT']],
    ["JM",sipinterface['vspa_JM']],
    ["JP",sipinterface['vspa_JP']],
    ["JE",sipinterface['vspa_JE']],
    ["DJ",sipinterface['vspa_DJ']],
    ["JO",sipinterface['vspa_JO']],
    ["KW",sipinterface['vspa_KW']],
    ["LA",sipinterface['vspa_LA']],
    ["LS",sipinterface['vspa_LS']],
    ["LV",sipinterface['vspa_LV']],
    ["LB",sipinterface['vspa_LB']],
    ["LR",sipinterface['vspa_LR']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["LT",sipinterface['vspa_LT']],
    ["LU",sipinterface['vspa_LU']],
    ["MK",sipinterface['vspa_MK']],
    ["MG",sipinterface['vspa_MG']],
    ["YT",sipinterface['vspa_YT']],
    ["MY",sipinterface['vspa_MY']],
    ["MW",sipinterface['vspa_MW']],
    ["MV",sipinterface['vspa_MV']],
    ["ML",sipinterface['vspa_ML']],
    ["MT",sipinterface['vspa_MT']],
    ["MP",sipinterface['vspa_MP']],
    ["MA",sipinterface['vspa_MA']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MU",sipinterface['vspa_MU']],
    ["MR",sipinterface['vspa_MR']],
    ["MX",sipinterface['vspa_MX']],
    ["MM",sipinterface['vspa_MM']],
    ["FM",sipinterface['vspa_FM']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MN",sipinterface['vspa_MN']],
    ["MS",sipinterface['vspa_MS']],
    ["ME",sipinterface['vspa_ME']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NI",sipinterface['vspa_NI']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NU",sipinterface['vspa_NU']],
    ["NO",sipinterface['vspa_NO']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["OM",sipinterface['vspa_OM']],
    ["NL",sipinterface['vspa_NL']],
    ["PW",sipinterface['vspa_PW']],
    ["PS",sipinterface['vspa_PS']],
    ["PA",sipinterface['vspa_PA']],
    ["PG",sipinterface['vspa_PG']],
    ["PK",sipinterface['vspa_PK']],
    ["PY",sipinterface['vspa_PY']],
    ["PE",sipinterface['vspa_PE']],
    ["PF",sipinterface['vspa_PF']],
    ["PL",sipinterface['vspa_PL']],
    ["PR",sipinterface['vspa_PR']],
    ["PT",sipinterface['vspa_PT']],
    ["KE",sipinterface['vspa_KE']],
    ["KG",sipinterface['vspa_KG']],
    ["KI",sipinterface['vspa_KI']],
    ["HK",sipinterface['vspa_HK']],
    ["MO",sipinterface['vspa_MO']],
    ["GB",sipinterface['vspa_GB']],
    ["CF",sipinterface['vspa_CF']],
    ["CZ",sipinterface['vspa_CZ']],
    ["KR",sipinterface['vspa_KR']],
    ["DO",sipinterface['vspa_DO']],
    ["KP",sipinterface['vspa_KP']],
    ["RE",sipinterface['vspa_RE']],
    ["RO",sipinterface['vspa_RO']],
    ["RW",sipinterface['vspa_RW']],
    ["RU",sipinterface['vspa_RU']],
    ["SV",sipinterface['vspa_SV']],
    ["WS",sipinterface['vspa_WS']],
    ["AS",sipinterface['vspa_AS']],
    ["SH",sipinterface['vspa_SH']],
    ["LC",sipinterface['vspa_LC']],
    ["BL",sipinterface['vspa_BL']],
    ["KN",sipinterface['vspa_KN']],
    ["SM",sipinterface['vspa_SM']],
    ["SX",sipinterface['vspa_SX']],
    ["PM",sipinterface['vspa_PM']],
    ["ST",sipinterface['vspa_ST']],
    ["VC",sipinterface['vspa_VC']],
    ["SC",sipinterface['vspa_SC']],
    ["SN",sipinterface['vspa_SN']],
    ["SL",sipinterface['vspa_SL']],
    ["RS",sipinterface['vspa_RS']],
    ["SG",sipinterface['vspa_SG']],
    ["SY",sipinterface['vspa_SY']],
    ["SO",sipinterface['vspa_SO']],
    ["LK",sipinterface['vspa_LK']],
    ["SZ",sipinterface['vspa_SZ']],
    ["SD",sipinterface['vspa_SD']],
    ["SS",sipinterface['vspa_SS']],
    ["SE",sipinterface['vspa_SE']],
    ["CH",sipinterface['vspa_CH']],
    ["SR",sipinterface['vspa_SR']],
    ["SJ",sipinterface['vspa_SJ']],
    ["TH",sipinterface['vspa_TH']],
    ["TW",sipinterface['vspa_TW']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TF",sipinterface['vspa_TF']],
    ["IO",sipinterface['vspa_IO']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["TO",sipinterface['vspa_TO']],
    ["TK",sipinterface['vspa_TK']],
    ["TT",sipinterface['vspa_TT']],
    ["TN",sipinterface['vspa_TN']],
    ["TM",sipinterface['vspa_TM']],
    ["TR",sipinterface['vspa_TR']],
    ["TV",sipinterface['vspa_TV']],
    ["UA",sipinterface['vspa_UA']],
    ["UG",sipinterface['vspa_UG']],
    ["UY",sipinterface['vspa_UY']],
    ["UZ",sipinterface['vspa_UZ']],
    ["VU",sipinterface['vspa_VU']],
    ["VA",sipinterface['vspa_VA']],
    ["VE",sipinterface['vspa_VE']],
    ["VN",sipinterface['vspa_VN']],
    ["WF",sipinterface['vspa_WF']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']]];

    var RegionRU = [
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AZ",sipinterface['vspa_AZ']],
    ["AX",sipinterface['vspa_AX']],
    ["AL",sipinterface['vspa_AL']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AS",sipinterface['vspa_AS']],
    ["AI",sipinterface['vspa_AI']],
    ["AO",sipinterface['vspa_AO']],
    ["AD",sipinterface['vspa_AD']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["AR",sipinterface['vspa_AR']],
    ["AM",sipinterface['vspa_AM']],
    ["AW",sipinterface['vspa_AW']],
    ["AF",sipinterface['vspa_AF']],
    ["BS",sipinterface['vspa_BS']],
    ["BD",sipinterface['vspa_BD']],
    ["BB",sipinterface['vspa_BB']],
    ["BH",sipinterface['vspa_BH']],
    ["BY",sipinterface['vspa_BY']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BE",sipinterface['vspa_BE']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BM",sipinterface['vspa_BM']],
    ["BG",sipinterface['vspa_BG']],
    ["BO",sipinterface['vspa_BO']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BR",sipinterface['vspa_BR']],
    ["IO",sipinterface['vspa_IO']],
    ["BN",sipinterface['vspa_BN']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["BT",sipinterface['vspa_BT']],
    ["VU",sipinterface['vspa_VU']],
    ["VA",sipinterface['vspa_VA']],
    ["HU",sipinterface['vspa_HU']],
    ["VE",sipinterface['vspa_VE']],
    ["VG",sipinterface['vspa_VG']],
    ["VI",sipinterface['vspa_VI']],
    ["UM",sipinterface['vspa_UM']],
    ["VN",sipinterface['vspa_VN']],
    ["GA",sipinterface['vspa_GA']],
    ["GY",sipinterface['vspa_GY']],
    ["HT",sipinterface['vspa_HT']],
    ["GM",sipinterface['vspa_GM']],
    ["GH",sipinterface['vspa_GH']],
    ["GP",sipinterface['vspa_GP']],
    ["GT",sipinterface['vspa_GT']],
    ["GN",sipinterface['vspa_GN']],
    ["GW",sipinterface['vspa_GW']],
    ["DE",sipinterface['vspa_DE']],
    ["GG",sipinterface['vspa_GG']],
    ["GI",sipinterface['vspa_GI']],
    ["HN",sipinterface['vspa_HN']],
    ["GD",sipinterface['vspa_GD']],
    ["GL",sipinterface['vspa_GL']],
    ["GR",sipinterface['vspa_GR']],
    ["GE",sipinterface['vspa_GE']],
    ["GU",sipinterface['vspa_GU']],
    ["DK",sipinterface['vspa_DK']],
    ["CD",sipinterface['vspa_CD']],
    ["JE",sipinterface['vspa_JE']],
    ["DJ",sipinterface['vspa_DJ']],
    ["DM",sipinterface['vspa_DM']],
    ["DO",sipinterface['vspa_DO']],
    ["EG",sipinterface['vspa_EG']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']],
    ["YE",sipinterface['vspa_YE']],
    ["IL",sipinterface['vspa_IL']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["JO",sipinterface['vspa_JO']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IR",sipinterface['vspa_IR']],
    ["IE",sipinterface['vspa_IE']],
    ["IS",sipinterface['vspa_IS']],
    ["ES",sipinterface['vspa_ES']],
    ["IT",sipinterface['vspa_IT']],
    ["CV",sipinterface['vspa_CV']],
    ["KZ",sipinterface['vspa_KZ']],
    ["KH",sipinterface['vspa_KH']],
    ["CM",sipinterface['vspa_CM']],
    ["CA",sipinterface['vspa_CA']],
    ["QA",sipinterface['vspa_QA']],
    ["KE",sipinterface['vspa_KE']],
    ["CY",sipinterface['vspa_CY']],
    ["KG",sipinterface['vspa_KG']],
    ["KI",sipinterface['vspa_KI']],
    ["KP",sipinterface['vspa_KP']],
    ["CC",sipinterface['vspa_CC']],
    ["CO",sipinterface['vspa_CO']],
    ["KM",sipinterface['vspa_KM']],
    ["CG",sipinterface['vspa_CG']],
    ["CR",sipinterface['vspa_CR']],
    ["CI",sipinterface['vspa_CI']],
    ["CU",sipinterface['vspa_CU']],
    ["KW",sipinterface['vspa_KW']],
    ["CW",sipinterface['vspa_CW']],
    ["LA",sipinterface['vspa_LA']],
    ["LV",sipinterface['vspa_LV']],
    ["LS",sipinterface['vspa_LS']],
    ["LR",sipinterface['vspa_LR']],
    ["LB",sipinterface['vspa_LB']],
    ["LY",sipinterface['vspa_LY']],
    ["LT",sipinterface['vspa_LT']],
    ["LI",sipinterface['vspa_LI']],
    ["LU",sipinterface['vspa_LU']],
    ["MU",sipinterface['vspa_MU']],
    ["MR",sipinterface['vspa_MR']],
    ["MG",sipinterface['vspa_MG']],
    ["YT",sipinterface['vspa_YT']],
    ["MW",sipinterface['vspa_MW']],
    ["MY",sipinterface['vspa_MY']],
    ["ML",sipinterface['vspa_ML']],
    ["MV",sipinterface['vspa_MV']],
    ["MT",sipinterface['vspa_MT']],
    ["MA",sipinterface['vspa_MA']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MH",sipinterface['vspa_MH']],
    ["CN",sipinterface['vspa_CN']],
    ["MX",sipinterface['vspa_MX']],
    ["FM",sipinterface['vspa_FM']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MN",sipinterface['vspa_MN']],
    ["MS",sipinterface['vspa_MS']],
    ["MM",sipinterface['vspa_MM']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NL",sipinterface['vspa_NL']],
    ["NI",sipinterface['vspa_NI']],
    ["NU",sipinterface['vspa_NU']],
    ["NZ",sipinterface['vspa_NZ']],
    ["NC",sipinterface['vspa_NC']],
    ["NO",sipinterface['vspa_NO']],
    ["AE",sipinterface['vspa_AE']],
    ["OM",sipinterface['vspa_OM']],
    ["BV",sipinterface['vspa_BV']],
    ["IM",sipinterface['vspa_IM']],
    ["NF",sipinterface['vspa_NF']],
    ["CX",sipinterface['vspa_CX']],
    ["SH",sipinterface['vspa_SH']],
    ["HM",sipinterface['vspa_HM']],
    ["KY",sipinterface['vspa_KY']],
    ["CK",sipinterface['vspa_CK']],
    ["PN",sipinterface['vspa_PN']],
    ["WF",sipinterface['vspa_WF']],
    ["PK",sipinterface['vspa_PK']],
    ["PW",sipinterface['vspa_PW']],
    ["PS",sipinterface['vspa_PS']],
    ["PA",sipinterface['vspa_PA']],
    ["PG",sipinterface['vspa_PG']],
    ["PY",sipinterface['vspa_PY']],
    ["PE",sipinterface['vspa_PE']],
    ["PL",sipinterface['vspa_PL']],
    ["PT",sipinterface['vspa_PT']],
    ["PR",sipinterface['vspa_PR']],
    ["KR",sipinterface['vspa_KR']],
    ["RE",sipinterface['vspa_RE']],
    ["RU",sipinterface['vspa_RU']],
    ["RW",sipinterface['vspa_RW']],
    ["RO",sipinterface['vspa_RO']],
    ["SV",sipinterface['vspa_SV']],
    ["WS",sipinterface['vspa_WS']],
    ["SM",sipinterface['vspa_SM']],
    ["ST",sipinterface['vspa_ST']],
    ["HK",sipinterface['vspa_HK']],
    ["MO",sipinterface['vspa_MO']],
    ["SA",sipinterface['vspa_SA']],
    ["SZ",sipinterface['vspa_SZ']],
    ["MK",sipinterface['vspa_MK']],
    ["MP",sipinterface['vspa_MP']],
    ["SC",sipinterface['vspa_SC']],
    ["BL",sipinterface['vspa_BL']],
    ["SN",sipinterface['vspa_SN']],
    ["MF",sipinterface['vspa_MF']],
    ["PM",sipinterface['vspa_PM']],
    ["VC",sipinterface['vspa_VC']],
    ["KN",sipinterface['vspa_KN']],
    ["LC",sipinterface['vspa_LC']],
    ["RS",sipinterface['vspa_RS']],
    ["SG",sipinterface['vspa_SG']],
    ["SX",sipinterface['vspa_SX']],
    ["SY",sipinterface['vspa_SY']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["GB",sipinterface['vspa_GB']],
    ["SB",sipinterface['vspa_SB']],
    ["SO",sipinterface['vspa_SO']],
    ["SD",sipinterface['vspa_SD']],
    ["SR",sipinterface['vspa_SR']],
    ["US",sipinterface['vspa_US']],
    ["SL",sipinterface['vspa_SL']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TW",sipinterface['vspa_TW']],
    ["TH",sipinterface['vspa_TH']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TC",sipinterface['vspa_TC']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["TK",sipinterface['vspa_TK']],
    ["TO",sipinterface['vspa_TO']],
    ["TT",sipinterface['vspa_TT']],
    ["TV",sipinterface['vspa_TV']],
    ["TN",sipinterface['vspa_TN']],
    ["TM",sipinterface['vspa_TM']],
    ["TR",sipinterface['vspa_TR']],
    ["UG",sipinterface['vspa_UG']],
    ["UZ",sipinterface['vspa_UZ']],
    ["UA",sipinterface['vspa_UA']],
    ["UY",sipinterface['vspa_UY']],
    ["FO",sipinterface['vspa_FO']],
    ["FJ",sipinterface['vspa_FJ']],
    ["PH",sipinterface['vspa_PH']],
    ["FI",sipinterface['vspa_FI']],
    ["FK",sipinterface['vspa_FK']],
    ["FR",sipinterface['vspa_FR']],
    ["GF",sipinterface['vspa_GF']],
    ["PF",sipinterface['vspa_PF']],
    ["TF",sipinterface['vspa_TF']],
    ["HR",sipinterface['vspa_HR']],
    ["CF",sipinterface['vspa_CF']],
    ["TD",sipinterface['vspa_TD']],
    ["ME",sipinterface['vspa_ME']],
    ["CZ",sipinterface['vspa_CZ']],
    ["CL",sipinterface['vspa_CL']],
    ["CH",sipinterface['vspa_CH']],
    ["SE",sipinterface['vspa_SE']],
    ["SJ",sipinterface['vspa_SJ']],
    ["LK",sipinterface['vspa_LK']],
    ["EC",sipinterface['vspa_EC']],
    ["GQ",sipinterface['vspa_GQ']],
    ["ER",sipinterface['vspa_ER']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["ZA",sipinterface['vspa_ZA']],
    ["GS",sipinterface['vspa_GS']],
    ["SS",sipinterface['vspa_SS']],
    ["JM",sipinterface['vspa_JM']],
    ["JP",sipinterface['vspa_JP']]];
    
    var RegionBS = [    
    ["AF",sipinterface['vspa_AF']],
    ["CF",sipinterface['vspa_CF']],
    ["ZA",sipinterface['vspa_ZA']],
    ["AL",sipinterface['vspa_AL']],
    ["DE",sipinterface['vspa_DE']],
    ["AD",sipinterface['vspa_AD']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["SA",sipinterface['vspa_SA']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AR",sipinterface['vspa_AR']],
    ["AM",sipinterface['vspa_AM']],
    ["AW",sipinterface['vspa_AW']],
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AZ",sipinterface['vspa_AZ']],
    ["BS",sipinterface['vspa_BS']],
    ["BH",sipinterface['vspa_BH']],
    ["BD",sipinterface['vspa_BD']],
    ["BB",sipinterface['vspa_BB']],
    ["BE",sipinterface['vspa_BE']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BM",sipinterface['vspa_BM']],
    ["BY",sipinterface['vspa_BY']],
    ["BO",sipinterface['vspa_BO']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BR",sipinterface['vspa_BR']],
    ["BN",sipinterface['vspa_BN']],
    ["BG",sipinterface['vspa_BG']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["BT",sipinterface['vspa_BT']],
    ["CV",sipinterface['vspa_CV']],
    ["CM",sipinterface['vspa_CM']],
    ["KH",sipinterface['vspa_KH']],
    ["CA",sipinterface['vspa_CA']],
    ["KZ",sipinterface['vspa_KZ']],
    ["TD",sipinterface['vspa_TD']],
    ["CL",sipinterface['vspa_CL']],
    ["CN",sipinterface['vspa_CN']],
    ["CY",sipinterface['vspa_CY']],
    ["SG",sipinterface['vspa_SG']],
    ["CO",sipinterface['vspa_CO']],
    ["KM",sipinterface['vspa_KM']],
    ["CG",sipinterface['vspa_CG']],
    ["CI",sipinterface['vspa_CI']],
    ["CR",sipinterface['vspa_CR']],
    ["HR",sipinterface['vspa_HR']],
    ["CU",sipinterface['vspa_CU']],
    ["CW",sipinterface['vspa_CW']],
    ["DK",sipinterface['vspa_DK']],
    ["DJ",sipinterface['vspa_DJ']],
    ["DM",sipinterface['vspa_DM']],
    ["EG",sipinterface['vspa_EG']],
    ["SV",sipinterface['vspa_SV']],
    ["AE",sipinterface['vspa_AE']],
    ["EC",sipinterface['vspa_EC']],
    ["ER",sipinterface['vspa_ER']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["ES",sipinterface['vspa_ES']],
    ["US",sipinterface['vspa_US']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["FJ",sipinterface['vspa_FJ']],
    ["PH",sipinterface['vspa_PH']],
    ["FI",sipinterface['vspa_FI']],
    ["FR",sipinterface['vspa_FR']],
    ["GA",sipinterface['vspa_GA']],
    ["GM",sipinterface['vspa_GM']],
    ["GH",sipinterface['vspa_GH']],
    ["GE",sipinterface['vspa_GE']],
    ["GI",sipinterface['vspa_GI']],
    ["GB",sipinterface['vspa_GB']],
    ["GD",sipinterface['vspa_GD']],
    ["GR",sipinterface['vspa_GR']],
    ["GL",sipinterface['vspa_GL']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GT",sipinterface['vspa_GT']],
    ["GG",sipinterface['vspa_GG']],
    ["GY",sipinterface['vspa_GY']],
    ["GF",sipinterface['vspa_GF']],
    ["GN",sipinterface['vspa_GN']],
    ["GQ",sipinterface['vspa_GQ']],
    ["GW",sipinterface['vspa_GW']],
    ["HT",sipinterface['vspa_HT']],
    ["HN",sipinterface['vspa_HN']],
    ["HU",sipinterface['vspa_HU']],
    ["YE",sipinterface['vspa_YE']],
    ["BV",sipinterface['vspa_BV']],
    ["IM",sipinterface['vspa_IM']],
    ["NF",sipinterface['vspa_NF']],
    ["AX",sipinterface['vspa_AX']],
    ["KY",sipinterface['vspa_KY']],
    ["CX",sipinterface['vspa_CX']],
    ["CC",sipinterface['vspa_CC']],
    ["CK",sipinterface['vspa_CK']],
    ["FK",sipinterface['vspa_FK']],
    ["FO",sipinterface['vspa_FO']],
    ["GS",sipinterface['vspa_GS']],
    ["HM",sipinterface['vspa_HM']],
    ["MH",sipinterface['vspa_MH']],
    ["UM",sipinterface['vspa_UM']],
    ["SB",sipinterface['vspa_SB']],
    ["TC",sipinterface['vspa_TC']],
    ["VG",sipinterface['vspa_VG']],
    ["VI",sipinterface['vspa_VI']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["IR",sipinterface['vspa_IR']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IE",sipinterface['vspa_IE']],
    ["IS",sipinterface['vspa_IS']],
    ["IL",sipinterface['vspa_IL']],
    ["IT",sipinterface['vspa_IT']],
    ["JM",sipinterface['vspa_JM']],
    ["JP",sipinterface['vspa_JP']],
    ["JE",sipinterface['vspa_JE']],
    ["JO",sipinterface['vspa_JO']],
    ["KI",sipinterface['vspa_KI']],
    ["KW",sipinterface['vspa_KW']],
    ["LA",sipinterface['vspa_LA']],
    ["LS",sipinterface['vspa_LS']],
    ["LV",sipinterface['vspa_LV']],
    ["LB",sipinterface['vspa_LB']],
    ["LR",sipinterface['vspa_LR']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["LT",sipinterface['vspa_LT']],
    ["LU",sipinterface['vspa_LU']],
    ["MK",sipinterface['vspa_MK']],
    ["MG",sipinterface['vspa_MG']],
    ["MY",sipinterface['vspa_MY']],
    ["MW",sipinterface['vspa_MW']],
    ["MV",sipinterface['vspa_MV']],
    ["ML",sipinterface['vspa_ML']],
    ["MT",sipinterface['vspa_MT']],
    ["MP",sipinterface['vspa_MP']],
    ["MA",sipinterface['vspa_MA']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MU",sipinterface['vspa_MU']],
    ["MR",sipinterface['vspa_MR']],
    ["YT",sipinterface['vspa_YT']],
    ["MX",sipinterface['vspa_MX']],
    ["MM",sipinterface['vspa_MM']],
    ["FM",sipinterface['vspa_FM']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MN",sipinterface['vspa_MN']],
    ["MS",sipinterface['vspa_MS']],
    ["ME",sipinterface['vspa_ME']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NI",sipinterface['vspa_NI']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NU",sipinterface['vspa_NU']],
    ["NO",sipinterface['vspa_NO']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["OM",sipinterface['vspa_OM']],
    ["NL",sipinterface['vspa_NL']],
    ["PW",sipinterface['vspa_PW']],
    ["PS",sipinterface['vspa_PS']],
    ["PA",sipinterface['vspa_PA']],
    ["PG",sipinterface['vspa_PG']],
    ["PK",sipinterface['vspa_PK']],
    ["PY",sipinterface['vspa_PY']],
    ["PE",sipinterface['vspa_PE']],
    ["PN",sipinterface['vspa_PN']],
    ["PF",sipinterface['vspa_PF']],
    ["PL",sipinterface['vspa_PL']],
    ["PR",sipinterface['vspa_PR']],
    ["PT",sipinterface['vspa_PT']],
    ["QA",sipinterface['vspa_QA']],
    ["KE",sipinterface['vspa_KE']],
    ["KG",sipinterface['vspa_KG']],
    ["HK",sipinterface['vspa_HK']],
    ["MO",sipinterface['vspa_MO']],
    ["CZ",sipinterface['vspa_CZ']],
    ["KR",sipinterface['vspa_KR']],
    ["CD",sipinterface['vspa_CD']],
    ["DO",sipinterface['vspa_DO']],
    ["KP",sipinterface['vspa_KP']],
    ["RE",sipinterface['vspa_RE']],
    ["RO",sipinterface['vspa_RO']],
    ["RW",sipinterface['vspa_RW']],
    ["RU",sipinterface['vspa_RU']],
    ["PM",sipinterface['vspa_PM']],
    ["WS",sipinterface['vspa_WS']],
    ["AS",sipinterface['vspa_AS']],
    ["SH",sipinterface['vspa_SH']],
    ["LC",sipinterface['vspa_LC']],
    ["BL",sipinterface['vspa_BL']],
    ["KN",sipinterface['vspa_KN']],
    ["SM",sipinterface['vspa_SM']],
    ["MF",sipinterface['vspa_MF']],
    ["ST",sipinterface['vspa_ST']],
    ["VC",sipinterface['vspa_VC']],
    ["SN",sipinterface['vspa_SN']],
    ["SL",sipinterface['vspa_SL']],
    ["RS",sipinterface['vspa_RS']],
    ["SC",sipinterface['vspa_SC']],
    ["SX",sipinterface['vspa_SX']],
    ["SY",sipinterface['vspa_SY']],
    ["SO",sipinterface['vspa_SO']],
    ["LK",sipinterface['vspa_LK']],
    ["SZ",sipinterface['vspa_SZ']],
    ["SD",sipinterface['vspa_SD']],
    ["SS",sipinterface['vspa_SS']],
    ["SE",sipinterface['vspa_SE']],
    ["CH",sipinterface['vspa_CH']],
    ["SR",sipinterface['vspa_SR']],
    ["SJ",sipinterface['vspa_SJ']],
    ["TH",sipinterface['vspa_TH']],
    ["TW",sipinterface['vspa_TW']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TZ",sipinterface['vspa_TZ']],
    ["IO",sipinterface['vspa_IO']],
    ["TF",sipinterface['vspa_TF']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["TK",sipinterface['vspa_TK']],
    ["TO",sipinterface['vspa_TO']],
    ["TT",sipinterface['vspa_TT']],
    ["TN",sipinterface['vspa_TN']],
    ["TM",sipinterface['vspa_TM']],
    ["TR",sipinterface['vspa_TR']],
    ["TV",sipinterface['vspa_TV']],
    ["UA",sipinterface['vspa_UA']],
    ["UG",sipinterface['vspa_UG']],
    ["UY",sipinterface['vspa_UY']],
    ["UZ",sipinterface['vspa_UZ']],
    ["VU",sipinterface['vspa_VU']],
    ["VA",sipinterface['vspa_VA']],
    ["VE",sipinterface['vspa_VE']],
    ["VN",sipinterface['vspa_VN']],
    ["WF",sipinterface['vspa_WF']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']]];
    
	var RegionTu = [
    ["US",sipinterface['vspa_US']],
    ["AF",sipinterface['vspa_AF']],
    ["AX",sipinterface['vspa_AX']],
    ["DE",sipinterface['vspa_DE']],
    ["UM",sipinterface['vspa_UM']],
    ["AS",sipinterface['vspa_AS']],
    ["AD",sipinterface['vspa_AD']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["AR",sipinterface['vspa_AR']],
    ["AL",sipinterface['vspa_AL']],
    ["AW",sipinterface['vspa_AW']],
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AZ",sipinterface['vspa_AZ']],
    ["BS",sipinterface['vspa_BS']],
    ["BH",sipinterface['vspa_BH']],
    ["BD",sipinterface['vspa_BD']],
    ["BB",sipinterface['vspa_BB']],
    ["BE",sipinterface['vspa_BE']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BM",sipinterface['vspa_BM']],
    ["BY",sipinterface['vspa_BY']],
    ["AE",sipinterface['vspa_AE']],
    ["BO",sipinterface['vspa_BO']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BV",sipinterface['vspa_BV']],
    ["BR",sipinterface['vspa_BR']],
    ["IO",sipinterface['vspa_IO']],
    ["BN",sipinterface['vspa_BN']],
    ["BG",sipinterface['vspa_BG']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["BT",sipinterface['vspa_BT']],
    ["GB",sipinterface['vspa_GB']],
    ["CV",sipinterface['vspa_CV']],
    ["KY",sipinterface['vspa_KY']],
    ["GI",sipinterface['vspa_GI']],
    ["DZ",sipinterface['vspa_DZ']],
    ["CX",sipinterface['vspa_CX']],
    ["DJ",sipinterface['vspa_DJ']],
    ["CC",sipinterface['vspa_CC']],
    ["CK",sipinterface['vspa_CK']],
    ["CW",sipinterface['vspa_CW']],
    ["TD",sipinterface['vspa_TD']],
    ["CZ",sipinterface['vspa_CZ']],
    ["CN",sipinterface['vspa_CN']],
    ["DK",sipinterface['vspa_DK']],
    ["CD",sipinterface['vspa_CD']],
    ["DO",sipinterface['vspa_DO']],
    ["DM",sipinterface['vspa_DM']],
    ["EC",sipinterface['vspa_EC']],
    ["GQ",sipinterface['vspa_GQ']],
    ["SV",sipinterface['vspa_SV']],
    ["ID",sipinterface['vspa_ID']],
    ["ER",sipinterface['vspa_ER']],
    ["AM",sipinterface['vspa_AM']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["FK",sipinterface['vspa_FK']],
    ["FO",sipinterface['vspa_FO']],
    ["MA",sipinterface['vspa_MA']],
    ["FJ",sipinterface['vspa_FJ']],
    ["CI",sipinterface['vspa_CI']],
    ["PH",sipinterface['vspa_PH']],
    ["PS",sipinterface['vspa_PS']],
    ["FI",sipinterface['vspa_FI']],
    ["FR",sipinterface['vspa_FR']],
    ["TF",sipinterface['vspa_TF']],
    ["GF",sipinterface['vspa_GF']],
    ["PF",sipinterface['vspa_PF']],
    ["GA",sipinterface['vspa_GA']],
    ["GM",sipinterface['vspa_GM']],
    ["GH",sipinterface['vspa_GH']],
    ["GN",sipinterface['vspa_GN']],
    ["GW",sipinterface['vspa_GW']],
    ["GD",sipinterface['vspa_GD']],
    ["GL",sipinterface['vspa_GL']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GT",sipinterface['vspa_GT']],
    ["GG",sipinterface['vspa_GG']],
    ["GY",sipinterface['vspa_GY']],
    ["ZA",sipinterface['vspa_ZA']],
    ["GS",sipinterface['vspa_GS']],
    ["SS",sipinterface['vspa_SS']],
    ["GE",sipinterface['vspa_GE']],
    ["HT",sipinterface['vspa_HT']],
    ["HM",sipinterface['vspa_HM']],
    ["HR",sipinterface['vspa_HR']],
    ["IN",sipinterface['vspa_IN']],
    ["NL",sipinterface['vspa_NL']],
    ["HN",sipinterface['vspa_HN']],
    ["HK",sipinterface['vspa_HK']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IR",sipinterface['vspa_IR']],
    ["IE",sipinterface['vspa_IE']],
    ["ES",sipinterface['vspa_ES']],
    ["IL",sipinterface['vspa_IL']],
    ["SE",sipinterface['vspa_SE']],
    ["CH",sipinterface['vspa_CH']],
    ["IT",sipinterface['vspa_IT']],
    ["IS",sipinterface['vspa_IS']],
    ["JM",sipinterface['vspa_JM']],
    ["JP",sipinterface['vspa_JP']],
    ["JE",sipinterface['vspa_JE']],
    ["KH",sipinterface['vspa_KH']],
    ["CM",sipinterface['vspa_CM']],
    ["CA",sipinterface['vspa_CA']],
    ["ME",sipinterface['vspa_ME']],
    ["QA",sipinterface['vspa_QA']],
    ["KZ",sipinterface['vspa_KZ']],
    ["KE",sipinterface['vspa_KE']],
    ["CY",sipinterface['vspa_CY']],
    ["KG",sipinterface['vspa_KG']],
    ["KI",sipinterface['vspa_KI']],
    ["CO",sipinterface['vspa_CO']],
    ["KM",sipinterface['vspa_KM']],
    ["CG",sipinterface['vspa_CG']],
    ["KR",sipinterface['vspa_KR']],
    ["KP",sipinterface['vspa_KP']],
    ["CR",sipinterface['vspa_CR']],
    ["CU",sipinterface['vspa_CU']],
    ["KW",sipinterface['vspa_KW']],
    ["MK",sipinterface['vspa_MK']],
    ["MP",sipinterface['vspa_MP']],
    ["LA",sipinterface['vspa_LA']],
    ["LS",sipinterface['vspa_LS']],
    ["LV",sipinterface['vspa_LV']],
    ["LR",sipinterface['vspa_LR']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["LT",sipinterface['vspa_LT']],
    ["LB",sipinterface['vspa_LB']],
    ["LU",sipinterface['vspa_LU']],
    ["HU",sipinterface['vspa_HU']],
    ["MG",sipinterface['vspa_MG']],
    ["MO",sipinterface['vspa_MO']],
    ["MW",sipinterface['vspa_MW']],
    ["MV",sipinterface['vspa_MV']],
    ["MY",sipinterface['vspa_MY']],
    ["ML",sipinterface['vspa_ML']],
    ["MT",sipinterface['vspa_MT']],
    ["IM",sipinterface['vspa_IM']],
    ["MH",sipinterface['vspa_MH']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MU",sipinterface['vspa_MU']],
    ["YT",sipinterface['vspa_YT']],
    ["MX",sipinterface['vspa_MX']],
    ["EG",sipinterface['vspa_EG']],
    ["FM",sipinterface['vspa_FM']],
    ["MN",sipinterface['vspa_MN']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MS",sipinterface['vspa_MS']],
    ["MR",sipinterface['vspa_MR']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MM",sipinterface['vspa_MM']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NI",sipinterface['vspa_NI']],
    ["NU",sipinterface['vspa_NU']],
    ["NF",sipinterface['vspa_NF']],
    ["NO",sipinterface['vspa_NO']],
    ["CF",sipinterface['vspa_CF']],
    ["UZ",sipinterface['vspa_UZ']],
    ["PK",sipinterface['vspa_PK']],
    ["PW",sipinterface['vspa_PW']],
    ["PA",sipinterface['vspa_PA']],
    ["PG",sipinterface['vspa_PG']],
    ["PY",sipinterface['vspa_PY']],
    ["PE",sipinterface['vspa_PE']],
    ["PN",sipinterface['vspa_PN']],
    ["PL",sipinterface['vspa_PL']],
    ["PT",sipinterface['vspa_PT']],
    ["PR",sipinterface['vspa_PR']],
    ["RE",sipinterface['vspa_RE']],
    ["RO",sipinterface['vspa_RO']],
    ["RW",sipinterface['vspa_RW']],
    ["RU",sipinterface['vspa_RU']],
    ["BL",sipinterface['vspa_BL']],
    ["SH",sipinterface['vspa_SH']],
    ["KN",sipinterface['vspa_KN']],
    ["LC",sipinterface['vspa_LC']],
    ["MF",sipinterface['vspa_MF']],
    ["PM",sipinterface['vspa_PM']],
    ["VC",sipinterface['vspa_VC']],
    ["WS",sipinterface['vspa_WS']],
    ["SM",sipinterface['vspa_SM']],
    ["ST",sipinterface['vspa_ST']],
    ["SN",sipinterface['vspa_SN']],
    ["SC",sipinterface['vspa_SC']],
    ["RS",sipinterface['vspa_RS']],
    ["SL",sipinterface['vspa_SL']],
    ["SG",sipinterface['vspa_SG']],
    ["SX",sipinterface['vspa_SX']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["SB",sipinterface['vspa_SB']],
    ["SO",sipinterface['vspa_SO']],
    ["LK",sipinterface['vspa_LK']],
    ["SD",sipinterface['vspa_SD']],
    ["SR",sipinterface['vspa_SR']],
    ["SY",sipinterface['vspa_SY']],
    ["SA",sipinterface['vspa_SA']],
    ["SJ",sipinterface['vspa_SJ']],
    ["SZ",sipinterface['vspa_SZ']],
    ["CL",sipinterface['vspa_CL']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TH",sipinterface['vspa_TH']],
    ["TW",sipinterface['vspa_TW']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["TK",sipinterface['vspa_TK']],
    ["TO",sipinterface['vspa_TO']],
    ["TT",sipinterface['vspa_TT']],
    ["TN",sipinterface['vspa_TN']],
    ["TR",sipinterface['vspa_TR']],
    ["TM",sipinterface['vspa_TM']],
    ["TC",sipinterface['vspa_TC']],
    ["TV",sipinterface['vspa_TV']],
    ["UG",sipinterface['vspa_UG']],
    ["UA",sipinterface['vspa_UA']],
    ["OM",sipinterface['vspa_OM']],
    ["UY",sipinterface['vspa_UY']],
    ["JO",sipinterface['vspa_JO']],
    ["VU",sipinterface['vspa_VU']],
    ["VA",sipinterface['vspa_VA']],
    ["VE",sipinterface['vspa_VE']],
    ["VN",sipinterface['vspa_VN']],
    ["VI",sipinterface['vspa_VI']],
    ["VG",sipinterface['vspa_VG']],
    ["WF",sipinterface['vspa_WF']],
    ["YE",sipinterface['vspa_YE']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["GR",sipinterface['vspa_GR']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']]];

    var RegionGe = [
    ["AF",sipinterface['vspa_AF']],
    ["AX",sipinterface['vspa_AX']],
    ["AL",sipinterface['vspa_AL']],
    ["DZ",sipinterface['vspa_DZ']],
    ["AS",sipinterface['vspa_AS']],
    ["AD",sipinterface['vspa_AD']],
    ["AO",sipinterface['vspa_AO']],
    ["AI",sipinterface['vspa_AI']],
    ["AQ",sipinterface['vspa_AQ']],
    ["AG",sipinterface['vspa_AG']],
    ["AR",sipinterface['vspa_AR']],
    ["AM",sipinterface['vspa_AM']],
    ["AW",sipinterface['vspa_AW']],
    ["AU",sipinterface['vspa_AU']],
    ["AT",sipinterface['vspa_AT']],
    ["AZ",sipinterface['vspa_AZ']],
    ["BS",sipinterface['vspa_BS']],
    ["BH",sipinterface['vspa_BH']],
    ["BD",sipinterface['vspa_BD']],
    ["BB",sipinterface['vspa_BB']],
    ["BY",sipinterface['vspa_BY']],
    ["BE",sipinterface['vspa_BE']],
    ["BZ",sipinterface['vspa_BZ']],
    ["BJ",sipinterface['vspa_BJ']],
    ["BM",sipinterface['vspa_BM']],
    ["BT",sipinterface['vspa_BT']],
    ["BO",sipinterface['vspa_BO']],
    ["BQ",sipinterface['vspa_BQ']],
    ["BA",sipinterface['vspa_BA']],
    ["BW",sipinterface['vspa_BW']],
    ["BV",sipinterface['vspa_BV']],
    ["BR",sipinterface['vspa_BR']],
    ["IO",sipinterface['vspa_IO']],
    ["BN",sipinterface['vspa_BN']],
    ["BG",sipinterface['vspa_BG']],
    ["BF",sipinterface['vspa_BF']],
    ["BI",sipinterface['vspa_BI']],
    ["KH",sipinterface['vspa_KH']],
    ["CM",sipinterface['vspa_CM']],
    ["CA",sipinterface['vspa_CA']],
    ["CV",sipinterface['vspa_CV']],
    ["KY",sipinterface['vspa_KY']],
    ["CF",sipinterface['vspa_CF']],
    ["TD",sipinterface['vspa_TD']],
    ["CL",sipinterface['vspa_CL']],
    ["CN",sipinterface['vspa_CN']],
    ["CX",sipinterface['vspa_CX']],
    ["CC",sipinterface['vspa_CC']],
    ["CO",sipinterface['vspa_CO']],
    ["KM",sipinterface['vspa_KM']],
    ["CG",sipinterface['vspa_CG']],
    ["CK",sipinterface['vspa_CK']],
    ["CR",sipinterface['vspa_CR']],
    ["CI",sipinterface['vspa_CI']],
    ["HR",sipinterface['vspa_HR']],
    ["CU",sipinterface['vspa_CU']],
    ["CW",sipinterface['vspa_CW']],
    ["CY",sipinterface['vspa_CY']],
    ["CZ",sipinterface['vspa_CZ']],
    ["KP",sipinterface['vspa_KP']],
    ["DK",sipinterface['vspa_DK']],
    ["DJ",sipinterface['vspa_DJ']],
    ["DM",sipinterface['vspa_DM']],
    ["DO",sipinterface['vspa_DO']],
    ["EC",sipinterface['vspa_EC']],
    ["EG",sipinterface['vspa_EG']],
    ["SV",sipinterface['vspa_SV']],
    ["GQ",sipinterface['vspa_GQ']],
    ["ER",sipinterface['vspa_ER']],
    ["EE",sipinterface['vspa_EE']],
    ["ET",sipinterface['vspa_ET']],
    ["FK",sipinterface['vspa_FK']],
    ["FO",sipinterface['vspa_FO']],
    ["FJ",sipinterface['vspa_FJ']],
    ["FI",sipinterface['vspa_FI']],
    ["FR",sipinterface['vspa_FR']],
    ["GF",sipinterface['vspa_GF']],
    ["PF",sipinterface['vspa_PF']],
    ["TF",sipinterface['vspa_TF']],
    ["GA",sipinterface['vspa_GA']],
    ["GM",sipinterface['vspa_GM']],
    ["GE",sipinterface['vspa_GE']],
    ["DE",sipinterface['vspa_DE']],
    ["GH",sipinterface['vspa_GH']],
    ["GI",sipinterface['vspa_GI']],
    ["GR",sipinterface['vspa_GR']],
    ["GL",sipinterface['vspa_GL']],
    ["GD",sipinterface['vspa_GD']],
    ["GP",sipinterface['vspa_GP']],
    ["GU",sipinterface['vspa_GU']],
    ["GT",sipinterface['vspa_GT']],
    ["GG",sipinterface['vspa_GG']],
    ["GN",sipinterface['vspa_GN']],
    ["GW",sipinterface['vspa_GW']],
    ["GY",sipinterface['vspa_GY']],
    ["HT",sipinterface['vspa_HT']],
    ["HM",sipinterface['vspa_HM']],
    ["HN",sipinterface['vspa_HN']],
    ["HK",sipinterface['vspa_HK']],
    ["HU",sipinterface['vspa_HU']],
    ["IS",sipinterface['vspa_IS']],
    ["IN",sipinterface['vspa_IN']],
    ["ID",sipinterface['vspa_ID']],
    ["IR",sipinterface['vspa_IR']],
    ["IQ",sipinterface['vspa_IQ']],
    ["IE",sipinterface['vspa_IE']],
    ["IM",sipinterface['vspa_IM']],
    ["IL",sipinterface['vspa_IL']],
    ["IT",sipinterface['vspa_IT']],
    ["JM",sipinterface['vspa_JM']],
    ["JP",sipinterface['vspa_JP']],
    ["JE",sipinterface['vspa_JE']],
    ["JO",sipinterface['vspa_JO']],
    ["KZ",sipinterface['vspa_KZ']],
    ["KE",sipinterface['vspa_KE']],
    ["KI",sipinterface['vspa_KI']],
    ["KW",sipinterface['vspa_KW']],
    ["KG",sipinterface['vspa_KG']],
    ["LA",sipinterface['vspa_LA']],
    ["LV",sipinterface['vspa_LV']],
    ["LB",sipinterface['vspa_LB']],
    ["LS",sipinterface['vspa_LS']],
    ["LR",sipinterface['vspa_LR']],
    ["LY",sipinterface['vspa_LY']],
    ["LI",sipinterface['vspa_LI']],
    ["LT",sipinterface['vspa_LT']],
    ["LU",sipinterface['vspa_LU']],
    ["MO",sipinterface['vspa_MO']],
    ["MG",sipinterface['vspa_MG']],
    ["MW",sipinterface['vspa_MW']],
    ["MY",sipinterface['vspa_MY']],
    ["MV",sipinterface['vspa_MV']],
    ["ML",sipinterface['vspa_ML']],
    ["MT",sipinterface['vspa_MT']],
    ["MH",sipinterface['vspa_MH']],
    ["MQ",sipinterface['vspa_MQ']],
    ["MR",sipinterface['vspa_MR']],
    ["MU",sipinterface['vspa_MU']],
    ["YT",sipinterface['vspa_YT']],
    ["MX",sipinterface['vspa_MX']],
    ["FM",sipinterface['vspa_FM']],
    ["MD",sipinterface['vspa_MD']],
    ["MC",sipinterface['vspa_MC']],
    ["MN",sipinterface['vspa_MN']],
    ["ME",sipinterface['vspa_ME']],
    ["MS",sipinterface['vspa_MS']],
    ["MA",sipinterface['vspa_MA']],
    ["MZ",sipinterface['vspa_MZ']],
    ["MM",sipinterface['vspa_MM']],
    ["NA",sipinterface['vspa_NA']],
    ["NR",sipinterface['vspa_NR']],
    ["NP",sipinterface['vspa_NP']],
    ["NL",sipinterface['vspa_NL']],
    ["NC",sipinterface['vspa_NC']],
    ["NZ",sipinterface['vspa_NZ']],
    ["NI",sipinterface['vspa_NI']],
    ["NE",sipinterface['vspa_NE']],
    ["NG",sipinterface['vspa_NG']],
    ["NU",sipinterface['vspa_NU']],
    ["NF",sipinterface['vspa_NF']],
    ["MK",sipinterface['vspa_MK']],
    ["MP",sipinterface['vspa_MP']],
    ["NO",sipinterface['vspa_NO']],
    ["OM",sipinterface['vspa_OM']],
    ["PK",sipinterface['vspa_PK']],
    ["PW",sipinterface['vspa_PW']],
    ["PS",sipinterface['vspa_PS']],
    ["PA",sipinterface['vspa_PA']],
    ["PG",sipinterface['vspa_PG']],
    ["PY",sipinterface['vspa_PY']],
    ["PE",sipinterface['vspa_PE']],
    ["PH",sipinterface['vspa_PH']],
    ["PN",sipinterface['vspa_PN']],
    ["PL",sipinterface['vspa_PL']],
    ["PT",sipinterface['vspa_PT']],
    ["PR",sipinterface['vspa_PR']],
    ["QA",sipinterface['vspa_QA']],
    ["KR",sipinterface['vspa_KR']],
    ["RE",sipinterface['vspa_RE']],
    ["RO",sipinterface['vspa_RO']],
    ["RU",sipinterface['vspa_RU']],
    ["RW",sipinterface['vspa_RW']],
    ["BL",sipinterface['vspa_BL']],
    ["SH",sipinterface['vspa_SH']],
    ["KN",sipinterface['vspa_KN']],
    ["LC",sipinterface['vspa_LC']],
    ["MF",sipinterface['vspa_MF']],
    ["PM",sipinterface['vspa_PM']],
    ["VC",sipinterface['vspa_VC']],
    ["WS",sipinterface['vspa_WS']],
    ["SM",sipinterface['vspa_SM']],
    ["ST",sipinterface['vspa_ST']],
    ["SA",sipinterface['vspa_SA']],
    ["SN",sipinterface['vspa_SN']],
    ["RS",sipinterface['vspa_RS']],
    ["SC",sipinterface['vspa_SC']],
    ["SL",sipinterface['vspa_SL']],
    ["SG",sipinterface['vspa_SG']],
    ["SX",sipinterface['vspa_SX']],
    ["SK",sipinterface['vspa_SK']],
    ["SI",sipinterface['vspa_SI']],
    ["SB",sipinterface['vspa_SB']],
    ["SO",sipinterface['vspa_SO']],
    ["ZA",sipinterface['vspa_ZA']],
    ["GS",sipinterface['vspa_GS']],
    ["SS",sipinterface['vspa_SS']],
    ["ES",sipinterface['vspa_ES']],
    ["LK",sipinterface['vspa_LK']],
    ["SD",sipinterface['vspa_SD']],
    ["SR",sipinterface['vspa_SR']],
    ["SJ",sipinterface['vspa_SJ']],
    ["SZ",sipinterface['vspa_SZ']],
    ["SE",sipinterface['vspa_SE']],
    ["CH",sipinterface['vspa_CH']],
    ["SY",sipinterface['vspa_SY']],
    ["TW",sipinterface['vspa_TW']],
    ["TJ",sipinterface['vspa_TJ']],
    ["TZ",sipinterface['vspa_TZ']],
    ["TH",sipinterface['vspa_TH']],
    ["CD",sipinterface['vspa_CD']],
    ["TL",sipinterface['vspa_TL']],
    ["TG",sipinterface['vspa_TG']],
    ["TK",sipinterface['vspa_TK']],
    ["TO",sipinterface['vspa_TO']],
    ["TT",sipinterface['vspa_TT']],
    ["TN",sipinterface['vspa_TN']],
    ["TR",sipinterface['vspa_TR']],
    ["TM",sipinterface['vspa_TM']],
    ["TC",sipinterface['vspa_TC']],
    ["TV",sipinterface['vspa_TV']],
    ["UG",sipinterface['vspa_UG']],
    ["UA",sipinterface['vspa_UA']],
    ["AE",sipinterface['vspa_AE']],
    ["GB",sipinterface['vspa_GB']],
    ["US",sipinterface['vspa_US']],
    ["UM",sipinterface['vspa_UM']],
    ["UY",sipinterface['vspa_UY']],
    ["UZ",sipinterface['vspa_UZ']],
    ["VU",sipinterface['vspa_VU']],
    ["VA",sipinterface['vspa_VA']],
    ["VE",sipinterface['vspa_VE']],
    ["VN",sipinterface['vspa_VN']],
    ["VG",sipinterface['vspa_VG']],
    ["VI",sipinterface['vspa_VI']],
    ["WF",sipinterface['vspa_WF']],
    ["YE",sipinterface['vspa_YE']],
    ["ZM",sipinterface['vspa_ZM']],
    ["ZW",sipinterface['vspa_ZW']]];

    for (i = 0; i < RegionEn.length; i++)
    {
        var Option = document.createElement("Option");
        if (curLanguage == "english")
        {
            if (brazclaroMode == 1) {
                if ((RegionEn[i][0] == "HK") || (RegionEn[i][0] == "TW") || (RegionEn[i][0] == "MO")) {
                    continue;
                }
            }
            Option.value = RegionEn[i][0];
            Option.innerText = RegionEn[i][1];
            Option.text = RegionEn[i][1];
        }
        if (curLanguage == "chinese")
        {
            Option.value = RegionCh[i][0];
            Option.innerText = RegionCh[i][1];
            Option.text = RegionCh[i][1];
        }
        if (curLanguage == "spanish")
        {
            Option.value = RegionSpa[i][0];
            Option.innerText = RegionSpa[i][1];
            Option.text = RegionSpa[i][1];
        }
        if (curLanguage == "arabic")
        {
            Option.value = RegionArb[i][0];
            Option.innerText = RegionArb[i][1];
            Option.text = RegionArb[i][1];
        }
        if (curLanguage == "japanese") 
        {
            Option.value = RegionJap[i][0];
            Option.innerText = RegionJap[i][1];
            Option.text = RegionJap[i][1];
        
        }
        if (curLanguage == "portuguese")
        {
            Option.value = RegionPT[i][0];
            Option.innerText = RegionPT[i][1];
            Option.text = RegionPT[i][1];
        }
    
        if (curLanguage == "russian")
        {
             Option.value = RegionRU[i][0];
            Option.innerText = RegionRU[i][1];
             Option.text = RegionRU[i][1];
        }

        if (curLanguage == "brasil")
        {
            if (brazclaroMode == 1) {
                if ((RegionBS[i][0] == "HK") || (RegionBS[i][0] == "TW") || (RegionBS[i][0] == "MO")) {
                    continue;
                }
            }
            Option.value = RegionBS[i][0];
            Option.innerText = RegionBS[i][1];
            Option.text = RegionBS[i][1];
        }

        if (curLanguage == "turkish") {
            Option.value = RegionTu[i][0];
            Option.innerText = RegionTu[i][1];
            Option.text = RegionTu[i][1];
        }

        if (curLanguage == "german") {
            Option.value = RegionGe[i][0];
            Option.innerText = RegionGe[i][1];
            Option.text = RegionGe[i][1];
        }
    
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

    var PotsNum = parseInt(PortNum,10);
    
    for (i = 1; i <= PotsNum; i++)
    {
        var Option = document.createElement("Option");
        Option.value = i;
        Option.innerText = i;
        Option.text = i;
        Control.appendChild(Option);
    }
}

function SyncAddress(Obj)
{
    
        return ;
    
    var Server_Arr = new Array("OutboundProxy","SecondaryOutboundProxy","ProxyServer","SecondProxyServer","HomeDomain");

    for(var index = 0; index < Server_Arr.length; index++)
    {
        if(document.getElementById(Server_Arr[index]) != Obj)
        {
            setText(Server_Arr[index],Obj.value);
        }
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
<li id="OutboundProxy" RealType="TextBox" DescRef="vspa_outbanproxy" RemarkRef="vspa_outbandproxyhint" ErrorMsgRef="Empty" Require="FALSE" BindField="OutboundProxy" InitValue="Empty" MaxLength="256"/>
<li id="OutboundProxyPort" RealType="TextBox" DescRef="vspa_outbandport" RemarkRef="vspa_outbandporthint" ErrorMsgRef="Empty" Require="FALSE" BindField="OutboundProxyPort" InitValue="Empty" MaxLength="256"/>
<li id="SecondaryOutboundProxy" RealType="TextBox" DescRef="vspa_stoutproxy" RemarkRef="vspa_outbandproxyhint" ErrorMsgRef="Empty" Require="FALSE" BindField="SecondaryOutboundProxy" InitValue="Empty" MaxLength="256"/>
<li id="SecondaryOutboundProxyPort" RealType="TextBox" DescRef="vspa_stoutport" RemarkRef="vspa_outbandporthint" ErrorMsgRef="Empty" Require="FALSE" BindField="SecondaryOutboundProxyPort" InitValue="Empty" MaxLength="256"/>
<li id="ProxyServer" RealType="TextBox" DescRef="vspa_proxy" RemarkRef="vspa_outbandproxyhint" ErrorMsgRef="Empty" Require="FALSE" BindField="ProxyServer" InitValue="Empty" MaxLength="256"/>
<li id="ProxyServerPort" RealType="TextBox" DescRef="vspa_proxyport" RemarkRef="vspa_outbandporthint" ErrorMsgRef="Empty" Require="FALSE" BindField="ProxyServerPort" InitValue="Empty" MaxLength="11"/>
<li id="SecondProxyServer" RealType="TextBox" DescRef="vspa_stproxy" RemarkRef="vspa_outbandproxyhint" ErrorMsgRef="Empty" Require="FALSE" BindField="SecondProxyServer" InitValue="Empty" MaxLength="256"/>
<li id="SecondProxyServerPort" RealType="TextBox" DescRef="vspa_stport" RemarkRef="vspa_outbandporthint" ErrorMsgRef="Empty" Require="FALSE" BindField="SecondProxyServerPort" InitValue="Empty" MaxLength="11"/>
<script language="JavaScript" type="text/javascript">
    if('GLOBE2WIFI' == CfgModeWord.toUpperCase())
    {
        document.write("\<li id=\"HomeDomain\" RealType=\"TextBox\" DescRef=\"vspa_homedomain\" RemarkRef=\"vspa_outbandproxyhint\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"HomeDomain\" InitValue=\"Empty\" MaxLength=\"256\" ClickFuncApp=\"onKeyUp=SyncAddress\"\/\> ");
    }

    if (CfgModeWord.toUpperCase() == 'ROSUNION')
    {
        document.write("\<li id=\"RegistrarServer\" RealType=\"TextBox\" DescRef=\"vspa_regisserver\" RemarkRef=\"vspa_outbandproxyhint\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"RegistrarServer\" InitValue=\"Empty\" MaxLength=\"256\" ClickFuncApp=\"onKeyUp=SyncAddress\"\/\> ");
        document.write("\<li id=\"UserAgentDomain\" RealType=\"TextBox\" DescRef=\"vspa_uadomain\" RemarkRef=\"vspa_outbandproxyhint\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"HomeDomain\" InitValue=\"Empty\" MaxLength=\"256\" ClickFuncApp=\"onKeyUp=SyncAddress\"\/\> ");
        document.write("\<li id=\"RegisterRetryInterval\" RealType=\"TextBox\" DescRef=\"vspa_regretryinterval\" RemarkRef=\"vspa_regretryintervalhint\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"RegisterRetryInterval\" InitValue=\"Empty\" MaxLength=\"11\"\/\> ")

	}
    else
    {
        document.write("\<li id=\"HomeDomain\" RealType=\"TextBox\" DescRef=\"vspa_homedomain\" RemarkRef=\"vspa_outbandproxyhint\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"HomeDomain\" InitValue=\"Empty\" MaxLength=\"256\"\/\> ");
    }

    if (CfgModeWord.toUpperCase() == 'OTE') {
        document.write("\<li id=\"UserAgentDomain\" RealType=\"TextBox\" DescRef=\"vspa_uadomain\" RemarkRef=\"vspa_outbandproxyhint\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"HomeDomain\" InitValue=\"Empty\" MaxLength=\"256\" ClickFuncApp=\"onKeyUp=SyncAddress\"\/\> ");
    }
</script>
<li id="UserAgentPort" RealType="TextBox" DescRef="vspa_loport" RemarkRef="vspa_localporthint" ErrorMsgRef="Empty" Require="TRUE" BindField="UserAgentPort" InitValue="Empty" MaxLength="11"/>
<script language="JavaScript" type="text/javascript">
    if (rosUnionGame == 1) {
        document.write("\<li id=\"DigitMap\" RealType=\"TextArea\" DescRef=\"vspa_digmap\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"DigitMap\" InitValue=\"Empty\" Elementclass=\"interfacetextrosgameclass\"\/\>");
    } else {
        document.write("\<li id=\"DigitMap\" RealType=\"TextArea\" DescRef=\"vspa_digmap\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"DigitMap\" InitValue=\"Empty\" Elementclass=\"interfacetextclass\"\/\>");
    }
</script>
<li id="X_HW_DigitMapMatchMode" RealType="DropDownList" DescRef="vspa_digmatchmode" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="X_HW_DigitMapMatchMode" InitValue="[{TextRef:'vspa_minmat',Value:'Min'},{TextRef:'vspa_maxmat',Value:'Max'}]"/>
<li id="RegistrationPeriod" RealType="TextBox" DescRef="vspa_regperiod" RemarkRef="vspa_regperiodhint" ErrorMsgRef="Empty" Require="FALSE" BindField="RegistrationPeriod" InitValue="Empty" MaxLength="11"/>
<li id="X_HW_PortName" RealType="DropDownList" DescRef="vspa_sigport" RemarkRef="vspa_sigporthint" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" Elementclass="restrict_dir_ltr"/>
<li id="X_HW_PortName_RTP" RealType="DropDownList" DescRef="vspa_meiport" RemarkRef="vspa_meiporthint" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty" Elementclass="restrict_dir_ltr"/>
<li id="Region" RealType="DropDownList" DescRef="vspa_Region" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Region" InitValue="Empty"/>
<script>
var VoipConfigFormList1 = HWGetLiIdListByForm("voipbasic", null);
HWParsePageControlByID("voipbasic", TableClass, sipinterface, null);
var VoipBasicParaSetArray = new Array();
if(0 == SingTelMode)
{
    DropDownListSelect("X_HW_PortName",WanInfo);
    DropDownListSelect("X_HW_PortName_RTP",WanInfo);
}
RegionSelect("Region");
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

<script>
    if (ringPrlflag) {
        document.write('<li id="PhyReferenceList" RealType="CheckBoxList" DescRef="vspa_asspot" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PhyReferenceList" InitValue="[{TextRef:\'vspa_pots1\',Value:\'vspa_potIns1\'}, {TextRef:\'vspa_pots2\',Value:\'vspa_potIns2\'}]"/>');
    } else {
        document.write('<li id="PhyReferenceList" RealType="DropDownList" DescRef="vspa_asspot" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PhyReferenceList" InitValue="Empty"/>');
    }

	if(ProductType != 2) {
	document.write('<li id="AuthUserName" RealType="TextBox" DescRef="vspa_authname" RemarkRef="vspa_authnamehint" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthUserName" InitValue="Empty" Elementclass="lineclass"/>');
	document.write('<li id="AuthPassword" RealType="TextBox" DescRef="vspa_paasw" RemarkRef="vspa_passwdhint" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthPassword" InitValue="Empty" Elementclass="lineclass"/>');
	}
	else{
		document.write('<li id="AuthUserName" RealType="TextBox" DescRef="vspa_authname" RemarkRef="vspa_authnamehint_xd" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthUserName" InitValue="Empty" Elementclass="lineclass"/>');
		document.write('<li id="AuthPassword" RealType="TextBox" DescRef="vspa_paasw" RemarkRef="vspa_passwdhint_xd" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthPassword" InitValue="Empty" Elementclass="lineclass"/>');	
	}	
</script>
<script>
var VoipConfigFormList2 = HWGetLiIdListByForm("ConfigForm1", null);
HWParsePageControlByID("ConfigForm1", TableClass, sipinterface, null);
if (ringPrlflag) {
    var phy = document.getElementById("PhyReferenceListCol");
    phy.append("\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0 (incoming pots)");
} else {
    DropDownLineListSelect("PhyReferenceList",AllPhyInterface);
}

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
