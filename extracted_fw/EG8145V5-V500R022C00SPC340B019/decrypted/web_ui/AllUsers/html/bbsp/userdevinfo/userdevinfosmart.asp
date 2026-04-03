<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>User Device Information</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../common/lanuserinfo.asp"></script>
<script language="JavaScript" type="text/javascript">
var token = '<%HW_WEB_GetToken();%>';
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var MAX_HOST_TYPE=16;
var para = '';
var devtype = '';
var ConnectDevIp = '<%HW_WEB_GetCurDeviceIP();%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsVDFPTAPFlag='<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_VDFPTAP);%>';
var IsAPFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>'
var STBPort = '<%HW_WEB_GetSTBPort();%>';
var APChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var TDEMode = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDE);%>';
var IsDevTypeFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_USER_DEVTYPE);%>';
var isGlobe = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GLOBE);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var IsBridgeMode = '<%HW_WEB_GetApMode();%>';
var APAutoUPPortFlag = '<%HW_WEB_GetFeatureSupport(FT_AP_WEB_SELECT_UPPORT);%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var num = 0;

var firstpage = 1;
var page = firstpage;
var isFTTRMAIN = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';

if (["TOTALPLAY", "TOTALPLAY2"].indexOf(curCfgModeWord.toUpperCase()) >= 0) {
    var ispStaInfo = '<%WEB_GetIspStaInfo();%>';
    var ispStaInfoJson = JSON.parse(ispStaInfo);
}

function IsFreInSsidName()
{
	if(1 == IsPTVDFFlag || 1 == IsVDFPTAPFlag)
	{
		return true;
	}
}

if (window.location.href.indexOf("type") != -1)
{
	para = window.location.href.split("type")[1]; 
	devtype = para.split("=")[1];
}

var DHCPLeaseTimes = new Array();
var UserDevices = new Array();
var WifiDevNum = 0;
var EthDevNum = 0;
var EthOnlineNum = 0;
var WifiDev = new Array();
var EthDev = new Array();
var wifiOnlineDevNum2g = 0;
var wifiOnlineDevNum5g = 0;
var wifiDev2g = new Array();
var wifiDev5g = new Array();
var wifiDevMap = {};
var AllMacFilter;
var IsSupportWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';

var SingtelMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_SINGTEL);%>';
var IPProtVerMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_IPProtocolVersion.Mode);%>';

function StWlan(domain,name) 
{
    this.domain = domain;
    this.name = name;
}

var wlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, Name, StWlan);%>;
for (var i = 0; i < wlanArr.length - 1; i++) {
    var freg = '2g';
    if (getWlanPortNumber(wlanArr[i].name) >= ssidStart5G) {
        freg = '5g';
    }
    wifiDevMap['SSID' + getInstIdByDomain(wlanArr[i].domain)] = freg;
}

if (typeof top.wifiDevFreq == 'undefined') {
    top.wifiDevFreq = '2G';
}

function stHomeNetName(domain,MACAddress,Name)
{
   this.domain = domain;
   this.MACAddress = MACAddress;
   this.Name = Name;
}

var HomeNetNameList;
var enableMacFilter = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.MacFilterRight);%>';
var MacFilterPolicy = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.MacFilterPolicy);%>';
function stMacFilter(domain,MACAddress)
{
   this.domain = domain;
   this.MACAddress = MACAddress;
}
var MacFilter = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.MacFilter.{i},SourceMACAddress,stMacFilter);%>;

var enableWlanMacFilter = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.WlanMacFilterRight);%>';
var WlanMacFilterPolicy = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.WlanMacFilterPolicy);%>';
function stWlanMacFilter(domain,SSIDName,MACAddress)
{
   this.domain = domain;   
   this.SSIDName = SSIDName;
   this.MACAddress = MACAddress; 
}

var WlanMacFilterSrc = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.WLANMacFilter.{i},SSIDName|SourceMACAddress,stWlanMacFilter);%>;
var WlanMacFilter = new Array();
for (var i = 0; i < WlanMacFilterSrc.length-1; i++)
{
	var SSIDIndex = WlanMacFilterSrc[i].SSIDName.charAt(WlanMacFilterSrc[i].SSIDName.length - 1);
	if(IsVisibleSSID('SSID' + SSIDIndex) == true)
		WlanMacFilter.push(WlanMacFilterSrc[i]);
}
WlanMacFilter.push(null);

function USERDevice(Domain,IpAddr,MacAddr,Port,IpType,DevType,DevStatus,PortType,Time,HostName)
{
	this.Domain 	= Domain;
	this.IpAddr	    = IpAddr;
	this.MacAddr	= MacAddr;
	this.Port 		= Port;
	this.PortType	= PortType;
	
	this.DevStatus 	= DevStatus;
	this.IpType		= IpType;
	if(IpType=="Static")
	{
	  this.DevType="--";
	}
	else
	{
		if(DevType=="")
		{
			this.DevType	= "--";	
		}
		else
		{
			this.DevType	= DevType;		
		}	
	}
	this.Time	    = Time;
	
	if(HostName=="")
	{
		this.HostName	= "--";
	}
	else
	{
	   this.HostName	= HostName;
	}
}

function compare(property) {
    return function (a, b) {
        var value1 = a[property].toUpperCase();
        var value2 = b[property].toUpperCase();
        if ((value1 == "ONLINE") && (value2 != "ONLINE")) {
            return -1;
        } else {
            return 1;
        }
    }
}

