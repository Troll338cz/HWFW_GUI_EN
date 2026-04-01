<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(common.js);%>"></script>
<script language="javascript" src="../../bbsp/common/topoinfo.asp"></script>
<script>
var curUserType = '<%HW_WEB_GetUserType();%>';
function __GetISPWanOnlyRead()
{
	return ("<%HW_WEB_GetFeatureSupport(BBSP_FT_ISPSSID_DISPALY);%>" == "1")?true:false;
}
</script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wanipv6state.asp"></script>
<script language="javascript" src="../../bbsp/common/wanaddressacquire.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info_e8c.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_e8c.asp"></script>
<script language="javascript" src="../../bbsp/common/wancontrole8c.asp"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script language="javascript" src="../../bbsp/common/lanuserinfo.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, qos_language);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var BinWord ='<%HW_WEB_GetBinMode();%>';
var Stbid ='<%HW_WEB_GetStbid();%>';
var TopoInfo = GetTopoInfo();
var ontMatchOLTStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.ONT.MatchStatus);%>';
var softversion = '<%HW_WEB_GetSoftVersion();%>';
var ctCustomVer = '<%HW_WEB_GetFeatureSupport(FT_CTCUSTOM_VERSION);%>';
var isSupportOptic = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_OPTIC);%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var IsRhGateway = '<%HW_WEB_GetFeatureSupport(RH_WEB_INFO_DISPLAY);%>'
var IsLAN = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var IsInformStbid = '<%HW_WEB_GetFeatureSupport(FT_CWMP_INFORM_STBID);%>';
var TianYiFlag = '<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>';
var AnHuiFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_AHCT);%>';
var E8CRONGHEFlag = '<%HW_WEB_GetFeatureSupport(FT_SHMP_RONGHE);%>';
var IsZQ = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
var jiuzhouFlag = '<%WEB_GetJiuZhouFlag();%>';

function isPortInAttrName()
{
    if((1 == TianYiFlag) && ('E8C' == CurrentBin.toUpperCase()))
	{
		return true;
	}
	return false;
}
var acEthType = '<%HW_WEB_GetEthTypeList();%>'; 
var lanDescArr = new Array();
var GEPortNum = 0;
var PortIndex = 1;
for(var i = 1; i <= parseInt(acEthType.charAt(0)) ; i++)
{
    if ('1' != acEthType.charAt(i))
    {
        GEPortNum++;
    }
}

for(var i = 1; i <= parseInt(acEthType.charAt(0)) ; i++)
{
    if (((2 == i) || ((3 == i) && (1 == AnHuiFlag))) && (4 == acEthType.charAt(0)) && ('E8C' == CurrentBin.toUpperCase()))
    {
        lanDescArr.push("iTV");
        if ((1 != GEPortNum) || (3 == i))
        {
            PortIndex++;
        }
    }
    else
    {
        if ('1' != acEthType.charAt(i))
        {
            if (1 == GEPortNum)
            {
                lanDescArr.push("千兆口");
            }
            else
            {
                lanDescArr.push("千兆口" + PortIndex);
            }
            PortIndex++;
        }
        else
        {
            lanDescArr.push("百兆口" + PortIndex);
            PortIndex++;
        }
    }
}

function GetServLang(type)
{
	var serv =
	{
		internet_en: 'INTERNET',
		other_en:    'OTHER',
		tr069_en:    'TR069',
		voip_en:     'VOICE',
		service_en:  'SPECIAL SERVICE', 
		internet_cn: '上网',
		other_cn:    '其它',
		tr069_cn:    '管理',
		service_cn:  'SPECIAL SERVICE', 
		voip_cn:     '语音'
	};

	return serv[type + ((1 == '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_AHCT);%>')? "_en" : "_cn")];
}
function stDeviceInfo(domain,SerialNumber,HardwareVersion,SoftwareVersion,ModelName,VendorID,ReleaseTime,Mac,Description,ManufacturerOUI,specsn,DeviceType,AccessType,ManufactureInfo,ImageSize,SysVersion,CpuFrequence,Memtotal,Flashtotal,ProcessorNumberOfEntries)
{
	this.domain             = domain;
	this.SerialNumber       = SerialNumber;
	this.HardwareVersion    = HardwareVersion;
	this.SoftwareVersion    = SoftwareVersion;
	this.ModelName          = ModelName;
	this.VendorID           = VendorID;
	this.ReleaseTime        = ReleaseTime;
	this.Mac                = Mac;
	this.Description        = Description;
	this.ManufacturerOUI    = ManufacturerOUI;
	this.specsn             = specsn;
	this.DeviceType         = DeviceType;
	this.AccessType         = AccessType;
	this.ManufactureInfo    = ManufactureInfo;
	this.ImageSize          = ImageSize;
	this.SysVersion         = SysVersion;
	this.CpuFrequence       = CpuFrequence;
	this.Memtotal           = Memtotal;
	this.Flashtotal         = Flashtotal;
	this.ProcessorNumberOfEntries = ProcessorNumberOfEntries;
}

function ONTInfo(domain,ONTID,Status)
{
	this.domain         = domain;
	this.ONTID          = ONTID;
	this.Status         = Status;
}

var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>;
var SimIsAuth=SimConnStates[0].AuthState;
function filterWanOnlyTr069(WanItem)
{
	if ("0" == SimIsAuth && WanItem.ServiceList.indexOf("TR069") < 0)
	{
		return false;
	}
	return true;
}
function stWlanInfo(domain,enable,name,ssid)
{
	this.domain = domain;
	this.enable = enable;
	this.name = name;
	this.ssid = ssid;
}

function GetProtocolType(IPv4Enable, IPv6Enable)
{
	if (IPv4Enable == "1" && IPv6Enable == "1")
	{
		return "IPv4/IPv6";
	}
	if (IPv4Enable == "1")
	{
		return "IPv4";
	}
	return "IPv6"
}

function GetWanName(wan)
{
	var wanInst = 0;
	var wanServiceList = '';
	var wanMode = '';
	var vlanId = 0;
	var currentWanName = '';

	wanInst = wan.MacId;
	wanServiceList  = wan.ServiceList;
	wanMode         = (wan.Mode == 'IP_Routed' ) ? "R" : "B";
	vlanId          = wan.VlanId;

	if (0 != parseInt(vlanId))
	{
		currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_" + vlanId;
	}
	else
	{
		currentWanName = wanInst + "_" + wanServiceList + "_" + wanMode + "_VID_";
	}

	for (var i = 0;i < GetWanList().length;i++)
	{
		var CurrentWan = GetWanList()[i];
		if (CurrentWan.MacId ==  wan.MacId)
		{
			return CurrentWan.Name;
		}
	}

	return currentWanName;
}

function EPONLinkStatus(domain,FECEnable,EncryptionEnable,LinkAlarmInfo,PONTxPacketsHigh,PONRxPacketsHigh,PONTxPacketsLow,PONRxPacketsLow)
{
	this.Domain = domain;
	this.FECEnable = FECEnable;
	this.EncryptionEnable = EncryptionEnable;
	this.LinkAlarmInfo = LinkAlarmInfo;
	this.PONTxPacketsHigh = PONTxPacketsHigh;
	this.PONRxPacketsHigh = PONRxPacketsHigh;
	this.PONTxPacketsLow = PONTxPacketsLow;
	this.PONRxPacketsLow = PONRxPacketsLow;

}

function AuthInfo(domain, AuthUserName)
{
	this.Domain = domain;
	this.AuthUserName = AuthUserName;
}

function LineInfo(domain, Status)
{
	this.Domain = domain;
	this.Status = Status;
}
var MngtGdct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GDCT);%>';
var MngtJsct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_JSCT);%>';
var MngtSzct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SZCT);%>';
var MngtYnct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_YNCT);%>';
var MngtFjct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_FJCT);%>';
var MngtScct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SCCT);%>';
var MngtCqct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_CQCT);%>';
var MngtGsct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GSCT);%>';
var Mngtct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_CT);%>';

function VoiceRelationInfo(ErrorDes, ChineseDes)
{
	this.ErrorDes = ErrorDes;
	this.ChineseDes = ChineseDes;
}
var VoiceErrorDes = '<%HW_WEB_GetVoiceRegState();%>';
var VoiceStateInfo = new Array(new VoiceRelationInfo("Error_None", "正常注册"),
							   new VoiceRelationInfo("Error_SBCUnreachable", "网络（SBC）不可达"),
							   new VoiceRelationInfo("Error_AuthenticationFail", "鉴权失败"),
							   new VoiceRelationInfo("Error_VOIPPathFail", "业务通道异常"),
							   new VoiceRelationInfo("Error_Unknown", "其它异常"),
							   null);

function GetVoiceChineseDes(VoiceStateInfo, ErrorDes)
{
	var length = VoiceStateInfo.length;

	for( var i = 0; i <  length - 1; i++)
	{
		if((ErrorDes != '') && (ErrorDes == VoiceStateInfo[i].ErrorDes))
		{
			return VoiceStateInfo[i].ChineseDes;
		}
	}
	return '/';
}

function stResultInfo(domain, Result, Status, InformStatus)
{
	this.domain = domain;
	this.Result = Result;
	this.Status = Status;
	this.InformStatus   = InformStatus;
}
function stAuthGetLoidPwd(domain,Loid,Password)
{
	this.domain   = domain;
	this.Loid     = Loid;
	this.Password = Password;
}

function PonOpticInfo(domain,transOpticPower, revOpticPower)
{
	this.Domain = domain;
	this.TransOpticPower = transOpticPower;
	this.RevOpticPower = revOpticPower;
}
var PonOpticInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic,TxPower|RxPower, PonOpticInfo);%>;
var PonOpticInfo = PonOpticInfoList[0];

var AuthInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, UserName|UserId, stAuthGetLoidPwd);%>;
var LoidPwdInfo = AuthInfo[0];
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var ontLedMode = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_LOID_O5AUTH_SHOW);%>';

var RevOptic = 0;
var TransOptic = 0;
if('0' != isSupportOptic)
{
 RevOptic = PonOpticInfo.RevOpticPower;
 TransOptic = PonOpticInfo.TransOpticPower;
}

var stInfoStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserInfo.X_HW_InformStatus);%>';
var stResultInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, Result|Status|X_HW_InformStatus, stResultInfo);%>;
var Infos = stResultInfos[0];
var ontInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT,Ontid|State,ONTInfo);%>;
var ontEPONInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT,Ontid|State,ONTInfo);%>;
var deviceInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, SerialNumber|HardwareVersion|SoftwareVersion|ModelName|X_HW_VendorId|X_HW_ReleaseTime|X_HW_LanMac|Description|ManufacturerOUI|X_HW_SpecSn|DeviceType|AccessType|ManufactureInfo|X_HW_ImageSize|X_HW_SysVersion|X_HW_CpuFrequence|X_HW_Memtotal|X_HW_Flashtotal|ProcessorNumberOfEntries, stDeviceInfo);%>;
var EponLinkStates = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.EPONLinkInfo,FECEnable|EncryptionEnable|LinkAlarmInfo|PONTxPacketsHigh|PONRxPacketsHigh|PONTxPacketsLow|PONRxPacketsLow,EPONLinkStatus);%>;
var ontInfo = ontInfos[0];
var ontEPONInfo = ontEPONInfos[0];
var deviceInfo = deviceInfos[0];
var EponLinkState = EponLinkStates[0];
var losStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptStaus.status);%>';
var RxThresStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptStaus.RxThresStatus);%>';

