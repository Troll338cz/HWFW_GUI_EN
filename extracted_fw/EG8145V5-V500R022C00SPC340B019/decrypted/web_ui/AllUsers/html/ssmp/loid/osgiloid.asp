<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_CleanCache_Resource(style_n.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_CleanCache_Resource(lan.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
</head>
<script language="JavaScript" type="text/javascript">
function stAuthGetLoidPwd(domain,UserName,UserId)
{
    this.domain   = domain;
    this.UserName     = UserName;
    this.UserId = UserId;
}

function stResultInfo(domain, Result, Status)
{
	this.domain = domain;
	this.Result = Result;
	this.Status = Status;
} 

var MngtAhct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_AHCT);%>';
var MngtYnct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_YNCT);%>';
var AuthInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, UserName|UserId, stAuthGetLoidPwd);%>; 
var LoidPwdInfo = AuthInfo[0];
var stResultInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, Result|Status, stResultInfo);%>;
var Infos = stResultInfos[0];

var MngtFjct = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_FJCT);%>';

var iPwdLen = 12;	
if(1 == MngtFjct)
{
	iPwdLen = 24;
}

function LoadFrame() 
{
	if ( 1 == MngtAhct || 1 == MngtYnct)
	{
		if (((parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 1)) || (parseInt(Infos.Status) == 5))
		{
			setDisable("UserName",1);
			setDisable("UserId",1);
			setDisable("button",1);			
		}
	}
	setText("UserName", LoidPwdInfo.UserName);
	setText("UserId", LoidPwdInfo.UserId);
}


function CheckForm()
{
    var username = document.getElementById("UserName");
    var userid = document.getElementById("UserId");
	
	if (username.value == "")
	{
		AlertEx("宽带识别码（LOID）不能为空。");
		return false;
	}
	
	if (isValidAscii(username.value) != '')
	{
		AlertEx("宽带识别码（LOID）包含非ASCII字符，请输入正确的宽带识别码（LOID）。");
		return false;
	}

	if (username.value.length > 24)
	{
		AlertEx("宽带识别码（LOID）的长度必须在1~24个字符之间。");
		return false;
	}
	
	if (userid.value != "")
	{
		if (isValidAscii(userid.value) != '')
		{
			AlertEx("密码包含非ASCII字符，请输入正确的密码。");
			return false;
		}
		
		if (userid.value.length > iPwdLen)
		{
			AlertEx("密码的长度必须在1~"+ iPwdLen +"个字符之间。");
			return false;
		}
	}
	
	return true;
}


function ApplySubmit()
{
	if( false == CheckForm())
	{
		return;
	}
	
	if(false == confirm("是否确认修改宽带设置？"))
	{
		return;
	}
	setDisable('button', 1);
	var Form = new webSubmitForm();		
	Form.addParameter('x.UserName',getValue('UserName'));
	Form.addParameter('x.UserId',getValue('UserId'));
    var RequestFile = 'html/ssmp/loid/osgiloid.asp';
    var urlpara;
	urlpara = 'x=InternetGatewayDevice.X_HW_UserInfo&RequestFile=' + RequestFile;
	Form.addParameter('x.X_HW_Token', getAuthToken());
    var url = 'loid.cgi?' + urlpara;
    Form.setAction(url);
	Form.submit();		
}	

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody" style="overflow:hidden;">
<div class="contentItem">
</div>
<div class="contentItem">
</div>
<div class="contentItem">
<div class="labelBox">宽带识别码（LOID）：</div>
<div class="contenbox">
<input type="text" id="UserName" name="UserName" class="textbox" maxlength='24'>
</div>
</div>
<div class="contentItem">
<div class="labelBox">密码：</div>
<div class="contenbox">
<input type="password" autocomplete="off" id="UserId" name="UserId" class="textbox">
</div>
</div>
<td>		
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<button class="button" id="button" onClick="ApplySubmit();">确定</button>
</td>
<!-- </form>	 -->
</body>
</html>