function GetDevInfo()
{
	WifiDev = new Array();
	EthDev = new Array();
	EthDevNum = 0;
	WifiDevNum = 0;
	EthOnlineNum = 0;

    wifiDev2g = new Array();
    wifiDev5g = new Array();
    wifiOnlineDevNum2g = 0;
    wifiOnlineDevNum5g = 0;
	
	for (var i=0; UserDevices.length > 0 && i < UserDevices.length-1; i++)
	{
		if(UserDevices[i].PortType.toUpperCase() == "ETH" || UserDevices[i].PortType.toUpperCase() == "ONU")
		{
			EthDev[EthDevNum] = new USERDevice("","","","","","","","","","");
			EthDev[EthDevNum]	= UserDevices[i];
			EthDevNum++;
			if (UserDevices[i].DevStatus.toUpperCase() == "ONLINE") {
				EthOnlineNum++;
			}

		}
		else if(UserDevices[i].PortType.toUpperCase() == "WIFI")
		{
			WifiDev[WifiDevNum] = new USERDevice("","","","","","","","","","");
			WifiDev[WifiDevNum]	= UserDevices[i];
			WifiDevNum++;

            if (curCfgModeWord.toUpperCase() == "TURKCELL2") {
                if (wifiDevMap[UserDevices[i].Port] == '5g') {
                    wifiDev5g.push(UserDevices[i]);
                    if (UserDevices[i].DevStatus.toUpperCase() == "ONLINE") {
                        wifiOnlineDevNum5g++;
                    }
                } else {
                    wifiDev2g.push(UserDevices[i]);
                    if (UserDevices[i].DevStatus.toUpperCase() == "ONLINE") {
                        wifiOnlineDevNum2g++;
                    }
                }
            }
		}
	}

    if ((curCfgModeWord.toUpperCase() == "TURKCELL2") && (devtype.toUpperCase() == "WIFIDEV")) {
        wifiDev2g.sort(compare('DevStatus'));
        wifiDev5g.sort(compare('DevStatus'));
	}
}

function GetMacFilter(DevType)
{
	var url = '';
	if ('LINEDEV' == DevType.toUpperCase())
	{
		url = "/html/bbsp/userdevinfo/getmacfilterinfo.asp";
	}
	else if ('WIFIDEV' == DevType.toUpperCase())
	{
		url = "/html/bbsp/userdevinfo/getwlanmacfilterinfo.asp";
	}
	
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : '&x.X_HW_Token='+ token,
		url : url,
		success : function(data) {
		AllMacFilter = dealDataWithFun(data);
		}
	});

}

function isNotDBAA1SuperUser() {
    var curUserType = '<%HW_WEB_GetUserType();%>';
    if ((DBAA1 == "1") && (curUserType != "2")) {
        return true;
    }
    return false;
}

function ClickRefresh(DevType)
{
	if (APChangeMode > 1 || GhnDevFlag ==1)
	{
		window.parent.ShowAPDeviceNum();
	}
	else
	{
		window.parent.SetDeviceNum();		
	}	

	window.location.reload();
}

function EditDeviceName(id)
{
	var index = id.split('_')[1];	
	setDisplay('divInputDevName_'+index,1);
	setDisplay('divLabelDevName_'+index,0);
}

function checkDevName(DevName)
{
	if((DevName!='')&&(isValidAscii(DevName)!= '')) 
	{
		AlertEx(userdevinfo_mainpage_language['bbsp_devname'] + Languages['Hasvalidch'] + isValidAscii(DevName) + '".');          
		return false;
	}
	return true;
}

function FindNameItemByDevInfo(UserDevinfoItem)
{
	for (var n=0; HomeNetNameList.length > 0 && n < HomeNetNameList.length; n++)
	{	
		if(HomeNetNameList[n].MACAddress.toUpperCase() == UserDevinfoItem.MacAddr.toUpperCase())
		{
			return n;
		}
	}
	return -1;
}

function SubmitDevName(val)
{
	var index = val.id.split('_')[1];	
	var NewDevName = getValue('inputDevName_'+index);
	if (false == checkDevName(NewDevName))
	{
		return;
	}
	var Name_i = FindNameItemByDevInfo(UserDevices[index]);
	
	var para = HomeNetNameList[Name_i].MACAddress.split(":");
	var ConfigParaList = new Array(new stSpecParaArray("x.MACAddress", para[0] + para[1] + para[2] + para[3] + para[4] + para[5], 0),
									  new stSpecParaArray("x.Name",NewDevName, 0));
										  
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
	Parameter.SpecParaPair = ConfigParaList;

	var ConfigUrl = "setajax.cgi?x="+HomeNetNameList[Name_i].domain+ '&RequestFile=/html/bbsp/userdevinfo/userdevinfosmart.asp';							  
	HWSetAction("ajax", ConfigUrl, Parameter, token);
	location.replace('/html/bbsp/userdevinfo/userdevinfosmart.asp?devtype='+devtype);
}

function CancleDevName(val)
{
	var index = val.id.split('_')[1];
	setDisplay('divInputDevName_'+index,0);
	setText('inputDevName_'+index, UserDevices[index].HostName);
	setDisplay('divLabelDevName_'+index,1);
}

