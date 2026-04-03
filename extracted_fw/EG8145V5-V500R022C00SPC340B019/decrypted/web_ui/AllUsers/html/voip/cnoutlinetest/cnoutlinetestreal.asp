<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title>VOIP Interface</title>
<script language="JavaScript" type="text/javascript"> 

function stAuthState(AuthState)
{
    this.AuthState=AuthState;
}
var SimConnStates=<%HW_Web_GetCardOntAuthState(stAuthState);%>; 
var SimIsAuth=SimConnStates[0].AuthState;

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

function SetContentInBuff(OutlineTestPhyIns, OutlineTestForceFlag, SimuTestPhyIns)
{
	var Result = null;
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : './SetContentInBuff.cgi?'+'OutlineTestPhyIns='+String(OutlineTestPhyIns)+'&OutlineTestForceFlag='+String(OutlineTestForceFlag)+'&InnerLineTestPhyIns=255'+'&SimuTestPhyIns='+String(SimuTestPhyIns),
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
	else if(name == "SimulateTestSelect")
	{
		content = '<%HW_WEB_GetContentInBuff("4");%>';
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

var CurrentOutTestPhyIndex   = -2;
var CurrentSimuTestPhyIndex   = -2;
var DefaultSelectPhyIndex   = 1;

function stAllPhyTests(Domain, TestState, TestSelector)
{
    this.Domain = Domain;
    this.TestState = TestState;
    this.TestSelector = TestSelector;
}
var AllPhyTests = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.Tests, TestState|TestSelector, stAllPhyTests);%>;

function stAllPhySimulateTests(Domain, TestState, TestSelector)
{
    this.Domain = Domain;
    this.TestState = TestState;
    this.TestSelector = TestSelector;
}
var AllPhySimulateTests = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i}.Tests, TestState|TestSelector, stAllPhySimulateTests);%>;
function stSimulateTestResult(Domain, Conclusion, CallerFailReason, CalledNumber, Status)
{
    this.Domain = Domain;
    this.Conclusion = Conclusion; 
    this.CallerFailReason = CallerFailReason;
    this.CalledNumber = CalledNumber;
    this.Status = Status;
}

var AllSimulateResults = new Array(AllPhySimulateTests.length);
for (var i = 0; i < AllPhySimulateTests.length - 1; i++)
{
    if (((AllPhySimulateTests[i].TestSelector == "X_CT-COM_SimulateTest") 
            ||(AllPhySimulateTests[i].TestSelector == "X_HW_SimulateTest"))
            && (AllPhySimulateTests[i].TestState == "Requested"))
    {
        CurrentSimuTestPhyIndex = i;
    }        


        if (0 == i)
        {

            var result0 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result0[0];
        }
        if (1 == i)
        {
            var result1 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result1[0];
        }
        if (2 == i)
        {
            var result2 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result2[0];
        }
        if (3 == i)
        {
            var result3 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.4.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result3[0];
        }
        if (i == 4) {
            var result4 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.5.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result4[0];
        }
        if (i == 5) {
            var result5 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.6.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result5[0];
        }
        if (i == 6) {
            var result6 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.7.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result6[0];
        }
        if (i == 7) {
            var result7 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.8.Tests.X_HW_SimulateTest, Conclusion|CallerFailReason|CalledNumber|Status, stSimulateTestResult);%>;
            AllSimulateResults[i] = result7[0];
        }


}
function translateSimuConclusion2Chinese(englishConclusion, FailReason, Status)
{
    if(englishConclusion == 'Success')
    {
        return '测试成功';
    }
    if(Status == 'Idle')
    {
        return '本端未摘机';
    }
    if(Status == 'Off-hook')
    {
        return '本端摘机';
    }
    if(Status == 'Dialtone')
    {
        return '拨号音正常播放';
    }
    if(Status == 'Receiving')
    {
        return '拨号音停止';
    }
    if(Status == 'ReceiveEnd')
    {
        return '拨打对端号码';
    }
    if(Status == 'Ringing-back')
    {
        return '检测到振铃回铃音';
    }
    if(Status == 'Connected')
    {
        return '对端摘机，进入通话';
    }
    if(FailReason == 'NoDailTone')
    {
        return '未检测到拨号音';
    }
    if(FailReason == 'OffhookRelease')
    {
        return '本端摘机后未拨打对端号码';
    }
    if(FailReason == 'DialingRelease')
    {
        return '本端摘机拨号时释放';
    }
    if(FailReason == 'AfterDialRelease')
    {
        return '未检测到回铃音';
    }
    if(FailReason == 'NoAnswer')
    {
        return '检测到振铃回铃音，但对端未摘机';
    }
    if(FailReason == 'DTMFSendingRelease')
    {
        return '对端摘机';
    }
    if(FailReason == 'KeyError')
    {
        return '对端摘机，但按键确认失败';
    }

    return '测试未启动';
}

