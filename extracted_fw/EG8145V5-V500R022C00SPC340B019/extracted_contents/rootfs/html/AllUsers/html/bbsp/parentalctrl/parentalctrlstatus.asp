 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style type="text/css">

.head_title_VDF {
	border: #d9d9d9;
	font-family:"Trebuchet MS", Helvetica, sans-serif;
	background-color: #feffe0;
	font-size: 12px;
	font-weight: bold;
	text-align: center;
	color: #000;
	height: 18px;
	line-height: 16px;
}


#pccframeWarpContent {
	height: 610px;
}
</style>

<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>PCCstatus</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" type="text/javascript">


var IsPTVDFFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var Custom_cmcc_rms = '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_PARENTAL_CTRL);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';
var BinWord ='<%HW_WEB_GetBinMode();%>';
var isUrlFilCategory = '<%HW_WEB_GetFeatureSupport(FT_URLFIL_CATEGORY);%>';

function IsNeedAddSafeDesForBelTelecom(){
	if(1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0){
		return true;
	}
	
	return false;
}

var numpara1 = '';
var numpara2 = '';
if( window.location.href.indexOf("?") > 0)
{
    numpara1 = window.location.href.split("?")[1]; 
	numpara2 = window.location.href.split("?")[2]; 
}

function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++)
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		setObjNoEncodeInnerHtmlValue(b, parentalctrl_language[b.getAttribute("BindText")]);
	}
}

function LoadFrame()
{
	ClickAllInfo();
	loadlanguage();

	if (isUrlFilCategory == 1) {
		setDisplay("tdCategory", 1);
		setDisplay("tdCategorySpace", 1);
		setDisplay("tdCategoryLine", 1);
		setDisplay("tdCategoryEndSpace", 1);
		$("#middleSpace").css("width", "70%");
	}
}

function ClickAllInfo()
{
	if (CfgModeWord.toUpperCase() == 'PLPLAYAP') {
		document.getElementById("ParentalctrlAllInfo").style.color = "#6c43bf";
	} else {
		document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleClick").css("color");
	}
	document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleNoClick").css("color");
	if( window.location.href.indexOf("?") > 0 && (GetCfgMode().OSK == 1 || GetCfgMode().COMMON == 1))
	{
	document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlmac.asp?" + htmlencode(numpara1) +'?' + htmlencode(numpara2);
	}
	else
	{
	document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlmac.asp";
	}
}
function ClickTemplate()
{
	if (CfgModeWord.toUpperCase() == 'PLPLAYAP') {
		document.getElementById("ParentalctrlTemplate").style.color = "#6c43bf";
	} else {
		document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleClick").css("color");
	}
	document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrltemplate.asp";
}
function ClickCategory()
{
	document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleClick").css("color");
	document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlcategory.asp";
}
function ClickStatistics()
{
	if (CfgModeWord.toUpperCase() == 'PLPLAYAP') {
		document.getElementById("ParentalctrlStatistics").style.color = "#6c43bf";
	} else {
		document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleClick").css("color");
	}
	document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleNoClick").css("color");
	document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleClick").css("color");
	document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlStat.asp";
}

function showdiag()
{
	var d = document.getElementById("diag");
	d.style.left  =20;
	d.style.top =0;
	var srcUrl = document.getElementById("pccframeContent").src;
	if ((isUrlFilCategory == 1) && (srcUrl.indexOf("/html/bbsp/parentalctrl/parentalctrltemplate.asp") >= 0)) {
		$("#diag").css("height", '1000px');
	} else {
		$("#diag").css("height", '800px');
	}
	d.style.display = "block";
}
function closeDiag()
{
	var d = document.getElementById("diag");
	d.style.display = "none";
}

function adjustParentHeight(containerID, newHeight)
{
	$("#DivContent").css("height", 'auto');
	var newHeight1 = (newHeight > 700) ? newHeight : 700;
	$("#" + containerID).css("height", newHeight1 + "px");

	if ((navigator.appName.indexOf("Internet Explorer") == -1)
		&& (containerID == "pccframeWarpContent"))
	{
		var height1 = document.body.scrollHeight;
		var height = (height1 > 700) ? height1 : 700;
		$("#DivContent").css("height", height + "px");
	}
}

if( Custom_cmcc_rms == 1 )
{
	parentalctrl_language['bbsp_FAQA2info2'] = parentalctrl_language['bbsp_FAQA2info2cmcc'];
}

