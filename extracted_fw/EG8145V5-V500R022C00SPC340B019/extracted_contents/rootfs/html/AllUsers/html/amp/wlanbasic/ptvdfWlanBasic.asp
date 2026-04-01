<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">

<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, vdf_wlan_basic_language, cfg_wlancfgother_language, cfg_wlancfgbasic_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>ptvdfWlanBasic</title>
<style>
.divsummaryicon,.divpageicontext{
	float:left;
	margin-top: -15px;
}
.pagetitlecontent_span{
	clear:both;
	display:block;
}
</style>
<script language="JavaScript" type="text/javascript">
function stLanDevice(domain, WlanCfg)
{
    this.domain = domain;
    this.WlanCfg = WlanCfg;
}

var LanDeviceArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable, stLanDevice,EXTEND);%>;
var LanDevice = LanDeviceArr[0];
var enbl = LanDevice.WlanCfg;

var curUserType='<%HW_WEB_GetUserType();%>';
var clickSplitButton = 0;

function stWlan(domain,name,enable,ssid,wlHide,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                KeyIndex,EncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,WPARekey,RadiusServer,RadiusPort,RadiusKey,X_HW_ServiceEnable)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
    this.wlHide = wlHide;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.BasicAuthenticationMode = BasicAuthenticationMode;
    this.KeyIndex = KeyIndex;
    this.EncypBit = EncryptionLevel;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.WPAAuthenticationMode = WPAAuthenticationMode;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.IEEE11iAuthenticationMode = IEEE11iAuthenticationMode;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
    this.X_HW_WPAand11iAuthenticationMode = X_HW_WPAand11iAuthenticationMode;
    this.WPARekey = WPARekey;
    this.RadiusServer = RadiusServer;
    this.RadiusPort = RadiusPort;
    this.RadiusKey = RadiusKey;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
}

function stWEPKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function stPreSharedKey(domain, psk, kpp)
{
    this.domain = domain;
    this.value = psk;

    if('1' == kppUsedFlag)
    {
        this.value = kpp;
    }
}

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|SSIDAdvertisementEnabled|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_GroupRekey|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable,stWlan);%>;

var index2g = -1;
var index5g = -1;

for (i = 0; i < WlanArr.length - 1; i++)
{
   if (0 == getWlanPortNumber(WlanArr[i].name))
   {
		index2g = i;
   }
   else if (4 == getWlanPortNumber(WlanArr[i].name))
   {
		index5g = i;
   }
}

var WlanWifi2G = WlanArr[index2g];
var WlanWifi5G = WlanArr[index5g];

var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey|KeyPassphrase,stPreSharedKey);%>;

function isWlanSame()
{
	if(enbl2G != enbl5G)
	{
		return false;
	}
	else if (WlanWifi2G.ssid != WlanWifi5G.ssid)
	{
		return false;
	}
	else if (WlanWifi2G.enable != WlanWifi5G.enable)
	{
		return false;
	}
	else if (WlanWifi2G.wlHide != WlanWifi5G.wlHide)
	{
		return false;
	}
	else if (WlanWifi2G.BeaconType != WlanWifi5G.BeaconType)
	{
		return false;
	}
	
	if ((WlanWifi2G.BeaconType == 'Basic')|| (WlanWifi2G.BeaconType == 'None'))
	{
		if (WlanWifi2G.BasicAuthenticationMode != WlanWifi5G.BasicAuthenticationMode 
			|| WlanWifi2G.BasicEncryptionModes != WlanWifi5G.BasicEncryptionModes)
		{
			return false;
		}
		
		if (WlanWifi2G.BasicEncryptionModes == "WEPEncryption")
		{
			if (WlanWifi2G.KeyIndex != WlanWifi5G.KeyIndex)
			{
				return false;
			}
			else if (WlanWifi2G.EncypBit != WlanWifi5G.EncypBit)
			{
				return false;
			}
			else if (g_keys[index2g * 4].value != g_keys[index5g * 4].value
				|| g_keys[index2g * 4 + 1].value != g_keys[index5g * 4 + 1].value
				|| g_keys[index2g * 4 + 2].value != g_keys[index5g * 4 + 2].value
				|| g_keys[index2g * 4 + 3].value != g_keys[index5g * 4 + 3].value) 
			{
				return false;
			}
			else 
			{
				return true;
			}
		}
		else 
		{
			return true;
		}
	}
	else if (WlanWifi2G.BeaconType == 'WPA')
	{
		if (WlanWifi2G.WPAAuthenticationMode != WlanWifi5G.WPAAuthenticationMode 
			|| WlanWifi2G.WPAEncryptionModes != WlanWifi5G.WPAEncryptionModes)
		{	
			return false;
		}
	}
	else if ((WlanWifi2G.BeaconType == '11i') || (WlanWifi2G.BeaconType == 'WPA2'))
	{
		if (WlanWifi2G.IEEE11iAuthenticationMode != WlanWifi5G.IEEE11iAuthenticationMode 
			|| WlanWifi2G.IEEE11iEncryptionModes != WlanWifi5G.IEEE11iEncryptionModes)
		{	
			return false;
		}
	}
	else if ((WlanWifi2G.BeaconType == 'WPAand11i') || (WlanWifi2G.BeaconType == 'WPA/WPA2'))
	{
		if (WlanWifi2G.X_HW_WPAand11iAuthenticationMode != WlanWifi5G.X_HW_WPAand11iAuthenticationMode 
			|| WlanWifi2G.X_HW_WPAand11iEncryptionModes != WlanWifi5G.X_HW_WPAand11iEncryptionModes)
		{	
			return false;
		}
	}
	
	if ((WlanWifi2G.BeaconType == 'WPA') || (WlanWifi2G.BeaconType == '11i') || (WlanWifi2G.BeaconType == 'WPA2')
		||(WlanWifi2G.BeaconType == 'WPAand11i') || (WlanWifi2G.BeaconType == 'WPA/WPA2'))
	{
		if (WlanWifi2G.WPAAuthenticationMode == 'PSKAuthentication')
		{
			if (wpaPskKey[index2g].value != wpaPskKey[index5g].value)
			{
				return false;
			}
			else 
			{
				return true;
			}
		}
		else 
		{	
			if (WlanWifi2G.RadiusKey != WlanWifi5G.RadiusKey)
			{
				return false;
			}
			else 
			{
				return true;
			}
		}
	}
}

