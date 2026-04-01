<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var IsSupportIot = '<%HW_WEB_GetIotStatus();%>';
var APwebGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_NEW_AP);%>';
var backupfilelist = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.X_HW_AutoBackupRestore.RestoreFileLst);%>';
var IsSupportRb = '<%IsSupportRestore();%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

if( APwebGuideFlag == 1)
{
	RestoreLgeDes['s0a01'] = RestoreLgeDes['s0a01AP'];
}

function setAllDisable()
{
	setDisable('btnRestoreDftCfg',1);
}

function isSGP210W()
{
    if ((CfgModeWord.toUpperCase() == 'SYNCSGP210W') || (CfgModeWord.toUpperCase() == 'SONETSGP210W')) {
        return true;
    }
    return false;
}

function LoadFrame()
{ 
	if((IsSupportRb == "1") && (CfgModeWord.toUpperCase() != 'ROSUNION')){
		$('#RestoreBackup').css("display", "block");
	}
	
	if(backupfilelist == ""){
		setDisable('btnRestorefuncbybackup',1);
	}

	if (isSGP210W()) {
        setDisplay('RestoreBackup',0);
        setDisplay('btnRestorefuncbybackup',0);
    }
}

function RestoreDefaultCfg()
{
	if(1 == parseInt(IsSupportIot))
	{
		RestoreDefaultChoose();
	}
	else
	{
		if(ConfirmEx(RestoreLgeDes['s0a01']))
		{
			var Form = new webSubmitForm();
			setDisable('btnRestoreDftCfg', 1);
			Form.setAction('restoredefaultcfg.cgi?' + 'RequestFile=html/ssmp/ssmp/reset.asp');
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.submit();
		}
	}
}

function RestoreDefaultChoose()
{
	setDisable('btnRestoreDftCfg',1);
	$('#PageBaseMask').css("display", "block");	
	$('#MBIOTRestoreInfo').css("display", "block");
}

