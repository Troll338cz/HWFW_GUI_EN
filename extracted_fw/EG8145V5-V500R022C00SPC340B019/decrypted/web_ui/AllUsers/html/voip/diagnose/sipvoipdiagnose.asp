<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>VOIP Interface</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, diagnose);%>"></script>
<script language="JavaScript" type="text/javascript"> 


function setLastestPhyIndexCookie(name, value, expiredays)
{
	var exdate = new Date();
	
	exdate.setDate(exdate.getDate() + expiredays);
	if (null == expiredays)
	{
		document.cookie = name + "=" + value;
	}
	else
	{
		document.cookie = name + "=" + value + ";expires=" + exdate.toGMTString();
	}
}

function SetContentInBuff(OutlineTestPhyIns, OutlineTestForceFlag, InnerLineTestPhyIns)
{
	var Result = null;
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : './SetContentInBuff.cgi?'+'OutlineTestPhyIns='+String(OutlineTestPhyIns)+'&OutlineTestForceFlag='+String(OutlineTestForceFlag)+'&InnerLineTestPhyIns='+String(InnerLineTestPhyIns)+'&SimuTestPhyIns=255',
	data :'x.X_HW_Token=' + getValue('hwonttoken'),
	success : function(data) 
	{
	
	}
	});

	return null;

}

function getLastestPhyIndexCookie(name)
{
	var content = 1;
	
	if(name == "OutLineTestSelect")
	{
		content = '<%HW_WEB_GetContentInBuff("0");%>';
	}
	else if(name == "busyTestCheckbox")
	{
		content = '<%HW_WEB_GetContentInBuff("1");%>';
	}
	else if(name == "InnerLineTestSelect")
	{
		content = '<%HW_WEB_GetContentInBuff("2");%>';
	}
	else
	{
		;
	}
	
	return content;
}

function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
	this.InterfaceID = InterfaceID;
}
var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;

var CurrentInnerTestPhyIndex = -2;
var CurrentOutTestPhyIndex   = -2;

var TableClass = new stTableClass("width_per30", "width_per70", "ltr");

function SubmitStartInnerTest()
{
    var Form = new webSubmitForm();
	var PhyReferenceIndex = getSelectVal('InnerLineTestSelect');
	
	Form.addParameter('x.TestState','Requested');
	Form.addParameter('x.TestSelector','X_HW_InnerTest');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

	SetContentInBuff(255, 255, PhyReferenceIndex);
	
	setDisable('startInnerLineTest',1);
	
    Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.'	+ String(PhyReferenceIndex)+ '.Tests'
	               +'&RequestFile=html/voip/diagnose/voipdiagnose.asp');
	
    Form.submit();
}

function SubmitStartOutLineTest()
{
    var Form = new webSubmitForm();
	var PhyReferenceIndex = getSelectVal('OutLineTestSelect');
	var isBustTestVal = getCheckVal('busyTestCheckbox');
	
	Form.addParameter('x.IsTestOnBusy', isBustTestVal);	
	Form.addParameter('y.TestState','Requested');
	Form.addParameter('y.TestSelector','X_HW_LineTest');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));

	SetContentInBuff(PhyReferenceIndex, isBustTestVal, 255);
	
	setDisable('startOutLineTest',1);

	var urlPrefix = 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.' + String(PhyReferenceIndex)+ '.Tests';
	
    Form.setAction('set.cgi?x=' + urlPrefix + '.X_HW_LineTest'
	               + '&y=' + urlPrefix
				   + '&RequestFile=html/voip/diagnose/voipdiagnose.asp');
	
    Form.submit(); 
	
}

function stAllPhyTests(Domain, TestState, TestSelector)
{
	this.Domain = Domain;
	this.TestState = TestState;
	this.TestSelector = TestSelector;
}
var AllPhyTests = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.Tests, TestState|TestSelector, stAllPhyTests);%>;

