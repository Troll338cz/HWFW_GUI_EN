<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<title>Activation ID</title>

<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>

<script language="JavaScript" type="text/javascript">
var OnlineStatus ='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WRPService.X_HW_OnlineStatus);%>';
var Language = '<%HW_WEB_GetCurrentLanguage();%>';

var br0Ip = '<%HW_WEB_GetBr0IPString();%>';
var httpport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';
if (window.location.href.indexOf(br0Ip) == -1)
{
	window.location = 'http://' + br0Ip +':'+ httpport +'/Activation';
}


if( OnlineStatus == "Online" ||  OnlineStatus == "online")
{			
	window.location="/login.asp";
}

function IsIEBrower(num) {
    var ua = navigator.userAgent.toLowerCase();
    var isIE = ua.indexOf("msie")>-1;
    var safariVersion;
    if(isIE){
        safariVersion =  ua.match(/msie ([\d.]+)/)[1];
        var sa = parseInt(safariVersion);
        if(safariVersion <= num ){
           alert("Your browser version is outdated (IE 6, IE 7, and IE 8 are not supported). You must upgrade your browser to IE 9 or later. ");
        }
    }
}





function Cancel()
{
     window.location='http://' + br0Ip;
}

function ChangeHextoAscii(hexpasswd)
{
    var str;
	var len = 0;
	
	len = hexpasswd.length;

	if (0 != len%2)
	{
	    hexpasswd += "0";
	}
	
    str = hexpasswd.replace(/[a-f\d]{2}/ig, function(m){
    return String.fromCharCode(parseInt(m, 16));});

    return str;
}

function ChangeAsciitoHex(passwd)
{
    var hexstr = "";
	var temp = "";
	var code = 0;
	for (var i = 0; i < passwd.length; i++)
	{
	     code = parseInt(passwd.charCodeAt(i));
		 if (code < 16)
		 {
		     hexstr += "0";
			 hexstr += code.toString(16);
		 } 
		 else
		 {
		     hexstr += code.toString(16);
		 }
	}
	
	return hexstr;	
}

function SubmitForm() {
	var Username = document.getElementById('txt_Username');
	var Password = document.getElementById('txt_Password');
	var ActivationID = document.getElementById('txt_ActivationID');
	var appName = navigator.appName;
	var version = navigator.appVersion;
	var password;

	if (appName == "Microsoft Internet Explorer")
	{
		var versionNumber = version.split(" ")[3];
		if (parseInt(versionNumber.split(";")[0]) < 6)
		{
			alert("We cannot support the IE version which is lower than 6.0.");
			return false;
		}
	}

	if (Username.value == "") {
		alert("Account is a required field.");			
		Username.focus();
		return false;
	}

	if (Password.value == "") {
		alert("Password is a required field.");
		Password.focus();
		return false;
	}
	
	if (ActivationID.value == "") {
		alert("ActivationID is a required field.");
		ActivationID.focus();
		return false;
	}
		
	if ( ActivationID.value.length > 10) {
		alert("The ActivationID must be a string of 10 pairs of hexadecimal characters at most.");
		ActivationID.focus();
		return false;
	}

	var cnt;

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/asp/GetRandCount.asp',
		success : function(data) {
			cnt = data;
		}
		});

	var Form = new webSubmitForm();

	var cookie2 = "Cookie=body:" + "Language:" + Language + ":" + "id=-1;path=/";
	Form.addParameter('UserName', Username.value);
	Form.addParameter('PassWord', base64encode(Password.value));
	
	
	password = ChangeAsciitoHex(ActivationID.value);

	Form.addParameter('x.X_HW_PonHexPassword', password);
	Form.addParameter('x.X_HW_ForceSet', 1);
	
	document.cookie = cookie2;
	Username.disabled = true;
	Password.disabled = true;
	Form.addParameter('x.X_HW_Token', cnt);

	Form.setAction('AisLoginAuth.cgi?'+'x=InternetGatewayDevice.DeviceInfo');
	
	
	Form.submit();
	return true;
}
</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();">
<table width="100%" height="10%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="prompt">
        </td>
    </tr>
</table>

<form>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg" align="center">
	<tr width="100%">
		<td height="37"  width="37%"></td>
		<td height="37"  width="26%">
			<table width="100%">
				<tr width="100%">
					<td class="whitebold" style="font-size:20px;" height="37" align="right" width="40%" id="account">User</td>
					<td class="whitebold" style="font-size:20px;" height="37" align="center" width="3%">:</td>
					<td width="57%" align="left"> <input style="font-size:20px;font-family:Tahoma,Arial;" height="37" id="txt_Username" class="input_login" name="txt_Username" type="text" maxlength="31"> </td>
				</tr>				
			</table>
			</td>
		<td height="37"  width="37%"></td>
		  </tr>
	<tr width="100%">
		<td height="37"  width="37%"></td>
		<td height="37"  width="26%">
			<table width="100%">
				<tr width="100%">
					<td class="whitebold" style="font-size:20px;" height="37" align="right" width="40%" id="Password">Password</td>
					<td class="whitebold" style="font-size:20px;" height="37" align="center" width="3%" >:</td>
					<td width="57%" align="left"><input style="font-size:20px;font-family:Tahoma,Arial;" height="37" id="txt_Password" class="input_login" name="txt_Password" type="password" maxlength="127" autocomplete="off"></td>
				</tr>				
			</table>
			</td>
		<td height="37"  width="37%"></td>
		  </tr>
	<tr width="100%">
		<td height="37"  width="37%"></td>
		<td height="37"  width="26%">
			<table width="100%">
				<tr width="100%">
					<td class="whitebold" style="font-size:20px;" height="37" align="right" width="40%" id="txt_Activation">Activation ID</td>
					<td class="whitebold" style="font-size:20px;" height="37" align="center" width="3%">:</td>
					<td width="57% align="left"><input style="font-size:20px;font-family:Tahoma,Arial;" height="37" id="txt_ActivationID" class="input_login" name="txt_ActivationID" type="password" maxlength="10" autocomplete="off"></td>
		  </tr>
		 		 
		</table>		
		</td>
		<td height="37"  width="37%"></td>
		</tr>
	<tr width="100%">
		<td height="37"  width="37%"></td>
		<td height="37"  width="26%">
			<table width="100%" >
				<tr width="100%">
					<td class="whitebold" style="font-size:20px;" height="37" align="right" width="40%"></td>
					<td class="whitebold" style="font-size:20px;" height="37" align="center" width="3%"></td>
					<td width="57% align="left">
						<table width="100%">
							<tr width="100%">
								<td width="49%" align="left" class="whitebold">
									<button style="font-size:20px;font-family:Tahoma,Arial;" height="37" id="button" class="submit" name="Submit" onClick="SubmitForm();" type="button">Submit</button>
								</td>			
								<td width="2%" align="center"></td>
								<td width="49%" align="left" class="whitebold">
									<button style="font-size:20px;font-family:Tahoma,Arial;" height="37" id="button" class="submit" name="Submit" onClick="Cancel();" type="button">Cancel</button>
								</td>
							</tr>
					</table> 		
				</td>
				</tr>				
			</table>
			</td>
			<td height="37"  width="37%"></td>
		</tr>
	<tr width="100%">
		<td height="37"  width="37%"></td>
		<td class="whitebold" style="color:red;font-size:12px;font-family:Arial;" height="37" align="center" width="26%" id="Password">Registration failed. Please try again.</td>	
		<td height="37"  width="37%"></td>
	</tr>
</table>



</form>
</body>
</html>





