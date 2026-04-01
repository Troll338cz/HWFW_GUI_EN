<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlancfgother_language, cfg_wlancfgdetail_language, cfg_wificover_basic_language, cfg_wlancfgbasic_tde_language);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(ahcode.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="Javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>

<style>
.width_per32 {
	width: 32%;
}
.width_per68 {
	width: 68%;
}
.tabal_noborder_bg {
	padding:0px 0px 10px 0px;
	background-color: #FAFAFA;
}

.helpclass {
	font-size:14px;
	color: #005c8b;
	cursor:pointer;
	white-space:nowrap;
}

.helpclass:link {
	color: #005c8b;
	text-decoration: underline;
}

.helpclass:hover {
	color: #0193de;
	text-decoration: none;
}

</style>
<script language="JavaScript" type="text/javascript">
var wlanpage;
if (location.href.indexOf("GuestWifiTDE.asp?") > 0)
{
    wlanpage = location.href.split("?")[1]; 
    top.WlanBasicPage = wlanpage;
}

wlanpage = top.WlanBasicPage;

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

initWlanCap(wlanpage);

function stWlan(domain,name,enable,ssid,wlShow,BeaconType,BasicEncryptionModes,BasicAuthenticationMode,
                WEPKeyIndex,WEPEncryptionLevel,WPAEncryptionModes,WPAAuthenticationMode,IEEE11iEncryptionModes,IEEE11iAuthenticationMode,
                X_HW_WPAand11iEncryptionModes,X_HW_WPAand11iAuthenticationMode,X_HW_ServiceEnable,mode,channel,Country,AutoChannelEnable,
                X_HW_HT20,wmmEnable,MACAddressControlEnabled,X_HW_AssociateNum)
{
    this.domain = domain;
    this.name = name;
    this.enable = enable;
    this.ssid = ssid;
    this.wlShow = wlShow;
    this.BeaconType = BeaconType;
    this.BasicEncryptionModes = BasicEncryptionModes;
    this.BasicAuthenticationMode = BasicAuthenticationMode;
    this.KeyIndex = WEPKeyIndex;
    this.WEPEncryptionLevel = WEPEncryptionLevel;
    this.WPAEncryptionModes = WPAEncryptionModes;
    this.WPAAuthenticationMode = WPAAuthenticationMode;
    this.IEEE11iEncryptionModes = IEEE11iEncryptionModes;
    this.IEEE11iAuthenticationMode = IEEE11iAuthenticationMode;
    this.X_HW_WPAand11iEncryptionModes = X_HW_WPAand11iEncryptionModes;
    this.X_HW_WPAand11iAuthenticationMode = X_HW_WPAand11iAuthenticationMode;
    this.X_HW_ServiceEnable = X_HW_ServiceEnable;
    this.mode = mode;
    this.channel = parseInt(channel);
    this.RegulatoryDomain = Country;
    this.AutoChannelEnable = parseInt(AutoChannelEnable);
    this.X_HW_HT20 = X_HW_HT20;
    this.wmmEnable = wmmEnable;
    this.MACAddressControlEnabled = MACAddressControlEnabled;
	this.X_HW_AssociateNum= X_HW_AssociateNum;

    if(BeaconType == "None")
    {
        this.BeaconType = "Basic";
        this.BasicEncryptionModes = "None";
        this.BasicAuthenticationMode = "None";
    }
    else if(BeaconType == "WPA2")
    {
        this.BeaconType = "11i";
    }
    else if(BeaconType == "WPA/WPA2")
    {
        this.BeaconType = "WPAand11i";
    }
}

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

function stExtendedWLC(domain, SSIDIndex)
{
    this.domain = domain;
    this.SSIDIndex = SSIDIndex;
}

function ssidNullCheckAndSet()
{
    if(null == Wlan)
    {
        isSsidNull = true;
        Wlan = new stWlan("InternetGatewayDevice.LANDevice.1.WLANConfiguration.1","",0,"",0,"","","",1,"","","","","","","",0,"",0,"",0,"",0,0,0);
        pwdPsk = "";
        pwdWep = "";
    }
    else
    {
        pwdPsk = pwdPsk[0].value;
        pwdWep = pwdWep[Wlan.KeyIndex - 1].value;
    }
}

var Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.3,Name|Enable|SSID|SSIDAdvertisementEnabled|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_ServiceEnable|X_HW_Standard|Channel|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|WMMEnable|MACAddressControlEnabled|X_HW_AssociateNum,stWlan);%>;

