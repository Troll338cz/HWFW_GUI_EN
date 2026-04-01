<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_list_info.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_list.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wandns.asp);%>"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(wan_check.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, vlan_ctc_language);%>"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>

	
<script language="JavaScript" type="text/javascript">
var SelectIndex = -1;
var TableName = "tabinfo";
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var UpportDetectFlag = '<%HW_WEB_GetFeatureSupport(FT_UPPORT_DETECT);%>';
var PonUpportConfig ='<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>';
var supportIPTVPort = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var isSupportOnulanCfg = "<%HW_WEB_GetFeatureSupport(FT_WEB_ONU_LAN_CFG);%>";
var BinWord ='<%HW_WEB_GetBinMode();%>';
var isDualWanUpCfg = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DUALWAN_UPSTREAM);%>';
var isDualWanUpProduct = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_DUALWAN_UPSTREAM);%>';
var backupWanEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BackupWAN.Enable);%>';
var backupWancurrentPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BackupWAN.Port);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var CfgFtWordArea = '<%GetConfigAreaInfo();%>';
var isUNICOMFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_UNICOM);%>';
function isGuangdongUNICOM(){
    return (CfgFtWordArea === '020' && isUNICOMFlag === '1');
}

function IsFreInSsidName()
{
	if(1 == IsPTVDFFlag)
	{
		return true;
	}
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
		b.innerHTML = vlan_ctc_language[b.getAttribute("BindText")];
	}
}

function IsLanPortType(BindInfo)
{
	if(BindInfo.domain.indexOf("LANEthernetInterfaceConfig") >= 0)
		return true;
	else
		return false;
}
	
function BindInfoClass(domain, Mode, Vlan, MultiCastVlanAct, MultiCastVlan)
{
	this.domain = domain;
	this.Mode = Mode;
	if(Mode == 1)
		this.Vlan = Vlan.replace(/;/g, ",");
	else
		this.Vlan = "";
	this.PortName = '';
	this.MultiCastVlanAct = MultiCastVlanAct;
    this.MultiCastVlan = MultiCastVlan;
}

function BindInfoClassByOnu(domain, Vlan)
{
    this.domain = domain;
    this.PortName = "";
    this.Mode = "";
    this.Vlan = Vlan;
}

function BindInfoClassByWlan(domain, Mode, Vlan, freq)
{
	this.domain = domain;
	this.Mode = Mode;
    this.freq = freq;
	if(Mode == 1)
		this.Vlan = Vlan.replace(/;/g, ",");
	else
		this.Vlan = "";
	this.PortName = '';
	this.MultiCastVlanAct = 0;
    this.MultiCastVlan = 1;
}

var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
var SSIDPath = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
var LANPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.MultiSrvPortList.PhyPortName);%>'.toUpperCase();
var CurrentLANPortList = new Array();
GetLANPortListInfo();

function GetLANPortListInfo()
{
	var tempLANPortValue = "";
	var tempLANPortList = LANPortInfo.split(",");
	for (var i = 0; i < tempLANPortList.length; i++)
	{		
		if (tempLANPortList[i].indexOf(LANPath.toUpperCase()) != -1)
		{
			tempLANPortValue = tempLANPortList[i].replace(LANPath.toUpperCase(), "LAN");
		}
		else
		{
			tempLANPortValue = tempLANPortList[i].replace(SSIDPath.toUpperCase(), "SSID");
		}

		var tempLANPortInfoList = tempLANPortValue.split(".");
		CurrentLANPortList[i] = tempLANPortInfoList[0];
	}
	
}

function setControlMultiSrv(Index)
{
	if (supportIPTVPort != 1)
	{
		return;
	}
	
	var tempID = LanArray[Index - 1].PortName;
	setDisable("PortId", 0);
	setDisable("ChooseDeviceType", 0);
	setDisable("UrlAddressControl", 0);
	setDisable("ChooseDnMultiAction", 0);
	setDisable("DnMultiVlan", 0);
	setDisplay("ButtonApply", 1);
	setDisplay("ButtonCancel", 1);
	for(var i = 0; i < CurrentLANPortList.length; i++)
	{
		if (tempID == CurrentLANPortList[i])
		{
			setDisable("PortId", 1);
			setDisable("ChooseDeviceType", 1);
			setDisable("UrlAddressControl", 1);
			setDisable("ChooseDnMultiAction", 1);
			setDisable("DnMultiVlan", 1);
			setDisplay("ButtonApply", 0);
			setDisplay("ButtonCancel", 0);
			break;
		}
	}
}