function stInnerLineTestResult(Domain, LoopCurrentTestResult, FeedTestResult,RingTestResult, OnOffHookTestResult, FeedValue, RingValue, LoopCurrentValue)
{
    this.Domain = Domain;
    this.LoopCurrentTestResult = LoopCurrentTestResult; 
	this.FeedTestResult = FeedTestResult;
    this.RingTestResult = RingTestResult;
    this.OnOffHookTestResult = OnOffHookTestResult;
	this.FeedValue = FeedValue;
	this.RingValue = RingValue;
	this.LoopCurrentValue = LoopCurrentValue;
}

var AllInnerLineResults = new Array(AllPhyTests.length);
for (var i = 0; i < AllPhyTests.length - 1; i++)
{
    if (((AllPhyTests[i].TestSelector == "X_HW_InnerTest") || (AllPhyTests[i].TestSelector == "X_RTK_InnerTest")) && (AllPhyTests[i].TestState == "Requested"))
	{
		AllInnerLineResults[i] = new stInnerLineTestResult('', '', '', '', '', '', '', '');
		CurrentInnerTestPhyIndex = i;
	}
	else
	{
		if (i == 0) {
			var result0 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result0[0];
		}
		if (i == 1) {
			var result1 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result1[0];
		}
		if (i == 2) {
			var result2 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result2[0];
		}
		if (i == 3) {
			var result3 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.4.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result3[0];
		}
		if (i == 4) {
			var result4 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.5.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result4[0];
		}
		if (i == 5) {
			var result5 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.6.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result5[0];
		}
		if (i == 6) {
			var result6 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.7.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result6[0];
		}
		if (i == 7) {
			var result7 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.8.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result7[0];
		}
	}
}

function ResultNormal()
{	
    return diagnose['vspa_nor'];
}

function ResultAbnormal()
{	
    return diagnose['vspa_abnor'];
}

function ResultNotSupported()
{	
    return diagnose['vspa_notsupport'];
}

function translateInnerTestResult2Chinese( englishResult )
{
	if( englishResult == 'Normal')
	{
		return ResultNormal();
	}
	if( englishResult == 'Abnormal')
	{
		return ResultAbnormal();
	}
	if( englishResult == '')
	{
		return ResultNotSupported();
	}
	return englishResult;
}

for (var i = 0; i < AllPhyTests.length - 1; i++)
{
	AllInnerLineResults[i].LoopCurrentTestResult = translateInnerTestResult2Chinese( AllInnerLineResults[i].LoopCurrentTestResult );
	AllInnerLineResults[i].FeedTestResult = translateInnerTestResult2Chinese( AllInnerLineResults[i].FeedTestResult );
	AllInnerLineResults[i].RingTestResult = translateInnerTestResult2Chinese( AllInnerLineResults[i].RingTestResult );
	AllInnerLineResults[i].OnOffHookTestResult = translateInnerTestResult2Chinese( AllInnerLineResults[i].OnOffHookTestResult );			
}

function stOutLineTestResult(Domain, IsTestOnBusy, Conclusion,AGACVoltage, BGACVoltage, ABACVoltage, AGDCVoltage, BGDCVoltage,ABDCVoltage,AGInsulationResistance,BGInsulationResistance,ABInsulationResistance, AGCapacitance, BGCapacitance, ABCapacitance)
{
    this.Domain = Domain;
    this.IsTestOnBusy = IsTestOnBusy; 
	this.Conclusion = Conclusion;
    this.AGACVoltage = AGACVoltage;
    this.BGACVoltage = BGACVoltage;
	this.ABACVoltage = ABACVoltage;
	this.AGDCVoltage = AGDCVoltage;
	this.BGDCVoltage = BGDCVoltage;
	this.ABDCVoltage = ABDCVoltage;
    this.AGInsulationResistance = AGInsulationResistance;
    this.BGInsulationResistance = BGInsulationResistance;
	this.ABInsulationResistance = ABInsulationResistance;
	this.AGCapacitance = AGCapacitance;
	this.BGCapacitance = BGCapacitance;
	this.ABCapacitance = ABCapacitance;
}

