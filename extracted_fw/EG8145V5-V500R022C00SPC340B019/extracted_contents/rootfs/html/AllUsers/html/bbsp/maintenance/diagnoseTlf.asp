<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<title>UTILITIES</title>
<link rel="stylesheet"  href='../../../Cuscss/gateway.css' type='text/css'>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style>
	.block_title{
		text-align: center;
	}
	.table_title{
		background: #e3e3e3;
	}
	.table_right{
		background: #f1f2f3;
	}
	.tabal_noborder_bg{
		padding:0px;
	}
	Table td select.select_width_190{
		width: 190px; 
		height: 24px; 
		line-height: 24px; 
		padding-left: 10px;
	}
	Table td input.input_width_190{
		width: 176px; 
		height: 24px; 
		line-height: 24px; 
		padding-left: 10px;
	}
	table.setTable{
		border-spacing:2px 0px;
		margin-bottom:0px;
	}
	.btn-default-orange-small{
		margin-top:0px;
		margin-bottom:0px;
		padding-top:0px;
		padding-bottom:0px;
		outline:none;
	}
	button[disabled].btn-default-orange-small,button[disabled].btn-default-orange-small span{
		background-color:#999999;
	}
</style>
</head>
<script language="JavaScript" type="text/javascript">
	var sysUserType = '0';
	var curUserType = '<%HW_WEB_GetUserType();%>';
	var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';

	var RequestFile = 'html/bbsp/maintenance/diagnoseTlf.asp';

	var DATA_BLOCK_DEFAULT=56;
	var TraceRoute_DATA_BLOCK_DEFAULT = 38;
	var PING_FLAG="Ping";
	var TRACEROUTE_FLAG="Traceroute";
	var REPEATE_TIME_DEFAULT=4;
	var DSCP_DEFAULT=0;
	var MaxTimeout_DEFAULT = 10;
	
	var CLICK_INIT_FLAG="None";
	var CLICK_START_FLAG="START";
	var CLICK_TERMINAL_FLAG="TERMIANL";

	var STATE_INIT_FLAG="None";
	var STATE_DOING_FLAG="Doing";
	var STATE_DONE_FLAG="Done";

	var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
	
	var TimerHandlePing = null;
	var TimerHandlePingDns;
	
	function loadlanguage(){
		var all = document.getElementsByTagName("td");
		for (var i = 0; i <all.length ; i++) {
			var b = all[i];
			if(b.getAttribute("BindText") == null){
				continue;
			}
			b.innerHTML = diagnose_language[b.getAttribute("BindText")];
		}
	}
	
	function chooseDiagnoseType(){
		$('#testResults').val('');
		$('#IPAddress').val('');
		$('#NumOfRepetitions').val('');

		if($(this).val() == "Ping")
		{
			setPingPara();
		}
		else
		{
			setTraceRtPara();
		}

		getResultMessgeForType($(this).val());
	}

	function setPingPara()
	{
		if(PingResult)
		{	
			setText("IPAddress",PingResult.Host);
			setText("NumOfRepetitions",PingResult.NumberOfRepetitions);		
		}
		setDisplay("NumOfRepetitionsRow", 1);
	}

	function setTraceRtPara()
	{
		if(TracerResult)
		{	
			setText("IPAddress",TracerResult.Host);			
		}
		setDisplay("NumOfRepetitionsRow", 0);
	}

	function LoadFrame(){
		$('#DiagnoseType').on('change',chooseDiagnoseType);
		
		setPingPara();
		getResultMessgeForType('Ping');
		loadlanguage();
		diagnoseTypeChange();

		if ('<%HW_WEB_GetFeatureSupport(BBSP_FT_TRACEROUTE_ICMP);%>' == '1') {
            setDisplay('protocolTypeRow', 0);
        }
	}
	
	function setEditStatus(type)
	{
		var flag = (type == "start")?1:0;

		setDisable('btnApply_ex',flag);
		setDisable('clearTextarea',flag);
		setDisable("cancelValue", !flag);

		setDisable("IPAddress", flag);
		setDisable("NumOfRepetitions", flag);
		setDisable("DiagnoseType", flag);
	}

	function getResultMessgeForType(type){
		if(type=='Ping'){
			if(CLICK_START_FLAG == PingClickFlag){
				setEditStatus("start");
				GetPingAllResult();
			}
			else if(CLICK_TERMINAL_FLAG == PingClickFlag){
				$("#testResults").val("");
				setEditStatus("stop");
			}
			else if(CLICK_INIT_FLAG == PingClickFlag){
				$("#testResults").val("");
				setEditStatus("stop");
			}		
		}else{
			if (CLICK_START_FLAG == TracerouteClickFlag){
				setEditStatus("start");
				GetRouteResult();
			}else if(CLICK_INIT_FLAG == TracerouteClickFlag){
				setEditStatus("stop");
			}else if  (CLICK_TERMINAL_FLAG == TracerouteClickFlag){
				$("#testResults").val("");
				setEditStatus("stop");
			}
		}
	}
	
	function CheckForm(){      
								
	}