function SetDivValue(Id, Value)
{
    try
    {	
        var Div = document.getElementById(Id);
        Div.innerHTML = Value;
    }
    catch(ex)
    {

    }
}
function IsFindMacList(macAddress,macfilter,macfilterpolicy)
{
	var i;
	var index = -1;
	if ('0' != macfilterpolicy)
	{
		return index;
	}
	for(i=0;(macfilter != null && i < macfilter.length - 1);i++) 
	{
		if (macfilter[i].MACAddress == macAddress)
		{
			index = i;
			break;
		}
	}
	return index;
}
function USERDeviceV6(Domain,IP,Scope,HostName,DevType,MacAddr,DevStatus,PortType,PortID)
{
	this.Domain 	= Domain;
	this.IP	        = IP;
	this.Scope	    = Scope;
	this.HostName	    = HostName;
	this.DevType	    = DevType;
	this.MacAddr	    = MacAddr;
	this.DevStatus	    = DevStatus;
	this.PortType	    = PortType;
	this.PortID	    = PortID;
}
var UserDevIpv6Info = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i}.IPv6Address.{i}, IP|Scope|HostName|DevType|MacAddr|DevStatus|PortType|PortID, USERDeviceV6);%>;

function UserDevFindIpv6(domain)
{
	var ipaddr_gua = "";

	var usrdevid = domain.split(".")[4];

	for(var i = 0; i < UserDevIpv6Info.length - 1; i++)
	{
		var usrdev6id = UserDevIpv6Info[i].Domain.split(".")[4];

		if ((usrdevid == usrdev6id) && (UserDevIpv6Info[i].Scope == "GUA") && (UserDevIpv6Info[i].DevStatus.toUpperCase() == "ONLINE")) {
			ipaddr_gua = UserDevIpv6Info[i].IP;
			break;
		}
	}

	return ipaddr_gua;
}

function setDeviceInfo(Data, macfilter, macfilterpolicy)
{
	for(var i = 0; i < Data.length; i++)
	{
        if (Data[i].PortType.toUpperCase().indexOf("WIFI") >= 0) {
            var ssidindex = Data[i].Port;
            ssidindex = ssidindex.charAt(ssidindex.length-1);
            if (isSsidForIsp(ssidindex) == 1) {
                continue;
            }
        }

        if (["TOTALPLAY", "TOTALPLAY2"].indexOf(curCfgModeWord.toUpperCase()) >= 0) {
            var skipFlag = 0;
            for (var j = 0; j < ispStaInfoJson.length; j++) {
                if (Data[i].MacAddr == ispStaInfoJson[j].ispStaMac.toLowerCase()) {
                    skipFlag = 1;
                    break;
                }
            }
            if (skipFlag == 1) {
                continue;
            }
        }

		var hostname = '';
		var hostport = '';
		if(('--' == Data[i].HostName) && ("1" == GetCfgMode().TELMEX))
		{
			hostname = Data[i].MacAddr;
		}
		else
		{
			hostname = Data[i].HostName.substr(0,MAX_HOST_TYPE);
		}
		
		if( "LAN0" == Data[i].Port.toUpperCase() || "SSID0" == Data[i].Port.toUpperCase())
		{
			hostport = "--";
		} 
		else if (Data[i].PortType == "ONU") {
			hostport = "PON1";
			if (curCfgModeWord.toUpperCase() == "EBGFTTR") {
				hostport = "PON";
			}
 		}
		else
		{
			hostport = Data[i].Port.toUpperCase();
			if(true == IsFreInSsidName())
			{
				var SL = GetSSIDList();
				var SLFre = GetSSIDFreList();
				for(var j = 0; j < SL.length; j++)
				{
					if(SL[j].name == Data[i].Port.toUpperCase())
					{
						hostport = SLFre[j].name;
						break;
					}
				}
			}
			if(STBPort > 0)
			{
				var LanPort = "LAN" + STBPort;
				if(Data[i].Port.toUpperCase() == LanPort)
				{
					hostport = userdevinfo_language['bbsp_lanstb'];
				}
			}
		}

        num = i;
		var UserDevAlias = Data[num].UserDevAlias;
		if (UserDevAlias != "--") {
			document.getElementById('labelDevName_' + i).title = UserDevAlias;
			SetDivValue('divDevName_'+i, htmlencode(GetStringContent(UserDevAlias, 16)));
		} else {
			document.getElementById('labelDevName_' + i).title = hostname;
			SetDivValue('divDevName_'+i, htmlencode(GetStringContent(hostname, 16)));
		}
		SetDivValue('DivDevPort_'+i, hostport);
		var IPandMAc;
        if ((IPProtVerMode == '3') || (IPProtVerMode == '2')) {
            IPandMAc = Data[i].MacAddr+'<br/>'+Data[i].IpAddr+'<br/>'+UserDevFindIpv6(Data[i].Domain); 
        } else {
            IPandMAc = Data[i].MacAddr+'<br/>'+Data[i].IpAddr;
        }

		SetDivValue('DivIpandMac_'+i, IPandMAc);
		SetDivValue('DivDevStatus_'+i, userdevinfo_language[Data[i].DevStatus]);
		var unit_h = (parseInt(Data[i].Time.split(":")[0],10) > 1) ? userdevinfo_mainpage_language['bbsp_hours'] : userdevinfo_mainpage_language['bbsp_hour'];
		var unit_m = (parseInt(Data[i].Time.split(":")[1],10) > 1) ? userdevinfo_mainpage_language['bbsp_mins'] : userdevinfo_mainpage_language['bbsp_min'];
		var connecttime = (Data[i].DevStatus.toUpperCase() != "ONLINE") ? "--" : (Data[i].Time.split(":")[0] + unit_h + Data[i].Time.split(":")[1] + unit_m);
		if (Data[i].Time == "")
		{
			connecttime = "--";
		}
		
		SetDivValue('DivConnectTime_'+i, connecttime);
        if ((1 == IsPTVDFFlag || 1 == IsVDFPTAPFlag || 1 == isGlobe || 2 == ProductType) && (!isNotDBAA1SuperUser())) {
			var appname = '';
			if ('-1' == IsFindMacList(Data[i].MacAddr, macfilter, macfilterpolicy))
			{
				appname = userdevinfo_mainpage_language['bbsp_addblacklist'];
			}
			else
			{
				appname = userdevinfo_mainpage_language['bbsp_delblacklist'];
			}
			var appblacklistid = "appBlackList_" + devtype + "_" + i;
			document.getElementById(appblacklistid).value = appname;
		}
	}
}

