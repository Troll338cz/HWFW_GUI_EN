<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style type='text/css'>
  span.language-string {
  padding: 0px 15px;
  display: block;
  height: 40px;
  line-height: 40px;
}
.row.hidden-pw-row {
  width: 132px;
  height: 30px;
  line-height: 30px;
}

#HilinkTips {
  display:none;
  color:red;
  font-family: 'Tohama', 'Arial', '宋体';
  font-size: 12px;
}
</style>
<script language="JavaScript" type="text/javascript">

var MultiUser = 0;
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var keyBoardConsecutiveNumber = '';
var consecutiveNumber = '';
var repeatedNumber = '';
var ShowOldPwd = 0;
var sptUserName = null;
var sptAdminName;
var UserNum = 0;
var CurUserBuf = new Array(); 
var CurUserInst = new Array(); 
var Ftmodifyadmin = '<%HW_WEB_GetFeatureSupport(FT_WEB_MODIFY_USER_PWD);%>';  
var RosFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROS);%>'; 
var PwdType = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_PWDTYPE.UINT32);%>'
var PwdMinLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>'
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var Ftmodifyowner =  '<%HW_WEB_GetFeatureSupport(FT_WEB_MODIFY_OWNER_PWD);%>';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var IsViettel8045A2Flag='<%HW_WEB_GetFeatureSupport(FT_SSMP_VIETTEL_8045MODE);%>';
var CmccRmsOsgiFlag = '<%HW_WEB_GetFeatureSupport(FT_CMCC_RMS_OSGI);%>';
var CmccOsgiFlag = '<%HW_WEB_GetFeatureSupport(FT_CMCC_OSGI);%>';
var clisynFlag = '<%HW_WEB_GetFeatureSupport(HW_FT_CLI_WEB_PASSWORD_SYN);%>';
var cliadminsynFlag = '<%HW_WEB_GetFeatureSupport(HW_FT_CLI_WEB_PASSWORD_AUTH_IG);%>';
var adminUsrName = "";
var curUserName = '<%HW_WEB_GetCurUserName();%>';
var APType ='<%HW_WEB_GetApMode();%>'
var UpdateFlag = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.2.UpdateFlag);%>';
var Is8011_21V5 = "<%HW_WEB_GetFeatureSupport(FT_NEW_AP);%>";
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';
var webPwdChange = '<%HW_WEB_GetFeatureSupport(FT_SSMP_KICKOFF_WEB_USER);%>';
var DBAA1= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var curUserType = '<%HW_WEB_GetUserType();%>';
var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";
var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
var resetUserPwdFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_RESET_USER_PWD);%>';
var dbaa1SuperAdminUserType = '2';
var pwdModifyFlag = 0;
var supportCertAlarm = '<%HW_WEB_GetFeatureSupport(FT_CWMP_CERTIFICATE_ALARM);%>';
var supportCertDisplay = '<%HW_WEB_GetFeatureSupport(FT_CWMP_CERTIFICATE_WEB);%>';
var isHG8010Hv6 = '<%HW_WEB_GetFeatureSupport(FT_WEB_HG8010HV6_CUT);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var checkWeakPwdFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_CHECK_WEAKPWD);%>';
var pwdComplexFt = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PWDCOMPLEX);%>';
var isSpecialFlag = '<%HW_WEB_GetFeatureSupport(FT_SONET_WEB_PWD_LENGTH);%>';
var ispwdLength = '<%HW_WEB_GetFeatureSupport(FT_WEB_PWD_LENGTH_CHECK);%>';
var isOltVisualUser = "<%HW_WEB_IfVisualOltUser();%>";
var totalplay = '<%HW_WEB_GetFeatureSupport(FT_SSMP_TOTALPLAY);%>';
var curUserInfoStatus = '<%WEB_GetUserInfoStatus();%>';
var cmccApFlag = '<%HW_WEB_GetFeatureSupport(FT_DESKCMCCAP_SUPPORT);%>';
var ttnet = '<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>';
var pwdChangeNoticeFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_PWD_CHANGE_NOTICE);%>';
var sysUserType = '0';

var normalUpdateFlag = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.1.UpdateFlag);%>';
if ((normalUpdateFlag == 1) && (CfgMode.toUpperCase() == "RDSAP")) {
    UpdateFlag = 1;
}

var isMultiAdminUser = '<%HW_WEB_GetFeatureSupport(FT_WEB_SUPPORT_MULTI_ADMINGUIDE);%>';

function GetLanguageDesc(Name)
{
	return AccountLgeDes[Name];
}

function IsSYNCSGP210WAdmin()
{
    if ((CfgModeWord.toUpperCase() == 'SYNCSGP210W') && (curUserName == sptAdminName)) {
        return true;
    }
    return false;
}

function stModifyUserInfo(domain,UserName,UserLevel,Enable,modifyFlag)
{
	this.domain = domain;
	this.UserName = UserName;
	this.UserLevel = UserLevel;
    this.Enable = Enable;
    this.modifyFlag = modifyFlag;
}

function stSSLWeb(domain,Enable)
{
	this.domain = domain;
	this.Enable   = Enable;
}

var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName|UserLevel|Enable|ModifyPasswordFlag, stModifyUserInfo);%>;
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var stSSLWebs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebSslInfo,Enable,stSSLWeb);%>;
var SSLConfig = stSSLWebs[0];


var IsSurportWebsslPage  = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_WEBSSLPAGE);%>';
if (3 < stModifyUserInfos.length)
{
	MultiUser = 1;
}

if (pwdChangeNoticeFlag == 1) {
    if (stModifyUserInfos.length == 2) {
        pwdModifyFlag = stModifyUserInfos[0].modifyFlag;
    } else {
        pwdModifyFlag = stModifyUserInfos[1].modifyFlag;
    }
 
}

function SupportTtnet()
{
    return (CfgMode.toUpperCase() == "DTTNET2WIFI" || CfgMode.toUpperCase() == "TTNET2");
}

function dbaa1UserShouldBeSelected(userName)
{
    return (DBAA1 == "1") &&
           (curUserType == dbaa1SuperAdminUserType) &&
           (userName == curUserName);
}

function onDbaa1UserNameModified(instNo, newUserName)
{
    stModifyUserInfos[instNo].UserName = newUserName;
    sptUserName = newUserName;

    var webUserList = getElementById("WebUserList");
    CurUserBuf[webUserList.value - 1] = newUserName;

    for (var i = 0;i < webUserList.options.length;i++) {
        var webUserListItem = webUserList.options[i];
        if (webUserListItem.value == webUserList.value) {
            webUserListItem.text = newUserName;
            break;
        }
    }
}

function filterUserInfo(userInfo)
{
    if (CfgMode.toUpperCase() == 'DNOVA2WIFI') {
        return (curUserType != sysUserType) && (userInfo.UserLevel == '0');
    }

    if (DBAA1 == "1") {
        if (curUserType == "0") {
            return (userInfo.Enable != 1) || (userInfo.UserLevel != 1);
        }
    }
    return userInfo.Enable != 1;
}

