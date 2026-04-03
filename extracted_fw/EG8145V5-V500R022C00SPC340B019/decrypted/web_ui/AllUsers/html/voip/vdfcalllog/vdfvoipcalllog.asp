<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="background-color:#fff;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>VOIP Call log</title>
<style>

html, body, div, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, abbr, acronym, address, big, cite,
code, del, dfn, em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center,
dl, dt, dd, ol, ul, li, fieldset, form, label, legend, input, select, option, table, caption, tbody, tfoot,
thead, tr, th, td, textarea {
    background: none repeat scroll 0 0 transparent;
    border: 0 none;
    font-family: Arial, sans-serif;
    font-size: 100%;
    margin: 0;
    outline: 0 none;
    padding: 0;
    vertical-align: middle;
}

.mainbody{
    padding-bottom: 60px;
    position: relative;
    -webkit-transition: all 0.3s ease-out;
    -moz-transition: all 0.3s ease-out;
    -o-transition: all 0.3s ease-out;
    transition: all 0.3s ease-out;
}

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

h1 {
    color: #e60000;
    font-family: "VodafoneRgRegular";
    font-size: 45px;
    font-weight: 350;
    line-height: 50px;
    margin-bottom: 10px;
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
  background-color: white;
  margin: 0 -10px;
  cursor: pointer;
}


.grey-table-content {
  background-color: #f7f7f7;
  padding: 0 10px;
  margin: 0 -10px;
}

.more-columns {
  text-align: center;
  background-color: #f7f7f7;
}
.call-log > .table-row > .table-col {
  height: 50px;
}
.table-call-log-buttons {
  text-align: right;
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
  margin-top: 20px;
  hight:auto;
}
.pagination-arrows {
    width: 25px;
    height: 25px;
    border-radius: 3px;
    box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.6);
    -moz-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.6);
    -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.6);
    display: inline-block;
    background-color: #ffffff;
    text-align: center;
    line-height: 23px;
    cursor: pointer;
}
.arrow-left img {
    margin-top: 6px;
}
.arrow-right img {
    margin-top: 6px;
}

.arrow-left {
    margin-top:6px;
    padding: 0 5px;
    margin-left: 100px;

    width: 30px;
    height: 23px;
    display: inline-block;
    text-align: center;
}
.arrow-right {
    margin-top:6px;
    padding: 0 5px;
    margin-right: 40px;
    width: 30px;
    height: 23px;
    display: inline-block;
    text-align: center;
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
  width: 50px;
  height: 23px;
  display: inline-block;
  text-align: center;
}

input.button {
  border-radius: 3px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.6);
  font-size: 16px;
  font-weight: bold;
  padding: 0 20px;
  height: 34px;
  line-height: 34px;
  background-color: #ffffff;
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

.h3-table-content {
    margin-left: 10px;
    padding-bottom: 50px;
    height:auto;
    position:relative;
    z-index: 100;
}

.h3-content {
    margin-left: 40px;
    width: 94.8%;
    display: table;
    position:relative;
    z-index: 999;
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
    background-position: 265px;
    background-repeat: no-repeat;
    z-index:999;
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

.pages {
    padding-top: 10px;
}

</style>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, vdfcalllog);%>"></script>
<script language="JavaScript" type="text/javascript"> 
var For_CallLogTotalCount = 0;

