<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var CmccRmsOsgiFlag = '<%HW_WEB_GetFeatureSupport(FT_CMCC_RMS_OSGI);%>';
var CmccOsgiFlag = '<%HW_WEB_GetFeatureSupport(FT_CMCC_OSGI);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var PwdType = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_PWDTYPE.UINT32);%>'
var UserLeveladmin = '<%HW_WEB_CheckUserInfo();%>';
var webPwdChange = '<%HW_WEB_GetFeatureSupport(FT_SSMP_KICKOFF_WEB_USER);%>';
var DBAA1= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";
var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
var curUserType = '<%HW_WEB_GetUserType();%>';
var sysUserType = '0';
var normalUserType = '1';
var updateFlag = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1.UpdateFlag);%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var isSurportWebsslPage  = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_WEBSSLPAGE);%>';
var isHG8010Hv6 = '<%HW_WEB_GetFeatureSupport(FT_WEB_HG8010HV6_CUT);%>';
var checkWeakPwdFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_CHECK_WEAKPWD);%>';
var secCodeLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>'
var pwdChangeNoticeFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_PWD_CHANGE_NOTICE);%>';

function GetLanguageDesc(Name)
{
	return AccountLgeDes[Name];
}

function stNormalUserInfo(UserName, ModifyPasswordFlag, InstantNo)
{
	this.UserName = UserName;
	this.ModifyPasswordFlag = ModifyPasswordFlag;
	this.InstantNo = InstantNo;
}

var UserInfo = <%HW_WEB_GetNormalUserInfo(stNormalUserInfo);%>;
var RosFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROS);%>'; 
function stModifyUserInfo(domain,UserName)
{
    this.domain = domain;
    this.UserName = UserName;
}
var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName, stModifyUserInfo);%>;
var sptUserName = UserInfo[0].UserName;
var sptInstantNo = UserInfo[0].InstantNo;

var PwdModifyFlag = 0;
var keyBoardConsecutiveNumber = '';
var consecutiveNumber = '';
var repeatedNumber = '';
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var isSpecialFlag = '<%HW_WEB_GetFeatureSupport(FT_SONET_WEB_PWD_LENGTH);%>';
var ispwdLength = '<%HW_WEB_GetFeatureSupport(FT_WEB_PWD_LENGTH_CHECK);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ttnet = '<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>';
if (ttnet == '1') {
    sptUserName = top.UserName;
}

function SupportTtnet()
{
    return (CfgMode.toUpperCase() == "DTTNET2WIFI" || CfgMode.toUpperCase() == "TTNET2");
}

function setAllDisable()
{
	setDisable('newUsername',1);
	setDisable('oldPassword',1);
	setDisable('newPassword',1);
	setDisable('cfmPassword',1);
	setDisable('MdyPwdApply',1);
	setDisable('MdyPwdcancel',1);
}

function reverstring(str)
{
    var tempstr = new Array();
    var i = 0;
    for (i = (str.length-1); i >=0; i--)
    {
        tempstr.push(str.charAt(i));
    }

    return tempstr.join("");
}

function CheckPwdIsComplexForRosunion(str)
{
    if (str.length < 8)
    {
        return false;
    }
    if (!isDigitInString(str))
    {
        return false;
    }
    if (!isLowercaseInString(str) && !isUppercaseInString(str))
    {
        return false;
    }

    var tempUserName = reverstring(sptUserName);
    if (!CompareString(str,sptUserName) )
    {
        return false;
    }
    if (!CompareString(str,tempUserName) )
    {
        return false;
    }

    return true;
}

function getMinCharTypeCount()
{
    if ((CmccOsgiFlag == '1') ||
        (CmccRmsOsgiFlag == '1') ||
        (CfgMode.toUpperCase() == "DTURKCELL2WIFI") ||
        (CfgMode.toUpperCase() == "TURKCELL2") ||
        (CfgMode.toUpperCase() == "HT") ||
        (CfgMode.toUpperCase() == "ROMANIADT2")) {
        return 3;
    }

    if (CfgMode.toUpperCase() == "EGVDF2") {
        return 4;
    }

    return 2;
}

