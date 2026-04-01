<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<title>Firewall Level</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style type="text/css">
.imgswitch{
    cursor: pointer;
}
</style>
<script type="text/javascript">
function stfirewall(domain,enable,config)
{
    this.domain = domain;
	this.enable = enable;
	this.config = config;
}

var FirewallInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.Firewall,Enable|Config,stfirewall);%>;

function stDos(domain,SynFloodEn,IcmpEchoReplyEn,IcmpRedirectEn,LandEn,SmurfEn,WinnukeEn,PingSweepEn)
{
    this.domain = domain;
    this.SynFloodEn = SynFloodEn;
	this.IcmpEchoReplyEn = IcmpEchoReplyEn;
	this.IcmpRedirectEn = IcmpRedirectEn;
	this.LandEn = LandEn;
	this.SmurfEn = SmurfEn;
	this.WinnukeEn = WinnukeEn;
	this.PingSweepEn = PingSweepEn;
}
var DosFilters = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.Dosfilter,SynFloodEn|IcmpEchoReplyEn|IcmpRedirectEn|LandEn|SmurfEn|WinnukeEn|PingSweepEn,stDos);%>;

var ShowFirewallEnable = FirewallInfo[0].enable;
var ShowPingEnable = ((DosFilters[0].PingSweepEn ==1) ? 0:1);


function ShowEnable(Enable,id)
{
	if('1' == Enable)
	{
		$("#" + id).attr("src","../../../images/checkon.gif");
	}
	else
	{
		$("#" + id).attr("src","../../../images/checkoff.gif");
	}
}

function FirewallSwitch()
{
    ShowFirewallEnable = (ShowFirewallEnable ==1 ? 0 :1);
    ShowEnable(ShowFirewallEnable,'FirewallSwitchon');
}

function InitShowValue()
{
    ShowPingEnable = ((DosFilters[0].PingSweepEn ==1) ? 0:1);
    ShowFirewallEnable = FirewallInfo[0].enable

	ShowEnable(ShowPingEnable,'Pingswithicon');
	ShowEnable(ShowFirewallEnable,'FirewallSwitchon');
}

function LoadFrame()
{
	InitShowValue();
}
function PingSwith()
{
    ShowPingEnable = (ShowPingEnable ==1 ? 0 :1);
    ShowEnable(ShowPingEnable,'Pingswithicon');
}

function SubmitForm()
{
    var FirewallEn = ShowFirewallEnable;
	var PingSweepEn = ((ShowPingEnable==1) ? 0:1);
	var RequestFile = 'html/bbsp/firewallleveldual/firewalllevelitvdf.asp';
    var Form = new webSubmitForm();
	Form.addParameter('x.Enable',FirewallEn);
    Form.addParameter('x.Config','Standard');
    Form.addParameter('y.PingSweepEn',PingSweepEn);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.Firewall'
						  +'&y=InternetGatewayDevice.X_HW_Security.Dosfilter'
						  + '&RequestFile='+RequestFile);
	Form.submit();
}

function CancelButton()
{
    LoadFrame();
}

</script>
</head>
<body onLoad="LoadFrame();" class="firewallleveldual">
<div class="title_spread"></div>
<form id="FirewallLevelDualForm">
<div id="content" class="content-firewall">
	<h1>
	  <span class="language-string"><script>document.write(firewallleveldual_language['bbsp_f_firewall_title']);</script></span>
	</h1>
	<h2>
	  <span class="language-string">
	  	<script>document.write(firewallleveldual_language['bbsp_f_firewall_des']);</script></span>
	</h2>

	<div class="h3-content no-padding-bottom">
		<table>
			<tr class = "row" style="border-bottom: 1px solid #e6e6e6;height: 80px">
				<td class="labelBox" style="font-weight:bold"><script>document.write(firewallleveldual_language['bbsp_f_firewall_ping']);</script></td>
				<td class="contenbox">
                    <img src="../../../images/checkon.gif" class="imgswitch" id="Pingswithicon" onclick="PingSwith()">
				</td>
			</tr>
			<tr class = "row firewall">
				<td class="labelBox" style="font-weight:bold"><script>document.write(firewallleveldual_language['bbsp_f_firewall_en']);</script></td>
				<td class="contenbox">
                    <img src="../../../images/checkon.gif" class="imgswitch" id="FirewallSwitchon" onclick="FirewallSwitch()">
				</td>
			</tr>
		</table>
	</div>
</div>
</form>
<div class="clearfix apply-cancel">
  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
  <button type="button" id="cancelButton" class="button button-cancel" onclick="CancelButton();">
  		<script>document.write(firewallleveldual_language['bbsp_f_firewall_cancel']);</script>
  </button>
  <button type="button" id="applyButton" class="button button-apply " onclick="SubmitForm();" style="background:#9c2aa0;">
  		<script>document.write(firewallleveldual_language['bbsp_f_firewall_apply']);</script>
  </button>
</div>
</body>
</html>