function setEnableBlackPolicy(index, DevData)
{
	var ConfigParaList = new Array();
	
	if (DevData[index].PortType.toUpperCase().indexOf("WIFI")<0)
	{
		if ('1' != enableMacFilter)
		{
			ConfigParaList.push(new stSpecParaArray("x.MacFilterRight",1, 0));
		}
		if ('0' != MacFilterPolicy)
		{
			ConfigParaList.push(new stSpecParaArray("x.MacFilterPolicy",0, 0));
		}
	}
	else
	{
		if ('1' != enableWlanMacFilter)
		{
			ConfigParaList.push(new stSpecParaArray("x.WlanMacFilterRight",1, 0));
		}
		if ('0' != WlanMacFilterPolicy)
		{
			ConfigParaList.push(new stSpecParaArray("x.WlanMacFilterPolicy",0, 0));
		}
	}
	if (ConfigParaList.length > 0)
	{
		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false;
		Parameter.SpecParaPair = ConfigParaList;
		var ConfigUrl = 'setajax.cgi?x=InternetGatewayDevice.X_HW_Security'+'&RequestFile=/html/bbsp/userdevinfo/userdevinfosmart.asp';							  
		HWSetAction("ajax", ConfigUrl, Parameter, token);
	}
}

function setMacFilterList(index, DevData)
{
	var CurMacIndex;
	var MacAddr = DevData[index].MacAddr;
	
	var ConfigParaList = new Array();
	var Parameter = {};	
	Parameter.OldValueList = null;
	Parameter.FormLiList = null;
	Parameter.UnUseForm = true;
	Parameter.asynflag = false;
			
	if (DevData[index].PortType.toUpperCase().indexOf("WIFI")<0)
	{
		CurMacIndex = IsFindMacList(MacAddr,MacFilter,MacFilterPolicy);
		if ('-1' == CurMacIndex)
		{
			if (ConnectDevIp == DevData[index].IpAddr)
			{
				if (ConfirmEx(userdevinfo_mainpage_language['bbsp_AddBlacklistHint']) == false)
				{
					return false;
				}
			}
			
			if (MacFilter.length >= 8+1)
	        {
	            AlertEx(userdevinfo_language['bbsp_macfilterfull']);
	            return false;
	        }

			ConfigParaList.push(new stSpecParaArray("x.SourceMACAddress",MacAddr, 0));
			Parameter.SpecParaPair = ConfigParaList;
			var ConfigUrl = 'addajax.cgi?x=InternetGatewayDevice.X_HW_Security.MacFilter&RequestFile=/html/bbsp/userdevinfo/userdevinfosmart.asp';							  
			HWSetAction("ajax", ConfigUrl, Parameter, token);
		}
		else
		{
			ConfigParaList.push(new stSpecParaArray(MacFilter[CurMacIndex].domain ,'', 0));
			Parameter.SpecParaPair = ConfigParaList;
			var ConfigUrl = 'delajax.cgi?x=InternetGatewayDevice.X_HW_Security.MacFilter&RequestFile=/html/bbsp/userdevinfo/userdevinfosmart.asp';		
			HWSetAction("ajax", ConfigUrl, Parameter, token);
		}
	}
	else
	{
		CurMacIndex = IsFindMacList(MacAddr,WlanMacFilter,WlanMacFilterPolicy);
		if ('-1' == CurMacIndex)
		{
			if (ConnectDevIp == DevData[index].IpAddr)
			{
				if (ConfirmEx(userdevinfo_mainpage_language['bbsp_AddBlacklistHint']) == false)
				{
					return false;
				}
			}
			
			var SL = GetSSIDList();
			for (var i = 0, l = SL.length; i < l; i++)
			{
			    var ssidname = 'SSID-' + SL[i].name.charAt(SL[i].name.length - 1);
				var num = 0;
				for (var j = 0; j < WlanMacFilter.length-1; j++)
			    {
		            if (ssidname == WlanMacFilter[j].SSIDName)
		            {
		               num++;
		            }
			    }
			    if (num >= 8)
			    {
			        AlertEx(userdevinfo_language['bbsp_rulenum']);
			        return false;
			    }
			}
			for (var i = 0, l = SL.length; i < l; i++)
			{
			    var ssidname = 'SSID-' + SL[i].name.charAt(SL[i].name.length - 1);
				ConfigParaList = [];
				ConfigParaList.push(new stSpecParaArray("x.SSIDName",ssidname, 0));
				ConfigParaList.push(new stSpecParaArray("x.SourceMACAddress",MacAddr, 0));
				ConfigParaList.push(new stSpecParaArray("x.Enable", 1, 0));
				Parameter.SpecParaPair = ConfigParaList;
				var ConfigUrl = 'addajax.cgi?x=InternetGatewayDevice.X_HW_Security.WLANMacFilter&RequestFile=/html/bbsp/userdevinfo/userdevinfosmart.asp';							  
				HWSetAction("ajax", ConfigUrl, Parameter, token);
			}
		}
		else
		{
		    for(var i = 0, l = WlanMacFilter.length - 1; i < l; i++) 
			{
				if (WlanMacFilter[i].MACAddress == MacAddr)
				{
					ConfigParaList = [];
					ConfigParaList.push(new stSpecParaArray(WlanMacFilter[i].domain ,'', 0));
					Parameter.SpecParaPair = ConfigParaList;
					var ConfigUrl = 'delajax.cgi?x=InternetGatewayDevice.X_HW_Security.WLANMacFilter&RequestFile=/html/bbsp/userdevinfo/userdevinfosmart.asp';		
					HWSetAction("ajax", ConfigUrl, Parameter, token);
				}
			}
		}
	}
	return true;
}

