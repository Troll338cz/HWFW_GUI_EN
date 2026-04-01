<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>"  media="all" rel="stylesheet" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(guide.css);%>" rel="stylesheet" type="text/css" />
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="JavaScript" src="/resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<title></title>
</head>
<script>
var wifiPara = new Object();
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var ontAuthPage = '';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var IsSurportWlanCfg  = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var RedirtIndex = '<%HW_WEB_GetGuideChl();%>';
var UpgradeFlag = 0; 
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var IsSupportpon2lan = '<%HW_WEB_GetFeatureSupport(FT_PON_UPPORT_CONFIG);%>'; 
var CurrentUpMode = '<%HW_WEB_GetUpMode();%>';
var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var telmexwififeature = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var DAUMLOGO = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_Web.X_WebLogo);%>';
var DAUMFEATURE = "<%HW_WEB_GetFeatureSupport(FT_PRODUCT_DAUM);%>";
var Passwordmode = 0;
var selectrepwlan = "";
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var TedataGuide = "<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_TEDATAGUIDE);%>";
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DBAA1= "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var isTruergT3 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRUERGT3);%>';
var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";
var modifyWebcodeLogout = '<%HW_WEB_GetFeatureSupport(FT_MODIFY_WEBCODE_GUIDE_LOGOUT);%>';
var UserName = '<%HW_WEB_GetCurUserName();%>';
var modifyWebCode = '0'
var securityAccessWeb = '<%HW_WEB_GetFeatureSupport(FT_SECURITY_ACCESS_WEB);%>';
var enableIotSsid = 0;
var showIotSsidFlag = 0;

function WebUserInfo(domain, ModifyPasswordFlag)
{
	this.domain = domain;
	this.ModifyPasswordFlag = ModifyPasswordFlag;
}
var userInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.{i}, ModifyPasswordFlag, WebUserInfo);%>;
var isForceModifyPwd = (securityAccessWeb == "1") && (userInfo[1].ModifyPasswordFlag == 0);

var isDbaa1NormalAdmin = false;
if ((DBAA1 == "1") && (curUserType == '0')) {
    isDbaa1NormalAdmin = true;
}
RedirtIndex = RedirtIndex-48;
var timer = [];
wifiPara.wifiFlag = 0;
document.title = ProductName;

if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI'))
{
    document.write('<link rel="shortcut icon" href="/images/Dzain.ico" />');
    document.write('<link rel="Bookmark" href="/images/Dzain.ico" />');
}

if ('DVODACOM2WIFI' == CfgMode.toUpperCase())
{
    document.write('<link rel="shortcut icon" href="/images/Dvodacom.ico" />');
    document.write('<link rel="Bookmark" href="/images/Dvodacom.ico" />');
}

if (DAUMFEATURE == 1) {
	document.write('<link rel="shortcut icon" href="/images/hwlogo.ico" />');
	document.write('<link rel="Bookmark" href="/images/hwlogo.ico" />');
}

function SupportTtnet()
{
	return (CfgMode.toUpperCase() == "DTTNET2WIFI" || CfgMode.toUpperCase() == "TTNET2");
}

