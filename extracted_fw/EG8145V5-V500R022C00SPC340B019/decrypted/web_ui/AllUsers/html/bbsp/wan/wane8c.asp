<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="Pragma" content="no-cache" />
    <link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
    <script src="../../../resource/common/jquery.min.js" type="text/javascript"></script>
    <script language="JavaScript" src="../../../resource/common/util.js"></script>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(common.js);%>"></script>
    <script language="JavaScript" src="../../../resource/common/InitForm.asp"></script>
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, Languages, htmlpage_language, dst_ip_forwarding_cfg_ctc_language, guideinternet_language);%>"></script>
    <title>WAN Configuration</title>
    
    <style>
    .TextBox
    {
        width:150px;  
    }
    .Select
    {
        width:157px;  
    }
    .TextArea
    {
        width:475px;  
    }
    </style>
</head>

<script>
var stopWanStateTimer = function() {
  if (window.parent.stopWanStateTimer) {
    window.parent.stopWanStateTimer();
  }
}

function GetLanguage(Name) {
    return Languages[Name];
}

function AlertMsg(Name) {
    AlertEx(GetLanguage(Name));
}

function stLayer3Enable(domain, lay3enable) {
  this.domain = domain;
  this.L3Enable = lay3enable;
}

var LanModeList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 
function checkHon() {
  if ((isSupportPCDN == '1') && (typeWordCom != 'CDN') && (typeWordCom != 'V8XXC')) {
    return true;
  }
  return false;
}

function IsL3Mode(LanId) {
  if (parseInt(LanId) >= LanModeList.length) {
    return "null";
  }
  return LanModeList[parseInt(LanId)-1].L3Enable;
}

var guideIndex = '<%HW_WEB_GetGuideChl();%>';
var E8CAPFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_E8CAP_SWITCH);%>';
var E8CRONGHEFlag = '<%HW_WEB_GetFeatureSupport(FT_SHMP_RONGHE);%>';
var SCCTFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SCCT);%>';
var IPV4V6Flag = '<%HW_WEB_GetFeatureSupport(FT_INTERNET_WAN_DEFAULT_DUALSTACK);%>';
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var isIPV6DemandWan = '<%HW_WEB_GetFeatureSupport(FT_BBSP_IPV6_DEMAND_WAN);%>';
var CQCTFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CQCT);%>';

guideIndex = guideIndex - 48;
var vxlanfeature = <%HW_WEB_GetFeatureSupport(FT_VXLAN);%>;

var VXLAN_VXLANConfig_Interface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.VXLANMAP.VXLANView.{i},RemoteEndPoints|WANInterface|VNI, stVXLANConfig);%>;
var specWanMaxNum = '<%HW_WEB_GetSPEC(BBSP_SPEC_IFM_WANNUM.UINT32);%>';
if(specWanMaxNum == 0) {
	specWanMaxNum = 8;
}

var vxlanWanMaxNum = 10;
var notVxlanWanMaxNum = 8;

if (specWanMaxNum == 8) {
    vxlanWanMaxNum = 6;
}

function stVXLANConfig(domain, RemoteEndPoints, WANInterface, VNI)
{
    this.domain = domain;
	this.RemoteEndPoints = RemoteEndPoints;
	this.WANInterface = WANInterface;
	this.VNI = VNI;
}

var CfgGuide = -1;
if (window.location.href.indexOf("cfgguide") != -1)
{
	para = window.location.href.split("cfgguide")[1];
	CfgGuide = para.split("=")[1];
}

function doKey(e){   
    var ev = e || window.event;
    var obj = ev.target || ev.srcElement;
    var t = obj.type || obj.getAttribute('type');

    if(ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea"){   
        return false;   
    }   
}

document.onkeypress=doKey;   

document.onkeydown=doKey;   

function NeedClearWanIPv4Info(Wan)
{
	if ("1" == Wan.IPv4Enable && Wan.Mode == 'IP_Routed' && Wan.IPv4AddressMode == 'Static')
		return false;
	else
		return true;
}

function NeedClearWanIPv6AddressInfo(Wan)
{
	if ("1" == Wan.IPv6Enable && Wan.Mode == 'IP_Routed' && Wan.IPv6AddressMode == "Static")
		return false;
	else
		return true;
}

function NeedClearWanIPv6PrefixInfo(Wan)
{
	if ("1" == Wan.IPv6Enable && Wan.Mode == 'IP_Routed' && Wan.IPv6PrefixMode == "Static")
		return false;
	else
		return true;
}

function ModifyWanData(Wan)
{

	if(true == NeedClearWanIPv4Info(Wan))
	{
		Wan.IPv4IPAddress    = "";
		Wan.IPv4SubnetMask   = "";
		Wan.IPv4Gateway      = "";
		Wan.IPv4PrimaryDNS   = "";
		Wan.IPv4SecondaryDNS = "";
	}

	if(true == NeedClearWanIPv6AddressInfo(Wan))
	{
		Wan.IPv6IPAddress    = "";
		Wan.IPv6PrimaryDNS   = "";
		Wan.IPv6SecondaryDNS = "";
		Wan.IPv6AddrMaskLenE8c   = "";
		Wan.IPv6GatewayE8c = "";
	}
	
	if(true == NeedClearWanIPv6PrefixInfo(Wan))
	{
		Wan.IPv6StaticPrefix = "";
	}
}
var curEnterStyle = "";
if(window.location.href.indexOf("wane8c.asp?") > 0)
{
	var currentUrl = window.location.href;
	var tempId = (currentUrl.split("?"))[1];
	if(tempId != "")
	{
		curEnterStyle = "Link";
	}
}
else
{
	curEnterStyle = "Direct";
}

function GetCurrentLinkWan()
{
	var curUrl = window.location.href;
	var curMacId = (curUrl.split("?"))[1];
	var Wan = GetWanList();
	for(var i = 0; i < Wan.length; i++)
	{
		if (Wan[i].MacId == curMacId )
		{
		    return domainTowanname(Wan[i].domain);
		}
	}
	return null;
}

var IfVisual = "<% HW_WEB_IfVisualOltUser();%>";

function LoadFrame()
{   
	ModifyWanList(ModifyWanData);
	ControlWanNameList();
	DisplayConfigPanel(1);
	ControlWanNewConnection();
	if(curEnterStyle == "Link")
	{
		var curLinkWan = GetCurrentLinkWan();
		if(curLinkWan != null)
		{
			setSelect("WanConnectName_select",curLinkWan);
		}
	}
	ControlWanPage();
	WanSelectControl();

	if (1 == CfgGuide)
	{
		if(1 == smartlanfeature)
		{
			setDisplay("firstpage", 1);
			setDisplay("guideontauth", 0);
		}
		setDisplay("PromptPanel", 0);
		setDisplay("btnguidewan", 1);
		$("#ConfigPanel").css("background-color", "#FFFFFF");
		window.parent.adjustParentHeight();
	}
	else
	{
		setDisplay("PromptPanel", 1);
		setDisplay("btnguidewan", 0);
		if (E8CAPFlag == '1')
		{
			$("#ConfigPanel").css("background-color", "#d8d8d8");
		}
	}	

   if(IfVisual==1)
   {
      pageDisable();
	  setDisable("ButtonNewWan",1);
	  setDisable("ButtonNew",1);
	  setDisable("ButtonApply",1);
      setDisable("ButtonDelete",1);
	  setDisable("WanConnectName_select",0);
   }

   if (E8CRONGHEFlag == 1)
   {
	  setDisplay("DivWan_Port_checkbox" + stbport, 0);
   }
}

function __GetISPWanOnlyRead()
{
	return ("<%HW_WEB_GetFeatureSupport(BBSP_FT_ISPSSID_DISPALY);%>" == "1")?true:false;
}
</script>

<body  class="mainbody" onLoad="LoadFrame();" >
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wanaddressacquire.asp"></script>
<script language="javascript" src="../../bbsp/common/wandns.asp"></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info_e8c.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_DeepCleanCache_Resource(wan_settings_e8c.asp);%>"></script>
<script language="javascript" src="../../amp/common/<%HW_WEB_DeepCleanCache_Resource(wlan_list.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/wanpageparse.asp"></script>
<script language="javascript" src="../../bbsp/common/wandatabind.asp"></script>
<script language="javascript" src="../../bbsp/common/wancontrole8c.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_check.asp"></script>
<script language="javascript" src="../../bbsp/common/topoinfo.asp"></script>
<script language="JavaScript" type="text/javascript">

var Wan = GetWanList();
var IsSurportPolicyRoute  = "<% HW_WEB_GetFeatureSupport(BBSP_FT_ROUTE_POLICY);%>";
var DoubleFreqFlag = <%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>;  
var DefaultDHCPv6  = <%HW_WEB_GetFeatureSupport(FT_IPV6_DEFAULT_DHCPv6);%>;
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var RemoteWanFeature = "<%HW_WEB_GetFeatureSupport(FT_REMOTE_LOCAL_WAN);%>"; 
var stbport = '<%HW_WEB_GetSTBPort();%>';
var ApFeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>'; 
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';

var isFullCfgVxlan = "<%HW_WEB_GetFeatureSupport(FT_WEB_FULLCFG_VXLAN);%>";
function IsSupportDualsStack()
{
	var Custom_cmcc =  '<%HW_WEB_GetFeatureSupport(FT_WAN_DEFAULT_DUALSTACK);%>';
	if ('1' == Custom_cmcc )
	{
		return true;
	}
	else
	{
		return false;
	}	
}

function IsAdminUser()
{
    return (curUserType == sysUserType);
}

function TopoInfoClass(Domain, EthNum, SSIDNum)
{   
    this.Domain = Domain;
    this.EthNum = EthNum;
    this.SSIDNum = SSIDNum;
}

var ethNum = '<%WEB_GetEthNum();%>';
var SSIDNum = '<%WEB_GetSsidNum();%>';
var TopoInfo = new TopoInfoClass('InternetGatewayDevice.X_HW_Topo', parseInt(ethNum), parseInt(SSIDNum));
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
TopoInfo.EthNum = '<%GetLanPortNum();%>';

if (PonUpportConfig == 1) {
	TopoInfo.EthNum = parseInt(TopoInfo.EthNum) + getIsHaveHiddenPort();
}

