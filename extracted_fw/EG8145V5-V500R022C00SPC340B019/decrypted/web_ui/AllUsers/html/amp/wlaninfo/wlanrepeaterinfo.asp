<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlaninfo_repeater_info_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<title>Wlan repeater information</title>
<script type="text/javascript">

function stRepeaterInfo(SSID,BSSID,Channel,Rate_RX,Rate_TX,MCS_RX,MCS_TX,ChannelWidth,RSSI)
{
	this.SSID = SSID;
	this.BSSID = BSSID;
    this.Channel = Channel;
    this.Rate_RX = Rate_RX;
	this.Rate_TX = Rate_TX;
	this.MCS_RX = MCS_RX;
	this.MCS_TX = MCS_TX;
	this.ChannelWidth = ChannelWidth;
	this.RSSI = RSSI;
}

var RepeaterInfo = new stRepeaterInfo(<%HW_WEB_RepeaterinfoGet();%>);

function getchannelwidth(channelwidth)
{
	var width='';
	if(0 == channelwidth)
	{
		width = "20 MHz";
	}
	else if(1 == channelwidth)
	{
		width = "40 MHz";
	}
	else if(2 == channelwidth)
	{
		width = "80 MHz";
	}
	else
	{
		width = "160 MHz";
	}
	
	return width;
}

function getrssi(RSSI)
{
	var rssi = -95;
	if(RSSI != 0)
	{
		rssi = RSSI - 100;
	}
	return rssi + " dBm";
}

function getrate(rate)
{
	return rate + " Mbps";
}

function LoadFrame()
{
}
</script>
<body  class="mainbody" onLoad="LoadFrame();">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("repeaterinfoasp", GetDescFormArrayById(cfg_wlaninfo_repeater_info_language, "amp_wlan_repeater_info_title"), GetDescFormArrayById(cfg_wlaninfo_repeater_info_language, "amp_wlan_repeater_info_summary"), false);
</script>
<div class="title_spread"></div>
<form id="repeaterInfoForm" name="repeaterInfoForm">
<table id="deviceInfoFormPanel" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="SSID" RealType="HtmlText" DescRef="amp_wlan_repeater_info_ssid" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="SSID" InitValue="Empty" />
<li id="BSSID" RealType="HtmlText" DescRef="amp_wlan_repeater_info_bssid" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="BSSID" InitValue="Empty" />
<li id="RSSI" RealType="HtmlText" DescRef="amp_wlan_repeater_info_rssi" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="RSSI" InitValue="Empty" />
<li id="Channel" RealType="HtmlText" DescRef="amp_wlan_repeater_info_channel" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Channel" InitValue="Empty" />
<li id="ChannelWidth" RealType="HtmlText" DescRef="amp_wlan_repeater_info_channelwidth" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="ChannelWidth" InitValue="Empty" />
<li id="MCS_TX" RealType="HtmlText" DescRef="amp_wlan_repeater_info_txmcs" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="MCS_TX" InitValue="Empty" />
<li id="MCS_RX" RealType="HtmlText" DescRef="amp_wlan_repeater_info_rxmcs" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="MCS_RX" InitValue="Empty" />
<li id="Rate_TX" RealType="HtmlText" DescRef="amp_wlan_repeater_info_txrate" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Rate_TX" InitValue="Empty" />
<li id="Rate_RX" RealType="HtmlText" DescRef="amp_wlan_repeater_info_rxrate" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Rate_RX" InitValue="Empty" />
</table>
<script>
var TableClass = new stTableClass("width_per25", "table_right align_left","ltr");
var repeaterInfoFormList = new Array();
repeaterInfoFormList = HWGetLiIdListByForm("repeaterInfoForm",null);

var width = getchannelwidth(RepeaterInfo.ChannelWidth);
var rssi = getrssi(RepeaterInfo.RSSI);
var txrate = getrate(RepeaterInfo.Rate_TX);
var rxrate = getrate(RepeaterInfo.Rate_RX);
var txmcs = '--';
var rxmcs = '--';

if (255 != RepeaterInfo.MCS_TX)
{
	txmcs = RepeaterInfo.MCS_TX;
}
if (255 != RepeaterInfo.MCS_RX)
{
	rxmcs = RepeaterInfo.MCS_RX;
}
HWParsePageControlByID("repeaterInfoForm",TableClass,cfg_wlaninfo_repeater_info_language,null);
document.getElementById('SSID').innerHTML = htmlencode(RepeaterInfo.SSID);
document.getElementById('BSSID').innerHTML = htmlencode(RepeaterInfo.BSSID);
document.getElementById('RSSI').innerHTML = htmlencode(rssi);
document.getElementById('Channel').innerHTML = htmlencode(RepeaterInfo.Channel);
document.getElementById('ChannelWidth').innerHTML = htmlencode(width);
document.getElementById('MCS_TX').innerHTML = htmlencode(txmcs);
document.getElementById('MCS_RX').innerHTML = htmlencode(rxmcs);
document.getElementById('Rate_TX').innerHTML = htmlencode(txrate);
document.getElementById('Rate_RX').innerHTML = htmlencode(rxrate);

</script>
</form>
<div class="func_spread"></div>

<div style="height:20px"></div>
</body>
</html>
