<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>DHCP Configure</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, dhcp_language);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/dhcpinfo.asp"></script>
<script language="JavaScript" type="text/javascript">
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var dbaa1SuperSysUserType = '2';
var isBiznetForUser = '<%HW_WEB_GetFeatureSupport(FT_DISPLAY_GUESTWIFI_POOL);%>';
function IsAdminUser()
{
    if (DBAA1 == '1') {
        return curUserType == dbaa1SuperSysUserType;
    }
    return curUserType == sysUserType;
}
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var norightslavepool='<%HW_WEB_GetFeatureSupport(FT_NOMAL_NO_RIGHT_SLAVE_POOL);%>';
var conditionpoolfeature ='<%HW_WEB_GetFeatureSupport(BBSP_FT_DHCPS_COND_POOL);%>';
var SonetHN8055QFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SONET_HN8055Q);%>';
var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var RosMode = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROS);%>';
var LanAddrSplitFlag = '<%HW_WEB_GetFeatureSupport(FT_LAN_SPLIT_ADDR_ADRESSPOOL);%>';
var gstwfpoolfeature ='<%HW_WEB_GetFeatureSupport(FT_LAN_GUESTWIFI_POOL);%>';
var gstuseallslvpool ='<%HW_WEB_GetFeatureSupport(FT_GUEST_USE_ALL_SLVPOOL);%>';
var LanMultiIpfeature = '<%HW_WEB_GetFeatureSupport(FT_LAN_MULTI_IP);%>';
var IsAPFlagfeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var TableName = "LanHostIp";
var ProductType = '<%HW_WEB_GetProductType();%>';
if('1' == gstwfpoolfeature)
{
   conditionpoolfeature = '0';
}

var specIPoEMTUMax = '<%HW_WEB_GetSPEC(SPEC_LOWER_LAYER_MAX_MTU.UINT32);%>';
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';

var ClassAIpSupportFlag='<%HW_WEB_GetFeatureSupport(BBSP_FT_SUPPORT_CLASS_A_IP);%>';
var TDEMode = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var IsTELECOMFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_TELECOM);%>';
var IsNETLIFElag = '<%HW_WEB_GetFeatureSupport(HW_BBSP_FEATURE_NETLIFE);%>';
var IsLanForceDownFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_FORCERENEW_LAN_UPDOWN);%>';
var IsSupportBridgeWan = '<%HW_WEB_GetFeatureSupport(FT_WAN_SUPPORT_BRIDGE_INTERNET);%>';
var isMegacableFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
var selctIndex = -1;
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var isBbspFtLswWebCut = '<%HW_WEB_GetFeatureSupport(BBSP_FT_LSW_WEB_CUT);%>';

function IsSonetHN8055QUser()
{
    if ((SonetHN8055QFlag == '1') && (IsAdminUser() == false)) {
        return true;
    }
    else
    {
        return false;
    }
}

function GetCurrentLoginIP()
{
    var CurUrlHost = (window.location.host).toUpperCase();
    var CurUrlIp = CurUrlHost.split(":")[0];
    return CurUrlIp;
}

function IsSonetNewNormalUser() {
    if (((curCfgModeWord.toUpperCase() == 'SONET') || (curCfgModeWord.toUpperCase() == 'SONET8045Q') ||
        (curCfgModeWord.toUpperCase() == 'SONETSGP200W')) && (IsAdminUser() == false)) {
        return true;
    }
    if ((curCfgModeWord.toUpperCase() == 'SYNCSGP210W') || (curCfgModeWord.toUpperCase() == 'SONETSGP210W')) {
        return true;
    }
    return false;
}

function stLanHostInfo(domain,enable,ipaddr,subnetmask,AddressConflictDetectionEnable)
{
    this.domain = domain;
    this.enable = enable;
    this.ipaddr = ipaddr;
    this.subnetmask = subnetmask;
    this.AddressConflictDetectionEnable = AddressConflictDetectionEnable;
}

function PolicyRouteItem(_Domain, _Type, _VenderClassId, _WanName)
{
    this.Domain = _Domain;
    this.Type = _Type;
    this.VenderClassId = _VenderClassId;
    this.WanName = _WanName;
}

function SlaveDhcpInfo(domain, enable)
{
    this.domain    = domain;
    this.enable    = enable;
}

function GetPolicyRouteListLength(PolicyRouteList, Type)
{
    var Count = 0;

    if (PolicyRouteList == null)
    {
        return 0;
    }

    for (var i = 0; i < PolicyRouteList.length; i++)
    {
        if (PolicyRouteList[i] == null)
        {
            continue;
        }

        if (PolicyRouteList[i].Type == Type)
        {
            Count++;
        }
    }

    return Count;
}
function condhcpst(domain,enable,ipstart,ipend,gateway)
{
    this.Domain     = domain;
    this.enable     = enable;
    this.ipstart     = ipstart;
    this.ipend       = ipend;
    this.gateway    = gateway;
}
function madhcpst(domain,ipstart,ipend,gateway)
{
    this.Domain     = domain;
    this.ipstart     = ipstart;
    this.ipend       = ipend;
    this.gateway    = gateway;
}
function dhcpmainst(domain, DHCPServerEnable, X_HW_MTU)
{
    this.domain = domain;
    this.X_HW_MTU = X_HW_MTU;
    this.DHCPServerEnable = DHCPServerEnable;
}
var LanHostInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask|X_HW_AddressConflictDetectionEnable,stLanHostInfo);%>;
var LanHostInfo2 = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2,Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask|X_HW_AddressConflictDetectionEnable,stLanHostInfo);%>;
var PolicyRouteListAll = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterPolicyRoute, InternetGatewayDevice.Layer3Forwarding.X_HW_policy_route.{i},PolicyRouteType|VenderClassId|WanName,PolicyRouteItem);%>;
var SlaveDhcpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaSlaveDhcpPool, InternetGatewayDevice.X_HW_DHCPSLVSERVER,DHCPEnable,SlaveDhcpInfo);%>;
var LanHostInfo = LanHostInfos[0];
LanHostInfos.pop();
var LanHostInfoValue = new Array();
var ConditionDhcpInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.{i}, Enable|MinAddress|MaxAddress|IPRouters,condhcpst);%>;
if (ConditionDhcpInfos[1] == null)
{
    ConditionDhcpInfos[1] = new condhcpst("InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2", "", "", "", "");
}
var MainDhcpRange = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaMainDhcpPool, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement, MinAddress|MaxAddress|IPRouters, madhcpst);%>;
var MainDhcpPara = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaMainDhcpPool, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement,DHCPServerEnable|X_HW_MTU,dhcpmainst);%>;
var SlaveIpAddr = "";
var SlaveIpMask = "";
if (LanHostInfos[1] != null)
{
    SlaveEnable = LanHostInfos[1].enable;
    SlaveIpAddr = LanHostInfos[1].ipaddr;
    SlaveIpMask = LanHostInfos[1].subnetmask;
}
else if(LanHostInfos[1] == null && LanHostInfo2[0] != null && '1' == conditionpoolfeature)
{
    SlaveEnable = LanHostInfo2[0].enable;
    SlaveIpAddr = LanHostInfo2[0].ipaddr;
    SlaveIpMask = LanHostInfo2[0].subnetmask;
}

