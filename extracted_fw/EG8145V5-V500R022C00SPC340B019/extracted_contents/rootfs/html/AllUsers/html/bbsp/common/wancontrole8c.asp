var CurrentWan = null;
var EditFlag = "";
var ChangeUISource = "";
var AddType     = 1;
var CurrentWan = new WanInfoInst();
var defaultWan  = new WanInfoInst(); 
var COMPLEX_CGI_PREFIX='Add_';
var IsE8C = isE8cAndCMCC();
var MngtShct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SHCT);%>';
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var DefaultMTUSize = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.DefaultWANMTUSize);%>';
var UserModePppoe = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_MOD_PPPOE);%>';
var Option60FT =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_IPTV_OPT60_ENCRY);%>';
var MngtGdct = '<%HW_WEB_GetFeatureSupport(BBSP_FT_GDCT);%>';
var DefaultBridgeMTUSize = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.DefaultBridgeWANMTUSize);%>';
var MngtServiceListPre = "";
var MngtWanModePre = "";
var HideMtu = '<%HW_WEB_GetFeatureSupport(BBSP_FT_TR069_VOIP_NOMTU);%>';
var AddSpecSrvType = '<%HW_WEB_GetFeatureSupport(FT_SUPPORT_SPECAIL_SERVICE);%>';
var enFullRouting = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_E8CIPFwd.IPForwardModeEnabled);%>';
var IsSmartGateWay =  '<%HW_WEB_GetFeatureSupport(FT_FULLROUTE_ROUTEVOICEWAN_NAT);%>';
var IsSupportVoice = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
var IfVisual = "<%HW_WEB_IfVisualOltUser();%>";
var IPV4V6Flag = '<%HW_WEB_GetFeatureSupport(FT_INTERNET_WAN_DEFAULT_DUALSTACK);%>';
var WanForbidModeFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_FORBID_MOD_WANCONNTYPE);%>';
var option60Flag = '<%HW_WEB_GetFeatureSupport(FT_MAC_ROUTE_E8C_OPTION60);%>';
var macRouteCfgEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.X_HW_E8C_MACRouteCfg.Enable);%>';
var mngtScct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SCCT);%>';
var mngtTY40 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TIANYI_40);%>';
var isSupportIPSET = '<%HW_WEB_GetFeatureSupport(FT_IPSET);%>';
var vxlanfeature = <%HW_WEB_GetFeatureSupport(FT_VXLAN);%>;
var CurCfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var typeWordCom = '<%HW_WEB_GetTypeWord();%>';
var VOIP_INIT_FLAG = true;
var VXLAN_VXLANConfig_Interface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.VXLANMAP.VXLANView.{i},RemoteEndPoints|WANInterface|VNI, stVXLANConfig);%>;
var specWanMaxNum = '<%HW_WEB_GetSPEC(BBSP_SPEC_IFM_WANNUM.UINT32);%>';
var isSupportNPTv6 = '<%HW_WEB_GetFeatureSupport(FT_WEB_NPTV6);%>';
var isFullCfgVxlan = "<%HW_WEB_GetFeatureSupport(FT_WEB_FULLCFG_VXLAN);%>";
var is5182H = "<%HW_WEB_GetFeatureSupport(BBSP_FT_DATAPATH_NP);%>";
var isPerfixderived = "<%HW_WEB_GetFeatureSupport(FT_PERFIXDERIVED_SUPPORT);%>";
var isIPV6DemandWan = '<%HW_WEB_GetFeatureSupport(FT_BBSP_IPV6_DEMAND_WAN);%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var SCCTFttrCtrl = '<%HW_WEB_GetFeatureSupport(FT_FTTR_SCCT_CTRL);%>';
var ponOnuBindCrtl = '<%HW_WEB_GetFeatureSupport(FT_FTTR_PON_ONU_BIND_CTRL);%>';
var ponOnuBind = 0;
if ((SCCTFttrCtrl == 1) || (ponOnuBindCrtl == 1)) {
    ponOnuBind = 1;
}
var isSupportPCDN = '<%HW_WEB_GetFeatureSupport(FT_PCDN_SUPPORT);%>';
var scnFT = '<%HW_WEB_GetFeatureSupport(FT_WLAN_SCN_ROAM);%>';
var scnEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_SCN.Enable);%>';
var scnInst5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_SCN.ScnInst5G);%>';
var optin60Info = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i}.X_HW_ExtendDHCPOPTION60.{i},Enable|Type|Account|Password|ValueMode, stOption60Config);%>;
var vlanNoRepeate = '<%HW_WEB_GetFeatureSupport(FT_WEB_VLAN_NOREPEATE);%>';
function stOption60Config(domain, enable, type, account, password, valueMode)
{
  this.domain = domain;
  this.Enable = enable;
  this.Type = type;
  this.Account = account;
  this.Password = password;
  this.ValueMode = valueMode;
}

var CQCTFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CQCT);%>';
var defaultPwd = "********************************";

function iptvConfig(domain, account)
{
    this.domain = domain;
    this.UserID = account;
}

var iptvInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_IPTV,UserID, iptvConfig);%>;
var iptvInfo = iptvInfos[0];

function isHENCmccMode()
{
  if ((CfgModeWord.toUpperCase() === 'HENCMCC_RMS') || (CfgModeWord.toUpperCase() === 'HENCMCC')) {
    return true;
  }

  return false;
}

function isIPv4()
{
  var Wan = GetPageData();
  if ((Wan.ProtocolType.toString().toUpperCase() === "IPV4/IPV6") || (Wan.ProtocolType.toString().toUpperCase() === "IPV4")) {
    return true;
  }

  return false;
}

function isOption60Wan()
{
  if (!isIPv4()) {
    return false;
  }

  var Wan = GetPageData();
  var WanMode = Wan.Mode.toString().toUpperCase();
  var encapMode = CurrentWan.EncapMode.toString().toUpperCase();
  var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();
  if (isHENCmccMode() && (WanMode === "IP_ROUTED") && (encapMode === "IPOE") &&
     ((ServiceList.indexOf("IPTV") >= 0) && (ServiceList.indexOf("VOIP") < 0))) {
    return true;
  }

    return false;
}

function checkWanOptionEnable() 
{
  if (getCheckVal('WanOption60_Enable') === 1) {
    setDisplay("WanOption60_UserRow", 1);
    setDisplay("WanOption60_PasswordRow", 1);
  } else {
    setDisplay("WanOption60_UserRow", 0);
    setDisplay("WanOption60_PasswordRow", 0);
  }
}

function IsIPOEOtherRouteWan(wan)
{
    return ((wan.EncapMode.toString().toUpperCase() == "IPOE") && (wan.ServiceList.toString().toUpperCase() == "OTHER") &&
            (wan.Mode.toString().toUpperCase() == "IP_ROUTED"));
}

function controlDhcpOption60()
{
    if (CQCTFlag != 1) {
        return;
    }

    if (getCheckVal("DhcpOption60Enable") == '1'){
        setDisplay("DhcpOption60ModeRow", 1);
        setDisplay("DhcpOption60TypeRow", 1); 
        if (getValue('DhcpOption60Mode') == ''){
            setText('DhcpOption60Mode', 2);            
        }
        if (getValue('DhcpOption60Type') == ''){
            setText('DhcpOption60Type', 34);
        }        
    }else{
        setDisplay("DhcpOption60ModeRow", 0);
        setDisplay("DhcpOption60TypeRow", 0);        
    }    

    return;
}

function OtherWanProcess()
{
    if (CQCTFlag != 1) {
        return;
    }

    setDisplay("IPTVAuthUserNameRow", 0);
    setDisplay("IPTVAuthPassWordRow", 0);
    setDisplay("DhcpOption60EnableRow", 0);
    setDisplay("DhcpOption60ModeRow", 0);
    setDisplay("DhcpOption60TypeRow", 0);

    var wan = GetPageData();
    if (IsIPOEOtherRouteWan(wan)) {
        setDisplay("IPTVAuthUserNameRow", 1);
        setDisplay("IPTVAuthPassWordRow", 1);
        setDisplay("DhcpOption60EnableRow", 1);        
        var tempOption60;
        for (var i = 0; i < optin60Info.length - 1; i++) {
            tempOption60 = (optin60Info[i].domain).split(".X_HW_ExtendDHCPOPTION60.1");
            if (tempOption60[0] == wan.domain) {
                if (optin60Info[i].Enable == "0") {
                    getElementById("DhcpOption60Enable").checked = false;
                } else {
                    getElementById("DhcpOption60Enable").checked = true;
                    setDisplay("DhcpOption60ModeRow", 1);
                    setDisplay("DhcpOption60TypeRow", 1);                    
                }
                setText("DhcpOption60Mode", optin60Info[i].ValueMode);
                setText("DhcpOption60Type", optin60Info[i].Type);
            }
        }  
                
        if (wan.domain != "") {
            setText("IPTVAuthUserName", iptvInfo.UserID);
            setText("IPTVAuthPassWord", defaultPwd);
        } else {
           setText("IPTVAuthUserName", "");
           setText("IPTVAuthPassWord", "");
           setText("DhcpOption60Mode", "");
           setText("DhcpOption60Type", "");
        }
    }  
}

function option60WanProcess()
{
  setDisplay("WanOption60_EnableRow", 1);
  if (!isOption60Wan()) {
    setDisplay("WanOption60_EnableRow", 0);
    setDisplay("WanOption60_UserRow", 0);
    setDisplay("WanOption60_PasswordRow", 0);
  } else {
    var Wan = GetPageData();
    var tempOption60;
    for (var i = 0; i < optin60Info.length - 1; i++) {
      tempOption60 = (optin60Info[i].domain).split(".X_HW_ExtendDHCPOPTION60");
      if (tempOption60[0] == Wan.domain) {
        if (optin60Info[i].Enable == "0") {
          getElementById("WanOption60_Enable").checked = false;
        } else {
          getElementById("WanOption60_Enable").checked = true;
        }
        setText("WanOption60_User", optin60Info[i].Account);
        setText("WanOption60_Password", optin60Info[i].Password);
      }
    }

    if (Wan.domain === "") {
      setText("WanOption60_User", "");
      setText("WanOption60_Password", "");
    }

    checkWanOptionEnable();
  }
}

function stVXLANConfig(domain, RemoteEndPoints, WANInterface, VNI)
{
    this.domain = domain;
    this.RemoteEndPoints = RemoteEndPoints;
    this.WANInterface = WANInterface;
    this.VNI = VNI;
}

function SupportNPTv6(wan) {
    if (((mngtTY40 == '1') || (isSupportNPTv6 == '1')) && (wan.Mode.toString().toUpperCase() == "IP_ROUTED")
        && ((wan.ServiceList.indexOf("INTERNET") >=0 ) || (wan.ServiceList.indexOf("IPTV") >=0) 
        || (wan.ServiceList.indexOf("OTHER") >=0) || (wan.ServiceList.indexOf("OTT") >= 0)
        || (wan.ServiceList.indexOf("SPECIAL_SERVICE") >= 0))) {
        return true;
    }
    return false;
}

function speedTestControl() {
    setDisplay("Speed_limit_upRow", 0);
    setDisplay("Speed_limit_downRow", 0);
    if (mngtTY40 == '1') {
        setDisplay("Speed_limit_upRow", 1);
        setDisplay("Speed_limit_downRow", 1);
	}
}	

function ipPingResponseControl() {
    var supportFlag = isSupportPingReponse();
    setDisplay("PingResponseEnableRow", supportFlag);
    setDisplay("PingResponseWhiteListRow", supportFlag);
    if (CurrentWan.X_HW_PingResponseEnable == 1) {
        setDisable("PingResponseWhiteList", 0);
    } else {
        setDisable("PingResponseWhiteList", 1);
    }
}

function IsCmcc_rmsMode()
{
	var Custom_cmcc_rms =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
	if ('1' == Custom_cmcc_rms )
	{
		return true;
	}
	else
	{
		return false;
	}	
}


function SetCurrentWan(Wan)
{
    CurrentWan = Wan;
}
function GetCurrentWan()
{
    if (CurrentWan != null)
    {
        return CurrentWan;
    }
    
    return GetPageData();
}
function IsConTrigCanBeSend(Wan)
{
    if (Wan.Mode.toString().toUpperCase() == 'IP_ROUTED' && Wan.ServiceList.toString().toUpperCase() == 'INTERNET') 
    {
        return true;
    } 
    
    return false;
}


function GetOriginalWan(Domain)
{
	var WanList = GetWanList();
	
	for (var i = 0; i < WanList.length; i++)
	{
		if (WanList[i].domain == Domain)
		{
			return WanList[i];
		}
	}

	return null;
}

function IsConnectionTypeChange()
{
	var CurrentWan = GetCurrentWan();
	var OriginalWan = GetOriginalWan(CurrentWan.domain);
	if (OriginalWan == null)
	{
		return true;
	}

	var CurrentType = (CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) ? "BRIDGE" : "ROUTE";
	var OriginalType = (OriginalWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) ? "BRIDGE" : "ROUTE";

	return (CurrentType == OriginalType) ? false : true;
}

function IsOriginalTr069Type()
{
	var CurrentWan = GetCurrentWan();
	var OriginalWan = GetOriginalWan(CurrentWan.domain);
	if (OriginalWan == null)
	{
		return false;
	}

	return (OriginalWan.ServiceList.toUpperCase().indexOf("TR069") >= 0) ? true : false;
}

function getMtuMaxAllowCfg(Wan)
{
    var specIPoEMTUMax = '<%HW_WEB_GetSPEC(SPEC_LOWER_LAYER_MAX_MTU.UINT32);%>';
    var maxMtuCfg = 1540;

    if (parseInt(specIPoEMTUMax, 10) != 1500) {
        if (IsCmcc_rmsMode()) {
            maxMtuCfg = parseInt(specIPoEMTUMax, 10) - 8;
            return maxMtuCfg; 
        }

        if(Wan.IPv4AddressMode.toUpperCase() == "PPPOE") {
            maxMtuCfg = parseInt(specIPoEMTUMax, 10) - 8;
        } else {
            maxMtuCfg = parseInt(specIPoEMTUMax, 10);
        }
    }
    return maxMtuCfg;
}

function ControlSpec()
{
    setDisplay("WanDomainRow", 0);
    setDisplay("IPv6SubnetMaskRow", 0);
    setDisplay("IPv6DefaultGatewayRow", 0); 
     
    var FeatureInfo = GetFeatureInfo(); 
    if (FeatureInfo.IPv6 == "0")
    {
        
        setDisplay("WanIPv4InfoBarRow", 0);
        setDisplay("WanIPv6InfoBarRow", 0);
		setDisplay("WanPrefix_checkboxRow", 0);
        setDisplay("WanPrefix_selectRow", 0);
        setDisplay("WanIPv6Address_Pre_textRow", 0);
		setDisplay("WanIPv6Address_selectRow", 0);
		
        setDisplay("IPv6AddressStuffRow", 0);   
        setDisplay("WanIPv6Address_textRow", 0);
        setDisplay("IPv6AddrMaskLenE8cRow", 0);
        setDisplay("WanIPv6_Gateway_textRow", 0);
		setDisplay("IPv6ReserveAddress", 0);
        setDisplay("IPv6SubnetMaskRow", 0);
        setDisplay("IPv6DefaultGatewayRow", 0);
        setDisplay("WanIPv6Pri_DNS_textRow", 0);
        setDisplay("WanIPv6Sec_DNS_textRow", 0);  
        setDisplay("IPv6WanMVlanIdRow", 0);     
        setDisable("WanIP_Mode_select", 1);
        setSelect("WanIP_Mode_select", "IPv4");

    }
    if (FeatureInfo.WanPriPolicy == "0")
    {
        setDisplay("PriorityPolicyRow", 0);
    }
}

