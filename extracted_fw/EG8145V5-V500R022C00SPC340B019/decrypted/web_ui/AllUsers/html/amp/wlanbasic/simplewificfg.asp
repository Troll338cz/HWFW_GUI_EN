<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="javascript" src="../common/wlan_extended.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<style type='text/css'>
span.language-string {
    padding: 0px 15px;
    display: block;
    height: 40px;
    line-height: 40px;
}
</style>
<title>WiFi Configuration</title>
<script language="JavaScript" type="text/javascript">

var isFireFox4 = 0;
if (navigator.userAgent.toLowerCase().indexOf('firefox/4.0') > 0)
{
	isFireFox4 = 1;
}

var enbl2G = 0;
var enbl5G = 0;
var wlan1 = null;
var wlan5 = null;

var allPsk;
var allWep;
var wlan5_exist = false;
var encryTypeArr = new Array();
var pwdNoticeArr = new Array("pwd_2g_notice", "pwd_5g_notice");
var wifipwdLenArr = new Array("pwd_2g_wifipwd", "pwd_5g_wifipwd");
var wifipwdTextArr = new Array("txt_2g_wifipwd","txt_5g_wifipwd");
var wifi2g_enable;
var wifi5g_enable;
var psk1 = "";
var psk5 = "";
var wep1 = "";
var wep5 = "";
var url = "";
var curUserType='<%HW_WEB_GetUserType();%>';
var sysUserType='0';
var sptUserType = '1';
var maxisNormalUserType = '2';
var wifiPasswordMask='<%HW_WEB_GetWlanPsdMask();%>';
var AmpTDESepicalCharaterFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TDE_SEPCIAL_CHARACTER);%>';
var t2Flag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TDEWIFI);%>';
var PTVDFFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_PTVDF);%>';
var DslTalkTalkFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TALKTALK);%>';
var tmczstFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TMCZST);%>';
var webEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebEnable);%>';
var webAdminEnable5G = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.LANDevice.1.WiFi.X_HW_Wlan5GwebAadminEnable);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var hiLinkRoll = '<%HW_WEB_GetHilinkRole();%>';
var bondingEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WifiCoverService.BondingEnable);%>';
var bsdPolicy;
var isSet5Gflag = 0;
var ssid5GIndex = 0;
var isVideoRetrans = '<%HW_WEB_GetFeatureSupport(FT_WLAN_VIDEO_TRANS);%>';
var megacablePwd = '<%HW_WEB_GetFeatureSupport(FT_WLAN_MEGACABLEPWD);%>';
var isFitAp = 0;
var fitApFt = '<%HW_WEB_GetFeatureSupport(FT_FIT_AP);%>';
var fitApEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Capwap.APMode);%>';
if ((fitApFt == 1) && (fitApEnable == 1)) {
    isFitAp = 1;
}
var TypeWord = '<%HW_WEB_GetTypeWordMode();%>';
var ssidTips = cfg_wlancfgdetail_language['amp_linkname_note'];
if (1 == DslTalkTalkFlag)
{
	ssidTips = cfg_wlancfgdetail_language['amp_linkname_note_dslTT'];
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

function isValIdRule(val)
{	
	var reg = /^[A-Za-z0-9-]+$/;
	if(val.match(reg))
	{
		return val;
	}
	else
	{
		return '';
	}
}

function isValPWDRule(val)
{	
	var reg = /^[A-Za-z0-9]+$/;
	if(val.match(reg))
	{
		return val;
	}
	else
	{
		return '';
	}
}

if(allWlanInfo != null && allWlanInfo.length > 1)
{
	allWlanInfo.pop();
	
	allWlanInfo.sort(function(s1, s2)
	    {
	        return parseInt(s1.name.charAt(s1.name.length - 1), 10) - parseInt(s2.name.charAt(s2.name.length - 1), 10);
	    }
	);
}

allPsk = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey|KeyPassphrase,stPreSharedKey);%>;
allWep = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WEPKey.{i},WEPKey,stWEPKey);%>;


function stWpsPin(domain, X_HW_ConfigMethod, DevicePassword, X_HW_PinGenerator, Enable)
{
    this.domain = domain;
    this.X_HW_ConfigMethod = X_HW_ConfigMethod;
    this.DevicePassword = DevicePassword;
    this.X_HW_PinGenerator = X_HW_PinGenerator;
    this.Enable = Enable;
}


var wpsPinNum = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.WPS,X_HW_ConfigMethod|DevicePassword|X_HW_PinGenerator|Enable,stWpsPin);%>;


var wpsEnableArray = new Array(-1, -1);
function checkWps(id, WpsEnable, index)
{
	if('1' == t2Flag)
    {
        if(1 == getCheckVal(id))
        {
            AlertEx(cfg_wlancfgbasic_tde_language['amp_wifitde_ssidhide_alert']);
			wpsEnableArray[index] = 0;	
        }
        else
        {
            AlertEx(cfg_wlancfgbasic_tde_language['amp_wifitde_ssidshow_alert']);
			wpsEnableArray[index] = 1;	
        }
    }
    else if (1 == PTVDFFlag)
    {
        if((1 == WpsEnable) && (1 == getCheckVal(id)))
        {
            AlertEx(cfg_wlancfgother_language['amp_bcastssid_off_help']);
            setCheck(id,0);
        }
    }
}

function StApDevice(domain, DeviceType, SerialNumber, DeviceStatus, UpTime, WorkingMode, SyncStatus, SupportedWorkingMode, SupportedRFBand, SupportedSSIDNumber, UpAccessSsidInst) {
    this.domain = domain;
    this.DeviceType = DeviceType;
    this.SerialNumber = SerialNumber;
    this.DeviceStatus = DeviceStatus;
    this.UpTime = UpTime;
    this.WorkingMode = WorkingMode;
    this.SyncStatus = SyncStatus;
    this.SupportedWorkingMode = SupportedWorkingMode;
    this.SupportedRFBand = SupportedRFBand;
    this.SupportedSSIDNumber = SupportedSSIDNumber;
    this.UpAccessSsidInst = UpAccessSsidInst;
}

var apDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i}, DeviceType|SerialNumber|DeviceStatus|UpTime|WorkingMode|SyncStatus|SupportedWorkingMode|SupportedRFBand|SupportedSSIDNumber|UpAccessSsidInst, StApDevice);%>;
var usefulApDeviceList = new Array();
for (var i = 0; i < apDeviceList.length - 1; i++) {
    if ((apDeviceList[i].DeviceType != '') && (apDeviceList[i].SerialNumber != '')) {
        usefulApDeviceList.push(apDeviceList[i]);
    }
}
var apNum = usefulApDeviceList.length;

function hide2GSsidClick(id)
{
	var WpsEnable2g = 1;

	for(var loop =0;loop<WlanInfo.length-1;loop++)
	{
		if(WlanInfo[loop].name == 'ath0')
		{
			WpsEnable2g = wpsPinNum[loop].Enable;
		}
	}
	
	checkWps(id, WpsEnable2g, 0);
}

