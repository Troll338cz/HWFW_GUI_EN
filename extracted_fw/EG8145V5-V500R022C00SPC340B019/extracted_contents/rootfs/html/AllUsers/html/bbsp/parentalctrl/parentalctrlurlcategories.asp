<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style type="text/css">
.nomargin {
	margin-left: 0px;
	margin-right:0px;
	margin-top: 0px;
}
</style>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/parentalctrlinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>

<title>URL Category Filter</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="JavaScript" type="text/javascript">

document.onkeydown = function(e)
{
	if( !e )
	e = window.event;
	if (e.keyCode == 13 || e.which == 13)
	{
		return false;
	}
	
	return true;
}
var TableName = "UrlCategoryList";

var FlagStatus = "";
var LastAddInst = "<%HW_WEB_GetLastAddInstNum();%>";

var para = "";
var para1 = "";
var paraTemplate = "";
var paraFlagStatus = "";
var CurTemplateId = "";

if( window.location.href.indexOf("?") > 0)
{
	if (window.location.href.indexOf("TemplateId") != -1)
	{
		para = window.location.href.split("?"); 
		para = para[para.length -1];
		para1 = para.split("&"); 
		if (para1.length == 2)
		{
			paraTemplate = para1[0];
			paraFlagStatus = para1[1];
			CurTemplateId = paraTemplate.split("=")[1];
			FlagStatus = paraFlagStatus.split("=")[1];
		}
		else if (para1.length == 3)
		{
			paraTemplate = para1[1];
			paraFlagStatus = para1[2];
			CurTemplateId = paraTemplate.split("=")[1];
			FlagStatus = paraFlagStatus.split("=")[1];
		}
	}
}
else
{
	para = LastAddInst.split(";");
	para = para[para.length -1];
	CurTemplateId = para.split(":")[1];
	FlagStatus = "AddTemplate";
}

var TemplatesListArray = GetTemplatesList();

function OnUrlFinsh() {
	window.location='/html/bbsp/parentalctrl/parentalctrltemplate.asp';
}

function loadlanguage() {
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = parentalctrl_language[b.getAttribute("BindText")];
	}
}

function adjustParentHeight() {
	var dh = getHeight(document.getElementById("DivContent"));    
	var height = 200 + (dh != null ? dh : 0);
	window.parent.adjustParentHeight("pccframeWarpContent", height);
}

function LoadFrame() {
	if (FlagStatus == "AddTemplate") {
		SetDivValue("DivUrlCategoryTitle",parentalctrl_language['bbsp_step4']);
		document.getElementById("ButtonFinsh").innerHTML = parentalctrl_language['bbsp_finsh'];
	} else if (FlagStatus == "EditTemplate") {
		SetDivValue("DivUrlCategoryTitle",parentalctrl_language['bbsp_restrictedcategories']);
		document.getElementById("ButtonFinsh").innerHTML = parentalctrl_language['bbsp_return'];
	}
	
	loadlanguage();
	
	var output = '<input id="UrlCategoryList_rml" type="checkbox" name="UrlCategoryListrml" onclick="UrlCategoryListselectRemoveCnt(this);" value="">';
	$("#headUrlCategoryList_0_0").append(output);
	$("#headUrlCategoryList_0_0").css("text-align", "left");

	InitCategoryFiltList();
}

function showlistcontrol() {
	var TableDataInfo = new Array();
	var UrlListlen = 0;
	
	TableDataInfo[UrlListlen] = new CategoryListClass();
	TableDataInfo[UrlListlen].domain = "";
	TableDataInfo[UrlListlen].categoryName = "No Restrictions";
	UrlListlen++;
	for (var i = 0; i < CategoryListArrayNr; i++) {
		TableDataInfo[UrlListlen] = new CategoryListClass();
		TableDataInfo[UrlListlen].domain = CategoryListArray[i].domain;
		TableDataInfo[UrlListlen].categoryName = CategoryListArray[i].categoryName;
		UrlListlen++;
	}
	TableDataInfo.push(null);
	HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, UrlCategorylistInfo, parentalctrl_language, null);
}

function OnApply() {
	var rml = getElement('UrlCategoryListrml');
	var filterUrlList = "";
	for (var i = 2; i < rml.length; i++) {
		if (rml[i].checked == true) {
			filterUrlList += GetCategoryNameByDomain(rml[i].value) + ",";
		}
	}
	if (filterUrlList != "") {
		filterUrlList = filterUrlList.substr(0, filterUrlList.length-1);
	}
	if (rml[1].checked == true) {
		filterUrlList = "";
	}
	
	setDisable("ButtonApply", 1);
	setDisable("ButtonCancel", 1);
	
	var action;
	action = 'set.cgi?x=InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.' + CurTemplateId + '&RequestFile=html/bbsp/parentalctrl/parentalctrlurlcategories.asp';

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : 'x.URLCategoryFilterList=' + filterUrlList +'&x.X_HW_Token='+ getValue('onttoken'),
		url :  action,
		error:function(XMLHttpRequest, textStatus, errorThrown) 
		{
		}
	});
	
	window.location='/html/bbsp/parentalctrl/parentalctrlurlcategories.asp'+'?TemplateId='+CurTemplateId+'&FlagStatus='+FlagStatus;
}
</script>