function ControlPanel()
{
    var Wan = GetCurrentWan();
    var Type = Wan.ProtocolType.toString();
    var IPv4BarIndex = 0;
    var IPv6BarIndex = 0;
    

    setDisplay("WanIPv4InfoBarPanel", 0);
    setDisplay("WanIPv6InfoBarPanel", 0);
   
    if (Type.toUpperCase()=="IPV4")
    {
        setDisplay("WanIPv4InfoBarPanel", 1);
    }
    
    if (Type.toUpperCase()=="IPV6")
    {
        setDisplay("WanIPv6InfoBarPanel", 1);
    }
    
    if (Type.toUpperCase()=="IPV4/IPV6")
    {
        setDisplay("WanIPv4InfoBarPanel", 1);
        setDisplay("WanIPv6InfoBarPanel", 1);
    }
    
}


function ControlIPv4AddressMode()
{
    setDisplay("WanIPv4Address_selectRow", 1);
    if (GetCurrentWan().Mode.toString().toUpperCase() != "IP_ROUTED")
    {
        setDisplay("WanIPv4Address_selectRow", 0);
    }

}

function ControlIPv4DHCPEnable()
{
    var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();
    var src = getElementById('WanServiceList_select');
    
    setDisplay("LanDhcpSwitchRow", 0);
    if ( ServiceList.match('INTERNET')
    || ServiceList.match('IPTV') 
    || ServiceList.match('OTT')
    || ServiceList.match('OTHER')
    || ServiceList.match('SPECIAL_SERVICE'))
    {
        if(isE8cAndCMCC())
        {
	        setDisplay("LanDhcpSwitchRow", 1);
	    }		
    }
	
    if(EditFlag.toUpperCase() == "ADD" && ChangeUISource == src)
    {
        if (ServiceList == "OTHER")
	    {
            setCheck("LanDhcpSwitch", 0);
        }
	    else
	    {
	        setCheck("LanDhcpSwitch", 1);
	    }
    }
}

function ControlVxlanEnable() {
    var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();

    setDisplay("Vxlan_EnableRow", 0);
    if ((vxlanfeature == 1) && (isFullCfgVxlan != 1)) {
        if ((ServiceList.indexOf("INTERNET") >=0) && (GetCurrentWan().EncapMode.toString().toUpperCase() != "PPPOE")) {
            if (is5182H != 1) {
                setDisplay("Vxlan_EnableRow", 1);
            }

            if ((GetCurrentWan().X_HW_VXLAN_Enable.toString().toUpperCase() == "1") || (getCheckVal('Vxlan_Enable') == 1)) {
                setCheck("Vxlan_Enable", 1);
                if (EditFlag.toUpperCase() == "ADD") {
                    setCheck("WanSwitch", 0);
                }
                setDisable("WanSwitch", 1);
            } else {
                setCheck("Vxlan_Enable", 0);
                setDisable("WanSwitch", 0);
            }
        }
    }
}

function IsDstIPForwardingListVisibility(Wan,ServiceList)
{
	if (   (ServiceList == "TR069")
	     ||(ServiceList == "VOIP")
	     ||(ServiceList == "TR069_VOIP")
	     ||(ServiceList == "HON")
	     ||("IP_BRIDGED" == Wan.Mode.toString().toUpperCase()) 
	     ||("PPPOE_BRIDGED" == Wan.Mode.toString().toUpperCase()))
	{
		return false;
	}
	if ('E8C' != CurrentBin.toUpperCase())
	{
		return false;
	}
	return true;
}

function ControlDstIPForwardingListVisibility()
{
	var Wan = GetCurrentWan();
	var ServiceList = Wan.ServiceList;
	
	setDisplay("DstIPForwardingListRow", 0);
	setDisplay("DstIPForwardingList", 0);
	setDisplay("DstIPForwardingListRow", 1);
	setDisplay("DstIPForwardingList", 1);
	
	if ( false == IsDstIPForwardingListVisibility(Wan,ServiceList) )
	{
		setDisplay("DstIPForwardingListRow", 0);
		setDisplay("DstIPForwardingList", 0);
	}
}

function RemoveAllFromSelectByKey(objSelect, objItemKey) 
{             
	for (var i = objSelect.options.length -1 ; i >= 0; i--) 
	{  
		if(objSelect.options[i].value.indexOf(objItemKey) >= 0 )  
		{ 
            objSelect.options[i]=null;            
        }     
    }
}

function RemoveItemFromSelect(objSelect, objItemValue) 
{             
    for (var i = 0; i < objSelect.options.length; i++) 
	{  
	
		if(objSelect.options[i].value == objItemValue) 
		{        
            objSelect.options[i]=null;         
            break;        
        }     
    }
}

function displayWanMode()
{
}

function displayProtocolType()
{
	var protoType = getElementById('WanIP_Mode_select');
	var IPProtVer = Instance_IPVersion.GetIPProtVerMode();
	var Feature = GetFeatureInfo();

	if ((EditFlag.toUpperCase() == "ADD") && (Feature.IPProtChk == 1) && (IPProtVer == 1))
	{
		RemoveItemFromSelect(protoType, Languages['IPv4IPv6']);
		RemoveItemFromSelect(protoType, Languages['IPv6']);
	}
	else if ((EditFlag.toUpperCase() == "ADD") && (Feature.IPProtChk == 1) && (IPProtVer == 2))
	{
		RemoveItemFromSelect(protoType, Languages['IPv4IPv6']);
		RemoveItemFromSelect(protoType, Languages['IPv4']);
	}
}

function displaysvrlist() 
{
	if (EditFlag.toUpperCase() == "ADD")
	{
		Controlsvrlist();
	}
}

function bin4board_nonvoice()
{
	if(productName == 'HG8045A' || productName == 'HG8045H' || productName == 'HG8045D' || productName == 'HG8021H' || productName == 'HG8045A2')
	{
		return true;
	}
	return false;
}

function ControlWanIPMode()
{
    var Wan = GetCurrentWan();
	
	if((getValue('WanConnectMode_select').toString().toUpperCase().indexOf("ROUTE") >= 0) && (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0))
	{
		Wan.ProtocolType = "IPv4/IPv6";
		Wan.IPv4Enable = "1";
		Wan.IPv6Enable = "1";
		setSelect("WanIP_Mode_select","IPv4/IPv6");
	}
}

function isPortInAttrName()
{
    return ((TianYiFlag == 1) && (CurrentBin.toUpperCase() == 'E8C'));
}

function Controlsvrlist()
{
	var svrlist = getElementById('WanServiceList_select');
	var Wan = GetCurrentWan();
	var SrvLang = (1 == '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_AHCT);%>')? "AHCT" : "e8c";
	
	svrlist.options.length = 0;
    
    if (IsCmcc_rmsMode())
    {
        svrlist.options.add(new Option(Languages['TR069' + SrvLang],Languages['TR069']));
        svrlist.options.add(new Option(Languages['INTERNET' + SrvLang],Languages['INTERNET']));
        svrlist.options.add(new Option(Languages['VOIP' + SrvLang],Languages['VOIP']));
        svrlist.options.add(new Option(Languages['IPTV' + SrvLang],Languages['IPTV']));
        svrlist.options.add(new Option(Languages['OTT' + SrvLang],Languages['OTT']));
        svrlist.options.add(new Option(Languages['OTHER' + SrvLang],Languages['OTHER']));
        svrlist.options.add(new Option(Languages['VOIP_INTERNET' + SrvLang],Languages['VOIP_INTERNET']));
        svrlist.options.add(new Option(Languages['VOIP_IPTV' + SrvLang],Languages['VOIP_IPTV']));
        svrlist.options.add(new Option(Languages['TR069_INTERNET' + SrvLang],Languages['TR069_INTERNET']));
        svrlist.options.add(new Option(Languages['TR069_VOIP' + SrvLang],Languages['TR069_VOIP']));
        svrlist.options.add(new Option(Languages['TR069_VOIP_INTERNET' + SrvLang],Languages['TR069_VOIP_INTERNET']));
        svrlist.options.add(new Option(Languages['TR069_IPTV' + SrvLang],Languages['TR069_IPTV']));
        svrlist.options.add(new Option(Languages['TR069_VOIP_IPTV' + SrvLang],Languages['TR069_VOIP_IPTV']));
    }
    else
    {
        svrlist.options.add(new Option(Languages['TR069' + SrvLang],Languages['TR069']));
        svrlist.options.add(new Option(Languages['INTERNET' + SrvLang],Languages['INTERNET']));
        svrlist.options.add(new Option(Languages['VOIP' + SrvLang],Languages['VOIP']));
        svrlist.options.add(new Option(Languages['OTHER' + SrvLang],Languages['OTHER']));
        svrlist.options.add(new Option(Languages['VOIP_INTERNET' + SrvLang],Languages['VOIP_INTERNET']));
        svrlist.options.add(new Option(Languages['TR069_INTERNET' + SrvLang],Languages['TR069_INTERNET']));
        svrlist.options.add(new Option(Languages['TR069_VOIP' + SrvLang],Languages['TR069_VOIP']));
        svrlist.options.add(new Option(Languages['TR069_VOIP_INTERNET' + SrvLang],Languages['TR069_VOIP_INTERNET']));
	}

    if (((mngtTY40 == '1') || (!isPortInAttrName())) && (EditFlag.toUpperCase() != "ADD")) {
        svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_VR_E8C'],Languages['SPECIAL_SERVICE_VR']));
    }

	if (1 == AddSpecSrvType)
	{
	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_1'],Languages['SPECIAL_SERVICE_1']));
	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_2'],Languages['SPECIAL_SERVICE_2']));
	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_3'],Languages['SPECIAL_SERVICE_3']));
	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_4'],Languages['SPECIAL_SERVICE_4']));
	}

  if ((isSupportPCDN == '1') && (typeWordCom != 'CDN') && (typeWordCom != 'V8XXC')) {
    svrlist.options.add(new Option(Languages['HON'], Languages['HON']));
  }

	svrlist.value = Languages['INTERNET'] ;
	
	if(getValue('WanConnectMode_select').toString().toUpperCase().indexOf("BRIDGED") >= 0)
	{
		svrlist.options.length = 0;

        if ((WanForbidModeFlag != 1) || (EditFlag.toUpperCase() != "ADD")) {
            svrlist.options.add(new Option(Languages['INTERNET' + SrvLang],Languages['INTERNET']));
        }

        if (IsCmcc_rmsMode())
        {
            svrlist.options.add(new Option(Languages['IPTV' + SrvLang],Languages['IPTV']));
            svrlist.options.add(new Option(Languages['OTT' + SrvLang],Languages['OTT']));
        }
        
		svrlist.options.add(new Option(Languages['OTHER' + SrvLang],Languages['OTHER']));

		if (1 == AddSpecSrvType)
    	{
    	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_1'],Languages['SPECIAL_SERVICE_1']));
    	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_2'],Languages['SPECIAL_SERVICE_2']));
    	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_3'],Languages['SPECIAL_SERVICE_3']));
    	    svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_4'],Languages['SPECIAL_SERVICE_4']));
    	}
		
		switch(GetCurrentWan().ServiceList.toString().toUpperCase()) 
		{
			case Languages['INTERNET']:
            case Languages['IPTV']:
			case Languages['OTT']:
			case Languages['OTHER']:
			case Languages['SPECIAL_SERVICE_1']:
			case Languages['SPECIAL_SERVICE_2']:
			case Languages['SPECIAL_SERVICE_3']:
			case Languages['SPECIAL_SERVICE_4']:
				svrlist.value = GetCurrentWan().ServiceList.toString().toUpperCase();
				break;
			default:
			  if (EditFlag.toUpperCase() != "ADD"){
				var servalue = GetCurrentWan().ServiceList.toString().toUpperCase();
					if(servalue == Languages['TR069'])
					{
						svrlist.options.add(new Option(Languages['TR069' + SrvLang],"TR069"));
						setSelect("WanServiceList_select","TR069");
					}
					if(servalue == Languages['TR069_INTERNET'])
					{
						svrlist.options.add(new Option(Languages['TR069_INTERNET' + SrvLang],"TR069_INTERNET"));
						setSelect("WanServiceList_select","TR069_INTERNET");
					}
					if(servalue == Languages['TR069_VOIP'])
					{
						svrlist.options.add(new Option(Languages['TR069_VOIP' + SrvLang],"TR069_VOIP"));
						setSelect("WanServiceList_select","TR069_VOIP");
					}
					if(servalue == Languages['VOIP'])
					{
						svrlist.options.add(new Option(Languages['VOIP' + SrvLang],"VOIP"));
						setSelect("WanServiceList_select","VOIP");
					}
					if(servalue == Languages['VOIP_INTERNET'])
					{
						svrlist.options.add(new Option(Languages['VOIP_INTERNET' + SrvLang],"VOIP_INTERNET"));
						setSelect("WanServiceList_select","VOIP_INTERNET");
					}
					if(servalue == Languages['TR069_VOIP_INTERNET'])
					{
						svrlist.options.add(new Option(Languages['TR069_VOIP_INTERNET' + SrvLang],"TR069_VOIP_INTERNET"));
						setSelect("WanServiceList_select","TR069_VOIP_INTERNET");
					}
					}
				break;
		}
		
		return ;
	}
	
	var src = getElementById('WanServiceList_select');
	if ((IPV4V6Flag == 1) && (EditFlag == "ADD") && (ChangeUISource == src)) {
		ControlWanIPMode();
	}
	
	if ((bin4board_nonvoice() == true)&&(selctIndex == -1))
	{
		RemoveAllFromSelectByKey(svrlist , Languages['VOIP']);
	}
	
	svrlist.value = Wan.ServiceList.toString().toUpperCase();
	CleanServiceListVoip();
	return;

}

function ControlIPv4MXU(Wan)
{
    var WanProtocolType = GetCurrentWan().ProtocolType.toString();
    var WanIPv6DSLite = GetCurrentWan().IPv6DSLite.toString();
    
    document.getElementById("WanMTU_textRow").cells[0].innerHTML = Languages['IPv4MXUe8c'];
	
    setDisplay("WanMTU_textRow", 1);
	
	if ((GetCurrentWan().Mode.toString().toUpperCase() != "IP_ROUTED") 
		|| (GetCfgMode().PCCWHK == "1")
		|| (("1" == HideMtu) && (Wan.ServiceList == 'TR069_VOIP'))
	    )
	{
		setDisplay("WanMTU_textRow", 0);
	}

	if ((GetCurrentWan().Mode.toString().toUpperCase() != "IP_ROUTED") 
		&& (MngtGdct == 1))
	{
	    setDisplay("WanMTU_textRow", 1);
	}
			
    if ((MngtGdct == 1) && (EditFlag.toUpperCase() == "ADD"))
    {

		var MngtWanModeCur = GetCurrentWan().Mode.toString().toUpperCase();

		if (MngtWanModeCur != MngtWanModePre)
		{
			if(GetCurrentWan().Mode.toString().toUpperCase() == "IP_ROUTED") 
			{
				setText('WanMTU_text', 1492);	
			}
			else
			{
				setText('WanMTU_text', 1500);	
			}
		}        
		MngtWanModePre = MngtWanModeCur;

    }
    
    var MTUIPv4 = "(1-1540)";
    var MTUIPv6 = "(1280-1540)";
    if (IsCmcc_rmsMode()) {
        MTUIPv4 = "(1-1800)";
        MTUIPv6 = "(1280-1800)";
    }
    if (WanProtocolType.match("IPv6")) {
        document.getElementById("WanMTU_textRemark").innerHTML = MTUIPv6;
        getElById('WanMTU_text').title = MTUIPv6;
    } else {
        document.getElementById("WanMTU_textRemark").innerHTML = MTUIPv4;
        getElById('WanMTU_text').title = MTUIPv4;
    }
}

