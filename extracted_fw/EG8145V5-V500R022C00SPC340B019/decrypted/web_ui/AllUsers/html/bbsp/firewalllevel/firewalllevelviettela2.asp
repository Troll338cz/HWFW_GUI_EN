<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>Firewall Level</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var FltsecLevelx = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>';
var Tr181FltsecLevelx = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.Firewall.Config);%>';
var Tr181FltsecEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.Firewall.Enable);%>';

var FltsecLevel = changechar(FltsecLevelx);
var Tr181Level = Tr181FltsecLevelx.toLowerCase();
var Tr181TranslateLevel = "";

var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var curUserType = '<%HW_WEB_GetUserType();%>';
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var TR181FirewallFT = '<%HW_WEB_GetFeatureSupport(FT_TR181_FIREWALL);%>';
var COMMONV5FirewallFT = '<%HW_WEB_GetFeatureSupport(BBSP_FT_FIREWALL_COMMONV5);%>';
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';
function IsNeedAddSafeDesForBelTelecom(){
	if(1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0){
		return true;
	}
	
	return false;
}


if(TR181FirewallFT == 1 && COMMONV5FirewallFT == 1)	
{
	if (Tr181FltsecEnable.toString() == '0')
	{	
		Tr181TranslateLevel = "Disable";
	}
	else
	{
		Tr181TranslateLevel = "Standard";
	}
}
else 
{
	if (Tr181FltsecEnable.toString() == '0')
	{	
		Tr181TranslateLevel = "Disable";
	}
	else
	{
		Tr181TranslateLevel = (Tr181Level.indexOf("advanced") >= 0) ? changechar(Tr181Level) : changetr181char(Tr181Level);
	}
}	

