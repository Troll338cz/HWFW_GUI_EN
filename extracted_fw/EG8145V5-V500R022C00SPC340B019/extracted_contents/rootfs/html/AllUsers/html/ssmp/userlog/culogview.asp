<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" type='text/css' href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'>
<link rel="stylesheet" type='text/css' href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
function stSyslogCfg(domain, Enable, Level)
{
	this.domain = domain;
	this.Enable = Enable;
	this.Level  = Level;
}

var temp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo.X_HW_Syslog, Enable|Level, stSyslogCfg);%>;
var SyslogCfg = temp[0];

var LogLevelInfo = ["[Emergency", "[Alert", "[Critical", "[Error", "[Warning", "[Notice", "[Informational", "[Debug"];
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var SonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>'; 

function LoadFrame()
{
	setSelect('Level', SyslogCfg.Level);
	top.SaveLogContent = document.getElementById("logarea").value;
	RefreshByLogType();
}

function CheckLogLevel( LineLogText, LookLogLevel )
{
	var LevelInfoLength = LogLevelInfo.length;
	var i = parseInt(LookLogLevel,10) + 1;

	for (; i < LevelInfoLength ; i++)
	{
		if ( -1 != LineLogText.indexOf(LogLevelInfo[i]) )
		{
			return false;
		}
	}

	return true;
}

function RefreshSubmit()
{
	var OldLogText = top.SaveLogContent;
	setSelect('Level', getSelectVal('Level'));
	ShowNewLogContent(OldLogText);
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

function RefreshByLogType()
{
	var OldLogText = top.SaveLogContent;
	var LookLogType = getSelectVal('LogType');
	setSelect('LogType', LookLogType);
	var LookLevel = getSelectVal('Level');

	var ResultLog = OldLogText.split("\n");
	var NewShowLog = "";
	var blankLineFlag = false;

	LookLogType = GetLogTypeDes(LookLogType);
	for (var i = 0; i < ResultLog.length -1; i++ )
	{
		if (false == blankLineFlag)
		{
			NewShowLog += ResultLog[i];
			NewShowLog += "\n";
			if(ResultLog[i] == "\r" || ResultLog[i]== "")
			{
				blankLineFlag = true;
			}
		}
		else
		{
			if (ResultLog[i] != "\r\n" || ResultLog[i] != "" ||  ResultLog[i] != "\0")
			{
				if("All" == LookLogType)
				{
					if (true == CheckLogLevel(ResultLog[i], LookLevel))
					{
						NewShowLog += ResultLog[i];
						NewShowLog += "\n";
					}
				}
				else
				{
					if (-1 != ResultLog[i].indexOf(LookLogType) && true == CheckLogLevel(ResultLog[i], LookLevel))
					{
						NewShowLog += ResultLog[i];
						NewShowLog += "\n";
					}
				}
			}
		}
	}

	document.getElementById("logarea").value = NewShowLog;
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
<div id="logconfig">
	<script language="JavaScript" type="text/javascript">
		HWCreatePageHeadInfo("logview", GetDescFormArrayById(LogviewLgeDes, "s0101"), GetDescFormArrayById(LogviewLgeDes, "s0c01"), false);
	</script>
	<div class="title_spread"></div>
	<form id="LogEnableCfgForm"  name="LogEnableCfgForm">
		<table id="LogEnableCfgPanel" width="100%" border="0" cellpadding="0" cellspacing="1">
			<li id="Level"   RealType="DropDownList" DescRef="s0c02" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.Level"
				InitValue="[{TextRef:'s0b05',Value:'0'},{TextRef:'s0b06',Value:'1'},{TextRef:'s0b07',Value:'2'},{TextRef:'s0b08',Value:'3'},{TextRef:'s0b09',Value:'4'},{TextRef:'s0b0a',Value:'5'},{TextRef:'s0b0b',Value:'6'},{TextRef:'s0b0c',Value:'7'}]" ClickFuncApp="onChange=RefreshByLogType"/>
			<li id="LogType" RealType="DropDownList" DescRef="s0c03" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Empty"
				InitValue="[{TextRef:'s0b18',Value:'All'},{TextRef:'s0b15',Value:'0'},{TextRef:'s0b16',Value:'1'},{TextRef:'s0b17',Value:'2'}]" ClickFuncApp="onChange=RefreshByLogType"/>
		</table>
		<script>
			var LogEnableCfgFormList = new Array();
			LogEnableCfgFormList = HWGetLiIdListByForm("LogEnableCfgForm", null);
			var TableClass = new stTableClass("width_per20", "width_per80");
			HWParsePageControlByID("LogEnableCfgForm", TableClass, LogviewLgeDes, null);

			var LogEnableArray = new Array();

			LogEnableArray["Level"] = SyslogCfg.Level;
			HWSetTableByLiIdList(LogEnableCfgFormList, LogEnableArray, null);
		</script>
	</form>
	<div class="func_spread"></div>
	<div class="func_title" BindText="s1613"></div><!-- function 2: log view -->
	<div id="logviews" align="center">
		<textarea name="logarea" id="logarea" style="width:100%;height:330px;margin-bottom:20px;" wrap="off" readonly="readonly"></textarea>
		<script type="text/javascript">			
		    document.getElementById("logarea").value='<%HW_WEB_GetLogInfo();%>';
		</script>
	</div>
	<script>
		ParseBindTextByTagName(LogviewLgeDes, "div",   1);
		ParseBindTextByTagName(LogviewLgeDes, "input", 2);
	</script>
</body>
</html>
