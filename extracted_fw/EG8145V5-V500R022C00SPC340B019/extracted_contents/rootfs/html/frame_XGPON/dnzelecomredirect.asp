<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<meta http-equiv="Pragma" content="no-cache" />
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
<title></title>
<style type="text/css">
</style>
<script language="JavaScript" type="text/javascript">
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var timer = [];

function Connect3G()
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "/wanbackup.cgi?RequestFile=redirect.asp",
		data : getDataWithToken('ConnectionControl=1'),
		success : function(data) {
			CheckResult=data;
		}
	});	

	setDisplay('resetButton', 0);
	setDisplay('connectIng', 1);
	timer.push(setInterval("checkRadioWan();", 60000));  
}

function checkRadioWan()
{	
	var radiowanStatus = null; 

	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : '/asp/GetRadioWanStatus.asp',
	success : function(data) {
		radiowanStatus = data;
	}
	});
	
	setDisplay('connectIng', 0);
	if (null != radiowanStatus)
	{
		if (radiowanStatus == "Connected")
		{
			setDisplay('connectSucc', 1);
		}
		else
		{
			setDisplay('connectFail', 1);
		}
	}
	else
	{
		setDisplay('connectSucc', 1);
	}
}

function stCardCfgInfo(domain,EnablePin,PinStates)
{
	this.domain = domain;
	this.EnablePin = EnablePin;
	this.PinStates = PinStates;
}

function Show3GConnectiongButton()
{
	var SwitchModeEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_RadioWanPS.1.Enable);%>';
	var SwitchMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_RadioWanPS.1.SwitchMode);%>';
	var stCardCfgInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage, EnablePin|PinStates, stCardCfgInfo);%>;
	CardCfgInfo = stCardCfgInfos[0];

	if ('DNZTELECOM2WIFI' != CfgModeWord.toUpperCase())
	{
		return false;
	}

	if (CardCfgInfo.EnablePin != 1)
	{
		return false;
	}
	if (CardCfgInfo.PinStates != 1)
	{
		return false;
	}

	if (SwitchModeEnable != "1")
	{
		return false;
	}

	if (SwitchMode != "ManualSwitch")
	{
		return false;
	}
	
	return true;
}

function LoadFrame()
{ 
	if (true == Show3GConnectiongButton())
	{
		setDisplay('resetButton', 1);
		setDisplay('connectFail', 0);
		setDisplay('connectIng', 0);
		setDisplay('connectSucc', 0);
	}
	else
	{
		setDisplay('resetButton', 0);
		setDisplay('connectFail', 1);
		setDisplay('connectIng', 0);
		setDisplay('connectSucc', 0);
	}
}
</script>
 </head>
 <body class="mainbody" onLoad="LoadFrame();">
 <br>
<div id="connectFail" align="center">
<p>Your device cannot connect to the Internet. Please contact your Internet service provider (ISP).</p>
<p>
<script language="JavaScript" type="text/javascript">
var LanHostInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress,stLanHostInfo);%>;
var LanHostInfo = LanHostInfos[0]; 

function stLanHostInfo(domain,ipaddr)
{
    this.domain = domain;
    this.ipaddr = ipaddr;
}

document.write("or configure advanced settings by accessing <a href=\"http://"+ LanHostInfo.ipaddr +"\">Internet Settings</a>.");	
</script>	
</p>
</div>
<div id="connectIng" align="center">
<p>Please wait one minute. Searching for networks...</p>
</div>
<div id="connectSucc" align="center">
<p>Internet connected.</p>
</div>
<div id="resetButton">
<table width="50%" height="35" cellpadding="0" cellspacing="0" align="center">     
<tr>
	<td  class="table_right" class="align_left">
	Your datacard is ready, you can access internet now.
	</td>
</tr>	
<tr>
	<td  class="table_right" class="align_left">
	<font color="red">Warning: Enabling internet connection via 3G USB data stick will incur data charges.</font>
	</td>
</tr>		
 <tr>
    <td  class="table_right" class="align_left">
    <input name="btnReboot" id="btnReboot" type="button" class="CancleButtonCss buttonwidth_150px_250px" value="Restart 3G" onClick="Connect3G();"/> 
    <script type="text/javascript">
    document.getElementsByName('btnReboot')[0].value = "Connect";    
    </script>
    </td>
</tr>
</table>
</div>	
 </body>
</html>
