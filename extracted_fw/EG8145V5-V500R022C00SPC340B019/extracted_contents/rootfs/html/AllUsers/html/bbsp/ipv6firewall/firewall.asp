<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<title>IPv6 firewall</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, ipv6firewall_language, route_language);%>"></script>
<script language="JavaScript" type="text/javascript">

var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var dbaa1SuperSysUserType = '2';
var maxisNormalUserType = '2';

function IsAdminUser()
{
    if (DBAA1 == '1') {
        return curUserType == dbaa1SuperSysUserType;
    }
    return curUserType == sysUserType;
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
		b.innerHTML = ipv6firewall_language[b.getAttribute("BindText")];
	}
}

var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>';

var IPv6Firewall = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_IPv6FWDFireWallEnable);%>';

function maxisShowFireWall()
{
    if (curCfgModeWord.toUpperCase() != 'DETHMAXIS') {
        return;
	}

	if (curUserType == maxisNormalUserType) {
		return;
	}
	
	setDisable("ipv6firewall" , 0);
    setDisable("btnApply" , 0);
    setDisable("cancelValue" , 0);
}

function GetShouldDisable() {
    if ((GetCfgMode().OSK == "1")) {
        return 0;
    }

    if (['DGRWIND', 'SONETSGP200W', 'SYNCSGP200W', 'SONETSGP210W', 'SYNCSGP210W', 'PERUCLARO'].indexOf(curCfgModeWord.toUpperCase()) >= 0) {
        return 0;
    }

    return IsAdminUser() ? 0 : 1;
}

function LoadFrame()
{
    setCheck('ipv6firewall',IPv6Firewall);

    var shouldDisable = GetShouldDisable();
    setDisable("ipv6firewall" , shouldDisable);
    setDisable("btnApply" , shouldDisable);
    setDisable("cancelValue" , shouldDisable);

    maxisShowFireWall();
    loadlanguage();
}

function OnFirewallClick()
{
	 if (0 == getCheckVal('ipv6firewall'))
	 {
	 	AlertEx(ipv6firewall_language['bbsp_note']);
	 }
}

function SubmitForm()
{
	 var Form = new webSubmitForm();
	 Form.addParameter('x.X_HW_IPv6FWDFireWallEnable',getCheckVal('ipv6firewall'));
	 Form.addParameter('x.X_HW_Token', getValue('onttoken'));
     Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security&RequestFile=html/bbsp/ipv6firewall/firewall.asp');
     setDisable('btnApply', 1);
     setDisable('cancelValue', 1);
     Form.submit();   
}

function CancelConfig()
{
    LoadFrame();
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody"> 
<div id="Configure"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("ipv6firewalltitle", GetDescFormArrayById(ipv6firewall_language, "bbsp_mune"), GetDescFormArrayById(ipv6firewall_language, "bbsp_firewall_title"), false);
</script>
<div class="title_spread"></div>

<form id="FirewallForm" name="FirewallForm">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li   id="ipv6firewall"                 RealType="CheckBox"           DescRef="bbsp_ipv6firewall"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.X_HW_IPv6FWDFireWallEnable"             InitValue="Empty" ClickFuncApp="onclick=OnFirewallClick"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per35", "width_per75", "ltr");
		var FirewallFormList = new Array();
		FirewallFormList = HWGetLiIdListByForm("FirewallForm",null);
		HWParsePageControlByID("FirewallForm",TableClass,ipv6firewall_language,null);
	</script>
	<table cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
    <tr> 
      <td class='width_per25's></td> 
      <td class="table_submit">
	  	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
	 	<button name="btnApply" id="btnApply" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();"><script>document.write(route_language['bbsp_app']);</script></button>
        <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(route_language['bbsp_cancel']);</script></button> </td> 
    </tr> 
  </table> 
</form>
</div> 
</body>
</html>
