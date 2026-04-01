<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_CleanCache_Resource(style_n.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_CleanCache_Resource(wificonfig.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, osgi_cfg_wifiinfo_language, cfg_wlancfgother_language, cfg_wlancfgadvance_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(pwd_dyn.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>Chinese -- Wifi Configure</title>

</head>

<script type="text/javascript">

var sptSsidName;
var wifi_enable;    //wlan全局使能开关
var g_flags = new Array();
g_flags[0] = 0;
g_flags[1] = 0;
g_flags[2] = 0;

var RadioEbl2G = 0;
var RadioEbl5G = 0;

var url = "";

function stWlanEnable(domain,enable)
{
    this.domain = domain;
    this.enable = enable;
}
var WlanEnable = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1, X_HW_WlanEnable,stWlanEnable);%>

function stWEPKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function stPreSharedKey(domain, value)
{
    this.domain = domain;
    this.value = value;
}

function stWlan(domain,name,enable,ssid,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                KeyIndex,EncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,RadiusServer,RadiusPort,RadiusKey,X_HW_ServiceEnable, LowerLayers,
				X_HW_WAPIEncryptionModes,X_HW_WAPIAuthenticationMode,X_HW_WAPIServer,X_HW_WAPIPort)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
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
    this.RadiusServer = RadiusServer;
    this.RadiusPort = RadiusPort;
    this.RadiusKey = RadiusKey;
	this.X_HW_ServiceEnable = X_HW_ServiceEnable;
	this.LowerLayers = LowerLayers;
	this.X_HW_WAPIEncryptionModes = X_HW_WAPIEncryptionModes;
	this.X_HW_WAPIAuthenticationMode = X_HW_WAPIAuthenticationMode;
	this.X_HW_WAPIServer = X_HW_WAPIServer;
	this.X_HW_WAPIPort = X_HW_WAPIPort;
}

var g_keys = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;
if (null != g_keys)
{
	wep1password = g_keys[0].value;
}

function stWlanWifi(domain,name,enable,ssid,mode,channel,power,Country,AutoChannelEnable,channelWidth)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
    this.mode = mode;
    this.channel = channel;
    this.power = power;
    this.RegulatoryDomain = Country;
    this.AutoChannelEnable = AutoChannelEnable;
    this.channelWidth = channelWidth;
}

var WlanWifi = new Array();
var WlanWifiArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|X_HW_Standard|Channel|TransmitPower|RegulatoryDomain|AutoChannelEnable|X_HW_HT20,stWlanWifi);%>;
var WlanWifiLen = WlanWifiArr.length - 1;
for (i=0; i < WlanWifiLen; i++)
{
    WlanWifi[i] = new stWlanWifi();
    WlanWifi[i] = WlanWifiArr[i];
}

var enbl = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.X_HW_WlanCfg);%>';

var Wlan = new Array();
var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},Name|Enable|SSID|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_RadiuServer|X_HW_RadiusPort|X_HW_RadiusKey|X_HW_ServiceEnable|LowerLayers|X_HW_WAPIEncryptionModes|X_HW_WAPIAuthenticationMode|X_HW_WAPIServer|X_HW_WAPIPort,stWlan);%>;
var wlanArrLen = WlanArr.length - 1;
for (i=0; i < wlanArrLen; i++)
{
    Wlan[i] = new stWlan();
    Wlan[i] = WlanArr[i];
}
var wpaPskKey = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey,stPreSharedKey);%>;
var wlanMac = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_WlanMac);%>';


var first2gIndex = 0;
var first5gIndex = 0;

function findFirstWlanInst()
{
    for (i=0; i < wlanArrLen; i++)
    {
		if (('ath0' == WlanArr[i].name) && (0 == first2gIndex))
        {     
            first2gIndex = i;
        }  
		
        if (1 == DoubleFreqFlag)
        {
            if (('ath4' == WlanArr[i].name) && (0 == first5gIndex))
            {     
                first5gIndex = i;
            }
		}
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
		b.innerHTML = osgi_cfg_wifiinfo_language[b.getAttribute("BindText")];
	}
}

function SetShowWifiPsw(id)
{
    var enable = getCheckVal(id);
    var wlanPasswordFlag = enable ? 0 : 1;
    var twlanPasswordFlag = enable ? 1 : 0;

    if ('CkBoxShowPsw' == id)
    {
        setDisplay("WlanPassword_password", wlanPasswordFlag);
        setDisplay("tWlanPassword_password", twlanPasswordFlag);
    }
    else
    {
        setDisplay("WlanPassword_password_5G", wlanPasswordFlag);
        setDisplay("tWlanPassword_password_5G", twlanPasswordFlag);
    }
}

function isValidSSID(ssid)
{
    if (ssid == '')
    {
        AlertEx(cfg_wlancfgother_language['amp_empty_ssid']);
        return false;
    }

    if (ssid.length > 32)
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_loog']);
        return false;
    }

    if (isValidAscii(ssid) != '')
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid'] + isValidAscii(ssid));
        return false;
    }

    if(0 != ssid.indexOf("ChinaNet-")) 
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_must_be_chinanet']);
        return false;
    }
        
    return true;
}

