<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>PCCCategoryUrlList</title>
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

var urlCategoryId = '1';
var CurPage = 0;
var para;
var para1;
var paraCategory;
var selectindex = -1;

if (window.location.href.indexOf("?") > 0) {
	if (window.location.href.indexOf("id") != -1) {
		para = window.location.href.split("?"); 
		para = para[para.length -1];
		para1 = para.split("&");
		if (para1.length == 1) {
			paraCategory = para1[0];
			urlCategoryId = paraCategory.split("=")[1];
		} else if (para1.length == 2) {
			CurPage = para1[0];
			paraCategory = para1[1];
			urlCategoryId = paraCategory.split("=")[1];
		}
	}
}

var currentFile = 'categoryUrlList.asp';
var UrlArray = GetUrlArrayByCategory(urlCategoryId);
var UrlArrayNr = UrlArray.length;
var MAX_URLS = 32;
var firstpage = 1;
var list = 10;
if (UrlArrayNr == 0) {
	firstpage = 0;
}
var lastpage = UrlArrayNr/list;
if (lastpage != parseInt(lastpage,10)) {
	lastpage = parseInt(lastpage,10) + 1;
}

var page = firstpage;
if (window.location.href.indexOf("?") > 0) {
    page = parseInt(CurPage,10);
}

if (page < firstpage) {
	page = firstpage;
} else if (page > lastpage) {
	page = lastpage;
}

function IsValidPage(pagevalue) {
	if (true != isInteger(pagevalue)) {
		return false;
	}
	return true;
}
function submitfirst() {
	page = firstpage;
	
	if (false == IsValidPage(page))	{
		return;
	}
	window.location= currentFile + "?" + parseInt(page,10)+ '&id=' + urlCategoryId;
}

function submitprv() {
	if (false == IsValidPage(page))	{
		return;
	}
	page--;
	window.location = currentFile + "?" + parseInt(page,10)+ '&id=' + urlCategoryId;
}

function submitnext() {
	if (false == IsValidPage(page))	{
		return;
	}
	page++;
	window.location= currentFile + "?" + parseInt(page,10)+ '&id=' + urlCategoryId;
}

function submitlast() {
	page = lastpage;
	if (false == IsValidPage(page))	{
		return;
	}
	
	window.location= currentFile + "?" + parseInt(page,10)+ '&id=' + urlCategoryId;
}

function submitjump() {
	var jumppage = getValue('pagejump');
	if ((jumppage == '') || (isInteger(jumppage) != true)) {
		setText('pagejump', '');
		return;
	}
	
	jumppage = parseInt(jumppage, 10);
	if (jumppage < firstpage) {
		jumppage = firstpage;
	}
	if (jumppage > lastpage) {
		jumppage = lastpage;
	}
	window.location= currentFile + "?" + jumppage+ '&id=' + urlCategoryId;
}

function LoadFrame() {
}

function showlist(startlist , endlist) {
	var TableDataInfo = new Array();
	var i = 0;
	var UrlListlen = 0;
	
	if (UrlArrayNr == 0) {
		TableDataInfo[UrlListlen] = new CategoryUrlShowClass();
		TableDataInfo[UrlListlen].domain = '--';
		TableDataInfo[UrlListlen].UrlAddress = '--';
		TableDataInfo.push(null);
		HWShowTableListByType(1, "urlListTblId", ShowButtonFlag, ColumnNum, TableDataInfo, UrlListConfiglistInfo, parentalctrl_language, null);
		return;
	}

	for (i = startlist; i <= endlist - 1; i++) {
		TableDataInfo[UrlListlen] = new CategoryUrlShowClass();
		TableDataInfo[UrlListlen].domain = UrlArray[i].domain;
		TableDataInfo[UrlListlen].UrlAddress = UrlArray[i].urlAddress;
		UrlListlen++;
	}
	TableDataInfo.push(null);
	HWShowTableListByType(1, "urlListTblId", ShowButtonFlag, ColumnNum, TableDataInfo, UrlListConfiglistInfo, parentalctrl_language, null);
}

function showlistcontrol() {	
	if (UrlArrayNr == 0) {
		showlist(0, 0);
	} else if (UrlArrayNr >= list*parseInt(page,10)) {
		showlist((parseInt(page,10)-1)*list, parseInt(page,10)*list);
	} else {
		showlist((parseInt(page,10)-1)*list, UrlArrayNr);
	}
}