var pwdPsk = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.3.PreSharedKey.1,KeyPassphrase,stPreSharedKey);%>;

var pwdWep = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.3.WEPKey.{i},WEPKey,stWEPKey);%>;

if(wlanpage == "5G")
{
    Wlan = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.4,Name|Enable|SSID|SSIDAdvertisementEnabled|BeaconType|BasicEncryptionModes|BasicAuthenticationMode|WEPKeyIndex|WEPEncryptionLevel|WPAEncryptionModes|WPAAuthenticationMode|IEEE11iEncryptionModes|IEEE11iAuthenticationMode|X_HW_WPAand11iEncryptionModes|X_HW_WPAand11iAuthenticationMode|X_HW_ServiceEnable|X_HW_Standard|Channel|RegulatoryDomain|AutoChannelEnable|X_HW_HT20|WMMEnable|MACAddressControlEnabled|X_HW_AssociateNum,stWlan);%>;
    
    pwdPsk = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.4.PreSharedKey.1,KeyPassphrase,stPreSharedKey);%>;
    
    pwdWep = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.4.WEPKey.{i},WEPKey,stWEPKey);%>;
}
function stXHWAdvanceCfg(domain, value)
{
    this.domain = domain;
    this.value = value;
}

var XHWAdvanceCfg = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.Radio.1.X_HW_AdvanceCfg,UsersPerSSIDEnable,stXHWAdvanceCfg);%>;

if(wlanpage == "5G")
{
	XHWAdvanceCfg = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WiFi.Radio.2.X_HW_AdvanceCfg,UsersPerSSIDEnable,stXHWAdvanceCfg);%>;
}

XHWAdvanceCfg = XHWAdvanceCfg[0];

var isSsidNull = false;

Wlan = Wlan[0];
ssidNullCheckAndSet();

var urlNode = '';
var Form = null;
var pwdType = "-1";
var wlanInst = getWlanInstFromDomain(Wlan.domain);
var beaconType = Wlan.BeaconType;

var apExtendedWLC = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.X_HW_APDevice.{i}.WifiCover.ExtendedWLC.{i}, SSIDIndex, stExtendedWLC, EXTEND);%>;

function stGuestWifi(domain,SSID_IDX,PortIsolation,Duration,UpRateLimit,DownRateLimit)
{
	this.domain = domain;
    this.SSID_IDX = SSID_IDX;
	this.PortIsolation = PortIsolation;
	this.Duration = Duration;
	this.UpRateLimit = UpRateLimit;
	this.DownRateLimit = DownRateLimit;
}

if(Wlan.BeaconType == "Basic" && Wlan.BasicAuthenticationMode == "SharedAuthentication")
{
    beaconType = "Shared";
}

var setEnableFlag = 0;
var wifiEnable = 0;

function SetGuestEnable()
{
	setEnableFlag = 1;
	wifiEnable = 1 - wifiEnable;
	if(wifiEnable == 1)
	{
		$("#swithicon").attr("src", "../../../images/cus_images/btn_on.png");
	}
	else
	{
		$("#swithicon").attr("src", "../../../images/cus_images/btn_off.png");
	}
}



function initEncryTypeChange(encry)
{
    var type = "psk";
    var pwd = pwdPsk;
	
    if(encry == "Basic")
    {
        type = "";
        pwd = "";
    }
	
    setWiFiPwd(pwd, type);
}

function initAuthMode()
{
    setSelect("wlAuthMode", beaconType);
	initEncryTypeChange(getSelectVal("wlAuthMode"));
}

function authModeChange()
{
	var authMode = getSelectVal("wlAuthMode");
	initEncryTypeChange(authMode);
}

function setWiFiPwd(pwd, type)
{
    if(pwdType == type)
    {
        return;
    }

    setDisable("PSKssidPwdTxt", 0);

    if ("psk" == type)
    {
        setText("PSKssidPwd", pwd);
        setText("PSKssidPwdTxt", pwd);		
    }
    else if ("" == type)
    {
        setDisable("PSKssidPwdTxt", 1);
        setText("PSKssidPwdTxt", "");
		
        setDisplay("PSKssidPwd", 0);
        setDisplay("PSKssidPwdTxt", 1);
    }
    
    ssidPwdChkClick(type);
    pwdType = type;
    ssidPwdChange(pwdType);
}