var WanList = GetWanList();
var Wan = new Array();
for (var i=0,j=0; WanList.length >= 1 && j< WanList.length; i++,j++)
{
	if("1" == WanList[j].Tr069Flag )
	{
		i--;
		continue;
	}
	if(filterWanOnlyTr069(WanList[j]) == false )
	{
		i--;
		continue;
	}

	Wan[i]  = WanList[j];
}

function GetChineseStatus(EnglishStatus)
{
	var statusEnum = '{"Disconnected":"异常", "Connected" : "正常"}';
	var status = JSON.parse(statusEnum);
	return status[EnglishStatus] == undefined || typeof(status[EnglishStatus]) == 'undefined' ? "" : status[EnglishStatus];
}

function MakeWanName(type)
{
	var serv =
	{
		TR069: 		'ITMS管理通道状态',
		INTERNET:   'INTERNET（上网业务）',
		VOIP:    	'VOICE（语音业务）',
		OTHER:     	'ITV业务',
		SERVICE: 	"SPECIAL SERVICE" 
	};

	return serv[type];
}
function MakeConnectionMode(Wan,Type)
{
	var currentConnectionMode = "";
	if( Wan.Mode =="IP_Routed")
	{
		if(Wan.ServiceList.indexOf("INTERNET") >= 0 && Type == "INTERNET")
		{
			currentConnectionMode = "路由（网关拨号）";
		}
		else
		{
			currentConnectionMode = "路由";
		}
	}
	if((Wan.Mode =="IP_Bridged"|| Wan.Mode =="PPPoE_Bridged"))
	{
		if(Wan.ServiceList.indexOf("INTERNET") >= 0 && Type == "INTERNET")
		{
			currentConnectionMode = "桥接（电脑拨号）";
		}
		else
		{	
			currentConnectionMode = "桥接";
		}
	}
	return currentConnectionMode;
	
}
function MakeContentedWanStatus(currentwan)
{
	var statusvalue = "";
	if (currentwan.Mode =="IP_Routed")
	{
		switch (currentwan.IPv4AddressMode.toUpperCase())
		{
			case "DHCP":
				statusvalue = "路由（DHCP自动获取）";
				break;
			case "STATIC":
				statusvalue = "路由（静态获取）";
				break;
			case "PPPOE":
				statusvalue = "路由（终端内置拨号）";
				break;
			default:
				break;			
		}
	}
	else
	{	
		switch (currentwan.ServiceList.toUpperCase())
		{	
			case "INTERNET":
				statusvalue = "桥接（电脑拨号）";
				break;
			case "OTHER":
				statusvalue = "桥接（ITV终端自动获取）";
				break;	
			default:
				break;		
		}
	}
	return statusvalue;
}
function GetIPv6Address(CurrentWan)
{
	var ipv6Address = GetIPv6AddressList(CurrentWan.MacId);
	var ipv6AddressHtml = "";	
	for (var m = 0; m < ipv6Address.length; m++)
	{			
		if (ipv6Address[m].Origin.toUpperCase() != "LINKLOCAL")
		{				
			if (CurrentWan.Enable == "1")
			{
				if(ipv6AddressHtml == '')
					ipv6AddressHtml += ipv6Address[m].IPAddress;
				else
					ipv6AddressHtml += "<br>" + ipv6Address[m].IPAddress;
			}
		}
	}
	return 	ipv6AddressHtml;
}
function GetIPAddress(currentwan,ipaddress,type)
{
	var ipaddressvalue = "";
	var ipv6Wan = GetIPv6WanInfo(currentwan.MacId);
	var wanstatus = (type.toUpperCase() == "IPV4")?currentwan.Status:ipv6Wan.ConnectionStatus;
	if((IsPonOnline() || IsStaticIP(currentwan)) && wanstatus=="Connected")
	{
		if (currentwan.Mode == 'IP_Routed')
		{
			var ipv6Wan = GetIPv6WanInfo(currentwan.MacId);
			if (ipv6Wan.ConnectionStatus.toUpperCase() == "CONNECTED" && type.toUpperCase() == "IPV6")
			{
				var ipv6Address = GetIPv6Address(currentwan);
				return ipaddressvalue = (ipv6Address == "")?"/":ipv6Address;
			}						
			ipaddressvalue = ipaddress;
		}
		else
		{
			ipaddressvalue = "/"
		}
	}
	else
	{
		if (currentwan.Mode == 'IP_Routed')
		{
			if (type.toUpperCase() == "IPV6")
			{
				ipaddressvalue = "::";
			}
			else
			{
				ipaddressvalue = "--";
			}
		}
		else
		{
			ipaddressvalue = "/";
		}
	}	
	return ipaddressvalue;
}
function GetIPV6AddressAcquire(CurrentWan)
{
	var AddressAcquire = GetIPv6AddressAcquireInfo(CurrentWan.domain);
	var status = "";
	if (AddressAcquire.Origin.toUpperCase() == "NONE")
	{
		status = "正常使用、通道正常";
	}
	else
	{
		status = "正常使用、通道正常、获取到IP地址";
	}
	return status;
}
function GetDialStatus(currentwan,type)
{
	var dialstatusvalue = "";
	var ipv6Wan = GetIPv6WanInfo(currentwan.MacId);
	var wanstatus = (type.toUpperCase() == "IPV4")?currentwan.Status:ipv6Wan.ConnectionStatus;	
	if((currentwan.Mode =="IP_Bridged" || currentwan.Mode =="PPPoE_Bridged")&&(currentwan.ServiceList=="INTERNET"))
	{
		if(wanstatus=="Connected")
		{
			dialstatusvalue = "桥接型且通道正常";
		}
		else
		{
			dialstatusvalue = "桥接型且通道异常";
		}
	}
	else if(currentwan.Mode =="IP_Routed"&& currentwan.IPv4AddressMode.toUpperCase() == "PPPOE")
	{
		if((IsPonOnline() || IsStaticIP(currentwan)) && wanstatus=="Connected")
		{
			if (type.toUpperCase() == "IPV6")
			{
				dialstatusvalue = GetIPV6AddressAcquire(currentwan);
			}
			else
			{
				dialstatusvalue = "正常使用、通道正常、获取到IP地址";
			}
		}
		else
		{
			if (currentwan.Enable == "0")
			{
				dialstatusvalue = "其他错误";
			}
			else if(currentwan.LastConnErr == "ERROR_AUTHENTICATION_FAILURE")
			{
				dialstatusvalue = "691（认证失败）";
			}
			else if((currentwan.LastConnErr == "ERROR_SERVER_OUT_OF_RESOURCES")
				 || (currentwan.LastConnErr == "ERROR_USER_DISCONNECT")
				 || (currentwan.LastConnErr == "ERROR_ISP_TIME_OUT")
				 || (currentwan.LastConnErr == "ERROR_ISP_DISCONNECT"))
			{
				dialstatusvalue = "678（响应超时）";
			}
			else if(currentwan.LastConnErr == "ERROR_NONE")
			{
				dialstatusvalue = "拨号中";
			}
			else
			{
				dialstatusvalue = "其他错误";
			}
		}
	}
	else
	{
		dialstatusvalue = "/";
	}
	return dialstatusvalue;
}
function VoipStatus(currentwan)
{
	var voipstatus = "";
	if(currentwan.ServiceList.indexOf("VOIP") >= 0)
	{
		voipstatus = GetVoiceChineseDes(VoiceStateInfo, VoiceErrorDes);
	}
	else
	{
		voipstatus = "/";
	}
	return voipstatus;	
}
function WriteWanInfo(type)
{
	for (i = 0;i < Wan.length;i++)
	{
		var voipstatusvalue = "";
		if(Wan[i].ServiceList.indexOf(type) >= 0)
		{
			var wanName = MakeWanName(type);
			rowItms = false;
			var htmlline = "";
			var ipaddress = (Wan[i].ProtocolType == "IPv4")? Wan[i].IPv4IPAddress:Wan[i].IPv6IPAddress;
			if (Wan[i].ProtocolType == "IPv4/IPv6")
			{			
				for(var k = 0;k < 2;k++)
				{
					var IPProtocolType = (rowItms == false)? "IPv4":"IPv6";					
					ipaddress = (IPProtocolType == "IPv4")? Wan[i].IPv4IPAddress:"::";
					if (IPProtocolType == "IPv6")
					{
						voipstatusvalue = "/";
					}
					else
					{
						if (type != "VOIP")
						{
							voipstatusvalue = "/";
						}
						else
						{
							voipstatusvalue = VoipStatus(Wan[i]);
						}
					}
					htmlline += '<tr class = "tabal_01">';
					if (rowItms == false)
					{
						htmlline +='<td width="10%" rowspan="2" style="height: 21px">'+wanName+'</td>';
						rowItms = true;
					}									
					htmlline += '<td width="10%" id ="Table_wan'+j+'_2_table">'+MakeIPContentedStatus(Wan[i],IPProtocolType)+'</td>';
					htmlline += '<td width="10%" id ="Table_wan'+j+'_3_table">'+IPProtocolType+'</td>';
					htmlline += '<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeContentedWanStatus(Wan[i])+'</td>';
					htmlline += '<td width="20%" id ="Table_wan'+j+'_5_table">'+GetIPAddress(Wan[i],ipaddress,IPProtocolType)+'</td>';
					htmlline += '<td width="20%" id ="Table_wan'+j+'_6_table">'+GetDialStatus(Wan[i],IPProtocolType)+'</td>';
					htmlline += '<td width="20%" id ="Table_wan'+j+'_7_table">'+voipstatusvalue+'</td>';
					htmlline += '</tr>';
					j++;	
				}			
			}
			else
			{
				if (Wan[i].ProtocolType == "IPv6")
				{
					voipstatusvalue = "/";
				}
				else
				{
					if (type != "VOIP")
					{
						voipstatusvalue = "/";
					}
					else
					{
						voipstatusvalue = VoipStatus(Wan[i]);
					}
				}		
				htmlline += '<tr class = "tabal_01">';
				htmlline += '<td width="10%" style="height: 21px">'+wanName+'</td>';
				htmlline += '<td width="10%" id ="Table_wan'+j+'_2_table">'+MakeIPContentedStatus(Wan[i],Wan[i].ProtocolType)+'</td>';
				htmlline += '<td width="10%" id ="Table_wan'+j+'_3_table">'+Wan[i].ProtocolType+'</td>';
				htmlline += '<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeContentedWanStatus(Wan[i])+'</td>';
				htmlline += '<td width="20%" id ="Table_wan'+j+'_5_table">'+GetIPAddress(Wan[i],ipaddress,Wan[i].ProtocolType)+'</td>';
				htmlline += '<td width="20%" id ="Table_wan'+j+'_6_table">'+GetDialStatus(Wan[i],Wan[i].ProtocolType)+'</td>';
				htmlline += '<td width="20%" id ="Table_wan'+j+'_7_table">'+voipstatusvalue+'</td>';
				htmlline += '</tr>';					
			}
			document.write(htmlline);	
		}
	}	
}
function MakeIPContentedStatus(wanlist,type)
{
	if (ontPonMode.toUpperCase() == 'GPON')
	{
		if ((ontInfo.Status.toUpperCase() != 'O5') && (ontInfo.Status.toUpperCase() != 'O5AUTH'))
		{
			statusvalue = GetChineseStatus('Disconnected');
		}
		else
		{
			statusvalue = IncludTr069wanStatus(wanlist,type);
		}
	}
	else if (ontPonMode.toUpperCase() =="EPON")
	{
		if (ontEPONInfo !=null)
		{
			if (ontEPONInfo.Status == 'OFFLINE')
			{
				statusvalue = GetChineseStatus('Disconnected')
			}
			else if (ontEPONInfo.Status == 'ONLINE')
			{
				statusvalue = IncludTr069wanStatus(wanlist,type);
			}
			else
			{
				statusvalue = "异常"
			}			
		}
		else
		{
			statusvalue = "异常"
		}
	}
	else if (ontPonMode.toUpperCase() == "GE")
	{
		statusvalue = IncludTr069wanStatus(wanlist,type);
	}
	else
	{
		statusvalue = "异常";
	}
	return 	statusvalue;
}
function IncludTr069wanStatus(wanlist,type)
{
	var statusvalue = ""
	if(wanlist.ServiceList.indexOf("TR069") >= 0)
	{
		if(stInfoStatus == "0")
		{
			statusvalue = GetChineseStatus('Connected');
		}
		else
		{
			statusvalue = GetChineseStatus('Disconnected');
		}
	}
	else
	{
		if (type.toUpperCase() == "IPV6")
		{
			var ipv6Wan = GetIPv6WanInfo(wanlist.MacId);
			if(ipv6Wan.ConnectionStatus.toUpperCase() == "CONNECTED")
			{
				statusvalue = GetChineseStatus('Connected');
			}
			else 
			{
				statusvalue = GetChineseStatus('Disconnected');							
			}
		}
		else
		{
			if(wanlist.Status == "Connected")
			{
				statusvalue = GetChineseStatus('Connected');
			}
			else 
			{
				statusvalue = GetChineseStatus('Disconnected');							
			}	
		}		
	}
	return statusvalue;
}