function CheckWanSet(Wan)
{
	if(productName == 'HG8110H')
	{
		if ((Wan.ServiceList.toString().toUpperCase() != "TR069") && (Wan.ServiceList.toString().toUpperCase() != "VOIP") && (Wan.ServiceList.toString().toUpperCase() != "TR069_VOIP"))
		{
			AlertEx(Languages['CantSetInvalidSrv']);
			return false;
		}
	}
	
	return true;
}

function ControlIPv4EnableNAT()
{
    var ServiceList = GetCurrentWan().ServiceList.toString().toUpperCase();
        
    setDisplay("IPv4NatSwitchRow", 0);
    setDisplay("IPv4NatTypeRow", 0);	
    
    if (FeatureInfo.LanSsidWanBind == "0")
    {
        return;    
    }
    
    if (GetCurrentWan().Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0)
    {
       setCheck('IPv4NatSwitch', 1);
       return; 
    }
    
    if ( (ServiceList.indexOf("INTERNET") >=0 )
    || (ServiceList.indexOf("IPTV") >=0) 
    || (ServiceList.indexOf("OTHER") >=0) 
    || (ServiceList.indexOf("OTT") >= 0)
    || (ServiceList.indexOf("SPECIAL_SERVICE") >= 0))
    {
		setDisplay("IPv4NatSwitchRow", 1);
          
        if (("1" == GetCfgMode().TELMEX)
	  	||("1" == GetCfgMode().PCCWHK)
	  	||("1" == GetCfgMode().MOBILY)
	  	||("1" == GetRunningMode()))
		{
            setDisplay("IPv4NatTypeRow", 0);	
		}
        else
        {
        	setDisplay("IPv4NatTypeRow", 1);	
        }
        
        if (GetCurrentWan().IPv4NATEnable.toString().toUpperCase() == "1")
    	{
 			setDisable("IPv4NatType", 0);   
    	}
    	else
    	{
    		setDisable("IPv4NatType", 1);
    	}
    }

	var  IsSmartGateWaySupportWan = (('1' == enFullRouting)&&('1' == IsSupportVoice)&&( '1' == IsSmartGateWay));
	var IsInitAdd = ((true == VOIP_INIT_FLAG)&&(EditFlag.toUpperCase() == "ADD"));

	if(true == IsSmartGateWaySupportWan)
	{
		if(true == IsInitAdd)
		{
			setCheck('IPv4NatSwitch', 1);
		}
	}	
	
	if (('VOIP' == GetCurrentWan().ServiceList.toUpperCase())&&(true == IsSmartGateWaySupportWan))
	{
		setDisplay("IPv4NatSwitchRow", 1);
	
		if(true == IsInitAdd)
		{
			setCheck('IPv4NatSwitch', 0);
		}
	}
}

function ControlLanEnableHost(Wan)
{
    if (CurrentBin.toUpperCase() != 'E8C') {
        return;
    }

    setDisplay("LanHostSwitchRow", 0);
    if ((Wan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0) &&
        (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0)) {
        setDisplay("LanHostSwitchRow", 1);
        if (Wan.domain == null) {
            return;
        }
        var LanHostEnable = GetBridgeHostInfo(Wan.domain);
        if(LanHostEnable == 1) {
            setCheck('LanHostSwitch',1);
        } else {
            setCheck('LanHostSwitch',0);
        }
    }
    return; 
}

function ControlVlanId()
{
	var VlanId;
    setDisplay("WanVlanID_textRow", 0);
    if (GetCurrentWan().EnableVlan.toString().toUpperCase() == "1")
    {
        setDisplay("WanVlanID_textRow", 1);
		VlanId = GetCurrentWan().VlanId;
		if (0 == VlanId)
		{
			if (GetCurrentBin().toUpperCase() == "E8C")
			{
				setText('WanVlanID_text',1);
			}
			else
        	{
				setText('WanVlanID_text','');
			}
		}
    } else {
        if (vlanNoRepeate === '1') {
          setText('WanVlanID_text',''); 
        }
    }
}


function ControlIPv4VendorId()
{
    setDisplay("IPv4VendorIdRow", 0);
    if (GetCurrentWan().Mode.toString().toUpperCase() == "IP_ROUTED" && GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == "DHCP")
    {
        setDisplay("IPv4VendorIdRow", 1);
    }
}


function ControlIPv4ClientId()
{
    setDisplay("IPv4ClientIdRow", 0);
    if ( (!isE8cAndCMCC()) && GetCurrentWan().Mode.toString().toUpperCase() == "IP_ROUTED" && GetCurrentWan().IPv4AddressMode.toString().toUpperCase() == "DHCP")
    {
        setDisplay("IPv4ClientIdRow", 1);
    }
}


function ControlIPv4StaticIPAddress()
{
    var IPv4AddressType = GetCurrentWan().IPv4AddressMode.toString().toUpperCase();
    setDisplay("WanIPv4Address_textRow", 0);
    setDisplay("WanSubmask_textRow", 0);
    setDisplay("WanGateway_textRow", 0);
    setDisplay("WanPri_DNS_textRow", 0);
    setDisplay("WanSec_DNS_textRow", 0);
    if (IPv4AddressType == "STATIC" && GetCurrentWan().Mode.toString().toUpperCase() == "IP_ROUTED")
    {
		setDisplay("WanIPv4Address_textRow", 1);
		setDisplay("WanSubmask_textRow", 1);
		setDisplay("WanGateway_textRow", 1);
		setDisplay("WanPri_DNS_textRow", 1);
		setDisplay("WanSec_DNS_textRow", 1);
    }

}


function ControlUserName()
{
    var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();
    setDisplay("WanUserName_textRow", 0);
    setDisplay("WanPassword_textRow", 0);

    setDisable("WanUserName_text",0);
    setDisable("WanPassword_text",0);
	
    if (EncapMode == "PPPOE" && GetCurrentWan().Mode == "IP_Routed")
    {
        setDisplay("WanUserName_textRow", 1);
        setDisplay("WanPassword_textRow", 1);
    }   

	if(Instance_IspWlan.IsOnlyReadWan( GetCurrentWan()))
    {
		setDisable("WanUserName_text",1);
		setDisable("WanPassword_text",1);
	}	
}

function ControlApplyButton()
{
	var DisableButton = false; 

	if (!IsAdminUser())
	{
		var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();

		if(EncapMode == "PPPOE" && GetCurrentWan().Mode == "IP_Routed")
		{
			DisableButton = false;	
		}
		else
		{
			DisableButton = true;
		}

		if( GetCurrentWan().ServiceList.toString().toUpperCase() =='INTERNET'
				&&  GetCfgMode().BJCU == "1" )
		{
			DisableButton = false;
		}        
	}
	
	if ("ADD" == EditFlag.toUpperCase())
	{
		if((vxlanfeature == 1) && (GetWanList().length >= specWanMaxNum))
		{
			DisableButton = true;
		}
		else if((vxlanfeature == 0) && (GetWanList().length >= 8))
		{
			DisableButton = true;
		}
	}

	setDisable("ButtonApply", DisableButton?1:0);
	setDisable("ButtonCancel", DisableButton?1:0);
}

function ControlLcpCheck()
{
    var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();
    setDisplay("LcpEchoReqCheckRow", 0);
    if ((!isE8cAndCMCC()) && EncapMode == "PPPOE" && GetCurrentWan().Mode == "IP_Routed")
    {
        setDisplay("LcpEchoReqCheckRow", 1);
    }    
}


function ControlIPv4Dial()
{
    setDisplay("IPv4DialModeRow", 0);
    setDisplay("IPv4DialIdleTimeRow", 0);
    setDisplay("IPv4IdleDisconnectModeRow", 0);     
    
    if (GetCurrentWan().IPv6Enable.toString().toUpperCase() == "1" && (isIPV6DemandWan != '1'))
    {
        return;
    }

    if (GetCurrentWan().Mode.toString().toUpperCase() != "IP_ROUTED")
    {
        return;
    }
    
    if (GetCurrentWan().IPv4AddressMode.toString().toUpperCase() != "PPPOE")
    {
        return;
    }
    

    if (GetCurrentWan().ServiceList.toString().toUpperCase() != "INTERNET")
    {
        return;
    }
    
    setDisplay("IPv4DialModeRow", 1);
    if (GetCurrentWan().IPv4DialMode.toString().toUpperCase() == "ONDEMAND") 
    {
        setDisplay("IPv4DialIdleTimeRow", 1); 
        setDisplay("IPv4IdleDisconnectModeRow",1);  
        
        if(GetCurrentWan().IPv4NATEnable.toString().toUpperCase() != "1")
        {
           setDisplay("IPv4IdleDisconnectModeRow",0);
        }
        if(SetIdleDisconnectMode == "1")
        {
            setDisable("IPv4IdleDisconnectMode", 1);
            setSelect("IPv4IdleDisconnectMode", "DetectUpstream");
        }
		if ("1" == supportTelmex)
		{
			setDisplay("IPv4IdleDisconnectModeRow",0);    
		}
        
    }    
}

function ControlMVlan(IPvx)
{
    var Wan = GetCurrentWan();
    setDisplay(IPvx+"WanMVlanIdRow", 1);
    
    if ( '0' == FeatureInfo.RouteWanMulticastIPoE && "IP_ROUTED" == Wan.Mode.toString().toUpperCase())
    {
        setDisplay(IPvx+"WanMVlanIdRow", 0);
        return;
    }
    if ('0' == FeatureInfo.BridgeWanMulticast && ("IP_BRIDGED" == Wan.Mode.toString().toUpperCase() || "PPPOE_BRIDGED" == Wan.Mode.toString().toUpperCase()))
    {
        setDisplay(IPvx+"WanMVlanIdRow", 0);
        return;
    } 

	if((productName == 'HG8240') && ("IP_ROUTED" == Wan.Mode.toString().toUpperCase()))
	{
		setDisplay(IPvx+"WanMVlanIdRow", 0);
		return;
	}
	
    if ((Wan.ServiceList =="TR069") || (Wan.ServiceList == "VOIP")
         || (Wan.ServiceList =="TR069_VOIP") || (Wan.ServiceList =="OTT" && IsCmcc_rmsMode()))
    {
        setDisplay(IPvx+"WanMVlanIdRow",0);
        return;
    }
    else
    {
        setDisplay(IPvx+"WanMVlanIdRow",1);
    }

	var WanProtocolType = GetCurrentWan().ProtocolType.toString();
	var WanEnableDSLite = GetCurrentWan().EnableDSLite.toString();
	if (WanProtocolType == "IPv6")
	{
		if(WanEnableDSLite == "1")
		{
			setDisplay(IPvx+"WanMVlanIdRow", 0);
			return;
		}
		else
		{
			setDisplay(IPvx+"WanMVlanIdRow",1);
		}
	}
	if (Is3TMode())
	{
		if (WanProtocolType == "IPv4/IPv6")
		{
			setDisplay("IPv4v6"+"WanMVlanIdRow",1);
			setDisplay("IPv4"+"WanMVlanIdRow",0);
			setDisplay("IPv6"+"WanMVlanIdRow",0);
		}
		else
		{
			setDisplay("IPv4v6"+"WanMVlanIdRow",0);
		}
	}
}

function BirdgetoRoute()
{
	var Wan = GetPageData();
	if (Wan.domain.length > 10 && Wan.Mode == "IP_Routed")
	{
		var i = 0;
		for (i = 0; i < GetWanList().length; i++)
		{
			if (GetWanList()[i].domain == Wan.domain)
			{
				break;
			}
		}
		 
		if (GetWanList()[i].Mode.toUpperCase().indexOf("BRIDGE") >= 0)
		{
			return true;
		}
	}
	return false;
}

function ControlIPv4AddressType()
{
    var Wan = GetCurrentWan();
	var IPv4AddressTypeList = getElementById('WanIPv4Address_select');
    
    setDisplay("WanIPv4Address_selectRow", 1);
    if (Wan.Mode.toString().toUpperCase() != "IP_ROUTED")
    {
        setDisplay("WanIPv4Address_selectRow", 0);
        return;
    } 
	
	IPv4AddressTypeList.options.length = 0;
	IPv4AddressTypeList.options.add(new Option(Languages['DHCP'],"DHCP"));
	IPv4AddressTypeList.options.add(new Option(Languages['Static'],"Static"));
	IPv4AddressTypeList.options.add(new Option(Languages['PPPoE'],"PPPoE"));

    if (Wan.EncapMode.toString().toUpperCase() == "IPOE")
    {
		RemoveItemFromSelect(IPv4AddressTypeList , "PPPoE");
		if(Wan.IPv4AddressMode.toString().toUpperCase() == "DHCP")
		{
			setSelect("WanIPv4Address_select","DHCP");
		}
		else if(Wan.IPv4AddressMode.toString().toUpperCase() == "STATIC")
		{
			setSelect("WanIPv4Address_select","Static");
		}
		else
		{
			setSelect("WanIPv4Address_select","DHCP");
			Wan.IPv4AddressMode = "DHCP";
		}
		
		if((BirdgetoRoute() == true) && (Wan.IPv4AddressMode.toString().toUpperCase() == "STATIC"))
		{
			if(getElById("WanIPv4Address_text").value == '0.0.0.0')
			{
				setText('WanIPv4Address_text','');
			}
			if(getElById("WanSubmask_text").value == '0.0.0.0')
			{
				setText('WanSubmask_text','');
			}
			if(getElById("WanGateway_text").value == '0.0.0.0')
			{
				setText('WanGateway_text','');
			}
		}
		  
    }

    else if (Wan.EncapMode.toString().toUpperCase() == "PPPOE")
    {
		RemoveItemFromSelect(IPv4AddressTypeList , "DHCP");
		RemoveItemFromSelect(IPv4AddressTypeList , "Static");
		setSelect("WanIPv4Address_select","PPPOE");
        Wan.IPv4AddressMode = "PPPoE";
    }
}