</script>
<script language="JavaScript" type="text/javascript">
function Br0IPAddressItem(domain, IPAddress, SubnetMask)
{
    this.domain = domain;
    this.IPAddress = IPAddress;
    this.SubnetMask = SubnetMask;
}
function PingResultClass(domain, DiagnosticsState,Interface,Host,NumberOfRepetitions,Timeout,DataBlockSize,DSCP,FailureCount, SuccessCount,MinimumResponseTime,MaximumResponseTime,AverageResponseTime)
{
    this.domain = domain;
    this.DiagnosticsState = DiagnosticsState;
    this.Interface = Interface;
    this.Host = Host;
    if (1 > NumberOfRepetitions)
	{
		this.NumberOfRepetitions = 1;
	}
	else if (3600 < NumberOfRepetitions)
	{
		this.NumberOfRepetitions = 3600;
	}
	else
	{
		this.NumberOfRepetitions = NumberOfRepetitions;
	}
    if (Timeout < 1000)
	{
		this.Timeout = 1000;
	}
	else
	{
    	this.Timeout = Timeout;
	}
    if (32 > DataBlockSize)
	{
		this.DataBlockSize = 32;
	}
	else if (65500 < DataBlockSize)
	{
		this.DataBlockSize = 65500;
	}
	else
	{
		this.DataBlockSize = DataBlockSize;
	}
    this.DSCP = DSCP;
    this.FailureCount = FailureCount;
    this.SuccessCount = SuccessCount;
    this.MinimumResponseTime = MinimumResponseTime;
    this.MaximumResponseTime = MaximumResponseTime;
    this.AverageResponseTime = AverageResponseTime;
}
var LanHostInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},IPInterfaceIPAddress|IPInterfaceSubnetMask,Br0IPAddressItem);%>;
var LanHostInfo = LanHostInfos[0];
var PingResultList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.IPPingDiagnostics,DiagnosticsState|Interface|Host|NumberOfRepetitions|Timeout|DataBlockSize|DSCP|FailureCount|SuccessCount|MinimumResponseTime|MaximumResponseTime|AverageResponseTime, PingResultClass);%>;
var PingResult = PingResultList[0];
var splitobj = "[@#@]";
var dnsString = "";

var PingClickFlag= "<%HW_WEB_GetRunState("Ping");%>";
var PingState=STATE_INIT_FLAG;

function filterWan(WanItem)
{
	return true;
}
var wans = GetWanListByFilter(filterWan);

