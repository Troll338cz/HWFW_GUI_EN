<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<title>Device Access Precise Control Configuration</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="/html/bbsp/common/userinfo.asp"></script>
<script language="javascript" src="/html/bbsp/common/topoinfo.asp"></script>
<script language="javascript" src="/html/amp/common/wlan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/managemode.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>
<script language="javascript" src="/html/bbsp/common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="/html/bbsp/common/wan_check.asp"></script>
<style>
#wanipStart ,#wanipEnd
{
    width:124px;
}
#desnote
{
    color: #767676;
}
#serviceProtocol
{
    width:80px;
}
</style>
<script>
    
var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();
var ProductType = '<%HW_WEB_GetProductType();%>';
var LanNameList = new Array();
var SSIDNameList =  GetRealSSIDList();
var stbPort = '<%HW_WEB_GetSTBPort();%>';
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
var supportIPTVPort = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var EthNum = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Topo.X_HW_EthNum);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var COMMONV5FirewallFT = '<%HW_WEB_GetFeatureSupport(BBSP_FT_FIREWALL_COMMONV5);%>';
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var isSupportHybrid = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HYBRID);%>';
var IsSupportLanAsWan = '<%HW_WEB_GetFeatureSupport(FT_LAN_AS_WAN);%>';
var checkWeakPwdFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_CHECK_WEAKPWD);%>';
var reqFile = "html/bbsp/portacl/newacl.asp";
var defaultPwd = "********************************";
var modifiedPwd = 0;
var notSetPwd = 0;
var securityAccessFlag = '<%HW_WEB_GetFeatureSupport(FT_SECURITY_ACCESS);%>';
var securityInAccessFlag = '<%HW_WEB_GetFeatureSupport(FT_WAN_ACCESS_IN_SECURITY);%>';
var disableUnsafePro = '<%HW_WEB_GetFeatureSupport(FT_DISABLE_UNSAFE_PROTOCOL);%>';
var isDebugMode ='<%WEB_GetDebugMode();%>';
var secCodeLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>'
var telnetIndex;
var upMode = '<%HW_WEB_GetUpMode();%>';
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
var disableWifi = '<%HW_WEB_GetFeatureSupport(FT_DISABLE_WIFI);%>';
var isWanAccess = '<%HW_WEB_GetFeatureSupport(FT_WEB_WAN_ACCESS);%>';
var XD_PRODUCT_TYPE = "2";
var selectServicePro = "ALL";
var noticeSelectService = 0;
var isDnzvdf = '<%HW_WEB_GetFeatureSupport(FT_MNGT_DNZVDF);%>';
var isMapFlag = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_MAP);%>';
var mapEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_IPv6Transition.MAP.Enable);%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var novaUserType = curUserType;
var upportfeature ='<%HW_WEB_GetFeatureSupport(FT_AP_WEB_SELECT_UPPORT);%>';
var isSupportUSB = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_USB);%>';

EthNum = parseInt(EthNum);
if (upportfeature == 1) {
    EthNum = EthNum - 1;
}

if (["DCORIOLIS2WIFI", "DSAZAIN2WIFI", "DRDS2WIFI"].indexOf(CfgMode.toUpperCase()) >= 0) {
    EthNum = '<%GetLanPortNum();%>';
}
var upLinkLanPort ='<%HW_WEB_GetFeatureSupport(FT_WEB_NOSHOW_UPLINK_LAN);%>';
if (((securityAccessFlag == '1') && (securityInAccessFlag == '0')) && (isWanAccess == '0')) {
    isWanAccess = '1';
}

if (CfgMode.toUpperCase() == "TURKCELL2") {
    reqFile = "remote/aclconfig.html";
}

function IsDisableUnsafeProtocol()
{
	if ((securityAccessFlag == '1') && (disableUnsafePro == '1') && (isDebugMode != '1')) {
		return true;
	}
	return false;
}

function stConfigPort(domain,X_HW_MainUpPort)
{
	this.domain = domain;
	this.X_HW_MainUpPort = X_HW_MainUpPort;
}

var PortConfigInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo,X_HW_MainUpPort,stConfigPort);%>;
var PortConfigInfo = PortConfigInfos[0];
var MainUpPort = PortConfigInfo.X_HW_MainUpPort;

var lanCtrlCheckBoxNum = parseInt(EthNum) + 1;
var lanIDCheckBoxNum = 9;
var ssidIDCheckBoxNum = 9;
var stbPortId = parseInt(stbPort) + 1;

var TableName = "PortAclConfigList";
var AddFlag = false;
var PortAclIndex = -1;

var modeValue = 0;
var IsBin5 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_IS_BIN5);%>';

var PortTypeList = ["LAN", "SSID", "WAN"];
var protocolArr = ['TELNET','HTTP', 'SSH','FTP','ICMP','SAMBA'];
if (["DBAA1", "MOLDTEL2", "COMTECOEBG4"].indexOf(CfgMode.toUpperCase()) >= 0) {
    protocolArr = ['TELNET','HTTP', 'HTTPS', 'SSH','FTP','ICMP','SAMBA'];
} else if (CfgMode.toUpperCase() == "EGVDF2") {
    protocolArr = ['HTTP','FTP','ICMP','SAMBA'];
} else if (IsTedata == 1) {
    PortTypeList = ["LAN", "SSID"];
    protocolArr = ['FTP','ICMP','SAMBA'];
} else if (CfgMode.toUpperCase() == 'DMASMOVIL2WIFI') {
    protocolArr = ['HTTP','FTP','ICMP','SAMBA'];
} else if (IsDisableUnsafeProtocol()) {
    if (isSupportUSB == '0') {
        protocolArr = ['SSH','ICMP'];
    } else {
        protocolArr = ['SSH','SFTP','ICMP','SAMBA'];
    }
} else if ((IsBin5 == '1') || (isSupportUSB == '0')) {
    protocolArr = ['TELNET','HTTP','SSH','ICMP'];
} else if (isDnzvdf == 1) {
    protocolArr = ['HTTP','ICMP'];
}
var portBindName = {'LAN1':'ALL LAN','LAN2':'LAN1','LAN3':'LAN2','LAN4':'LAN3','LAN5':'LAN4','LAN6':'LAN5','LAN7':'LAN6','LAN8':'LAN7','LAN9':'LAN8','SSID1':'ALL SSID','SSID2':'SSID1','SSID3':'SSID2','SSID4':'SSID3','SSID5':'SSID4','SSID6':'SSID5','SSID7':'SSID6','SSID8':'SSID7','SSID9':'SSID8'};
var portBindNoAllName = {'LAN2':'LAN1','LAN3':'LAN2','LAN4':'LAN3','LAN5':'LAN4','LAN6':'LAN5','LAN7':'LAN6','LAN8':'LAN7','LAN9':'LAN8','SSID2':'SSID1','SSID3':'SSID2','SSID4':'SSID3','SSID5':'SSID4','SSID6':'SSID5','SSID7':'SSID6','SSID8':'SSID7','SSID9':'SSID8'};
var LanguageAllDisplay = {'0':'bbsp_alllan','1':'bbsp_allssid','2':'bbsp_allwan'};

function CheckProtoPort(portType, protocolPort)
{
    if (CfgMode.toUpperCase() != "EGVDF2") {
        return true;
    }

    var portArray = ["22", "23"];
    if (portType == 2) {
        portArray = ["22", "23", "80", "443"];
    }

    var protoPortSegArr = [];
    var protoPortArr = [];
    var port;
    var startPort;
    var endPort;
    protoPortSegArr = protocolPort.split(',');
    for (var idx = 0; idx < protoPortSegArr.length; ++idx) {
        if (protoPortSegArr[idx] == '') {
            continue;
        }

        protoPortArr = protoPortSegArr[idx].split(':');
        if (protoPortArr.length == 2) {
            startPort = parseInt(protoPortArr[0], 10);
            endPort = parseInt(protoPortArr[1], 10);
            for (var i = 0; i < portArray.length; i++) {
                port = parseInt(portArray[i], 10);
                if ((startPort <= port) && (port <= endPort)) {
                    AlertEx('Error: Invalid port ID. Port ' + portArray[i] + ' is not allowed.');
                    return false;
                }
            }
        } else if (protoPortArr.length == 1) {
            if (portArray.indexOf(protoPortArr[0]) >= 0) {
                AlertEx('Error: Invalid port ID. Port ' + protoPortArr[0] + ' is not allowed.');
                return false;
            }
        }
    }

    return true;
}

function getIsHaveHiddenPort()
{ 
   if(UpUserPortID >5) 
   {
       return 0;
   } 
   else
   {
       return 1;
   }
}

function stLanInfo(domain,name)
{
    this.domain = domain ;
    this.name = name;
}

for (var i = 1;i <= EthNum;i++)
{
    LanNameList.push(new stLanInfo('InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.' + i,'LAN' + i));
}

function stNewAclEnable(domain,enable)
{
    this.domain = domain;
    this.enable = enable;
}

function stNewDeviceAcl(domain, SrcPortType, SrcPortName, Protocol, Priority, ServiceProto, ServiceProtoPort, Mode,
                        SrcIp, DynamicWanServiceType)
{
    this.domain = domain;
    this.SrcPortType = SrcPortType ;
    this.SrcPortName = SrcPortName;
    this.Protocol = Protocol;
    this.Priority = Priority;
    this.ServiceProto = ServiceProto;
    this.ServiceProtoPort = ServiceProtoPort;
    this.Mode = Mode;
    this.SrcIp = SrcIp;
    this.DynamicWanServiceType = DynamicWanServiceType;
}

var NewAclEnableInfo =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.AclServices.AccessControl,AccessControlListEnable,stNewAclEnable);%>;

if (NewAclEnableInfo[0] == null)
{
   NewAclEnableInfo[0] = new stNewAclEnable("","");
}

var NewDeviceAclListInfoTmp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.AclServices.AccessControl.List.{i},SrcPortType|SrcPortName|ServicePort|Priority|ServiceProto|ServiceProtoPort|Mode|SrcIp|DynamicWanServiceType,stNewDeviceAcl);%>;

var NewDeviceAclListInfo = new Array();