function ControlIPv4LanWanBind()
{
    var Wan = GetCurrentWan();
    var ISPPortList = Instance_IspWlan.GetISPPortList();
    
    if (FeatureInfo.LanSsidWanBind == "0")
    {
        setDisplay('Wan_Port_checkboxRow',0);
        setDisplay('Wan_SSID_checkboxRow',0);
        setDisplay('Wan_Pon_checkboxRow',0);
        return;
    }
    
    for (var i = 1; i <= parseInt(TopoInfo.EthNum); i++)
    {
        if (IsL3Mode(i) == "0")
        {
            setDisable("Wan_Port_checkbox"+i, 1);
        }
    }
    
    for (var i = parseInt(TopoInfo.EthNum)+1; i <= 8; i++)
    {
        setDisplay("DivWan_Port_checkbox"+i, 0);
    }

	var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';      

	if (1 != DoubleFreqFlag)
	{	
		for (var i = parseInt(TopoInfo.SSIDNum) + 1; i <= 8; i++)
		{
			setDisplay("DivWan_SSID_checkbox"+i, 0);
		}
	}

	
    if(ISPPortList.length > 0)
    {
        for (var i = 1; i <= parseInt(TopoInfo.SSIDNum); i++)
        {
            var pos = ArrayIndexOf(ISPPortList, 'SSID'+i);
			if(pos >= 0)
            {
                var DivID = i;
                if (Instance_IspWlan.GetISPWanOnlyRead())
                {
                    setDisable("DivWan_SSID_checkbox"+DivID, 1);
                }
                else
                {
                    setDisplay("DivWan_SSID_checkbox"+DivID, 0);
                }
            }
        }
    }
    

	if(1 == DoubleFreqFlag)
	{
		for (var i = 0; i < WlanList.length; i++)
		{
			var tid = parseInt(i+9);
			var tidssid = tid -8;
			if (WlanList[i].bindenable == "0")
			{  
				setDisable("Wan_SSID_checkbox"+tidssid, 1);
			}

			if(WlanList[i].bindenable == "1")
			{			
				if(enbl5G != 1 && tidssid > 4)
				{
					setDisable("Wan_SSID_checkbox"+tidssid, 1);
				}
			
				if(enbl2G != 1 && tidssid < 5)
				{
					setDisable("Wan_SSID_checkbox"+tidssid, 1);
				}
			}
			if (option60Flag == '1' && macRouteCfgEnable == '1' && mngtScct == '1') {
				setCheck("Wan_SSID_checkbox" + tidssid, 0);
				setDisable("Wan_SSID_checkbox" + tidssid, 1);
			}

            if ((scnFT === '1') && (scnEnable === '1') && (tidssid === parseInt(scnInst5G))) {
                setCheck("Wan_SSID_checkbox" + tidssid, 0);
            }
		}
	}
	else
	{
		for (var i = 0; i < WlanList.length; i++)
		{
			var tidssid = parseInt(i+1);
			if (WlanList[i].bindenable == "0")
			{  
				setDisable("Wan_SSID_checkbox"+tidssid, 1);
			}
			if (option60Flag == '1' && macRouteCfgEnable == '1' && mngtScct == '1') {
				setCheck("Wan_SSID_checkbox" + tidssid, 0);
				setDisable("Wan_SSID_checkbox" + tidssid, 1);
			}
		}
	}
    
    setDisplay('Wan_Port_checkboxRow',0);
    setDisplay('Wan_SSID_checkboxRow', 0);
    setDisplay('Wan_Pon_checkboxRow', 0);
    if (Wan.ServiceList.match("INTERNET")
     || Wan.ServiceList.match("OTHER")
	 || Wan.ServiceList.match("IPTV")
     || Wan.ServiceList.match("OTT")
	 || Wan.ServiceList.match("SPECIAL_SERVICE"))
	 {
        setDisplay('Wan_Port_checkboxRow', 1);
        setDisplay('Wan_SSID_checkboxRow', 1);
        setDisplay('Wan_Pon_checkboxRow', 1);
	 }
	 var WlanAvailableFlag= '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
	 if('1' != WlanAvailableFlag)
	 {
	 	setDisplay('Wan_SSID_checkboxRow',0);
	 }

    if (ponOnuBind != 1) {
        setDisplay('Wan_Pon_checkboxRow', 0);
    }

	for (var i = 1; i <= parseInt(TopoInfo.EthNum); i++) {
		if (option60Flag == '1' && macRouteCfgEnable == '1' && mngtScct == '1') {
			setCheck("Wan_Port_checkbox" + i, 0);
			setDisable("Wan_Port_checkbox" + i, 1);
			setCheck("Wan_Pon_checkbox1", 0);
			setDisable("Wan_Pon_checkbox1", 1);
		}
	}
}


function ControlIPv6PrefixAcquireMode()
{
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
    var Wan = GetCurrentWan();
    setDisplay("WanPrefix_checkboxRow", 0);
	setDisplay("WanPrefix_selectRow", 0);
	
    if (WanMode == "IP_ROUTED" && Wan.ServiceList.toUpperCase() != "VOIP")
    {
        setDisplay("WanPrefix_checkboxRow", 1);
		if(getCheckVal("WanPrefix_checkbox") == '1')
		{
			setDisplay("WanPrefix_selectRow", 1);
		}
    } 
	
}


function Control6RDParametersDisplay(Wan)
{
    var servicetypeIsMatch = (-1 != Wan.ServiceList.indexOf("INTERNET")) || (-1 != Wan.ServiceList.indexOf("IPTV")) || (-1 != Wan.ServiceList.indexOf("OTHER")) || (-1 != Wan.ServiceList.indexOf("SPECIAL_SERVICE"));
		
    setDisplay("RDModeRow", 0); 
    setDisplay("RdPrefixRow", 0); 
    setDisplay("RdPrefixLenRow", 0); 
    setDisplay("RdBRIPv4AddressRow", 0); 
    setDisplay("RdIPv4MaskLenRow", 0);  
    
    if( (1 == Wan.IPv4Enable) && (0 == Wan.IPv6Enable) && (Wan.Mode.toString().toUpperCase() == "IP_ROUTED") &&
        (true == servicetypeIsMatch)&&(true == Is6RdSupported()) ){
		
		setDisplay("RDModeRow", 1); 
		
		if ("STATIC" == Wan.RdMode.toString().toUpperCase())
		{
			setDisplay("RdPrefixRow", 1); 
			setDisplay("RdPrefixLenRow", 1); 
			setDisplay("RdBRIPv4AddressRow",1); 
			setDisplay("RdIPv4MaskLenRow", 1); 
		}
		
		setDisableByName("RDMode", 0);
		setDisable("RdPrefix", 0);
		setDisable("RdPrefixLen", 0);
		setDisable("RdBRIPv4Address", 0);
		setDisable("RdIPv4MaskLen", 0);
		for(var i = 0; i < GetWanList().length;i++)
		{
			if( GetWanList()[i].Enable6Rd != "0" && GetWanList()[i].domain != GetCurrentWan().domain)
			{
				setDisableByName("RDMode", 1);
				setDisable("RdPrefix", 1);
				setDisable("RdPrefixLen", 1);
				setDisable("RdBRIPv4Address", 1);
				setDisable("RdIPv4MaskLen", 1);
			}
		}
		
		if(Wan.IPv4AddressMode.toString().toUpperCase() != 'DHCP')
		{
			setDisable("RDMode2", 1);
		}
    }
}

function ControlIPv6Prefix()
{
    var IPv6StaticPrefix = GetCurrentWan().IPv6PrefixMode.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
    
    setDisplay("WanIPv6Address_Pre_textRow", 0);
    if (IPv6StaticPrefix == "STATIC" && WanMode == "IP_ROUTED")
    {
        setDisplay("WanIPv6Address_Pre_textRow", 1);
    }    
}


function ControlIPv6AddressAcquireMode()
{
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
    var WanEncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();
	var IPv6AddressList = getElementById('WanIPv6Address_select');
	var Wan = GetCurrentWan();
	setDisplay("WanIPv6Address_selectRow", 0);
	
    if (WanMode == "IP_ROUTED")
    {
		setDisplay("WanIPv6Address_selectRow", 1);
    }
	
	if(WanEncapMode == "PPPOE")
	{
		IPv6AddressList.options.length = 0;
        if ((CfgModeWord.toUpperCase() == 'SCCT') || (CfgModeWord.toUpperCase() == 'SCSCHOOL'))
        {
            IPv6AddressList.options.add(new Option(Languages['Autoe8c_scct'],"AutoConfigured"));
            IPv6AddressList.options.add(new Option(Languages['DHCPV6e8c'],"DHCPv6"));
            IPv6AddressList.options.add(new Option(Languages['None_scct'],"None"));
        }
        else
        {
            IPv6AddressList.options.add(new Option(Languages['Autoe8c'],"AutoConfigured"));
            IPv6AddressList.options.add(new Option(Languages['DHCPV6e8c'],"DHCPv6"));
            IPv6AddressList.options.add(new Option(Languages['None'],"None"));
        }
		
		if ((Wan.IPv6AddressMode.toString().toUpperCase() != "AUTOCONFIGURED")
		&& (Wan.IPv6AddressMode.toString().toUpperCase() != "DHCPV6")
        && (Wan.IPv6AddressMode.toString().toUpperCase() != "NONE"))
        {
            setSelect("WanIPv6Address_select","AutoConfigured");
            Wan.IPv6AddressMode = "AutoConfigured"; 
        } 
	}
	else
	{
		IPv6AddressList.options.length = 0;
        if ((CfgModeWord.toUpperCase() == 'SCCT') || (CfgModeWord.toUpperCase() == 'SCSCHOOL'))
        {
            IPv6AddressList.options.add(new Option(Languages['Autoe8c_scct'],"AutoConfigured"));
            IPv6AddressList.options.add(new Option(Languages['DHCPV6e8c'],"DHCPv6"));
            IPv6AddressList.options.add(new Option(Languages['Statice8c_scct'],"Static"));
            if (isPerfixderived == 1) {
                IPv6AddressList.options.add(new Option(Languages['Prefixe8c_scct'],"PrefixDerived"));
            }
            IPv6AddressList.options.add(new Option(Languages['None_scct'],"None"));
        }
        else
        {
            IPv6AddressList.options.add(new Option(Languages['Autoe8c'],"AutoConfigured"));
            IPv6AddressList.options.add(new Option(Languages['DHCPV6e8c'],"DHCPv6"));
            IPv6AddressList.options.add(new Option(Languages['Statice8c'],"Static"));
            if (isPerfixderived == 1) {
                IPv6AddressList.options.add(new Option(Languages['Prefixe8c'],"PrefixDerived"));
            }
            IPv6AddressList.options.add(new Option(Languages['None'],"None"));
        }
	}
	IPv6AddressList.value = GetCurrentWan().IPv6AddressMode;
	return;
}


function ControlIPv6ReservedPrefixAddress()
{
	var IPv6AddressType = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
	var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
	
	setDisplay("IPv6ReserveAddressRow", 0);
	
    if(!isE8cAndCMCC())
	{
		if ((CurrentWan.EncapMode.toString().toUpperCase() == "IPOE") && (IPv6AddressType.toUpperCase() == "NONE") && (WanMode == "IP_ROUTED"))
		{
			setDisplay("IPv6ReserveAddressRow", 1);
		}
	}
}

function ControlIPv6StaticIPAddress()
{
    var IPv6AddressType = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();

    setDisplay("WanIPv6Address_textRow", 0);
    setDisplay("IPv6AddrMaskLenE8cRow", 0);
    setDisplay("WanIPv6_Gateway_textRow", 0);
    setDisplay("IPv6SubnetMaskRow", 0);
    setDisplay("IPv6DefaultGatewayRow", 0);
    setDisplay("WanIPv6Pri_DNS_textRow", 0);
    setDisplay("WanIPv6Sec_DNS_textRow", 0);

    if (IPv6AddressType == "STATIC" && WanMode == "IP_ROUTED")
    {
        setDisplay("WanIPv6Address_textRow", 1);
        setDisplay("IPv6AddrMaskLenE8cRow", 1);
        setDisplay("WanIPv6_Gateway_textRow", 1);
        setDisplay("IPv6SubnetMaskRow", 1);
        setDisplay("IPv6DefaultGatewayRow", 1);
        setDisplay("WanIPv6Pri_DNS_textRow", 1);
        setDisplay("WanIPv6Sec_DNS_textRow", 1);
    }
    
}

function ControlIPv6IPAddressStuff()
{
    setDisplay("IPv6AddressStuffRow", "0");
    var IPv6AddressType = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
    var ProtocolType = GetCurrentWan().ProtocolType.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
    
    if (ProtocolType == "IPV4")
    {
        return;
    }

    if (IPv6AddressType != "AUTOCONFIGURED")
    {
        return;
    }

    if (WanMode != "IP_ROUTED")
    {
        return;
    }

	setDisplay("IPv6AddressStuffRow", 1);

}

function setDisableByName(Name, Disable)
{
    var List = document.getElementsByName(Name);
    for (var i = 0; i < List.length; i++)
    {
        setDisable(List[i].id, Disable);
    }   
}

function ControlEditMode()
{
    var Disable = 0;
    var Wan = GetPageData();

    setDisable("WanAddress_select", EditFlag.toUpperCase() == "ADD" ? 0 : 1);
	
    setDisable("WanIP_Mode_select", EditFlag.toUpperCase() == "ADD" ? 0 : 1);

    if ((WanForbidModeFlag == 1) && (Wan.ServiceList.indexOf("INTERNET") >= 0)) {
        setDisable("WanConnectMode_select", 1);
    } else {
        setDisable("WanConnectMode_select", 0);
    }

    if((Disable) && (bin3board() == true))
    {
        setDisable("WanConnectMode_select", 1);
    }
    setDisable("WanMTU_text", 0);
    setDisable("WanServiceList_select", EditFlag.toUpperCase() == "ADD" ? 0 : 1);
    setDisable("WanIPv4Address_select", Disable);
	setDisable("WanPrefix_checkbox", Disable);
    setDisable("WanPrefix_select", Disable);
    setDisableByName("IPv6AddressMode", Disable);
	
	setDisable("WanIPv6Address_select", Disable);
    setDisable("WanIPv6Address_text", Disable);
    setDisable("IPv6AddrMaskLenE8c", Disable);
    setDisable("WanIPv6_Gateway_text", Disable);
	setDisable("IPv6ReserveAddress", Disable);
    setDisable("WanIPv6Address_Pre_text", Disable);
    setDisable("IPv6AddressStuff", Disable);

	if (AddType == 2 && EditFlag.toUpperCase() == "ADD")
	{
	        var SessionVlanLimit  = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULT_SESSION_VLAN_LIMIT);%>";
	        if (SessionVlanLimit == 1)
	        {
		    setDisable('WanVlan_Enable', 1);
	            setDisable('WanVlanID_text', 1);
		    setDisableByName('PriorityPolicy', 1);
                    setDisable('Wan_802_1_P_select', 1);
		    setDisable('DefaultVlanPriority', 1);
		}

	}

	if (Wan.domain.length > 10 && Wan.Mode == "IP_Routed")
	{
		var i = 0;
		for (i = 0; i < GetWanList().length; i++)
		{
			if (GetWanList()[i].domain == Wan.domain)
			{
				break;
			}
		}
		var IPv6StaticPrefix = GetCurrentWan().IPv6PrefixMode.toString().toUpperCase();
        var IPv6StaticAdress = GetCurrentWan().IPv6AddressMode.toString().toUpperCase();
		if (GetWanList()[i].Mode.toUpperCase().indexOf("BRIDGE") >= 0 )
		{
			setDisable("WanPrefix_checkbox", 0);
			setDisable("WanPrefix_select", 0);

			if (IPv6StaticPrefix == "STATIC")
			{
				setDisable("WanIPv6Address_Pre_text", 0);
			} 

			setDisableByName("IPv6AddressMode",0); 
			setDisable("WanIPv6Address_select",0);

			if (IPv6StaticAdress == "STATIC")
			{
				setDisable("WanIPv6Address_text", 0);
				setDisable("IPv6AddrMaskLenE8c", 0);
                    setDisable("WanIPv6_Gateway_text", 0);
			}

			if (IPv6StaticAdress == "AUTOCONFIGURED")
			{
				setDisable("IPv6AddressStuff", 0);
			}		
		}
	}
	
}