var AllOutLineResults = new Array(AllPhyTests.length);
for (var i = 0; i < AllPhyTests.length - 1; i++)
{
    if (((AllPhyTests[i].TestSelector == "X_HW_LineTest") || (AllPhyTests[i].TestSelector == "X_RTK_LineTest")) && (AllPhyTests[i].TestState == "Requested"))
	{
		AllOutLineResults[i] = new stOutLineTestResult('', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
		CurrentOutTestPhyIndex = i;
	}		
	else
	{
		if (i == 0) {
			var result0 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result0[0];
		}
		if (i == 1) {
			var result1 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result1[0];
		}
		if (i == 2) {
			var result2 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result2[0];
		}
		if (i == 3) {
			var result3 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.4.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result3[0];
		}
		if (i == 4) {
			var result4 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.5.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result4[0];
		}
		if (i == 5) {
			var result5 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.6.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result5[0];
		}
		if (i == 6) {
			var result6 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.7.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result6[0];
		}
		if (i == 7) {
			var result7 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.8.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
			AllOutLineResults[i] = result7[0];
		}		
		if (AllOutLineResults[i].Conclusion == '') {
			AllOutLineResults[i].Conclusion = diagnose['vspa_nor'];
		}
		
	}
}

function ResPhoneDisconnect()
{	
    return diagnose['vspa_phdis'];
}

function ResPhoneOffhook()
{	
    return diagnose['vspa_phof'];
}

function ResPowerLineContacted()
{	
    return diagnose['vspa_licon'];
}

function ResBothLoopLineMixOther()
{	
    return diagnose['vspa_bom'];
}

function ResALineMixOther()
{	
    return diagnose['vspa_alm'];
}

function ResBLineMixOther()
{	
    return diagnose['vspa_blm'];
}
function ResBothLineGrounding()
{	
    return diagnose['vspa_bogr'];
}

function ResALineGrounding()
{	
    return diagnose['vspa_agr'];
}

function ResBLineGrounding()
{	
    return diagnose['vspa_bgr'];
}

function ResABLinePoorInsulation()
{	
    return diagnose['vspa_abpo'];
}

function ResShortCircuit()
{	
    return diagnose['vspa_short'];
}

function ResBothLineLeakageToGround()
{	
    return diagnose['vspa_boleak'];
}

function ResALineLeakageToGround()
{	
    return diagnose['vspa_aleak'];
}

function ResBLineLeakageToGround()
{	
    return diagnose['vspa_bleak'];
}


function translateOutLineConclusion2Chinese(englishConclusion)
{
	if(englishConclusion == 'Normal')
	{
		return ResultNormal();
	}
	if(englishConclusion == 'PhoneDisconnect')
	{
		return ResPhoneDisconnect();
	}
	if(englishConclusion == 'PhoneOffhook')
	{
		return ResPhoneOffhook();
	}
	if(englishConclusion == 'PowerLineContacted')
	{
		return ResPowerLineContacted();
	}
	if(englishConclusion == 'BothLoopLineMixOther')
	{
		return ResBothLoopLineMixOther();
	}
	if(englishConclusion == 'ALineMixOther')
	{
		return ResALineMixOther();
	}
	if(englishConclusion == 'BLineMixOther')
	{
		return ResBLineMixOther();
	}	
	if(englishConclusion == 'BothLineGrounding')
	{
		return ResBothLineGrounding();
	}	
	if(englishConclusion == 'ALineGrounding')
	{
		return ResALineGrounding();
	}	
	if(englishConclusion == 'BLineGrounding')
	{
		return ResBLineGrounding();
	}	
	if(englishConclusion == 'ABLinePoorInsulation')
	{
		return ResABLinePoorInsulation();
	}	
	if(englishConclusion == 'ShortCircuit')
	{
		return ResShortCircuit();
	}	
	if(englishConclusion == 'BothLineLeakageToGround')
	{
		return ResBothLineLeakageToGround();
	}	
	if(englishConclusion == 'ALineLeakageToGround')
	{
		return ResALineLeakageToGround();
	}	
	if(englishConclusion == 'BLineLeakageToGround')
	{
		return ResBLineLeakageToGround();
	}	

	return englishConclusion;
}

for (var i = 0; i < AllPhyTests.length - 1; i++)
{
	AllOutLineResults[i].Conclusion = translateOutLineConclusion2Chinese(AllOutLineResults[i].Conclusion);
}

function SubmitGetInnerTestResult()
{
	var PhyReferenceIndex = getSelectVal('InnerLineTestSelect');
	
	var Form = new webSubmitForm();

	SetContentInBuff(255, 255, PhyReferenceIndex);
	
	Form.submit();
}

function SubmitGetOutLineTestResult()
{
	var PhyReferenceIndex = getSelectVal('OutLineTestSelect');
	
	var Form = new webSubmitForm();
	SetContentInBuff(PhyReferenceIndex, 255, 255);
	
	Form.submit();
}

function InnerTestTimeoutProc()
{		
	var Form = new webSubmitForm();
	Form.submit();
}

function OutTestTimeoutProc()
{	
	var Form = new webSubmitForm();	
	Form.submit();
}

function DecideInnerTestSelectPhyIndex()
{

	var tempCookieValue = getLastestPhyIndexCookie('InnerLineTestSelect');
	
	if (CurrentInnerTestPhyIndex >= 0)
	{
		return CurrentInnerTestPhyIndex + 1; 
	}
	
	if (null != tempCookieValue)
	{
		if(tempCookieValue >= AllPhyInterface.length)
		{
			return 1;	
		}
		
		return tempCookieValue;
	}
	
	return 1;
}

function DecideOutTestSelectPhyIndex()
{
	var tempCookieValue = getLastestPhyIndexCookie('OutLineTestSelect');
	
	if (CurrentOutTestPhyIndex >= 0)
	{	
		return CurrentOutTestPhyIndex + 1;
	}
				
	if (null != tempCookieValue)
	{
		if(tempCookieValue >= AllPhyInterface.length)
		{
			return 1;	
		}
		
		return tempCookieValue;
	}
	
	return 1;
}


function DropDownListSelect(id, ArrayOption)
{
    var Control = getElById(id);
    var i = 1;  

    for (i = 1; i <  ArrayOption.length; i++)
    {
        var Option = document.createElement("Option");
        Option.value = i;
        Option.innerText = i;
		Option.text = i;
        Control.appendChild(Option);
    }
}




function LoadFrame()
{
	for (var i = 0; i < AllPhyTests.length - 1; i++)
	{
        if (((AllPhyTests[i].TestSelector == "X_HW_InnerTest") || (AllPhyTests[i].TestSelector == "X_RTK_InnerTest")) && (AllPhyTests[i].TestState == "Requested"))
		{
			CurrentInnerTestPhyIndex = i;
			setDisable('InnerLineTestSelect', 1);			
			break;
		}				
	}		
	for (var j = 0; j < AllPhyTests.length - 1; j++)
	{
        if (((AllPhyTests[j].TestSelector == "X_HW_LineTest") || (AllPhyTests[j].TestSelector == "X_RTK_LineTest")) && (AllPhyTests[j].TestState == "Requested"))
		{
			CurrentOutTestPhyIndex = j;
			setDisable('OutLineTestSelect', 1);			
			break;
		}				
	}
	
	var InnerSelValue = DecideInnerTestSelectPhyIndex();
	setSelect('InnerLineTestSelect', InnerSelValue);	
	if(getLastestPhyIndexCookie('InnerLineTestSelect') !=  InnerSelValue)
	{
		SetContentInBuff(255, 255, InnerSelValue);
	}	
	
	var OutSelValue = DecideOutTestSelectPhyIndex();
	setSelect('OutLineTestSelect', OutSelValue);
	if(getLastestPhyIndexCookie('OutLineTestSelect') !=  OutSelValue)
	{
		SetContentInBuff(OutSelValue, 255, 255);
	}
	
	
	if (-2 != CurrentInnerTestPhyIndex)
	{
		setDisable('startInnerLineTest', 1);
		
		setTimeout("InnerTestTimeoutProc()",10000);
	}
	if (-2 != CurrentOutTestPhyIndex)
	{
		setDisable('startOutLineTest', 1);
		setDisable('busyTestCheckbox', 1);
		
		setTimeout("OutTestTimeoutProc()",15000);
	}
	
	var tempCheckVal = getLastestPhyIndexCookie('busyTestCheckbox');
	if ('1' == tempCheckVal)
	{
		setCheck('busyTestCheckbox', '1');
	}
	
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = diagnose[b.getAttribute("BindText")];
	}
}
</script>
</head>
<body  class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipDiagnose", GetDescFormArrayById(diagnose, "v01"), GetDescFormArrayById(diagnose, "vspa_diag"), false);
</script>