/*
只有单一数字、字母（完全大写或完全小写）为弱，
数字字母（完全大写或完全小写）混合为中，
包含数字、字母、符号为强。
输入过程中，若键盘大写处于打开状态，给出提示“您的键盘处于大写锁定状态”。
*/

function CheckPwdCpy(val)
{
	var HaveDigit = 0;
	var HaveBigChar = 0;
	var HaveSmallChar = 0;
	var HaveSpecialChar = 0;

    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch <= '9' && ch >= '0' )
        {
            HaveDigit = 1;
        }
		else if(ch <= 'z' && ch >= 'a')
		{
			HaveSmallChar = 1;
		}
		else if(ch <= 'Z' && ch >= 'A')
		{
			HaveBigChar = 1;
		}
		else
		{
			HaveSpecialChar = 1;
		}
    }

	var Result = HaveDigit + HaveSmallChar + HaveBigChar + HaveSpecialChar;

	if(1 == Result)
	{
		return "simple";
	}
	else if( (1 == HaveDigit) && (1 == (HaveSmallChar + HaveBigChar)) && (0 == HaveSpecialChar))
	{
		return "medium";
	}
	else
	{
		return "strong";
	}
}

function ShowPwdCpy(Para)
{
    var enable_idArr = new Array("simpleicon", "simplechar", "mediumicon", "mediumchar", "strongicon", "strongchar", "Div_pwd_cpy_info");

    if (Para.id.indexOf("_5G") != '-1')
    {
        for (var i = 0; i < enable_idArr.length; i++)
        {
            enable_idArr[i] = enable_idArr[i] + "_5G";
        }
    }
	
    setDisplay(enable_idArr[0], 0);
    setDisplay(enable_idArr[1], 0);
    setDisplay(enable_idArr[2], 0);
    setDisplay(enable_idArr[3], 0);
    setDisplay(enable_idArr[4], 0);
    setDisplay(enable_idArr[5], 0);
    setDisplay(enable_idArr[6], 0);

    if ( "" == Para.value)
    {
        return 0;
    }

    if ('' != isValidAscii(Para.value))
    {
        alert(GetLanguageDesc("s0f04"));
        return 0;
    }

    var Result = CheckPwdCpy(Para.value);
    setDisplay(enable_idArr[6], 1);

    if (Result == "simple")
    {
        setDisplay(enable_idArr[0], 1);
        setDisplay(enable_idArr[1], 1);
    }
    else if (Result == "medium")
    {
        setDisplay(enable_idArr[0], 1);
        setDisplay(enable_idArr[1], 1);
        setDisplay(enable_idArr[2], 1);
        setDisplay(enable_idArr[3], 1);
    }
    else
    {
        setDisplay(enable_idArr[0], 1);
        setDisplay(enable_idArr[1], 1);
        setDisplay(enable_idArr[2], 1);
        setDisplay(enable_idArr[3], 1);
        setDisplay(enable_idArr[4], 1);
        setDisplay(enable_idArr[5], 1);
    }

    return 0;
}

function ChannelChange()
{
}

function CheckForm(type)
{
	//confirm(osgi_cfg_wifiinfo_language['bbsp_osgi_note']);
    return true;
}

function ltrim(str)
{
	return str.replace(/(^\s*)/g,"");
}

function addParaWifiEnable()
{
    Form.addParameter('w.X_HW_WlanEnable', wifi_enable);

    if (wifi_enable == '1')
    {
        Form.addParameter('y.Enable', wifi_enable);
    }

    url += 'w=InternetGatewayDevice.LANDevice.1';
}

function CheckPrefix()
{
    var ssid;
    ssid = ltrim(getValue('osgi_amp_ssid_name'));

    if (0 != ssid.indexOf("ChinaNet-") )
    {
        alert(cfg_wlancfgother_language['amp_ssid_must_be_chinanet']);
        return false;
    }

    if ('1' == DoubleFreqFlag)
    {
        ssid = ltrim(getValue('osgi_amp_ssid_name_5G'));

        if (0 != ssid.indexOf("ChinaNet-") )
        {
            alert(cfg_wlancfgother_language['amp_ssid_must_be_chinanet']);
            return false;
        }
    }

    return true;
}

function addParaSsid(Form)
{
    var ssid;

    ssid = getValue('osgi_amp_ssid_name');

    if (false == isValidSSID(ssid))
    {
        return false;
    }

    Form.addParameter('y.SSID', ssid);

    if ('1' == DoubleFreqFlag)
    {
        ssid = getValue('osgi_amp_ssid_name_5G');

        if (false == isValidSSID(ssid))
        {
            return false;
        }

        Form.addParameter('z.SSID', ssid);
    }
	
	return true;
}

function ApplySubmit()
{
    var con = window.confirm("是否确认修改WiFi设置？");

    if (con != true)
    {
        window.close();
        return;
    }

    /* 检查输入是否有ChinaNet-*/
    if (true != CheckPrefix())
    {
        return ;
    }
	
	var Form = new webSubmitForm();

    /* 检查SSID的合法性*/
    if (true != addParaSsid(Form))
    {
        return;
    }

    if ('0' == DoubleFreqFlag)
    {
        ApplySubmit1(Form);
    }
    else
    {
        ApplySubmit2(Form);
    }

}