function CheckPwdIsComplex(str)
{
	var i = 0;
	if(1 == RosFlag || '1' == RosFlag)
	{
        if (str.length < secCodeLen)
		{
			return false;
		}

		if (!CompareString(str,sptUserName) )
		{
			return false;
		}

		if ( isUppercaseInString(str) || isLowercaseInString(str))
		{
			i++;
		}

		if ( isDigitInString(str) )
		{
			i++;
		}
	}
	else if (1 == CmccOsgiFlag || 1 == CmccRmsOsgiFlag)
	{
	    if ( 8 > str.length )
		{
			return false;
		}

		if (!CompareString(str,sptUserName) )
		{
			return false;
		}

		if ( isLowercaseInString(str) || isUppercaseInString(str) )
		{
			i++;
		}

		if ( isDigitInString(str) )
		{
			i++;
		}

		if ( isSpecialCharacterNoSpace(str) )
		{
			i++;
		}
	}
	else if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2"))
	{
	    if ( 6 > str.length )
		{
			return false;
		}

		if (!CompareString(str,sptUserName) )
		{
			return false;
		}

		if ( isLowercaseInString(str) || isUppercaseInString(str) )
		{
			i++;
		}

		if ( isDigitInString(str) )
		{
			i++;
		}

		if ( isSpecialCharacterNoSpace(str) )
		{
			i++;
		}
    } else if (CfgMode.toUpperCase() == "ROMANIADT2") {
        if (str.length < 8) {
            return false;
        }

        if (!CompareString(str, sptUserName)) {
            return false;
        }

        if (isLowercaseInString(str)) {
            i++;
        }

        if (isUppercaseInString(str)) {
            i++;
        }

        if (isDigitInString(str)) {
            i++;
        }

        if (isSpecialCharacterNoSpace(str)) {
            i++;
        }
    } else if (CfgMode.toUpperCase() == "EGVDF2") {
        if (str.length < 8) {
            return false;
        }

        if (isLowercaseInString(str)) {
            i++;
        }

        if (isUppercaseInString(str)) {
            i++;
        }

        if (isDigitInString(str)) {
            i++;
        }

        if (isSpecialCharacterNoSpace(str)) {
            i++;
        }
    } else {
		if (isSpecialFlag == "1" || ispwdLength == "1") {
			if (str.length < 8) {
				return false;
			}
		} else {
			if (str.length < secCodeLen) {
				return false;
			}
		}

		if (!CompareString(str,sptUserName) )
		{
			return false;
		}

		if ( isLowercaseInString(str) )
		{
			i++;
		}

		if ( isUppercaseInString(str) )
		{
			i++;
		}

		if ( isDigitInString(str) )
		{
			i++;
		}

		if ( isSpecialCharacterNoSpace(str) )
		{
			i++;
		}
	}

    return i >= getMinCharTypeCount();
}

