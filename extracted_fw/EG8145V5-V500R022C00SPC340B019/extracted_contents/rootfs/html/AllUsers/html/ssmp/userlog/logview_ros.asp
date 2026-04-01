<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" type='text/css' href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link rel="stylesheet" type='text/css' href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<script language="JavaScript" type="text/javascript">
function stSyslogCfg(domain,Enable,Level,LogUploadEnable,LogUploadInterval,UploadServer,Username,Password)
{
	this.domain = domain;
	this.Enable = Enable;
	this.Level = Level;
	this.LogUploadEnable = LogUploadEnable;
	this.LogUploadInterval = LogUploadInterval;
	this.UploadServer = UploadServer;
	this.Username = Username;
	this.Password = Password;
}
var curUserType = '<%HW_WEB_GetUserType();%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var temp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_Syslog, Enable|Level|LogUploadEnable|LogUploadInterval|UploadServer|Username|Password, stSyslogCfg);%>;
var SyslogCfg = temp[0];
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';

function GetSyslogConfigPara(domain, logServerEnable, serverAddress, serverPort, policyMode, Interface) {
    this.domain = domain;
    this.logServerEnable = logServerEnable;
    this.serverAddress = serverAddress;
    this.serverPort = serverPort;
    this.policyMode = policyMode;
    this.Interface = Interface;
}

var syslogConfig = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_SyslogConfig, LogServerEnable|ServerAddress|ServerPort|PolicyMode|Interface, GetSyslogConfigPara);%>;
var syslogConfigPara = syslogConfig[0]

var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>'; 
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

function FillSyslogConfigPara(){
    setCheck('ServerEnable_DEFHIDE', syslogConfigPara.logServerEnable);
    setText('UploadLogAddr_DEFHIDE', syslogConfigPara.serverAddress);
    setText('UploadLogPort_DEFHIDE', syslogConfigPara.serverPort);
    setSelect('UploadLogMode_DEFHIDE', syslogConfigPara.policyMode);
    setSelect('WAN_NAME', syslogConfigPara.Interface);
}

function IsRouteWan(Wan)
{
	if (Wan.Mode =="IP_Routed")
	{
		return true;
	} 
	return false;
}

function LoadFrame() {
    setCheck('LogEnable', SyslogCfg.Enable);
    setSelect('Level', SyslogCfg.Level);

    top.SaveLogContent = document.getElementById("logarea").value;
    setDisable('Level',1);

    if (CfgMode.toUpperCase() != 'ROSUNION') {
        setCheck('UploadLogEnable', SyslogCfg.LogUploadEnable);
        setText('UploadLogInterval', SyslogCfg.LogUploadInterval);
        setText('UploadLogURL', SyslogCfg.UploadServer);
        setText('UploadLogUsername', SyslogCfg.Username);
        setText('UploadLogPassword', SyslogCfg.Password);
    }

    if ((curLanguage.toUpperCase() != "CHINESE" && CfgMode != "ROSUNION")||(curUserType == '1' && CfgMode == "ROSUNION")) {
        setDisable('LogEnable', 1);
        setDisable('btnApply', 1);
        setDisable('cancelValue', 1);
    }

    if (CfgMode.toUpperCase() == 'ROSUNION') {
        if (curUserType == '0') {
            setDisable('Level', 0);
            setDisplay("clearlog", 1);
        }

        setDisplay("UploadLogEnableRow", 0);
        setDisplay("UploadLogIntervalRow", 0);
        setDisplay("UploadLogURLRow", 0);
        setDisplay("UploadLogUsernameRow", 0);
        setDisplay("UploadLogPasswordRow", 0);
        setDisplay("ServerEnable_DEFHIDERow", 1);
        setDisplay("UploadLogAddr_DEFHIDERow", 1);
        setDisplay("WAN_NAMERow", 1);
        setDisplay("UploadLogPort_DEFHIDERow", 1);
        setDisplay("UploadLogMode_DEFHIDERow", 1);
        FillSyslogConfigPara();
    }
}