function addBackSlash(str)
{
    var strNeedSlash = "\\'\".:,;";
    var strNew = "";
  
    for(var i=0; i<str.length; i++)
    {
        var c = str.charAt(i);
        for(var j=0; j<strNeedSlash.length; j++)
        {
            if(c == strNeedSlash.charAt(j))
            {
                strNew += "\\";
                break;
            }
        }
        strNew += c;
    }
    
    return strNew;
}

function createQRCode()
{
    var qrTxt = "WIFI:";
    var psk = "nopass";    
    var ssid = addBackSlash(Wlan.ssid);
    
    if(beaconType == "Basic")
    {
        if(Wlan.BasicEncryptionModes == "WEPEncryption")
        {
            qrTxt += "T:WEP";
            psk = addBackSlash(pwdWep);
        }
        else
        {
            qrTxt += "T:nopass";
        }
    }
    else if(beaconType == "Shared")
    {
        qrTxt += "T:WEP";
        psk = addBackSlash(pwdWep);
    }
    else
    {
        qrTxt += "T:WPA";
        psk = addBackSlash(pwdPsk);
    }
    
    qrTxt += ";S:" + ssid + ";P:" + psk + ";";
    
    qrTxt += (Wlan.wlShow == "1") ? "H:false;" : "H:true;";
    
    var qrcode = new QRCode(document.getElementById("QRCode"), {
        width : 100,
        height : 100
    });

    qrcode.makeCode(qrTxt);

    $("#QRCode").attr("title", "");
    $("#QRCode table").css({"width":"100px", "height":"100px", "margin":"0px"});
}

function loadNullSsid()
{
    if(isSsidNull)
    {
        $("#WiFiArea input").attr("disabled", "disabled");
        $("#WiFiArea select").empty();
        $("#WiFiArea select").attr("disabled", "disabled");
        
        return false;
    }

    return true;
}

function initSSIDEnable()
{
	wifiEnable = Wlan.enable;
	if(wifiEnable == 1)
	{
		$("#swithicon").attr("src", "../../../images/cus_images/btn_on.png");
	}
	else
	{
		$("#swithicon").attr("src", "../../../images/cus_images/btn_off.png");
	}
}

function initAssociateNum()
{
	if("1" == XHWAdvanceCfg.value)
	{
		setDisplay("wlAssociateNumRow", 1);
		setText("wlAssociateNum", Wlan.X_HW_AssociateNum);
	}
	else
	{
		setDisplay("wlAssociateNumRow", 0);
	}
}

function LoadFrame()
{
    if(!loadNullSsid())
    {
        return ;
    }
	
	initSSIDEnable();
    setText("ssidName", Wlan.ssid);
    
    initAuthMode();
	initAssociateNum();
	
    createQRCode();
}

function checkWep(val)
{
    Form.addParameter('y.WEPEncryptionLevel', '104-bit');
    
    if ( val != '' && val != null)
    {
        if (isSpaceInKey(val))
        {
            AlertEx(val + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + cfg_wlancfgother_language['amp_wpa_space']);
            return false;
        }

       if (isValidKey(val, 13) == false )
       {
           AlertEx(cfg_wlancfgdetail_language['amp_key_check1'] + val + cfg_wlancfgdetail_language['amp_key_invalid1']);
           return false;
       }

       if (isValidStr(val) != '')
       {
           AlertEx(val + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + isValidStr(val));
           return false;
       }
    }
    else
    {
       AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_empty']);
       return false;
    }
    return true;
}

function CheckPwdStrength(val)
{
    var HaveDigit = 0;
    var HaveChar = 0;
    var HaveSpecialChar = 0;

    if(null == val || val.length == 0)
    {
        return "none";
    }

    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch <= '9' && ch >= '0' )
        {
            HaveDigit = 1;
        }
        else if((ch <= 'z' && ch >= 'a') || (ch <= 'Z' && ch >= 'A'))
        {
            HaveChar = 1;
        }
        else
        {
            HaveSpecialChar = 1;
        }
    }

    var Result = HaveDigit + HaveChar + HaveSpecialChar;

	if(pwdType == "psk")
    {
        if(val.length < 8)
        {
            return "none";
        }
        else if(val.length <= 10)
        {
            if(Result == 1)
            {
                return "simple";
            }
            else {
                return "medium";
            }
        }
        else if(val.length <= 63)
        {
            if(Result == 1)
            {
                return "simple";
            }
            else if(Result == 2)
            {
                return "medium";
            }
            else
            {
                return "strong";
            }
        }
        else {
            return "none";
        }
    }
    else
    {
        return "none";
    }
    
}