function LoadFrame()
{
    if (SupportTtnet()) {
        $("#PwdNotice").css("display", "none");
        $(".width_per60").css("width", "14%");
    }
    if ((CfgMode.toUpperCase() == "HT") || (CfgMode.toUpperCase() == "OTE")) {
        setDisplay('websslpage', 1);
	}
	if (isHG8010Hv6 == 1) {
		setDisplay('websslpage', 0);
	}
	
	if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
	{
		$("#checkinfo1Row").css("display", "none");
	}
	else
	{
		$("#checkinfo1Row").css("display", "none");
	}
	
	document.getElementById('WebUserName').appendChild(document.createTextNode(sptUserName));

	if((curWebFrame == 'frame_argentina') &&(curUserType != sysUserType))
	{
		setAllDisable();
	}

	PwdModifyFlag = UserInfo[0].ModifyPasswordFlag;

	if((parseInt(PwdModifyFlag,10) == 0) && (curLanguage.toUpperCase() != "CHINESE"))
	{
		 document.getElementById('tabledefaultpwdnotice').style.display="block";
		 document.getElementById('defaultpwdnotice').innerHTML=GetLanguageDesc("s1118");
	}

    if ((parseInt(PwdModifyFlag, 10) == 0) && ((CfgMode.toUpperCase() == "TTNET2") || (pwdChangeNoticeFlag == 1))) {
        document.getElementById('tabledefaultpwdnotice').style.display="block";
        document.getElementById('defaultpwdnotice').innerHTML=GetLanguageDesc("s1118a");
    }
	
	if((parseInt(PwdModifyFlag,10) == 0) && ('CTM' == CfgMode.toUpperCase()))
	{
		 document.getElementById('tabledefaultpwdnotice').style.display="block";
		 document.getElementById('defaultpwdnotice').innerHTML=GetLanguageDesc("s1118");
	}
	
	if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag || 1 == PwdTipsFlag)
	{
		var pwdcheck1 = document.getElementById('checkinfo1');
		pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="float:left; width: 126px;"><span style="text-align:center;padding:0px 15px; display:block;line-height:40px;" class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>';
	}

    if (((CfgMode.toUpperCase() == "DESKVDFPTAP") || (CfgMode.toUpperCase() == "AISAP") || (CfgMode.toUpperCase() == "LATVIATETAP")) && (updateFlag == 1)) {
        document.getElementById('tabledefaultpwdnotice').style.display = "none";
        document.getElementById('defaultpwdnotice').innerHTML = "";
        document.getElementById("MdyPwdApply").disabled = "disabled";
        document.getElementById("MdyPwdcancel").disabled = "disabled";
        setDisable('oldPassword', 1);
        setDisable('newPassword', 1);
        setDisable('cfmPassword', 1);
    }

    if((parseInt(PwdModifyFlag,10) == 1) && (CfgMode.toUpperCase() == "AISAP")) {
        document.getElementById('tabledefaultpwdnotice').style.display = "none";
    }

    if (CfgMode.toUpperCase() == "DICELANDVDF") {
        document.getElementById('tabledefaultpwdnotice').style.display = "none";
    }

    if (CfgMode.toUpperCase() == 'TS2WIFI') {
        setDisplay('websslpage', 1);
    }

    if (isSpecialFlag == "1") {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116sonet");
    }
    if (ispwdLength =="1") {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("ss1116d");        
     }
    if (CfgMode.toUpperCase() == "EGVDF2") {
        var pwdcheck1 = document.getElementById('checkinfo1');
        pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="float:left; width: 126px;"><span style="text-align:center;padding:0px 15px; display:block;line-height:40px;" class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>';
        document.getElementById('PwdNotice').innerHTML = "1. " + GetLanguageDesc("ss2011a") + "<br/>";
        document.getElementById('PwdNotice').innerHTML += "2. " + GetLanguageDesc("ss2012b") + "<br/>";
        document.getElementById('PwdNotice').innerHTML += "3. " + GetLanguageDesc("s2013");
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
	var oldPassword = document.getElementById("oldPassword");
	var newPassword = document.getElementById("newPassword");
	var cfmPassword = document.getElementById("cfmPassword");

    var needCheckOldPwdEmpty = true;
    if ((DBAA1 == "1") && (curUserType == normalUserType)) {
        needCheckOldPwdEmpty = false;
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

    if ((CfgMode.toUpperCase() == "TURKSATEBG3")) {
        if (newPassword.value.length < 8) {
            AlertEx(GetLanguageDesc("ss2011a"));
            return false;
        }
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

	var checkPwdUrl = "../common/CheckNormalPwd.asp?&1=1";
	if (ttnet == 1 ) {
		checkPwdUrl = "../common/CheckOldPwd.asp?&1=1";
	}

	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : "../common/CheckNormalPwd.asp?&1=1",
	data :'NormalPwdInfo=' + NormalPwdInfo + '&NewWebUserPwd=' + FormatUrlEncode(newPassword.value),
	success : function(data) {
		CheckResult=data;
		}
	});

	if (CheckResult == 2) {
		AlertEx(GetLanguageDesc("s0f16"));
		return false;
	} else if (CheckResult != 1) {
		AlertEx(GetLanguageDesc("s0f11"));
		return false;
	}

    if (('PLDT' == CfgMode.toUpperCase()) || 
        ('PLDT2' == CfgMode.toUpperCase())) {
        if (!CheckPwdIsComplexForPldt(newPassword.value)) {
            AlertEx(GetLanguageDesc("s1902"));
            return false;
        }
	}
	
    if (CfgMode.toUpperCase() == "TTNET2") {
        if (!TtnetComplex(oldPassword.value, newPassword.value)) {
            return false;
        }
    }

	if (PwdType == 4)
	{
		if (!CheckPwdIsComplexForRosunion(newPassword.value))
		{
			AlertEx(GetLanguageDesc("s1902"));
			return false;
		}
	}
	else if(!CheckPwdIsComplex(newPassword.value))
	{
        if (CfgMode.toUpperCase() == "EGVDF2") {
            AlertEx(GetLanguageDesc("s1116m"));
            return false;
        }
		AlertEx(GetLanguageDesc("s1902"));
		return false;
	}

	setDisable('MdyPwdApply', 1);
	setDisable('MdyPwdcancel', 1);
	return true;
}