<div class="title_spread"></div>
<form id="OutLineTestSet">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
<tr><td class="width_100p align_left" BindText='vspa_outlinetext'></td> </tr> 
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
<li  id="OutLineTestSelect" RealType="DropDownList" DescRef="vspa_potsindex"  RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="Empty"   InitValue="Empty"/>
<li  id="busyTestCheckbox"  RealType="CheckBox"     DescRef="vspa_testonbusy" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"  BindField="x.IsTestOnBusy"   InitValue="Empty"/>
<script>
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var VoipConfigFormList1 = HWGetLiIdListByForm("OutLineTestSet", null);
HWParsePageControlByID("OutLineTestSet", TableClass, diagnose, null);
var OutLinetestSetArray = new Array();
var OutSelValue = DecideOutTestSelectPhyIndex();
DropDownListSelect("OutLineTestSelect",AllPhyInterface);
HWSetTableByLiIdList(VoipConfigFormList1, OutLinetestSetArray, null);
</script>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button"> 
  <tr> 
    <td class="table_submit width_per30"></td> 
    <td class="table_submit align_left">
        <input name="startOutLineTest" id="startOutLineTest" type="button" class="ApplyButtoncss" value="Start Test" onClick="SubmitStartOutLineTest();"/>
        <script type="text/javascript">
            document.getElementsByName('startOutLineTest')[0].value = diagnose['vspa_start'];
            if (CfgMode.toUpperCase() == 'DINFOTEK2') {
                document.getElementById("startOutLineTest").style.backgroundColor = "#0cb433";
            }
        </script>
        <input name="getLineTestResult" id="getLineTestResult" type="button" class="CancleButtonCss" value="Get Result" onClick="SubmitGetOutLineTestResult();"/>
        <script type="text/javascript">
            document.getElementsByName('getLineTestResult')[0].value = diagnose['vspa_getresult'];
            if (CfgMode.toUpperCase() == 'DINFOTEK2') {
                document.getElementById("getLineTestResult").style.backgroundColor = "#0cb433";
            }        
        </script>
    </td>
  </tr> 
