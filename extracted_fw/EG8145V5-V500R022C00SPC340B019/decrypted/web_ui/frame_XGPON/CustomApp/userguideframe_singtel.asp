<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" media="all" rel="stylesheet" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(guide.css);%>" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../images/singtel.ico" />
<link rel="Bookmark" href="../images/singtel.ico" />
<script type="text/javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="/resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<title></title>
</head>
<script>
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var IsSurportInternetCfg  = "<%HW_WEB_GetFeatureSupport(BBSP_FT_GUIDE_PPPOE_WAN_CFG);%>";
var IsSurportWlanCfg  = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var UpgradeFlag = 0;
var wifiForm = null;
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var UserGuideSteps = getUserGuideSteps();
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
document.title = ProductName;
var enableIotSsid = 0;
var showIotSsidFlag = 0;
function getUserGuideSteps()
{
	return ((IsSurportInternetCfg == "1" && mngttype == "0") ? 0x2 : 0) + (IsSurportWlanCfg == "1" ? 1 : 0);
}

function showStep(step)
{
	//setDisplay("span" + step, flag);
	$("#span" + step).css("display", "inline-block");
	$("#span" + step).css("display", "-moz-inline-stack");
	setDisplay("ico"  + step, 1);
}

function setStepClass(step, css)
{
	$("#span" + step).addClass(css);
	$("#ico"  + step).addClass(css);
}

function loadframe()
{
	switch (UserGuideSteps)
	{
		case 3:
			document.getElementById("frameContent").src = "/html/bbsp/guideinternet/guideinternet.asp";
			$("#selectarrow").addClass("guidestep1of4");
			//setStepClass("internetconfig", "guidestepintv4");
			setStepClass("wlanconfig",     "guidestepintv4");
			setStepClass("sysconfig",      "guidestepintv4");
			setStepClass("configdone",     "guidestepintv4");
			showStep("internetconfig");
			showStep("wlanconfig");
			break;
		case 2:
			document.getElementById("frameContent").src = "/html/bbsp/guideinternet/guideinternet.asp";
			$("#selectarrow").addClass("guidestep1of3");
			//setStepClass("internetconfig", "guidestepintv3");
			setStepClass("sysconfig",      "guidestepintv3");
			setStepClass("configdone",     "guidestepintv3");
			showStep("internetconfig");
			break;
		case 1:
			document.getElementById("frameContent").src = "/html/amp/wlanbasic/guidewificfg.asp";
			$("#selectarrow").addClass("guidestep1of3");
			//setStepClass("wlanconfig", "guidestepintv3");
			setStepClass("sysconfig",  "guidestepintv3");
			setStepClass("configdone", "guidestepintv3");
			showStep("wlanconfig");
			break;
		default:
			document.getElementById("frameContent").src = "/html/ssmp/accoutcfg/guideaccountcfg.asp";
			$("#selectarrow").addClass("guidestep1of2");
			//setStepClass("sysconfig",  "guidestepintv2");
			setStepClass("configdone", "guidestepintv2");
			break;
	}
	setDisplay("selectarrow", 1);
	showStep("sysconfig");
	showStep("configdone");

	wifiForm = new webSubmitForm();
}

function onchangestep(val)
{
	var id = val.id;
	var totalSteps = 2;
	var curStep = 1;
	var defStepOff = 2;
	var wifiStepOff = 0;

	switch (UserGuideSteps)
	{
		case 3:
			totalSteps  = 4;
			wifiStepOff = 0;
			defStepOff  = 2;
			break;
		case 2:
			totalSteps  = 3;
			wifiStepOff = 0;
			defStepOff  = 1;
			break;
		case 1:
			totalSteps  = 3;
			wifiStepOff = -1;
			defStepOff  = 1;
			break;
		default:
			wifiStepOff = -1;
			defStepOff  = 0;
			break;
	}

	if(id == "guideinternet")
	{
		curStep = 1;
	}
	else if(id == "guidewificfg")
	{
		curStep = 2 + wifiStepOff;
	}
	else if(id == "guidesyscfg")
	{
		curStep = 1 + defStepOff;
	}
	else if(id == "guidecfgdone")
	{
		curStep = 2 + defStepOff;
	}
	else
	{
		return;
	}

	resetArrowClass();
	$("#selectarrow").addClass("guidestep" + curStep + "of" + totalSteps);
	document.getElementById("frameContent").src = val.name;
}

