<html>
<head>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(common.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, waninfo_language);%>"></script>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script>
var curUserType = '<%HW_WEB_GetUserType();%>';
function __GetISPWanOnlyRead()
{
	return ("<%HW_WEB_GetFeatureSupport(BBSP_FT_ISPSSID_DISPALY);%>" == "1")?true:false;
}
</script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_DeepCleanCache_Resource(wan_list_info_e8c.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/<%HW_WEB_DeepCleanCache_Resource(wan_list_e8c.asp);%>"></script>
<script language="javascript" src="../../bbsp/common/wancontrole8c.asp"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>WAN Information</title>
<script>
var IPv4VendorId="--"
var ClickWanType = "";
var curCfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var mngtTY40 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TIANYI_40);%>';
var isSupportNPTv6 = '<%HW_WEB_GetFeatureSupport(FT_WEB_NPTV6);%>';
var isAutoNPTv6 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_AUTO_NPTV6);%>';
var isZQ = '<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>';
function selectLineipv4(id)
{
	ClickWanType = "IPV4";
	selectLine(id);
}

function selectLineipv6(id)
{
	ClickWanType = "IPV6";
	selectLine(id);
}


var page_version;
if (location.href.indexOf("waninfoe8c.asp?") > 0)
{
	page_version = location.href.split("?")[1];
}
var Custom_cmcc_rms =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';

var WanStatisticSupport = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WEB_WAN_STATISTIC);%>';
function stLinkStats(Domain,EthernetBytesSent,EthernetBytesReceived,EthernetPacketsSent,EthernetPacketsReceived)
{
    this.Domain = Domain;
	this.EthernetBytesSent = EthernetBytesSent;
	this.EthernetBytesReceived = EthernetBytesReceived;
	this.EthernetPacketsSent = EthernetPacketsSent;
	this.EthernetPacketsReceived = EthernetPacketsReceived;
}
var IPLinkStats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.Stats ,EthernetBytesSent|EthernetBytesReceived|EthernetPacketsSent|EthernetPacketsReceived,stLinkStats);%>;
var PPPLinkStats = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection.{i}.Stats ,EthernetBytesSent|EthernetBytesReceived|EthernetPacketsSent|EthernetPacketsReceived,stLinkStats);%>;
function SetDivValue(Id, Value)
{
    try
	{
	    var Div = document.getElementById(Id);
	    Div.innerHTML = Value;
	}
	catch(ex)
	{
	}
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
		b.innerHTML = waninfo_language[b.getAttribute("BindText")];
	}
}

function GetIPv4PPPoeError(CurrentWan)
{
    var errStr = "";
    if (GetOntState()!= "ONLINE")
    {
        errStr = waninfo_language['bbsp_wanerror_offline'];
        return errStr;
    }

    if (CurrentWan.Enable == "0")
    {
        errStr = waninfo_language['bbsp_wanerror_disable'];
        return errStr;
    }

    if((CurrentWan.ConnectionTrigger == "Manual") && (CurrentWan.ConnectionControl == "0"))
    {
       errStr = waninfo_language['bbsp_wanerror_nodial'];
       return errStr;
    }

    if (CurrentWan.Status.toUpperCase() == "UNCONFIGURED")
    {
        errStr = waninfo_language['bbsp_wanerror_noaddress'];
        return errStr;
    }

    switch(CurrentWan.LastConnErr)
    {
		case "ERROR_NOT_ENABLED_FOR_INTERNET":
			errStr = waninfo_language['bbsp_wanerror_neg'];
			break;

		case "ERROR_AUTHENTICATION_FAILURE":
			errStr = waninfo_language['bbsp_wanerror_usrpass'];
			break;

		case "ERROR_ISP_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_srvdown'];
			break;

		case "ERROR_ISP_TIME_OUT":
		    errStr = waninfo_language['bbsp_wanerror_timeout'];
			break;

		case "ERROR_IDLE_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_notraffic'];
			break;

		default:
		    errStr = waninfo_language['bbsp_wanerror_noaddress'];
		    break;
	}

    return errStr;

}


function IsDisplayIPv6DialCode(Origin, lla, gua)
{

    if (lla != "")
    {
        return false;
    }

    return true;
}

function GetIPv6PPPoeError(CurrentWan, lla, gua)
{
    var errStr = "";

    if (GetOntState()!= "ONLINE")
    {
        errStr = waninfo_language['bbsp_wanerror_offline'];
        return errStr;
    }

    if (CurrentWan.Enable == "0")
    {
        errStr = waninfo_language['bbsp_wanerror_disable'];
        return errStr;
    }

    switch(CurrentWan.LastConnErr)
    {
		case "ERROR_NOT_ENABLED_FOR_INTERNET":
			errStr = waninfo_language['bbsp_wanerror_neg'];
			break;

		case "ERROR_AUTHENTICATION_FAILURE":
			errStr = waninfo_language['bbsp_wanerror_usrpass'];
			break;

		case "ERROR_ISP_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_srvdown'];
			break;

		case "ERROR_ISP_TIME_OUT":
		    errStr = waninfo_language['bbsp_wanerror_timeout'];
			break;

		case "ERROR_IDLE_DISCONNECT":
			errStr = waninfo_language['bbsp_wanerror_notraffic'];
			break;

		default:
		    errStr = waninfo_language['bbsp_wanerror_noaddress'];
		    break;
	}

    return errStr;

}

function ConvertWanStatus(WanStatus)
{
	if ("CONNECTED" == WanStatus.toUpperCase())
	{
		return "已连接";
	}
	else if ("CONNECTING" == WanStatus.toUpperCase())
	{
		return "连接中";
	}
	else
	{
		return "未连接";
	}
}


function convertDHCPLeaseTimeRemaining(DHCPLeaseTimeRemaining)
{
	if('0' == DHCPLeaseTimeRemaining || '' == DHCPLeaseTimeRemaining)
	{
	   return "";
	}
	else
	{
	   return DHCPLeaseTimeRemaining;
	}

}

function LoadFrame()
{
	if (GetFeatureInfo().IPv6 == "0")
    {
        setDisplay("IPv6PrefixPanel", "0");
    }

    if( Custom_cmcc_rms ==  "1")
    {
    	if("v4" == page_version)
    	{
    		setDisplay("Table_wan_ipv6_table", "0");
        	setDisplay("IPv6PrefixPanel", "0");
    	}
    	else if("v6" == page_version)
    	{
    		setDisplay("Table_wan_ipv4_table", "0");
        	setDisplay("IPv4Panel", "0");
    	}

    }
	loadlanguage();
}

</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<script language="javascript" src="../../bbsp/common/ontstate.asp"></script>
<script language="javascript" src="../../bbsp/common/wanaddressacquire.asp"></script>
<script language="javascript" src="../../bbsp/common/wanipv6state.asp"></script>
<script language="javascript" src="../../bbsp/common/wandns.asp"></script>

<div id="PanelPrompt">
  <table class='width_100p'  border="0" cellpadding="0" cellspacing="0" id="tabTest">
    <tr>
      <td class="prompt">
	  	<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	  	<table class='width_100p' border="0" cellspacing="0" cellpadding="0">
          <tr>
			<td class='title_common' ><label id="Title_wan_satus_lable">在本页面上，您可以查询网络侧连接信息。</label> </td>
          </tr>
        </table></td>
    </tr>
  </table>
  <div class="title_spread"></div>