function CheckServiceProtoICMP(NewDeviceAclInfoTmp) {
    if ((NewDeviceAclInfoTmp.ServiceProto == "") || (NewDeviceAclInfoTmp.ServiceProto == null)) {
            return false;
        }
    var protocolList = NewDeviceAclInfoTmp.ServiceProto.split(",");
    for (var loop = 0; loop < protocolList.length; loop++) {
        var curProtocol = protocolList[loop].toUpperCase();
        if (curProtocol != "ICMP" && curProtocol != "ICMPV6") {
            return false;
        }
    }
    return true;
}
for (var i = 0;i < NewDeviceAclListInfoTmp.length-1;i++)
{
    var aclInfo = NewDeviceAclListInfoTmp[i];
    if (CheckServiceProtoICMP(aclInfo)) {
        aclInfo.ServiceProtoPort = "--";
    }
    if (isWanAccess == "0") {
        if ((aclInfo.SrcPortType != 2) || (aclInfo.Protocol == "ICMP") || (CheckServiceProtoICMP(aclInfo) == true)) {
            if ((ProductType != XD_PRODUCT_TYPE) || (aclInfo.Protocol.toUpperCase().indexOf("ACS") == -1)) {
                NewDeviceAclListInfo.push(aclInfo);
            }
        }
    } else {
        if ((ProductType != XD_PRODUCT_TYPE) || (aclInfo.Protocol.toUpperCase().indexOf("ACS") == -1)) {
            NewDeviceAclListInfo.push(aclInfo);
        }
    }
}
NewDeviceAclListInfo.push(null);

function GetTelnetChecked()
{
    for (var i = 1; i <= protocolArr.length; i ++) {
        if (getElement("Protocol" + i).value == 'TELNET') {
            return getElement("Protocol" + i).checked;
        }
    }
    return false;
}

function GetSshChecked()
{
    for (var i = 1; i <= protocolArr.length; i ++) {
        if (getElement("Protocol" + i).value == 'SSH') {
            return getElement("Protocol" + i).checked;
        }
    }
    return false;
}

function GetHTTPChecked()
{
    for (var i = 1; i <= protocolArr.length; i ++) {
        if (getElement("Protocol" + i).value == 'HTTP') {
            return getElement("Protocol" + i).checked;
        }
    }
    return false;
}

function GetHTTPSChecked()
{
    for (var i = 1; i <= protocolArr.length; i ++) {
        if (getElement("Protocol" + i).value == 'HTTPS') {
            return getElement("Protocol" + i).checked;
        }
    }
    return false;
}

function CheckEnableProtocolType(index)
{
    if (CfgMode.toUpperCase() != 'EGVDF2') {
        return;
    }

    var unsafePclStr = "HTTP,FTP,ICMP,SAMBA,UPNP";
    var confirmStr = "Enabling ";
    var protocolType = getElement("Protocol" + index).value;

    if (unsafePclStr.indexOf(protocolType) >= 0) {
        $("#Protocol" + index).unbind("click");
        $("#Protocol" + index).click(function()
        {
            var confirmStr = port_acl_language['bbsp_confirm_protocol_enable'] + protocolType + port_acl_language['bbsp_confirm_protocol_right'];
            if (getElement("Protocol" + index).checked == true) {
                if (ConfirmEx(confirmStr) == false) {
                    setCheck("Protocol" + index, 0);
                    return;
                }
            }
        });
    }
}

function clickAll()
{    
    $("#LAN1").unbind("click");
    $("#LAN1").click(function()
    {
        if (getElement("LAN1").checked)
        {
            setCrtlCheck(1);
        }
        else
        {
            setCrtlCheck(0);
        }    
            
    });
    
    $("#SSID1").unbind("click");
    $("#SSID1").click(function()
    {
        if (getElement("SSID1").checked)
        {
            setCrtlCheck(1);
        }
        else
        {
            setCrtlCheck(0);
        }    
            
    });

    for (var i = 1; i <= protocolArr.length; i ++) {
        CheckEnableProtocolType(i);
        if (getElement("Protocol" + i).value == 'TELNET') {
            telnetIndex = i;
            $("#Protocol" + i).unbind("click");
            $("#Protocol" + i).click(function()
            {
                if (GetTelnetChecked() == true) {
                    if (ConfirmEx(port_acl_language['bbsp_confirm_telnet']) == false) {
                        setCheck("Protocol" + telnetIndex, 0);
                        return;
                    }
                }
                if (GetTelnetChecked() || GetSshChecked()) {
                    setDisplay('telnetpasswordRow', 1);
                    setDisplay('CfmtelnetpasswordRow', 1);
                } else {
                    setDisplay('telnetpasswordRow', 0);
                    setDisplay('CfmtelnetpasswordRow', 0);
                }
                if (modifiedPwd == 0) {
                    setText("telnetpassword", '');
                    setText("Cfmtelnetpassword", '');
                } else {
                    setText("telnetpassword", defaultPwd);
                    setText("Cfmtelnetpassword", defaultPwd);
                }
            });
        }
    }

    for (var i = 1; i <= protocolArr.length; i ++) {
        if (getElement("Protocol" + i).value == 'SSH') {
            $("#Protocol" + i).unbind("click");
            $("#Protocol" + i).click(function()
            {
                if (GetTelnetChecked() || GetSshChecked()) {
                    setDisplay('telnetpasswordRow', 1);
                    setDisplay('CfmtelnetpasswordRow', 1);
                } else {
                    setDisplay('telnetpasswordRow', 0);
                    setDisplay('CfmtelnetpasswordRow', 0);
                }
                if (modifiedPwd == 0) {
                    setText("telnetpassword", '');
                    setText("Cfmtelnetpassword", '');
                } else {
                    setText("telnetpassword", defaultPwd);
                    setText("Cfmtelnetpassword", defaultPwd);
                }
            });
        }
    }

    if (CfgMode.toUpperCase() == "COMTECOEBG4") {
        for (var i = 1; i <= protocolArr.length; i ++) {
            if (getElement("Protocol" + i).value == 'HTTP') {
                httpsIndex = i + 1;
                $("#Protocol" + i).unbind("click");
                $("#Protocol" + i).click(function()
                {
                    if (GetHTTPChecked() == true) {
                        setCheck("Protocol" + httpsIndex, 1);
                    }
                });
            }
        }

        for (var i = 1; i <= protocolArr.length; i ++) {
            if (getElement("Protocol" + i).value == 'HTTPS') {
                httpIndex = i - 1;
                $("#Protocol" + i).unbind("click");
                $("#Protocol" + i).click(function()
                {
                    if (GetHTTPSChecked() == false) {
                        setCheck("Protocol" + httpIndex, 0);
                    }
                });
            }
        }
    }

    for (var port in portBindNoAllName)
    {
        $("#" + port).unbind("click");
        $("#" + port).click(function()
        {
            for(var port in portBindNoAllName)
            {
                var portStr = port.substring(0,port.length-1);
                        
                if (getElement(port).checked)
                { 
                    setCheck(port,1);
                    setCheck(portStr + '1',0);
                }
                else
                {
                    setCheck(port,0);
                }
                
            }
        });
    }
}
    
function OnPageLoad()
{   
    setCheck("radionewacl1",1);
    setDisableWanAclTableList();
    radioClick();
    setDisplay("serviceProtocolRow",0);
    setDisplay("servicePortRow",0);
	if (IsTedata == 1)
	{
		setDisplay("radionewaclRow",0);
		for (var i = 0; i < NewDeviceAclListInfo.length - 1; i++)
		{
			if (NewDeviceAclListInfo[i].ServiceProto != "")
			{
				setDisable('PortAclConfigList_rml' + i, 1);
			}
		}
	}
    CheckCliPasswordModified();
    OnChangePortType();
}

function GetPortNameDomian(id,porttype)
{
    var portdomain = "";

    if (0 == porttype)
    {
        for (var i = 0 ; i< EthNum ; i++)
        {
            if(id == LanNameList[i].name)
            {
                portdomain = LanNameList[i].domain;
                break;
            }
        }
    }
    else if (1 == porttype)
    {
        for (var i = 0 ; i< SSIDNameList.length ; i++)
        {
            if (id == SSIDNameList[i].name)
            {
                portdomain = SSIDNameList[i].domain;
                break;
            }
        }
    }
    else
    {
        return "";
    }
    
    return portdomain;
}

function GetSelectedWan(wandomain)
{
    var WanList = GetWanList();
    var i = 0;

    for (i = 0; i < WanList.length; i++)
    {
        var wandomainValue = WanList[i].domain;
            
        if (wandomain.indexOf(wandomainValue) >= 0)
        {
            return WanList[i];
        }
    }
    return null;
}

function GetSrcPortListID(srcporttype)
{
    var portnamelistid = new Array();
    
    if (0 == srcporttype )
    {
        for (var i = 1 ; i<= EthNum ; i++)
        {
            portnamelistid[i-1] = LanNameList[i-1].name;
        }
    }
    else if (1 == srcporttype)
    {
        for (var i = 0 ; i< SSIDNameList.length ; i++)
        {
            portnamelistid[i] = SSIDNameList[i].name;
        }
    }
    
    return portnamelistid;
}

function GetSplitList(splitlist)
{
    var splitlist = splitlist.split(",");
    var tmplist = new Array();
    var index = 0;

    for (var i = 0; i < splitlist.length; i++)
    {
        if (splitlist[i] != "")
            tmplist[index++] = splitlist[i];
    }
    return tmplist;
}

function GetSrcPortID(domain, srcporttype)
{
    var portnameid;
    
    if (0 == srcporttype)
    {
        for (var i = 0 ; i< EthNum ; i++)
        {
            var landomainValue = LanNameList[i].domain;
            
            if (domain.indexOf(landomainValue) >= 0)
            {    
                portnameid = LanNameList[i].name;
                if (stbPort == (i+1))
                {
                    portnameid = port_acl_language['bbsp_stb'];
                }
                break;
            }
        }
    }
    else if (1 == srcporttype)
    {
        for (var i = 0 ; i< SSIDNameList.length ; i++)
        {
            
            var ssiddomainValue = SSIDNameList[i].domain;
            
            if (domain.indexOf(ssiddomainValue) >= 0)
            {
                portnameid = SSIDNameList[i].name;
                break;
            }
        }
    }

    return portnameid.toString();
}

function getIPV4BoundMask(maskValue, isMinMask)
{
    var IPMaskList = new Array();
    var tempMask = "";
    var i = 0;
    var MaskBit1 = "0";
    var MaskBit2 = "1";
    
    if (maskValue < 0 && maskValue > 32)
    {
        return null;
    }
    
    if (isMinMask)
    {
        MaskBit1 = "1";
        MaskBit2 = "0";
    }
    
    for (i = 0; i < 32; i++)
    {
        if(i < maskValue)
        {
            tempMask = tempMask + MaskBit1;
            continue; 
        }
        
        tempMask = tempMask + MaskBit2;
    }
        
    i = 0;
    while (i < 32)
    {
        ipmask = tempMask.substring(i, i + 8);
        ipmask = parseInt(ipmask,2).toString(10);
        IPMaskList.push(ipmask);
        i = i + 8;
    }
    
    return IPMaskList;
}

