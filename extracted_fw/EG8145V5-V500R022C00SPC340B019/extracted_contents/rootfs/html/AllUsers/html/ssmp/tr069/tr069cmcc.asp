<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stCWMP(domain,InformEnb,Interval,Time,URL,Username,Password,CntReqName,CertEnable)
{
    this.domain = domain;
    this.InformEnb = InformEnb;
    this.Interval = Interval;
    this.Time = Time;
    this.URL = URL;
    this.Username = Username;
    this.Password = Password;
    this.CntReqName = CntReqName;
    this.CntReqPwd = '********************************';
    this.CertEnable  = CertEnable ;
}

function stManageFlag(ManageFlag)
{
    this.ManageFlag = ManageFlag;
}
 
var UnChangeURL = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGEURL);%>'
var UnChangeUser = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGEUSER);%>'
var UnChangePeriod = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGEPERIOD);%>'
var DisableACSApply = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_DISABLEACSAPPLY);%>'
var UnchangeTimePeriod = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_UNCHANGETIME);%>'
var UnSupportIpv6 = '<%HW_WEB_GetFeatureSupport(FT_CWMP_SUPPORT_IPV6);%>'

var CfgMode ='<%HW_WEB_GetCfgMode();%>';

var setpasswordflag = 0;

var stCWMPs = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.ManagementServer,PeriodicInformEnable|PeriodicInformInterval|PeriodicInformTime|URL|Username|Password|ConnectionRequestUsername|X_HW_EnableCertificate,stCWMP);%>;

var cwmp = stCWMPs[0];

function LoadFrame()
{
	if ( null != cwmp )
	{
	    setCheck('PeriodicInformEnable',cwmp.InformEnb);
	    setText('PeriodicInformInterval',cwmp.Interval);
	    setText('PeriodicInformTime',cwmp.Time);
	    setText('URL',cwmp.URL);
	    setText('Username',cwmp.Username);
	    setText('Password',cwmp.Password);
	    setText('ConnectionRequestUsername',cwmp.CntReqName);
	    setText('ConnectionRequestPassword',cwmp.CntReqPwd);
	    setCheck('CertificateEnable', cwmp.CertEnable);
		if ('0' == cwmp.InformEnb)
		{
			document.getElementById("PeriodicInformInterval").disabled = true;
			document.getElementById("PeriodicInformTime").disabled = true;
		}
	}
	
	if (1 == UnChangeURL)
	{
		setDisable('URL',1);
	}
	if (1 == UnChangeUser)
	{
		setDisable('Username',1);
		setDisable('Password',1);
		setDisable('ConnectionRequestUsername',1);
		setDisable('ConnectionRequestPassword',1);
	}
	if (1 == UnChangePeriod)
	{
		setDisable('PeriodicInformEnable',1);
		setDisable('PeriodicInformTime',1);
		setDisable('PeriodicInformInterval',1);
	}
	if (1 == DisableACSApply)
	{
		setDisable('ACSbtnApply',1);
        setDisable('ACScancelValue',1);
	}

	if (1 == UnchangeTimePeriod)
	{
		setDisable('PeriodicInformInterval',1);
	}
	
}

function CheckTime(str_date)
{
	var date_reg = new RegExp("^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$");
	var time_reg = new RegExp("^((0[0-9])|(1[0-9])|(2[0-3])):([0-5][0-9]):([0-5][0-9])(Z?|(([+-](0[0-9]|1[0-2]):00)|([+]13:00))?)$");
	
	var date_reg2 = new RegExp("^(?:(?!0000)[0-9]{4}(?:(?:0[1-9]|1[0-2])(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])(?:29|30)|(?:0[13578]|1[02])31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)0229)$");
	var time_reg2 = new RegExp("^((0[0-9])|(1[0-9])|(2[0-3]))([0-5][0-9])([0-5][0-9])((([+-](0[0-9]|1[0-2])(00)?)|([+]13(00)?))?)$");

	date_time = str_date.split("T");
	if (date_time.length != 2)
	{
		return false;
	}
	
	date_time_type = false;
	date_time_type2 = false;

	if ((date_reg.test(date_time[0])) && (time_reg.test(date_time[1])))
	{
		date_time_type = true;
	}
	
	if ((date_reg2.test(date_time[0])) && (time_reg2.test(date_time[1])))
	{
		date_time_type2 = true;
	}
	
	if ((date_time_type == false) && (date_time_type2 == false))
	{
		return false;
	}

	return true;
}

