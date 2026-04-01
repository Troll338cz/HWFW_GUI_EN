<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../../bbsp/common/lanuserinfo.asp"></script>
<title>用户侧以太网接口信息</title>
<script language="JavaScript" type="text/javascript">

var CurrentBin = '<%HW_WEB_GetBinMode();%>';
var stbport = '<%HW_WEB_GetSTBPort();%>';
var UpUserPortID = '<%HW_WEB_GetCurUpUserPortID();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';

var TianYiFlag = '<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>';
var AnHuiFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_AHCT);%>';
var acEthType = '<%HW_WEB_GetEthTypeList();%>'; 
var E8CRONGHEFlag = '<%HW_WEB_GetFeatureSupport(FT_SHMP_RONGHE);%>';
var intMax = 4294967296;
var lanDescArr = new Array();
var GEPortNum = 0;
var PortIndex = 1;
for(var i = 1; i <= parseInt(acEthType.charAt(0)) ; i++)
{
    if ('1' != acEthType.charAt(i))
    {
        GEPortNum++;
    }
}

for(var i = 1; i <= parseInt(acEthType.charAt(0)) ; i++)
{
    if (((2 == i) || ((3 == i) && (1 == AnHuiFlag))) && (4 == acEthType.charAt(0)) && ('E8C' == CurrentBin.toUpperCase()))
    {
        lanDescArr.push("iTV");
        if ((1 != GEPortNum) || (3 == i))
        {
            PortIndex++;
        }
    }
    else
    {
        if ('1' != acEthType.charAt(i))
        {
            if (1 == GEPortNum)
            {
                lanDescArr.push("千兆口");
            }
            else
            {
                lanDescArr.push("千兆口" + PortIndex);
            }
            PortIndex++;
        }
        else
        {
            lanDescArr.push("百兆口" + PortIndex);
            PortIndex++;
        }
    }
}

function getlandesc(lanid)
{
    if ('1' == TianYiFlag)
    {
        return lanDescArr[lanid - 1];
    }
    
	var landesc;
	landesc = "网口" + lanid;
	if ((0 == stbport) && (2 == lanid) && (4 == userEthInfos.length - 1) && ('E8C' == CurrentBin.toUpperCase()) && CfgMode.toUpperCase() != "GZGD")
	{
		landesc = "iTV";
	}
	
	if ((lanid == 0) || (lanid > userEthInfos.length - 1))
	{
		landesc = "";
	}

	return landesc;
}

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

		b.innerHTML = status_ethinfo_language[b.getAttribute("BindText")];
	}
}

function LANStats(domain,txPackets,txPackets_H,txGoodBytes,txGoodBytes_H,txBadBytes,txBadBytes_H,rxPackets,rxPackets_H,rxGoodBytes,rxGoodBytes_H,rxBadBytes,rxBadBytes_H)
{  
    this.domain   = domain;
    this.txPackets = parseInt(txPackets_H)*intMax + parseInt(txPackets);
    this.txBytes  = parseInt(txGoodBytes_H)*intMax + parseInt(txGoodBytes) + parseInt(txBadBytes) + parseInt(txBadBytes_H)*intMax;
    this.rxPackets = parseInt(rxPackets_H)*intMax + parseInt(rxPackets);
    this.rxBytes  = parseInt(rxGoodBytes_H)*intMax + parseInt(rxGoodBytes) + parseInt(rxBadBytes) + parseInt(rxBadBytes_H)*intMax;
}

var userEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.Statistics,SendFrame|SendFrame_H|SendGoodPktOcts|SendGoodPktOcts_H|SendBadPktOcts|SendBadPktOcts_H|RcvFrame|RcvFrame_H|RcvGoodPktOcts|RcvGoodPktOcts_H|RcvBadPktOcts|RcvBadPktOcts_H,LANStats);%>;

function GEInfo(domain,Mode,Speed,Status)
{
	this.domain		= domain;
	this.Mode 		= Mode;
	this.Speed 		= Speed;
	this.Status 	= Status;
	
	if(Status==1)
	{
		if(Mode==0)this.Mode = status_ethinfo_language['amp_port_halfduplex'];
		if(Mode==1)this.Mode = status_ethinfo_language['amp_port_fullduplex'];

		if(Speed==0)this.Speed = status_ethinfo_language['amp_port_10M'];
		if(Speed==1)this.Speed = status_ethinfo_language['amp_port_100M'];
		if(Speed==2)this.Speed = status_ethinfo_language['amp_port_1000M'];
		if(Speed==3)this.Speed = status_ethinfo_language['amp_port_2500M'];
		if(Speed==4)this.Speed = status_ethinfo_language['amp_port_10000M'];
		if(Speed==6)this.Speed = status_ethinfo_language['amp_port_5000M'];
		
		this.Status = "已连接设备";
	}
	else
	{	
		this.Mode = "--";
		this.Speed = "--";
		this.Status = "未连接设备";
	}
}

var geInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig,Duplex|Speed|Link,GEInfo);%>;
</script>
</head>

<body onLoad="LoadFrame();" class="mainbody">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="prompt">
            <label id="Title_eth_satus_lable" class="title_common">在本页面上，您可以查询用户侧以太网接口信息。</label>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height15p"></td>
	</tr>
</table>

<div id="divDhcpInfo">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td BindText='amp_dhcpinfo_title'></td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
	<tr class="table_title" id="dhcpinfotitle">
	    <td BindText='amp_dhcpinfo_ipadd'></td>
	    <td BindText='amp_dhcpinfo_macadd'></td>
	    <td BindText='amp_dhcpinfo_dev'></td>
		<td BindText='amp_ethinfo_portnum'></td>
	</tr>
	<script type="text/javascript" language="javascript">
	function appendstr(str)
	{
		return str;
	}
	function createdhcptable(lanuserdhcpinfos, lanuserdevinfos)
	{
		var dhcpNum = lanuserdhcpinfos.length - 1;
		var Count = 0;
		var output = "";
		for(i=0;i< dhcpNum ;i++)
		{
			if (0 == lanuserdhcpinfos[i].remaintime)
			{
				continue;
			}

			for (j = 0;j < lanuserdevinfos.length - 1; j++)
			{
				if ((lanuserdhcpinfos[i].ip == lanuserdevinfos[j].IpAddr) && (lanuserdhcpinfos[i].mac == lanuserdevinfos[j].MacAddr))
				{
					break;
				}
			}
			
			if (j == lanuserdevinfos.length - 1)
			{
				continue;
			}
			
			if (stbport == parseInt(lanuserdevinfos[j].Port.charAt(lanuserdevinfos[j].Port.length -1)) && E8CRONGHEFlag == 1)
			{
				continue;
			}
			
			if (lanuserdevinfos[j].DevStatus.toUpperCase() =="OFFLINE")
			{
				continue;
			}
			
			if ('ETH' != lanuserdevinfos[j].PortType)
			{
				continue;
			}

			Count++;

			if(Count%2 == 0)
			{
				output = output + appendstr("<tr class=\"tabal_01\">");
			}
			else
			{
				output = output + appendstr("<tr class=\"tabal_02\">");
			}

			output = output + appendstr('<td class=\"align_left\">'+lanuserdevinfos[j].IpAddr	+'</td>');
			output = output + appendstr('<td class=\"align_left\">'+lanuserdevinfos[j].MacAddr	+'</td>');
			output = output + appendstr('<td class=\"align_left\">'+htmlencode(lanuserdevinfos[j].DevType) +'</td>');
			if("--" == lanuserdevinfos[j].Port)
			{
				output = output + appendstr('<td class=\"align_left\">--</td>');
			}
			else if (stbport == parseInt(lanuserdevinfos[j].Port.charAt(lanuserdevinfos[j].Port.length -1)))
			{
				output = output + appendstr('<td class=\"align_left\">'+ status_ethinfo_language['amp_port_inner_stb'] +'</td>');
			}
			else if (UpUserPortID == parseInt(lanuserdevinfos[j].Port.charAt(lanuserdevinfos[j].Port.length -1)))
			{
				output = output + appendstr('<td class=\"align_left\">' +  status_ethinfo_language['amp_port_wan'] +'</td>');
			}
			else
			{
				output = output + appendstr('<td class=\"align_left\">'+getlandesc(parseInt(lanuserdevinfos[j].Port.charAt(lanuserdevinfos[j].Port.length -1))) +'</td>');
			}

			output = output + appendstr("</tr>");
		}

		if(( 0 == dhcpNum ) || (Count == 0) )
		{			
			output = output + appendstr("<tr class=\"tabal_01\">");
			output = output + appendstr('<td class=\"align_left\">'+'--'	+'</td>');
			output = output + appendstr('<td class=\"align_left\">'+'--'	+'</td>');
			output = output + appendstr('<td class=\"align_left\">'+'--'	+'</td>');
			output = output + appendstr('<td class=\"align_left\">'+'--'	+'</td>');
			output = output + appendstr("</tr>");
		}
		
		$("#dhcpinfotitle").after(output);
	}
	
	GetLanUserInfo(function(lanuserdhcpinfos, lanuserdevinfos)
	{
		createdhcptable(lanuserdhcpinfos, lanuserdevinfos);	
	});
	
	</script>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr ><td class="height15p"></td></tr>
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="tabal_head">
    <td id="Table_laninterface_table" BindText='amp_ethinfo_title'></td>
    </tr>