function getIPV4BoundIP(IPList, MinMaskList, isMinMask)
{
    var tempIP = "";
    var IPSection = "";
    
    for (var i = 0; i < IPList.length; i++)
    {
        if (isMinMask)
        {
            IPSection = IPList[i] & MinMaskList[i];
        }
        else
        {
            IPSection = IPList[i] | MinMaskList[i];
        }
        
        if (i == IPList.length -1)
        {
            if(isMinMask)
            {
                IPSection = IPSection + 1;
            }
            else
            {
                IPSection = IPSection - 1;
            }
        }
        
        if (tempIP.length == 0)
        {
            tempIP = IPSection;
        }
        else
        {
            tempIP = tempIP + "." + IPSection;
        }    
    }
    
    return tempIP;
}

function IPv4AddrMaskTansform(ipmask)
{
    var i = 0;
    var ipmaskvalue = ipmask.split("/");
    var ip = ipmaskvalue[0];
    var mask = ipmaskvalue[1];    
    var iprange = ip.split(".");
    var minIPInfo = "";
    var maxIPInfo = "";
    var minMaskList = getIPV4BoundMask(mask, true);
    var maxMaskList = getIPV4BoundMask(mask, false);
    
    if (ipmaskvalue.length != 2)
    {
        return "";
    }
    
    if (iprange.length != 4)
    {
        return "";
    }
    if (mask == 32)
    {
        minIPInfo = ip;
        maxIPInfo = ip;
    }
    else if (mask == 31)
    {
        minIPInfo = getIPV4BoundIP(iprange, maxMaskList, false);
        maxIPInfo = getIPV4BoundIP(iprange, minMaskList, true);
    }
    else
    {
        minIPInfo = getIPV4BoundIP(iprange, minMaskList, true);
        maxIPInfo = getIPV4BoundIP(iprange, maxMaskList, false);
    }
    return minIPInfo + "-" + maxIPInfo;  
}

function getIPv6BoundMask(maskValue, isMinMask)
{
    var IPv6MaskList = new Array();
    var tempMask = "";
    var i = 0;
    var MaskBit1 = "0";
    var MaskBit2 = "1";
    
    if (maskValue < 0 && maskValue > 128)
    {
        return null;
    }
    
    if (isMinMask)
    {
        MaskBit1 = "1";
        MaskBit2 = "0";
    }
    
    for (i = 0; i < 128; i++)
    {
        if (i < maskValue)
        {
            tempMask = tempMask + MaskBit1;
            continue; 
        }
        
        tempMask = tempMask + MaskBit2;
    }
        
    i = 0;
    while (i < 128)
    {
        var ipmask = tempMask.substring(i, i + 16);
        IPv6MaskList.push(ipmask);
        i = i + 16;
    }
    
    return IPv6MaskList;
}

function GetIPv4BoundAddrFromIPV6Section(IPV4Adrr, Mask1, Mask2, isMinIP)
{
    var DestIPV4 = "";
    var MaskSectionList = new Array();
    var TempMask = Mask1 + Mask2;
    var i = 0;
    
    while (i < 32)
    {
        var ipmask = TempMask.substring(i, i + 8);
        ipmask = parseInt(ipmask,2).toString(10);
        MaskSectionList.push(ipmask);
        i = i + 8;
    }
    
    var IPV4SectionList = IPV4Adrr.split(".");
    DestIPV4 = getIPV4BoundIP(IPV4SectionList, MaskSectionList, isMinIP);
    
    return DestIPV4;
}

function getIPv6BoundAddr(IPV6List, IPv6MaskList, isMinIP)
{
    var IPv4Addr = "";
    var IPv6Addr = "";
    var IPv6Section = "";
    var TempIPV6MaskSection;
    var IPV6AddrList = IPV6AddressTansfrom(IPV6List);
    var IPV6Length = IPV6AddrList.length;
    var MaskLength = IPv6MaskList.length;
    var tempLength = IPV6Length;
    
    if (IPV6Length != MaskLength)
    {
        tempLength = tempLength - 1;
        IPv4Addr = GetIPv4BoundAddrFromIPV6Section(IPV6AddrList[IPV6Length - 1], IPv6MaskList[MaskLength - 2], IPv6MaskList[MaskLength - 1], isMinIP);
    }

    for (var i = 0; i < tempLength; i++)
    {
        TempIPV6MaskSection = parseInt(IPv6MaskList[i],2).toString(10);
        
        if (isMinIP)
        {    
            IPv6Section = IPV6AddrList[i] & TempIPV6MaskSection;
        }
        else
        {
            IPv6Section = IPV6AddrList[i] | TempIPV6MaskSection;
        }

        if (i == IPV6Length - 1)
        {
            if (isMinIP)
            {
                IPv6Section = IPv6Section + 1;
            }
            else
            {
                IPv6Section = IPv6Section - 1;
            }
        }
        
        IPv6Section = parseInt(IPv6Section,10).toString(16);
    
        if (IPv6Addr.length == 0)
        {
            IPv6Addr = IPv6Section;
        }
        else
        {
            IPv6Addr = IPv6Addr + ":" + IPv6Section;
        }
    }

    if (IPv4Addr != "")
    {
        IPv6Addr = IPv6Addr + ":" + IPv4Addr;
    }
    
    return IPv6Addr;
}

function IPV6AddressTansfrom(ipValue)
{    
    var ipAddr = ipValue.toString().split(":");
    var ipLength = ipAddr.length;
    var V6AddrStandardList = new Array();                                                                             
    var v6Check = ipValue.indexOf("::");
    var v4Andv6Check = ipValue.indexOf(".")
    
    if (v6Check >= 0 && v4Andv6Check < 0)    
    {
        V6AddrStandardList = IPV6Format(ipAddr,8);
        V6AddrStandardList = binaryTansform(V6AddrStandardList);
    }
    else if (v6Check >= 0 && v4Andv6Check >=0)   
    {
        V6AddrStandardList = ipAddr.slice(0,ipLength-1);
        V6AddrStandardList = IPV6Format(V6AddrStandardList,6);
        V6AddrStandardList = binaryTansform(V6AddrStandardList);
        V6AddrStandardList.push(ipAddr[ipLength-1]);
    }
    else if (v6Check < 0 && v4Andv6Check >= 0)  
    {
        V6AddrStandardList = ipAddr.slice(0,ipLength-1);
        V6AddrStandardList = binaryTansform(V6AddrStandardList);
        V6AddrStandardList.push(ipAddr[ipLength-1]);
    }
    else
    {
        V6AddrStandardList = binaryTansform(ipAddr);
    }

    return V6AddrStandardList;
}

function binaryTansform(IPv6AddrArr)
{
    var IPv6AddrArrChange = new Array();
    
    for (i = 0;i < IPv6AddrArr.length;i++)
    {    
        IPv6AddrSection = parseInt(IPv6AddrArr[i],16).toString(10);
        IPv6AddrArrChange.push(IPv6AddrSection);
    }
    
    return IPv6AddrArrChange;
}

function IPV6Format(ipListArr, num)
{    
    var i = 0;
    var ipTempList = new Array();
    var ipLength = ipListArr.length;
    
    if (ipListArr[0] == "" && ipListArr[1] == "")
    {
        var ipv6Length = ipListArr.length - 2;
        
        for (i = 0; i < num - ipv6Length; i++)
        {
            ipTempList.push("0");
        }
        
        for (i = 2; i < ipListArr.length; i++)
        {
            ipTempList.push(ipListArr[i]);
        }
    }
    else if (ipListArr[ipLength - 2] == "" && ipListArr[ipLength - 1] == "")
    {
        var ipv6Length = ipListArr.length - 2;
            
        for (i = 0; i < ipv6Length; i++)
        {
            ipTempList.push(ipListArr[i]);
        }
        
        for (i = ipv6Length; i < num; i++)
        {
            ipTempList.push("0");        
        }
    }
    else
    {    
        for (i = 0; i < ipLength; i++)
        {
            if (ipListArr[i] != "")
            {
                ipTempList.push(ipListArr[i]);
            }
            else
            {
                for (var j = 0; j < num - ipLength + 1; j++ )
                {
                    ipTempList.push("0");
                }        
            }
        }
    }
    
    return ipTempList;
}

function IPv6AddrMaskTransform(ipmask)
{
    var ipv6MaskValue = ipmask.split("/");
    var ipv6Addr = ipv6MaskValue[0];
    var ipv6Mask = ipv6MaskValue[1];
    var minIPv6Info = "";
    var maxIPv6Info = "";
    var minIPv6MaskList = getIPv6BoundMask(ipv6Mask, true);
    var maxIPv6MaskList = getIPv6BoundMask(ipv6Mask, false);
    
    if (ipv6MaskValue.length != 2)
    {
        return;
    }
    
    if (ipv6Mask == 128)
    {
        minIPv6Info = ipv6Addr.toUpperCase();
        maxIPv6Info = ipv6Addr.toUpperCase();
    }
    else if (ipv6Mask == 127)
    {
        minIPv6Info = getIPv6BoundAddr(ipv6Addr, maxIPv6MaskList, false);
        maxIPv6Info = getIPv6BoundAddr(ipv6Addr, minIPv6MaskList, true);
    }
    else
    {    
        minIPv6Info = getIPv6BoundAddr(ipv6Addr, minIPv6MaskList, true);
        maxIPv6Info = getIPv6BoundAddr(ipv6Addr, maxIPv6MaskList, false);
    }
    return minIPv6Info.toUpperCase() + "-" + maxIPv6Info.toUpperCase();  
}

function GetSrcIP(sip)
{
    var srcIp = "";
    var v6Check = sip.indexOf(":");
    var ipmaskCheck = sip.indexOf("/");
    
    if (sip != "")
    {
        if (v6Check >= 0 && ipmaskCheck >=0)
        {
            srcIp = IPv6AddrMaskTransform(sip).split("-");
        }
        else if (v6Check < 0 && ipmaskCheck >=0)
        {
            srcIp = IPv4AddrMaskTansform(sip).split("-");
        }
        else
        {
            srcIp = sip.split("-");
        }
        
        if (srcIp.length > 1)
        {
            setText("wanipStart",srcIp[0]);
            setText("wanipEnd",srcIp[1]);
        }
    }
    else
    {
        setText("wanipStart","");
        setText("wanipEnd","");        
    }

}
function DisplayOtherDivProtocols(displayFlag)
{
    var protocolCheckBoxList = document.getElementsByName("Protocol");
    for (var i = 0; i < protocolCheckBoxList.length; i++) {
        if (protocolCheckBoxList[i].value != "ICMP") {
            setDisplay("Div" + protocolCheckBoxList[i].id, displayFlag);
        }
    }
}

