<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1"><!-IE7 mode->
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' rel="stylesheet" type='text/css' />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">

function GetLanguageDesc(Name)
{
    return AccountLgeDes[Name];
}

function stModifyUserInfo(domain,UserName,UserLevel,Enable)
{
	this.domain = domain;
	this.UserName = UserName;
	this.UserLevel = UserLevel;
	this.Enable = Enable;
}

function stNormalUserInfo(UserName, ModifyPasswordFlag, InstantNo)
{
    this.UserName = UserName;
    this.ModifyPasswordFlag = ModifyPasswordFlag;
    this.InstantNo = InstantNo;
}

var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName|UserLevel|Enable, stModifyUserInfo);%>;
stModifyUserInfos.splice(stModifyUserInfos.length - 1, 1);
var UserInfo = <%HW_WEB_GetNormalUserInfo(stNormalUserInfo);%>;
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
var keyBoardConsecutiveNumber = '';
var consecutiveNumber = '';
var repeatedNumber = '';
var sptUserName = UserInfo[0].UserName;
var sptInstantNo = UserInfo[0].InstantNo;

var PwdModifyFlag = 0;
var normalUserType = '1';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var CurUserName = '<%HW_WEB_GetCurUserName();%>';
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var CurrentUpMode = '<%HW_WEB_GetUpMode();%>';
var isBponFlag = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';

var isDnzvdf = '<%HW_WEB_GetFeatureSupport(FT_MNGT_DNZVDF);%>';
var IsSurportInternetCfg  = "<%HW_WEB_GetFeatureSupport(BBSP_FT_GUIDE_PPPOE_WAN_CFG);%>";
var IsSurportWlanCfg  = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var clisynFlag = '<%HW_WEB_GetFeatureSupport(HW_FT_CLI_WEB_PASSWORD_SYN);%>';
var cliadminsynFlag = '<%HW_WEB_GetFeatureSupport(HW_FT_CLI_WEB_PASSWORD_AUTH_IG);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var TedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
var dbaa1SuperSysUserType = '2';
var DBAA1= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var fttrFlag = '<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>';
var checkWeakPwdFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_CHECK_WEAKPWD);%>';
var isSupportOnulanCfg = "<%HW_WEB_GetFeatureSupport(FT_WEB_ONU_LAN_CFG);%>";
var secCodeLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>'
var ttnet = '<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>';
var isDbaa1SuperSys = false;
if ((DBAA1 == "1") && (curUserType == dbaa1SuperSysUserType)) {
    isDbaa1SuperSys = true;
}
var isDbaa1Sys = false;
if ((DBAA1 == "1") && (curUserType == sysUserType)) {
    isDbaa1Sys = true;
}
var isDbaa1Normal = false;
if ((DBAA1 == "1") && (curUserType == normalUserType)) {
    isDbaa1Normal = true;
}
var selectedUser = null;
var isForceModifyPwd = window.parent.isForceModifyPwd;

if (isDbaa1Sys) {
    for (var i = stModifyUserInfos.length - 1;i >= 0;i--) {
        var curUser = stModifyUserInfos[i];
        if (curUser.UserLevel != normalUserType) {
            stModifyUserInfos.splice(i, 1);
        }
    }
}

function SupportTtnet()
{
    return (CfgMode.toUpperCase() == "DTTNET2WIFI" || CfgMode.toUpperCase() == "TTNET2");
}

function ClickExit()
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=0', true),
        success : function(data) {
        }
    });
    window.top.location.href="/index.asp";
}

function getMinCharTypeCount()
{
    if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") ||
        (CfgMode.toUpperCase() == "TURKCELL2") ||
        (CfgMode.toUpperCase() == "HT") ||
        (CfgMode.toUpperCase() == "TEDATA2") ||
        (CfgMode.toUpperCase() == "OTE")) {
        return 3;
    }
    return 2;
}

function CheckPwdIsComplexForEgvdf(str)
{
    var score = 0;
    if (str.length < 8) {
        return false;
    }

    if (isLowercaseInString(str)) {
        score++;
    }

    if (isUppercaseInString(str)) {
        score++;
    }

    if (isDigitInString(str)) {
        score++;
    }

    if (isSpecialCharacterNoSpace(str)) {
        score++;
    }

    if (score >= 4) {
        return true;
    }

    return false;
}