function isSafeCharSN(val)
{
    if ( ( val == '<' )
      || ( val == '>' )
      || ( val == '\'' )
      || ( val == '\"' )
      || ( val == ' ' )
      || ( val == '%' )
      || ( val == '#' )
      || ( val == '{' )
      || ( val == '}' )
      || ( val == '\\' )
      || ( val == '|' )
      || ( val == '^' )
      || ( ( val == '[' ) && ( 0 == UnSupportIpv6 ) )
      || ( ( val == ']' ) && ( 0 == UnSupportIpv6 ) ) )
	{
	    return false;
	}
	
    return true;
}

function isSafeStringSN(val)
{
    if ( val == "" )
    {
        return false;
    }

    for ( var j = 0 ; j < val.length ; j++ )
    {
        if ( !isSafeCharSN(val.charAt(j)) )
        {
            return false;
        }
    }

    return true;
}


function isNum(str)
{
    var valid=/[0-9]/;
    var i;
    for(i=0; i<str.length; i++)
    {
        if(false == valid.test(str.charAt(i)))
        {
        	return false;
        }
    }
    return true;
}

function isNull( str )
{
    if ( str == "" ) return true;
    var regu = "^[ ]+$";
    var re = new RegExp(regu);
    return re.test(str);
}

function checkUrlPort(urlinfo)
{
    var url_values = urlinfo.split("://");

	if (url_values.length <= 1) 
	{
		var port_value = urlinfo.split(":");

		if (port_value.length <= 1)
		{
			return true;
		}
	    else
		{
			var othervalue = port_value[port_value.length-1].split("/");
			
			if (othervalue.length == 0)
		    {
				return true;
			}

			if(true == isNull(othervalue[0]))
			{
				return false;
			}
			
			if(false == isNum(othervalue[0]))
			{
				return false;
			}
			
			var port = parseInt(othervalue[0], 10);
	    	if ((port >= 65536) || ( port < 1))
			{
				return false;
			}
			return true;
		}
	}
    else
    {
		var port_value = url_values[url_values.length-1].split(":");
		if (port_value.length <= 1)
		{
			return true;
		}

		var othervalue = port_value[port_value.length-1].split("/");
		if (othervalue.length == 0)
		{
			return true;
		}
		
		if(true == isNull(othervalue[0]))
		{
			return false;
		}
			
		if(false == isNum(othervalue[0]))
		{
			return false;
		}
		
		var port = parseInt(othervalue[0], 10);
		if ((port >= 65536) || ( port < 1))
		{
			return false;
		}
    }
    
    return true;
}