for (var i = 0; i < LanHostInfos.length; i++) 
{
    var spstr = LanHostInfos[i].domain.split(".");
    if (spstr[spstr.length-1] > 2)
    {
        LanHostInfoValue.push(LanHostInfos[i]);
    }
}

function PortVlanIpInterfaceInfo(Domain, Enable, IPInterfaceIPAddress, IPInterfaceSubnetMask) {
    this.Domain = Domain;
    this.Enable = Enable;
    this.IPInterfaceIPAddress = IPInterfaceIPAddress;
    this.IPInterfaceSubnetMask = IPInterfaceSubnetMask;
}
function PortVlanDhcpPollInfo(Domain, DHCPServerEnable, MinAddress, MaxAddress, SubnetMask) {
    this.Domain = Domain;
    this.DHCPServerEnable = DHCPServerEnable;
    this.MinAddress = MinAddress;
    this.MaxAddress = MaxAddress;
    this.SubnetMask = SubnetMask;
}
var portVlanIpInterfaceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_VLAN.VLANConfig.{i}.IPInterface,Enable|IPInterfaceIPAddress|IPInterfaceSubnetMask,PortVlanIpInterfaceInfo);%>;
var portVlanIpInterfaceLen = portVlanIpInterfaceList.length - 1;
var portVlanIpDhcpPoolList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_VLAN.VLANConfig.{i}.DHCPConfig,DHCPServerEnable|MinAddress|MaxAddress|SubnetMask,PortVlanDhcpPollInfo);%>;
var portVlanIpDhcpPoolLen = portVlanIpDhcpPoolList.length - 1;

function setAllDisable()
{
    setDisable('ethIpAddress',1);
    setDisable('ethSubnetMask',1);
    setDisable('enableslaveaddress',1);
    setDisable('slaveIpAddress',1);
    setDisable('slaveSubnetMask',1);
    setDisable('btnApply',1);
    setDisable('cancelValue',1);
}

function setControl(index)
{
    var lanhostinfo;
    selctIndex = index;
    if (index == -1)
    {
        lanhostinfo = new stLanHostInfo("","","","");
        setDisplay('SecondaryAddrFormtde', 1);
        setDisplay("SecondaryAddrtdeTitle",0);
        setCtlDisplay(lanhostinfo);
     }
    else if (index == -2)
    {
        setDisplay('SecondaryAddrFormtde', 0);
    }
    else
    {
        lanhostinfo = LanHostInfoValue[index];
        setCtlDisplay(lanhostinfo);        
        setDisplay('SecondaryAddrFormtde', 1);
    }
}

function DisableMultiLanIP()
{
    var enableslaveaddress = getCheckVal('enableslaveaddress');
    if (enableslaveaddress == "1") 
    {
        setDisable("Newbutton",0);
        setDisable("DeleteButton",0);
    }
    else
    {
        setDisable("Newbutton",1);
        setDisable("DeleteButton",1);
    }
}

function setCtlDisplay(lanhostinfo)
{
    setCheck('enableslaveaddresstde', lanhostinfo.enable);
    setText('slaveIpAddresstde',lanhostinfo.ipaddr);
    setText('slaveSubnetMasktde',lanhostinfo.subnetmask);
}

function displayMtu()
{
    if ((specIPoEMTUMax != '1500') && (IsSupportBridgeWan == 0))
    {
        setDisplay("br0MtuRow", 1);
        document.getElementById("br0MtuRowRemark").innerHTML = "(1-"+ specIPoEMTUMax + ")";
        getElById('br0MtuRowRemark').title = "(1-"+ specIPoEMTUMax + ")";
        if ("ARABIC" == LoginRequestLanguage.toUpperCase())
        {
            document.getElementById("br0MtuRowRemark").innerHTML = "("+ specIPoEMTUMax + "-1)";
            getElById('br0MtuRowRemark').title = "("+ specIPoEMTUMax + "-1)";
        }
    }
    else
    {
        setDisplay("SetMTU", 0);
    }
    if (isBbspFtLswWebCut == "1")
    {
        setDisplay("SetMTU", 0);
    }
    return;
}

function DisplaySecondaryDhcp()
{
    if ((IsAPFlagfeature == "1") && (["MALAYTIMEAP", "TMAP6", "MALAYTIMEAP6"].indexOf(curCfgModeWord.toUpperCase()) < 0)) {
        setDisplay("SecondaryDhcp",0);
    }
    if (isBbspFtLswWebCut == "1")
    {
        setDisplay("SecondaryDhcp", 0);
    }
}
function DisplaySecondDhcpTde()
{
    if (LanHostInfo2[0] != null)
    {
        setCheck('enableslaveaddress',LanHostInfo2[0].enable);
        setText('slaveIpAddress', LanHostInfo2[0].ipaddr);
        setText('slaveSubnetMask',LanHostInfo2[0].subnetmask);  
    }
    else
    {
        setCheck('enableslaveaddress',0);
        setDisplay('slaveIpAddressRow', 0);
        setDisplay('slaveSubnetMaskRow', 0);      
    }    
}
function LanHostIpselectRemoveCnt()
{

}

