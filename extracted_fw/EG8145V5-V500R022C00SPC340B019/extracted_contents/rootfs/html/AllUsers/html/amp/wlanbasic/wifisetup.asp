<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlancfgother_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<title>WiFi Setup</title>
<script language="JavaScript" type="text/javascript">

function stWlan(domain,ssid)
{
    this.domain = domain;
    this.ssid = ssid;
}

function stPsk(domain,psk)
{
    this.domain = domain;
    this.psk = psk;
}

var WlanArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i},SSID, stWlan);%>;
var PskArr = <%HW_WEB_CmdGetWlanConf(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}.PreSharedKey.1,PreSharedKey, stPsk);%>;

function CheckPsk(value)
{
	if (value == '')
	{
		AlertEx("The WPA pre-shared key cannot be empty.");
		return false;
	}

	if (isValidWPAPskKey(value) == false)
	{
		AlertEx("The WPA pre-shared key must be between 8 and 63 ASCII characters or 64 hexadecimal characters.");
		return false;
	}

	if (isValidStr(value) != '')
	{
		AlertEx("The WPA pre-shared key" + " "+ value + cfg_wlancfgother_language['amp_wlanstr_invalid'] + " " + isValidStr(value));
		return false;
	}

	return true;
}

function WlanNext()
{
    var ssid = ltrim(getValue('Wizard_text02_text'));
    var psk  = getValue('Wizard_password02_password');

	if (false == CheckSsid(ssid))
	{
		return false;
	}

	if (false == CheckPsk(psk))
	{
		return false;
	}

    if (false == CheckSsidExist(ssid, WlanArr))
	{
		return false;
	}

	return true;
}

function WlanAddFormPara(Form)
{
    Form.addParameter('p.SSID', ltrim(getValue('Wizard_text02_text')));

	Form.addParameter('q.PreSharedKey', getValue('Wizard_password02_password'));
}

function LoadFrame()
{
	setText('Wizard_text02_text', WlanArr[0].ssid);
    setText('Wizard_password02_password', PskArr[0].psk);
}

function ApplySubmit()
{
    var Form = new webSubmitForm();

    if (WlanNext() == false)
    {
        return false;
    }

	setDisable('btnSubmit', 1);

    url = 'set.cgi?';

    WlanAddFormPara(Form);
	url += '&p=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1' + '&q=InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1';

    url += '&RequestFile=html/amp/wlanbasic/wifisetup.asp';
	Form.setAction(url);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}
</script>
</head>


<body class="mainbody" onLoad="LoadFrame();">

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_noborder_bg">
    <tr class="tabal_head">
        <td class='block_title' colspan="2">Enter your Wi-Fi SSID and key</td>
    </tr>
	<tr>
		<td class="table_title width_per25"  width="25%">SSID:</td>
		<td class="table_right" width="75%">
		<input type="text" name="Wizard_text02_text" id="Wizard_text02_text" size="15" maxlength="32">
			<font class="color_red">*</font>
		</td>
	</tr>
	<tr>
		<td class="table_title width_per25"  width="25%">WPA pre-shared key:</td>
		<td class="table_right" width="75%">
		<input type='password' autocomplete='off' id='Wizard_password02_password' name='Wizard_password02_password' size="15" maxlength='64'>
			<font class="color_red">*</font>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="table_button">
  <tr>
    <td class="table_submit width_per25" width="25%"></td>
    <td class="table_submit">
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	  <button type="button" id="btnSubmit" class="ApplyButtoncss buttonwidth_100px" onClick="ApplySubmit();">Submit</button>
	</td>
  </tr>
</table>

</body>
</html>