function CheckForm(type)
{   
	with(document.getElementById("ConfigForm"))
    {
        if (URL.value == '')
        {
            AlertEx("请输入URL。");
            URL.focus();
            return false;
        }
        
        if (!isSafeStringSN(URL.value))
        {
            if (0 == UnSupportIpv6)
            {
                AlertEx('RMS不能包含空格和下列字符： \"<, >, \', \", {, }, [, ], %, \\, ^, #, |\"。');
            }
            else
            {
                AlertEx('RMS不能包含空格和下列字符： \"<, >, \', \", {, }, %, \\, ^, #, |\"。');
            }
            URL.focus();
            return false;
        }
        
		if (!checkUrlPort(URL.value))
        {
        	AlertEx('RMS URL包含无效的端口。');
            URL.focus();
            return false;
        }
        
        if ('' != isValidAscii(URL.value))
        {
        	AlertEx('RMS URL中包含非ASCII字符。');
            URL.focus();
            return false;
		}
		
        if (getCheckVal("PeriodicInformEnable") == 1)
        {
            if ((PeriodicInformInterval.value == '') || (isPlusInteger(PeriodicInformInterval.value) == false))
            {
                AlertEx("无效的周期通知时间间隔。");
                PeriodicInformInterval.focus();
                return false;
            }
            
            var info = parseInt(PeriodicInformInterval.value,10);
            if (info < 1 || info > 2147483647)
            {
                AlertEx("无效的周期通知时间间隔。");
                PeriodicInformInterval.focus();
                return false;
            }

            if (getValue('PeriodicInformTime') != '' && CheckTime(getValue('PeriodicInformTime')) == false)
    		{
    			AlertEx("无效的周期通知时间。");
    			return false;
    		}
        }       
        
        if (Username.value == '')
        {
            AlertEx("请输入RMS用户名。");
            Username.focus();
            return false;
        }
        if (isValidString(Username.value) == false )
        {
            AlertEx("无效的RMS用户名。");
            Username.focus();
            return false;
        }
        
        if (Password.value == '')
        {
            AlertEx("请输入RMS密码。");
            Password.focus();
            return false;
        }       
        if (isValidString(Password.value) == false )
        {
            AlertEx("无效的RMS密码。");
            Password.focus();
            return false;
        }
        
        if (ConnectionRequestUsername.value == '')
        {
            AlertEx("请输入请求连接的用户名。");
            ConnectionRequestUsername.focus();
            return false;
        }
        if (isValidString(ConnectionRequestUsername.value) == false )
        {
            AlertEx("无效的请求用户名。");
            ConnectionRequestUsername.focus();
            return false;
        }
        
        if ('' == ConnectionRequestPassword.value)
        {
            AlertEx("请输入请求连接的用户密码。");
            ConnectionRequestPassword.focus();
            return false;
        }
        
        if (isValidString(ConnectionRequestPassword.value) == false )
        {
            AlertEx("无效的请求连接密码。");
            ConnectionRequestPassword.focus();
            return false;
        }
    }
    
    return true;
}

function ClickPeriodicInformEnable()
{
	var itemPeriodicInformEnable = document.getElementById("ConfigForm").PeriodicInformEnable;
	var itemPeriodicInformInterval = document.getElementById("ConfigForm").PeriodicInformInterval;
	var itemPeriodicInformTime = document.getElementById("ConfigForm").PeriodicInformTime;
    
    if (true == itemPeriodicInformEnable.checked) {
       //这个广东特殊需求，沟选后也不让修改 
    		if ( 'GDCT' == CfgMode.toUpperCase() || 'GDGCT' == CfgMode.toUpperCase())	
	    	{
	    		itemPeriodicInformInterval.disabled = true;
	    	}
	    	else
    		{
    			itemPeriodicInformInterval.disabled = false;
    		}
    		
        itemPeriodicInformTime.disabled = false;
    } else {
        itemPeriodicInformInterval.disabled = true;
        itemPeriodicInformTime.disabled = true;
    }
}

function AddSubmitParam(SubmitForm,type)
{
    SubmitForm.addParameter('x.PeriodicInformEnable',getCheckVal('PeriodicInformEnable'));
    if (getCheckVal('PeriodicInformEnable') == 1)
    {
        SubmitForm.addParameter('x.PeriodicInformInterval',parseInt(getValue('PeriodicInformInterval'),10));
        SubmitForm.addParameter('x.PeriodicInformTime',getValue('PeriodicInformTime'));
    }
    SubmitForm.addParameter('x.URL',getValue('URL'));
    SubmitForm.addParameter('x.Username',getValue('Username'));
    SubmitForm.addParameter('x.Password',getValue('Password'));
    SubmitForm.addParameter('x.ConnectionRequestUsername',getValue('ConnectionRequestUsername'));
	
	if (getValue('ConnectionRequestPassword') != '********************************')
    {   
		SubmitForm.addParameter('x.ConnectionRequestPassword',getValue('ConnectionRequestPassword'));   	
    }
	
    SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.ManagementServer'
                         + '&RequestFile=html/ssmp/tr069/tr069cmcc.asp');
    setDisable('ACSbtnApply',1);
    setDisable('ACScancelValue',1);
}

function CancelConfig()
{
	if ( null != cwmp )
	{
	    setCheck('PeriodicInformEnable',cwmp.InformEnb);
	    setText('PeriodicInformInterval',cwmp.Interval);
	    setText('PeriodicInformTime',cwmp.Time);
	    setText('URL',cwmp.URL);
	    setText('Username',cwmp.Username);
	    setText('Password',cwmp.Password);
	    setText('ConnectionRequestUsername',cwmp.CntReqName);
	    setText('ConnectionRequestPassword',cwmp.CntReqPwd);
		if ('0' == cwmp.InformEnb)
		{
			document.getElementById("PeriodicInformInterval").disabled = true;
			document.getElementById("PeriodicInformTime").disabled = true;
		}
	}
}

