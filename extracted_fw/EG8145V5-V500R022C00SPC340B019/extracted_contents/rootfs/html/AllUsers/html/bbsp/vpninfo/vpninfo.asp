<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Configuration</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<style type="text/css">
	.Select
    {
        width:150px;  
    }

    .TextBox
    {
        width:150px;  
    }
</style>
	
<script language="JavaScript" type="text/javascript">

function GetStateName(State)
{
    if("UP" == State.toUpperCase())
	{
	    return L2TP_info_language['bbsp_l2tp_stateup'];
	}
	else if("DOWN" == State.toUpperCase())
	{
	    return L2TP_info_language['bbsp_l2tp_statedn'];
	}
	else
	{
	    return '---';
	}
}

function GetEnableState(Enable)
{
    if("1" == Enable)
	{
	    return L2TP_info_language['bbsp_l2tp_enable'];
	}
	else if("0" == Enable)
	{
	    return L2TP_info_language['bbsp_l2tp_disable'];
	}
	else
	{
	    return '---';
	}
}

function L2TPConfigInfo (domain,State,Enable,Username,UserId,ServerAddress)
{
	this.domain = domain;
	this.State = GetStateName(State);
	this.Enable = GetEnableState(Enable);
	this.Username = Username;
	this.UserId = UserId;
	this.ServerAddress = ServerAddress;
	this.Password = (domain == "")?"---":"********";
}

var L2TPConfigInfoArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_L2TPTunnel.{i},State|Enable|Username|UserId|ServerAddress,L2TPConfigInfo);%>;
var L2TPPara=new L2TPConfigInfo("", "---", "---", "---", "---","---","---");	

function initL2TPConfig()
{
	for(var i=0;i<L2TPConfigInfoArray.length-1;i++)
	{
		if(L2TPConfigInfoArray[i].UserId=="AWIFI") 
		{
			L2TPPara=L2TPConfigInfoArray[i];
		}
	}
}

function SetCurrentItemInfo()
{	
	$("#L2TPStatus").text(L2TPPara.State);	
    $("#L2TPStartClient").text(L2TPPara.Enable);
    $("#L2TPServerAddr").text(L2TPPara.ServerAddress); 	
	$("#L2TPUsername").text(L2TPPara.Username);
	$("#L2TPPassword").text(L2TPPara.Password);
}

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = L2TP_info_language[b.getAttribute("BindText")];
	}
}

function OnPageLoad()
{	
	loadlanguage();	
	initL2TPConfig();
	SetCurrentItemInfo();	
    return true; 
}
</script>
</head>

<body  class="mainbody" onload="OnPageLoad();">
<form id="TableL2TPInfo" style="display:block">
  <table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
  		<li   id="L2TPStatus"		   RealType="HtmlText"	  DescRef="bbsp_l2tp_state" 	     RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"	 BindField=""    InitValue="Empty"/>
		<li   id="L2TPStartClient"     RealType="HtmlText"    DescRef="bbsp_l2tp_starten"        RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue=""/>
		<li   id="L2TPServerAddr"      RealType="HtmlText"     DescRef="bbsp_l2tp_serveraddr"    RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty"/>
		<li   id="L2TPUsername"        RealType="HtmlText"     DescRef="bbsp_l2tp_uername"       RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty"/>
		<li   id="L2TPPassword"        RealType="HtmlText"     DescRef="bbsp_l2tp_password"      RemarkRef="Empty"   ErrorMsgRef="Empty"    Require="FALSE"    BindField=""    InitValue="Empty"/>
		
		<script language="JavaScript" type="text/javascript">
			
			var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			
			HWParsePageControlByID("TableL2TPInfo", TableClass, L2TP_info_language, null);
		</script>
  </table>
</form>
</body>
</html>
