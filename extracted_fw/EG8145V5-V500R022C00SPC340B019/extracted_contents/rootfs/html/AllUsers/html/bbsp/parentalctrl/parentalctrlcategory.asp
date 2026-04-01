<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>PCCCategory</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/time.asp"></script>
<script language="javascript" src="../common/parentalctrlinfo.asp"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<style>
.nomargin {
	margin-left: 0px;
	margin-right:0px;
	margin-top: 0px;
}
</style>
<script language="JavaScript" type="text/javascript">
var resizeTimer;

function LoadFrame() {
}

function WriteCategoryListOption() {
	var output = '';
	for (var i = 0; i < CategoryListArrayNr; i++)
	{
		output = '<option value=\"' + htmlencode(CategoryListArray[i].domain) + '">' + htmlencode(CategoryListArray[i].categoryName) + '</option>';
		$("#CategoryList").append(output);
	}
}

function setControl() {
}

function OnCategoryListChange() {
	var categoryDomain = getSelectVal("CategoryList");
	var para = categoryDomain.split('.');
	urlCategoryId = para[para.length-1];
	document.getElementById("frameUrlAddrList").src = "categoryUrlList.asp?id=" + urlCategoryId;
}

function adjustParentHeight() {
	var dh = getHeight(document.getElementById("DivCategoryList"));
	var dh1 = getHeight(document.getElementById("DivCategoryUrlList"));
	var height = 200 + (dh != null ? dh : 0) + (dh1 != null ? dh1 : 0);

	window.parent.adjustParentHeight("pccframeWarpContent", height);
}

window.clearInterval(resizeTimer);
function resizeUrlListHeight() {
	var theIframe = document.getElementById('frameUrlAddrList');
	var urlListTable = document.getElementById('frameUrlAddrList').contentWindow.document.getElementById("DivUrlAddrList");
	if (null == urlListTable) {
		return;
	}
	var dh = getHeight(urlListTable);
	var theHeight = (dh > 0 ? dh : 0);

	if (theIframe.height != theHeight) {
		theIframe.height = theHeight;
		adjustParentHeight();
	}
}
resizeTimer = window.setInterval("resizeUrlListHeight()", 200);
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody nomargin">
<div id="DivCategoryList">
	<div id="CategoryListTitle" class="func_title" BindText="bbsp_categorytitle"></div>
	<form id="TableCategoryInfo">
		<table border="0" cellpadding="0" cellspacing="1"  width="100%">
			<li   id="CategoryList"                     RealType="DropDownList"       DescRef="bbsp_categorylist"        RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.URLCategory"         InitValue="Empty" ClickFuncApp="onchange=OnCategoryListChange"/>
		</table>
		<script>
			var formid_hide_id = null;
			var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
			HWParsePageControlByID("TableCategoryInfo", TableClass, parentalctrl_language, formid_hide_id);
			WriteCategoryListOption();
		</script>
	</form>
</div>

<div id="DivCategoryUrlList">
	<div class="func_spread"></div>

	<div id="DivUrlTitle" class="func_title" BindText=""></div>

	<iframe id="frameUrlAddrList" src="categoryUrlList.asp" class='width_per100' frameborder="0" marginheight="0" marginwidth="0" scrolling="no">
	</iframe>

	<div class="func_spread"></div>
</div>

<script>
	ParseBindTextByTagName(parentalctrl_language, "td", 1);
	ParseBindTextByTagName(parentalctrl_language, "div", 1);
	ParseBindTextByTagName(parentalctrl_language, "input", 2);
</script>
</body>
</html>