function CheckFormPassword(type)
{	
	with(document.getElementById("ConfigForm"))
    {
        if(certPassword.value.length > 32)
        {
            AlertEx("密码的长度必须在1~32个字符之间。");
            setText('certPassword', '');
			setText("CfmPassword", "");
            return false;
        }
        
        if(certPassword.value != CfmPassword.value)
        {
            AlertEx("确认密码不匹配。");
			setText("certPassword", "");
			setText("CfmPassword", "");
            return false;
        }
		
		if (certPassword.value != '')
		{
		    setpasswordflag = 1;
		}
    }
    return true;
}

function VerifyFile(FileName)
{
	var File = document.getElementsByName(FileName)[0].value;
    if (File.length == 0)
    {
        AlertEx('请选择文件路径。');
        return false;
    }
    if (File.length > 128)
    {
        AlertEx('文件的路径长度必须小于128个字符。');
        return false;
    }
	
    try
    {
		if(window.ActiveXObject) {
			fso = new ActiveXObject("Scripting.FileSystemObject");
			try
			{
				var FileSize = fso.GetFile(File).Size;
				var MaxImageFileSize = (1024)*(1024)*(1);
				if (FileSize > MaxImageFileSize)
				{
					AlertEx('文件太大'+FileSize);
					return false;
				}
			}
			catch (e)
			{
				AlertEx('"' + File + '"无效的文件或者文件不存在。');
				return false;
			}
		}
    }
    catch (e)
    {
    }

    return true;	
}

function uploadCert()
{
	var uploadForm = document.getElementById("fr_uploadImage");
	if (VerifyFile('browse') == false)
	{
	   return;
	}	
	top.previousPage = '/html/ssmp/reset/reset.asp';
	setDisable('btnSubmit',1);
	uploadForm.submit();
}