function GetTopoInfo()
{
    return TopoInfo;
}
function GetTopoItemValue(Name)
{
    return TopoInfo[Name];
}
function getIsHaveHiddenPort() {
	if (UpUserPortID > 5) {
		return 0;
	} else {
		return 1;
	}
}
var TianYiFlag = '<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>';
function isPortInAttrName()
{
    if((1 == TianYiFlag) && ('E8C' == CurrentBin.toUpperCase()))
	{
		return true;
	}
	return false;
}
if(isPortInAttrName())
{	
	var portNum = parseInt(GetTopoInfo().EthNum,10);
	
	if(portNum > 0)
	{
		for(var i=1;i<=portNum;i++)
		{
			if(i != 2)
			{
				Languages['LAN'+ i+ 'e8c'] = getTianYilandesc(i);
			}
		}
	}
}
function isSessionWanUser()
{
    if(IsCmcc_rmsMode() && (CfgModeWord.toUpperCase() != 'HUBCMCC_RMS')
						&& (CfgModeWord.toUpperCase() != 'HUBCMDC')
						&& (CfgModeWord.toUpperCase() != 'HUBCIOT'))
	{
		return true;
	}
	return false;
}
if((parseInt(GetTopoInfo().EthNum,10) <= 2) || (false == IsE8cFrame()))
{
	Languages['LAN2e8c'] = Languages['LAN2e8c_ex'];
}

var CfgMode = '<%HW_WEB_GetCfgMode();%>';
if(CfgMode.toUpperCase().indexOf("GZGD") == 0)
{
	Languages['LAN2e8c'] = Languages['LAN2e8c_ex'];
}

if( stbport > 0)
{
	Languages['LAN'+ stbport+ 'e8c'] = Languages['LANSTB'];
	Languages['LAN2e8c'] = Languages['LAN2e8c_ex'];
}

if('1' == ApFeature)
{
	Languages['LAN1e8c'] = Languages['LAN1'];
	Languages['LAN2e8c'] = Languages['LAN2'];
	Languages['LAN3e8c'] = Languages['LAN3'];
	Languages['LAN4e8c'] = Languages['LAN4'];
	Languages['LAN5e8c'] = Languages['LAN5'];
	Languages['LAN6e8c'] = Languages['LAN6'];
	Languages['LAN7e8c'] = Languages['LAN7'];
	Languages['LAN8e8c'] = Languages['LAN8'];
}
</script>
<div id="PromptPanel">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("wan", GetDescFormArrayById(Languages, "bbsp_mune"), GetDescFormArrayById(Languages, "WanHeadDescription"), false);
</script>
	<div class="title_spread"></div>
</div>

<script>
var gWanMode = 'IP_Routed';
var g_lastSetControlIndex = -2;

function setControl(Index)
{
    g_lastSetControlIndex = Index;
    setDisable("ButtonApply", "0");
    setDisable("ButtonNewWan", "0");
    if (-1 == Index)
    {
        var CurrentWan = new WanInfoInst(); 

		if (1 == DefaultDHCPv6)
	    {
		    CurrentWan.IPv6AddressMode = "DHCPv6";
	    }
        
       	var IPProtVer = Instance_IPVersion.GetIPProtVerMode();
		if (IsSupportDualsStack())
		{
			CurrentWan.ProtocolType = "IPv4/IPv6";
			CurrentWan.IPv4Enable = "1";
			CurrentWan.IPv6Enable = "1";
		}
		
		if ((IPV4V6Flag == 1) && (CurrentWan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0) && (CurrentWan.Mode.toUpperCase().indexOf("ROUTE") >= 0))
		{
			CurrentWan.ProtocolType = "IPv4/IPv6";
			CurrentWan.IPv4Enable = "1";
			CurrentWan.IPv6Enable = "1";
		}
				
        else if(2 == IPProtVer)
		{
			CurrentWan.ProtocolType = "IPv6";
			CurrentWan.IPv4Enable = "0";
			CurrentWan.IPv6Enable = "1";
		}
		
		if ((SCCTFlag == 1) && (CurrentWan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0) && (CurrentWan.Mode.toUpperCase().indexOf("ROUTE") >= 0))
		{
			CurrentWan.ProtocolType = "IPv4/IPv6";
			CurrentWan.IPv4Enable = "1";
			CurrentWan.IPv6Enable = "1";
		}
		
		if(GetRunningMode() == "1")
		{
			CurrentWan.VlanId = "1";
			CurrentWan.UserName = "";
			CurrentWan.Password = "";
		}
		
		if(true == Option60DisplayFlag(CurrentWan))
		{
			CurrentWan.EnableOption60 = "0";
			CurrentWan.X_HW_IPoEName = "";
			CurrentWan.X_HW_IPoEPassword = "";
		}
		
        EditFlag = "ADD";
        ChangeUISource = null;
        if (typeof CurrentWan && CurrentWan.Mode) {
          gWanMode = CurrentWan.Mode;
        }
		
		var AddWanCnt = btnAddWanCnt();
		if (true == AddWanCnt)
		{
			var wanInfoTmp = null;
			wanInfoTmp = GetWanInfoSelected();

			CurrentWan.EnableVlan = wanInfoTmp.EnableVlan;
			CurrentWan.VlanId = wanInfoTmp.VlanId ;
			CurrentWan.PriorityPolicy = wanInfoTmp.PriorityPolicy;
			CurrentWan.Priority = wanInfoTmp.Priority;
			CurrentWan.DefaultPriority = wanInfoTmp.DefaultPriority;
		}
		else if (false == AddWanCnt)
		{
			EditFlag = "EDIT";
			ChangeUISource = null;
			return false;
		}

        BindPageData(CurrentWan);
        ControlPage(CurrentWan);
        displaysvrlist();
        DisplayConfigPanel(1);
   }
   else
   {
        var Feature = GetFeatureInfo();
        if (Feature.IPProtChk == 1)
        {
			var protoType = getElementById('WanIP_Mode_select');
            protoType.options.length = 0;
			protoType.options.add(new Option(Languages['IPv4'],'IPv4'));
			protoType.options.add(new Option(Languages['IPv6'],'IPv6'));	
			protoType.options.add(new Option(Languages['IPv4IPv6e8c'],'IPv4/IPv6')); 
		}

		var CurrentWan = GetWanInfoSelected();
        if (CurrentWan && CurrentWan.Mode) {
          gWanMode = CurrentWan.Mode;
        }
        EditFlag = "EDIT";
        BindPageData(CurrentWan);
        ControlPage(CurrentWan);
        DisplayConfigPanel(1);

       if (isPortInAttrName() && (CurrentWan.ServiceList.indexOf("SPECIAL_SERVICE_VR") >=0)) {
            setDisable("ButtonNew",1);
            setDisable("ButtonApply",1);
            setDisable("ButtonDelete",1);
        }
   }

	displayProtocolType();
	displayWanMode();
}

function ControlWanNameList()
{
	var Control = getElById("WanConnectName_select");
	var WanList = GetWanList();
	var i = 0;
	var commonWanNum = WanList.length;
    Control.options.length = 0;
	
    for (i = 0; i < WanList.length; i++) {
        if ((isFullCfgVxlan == 1) && (WanList[i].X_HW_VXLAN_Enable == 1)) {
			commonWanNum = commonWanNum - 1;
            continue;
        }
        var Option = document.createElement("Option");
        Option.value = domainTowanname(WanList[i].domain);
        Option.innerText = MakeWanName1(WanList[i]);
        Option.text = MakeWanName1(WanList[i]);
        Control.appendChild(Option);
    }
    if ((WanList.length == 0) || ((isFullCfgVxlan == 1) && (commonWanNum == 0))) {
        var NullOption = document.createElement("Option");
        NullOption.value = 'New';
        NullOption.innerText = '';
        NullOption.text = '';
        Control.appendChild(NullOption);
    }
}

function ControlWanPage()
{
	var Control = getElById("WanConnectName_select");
	if(Control.value == 'New')
	{
		
		setControl(-1);	
		if(!isSessionWanUser())
		{
			setDisable("ButtonNew", "1"); 
		}
		return;
	}
	else
	{
		var SelectWan = GetSelectWan(Control.value);
		if(IsTr069WanOnlyRead() && (SelectWan.ServiceList.indexOf("TR069") >= 0))
		{
			setDisable("ButtonDelete", 1);
			if(!isSessionWanUser())
			{
				setDisable("ButtonNew", 1);
			}
		}
		else
		{
			setDisable("ButtonDelete", 0);
			setDisable("ButtonNew", 0);
		}
		
		setControl(-2);	
	}
	
}
function IsZJCmccMode()
{
	if((CfgModeWord.toUpperCase() == 'ZJCMCC_RMS') ||
		(CfgModeWord.toUpperCase() == 'ZJCMCC') ||
		(CfgModeWord.toUpperCase() == 'ZJCMDC') ||
		(CfgModeWord.toUpperCase() == 'ZJCIOT'))
	{
		return true;
	}
	return false;
}
function ClickAddWan()
{	
    if (vxlanfeature != 1) {
        if (GetWanList().length >= 8) {
            AlertMsg("WanIsFull");
            return false;    
        }
    } else {
        if (GetWanList().length >= specWanMaxNum) {
            AlertMsg("WanIsFull");
            return false;
        }
        var WanList = GetWanList();
        var vxlanWanNum = 0;
        var notVxlanWanNum = 0;
        for (i=0; (WanList.length > 0) && (i < WanList.length); i++) {
            if (WanList[i].X_HW_VXLAN_Enable == 1) {
               vxlanWanNum++;
            } else {
               notVxlanWanNum++;
            }
        }
        if (vxlanWanNum > vxlanWanMaxNum) {
            AlertMsg("VxlanWanIsFull");
            return false;    
        }
        if (notVxlanWanNum > notVxlanWanMaxNum) {
            AlertMsg("NotVxlanWanIsFull");
            return false; 
        }
    }

	var Control = getElById("WanConnectName_select");
	if(Control.value == 'New')
	{
		return;
	}
	else
	{
		if(isSessionWanUser())
		{
			var RealWanValue = Control.value + "_NewConnect";
			var NullOption = document.createElement("Option");
			NullOption.value = RealWanValue;
			NullOption.innerText = '';
			NullOption.text = '';
			Control.appendChild(NullOption);
			setSelect("WanConnectName_select", RealWanValue);
		}
		setControl(-1);	
	}
	if (IsZJCmccMode())
	{
		setDisable("Option60Enable", 1);
	}

    OtherWanProcess();

	option60WanProcess();
}

function isExistOptionNew()
{
	var objSelect = getElById("WanConnectName_select");
	for(var i = 0; i < objSelect.options.length; i++)
	{
		if(objSelect.options[i].value == 'New')
		{
			return true;
		}
	}
	return false;
}