function ApplyBlackList(val)
{
	var id = val.id;
	var DevType = id.split('_')[1];
	var index = id.split('_')[2];
	
	if ('LINEDEV' == DevType.toUpperCase())
	{
		setEnableBlackPolicy(index, EthDev);
		if (false == setMacFilterList(index, EthDev))
		{
			return;
		}
	}
	else if (('WIFIDEV' == DevType.toUpperCase()) && ('1' == IsSupportWifi))
	{
		setEnableBlackPolicy(index, WifiDev);
		if (false == setMacFilterList(index, WifiDev))
		{
			return;
		}
	}
	
	location.replace('/html/bbsp/userdevinfo/userdevinfosmart.asp?type='+DevType);
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
		b.innerHTML = userdevinfo_mainpage_language[b.getAttribute("BindText")];
	}
}

function getHeight(id)
{
	var item = document.getElementById(id);
	if (item != null)
	{
		if (item.style.display == 'none')
		{
			return 0;
		}
		if (typeof item.scrollHeight == 'number')
		{
			return item.scrollHeight;
		}
		return null;
	}

	return null;
}
function adjustParentHeight()
{
	var dh = getHeight("DevTitle");
	var dh1 = getHeight("devlist");
	var height = (dh > 0 ? dh : 0) + (dh1 > 0 ? dh1 : 0) + 24;
	if (curCfgModeWord.toUpperCase() == "TURKCELL2") {
		height += 38;
	}
	if(navigator.appName.indexOf("Internet Explorer") == -1)
	{
		window.parent.adjustParentHeight("mainpage", height + 800);		
	}
	window.parent.adjustParentHeight("ContectdevmngtPage", height);
}

function getHomeNetData()
{
	var isZQ = <%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>;
	var isSupportHomeNet = <%HW_WEB_GetFeatureSupport(FT_ZQ_SUPPORT_SMART);%>;
	if (!isSupportHomeNet && isZQ) {
		return;
	}
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : '&x.X_HW_Token='+ token,
		url : "/html/bbsp/userdevinfo/getHomeNetdata.asp",
		success : function(data) {
			HomeNetNameList = dealDataWithFun(data);
		}
	});
}

function LoadFrame()
{
	loadlanguage();
	getHomeNetData();
	parent.SetDeviceNum();
}
function submit1(index)
{
	var indexResult;
	var strArr = Data[index].Domain.split('.')
	var instanceNum = strArr[strArr.length - 1];
	for(var i = 0; i < UserDevices.length -1; i++)
	{
		if(Data[index].Domain == UserDevices[i].Domain)
		{
			indexResult = i;
		}
	}
	top.getElementById("menuIframe").src = '/html/bbsp/userdevinfo/userdetdevinfo.asp?' + indexResult +  "?" + parseInt(page,10);
}

function submit2(index, Data)
{
	var shell = null;
	var index_s=index.split("_")[1];
	var address = "\\\\"+Data[index_s].IpAddr;
	try
	{
        shell = new ActiveXObject("wscript.shell");
    }
	catch(exception)
	{
		AlertEx(userdevinfo_language['bbsp_explorertooh']+"\r\n\r\n" +userdevinfo_language['bbsp_youcaninput']+"\""+address+"\""+userdevinfo_language['bbsp_accesscom']);
		return false;
	}
	shell.run("explorer "+address);
}
function submit3(index, IsBridgeFlag, Data)
{
	var index_a=index.split("_")[1];
	if(IsBridgeFlag)
	{
		var numpara1 = Data[index_a].IpAddr;
		var numpara2 = Data[index_a].MacAddr;
		var porttype = Data[index_a].PortType;
		var portid   = Data[index_a].Port;
		var menuID = ProductType != '3' ? "macfilter" : "macflt";
		if(porttype == "ETH")
		{
			window.parent.parent.onMenuChange(menuID);
			window.parent.location='../../../html/bbsp/macfilter/macfilter.asp?' + numpara2;
		}
		else
		{
			window.parent.parent.onMenuChange("wlanmacfilter");
			window.parent.location='../../../html/bbsp/wlanmacfilter/wlanmacfilter.asp?' + numpara2 + '?' + portid;
		}
	} else {
		var ssidPort = Data[index_a].Port;
		if ("TALKTALK2WIFI" == curCfgModeWord)
		{
			ssidPort = Data[index_a].PortID;
		}
		var jumppageURL = Data[index_a].IpAddr + "?"+ Data[index_a].MacAddr + "?" + Data[index_a].PortType + "?" + ssidPort + "?" + parseInt(page,10); 
		top.getElementById("menuIframe").src = '/html/bbsp/userdevinfo/netappsmart.asp?' + jumppageURL;
	}
}