var PhoneNameCount = 1;
var PhoneNameDisp= new Array();
var PhoneNameTrueValue = new Array();
PhoneNameDisp[0] = vdfcalllog['vspa_itvdf_calllog_allNumber'];
PhoneNameTrueValue[0] = "all";
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
function stLine(Domain, PhyReferenceList, DirectoryNumber, X_HW_Description, Status)
{
    this.Domain = Domain;
    this.PhyReferenceList = PhyReferenceList;
	this.DirectoryNumber = DirectoryNumber;
	this.X_HW_Description = X_HW_Description;
    this.Status = Status;
    
}
function stLineURI(Domain, URI)
{
	this.Domain = Domain;
    this.URI = URI;

}
function stAuth(Domain, AuthUserName)
{
    this.Domain = Domain;
    this.AuthUserName = AuthUserName;
    
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,AuthUserName,stAuth);%>;
var AllLineURI = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,URI,stLineURI);%>;
var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},PhyReferenceList|DirectoryNumber|X_HW_Description|Status,stLine);%>;
function GetPhoneNumber(inputstring)
{
	var number;
	if( inputstring.indexOf(":") >= 0) 
	{
		var URIpart = inputstring.split(':');
		var k1 = URIpart[1];
		var k2 = k1.split('@');
		var k3 = k2[0];
		if (k3 == "")
		{ 
			number = "--";
		}
		else
		{ 
			number = k3;
		}
	}
	else
	{
		var URIpart = inputstring.split('@');
		var k = URIpart[0];
		if (k == "")
		{ 
			number = "--";
		}
		else
		{ 
			number = k; 
		}
	}
	return number;
}
function createDropdown(dropdowndefault,width, dropdownTrue, ArrdropdownArr,callfuncobj){
    var i = 0;
    $('#IframeDropdown1').css({"width":width});
    $('#IframeDropdown1').html("<div class='dropdownShowCss' id='dropdownShow' onclick='showCalllogDropdown(event);'></div><ul class='dropdownHide' id='dropdownHide' style='display:none;'></ul>");
    $('#dropdownShow').html(dropdowndefault);
    $('#dropdownShow').css({"width":"100%"});
    for(i;i<ArrdropdownArr.length;i++){
        $("#dropdownHide").append("<li id='"+ ArrdropdownArr[i] + "' onclick='" + callfuncobj + "' value='" + dropdownTrue[i]+ "'>"+ArrdropdownArr[i]+"</li>");
    }
    $('#dropdownHide').css({"width":width});
}
var g_Allclickshow = false;
function showCalllogDropdown(event){
	$("#dropdownHide").toggle(function(){
		if(false == g_Allclickshow){
			$('#dropdownShow').css("background-image","url('../../../images/arrow-up.png')");
			g_Allclickshow = true;
		}else{
			g_Allclickshow = false;
			$('#dropdownShow').css("background-image","url('../../../images/arrow-down.png')");
		}
	}
	);
	$("body").click(function(){
		$("#dropdownHide").hide();
		g_Allclickshow = false;
		$('#dropdownShow').css("background-image","url('../../../images/arrow-down.png')");
	});
	var e = window.event || event;
	if(e.stopPropagation){
		e.stopPropagation();
	}else{
		window.event.cancelBubble = true;
	}
}
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
		PerPagePhoneName[j] = GetNameOrTelNum(htmlencode(CallPageCallLogBody[5]));
	}
    
    
}
function GetTelNum(j)
{
	if(AllLineURI[j].URI != "")
	{
		return GetPhoneNumber(AllLineURI[j].URI);	
	}
	else if(AllLine[j].DirectoryNumber != "")
	{
		return GetPhoneNumber(AllLine[j].DirectoryNumber);
	}
	else if(AllAuth[j].AuthUserName != "")
	{
		return GetPhoneNumber(AllAuth[j].AuthUserName);
	}
	else
	{
		return "";
	}
}
function GetNameOrTelNum(TelNumFromDb)
{
	for (var m = 0; m < AllLine.length - 1; m++) {
        var num = TelNumFromDb.indexOf(GetTelNum(m));
        if (num >= 0) {
            if (AllLine[m].X_HW_Description != "") {
                return AllLine[m].X_HW_Description;
            }
            return TelNumFromDb;
        }
    }

    return TelNumFromDb;
}
	