function addParaWlan2g(Form)
{
    var wlan = Wlan[first2gIndex];
    var wlandomain = wlan.domain;
    var wlanInstId = parseInt(wlandomain.charAt(wlandomain.length - 1));
    var acApConfigPath = 'InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic';
    var value = getValue('tWlanPassword_password');
    var AuthMode = getSelectVal('ssid_encry');

    Form.addParameter('w.X_HW_WlanEnable', wifi_enable);
    url += 'w=InternetGatewayDevice.LANDevice.1';

    if (wifi_enable == '1')
    {
        Form.addParameter('y.Enable', wifi_enable);
    }

    var Rssi = getSelectVal('ssid_rssi');
    Form.addParameter('y.TransmitPower', Rssi);

    var Channel = getSelectVal('ssid_channel');

    if (Channel == '0')
    {
        Form.addParameter('y.AutoChannelEnable', '1');
    }
    else
    {
        Form.addParameter('y.AutoChannelEnable', '0');
        Form.addParameter('y.Channel', Channel);
    }

    Form.addParameter('a.SsidInst', wlanInstId);
    Form.addParameter('a.SSID', ltrim(getValue('osgi_amp_ssid_name')));
    Form.addParameter('a.Enable', wifi_enable);
    Form.addParameter('a.Standard', WlanWifi[first2gIndex].mode);

    if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {
        Form.addParameter('a.WEPKeyIndex', 1);

        if (AuthMode == 'wpa-psk')
        {
            Form.addParameter('y.BeaconType', 'WPA');
            Form.addParameter('y.WPAAuthenticationMode', 'PSKAuthentication');

            Form.addParameter('a.BeaconType', 'WPA');
            Form.addParameter('a.WPAAuthenticationMode', 'PSKAuthentication');
            Form.addParameter('a.WPAEncryptionModes', 'TKIPandAESEncryption');
            Form.addParameter('a.Key', value);
        }
        else if (AuthMode == 'wpa2-psk')
        {
            Form.addParameter('y.BeaconType', '11i');
            Form.addParameter('y.IEEE11iAuthenticationMode', 'PSKAuthentication');

            Form.addParameter('a.BeaconType', '11i');
            Form.addParameter('a.IEEE11iAuthenticationMode', 'PSKAuthentication');
            Form.addParameter('a.IEEE11iEncryptionModes', 'TKIPandAESEncryption');
            Form.addParameter('a.Key', value);
        }
        else
        {
            Form.addParameter('y.BeaconType', 'WPAand11i');
            Form.addParameter('y.X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication');

            Form.addParameter('a.BeaconType', 'WPAand11i');
            Form.addParameter('a.MixAuthenticationMode', 'PSKAuthentication');
            Form.addParameter('a.MixEncryptionModes', 'TKIPandAESEncryption');
            Form.addParameter('a.Key', value);
        }

        Form.addParameter('k.PreSharedKey', value);

        url += '&y=' + wlandomain + '&k=' + wlandomain + '.PreSharedKey.1' + '&a=' + acApConfigPath;
    }
    else if (AuthMode == 'encry_none')
    {
        Form.addParameter('y.BeaconType', 'None');
        Form.addParameter('y.BasicEncryptionModes', 'None');
        Form.addParameter('y.BasicAuthenticationMode', 'None');

        Form.addParameter('a.WEPKeyIndex', 1);
        Form.addParameter('a.BeaconType', 'none');
        Form.addParameter('a.BasicEncryptionModes', 'None');
        Form.addParameter('a.BasicAuthenticationMode', 'None');

        url += '&y=' + wlandomain + '&a=' + acApConfigPath;
    }
    else if (AuthMode == 'encry_shared')
    {
        Form.addParameter('y.BeaconType', 'Basic');
        Form.addParameter('y.BasicEncryptionModes', 'WEPEncryption');
        Form.addParameter('y.BasicAuthenticationMode', 'SharedKey');
        Form.addParameter('k.WEPKey', value);

        Form.addParameter('a.WEPKeyIndex', 1);
        Form.addParameter('a.BeaconType', 'Basic');
        Form.addParameter('a.BasicEncryptionModes', 'WEPEncryption');
        Form.addParameter('a.BasicAuthenticationMode', 'SharedKey');
        Form.addParameter('a.Key', value);

        url += '&y=' + wlandomain + '&k=' + wlandomain + '.WEPKey.1' + '&a=' + acApConfigPath;
    }
}