</head>
<body  onLoad="LoadFrame();" class="mainbody nomargin">
<div id="DivContent" style="display:block"> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="func_title" >
		<tr> 
			<td class="align_left" >
				<div id="DivUrlCategoryTitle"></div>
			</td> 
		</tr>
	</table>

	<form id="CategoryFilterConfigForm">
		<script language="JavaScript" type="text/javascript">
			var UrlCategorylistInfo = new Array(new stTableTileInfo("Empty","","DomainBox"),									
												new stTableTileInfo("bbsp_categorylisttitle","","categoryName",false, 64),null);
			var ColumnNum = 2;
			var ShowButtonFlag = false;
			showlistcontrol();
		</script>
		
		<table cellpadding="0" cellspacing="0"  width="100%" class="table_button">
			<tr>
				<td class="table_submit" style="text-align:center">		 
						<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
						<button type="button" id='ButtonApply' onclick="OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(parentalctrl_language['bbsp_app']);</script> </button>
						&nbsp;
						<button type="button" id='ButtonCancel' onclick="OnCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(parentalctrl_language['bbsp_cancel']);</script> </button>
				</td>
			</tr>
		</table>
	
		<table id="tabBtnFinsh" cellpadding="0" cellspacing="0"  width="100%" class="table_button"> 
			<tr> 
			  <td width="90%"></td>
			  <td class="align_right table_submit" style="text-align:center">
				   <button type="button" id='ButtonFinsh' onclick="OnUrlFinsh();" class="ApplyButtoncss buttonwidth_100px" value=""></button>
			  </td>
			</tr> 
		</table>
	</form>
</div>
<script language="javascript">
function setControl() {

}

function SetAllCheck(checkVal) {
	var rml = getElement('UrlCategoryListrml');
	for (var i = 0; i < rml.length; i++) {
		if (i == 0) {
			setCheck("UrlCategoryList_rml"+i, !checkVal);
		} else {
			setCheck("UrlCategoryList_rml"+i, checkVal);
		}
	}
}

function OnCheckNoRestrictions(checkVal) {
	var rml = getElement('UrlCategoryListrml');
	setCheck("UrlCategoryList_rml", 0);
	for (var i = 1; i < rml.length; i++) {
		setCheck("UrlCategoryList_rml"+i, 0);
	}
}

function IsNoCategoryChecked(checkBoxId) {
	var noBoxChecked = true;
	var rml = getElement('UrlCategoryListrml');
	for (var i = 2; i < rml.length; i++) {
		if (rml[i].id == checkBoxId) {
			continue;
		}
		if (rml[i].checked == true) {
			noBoxChecked = false;
			break;
		}
	}
	return noBoxChecked;
}

function IsAllCategoryChecked(checkBoxId) {
	var isAllChecked = true;
	var rml = getElement('UrlCategoryListrml');
	for (var i = 2; i < rml.length; i++) {
		if (rml[i].id == checkBoxId) {
			continue;
		}
		if (rml[i].checked == false) {
			isAllChecked = false;
			break;
		}
	}
	return isAllChecked;
}

function UrlCategoryListselectRemoveCnt(val) {
	if (val.id == "UrlCategoryList_rml") {
		SetAllCheck(val.checked);
	} else if (val.id == "UrlCategoryList_rml0") {
		if (val.checked == true) {
			OnCheckNoRestrictions();
		}
	} else {
		if (val.checked == true) {
			setCheck("UrlCategoryList_rml0", 0);
			if (IsAllCategoryChecked(val.id)) {
				setCheck("UrlCategoryList_rml", 1);
			}
		} else {
			if (IsNoCategoryChecked(val.id)) {
				setCheck("UrlCategoryList_rml0", 1);
			}
			setCheck("UrlCategoryList_rml", 0);
		}
	}
}

function InitCategoryFiltList() {
	var categoryFiltList = GetCategoryFiltList(CurTemplateId);
	var rml = getElement('UrlCategoryListrml');
	for (var i = 0; i < rml.length; i++) {
		setCheck(rml[i].id, 0);
	}
	
	var sites = categoryFiltList.split(",");
	if ((sites.length <= 0) || ((sites.length == 1) && (sites[0] == ""))) {
		setCheck(rml[1].id, 1);
		return;
	}

	var curSites = "";
	var j;
	for (var i = 2; i < rml.length; i++) {
		curSites = GetCategoryNameByDomain(rml[i].value);
		for (j = 0; j < sites.length; j++) {
			if (curSites == sites[j]) {
				setCheck(rml[i].id, 1);
				break;
			}
		}
	}
	if (CategoryListArrayNr == sites.length) {
		setCheck("UrlCategoryList_rml", 1);
	}
}

function OnCancel()
{
	InitCategoryFiltList();
}
</script> 

<br> 
<br> 

</body>
</html>