function hide5GSsidClick(id)
{
	var WpsEnable5g = 1;

	for(var loop =0;loop<WlanInfo.length-1;loop++)
	{
		if(WlanInfo[loop].name == 'ath4')
		{
			WpsEnable5g = wpsPinNum[loop].Enable;
		}
	}
	

	checkWps(id, WpsEnable5g, 1);
}

function isWepChanged(newWep, wlan)
{
	return newWep != getWep(wlan.InstId, wlan.KeyIndex, allWep);
}

function isPskChanged(newPsk, wlan)
{
	return newPsk != getPsk(wlan.InstId, allPsk);
}

function getWlan()
{
	wlan1 = getFirstSSIDInst(1, allWlanInfo);
	
	if(null != wlan1)
	{
		psk1 = getPsk(wlan1.InstId, allPsk);
		wep1 = getWep(wlan1.InstId, wlan1.KeyIndex, allWep);
        convStdAuthMode(wlan1);
	}

	if(1 == DoubleFreqFlag)
	{
		wlan5 = getFirstSSIDInst(2, allWlanInfo);
		wlan5_exist = (null != wlan5);

		if(wlan5_exist)
		{
			psk5 = getPsk(wlan5.InstId, allPsk);
			wep5 = getWep(wlan5.InstId, wlan5.KeyIndex, allWep);
            convStdAuthMode(wlan5);
		}
	}
}

function initWlanEncType(wlan)
{
	var idx = wlan==wlan1?0:1;
    var wifipwdlen = document.getElementById(wifipwdLenArr[idx]); 
	var wifitxtlen = document.getElementById(wifipwdTextArr[idx]);
	
	if(wlan.BeaconType == 'Basic')
	{
		if(wlan.BasicEncryptionModes == 'WEPEncryption')
		{
			encryTypeArr[idx] = "wep";
		}
		else
		{
			encryTypeArr[idx] = "none";
		}
	}
	else
	{
		encryTypeArr[idx] = "psk";
	}

    if (encryTypeArr[idx] == "wep") {
        if(wlan.WEPEncryptionLevel == "104-bit") {
            getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_encrypt_keynote_128'];
            wifipwdlen.maxLength = 26;
            wifitxtlen.maxLength = 26;
        } else {
            getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_encrypt_keynote_64'];
            wifipwdlen.maxLength = 10;
            wifitxtlen.maxLength = 10;
        }
    } else {
        if ((wlan.BeaconType == "WPA3") || (wlan.BeaconType == "WPA2/WPA3")) {
            if (megacablePwd == 1) {
                getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63_telmex'];
            } else {
                getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_63'];
            }
            wifipwdlen.maxLength = 63;
            wifitxtlen.maxLength = 63;
        } else {
        if (megacablePwd == 1) {
            getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote_telmex'];
        } else {
            getElById(pwdNoticeArr[idx]).innerHTML = cfg_wlancfgdetail_language['amp_wpa_psknote' + ('1' == kppUsedFlag ? '_63' : '')];
        }
            wifipwdlen.maxLength = 64;
            wifitxtlen.maxLength = 64;
        }
    }

    if (CfgMode.toUpperCase() == "EGVDF2") {
        getElById(pwdNoticeArr[idx]).innerHTML = "(" + cfg_wlancfgdetail_language['amp_encrypt_keynote_eg'] + ")";
    }
}

function checkPasswordStrength(id) {
    var score = 0;
    var passWord = document.getElementById(id).value;

    if (passWord.length < 8) {
        return 0;
    }

    if (isLowercaseInString(passWord)) {
        score++;
    }
    if (isUppercaseInString(passWord)) {
        score++;
    }
    if (isDigitInString(passWord)) {
        score++;
    }
    if (isSpecialCharacterNoSpace(passWord)) {
        score++;
    }

    return score;
}

function initEncType()
{
	initWlanEncType(wlan1);
	
	if(wlan5_exist)
	{
		initWlanEncType(wlan5)
	}
}

function setRadioEnable(id ,enabled)
{
	if(1 == enabled)
	{
        if (CfgMode == "DICELANDVDF") {
            getElById(id).style.background = "url(../../../images/onred.jpg) no-repeat";
        } else {
            getElById(id).style.background = "url(../../../images/on.jpg) no-repeat";
        }
	}
	else
	{
		getElById(id).style.background = "url(../../../images/off.jpg) no-repeat";
	}
}

function refreshWiFi(flag)
{
	var enable_idArr = new Array("txt_2g_wifiname", "pwd_2g_wifipwd", "cb_2g_hide", "cb_2g_pwd", "txt_2g_wifipwd");
	var radioEnabled;
	
	if(flag)
	{
		for(var i=0; i<enable_idArr.length; i++)
		{
			enable_idArr[i] = enable_idArr[i].replace("2g", "5g");
		}
		radioEnabled = enbl5G;
	}
	else
	{
		radioEnabled = enbl2G;
	}
	
	if(radioEnabled == 1)
	{	
		$.each(enable_idArr,function(n,value) {  
				getElById(value).removeAttribute('disabled');
            });
	}
	else
	{
		$.each(enable_idArr,function(n,value) {  
				getElById(value).disabled = "disabled";
            });  
	}

	if ((curUserType == sysUserType) && (wifiPasswordMask == '1') ) {
		getElById("cb_2g_pwd").style.display = 'none';
		getElById("cb_5g_pwd").style.display = 'none';
		getElById("hideId2").style.display = 'none';
		getElById("hideId5").style.display = 'none';
	}
}

function IsAdminUser() {
    if ((curUserType == sysUserType) || ((CfgMode.toUpperCase() == 'DETHMAXIS') && (curUserType == sptUserType))) {
        return true;
    }

    return false;
}

function EnableWiFi(id)
{		
    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        return;
    }
	var flag;
	var wlan;
	
	if(id=="enable2g")
	{
		enbl2G = 1 - enbl2G;
		flag = 0;
		wlan = wlan1;
		setRadioEnable(id ,enbl2G)
	}
	else
	{
        if ((bondingEnable == 1) && (apNum > 0)) {
            if (enbl5G == 1) {
                AlertEx(cfg_wlancfgother_language['amp_bonding_sug']);
            }
        }

		enbl5G = 1 - enbl5G;
		flag = 1;
		wlan = wlan5;
		setRadioEnable(id ,enbl5G)
	}

	if(null != wlan)
	{
        if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) == -1) {
            refreshWiFi(flag);
        }
	}
}

function setPwdText(idx)
{
	var pwdId = idx?"pwd_5g_wifipwd":"pwd_2g_wifipwd";
	var txtId = idx?"txt_5g_wifipwd":"txt_2g_wifipwd";
	if(encryTypeArr[idx] == "none")
	{
		setText(pwdId, "");
	}
	else
	{
		var pwd = (encryTypeArr[idx] == "wep")?(idx?wep5:wep1):(idx?psk5:psk1);
		setText(pwdId, pwd);
		setText(txtId, pwd);
	}
}

function IsTmczstShow5G() {
    if (((webEnable5G != 1) && (curUserType != 0)) || ((webAdminEnable5G != 1) && (curUserType == 0))) {
        return true;
    }

    return false;
}