function ApplyRestore()
{
	$('#PageBaseMask').css("display", "none");	
	$('#MBIOTRestoreInfo').css("display", "none");
	var Form = new webSubmitForm();
	setDisable('btnRestoreDftCfg', 1);
	
	if(getCheckVal('EnableCheckBox') == 1)
	{
		Form.addParameter('ParaKey', "ResetIot");
	}
	
	Form.setAction('restoreIotdefcfg.cgi?&RequestFile=html/ssmp/ssmp/reset.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function CancelRestore()
{
	$('#PageBaseMask').css("display", "none");	
	$('#MBIOTRestoreInfo').css("display", "none");
	setDisable('btnRestoreDftCfg',0);
}

var g_FilelistArray = backupfilelist.split(",");
function WriteFileListOption(id)
{
	var select = document.getElementById(id);
	if ( backupfilelist != "" && g_FilelistArray != 'null')
	{
		var validIndex=1;
		for (var i in g_FilelistArray)
		{
			if ((g_FilelistArray[i] == 'null')
				|| (g_FilelistArray[i] == 'undefined'))
				continue;
				
			var opt = document.createElement('option');
			var htmlstr= validIndex + " " + g_FilelistArray[i];
			var html = document.createTextNode(htmlstr);
			opt.value = validIndex;
			opt.appendChild(html);
			select.appendChild(opt);
			validIndex++;
		}
		return true;
	}
	else
	{
		var opt = document.createElement('option');
		var html = document.createTextNode("not exsit backup file");
		opt.value = 'none';
		opt.appendChild(html);
		select.appendChild(opt);
		return false;
	}
}

function Restorebybackup(){
	var Title = RestoreLgeDes["s0a00"];
	if(ConfirmEx(Title))
	{
		var Form = new webSubmitForm();
		var restorefile = getSelectVal('backup_filelist');
		var restorepoint = restorefile;
		Form.addParameter('filenum', restorepoint);
		Form.setAction('restorebackup.cgi?&RequestFile=html/ssmp/restore/restore.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
		Form.submit();
	}
}

function ChooseFile(){
	var restorefile = getSelectVal('backup_filelist');
	if(restorefile == "none"){
		setDisable('btnRestorefuncbybackup',1);
	}else{
		setDisable('btnRestorefuncbybackup',0);
	}
}
</script>
</head>
<body class="mainbody pageBg" onLoad="LoadFrame();"> 
<div id="MBIOTRestoreInfo" class="MBIOTRestoreInfo">
<div class="title_spread"></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div id="iotAlarmInfo" class="iotResetHeadSpanCss"><span id="AlarmInfoSpan" BindText="s0a04"></span></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div id="CheckBoxArea" class="iotResetHeadSpanCss">
<input id="EnableCheckBox" name="EnableCheckBox" class="CheckBoxMiddle" value='1' type='checkbox'><span id="CheckInfoSpan" BindText="s0a05"></span>
</div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div class="title_spread"></div>
<div id="IotRestroeButtonCss" class="IotRestroeButtonCss">
<input type="button"  class="ApplyButtoncss buttonfloatleft buttonwidth_100px" id="ApplyRestore" onClick="ApplyRestore(this);" value="" BindText="s0a06"/>
<input type="button"  class="ApplyButtoncss buttonfloatright buttonwidth_100px" id="CancelRestore" onClick="CancelRestore();" value="" BindText="s0a07"/>
</div><!-- end of ChooseButton-->
</div>

<div>
<script language="JavaScript" type="text/javascript">
if( APwebGuideFlag == 1)
{
	HWCreatePageHeadInfo("restore", GetDescFormArrayById(RestoreLgeDes, "s0a03AP"), GetDescFormArrayById(RestoreLgeDes, "s0a02AP"), false);
}
else
{
	HWCreatePageHeadInfo("restore", GetDescFormArrayById(RestoreLgeDes, "s0a03"), GetDescFormArrayById(RestoreLgeDes, "s0a02"), false);
}

</script> 
<div class="title_spread"></div>
  <table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
      <td> 
      	<input  class = "ApplyButtoncss buttonwidth_150px_250px" name="btnRestoreDftCfg" id="btnRestoreDftCfg" type='button' onClick='RestoreDefaultCfg()'  value="" >
		<script type="text/javascript">
		if (rosunionGame == "1") {
			$("#btnRestoreDftCfg").removeClass("ApplyButtoncss").addClass("CancleButtonCss");
		}
		if( APwebGuideFlag == 1)
		{
			document.getElementsByName('btnRestoreDftCfg')[0].value = RestoreLgeDes['s0a03AP']; 
		}
		else
		{
			document.getElementsByName('btnRestoreDftCfg')[0].value = RestoreLgeDes['s0a03']; 
		}
		   
		</script>		
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
      </td> 
    </tr> 
  </table> 

<div class="title_spread"></div>
<div class="title_spread"></div>

<div id="RestoreBackup" style="display:none;">
<div class="func_title" BindText="s0aa0"></div>
<table class="tabal_noborder_bg" width="100%" cellpadding="0" cellspacing="1">
<tbody><tr>
<td class="table_title width_per30" BindText="s0aa1"></td>
<td class="table_right">
<select name="backup_filelist" id="backup_filelist" size="1" OnChange="ChooseFile(this);">
</select>
<script language="JavaScript" type="text/javascript">
WriteFileListOption("backup_filelist");
</script>
</td>
</table>
<div class="title_spread"></div>
<table width="100%" cellpadding="0" cellspacing="0"> 
<tr> 
  <td> 
	<input  class = "ApplyButtoncss buttonwidth_150px_300px" name="btnRestorefuncbybackup" id="btnRestorefuncbybackup" type='button' onClick='Restorebybackup()'  BindText="s0aa2" >
	<script type="text/javascript">
	</script>
  </td> 
</tr> 
</table> 
</div> 

<script>
ParseBindTextByTagName(RestoreLgeDes, "td",     1);
ParseBindTextByTagName(RestoreLgeDes, "input",  2);
ParseBindTextByTagName(RestoreLgeDes, "div",  1);
ParseBindTextByTagName(RestoreLgeDes, "span", 1);
</script>

</body>
</html>
