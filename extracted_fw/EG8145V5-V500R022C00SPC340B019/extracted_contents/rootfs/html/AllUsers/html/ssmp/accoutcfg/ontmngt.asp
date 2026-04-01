<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(indexclick.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
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
#testTips{
	height: 60px;
    line-height: 60px;
}
.divLabal{
    float: left;
    font-size: 14px;
    font-family: "Trebuchet MS", Helvetica, sans-serif;
    color: rgb(102, 102, 102);
    height: 60px;
    line-height: 60px;
    width: 30%;
    text-align: left;
}
.pwdTips{
    float: left;
    font-size: 14px;
    height: 60px;
    line-height: 60px;
    color: #333333;
    font-family: "Trebuchet MS", Helvetica, sans-serif;
    height: 30px;
    width: 60%;

}

.ChooseBRButtonCss {
	width:200px;
	padding-top:10px;
}

.ChhooseFileAreaCss {
	height:50px;
}

.BRRestoreSpanCss {
	padding-left:20px;
}

</style>
<script language="JavaScript" type="text/javascript">
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

var sptUserName = '';
var sptInstantNo = 1;
var UserInfo = '<%HW_WEB_GetUserName(stNormalUserInfo);%>';
if (UserInfo !== '') {
    UserInfo = dealDataWithStr(UserInfo);
    sptUserName = UserInfo[0].UserName;
    sptInstantNo = UserInfo[0].InstantNo;
}

var PwdModifyFlag = 0;
var sysUserType = '0';
var sysMaxisNormalUserType = '2';
var sysMaxisLocalUserType = '1';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var isGlobe = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_GLOBE);%>';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var AlarmPwdType = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>';
var ModifyPwdType = '<%HW_WEB_GetFeatureSupport(HW_SSMP_WEB_MODIFY_AMDIN_PWD);%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var WebAdminReset = '<%HW_WEB_GetFeatureSupport(HW_FT_WEB_RESET_CFG_ADMIN);%>';

var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var XDProductType = '2';
var PwdTipsFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_PWD_TIPS);%>';
var clisynFlag = '<%HW_WEB_GetFeatureSupport(HW_FT_CLI_WEB_PASSWORD_SYN);%>';
var cliadminsynFlag = '<%HW_WEB_GetFeatureSupport(HW_FT_CLI_WEB_PASSWORD_AUTH_IG);%>';
var IsSupportIot = '<%HW_WEB_GetIotStatus();%>';
var IsSupportRb = '<%IsSupportRestore();%>';
var anteltype = '<%HW_WEB_GetFeatureSupport(FT_NORMAL_USER_NOGUIGE);%>';
var webPwdChange = '<%HW_WEB_GetFeatureSupport(FT_SSMP_KICKOFF_WEB_USER);%>';
var DBAA1= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
var isMegacableFlag = '<%HW_WEB_GetFeatureSupport(FT_WEB_CUSTOMIZE_FORMC);%>';
var checkWeakPwdFlag  = '<%HW_WEB_GetFeatureSupport(FT_WEB_CHECK_WEAKPWD);%>';
var supportDSL = '<%HW_WEB_GetFeatureSupport(HW_FT_DSL_SURPPORT);%>';
var isSupportCut = '<%HW_WEB_GetFeatureSupport(FT_WEB_MAINPAGE_CUT);%>';
var curUserName = '';
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
var totalplay = '<%HW_WEB_GetFeatureSupport(FT_SSMP_TOTALPLAY);%>';
var curUserInfoStatus = '<%WEB_GetUserInfoStatus();%>';
var isMultiAdminUser = '<%HW_WEB_GetFeatureSupport(FT_WEB_SUPPORT_MULTI_ADMINGUIDE);%>';
var ttnet = '<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>';

if ((CfgMode.toUpperCase() == 'DETHMAXIS') && (curUserType == sysMaxisNormalUserType) || (totalplay == '1') ||
    ((isMultiAdminUser == 1) && (curUserType == sysUserType))) {
	UserInfo = <%HW_WEB_GetNormalUserInfo(stNormalUserInfo);%>;
	sptUserName = UserInfo[0].UserName;
	sptInstantNo = UserInfo[0].InstantNo;
}

function stUserInfo(domain,UserName,UserLevel)
{
    this.domain = domain;
    this.UserName = UserName;
    this.UserLevel = UserLevel;
}

var stUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName|UserLevel, stUserInfo);%>;
for (var i = 0; i < stUserInfos.length - 1; i++) {
    if (stUserInfos[i].UserLevel == curUserType) {
        curUserName = stUserInfos[i].UserName;
    }
}

function SupportTtnet()
{
    return (CfgMode.toUpperCase() == "DTTNET2WIFI" || CfgMode.toUpperCase() == "TTNET2");
}

