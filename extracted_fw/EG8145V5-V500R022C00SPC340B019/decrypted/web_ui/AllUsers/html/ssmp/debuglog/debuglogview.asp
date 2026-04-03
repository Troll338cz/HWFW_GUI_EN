<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">

var IsSupportWlanFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var IsSupportUPNPFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_UPNP_EXPAND);%>';
var DebugLogInfoText = '<%HW_WEB_GetDebugLogInfo();%>';
var WiFiLogInfoText = '<%HW_WEB_GetWiFiDebugLog();%>';
var QueryLogInfoText = '<%HW_WEB_GetQueryLogInfo();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var languageList = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE_SET.STRING);%>';
var initLanguage = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE.STRING);%>';
var languageSet = new Array();
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

if ((typeof languageList == 'string') && (languageList != '')) {
    languageSet = languageList.split("|");
}

function IsSupportPrompt()
{
    if (languageSet.length > 1) {
        for (var lang in languageSet) {
            if ((languageSet[lang] != 'english') && (languageSet[lang] != 'chinese')) {
                return false;
            }
        }
    }

    if ((initLanguage != 'english') && (initLanguage != 'chinese')) {
        return false;
    }

    if ((curLanguage != 'english') && (curLanguage != 'chinese')) {
        return false;
    }

    return true;
}

function LoadFrame()
{     

}

function RefreshByLogType()
{
	var LookLogType = getSelectVal('LogTypeVal');
	if(0 == LookLogType)
	{
		document.getElementById("logarea").value = DebugLogInfoText;
	}
	else if (1 == LookLogType)
	{
		document.getElementById("logarea").value = WiFiLogInfoText;
	}
	else if (2 == LookLogType)
	{
		document.getElementById("logarea").value = QueryLogInfoText;
	}
}

function DownloadDebugLog()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('logtype', "opt");
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('debuglogdown.cgi?FileType=debuglog&RequestFile=html/ssmp/debuglog/debuglogview.asp');
	Form.submit();
}

function DownloadWiFiLog()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('wifidebuglogdown.cgi?RequestFile=html/ssmp/debuglog/debuglogview.asp');
	Form.submit();
}

function DownloadQueryLog()
{
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('logtype', "opt");
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('querylogdown.cgi?FileType=querylog&RequestFile=html/ssmp/debuglog/debuglogview.asp');
	Form.submit();
}
  
function backupSetting()
{
	if (IsSupportPrompt() == true) {
		if (ConfirmEx(DebuglogviewLgeDes['s0b22']) == false) {
			return;
		}
	}

	var LookLogType = getSelectVal('LogTypeVal');
	var ua = navigator.userAgent.toLowerCase();	
	if (/iphone|ipad|ipod/.test(ua)) {	
		window.open("/html/ssmp/debuglog/debuglogview_ios.asp?" + LookLogType);
		return;
	}
	
	if (0 == LookLogType)
	{
		DownloadDebugLog();
	}
	else if (1 == LookLogType)
	{
		DownloadWiFiLog();
	}
	else if (2 == LookLogType)
	{
		DownloadQueryLog();
	}
}


</script>
</head>

<body  class="mainbody pageBg" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("debuglogview", GetDescFormArrayById(DebuglogviewLgeDes, "s0101"), GetDescFormArrayById(DebuglogviewLgeDes, "s0100"), false);
</script> 
<div class="title_spread"></div>
<div class="func_title" BindText="s0b0f"></div> 
<div id="backlog"> 
  <table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td> <input  class="ApplyButtoncss buttonwidth_150px_250px" name="button" id="button" type='button'  onClick='backupSetting()' BindText="s0b11" > 
	  <input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>"></td> 
    </tr> 
  </table> 
</div>
<div class="button_spread"></div>

<form id="LogviewsCfgForm" name="LogviewsCfgForm">
	<table id="LogviewsCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1">
        <script>
        if (CfgMode != "DSLSTC2WIFI") {
            if ((IsSupportWlanFlag == 1 || IsSupportUPNPFlag == 1) && (CfgMode == "ROSUNION")) {
                document.write('<li id="LogTypeVal" RealType="DropDownList" DescRef="s0b14" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="LogTypeVal"InitValue="[{TextRef:\'s0b19\',Value:\'0\'},{TextRef:\'s0b20\',Value:\'1\'}]" ClickFuncApp="onChange=RefreshByLogType"/>');
            } else if (IsSupportWlanFlag == 1 || IsSupportUPNPFlag == 1) {
                document.write('<li id="LogTypeVal" RealType="DropDownList" DescRef="s0b14" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="LogTypeVal"InitValue="[{TextRef:\'s0b19\',Value:\'0\'},{TextRef:\'s0b20\',Value:\'1\'},{TextRef:\'s0b21\',Value:\'2\'}]" ClickFuncApp="onChange=RefreshByLogType"/>');
            } else {
                document.write('<li id="LogTypeVal" RealType="DropDownList" DescRef="s0b14" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="LogTypeVal" InitValue="[{TextRef:\'s0b19\',Value:\'0\'},{TextRef:\'s0b21\',Value:\'2\'}]" ClickFuncApp="onChange=RefreshByLogType"/>');
            }
        }
</script>
	</table>
	<script>
		var LogviewsCfgFormList = new Array();
		LogviewsCfgFormList = HWGetLiIdListByForm("LogviewsCfgForm", null);
		var TableClass = new stTableClass("width_per20", "width_per80");
		HWParsePageControlByID("LogviewsCfgForm", TableClass, DebuglogviewLgeDes, null);			
	</script>
			
	<div id="logviews"> 
		<textarea name="logarea" id="logarea" class="text_log" wrap="off" readonly="readonly">
		</textarea> 
		<script type="text/javascript">
			document.getElementById("logarea").value='<%HW_WEB_GetDebugLogInfo();%>';
		</script> 
	</div> 
</form>
<script>
if (rosunionGame == "1") {
	$(".ApplyButtoncss").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
}
ParseBindTextByTagName(DebuglogviewLgeDes, "td",     1);
ParseBindTextByTagName(DebuglogviewLgeDes, "div",    1);
ParseBindTextByTagName(DebuglogviewLgeDes, "input",  2);
</script>

</body>
</html>
