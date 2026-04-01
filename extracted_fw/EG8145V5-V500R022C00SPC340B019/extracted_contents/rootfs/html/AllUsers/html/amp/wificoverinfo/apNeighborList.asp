<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wificoverinfo_language, status_wlaninfo_language);%>"></script>
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

function stApNeighbor(ssid, bssid, networktype, channel, rssi, noise, beacon, dtim, security, standard, MaxBitRate, RFBand)
{
	this.ssid = ssid;
	this.bssid = bssid;
	this.networktype = networktype;
	this.channel = channel;
	this.rssi = rssi;
	this.noise = noise;
	this.beacon = beacon;
	this.dtim = dtim;
	this.security = security;
	this.standard = standard;
	this.MaxBitRate = MaxBitRate;
	this.RFBand = RFBand;
}

var astApNeighbor = new Array(null);

var wificoverApId = 1;
var wificoverApRfband = '';
var onlineFlag  = '';
if (location.href.indexOf("apNeighborList.asp?") > 0)
{
	var wificoverApIdRfBand;
	
	wificoverApIdRfBand = location.href.split("?")[1];
	wificoverApId = wificoverApIdRfBand.split("&")[0];
	wificoverApRfband = wificoverApIdRfBand.split("&")[1];
	
	onlineFlag = wificoverApIdRfBand.split("&")[2];
	if (1 == onlineFlag)
	{
	    getApNeighborInfoAjaxRequest(wificoverApId, wificoverApRfband);
	}
}

function StartFileOpt()
{
    XmlHttpSendAspFlieWithoutResponse("../../ssmp/common/StartFileLoad.asp");
}

function getApNeighborInfoAjaxRequest(apInst, rfband)
{
	StartFileOpt();
	
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : "apinst="+apInst+"&rfband="+rfband,
		url : "../common/WlanGetApNeighborinfo.asp?&1=1",
		success : function(data) {
			if (data != '')
			{
				astApNeighbor = dealDataWithStr(data);
			}			
		}
	});
}

function setControl()
{
}

function  processEmptyValue(record) 
{
    if(!record || typeof record != 'object') return false;
          	
    for(var pKey in record) 
	{
	
		if (record[pKey] == '-')
		{
			record[pKey] = '--';
		}
		
        record[pKey] = record[pKey] || '--';
    }
          		
    return true;
}

function convertApDataToHtml(record)
{
	if (processEmptyValue(record) == false)
	{
		return false;
	}
 	
	if( record.rssi < -80 )
	{
		record.rssi += status_wlaninfo_language['amp_stainfo_level1'];  
	}
	if(( record.rssi >= -80 )&&( record.rssi <= -75 ))
	{
		record.rssi += status_wlaninfo_language['amp_stainfo_level2'];  
	}
	if(( record.rssi > -75 )&&( record.rssi <= -69 ))
	{
		record.rssi += status_wlaninfo_language['amp_stainfo_level3'];  
	}
	if(( record.rssi > -69 )&&( record.rssi <= -63 ))
	{
		record.rssi += status_wlaninfo_language['amp_stainfo_level4'];  
	}
	if( record.rssi > -63 )
	{
		record.rssi += status_wlaninfo_language['amp_stainfo_level5'];  
	}

	record.bssid = record.bssid.toUpperCase();
	record.ssid = record.ssid;
	
	return true;
}

function LoadFrame()
{ 
    LoadResource();
   parent.document.getElementById('coverinfo_content').height = document.body.scrollHeight + 10;
}

</script>

</head>
<body class="mainbody" onLoad="LoadFrame();"  style="margin-left:0;margin-right:0;margin-top:0" >

<div id="wlancoverAPNeighInfo">

<div id="wlancoverAPNeighInfo_Table_Container" style="overflow:auto;overflow-y:hidden">

<script language="JavaScript" type="text/JavaScript">
var index = 0;
var apNeighbor ;

var APShowableFlag = 1;
var APShowButtonFlag = 0;
var APColumnNum = 11;
var APArray = new Array();
var APConfiglistInfo = new Array(
		new stTableTileInfo("amp_wificover_common_ssidname","align_center","ssid",false),
		new stTableTileInfo("amp_wificover_ap_sta_mac","align_center","bssid",false),
		new stTableTileInfo("amp_wificover_ap_neigh_type","align_center","networktype",false),
		new stTableTileInfo("amp_wificover_common_channel","align_center","channel",false),
		new stTableTileInfo("amp_wificover_common_signal","align_center","rssi",false),
		new stTableTileInfo("amp_wificover_common_noise","align_center","noise",false),
		new stTableTileInfo("amp_wificover_ap_neigh_DTIM","align_center","dtim",false),
		new stTableTileInfo("amp_wificover_ap_neigh_beacon","align_center","beacon",false),
		new stTableTileInfo("amp_wificover_common_auth","align_center","security",false),
		new stTableTileInfo("amp_wificover_ap_neigh_standard","align_center","standard",false),
		new stTableTileInfo("amp_wificover_ap_neigh_maxRate","align_center","MaxBitRate",false),null);
				  
if ( 0 != astApNeighbor.length - 1)
{
   for (index = 0; index < astApNeighbor.length - 1; index++)
    {
		/*astApNeighbor里频段信息在后台已经过滤过*/
		if (convertApDataToHtml(astApNeighbor[index]) == false)
		{
			continue;
		}
		
		if (('--' == astApNeighbor[index].bssid) || ('' == astApNeighbor[index].bssid))
		{
			continue;
		}
		
		APArray.push(astApNeighbor[index]);
    }   
}

APArray.push(null);

HWShowTableListByType(APShowableFlag, "tdwlancoverAPNeighInfo", APShowButtonFlag, APColumnNum, APArray, APConfiglistInfo, cfg_wificoverinfo_language, null);

window.parent.document.getElementById("WifiStatusShow").style.display = "none";

fixIETableScroll("wlancoverAPNeighInfo_Table_Container", "tdwlancoverAPNeighInfo");

</script>

</div>

<div class="func_spread"></div>

</div>

</body>
</html>