function DisableUserMode(Disable)
{
    setDisable("WanSwitch", Disable);
    setDisable("WanAddress_select", Disable);
    setDisable("WanIP_Mode_select", Disable);
    setDisable("WanConnectMode_select", Disable);
    setDisable("WanMTU_text", Disable);
    setDisable("WanServiceList_select", Disable);
    setDisable("WanVlan_Enable", Disable);
    setDisable("WanVlanID_text", Disable);
    setDisable("Wan_802_1_P_select", Disable);
    setDisableByName("PriorityPolicy",  Disable);
    setDisable("WanIPv4Address_select", Disable);
    setDisable("WanMTU_text", Disable);
    setDisable("LanDhcpSwitch", Disable);
    setDisable("IPv4NatSwitch", Disable);
    setDisable("IPv4NatType", Disable);  
    setDisable("IPv4VendorId", Disable);
    setDisable("IPv4ClientId", Disable);
    setDisable("WanIPv4Address_text", Disable);
    setDisable("WanSubmask_text", Disable);
    setDisable("WanGateway_text", Disable);
    setDisable("WanPri_DNS_text", Disable);
    setDisable("WanSec_DNS_text", Disable);
    setDisable("LcpEchoReqCheck", Disable);
	setDisable("IPv4v6WanMVlanId", Disable);
    setDisable("IPv4DialMode", Disable);
    setDisable("IPv4DialIdleTime", Disable);
    setDisable("IPv4IdleDisconnectMode", Disable);
    setDisable("IPv4WanMVlanId", Disable);
    setDisableByName("Wan_Port_checkbox", Disable);
	setDisableByName("Wan_SSID_checkbox", Disable);
	setDisable("WanPrefix_checkbox", Disable);
	setDisable("WanPrefix_checkbox", Disable);
    setDisable("WanPrefix_select", Disable);
	setDisable("WanDslite_checkbox", Disable);
    setDisableByName("IPv6DSLite", Disable);
    setDisable("IPv6AFTRName", Disable);
    setDisable("WanIPv6Address_Pre_text", Disable);
    setDisableByName("IPv6AddressMode", Disable);
	setDisable("WanIPv6Address_select", Disable);
	
    setDisable("IPv6AddressStuff", Disable);
    setDisable("WanIPv6Address_text", Disable);
    setDisable("IPv6AddrMaskLenE8c", Disable);
    setDisable("WanIPv6_Gateway_text", Disable);
    setDisable("IPv6ReserveAddress", Disable);
    setDisable("IPv6SubnetMask", Disable);
    setDisable("IPv6DefaultGateway", Disable);
    setDisable("WanIPv6Pri_DNS_text", Disable);
    setDisable("WanIPv6Sec_DNS_text", Disable);
    setDisable("IPv6WanMVlanId", Disable);
    setDisableByName("PriorityPolicy", Disable);
    setDisable("DefaultVlanPriority", Disable);
	setDisableByName("RDMode", Disable);
	setDisable("RdPrefix", Disable);
	setDisable("RdPrefixLen", Disable);
	setDisable("RdBRIPv4Address", Disable);
	setDisable("RdIPv4MaskLen", Disable);
	setDisable("Speed_limit_up", Disable);
	setDisable("Speed_limit_down", Disable);
	setDisable("IPv6NPTSwitch", Disable);
	setDisable("PingResponseEnable", Disable);
	setDisable("PingResponseWhiteList", Disable);
}

function ControlUserMode()
{
    var Disable = IsAdminUser()==true ? 0 : 1;
	DisableUserMode(Disable);
}

function ControlPageByEditModeAndUser()
{
	var Wan = GetCurrentWan();
    if (IsAdminUser())
    {
		if(Instance_IspWlan.IsOnlyReadWan(Wan))
		{
			DisableUserMode(1);
		    setDisable("ButtonApply", 1);
			setDisable("ButtonNew", 1);
		    setDisable("ButtonDelete", 1);			
			setDisable("DstIPForwardingList", 1);
		}
		else
		{
			 ControlEditMode();
		}
       
    }
    else
    {
        ControlUserMode();
    }
    
}

function Option60DisplayFlag(Wan)
{ 
	if((1 == Option60FT)
	&& (CurrentWan.EncapMode.toString().toUpperCase() == "IPOE")	
	&& (Wan.ServiceList.toString().toUpperCase().indexOf("VOIP") < 0)
	&& (IsAdminUser())
	&& Wan.Mode == "IP_Routed"
	&& ((Wan.ProtocolType.toString().toUpperCase()=="IPV4/IPV6") || ((Wan.ProtocolType.toString().toUpperCase()=="IPV4"))))
	{
		return true;
	}
	else
	{
		return false;	
	}
}

function E8CCheckDisable(Wan)
{
	setDisable('WanSwitch', 0);
	setDisable('WanVlan_Enable', 0);
	setDisable('WanVlanID_text', 0);
	setDisable('Wan_802_1_P_select', 0);
	setDisableByName("PriorityPolicy", 0);
	setDisable('IPv4VendorId', 0);
	setDisable('IPv4ClientId', 0);
	setDisable('IPv4NatSwitch',0);
    setDisable('IPv4NatType',0);
	setDisable('IPv4WanMVlanId',0);
	setDisable('Option60Enable', 0);	
	setDisable('IPoEUserName', 0);
	setDisable('IPoEPassword', 0);
	
	if(!isReadModeForTR069Wan())
	{
		return;
	}
	
	setDisable("Wan_Port_checkboxCol", 0);
	setDisable("Wan_SSID_checkboxCol", 0);
	setDisable("Wan_Pon_checkboxRow", 0);
    if ((Wan.ServiceList.indexOf("TR069") >= 0) && (Wan.ServiceList.indexOf("INTERNET") < 0))
	{
		setDisable("Wan_Port_checkboxCol", 1);
		setDisable("Wan_SSID_checkboxCol", 1);
		setDisable("Wan_Pon_checkboxRow", 1);
	}
	
    if (EditFlag.toUpperCase() == "ADD")
	{
		return;
	}
	else
	{
		if(!IsOriginalTr069Type())
		{
			return;
		}
	}
	
	if ((Wan.ServiceList == "TR069") || (Wan.ServiceList == "TR069_VOIP"))
	{
		setDisable('WanSwitch', 1);
		setDisable('WanVlan_Enable', 1);
		setDisable('WanVlanID_text', 1);
		setDisable('Wan_802_1_P_select', 1);
		setDisableByName("PriorityPolicy", 1);
		setDisable('IPv4VendorId', 1);
		setDisable('IPv4ClientId', 1);
		return;
	}
	
	if ((Wan.ServiceList == "TR069_INTERNET") || (Wan.ServiceList == "TR069_VOIP_INTERNET"))
	{
		setDisable('WanSwitch', 1);
		setDisable('WanVlan_Enable', 1);
		setDisable('WanVlanID_text', 1);
		setDisable('Wan_802_1_P_select', 1);
		setDisableByName("PriorityPolicy", 1);
		setDisable('IPv4VendorId', 1);
		setDisable('IPv4ClientId', 1);
		setDisable('IPv4NatSwitch',1);
        setDisable('IPv4NatType',1);
		setDisable('IPv4WanMVlanId',1);
		return;
	}
}



function E8Ctr069CheckDisable(Wan)
{
	setDisable("Speed_limit_up", 0);
	setDisable("Speed_limit_down", 0);
	setDisable("PingResponseEnable", 0);
	setDisable("PingResponseWhiteList", 0);
	if(isReadModeForTR069Wan() && (Wan.ServiceList.indexOf("TR069") >= 0)&& (EditFlag.toUpperCase() != "ADD"))
	{
		setDisableByName("Wan_Port_checkbox", 1);
		setDisableByName("Wan_SSID_checkbox", 1);
		setDisable('DstIPForwardingList', 1);
		setDisable("LanDhcpSwitch", 1);
		setDisable("Speed_limit_up", 1);
		setDisable("Speed_limit_down", 1);
		setDisable("PingResponseEnable", 1);
		setDisable("PingResponseWhiteList", 1);
	}
	else
	{
		if (Instance_IspWlan.IsOnlyReadWan(Wan)) {
			setDisable('DstIPForwardingList', 1);
			setDisable("Speed_limit_up", 1);
			setDisable("Speed_limit_down", 1);
		} else {
			setDisable('DstIPForwardingList', 0);
		}
	}
	
	if(!isReadModeForTR069Wan())
	{
		return;
	}

    if (EditFlag.toUpperCase() == "ADD")
	{
		return;
	}
	else
	{
		if(!IsOriginalTr069Type())
		{
			return;
		}
	}

	if ((Wan.ServiceList == "TR069") || (Wan.ServiceList == "TR069_VOIP") || (Wan.ServiceList == "TR069_INTERNET") || (Wan.ServiceList == "TR069_VOIP_INTERNET"))
	{
		setDisable("WanConnectMode_select", 1);
		setDisable("WanMTU_text", 1);
        setDisable("WanIP_Mode_select", 1);
        setDisable("WanServiceList_select", 1);
        setDisable("WanIPv4Address_select", 1);
		setDisable("WanUserName_text", 1);
        setDisable("WanPassword_text", 1);
		return;
	}
}

function E8CVRCheckDisable(Wan) {
    if (Wan.ServiceList == "SPECIAL_SERVICE_VR") {
        setDisable("WanSwitch", 1);
        setDisable("WanConnectMode_select", 1);
        setDisable("WanMTU_text", 1);
        setDisable("WanIP_Mode_select", 1);
        setDisable("WanServiceList_select", 1);
        setDisable("WanIPv4Address_select", 1);
        setDisable("Speed_limit_up", 1);
        setDisable("Speed_limit_down", 1);
        setDisable("PingResponseEnable", 1);
        setDisable("PingResponseWhiteList", 1);
        setDisable('IPv4v6WanMVlanId', 1);
        setDisable('WanVlanID_text', 1);
        setDisable('WanVlan_Enable', 1);
        setDisable('Wan_802_1_P_select', 1);
        setDisable('DstIPForwardingList', 1);
        setDisable("IPv4VendorId", 1);
        setDisable("IPv4NatSwitch", 1);
        setDisable("LanDhcpSwitch", 1);
        setDisable("WanIPv6Address_select", 1);
        setDisable("WanPrefix_checkbox", 1);
        setDisable("WanPrefix_select", 1);
        setDisable("IPv6AddressStuff", 1);
        setDisable("IPv6NPTSwitch", 1);
        setDisableByName("PriorityPolicy",1);
        setDisableByName("Wan_Port_checkbox", 1);
        setDisableByName("Wan_SSID_checkbox", 1);
        setDisable("ButtonApply", 1);
    }
}


function ControlIPv6DSLite()
{    
	var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
    
    setDisplay("IPv6DSLiteRow", 0);
    setDisplay("DivIPv6DSLite1", 0);
	setDisplay("WanDslite_checkboxRow", 0);

	if((GetFeatureInfo().Dslite == "0") || (1 == GetCurrentWan().IPv4Enable))
    {
        return;
    }   
	if (WanMode != "IP_ROUTED")
    {
        return;
    }  
	setDisplay("WanDslite_checkboxRow", 1);
	if(getCheckVal("WanDslite_checkbox") == '1')
	{
		setDisplay("IPv6DSLiteRow", 1); 
		if (GetCurrentWan().IPv6DSLite.toString() == "Off")
		{
			setRadio('IPv6DSLite', 'Dynamic');
		}
	}
	setDisableByName("IPv6DSLite", 0);
	setDisable("WanDslite_checkbox", 0);
	for(var i = 0; i < GetWanList().length;i++)
	{
	    if( GetWanList()[i].IPv6DSLite.toString() != "Off" && GetWanList()[i].domain != GetCurrentWan().domain)
		{
		    setDisableByName("IPv6DSLite", 1);
			setDisable("WanDslite_checkbox", 1);
		}
	}
}

function ControlIPv6AFTRName()
{   
	var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
	var WanIPv6DSLite = GetCurrentWan().IPv6DSLite.toString();
    
    setDisplay("IPv6AFTRNameRow", 0);
    if((GetFeatureInfo().Dslite == "0") || (1 == GetCurrentWan().IPv4Enable))     
    {
        return;
    }  
	if (WanMode != "IP_ROUTED")
    {
        return;
    }  
	
	if(getCheckVal("WanDslite_checkbox") == '1')
	{
		setDisplay("IPv6AFTRNameRow", 1);
	}
	
	setDisable("IPv6AFTRName", 0);
	if(WanIPv6DSLite != "Static")
	{
	    setDisable("IPv6AFTRName", 1);
		setText("IPv6AFTRName","");
	}
	
}


function ControlPriority()
{
    var PriorityPolicy = GetCurrentWan().PriorityPolicy.toString();
    var MngtServiceListCur;
    setDisplay("DefaultVlanPriorityRow", 0);
    setDisplay("Wan_802_1_P_selectRow", 0);
    setDisplay("PriorityPolicyRow", 0);
    if (GetCurrentWan().EnableVlan.toString().toUpperCase() == "1")
    {
        setDisplay("PriorityPolicyRow", 1);
    }
    if (PriorityPolicy.toUpperCase() == "SPECIFIED" && GetCurrentWan().EnableVlan.toString().toUpperCase() == "1")
    {
        setDisplay("Wan_802_1_P_selectRow", 1);
    }  
    if (PriorityPolicy.toUpperCase() == "COPYFROMIPPRECEDENCE"  && GetCurrentWan().EnableVlan.toString().toUpperCase() == "1")
    {
        setDisplay("DefaultVlanPriorityRow", 1);
    }

    if ((MngtGdct == 1) && (EditFlag.toUpperCase() == "ADD"))
    {
        MngtServiceListCur = getElementById('WanServiceList_select').value.toUpperCase();
        if (MngtServiceListCur != MngtServiceListPre)
        {
            if (MngtServiceListCur == "OTHER")
            {
                setSelect("Wan_802_1_P_select","5");
            }
            else
            {
                setSelect("Wan_802_1_P_select","0");
            }
        }        
        MngtServiceListPre = MngtServiceListCur;
    }
}

function ControlErrorWANCfg(Wan)
{
	if((Wan.IPv4Enable == 1) || (Wan.IPv6Enable == 1))
	{
		return ;
	}
	var Disable = 1;
	DisableUserMode(Disable);
	setDisable("WanUserName_text",Disable);
	setDisable("WanPassword_text",Disable);
	setDisable("IPv6AFTRName",Disable);
	setDisable("ButtonApply",Disable);
	setDisable("ButtonCancel",Disable);
}

function E8CScctCheckDisable(Wan)
{
    var scctfeature = <%HW_WEB_GetFeatureSupport("BBSP_FT_SCCT");%>;
	if (0 == scctfeature)
    {
	    return ;
    }
	
	if ((EditFlag.toUpperCase() != "ADD")
	    && (Wan.ServiceList != "INTERNET"))
	{
	    setDisable("ButtonApply", 1);
	    setDisable("ButtonNew", 1);
	    setDisable("ButtonDelete", 1);
		
	    setDisable("WanUserName_text",1);
	    setDisable("WanPassword_text",1);
	    setDisable("Speed_limit_up", 1);
	    setDisable("Speed_limit_down", 1);
		
	    DisableUserMode(1);
	}	
}

function IsZJCmccMode()
{
	if ((CfgModeWord.toUpperCase() == 'ZJCMCC_RMS') || 
		(CfgModeWord.toUpperCase() == 'ZJCMCC') || 
		(CfgModeWord.toUpperCase() == 'ZJCMDC') ||
		(CfgModeWord.toUpperCase() == 'ZJCIOT'))
	{
		return true;
	}
	return false;
}