function ssidPwdChange(pwdType)
{
    var Strength = CheckPwdStrength(getValue('PSKssidPwd'));
	
    if ("simple" == Strength)
    {
        document.getElementById("masker").style.width = "133px";
    }
    else if ("medium" == Strength)
    {
        document.getElementById("masker").style.width = "66px";
    }
    else if ("strong" == Strength)
    {
        document.getElementById("masker").style.width = "0";
    }
    else
    {
        document.getElementById("masker").style.width = "200px";
    }
}

function checkSSIDForTDE(wlan)
{
	var ssid = wlan.ssid;
	
	if(checkSSIDExist(wlan, WlanInfo))
    {
    	return false;
    }

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

    if (true != checkSepcailStrValid(ssid))
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid']);
        return false;
    }
	
	if(getTDEStringActualLen(ssid) > 32)
	{
	    AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_loog']);
        return false;
	}
    
    return true;
}

function checkAddPara()
{
    var ssid = getValue('ssidName');
    ssid = ltrim(ssid);
    Wlan.ssid = ssid;
    if(false == checkSSIDForTDE(Wlan))
    {
        return false;
    }
    Form.addParameter('y.SSID',ssid);

    var pwd = "";
	if(pwdType == "psk")
	{
		pwd = getValue("PSKssidPwd");
		if ((isFireFox4 == 1) && (pwd == ''))
		{
			pwd = getValue("PSKssidPwdTxt");
		}
		
		if(false == isValidWPAPskSepcialKey(pwd))
		{
			return false;
		}
		
		var pskDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration."+wlanInst+".PreSharedKey.1";

		Form.addParameter('p.PreSharedKey', pwd);
		Form.addParameter('p.KeyPassphrase', pwd);
		
		urlNode += "p="+pskDomain+"&";
	}                
 
    return true;
}

function isWifiCoverSsid()
{
    for (var j = 0; j < apExtendedWLC.length - 1; j++)
    {
        if (wlanInst == apExtendedWLC[j].SSIDIndex)
        {
            return true;            
        }
    }
    return false
}

function addCoverPara()
{
    if(!isWifiCoverSsid())
        return true;

    var paraChanged = false;

    var ssidCoverParaArr = [["SsidInst", "", wlanInst], ["SSID", "", Wlan.ssid], ["Standard", "", Wlan.mode], ["BeaconType", "", Wlan.BeaconType], 
		    ["BasicEncryptionModes", "", Wlan.BasicEncryptionModes], ["BasicAuthenticationMode", "", Wlan.BasicAuthenticationMode], 
		    ["WPAEncryptionModes", "", Wlan.WPAEncryptionModes], ["WPAAuthenticationMode", "", Wlan.WPAAuthenticationMode], 
		    ["IEEE11iEncryptionModes", "", Wlan.IEEE11iEncryptionModes], ["IEEE11iAuthenticationMode", "", Wlan.IEEE11iAuthenticationMode], 
		    ["X_HW_WPAand11iEncryptionModes", "MixEncryptionModes", Wlan.X_HW_WPAand11iEncryptionModes], 
		    ["X_HW_WPAand11iAuthenticationMode", "MixAuthenticationMode", Wlan.X_HW_WPAand11iAuthenticationMode], 
		    ["WEPKey", "Key", pwdWep], ["PreSharedKey", "Key", pwdPsk]];
    
    var postForm = $("form[method='POST']");
    
    if(0 == postForm.find("input").length)
    {
        return true;
    }
    
    $.each(ssidCoverParaArr, function(idx, ssidCoverPara){
    
        var key = (ssidCoverPara[1] == "") ? ssidCoverPara[0] : ssidCoverPara[1];
        var value = ssidCoverPara[2];

        var inputPara = postForm.find("input[name$='." + ssidCoverPara[0] + "']");
        if(inputPara.length > 0)
        {
            value = inputPara[0].value;
            paraChanged = true;
        }
        
        Form.addParameter('c.'+key, value);
    });
    
    if(paraChanged)
    {
        urlNode += "c=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&";
        
        return ConfirmEx(cfg_wificover_basic_language['amp_wificover_ssid_change_notify']);
    }
    
    return true;
}

function ssidPwdChkClick(pwdType)
{
    if("psk" == pwdType)
    {
        if (1 == getCheckVal("ssidPwdChk"))
        {
            setDisplay("PSKssidPwd", 1);
            setDisplay("PSKssidPwdTxt", 0);
        }
        else
        {
            setDisplay("PSKssidPwd", 0);
            setDisplay("PSKssidPwdTxt", 1);
        }
    }
}