function GetStatus(Status)
{
	var currentStatus = "";
	if("UNCONFIGURED" == Status.toUpperCase())
	{
		currentStatus = "未配置";
	}
	else if("CONNECTED" == Status.toUpperCase())
	{
		currentStatus = "可用";
	}
	else
	{
		currentStatus = "不可用";
	}
	return currentStatus;
}

function MakeStatus(Wan,type)
{
	var currentStatus = "";
	if("1" != Wan.Enable)
	{
		currentStatus = "未启用";
	}
	else if(ontPonMode == 'gpon' || ontPonMode == 'GPON')
	{
		if ((ontInfo.Status.toUpperCase() != 'O5') && (ontInfo.Status.toUpperCase() != 'O5AUTH'))
		{
			currentStatus = "不可用";
		}
		else
		{
			if((Wan.ServiceList == "TR069") ||(Wan.ServiceList == "TR069_VOIP")||(Wan.ServiceList == "TR069_INTERNET")||(Wan.ServiceList == "TR069_VOIP_INTERNET"))
			{
				if( '0' == stInfoStatus )
				{
					currentStatus = "可用";
				}
				else
				{
					currentStatus = "不可用";
				}
			}
			else
			{
				if("IPv6" == type)
				{
					var ipv6Wan = GetIPv6WanInfo(Wan.MacId);
					currentStatus = GetStatus(ipv6Wan.ConnectionStatus);
				}
				else
				{
					currentStatus = GetStatus(Wan.Status);
				}
			}
		}
	}
	else if (ontPonMode == 'epon' || ontPonMode == 'EPON')
	{
			if (ontEPONInfo != null)
			{
				if (ontEPONInfo.Status == 'OFFLINE')
				{
					currentStatus = "不可用";
				}
				else if (ontEPONInfo.Status == 'ONLINE')
				{
					if((Wan.ServiceList == "TR069") ||(Wan.ServiceList == "TR069_VOIP")||(Wan.ServiceList == "TR069_INTERNET")||(Wan.ServiceList == "TR069_VOIP_INTERNET"))
					{
						if( '0' == stInfoStatus)
						{
							currentStatus = "可用";
						}
						else
						{
							currentStatus = "不可用";
						}
					}
					else
					{
						if("IPv6" == type)
						{
							var ipv6Wan = GetIPv6WanInfo(Wan.MacId);
							currentStatus = GetStatus(ipv6Wan.ConnectionStatus);
						}
						else
						{
							currentStatus = GetStatus(Wan.Status);
						}
					}
				}
				else
				{
					currentStatus = "不可用";
				}
			}
			else
			{
				currentStatus = "不可用";
			}
	}
	else if(ontPonMode == 'ge' || ontPonMode == 'GE' || ontPonMode.toUpperCase() == 'WIFI')
	{
		if((Wan.ServiceList == "TR069") ||(Wan.ServiceList == "TR069_VOIP")||(Wan.ServiceList == "TR069_INTERNET")||(Wan.ServiceList == "TR069_VOIP_INTERNET"))
		{
			if( '0' == stInfoStatus )
			{
				currentStatus = "可用";
			}
			else
			{
				currentStatus = "不可用";
			}
		}
		else
		{
			if("IPv6" == type)
			{
				var ipv6Wan = GetIPv6WanInfo(Wan.MacId);
				currentStatus = GetStatus(ipv6Wan.ConnectionStatus);
			}
			else
			{
				currentStatus = GetStatus(Wan.Status);
			}
		}
	}
	else
	{
		currentStatus = "不可用";
	}
	return currentStatus;
}

function MakeBindPort(Wan,Type)
{
	var currentBindPortInfo = "";
	var WlanBindPortInfo = "";
	var LanBindPortInfo = "";
	var BindPortInfo = Instance_PolicyRoute.GetLanWanBindInfo(domainTowanname(Wan.domain));
	var Wlan = new Array();

	if (BindPortInfo != null && BindPortInfo != undefined)
	{
		var BindPortInfoList = BindPortInfo.PhyPortName.split(",");
		var LanBindPortNumber = 0;
		var WlanBindPortNumber = 0;
        var StbPortInfo = "LAN"+ stbport;
		for(var i = 0; i < BindPortInfoList.length; i++)
		{
            if ((E8CRONGHEFlag == 1) && (stbport > 0) && (StbPortInfo == BindPortInfoList[i].toUpperCase()))
            {
                continue;
            }
        
			if("LAN1" == BindPortInfoList[i].toUpperCase())
			{
				if(isPortInAttrName())
				{
					LanBindPortInfo += getTianYilandesc(1) + "，";	
				}
				else
				{
					LanBindPortInfo += "网口1，";
				}
				LanBindPortNumber++;
			}
			if("LAN2" == BindPortInfoList[i].toUpperCase())
			{
				if(parseInt(TopoInfo.EthNum,10) > 2 && CfgMode.toUpperCase() != 'GZGD')
				{
					LanBindPortInfo += "iTV，";
				}
				else
				{
					LanBindPortInfo += "网口2，";
				}
				LanBindPortNumber++;
			}
			if("LAN3" == BindPortInfoList[i].toUpperCase())
			{
				if(isPortInAttrName())
				{
					LanBindPortInfo += getTianYilandesc(3) + "，";	
				}
				else
				{
					LanBindPortInfo += "网口3，";
				}
				LanBindPortNumber++;
			}
			if("LAN4" == BindPortInfoList[i].toUpperCase())
			{
				if(isPortInAttrName())
				{
					LanBindPortInfo += getTianYilandesc(4) + "，";	
				}
				else
				{
					LanBindPortInfo += "网口4，";
				}
				LanBindPortNumber++;
			}
			if (BinWord.toUpperCase() == 'A8C') {
				if(BindPortInfoList[i].toUpperCase() == "LAN5") {
					if(isPortInAttrName()) {
						LanBindPortInfo += getTianYilandesc(4) + "，";	
					} else {
						LanBindPortInfo += "网口5，";
					}
					LanBindPortNumber++;
				}
				if(BindPortInfoList[i].toUpperCase() == "LAN6") {
					if(isPortInAttrName()) {
						LanBindPortInfo += getTianYilandesc(6) + "，";	
					} else {
						LanBindPortInfo += "网口6，";
					}
					LanBindPortNumber++;
				}
				if(BindPortInfoList[i].toUpperCase() == "LAN7") {
					if(isPortInAttrName()) {
						LanBindPortInfo += getTianYilandesc(7) + "，";	
					} else {
						LanBindPortInfo += "网口7，";
					}
					LanBindPortNumber++;
				}
				if(BindPortInfoList[i].toUpperCase() == "LAN8") {
					if(isPortInAttrName()) {
						LanBindPortInfo += getTianYilandesc(8) + "，";	
					} else {
						LanBindPortInfo += "网口8，";
					}
					LanBindPortNumber++;
				}
			}

			if("SSID1" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.1,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}
			if("SSID2" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.2,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}
			if("SSID3" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.3,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}
			if("SSID4" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.4,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}
			if("SSID5" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.5,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}
			if("SSID6" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.6,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}
			if("SSID7" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.7,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}
			if("SSID8" == BindPortInfoList[i].toUpperCase())
			{
				Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.8,Enable|Name|SSID,stWlanInfo);%>;
				if(Wlan.length - 1 > 0)
				{
					WlanBindPortInfo += Wlan[0].ssid + qos_language['bbsp_comma'];
					WlanBindPortNumber++;
				}
			}

		}
		LanBindPortInfo = LanBindPortInfo.substring(0,LanBindPortInfo.lastIndexOf('，'));
		
		if( stbport > 0)
		{
			var PortInfo = "网口"+ stbport;
			var iTVID = "iTV";
			LanBindPortInfo = LanBindPortInfo.replace(PortInfo,"内置STB");
			LanBindPortInfo = LanBindPortInfo.replace(iTVID,"网口2");
		}
		
		WlanBindPortInfo = WlanBindPortInfo.substring(0,WlanBindPortInfo.lastIndexOf('，'));
		if(("INTERNET" == Type) || ("SERVICE" == Type) || (("OTHER" == Type) && (WlanBindPortNumber > 0)))
		{
			if(LanBindPortNumber > 0)
			{
				currentBindPortInfo = "有线：" + LanBindPortInfo;
			}
			if(WlanBindPortNumber > 0)
			{
				if(LanBindPortNumber > 0)
				{
					currentBindPortInfo = currentBindPortInfo + "<br>";
				}
				currentBindPortInfo = currentBindPortInfo + "无线：" + htmlencode(WlanBindPortInfo);
			}
		}
		else if("OTHER" == Type)
		{
			currentBindPortInfo = LanBindPortInfo;
		}
		else
		{
			currentBindPortInfo = "";
		}
		
    }
	else
	{
		currentBindPortInfo = "";
	}
	
	if("VOIP" == Type)
	{
		var VoipSupport = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
		if (1==VoipSupport)
			currentBindPortInfo = "电话";
		else
			currentBindPortInfo = "";
	}

	return currentBindPortInfo;
}


function JumpToPage1()
{
	top.Frame.changeMenuShow('Menu1_Network','Menu2_Net_Network','Menu3_NN_WAN');
}

function JumpToPage2()
{
	top.Frame.changeMenuShow('Menu1_Status','Menu2_Sta_Overview','Menu3_SO_Wizard');
}

