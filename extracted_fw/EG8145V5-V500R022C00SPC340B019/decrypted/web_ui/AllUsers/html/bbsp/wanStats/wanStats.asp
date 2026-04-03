<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wanStatsinfo.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var RadioWanStatsList = GetRadioWanStatsList();
var appName = navigator.appName;
var TimerHandle;
var isSupportAboard = '<%HW_WEB_GetFeatureSupport(FT_ABOARD_FTTO);%>';

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
		b.innerHTML = RadioWanStats_language[b.getAttribute("BindText")];
	}
}

function GetBytesSent(Stats)
{
	var BytesSentHigh = parseInt(Stats.BytesSentH,10);
	var BytesSentLow = parseInt(Stats.BytesSentL,10);
	var BytesSentHighStr = BytesSentHigh.toString(16);
	var BytesSentLowStr = BytesSentLow.toString(16);
	var BytesSentLowlen= 8 - BytesSentLowStr.length;
	for(var i = 0; i < BytesSentLowlen; i++)
	{
		BytesSentLowStr = '0' + BytesSentLowStr;
	}
	var BytesSentStr = BytesSentHighStr + BytesSentLowStr;
	var BytesSentNum = parseInt(BytesSentStr,16);
	return BytesSentNum;
}

function GetBytesReceived(Stats)
{
	var BytesReceivedHigh = parseInt(Stats.BytesReceivedH,10);
	var BytesReceivedLow = parseInt(Stats.BytesReceivedL,10);
	var BytesReceivedHighStr = BytesReceivedHigh.toString(16);
	var BytesReceivedLowStr = BytesReceivedLow.toString(16);
	var BytesReceivedLowlen= 8 - BytesReceivedLowStr.length;
	for(var i = 0; i < BytesReceivedLowlen; i++)
	{
		BytesReceivedLowStr = '0' + BytesReceivedLowStr;
	}
	var BytesReceivedStr = BytesReceivedHighStr + BytesReceivedLowStr;
	var BytesReceivedNum = parseInt(BytesReceivedStr,16);
	return BytesReceivedNum;
}

function GetSignalStrength(SignalStrength)
{
	var StrSignalStrength = '';
	SignalStrength = SignalStrength.toUpperCase();
	switch (SignalStrength)
	{
		case 'NOSIGNAL':
			StrSignalStrength = RadioWanStats_language['bbsp_nosignal'];
			break;
		case 'VERYLOW':
			StrSignalStrength = RadioWanStats_language['bbsp_verylow'];
			break;
		case 'LOW':
			StrSignalStrength = RadioWanStats_language['bbsp_low'];
			break; 
		case 'GOOD':
			StrSignalStrength = RadioWanStats_language['bbsp_good'];
			break; 
		case 'VERYGOOD':
			StrSignalStrength = RadioWanStats_language['bbsp_verygood'];
			break; 
		case 'EXCELLENT':
			StrSignalStrength = RadioWanStats_language['bbsp_excellent'];
			break;
		default:
			StrSignalStrength = RadioWanStats_language['bbsp_nosignal'];
			break;
	}
	return StrSignalStrength;
}
function StatsRefresh()
{
	var Onttoken = getValue('onttoken');
	$.ajax({
            type : "POST",
            async : false,
            cache : false,
            data : '&x.X_HW_Token='+ Onttoken,
            url : "./GetRadioWanStatsResult.asp",
            success : function(data) {
                RadioWanStatsList = dealDataWithFun(data);
                setStatInfo(RadioWanStatsList);
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) 
            {
                if (TimerHandle != undefined)
                {
                    clearInterval(TimerHandle);
                }	
            },
            complete: function (XHR, TS) 
            { 
                RadioWanStatsList=null;
             	XHR = null;
            }		
        });
}