function LoadFrame()
{
	for ( var m = 0; m < AllLine.length - 1; m++ )
	{
		if ( AllLine[m].X_HW_Description == "")
		{
			temp = htmlencode(GetTelNum(m));
			if("" == temp)
			{
				continue;
			}
		}
		else
		{
			temp = htmlencode(AllLine[m].X_HW_Description);
		}
		PhoneNameTrueValue[PhoneNameCount] = htmlencode(GetTelNum(m));
		if(temp.length > 20)
		{
			temp = temp.substr(0, 15);
			temp += "...";
		}
		
		PhoneNameDisp[PhoneNameCount] = temp;
		PhoneNameCount++;
	}
	GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo);
}
function GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo)
{
	For_CallLogTotalCount = HwQueryAjaxGetPara(LocalTelNum, CallType, "0");

	if (For_CallLogTotalCount == null) {
		return;
	}
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
function stLine(Domain, PhyReferenceList, DirectoryNumber, X_HW_Description)
{
    this.Domain = Domain;
    this.PhyReferenceList = PhyReferenceList;
    this.DirectoryNumber = DirectoryNumber;
	this.X_HW_Description = X_HW_Description; 
}

LoadFrame();
function DropDownListSelect(obj)
{
	$('#dropdownShow').html(obj.id);
	LocalTelNum = $(obj).attr("value");
	if(CurrentPageNo != 0)
	{
		CurrentPageNo = 1;
	}
	GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo);
	InnerHtmlLoadTable();
	InnerHtmlLoadPage();
	InnerHtmlLoadBtn(false);
	return;
}


function selectAll()
{
	var a = document.getElementsByTagName("input");
	if(a[0].checked)
	{	
		for(var i = 1;i<a.length;i++)
		{
			if(a[i].type == "checkbox") 
			{
				a[i].checked = true;
				chosenRecordCount = chosenRecordCount + 1;
				InnerHtmlLoadBtn(true);
			}
		}
		
	}
	else
	{
		chosenRecordCount = 0;
		for(var i = 1;i<a.length;i++)
		{
			if(a[i].type == "checkbox")
			{
				a[i].checked = false;
			}	
		}
		InnerHtmlLoadBtn(false);
	}

}