function CheckPwdIsComplex(str)
{
	var i = 0;
	if (str.length < secCodeLen) {
		return false;
	}

	if ( ((CfgMode.toUpperCase() == "DTURKCELL2WIFI" || CfgMode.toUpperCase() == "TURKCELL2") && (curUserType == sysUserType))
		 || (CfgMode.toUpperCase() == "TEDATA2"))
	{
		if ( 8 > str.length )
		{
			return false;
		}
	}
	
	if (!CompareString(str,sptUserName))
	{
		return false;
	}

    if (CfgMode.toUpperCase() == "EGVDF2") {
        return CheckPwdIsComplexForEgvdf(str);
    }

	if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2") || (CfgMode.toUpperCase() == "TEDATA2"))
	{
		if (isLowercaseInString(str) || isUppercaseInString(str))
		{
		    i++;
		}
	}
	else
	{
		if ( isLowercaseInString(str) )
		{
			i++;
		}

		if ( isUppercaseInString(str) )
		{
			i++;
		}
	}
	
	if ( isDigitInString(str) )
	{
		i++;
	}

	if ( isSpecialCharacterInString(str) )
	{
		i++;
	}

    return i >= getMinCharTypeCount();
}

function LoadFrame()
{
    if (SupportTtnet()) {
        $(".guidepwdnoticearea").css("display", "none");
        $("#Modifyuserinfo").css("margin-left", "150px");
        $(".contenModifySubmitbox").css("margin-left", "150px");
    }

    if ((isDbaa1SuperSys == false) && (isDbaa1Sys == false)) {
        document.getElementById('txt_Username').appendChild(document.createTextNode(sptUserName));
    }
	PwdModifyFlag = UserInfo[0].ModifyPasswordFlag;

	if((parseInt(PwdModifyFlag,10) == 0) && (curLanguage.toUpperCase() != "CHINESE"))
	{
        if ((logo_singtel!= true) && (CfgMode.toUpperCase() !== "DICELANDVDF"))
        {
            document.getElementById('defaultpwdnotice').innerHTML=GetLanguageDesc("s1118");
        }
    }
    if ((parseInt(PwdModifyFlag, 10) == 0) && (CfgMode.toUpperCase() == "TTNET2")) {
        document.getElementById('defaultpwdnotice').innerHTML=GetLanguageDesc("s1118a");
    }
	if ((ProductType == '2') || (TedataGuide == 1))
	{
		window.parent.adjustParentHeight();
	}
	else
	{
		if("" != curChangeMode && 0 != curChangeMode || GhnDevFlag == 1 || 1 == PwdTipsFlag)
		{
			var pwdcheck1 = document.getElementById('pwdvalue1');
	        pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>'
			psdStrength();
		}
		<!--密码强度1-->
		if("" != curChangeMode && 0 != curChangeMode || GhnDevFlag == 1 || 1 == PwdTipsFlag)
		{
			$("#guidecmodecfg").css("display", "block");
			$("#pwdstrongdiv").css("display", "none");
			$("#psd_checkpwd").css("display", "none");
			$("#guidewificfg").css("display", "none");
		}
		else
		{
			$("#guidecmodecfg").css("display", "none");
			$("#pwdstrongdiv").css("display", "none");
			$("#guidewificfg").css("display", "inline-block");
		}
	}

    if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") ||
        (CfgMode.toUpperCase() == "TURKCELL2")) {
        if (curUserType == sysUserType) {
            document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
        } else {
            document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("s2011");
        }
        document.getElementById('PwdComplexAlarm').innerHTML = GetLanguageDesc("ss2012a");
    }
    if (CfgMode.toUpperCase() == "TTNET2") {
        document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
        document.getElementById('PwdComplexAlarm').innerHTML = GetLanguageDesc("ss2012a");
    }

    if ((CfgMode.toUpperCase() == "OTE") || (CfgMode.toUpperCase() == "HT")) {
        document.getElementById('PwdComplexAlarm').innerHTML = GetLanguageDesc("ss2012a");
    }

    if (secCodeLen == 8) {
        document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
    }

    if ((fttrFlag == 1) && (window.parent.wifiPara != null)) {
		window.parent.setDisplay("framepageContent", 1);	
	}

    if (CfgMode.toUpperCase() == "EGVDF2") {
        var pwdcheck1 = document.getElementById('pwdvalue1');
        pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 233px;"><span class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>';
        psdStrength();
        document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
        document.getElementById('PwdComplexAlarm').innerHTML = GetLanguageDesc("ss2012b");
    }
    if (CfgMode.toUpperCase() == "GNVDF") {
        document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
    }
    if (CfgMode.toUpperCase() == "TEDATA2") {
        document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
        document.getElementById('PwdComplexAlarm').innerHTML = GetLanguageDesc("ss2012");
    }

    if ((isDnzvdf == 1) || ((ProductType == '2') && isForceModifyPwd)) {
        setDisplay("guideskip", 0);
    }
}

function isValidAscii(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch <= ' ' || ch > '~' )
        {
            return false;
        }
    }
    return true;
}

function CheckPwdInWeakPwdList(pwd)
{
    if (checkWeakPwdFlag != "1") {
        return false;
    }

    var NormalPwdInfo = FormatUrlEncode(pwd);
    var CheckResult = 0;
    $.ajax({
        type: "POST",
        async: false,
        cache: false,
        url: "../common/CheckPwdInWeakPwdList.asp?&1=1",
        data: 'NormalPwdInfo=' + NormalPwdInfo,
        success: function (data) {
            CheckResult = data;
        }
    });
    return CheckResult == 1;
}