function GetInterface()
{
	for(var k = 0; k < wans.length; k++ )
	{
		if(wans[k].ServiceList != 'TR069'
		&& wans[k].ServiceList != 'VOIP'
        && wans[k].ServiceList != 'TR069_VOIP'
		&& wans[k].ServiceList.indexOf('INTERNET') != -1
        && wans[k].Mode == 'IP_Routed')
		{
			return wans[k].domain;
		}
	}
	return "InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.1.WANPPPConnection.1";
}


	function ChangeRetsult(text)
	{
		var result = "";
		if (text.toLowerCase() != 'none')
		{
		   var str=text.replace("!H"," ");
		   res = str.split("\n");
		   
		   for(i=0;i<res.length;i++)
		   {
			  result+=res[i]+'<br/>';
		   }
		}
		return result;
	}

	function ParsePingResult(pingString)
	{
		 var subString = pingString.split(splitobj);
		 var result = "";
		 var status = "";
		 if (subString.length >= 2)
		 {
			if ("\n" == subString[1])
			{
				status = subString[0];
				substring=null;
				return;
			}
			else
			{
				status = subString[1];
				result = subString[0];
			}
		 }
		 else
		 {
			 substring=null;
			 return ;
		 }
		if (( status.indexOf("Requested") >= 0))
		{
			if (CLICK_START_FLAG == PingClickFlag)
			{
				var requestResult = "";
				if(dnsString.indexOf("NONE") == -1)
				{
					requestResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
				}
				requestResult += diagnose_language['bbsp_pingtitle'] + '\n';
				if(result.indexOf("NONE") == -1)
				{
					requestResult += result;
				}
				getElement("testResults").value = requestResult;	

				PingState=STATE_DOING_FLAG;
			 }
			 else if(CLICK_INIT_FLAG == PingClickFlag)
			 {
				PingState=STATE_INIT_FLAG;
			 }	
		 }
		 else if( status.indexOf("Complete_Err") >= 0)
		 {
			PingState=STATE_DONE_FLAG;		
			setEditStatus("stop");
			
			var errResult = "";
			if(dnsString.indexOf("NONE") == -1)
			{
				errResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
			}
			errResult += diagnose_language['bbsp_pingtitle'] + '\n' + result;
			getElement("testResults").value = errResult;
		 }
		 else if( status.indexOf("Complete") >= 0)
		 {
			PingState=STATE_DONE_FLAG;		
			setEditStatus("stop");

			var tmpResult = ChangeRetsult(result);
			var SubStatisticResult = tmpResult.split("ping statistics ---<br/>");
			var StatisticResult = SubStatisticResult[1];
			var Result = StatisticResult.split("<br/>");
			
			var completeResult = "";
			if(dnsString.indexOf("NONE") == -1)
			{
				completeResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
			}
			
			completeResult += diagnose_language['bbsp_pingtitle'] + '\n' + result;
			getElement("testResults").value = completeResult;		
		 }
		else if ( status.toUpperCase().indexOf("NONE") >= 0)
		 {	
			PingState=STATE_DONE_FLAG;		
			setEditStatus("stop");	
			getElement("testResults").value = '';
		 }
		 else 
		 {
			PingState=STATE_DONE_FLAG;
			var otherResult = "";
			setEditStatus("stop");
			if( false == CheckIsIpOrNot(removeSpaceTrim(getValue("IPAddress"))) )
			{
				if (dnsString.indexOf("NONE") == -1)
				{
					var DnsStringnew = htmlencode(dnsString.replace(new RegExp(/(\n)/g),'<br>'));
					var newpingResult = DnsStringnew.replace(new RegExp(/(&lt;br&gt;)/g), '<br>');
					otherResult = diagnose_language['bbsp_dnstitle'] + '\n' + dnsString + '\n';
				}
				else
				{
					otherResult = diagnose_language['bbsp_dnstitle'] + '\n' + diagnose_language['bbsp_pingfail1'] + '\n';
				}
			}
			otherResult += diagnose_language['bbsp_pingtitle'] + '\n' + diagnose_language['bbsp_pingfail1'];
			getElement("testResults").value = otherResult;		
		 }
		 otherResult = null;
		 completeResult = null;
		 errResult = null;
		 tmpResult=null;	 
		 tmpResult=null;
		 SubStatisticResult=null;
		 Result=null;
		 return ;
	}
	function GetPingResult()
	{
		var PingContent="";
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : "./GetPingResult.asp",
			success : function(data) {
				if ((data.length > 8) && ('\\n" + ' == data.substr(2,6)))
				{
					data = data.substr(8);
				}
				PingContent = dealDataWithFun(data);
				ParsePingResult(PingContent);
			},
			complete: function (XHR, TS) { 
				PingContent=null;			
				XHR = null;
			}
		});
	}
	
	function GetPingDnsResult()
	{
		var PingDnsContent="";
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : "./GetPingDnsResult.asp",
			success : function(data) {
				if ((data.length > 8) && ('\\n" + ' == data.substr(2,6)))
				{
					data = data.substr(8);
				}
				PingDnsContent = dealDataWithFun(data);
				dnsString = PingDnsContent;
			},
			complete: function (XHR, TS) { 
				PingDnsContent = null;			
				XHR = null;
			}
		});
	}
	
	function GetPingAllResult()
	{
		GetPingDnsResult();
		GetPingResult();

		if (CLICK_START_FLAG  ==  PingClickFlag && STATE_DOING_FLAG == PingState)
		{ 
			if(TimerHandlePing == null)
			{            
				TimerHandlePing = setInterval("GetPingAllResult()", 10000);
			}
		}
		
		if ((CLICK_START_FLAG  ==  PingClickFlag && STATE_DONE_FLAG == PingState)
			|| (CLICK_TERMINAL_FLAG  ==  PingClickFlag) )
		{ 
			if(TimerHandlePing != null)
			{
				clearInterval(TimerHandlePing);
				TimerHandlePing=null;
			}
		}   
	}
	