function selectOne()
{
	var a = document.getElementsByTagName("input");
	
	a[0].checked = true;
	InnerHtmlLoadBtn(false);
	chosenRecordCount = 0;
	for(var i = 1;i<a.length;i++)
	{
		if((a[i].type == "checkbox")&&(a[i].checked == true)) 
		{
			InnerHtmlLoadBtn(true);
			chosenRecordCount = chosenRecordCount + 1;
		}
		if((a[i].type == "checkbox")&&(a[i].checked == false))
		{
			a[0].checked = false;
		}
	}

}
function ChangeLabel(label_zero, label_one, label_two, label_three)
{
	var d = document.getElementById("tab-all");
	if(1 == label_zero)
	{  
		d.style.backgroundColor = "#f7f7f7";
		d.style.fontWeight ="bold";
	}
	else
	{   
		d.style.backgroundColor = "#ffffff";
		d.style.fontWeight ="";
	}
	
	d = document.getElementById("tab-dialled"); 
	if(1 == label_one)
	{   
		d.style.backgroundColor = "#f7f7f7";
		d.style.fontWeight ="bold";
	}
	else
	{   
		d.style.backgroundColor = "#ffffff";
		d.style.fontWeight ="";
	}
	
	d = document.getElementById("tab-received"); 
	if(1 == label_two)
	{  
		d.style.backgroundColor = "#f7f7f7";
		d.style.fontWeight ="bold";
	}
	else
	{   
		d.style.backgroundColor = "#ffffff";
		d.style.fontWeight ="";
	}
	
	d = document.getElementById("tab-missed");
	if(1 == label_three)
	{    
		d.style.backgroundColor = "#f7f7f7";
		d.style.fontWeight ="bold";
	}
	else
	{    
		d.style.backgroundColor = "#ffffff";
		d.style.fontWeight ="";
	}

}
function SubmitGetProfile(CallType)
{
	InnerHtmlLoadBtn(false);
	if ( CallType == 0)
	{
		ChangeLabel(1, 0, 0, 0);
	}
	if ( CallType == 1)
	{
		ChangeLabel(0, 1, 0, 0);
	}
	if ( CallType == 2)
	{
		ChangeLabel(0, 0, 1, 0);
	}
	if ( CallType == 3)
	{
		ChangeLabel(0, 0, 0, 1);
	}
	CurrentPageNo = 1;
	CallPageLog = GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo);
	
	InnerHtmlLoadTable();
	InnerHtmlLoadPage();
	InnerHtmlLoadBtn(false);
}
function LoadCallLogBody()
{
	var html = ''; 
	
	for(var rowjj = 0; rowjj < PerPageCount; rowjj++)
	{
		var picUrl = '';
		var temphtml = ''; 
		temphtml = '<tr class="table-row received co num2 numAll num_office" style="float:left;display: table-row;min-height:40px;align:middle;padding-top:12px;">';
		if ( 0 == PerPageCallType[rowjj] )
		{
			picUrl = '';
		}
		else if( 1 == PerPageCallType[rowjj] )
		{
			picUrl = '../../../images/outgoing.png';
		}
		else if( 2 == PerPageCallType[rowjj] )
		{
			picUrl = '../../../images/incoming.png';
		}
		else if( 3 == PerPageCallType[rowjj] )
		{
			picUrl = '../../../images/missedcall.png';
			temphtml = '<tr class="table-row received co num2 numAll num_office" style="float:left;display: table-row; color:red;min-height:40px;padding-top:12px;">';
		}
		else
		{
			picUrl = '';
		}
		
		html += temphtml;
		
		html += '<td>';
		html += '<span style="float:left;width:35px;font-family:Arial,sans-serif;">'; 
		html += '   <img src="' + picUrl + '" alt="Loading...">';  
		
		html += '   </span>'; 
		html += '</td>'; 
		
		html += '<td>';  
		html += '   <span class="language-string" name="PAGE_CALL_LOG_TABLE_TODAY" style="float:left;width:136px;min-height:40px;padding-top:12px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';  
		if("Today" == htmlencode(PerPageDate[rowjj]))
		{
			html +=        vdfcalllog['vspa_itvdf_calllog_toDay'];
		}
		else if("Yesterday" == htmlencode(PerPageDate[rowjj]))
		{
			html +=        vdfcalllog['vspa_itvdf_calllog_yesterDay'];
		}
		else
		{
			html +=        htmlencode(PerPageDate[rowjj]);
		}
		html += '   </span>'; 
		html += '</td>'; 
		 
		html += '<td>'; 
		html += '   <span style="float:left;width:109px;min-height:40px;padding-top:12px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';  
		html +=        htmlencode(PerPageTime[rowjj]);
		html += '   </span>'; 
		html += '</td>'; 
		
		html += '<td>'; 
		html += '   <span style="float:left;width:140px;min-height:40px;padding-top:12px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">'; 
		html +=        htmlencode(PerPagePeerNum[rowjj]); 
		html += '   </span>';
		html += '</td>';
		
		html += '<td>';  
		html += '   <span style="float:left;width: 135px;min-height:40px;padding-top:12px;white-space:normal;word-wrap:break-word;word-break: break-all;width:135px;font-family:Arial,sans-serif;">';  
		html +=        htmlencode(PerPagePhoneName[rowjj]); 
		html += '   </span>'; 
		html += '</td>'; 
		 
		html += '<td>';
		html += '   <span style="float:left;width:103px;min-height:40px;padding-top:12px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';
		html +=        htmlencode(PerPageDuration[rowjj]); 
		html += '   </span>';
		html += '</td>'; 
		
		html += '<td style="width:60px;min-height:40px;padding-top:3px;">';  
		html += '<input id="ch' + rowjj + '"  class="checkbox ch1 checkbox-checked" type="checkbox" onclick = "selectOne()" style="float:left;width:44px;font-family:Arial,sans-serif;">';
		html += '<label for="ch' + rowjj + '"></label>';
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
	html += '<td class="pages" style="font-family:Arial,sans-serif;width:600px;">';
	html += '</td>';
	if(CallLogTotalCount == 0)
	{
		CurrentPageNo = 0;
	}
	if(CurrentPageNo < 2)
	{
		html += '<td class="pagination-arrows arrow-left" style="opacity: 0.3;margin-top: 8px;" onclick="pageOnclick(1)">';
	}
	else
	{
		html += '<td class="pagination-arrows arrow-left" style="opacity: 1;margin-top: 8px;" onclick="pageOnclick(1)">';
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
		html += '<td class="pagination-arrows arrow-right" style="opacity: 0.3;" onclick="pageOnclick(2)">';
	}						
	else
	{
		html += '<td class="pagination-arrows arrow-right" style="opacity: 1;" onclick="pageOnclick(2)">';
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
function cancelBtnClick()
{
	var d = document.getElementById("popdiv_id");
	d.style.display="none";
}
function deleteBtnClick(which)
{
	var delRecordCount = 0;
	var d = document.getElementById("popdiv_id");
	if(chosenRecordCount == 0)
	{
		return;
	}
	if( 1 == which)
	{
		d.style.display="";
	}
	if( 2 == which)
	{
		var a = document.getElementsByTagName("input");
		DeleteData = '';
		for(var i = 1; i<a.length;i++)
		{
			if((a[i].type == "checkbox") && (a[i].checked == true)) 
			{
				delRecordCount += 1;
				if(DeleteData == '')
				{
					DeleteData += PerPageEntryID[i-1];
				}
				else
				{
					DeleteData += '|' + PerPageEntryID[i-1];
				}
					
			}
		}
		
		HwDeleteAjaxGetPara(DeleteData);
	
		if(delRecordCount == PerPageCount)
		{
			if(CurrentPageNo == TotalPageCount)
			{
				CurrentPageNo = parseInt(CurrentPageNo) - 1;
			}
			else
			{
				CurrentPageNo = CurrentPageNo;
			}
		}
		
		GetPageCountAndData(LocalTelNum, CallType, CurrentPageNo);
		d.style.display="none";
		InnerHtmlLoadTable();
		InnerHtmlLoadPage();
		InnerHtmlLoadBtn(false);
	}
	
}
function refreshBtnClick()
{
	if(CurrentPageNo != 0)
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
	
	divHtml += '<input id="RefreshBtn" class="button button-cancel" style="float:right;font-family:Arial,sans-serif;" value="';
	divHtml += vdfcalllog['vspa_itvdf_calllog_refreshBtn'];
	divHtml += '" type="button" onclick="refreshBtnClick()">';
	
	if(chosen == true)
	{
		divHtml += '<input id="DeleteBtn" class="button button-cancel" style="font-family:Arial,sans-serif;" value="';
	}
	else
	{
		divHtml += '<input id="DeleteBtn" class="button button-cancel table-button-faded disabled" style="font-family:Arial,sans-serif;" value="';
	}
	
	divHtml += vdfcalllog['vspa_itvdf_calllog_deleteBtn'];
	divHtml += '" type="button" onclick="deleteBtnClick(1)">';
	
	
	btndiv_id.innerHTML = '';
	btndiv_id.innerHTML = divHtml;
	var DeleteBtn = getElementById('DeleteBtn');
	if(chosen == true)
	{
		DeleteBtn.disabled = false;
	}
	else
	{
		DeleteBtn.disabled = true;
	}
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
	var trHeadHtml = '<table>';
	trHeadHtml += '<tr class="table-row received co num2 numAll num_office"  style="float:left;display: table-row;border-bottom: 1px solid #e6e6e6;">';
	var trHeadHtml_pic = '<td>';
	trHeadHtml_pic += '<span style="float:left;width:35px;font-family:Arial,sans-serif;">';
	trHeadHtml_pic += '&nbsp;';
	trHeadHtml_pic += '</span>';
	trHeadHtml_pic += '</td>';
	
	var trHeadHtml_date = '<td>';
	trHeadHtml_date += '<span style="float:left;width:136px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';
	trHeadHtml_date += vdfcalllog['vspa_itvdf_calllog_date'];
	trHeadHtml_date += '</span>';
	trHeadHtml_date += '</td>';
	
	var trHeadHtml_time = '<td>';
	trHeadHtml_time += '<span class="language-string" name="PAGE_CALL_LOG_TABLE_SUB_TIME" style="float:left;width:109px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';
	trHeadHtml_time += vdfcalllog['vspa_itvdf_calllog_time'];
	trHeadHtml_time += '</span>';
	trHeadHtml_time += '</td>';
	
	var trHeadHtml_exterNum = '<td>';
	trHeadHtml_exterNum += '<span style="float:left;width: 140px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';
	trHeadHtml_exterNum += vdfcalllog['vspa_itvdf_calllog_extern_number'];
	trHeadHtml_exterNum += '</span>';
	trHeadHtml_exterNum += '</td>';
	
	var trHeadHtml_ownNum = '<td>';
	trHeadHtml_ownNum += '<span style="float:left;width: 135px;word-wrap:break-word;font-family:Arial,sans-serif;">';
	trHeadHtml_ownNum += vdfcalllog['vspa_itvdf_calllog_your_number'];
	trHeadHtml_ownNum += '</span>';
	trHeadHtml_ownNum += '</td>';
	
	var trHeadHtml_duration = '<td>';
	trHeadHtml_duration += '<span class="language-string" name="PAGE_CALL_LOG_TABLE_SUB_DURATION" style="float:left;width:103px;word-wrap:break-word;word-break: break-all;font-family:Arial,sans-serif;">';
	trHeadHtml_duration += vdfcalllog['vspa_itvdf_calllog_dura'];
	trHeadHtml_duration += '</span>';
	trHeadHtml_duration += '</td>';
	
	var trHeadHtml_checkBox = '<td style="width:60px">';
	trHeadHtml_checkBox += '<input id="checkAll" style="width:44px;font-family:Arial,sans-serif;" type="checkbox" onclick="selectAll()">';
	trHeadHtml_checkBox += '<label for="checkAll">';
	trHeadHtml_checkBox += '</label>';
	trHeadHtml_checkBox += '</td>';
	
	trHeadHtml += trHeadHtml_pic + trHeadHtml_date + trHeadHtml_time + trHeadHtml_exterNum + trHeadHtml_ownNum + trHeadHtml_duration + trHeadHtml_checkBox + '</tr>';
	
	var trBodyHtml = LoadCallLogBody();
	
	divHtml += trHeadHtml +trBodyHtml;
	divHtml += '</table>';
	return divHtml;
}
</script>
</head>
	<body class="mainbody">
		<h1><span class="language-string" name="PAGE_CALL_LOG_PAGETITLE"><script>document.write(vdfcalllog['vspa_itvdf_calllog_title']);</script></span></h1>
		<div id="content" class="content-call-log"> 
			<div class="h3-content">
    			<div class="row">
    				<div class="left" style="float:left;font-weight:bold;font-family:Arial,sans-serif;"><span class="language-string" name="PAGE_CALL_LOG_SHOW_CALLS"><script>document.write(vdfcalllog['vspa_itvdf_calllog_name']);</script></span>        </div>
        			<div class="right" style="float:right;font-weight:bold;padding-top: 19px;padding-right:5px;">
						<div id="IframeDropdown1" style="float:right;height:39px;font-weight:bold;width:290px">
        					<script>
								var defaultValue = PhoneNameDisp[0];
								createDropdown(defaultValue, "290px", PhoneNameTrueValue, PhoneNameDisp, "DropDownListSelect(this)");
        					</script>
						</div>
					</div>
				</div>
			</div>
		
			<div class="h3-table-content">
				<div class="clearfix tabs tabs-bg-4-3">
					<div id="tab-all" style="height: 44px;width:25%;border-top-left-radius:2px;border-top-right-radius:2px;float:left;text-align:center;line-height:44px;background-color:#f7f7f7;font-weight:bold;font-family:Arial,sans-serif;" onclick="SubmitGetProfile(0);">
						<span class="language-string" name="PAGE_CALL_LOG_TABLE_SUB_ALL">
							<script>document.write(vdfcalllog['vspa_itvdf_calllog_all']);
							</script>
						</span>
					</div>
					<div id="tab-dialled" style="height: 44px;width: 25%;border-top-left-radius: 2px;border-top-right-radius: 2px;float: left;text-align: center;line-height: 44px;background-color: #ffffff;" onclick="SubmitGetProfile(1);">
            			<div class="cont1">
                			<img src="../../../images/outgoing.png" alt="outgoing">
                				<span class="langSpan">
                					<span class="language-string" name="PAGE_CALL_LOG_TABLE_SUB_DIALLED" style="font-family:Arial,sans-serif;"><script>document.write(vdfcalllog['vspa_itvdf_calllog_dialled']);</script></span>
                				</span>
            			</div>
        			</div>
        			<div id="tab-received" style="height: 44px;width: 25%;border-top-left-radius: 2px;border-top-right-radius: 2px;float: left;text-align: center;line-height: 44px;background-color: #ffffff;" onclick="SubmitGetProfile(2);">
            			<div class="cont2">
							<img src="../../../images/incoming.png" alt="incoming">
								<span class="langSpan">
									<span class="language-string" name="PAGE_CALL_LOG_TABLE_SUB_RECEIVED" style="font-family:Arial,sans-serif;"><script>document.write(vdfcalllog['vspa_itvdf_calllog_received']);</script>
									</span>
								</span>
            			</div>
        			</div>
        			<div id="tab-missed" style="height: 44px;width: 25%;border-top-left-radius: 2px;border-top-right-radius: 2px;float: left;text-align: center;line-height: 44px;background-color: #ffffff;font-family:Arial,sans-serif;" onclick="SubmitGetProfile(3);">
            			<div class="cont3">
                			<img src="../../../images/missedcall.png" alt="missedcall">
               					<span class="langSpan">
               					<span class="language-string" name="PAGE_CALL_LOG_TABLE_SUB_MISSED" style="font-family:Arial,sans-serif;"><script>document.write(vdfcalllog['vspa_itvdf_calllog_missed']);</script>
               					</span>
               					</span>
            			</div>
        			</div>
        		</div>
	
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
					html += '<input id="RefreshBtn" class="button button-cancel" style="float:right;font-family:Arial,sans-serif;" value="';
					html += vdfcalllog['vspa_itvdf_calllog_refreshBtn'];
					html += '" type="button" onclick="refreshBtnClick()">';
					
					html += '<input id="DeleteBtn" class="button button-cancel table-button-faded disabled" style="font-family:Arial,sans-serif;" value="';
					html += vdfcalllog['vspa_itvdf_calllog_deleteBtn'];
					html += '" type="button" onclick="deleteBtnClick(1)">';					
					document.write(html);
					var DeleteBtn = getElementById('DeleteBtn');
					DeleteBtn.disabled = true;
				</script>		
			</div>

			<div id="popdiv_id" style="background-color:#f0f0f2;position:fixed;width:620px;height:293px;z-index:999;display:none;left:5%;top:20%;">
				<div style="left:10%;top:10%;height:150px;margin-top:20px;margin-left:30px;">
					<p class="title">
						<span class="language-string" style="font-family:Arial,sans-serif;">
							<script>
							document.write(vdfcalllog['vspa_itvdf_calllog_deletecomfirm']);
							</script>
						</span>
					</p>
				</div>
				<div class="apply-cancel" style="left:10%;top:50%;height:105px;margin-right:25px;">
					<script>
						var html ='';
						html += '<input id="cancelPopupButton" class="button button-cancel " style="font-family:Arial,sans-serif;" type="button" value="';
						html += vdfcalllog['vspa_itvdf_calllog_cancelBtn'];
						html += '" onclick="cancelBtnClick()">';
						html += '<input id="deletePopupButton" class="button button-apply" style="font-family:Arial,sans-serif;" data-popup-hide="" type="button" value="';
						html += vdfcalllog['vspa_itvdf_calllog_deleteBtn'];
						html += '" language-string"="" name="PAGE_CALL_LOG_POPUP_DELETE_BUTTON" onclick="deleteBtnClick(2)">';
						
						document.write(html);
					</script>
				</div>
			</div>
			<div id="transparent_id" style="background-color:rgba(0,0,0,0.7);left:0;height:100%;width:100%;z-index:100;position:fixed;top:0;display:none;">
			</div>
        <input type="hidden" name="onttoken1" id="onttoken1" value="<%HW_WEB_GetToken();%>">
		</div>
		
	</body>
</html>