function CheckParameter()
{
    var needCheckOldPwdMatch = true;
    var needCheckOldPwdEmpty = true;

    if (isDbaa1SuperSys && (selectedUser.UserName != CurUserName)) {
        needCheckOldPwdMatch = false;
        needCheckOldPwdEmpty = false;
    }

    if (isDbaa1Sys && (selectedUser.UserName != CurUserName)) {
        needCheckOldPwdMatch = false;
        needCheckOldPwdEmpty = false;
    }

    if (isDbaa1Normal) {
        needCheckOldPwdEmpty = false;
    }

	var oldPassword = document.getElementById("txt_oldPassword");
	var newPassword = document.getElementById("txt_newPassword");
    var cfmPassword = document.getElementById("txt_newcfmPassword");

    if (isDbaa1SuperSys && selectedUser.UserName != CurUserName) {
        var newUserName = document.getElementById('txt_NewUsername').value;
        if (newUserName == "") {
            AlertEx(GetLanguageDesc("s0f10"));
            return false;
        }
        for (var i = 0; i < stModifyUserInfos.length; i++) {
            if ((stModifyUserInfos[i].UserName != selectedUser.UserName) &&
                (newUserName == stModifyUserInfos[i].UserName)) {
                AlertEx(GetLanguageDesc("s0f10a"));
                return false;
            }
        }
    }

    if (needCheckOldPwdEmpty && (oldPassword.value == "")) {
        AlertEx(GetLanguageDesc("s0f0f"));
        return false;
    }

	if (newPassword.value == "")
	{
		AlertEx(GetLanguageDesc("s0f02"));
		return false;
	}

	if (newPassword.value.length > 127)
	{
		AlertEx(GetLanguageDesc("s1904"));
		return false;
	}

    if ((CfgMode.toUpperCase() == "DTTNET2WIFI") || (CfgMode.toUpperCase() == "TTNET2")) {
        if (!TtnetComplex(oldPassword.value, newPassword.value)) {
            return false;
        }
    }

	if (!isValidAscii(newPassword.value))
	{
		AlertEx(GetLanguageDesc("s0f04"));
		return false;
	}

	if (cfmPassword.value != newPassword.value)
	{
		AlertEx(GetLanguageDesc("s0f06"));
		return false;
	}

    if (CheckPwdInWeakPwdList(newPassword.value)) {
        AlertEx(GetLanguageDesc("s0f06a"));
        return false;
    }

	var NormalPwdInfo = FormatUrlEncode(oldPassword.value);
    var CheckResult = 0;
    var checkPwdUrl = "/html/ssmp/common/CheckNormalPwd.asp?&1=1";
    if (DBAA1 == "1") {
        checkPwdUrl = "/html/ssmp/common/CheckOldPwd.asp?&1=1";
    }

    if (needCheckOldPwdMatch) {
        $.ajax({
            type: "POST",
            async: false,
            cache: false,
            url: checkPwdUrl,
            data: 'NormalPwdInfo=' + NormalPwdInfo + '&NewWebUserPwd=' + FormatUrlEncode(newPassword.value),
            success: function (data) {
                CheckResult = data;
            }
        });
    } else {
        CheckResult = 1;
    }

	if (CheckResult == 2) {
		AlertEx(GetLanguageDesc("s0f16"));
		return false;
	} else if (CheckResult != 1) {
		AlertEx(GetLanguageDesc("s0f11"));
		return false;
	}

    if (CfgMode.toUpperCase() == "TTNET2") {
        if (!TtnetComplex(oldPassword.value, newPassword.value)) {
            return false;
        }
    }

    if (!CheckPwdIsComplex(newPassword.value)) {
        if (CfgMode.toUpperCase() == "EGVDF2") {
            AlertEx(GetLanguageDesc("s1116m"));
            return;
        }

        AlertEx(GetLanguageDesc("s1902"));
        return false;
    }

	return true;
}

function FormatUrlEncode(val)
{
	if(null != val)
	{
		var formatstr = escape(val);
		formatstr=formatstr.replace(new RegExp(/(\+)/g),"%2B");
		formatstr = formatstr.replace(new RegExp(/(\/)/g), "%2F");
		return formatstr
	}
	return null;
}

function getInstIDbyUserName(username)
{
    var instId = 0;
    for (var i = 0; i < stModifyUserInfos.length; i++) {
        if (stModifyUserInfos[i].UserName == username) {
            var temp = stModifyUserInfos[i].domain.split(".");
            instId = temp[temp.length - 1];
            break;
        }
    }
    return instId;
}