</div>
<script type="text/javascript" language="javascript">
if (navigator.appName == "Microsoft Internet Explorer")
{
    document.write('<div  id="IPTable" style="overflow-x:auto;overflow-y:hidden;width:100%;">');
}
else
{
    document.write('<div  id="IPTable" style="overflow-x:auto;overflow-y:hidden;width:667;">');
}
</script>

<table class="tabal_bg width_100p"  cellspacing="1" id="IPv4Panel" >
  <div class="func_title" id = "Table_wan_ipv4_table">IPV4信息</div>
  <tr class="head_title" id = "Table_wan_ipv4_head">
	<td id = "Table_wan_ipv4_1_1_table" nowrap>WAN连接名称</td>
	<td id = "Table_wan_ipv4_1_2_table" nowrap>使能状态</td>
    <td id = "Table_wan_ipv4_1_3_table" nowrap>连接状态</td>
    <td id = "Table_wan_ipv4_1_4_table" nowrap>地址获取方式</td>
    <td id = "Table_wan_ipv4_1_5_table" nowrap>IP地址</td>
    <td id = "Table_wan_ipv4_1_6_table" nowrap>子网掩码</td>
    <td id = "Table_wan_ipv4_1_7_table" nowrap>默认网关</td>
    <td id = "Table_wan_ipv4_1_8_table" nowrap>主用DNS</td>
    <td id = "Table_wan_ipv4_1_9_table" nowrap>备用DNS</td>
	<td id = "Table_wan_ipv4_1_10_table" nowrap>VLAN/优先级</td>
    <td id = "Table_wan_ipv4_1_11_table" nowrap>MAC地址</td>
    <td id = "Table_wan_ipv4_1_12_table" nowrap>连接</td>
  </tr>
	<script type="text/javascript" language="javascript">

	function replaceSpace(str)
	{
		if(str.indexOf(" ")!=-1)
		{
			str=str.replace(/ /g,"&#160;");
		}
		return str;
	}

	function AddTimeUnit(time,timeunit)
	{
		if(time.toString().length == 0||(time == "--"))
			return time;
		else
			return time.toString() +" "+ timeunit;
	}
	function displaywanstatistic(CurrentWan)
	{
		var index =  0;
		var length = 0;
		if(WanStatisticSupport != 1)
		{
			return;
		}
		if('IPoE' == CurrentWan.EncapMode)
		{
			length = IPLinkStats.length;
			for(var i = 0; i < length-1; i++)
			{
				if((CurrentWan.domain + ".Stats") === IPLinkStats[i].Domain)
				{
					index = i;
					SetDivValue("WanStatsSendPackets",IPLinkStats[index].EthernetPacketsSent);
			        SetDivValue("WanStatsReceivePackets",IPLinkStats[index].EthernetPacketsReceived);
			        SetDivValue("WanStatsReceiveBytes",IPLinkStats[index].EthernetBytesReceived);
			        SetDivValue("WanStatsSendBytes",IPLinkStats[index].EthernetBytesSent);
				}
			}

		}
		else
		{
			length = PPPLinkStats.length;
			for(var i = 0; i < length-1; i++)
			{
				if((CurrentWan.domain + ".Stats") === PPPLinkStats[i].Domain)
				{
					index = i;
					SetDivValue("WanStatsSendPackets",PPPLinkStats[index].EthernetPacketsSent);
			        SetDivValue("WanStatsReceivePackets",PPPLinkStats[index].EthernetPacketsReceived);
			        SetDivValue("WanStatsReceiveBytes",PPPLinkStats[index].EthernetBytesReceived);
			        SetDivValue("WanStatsSendBytes",PPPLinkStats[index].EthernetBytesSent);
				}
			}
		}

		document.getElementById("TableLinkStatesInfo_Wan").style.display = "";
		document.getElementById("Table_wan_link_table").style.display = "";
	}
	function GetAddressTimeRemaining(wanIpv6Address, wanIndex)
	{
		var List = new Array();
		var Count = 0;

		for (var i = 0; i < wanIpv6Address.length; i++)
		{
			if(wanIpv6Address[i] == null)
			continue;

			if (wanIpv6Address[i].WanInstanceId != wanIndex)
			continue;

			List[Count++] = wanIpv6Address[i];
		}

		return List;
	}

	function GetPrefixTimeRemaining(wanIpv6prefix, wanIndex)
	{
		var List = new Array();
		var Count = 0;

		for (var i = 0; i < wanIpv6prefix.length; i++)
		{
			if(wanIpv6prefix[i] == null)
			continue;

			if (wanIpv6prefix[i].WanInstanceId != wanIndex)
			continue;

			List[Count++] = wanIpv6prefix[i];
		}

		return List;
	}
	function DisplayIPv6WanDetail(WanIndex)
	{
		var CurrentWan = GetWanList()[WanIndex];
		var ipv6Wan = GetIPv6WanInfo(CurrentWan.MacId);
		var AddressAcquire = GetIPv6AddressAcquireInfo(CurrentWan.domain);
		var AddressList = GetIPv6AddressList(CurrentWan.MacId);
		var AcquireHtml = "";
		var AddressHtml = "";
		var AddressStatusHtml = "";
		var AddressPreferredTimeHtml = "";
		var AddressValidTimeHtml = "";
		var AddressValidTimeRemainingHtml="";

		var wanIpv6Address = new Array(null);
        $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : "/html/bbsp/common/get_ipv6state_address.asp",
            success : function(data) {
                if (data != "") {
                    wanIpv6Address = dealDataWithFun(data);
                }
            }
		});
		var addressTimeList = GetAddressTimeRemaining(wanIpv6Address, CurrentWan.MacId);

        if (!AddressAcquire) { AddressAcquire = { Origin: ""}; }

		for (var m = 0; m < AddressList.length; m++)
		{
			if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
			{
				if (CurrentWan.Enable == "1")
				{
					if(AddressHtml == '')
						AddressHtml += AddressList[m].IPAddress;
					else
						AddressHtml += "<br>" + AddressList[m].IPAddress;

					if(AddressStatusHtml == '')
						AddressStatusHtml += AddressList[m].IPAddressStatus;
					else
						AddressStatusHtml += "<br>" +  AddressList[m].IPAddressStatus;

					if(AddressPreferredTimeHtml == '')
						AddressPreferredTimeHtml += AddressList[m].PreferredTime;
					else
						AddressPreferredTimeHtml += "<br>" +  AddressList[m].PreferredTime;

					if(AddressValidTimeHtml == '')
						AddressValidTimeHtml += AddressList[m].ValidTime;
					else
						AddressValidTimeHtml += "<br>" +  AddressList[m].ValidTime;

				    if(AddressValidTimeRemainingHtml == '')
				    {
						AddressValidTimeRemainingHtml += convertDHCPLeaseTimeRemaining(addressTimeList[m].ValidTimeRemaining);
					}
					else
					{
						AddressValidTimeRemainingHtml += "<br>" +  convertDHCPLeaseTimeRemaining(addressTimeList[m].ValidTimeRemaining);
				    }
				}
			}
		}

		document.getElementById("IPv6WanDetail").style.display = "";
		setElementInnerHtmlById("IPv6MacAddress", CurrentWan.MACAddress);
		setNoEncodeInnerHtmlValue("IPv6PriorityPolicy", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? waninfo_language['bbsp_wanpriority'] : waninfo_language['bbsp_wandefaultpri']);
		setDisplay("IPv6NPTv6EnableRow", 0);
		if ( 0 == parseInt(CurrentWan.VlanId,10) )
		{
			if((ipv6Wan.ConnectionStatus.toUpperCase()=="CONNECTED") && (CurrentWan.Mode == 'IP_Routed') )
			{
				setElementInnerHtmlById("IPv6Vlan", "");
				setElementInnerHtmlById("IPv6Priority", "");
				setElementInnerHtmlById("IPv6PriorityPolicy", "");
			}
			else
			{
				setElementInnerHtmlById("IPv6Vlan", "--");
				setElementInnerHtmlById("IPv6Priority", "--");
				setElementInnerHtmlById("IPv6PriorityPolicy", "--");
			}
		}
		else
		{
			setElementInnerHtmlById("IPv6Vlan", CurrentWan.VlanId);
			setElementInnerHtmlById("IPv6Priority", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? CurrentWan.Priority : CurrentWan.DefaultPriority);
			setNoEncodeInnerHtmlValue("IPv6PriorityPolicy", waninfo_language[CurrentWan.PriorityPolicy]);
		}

		if('IP_Routed' == CurrentWan.Mode)
		{
			document.getElementById("IPv6GateWayRow").style.display = "";
			document.getElementById("IPv6DnsServerRow").style.display = "";
			document.getElementById("IPv6PrefixRow").style.display = "";
			document.getElementById("IPv6PrefixModeRow").style.display = "";
			document.getElementById("IPv6PrefixPreferredTimeRow").style.display = "";
			document.getElementById("IPv6PrefixVaildTimeRow").style.display = "";
			document.getElementById("IPv6PrefixVaildTimeRemainingRow").style.display = "";
			document.getElementById("IPv6IpAddressRow").style.display = "";
			document.getElementById("IPv6IpAccessModeRow").style.display = "";
			document.getElementById("Ipv6IpStateRow").style.display = "";
			document.getElementById("IPv6PreferredTimeRow").style.display = "";
			document.getElementById("IPv6VaildTimeRow").style.display = "";
			document.getElementById("IPv6VaildTimeRemainingRow").style.display = "";
			document.getElementById("IPv6DsliteAftrnameRow").style.display = "";
			document.getElementById("IPv6DslitePeerAddressRow").style.display = "";
			if (((mngtTY40 == '1') || (isSupportNPTv6 == '1')) && (isAutoNPTv6 != '1')) {
				setDisplay("IPv6NPTv6EnableRow", 1);
				setNoEncodeInnerHtmlValue("IPv6NPTv6Enable", CurrentWan.X_HW_NPTv6Enable == "1" ? waninfo_language['bbsp_enable']: waninfo_language['bbsp_disable']);
			}
			var PrefixList = GetIPv6PrefixList(CurrentWan.MacId);
			var Prefix = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].Prefix:'') :(PrefixList[0].Prefix));
			Prefix = (CurrentWan.Enable == "1") ? Prefix : "";


			var PrefixAcquire = GetIPv6PrefixAcquireInfo(CurrentWan.domain);
			PrefixAcquire = ((PrefixAcquire==null) ? '' : PrefixAcquire.Origin);
			setElementInnerHtmlById("IPv6PrefixMode", PrefixAcquire);


			AcquireHtml = AddressAcquire.Origin;
			setElementInnerHtmlById("IPv6IpAccessMode", AcquireHtml);


			var PrefixPreferredTime = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].PreferredTime:'') :(PrefixList[0].PreferredTime));
			PrefixPreferredTime = ((CurrentWan.Enable == "1") && (Prefix.length != 0))? PrefixPreferredTime : "";


			var PrefixValidTime = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].ValidTime:'') :(PrefixList[0].ValidTime));
			PrefixValidTime = ((CurrentWan.Enable == "1") && (Prefix.length != 0)) ? PrefixValidTime : "";

			var wanIpv6prefix = new Array(null);
			$.ajax({
				type : "POST",
				async : false,
				cache : false,
				url : "/html/bbsp/common/get_ipv6state_prefix.asp",
				success : function(data) {
					if (data != "") {
						wanIpv6prefix = dealDataWithFun(data);
					}
				}
			});
			var prefixTimeList = GetAddressTimeRemaining(wanIpv6prefix, CurrentWan.MacId);

			var PrefixValidTimeRemaining = ((PrefixList!=null)?(PrefixList.length > 0?prefixTimeList[0].ValidTimeRemaining:'') :(prefixTimeList[0].ValidTimeRemaining));
			PrefixValidTimeRemaining = ((CurrentWan.Enable == "1") && (Prefix.length != 0)) ? PrefixValidTimeRemaining : "";
			PrefixValidTimeRemaining = convertDHCPLeaseTimeRemaining(PrefixValidTimeRemaining);

			if("CONNECTED" == ipv6Wan.ConnectionStatus.toUpperCase() || ('1' == '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_LASTERR_IPVER_IND);%>') || ('<%HW_WEB_GetFeatureSupport(BBSP_FT_CTC);%>' == '1'))
			{
				setElementInnerHtmlById("IPv6GateWay", ipv6Wan.DefaultRouterAddress);
				setElementInnerHtmlById("IPv6DnsServer", ipv6Wan.DNSServers);
				setNoEncodeInnerHtmlValue("IPv6PreferredTime", AddTimeUnit(AddressPreferredTimeHtml,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6VaildTime", AddTimeUnit(AddressValidTimeHtml,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6VaildTimeRemaining", AddTimeUnit(AddressValidTimeRemainingHtml,waninfo_language['bbsp_timeunit']));
				setElementInnerHtmlById("IPv6Prefix", Prefix);
				setNoEncodeInnerHtmlValue("IPv6PrefixPreferredTime", AddTimeUnit(PrefixPreferredTime,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6PrefixVaildTime", AddTimeUnit(PrefixValidTime,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6PrefixVaildTimeRemaining", AddTimeUnit(PrefixValidTimeRemaining,waninfo_language['bbsp_timeunit']));
				setNoEncodeInnerHtmlValue("IPv6IpAddress", AddressHtml);
				setNoEncodeInnerHtmlValue("Ipv6IpState", AddressStatusHtml);
				setElementInnerHtmlById("IPv6DsliteAftrname", CurrentWan.IPv6AFTRName);
				setElementInnerHtmlById("IPv6DslitePeerAddress", ipv6Wan.AFTRPeerAddr);

			}
			else
			{
				setElementInnerHtmlById("IPv6GateWay", "--");
				setElementInnerHtmlById("IPv6DnsServer", "--");
				setElementInnerHtmlById("IPv6PreferredTime", "--");
				setElementInnerHtmlById("IPv6VaildTime", "--");
				setElementInnerHtmlById("IPv6Prefix", "--");
				setElementInnerHtmlById("IPv6PrefixPreferredTime", "--");
				setElementInnerHtmlById("IPv6PrefixVaildTime", "--");
				setElementInnerHtmlById("IPv6PrefixVaildTimeRemaining", "--");
				setElementInnerHtmlById("IPv6IpAddress", "--");
				setElementInnerHtmlById("Ipv6IpState", "--");
				setElementInnerHtmlById("IPv6DsliteAftrname", "--");
				setElementInnerHtmlById("IPv6DslitePeerAddress", "--");
		  }

          if('IPoE' == CurrentWan.EncapMode)
          {
              document.getElementById("IPv6DialFailedCodeRow").style.display = "none";
          }
          else
          {
              var lla = "";
              var gua = "";
              for (var m = 0; m < AddressList.length; m++)
              {
            		if (AddressList[m].Origin.toUpperCase() != "LINKLOCAL")
            		{
            		    gua = AddressList[m].IPAddress;
            		}
            		else
            		{
            		    lla = AddressList[m].IPAddress;
            		}
              }

              if (IsDisplayIPv6DialCode(AddressAcquire.Origin, lla, gua) == false)
              {
                  document.getElementById("IPv6DialFailedCodeRow").style.display = "none";
              }
              else
              {
                  document.getElementById("IPv6DialFailedCodeRow").style.display = "";

                  var error = GetIPv6PPPoeError(CurrentWan, lla, gua);
				  setElementInnerHtmlById("IPv6DialCode", error);
              }
          }

		}
		else
		{
			document.getElementById("IPv6GateWayRow").style.display = "none";
			document.getElementById("IPv6DnsServerRow").style.display = "none";
			document.getElementById("IPv6PrefixRow").style.display = "none";
			document.getElementById("IPv6PrefixModeRow").style.display = "none";
			document.getElementById("IPv6PrefixPreferredTimeRow").style.display = "none";
			document.getElementById("IPv6PrefixVaildTimeRow").style.display = "none";
			document.getElementById("IPv6PrefixVaildTimeRemainingRow").style.display = "none";
			document.getElementById("IPv6IpAddressRow").style.display = "none";
			document.getElementById("IPv6IpAccessModeRow").style.display = "none";
			document.getElementById("Ipv6IpStateRow").style.display = "none";
			document.getElementById("IPv6PreferredTimeRow").style.display = "none";
			document.getElementById("IPv6VaildTimeRow").style.display = "none";
			document.getElementById("IPv6DsliteAftrnameRow").style.display = "none";
			document.getElementById("IPv6VaildTimeRemainingRow").style.display = "none";
			document.getElementById("IPv6DslitePeerAddressRow").style.display = "none";
            document.getElementById("IPv6DialFailedCodeRow").style.display = "none";
		}
		displaywanstatistic(CurrentWan);
	}

	function GetStaticRouteInfo(string)
	{
		var Result = hexDecode(string);
		var res = Result.split("\n");
		if ((typeof(res) != "undefined") && (res != "undefined")) {
			setElementInnerHtmlById("StaticRoute", res[1]);
		}
	}

	function GetOption121(wanindex)
	{
		var Option121Info="";

		$.ajax({
			type : "POST",
			async : true,
			cache : false,
			timeout : 2000,
			data : "x.X_HW_Token="+getValue('onttoken'),
			url : "staticroute.cgi?WANNAME=wan"+wanindex,
			success : function(data) {
				GetStaticRouteInfo(data);
			},
			complete: function (XHR, TS) {

				Option121Info=null;

				XHR = null;
		  }
		});
	}

	function DisplayIPv4WanDetail(WanIndex)
	{
		var CurrentWan = GetWanList()[WanIndex];
		document.getElementById("WanDetail").style.display = "";
		setElementInnerHtmlById("MacAddress", CurrentWan.MACAddress);
		setNoEncodeInnerHtmlValue("wanpriority", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? waninfo_language['bbsp_wanpriority'] : waninfo_language['bbsp_wandefaultpri']);

		if ( 0 == parseInt(CurrentWan.VlanId,10) )
		{
			if(("Connected" == CurrentWan.Status) && ('' != CurrentWan.IPv4IPAddress) )
			{
				setElementInnerHtmlById("Vlan", "");
				setElementInnerHtmlById("Priority", "");
				setElementInnerHtmlById("PriorityPolicy", "");
			}
			else
			{
				setElementInnerHtmlById("Vlan", "--");
				setElementInnerHtmlById("Priority", "--");
				setElementInnerHtmlById("PriorityPolicy", "--");
			}
		}
		else
		{
			setElementInnerHtmlById("Vlan", CurrentWan.VlanId);
			setElementInnerHtmlById("Priority", ('SPECIFIED' == CurrentWan.PriorityPolicy.toUpperCase()) ? CurrentWan.Priority : CurrentWan.DefaultPriority);
			setNoEncodeInnerHtmlValue("PriorityPolicy", waninfo_language[CurrentWan.PriorityPolicy]);
		}

        setDisplay("RDModeRow", 0);
        setDisplay("RdPrefixRow", 0);
        setDisplay("RdPrefixLenRow", 0);
        setDisplay("RdBRIPv4AddressRow", 0);
        setDisplay("RdIPv4MaskLenRow", 0);

		if( 'IP_Routed' == CurrentWan.Mode )
		{
			document.getElementById("NatSwitchRow").style.display = "";
			setNoEncodeInnerHtmlValue("NatSwitch", CurrentWan.IPv4NATEnable == "1" ? waninfo_language['bbsp_enable']: waninfo_language['bbsp_disable']);
			document.getElementById("IpAdressRow").style.display = "";
			document.getElementById("GateWayRow").style.display = "";
			document.getElementById("DnsServerRow").style.display = "";

			var servicetypeIsMatch = (-1 != CurrentWan.ServiceList.indexOf("INTERNET")) || (-1 != CurrentWan.ServiceList.indexOf("IPTV")) || (-1 != CurrentWan.ServiceList.indexOf("OTHER"));
            if( (1 == CurrentWan.IPv4Enable) && (0 == CurrentWan.IPv6Enable) &&
                (true == servicetypeIsMatch)&&(true == Is6RdSupported()))
			{
                setDisplay("RDModeRow", 1);
				setElementInnerHtmlById("RDMode", CurrentWan.RdMode);
				if (1 == CurrentWan.Enable6Rd)
				{
					setDisplay("RdPrefixRow", 1);
					setDisplay("RdPrefixLenRow", 1);
					setDisplay("RdBRIPv4AddressRow", 1);
					setDisplay("RdIPv4MaskLenRow", 1);
					setElementInnerHtmlById("RDPrefix", CurrentWan.RdPrefix);
					setElementInnerHtmlById("RDPrefixLenth", CurrentWan.RdPrefixLen);
					setElementInnerHtmlById("RDBrAddr", CurrentWan.RdBRIPv4Address);
					setElementInnerHtmlById("RDIpv4MaskLenth", CurrentWan.RdIPv4MaskLen);
				}
    		}

			if(("Connected" == CurrentWan.Status ) && ('' != CurrentWan.IPv4IPAddress) )
			{
				setElementInnerHtmlById("IpAdress", CurrentWan.IPv4IPAddress + "/" + CurrentWan.IPv4SubnetMask);
				if (CurrentWan.IPv4Gateway != '')
                {
    				setElementInnerHtmlById("GateWay", CurrentWan.IPv4Gateway);
                }
                else
                {
    				setElementInnerHtmlById("GateWay", "--");
                }
				setElementInnerHtmlById("DnsServer",CurrentWan.IPv4PrimaryDNS + " " +CurrentWan.IPv4SecondaryDNS);
			}
			else
			{
				setElementInnerHtmlById("IpAdress", "--");
				setElementInnerHtmlById("GateWay", "--");
				setElementInnerHtmlById("DnsServer", "--");
			}

			if('IPoE' == CurrentWan.EncapMode)
			{
				document.getElementById("BrasNameRow").style.display = "none";
                document.getElementById("DialFailedCodeRow").style.display = "none";
				if ("STATIC" == CurrentWan.IPv4AddressMode.toUpperCase())
				{
					document.getElementById("LeaseTimeRow").style.display = "none";
					document.getElementById("LeaseTimeRemainingRow").style.display = "none";
					document.getElementById("NtpServerRow").style.display = "none";
					document.getElementById("STimeRow").style.display = "none";
					document.getElementById("SipServerRow").style.display = "none";
					document.getElementById("StaticRouteRow").style.display = "none";
					document.getElementById("VenderInfoRow").style.display = "none";
				}
				else
				{
					document.getElementById("LeaseTimeRow").style.display = "";
					document.getElementById("LeaseTimeRemainingRow").style.display = "";
					document.getElementById("NtpServerRow").style.display = "";
					document.getElementById("STimeRow").style.display = "";
					document.getElementById("SipServerRow").style.display = "";
					document.getElementById("StaticRouteRow").style.display = "";
					document.getElementById("VenderInfoRow").style.display = "";
				}

				var wanTimeList = new Array(null);
				$.ajax({
					type : "POST",
					async : false,
					cache : false,
					url : "/html/bbsp/common/get_wan_list_time.asp",
					success : function(data) {
						if (data != "") {
							wanTimeList = dealDataWithFun(data);
						}
					}
				});

				var wanTimeListNum = wanTimeList.length;
				var DHCPLeaseTimeRemaining = CurrentWan.DHCPLeaseTimeRemaining;
				for (i = 0; (wanTimeList != null && wanTimeListNum > 0 && i < wanTimeListNum); i++) {
					if (wanTimeList[i].domain == CurrentWan.domain) {
						DHCPLeaseTimeRemaining = wanTimeList[i].DHCPLeaseTimeRemaining;
					}
				}

				if("Connected" == CurrentWan.Status)
				{
					setNoEncodeInnerHtmlValue("LeaseTime", AddTimeUnit(CurrentWan.DHCPLeaseTime,waninfo_language['bbsp_timeunit']));
					setNoEncodeInnerHtmlValue("LeaseTimeRemaining", AddTimeUnit(convertDHCPLeaseTimeRemaining(DHCPLeaseTimeRemaining),waninfo_language['bbsp_timeunit']));
					setElementInnerHtmlById("NtpServer", CurrentWan.NTPServer);
					setElementInnerHtmlById("STime", CurrentWan.TimeZoneInfo);
					setElementInnerHtmlById("SipServer", CurrentWan.SIPServer);

					setElementInnerHtmlById("StaticRoute", "");
					if ("DHCP" == CurrentWan.IPv4AddressMode.toUpperCase())
					{
						GetOption121(CurrentWan.MacId);
					}
					else
					{
						setElementInnerHtmlById("StaticRoute", CurrentWan.StaticRouteInfo);
					}
					IPv4VendorId = CurrentWan.IPv4VendorId;
					setNoEncodeInnerHtmlValue("VenderInfo", GetStringContent(htmlencode(IPv4VendorId),16));
					document.getElementById("VenderInfo").title = IPv4VendorId;
				}
				else
				{
					setElementInnerHtmlById("LeaseTime", "--");
					setElementInnerHtmlById("LeaseTimeRemaining", "--");
					setElementInnerHtmlById("NtpServer", "--");
					setElementInnerHtmlById("STime", "--");
					setElementInnerHtmlById("SipServer", "--");
					setElementInnerHtmlById("StaticRoute", "--");
					setElementInnerHtmlById("VenderInfo", "--");
				}
				if ( bin4board_nonvoice() == true )
				{
					document.getElementById("SipServerRow").style.display = "none";
				}
			}
			else
			{
				document.getElementById("BrasNameRow").style.display = "";
				document.getElementById("LeaseTimeRow").style.display = "none";
				document.getElementById("LeaseTimeRemainingRow").style.display = "none";
				document.getElementById("NtpServerRow").style.display = "none";
				document.getElementById("STimeRow").style.display = "none";
				document.getElementById("SipServerRow").style.display = "none";
				document.getElementById("StaticRouteRow").style.display = "none";
				document.getElementById("VenderInfoRow").style.display = "none";
				if("Connected" == CurrentWan.Status)
				{
					setElementInnerHtmlById("BrasName", CurrentWan.PPPoEACName);
                    document.getElementById("DialFailedCodeRow").style.display = "none";
				}
				else
				{
				    document.getElementById("DialFailedCodeRow").style.display ="" ;
                    var error = GetIPv4PPPoeError(CurrentWan);
					setElementInnerHtmlById("DialCode", error);
					setElementInnerHtmlById("BrasName", "--");
				}

			}
		}
		else
		{
			document.getElementById("NatSwitchRow").style.display = "none";
			document.getElementById("IpAdressRow").style.display = "none";
			document.getElementById("GateWayRow").style.display = "none";
			document.getElementById("DnsServerRow").style.display = "none";
			document.getElementById("BrasNameRow").style.display = "none";
			document.getElementById("LeaseTimeRow").style.display = "none";
			document.getElementById("LeaseTimeRemainingRow").style.display = "none";
			document.getElementById("NtpServerRow").style.display = "none";
			document.getElementById("STimeRow").style.display = "none";
			document.getElementById("SipServerRow").style.display = "none";
			document.getElementById("StaticRouteRow").style.display = "none";
			document.getElementById("VenderInfoRow").style.display = "none";
            document.getElementById("DialFailedCodeRow").style.display = "none";
		}
		displaywanstatistic(CurrentWan);
	}

    var Selected_LastControlID = null;
	function setControl(WanIndex)
	{
		Selected_LastControlID = WanIndex;
		var CurrentWan = GetWanList()[WanIndex];
		var ProtocolType = GetProtocolType(CurrentWan.IPv4Enable, CurrentWan.IPv6Enable);
		if ("IPv4" == ProtocolType)
		{
			DisplayIPv4WanDetail(WanIndex);
		}
		else if ("IPv6" == ProtocolType)
		{
			DisplayIPv6WanDetail(WanIndex);
		}
		else if ("IPv4/IPv6" == ProtocolType)
		{
			if ("IPV4" == ClickWanType)
			{
				DisplayIPv4WanDetail(WanIndex);
			}
			else if ("IPV6" == ClickWanType)
			{
				DisplayIPv6WanDetail(WanIndex);
			}
		}
	}

	var IPv4WanCount = 0;
	var IPv6WanCount = 0;

    function DrawIPv4Table() {
		var domString = "";
        for (var i = 0;i < GetWanList().length;i++) {
            var CurrentWan = GetWanList()[i];
            if ((CurrentWan.IPv4Enable != "1") || (CurrentWan.X_HW_VXLAN_Enable == 1)) {
                continue;
            }
            IPv4WanCount ++;
            var IPv4WanCol= IPv4WanCount + 1;
            var idPrefix = getElementId(domainTowanname(CurrentWan.domain));
            var bridgeHostEnable = GetBridgeHostInfo(CurrentWan.domain);
            domString += ('<TR id="record_' + i + '" onclick="selectLineipv4(this.id);" class="tabal_center01">');
            domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_1_table" class="'+idPrefix+'_Name" nowrap>'+CurrentWan.Name+'</td>');
            if (CurrentWan.Enable != "1") {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_2_table" nowrap>禁用</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_2_table" nowrap>启用</td>');
            }

            if (GetOntState()!='ONLINE') {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_3_table" nowrap>'+ConvertWanStatus('Disconnected')+'</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_3_table" nowrap>'+ConvertWanStatus(CurrentWan.Status)+'</td>');
            }

            if ((CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) && (bridgeHostEnable == 0)) {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_4_table"align="center" nowrap>--</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_4_table" align="center" nowrap>'+CurrentWan.IPv4AddressMode+'</td>');
            }

            if ((CurrentWan.Status=="Connected") && (CurrentWan.IPv4IPAddress != '') && ((CurrentWan.Mode == 'IP_Routed') || (bridgeHostEnable == 1))) {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_5_table" nowrap>'+CurrentWan.IPv4IPAddress + '</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_5_table" align="center" nowrap>--</td>');
            }

            if ((CurrentWan.Status=="Connected") && (CurrentWan.IPv4SubnetMask != '') && ((CurrentWan.Mode == 'IP_Routed') || (bridgeHostEnable == 1))) {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_6_table" nowrap>'+CurrentWan.IPv4SubnetMask+'</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_6_table" align="center" nowrap>--</td>');
            }

            if ((CurrentWan.Status=="Connected") && (CurrentWan.IPv4Gateway != '') && ((CurrentWan.Mode == 'IP_Routed') || (bridgeHostEnable == 1))) {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_7_table" nowrap>'+CurrentWan.IPv4Gateway+'</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_7_table" align="center" nowrap>--</td>');
            }

            if ((CurrentWan.Status=="Connected") && (CurrentWan.IPv4PrimaryDNS != '') && ((CurrentWan.Mode == 'IP_Routed') || (bridgeHostEnable == 1))) {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_8_table" nowrap>'+CurrentWan.IPv4PrimaryDNS+'</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_8_table" align="center" nowrap>--</td>');
            }

            if ((CurrentWan.Status=="Connected") && (CurrentWan.IPv4SecondaryDNS != '') && ((CurrentWan.Mode == 'IP_Routed') || (bridgeHostEnable == 1))) {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_9_table" nowrap>'+CurrentWan.IPv4SecondaryDNS+'</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_9_table" align="center" nowrap>--</td>');
            }

            if ( 0 != parseInt(CurrentWan.VlanId,10) ) {
                var pri = ('Specified' == CurrentWan.PriorityPolicy) ? CurrentWan.Priority : CurrentWan.DefaultPriority ;
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_10_table" nowrap>'+CurrentWan.VlanId+'/'+pri+'</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_10_table" align="center" nowrap>'+'-/-'+'</td>');
            }

            if (CurrentWan.MACAddress != '') {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_11_table" nowrap>'+CurrentWan.MACAddress +'</td>');
            } else {
                domString += ('<td id = "Table_wan_ipv4_'+IPv4WanCol+'_11_table" align="center"  nowrap>--</td>');
            }

            if (NeedAddConnectButton(CurrentWan) == true && CurrentWan.Enable == "1") {
                var btText = CurrentWan.ConnectionControl == "1" ? waninfo_language['bbsp_discon']: waninfo_language['bbsp_con'];
                var ctrFlag = CurrentWan.ConnectionControl == "1" ? "0": "1";
                domString += ("<td id = 'Table_wan_ipv4_"+IPv4WanCol+"_12_table' align='center' nowrap><a style='color:blue' onclick = 'OnConnectionControlButtonE8c(this,"+i+","+ctrFlag+")' RecordId = '"+i+"' href='#'>"+btText+"</a></td>");
            } else {
                var innerText = CurrentWan.Enable == "1" ? "AlwaysOn":"AlwaysOn";
                if (CurrentWan.ConnectionTrigger == "OnDemand") {
                    innerText = waninfo_language['bbsp_needcon'];
                } else if (CurrentWan.ConnectionTrigger == "Manual") {
                    innerText = waninfo_language['bbsp_Manual'];
                }
                domString += ("<td id = 'Table_wan_ipv4_"+IPv4WanCol+"_12_table' nowrap>"+innerText+"</td>");
            }
            domString += ('</tr>');
        }

        if (IPv4WanCount == 0) {
            domString += ("<tr class= \"tabal_center01\">");
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ('<td >'+'--'+'</td>');
            domString += ("</tr>");
        }
        return domString;
    }
    $("#Table_wan_ipv4_head").after(DrawIPv4Table());
	</script>
