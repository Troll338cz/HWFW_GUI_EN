<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var CuOSGIMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CU_OSGI_MODE);%>';	
var pwdLen = '<%HW_WEB_GetSPEC(SPEC_SSMP_CHKPWD_LENGTH.UINT32);%>'; 

function GetLanguageDesc(Name)
{
    return AccountLgeDes[Name];
}

function stUserInfo(UserName,Passwd,PassMode)
{
    this.UserName = UserName;
    this.Passwd = Passwd;
    this.PassMode = PassMode;	
}
var UserInfo = <%GetAspAccountInfo(stUserInfo);%>;

var sptUserName = UserInfo[0].UserName;
var oldpasswd = UserInfo[0].Passwd;

function CheckPwdIsComplex(str)
{
	var i = 0;
    if (str.length < pwdLen)
	{
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
	if ( i >= 2 )
	{
		return true;
	}
	return false;
}
function LoadFrame()
{
	if( ( window.location.href.indexOf("set.cgi?") > 0) )
	{
	    AlertEx("管理用户的密码修改成功！");
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

function CheckForm()
{
	var oldPassword = document.getElementById("oldPassword");
    var newPassword = document.getElementById("newPassword");
    var cfmPassword = document.getElementById("cfmPassword");

	if (oldPassword.value == "")
	{
		AlertEx(GetLanguageDesc("s0f0f"));
		return false;
	}
	
	if (newPassword.value == "")
	{
		AlertEx(GetLanguageDesc("s0f02"));
		return false;
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
	
	var NormalPwdInfo = FormatUrlEncode(oldPassword.value);
	var CheckResult = 0;

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "../common/CheckAdminPwd.asp?&1=1",
		data :'NormalPwdInfo='+NormalPwdInfo, 
		success : function(data) {
		CheckResult=data;
		}
	});
	
	if (CheckResult != 1)
	{
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

function AddSubmitParam(SubmitForm,type)
{
    var parainfo="";
    parainfo='x.OldPassword=' + FormatUrlEncode(getValue('oldPassword')) + "&";
    parainfo+='x.Password=' + FormatUrlEncode(getValue('newPassword')) + "&";
    parainfo+='x.X_HW_Token=' + getValue('onttoken');
    $.ajax({
         type : "POST",
         async : false,
         cache : false,
         data : parainfo,
         url : "setajax.cgi?x=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.2&RequestFile=html/ssmp/accoutcfg/modifyadmininfo.asp",
         success : function(data) {
                var ResultInfo = JSON.parse(hexDecode(data));
                if (ResultInfo.result == 0) {
                    AlertEx(GetLanguageDesc("s0f0e"));
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
}
</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td class="prompt">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class="title_common"><script language="JavaScript" type="text/javascript">document.write("在本页面上，您可以修改管理用户的登录密码以确保安全和容易记忆。");</script></td> 
        </tr> 
      </table>
	</td> 
  </tr> 
</table> 
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr id="secUsername"> 
    <td class="width_per40">
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF" class="tabal_bg">
            <tr>
                <td class="table_title_pwd width_per60" BindText="s0f08"></td>
                <td class="table_right_pwd"><script language="JavaScript" type="text/javascript">document.write(htmlencode(sptUserName));</script></td>
            </tr>
            <tr id="TroldPassword"> 
                <td class="table_title_pwd width_per60" BindText="s0f13"></td>
                <td class="table_right_pwd"><input name='oldPassword' type="password" autocomplete="off" id="oldPassword" ></td>
            </tr>
            <tr> 
                <td class="table_title_pwd width_per60" BindText="s0f09"></td>
                <td class="table_right_pwd"><input name='newPassword' type="password" autocomplete="off" id="newPassword" ></td> 
            </tr>
            <tr> 
                <td class="table_title_pwd width_per60" BindText="s0f0b"></td>
                <td class="table_right_pwd"><input name='cfmPassword' type='password' autocomplete="off" id="cfmPassword" ></td> 
            </tr>
        </table>  
    </td>
  
    <td class="tabal_pwd_notice width_per60" id="PwdNotice" BindText="s1116a" >
    </td>
  </tr> 
</table> 

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button"> 
    <tr> 
        <td class="table_submit width_per25"></td> 
        <td  class="table_submit"> 
            <input  class="submit" name="MdyPwdApply" id="MdyPwdApply" type="button" onClick="Submit();"  BindText="s0f0c"> 
            <input class="submit" name="MdyPwdcancel" id="MdyPwdcancel" type="button" onClick="CancelValue();"  BindText="s0f0d"> 
            <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">	
        </td> 
    </tr> 
</table> 

<script>
var all = document.getElementsByTagName("td");
for (var i = 0; i < all.length; i++)
{
    var b = all[i];
	var c = b.getAttribute("BindText");
	if(c == null)
	{
		continue;
	}
    b.innerHTML = AccountLgeDes[c];
}

var all = document.getElementsByTagName("input");
for (var i = 0; i < all.length; i++)
{
    var b = all[i];
	var c = b.getAttribute("BindText");
	if(c == null)
	{
		continue;
	}
    b.value = AccountLgeDes[c];
}
var ele = document.getElementById("PwdNotice");
if(CuOSGIMode == "1")
{
	ele.style.color = '#FFFFFF';
}
</script>

</body>
</html>
