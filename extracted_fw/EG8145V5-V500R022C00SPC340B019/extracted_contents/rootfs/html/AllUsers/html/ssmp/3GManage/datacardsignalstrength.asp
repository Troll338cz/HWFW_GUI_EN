<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" type="text/javascript">
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
function stCardCfgInfo(domain,EnablePin,DataCardVendor,DataCardSwVesion,DataCardHdVesion,Mode,WorkMode,PinStates,PinRemainTimes,PukRemainTimes)
{
	this.domain = domain;
	this.EnablePin = EnablePin;
	this.DataCardVendor = DataCardVendor;
	this.DataCardSwVesion = DataCardSwVesion;
	this.DataCardHdVesion = DataCardHdVesion;
	this.Mode = Mode;
	this.WorkMode = WorkMode;
	this.PinStates = PinStates;
	this.PinRemainTimes = PinRemainTimes;
	this.PukRemainTimes = PukRemainTimes;
}

function stSignalStrength(domain,SignalStrength)
{
	this.domain = domain;
	this.SignalStrength = SignalStrength;
}


var stCardCfgInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_DataCardManage, EnablePin|DataCardVendor|DataCardSwVesion|DataCardHdVesion|Mode|WorkMode|PinStates|PinRemainTimes|PukRemainTimes, stCardCfgInfo);%>;
CardCfgInfo = stCardCfgInfos[0];
var stSignalStrength = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Radio_WAN_Stats, SignalStrength, stSignalStrength);%>;
SignalInfo = stSignalStrength[0];

function GetLanguageDesc(Name)
{
    return XGManageDes[Name];
}
function LoadFrame()
{ 	
	if ((CardCfgInfo == null) || (CardCfgInfo.PinStates == 4) || (CardCfgInfo.PinStates == 5) ||
	    (CardCfgInfo.PinStates == 6) || (CardCfgInfo.PinStates == 7)) {
		document.getElementById('signalstrength').innerHTML = '--';
	} else {
		document.getElementById('signalstrength').innerHTML = htmlencode(SignalInfo.SignalStrength);
	}
}
</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<div> 
  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("RSSIInfo", GetDescFormArrayById(XGManageDes, "s0102"), GetDescFormArrayById(XGManageDes, "s0103"), false);
</script>
<div class="title_spread"></div>
<div class="func_title" BindText="s2100"></div>
    <table class="tabal_noborder_bg" width="100%" height="5" border="0" cellpadding="0" cellspacing="1" >
	<script type="text/javascript">
		document.write('<tr class="table_title" > <td width="200px" BindText="s2124"></td> <td id="signalstrength"></td> </tr>');
	</script>
  </table>

</div>  
<div class="func_spread"></div>
</body>

<script>
ParseBindTextByTagName(XGManageDes, "td",    1);
ParseBindTextByTagName(XGManageDes, "div",   1);
</script>

</html>