function InitPwdStrength()
{
    $("#checkinfo1Row").css("display", "none");
    var pwdcheck1 = document.getElementById('checkinfo1');
    pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd1" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1"></span> </div></div>';

    
    $("#checkinfo2Row").css("display", "none");
    var pwdcheck2 = document.getElementById('checkinfo2');
    pwdcheck2.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd2" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue2"></span></div></div>';
}

function LoadFrame()
{
	getWlan();

	if (CfgMode.toUpperCase() == "EGVDF2") {
		InitPwdStrength();
	}

	if(null != wlan1)
	{
		initWlanEncType(wlan1);

        if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) >= 0) {
            enbl2G = wlan1.Enable;
        } else {
            enbl2G = Radio[0].Enable;
        }
		setText("txt_2g_wifiname", wlan1.ssid);
		setPwdText(0);
		getElById("cb_2g_hide").checked = wlan1.SSIDAdvertisementEnabled==1?false:true;
	}
	else
	{
		enbl2G = 0;
	}

    if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) == -1) {
        refreshWiFi(0);
    }

    if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) >= 0) {
        enbl2G = wlan1.Enable;
    } else {
        enbl2G = Radio[0].Enable;
    }
	setRadioEnable("enable2g", enbl2G);
	
	if(1 == DoubleFreqFlag)
	{
        if ((tmczstFlag == 1) && (IsTmczstShow5G())) {
            setDisplay('tb_5g', 0);
            setDisplay('div_separatrix1', 0);
        } else {
            setDisplay('tb_5g', 1);
            setDisplay('div_separatrix1', 1);
        }

		if(null != wlan5)
		{
			initWlanEncType(wlan5);

            if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) >= 0) {
                enbl5G = wlan5.Enable;
            } else {
                enbl5G = Radio[1].Enable;
            }
			setText("txt_5g_wifiname", wlan5.ssid);
			setPwdText(1);
			getElById("cb_5g_hide").checked = wlan5.SSIDAdvertisementEnabled==1?false:true;
		}
		else
		{
			enbl5G = 0;
		}
        if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) == -1) {
            refreshWiFi(1);
        }

        if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) >= 0) {
            enbl5G = wlan5.Enable;
        } else {
            enbl5G = Radio[1].Enable;
        }
		setRadioEnable("enable5g", enbl5G);
	}
	
    if((curUserType == sysUserType) && (wifiPasswordMask == '1')) {
        getElById("cb_2g_pwd").style.display = 'none';
        getElById("cb_5g_pwd").style.display = 'none';
        getElById("hideId2").style.display = 'none';
        getElById("hideId5").style.display = 'none';
    }
    if ((CfgMode.toUpperCase() == "ANTEL2") && (curUserType != 0)) {
        setDisplay('hide_2g', 0);
        setDisplay('hide_5g', 0);
    }

    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
        getElById("txt_2g_wifititle").innerHTML = cfg_wlancfgother_language['amp_wlan_enable'];
    }

    if (isVideoRetrans == 1) {
        setDisplay("tb_2g", 0);
    }

    SetBSDShow();
	SetDomDisabled();
    AdjustHtmlHeight();
    setTimeout(function(){AlertSsidNeedCfg();}, 100);

    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        setDisable("enable2g", 1);
        setDisable("txt_2g_wifiname", 1);
        setDisable("pwd_2g_wifipwd", 1);
        setDisable("cb_2g_pwd", 1);
        setDisable("cb_2g_hide", 1);
        setDisable("enable5g", 1);
        setDisable("txt_5g_wifiname", 1);
        setDisable("pwd_5g_wifipwd", 1);
        setDisable("cb_5g_hide", 1);
        setDisable("cb_5g_pwd", 1);
        setDisable("btnSave", 1);
        setDisable("btnCancel", 1);
    }

    if (isFitAp == 1) {
        setDisable("txt_2g_wifiname", 1);
        getElementById("txt_2g_wifiname").style.color = "grey";
        setDisable("txt_5g_wifiname", 1);
        getElementById("txt_5g_wifiname").style.color = "grey";
        setDisable("pwd_2g_wifipwd", 1);
        getElementById("pwd_2g_wifipwd").style.color = "grey";
        setDisable("txt_2g_wifipwd", 1);
        getElementById("txt_2g_wifipwd").style.color = "grey";
        setDisable("pwd_5g_wifipwd", 1);
        getElementById("pwd_5g_wifipwd").style.color = "grey";
        setDisable("txt_5g_wifipwd", 1);
        getElementById("txt_5g_wifipwd").style.color = "grey";
        setDisable("btnSave", 1);
        setDisable("enable2g", 1);
        $("#enable2g").removeAttr("onclick");
        setDisable("enable5g", 1);
        $("#enable5g").removeAttr("onclick");
    }
}

function SetDomDisabled() {
    if (((CfgMode.toUpperCase() != 'COCLAROEBG4') || (curUserType != sptUserType)) &&
        ((curUserType != maxisNormalUserType) || (CfgMode.toUpperCase() != 'DETHMAXIS'))) {
        return;
    }

    setDisplay('hide_2g', 0);
    setDisable('cb_2g_hide', 1);
    setDisable('txt_2g_wifiname', 1);
    $("#txt_2g_wifiname").css("background-color","#CCCCCC");
    if (DoubleFreqFlag == 1) {
        setDisplay('hide_5g', 0);
        setDisable('cb_5g_hide', 1);
        setDisable('txt_5g_wifiname', 1);
        $("#txt_5g_wifiname").css("background-color","#CCCCCC");
    }

    if (CfgMode.toUpperCase() == 'DETHMAXIS') {
        setDisable('txt_2g_wifiname', 0);
        if (DoubleFreqFlag == 1) {
            setDisable('txt_5g_wifiname', 0);
        }
    }
}

function AdjustHtmlHeight() {
    var h = $('body').outerHeight(true);
    window.parent.adjustParentHeight("ConfigWifiPage", h + 10);
}

function AdjustHtmlHeightPwdStrength()
{
    var h = $('body').outerHeight(true);
    window.parent.adjustParentHeight("ConfigWifiPage", h + 5);
}

function showPwd(id)
{
	var pwdId = id=="cb_2g_pwd"?"pwd_2g_wifipwd":"pwd_5g_wifipwd";
	var txtId = id=="cb_2g_pwd"?"txt_2g_wifipwd":"txt_5g_wifipwd";
	
	if(getElById(pwdId).style.display == "none")
	{
		setDisplay(pwdId, 1);
		setDisplay(txtId, 0);
	}
	else
	{
		setDisplay(pwdId, 0);
		setDisplay(txtId, 1);
	}
}

function isValidKey(val, size)
{
    var len = val.length;
    var dbSize = size * 2;

    if (isValidAscii(val) != '') {
        return false;
    }

    if (len == size) {
        return true;
    }

    if (len == dbSize) {
        for (i = 0; i < dbSize; i++) {
            if (isHexaDigit(val.charAt(i)) == false) {
                return false;
            }
        }
        return true;
    }

    return false;
}