function InitTablelList()
{
    setText("priority","");
    setSelect("PortType", 0);
    
    for (var i = 1;i <= protocolArr.length;i++)
    {
        var ProtocolCtrlID = "Protocol" + i;
        
        setCheck(ProtocolCtrlID,0);
    }

    for (var port in portBindName)
    {
        setCheck(port,0);
    }
    
    setSelect("WanNameList",0);
    setSelect("WanTypeList", 0);
    setCheck("mode1",1);
    modeValue = 0;
    setText("wanipStart","");
    setText("wanipEnd","");
    setCheck("radionewacl1",1);
    setDisplay('LANRow',1);
    setDisplay('SSIDRow',0);
    setDisplay('WanNameListRow', 0);
    setDisplay('WanTypeListRow', 0);

    setSelect("serviceProtocol",1);
    setText("servicePort","");

    setCtrlDisable(0);
    
    setDisplay('telnetpasswordRow', 0);
    setDisplay('CfmtelnetpasswordRow', 0);
    
    if (modifiedPwd == 0) {
        setText("telnetpassword", '');
        setText("Cfmtelnetpassword", '');
    } else {
        setText("telnetpassword", defaultPwd);
        setText("Cfmtelnetpassword", defaultPwd);
    }

	
    if (IsSupportLanAsWan == 1) {
        for (var i = 1; i <= EthNum; i++) {
	    if ((MainUpPort.indexOf("LAN") >= 0) && (parseInt(MainUpPort.substr(3)) == i)) {
	        setDisplay("DivLAN"+(i+1), 0);
	    }
	}
    }
}

function ctrlCheckPortName(type,val,portname)
{
    for (var port in portBindName)
    {
        setCheck(port,0);
    }
    
    if (val == "ALL")
    {
        if (type == "0")
        {
            for (var i=1,len = LanNameList.length+1;i <= len;i++)
            {
	        if ((IsSupportLanAsWan == 1) && (MainUpPort.indexOf("LAN") >= 0) && (parseInt(MainUpPort.substr(3)) == i-1)) {
		    continue;
		}
                setCheck("LAN"+i,1);
            }
        }
        
        if (type == "1")
        {
            for (var i = 0; i < SSIDNameList.length; i++)
            {
                var ssidName = SSIDNameList[i].name.toString();
                var  ssidVal = ssidName.substring(ssidName.length-1,ssidName.length);
                ssidVal = "SSID" +(parseInt(ssidVal) + 1);            
                setCheck(ssidVal,1);    
            }
            setCheck("SSID1",1);
        }
    }
    else
    {
        setCheck("LAN1",0);
        setCheck("SSID1",0);
            
        for (var port in portBindNoAllName)
        {
            for (i = 0; i < portname.length; i++)
            {
                var portName = GetSrcPortID(portname[i],type);
                
                if (portBindNoAllName[port] == portName)
                {    
                    setCheck(port,1);
                }
                
                if (portName.toUpperCase().indexOf("STB") > 0)
                {
                    setCheck("LAN" + stbPortId,1);
                }            
            }     
        }        
    }
}

function setControl(index)
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AlertEx(maptInfo_language["map041"]);
        return;
    }
    var record;
    PortAclIndex = index;
    
    if (index == -1)
    {
        setDisplay("ConfigForm", 1);
        AddFlag = true;    
        record = new stNewDeviceAcl("", "0", "", "","","","");     
        InitTablelList();
        clickAll();    
        radioClick();
        if ((IsAdminUser() == false) || ((securityAccessFlag == '1') && (securityInAccessFlag == '0'))) {
            $("#PortType option[value='2']").remove();
        }
    }
    else if (index == -2)
    {
        setDisplay("ConfigForm", 0);
    }
    else
    {
		if (IsTedata == 1 && NewDeviceAclListInfo[PortAclIndex].ServiceProto != "")
		{
			setDisplay("ConfigForm", 0);
			return;
		}
        var optionlen = document.getElementById("PortType").options.length;
        
        setDisplay("ConfigForm", 1);
        AddFlag = false;
        record = NewDeviceAclListInfo[PortAclIndex];
        setCtlDisplay(record);
        clickAll();
        
        if (((IsAdminUser() == false) || ((securityAccessFlag == '1') && (securityInAccessFlag == '0')))) {
            if (record.SrcPortType == 2) {
                if (optionlen < 3) {
                    $("#PortType").append('<option value=' + 2 + ' id="WAN">' + 'WAN' + '</option>');
                }
                setCtlDisplay(record);
                setCtrlDisable(1);
            } else {
                $("#PortType option[value='2']").remove();
            }
        } else {
            setCtrlDisable(0);
        }
    }
}

function setCtrlDisable(disable)
{
    setDisable('priority',disable);
    setDisable('PortType',disable);
    setDisable('WanNameList',disable);
    setDisable('WanTypeList',disable);
    setDisable('wanipStart',disable);
    setDisable('wanipEnd',disable);
    setDisable('mode1',disable);
    setDisable('mode2',disable);
    setDisable('btnApply_ex',disable);
    setDisable('canelButton',disable);
	setDisable('serviceProtocol',disable);
	setDisable('servicePort',disable);
	setDisable('radionewacl1',disable);
	setDisable('radionewacl2',disable);
    
    for    (var i = 1;i <= protocolArr.length;i++)
    {
        setDisable('Protocol'+i,disable);
    }
}

function PortAclConfigListselectRemoveCnt(val)
{

}

function checkContainProtocol(protocolList, protocol) {
    if (protocolList == null) {
        return false;
    }
    if (protocolList.length == 0) {
        return false;
    }
    for (var i = 0;i < protocolList.length;i++) {
        if (protocolList[i] == protocol) {
            return true;
        }
    }
    return false;
}

function saveLastSrvProtocol(value)
{
    selectServicePro = value;
}

function setCtlDisplay(record)
{
    var portLanNameList = GetSrcPortListID(0);
    var portSSIDNameIdList = GetSrcPortListID(1);
    var portNameList = GetSplitList(record.SrcPortName);
    var portTypeValue = record.SrcPortType;
    var portNameVal = record.SrcPortName.toUpperCase();
    var protocolList = [];
    var priorityvalue = "";

    if (record.Protocol != "") {
        protocolList = record.Protocol.split(',');
    }

    InitTablelList();
    
    if (record.Priority != "")
    {
        priorityvalue = parseInt(record.Priority);
    }

    setText("priority",priorityvalue);
    setSelect("PortType", record.SrcPortType);
    
    for (var i = 1;i <= protocolArr.length;i++)
    {
        var ProtocolCtrlID = "Protocol" + i;
        if (checkContainProtocol(protocolList, protocolArr[i-1])) {
            setCheck(ProtocolCtrlID,1);
        } else {
            setCheck(ProtocolCtrlID,0);
        }
    }
    
    if (record.Mode == "0")
    {
        setCheck("mode1",1);
    }
    else
    {
        setCheck("mode2",1);
    }

    if (portTypeValue == "2") {
        if (CfgMode.toUpperCase() == 'DBAA1') {
            if (record.DynamicWanServiceType != '') {
                setSelect("WanTypeList", record.DynamicWanServiceType.toUpperCase());
            }
        } else {
            if (record.SrcPortName.toUpperCase() == "ALL") {
                setSelect("WanNameList",0);
            } else if (record.SrcPortName == "") {
                setSelect("WanNameList","");
            } else if ((isSupportHybrid == 1) && (record.SrcPortName.toUpperCase() == "BONDING")) {
                setSelect("WanNameList","BONDING");
            } else {
                setSelect("WanNameList", GetSelectedWan(record.SrcPortName).domain);
            }
        }
    } else {
        ctrlCheckPortName(portTypeValue,portNameVal,portNameList);
    }
    
    var arr = ["TCP","UDP","ICMP","ICMPV6"];
    setCheck("radionewacl1",1);
    
    for (var index in arr)
    {
        if (record.ServiceProto.toUpperCase().indexOf(arr[index]) >-1)
        {  
            setCheck("radionewacl2",1);
            switch(record.ServiceProto.toUpperCase())
            {
                case "TCP,UDP":
                case "UDP,TCP":
                    setSelect('serviceProtocol',"TCP/UDP");
                    saveLastSrvProtocol("TCP/UDP");
                    break;
                case "TCP":
                case "UDP":
                case "ICMP":
                case "ICMPV6":
                    setSelect('serviceProtocol',record.ServiceProto.toUpperCase());
                    saveLastSrvProtocol(record.ServiceProto.toUpperCase());
                    break;
                default:
                    setSelect('serviceProtocol',"ALL");
                    saveLastSrvProtocol("ALL");
                    break;
            }
            
            if (record.ServiceProtoPort == "--")
            {
                setText('servicePort',"");
            }
            else
            {
                setText('servicePort',record.ServiceProtoPort);
            }
        }
    }
    
    radioClick();    
    GetSrcIP(record.SrcIp);
    OnChangePortType();
    OnChangeClickMode();
    if (GetTelnetChecked() || GetSshChecked()) {
        setDisplay('telnetpasswordRow', 1);
        setDisplay('CfmtelnetpasswordRow', 1);
    } else {
        setDisplay('telnetpasswordRow', 0);
        setDisplay('CfmtelnetpasswordRow', 0);
    }
}

function shouldIgnoreSrcProtocol(protocalName) {
    if (CfgMode.toUpperCase() == 'DBAA1') {
        return false;
    }
    return (ProductType == '2') && (getSelectVal('PortType') == '2') && (protocalName == "HTTP");
}

function GetSrcProtocol(id,arr)
{
    var protoclStr = "";
    
    for (var i = 0; i <= arr.length; i++)
    {    
        var protocolID = id + (i + 1);
        var checkProtoValue = getCheckVal(protocolID);

        if (checkProtoValue >= 1)
        {
            if (shouldIgnoreSrcProtocol(arr[i])) {
                continue;
            }
            protoclStr += "," + arr[i];
        }
    }

    if (protoclStr.substr(0,1) == ",")
    {
        protoclStr = protoclStr.substr(1);
    }
    
    return protoclStr;
}

function GetSrcPortName(srcporttype)
{
    var portname = "";
    
    for (var port in portBindName)
    {
        var portdomain = GetPortNameDomian(portBindName[port],srcporttype);
        if (getCheckVal(port) && (portdomain != "")) {
            var portindex = port.substring(port.length - 1, port.length);
            if (((PonUpportConfig == 1) || (CfgMode.toUpperCase() == "DETHMAXIS") || (upLinkLanPort == 1)) && (parseInt(UpUserPortID) + 1 == portindex) && (port.toUpperCase().indexOf("LAN") >= 0)) {
                continue;
            }
            portname += GetPortNameDomian(portBindName[port],srcporttype) + ',';
         }
    }
    
    portname = portname.substring(0, portname.length - 1); 
    
    return portname;
}