</table>

<table id="eth_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
	<tr class="table_title" align="center">
    <td id="Table_laninterface_1_1_table" colspan="1" rowspan="2" BindText='amp_ethinfo_portnum'></td>
	<td id="Table_laninterface_1_2_table" colspan="3" BindText='amp_ethinfo_portstatus'></td>
	<td id="Table_laninterface_1_3_table" colspan="2" BindText='amp_ethinfo_rx'></td>
	<td id="Table_laninterface_1_4_table" colspan="2" BindText='amp_ethinfo_tx'></td>
	</tr>
                    
    <tr class="table_title" align="center">
    <td id="Table_laninterface_2_2_table" BindText='amp_ethinfo_duplex'></td>
    <td id="Table_laninterface_2_3_table" BindText='amp_ethinfo_speed'></td>
    <td id="Table_laninterface_2_4_table" BindText='amp_ethinfo_link'></td>
	<td id="Table_laninterface_2_5_table" BindText='amp_ethinfo_bytes'></td>
	<td id="Table_laninterface_2_6_table" BindText='amp_ethinfo_pkts'></td>
	<td id="Table_laninterface_2_7_table" BindText='amp_ethinfo_bytes'></td>
	<td id="Table_laninterface_2_8_table" BindText='amp_ethinfo_pkts'></td>
    </tr>
	
    <script type="text/javascript" language="javascript">
	if( 1 == userEthInfos.length || null == userEthInfos)
	{
		document.write("<tr class=\"tabal_01\">");
		document.write('<td>'+'&nbsp '	+'</td>');
		document.write('<td>'+'&nbsp '	+'</td>');
		document.write('<td>'+'&nbsp '	+'</td>');
		document.write('<td>'+'&nbsp '	+'</td>');
		
        document.write('<td>'+'&nbsp '	+'</td>');
		document.write('<td>'+'&nbsp '	+'</td>');
		document.write('<td>'+'&nbsp '	+'</td>');
		document.write('<td>'+'&nbsp '	+'</td>');
		document.write("</tr>");
	}	

	var lanid;
	for(i=0;i<userEthInfos.length - 1;i++)
	{
	    lanid = i+1;
		
		/* 控件id */		
		var id_lanid = "Table_laninterface_" + (3+i) + "_1_table";
		var id_Mode = "Table_laninterface_" + (3+i) + "_2_table";
		var id_Speed = "Table_laninterface_" + (3+i) + "_3_table";
		var id_Status = "Table_laninterface_" + (3+i) + "_4_table";
		var id_rxBytes = "Table_laninterface_" + (3+i) + "_5_table";
		var id_rxPackets = "Table_laninterface_" + (3+i) + "_6_table";
		var id_txBytes = "Table_laninterface_" + (3+i) + "_7_table";
		var id_txPackets = "Table_laninterface_" + (3+i) + "_8_table";

		if (stbport == lanid && E8CRONGHEFlag == 1)
		{
			continue;
		}
		
		if(i%2 == 0)
		{
		    document.write("<tr class=\"tabal_01\">");
		}
		else
		{
		    document.write("<tr class=\"tabal_02\">");
		}
              if (stbport == lanid)
              {
		    document.write('<td id=' + id_lanid + '>' +  status_ethinfo_language['amp_port_inner_stb'] +'</td>');
              }
			  else if (UpUserPortID == lanid)
              {
				document.write('<td id=' + id_lanid + '>' +  status_ethinfo_language['amp_port_wan'] +'</td>');
              }
              else
              {
		    document.write('<td id=' + id_lanid + '>' +  getlandesc(lanid) +'</td>');
              }
		document.write('<td id=' + id_Mode + '>' +geInfos[i].Mode	+'</td>');
		document.write('<td id=' + id_Speed + '>' +geInfos[i].Speed	+'</td>');
		document.write('<td id=' + id_Status + '>' +geInfos[i].Status	+'</td>');

        document.write('<td id=' + id_rxBytes + '>' +userEthInfos[i].rxBytes	+'</td>');
		document.write('<td id=' + id_rxPackets + '>' +userEthInfos[i].rxPackets	+'</td>');
		document.write('<td id=' + id_txBytes + '>' +userEthInfos[i].txBytes	+'</td>');
		document.write('<td id=' + id_txPackets + '>' +userEthInfos[i].txPackets	+'</td>');
		document.write("</tr>");
	   
	}
	</script>
</table>
</body>
</html>
