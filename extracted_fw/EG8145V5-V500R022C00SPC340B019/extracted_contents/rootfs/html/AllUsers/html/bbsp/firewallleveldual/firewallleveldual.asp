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
<title>Firewall Level</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';

function stfirewall(domain,enable,config)
{
    this.domain = domain;
	this.enable = enable;
	this.config = config;  
}
var FirewallInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.Firewall,Enable|Config,stfirewall);%>;  
var AdvancedLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.Firewall.AdvancedLevel);%>';	

var LevelHigh = "Device.Firewall.Level.2";
var LevelTalkTalk = "Device.Firewall.Level.1";
var LevelDaumHigh = "InternetGatewayDevice.X_HW_Security.Firewall.Level.2";
var LevelDaumLow = "InternetGatewayDevice.X_HW_Security.Firewall.Level.1";

var curCfgModeWord = '<%HW_WEB_GetCfgMode();%>'; 

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
		b.innerHTML = firewallleveldual_language[b.getAttribute("BindText")];
	}
}


function displayFltsecLevel(IsSelectOption)
{
	var strFirewallLevel = '';
	
	if (false == IsSelectOption)
	{
		var showStandard = firewallleveldual_language['bbsp_Standard'];
		var showDisable = firewallleveldual_language['Disable'];
		var showHigh = 'High'
		var showTalkTalk = 'TalkTalk';
		var showLow = 'Low';
	}
	else
	{
		var showStandard = 'Standard';
		var showDisable = 'Disabled';
		var showHigh = 'High'
		var showTalkTalk = 'TalkTalk';
		var showLow = 'Low';
	}
	
	if (FirewallInfo[0] == null)
	{
		strFirewallLevel = showDisable;
	}
	else
	{
		if (0 == FirewallInfo[0].enable)
		{
			strFirewallLevel = 'Disabled';		
		}
		else if (1 == FirewallInfo[0].enable)
		{
			switch(FirewallInfo[0].config.toUpperCase()) 
			{
				case 'ADVANCED':

						if (curCfgModeWord == "TALKTALK2WIFI")
						{
				
							if (LevelHigh == AdvancedLevel)
							{
								strFirewallLevel = showHigh;		
							}
							else if (LevelTalkTalk == AdvancedLevel)
							{
								strFirewallLevel = showTalkTalk;	
							}
						}
						else if (curCfgModeWord == "DAUM2WIFI")
						{
							if (LevelDaumHigh == AdvancedLevel)
							{
								strFirewallLevel = showHigh;		
							}
							else if (LevelDaumLow == AdvancedLevel)
							{
								strFirewallLevel = showLow;	
							}
						}
						break;
				case 'STANDARD':
				default:
				
					strFirewallLevel = showStandard;
					break;

			}
		}
	}

	return strFirewallLevel;
}


function LoadFrame()
{
	setSelect("SecurityLevel", displayFltsecLevel(true));
	loadlanguage();
}