function setOntAuthPage()
{
	var eleId;
	if (TedataGuide == 1) {
		eleId = 'icowancfg';
		ontAuthPage = '../../html/bbsp/guideinternet/guideinternet.asp';
	} else if (ProductType == '2') {
        if (isDbaa1NormalAdmin) {
            eleId = 'icowlanconfig';
            ontAuthPage = '../../html/amp/wlanbasic/guidewificfg.asp';
        } else if (SupportTtnet()) {
            eleId = 'icowancfg';
            ontAuthPage = '../../html/bbsp/guideinternet/guideinternet.asp';
        } else if (CfgMode.toUpperCase() == "DETHMAXIS") {
			eleId = 'icowancfg';
			ontAuthPage = '../../html/ssmp/vlanprofileswitch/vlanprofileswitch.asp?cfgguide=1';
		} else {
            eleId = 'icowancfg';
            ontAuthPage = '../../html/bbsp/wan/wan.asp?cfgguide=1';
        }

		if (isForceModifyPwd) {
			eleId = 'icosysconfig';
			ontAuthPage = '../../html/ssmp/accoutcfg/guideaccountcfg.asp';
		}
    } else {
        eleId = 'icoontauth';
        ontAuthPage = '../../html/amp/ontauth/passwordcommon.asp';
    }

    if((curLanguage == "chinese") || (CfgMode.toUpperCase() == "BLSCHOOL2")) {
        ontAuthPage = '../../html/amp/ontauth/password.asp';
    }

    getElById(eleId).name = ontAuthPage;
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
function apcmodefun()
{
	if(curChangeMode == 2 || curChangeMode == 3)
	{
		var modeChangePage = "../../html/ssmp/modechange/modechange.asp?cfgguide=1";
		var wlanneighborAPPage = "../../html/amp/wlaninfo/wlanneighborAP.asp";
		var resultPage = (CfgMode == "VDFPTAP" || CfgMode == "TRUEAP")?wlanneighborAPPage:modeChangePage;
		$("#spanwancfg").css("display", "none");
		$("#icowancfg").css("display", "none");
		$("#icocmode").css("display", "inline-block");
		$("#spancmodecfg").css("display", "inline-block");
		
		showStep("cmodecfg");
		$("#selectarrow").addClass("guidestep1of2");
		setStepClass("cfgdone", "guidestepintv2");
		getElById('icocmode').name = resultPage;
		getElById('frameContent').src = resultPage;
		wifiPara.id = "guidecmodecfg";
		wifiPara.name = resultPage;
	}
	else if(curChangeMode == 1)
	{
		$("#spanwancfg").css("display", "inline-block");
		$("#icowancfg").css("display", "inline-block");
		$("#icocfgdone").css("display", "inline-block");
		$("#spancfgdone").css("display", "inline-block");
		$("#icocmode").css("display", "inline-block");
		$("#spancmodecfg").css("display", "inline-block");
		
		showStep("cmodecfg");
		$("#selectarrow").addClass("guidertstep");
		$("#icocmode").addClass("guideicocmode");
		$("#spancmodecfg").addClass("guidecmodestep");
		$("#icocfgdone").addClass("guidestepintv2rt");
		$("#spancfgdone").addClass("guidestepintv2rt");
		$("#icowancfg").addClass("guideicowancfg");
		$("#spanwancfg").addClass("guidewanstep");

		setStepClass("cfgdone", "guidestepintv2");
		getElById('icocmode').name = "../../html/ssmp/modechange/modechange.asp?cfgguide=1";
		getElById('frameContent').src = "../../html/ssmp/modechange/modechange.asp?cfgguide=1";
		wifiPara.id = "guidecmodecfg";
		wifiPara.name = "../../html/ssmp/modechange/modechange.asp?cfgguide=1";
	}
}
var wifiForm = null;
function loadframe()
{
	if(1 == smartlanfeature || (3 == CurrentUpMode && 1 == IsSupportpon2lan))
	{
		if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
		{
			apcmodefun();
		}
		else
		{
			showStep("wancfg");
			$("#selectarrow").addClass("guidestep1of2");
			setStepClass("cfgdone", "guidestepintv2");
			getElById('icowancfg').name = "../../html/bbsp/wan/wan.asp?cfgguide=1";
			getElById('frameContent').src = "../../html/bbsp/wan/wan.asp?cfgguide=1";
			wifiPara.id = "guidewancfg";
			wifiPara.name = "../../html/bbsp/wan/wan.asp?cfgguide=1";
		}
	}
	else
	{
		if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
		{
			apcmodefun();
		}
		else
		{
			if (ifNoWanStep())
			{
				$("#selectarrow").addClass("guidestep1of2");
				//setStepClass("ontauth", "guidestepintv2");
				setStepClass("cfgdone", "guidestepintv2");
				wifiPara.id = "guidecfgdone";
				wifiPara.name = "../../html/ssmp/bss/guidebssinfo.asp";
			} else {
                if ((ProductType == '2') || (TedataGuide == 1)) {
                	if (isDbaa1NormalAdmin) {
                        $("#selectarrow").addClass("guidestep1of3");
                        setStepClass("sysconfig", "guidestepintv3");
                        setStepClass("cfgdone", "guidestepintv3");
                    } else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
                        $("#selectarrow").addClass("guidestep1of6");
                        setStepClass("pppoeconfig", "guidestepintv6");
                        setStepClass("voiceconfig", "guidestepintv6");
                        setStepClass("wlanconfig", "guidestepintv6");
                        setStepClass("sysconfig", "guidestepintv6");
                        setStepClass("cfgdone", "guidestepintv6");

                        showStep("pppoeconfig");
                        showStep("voiceconfig");
                    } else if (IsTedata == 1) {
                        if (IsSurportWlanCfg == 1) {
                            $("#selectarrow").addClass("guidestep1of3");
                            setStepClass("wlanconfig", "guidestepintv3");
                            setStepClass("cfgdone", "guidestepintv3");
                        } else {
                            $("#selectarrow").addClass("guidestep1of2");
                            setStepClass("cfgdone", "guidestepintv2");
                        }
                    } else if (isForceModifyPwd) {
                        $("#selectarrow").addClass("guidestep1of4");
                        setStepClass("wlanconfig", "guidestepintv4");
                        setStepClass("wancfg", "guidestepintv4");
                        setStepClass("cfgdone", "guidestepintv4");
                    } else {
                        $("#selectarrow").addClass("guidestep1of4");
                        setStepClass("wlanconfig", "guidestepintv4");
                        setStepClass("sysconfig", "guidestepintv4");
                        setStepClass("cfgdone", "guidestepintv4");
                    }
                    if (IsSurportWlanCfg == 1) {
                        showStep("wlanconfig");
                    }
                    showStep("sysconfig");
                    showStep("cfgdone");
                } else {
                    $("#selectarrow").addClass("guidestep1of3");
                    //setStepClass("ontauth", "guidestepintv3");
                    setStepClass("wancfg", "guidestepintv3");
                    setStepClass("cfgdone", "guidestepintv3");
                    showStep("wancfg");
                }
				wifiPara.id = "guidewancfg";
				wifiPara.name = "../../html/bbsp/wan/wan.asp?cfgguide=1";
			}
			
			showStep("ontauth");
			setOntAuthPage();
		}
	}
	
	setDisplay("selectarrow", 1);
    if ((ProductType == '2') || (TedataGuide == 1)) {
		if ((isDbaa1NormalAdmin == false) || isForceModifyPwd) {
            showStep("wancfg");
        }
        setOntAuthPage();
        wifiForm = new webSubmitForm();
    } else {
        showStep("cfgdone");
        timer.push(setInterval("adjustParentHeight();", 200));
		wifiForm = new webSubmitForm();
    }

    if (CfgMode.toUpperCase() == 'BRAZCLARO') {
        $("#guideframebody").css("background-color", "rgb(218,41,28)");
        $("#guideframebody").css("background-image", "url()");
    }
}