function IsSonetUser()
{
	if((SonetFlag == '1')
        && curUserType != '0')
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsOSKNormalUser()
{
	if ((GetCfgMode().OSK == "1") && (curUserType != '0'))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsCroatiahtUser()
{
	if ('CROATIAHT' == CfgModeWord.toUpperCase())
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsDigicelUser()
{
	if (('DIGICEL' == CfgModeWord.toUpperCase()) || ('DIGICEL2' == CfgModeWord.toUpperCase()))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsCABLEVISIONNormalUser()
{
	if ((GetCfgMode().CABLEVISION == "1") && (curUserType != '0'))
	{
		return true;
	}
	else
	{
		return false;
	}
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
		b.innerHTML = firewalllevel_language[b.getAttribute("BindText")];
	}
}

function changechar(str)
{
	if(!str)
	{
		return "";
	}
	return str.substring(0,1).toUpperCase()+str.substring(1,10).toLowerCase();
}

function changetr181char(str)   
{
	if(!str)
	{
		return "";
	}
	return str.substring(0,6).toUpperCase() + str.substring(6,15).toLowerCase();
}

function LoadFrame()
{		
	if(TR181FirewallFT == 1 && COMMONV5FirewallFT == 1)	
	{
		setDisplay("SecurityLevelRow",0)
		setDisplay("TR181SecurityLevelRow",0)	
		var WebDisplayLevel = (TR181FirewallFT == 0) ? FltsecLevel : Tr181TranslateLevel;
		setSelect("COMMONV5SecurityLevel", WebDisplayLevel);
	}
	else
	{
		var WebDisplayLevel = (TR181FirewallFT == 0) ? FltsecLevel : Tr181TranslateLevel;

		setDisplay("TR181SecurityLevelRow",0);
		setDisplay("COMMONV5SecurityLevelRow",0)
		if (TR181FirewallFT == 0)
		{	
			setDisplay("SecurityLevelRow",1)
			setDisplay("TR181SecurityLevelRow",0)
			setSelect("SecurityLevel", WebDisplayLevel);
		}
		else
		{	
			setDisplay("SecurityLevelRow",0)
			setDisplay("TR181SecurityLevelRow",1)
			setSelect("TR181SecurityLevel", WebDisplayLevel);
		}

		setDisable("SecurityLevel" , (curUserType != '0') ? 1 : 0);
		setDisable("TR181SecurityLevel" , (curUserType != '0') ? 1 : 0);
		setDisable("btnApply" , (curUserType!= '0') ? 1 : 0);

		if(IsSonetUser() || IsOSKNormalUser() || IsCroatiahtUser() || IsDigicelUser() || IsCABLEVISIONNormalUser())
		{
			setDisable("SecurityLevel",0);
			setDisable("btnApply",0);
		}

		loadlanguage();
	}	
}

function SubmitForm()
{
    var Form = new webSubmitForm();   
	var firewallLevel = getValue('SecurityLevel');
	var tr181firewalllevel = getValue('TR181SecurityLevel');
	var v5firewallLevel = getValue('COMMONV5SecurityLevel');

	if(TR181FirewallFT == 1 && COMMONV5FirewallFT == 1)	
	{
		if(v5firewallLevel == "Disable")
		{
		    if(firewallLevel.toLowerCase() == "disable")
			{
				if(ConfirmEx(firewalllevel_language["bbsp_DisableFirewallLevel"]) == false)
				{
					return;
				}
			}
			Form.addParameter('x.Enable','0');
			Form.addParameter('x.AdvancedLevel',"");
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall'+ '&RequestFile=html/bbsp/firewalllevel/firewalllevelviettela2.asp');
			Form.submit();
			
			
		}
		else if(v5firewallLevel == "Standard")
		{
			Form.addParameter('x.Enable','1');
			Form.addParameter('x.AdvancedLevel',"InternetGatewayDevice.X_HW_Security.Firewall.Level.1");
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall'+ '&RequestFile=html/bbsp/firewalllevel/firewalllevelviettela2.asp');
			Form.submit();
		}	
	}
	else
	{
		if (TR181FirewallFT == 0)
		{
            if(firewallLevel.toLowerCase() == "disable")
			{
				if(ConfirmEx(firewalllevel_language["bbsp_DisableFirewallLevel"]) == false)
				{
					return;
				}
			}
			Form.addParameter('x.X_HW_FirewallLevel',firewallLevel);
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security'+ '&RequestFile=html/bbsp/firewalllevel/firewalllevelviettela2.asp');
			Form.submit();	
		}
		else
		{	
			
		if (tr181firewalllevel.toLowerCase() == "disable")
		{	
			if(ConfirmEx(firewalllevel_language["bbsp_DisableFirewallLevel"]) == false)
			{
				return;
			}
			Form.addParameter('x.Enable','0');
		}
		else
		{	
			Form.addParameter('x.Enable','1');
			Form.addParameter('x.Config',tr181firewalllevel);
		}
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall' + '&RequestFile=html/bbsp/firewalllevel/firewalllevelviettela2.asp');
			Form.submit();	
		}	
	}
}

function ChangeLevel(level)
{		

}

function DisplayCurrentLevel(level,defaltlev)
{
	if (undefined != firewalllevel_language[level])
	{
		document.getElementById('currentlevel').innerHTML = "&nbsp;&nbsp;"+firewalllevel_language[level];
	}
	else
	{
		document.getElementById('currentlevel').innerHTML = "&nbsp;&nbsp;"+firewalllevel_language[defaltlev];
	}
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("firewallleveltitle", GetDescFormArrayById(firewalllevel_language, "bbsp_mune"), GetDescFormArrayById(firewalllevel_language, ""), false);
	if (IsPTVDFFlag == 1)
	{
		  document.getElementById("firewallleveltitle_content").innerHTML = firewalllevel_language['bbsp_firewalllevel_title_short'];
	}
	else if(true == IsNeedAddSafeDesForBelTelecom())
	{
		document.getElementById("firewallleveltitle_content").innerHTML = firewalllevel_language['bbsp_firewalllevel_title'] + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>";
	}
	else
	{
		  document.getElementById("firewallleveltitle_content").innerHTML = firewalllevel_language['bbsp_firewalllevel_title'];
	}
</script>
<div class="title_spread"></div>

<form id="FirewallLevelForm" name="FirewallLevelForm">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li id="currentlevel"   RealType="HtmlText" DescRef="bbsp_currentlevelmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="Empty"  MaxLength="15" InitValue="Empty" />
		<li id="SecurityLevel"  RealType="DropDownList" DescRef="bbsp_setlevelmh"   RemarkRef="Empty"   ErrorMsgRef="Empty"  Require="FALSE"   BindField="Empty"  InitValue="[{TextRef:'High',Value:'High'},{TextRef:'Medium',Value:'Medium'},{TextRef:'Low',Value:'Low'},{TextRef:'Custom',Value:'Custom'}]"/>
		<li id="TR181SecurityLevel"  RealType="DropDownList" DescRef="bbsp_setlevelmh"   RemarkRef="Empty"   ErrorMsgRef="Empty"  Require="FALSE"   BindField="Empty"  InitValue="[{TextRef:'X_HW_High',Value:'X_HW_High'},{TextRef:'X_HW_Medium',Value:'X_HW_Medium'},{TextRef:'X_HW_Low',Value:'X_HW_Low'},{TextRef:'X_HW_Customer',Value:'X_HW_Customer'},{TextRef:'Advanced',Value:'Advanced'}]"/>
		<li id="COMMONV5SecurityLevel"  RealType="DropDownList" DescRef="bbsp_setlevelmh"   RemarkRef="Empty"   ErrorMsgRef="Empty"  Require="FALSE"   BindField="Empty"  InitValue="[{TextRef:'Standard',Value:'Standard'}]"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per40", "width_per60", "ltr");
		var FirewallLevelFormList = new Array();
		FirewallLevelFormList = HWGetLiIdListByForm("FirewallLevelForm",null);
		HWParsePageControlByID("FirewallLevelForm",TableClass,firewalllevel_language,null);
		    
		if (TR181FirewallFT == 0)
		{	
			DisplayCurrentLevel(FltsecLevel,"Custom");		
		}
		else
		{
			if (Tr181FltsecEnable.toLowerCase() == false)
			{
				if(TR181FirewallFT == 1 && COMMONV5FirewallFT == 1)	
				{
					DisplayCurrentLevel(Tr181TranslateLevel,"X_HW_Customer");
				}
				else
				{
					document.getElementById('currentlevel').innerHTML = "&nbsp;&nbsp;" + "Disabled"
				}
			}
			else
			{
				DisplayCurrentLevel(Tr181TranslateLevel,"X_HW_Customer");
			}
		}		
	</script>
</form>

<table id="OperatorPanel" class="table_button" style="width: 100%" cellpadding="0">
  <tr>
  <td class="table_submit width_per40"></td>
  <td class="table_submit">
  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
  <button name="btnApply" id="btnApply" type="button"  onClick="SubmitForm();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(firewalllevel_language['bbsp_app']);</script></button>
  </td>
  </tr>
</table>

</body>
</html>