function SubmitPwd(val)
{
    var newPassword = document.getElementById("txt_newPassword");

    if(!CheckParameter())
    {
        return false;
    }
    else
    {
        if ((1 == clisynFlag) && (1 == cliadminsynFlag))
        {
            if (newPassword.value.length <= 64)
            {
                AlertEx(GetLanguageDesc("s0f0ea"));
            }
            else if (ConfirmEx(AccountLgeDes['s0f0eb']) == false)
            {
                setDisable('MdyPwdApply', 0);
                setDisable('MdyPwdcancel', 0);
                return false;
            }
        }
    }

    var newPassword = getValue('txt_newPassword');
    var OldPassword = getValue('txt_oldPassword');
    var guideConfigParaList = new Array(new stSpecParaArray("x.Password",  newPassword, 0));
    var Parameter = {};
    Parameter.OldValueList = null;
    Parameter.FormLiList = null;
    Parameter.UnUseForm = true;
    Parameter.asynflag = false;
    Parameter.SpecParaPair = guideConfigParaList;

    if (ttnet == 1) {
        sptInstantNo = getInstIDbyUserName(CurUserName);
    }

    var ConfigUrl = "setajax.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo."+sptInstantNo+ '&RequestFile=html/ssmp/accoutcfg/guideaccountcfg.asp';
    var tokenvalue = getValue('onttoken');

    if (isDbaa1SuperSys) {
        ConfigUrl = "setajax.cgi?x=" + selectedUser.domain + "&RequestFile=html/ssmp/accoutcfg/guideaccountcfg.asp";
        if (selectedUser.UserName == CurUserName) {
            guideConfigParaList.push(new stSpecParaArray("x.OldPassword", OldPassword, 0));
        } else {
            var newUserName = document.getElementById('txt_NewUsername').value;
            if (newUserName != selectedUser.UserName) {
                guideConfigParaList.push(new stSpecParaArray("x.UserName",  newUserName, 0));
            }
        }
    } else if (isDbaa1Sys) {
        ConfigUrl = "setajax.cgi?x=" + selectedUser.domain + "&RequestFile=html/ssmp/accoutcfg/guideaccountcfg.asp";
    } else {
        guideConfigParaList.push(new stSpecParaArray("x.OldPassword", OldPassword, 0));
    }

    if (CfgMode.toUpperCase() != "TURKCELL2") {
        guideConfigParaList.push(new stSpecParaArray("x.GuideModifyPwdFlag", 1, 0));
    }

    var AjaxBody = HWAddParameterByFormId(null, Parameter.FormLiList, Parameter.SpecParaPair, Parameter.OldValueList, true);
    if(AjaxBody == null) {
        return;
    }

    var setFlag = 0;
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url: ConfigUrl,
        data :AjaxBody + "&x.X_HW_Token=" + tokenvalue,
        success : function(data) {
             var ResultInfo = JSON.parse(hexDecode(data));
            if (ResultInfo.result != 0) {
               setFlag = 1;
               var errorcode = ResultInfo.error;
               if (errorcode == 0xf7200119) {
                   AlertEx(GetLanguageDesc("s0f17"));
               } else {
                   AlertEx(GetLanguageDesc("s2200"));
               }
            } else {
                window.parent.modifyWebCode = '1';
            }
        }
    });

    if (setFlag == 1) {
        return;
    }

    if ((ProductType == '2') || (TedataGuide == 1))
    {
        if (true == logo_singtel)
        {
            val.name = "/html/ssmp/cfgguide/userguidecfgdone_singtel.asp";
        }

        if (isForceModifyPwd) {
            val.name = "../../html/amp/wlanbasic/guidewificfg.asp";
        }
    }
    else
    {
        if (true == logo_singtel && TypeWord_com != "COMMON")
        {
            val.name = "/html/ssmp/cfgguide/userguidecfgdone_singtel.asp";
        }
    }
    window.parent.onchangestep(val);
}

function onskip(val)
{
    val.id = "guidecfgdone";
    if ((ProductType == '2') || (TedataGuide == 1))
    {
        if (true == logo_singtel)
        {
            val.name = "/html/ssmp/cfgguide/userguidecfgdone_singtel.asp";
        }    
    }
    else
    {
        if (true == logo_singtel && TypeWord_com != "COMMON")
        {
            val.name = "/html/ssmp/cfgguide/userguidecfgdone_singtel.asp";
        }
    }
    window.parent.onchangestep(val);
}

function onprevious(val)
{    
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/smartguide.cgi?1=1&RequestFile=index.asp',
        data: getDataWithToken('Parainfo=0', true),
        success : function(data) {
        }
        });

    if((0 == IsSurportInternetCfg) && (0 == IsSurportWlanCfg))
    {
        if ((ProductType == '2') || (TedataGuide == 1))
        {
            if (true == logo_singtel)
            {
                window.parent.location="../../../mainpage.asp";
            }
            else
            {
                window.parent.location="../../../index.asp";
            }        
        }
        else
        {
            if (true == logo_singtel && TypeWord_com != "COMMON")
            {
                window.parent.location="../../../mainpage.asp";
            }
            else
            {
                window.parent.location="../../../index.asp";
            }
        }
        return;
    }
    else if((1 == IsSurportInternetCfg) && (0 == IsSurportWlanCfg))
    {    

            val.id = "guideinternet";
            val.name = "/html/bbsp/guideinternet/guideinternet.asp";
    }


    window.parent.onchangestep(val);
}