function LoadFrame()
{
    with ( document.forms[0] )
    {
        setText('ethIpAddress',LanHostInfo.ipaddr);
        setText('ethSubnetMask',LanHostInfo.subnetmask);
        if (DBAA1 == "1") {
            setDisable('ethSubnetMask', 1);            
        }
        setCheck('enableFreeArp', LanHostInfo.AddressConflictDetectionEnable);
        if (MainDhcpPara[0] != null)
        {
            setText('br0MtuRow', MainDhcpPara[0].X_HW_MTU);
        }

        if (LanHostInfos[1] != null)
        {
            if(LanMultiIpfeature == 1)
            {
                DisplaySecondDhcpTde();
            }
            else
            {
                setCheck('enableslaveaddress',LanHostInfos[1].enable);
                setText('slaveIpAddress', LanHostInfos[1].ipaddr);
                setText('slaveSubnetMask',LanHostInfos[1].subnetmask);
            }
        }
        else if (LanHostInfos[1] == null && LanHostInfo2[0] != null && '1' == conditionpoolfeature)
        {
            setCheck('enableslaveaddress',LanHostInfo2[0].enable);
            setText('slaveIpAddress', LanHostInfo2[0].ipaddr);
            setText('slaveSubnetMask',LanHostInfo2[0].subnetmask);
        }
        
        if (((IsTELECOMFlag == 1) && (IsAdminUser() == false)) ||
            (GetCfgMode().PTVDFB == "1")) {
            setAllDisable();
        }

        if ((GetCfgMode().TELMEX == "1") ||
            (GetCfgMode().PCCWHK == "1") ||
            (GetCfgMode().DT_HUNGARY == "1") ||
            ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY")) ||
            ((IsAdminUser() == false) && (GetCfgMode().PTVDF == "1")) ||
            (IsSonetHN8055QUser()) ||
            (RosMode == '1') ||
            (IsSonetNewNormalUser()) ||
            (curCfgModeWord.toUpperCase() == "ROMANIADT2") ||
            (curCfgModeWord.toUpperCase() == "DMASMOVIL2WIFI")) {
            if (IsAdminUser() && (GetCfgMode().PCCWHK == "1") && (gstuseallslvpool != "1")) {
                if (ProductType == '3') {
                    setDisplay('SecondaryDhcp', 0);
                } else {
                    setDisplay('SecondaryDhcp', 1);
                }
            } else {
                setDisplay('SecondaryDhcp', 0);
            }
        }
        else if ((SingtelMode == '1') || (gstuseallslvpool == "1"))
        {
            setDisplay('SecondaryDhcp', 0);
        }
        else
        {
            if (ProductType == '3')
            {
                setDisplay('SecondaryDhcp', 0);
            } else {
                if ((DBAA1 == "1") && (curUserType != dbaa1SuperSysUserType)) {
                    setDisplay('SecondaryDhcp', 0);
                } else {
                    setDisplay('SecondaryDhcp', 1);
                }
            }
        }
        configEnableSaddress();
    }


    if (true == IsSupportConfigFreeArp())
    {
        setDisplay('FreeArpForm', 1);
    }
    else
    {
        setDisplay('FreeArpForm', 0);
    }

    if (LanMultiIpfeature == "1")
    {
        setDisplay("LanHostIp_tbl",1);
        setDisplay("SecondaryAddrForm",1);
    }
    else
    {
        setDisplay("LanHostIp_tbl",0);
        setDisplay("SecondaryAddrForm",1);
    }
    if ((curCfgModeWord.toUpperCase() == "DMASMOVIL2WIFI") || ((curUserType != '0') && (isMegacableFlag == "1"))) {
        setDisplay("SecondaryAddrForm",0);
    }
    displayMtu();
    DisableMultiLanIP();
    DisplaySecondaryDhcp();
	
    if (isBiznetForUser == "1") {
		setDisplay("SecondaryAddrForm",0);
    }
}

function checkMtu()
{

    var br0Mtu = getValue("br0MtuRow");
    if ((br0Mtu!='')&&(false == CheckNumber(br0Mtu, 1, specIPoEMTUMax)))
    {
        AlertEx(dhcp_language['bbsp_MxuInvalid']);
        return false;
    }
    return true;
}

function iPStrToIpDigit(ipStr)
{
    var ipNum = 0;
    var ipArr = ipStr.split(".");
    if (ipArr.length != 4) {
        return ipNum;
    }

    if ((parseInt(ipArr[0]) < 256) && (parseInt(ipArr[1]) < 256) && (parseInt(ipArr[2]) < 256) && (parseInt(ipArr[3]) < 256)) {
        ipNum = (parseInt(ipArr[0]) << 24) | (parseInt(ipArr[1]) << 16) | (parseInt(ipArr[2]) << 8) | parseInt(ipArr[3]);
        return ipNum;
    }

    return ipNum;
}

function IsSameNetWithPortVlan(ifAddrNum, netAddr) 
{
    for (var i = 0; i < portVlanIpInterfaceLen; ++i) {
        if (portVlanIpInterfaceList[i].Enable == '0') {
            break;
        }
        var portVlanIfIpnum = iPStrToIpDigit(portVlanIpInterfaceList[i].IPInterfaceIPAddress);
        var portVlanMaskNum = iPStrToIpDigit(portVlanIpInterfaceList[i].IPInterfaceSubnetMask);
        var portVlanIfNetAddr = portVlanIfIpnum & portVlanMaskNum;

        if ((netAddr == portVlanIfNetAddr) || ifAddrNum == portVlanIfIpnum) {
            return true;
        }
    }

    for (var i = 0; i < portVlanIpDhcpPoolLen; ++i) {
        if (portVlanIpDhcpPoolList[i].DHCPServerEnable == '0') {
            break;
        }
        var portVlanStartIpNum = iPStrToIpDigit(portVlanIpDhcpPoolList[i].MinAddress);
        var portVlanStopIpNum = iPStrToIpDigit(portVlanIpDhcpPoolList[i].MaxAddress);
        var portVlanMaskNum = iPStrToIpDigit(portVlanIpDhcpPoolList[i].SubnetMask);
        var portVlanMinNetAddr = portVlanStartIpNum & portVlanMaskNum;
        var portVlanMaxNetAddr = portVlanStopIpNum & portVlanMaskNum;

        if ((netAddr == portVlanMinNetAddr) || (netAddr == portVlanMaxNetAddr) ||
            (ifAddrNum == portVlanStartIpNum) || (ifAddrNum == portVlanStopIpNum) ) {
            return true;
        }
    }
    return false;
}

function IsConfilctWithPortVlan()
{
    var ethAddressNum = iPStrToIpDigit(getValue('ethIpAddress'));
    var ethNetmaskNum = iPStrToIpDigit(getValue('ethSubnetMask'));
    var ethNetAddrNum = ethAddressNum & ethNetmaskNum;

    if (IsSameNetWithPortVlan(ethAddressNum, ethNetAddrNum) == true) {
        return true;
    }

    if (getCheckVal('enableslaveaddress') == '0') {
        return false;
    }

    var slaveAddressNum = iPStrToIpDigit(getValue('slaveIpAddress'));
    var slaveNetmaskNum = iPStrToIpDigit(getValue('slaveSubnetMask'));
    var slaveNetAddrNum = slaveAddressNum & slaveNetmaskNum;

    if (IsSameNetWithPortVlan(slaveAddressNum, slaveNetAddrNum) == true) {
        return true;
    }
}