function Option60Display(Wan)
{
	setDisplay("Option60EnableRow","0");
	setDisplay("IPoEUserNameRow", "0");
	setDisplay("IPoEPasswordRow", "0");
	if(true == Option60DisplayFlag(Wan))
	{
		setDisplay("Option60EnableRow","1");
		if("1" == Wan.EnableOption60)
		{
			setDisplay("IPoEUserNameRow", 1);
			setDisplay("IPoEPasswordRow", 1);
			if (IsZJCmccMode() || 
			((IsTr069WanOnlyRead() == 1) && (Wan.ServiceList.indexOf("TR069") >= 0)))
			{
				setDisable("Option60Enable", 1);
				setDisable("IPoEUserName", 1);
				setDisable("IPoEPassword", 1);
			}			
		}			 
		else
		{
			if (IsZJCmccMode() || 
			((IsTr069WanOnlyRead() == 1) && (Wan.ServiceList.indexOf("TR069") >= 0)))
			{
				setDisable("Option60Enable", 1);
			}
		}		
	}	

	return ;
}

function IsJSCmccMode()
{
	if ((CfgModeWord.indexOf("JSCMCC") >= 0) || 
		(CfgModeWord.indexOf("JSCMDC") >= 0) ||
		(CfgModeWord.indexOf("JSCIOT") >= 0))
	{
		return true;
	}
	return false;
}

function CMCC_RMSUserDisplay()
{
	if((false == IsAdminUser()) && ('1' == UserModePppoe))
	{
		setDisable("ButtonNewWan", 1);
		setDisable("ButtonNew", 1);
		setDisable("ButtonDelete",1);
		if(IsJSCmccMode())
		{
			setDisable("IPv4DialMode", 1);
		}
		else
		{
			setDisable("IPv4DialMode", 0);
		}
		setDisable("IPv4DialIdleTime", 0);
		setDisable("IPv4IdleDisconnectMode", 0);			
	}
}

function ControlBridgeEnable(Wan) {
    var EncapMode = GetCurrentWan().EncapMode.toString().toUpperCase();
    var WanMode = GetCurrentWan().Mode.toString().toUpperCase();
    setDisplay("BridgeEnableRow",0);
    if (((mngtTY40 == "1") || (CurCfgModeWord.toUpperCase() == "A8C")) && (IsAdminUser() == true) && (Wan.ServiceList.indexOf("INTERNET") >= 0) &&
        (WanMode == "IP_ROUTED") && (EncapMode == "PPPOE")) {
        setDisplay("BridgeEnableRow",1);
    }
}

function ControlPage(Wan)
{   
    SetCurrentWan(Wan);
    DisableUserMode(0);
    ControlPageByEditModeAndUser();

    if(IPV4V6Flag != 1)
	{
	    ControlPanel();
	}
	ControlUserName();
    ControlApplyButton();
    ControlLcpCheck();
    ControlVlanId();
    ControlPriority();
    E8CCheckDisable(Wan);
    ControlIPv4DHCPEnable();
    ControlVxlanEnable();
	Controlsvrlist();
	var src = getElementById('WanConnectMode_select');
	if((IPV4V6Flag == 1) && (ChangeUISource == src) && (EditFlag == "ADD"))
	{
	    ControlWanIPMode();
	}
	
	if(IPV4V6Flag == 1)
	{
	    ControlPanel();
	}
	
    ControlDstIPForwardingListVisibility();
	ControlMVlan('IPv4v6');

    ControlIPv4AddressType();
    ControlIPv4EnableNAT();  
	ControlIPv4MXU(Wan);
    ControlIPv4VendorId();
    ControlIPv4ClientId();
    ControlIPv4StaticIPAddress();
    ControlIPv4Dial();
    ControlMVlan('IPv4');
    ControlIPv4LanWanBind();
    Control6RDParametersDisplay(Wan);

    ControlIPv6PrefixAcquireMode();
    ControlIPv6Prefix();
    ControlIPv6AddressAcquireMode();
	ControlIPv6ReservedPrefixAddress();
    ControlIPv6StaticIPAddress();
    ControlIPv6IPAddressStuff();

	ControlIPv6DSLite();
	ControlIPv6AFTRName();
	ControlMVlan('IPv6');

    ControlSpec();

    ControlPageByEditModeAndUser();
	if((GetCfgMode().BJCU == "1") && (Wan.ServiceList.match('INTERNET')))
    {
    	setDisable("WanConnectMode_select", 0);
    }
    
    if (GetFeatureInfo().IPv6 == "0")
    {      
        setDisable("WanIP_Mode_select", 1);
        setSelect("WanIP_Mode_select", "IPv4");
    }

	E8Ctr069CheckDisable(Wan);
	E8CVRCheckDisable(Wan);
	ControlErrorWANCfg(Wan);
	
	E8CScctCheckDisable(Wan);

	CMCC_RMSUserDisplay();	
	
	Option60Display(Wan);
    ControlBridgeEnable(Wan);
	setDisplay("IPv6NPTSwitchRow", 0);
	if (SupportNPTv6(Wan)) {
		setDisplay("IPv6NPTSwitchRow", 1);
	}

	speedTestControl();
    ipPingResponseControl();   

    if (CurrentBin.toUpperCase() == 'E8C') {
        setDisplay("LanHostSwitchRow", 0);
        if ((GetCurrentWan().Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0) &&
            (GetCurrentWan().ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)) {
            setDisplay("LanHostSwitchRow", 1);
        }
    }

    return;
}

function OnChangeUI(ControlObject)
{
    var wanmodeobj = getElementById('WanConnectMode_select');
    ChangeUISource = ControlObject;
    if(ControlObject == wanmodeobj)
    {
        Controlsvrlist();
    }
	
	if(ControlObject == getElementById('IPv4NatSwitch'))
	{
		VOIP_INIT_FLAG = false;
	}
	if(ControlObject == getElementById('Vxlan_Enable'))
	{
		setCheck("Vxlan_Enable", getCheckVal('Vxlan_Enable'));
		if(getCheckVal('Vxlan_Enable') == 1)
		{
		   setCheck("WanSwitch", 0);
		   setDisable("WanSwitch", 1);

		   if (GetCurrentWan().Mode.toUpperCase().indexOf("BRIDGE") >= 0) {
				setCheck("LanDhcpSwitch", 0);
		   } else {
				setCheck("LanDhcpSwitch", 1);
		   }
		}
		else
		{
		   setDisable("WanSwitch", 0);
		}
		return;
	}
	
    if(ControlObject == getElementById('WanConnectMode_select')) {
        if(getValue('WanConnectMode_select').toString().toUpperCase().indexOf("BRIDGED") >= 0) {
            setCheck("LanDhcpSwitch", 0);
        } else {
            setCheck("LanDhcpSwitch", 1);
        }
    }

	if (ControlObject == getElementById('WanOption60_Enable')) {
		checkWanOptionEnable();
		var Wan = GetPageData();
		var tempOption60;
		for (var i = 0; i < optin60Info.length - 1; i++) {
			tempOption60 = (optin60Info[i].domain).split(".X_HW_ExtendDHCPOPTION60");
			if (tempOption60[0] == Wan.domain) {
				setText("WanOption60_User", optin60Info[i].Account);
				setText("WanOption60_Password", optin60Info[i].Password);
			}
		}
		if (Wan.domain == "") {
			setText("WanOption60_User", "");
			setText("WanOption60_Password", "");
		}
	}

	ControlPage(GetPageData());
	if(IfVisual==1)
	{
	    pageDisable();
		setDisable(ControlObject.id,0);
		setDisable("WanConnectName_select",0);
	}

	if (ControlObject == getElementById('WanAddress_select')) {
		OtherWanProcess();
		option60WanProcess();
	}

	if (ControlObject == getElementById('WanConnectMode_select')) {
		OtherWanProcess();
		option60WanProcess();
	}

	if (ControlObject == getElementById('WanIP_Mode_select')) {
		option60WanProcess();
	}

	if (ControlObject == getElementById('WanServiceList_select')) {
		OtherWanProcess();
		option60WanProcess();
	}
     
    if (ControlObject == getElementById('DhcpOption60Enable')){
        controlDhcpOption60();
    }
}

function GetAddType()
{
    return AddType;
}

function GetAddWanUrl(Wan)
{
	var wanConInst = 0;
	if (AddType != 2)
	{
		if(Wan.EncapMode.toString().toUpperCase() == 'PPPOE')
		{
			return 'GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANPPPConnection';
		}
		else
		{
			return 'GROUP_a_x=InternetGatewayDevice.WANDevice.1.WANConnectionDevice&GROUP_a_y=GROUP_a_x.WANIPConnection';
		}
	}
	else
	{
		wanConInst = GetWanInfoSelected().domain.split(".")[4];
	
		if(Wan.EncapMode.toString().toUpperCase() == 'PPPOE')
		{
			return 'GROUP_a_y=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.' + wanConInst + '.WANPPPConnection';
		}
		else
		{
			return 'GROUP_a_y=InternetGatewayDevice.WANDevice.1.WANConnectionDevice.' + wanConInst + '.WANIPConnection';
		}
	}
}

function GetEditWanUrl(Wan)
{
    return Wan.domain;
}

function IsLanBind(Name, IPv4BindLanList)
{
    for (var i = 0; i < IPv4BindLanList.length; i++)
    {
        if (IPv4BindLanList[i] != undefined && IPv4BindLanList[i] != null)
        if (Name.toString().toUpperCase() == IPv4BindLanList[i].toString().toUpperCase())
        {
            return true;
        }
    }
    return false;
}

function IsOldServerListType(type)
{
	switch(type)
	{
		case 'TR069':
		case 'INTERNET':
		case 'TR069_INTERNET':
		case 'VOIP':
		case 'TR069_VOIP':
		case 'VOIP_INTERNET':
		case 'TR069_VOIP_INTERNET':
		case 'IPTV':
        case 'OTT':
		case 'OTHER':
			return true;
	}
	
	return false;
}

function isOnlyIpv4OrOnlyIpv6(ipv4Enable, ipv6Enable)
{
    if (((ipv4Enable == "1") && (ipv6Enable != "1")) || ((ipv4Enable != "1") && (ipv6Enable == "1"))) {
        return true;
    }

    return false;
}

function FillUserForm(Form, Wan)
{
    if (Wan.Mode == 'IP_Routed')
    {
        switch (Wan.IPv4AddressMode)
        {
            case 'PPPoE':
                Form.usingPrefix('y');	
                Form.addParameter('Username', Wan.UserName);
                Form.addParameter('Password', Wan.Password);
				if (('1' == UserModePppoe) && Wan.Mode == 'IP_Routed' && Wan.ServiceList == 'INTERNET' && "1" == Wan.IPv4Enable && ("1" != Wan.IPv6Enable))
				{
					if(IsJSCmccMode())
					{
						Form.addParameter('ConnectionTrigger',Wan.IPv4DialMode);
					}
					if (Wan.IPv4DialMode == "OnDemand")
					{
						Form.addParameter('IdleDisconnectTime',Wan.IPv4DialIdleTime); 
						Form.addParameter('X_HW_IdleDetectMode',Wan.IPv4IdleDisconnectMode);
					}
				}				

                Form.endPrefix();
                break;
        }
    }
	
	if(GetCfgMode().BJCU == "1" )
    {
    	Form.usingPrefix('y');	
		Form.addParameter('ConnectionType', Wan.Mode);
        Form.addParameter('NATEnabled', Wan.IPv4NATEnable);
        Form.endPrefix();
    }
}

function FillSysForm_MVlan(Form, Wan)
{
	if ("IPv4/IPv6" == Wan.ProtocolType.toString() && Is3TMode())
	{
		if ("" == Wan.IPv4v6WanMVlanId)
	    {
	        Form.addParameter('X_HW_MultiCastVLAN', 0xFFFFFFFF);
			Form.addParameter('X_HW_IPv6MultiCastVLAN', -1);
	    }
        else
	    {
	        Form.addParameter('X_HW_MultiCastVLAN', Wan.IPv4v6WanMVlanId);
			Form.addParameter('X_HW_IPv6MultiCastVLAN', Wan.IPv4v6WanMVlanId);
        }
	}
}