</table>

<div  align='center' style="display:none" id="WanDetail">
<table id="table_wandetail" class="tabal_bg width_100p"  cellspacing="1" >
  <tr class="head_title align_left">
    <td  colspan="8" BindText = 'bbsp_wandetailinfo'></td>
  </tr>

  <tr class="tabal_01 align_left">
    <td  width="30%"  BindText = 'bbsp_wanmacaddress'></td>
    <td  width="70%" id="MacAddress"></td>
  </tr>
  <tr class="tabal_01 align_left">
    <td  width="30%"  BindText = 'bbsp_wanvlan'></td>
    <td  width="70%" id="Vlan"></td>
 </tr>
  <tr class="tabal_01 align_left">
    <td  width="30%" BindText = 'bbsp_wanpripolicy'></td>
    <td  width="70%" id="PriorityPolicy"></td>
  </tr>
  </tr>
  <tr class="tabal_01 align_left">
    <td  width="30%" id='wanpriority'></td>
    <td  width="70%" id="Priority"></td>
  </tr>
  <tr class="tabal_01 align_left" id="NatSwitchRow">
    <td  width="30%" BindText = 'bbsp_wannat'></td>
    <td  width="70%" id="NatSwitch"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IpAdressRow">
    <td  width="30%" BindText = 'bbsp_wanip'></td>
    <td  width="70%" id="IpAdress"></td>
  </tr>
  <tr class="tabal_01 align_left" id="GateWayRow">
    <td  width="30%" BindText = 'bbsp_wangateway'></td>
    <td  width="70%" id="GateWay"></td>
  </tr>
  <tr class="tabal_01 align_left" id="DnsServerRow">
    <td  width="30%" BindText = 'bbsp_wandns'></td>
    <td  width="70%" id="DnsServer"></td>
  </tr>

  <tr class="tabal_01 align_left" id="BrasNameRow">
    <td  width="30%" BindText = 'bbsp_wanbras'></td>
    <td  width="70%" id="BrasName"></td>
  </tr>

  <tr class="tabal_01 align_left" id="DialFailedCodeRow">
    <td  width="30%" BindText = 'bbsp_wandialcode'></td>
    <td  width="70%" id="DialCode"></td>
  </tr>

  <tr class="tabal_01 align_left" id="LeaseTimeRow">
    <td  width="30%" BindText = 'bbsp_wanlease'></td>
    <td  width="70%" id="LeaseTime"></td>
  </tr>
  <tr class="tabal_01 align_left" id="LeaseTimeRemainingRow">
    <td  width="30%" BindText = 'bbsp_wanlease_remaining'></td>
    <td  width="70%" id="LeaseTimeRemaining"></td>
  </tr>
  <tr class="tabal_01 align_left" id="NtpServerRow">
    <td  width="30%" BindText = 'bbsp_wanntp'></td>
    <td  width="70%" id="NtpServer"></td>
  </tr>
  <tr class="tabal_01 align_left" id="STimeRow">
    <td  width="30%" BindText = 'bbsp_wanstime'></td>
    <td  width="70%" id="STime"></td>
  </tr>
  <tr class="tabal_01 align_left" id="SipServerRow">
    <td  width="30%" BindText = 'bbsp_wansip'></td>
    <td  width="70%" id="SipServer"></td>
  </tr>
  <tr class="tabal_01 align_left" id="StaticRouteRow">
    <td  width="30%" BindText = 'bbsp_wansroute'></td>
    <td  width="70%" id="StaticRoute"></td>
  </tr>
  <tr class="tabal_01 align_left"  id="VenderInfoRow">
    <td  width="30%" BindText = 'bbsp_wanvendor'></td>
    <td  width="70%" id="VenderInfo"></td>
  </tr>
  <tr class="tabal_01 align_left"  id="RDModeRow">
    <td  width="30%" BindText = 'Des6RDMode'></td>
    <td  width="70%" id="RDMode"></td>
  </tr>
  <tr class="tabal_01 align_left"  id="RdPrefixRow">
    <td  width="30%" BindText = 'Des6RDPrefix'></td>
    <td  width="70%" id="RDPrefix"></td>
  </tr>
  <tr class="tabal_01 align_left"  id="RdPrefixLenRow">
    <td  width="30%" BindText = 'Des6RDPrefixLenth'></td>
    <td  width="70%" id="RDPrefixLenth"></td>
  </tr>
  <tr class="tabal_01 align_left"  id="RdBRIPv4AddressRow">
    <td  width="30%" BindText = 'Des6RDBrAddr'></td>
    <td  width="70%" id="RDBrAddr"></td>
  </tr>
  <tr class="tabal_01 align_left"  id="RdIPv4MaskLenRow">
    <td  width="30%" BindText = 'Des6RDIpv4MaskLenth'></td>
    <td  width="70%" id="RDIpv4MaskLenth"></td>
  </tr>
