<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>用户侧丢帧检测信息</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">

function LoadFrame() 
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}

		b.innerHTML = status_frameinfo_language[b.getAttribute("BindText")];
	}
}

function FrameInfo(domain,DetectionsState,ResultNumber,ResultTotal,ResultTotalEx)
{  
    this.domain   = domain;
    this.state    = DetectionsState;
    this.number   = ResultNumber;
	this.result   = ResultTotal;
	this.resultex   = ResultTotalEx;
}
function DevFrameInst(mac, lostrate, delay, jetter)
{  
    this.mac        = mac;
    this.lostrate   = lostrate;
    this.delay      = delay;
	this.jetter     = jetter;
}

function GEInfo(domain)
{
	this.domain  = domain;
}

var FrameInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_Framedetection, DetectionsState|ResultNumberOfEntries|ResultTotal|ResultTotalEx,FrameInfo);%>;
var state = false;
var DevFrameArray = new Array();

if (FrameInfos.length > 1)
{
    if (FrameInfos[0].state == "Complete")
	{
	    state =  true;
		
		var Idx = 0;
		records = FrameInfos[0].result.split('-');
		for (var i = 0; i < records.length; i++)
	    {
		    var temp = records[i].split(':');
	        if (temp.length != 9)
			{
			    continue;
			}
			
		    DevFrameArray[Idx] = new DevFrameInst(temp[0] + ":"+ temp[1] + ":" + temp[2] + ":" + temp[3] +":" + temp[4] +":"+ temp[5], temp[6], temp[7], temp[8]);
			Idx++;
		}
	}
}

var lanDscArr = new Array();
var ethTypeArr = '<%HW_WEB_GetEthTypeList();%>';
var GEPortNum = 0;
var PortIndex = 1;
var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var TianYiFlag = '<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>';
var geInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Link,GEInfo);%>;
var stbport = '<%HW_WEB_GetSTBPort();%>';

for(var i = 1; i <= parseInt(ethTypeArr.charAt(0)) ; i++)
{
	if ('1' != ethTypeArr.charAt(i))
	{
		GEPortNum++;
	}
}
for(var i = 1; i <= parseInt(ethTypeArr.charAt(0)) ; i++)
{
    if (2 == i && 4 == ethTypeArr.charAt(0) && ('E8C' == CurrentBin.toUpperCase()))
    {
        lanDscArr.push("iTV");
        if (1 != GEPortNum)
        {
            PortIndex++;
        }
    }
    else
    {
        if ('1' != ethTypeArr.charAt(i))
        {
            if (1 == GEPortNum)
            {
                lanDscArr.push("千兆口");
            }
            else
            {
                lanDscArr.push("千兆口" + PortIndex);
            }
            PortIndex++;
        }
        else
        {
            lanDscArr.push("百兆口" + PortIndex);
            PortIndex++;
        }
    }
}

function getTianYilandesc(lanid)
{
	
	if(lanid > parseInt(ethTypeArr.charAt(0)))
	{
		return "";
	}	

	return lanDscArr[lanid - 1];
}

function isPortInAttrName()
{
    if((1 == TianYiFlag) && ('E8C' == CurrentBin.toUpperCase()))
	{
		return true;
	}
	return false;
}

function getlandesc(lanid)
{
	var landesc;
	if(isPortInAttrName())
	{
		landesc = getTianYilandesc(lanid);
		if(lanid == 2)
		{
			landesc = "iTV";
		}
	}
	else
	{
		landesc = "网口" + lanid;
	}

	if ((lanid == 0) || (lanid > geInfos.length - 1))
	{
		landesc = "";
	}
	
	if( lanid == stbport)
	{
		landesc = "内置STB";
	}

	return landesc;
}

var recordsex = FrameInfos[0].resultex.split('-');
var minRcd;
for (var i = 0; i < recordsex.length; i++)
{
	var temp1 = recordsex[i].split(':');
	if (temp1.length != 10)
	{
		continue;
	}
	for (var j = i+1; j < recordsex.length; j++)
	{
		var temp2 = recordsex[j].split(':');
		if (temp2.length != 10)
		{
			continue;
		}
		
		if (temp1[6] > temp2[6])
		{
			minRcd = recordsex[i];
			recordsex[i] = recordsex[j];
			recordsex[j] = minRcd;
		}
	}
}