for (var i = 0; i < AllPhyTests.length - 1; i++)
{
    AllSimulateResults[i].Conclusion = translateSimuConclusion2Chinese(AllSimulateResults[i].Conclusion, AllSimulateResults[i].CallerFailReason, AllSimulateResults[i].Status);
}

function CheckCalledNum()
{    
    if(getValue('SimulateTelNo').length == 0)
    {
        AlertEx("请输入呼叫号码!");
        return false;
    }

	if (isSafeStringIn(getValue('SimulateTelNo'), '0123456789*#ABCDEF') == false)
	{
		AlertEx("呼叫号码不合法, 合法范围是\" 0123456789*#ABCDEF \"");
		return false;
	}
       
    return true;
}

function SubmitStartSimulateTest()
{
    var Form = new webSubmitForm();
    var PhyReferenceIndex = getSelectVal('SimulateTestSelect');
    var TelNo = getValue('SimulateTelNo');

	SetContentInBuff(255, 255, PhyReferenceIndex);
	
    var ulret = CheckCalledNum();    
    if (ulret != true )
    {
        return false;
    }

    Form.addParameter('x.TestType','Caller');
    Form.addParameter('x.CalledNumber', TelNo);
    Form.addParameter('x.DialDTMFConfirmEnable', 1);
        
    Form.addParameter('y.TestState','Requested');
    Form.addParameter('y.TestSelector','X_HW_SimulateTest');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    setDisable('startOutLineTest',1);
    setDisable('startSimulateTest',1);
    
    var urlPrefix = 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.' + String(PhyReferenceIndex)+ '.Tests';

    Form.setAction('set.cgi?x=' + urlPrefix + '.X_HW_SimulateTest'
                   + '&y=' + urlPrefix
                   + '&RequestFile=html/voip/cnoutlinetest/cnoutlinetest.asp');               

    Form.submit(); 
}
function SubmitGetSimulateTestResult()
{
    var PhyReferenceIndex = getSelectVal('SimulateTestSelect');
	SetContentInBuff(255, 255, PhyReferenceIndex);

    
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    Form.submit();
}
function DecideSimuTestSelectPhyIndex()
{
    var tempCookieValue = getLastestPhyIndexCookie('SimulateTestSelect');
    
    if (CurrentSimuTestPhyIndex >= 0)
    {    
        return CurrentSimuTestPhyIndex + 1;
    }
                
    if (null != tempCookieValue)
    {
    	if(tempCookieValue >= AllPhyInterface.length)
    	{
    		return DefaultSelectPhyIndex;
    	}
    	
        return tempCookieValue;
    }
    
    return DefaultSelectPhyIndex;
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

var RingResistance = new Array(AllPhyTests.length);
var RingResistanceConst = 1/(2*3.14*25)*1000000000;
var AllOutLineResults = new Array(AllPhyTests.length);
for (var i = 0; i < AllPhyTests.length - 1; i++)
{
    if ( (AllPhyTests[i].TestSelector == "X_HW_LineTest") && (AllPhyTests[i].TestState == "Requested") )
    {
        AllOutLineResults[i] = new stOutLineTestResult('', '', '', '', '', '', '', '', '', '', '', '', '', '', '' );
        RingResistance[i] = '';
        CurrentOutTestPhyIndex = i;
    }        
    else
    {
        if (0 == i)
        {

            var result0 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
            AllOutLineResults[i] = result0[0];
        }
        if (1 == i)
        {
            var result1 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
            AllOutLineResults[i] = result1[0];
        }
        if (2 == i)
        {
            var result2 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
            AllOutLineResults[i] = result2[0];
        }
        if (3 == i)
        {
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
        if (i ==7) {
            var result7 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.8.Tests.X_HW_LineTest, IsTestOnBusy|Conclusion|AGACVoltage|BGACVoltage|ABACVoltage|AGDCVoltage|BGDCVoltage|ABDCVoltage|AGInsulationResistance|BGInsulationResistance|ABInsulationResistance|AGCapacitance|BGCapacitance|ABCapacitance, stOutLineTestResult);%>;
            AllOutLineResults[i] = result7[0];
        }
        
        if(0 == AllOutLineResults[i].ABCapacitance)
        {
            RingResistance[i] = '∞';    
        }
        else
        {
            RingResistance[i] =  Math.floor(RingResistanceConst/(AllOutLineResults[i].ABCapacitance) + 0.5);
        }
        
        if ('' == AllOutLineResults[i].Conclusion)
        {
            AllOutLineResults[i].Conclusion = 'Normal';
        }        
    }
}

function translateOutLineConclusion2Chinese(englishConclusion)
{
    if(englishConclusion == 'Normal')
    {
        return '正常';
    }
    if(englishConclusion == 'PhoneDisconnect')
    {
        return '断线(未接话机)';
    }
    if(englishConclusion == 'PhoneOffhook')
    {
        return '未挂机';
    }
    if(englishConclusion == 'PowerLineContacted')
    {
        return '碰电力线';
    }
    if(englishConclusion == 'BothLoopLineMixOther')
    {
        return '双线它混';
    }
    if(englishConclusion == 'ALineMixOther')
    {
        return 'A线它混';
    }
    if(englishConclusion == 'BLineMixOther')
    {
        return 'B线它混';
    }    
    if(englishConclusion == 'BothLineGrounding')
    {
        return '双地气';
    }    
    if(englishConclusion == 'ALineGrounding')
    {
        return 'A线地气';
    }    
    if(englishConclusion == 'BLineGrounding')
    {
        return 'B线地气';
    }    
    if(englishConclusion == 'ABLinePoorInsulation')
    {
        return 'AB间绝缘差';
    }    
    if(englishConclusion == 'ShortCircuit')
    {
        return 'AB自混(短路)';
    }    
    if(englishConclusion == 'BothLineLeakageToGround')
    {
        return '双线对地漏电';
    }    
    if(englishConclusion == 'ALineLeakageToGround')
    {
        return 'A线对地漏电';
    }    
    if(englishConclusion == 'BLineLeakageToGround')
    {
        return 'B线对地漏电';
    }    

    return englishConclusion;
}

for (var i = 0; i < AllPhyTests.length - 1; i++)
{
    AllOutLineResults[i].Conclusion = translateOutLineConclusion2Chinese(AllOutLineResults[i].Conclusion);
}

function SubmitStartOutLineTest()
{
    var Form = new webSubmitForm();
    var PhyReferenceIndex = getSelectVal('OutLineTestSelect');
    var isBustTestVal = getCheckVal('busyTestCheckbox');

	SetContentInBuff(PhyReferenceIndex, isBustTestVal, 255);
    
    Form.addParameter('x.IsTestOnBusy', isBustTestVal);
    
    Form.addParameter('y.TestState','Requested');
    Form.addParameter('y.TestSelector','X_HW_LineTest');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    setDisable('startOutLineTest',1);
    setDisable('startSimulateTest',1);

    var urlPrefix = 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.' + String(PhyReferenceIndex)+ '.Tests';
    
    Form.setAction('set.cgi?x=' + urlPrefix + '.X_HW_LineTest'
                   + '&y=' + urlPrefix
                   + '&RequestFile=html/voip/cnoutlinetest/cnoutlinetest.asp');               
    
    
    Form.submit(); 
}

function SubmitGetOutLineTestResult()
{
    var PhyReferenceIndex = getSelectVal('OutLineTestSelect');
	SetContentInBuff(PhyReferenceIndex, 255, 255);

    
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    
    Form.submit();
}

function OutTestTimeoutProc()
{

    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.submit();
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
    		return DefaultSelectPhyIndex;
    	}
    		
        return tempCookieValue;
    }
    
    return DefaultSelectPhyIndex;
}

