<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="background-color:#d3d3d3;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_CleanCache_Resource(ajaxconfig.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>VOIP Call log</title>
<style>
[type="checkbox"]:not(:checked),
[type="checkbox"]:checked {
  left: -9999px;
  position: absolute;
}
[type="checkbox"]:not(:checked) + label,
[type="checkbox"]:checked + label {
  cursor: pointer;
  font-weight: normal;
  line-height: 20px;
  margin-bottom: 15px;
  padding-left: 25px;
  position: relative;
  z-index: 2;
}
[type="checkbox"]:not(:checked) + label::before,
[type="checkbox"]:checked + label::before {
  background-position: center center;
  background-repeat: no-repeat;
  border: 1px solid #808080;
  border-radius: 3px;
  content: "";
  height: 21px;
  left: 0;
  position: absolute;
  top: -2px;
  transition: all 0.2s ease 0s;
  width: 21px;
}
[type="checkbox"]:checked + label::before {
  background-color: #a8b400;
  background-image: url("../../../images/check-white.png");
  border: 1px solid rgba(0, 0, 0, 0.25);
}
[type="checkbox"]:not(:checked) + label::after,
[type="checkbox"]:checked + label::after {
  color: #fff;
  content: " ";
  left: 2px;
  position: absolute;
  top: -2px;
  transition: all 0.2s ease 0s;
}
[type="checkbox"]:not(:checked) + label::after {
  /* ?opacity: 0;*/
  transform: scale(0);
}
[type="checkbox"]:checked + label::after {
  opacity: 1;
  transform: scale(1);
}
[type="checkbox"]:disabled:not(:checked) + label::before,
[type="checkbox"]:disabled:checked + label::before {
  background-color: #ddd;
  border-color: #bbb;
  box-shadow: none;
}
[type="checkbox"]:disabled:checked + label::after {
  color: #999;
}
[type="checkbox"]:disabled + label {
  color: #aaa;
}

.tabs {
  background-color:#f8f8f8;
  cursor: pointer;
}


.grey-table-content {
  padding: 0 10px;
  margin: 0 -10px;
}

.more-columns {
  text-align: center;
  background-color: #f8f8f8;
  overflow: hidden;
}
.call-log > .table-row > .table-col {
  height: 50px;
}
.table-call-log-buttons {
  text-align: right;
  margin-top: 10px;
}
.table-button-faded {
  opacity: 0.3;
}
.faded {
  opacity: 0.3;
}

.hidden1,
.hidden2 {
  display: none;
}
.row {
font-weight: bold;
display: table-row;
line-height: 30px;
width: 100%;
}

/*call log pagination*/
.pagination {
  width: 100%;
  text-align: right;
  margin-top: 10px;
  hight:auto;
}

.pagination-arrows {
  width: 15px;
  height: 18px;
  border-radius: 3px;
  box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.6);
  display: table-cell;
  background-color: #ffffff;
  text-align: center;
  line-height: 23px;
  cursor: pointer;
  vertical-align: middle;
}
.arrow-left img {
  margin-top: 2px;
}
.arrow-right img {
  margin-top: 2px;
}
.pagination-arrows:hover {
  background-color: #F4F4F4;
  color: #000;
  -moz-box-shadow: rgba(0, 0, 0, 0.6);
  -webkit-box-shadow: rgba(0, 0, 0, 0.6);
  box-shadow: rgba(0, 0, 0, 0.6);
}
.pagination-arrows:active {
  background-color: #F4F4F4;
  color: #000;
  -moz-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
  -webkit-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
  box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
}



