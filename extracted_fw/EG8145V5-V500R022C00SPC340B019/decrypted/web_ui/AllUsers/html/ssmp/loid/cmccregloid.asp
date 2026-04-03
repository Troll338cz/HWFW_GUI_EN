<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stAuthGetLoidPwd(domain,Loid,Password,X_HW_RmsRegType)
{
    this.domain   = domain;
    this.Loid     = Loid;
    this.Password = Password;
	this.X_HW_RmsRegType=X_HW_RmsRegType;
}

var AuthInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, UserName|UserId|X_HW_RmsRegType, stAuthGetLoidPwd);%>;
var LoidPwdInfo = AuthInfo[0]; 
var PwdInfo = '<%HW_WEB_GetCMCCAuthPwd();%>';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';

var CmccRegflag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_CMCC_RMS);%>';
var SavePwdLoid = '<%HW_WEB_GetFeatureSupport(FT_SAVE_PASSWORD_AND_LOID);%>';
var X10Gpon = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_10GPON);%>';
var CfgFtWordArea = '<%GetConfigAreaInfo();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var iPwdLen=24;

var confirmWay=LoidPwdInfo.X_HW_RmsRegType;
var var_regtype=LoidPwdInfo.X_HW_RmsRegType;

function LoadFrame()
{
    if (1 == var_regtype)
    {
		document.getElementById('Trshowloid').style.display="none";
		document.getElementById('Trshowpassword').style.display="";
		setText("userid", PwdInfo);
		setText("Loid_text", LoidPwdInfo.Loid);
		setText("Pwd_text", LoidPwdInfo.Password);
    }
    else
	{
		document.getElementById('Trshowloid').style.display="";
		document.getElementById('Trshowpassword').style.display="none";
		setText("userid", PwdInfo);
		setText("Loid_text", LoidPwdInfo.Loid);
		setText("Pwd_text", LoidPwdInfo.Password);
    }
	
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
	if (curUserType != sysUserType )
	{
		setDisable("Loid_text",1);
		setDisable("Pwd_text",1);
		setDisable("username",1);
		setDisable("userid",1);
		setDisable("setbutton",1);
		setDisable("cancel",1);
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
}
function CheckLoidPswForm()
{
    var username = document.getElementById("Loid_text");
    var userid = document.getElementById("Pwd_text");
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

function CheckForm()
{
	 if(CmccRegflag == 1)
	{
		if (1 == confirmWay)
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

function AddSubmitParam(SubmitForm,type)
{
	if(CmccRegflag == 1)
	{
		if (1 == confirmWay)
		{
			SubmitForm.addParameter('x.Password',getValue('userid'));
			SubmitForm.addParameter('x.X_HW_RmsRegType', 1);
		}
		else
		{
			SubmitForm.addParameter('x.UserName',getValue('Loid_text'));	
			SubmitForm.addParameter('x.UserId',getValue('Pwd_text'));
			SubmitForm.addParameter('x.X_HW_RmsRegType', 0);		
		}
	}
	else
	{
		SubmitForm.addParameter('x.UserName',getValue('username'));	
		SubmitForm.addParameter('x.UserId',getValue('userid'));
	}
	
	SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.X_HW_UserInfo'
							 + '&RequestFile=html/ssmp/loid/cmccregloid.asp');	 
}

function CancelValue()
{

    if(CmccRegflag == 1)
	{
		if (var_regtype == 1)
		{
			setRadio("rMethod",2);
			document.getElementById('Trshowloid').style.display="none";
			document.getElementById('Trshowpassword').style.display="";
			confirmWay = 1;
			document.getElementById('prompt_des').innerHTML = "<font style='font-size: 12px;'>您可以通过设置Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。</font>";
			setText("userid", PwdInfo);
			setText("Loid_text", LoidPwdInfo.Loid);
			setText("Pwd_text", LoidPwdInfo.Password);
		}
		else
		{
			setRadio("rMethod",1);
			document.getElementById('Trshowloid').style.display="";
			document.getElementById('Trshowpassword').style.display="none";
			confirmWay = 0;
			document.getElementById('prompt_des').innerHTML = "<font style='font-size: 12px;'>您可以通过设置LOID和Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。</font>";			
			setText("userid", PwdInfo);
			setText("Loid_text", LoidPwdInfo.Loid);
			setText("Pwd_text", LoidPwdInfo.Password);
		}
	}
	else
	{
		setText("username", LoidPwdInfo.Loid);
		setText("userid", LoidPwdInfo.Password);
	}

}
function onClickMethod()
{
    if (1 == getRadioVal("rMethod"))
    {
		document.getElementById('Trshowloid').style.display="";
		document.getElementById('Trshowpassword').style.display="none";
		confirmWay = 0;
		document.getElementById('prompt_des').innerHTML = "<font style='font-size: 12px;'>您可以通过设置LOID和Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。</font>";
    }
    if ((2 == getRadioVal("rMethod")))
    {
		document.getElementById('Trshowloid').style.display="none";
		document.getElementById('Trshowpassword').style.display="";
		confirmWay = 1;
		document.getElementById('prompt_des').innerHTML = "<font style='font-size: 12px;'>您可以通过设置Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。</font>";
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
          <td class="title_01" id="prompt_des" style="padding-left:10px;" width="100%"> <script language="JavaScript" type="text/javascript">	
			if (CmccRegflag == 1)
			{
				if (confirmWay==1)
				{
					document.write("您可以通过设置Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。");
				}
				else
				{
					document.write("您可以通过设置LOID和Password，然后点击&quot;认证&quot;按钮向网管服务器注册并请求业务配置。");
				}
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
  <tr style="text-align: center;line-height: 40px;"> 
	<td id="TrTdSelectMethod">
		<div style="display:inline">
			<input name="rMethod" id="rMethod" type="radio" value="1" checked="true" onclick="onClickMethod()">LOID 
		</div>
		<div style="display:inline; margin-left:60px;">
			<input name="rMethod" id="rMethod" type="radio" value="2" onclick="onClickMethod()">Password 
		</div>
		<script language="javascript">
			if (var_regtype==1)
			{
				setRadio("rMethod",2);
			}
			else
			{
				setRadio("rMethod",1);
			}
		</script>
	</td>
  </tr> 
</table> 
<div id="Trshowpassword" style="display:none">
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
</div>
<div id ="Trshowloid" style="border: 1px solid #757373;"> 
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_bg"> 
	  <tr id="TroldPassword"> 
		<td  class="table_title" align="left" width='25%'>LOID:</td> 
		<td  class="table_right" align="left" colspan="6" width='75%'>
			<input name='Loid_text' type="text" id="Loid_text" maxlength="24"> 
		  <strong style="color:#FF0033">*</strong>
		  <span class="gray"><script>document.write("(字符串最多包含24个英文字符或数字)");</script></span>
		  </td> 
	  </tr>  
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_bg"> 
	  <tr> 
		<td class="table_title"  align="left" width='25%'>Password:</td> 
		<td class="table_right"   align="left" colspan="6" width='75%'>
			 <input name='Pwd_text' type="text" id="Pwd_text">
			 <span class="gray"><script>document.write(" (字符串最多包含10个英文字符或数字)");</script></span>
		</td>
	  </tr> 
	</table>
</div> 
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