function EndGuide(val)
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

function goToIndexPage()
{
    window.parent.location="../../../index.asp";
}
function ClickPreCMmode(val)
{
    if(1 == apcmodefeature)
    {
        val.name = 'VDFPTAP' == CfgMode ?
			"/html/amp/wlaninfo/wlanneighborAP.asp?cfgguide=1"
			:'/html/ssmp/modechange/modechange.asp';
        window.parent.onchangestep(val);
    }else{
        EndGuide();
        setTimeout("goToIndexPage();", 500);
    }

}

function CheckPwdNotice()
{
    var password1 = getElementById("txt_newPassword").value;
    var password2 = getElementById("txt_oldPassword").value;

    if(password1.length == 0){
        return;
    }

    if ((CfgMode.toUpperCase() == "DTTNET2WIFI") || (CfgMode.toUpperCase() == "TTNET2")) {
        if (!TtnetComplex(password2, password1)) {
            return;
        }
    } else if (!CheckPwdIsComplex(password1)) {
        if (CfgMode.toUpperCase() == "EGVDF2") {
            AlertEx(GetLanguageDesc("s1116m"));
            return;
        }

        AlertEx(GetLanguageDesc("s1902"));
        return;
    }

    return;
}

function egvdfPwdStrengthcheck()
{
    var score = 0;
    var password = getElementById("txt_newPassword").value;

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
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1448');
        getElementById("pwdvalue1").style.width=40+"%";
        getElementById("pwdvalue1").style.borderBottom="10px solid #FF0000";
    } else if (score == 2) {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1449');
        getElementById("pwdvalue1").style.width=60+"%";
        getElementById("pwdvalue1").style.borderBottom="10px solid #FFA500";
    } else if (score >= 3) {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1450');
        getElementById("pwdvalue1").style.width=100+"%";
        getElementById("pwdvalue1").style.borderBottom="10px solid #008000";
    }
}

function psdStrength()
{
	var lengthmatch=0;
	var lowerCharmatch=0;
	var upCharmatch=0;
	var NumCharmatch=0;
	var specialCharmatch=0;
    var score = 0;
	var totalscore = 0;
    var password1 = getElementById("txt_newPassword").value;
	var DestPwdLen = secCodeLen;
	
	if ( ((CfgMode.toUpperCase() == "DTURKCELL2WIFI" || CfgMode.toUpperCase() == "TURKCELL2") && (curUserType == sysUserType))
		|| (CfgMode.toUpperCase() == "TEDATA2"))
	{
		DestPwdLen = 8;
	}

    if(password1.length >= DestPwdLen) {
		lengthmatch = 1;
		score++;
	}

    if(password1.match(/[a-z]/)) {
		lowerCharmatch = 1;
		score++;
	}
	
	if(password1.match(/[A-Z]/)){
		upCharmatch = 1;
		score++;
	}
	
	if(password1.match(/[0-9]/)){
		NumCharmatch = 1;
		score++;
	}

    if(password1.match(/\d/)) score++;

    if ( password1.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) {
		specialCharmatch=1;
		score++;
	}
	
	totalscore = lengthmatch + lowerCharmatch + upCharmatch + NumCharmatch + specialCharmatch;
	
	if(0 == lengthmatch || totalscore <=2 ){
	    getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1448');
        getElementById("pwdvalue1").style.width=18+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FF0000";
        getElementById("pwdvalue1").style.float="left";
        getElementById("pwdvalue1").style.display="block";
		return;
	}
	
	
	if(1 == lengthmatch && totalscore == 3){
		getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1449');
        getElementById("pwdvalue1").style.width=49.8+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FFA500";
		return;
	}
	
	if(1 == lengthmatch && totalscore > 3 ){
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1450');
        getElementById("pwdvalue1").style.width=100+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #008000";
		return;
	}
}

<!-- 密码强度显示-->
</script>
</head>
<style type="text/css">
.Modifyuserinfo{
    width:500px;
    float:left;
}

.nofloat{
    float:none;
}

.Pwdfloatleft{
    float:left;
}

.pwdnoticetitle{
    margin-top:16px;
}

.clearfixarea{
clear:both;
display:block;
font-size:0;
height:0;
line-height:0;
overflow:hidden;
}

/*IE7 compatible begin*/
.contentModifypwdItem{
    *text-align:left;
}

.contenModifypwdbox{
    *width:240px;
    *text-align:left;
    *padding-left:10px;
}

.txt_Username{
    *padding-left:10px;
}