function addAuthPara()
{
    var curAuthMode = getSelectVal("wlAuthMode");
    var beaconEncryArr = 
               [["Basic", "BasicEncryptionModes", 'None', 'BasicAuthenticationMode', 'None'], 
                ["11i", "IEEE11iEncryptionModes", "AESEncryption", 'IEEE11iAuthenticationMode', 'PSKAuthentication'], 
                ["WPAand11i", "X_HW_WPAand11iEncryptionModes", "TKIPandAESEncryption", 'X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication']];

    Form.addParameter('y.BeaconType', curAuthMode);
    
    if(curAuthMode=="Basic")
    {
    }
    else
    {
        pwdType = "psk";
    }
    
    for(var i=0; i < beaconEncryArr.length; i++)
    {
        if(curAuthMode == beaconEncryArr[i][0])
        {
            Form.addParameter('y.' + beaconEncryArr[i][1], beaconEncryArr[i][2]);
            Form.addParameter('y.' + beaconEncryArr[i][3], beaconEncryArr[i][4]);
            
            break;
        }
    }
}

function addSSIDEnable()
{
	var setWifiEnable = 0;
	if(setEnableFlag == 1)
	{
		//从页面读取
		setWifiEnable = wifiEnable;
		setEnableFlag = 0;
	}
	else
	{
		//从数据库中读取
		setWifiEnable = Wlan.enable;
	}
	
	Form.addParameter('y.Enable', setWifiEnable);
}

function addAssociateNum()
{
	var deviceNum = getValue('wlAssociateNum');

    if (isValidAssoc(deviceNum) == false)
    {
        return false;
    }
	
	var deviceNumInt = parseInt(getValue('wlAssociateNum'),10);
	
	Form.addParameter('y.X_HW_AssociateNum', deviceNumInt);
}

function ApplySubmit()
{    
    Form = new webSubmitForm();
    urlNode = "";
    
    var valid = true;
    var tmp = 0;
	
    if(!checkAddPara() || !addCoverPara())
    {
        return;
    }
	
	addSSIDEnable();
	addAuthPara();
	
	if("1" == XHWAdvanceCfg.value)
	{
		addAssociateNum();
	}

    urlNode += 'y=' + Wlan.domain + "&";
	
    Form.setAction("set.cgi?" + urlNode
	+ 'RequestFile=html/amp/wlanbasic/GuestWifiTDE.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    if(isSsidNull || !isWlanInitFinished(wlanpage, Wlan.mode, Wlan.X_HW_HT20))
    {
        return;
    }
    
    setDisable("apply", 1);
    setDisable("cancel", 1);

    Form.submit();
}

</script>

<style>
#progress {
height: 15px;
width: 200px;
border: 1px solid #CCCCCC;
background-image: url(../../../images/cus_images/strength.png);
background-repeat: repeat-y;
background-color: blue;
z-index: 10;
}
#masker {
float: right;
height: 15px;
width: 200px;
background-color: #FAFAFA;
z-index: 30;
}
#maskertext {
position: absolute;
float: left;
display: inline-block;
font-size: 12px;
z-index: 40;
background: transparent;
margin-top: -2px;
}
#maskertext span {
display: inline-block;
width: 66px;
text-align: center;
}
#PwdStrengthContainer {
float: left;
width: 100%;
vertical-align:middle;
position: relative;
margin-top: 0px;
}
#PwdStrengthIndicator {
height: 36px;
width: 200px;
text-align: center;
font-size: 14px;
}
#guidetitleinfo {
width: 100%;
height: 30px;
border-bottom: 1px solid #A6A6A6;
}
.spanguidetitleinfocss {
padding-left: 15px;
font-size: 14px;
font-family: "微软雅黑";
color: #266B94;
font-weight: bold;
line-height: 30px;
}
#tb1, #tb2{
width: 100%;
margin-left: 10px;
}
</style>

</head>
<body  class="iframebody" onLoad="LoadFrame();" style="text-align: left;">
<div class="title_spread"></div>

<form>

<div id="WiFiArea" class="FuctionPageAreaCss">

<div id="PcTitle" class="FunctionPageTitleCss">
<span id="PageTitleText" class="PageTitleTextCss">WiFi Invitados</span>
</div>

<div class="PageSumaryInfoCss" BindText="amp_wifitde_GuestWifiSumaryInfo"></div>