.pages {
  width: 40px;
  height: 18px;
  display: inline-block;
  text-align: center;
}
.content-call-log{
	margin-top:20px;
}
input.button {
  border-radius: 3px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.6);
  font-size: 16px;
  font-weight: bold;
  height: 28px;
  background-color: ffffff;
}
input.button.button-apply {
  background-color: #b141ad;
  color: #fff;
}
input.button.button-apply:hover {
  background-color: #680F68;
  color: #fff;
  -moz-box-shadow: rgba(0, 0, 0, 0.6);
  -webkit-box-shadow: rgba(0, 0, 0, 0.6);
  box-shadow: rgba(0, 0, 0, 0.6);
}
input.button.button-cancel:hover {
  background-color: #F4F4F4;
  color: #000;
  -moz-box-shadow: rgba(0, 0, 0, 0.6);
  -webkit-box-shadow: rgba(0, 0, 0, 0.6);
  box-shadow: rgba(0, 0, 0, 0.6);
}
input.button.button-apply:active {
  background-color: #680F68;
  color: #fff;
  -moz-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
  -webkit-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
  box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
}
input.button.button-cancel:active {
  background-color: #F4F4F4;
  color: #000;
  -moz-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
  -webkit-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
  box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6) inset;
}
#call-log-table-id table tr{
	border-top:1px solid #e6e6e6;
}

.row .left{
  display: table-cell;
  padding-top: 29px;
  padding-bottom: 20px;

}
.popup .apply-cancel {
  text-align: right;
}



.dropdownShowCss{
  height: 39px;
  line-height: 39px;
  text-align: left;
  border-radius: 4px;
  background: white;
  cursor: pointer;
  background-image:url("../../../images/arrow-down.png");
  background-position: center right;
  background-repeat: no-repeat;
  font-size: 16px;
}
.dropdownHide{
  margin:1px;
  width: 290px;
  line-height: 39px;
  list-style:none;
}
#IframeDropdown1{
    text-indent: 15px;
    border-radius: 3px;
    color: #333;
    box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.55);
    border: 0;
    font-size: 18px;
    font-weight: bold;
    top: 10px;
    left: 3px;
    z-index: 9;
	font-size:16px;
}
.dropdownHide li{
    width: 290px;
    height: 39px;
    line-height: 39px;
    border-top:none;
    text-align: left;
    cursor: pointer;
    background: #fff;
	font-size:16px;
}


</style>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, voipcalllog);%>"></script>
<script language="JavaScript" type="text/javascript"> 
var For_CallLogTotalCount = 0;

var temp = "";
var SameFlag = 0;
var rowjj = 0;
var LocalTelNum = "all";
var CallType = 0;
var CurrentPageNo = 1;
var PerPageCount = 0;
var TotalPageCount = 0;
var CallPageLog = 0;
var DeleteData = 0;

var CallPageLogMsg;
var CallPageLogHead;
var CallPageLogTail;
var PerPageEntryID;
var PerPageCallType;
var PerPageDate;
var PerPageTime;
var PerPagePeerNum;
var PerPagePhoneName;
var PerPageDuration;

var For_CallLogTotalCount1 = "";	
var For_CallLogTotalCount2 = "";
var CallLogTotalCount = 0;
var chosenRecordCount = 0;

LocalTelNum = "all";
CallType = 0;
CurrentPageNo = 1;


function DealJavaCodeForSingleJson(InputData)
{
	try{
		return JsonData = JSON.parse(hexDecode(InputData));
	}catch(e){
	return null;
	}
}

function HwQueryAjaxGetPara(LocalTelNum, CallType, PageIndex)
{
	var Result = null;
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : './GetMatchedCallLog.cgi?telnum=' + LocalTelNum + '&calltype=' + CallType + '&page=' + PageIndex,
	data :'x.X_HW_Token=' + getValue('onttoken1'),
	success : function(data) 
	{
		data = DealJavaCodeForSingleJson(data);
		if(null != data)
		{
			if(data.Result == 0)
				Result = data.CallLog;
		}
	}
	});

	try{
	return Result;
	}
	catch(e){
	return null; 
	}
}

function HwDeleteAjaxGetPara(EntryIdArray)
{
	var Result = null;
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : './DelMatchedCallLog.cgi?EntryIdArray=' + EntryIdArray,
    data :'x.X_HW_Token=' + getValue('onttoken1'),
	success : function(data) 
	{
		data = DealJavaCodeForSingleJson(data);
		if(null != data)
		{
			if(data.Result == 0)
				Result = 0;
		}
	}
	});

	try{
	return Result;
	}
	catch(e){
	return null; 
	}
}