function GetSrcIpValue()
{
    var srcIpValue = "";
    var ipStart = getValue("wanipStart");
    var ipEnd = getValue("wanipEnd");
    
    if (ipStart != "" && ipEnd != "")
    {
        srcIpValue = ipStart + "-" + ipEnd;
    }
    else if (ipStart != "" && ipEnd == "")
    {
        srcIpValue = ipStart + "-" + ipStart;
    }
    else if (ipStart == "" && ipEnd != "")
    {
        srcIpValue = ipEnd + "-" + ipEnd;
    }
    else
    {
        srcIpValue = "";
    }
    
    return srcIpValue;
}

function OnDeleteButtonClick()
{
    if (isMapFlag == "1" && mapEnable == "1") {
        AlertEx(maptInfo_language["map041"]);
        return;
    }
    if(false == ConfirmEx(port_acl_language['bbsp_modify_prompt']))
    {
        return false;
    }

    var CheckBoxList = document.getElementsByName(TableName+"rml");
    var Form = new webSubmitForm();
    var Count = 0;

    for (var i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked != true)
        {
            continue;
        }

        Count++;
        Form.addParameter(CheckBoxList[i].value,'');
    }
    
    if (Count <= 0)
    {
        return false;
    }
    
    setDisable("btnApply_ex","1");
    setDisable("canelButton",1);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.X_HW_Security.AclServices.AccessControl.List' + '&RequestFile=' + reqFile);
    Form.submit();

    return false;
}

function FindWanDomain(str)
{
    var WanList = GetWanList();
    
    for (i = 0; i < WanList.length; i++)
    {
        if (str == WanList[i].domain)
        {
            return WanList[i].domain;
        }
    }
    return null;
}

function CheckSubmit() {
    var strWarning = "";
    var protoclStr = GetSrcProtocol("Protocol", protocolArr);
    var protocolCheckArr = ['TELNET','HTTP','FTP','ICMP','SAMBA'];

    if(getElement("radionewacl")[0].checked == false) {
        return false;
    }
    for (var i = 0; i < protocolCheckArr.length; i++) {
        if (protoclStr.indexOf(protocolCheckArr[i]) != -1) {
            strWarning += "," + protocolCheckArr[i];
        }
    }
    if (strWarning.substr(0,1) == ",")
    {
        strWarning = strWarning.substr(1);
    }
    if (strWarning == "") {
        return false;
    }
    strWarning = port_acl_language["bbsp_warning1"] + " " + strWarning + " " + port_acl_language["bbsp_warning2"];
    AlertEx(strWarning);
    return true;
}

function CheckPwdInWeakPwdList(pwd)
{
    if (checkWeakPwdFlag != "1") {
        return false;
    }

    var NormalPwdInfo = FormatUrlEncode(pwd);
    var CheckResult = 0;
    $.ajax({
        type: "POST",
        async: false,
        cache: false,
        url: "/html/ssmp/common/CheckPwdInWeakPwdList.asp?&1=1",
        data: 'NormalPwdInfo=' + NormalPwdInfo,
        success: function (data) {
            CheckResult = data;
        }
    });
    return CheckResult == 1;
}

function CheckTelnetPwd()
{
    CheckCliPasswordModified();
    with(document.getElementById("ConfigForm")) {
        if (((Cfmtelnetpassword.value == defaultPwd) && (telnetpassword.value == defaultPwd) && (modifiedPwd == 1)) ||
            ((GetTelnetChecked() == false) && (GetSshChecked() == false))) {
            notSetPwd = 1;
            return true;
        }
        notSetPwd = 0;
        if ((Cfmtelnetpassword.value == '') || (telnetpassword.value == '')) {
            AlertEx(port_acl_language["bbsp_nopwd"]);
            return false;
        }
        if (Cfmtelnetpassword.value != telnetpassword.value) {
            AlertEx(port_acl_language["bbsp_notsame"]);
            return false;
        }
        if ((telnetpassword.value.length < secCodeLen) || (telnetpassword.value.length > 63)) {
            if (secCodeLen == 8) {
                AlertEx(port_acl_language["bbsp_pwdlenerr_sec"]);
            } else {
                AlertEx(port_acl_language["bbsp_pwdlenerr"]);
            }
            return false;
        }
        if (CheckPwdInWeakPwdList(telnetpassword.value)) {
            AlertEx(port_acl_language["bbsp_weakpwd"]);
            return false;
        }
        var score = 0;
        if (isLowercaseInString(telnetpassword.value)) {
            score++;
        }

        if (isUppercaseInString(telnetpassword.value)) {
            score++;
        }

        if (isDigitInString(telnetpassword.value)) {
            score++;
        }

        if (isSpecialCharacterNoSpace(telnetpassword.value)) {
            score++;
        }

        if (score < 2){
            AlertEx(port_acl_language["bbsp_pwdcomplexitylow"]);
            return false;
        }
    }
    return true;
}

function isTelnetservicePort(protoPort)
{
    if (protoPort == "23") {
        return true;
    }

    if (protoPort.indexOf(':') >= 0) {
        var list = protoPort.split(":");
        if ((list.length == 2) && (parseInt(list[0]) <= 23) && (parseInt(list[1]) >= 23)) {
            return true;
        }
    }

    return false;
}

function CheckProtoPortDnzvdf(protocolPort)
{
    if (isDnzvdf != 1) {
        return true;
    }

    var portArray = ["21", "22", "23"];
    var protoPortSegArr = [];
    var protoPortArr = [];
    var port;
    var startPort;
    var endPort;
    protoPortSegArr = protocolPort.split(',');
    for (var idx = 0; idx < protoPortSegArr.length; ++idx) {
        if (protoPortSegArr[idx] == '') {
            continue;
        }

        protoPortArr = protoPortSegArr[idx].split(':');
        if (protoPortArr.length == 2) {
            startPort = parseInt(protoPortArr[0], 10);
            endPort = parseInt(protoPortArr[1], 10);
            for (var i = 0; i < portArray.length; i++) {
                port = parseInt(portArray[i], 10);
                if ((startPort <= port) && (port <= endPort)) {
                    AlertEx('Error: Invalid port ID. Port ' + portArray[i] + ' is not allowed.');
                    return false;
                }
            }
        } else if (protoPortArr.length == 1) {
            if (portArray.indexOf(protoPortArr[0]) >= 0) {
                AlertEx('Error: Invalid port ID. Port ' + protoPortArr[0] + ' is not allowed.');
                return false;
            }
        }
    }

    return true;
}

function SubmitForm() {
	if ((CfgMode.toUpperCase() == "SAFARICOM") || (CfgMode.toUpperCase() == "SAFARICOM2")) {
        CheckSubmit();
    }
    if (CheckTelnetPwd() == false) {
        return false;
    }
    
    if(false == ConfirmEx(port_acl_language['bbsp_modify_prompt']))
    {
        return false;
    }
    
    var priorityValue = parseInt(getValue("priority"));
    var portType = getSelectVal('PortType');
    var srcPortnNameStr = "";
    var wanType = "";
    var protoclStr = GetSrcProtocol("Protocol", protocolArr);
    var scrip = GetSrcIpValue();
    var proto = getSelectVal('serviceProtocol');
    var protoPort = getValue('servicePort');
    var Form = new webSubmitForm();
    
    if (getValue("priority") == "")
    {
        priorityValue = "";
    }

    if (((CfgMode.toUpperCase() == 'MYTIME') || (CfgMode.toUpperCase() == 'MALAYTIMEAP6')) && (protoclStr.toUpperCase().indexOf("HTTP") >= 0)) {
        protoclStr = protoclStr + ",HTTPS";
    }

    if (((proto == "ALL") || (proto == "TCP/UDP") || (proto == "TCP")) && isTelnetservicePort(protoPort) &&
        (modeValue == 0) && (ConfirmEx(port_acl_language['bbsp_confirm_telnet']) == false)) {
        return;
    }

    if (portType == "2") {
        if (CfgMode.toUpperCase() == 'DBAA1') {
            wanType = getSelectVal("WanTypeList");
        } else {
            var selectWan = getSelectVal("WanNameList");
            if (selectWan == "0") {
                srcPortnNameStr =  "ALL";  
            } else if (selectWan == "") {
                srcPortnNameStr = "";
            } else if ((isSupportHybrid == 1) && (selectWan == "BONDING")) {
                srcPortnNameStr = "BONDING";
            } else {
                srcPortnNameStr = FindWanDomain(selectWan);  
            }
        }
    } else {
        var allLan = getCheckVal("LAN1");
        var allSSID = getCheckVal("SSID1");
    
        if (allLan) {
            srcPortnNameStr = "ALL";
            if ((PonUpportConfig == 1) && (upMode == 3)) {
                srcPortnNameStr = GetSrcPortName(portType);
            }
        } else if(allSSID) {
            srcPortnNameStr = "ALL";
        } else {
            srcPortnNameStr = GetSrcPortName(portType);
        } 
    }
    
    
    if (getElement("radionewacl")[1].checked)
    {
        if (proto == "ALL" )
        {
            if ((isWanAccess == "0") && (portType =="2")) {
                proto = "ICMP,ICMPV6";
            } else {
                proto = "ICMP,ICMPV6,TCP,UDP";
            }
        }
    
        if (proto == "TCP/UDP" )
        {
            proto = "TCP,UDP";
        }

        if (proto == "ICMP" || proto == "ICMPV6" || proto == "ICMP,ICMPV6"|| proto == "ICMPV6,ICMP")
        {
            protoPort = "";
        }
        
        if ('DMASMOVIL2WIFI' == CfgMode.toUpperCase())
        {
            if (proto.indexOf('TCP') >= 0)
            {
                var protoPortSegArr = [];
                var protoPortArr = [];
                protoPortSegArr = protoPort.split(',');
                for (var idx = 0; idx < protoPortSegArr.length; ++idx)
                {
                    if ('' == protoPortSegArr[idx])
                    {
                        continue;
                    }
                    protoPortArr = protoPortSegArr[idx].split(':');
                    if (2 == protoPortArr.length)
                    {
                        if (protoPortArr[0] <= 22 && protoPortArr[1] >= 22)
                        {
                            AlertEx('Error: Invalid port ID. TCP port 22 is not allowed.');
                            return false;
                        }
                    }
                    else if (1 == protoPortArr.length)
                    {
                        if (protoPortArr[0] == 22)
                        {
                            AlertEx('Error: Invalid port ID. TCP port 22 is not allowed.');
                            return false;
                        }
                    }
                }
            }
        }

        if (CheckProtoPort(portType, protoPort) == false) {
            return false;
        }

        if (CheckProtoPortDnzvdf(protoPort) == false) {
            return false;
        }

        protoclStr = "";
    }
    else
    {
        proto = "";
        protoPort = "";
        if ((CfgMode.toUpperCase() == "EGVDF2") && (portType == "2")) {
            if (protoclStr.toUpperCase().indexOf("HTTP") >= 0) {
                 AlertEx('Error: Invalid protocol. HTTP is not allowed.');
                 return false;
            }
        }
    }
    
    if ((AddFlag == true) && (notSetPwd == 0)) {
        Form.addParameter('Add_x.Priority',priorityValue);
        if ((CfgMode.toUpperCase() == 'DBAA1') && (portType == '2')) {
            Form.addParameter('Add_x.DynamicWanServiceType', wanType);
        } else {
            Form.addParameter('Add_x.SrcPortName', srcPortnNameStr);
        }
        Form.addParameter('Add_x.ServicePort',protoclStr);
        Form.addParameter('Add_x.SrcPortType',portType);
        Form.addParameter("Add_x.SrcIp",scrip);
        Form.addParameter("Add_x.Mode",modeValue); 
        Form.addParameter('Add_x.ServiceProto',proto);
        Form.addParameter('Add_x.ServiceProtoPort',protoPort);
    } else {
        Form.addParameter('x.Priority',priorityValue);
        if ((CfgMode.toUpperCase() == 'DBAA1') && (portType == '2')) {
            Form.addParameter('x.DynamicWanServiceType', wanType);
        } else {
            Form.addParameter('x.SrcPortName', srcPortnNameStr);
        }
        Form.addParameter('x.ServicePort',protoclStr);
        Form.addParameter('x.SrcPortType',portType);
        Form.addParameter("x.SrcIp",scrip);
        Form.addParameter("x.Mode",modeValue); 
        Form.addParameter('x.ServiceProto',proto);
        Form.addParameter('x.ServiceProtoPort',protoPort);
    }
    if (notSetPwd == 0) {
            Form.addParameter('y.Userpassword', getValue('telnetpassword'));
        }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    if (AddFlag == true) {
        if (notSetPwd == 0) {
            Form.setAction('complex.cgi?' + 'y=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.1' +
                           '&Add_x=InternetGatewayDevice.X_HW_Security.AclServices.AccessControl.List' + '&RequestFile=' + reqFile);
        } else {
            Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_Security.AclServices.AccessControl.List' + '&RequestFile=' + reqFile);
        }
    }
    else
    {
        if (notSetPwd == 0) {
            Form.setAction('complex.cgi?' +'x='+ NewDeviceAclListInfo[PortAclIndex].domain + '&y=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.1' +
                           '&RequestFile=' + reqFile);
        } else {
            Form.setAction('set.cgi?' +'x='+ NewDeviceAclListInfo[PortAclIndex].domain + '&RequestFile=' + reqFile);
        }
        
    }

    Form.submit();

    setDisable('ButtonApply',1);
    setDisable('ButtonCancel',1);
    return false;
}