function GetLogTypeDes(key)
{
	if (1 == SonetFlag)
	{
		if("0" == key) return '[構成ログ]';
		if("1" == key) return '[シェルログ]';
		if("2" == key) return '[アラームログ]';
	}
	else
	{
		if(curLanguage == "chinese")
		{
			if("0" == key) return '['+LogviewLgeDes['s0b15']+']';
			if("1" == key) return '['+LogviewLgeDes['s0b16']+']';
			if("2" == key) return '['+LogviewLgeDes['s0b17']+']';
		}
		else
		{
			if("0" == key) return '[Config-Log]';
			if("1" == key) return '[Shell-Log]';
			if("2" == key) return '[Alarm-Log]';
		}

	}

	return "All";
}

function CheckForm()
{
	return true;
}

function CancelConfig()
{
	setCheck('LogEnable', SyslogCfg.Enable);
	setSelect('Level', SyslogCfg.Level);
}

function AddSubmitParam(SubmitForm,type)
{
	SubmitForm.addParameter('x.Enable',getCheckVal('LogEnable'));

	if (CfgMode.toUpperCase() == 'ROSUNION') {
		SubmitForm.addParameter('x.Level', getSelectVal('Level'));
	}
	
	SubmitForm.setAction('set.cgi?x=InternetGatewayDevice.DeviceInfo.X_HW_Syslog'
					   + '&RequestFile=html/ssmp/userlog/logview_ros.asp');

	setDisable('btnApply',1);
	setDisable('cancelValue',1);
}

function ViewLog()
{
	var Form = new webSubmitForm();
	Form.addParameter('InternetGatewayDevice.X_ATP_SyslogConfig.DisplayLevel',
					  getSelectVal('DisplayLevel'));
	Form.setAction('set.cgi?RequestFile=html/ssmp/userlog/logview_ros.asp');
	Form.submit();
}