function ClickNewWan()
{
    if (vxlanfeature != 1) {
        if (GetWanList().length >= 8) {
            AlertMsg("WanIsFull");
            return false;
        }
    } else {
        if (GetWanList().length >= specWanMaxNum) {
            AlertMsg("WanIsFull");
            return false;
        }
        var WanList = GetWanList();
        var vxlanWanNum = 0;
        var notVxlanWanNum = 0;
        for(i=0; (WanList.length > 0) && (i < WanList.length); i++) {
            if (WanList[i].X_HW_VXLAN_Enable == 1) {
               vxlanWanNum++;
            } else {
               notVxlanWanNum++;
            }
        }
        if (vxlanWanNum > vxlanWanMaxNum) {
            AlertMsg("VxlanWanIsFull");
            return false;    
        }
        if (notVxlanWanNum > notVxlanWanMaxNum) {
            AlertMsg("NotVxlanWanIsFull");
            return false; 
        }
    }

	var Control = getElById("WanConnectName_select");
	if(!isExistOptionNew())
	{
		var NullOption = document.createElement("Option");
		NullOption.value = 'New';
		NullOption.innerText = '';
		NullOption.text = '';
		Control.appendChild(NullOption);
	}
	setSelect("WanConnectName_select",'New');
	WanSelectControl();
	setDisable("ButtonApply", "0");
	
	if (IsZJCmccMode())
	{
		setDisable("Option60Enable", 1);
	}
}



function CheckOption60(Wan)
{
	if(true == Option60DisplayFlag(Wan))
	{
		if("0" == Wan.EnableOption60)
		{
			return true;
		}
		
		if(Wan.X_HW_IPoEName == "")
		{
			AlertEx(getErrorMsg("IPv4UserNamee8c",ERR_MUST_INPUT));
			return false;
		}
		if(Wan.X_HW_IPoEPassword == "")
		{
			AlertEx(getErrorMsg("IPv4Passworde8c",ERR_MUST_INPUT));
			return false;			
		}
	}	
	return true;

}

function isValueNumber(value)
{	    
	for (var i = 0; i < value.length; i++)
	{
		if (value[i].charCodeAt() < '0'.charCodeAt() || value[i].charCodeAt() > '9'.charCodeAt())
		{
			return false;
		}
	}
    
	return true;
}

function IsBridgeHostEnableValid(Wan, editFlag)
{
    if (CurrentBin.toUpperCase() != 'E8C') {
        return true;
    }

    if ((Wan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0) &&
        (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >= 0) && (Wan.X_HW_BridgeHostEnable == 1)) {
        if (editFlag == "ADD") {
            return (!IsHaveBridgeHostEnableByAdd());
        } else {
            return (!IsHaveBridgeHostEnableByEdit(Wan.domain));
        }
    }

    return true;
}

function DisplayConfigPanel(Flag)
{
    setDisplay("ConfigPanel", Flag); 
    setDisplay("ConfigPanelButtons", Flag);  
}

