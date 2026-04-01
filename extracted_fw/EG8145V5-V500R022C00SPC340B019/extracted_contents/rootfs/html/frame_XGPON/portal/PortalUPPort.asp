<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no"/>
	<title></title>
	<link href="/Cuscss/<%HW_WEB_GetCusSource(bootstrap.min.css);%>"  media="all" rel="stylesheet" />
	<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
	<link href="/Cuscss/<%HW_WEB_GetCusSource(portal.css);%>"  media="all" rel="stylesheet" />
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(bootstrap.min.js);%>"></script>
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
	<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>

	<style>	
		@media screen and (max-width: 320px) {
			body {
				background: pink;
			}

			.devicename {
				float: left;
				left: 4%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 0.5vw;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 0.5vw;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 0.5vw;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 66%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 0.5vw;
				letter-spacing: -1px;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 26%;
				left: -2%;
				font-size: 0.5vw;
				letter-spacing: -1px;
			}
			
			.devicenameThree {
				float: left;
				left: 41%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 0.5vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 74%;
				top: 3%;
				position: absolute;
				z-index: 1;
				font-size: 0.5vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 0.5vw;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 329px) and (max-width: 480px) {
			body {
				background: #7265ec;
			}

			.devicename {
				float: left;
				left: 9%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 79%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 41%;
				left: 8%;
				font-size: 1.4vw;
			}
			
			.devicenameThree {
				float: left;
				left: 42%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 77%;
				top: 11%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 78%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 481px) and (max-width: 768px) {
			body {
				background: #65b1ec;
			}

			.devicename {
				float: left;
				left: 9%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 75%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 38%;
				font-size: 2vw;
				left: 5%;
			}
			
			.devicenameThree {
				float: left;
				left: 42%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 77%;
				top: 11%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 769px) and (max-width: 960px) {
			body {
				background: #65ec9b;
			}

			.devicename {
				float: left;
				left: 10%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 77%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}

			.apstyle {
				width: 40%;
				height: auto;
				z-index: 2;
				float: left;
				position: absolute;
				top: 38%;
				font-size: 2vw;
				left: 0%;
			}
			
			.devicenameThree {
				float: left;
				left: 44%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 78%;
				top: 14%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 2vw;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 961px) and (max-width: 1080px) {
		
			body {
				background: #98d67a;
			}

			.devicename {
				float: left;
				left: 10%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.8vw;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 1.8vw;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 1.8vw;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 75%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.8vw;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 37%;
				font-size: 1.8vw;
				left: 0%;
			}
			
			.devicenameThree {
				float: left;
				left: 44%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.8vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 79%;
				top: 13%;
				position: absolute;
				z-index: 1;
				font-size: 1.8vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 1.8vw;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 1081px) and (max-width: 1200px) {
			body {
				background: #e0e887;
			}

			.devicename {
				float: left;
				left: 10%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.7vw;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 1.7vw;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 1.7vw;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 77%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.7vw;
				font-family: "微软雅黑";
			}
			
			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 38%;
				font-size: 1.7vw;
				left: 5%;
			}
			
			.devicenameThree {
				float: left;
				left: 44%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.7vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 78%;
				top: 14%;
				position: absolute;
				z-index: 1;
				font-size: 1.7vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 1.7vw;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 1201px) and (max-width: 1400px) {
			body {
				background: #e8a787;
			}

			.devicename {
				float: left;
				left: 10%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 77%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 37%;
				font-size: 1.4vw;
				left: 5%;
			}
			
			.devicenameThree {
				float: left;
				left: 44%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 78%;
				top: 14%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 1.4vw;
				font-family: "微软雅黑";
			}
		}
		
		
		@media only screen and (min-width: 1401px) and (max-width: 1600px) {
			body {
				background: #e8a787;
			}

			.devicename {
				float: left;
				left: 9%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 77%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 38%;
				font-size: 20px;
				left: 5%;
			}
			
			.devicenameThree {
				float: left;
				left: 44%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 74%;
				top: 14%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 1601px) and (max-width: 1800px) {
			body {
				background: #e8a787;
			}
			
			.devicename {
				float: left;
				left: 10%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 74%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 37%;
				font-size: 20px;
				left: 5%;
			}
			
			.devicenameThree {
				float: left;
				left: 44%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 78%;
				top: 14%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
		}
		
		@media only screen and (min-width: 1801px) {
			body {
				background: #e8a787;
			}

			.devicename {
				float: left;
				left: 10%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.sectionline {
				width: 50%;
				float:left;
				left: 27%;
				top: 26%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.wanportinfo {
				margin-right:10%;
			}

			.sectionlineTwo {
				width: 50%;
				float:left;
				left: 27%;
				top: 71%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameTwo {
				float: left;
				left: 74%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}

			.apstyle {
				z-index: 2;
				float: left;
				position: absolute;
				top: 37%;
				font-size: 20px;
				left: 5%;
			}
			
			.devicenameThree {
				float: left;
				left: 44%;
				top: 82%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameFour {
				float: left;
				left: 78%;
				top: 14%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
			
			.devicenameFive {
				float: left;
				left: 76%;
				top: 74%;
				position: absolute;
				z-index: 1;
				font-size: 20px;
				font-family: "微软雅黑";
			}
		}
		
	</style>
	<script type="text/javascript">
	var LANPath = "InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.";
	var SSIDPath = "InternetGatewayDevice.LANDevice.1.WLANConfiguration.";
	var IPTVUpPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.IPTVUpPort);%>'.toUpperCase();
	self.parent.CurrentIPTVUpInfo = "";
	var LANPortInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_APService.MultiSrvPortList.PhyPortName);%>'.toUpperCase();
	var WLANInfoList = '<%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.WLANConfiguration.{i}, SSIDReference, stWLANInfo);%>';
    if (WLANInfoList !== '') {
      WLANInfoList= dealDataWithStr(WLANInfoList);
    } else {
      WLANInfoList= new Array(null);
    }
	self.parent.CurrentLANPortList = new Array();
	var AllLANPortList = new Array();
	var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfo);%>;
	var TopoInfo = TopoInfoList[0];
	TopoInfo.EthNum = '<%GetLanPortNum();%>';
	var UpgradeFlag = 0;
	self.parent.EnableUPPort = "off";
	GetLANPortListInfo();
	GetIPTVPortInfo();
	var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
	document.title = ProductName;

	var portalAPType = '<%HW_WEB_GetApMode();%>';
	var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
	if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
	{
		window.location='/login.asp'; 
	}
	
	function stWLANInfo(Domain, SSIDReference)
	{
		this.Domain = Domain;
		this.SSIDReference = SSIDReference.replace("Device.WiFi.SSID.", "SSID");;
	}

	function GetIPTVPortInfo()
	{
		if (IPTVUpPortInfo.length != 0)
		{
			var tempIPTVUpValue = IPTVUpPortInfo.replace(LANPath.toUpperCase(), "LAN");
			var tempIPTVUpList = tempIPTVUpValue.split(".");;
			self.parent.CurrentIPTVUpInfo = tempIPTVUpList[0];
			self.parent.EnableUPPort = "on";
		}
	}

	function GetLANPortListInfo()
	{
		var tempLANPortValue = "";
		if (LANPortInfo == "")
		{
			return;
		}
		
		var tempLANPortList = LANPortInfo.split(",");
		for (var i = 0; i < tempLANPortList.length; i++)
		{		
			if (tempLANPortList[i].indexOf(LANPath.toUpperCase()) != -1)
			{
				tempLANPortValue = tempLANPortList[i].replace(LANPath.toUpperCase(), "LAN");
			}
			else
			{
				tempLANPortValue = tempLANPortList[i].replace(SSIDPath.toUpperCase(), "SSID");
			}

			var tempLANPortInfoList = tempLANPortValue.split(".");
			self.parent.CurrentLANPortList[i] = tempLANPortInfoList[0];
			self.parent.EnableUPPort = "on";
		}
	}

	function TopoInfo(Domain, EthNum, SSIDNum)
	{   
		this.Domain = Domain;
		this.EthNum = EthNum;
		this.SSIDNum = SSIDNum;
	}
    
	function InitValue()
	{
		var i;
		if (self.parent.CurrentLANPortList.length == 0 && self.parent.CurrentIPTVUpInfo == "")
		{
			for (i = 0; i < AllLANPortList.length; i++)
			{
				if (AllLANPortList[i] == "LAN1")
				{
					self.parent.CurrentIPTVUpInfo = "LAN1";
				}
				
				if (AllLANPortList[i] == "LAN2")
				{
					self.parent.CurrentLANPortList[0] = "LAN2";
				}	
			}
		}
		
		return;
	}
		
	function InitLANPortFromValue()
	{
		setCheck("LAN1", 0);
		setCheck("LAN2", 0);
		setCheck("LAN3", 0);
		setCheck("LAN4", 0);
		setCheck("LAN5", 0);
		setCheck("SSID1", 0);
		setCheck("SSID2", 0);
		setCheck("SSID3", 0);
		setCheck("SSID4", 0);
		setCheck("SSID5", 0);
		setCheck("SSID6", 0);
		setCheck("SSID7", 0);
		setCheck("SSID8", 0);
		setDisable("Div_LAN1", 0);
		setDisable("Div_LAN2", 0);
		setDisable("Div_LAN3", 0);
		setDisable("Div_LAN4", 0);
		setDisable("Div_LAN5", 0);
		
		if (self.parent.CurrentIPTVUpInfo != "")
		{
			setDisable("Div_" + self.parent.CurrentIPTVUpInfo, 1);
		}
		
		for(var i = 0; i < self.parent.CurrentLANPortList.length; i++)
		{
			setCheck(self.parent.CurrentLANPortList[i].toUpperCase(), 1);
		}
		
		return;
	}

	function InitIPTVUpFromValue()
	{
		var isNeedAdd = 1;
		var Option = document.createElement("Option");
		Option.value = "";
		Option.innerText = "";
		Option.text = "";
		removeAllOption("IPTVUpPortID");
		getElById("IPTVUpPortID").appendChild(Option);

		for (var i = 1; i <= TopoInfo.EthNum; i++)
		{
			isNeedAdd = 1;
			lanoption = "LAN" + i;
			for (var j = 0; j < self.parent.CurrentLANPortList.length; j++)
			{
				if (lanoption == self.parent.CurrentLANPortList[j])
				{
					isNeedAdd = 0;
					break;
				}
			}
			
			if (isNeedAdd == 1)
			{
				Option = document.createElement("Option");
				Option.value = lanoption;
				Option.innerText = lanoption;
				Option.text = lanoption;
				getElById("IPTVUpPortID").appendChild(Option);
			}
		}
		
		if (self.parent.CurrentIPTVUpInfo != "")
		{
			setSelect("IPTVUpPortID", self.parent.CurrentIPTVUpInfo);
		}
		
		return;
	}
	
	function ShowEnableUPPort()
	{
		if (self.parent.EnableUPPort == "off")
		{
			setDisplay('ImagesInfoID', 0);
			setDisplay('LANPortTipID', 0);
			setDisplay('LANPortID', 0);
			setDisplay('SSID1PortID', 0);
			setDisplay('SSID5PortID', 0);
			setDisplay('IPTVUPPortTipID', 0);
			setDisplay('IPTVUPPortRowID', 0);
			setDisplay('HelpTipID', 1);
			document.getElementById('swithicon').setAttribute('src', '/images/checkoff.jpg')
		}
		else
		{
			setDisplay('HelpTipID', 0);
			setDisplay('ImagesInfoID', 1);
			setDisplay('LANPortTipID', 1);
			setDisplay('LANPortID', 1);
			setDisplay('SSID1PortID', 1);
			setDisplay('SSID5PortID', 1);
			setDisplay('IPTVUPPortTipID', 1);
			setDisplay('IPTVUPPortRowID', 1);
			document.getElementById('swithicon').setAttribute('src', '/images/checkon.jpg')
		}
		
		self.parent.IPTVUPPortSytleControl(self.parent.EnableUPPort);
	}
	
	function SwithEnableUPPort()
	{
		if(document.getElementById('swithicon').getAttribute('src') == "/images/checkon.jpg")
		{
			self.parent.EnableUPPort = "off";
			document.getElementById('swithicon').setAttribute('src', '/images/checkoff.jpg')
		} 
		else
		{
			self.parent.EnableUPPort = "on";
			document.getElementById('swithicon').setAttribute('src', '/images/checkon.jpg')
		}
		
		ShowEnableUPPort();
	}
	
	function GetCurrentLANPortValue()
	{
		var tempLANID = "";
		var tempSSIDID = "";
		var i = 0;
		
		self.parent.CurrentLANPortList = [];
		for (i = 1; i <= TopoInfo.EthNum; i++)
		{
			tempLANID = "LAN" + i;
			if (1 == getCheckVal(tempLANID))
			{
				self.parent.CurrentLANPortList.push(tempLANID);
			}
		}

		for (i = 1; i <= TopoInfo.SSIDNum; i++)
		{
			tempSSIDID = "SSID" + i;
			if (1 == getCheckVal(tempSSIDID))
			{
				self.parent.CurrentLANPortList.push(tempSSIDID);
			}
		}
		
		return;
	}
	
	function GetCurrentIPTVUPPortValue()
	{
		self.parent.CurrentIPTVUpInfo = getSelectVal("IPTVUpPortID");
	}
	
	function GetCurrentValue()
	{
		GetCurrentLANPortValue();
		GetCurrentIPTVUPPortValue();
	}
	
	function LimitLANPortValue()
	{
		var i;
		var j;
		var bIsDisable = 0;
		
		for (i = 0; i < AllLANPortList.length; i++)
		{
			if (self.parent.CurrentIPTVUpInfo == AllLANPortList[i])
			{
				continue;
			}
			
			setDisable(AllLANPortList[i], 0);
		}
		
		if (self.parent.CurrentLANPortList.length < 4)
		{
			return;
		}
		
		for (i = 0; i < AllLANPortList.length; i++)
		{
			bIsDisable = 0;
			
			for (j = 0;j < self.parent.CurrentLANPortList.length; j++)
			{
				if (AllLANPortList[i] == self.parent.CurrentLANPortList[j])
				{
					bIsDisable = 1;
					break;
				}
			}
			
			if (bIsDisable == 0)
			{
				setDisable("Div_" + AllLANPortList[i], 1);
			}
		}
	}
	
	function OnSelectMultiService()
	{
		GetCurrentValue();
		InitLANPortFromValue();
		InitIPTVUpFromValue();
		LimitLANPortValue();
		ControlImages();
		return;
	}
	
	function ControlImages()
	{
		var tempInfo = "";
		if (self.parent.CurrentIPTVUpInfo == "")
		{
			$("#iptvupport1Img").attr("src","/images/iptvImg3.jpg");
			setDisplay('sectionlineTwoDiv', 0);
		}
		else
		{
			document.getElementById("iptvWanID").innerHTML = self.parent.CurrentIPTVUpInfo;	
			$("#iptvupport1Img").attr("src","/images/iptvImg1.jpg");
			setDisplay('sectionlineTwoDiv', 1);			
		}
		
		for (var i = 0; i < self.parent.CurrentLANPortList.length; i++)
		{
			if (i == 0)
			{
				tempInfo = tempInfo + self.parent.CurrentLANPortList[i];
			}
			else
			{
				if (i == 1)
				{
					tempInfo = tempInfo + ",<br>" + self.parent.CurrentLANPortList[i];
				}
				else 
				{
					tempInfo = tempInfo + "," + self.parent.CurrentLANPortList[i];
				}
			}
		}
		
		document.getElementById("LANPortNameID").innerHTML = tempInfo;
		
		if (self.parent.CurrentLANPortList.length == 0)
		{
			$("#iptvupport1").css("margin-left","-1em");
			
			setDisplay("iptvupport2", 0);
			setDisplay("iptvupport1", 1);
		}
		else if (self.parent.CurrentLANPortList[0] == "")
		{
			$("#iptvupport1").css("margin-left","-1em");
			
			setDisplay("iptvupport2", 0);
			setDisplay("iptvupport1", 1);
		}
		else
		{
			$("#iptvupport1").css("margin-left","0");
			setDisplay("iptvupport1", 1);
			setDisplay("iptvupport2", 1);
		}
		
		return;
	}
	
	function LoadFrame()
	{
		InitValue();
		InitLANPortFromValue();
		InitIPTVUpFromValue();
		ShowEnableUPPort();
		ControlImages();
		parent.adjustIframeHeight();
		self.parent.curPageFlag = "IPTVPortPage";
		self.parent.ControlPageShow();
		return;
	}
	
	function IPTVPortSubform()
	{
		SetAjaxIPTVPort();
		return true;
	}
	
	</script>
  </head> 
  
  <body onload="LoadFrame();" style="background-color: #f2f2f2;" class="bodyclass_12">
		<div class="stepPortalContent">  
			<div class="stepPortalTipUpport" style="background-color: #ffffff;">
				<div class="stepPortalTipSpan" style="float:left;margin-right: 5%;margin-left: 2%;" BindText="p0132"></div>
				<div style="text-align: left;" onclick="SwithEnableUPPort();" ><img src="/images/checkoff.jpg" id="swithicon"/></div>
			</div>
		</div>

		<div class="func_spread"></div>
		<div id="HelpTipID" class="stepPortalTipUpport" style="background-color: #ffffff; line-height:1.5em;">
			<span class="TextHelp" style="margin-left:1.5%" BindText="p0133"></span>
		</div>
	
	<div id="ImagesInfoID" style="display: none;">	
		<div class="iptvupportcss">
			<div id="iptvupport1">
				<img id='iptvupport1Img' src="/images/iptvImg1.jpg">
				<span class="devicename" BindText="p0134"></span>
				<div class="sectionline">
					<span class="wanportinfo" BindText="p0135"></span>
					<span class="wanportinfo" BindText="p0143"></span>
				</div>
				<div id="sectionlineTwoDiv" class="sectionlineTwo">
					<span class="wanportinfo" BindText="p0136"></span>
					<span id="iptvWanID" class="wanportinfo"></span>
				</div>
				<span>
					<script>document.write('<div class="devicenameTwo" id="PortalProductName">' + ProductName + '</div>');</script>
				</span>
			</div>
			
			<div id="iptvupport2" class="iptvupport2" style="display:block;">
				<img src="/images/iptvImg2.jpg">
				<span id="LANPortNameID" class="apstyle" BindText="p0137"></span>
				<span class="devicenameThree" BindText="p0138"></span>
				<span class="devicenameFour" BindText="p0139"></span>
				<span class="devicenameFive" BindText="p0140"></span>
				
			</div>
		</div>	
	</div>		
		
		<div id="LANPortTipID" class="" style="display: none;background-color: #ffffff;margin-top:3em;line-height: 4em;">
			<div class="stepPortalTipSpan" style="text-align: left;margin-bottom:1.5em;margin-left: 2.5%;" BindText="p0141"></div>
		</div>

		<div id='AllPortID' style="margin-left: 2.5%;">
		<div id="LANPortID" style="text-align:left;display: none;">
				<div id="Div_LAN1"  class="col-xs-3"> 
					<input type="checkbox" id="LAN1" name="cb_Lan1" value="LAN1" onclick="OnSelectMultiService()">LAN1</input>
				</div>
				<div id="Div_LAN2" class="col-xs-3">
					<input type="checkbox" id="LAN2" name="cb_Lan2" value="LAN2" onclick="OnSelectMultiService()">LAN2</input>
				</div>
				<div id="Div_LAN3" class="col-xs-3">
					<input type="checkbox" id="LAN3" name="cb_Lan3" value="LAN3" onclick="OnSelectMultiService()">LAN3</input>
				</div>
				<div id="Div_LAN4" class="col-xs-3">
					<input type="checkbox" id="LAN4" name="cb_Lan4" value="LAN4" onclick="OnSelectMultiService()">LAN4</input>
				</div>
				<div id="Div_LAN5" class="col-xs-3">
					<input type="checkbox" id="LAN5" name="cb_Lan5" value="LAN5" onclick="OnSelectMultiService()">LAN5</input>
				</div>
		</div>
		<div class="clear"></div>

		<script>
			var EthNum = TopoInfo.EthNum;
			for (var i = 1; i <= 5; i++)
			{
				if (i > EthNum)
				{
					setDisplay("Div_LAN" + i, 0);
				}
				else
				{
					AllLANPortList.push("LAN" + i);
				}
			}
		</script>	
		<div id="SSID1PortID" style="text-align:left;display: none;" >
				<div id="Div_SSID1" class="col-xs-3"> 
					<input type="checkbox" id="SSID1" name="cb_Ssid1" value="SSID1" onclick="OnSelectMultiService()">SSID1</input>
				</div>
				<div id="Div_SSID2" class="col-xs-3">
					<input type="checkbox" id="SSID2" name="cb_Ssid2" value="SSID2" onclick="OnSelectMultiService()">SSID2</input>
				</div>
				<div id="Div_SSID3" class="col-xs-3">
					<input type="checkbox" id="SSID3" name="cb_Ssid3" value="SSID3" onclick="OnSelectMultiService()">SSID3</input>
				</div>
				<div id="Div_SSID4" class="col-xs-3">
					<input type="checkbox" id="SSID4" name="cb_Ssid4" value="SSID4" onclick="OnSelectMultiService()">SSID4</input>
				</div>
		</div>
		<div class="clear"></div>
		<div id="SSID5PortID" style="text-align:left;display: none;" >
				<div id="Div_SSID5" class="col-xs-3"> 
					<input type="checkbox" id="SSID5" name="cb_Ssid5" value="SSID5" onclick="OnSelectMultiService()">SSID5</input>
				</div>
				<div id="Div_SSID6" class="col-xs-3"> 
					<input type="checkbox" id="SSID6" name="cb_Ssid6" value="SSID6" onclick="OnSelectMultiService()">SSID6</input>
				</div>
				<div id="Div_SSID7" class="col-xs-3"> 
					<input type="checkbox" id="SSID7" name="cb_Ssid7" value="SSID7" onclick="OnSelectMultiService()">SSID7</input>
				</div>
				<div id="Div_SSID8" class="col-xs-3"> 
					<input type="checkbox" id="SSID8" name="cb_Ssid8" value="SSID8" onclick="OnSelectMultiService()">SSID8</input>
				</div>
		</div>
		</div>
		<div class="clear"></div>
		<script>		
			var SSIDNum = TopoInfo.SSIDNum;
			var i;
			for (i = 1; i <= 8; i++)
			{
				if (i > SSIDNum)
				{
					setDisplay("Div_SSID"+i, 0);
				}
			}
			
			setDisplay("Div_SSID1", 0);
			setDisplay("Div_SSID2", 0);
			setDisplay("Div_SSID3", 0);
			setDisplay("Div_SSID4", 0);
			setDisplay("Div_SSID5", 0);
			setDisplay("Div_SSID6", 0);
			setDisplay("Div_SSID7", 0);
			setDisplay("Div_SSID8", 0);
			
			for(i = 0; i < WLANInfoList.length - 1; i++)
			{
				setDisplay("Div_" + WLANInfoList[i].SSIDReference, 1);
				AllLANPortList.push(WLANInfoList[i].SSIDReference);
			}
		</script>
		
		<div id="IPTVUPPortRowID" class="stepPortalTipSpan" style="display: none;margin-top:8em;font-size: 1.5em;line-height: 4em;background-color: #ffffff">
			<span style="float:left; margin-left: 2.5%;" BindText="p0142"></span>
			<div style="text-align: left;margin-left:1em;">
				<select id="IPTVUpPortID" onchange="OnSelectMultiService()">
					<option value="LAN0"></option>
					<option value="LAN1">LAN1</option>
					<option value="LAN2">LAN2</option>
					<option value="LAN3">LAN3</option>
				</select>
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
