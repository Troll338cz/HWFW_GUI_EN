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
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/wandns.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>

<script>
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
			setObjNoEncodeInnerHtmlValue(b, dhcp_info_language[b.getAttribute("BindText")]);
		}
	}

    function DhcpInfoClass(domain, DUID, IPAddress, PrefixLen, Duration)
    {
        this.domain = domain;
        this.DUID    = DUID;
        this.IPAddress = IPAddress;
        this.PrefixLen = PrefixLen;
		this.Duration = Duration;
    }
	
	function DhcpPoolClass(domain, Prefix, MinAddress, MaxAddress)
    {
        this.domain = domain;
        this.Prefix    = Prefix;
        this.MinAddress = MinAddress;
        this.MaxAddress = MaxAddress;
    }

	function DhcpHostClass(domain, HostNumberOfEntries)
    {
        this.domain = domain;
        this.HostNumberOfEntries = HostNumberOfEntries;
    }

	var appName = navigator.appName;
    var RecordList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Hosts.Host.{i},DUID|IPAddress|PrefixLen|Duration, DhcpInfoClass);%>;
	var DhcpPoolInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_DhcpInfos, InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Server.Pool.1,Prefix|MinAddress|MaxAddress, DhcpPoolClass);%>;
	var DhcpHostInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_DhcpInfos, InternetGatewayDevice.LANDevice.1.X_HW_DHCPv6.Hosts,HostNumberOfEntries, DhcpHostClass);%>;

    var DhcpPoolInfo = DhcpPoolInfos[0];
	var DhcpHostInfo = DhcpHostInfos[0];
	var TotalIpNum = 0;
	var LeftIpAddrNum = 0;
	
	function IpToInteger(str)
	{
		var ipSeg;
		var IpInteger;
		ipSeg = str.split(':');
		IpInteger = ((parseInt(ipSeg[0],16) << 48 + parseInt(ipSeg[1],16) << 32) + parseInt(ipSeg[2],16) << 16) + parseInt(ipSeg[3],16);
		 
		return IpInteger;
	}

	function CalcIpNum()
	{
		if (DhcpPoolInfos.length-1>0)
		{
			TotalIpNum = IpToInteger(DhcpPoolInfo.MaxAddress) - IpToInteger(DhcpPoolInfo.MinAddress) + 1;
			LeftIpAddrNum = TotalIpNum - DhcpHostInfo.HostNumberOfEntries;
		}
	}

	function IsSupportStatandLeasedInfo()
	{
		if(!IsE8cFrame())
		{
			return true;
		}
		
		return false;
	}
	
	function setControl(index)
	{
	
	}

    function OnPageLoad()
    {
		if (IsSupportStatandLeasedInfo() == true)
		{
			setDisplay("DivDhcpStatInfo", 1);
		}
		else
		{
			setDisplay("DivDhcpStatInfo", 0);
		}
		loadlanguage();
        return true;
    }

</script>
<title>DHCPv6 Server Information</title>
</head>
<body onLoad="OnPageLoad();" class="mainbody">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("dhcpv6infotitle", GetDescFormArrayById(dhcp_info_language, "bbsp_mune"), GetDescFormArrayById(dhcp_info_language, ""), false);
	if (IsSupportStatandLeasedInfo() == true)
	 {
		  setNoEncodeInnerHtmlValue("dhcpv6infotitle_content", dhcp_info_language["bbsp_dhcp_info_title"]);
	 }
	 else
	 {
	 	 setNoEncodeInnerHtmlValue("dhcpv6infotitle_content", dhcp_info_language["bbsp_dhcp_info_title_e8c"]);
	 }
</script>
<div class="title_spread"></div>

<script>
	CalcIpNum();
</script>
  
<form id="DivDhcpStatInfo" name="DivDhcpStatInfo">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
		<li id="addrtotalnum" RealType="HtmlText" DescRef="bbsp_addrtotalnum" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="TotalIpNum"  InitValue="Empty" />
		<li id="leftaddrnum"  RealType="HtmlText" DescRef="bbsp_leftaddrnum"  RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="LeftIpAddrNum" InitValue="Empty" />
	</table>
	<script>
		var TableClass = new stTableClass("width_per35", "width_per65", "ltr");
		var DhcpStatFormList = new Array();
		DhcpStatFormList = HWGetLiIdListByForm("DivDhcpStatInfo",null);
		HWParsePageControlByID("DivDhcpStatInfo",TableClass,dhcp_info_language,null);
		setElementInnerHtmlById('addrtotalnum', TotalIpNum);
		setElementInnerHtmlById('leftaddrnum', LeftIpAddrNum);
	</script>
	<div class="func_spread"></div>
</form>

<script language="JavaScript" type="text/javascript">
	var Dhcpv6InfoConfiglistInfo = new Array();
	var ColumnNum = '';
	var ShowButtonFlag = false;
	var TableDataInfo = new Array();
	if (IsSupportStatandLeasedInfo() == true)
	{
		 Dhcpv6InfoConfiglistInfo = new Array(new stTableTileInfo("bbsp_uuid","align_center width_per30","DUID"),
									new stTableTileInfo("bbsp_ipPrefix","align_center width_per30","IpPrefix"),
									new stTableTileInfo("bbsp_leased","align_center width_per30","Duration"),
									null);
		 ColumnNum = 3;
		 for (var i = 0; i < RecordList.length-1; i++)
		 {
		 	TableDataInfo[i] = new DhcpInfoClass();
		 	TableDataInfo[i].DUID = RecordList[i].DUID;
			TableDataInfo[i].IpPrefix = RecordList[i].IPAddress+((RecordList[i].PrefixLen=="0")?(''):('/'+RecordList[i].PrefixLen));
			TableDataInfo[i].Duration = RecordList[i].Duration + dhcpinfo_language['bbsp_sec'];
		 }
		 if (RecordList.length == 1)
		 {
			TableDataInfo[0] = new DhcpInfoClass();
		 	TableDataInfo[0].DUID = '--';
			TableDataInfo[0].IpPrefix = '--';
			TableDataInfo[0].Duration = '--';
		 }
		 TableDataInfo.push(null);
	}
	else
	{
		Dhcpv6InfoConfiglistInfo = new Array(new stTableTileInfo("bbsp_uuid","align_center width_per50","DUID"),
									new stTableTileInfo("bbsp_ipPrefix","align_center width_per50","IpPrefix"),null);
		for (var i = 0; i < RecordList.length-1; i++)
		{
			TableDataInfo[i] = new DhcpInfoClass();
			TableDataInfo[i].DUID = RecordList[i].DUID;
			TableDataInfo[i].IpPrefix = RecordList[i].IPAddress+((RecordList[i].PrefixLen=="0")?(''):('/'+RecordList[i].PrefixLen));
		}
		if (RecordList.length == 1)
		{
			TableDataInfo[0] = new DhcpInfoClass();
			TableDataInfo[0].DUID = '--';
			TableDataInfo[0].IpPrefix = '--';
		}
		TableDataInfo.push(null);
	}
	
	HWShowTableListByType(1, "dhcpinfo", ShowButtonFlag, ColumnNum, TableDataInfo, Dhcpv6InfoConfiglistInfo, dhcp_info_language, null);
</script>
<div style="height:20px;"></div>
</body>
</html>
