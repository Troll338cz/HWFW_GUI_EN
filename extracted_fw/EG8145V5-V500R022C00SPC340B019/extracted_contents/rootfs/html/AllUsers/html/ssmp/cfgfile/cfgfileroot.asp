<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" type="text/javascript">

var IsWebLoadConfigfile = "<%HW_WEB_GetFeatureSupport(FT_WEB_LOAD_CONFIGFILE);%>";
var initLanguage = '<%HW_WEB_GetSPEC(SSMP_SPEC_WEB_LANGUAGE.STRING);%>';
var languageSet = new Array();
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var reqFile = "html/ssmp/cfgfile/cfgfileroot.asp";

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

function GetLanguageDesc(Name)
{
    return CfgfileLgeDes[Name];
}

var CfgMode ='<%HW_WEB_GetCfgMode();%>';

function isSGP210W()
{
    if ((CfgMode.toUpperCase() == 'SYNCSGP210W') || (CfgMode.toUpperCase() == 'SONETSGP210W')) {
        return true;
    }
    return false;
}

function isMongolia()
{
    if ((curUserType == 1) && ((CfgMode.toUpperCase() == "MONGOLIA") || (CfgMode.toUpperCase() == "MONGOLIA2") )) {
        return true;
    }
    return false;
}

function delayTime(saveflag)
{
    if (saveflag == 1) {
        saveflag = 0;
        top.SaveDataFlag = 0;
        AlertEx(GetLanguageDesc("s0701"));
    }
}

function LoadFrame() 
{
    if ( 'NOS' != CfgMode.toUpperCase())
    {
        document.getElementById('SaveCfgInfo').style.display="";
    }
    setTimeout('delayTime(top.SaveDataFlag)', 30);

    if (isSGP210W()) {
        setDisplay('saveConfig', 0);
        setDisplay('downloadConfig', 1);
        setDisplay('uploadConfig', 1);
    }

    if (isMongolia()) {
        setDisplay('btnsaveandreboot', 0);
    }
}

function fchange()
{
    var ffile = document.getElementById("f_file");
    var tfile = document.getElementById("t_file");
    ffile.value = tfile.value;

    var buttonstart = document.getElementById('btnSubmit');
    buttonstart.focus();
    return ;
}

function StartFileOpt()
{
    XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
}

function Check_SWM_Status()
{
    var xmlHttp = null;

    if(window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    } else if(window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlHttp.open("GET", "/html/get_swm_status.asp", false);
    xmlHttp.send(null);

    var swm_status = xmlHttp.responseText;
    if (swm_status.substr(1, 1) == "0") {
        return true;
    } else {
        return false;
    }
}

function VerifyFile(FileName)
{
    var filePath = document.getElementsByName(FileName)[0].value;

    if (filePath.length == 0) {
        AlertEx(GetLanguageDesc("s0702"));
        return false;
    }

    if (filePath.length > 128) {
        AlertEx(GetLanguageDesc("s0703"));
        return false;
    }

    return true;
}

function uploadSetting() {
    if (IsWebLoadConfigfile == "0") {
        return;
    }
    var uploadForm = document.getElementById("fr_uploadSetting");

    if (Check_SWM_Status() == false) {
        AlertEx(GetLanguageDesc("s0905"));
        return;
    }
    if (VerifyFile('browse') == false) {
        return;
    }

    if(!ConfirmEx(GetLanguageDesc("s0711")))
    {
        return;
    }
    top.previousPage = '/html/ssmp/reset/reset.asp';
    setDisable('btnSubmit', 1);
    uploadForm.submit();
    setDisable('browse', 1);
    setDisable('btnBrowse', 1);

}

function backupSetting()
{
    if (IsWebLoadConfigfile == "0") {
        return;
    }
    if (IsSupportPrompt() == true) {
        if (ConfirmEx(GetLanguageDesc("ss0a0b")) == false) {
            return;
        }
    }

    XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
    var Form = new webSubmitForm();
    Form.setAction('cfgfiledown.cgi?&RequestFile=' + reqFile);
    Form.addParameter('x.X_HW_Token', getValue('onttokenBackup'));
    Form.submit();
}

function SaveSetting() {
	var Form = new webSubmitForm();
	Form.setMethod('POST');
	top.SaveDataFlag = 1;
	Form.setAction('set.cgi?' + 'x=InternetGatewayDevice.X_HW_DEBUG.SSP.DBSave' + '&RequestFile=html/ssmp/cfgfile/cfgfileroot.asp');
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.submit();
}

function SaveandReboot()
{
	if(ConfirmEx(GetLanguageDesc("s0706")))
	{
		setDisable('btnsaveandreboot', 1);
		var Form = new webSubmitForm();		
		Form.setAction('set.cgi?' + 'x=InternetGatewayDevice.X_HW_DEBUG.SSP.DBSave&y=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard' + '&RequestFile=html/ssmp/cfgfile/cfgfileroot.asp');
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));		
		Form.submit();
	}
}            
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();"> 
<div id="saveConfig"> 
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("cfgfileroot", GetDescFormArrayById(CfgfileLgeDes, "s0102"), GetDescFormArrayById(CfgfileLgeDes, "s0707"), false);
</script>
<div class="title_spread"></div> 
  <table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> 
        <td id="SaveCfgInfo" style="display:none;"> <input class="ApplyButtoncss buttonwidth_150px" name="saveconfigbutton" id="saveconfigbutton" type='button' onClick='SaveSetting()' BindText="s0709"> </td> 
        <td>
        <script language="JavaScript" type="text/javascript">
            var curClass = "ApplyButtoncss buttonwidth_150px"
            if (curLanguage == 'russian') {
                curClass = "ApplyButtoncss buttonwidth_240px";
            } else if (curLanguage == 'portuguese') {
                curClass = "ApplyButtoncss buttonwidth_150px_250px";
            }
            document.write('<input class="' + curClass + '" name="btnsaveandreboot" id="btnsaveandreboot" type="button" onClick="SaveandReboot()" BindText="s070a">');
        </script>
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        </td> 
    </tr> 
  </table> 