function CancelValue()
{
    setDisplay("ConfigForm", 0);
    if (PortAclIndex == -1)
    {
        var tableRow = getElement(TableName);
        if (tableRow.rows.length == 1)
        {

        }
        else if (tableRow.rows.length == 2)
        {

        }
        else
        {
            tableRow.deleteRow(tableRow.rows.length-1);
            selectLine(TableName + "_record_0");
        }
    }
    else
    {
        var record = NewDeviceAclListInfo[PortAclIndex];
        setCtlDisplay(record);
    }
}

function GetShortPortName(SrcPortName,SrcPortType)
{
    var portnamelist = GetSplitList(SrcPortName);
    var portshortname = "";
    
    for (var i = 0 ; i < portnamelist.length ; i++)
    {
        if (i == portnamelist.length - 1)
        {
            portshortname += GetSrcPortID(portnamelist[i], SrcPortType);
            break;
        }

        portshortname += GetSrcPortID(portnamelist[i], SrcPortType) + ',';
    }

    return portshortname;
}

function ShowListControlInfo()
{
    var ColumnNum = 8;
    var ShowButtonFlag = true;
    var TableDataInfo = new Array();
    var Listlen = 0;
    var i = 0;

    var newAclInfoNr = NewDeviceAclListInfo.length-1;


	if(1 == COMMONV5FirewallFT)
	{
		if(FltsecLevel == 'DISABLE')
		{
			setDisable("portaclwhite",0);	
		}		
	}
	else
	{
	    if (FltsecLevel != 'CUSTOM')
		{
			newAclInfoNr = 0;
			ShowButtonFlag = false;
			setDisable("portaclwhite",1);
		}	
	}

    for (i = 0; i < newAclInfoNr; i++)
    {
        TableDataInfo[Listlen] = new stNewDeviceAcl();
        TableDataInfo[Listlen].domain = NewDeviceAclListInfo[i].domain;
        TableDataInfo[Listlen].Priority = htmlencode(NewDeviceAclListInfo[i].Priority);
        
        for (var typeNumber in LanguageAllDisplay)
        {
            if (NewDeviceAclListInfo[i].SrcPortType == typeNumber)
            {
                if (NewDeviceAclListInfo[i].SrcPortName != "" )
                {
                    if (NewDeviceAclListInfo[i].SrcPortName.toUpperCase() == "ALL")
                    {
                        TableDataInfo[Listlen].SrcPortName = port_acl_language[LanguageAllDisplay[typeNumber]];
                    }
                    else if ((isSupportHybrid == 1) && (NewDeviceAclListInfo[i].SrcPortName.toUpperCase() == "BONDING"))
                    {
                        TableDataInfo[Listlen].SrcPortName = bonding_other_language['bbsp_bonding'];
                    }
                    else
                    {
                        TableDataInfo[Listlen].SrcPortName = 
                        ((typeNumber === '2') ? (GetSelectedWan(NewDeviceAclListInfo[i].SrcPortName).Name) : (GetShortPortName(NewDeviceAclListInfo[i].SrcPortName,NewDeviceAclListInfo[i].SrcPortType)));
                        
                    }
                } else {
                    if ((CfgMode.toUpperCase() == "DBAA1") &&
                        (NewDeviceAclListInfo[i].SrcPortType == "2")) {
                        TableDataInfo[Listlen].SrcPortName = NewDeviceAclListInfo[i].DynamicWanServiceType;
                    } else {
                        TableDataInfo[Listlen].SrcPortName = "--";
                    }
                }
            }
        }

        TableDataInfo[Listlen].Protocol = NewDeviceAclListInfo[i].Protocol.toUpperCase();

        if (TableDataInfo[Listlen].Protocol == "")
        {
            TableDataInfo[Listlen].Protocol = "--";        
        } else if (((CfgMode.toUpperCase() == 'MYTIME') || (CfgMode.toUpperCase() == 'MALAYTIMEAP6')) && (TableDataInfo[Listlen].Protocol.toUpperCase().indexOf("HTTPS") >= 0)) {
            TableDataInfo[Listlen].Protocol = TableDataInfo[Listlen].Protocol.replace(",HTTPS", "");
        }

        if (NewDeviceAclListInfo[i].SrcIp == "")
        {
            TableDataInfo[Listlen].SrcIp = "--";
        }
        else
        {
            var srcV6IPVal = NewDeviceAclListInfo[i].SrcIp.indexOf(":");
            var srcV4IPVal = NewDeviceAclListInfo[i].SrcIp.indexOf("/");
            
            if (srcV6IPVal >= 0 && srcV4IPVal >= 0)
            {
                TableDataInfo[Listlen].SrcIp = IPv6AddrMaskTransform(htmlencode(NewDeviceAclListInfo[i].SrcIp));
            }
            else if (srcV6IPVal < 0 && srcV4IPVal >= 0)
            {
                TableDataInfo[Listlen].SrcIp = IPv4AddrMaskTansform(htmlencode(NewDeviceAclListInfo[i].SrcIp));
            }
            else
            {
                TableDataInfo[Listlen].SrcIp = htmlencode(NewDeviceAclListInfo[i].SrcIp);
            }
        }
        
        TableDataInfo[Listlen].ServiceProtoPort = NewDeviceAclListInfo[i].ServiceProtoPort;
        TableDataInfo[Listlen].ServiceProto = NewDeviceAclListInfo[i].ServiceProto.toUpperCase();

        if (TableDataInfo[Listlen].ServiceProto == "")
        {
            TableDataInfo[Listlen].ServiceProto = "--";
        }

        if (TableDataInfo[Listlen].ServiceProtoPort == "")
        {
            TableDataInfo[Listlen].ServiceProtoPort = "--";
        }

        TableDataInfo[Listlen].Mode = port_acl_language["bbsp_deny_web"];
        
        if (NewDeviceAclListInfo[i].Mode == 0)
        {
            TableDataInfo[Listlen].Mode = port_acl_language["bbsp_permit_web"];
        }

        Listlen++;    
    }
    
    if (0 == newAclInfoNr)
    {
        TableDataInfo[Listlen] = new stNewDeviceAcl();
        TableDataInfo[Listlen].domain = "--";
        TableDataInfo[Listlen].Priority = "--";
        TableDataInfo[Listlen].SrcPortName = "--";
        TableDataInfo[Listlen].Protocol = "--";
        TableDataInfo[Listlen].ServiceProto= "--";
        TableDataInfo[Listlen].ServiceProtoPort = "--";
        TableDataInfo[Listlen].SrcIp = "--";
        TableDataInfo[Listlen].Mode = "--";
    }
    else
    {
        TableDataInfo.push(null);
    }
    
    HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PortAclConfiglistInfo, port_acl_language, null);
}

function setCrtlCheck(checkVal)
{    
    var portTypeValue = getSelectVal("PortType")

    if (portTypeValue == 0)    
    {
        for (var i = 1; i <= lanCtrlCheckBoxNum; i++)
        {
            if (1 == PonUpportConfig && parseInt(UpUserPortID) + 1 == i)
            {
                continue;
            }
			
	    if ((IsSupportLanAsWan == 1) && (PortConfigInfo.X_HW_MainUpPort.indexOf("LAN") >= 0) && (parseInt(MainUpPort.substr(3)) == i-1)) {
	        continue;
	    }
            
            setCheck('LAN' + i,checkVal);
        }
    }
    else if (portTypeValue == 1)
    {
        for (var i = 1; i <= ssidIDCheckBoxNum; i++)
        {
            setCheck('SSID' + i,checkVal);
        }
    }
}

function setDisableWanAclTableList()
{
    for (var i = 0,len = NewDeviceAclListInfo.length - 1; i < len; i++) {
        if ((NewDeviceAclListInfo[i].SrcPortType == 2) && ((IsAdminUser() == false) || ((securityAccessFlag == '1') && (securityInAccessFlag == '0')))) {
            setDisable('PortAclConfigList_rml' + i, 1);
        } else {
            setDisable('PortAclConfigList_rml' + i, 0);
        }
    }
}

