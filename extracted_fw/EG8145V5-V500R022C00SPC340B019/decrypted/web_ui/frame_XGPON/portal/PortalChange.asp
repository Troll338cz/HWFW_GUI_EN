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
	<style>
	#bg{
		width:100%;
		height:100%;
		top:0px;
		left:0px;
		position:absolute;
		filter: Alpha(opacity=50);
		opacity:0.5;
		background:#000000;
		display:none;
		}
		
		
    #popbox{
		display: none; 
		position: absolute; 
		top: 25%; 
		left: 15%; 
		width: 70%; 
		height: auto;
		background-color: white; 
		z-index:1002; 
		border-radius:2em;
	  }
	  
	.popboxBtn{
		border-radius:0.2em;
		-webkit-border-radius:0.2em;
		font-size:2em;
		font-family:"微软雅黑";
		font-weight: bold;
		text-align: center;
		margin-left: auto;
		margin-right: auto;
		line-height: 2em;
		margin-top: 3em;
		margin-bottom: 2em;
		cursor: pointer;
		min-width: 3em;
		max-width: 16%;
		border: 0.1em solid rgb(0, 162, 232);
		color: rgb(0, 162, 232);
	}
	</style>
	<script type="text/javascript">
	var UserInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, UserName, stUserInfo);%>;
	var supportIPTVUPPortFlag = '<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>';
	var portalAPType = '<%HW_WEB_GetApMode();%>';
	var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
	var PageFlagList = ["WANStatusPage", "DHCPWANPage", "PPPOEWANPage", "StaticWANPage", "WIFIPWDPage", "WEBPWDPage", "IPTVPortPage", "EndStatusPage"];
	var curPageFlag = "WANStatusPage";
	var curUPLinkStatus = 1;
	var curWANStatus = 1;
	var curSamePWD = 0;
	var currDHCPIndex = -1;
	var currPPPOEIndex = -1;
	var currStaticIndex = -1;
	var WanIp;
	var WanPpp;
	var WANTypeList = ["DHCP", "PPPOE", "Static"];
	var curOnlineWan = "";
	var FristLogin = 0;
	var isConfigWiFi = 0;
	var wifiSsid;
	var wifissid5g;
	var wifiWPAPskKey;
	var wlanDomain2g;
	var wlanDomain5g;
	var EnableUPPort = "off";
	var CurrentIPTVUpInfo = "";
	var CurrentLANPortList = new Array();
	var needDelWANPath = "";
	var DNSResult = 0;
	var IsIPTVNeedConfig = 0;

	if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
	{
		window.location='/login.asp'; 
	}

	function pupopen()
	{
		document.getElementById("bg").style.display="block";
		document.getElementById("popbox").style.display="block" ;		
	}

	function pupclose()
	{
		document.getElementById("bg").style.display="none";
        document.getElementById("popbox").style.display="none" ;
	}
	
	function AlertIframeHeight()
	{
		getElementById('bg').style.height = document.body.scrollHeight * 1.1 + 'px';
	}
	
	function AlertInfo(curAlertInfo)
	{
		$('#alertinfoID').html(curAlertInfo);
		AlertIframeHeight();
		pupopen();
	}
	
	function stUserInfo(domain, UserName)
	{
		this.domain = domain;
		this.UserName = UserName;
	}
	
	function HwAjaxConfigPara(ObjPath, ParameterList)
	{
		var Result = null;
		$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/portalguideconfig.cgi?' + ObjPath + "&RequestFile=/portal/PortalInternetStatus.asp",
		data: getDataWithToken(ParameterList),
		success : function(data) {
		Result  = data;      
		}
		});

		return Result;
	}
	
	function DHCPWanSubForm()
	{
		if (self.parent.currDHCPIndex == -1)
		{
			var add_wanpath = "InternetGatewayDevice.WANDevice.1.WANConnectionDevice";     
			var add_path = 'Add_x='+ add_wanpath + 
					'&Addconnect_z=' + add_wanpath + '.{i}.WANIPConnection';

			var add_wanparalist = "Addconnect_z.Enable=1&Addconnect_z.X_HW_IPv4Enable=1&Addconnect_z.X_HW_IPv6Enable=0&Addconnect_z.X_HW_IPv6MultiCastVLAN=-1" +
				 "&Addconnect_z.X_HW_SERVICELIST=INTERNET&Addconnect_z.X_HW_ExServiceList=&Addconnect_z.X_HW_VLAN=0&Addconnect_z.X_HW_PRI=0" +
					  "&Addconnect_z.X_HW_PriPolicy=Specified&Addconnect_z.X_HW_DefaultPri=0&Addconnect_z.ConnectionType=IP_Routed" +
					  "&Addconnect_z.X_HW_MultiCastVLAN=4294967295&Addconnect_z.NATEnabled=1&Addconnect_z.X_HW_NatType=0" +
					  "&Addconnect_z.DNSEnabled=1&Addconnect_z.MaxMTUSize=1500&Addconnect_z.AddressingType=DHCP&Addconnect_z.DNSOverrideAllowed=0" +
					  "&Addconnect_z.DNSServers=&Addconnect_z.X_HW_VenderClassID=&Addconnect_z.X_HW_ClientID=&Addconnect_z.X_HW_BindPhyPortInfo=";         

			HwAjaxConfigPara(add_path, add_wanparalist);
		}
		else
		{
			var path = "x=" + self.parent.WanIp[currDHCPIndex].domain;
			var set_wanparalist = "x.AddressingType=DHCP&x.ExternalIPAddress=&x.SubnetMask=&x.DefaultGateway=&x.DNSServers=";
			HwAjaxConfigPara(path, set_wanparalist);
		}
	}
	
	function DelWanSubForm()
	{
		if (needDelWANPath == "")
		{
			return;
		}
		
		var del_path = 'Del_x='+ needDelWANPath;
		var del_wanparalist = "Del_x.Enable="
		HwAjaxConfigPara(del_path, del_wanparalist);
		needDelWANPath = "";
	}
		
	function IPTVUPPortSytleControl(EnableUPPort)
	{
		adjustIframeHeight();
	}
	
	function Subform()
	{
		switch (curPageFlag)
		{
			case "DHCPWANPage":
				DelWanSubForm();
				DHCPWanSubForm();
				break;
			case "PPPOEWANPage":
				DelWanSubForm();
				portalContent.window.PPPoeWanSubForm();
				break;
			case "StaticWANPage":
				DelWanSubForm();
				portalContent.window.StaticWanSubForm();
				break;
			case "WANStatusPage":
				break;
			case "WIFIPWDPage":
				isConfigWiFi = 1;
				break;
			case "WEBPWDPage":
				portalContent.window.ModifyWebPwd();
				break; 
			case "IPTVPortPage":
				IsIPTVNeedConfig = 1;
				break;
			case "EndStatusPage":
				break;
			default:
				AlertInfo(PortalguideDes['p0158']);
				break;
		}
		
		return;
	}
	
	function CheckValue()
	{
		switch (curPageFlag)
		{
			case "DHCPWANPage":
				break;
			case "PPPOEWANPage":
				return portalContent.window.CheckParameter();
			case "StaticWANPage":
				return portalContent.window.CheckParameter();
			case "WANStatusPage":
				break;
			case "WIFIPWDPage":
			    return portalContent.window.CheckParameter();
			case "WEBPWDPage":
				return portalContent.window.CheckParameter();
			case "IPTVPortPage":
			case "EndStatusPage":
			default:
				break;
		}
		
		return true;
	}
	
	function toDHCPPage()
	{
		DisableWanBtn("true");
		curPageFlag = "DHCPWANPage";
		if (curOnlineWan == "PPPOE")
		{
			needDelWANPath = WanPpp[currPPPOEIndex].domain;
			curOnlineWan = "";
		}
		else if (curOnlineWan == "Static")
		{
			currDHCPIndex = currStaticIndex;
			currStaticIndex = -1;
			curOnlineWan = "";
		}
		else if (curOnlineWan == "DHCP" || currDHCPIndex != -1)
		{
			InitShowControlPage();
			ChangePageFlag();
			ControlPage();
			return;
		}
		else
		{
			if (currStaticIndex != -1)
			{
				currDHCPIndex = currStaticIndex;
				currStaticIndex = -1;
			}
			else
			{
				if (currPPPOEIndex != -1)
				{
					needDelWANPath = WanPpp[currPPPOEIndex].domain;
				}
			}
		}
		
		toNextPage();
		return;
	}
	
	function toPPPOEPage()
	{
		curPageFlag = "PPPOEWANPage";
		
		if (curOnlineWan == "DHCP" && currDHCPIndex != -1)
		{
			needDelWANPath = WanIp[currDHCPIndex].domain;
			curOnlineWan = "";
		}
		else if (curOnlineWan == "Static" && currStaticIndex != -1)
		{
			needDelWANPath = WanIp[currStaticIndex].domain;
			curOnlineWan = "";
		}
		else if (curOnlineWan == "")
		{
			if (currDHCPIndex != -1)
			{
				needDelWANPath = WanIp[currDHCPIndex].domain;
			}
			else
			{
				if (currStaticIndex != -1)
				{
					needDelWANPath = WanIp[currStaticIndex].domain;
				}
			}
		}
		
		InitShowControlPage();
		ControlPage();
		return;
	}
	
	function toStaticIPPage()
	{
		curPageFlag = "StaticWANPage";
		if (curOnlineWan == "DHCP" && currDHCPIndex != -1)
		{
			currStaticIndex = currDHCPIndex;
			currDHCPIndex = -1;
			curOnlineWan = "";
		}
		else if (curOnlineWan == "PPPOE" && currPPPOEIndex != -1)
		{
			needDelWANPath = WanPpp[currPPPOEIndex].domain;
			curOnlineWan = "";
		}
		else if (curOnlineWan == "")
		{
			if (currDHCPIndex != -1)
			{
				currStaticIndex = currDHCPIndex;
				currDHCPIndex = -1;				
			}
			else 
			{
				if (currPPPOEIndex != -1)
				{
					needDelWANPath = WanPpp[currPPPOEIndex].domain;
				}
			}
		}
		
		InitShowControlPage();
		ControlPage();
		return;
	}
	
	function toEnterPage()
	{
		ChangeJumpPageFlag();
		InitShowControlPage();
		ControlPage();
	}
	
	function toRetryPage()
	{
		InitShowControlPage();
		ControlPage();
	}
	
	function toNextPage()
	{
		if (true != CheckValue())
		{
			return;
		}
		
		Subform();
		ChangePageFlag();
		InitShowControlPage();
		ControlPage();
	}
	
	function ChangeJumpPageFlag()
	{
		switch (curPageFlag)
		{
			case "DHCPWANPage":
				curPageFlag = "WANStatusPage";
				break;
			case "PPPOEWANPage":
				curPageFlag = "WANStatusPage";
				break;
			case "StaticWANPage":
				curPageFlag = "WANStatusPage";
				break;
			case "WANStatusPage":
				curPageFlag = "WIFIPWDPage";
				break;
			case "WIFIPWDPage":
				curPageFlag = "WEBPWDPage";
				break;
			case "WEBPWDPage":
				if (supportIPTVUPPortFlag == 1)
				{
					curPageFlag = "IPTVPortPage";
				}
				else
				{
					curPageFlag = "EndStatusPage";
				}
				break;
			case "IPTVPortPage":
				curPageFlag = "EndStatusPage";
				break;
			case "EndStatusPage":
				break;
			default:
				AlertInfo(PortalguideDes['p0158']);
				break;
		}
		
		return;
	}
	
	function ChangePageFlag()
	{
		switch (curPageFlag)
		{
			case "DHCPWANPage":
				curPageFlag = "WANStatusPage";
				break;
			case "PPPOEWANPage":
				curPageFlag = "WANStatusPage";
				break;
			case "StaticWANPage":
				curPageFlag = "WANStatusPage";
				break;
			case "WANStatusPage":
				curPageFlag = "WIFIPWDPage";
				break;
			case "WIFIPWDPage":
				curPageFlag = "WEBPWDPage";
				if (curSamePWD == 1)
				{
					if (supportIPTVUPPortFlag == 1)
					{
						curPageFlag = "IPTVPortPage";
					}
					else
					{
						curPageFlag = "EndStatusPage";
					}
					
				}				
				break;
			case "WEBPWDPage":
				if (supportIPTVUPPortFlag == 1)
				{
					curPageFlag = "IPTVPortPage";
				}
				else
				{
					curPageFlag = "EndStatusPage";
				}
				break;
			case "IPTVPortPage":
				curPageFlag = "EndStatusPage";
				break;
			case "EndStatusPage":
				break;
			default:
				AlertInfo(PortalguideDes['p0158']);
				break;
		}
		
		return;
	}
	
	function ControlBtn()
	{
		$("#RetryBtnID").css("display","none");
		$("#NextpageBtnID").css("display","none");
		$("#EndBtnID").css("display","none");
		if ((curUPLinkStatus == 0 || curWANStatus == 0 || DNSResult == 0) && curPageFlag == "WANStatusPage")
		{
			$("#RetryBtnID").css("display","block");
		}
		else if (curPageFlag == "WIFIPWDPage" && supportIPTVUPPortFlag != 1)
		{
			$("#EndBtnID").css("display","block");
		}
		else if (curPageFlag == "WEBPWDPage" && supportIPTVUPPortFlag != 1)
		{
			$("#EndBtnID").css("display","block");
		}
		else if (curPageFlag == "IPTVPortPage")
		{
			$("#EndBtnID").css("display","block");
		}
		else if (curPageFlag == "EndStatusPage")
		{
			$("#settingPortalBtn").css("display","none");
		}
		else
		{
			$("#NextpageBtnID").css("display","block");
		}
	
		return;
	}
	
	function InitShowControlTitle()
	{
		$("#portalTitle").css("display","none");
		$("#bbspPwdtitle").css("display","none");
		$("#StaticIPtitle").css("display","none");
		$("#wifiPwdtitle").css("display","none");
		$("#webPwdtitle").css("display","none");
		$("#UPPorttitle").css("display","none");
		$("#Endtitle").css("display","none");
	}
	
	function InitShowControlWanBtn()
	{
		$("#StaticIp").css("display","none");
		$("#BbspPwd").css("display","none");
		$("#AutoNum").css("display","none");
		$("#line1").css("display","none");
		$("#line2").css("display","none");
		$("#line3").css("display","none");
	}
	
	function InitShowControlPage()
	{
		InitShowControlTitle();
		InitShowControlWanBtn();
		$("#portalSkip").css("display","none");
		return;
	}
	
	function ControlWanBtn()
	{
		if (curOnlineWan == "DHCP" && DNSResult == 1)
		{
			$("#BbspPwd").css("display","inline-block");
			$("#line1").css("display","inline-block");
			$("#StaticIp").css("display","inline-block");
			$("#line3").css("display","inline-block");
		}
		else if (curOnlineWan == "PPPOE" && DNSResult == 1)
		{
			$("#AutoNum").css("display","inline-block");
			$("#line2").css("display","inline-block");
			$("#StaticIp").css("display","inline-block");
			$("#line3").css("display","inline-block");
		}
		else if (curOnlineWan == "Static" && DNSResult == 1)
		{
			$("#BbspPwd").css("display","inline-block");
			$("#line1").css("display","inline-block");
			$("#AutoNum").css("display","inline-block");
			$("#line2").css("display","inline-block");
		}
		else
		{
			$("#BbspPwd").css("display","inline-block");
			$("#line1").css("display","inline-block");
			$("#AutoNum").css("display","inline-block");
			$("#line2").css("display","inline-block");
			$("#StaticIp").css("display","inline-block");
			$("#line3").css("display","inline-block");
		}
		
		return;
	}
	
	function adjustIframeHeight()
	{
		getElementById('portalFrameContent').height = portalContent.document.body.scrollHeight + 'px';
	}
	
	function ControlPageShow()
	{
		InitShowControlPage();
		switch (curPageFlag)
		{
			case "PPPOEWANPage":		
				$("#bbspPwdtitle").css("display","block");
				$("#StaticIp").css("display","inline-block");
				$("#AutoNum").css("display","inline-block");
				$("#line3").css("display","inline-block");
				$("#line2").css("display","inline-block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "StaticWANPage":
				$("#StaticIPtitle").css("display","block");
				$("#AutoNum").css("display","inline-block");
				$("#BbspPwd").css("display","inline-block");
				$("#line1").css("display","inline-block");
				$("#line2").css("display","inline-block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "DHCPWANPage":
			case "WANStatusPage":
				$("#portalTitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				ControlWanBtn();
				break;
			case "WIFIPWDPage":
				$("#wifiPwdtitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "WEBPWDPage":
				$("#webPwdtitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "IPTVPortPage":
				$("#UPPorttitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "EndStatusPage":
				$("#Endtitle").css("display","block");
				break;
			default:
				AlertInfo(PortalguideDes['p0158']);
				break;
		}
		
		ControlBtn();
		return;
	}
	
	function ControlPage()
	{	
		switch (curPageFlag)
		{
			case "PPPOEWANPage":
				$("#portalFrameContent").attr("src","PortalBbspPwd.asp");		
				$("#bbspPwdtitle").css("display","block");
				$("#StaticIp").css("display","inline-block");
				$("#AutoNum").css("display","inline-block");
				$("#line3").css("display","inline-block");
				$("#line2").css("display","inline-block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "StaticWANPage":
				$("#portalFrameContent").attr("src","PortalStaticIP.asp");
				$("#StaticIPtitle").css("display","block");
				$("#AutoNum").css("display","inline-block");
				$("#BbspPwd").css("display","inline-block");
				$("#line1").css("display","inline-block");
				$("#line2").css("display","inline-block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "DHCPWANPage":
			case "WANStatusPage":
				$("#portalFrameContent").attr("src","PortalInternetStatus.asp");
				$("#portalTitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				ControlWanBtn();
				break;
			case "WIFIPWDPage":
				$("#portalFrameContent").attr("src","PortalWifi.asp");
				$("#wifiPwdtitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "WEBPWDPage":
				$("#portalFrameContent").attr("src","PortalWebPwd.asp");
				$("#webPwdtitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "IPTVPortPage":
				$("#portalFrameContent").attr("src","PortalUPPort.asp");
				$("#UPPorttitle").css("display","block");
				$("#portalSkip").css("display","inline-block");
				break;
			case "EndStatusPage":
				$("#portalFrameContent").attr("src","PortalFinish.asp");
				$("#Endtitle").css("display","block");
				break;
			default:
				AlertInfo(PortalguideDes['p0158']);
				break;
		}
		
		ControlBtn();
		return;
	}
	
	function DisableBtn(iStatus)
	{
		if (iStatus == "true")
		{
			getElement("RetryBtnID").onclick = null;
			getElement("RetryBtnID").style.background = "#ccc";
		}
		else
		{
			getElement("RetryBtnID").onclick = toRetryPage;
			getElement("RetryBtnID").style.background = "#f3f3f3";		
		}
	}
	
	function DisableWanBtn(iStatus)
	{
		if (iStatus == "true")
		{
			getElement("BbspPwd").onclick = null;
			getElement("BbspPwd").style.color = "#ccc";
			getElement("AutoNum").onclick = null;
			getElement("AutoNum").style.color = "#ccc";
			getElement("StaticIp").onclick = null;
			getElement("StaticIp").style.color = "#ccc";
		}
		else
		{
			getElement("BbspPwd").onclick = toPPPOEPage;
			getElement("BbspPwd").style.color = "#000";
			getElement("AutoNum").onclick = toDHCPPage;
			getElement("AutoNum").style.color = "#000";
			getElement("StaticIp").onclick = toStaticIPPage;
			getElement("StaticIp").style.color = "#000";		
		}
	}
		
	function LoadFrame()
	{	
		InitShowControlPage();
		ControlPage();
		return;
	}
	
	</script>
</head>
<body onload="LoadFrame();" style="background-color: #f2f2f2;" class="bodyclass_8">
	<div class="indexPortalContent">
		<div class="stepPortalTitleCenter">
			<span id="portalTitle" style="" BindText="p0100"></span>
			<span id="bbspPwdtitle" style="display:none;" BindText="p0101"></span>
			<span id="StaticIPtitle" style="display:none;" BindText="p0102"></span>
			<span id="wifiPwdtitle" style="display:none;" BindText="p0103"></span>
			<span id="webPwdtitle" style="display:none;" BindText="p0104"></span>
			<span id="UPPorttitle" style="display:none;" BindText="p0105"></span>
			<span id="Endtitle" style="display:none;" BindText="p0106"></span>
		</div>

		<div id="portalFramepageContent" style="">
			<iframe id="portalFrameContent" name="portalContent" frameborder="0" width="100%" height="450em" marginheight="0" marginwidth="0" src="" scrolling="no" frameborder="0"></iframe>
		</div>
		
		<div id="RetryBtnID" class="operatePortalBtn" style="display:none;border:solid 0.05em rgb(0, 162, 232);" onclick="toRetryPage()">
			<span BindText="p0107"></span>
		</div>

		<div id="NextpageBtnID" class="operatePortalBtn" style="display:none;border:solid 0.05em rgb(0, 162, 232);" onclick="toNextPage()">
			<span BindText="p0108"></span>
		</div>
		
		<div id="EndBtnID" class="operatePortalBtn" style="display:none;border:solid 0.05em rgb(0, 162, 232);" onclick="toNextPage()">
			<span BindText="p0109"></span>
		</div>

		<div style="margin-top:1em;font-family: 微软雅黑;">
			<div id="BbspPwd" style="display:inline-block;text-align:center;font-size:1.5em;cursor:pointer;" onclick="toPPPOEPage()"><span BindText="p0101s"></span></div>
			<div id="line1" style="display:inline-block"><span><img src="/images/internetmidlinetop.jpg" /></span></div>
			<div id="AutoNum" style="display:inline-block;text-align:center;font-size:1.5em;cursor:pointer;" onclick="toDHCPPage()"><span BindText="p0110"></span></div>
			<div id="line2" style="display:inline-block"><span><img src="/images/internetmidlinetop.jpg" /></span></div>
			<div id="StaticIp" style="display:inline-block;text-align:center;font-size:1.5em;cursor:pointer;" onclick="toStaticIPPage()"><span BindText="p0102s"></span></div>
			<div id="line3" style="display:inline-block"><span><img src="/images/internetmidlinetop.jpg" /></span></div>
			<div id="portalSkip" style="display:inline-block;text-align:center;font-size:1.5em;cursor:pointer;" onclick="toEnterPage()"><span BindText="p0111"></span></div>
		</div>
		<div id="bg" style="display:none;"></div>
		<div id="popbox" style="display:none;">
			<div id="alertinfoID1" style="margin-top:5em;">
				<span id="alertinfoID" style="font-size:1.8em;font-family: 微软雅黑;color: #333;margin-top: 2em;"></span>
			</div>
			<div class="popboxBtn" onclick="pupclose()"><span BindText="p0176"></span></div>
		</div>
		<div class="clear"></div>
	</div>
	<script>
	ParseBindTextByTagName(PortalguideDes, "span", 1);
	ParseBindTextByTagName(PortalguideDes, "td", 1);
	ParseBindTextByTagName(PortalguideDes, "div", 1);
	ParseBindTextByTagName(PortalguideDes, "input", 2);
	</script>

</body>
</html>
