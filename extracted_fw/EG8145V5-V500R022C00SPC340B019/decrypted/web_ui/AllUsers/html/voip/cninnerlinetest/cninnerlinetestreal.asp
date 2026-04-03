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
function SetContentInBuff(InnerLineTestPhyIns)
{
	var Result = null;
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : './SetContentInBuff.cgi?'+'OutlineTestPhyIns=255'+'&OutlineTestForceFlag=255'+'&InnerLineTestPhyIns='+String(InnerLineTestPhyIns)+'&SimuTestPhyIns=255',
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
	
	if(name == "InnerLineTestSelect")
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
	if ( (AllPhyTests[i].TestSelector == "X_HW_InnerTest") && (AllPhyTests[i].TestState == "Requested") )	
	{
		AllInnerLineResults[i] = new stInnerLineTestResult('', '', '', '', '', '', '', '');
		CurrentInnerTestPhyIndex = i;
	}
	else
	{
		if (0 == i)
		{
			var result0 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result0[0];
		}
		if (1 == i)
		{
			var result1 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result1[0];
		}
		if (2 == i)
		{
			var result2 = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.Tests.X_HW_InnerTest, LoopCurrentTestResult|FeedTestResult|RingTestResult|OnOffHookTestResult|FeedValue|RingValue|LoopCurrentValue, stInnerLineTestResult);%>;
			AllInnerLineResults[i] = result2[0];
		}
		if (3 == i)
		{
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

function translateInnerTestResult2Chinese( englishResult )
{
	if( englishResult == 'Normal')
	{
		return '正常';
	}
	if( englishResult == 'Abnormal')
	{
		return '异常';
	}
	if( englishResult == '')
	{
		return '--';
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

function SubmitStartInnerTest()
{
    var Form = new webSubmitForm();
	var PhyReferenceIndex = getSelectVal('InnerLineTestSelect');
	
	Form.addParameter('x.TestState','Requested');
	Form.addParameter('x.TestSelector','X_HW_InnerTest');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	
	setDisable('startInnerLineTest',1);
	
    Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.VoiceService.1.PhyInterface.'	+ String(PhyReferenceIndex)+ '.Tests'
	               +'&RequestFile=html/voip/cninnerlinetest/cninnerlinetest.asp');
	
	SetContentInBuff(PhyReferenceIndex);
	
    Form.submit();
}

function SubmitGetInnerTestResult()
{
	var PhyReferenceIndex = getSelectVal('InnerLineTestSelect');
	SetContentInBuff(PhyReferenceIndex);
	
	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}


function InnerTestTimeoutProc()
{

	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
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

function LoadFrame()
{ 
    if (0 != SimIsAuth)
    {
        document.getElementById('SimShowPage').style.display="";
    }

	for (var i = 0; i < AllPhyTests.length - 1; i++)
	{
		if ((AllPhyTests[i].TestSelector == "X_HW_InnerTest") && (AllPhyTests[i].TestState == "Requested"))
		{
			CurrentInnerTestPhyIndex = i;
			
			setDisable('InnerLineTestSelect', 1);
			
			break;
		}				
	}	
	
	var InnerSelValue = DecideInnerTestSelectPhyIndex();
	setSelect('InnerLineTestSelect', InnerSelValue);
	if(getLastestPhyIndexCookie('InnerLineTestSelect') !=  InnerSelValue)
	{
		SetContentInBuff(InnerSelValue);
	}
	
	if (-2 != CurrentInnerTestPhyIndex)
	{
		setDisable('startInnerLineTest', 1);

		setTimeout("InnerTestTimeoutProc()",10000);
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
          <td class="title_01"  style="padding-left:10px;" width="100%"> 您可以点击"开始测试"按钮启动内线测试，请在内线测试前断开话机与设备的连接。 </td> 
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
		<select name="InnerLineTestSelect" id="InnerLineTestSelect" style="width: 40px">
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

<table width="100%" border="0" cellspacing="1" cellpadding="0" class=""> 
  <tr> 
    <td class="" width='30%'></td> 
    <td class="" align="left">
	  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
	  <input  class="submit" name="startInnerLineTest" id="startInnerLineTest" type="button" value="开始测试" onClick="SubmitStartInnerTest();"> 
      <input  class="submit" name="getInnerLineTestResult" id="getInnerLineTestResult" type="button" value="获取结果" onClick="SubmitGetInnerTestResult();"> </td>  
  </tr> 
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"> 
  <tr>
    <td  class="table_title" width="30%" align="left">环路电流测试结果:</td> 
	<script language="javascript">
		var InnerSelValue = DecideInnerTestSelectPhyIndex();
		var html = '';
		html += '<td id="LoopCurrentTestResultCell" class="table_right" width="70%"  align="left">'
		     + htmlencode(AllInnerLineResults[InnerSelValue-1].LoopCurrentTestResult);
			 + '</td>';
		document.write(html);	 
	</script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">馈电电压测试结果:</td> 
	<script language="javascript">
		var InnerSelValue = DecideInnerTestSelectPhyIndex();
		var html = '';
		html += '<td  id="FeedTestResultCell" class="table_right" width="70%"  align="left">'
		     + htmlencode(AllInnerLineResults[InnerSelValue-1].FeedTestResult);
			 + '</td>';
		document.write(html);	 
	</script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">振铃测试结果:</td> 
	<script language="javascript">
		var InnerSelValue = DecideInnerTestSelectPhyIndex();
		var html = '';
		html += '<td  id="RingTestResultCell" class="table_right" width="70%"  align="left">'
		     + htmlencode(AllInnerLineResults[InnerSelValue-1].RingTestResult);
			 + '</td>';
		document.write(html);	 
	</script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">摘挂机测试结果:</td> 
	<script language="javascript">
		var InnerSelValue = DecideInnerTestSelectPhyIndex();
		var html = '';
		html += '<td  id="OnOffHookTestResultCell" class="table_right" width="70%"  align="left">'
		     + htmlencode(AllInnerLineResults[InnerSelValue-1].OnOffHookTestResult);
			 + '</td>';
		document.write(html);	 
	</script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">环路电流测试值(单位:毫安):</td> 
	<script language="javascript">
		var InnerSelValue = DecideInnerTestSelectPhyIndex();
		var html = '';
		html += '<td  id="LoopCurrentValueCell" class="table_right" width="70%"  align="left">'
		     + htmlencode(AllInnerLineResults[InnerSelValue-1].LoopCurrentValue);
			 + '</td>';
		document.write(html);	 
	</script>
  </tr>
  <tr>
    <td  class="table_title" width="30%" align="left">馈电电压测试值(单位:毫伏):</td> 
	<script language="javascript">
		var InnerSelValue = DecideInnerTestSelectPhyIndex();
		var html = '';
		html += '<td  id="FeedValueCell" class="table_right" width="70%"  align="left">'
		     + htmlencode(AllInnerLineResults[InnerSelValue-1].FeedValue);
			 + '</td>';
		document.write(html);	 
	</script> 
  </tr>  
  <tr>
    <td  class="table_title" width="30%" align="left">振铃电压测试值(单位:毫伏):</td> 
	<script language="javascript">
		var InnerSelValue = DecideInnerTestSelectPhyIndex();
		var html = '';
		html += '<td  id="RingValueCell" class="table_right" width="70%"  align="left">'
		     + htmlencode(AllInnerLineResults[InnerSelValue-1].RingValue);
			 + '</td>';
		document.write(html);
	</script>
	
	<script language="javascript">
		setLastestPhyIndexCookie('getInnerLineTestSelect', 0, -1000);
	</script>
  </tr>
</table>
</div>
</body>
</html>