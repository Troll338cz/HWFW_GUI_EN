<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' rel="stylesheet" type="text/css" />
<link href="../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>" rel="stylesheet" type="text/css" />
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<title></title>
</head>
<script>
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var RedirtIndex = 0;
var UpgradeFlag = 0;
var TypeWord_com = '<%HW_WEB_GetTypeWord();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var isTruergT3 = '<%HW_WEB_GetFeatureSupport(FT_WEB_TRUERGT3);%>';
var sonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var guideIndex = '<%HW_WEB_GetGuideChl();%>';
var L3_Web_cut = '<%HW_WEB_GetFeatureSupport(BBSP_FT_LSW_WEB_CUT);%>';
var UserName = '<%HW_WEB_GetCurUserName();%>';

guideIndex = guideIndex - 48;
document.title = ProductName;
var checkImgRef = "../../../images/guidecheck.jpg";
var nocheckImgRef = "../../../images/guidenocheck.jpg";

function loadframe()
{
	if ( (0 < guideIndex) && (5 > guideIndex))
	{
		RedirtIndex = guideIndex;
		document.getElementById("img" + guideIndex).src = "../../../images/guidecheck.jpg";
	}
	else
		document.getElementById("btncfgnext").disabled = "disabled";

	if (CfgMode.toUpperCase() == 'BRAZCLARO') {
        $("#mainguidebg").css("background-color", "rgb(218,41,28)");
        $("#mainguidebg").css("background-image", "url()");
	}

	if (CfgMode.toUpperCase() == 'AOUNITEL') {
		document.getElementById("headerName").innerHTML = ProductName;
		$("#img1").attr("src", "../../../images/guidenocheck_ORANGEMT2.png");
		$("#img2").attr("src", "../../../images/guidenocheck_ORANGEMT2.png");
		$("#img3").attr("src", "../../../images/guidenocheck_ORANGEMT2.png");
		$("#img4").attr("src", "../../../images/guidenocheck_ORANGEMT2.png");
		checkImgRef = "../../../images/guidecheck_ORANGEMT2.png";
		nocheckImgRef = "../../../images/guidenocheck_ORANGEMT2.png";
	}

	if (L3_Web_cut == true) {
		setDisplay("guideline3",0);
		setDisplay("guideline4",0);
	}
}

function onchangeimg(id)
{
	var selectpng = document.getElementById(id).src.split("/");
	selectpng = selectpng[selectpng.length - 1];

	if(selectpng == "guidenocheck.jpg" || selectpng == "guidenocheck_ORANGEMT2.png")
	{
		document.getElementById(id).src = checkImgRef;
		RedirtIndex = id.substr(id.length - 1, 1);
		for(var i = 1; i < 5; i++)
		{
			if (RedirtIndex != i)
			{
				document.getElementById("img" + i).src = nocheckImgRef;
			}
		}
		document.getElementById("btncfgnext").disabled = "";
	}
	else
	{
		document.getElementById(id).src = nocheckImgRef;
		RedirtIndex = 0;
		document.getElementById("btncfgnext").disabled = "disabled";
	}
}

function onbtncfgnext(val)
{
	if (0 < RedirtIndex && 5 > RedirtIndex)
	{
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : '/smartguide.cgi?1=1&RequestFile=CustomApp/adminguideframe.asp',
			data: getDataWithToken('Parainfo=' + RedirtIndex, true),
			success : function(data) {
				;
			}
		});

		window.location="/CustomApp/adminguideframe.asp";
	}
}