function AddSubmitImportcert()
{

    var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_EnableCertificate',getCheckVal('CertificateEnable'));  
    Form.setAction('set.cgi?x=InternetGatewayDevice.ManagementServer'
                         + '&RequestFile=html/ssmp/tr069/tr069cmcc.asp');
                         
    setDisable('PWDbtnApply',1);
    setDisable('PWDcancelValue',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
	
	if (1 == setpasswordflag )
	{
	    setpasswordflag = 0;
	    AlertEx('私钥密码修改成功，新密码重启后生效。');
	}
}

function CancelConfigPwd()
{
    if ( null != cwmp )
	{
	    setCheck('CertificateEnable', cwmp.CertEnable);
	}
	
    setText("certPassword", "");
	setText("CfmPassword", "");
}

</script>
<script language="JavaScript" type="text/javascript">
function fchange() {
	var ffile = document.getElementById("f_file");
	var tfile = document.getElementById("t_file");
	ffile.value = tfile.value;
}

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<form id="ConfigForm"> 
<div class="title_with_desc">RMS参数设置</div>
<div class="title_01"  style="padding-left:10px;" width="100%">如果TR069的自动连接功能是使能的，您可以设置终端的RMS变量参数。</div>
<div class="func_spread"></div>

  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg"> 
    <tr align="left"> 
      <td class="table_title" width="30%" align="left">使能周期通知:</td> 
      <td class="table_right" colspan="8" align="left"> <input  id='PeriodicInformEnable' name='PeriodicInformEnable'  value='1' type='checkbox' onclick='ClickPeriodicInformEnable()'> </td> 
    </tr> 
    <tr> 
      <td  class="table_title" align="left">周期通知时间间隔:</td> 
      <td class="table_right" colspan="8"> <input name='PeriodicInformInterval' type='text' id="PeriodicInformInterval" size="20"  maxlength="10"> 
        <strong style="color:#FF0033">*</strong> <span class="gray">[1 - 2147483647](s)</span> </td> 
    </tr> 
    <tr> 
      <td  class="table_title" align="left">周期通知时间:</td> 
      <td class="table_right" colspan="8"> <input name='PeriodicInformTime' type='text' id="PeriodicInformTime" size="20"  maxlength="25"> 
        <span class="gray">yyyy-mm-ddThh:mm:ss(例如:2009-12-20T12:23:34)</span></td> 
    </tr> 
    <tr> 
      <td  class="table_title" align="left">RMS URL:</td> 
      <td class="table_right" colspan="8"> <input name='URL' type='text' id="URL" size="20" maxlength="256"> 
        <strong style="color:#FF0033">*</strong> </td> 
    </tr> 
    <tr> 
      <td  class="table_title" align="left">RMS用户名:</td> 
      <td class="table_right" colspan="8"> <input name='Username' type='text' id="Username" size="20" maxlength="256"> 
        <strong style="color:#FF0033">*</strong> </td> 
    </tr> 
    <tr> 
      <td  class="table_title" align="left">RMS密码:</td> 
      <td class="table_right" colspan="8" align="left"> <input name='Password' autocomplete='off' type='password' id="Password" size="20" maxlength="256"> 
        <strong style="color:#FF0033">*</strong><span class="gray">(密码的长度必须在1~256位字符之间)</span> </td> 
    </tr> 
    <tr> 
      <td  class="table_title" align="left">请求连接的用户名:</td> 
      <td class="table_right" colspan="8"> <input name='ConnectionRequestUsername' type='text' id="ConnectionRequestUsername" size="20" maxlength="256"> 
        <strong style="color:#FF0033">*</strong> </td> 
    </tr> 
    <tr> 
      <td  class="table_title" align="left">请求连接的密码:</td> 
      <td class="table_right" colspan="8"> <input name='ConnectionRequestPassword' autocomplete='off' type='password' id="ConnectionRequestPassword" size="20"  maxlength="256"> 
        <span class="gray"><strong style="color:#FF0033">*</strong> (密码的长度必须在1~256位字符之间)</span> </td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">  
      <td  class="table_submit" width="30%"></td> 
      <td  class="table_submit" align="left"> <input  class="submit" name="btnApply" id= "ACSbtnApply" type="button" value="应用" onClick="Submit();"> 
        <input class="submit" name="cancelValue" id="ACScancelValue" type="button" value="取消" onClick="CancelConfig();"> </td> 
    </tr> </table> 
 <div class="func_spread"></div>
 
<div class="title_with_desc">使能证书认证</div>
<div class="title_01"  style="padding-left:10px;" width="100%">如果设备想要通过SSL方式连接RMS，您可以使能证书认证。</div>
<div class="func_spread"></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_bg"> 
    <tr> 
      <td  class="table_title" width="30%" align="left">使能证书认证:</td> 
      <td  class="table_right" align="left"> <input  id='CertificateEnable' name='CertificateEnable'  value='1' type='checkbox'> </td> 
    </tr> 
  </table> 
  <table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">  
      <td  class="table_submit" width="30%"></td> 
      <td  class="table_submit" align="left"> <input  class="submit" name="btnApply" id= "PWDbtnApply" type="button" value="应用" onClick="AddSubmitImportcert();"> 
        <input class="submit" name="cancelValue" id="PWDcancelValue" type="button" value="取消" onClick="CancelConfigPwd();"> </td> 
    </tr> </table> 
</form> 
<form action="certification.cgi?RequestFile=html/ssmp/reset/reset.asp" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage"> 
  <div> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_head"> 
      <tr> 
        <td  width="100%"  align="left" >导入证书文件</td> 
      </tr> 
    </table> 
    <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
      <tr> 
        <td></td> 
      </tr> 
    </table> 
    <table> 
      <tr> 
        <td valign="middle">证书文件:</td> 
        <td valign="top"> <div class="filewrap"> 
            <div class="fileupload"> 
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
              <input type="text" id="f_file" autocomplete="off" readonly="readonly" /> 
              <input type="file" name="browse" id="t_file" size="1" onchange="fchange();" /> 
              <input id="btnBrowse" type="button" class="submit" value="浏览..." /> 
            </div> 
          </div></td> 
        <td align="left" valign="top"> <input class="submit" name="btnSubmit" id="btnSubmit" type='button' onclick='uploadCert();' value="导入证书" /> </td> 
      </tr> 
    </table> 
  </div> 
  <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td></td> 
    </tr> 
  </table> 
</form> 
</body>
</html>