function FillSysForm_Scct(Form, Wan)  
{
	var WanProtocolType = GetCurrentWan().ProtocolType.toString();
	var WanIPv6DSLite = GetCurrentWan().IPv6DSLite.toString();
	
	if(EditFlag == "ADD")
	{
		Form.usingPrefix('GROUP_a_y'); 
	}
	else if(EditFlag == "EDIT")
	{
		Form.usingPrefix('y');  
	}
	
	Form.addParameter('Enable',Wan.Enable); 
	Form.addParameter('X_HW_IPv4Enable',Wan.IPv4Enable); 
	Form.addParameter('X_HW_IPv6Enable',Wan.IPv6Enable);  
	
	if ("" == Wan.IPv6WanMVlanId)
	{
	    Form.addParameter('X_HW_IPv6MultiCastVLAN', -1);
	}
        else
	{
	    Form.addParameter('X_HW_IPv6MultiCastVLAN', Wan.IPv6WanMVlanId);
        }

	if(true == IsOldServerListType(Wan.ServiceList))
	{
		Form.addParameter('X_HW_SERVICELIST', Wan.ServiceList); 
		Form.addParameter('X_HW_ExServiceList', ''); 		
	}
	else
	{
		Form.addParameter('X_HW_SERVICELIST', 'INTERNET'); 
		Form.addParameter('X_HW_ExServiceList', Wan.ServiceList); 
	}
         
    Form.addParameter('ConnectionType',Wan.Mode);	
    if ( Wan.ServiceList.match('INTERNET')
    || Wan.ServiceList.match('IPTV') 
    || Wan.ServiceList.match('OTT')
    || Wan.ServiceList.match('OTHER') )
    {
        
        Form.addParameter('X_HW_LanDhcpEnable',Wan.EnableLanDhcp);		
    }
     
    if ( true == IsDstIPForwardingListVisibility(Wan,Wan.ServiceList) )
    {
    	Form.addParameter('X_HW_IPForwardList',Wan.DstIPForwardingList);
    }
    if (Wan.Mode.indexOf("Bridged") >= 0)
    {
	    if (EditFlag == "ADD")
	    {
        }

	    if ("" == Wan.IPv4WanMVlanId)
	    {
	        Form.addParameter('X_HW_MultiCastVLAN', 0xFFFFFFFF); 
	    }
        else
	    {
	        Form.addParameter('X_HW_MultiCastVLAN', Wan.IPv4WanMVlanId);
        }

    }
    else if (Wan.Mode == 'IP_Routed')
    {
        if(!(Wan.ServiceList=="TR069" || Wan.ServiceList=="TR069_VOIP"))
		{
			Form.addParameter('NATEnabled',Wan.IPv4NATEnable);
		}	
		 
		if (('1' == enFullRouting)&&('1' == IsSupportVoice)&&('VOIP' == ServiceList.toUpperCase())&&( '1' == IsSmartGateWay))
		{
			Form.addParameter('NATEnabled',Wan.IPv4NATEnable);
		}	
		 
        if (Wan.IPv4NATEnable == "1")
        {
         	Form.addParameter('X_HW_NatType', Wan.NatType);      
        }
        
        if ("" == Wan.IPv4WanMVlanId)
        {
            Form.addParameter('X_HW_MultiCastVLAN', 0xFFFFFFFF);
        }
        else
        {
            Form.addParameter('X_HW_MultiCastVLAN', Wan.IPv4WanMVlanId);
        }
    }
	
	FillSysForm_MVlan(Form, Wan);
	
                var DnsStr = Wan.IPv4PrimaryDNS + ',' + Wan.IPv4SecondaryDNS;
                if (Wan.IPv4PrimaryDNS.length == 0)
                {
                    DnsStr = Wan.IPv4SecondaryDNS;
		        }
                if (Wan.IPv4SecondaryDNS.length == 0)
                {
                    DnsStr = Wan.IPv4PrimaryDNS;
                }	

	if (Wan.Mode == 'IP_Routed')
	{
        switch (Wan.IPv4AddressMode)
        {
            case 'PPPoE':
                Form.addParameter('Username',Wan.UserName);
                Form.addParameter('Password',Wan.Password);
                if(!isE8cAndCMCC())
                {
                    Form.addParameter('X_HW_LcpEchoReqCheck',Wan.LcpEchoReqCheck);
                }
                if ((Wan.Mode == 'IP_Routed') && (Wan.ServiceList == 'INTERNET'))
                {
                    Form.addParameter('ConnectionTrigger',Wan.IPv4DialMode);
                    if (Wan.IPv4DialMode == "OnDemand")
                    {
                        Form.addParameter('IdleDisconnectTime',Wan.IPv4DialIdleTime); 
                        Form.addParameter('X_HW_IdleDetectMode',Wan.IPv4IdleDisconnectMode);
                    }
                }
                Form.addParameter('DNSEnabled', "1");
				
                break;
    					
            case 'Static':
                if("1" == Wan.IPv4Enable)
                {
                    Form.addParameter('AddressingType','Static');
                    Form.addParameter('ExternalIPAddress',Wan.IPv4IPAddress);
                    Form.addParameter('SubnetMask',Wan.IPv4SubnetMask);
                    Form.addParameter('DefaultGateway',Wan.IPv4Gateway);
    					
                    Form.addParameter('DNSServers',DnsStr);	
                    Form.addParameter('DNSEnabled', "1");

                }
                break;
                
            case 'DHCP':
                if("1" == Wan.IPv4Enable)
                {
                    Form.addParameter('AddressingType','DHCP');
                    Form.addParameter('DNSEnabled', "1");
                    Form.addParameter('X_HW_VenderClassID',Wan.IPv4VendorId);
                    if(!isE8cAndCMCC())
                    {
                        Form.addParameter('X_HW_ClientID',Wan.IPv4ClientId);
                    }
                }
                break;
            default:		
                break;
        }
    }
	
    var LanWanBindInfo = Instance_PolicyRoute.GetLanWanBindInfo(domainTowanname(Wan.domain));
    
    if ( Wan.ServiceList.match('INTERNET')
	|| Wan.ServiceList.match('IPTV')
    || Wan.ServiceList.match('OTT')
	|| Wan.ServiceList.match('OTHER') )
    {   
		    var Bindlist = "";
            var Bindlist2 = "";
		    for (var i = 1; i <= TopoInfo.EthNum; i++)
			{
				if(IsLanBind("Lan"+i, Wan.IPv4BindLanList)==true)
				{
					 Bindlist = Bindlist + "Lan"  + i + ",";
				}
			}

            for (var i = 1; i <= TopoInfo.SSIDNum; i++)
            {            
               if(IsLanBind("SSID"+i, Wan.IPv4BindLanList)==true)
				{
                    Bindlist = Bindlist + "SSID"  + i + ",";
                    if ((i === 5) && (scnFT === '1') && (scnEnable === '1')) {
                        Bindlist = Bindlist + "SSID" + scnInst5G + ",";
                    }
				}
            }
			Bindlist2 = Bindlist.substring(0, Bindlist.length - 1);
      		Form.addParameter('X_HW_BindPhyPortInfo', Bindlist2);
    }
    Form.endPrefix();
    
    if ("IP_Routed" == Wan.Mode  && "1" == Wan.IPv6Enable)
    {   		    
		var IPv6AddressUrl = GetIPv6AddressAcquireInfo(Wan.domain);
		if(IPv6AddressUrl==null && EditFlag == "EDIT")
		{
			Form.usingPrefix(COMPLEX_CGI_PREFIX + 'm');	
		}
		else  
		{
		    Form.usingPrefix('m');
		}
		Form.addParameter('Alias','');
		Form.addParameter('Origin',Wan.IPv6AddressMode);
		Form.addParameter('IPAddress', Wan.IPv6IPAddress);
		Form.addParameter('ChildPrefixBits', Wan.IPv6AddressStuff);
		if(Wan.IPv6AddrMaskLenE8c == "")
		{
		    Form.addParameter('AddrMaskLen',"0");
		}
		else
		{
		    Form.addParameter('AddrMaskLen',Wan.IPv6AddrMaskLenE8c);
		}
		Form.addParameter('DefaultGateway',Wan.IPv6GatewayE8c);
		if ((Wan.EncapMode.toString().toUpperCase() == "IPOE") && (Wan.IPv6AddressMode == "None"))
		{
			if(!isE8cAndCMCC())
			{
				Form.addParameter('UnnumberredWanReserveAddress', Wan.IPv6ReserveAddress);
			}
		}
		Form.endPrefix();
    }
	
	if ("IP_Routed" == Wan.Mode  && "1" == Wan.IPv6Enable)
    { 		
		var IPv6PrefixUrl = GetIPv6PrefixAcquireInfo(Wan.domain);
		if(IPv6PrefixUrl==null && EditFlag == "EDIT")
		{                   
			Form.usingPrefix(COMPLEX_CGI_PREFIX + 'n');	
		}
		else
		{
		    Form.usingPrefix('n');
		}
		Form.addParameter('Alias','');
		
		Wan.IPv6PrefixMode = (Wan.EnablePrefix == "0")?"None":Wan.IPv6PrefixMode;
		Form.addParameter('Origin',Wan.IPv6PrefixMode);
		Form.addParameter('Prefix',Wan.IPv6StaticPrefix);
		Form.endPrefix();
    }
    
	if ("IP_Routed" == Wan.Mode  && "1" == Wan.IPv6Enable && Wan.IPv6AddressMode == "Static")
    { 		
		var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
		if(DnsUrl==null && EditFlag == "EDIT")
		{
			Form.usingPrefix(COMPLEX_CGI_PREFIX+'k');	
			var DnsServer = GetWanDnsServerString(Wan.IPv6PrimaryDNS, Wan.IPv6SecondaryDNS);
			Form.addParameter('DNSServer',DnsServer);

			Form.addParameter('Interface',domainTowanname(Wan.domain));
			Form.endPrefix();
		}
		else
		{
		 			Form.usingPrefix('k');	
			var DnsServer = GetWanDnsServerString(Wan.IPv6PrimaryDNS, Wan.IPv6SecondaryDNS);
			Form.addParameter('DNSServer',DnsServer);
			Form.endPrefix();
		}
    }    	
	
	if (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed" )
	{
	  Form.usingPrefix('j');  
		if(Wan.EnableDSLite == "0")
		{
			Wan.IPv6DSLite = 'Off';
			Wan.IPv6AFTRName = "";
		}
		Form.addParameter('WorkMode',Wan.IPv6DSLite);
		Form.addParameter('AFTRName',Wan.IPv6AFTRName);
		Form.endPrefix();
	}

	if ( Wan.ProtocolType.toString() == "IPv4" && Wan.Mode == "IP_Routed" && true == Is6RdSupported())
	{
	    Form.usingPrefix('r');
		if ('Off' == Wan.RdMode)
		{
			Form.addParameter('Enable','0');  
		}
		else if('Dynamic' == Wan.RdMode)
		{
			Form.addParameter('Enable','1');  
			Form.addParameter('RdMode',Wan.RdMode);
		}
		else
		{
			Form.addParameter('Enable','1');  
			Form.addParameter('RdPrefix',Wan.RdPrefix);
			Form.addParameter('RdPrefixLen',Wan.RdPrefixLen);
			Form.addParameter('RdBRIPv4Address',Wan.RdBRIPv4Address);
			Form.addParameter('RdIPv4MaskLen',Wan.RdIPv4MaskLen);
			if (Wan.EncapMode.toString().toUpperCase() != "PPPOE")
			{
				Form.addParameter('RdMode',Wan.RdMode);
			}
		}

		Form.endPrefix();
    }
}

function FillSysForm(Form, Wan)  
{
	var WanProtocolType = GetCurrentWan().ProtocolType.toString();
	var WanIPv6DSLite = GetCurrentWan().IPv6DSLite.toString();

	var scctfeature = <%HW_WEB_GetFeatureSupport("BBSP_FT_SCCT");%>;
	if ( (1 == scctfeature) && (EditFlag == "EDIT") && (Wan.ServiceList != "INTERNET"))
	{
	    FillSysForm_Scct(Form, Wan);
	    return;
	}
	
	if(EditFlag == "ADD")
	{
		Form.usingPrefix('GROUP_a_y'); 
	}
	else if(EditFlag == "EDIT")
	{
		Form.usingPrefix('y');  
	}
	
	Form.addParameter('Enable',Wan.Enable); 
	Form.addParameter('X_HW_IPv4Enable',Wan.IPv4Enable); 
    Form.addParameter('X_HW_IPv6Enable',Wan.IPv6Enable);  
    if(mngtTY40 == '1') {
        Form.addParameter('X_HW_SpeedLimit_UP',Wan.X_HW_SpeedLimit_UP);
        Form.addParameter('X_HW_SpeedLimit_DOWN',Wan.X_HW_SpeedLimit_DOWN);
    }

    if (isSupportPingReponse()) {
        Form.addParameter('X_HW_PingResponseEnable', Wan.X_HW_PingResponseEnable);
        if (Wan.X_HW_PingResponseEnable == "1") {
            Form.addParameter('X_HW_PingResponseWhiteList', Wan.X_HW_PingResponseWhiteList);
        }
    }

	if ("" == Wan.IPv6WanMVlanId)
	{
	    Form.addParameter('X_HW_IPv6MultiCastVLAN', -1);
	}
        else
	{
	    Form.addParameter('X_HW_IPv6MultiCastVLAN', Wan.IPv6WanMVlanId);
        }

	if(true == IsOldServerListType(Wan.ServiceList))
	{
		Form.addParameter('X_HW_SERVICELIST', Wan.ServiceList); 
		Form.addParameter('X_HW_ExServiceList', ''); 		
	}
	else
	{
		Form.addParameter('X_HW_SERVICELIST', 'INTERNET'); 
		Form.addParameter('X_HW_ExServiceList', Wan.ServiceList); 
	}
         
    Form.addParameter('X_HW_VLAN', Wan.EnableVlan == "1" ? Wan.VlanId:"0");   
    Form.addParameter('X_HW_PRI',Wan.Priority);
    Form.addParameter('X_HW_PriPolicy', (Wan.EnableVlan == "1") ? Wan.PriorityPolicy:"Specified"); 
    Form.addParameter('X_HW_DefaultPri', Wan.DefaultPriority); 

    var ConnectionType = Wan.Mode;
	if (IsCmcc_rmsMode())
    {
        if (("IP_Routed" == Wan.Mode) && ("PPPoE" == Wan.EncapMode))
        {
            ConnectionType = "PPPoE_Routed";
        }
    }
    
    Form.addParameter('ConnectionType',ConnectionType);	
    if ( Wan.ServiceList.match('INTERNET') 
    || Wan.ServiceList.match('IPTV')
    || Wan.ServiceList.match('OTT')
    || Wan.ServiceList.match('OTHER') 
    || Wan.ServiceList.match('SPECIAL_SERVICE'))
    {
        
        Form.addParameter('X_HW_LanDhcpEnable',Wan.EnableLanDhcp);		
    }
	
	if ((Wan.ServiceList.indexOf("INTERNET") >=0) && (vxlanfeature == 1) && (isFullCfgVxlan != 1))
    {
	    Form.addParameter('X_HW_VXLAN_Enable',getCheckVal('Vxlan_Enable'));	
    }	
     
    if ( true == IsDstIPForwardingListVisibility(Wan,Wan.ServiceList) )
    {
    	Form.addParameter('X_HW_IPForwardList',Wan.DstIPForwardingList);
    }
    if (Wan.Mode.indexOf("Bridged") >= 0)
    {
	    if (EditFlag == "ADD")
	    {
        }

	    if ("" == Wan.IPv4WanMVlanId)
	    {
	        Form.addParameter('X_HW_MultiCastVLAN', 0xFFFFFFFF); 
	    }
        else
	    {
	        Form.addParameter('X_HW_MultiCastVLAN', Wan.IPv4WanMVlanId);
        }
    }
    else if (Wan.Mode == 'IP_Routed')
    {
        if(!(Wan.ServiceList=="TR069" || Wan.ServiceList=="VOIP" || Wan.ServiceList=="TR069_VOIP"))
        {
			Form.addParameter('NATEnabled',Wan.IPv4NATEnable);
        }
		
		if(SupportNPTv6(Wan)) {
			Form.addParameter('X_HW_NPTv6Enable',Wan.X_HW_NPTv6Enable);
		}
		
		if (('1' == enFullRouting)&&('1' == IsSupportVoice)&&('VOIP' == Wan.ServiceList.toUpperCase())&&( '1' == IsSmartGateWay))
		{
			Form.addParameter('NATEnabled',Wan.IPv4NATEnable);
		}
        
        if (Wan.IPv4NATEnable == "1")
        {
         	Form.addParameter('X_HW_NatType', Wan.NatType);      
        }
        
        if ("" == Wan.IPv4WanMVlanId)
        {
            Form.addParameter('X_HW_MultiCastVLAN', 0xFFFFFFFF);
        }
        else
        {
            Form.addParameter('X_HW_MultiCastVLAN', Wan.IPv4WanMVlanId);
        }
    }

    if (IsCmcc_rmsMode())
    {
	    if (("" != Wan.IPv6WanMVlanId) && (Wan.IPv4Enable == "0"))
		{
			Form.addParameter('X_HW_MultiCastVLAN', Wan.IPv6WanMVlanId);	
	    }
    }
	
	FillSysForm_MVlan(Form, Wan);
	
                var DnsStr = Wan.IPv4PrimaryDNS + ',' + Wan.IPv4SecondaryDNS;
                if (Wan.IPv4PrimaryDNS.length == 0)
                {
                    DnsStr = Wan.IPv4SecondaryDNS;
		        }
                if (Wan.IPv4SecondaryDNS.length == 0)
                {
                    DnsStr = Wan.IPv4PrimaryDNS;
                }	

	if (Wan.Mode == 'IP_Routed')
	{
        switch (Wan.IPv4AddressMode)
        {
            case 'PPPoE':
                Form.addParameter('Username',Wan.UserName);
                Form.addParameter('Password',Wan.Password);
                if(!isE8cAndCMCC())
                {
                    Form.addParameter('X_HW_LcpEchoReqCheck',Wan.LcpEchoReqCheck);
                }
                if ((Wan.Mode == 'IP_Routed') && (Wan.ServiceList == 'INTERNET'))
                {
                    Form.addParameter('ConnectionTrigger',Wan.IPv4DialMode);
                    if (Wan.IPv4DialMode == "OnDemand")
                    {
                        Form.addParameter('IdleDisconnectTime',Wan.IPv4DialIdleTime); 
                        Form.addParameter('X_HW_IdleDetectMode',Wan.IPv4IdleDisconnectMode);
                    }
                }
                Form.addParameter('DNSEnabled', "1");
				
				if(Wan.IPv4MXU == "")
				{
				    if ( "" == DefaultMTUSize || "0" == DefaultMTUSize)
				    {
    					Form.addParameter('MaxMRUSize',"1492");
    			    }
    			    else
    			    {
    			        Form.addParameter('MaxMRUSize',DefaultMTUSize);
    			    }
				}
				else
				{
					Form.addParameter('MaxMRUSize',Wan.IPv4MXU);
				} 
                break;
    					
            case 'Static':
                if("1" == Wan.IPv4Enable)
                {
                    Form.addParameter('AddressingType','Static');
                    Form.addParameter('ExternalIPAddress',Wan.IPv4IPAddress);
                    Form.addParameter('SubnetMask',Wan.IPv4SubnetMask);
                    Form.addParameter('DefaultGateway',Wan.IPv4Gateway);
    					
                    Form.addParameter('DNSServers',DnsStr);	
                    Form.addParameter('DNSEnabled', "1");

                }
				
				if(Wan.IPv4MXU == "")
				{
				    if ( "" == DefaultMTUSize || "0" == DefaultMTUSize)
				    {
                        if (getCheckVal('Vxlan_Enable') == 1) {
                            Form.addParameter('MaxMTUSize', "1440");
                        } else {
                            Form.addParameter('MaxMTUSize', "1500");
                        }
					}
					else
					{
						Form.addParameter('MaxMTUSize',DefaultMTUSize);
					    
					}
				}
				else
				{
					Form.addParameter('MaxMTUSize',Wan.IPv4MXU);
				}
                break;
                
            case 'DHCP':
                if("1" == Wan.IPv4Enable)
                {
                    Form.addParameter('AddressingType','DHCP');
                    Form.addParameter('DNSEnabled', "1");
                    Form.addParameter('X_HW_VenderClassID',Wan.IPv4VendorId);
                    if(!isE8cAndCMCC())
                    {
                        Form.addParameter('X_HW_ClientID',Wan.IPv4ClientId);
                    }
                }
				
				if(Wan.IPv4MXU == "")
				{
				    if ( "" == DefaultMTUSize || "0" == DefaultMTUSize)
				    {
                        if (getCheckVal('Vxlan_Enable') == 1) {
                            Form.addParameter('MaxMTUSize', "1440");
                        } else {
                            Form.addParameter('MaxMTUSize', "1500");
                        }
					}
					else
					{
						Form.addParameter('MaxMTUSize',DefaultMTUSize);					    
					}
				}
				else
				{
					Form.addParameter('MaxMTUSize',Wan.IPv4MXU);
				}
                break;
            default:		
                break;
        }
    }
    else if (MngtGdct == 1)
    {
        switch (Wan.EncapMode)
        {
            case 'PPPoE':
                if(Wan.IPv4MXU == "")
				{
				    if (('0' == DefaultBridgeMTUSize) || ('' == DefaultBridgeMTUSize))
				    {
                        if (getCheckVal('Vxlan_Enable') == 1) {
                            Form.addParameter('MaxMTUSize', "1440");
                        } else {
                            Form.addParameter('MaxMTUSize', "1500");
                        }
				    }
				    else
				    {
				        Form.addParameter('MaxMRUSize', DefaultBridgeMTUSize);
				    }
				}
				else
				{
    				Form.addParameter('MaxMRUSize',Wan.IPv4MXU);    
				}
                break;
            default:
                if(Wan.IPv4MXU == "")
				{
				    if (('0' == DefaultBridgeMTUSize) || ('' == DefaultBridgeMTUSize))
				    {
                        if (getCheckVal('Vxlan_Enable') == 1) {
                            Form.addParameter('MaxMTUSize', "1440");
                        } else {
                            Form.addParameter('MaxMTUSize', "1500");
                        }
				    }
				    else
				    {
				        Form.addParameter('MaxMTUSize', DefaultBridgeMTUSize);
				    }
				}
				else
				{
    				Form.addParameter('MaxMTUSize',Wan.IPv4MXU);    
				}
                break;
        }
    }
    if (((mngtTY40 == "1") || (CurCfgModeWord.toUpperCase() == "A8C")) && (IsAdminUser() == true) && (Wan.ServiceList.indexOf("INTERNET") >= 0) &&
        (Wan.Mode == "IP_Routed") && (Wan.EncapMode == "PPPoE")) {
        Form.addParameter('X_HW_BridgeEnable',Wan.X_HW_BridgeEnable);
	}
	if (SupportNPTv6(Wan)) {
		Form.addParameter('X_HW_NPTv6Enable',Wan.X_HW_NPTv6Enable);
	}

    var LanWanBindInfo = Instance_PolicyRoute.GetLanWanBindInfo(domainTowanname(Wan.domain));
    
    if ( Wan.ServiceList.match('INTERNET')
	|| Wan.ServiceList.match('IPTV')
    || Wan.ServiceList.match('OTT')
	|| Wan.ServiceList.match('OTHER') 
	|| Wan.ServiceList.match('SPECIAL_SERVICE')
	)
    {   
		    var Bindlist = "";
            var Bindlist2 = "";
		    for (var i = 1; i <= TopoInfo.EthNum; i++)
			{
				if(IsLanBind("Lan"+i, Wan.IPv4BindLanList)==true)
				{
					 Bindlist = Bindlist + "Lan"  + i + ",";
				}
			}

            for (var i = 1; i <= TopoInfo.SSIDNum; i++)
            {            
               if(IsLanBind("SSID"+i, Wan.IPv4BindLanList)==true)
				{
					Bindlist = Bindlist + "SSID"  + i + ",";  
                    if ((i === 5) && (scnFT === '1') && (scnEnable === '1')) {
                        Bindlist = Bindlist + "SSID" + scnInst5G + ",";
                    }
				}
            }

            if ((ponOnuBind == 1) && (Wan.IPv4BindOnuList != null) && (Wan.IPv4BindOnuList != undefined)) {
                for (var j = 1; j <= 16; j++) {
                    if (IsLanBind("ONU" + j, Wan.IPv4BindOnuList) == true) {
                        Bindlist = Bindlist + "ONU" + j + ",";
                    }
                }
            }

			Bindlist2 = Bindlist.substring(0, Bindlist.length - 1);
      		Form.addParameter('X_HW_BindPhyPortInfo', Bindlist2);
    }

    if (Option60DisplayFlag(Wan)) {
        if ((!IsZJCmccMode()) && (!isHENCmccMode())) {
            if("1" == Wan.EnableOption60) {
                Form.addParameter('X_HW_IPoEName',Wan.X_HW_IPoEName);
                Form.addParameter('X_HW_IPoEPassword',Wan.X_HW_IPoEPassword);
            } else {
                Form.addParameter('X_HW_IPoEName',"");
                Form.addParameter('X_HW_IPoEPassword',"");
            }
        }
    }

    Form.endPrefix();
    
    if ("IP_Routed" == Wan.Mode  && "1" == Wan.IPv6Enable)
    {   		    
		var IPv6AddressUrl = GetIPv6AddressAcquireInfo(Wan.domain);
		if(IPv6AddressUrl==null && EditFlag == "EDIT")
		{
			Form.usingPrefix(COMPLEX_CGI_PREFIX + 'm');	
		}
		else  
		{
		    Form.usingPrefix('m');
		}
		Form.addParameter('Alias','');
		Form.addParameter('Origin',Wan.IPv6AddressMode);
		Form.addParameter('IPAddress', Wan.IPv6IPAddress);
		Form.addParameter('ChildPrefixBits', Wan.IPv6AddressStuff);
		if(Wan.IPv6AddrMaskLenE8c == "")
		{
		    Form.addParameter('AddrMaskLen',"0");
		}
		else
		{
		    Form.addParameter('AddrMaskLen',Wan.IPv6AddrMaskLenE8c);
		}
		Form.addParameter('DefaultGateway',Wan.IPv6GatewayE8c);
		if ((Wan.EncapMode.toString().toUpperCase() == "IPOE") && (Wan.IPv6AddressMode == "None"))
		{
			if(!isE8cAndCMCC())
			{
				Form.addParameter('UnnumberredWanReserveAddress', Wan.IPv6ReserveAddress);
			}
		}
		Form.endPrefix();
    }
	
	if ("IP_Routed" == Wan.Mode  && "1" == Wan.IPv6Enable)
    { 		
		var IPv6PrefixUrl = GetIPv6PrefixAcquireInfo(Wan.domain);
		if(IPv6PrefixUrl==null && EditFlag == "EDIT")
		{                   
			Form.usingPrefix(COMPLEX_CGI_PREFIX + 'n');	
		}
		else
		{
		    Form.usingPrefix('n');
		}
		Form.addParameter('Alias','');
		
		Wan.IPv6PrefixMode = (Wan.EnablePrefix == "0")?"None":Wan.IPv6PrefixMode;
		Form.addParameter('Origin',Wan.IPv6PrefixMode);
		Form.addParameter('Prefix',Wan.IPv6StaticPrefix);
		Form.endPrefix();
    }
    
	if ("IP_Routed" == Wan.Mode  && "1" == Wan.IPv6Enable && Wan.IPv6AddressMode == "Static")
    { 		
		var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
		if(DnsUrl==null && EditFlag == "EDIT")
		{
			Form.usingPrefix(COMPLEX_CGI_PREFIX+'k');	
			var DnsServer = GetWanDnsServerString(Wan.IPv6PrimaryDNS, Wan.IPv6SecondaryDNS);
			Form.addParameter('DNSServer',DnsServer);

			Form.addParameter('Interface',domainTowanname(Wan.domain));
			Form.endPrefix();
		}
		else
		{
		 			Form.usingPrefix('k');	
			var DnsServer = GetWanDnsServerString(Wan.IPv6PrimaryDNS, Wan.IPv6SecondaryDNS);
			Form.addParameter('DNSServer',DnsServer);
			Form.endPrefix();
		}
    }    	
	
	if (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed" )
	{
	  Form.usingPrefix('j');  
		if(Wan.EnableDSLite == "0")
		{
			Wan.IPv6DSLite = 'Off';
			Wan.IPv6AFTRName = "";
		}
		Form.addParameter('WorkMode',Wan.IPv6DSLite);
		Form.addParameter('AFTRName',Wan.IPv6AFTRName);
		Form.endPrefix();
	}

	if ( Wan.ProtocolType.toString() == "IPv4" && Wan.Mode == "IP_Routed" && true == Is6RdSupported())
	{
	    Form.usingPrefix('r');
		if ('Off' == Wan.RdMode)
		{
			Form.addParameter('Enable','0');  
		}
		else if('Dynamic' == Wan.RdMode)
		{
			Form.addParameter('Enable','1');  
			Form.addParameter('RdMode',Wan.RdMode);
		}
		else
		{
			Form.addParameter('Enable','1');  
			Form.addParameter('RdPrefix',Wan.RdPrefix);
			Form.addParameter('RdPrefixLen',Wan.RdPrefixLen);
			Form.addParameter('RdBRIPv4Address',Wan.RdBRIPv4Address);
			Form.addParameter('RdIPv4MaskLen',Wan.RdIPv4MaskLen);
			if (Wan.EncapMode.toString().toUpperCase() != "PPPOE")
			{
				Form.addParameter('RdMode',Wan.RdMode);
			}
		}

		Form.endPrefix();
    }

    if ((CurrentBin.toUpperCase() == 'E8C') && (Wan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0) &&
        (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0)) {
        Form.usingPrefix('w');
        Form.addParameter('Enable', Wan.X_HW_BridgeHostEnable);
        Form.endPrefix();
    }
}

function FillForm(Form, Wan)  
{
    if (IsAdminUser())
        FillSysForm(Form, Wan);
    else
        FillUserForm(Form, Wan);
}

function CleanServiceListVoip()
{
    var ServiceList = document.getElementById("WanServiceList_select");
    var Length = ServiceList.options.length;
	var ProductName = GetProductName();
	var IsSupportVoice = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
	
	if ((ProductName != 'HG8045') && (ProductName != 'HG8010') && (ProductName != 'HG8040') && (ProductName != 'HG8045A') &&
		(ProductName != 'HG8045H') && (ProductName != 'HG8045D') && (ProductName != 'HG8021H') && (IsSupportVoice != '0')) {
		return true;
	}
	
    for (var i = Length; i >=0; i--)
    {
        try
        {
            var Child = ServiceList.options[i];
            if (Child == undefined)
            {
               continue;
            }
            
            if ((Child.value.toString().toUpperCase() == "VOIP" 
               || Child.value.toString().toUpperCase() == "TR069_VOIP" 
               || Child.value.toString().toUpperCase() == "VOIP_INTERNET"
               || Child.value.toString().toUpperCase() == "TR069_VOIP_INTERNET"
			   || Child.value.toString().toUpperCase() == "VOIP_IPTV" 
			   || Child.value.toString().toUpperCase() == "TR069_VOIP_IPTV")
			   && (selctIndex == -1))
            {
                ServiceList.remove(i);        
            }			
        }
        catch(ex)
        {
        }
    }
}


function GetSelectWan(wanname)
{
	var WanResult = new Array();
	var WanList = GetWanList();
	for(var i = 0; i < WanList.length; i++)
	{
		if(domainTowanname(WanList[i].domain) == wanname)
		{
			WanResult = WanList[i];
			return WanResult;
		}
	}
	return null;
}
function GetWanInfoSelected()
{
	var Control = document.getElementById("WanConnectName_select");
	if (Control == null)
	{
	    return null;
	}
	if(isSessionWanUser())
	{
		var SelectWanValue=Control.value.split("_NewConnect")[0];
		var SelectWan = GetSelectWan(SelectWanValue);
	}
	else
	{
		var SelectWan = GetSelectWan(Control.value);
	}
	return SelectWan;
}	

function btnAddWanCnt()
{
	CurrentWan = defaultWan.clone();

	var wanInfoTmp = null;
    if (AddType == 2)
	{
	    wanInfoTmp = GetWanInfoSelected();
		if (wanInfoTmp == null)
		{
		    return null;
		}
		return true;
	}
    return null;
}	

function GetBrotherWan(wanTmp)
{
    var i = 0;
	for (i = 0; i < GetWanList().length; i++)
	{
		if ((GetWanList()[i].domain.substring(0, 55) == 
	       wanTmp.domain.substring(0, 55))
           && (GetWanList()[i].domain != wanTmp.domain))
        {
			return GetWanList()[i];
		}				
	}
	return null;
}

function GetBrotherWanindex(wanTmp)
{
    var i = 0;
	for (i = 0; i < GetWanList().length; i++)
	{
		if ((GetWanList()[i].domain.substring(0, 55) == 
	       wanTmp.domain.substring(0, 55))
           && (GetWanList()[i].domain != wanTmp.domain))
        {
			return i;
		}				
	}
	return null;
}


function ControlWanNewConnection()
{
	var Control = getElById("WanConnectName_select");
	if(Control.value == 'New')
	{
		AddType = 1;
	}
	else
	{
		AddType = 2;
	}
	
}

function isSupportPingReponse() {
    if ((mngtTY40 == '0') || (isSupportIPSET == '0')) {
        return false;
    }

    if (getValue('WanConnectMode_select').toString().toUpperCase().indexOf("BRIDGED") >= 0) {
        return false;
    }

    return true;
}