</div>

<div class="func_spread"></div>
    <div id="downloadConfig" style="display:none">
        <div id="cfgfileroot_content" class="PageTitle_content" BindText="s0707"></div>
        <div class="func_title" BindText="s070c"></div>
        <table width="100%" cellpadding="0" cellspacing="0" class="table_button">
            <tr>
            <script language="JavaScript" type="text/javascript">
                var curClass = "ApplyButtoncss buttonwidth_150px_250px"
                document.write('<td><input class="' + curClass + '" name="downloadconfigbutton" id="downloadconfigbutton" type="button" onClick="backupSetting()" BindText="s070c"></td>');
            </script>
            <input type="hidden" name="onttokenBackup" id="hwonttokenBackup" value="<%HW_WEB_GetToken();%>">
            </tr>
        </table>
    </div>
    <div class="func_spread"></div>
    <div id="uploadConfig" style="display:none">
        <form action="cfgfileupload.cgi?RequestFile=html/ssmp/reset/reset.asp&FileType=config" method="post" enctype="multipart/form-data" name="fr_uploadSetting" id="fr_uploadSetting">
            <div class="func_title" BindText="s0710"></div>
            <table width="100%" cellpadding="0" cellspacing="0" class="table_button">
                <tr>
                    <td class="filetitle" BindText="s070e"></td>
                    <td>
                        <div class="filewrap">
                            <div class="fileupload">
                                <input type="text"   id="f_file"     autocomplete="off" readonly="readonly" />
                                <input type="file"   id="t_file"     name="browse" size="1"  onblur="StartFileOpt();" onchange="fchange();" />
                                <input type="button" id="btnBrowse"  class="CancleButtonCss filebuttonwidth_100px" BindText="s070f" />
                            </div>
                        </div>
                    </td>
                    <td>
                    <script language="JavaScript" type="text/javascript">
                        var curClass = "CancleButtonCss filebuttonwidth_150px_250px"
                        document.write('<input type="button" id="btnSubmit" name="btnSubmit" class="' + curClass + '" onclick="uploadSetting();" BindText="s0710" />');
                    </script>
                    </td>
                </tr>
            </table>
        </form>
    </div>

<script>
	ParseBindTextByTagName(CfgfileLgeDes, "div", 1);
	ParseBindTextByTagName(CfgfileLgeDes, "td",     1);
	ParseBindTextByTagName(CfgfileLgeDes, "input",  2);
</script>

</body>
</html>