function resetArrowClass()
{
	var steps = new Array("1of4", "2of4", "3of4", "4of4",
						  "1of3", "2of3", "3of3",
						  "1of2", "2of2");
	for (var i = 0; i < steps.length; i++)
	{
		$("#selectarrow").removeClass("guidestep" + steps[i]);
	}
}
</script>
<body onload="loadframe();">
	<div id="guideframebody">
		<div id="guideframebg">
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="brandlog_singtel" style="display:none;"></div>');				
			}
			else
			{
				document.write('<div id="brandlog" style="display:none;"></div>');
			}
			</script>
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="ProductName" style="text-align:right; height:41px; line-height:63px; margin-left:630px;">' + ProductName + '</div>');				
			}
			else
			{
				document.write('<div id="ProductName">' + ProductName + '</div>');
			}
			</script>
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="guideframehead"><span BindText="s2012SINGTEL"></span></div>');
			}
			else
			{
				document.write('<div id="guideframehead"><span BindText="s2012"></span></div>');
			}
			</script>
			<div id="guidestepsinfo" class="guidestepinfo">
				<div id="guidestepstitle">
					<span id="spaninternetconfig" class="" style="display:none;" BindText="s2016"></span>
					<span id="spanwlanconfig"     class="" style="display:none;" BindText="s2017"></span>
					<span id="spansysconfig"      class="" style="display:none;" BindText="s2018"></span>
					<span id="spanconfigdone"     class="" style="display:none;" BindText="s2015"></span>
				</div>
				<div id="guidestepsico">
					<img id="icointernetconfig"   class="" style="display:none;" name="../../html/bbsp/guideinternet/guideinternet.asp" src="../images/configinternet.jpg" />
					<img id="icowlanconfig"       class="" style="display:none;" name="../../html/amp/wlanbasic/guidewificfg.asp" src="../images/configwlan.jpg" />
					<img id="icosysconfig"        class="" style="display:none;" name="guidesystemcfg.asp" src="" />
					<img id="icoconfigdone"       class="" style="display:none;" name="userguidecfgdone.asp" src="../images/configdone.jpg" />
				</div>
				<script type="text/javascript">
					if (true == logo_singtel)
					{
						document.getElementById("icosysconfig").src= "../images/syscfgnowifi.jpg";
					}
					else
					{
						document.getElementById("icosysconfig").src= "../images/syscfg.jpg";
					}
				</script>
			</div>
			<div id="selectarrow" style="display:none;">
				<img id="arrowimg" src="../images/guidearrow.jpg">
			</div>
		</div>
	</div>
	<div id="greenline"></div>
	<div id="framepageContent">
		<iframe id="frameContent" width="100%" frameborder="0" height="100%" marginheight="0" marginwidth="0" src=""></iframe>
	</div>
	<div style="display:none;">
		<iframe frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no" src="/refresh.asp"></iframe>
	</div>
	<script>
		ParseBindTextByTagName(CfgguideLgeDes, "span", 1, mngttype, logo_singtel);
		if (parseInt(mngttype, 10) != 1)
		{						
			if(parseInt(logo_singtel, 10) == 1)
			{
			    if(TypeWord_com == "COMMON")
				{
					$("#brandlog_singtel").css("background-image", "url()");
				}
			    $("#brandlog_singtel").css("display", "block");
			}
			else
			{
			    $("#brandlog").css("display", "block");
			}				
		}
	</script>
</body>
</html>
