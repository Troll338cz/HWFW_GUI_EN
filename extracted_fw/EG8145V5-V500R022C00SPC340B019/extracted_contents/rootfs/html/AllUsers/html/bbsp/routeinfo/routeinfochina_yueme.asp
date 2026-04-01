<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../resource/<%HW_WEB_Resource(diffcss.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>RouteShow</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" type="text/javascript">

function GetMatchWanName(Interface)
{
	var Wans = GetWanList();
	for(var i in Wans)
	{
		if(Interface.split("")[3] == Wans[i].MacId)
		{
			return MakeWanName1(Wans[i]);
		}
	}
	return Interface;
}

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
		b.innerHTML = routeinfo_language[b.getAttribute("BindText")];
	}
}

function LoadFrame()
{
	loadlanguage();

	$.ajax({
		type : "POST",
		async : true,
		cache : false,
		data : 'x.State=Creating&x.X_HW_Token='+getValue('onttoken') ,
		url : 'set.cgi?x=InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.RouteTable' ,
		error:function(XMLHttpRequest, textStatus, errorThrown) 
		{
		}
	});	
}

function RouteInfo(DestIPAddress,GatewayIPAddress,DestSubnetMask,Interface)
{
	this.DestIPAddress = DestIPAddress;
	this.DestSubnetMask	= DestSubnetMask;
	this.GatewayIPAddress = GatewayIPAddress;
	this.Interface = Interface;
}

function ShowRouteInfoTbl()
{
    var routeInfoRaw = "";
    var recordShow = new Array(0);
  
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "./GetRouteInfoProcResult.asp",
		success : function(data) {
			routeInfoRaw = dealDataWithFun(data);
		},
		complete: function (XHR, TS) { 
            resultState=null;			
			      XHR = null;
		}
	});
	
	var recordsRaw = routeInfoRaw.split("##");
	
	for(var i in recordsRaw){
		var aRecord = recordsRaw[i].split(",");
		if (4 === aRecord.length){
			recordShow.push(new RouteInfo(aRecord[0],aRecord[1],aRecord[2],aRecord[3]));
		}
	}
	
	if( 0 === recordShow.length )
	{
		$("#routeInfoTbl").append("<tr class=\"tabal_center01\"><td >--</td><td >--</td><td >--</td><td >--</td></tr>");
	}
	else
	{
		for(i = 0; i < recordShow.length; i++)   
		{
			var tblContent = "<tr class=\"tabal_center01 trTabContent\" ><td>" + htmlencode(recordShow[i].DestIPAddress) +'</td><td>' + htmlencode(recordShow[i].DestSubnetMask) +
			'</td><td>' + htmlencode(recordShow[i].GatewayIPAddress) + '</td><td>' + htmlencode(GetMatchWanName(recordShow[i].Interface)) +'</td></tr>';
			$("#routeInfoTbl").append(tblContent);
		}
	}
}

function GetRouteInfoResult()
{
	var resultState=null;
	
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "./GetRouteInfoProcState.asp",
		success : function(data) {
			resultState = dealDataWithFun(data);
			if(resultState.length > 1 && 'Completed' == resultState[0].state){
				ShowRouteInfoTbl();
				clearInterval(resultChecker);
			}
		},
		complete: function (XHR, TS) { 
            resultState=null;			
			XHR = null;
		}
	});
}

var resultChecker = setInterval("GetRouteInfoResult();",1000);

</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<table id="table_logtitle" width="100%" border="0" cellspacing="0" cellpadding="0">
<label id="Title_log_enable_lable" > 
<tr> 
<td><span style="font-size:15px;font-weight:bold;color:#66FFFF">路由表</span></td>
</tr>
<td><input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>"></td>
</label>  
</table>
<div id="routeTableDiv">
  <table id="routeInfoTbl" border="0" align="center" cellpadding="0" cellspacing="1" id='devlist' width="100%" class="tabal_bg">
    <tr class="head_title">
    <td style='width:25%' BindText='bbsp_ip'></td> 
    <td style='width:25%' BindText='bbsp_mask'></td> 
    <td style='width:20%' BindText='bbsp_gw'></td> 
    <td BindText='bbsp_if'></td> 
    </tr> 
  </table>
</div>
</body>
</html>