</script>
<script>
	function TracertResultClass(domain,DiagnosticsState,Interface,Host,NumberOfTries,Timeout,DataBlockSize,DSCP,MaxHopCount,ResponseTime,RouteHopsNumberOfEntries,ProtocolType)
	{
		this.domain = domain;
		this.DiagnosticsState = DiagnosticsState;
		this.Interface = Interface;
		this.Host = Host;
		this.NumberOfTries = NumberOfTries;
		this.Timeout = Timeout;
		this.DataBlockSize = DataBlockSize;
		this.DSCP = DSCP;
		this.MaxHopCount = MaxHopCount;
		this.ResponseTime = ResponseTime;
		this.RouteHopsNumberOfEntries = RouteHopsNumberOfEntries;
		this.ProtocolType = ProtocolType;
	}
	
	var TracertResultList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.TraceRouteDiagnostics,DiagnosticsState|Interface|Host|NumberOfTries|Timeout|DataBlockSize|DSCP|MaxHopCount|ResponseTime|RouteHopsNumberOfEntries|X_HW_ProtocolType, TracertResultClass);%>;
	var TracerResult = TracertResultList[0];
	
	var TracerouteClickFlag= '<%HW_WEB_GetRunState("Traceroute");%>';
	var TraceRouteState=STATE_INIT_FLAG;
	
	var TimerHandle = null;
	
	function FindResultEnd(string)
	{
		var newString = string.split(splitobj);
		var result =  newString[0];
		var status =  newString[1];

		 if (status.indexOf("Requested") >= 0) {

			var requestedResult = ChangeRetsult(result);
			getElement('testResults').value =requestedResult.replace(/\<br\/>/g,'\n');
			TraceRouteState=STATE_DOING_FLAG;
		 }
		 else if( status.indexOf("Complete") >= 0){
			TraceRouteState=STATE_DONE_FLAG;
			setEditStatus("stop");

			var tmpResult = ChangeRetsult(newString[0]);
			if(tmpResult == "" || tmpResult == "<br/>")
			{
				getElement('testResults').value = diagnose_language['bbsp_pingfail1'];
			}
			else
			{
				tmpResult = tmpResult.replace(/\<br\/>/g,'\n');
				getElement('testResults').value = tmpResult;
			}
			tmpResult=null;
		 }
		 else if (status.toUpperCase().indexOf("NONE") >= 0) {
			TraceRouteState=STATE_DONE_FLAG;	 	
			setEditStatus("stop");
			
			var tmpResult = ChangeRetsult(newString[0]);
			if(tmpResult == "" || tmpResult == "<br/>")
			{
				getElement('testResults').value ="";
			}
			else
			{
				tmpResult = tmpResult.replace(/\<br\/>/g,'\n');
				getElement('testResults').value = tmpResult;
			}
			tmpResult=null;
	 	}
         else{
			TraceRouteState=STATE_DONE_FLAG;
			setEditStatus("stop");

			var tmpResult = ChangeRetsult(newString[0]);
			if(tmpResult == "" || tmpResult == "<br/>")
			{
				getElement('testResults').value = diagnose_language['bbsp_pingfail1'];
			}
			else
			{
				tmpResult = tmpResult.replace(/\<br\/>/g,'\n');
				getElement('testResults').value = tmpResult;
			}
			tmpResult=null;
		 }
		newString=null;
		result=null;
		return ;
	}
	
	function GetRouteResult(){
		var traceRouteTxt="";
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : "./GetRouteResult.asp",
			success : function(data) {
            if(data !== '') {
              traceRouteTxt = dealDataWithStr(data);
            }
			   FindResultEnd(traceRouteTxt);
			},
			complete: function (XHR, TS) { 
				if (CLICK_START_FLAG  ==  TracerouteClickFlag && TraceRouteState == STATE_DOING_FLAG)
				{
					if(TimerHandle == null)
					{
						TimerHandle=setInterval("GetRouteResult()", 10000);
					}
				}
				if( CLICK_START_FLAG  ==  TracerouteClickFlag && TraceRouteState == STATE_DONE_FLAG )
				{
					if(TimerHandle != null)
				   {
					   clearInterval(TimerHandle);
					   TimerHandle=null;
				   }
				   else
				   {

				   }
				}                  
				traceRouteTxt=null;
				XHR = null;
		   }
		});
	}