function DeCodeCallPageLog(CallPageLog)
{
    
	if(CallLogTotalCount/10 == parseInt( CallLogTotalCount/10 ))
	{
		TotalPageCount = CallLogTotalCount/10;
	}
	else
	{
		TotalPageCount = parseInt( CallLogTotalCount/10 ) + 1;
	}
						
	CallPageLogMsg = CallPageLog.split(",");
	CallPageLogHead = CallPageLogMsg[0].split("|");
	LocalTelNum = CallPageLogHead[0];
	CallType = CallPageLogHead[1];
	CurrentPageNo = CallPageLogHead[2];
	PerPageCount = CallPageLogHead[3];
	
	CallPageLogTail = CallPageLogMsg[1].split("|");
	
	PerPageEntryID = new Array(PerPageCount);
	PerPageCallType = new Array(PerPageCount);
	PerPageDate = new Array(PerPageCount);
	PerPageTime = new Array(PerPageCount);
	PerPagePeerNum = new Array(PerPageCount);
	PerPagePhoneName = new Array(PerPageCount);
	PerPageDuration = new Array(PerPageCount);
	
	for ( var j = 0; j < PerPageCount; j++ )
	{
		var CallPageCallLogBody = CallPageLogTail[j].split(";");
		PerPageEntryID[j] = CallPageCallLogBody[0];
		PerPageCallType[j] = CallPageCallLogBody[1];
		PerPageDate[j] = CallPageCallLogBody[2];
		PerPageTime[j] = CallPageCallLogBody[3];
		PerPagePeerNum[j] = CallPageCallLogBody[4];
		PerPageDuration[j] = CallPageCallLogBody[6];
		PerPagePhoneName[j] = ((CallPageCallLogBody[5]));
	}
    
    
}

	
function LoadFrame()
{
	GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo);
}
function GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo)
{
	For_CallLogTotalCount = HwQueryAjaxGetPara(LocalTelNum, CallType, "0");
	For_CallLogTotalCount1 = For_CallLogTotalCount.split(",");
	For_CallLogTotalCount2 = For_CallLogTotalCount1[0].split("|");
	CallLogTotalCount = For_CallLogTotalCount2[3];
	if(CallLogTotalCount != 0)
	{
		CallPageLog = HwQueryAjaxGetPara(LocalTelNum, CallType, CurrentPageNo);
		DeCodeCallPageLog(CallPageLog);
	}
	else
	{
		PerPageEntryID = null;
		PerPageCallType = null;
		PerPageDate = null;
		PerPageDuration = null;
		PerPagePeerNum = null;
		PerPagePhoneName = null;
		PerPageTime = null;
		PerPageCount = 0;
		TotalPageCount = 0;
	}
}


LoadFrame();