function GetIPTVWANInfo()
{
	if (supportIPTVPort != 1)
	{
		return 0;
	}

	var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
	if (IPTVUpPortInfo == "")
	{
		return 0;
	}
	
	var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
	var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
	var tempIPTVUpList = tempIPTVUpValue.split(".");
	return tempIPTVUpList[0].substr(3);
}

function GetMainUPportInfo() {
	var MainUPportInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_MainUpPort);%>'.toUpperCase();
	if (MainUPportInfo == "" || MainUPportInfo == "OPTICAL") {
		return 0;
	}
	
	var tempMainUPportList = MainUPportInfo.split(".");
	return tempMainUPportList[0].substr(3);
}

var LanArray = new Array();
var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
var __LanArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i},X_HW_Mode|X_HW_VLAN|X_HW_MultiCastVlanAct|X_HW_MultiCastVlan,BindInfoClass);%>;
var __onuLanArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANONUInterfaceConfig.{i},X_HW_VLAN,BindInfoClassByOnu);%>;
var onuLANInfo = __onuLanArray[0];
var __SSIDArrayRaw = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},X_HW_Mode|X_HW_VLAN|X_HW_RFBand,BindInfoClassByWlan);%>;
var __SSIDArray = __SSIDArrayRaw;
if (__SSIDArrayRaw.length > 0) 
{
    if(( 1 != DoubleFreqFlag ) && 1 == isShowHomeNetWork)
    {
        __SSIDArray = new Array();
        for (var i = 0 ; i< __SSIDArrayRaw.length-1; i++)
        {
            if (__SSIDArrayRaw[i].freq == '2.4GHz')
            {
                __SSIDArray.push(__SSIDArrayRaw[i]);
            }
        }
        __SSIDArray.push(null);
    }

}
else
{
	__SSIDArray = new Array(null);
}

var wlanstate = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>'; 

var EthNum = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Topo.X_HW_EthNum);%>';
EthNum = parseInt(EthNum);

var _LanPortNum = ((__LanArray.length - 1) > EthNum) ? EthNum : (__LanArray.length - 1);
	
for(var i = 0; i < _LanPortNum; i++)
{
    var index = __LanArray[i].domain.charAt(__LanArray[i].domain.length-1);
	__LanArray[i].PortName = 'LAN' + index;
	
	var IPTVPortID = GetIPTVWANInfo();
	var MAINPortID = GetMainUPportInfo();
	if (IPTVPortID == index || MAINPortID == index)
	{
		continue;
	}
	
	if ((UpportDetectFlag == 1) && UpUserPortID == index)
	{
		continue;
	}

    if ((CfgModeWord.toUpperCase() == "SDCCENTER") && (index == 2)) {
        continue;
    }

	LanArray.push(__LanArray[i]);
}

if (isSupportOnulanCfg == "1") {
    var onuLanMaxNum = 8;
    for (var i = 1; i <= onuLanMaxNum; i++) {
        var onuLANInfoTmp = new BindInfoClassByOnu(onuLANInfo.domain, onuLANInfo.Vlan);
        onuLANInfoTmp.PortName = "EdgeONT LAN" + i;
        onuLANInfoTmp.Mode = "BindWan";
        LanArray.push(onuLANInfoTmp);
    }
}

function filterWan(WanItem)
{
    if ((WanItem.Mode == 'IP_Routed')) {
        return false;
    }

    if ((isSupportOnulanCfg == 1) && (WanItem.EnableVlan == 0) && (WanItem.Mode.toUpperCase().indexOf("_BRIDGED") >= 0)) {
        return false;
    }

    return true;
}
var WanInfo = GetWanListByFilter(filterWan);