function OnChangePortType()
{
    var porttype = getSelectVal('PortType');

    if (ProductType == XD_PRODUCT_TYPE)
    {
        setDisplay("Protocol2_text",1);
        setDisplay("Protocol2",1);
    }
    DisplayOtherDivProtocols(1);
    var checkServiceProtocol = document.getElementById("serviceProtocol").options.length;
    if (checkServiceProtocol < 6) {
        $("#serviceProtocol").append('<option id=' + '"4"'+'value=' +'"TCP/UDP"' + '>' + 'TCP/UDP' + '</option>');
        $("#serviceProtocol").append('<option id=' + '"5"'+'value=' +'"TCP"' + '>' + 'TCP' + '</option>');
        $("#serviceProtocol").append('<option id=' + '"6"'+'value=' +'"UDP"' + '>' + 'UDP' + '</option>');
    }
    setDisplay("DivProtocol1", 1);
    if (porttype == "0")
    {
        setDisplay('LANRow',1);
        setDisplay('SSIDRow',0);
        setDisplay('WanNameListRow',0);
        setDisplay('WanTypeListRow',0);
    }
    else if (porttype == "1")
    {
        setDisplay('SSIDRow',1);
        setDisplay('LANRow',0);
        setDisplay("WanNameListRow",0);
        setDisplay('WanTypeListRow',0);
    }
    else
    {
        if (isWanAccess == "0") {
            DisplayOtherDivProtocols(0);
            setDisplay("servicePortRow", 0);
            $("#serviceProtocol option[value='TCP/UDP']").remove();
            $("#serviceProtocol option[value='TCP']").remove();
            $("#serviceProtocol option[value='UDP']").remove();
        }
        setDisplay('LANRow',0);
        setDisplay('SSIDRow',0);
        if (CfgMode.toUpperCase() == 'DBAA1') {
            setDisplay('WanTypeListRow', 1);
        } else {
            setDisplay('WanNameListRow',1);
        }
        if ((ProductType == XD_PRODUCT_TYPE) &&
           (CfgMode.toUpperCase() != 'DMASMOVIL2WIFI') &&
           (CfgMode.toUpperCase() != 'DBAA1')) {
            setDisplay("Protocol2_text",0);
            setDisplay("Protocol2",0);
        }
        if (CfgMode.toUpperCase() == "EGVDF2") {
            setDisplay("DivProtocol1", 0);
        }
    }
    if ((isWanAccess == "0") && (getElement("radionewacl")[1].checked == true) && (porttype != 2)) {
        setDisplay("servicePortRow", 1);
    }
}

function enableUnsafeProtocol(value)
{
    if ((getElement("radionewacl")[0].checked == false) && (noticeSelectService == 0)) {
        noticeSelectService = 1;
        return true;
    }

    var unsafePclStr = "ALL,ICMP,ICMPV6";
    var noticeWord = value;
    if (noticeWord == "ALL") {
        noticeWord = "ICMP, ICMPV6";
    }
    if (unsafePclStr.indexOf(value) >= 0) {
        var confirmStr = port_acl_language['bbsp_confirm_protocol_enable'] + noticeWord + port_acl_language['bbsp_confirm_protocol_right'];
        if (ConfirmEx(confirmStr) == false) {
            setSelect('serviceProtocol', selectServicePro);
            return false;
        }
    }

    saveLastSrvProtocol(getSelectVal('serviceProtocol'));
    return true;
}

function protocalChange(event_invoke)
{
    var currentPro = getSelectVal('serviceProtocol');
    var curPortType = $("#PortType").val();

    if (CfgMode.toUpperCase() == "EGVDF2") {
        if (enableUnsafeProtocol(currentPro) == false) {
            return;
        }
    }

        switch (currentPro.toUpperCase())
        {
            case "ICMP":
            case "ICMPV6":
                setDisplay('servicePortRow',0);
                break;
            default:
                setDisplay('servicePortRow',1);
                break;
        }
    if ((isWanAccess == "0") && (curPortType == "2")) {
        setDisplay("servicePortRow", 0);
    }
}

function OnChangeClickMode()
{
    if (true == getElement("mode")[0].checked)
    {
        modeValue = 0;
    }
    else
    {
        modeValue = 1;
    }
}

function OnChangeClickProtocol()
{
    if (true == getElement("mode")[0].checked)
    {
        modeValue = 0;
    }
    else
    {
        modeValue = 1;
    }
}

function InitIPTVWANInfo()
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
	var tempIPTVPortID = parseInt(tempIPTVUpList[0].substr(3)) + 1;
	setDisplay("DivLAN" + tempIPTVPortID, 0);
	return;
}

function InitConfigForm()
{    
    for (var i = 0; i < PortTypeList.length; i++)
    {
        if (0 == SSIDNameList.length && i == 1)
        {
            continue;
        }
        
        $("#PortType").append('<option value=' + i + ' id="' + PortTypeList[i] + '">' + PortTypeList[i] + '</option>');
    }

    for (var i = 1; i <= lanIDCheckBoxNum; i++)
    {
        setDisplay('DivSSID' + i, 0);
        
        if (i > lanCtrlCheckBoxNum) {
            if (notSupportPON == '1') {
                setDisplay('DivLAN' + i, 0);
                setDisplay('DivLAN5', 0);
            } else {
                setDisplay('DivLAN' + i, 0);
            }
        }
        if (1 == PonUpportConfig && UpUserPortID == i)
        {
            setDisable('LAN' + (i + 1), 1);
        }
        if (((CfgMode.toUpperCase() == "DETHMAXIS") || (upLinkLanPort == 1)) && (UpUserPortID == i)) {
            setDisplay('DivLAN' + (i + 1), 0);
        }
    }

    if (CfgMode.toUpperCase() == "SDCCENTER") {
        setDisplay("DivLAN3", 0);
    }

	InitIPTVWANInfo();
	
    for (var i = 0; i < SSIDNameList.length; i++)
    {

        var ssidName = SSIDNameList[i].name.toString();
        var  ssidVal = ssidName.substring(ssidName.length-1,ssidName.length);
        ssidVal = "SSID" +(parseInt(ssidVal) + 1);
        
        setDisplay('Div'+ ssidVal,1);
        setDisplay("DivSSID1",1);
    }
}

function EnablePortAclForm()
{
    var Form = new webSubmitForm();
    var Enable = getElById("portaclwhite").checked;
    
    if (Enable == true)
    {
       Form.addParameter('x.AccessControlListEnable',1);
    }
    else
    {
        if(false == ConfirmEx(port_acl_language['bbsp_modify_prompt']))
        {
            setCheck("portaclwhite",1);
            return false;
        }
        else
        {
            setCheck("portaclwhite",0);
        }
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices.AccessControl'
                        + '&RequestFile=' + reqFile);
    Form.submit();
}

if (stbPort > 0)
{
    port_acl_language['bbsp_lan'+ stbPort] = port_acl_language['bbsp_stb'];
}

function radioClick()
{
    noticeSelectService = 0;
    var curPortType = $("#PortType").val();
    var record = NewDeviceAclListInfo[PortAclIndex];
    if(true == getElement("radionewacl")[0].checked)
    {
        setDisplay("ProtocolRow",1);
        setDisplay("serviceProtocolRow",0);
        setDisplay("servicePortRow",0);
        if ((isWanAccess == "0") && (IsAdminUser() == true)) {
            if (curPortType != "2") {
                DisplayOtherDivProtocols(1);
            }
        }
    } else {
        setDisplay("ProtocolRow",0);
        setDisplay("serviceProtocolRow",1);
        protocalChange();
    }
}

function title_show(input)
{
    var div=document.getElementById("title_show");
    if (CfgMode.toUpperCase() == "TURKCELL2") {
        div.style.left = (input.offsetLeft + 900)+"px";
    } else {
        div.style.left = (input.offsetLeft + 390)+"px";
    }


    if (secCodeLen == 8) {
        div.innerHTML = port_acl_language['bbsp_telnetpwd_note_sec'];
    } else {
        div.innerHTML = port_acl_language['bbsp_telnetpwd_note'];
    }
    div.style.display = '';
}
function title_back(input)
{
    var div=document.getElementById("title_show");
    div.style.display = "none";
}

function CheckCliPasswordModified()
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "/html/ssmp/common/CheckCliPasswordModified.asp",
        success : function(data) {
            modifiedPwd = htmlencode(data);
        }
    });
}

</script>
</head>
<body onLoad="OnPageLoad();" class="mainbody">
<div id="PromptPanel">
<script language="JavaScript" type="text/javascript">
    var titleId = "bbsp_title_newprompt";
    if (IsDisableUnsafeProtocol()) {
        titleId = "bbsp_title_newprompt_disable_nosafe";
    } else if (((securityAccessFlag == '1') && (securityInAccessFlag == '0'))) {
        titleId = "bbsp_title_newprompt_security";
    }
    if (disableWifi == '1') {
        titleId = "bbsp_title_newprompt_security_nowifi";
    }
    HWCreatePageHeadInfo("portacltitle", GetDescFormArrayById(port_acl_language, "bbsp_newmune"), GetDescFormArrayById(port_acl_language, titleId), false);

    </script>
<div class="title_spread"></div>
</div>

<form id="PortAccessEnableForm" style="display:block;">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li   id="portaclwhite"   RealType="CheckBox"  DescRef="bbsp_title_newaclenable"   RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField="y.PortSrcWhiteListEnable"  InitValue=""  ClickFuncApp="onclick=EnablePortAclForm"/>
    </table>
    <script>
        var PortAccessEnableFormList = new Array();
        var TableClass = new stTableClass("per_35_45", "per_65_48", "ltr");
        PortAccessEnableFormList = HWGetLiIdListByForm("PortAccessEnableForm",null);
        HWParsePageControlByID("PortAccessEnableForm",TableClass,port_acl_language,null);
        setCheck('portaclwhite',NewAclEnableInfo[0].enable);
    </script>
    <div class="func_spread"></div>
</form>

<div class="title_spread"></div>
<script language="JavaScript" type="text/javascript">
    var PortAclConfiglistInfo = new Array(new stTableTileInfo("Empty","align_center width_per15","DomainBox"),
                                new stTableTileInfo("bbsp_td_priority","align_center width_per10","Priority","Priority",10),
                                new stTableTileInfo("bbsp_td_portname","align_center width_per12","SrcPortName","SrcPortName",12),
                                new stTableTileInfo("bbsp_td_sip","align_center width_per15","SrcIp","SrcIp",20), 
                                new stTableTileInfo("bbsp_user_application","align_center width_per13","Protocol","Protocol",20),
                                new stTableTileInfo("bbsp_td_ServiceProto","align_center width_per12","ServiceProto","ServiceProto",13),
                                new stTableTileInfo("bbsp_td_ServiceProtoPort","align_center width_per13","ServiceProtoPort","ServiceProtoPort",20),
                                new stTableTileInfo("bbsp_td_mode","align_center width_per5","Mode","Mode",10),null);

    ShowListControlInfo();
</script>

