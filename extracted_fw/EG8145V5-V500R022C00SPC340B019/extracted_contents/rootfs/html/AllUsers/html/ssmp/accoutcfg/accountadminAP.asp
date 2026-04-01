<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
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
</style>
<script language="JavaScript" type="text/javascript">

var MultiUser = 0;
var CfgMode ='<%HW_WEB_GetCfgMode();%>';

var ShowOldPwd = 0;
var sptUserName = null;
var sptAdminName;
var UserNum = 0;
var CurUserBuf = new Array(); 
var CurUserInst = new Array(); 
var Ftmodifyadmin = '<%HW_WEB_GetFeatureSupport(FT_WEB_MODIFY_USER_PWD);%>';  
var RosFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROS);%>'; 
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var APwebGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_BRIDGE_WEB);%>';
var webPwdChange = '<%HW_WEB_GetFeatureSupport(FT_SSMP_KICKOFF_WEB_USER);%>';
var secCodeLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>'
var pwdComplexFt = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_PWDCOMPLEX);%>';

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

function stSSLWeb(domain,Enable)
{
	this.domain = domain;
	this.Enable   = Enable;
}

var stModifyUserInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName|UserLevel|Enable, stModifyUserInfo);%>;
var LoginRequestLanguage = '<%HW_WEB_GetLoginRequestLangue();%>';
var stSSLWebs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebSslInfo,Enable,stSSLWeb);%>;
var SSLConfig = stSSLWebs[0];

var IsSurportWebsslPage  = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_WEBSSLPAGE);%>';
if (3 < stModifyUserInfos.length)
{
	MultiUser = 1;
}

for (var i = 0; i < stModifyUserInfos.length - 1; i++)
{
	if (stModifyUserInfos[i].UserLevel == 0)
	{
		sptUserName = stModifyUserInfos[i].UserName;
	}
}

if (1 < UserNum)
{
	MultiUser = 1;
}

function GetAdminIndexForAis()
{
  if ((stModifyUserInfos == null) || (stModifyUserInfos.length == 1)) {
    return 0;
  }

  for (var i = 0; i < (stModifyUserInfos.length - 1); i++) {
    if (stModifyUserInfos[i].UserLevel == 0) {
      return i;
    }
  }

  return 0;
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

	var webCertTips = (pwdComplexFt == 1) ? 's1116_sec' : 's1116';
	div.innerHTML = WebcertmgntLgeDes[webCertTips];
	div.style.display = '';
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

function title_back(input)
{
	var div=document.getElementById("title_show");
	div.style.display = "none";
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
	top.previousPage = '/html/ssmp/accoutcfg/accountadminAP.asp';
	setDisable('btnSubmit',1);
	uploadForm.submit();
	setDisable('browse',1);
	setDisable('btnBrowse',1);
}

function AddSubmitImportcert()
{
	if (IsSurportWebsslPage !=1)
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
						 + '&RequestFile=html/ssmp/accoutcfg/accountadminAP.asp');

	setDisable('WebbtnApply',1);
	setDisable('WebcancelValue',1);
	Form.submit();
}