function checkWep(val, keyBit)
{
	if ( val != '' && val != null)
	{
	   
	   if ( keyBit == '104-bit' )
	   {
		   if (isValidKey(val, 13) == false )
		   {
			   AlertEx(cfg_wlancfgdetail_language['amp_key_check1'] + val + cfg_wlancfgdetail_language['amp_key_invalid1']);
			   return false;
		   }
	   }
	   else
	   {
		   if (isValidKey(val, 5) == false )
		   {
			   AlertEx(cfg_wlancfgdetail_language['amp_key_check1'] + val + cfg_wlancfgdetail_language['amp_key_invalid2']);
			   return false;
		   }
	   }

	}
	else
	{
	   AlertEx(cfg_wlancfgdetail_language['amp_wifipwd_empty']);
	   return false;
	}
	return true;
}





function checkSsid(ssid)
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
	
	if (1 == DslTalkTalkFlag)
	{
		if (ssid.length < 3)
		{
			AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_too_short']);
			return false;
		}
	}

    if ((isValidAscii(ssid) != '') && (CfgMode.toUpperCase() != "TTNET2"))
    {
        AlertEx(cfg_wlancfgother_language['amp_ssid_check1'] + ssid + cfg_wlancfgother_language['amp_ssid_invalid'] + isValidAscii(ssid));
        return false;
    }
	
	return true;
}

function addRadioEnablePara(form)
{
    var coverFlag2G = false;
    var coverFlag5G = false;
    var oldRadioEbl = Radio[0].Enable;
    if (enbl2G != oldRadioEbl) {
        coverFlag2G = true;
    }

    if (DoubleFreqFlag == 1) {
        oldRadioEbl = Radio[1].Enable;
        if (enbl5G != oldRadioEbl) {
            coverFlag5G = true;
        }
    }

    if (hiLinkRoll != 0) {
        if (coverFlag2G && coverFlag5G) {
            form.addParameter('r3.RadioInst', 0);
            form.addParameter('r3.FirstBandEnable', enbl2G);
            form.addParameter('r3.SecondBandEnable', enbl5G);
            url += 'r3=InternetGatewayDevice.X_HW_DEBUG.AMP.SetDualWifiCoverEnable&';
        } else if (coverFlag2G) {
            form.addParameter('r3.RadioInst', 1);
            form.addParameter('r3.FirstBandEnable', enbl2G);
            url += 'r3=InternetGatewayDevice.X_HW_DEBUG.AMP.SetDualWifiCoverEnable&';
        } else if (coverFlag5G) {
            form.addParameter('r3.RadioInst', 2);
            form.addParameter('r3.FirstBandEnable', enbl5G);
            url += 'r3=InternetGatewayDevice.X_HW_DEBUG.AMP.SetDualWifiCoverEnable&';
        }
    }

    if (coverFlag2G) {
        form.addParameter('r1.Enable',enbl2G);
        url += 'r1=InternetGatewayDevice.LANDevice.1.WiFi.Radio.1&';
    }

    if (coverFlag5G) {
        form.addParameter('r2.Enable', enbl5G);
        url += 'r2=InternetGatewayDevice.LANDevice.1.WiFi.Radio.2&';
    }
}

function addParaForCover(wlan, form) 
{
	var wlanInst = wlan.InstId;
	var idx = wlan==wlan1?0:1;
	var coverIndex = (idx == 0)?'':'5G';
	form.addParameter('m' + '.SsidInst' + coverIndex, (idx == 0)?1:5);
	form.addParameter('m' + '.Enable' + coverIndex, wlan.Enable);
	form.addParameter('m' + '.WMMEnable' + coverIndex, wlan.WMMEnable);
	form.addParameter('m' + '.STAIsolation' + coverIndex, wlan.IsolationEnable);
	form.addParameter('m' + '.MaxAssociateNum' + coverIndex, wlan.X_HW_AssociateNum);
}

function addParaWlan(wlan, form)
{
	var wlanInst = wlan.InstId;
	var idx = wlan==wlan1?0:1;
	var wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst;
	var pwd = idx?getValue("pwd_5g_wifipwd"):getValue("pwd_2g_wifipwd");

    if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) >= 0) {
        var ssidEnable = idx?enbl5G:enbl2G;
    }
	if ((isFireFox4 == 1) && (pwd == ''))
	{
		pwd = idx?getValue("txt_5g_wifipwd"):getValue("txt_2g_wifipwd");
	}
	
	var coverIndex = (idx == 0)?'':'5G';
	var ssid = idx?getValue("txt_5g_wifiname"):getValue("txt_2g_wifiname");
	var ssidVisible = 1 - (idx?getCheckVal("cb_5g_hide"):getCheckVal("cb_2g_hide"));
	
	if (true == AmpTDESepicalCharaterFlag)
	{
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
	}
	else
	{ 
	    if(!checkSsid(ssid))
	    {
		  return false;
	    }
	}
	wlan.ssid = ssid;
	if(checkSSIDExist(wlan, allWlanInfo))
		return false;
	
	if(encryTypeArr[idx] == "wep")
	{	
		var wep1Domain = wlanDomain + ".WEPKey." + wlan.KeyIndex;
		if(!checkWep(pwd, wlan.WEPEncryptionLevel))
			return false;
		
		if(isWepChanged(pwd, wlan))
		{
			form.addParameter('wep'+idx+'.WEPKey', pwd);
			url += "wep"+idx+"="+wep1Domain+"&";
		}
	}
	else
	{
		var pskDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration."+wlanInst+".PreSharedKey.1";
        if (true == AmpTDESepicalCharaterFlag)
	    {
	        if (true != isValidWPAPskSepcialKey(pwd))
            {
                return false;
            }
	    }
	    else
	    { 
	        if(!CheckPsk(pwd))
	        {
		       return false;
	        }
	    }
	
		
        if ((encryTypeArr[idx] == "none") || (isPskChanged(pwd, wlan)) || ((fttrFlag == 1) && (DoubleFreqFlag != 1) && (curUserType != 0))) {
            form.addParameter('psk'+idx+'.PreSharedKey', pwd);
            form.addParameter('m' + '.Key' + coverIndex, pwd);

            if (kppUsedFlag == '1') {
                form.addParameter('psk'+idx+'.KeyPassphrase', pwd);
            }

            url += "psk"+idx+"="+pskDomain+"&";
            if (isSet5Gflag == 1) {
                url += "PSK" + idx + "=" + allWlanInfo[ssid5GIndex].domain + ".PreSharedKey.1&";
            }
        }
	}
	
	if(encryTypeArr[idx] == "none")
	{
		form.addParameter('w'+idx+'.BeaconType', "WPAand11i");
        form.addParameter('w'+idx+'.X_HW_WPAand11iAuthenticationMode','PSKAuthentication');
		form.addParameter('w'+idx+'.X_HW_WPAand11iEncryptionModes', "TKIPandAESEncryption");
		
		form.addParameter('m' + '.BeaconType' + coverIndex, 'WPAand11i');
        form.addParameter('m' + '.MixAuthenticationMode' + coverIndex, 'PSKAuthentication');
        form.addParameter('m' + '.MixEncryptionModes' + coverIndex, "TKIPandAESEncryption");
	}

    if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) >= 0) {
        form.addParameter('w'+idx+'.Enable', ssidEnable);
    }
	form.addParameter('w'+idx+'.SSID', ssid);
	form.addParameter('w'+idx+'.SSIDAdvertisementEnabled', ssidVisible);
	form.addParameter('m' + '.SSID' + coverIndex, ssid);
	form.addParameter('m' + '.SSIDAdvertisementEnabled' + coverIndex, ssidVisible);
	url += "w"+idx+"="+wlanDomain+"&";
    if (isSet5Gflag == 1) {
        url += "W" + idx + "=" + allWlanInfo[ssid5GIndex].domain + "&";
    }

	if ('1' == t2Flag)
	{
		if (wpsEnableArray[idx] >=0 )
		{
			form.addParameter('z'+idx+'.Enable', wpsEnableArray[idx]);
			url += "z"+idx+"="+wlanDomain + '.WPS'+"&";
		}
	}
	
	addParaForCover(wlan, form);
	
	return true;
}

