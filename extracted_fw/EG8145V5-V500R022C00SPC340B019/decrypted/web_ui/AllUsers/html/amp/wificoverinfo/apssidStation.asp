<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wificoverinfo_language);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>

<title>WLAN智能覆盖网络信息</title>
<script language="JavaScript" type="text/javascript">

function LoadResource()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) 
    {
        var b = all[i];
        if(b.getAttribute("BindText") == null)
        {
            continue;
        }

        if (cfg_wificoverinfo_language[b.getAttribute("BindText")]) 
        {
            b.innerHTML = cfg_wificoverinfo_language[b.getAttribute("BindText")];
        }
    }
}

function ApSsidStation(staMac, staUptime, staRxRate, staTxRate, staRssi, staNoise, staSnr, staSignalQuality, X_HW_AntennaNum, X_HW_11kSupported, X_HW_11vSupported, X_HW_DualBandSupported, X_HW_BeamFormingSupported, wifiCoverName)
{
	this.staMac = staMac;
	this.staUptime = staUptime;
	this.staRxRate = staRxRate;
	this.staTxRate = staTxRate;
	
	this.staRssi = staRssi;
	this.staNoise = staNoise;
	this.staSnr = staSnr;
	this.staSignalQuality = staSignalQuality;	

	this.X_HW_AntennaNum = X_HW_AntennaNum;
	this.X_HW_11kSupported = X_HW_11kSupported;
	this.X_HW_11vSupported = X_HW_11vSupported;
	this.X_HW_DualBandSupported = X_HW_DualBandSupported;
	this.X_HW_BeamFormingSupported = X_HW_BeamFormingSupported;

	this.wifiCoverName = wifiCoverName;
}

var stApSta = new Array(null);
var onlineFlag = '';
var wificoverApId = 1;
var wificoverApRfband = '';
if (location.href.indexOf("apssidStation.asp?") > 0)
{
	var wificoverApIdRfBand;
	
	wificoverApIdRfBand = location.href.split("?")[1];
	wificoverApId = wificoverApIdRfBand.split("&")[0];
	wificoverApRfband = wificoverApIdRfBand.split("&")[1];
	onlineFlag = wificoverApIdRfBand.split("&")[2];
	if (1 == onlineFlag)
	{
	    getApStaAjaxRequest(wificoverApId, wificoverApRfband);
	}
}

function getApStaAjaxRequest(apInst, rfband)
{
		$.ajax({
			 type : "POST",
			 async : false,
			 cache : false,
			 data : "apinst="+apInst+"&rfband="+rfband,
			 url : "../common/WlanGetApSta.asp?&1=1",
			 success : function(data) {
				if (data != '')
				{
					stApSta = dealDataWithStr(data);
				}	
			 }
		});
}

function setControl()
{
}

function LoadFrame()
{ 
    LoadResource();
   parent.document.getElementById('coverinfo_content').height = document.body.scrollHeight + 10;
}

</script>
</head>

<body  class="mainbody"  style="margin-left:0;margin-right:0;margin-top:0" onLoad="LoadFrame();" >

<div id="wlancoverAPDeviceInfo">

<div id="wlancoverAPDeviceInfo_Table_Container" style="overflow:auto;overflow-y:hidden">

<script language="JavaScript" type="text/JavaScript">
var index = 0;

var STATShowableFlag = 1;
var STAShowButtonFlag = 0;
var STAColumnNum = 14;
var StaArray = new Array();
var STAConfiglistInfo = new Array(
		new stTableTileInfo("amp_wificover_common_ssidname","align_center","wifiCoverName",false),
		new stTableTileInfo("amp_wificover_ap_sta_mac","align_center","staMac",false),
		new stTableTileInfo("amp_wificover_ap_sta_onlinetime","align_center","staUptime",false),
		new stTableTileInfo("amp_wificover_ap_sta_rate_rx","align_center","staRxRate",false),
		new stTableTileInfo("amp_wificover_ap_sta_rate_tx","align_center","staTxRate",false),
		new stTableTileInfo("amp_wificover_common_signal","align_center","staRssi",false),
		new stTableTileInfo("amp_wificover_common_noise","align_center","staNoise",false),
		new stTableTileInfo("amp_wificover_ap_sta_snr","align_center","staSnr",false),
		new stTableTileInfo("amp_wificover_ap_sta_noise","align_center","staSignalQuality",false),
		
		new stTableTileInfo("amp_stainfo_antenna_num","align_center","X_HW_AntennaNum",false),
		new stTableTileInfo("amp_stainfo_11k_supported","align_center","X_HW_11kSupported",false),
		new stTableTileInfo("amp_stainfo_11v_supported","align_center","X_HW_11vSupported",false),
		new stTableTileInfo("amp_stainfo_dualBand","align_center","X_HW_DualBandSupported",false),
		new stTableTileInfo("amp_stainfo_beamforming","align_center","X_HW_BeamFormingSupported",!((1 == DoubleFreqFlag) && (wificoverApIdRfBand.split("&")[1] == '5G'))),null);

if ( 0 != stApSta.length - 1)
{
   for (index = 0; index < stApSta.length - 1; index ++)
   {
		StaArray.push(stApSta[index]);
   }
}

StaArray.push(null);

HWShowTableListByType(STATShowableFlag, "wlancoverAPDeviceInfo_table", STAShowButtonFlag, STAColumnNum, StaArray, STAConfiglistInfo, cfg_wificoverinfo_language, null);

window.parent.document.getElementById("WifiStatusShow").style.display = "none";

fixIETableScroll("wlancoverAPDeviceInfo_Table_Container", "wlancoverAPDeviceInfo_table");

</script>

</div>

<div class="func_spread"></div>

</div>


</body>
</html>