function LoadCallLogBody()
{
	var html = ''; 
	
	for(var rowjj = 0; rowjj < PerPageCount; rowjj++)
	{
		var htmldirection = '';
		var temphtml = ''; 
		temphtml = '<tr class="table_right ">';
		if (( 2 == PerPageCallType[rowjj] )||( 3 == PerPageCallType[rowjj] ))
		{
			htmldirection = voipcalllog['vspa_callogIncoming'];
		}
		else
		{
			htmldirection = voipcalllog['vspa_callogOutgoing'];
		}
		
		html += temphtml;
				
		html += '<td>';  
		html += '   <span class="align_center">';  
		
		{
			html += htmlencode(PerPageDate[rowjj]);
		}
		html += '   </span>'; 
		html += '</td>'; 
		 
		html += '<td>'; 
		html += '   <span class="align_center">';  
		html +=        htmlencode(PerPageTime[rowjj]);
		html += '   </span>'; 
		html += '</td>'; 
		
		html += '<td>'; 
		html += '   <span class="align_center">'; 
		html +=        htmlencode(PerPagePeerNum[rowjj]); 
		html += '   </span>';
		html += '</td>';
		
		html += '<td>';
		html += '<span class="align_center">'; 
		html +=    htmlencode(htmldirection);  		
		html += '   </span>'; 
		html += '</td>'; 
		
		html += '<td>';  
		html += '   <span class="align_center">';  
		html +=        htmlencode(PerPagePhoneName[rowjj]); 
		html += '   </span>'; 
		html += '</td>'; 
		 
		html += '<td>';
		html += '   <span class="align_center">';
		html +=        htmlencode(PerPageDuration[rowjj]); 
		html += '   </span>';
		html += '</td>'; 		
		html += '</tr>'; 
		
	}
	return html;
}
function pageOnclick(pre_or_next)
{
	
	if(1 == pre_or_next)
	{
		if(CurrentPageNo <= 1)
		{
			return;
		}
		CurrentPageNo = parseInt(CurrentPageNo) - 1;
	}
	if(2 == pre_or_next)
	{
		if(CurrentPageNo >= TotalPageCount)
		{
			return;
		}
		CurrentPageNo = parseInt(CurrentPageNo) + 1;
	}
	GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo);
	InnerHtmlLoadTable();
	InnerHtmlLoadPage();
	InnerHtmlLoadBtn(false);
}
function LoadCallLogPage()
{
	var html = '';
	html += '<table>';
	html += '<tr>';
	html += '<td class="pages" style="font-family:Arial,sans-serif;width:613px;">';

	html += '</td>';
	if(CallLogTotalCount == 0)
	{
		CurrentPageNo = 0;
	}
	if(CurrentPageNo < 2)
	{
		html += '<td class="pagination-arrows arrow-left" style="opacity: 0.3; vertical-align:  middle;"  onclick="pageOnclick(1)">';
	}
	else
	{
		html += '<td class="pagination-arrows arrow-left" style="opacity: 1; vertical-align:  middle;" onclick="pageOnclick(1)">';
	}
	
	html += '<img src="../../../images/arrow-left.png" alt="">';
	html += '</td>';   

	html += '<td class="pages" style="font-family:Arial,sans-serif;">';
	html += CurrentPageNo;
	html += '&nbsp;';
	html += '/';
	html += '&nbsp;';
	html += TotalPageCount;
	html += '</td>';
	
	if(parseInt(CurrentPageNo) >= parseInt(TotalPageCount))
	{
		html += '<td class="pagination-arrows arrow-right" style="opacity: 0.3; vertical-align:  middle;" onclick="pageOnclick(2)">';
	}						
	else
	{
		html += '<td class="pagination-arrows arrow-right" style="opacity: 1; vertical-align:  middle;" onclick="pageOnclick(2)">';
	}
	html += '<img src="../../../images/arrow-right.PNG" alt="">';
	html += '</td>';
	if(CallLogTotalCount == 0)
	{
		CurrentPageNo = 1;
	}
	html += '</tr>';
	html += '</table>';
	return html;
}

function deleteBtnClick()
{
	if(ConfirmEx(voipcalllog['vspa_clearlogsalert']) == false)
	{
		return;
	}

	HwDeleteAjaxGetPara(DeleteData);

	CurrentPageNo = 1;
	GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo);

	InnerHtmlLoadTable();
	InnerHtmlLoadPage();
	InnerHtmlLoadBtn(false);	
}