</table>
</div>

<div class="func_spread"></div>

<table class="tabal_bg width_100p" cellspacing="1"  id="IPv6PrefixPanel">
  <div class="func_title" id = "Table_wan_ipv6_table">IPV6信息</div>
  <tr class="head_title" id = "Table_wan_ipv6_head">
	<td id = "Table_wan_ipv6_1_1_table" nowrap>WAN连接名称</td>
	<td id = "Table_wan_ipv6_1_2_table" nowrap>使能状态</td>
    <td id = "Table_wan_ipv6_1_3_table" nowrap>连接状态</td>
	<td id = "Table_wan_ipv6_1_4_table" nowrap>前缀获取方式</td>
    <td id = "Table_wan_ipv6_1_5_table" nowrap>前缀</td>
    <td id = "Table_wan_ipv6_1_6_table" nowrap>IP获取方式</td>
    <td id = "Table_wan_ipv6_1_7_table" nowrap>IP地址</td>
    <td id = "Table_wan_ipv6_1_8_table" nowrap>IP地址状态</td>
	<td id = "Table_wan_ipv6_1_9_table" nowrap>主用DNS</td>
    <td id = "Table_wan_ipv6_1_10_table" nowrap>备用DNS</td>
	<td id = "Table_wan_ipv6_1_11_table" nowrap>VLAN/优先级</td>
	<td id = "Table_wan_ipv6_1_12_table" nowrap>MAC地址</td>
    <td id = "Table_wan_ipv6_1_13_table" nowrap>网关</td>
  </tr>
  <script type="text/javascript" language="javascript">
  	function DrawIPv6Table() {
  		var domString = "";
		for (var i = 0;i < GetWanList().length;i++)
		{
		    var CurrentWan = GetWanList()[i];

		    if ((CurrentWan.IPv6Enable != "1")|| (CurrentWan.X_HW_VXLAN_Enable == 1)) {
		        continue;
		    }

		    IPv6WanCount++;
			var IPv6WanCol = IPv6WanCount + 1;
			var ipv6Wan = GetIPv6WanInfo(CurrentWan.MacId);
			if (ipv6Wan == null)
			{
				continue;
			}
			domString += ('<tr id="ipv6record_' + i + '" onclick="selectLineipv6(this.id);" class="tabal_center01">');
            var idPrefix = getElementId(domainTowanname(CurrentWan.domain));
            var bridgeHostEnable = GetBridgeHostInfo(CurrentWan.domain);
			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_1_table" class="'+idPrefix+'_Name" nowrap>'+CurrentWan.Name+'</td>');

			if("1" != CurrentWan.Enable)
			{
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_2_table" nowrap>禁用</td>');
			}
			else
			{
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_2_table" nowrap>启用</td>');
			}

			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_3_table" nowrap>'+ConvertWanStatus(ipv6Wan.ConnectionStatus)+'</td>');

		    var AddressList = GetIPv6AddressList(CurrentWan.MacId);
			var PrefixAcquire = GetIPv6PrefixAcquireInfo(CurrentWan.domain);
			var AddressAcquire = GetIPv6AddressAcquireInfo(CurrentWan.domain);
			PrefixAcquire = ((PrefixAcquire==null) ? '' : PrefixAcquire.Origin);
			PrefixAcquire = ((CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) && (bridgeHostEnable == 0)) ? '--' : PrefixAcquire;
			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_4_table" nowrap>'+PrefixAcquire+'</td>');

			var PrefixList = GetIPv6PrefixList(CurrentWan.MacId)
			var Prefix = ((PrefixList!=null)?(PrefixList.length > 0?PrefixList[0].Prefix:'') :(PrefixList[0].Prefix));
			Prefix = (CurrentWan.Enable == "1") ? Prefix : "";
			Prefix = ((CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) && (bridgeHostEnable == 0)) ? '--' : Prefix;
			if(ipv6Wan.ConnectionStatus.toUpperCase()=="CONNECTED" || ('1' == '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_LASTERR_IPVER_IND);%>') || ('<%HW_WEB_GetFeatureSupport(BBSP_FT_CTC);%>' == '1'))
			{
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_5_table" nowrap>'+Prefix+ '</td>');
			}
			else
			{
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_5_table" nowrap>'+'--'+ '</td>');
			}

			var AcquireHtml = "";
			var AddressHtml = "";
			var AddressStatusHtml = "";
			for (var m = 0; m < AddressList.length; m++)
			{
				 AcquireHtml += (AddressList[m].Origin == ""?AddressAcquire.Origin:AddressList[m].Origin) +"<br>";
				 if (CurrentWan.Enable == "1")
				 {
					 AddressHtml += AddressList[m].IPAddress+"<br>";
					 AddressStatusHtml += AddressList[m].IPAddressStatus +"<br>";
				 }
			}
			if ((CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) && (bridgeHostEnable == 0)) {
				AcquireHtml = "--<br>";
				AddressHtml = "--<br>";
				AddressStatusHtml = "--<br>";
			}
			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_6_table" nowrap>'+AcquireHtml+'</td>');
			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_7_table" nowrap>'+AddressHtml+'</td>');
			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_8_table" nowrap>'+AddressStatusHtml+'</td>');

			var IPv6WanDNSHtml = GetIPv6WanInfo(CurrentWan.MacId).DNSServers;
			var IPv6PrimaryDNSHtml = "";
			var IPv6SecondaryDNSHtml = "";
			if(IPv6WanDNSHtml != null)
			{
				var IPv6WanDNSHtmlList = IPv6WanDNSHtml.split(",");
				if(IPv6WanDNSHtmlList != null)
				{
					IPv6PrimaryDNSHtml = (IPv6WanDNSHtmlList.length >= 1)?IPv6WanDNSHtmlList[0]:'--';
					IPv6SecondaryDNSHtml =(IPv6WanDNSHtmlList.length >= 2)?IPv6WanDNSHtmlList[1]:'--';
				}
			}
			IPv6PrimaryDNSHtml = (IPv6PrimaryDNSHtml=="")?'--':IPv6PrimaryDNSHtml;
			IPv6SecondaryDNSHtml = (IPv6SecondaryDNSHtml=="")?'--':IPv6SecondaryDNSHtml;
			if ((CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) && (bridgeHostEnable == 0)) {
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_9_table" align="center" nowrap>--</td>');
			} else {
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_9_table" align="center" nowrap>'+IPv6PrimaryDNSHtml+'</td>');
			}
			if ((CurrentWan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) && (bridgeHostEnable == 0)) {
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_10_table" align="center" nowrap>--</td>');
			} else {
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_10_table" align="center" nowrap>'+IPv6SecondaryDNSHtml+'</td>');
			}

			if (0 != parseInt(CurrentWan.VlanId,10))
		    {
			var pri = ('Specified' == CurrentWan.PriorityPolicy) ? CurrentWan.Priority : CurrentWan.DefaultPriority ;
			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_11_table" nowrap>'+CurrentWan.VlanId+'/'+pri+'</td>');
			}
            else
			{
                  domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_11_table" align="center" nowrap>'+'-/-'+'</td>');
            }

			if(CurrentWan.MACAddress != '')
			{
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_12_table" nowrap>'+CurrentWan.MACAddress +'</td>');
			}
			else
			{
				domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_12_table" align="center" nowrap>--</td>');
			}

			var ipv6WanForGw = GetIPv6WanInfo(CurrentWan.MacId);
			var IPv6Gw = ipv6WanForGw.DefaultRouterAddress;
			if( null == IPv6Gw)
			{
				IPv6Gw = "--";
			}

			domString += ('<td id = "Table_wan_ipv6_'+IPv6WanCol+'_13_table" align="center" nowrap>'+IPv6Gw+'</td>');
			domString += ('</tr>');
		}

    	if( 0 == IPv6WanCount)
		{
			domString += ("<tr class= \"tabal_center01\">");
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ('<td >'+'--'+'</td>');
			domString += ("</tr>");
		}
		return domString;
  	}
    $("#Table_wan_ipv6_head").after(DrawIPv6Table());
		</script>