function addParaWlan5g(Form)
{
    var wlan = Wlan[first5gIndex];
    var wlandomain = wlan.domain;
    var wlanInstId = parseInt(wlandomain.charAt(wlandomain.length - 1));
    //var acApConfigPath = 'InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic';
    var value = getValue('tWlanPassword_password_5G');
    var AuthMode = getSelectVal('ssid_encry_5G');

    var Rssi = getSelectVal('ssid_rssi_5G');
    Form.addParameter('z.TransmitPower', Rssi);

    var Channel = getSelectVal('ssid_channel_5G');

    if (Channel == '0')
    {
        Form.addParameter('z.AutoChannelEnable', '1');
    }
    else
    {
        Form.addParameter('z.AutoChannelEnable', '0');
        Form.addParameter('z.Channel', Channel);
    }

    //Form.addParameter('a1.SsidInst', wlanInstId);
    //Form.addParameter('a1.SSID', ltrim(getValue('osgi_amp_ssid_name_5G')));
    //Form.addParameter('a1.Enable', enbl5G);
    //Form.addParameter('a1.Standard', WlanWifi[first5gIndex].mode);
	
    if (AuthMode == 'wpa-psk' || AuthMode == 'wpa2-psk' || AuthMode == 'wpa/wpa2-psk')
    {

        if (AuthMode == 'wpa-psk')
        {
            Form.addParameter('z.BeaconType', 'WPA');
            Form.addParameter('z.WPAAuthenticationMode', 'PSKAuthentication');

            //Form.addParameter('a1.BeaconType', 'WPA');
            //Form.addParameter('a1.WPAAuthenticationMode', 'PSKAuthentication');
            //Form.addParameter('a1.WPAEncryptionModes', 'TKIPandAESEncryption');
            //Form.addParameter('a1.Key', value);
        }
        else if (AuthMode == 'wpa2-psk')
        {
            Form.addParameter('z.BeaconType', '11i');
            Form.addParameter('z.IEEE11iAuthenticationMode', 'PSKAuthentication');

            //Form.addParameter('a1.BeaconType', '11i');
            //Form.addParameter('a1.IEEE11iAuthenticationMode', 'PSKAuthentication');
            //Form.addParameter('a1.IEEE11iEncryptionModes', 'TKIPandAESEncryption');
            //Form.addParameter('a1.Key', value);
        }
        else
        {
            Form.addParameter('z.BeaconType', 'WPAand11i');
            Form.addParameter('z.X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication');

            //Form.addParameter('a1.BeaconType', 'WPAand11i');
            //Form.addParameter('a1.MixAuthenticationMode', 'PSKAuthentication');
            //Form.addParameter('a1.MixEncryptionModes', 'TKIPandAESEncryption');
            //Form.addParameter('a1.Key', value);
        }

        Form.addParameter('h.PreSharedKey', value);

        url += '&z=' + wlandomain + '&h=' + wlandomain + '.PreSharedKey.1';
    }
    else if (AuthMode == 'encry_none')
    {
        Form.addParameter('z.BeaconType', 'None');
        Form.addParameter('z.BasicEncryptionModes', 'None');
        Form.addParameter('z.BasicAuthenticationMode', 'None');

        //Form.addParameter('a1.WEPKeyIndex', 1);
        //Form.addParameter('a1.BeaconType', 'none');
        //Form.addParameter('a1.BasicEncryptionModes', 'None');
        //Form.addParameter('a1.BasicAuthenticationMode', 'None');

        url += '&z=' + wlandomain;
    }
    else if (AuthMode == 'encry_shared')
    {
        Form.addParameter('z.BeaconType', 'Basic');
        Form.addParameter('z.BasicEncryptionModes', 'WEPEncryption');
        Form.addParameter('z.BasicAuthenticationMode', 'SharedKey');
        Form.addParameter('h.WEPKey', value);

        //Form.addParameter('a1.WEPKeyIndex', 1);
        //Form.addParameter('a1.BeaconType', 'Basic');
        //Form.addParameter('a1.BasicEncryptionModes', 'WEPEncryption');
        //Form.addParameter('a1.BasicAuthenticationMode', 'SharedKey');
        //Form.addParameter('a1.Key', value);

        url += '&z=' + wlandomain + '&h=' + wlandomain + '.WEPKey.1';
    }
}

function ApplySubmit1(Form)
{
    addParaWlan2g(Form);

    Form.setAction('set.cgi?' + url + '&RequestFile=html/amp/wlanbasic/wificonfig.asp');

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    setDisable('mapwdApply', 1);
    Form.submit();
    setDisable('button', 1);
}

function ApplySubmit2(Form)
{
    addParaWlan2g(Form);
    addParaWlan5g(Form);
    addParaRadioEnable(Form);

    Form.setAction('set.cgi?' + url + '&RequestFile=html/amp/wlanbasic/wificonfig.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken_5G'));
    setDisable('mapwdApply', 1);
    Form.submit();
    setDisable('button_5G', 1);
}

function load2GChannelList(country, mode)
{	  
    var WebChannel = WlanWifi[first2gIndex].channel;
    var WebChannelValid = 0;
    var len = ssid_channel.options.length;    

    for (i = 0; i < len; i++)
    {
        ssid_channel.remove(0);
    }   

    ssid_channel[0] = new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0");

    for (i = 1; i <= 11; i++)
    {
        if (WebChannel == i)
        {
            WebChannelValid = 1;
        }
        ssid_channel[i] = new Option(i, i);
    }

    if (country != "CA" && country != "CO" && country != "DO" && country != "GT" && country != "MX"
        && country != "PA" && country != "PR" && country != "TW" && country != "US" && country != "UZ")
    {
        if ((WebChannel == 12) || (WebChannel == 13))
        {
            WebChannelValid = 1;
        }
        ssid_channel[12] = new Option("12", "12");
        ssid_channel[13] = new Option("13", "13");
    }
        
    if ((mode == "11b") &&  (country == "JP"))
    {
        if (WebChannel == 14)
        {
            WebChannelValid = 1;
        }
        ssid_channel[14] = new Option("14", "14");
    }

    if (1 == WebChannelValid)
    {
        setSelect('ssid_channel', WebChannel);
    }
    else
    {
        setSelect('ssid_channel', 0);    
    }
}