function urlListTblIdselectRemoveCnt() {
}

function setControl(index)
{
	selectindex = index;

	if (selectindex < -1) {
		adjustParentHeight();
		return;
	}

	if (selectindex == -1) {
		if (UrlArrayNr >= MAX_URLS)	{
			DeleteLineRow();
			AlertEx(parentalctrl_language["bbsp_maxurl"]);
			window.location= currentFile + "?" + parseInt(page,10)+ '&id=' + urlCategoryId;
			return ;
		}

		setText("UrlAddress", "");
	} else {
		setText("UrlAddress", UrlArray[(page-1)*list+selectindex].urlAddress);
	}
	setDisplay('UrlTableConfigInfo', 1);
	adjustParentHeight();
	return;
}

function DeleteLineRow() {
    var tableRow = getElementById("urlListTblId_tbl");
    if (tableRow.rows.length > 2)
    tableRow.deleteRow(tableRow.rows.length-1);
    return false;
}

function adjustParentHeight() {
	var dh = getHeight(document.getElementById("urlAddrListForm"));
	var dh1 = getHeight(document.getElementById("UrlTableConfigInfo"));
	var height = 450 + (dh > 0 ? dh : 0) + (dh1 > 0 ? dh1 : 0);
	window.parent.adjustParentHeight("frameUrlAddrList", height);
}

function clickRemove() {
	if (UrlArray.length == 0) {
		AlertEx(parentalctrl_language['bbsp_nourladdress']);
		document.getElementById("DeleteButton").disabled = false;
		return;
	}

	var rml = getElement('urlListTblIdrml');
	var noChooseFlag = true;
	if (rml.length > 0)	{
		for (var i = 0; i < rml.length; i++) {
			if (rml[i].checked == true) {
                noChooseFlag = false;				 
			}
		}
	} else if (rml.checked == true)	{
		noChooseFlag = false;
	}
	if (noChooseFlag) {
		AlertEx(parentalctrl_language['bbsp_selecturladdr']);
		document.getElementById("DeleteButton").disabled = false;
		return;
	}

	if (ConfirmEx(parentalctrl_language['bbsp_delurladdr']) == false) {
		document.getElementById("DeleteButton").disabled = false;
		return;
	}
	removeInst();
}

function removeInst() {
    var rml = getElement('urlListTblIdrml');
    var Onttoken = getValue('onttoken');
	if (rml == null)
	    return;

	var cnt = 0;
	var str = "";
	with (document.forms[0]) {
		if (rml.length > 0)	{
			for (var i = 0; i < rml.length; i++) {
				if (rml[i].checked == true)	{
					cnt++;
					if (cnt > 1) {
						str += '&';
					}
					str += rml[i].value + '=' + '';
				}
			}
		} else if (rml.checked == true)	{
			str += rml.value + '=' + '';
			cnt++;
		}
	}

    str += '&x.X_HW_Token=' + Onttoken;
    var action = '';
	action = 'del.cgi?';

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : str,
		url :  action + '&RequestFile=/html/bbsp/parentalctrl/categoryUrlList.asp',
		error:function(XMLHttpRequest, textStatus, errorThrown)
		{
			if(XMLHttpRequest.status == 404)
			{
			}
		}
	});
	window.location = currentFile + "?" + parseInt(page,10)+ '&id=' + urlCategoryId;
}

function CheckForm() {
	var urlAddress = getValue('UrlAddress');
	
	if (selectindex == -1) {
		for (var i = 0; i < UrlArrayNr; i++) {
			if (urlAddress.toUpperCase() == (UrlArray[i].urlAddress).toUpperCase())	{
				AlertEx(parentalctrl_language["bbsp_repeaturladdress"]);
				return false;
			}
		}
	}

	return true;
}