function CheckPwdIsComplexForPldt(str) {
    var complexValue = 0;
    if (str.length < 8) {
        return false;
    }

    if (isLowercaseInString(str)) {
        complexValue++;
    }

    if (isUppercaseInString(str)) {
        complexValue++;
    }

    if (isDigitInString(str)) {
        complexValue++;
    }

    if (isSpecialCharacterNoSpace(str)) {
        complexValue++;
    }

    if (complexValue < 3) {
        return false;
    }

    var tempUserName = reverstring(sptUserName);
    if (!CompareString(str, sptUserName)) {
        return false;
    }

    if (!CompareString(str, tempUserName)) {
        return false;
    }
    return true;
}

function getInstIDbyUserName(username)
{
    var instId = 0;
    for (var i = 0; i < stModifyUserInfos.length; i++) {
        if (stModifyUserInfos[i].UserName == username) {
            var temp = stModifyUserInfos[i].domain.split(".");
            instId = temp[temp.length-1];
            break;
        }
    }
    return instId;
}

function SubmitPwd()
{
    if ((!CheckParameter()) || (((CfgMode.toUpperCase() == "DESKVDFPTAP") || (CfgMode.toUpperCase() == "AISAP") || (CfgMode.toUpperCase() == "LATVIATETAP")) && (updateFlag == 1))) {
        return false;
    }

    var parainfo="";
    parainfo = 'x.OldPassword=' + FormatUrlEncode(getValue('oldPassword')) + "&";
    parainfo += 'x.Password=' + FormatUrlEncode(getValue('newPassword')) + "&";
    parainfo += 'x.X_HW_Token=' + getValue('onttoken');
    if (ttnet == '1') {
        sptInstantNo = getInstIDbyUserName(sptUserName);
    }

    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : parainfo,
         url : "setajax.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo." + sptInstantNo + "&RequestFile=html/ssmp/accoutcfg/account.asp",
         success : function(data) {
                var ResultInfo = JSON.parse(hexDecode(data));
                if (ResultInfo.result == 0) {
                    if (webPwdChange == 1) {
                        AlertEx(GetLanguageDesc("s0f0e0"));
                    } else {
                        AlertEx(GetLanguageDesc("s0f0e"));
                    }
                    CancelValue();
                    ChangePwdNotice();
                } else {
                    var errorcode = ResultInfo.error;
                    if (errorcode == 0xf7200119) {
                        AlertEx(GetLanguageDesc("s0f17"));
                    } else {
                        AlertEx(GetLanguageDesc("s2200"));
                    }
                }
         },
         complete: function (XHR, TS) {
            XHR=null;
            setDisable('MdyPwdApply', 0);
            setDisable('MdyPwdcancel', 0);
         }
    });
}

function GetLanguageDesc(Name)
{
	return AccountLgeDes[Name];
}

function CancelValue()
{
	setText('oldPassword','');
	setText('newPassword','');
	setText('cfmPassword','');
	if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag || 1 ==  PwdTipsFlag)
	{
		$("#checkinfo1Row").css("display", "none");
		$("#psd_checkpwd").css("display", "none");
	}
}

function ChangePwdNotice()
{
  if (CfgMode.toUpperCase() == "AISAP" ) {
    document.getElementById('tabledefaultpwdnotice').style.display = "none";
  }
}

function CheckPwdNotice()
{
    var password1 = getElementById("newPassword").value;
    var password2 = getElementById("oldPassword").value;

    if (password1.length == 0) {
        return;
    }

    if (CfgMode.toUpperCase() == "DTTNET2WIFI" || (CfgMode.toUpperCase() == "TTNET2")) {
        if (!TtnetComplex(password2, password1)) {
            return;
        }
        return;
    }

	if (PwdType == 4)
	{
		if (!CheckPwdIsComplexForRosunion(password1))
		{
			AlertEx(GetLanguageDesc("s1902"));
			return false;
		}
	}
	else if(!CheckPwdIsComplex(password1))
	{
        if (CfgMode.toUpperCase() == "EGVDF2") {
            AlertEx(GetLanguageDesc("s1116m"));
            return false;
        }

		AlertEx(GetLanguageDesc("s1902"));
		return;
	}
	
	return;
}