.textboxbg{
    *margin:auto 0px;
}
/*IE7 compatible end*/

#guideskip{
    text-decoration:none;
    color:#666666;
    white-space:nowrap;
    *display:block;            /*IE7 compatible*/
    *margin-top:-26px;        /*IE7 compatible*/
    *margin-left:250px;        /*IE7 compatible*/
    *text-decoration:none;    /*IE7 compatible*/
}

a span{
    font-size:16px;
    margin-left:10px;
}

#defaultpwdnotice{
    color:red;
    font-size:14px;
}
table{
    border:0px;
    cellspacing:0;
    cellpadding:0;
}
.acctablehead{
    font-size:16px;
    color:#666666;
    font-weight:bold;
    text-align:center;
}
</style>
</head>
<script type = text/javascript>
	if(curLanguage == 'arabic'){
		document.write('<body onLoad="LoadFrame();" style="background-color: #ffffff; direction: rtl;">')
	}
	else{
		document.write('<body onLoad="LoadFrame();" style="background-color: #ffffff; direction: ltr;">')
    }		

</script>
    <div align="center">
        <table width="550px" style="margin:0 auto;">
            <tr>
                <td height="40"></td>
            </tr>
            <tr align="left">
                <td class="acctablehead" BindText="s2000"></td>
            </tr>
        </table>

        <table width="100%" height="10px">
            <tr>
                <td height="10"></td>
            </tr>
            <tr align="center">
                <td id="defaultpwdnotice"></td>
            </tr>
        </table>
        <div id="userinfo">
        <div id="Modifyuserinfo" class="Modifyuserinfo">
            <div id="username" class="contentModifypwdItem">
                <div class="ModifypwdlabelBox"><span id="useraccount" BindText="s0f08"></span></div>
                <script>
                    if (CfgMode.toUpperCase() == "DNZVDF2WIFI") {
                        setDisplay("username", 0);
                        $("#Modifyuserinfo").css("paddingTop", "25px");
                    }
                    function onSelectedUserChanged() {
                        selectedUser = stModifyUserInfos[getValue('WebUserList')];
                        document.getElementById('txt_NewUsername').value = selectedUser.UserName;
                        if (selectedUser.UserName == CurUserName) {
                            $("#dbaa1NewUserNameRow").css("display", "none");
                            $("#olduserpwd").css("display", "block");
                        } else {
                            $("#dbaa1NewUserNameRow").css("display", "block");
                            $("#olduserpwd").css("display", "none");
                        }
                    }
                    if (isDbaa1SuperSys || isDbaa1Sys) {
                        document.write('<div class="contenModifypwdbox Pwdfloatleft">');
                        document.write('    <select id="WebUserList" '
                                                + ' class="Pwdfloatleft txt_Username" '
                                                + ' style="width: 233px; margin-left:4px;" '
                                                + ' name="WebUserList" '
                                                + ' onchange="onSelectedUserChanged()">');
                        for (var i = 0; i < stModifyUserInfos.length; i++) {
                            var curUser = stModifyUserInfos[i];
                            var optText = curUser.UserName;
                            var optValue = i;
                            var isSelectedUser = false;
                            if (isDbaa1SuperSys) {
                                isSelectedUser = curUser.UserName == CurUserName;
                            } else if (isDbaa1Sys) {
                                isSelectedUser = i == 0;
                            }
                            if (isSelectedUser) {
                                document.write('    <option selected value="' + optValue + '">' + optText + '</option>');
                                selectedUser = curUser;
                            } else {
                                document.write('    <option value="' + optValue + '">' + optText + '</option>');
                            }
                        }
                        document.write('    </select>');
                        document.write('</div>');
                    } else {
                        document.write('<div class="Pwdfloatleft txt_Username" id="txt_Username" name="txt_Username">');
                        document.write('</div>');
                    }
                </script>
            </div>
            <script>
                if (isDbaa1SuperSys) {
                    document.write('<div id="dbaa1NewUserNameRow" class="contentModifypwdItem" style="display:none;">');
                    document.write('    <div class="ModifypwdlabelBox">');
                    document.write('        <span id="dbaa1NewUserName" BindText="s0f08">');
                    document.write('        </span>');
                    document.write('    </div>');
                    document.write('    <div class="contenModifypwdbox Pwdfloatleft">');
                    document.write('        <input type="text"'
                                                + 'id="txt_NewUsername" '
                                                + 'name="txt_NewUsername" '
                                                + 'style="line-height:32px;" '
                                                + 'class="textModifypwdboxbg" />');
                    document.write('    </div>');
                    document.write('</div>');
                }
            </script>
            <div id="olduserpwd" class="contentModifypwdItem">
                <div class="ModifypwdlabelBox"><span id="olduserpassword" BindText="s0f13"></span></div>
                <script>
                    if ((ProductType != '2') && (TedataGuide != 1))
                    {
                        document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="password" id="txt_oldPassword" name="txt_oldPassword" class="textModifypwdboxbg" autocomplete="off"></div>');
    
                    }
                    else
                    {                
                document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="password" autocomplete="off" id="txt_oldPassword" name="txt_oldPassword" style="line-height:32px;" class="textModifypwdboxbg"></div>');
                    }
                    if (isDbaa1Sys) {
                        $("#olduserpwd").css("display", "none");
                    }
                </script>
            </div>

            <div id="newuserpwd" class="contentModifypwdItem">
                <div class="ModifypwdlabelBox"><span id="newuserpassword" BindText="s0f09"></span></div>
                <script>
                    if ((ProductType != '2') && (TedataGuide != 1))
                    {
                        document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="password" id="txt_newPassword" name="txt_newPassword" class="textModifypwdboxbg" autocomplete="off"></div>');

                    }
                    else
                    {
                        if (SupportTtnet()) {
                            document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="text" autocomplete="off" id="txt_newPassword" name="txt_newPassword" style="line-height:32px;" class="textModifypwdboxbg"></div>');
                        } else {
                            document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="password" autocomplete="off" id="txt_newPassword" name="txt_newPassword" style="line-height:32px;" class="textModifypwdboxbg"></div>');
                        }
                    }
                </script>                
            </div>
            <script>
                if (CfgMode.toUpperCase() == "EGVDF2") {
                    document.write('<div id="pwdstrongdiv" style="float:left;margin-top:12px; display:none;">');
                    document.write('<div class="" id="pwdstrong" style="float:left;font-family: 微软雅黑;color:#666666;width:250px;position:relative;text-align:right;" BindText="s1447"></div>');
                    document.write('<div class="" style="display: table-cell; float:left; width: 233px;">');
                    document.write('<span class="language-string" id="pwdvalue1" BindText="s1448"></span>');
                    document.write('</div>');
                    document.write('</div>');
                    $('#txt_newPassword').bind('keyup',function() {
                        $("#pwdstrongdiv").css("display", "block");
                        $("#psd_checkpwd").css("display", "block");
                        egvdfPwdStrengthcheck();
                    });
                }
            </script>
            <div id="newusercfmpwd" class="contentModifypwdItem">
                <div class="ModifypwdlabelBox"><span id="newusercfmpassword" BindText="s0f0b"></span></div>
                <script>
                    if ((ProductType == '2') || (TedataGuide == 1))
                    {
                        if (SupportTtnet()) {
                            document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="text" id="txt_newcfmPassword" name="txt_newcfmPassword" class="textModifypwdboxbg" autocomplete="off"></div>');
                        } else {
                            document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="password" id="txt_newcfmPassword" name="txt_newcfmPassword" class="textModifypwdboxbg" autocomplete="off"></div>');
                        }
                    }
                    else
                    {
                        document.write('<div class="contenModifypwdbox Pwdfloatleft"><input type="password" autocomplete="off" id="txt_newcfmPassword" name="txt_newcfmPassword" style="line-height:32px;" class="textModifypwdboxbg"></div>');
                    }
                </script>
            </div>
            <script>
                if ((ProductType != '2') && (TedataGuide != 1))
                {
                    document.write('<div id="pwdstrongdiv" style="float:left;margin-top:12px; display:none;">');
                    document.write('<div class="" id="pwdstrong" style="float:left;font-family: 微软雅黑;color:#666666;width:250px;position:relative;text-align:right;" BindText="s1447"></div>');
                    document.write('<div class="" style="float: left; width: 235px; margin-left: 10px;">');
                    document.write('<span class="language-string" id="pwdvalue1" style="width: 16.6%; border-bottom-width: 4px; border-bottom-style: solid; border-bottom-color: rgb(255, 0, 0);" BindText="s1448"></span>');
                    document.write('</div>');
                    document.write('</div>');
                }
            </script>
            <script>
                if ((ProductType != '2') && (TedataGuide != 1))
                {
                    $('#txt_newPassword').bind('keyup',function()
                        {
                                if("" != curChangeMode && 0 != curChangeMode || GhnDevFlag == 1 || 1 == PwdTipsFlag){
                                $("#pwdstrongdiv").css("display", "block");
                                $("#psd_checkpwd").css("display", "block");
                                psdStrength();
                            }
                        }
                    );
                }
				
				$('#txt_newPassword').blur(function()
				{
					CheckPwdNotice();
				});
            </script>
        </div>
            
            <div class="guidepwdnoticearea Pwdfloatleft">
            <div id="pwdnoticetitle" class="pwdnoticetitle"><span id="PwdNoticeTitle" BindText="s2010"></span></div>
            <div id="pwdnoticearea">
            <ol class="outside" id="PwdNotice">
            <li><span id="PwdLengthAlarm" BindText="s2011"></span></li>
            <li><span id="PwdComplexAlarm" BindText="s2012"></span></li>
            <li><span BindText="s2013"></span></li>
            </ol>
            </div>
            </div>
            
         <div id="clearfixarea" class="clearfixarea"></div>

        </div>
        
        <div id="ConfigAreaInfo">
        <div class="contentModifypwdItem nofloat">
        <div class="ModifypwdlabelBox"></div>
        <div class="contenModifySubmitbox">
        <script>
        if (CfgMode.toUpperCase() == "TURKCELL2") {
            document.write('<input type="button" id="guidewificfg" name="" class="CancleButtonCss buttonwidth_100px" onClick="ClickExit(this);" />');
        } else if ((ProductType == '2') || (TedataGuide == 1)) {
            if (!isForceModifyPwd) {
                document.write('<input type="button" id="guidewlanconfig" name="/html/amp/wlanbasic/guidewificfg.asp" class="CancleButtonCss buttonwidth_100px" onClick="onprevious(this);">');
            }
        } else {
            document.write('<input type="button" id="guidewificfg" name="/html/amp/wlanbasic/guidewificfg.asp" class="CancleButtonCss buttonwidth_100px" onClick="onprevious(this);">');
            document.write('<input type="button" id="guidecmodecfg" name="/html/ssmp/modechange/modechange.asp" class="CancleButtonCss buttonwidth_100px" style="float:left;" value="" onClick="ClickPreCMmode(this);">');
        }
        </script>
        <script>
            if (CfgMode.toUpperCase() == "TURKCELL2") {
                setText('guidewificfg', AccountLgeDes['s2004']);
            } else if ((ProductType == '2') || (TedataGuide == 1)) {
                if((IsSurportInternetCfg == 0) && (IsSurportWlanCfg == 0)) {
                    setText('guidewlanconfig', AccountLgeDes['s2004']);
                } else {
                    setText('guidewlanconfig', AccountLgeDes['s2001']);
                }
            } else {
                if((IsSurportInternetCfg == 0) && (IsSurportWlanCfg == 0)) {
                    setText('guidewificfg', AccountLgeDes['s2004']);
                } else {
                    setText('guidewificfg', AccountLgeDes['s2001']);
                    if(apcmodefeature == 1) {
                        setText('guidecmodecfg', AccountLgeDes['s2001']);
                    }else{
                        setText('guidecmodecfg', AccountLgeDes['s2004']);
                    }
                }
            }
            
        if(CfgMode == "GLOBE2") {
            document.write('<input type="button" id="guidecfgdone" name="/html/ssmp/bss/guidebssinfo.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitPwd(this);" BindText="s2002">');
            document.write('<a id="guideskip" name="/html/ssmp/bss/guidebssinfo.asp" href="#" onClick="onskip(this);"><span BindText="s2003"></span></a>');
        } else if (CfgMode.toUpperCase() == "TURKCELL2") {
            document.write('<input type="button" id="guidecfgdone" name="" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitPwd(this);" BindText="s0f0c"/>');
        } else {
            if ((fttrFlag == 1) && (isSupportOnulanCfg != 1)) {
                if (isBponFlag != 1) {
                    document.write('<input type="button" id="guidelanconfig" name="/html/bbsp/lanservicecfg/lanservicecfg.asp" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitPwd(this);" BindText="s2002"/>');
                    document.write('<a id="accountguideskip" name="/html/bbsp/lanservicecfg/lanservicecfg.asp" href="#" onClick="window.parent.onchangestep(this);"><span BindText="s2003"></span></a>');
                } else {
                    document.write('<input type="button" id="guidecfgdone" class="ApplyButtoncss buttonwidth_100px"  onClick="ClickExit(this);" BindText="s2002">');
                    document.write('<a id="guideskip"  onClick="ClickExit(this);"><span BindText="s2003"></span></a>');
                }
            } else if ((ProductType == '2') && isForceModifyPwd) {
                document.write('<input type="button" id="guidewlanconfig" name="/html/amp/wlanbasic/guidewificfg.asp" class="ApplyButtoncss buttonwidth_100px" style="margin-left: 125px" onClick="SubmitPwd(this);" BindText="s2002">');
            } else {
                document.write('<input type="button" id="guidecfgdone" name="/html/ssmp/cfgguide/userguidecfgdone.asp" class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitPwd(this);" BindText="s2002">');
                document.write('<a id="guideskip" name="/html/ssmp/cfgguide/userguidecfgdone.asp" href="#" onClick="onskip(this);"><span BindText="s2003"></span></a>');
            }
			
		}
        
        </script>
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        </div>
        </div>
        </div>    
    </div>

    <script>
        ParseBindTextByTagName(AccountLgeDes, "div",  1);
        ParseBindTextByTagName(AccountLgeDes, "span",  1);
        ParseBindTextByTagName(AccountLgeDes, "td",    1);
        ParseBindTextByTagName(AccountLgeDes, "input", 2);
    </script>
</div>
</body>
</html>