function getLanDescByDevFrameIdx(idx)
{
	for (var i = 0; i < recordsex.length; i++)
	{
		if (i != idx)
		{
			continue;
		}

		var temp = recordsex[i].split(':');
		if (temp.length != 10)
		{
			continue;
		}
		
		var lanx = temp[6];
		if (lanx.substr(0, 3) == "Lan")
		{
			var lanid = parseInt(lanx.substr(3));
			return getlandesc(lanid);
		}
	}
	
	return "";
}

function appendstr(str)
{
	return str;
}

function createframetable()
{
    var output = "";
    if(( false == state ) || (DevFrameArray.length == 0) )
    {			
        output = output + appendstr("<tr class=\"tabal_01\">");
        output = output + appendstr('<td class=\"align_left\">' + '--'	+ '</td>');
        output = output + appendstr('<td class=\"align_left\">' + '--'	+ '</td>');
        output = output + appendstr('<td class=\"align_left\">' + '--'	+ '</td>');
        output = output + appendstr('<td class=\"align_left\">' + '--'	+ '</td>');
        output = output + appendstr('<td class=\"align_left\">' + '--'	+ '</td>');
        output = output + appendstr("</tr>");
    }
	else
	{
	    for(i = 0; i < DevFrameArray.length; i++)
        {
            output = output + appendstr("<tr class=\"tabal_01\">");
			output = output + appendstr('<td class=\"align_left\">' + htmlencode(getLanDescByDevFrameIdx(i)) + '</td>');
            output = output + appendstr('<td class=\"align_left\">' + htmlencode(DevFrameArray[i].mac) + '</td>');
            output = output + appendstr('<td class=\"align_left\">' + htmlencode(DevFrameArray[i].lostrate) + '</td>');
            output = output + appendstr('<td class=\"align_left\">' + htmlencode(DevFrameArray[i].delay) + '</td>');
            output = output + appendstr('<td class=\"align_left\">' + htmlencode(DevFrameArray[i].jetter) + '</td>');
            output = output + appendstr("</tr>");
        } 
	}
		
    $("#frameinfotitle").after(output);
}
	
</script>
</head>

<body onLoad="LoadFrame();" class="mainbody">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="prompt">
            <label id="Title_frameinfo_lable" class="title_common">在本页面上，您可以查询用户侧设备丢帧检测信息。</label>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height_15px"></td>
	</tr>
</table>

<div id="divFrameInfo">
<table id="frameinfo_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
    <tr>
        <td class="table_left width_25p" BindText='bbsp_frameinfo_status'></td>
        <td class="table_right"> 
        <script language="JavaScript" type="text/javascript">
            if ( true == state )
            {
                document.write(status_frameinfo_language['bbsp_frameinfo_completed'] + '&nbsp;&nbsp;');
            }
            else
            {
                document.write(status_frameinfo_language['bbsp_frameinfo_uncompleted'] + '&nbsp;&nbsp;');
            }
        </script>
    </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height_15px"></td></tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" cellspacing="1" >
	<tr class="tabal_head">  
	<td BindText='bbsp_frameinfo_result'></td>
	</tr>
</table>


<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
	<tr class="table_title" id="frameinfotitle">
		<td class="table_left width_20p" BindText='bbsp_frameinfo_lanx'></td>
	    <td class="table_left width_20p" BindText='bbsp_frameinfo_devmac'></td>
	    <td class="table_left width_20p" BindText='bbsp_frameinfo_lostrate'></td>
	    <td class="table_left width_20p" BindText='bbsp_frameinfo_delay'></td>
		<td class="table_left width_20p" BindText='bbsp_frameinfo_jitter'></td>
	</tr>
	<script type="text/javascript" language="javascript">
	    createframetable();	
	</script>
</table>
</div>

</body>
</html>