</table>

<div  align='center' style="display:none" id="IPv6WanDetail">
<table id="table_ipv6wandetail" class="tabal_bg width_100p"  cellspacing="1" >
  <tr class="head_title align_left">
    <td  colspan="8" BindText = 'bbsp_wandetailinfo'></td>
  </tr>

 <tr class="tabal_01 align_left">
    <td width="30%"  BindText = 'bbsp_wanmacaddress'></td>
    <td  width="70%" id="IPv6MacAddress"></td>
  </tr>
  <tr class="tabal_01 align_left">
    <td  width="30%"  BindText = 'bbsp_wanvlan'></td>
    <td  width="70%" id="IPv6Vlan"></td>
  </tr>
  <tr class="tabal_01 align_left">
    <td  width="30%"  BindText = 'bbsp_wanpripolicy'></td>
    <td  width="70%" id="IPv6PriorityPolicy"></td>
  </tr>
  <tr class="tabal_01 align_left">
    <td  width="30%"  BindText = 'bbsp_wanpriority'></td>
    <td  width="70%" id="IPv6Priority"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6NPTv6EnableRow">
    <td  width="30%"  BindText = 'bbsp_ntpv6enable'></td>
    <td  width="70%" id="IPv6NPTv6Enable"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6DnsServerRow">
    <td  width="30%"  BindText = 'bbsp_wandns'></td>
    <td  width="70%" id="IPv6DnsServer"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6PrefixRow">
    <td  width="30%"  BindText = 'bbsp_ipv6prefix'></td>
    <td  width="70%" id="IPv6Prefix"></td>
 </tr>
  <tr class="tabal_01 align_left" id="IPv6PrefixModeRow">
    <td  width="30%" BindText = 'bbsp_ipv6prefixmode'></td>
    <td  width="70%" id="IPv6PrefixMode"></td>
  </tr>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6PrefixPreferredTimeRow">
    <td class="align_left" width="30%" BindText = 'bbsp_prefixpreferredtime'></td>
    <td class="align_left"  width="70%" id="IPv6PrefixPreferredTime"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6PrefixVaildTimeRow">
    <td  width="30%" BindText = 'bbsp_prefixvaildtime'></td>
    <td  width="70%" id="IPv6PrefixVaildTime"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6PrefixVaildTimeRemainingRow">
    <td width="30%" BindText = 'bbsp_prefixvaild_remaining'></td>
    <td width="70%" id="IPv6PrefixVaildTimeRemaining"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6IpAddressRow">
    <td width="30%" BindText = 'bbsp_ipv6ipaddress'></td>
    <td width="70%" id="IPv6IpAddress"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6IpAccessModeRow">
    <td  width="30%" BindText = 'bbsp_ipacmode'></td>
    <td  width="70%" id="IPv6IpAccessMode"></td>
  </tr>
  <tr class="tabal_01 align_left" id="Ipv6IpStateRow">
    <td  width="30%" BindText = 'bbsp_ipv6ipstate'></td>
    <td  width="70%" id="Ipv6IpState"></td>
  </tr>

  <tr class="tabal_01 align_left" id="IPv6PreferredTimeRow">
    <td  width="30%" BindText = 'bbsp_ippreferredtime'></td>
    <td  width="70%" id="IPv6PreferredTime"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6VaildTimeRow">
    <td  width="30%" BindText = 'bbsp_ipvaildtime'></td>
    <td  width="70%" id="IPv6VaildTime"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6VaildTimeRemainingRow">
    <td  width="30%" BindText = 'bbsp_ipvaildtime_remaining'></td>
    <td  width="70%" id="IPv6VaildTimeRemaining"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6GateWayRow">
    <td  width="30%" BindText = 'bbsp_ipv6_default_route'></td>
    <td  width="70%" id="IPv6GateWay"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6DsliteAftrnameRow">
    <td  width="30%" BindText = 'bbsp_dsliteaftrname'></td>
    <td  width="70%" id="IPv6DsliteAftrname"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6DslitePeerAddressRow">
    <td  width="30%" BindText = 'bbsp_dslitepeeraddress'></td>
    <td  width="70%" id="IPv6DslitePeerAddress"></td>
  </tr>
  <tr class="tabal_01 align_left" id="IPv6DialFailedCodeRow">
    <td  width="30%" BindText = 'bbsp_wandialcode'></td>
    <td  width="70%" id="IPv6DialCode"></td>
  </tr>