<table id="tb1" cellspacing="10">
<tr >
	<td BindText="amp_wifitde_enable"></td>
	<td><img style="width:45px;" src="../../../images/cus_images/btn_off.png" id="swithicon" onClick='SetGuestEnable();'/></td>
</tr>
<tr>
<td BindText="amp_wifitde_wifiname"></td>
<td><input id="ssidName" maxlength="32" style="width:200px;" /></td>
</tr>
<tr>
<td style="vertical-align: top; padding-top: 6px;"  BindText="amp_wifitde_wifipwd"></td>
<td>
<div>
<div style="float:left">
<input id="PSKssidPwdTxt" type="text" autocomplete="off" style="width:200px;display:none;" onkeyup="setText('PSKssidPwd', this.value);ssidPwdChange(pwdType);" maxlength="63"/>
<input id="PSKssidPwd" type="password" autocomplete="off" style="width:200px;" onkeyup="setText('PSKssidPwdTxt', this.value);ssidPwdChange(pwdType);" maxlength="63"/>

<input id="ssidPwdChk" type="checkbox" checked onclick="ssidPwdChkClick(pwdType);" />
<span style="font-size:14px;"><script>document.write(cfg_wlancfgdetail_language['amp_wlanpassword_hide']);</script></span>
<div style="font-size: 12px;width: 280px;" BindText="amp_wifitde_pwdnote"></div>
</div>
<div id="PwdStrengthContainer" style="float:right; width:300px;">
  <div id="PwdStrengthIndicator" BindText="amp_wifitde_pwdstrength" style="height: 25px; width: 300px;"></div>
  <div id="progress" style="margin-left: 50px;">
      <div id="masker"></div>
      <div id="maskertext">
        <span BindText="amp_wifitde_pwdstrength_low"></span><span BindText="amp_wifitde_pwdstrength_medium"></span><span BindText="amp_wifitde_pwdstrength_high"></span>
      </div>
  </div>
</div>
</div>

</td>
</tr>
</table>

<table id="tb2" cellspacing="10">
<tr>
<td BindText="amp_wifitde_security_type"></td>
<td>
<select id="wlAuthMode" name="wlAuthMode" style="width:200px;" size="1" onchange="authModeChange()">
<script>
document.write('<option value="11i">' + cfg_wlancfgdetail_language['amp_auth_encrypt_wpa2'] + '</option>');
if(wlanpage != "5G")
{
	document.write('<option value="WPAand11i">' + cfg_wlancfgdetail_language['amp_auth_encrypt_wpawpa2'] + '</option>');
}
document.write('<option value="Basic">' + cfg_wlancfgdetail_language['amp_auth_encrypt_none'] + '</option>');
</script>
</select>
</td>
</tr>
<tr id="wlAssociateNumRow">
<td BindText="amp_wifitde_number_of_associate_device"></td>
<td>
<input id="wlAssociateNum" name="wlAssociateNum" style="width:200px;" size="1" onchange="authModeChange()" />
<span style="font-size:14px;"><script>document.write(cfg_wlancfgbasic_tde_language['amp_wifitde_number_user_per_ssid_note']);</script></span>
</td>
</tr>
</table>


<div class="title_spread"></div>

<div style="overflow:hidden;zoom:1;">
<div id="QRCode" style="float:right;margin-right: 152px;"></div>
<div class="PageSumaryInfoCss" style="width: 600px;margin-left:22px;" BindText="amp_wifitde_qrcode_note"></div>
</div>

<div class="ButtonListCss" style="margin-left: 22px;">
    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    <input id="apply" type="button" BindText="amp_wifitde_apply" class="BluebuttonGreenBgcss width_120px" onClick="ApplySubmit();" />
</div>

</div>

<div class="DivSpread_30PX"></div>


<script>
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "div",  1);
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "td",  1);
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "span",  1);
ParseBindTextByTagName(cfg_wlancfgbasic_tde_language, "input", 2);

$("#tb1 td:nth-child(1)").addClass("PageSumaryTitleCss").css({"width":"30%"});
$("#tb2 td:nth-child(1)").addClass("PageSumaryTitleCss").css({"width":"30%"});

function stPageJump(id, NameStr, name)
{
this.id = id;
this.NameStr = NameStr;
this.name = name;
}

function gotoHelp()
{
    valinfo = new stPageJump("", cfg_wlancfgbasic_tde_language['amp_wifitde_note_help'], "CustomApp/helpinfo.asp");
    top.helpId = "WiFiHelp";
    window.parent.OnChangeIframeShowPage(valinfo); 
}
</script>

</form>

</body>

</html>