function InnerHtmlLoadBtn(chosen)
{
	var btndiv_id = getElementById('btn_div_id');
	var divHtml = '';

	divHtml += '<input id="DeleteBtn" class="CancleButtonCss buttonwidth_150px_250px" style="font-family:Arial,sans-serif;" value="';
	
	divHtml += voipcalllog['vspa_itvdf_calllog_deleteBtn'];
	divHtml += '" type="button" onclick="deleteBtnClick()">';
	
	
	btndiv_id.innerHTML = '';
	btndiv_id.innerHTML = divHtml;
	var DeleteBtn = getElementById('DeleteBtn');

	DeleteBtn.disabled = false;
}
function InnerHtmlLoadPage()
{
	var pagination_id = getElementById('pagination_id');
	var divHtml = '';
	divHtml += LoadCallLogPage();
	pagination_id.innerHTML = '';
	pagination_id.innerHTML = divHtml;
}
function InnerHtmlLoadTable()
{
	var tableid = getElementById('call-log-table-id');
	var divHtml = '';
	divHtml += LoadTableHeadAndCallLogBody();
	tableid.innerHTML = '';
	tableid.innerHTML = divHtml;
}
function LoadTableHeadAndCallLogBody()
{		
	var divHtml = '';
	var trHeadHtml = '<table width="100%" height="5" border="0" cellpadding="0" cellspacing="1" class="tabal_bg" style="table-layout:fixed; word-break:break-all">';
	trHeadHtml += '<tr class="head_title">';
	
	var trHeadHtml_date = '<td class="width_per8">';
	trHeadHtml_date += '<span>';
	trHeadHtml_date += voipcalllog['vspa_callogdate'];
	trHeadHtml_date += '</span>';
	trHeadHtml_date += '</td>';
	
	var trHeadHtml_time = '<td class="width_per8">';
	trHeadHtml_time += '<span>';
	trHeadHtml_time += voipcalllog['vspa_callogtime'];
	trHeadHtml_time += '</span>';
	trHeadHtml_time += '</td>';
	
	var trHeadHtml_exterNum = '<td class="width_per13">';
	trHeadHtml_exterNum += '<span>';
	trHeadHtml_exterNum += voipcalllog['vspa_callogownNum'];
	trHeadHtml_exterNum += '</span>';
	trHeadHtml_exterNum += '</td>';

	var trHeadHtml_direction = '<td class="width_per8">';
	trHeadHtml_direction += '<span>';
	trHeadHtml_direction += voipcalllog['vspa_callogdirection'];
	trHeadHtml_direction += '</span>';
	trHeadHtml_direction += '</td>';
	
	var trHeadHtml_ownNum = '<td class="width_per13">';
	trHeadHtml_ownNum += '<span>';
	trHeadHtml_ownNum += voipcalllog['vspa_callogexterNum'];
	trHeadHtml_ownNum += '</span>';
	trHeadHtml_ownNum += '</td>';
	
	var trHeadHtml_duration = '<td class="width_per8">';
	trHeadHtml_duration += '<span>';
	trHeadHtml_duration += voipcalllog['vspa_callogduration'];
	trHeadHtml_duration += '</span>';
	trHeadHtml_duration += '</td>';

	trHeadHtml += trHeadHtml_date + trHeadHtml_time + trHeadHtml_exterNum + trHeadHtml_direction + trHeadHtml_ownNum + trHeadHtml_duration + '</tr>';
	
	var trBodyHtml = LoadCallLogBody();
	
	divHtml += trHeadHtml +trBodyHtml;
	divHtml += '</table>';
	return divHtml;
}
</script>
</head>
	<body class="mainbody">
		<script language="JavaScript" type="text/javascript">
			HWCreatePageHeadInfo("voipcalllog", GetDescFormArrayById(voipcalllog, "vspa_calllog_title"), GetDescFormArrayById(voipcalllog, "vspa_callogtitle"), false);
		</script>
		<div id="content" class="content-call-log"> 
		
			<div class="h3-table-content">	
				<div class="grey-table-content">
					<div id="call-log-table-id" class="table call-log more-columns">
						<script>
							var html = '';
							html += LoadTableHeadAndCallLogBody();
							document.write(html);
						</script>
						
					</div>
				</div>
				<div id="pagination_id" class="pagination">
					<script>
						var html = '';
						html += LoadCallLogPage();
						document.write(html);
					</script>
				</div>
				
			</div>
						
			<div id="btn_div_id" class="table-call-log-buttons clearfix">
				<script>
				
					var html ='';					
					
					html += '<input id="DeleteBtn" class="CancleButtonCss buttonwidth_150px_250px" style="font-family:Arial,sans-serif;" value="';
					html += voipcalllog['vspa_itvdf_calllog_deleteBtn'];
					html += '" type="button" onclick="deleteBtnClick()">';					
					document.write(html);
					var DeleteBtn = getElementById('DeleteBtn');
					DeleteBtn.disabled = false;
				</script>		
			</div>

			<div id="transparent_id" style="background-color:rgba(0,0,0,0.7);left:0;height:100%;width:100%;z-index:100;position:fixed;top:0;display:none;">
			</div>
        <input type="hidden" name="onttoken1" id="onttoken1" value="<%HW_WEB_GetToken();%>">
		</div>
		
	</body>
</html>