function SetCertificateInfo()
{
	if (IsSurportWebsslPage !=1)
	{
		return false;
	}
	var Form = new webSubmitForm();
	var Value = getCheckVal('WebCertificateEnable');

	Form.addParameter('x.Enable', Value);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebSslInfo&RequestFile=html/ssmp/accoutcfg/accountadminAP.asp');
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
	else
	{
		if (str.length < secCodeLen) {
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

		if ( isSpecialCharacterNoSpace(str) )
		{
			i++;
		}
	}
	
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}
function CheckPwdIsComplexWithSpace(str)
{
	var i = 0;
    if (str.length < secCodeLen) {
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
function LoadFrame()
{
		
	if( 1 == APwebGuideFlag )
	{
		setDisplay("WebUserNameRow",0);
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
	

	if( 1 == IsSurportWebsslPage )
	{
		setDisplay("websslpage",1);
	}

	if ( null != SSLConfig )
	{
		setCheck('WebCertificateEnable', SSLConfig.Enable);
	}

	if( ( window.location.href.indexOf("complex.cgi?") > 0) )
	{
		AlertEx(GetLanguageDesc("s0d14"));
	}

	
	if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
	{
		var pwdcheck1 = document.getElementById('checkinfo1');
		pwdcheck1.innerHTML =' <div class="row hidden-pw-row" id="psd_checkpwd" style="display:none;"><div class="left" style="display: table-cell; float:left; width: 126px;"><span style="text-align:center;" class="language-string" id="pwdvalue1" BindText="s1448"></span> </div></div>';
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

function CheckParameter()
{

	var newPassword = document.getElementById("newPassword");
	var cfmPassword = document.getElementById("cfmPassword");
	

		var oldPassword = document.getElementById("oldPassword");	
	if (oldPassword.value == "")
	{	
		AlertEx(GetLanguageDesc("s0f0f")); 
		return false;
	}
	if (newPassword.value == "") {
		AlertEx(GetLanguageDesc("s0f02"));
		return false;
	}

	if (newPassword.value.length > 127) {
		AlertEx(GetLanguageDesc("s1904"));
		return false;
	}

	if (!isValidAscii(newPassword.value)) {
		AlertEx(GetLanguageDesc("s0f04"));
		return false;
	}

	if (cfmPassword.value != newPassword.value) {
		AlertEx(GetLanguageDesc("s0f06"));
		return false;
	}

	var NormalPwdInfo = FormatUrlEncode(oldPassword.value);
    var CheckResult = 0;

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "/html/ssmp/common/CheckNormalPwd.asp?&1=1",
		data :'NormalPwdInfo='+NormalPwdInfo + '&NewWebUserPwd=' + FormatUrlEncode(newPassword.value),
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

	if(!CheckPwdIsComplex(newPassword.value))
	{
		AlertEx(GetLanguageDesc("s1902"));
		return false;
	}

	setDisable('MdyPwdApply', 1);
	setDisable('MdyPwdcancel', 1);

	return true;
}

function SubmitPwd()
{
    if (!CheckParameter()) {
        return false;
    }

    var InstNo = 0;
    if (CfgMode.toUpperCase() == "AISAP") {
        InstNo = GetAdminIndexForAis();
    }

    var parainfo="";
    parainfo='x.OldPassword=' + FormatUrlEncode(getValue('oldPassword')) + "&";
    parainfo +='x.Password=' + FormatUrlEncode(getValue('newPassword')) + "&";
    parainfo +='x.X_HW_Token=' + getValue('onttoken');
    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : parainfo,
         url : "setajax.cgi?x=" + stModifyUserInfos[InstNo].domain + "&RequestFile=html/ssmp/accoutcfg/accountadminAP.asp",
         success : function(data) {
                var ResultInfo = JSON.parse(hexDecode(data));
                if (ResultInfo.result == 0) {
                    if (webPwdChange == 1) {
                        AlertEx(GetLanguageDesc("s0f0e0"));
                    } else {
                        AlertEx(GetLanguageDesc("s0f0e"));
                    }
                    CancelValue();
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
	setText('newPassword','');
	setText('cfmPassword','');
	setText('oldPassword','');
	
	if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
	{
		$("#checkinfo1Row").css("display", "none");
		$("#psd_checkpwd").css("display", "none");
	}
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

function CheckPwdNotice()
{
	var password1 = getElementById("newPassword").value;
	
	if(password1.length == 0){
		return;
	}
	
	if(!CheckPwdIsComplex(password1))
	{
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
	var DestPwdLen = secCodeLen;
	
	if ("DTURKCELL2WIFI" == CfgMode.toUpperCase() && curUserType == sysUserType)
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

</script>
</head>

<body  class="mainbody pageBg" onLoad="LoadFrame();">
	<script language="JavaScript" type="text/javascript">	
	if(1 == IsSurportWebsslPage && 1 == Ftmodifyadmin)	
	{
		HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0f12a"), false);
	}
	else if(1 == IsSurportWebsslPage && 0 == Ftmodifyadmin)
	{
		HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0100a"), false);
	}
	else if(0 == IsSurportWebsslPage && 1 == Ftmodifyadmin)
	{
		HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0f12"), false);
	}
	else
	{
		HWCreatePageHeadInfo("accountadmin", GetDescFormArrayById(AccountLgeDes, "s0102"), GetDescFormArrayById(AccountLgeDes, "s0f07a"), false);
	}
		
	</script>
	<div class="title_spread"></div>
	<div class="func_title" BindText="s0101"></div>
	<table width="100%" border="0" cellpadding="0" cellspacing="1">
		<tr id="secUsername">
			<td class="width_per40">
				<form id="PwdChangeCfgForm"  name="PwdChangeCfgForm">
					<table id="PwdChangeCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF">
						<li id="WebUserName" RealType="HtmlText" DescRef="s0f08" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="WebUserName" InitValue="Empty"/>
						<li id="oldPassword" RealType="TextBox"  DescRef="s0f13" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.oldPassword"  InitValue="Empty"/>
						<li id="newPassword" RealType="TextBox"  DescRef="s0f09" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Password"  InitValue="Empty"  onKeyUp="psdStrength()" />
						<li id="cfmPassword" RealType="TextBox"  DescRef="s0f0b" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"       InitValue="Empty"/>
						<!-- 密码强度-->
						<li id="checkinfo1" RealType="HtmlText"  DescRef="s1447" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField=""  InitValue="Empty" style="display:none;" />
						<!-- 密码强度-->
					</table>					
					<script>
						var PwdChangeCfgFormList = new Array();
						PwdChangeCfgFormList = HWGetLiIdListByForm("PwdChangeCfgForm", null);
						var TableClass = new stTableClass("width_per60", "width_per40");
						HWParsePageControlByID("PwdChangeCfgForm", TableClass, AccountLgeDes, null);
	
						var PwdChangeArray = new Array();
						PwdChangeArray["WebUserName"] = sptUserName;
						HWSetTableByLiIdList(PwdChangeCfgFormList, PwdChangeArray, null);
						$('#newPassword').bind('keyup',function(){
							if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
							{
								$("#checkinfo1Row").css("display", "");
								$("#psd_checkpwd").css("display", "block");
								psdStrength();
							}
						});
						
						$('#newPassword').blur(function()
						{
							CheckPwdNotice();
						});
					</script>
				</form>
			</td>
			<script language="JavaScript" type="text/javascript">
			if ((RosFlag == 1) || (RosFlag == '1')) {
				var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="ss1116e"></td>';
			} else if (secCodeLen == 8) {
				var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="ss1116d"></td>';
			} else {
				var innerhtml = '<td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116a"></td>';
			}
			
			document.write(innerhtml);
			</script>
		</tr>
					
	</table>

	<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
		<tr>
			<td class="table_submit width_per25"></td>
			<td class="table_submit">
				<input type="button" id="MdyPwdApply"  name="MdyPwdApply"  class="ApplyButtoncss buttonwidth_100px"  onClick="SubmitPwd();"    BindText="s0f0c" />
				<input type="button" id="MdyPwdcancel" name="MdyPwdcancel" class="CancleButtonCss buttonwidth_100px" onClick="CancelValue();"  BindText="s0f0d" />
			</td>
		</tr>
	</table>
	
	
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
		<form action="websslcert.cgi?RequestFile=html/ssmp/accoutcfg/accountadminAP.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage">
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
		ele.style.background = '#FFFFFF';

		ParseBindTextByTagName(AccountLgeDes, "div",    1);
		ParseBindTextByTagName(AccountLgeDes, "td",     1);
		ParseBindTextByTagName(AccountLgeDes, "input",  2);
	</script>
</body>
</html>
