<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" media="all" rel="stylesheet" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(guide.css);%>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script type="text/javascript" src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="/resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<script language="javascript" src="/html/bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="/html/bbsp/common/wan_list.asp"></script>

<title></title>
</head>
<script>
var TYPE_NORMAL_USER = '2';
var CurUserType = '<%HW_WEB_GetUserType();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var IsSurportInternetCfg  = "<%HW_WEB_GetFeatureSupport(BBSP_FT_GUIDE_PPPOE_WAN_CFG);%>";
var IsSurportWlanCfg  = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var UpgradeFlag = 0;
var selectrepwlan = "";
var wifiForm = null;
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
document.title = ProductName;
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var telmexwififeature = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var apcmodefeature = '<%HW_WEB_GetFeatureSupport(FT_SSMP_AP_OPERATION_SWITCH);%>';
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
var DirectGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_CHANGE_GUIDE_LEVEL);%>';
var DAUMLOGO = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_Web.X_WebLogo);%>';
var DAUMFEATURE = "<%HW_WEB_GetFeatureSupport(FT_PRODUCT_DAUM);%>";
var trueAdapt = '<%HW_WEB_GetFeatureSupport(FT_TRUE_ADAPT);%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var UserGuideSteps = getUserGuideSteps();
var aprepeater = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_BbspConfig.UpLinkStatus);%>';
var aprepEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_FeatureList.BBSPCustomization.AutoSelectSlaveApUpPort);%>';
var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";
var isTruergT3 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRUERGT3);%>';
var notSupportPON = '<%HW_WEB_GetFeatureSupport(FT_WEB_DELETE_PON);%>';
var timer = [];
var UserName = '<%HW_WEB_GetCurUserName();%>';
var modifyWebcodeLogout = '<%HW_WEB_GetFeatureSupport(FT_MODIFY_WEBCODE_GUIDE_LOGOUT);%>';
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
var isForceModifyPwd = (securityAccessWeb == "1") && (userInfo[0].ModifyPasswordFlag == 0);

if(1 != curChangeMode && 1 == aprepEnable)
{
	if(3 == aprepeater)
	{
		curChangeMode = 2;
	}
	else if(8 == aprepeater)
	{
		curChangeMode = 3;
	}
}

if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI'))
{
    document.write('<link rel="shortcut icon" href="/images/Dzain.ico" />');
    document.write('<link rel="Bookmark" href="/images/Dzain.ico" />');
}

if (DAUMFEATURE == 1) {
	document.write('<link rel="shortcut icon" href="/images/hwlogo.ico" />');
	document.write('<link rel="Bookmark" href="/images/hwlogo.ico" />');
}

function getUserGuideSteps()
{
    if (DBAA1 == "1") {
        return 1;
	}

    if (CfgMode.toUpperCase() == "TURKCELL2") {
        return 0;
    }

    if ((CfgMode.toUpperCase() == "DETHMAXIS") && (CurUserType == TYPE_NORMAL_USER)){
        return 1;
    }

	return ((IsSurportInternetCfg == "1" && mngttype == "0") ? 0x2 : 0) + (IsSurportWlanCfg == "1" ? 1 : 0);
}

function filterPPPInternetWan(wanItem)
{
	if ((wanItem.ServiceList.toUpperCase().indexOf("INTERNET") >= 0)
		&& (wanItem.EncapMode.toUpperCase() == "PPPOE"))
	{
		return true; 
	}

	return false;
}

var internetPPPWanInfo = GetWanListByFilter(filterPPPInternetWan);