</table>
</div>
<div class="func_spread"></div>
<table class="tabal_bg width_100p"  cellspacing="1" id="TableLinkStatesInfo_Wan" style="display:none">
    <div class="func_title" id = "Table_wan_link_table" style="display:none">WAN口性能统计</div>
	<tr class="tabal_01 align_left">
        <td  width="30%" >WAN口发包数:</td>
        <td  width="70%">
		<div id="WanStatsSendPackets"></div>
		</td>
    </tr>
	<tr class="tabal_01 align_left">
        <td  width="30%"  >WAN口收包数:</td>
        <td  width="70%">
		<div id="WanStatsReceivePackets"></div>
		</td>
    </tr>
	<tr class="tabal_01 align_left">
        <td  width="30%"  >WAN口接收字节:</td>
        <td  width="70%">
		<div id="WanStatsReceiveBytes"></div>
		</td>
    </tr>
	<tr class="tabal_01 align_left">
        <td  width="30%"  >WAN口发送字节:</td>
        <td  width="70%">
		<div id="WanStatsSendBytes"></div>
		</td>
    </tr>
</table>
<table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td></td>
  </tr>
</table>
</div>
<div class="subWanListPolicyRoute subWanListIPVersion subIspWlan subDSLite subV6RDTunnel subRadioWan subWanStats subWANAccessType ">
    <script type="text/javascript">
        function RenderPage(event) {
            $(".tabal_center01").remove();
            $("#Table_wan_ipv4_head").after(DrawIPv4Table());
            $("#Table_wan_ipv6_head").after(DrawIPv6Table());
            if (Selected_LastControlID) {
                setControl(Selected_LastControlID);
            }
        }
        LazyLoad();
    </script>
</div>
</body>
</html>