</script>
<script>
	function checkInput(obj,type,length,cssClass){
		if(!obj.val()||obj.val()==''||obj.val()==null){
			obj.focus();
			return false;
		}
		if(obj.val().length>length){
			obj.focus();
			return false;
		}
		
		if(type=='int'){
			var rec = /^[1-9]+[0-9]*]*$/;
			if(!rec.test(obj.val())){
				obj.focus();
				return false;
			}
		}
		if(type=='number'){
			if(!isNaN(obj.val())){
				obj.focus();
				return false;
			}
		}
		if(type=='ip'){
			var rec = /^[1-9]+[0-9]*]*$/;
			var strs = obj.val().split('.');
			for(var i=0;i<strs.length;i++){
				if(!rec.test(strs[i])){
					obj.focus();
					return false;
				}
			}
		}
		
		if(cssClass=='numberOfPings'){
			if (false == CheckNumber(obj.val(),1, 3600)) {
				obj.focus();			
				return false;
			}
		}
		return true;
	}
	
	function getMessage(){
		var tool = $('#DiagnoseType');
		var destination = $('#IPAddress');
		var numberOfPingsObj = $('#NumOfRepetitions');
		var numberOfPings = numberOfPingsObj.val();

		if(numberOfPingsObj.val() == "")
		{
			numberOfPings = 4;
		}

		if((tool.val() == "Ping")
			&& (false == checkInput(numberOfPingsObj,'int',4,'numberOfPings')))
		{
			AlertEx(diagnose_language['bbsp_numofrepetitionsinvalid_tlf']);
			return null
		}

		return {tool:tool.val(),destination:destination.val(),numberOfPings:numberOfPings};
	}
	
	function getRunStateByType(){
		var type = $('#DiagnoseType').val();
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			url : "./GetRunState.asp",
			success : function(data) {
				if(data){
					var runState =  dealDataWithFun(data);
					if(type=='Ping'){
						PingClickFlag = runState;
						getResultMessgeForType('Ping');
					}else{
						TracerouteClickFlag = runState;
						getResultMessgeForType('Traceroute');
					}
				}
			},
			complete: function (XHR, TS) { 
				PingDnsContent = null;			
				XHR = null;
			}
		});
	}

	function HWSetActionTemp(type,url,Parameter,tokenvalue)
	{
		var UnUseForm = (Parameter.UnUseForm == true) ? true : false;
		var ajaxResult;
		if("ajax" == type)
		{
			var AjaxBody = HWAddParameterByFormId(null, Parameter.FormLiList, Parameter.SpecParaPair, Parameter.OldValueList, UnUseForm);
			if(null == AjaxBody)
			{
				return;
			}

			$.ajax({
				type : "POST",
				async : Parameter.asynflag,
				cache : false,
				url: url,
				data :AjaxBody + "&x.X_HW_Token=" + tokenvalue,
				success : function(data) {
					ajaxResult=data;
				}
			});

			return ajaxResult;
		}
	}

	function toDiagnose(ConfigParaList,type){
		var Parameter = {};	
		Parameter.OldValueList = null;
		Parameter.FormLiList = null;
		Parameter.UnUseForm = true;
		Parameter.asynflag = false;
		Parameter.SpecParaPair = ConfigParaList;
		if(type=='Ping'){
			var ConfigUrl = 'complexajax.cgi?x=InternetGatewayDevice.IPPingDiagnostics&RUNSTATE_FLAG='+type+'&RequestFile=' + RequestFile;							  
		}else{
			var ConfigUrl = 'complexajax.cgi?x=InternetGatewayDevice.TraceRouteDiagnostics&RUNSTATE_FLAG='+type+'&RequestFile=' + RequestFile;
		}
		var ret = HWSetActionTemp("ajax", ConfigUrl, Parameter, getValue("onttoken"));
		if(false == CheckHwAjaxRet(ret))
		{
			getElement('testResults').value = diagnose_language['bbsp_pingfail1'];
			return;
		}
		
		setDisable("btnApply_ex", "1");
		setDisable('clearTextarea',"1");
		setDisable("cancelValue", "1");
		getRunStateByType();
	}

	function startPing(){
		var message = getMessage();
		var interfaceMessage = GetInterface();
		
		if(message==null){
			return false;
		}

		var ConfigParaList = new Array(new stSpecParaArray("x.Host",message.destination, 0),
									new stSpecParaArray("x.NumberOfRepetitions",message.numberOfPings, 0),
									new stSpecParaArray("x.DiagnosticsState","Requested", 0),
									new stSpecParaArray("RUNSTATE_FLAG.value",CLICK_START_FLAG, 0),
									new stSpecParaArray("x.Interface",interfaceMessage, 0));
		
		toDiagnose(ConfigParaList, PING_FLAG);
	}
	
	function startTraceroute(){
		var message = getMessage();
		var interfaceMessage = GetInterface();
		var proType = getSelectVal('protocolType');

		if(message==null){
			return false;
		}

		var ConfigParaList = new Array(new stSpecParaArray("x.Host",message.destination, 0),
									new stSpecParaArray("x.DiagnosticsState","Requested", 0),
									new stSpecParaArray("RUNSTATE_FLAG.value",CLICK_START_FLAG, 0),
									new stSpecParaArray("x.Interface",interfaceMessage, 0),
									new stSpecParaArray("x.X_HW_ProtocolType", proType, 0));
		toDiagnose(ConfigParaList,TRACEROUTE_FLAG);
	}

	function stopPing(){
		var message = getMessage();
		var interfaceMessage = GetInterface();

		if(message==null){
			return false;
		}

		var ConfigParaList = new Array(new stSpecParaArray("x.Host",message.destination, 0),
									new stSpecParaArray("x.NumberOfRepetitions",message.numberOfPings, 0),
									new stSpecParaArray("RUNSTATE_FLAG.value",CLICK_TERMINAL_FLAG, 0),
									new stSpecParaArray("x.Interface",interfaceMessage, 0));

		toDiagnose(ConfigParaList,PING_FLAG);
	}

	function stopTraceroute(){
		var message = getMessage();
		var interfaceMessage = GetInterface();
		var proType = getSelectVal('protocolType');

		if(message==null){
			return false;
		}
		var ConfigParaList = new Array(new stSpecParaArray("x.Host",message.destination, 0),
									new stSpecParaArray("RUNSTATE_FLAG.value",CLICK_TERMINAL_FLAG, 0),
									new stSpecParaArray("x.Interface",interfaceMessage, 0),
									new stSpecParaArray("x.X_HW_ProtocolType", proType, 0));
		toDiagnose(ConfigParaList,TRACEROUTE_FLAG);
	}

	function onApply(){
		var currentPro = getSelectVal('DiagnoseType');
		if (currentPro == "Ping"){
			startPing();
		}else{
			startTraceroute();
		}
		return;
	}
	
	function onStopPing(){

		var currentPro = getSelectVal('DiagnoseType');

		if (currentPro == "Ping")
		{
			stopPing();
		}
		else
		{
			stopTraceroute();
		}
	}
	
	function clearInfoSubmit(cgitype)
	{
		$.ajax({
			type : "POST",
			async : false,
			cache : false,
			data : "x.X_HW_Token="+getValue('onttoken'),
			url : cgitype + '?&RequestFile=html/bbsp/maintenance/diagnoseTlf.asp',
			success : function(data) {
			}
		});
	}

	function onClearResult()
	{	
		var currentPro = getSelectVal('DiagnoseType');	
		if ("Ping" == currentPro)
		{
			clearInfoSubmit("clearping.cgi");
		}
		else
		{
			clearInfoSubmit("cleartraceroute.cgi");	
		}

		getElement('testResults').value ="";
	}

	function diagnoseTypeChange()
	{
		var currentPro = getSelectVal('DiagnoseType');
		if (currentPro == "Ping") {
			setDisplay("protocolType", 0);
		} else {
			setDisplay("protocolType", 1);
		}
	}