function TransPrivateData(Wan)
{
	if (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed" )
	{
		if(Wan.EnableDSLite == "0")
		{
			Wan.IPv6DSLite = 'Off';
			Wan.IPv6AFTRName = "";
		}
	}
}

function OnAddApply()
{
    var Wan = GetPageData();
	var FeatureInfo = GetFeatureInfo();
    
	TransPrivateData(Wan);
    if (CheckWan(Wan) == false)
    {
        return false;
    }

    if (vxlanfeature == 1) {
        var WanList = GetWanList();
        var vxlanWanNum = 0;
        var notVxlanWanNum = 0;

        for(i = 0; WanList.length > 0 && i < WanList.length; i++) {
            if (WanList[i].X_HW_VXLAN_Enable == 1) {
                vxlanWanNum++;
            } else {
                notVxlanWanNum++;
            }
        }

        if(vxlanWanNum >= vxlanWanMaxNum  && getCheckVal('Vxlan_Enable') == 1) {
            AlertMsg("VxlanWanIsFull");
            return false;
        }

        if(notVxlanWanNum >= notVxlanWanMaxNum && getCheckVal('Vxlan_Enable') == 0) {
            AlertMsg("NotVxlanWanIsFull");
            return false; 
        }
    }

    if (CheckForSession(Wan, GetAddType()) == false)
    {
        return false;
    }

	if (CheckOption60(Wan) == false)
	{
        return false;		
	}

	if (false == relateIPTVParaByInternet(Wan))
	{
		return;
	}    
    
    if (IsBridgeHostEnableValid(Wan, "ADD") == false) {
        AlertMsg("NoSetBridgeHostEnable");
        return false;
    }

    setDisable("ButtonApply", "1");
	setDisable("ButtonDelete", "1");
	setDisable("ButtonNew", "1");
	setDisable("ButtonNewWan", "1");
    
    var Form = new webSubmitForm();
    FillForm(Form, Wan);
    
    var DnsUrl = (Wan.IPv6AddressMode=="Static") ? "&k=GROUP_a_y.X_HW_IPv6.IPv6DnsServer" : "";
    var IPv6Path = (Wan.IPv6Enable == "1") ? ('&m=GROUP_a_y.X_HW_IPv6.IPv6Address&n=GROUP_a_y.X_HW_IPv6.IPv6Prefix'+DnsUrl) : '';
    var DSLite = (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed") ? ('&j=GROUP_a_y.X_HW_IPv6.DSLite') : '';
    var Path6Rd = (true == Is6RdSupported()) ? ('&r=GROUP_a_y.X_HW_6RDTunnel') : '';
    var PathHost = (CurrentBin.toUpperCase() == 'E8C') ? ('&w=GROUP_a_y.X_HW_BridgeHost') : '';
    var iptvInfoUrl = '';
    var dhcpOption60Url = '';
    if (CQCTFlag == 1) {
        if (IsIPOEOtherRouteWan(Wan)) {
            iptvInfoUrl= '&h=InternetGatewayDevice.Services.X_HW_IPTV';
            Form.addParameter('h.UserID', getValue('IPTVAuthUserName'));
            if (getValue('IPTVAuthPassWord') != defaultPwd) {
                Form.addParameter('h.Password', getValue('IPTVAuthPassWord'));
            }
            dhcpOption60Url = ('&i=GROUP_a_y.X_HW_ExtendDHCPOPTION60');
            Form.addParameter('i.Enable', getCheckVal('DhcpOption60Enable'));
            Form.addParameter('i.Type', Number(getValue('DhcpOption60Type')));
            Form.addParameter('i.ValueMode', Number(getValue('DhcpOption60Mode')));
        }
    }

    var Option60Url = "";
    if (isOption60Wan()) {
        Option60Url = '&z=GROUP_a_y.X_HW_ExtendDHCPOPTION60';
        Form.addParameter('z.Enable', Wan.Option60_enable);
        Form.addParameter('z.Type', '31');
        Form.addParameter('z.Account', Wan.Option60_User);
        Form.addParameter('z.Password', Wan.Option60_Pwd);
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    var Url = 'addcfg.cgi?' + GetAddWanUrl(Wan) + IPv6Path + DSLite + Path6Rd + Option60Url + PathHost + iptvInfoUrl + dhcpOption60Url + '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';

	if (1 == CfgGuide)
	{
		Url += '&cfgguide=1';
	}

    stopWanStateTimer();
    Form.setAction(Url);
    Form.submit();    
}

function addParamForBroWan(Form, wan)
{
	Form.usingPrefix('u');
    Form.addParameter('X_HW_VLAN', wan.VlanId);
    Form.addParameter('X_HW_PriPolicy',wan.PriorityPolicy);
    Form.addParameter('X_HW_PRI',wan.Priority);
	Form.addParameter('X_HW_DefaultPri', wan.DefaultPriority);
    Form.endPrefix();
}

function filterWan(wanItem)
{
	if ((wanItem.ServiceList.toUpperCase().indexOf("OTHER") >= 0 || wanItem.ServiceList.toUpperCase().indexOf("IPTV") >= 0)
		&& (wanItem.domain.indexOf("WANPPPConnection") >= 0)
		&& (wanItem.Mode.toUpperCase().indexOf('_ROUTED') >= 0))
	{
		return true;
	}
	return false;
}

function relateIPTVParaByInternet(wanItem)
{
	var ret = true;
	var pppusername = '';
	var ppppassword = '';
	var IPTVWan = new Array();	

	if ('1' != "<% HW_WEB_GetFeatureSupport(BBSP_FT_PPPUSER_RELATE_SET);%>")
	{
		return true;
	}

	if ((wanItem.ServiceList.toUpperCase().indexOf("INTERNET") < 0)
		|| (wanItem.IPv4AddressMode.toUpperCase() != "PPPOE")
		|| (wanItem.Mode.toUpperCase().indexOf('_ROUTED') < 0))
	{
		return true;
	}

	IPTVWan = GetWanListByFilter(filterWan);   
	if (IPTVWan.length <= 0)
	{
		var JSSpecWan = getWANByVlan(JsctSpecVlan);

		for (var i = 0; i < JSSpecWan.length; i++)
		{
			if (filterWan(JSSpecWan[i]))
			{
				IPTVWan.push(JSSpecWan[i]);
				break;
			}
		}		
	}

	if (IPTVWan.length <= 0)
	{
		return true;
	}	
	
	if (wanItem.UserName.length > (64 - 6))
	{
		AlertMsg("usernameOverLength");
		return false;
	}	

	var SpecPPPWanCfgParaList = new Array(new stSpecParaArray("x.Username", wanItem.UserName + '@VIDEO', 1),
									      new stSpecParaArray("x.Password", wanItem.Password, 1));
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
	Parameter.SpecParaPair = SpecPPPWanCfgParaList;
	var tokenvalue = getValue('onttoken');
	var url = 'setajax.cgi?x=' + IPTVWan[0].domain + '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html'
	if (1 == CfgGuide)
	{
		url += '&cfgguide=1';
	}	
	ret = HWSetAction("ajax", url, Parameter, tokenvalue);	
	return ret;

}

function OnEditApply()
{
    var Wan = GetPageData();

    var CurrentWan = GetWanInfoSelected();
    if (vxlanfeature == 1) {
        if (CurrentWan.X_HW_VXLAN_Enable == 1) {
            for (var i = 0; i < VXLAN_VXLANConfig_Interface.length - 1; i++) {
                if ((VXLAN_VXLANConfig_Interface[i].WANInterface == CurrentWan.domain) && (getCheckVal('Vxlan_Enable') == 0)) {
                   AlertEx(Languages['VxlanIsUsedNotDisable']);
                   return false;
                }
            }
        }
    }

	TransPrivateData(Wan);
    if (CheckWan(Wan) == false)
    {
        return false;
    }

    if (vxlanfeature == 1) {
        var WanList = GetWanList();
        var vxlanWanNum = 0;
        var notVxlanWanNum = 0;
        for (i = 0; (WanList.length > 0) && (i < WanList.length); i++) {
            if (WanList[i].X_HW_VXLAN_Enable == 1) {
                vxlanWanNum++;
            } else {
                notVxlanWanNum++;
            }
        }

        if (CurrentWan.X_HW_VXLAN_Enable == getCheckVal('Vxlan_Enable')) {
            if ((vxlanWanNum > vxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 1)) {
                AlertMsg("VxlanWanIsFull");
                return false;    
            }
            if ((notVxlanWanNum > notVxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 0)) {
                AlertMsg("NotVxlanWanIsFull");
                return false; 
            }
        } else if ((CurrentWan.X_HW_VXLAN_Enable == 1) && (getCheckVal('Vxlan_Enable') == 0)) {
            if ((notVxlanWanNum >= notVxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 0)) {
                AlertMsg("NotVxlanWanIsFull");
                return false; 
            }
        } else if((CurrentWan.X_HW_VXLAN_Enable == 0) && (getCheckVal('Vxlan_Enable') == 1)) {
            if ((vxlanWanNum >= vxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 1)) {
                AlertMsg("VxlanWanIsFull");
                return false;
            }
        }
    }
    
	if (CheckWanSet(Wan) == false)
	{
		return false;
	}
	
	if (CheckOption60(Wan) == false)
	{
        return false;		
	}
   	
	if (gWanMode != Wan.Mode && Wan.Mode == 'IP_Routed')
	{	
		Wan.IPv4NATEnable = 1;
	}

	if (false == relateIPTVParaByInternet(Wan))
	{
		return;
	}
    
    if (IsBridgeHostEnableValid(Wan, "EDIT") == false) {
        AlertMsg("NoSetBridgeHostEnable");
        return false;
    }

    setDisable("ButtonApply", "1");
	setDisable("ButtonDelete", "1");
	setDisable("ButtonNew", "1");
	setDisable("ButtonNewWan", "1");	
    
    var Form = new webSubmitForm();
    FillForm(Form, Wan);
    
    var IPv6PrefixUrl = GetIPv6PrefixAcquireInfo(Wan.domain);    
	if (IPv6PrefixUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable)
	{
		IPv6PrefixUrl = "&"+COMPLEX_CGI_PREFIX+"n=" +  Wan.domain + ".X_HW_IPv6.IPv6Prefix";
	}	
	else
	{
		IPv6PrefixUrl = (IPv6PrefixUrl == null) ? "" : ("&n="+IPv6PrefixUrl.domain);
	}	
    
    var IPv6addressUrl = GetIPv6AddressAcquireInfo(Wan.domain);
	if (IPv6addressUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable)
	{
		IPv6addressUrl = "&"+COMPLEX_CGI_PREFIX+"m=" +  Wan.domain + ".X_HW_IPv6.IPv6Address";
	}	
	else
	{
		IPv6addressUrl = (IPv6addressUrl == null) ? "" : ("&m="+IPv6addressUrl.domain);
	}
	
    var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
	  if (Wan.Mode == 'IP_Routed' && Wan.IPv6AddressMode=="Static" && DnsUrl == null)
	  {
		    DnsUrl = "&"+COMPLEX_CGI_PREFIX+"k=InternetGatewayDevice.X_HW_DNS.Client.Server";
	  }
	  else
	  {
		    DnsUrl = (DnsUrl == null) ? "" : ("&k="+DnsUrl.domain);
		    DnsUrl = (Wan.IPv6AddressMode=="Static") ? DnsUrl : "";
	  }

    var PathHost = "";
    if ((CurrentBin.toUpperCase() == 'E8C') &&  (Wan.Mode.toString().toUpperCase().indexOf("BRIDGED") >= 0 )) {
        var PathHost = "&w="+Wan.domain + ".X_HW_BridgeHost";
    }

	var CurrentWan = GetWanInfoSelected();
	var broWan = GetBrotherWan(CurrentWan);
	var FlagForAddBroWan = false;
	
	var FeatureInfo = GetFeatureInfo();
	
	var DSLite = (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed") ? ('.X_HW_IPv6.DSLite') : '';
	var Path6Rd = (true == Is6RdSupported()) ? ('.X_HW_6RDTunnel') : '';
    var DSLiteUrl = (DSLite != '') ? ('&j='+ Wan.domain + DSLite) : '';
    var Path6RdUrl = (Path6Rd != '') ? ('&r='+ Wan.domain + Path6Rd) : '';
    var iptvInfoUrl = '';
    var dhcpOption60Url = '';
    
    if (CQCTFlag == 1) {
        if (IsIPOEOtherRouteWan(Wan)) {
            iptvInfoUrl= '&h=InternetGatewayDevice.Services.X_HW_IPTV';
            Form.addParameter('h.UserID', getValue('IPTVAuthUserName'));
            if (getValue('IPTVAuthPassWord') != defaultPwd) {
                Form.addParameter('h.Password', getValue('IPTVAuthPassWord'));
            }
            dhcpOption60Url = ('&i=' + Wan.domain + '.X_HW_ExtendDHCPOPTION60.1');
            Form.addParameter('i.Enable', getCheckVal('DhcpOption60Enable'));
            Form.addParameter('i.Type', Number(getValue('DhcpOption60Type')));
            Form.addParameter('i.ValueMode', Number(getValue('DhcpOption60Mode')));
        }
    }

	if (((CurrentWan.VlanId != Wan.VlanId)
	  || (CurrentWan.PriorityPolicy != Wan.PriorityPolicy)
	  || (CurrentWan.EnableVlan != Wan.EnableVlan)
      || ((Wan.PriorityPolicy.toUpperCase() == 'SPECIFIED' ) && (CurrentWan.Priority != Wan.Priority))
	  || ((Wan.PriorityPolicy.toUpperCase() != 'SPECIFIED' ) && (CurrentWan.DefaultPriority != Wan.DefaultPriority)))
	  && (broWan != null))
	{
		var prompt = GetLanguage("brothwan") + MakeWanName(broWan) + GetLanguage("browanvlan");
		if (false == ConfirmEx(prompt))
		{
			return;
		}
		broWan.EnableVlan = Wan.EnableVlan;
		
		

		if (Wan.EnableVlan == "1")
		{
		  broWan.VlanId = Wan.VlanId;
				broWan.Priority = Wan.Priority;
		}
		else
		{
    		broWan.VlanId = 0;
			broWan.Priority = 0;
		}
		
		broWan.PriorityPolicy = Wan.PriorityPolicy;
		
		broWan.DefaultPriority = Wan.DefaultPriority;
		
		FlagForAddBroWan = true;
		

		if(!DoubleFreqFlag)
		{
			var Url = 'complex.cgi?'
					+ 'y=' + Wan.domain
					+ IPv6PrefixUrl
					+ IPv6addressUrl
					+ DnsUrl
                    + PathHost
                    + DSLiteUrl
                    + Path6RdUrl
                    + iptvInfoUrl
                    + dhcpOption60Url
					+ '&u=' + broWan.domain
					+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';
		}
		else
		{ 
		    if(IsSurportPolicyRoute == 1)
		    {
			    var Url = 'complex.cgi?'
					+ 'y=' + Wan.domain
					+ IPv6PrefixUrl
					+ IPv6addressUrl
					+ DnsUrl
                    + PathHost
                    + DSLiteUrl
                    + Path6RdUrl
                    + iptvInfoUrl
                    + dhcpOption60Url
					+ '&u=' + broWan.domain
					+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';   
			}
			else
			{     
			    var Url = 'complex.cgi?'
					+ 'y=' + Wan.domain
					+ IPv6PrefixUrl
					+ IPv6addressUrl
					+ DnsUrl
                    + PathHost
                    + DSLiteUrl
                    + Path6RdUrl
                    + iptvInfoUrl
                    + dhcpOption60Url
					+ '&u=' + broWan.domain
					+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';   			
			}
		}
	}
	else
	{
		if(!DoubleFreqFlag)
		{
			var Url = 'complex.cgi?'
					+ 'y=' + Wan.domain
					+ IPv6PrefixUrl
					+ IPv6addressUrl
					+ DnsUrl
                    + PathHost
                    + DSLiteUrl
                    + Path6RdUrl
                    + iptvInfoUrl
                    + dhcpOption60Url
					+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';
		}
		else
		{       
		    if(IsSurportPolicyRoute == 1)
		    {
			var Url = 'complex.cgi?'
					+ 'y=' + Wan.domain
					+ IPv6PrefixUrl
					+ IPv6addressUrl
					+ DnsUrl
                    + PathHost
                    + DSLiteUrl
                    + Path6RdUrl
                    + iptvInfoUrl
                    + dhcpOption60Url
					+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';  
		    }
		    else
		    {
		    	var Url = 'complex.cgi?'
					+ 'y=' + Wan.domain
					+ IPv6PrefixUrl
					+ IPv6addressUrl
					+ DnsUrl
                    + PathHost
                    + DSLiteUrl
                    + Path6RdUrl
                    + iptvInfoUrl
                    + dhcpOption60Url
					+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html'; 
		    }
		}
	}
	
	if (FlagForAddBroWan == true)
	{
	    addParamForBroWan(Form, broWan);
	}
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	if (1 == CfgGuide)
	{
		Url += '&cfgguide=1';
	}	

    stopWanStateTimer();
    Form.setAction(Url);
    Form.submit();
}

function OnEditApplyOmitBrother()
{
    var Wan = GetPageData();

    var CurrentWan = GetWanInfoSelected();
    if (vxlanfeature == 1) {
        if (CurrentWan.X_HW_VXLAN_Enable == 1) {
            for (var i = 0; i < VXLAN_VXLANConfig_Interface.length - 1; i++) {
                if ((VXLAN_VXLANConfig_Interface[i].WANInterface == CurrentWan.domain) && (getCheckVal('Vxlan_Enable') == 0)) {
                   AlertEx(Languages['VxlanIsUsedNotDisable']);
                   return false;
                }
            }
        }
    }

	TransPrivateData(Wan);
    if (CheckWan(Wan) == false)
    {
        return false;
    }

    if (vxlanfeature == 1) {
        var WanList = GetWanList();
        var vxlanWanNum = 0;
        var notVxlanWanNum = 0;
        for (i = 0; (WanList.length > 0) && (i < WanList.length); i++) {
            if (WanList[i].X_HW_VXLAN_Enable == 1) {
                vxlanWanNum++;
            } else {
                notVxlanWanNum++;
            }
        }

        if (CurrentWan.X_HW_VXLAN_Enable == getCheckVal('Vxlan_Enable')) {
            if ((vxlanWanNum > vxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 1)) {
                AlertMsg("VxlanWanIsFull");
                return false;    
            }
            if ((notVxlanWanNum > notVxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 0)) {
                AlertMsg("NotVxlanWanIsFull");
                return false; 
            }
        } else if ((CurrentWan.X_HW_VXLAN_Enable == 1) && (getCheckVal('Vxlan_Enable') == 0)) {
            if ((notVxlanWanNum >= notVxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 0)) {
                AlertMsg("NotVxlanWanIsFull");
                return false; 
            }
        } else if((CurrentWan.X_HW_VXLAN_Enable == 0) && (getCheckVal('Vxlan_Enable') == 1)) {
            if ((vxlanWanNum >= vxlanWanMaxNum) && (getCheckVal('Vxlan_Enable') == 1)) {
                AlertMsg("VxlanWanIsFull");
                return false;
            }
        }
    }

    if (CheckWanSet(Wan) == false)
    {
        return false;
    }
	
	if (CheckOption60(Wan) == false)
	{
        return false;		
	}
	
	if (gWanMode != Wan.Mode && Wan.Mode == 'IP_Routed')
	{	
		Wan.IPv4NATEnable = 1;
	}

	if (false == relateIPTVParaByInternet(Wan))
	{
		return;
	}
    
    if (IsBridgeHostEnableValid(Wan, "EDIT") == false) {
        AlertMsg("NoSetBridgeHostEnable");
        return false;
    }

    setDisable("ButtonApply", "1");
	setDisable("ButtonDelete", "1");
	setDisable("ButtonNew", "1");
	setDisable("ButtonNewWan", "1");
    
    var Form = new webSubmitForm();
    FillForm(Form, Wan);
    
    var IPv6PrefixUrl = GetIPv6PrefixAcquireInfo(Wan.domain);    
    if (IPv6PrefixUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable)
    {
        IPv6PrefixUrl = "&"+COMPLEX_CGI_PREFIX+"n=" +  Wan.domain + ".X_HW_IPv6.IPv6Prefix";
    }	
    else
    {
	IPv6PrefixUrl = (IPv6PrefixUrl == null) ? "" : ("&n="+IPv6PrefixUrl.domain);
    }	
    
    var IPv6addressUrl = GetIPv6AddressAcquireInfo(Wan.domain);
    if (IPv6addressUrl == null && "IP_Routed" == Wan.Mode && "1" == Wan.IPv6Enable)
    {
        IPv6addressUrl = "&"+COMPLEX_CGI_PREFIX+"m=" +  Wan.domain + ".X_HW_IPv6.IPv6Address";
    }	
    else
    {
        IPv6addressUrl = (IPv6addressUrl == null) ? "" : ("&m="+IPv6addressUrl.domain);
    }
	
    var DnsUrl = GetIPv6WanDnsServerInfo(domainTowanname(Wan.domain));
    if (Wan.Mode == 'IP_Routed' && Wan.IPv6AddressMode=="Static" && DnsUrl == null)
    {
        DnsUrl = "&"+COMPLEX_CGI_PREFIX+"k=InternetGatewayDevice.X_HW_DNS.Client.Server";
    }
    else
    {
        DnsUrl = (DnsUrl == null) ? "" : ("&k="+DnsUrl.domain);
        DnsUrl = (Wan.IPv6AddressMode=="Static") ? DnsUrl : "";
    }


    var FeatureInfo = GetFeatureInfo();
    var DSLite = (Wan.ProtocolType.toString() == "IPv6" && Wan.Mode == "IP_Routed") ? ('.X_HW_IPv6.DSLite') : '';
    var DSLiteUrl = (DSLite != '') ? ('&j='+ Wan.domain + DSLite) : '';

    var iptvInfoUrl = '';
    var dhcpOption60Url = '';
    if (CQCTFlag == 1) {
        if (IsIPOEOtherRouteWan(Wan)) {
            iptvInfoUrl= '&h=InternetGatewayDevice.Services.X_HW_IPTV';
            Form.addParameter('h.UserID', getValue('IPTVAuthUserName'));
            if (getValue('IPTVAuthPassWord') != defaultPwd) {
                Form.addParameter('h.Password', getValue('IPTVAuthPassWord'));
            }
            dhcpOption60Url = ('&i=' + Wan.domain + '.X_HW_ExtendDHCPOPTION60.1');
            Form.addParameter('i.Enable', getCheckVal('DhcpOption60Enable'));
            Form.addParameter('i.Type', Number(getValue('DhcpOption60Type')));
            Form.addParameter('i.ValueMode', Number(getValue('DhcpOption60Mode')));            
        }
    }

    var Option60Url = "";
    if (isOption60Wan()) {
        Option60Url = ('&z=' + Wan.domain + '.X_HW_ExtendDHCPOPTION60.1');
        Form.addParameter('z.Enable', Wan.Option60_enable);
        Form.addParameter('z.Type', '31');
        Form.addParameter('z.Account', Wan.Option60_User);
        Form.addParameter('z.Password', Wan.Option60_Pwd);
    }

    if(!DoubleFreqFlag)
    {
        var Url = 'complex.cgi?'
			+ 'y=' + Wan.domain
			+ IPv6PrefixUrl
			+ IPv6addressUrl
			+ DnsUrl
			+ DSLiteUrl
			+ Option60Url
			+ iptvInfoUrl
            + dhcpOption60Url
			+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';
    }
    else
    {       
        if(IsSurportPolicyRoute == 1)
		{
            var Url = 'complex.cgi?'
				+ 'y=' + Wan.domain
				+ IPv6PrefixUrl
				+ IPv6addressUrl
				+ DnsUrl
				+ DSLiteUrl
				+ Option60Url
				+ iptvInfoUrl
                + dhcpOption60Url
				+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html';  
        }
        else
        {
	    	var Url = 'complex.cgi?'
				+ 'y=' + Wan.domain
				+ IPv6PrefixUrl
				+ IPv6addressUrl
				+ DnsUrl
				+ DSLiteUrl
				+ Option60Url
				+ iptvInfoUrl
                + dhcpOption60Url
				+ '&RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html'; 
        }
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

	if (1 == CfgGuide)
	{
		Url += '&cfgguide=1';
	}
	
    stopWanStateTimer();
    Form.setAction(Url);
    Form.submit();
}

function OnApply()
{   
    if (EditFlag == "ADD")
    {
        OnAddApply();
        return;
    }
    var SessionVlanLimit  = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULT_SESSION_VLAN_LIMIT);%>";
    if (SessionVlanLimit == 1)
    {
        OnEditApply();
    }
    else
    {
        OnEditApplyOmitBrother();
    }
}

function OnDelete()
{
    var Control = getElById("WanConnectName_select");
	if ((Control.value == 'New') || (Control.value.indexOf("_NewConnect") >= 0)) {
		return;
	}
	
	if(!DoubleFreqFlag)
	{
		var Form = new webSubmitForm();
		Form.addParameter(GetWanInfoSelected().domain,'');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.setAction('del.cgi?RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html');
	}
	else
	{
		var LanWanBindInfo = Instance_PolicyRoute.GetLanWanBindInfo(domainTowanname(Wan.domain));

		var Form = new webSubmitForm();
		Form.addParameter(GetWanInfoSelected().domain,'');
		if(LanWanBindInfo != null)
		{

		}
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		
		if(GetWanInfoSelected().X_HW_VXLAN_Enable == 1)
		{
			for (var i = 0; i < VXLAN_VXLANConfig_Interface.length - 1; i++)  
			{
				if(VXLAN_VXLANConfig_Interface[i].WANInterface == GetWanInfoSelected().domain)
				{
				   AlertEx(Languages['VxlanIsUsed']);
				   return false;
				}
			}
		}

		if (1 == CfgGuide)
		{
			Form.setAction('del.cgi?RequestFile=html/bbsp/wan/wane8c.asp'+'&cfgguide=1');
		}
		else
		{
			Form.setAction('del.cgi?RequestFile=html/bbsp/wan/confirmwane8ccfginfo.html');
		}		
    	
	}
	
	setDisable("ButtonApply", "1");
    setDisable("ButtonDelete", "1"); 
	setDisable("ButtonNew", "1");
	setDisable("ButtonNewWan", "1");
    stopWanStateTimer();
	Form.submit();
	DisableRepeatSubmit();
}

function onfirstpage(val)
{
	if (-48 == guideIndex)
	{
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : '/smartguide.cgi?1=1&RequestFile=index.asp',
			data: getDataWithToken('Parainfo=0', true),
			success : function(data) {
				;
			}
		});
	}

	window.top.location.href="/index.asp";
}

function ClickPre(val)
{

	val.name = '/html/ssmp/modechange/modechange.asp';

	window.parent.onchangestep(val);
}

function ClickSkip(val)
{
	val.id = "guidecfgdone";
	window.parent.onchangestep(val);
}

function IsCnt() {
    if (isIPV6DemandWan == 1) {
        return true;
    }

    return false;
}

</script>

<form id="ConfigForm">
<table id="ConfigPanel"  width="100%" cellspacing="0" cellpadding="0"> 
<tr>
	<td class="table_left width_25p">连接名称</td> 
	<td class="table_right width_75p"> <select id="WanConnectName_select" class="Select" onchange="WanSelectControl()"> </select></td> 
</tr> 
<li   id="WanDomain"                 RealType="TextBox"            DescRef="VlanId"                    RemarkRef="WanVlanIdRemark"    ErrorMsgRef="Empty"    Require="TRUE"     BindField="domain"             InitValue="Empty"/>
<li   id="WanSwitch"                 RealType="CheckBox"           DescRef="EnableWanConnectione8c"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Enable"             InitValue="Empty"/>
<li   id="WanAddress_select"         RealType="DropDownList"       DescRef="EncapModee8c"                 RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="EncapMode"          InitValue="[{TextRef:'IPoE',Value:'IPoE'},{TextRef:'PPPoE',Value:'PPPoE'}]"/>
<script language="JavaScript" type="text/javascript">
    if (isPortInAttrName() && (!checkHon())) {
        document.write("\<li   id=\"WanServiceList_select\"     RealType=\"DropDownList\"       DescRef=\"WanServiceListe8c\"            RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"ServiceList\"        InitValue=\"[{TextRef:'TR069',Value:'TR069'},{TextRef:'INTERNET',Value:'INTERNET'},{TextRef:'TR069_INTERNET',Value:'TR069_INTERNET'},{TextRef:'VOIP',Value:'VOIP'},{TextRef:'TR069_VOIP',Value:'TR069_VOIP'},{TextRef:'VOIP_INTERNET',Value:'VOIP_INTERNET'},{TextRef:'TR069_VOIP_INTERNET',Value:'TR069_VOIP_INTERNET'},{TextRef:'IPTV',Value:'IPTV'},{TextRef:'OTHER',Value:'OTHER'}, {TextRef:'VOIP_IPTV',Value:'VOIP_IPTV'}, {TextRef:'TR069_IPTV',Value:'TR069_IPTV'},{TextRef:'TR069_VOIP_IPTV',Value:'TR069_VOIP_IPTV'}]\"\/\> ");
    } else if (checkHon()) {
        document.write("\<li   id=\"WanServiceList_select\"     RealType=\"DropDownList\"       DescRef=\"WanServiceListe8c\"            RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"ServiceList\"        InitValue=\"[{TextRef:'TR069',Value:'TR069'},{TextRef:'INTERNET',Value:'INTERNET'},{TextRef:'TR069_INTERNET',Value:'TR069_INTERNET'},{TextRef:'VOIP',Value:'VOIP'},{TextRef:'TR069_VOIP',Value:'TR069_VOIP'},{TextRef:'VOIP_INTERNET',Value:'VOIP_INTERNET'},{TextRef:'TR069_VOIP_INTERNET',Value:'TR069_VOIP_INTERNET'},{TextRef:'IPTV',Value:'IPTV'},{TextRef:'OTHER',Value:'OTHER'}, {TextRef:'VOIP_IPTV',Value:'VOIP_IPTV'}, {TextRef:'TR069_IPTV',Value:'TR069_IPTV'},{TextRef:'TR069_VOIP_IPTV',Value:'TR069_VOIP_IPTV'},{TextRef:'HON',Value:'HON'}]\"\/\> ");
    } else {
        document.write("\<li   id=\"WanServiceList_select\"     RealType=\"DropDownList\"       DescRef=\"WanServiceListe8c\"            RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"ServiceList\"        InitValue=\"[{TextRef:'TR069',Value:'TR069'},{TextRef:'INTERNET',Value:'INTERNET'},{TextRef:'TR069_INTERNET',Value:'TR069_INTERNET'},{TextRef:'VOIP',Value:'VOIP'},{TextRef:'TR069_VOIP',Value:'TR069_VOIP'},{TextRef:'VOIP_INTERNET',Value:'VOIP_INTERNET'},{TextRef:'TR069_VOIP_INTERNET',Value:'TR069_VOIP_INTERNET'},{TextRef:'IPTV',Value:'IPTV'},{TextRef:'OTHER',Value:'OTHER'}, {TextRef:'VOIP_IPTV',Value:'VOIP_IPTV'}, {TextRef:'TR069_IPTV',Value:'TR069_IPTV'},{TextRef:'TR069_VOIP_IPTV',Value:'TR069_VOIP_IPTV'},{TextRef:'SPECIAL_SERVICE_VR',Value:'SPECIAL_SERVICE_VR'}]\"\/\> ");
    }
</script>
<li   id="WanConnectMode_select"     RealType="DropDownList"       DescRef="WanModee8c"                   RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Mode"               InitValue="[{TextRef:'WanModeRoute',Value:'IP_Routed'},{TextRef:'WanModeBridge',Value:'IP_Bridged'}]"/>
<li   id="WanIP_Mode_select"         RealType="DropDownList"       DescRef="WanProtocolTypee8c"           RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="ProtocolType"       InitValue="[{TextRef:'IPv4',Value:'IPv4'},{TextRef:'IPv6',Value:'IPv6'},{TextRef:'IPv4IPv6e8c',Value:'IPv4/IPv6'}]"/>
<li   id="WanUserName_text"          RealType="TextBox"            DescRef="IPv4UserNamee8c"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="UserName"           InitValue="Empty"   MaxLength="64"/>
<li   id="WanPassword_text"          RealType="TextBox"            DescRef="IPv4Passworde8c"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Password"           InitValue="Empty"   MaxLength="64"/>
<li   id="Option60Enable"            RealType="CheckBox"           DescRef="EnableOption60Web"            RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="EnableOption60"     InitValue="Empty"/>
<li   id="IPoEUserName"              RealType="TextBox"            DescRef="IPv4UserNamee8c"              RemarkRef="Empty"   			 ErrorMsgRef="Empty"    Require="TRUE"     BindField="X_HW_IPoEName"      InitValue="Empty"   MaxLength="128"/>
<li   id="IPoEPassword"              RealType="TextBox"            DescRef="IPv4Passworde8c"              RemarkRef="Empty"   			 ErrorMsgRef="Empty"    Require="TRUE"     BindField="X_HW_IPoEPassword"  InitValue="Empty"   MaxLength="128"/>
<li   id="BridgeEnable"              RealType="CheckBox"           DescRef="BridgeEnable"                 RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="X_HW_BridgeEnable"  InitValue="Empty"/>
<li   id="WanMTU_text"               RealType="TextBox"            DescRef="IPv4MXUe8c"                   RemarkRef="IPv4MXUHELP"        ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4MXU"            InitValue="Empty"/>
<li   id="Vxlan_Enable"             RealType="CheckBox"           DescRef="EnableVxlanA8c"             RemarkRef="VxlanA8cRemark"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="EnableVxlan"      InitValue="Empty"/>
<li   id="WanVlan_Enable"            RealType="CheckBox"           DescRef="EnableVlane8c"                RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="EnableVlan"         InitValue="Empty"/>
<li   id="WanVlanID_text"            RealType="TextBox"            DescRef="VlanIde8c"                    RemarkRef="WanVlanIdRemark"    ErrorMsgRef="Empty"    Require="TRUE"     BindField="VlanId"             InitValue="Empty"/>

<li   id="PriorityPolicy"            RealType="RadioButtonList"    DescRef="PriorityPolicye8c"            RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="PriorityPolicy"     InitValue="[{TextRef:'Specified',Value:'Specified'},{TextRef:'CopyFromIPPrecedence',Value:'CopyFromIPPrecedence'}]"/>
<li   id="DefaultVlanPriority"       RealType="DropDownList"       DescRef="DefaultVlanPrioritye8c"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="DefaultPriority"    InitValue="[{TextRef:'Priority0',Value:'0'}, {TextRef:'Priority1',Value:'1'}, {TextRef:'Priority2',Value:'2'}, {TextRef:'Priority3',Value:'3'}, {TextRef:'Priority4',Value:'4'}, {TextRef:'Priority5',Value:'5'}, {TextRef:'Priority6',Value:'6'}, {TextRef:'Priority7',Value:'7'}]"/>

<li   id="Wan_802_1_P_select"        RealType="DropDownList"       DescRef="VlanPrioritye8c"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Priority"           InitValue="[{TextRef:'Priority0',Value:'0'}, {TextRef:'Priority1',Value:'1'}, {TextRef:'Priority2',Value:'2'}, {TextRef:'Priority3',Value:'3'}, {TextRef:'Priority4',Value:'4'}, {TextRef:'Priority5',Value:'5'}, {TextRef:'Priority6',Value:'6'}, {TextRef:'Priority7',Value:'7'}]"/>
<li   id="Speed_limit_up"            RealType="TextBox"            DescRef="Speed_limit_up"               RemarkRef="Speed_limit_ref"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="X_HW_SpeedLimit_UP"     InitValue="Empty"/>
<li   id="Speed_limit_down"          RealType="TextBox"            DescRef="Speed_limit_down"             RemarkRef="Speed_limit_ref"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="X_HW_SpeedLimit_DOWN"   InitValue="Empty"/>
<li   id="LcpEchoReqCheck"           RealType="CheckBox"           DescRef="LcpEchoReqChecke8c"           RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="LcpEchoReqCheck"    InitValue="Empty"/>
<li   id="Wan_Port_checkbox"         RealType="CheckBoxList"       DescRef="IPv4LanBindOptionse8c"           RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4BindLanList"    InitValue="[{TextRef:'LAN1e8c',Value:'LAN1'},{TextRef:'LAN2e8c',Value:'LAN2'},{TextRef:'LAN3e8c',Value:'LAN3'},{TextRef:'LAN4e8c',Value:'LAN4'},{TextRef:'LAN5e8c',Value:'LAN5'},{TextRef:'LAN6e8c',Value:'LAN6'},{TextRef:'LAN7e8c',Value:'LAN7'},{TextRef:'LAN8e8c',Value:'LAN8'}]"/>                                                                   
<li   id="Wan_SSID_checkbox"         RealType="CheckBoxList"       DescRef="IPv4SSIDBindOptions"           RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4BindSsidList"    InitValue="[{TextRef:'SSID1e8c',Value:'SSID1'},{TextRef:'SSID2',Value:'SSID2'},{TextRef:'SSID3',Value:'SSID3'},{TextRef:'SSID4',Value:'SSID4'},{TextRef:'SSID5',Value:'SSID5'},{TextRef:'SSID6',Value:'SSID6'},{TextRef:'SSID7',Value:'SSID7'},{TextRef:'SSID8',Value:'SSID8'}]"/>                                                                   
<li id="Wan_Pon_checkbox" RealType="CheckBoxList" DescRef="IPv4PONBindOptions" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="IPv4BindOnuList" InitValue="[{TextRef:'PONBindRemark',Value:'PON1'}]"/>
<li   id="DstIPForwardingList"       RealType="TextArea"           DescRef="DstIPForwardingCfge8c"        RemarkRef="DstIPForwardingHelp"  ErrorMsgRef="Empty"    Require="FALSE"    BindField="DstIPForwardingList" InitValue="Empty" MaxLength="8200"/>
<script language="JavaScript" type="text/javascript">
if(Is3TMode())
{
document.write("\<li   id=\"IPv4v6WanMVlanId\"               RealType=\"TextBox\"         DescRef=\"WanMVlanIde8c\"               RemarkRef=\"WanMVlanIdRemark\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"IPv4v6WanMVlanId\"              InitValue=\"Empty\"\/\> ");
}
if (isSupportPingReponse()) {
    document.write("\<li   id=\"PingResponseEnable\"               RealType=\"CheckBox\"         DescRef=\"PingResponseEnable\"               RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"X_HW_PingResponseEnable\"  ClickFuncApp=\"onclick=OnChangeUI\"  InitValue=\"Empty\"\/\> ");
    document.write("\<li   id=\"PingResponseWhiteList\"               RealType=\"TextArea\"         DescRef=\"PingResponseWhiteList\"               RemarkRef=\"DstIPForwardingHelp\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"X_HW_PingResponseWhiteList\"              InitValue=\"Empty\"\/\> ");
}
if (IsCnt()) {
    document.write('<li   id="IPv4DialMode"              RealType="DropDownList"       DescRef="IPv4DialMode"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4DialMode"       InitValue="[{TextRef:\'IPv4DialModeAlwaysOn\',Value:\'AlwaysOn\'},{TextRef:\'IPv4DialModeManual\',Value:\'Manual\'},{TextRef:\'IPv4DialModeOnDemand\',Value:\'OnDemand\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
    document.write('<li   id="IPv4DialIdleTime"          RealType="TextBox"            DescRef="IPv4IdleTime"              RemarkRef="IPv4IdleTimeRemark" ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv4DialIdleTime"   InitValue="Empty"/>');
    document.write('<li   id="IPv4IdleDisconnectMode"    RealType="DropDownList"       DescRef="IPv4IdleDisconnectMode"    RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4IdleDisconnectMode"   InitValue="[{TextRef:\'IPv4IdleDisconnectMode_note1\',Value:\'DetectBidirectionally\'},{TextRef:\'IPv4IdleDisconnectMode_note2\',Value:\'DetectUpstream\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
}
if (CurrentBin.toUpperCase() == 'E8C') {
    document.write('<li id="LanHostSwitch"  RealType="CheckBox" DescRef="EnableLanHoste8c" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="X_HW_BridgeHostEnable"  InitValue="Empty"/>');
}
if (CQCTFlag == 1) {
    document.write('<li id="IPTVAuthUserName"     RealType="TextBox"      DescRef="WanIptvUserNamee8c"     RemarkRef="Empty"     ErrorMsgRef="Empty"     Require="FALSE"    BindField=""      InitValue="Empty" MaxLength="132"/>');
    document.write('<li id="IPTVAuthPassWord"     RealType="TextBox"      DescRef="WanIptvPassWorde8c"     RemarkRef="Empty"     ErrorMsgRef="Empty"     Require="FALSE"    BindField=""      InitValue="Empty" MaxLength="132"/>');
    document.write('<li id="DhcpOption60Enable"   RealType="CheckBox"     DescRef="WanDhcpOption60Enablee8c"   RemarkRef="Empty" ErrorMsgRef="Empty"     Require="FALSE"    BindField=""      InitValue="Empty" ClickFuncApp="onchange=OnChangeUI"/>');
    document.write('<li id="DhcpOption60Mode"     RealType="TextBox"      DescRef="WanDhcpOption60Modee8c" RemarkRef="Empty"     ErrorMsgRef="Empty"     Require="FALSE"    BindField=""      InitValue="Empty" MaxLength="8"/>');
    document.write('<li id="DhcpOption60Type"     RealType="TextBox"      DescRef="WanDhcpOption60Typee8c" RemarkRef="Empty"     ErrorMsgRef="Empty"     Require="FALSE"    BindField=""      InitValue="Empty" MaxLength="8"/>');
}
</script>

<li   id="WanIPv4InfoBar"            RealType="HorizonBar"         DescRef="WanIPv4Info"               RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"              InitValue="Empty"/> 
<li   id="WanIPv4Address_select"     RealType="DropDownList"       DescRef="WanIpModee8c"                 RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4AddressMode"    InitValue="[{TextRef:'DHCP',Value:'DHCP'},{TextRef:'Static',Value:'Static'},{TextRef:'PPPoE',Value:'PPPoE'}]"/>
<li   id="IPv4NatSwitch"             RealType="CheckBox"           DescRef="EnableNate8c"                 RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4NATEnable"      InitValue="Empty"/>
<li   id="IPv4NatType"               RealType="DropDownList"       DescRef="NatTypee8c"                   RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="NatType"            InitValue="[{TextRef:'Port_Restricted_Cone_NAT',Value:'0'},{TextRef:'Full_Cone_NAT',Value:'1'}]"/>
<li   id="IPv4VendorId"              RealType="TextBox"            DescRef="IPv4VendorIde8c"              RemarkRef="IPv4VendorIdDes"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4VendorId"       InitValue="Empty"   MaxLength="64"/>
<li   id="IPv4ClientId"              RealType="TextBox"            DescRef="IPv4ClientIde8c"              RemarkRef="IPv4ClientIdDes"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4ClientId"       InitValue="Empty"   MaxLength="64"/>
<li   id="WanIPv4Address_text"       RealType="TextBox"            DescRef="IPv4IPAddresse8c"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv4IPAddress"      InitValue="Empty"/>
<li   id="WanSubmask_text"           RealType="TextBox"            DescRef="IPv4SubnetMaske8c"            RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv4SubnetMask"     InitValue="Empty"/>
<li   id="WanGateway_text"           RealType="TextBox"            DescRef="IPv4DefaultGatewaye8c"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField="IPv4Gateway"        InitValue="Empty"/>
<li   id="WanPri_DNS_text"           RealType="TextBox"            DescRef="IPv4PrimaryDNSe8c"      RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4PrimaryDNS"     InitValue="Empty"/>
<li   id="WanSec_DNS_text"           RealType="TextBox"            DescRef="IPv4SecondaryDNSe8c"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4SecondaryDNS"   InitValue="Empty"/>
<script language="JavaScript" type="text/javascript">
	if (!IsCnt()) {
		document.write('<li   id="IPv4DialMode"              RealType="DropDownList"       DescRef="IPv4DialMode"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4DialMode"       InitValue="[{TextRef:\'IPv4DialModeAlwaysOn\',Value:\'AlwaysOn\'},{TextRef:\'IPv4DialModeManual\',Value:\'Manual\'},{TextRef:\'IPv4DialModeOnDemand\',Value:\'OnDemand\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
		document.write('<li   id="IPv4DialIdleTime"          RealType="TextBox"            DescRef="IPv4IdleTime"              RemarkRef="IPv4IdleTimeRemark" ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv4DialIdleTime"   InitValue="Empty"/>');
		document.write('<li   id="IPv4IdleDisconnectMode"    RealType="DropDownList"       DescRef="IPv4IdleDisconnectMode"    RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4IdleDisconnectMode"   InitValue="[{TextRef:\'IPv4IdleDisconnectMode_note1\',Value:\'DetectBidirectionally\'},{TextRef:\'IPv4IdleDisconnectMode_note2\',Value:\'DetectUpstream\'}]" ClickFuncApp="onchange=OnChangeUI"/>');
	}
</script>
<li   id="IPv4WanMVlanId"            RealType="TextBox"            DescRef="WanMVlanIde8c"                RemarkRef="WanMVlanIdRemark"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv4WanMVlanId"     InitValue="Empty"/>
<li   id="LanDhcpSwitch"             RealType="CheckBox"           DescRef="EnableLanDhcpe8c"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="EnableLanDhcp"      InitValue="Empty"/>
<li   id="RDMode"                    RealType="RadioButtonList"    DescRef="Des6RDModee8c"                RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="RdMode"              InitValue="[{TextRef:'Off',Value:'Off'},{TextRef:'Auto',Value:'Dynamic'},{TextRef:'Static',Value:'Static'}]"/>
<li   id="RdPrefix"                  RealType="TextBox"            DescRef="Des6RDPrefixe8c"              RemarkRef="Empty"       ErrorMsgRef="Empty"    Require="TRUE"     BindField="RdPrefix"              InitValue="Empty"/>
<li   id="RdPrefixLen"               RealType="TextBox"            DescRef="Des6RDPrefixLenthe8c"         RemarkRef="RDPreLenthReMark"   ErrorMsgRef="Empty"    Require="TRUE"     BindField="RdPrefixLen"              InitValue="Empty"/>
<li   id="RdBRIPv4Address"           RealType="TextBox"            DescRef="Des6RDBrAddre8c"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="TRUE"     BindField="RdBRIPv4Address"              InitValue="Empty"/>
<li   id="RdIPv4MaskLen"             RealType="TextBox"            DescRef="Des6RDIpv4MaskLenthe8c"       RemarkRef="RDIpv4MskLnReMark"  ErrorMsgRef="Empty"    Require="TRUE"     BindField="RdIPv4MaskLen"              InitValue="Empty"/>

<li   id="WanOption60_Enable"     RealType="CheckBox"      DescRef="enableWanOption60"       RemarkRef="Empty"                           ErrorMsgRef="Empty"    Require="FALSE"    BindField="Option60_enable"    InitValue="Empty"/>
<li   id="WanOption60_User"       RealType="TextBox"       DescRef="option60User"            RemarkRef="option60UserRemark"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Option60_User"    InitValue="Empty" MaxLength="64"/>
<li   id="WanOption60_Password"   RealType="TextBox"       DescRef="option60Pwd"             RemarkRef="option60PwdRemark"               ErrorMsgRef="Empty"    Require="FALSE"    BindField="Option60_Pwd" InitValue="Empty" MaxLength="64"/>

<li   id="WanIPv6InfoBar"            RealType="HorizonBar"         DescRef="WanIPv6Info"               RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"              InitValue="Empty"/>
<li   id="WanDslite_checkbox"        RealType="CheckBox"           DescRef="DSLiteEnable"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="EnableDSLite"       InitValue="Empty"/>
<li   id="IPv6DSLite"                RealType="RadioButtonList"    DescRef="DSLitee8c"                    RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6DSLite"         InitValue="[{TextRef:'Off',Value:'Off'},{TextRef:'Auto',Value:'Dynamic'},{TextRef:'Static',Value:'Static'}]"/>
<li   id="IPv6AFTRName"              RealType="TextBox"            DescRef="AFTRNamee8c"                  RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6AFTRName"       InitValue="Empty"   MaxLength="255"/>
<script>
if ((CfgModeWord.toUpperCase() == "SCCT") || (CfgModeWord.toUpperCase() == "SCSCHOOL"))
{
    document.write("<li   id=\"WanIPv6Address_select\"     RealType=\"DropDownList\"       DescRef=\"WanIpModee8cv6\"            RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"IPv6AddressMode\"    InitValue=\"[{TextRef:'Autoe8c_scct',Value:'AutoConfigured'},{TextRef:'DHCPV6e8c',Value:'DHCPv6'},{TextRef:'Statice8c_scct',Value:'Static'},{TextRef:'None_scct',Value:'None'}]\"/>");
}
else
{
    document.write("<li   id=\"WanIPv6Address_select\"     RealType=\"DropDownList\"       DescRef=\"WanIpModee8cv6\"            RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"IPv6AddressMode\"    InitValue=\"[{TextRef:'Autoe8c',Value:'AutoConfigured'},{TextRef:'DHCPV6e8c',Value:'DHCPv6'},{TextRef:'Statice8c',Value:'Static'},{TextRef:'None',Value:'None'}]\"/>");
}
</script>
<li   id="WanPrefix_checkbox"        RealType="CheckBox"           DescRef="PrefixEnable"              RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="EnablePrefix"       InitValue="Empty"/>
<script>
if ((CfgModeWord.toUpperCase() == "SCCT") || (CfgModeWord.toUpperCase() == "SCSCHOOL"))
{
    document.write("<li   id=\"WanPrefix_select\"            RealType=\"DropDownList\"    DescRef=\"IPv6PrefixModee8c\"            RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"IPv6PrefixMode\"     InitValue=\"[{TextRef:'DHCPPD',Value:'PrefixDelegation'},{TextRef:'Statice8c_scct',Value:'Static'},{TextRef:'None_scct',Value:'None'}]\"/>");
}
else
{
    document.write("<li   id=\"WanPrefix_select\"            RealType=\"DropDownList\"    DescRef=\"IPv6PrefixModee8c\"            RemarkRef=\"Empty\"              ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"IPv6PrefixMode\"     InitValue=\"[{TextRef:'PrefixDelegation',Value:'PrefixDelegation'},{TextRef:'Static',Value:'Static'},{TextRef:'None',Value:'None'}]\"/>");
}
</script>
<li   id="WanIPv6Address_Pre_text"          RealType="TextBox"            DescRef="IPv6StaticPrefixe8c"          RemarkRef="PrefixRemark"       ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv6StaticPrefix"   InitValue="Empty"/>
<li   id="IPv6ReserveAddress"        RealType="TextBox"            DescRef="IPv6ReserveAddresse8c"        RemarkRef="IPv6ReserveAddressNote" ErrorMsgRef="Empty" Require="FALSE"   BindField="IPv6ReserveAddress" InitValue="Empty"/>
<li   id="IPv6AddressStuff"          RealType="TextBox"            DescRef="IPv6AddressStuffe8c"          RemarkRef="StuffRemark"        ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6AddressStuff"   InitValue=""TitleRef="AddressStuffTitle"/>
<li   id="WanIPv6Address_text"             RealType="TextBox"            DescRef="IPv6IPAddresse8c"             RemarkRef="IPv6AddressRemark"  ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv6IPAddress"      InitValue="Empty"/>
<li   id="IPv6AddrMaskLenE8c"           RealType="TextBox"            DescRef="IPv6AddrMaskLenE8c2"           RemarkRef="IPv6AddrMaskLenE8cRemark"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6AddrMaskLenE8c"    InitValue="Empty"/>
<li   id="WanIPv6_Gateway_text"               RealType="TextBox"            DescRef="IPv6GatewayE8c1"               RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6GatewayE8c"    InitValue="Empty"/>
<li   id="IPv6SubnetMask"            RealType="TextBox"            DescRef="IPv4SubnetMaske8c"            RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv6SubnetMask"     InitValue="Empty"/>
<li   id="IPv6DefaultGateway"        RealType="TextBox"            DescRef="IPv4DefaultGatewaye8c"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="TRUE"     BindField="IPv6Gateway"        InitValue="Empty"/>
<li   id="WanIPv6Pri_DNS_text"      RealType="TextBox"            DescRef="IPv6PrimaryDNSServer"      RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6PrimaryDNS"     InitValue="Empty"/>
<li   id="WanIPv6Sec_DNS_text"      RealType="TextBox"            DescRef="IPv6SecondaryDNSServer"    RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6SecondaryDNS"   InitValue="Empty"/>
<li   id="IPv6WanMVlanId"            RealType="TextBox"            DescRef="WanMVlanIde8c"                RemarkRef="WanMVlanIdRemark"    ErrorMsgRef="Empty"    Require="FALSE"    BindField="IPv6WanMVlanId"     InitValue="Empty"/>
<li   id="IPv6NPTSwitch"             RealType="CheckBox"           DescRef="EnableNPTv6e8c"                 RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="X_HW_NPTv6Enable"      InitValue="Empty"/>

<script>ParsePageControl(true);CleanServiceListVoip();</script>
<script>
function GetOperateValue(domain) {
    for (var i = 0; i < IPWanList.length - 1; i++) {
        if (domain == IPWanList[i].domain) {
            return IPWanList[i].X_HW_OperateDisable;
        }
    }

    for (var i = 0; i < PPPWanList.length - 1; i++) {
        if (domain == PPPWanList[i].domain) {
            return PPPWanList[i].X_HW_OperateDisable;
        }
    }
    return 0;
}

var isF5g;
function WanSelectControl()
{ 
	var Control = getElById("WanConnectName_select");
	ControlWanNewConnection();
    isF5g = false;
	if(Control.value == 'New')
	{
		
		setControl(-1);	
		setDisable("ButtonDelete", 0);
		if(Wan.length == 0)
		{
			setDisable("ButtonApply", 1);
		}
		if(!isSessionWanUser())
		{
			setDisable("ButtonNew", 1);
		}
		else
		{
			setDisable("ButtonApply", 0);
		}

        OtherWanProcess();

		option60WanProcess();

		return;
	}
	else
	{
		var SelectWan = GetSelectWan(Control.value);
		if(IsTr069WanOnlyRead() && (SelectWan.ServiceList.indexOf("TR069") >= 0))
		{
			setDisable("ButtonDelete", 1);
			if(!isSessionWanUser())
			{
				setDisable("ButtonNew", 1);
			}
		}
		else
		{
			setDisable("ButtonDelete", 0);
			setDisable("ButtonNew", 0);
		}

        if (GetOperateValue(SelectWan.domain) == 1) {
            isF5g = true;
        }
		
		setControl(-2);
	}
	if(IfVisual==1)
	{
	   pageDisable();
	   setDisable("ButtonNewWan",1);
	   setDisable("ButtonNew",1);
	   setDisable("ButtonApply",1);
       setDisable("ButtonDelete",1);
	   setDisable("WanConnectName_select",0);
	}

    if (isF5g) {
        DisableUserMode(1);
        setDisable("UserName", "1");
        setDisable("PasswordCol", "1");
        setDisable("ButtonApply", "1");
        setDisable("ButtonCancel", "1");
        setDisable("ButtonDelete", "1");
        setDisable("WanUserName_text", "1");
        setDisable("WanPassword_text", "1");
        setDisable("DstIPForwardingList", "1");
        setDisable("BridgeEnable", "1");
        if (!isSessionWanUser()) {
            setDisable("ButtonNew", "1");
        }
    }

    OtherWanProcess();

    option60WanProcess();
    ControlLanEnableHost(GetCurrentWan());
}
</script>
<script>
(function(){
	PromptInfo = function (id, des) {
		this.id = id;
		this.des = des;
	}
	
	var List = new Array();
	
	List[0] = new PromptInfo('LcpEchoReqCheck', 'LcpEchoReqCheckDes');
	List[1] = new PromptInfo('IPv6ReserveAddress', 'IPv6ReserveAddressDes');
	
	try{
		for ( var i in List){
			getElementById(List[i].id).setAttribute('title', Languages[List[i].des]);
		}
	}
	catch(e){

	}
})();
</script>
</table>

<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
		<td width="25%">
		</td>
        <td class="table_submit" >
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
			<script>
			if(!isSessionWanUser())
			{
				document.write('<input id="ButtonNewWan" class="ApplyButtoncss" type="button"  onclick="javascript:return ClickNewWan();"/>');
			}
			</script>
			<input id="ButtonNew" class="CancleButtonCss" type="button"  onclick="javascript:return ClickAddWan();"/>
            <input id="ButtonApply"  type="button" value="OK" onclick="javascript:return OnApply();" class="CancleButtonCss" />
			<input id="ButtonDelete"  type="button" value="Delete" onclick="javascript:return OnDelete();" class="CancleButtonCss" />
        </td>
    </tr>
</table>

<script>
ControlWanNewConnection();
setText('ButtonNew', Languages['New_Connection']);
setText("ButtonApply", "保存/应用");
setText("ButtonDelete","删除");
getElById('ButtonNew').title = "新建一条当前连接的兄弟WAN口";
if(!isSessionWanUser())
{
	setText('ButtonNewWan', Languages['Connection']);
getElById('ButtonNewWan').title = "新建一条WAN口";
}
else
{
	setText('ButtonNew', Languages['Connection']);
	getElById('ButtonNew').title = "新建一条WAN口";
}
</script>

<script>DisplayConfigPanel(0);</script>
</form>

<div align="center">
	<div id="btnguidewan" border="0" cellpadding="0" cellspacing="0" class="contentItem nofloat" style="display:none;">
		<div class="labelBox"></div>
		<div class="contenbox nofloat">
			<input type="button" id="firstpage"  style="display:none;" class="CancleButtonCss buttonwidth_100px" onClick="onfirstpage(this);"  BindText="bbsp_exit" />
			<input type="button" id="guideontauth" name="/html/ssmp/modechange/modechange.asp" class="CancleButtonCss buttonwidth_100px" onClick="ClickPre(this);" BindText="bbsp_pre"/>
			<input type="button" id="guidecfgdone" name="/html/ssmp/cfgguide/userguidecfgdone.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="window.parent.onchangestep(this);"  BindText="bbsp_next"/>
			<a id="guideskip" name="/html/ssmp/cfgguide/userguidecfgdone.asp" href="#" onClick="ClickSkip(this);">
				<span BindText="bbsp_skip"></span>
			</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	ParseBindTextByTagName(guideinternet_language, "span", 1);
	ParseBindTextByTagName(guideinternet_language, "input", 2);
</script>
<script language="javascript" src="../common/wanipv6state.asp"></script>
<div class="subWanListPolicyRoute subWanListIPVersion subIspWlan subDSLite subV6RDTunnel subRadioWan subWANAccessType">
    <script type="text/javascript">
        function RenderPage(event) {
            if (event.type == "evtWanListIPVersion") {
                displayProtocolType();
                setControl(g_lastSetControlIndex);
            }
            if (event.type == "evtWanListPolicyRoute" ||
                event.type == "evtIspWlan") {
                setControl(g_lastSetControlIndex);
            }

            if (event.type === 'evtDSLite') {
              ControlIPv6DSLite();
              ControlIPv6AFTRName();
              setControl(g_lastSetControlIndex);
            }

            if (isF5g) {
                DisableUserMode(1);
                setDisable("UserName", "1");
                setDisable("PasswordCol", "1");
                setDisable("ButtonApply", "1");
                setDisable("ButtonCancel", "1");
                setDisable("ButtonDelete", "1");
                setDisable("WanUserName_text", "1");
                setDisable("WanPassword_text", "1");
                setDisable("DstIPForwardingList", "1");
                setDisable("BridgeEnable", "1");
                if (!isSessionWanUser()) {
                    setDisable("ButtonNew", "1");
                }
            }
        }
        LazyLoad();
        $(document).ready(function(){
          if (window.parent.startWanStateTimer) {
            window.parent.startWanStateTimer();
          }
        }); 
    </script>
</div>
</body>
</html>