<form id="ConfigForm" style="display:none">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li   id="radionewacl"      RealType="RadioButtonList"      DescRef="bbsp_user_protype"        RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"    InitValue="[{TextRef:'bbsp_user_application',Value:'1'},{TextRef:'bbsp_user_custom',Value:'2'}]" ClickFuncApp="onclick=radioClick"/>
        <li   id="priority"     RealType="TextBox"      DescRef="bbsp_priority"     RemarkRef="bbsp_priority_note"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""     Elementclass="width_260px "     InitValue="" />
        <li   id="PortType"     RealType="DropDownList"     DescRef="bbsp_porttype"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""    Elementclass="width_260px "     InitValue=""  ClickFuncApp="onChange=OnChangePortType"/>
        <li   id="LAN"      RealType="CheckBoxList"     DescRef="bbsp_portname"      RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""    InitValue="[{TextRef:'bbsp_all',Value:'ALL'},{TextRef:'bbsp_lan1',Value:'LAN1'},{TextRef:'bbsp_lan2',Value:'LAN2'},{TextRef:'bbsp_lan3',Value:'LAN3'},{TextRef:'bbsp_lan4',Value:'LAN4'},{TextRef:'bbsp_lan5',Value:'LAN5'},{TextRef:'bbsp_lan6',Value:'LAN6'},{TextRef:'bbsp_lan7',Value:'LAN'},{TextRef:'bbsp_lan8',Value:'LAN8'}]" />
        <li  id="SSID" RealType="CheckBoxList" DescRef="bbsp_portname" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="" InitValue="[{TextRef:'bbsp_all',Value:'ALL'},{TextRef:'bbsp_ssid1',Value:'SSID1'},{TextRef:'bbsp_ssid2',Value:'SSID2'},{TextRef:'bbsp_ssid3',Value:'SSID3'},{TextRef:'bbsp_ssid4',Value:'SSID4'},{TextRef:'bbsp_ssid5',Value:'SSID5'},{TextRef:'bbsp_ssid6',Value:'SSID6'},{TextRef:'bbsp_ssid7',Value:'SSID'},{TextRef:'bbsp_ssid8',Value:'SSID8'}]" />
        <li   id="WanNameList"      RealType="DropDownList"     DescRef="bbsp_wanname"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""     Elementclass="width_260px "     InitValue=""  ClickFuncApp="onChange=OnChangePortType"/>
        <li   id="WanTypeList"      RealType="DropDownList"     DescRef="bbsp_wantype"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""     Elementclass="width_260px "     InitValue="[{TextRef:'bbsp_Tr069',Value:'TR069'},{TextRef:'bbsp_Internet',Value:'INTERNET'},{TextRef:'bbsp_Voip',Value:'VOIP'},{TextRef:'bbsp_Iptv',Value:'IPTV'},{TextRef:'bbsp_Other',Value:'OTHER'}]"/>
        <li   id="wanipStart" RealType="TextOtherBox" DescRef="bbsp_sip" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="DestIPStart" MaxLength="39" InitValue="[{Type:'span',Item:[{AttrName:'id',AttrValue:'despip'},{AttrName:'innerhtml', AttrValue:'bbsp_dash'}]},{Type:'text',Item:[{AttrName:'id',AttrValue:'wanipEnd'},{AttrName:'MaxLength', AttrValue:'39'}]},{Type:'span',Item:[{AttrName:'id',AttrValue:'desnote'},{AttrName:'innerhtml', AttrValue:'bbsp_ip_note'}]}]"/>
		<script language="JavaScript" type="text/javascript">      

            if (IsTedata == 1){
                document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_Ftp',Value:'FTP'},{TextRef:'bbsp_Icmp',Value:'ICMP'},{TextRef:'bbsp_Samba',Value:'SAMBA'}]\" />");
            } else if ((CfgMode.toUpperCase() == 'DMASMOVIL2WIFI') || (CfgMode.toUpperCase() == 'EGVDF2')) {
                document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_Http',Value:'HTTP'},{TextRef:'bbsp_Ftp',Value:'FTP'},{TextRef:'bbsp_Icmp',Value:'ICMP'},{TextRef:'bbsp_Samba',Value:'SAMBA'}]\" />");
            } else if (["DBAA1", "MOLDTEL2", "COMTECOEBG4"].indexOf(CfgMode.toUpperCase()) >= 0) {
                document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_Telnet',Value:'TELNET'},{TextRef:'bbsp_Http',Value:'HTTP'},{TextRef:'bbsp_Https',Value:'HTTPS'},{TextRef:'bbsp_SSH',Value:'SSH'},{TextRef:'bbsp_Ftp',Value:'FTP'},{TextRef:'bbsp_Icmp',Value:'ICMP'},{TextRef:'bbsp_Samba',Value:'SAMBA'}]\" />");
            } else if (IsDisableUnsafeProtocol()) {
                if (isSupportUSB == '0') {
                    document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_SSH',Value:'SSH'},{TextRef:'bbsp_Icmp',Value:'ICMP'}]\"/>");
                } else {
                    document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_SSH',Value:'SSH'},{TextRef:'bbsp_Sftp',Value:'SFTP'},{TextRef:'bbsp_Icmp',Value:'ICMP'},{TextRef:'bbsp_Samba',Value:'SAMBA'}]\"/>");
                }
            } else if ((IsBin5 == '1') || (isSupportUSB == '0')) {
                document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_Telnet',Value:'TELNET'},{TextRef:'bbsp_Http',Value:'HTTP'},{TextRef:'bbsp_SSH',Value:'SSH'},{TextRef:'bbsp_Icmp',Value:'ICMP'}]\" />");
            } else if (isDnzvdf == 1) {
                document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_Http',Value:'HTTP'},{TextRef:'bbsp_Icmp',Value:'ICMP'}]\" />");
            }else {
                document.write("<li   id=\"Protocol\"     RealType=\"CheckBoxList\"     DescRef=\"bbsp_user_applicationmh\"     RemarkRef=\"Empty\"     ErrorMsgRef=\"Empty\"    Require=\"FALSE\"     BindField=\"\"      InitValue=\"[{TextRef:'bbsp_Telnet',Value:'TELNET'},{TextRef:'bbsp_Http',Value:'HTTP'},{TextRef:'bbsp_SSH',Value:'SSH'},{TextRef:'bbsp_Ftp',Value:'FTP'},{TextRef:'bbsp_Icmp',Value:'ICMP'},{TextRef:'bbsp_Samba',Value:'SAMBA'}]\"/>");
            }

            if (IsDisableUnsafeProtocol()) {
                document.write("<li id=\"telnetpassword\" RealType=\"TextBox\" DescRef=\"bbsp_sshpwd\" RemarkRef=\"bbsp_telnetpwd_tip\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"\" InitValue=\"\" ClickFuncApp=\"onmouseover=title_show;onmouseout=title_back\"/>");
                document.write("<li id=\"Cfmtelnetpassword\" RealType=\"TextDivbox\" DescRef=\"bbsp_sshpwdCfm\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\"  BindField=\"\" InitValue=\"[{Item:[{AttrName:'id', AttrValue:'title_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:280px;margin-top:-60px; border:solid 1px #999999; background:#edeef0;'}]}]\" />");
            } else {
                document.write("<li id=\"telnetpassword\" RealType=\"TextBox\" DescRef=\"bbsp_telnetpwd\" RemarkRef=\"bbsp_telnetpwd_tip\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"\" InitValue=\"\" ClickFuncApp=\"onmouseover=title_show;onmouseout=title_back\"/>");
                document.write("<li id=\"Cfmtelnetpassword\" RealType=\"TextDivbox\" DescRef=\"bbsp_telnetpwdCfm\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\"  BindField=\"\" InitValue=\"[{Item:[{AttrName:'id', AttrValue:'title_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:280px;margin-top:-60px; border:solid 1px #999999; background:#edeef0;'}]}]\" />");
            }
        </script>
        <li id="serviceProtocol" RealType="DropDownList" DescRef="bbsp_protocolmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="serviceProtocol" Elementclass="SelectDdns" InitValue="[{TextRef:'bbsp_all',Value:'ALL'},{TextRef:'ICMP',Value:'ICMP'},{TextRef:'ICMPV6',Value:'ICMPV6'},{TextRef:'TCPUDP',Value:'TCP/UDP'},{TextRef:'TCP',Value:'TCP'},{TextRef:'UDP',Value:'UDP'}]" ClickFuncApp="onchange=protocalChange" />
        <li id="servicePort" RealType="TextBox" DescRef="bbsp_td_ServiceProtoPortmh" RemarkRef="bbsp_port_note" ErrorMsgRef="Empty" Require="FALSE" BindField="" Elementclass="" MaxLength="32" InitValue="Empty" />
        <li   id="mode"     RealType="RadioButtonList"      DescRef="bbsp_mode"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField=""    InitValue="[{TextRef:'bbsp_permit',Value:'0'},{TextRef:'bbsp_deny',Value:'1'}]" ClickFuncApp="onclick=OnChangeClickMode"/>
        <script language="JavaScript" type="text/javascript">
            var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
            var PortAclFormList = new Array();
            PortAclFormList = HWGetLiIdListByForm("ConfigForm", null);
            var formid_hide_id = null;
            HWParsePageControlByID("ConfigForm", TableClass, port_acl_language, formid_hide_id);
            InitConfigForm();
        </script>
    </table>

    <table class="table_button" cellspacing="1" id="cfg_table" width="100%">
      <tr>
        <td class='width_per25'>&nbsp;</td>
        <td class="table_submit width_per75">
          <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
          <input id="btnApply_ex" name="btnApply_ex" type="button" BindText = "bbsp_app" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();">
          <input id="canelButton" name="canelButton" type="button" BindText = "bbsp_cancel" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();">
        </td>
      </tr>
    </table>
</form>
<script>
    function IsRouteWan(Wan)
    {
        if (Wan.Mode =="IP_Routed")
        {
            return true;
        }

        return false;
    }
        
    $("#WanNameList").append('<option value=' + 0 + ' id="ALL">'+ port_acl_language["bbsp_all"] + '</option>');
    InitWanNameListControl1("WanNameList", IsRouteWan);
    if (isSupportHybrid == 1) {
        $("#WanNameList").append('<option value="BONDING" id="BONDING">' + bonding_other_language['bbsp_bonding'] + '</option>');
    }
    ParseBindTextByTagName(port_acl_language, "div",  1);
    ParseBindTextByTagName(port_acl_language, "td",  1);
    ParseBindTextByTagName(port_acl_language, "span",  1);
    ParseBindTextByTagName(port_acl_language, "input", 2);
    ParseBindTextByTagName(port_acl_language, "th", 1);
    ParseBindTextByTagName(port_acl_language, "h3", 1);  
 </script>
</body>
</html>