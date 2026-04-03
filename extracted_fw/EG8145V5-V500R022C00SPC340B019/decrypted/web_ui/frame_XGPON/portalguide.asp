
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title></title>
	<link href="/Cuscss/<%HW_WEB_GetCusSource(bootstrap.min.css);%>"  media="all" rel="stylesheet" />
	<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
	<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(bootstrap.min.js);%>"></script>
	<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
	<script src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
	<style>
		div.indexPortalContent 
		{
			height:100%;
			width:100%;
			background-size:100% 100%;
			/*background-color:#7bcbff;*/
		}
		.indexPortalTitle
		{
			width:100%;
			color: #fff;
			font-size:2.5em;
			text-align: center;
			/*line-height:1.65em;*/
			font-family:"微软雅黑";
			font-weight: bold;
			margin-left: auto;
			margin-right: auto;
			padding-top: 5em;
		}
		.PortalProductName
		{
			width:100%;
			color: #fff;
			font-size:2.5em;
			/*line-height:1.65em;*/
			font-family:"微软雅黑";
			font-weight: bold;
			margin-left: auto;
			margin-right: auto;
			padding-top: 5em;
		}
		.gatewayPortalImg
		{
			text-align: center;
			margin-top:2em;
		}
		.settingPortalTip
		{
			color: #fff;
			font-size:1.5em;
			font-family:"微软雅黑";
			font-weight: bold;
			text-align: center;
			margin-top: 1em;
		}
		#settingPortalBtn
		{
			background-color: #fff;
			color:rgb(0, 162, 232);
		}
		.operatePortalBtn
		{
			border-radius:0.2em;
			-webkit-border-radius:0.2em;
			font-size:2.5em;
			font-family:"微软雅黑";
			font-weight: bold;
			text-align: center;
			margin-left: auto;
			margin-right: auto;
			line-height: 2.5em;
			margin-top: 1em;
			cursor: pointer;
			min-width: 10em;
			max-width: 40%;
		}
		.operatePortalBtn1
		{
			font-size: 2.5em;
			color:rgb(0, 162, 232);
			font-weight: bold;
		}
		.bodyclass{
		text-align: center;
		font-size: 12px;
		background-color: rgb(0, 162, 232);
	    }
	</style>
	<script type="text/javascript">
	var br0Ip = '<%HW_WEB_GetBr0IPString();%>';
	var httpport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';
	var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
	document.title = ProductName;

	var portalAPType = '<%HW_WEB_GetApMode();%>';
	var IsPortalEnd = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DataModel.PortalGuideCtrl.PortalGuideSupport);%>';
	if (portalAPType == 1 || (portalAPType == 0 && IsPortalEnd == 0))
	{
		window.location='/login.asp'; 
	}

	if (window.location.href.toUpperCase().indexOf(br0Ip) == -1)
	{
		if(window.location.href.toUpperCase().indexOf("HTTPS://") >= 0)
		{
			window.location = 'https://' + br0Ip +'/portalguide.asp';	
		}
		else
		{
			window.location = 'http://' + br0Ip + '/portalguide.asp';
		}
	}

	function LoadFrame()
	{				
		return;
	}
	
	function toNextPage()
	{
			window.location='/portal/PortalChange.asp'; 
	}
	</script>
  </head> 
  <body onload="LoadFrame();" class="bodyclass">
	
	<div class="indexPortalContent">
	<div class = "container" id="container">
		<div class="indexPortalTitle">
			<span style="display:inline-block;" BindText="mainpage045"></span>
			<span style="display:inline-block;"><script>document.write('<div id="PortalProductName">' + ProductName + '</div>');</script></span>
			<span style="display:inline-block;" BindText="mainpage046"></span>
		</div>

		<div class="gatewayPortalImg" style="margin-top:3em">
			<img src="/images/portal_main.jpg" style="width: 50em;display:inline" class="img-responsive"/>
		</div>

		<div class="settingPortalTip">
			<span BindText="mainpage047"></span>
		</div>		
    </div>
		<div id="settingPortalBtn" class="operatePortalBtn" onclick="toNextPage()">
			<span id="NextpageBtnID" BindText="mainpage048"></span>
		</div>
	</div>
	<script>
	ParseBindTextByTagName(framedesinfo, "span", 1);
	ParseBindTextByTagName(framedesinfo, "td", 1);
	ParseBindTextByTagName(framedesinfo, "div", 1);
	ParseBindTextByTagName(framedesinfo, "input", 2);
	</script>
  </body>
</html>