function onchangestep(val)
{
	var id = val.id;
	if ((id == "guidecfgdone") && (modifyWebCode == '1') && (modifyWebcodeLogout == '1')) {
        setDisplay("guideframebody", 0);
        setDisplay("selectarrow", 0);
        setDisplay("greenline", 0);
        setDisplay("framepageContent", 0);
    }

	if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
	{
		if(curChangeMode == 2 || curChangeMode == 3)
		{
			if(id =="guidecmodecfg")
			{
				$("#selectarrow").addClass("guidestep1of2");
				$("#selectarrow").removeClass("guidestep2of2");
			}
			
			if(id == "guidecfgdone")
			{
				$("#selectarrow").addClass("guidestep2of2");
			}
		}
		else
		{
			if(id =="guidecmodecfg")
			{
				$("#selectarrow").addClass("guidertstep");
			}
			if(id == "guidewancfg")
			{
				$("#selectarrow").removeClass("guidertstep");
				$("#selectarrow").addClass("guidestep2of3");
				$("#selectarrow").removeClass("guidestep3of3rt");
			}
			
			if(id == "guidecfgdone")
			{
				$("#selectarrow").addClass("guidestep3of3rt");
			}
		}
	}
	else if(1 == smartlanfeature || (3 == CurrentUpMode && 1 == IsSupportpon2lan))
	{		
		$("#selectarrow").removeClass("guidestep1of2");
		$("#selectarrow").removeClass("guidestep2of2");
		if(id == "guidewancfg")
		{
			$("#selectarrow").addClass("guidestep1of2");
		}
		else if(id == "guidecfgdone")
		{
			val.name ="/html/ssmp/cfgguide/userguidecfgdone.asp";
			$("#selectarrow").addClass("guidestep2of2");
		}
	}
	else
	{
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
		} else {
            if ((ProductType == '2') || (TedataGuide == 1)) {
                if (isDbaa1NormalAdmin) {
                    $("#selectarrow").removeClass("guidestep1of3");
                    $("#selectarrow").removeClass("guidestep2of3");
                    $("#selectarrow").removeClass("guidestep3of3");

                    if (id == "guidewlanconfig") {
                        $("#selectarrow").addClass("guidestep1of3");
                    } else if(id == "guidesyscfg") {
                        $("#selectarrow").addClass("guidestep2of3");
                    } else if(id == "guidecfgdone") {
                        $("#selectarrow").addClass("guidestep3of3");
                    }
                } else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
                    $("#selectarrow").removeClass("guidestep1of6");
                    $("#selectarrow").removeClass("guidestep2of6");
                    $("#selectarrow").removeClass("guidestep3of6");
                    $("#selectarrow").removeClass("guidestep4of6");
                    $("#selectarrow").removeClass("guidestep5of6");
                    $("#selectarrow").removeClass("guidestep6of6");

                    if (id == "guidewancfg") {
                        $("#selectarrow").addClass("guidestep1of6");
                    } else if(id == "guidepppoeconfig") {
                        $("#selectarrow").addClass("guidestep2of6");
                    } else if(id == "guidevoiceconfig") {
                        $("#selectarrow").addClass("guidestep3of6");
                    } else if(id == "guidewlanconfig") {
                        $("#selectarrow").addClass("guidestep4of6");
                    } else if(id == "guidesyscfg") {
                        $("#selectarrow").addClass("guidestep5of6");
                    } else if(id == "guidecfgdone") {
                        $("#selectarrow").addClass("guidestep6of6");
                    }
                } else if (IsTedata == 1) {
                    if (IsSurportWlanCfg == 1) {
                        if (id == "guideinternet") {
                            $("#selectarrow").removeClass("guidestep2of3");
                            $("#selectarrow").addClass("guidestep1of3");
                        } else if(id == "guidewlanconfig") {
                            $("#selectarrow").addClass("guidestep2of3");
                        } else if (id == "guidesyscfg") {
                            if ($("#selectarrow").hasClass('guidestep3of3')) {
                                $("#selectarrow").removeClass("guidestep3of3");
                                $("#selectarrow").addClass("guidestep2of3");
                            } else {
                                $("#selectarrow").addClass("guidestep3of3");
                            }
                        } else if (id == "guidecfgdone") {
                            $("#selectarrow").addClass("guidestep3of3");
                        }
                    } else {
                        $("#selectarrow").removeClass("guidestep1of2");
                        $("#selectarrow").removeClass("guidestep2of2");
                        if (id == "guideinternet") {
                            $("#selectarrow").addClass("guidestep1of2");
                        } else if(id == "guidecfgdone") {
                            $("#selectarrow").addClass("guidestep2of2");
                        }
                    }
                } else {
                    $("#selectarrow").removeClass("guidestep1of4");
                    $("#selectarrow").removeClass("guidestep2of4");
                    $("#selectarrow").removeClass("guidestep3of4");
                    $("#selectarrow").removeClass("guidestep4of4");

                    if ((id == "guidewancfg") || (TedataGuide == 1 && id == "guideinternet")) {
						if (isForceModifyPwd) {
							$("#selectarrow").addClass("guidestep3of4");
						} else {
							$("#selectarrow").addClass("guidestep1of4");
						}
                    } else if(id == "guidewlanconfig") {
                        $("#selectarrow").addClass("guidestep2of4");
                    } else if(id == "guidesyscfg") {
						if (isForceModifyPwd) {
							$("#selectarrow").addClass("guidestep1of4");
						} else {
							$("#selectarrow").addClass("guidestep3of4");
						}
                    } else if(id == "guidecfgdone") {
                        $("#selectarrow").addClass("guidestep4of4");
                    }  else if ((id == "guideinternet") && (SupportTtnet())) {
                        $("#selectarrow").addClass("guidestep1of4");
                    } 
                }
            } else {
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
        }
    }
	$("#framepageContent").css("height", "300px");
	if(('1' == smartlanfeature || (3 == CurrentUpMode && 1 == IsSupportpon2lan))&& val.name.indexOf("guidebssinfo.asp") != -1){
		val.name = "/html/ssmp/cfgguide/userguidecfgdone.asp";
	}
	
	document.getElementById("frameContent").src = val.name;
	timer.push(setInterval("adjustParentHeight();", 200));
}