function egvdfPwdStrengthcheck()
{
    var password = getElementById("newPassword").value;
    var score = 0;

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
        getElementById("pwdvalue1").style.width=23+"%";
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
    var password1 = getElementById("newPassword").value;
	var DestPwdLen = secCodeLen;
	
	if ((((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) && (curUserType == sysUserType)) || (CfgMode.toUpperCase() == "ROMANIADT2")) {
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

function StartFileOpt()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
}

function fchange()
{
    var ffile = document.getElementById("f_file");
    var tfile = document.getElementById("t_file");
    ffile.value = tfile.value;

    var buttonstart = document.getElementById('ImportCertification');
    buttonstart.focus();
}

function VerifyFile(FileName)
{
	var File = document.getElementsByName(FileName)[0].value;
	if (File.length == 0)
	{
		AlertEx(GetLanguageDesc("s0d10"));
		return false;
	}
	if (File.length > 128)
	{
		AlertEx(GetLanguageDesc("s0d11"));
		return false;
	}

	return true;
}

function uploadCert()
{
	if (isSurportWebsslPage != 1)
	{
		return false;
	}
	var uploadForm = document.getElementById("fr_uploadImage");
	if (VerifyFile('browse') == false)
	{
	   return;
	}
	top.previousPage = '/html/ssmp/accoutcfg/account.asp';
	setDisable('btnSubmit',1);
	uploadForm.submit();
	setDisable('browse',1);
	setDisable('btnBrowse',1);
}

</script>
</head>

<body class="mainbody" onLoad="LoadFrame();">
    <script language="JavaScript" type="text/javascript">
        if (((CfgMode.toUpperCase() == "DESKVDFPTAP") || (CfgMode.toUpperCase() == "AISAP") || (CfgMode.toUpperCase() == "LATVIATETAP")) && (updateFlag == 1)) {
            HWCreatePageHeadInfo("account", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0f12ap"), false);
        } else {
            HWCreatePageHeadInfo("account", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0f12"), false);
        }
	</script>
	<div class="title_spread"></div>

	<table id="tabledefaultpwdnotice" width="100%" border="0" cellpadding="0" cellspacing="0" style="display:none;">
		<tr>
			<td id="defaultpwdnotice"></td>
		</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="1">
		<tr id="secUsername">
			<td class="width_per40">
				<form id="PwdChangeCfgForm"  name="PwdChangeCfgForm">
					<table id="PwdChangeCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF">
						<li id="WebUserName" RealType="HtmlText" DescRef="s0f08" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="WebUserName"   InitValue="Empty"/>
						<li id="oldPassword" RealType="TextBox"  DescRef="s0f13" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.OldPassword" InitValue="Empty"/>
                        <script>
                            if (SupportTtnet()) {
                                document.write('<li id="newPassword" RealType="TextBoxNP"  DescRef="s0f09" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Password"    InitValue="Empty" onKeyUp="psdStrength()"/>');
                                document.write('<li id="cfmPassword" RealType="TextBoxNP"  DescRef="s0f0b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"         InitValue="Empty"/>');
                            } else if (CfgMode.toUpperCase() == "EGVDF2") {
                                document.write('<li id="newPassword" RealType="TextBox"  DescRef="s0f09" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Password"    InitValue="Empty" onKeyUp="psdStrength()"/>');
                                document.write('<li id="checkinfo1" RealType="HtmlText"  DescRef="s1447" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;"/>');
                                document.write('<li id="cfmPassword" RealType="TextBox"  DescRef="s0f0b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"         InitValue="Empty"/>');
                            } else {
                                document.write('<li id="newPassword" RealType="TextBox"  DescRef="s0f09" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Password"    InitValue="Empty" onKeyUp="psdStrength()"/>');
                                document.write('<li id="cfmPassword" RealType="TextBox"  DescRef="s0f0b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"         InitValue="Empty"/>');
                                document.write('<li id="checkinfo1" RealType="HtmlText"  DescRef="s1447" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;"/>');
                            }
                        </script>
					</table>
					<script>
						var PwdChangeCfgFormList = new Array();
						PwdChangeCfgFormList = HWGetLiIdListByForm("PwdChangeCfgForm", null);
						var TableClass = new stTableClass("width_per60", "width_per40");
						HWParsePageControlByID("PwdChangeCfgForm", TableClass, AccountLgeDes, null);

						var PwdChangeArray = new Array();

						
						HWSetTableByLiIdList(PwdChangeCfgFormList, PwdChangeArray, null);
												
						$('#newPassword').bind('keyup',function()
						{
							if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag || 1 == PwdTipsFlag)
							{
								$("#checkinfo1Row").css("display", "");
								$("#psd_checkpwd").css("display", "block");
								psdStrength();
							}
						});
						
                        if(CfgMode.toUpperCase() == "EGVDF2") {
                            $('#newPassword').bind('keyup',function()
                            {
                                $("#checkinfo1Row").css("display", "");
                                $("#psd_checkpwd").css("display", "block");
                                egvdfPwdStrengthcheck();
                            });
                        }

						$('#newPassword').blur(function()
						{
							CheckPwdNotice();
						});
						$('#oldPasswordColleft').css("white-space", "nowrap");
						$('#newPasswordColleft').css("white-space", "nowrap");
						$('#cfmPasswordColleft').css("white-space", "nowrap");
					</script>
				</form>
			</td>
			<script language="JavaScript" type="text/javascript">
			if(1 == RosFlag || '1' == RosFlag)
			{
				var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="ss1116e"></td>';
			}
			else
			{
			    if (1 == CmccOsgiFlag || 1 == CmccRmsOsgiFlag) {
			        var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116b"></td>';
			    } else if ((oteFlag == 1) || (htFlag == 1)) {
			        var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116_ote"></td>';
			    } else if (secCodeLen == 8) {
			        var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="ss1116d"></td>';
			    } else if (isSpecialFlag == "1") {
					var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116sonet"></td>';
				}
				else {
			        var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116a"></td>';
			    }
			}

			if (PwdType == 4)
			{
				var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="ss1116r"></td>';
			}

			if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2"))
			{
				var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116i"></td>';
            } else if (CfgMode.toUpperCase() == "ROMANIADT2") {
                var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116k"></td>';
            }

            if (('PLDT' == CfgMode.toUpperCase()) ||
                ('PLDT2' == CfgMode.toUpperCase())) {
                var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116h"></td>';
            }

            if (CfgMode.toUpperCase() == "TTNET2") {
               var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116h"></td>';
            }

            if (CfgMode.toUpperCase() == "TURKSATEBG3") {
               var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116h"></td>';
            }

			document.write(innerhtml);
			</script>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
		<tr>
			<td class="table_submit width_per25"></td>
			<td  class="table_submit">
				<input type="button" id="MdyPwdApply"  name="MdyPwdApply"  class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitPwd();"   BindText="s0f0c">
				<input type="button" id="MdyPwdcancel" name="MdyPwdcancel" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();" BindText="s0f0d">
            </td>
        </tr>
    </table>

    <div id="websslpage" style="display:none;">
	<div class="func_spread"></div>
        <form action="websslcert.cgi?RequestFile=html/ssmp/accoutcfg/account.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage">
            <div>
                <script>
                    if (CfgMode.toUpperCase() == 'TS2WIFI') {
                        document.write('<div id="wssll" class="func_title" BindText="s0d29"></div>');
                    } else {
                        document.write('<div id="wssll" class="func_title" BindText="s0e2c"></div>');
                    }
                </script>
                <table>
                    <tr>
                        <td class="filetitle" BindText="s0d2a"></td>
                        <td>
                            <div class="filewrap">
                                <div class="fileupload">
                                    <input type="hidden" id="hwonttoken"   name="onttoken"     value="<%HW_WEB_GetToken();%>">
                                    <input type="text"   id="f_file" autocomplete="off" readonly="readonly" />
                                    <input type="file"   id="t_file" name="browse" size="1"  onblur="StartFileOpt();" onchange="fchange();" />
                                    <input type="button" id="btnBrowse" class="CancleButtonCss filebuttonwidth_100px" BindText="s0d2b" />
                                </div>
                            </div>
                        </td>
                        <td>
                            <input class="CancleButtonCss filebuttonwidth_100px" id="ImportCertification" name="btnSubmit" type='button' onclick='uploadCert();' BindText="s0d2c" />
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>

	<script>
		var ele = document.getElementById("divTablePwdChangeCfgForm");
		ele.setAttribute('class', '');

		ele = document.getElementById("PwdNotice");
		if(CuOSGIMode == "1")
		{
			ele.style.color = '#FFFFFF';
		}
		else if ( 'ZAIN' == CfgMode.toUpperCase())
		{
			ele.style.background = '#000000';
		} else if (rosunionGame == "1") {
            ele.style.background = 'rgb(0, 28, 69)';
		}
		else
		{
		ele.style.background = '#FFFFFF';
		}
        ParseBindTextByTagName(AccountLgeDes, "div",    1);
		ParseBindTextByTagName(AccountLgeDes, "td",     1);
		ParseBindTextByTagName(AccountLgeDes, "input",  2);
		if (CfgMode.toUpperCase() == "DNZVDF2WIFI") {
			setDisplay('WebUserNameRow', 0);
		}
	</script>
</body>
</html>