function submit4(index, Data)
{
	var index_a=index.split("_")[1];

	if (ConfirmEx(userdevinfo_language['bbsp_devinfodelconfirm'])) 
	{
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			data : Data[index_a].Domain+"="+"&x.X_HW_Token="+getValue('onttoken'),
			url : 'del.cgi?' +'x=InternetGatewayDevice.LANDevice.1.X_HW_UserDev&RequestFile=html/bbsp/userdevinfo/userdevinfosmart.asp',
			success : function(data) {
				
			},
			complete: function (XHR, TS) {
			XHR=null;
			}
		});

	    location.replace('/html/bbsp/userdevinfo/userdevinfosmart.asp?type='+DevType);
		DisableRepeatSubmit();
	}
}

function IsBridgeAddressSource(IPAddressSource)
{
	if(("Static"==IPAddressSource)||("DHCP"==IPAddressSource))
	{
		return false;
	}
	return true;
}

function RefreshWiFiDevice(devtype, data) {
    $("#devListDiv").remove();
    ShowCntDevDetails(devtype, data);
    adjustParentHeight();

    if (top.wifiDevFreq == '2G') {
        $("#devicetitle5g").css('color', '#56b6f1');
    } else {
        $("#devicetitle").css('color', '#56b6f1');
    }
}