function AddParaWlanForBSD(form) {
    var wlanInst = wlan5.InstId;
    var idx = 1;
    var wlanDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst;
    var pwd = getValue("pwd_2g_wifipwd");
    if ((isFireFox4 == 1) && (pwd == '')) {
        pwd = getValue("txt_2g_wifipwd");
    }

    var coverIndex = '5G';
    var ssid = getValue("txt_2g_wifiname");

    var ssidVisible = 1 - (getCheckVal("cb_2g_hide"));

    if (!checkSsid(ssid)) {
        return false;
    }

    wlan5.ssid = ssid;
    if (checkSSIDExist(wlan5, allWlanInfo)) {
        return false;
    }

    var pskDomain = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + wlanInst + ".PreSharedKey.1";

    if (!CheckPsk(pwd)) {
        return false;
    }

    if ((encryTypeArr[0] == "none") || isPskChanged(pwd, wlan5)) {
        form.addParameter('psk' + idx + '.PreSharedKey', pwd);
        form.addParameter('m' + '.Key' + coverIndex, pwd);

        if (kppUsedFlag == '1') {
            form.addParameter('psk' + idx + '.KeyPassphrase', pwd);
        }

        url += "psk" + idx + "=" + pskDomain + "&";
    }

    form.addParameter('w' + idx + '.Enable', wlan1.Enable);

    if (encryTypeArr[0] == "none") {
        form.addParameter('w' + idx + '.BeaconType', "WPAand11i");
        form.addParameter('w' + idx + '.X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication');
        form.addParameter('w' + idx + '.X_HW_WPAand11iEncryptionModes', "TKIPandAESEncryption");
        form.addParameter('m' + '.BeaconType' + coverIndex, 'WPAand11i');
        form.addParameter('m' + '.MixAuthenticationMode' + coverIndex, 'PSKAuthentication');
        form.addParameter('m' + '.MixEncryptionModes' + coverIndex, "TKIPandAESEncryption");
    } else if ((wlan1.BeaconType == 'WPA') || (wlan1.BeaconType == '11i') || (wlan1.BeaconType == 'WPA2') || 
                (wlan1.BeaconType == 'WPAand11i') || (wlan1.BeaconType == 'WPA/WPA2')) {
        form.addParameter('w' + idx + '.BeaconType', wlan1.BeaconType);
        form.addParameter('m' + '.BeaconType' + coverIndex, wlan1.BeaconType);

        if (wlan1.BeaconType == 'WPA') {
            form.addParameter('w' + idx + '.WPAAuthenticationMode', wlan1.WPAAuthenticationMode);
            form.addParameter('w' + idx + '.WPAEncryptionModes', wlan1.WPAEncryptionModes);
            form.addParameter('m' + '.WPAAuthenticationMode' + coverIndex, wlan1.WPAAuthenticationMode);
            form.addParameter('m' + '.WPAEncryptionModes' + coverIndex, wlan1.WPAEncryptionModes);
        } else if ((wlan1.BeaconType == '11i') || (wlan1.BeaconType == 'WPA2')) {
            form.addParameter('w' + idx + '.IEEE11iAuthenticationMode', wlan1.IEEE11iAuthenticationMode);
            form.addParameter('w' + idx + '.IEEE11iEncryptionModes', wlan1.IEEE11iEncryptionModes);
            form.addParameter('m' + '.IEEE11iAuthenticationMode' + coverIndex, wlan1.IEEE11iAuthenticationMode);
            form.addParameter('m' + '.IEEE11iEncryptionModes' + coverIndex, wlan1.IEEE11iEncryptionModes);
        } else {
            form.addParameter('w' + idx + '.X_HW_WPAand11iAuthenticationMode', wlan1.X_HW_WPAand11iAuthenticationMode);
            form.addParameter('w' + idx + '.X_HW_WPAand11iEncryptionModes', wlan1.X_HW_WPAand11iEncryptionModes);
            form.addParameter('m' + '.MixAuthenticationMode' + coverIndex, wlan1.X_HW_WPAand11iAuthenticationMode);
            form.addParameter('m' + '.MixEncryptionModes' + coverIndex, wlan1.X_HW_WPAand11iEncryptionModes);
        }
    } else {
    }

    form.addParameter('w' + idx + '.SSID', ssid);
    form.addParameter('w' + idx + '.SSIDAdvertisementEnabled', ssidVisible);
    form.addParameter('m' + '.SSID' + coverIndex, ssid);
    form.addParameter('m' + '.SSIDAdvertisementEnabled' + coverIndex, ssidVisible);

    url += "w" + idx + "=" + wlanDomain + "&";

    addParaForCover(wlan5, form);
    return true;
}

function AddParameterForBSD(form) {
    form.addParameter('z.BandSteeringPolicy', bsdPolicy);
    url += "z="+ XHWGlobalConfig.domain+"&";
}

function IsFirstSsidEqual() {
    var ssid2G = '';
    var ssid5G = '';
    for (var i = 0; i < allWlanInfo.length; i++) {
        if (getInstIdByDomain(allWlanInfo[i].domain) == 1) {
            ssid2G = allWlanInfo[i].ssid;
        }

        if (getInstIdByDomain(allWlanInfo[i].domain) == parseInt(ssidStart5G) + 1) {
            ssid5G = allWlanInfo[i].ssid;
            ssid5GIndex = i;
        }
    }

    if (ssid2G == ssid5G) {
        return true;
    }

    return false;
}

function IsSetSsid5G(wlandomain) {
    if ((fttrFlag == 1) && (DoubleFreqFlag != 1) && (getInstIdByDomain(wlandomain) == 1) &&
        ((encryTypeArr[0] == "psk") || (encryTypeArr[0] == "none")) && (hiLinkRoll == 1) &&
        (IsFirstSsidEqual() == true)) {
        isSet5Gflag = 1;
    } else {
        isSet5Gflag = 0;
    }
}

function IsSsid5GExist(ssid) {
    for (var i = 0; i < allWlanInfo.length; i++) {
        if (getWlanPortNumber(allWlanInfo[i].name) <= ssidEnd2G) {
            continue;
        }

        if (i != ssid5GIndex) {
            if (allWlanInfo[i].ssid == ssid) {
                AlertEx(cfg_wlancfgother_language['amp_ssid_exist']);
                return false;
            }
        }
    }

    return true;
}