function getPossibleChannels(freq, country, mode, width)
{
    $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "../common/WlanChannel.asp?&1=1",
            data :"freq="+freq+"&country="+country+"&standard="+mode + "&width="+width,
            success : function(data) {
                possibleChannels = data;
            }
        });
}

function load5GChannelList(country, mode, width)
{
	var channelObj = getElementById("ssid_channel_5G");
    var len = channelObj.options.length;
    var index = 0;
    var i;
    var WebChannel = getSelectVal('ssid_channel_5G');
    var WebChannelValid = 0;  
	var freq = "5G";

    getPossibleChannels(freq, country, mode, width);
    var ShowChannels = possibleChannels.split(',');

    for (i = 0; i < len; i++)
    {
        channelObj.remove(0);
    }

	channelObj.options.add(new Option(cfg_wlancfgadvance_language['amp_chllist_auto'], "0")); 
    
    for (var j=1; j<=ShowChannels.length; j++)
    {
        if(j==ShowChannels.length)
        {
            for(i = 0; i < ShowChannels[ShowChannels.length-1].length;i++)
            {
                if((ShowChannels[ShowChannels.length-1].charCodeAt(i)< 0x30)||(ShowChannels[ShowChannels.length-1].charCodeAt(i) > 0x39))
                {
                    index = i;
                    break;
                    
                }
            }
            ShowChannels[j-1] = ShowChannels[ShowChannels.length-1].substring(0,index);
        }
        
        if (WebChannel == ShowChannels[j-1])
        {
            WebChannelValid = 1;
        }
		
		channelObj.options.add(new Option(ShowChannels[j-1], ShowChannels[j-1])); 
    }

    if (1 == WebChannelValid)
    {
        setSelect('ssid_channel_5G', WebChannel);
    }
    else
    {
        setSelect('ssid_channel_5G', 0);    
    }
}

function ShowWifiCfg_2G()
{
	load2GChannelList(WlanWifi[first2gIndex].RegulatoryDomain, WlanWifi[first2gIndex].mode);		

	setText('osgi_amp_ssid_name', WlanWifi[first2gIndex].ssid);
    if (Wlan[first2gIndex].BeaconType == 'None')
    {
        setText('WlanPassword_password',"");
        setText('tWlanPassword_password',"");
        wpapskpassword = "";
    }
	else if (Wlan[first2gIndex].BeaconType == 'Basic')
	{
	    setText('WlanPassword_password',  g_keys[first2gIndex*4].value);
        setText('tWlanPassword_password', g_keys[first2gIndex*4].value);
        wpapskpassword = g_keys[first2gIndex*4].value;
	}
    else
    {
        setText('WlanPassword_password', wpaPskKey[first2gIndex].value);
        setText('tWlanPassword_password',wpaPskKey[first2gIndex].value);
        wpapskpassword = wpaPskKey[first2gIndex].value;
    }

	setSelect('ssid_rssi',WlanWifi[first2gIndex].power);

    if (Wlan[first2gIndex].BeaconType == 'None')
    {
        setSelect('ssid_encry','encry_none');
		
		setDisable('WlanPassword_password',  1);
		setDisable('tWlanPassword_password', 1);
        setDisable('CkBoxShowPsw',           1);
    }
    else if (Wlan[first2gIndex].BeaconType == 'Basic')
    {
        setSelect('ssid_encry', 'encry_shared');
    }
	else if(Wlan[first2gIndex].BeaconType == 'WPA')
	{
		setSelect('ssid_encry','wpa-psk');
	}
	else if(Wlan[first2gIndex].BeaconType == '11i' || Wlan[first2gIndex].BeaconType == 'WPA2')
	{
		setSelect('ssid_encry','wpa2-psk');
	}
	else if(Wlan[first2gIndex].BeaconType == 'WPAand11i')
	{
		setSelect('ssid_encry','wpa/wpa2-psk');
	}
	else
	{
		setSelect('ssid_encry','wpa/wpa2-psk');
	}
    
	if(WlanWifi[first2gIndex].AutoChannelEnable == '1')
	{
		setSelect('ssid_channel','0');
	}
	else
	{
		setSelect('ssid_channel',WlanWifi[first2gIndex].channel);
	}
	
}

