<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<title>ActivationID</title>

<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>

<script language="JavaScript" type="text/javascript">
var OnlineStatus ='<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_WRPService.X_HW_OnlineStatus);%>';
var Language = '<%HW_WEB_GetCurrentLanguage();%>';


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
	 window.location="/login.asp";
}


</script>
</head>

<body  class="mainbody" >
<table width="100%" height="10%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="prompt">
        </td>
    </tr>
</table>

<form>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
    <tr>
      <td align="center" height="65"> 
	    <table border="0" cellpadding="0" cellspacing="0" class="tblcalss" height="65" width="45%" style="font-size:20px;"> 
		  <tr>
			<td class="whitebold" style="font-size:20px;" height="37" align="center" width="20%" id="account">ActivationID is recorded successfully. </td>
			
		  </tr>
		 		 
		</table>		
		</td>
		</tr>
		
</table> 

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
			
		<tr>			
		
			<td class="whitebold" style="font-size:20px;" height="37" align="center" width="7%"> 
				<button style="font-size:20px;font-family:Tahoma,Arial;" height="37" id="button" class="submit" name="Submit" onClick="Cancel();" type="button">Return</button>&nbsp;
			</td>			
			
								
		</tr>
							
		
</table> 		
</form>
</body>
</html>