function AddParameter5G(wlandomain, form) {
    var formLength = form.oForm.length;
    for (var i = 0; i < formLength; i++) {
        if (form.oForm[i].name == 'w0.SSID') {
            if (IsSsid5GExist(form.oForm[i].value) == false) {
                return false;
            }
        }

        var name = form.oForm[i].name.split('.');
        if ((name[0] == 'r1') || (name[0] == 'z0')) {
            continue;
        }

        var newName;
        if (name[0] == 'm') {
            newName = form.oForm[i].name + '5G';
            if (newName == 'm.SsidInst5G') {
                form.addParameter(newName, parseInt(ssidStart5G) + 1);
                continue;
            }

            if (newName == 'm.Standard5G') {
                continue;
            }
        } else {
            newName = name[0].toUpperCase() + '.' + name[1];
        }

        form.addParameter(newName, form.oForm[i].value);
    }

    if (((allWlanInfo[ssid5GIndex].BeaconType == 'Basic') && (allWlanInfo[ssid5GIndex].BasicEncryptionModes == 'None')) && (encryTypeArr[0] == "psk")) {
        if (wlan1.BeaconType == 'WPA') {
            form.addParameter('W0.BeaconType', wlan1.BeaconType);
            form.addParameter('W0.WPAAuthenticationMode', 'PSKAuthentication');
            form.addParameter('W0.WPAEncryptionModes', wlan1.WPAEncryptionModes);

            form.addParameter('m.BeaconType5G', wlan1.BeaconType);
            form.addParameter('m.WPAAuthenticationMode', 'PSKAuthentication');
            form.addParameter('m.WPAEncryptionModes', wlan1.WPAEncryptionModes);
        } else if ((wlan1.BeaconType == '11i') || (wlan1.BeaconType == 'WPA2')) {
            form.addParameter('W0.BeaconType', wlan1.BeaconType);
            form.addParameter('W0.IEEE11iAuthenticationMode', 'PSKAuthentication');
            form.addParameter('W0.IEEE11iEncryptionModes', wlan1.IEEE11iEncryptionModes);

            form.addParameter('m.BeaconType5G', wlan1.BeaconType);
            form.addParameter('m.IEEE11iAuthenticationMode5G', 'PSKAuthentication');
            form.addParameter('m.IEEE11iEncryptionModes5G', wlan1.IEEE11iEncryptionModes);
        } else if ((wlan1.BeaconType == 'WPAand11i') || (wlan1.BeaconType == 'WPA/WPA2') ||
                   (wlan1.BeaconType == 'WPA3') || (wlan1.BeaconType == 'WPA2/WPA3')) {
            form.addParameter('W0.BeaconType', wlan1.BeaconType);
            form.addParameter('W0.X_HW_WPAand11iAuthenticationMode', 'PSKAuthentication');
            form.addParameter('W0.X_HW_WPAand11iEncryptionModes', wlan1.X_HW_WPAand11iEncryptionModes);

            form.addParameter('m.BeaconType5G', wlan1.BeaconType);
            form.addParameter('m.MixAuthenticationMode5G', 'PSKAuthentication');
            form.addParameter('m.MixEncryptionModes5G', wlan1.X_HW_WPAand11iEncryptionModes);
        }
    }

    return true;
}

function SubmitForm()
{
    if ((CfgMode.toUpperCase() == 'CMHK') && (TypeWord == 'BRIDGE')) {
        return;
    }

    if (CfgMode.toUpperCase() == "EGVDF2") {
        if ((checkPasswordStrength("pwd_2g_wifipwd") < 2) || (checkPasswordStrength("pwd_5g_wifipwd") < 2)) {
            AlertEx(cfg_wlancfgdetail_language['amp_encrypt_keynote_eg']);
            return;
        }
    }

    var form = new webSubmitForm();
    url = '';
    url_new = 'set.cgi?';
    if ((fttrFlag == 1) && (DoubleFreqFlag != 1)) {
        IsSetSsid5G(wlan1.domain);
    }
	
	if((null != wlan1) && !addParaWlan(wlan1, form))
		return ;
		
	if(1 == DslTalkTalkFlag)
	{
		if(isValIdRule(getValue('txt_2g_wifiname')) == '') 
		{
			AlertEx(cfg_wlancfgother_language['amp_ttd_ssid_check']);
			return false;
		}
		
		if(wlan1.BeaconType == 'Basic')
		{
			if(wlan1.BasicEncryptionModes != 'WEPEncryption')
			{
				if(isValPWDRule(getValue('pwd_2g_wifipwd')) == '') 
				{
					AlertEx(cfg_wlancfgother_language['amp_ttd_pwd_check']);
					return false;
				}
			}
		}
		else
		{
			if(isValPWDRule(getValue('pwd_2g_wifipwd')) == '') 
				{
					AlertEx(cfg_wlancfgother_language['amp_ttd_pwd_check']);
					return false;
				}
		}
				
		if(isValIdRule(getValue('txt_5g_wifiname')) == '') 
		{
			AlertEx(cfg_wlancfgother_language['amp_ttd_ssid_check']);
			return false;
		}
		
		if(wlan5.BeaconType == 'Basic')
		{
			if(wlan5.BasicEncryptionModes != 'WEPEncryption')
			{
				if(isValPWDRule(getValue('pwd_5g_wifipwd')) == '') 
				{
					AlertEx(cfg_wlancfgother_language['amp_ttd_pwd_check']);
					return false;
				}
			}
		}
		else
		{
			if(isValPWDRule(getValue('pwd_5g_wifipwd')) == '') 
				{
					AlertEx(cfg_wlancfgother_language['amp_ttd_pwd_check']);
					return false;
				}
		}	
	}	

	if(wlan5_exist)
	{
		if (IsShowBSD()) {
            if (bsdPolicy != XHWGlobalConfig.BandSteeringPolicy) {
                AddParameterForBSD(form);
            }

            if (bsdPolicy == 0) {
                if(!addParaWlan(wlan5, form)) {
                    return ;
                }
            } else {
                if (!AddParaWlanForBSD(form)) {
                    return ;
                }
            }
        } else {
            if (tmczstFlag == 1) {
                if (!IsTmczstShow5G()) {
                    if(!addParaWlan(wlan5, form)) {
                        return ;
                    }
                }
            } else {
                if(!addParaWlan(wlan5, form)) {
                    return ;
                }
            }
        }
	}

    if (isSet5Gflag == 1) {
        if (AddParameter5G(wlan1.domain, form) == false) {
            return;
        }
    }
    if (["ANTEL", "ANTEL2"].indexOf(CfgMode.toUpperCase()) == -1) {
        addRadioEnablePara(form);
    }
	url_new += 'm=InternetGatewayDevice.X_HW_DEBUG.AMP.WifiCoverSetWlanBasic&';
	url_new += url;
	form.setAction(url_new+'RequestFile=html/amp/wlanbasic/simplewificfg.asp');
	
	form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
	form.submit();
    if (fttrFlag == 1) {
        setDisable("btnSave", 1);
        setDisable("btnCancel", 1);
    }
}