</script>
</head>
<body onLoad="LoadFrame();" class="userinfo" style="background-color:#EDF1F2;">
<div id="devlistsmart">
<script>
function ShowCntDevDetails(DevType, DataIn)
{
	var numIn = DataIn.length;
	var Data = new Array();
	var macfilter = new Array();
	var macfilterpolicy = '';
	var DataIndex = 0;
	var num = 0;
	
	for(var index = 0; index < numIn; index++)
	{
	
		Data[DataIndex] = DataIn[index];
		DataIndex++;
	}	
	num = DataIndex;
	
	var html="";
	html += '<div id = "devListDiv">';
    var html = "";
	var HeadName = '';
	if ('WIFIDEV' == DevType.toUpperCase())
	{
		HeadName = userdevinfo_mainpage_language['bbsp_wifidev'];
		macfilter = WlanMacFilter;
		macfilterpolicy = WlanMacFilterPolicy;

		if ((curCfgModeWord.toUpperCase() == "TURKCELL2") && (DoubleFreqFlag == 1)) {
            HeadName = userdevinfo_mainpage_language['bbsp_wifidev_2g'];
        }
	}
	else
	{
		HeadName = userdevinfo_mainpage_language['bbsp_linedev'];
		if (IsSupportWifi != 1) {
			HeadName = userdevinfo_mainpage_language['bbsp_linedevnowifi'];
		}
		if(SingtelMode == 1)
		{
			HeadName = userdevinfo_mainpage_language['bbsp_linedev_SINGTEL'];
		}
		macfilter = MacFilter;
		macfilterpolicy = MacFilterPolicy;
	}
	if (APChangeMode > 0 || GhnDevFlag ==1)
	{
		html += '<table id="DevTitle" class="DevNameTitle" style = "width:94%;background-color:#56B2F8;height:30px;line-height:30px;">';
		html += '<tr><td><img style = "height:16px;width:15px" src="../../../images/usermark.png"></td><td width="5%"><label id="devicetitle" name="devicetitle" class="DeviceTitle" style="white-space:nowrap;color:white">' + HeadName + '</label></td>';
		html += '<td class="DeviceLine"> | </td>';
		html += '<td width="5%"><a id="refresh" href="" name="'+htmlencode(DevType)+'" onClick="ClickRefresh(this.name);" class="DeviceRefresh" style="white-space:nowrap;color:white;text-decoration:none;">'+ userdevinfo_mainpage_language['bbsp_refresh'] +'</a></td>';
		html += '<td width="90%"></td>';
		html += '</tr>';
		html += '</table>';
	}
	else
	{
		html += '<table id="DevTitle" class="DevNameTitle">';
		html += '<tr><td width="5%"><label id="devicetitle" name="devicetitle" class="DeviceTitle" style="white-space:nowrap;">' + HeadName + '</label></td>';
		html += '<td class="DeviceLine"> | </td>';
        if ((curCfgModeWord.toUpperCase() == "TURKCELL2") && (DoubleFreqFlag == 1) && (DevType.toUpperCase() == 'WIFIDEV')) {
            html += '<td width="5%"><label id="devicetitle5g" class="DeviceTitle" style="white-space:nowrap;">' + userdevinfo_mainpage_language['bbsp_wifidev_5g'] + '</label></td>';
            html += '<td class="DeviceLine"> | </td>';
        }
		if (curCfgModeWord.toUpperCase().indexOf('DTEDATA') >= 0)
		{
			html += '<td width="5%"><a id="refresh" href="" name="'+htmlencode(DevType)+'" onClick="ClickRefresh(this.name);" class="DeviceRefresh" style="white-space:nowrap;color:#6f2d91;text-decoration:none;">'+ userdevinfo_mainpage_language['bbsp_refresh'] +'</a></td>';
		}
		else
		{
			html += '<td width="5%"><a id="refresh" href="" name="'+htmlencode(DevType)+'" onClick="ClickRefresh(this.name);" class="DeviceRefresh" style="white-space:nowrap;color:#56b6f1;text-decoration:none;">'+ userdevinfo_mainpage_language['bbsp_refresh'] +'</a></td>';
		}
		html += '<td width="90%"></td>';
		html += '</tr>';
		html += '<tr><td height="10px"></td><tr>';
		html += '</table>';
		if (curCfgModeWord.toUpperCase() == "TURKCELL2") {
			html += '<table class="DevNameTitle">';
			if (DevType.toUpperCase() == 'LINEDEV') {
				html += '<tr><td ><label id="devicetitle" name="devicetitle" class="DeviceTitle" style="white-space:nowrap;">' + userdevinfo_mainpage_language['bbsp_linedevNum'] + num + '</label></td><tr>';
                html += '<tr><td ><label id="devicetitle" name="devicetitle" class="DeviceTitle" style="white-space:nowrap;">' + userdevinfo_mainpage_language['bbsp_onlinelinedevNum'] + EthOnlineNum + '</label></td><tr>';
            } else {
                var onLineNum = (top.wifiDevFreq == '2G') ? wifiOnlineDevNum2g : wifiOnlineDevNum5g;
                html += '<tr><td ><label class="DeviceTitle" style="white-space:nowrap;">' + userdevinfo_mainpage_language['bbsp_wifidevNum'] + numIn + '</label></td><tr>';
                html += '<tr><td ><label class="DeviceTitle" style="white-space:nowrap;">' + userdevinfo_mainpage_language['bbsp_onlinewifidevNum'] + onLineNum + '</label></td><tr>';
            }

			html += '</table>';
		}
	}
	html += '<table width="94%" border="1" align="center" cellpadding="0" cellspacing="0" id="devlist" class="DevTable DevTableListTd">';
	html += '<tr class="DevTableTitle">';

    if ((TDEMode == "1") || isNotDBAA1SuperUser()) {
		html += '<td width="20%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_devname'] + '</td>';
		html += '<td width="20%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_devport'] + '</td>';
		html += '<td width="20%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_devinfo'] + '</td>';
		html += '<td width="20%" class="DevTableListTd">' + userdevinfo_language['bbsp_devstate'] + '</td>';
		html += '<td width="20%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_connecttime'] + '</td>';
	}
	else
	{
		html += '<td width="18%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_devname'] + '</td>';
		if (curCfgModeWord == "TALKTALK2WIFI")
		{
			html += '<td width="12%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_mode'] + '</td>';
		}			
		else if (APAutoUPPortFlag != 1)
		{
			html += '<td width="12%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_devport'] + '</td>';
		}
		html += '<td width="15%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_devinfo'] + '</td>';
		html += '<td width="15%" class="DevTableListTd">' + userdevinfo_language['bbsp_devstate'] + '</td>';
		html += '<td width="20%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_connecttime'] + '</td>';
		html += '<td width="20%" class="DevTableListTd">' + userdevinfo_mainpage_language['bbsp_appblacklist'] + '</td>';		
		html += '</tr>';
	}
	
	var existOnline = 0;
	for(var i=0;i < num;i++)   
	{
		if (Data[i].PortType.toUpperCase().indexOf("WIFI") >=0)
		{	
			var ssidindex = Data[i].Port;	
			ssidindex = ssidindex.charAt(ssidindex.length-1);
			if (1 == isSsidForIsp(ssidindex))
			{
				continue;
			}
		}

        if (["TOTALPLAY", "TOTALPLAY2"].indexOf(curCfgModeWord.toUpperCase()) >= 0) {
            var skipFlag = 0;
            for (var j = 0; j < ispStaInfoJson.length; j++) {
                if (Data[i].MacAddr.toLowerCase() == ispStaInfoJson[j].ispStaMac.toLowerCase()) {
                    skipFlag = 1;
                    break;
                }
            }
            if (skipFlag == 1) {
                continue;
            }
        }

		if (curCfgModeWord == "DAUM2WIFI") {
			if (userdevinfo_language[Data[i].DevStatus] == "Offline") {
				html += '<tr class="DevTableList" style="display:none;">';
			} else {
				existOnline++;
				html += '<tr class="DevTableList">';
			}
		} else {
			html += '<tr class="DevTableList">';
		}

		html += '<td class="DevTableListTd1" width="22%" nowrap>';
		html += '<div id="divLabelDevName_'+ i +'">';
		html += '<nobr>';
		html += '<label id="labelDevName_'+ i +'" class="DevNameLabel" title="'+htmlencode(Data[i].HostName)+'"><div id="divDevName_'+ i +'"></div></label>';
		html += '<button style="display:none;" type="button" id="btnEdit_' + i +'"  type="button"  class="DevEditBtn"  onClick="EditDeviceName(this.id);"></button>';
		html += '</nobr>';
		html += '</div>';
		
		html += '<div style="display:none;" id="divInputDevName_'+ i +'" >';
		html += '<input type="text" id="inputDevName_'+ i +'" class="DevInputName"/>';
		html += '<a id="btnAppDevName_' + i +'" href="#" class="DevNameBtnBg" onClick="SubmitDevName(this);" style="white-space:nowrap;text-decoration:none;">'+ userdevinfo_mainpage_language['bbsp_apply'] +'</a>' +'&nbsp';
		html += '<a id="btnCancleDevName_' + i +'" href="#" class="DevNameBtnBg" onClick="CancleDevName(this);" style="white-space:nowrap;text-decoration:none;">'+ userdevinfo_mainpage_language['bbsp_cancle'] +'</a>';
		html += '</div>';
		html += '</td>';
		
		if (APAutoUPPortFlag != 1)
		{
		html +=  '<td class="DevTableListTd2" width="12%"><div id="DivDevPort_' + i +'"></div></td>';
		}
		html +=  '<td class="DevTableListTd2" width="15%"><div id="DivIpandMac_' + i +'"></div></td>';
		html +=  '<td class="DevTableListTd2" width="11%"><div id="DivDevStatus_' + i +'"></div></td>';
		html += '<td class="DevTableListTd1" width="20%"><div id="DivConnectTime_' + i +'"></div></td>';
		if ((TDEMode == "0") && (!isNotDBAA1SuperUser()))
		{
			html += '<td class="DevTableListTd" width="20%">';
			if(1 == IsVDFPTAPFlag || 1 == isGlobe || 2 == ProductType)
			{
				html += '<input style="font-size:12px;" type="button" id="appBlackList_' + htmlencode(DevType) + '_' + i +'" class="ApplyButtoncss buttonwidth_97px_150px"  onClick="ApplyBlackList(this);"/>';
			}
			else if (IsPTVDFFlag == 1) {
				window.DevType = DevType;
				window.Data = Data;
				html += '<button name="btnApply" id='+ i +' class="ApplyButtoncss oprateDeviceButton" onClick="submit1(this.id);">';
				if (IsDevTypeFlag == 1) {
					html += userdevinfo_language['bbsp_editinfo'];
				} else {
					html += userdevinfo_language['bbsp_detinfo'];
				}
				html += '</button>';
				html += '<input style="font-size:12px;" type="button" id="appBlackList_' + htmlencode(DevType) + '_' + i +'" class="ApplyButtoncss oprateDeviceButton"  onClick="ApplyBlackList(this);"/>';
			} else
			{
				window.DevType = DevType;
				window.Data = Data;
				html += '<button name="btnApply" id='+ i +' class="ApplyButtoncss oprateDeviceButton" onClick="submit1(this.id);">';
				if (IsDevTypeFlag == 1)
				{
					html += userdevinfo_language['bbsp_editinfo'];
				}
				else
				{
					html += userdevinfo_language['bbsp_detinfo'];
				}
				html += '</button>';
				var IsBridgeFlag=IsBridgeAddressSource(Data[i].IpType);
				if ('ONLINE' != Data[i].DevStatus.toUpperCase() )
				{
					html += '<button name="btnApply" id=share_'+ i +'  type="button"  class="ApplyButtoncss oprateDeviceButton"  onClick="submit4(this.id,Data);">';
					html += userdevinfo_language['bbsp_delete'];
					html += '</button>';
				}
				else
				{	
					if("1" != GetCfgMode().PTVDF)
					{
						if(!IsBridgeFlag)
						{
							html += '<button name="btnApply" id=share_'+ i +'  type="button"  class="ApplyButtoncss oprateDeviceButton"  onClick="submit2(this.id, Data);">';
							html += userdevinfo_language['bbsp_comaccess'];
							html += '</button>';
						}
					}
				}
                // 如果BBSP_FT_LSW_WEB_CUT开关开启，则不显示，其中BBSP_FT_LSW_WEB_CUT为p815E独有，不影响其他
                var feature_web_cut = <%HW_WEB_GetFeatureSupport(BBSP_FT_LSW_WEB_CUT);%>;
                if (!feature_web_cut){
					html += '<button name="btnApply" id=netapp_'+ i +'  type="button" class="ApplyButtoncss oprateDeviceButton"  onClick="submit3(this.id, '+ IsBridgeMode +', Data);">';

					if('0' == IsBridgeMode)
					{
						html += userdevinfo_language['bbsp_netapp'];
					}
					else
					{
						html += userdevinfo_language['bbsp_macfilt'];
					}
					html += '</button>';
				}
			}
			html += '</td>';
		}
		html += "</tr>";
	}

	if ((num == 0) || ((curCfgModeWord == "DAUM2WIFI") && (existOnline == 0))) {
		html += '<tr class="DevTableList">';
		html +=  '<td class="DevTableListTd" colspan="6" width="100%" nowrap>' + userdevinfo_mainpage_language['bbsp_nodata'] + '</td>';
		html += '</tr>';
	}

	html += '</table>';
	html += '</div>';
	$("#devlistsmart").after(html);
	setDeviceInfo(Data, macfilter, macfilterpolicy);
    if ((curCfgModeWord.toUpperCase() == "TURKCELL2") && (DoubleFreqFlag == 1) && (devtype.toUpperCase() == 'WIFIDEV')) {
        $("#devicetitle").click(function(event){
            top.wifiDevFreq = '2G';
            RefreshWiFiDevice(devtype, wifiDev2g);
        });

        $("#devicetitle5g").click(function(event){
            top.wifiDevFreq = '5G';
            RefreshWiFiDevice(devtype, wifiDev5g);
        });
    }
}
</script>
<tr>
<td height="24px">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
</td>

<tr>
</div>
<script>
GetLanUserDevInfo(function(para)
{
	UserDevices = para;
	GetDevInfo();
	if ('LINEDEV' == devtype.toUpperCase())
	{
		ShowCntDevDetails(devtype, EthDev);
	}
	else
	{
        if ((curCfgModeWord.toUpperCase() == "TURKCELL2") && (DoubleFreqFlag == 1)) {
            top.wifiDevFreq = '2G';
            ShowCntDevDetails(devtype, wifiDev2g);
            $("#devicetitle5g").css('color', '#56b6f1');
        } else {
            ShowCntDevDetails(devtype, WifiDev);
        }
	}
	
	if ('DVODACOM2WIFI' == curCfgModeWord.toUpperCase())
	{
		$("#refresh").css("color", "red");
	}
	
	adjustParentHeight();	
});
</script>
	</body>
</html>