function SubmitForm()
{
	var enable = 1;
	var SecurityLevel = getValue('SecurityLevel');
	var message = '';
	var Form = new webSubmitForm(); 
	
	if (curCfgModeWord == "TALKTALK2WIFI")
	{
	
		if("Disabled" == SecurityLevel) 
		{
			enable = 0;
			SecurityLevel = 'Disabled';
			message = firewallleveldual_language['bbsp_DisableMode'];
			if (ConfirmEx(message) == false)
			{
				return;
			}
			
		}
		else
		{
			enable = 1;
			if ("High" == SecurityLevel)
			{
				message = firewallleveldual_language['bbsp_TalkTalkHighMode'];
				if(ConfirmEx(message))
				{
					Form.addParameter('x.AdvancedLevel', LevelHigh);
				}
				else
				{
					return;
				}	
			}
			else if ("TalkTalk" == SecurityLevel)
			{
				message = firewallleveldual_language['bbsp_TalkTalkMode'];
				if(ConfirmEx(message))
				{	
					Form.addParameter('x.AdvancedLevel', LevelTalkTalk);
				}
				else
				{
					return;
				}
								
			}
			SecurityLevel = 'Advanced';
		}
	}
	else if (curCfgModeWord == "DAUM2WIFI")
	{	
		if("Disabled" == SecurityLevel) 
		{
			enable = 0;
			SecurityLevel = 'Disabled';
			message = firewallleveldual_language['bbsp_DAUM_DisableMode'];
			if (ConfirmEx(message) == false)
			{
				return;
			}
			
		}
		else
		{
			enable = 1;
			if ("High" == SecurityLevel)
			{
				message = firewallleveldual_language['bbsp_DAUM_HIGHMode'];
				if(ConfirmEx(message))
				{
					Form.addParameter('x.AdvancedLevel', LevelDaumHigh);
				}
				else
				{
					return;
				}	
			}
			else if ("Low" == SecurityLevel)
			{
				message = firewallleveldual_language['bbsp_DAUM_LOWMode'];
				if(ConfirmEx(message))
				{	
					Form.addParameter('x.AdvancedLevel', LevelDaumLow);
				}
				else
				{
					return;
				}
								
			}
			SecurityLevel = 'Advanced';
		}
	}
	else
	{
		switch(SecurityLevel)
		{
			case 'Disabled':
				message = firewallleveldual_language['bbsp_DisabledMode'];
				break;
			case 'Standard':
				message = firewallleveldual_language['bbsp_StandardMode'];
				break;
			default:
				break;
		}
		
		if (ConfirmEx(message) == false)
		{
			return;
		}
		
		if("Disabled" == SecurityLevel) 
		{
			enable = 0;
			SecurityLevel = 'Standard';
		}	
	}
	
	Form.addParameter('x.Enable',enable);
	Form.addParameter('x.Config',SecurityLevel);	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall'+ '&RequestFile=html/bbsp/firewallleveldual/firewallleveldual.asp');	
	Form.submit();	
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("firewallleveldualtitle", GetDescFormArrayById(firewallleveldual_language, "bbsp_mune"), GetDescFormArrayById(firewallleveldual_language, ""), false);
	if(IsPTVDFFlag == 1)
	{
		  document.getElementById("firewallleveldualtitle_content").innerHTML = firewallleveldual_language['bbsp_firewalllevel_title_short'];
	}else
	{
		  document.getElementById("firewallleveldualtitle_content").innerHTML = firewallleveldual_language['bbsp_firewallleveldual_title'];
	}
</script>
<div class="title_spread"></div>

<form id="FirewallLevelDualForm" name="FirewallLevelDualForm">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li id="currentlevel"   RealType="HtmlText" DescRef="bbsp_currentlevelmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="TRUE" BindField="Empty"  MaxLength="15" InitValue="Empty" />
		<script type="text/javascript">
			if(curCfgModeWord == "TALKTALK2WIFI")
			{
				document.write('<li id="SecurityLevel"  RealType="DropDownList" DescRef="bbsp_setlevelmh"   RemarkRef="Empty"   ErrorMsgRef="Empty"  Require="FALSE"   BindField=""  InitValue="[{TextRef:\'Low_tt\',Value:\'TalkTalk\'},{TextRef:\'High\',Value:\'High\'},{TextRef:\'Disable\',Value:\'Disabled\'}]"/>');			
			}
			else if(curCfgModeWord == "DAUM2WIFI")
			{
				document.write('<li id="SecurityLevel"  RealType="DropDownList" DescRef="bbsp_setlevelmh"   RemarkRef="Empty"   ErrorMsgRef="Empty"  Require="FALSE"   BindField=""  InitValue="[{TextRef:\'Low\',Value:\'Low\'},{TextRef:\'High\',Value:\'High\'},{TextRef:\'Disable\',Value:\'Disabled\'}]"/>');			
			}
			else
			{
				document.write('<li id="SecurityLevel"  RealType="DropDownList" DescRef="bbsp_setlevelmh"   RemarkRef="Empty"   ErrorMsgRef="Empty"  Require="FALSE"   BindField="x.Config"  InitValue="[{TextRef:\'Disable\',Value:\'Disabled\'},{TextRef:\'bbsp_Standard\',Value:\'Standard\'}]"/>');
			}			
	
		</script>
	</table>
	<script>
		var TableClass = new stTableClass("width_per40", "width_per60", "ltr");
		var FirewallLevelFormList = new Array();
		FirewallLevelFormList = HWGetLiIdListByForm("FirewallLevelDualForm",null);
		HWParsePageControlByID("FirewallLevelDualForm",TableClass,firewallleveldual_language,null);
		document.getElementById('currentlevel').innerHTML = "&nbsp;&nbsp;"+displayFltsecLevel(false);
	</script>
</form>
			
<table id="OperatorPanel" class="table_button" style="width: 100%" cellpadding="0">
  <tr>
  <td class="table_submit width_per40"></td>
  <td class="table_submit">
  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
  <button name="btnApply" id="btnApply" type="button"  onClick="SubmitForm();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(firewallleveldual_language['bbsp_app']);</script></button>
  </td>
  </tr>
</table>

</body>
</html>