if(internetPPPWanInfo.length > 0)
{
	if((1 == smartlanfeature &&  1== IsSurportWlanCfg))
	{
		UserGuideSteps = 3;
	}
	else if((1 == smartlanfeature &&  0== IsSurportWlanCfg)) {
		UserGuideSteps = 2;
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
    if (CfgMode.toUpperCase() == "TURKCELL2") {
       UserGuideSteps = 0;
    }

	var CfgAccountSrc = (1 == DirectGuideFlag)?"/html/ssmp/accoutcfg/guideaccountcfgAP.asp":"/html/ssmp/accoutcfg/guideaccountcfg.asp";
	
	if("" != curChangeMode && 0 != curChangeMode)
	{
		if(1 == apcmodefeature)
		{
			$("#spancmodeconfig").css("display", "inline-block");
			$("#icocmodeimage").css("display", "inline-block");
			$("#spanwlanconfig").css("display", "none");
			$("#icowlanconfig").css("display", "none");	
			document.getElementById("frameContent").src = "/html/ssmp/modechange/modechange.asp";
			$("#selectarrow").addClass("guidestep1of3");
			//setStepClass("wlanconfig", "guidestepintv3");
			setStepClass("sysconfig",  "guidestepintv3");
			setStepClass("configdone", "guidestepintv3");
			showStep("cmodecfg");	
			if("VDFPTAP"==CfgMode || "TRUEAP"==CfgMode)
			{
				document.getElementById("frameContent").src = "/html/amp/wlaninfo/wlanneighborAP.asp";
			}
			if(trueAdapt == 1)
			{
				document.getElementById("frameContent").src = "/html/ssmp/modechange/modechange.asp";
			}
		}
		else
		{
			if(curChangeMode=='2' || curChangeMode=='3')
			{
				$("#spancmodeconfig").css("display", "none");
				$("#icocmodeimage").css("display", "none");
				$("#spanwlanconfig").css("display", "none");
				$("#icowlanconfig").css("display", "none");	
				document.getElementById("frameContent").src = CfgAccountSrc;
				$("#selectarrow").addClass("guidestep1of2");
				//setStepClass("sysconfig",  "guidestepintv2");
				setStepClass("configdone", "guidestepintv2");
				
			}
		}
	}

	else
	{
		switch (UserGuideSteps)
		{
			case 3:
				if ((ProductType == '2') && isForceModifyPwd) {
					document.getElementById("frameContent").src = "/html/ssmp/accoutcfg/guideaccountcfg.asp";
					$("#selectarrow").addClass("guidestep1of4");
					setStepClass("wlanconfig", "guidestepintv4");
					setStepClass("internetconfig", "guidestepintv4");
					setStepClass("configdone", "guidestepintv4");
					showStep("sysconfig");
					showStep("wlanconfig");
				} else {
					document.getElementById("frameContent").src = "/html/bbsp/guideinternet/guideinternet.asp";
					$("#selectarrow").addClass("guidestep1of4");
					//setStepClass("internetconfig", "guidestepintv4");
					setStepClass("wlanconfig",     "guidestepintv4");
					setStepClass("sysconfig",      "guidestepintv4");
					setStepClass("configdone",     "guidestepintv4");
					showStep("internetconfig");
					showStep("wlanconfig");
				}
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
				document.getElementById("frameContent").src = CfgAccountSrc;
				$("#selectarrow").addClass("guidestep1of2");
				//setStepClass("sysconfig",  "guidestepintv2");
				setStepClass("configdone", "guidestepintv2");
				break;
		}
	}

	if (CfgMode.toUpperCase() == 'BRAZCLARO') {
		$("#guideframebody").css("background-color", "rgb(218,41,28)");
        $("#guideframebody").css("background-image", "url()");
    }

	if ((ProductType == '2') && isForceModifyPwd) {
		showStep("internetconfig");
	} else {
		showStep("sysconfig");
	}

	if (CfgMode.toUpperCase() != "TURKCELL2") {
		showStep("configdone");
		setDisplay("selectarrow", 1);
	}
	timer.push(setInterval("adjustParentHeight();", 200));
	wifiForm = new webSubmitForm();
}

function onchangestep(val)
{
	var id = val.id;
	var totalSteps = 2;
	var curStep = 1;
	var defStepOff = 2;
	var wifiStepOff = 0;
    
    if ((id == "guidecfgdone") && (modifyWebCode == '1') && (modifyWebcodeLogout == '1')) {
        setDisplay("guideframebody", 0);
        setDisplay("selectarrow", 0);
        setDisplay("greenline", 0);
        setDisplay("framepageContent", 0);
    }
    
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
		if ((ProductType == '2') && isForceModifyPwd) {
			curStep = 3;
		} else {
			curStep = 1;
		}
	}
    else if(id == "guidewificfg" || id == "guidecmodecfg" || id == "guidewlanconfig") 
	{
		curStep = 2 + wifiStepOff;
	}
	else if(id == "guidesyscfg")
	{
		if ((ProductType == '2') && isForceModifyPwd) {
			curStep = 1;
		} else {
			curStep = 1 + defStepOff;
		}
	}
	else if(id == "guidecfgdone")
	{
		curStep = 2 + defStepOff;
    } else {
		return;
	}
	
	if((2 == curChangeMode && 0 == apcmodefeature) || (3 == curChangeMode && 0 == apcmodefeature))
	{
		totalSteps  = 2;
		defStepOff = 0;
		if(id == "guidecfgdone"){
			curStep = 2 + defStepOff;
		}else if(id == "guidesyscfg"){
			curStep = 1 + defStepOff;
		}else{
			return;
		}
	}
	
	resetArrowClass();
	$("#selectarrow").addClass("guidestep" + curStep + "of" + totalSteps);
	if('1' == smartlanfeature && val.name.indexOf("guidebssinfo.asp") != -1){
		val.name = "/html/ssmp/cfgguide/userguidecfgdone.asp";
	}
	
	document.getElementById("frameContent").src = val.name;
	timer.push(setInterval("adjustParentHeight();", 200));
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

function adjustParentHeight()
{
	adjustFrameHeight("framepageContent", "frameContent", 90);
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
			} else if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
				document.write('<div id="brandlog_DZAIN2" style="display:none;"></div>');
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
			}
			else if ('ORANGEMT' == CfgMode.toUpperCase())
			{
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_orangemt" src="../../images/hwlogo_orangemt.gif" width="48px"></img>' + '<div  id="ProductNameOrg">' + ProductName + '</div>'+'</div>');
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
			else if (CfgMode.toUpperCase() == 'PARAGUAYPSN')
			{
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<div style="margin-left:50px"><img id="brandlog_paraguaypsn" src="../../images/hwlogo_paraguaypsn.gif" width="92px"></img></div>' + '<div  id="ProductNamePar">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'MYTIME') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 12px"></div>'+'<div style="margin-left:50px"><img id="brandlog_mytime" src="../../images/hwlogo_mytime.gif" width="92px"></img></div>' + '<div  id="ProductNamePar" style="margin-top: -37px">' + ProductName + '</div>'+'</div>');
			} else if (isTruergT3 == 1) {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_truerg" src="../../images/hwlogo_truergpwdsn.gif" width="48px"></img>' + '<div  id="ProductNameTruergPwdsn">' + ProductName + '</div>'+'</div>');
			}
			else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase())
			{
				document.write('<div id="brandlog_dnztelecom" style="display:none;"></div>');
			} else if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
				document.write('<div id="brandlog_DVODACOM2WIFI" style="display:none;"></div>');
			} else if (CfgMode.toUpperCase() == 'CLARODR') {
				document.write('<div id="brandlog_clarodr" style="display:none;"></div>');
			} else if (CfgMode.toUpperCase() == "BRAZCLARO") {
                document.write('<div id="brandlog_claro" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<img id="brandlog_dethmaxis" src="../../images/hwlogo_dethmaxis.gif" width="65px"></img>' + '<div  id="ProductNameDethmaxis">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<div style="margin-left:50px"><img id="brandlog_cypruscyta" src="../../images/hwlogo_cyta.jpg" width="92px"></img></div>' + '<div  id="ProductNameCypruscyta" style="margin-top: -40px">' + ProductName + '</div>'+'</div>');
			} else if (DBAA1 == '1') {
                document.write('<div id="brandlog_dbaa1" style="display:none;"></div>');
            } else if (htFlag == 1) {
                document.write('<div id="brandlog_ht" style="display:none;"></div>');
            } else if (oteFlag == 1) {
                document.write('<div id="brandlog_ote" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
                document.write('<div id="brandlog_commonrmhw" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == 'AWASR') {
                document.write('<div id="brandlog_awasr" style="display:none;"></div>');
            } else {
                document.write('<div id="brandlog" style="display:none;"></div>');
            }
			</script>
			<script>
			if (CfgMode.toUpperCase() == 'AOUNITEL'){
				document.write('<div id="ProductName" style="text-align:right; margin-left:630px;"></div>');
			}
			else if(logo_singtel == '1')
			{
				document.write('<div id="ProductName" style="text-align:right; margin-left:630px;">' + ProductName + '</div>');				
			}
			else if (('ORANGEMT' !== CfgMode.toUpperCase()) && ('PARAGUAYPSN' !== CfgMode.toUpperCase()) && (isTruergT3 != 1)
				&& (CfgMode.toUpperCase() !== 'MYTIME') && (CfgMode.toUpperCase() != 'DETHMAXIS') && (CfgMode.toUpperCase() != 'CYPRUSCYTA')) {
				if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
					document.write('<div id="ProductName" style="float:left;">' + ProductName + '</div>');
					document.write('<div style="clear:both;">' + '</div>');
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
					document.write('<div id="guideframehead"><span BindText="s2012SINGTELHS"></span></div>');
				}
				else
				{
					document.write('<div id="guideframehead"><span BindText="s2012SINGTEL"></span></div>');
				}
			}
			else
			{	
				if(smartlanfeature == 1)
				{	if("" != curChangeMode && 0 != curChangeMode || GhnDevFlag == 1)
					{
						document.write('<div id="guideframehead"><span BindText="s2012aplan"></span></div>');
					}
					else if(1 == IsSmartDev)
					{
						document.write('<div id="guideframehead"><span BindText="s2012lan"></span></div>');
					}else{
						document.write('<div id="guideframehead"><span BindText="s2012aplan"></span></div>');
					}
				} else {
                    if (ProductType == '2') {
						if ('DVODACOM2WIFI' == CfgMode.toUpperCase()) {
								document.write('<div id="guideframehead"  style="margin-top:76px;"><span BindText="s2012_xd"></span></div>');
							} else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
                            	document.write('<div id="guideframehead"><span BindText="s2012_dethmaxis"></span></div>');
                        	} else if (CfgMode.toUpperCase() == 'DBAA1') {
								document.write('<div id="guideframehead"><span style="" BindText="s2012_dbaa1"></span></div>');
							} else if (CfgMode.toUpperCase() == 'DCORIOLIS2WIFI') {
                                document.write('<div id="guideframehead"><span BindText="s2012_coriolis"></span></div>');
                        	} else {
								document.write('<div id="guideframehead"><span style="" BindText="s2012_xd"></span></div>');
							}
                    } else {
						if (isTruergT3 == 1) {
                            document.write('<div id="guideframehead"><span BindText="s2012_truerg"></span></div>');
                        } else if (notSupportPON == 1) {
                            document.write('<div id="guideframehead"><span style="" BindText="s2012_xd"></span></div>');
						} else if (CfgMode.toUpperCase() == 'AOUNITEL') {
							document.write('<div id="guideframehead"><span BindText="s2012AOUNITEL"></span></div>');
                        } else {
							document.write('<div id="guideframehead"><span BindText="s2012"></span></div>');
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
						if ((ProductType == '2') && isForceModifyPwd) {
							document.write('<span id="spansysconfig" class="" style="display:none;" BindText="s2018"></span>');
							document.write('<span id="spanwlanconfig" class="" style="display:none;" BindText="s2017"></span>');
							document.write('<span id="spancmodeconfig" class="" style="display:none;word-wrap: break-word;width: 118px;font-size: 18px;color: #ffffff;font-family: Arial, Î¢ÈíÑÅºÚ" BindText="s2038"></span>');
							document.write('<span id="spaninternetconfig" class="" style="display:none;" BindText="s2016"></span>');
							document.write('<span id="spanconfigdone" class="" style="display:none;" BindText="s2015"></span>');
						} else {
							document.write('<span id="spaninternetconfig" class="" style="display:none;" BindText="s2016"></span>');
							document.write('<span id="spanwlanconfig" class="" style="display:none;" BindText="s2017"></span>');
							document.write('<span id="spancmodeconfig" class="" style="display:none;word-wrap: break-word;width: 118px;font-size: 18px;color: #ffffff;font-family: Arial, Î¢ÈíÑÅºÚ" BindText="s2038"></span>');
							document.write('<span id="spansysconfig" class="" style="display:none;" BindText="s2018"></span>');
							document.write('<span id="spanconfigdone" class="" style="display:none;" BindText="s2015"></span>');
						}
					</script>
				</div>

				<div id="guidestepsico">
					<script>
						if ((ProductType == '2') && isForceModifyPwd) {
							document.write('<img id="icosysconfig" class="" style="display:none;" name="guidesystemcfg.asp" src="" />');
							document.write('<img id="icowlanconfig" class="" style="display:none;" name="../../html/amp/wlanbasic/guidewificfg.asp" src="../images/configwlan.jpg" >');
							document.write('<img id="icocmodeimage" class="" style="display:none;" name="" src="../images/cmode.png" />');
							document.write('<img id="icointernetconfig" class="" style="display:none;" name="../../html/bbsp/guideinternet/guideinternet.asp" src="../images/configinternet.jpg" />');
							document.write('<img id="icoconfigdone" class="" style="display:none;" name="userguidecfgdone.asp" src="../images/configdone.jpg" />');
						} else if (CfgMode.toUpperCase() == 'AOUNITEL') {
							document.write('<img id="icointernetconfig"   class="" style="display:none;" name="../../html/bbsp/guideinternet/guideinternet.asp" src="../images/configinternet_black.jpg" />');
							document.write('<img id="icowlanconfig"       class="" style="display:none;" name="../../html/amp/wlanbasic/guidewificfg.asp" src="../images/configwlan_black.jpg" />');
							document.write('<img id="icocmodeimage" class="" style="display:none;" name="" src="../images/cmode_black.png">');
							document.write('<img id="icosysconfig"        class="" style="display:none;" name="guidesystemcfg.asp" src="" />');
							document.write('<img id="icoconfigdone"       class="" style="display:none;" name="userguidecfgdone.asp" src="../images/configdone_black.jpg" />');
						} else {
							document.write('<img id="icointernetconfig" class="" style="display:none;" name="../../html/bbsp/guideinternet/guideinternet.asp" src="../images/configinternet.jpg" />');
							document.write('<img id="icowlanconfig" class="" style="display:none;" name="../../html/amp/wlanbasic/guidewificfg.asp" src="../images/configwlan.jpg" >');
							document.write('<img id="icocmodeimage" class="" style="display:none;" name="" src="../images/cmode.png" />');
							document.write('<img id="icosysconfig" class="" style="display:none;" name="guidesystemcfg.asp" src="" />');
							document.write('<img id="icoconfigdone" class="" style="display:none;" name="userguidecfgdone.asp" src="../images/configdone.jpg" />');
						}
					</script>
				</div>
				<script type="text/javascript">
					if (true == logo_singtel)
					{
						if (CfgMode.toUpperCase() == 'AOUNITEL') {
							document.getElementById("icosysconfig").src= "../images/syscfgnowifi_black.jpg";
						} else {
							document.getElementById("icosysconfig").src= "../images/syscfgnowifi.jpg";
						}
					}
					else
					{
						if (CfgMode.toUpperCase() == 'AOUNITEL') {
							document.getElementById("icosysconfig").src= "../images/syscfg_black.jpg";
						} else {
							document.getElementById("icosysconfig").src= "../images/syscfg.jpg";
						}
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
			    if ('TELECENTRO' == CfgMode.toUpperCase())
				{
					$("#brandlog_telecentro").css("display", "block");
				}
				else if ('PLDT2' == CfgMode.toUpperCase() || 'PLDT' == CfgMode.toUpperCase())
				{
					$("#brandlog_pldt").css("display", "block");
				} else if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
					$("#brandlog_DZAIN2").css("display", "block");
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
				}
				else if (isTruergT3 == 1) 
				{
					$("#brandlog_truerg").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
					$("#brandlog_dethmaxis").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
					$("#brandlog_cypruscyta").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
					$("#guideframebody").css("background-color", "#44a7e0");
					$("#guideframebody").css("background-image", "url()");
					$("#ProductName").css("font-size", "22px");
					$("#ProductName").css("line-height", "73px");
					$("#ProductName").css("color", "#FFFFFF");
					$("#ProductName").css("margin-left", "162px");
					$("#brandlog_commonrmhw").css("display", "block");
				} else if((DAUMFEATURE == 1) && (DAUMLOGO == 1)) {
					$("#brandlog_daum_iprimus").css("display", "block");
				}
				else if((DAUMFEATURE == 1) && (DAUMLOGO == 2))
				{
					$("#brandlog_daum_dodo").css("display", "block");
				}
				else if((DAUMFEATURE == 1) && (DAUMLOGO == 3))
				{
					$("#brandlog_daum_commander").css("display", "block");
				}
				else if ('DNZTELECOM2WIFI' == CfgMode.toUpperCase())
				{
					$("#brandlog_dnztelecom").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'DVODACOM2WIFI') {
					$("#brandlog_DVODACOM2WIFI").css("display", "block");
					$("#ProductName").css("width", "350px");
					$("#ProductName").css("color", "red");
				} else if (CfgMode.toUpperCase() == 'BRAZCLARO') {
				    $("#brandlog_claro").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'CLARODR') {
					$("#brandlog_clarodr").css("display", "block");
				} else if (DBAA1 == '1') {
					$("#brandlog_dbaa1").css("display", "block");
				} else if (htFlag == 1) {
					$("#brandlog_ht").css("display", "block");
				} else if (oteFlag == 1) {
					$("#brandlog_ote").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'AWASR') {
					$("#brandlog_awasr").css("display", "block");
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
                if (CfgMode.toUpperCase() == "CMHK") {
                    $("#brandlog").css("background", "url(../images/CMHKlogo.jpg) no-repeat center");
                    $("#brandlog").css("background-size", "100%");
                    $("#brandlog").css("width", "200px");
                    $("#brandlog").css("height", "66px");
                    $("#brandlog").css("margin-top", "-16px");
                    $("#ProductName").css("margin-left", "228px");
                    $("#ProductName").css("padding-top", "2px");
                }

                if (CfgMode.toUpperCase() == "UMNIAHPAIR") {
                    $("#brandlog").css("background", "url(../images/headerlogo_umniah.gif) no-repeat center");
                    $("#copyrightlog").css("background-image", "url()");
                }
                if (CfgMode.toUpperCase() == 'MOINWI2'|| CfgMode.toUpperCase() == 'MOINWI') {
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
            }
        }
    </script>
</body>
</html>