</table> 
</form>

<form id="OutLineTestTable">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
<li  id="ConclusionCell"     RealType="HtmlText"      DescRef="vspa_testresult"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="ConclusionCell"   InitValue="Empty"/>
<li  id="AGACVoltageCell"     RealType="HtmlText"      DescRef="vspa_atgac"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="AGACVoltageCell"   InitValue="Empty"/>
<li  id="BGACVoltageCell"     RealType="HtmlText"      DescRef="vspa_btgac"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="BGACVoltageCell"   InitValue="Empty"/>
<li  id="ABACVoltageCell"     RealType="HtmlText"      DescRef="vspa_atbac"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="ABACVoltageCell"   InitValue="Empty"/>
<li  id="AGDCVoltageCell"     RealType="HtmlText"      DescRef="vspa_atgdc"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="AGDCVoltageCell"   InitValue="Empty"/>
<li  id="BGDCVoltageCell"     RealType="HtmlText"      DescRef="vspa_btgdc"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="BGDCVoltageCell"   InitValue="Empty"/>
<li  id="ABDCVoltageCell"     RealType="HtmlText"      DescRef="vspa_atbdc"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="ABDCVoltageCell"   InitValue="Empty"/>
<li  id="AGInsulationResistanceCell"     RealType="HtmlText"      DescRef="vspa_atgr"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="AGInsulationResistanceCell"   InitValue="Empty"/>
<li  id="BGInsulationResistanceCell"     RealType="HtmlText"      DescRef="vspa_btgr"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="BGInsulationResistanceCell"   InitValue="Empty"/>
<li  id="ABInsulationResistanceCell"     RealType="HtmlText"      DescRef="vspa_atbr"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="ABInsulationResistanceCell"   InitValue="Empty"/>
<li  id="AGCapacitanceCell"     RealType="HtmlText"      DescRef="vspa_atgc"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="AGCapacitanceCell"   InitValue="Empty"/>
<li  id="BGCapacitanceCell"     RealType="HtmlText"      DescRef="vspa_btgc"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="BGCapacitanceCell"   InitValue="Empty"/>
<li  id="ABCapacitanceCell"     RealType="HtmlText"      DescRef="vspa_atbc"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="ABCapacitanceCell"   InitValue="Empty"/>
<script>
var VoipConfigFormList2 = HWGetLiIdListByForm("OutLineTestTable", null);
HWParsePageControlByID("OutLineTestTable", TableClass, diagnose, null);
var OutLinetestArray = new Array();
var OutSelValue = DecideOutTestSelectPhyIndex();
OutLinetestArray["ConclusionCell"] = AllOutLineResults[OutSelValue-1].Conclusion;
OutLinetestArray["AGACVoltageCell"] = AllOutLineResults[OutSelValue-1].AGACVoltage;
OutLinetestArray["BGACVoltageCell"] = AllOutLineResults[OutSelValue-1].BGACVoltage;
OutLinetestArray["ABACVoltageCell"] = AllOutLineResults[OutSelValue-1].ABACVoltage;
OutLinetestArray["AGDCVoltageCell"] = AllOutLineResults[OutSelValue-1].AGDCVoltage;
OutLinetestArray["BGDCVoltageCell"] = AllOutLineResults[OutSelValue-1].BGDCVoltage;
OutLinetestArray["ABDCVoltageCell"] = AllOutLineResults[OutSelValue-1].ABDCVoltage;
OutLinetestArray["AGInsulationResistanceCell"] = AllOutLineResults[OutSelValue-1].AGInsulationResistance;
OutLinetestArray["BGInsulationResistanceCell"] = AllOutLineResults[OutSelValue-1].BGInsulationResistance;
OutLinetestArray["ABInsulationResistanceCell"] = AllOutLineResults[OutSelValue-1].ABInsulationResistance;
OutLinetestArray["AGCapacitanceCell"] = AllOutLineResults[OutSelValue-1].AGCapacitance;
OutLinetestArray["BGCapacitanceCell"] = AllOutLineResults[OutSelValue-1].BGCapacitance;
OutLinetestArray["ABCapacitanceCell"] = AllOutLineResults[OutSelValue-1].ABCapacitance;
HWSetTableByLiIdList(VoipConfigFormList2, OutLinetestArray, null);
</script>
</table>
</form>