if (ProductType == '3')
{
	var UpdateState = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.SMP.ShowSwUpdateState.SwUpdateState);%>';
}

if("undefined" == AlarmPwdType || 0 == AlarmPwdType)
{
	AlarmPwdType = 6;
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
	if (((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) && curUserType == sysUserType)
	{
        if (str.length < AlarmPwdType)
		{
			return false;
		}
	}
	
	if ( AlarmPwdType > str.length )
	{
		return false;
	}

	if (!CompareString(str,sptUserName) )
	{
		return false;
	}

    if (CfgMode.toUpperCase() == "EGVDF2") {
        return CheckPwdIsComplexForEgvdf(str);
    }

	if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2"))
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

	if ( isSpecialCharacterNoSpace(str) )
	{
		i++;
	}
	
	if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2") || (CfgMode.toUpperCase() == "OTE"))
	{
		if ( i >= 3 )
		{
			return true;
		}
	}
	else
	{
		if ( i >= 2 )
		{
			return true;
		}
	}

	
	return false;
}

function DelayedProcessing()
{
    if ((window.location.href.indexOf("set.cgi?") > 0)) {
        AlertEx(GetLanguageDesc("s0f0e"));
    }
}

function getInstIDbyUserName(username)
{
    var instId = 0;
    for (var i = 0; i < stUserInfos.length; i++) {
        if (stUserInfos[i].UserName == username) {
            var temp = stUserInfos[i].domain.split(".");
            instId = temp[temp.length - 1];
            break;
        }
    }
    return instId;
}

function hideClaroReset()
{
    if ((CfgMode.toUpperCase() == "PERUCLARO") && (curUserType != sysUserType)) {
        return true;
    }
    return false;
}

function LoadFrame()
{
	if(smartlanfeature == 1)
	{
		document.getElementById('PageTitle').innerHTML = GetLanguageDesc("s1119lan");
	}

    if (CfgMode.toUpperCase() == "EGVDF2") {
        $("#checkinfo1Row").css("display", "none");
        var pwdCheck = document.getElementById('checkinfoblock');
        pwdCheck.innerHTML ='<div class="row hidden-pw-row" id="psd_checkpwdvdfserver" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center; height: 30px;" class="language-string" id="pwdvalue6"></span></div></div>';
    }

    if (SupportTtnet()) {
        $("#PwdNotice").css("display", "none");
        $("#pwdnoticeareatitle").css("display", "none");
        $("#MdyPwdApply").css("margin-left", "0px");
    }

    if (isSupportCut == "1") {
        setTimeout("DelayedProcessing()",500);
    }

	if ((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2"))
	{
		if (curUserType == sysUserType)
		{
			document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
		}
		else
		{
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

    if ((CfgMode.toUpperCase() == "EGVDF2")) {
        document.getElementById('PwdLengthAlarm').innerHTML = GetLanguageDesc("ss2011a");
        document.getElementById('PwdComplexAlarm').innerHTML = GetLanguageDesc("ss2012b");
    }

    if (CfgMode.toUpperCase() == "DNZVDF2WIFI") {
        document.getElementById("username").style.display="none";
        document.getElementById("userconfig").style.paddingTop = "25px";
    } else {
        document.getElementById("username").style.display="block";
    }

    if (ttnet == '1') {
        sptUserName = top.UserName;
    }

	if((1 == ModifyPwdType) && (curUserType == sysUserType) )
	{
		if (isMultiAdminUser != 1) {
			sptInstantNo = 2;
		}
		if (!!top.UserName)
		{
			sptUserName = top.UserName;
		}
		if (isSupportCut == "1") {
			sptUserName = curUserName;
		}
		document.getElementById('txt_Username').appendChild(document.createTextNode(sptUserName));		
		document.getElementById("olduserpwd").style.display="block";
	}
	else
	{
		document.getElementById('txt_Username').appendChild(document.createTextNode(sptUserName));
		document.getElementById("olduserpwd").style.display="none";
	}

	if((curUserType != sysUserType))
	{
		document.getElementById("olduserpwd").style.display="block";
	}

	if (UserInfo !== '') {
		PwdModifyFlag = UserInfo[0].ModifyPasswordFlag;
	}

	if((parseInt(PwdModifyFlag,10) == 0) && (curLanguage.toUpperCase() != "CHINESE") && curUserType != sysUserType)
	{
		 document.getElementById('defaultpwdnotice').innerHTML='( ' + GetLanguageDesc("s1118") + ' )';
		 $('#defaultpwdnotice').css("display", "block");
	}

    if ((parseInt(PwdModifyFlag, 10) == 0) && (CfgMode.toUpperCase() == "TTNET2")) {
        document.getElementById('defaultpwdnotice').innerHTML=GetLanguageDesc("s1118a");
        $('#defaultpwdnotice').css("display", "block");
    }

	if (PwdTipsFlag ==1)
	{
		var pwdcheck1 = document.getElementById('checkinfo1');
		pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>';
	}
	
	if(IsSupportRb == "1"){
		$('#BackupRestore').css("display", "block");
	}
	
	if(backupfilelist == ""){
		setDisable('btnRestoreBRDftCfg',1);
	}
	if ((parseInt(anteltype, 10) == 1) && (curUserType != sysUserType)) {
		$("#userinfoontmngt").css("display", "none");
    }

    if (DBAA1 == "1") {
        $("#userinfoontmngt").css("display", "none");
    }

    if (!PageTitleVisible()) {
        $("#PageTitle").css("display", "none");
    }

    if ((CfgMode.toUpperCase() == "BYTEL") || hideClaroReset()) {
        $("#userinfoontmngt").css("display", "none");
        $('#BackupRestore').css("display", "none");
    }

    if (((htFlag == "1") || (CfgMode.toUpperCase() == "OTE")) && (curUserType != "0")) {
        $("#OntRestore").css("display", "block");
        $('#BackupRestore').css("display", "none");
    }
    if ((isMegacableFlag == "1") && (curUserType != sysUserType)) {
        $("#ResetRestore").css("display", "none");
        $("#BackupRestore").css("display", "none")
    }

    if ((CfgMode.toUpperCase() == 'COCLAROEBG4') && (curUserInfoStatus != "3")) {
        setDisplay("MainContent", 0);
    }

    if (supportOperateAp == true) {
        $('#RestoreApFactory').css("display", "block");
    }

    if ((CfgMode.toUpperCase() == 'TS2WIFI') && (curUserType != sysUserType)) {
        if (curUserType != sysUserType) {
            $('#BackupRestore').css("display", "none");
        }
        $("#OntRestore").css("display", "block");
    }

    if ((CfgMode.toUpperCase() == "ANTEL2") && (curUserType == "1")) {
        $('#BackupRestore').css("display", "none");
    }

    if ((curUserType == 1) && ((CfgMode.toUpperCase() == "MONGOLIA") || (CfgMode.toUpperCase() == "MONGOLIA2"))) {
        $("#ResetRestore").css("display", "none");
        window.parent.adjustParentHeight("routermngtpage", 270);
    }

    if (CfgMode.toUpperCase() == "AISAP") {
        $("#OntRestore").css("display", "block");
        $('#BackupRestore').css("display", "none");
    }
    
    if ((CfgMode.toUpperCase() == "RDSGATEWAY") && (curUserType != sysUserType)) {
        $('#BackupRestore').css("display", "none");
    }
}

function PageTitleVisible()
{
	var invisibleCfgWordList = ["DSTCOACCESS"];
    for (var loop = 0; loop < invisibleCfgWordList.length; loop++) {
        if (CfgMode.toUpperCase() == invisibleCfgWordList[loop]) {
            return false;
        }
    }
    if ((ProductType == XDProductType) && supportDSL != 1) {
        return false;
    }
    return true;
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


function CheckPwdNotice()
{
    var password1 = getElementById("newPassword").value;
    var password2 = getElementById("oldPassword").value;

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
	var DestPwdLen = AlarmPwdType;
	
	if (((CfgMode.toUpperCase() == "DTURKCELL2WIFI") || (CfgMode.toUpperCase() == "TURKCELL2")) && curUserType == sysUserType)
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

	if (oldPassword.value == "" && curUserType != sysUserType)
	{
		AlertEx(GetLanguageDesc("s0f0f"));
		return false;
	}

	if (newPassword.value == "")
	{
		AlertEx(GetLanguageDesc("s0f02"));
		return false;
	}

	if (CfgMode.toUpperCase()  == 'TDE2')
	{
		if (newPassword.value.length > 64)
		{
			AlertEx(GetLanguageDesc("s1904a"));
			return false;
		}
	}
	else
	{
		if (newPassword.value.length > 127)
		{
			AlertEx(GetLanguageDesc("s1904"));
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

    if (((CfgMode.toUpperCase() == "DTTNET2WIFI") || (CfgMode.toUpperCase() == "TTNET2")) &&
        (!TtnetComplex(oldPassword.value, newPassword.value))) {
         return false;
    }

	if(curUserType != sysUserType || ((1 == ModifyPwdType) && (curUserType == sysUserType)))
	{
		var NormalPwdInfo = FormatUrlEncode(oldPassword.value);
		var CheckResult = 0;
        var checkPwdUrl = "../common/CheckNormalPwd.asp?&1=1";
		if ((isMultiAdminUser == 1) || (ttnet == 1)) {
        	checkPwdUrl = "../common/CheckOldPwd.asp?&1=1";
    	}

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

    if (CfgMode.toUpperCase() == "TTNET2") {
        if (!TtnetComplex(oldPassword.value, newPassword.value)) {
            return false;
        }
    }

    if(!CheckPwdIsComplex(newPassword.value)) {
        if (CfgMode.toUpperCase() == "EGVDF2") {
            AlertEx(GetLanguageDesc("s1116m"));
            return false;
        }

        AlertEx(GetLanguageDesc("s1902"));
        return false;
    }

	return true;
}

function GetLanguageDesc(Name)
{
	return AccountLgeDes[Name];
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

function SubmitPwdCut()
{
    if (!CheckParameter()) {
        return false;
    }

    var Form = new webSubmitForm();
    Form.addParameter('x.Password',getValue('newPassword'));
    if ((curUserType != sysUserType) || ((ModifyPwdType == 1) && (curUserType == sysUserType))) {
        Form.addParameter('x.OldPassword',getValue('oldPassword'));
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.' + sptInstantNo +
                   '&RequestFile=html/ssmp/accoutcfg/ontmngt.asp');
    Form.submit();
}

function SubmitPwd(val)
{
    if (isSupportCut == "1") {
        SubmitPwdCut();
        return;
    }

    var newPassword = getValue('newPassword');
    var guideConfigParaList = new Array(new stSpecParaArray("x.Password",newPassword, 0));

    if(!CheckParameter())
    {
        return false;
    }
    else
    {
        if ((1 == clisynFlag) && (1 == cliadminsynFlag))
        {
            if (newPassword.length <= 64)
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
    var parainfo = 'x.Password=' + FormatUrlEncode(getValue('newPassword')) + "&";
    if ((curUserType != sysUserType) || ((ModifyPwdType == 1) && (curUserType == sysUserType))) {
        parainfo += 'x.OldPassword=' + FormatUrlEncode(getValue('oldPassword')) + "&";
    }
    parainfo += 'x.X_HW_Token=' + getValue('onttoken');
    if (ttnet == '1') {
        sptInstantNo = getInstIDbyUserName(sptUserName);
    }

    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : parainfo,
         url : "setajax.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo." + sptInstantNo + "&RequestFile=CustomApp/mainpage.asp",
         success : function(data) {
                var ResultInfo = JSON.parse(hexDecode(data));
                if (ResultInfo.result == 0) {
                    if (webPwdChange == 1) {
                        AlertEx(GetLanguageDesc("s0f0e0"));
                    } else {
                        AlertEx(GetLanguageDesc("s0f0e"));
                    }

                    $('#defaultpwdnotice').css("display", "none");
                    CanclePwd();
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

function CanclePwd()
{
    setText("oldPassword","");
    setText("newPassword","");
    setText("cfmPassword","");
    if(1 ==  PwdTipsFlag)
    {
        $("#testTips").css("display", "none");
        $("#psd_checkpwd").css("display", "none");
    }
}

function ResetONT()
{
    var Title = ResetLgeDes["s0601"];
    if(ConfirmEx(Title))
    {
        setDisable('btnReboot',1);

        var Form = new webSubmitForm();

        Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
                                + '&RequestFile=html/ssmp/accoutcfg/ontmngt.asp');
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.submit();
    }
}

function RestoreDefaultChoose()
{
	setDisable('btnRestoreDftCfg',1);
	$('#PageBaseMask').css("display", "block");	
	$('#MBIOTRestoreInfo').css("display", "block");
}
function ApplyRestore()
{
	$('#PageBaseMask').css("display", "none");	
	$('#MBIOTRestoreInfo').css("display", "none");
	var Form = new webSubmitForm();
	setDisable('btnRestoreDftCfg', 1);
	if(getCheckVal('EnableCheckBox') == 1)
	{
		Form.addParameter('ParaKey', "ResetIot");
	}
	Form.setAction('restoreIotdefcfg.cgi?&RequestFile=html/ssmp/ssmp/reset.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}
function CancelRestore()
{
	$('#PageBaseMask').css("display", "none");	
	$('#MBIOTRestoreInfo').css("display", "none");
	setDisable('btnRestoreDftCfg',0);
}

function RestoreONT()
{	
    var Title = RestoreLgeDes["s0a01"];

    if (ProductType == '3')
    {
        if('1' == UpdateState)
        {
            alert("The device is upgrading, please do not reset the device!");
            return false;
        }
    }

	if(1 == parseInt(IsSupportIot))
	{
		RestoreDefaultChoose();
	}
	else
	{
		if(ConfirmEx(Title))
		{
			var Form = new webSubmitForm();

			setDisable('btnRestoreDftCfg', 1);
			Form.setAction('restoredefaultcfg.cgi?' + 'RequestFile=html/ssmp/accoutcfg/ontmngt.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
		}
	}
    
}

var backupfilelist = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_AutoBackupRestore.RestoreFileLst);%>';

var g_FilelistArray = backupfilelist.split(",");
function WriteFileListOption(id)
{
	var select = document.getElementById(id);
	if (backupfilelist != "" && g_FilelistArray != 'null')
	{
		var validIndex=1;
		for (var i in g_FilelistArray)
		{
			if ((g_FilelistArray[i] == 'null')
				|| (g_FilelistArray[i] == 'undefined'))
				continue;
				
			var opt = document.createElement('option');
			var htmlstr= validIndex + " " + g_FilelistArray[i];
			var html = document.createTextNode(htmlstr);
			opt.value = validIndex;
			opt.appendChild(html);
			select.appendChild(opt);
			validIndex++;
		}
		return true;
	}
	else
	{
		var opt = document.createElement('option');
		var html = document.createTextNode("not exsit backup file");
		opt.value = 'none';
		opt.appendChild(html);
		select.appendChild(opt);
		return false;
	}
}

function RestoreBRONT(){
    if ((CfgMode.toUpperCase() == "RDSGATEWAY") && (curUserType != sysUserType)) {
        return;
    }

	var Title = RestoreLgeDes["s0a00"];
	if(ConfirmEx(Title))
	{
		var Form = new webSubmitForm();
		var restorefile = getSelectVal('backup_filelist');
		var restorepoint = restorefile;
		Form.addParameter('filenum', restorepoint);
		Form.setAction('restorebackup.cgi?&RequestFile=html/ssmp/accoutcfg/ontmngt.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function ChooseFile(){
	var restorefile = getSelectVal('backup_filelist');
	if(restorefile == "none"){
		setDisable('btnRestoreBRDftCfg',1);
	}else{
		setDisable('btnRestoreBRDftCfg',0);
	}
}

function stApDeviceList(domain,ApOnlineFlag,APMacAddr)
{
    this.domain = domain;
    this.ApOnlineFlag = ApOnlineFlag;
    this.APMacAddr = APMacAddr;
}

var apDeviceList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_APDevice.{i},ApOnlineFlag|APMacAddr,stApDeviceList);%>;
var apEnableDeviceList = new Array();
var apActionEnable = 0;
var idx = 0;
for (var i = 0; i < apDeviceList.length - 1; i++) {
    if (apDeviceList[i].ApOnlineFlag == '1') {
        GetApEnable(apDeviceList[i].APMacAddr);
        if (apActionEnable == 1) {
            apEnableDeviceList[idx] = apDeviceList[i];
            idx++;
        }
    }
}

function GetApEnable(mac)
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "../common/GetApActionEnable.asp?&1=1",
        data :'APMacAddr=' + mac,
        success : function(data) {
            apActionEnable = data;
        }
    });
}

var supportOperateAp = false;
if (apEnableDeviceList.length > 0) {
    supportOperateAp = true;
}

function WriteApMacOption(id)
{
    var select = document.getElementById(id);
    for (var i in apEnableDeviceList) {
        var opt = document.createElement('option');
        var html = document.createTextNode(apEnableDeviceList[i].APMacAddr);
        opt.value = apEnableDeviceList[i].APMacAddr;
        opt.appendChild(html);
        select.appendChild(opt);
    }
}

function RestoreApFactoryCfg()
{
    var apMac = getSelectVal('apMacList');
    if (ConfirmEx(AccountLgeDes["s1205"])) {
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : "APMacAddr=" + apMac + "&x.X_HW_Token=" + getValue('onttoken'),
            url : 'restoreApFactory.cgi?&RequestFile=html/ssmp/accoutcfg/ontmngt.asp',
            success : function(data) {
                    var ResultInfo = JSON.parse(hexDecode(data));
                    if (ResultInfo.Result == 0) {
                        return;
                    }
                    AlertEx(GetLanguageDesc("s1206"));
                 }
         });
    }
}

function vdfPwdStrengthServer(id)
{
    var checkid = "pwdvalue6"
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

</script>
</head>
<body onLoad="LoadFrame();" style="background-color:#EDF1F2;">
<div id="MBIOTRestoreInfo" class="MBIOTRestoreInfo">
<div class="title_spread"></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div id="iotAlarmInfo" class="iotResetHeadSpanCss"><span id="AlarmInfoSpan" BindText="s0a04"></span></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div id="CheckBoxArea" class="iotResetHeadSpanCss">
<input id="EnableCheckBox" name="EnableCheckBox" class="CheckBoxMiddle" value='1' type='checkbox'><span id="CheckInfoSpan" BindText="s0a05"></span>
</div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div id="IotRestroeButtonCss" class="IotRestroeButtonCss">
<input type="button"  class="ApplyButtoncss buttonfloatleft buttonwidth_100px" id="ApplyRestore" onClick="ApplyRestore(this);" value="" BindText="s0a06"/>
<input type="button"  class="ApplyButtoncss buttonfloatright buttonwidth_100px" id="CancelRestore" onClick="CancelRestore();" value="" BindText="s0a07"/>
</div><!-- end of ChooseButton-->
</div>
<div id="MainContent">

<script>
if (ProductType == '3')
{
    document.write('<div id="PageTitle" class="PageTitleCss" BindText="s1119_cm"></div>')
}
else if ((ProductType == '2') || (notSupportPON == '1'))
{
    document.write('<div id="PageTitle" class="PageTitleCss" BindText="s1119_telmex"></div>')
}
else
{
    document.write('<div id="PageTitle" class="PageTitleCss" BindText="s1119"></div>')
}

</script>

<div id="userinfoontmngt">
<div id="FunctionUser" class="FunctionTitle">
<div id="FunctionTitleIcon" class="FunctionTitleCss"></div>
<div id="FunctionTitleText"><span id="FunctionTitleTextSpan" class="FunctionTitleTextSpanCss" BindText="s1120"></span></div>
<div id="defaultpwdnotice"></div>
</div>

<div class="DivSpace"></div>

<div id="userconfig">
<div id="username" class="divtr" style="display:none;">
<div class="divtdlabal"><span id="useraccount" BindText="s0f08"></span></div>
<div id="txt_Username" name="txt_Username" class="divtdinput"></div>
</div>

<div id="olduserpwd" class="divtr" style="display:none;">
<div class="divtdlabal"><span id="olduserpassword" BindText="s0f13"></span></div>
<div class="divtdinput"><input type="password" autocomplete="off" id="oldPassword" name="oldPassword" class="textboxbg"></div>
</div>

<div id="newuserpwd" class="divtr">
<div class="divtdlabal"><span id="newuserpassword" BindText="s0f09"></span></div>
<script>
if (SupportTtnet()) {
    document.write('<div class="divtdinput"><input type="text" autocomplete="off" id="newPassword" name="newPassword" class="textboxbg"></div>');
} else {
    document.write('<div class="divtdinput"><input type="password" autocomplete="off" id="newPassword" name="newPassword" class="textboxbg"></div>');
}
</script>
</div>
<script>
if (CfgMode.toUpperCase() == "EGVDF2") {
    document.write('<div id="checkinfo1Row" class="divtr" style="display:none; height: 45px;"><div id = "checkinfotitel" class="divtdlabal" style="margin-top:10px;">');
    document.write('<span id="checkinfo1Col" BindText="s1447"></span></div><div id="checkinfoblock" class="divtdlabal"></div></div>');
    $('#newPassword').on('keyup',function(){
        $("#checkinfo1Row").css("display", "");
        $("#psd_checkpwdvdfserver").css("display", "block");
        vdfPwdStrengthServer("newPassword");
    });
}
</script>
<div id="newusercfmpwd" class="divtr">
<div class="divtdlabal"><span id="newusercfmpassword"  BindText="s0f0b"></span></div>
<script>
if (SupportTtnet()) {
    document.write('<div class="divtdinput"><input type="text" autocomplete="off" id="cfmPassword" name="cfmPassword" class="textboxbg"></div>');
} else {
    document.write('<div class="divtdinput"><input type="password" autocomplete="off" id="cfmPassword" name="cfmPassword" class="textboxbg"></div>');
}
</script>
</div>

<div id="testTips" style="display:none;">
<div class="divLabal"><span id="newuserpassword" BindText="s1447"></span></div>
<div class="pwdTips">

<div id="checkinfo1" class="divtr" >
<div class="divtdlabal"><span id="test1234" ></span></div>
<div class="divtdinput"></div>
</div>
</div>


</div>

<div id="submitinfo" class="divtrbutton">
<div class="divtdlabal"></div>
<div class="divtdinput">
<input type="button" id="MdyPwdApply" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitPwd(this);" value="" BindText="s1121">
<input type="button" id="MdyPwdcancel" class="CancleButtonCss buttonwidth_100px" onClick="CanclePwd(this);" value="" BindText="s0f0d">
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
</div>
</div><!-- end of submitinfo -->
</div><!-- end of userconfig -->
<div id="pwdnoticeareatitle" class="pwdnoticeareaCss"><span id="PwdNoticeTitle" class="PwdNoticeTextCss" BindText="s2010"></span></div>
<div id="pwdnoticearea" class="PwdNoticeTextCss">
<ol class="outside" id="PwdNotice"><li><span id="PwdLengthAlarm" BindText="s2011"></span></li><li><span id="PwdComplexAlarm" BindText="s2012"></span></li><li><span BindText="s2013"></span></li></ol></div>
</div>
<div id="ResetRestore" style="margin-top: 6px">
<div class="FunctionTitle">
<div id="FunctionTitleIcon" class="FunctionTitleCss"></div>
<div id="FunctionTitleText">
<script type="text/javascript" language="javascript">
    function canRestore() {
        if (["DNOVA2WIFI"].indexOf(CfgMode.toUpperCase()) >= 0) {
            return 1;
        }

        if (CfgMode.toUpperCase() == "BYTEL") {
            return 0;
        }

        if ((CfgMode.toUpperCase() == "RDSGATEWAY") && (curUserType != sysUserType)) {
            return 0;
        }

        return ((curUserType == 0) ||
                (WebAdminReset == 0) ||
                (["DMASMOVIL2WIFI", "DAUM2WIFI", "TTNET2"].indexOf(CfgMode.toUpperCase()) > -1) ||
                (DBAA1 == "1") ||
                ((CfgMode.toUpperCase() == "DETHMAXIS") && (curUserType == 1)));
    }

    if (canRestore()) {
        if (CfgMode.toUpperCase() == "DETHMAXIS") {
            document.write("<span id=\"FunctionTitleTextSpan2\" class=\"FunctionTitleTextSpanCss\" BindText=\"s1122_maxis\"></span>");
        } else {
            document.write("<span id=\"FunctionTitleTextSpan2\" class=\"FunctionTitleTextSpanCss\" BindText=\"s1122\"></span>");
        }
    } else {
        if (CfgMode.toUpperCase() == "DETHMAXIS") {
            document.write("<span id=\"FunctionTitleTextSpan2\" class=\"FunctionTitleTextSpanCss\" BindText=\"s1128_maxis\"></span>");
        } else {
            document.write("<span id=\"FunctionTitleTextSpan2\" class=\"FunctionTitleTextSpanCss\" BindText=\"s1128\"></span>");
        }
    }
</script></div>
</div>
<div id="OntReset">
<div id="ResetIcon" class="OntResetIcon"></div>
<div id="ResetButton" class="FloatLeftCss">
<input type="button"  class="bluebuttoncss buttonwidth_150px_200px" id="btnReboot" onClick="ResetONT(this);" value="" BindText="s1123"/>
</div>
<div id="ResetDes">
<table height="40px;"><tr><td class="ResetRestoreSpan" BindText="s1125"></td></tr></table>
</div>
</div>
<div id="OntRestore">
<div id="RestoreIcon" class="OntRestoreIcon">
<SCRIPT>
    if ((CfgMode.toUpperCase() == 'DVODACOM2WIFI') || (CfgMode.toUpperCase() == 'HT') || (CfgMode.toUpperCase() == 'OTE') || (('DETHMAXIS' == CfgMode.toUpperCase()) && (curUserType == sysMaxisLocalUserType)))  {
        setDisplay('OntRestore',1);
	} else {
		 setDisplay('OntRestore', canRestore());
	}
    if (canRestore())
    {
        window.parent.adjustParentHeight("routermngtpage", 450);
    }
    else
    {
        window.parent.adjustParentHeight("routermngtpage", 360);
    }
</SCRIPT></div>
<div id="RestoreButton" class="FloatLeftCss">
<script>
    if (CfgMode.toUpperCase() == 'DETHMAXIS') {
        document.write('<input type="button"  class="bluebuttoncss buttonwidth_150px_200px" id="btnRestoreDftCfg" onClick="RestoreONT(this);" value="" BindText="s1128"/>');
    } else {
        document.write('<input type="button"  class="bluebuttoncss buttonwidth_150px_200px" id="btnRestoreDftCfg" onClick="RestoreONT(this);" value="" BindText="s1127"/>');
    }
</script>
</div>
<div id="RestoreDes">
<table height="40px;">
    <tr>
        <script>
            if (CfgMode.toUpperCase() == 'DETHMAXIS') {
                document.write('<td class="ResetRestoreSpan" BindText="s1126_maxis"></td>');
            } else {
                document.write('<td class="ResetRestoreSpan" BindText="s1126"></td>');
            }
        </script>
    </tr>
</table>
</div>
</div>
<div class="DivSpace"></div>
</div>

<div id="BackupRestore" style="margin-top: 20px;display:none;">
<div class="FunctionTitle">
<div id="FunctionTitleIcon" class="FunctionTitleCss"></div>
<div id="FunctionBRTitleText">
<script type="text/javascript" language="javascript">
if (CfgMode.toUpperCase() == 'DETHMAXIS') {
    document.write("<span id=\"FunctionBRTitleTextSpan2\" class=\"FunctionTitleTextSpanCss\" BindText=\"s2504_maxis\"></span>");
} else {
    document.write("<span id=\"FunctionBRTitleTextSpan2\" class=\"FunctionTitleTextSpanCss\" BindText=\"s2501\"></span>");
}
</script></div>
</div>
<div id="ChhooseFileArea" class="ChhooseFileAreaCss">
<div id="ChooseBRDes" class="ChooseBRDesCss"><span class="ResetRestoreSpan" BindText="s2503"></span></div>
<div id="ChooseBRButton" class="FloatLeftCss ChooseBRButtonCss">
<select name="backup_filelist" id="backup_filelist" size="1" OnChange="ChooseFile(this);">
</select>
<script language="JavaScript" type="text/javascript">
WriteFileListOption("backup_filelist");
</script>
</div>
</div>

<div id="OntRestoreBR">
<script>
if (CfgMode.toUpperCase() == "BYTEL") {
    window.parent.adjustParentHeight("routermngtpage", 200);
} else {
    window.parent.adjustParentHeight("routermngtpage", 600);
}
</script>
<div id="RestoreBRButton" class="FloatLeftCss">
    <script language="JavaScript" type="text/javascript">
        var curClass = "bluebuttoncss buttonwidth_120px_200px"
        if ((curLanguage == 'russian') && (CfgMode.toUpperCase() != 'DETHMAXIS')) {
            curClass = "bluebuttoncss buttonwidth_150px_250px";
        }

    if (CfgMode.toUpperCase() == 'DETHMAXIS') {
            document.write('<input type="button" class="' + curClass + '" id="btnRestoreBRDftCfg" onClick="RestoreBRONT(this);" value="" BindText="s2504_maxis"/>');
        } else {
            document.write('<input type="button" class="' + curClass + '" id="btnRestoreBRDftCfg" onClick="RestoreBRONT(this);" value="" BindText="s2504"/>');
    }
</script>
</div>
<div id="RestoreBRDes" class="RestoreBRDesCss">
<table height="40px;"><tr>
    <script>
        if (CfgMode.toUpperCase() == 'DETHMAXIS') {
            document.write('<td class="ResetRestoreSpan BRRestoreSpanCss" BindText="s2502_maxis"></td>');
        } else {
            document.write('<td class="ResetRestoreSpan BRRestoreSpanCss" BindText="s2502"></td>');
        }
    </script>
</tr>
</table>

</div>
</div>
<div class="DivSpace"></div>
</div>

<div id="RestoreApFactory" style="margin-top: 20px;display:none;">
<script>
if (supportOperateAp == true) {
    var newHeight = parseInt(window.parent.getElementById('routermngtpage').style.height) + 150;
    window.parent.adjustParentHeight("routermngtpage", newHeight);
}
</script>
<div class="FunctionTitle">
<div id="FunctionTitleIcon" class="FunctionTitleCss"></div>
<div id="RestoreApFactoryTitle">
<script type="text/javascript" language="javascript">
document.write("<span id=\"RestoreApFactoryTitleSpan2\" class=\"FunctionTitleTextSpanCss\" BindText=\"s1201\"></span>");
</script></div>
</div>
<div id="ChooseApMacArea" class="ChhooseFileAreaCss">
<div id="ChooseApMacDes" class="ChooseBRDesCss"><span class="ResetRestoreSpan" BindText="s1202"></span></div>
<div id="ChooseApMacList" class="FloatLeftCss ChooseBRButtonCss">
<select name="apMacList" id="apMacList" size="1">
</select>
<script language="JavaScript" type="text/javascript">
WriteApMacOption("apMacList");
</script>
</div>
</div>

<div id="OntRestoreBR">
<div id="RestoreApFactoryButton" class="FloatLeftCss">
<input type="button"  class="bluebuttoncss buttonwidth_150px_250px" id="btnRestoreApFactoryCfg" onClick="RestoreApFactoryCfg(this);" value="" BindText="s1204"/>
</div>
<div id="RestoreApFactoryCfgDes" class="RestoreBRDesCss">
<table height="40px;"><tr><td class="ResetRestoreSpan BRRestoreSpanCss" BindText="s1203"></td></tr></table>
</div>
</div>
<div class="DivSpace"></div>
</div>

</div>
<script>
$('#newPassword').bind('keyup',function()
{
    if(1 == PwdTipsFlag)
    {
        $("#testTips").css("display", "block");
        $("#psd_checkpwd").css("display", "block");
        psdStrength();
    }
});

$('#newPassword').blur(function()
{
	CheckPwdNotice();
});

if(curUserType != sysUserType
	&& 1 == parseInt(isGlobe, 10))
{
	document.getElementById("FunctionTitleTextSpan2").setAttribute("BindText","s1122a");
	document.getElementById("OntRestore").style.display = "none";
}
ParseBindTextByTagName(AccountLgeDes, "span",  1);
ParseBindTextByTagName(AccountLgeDes, "div",   1, mngttype, var_singtel);
ParseBindTextByTagName(AccountLgeDes, "td",    1);
ParseBindTextByTagName(AccountLgeDes, "input", 2);
if(8 == AlarmPwdType)
{
    SetDivValue("PwdLengthAlarm", AccountLgeDes["ss2011a"]);
}
</script>
</div>
</body>
</html>
