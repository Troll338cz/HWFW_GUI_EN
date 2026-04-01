<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title></title>
	<link href="/Cuscss/<%HW_WEB_GetCusSource(bootstrap.min.css);%>"  media="all" rel="stylesheet" />
	<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
	<link href="/Cuscss/<%HW_WEB_GetCusSource(portal.css);%>"  media="all" rel="stylesheet" />
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(bootstrap.min.js);%>"></script>
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
	<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>

	<script type="text/javascript">
	var curUPPort = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_MainUpPort);%>';
	var LANPortInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort.{i}.CommonConfig, Link, stUpLink);%>;
	self.parent.WanIp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANIPConnection.{i},ConnectionStatus|X_HW_VLAN|X_HW_SERVICELIST|ConnectionType|AddressingType|ExternalIPAddress|SubnetMask|DefaultGateway|DNSServers,WANIP);%>;
	self.parent.WanPpp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANPPPConnection.{i},ConnectionStatus|X_HW_VLAN|X_HW_SERVICELIST|ConnectionType|Username,WANPPP);%>;
	self.parent.currDHCPIndex = -1;
	self.parent.currPPPOEIndex = -1;
	self.parent.currStaticIndex = -1;
	self.parent.DNSResult = 0;
	var count = 0;
	var countDns = 0;
	var checkCreateWanCount = 0;
	var CheckDNSResultHandle;
	var CheckOnlineInternetWanHandle;
	var CheckCreateWANInfoHandle;
	var MaxCount = 6;
	var portalAPType = '<%HW_WEB_GetApMode();%>';
	var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
	var pingUrl = '<%HW_WEB_GetSPEC(SSMP_SPEC_PING_URL.STRING);%>';
	if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
	{
		window.location='/login.asp'; 
	}
	
	function stUpLink(domain, Link)
	{
		this.domain 	= domain;
		this.Link 	    = Link;
	}
	
	function WANIP(domain, ConnectionStatus, X_HW_VLAN, X_HW_SERVICELIST, ConnectionType, AddressingType, ExternalIPAddress, SubnetMask, DefaultGateway, DNSServers)
	{
		this.domain 	= domain;
		this.ConnectionStatus 	= ConnectionStatus;			
		this.ConnectionType	= ConnectionType;
		this.X_HW_VLAN	= X_HW_VLAN;
		this.X_HW_SERVICELIST = X_HW_SERVICELIST;
		this.AddressingType = AddressingType;
		this.ExternalIPAddress = ExternalIPAddress;
		this.SubnetMask = SubnetMask;
		this.DefaultGateway = DefaultGateway;
		this.DNSAServers = "";
		this.DNSSServers = "";
		if (DNSServers != "")
		{
			DNSList = DNSServers.split(",");
			this.DNSAServers = DNSList[0];
			if (DNSList.length == 2)
			{
				this.DNSSServers = DNSList[1];
			}
		}
	}

	function WANPPP(domain, ConnectionStatus, X_HW_VLAN, X_HW_SERVICELIST, ConnectionType, Username)
	{
		this.domain	= domain;
		this.ConnectionStatus	= ConnectionStatus;	
		this.ConnectionType	= ConnectionType;
		this.X_HW_VLAN	= X_HW_VLAN;
		this.X_HW_SERVICELIST = X_HW_SERVICELIST;
		this.Username = Username;
	}
	
	function GetWanInfo()
	{
		$.ajax({
			type : "POST",
			async : true,
			cache : false,
			timeout : 4000,
			url : "/asp/GetPortalWanIp.asp",
			success : function(data) {
				self.parent.WanIp = dealDataWithFun(data);
			}
		});	

		$.ajax({
			type : "POST",
			async : true,
			cache : false,
			timeout : 4000,
			url : "/asp/GetPortalWanPpp.asp",
			success : function(data) {
				self.parent.WanPpp = dealDataWithFun(data);
			}
		});
	}
	
	
	function CheckInternetOnline()
	{		
		if (self.parent.curOnlineWan == "DHCP")
		{
			setDNSCheck(self.parent.WanIp[self.parent.currDHCPIndex].domain);
		}
		
		if (self.parent.curOnlineWan == "PPPOE")
		{
			setDNSCheck(self.parent.WanPpp[self.parent.currPPPOEIndex].domain);
		}

		if (self.parent.curOnlineWan == "Static")
		{
			setDNSCheck(self.parent.WanIp[self.parent.currStaticIndex].domain);
		}
	}
	
	function setDNSCheck(path)
	{
		var Result = null;
		var paralist = "";
			paralist += "DNSDomain=" + pingUrl;
			paralist += "&WanPath=" + path;
			
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : "/ParserDNSDomain.cgi?&RequestFile=/portal/PortalInternetStatus.asp",
			data: getDataWithToken(paralist),
			success : function(data) {
				 Result  = data;      
			}
		});
	}
	
	function GetDNSResult()
	{
		var cnt = '"false"';

		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : '/asp/GetPortalDNSResult.asp',
			success : function(data) {
				cnt = data;
			}
			});
		
		return cnt;
	}
	
	function ControlDNSShow()
	{
		var res = GetDNSResult();
		countDns++;
		DynamicShow(countDns);
		
		if (countDns >= MaxCount || res == '"true"')
		{
			if(CheckDNSResultHandle != undefined)
			{
				clearInterval(CheckDNSResultHandle);
			}
			
			setDisplay("WANConnecting", 0);
			self.parent.DisableBtn("false");
			if (res == '"true"')
			{
				self.parent.DNSResult = 1;
				setDisplay("WANOnlineID", 1);
				ShowOnlinePage();
			}
			else
			{
				self.parent.DNSResult = 0;
				setDisplay("WANOfflineID", 1);
				ShowSetWanPage();
			}
		}
	}
	
	function GetUPLinkStatus()
	{
		var index = curUPPort.substr(3);
		var path = "InternetGatewayDevice.X_HW_DEBUG.AMP.LANPort." + index + ".CommonConfig";
		
		for (var i = 0; i < LANPortInfoList.length - 1; i++)
		{
			if (LANPortInfoList[i].domain == path)
			{
				self.parent.curUPLinkStatus = LANPortInfoList[i].Link;
			}
		}
	}
		
	function ControlShow()
	{
		CheckOnlineInternetWan();
		count++;
		DynamicShow(count);
		
		if (count >= MaxCount || self.parent.curWANStatus == 1)
		{		
			self.parent.DisableWanBtn("false");
			if(CheckOnlineInternetWanHandle != undefined)
			{
				clearInterval(CheckOnlineInternetWanHandle);
			}
			
			if (self.parent.curWANStatus == 1)
			{
				CheckInternetOnline();
				CheckDNSResultHandle = setInterval("ControlDNSShow();", 2000);
			}
			else
			{
				self.parent.DisableBtn("false");
				setDisplay("WANConnecting", 0);
				setDisplay("WANDownID", 1);
				ShowSetWanPage();
			}
		}
	}
	
	function CheckCreateWanInfo()
	{
		CheckOnlineInternetWan();
		checkCreateWanCount++;
		
		if (checkCreateWanCount >= MaxCount || self.parent.currDHCPIndex != -1)
		{
			if(CheckCreateWANInfoHandle != undefined)
			{
				clearInterval(CheckCreateWANInfoHandle);
			}
		}
		
	}
	
	function CheckOnlineInternetWan()
	{
		var i = 0;
		self.parent.curWANStatus = 0;
		self.parent.curOnlineWan = "";
		GetWanInfo();
		
		for (i = 0; i < self.parent.WanIp.length - 1; i++)
		{
			if(self.parent.WanIp[i].ConnectionType == 'IP_Bridged')
			{
				continue;
			}
			
			if ((self.parent.WanIp[i].X_HW_SERVICELIST).indexOf("INTERNET") != -1 && self.parent.WanIp[i].AddressingType == "DHCP")
			{
				self.parent.currDHCPIndex = i;
				if (self.parent.WanIp[i].ConnectionStatus == "Connected")
				{
					self.parent.currDHCPIndex = i;
					self.parent.curOnlineWan = "DHCP";
					self.parent.curWANStatus = 1;
					break;
				}
			}
		}
		
		for (i = 0; i < self.parent.WanPpp.length - 1; i++)
		{
			if(self.parent.WanPpp[i].ConnectionType == 'PPPoE_Bridged')
			{
				continue;
			}
			
			if ((self.parent.WanPpp[i].X_HW_SERVICELIST).indexOf("INTERNET") != -1)
			{
				self.parent.currPPPOEIndex = i;
				if (self.parent.WanPpp[i].ConnectionStatus=="Connected")
				{
					self.parent.currPPPOEIndex = i;
					if (self.parent.curWANStatus == 0)
					{
						self.parent.curOnlineWan = "PPPOE";
						self.parent.curWANStatus = 1;
					}

					break;
				}
			}	
		}

		for (i = 0; i < self.parent.WanIp.length - 1; i++)
		{
			if(self.parent.WanIp[i].ConnectionType == 'IP_Bridged')
			{
				continue;
			}

			if ((self.parent.WanIp[i].X_HW_SERVICELIST).indexOf("INTERNET") != -1 && self.parent.WanIp[i].AddressingType == "Static")
			{
				self.parent.currStaticIndex = i;
				if (self.parent.WanIp[i].ConnectionStatus == "Connected")
				{
					self.parent.currStaticIndex = i;
					if (self.parent.curWANStatus == 0)
					{
						self.parent.curOnlineWan = "Static";
						self.parent.curWANStatus = 1;
					}

					break;
				}
			}
		}
		
		return;
	}
		
	function UPLinkStatusShow()
	{
		GetUPLinkStatus();
		setDisplay("UPLinkStatusID", 0);
		setDisplay("UPLinkStatusHelpID", 0);
		if (self.parent.curUPLinkStatus == 0)
		{
			setDisplay("UPLinkStatusID", 1);
			setDisplay("UPLinkStatusHelpID", 1);
			self.parent.ControlBtn();
		}
		
		return;
	}
	
	function CheckWANNum()
	{
		var WanNum = self.parent.WanIp.length + self.parent.WanPpp.length;
		if (WanNum <= 2)
		{
			self.parent.DHCPWanSubForm();
			CheckCreateWANInfoHandle = setInterval("CheckCreateWanInfo();", 2000);
		}

		return;
	}
	
	function ShowOnlinePage()
	{
		self.parent.InitShowControlWanBtn();
		self.parent.ControlWanBtn();
		self.parent.ControlBtn();
		return;
	}
	
	function ShowSetWanPage()
	{
		if (self.parent.FristLogin == 1)
		{
			self.parent.ControlBtn();
			return;
		}
		
		if (self.parent.currDHCPIndex != -1)
		{
			self.parent.ControlBtn();
			return;
		}
		
		if (self.parent.currPPPOEIndex != -1)
		{
			self.parent.toPPPOEPage();
			return;
		}

		if (self.parent.currStaticIndex != -1)
		{
			self.parent.toStaticIPPage();
			return;
		}
		
		self.parent.ControlBtn();
		return;
	}
	
	function InternetStatusShow()
	{
		CheckOnlineInternetWan();
		if (self.parent.curUPLinkStatus == 0)
		{
			return;
		}
		
		setDisplay("WANOfflineID", 0);
		setDisplay("WANOnlineID", 0);
		setDisplay("WANDownID", 0);
		setDisplay("WANConnecting", 1);
		self.parent.DisableBtn("true");
		CheckOnlineInternetWanHandle = setInterval("ControlShow();", 2000);
	}
	
	function DynamicShow(index)
	{
		switch (index)
		{
			case 1:
			case 4:
				document.getElementById("DynamicID").innerHTML = PortalguideDes['p0114a'];
				break;
			case 2:
			case 5:
				document.getElementById("DynamicID").innerHTML = PortalguideDes['p0114b'];
				break;
			case 3:
			case 6:
				document.getElementById("DynamicID").innerHTML = PortalguideDes['p0114c'];
				break;
			default:
				document.getElementById("DynamicID").innerHTML = PortalguideDes['p0114'];
				break;
		}
		
		return;
	}
	
	function LoadFrame()
	{
		self.parent.DisableWanBtn("true");
		UPLinkStatusShow();
		CheckWANNum();
		InternetStatusShow();
		self.parent.adjustIframeHeight();
		self.parent.curPageFlag = "WANStatusPage";
		self.parent.ControlPageShow();
	}
	</script>