function onfirstpage(val)
{
	if (-48 == guideIndex)
	{
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : '/smartguide.cgi?1=1&RequestFile=index.asp',
			data: getDataWithToken('Parainfo=0', true),
			success : function(data) {
				;
			}
		});
	}

	window.location="/index.asp";
}
</script>
<body onload="loadframe();">
	<div id="headerSpace" style="display: none;">
		<div id="headerLogo"></div>
		<div id="headerName"></div>
	</div>
	<div id="mainguidebg">
		<div id="mainguidetop">
			<script>
			if(true == logo_singtel)
			{
				document.write('<div id="brandlog_singtel" style="display:none;"></div>');				
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
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_orangemt" src="../../../images/hwlogo_orangemt.gif" width="48px"></img>' + '<div  id="ProductNameOrg">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'MYTIME') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 12px"></div>'+'<div style="margin-left:50px"><img id="brandlog_mytime" src="../../../images/hwlogo_mytime.gif" width="92px"></img></div>' + '<div id="ProductNamePar" style="margin-top: -37px">' + ProductName + '</div>'+'</div>');
			} else if (isTruergT3 == 1) {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<img id="brandlog_truerg" src="../../../images/hwlogo_truergpwdsn.gif" width="48px"></img>' + '<div id="ProductNameTruergPwdsn">' + ProductName + '</div>'+'</div>');
			}
			else if (CfgMode.toUpperCase() == 'PARAGUAYPSN')
			{
				document.write('<div style="margin: 0 auto">' + '<div style="height: 8px"></div>'+'<div style="margin-left:50px"><img id="brandlog_paraguaypsn" src="../../../images/hwlogo_paraguaypsn.gif" width="92px"></img></div>' + '<div id="ProductNamePar">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'CLARODR') {
                document.write('<div id="brandlog_clarodr" style="display:none;"></div>');
            } else if (CfgMode.toUpperCase() == "BRAZCLARO") {
			    document.write('<div id="brandlog_claro" style="display:none;"></div>');
			} else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
				document.write('<div id="brandlog_deskctap" style="display:none;"></div>');
			} else if (CfgMode.toUpperCase() == 'DETHMAXIS') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<img id="brandlog_dethmaxis" src="../../../images/hwlogo_dethmaxis.gif" width="65px"></img>' + '<div id="ProductNameDethmaxis">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
				document.write('<div style="margin: 0 auto">' + '<div style="height: 18px"></div>'+'<div style="margin-left:50px"><img id="brandlog_cypruscyta" src="../../../images/hwlogo_cyta.jpg" width="92px"></img></div>' + '<div id="ProductNameCypruscyta" style="margin-top: -40px">' + ProductName + '</div>'+'</div>');
			} else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
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
				document.write('<div id="ProductName" style="text-align:right; height:41px; line-height:63px; margin-left:630px;">' + ProductName + '</div>');				
			}
			else if (CfgMode.toUpperCase() == 'AOUNITEL')
			{
				document.write('<div id="ProductName"></div>');
			}
			else if ((CfgMode.toUpperCase() !== 'ORANGEMT') && (CfgMode.toUpperCase() !== 'PARAGUAYPSN') && (isTruergT3 != 1)
				&& (CfgMode.toUpperCase() !== 'MYTIME') && (CfgMode.toUpperCase() != 'DETHMAXIS') && (CfgMode.toUpperCase() != 'CYPRUSCYTA')) {
				document.write('<div id="ProductName">' + htmlencode(ProductName) + '</div>');
			}
			</script>

			<div id="guidindexhead" class="guideline">
				<div class="guidecheckbox"></div>
				<div class="guidecontent"><div class="check_title"><span BindText="s2000"></span></div></div>
			</div>
			<div class="guideheadspace"></div>
			<div id="guideline1" class="guideline">
				<div class="guidecheckbox"><img id="img1" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<div class="guidecontent"><div class="check_title"><span id="oltcfg" BindText="s2001"></span></div></div>
				<div class="guidecheckbox"></div>
				<!--
				<div class="guidecontent"><div class="check_content"><span id="oltcfginfo" BindText="s2002"></span></div></div>
				-->
				<script>
					if (ProductName == 'DN82545F')
					{
						document.write('<div class="guidecontent"><div class="check_content"><span id="oltcfginfo" BindText="s2002_xd"></span></div></div>');
					}
					else
					{
						document.write('<div class="guidecontent"><div class="check_content"><span id="oltcfginfo" BindText="s2002"></span></div></div>');
					}
				</script>
			</div>
			<div class="guidespace"></div>
			<div id="guideline2" class="guideline">
				<div class="guidecheckbox"><img id="img2" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<div class="guidecontent"><div class="check_title"><span id="emscfg" BindText="s2003"></span></div></div>
				<div class="guidecheckbox"></div>
				<!--
				<div class="guidecontent"><div class="check_content"><span id="emscfginfo" BindText="s2004"></span></div></div>
			-->
				<script>
					if (ProductName == 'DN8245F')
					{
						document.write('<div class="guidecontent"><div class="check_content"><span id="emscfginfo" BindText="s2004_xd"></span></div></div>');
					}
					else
					{
						document.write('<div class="guidecontent"><div class="check_content"><span id="emscfginfo" BindText="s2004"></span></div></div>');
					}
				</script>
			</div>
			<div class="guidespace"></div>
			<div id="guideline3" class="guideline">
				<div class="guidecheckbox"><img id="img3" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<div class="guidecontent"><div class="check_title"><span id="acscfg" BindText="s2005"></span></div></div>
				<div class="guidecheckbox"></div>
				<!--
				<div class="guidecontent"><div class="check_content"><span id="acscfginfo" BindText="s2006"></span></div></div>
				-->
				<script>
					if (ProductName == 'DN8245F')
					{
						document.write('<div class="guidecontent"><div class="check_content"><span id="acscfginfo" BindText="s2006_xd"></span></div></div>');
					}
					else
					{
						document.write('<div class="guidecontent"><div class="check_content"><span id="acscfginfo" BindText="s2006"></span></div></div>');
					}
				</script>				
			</div>
			<div class="guidespace"></div>
			<div id="guideline4" class="guideline">
				<div class="guidecheckbox"><img id="img4" src="../../../images/guidenocheck.jpg" onClick="onchangeimg(this.id);"></div>
				<!--
				<div class="guidecontent"><div class="check_title"><span id="webcfg" BindText="s2007"></span></div></div>
				<div class="guidecheckbox"></div>
				<div class="guidecontent"><div class="check_content"><span id="webcfginfo" BindText="s2008"></span></div></div>
				-->
				<script>
					if (ProductName == 'DN8245F')
					{
						document.write('<div class="guidecontent"><div class="check_title"><span id="webcfg" BindText="s2007_xd"></span></div></div><div class="guidecheckbox"></div><div class="guidecontent"><div class="check_content"><span id="webcfginfo" BindText="s2008_xd"></span></div></div>');
					}
					else
					{
						document.write('<div class="guidecontent"><div class="check_title"><span id="webcfg" BindText="s2007"></span></div></div><div class="guidecheckbox"></div><div class="guidecontent"><div class="check_content"><span id="webcfginfo" BindText="s2008"></span></div></div>');
					}
				</script>
			</div>
			<div class="guidespace"></div>
			<div id="guideline5" class="guideline">
				<div class="guidecheckbox"></div>
				<div class="guidecontent">
					<input type="button" id="firstpage"  class="CancleButtonBlueBgCss buttonwidth_100px" onClick="onfirstpage(this);"  value="" BindText="s2009">
					<input type="button" id="btncfgnext" class="CancleButtonBlueBgCss buttonwidth_100px" onClick="onbtncfgnext(this);" value="" BindText="s2010">
				</div>
			</div>
		</div>
	</div>
	<div id="greenline"></div>
	<div id="copyright">
		<div id="copyrightspace"></div>
		<div id="copyrightlog" style="display:none;"></div>
        <script type="text/javascript">
            if (sonetFlag == 1) {
                document.write('<div id="copyrighttext"><span id="footer" BindText="s2011SGP"></span></div>');			
            } else {
                document.write('<div id="copyrighttext"><span id="footer" BindText="s2011"></span></div>');
            }
        </script>
	</div>

	<div style="display:none;">
		<iframe frameborder="0" height="100%" marginheight="0" marginwidth="0" scrolling="no" src="/refresh.asp" width="100%"></iframe>
	</div>

	<script>
		ParseBindTextByTagName(CfgguideLgeDes, "span",  1, mngttype, logo_singtel);
		ParseBindTextByTagName(CfgguideLgeDes, "input", 2);
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
				} else if (CfgMode.toUpperCase() == 'MYTIME') {
					$("#brandlog_mytime").css("display", "block");
				} else if (isTruergT3 == 1) {
					$("#brandlog_truerg").css("display", "block");
				} else if ('DETHMAXIS' == CfgMode.toUpperCase()) {
					$("#brandlog_dethmaxis").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'CYPRUSCYTA') {
					$("#brandlog_cypruscyta").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'PARAGUAYPSN')
				{
					$("#brandlog_paraguaypsn").css("display", "block");
				} else if (CfgMode.toUpperCase() == 'CLARODR') {
                    $("#brandlog_clarodr").css("display", "block");
                } else if (CfgMode.toUpperCase() == 'BRAZCLARO') {
				    $("#brandlog_claro").css("display", "block");
				} else if ((CfgMode.toUpperCase() != "COMMON") && (ProductName.toUpperCase() == "K662C")) {
					$("#brandlog_deskctap").css("background", "url('/images/logo_pon_login_deskctap.jpg') no-repeat center");
				    $("#brandlog_deskctap").css("display", "block");
					$("#brandlog_deskctap").css("width", "172px");
					$("#brandlog_deskctap").css("height", "60px");
					$("#brandlog_deskctap").css("float", "left");
					$("#copyrightlog").css("background-image", "url('')");
				} else if (CfgMode.toUpperCase() == 'COMMONRMHW') {
					$("#mainguidebg").css("background-image", "url()");
					$("#mainguidebg").css("background-color", "#44a7e0");
					$("#ProductName").css("font-size", "22px");
					$("#ProductName").css("line-height", "73px");
					$("#ProductName").css("color", "#FFFFFF");
					$("#ProductName").css("margin-left", "162px");
					$("#brandlog_commonrmhw").css("display", "block");
					$("#copyrightlog").css("background-image", "url()");
				} else if (CfgMode.toLocaleUpperCase() == 'AOUNITEL') {
					$("#brandlog_aounitel").css("display", "block");
				} else if (CfgMode.toLocaleUpperCase() == 'AWASR') {
					$("#brandlog_awasr").css("display", "block");
				} else {
					$("#brandlog").css("display", "block");
				}
			}
			
			if((parseInt(logo_singtel, 10) == 1) && TypeWord_com == "COMMON")
			{
				$("#copyrightlog").css("display", "none");
			}
			else if (isTruergT3 == 1)
			{
				document.getElementById('copyrightlog').style.display = 'none';
			} else if ((CfgMode.toUpperCase() == 'DETHMAXIS') || (CfgMode.toUpperCase() == 'COMMONRMHW')) {
				document.getElementById('copyrightlog').style.display = 'none';
			} else
			{
				$("#copyrightlog").css("display", "block");	
			}
            if ((CfgMode.toUpperCase() == 'TS2') || (CfgMode.toUpperCase() == 'TS') || (CfgMode.toUpperCase() == 'TS2WIFI')) {
                $("#brandlog").css("background", "url(../../../images/logo_ts.jpg) no-repeat center");
                $("#brandlog").css("background-size", "80%");
                $("#brandlog").css("width", "155px");
                $("#brandlog").css("height", "70px");
                $("#ProductName").css("line-height", "95px");
            }
            if (CfgMode.toUpperCase() == "UMNIAHPAIR") {
                $("#brandlog").css("background", "url(../../../images/headerlogo_umniah.gif) no-repeat center");
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
                $("#brandlog").css("float", "right"); 
                $("#brandlog").css("background", "url(../../../images/telesur-colored.png) no-repeat center");
                $("#brandlog").css("width", "105px"); 
                $("#brandlog").css("height", "45px"); 
                $("#brandlog").css("background-size", "contain");
                $("#brandlog").css("background-position", "center center");  
            }
            if (CfgMode.toUpperCase() == "CMHK") {
                $("#brandlog").css("background", "url(../../../images/CMHKlogo.jpg) no-repeat center");
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
    </script>

</body>
</html>
