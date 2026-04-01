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
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

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

function stapStats(SSID,AssociatedDevNum,TotalBytesReceived,TotalPacketsReceived,ErrorsReceived,DiscardPacketsReceived,TotalBytesSent,TotalPacketsSent,ErrorsSent,DiscardPacketsSent)
{
	this.SSID = SSID;
    this.AssociatedDevNum = AssociatedDevNum;
	this.TotalBytesReceived = TotalBytesReceived;
	this.TotalPacketsReceived = TotalPacketsReceived;
	this.ErrorsReceived = ErrorsReceived;
	this.DiscardPacketsReceived = DiscardPacketsReceived;
    this.TotalBytesSent = TotalBytesSent;
	this.TotalPacketsSent = TotalPacketsSent;	
	this.ErrorsSent = ErrorsSent;
	this.DiscardPacketsSent = DiscardPacketsSent;
}

var apStats = new Array(null);
var onlineFlag = '';
var wificoverApId = 1;
var wificoverApRfband = '';

if (location.href.indexOf("apssidStat.asp?") > 0)
{
	var wificoverApIdRfBand;

	wificoverApIdRfBand = location.href.split("?")[1];
	wificoverApId = wificoverApIdRfBand.split("&")[0];
	wificoverApRfband = wificoverApIdRfBand.split("&")[1];
	onlineFlag = wificoverApIdRfBand.split("&")[2];
	if (1 == onlineFlag)
	{
	    getApStatAjaxRequest(wificoverApId, wificoverApRfband);
	}
}

function getApStatAjaxRequest(apInst, rfband)
{
    $.ajax({
    	 type : "POST",
    	 async : false,
    	 cache : false,
    	 data : "apinst="+apInst+"&rfband="+rfband,
    	 url : "../common/WlanGetApStatistic.asp?&1=1",
    	 success : function(data) {
    		if (data != '')
    		{
    			apStats = dealDataWithStr(data);
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
	fixIETableScroll("ApssidstatInfo_Table_Container", "tbApssidstat");

    if (rosunionGame == 1) {
        $('#tbApssidstat').addClass('rosTableNoBoder');
        $('#tbApssidstat td').css('border-bottom', '1px solid #6d6060');
    }
}

function AppendApStatContent()
{
    var index = 0;
    if (0 == apStats.length - 1)
    {
        document.writeln("<tr class='tabal_01'>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("<td class='align_center'>--</td>");
        document.writeln("</tr>");
    }
    else
    {
        for (index = 0; index < apStats.length - 1; index++)
        {
            if( (apStats.length - 1)%2 )
        	{
        		document.write("<tr class=\"tabal_01\">");
        	}
        	else
        	{
        		document.write("<tr class=\"tabal_02\">");
        	}

        	document.write('<td class=\"align_center\">'+ htmlencode(apStats[index].SSID) +'</td>');

            document.write('<td class=\"align_center\">'+apStats[index].AssociatedDevNum	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].TotalBytesReceived	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].TotalPacketsReceived	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].ErrorsReceived	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].DiscardPacketsReceived	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].TotalBytesSent	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].TotalPacketsSent	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].ErrorsSent	+'</td>');
        	document.write('<td class=\"align_center\">'+apStats[index].DiscardPacketsSent	+'</td>');

        	document.write("</tr>");
            }    	
    }
    window.parent.document.getElementById("WifiStatusShow").style.display = "none";	
}

</script>
</head>

<body  class="mainbody"  style="margin-left:0;margin-right:0;margin-top:0" onLoad="LoadFrame();">

<div id="ApssidstatInfo">

<div id="ApssidstatInfo_Table_Container" style="overflow:auto;overflow-y:hidden">

<table id="tbApssidstat" width="100%" cellspacing="1" class="tabal_bg" border="0">
  <tr class="head_title"> 
    <td rowspan="2" BindText='amp_wificover_common_ssidname'></td>
    <td rowspan="2" BindText='amp_wificover_ap_stats_devnum'></td>
    <td colspan="4" align="center"BindText='amp_wificover_ap_stats_rx'></td>
    <td colspan="4" align="center"BindText='amp_wificover_ap_stats_tx'></td>
  </tr>
  <tr class="head_title"> 
    <td BindText='amp_wificover_ap_stats_byte'></td>
    <td BindText='amp_wificover_ap_stats_pkg'></td>
    <td BindText='amp_wificover_ap_stats_errpkg'></td>
    <td BindText='amp_wificover_ap_stats_droppkg'></td>
    <td BindText='amp_wificover_ap_stats_byte'></td>
    <td BindText='amp_wificover_ap_stats_pkg'></td>
    <td BindText='amp_wificover_ap_stats_errpkg'></td>
    <td BindText='amp_wificover_ap_stats_droppkg'></td>
  </tr>
  <script language="JavaScript" type="text/JavaScript">
    AppendApStatContent();
  </script>

</table>

</div>

<div class="func_spread"></div>

</div>

</body>
</html>