function ShowWifiCfg_5G()
{
	load5GChannelList(WlanWifi[first5gIndex].RegulatoryDomain, WlanWifi[first5gIndex].mode, WlanWifi[first5gIndex].channelWidth);

    setText('osgi_amp_ssid_name_5G', Wlan[first5gIndex].ssid);

    if (Wlan[first5gIndex].BeaconType == 'None')
    {
        setText('WlanPassword_password_5G', "");
        setText('tWlanPassword_password_5G', "");
        wpapskpassword_5G = "";
    }
    else if (Wlan[first5gIndex].BeaconType == 'Basic')
    {
        setText('WlanPassword_password_5G',  g_keys[first5gIndex*4].value);
        setText('tWlanPassword_password_5G', g_keys[first5gIndex*4].value);
        wpapskpassword_5G = g_keys[first5gIndex*4].value;
    }
    else
    {
        setText('WlanPassword_password_5G', wpaPskKey[first5gIndex].value);
        setText('tWlanPassword_password_5G', wpaPskKey[first5gIndex].value);
        wpapskpassword_5G = wpaPskKey[first5gIndex].value;
    }

    setSelect('ssid_rssi_5G', WlanWifi[first5gIndex].power);

    if (Wlan[first5gIndex].BeaconType == 'None')
    {
        setSelect('ssid_encry_5G', 'encry_none');

        setDisable('WlanPassword_password_5G',  1);
        setDisable('tWlanPassword_password_5G', 1);
        setDisable('CkBoxShowPsw_5G',           1);
    }
    else if (Wlan[first5gIndex].BeaconType == 'Basic')
    {
        setSelect('ssid_encry_5G', 'encry_shared');
    }
    else if (Wlan[first5gIndex].BeaconType == 'WPA')
    {
        setSelect('ssid_encry_5G', 'wpa-psk');
    }
    else if (Wlan[first5gIndex].BeaconType == '11i' || Wlan[first5gIndex].BeaconType == 'WPA2')
    {
        setSelect('ssid_encry_5G', 'wpa2-psk');
    }
    else if (Wlan[first5gIndex].BeaconType == 'WPAand11i')
    {
        setSelect('ssid_encry_5G', 'wpa/wpa2-psk');
    }
    else
    {
        setSelect('ssid_encry_5G', 'wpa/wpa2-psk');
    }

    if (WlanWifi[first5gIndex].AutoChannelEnable == '1')
    {
        setSelect('ssid_channel_5G', '0');
    }
    else
    {
        setSelect('ssid_channel_5G', WlanWifi[first5gIndex].channel);
    }
}

function OnAuthModeChange(id)
{
    var enable_idArr = new Array("ssid_encry", "WlanPassword_password", "tWlanPassword_password", "CkBoxShowPsw");
    var wepkey = g_keys[first2gIndex*4].value;
    var pskkey = wpaPskKey[first2gIndex].value;
    
    if ('ssid_encry_5G' == id)
    {
        for (var i = 0; i < enable_idArr.length; i++)
        {
            enable_idArr[i] = enable_idArr[i] + '_5G';
        }

        wepkey = g_keys[first5gIndex*4].value;
        pskkey = wpaPskKey[first5gIndex].value;
    }
   
    value = getSelectVal(enable_idArr[0]);

    if (value == 'encry_none')
    {
        setDisable(enable_idArr[1], 1);
        setDisable(enable_idArr[2], 1);
        setDisable(enable_idArr[3], 1);

        setText(enable_idArr[1], "");
        setText(enable_idArr[2], "");
    }
    else if (value == 'encry_shared')
    {
        setDisable(enable_idArr[1], 0);
        setDisable(enable_idArr[2], 0);
        setDisable(enable_idArr[3], 0);

        setText(enable_idArr[1],  wepkey);
        setText(enable_idArr[2], wepkey);
    }
    else
    {
        setDisable(enable_idArr[1], 0);
        setDisable(enable_idArr[2], 0);
        setDisable(enable_idArr[3], 0);

        setText(enable_idArr[1], pskkey);
        setText(enable_idArr[2], pskkey);
    }
}

function SetWifiEnable(id)
{
    if (id == "swithicon")
    {
	   if (1 == DoubleFreqFlag)
	   {
			if ($("#" + id).attr("src") == "../../../images/nimages/checkon.jpg")
			{
				enbl2G = 0;			
				$("#" + id).attr("src", "../../../images/nimages/checkoff.jpg");
			}
			else
			{
				enbl2G = 1;
				$("#" + id).attr("src", "../../../images/nimages/checkon.jpg");
			}
		}
		else
		{
			if ($("#" + id).attr("src") == "../../../images/nimages/checkon.jpg")
			{
				wifi_enable = 0;			
				$("#" + id).attr("src", "../../../images/nimages/checkoff.jpg");
			}
			else
			{
				wifi_enable = 1;
				$("#" + id).attr("src", "../../../images/nimages/checkon.jpg");
			}
		}
    }
    else
    {
        if ($("#" + id).attr("src") == "../../../images/nimages/checkon.jpg")
        {
            enbl5G = 0;
            $("#" + id).attr("src", "../../../images/nimages/checkoff.jpg");
        }
        else
        {
            enbl5G = 1;
            $("#" + id).attr("src", "../../../images/nimages/checkon.jpg");
        }
    }
}

function addParaRadioEnable(form)
{
    if (enbl2G != RadioEbl2G)
    {
        form.addParameter('r1.Enable', enbl2G);
        url += '&r1=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1';
    }

    if (1 == DoubleFreqFlag)
    {
        if (enbl5G != RadioEbl5G)
        {
            form.addParameter('r2.Enable', enbl5G);
            url += '&r2=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2';
        }
    }
}

function SwitchIconShow(fanaEnable)
{
    if (fanaEnable == '0')
    {
        $("#swithicon").attr("src", "../../../images/nimages/checkoff.jpg");
    }
    else
    {
        $("#swithicon").attr("src", "../../../images/nimages/checkon.jpg");
    }

    if (1 == DoubleFreqFlag)
    {
        if (enbl5G == '0')
        {
            $("#swithicon_5G").attr("src", "../../../images/nimages/checkoff.jpg");
        }
        else
        {
            $("#swithicon_5G").attr("src", "../../../images/nimages/checkon.jpg");
        }
    }
}

