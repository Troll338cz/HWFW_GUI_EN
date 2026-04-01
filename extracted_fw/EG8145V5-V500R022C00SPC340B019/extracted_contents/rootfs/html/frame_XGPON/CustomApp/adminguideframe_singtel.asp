<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(guide.css);%>" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../images/singtel.ico" />
<link rel="Bookmark" href="../images/singtel.ico" />
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="JavaScript" src="/resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<title></title>
</head>
<script>
var wifiPara = new Object();
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var ontAuthPage = '';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var RedirtIndex = '<%HW_WEB_GetGuideChl();%>';
var UpgradeFlag = 0; 
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var Passwordmode = 0;
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
RedirtIndex = RedirtIndex-48;
var timer = [];
wifiPara.wifiFlag = 0;
document.title = ProductName;
var enableIotSsid = 0;
var showIotSsidFlag = 0;

function setOntAuthPage()
{
	if("chinese" == curLanguage)
	{
		ontAuthPage = '../../html/amp/ontauth/password.asp';
	}
	else
	{
		ontAuthPage = '../../html/amp/ontauth/passwordcommon.asp';
	}
	getElById('icoontauth').name = ontAuthPage;
	getElById('frameContent').src = ontAuthPage;
}

function ifNoWanStep()
{
	if(1 == logo_singtel)
	{
		return true;
	}
	else
	{
		return (0 < RedirtIndex) && (RedirtIndex < 4);
	}
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
	if (ifNoWanStep())
	{
		$("#selectarrow").addClass("guidestep1of2");
		//setStepClass("ontauth", "guidestepintv2");
		setStepClass("cfgdone", "guidestepintv2");
		wifiPara.id = "guidecfgdone";
		wifiPara.name = "../../html/ssmp/bss/guidebssinfo.asp";
	}
	else
	{
		$("#selectarrow").addClass("guidestep1of3");
		//setStepClass("ontauth", "guidestepintv3");
		setStepClass("wancfg", "guidestepintv3");
		setStepClass("cfgdone", "guidestepintv3");
		showStep("wancfg");
		wifiPara.id = "guidewancfg";
		wifiPara.name = "../../html/bbsp/wan/wan.asp?cfgguide=1";
	}

	setDisplay("selectarrow", 1);
	showStep("ontauth");
	showStep("cfgdone");

	setOntAuthPage();
	timer.push(setInterval("adjustParentHeight();", 200));
}

function onchangestep(val)
{
	var id = val.id;
	if (ifNoWanStep())
	{
		$("#selectarrow").removeClass("guidestep1of2");
		$("#selectarrow").removeClass("guidestep2of2");
		if(id == "guideontauth")
		{
			$("#selectarrow").addClass("guidestep1of2");
		}
		else if(id == "guidecfgdone")
		{
			$("#selectarrow").addClass("guidestep2of2");
		}
	}
	else
	{
		$("#selectarrow").removeClass("guidestep1of3");
		$("#selectarrow").removeClass("guidestep2of3");
		$("#selectarrow").removeClass("guidestep3of3");
		if(id == "guideontauth")
		{
			$("#selectarrow").addClass("guidestep1of3");
		}
		else if(id == "guidewancfg")
		{
			$("#selectarrow").addClass("guidestep2of3");
		}
		else if(id == "guidecfgdone")
		{
			$("#selectarrow").addClass("guidestep3of3");
		}
	}
	$("#framepageContent").css("height", "300px");
	document.getElementById("frameContent").src = val.name;
	timer.push(setInterval("adjustParentHeight();", 200));
}

function adjustParentHeight()
{
	var t;
	adjustFrameHeight("framepageContent", "frameContent", 90);
	while((t = timer.pop()) != undefined)
	{
		clearInterval(t);
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
				document.write('<div id="guideframehead"><span style="" BindText="s2012SINGTEL"></span></div>');
			}
			else
			{
				document.write('<div id="guideframehead"><span style="" BindText="s2012"></span></div>');
			}
			</script>
			<div id="guidestepsinfo" class="guidestepinfo">
				<div id="guidestepstitle">
					<span id="spanontauth" class="" style="display:none;" BindText="s2013"></span>
					<span id="spanwancfg"  class="" style="display:none;" BindText="s2014"></span>
					<span id="spancfgdone" class="" style="display:none;" BindText="s2015"></span>
				</div>
				<div id="guidestepsico">
					<img id="icoontauth"   class="" style="display:none;" name="" src="" />
					<img id="icowancfg"    class="" style="display:none;" name="../../html/bbsp/wan/wan.asp?cfgguide=1" src="../images/configwan.jpg" />
					<img id="icocfgdone"   class="" style="display:none;" name="guidebssinfo.asp" src="../images/configdone.jpg" />
				</div>
			</div>
			<script type="text/javascript">
				if (true == logo_singtel)
				{
					document.getElementById("icoontauth").src= "../images/syscfgnowifi.jpg";
				}
				else
				{
					document.getElementById("icoontauth").src= "../images/syscfg.jpg";
				}
			</script>
			<div id="selectarrow" style="display:none;"><img id="arrowimg" src="../images/guidearrow.jpg"></div>
		</div>
	</div>

	<div id="greenline"></div>

	<div id="framepageContent">
		<iframe id="frameContent" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" src=""></iframe>
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