function adjustParentHeight()
{
	adjustFrameHeight("framepageContent", "frameContent", 90, 200);
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
			else if (telmexwififeature == 1)
			{
				document.write('<div id="brandlog_telmex" style="display:none;"></div>');
			}
			else if ('TELECENTRO' == CfgMode.toUpperCase())
			{
				document.write('<div id="brandlog_telecentro" style="display:none;"></div>');
			}
			else if ('PLDT2' == CfgMode.toUpperCase() || 'PLDT' == CfgMode.toUpperCase())
			{
				document.write('<div id="brandlog_pldt" style="display:none;"></div>');
			}
			else if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
				document.write('<div id="brandlog_antel" style="display:none;"></div>');
            } else if (('OMANONT' == CfgMode.toUpperCase()) || 
                       ('OMANONT2' == CfgMode.toUpperCase())) {
                    document.write('<div id="brandlog_oman" style="display:none;"></div>');
			}
			else if ('MAROCTELECOM' == CfgMode.toUpperCase())
			{
				document.write('<div id="brandlog_maroctelecom" style="display:none;"></div>');
			} else if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
				document.write('<div id="brandlog_DZAIN2" style="display:none;"></div>');
			}
			else if ('ORANGEMT' == CfgMode.toUpperCase())
			{
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_orangemt" src="../../images/hwlogo_orangemt.gif" width="48px"></img>' + '<div  id="ProductNameOrg">' + ProductName + '</div>'+'</div>');
			}
			else if (CfgMode.toUpperCase() == 'PARAGUAYPSN')
			{
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<div style="margin-left:50px"><img id="brandlog_paraguaypsn" src="../../images/hwlogo_paraguaypsn.gif" width="92px"></img></div>' + '<div  id="ProductNamePar">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'MYTIME') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 12px"></div>'+'<div style="margin-left:50px"><img id="brandlog_mytime" src="../../images/hwlogo_mytime.gif" width="92px"></img></div>' + '<div  id="ProductNamePar" style="margin-top: -37px">' + ProductName + '</div>'+'</div>');
			} else if (isTruergT3 == 1) {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_truerg" src="../../images/hwlogo_truergpwdsn.gif" width="48px"></img>' + '<div  id="ProductNameTruergPwdsn">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<img id="brandlog_dethmaxis" src="../../images/hwlogo_dethmaxis.gif" width="65px"></img>' + '<div  id="ProductNameDethmaxis">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<div style="margin-left:50px"><img id="brandlog_cypruscyta" src="../../images/hwlogo_cyta.jpg" width="92px"></img></div>' + '<div  id="ProductNameCypruscyta" style="margin-top: -40px">' + ProductName + '</div>'+'</div>');
			} 
			else if((DAUMFEATURE == 1) && (DAUMLOGO == 1))
			{
				document.write('<div id="brandlog_daum_iprimus" style="display:none;"></div>');
			}
			else if((DAUMFEATURE == 1) && (DAUMLOGO == 2))
			{
				document.write('<div id="brandlog_daum_dodo" style="display:none;"></div>');
			}
			else if((DAUMFEATURE == 1) && (DAUMLOGO == 3))
			{
				document.write('<div id="brandlog_daum_commander" style="display:none;"></div>');
			}
			else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase())
			{
				document.write('<div id="brandlog_dnztelecom" style="display:none;"></div>');
			}
			else if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
				document.write('<div id="brandlog_DVODACOM2WIFI" style="display:none;"></div>');
			} else if (CfgMode.toUpperCase() == 'CLARODR') {
				document.write('<div id="brandlog_clarodr" style="display:none;"></div>');
			} else if (CfgMode.toUpperCase() == "BRAZCLARO") {
			    document.write('<div id="brandlog_claro" style="display:none;"></div>');
			} else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
				document.write('<div id="brandlog_deskctap" style="display:none;"></div>');
			}  if (DBAA1 == '1') {
				document.write('<div id="brandlog_dbaa1" style="display:none;"></div>');
			} else if (TedataGuide == 1) {
                            if (TypeWord_com == "ACUD") {
                                document.write('<div id="brandlog" style="display:none;"></div>');
                                $("#brandlog").css("background", "url(../images/tedate_acud.jpg) no-repeat center");
                                $("#brandlog").css("width", "60PX");
                                $("#brandlog").css("marginRight", "10PX");
                            } else {
                                document.write('<div id="brandlog" style="display:none;"></div>');
                                $("#brandlog").css("background", "url(../images/yptlogo.jpg) no-repeat center");
                                $("#brandlog").css("width", "60px");
                            }
            } else if (htFlag == 1) {
                document.write('<div id="brandlog_ht" style="display:none;"></div>');
            } else if (oteFlag == 1) {
                document.write('<div id="brandlog_ote" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == "COMMONRMHW") {
                document.write('<div id="brandlog_commonrmhw" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'AWASR') {
                document.write('<div id="brandlog_awasr" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'AOUNITEL') {
                document.write('<div id="brandlog_aounitel" style="display:none;"></div>');
            } else {
                document.write('<div id="brandlog" style="display:none;"></div>');
            }
			</script>	
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="ProductName" style="text-align:right; margin-left:630px;">' + ProductName + '</div>');				
			}
			else if ((CfgMode.toUpperCase() != 'ORANGEMT') && (CfgMode.toUpperCase() != 'PARAGUAYPSN') && (CfgMode.toUpperCase() != 'MYTIME')
				&& (isTruergT3 != 1) && (CfgMode.toUpperCase() != 'DETHMAXIS') && (CfgMode.toUpperCase() != 'CYPRUSCYTA'))
			{
				if ('DVODACOM2WIFI' == CfgMode.toUpperCase()) {
					document.write('<div id="ProductName" style="float:left;">' + ProductName + '</div>');
					document.write('<div style="clear:both;">' + '</div>');
				} else if (CfgMode.toUpperCase() == 'AOUNITEL') {
					document.write('<div id="ProductName"></div>');
				} else if (DBAA1 == '1') {
					document.write('<div id="ProductName">' + framedesinfo["frame024"] + '</div>');
				} else {
					document.write('<div id="ProductName">' + ProductName + '</div>');
				}				
			}
			</script>
			<script>
			if(true == logo_singtel)
			{
				if(TypeWord_com == "COMMON")
				{
					document.write('<div id="guideframehead"><span style="" BindText="s2012SINGTELHS"></span></div>');
				}
				else
				{
					document.write('<div id="guideframehead"><span style="" BindText="s2012SINGTEL"></span></div>');
				}
			}
			else
			{
				if(smartlanfeature == 1 || (3 == CurrentUpMode && 1 == IsSupportpon2lan))
				{	
					if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
					{
						document.write('<div id="guideframehead"><span style="" BindText="s2012aplan"></span></div>');
					}
					else if(1 == IsSmartDev)
					{
						document.write('<div id="guideframehead"><span style="" BindText="s2012lan"></span></div>');
					}
					else{
						document.write('<div id="guideframehead"><span style="" BindText="s2012aplan"></span></div>');
					}
				}
				else
				{					
					if(("" != curChangeMode && 0 != curChangeMode) || 1 == GhnDevFlag)
					{
						document.write('<div id="guideframehead"><span style="" BindText="s2012aplan"></span></div>');
					}
					else
					{
                        if ((ProductType == '2') || (TedataGuide == 1))
                        {
							if ('DVODACOM2WIFI' == CfgMode.toUpperCase()) {
								document.write('<div id="guideframehead"  style="margin-top:76px;"><span BindText="s2012_xd"></span></div>');
							} else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
								document.write('<div id="guideframehead"><span style="" BindText="s2012_dethmaxis"></span></div>');
                        	} else if (CfgMode.toUpperCase() == 'DBAA1') {
								document.write('<div id="guideframehead"><span style="" BindText="s2012_dbaa1"></span></div>');
                            } else if (CfgMode.toUpperCase() == 'DCORIOLIS2WIFI') {
                                document.write('<div id="guideframehead"><span style="" BindText="s2012_coriolis"></span></div>');
                            } else {
								document.write('<div id="guideframehead"><span style="" BindText="s2012_xd"></span></div>');
							}								
                        }
                        else
                        {
							if (isTruergT3 == 1) { 
                                document.write('<div id="guideframehead"><span style="" BindText="s2012_truerg"></span></div>');
                            } else if (CfgMode.toUpperCase() == 'AOUNITEL') {
								document.write('<div id="guideframehead"><span style="" BindText="s2012AOUNITEL"></span></div>');
                            } else {
								document.write('<div id="guideframehead"><span style="" BindText="s2012"></span></div>');
                            }
                        }
					}
				}

				if (isTruergT3 == 1) {
                    $("#guideframehead").css('margin-top', '69px');
                }

			}
			</script>
			<div id="guidestepsinfo" class="guidestepinfo">
				<div id="guidestepstitle">
                <script>
                    if (SupportTtnet()) {
                        document.write('<span id="spanwancfg" class="" style="display:none;" BindText="s2016"></span>');
                        document.write('<span id="spanwlanconfig" class="" style="display:none;" BindText="s2017"></span>');
                        document.write('<span id="spansysconfig" class="" style="display:none;" BindText="s2018"></span>');
                        document.write('<span id="spancfgdone" class="" style="display:none;" BindText="s2015"></span>');
                    } else if ((ProductType == '2') || (TedataGuide == 1)) {
                        if (CfgMode.toUpperCase() == "DETHMAXIS") {
							document.write('<span id="spanwancfg" class="" style="display:none;" BindText="s2014_maxis"></span>');
							document.write('<span id="spanpppoeconfig" class="" style="display:none;" BindText="s2022"></span>');
                            document.write('<span id="spanvoiceconfig" class="" style="display:none;" BindText="s2023"></span>');
                        } else if (isForceModifyPwd) {
							document.write('<span id="spansysconfig" class="" style="display:none;" BindText="s2018"></span>');
                        } else {
							document.write('<span id="spanwancfg" class="" style="display:none;" BindText="s2014"></span>');
						}
                        document.write('<span id="spanwlanconfig" class="" style="display:none;" BindText="s2017"></span>');
                        if (IsTedata == 1) {
                            document.write('');
                        } else if (isForceModifyPwd) {
                            document.write('<span id="spanwancfg" class="" style="display:none;" BindText="s2014"></span>');
                        } else {
							document.write('<span id="spansysconfig" class="" style="display:none;" BindText="s2018"></span>');
						}
                        document.write('<span id="spancfgdone" class="" style="display:none;" BindText="s2015"></span>');
                    }
                    else
                    {
                        document.write('<span id="spanontauth" class="" style="display:none;" BindText="s2013"></span>');
                        document.write('<span id="spancmodecfg" class="" style="display:none;" BindText="s2038"></span>');
                        document.write('<span id="spanwancfg" class="" style="display:none;" BindText="s2014"></span>');
                        document.write('<span id="spancfgdone" class="" style="display:none;" BindText="s2015"></span>');
                    }
                </script>
				</div>
				<div id="guidestepsico">
                    <script>
                        if ((ProductType == '2') || (TedataGuide == 1))
                        {
							if (isForceModifyPwd) {
								document.write('<img id="icosysconfig" class="" style="display:none;" name="guidesystemcfg.asp" src="../images/syscfg.jpg" />');
							} else {
								document.write('<img id="icowancfg" class="" style="display:none;" name="/html/bbsp/wan/wan.asp?cfgguide=1" src="../images/configwan.jpg" />');
							}
                            
							if (CfgMode.toUpperCase() == 'DETHMAXIS') {
                                document.write('<img id="icopppoeconfig" class="" style="display:none;" name="/html/bbsp/guideinternet/guideinternet.asp" src="../images/configinternet.jpg" />');
                                document.write('<img id="icovoiceconfig" class="" style="display:none;" name="/html/voip/voipinterface/guidevoice.asp" src="../images/configvoice.jpg" />');
                            }

							document.write('<img id="icowlanconfig" class="" style="display:none;" name="../../html/amp/wlanbasic/guidewificfg.asp" src="../images/configwlan.jpg" />');

                            if (IsTedata == 1) {
                                document.write('');
                            } else {
								if (isForceModifyPwd) {
									document.write('<img id="icowancfg" class="" style="display:none;" name="/html/bbsp/wan/wan.asp?cfgguide=1" src="../images/configwan.jpg" />');
								} else {
									document.write('<img id="icosysconfig" class="" style="display:none;" name="guidesystemcfg.asp" src="../images/syscfg.jpg" />');
								}
                            }

                            document.write('<img id="icocfgdone" class="" style="display:none;" name="guidebssinfo.asp" src="../images/configdone.jpg" />');
                        }
                        else
                        {
                            document.write('<img id="icoontauth" class="" style="display:none;" name="" src="" />');
                            if (CfgMode.toUpperCase() == 'AOUNITEL') {
								document.write('<img id="icocmode" class="" style="display:none;" name="../../html/ssmp/modechange/modechange.asp?cfgguide=1" src="../images/cmode_black.png">');
								document.write('<img id="icowancfg" class="" style="display:none;" name="../../html/bbsp/wan/wan.asp?cfgguide=1" src="../images/configwan_black.jpg" />');
								document.write('<img id="icocfgdone" class="" style="display:none;" name="guidebssinfo.asp" src="../images/configdone_black.jpg" />');
							} else {
								document.write('<img id="icocmode" class="" style="display:none;" name="../../html/ssmp/modechange/modechange.asp?cfgguide=1" src="../images/cmode.png">');
								document.write('<img id="icowancfg" class="" style="display:none;" name="../../html/bbsp/wan/wan.asp?cfgguide=1" src="../images/configwan.jpg" />');
								document.write('<img id="icocfgdone" class="" style="display:none;" name="guidebssinfo.asp" src="../images/configdone.jpg" />');
							}
                        }
                    </script>
				</div>
			</div>
			<script type="text/javascript">
                if ((ProductType != '2') && (TedataGuide != 1))
                {
                    if (true == logo_singtel)
                    {
                        if (CfgMode.toUpperCase() == 'AOUNITEL') {
							document.getElementById("icoontauth").src= "../images/syscfgnowifi_black.jpg";
						} else {
							document.getElementById("icoontauth").src= "../images/syscfgnowifi.jpg";
						}
                    }
                    else
                    {
                        if (CfgMode.toUpperCase() == 'AOUNITEL') {
							document.getElementById("icoontauth").src= "../images/syscfg_black.jpg";0
						} else {
							document.getElementById("icoontauth").src= "../images/syscfg.jpg";
						}
                    }
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
			    if ('TELECENTRO' == CfgMode.toUpperCase())
				{
					$("#brandlog_telecentro").css("display", "block");
				} else if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
					$("#brandlog_DZAIN2").css("display", "block");
				}
				else if ('PLDT2' == CfgMode.toUpperCase() || 'PLDT' == CfgMode.toUpperCase())
				{
					$("#brandlog_pldt").css("display", "block");
				}
				else if ((CfgMode.toUpperCase() == 'ANTEL2') || (CfgMode.toUpperCase() == 'ANTEL')) {
					$("#brandlog_antel").css("display", "block");
					$("#brandlog_antel").css("width", "92PX");
					$("#ProductName").css("line-height", "60PX");
                } else if (('OMANONT' == CfgMode.toUpperCase()) || 
                           ('OMANONT2' == CfgMode.toUpperCase())) {
                        $("#brandlog_oman").css("display", "block");
				}
				else if ('MAROCTELECOM' == CfgMode.toUpperCase())
				{
					$("#brandlog_maroctelecom").css("display", "block");
				}
				else if ('ORANGEMT' == CfgMode.toUpperCase())
				{
					$("#brandlog_orangemt").css("display", "block");
				}
				else if (CfgMode.toUpperCase() == 'PARAGUAYPSN')
				{
					$("#brandlog_paraguaypsn").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'MYTIME') {
					$("#brandlog_mytime").css("display", "block");
				} else if (isTruergT3 == 1) {
					$("#brandlog_truerg").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
					$("#brandlog_dethmaxis").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
					$("#brandlog_cypruscyta").css("display", "block");
				}
				else if ((DAUMFEATURE == 1) && (DAUMLOGO == 1))
				{
					$("#brandlog_daum_iprimus").css("display", "block");
				}
				else if ((DAUMFEATURE == 1) && (DAUMLOGO == 2))
				{
					$("#brandlog_daum_dodo").css("display", "block");
				}
				else if ((DAUMFEATURE == 1) && (DAUMLOGO == 3))
				{
					$("#brandlog_daum_commander").css("display", "block");
				}
				else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase())
				{
					$("#brandlog_dnztelecom").css("display", "block");
				}
				else if ('DVODACOM2WIFI' == CfgMode.toUpperCase())
				{
					$("#brandlog_DVODACOM2WIFI").css("display", "block");
					$("#ProductName").css("width", "350px");
					$("#ProductName").css("color", "red");
					document.getElementById("icowancfg").src="../images/configwan_dvodacom.jpg";
					document.getElementById("icowlanconfig").src="../images/configwlan_dvodacom.jpg";
					document.getElementById("icosysconfig").src="../images/syscfg_dvodacom.jpg";
					document.getElementById("icocfgdone").src="../images/configdone_dvodacom.jpg";
					document.getElementById("arrowimg").src="../images/guidearrow_dvodacom.jpg";
				} else if (CfgMode.toUpperCase() == 'CLARODR') {
                    $("#brandlog_clarodr").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'AWASR') {
                    $("#brandlog_awasr").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'AOUNITEL') {
                    $("#brandlog_aounitel").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'BRAZCLARO') {
                    $("#brandlog_claro").css("display", "block");
                } else if ((CfgMode.toUpperCase() == "DBAA1")) {
                    $("#brandlog_dbaa1").css("display", "block");
                } else if (htFlag == 1) {
                    $("#brandlog_ht").css("display", "block");
                } else if (oteFlag == 1) {
                    $("#brandlog_ote").css("display", "block");
                } else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
                    $("#brandlog_deskctap").css("background", "url('/images/logo_pon_login_deskctap.jpg') no-repeat center");
                    $("#brandlog_deskctap").css("display", "block");
                    $("#brandlog_deskctap").css("width", "172px");
                    $("#brandlog_deskctap").css("height", "60px");
                    $("#brandlog_deskctap").css("float", "left");
                } else if (SupportTtnet()) {
                    document.getElementById("icowancfg").src="../images/configinternet.jpg";
                } else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
                    $("#guideframebody").css("background-color", "#44a7e0");
                    $("#guideframebody").css("background-image", "url()");
                    $("#ProductName").css("font-size", "22px");
                    $("#ProductName").css("line-height", "73px");
                    $("#ProductName").css("color", "#FFFFFF");
                    $("#ProductName").css("margin-left", "162px");
                    $("#brandlog_commonrmhw").css("display", "block");
                } else {
                    $("#brandlog").css("display", "block");
                }
                if ((CfgMode.toUpperCase() == 'TS2') || (CfgMode.toUpperCase() == 'TS') || (CfgMode.toUpperCase() == 'TS2WIFI')) {
                    $("#brandlog").css("background", "url(../images/logo_ts.jpg) no-repeat center");
                    $("#brandlog").css("background-size", "80%");
                    $("#brandlog").css("width", "155px");
                    $("#brandlog").css("height", "70px");
                    $("#ProductName").css("line-height", "95px");
                }
                if (CfgMode.toUpperCase() == "UMNIAHPAIR") {
                    $("#brandlog").css("background", "url(../images/headerlogo_umniah.gif) no-repeat center");
                    $("#copyrightlog").css("background-image", "url()");
                }
                if (CfgMode.toUpperCase() == 'MOINWI2' || CfgMode.toUpperCase() == 'MOINWI') {
                    $("#brandlog").css("background", "url(../../../images/logo_moinwi2wifi.gif) no-repeat center");
                    $("#brandlog").css("background-repeat", "no-repeat");
                    $("#brandlog").css("background-size", "100%");
                    $("#brandlog").css("width", "140PX");
                    $("#brandlog").css("margin-right", "10px");
                }
                if (["TELESUREBG4","TELESUR2"].indexOf(CfgMode.toUpperCase()) >= 0) { 
                    $("#brandlog").css("background", "url(../images/telesur-colored.png) no-repeat center");
                    $("#brandlog").css("float", "right");
                    $("#brandlog").css("width", "105px"); 
                    $("#brandlog").css("height", "45px"); 
                    $("#brandlog").css("background-size", "contain");
                    $("#brandlog").css("background-position", "center center");  
                }
                if (CfgMode.toUpperCase() == "CMHK") {
                    $("#brandlog").css("background", "url(../images/CMHKlogo.jpg) no-repeat center");
                    $("#brandlog").css("background-size", "100%");
                    $("#brandlog").css("width", "200px");
                    $("#brandlog").css("height", "66px");
                    $("#brandlog").css("margin-top", "-16px");
                    $("#ProductName").css("margin-left", "228px");
                    $("#ProductName").css("padding-top", "2px");
                }
                if (CfgMode.toUpperCase() == "TM2") {
                    $("#brandlog").css("background", "url(../../../images/hwlogo_tm.gif) no-repeat center");
                    $("#brandlog").css("background-size", "100%");
                    $("#brandlog").css("width", "25px");
                    $("#brandlog").css("height", "25px");
                    $("#brandlog").css("margin-top", "5px");
                    $("#ProductName").css("margin-left", "20px");
                    $("#ProductName").css("padding-top", "2px");
                }
            }
        }
    </script>
</body>
</html>