for(var j = 0, SL = GetSSIDFreList(); (TopoInfo.SSIDNum != 0) && (j < SL.length) ; j++)
{		
	for(var i = 0; i < __SSIDArray.length - 1; i++)
	{
		if(__SSIDArray[i].domain == SL[j].domain)
		{
			if(true != IsFreInSsidName())
			{
			    __SSIDArray[i].PortName = "SSID" + getWlanInstFromDomain(SL[j].domain);
			}
			else
			{
			    __SSIDArray[i].PortName = SL[j].name;
			}
			LanArray.push(__SSIDArray[i]);
			
			break;
		}
	}
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

function OnPageLoad()
{
    InitWanNameListControl1("ChooseWanName", filterWan);
    loadlanguage();
    if (curUserType === '1' && isGuangdongUNICOM()) {
		pageDisable();
        $("#ButtonApply").remove();
        $("#ButtonCancel").remove();
	}
    return true; 
}

function IsBindBindVlanValid(BindVlan)
{   
    var LanVlanWanVlanList = BindVlan.split(",");
    var LanVlan0;
    var WanVlan;
    var TempList;
    	
    for (var i = 0; i < LanVlanWanVlanList.length; i++)
    {
    	TempList = LanVlanWanVlanList[i].split("/");
    		
    	if (TempList.length != 2)
    	{
    		AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_vlanpainvalid1']);
    		return false;
    	}
    		
    	if ((!isNum(TempList[0])) || (!isNum(TempList[1])))
    	{
    		AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_vlanpainvalid1']);
    		return false;				
    	}
    		
    	if (!(parseInt(TempList[0],10) >= 1 && parseInt(TempList[0],10) <= 4094))
    	{
    		AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_invlan']+vlan_ctc_language['bbsp_vlanpainvalid1']);
    		return false;
    	}
    		
    	if (!(parseInt(TempList[1],10) >= 1 && parseInt(TempList[1],10) <= 4094))
    	{
    		AlertEx(vlan_ctc_language['bbsp_vlanpairs']+vlan_ctc_language['bbsp_wan_vlan']+vlan_ctc_language['bbsp_vlanpainvalid1']);
    		return false;
    	}
    }	

    return true;
}

function GetDnMultiActByNumber(MultiactionNumber)
{
    if (3 == MultiactionNumber)
    {
        return "specified";
    }
    else if (2 == MultiactionNumber)
    {
        return "transparenttransmission";
    }
    else if (1 == MultiactionNumber)
    {
        return "stripping";
    }
    else
    {
        return "unconcern";
    }
}

function GetDnMultiActNumberByStr(Multiaction)
{
    if ("specified" == Multiaction)
    {
        return 3;
    }
    else if ("transparenttransmission" == Multiaction)
    {
        return 2;
    }
    else if ("stripping" == Multiaction)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

function CheckParameter(BindVlan, Mode, Multiaction, Multivlan)
{
    var PortId = $("#PortId").text(); 

    if ((Mode == "vlanbinding") && (0 == BindVlan.length) )
    {
        return true;
    }

    if (Mode == "vlanbinding")
    {
        if (IsBindBindVlanValid(BindVlan) == false)
        {
            return false;
        }
    }

    if((PortId.indexOf("SSID") >= 0) && (1 != wlanstate))
    {
    	AlertEx(vlan_ctc_language['bbsp_vlan_wifi_invalid']);
    	return false;
    }
   
    return true;
}

function FillBindInfo(Form)
{
    var BindVlan = getElById("UrlAddressControl").value.replace(/;/g, ",");
    var PortMode = getElById("ChooseDeviceType").value;

    if (CheckParameter(BindVlan, PortMode) == false)
    {
         return false;
    }
	
    Form.addParameter('z.X_HW_Mode', "0");
    
    if(PortMode == "vlanbinding")
    {
         Form.addParameter('z.X_HW_Mode', "1");
    }
    else if (PortMode == "lanwanbinding")
    {
         Form.addParameter('z.X_HW_Mode', "0");
    }
    if (BinWord.toUpperCase() == 'A8C' && PortMode != "lanwanbinding") {
        Form.addParameter('z.X_HW_Mode', "1");
    }

    if (BindVlan == "")
    {
         Form.addParameter('z.X_HW_VLAN', BindVlan);
    }
        
    Form.addParameter('z.X_HW_VLAN', BindVlan);

    return true;
}

function FillMultiVlanInfo(Form)
{
    if(getElementById("ChooseDeviceType").value == "lanwanbinding")
    {
        Form.addParameter('z.X_HW_MultiCastVlanAct', 0);
        Form.addParameter('z.X_HW_MultiCastVlan', 1);

        return true;
    }

    var Multiaction = getElById("ChooseDnMultiAction").value;
    var Multivlan = getElById("DnMultiVlan").value;
    
    if (Multiaction == "specified")
    {
        if (false == CheckNumber(Multivlan, 1, 4094))
        {
            AlertEx(vlan_ctc_language['bbsp_multivlan_invalid']);
            return false;
        }
    }

    Form.addParameter('z.X_HW_MultiCastVlanAct', GetDnMultiActNumberByStr(Multiaction));
    if (Multiaction == "specified")
    {
        Form.addParameter('z.X_HW_MultiCastVlan', Multivlan);
    }
    else
    {
        Form.addParameter('z.X_HW_MultiCastVlan', 1);
    }

    return true;
}

function OnuLanSubmit(PortId)
{
    var onuLanIndex = PortId.charAt(PortId.length - 1);
    onuLanIndex = parseInt(onuLanIndex, 10);
    var curWanVlan = "";
    var setFlag = -1;
    var onuLanVlanInfo = "";

    for (var index = 0; index < WanInfo.length; index++) {
        if (WanInfo[index].domain == getSelectVal("ChooseWanName")) {
            curWanVlan = WanInfo[index].VlanId;
        }
    }

    var onuVlanList = onuLANInfo.Vlan.split(",");
    for (var i = 0; i < onuVlanList.length; i++) {
        var onuVlanPrefixList = onuVlanList[i].split("/");
        if (onuVlanPrefixList[0] == ((onuLanIndex * 10) + 10)) {
            setFlag = i;
            break;
        }
    }

    if (setFlag != -1) {
        var onuVlanPrefixListTmp = onuVlanList[setFlag].split("/");
        onuVlanList[setFlag] = onuVlanPrefixListTmp[0] + "/" + curWanVlan;
        for (var i = 0; i < onuVlanList.length; i++) {
            if ((i == setFlag) && (curWanVlan == "")) {
                continue;
            }
            onuLanVlanInfo = onuLanVlanInfo + onuVlanList[i] + ",";
        }
        onuLanVlanInfo = onuLanVlanInfo.substr(0, onuLanVlanInfo.length - 1);
    } else if (onuVlanList[0] == "") {
        if (curWanVlan != "") {
            onuLanVlanInfo = ((onuLanIndex * 10) + 10) + "/" + curWanVlan;
        }
    } else {
        if (curWanVlan != "") {
            onuLanVlanInfo = onuLANInfo.Vlan + "," + ((onuLanIndex * 10) + 10) + "/" + curWanVlan;
        } else {
            onuLanVlanInfo = onuLANInfo.Vlan;
        }
    }

    var Form = new webSubmitForm();
    var onuPath = "";

    for (var i = 1; i <= 9; i++) {
        onuPath += "y" + i + "=InternetGatewayDevice.LANDevice.1.LANONUInterfaceConfig." + i + "&";
        Form.addParameter('y' + i + '.X_HW_VLAN', onuLanVlanInfo);
    }

    for (var i = 10; i <= 16; i++) {
        onuPath += "z" + i + "=InternetGatewayDevice.LANDevice.1.LANONUInterfaceConfig." + i + "&";
        Form.addParameter('z' + i + '.X_HW_VLAN', onuLanVlanInfo);
    }

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?' + onuPath + 'RequestFile=html/bbsp/vlanctc/vlanctc.asp');
    Form.submit();
}

function OnApplyButtonClick()
{
    var Path = "";
    var PortId = $("#PortId").text(); 
    var i;
    if (BinWord.toUpperCase() == 'A8C') {
        // port vlan 绑定设置不允许重新设置
        for (var i = 0; i < LanArray.length; i++) {
            if (LanArray[i].PortName == PortId) {
                var lanmode = LanArray[i].Mode;
                if (lanmode == 2) {
                    AlertEx(vlan_ctc_language['bbsp_port_vlan_binded']);
                    return false;
                }
            }
        }
    }
    if(PortId.indexOf("LAN") >= 0)
    {
        Path = "z=InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig." + PortId.charAt(PortId.length - 1); 
    }
    else if(PortId.indexOf("SSID") >= 0)
    {
        Path = "z=InternetGatewayDevice.LANDevice.1.WLANConfiguration." + PortId.charAt(PortId.length - 1); 
    }

    if(PortId.indexOf("EdgeONT LAN") >= 0) {
        OnuLanSubmit(PortId);
    } else {
        var Form = new webSubmitForm();

        if (getElementById("ChooseDeviceType").value == "lanwanbinding") {
            getElById("UrlAddressControl").value = "";
        }

        if (FillBindInfo(Form) == false) {
            return false;
        }

        if ((PortId.indexOf("LAN") >= 0) && (FillMultiVlanInfo(Form) == false)) {
            return false;
        }

        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('set.cgi?' +Path+ '&RequestFile=html/bbsp/vlanctc/vlanctc.asp');   
        Form.submit();
    }

    return false;
}


function OnCancelButtonClick()
{
    document.getElementById("TableUrlInfo").style.display = "none";
    return false;
} 

function OnChooseDeviceType(Select)
{
    var Mode = getElementById("ChooseDeviceType").value;

    getElById("ChooseDnMultiActionRow").style.display = "none"; 
    getElById("DnMultiVlanRow").style.display = "none";  

    if (Mode == "lanwanbinding")
    {
        getElById("UrlAddressControlRow").style.display = "none";
    }
    else if (Mode == "vlanbinding")
    {
        getElById("UrlAddressControlRow").style.display = "";
        
        if (IsLanPortType(LanArray[SelectIndex -1]))
        {            
            getElById("ChooseDnMultiActionRow").style.display = ""; 
           
            if (getElById("ChooseDnMultiAction").value == "specified")
            {
                getElById("DnMultiVlanRow").style.display = "";    
            }
            else
            {
                getElById("DnMultiVlanRow").style.display = "none";         
            }  
        }
    }
}

function OnChooseDnMultiAction(Select)
{
   var Mode = getElementById("ChooseDnMultiAction").value;

   if (Mode == "specified")
   {
       getElById("DnMultiVlanRow").style.display = "";     
   }
   else
   {
       getElById("DnMultiVlanRow").style.display = "none"; 
   }
    
}

function FindOnuVlanId(portName)
{
    var portNum = portName.charAt(portName.length - 1);
    portNum = parseInt(portNum, 10);
    var onuVlanList = onuLANInfo.Vlan.split(",");
    for (var i = 0; i < onuVlanList.length; i++) {
        var onuVlanPrefixList = onuVlanList[i].split("/");
        if (onuVlanPrefixList[0] == ((portNum * 10) + 10)) {
            return onuVlanList[i];
        }
    }
    return "--";
}

function CreateRouteList()
{       
	var TableDataInfo = new Array();
	var ShowButtonFlag = false;
    var Listlen = 0;
    var onuVlanId = "";

      for (var i = 1; i <= LanArray.length; i++)
      {  
          if ((isDualWanUpCfg === '1') && (isDualWanUpProduct === '1') && (backupWanEnable === '1')) {
              if (LanArray[i - 1].domain === backupWancurrentPort) {
                continue;
              }
          }

          var modestr = "";
          if (BinWord.toUpperCase() == 'A8C') {
              modestr = vlan_ctc_language['bbsp_portbind'];
          }
          if (LanArray[i-1].Mode == 0)
          {
              modestr = vlan_ctc_language['bbsp_portbind'];
          }
          else if (LanArray[i-1].Mode == 1)
          {
              modestr = vlan_ctc_language['bbsp_vlanbind'];
          } else if (LanArray[i-1].Mode == "BindWan") {
              modestr = vlan_ctc_language['bbsp_wanbind'];
          }
		  
		  TableDataInfo[Listlen] = new BindInfoClass();
		  if( i == stbport)
		  {
			 TableDataInfo[Listlen].PortName = vlan_ctc_language['bbsp_stb'];
		  }
		  else
		  {
			 TableDataInfo[Listlen].PortName = LanArray[i-1].PortName;
		  }
		  TableDataInfo[Listlen].X_HW_Mode = modestr;
          
          if( (LanArray[i-1].Vlan == "") || (LanArray[i-1].Mode == 0))
          {
			  TableDataInfo[Listlen].X_HW_VLAN = '--';
          } else if (LanArray[i-1].Mode == "BindWan") {
              TableDataInfo[Listlen].X_HW_VLAN = FindOnuVlanId(LanArray[i-1].PortName);
          } else {
			  TableDataInfo[Listlen].X_HW_VLAN = LanArray[i-1].Vlan;
          }
          Listlen++;
      }  
	 TableDataInfo.push(null);
	 HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, VlanctcConfiglistInfo, vlan_ctc_language, null);
}
</script>
<title>LAN VLAN Bind Configuration</title>

</head>
<body  class="mainbody" onload="OnPageLoad();">

<div id="PromptPanel">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("vlanctctitle", GetDescFormArrayById(vlan_ctc_language, "bbsp_mune"), GetDescFormArrayById(vlan_ctc_language, "bbsp_vlan_ctc_title"), false);
    if (BinWord.toUpperCase() == 'A8C') {
        HWCreatePageHeadInfo("vlanctctitle", GetDescFormArrayById(vlan_ctc_language, "bbsp_portmode"), GetDescFormArrayById(vlan_ctc_language, "bbsp_vlan_ctc_title"), false);
    }
</script> 
<div class="title_spread"></div>
</div>

<script language="JavaScript" type="text/javascript">
	var VlanctcConfiglistInfo = new Array(new stTableTileInfo("bbsp_port","align_center","PortName"),
								new stTableTileInfo("bbsp_portmode","align_center","X_HW_Mode"),
								new stTableTileInfo("bbsp_vlanpairs","align_center","X_HW_VLAN"),null);	
	var ColumnNum = 3;
	CreateRouteList();
</script>

<script language="JavaScript" type="text/javascript">

function setPortModeDisable(index,str)
{
	var landomain = str.domain;
	if (UpportDetectFlag ==1)
	{
		var id = landomain.split(".")[4];
		if (IsLanPortType(LanArray[index -1]) && IsL3Mode(id) == "0")
		{
			setDisable("ChooseDeviceType", 1);
		}
		else
		{
			setDisable("ChooseDeviceType", 0);
		}		
	}
}

function ModifyInstance(index)
{
    var lanmode = LanArray[index -1].Mode;
    var vlanpair = LanArray[index -1].Vlan;
    var DnMultiVlanAct = LanArray[index -1].MultiCastVlanAct;
    var DnMultiVlan = LanArray[index -1].MultiCastVlan;

    document.getElementById("TableUrlInfo").style.display = "";
    getElById("OnuPortModeRow").style.display = "none";
    getElById("ChooseWanNameRow").style.display = "none";
    getElById("ChooseDeviceTypeRow").style.display = "";
    getElById("UrlAddressControlRow").style.display = "";
    getElById("ChooseDnMultiActionRow").style.display = "";
    getElById("DnMultiVlanRow").style.display = "";
    getElById("UrlAddressControl").value = vlanpair;
    
	if (IsLanPortType(LanArray[index -1]) && IsL3Mode(index) == "0")
	{
		setDisable("ChooseDeviceType", 1);
	}
	else
	{
		setDisable("ChooseDeviceType", 0);
	}

    getElById("ChooseDnMultiAction").value = GetDnMultiActByNumber(DnMultiVlanAct);
    getElById("DnMultiVlan").value = DnMultiVlan;
	
    if (lanmode == 0 || (BinWord.toUpperCase() == 'A8C' && lanmode != 1))
    {
        getElById("ChooseDeviceType").value = "lanwanbinding";
        getElById("UrlAddressControlRow").style.display = "none";     
        getElById("ChooseDnMultiActionRow").style.display = "none"; 
        getElById("DnMultiVlanRow").style.display = "none";  
    }
    else if (lanmode == 1)
    {
        getElById("ChooseDeviceType").value = "vlanbinding"; 
        getElById("UrlAddressControlRow").style.display = "";
 
        if (IsLanPortType(LanArray[index -1]))
        {
            getElById("ChooseDnMultiActionRow").style.display = "";

            if (DnMultiVlanAct == 3)
            {
                getElById("DnMultiVlanRow").style.display = "";    
            }
            else
            {
                getElById("DnMultiVlanRow").style.display = "none";         
            }
        }
        else
        {
            getElById("ChooseDnMultiActionRow").style.display = "none"; 
            getElById("DnMultiVlanRow").style.display = "none";
        }
    }
	setPortModeDisable(index,LanArray[index -1]);
	setControlMultiSrv(index);
}

function ModifyOnuInstance(index)
{
    document.getElementById("TableUrlInfo").style.display = "";
    getElById("OnuPortModeRow").style.display = "";
    getElById("ChooseWanNameRow").style.display = "";
    getElById("ChooseDeviceTypeRow").style.display = "none";
    getElById("UrlAddressControlRow").style.display = "none";
    getElById("ChooseDnMultiActionRow").style.display = "none";
    getElById("DnMultiVlanRow").style.display = "none";

    $("#OnuPortMode").text(vlan_ctc_language['bbsp_wanbind']);

    var onuVlanId = FindOnuVlanId(LanArray[index - 1].PortName);
    var onuVlanList = onuVlanId.split("/");
    for (var i = 0; i < WanInfo.length; i++) {
        if (WanInfo[i].VlanId == onuVlanList[1]) {
            setSelect('ChooseWanName', WanInfo[i].domain);
            return;
        }
    }

    setSelect('ChooseWanName', "");
}

function setControl(index) 
{ 
	SelectIndex = index + 1;
	if (index < -1)
	{
		return;
	}
	
	if( SelectIndex == stbport)
	{
		$("#PortId").text(vlan_ctc_language['bbsp_stb']);
	}
	else
	{
		$("#PortId").text(LanArray[SelectIndex - 1].PortName);
	}

    if (LanArray[SelectIndex - 1].Mode == "BindWan") {
        return ModifyOnuInstance(SelectIndex);
    } else {
        return ModifyInstance(SelectIndex);
    }
}

</script>

<form id="TableUrlInfo" style="display:none">
  <div class="list_table_spread"></div>
  <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
  		<li id="PortId" RealType="HtmlText" DescRef="bbsp_portmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PortName"  InitValue="Empty" />
		<li   id="ChooseDeviceType"       RealType="DropDownList"     DescRef="bbsp_portmodemh"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.X_HW_Mode" 
        InitValue="[{TextRef:'bbsp_vlanbind',Value:'vlanbinding'},{TextRef:'bbsp_portbind',Value:'lanwanbinding'}]" ClickFuncApp="onchange=OnChooseDeviceType"/>
        <li id="OnuPortMode" RealType="HtmlText" DescRef="bbsp_portmodemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
        <li id="ChooseWanName" RealType="DropDownList" DescRef="bbsp_vlanpairsmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" Elementclass="width_260px restrict_dir_ltr" InitValue="Empty" MaxLength="30"/>
		<li   id="UrlAddressControl"           RealType="TextBox"          DescRef="bbsp_vlanpairsmh"         RemarkRef="bbsp_note"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.X_HW_VLAN"  Elementclass="width_300px"  Maxlength="255" InitValue="Empty"/>
		<li   id="ChooseDnMultiAction"       RealType="DropDownList"     DescRef="bbsp_multiaction"     RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.X_HW_MultiCastVlanAct" 
		InitValue="[{TextRef:'bbsp_dnmulti_unconcern',Value:'unconcern'},{TextRef:'bbsp_dnmulti_stripping',Value:'stripping'},{TextRef:'bbsp_dnmulti_transparent',Value:'transparenttransmission'},{TextRef:'bbsp_dnmulti_specified',Value:'specified'}]" ClickFuncApp="onchange=OnChooseDnMultiAction"/>                                                                   
        <li   id="DnMultiVlan"           RealType="TextBox"          DescRef="bbsp_multivlan"         RemarkRef="bbsp_multivlan_range"     ErrorMsgRef="Empty"    Require="TRUE"     BindField="x.X_HW_MultiCastVlan"  Elementclass="width_300px"  Maxlength="255" InitValue="Empty"/>
		<script language="JavaScript" type="text/javascript">
			var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			var VlanctcConfigFormList = new Array();
			VlanctcConfigFormList = HWGetLiIdListByForm("TableUrlInfo", null);
			var formid_hide_id = null;
			HWParsePageControlByID("TableUrlInfo", TableClass, vlan_ctc_language, formid_hide_id);
		</script>
  </table>
  
  <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per25'>
        </td>
        <td class="table_submit pad_left5p">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonApply"  type="button" onclick="javascript:return OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(vlan_ctc_language['bbsp_app']);</script></button>
            <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(vlan_ctc_language['bbsp_cancel']);</script></button>
        </td>
    </tr>
  </table>
</form>
</body>
</html>

