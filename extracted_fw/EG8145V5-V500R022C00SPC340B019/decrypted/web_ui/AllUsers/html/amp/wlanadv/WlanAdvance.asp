<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../common/<%HW_WEB_CleanCache_Resource(wlan_style.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="javascript" src="wlanadvance_com_api.asp"></script>
<script language="javascript" src="wlanadvance_api.asp"></script>
<title>WLAN Advanced Configuration</title>
<style>
.StyleSelect
{
    width:160px;  
}
</style>
<script>
    var processingState = 0;
    function checkProcessingState() {
        getProcessingState();
        return processingState === '1';
    }

    function getProcessingState() {
        $.ajax({
          type : "POST",
          async : false,
          cache : false,
          url : "getProcessState.asp",
          success : function(data) {
            processingState = data;
          }
        });
    }
</script>
</head>
<body class="mainbody wlanmenu" onLoad="LoadFrameWifi();">
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr></table> 
<script language="JavaScript" type="text/javascript">
initPageHeadInfo();
</script>

<div class="title_spread"></div>

<div id='div_wlanadv'>  

<table id="wlanadv_head" width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
<tr><td class="func_title" BindText="amp_wlan_advance"></td></tr>
</table>

<div id="TriBandMenuDiv" class="Menubox" style="display:none">
    <ul>
        <li id="menu1" onClick="setTab('menu',1)" class="hover"><script>document.write(cfg_wlancfgother_language['amp_wlanbasic_lowband_5G']);</script></li>
        <li id="menu2" onClick="setTab('menu',2)"><script>document.write(cfg_wlancfgother_language['amp_wlanbasic_highband_5G']);</script></li>
    </ul>
</div>

<form id="wlanadvForm">
<div id="divTablewlanadvForm" class="configborder">
<table id="TablewlanadvForm" width="100%" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" style='display:none;'>
	<tbody>
		<tr border="1" id="X_HW_WorkModeRow">
			<td class="table_title width_per30" id="X_HW_WorkModeColleft" BindText="amp_wlan_workmode"></td>
			<td id="X_HW_WorkModeCol" class="table_right width_per70">
				<select id="X_HW_WorkMode" class="StyleSelect" onchange="WorkModeChange();">
				</select>
				<font color="red" id="X_HW_WorkModeRequire"></font>
				<span class="gray" id="X_HW_WorkModespan"></span>
			</td>
		</tr>
		<tr border="1" id="TransmitPowerRow">
			<td class="table_title width_per30" id="TransmitPowerColleft" BindText="amp_tx_power"></td>
			<td id="TransmitPowerCol" class="table_right width_per70">
				<select id="TransmitPower" class="StyleSelect" onchange="setTransmitPowerSug();">
				</select>
				<font color="red" id="TransmitPowerRequire"></font>
				<span id='spanEirpSug' class="gray"></span>
				<span class="gray" id="TransmitPowerspan"></span>
			</td>
		</tr>
		<tr border="1" id="RegulatoryDomainRow">
			<td class="table_title width_per30" id="RegulatoryDomainColleft" BindText="amp_wlan_zone"></td>
			<td id="RegulatoryDomainCol" class="table_right width_per70">
				<select id="RegulatoryDomain" class="StyleSelect" onchange="RegulatoryDomainChange();">
				</select>
				<font color="red" id="RegulatoryDomainRequire"></font>
				<span class="gray" id="RegulatoryDomainspan"></span>
			</td>
		</tr>
		<tr border="1" id="ChannelRow">
			<td class="table_title width_per30" id="ChannelColleft" BindText="amp_wlan_channel"></td>
			<td id="ChannelCol" class="table_right width_per70">
				<select id="Channel" class="StyleSelect" onchange="setChannelSug();">
				</select>
				<script>
					if ((wlanpage == "5G") && ((cfgMode.toUpperCase() == 'SYNCSGP210W') || (cfgMode.toUpperCase() == 'SONETSGP210W'))) {
						document.write('<input id="CheckEnabledW52" type="checkbox" checked = "checked" class="CheckBox" onclick="selectChannels(this)">');
						document.write('<span id="Channelspan1"> W52   </span>');
						document.write('<input id="CheckEnabledW53" type="checkbox" checked = "checked" class="CheckBox" onclick="selectChannels(this)">');
						document.write('<span id="Channelspan2"> W53   </span>');
						document.write('<input id="CheckEnabledW56" type="checkbox" checked = "checked" class="CheckBox" onclick="selectChannels(this)">');
						document.write('<span id="Channelspan3"> W56</span>');
					}
				</script>
				<font color="red" id="ChannelRequire"></font>
				<span class="gray" id="Channelspan"></span>
			</td>
		</tr>
		
		<tr border="1" id="X_HW_AutoChannelPeriodicallyRow" style='display:none;'>
			<td class="table_title width_per30" id="X_HW_AutoChannelPeriodicallyColleft" BindText="amp_stop_auto_channel"></td>
			<td id="X_HW_AutoChannelPeriodicallyCol" class="table_right width_per70">
				<input id="X_HW_AutoChannelPeriodically" type="checkbox" class="CheckBox">
				<font color="red" id="X_HW_AutoChannelPeriodicallyRequire"></font>
				<span class="gray" id="X_HW_AutoChannelPeriodicallyspan"></span>
			</td>
		</tr>

		<tr border="1" id="X_HW_HT20Row">
			<td class="table_title width_per30" id="X_HW_HT20Colleft" BindText="amp_channel_width"></td>
			<td id="X_HW_HT20Col" class="table_right width_per70">
				<select id="X_HW_HT20" class="StyleSelect" onchange="X_HW_HT20Change();">
				</select>
				<font color="red" id="X_HW_HT20Require"></font>
				<span class="gray" id="X_HW_HT20span"></span>
			</td>
		</tr>
		<tr border="1" id="X_HW_StandardRow">
			<td class="table_title width_per30" id="X_HW_StandardColleft" BindText="amp_channel_mode"></td>
			<td id="X_HW_StandardCol" class="table_right width_per70">
				<select id="X_HW_Standard" class="StyleSelect" onchange="X_HW_StandardChange();">
				</select>
				<font color="red" id="X_HW_StandardRequire"></font>
				<span class="gray" id="X_HW_Standardspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_HW_MCSRow">
			<td class="table_title width_per30" id="X_HW_MCSColleft" BindText="amp_mcs_rate"></td>
			<td id="X_HW_MCSCol" class="table_right width_per70">
				<select id="X_HW_MCS" class="StyleSelect">
				</select>
				<font color="red" id="X_HW_MCSRequire"></font>
				<span class="gray" id="X_HW_MCSspan"></span>
			</td>
		</tr>

		<tr border="1" id="X_HW_WifiWorkingModeRow" style='display:none;'>
			<td class="table_title width_per30" id="X_HW_WifiWorkingModeColleft" BindText="amp_wlan_work_mode"></td>
			<td id="X_HW_WifiWorkingModeCol" class="table_right width_per70">
				<select id="X_HW_WifiWorkingMode" class="StyleSelect">
				</select>
				<font color="red" id="X_HW_WifiWorkingModeRequire"></font>
				<span class="gray" id="X_HW_WifiWorkingModespan"></span>
			</td>
		</tr>	

		<tr border="1" id="GuardIntervalRow">
			<td class="table_title width_per30" id="GuardIntervalColleft" BindText="amp_wlan_guardinterval"></td>
			<td id="GuardIntervalCol" class="table_right width_per70">
				<select id="GuardInterval" class="StyleSelect">
				</select>
				<font color="red" id="GuardIntervalRequire"></font>
				<span class="gray" id="GuardIntervalspan"></span>
			</td>
		</tr>
		<tr border="1" id="UsersPerSSIDEnableRow">
			<td class="table_title width_per30" id="UsersPerSSIDEnableColleft" BindText="amp_number_user_per_ssid"></td>
			<td id="UsersPerSSIDEnableCol" class="table_right width_per70">
				<input id="UsersPerSSIDEnable" type="checkbox"  class="CheckBox">
				<font color="red" id="UsersPerSSIDEnableRequire"></font>
				<span class="gray" id="UsersPerSSIDEnablespan"></span>
			</td>
		</tr>
		<tr border="1" id="X_IEEE80211wEnabledRow">
			<td class="table_title width_per30" id="X_IEEE80211wEnabledColleft" BindText="amp_ieee80211w"></td>
			<td id="X_IEEE80211wEnabledCol" class="table_right width_per70">
				<input id="X_IEEE80211wEnabled" type="checkbox" class="CheckBox">
				<font color="red" id="X_IEEE80211wEnabledRequire"></font>
				<span class="gray" id="X_IEEE80211wEnabledspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_TxBFEnabledRow">
			<td class="table_title width_per30" id="X_TxBFEnabledColleft" BindText="amp_tx_beamforming"></td>
			<td id="X_TxBFEnabledCol" class="table_right width_per70">
				<input id="X_TxBFEnabled" type="checkbox" class="CheckBox">
				<font color="red" id="X_TxBFEnabledRequire"></font>
				<span class="gray" id="X_TxBFEnabledspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_OCCACEnablesRow">
			<td class="table_title width_per30" id="X_OCCACEnablesColleft" BindText="amp_occac"></td>
			<td id="X_OCCACEnablesCol" class="table_right width_per70">
				<input id="X_OCCACEnables" type="checkbox" class="CheckBox">
				<font color="red" id="X_OCCACEnablesRequire"></font>
				<span class="gray" id="X_OCCACEnablesspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_QHOPEnablesRow">
			<td class="table_title width_per30" id="X_QHOPEnablesColleft" BindText="amp_qhop"></td>
			<td id="X_QHOPEnablesCol" class="table_right width_per70">
				<input id="X_QHOPEnables" type="checkbox" class="CheckBox">
				<font color="red" id="X_QHOPEnablesRequire"></font>
				<span class="gray" id="X_QHOPEnablesspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_SCSEnablesRow">
			<td class="table_title width_per30" id="X_SCSEnablesColleft" BindText="amp_scs"></td>
			<td id="X_SCSEnablesCol" class="table_right width_per70">
				<input id="X_SCSEnables" type="checkbox" class="CheckBox">
				<font color="red" id="X_SCSEnablesRequire"></font>
				<span class="gray" id="X_SCSEnablesspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_HW_AirtimeFairnessRow" style='display:none;'>
			<td class="table_title width_per30" id="X_HW_AirtimeFairnessColleft" BindText="amp_airtimefairness"></td>
			<td id="X_HW_AirtimeFairnessCol" class="table_right width_per70">
				<input id="X_HW_AirtimeFairness" type="checkbox" class="CheckBox" onclick="CheckBoost();">
				<font color="red" id="X_HW_AirtimeFairnessRequire"></font>
				<span class="gray" id="X_HW_AirtimeFairnessspan"></span>
			</td>
		</tr>
		<tr border="1" id="BandSteeringPolicyRow" style='display:none;'>
			<td class="table_title width_per30" id="BandSteeringPolicyColleft" BindText="amp_BandSteering"></td>
			<td id="BandSteeringPolicyCol" class="table_right width_per70">
				<input id="BandSteeringPolicy" type="checkbox" class="CheckBox">
				<font color="red" id="BandSteeringPolicyRequire"></font>
				<span class="gray" id="BandSteeringPolicyspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_MUMIMOEnabledRow" style='display:none;'>
			<td class="table_title width_per30" id="X_MUMIMOEnabledColleft" BindText="amp_MUMIMO"></td>
			<td id="X_MUMIMOEnabledCol" class="table_right width_per70">
				<input id="X_MUMIMOEnabled" type="checkbox" class="CheckBox">
				<font color="red" id="X_MUMIMOEnabledRequire"></font>
				<span class="gray" id="X_MUMIMOEnabledspan"></span>
			</td>
		</tr>
		<tr border="1" id="X_HW_PreambleTypeRow" style='display:none;'>
			<td class="table_title width_per30" id="X_HW_PreambleTypeColleft" BindText="amp_wlan_preambletype"></td>
			<td id="X_HW_PreambleTypeCol" class="table_right width_per70">
				<select id="X_HW_PreambleType" class="StyleSelect">
				</select>
				<font color="red" id="X_HW_PreambleTypeRequire"></font>
				<span class="gray" id="X_HW_PreambleTypespan"></span>
			</td>
		</tr>
		<tr border="1" id="DtimPeriodRow">
			<td class="table_title width_per30" id="DtimPeriodColleft" BindText="amp_dtim_time"></td>
			<td id="DtimPeriodCol" class="table_right width_per70">
				<input id="DtimPeriod" type="text" class="TextBox">
				<font color="red" id="DtimPeriodRequire"></font>
				<span class="gray" id="DtimPeriodRemark"></span>
			</td>
		</tr>
		<tr border="1" id="BeaconPeriodRow">
			<td class="table_title width_per30" id="BeaconPeriodColleft" BindText="amp_beacon_time"></td>
			<td id="BeaconPeriodCol" class="table_right width_per70">
				<input id="BeaconPeriod" type="text" class="TextBox">
				<font color="red" id="BeaconPeriodRequire"></font>
				<span class="gray" id="BeaconPeriodRemark"></span>
			</td>
		</tr>
		<tr border="1" id="RTSThresholdRow">
			<td class="table_title width_per30" id="RTSThresholdColleft" BindText="amp_rts_threshold"></td>
			<td id="RTSThresholdCol" class="table_right width_per70">
				<input id="RTSThreshold" type="text" class="TextBox">
				<font color="red" id="RTSThresholdRequire"></font>
				<span class="gray" id="RTSThresholdRemark"></span>
			</td>
		</tr>
		<tr border="1" id="FragThresholdRow">
			<td class="table_title width_per30" id="FragThresholdColleft" BindText="amp_frag_threshold"></td>
			<td id="FragThresholdCol" class="table_right width_per70">
				<input id="FragThreshold" type="text" class="TextBox">
				<font color="red" id="FragThresholdRequire"></font>
				<span class="gray" id="FragThresholdRemark"></span>
			</td>
		</tr>
		<tr border="1" id="X_HW_RSSIThresholdEnableRow">
			<td class="table_title width_per30" id="X_HW_RSSIThresholdEnableColleft" BindText="amp_wlan_rssithreshold_enable"></td>
			<td id="X_HW_RSSIThresholdEnableCol" class="table_right width_per70">
				<input id="X_HW_RSSIThresholdEnable" type="checkbox" class="CheckBox" onclick="X_HW_RSSIThresholdEnableClick(this);">
				<font color="red" id="X_HW_RSSIThresholdEnableRequire"></font>
				<span class="gray" id="X_HW_RSSIThresholdEnablespan"></span>
			</td>
		</tr>
        <tr border="1" id="MuMimoEnableRow" style="display: none;">
            <td class="table_title width_per30" id="MuMimoEnableColleft" BindText="amp_MUMIMO"></td>
            <td id="MuMimoEnableTd" class="table_right width_per70">
            <input type='checkbox' id='MuMimoEnable' name='MuMimoEnable' value="ON">
                <span class="gray"> </span>
            </td>
        </tr>
		<tr border="1" id="X_HW_RSSIThresholdRow">
			<td class="table_title width_per30" id="X_HW_RSSIThresholdColleft" BindText="amp_wlan_rssithreshold"></td>
			<td id="X_HW_RSSIThresholdCol" class="table_right width_per70">
				<input id="X_HW_RSSIThreshold" type="text" class="TextBox">
				<font color="red" id="X_HW_RSSIThresholdRequire"></font>
				<span class="gray" id="X_HW_RSSIThresholdRemark"></span>
			</td>
		</tr>
		<tr border="1" id="wds_EnableRow">
			<td class="table_title width_per30" id="wds_EnableColleft" BindText="amp_wds_enable"></td>
			<td id="wds_EnableCol" class="table_right width_per70">
				<input id="wds_Enable" type="checkbox" class="CheckBox" onclick="WdsClickFunc(this);">
				<font color="red" id="wds_EnableRequire"></font>
				<span class="gray" id="wds_Enablespan"></span>
			</td>
		</tr>
		<tr border="1" id="X_HW_WlanMacRow">
			<td class="table_title width_per30" id="X_HW_WlanMacColleft" BindText="amp_wds_address_master"></td>
			<td id="X_HW_WlanMac" class="table_right width_per70"></td>
		</tr>
		<tr border="1" id="wds_Ap1_BSSIDRow">
			<td class="table_title width_per30" id="wds_Ap1_BSSIDColleft" BindText="amp_wds_address_ap1"></td>
			<td id="wds_Ap1_BSSIDCol" class="table_right width_per70">
				<input id="wds_Ap1_BSSID" type="text" class="TextBox">
				<font color="red" id="wds_Ap1_BSSIDRequire"></font>
				<span class="gray" id="wds_Ap1_BSSIDRemark"></span>
			</td>
		</tr>
		<tr border="1" id="wds_Ap2_BSSIDRow">
			<td class="table_title width_per30" id="wds_Ap2_BSSIDColleft" BindText="amp_wds_address_ap2"></td>
			<td id="wds_Ap2_BSSIDCol" class="table_right width_per70">
				<input id="wds_Ap2_BSSID" type="text" class="TextBox">
				<font color="red" id="wds_Ap2_BSSIDRequire"></font>
				<span class="gray" id="wds_Ap2_BSSIDRemark"></span>
			</td>
		</tr>
		<tr border="1" id="wds_Ap3_BSSIDRow">
			<td class="table_title width_per30" id="wds_Ap3_BSSIDColleft" BindText="amp_wds_address_ap3"></td>
			<td id="wds_Ap3_BSSIDCol" class="table_right width_per70">
				<input id="wds_Ap3_BSSID" type="text" class="TextBox">
				<font color="red" id="wds_Ap3_BSSIDRequire"></font>
				<span class="gray" id="wds_Ap3_BSSIDRemark"></span>
			</td>
		</tr>
		<tr border="1" id="wds_Ap4_BSSIDRow">
			<td class="table_title width_per30" id="wds_Ap4_BSSIDColleft" BindText="amp_wds_address_ap4"></td>
			<td id="wds_Ap4_BSSIDCol" class="table_right width_per70">
				<input id="wds_Ap4_BSSID" type="text" class="TextBox">
				<font color="red" id="wds_Ap4_BSSIDRequire"></font>
				<span class="gray" id="wds_Ap4_BSSIDRemark"></span>
			</td>
		</tr>
	</tbody>
</table>
</div>	

<table id="AutoChannelScopeFt" width="100%" cellpadding="0" cellspacing="1" class="tabal_noborder_bg" style="display:none;">
	<tbody>
		<tr>       	
			<td class="table_title width_per30" ><script>document.write("Auto Channel Scope");</script></td> 
			
			<td>
				<table id="ponit" cellpadding="0" cellspacing="1" class="table_title width_per100">
					<tr>
						<td> <input name="WlanMethod" id="WlanMethod" type="radio" value="1" checked="checked" onclick="onClickMethod()"/>
						<script>
						if("2G" == wlanpage)
						{
							document.write("Thailand Standard (Recommend: Ch.1-11)");
						}
						else
						{
							document.write("Thailand Standard (Recommend: Ch.36-64 and Ch.149-161)");
						}
						</script>
						
						</td>
					</tr>
					<tr>
						<td> <input name="WlanMethod" id="WlanMethod" type="radio"  value="2"  onclick="onClickMethod()" />
						<script>document.write("Customize"); </script>							
							<table id="CustChannel_2g" style="display:none;">
								<tr>
								  <td><input type="checkbox" name="channel2g" value="1" id="Channel1" />Channel 1</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="2" id="Channel2" />Channel 2</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="3" id="Channel3" />Channel 3</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="4" id="Channel4" />Channel 4</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="5" id="Channel5" />Channel 5</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="6" id="Channel6" />Channel 6</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="7" id="Channel7" />Channel 7</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="8" id="Channel8" />Channel 8</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="9" id="Channel9" />Channel 9</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="10" id="Channel10" />Channel 10</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="11" id="Channel11" />Channel 11</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="12" id="Channel12" />Channel 12</td>
								</tr>
								<tr>
								  <td><input type="checkbox" name="channel2g" value="13" id="Channel13" />Channel 13</td>
								</tr>
							</table>				
							
							<table id="CustChannel_5g" style="display:none;">
							  <tr>
								<td width="198"><input type="checkbox" name="Band1" id="Band1" onclick="selectBand(this.id);" />Band 1</td>
								<td width="198"><input type="checkbox" name="Band2" id="Band2" onclick="selectBand(this.id);" />Band 2</td>
								<td width="198"><input type="checkbox" name="Band3" id="Band3" onclick="selectBand(this.id);" />Band 3</td>
							  </tr>
							  <tr>
								<td valign="top">
								  <table id="CustChannel_Band1">
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="36" id="Channel_0" />Channel 36</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="40" id="Channel_1" />Channel 40</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="44" id="Channel_2" />Channel 44</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="48" id="Channel_3" />Channel 48</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="52" id="Channel_4" />Channel 52</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="56" id="Channel_5" />Channel 56</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="60" id="Channel_6" />Channel 60</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand1" value="64" id="Channel_7" />Channel 64</td>
									</tr>	
								  </table>
								</td>
								<td valign="top">
								  <table id="CustChannel_Band2">
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="100" id="Channel_8" />Channel 100</td>
								    </tr>
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="104" id="Channel_9" />Channel 104</td>
								    </tr>
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="108" id="Channel_10" />Channel 108</td>
								    </tr>
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="112" id="Channel_11" />Channel 112</td>
								    </tr>
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="116" id="Channel_12" />Channel 116</td>
								    </tr>
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="120" id="Channel_13" />Channel 120</td>
								    </tr>
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="124" id="Channel_14" />Channel 124</td>
								    </tr>
								    <tr>
									  <td><input type="checkbox" name="ChBand2" value="128" id="Channel_15" />Channel 128</td>
								    </tr>
									<tr>
									  <td><input type="checkbox" name="ChBand2" value="132" id="Channel_16" />Channel 132</td>
								    </tr>
									<tr>
									  <td><input type="checkbox" name="ChBand2" value="136" id="Channel_17" />Channel 136</td>
								    </tr>
									<tr>
									  <td><input type="checkbox" name="ChBand2" value="140" id="Channel_18" />Channel 140</td>
								    </tr>									
									<tr>
									  <td><input type="checkbox" name="ChBand2" value="144" id="Channel_19" />Channel 144</td>
								    </tr>	
								  </table>
								</td>
								<td valign="top">
								  <table id="CustChannel_Band3">
									<tr>
									  <td><input type="checkbox" name="ChBand3" value="149" id="Channel_16" />Channel 149</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand3" value="153" id="Channel_17" />Channel 153</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand3" value="157" id="Channel_18" />Channel 157</td>
									</tr>
									<tr>
									  <td><input type="checkbox" name="ChBand3" value="161" id="Channel_19" />Channel 161</td>
									</tr>
								  </table>
								</td>
							  </tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<tbody>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
<tr>
    <td class="table_submit width_per25"></td>
    <td class="table_submit"> 
    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    <button id="applyButton" name="applyButton" type="button" class="ApplyButtoncss buttonwidth_100px" onClick="Submit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_apply']);</script></button>
    <button id="cancelButton" name="cancelButton" type="button" class="CancleButtonCss buttonwidth_100px" onClick="CancelConfig();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
    </td>
</tr>
</table>

</form>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
<tr ><td class="height10p"></td></tr>
</table>
</div>

</body>
</html>
