<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stAuthGetLoidPwd(domain,Loid,Password)
{
    this.domain   = domain;
    this.Loid     = Loid;
    this.Password = Password;
}
var AuthInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, UserName|UserId, stAuthGetLoidPwd);%>;
var LoidPwdInfo = AuthInfo[0]; 
var PwdInfo = '<%HW_WEB_GetCMCCAuthPwd();%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';

var CmccRegflag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CMCC_RMS);%>';
var SavePwdLoid = '<%HW_WEB_GetFeatureSupport(FT_SAVE_PASSWORD_AND_LOID);%>';
var X10Gpon = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_10GPON);%>';
var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var CfgFtWordArea = '<%GetConfigAreaInfo();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var CMCCFTTO = '<%HW_WEB_GetFeatureSupport(FT_CMCC_FTTO);%>';
var ZJCmccRms = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ZJCMCC_RMS);%>';
var locklefttimerhandle;
var isTimeout = false;
var isUseridDisable = '<%WEB_GetRegCodeTimeoutStatus();%>';

function LoadFrame()
{
	if(CfgFtWordArea.toUpperCase() != 'NOCHOOSE' && CfgFtWordArea.toUpperCase() != 'CHOOSE' )
    {
      document.getElementById("DivAuthentication").style.display = "";
    }
    else if(CfgFtWordArea.toUpperCase() == 'NOCHOOSE')
  	{	
			document.getElementById("DivAuthentication").style.display = "";		
  	}
	else if(CfgMode == 'CMCC_RMSBRIDGE')
	{
		window.location = "/html/amp/ontauth/password.asp";
		return;
	}
  	else
	{
		window.parent.document.location.href = "/loidreg.asp";
		return;
	}
	
	if (CfgMode.indexOf("BJCMCC") != -1) {
        if (CMCCFTTO != 1) {
            setDisable("username",1);
            setDisable("userid",1);
            setDisable("setbutton",1);
            setDisable("cancel",1);
        } else {
            setDisable("username",0);
            setDisable("userid",0);
            setDisable("setbutton",0);
            setDisable("cancel",0);
        }
	}
	else
	{
		if (curUserType != sysUserType )
		{
			setDisable("username",1);
			setDisable("userid",1);
			setDisable("setbutton",1);
			setDisable("cancel",1);
		}
	}

    if(CmccRegflag == 1)
	{
		setText("userid", PwdInfo);
	}
	else
	{
		document.getElementById("TroldPassword").style.display = "";
		setText("username", LoidPwdInfo.Loid);
		setText("userid", LoidPwdInfo.Password);
	}

    if (["SHCMCC_RMS","SHCMCC"].indexOf(CfgMode.toUpperCase()) >= 0) {
        document.getElementById("userid").type = 'password';
    }

    if (ZJCmccRms == 1) {
        setDisable('userid', isUseridDisable);
        locklefttimerhandle = setInterval('CheckIsTimeout()', 1000);
    }
}

function CheckIsTimeout()
{
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : '/asp/GetRegCodeTimerStatus.asp',
        success : function(data) {
            isTimeout = data;
        }
    });
    
    if (isTimeout == true) {
        setDisable('userid', 1);
        clearInterval(locklefttimerhandle);
    }
}

function CheckLoidPswForm()
{
    var username = document.getElementById("username");
    var userid = document.getElementById("userid");
    var inLen = 0;    
	
	if (username.value == "")
	{
		AlertEx("LOID不能为空。");
		return false;
	}
	
	if (isValidAscii(username.value) != '')
	{
		AlertEx("LOID包含非ASCII字符，请输入正确的LOID。");
		return false;
	}

	if (username.value.length > 24)
	{
		AlertEx("LOID的长度必须在1~24个字符之间。");
		return false;
	}

	inLen =  username.value.length;	
	if( inLen != 0)
	{
    	if ( ( username.value.charAt(0) == ' ' ) || (username.value.charAt(inLen -1) == ' ') )
    	{
        	if(false == confirm('您输入的LOID开始或结尾有空格，是否确认？'))
        	{			
        		return false;
        	}
    	}
	}		
	
	if (userid.value != "")
	{
		if (isValidAscii(userid.value) != '')
		{
			AlertEx("Password包含非ASCII字符，请输入正确的Password。");
			return false;
		}
		
		if (userid.value.length > 12)
		{
			AlertEx("Password的长度必须在1~12个字符之间。");
			return false;
		}
		
    	inLen =  userid.value.length;
    	if( inLen != 0)
    	{
        	if ( ( userid.value.charAt(0) == ' ' ) || (userid.value.charAt(inLen -1) == ' ') )
        	{
            	if(false == confirm('您输入的Password开始或结尾有空格，是否确认？'))
            	{			
            		return false;
            	}
        	}
    	}					
	}
	
	return true;
}