function IsPonOnline()
{
	if (ontPonMode.toUpperCase() != 'GPON' && ontPonMode.toUpperCase() != 'EPON') return true;
	if (ontPonMode.toUpperCase() == 'GPON' && ontInfo.Status.toUpperCase() == 'O5')  return true;
	if (ontPonMode.toUpperCase() == 'GPON' && ontInfo.Status.toUpperCase() == 'O5AUTH')  return true;
	if (ontPonMode.toUpperCase() == 'EPON' && ontEPONInfo.Status.toUpperCase() == 'ONLINE') return true;
	return false;
}

function OltRegStatusInfo()
{
	if (1 == ontMatchOLTStatus && RevOptic != "--")
	{
		document.write("OLT与ONT不匹配，请更换ONT");
	}
	else
	{
		if (ontPonMode == 'gpon' || ontPonMode == 'GPON')
		{
			if ('1' == ontLedMode)
			{
				if (ontInfo.Status == 'o5AUTH' || ontInfo.Status == 'O5AUTH')
				{
					document.write("失败 - 已注册未认证（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
				else if (ontInfo.Status == 'o5' || ontInfo.Status == 'O5')
				{
					document.write("成功 - 已注册已认证");
				}
				else
				{
					document.write("失败 - 未注册未认证（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
			}
			else
			{
				if (ontInfo.Status == 'o1' || ontInfo.Status == 'O1')
				{
					document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
				else if (ontInfo.Status == 'o2' || ontInfo.Status == 'O2')
				{
					document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
				else if (ontInfo.Status == 'o3' || ontInfo.Status == 'O3')
				{
					document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
				else if (ontInfo.Status == 'o4' || ontInfo.Status == 'O4')
				{
					document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
				else if (ontInfo.Status == 'o5' || ontInfo.Status == 'O5')
				{
					document.write("注册正常");
				}
				else if (ontInfo.Status == 'o6' || ontInfo.Status == 'O6')
				{
					document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
				else if (ontInfo.Status == 'o7' || ontInfo.Status == 'O7')
				{
					document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
				}
				else
				{
					document.write('');
				}
			}
		}
		else if (ontPonMode == 'epon' || ontPonMode == 'EPON')
		{
			if (ontEPONInfo != null)
			{
				if ('1' == ontLedMode)
				{
					if ( "OFFLINE" == ontEPONInfo.Status)
					{
						document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
					}
					else if("ONLINE" == ontEPONInfo.Status)
					{
						document.write("注册正常");
					}
					else
					{
						document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
					}
				}
				else
				{
					if ( "OFFLINE" == ontEPONInfo.Status)
					{
						document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
					}
					else if("ONLINE" == ontEPONInfo.Status)
					{
						document.write("注册正常");
					}
					else
					{
						document.write("注册失败（请检查收光功率或确认宽带识别码（LOID）是否正确）");
					}
				}
			}
			else
			{
				document.write('');
			}
		}
		else
		{
			document.write('');
		}
	}
}

function ONTRegStatusInfo()
{
	if (1 == ontMatchOLTStatus && RevOptic != "--")
	{
		document.write("OLT与ONT不匹配，请更换ONT");
	}
	else
	{
		if (ontPonMode == 'gpon' || ontPonMode == 'GPON')
		{
		    if (1 == '<%HW_WEB_GetFeatureSupport(AMP_FT_SPECIAL_AUTH_SHOW);%>')
            {
	            if (losStatus == 1)
	            {
	                document.write("失败 - 未注册未认证。");
	            }
	            else if (ontInfo.Status == 'o5' || ontInfo.Status == 'O5')
	            {
	                document.write("成功 - 已注册已认证。");
	            }
	            else if ((RxThresStatus == 1) && (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_RX_EXTEND_LED);%>'))
	            {
	                document.write("失败 - 未注册未认证。");
	            }
	            else
	            {
	                document.write("失败 - 已注册未认证。");
	            }
	        }
			else if ('1' == ontLedMode)
			{
				if (ontInfo.Status == 'o5AUTH' || ontInfo.Status == 'O5AUTH')
				{
					document.write("失败 - 已注册未认证。");
				}
				else if (ontInfo.Status == 'o5' || ontInfo.Status == 'O5')
				{
					document.write("成功 - 已注册已认证。");
				}
				else
				{
					document.write("失败 - 未注册未认证。");
				}
			}
			else
			{
				if (ontInfo.Status == 'o1' || ontInfo.Status == 'O1')
				{
					document.write(htmlencode(ontInfo.Status)+' (Initial state)');
				}
				else if (ontInfo.Status == 'o2' || ontInfo.Status == 'O2')
				{
					document.write(htmlencode(ontInfo.Status)+' (Standby state)');
				}
				else if (ontInfo.Status == 'o3' || ontInfo.Status == 'O3')
				{
					document.write(htmlencode(ontInfo.Status)+' (Serial-Number state)');
				}
				else if (ontInfo.Status == 'o4' || ontInfo.Status == 'O4')
				{
					document.write(htmlencode(ontInfo.Status)+' (Ranging state)');
				}
				else if (ontInfo.Status == 'o5' || ontInfo.Status == 'O5')
				{
					document.write(htmlencode(ontInfo.Status)+' (Operation state)');
				}
				else if (ontInfo.Status == 'o6' || ontInfo.Status == 'O6')
				{
					document.write(htmlencode(ontInfo.Status)+' (POPUP state)');
				}
				else if (ontInfo.Status == 'o7' || ontInfo.Status == 'O7')
				{
					document.write(htmlencode(ontInfo.Status)+' (Emergency-Stop state)');
				}
				else
				{
					document.write('');
				}
			}
		}
		else if (ontPonMode == 'epon' || ontPonMode == 'EPON')
		{
			if (ontEPONInfo != null)
			{
			    if (1 == '<%HW_WEB_GetFeatureSupport(AMP_FT_SPECIAL_AUTH_SHOW);%>')
	            {
	                if (losStatus == 1)
	                {
	                    document.write("失败 - 未注册未认证。");
	                }
	                else if ("ONLINE" == ontEPONInfo.Status)
	                {
	                    document.write("成功 - 已注册已认证。");
	                }
	                else if ((RxThresStatus == 1) && (1 == '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_RX_EXTEND_LED);%>'))
	                {
	                    document.write("失败 - 未注册未认证。");
	                }
	                else
	                {
	                    document.write("失败 - 已注册未认证。");
	                }
	            }
				else if ('1' == ontLedMode)
				{
					if ("ONLINE AUTHING" == ontEPONInfo.Status)
					{
						document.write("失败 - 已注册未认证。");
					}
					else if("ONLINE" == ontEPONInfo.Status)
					{
						document.write("成功 - 已注册已认证。");
					}
					else
					{
						document.write("失败 - 未注册未认证。");
					}
				}
				else
				{
					if ( "OFFLINE" == ontEPONInfo.Status)
					{
						document.write("未注册，未授权。");
					}
					else if("ONLINE" == ontEPONInfo.Status)
					{
						document.write("已注册，已授权。");;
					}
					else
					{
						document.write("已注册，未授权。");
					}
				}
			}
			else
			{
				document.write('');
			}
		}
		else
		{
			document.write('');
		}
	}
}


function IsStaticIP(wanTemp)
{
	return wanTemp.IPv4AddressMode.toUpperCase() == "STATIC";
}

function LoadFrame()
{	
	if (IsZQ == 1) {
		setDisplay("wifikey", 0);
		setDisplay("5gwifikey", 0);
	}
	if (1 == ctCustomVer)
	{
		setDisplay("Table_base7_0_table", 1);
		setDisplay("Table_base6_3_table", 1);
		setDisplay("Table_base6_6_table", 1);
	}
	
	if (1 == MngtGsct && curUserType == '0')
	{
		setDisplay("Div_HardwareInfo", 1);
	}
	else
	{
		setDisplay("Div_HardwareInfo", 0);
	}
	
	if ( 1 == MngtFjct || 1 == MngtScct || 1 == MngtCqct)
	{
		setDisplay("Div_BusinessInfo", 0);
		setDisplay("Div_Special_BusinessInfo", 1);
	}
	else
	{
		setDisplay("Div_BusinessInfo", 1);
		setDisplay("Div_Special_BusinessInfo", 0);
	}
	
	if ('1' == DoubleFreqFlag)
	{
		setDisplay("area_5g", 1);
	}
	
	if('0' == isSupportOptic)
	{
		setDisplay("oltauth", 0);
		setDisplay("PonInfo", 0);
	}

}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<div class="func_title">设备基本信息</div>

<table id="table_devicetype" width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg">
<tr>
<td class="table_title" width="25%" align="left" id="Table_base1_1_table" name="Table_base1_1_table">设备类型:&nbsp;</td>
<td class="table_right" width="75%" id="Table_base1_2_table" name="Table_base1_2_table">
<script type="text/javascript" language="javascript">
if ('1' == IsRhGateway)
{
	if ('1' == IsLAN)
	{
		document.write('以太网上行融合智能终端');
	}
	
	else
	{
		if (1 == E8CRONGHEFlag)
		{
			if (ontPonMode.toUpperCase() == 'GPON')
			{
				document.write('GPON宽带融合终端');
			}
			else
			{
				document.write('EPON宽带融合终端'); 
			}
		}
		else
		{
			if (ontPonMode.toUpperCase() == 'GPON')
			{
				document.write('GPON上行融合智能终端');
			}
			else
			{
				document.write('EPON上行融合智能终端'); 
			}
		}
	}
}
else if (deviceInfo != null)
{
	if( MngtYnct == 1 )
	{
		document.write(htmlencode(deviceInfo.DeviceType));
	}
	else
	{
		document.write(htmlencode(deviceInfo.AccessType));
	}
}
else
{
	document.write('');
}
</script>
</td>
</tr>
<script type="text/javascript" language="javascript">
if (MngtYnct == 1)
{
	document.write('<tr>');
	document.write('<td  class="table_title" width="25%" align="left" id="td2_1" name="td2_1">设备接入类型:&nbsp;</td>');
	document.write('<td class="table_right" width="75%" id="td2_2" name="td2_2">');
	if (deviceInfo != null)
	{
		document.write(htmlencode(deviceInfo.AccessType));
	}
	else
	{
		document.write('');
	}
	document.write('</td></tr>');
}
</script>
<tr>
<td class="table_title" width="25%" align="left" id="Table_base2_1_table" name="Table_base2_1_table">生产厂家:&nbsp;</td>
<script>
	tdHtml = jiuzhouFlag == "1" ? "九洲电器" : "华为";
	document.write('<td class="table_right" width="75%" id="Table_base2_2_table" name="Table_base2_2_table">' + tdHtml + '</td>');
</script>
</tr>

<tr>
<td class="table_title" width="25%" align="left" id="Table_base3_1_table" name="Table_base3_1_table">设备型号:&nbsp;</td>
<td class="table_right" width="75%" id="Table_base3_2_table" name="Table_base3_2_table">
<script language="javascript">
if (deviceInfo != null)
{
	document.write(htmlencode(deviceInfo.ModelName));
}
else
{
	document.write('');
}
</script>
</td>
</tr>
<tr>
<td class="table_title" width="25%" align="left" id="Table_base4_1_table" name="Table_base4_1_table">设备标识号:&nbsp;</td>
<td class="table_right" width="75%" id="Table_base4_2_table" name="Table_base4_2_table"> <script language="javascript">
	var stbOUI = Stbid.substr(6,6);
	if(IsInformStbid == 1 && stbOUI != "")
	{
		document.write(htmlencode(stbOUI) + '-' +htmlencode(Stbid));
	}
	else if(deviceInfo.specsn !='')
	{
		document.write(htmlencode(deviceInfo.ManufacturerOUI) + '-' +htmlencode(deviceInfo.specsn));
	}
	else
	{
		document.write(htmlencode(deviceInfo.ManufacturerOUI) + '-' +htmlencode(deviceInfo.SerialNumber));
	}
</script> </td>
</tr>

<tr>
<td class="table_title" align="left" id="Table_base5_1_table" name="Table_base5_1_table">硬件版本:&nbsp;</td>
<td class="table_right" id="Table_base5_2_table" name="Table_base5_2_table">
<script language="javascript">
	if (deviceInfo != null)
	{
		document.write(htmlencode(deviceInfo.HardwareVersion));
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>
<tr>
	<td class="table_title" align="left" id="Table_base6_1_table" name="Table_base6_1_table">软件版本:&nbsp;</td>
	<td class="table_right" id="Table_base6_2_table" name="Table_base6_2_table"> <script language="javascript">
	if (deviceInfo != null)
	{
		var softwareVersion = (jiuzhouFlag == '1') ? deviceInfo.SoftwareVersion.replace("HW", "JZ") : deviceInfo.SoftwareVersion;
		document.write(softwareVersion);
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

<tr id="Table_base6_3_table" name="Table_base6_3_table" style="display:none">
	<td class="table_title" align="left" id="Table_base_4" name="Table_base_4">内部软件版本:&nbsp;</td>
	<td class="table_right" id="Table_base6_5_table" name="Table_base6_5_table"> <script language="javascript">
	document.write(htmlencode(softversion));
</script> </td>
</tr>

<tr id="Table_base6_6_table" name="Table_base6_6_table" style="display:none">
	<td class="table_title" align="left" id="Table_base_7" name="Table_base_7">版本编译时间:&nbsp;</td>
	<td class="table_right" id="Table_base6_8table" name="Table_base6_8_table"> <script language="javascript">
	if (deviceInfo != null)
	{
	  var str = deviceInfo.ReleaseTime;
		str = str.toString().replace(/-/g,"/");
		str = str.toString().replace(/_/g,"/ ");
		document.write(htmlencode(str));
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

<tr id="Table_base7_0_table" name="Table_base7_0_table" style="display:none">
	<td class="table_title" align="left" id="Table_base7_1_table" name="Table_base7_1_table">软件大小:&nbsp;</td>
	<td class="table_right" id="Table_base7_2_table" name="Table_base7_2_table">
		<script language="javascript">
			if (deviceInfo != null)
			{
				if (deviceInfo.ImageSize != 0)
				{
					document.write(parseInt(deviceInfo.ImageSize/1024) + " KB（" + deviceInfo.ImageSize + " 字节）");
				}
				else
				{
					document.write("16185 KB（16573544 字节）");
				}
			}
			else
			{
				document.write('');
			}
		</script>
	</td>
</tr>

<script type="text/javascript" language="javascript">
if (MngtJsct == 1 || MngtSzct == 1)
{
  document.write('<tr>');
  document.write('<td class="table_title" width="25%" align="left" id="td8_1" name="td8_1">版本发布时间:&nbsp;</td>');
  document.write('<td class="table_right" width="75%" id="td8_2" name="td8_2">');
  if (deviceInfo != null)
  {
	   document.write(htmlencode(deviceInfo.ReleaseTime));
  }
  else
  {
	   document.write('');
  }
  document.write('</td></tr>');
}
</script>
<script type="text/javascript" language="javascript">
if ('1' != IsLAN)
{
	document.write('<tr>');
	if ( 1 == MngtFjct || 1 == MngtScct || 1 == MngtCqct)
	{
		document.write('<td class="table_title" align="left" id="td9_1" name="td9_1">OLT注册状态:&nbsp;</td>');
		document.write('<td class="table_right" id="td9_1" name="td9_2">');
		OltRegStatusInfo();
	}
	else
	{
		document.write('<td class="table_title" align="left" id="td9_1" name="td9_1">ONT注册状态:&nbsp;</td>');
		document.write('<td class="table_right" id="td9_1" name="td9_2">');
		ONTRegStatusInfo();
	}
}
</script>
</td>
</tr>

<script type="text/javascript" language="javascript">
if ( 1 == MngtFjct || 1 == MngtScct || 1 == MngtCqct)
{
	document.write('<tr>');
	document.write('<td  class="table_title" align="left" id="td10_1" name="td10_1">ITMS注册状态:&nbsp;</td>');
	document.write('<td class="table_right" id="td10_2" name="td10_2">');
	if( (parseInt(Infos.Status) == 99) && (parseInt(Infos.Result) == 99))
	{
		document.write('未注册');
	}
	else if(IsPonOnline())
	{
		if( (parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 0))
		{
			document.write('注册成功');
		}
		else if ((((parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 1)) || (parseInt(Infos.Status) == 5) ) )
		{
			document.write('注册成功');
		}
		else
		{
			document.write('注册失败');
		}
	}
	else
	{
		document.write('注册失败');
	}
	document.write('</td></tr>');
}
</script>

 <script type="text/javascript" language="javascript">
     var opticThresholdMin;	 
     if( 1 == MngtFjct)
     {
	    opticThresholdMin = -24;
	 }
	 else
	 {
	    opticThresholdMin = -27;
	 }
	 if (1 != IsLAN)
	 {
		if (1 == MngtFjct || 1 == MngtScct || 1 == MngtCqct)
		 {
			document.write('<tr>');
			document.write('<td  class="table_title" align="left" id="td11_1" name="td11_1">接收光功率:&nbsp;</td>');
			document.write('<td class="table_right" id="td11_2" name="td11_2">');
			if(RevOptic == null)
			{
				document.write('<font color="#ff0000">光功率过低，请检查光路或ODF是否有接错</font>');
			}
			else
			{
				if(RevOptic < opticThresholdMin)
				{
					document.write('<font color="#ff0000">光功率过低，请检查光路或ODF是否有接错</font>');
				}
				else if(RevOptic == "--")
				{
					document.write('<font color="#ff0000">光纤插接不正常，请检查光路或ODF是否有接错</font>');
				}
				else
				{
					document.write(htmlencode(RevOptic)+'dBm');
				}
			}
			document.write('</td></tr>');
		 }
	 }
	 
</script>

<script type="text/javascript" language="javascript">
if (1 != IsLAN)
{
	if ( 1 != MngtFjct && 1 != MngtScct && 1 != MngtCqct)
	{
		if (ontPonMode == 'gpon' || ontPonMode == 'GPON')
		{
			document.write('<tr id="tr12" name="tr12">');
			document.write('<td  class="table_left" align="left" id="tr12_1" name="tr12_1">ONT ID:&nbsp;</td>');
			document.write('<td  class="table_right" id="tr12_2" name="tr12_2">');
			if (ontInfo != null)
			{
				document.write(htmlencode(ontInfo.ONTID));
			}
			else
			{
				document.write('');
			}
			document.write('</td></tr>');
		}
	}
}
</script>
</table>

<div id="Div_HardwareInfo">
<div class="func_spread"></div>
<div class="func_title">硬件参数</div>

<table id="table_hardwareInfo" width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg">

<tr>
<td class="table_title" width="25%" align="left" id="Table_hardware1_1_table" name="Table_hardware1_1_table">硬件版本:&nbsp;</td>
<td class="table_right" width="75%" id="Table_hardware1_2_table" name="Table_hardware1_2_table">
<script language="javascript">
	if (deviceInfo != null)
	{
		document.write(htmlencode(deviceInfo.HardwareVersion));
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

<tr>
<td class="table_title" align="left" id="Table_hardware2_1_table" name="Table_hardware2_1_table">操作系统:&nbsp;</td>
<td class="table_right" id="Table_hardware2_2_table" name="Table_hardware2_2_table">
<script language="javascript">
	if (deviceInfo != null)
	{
		document.write(htmlencode(deviceInfo.SysVersion));
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

<tr>
<td class="table_title" align="left" id="Table_hardware4_1_table" name="Table_hardware4_1_table">CPU主频:&nbsp;</td>
<td class="table_right" id="Table_hardware4_2_table" name="Table_hardware4_2_table">
<script language="javascript">
	if (deviceInfo != null)
	{
		document.write(htmlencode(deviceInfo.CpuFrequence) + "MHz");
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

<tr>
<td class="table_title" align="left" id="Table_hardware5_1_table" name="Table_hardware5_1_table">CPU核数:&nbsp;</td>
<td class="table_right" id="Table_hardware5_2_table" name="Table_hardware5_2_table">
<script language="javascript">
	var tempInfoList = DevInfoDes["s2017"].split(",");
	if (deviceInfo != null)
	{
		if (deviceInfo.ProcessorNumberOfEntries < tempInfoList.length)
		{
			document.write(tempInfoList[deviceInfo.ProcessorNumberOfEntries - 1]);
		}
		else
		{
			document.write(tempInfoList[tempInfoList.length - 1]);
		}
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

<tr>
<td class="table_title" align="left" id="Table_hardware6_1_table" name="Table_hardware6_1_table">内存:&nbsp;</td>
<td class="table_right" id="Table_hardware6_2_table" name="Table_hardware6_2_table">
<script language="javascript">
	if (deviceInfo != null)
	{
		document.write(htmlencode(deviceInfo.Memtotal) + "MB");
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

<tr>
<td class="table_title" align="left" id="Table_hardware7_1_table" name="Table_hardware7_1_table">flash:&nbsp;</td>
<td class="table_right" id="Table_hardware7_2_table" name="Table_hardware7_2_table">
<script language="javascript">
	if (deviceInfo != null)
	{
		document.write(htmlencode(deviceInfo.Flashtotal) + "MB");
	}
	else
	{
		document.write('');
	}
</script> </td>
</tr>

</table>
</div>

<div class="func_spread"></div>
<div id="PonInfo">
<div class="func_title">PON信息</div>
<script type="text/javascript" language="javascript">


var GUIDE_NULL = "--";
var GUIDE_OPEN = "开启";
var GUIDE_CLOSE = "关闭";


function GetLinkState()
{
	var State = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>;

	if (State == 1 || State == "1")
	{
		return "已连接";
	}
	else
	{
		return "未连接";
	}
}

function GetAccessMode() {
	var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
	if (ontPonMode == 'gpon' || ontPonMode == "GPON") {
		return "GPON";
	} else if (ontPonMode == 'epon' || ontPonMode == "EPON") {
		return "EPON";
	} else {
		return "ETHERNET";
	}
}

function GetLinkTime()
{
	var LinkTime = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.EPONLinkInfo.PONLinkTime);%>';
	var LinkDesc;

	LinkDesc = parseInt(LinkTime/3600) + "小时" + parseInt((LinkTime%3600)/60) + "分钟" + parseInt(((LinkTime%3600)%60)) + "秒";
	if (GetLinkState() == "未连接")
	{
		LinkDesc = GUIDE_NULL;
	}

	return LinkDesc;
}
</script>

<table id="table_poninfo" width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg">
	<tr>
		<td class="table_left"  width="25%" id="Table_pon1_1_table" name="Table_pon1_1_table">线路协议:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_pon1_2_table" name="Table_pon1_2_table">
		<script type="text/javascript" language="javascript">document.write(deviceInfo.AccessType.toUpperCase());</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_pon2_1_table" name="Table_pon2_1_table">连接状态:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_pon2_2_table" name="Table_pon2_2_table">
		<script type="text/javascript" language="javascript">document.write(GetLinkState());</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_pon3_1_table" name="Table_pon3_1_table">连接时间:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_pon3_2_table" name="Table_pon3_2_table">
		<script type="text/javascript" language="javascript">document.write(GetLinkTime());</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_pon4_1_table" name="Table_pon4_1_table">发送光功率:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_pon4_2_table" name="Table_pon4_2_table">
		<script type="text/javascript" language="javascript">document.write(TransOptic+"dBm");</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_pon5_1_table" name="Table_pon5_1_table">接收光功率:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_pon5_2_table" name="Table_pon5_2_table">
		<script type="text/javascript" language="javascript">document.write(RevOptic+"dBm");</script>
		</td>
	</tr>
</table>
</div>

<div class="func_spread"></div>
<div class="func_title">网关注册信息</div>

<table id="table_loidreg" width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg">
<tr>
<td class="table_title" width="25%" align="left" id="Table_reg1_1_table" name="Table_reg1_1_table">宽带识别码（LOID）:&nbsp;</td>
<td class="table_right" width="75%" id="Table_reg1_2_table" name="Table_reg1_2_table">
<script type="text/javascript" language="javascript">document.write(htmlencode(LoidPwdInfo.Loid));</script>
</td>
</tr>
<tr id="oltauth">
<td class="table_title" width="25%" align="left" id="Table_reg2_1_table" name="Table_reg2_1_table">光路（OLT）认证:&nbsp;</td>
<td class="table_right" width="75%" id="Table_reg2_2_table" name="Table_reg2_2_table">
<script type="text/javascript" language="javascript">
if(RevOptic == "--")
{
	document.write('光纤未连接');
}
else
{
	if (ontPonMode.toUpperCase() == 'GPON')
	{
		if (ontInfo.Status.toUpperCase() == 'O5')
		{
			document.write('认证成功');
		}
		else
		{
			document.write('认证失败');
		}
	}
	else if (ontPonMode.toUpperCase() == 'EPON')
	{
		if (ontEPONInfo.Status.toUpperCase() =="ONLINE" )
		{
			document.write('认证成功');
		}
		else
		{
			document.write('认证失败');
		}
	}
	else
	{
		document.write('认证失败');
	}

}
</script>
</td>
</tr>
<tr>
<td class="table_title" width="25%" align="left" id="Table_reg3_1_table" name="Table_reg3_1_table">管理（ITMS）注册:&nbsp;</td>
<td class="table_right" width="75%" id="Table_reg3_2_table" name="Table_reg3_2_table">
<script type="text/javascript" language="javascript">

if( (parseInt(Infos.Status) == 99) && (parseInt(Infos.Result) == 99))
{
	document.write('未注册');
}
else if(IsPonOnline())
{
	if( (parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 0))
	{
		document.write('注册成功');
	}
	else if ((((parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 1)) || (parseInt(Infos.Status) == 5) ) )
	{
		document.write('注册成功');
	}
	else
	{
		if (('SHXCNCATV' == CfgMode.toUpperCase()) && (parseInt(Infos.Status) == 97) && (parseInt(Infos.Result) == 1))
		{
			document.write('注册成功');
		}
		else
		{
			document.write('注册失败');
		}
	}
}
else
{
	document.write('注册失败');
}

</script>
</td>
</tr>
</table>

<div class="func_spread"></div>
<div class="func_title">业务信息</div>

<div id="Div_BusinessInfo" style="display:none">
	<script type="text/javascript" language="javascript">
		document.write('<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" id="Table_wan_table">');
		document.write('<tr class="head_title">');
		document.write('<td width="10%" id="Table_wan0_1_table">业务类型</td>');
		document.write('<td id="Table_wan0_2_table">状态</td>');
		document.write('<td id="Table_wan0_3_table">IP协议</td>');
		document.write('<td id="Table_wan0_4_table">连接方式</td>');
		document.write('<td id="Table_wan0_5_table">可用端口</td>');
		document.write('<td id="Table_wan0_6_table">连接名称</td>');
		document.write('</tr>');


		if( 0 == Wan.length )
		{
			document.write("<tr class=\"tabal_center01\">");
			document.write('<td width="10%">--</td>');
			document.write('<td width="10%">--</td>');
			document.write('<td width="10%">--</td>');
			document.write('<td width="10%">--</td>');
			document.write('<td width="20%">--</td>');
			document.write('<td width="20%">--</td>');
			document.write("</tr>");
		}

		var InternetNumber = 0;
		var iTVNumber = 0;
		var VoipNumber = 0;
		var ItmsNumber = 0;
		var ServiceNumber = 0;
		for (i = 0;i < Wan.length;i++)
		{
			if(Wan[i].ServiceList.indexOf("INTERNET") >= 0)
			{
				InternetNumber++;
			}
			if(Wan[i].ServiceList.indexOf("OTHER") >= 0)
			{
				iTVNumber++;
			}
			if(Wan[i].ServiceList.indexOf("VOIP") >= 0)
			{
				VoipNumber++;
			}
			if(Wan[i].ServiceList.indexOf("TR069") >= 0)
			{
				ItmsNumber++;
			} 
			if(Wan[i].ServiceList.indexOf("SERVICE") >= 0)
			{
				ServiceNumber++;
			}
						
		}
		var j = 1;
		if(0 != InternetNumber)
		{
			var rowInternet = false;
			var WanMacId = 0;
			var url1 = "";
			var url2 = "";
			for (i = 0;i < Wan.length;i++)
			{
                var idPrefix = getElementId(domainTowanname(Wan[i].domain));
				rowInternet = false;

				if(Wan[i].ServiceList.indexOf("INTERNET") >= 0)
				{
					WanMacId = Wan[i].MacId;
					url1 = '../../bbsp/wan/wane8c.asp?' + WanMacId;
					url2 = '../cfgguide/cfgwizard.asp?' + WanMacId;
					if("IPv4/IPv6" == Wan[i].ProtocolType) 
					{
						for(var k = 0;k < 2;k++)
						{
							var IPProtocolType = (false == rowInternet)?"IPv4":"IPv6";
							var IPStatus = (false == rowInternet)?MakeStatus(Wan[i],"IPv4"):MakeStatus(Wan[i],"IPv6");
							document.write('<tr class = \"tabal_01\">');
							if(false == rowInternet)
							{
								if(curUserType == '0')
								{
									document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_admin_table" ><a onclick = "JumpToPage1();"  href="'+url1+'">'+ GetServLang('internet') + '</a></td>');
								}
								else
								{
									if("可用" == MakeStatus(Wan[i],"IPv4") && "可用" == MakeStatus(Wan[i],"IPv6"))
									{
										document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_user_table" >'+ GetServLang('internet') + '</td>');
									}
									else
									{
										document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_user_table" ><a onclick = "JumpToPage2();"  href="'+url2+'">'+ GetServLang('internet') + '</a></td>');
									}
								}
								rowInternet = true;
							}
							document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+IPStatus+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+IPProtocolType+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"INTERNET")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="INTERNET">'+MakeBindPort(Wan[i],"INTERNET")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
							document.write('</tr>');
							j++;
						}
					}
					else
					{
						document.write('<tr class = \"tabal_01\">');

						if(curUserType == '0')
						{
							document.write('<td width="10%" id ="Table_wan'+j+'_1_admin_table" ><a onclick = "JumpToPage1();"  href="'+url1+'">'+ GetServLang('internet') + '</a></td>');
						}
						else
						{
							if("可用" == MakeStatus(Wan[i],Wan[i].ProtocolType))
							{
								document.write('<td width="10%" id ="Table_wan'+j+'_1_user_table" >'+ GetServLang('internet') + '</td>');
							}
							else
							{
								document.write('<td width="10%" id ="Table_wan'+j+'_1_user_table" ><a onclick = "JumpToPage2();"  href="'+url2+'">'+ GetServLang('internet') + '</a></td>');
							}
						}

						document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+MakeStatus(Wan[i],Wan[i].ProtocolType)+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+Wan[i].ProtocolType+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"INTERNET")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="INTERNET">'+MakeBindPort(Wan[i],"INTERNET")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
						document.write('</tr>');
						j++;
					}
				}
			}
		}

		if(0 != iTVNumber)
		{
			var rowiTV = false;
			for (i = 0;i < Wan.length;i++)
			{
                var idPrefix = getElementId(domainTowanname(Wan[i].domain));
				rowiTV = false;
				if(Wan[i].ServiceList.indexOf("OTHER") >= 0)
				{
					if("IPv4/IPv6" == Wan[i].ProtocolType)
					{
						for(var k = 0;k < 2;k++)
						{
							var IPProtocolType = (false == rowiTV)?"IPv4":"IPv6";
							var IPStatus = (false == rowiTV)?MakeStatus(Wan[i],"IPv4"):MakeStatus(Wan[i],"IPv6");
							document.write('<tr class = \"tabal_01\">');
							if(false == rowiTV)
							{
								document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_table">'+ GetServLang('other') + '</td>');
								rowiTV = true;
							}
							document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+IPStatus+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+IPProtocolType+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"OTHER")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="OTHER">'+MakeBindPort(Wan[i],"OTHER")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
							document.write('</tr>');
							j++;
						}
					}
					else
					{
						document.write('<tr class = \"tabal_01\">');
						document.write('<td width="10%" id ="Table_wan'+j+'_1_table">'+ GetServLang('other') + '</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+MakeStatus(Wan[i],Wan[i].ProtocolType)+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+Wan[i].ProtocolType+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"OTHER")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="OTHER">'+MakeBindPort(Wan[i],"OTHER")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
						document.write('</tr>');
						j++;
					}
				}
			}
		}

		if(0 != VoipNumber)
		{
			var rowVoip = false;
			for (i = 0;i < Wan.length;i++)
			{
                var idPrefix = getElementId(domainTowanname(Wan[i].domain));
				rowVoip = false;
				if(Wan[i].ServiceList.indexOf("VOIP") >= 0)
				{
					if("IPv4/IPv6" == Wan[i].ProtocolType)
					{
						for(var k = 0;k < 2;k++)
						{
							var IPProtocolType = (false == rowVoip)?"IPv4":"IPv6";
							var IPStatus = (false == rowVoip)?MakeStatus(Wan[i],"IPv4"):MakeStatus(Wan[i],"IPv6");
							document.write('<tr class = \"tabal_01\">');
							if(false == rowVoip)
							{
								document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_table">'+ GetServLang('voip') + '</td>');
								rowVoip = true;
							}
							document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+IPStatus+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+IPProtocolType+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"VOIP")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="VOIP">'+MakeBindPort(Wan[i],"VOIP")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
							document.write('</tr>');
							j++;
						}
					}
					else
					{
						document.write('<tr class = \"tabal_01\">');
						document.write('<td width="10%" id ="Table_wan'+j+'_1_table">'+ GetServLang('voip') + '</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+MakeStatus(Wan[i],Wan[i].ProtocolType)+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+Wan[i].ProtocolType+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"VOIP")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="VOIP">'+MakeBindPort(Wan[i],"VOIP")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
						document.write('</tr>');
						j++;
					}
				}
			}
		}
		
		if(0 != ItmsNumber)
		{
			var rowItms = false;
			for (i = 0;i < Wan.length;i++)
			{
                var idPrefix = getElementId(domainTowanname(Wan[i].domain));
				rowItms = false;
				if(Wan[i].ServiceList.indexOf("TR069") >= 0)
				{
					if("IPv4/IPv6" == Wan[i].ProtocolType)
					{
						for(var k = 0;k < 2;k++)
						{
							var IPProtocolType = (false == rowItms)?"IPv4":"IPv6";
							var IPStatus = (false == rowItms)?MakeStatus(Wan[i],"IPv4"):MakeStatus(Wan[i],"IPv6");
							document.write('<tr class = \"tabal_01\">');
							if(false == rowItms)
							{
								document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_table">'+ GetServLang('tr069') + '</td>');
								rowItms = true;
							}
							document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+IPStatus+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+IPProtocolType+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"TR069")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="TR069">'+MakeBindPort(Wan[i],"TR069")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
							document.write('</tr>');
							j++;
						}
					}
					else
					{
						document.write('<tr class = \"tabal_01\">');
						document.write('<td width="10%" id ="Table_wan'+j+'_1_table">'+ GetServLang('tr069') + '</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+MakeStatus(Wan[i],Wan[i].ProtocolType)+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+Wan[i].ProtocolType+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"TR069")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="TR069">'+MakeBindPort(Wan[i],"TR069")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
						document.write('</tr>');
						j++;
					}
				}
			}
		}
		if(ServiceNumber != 0)
		{
			var rowService = false;
			for (i = 0;i < Wan.length;i++)
			{
                var idPrefix = getElementId(domainTowanname(Wan[i].domain));
				rowService = false;
				if(Wan[i].ServiceList.indexOf("SERVICE") >= 0)
				{
					if("IPv4/IPv6" == Wan[i].ProtocolType)
					{
						for(var k = 0;k < 2;k++)
						{
							var IPProtocolType = (false == rowService)?"IPv4":"IPv6";
							var IPStatus = (false == rowService)?MakeStatus(Wan[i],"IPv4"):MakeStatus(Wan[i],"IPv6");
							document.write('<tr class = \"tabal_01\">');
							if(false == rowService)
							{
								if (Wan[i].ServiceList.indexOf("SPECIAL_SERVICE_VR") >= 0) {
									document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_table">'+ 'CLOUD VR' + '</td>');
								} else {
									document.write('<td width="10%" rowspan="2" id ="Table_wan'+j+'_1_table">'+ GetServLang('service') + '</td>');
								}
								rowService = true;
							}
							document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+IPStatus+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+IPProtocolType+'</td>');
							document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"SERVICE")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="SERVICE">'+MakeBindPort(Wan[i],"SERVICE")+'</td>');
							document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
							document.write('</tr>');
							j++;
						}
					}
					else
					{
						document.write('<tr class = \"tabal_01\">');
						if (Wan[i].ServiceList.indexOf("SPECIAL_SERVICE_VR") >= 0) {
							document.write('<td width="10%" id ="Table_wan'+j+'_1_table">'+ 'CLOUD VR' + '</td>');
						} else {
							document.write('<td width="10%" id ="Table_wan'+j+'_1_table">'+ GetServLang('service') + '</td>');
						}
						document.write('<td width="10%" id ="Table_wan'+j+'_2_table">'+MakeStatus(Wan[i],Wan[i].ProtocolType)+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_3_table">'+Wan[i].ProtocolType+'</td>');
						document.write('<td width="10%" id ="Table_wan'+j+'_4_table">'+MakeConnectionMode(Wan[i],"SERVICE")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_5_table" wan_index="' + i + '" srvtype="SERVICE">'+MakeBindPort(Wan[i],"SERVICE")+'</td>');
						document.write('<td width="20%" id ="Table_wan'+j+'_6_table" class="'+idPrefix+'_Name">'+GetWanName(Wan[i])+'</td>');
						document.write('</tr>');
						j++;
					}
				}
			}
		}
				
		document.write('</table>');
	</script>
</div>
<div id="Div_Special_BusinessInfo" style="display:none">
	<script type="text/javascript" language="javascript">
	if ( 1 == MngtFjct || 1 == MngtScct || 1 == MngtCqct)
	{

		document.write('<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">');
		document.write('<tr class="head_title">');
		document.write('<td width="10%" style="height: 21px">&nbsp;</td>');
		document.write('<td style="height: 21px;">通道（WAN连接）状态</td>');
		document.write('<td style="height: 21px;">&nbsp;IP协议</td>');
		document.write('<td style="height: 21px;">&nbsp;IP地址获取方式</td>');
		document.write('<td style="height: 21px;">&nbsp;获取的IP地址</td>');
		document.write('<td style="height: 21px;">&nbsp;上网拨号状态</td>');
		document.write('<td style="height: 21px;">&nbsp;语音注册状态</td>');
		document.write('</tr>');

		if( 0 == Wan.length )
		{
			document.write("<tr class=\"tabal_01\">");
			document.write('<td width="10%" style="height: 21px">/</td>');
			document.write('<td width="10%" style="height: 21px">/</td>');
			document.write('<td width="10%" style="height: 21px">/</td>');
			document.write('<td width="10%" style="height: 21px">/</td>');
			document.write('<td width="10%" style="height: 21px">/</td>');
			document.write('<td width="10%" style="height: 21px">/</td>');
			document.write('<td width="10%" style="height: 21px">/</td>');

			document.write("</tr>");
		}

		for (i = 0;i < Wan.length;i++)
		{

			if (ItmsNumber != 0)
			{
				WriteWanInfo("TR069");
			}
			if (iTVNumber != 0)
			{
				WriteWanInfo("OTHER");
			}
			if (InternetNumber != 0)
			{
				WriteWanInfo("INTERNET");
			}
			if (VoipNumber != 0)
			{
				WriteWanInfo("VOIP");
			}
			if (ServiceNumber !=0)
			{
				WriteWanInfo("SERVICE");
			}

		}
		document.write('</table>');
	}
	</script>
</div>

<div id='guide_wlaninfo' style="display:none">

<div class="func_spread"></div>
<div class="func_title">无线信息</div>

<script type="text/javascript" language="javascript">
function stWlan(domain,enable,name,ssid,BeaconType,BasicEncrypt,BasicAuth,WPAEncrypt,WPAAuth,IEEE11iEncrypt,IEEE11iAuth,WPAand11iEncrypt,WPAand11iAuth,RadiusKey)
{
	this.domain = domain;
	this.enable = enable;
	this.name = name;
	this.ssid = ssid;
	this.BeaconType = BeaconType;
	this.BasicAuth = BasicAuth;
	this.BasicEncrypt = BasicEncrypt;
	this.WPAAuth = WPAAuth;
	this.WPAEncrypt = WPAEncrypt;
	this.IEEE11iAuth = IEEE11iAuth;
	this.IEEE11iEncrypt = IEEE11iEncrypt;
	this.WPAand11iAuth = WPAand11iAuth;
	this.WPAand11iEncrypt = WPAand11iEncrypt;
	this.RadiusKey = RadiusKey;
}

var first2gIndex = 0;
var first5gIndex = 0;
var SsidPerBand = '<%HW_WEB_GetSPEC(AMP_SPEC_SSID_NUM_MAX_BAND.UINT32);%>';
var first5gName = 'ath' + SsidPerBand;

function findFirstWlanInst()
{
    if ((WlanInfo[i].name == 'ath0') && (first2gIndex == 0))
    {     
        first2gIndex = i;
    }  
	
    if (DoubleFreqFlag == 1)
    {
        if ((WlanInfo[i].name == first5gName) && (first5gIndex == 0))
        {     
            first5gIndex = i;
        }
    }
}

var WlanInfo = new Array();
WlanInfoArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Enable|Name|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_RadiusKey,stWlan);%>;
var WlanWifiLen = WlanInfoArr.length - 1;
for (i=0; i < WlanWifiLen; i++)
{
    WlanInfo[i] = new stWlan();
    WlanInfo[i] = WlanInfoArr[i];
	
	findFirstWlanInst(i);
}

function stPreSharedKey(domain, value)
{
	this.domain = domain;
	this.value = value;
}

var wpaPskKey = new Array();
var wpaPskKeyArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;
var wpaPskKeyArrLen = wpaPskKeyArr.length - 1;
for (i=0; i < wpaPskKeyArrLen; i++)
{
    wpaPskKey[i] = new stPreSharedKey();
    wpaPskKey[i] = wpaPskKeyArr[i];
}

function stWEPKey(domain, value)
{
	this.domain = domain;
	this.value = value;
}

var wepKey = new Array();
var wepKeyArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.1,WEPKey,stWEPKey);%>;
var wepKeyArrLen = wepKeyArr.length - 1;
for (i=0; i < wepKeyArrLen; i++)
{
    wepKey[i] = new stWEPKey();
    wepKey[i] = wepKeyArr[i];
}

function GetWlanEnable()
{
	if (0 == DoubleFreqFlag)
	{
		var wlanEnbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanEnable);%>';
		if (wlanEnbl == 1)
		{
			return GUIDE_OPEN;
		}
		else
		{
			return GUIDE_CLOSE;
		}
	}
	else
	{
		if (enbl2G == 1)
		{
			return GUIDE_OPEN;
		}
		else
		{
			return GUIDE_CLOSE;
		}
	}
}

function GetWlanEnable5G()
{
	if (enbl5G == 1)
	{
		return GUIDE_OPEN;
	}
	else
	{
		return GUIDE_CLOSE;
	}
}

function GetWlanName()
{
	if (0 == DoubleFreqFlag)
	{
		if ((GetWlanEnable() == GUIDE_CLOSE) || (null == WlanInfo[first2gIndex]))
		{
			return GUIDE_NULL;
		}
	}
	else
	{
		if ((enbl2G == 0) || (null == WlanInfo[first2gIndex]))
		{
			return GUIDE_NULL;
		}
	}
	
	return WlanInfo[first2gIndex].ssid;
}

function GetWlanName5G()
{
	if ((enbl5G == 0) || (null == WlanInfo[first5gIndex]))
	{
		return GUIDE_NULL;
	}
	
	return WlanInfo[first5gIndex].ssid;
}

function GetWlanPwdValue(firstIndex) {
    if (WlanInfo[firstIndex].BeaconType == "Basic") {
		if (WlanInfo[firstIndex].BasicEncrypt != "None") {
			return wepKey[firstIndex].value;
		}
	} else if (WlanInfo[firstIndex].BeaconType == "WPA") {
		if (WlanInfo[firstIndex].WPAAuth == "PSKAuthentication") {
			return wpaPskKey[firstIndex].value;
		} else {
			return WlanInfo[firstIndex].RadiusKey;
		}
	} else if ((WlanInfo[firstIndex].BeaconType == "WPA2") || (WlanInfo[firstIndex].BeaconType == "11i")) {
		if (WlanInfo[firstIndex].IEEE11iAuth == "PSKAuthentication") {
			return wpaPskKey[firstIndex].value;
		} else {
			return WlanInfo[firstIndex].RadiusKey;
		}
	} else if ((WlanInfo[firstIndex].BeaconType == "WPAand11i") || (WlanInfo[firstIndex].BeaconType == "WPA/WPA2")) {
		if (WlanInfo[firstIndex].WPAand11iAuth == "PSKAuthentication") {
			return wpaPskKey[firstIndex].value;
		} else {
			return WlanInfo[firstIndex].RadiusKey;
		}
	} else if (WlanInfo[firstIndex].BeaconType == "WPA3") {
		if (WlanInfo[firstIndex].WPAand11iAuth == "SAEAuthentication") {
			return wpaPskKey[firstIndex].value;
		} else {
			return WlanInfo[firstIndex].RadiusKey;
		}
	} else if (WlanInfo[firstIndex].BeaconType == "WPA2/WPA3") {
		if (WlanInfo[firstIndex].WPAand11iAuth == "PSKandSAEAuthentication") {
			return wpaPskKey[firstIndex].value;
		} else {
			return WlanInfo[firstIndex].RadiusKey;
		}
	}
	return "";
}

function GetWlanPass() {
	if (DoubleFreqFlag == 0) {
		if ((GetWlanEnable() == GUIDE_CLOSE) || (WlanInfo[first2gIndex] == null)) {
			return GUIDE_NULL;
		}
	} else {
		if ((enbl2G == 0) || (WlanInfo[first2gIndex] == null)) {
			return GUIDE_NULL;
		}
	}

	return GetWlanPwdValue(first2gIndex);
}

function GetWlanPass5G() {
	if ((enbl5G == 0) || (WlanInfo[first5gIndex] == null)) {
		return GUIDE_NULL;
	} else {
		return GetWlanPwdValue(first5gIndex);
	}
}

function GetWlanSecuConfig()
{
	if (0 == DoubleFreqFlag)
	{
		if ((GetWlanEnable() == GUIDE_CLOSE) || (null == WlanInfo[first2gIndex]))
		{
			return GUIDE_NULL;
		}
	}
	else
	{
		if ((enbl2G == 0) || (null == WlanInfo[first2gIndex]))
		{
			return GUIDE_NULL;
		}
	}

	if (((WlanInfo[first2gIndex].BeaconType == "None") || (WlanInfo[first2gIndex].BeaconType == "Basic")) && (WlanInfo[first2gIndex].BasicEncrypt == "None"))
	{
		return GUIDE_CLOSE;
	}
	else
	{
		return GUIDE_OPEN;
	}
}

function GetWlanSecuConfig5G()
{
	if ((enbl5G == 0) || (null == WlanInfo[first5gIndex]))
	{
		return GUIDE_NULL;
	}
	else
	{
		if (((WlanInfo[first5gIndex].BeaconType == "None") || (WlanInfo[first5gIndex].BeaconType == "Basic")) && (WlanInfo[first5gIndex].BasicEncrypt == "None"))
		{
			return GUIDE_CLOSE;
		}
		else
		{
			return GUIDE_OPEN;
		}
	}
}
</script>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg">
	<tr>
		<td class="table_left"  width="25%" id="Table_wifi1_1_table" name="Table_wifi1_1_table">
		<script>  
		if ('0' == DoubleFreqFlag)
		{
			document.write("无线网络名称: ");
		}
		else
		{
			document.write("2.4G无线网络名称: ");
		} 
		</script> 
		</td>
		<td class="table_right" width="75%" id="Table_wifi1_2_table" name="Table_wifi1_2_table">
		<script type="text/javascript" language="javascript">document.write(GetSSIDStringContent(GetWlanName(),32));</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_wifi2_1_table" name="Table_wifi2_1_table">
		<script>  
		if ('0' == DoubleFreqFlag)
		{
			document.write("无线网络密钥: ");
		}
		else
		{
			document.write("2.4G无线网络密钥: ");
		} 
		</script> 
		</td>
		<td class="table_right" width="75%" id="Table_wifi2_2_table" name="Table_wifi2_2_table">
		<script type="text/javascript" language="javascript">document.write(GetWlanPass());</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_wifi3_1_table" name="Table_wifi3_1_table">
		<script>  
		if ('0' == DoubleFreqFlag)
		{
			document.write("无线状态: ");
		}
		else
		{
			document.write("2.4G无线状态: ");
		} 
		</script> 
		</td>
		<td class="table_right" width="75%" id="Table_wifi3_2_table" name="Table_wifi3_2_table">
		<script type="text/javascript" language="javascript">document.write(GetWlanEnable());</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_wifi4_1_table" name="Table_wifi4_1_table">
		<script>  
		if ('0' == DoubleFreqFlag)
		{
			document.write("安全模式: ");
		}
		else
		{
			document.write("2.4G安全模式: ");
		} 
		</script> 
		</td>
		<td class="table_right" width="75%" id="Table_wifi4_2_table" name="Table_wifi4_2_table">
		<script type="text/javascript" language="javascript">document.write(GetWlanSecuConfig());</script>
		</td>
	</tr>
</table>
<table id="area_5g" width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg" style="display:none">
	<tr>
		<td class="table_left"  width="25%" id="Table_wifi1_1_table" name="Table_wifi1_1_table">5G无线网络名称:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_wifi1_2_table" name="Table_wifi1_2_table">
		<script type="text/javascript" language="javascript">document.write(GetSSIDStringContent(GetWlanName5G(),32));</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_wifi2_1_table" name="Table_wifi2_1_table">5G无线网络密钥:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_wifi2_2_table" name="Table_wifi2_2_table">
		<script type="text/javascript" language="javascript">document.write(GetWlanPass5G());</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_wifi3_1_table" name="Table_wifi3_1_table">5G无线状态:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_wifi3_2_table" name="Table_wifi3_2_table">
		<script type="text/javascript" language="javascript">document.write(GetWlanEnable5G());</script>
		</td>
	</tr>

	<tr>
		<td class="table_left"  width="25%" id="Table_wifi4_1_table" name="Table_wifi4_1_table">5G安全模式:&nbsp;</td>
		<td class="table_right" width="75%" id="Table_wifi4_2_table" name="Table_wifi4_2_table">
		<script type="text/javascript" language="javascript">document.write(GetWlanSecuConfig5G());</script>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg">
	<script type="text/javascript" language="javascript">
	function AdminJump()
	{
		if (0 == DoubleFreqFlag)
		{
			top.Frame.changeMenuShow('Menu1_Network','Menu2_Net_WLAN','Menu3_NW_Basic');
		}
		else
		{
			top.Frame.changeMenuShow('Menu1_Network','Menu2_Net_WLAN','Menu3_NW_Basic_2G');
		}
	}

	function UserJump()
	{
		top.Frame.changeMenuShow('Menu1_Status','Menu2_Sta_Overview','Menu3_SO_Wizard');
	}

	var id_guidewlan;
	var url;
	if ('0' == '<%HW_WEB_GetUserType();%>')
	{		
		if (0 == DoubleFreqFlag)
		{
			url = "/html/amp/wlanbasic/e8cWlanBasic.asp";
		}
		else
		{
			url = "/html/amp/wlanbasic/e8cWlanBasic.asp?2G";
		}
		
		id_guidewlan = "Table_wifi5_1_admin_table";

		document.writeln("<tr>");
		document.writeln("<td class='table_left' id=" + id_guidewlan + ">" + "<a onclick='AdminJump();' href=" + url + ">" + "无线配置向导&nbsp;" + "</td>");
		document.writeln("</tr>");
	}
	else
	{
		url = "/html/ssmp/cfgguide/cfgwizard.asp";
		id_guidewlan = "Table_wifi5_1_user_table";

		document.writeln("<tr>");
		document.writeln("<td class='table_left' id=" + id_guidewlan + ">" + "<a onclick='UserJump();' href=" + url + ">" + "无线配置向导&nbsp;" + "</td>");
		document.writeln("</tr>");
	}
	</script>

</table>
</div>
<script type="text/javascript" language="javascript">
if ('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>' == 1)
{
	setDisplay('guide_wlaninfo', 1);
}
</script>

<div class="func_spread"></div>
<div class="func_title">用户侧以太网口信息</div>

<script type="text/javascript" language="javascript">
function GEInfo(domain,Status)
{
	this.domain  = domain;
	if(Status==0)this.Status = "未连接设备";
	if(Status==1)this.Status = "已连接设备";
}

var geInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Link,GEInfo);%>;

function getlandesc(lanid)
{
    if ('1' == TianYiFlag)
    {
        return lanDescArr[lanid - 1];
    }
	var landesc;
	landesc = "网口" + lanid;
	if ((0 == stbport) && (2 == lanid) && (4 == geInfos.length - 1) && CfgMode.toUpperCase() != 'GZGD')
	{
		landesc = "iTV";
	}

	if ((lanid == 0) || (lanid > geInfos.length - 1))
	{
		landesc = "";
	}
	
	if( lanid == stbport)
	{
		landesc = "内置STB";
	}

	return landesc;
}

</script>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg">
	<tr class="table_title" id="lanuserdevinfotitle">
		<td width="25%">端口号</td>
		<td width="25%">状态</td>
		<td width="25%">MAC地址</td>
	</tr>

	<script type="text/javascript" language="javascript">
	function appendstr(str)
	{
		return str;
	}

	function createlanuserdevtable(lanuserdevinfos)
	{
		var lanid;
		var UserDevicesNum = lanuserdevinfos.length - 1;
		var output = "";
		var mac = ""
		for(i=0; i<geInfos.length - 1; i++)
		{
			mac = ""
			lanid = i+1;

			for (j = 0; j < UserDevicesNum; j++)
			{
				if("ETH" != lanuserdevinfos[j].PortType)
				{
					continue;
				}

				if ((lanid == parseInt(lanuserdevinfos[j].Port.charAt(lanuserdevinfos[j].Port.length -1))) && (lanuserdevinfos[j].DevStatus.toUpperCase() =="ONLINE"))
				{
					mac = lanuserdevinfos[j].MacAddr;
				}
			}
			
			if (stbport == lanid && E8CRONGHEFlag == 1)
			{
				continue;
			}
			
			output = output + appendstr("<tr class=\"tabal_01\">");
			if (stbport == lanid)
			{
				output = output + appendstr('<td class=\"align_left\">' +  status_ethinfo_language['amp_port_inner_stb'] +'</td>');
			}
			else if (UpUserPortID == lanid)
			{
				output = output + appendstr('<td class=\"align_left\">' +  status_ethinfo_language['amp_port_wan'] +'</td>');
			}
			else
			{
				output = output + appendstr('<td class=\"align_left\">' +  getlandesc(lanid) +'</td>');
			}
			
			output = output + appendstr('<td class=\"align_left\">' + geInfos[i].Status +'</td>');
			output = output + appendstr('<td class=\"align_left\">' + mac +'</td>');
			output = output + appendstr("</tr>");

		}
		$("#lanuserdevinfotitle").after(output);
	}

	GetLanUserDevInfo(function(lanuserdevinfos)
	{
		createlanuserdevtable(lanuserdevinfos);
	});
	</script>
</table>
<div class="subWanListPolicyRoute subWanListIPVersion subIspWlan subDSLite subV6RDTunnel subRadioWan subWanStats subWANAccessType">
    <script type="text/javascript">
        function RenderPage(event) {
            if (event.type == "evtWanListPolicyRoute") {
                $("[wan_index]").each(function() {
                    var wanid = $(this).attr("wan_index");
                    var srvtype = $(this).attr("srvtype");
                    var txt = MakeBindPort(Wan[wanid],srvtype)
                    $(this).html(txt);
                });
            }
        }
        LazyLoad();
    </script>
</div>
</body>
</html>