function LoadFrame()
{ 
    if (0 != SimIsAuth)
    {
        document.getElementById('SimShowPage').style.display="";
    }

    for (var j = 0; j < AllPhySimulateTests.length - 1; j++)
    {

        if (((AllPhySimulateTests[j].TestSelector == "X_CT-COM_SimulateTest") 
                ||(AllPhySimulateTests[j].TestSelector == "X_HW_SimulateTest"))
                && (AllPhySimulateTests[j].TestState == "Requested"))
        {
            CurrentSimuTestPhyIndex = j;
            setDisable('OutLineTestSelect', 1);
            setDisable('SimulateTestSelect', 1);
            setDisable('startSimulateTest', 1);
            break;
        }                
    }
    
    var SimSelValue = DecideSimuTestSelectPhyIndex();
    setSelect('SimulateTestSelect', SimSelValue);
    setText('SimulateTelNo',AllSimulateResults[SimSelValue-1].CalledNumber);
    if(getLastestPhyIndexCookie('SimulateTestSelect') !=  SimSelValue)
    {
		SetContentInBuff(255, 255, SimSelValue);
    }    
    
    if (-2 != CurrentSimuTestPhyIndex)
    {
        setDisable('startOutLineTest', 1);
        setDisable('startSimulateTest',1);
        setDisable('busyTestCheckbox', 1);
        setDisable('getLineTestResult', 1);        
        
        setTimeout("OutTestTimeoutProc()",3000);
    }
    
    for (var j = 0; j < AllPhyTests.length - 1; j++)
    {
        if ((AllPhyTests[j].TestSelector == "X_HW_LineTest") && (AllPhyTests[j].TestState == "Requested"))
        {
            CurrentOutTestPhyIndex = j;
            setDisable('OutLineTestSelect', 1);
            setDisable('SimulateTestSelect', 1);
            setDisable('startSimulateTest', 1);
            break;
        }                
    }
    
    var OutSelValue = DecideOutTestSelectPhyIndex();
    setSelect('OutLineTestSelect', OutSelValue);
    if(getLastestPhyIndexCookie('OutLineTestSelect') !=  OutSelValue)
    {
    	SetContentInBuff(OutSelValue, 255, 255);
    }    
    
    if (-2 != CurrentOutTestPhyIndex)
    {
        setDisable('startOutLineTest',1);
        setDisable('startSimulateTest',1);
        setDisable('busyTestCheckbox', 1);
        setDisable('getSimulateTestResult', 1);    
        
        setTimeout("OutTestTimeoutProc()",15000);
    }
    var tempCheckVal = getLastestPhyIndexCookie('busyTestCheckbox');
    if ('1' == tempCheckVal)
    {
        setCheck('busyTestCheckbox', '1');
    }
}
</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();"> 
<div id="SimShowPage" style = "display:none">
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td class="prompt"><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%"> 您可以点击"开始测试"按钮启动外线测试。 </td> 
        </tr> 
      </table></td> 
  </tr> 