</script>
</head>
<body onLoad="LoadFrame();" class="">
<form id="table_ping" style="display:block;">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg">
	    <li id="UtilitiesTitleBar" RealType="HorizonBar" DescRef="bbsp_UtilitiesTitle" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" InitValue="Empty"/>
		<li id="DiagnoseType" RealType="DropDownList" DescRef="bbsp_Toolmh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Interface" Elementclass="select_width_190 restrict_dir_ltr" 
		InitValue="[{TextRef:'Ping',Value:'Ping'},{TextRef:'TraceRoute',Value:'TraceRoute'}]" ClickFuncApp="onChange=diagnoseTypeChange" />
		<li id="IPAddress" RealType="TextOtherBox" DescRef="bbsp_Destination" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Host"  Elementclass="input_width_190 restrict_dir_ltr" InitValue="Empty"/>    
		<li id="NumOfRepetitions" RealType="TextBox" DescRef="bbsp_NumOfPings" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.NumberOfRepetitions" Elementclass="input_width_190" InitValue="Empty"/>
		<li id="protocolType" RealType="DropDownList" DescRef="bbsp_protocoltype" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.X_HW_ProtocolType" Elementclass="width_260px restrict_dir_ltr"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
		var PingConfigFormList = new Array();
		PingConfigFormList = HWGetLiIdListByForm("table_ping", null);
		HWParsePageControlByID("table_ping", TableClass, diagnose_language, null);
		WriteOptionForPktType("protocolType");
	</script>
	<table width="100%" class="setupWifiTable setTable"> 
        <tr > 
          <td colspan="2" class="td_button">
		  	<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"> 		  	
            <button name="cancelValue" id="cancelValue" type="button" class="btn-default-orange-small right" onClick="onStopPing();"><span><script>document.write(diagnose_language['bbsp_cancel']);</script></span></button>
			<button id="btnApply_ex" name="btnApply_ex" type="button" class="btn-default-orange-small right" onClick="onApply();"><span><script>document.write(diagnose_language['bbsp_test1']);</script></span></button> 
		</td> 
        </tr>
	</table>
	<table class="setupWifiTable">
	  <thead class="">
            <th colspan="2"><script>document.write(diagnose_language['bbsp_resultados']);</script></th>
      <thead>
		<tbody>
			<tr>
				<td colspan="2" class="">
					<textarea readonly="readonly" id="testResults" style="font-size:12px;" rows="20" cols="80"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button id="clearTextarea" name="clearTextarea" type="button" class="btn-default-orange-small right" onClick="onClearResult();return false;"><span><script>document.write(diagnose_language['bbsp_clear']);</script></span></button>
				</td>
			</tr>
		</tbody>
	</table> 
</form> 
</body>
</html>

	