function backupSetting()
{
	var ua = navigator.userAgent.toLowerCase();	
	if (/iphone|ipad|ipod/.test(ua)) {
		window.open("/html/ssmp/userlog/logview_ios.asp");
		return;
	}
	XmlHttpSendAspFlieWithoutResponse("../common/StartFileLoad.asp");
	var Form = new webSubmitForm();
	Form.addParameter('logtype', "opt");
	Form.setAction('logviewdown.cgi?FileType=log&RequestFile=html/ssmp/userlog/logview_ros.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}


function RefreshByLogType()
{
	var OldLogText = top.SaveLogContent;
	var LookLogType = getSelectVal('LogTypeVal');
	setSelect('LogTypeVal', LookLogType);

	var LookLogTypeDes = GetLogTypeDes(LookLogType);

	if("All" == LookLogTypeDes)
	{
		document.getElementById("logarea").value = OldLogText;
		return;
	}

	var ResultLog = OldLogText.split("\n");
	var NewShowLog = "";
	for (var i = 0; i < ResultLog.length -1; i++ )
	{
		if (ResultLog[i] != "\r\n" || ResultLog[i] != "" ||  ResultLog[i] != "\0")
		{
			if (-1 != ResultLog[i].indexOf(LookLogTypeDes))
			{
				NewShowLog += ResultLog[i];
				NewShowLog += "\n";
			}
		}
	}

	document.getElementById("logarea").value = NewShowLog;
}

function SrvSubmit() {
    var Form = new webSubmitForm();
    var cfgUrl = "InternetGatewayDevice.DeviceInfo.X_HW_Syslog";
    var enable = 0;

    Form.usingPrefix('x');
    if (CfgMode.toUpperCase() == 'ROSUNION') {
        cfgUrl = "InternetGatewayDevice.DeviceInfo.X_HW_SyslogConfig";
        enable = getCheckVal('ServerEnable_DEFHIDE');
        Form.addParameter('LogServerEnable', enable);
    } else {
        enable = getCheckVal('UploadLogEnable');
        Form.addParameter('LogUploadEnable', enable);
    }

    if (enable == 1) {
        if (CfgMode.toUpperCase() == 'ROSUNION') {
            Form.addParameter('ServerAddress', getValue('UploadLogAddr_DEFHIDE'));
            Form.addParameter('ServerPort', getValue('UploadLogPort_DEFHIDE'));
            Form.addParameter('PolicyMode', getSelectVal('UploadLogMode_DEFHIDE'));
        } else {
            Form.addParameter('LogUploadInterval', getValue('UploadLogInterval'));
            Form.addParameter('UploadServer', getValue('UploadLogURL'));
            Form.addParameter('Username', getValue('UploadLogUsername'));

            if(SyslogCfg.Password != getValue('UploadLogPassword'))
            {
                Form.addParameter('Password', getValue('UploadLogPassword'));
            }
        }
    }
    Form.addParameter('Interface',getSelectVal('WAN_NAME'));
    Form.endPrefix();
    Form.addParameter('x.X_HW_Token', getValue('hwonttoken'));
    Form.setAction('set.cgi?x=' + cfgUrl + '&RequestFile=html/ssmp/userlog/logview_ros.asp');
    Form.submit();
}

function CancelSrvSubmit() {
    if (CfgMode.toUpperCase() == 'ROSUNION') {
        FillSyslogConfigPara();
    } else {
        setCheck('UploadLogEnable', SyslogCfg.LogUploadEnable);
        setText('UploadLogInterval', SyslogCfg.LogUploadInterval);
        setText('UploadLogURL', SyslogCfg.UploadServer);
        setText('UploadLogUsername', SyslogCfg.Username);
        setText('UploadLogPassword', SyslogCfg.Password);
    }
}

function ClearLogs() {
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('clearlog.cgi?&RequestFile=html/ssmp/userlog/logview_ros.asp');
    Form.submit();
}

</script>
</head>

<body  class="mainbody" onLoad="LoadFrame();">
	<script language="JavaScript" type="text/javascript">
		HWCreatePageHeadInfo("logview", GetDescFormArrayById(LogviewLgeDes, "s0101"), GetDescFormArrayById(LogviewLgeDes, "s0100"), false);
	</script>
	<div class="title_spread"></div>
	<div class="func_title" BindText="s0b12"></div><!-- function 1: log config -->
	<form id="LogEnableCfgForm"  name="LogEnableCfgForm">
		<table id="LogEnableCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1">
			<li id="LogEnable" RealType="CheckBox"     DescRef="s0b03" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty"/>
			<li id="Level"     RealType="DropDownList" DescRef="s0b04" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Level"
				InitValue="[{TextRef:'s0b05',Value:'0'},{TextRef:'s0b06',Value:'1'},{TextRef:'s0b07',Value:'2'},{TextRef:'s0b08',Value:'3'},{TextRef:'s0b09',Value:'4'},{TextRef:'s0b0a',Value:'5'},{TextRef:'s0b0b',Value:'6'},{TextRef:'s0b0c',Value:'7'}]"/>
		</table>
		<script>
			var LogEnableCfgFormList = new Array();
			LogEnableCfgFormList = HWGetLiIdListByForm("LogEnableCfgForm", null);
			var TableClass = new stTableClass("width_per20", "width_per80");
			HWParsePageControlByID("LogEnableCfgForm", TableClass, LogviewLgeDes, null);

			var LogEnableArray = new Array();
			LogEnableArray["Enable"] = SyslogCfg.Enable;
			LogEnableArray["Level"] = SyslogCfg.Level;
			HWSetTableByLiIdList(LogEnableCfgFormList, LogEnableArray, null);
		</script>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per20"></td>
				<td class="table_submit"> 
					<input type="button" name="btnApply"    id="btnApply"    class="ApplyButtoncss buttonwidth_100px"  BindText="s0b0d" onClick="Submit();">
					<input type="button" name="cancelValue" id="cancelValue" class="CancleButtonCss buttonwidth_100px" BindText="s0b0e" onClick="CancelConfig();">
				</td>
			</tr>
		</table>
	</form>
	<div class="func_spread"></div>
	
	<form id="BackLogForm" action="">
		<div class="func_title" BindText="s0b19"></div>
		<table id="table_backup_log" width="100%" cellspacing="1" cellpadding="0">
			<li id="UploadLogEnable" RealType="CheckBox"     DescRef="s0b20" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty"/>		
			<li id="UploadLogInterval"  RealType="TextBox" DescRef="s0b21" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
			<li id="UploadLogURL"  RealType="TextBox" DescRef="s0b22" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
			<li id="UploadLogUsername"  RealType="TextBox" DescRef="s0b23" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
			<li id="UploadLogPassword"  RealType="TextBox" DescRef="s0b24" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
            <li id="ServerEnable_DEFHIDE" RealType="CheckBox" DescRef="s0b35" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Enable" InitValue="Empty"/>
            <li id="WAN_NAME"  RealType="DropDownList" DescRef="s0b36" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
            <li id="UploadLogAddr_DEFHIDE"  RealType="TextBox" DescRef="s0b30" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
			<li id="UploadLogPort_DEFHIDE"  RealType="TextBox" DescRef="s0b31" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty" ElementClass="UserInput" InitValue="Empty"/>
			<li id="UploadLogMode_DEFHIDE" RealType="DropDownList" DescRef="s0b32" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Level" InitValue="[{TextRef:'s0b33',Value:'UDP'},{TextRef:'s0b34',Value:'TCPSSL'}]"/>
        </table>

		<script>
			var UsbConfigFormList = HWGetLiIdListByForm("BackLogForm", null);
			var formid_hide_id = null;
			var TableClass = new stTableClass("width_per20", "width_per80");
			
			HWParsePageControlByID("BackLogForm", TableClass, LogviewLgeDes, formid_hide_id);
		</script>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="table_button">
			<tr>
				<td class="table_submit width_per20"></td>
				<td class="table_submit">
					<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>" />
					<input type="button" name="btnDownSrvApply"  id="btnDownSrvApply"  class="ApplyButtoncss  buttonwidth_100px" BindText="s0b0d" onClick='SrvSubmit()' />
					<input type="button" name="cancelSrvValue" id="cancelSrvValue" class="CancleButtonCss buttonwidth_100px" BindText="s0b0e" onClick="CancelSrvSubmit();">
				</td>
			</tr>
		</table>
		<div class="func_spread"></div>
    </form>
    <div id="clearlog" style="display:none">
		<div class="func_title" BindText="s0b37"></div>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<input class="ApplyButtoncss buttonwidth_150px_250px" name="button" id="button" type='button'  onClick='ClearLogs()' BindText="s0b37" />
				</td>
			</tr>
		</table>
	</div>
	<div class="func_spread"></div>
	<div class="func_title" BindText="s0b0f"></div><!-- function 2: log backup -->
	<div id="backlog">
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<input class="ApplyButtoncss buttonwidth_150px_250px" name="button" id="button" type='button'  onClick='backupSetting()' BindText="s0b11" />
				</td>
			</tr>
		</table>
		<div class="button_spread"></div>
		<form id="LogviewsCfgForm" name="LogviewsCfgForm">
			<table id="LogviewsCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1">
				<li id="LogTypeVal" RealType="DropDownList" DescRef="s0b14" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="LogTypeVal"
				InitValue="[{TextRef:'s0b18',Value:'All'},{TextRef:'s0b15',Value:'0'},{TextRef:'s0b16',Value:'1'},{TextRef:'s0b17',Value:'2'}]" ClickFuncApp="onChange=RefreshByLogType"/>
			</table>
			<script>
				var LogviewsCfgFormList = new Array();
				LogviewsCfgFormList = HWGetLiIdListByForm("LogviewsCfgForm", null);
				var TableClass = new stTableClass("width_per20", "width_per80");
				HWParsePageControlByID("LogviewsCfgForm", TableClass, LogviewLgeDes, null);
			</script>

			<div id="logviews">
				<textarea dir="ltr" name="logarea" id="logarea" class="text_log" wrap="off" readonly="readonly"></textarea>
				<script type="text/javascript">
				    document.getElementById("logarea").value='<%HW_WEB_GetLogInfo();%>';
				</script>
			</div>
		</form>
	</div>
	<script>
		if (rosunionGame == "1") {
			$(".ApplyButtoncss").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
		}
		InitWanNameListControl1("WAN_NAME", IsRouteWan);
		ParseBindTextByTagName(LogviewLgeDes, "div",    1);
		ParseBindTextByTagName(LogviewLgeDes, "input",  2);
	</script>
</body>
</html>