</table> 
<table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 

<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr>
    <td  class="table_title" width="30%" align="left">物理端口:</td> 
    <td  class="table_right" width="70%"  align="left">
        <select name="OutLineTestSelect" id="OutLineTestSelect" style="width: 40px">
           <script language="JavaScript" type="text/javascript">
              var interfaceIndex;
              for (interfaceIndex = 1; interfaceIndex < AllPhyInterface.length; interfaceIndex++)
              {
                   document.write('<option value="' + interfaceIndex + '">' + interfaceIndex + '</option>');
              }
           </script>
      </select>
    </td> 
  </tr>
  <tr> 
    <td  class="table_title" width="30%" align="left">遇忙强测使能:</td> 
    <td  class="table_right" width="70%"  align="left"><input name="busyTestCheckbox" id="busyTestCheckbox" type="checkbox"></td> 
  </tr> 
</table> 

<table width="100%" border="0" cellspacing="1" cellpadding="0" class=""> 
  <tr> 
    <td class="" width='30%'></td> 
    <td class="" align="left">
       <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
       <input  class="submit" name="startOutLineTest" id="startOutLineTest" type="button" value="开始测试" onClick="SubmitStartOutLineTest();"> 
       <input  class="submit" name="getLineTestResult" id="getLineTestResult" type="button" value="获取结果" onClick="SubmitGetOutLineTestResult();"> </td> 
  </tr> 