function setStatInfo(RadioWanStatsList)
{
	SetDivValue('DivUploadData',GetBytesSent(RadioWanStatsList[0])+RadioWanStats_language['bbsp_wanstat_bytes']);
	SetDivValue('DivDownloadData',GetBytesReceived(RadioWanStatsList[0])+RadioWanStats_language['bbsp_wanstat_bytes']);
	SetDivValue('DivSignalStrength',GetSignalStrength(RadioWanStatsList[0].SignalStrength));
	if ('INSERVICE' == RadioWanStatsList[0].ServiceStatus.toUpperCase())
	{
		SetDivValue('DivServiceStatus',RadioWanStats_language['bbsp_service']);
	}
	else 
	{
		SetDivValue('DivServiceStatus',RadioWanStats_language['bbsp_noservice']);
	}
}


function StatsClear()
{
	var Form = new webSubmitForm();
	Form.addParameter('x.ResetStats',1);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
  	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Radio_WAN_Stats' + '&RequestFile=html/bbsp/wanStats/wanStats.asp');
    Form.submit();
}

function OnPageLoad()
{
	loadlanguage();
	TimerHandle = setInterval("StatsRefresh()", 10000);
	setTimeout("StatsRefresh()", 1000);
	return true;
}

</script>
<title>WanStat</title>
</head>
<script language="JavaScript" type="text/javascript"> 
if (appName == "Microsoft Internet Explorer")
{
	document.write('<body onLoad="OnPageLoad();" class="mainbody" scroll="auto">');
}
else
{
	document.write('<body onLoad="OnPageLoad();" class="mainbody" >');
	document.write('<DIV style="WIDTH: 100%; HEIGHT: 460px">');
}
</script>
<div>
<script language="JavaScript" type="text/javascript">
	if (isSupportAboard) {
		HWCreatePageHeadInfo("wanstatstitle", GetDescFormArrayById(RadioWanStats_language, "bbsp_mune_ftto"), GetDescFormArrayById(RadioWanStats_language, "bbsp_wirelessinfo_desc_ftto"), false);
	} else {
		HWCreatePageHeadInfo("wanstatstitle", GetDescFormArrayById(RadioWanStats_language, "bbsp_mune"), GetDescFormArrayById(RadioWanStats_language, "bbsp_wirelessinfo_desc"), false);
	}
</script> 
<div class="title_spread"></div>

<script language="JavaScript" type="text/javascript">
    if (isSupportAboard) {
        document.write('<TR><TD width="100%" border="0" cellspacing="0" cellpadding="0">Wireless Interface Status Info</TD></TR>');
    } else {
        document.write('<TR><TD width="100%" border="0" cellspacing="0" cellpadding="0">Mobile Backup Interface Status Info</TD></TR>');
	}
</script>
<form id="ConfigForm"> 
  <div id="DivWanStatInfo">
 	 <table id="WanStatInfo" border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<tr> 
			<td class="table_title width_per35" BindText='bbsp_uploaddata'></td> 
			<td class="table_right width_per65" id="UploadData"><div id="DivUploadData"></div></td> 
		</tr>
		<tr> 
			<td class="table_title width_per35" BindText='bbsp_downloaddata'></td> 
			<td class="table_right width_per65" id="DownloadData"><div id="DivDownloadData"></div></td> 
		</tr>
		<tr> 
			<td class="table_title width_per35" BindText='bbsp_signalstrength'></td> 
			<td class="table_right width_per65" id="SignalStrength"><div id="DivSignalStrength"></div></td> 
		</tr>
		<tr> 
			<td class="table_title width_per35" BindText='bbsp_servicestatus'></td> 
			<td class="table_right width_per65" id="ServiceStatus"><div id="DivServiceStatus"></div></td> 
		</tr>
   </table>
   <table cellpadding="0" cellspacing="1" width="100%" class="table_button"> 
    <tr> 
      <td class="align_right  table_submit">
	  	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"> 
        <button name="btnClear" id="btnClear" class="ApplyButtoncss buttonwidth_100px"  type="button" onClick="StatsClear();"><script>document.write(urlfiltersetting_language['bbsp_clear']);</script></button>
	</td> 
    </tr> 	
  </table> 
  </div>
</form> 
</div>
<script language="JavaScript" type="text/javascript">
if (appName != "Microsoft Internet Explorer")
{
	document.write('</DIV>');
}
</script> 
</body>
</html>