<div class="func_spread"></div>

<form id="InnerTestSet">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_head"> 
<tr><td  width="100% align_left" BindText='vspa_innerlinetest'></td></tr> 
</table> 
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
<li  id="InnerLineTestSelect"     RealType="DropDownList"      DescRef="vspa_potsindex"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="Empty"   InitValue="Empty"/>
<script>
var VoipConfigFormList = HWGetLiIdListByForm("InnerTestSet", null);
HWParsePageControlByID("InnerTestSet", TableClass, diagnose, null);
var InnertestSetArray = new Array();
var InnerSelValue = DecideInnerTestSelectPhyIndex();
DropDownListSelect("InnerLineTestSelect",AllPhyInterface);
HWSetTableByLiIdList(VoipConfigFormList, InnertestSetArray, null);
</script>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button"> 
  <tr> 
    <td class="table_submit width_per30"></td> 
    <td class="table_submit align_left">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<input name="startInnerLineTest" id="startInnerLineTest" type="button" class="ApplyButtoncss" value="Start Test" onClick="SubmitStartInnerTest();"/>
	<script type="text/javascript">
        document.getElementsByName('startInnerLineTest')[0].value = diagnose['vspa_start'];
		if (CfgMode.toUpperCase() == 'DINFOTEK2') {
			document.getElementById("startInnerLineTest").style.backgroundColor = "#0cb433";
		}
	</script>
	<input name="getInnerLineTestResult" id="getInnerLineTestResult" type="button" class="CancleButtonCss " value="Get Result" onClick="SubmitGetInnerTestResult();"/>
	<script type="text/javascript">
        document.getElementsByName('getInnerLineTestResult')[0].value = diagnose['vspa_getresult'];
		if (CfgMode.toUpperCase() == 'DINFOTEK2') {
			document.getElementById("getInnerLineTestResult").style.backgroundColor = "#0cb433";
		}
	</script>	  
	  </td>  
  </tr> 
