 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style type="text/css">
#pccframeWarpContent {
	height: 610px;
}
</style>

<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title></title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, lanservicecfg_language);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="JavaScript" type="text/javascript">
var CurrentLANPortList = new Array();
var TopoInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Topo,X_HW_EthNum|X_HW_SsidNum,TopoInfo);%>;
var TopoInfo = TopoInfoList[0];
TopoInfo.EthNum = '<%GetLanPortNum();%>';
var RegNewPageFlag = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT_NEW);%>";
var RegPageFlag = "<%HW_WEB_GetFeatureSupport(FT_MULTI_SERVICE_IPTV_PORT);%>";
var fttrmainflag = "<%HW_WEB_GetFeatureSupport(FT_FTTR_MAIN_ONT);%>";
var isGuidePage = false;
var curUserType = '<%HW_WEB_GetUserType();%>';
var jiuzhouFlag = '<%WEB_GetJiuZhouFlag();%>';
var timer = [];

if(window.parent.wifiPara != null)
{
	isGuidePage = true;
}

function TopoInfo(Domain, EthNum, SSIDNum)
{   
    this.Domain = Domain;
    this.EthNum = EthNum;
    this.SSIDNum = SSIDNum;
}

function adjustParentHeight()
{
    adjustFrameHeight("pccframeWarpContent", "pccframeContent", 20);
}

function LoadFrame()
{
	document.getElementById("pccframeContent").src="/html/bbsp/lanservicecfg/lanportcfg.asp";
	if (isGuidePage) {
		setDisplay("pagetitlecontent_span", 0);
		$(".mainbody").css("background-color", "#FFFFFF");
		$("#pccframeWarpContent").css("height", "auto");
		$("#lanserviceInfo").css("margin-left", "20px");
		setDisplay("btlanportapply", 0);
		$("#lanserviceInfo_content").css("color", "#666666");
		timer.push(setInterval("adjustParentHeight();", 50));
	}

	return;
}

</script>
</head>
<body  onLoad="LoadFrame();" class="mainbody">
	<div id="DivContent" style="display:block">
	<div id="LanPortHeadID">
	<table width="100%" height="0" border="0" cellpadding="0" cellspacing="0">
		<script language="JavaScript" type="text/javascript">
		if (isGuidePage == 1) {
			document.write('<div id="lanserviceInfo" class="PageTitle">');
			document.write('<div id="lanserviceInfo_title" class="PageTitle_title">' + lanservicecfg_language["bbsp_lanservice_lanport_hg"] + '</div>');
			document.write('<div id="lanserviceInfo_content" class="PageTitle_content">' + lanservicecfg_language["bbsp_lanservice_lanport_note5"] + '</div></div>');
		} else if (fttrmainflag == 1) {
			var LanServiceSummaryArray = new Array(new stSummaryInfo("text",GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice_title1")),
										new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice__note")),
										new stSummaryInfo("text",GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice_lanport_note4") + "<br>"),
										null);
		} else if((RegPageFlag == 0) && (RegNewPageFlag == 1))
		{
			var tipshtml = (jiuzhouFlag == '1') ? "bbsp_lanservice_lanport_note3_jiuzhou" : "bbsp_lanservice_lanport_note3";
			var LanServiceSummaryArray = new Array(new stSummaryInfo("text",GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice_title")),
										new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice__note")),
										new stSummaryInfo("text",GetDescFormArrayById(lanservicecfg_language, tipshtml) + "<br>"),
										null);
		}
		else
		{
			var LanServiceSummaryArray = new Array(new stSummaryInfo("text",GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice_title")),
										new stSummaryInfo("img","../../../images/icon_01.gif", GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice__note")),
										new stSummaryInfo("text",GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice_lanport_note1") + "<br>"),
										new stSummaryInfo("text","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + GetDescFormArrayById(lanservicecfg_language, "bbsp_lanservice_lanport_note2")),
										null);
		}
		if (isGuidePage != 1) {
			HWCreatePageHeadInfo("lanserviceInfo", lanservicecfg_language["bbsp_lanservice_info"], LanServiceSummaryArray, true);
		}

		var addHtml = '';
		addHtml += '<div class="divsummaryicon"><img style ="width :20px" src = '+' ../../../images/icon_01.gif '+'></div>';
		addHtml +='<span>' + GetDescFormArrayById(lanservicecfg_language,"bbsp_lanservice__note") + '</span>';
		if (jiuzhouFlag == '1') {
			addHtml +='<div style ="margin-top: 4px;">' + GetDescFormArrayById(lanservicecfg_language,"bbsp_lanservice_note8_jiuzhou") + '</div>';
		} else {
			addHtml +='<div style ="margin-top: 4px;">' + GetDescFormArrayById(lanservicecfg_language,"bbsp_lanservice_note8") + '</div>';
		}
		$("#lanserviceInfo_content").append(addHtml);
       </script>
	</table>
	</div>
		<div id="pccframeWarpContent" style="height:900px">
			<iframe id="pccframeContent" frameborder="0" marginheight="0" marginwidth="0" scrolling="yes" width="100%" height="100%" />
		</div>
    </div>
</body>
</html>