function SplitSSID()
{
	if (1 != enbl) {
		return;
	}
	
	if (1 == getCheckVal('splitSSID'))
	{
		setDisplay('allDiv', 0);
		setDisplay('splitDiv', 1);
		getElementById('coverinfo_content').src = './WlanBasic.asp?2G';
	}
	else
	{
		if (('0' == curUserType) && (0 == clickSplitButton)) {
			if (ConfirmEx(vdf_wlan_basic_language['amp_waln_splitSSID'])) {
				setDisplay('allDiv', 1);
				setDisplay('splitDiv', 0);
				getElementById('allcontent').src = './ptvdfAllWlanBasic.asp';
			}
		} else {
			setDisplay('allDiv', 1);
			setDisplay('splitDiv', 0);
			getElementById('allcontent').src = './ptvdfAllWlanBasic.asp';
		}
	}
}

function switchTab(TableN)
{	
    for (var i = 1; i <= 2; i++)
    {
        if ("tab" + i == TableN) 
        {
            getElementById(TableN).style.backgroundColor = "#f6f6f6";
        }
        else
        {
            getElementById("tab" + i).style.backgroundColor = "";
        }
    }

    if ("tab1" == TableN)
    {
		getElementById('coverinfo_content').src = "./WlanBasic.asp?2G";
	}
    else
    {
		getElementById('coverinfo_content').src = "./WlanBasic.asp?5G";
    }
	
	if (getElementById('coverinfo_content').contentDocument.body != undefined) {
		getElementById('coverinfo_content').contentDocument.body.attributes[0].value = '';
	}
}

function WlanEnableSubmit()
{
	var Form = new webSubmitForm();
    var enable = getCheckVal('wlAllEnbl');
    	
		
	Form.addParameter('x.X_HW_WlanEnable',enable);
    Form.setAction('set.cgi?x=InternetGatewayDevice.LANDevice.1'
                                + '&RequestFile=html/amp/wlanbasic/ptvdfWlanBasic.asp');
    
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function LoadFrame()
{
	setDisplay('contentDiv', 0);
	if (isWlanSame())
	{
		setCheck('splitSSID', 0); 
	}
	else 
	{
		setCheck('splitSSID', 1); 
	}
	
	clickSplitButton = 1;
	SplitSSID();
	clickSplitButton = 0;
	setCheck('wlAllEnbl', enbl);   
	
	if (1 == enbl)
	{
		setDisplay('contentDiv', 1);
	}
}

</script>

<style type="text/css">

</style>

</head>
<body class="mainbody" onLoad="LoadFrame();">

<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
	wlanbasic_note = cfg_wlancfgother_language['amp_wlanbasic_title'];
	wlanbasic_header = cfg_wlancfgbasic_language['amp_wlan_basic_header'];
var WlanBasicSummaryArray = new Array(new stSummaryInfo("text",wlanbasic_note),
                                    new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note1")),
                                    new stSummaryInfo("text","1. " + GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note") + "<br>"),
									new stSummaryInfo("text","2. " + GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note2")+ "<br>"),
									new stSummaryInfo("text","3. " + GetDescFormArrayById(cfg_wlancfgother_language, "amp_wlan_note3")),
                                    null);
HWCreatePageHeadInfo("wlanbasicSummary", wlanbasic_header, WlanBasicSummaryArray, true);
</script>

<div class="title_spread"></div>
	<div>
		<div>
			<input type='checkbox' name='wlAllEnbl' id='wlAllEnbl' onClick='WlanEnableSubmit();'>
				<script>document.write(vdf_wlan_basic_language["amp_wlan_basic_wifi_network"]);</script>
			</input>
		</div>
		
		<div id = 'contentDiv' style = 'display:none;'>
		
		<div >
			<input type='checkbox' name='splitSSID' id='splitSSID' onClick='SplitSSID();'>
				<script>document.write(vdf_wlan_basic_language["amp_wlan_basic_split_ssid"]);</script>
			</input>
		</div>
		
		<div id = 'allDiv' class='' style = 'display:none;'>
			<iframe id="allcontent" frameborder="0" height="900px" marginheight="0" 
				marginwidth="0" width="100%" scrolling="no">
			</iframe>
		</div>
		
		<div id = 'splitDiv' class='' style = 'display:none;'>
			<div>
				<table id="tableinfo" width="100%" height="100%" style="border-spacing: 0px;">
					<tr class="head_title">
						<td width="20%" id="tab1" onclick="switchTab('tab1');" style="background-color:#f6f6f6"><script>document.write('2.4G');</script></td>
						<td width="20%" id="tab2" onclick="switchTab('tab2');"><script>document.write('5G');</script></td>
					</tr>
				</table>
				
				<div id='splitIframeDiv'>
				<iframe id="coverinfo_content" frameborder="0" height="950px" marginheight="0"
					marginwidth="0" width="100%" scrolling="no">
				</iframe>
				</div>
			
			</div>
		</div>
		</div>
		
		<div id='DivApply' class="apply-cancel clearfix">
				<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		</div>
	</div>
</body>
</html>