</table>
</form>
<form id="InnerTestTable">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg">
<li  id="LoopCurrentTestResultCell" RealType="HtmlText" DescRef="vspa_loopcur" RemarkRef="Empty"  ErrorMsgRef="Empty"  Require="FALSE"  BindField="LoopCurrentTestResultCell"   InitValue="Empty"/>
<li  id="FeedTestResultCell"  RealType="HtmlText"  DescRef="vspa_feedtest"  RemarkRef="Empty"     ErrorMsgRef="Empty" Require="FALSE" BindField="FeedTestResultCell"   InitValue="Empty"/>
<li  id="RingTestResultCell"     RealType="HtmlText"      DescRef="vspa_ringtest"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="RingTestResultCell"   InitValue="Empty"/>
<li  id="OnOffHookTestResultCell"     RealType="HtmlText"      DescRef="vspa_onoffhook"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="OnOffHookTestResultCell"   InitValue="Empty"/>
<li  id="LoopCurrentValueCell"     RealType="HtmlText"      DescRef="vspa_loopcurvalue"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="LoopCurrentValueCell"   InitValue="Empty"/>
<li  id="FeedValueCell"     RealType="HtmlText"      DescRef="vspa_feedv"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="FeedValueCell"   InitValue="Empty"/>
<li  id="RingValueCell"     RealType="HtmlText"      DescRef="vspa_ringv"  RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="RingValueCell"   InitValue="Empty"/>
<script>
var VoipConfigFormList = HWGetLiIdListByForm("InnerTestTable", null);
HWParsePageControlByID("InnerTestTable", TableClass, diagnose, null);
var InnertestArray = new Array();
var InnerSelValue = DecideInnerTestSelectPhyIndex();
InnertestArray["LoopCurrentTestResultCell"] = AllInnerLineResults[InnerSelValue-1].LoopCurrentTestResult;
InnertestArray["FeedTestResultCell"] = AllInnerLineResults[InnerSelValue-1].FeedTestResult;
InnertestArray["RingTestResultCell"] = AllInnerLineResults[InnerSelValue-1].RingTestResult;
InnertestArray["OnOffHookTestResultCell"] = AllInnerLineResults[InnerSelValue-1].OnOffHookTestResult;
InnertestArray["LoopCurrentValueCell"] = AllInnerLineResults[InnerSelValue-1].LoopCurrentValue;
InnertestArray["FeedValueCell"] = AllInnerLineResults[InnerSelValue-1].FeedValue;
InnertestArray["RingValueCell"] = AllInnerLineResults[InnerSelValue-1].RingValue;
HWSetTableByLiIdList(VoipConfigFormList, InnertestArray, null);
</script>
</table>
</form> 
<br>
</body>
</html>