</script>
</head>
<body  onLoad="LoadFrame();" class="mainbody">
	<div id="DivContent" style="display:block">
		<table width="100%" height="0" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr>
		<script language="JavaScript" type="text/javascript">
		if (IsNeedAddSafeDesForBelTelecom() == true) {
			HWCreatePageHeadInfo("parental", GetDescFormArrayById(parentalctrl_language, "bbsp_mune"), GetDescFormArrayById(parentalctrl_language, "bbsp_parental_control_title") + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>", false);
		} else if ((CfgModeWord == "CNT") || (CfgModeWord == "CNT2")) {
            HWCreatePageHeadInfo("parental", GetDescFormArrayById(parentalctrl_language, "bbsp_mune"), GetDescFormArrayById(parentalctrl_language, "bbsp_parental_control_title_cnt"), false);
        } else if (('<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>' == 1) && (BinWord.toUpperCase() == 'A8C')) {
            HWCreatePageHeadInfo("parental", GetDescFormArrayById(parentalctrl_language, "bbsp_mune"), GetDescFormArrayById(parentalctrl_language, "bbsp_parental_control_title_a8c"), false);
        } else {
			HWCreatePageHeadInfo("parental", GetDescFormArrayById(parentalctrl_language, "bbsp_mune"), GetDescFormArrayById(parentalctrl_language, "bbsp_parental_control_title"), false);
		}
    	</script>
		</table>  
	   <div class="title_spread"></div>

		<table>
			<tr>
				<td width="5%" class="TagTitle1"><a id="ParentalctrlAllInfo" href="#" name="ParentalctrlAllInfo" onClick="ClickAllInfo();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_all']); </script></span></a></td>
				<td class="TagLineSpace"></td>
				<td class="TagLine">|</td>
				<td class="TagLineSpace"></td>
				<td width="5%"><a id="ParentalctrlTemplate" href="#" name="ParentalctrlTemplate" onClick="ClickTemplate();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_template']); </script></span></a></td>
				<td class="TagLineSpace"></td>
				<td class="TagLine">|</td>
				<td class="TagLineSpace"></td>
				<td width="5%" id="tdCategory" style="display:none;"><a id="ParentalctrlCategory" href="#" name="ParentalctrlCategory" onClick="ClickCategory();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_category']); </script></span></a></td>
				<td class="TagLineSpace" id="tdCategorySpace" style="display:none;"></td>
				<td class="TagLine" id="tdCategoryLine" style="display:none;">|</td>
				<td class="TagLineSpace" id="tdCategoryEndSpace" style="display:none;"></td>
				<td width="5%"><a id="ParentalctrlStatistics" href="#" name="ParentalctrlStatistics" onClick="ClickStatistics();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_stat']); </script></span></a></td>
				<td width="75%" id="middleSpace"></td>
				<td width="10%"><a id="Parentalctrlhelp" href="#" name="Parentalctrlhelp" onClick="showdiag();"><script> document.write(parentalctrl_language['bbsp_help']); </script></a></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr ><td height="10">
			<div id="tagclick" class="TagTitleClick"></div>
			<div id="tagnoclick" class="TagTitleNoClick"></div>
			</td></tr>
		</table>

		<div id="diag" width="100%" class = "diaghelp" onClick="closeDiag();">
			<table  id="TableHelp"   width="100%" border="0" cellpadding="0" cellspacing="0">
				<script language="JavaScript" type="text/javascript">
				    if (IsPTVDFFlag == '1')
				    {
				    	document.write('<tr class="head_title_VDF">');
					}
					else if ('<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>' == 1)
					{
						document.write('<tr class="head_title">');
					}
				    else
				    {
				    	document.write('<tr class="head_helptitle">');
					}
				</script>
					<td class='align_left' colspan="2" BindText ='bbsp_pcchelptitle'></td>
				</tr>
				<tr>
					<td class="table_helptitle" BindText ='bbsp_pcchelpinfo'> </td>
				</tr>

				<script language="JavaScript" type="text/javascript">
				    if (IsPTVDFFlag == '1')
				    {
				    	document.write('<tr class="head_title_VDF">');
				    }
				    else if ('<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>' == 1)
				    {
				    	document.write('<tr class="head_title">');
				    }
				    else
				    {
				    	document.write('<tr class="head_helptitle">');
					}
				</script>
					<td class='align_left' colspan="2" BindText ='bbsp_template'></td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_pcchelptempalteinfo1'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpexplain'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo2'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo3'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo4'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo5'> </td>
				</tr>

				<script language="JavaScript" type="text/javascript">
				    if (IsPTVDFFlag == '1')
				    {
				    	document.write('<tr class="head_title_VDF">');
				    }
				    else if ('<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>' == 1)
				    {
				    	document.write('<tr class="head_title">');
				    }
				    else
				    {
				    	document.write('<tr class="head_helptitle">');
					}
				</script>
					<td class='align_left' colspan="2" BindText ='bbsp_all'></td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_pcchelpallinfo1'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpexplain'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpallinfo2'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpallinfo3'> </td>
				</tr>

				<script language="JavaScript" type="text/javascript">
				    if (IsPTVDFFlag == '1')
				    {
				    	document.write('<tr class="head_title_VDF">');
				    }
				    else
				    {
				    	document.write('<tr class="head_helptitle">');
					}
				</script>
					<td class='align_left' colspan="2" BindText ='bbsp_stattitle'></td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_statinfo1'> </td>
				</tr>

				<script language="JavaScript" type="text/javascript">
				    if (IsPTVDFFlag == '1')
				    {
				    	document.write('<tr class="head_title_VDF">');
					}
					else if ('<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>' == 1)
					{
						document.write('<tr class="head_title">');
					}
				    else
				    {
				    	document.write('<tr class="head_helptitle">');
					}
				</script>
					<td class='align_left' colspan="2" BindText ='bbsp_FAQtitle'></td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQQ1info'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA1info1'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA1info2'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA1info3'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQQ2info'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA2info1'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA2info2'> </td>
				</tr>
				<tr>
					<td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA2info3'> </td>
				</tr>
			</table>
		</div>

		<div id="pccframeWarpContent">
			<iframe id="pccframeContent" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" width="100%" height="100%" />
		</div>
	</div>
</body>
</html>