if (Ftmodifyowner == 1)
{
	for (var i = 0; i < stModifyUserInfos.length - 1; i++)
	{
		if (stModifyUserInfos[i].UserLevel == 0)
		{
			sptAdminName = stModifyUserInfos[i].UserName;
			sptUserName = stModifyUserInfos[i].UserName;
			adminUsrName = stModifyUserInfos[i].UserName;
			ShowOldPwd = 1;			
			UserNum = 1; 
            CurUserInst[0]= i;
            pwdModifyFlag = stModifyUserInfos[i].modifyFlag;
			break;
		}		
	}
}
else
{
	for (var i = 0; i < stModifyUserInfos.length - 1; i++)
	{
		if (stModifyUserInfos[i].UserLevel == 0)
		{
			sptAdminName = stModifyUserInfos[i].UserName;
			adminUsrName = stModifyUserInfos[i].UserName;
		}
			
		if (1 == Ftmodifyadmin)
		{
			if (filterUserInfo(stModifyUserInfos[i]) == false)
			{
                var isSelectedUser = UserNum == 0;
                if (DBAA1 == "1") {
                    isSelectedUser = dbaa1UserShouldBeSelected(stModifyUserInfos[i].UserName);
                }

                if (isSelectedUser) {
                    sptUserName = stModifyUserInfos[i].UserName;
                    if (stModifyUserInfos[i].UserName == curUserName) {
                        ShowOldPwd = 1;
                    }
                }
				
				CurUserInst[UserNum] = i;
				UserNum++;
			}
		}
		else if ((sptUserName == null) || (totalplay == '1'))
		{
			if (stModifyUserInfos[i].UserLevel == 1)
			{
                if (sptUserName == null) {
                    sptUserName = stModifyUserInfos[i].UserName;
                }
				CurUserInst[UserNum] = i;
				UserNum++;
			}
		}
	}
}
if (1 < UserNum)
{
	MultiUser = 1;
}

function title_show(input)
{
	var div=document.getElementById("title_show");

	if ("ARABIC" == LoginRequestLanguage.toUpperCase())
	{
		div.style.right = (input.offsetLeft+50)+"px";
	}
	else
	{
		div.style.left = (input.offsetLeft+375)+"px";
	}

    if (isSpecialFlag == "1") {
        div.innerHTML = WebcertmgntLgeDes['s1116sonet'];
    } else if (ispwdLength == "1") {
        div.innerHTML = WebcertmgntLgeDes['ss1116d']; 
    }else {
        div.innerHTML = WebcertmgntLgeDes['s1116'];
    }

	var webCertTips = (pwdComplexFt == 1) ? 's1116_sec' : 's1116';
	div.innerHTML = WebcertmgntLgeDes[webCertTips];
	div.style.display = '';
	if ( 'ZAIN' == CfgMode.toUpperCase())
	{
		div.style.color = '#000000';
	}
	if (CfgModeWord.toUpperCase() == "ROSUNION") {
		div.style.background = 'rgb(39, 58, 100)';
		div.style.color = '#fff';
		div.style.border = 'none';
		div.style.padding = '5px';
	}
}
function title_back(input)
{
	var div=document.getElementById("title_show");
	div.style.display = "none";
}

function WriteUserListOption(val)
{
    if (stModifyUserInfos == 'null') {
        return false;
    }

    var j = 0;
    var output = '<select id="WebUserList" name="WebUserList" onchange="OnSelectedUserChanged(this.value)">';
    for (i = 0; i < stModifyUserInfos.length - 1; i++) {
        var userInfoItem = stModifyUserInfos[i];
        if (filterUserInfo(userInfoItem)) {
            continue;
        }
        if ((stModifyUserInfos[i].UserLevel == 0) && (totalplay == '1')) {
            continue;
        }
        output += '<option ';
        if ((DBAA1 == "1") && dbaa1UserShouldBeSelected(userInfoItem.UserName)) {
            output += ' selected ';
        }
        output += ' value="' + (j + 1) + '">' + htmlencode(userInfoItem.UserName);
        output += '</option>';
        CurUserBuf[j] = htmlencode(userInfoItem.UserName);
        j++;
    }
    output += "</select>";

    $("#" + val).append(output);
    return true;
}

function CheckFormPassword(type)
{
	with(document.getElementById("WebcertCfgForm"))
	{
		if(WebcertPassword.value.length > 127)
		{
			AlertEx(GetLanguageDesc("s1904"));
			setText('WebcertPassword', '');
			setText("WebCfmPassword", "");
			return false;
		}

		if (WebcertPassword.value == '')
		{
			AlertEx(GetLanguageDesc("s1430"));
			return false;
		}

		if(WebcertPassword.value != WebCfmPassword.value)
		{
			AlertEx(GetLanguageDesc("s0d0f"));
			setText("WebcertPassword", "");
			setText("WebCfmPassword", "");
			return false;
		}

		if(CheckPwdIsComplexWithSpace(WebcertPassword.value) == false)
		{
			AlertEx(GetLanguageDesc("s1902"));
			return false;
		}
	}
	return true;
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
	if (IsSurportWebsslPage !=1)
	{
		return false;
	}
	var uploadForm = document.getElementById("fr_uploadImage");
	if (VerifyFile('browse') == false)
	{
	   return;
	}
	top.previousPage = '/html/ssmp/accoutcfg/accountadmin.asp';
	setDisable('btnSubmit',1);
	uploadForm.submit();
	setDisable('browse',1);
	setDisable('btnBrowse',1);
}

function AddSubmitImportcert()
{
	if (IsSurportWebsslPage != 1)
	{
		return false;
	}
	if (CheckFormPassword() == false)
	{
		return ;
	}

	var Form = new webSubmitForm();
	Form.addParameter('x.CertPassword',getValue('WebcertPassword'));
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('complex.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebSslInfo'
						 + '&RequestFile=html/ssmp/accoutcfg/accountadmin.asp');

	setDisable('WebbtnApply',1);
	setDisable('WebcancelValue',1);
	Form.submit();
}

function SetCertificateInfo()
{
	if (IsSurportWebsslPage != 1)
	{
		return false;
	}

	if (getCheckVal('WebCertificateEnable') == true) {
		if (ConfirmEx(GetLanguageDesc("s1911")) == false) {
			setCheck('WebCertificateEnable', 0);
			return false;
		}
	}

	var Form = new webSubmitForm();
	var Value = getCheckVal('WebCertificateEnable');

	Form.addParameter('x.Enable', Value);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebSslInfo&RequestFile=html/ssmp/accoutcfg/accountadmin.asp');
	Form.submit();
}

function StartFileOpt()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
}