function lanIpIsSameSubNet(ip1, mask1, ip2, mask2)
{
    var count = 0;
    var ipAddr1 = ip1.split('.');
    var ipAddr2 = ip2.split('.');
    var subMask1 = mask1.split('.');
    var subMask2 = mask2.split('.');
    var minMask = subMask1;

    for (var i = 0; i < 4; ++i) {
        if (subMask1[i] > subMask2[i]) {
            minMask = subMask2;
            break;
        }
    }

    for (var i = 0; i < 4; ++i) {
        var minMaskNum = parseInt(minMask[i]);
        var subMaskNum1 = parseInt(ipAddr1[i]);
        var subMaskNum2 = parseInt(ipAddr2[i]);
        if ((subMaskNum1 & minMaskNum) == (subMaskNum2 & minMaskNum)) {
            count++;
        }
    }

    if (count == 4) {
        return true;
    }

    return false;
}

function CheckForm(type)
{
    var result = false;
    var ethIpAddress = getValue('ethIpAddress');
    var ethSubnetMask = getValue('ethSubnetMask');
    var slaveIpAddress = getValue('slaveIpAddress');
    var slaveSubnetMask = getValue('slaveSubnetMask');
	var enableslave = getCheckVal('enableslaveaddress');
	
	var alertChangeIp = false;
	if(ProductType == '2' && enableslave != LanHostInfos[1].enable && IsLanForceDownFlag == 1)
	{
	    if(confirm(dhcp_language['bbsp_LanForceDownAlert']) == false)
        {
            return;
        }
		
		alertChangeIp = true;
	}
    
    if(ProductType == '2' && slaveIpAddress != LanHostInfos[1].ipaddr && IsLanForceDownFlag == 1 && !alertChangeIp)
    {
        if(confirm(dhcp_language['bbsp_LanForceDownAlert']) == false)
        {
            return;
        }
    }
   
    if(gstuseallslvpool == "1")
    {
        if(true==isSameSubNet(ethIpAddress, ethSubnetMask,SlaveIpAddr,SlaveIpMask))
        {
            AlertEx(dhcp_language['bbsp_ipsamegusetip1'] + dhcp_language['bbsp_ipsamegusetip2'] + SlaveIpAddr);
            return false;
        }                   
    }
    if ( isValidIpAddress(ethIpAddress) == false )
    {
        if (SingtelMode == '1')
        {
            AlertEx(dhcp_language['bbsp_ipmhaddrp_singtel'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
        }
        else
        {
            AlertEx(dhcp_language['bbsp_ipmhaddrp'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
        }
        return false;
    }
    if ( isValidSubnetMask(ethSubnetMask) == false )
    {
        if (SingtelMode == '1')
        {
            AlertEx(dhcp_language['bbsp_subnetmaskmh_singtel'] + ethSubnetMask + dhcp_language['bbsp_isinvalidp']);
        }
        else
        {
            AlertEx(dhcp_language['bbsp_subnetmaskmh'] + ethSubnetMask + dhcp_language['bbsp_isinvalidp']);
        }
        return false;
    }
    if (ClassAIpSupportFlag != 1)
    {
        if ( isMaskOf24BitOrMore(ethSubnetMask) == false )
        {
            if (SingtelMode == '1')
            {
                AlertEx(dhcp_language['bbsp_subnetmaskmh_singtel'] + ethSubnetMask + dhcp_language['bbsp_isinvalidp'] + dhcp_language['bbsp_maskerrorinfo']);
            }
            else
            {
                AlertEx(dhcp_language['bbsp_subnetmaskmh'] + ethSubnetMask + dhcp_language['bbsp_isinvalidp'] + dhcp_language['bbsp_maskerrorinfo']);
            }
            return false;
         }
    }

    if(isHostIpWithSubnetMask(ethIpAddress, ethSubnetMask) == false)
    {
        if (SingtelMode == '1')
        {
            AlertEx(dhcp_language['bbsp_ipmhaddrp_singtel'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
        }
        else
        {
            AlertEx(dhcp_language['bbsp_ipmhaddrp'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
        }

        return false;
    }
    if ( isBroadcastIp(ethIpAddress, ethSubnetMask) == true )
    {
        if (SingtelMode == '1')
        {
            AlertEx(dhcp_language['bbsp_ipmhaddrp_singtel'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
        }
        else
        {
            AlertEx(dhcp_language['bbsp_ipmhaddrp'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
        }

        return false;
    }

    if ('1' == TDEMode)
    {

                
        if ((true == ipTDEPreserved(ethIpAddress))
            || (true == ipTDEPreserved(slaveIpAddress)))
        {
            AlertEx(dhcp_language['bbsp_TDEsaveip']);
            return false;
        }
    }
    if((GetCfgMode().TELMEX == "1") ||
       ((GetCfgMode().PCCWHK == "1") && (IsAdminUser() == false)) ||
       (GetCfgMode().DT_HUNGARY == "1") ||
       ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY")) ||
       ((IsAdminUser() == false) && (GetCfgMode().PTVDF) == "1") ||
       (RosMode == '1') ||
       (IsSonetHN8055QUser()) ||
       (IsSonetNewNormalUser()) ||
       (curCfgModeWord.toUpperCase() == "ROMANIADT2")) {
    } else if (SingtelMode == '1') {
    } else {
     if ((getCheckVal('enableslaveaddress') == 1 && (TDEMode == '1')) ||
         (TDEMode != '1')) {
        if ( isValidIpAddress(slaveIpAddress) == false )
        {
             AlertEx(dhcp_language['bbsp_ipaddrp'] + slaveIpAddress + dhcp_language['bbsp_isinvalidp']);
             return false;
        }
        if ( isValidSubnetMask(slaveSubnetMask) == false ) {
             AlertEx(dhcp_language['bbsp_subnetmaskp'] + slaveSubnetMask + dhcp_language['bbsp_isinvalidp']);
             return false;
        }
        if (ClassAIpSupportFlag != 1)
        {
            if ( isMaskOf24BitOrMore(slaveSubnetMask) == false )
            {
                AlertEx(dhcp_language['bbsp_subnetmaskp'] + slaveSubnetMask + dhcp_language['bbsp_isinvalidp'] + dhcp_language['bbsp_maskerrorinfo']);
                return false;
            }
        }

        if(isHostIpWithSubnetMask(slaveIpAddress, slaveSubnetMask) == false)
        {
            AlertEx(dhcp_language['bbsp_ipaddrp'] + slaveIpAddress + dhcp_language['bbsp_isinvalidp']);
            return false;
        }
        if ( isBroadcastIp(slaveIpAddress, slaveSubnetMask) == true )
        {
            AlertEx(dhcp_language['bbsp_ipaddrp'] + slaveIpAddress + dhcp_language['bbsp_isinvalidp']);
            return false;
        }
     }


    }

    if(SlaveDhcpInfos[0] != null)
    {
        var enableSlave = getCheckVal('enableslaveaddress');

         if (((1 == enableSlave) &&  '1' == TDEMode)
            ||('1' != TDEMode))
        {
            if((0 == LanAddrSplitFlag && (1 == enableSlave)) || (1 == LanAddrSplitFlag && 1 == getCheckVal('enableslaveaddress')))
            {
                  if (slaveIpAddress == ethIpAddress)
                  {
                      AlertEx(dhcp_language['bbsp_pridhcpsecdhcp']);
                      return false;
                  }

                  if(true == lanIpIsSameSubNet(ethIpAddress, ethSubnetMask,slaveIpAddress,slaveSubnetMask))
                  {
                      AlertEx(dhcp_language['bbsp_pridhcpsecdhcp']);
                      return false;
                  }
            }
        }

      }

    if ((getValue('ethIpAddress').split(".")[3] > 127) &&
        ((CfgModeWord.toUpperCase() == 'PCCWHK') || (CfgModeWord.toUpperCase() == 'PCCW3MAC')) &&
        (IsAdminUser() == false)) {
        AlertEx(dhcp_language['bbsp_iprangeinvalid']);
        return false;
    }

    if (false == checkMtu())
    {
        return false;
    }

    if (DBAA1 == "1") {
        if ((ethIpAddress.indexOf("10.0.0.") != 0) && (ethIpAddress.indexOf("192.168.0.") != 0) && (ethIpAddress.indexOf("192.168.1.") != 0)) {
            AlertEx(dhcp_language['bbsp_ipaddrp'] + ethIpAddress + dhcp_language['bbsp_isinvalidp']);
            return false;
        }

        if ((getCheckVal('enableslaveaddress') == 1) && (slaveIpAddress.indexOf("10.0.0.") != 0) && 
            (slaveIpAddress.indexOf("192.168.0.") != 0) && (slaveIpAddress.indexOf("192.168.1.") != 0)) {
            AlertEx(dhcp_language['bbsp_ipaddrp'] + slaveIpAddress + dhcp_language['bbsp_isinvalidp']);
            return false;
        }
    }

    var Reboot = (GetPolicyRouteListLength(PolicyRouteListAll, "SourceIP") > 0 && getValue('ethIpAddress') != LanHostInfos[0].ipaddr) ? dhcp_language['bbsp_resetont']:"";

    result = true;
    if (((getValue('ethIpAddress') != LanHostInfos[0].ipaddr) && (GetCurrentLoginIP() == LanHostInfos[0].ipaddr))
        ||((getValue('slaveIpAddress') != SlaveIpAddr) && (GetCurrentLoginIP() == SlaveIpAddr)))
    {
        result = ConfirmEx(dhcp_language['bbsp_dhcpconfirmnote']+Reboot);
    }

    if (IsConfilctWithPortVlan() == true) {
        AlertEx(dhcp_language['bbsp_isSameSubnetWithPortVlan']);
        return false;
    }

    if (1 == ClassAIpSupportFlag)
    {
        for (var i = 0;i < GetWanList().length;i++)
        {
            var CurrentWan = GetWanList()[i];
            if (CurrentWan.IPv4IPAddress != '0.0.0.0' && CurrentWan.IPv4SubnetMask != '0.0.0.0'
                && CurrentWan.IPv4IPAddress != '' && CurrentWan.IPv4SubnetMask != '' )
            {
                if (getValue('ethIpAddress') == CurrentWan.IPv4IPAddress)
                {
                    AlertEx(dhcp_language['bbsp_ipdifwan']);
                    return false;
                }

                if (CurrentWan.IPv4Enable == "1")
                {
                    if(true==isSameSubNet(getValue('ethIpAddress'), getValue('ethSubnetMask'),
                                          CurrentWan.IPv4IPAddress, CurrentWan.IPv4SubnetMask))
                    {
                          AlertEx(dhcp_language['bbsp_lanwanipcheck']);
                        return false;
                    }

                    if((getCheckVal('enableslaveaddress') == 1)
                        &&(true==isSameSubNet(getValue('slaveIpAddress'), getValue('slaveSubnetMask'),
                                      CurrentWan.IPv4IPAddress, CurrentWan.IPv4SubnetMask)))
                    {
                        AlertEx(dhcp_language['bbsp_lanwanipcheck']);
                        return false;
                    }
                }
            }
        }
    }

    if ( result == true )
    {
        setDisable('btnApply', 1);
        setDisable('cancelValue', 1);
    }

    return result;
}

function CheckMultiLanIP()
{
    var IpAddressValue = getValue("slaveIpAddresstde");
    var SubnetMaskValue = getValue("slaveSubnetMasktde");    
    if ( isValidIpAddress(IpAddressValue) == false )
    {
         AlertEx(dhcp_language['bbsp_ipaddrp'] + IpAddressValue + dhcp_language['bbsp_isinvalidp']);
         return false;
    }
    if ( isValidSubnetMask(SubnetMaskValue) == false ) {
         AlertEx(dhcp_language['bbsp_subnetmaskp'] + SubnetMaskValue + dhcp_language['bbsp_isinvalidp']);
         return false;
    }
    
    if (true == ipTDEPreserved(IpAddressValue))
    {
        AlertEx(dhcp_language['bbsp_TDEsaveip']);
        return false;
    }    
    
    return true;        
}

function IsNeedDelCond2()
{
    if((ConditionDhcpInfos[1].gateway == LanHostInfos[1].ipaddr) &&
       ((LanHostInfos[1].ipaddr != getValue('slaveIpAddress')) || (LanHostInfos[1].subnetmask != getValue('slaveSubnetMask'))))
    {
        return true;
    }
    if((ConditionDhcpInfos[1].gateway == LanHostInfos[0].ipaddr) &&
       ((LanHostInfos[0].ipaddr != getValue('ethIpAddress')) || (LanHostInfos[1].subnetmask != getValue('ethSubnetMask'))))
    {
        return true;
    }
    return false;
}

function NewSubmit()
{
    if ((IsAdminUser() == false) && (GetCfgMode().PTVDF == "1")) {
       return;
    }
    var RequestFile = 'html/bbsp/dhcp/dhcp.asp';
    var enableslave = getCheckVal("enableslaveaddresstde");
    var IpAddressValue = getValue("slaveIpAddresstde");
    var SubnetMaskValue = getValue("slaveSubnetMasktde");
    if (CheckMultiLanIP() == false)
    {
        return false;
    }
    var DSASpecCfgParaList = new Array(new stSpecParaArray("x.Enable",enableslave, 1),
                                    new stSpecParaArray("x.IPInterfaceIPAddress",IpAddressValue, 1),
                                    new stSpecParaArray("x.IPInterfaceSubnetMask",SubnetMaskValue, 1));
    var url = '';
    if( selctIndex == "-1" )
    {
        url = 'add.cgi?x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface'
                            + '&RequestFile='+ RequestFile;
    }
    else
    {
        url = 'set.cgi?x=' + LanHostInfoValue[selctIndex].domain
                            + '&RequestFile=' + RequestFile;
    }

    setDisable('Newbutton',1);
    setDisable('DeleteButton',1);
    setDisable('btnApply_ex',1);
    setDisable('cancelValue_ex',1);
    var Parameter = {};
    Parameter.asynflag = null;
    Parameter.FormLiList = DhcpPripoolFormListtde;
    Parameter.SpecParaPair = DSASpecCfgParaList;
    var tokenvalue = getValue('onttoken');
    HWSetAction(null, url, Parameter, tokenvalue);
}

function ApplyConfig(type)
{
    
    if((IsNETLIFElag == 1))
    {
        var enableslaveaddress = getCheckVal('enableslaveaddress');
        if(enableslaveaddress == "1")
        {
            if(confirm(dhcp_language['bbsp_dhcpconfirmtip']) == false)
            {
                return;
            }
        }
        
    }
    Submit(type);
}

function AddSubmitParam(Form,type)
{
    var RequestFile = 'html/bbsp/dhcp/dhcp.asp';
    var enableslave = getCheckVal('enableslaveaddress');
    var url = '';

    if (!((IsTELECOMFlag == 1) && (IsAdminUser() == false))) {
        with (document.forms[0])
        {
            Form.addParameter('x.IPInterfaceIPAddress',getValue('ethIpAddress'));
            if (DBAA1 != "1") {
                Form.addParameter('x.IPInterfaceSubnetMask',getValue('ethSubnetMask'));
            }
            if (true == IsSupportConfigFreeArp())
            {
                Form.addParameter('x.X_HW_AddressConflictDetectionEnable',getCheckVal('enableFreeArp'));
                if ((norightslavepool == 1) && (IsAdminUser() == false)) {
                } else {
                    Form.addParameter('z.X_HW_AddressConflictDetectionEnable',getCheckVal('enableFreeArp'));
                }
            }

            if ((GetCfgMode().TELMEX == "1") ||
                (GetCfgMode().PCCWHK == "1") ||
                (GetCfgMode().DT_HUNGARY == "1") ||
                ((IsAdminUser() == false) && (curCfgModeWord.toUpperCase() == "RDSGATEWAY")) ||
                ((IsAdminUser() == false) && (GetCfgMode().PTVDF) == "1") ||
                (IsSonetHN8055QUser()) ||
                (RosMode == "1") ||
                (IsSonetNewNormalUser()) ||
                (curCfgModeWord.toUpperCase() == "ROMANIADT2")) {
                if(IsAdminUser() && GetCfgMode().PCCWHK == "1" && gstuseallslvpool != "1")
                {
                    Form.addParameter('z.Enable',enableslave);
                    if (enableslave == '1')
                    {
                        Form.addParameter('z.IPInterfaceIPAddress',getValue('slaveIpAddress'));
                        Form.addParameter('z.IPInterfaceSubnetMask',getValue('slaveSubnetMask'));
                    }
                    url = 'set.cgi?'
                          + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1'
                          + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2';
                }
                else
                {
                    url = 'set.cgi?'
                          + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1';
                }
            }
            else if ((SingtelMode == '1') || (gstuseallslvpool == "1"))
            {
                    url = 'set.cgi?'
                          + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1';
            }
            else
            {
                Form.addParameter('z.Enable',enableslave);
                var isSetGst = true;
                if('1' == gstwfpoolfeature)
                {
                    if(true == IsNeedDelCond2())
                    {
                        var ParameterList = '';
                        var Url = '/complexajax.cgi?&Del_w=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2' ;
                        HWGetAction(Url, ParameterList, getValue('onttoken'));
                        isSetGst = false;
                    }
                    if((isSetGst == true) && (ConditionDhcpInfos[1].gateway == LanHostInfos[1].ipaddr))
                    {
                        if(ConditionDhcpInfos[0].enable == '1')
                        {
                            Form.addParameter('w.Enable',enableslave);
                        }
                        else
                        {
                            Form.addParameter('w.Enable',ConditionDhcpInfos[0].enable);
                        }
                        if((enableslave == '1') && (ConditionDhcpInfos[0].enable == '1'))
                        {
                            Form.addParameter('w.MinAddress',ConditionDhcpInfos[1].ipstart);
                            Form.addParameter('w.MaxAddress',ConditionDhcpInfos[1].ipend);
                        }
                    }
                }
                if (enableslave == '1')
                {
                    if (LanHostInfo2[0] == null)
                    {
                        $.ajax({
                             type : "POST",
                             async : false,
                             cache : false,
                             data : "z.IPInterfaceIPAddress="+getValue('slaveIpAddress')+"&z.IPInterfaceSubnetMask="+getValue('slaveSubnetMask')+"&z.Enable="+enableslave+"&x.X_HW_Token="+getValue('onttoken'),
                                 url : 'add.cgi?'+ 'z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface'+'&RequestFile=html/not_find_file.asp',
                             success : function(data) {
                             },
                             complete: function (XHR, TS) {
                                XHR=null;
                                 }
                            });
                    } else {
                        if (DBAA1 == "1") {
                            if (curUserType == dbaa1SuperSysUserType) {
                                Form.addParameter('z.IPInterfaceIPAddress',getValue('slaveIpAddress'));
                                Form.addParameter('z.IPInterfaceSubnetMask',getValue('slaveSubnetMask'));
                            }
                        } else {
                            Form.addParameter('z.IPInterfaceIPAddress',getValue('slaveIpAddress'));
                            Form.addParameter('z.IPInterfaceSubnetMask',getValue('slaveSubnetMask'));
                        }
                    }
                }
                if((isSetGst == true) && ('1' == gstwfpoolfeature))
                {
                   url = 'set.cgi?'
                      + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1'
                      + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2'
                      + '&w=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.DHCPConditionalServingPool.2'    ;
                }
                else
                {
                   url = 'set.cgi?'
                      + 'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1'
                      + '&z=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2';
                }
            }

        }

        if (('1500' != specIPoEMTUMax) && (IsSupportBridgeWan == 0))
        {
            Form.addParameter('y.X_HW_MTU',getValue('br0MtuRow'));
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            url +='&y=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement';
        }
        url += '&RequestFile=' + RequestFile;
        Form.setAction(url);
    }
    setDisable('dhcpSrvType',1);
}

function OnDeleteButtonClick(TableID)
{
    if ((IsAdminUser() == false) && (GetCfgMode().PTVDF == "1")) {
       return;
    }
    var CheckBoxList = document.getElementsByName(TableName+'rml');
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
    setDisable('Newbutton',1);
    setDisable('DeleteButton',1);
    setDisable('btnApply_ex',1);
    setDisable('cancelValue_ex',1);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('del.cgi?'+'x=InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface' + '&RequestFile=html/bbsp/dhcp/dhcp.asp');
    Form.submit();
}

var DhcpsFeature = "<% HW_WEB_GetFeatureSupport(BBSP_FT_DHCP_MAIN);%>";

function IsSupportConfigFreeArp()
{
    if(DhcpsFeature == "0")
    {
        return false;
    }

    if((curCfgModeWord.toUpperCase() == 'COMMON') ||
	   (curCfgModeWord.toUpperCase() == 'M1') ||
	   (curCfgModeWord.toUpperCase() == 'TR') ||
	   (curCfgModeWord.toUpperCase() == 'MAROCTELECOM'))
    {
       return true;
    }

    return false;
}

function CancelConfig()
{
    LoadFrame();
}

function CancelConfigtde()
{
    if (selctIndex == "-1") 
    {
        setDisplay("SecondaryAddrFormtde",0);      
    }
    else if (selctIndex == -2)
    {
        setDisplay('SecondaryAddrFormtde', 0);
    }
    else
    {
        setCtlDisplay(LanHostInfoValue[selctIndex]);        
        setDisplay('SecondaryAddrFormtde', 1);
    } 
}

function configFreeArp()
{
    var enable = getCheckVal('enableFreeArp');
}

function configEnableSaddress()
{
    var enableslaveaddress = getCheckVal('enableslaveaddress');
    setDisplay('slaveIpAddressRow', enableslaveaddress);
    setDisplay('slaveSubnetMaskRow', enableslaveaddress);
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("dhcptitle", GetDescFormArrayById(dhcp_language, "bbsp_mune"), GetDescFormArrayById(dhcp_language, ""), false);
    if (DhcpsFeature == "1" && bin5board() == false)
    {
      if (SingtelMode == '1')
      {
        document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title']+dhcp_language['bbsp_dhcp_title1_singtel'];
      }
      else if (true == IsSupportConfigFreeArp())
      {
        document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title']+dhcp_language['bbsp_dhcp_title1']+dhcp_language['bbsp_dhcp_title2'];
      }
      else
      {
          if('1' == gstwfpoolfeature && gstuseallslvpool != "1")
          {
              document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title']+dhcp_language['bbsp_dhcp_title1']+dhcp_language['bbsp_dhcp_title3'];
          }
          else
          {
              if ((curCfgModeWord.toUpperCase() == "ROSUNION") && (curLanguage == 'english')) {
                  document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title']+dhcp_language['bbsp_dhcp_title1']+dhcp_language['bbsp_dhcp_title5'];
              } else {
                  document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title']+dhcp_language['bbsp_dhcp_title1'];
              }
          }
      }
    }
    else
    {    
        document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title'];
    }
    if (isBbspFtLswWebCut == '1') 
    {
        document.getElementById("dhcptitle_content").innerHTML = dhcp_language['bbsp_dhcp_title'];
    }
    
</script>
<div class="title_spread"></div>

<form id="FreeArpForm" name="FreeArpForm" style="display:none;">
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li id="enableFreeArp" RealType="CheckBox" DescRef="bbsp_enablefreearpmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_AddressConflictDetectionEnable" InitValue="Empty" InitValue="0"   ClickFuncApp="onclick=configFreeArp"/>
    </table>
    <script>
        var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
        var FreeArpConfigFormList = new Array();
        FreeArpConfigFormList = HWGetLiIdListByForm("FreeArpForm", null);
        HWParsePageControlByID("FreeArpForm", TableClass, dhcp_language, null);
    </script>
    <div id="ConfigFreeArpSpace" class="func_spread"></div>
</form>

<form id="DhcpPripoolForm" name="DhcpPripoolForm">
<script language="JavaScript" type="text/javascript">
    if (SingtelMode == '1')
    {
        document.write('<div id="DhcpPripoolTitle" class="func_title" BindText="bbsp_dhcp_pripool_singtel"></div>');
    }
    else
    {
        document.write('<div id="DhcpPripoolTitle" class="func_title" BindText="bbsp_dhcp_pripool"></div>');
    }
</script>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
<script language="JavaScript" type="text/javascript">
    if (SingtelMode == '1')
    {
        document.write("\<li id=\"ethIpAddress\" RealType=\"TextBox\" DescRef=\"bbsp_ipmh_common_singtel\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"x.IPInterfaceIPAddress\"  MaxLength=\"15\" InitValue=\"Empty\" \/\>");
        document.write("\<li id=\"ethSubnetMask\" RealType=\"TextBox\" DescRef=\"bbsp_maskmh_common_singtel\" RemarkRef=\"bbsp_subnetmaskmh_eg_singtel\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"x.IPInterfaceSubnetMask\"  MaxLength=\"15\"  InitValue=\"Empty\" \/\>")
    }
    else
    {
        document.write("\<li id=\"ethIpAddress\" RealType=\"TextBox\" DescRef=\"bbsp_ipmh_common\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"x.IPInterfaceIPAddress\"  MaxLength=\"15\" InitValue=\"Empty\" \/\>");
        document.write("\<li id=\"ethSubnetMask\" RealType=\"TextBox\" DescRef=\"bbsp_maskmh_common\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"TRUE\" BindField=\"x.IPInterfaceSubnetMask\"  MaxLength=\"15\"  InitValue=\"Empty\" \/\>")
    }
</script>
    </table>
    <script>
        var DhcpPripoolFormList = new Array();
        DhcpPripoolFormList = HWGetLiIdListByForm("DhcpPripoolForm",null);
        HWParsePageControlByID("DhcpPripoolForm",TableClass,dhcp_language,null);
    </script>
</form>

<div id='SecondaryDhcp' style="display:none">
<form id="SecondaryAddrForm" name="SecondaryAddrForm" style="display:none;">
    <div id="SecondaryAddrTitle" class="func_title" BindText="bbsp_dhcp_secpool"></div>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li id="enableslaveaddress" RealType="CheckBox" DescRef="bbsp_enableslaveaddress" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.enable" InitValue="Empty" InitValue="0" ClickFuncApp="onclick=configEnableSaddress"/>
        <li id="slaveIpAddress" RealType="TextBox" DescRef="bbsp_ipslavemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.IPInterfaceIPAddress"  MaxLength="15" InitValue="Empty" />
        <li id="slaveSubnetMask" RealType="TextBox" DescRef="bbsp_maskslavemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.IPInterfaceSubnetMask"  MaxLength="15"  InitValue="Empty" />
    </table>
    <script>
        var DhcpPripoolFormList = new Array();
        DhcpPripoolFormList = HWGetLiIdListByForm("SecondaryAddrForm",null);
        HWParsePageControlByID("SecondaryAddrForm",TableClass,dhcp_language,null);
        if (conditionpoolfeature == '1')
        {
            getElById("enableslaveaddressCol").title = dhcp_language['bbsp_dhcp_con_enable'];
        }
        else
        {
            getElById("enableslaveaddressCol").title = dhcp_language['bbsp_dhcp_slave_enable'];
        }
    </script>
</form>
</div>

<div id="SetMTU" name="SetMTU">
<div class="func_spread"></div>
<form  id="SetDHCpMTU" name="SetDHCpMTU">
    <div id="SecondaryAddrTitle" class="func_title" BindText="bbsp_dhcp_mtu"></div>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
        <li id="br0MtuRow" RealType="TextBox" DescRef="bbsp_dhcp_mtu" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField=""  MaxLength="4"  InitValue="Empty" InitValue="0" />
    </table>
    <script>
        var DhcpSetMTUFormList = new Array();
        DhcpSetMTUFormList = HWGetLiIdListByForm("SetDHCpMTU",null);
        HWParsePageControlByID("SetDHCpMTU",TableClass,dhcp_language,null);
    </script>
</form>
</div>

<div id='dhcpInfo' style="display:none ">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
      <tr>
        <td  class="table_title width_per25" BindText='bbsp_startipmh'></td>
        <td  class="table_right width_per70"> <input type='text' id='dhcpEthStart' name='dhcpEthStart' maxlength='15'> </td>
      </tr>
      <tr>
        <td  class="table_title width_per25" BindText='bbsp_endipmh'></td>
        <td  class="table_right width_per70"> <input type='text' id='dhcpEthEnd' name='dhcpEthEnd' maxlength='15'> </td>
      </tr>
      <tr >
        <td  class="table_title width_per25" BindText='bbsp_leaseunitmh'></td>
        <td  class="table_right width_per70"> <input type="text" id="dhcpLeasedTime" name="dhcpLeasedTime" value="1" size="6">
          <select id='dhcpLeasedTimeFrag' name='dhcpLeasedTimeFrag' size='1'>
            <option value='60'><script>document.write(dhcp_language['bbsp_minute']);</script>
            <option value='3600'><script>document.write(dhcp_language['bbsp_hou']);</script>
            <option value='86400'><script>document.write(dhcp_language['bbsp_day']);</script>
            <option value='604800'><script>document.write(dhcp_language['bbsp_week']);</script>
          </select> </td>
      </tr>
      <tr  style="display:none ">
        <td  class="table_title width_per25" BindText='bbsp_devtypemh' ></td>
        <td  class="table_right width_per70"> <select id='IpPoolIndex' name='IpPoolIndex' size='15' onChange='IpPoolIndexChange()'>
            <option value='1'><script>document.write(dhcp_language['bbsp_stb']);</script>
            <option value='2'><script>document.write(dhcp_language['bbsp_phone']);</script>
            <option value='3'><script>document.write(dhcp_language['bbsp_camera']);</script>
            <option value='4'><script>document.write(dhcp_language['bbsp_computer']);</script>
          </select> </td>
      </tr>
      <tr  style="display:none ">
        <td  class="table_title width_per25" BindText='bbsp_startipmh'></td>
        <td  class="table_right width_per70"> <input type='text' id='dhcpEthStartFrag' name='dhcpEthStartFrag' maxlength='15'> </td>
      </tr>
      <tr style="display:none ">
        <td  class="table_title width_per25" BindText='bbsp_endipmh'></td>
        <td  class="table_right width_per70"> <input type='text' id='dhcpEthEndFrag' name='dhcpEthEndFrag' maxlength='15'> </td>
      </tr>
      <tr style="display:none ">
        <td  class="table_title width_per25" BindText='bbsp_dhcprelaymh'></td>
        <td  class="table_right width_per70"> <input type='checkbox' id='enableRelay' name='enableRelay'> </td>
      </tr>
    </table>
  </div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button" id="commosubmit">
    <tr >
      <td class='width_per30'></td>
      <td class="table_submit">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <button id="btnApply" name="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px"  onClick="ApplyConfig(0);"><script>document.write(dhcp_language['bbsp_app']);</script></button>
        <button name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px"  type="button" onClick="CancelConfig();"><script>document.write(dhcp_language['bbsp_cancel']);</script></button> </td>
    </tr>
  </table>
  <br>
<div class="func_spread"></div>
<script language="JavaScript" type="text/javascript">
    var LanHostlistInfo = new Array(new stTableTileInfo("Empty","align_center width_per5","DomainBox"),
                                        new stTableTileInfo("bbsp_ipslavemh","align_center width_per25","ipaddr",false,25),
                                        new stTableTileInfo("bbsp_maskslavemh","align_center width_per25","subnetmask",false,25),null);
    var ColumnNum = 3;
    var ShowButtonFlag = true;
    var DhcpStaticTableConfigInfoList = new Array();
    var TableDataInfo = HWcloneObject(LanHostInfoValue, 1);
    TableDataInfo.push(null);
    if((IsAdminUser()) && ("1" == GetCfgMode().PTVDF))
    {    
        HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, LanHostlistInfo, dhcp_language, null);
    }
</script>
<form id = "SecondaryAddrFormtde" style="display:none">
    <div id="SecondaryAddrtdeTitle" class="func_title"></div>
    <table border="0" cellpadding="0" cellspacing="1"  width="100%">
        <li id="enableslaveaddresstde" RealType="CheckBox" DescRef="bbsp_enableslaveaddress" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty" InitValue="0" />
        <li id="slaveIpAddresstde" RealType="TextBox" DescRef="bbsp_ipslavemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.IPInterfaceIPAddress"  MaxLength="15" InitValue="Empty" />
        <li id="slaveSubnetMasktde" RealType="TextBox" DescRef="bbsp_maskslavemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="x.IPInterfaceSubnetMask"  MaxLength="15"  InitValue="Empty" />
    </table>
    <script>
        var DhcpPripoolFormListtde = new Array();
        DhcpPripoolFormListtde = HWGetLiIdListByForm("SecondaryAddrFormtde",null);
        HWParsePageControlByID("SecondaryAddrFormtde",TableClass,dhcp_language,null);
    </script>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
    <tr >
      <td class='width_per30'></td>
      <td class="table_submit">
        <input id="btnApply_ex" name="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px"  onClick="NewSubmit(0);" BindText='bbsp_app'>
        <input name="cancelValue_ex" id="cancelValue" class="CancleButtonCss buttonwidth_100px"  type="button" onClick="CancelConfigtde();" BindText='bbsp_cancel'>
    </td>
    </tr>
    </table>
</form>
<script>
    ParseBindTextByTagName(dhcp_language, "td",    1);
    ParseBindTextByTagName(dhcp_language, "input", 2);
    ParseBindTextByTagName(dhcp_language, "div",   1);
</script>
</body>
</html>