</head>
<body onload="LoadFrame();" style="background-color: #f2f2f2;" class="bodyclass_12">
	<div class="indexPortalContent container">
		<div class="gatewayPortalImg asd">
			<img src="/images/portal_main.jpg" style="width: 50em;display:inline" class="img-responsive"/>
		</div>

		<div class="stepTipPortalSpan" style="padding-top:3.5em;">
			<div id="UPLinkStatusID" style="display:none;">
				<img src="/images/error.jpg"/>
				<span BindText="p0112"></span>
			</div>

			<div id="WANDownID" style="display:none;">
				<img src="/images/error.jpg"/>
				<span BindText="p0175"></span>
			</div>
			
			<div id="WANOfflineID" style="display:none;">
				<img src="/images/error.jpg"/>
				<span BindText="p0113"></span>
			</div>
			
			<div id="WANConnecting" style="display:none;">
				<img src="/images/choose.jpg"/>
				<span id="DynamicID" BindText="p0114"></span>
			</div>		
			
			<div id="WANOnlineID" style="display:none;">
				<img src="/images/choose.jpg"/>
				<span BindText="p0115"></span>
			</div>
		</div>
		
		<div class="stepTipPortalSpan" id="UPLinkStatusHelpID" style="display:none;margin-top:1em;font-size:1.3em;font-family: 微软雅黑;">
			<span style="" BindText="p0116"></span>
		</div>
	</div>
	<script>
	ParseBindTextByTagName(PortalguideDes, "span", 1);
	ParseBindTextByTagName(PortalguideDes, "td", 1);
	ParseBindTextByTagName(PortalguideDes, "div", 1);
	ParseBindTextByTagName(PortalguideDes, "input", 2);
	</script>

</body>
</html>
