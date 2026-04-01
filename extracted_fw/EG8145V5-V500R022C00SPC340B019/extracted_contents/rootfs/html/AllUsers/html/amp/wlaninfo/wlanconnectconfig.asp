<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlansyncswitch_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<title>Wlan elink switch</title>

<script language="JavaScript" type="text/javascript">
var CaseBandFre  = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_UpmodeConfig.1.UpAccessMode);%>';
var TribandFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TRIBAND_AP);%>';
var APType ='<%HW_WEB_GetApMode();%>'
var isFitAp = 0;
var fitApFt = '<%HW_WEB_GetFeatureSupport(FT_FIT_AP);%>';
var fitApEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Capwap.APMode);%>';
if ((fitApFt == 1) && (fitApEnable == 1)) {
    isFitAp = 1;
}
function wlanSyncEnableSwitch()
{

	var Form = new webSubmitForm();
    var enable = getCheckVal('wlanconnectconfig');

    Form.addParameter('x.WifiSyncEnable',enable);
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SlaveAPConfig'
                    + '&RequestFile=html/amp/wlaninfo/wlanconnectconfig.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function wlanSyncAccessCfgSwitch()
{

	var Form = new webSubmitForm();
    var enable = getCheckVal('wlansyncaccesscfg');

    Form.addParameter('x.WifiSyncAccessCfg',enable);
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SlaveAPConfig'
                    + '&RequestFile=html/amp/wlaninfo/wlanconnectconfig.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function WlanHttpsSwitch() {
    AlertEx(cfg_wlansyncswitch_language['amp_wlan_httpswitch_enable_note']);
    var Form = new webSubmitForm();
    var enable = getCheckVal('wlanHttpsCfg');

    Form.addParameter('x.HttpsSwitch',enable);
    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_SlaveAPConfig'
                    + '&RequestFile=html/amp/wlaninfo/wlanconnectconfig.asp');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}

function setCheckCaseBand()
{
	var radioValue = document.getElementsByName("caseBandRadio");
	for(i = 0; i< radioValue.length ;i++)
	{
		if(radioValue[i].value == CaseBandFre)
		{
			radioValue[i].checked = true;
		}
	}
}

function caseBandRadioClick()
{
	var radioValue = document.getElementsByName("caseBandRadio");
	var checkdValue;
	
	for(i = 0; i< radioValue.length ;i++)
	{
		if(radioValue[i].checked == true)
		{
			if(radioValue[i].value == CaseBandFre)
			{
				return false;
			}
			else
			{
				if (false == ConfirmEx(cfg_wlansyncswitch_language['amp_wlan_caseband_alert']))
				{
					setCheckCaseBand();
					return false;
				}
				
				checkdValue = radioValue[i].value;
				break;
			}
		}
	}
		
	var Form = new webSubmitForm();

    Form.addParameter('x.UpAccessMode',checkdValue);
    Form.setAction('set.cgi?x=InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_UpmodeConfig.1'
                    + '&RequestFile=html/amp/wlaninfo/wlanconnectconfig.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
}


function LoadFrame()
{
    var wlanSyncEnableSwitchEnable = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_SlaveAPConfig.WifiSyncEnable);%>;
    var wlanSyncAccessCfg = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_SlaveAPConfig.WifiSyncAccessCfg);%>;
    var wlanHttpsCfg = <%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_SlaveAPConfig.HttpsSwitch);%>;
    setCheck('wlanconnectconfig', wlanSyncEnableSwitchEnable);
    setCheck('wlansyncaccesscfg', wlanSyncAccessCfg);
    setCheck('wlanHttpsCfg', wlanHttpsCfg);
    if (TribandFlag == 0) {
        setDisplay('caseBand', 1);
        setCheckCaseBand();
    }

    if (isFitAp == 1) {
        setDisable("wlanconnectconfig", 1);
        setDisable("wlansyncaccesscfg", 1);
        setDisable("wlanHttpsCfg", 1);
        setDisable("caseBandRadio1", 1);
        setDisable("caseBandRadio2", 1);
        setDisable("caseBandRadio3", 1);
    }

	if (APType != 1) {
        setDisplay('wlansyncaccesscfgTr', 0);
        setDisplay('caseBand', 0);
    }
}
</script>


</head>
<body class="mainbody" onLoad="LoadFrame();">
<body class="mainbody" onLoad="LoadFrameSche();">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table>  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("wlanconnectconfig", GetDescFormArrayById(cfg_wlansyncswitch_language, "amp_wlan_wlansyncswitch_header"), GetDescFormArrayById(cfg_wlansyncswitch_language, "amp_wlan_wlansyncswitch_title"), false);
</script>

<div class="title_spread"></div>

<div>
<table cellspacing="0" cellpadding="0" width="100%">
  <tbody>
  <tr><td>
	<input type='checkbox' id='wlanconnectconfig' onClick='wlanSyncEnableSwitch();'/>
	<script>document.write(cfg_wlansyncswitch_language['amp_wlan_wlansyncswitch_enable']);</script>
  </td></tr>
  	<tr id='wlansyncaccesscfgTr'><td>
	<input type='checkbox' id='wlansyncaccesscfg' onClick='wlanSyncAccessCfgSwitch();'/>
	<script>document.write(cfg_wlansyncswitch_language['amp_wlan_wlansyncaccesscfg_enable']);</script>
  </td></tr>
  <tr><td>
	<input type='checkbox' id='wlanHttpsCfg' onClick='WlanHttpsSwitch();'/>
	<script>document.write(cfg_wlansyncswitch_language['amp_wlan_httpswitch_enable']);</script>
  </td></tr>
  </tbody>
</table>
</div>
<div id="caseBand" style="margin-top:20px;display:none;">
	<div class="func_title">
		<script>document.write(cfg_wlansyncswitch_language['amp_wlan_caseband_title']);</script>
	</div>
	<div>
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
			<tbody>
				<tr>
					<td class="table_title" width="100%">
						<input type="radio" id="caseBandRadio1" name="caseBandRadio" value="1" onClick="caseBandRadioClick()"/>
						<script>document.write(cfg_wlansyncswitch_language['amp_wlan_caseband_2G']);</script>
					</td>
				</tr>
				<tr>
					<td class="table_title" width="100%">
						<input type="radio" id="caseBandRadio2" name="caseBandRadio" value="2" onClick="caseBandRadioClick()" />
						<script>document.write(cfg_wlansyncswitch_language['amp_wlan_caseband_5G']);</script>
					</td>
				</tr>
				<tr>
					<td class="table_title" width="100%">
						<input type="radio" id="caseBandRadio3" name="caseBandRadio" value="4"  onClick="caseBandRadioClick()"/>
						<script>document.write(cfg_wlansyncswitch_language['amp_wlan_caseband_auto']);</script>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<div><input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"></div>         
<div>
	
</div>
</body>