</table> 

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr>
    <td  class="table_title" width="30%" align="left">测试结果:</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="ConclusionCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].Conclusion)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">A->地交流电压(单位:伏):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="AGACVoltageCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].AGACVoltage)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">B->地交流电压(单位:伏):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="BGACVoltageCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].BGACVoltage)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">A->B交流电压(单位:伏):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="ABACVoltageCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].ABACVoltage)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">A->地直流电压(单位:伏):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="AGDCVoltageCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].AGDCVoltage)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">B->地直流电压(单位:伏):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="BGDCVoltageCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].BGDCVoltage)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">A->B直流电压(单位:伏):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="ABDCVoltageCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].ABDCVoltage)
             + '</td>';
        document.write(html);    
    </script>
  </tr>  
  <tr>
    <td  class="table_title" width="30%" align="left">振铃阻抗(单位:欧):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        if( 0 == AllOutLineResults[OutSelValue-1].ABCapacitance)
        {
            html += '<td id="ABCapacitanceCell" class="table_right" width="70%" style="font-size: 18px" align="left">'
                 + htmlencode(RingResistance[OutSelValue-1])
                 + '</td>';
        }
        else
        {
            html += '<td id="ABCapacitanceCell" class="table_right" width="70%" align="left">'
                 + htmlencode(RingResistance[OutSelValue-1])
                 + '</td>';    
        }
        document.write(html);    
    </script>    
  </tr>       
  <tr>
    <td  class="table_title" width="30%" align="left">A->地电阻(单位:欧):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="AGInsulationResistanceCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].AGInsulationResistance)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">B->地电阻(单位:欧):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="BGInsulationResistanceCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].BGInsulationResistance)
             + '</td>';
        document.write(html);    
    </script>
  </tr>    
  <tr>
    <td  class="table_title" width="30%" align="left">A->B电阻(单位:欧):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="ABInsulationResistanceCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].ABInsulationResistance)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">A->地电容(单位:纳法):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="AGCapacitanceCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].AGCapacitance)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">B->地电容(单位:纳法):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="BGCapacitanceCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].BGCapacitance)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">A->B电容(单位:纳法):</td> 
    <script language="javascript">
        var OutSelValue = DecideOutTestSelectPhyIndex();
        var html = '';
        html += '<td id="ABCapacitanceCell" class="table_right" width="70%"  align="left">'
             + htmlencode(AllOutLineResults[OutSelValue-1].ABCapacitance)
             + '</td>';
        document.write(html);    
    </script>    
  </tr>     
    <script language="javascript">
        setLastestPhyIndexCookie('getOutLineTestSelect', 0, -1000);
    </script>  
</table> 


<table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td class="prompt"><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td class="title_01"  style="padding-left:10px;" width="100%"> 您可以点击"开始测试"按钮启动模拟主叫通话测试。 </td> 
        </tr> 
      </table></td> 
  </tr> 
</table> 
<table width="100%" height="10" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 

<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td></td> 
  </tr> 
</table> 
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr>
    <td  class="table_title" width="30%" align="left">物理端口:</td> 
    <td  class="table_right" width="70%"  align="left">
        <select name="SimulateTestSelect" id="SimulateTestSelect" style="width: 40px">
           <script language="JavaScript" type="text/javascript">
              var interfaceIndex;
              for (interfaceIndex = 1; interfaceIndex < AllPhyInterface.length; interfaceIndex++)
              {
                   document.write('<option value="' + interfaceIndex + '">' + interfaceIndex + '</option>');
              }
           </script>
      </select>
    </td> 
  </tr>
</table> 

<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tabal_button"> 
  <tr> 
    <td class="tabal_submit" width='30%'></td> 
    <td class="tabal_submit" align="left">
       <input  class="submit" name="startSimulateTest" id="startSimulateTest" type="button" value="开始测试" onClick="SubmitStartSimulateTest();"> 
       <input  class="submit" name="getSimulateTestResult" id="getSimulateTestResult" type="button" value="获取结果" onClick="SubmitGetSimulateTestResult();"> </td> 
  </tr>
 </table>
 <table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
    <tr>
        <td  class="table_title" width="30%" align="left">呼叫号码:</td> 
        <td class="table_right align_left" colspan="2" ><input type="text" name="SimulateTelNo" maxlength="32" id = "SimulateTelNo" class="wid_150px"/>
        <span class="gray"><script>document.write("(长度0~32)");</script></span></td>
    </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">测试结果:</td> 
    <script language="javascript">
        var OutSelValue = DecideSimuTestSelectPhyIndex();
        var html = '';
        html += '<td class="table_right align_left" colspan="2" >'
             + htmlencode(AllSimulateResults[OutSelValue-1].Conclusion)
             + '</td>';
        document.write(html);    
    </script>
  </tr>
</table> 
</div>
</body>
</html>