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


<title></title>
</head>
<script>
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var ProductType = '<%HW_WEB_GetProductType();%>';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
document.title = ProductName;
var smartlanfeature = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_LAN_UPPORT);%>';
var telmexwififeature = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
var curChangeMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
var GhnDevFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_GHNAP_MNGT);%>';
var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
var DAUMLOGO = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.X_Web.X_WebLogo);%>';
var DAUMFEATURE = "<%HW_WEB_GetFeatureSupport(FT_PRODUCT_DAUM);%>";
var trueAdapt = '<%HW_WEB_GetFeatureSupport(FT_TRUE_ADAPT);%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var htFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_HT);%>";
var oteFlag = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOGCHANGE_FOR_OTE);%>";
var isTruergT3 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRUERGT3);%>';


if (DAUMFEATURE == 1) {
	document.write('<link rel="shortcut icon" href="/images/hwlogo.ico" />');
	document.write('<link rel="Bookmark" href="/images/hwlogo.ico" />');
}

if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
    document.write('<link rel="shortcut icon" href="/images/Dzain.ico" />');
    document.write('<link rel="Bookmark" href="/images/Dzain.ico" />');
}

function showStep(step)
{
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
    $("#selectarrow").addClass("guidestep2of3");

    showStep("configdone");
    setDisplay("selectarrow", 1);


}

function onFinish()
{
    window.top.location.href="/login.asp";
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
			} else if (DBAA1 == '1') {
                document.write('<div id="brandlog_dbaa1" style="display:none;"></div>');
            } else if (htFlag == 1) {
                document.write('<div id="brandlog_ht" style="display:none;"></div>');
            } else if (oteFlag == 1) {
                document.write('<div id="brandlog_ote" style="display:none;"></div>');
            } else if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
				document.write('<div id="brandlog_DZAIN2" style="display:none;"></div>');
			} else {
                document.write('<div id="brandlog" style="display:none;"></div>');
            }
			</script>
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="ProductName" style="text-align:right; margin-left:630px;">' + ProductName + '</div>');				
			}
			else if (('ORANGEMT' !== CfgMode.toUpperCase()) && ('PARAGUAYPSN' !== CfgMode.toUpperCase()) && (isTruergT3 != 1)
				&& (CfgMode.toUpperCase() !== 'MYTIME') && (CfgMode.toUpperCase() != 'DETHMAXIS')) {
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
							} else {
								document.write('<div id="guideframehead"><span style="" BindText="s2012_xd"></span></div>');
							}
                    } else {
						if (isTruergT3 == 1) {
                            document.write('<div id="guideframehead"><span BindText="s2012_truerg"></span></div>');
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
                        if ('DETHMAXIS' == CfgMode.toUpperCase()) {
                            document.write('<span id="spaninternetconfig" class="" style="display:none;" BindText="s2014_maxis"></span>');
                        } else {
                            document.write('<span id="spaninternetconfig" class="" style="display:none;" BindText="s2016"></span>');
                        }
                    </script>
					<span id="spaninternetconfig" class="" style="display:none;" BindText="s2016"></span>
					<span id="spanwlanconfig"     class="" style="display:none;" BindText="s2017"></span>

					<span id="spancmodeconfig"    class="" style="display:none;word-wrap: break-word;width: 118px;font-size: 18px;color: #ffffff;font-family: Arial, 微软雅黑" BindText="s2038"></span>

					<span id="spansysconfig"      class="" style="display:none;"BindText="s2018"></span>
					<span id="spanconfigdone"     class="" BindText="s2015"></span>
				</div>
				<div id="guidestepsico">
					<img id="icointernetconfig"   class="" style="display:none;" name="../../html/bbsp/guideinternet/guideinternet.asp" src="../images/configinternet.jpg" />
					<img id="icowlanconfig"       class="" style="display:none;" name="../../html/amp/wlanbasic/guidewificfg.asp" src="../images/configwlan.jpg" />

					<img id="icocmodeimage" class="" style="display:none;" name="" src="../images/cmode.png">


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
<form>
		<div align="center">

			<div id="id_wifi_welcome" style="margin-top: 10px;font-size: 16px; color: #666666;" BindText="s2044finish"></div>

			<div style="margin-top: 35px">
				<script>
					if (ProductType != '2')
					{ 
						document.write('<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">');
					}
				</script>
				<input type="button" id="nextpage" class="ApplyButtoncss buttonwidth_120px_200px" onClick="onFinish();" value="" BindText="s2050">
			</div>
		</div>
	</form>
	<script>
		ParseBindTextByTagName(CfgguideLgeDes, "td", 1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "div", 1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "input", 2, mngttype);
	</script>

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
				} else if((DAUMFEATURE == 1) && (DAUMLOGO == 1))
				{
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
				} else if ((CfgMode.toUpperCase() == 'DZAIN2') || (CfgMode.toUpperCase() == 'DSAZAIN2WIFI')) {
                    $("#brandlog_DZAIN2").css("display", "block");
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
			}
		}
	</script>
</body>
</html>