function CheckPswForm()
{
    var userid = document.getElementById("userid");
	
	if (userid.value != "")
	{
		if (isValidAscii(userid.value) != '')
		{
			AlertEx("Password包含非ASCII字符，请输入正确的Password。");
			return false;
		}
		
        if ((X10Gpon == 1) && (SavePwdLoid == 1)) {
            if (userid.value.length > 24) {
                AlertEx("Password不能超过24个字符。");
                return false;
            }
        } else {
            if (userid.value.length > 10) {
                AlertEx("Password不能超过10个字符。");
                return false;
            }
        }


	}
	return true;
}

function CheckForm_xd()
{   
    var userid = document.getElementById("userid");
	
	if (userid.value != "")
	{
		if (isValidAscii(userid.value) != '')
		{
			AlertEx("Password包含非ASCII字符，请输入正确的Password。");
			return false;
		}
		

		if (userid.value.length > 10)
		{
			AlertEx("Password不能超过10个字符。");
			return false;
		}

	}

    setDisable('setbutton', 1);
	setDisable('cancel', 1);
	return true;
}

function CheckForm()
{
    if (ProductType == 2)
    {
	    var userid = document.getElementById("userid");
		
		if (userid.value != "")
		{
			if (isValidAscii(userid.value) != '')
			{
				AlertEx("Password包含非ASCII字符，请输入正确的Password。");
				return false;
			}
			

			if (userid.value.length > 10)
			{
				AlertEx("Password不能超过10个字符。");
				return false;
			}

		}

	    setDisable('setbutton', 1);
		setDisable('cancel', 1);
		return true;
    }
    else
    {
		 if(CmccRegflag == 1)
		{
			if(CheckPswForm() != true)
			{
				return false;
			}
		}
		else
		{
			if(CheckLoidPswForm() != true)
			{
				return false;
			}
		}
		setDisable('setbutton', 1);
		setDisable('cancel', 1);
		return true;    	
    }	

}

function AddSubmitParam(SubmitForm,type)
{
    if ((ZJCmccRms == 1) && (isTimeout == true)) {
        return;
    }

	if(CmccRegflag == 1)
	{
		SubmitForm.addParameter('x.Password',getValue('userid'));
	}
	else
	{
		SubmitForm.addParameter('x.UserName',getValue('username'));	
		SubmitForm.addParameter('x.UserId',getValue('userid'));
	}
	
	SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.X_HW_UserInfo'
							 + '&RequestFile=html/ssmp/loid/cmccloid.asp');	 
}

function CancelValue()
{

    if(CmccRegflag == 1)
	{
		setText("userid", PwdInfo);
	}
	else
	{
		setText("username", LoidPwdInfo.Loid);
		setText("userid", LoidPwdInfo.Password);
	}
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();"> 
<div name="DivAuthentication" id="DivAuthentication"  style="display:none">	
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td class="prompt"><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%"> <script language="JavaScript" type="text/javascript">	
			if (CmccRegflag == 1)
			{
				document.write("您可以通过设置Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。");
			}
			else
			{
				document.write("您可以通过设置LOID和Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。");
			}
			</script> </td> 
        </tr> 
      </table></td> 
  </tr> 
</table> 
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr id="TroldPassword"  style="display:none"> 
    <td  class="table_left" align="left" width='25%'>LOID:</td> 
    <td  class="table_right" align="left" colspan="6" width='75%'>
    	<input name='username' type="text" id="username"> 
      <strong style="color:#FF0033">*</strong>
      <span class="gray"><script>document.write("(字符串最多包含24个英文字符或数字)");</script></span>
      </td> 
  </tr> 
  <tr> 
    <td class="table_left"  align="left" width='25%'>Password:</td> 
    <td class="table_right"   align="left" colspan="6" width='75%'>
    	 <input name='userid' type="text" id="userid">
    	 <span class="gray">
    	    <script>
    	        if ((X10Gpon == 1) && (SavePwdLoid == 1)) {
    	            document.write("(字符串最多包含24个英文字符或数字)");
    	        } else {
    	            document.write("(字符串最多包含10个英文字符或数字)"); 
    	        }
    	    </script></span>
    </td> 
  </tr> 
</table> 
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_button"> 
  <tr> 
    <td class="table_submit" width='25%'></td> 
    <td  class="table_submit" align="left"> 
      <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
      <input  class="submit" name="setbutton" id="setbutton" type="button" onClick="Submit();" value="认证"> 
      <input class="submit" name="cancel" id="cancel" type="button" onClick="CancelValue();" value="取消"> 
    </td> 
  </tr> 
</table> 
<table width="100%" height="15" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 
</div>	
</body>
</html>