function cancelClick()
{
	if (CfgMode.toUpperCase() == 'DINFOTEK2') {
		window.parent.wifiCancelClass();
		window.parent.toggleFlag = true;
		window.parent.toggleOnlineOffineImg();
		window.parent.movewifiup();
	}

    $('#WIFIIcon', window.parent.document).css("background", "url( ../../../images/wifiseticon.jpg) no-repeat center");
    window.parent.ChangeClickConfigDiv(1,"wifi",null);
}

function ClickBandSteeringPolicy() {
    setDisable('bandSteeringPolicyRadio', 1);
    bsdPolicy = 1 - bsdPolicy;
    setRadioEnable('bandSteeringPolicyRadio', bsdPolicy);
    SetPageShow();
    SetSsidForBSD();
    setDisable('bandSteeringPolicyRadio', 0);
}

function SetSsidForBSD() {
    var ssid2G;
    var ssid5G;
    if (bsdPolicy == 1) {
        ssid2G = getValue('txt_2g_wifiname');
        setText('txt_2g_wifiname', ssid2G);
    } else {
        ssid2G = getValue('txt_2g_wifiname');
        ssid5G = getValue('txt_2g_wifiname');
        ssid5G = (ssid5G.length > 27) ? ssid5G : ssid5G + '_5GHz';
        setText('txt_2g_wifiname', ssid2G);
        setText("txt_5g_wifiname", ssid5G);
    }
}

function SetPageShow() {
    if (bsdPolicy == 1) {
        getElById('tdWiFiName2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiname'];
        getElById('tdWiFiPwd2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifipwd'];
        setDisplay('trWiFiName5G', 0);
        setDisplay('trWiFiPwd5G', 0);
        setDisplay('div_separatrix1', 0);
    } else {
        getElById('tdWiFiName2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiname_2G'];
        getElById('tdWiFiPwd2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifipwd_2G'];
        setDisplay('trWiFiName5G', 1);
        setDisplay('trWiFiPwd5G', 1);
        setDisplay('div_separatrix1', 1);
    }

    AdjustHtmlHeight();
}

function SetBSDShow() {
    if (IsShowBSD()) {
        setDisplay('tr_bsd', 1);
        setDisplay('tr_RadioEnable2g', 0);
        setDisplay('tr_RadioEnable5g', 0);
        setDisplay('hide_2g', 0);
        setDisplay('hide_5g', 0);
        getElById('tdWiFiName2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiname_2G'];
        getElById('tdWiFiPwd2G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifipwd_2G'];
        getElById('tdWiFiName5G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifiname_5G'];
        getElById('tdWiFiPwd5G').innerHTML = cfg_wifiguide_language['amp_wifiguide_wifipwd_5G'];
        $('#tdWiFiName2G').css('width', '140px');
        $('#tdWiFiPwd2G').css('width', '140px');
        $('#tdWiFiName5G').css('width', '140px');
        $('#tdWiFiPwd5G').css('width', '140px');

        bsdPolicy = XHWGlobalConfig.BandSteeringPolicy;
        setRadioEnable('bandSteeringPolicyRadio', bsdPolicy);
        SetPageShow();
    } else {
        setDisplay('tr_bsd', 0);
    }

    if ((turkcellFlag == 1) && (curUserType != 0)) {
        setDisplay('tr_bsd', 0);
    }
}

function egvdfPwdStrengthcheck(id, pwdid)
{
    var score = 0;
    var password = getElementById(id).value;

    if (password.match(/[a-z]/)) {
        score++;
    }

    if (password.match(/[A-Z]/)) {
        score++;
    }

    if (password.match(/\d/)) {
        score++;
    }

    if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) {
        score++;
    }

    if (password.length < 8) {
        score = 1;
    }

    if (score < 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_low'];
        getElementById(pwdid).style.width=23+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FF0000";
    } else if (score == 2) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_medium'];
        getElementById(pwdid).style.width=60+"%";
        getElementById(pwdid).style.borderBottom="10px solid #FFA500";
    } else if (score >= 3) {
        getElementById(pwdid).innerHTML=cfg_wlancfgdetail_language['amp_pwd_strength_high'];
        getElementById(pwdid).style.width=100+"%";
        getElementById(pwdid).style.borderBottom="10px solid #008000";
    }
}

function PwdStrength2G(id)
{
    var checkid= "pwdvalue1";
    egvdfPwdStrengthcheck(id,checkid);
}

function PwdStrength5G(id)
{
    var checkid= "pwdvalue2";
    egvdfPwdStrengthcheck(id,checkid);
}

</script>

<style type="text/css">
    .tb_label
    {
        font-size: 14px;
        color: #666666;
		width:100px;
    }
	.sp_checkbox
    {
        font-size: 13px;
        color: #666666;
    }
	.tb_input
	{
		-webkit-border-radius: 4px;
		-moz-border-radius: 4px;
		border-radius: 4px;
		border: 1px solid #CECACA;
		vertical-align: middle;
		font-size: 14px;
		height: 32px;
		width: 228px;
		padding-left: 5px;
		line-height: 32px;
		background-color: #ffffff;
	}
	
	.tb_input11
	{
		height: 32px;
		width: 228px;
		padding-left: 5px;
		line-height: 30px;
		font-size: 14px;
		background: none;
		border: none;
		background: url(../../../images/userinput.jpg) no-repeat;
	}
	
	.tb_radio
	{
		height: 30px;
		width: 70px;
		background: url(../../../images/on.jpg) no-repeat;
	}
	.gray
	{
		font-size: 13px;
		color: #666666;
	}
</style>

</head>

<body onLoad="LoadFrame();" class="simpwifi">
<div> 
<table border="0" cellspacing="0" cellpadding="0" class="simpTable">
  <tr>  
    <script>
        if (CfgMode.toUpperCase().indexOf('DTEDATA') >= 0){
	        document.write('<td style="padding-bottom: 10px;font-size:16px;font-style:normal;text-decoration:none;color:#6f2d91;font-weight:bold;" BindText="amp_wifipage_wificfg" />');
        } else {
            document.write('<td style="padding-bottom: 10px;font-size:16px;font-style:normal;text-decoration:none;color:#333333;" BindText="amp_wifipage_wificfg" />');
        }			
	</script>
  </tr> 
</table>