function CancelConfigPwd()
{
	setText("WebcertPassword", "");
	setText("WebCfmPassword", "");
}
function CheckPwdIsComplex(str)
{
	var i = 0;
    if(1 == RosFlag || '1' == RosFlag)
	{
		if (str.length < PwdMinLen)
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
	else if ( 1 == CmccOsgiFlag || 1 == CmccRmsOsgiFlag || (((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) && adminUsrName == sptUserName))
	{
	    if ( 8 > str.length )
		{
			return false;
		}

        if ((CfgMode.toUpperCase() != "DESKCMCC4AP") && (CfgMode.toUpperCase() != "DESKCMCC4SHAP")) {
            if (!CompareString(str,sptUserName)) {
                return false;
            }
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
			if (str.length < PwdMinLen) {
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
	
	if ((CmccOsgiFlag == '1') || (CmccRmsOsgiFlag == '1') || ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) || (CfgMode.toUpperCase() == "ROMANIADT2") || (CfgMode.toUpperCase() == "TEDATA2")) {
	    if ( i >= 3 )
		{
			return true;
		}
	} else if (CfgMode.toUpperCase() == "EGVDF2") {
        if (i >= 4) {
            return true;
        }
    } else {
	    if ( i >= 2 )
		{
			return true;
		}
	}
	
	return false;
}
function CheckPwdIsComplexWithSpace(str)
{
	var i = 0;
    if (str.length < PwdMinLen) {
		return false;
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

	if ( isSpecialCharacterInString(str) )
	{
		i++;
	}
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}

function SupportDisplayCertAlarm()
{
    if (supportCertAlarm != "1" || supportCertDisplay != "1" ) {
        return false;
    }

    if ((curLanguage.toUpperCase() != "CHINESE") && (curLanguage.toUpperCase() != "ENGLISH")) {
        return false;
    }

    return true;
}

function vdfPwdStrength(id)
{
    var checkid = "pwdvalue5"
    egvdfPwdStrengthcheck(id, checkid);
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

function LoadFrame()
{
    if (CfgMode.toUpperCase() == "EGVDF2") {
        $("#vdfPwdStrengthRow").css("display", "none");
        var pwdCheck = document.getElementById('vdfPwdStrength');
        pwdCheck.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwdvdf" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue5" BindText="amp_pwd_strength_low"></span></div></div>';
    }

    if (SupportTtnet()) {
        $("#PwdNotice").css("display", "none");
        $(".width_per60").css("width", "14%");
    }

	if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
	{
		$("#checkinfo1Row").css("display", "none");
		
		$("#wssl").css("display", "none");
		$("#yssl").css("display", "");
		$("#wssll").css("display", "none");
		$("#yssll").css("display", "");

	}
	else
	{
		$("#checkinfo1Row").css("display", "none");
		
		$("#wssl").css("display", "");
		$("#yssl").css("display", "none");
		$("#wssll").css("display", "");
		$("#yssll").css("display", "none");
	}
	
	if (1 == ShowOldPwd)
	{
		document.getElementById('oldPasswordDEFHIDERow').style.display  = ""; 
	}	
	
	if( 1 == IsSurportWebsslPage )
	{
		setDisplay("websslpage",1);
	}

    if ((resetUserPwdFlag == "1") && (CfgModeWord != "TRIPLETSINGLE")) {
        setDisplay("resetUserPwd", 1);
    }

    if (IsSYNCSGP210WAdmin()) {
        setDisplay("oldPasswordDEFHIDE", 1);
        setDisplay("modifyUsername", 1);
        setDisplay("UserNameChangeCfgForm", 1);
    }

	if ( null != SSLConfig )
	{
		setCheck('WebCertificateEnable', SSLConfig.Enable);
	}

	if( ( window.location.href.indexOf("complex.cgi?") > 0) )
	{
		AlertEx(GetLanguageDesc("s0d14"));
	}

	
    
    if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag || 1 == PwdTipsFlag)
    {
        var pwdcheck1 = document.getElementById('checkinfo1');
        pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>';
    }
    if(1 == RosFlag || '1' == RosFlag)
    {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("ss1116e");        
    }
    if (PwdType == 3)
    {
        if (CfgMode.toUpperCase() == 'VIETTEL2') {
            document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("ss1116g");
        } else {
            document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("ss1116f");
        }
    }
	else if (PwdType == 4)
	{
		document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("ss1116r");
	}
    else
    {
	    if (1 == CmccOsgiFlag || 1 == CmccRmsOsgiFlag || CfgMode.toUpperCase() == "TEDATA2")
		{
			document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116b");
		}
		else
		{
		    if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2"))
			{
				if (adminUsrName == sptUserName)
				{
					document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116h");
				}
				else
				{
					document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116i");
				}
            } else if (CfgMode.toUpperCase() == "ROMANIADT2") {
                document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116k");
            } else if (CfgMode.toUpperCase() == "TTNET2") {
                document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116h");
            } else if ((oteFlag == 1) || (htFlag == 1)) {
                document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116_ote");
            }  else if (PwdMinLen == 8) {
                document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("ss1116d");
            } else {
                document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116a");
            }
		}
    }
	
    if (CfgMode.toUpperCase() == "TURKSATEBG3") {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116h");
    }

	if(UpdateFlag == 1){
        document.getElementById("MdyPwdApply").disabled="disabled";
		document.getElementById("MdyPwdcancel").disabled="disabled";
		setDisable('oldPasswordDEFHIDE', 1);
		setDisable('newPassword', 1);
		setDisable('cfmPassword', 1);
    }
    
    setDisplay("PwdChangeCfgForm", 1);
    setDisplay("tableButton", 1);

    if (('PLDT' == CfgMode.toUpperCase()) || 
        ('PLDT2' == CfgMode.toUpperCase())) {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116h");
    }

    if (Is8011_21V5 == "1") {
        if (cmccApFlag == 1) {
            document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116cmap");
        } else if (PwdMinLen == 8) {
            document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116c_sec");
        } else {
            document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116c");
        }
    }

    if ((parseInt(pwdModifyFlag, 10) == 0) && ((CfgMode.toUpperCase() == "TTNET2") || (pwdChangeNoticeFlag == 1))) {
        document.getElementById('tabledefaultpwdnotice').style.display="block";
        document.getElementById('defaultpwdnotice').innerHTML=GetLanguageDesc("s1118a");
    }
    
    if (SupportDisplayCertAlarm()) {
        setDisplay("div_security_certificate_expiration", 1);
    } else {
        setDisplay("div_security_certificate_expiration", 0);
    }

    if(isHG8010Hv6 == "1") {
        setDisplay("resetUserPwd", 0);
        setDisplay("websslpage", 0);
        setDisplay("div_security_certificate_expiration", 0);
    }

    if ((MultiUser == 1) && (ttnet == 1)) {
        setSelect('WebUserList',getInstIdbyUserName(curUserName));
    }

    if (isSpecialFlag == "1") {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116sonet");
    }

    if (IsSYNCSGP210WAdmin()) {
        document.getElementById('UserNameNotice').innerHTML = GetLanguageDesc("s2826");
    }
    if (ispwdLength =="1") {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("ss1116d");        
    }
    if (CfgModeWord.toUpperCase() == "EGVDF2") {
        document.getElementById('PwdNotice').innerHTML = "1. " + GetLanguageDesc("ss2011a") + "<br/>";
        document.getElementById('PwdNotice').innerHTML += "2. " + GetLanguageDesc("ss2012b") + "<br/>";
        document.getElementById('PwdNotice').innerHTML += "3. " + GetLanguageDesc("s2013");
    }
    if (CfgMode.toUpperCase() == "VIETTELAP") {
        document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116c_viettel");
    }
}

function IsCurrentAdminUser(selectUserName) {
    for (var i = 0; i < stModifyUserInfos.length - 1; i++) {
        if (stModifyUserInfos[i].UserLevel == 0) {
            if ((curUserName == selectUserName) && (selectUserName == stModifyUserInfos[i].UserName)) {
                return true;
            }
        }
    }

    return false;
}

function OnSelectedUserChanged(itemValue)
{
    if (itemValue == 0) {
        return;
    }

    sptUserName = CurUserBuf[itemValue - 1];

    var userNameForCompare = sptAdminName;

    if (DBAA1 == '1') {
        userNameForCompare = curUserName;
        if (curUserType == dbaa1SuperAdminUserType) {
            if (curUserName != sptUserName) {
                setDisplay("newUserNameRow", 1);
            } else {
                setDisplay("newUserNameRow", 0);
            }
            document.getElementById('newUserName').value = sptUserName;
        }
    }

    var adminFlag = (userNameForCompare == sptUserName);
    if (isMultiAdminUser == 1) {
        adminFlag = IsCurrentAdminUser(sptUserName);
    }

    if (adminFlag || ((getUserLevelbyInstId(itemValue) == 0) && (CfgMode.toUpperCase() == "TTNET2"))) {
        ShowOldPwd = 1;
        document.getElementById('oldPasswordDEFHIDERow').style.display = "";
        if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) {
            document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116h");
        }
    } else {
        ShowOldPwd = 0;
        document.getElementById('oldPasswordDEFHIDERow').style.display = "none";
        if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) {
            document.getElementById('PwdNotice').innerHTML = GetLanguageDesc("s1116i");
        }
    }
    CancelValue();
}

function isValidAscii(val)
{
	if('VIETTEL' == CfgMode.toUpperCase() || 'VIETTEL2' == CfgMode.toUpperCase())
	{    
		for ( var i = 0 ; i < val.length ; i++ )
		{
			var ch = val.charAt(i);
			if ( ch < ' ' || ch > '~' )
			{
				return false;
			}
		}
	}
	else
	{
		for ( var i = 0 ; i < val.length ; i++ )
		{
			var ch = val.charAt(i);
			if ( ch <= ' ' || ch > '~' )
			{
				return false;
			}
		}
	}
    return true;
}

function isValidUserName(val)
{
    if (!isValidAscii(val)) {
        return false;
    }
    return true;
}

function CheckParaWeak()
{
    var newPassword = document.getElementById("newPassword").value;
	if (newPassword.length > 32)
	{
		AlertEx("The password must contain at most 32 characters.");
		return false;
	}
    
    if (newPassword.length < PwdMinLen)
    {
        if (CfgMode.toUpperCase() == 'VIETTEL2') {
            AlertEx("The password must contain at least 6 characters.");
        } else {
            AlertEx("The password must contain at least 8 characters.");
        }
        return false;
    }
        
    if (newPassword.charAt(0) == " " || newPassword.charAt(newPassword.length-1) == " ")
    {
        AlertEx("The password must not include the space character at the beginning of the key or at the end.");
        return false;
    }
    
    for(var i = 0; i <= newPassword.length-2; i++)
    {
        if(newPassword.charAt(i) == " " && newPassword.charAt(i+1) == " ")
        {
           AlertEx("The password can not have several consecutive spaces.");
            return false;        
        }
    }
    return true;
}

function CheckPwdIsComplexForViettel8045A2(str)
{
    if ( 8 >= str.length )
    {
        return false;
    }
    if ( !isLowercaseInString(str) )
    {
       return false;
    }
    if ( !isUppercaseInString(str) )
    {
        return false;
    }
    if ( !isDigitInString(str) )
    {
        return false;
    }
	if ( !isSpecialCharacterNoSpace(str) )
    {
         return false;
    }

	return true
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

function dbaa1NeedModifyUserName()
{
    if (DBAA1 == '1') {
        if (curUserType != dbaa1SuperAdminUserType) {
            return false;
        }
        return CurUserBuf[getValue("WebUserList") - 1] != curUserName;
    }
    return false;
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
function CheckUserName()
{
    var newWebUserName = document.getElementById("newWebUserName");

    if (isValidUserName(newWebUserName.value)) {
            setDisable('MdyUserNameApply', 1);
            setDisable('MdyUserNamecancel', 1);
            return true;
        }
        AlertEx(GetLanguageDesc("s0f10b"));
        return false;
}
function CheckParameter()
{
    var newPassword = document.getElementById("newPassword");
    var cfmPassword = document.getElementById("cfmPassword");
    var newUserName = document.getElementById("newUserName");
    var oldPassword = document.getElementById("oldPasswordDEFHIDE");

    if (dbaa1NeedModifyUserName()) {
        if (newUserName.value == "") {
            AlertEx(GetLanguageDesc("s0f10"));
            return false;
        }
        for (var i = 0; i < stModifyUserInfos.length - 1; i++) {
            var userItem = stModifyUserInfos[i];
            if (userItem == null) {
                continue;
            }
            if (userItem.UserName == sptUserName) {
                continue;
            }
            if (newUserName.value == userItem.UserName) {
                AlertEx(GetLanguageDesc("s0f10a"));
                return false;
            }
        }
    }

    if (newPassword.value == "") {
        AlertEx(GetLanguageDesc("s0f02"));
        return false;
    }

    if (newPassword.value.length > 127) {
        AlertEx(GetLanguageDesc("s1904"));
        return false;
    }

    if ((CfgMode.toUpperCase() == "TURKSATEBG3")) {
        if (newPassword.value.length < 8) {
            AlertEx(GetLanguageDesc("ss2011a"));
            return false;
        }
    }
    
    if (!isValidAscii(newPassword.value)) {
        if (PwdType == 3) {
            AlertEx(GetLanguageDesc("s0f04a"));
            return true;
        } else {
            AlertEx(GetLanguageDesc("s0f04"));
            return false;
        }
    }

    if (cfmPassword.value != newPassword.value) {
        AlertEx(GetLanguageDesc("s0f06"));
        return false;
    }

    if (CheckPwdInWeakPwdList(newPassword.value)) {
        AlertEx(GetLanguageDesc("s0f06a"));
        return false;
    }

    var checkPwdUrl = "../common/CheckAdminPwd.asp?&1=1";
    if ((DBAA1 == 1) || (CfgMode.toUpperCase() == "RDSAP") || (isMultiAdminUser == 1) || (ttnet == 1)) {
        checkPwdUrl = "../common/CheckOldPwd.asp?&1=1";
    }
    
    if (ShowOldPwd == 1) {
        if (oldPassword.value == "") {
            AlertEx(GetLanguageDesc("s0f0f"));
            return false;
        }
        var NormalPwdInfo = FormatUrlEncode(oldPassword.value);
        var CheckResult = 0;
        $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : checkPwdUrl,
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
    }

    if (PwdType == 3) {
        var WeakRst = CheckParaWeak();
        if (WeakRst == false) {
            return false;
        }
    } else if (PwdType == 4) {
        var WeakRst = CheckPwdIsComplexForRosunion(newPassword.value);
        if (WeakRst == false) {
            return false;
        }
    }

    if ((CfgMode.toUpperCase() == 'PLDT') || (CfgMode.toUpperCase() == 'PLDT2')) {
        if (!CheckPwdIsComplexForPldt(newPassword.value)) {
            AlertEx(GetLanguageDesc("s1902"));
            return false;
        }
    }

    if ((CfgMode.toUpperCase() == "DTTNET2WIFI") || (CfgMode.toUpperCase() == "TTNET2")) {
        if (!TtnetComplex(oldPassword.value, newPassword.value)) {
            return false;
        }
    }

	if (IsViettel8045A2Flag==1)
	{
		if (!CheckPwdIsComplexForViettel8045A2(newPassword.value))
		{
			var confirmVal = confirm("Weak password! Do you want to continue? \n(strong password must be more than 8 characters,using combination of uppercase and lower case and number and special characters)");
			if(confirmVal){
				return true;
			}
			else{
				return false;
			}
		}
	}
	
	if(!CheckPwdIsComplex(newPassword.value)&&(IsViettel8045A2Flag!=1)&&(PwdType!=4))
	{
        if (CfgMode.toUpperCase() == "EGVDF2") {
            AlertEx(GetLanguageDesc("s1116m"));
            return false;
        }

        if(PwdType == 3)
        {
            var confirmVal = confirm(GetLanguageDesc("s1902a"));
            if(confirmVal){
                return true;
            }
            else{
                return false;
            }    
        }
        else
        {
            AlertEx(GetLanguageDesc("s1902"));    
            return false;
            
        }
        
    }

    if (CfgMode.toUpperCase() == "VIETTELAP") {
        if (!CheckPwdIsComplexForViettel8045A2(newPassword.value)) {
            var confirmVal = confirm("Weak password! Do you want to continue? \n(strong password must be more than 8 characters, using combination of uppercase and lowercase and number and special characters)");
            if (confirmVal) {
                return true;
            } else {
                return false;
            }
        }
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

function getInstIdbyUserName(username)
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

function getDomainbyInstId(instId)
{
    var dominValue = "";
    for (var i = 0; i < stModifyUserInfos.length; i++) {
        var temp = stModifyUserInfos[i].domain.split(".");
        var index = temp[temp.length - 1];
        if (index == instId) {
            dominValue = stModifyUserInfos[i].domain;
            break;
        }
    }
    return dominValue;
}

function getUserLevelbyInstId(instId)
{
    var level = null;
    for (var i = 0; i < stModifyUserInfos.length; i++) {
        var temp = stModifyUserInfos[i].domain.split(".");
        var index = temp[temp.length - 1];
        if (index == instId) {
            level = stModifyUserInfos[i].UserLevel;
            break;
        }
    }
    return level;
}

function SubmitPwd()
{
    if ((CfgMode.toUpperCase() == 'COCLAROEBG4') && (curUserInfoStatus == "2")) {
        return false;
    }

    if (!CheckParameter() || UpdateFlag == 1)
    {
        return false;
    }

	var InstNo = 1;

    if (MultiUser == 1) {
        if (resetUserPwdFlag == "1") {
            InstNo = 2
        } else {
            InstNo = getValue('WebUserList');
            if (IsSYNCSGP210WAdmin()) {
                if (curUserType == "0") {
                    InstNo = 2;
                }
            }
        }
    }

	InstNo = CurUserInst[InstNo - 1];	
	var parainfo="";
    if (ShowOldPwd == 1) {
        parainfo='x.OldPassword=' + FormatUrlEncode(getValue('oldPasswordDEFHIDE')) + "&";
    }
    var dbaa1IsModifingUserName = dbaa1NeedModifyUserName();
    var newUserName = FormatUrlEncode(getValue('newUserName'));
    if (dbaa1IsModifingUserName) {
        parainfo='x.UserName=' + newUserName + "&";
    }
    parainfo +='x.Password=' + FormatUrlEncode(getValue('newPassword')) + "&";
    parainfo +='x.X_HW_Token=' + getValue('onttoken');
    var dataDomain = "";
    if ((MultiUser == 1) && (ttnet == '1')) {
        dataDomain = getDomainbyInstId(getValue('WebUserList'));
    } else {
        dataDomain = stModifyUserInfos[InstNo].domain;
    }
    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : parainfo,
         url : "setajax.cgi?x=" + dataDomain + "&RequestFile=html/ssmp/accoutcfg/accountadmin.asp",
         success : function(data) {
                var ResultInfo = JSON.parse(hexDecode(data));
                if (ResultInfo.result == 0) {
                    if (Ftmodifyadmin == 1) {
                        if ((webPwdChange == 1) && ((isMultiAdminUser != 1)  && (getValue('WebUserList') == 2) || ((isMultiAdminUser == 1) && (CurUserBuf[getValue('WebUserList') - 1] == curUserName)))) {
                            if ((webPwdChange == 1) && (getValue('WebUserList') == 2)) {
                                AlertEx(GetLanguageDesc("s0f0e0"));
                            } else {
                                AlertEx(GetLanguageDesc("s0f0e"));
                            }
                        } else {
                            if (webPwdChange == 1) {
                                AlertEx(GetLanguageDesc("s0f0e0"));
                            } else {
                                AlertEx(GetLanguageDesc("s0f0e"));
                            }
                        }
                    } else {
                        AlertEx(GetLanguageDesc("s0f01"));
                    }
                    CancelValue();
                    if (dbaa1IsModifingUserName) {
                        onDbaa1UserNameModified(InstNo, newUserName);
                    }
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

function SubmitUserName()
{
    if ((!CheckUserName()) || (UpdateFlag == 1)) {
        return false;
    }
    var parainfo = 'x.UserName=' +  FormatUrlEncode(getValue('newWebUserName')) + "&";
    parainfo += 'x.X_HW_Token=' + getValue('onttoken');
    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : parainfo,
         url : "setajax.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.2"+ "&RequestFile=html/ssmp/accoutcfg/accountadmin.asp",
         success : function(data) {
                var ResultInfo = JSON.parse(hexDecode(data));
                if (ResultInfo.result == 0) {
                    AlertEx(GetLanguageDesc("s0f0g"));
                    CancelUserNameValue();
                } else {
                    AlertEx(GetLanguageDesc("s220e"));
                }
            },
            complete : function (XHR, TS) {
            XHR = null;
            setDisable('MdyUserNameApply', 0);
            setDisable('MdyUserNamecancel', 0);
         }
        });
}

function GetLanguageDesc(Name)
{
    return AccountLgeDes[Name];
}

function CancelValue()
{
    setText('newPassword','');
    setText('cfmPassword','');
    setText('oldPasswordDEFHIDE','');
    if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag || 1 ==  PwdTipsFlag)
    {
        $("#checkinfo1Row").css("display", "none");
        $("#psd_checkpwd").css("display", "none");
    }
}

function CancelUserNameValue()
{
    setText('newWebUserName', '');
}
function InitSslCfgBox()
{
    if ( null != SSLConfig )
    {
        setCheck('WebCertificateEnable', SSLConfig.Enable);
    }
}

function fchange() {
    var ffile = document.getElementById("f_file");
    var tfile = document.getElementById("t_file");
    ffile.value = tfile.value;

    var buttonstart = document.getElementById('ImportCertification');
    buttonstart.focus();
}
function GetLanguageDesc(Name)
{
    return AccountLgeDes[Name];
}


function CheckNoticeForSSL(){

	var password1 = getElementById("WebcertPassword").value;
	
	if(password1.length == 0){
		return;
	}
	
	if(CheckPwdIsComplexWithSpace(password1) == false)
	{
		AlertEx(GetLanguageDesc("s1902"));
		return false;
	}
	
	return true;
}

function CheckPwdNotice()
{
    var password1 = getElementById("newPassword").value;
    var password2 = getElementById("oldPasswordDEFHIDE").value;

    if(password1.length == 0){
        return;
    }

    if ((CfgMode.toUpperCase() == "DTTNET2WIFI") || (CfgMode.toUpperCase() == "TTNET2")) {
        if (!TtnetComplex(password2, password1)) {
            return;
        }
        return;
    }

	if (PwdType == 4)
	{
		if (CheckPwdIsComplexForRosunion(password1) == false)
		{
			AlertEx(GetLanguageDesc("s1902"));    
			return false;
		}
	}
	else if(!CheckPwdIsComplex(password1)&&(IsViettel8045A2Flag!=1))
	{
        if (CfgMode.toUpperCase() == "EGVDF2") {
            AlertEx(GetLanguageDesc("s1116m"));
            return false;
        }

        if(PwdType == 3)
        {
            var confirmVal = confirm(GetLanguageDesc("s1902a"));
            if(confirmVal){
                return;
            }
            else{
				setText('newPassword','');
                return;
            }    
        }
        else
        {
            AlertEx(GetLanguageDesc("s1902"));    
            return false;
            
        }
        
    }
	
	return;
}

function ViettelCheckComplexMatch(lengthmatch, totalscore) {
    if ((lengthmatch == 0) || (totalscore < 2)) {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1448');
        getElementById("pwdvalue1").style.width=18+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FF0000";
        getElementById("pwdvalue1").style.float="left";
        getElementById("pwdvalue1").style.display="block";
        return;
    }

    if ((lengthmatch >= 1) && (totalscore >= 2)) {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1449');
        getElementById("pwdvalue1").style.width=49.8+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #FFA500";
    }

    if ((lengthmatch == 2) && (totalscore > 3)) {
        getElementById("pwdvalue1").innerHTML=GetLanguageDesc('s1450');
        getElementById("pwdvalue1").style.width=100+"%";
        getElementById("pwdvalue1").style.borderBottom="4px solid #008000";
        return;
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
    var vietteltotal = 0;
    var password1 = getElementById("newPassword").value;
	var DestPwdLen = PwdMinLen;
	
	if ((((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) && (curUserType == sysUserType)) || (CfgMode.toUpperCase() == "ROMANIADT2")) {
		DestPwdLen = 8;
	}

    if(password1.length >= DestPwdLen) {
		lengthmatch = 1;
		score++;
	}

	if (CfgMode.toUpperCase() == "VIETTELAP") {
		if (password1.length >= 8) {
			lengthmatch = 2;
			score++;
		}
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
    vietteltotal = lowerCharmatch + upCharmatch + NumCharmatch + specialCharmatch;

    if (CfgMode.toUpperCase() == "VIETTELAP") {
        ViettelCheckComplexMatch(lengthmatch, vietteltotal);
    }
	
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

function stCertificate(domain, enable, notBefore, notAfter, usage)
{
    this.domain = domain;
    this.enable = enable;
    this.notBefore = notBefore;
    this.notAfter = notAfter;
    this.usage = usage;
}

var certificateArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DataModel.Security.Certificate.{i}, Enable|NotBefore|NotAfter|X_HW_Usage, stCertificate);%>;

var isTimeSynced = '<%IsTimeSynced();%>';
var hgUtcTime = '<%GetUtcTime();%>';

function calculateValidDays(notBefore, notAfter)
{
    var now = new Date(hgUtcTime); 
    if (isTimeSynced == '0') {
        now = new Date().getTime();
    }

    var certStart = new Date(notBefore);
    if (certStart > now) {
        return NaN;
    }
    
    var certEnd = new Date(notAfter);
    if (certEnd < now) {
        return 0;
    }
    
    var DAY = 24 * 60 * 60 * 1000;
    var lastDays = (certEnd - now) / DAY;
    return Math.floor(lastDays + 0.5);
}

function DisplayCertificateItems(certificateArray)
{
    var result = "";
    
    if (certificateArray == null || certificateArray.length == 0) {
        result = "<tr class='tabal_01 align_center'>";
        result += "<td>--</td>";
        result += "<td>--</td>";
        result += "<td>--</td>";
        result += "<td>--</td>";
        result += "<td>--</td>";
        result += "</tr>"
        
        $("#tabel_certificate_info_detail").append(result);
        return;                
    }

    for (var i = 0; i < (certificateArray.length - 1); i++) {
        if (i % 2 == 0) {
            result += "<tr class='tabal_01 align_center'>";
        } else {
            result += "<tr class='tabal_02 align_center'>";
        }
        result += "<td>" + (i + 1) + "</td>";
        
        if (certificateArray[i].enable) {
            result += "<td>" + GetStringContent("true", 6) + "</td>";  
        } else {
            result += "<td>" + GetStringContent("false", 6) + "</td>";  
        }
        
        result += "<td>" + GetStringContent(htmlencode(certificateArray[i].usage), 18) + "</td>";
        result += "<td>" + GetStringContent(htmlencode(certificateArray[i].notBefore), 24) + "</td>";
        result += "<td>" + GetStringContent(htmlencode(certificateArray[i].notAfter), 24) + "</td>";
        
        var days = calculateValidDays(certificateArray[i].notBefore, certificateArray[i].notAfter);
        var certAlarmThreshold = 90;
        if (days >= certAlarmThreshold) { 
            result += "<td>" + days + "</td>";
        } else {
            result += "<td>" + "<font color='#FF0000'>" + days + "</font>" +  "</td>";
        }

        result += "</tr>";
    }
    
    $("#tabel_certificate_info_detail").append(result);
}

function ResetPwd()
{
    if (ConfirmEx(GetLanguageDesc("s2701")) == false) {
        return;
    }

    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : 'resetuserpwd.cgi?RequestFile=html/ssmp/accoutcfg/accountadmin.asp',
        data : 'x.X_HW_Token=' + getValue('onttoken'),
        success : function(data) {
            var ResultInfo = JSON.parse(hexDecode(data));
            if (ResultInfo.Result == 0) {
                AlertEx(GetLanguageDesc("s2703"));
            } else {
                AlertEx(GetLanguageDesc("s2704"));
            }
        }
    });

    return;
}

</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();">
    <script language="JavaScript" type="text/javascript">    
    if(1 == IsSurportWebsslPage && 1 == Ftmodifyadmin)    
    {
            var s0f1a;
            if('TALKTALK2WIFI' == CfgMode.toUpperCase()) {
                s0f1a = "s0f13a";
            } else if(CfgMode.toUpperCase() == 'COMMON') {
                s0f1a = "s0100a";
            } else if (IsSYNCSGP210WAdmin()) {
                s0f1a = "s0f12asgp210w";
            } else {
                s0f1a = "s0f12a";
            }
            HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, s0f1a), false);
    }
    else if(1 == IsSurportWebsslPage && 0 == Ftmodifyadmin)
    {
        HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0100"), false);
    }
    else if(0 == IsSurportWebsslPage && 1 == Ftmodifyadmin)
    {
		var s0f12 = "s0f12";
		if(UpdateFlag == 1)
		{
			s0f12 = "s0f12ap";
		}
        HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, s0f12), false);
    }
    else
    {
        HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0f07"), false);
    }
        
    </script>
	<label id="HilinkTips"></label>
    <div class="title_spread"></div>
    <div class="func_title" BindText="s0101"></div>
    <script>
        if ((CfgMode.toUpperCase() == "TTNET2") || (pwdChangeNoticeFlag == 1)) {
            document.write('<table id="tabledefaultpwdnotice" width="100%" border="0" cellpadding="0" cellspacing="0" style="display:none;"><tr><td id="defaultpwdnotice"></td></tr></table>');
        }
    </script>
    <table width="100%" border="0" cellpadding="0" cellspacing="1">
        <tr id="secUsername">
            <td class="width_per40 width_per48">
                <form id="PwdChangeCfgForm"  name="PwdChangeCfgForm" style="display:none;">
                    <table id="PwdChangeCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF">
                        <script>
                            if ((Is8011_21V5 == 1) && (CfgMode.toUpperCase() != "LATVIATETAP")) {
                                document.write("");
                            } else {
                                document.write("\<li id=\"WebUserName\" RealType=\"HtmlText\" DescRef=\"s0f08\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"WebUserName\" InitValue=\"Empty\"\/\>");
                            }
                        </script>
                        <li id="newUserName" RealType="TextBox"  DescRef="s0f08" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.UserName"  InitValue="Empty"/>
                        <li id="oldPasswordDEFHIDE" RealType="TextBox"  DescRef="s0f13" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.oldPassword"  InitValue="Empty"/>
                        <script>
                        if (SupportTtnet()) {
                            document.write('<li id="newPassword" RealType="TextBoxNP" DescRef="s0f09" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Password" InitValue="Empty" onKeyUp="psdStrength()"/>');
                            document.write('<li id="cfmPassword" RealType="TextBoxNP" DescRef="s0f0b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>');
                        } else if (CfgMode.toUpperCase() == "EGVDF2") {
                            document.write('<li id="newPassword" RealType="TextBox" DescRef="s0f09" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Password" InitValue="Empty" onKeyUp="vdfPwdStrength()"/>');
                            document.write('<li id="vdfPwdStrength" RealType="HtmlText" DescRef="s1447" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;" />');
                            document.write('<li id="cfmPassword" RealType="TextBox" DescRef="s0f0b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>');
                        } else {
                            document.write('<li id="newPassword" RealType="TextBox" DescRef="s0f09" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Password" InitValue="Empty" onKeyUp="psdStrength()"/>');
                            document.write('<li id="cfmPassword" RealType="TextBox" DescRef="s0f0b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>');
                        }
                        </script>
                        <!--密码强度-->
                        <li id="checkinfo1" RealType="HtmlText"  DescRef="s1447" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;" />
                        <!-- 密码强度-->
                    </table>                    
                    <script>
                        var PwdChangeCfgFormList = new Array();
                        PwdChangeCfgFormList = HWGetLiIdListByForm("PwdChangeCfgForm", null);
                        var TableClass = new stTableClass("width_per60", "width_per43");
                        HWParsePageControlByID("PwdChangeCfgForm", TableClass, AccountLgeDes, null);
                        if ((resetUserPwdFlag == "1") && ((curUserName == sptAdminName) || (isOltVisualUser))) {
                            var PwdChangeArray = new Array();
                            PwdChangeArray["WebUserName"] = sptAdminName;
                            HWSetTableByLiIdList(PwdChangeCfgFormList, PwdChangeArray, null);
                            ShowOldPwd = 1;
                            document.getElementById('oldPasswordDEFHIDERow').style.display = "";
                        } else if (IsSYNCSGP210WAdmin()){
                            var PwdChangeArray = new Array();
                            PwdChangeArray["WebUserName"] = curUserName;
                            HWSetTableByLiIdList(PwdChangeCfgFormList, PwdChangeArray, null);
                            ShowOldPwd = 1;
                            setDisplay("WebUserNameRow", 0);
                            document.getElementById('oldPasswordDEFHIDERow').style.display = "";
                         } else if (MultiUser == 1) {
                            WriteUserListOption("WebUserName");
                        }
                        else
                        {
                            var PwdChangeArray = new Array();
                            if(Is8011_21V5 == 1) {
                                PwdChangeArray["WebUserName"] = "";
                            } else {
                                PwdChangeArray["WebUserName"] = sptUserName;
                            }
                            HWSetTableByLiIdList(PwdChangeCfgFormList, PwdChangeArray, null);
                        }
                        if (CfgMode.toUpperCase() == "EGVDF2") {
                            $('#newPassword').bind('keyup',function(){
                                $("#vdfPwdStrengthRow").css("display", "");
                                $("#psd_checkpwdvdf").css("display", "block");
                                vdfPwdStrength("newPassword");
                            });
                        } else {
                            $('#newPassword').bind('keyup',function(){
                                if ((cmccApFlag != 1) && (("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag || 1 == PwdTipsFlag)) {
                                    $("#checkinfo1Row").css("display", "");
                                    $("#psd_checkpwd").css("display", "block");
                                    psdStrength();
                                }
                            });
                            $('#newPassword').blur(function()
                            {
                                CheckPwdNotice();
                            });
                        }

                        setDisplay("newUserNameRow", 0);
                    </script>
                </form>
            </td>
            <td class="tabal_pwd_notice width_per60 width_per43_act" id="PwdNotice"></td>
        </tr>
                    
    </table>

    <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button" style="display:none;" id="tableButton">
        <tr>
            <td class="table_submit width_per25"></td>
            <td class="table_submit">
                <input type="button" id="MdyPwdApply"  name="MdyPwdApply"  class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitPwd();"    BindText="s0f0c" />
                <input type="button" id="MdyPwdcancel" name="MdyPwdcancel" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();"  BindText="s0f0d" />
            </td>
        </tr>
    </table>

    <div id="resetUserPwd" style="display:none;">
        <div class="title_spread"></div>
        <div class="func_title" BindText="s2702"></div>
        <table id="resetUserPwdTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
            <tr >
                <td class="table_submit width_per1" ></td> 
                <script>
                    var buttonwidth = 'buttonwidth_150px_250px';
                    if (curLanguage == 'portuguese') {
                        buttonwidth = 'buttonwidth_150px_300px';
                    }
                    document.write("<td class='table_submit width_per99'><button id='resetUserPwdButton' name='resetUserPwdButton' type='button' class='ApplyButtoncss " + buttonwidth + "' BindText='s2702' onclick='ResetPwd();'></button></td> ");
                </script>
            </tr>
        </table>
    </div>

    <div id="modifyUsername" style="display:none;">
        <div class="title_spread"></div>
        <div class="func_title" BindText="s2823"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="1">
        <tr id="modifyUsername">
            <td class="width_per40 width_per48">
                <form id="UserNameChangeCfgForm"  name="UserNameChangeCfgForm">
                    <table id="UserNameChangeCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF">
                        <script>
                            document.write("\<li id=\"oldWebUserName\" RealType=\"HtmlText\" DescRef=\"s0f08\" RemarkRef=\"Empty\" ErrorMsgRef=\"Empty\" Require=\"FALSE\" BindField=\"WebUserName\" InitValue=\"Empty\"\/\>");
                            document.write('<li id="newWebUserName" RealType="TextBoxNP" DescRef="s2825" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=" x.UserName" InitValue="Empty" onKeyUp="psdStrength()"/>');
                        </script>
                    </table>
                    <script >
                        var UserNameChangeCfgFormList = new Array();
                        UserNameChangeCfgFormList = HWGetLiIdListByForm("UserNameChangeCfgForm", null);
                        var TableClass = new stTableClass("width_per60", "width_per43");
                        HWParsePageControlByID("UserNameChangeCfgForm", TableClass, AccountLgeDes, null);
                        var  UserNameChangeArray = new Array();
                        UserNameChangeArray["WebUserName"] = curUserName;
                        HWSetTableByLiIdList(UserNameChangeCfgFormList, UserNameChangeArray, null);
                        setDisplay("oldWebUserNameRow", 1);
                        document.getElementById('newWebUserName').disabled = 0;
                    </script>
                </form>
            </td>
            <td class="tabal_pwd_notice width_per60 width_per43_act" id="UserNameNotice"></td>
        </tr>
    </table>

        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
            <tr>
                <td class="table_submit width_per25"></td>
                <td class="table_submit">
                    <input type="button" id="MdyUserNameApply"  name="MdyUserNameApply"  class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitUserName();"    BindText="s0f0c" />
                    <input type="button" id="MdyUserNamecancel" name="MdyUserNamecancel" class="CancleButtonCss buttonwidth_100px" onClick="CancelUserNameValue();"  BindText="s0f0d" />
                </td>
            </tr>
        </table>
    </div>

    <div id="websslpage" style="display:none;">
    <div class="func_spread"></div>
        <div id="wssl" class="func_title" BindText="s0d23" style="display:none;"></div>
        <div id="yssl" class="func_ssl"  BindText="s0e23" style="display:none;"></div>
        <form id="WebcertCfgForm">
            <table id="WebcertCfgFormPanel" width="100%" cellspacing="1" cellpadding="0">
                <li   id="WebCertificateEnable"   RealType="CheckDivBox"   DescRef="s0d25"    RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.Enable"
                InitValue="[{Item:[{AttrName:'id', AttrValue:'title_show'},{AttrName:'style', AttrValue:'position:absolute; display:none; line-height:16px; width:310px; border:solid 1px #999999; background:#edeef0;'}]}]" ClickFuncApp="onClick=SetCertificateInfo"/>
                <li   id="WebcertPassword"   RealType="TextBox"    DescRef="s0d26"    RemarkRef="s1905"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.CertPassword"
                 ClickFuncApp="onmouseover=title_show;onmouseout=title_back"/>
                <li   id="WebCfmPassword"   RealType="TextBox"    DescRef="s0d28"    RemarkRef="s1905"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="CfmPassword"  InitValue="Empty"/>
            </table>        
            <script>
                var WebcertCfgFormList = new Array();
                WebcertCfgFormList = HWGetLiIdListByForm("WebcertCfgForm", null);
                var TableClass = new stTableClass("width_per20", "width_per80", "");
                HWParsePageControlByID("WebcertCfgForm", TableClass, AccountLgeDes, null);
                InitSslCfgBox();
            </script>
            <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
                <tr>
                    <td class="width_per25"></td>
                    <td class="table_submit">
                        <input type="button" id="PWDbtnApply"    name="PWDbtnApply"    class="ApplyButtoncss buttonwidth_100px"  BindText="s0d21" onClick="AddSubmitImportcert();">
                        <input type="button" id="PWDcancelValue" name="PWDcancelValue" class="CancleButtonCss buttonwidth_100px" BindText="s0d22" onClick="CancelConfigPwd();">
                    </td>
                </tr>
            </table>        
        </form>
        <div class="func_spread"></div>
        <form action="websslcert.cgi?RequestFile=html/ssmp/accoutcfg/accountadmin.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage">
            <div>
                <div id="wssll" class="func_title" BindText="s0d29" style="display:none;"></div>
                <div id="yssll" class="func_ssl" BindText="s0e29" style="display:none;"></div>
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
                                    <script>
                                        if (CfgMode.toUpperCase() == "DINFOTEK2") {
                                            document.getElementById("btnBrowse").style.backgroundColor = "#0cb433";
                                        }
                                    </script>
                                </div>
                            </div>
                        </td>
                        <td>
                            <script>
                                if (CfgMode == "DICELANDVDF") {
                                    document.write('<input class="ApplyButtoncss  filebuttonwidth_100px" id="ImportCertification" name="btnSubmit" type="button" onclick="uploadCert();"" BindText="s0d2c" />')
                                } else {
                                    document.write('<input class="CancleButtonCss filebuttonwidth_100px" id="ImportCertification" name="btnSubmit" type="button" onclick="uploadCert();"" BindText="s0d2c" />')
                                }
                            </script>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <div class="func_spread"></div>
    </div>
    <script>
		$('#WebcertPassword').blur(function()
		{
			CheckNoticeForSSL();
		});
		
        var ele = document.getElementById("divTablePwdChangeCfgForm");
        ele.setAttribute('class', '');

        ele = document.getElementById("WebcertPassword");
        ele.setAttribute('title', '');

        ele = document.getElementById("WebCfmPassword");
        ele.setAttribute('title', '');

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
        ParseBindTextByTagName(AccountLgeDes, "button", 1);

        if (CfgMode.toUpperCase() == "DNZVDF2WIFI") {
            setDisplay('WebUserNameRow', 0);
            OnSelectedUserChanged(CurUserBuf.indexOf(sptAdminName) + 1);
        }
    </script>
    <div id="div_security_certificate_expiration" style="display:none;">
    <div class="func_spread"></div>
    <div id="div_certificate_info" style="overflow:auto;overflow-y:hidden">
        <div id="div_certificate_info_title" class="func_title" BindText="s2601" ></div>

        <table id="tabel_certificate_info_detail" class='width_per100 tabal_bg' border="0" align="center" cellpadding="0" cellspacing="1" > 
            <tr class="head_title"> 
                <td class="restrict_dir_ltr" BindText = 's2602'></td> 
                <td BindText = 's2603'></td> 
                <td BindText = 's2604'></td> 
                <td BindText = 's2605'></td> 
                <td BindText = 's2606'></td>
                <td BindText = 's2607'></td>  
            </tr>

            <script language="JavaScript" type="text/javascript">
                DisplayCertificateItems(certificateArray);
                ParseBindTextByTagName(AccountLgeDes, "div", 1);
                ParseBindTextByTagName(AccountLgeDes, "td", 1);
                if (rosunionGame == "1") {
                    $("#PwdNotice").addClass("gray");
                }
            </script>
        </table>
    </div>
    </div>
</body>
</html>