function RadioEnableInit()
{
	RadioEbl2G = enbl2G;
	RadioEbl5G = enbl5G;
}

function LoadFrame()
{
	wifi_enable = WlanEnable[0].enable;
	
	RadioEnableInit();
	
	findFirstWlanInst();
	
    if ('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WIFI_POWER_FIX);%>' == '1')
    {
        setDisable('ssid_rssi', 1);
		setDisable('ssid_rssi_5G', 1);
    }
	
    if ('0' == DoubleFreqFlag)
    {
		setDisplay("button", 1);
		
        var final_state;
        
        if (wifi_enable == '0' || WlanWifi[first2gIndex].enable == '0')
        {
            final_state = '0';
        }
        else
        {
            final_state = '1';
        }

        SwitchIconShow(final_state);

        ShowWifiCfg_2G();
    }
    else
    {
		setDisplay("button", 0);
		setDisplay("area_5g", 1);
		
        SwitchIconShow(enbl2G);
        ShowWifiCfg_2G();
        ShowWifiCfg_5G();
    }

    loadlanguage();
}
</script>

<body onLoad="LoadFrame();" style="overflow:auto;overflow-x:hidden">
	<div class="contentItem">
	</div>
	<div class="contentItem">
	</div>

	<div class="contentItem contentSwitchicon">
		<div class="labelBox">
		<script>  
		if ('0' == DoubleFreqFlag)
		{
			document.write("无线开关: ");
		}
		else
		{
			document.write("2.4G无线开关: ");
		} 
		</script> 
		</div>
		<img src="../../../images/nimages/checkon.jpg" id="swithicon" onClick='SetWifiEnable(this.id);'/>
	</div>
	<div class="contentItem">
		<div class="labelBox">
		<script>  
		if ('0' == DoubleFreqFlag)
		{
			document.write("无线名称: ");
		}
		else
		{
			document.write("2.4G无线名称: ");
		} 
		</script> 
		</div>
		<div class="contenbox">
			<input type="text" id="osgi_amp_ssid_name" name="osgi_amp_ssid_name" class="textbox">
		</div>
	</div>
	<div class="contentItem">
		<div class="labelBox">
		<script>  
		if ('0' == DoubleFreqFlag)
		{
			document.write("无线密码: ");
		}
		else
		{
			document.write("2.4G无线密码: ");
		} 
		</script> 
		</div>
		<div class="contenbox">
			<input class="textbox" type='password' autocomplete='off' id='WlanPassword_password' name='WlanPassword_password' onKeyUp="ShowPwdCpy(this);" onchange="wpapskpassword=getValue('WlanPassword_password');getElById('tWlanPassword_password').value=wpapskpassword;"/>
			<input class="textbox" type='text' id='tWlanPassword_password' name='tWlanPassword_password' maxlength='64' style='display:none' onKeyUp="ShowPwdCpy(this);" onchange="wpapskpassword=getValue('tWlanPassword_password');getElById('WlanPassword_password').value=wpapskpassword;"/>
			<td><input type='checkbox' value=0 id='CkBoxShowPsw' name='CkBoxShowPsw' onClick='SetShowWifiPsw(this.id);'></td>
			<td>显示密码</td>
		</div>
	</div>
	<script type="text/javascript">
		InjectCapStateHtml("CapState", '100px', '0px');
		InjectCapStateEvent("WlanPassword_password", "CapState", true);
		InjectCapStateEvent("tWlanPassword_password", "CapState", true);
	</script>
	<div class="contentItem" id="Div_pwd_cpy_info" style="display:none;padding:0;">
		<table id="pwd_cpy_info">
			<tr height="10">
			<td id="space1"></td>
			<td class="labelBox" style=" padding-right:0;" id="simpleicon"><img height="10px;" src="../../../images/nimages/simple.jpg"/></td>
			<td style=" padding-left:0; padding-right:0;" id="mediumicon"><img height="10px;" src="../../../images/nimages/medium.jpg"/></td>
			<td style="padding-left:0;" id="strongicon"><img height="10px;" src="../../../images/nimages/strong.jpg"/></td>
			<td id="space2"></td>
			</tr>
			<tr height="20">
			<td id="space1"></td>
			<td align="center" id="simplechar">弱</td>
			<td align="center" id="mediumchar">中</td>
			<td align="center" id="strongchar">强</td>
			<td ></td>
			</tr>
		</table>
	</div>

	<div class="contentItem">
		<div class="labelBox">信号强度:</div>
		<div class="contenbox" >
			<select  name="ssid_rssi" class="textbox" id="select">
			<option value='100'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_100per']);</script>
			<option value='80'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_80per']);</script>
			<option value='60'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_60per']);</script>
			<option value='40'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_40per']);</script>
			<option value='20'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_20per']);</script>
			</select>
		</div>
	</div>
	<div class="contentItem">
		<div class="labelBox">加密方式:</div>
		<div class="contenbox">
			<select  id="ssid_encry" name="ssid_encry" class="textbox" onChange='OnAuthModeChange(this.id)'>
				<option value='encry_none'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_none']);</script>	
				<option value='encry_shared'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_shared']);</script>			
				<option value='wpa-psk'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_wpapsk']);</script>
				<option value='wpa2-psk'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_wpa2psk']);</script>
				<option value='wpa/wpa2-psk'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_wpawpa2psk']);</script>
			</select>
		</div>
	</div>
	<div class="contentItem">
		<div class="labelBox">信道选择:</div>
		<div class="contenbox">
			<!--select type="text" name="ssid_channel" class="textbox">
				<option value='0'> <script>document.write(cfg_wlancfgadvance_language['amp_chllist_auto']);</script>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
			</select-->
			<select id='ssid_channel' name='ssid_channel' size="1" onChange="ChannelChange()" class="textbox">
				<option value='0'> <script>document.write(cfg_wlancfgadvance_language['amp_chllist_auto']);</script>
			</select>
		</div>
	</div>
	<td>
		<button class="button" id="button" onClick="ApplySubmit();" style="display:none;">确定</button>
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	</td>
<div id="area_5g" style="display:none;">	
	<div class="contentItem contentSwitchicon">
		<div class="labelBox">5G无线开关:</div>
		<img src="../../../images/nimages/checkon.jpg" id="swithicon_5G" onClick='SetWifiEnable(this.id);'/>
	</div>
	<div class="contentItem">
		<div class="labelBox">无线名称:</div>
		<div class="contenbox">
			<input type="text" id="osgi_amp_ssid_name_5G" name="osgi_amp_ssid_name_5G" class="textbox">
		</div>
	</div>
	<div class="contentItem">
		<div class="labelBox">无线密码:</div>
		<div class="contenbox">
			<input class="textbox" type='password' autocomplete='off' id='WlanPassword_password_5G' name='WlanPassword_password_5G' onKeyUp="ShowPwdCpy(this);" onchange="wpapskpassword=getValue('WlanPassword_password_5G');getElById('tWlanPassword_password_5G').value=wpapskpassword;"/>
			<input class="textbox" type='text' id='tWlanPassword_password_5G' name='tWlanPassword_password_5G' maxlength='64' style='display:none' onKeyUp="ShowPwdCpy(this);" onchange="wpapskpassword=getValue('tWlanPassword_password_5G');getElById('WlanPassword_password_5G').value=wpapskpassword;"/>
			<td><input type='checkbox' value=0 id='CkBoxShowPsw_5G' name='CkBoxShowPsw_5G' onClick='SetShowWifiPsw(this.id);'></td>
			<td>显示密码</td>
		</div>
	</div>
	<script type="text/javascript">
		InjectCapStateHtml("CapState_5G", '100px', '0px');
		InjectCapStateEvent("WlanPassword_password_5G", "CapState_5G", true);
		InjectCapStateEvent("tWlanPassword_password_5G", "CapState_5G", true);
	</script>
	<div class="contentItem" id="Div_pwd_cpy_info_5G" style="display:none;padding:0;">
		<table id="pwd_cpy_info">
			<tr height="10">
			<td id="space1"></td>
			<td class="labelBox" style=" padding-right:0;" id="simpleicon_5G"><img height="10px;" src="../../../images/nimages/simple.jpg"/></td>
			<td style=" padding-left:0; padding-right:0;" id="mediumicon_5G"><img height="10px;" src="../../../images/nimages/medium.jpg"/></td>
			<td style="padding-left:0;" id="strongicon_5G"><img height="10px;" src="../../../images/nimages/strong.jpg"/></td>
			<td id="space2"></td>
			</tr>
			<tr height="20">
			<td id="space1"></td>
			<td align="center" id="simplechar_5G">弱</td>
			<td align="center" id="mediumchar_5G">中</td>
			<td align="center" id="strongchar_5G">强</td>
			<td ></td>
			</tr>
		</table>
	</div>

	<div class="contentItem">
		<div class="labelBox">信号强度:</div>
		<div class="contenbox" >
			<select  name="ssid_rssi_5G" class="textbox" id="select">
			<option value='100'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_100per']);</script>
			<option value='80'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_80per']);</script>
			<option value='60'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_60per']);</script>
			<option value='40'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_40per']);</script>
			<option value='20'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_ssid_20per']);</script>
			</select>
		</div>
	</div>
	<div class="contentItem">
		<div class="labelBox">加密方式:</div>
		<div class="contenbox">
			<select  name="ssid_encry_5G" id="ssid_encry_5G" class="textbox" onChange='OnAuthModeChange(this.id)'>
				<option value='encry_none'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_none']);</script>	
				<option value='encry_shared'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_shared']);</script>			
				<option value='wpa-psk'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_wpapsk']);</script>
				<option value='wpa2-psk'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_wpa2psk']);</script>
				<option value='wpa/wpa2-psk'> <script>document.write(osgi_cfg_wifiinfo_language['osgi_amp_auth_wpawpa2psk']);</script>
			</select>
		</div>
	</div>
		<div class="contentItem">
			<div class="labelBox">信道选择:</div>
			<div class="contenbox">
				<select id='ssid_channel_5G' name='ssid_channel_5G' size="1" onChange="ChannelChange()" class="textbox">
					<option value='0'> <script>document.write(cfg_wlancfgadvance_language['amp_chllist_auto']);</script>
				</select>
			</div>
		</div>
	<td>
		<button class="button" id="button_5G" onClick="ApplySubmit();">确定</button>
		<input type="hidden" name="onttoken_5G" id="hwonttoken_5G" value="<%HW_WEB_GetToken();%>">
	</td>
</div>
</body>
</html>