<table id="tb_2g" border="0" cellpadding="3" cellspacing="1" style="margin-left: 20px;">
	<tr id="tr_bsd" style='display:none;'> 
		<td class="tb_label"><script>document.write(cfg_wlancfgadvance_language['amp_BandSteering']);</script></td>
		<td><div id="bandSteeringPolicyRadio" class="tb_radio" onClick="ClickBandSteeringPolicy();"></div></td>
	</tr>
	<tr id='tr_RadioEnable2g'>
		<td class="tb_label" id="txt_2g_wifititle" BindText="amp_wifipage_wifi2on"></td>
		<td><div id="enable2g" class="tb_radio" onClick="EnableWiFi(this.id);"></div></td>
	</tr>
	<tr>
		<td id='tdWiFiName2G' class="tb_label" BindText="amp_wifiguide_wifiname"></td>
		<td> <input type="text" name="txt_2g_wifiname" id="txt_2g_wifiname" class="tb_input" maxlength="32"></td>
		<td><span class="sp_checkbox">
			<script language="JavaScript" type="text/javascript">
				document.write(ssidTips);
			</script>
		</span></td>
	</tr>
	<tr>
		<td id='tdWiFiPwd2G' class="tb_label" BindText="amp_wifipage_pwd"></td>
		<td> 
			<input type="password" autocomplete="off" name="pwd_2g_wifipwd" id="pwd_2g_wifipwd" class="tb_input" onchange="pwd=getValue('pwd_2g_wifipwd');getElById('txt_2g_wifipwd').value = pwd;">
			<input type="text" autocomplete="off" name="txt_2g_wifipwd" id="txt_2g_wifipwd" class="tb_input" style="display:none;" onchange="pwd=getValue('txt_2g_wifipwd');getElById('pwd_2g_wifipwd').value = pwd;">
		</td>
		<td> 
			<input  id="cb_2g_pwd" type="checkbox" checked="true" onClick="showPwd(this.id);"/>
			<span id="hideId2" class="sp_checkbox" BindText="amp_wifipage_hidepwd"></span>
			<span id="pwd_2g_notice" class="gray" style="font-size: 13px;"></span>
		</td>
	</tr>
    <tr id="checkinfo1Row" style="display:none">
        <td id="checkinfotitel" class="tb_label" >
            <script>
                if (CfgMode.toUpperCase() == "EGVDF2") {
                    document.write(cfg_wlancfgdetail_language['amp_wpa_psk_strength']);
                }
            </script>
        </td>
        <td id="checkinfo1" class="divtdlabal"> 
            <script>
                if (CfgMode.toUpperCase() == "EGVDF2") {
                    $('#pwd_2g_wifipwd').on('keyup',function(){
                        $("#checkinfo1Row").css("display", "");
                        $("#psd_checkpwd1").css("display", "block");
                        PwdStrength2G("pwd_2g_wifipwd");
                        AdjustHtmlHeightPwdStrength();
                    });
                    
                    $('#txt_2g_wifipwd').on('keyup',function(){
                        $("#checkinfo1Row").css("display", "");
                        $("#psd_checkpwd1").css("display", "block");
                        PwdStrength2G("txt_2g_wifipwd");
                        AdjustHtmlHeightPwdStrength();
                    });
                }
                </script>
        </td>
        <td></td>
    </tr>
	<tr id='hide_2g'>
	<td></td>
	<td><input id="cb_2g_hide" type="checkbox" onClick="hide2GSsidClick(this.id);"/><span class="sp_checkbox" BindText="amp_wifipage_hidessid"></span></td>
	</tr>
</table>
<div id="div_separatrix1" style="display:none; height: 10px; margin: 15px 10px 15px 10px; background:url(../../../images/wifi-separatrix1.jpg) no-repeat;"></div>
<table id="tb_5g" border="0" cellpadding="3" cellspacing="1" style="display:none;margin-left: 20px;" >
	<tr id='tr_RadioEnable5g'>
		<td class="tb_label" BindText="amp_wifipage_wifi5on"></td>
		<td><div id="enable5g" class="tb_radio" onClick="EnableWiFi(this.id);"></div></td>
	</tr>
	<tr id='trWiFiName5G'>
		<td id='tdWiFiName5G' class="tb_label" BindText="amp_wifiguide_wifiname"></td>
		<td> <input type="text" name="txt_5g_wifiname" id="txt_5g_wifiname" class="tb_input" maxlength="32"></td>
		<td><span class="sp_checkbox">
			<script language="JavaScript" type="text/javascript">
				document.write(ssidTips);
			</script>
		</span></td>
	</tr>
	<tr id='trWiFiPwd5G'>
		<td id='tdWiFiPwd5G' class="tb_label" BindText="amp_wifipage_pwd"></td>
		<td> 
			<input type="password" autocomplete="off" name="pwd_5g_wifipwd" id="pwd_5g_wifipwd" class="tb_input" onchange="pwd=getValue('pwd_5g_wifipwd');getElById('txt_5g_wifipwd').value = pwd;">
			<input type="text" autocomplete="off" name="txt_5g_wifipwd" id="txt_5g_wifipwd" class="tb_input" style="display:none;" onchange="pwd=getValue('txt_5g_wifipwd');getElById('pwd_5g_wifipwd').value = pwd;">
		</td>
		<td> 
			<input  id="cb_5g_pwd" type="checkbox" checked="true" onClick="showPwd(this.id);"/>
			<span id="hideId5" class="sp_checkbox" checked="true" BindText="amp_wifipage_hidepwd"></span>
			<span id="pwd_5g_notice" class="gray" style="font-size: 13px; text-align: left;"></span>
		</td>
	</tr>
    <tr id="checkinfo2Row" style="display:none">
        <td id="checkinfotite2" class="tb_label" >
            <script>
                if (CfgMode.toUpperCase() == "EGVDF2") {
                    document.write(cfg_wlancfgdetail_language['amp_wpa_psk_strength']);
                }
            </script>
        </td>
        <td id="checkinfo2">
            <script>
                if (CfgMode.toUpperCase() == "EGVDF2") {
                    $('#pwd_5g_wifipwd').on('keyup',function(){
                        $("#checkinfo2Row").css("display", "");
                        $("#psd_checkpwd2").css("display", "block");
                        PwdStrength5G("pwd_5g_wifipwd");
                        AdjustHtmlHeightPwdStrength();
                    });

                    $('#txt_5g_wifipwd').on('keyup',function(){
                        $("#checkinfo2Row").css("display", "");
                        $("#psd_checkpwd2").css("display", "block");
                        PwdStrength5G("txt_5g_wifipwd");
                        AdjustHtmlHeightPwdStrength();
                    });
                }
                </script>
        </td>
        <td></td>
    </tr>
	<tr id='hide_5g'>
	<td></td>
	<td><input id="cb_5g_hide" type="checkbox" onClick="hide5GSsidClick(this.id);"/><span class="sp_checkbox" BindText="amp_wifipage_hidessid"></span></td>
	</tr>
</table>
<div id="div_separatrix2" style="height: 10px; margin: 15px 10px 15px 10px; background:url(../../../images/wifi-separatrix2.jpg) no-repeat;"></div>
<div align="center">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">

<input id="btnSave" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();">
<script>getElById('btnSave').value = cfg_wifiguide_language['amp_wifipage_save'];</script>
</input>
<input id="btnCancel" type="button" class="CancleButtonCss buttonwidth_100px" onClick="cancelClick();">
<script>getElById('btnCancel').value = cfg_wifiguide_language['amp_wifipage_cancel'];</script>
</input>
		
</div>

</div>
<script>
ParseBindTextByTagName(cfg_wifiguide_language,"span",1);
ParseBindTextByTagName(cfg_wifiguide_language,"td",1);
ParseBindTextByTagName(cfg_wifiguide_language,"input",2);
</script>
</body>
</html>