function OnApply() {
	if (CheckForm() == false) {
		return;
	}
	
	setDisable("ButtonApply", 1);
	setDisable("ButtonCancel", 1);

	var urlAddress = getValue('UrlAddress');
	var action = '';
	if (selectindex == -1) {
		action = 'add.cgi?' + 'x=InternetGatewayDevice.X_HW_Security.ParentalCtrl.URLCategory.' + urlCategoryId + '.URLList' + '&RequestFile=html/bbsp/parentalctrl/categoryUrlList.asp';
	} else {
		action = 'set.cgi?x=' + UrlArray[(page-1)*list+selectindex].domain + '&RequestFile=html/bbsp/parentalctrl/categoryUrlList.asp';
	}

	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		data : 'x.URLAddress=' + urlAddress +'&x.X_HW_Token='+ getValue('onttoken'),
		url :  action,
		error:function(XMLHttpRequest, textStatus, errorThrown) 
		{
		}
	});
	
	window.location = currentFile + "?" + parseInt(page,10)+ '&id=' + urlCategoryId;
}

function OnCancel() {
	var tableName = 'urlListTblId';
	if (selectindex == -1) {
		var tableRow = getElement(tableName);
		if (tableRow.rows.length == 1) {
		} else if (tableRow.rows.length == 2) {
			if (UrlArrayNr <= 0) {
				document.getElementById("UrlTableConfigInfo").style.display = "none";
			}
		} else {
			tableRow.deleteRow(tableRow.rows.length-1);
			selectLine(tableName + '_record_0');
		}
	} else {
		setDisplay('UrlTableConfigInfo', 0);
	}
}
</script>
</head>
<body onLoad="LoadFrame();" class="mainbody nomargin">
<div id="DivUrlAddrList">
<form id="urlAddrListForm">
	<script language="JavaScript" type="text/javascript">
	var UrlListConfiglistInfo = new Array(new stTableTileInfo("Empty", "width_per10", "DomainBox"),
										  new stTableTileInfo("bbsp_urladdr", "", "UrlAddress", false, 64), null);
	var ColumnNum = 2;
	var ShowButtonFlag = true;
	var UrlListTableConfigInfoList = new Array();	
	showlistcontrol();
	</script>
	<table class='width_100p' border="0" cellspacing="0" cellpadding="0" > 
		<tr > 
			<td > 
				<input name="first" id="first" class="PageNext jumppagejumplastbutton_wh_px" type="button" value="<<" onClick="submitfirst();"/> 
				<input name="prv" id="prv"  class="PageNext jumppagejumpbutton_wh_px" type="button" value="<" onClick="submitprv();"/> 
					<script language="JavaScript" type="text/javascript">
						if (false == IsValidPage(page)) {
							page = (0 == UrlValueArrayNr) ? 0 : 1;
						}
						document.write(parseInt(page,10) + "/" + lastpage);
					</script>
				<input name="next"  id="next" class="PageNext jumppagejumpbutton_wh_px" type="button" value=">" onClick="submitnext();"/> 
				<input name="last"  id="last" class="PageNext jumppagejumplastbutton_wh_px" type="button" value=">>" onClick="submitlast();"/> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<script> document.write(parentalctrl_language['bbsp_goto']); </script> 
				<input  type="text" name="pagejump" id="pagejump" size="2" maxlength="2" style="width:20px;" />
				<script> document.write(parentalctrl_language['bbsp_page']); </script>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="jump"  id="jump" class="PageNext jumpbutton_wh_px" type="button" onClick="submitjump();"></td>
				<script>setText("jump",parentalctrl_language["bbsp_jump"]);</script>
			</td>
		</tr> 
	</table> 
	<script> 
		if (page == firstpage) {
			setDisable('first',1);
			setDisable('prv',1);
		}
		if (page == lastpage) {
			setDisable('next',1);
			setDisable('last',1);
		}
	</script>
</form>

<form id="UrlTableConfigInfo" style="display:none">
<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%">
		<li   id="UrlAddress"                     RealType="TextBox"            DescRef="bbsp_urladdr"     RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.UrlAddress"   Elementclass="Inputclass"   InitValue="Empty"      MaxLength="64"/>
	</table>
	<script>
	UrlListConfigFormList = HWGetLiIdListByForm("UrlTableConfigInfo", null);
	var formid_hide_id = null;
	var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
	HWParsePageControlByID("UrlTableConfigInfo", TableClass, parentalctrl_language, formid_hide_id);
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
</form>
</div>
<script>
	ParseBindTextByTagName(parentalctrl_language, "td", 1);
	ParseBindTextByTagName(parentalctrl_language, "div", 1);
	ParseBindTextByTagName(parentalctrl_language, "input", 2);
</script>
</body>
</html>